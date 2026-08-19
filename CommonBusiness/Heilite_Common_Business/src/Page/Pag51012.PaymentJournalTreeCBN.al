page 51012 "Payment Journal Tree CBN"
{
    // version HEI.47

    // DITW15.00.00.37 DDR 27/01/2010 issue 1036 Added field "Contract Group Code"
    // DITW15.00.00.37 DDR 28/01/2010 issue 879 Added field "Building No."
    //                     10/05/2010 issue 857 Added field "DIT Sub-Contract Type"
    // DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added fields "Service Contract Type","Service Contract No."
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "item charge type"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 AT  17/12/2013 DIT-770 #163 :  Added Posting Group
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.05 WSA 08/08/2014 DIT-770 #761 : Added Action Apply Invoice List
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // 
    // HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay—• Bank account for payment
    //   # New field Vendor Bank Account
    // HEI.02 PTPGAP029 IBM ISYED01 29.07.2017 Items included in payment proposal
    //   # Added functionality onDelete trigger to update vendor leddger entry when lines are deleted from Gen. jrnl line
    // HEI.03 PTPGAP068 IBM COSTES02 18.08.2017 Payment reconciliation grouping/archiving
    //   # New page created based on standard Payment Journal page
    // HEI.04 PTPGAP068 IBM COSTES02 03.10.2017 Payment reconciliation grouping/archiving
    //   # Calculate Total Balance
    // HEI.05 Defect 626 IBM.HORTOC01 18.10.2017
    //   # Add modify permission on VLE
    // HEI.06 FDD-PTPGAP072 IBM NASTAA02 22.02.2017 # Cashier Order Creation
    //   # New Page Action created "Print Cashier Order"
    //   # Report "Cashier Order" should be print just for "Parent" entries
    // 
    // HEI.07 PTPGAP083 IBM NASTAA02 05.03.2018 # Mark Reversed Rejected Payments
    //   # Added "Due Date" Field
    //   # Added "Reversed" Field
    // HEI.08 PTPGAP077 - IBM HORTOC01 23.03.2018
    //   # new function to delete the batch
    // HEI.09 FDD PTPGAP078 IBM POSTOI01 18.05.2018
    //   # show new field 50043  Heineken Bank Account CodeCode20
    //   # show new field HNK Check No
    //   # make Bank Payment Type property Editable=False
    //   # PrintCheck OnAction -add new line
    //   # modify Void Check and Void All Checks actions
    //   # new page action Print Check Batch
    //   # modify Print Check and Print Check Batch
    // HEI.10 defect #2221 IBM POSTOI01 04.06.2018
    //   # modify Delete Batch actiuon
    // HEI.11 Defect #2488 IBM NASTAA02 07.08.2018 # Error message after posting payment
    //   # In order to avoid the error which appears after posting the payment the ShowAsTree Property was changes to 'No'
    //   # User will not be able to collapse the parent line, it will be always expanded
    // HEI.12 IBM POSTOI01 fix issue
    //   # reported issue that page missing actions Expand All and Collapse All
    //   # go to Page Designer-> Repeater Group-> Properties> change ShowAsTree=Yes
    // HEI.13 FDD PTPGAP02 check bahama's.
    //   # Added code to hide Print Check Batch on the page only for Bahamas
    // HEI.14 FDD BA-PTPGAP03 IBM NASTAA02 04.02.2019 # Digital Checks Printout
    //   # New conditions added for "Print Check Batch"
    //   # Check Report should be run just once with "Print Check Batch" Action
    // HEI.15 CHG2011406 IBM.AB 12.04.2019
    //   # Void Check functionality fixed
    // HEI.16 V1.05 HT84 IBM POENAB02 01.04.2019
    //   # Code added in ExportPaymentsToFile - OnAction
    // HEI.17 FDD-HT453 IBM GAVANM01 04.06.2019
    //   # Code added to filter the journal lines on Print Check
    //   # Code modified for Print Check Batch
    //   # Code added to select the Check report from Bank Account
    //   # New local variable HNKBankAcc, in PrintCheck - OnAction()
    // HEI.18 CHG2000927 IBM ISYED01 remittance advice
    //   #added code for sending email for remittance advide
    // HEI.19 FDD-HT649 CHG2022329 IBM GAVANM01 09.08.2019
    //   # Code added to filter the journal lines on Print Check
    // HEI.20 FDD-HT594 IBM NASTAA02 07.10.2019 # La Reunion FA Requirements Vendor
    //   # Added Fields: "Fixed Asset Acquisition" and "IBAN"
    // HEI.22 FDD-HT649 CHG2022329 IBM GAVANM01 25.11.2019
    //   # Code added to select the Check report from Bank Account
    // HEI.24 Defect#4962 BULIMC01 IBM 23/12/2019
    //    #code added to "Print Check Batch" action to filter the lines
    //    #code changes for Void Check action
    // HEI.25 FDD-HT971 IBM POSTOI01 15.01.2020
    //   # show field WHT Business Posting Group
    //   # show field WHT Product Posting Group
    //   # show field WHT Amount
    //   # show field WHT Amount LCY
    // HEI.26 CHG2040699 IBM POSTOI01 14.01.2020 Ivory Coast - WHT at the moment of payment
    //   # new page action SuggestVendorPaymentsWHT,
    //   # new local variables
    //     SuggestVendorPaymentsReportSuggest Vendor Payments
    //     SuggestPaymentVendorsCodeUnitSuggest Vendor Payments
    //     GenJournalBatchRecordGen. Journal Batch
    //     GenJournalLine2RecordGen. Journal Line
    //     ApprovalsMgmtCodeUnitApprovals Mgmt.
    //   # modify Suggest Vendor Payments , new local variable GenLedgerSetup
    // HEI.27 CHG2037399 IBM NANDIS01 17.03.2020 - Cheque Printing
    //   # Code added under Print Check Batch button to take the report set under Bank Account Card AND line no not to be filtered
    // HEI.28 CHG2059040 IBM BULIMC01 27/04/2020 #create new action: "Export Bank to File"
    // HEI.23 CHG2039178 IBM PANDES01 27.12.2019
    //  # Code added and (Removed hard code values) for check print issue
    // HEI.31 CHG2052196 IBM.PANDES01 08.06.2020
    //   # Added Code for check ledger entry workflow.
    // HEI.32 CHG2086827 IBM POENAB02 Bank Connectivity DRC —? complementing BRD HT84
    //   # New field in Repeater group: "Amount LCY DRC" (after Amount)
    //   # Code added in OnAfterGetRecord
    //   # Code added in ExportBankToFile - OnAction
    // HEI.33 CHG2019432 IBM SHANKJ03  03.23.2021
    //   # CHanges in Post action Button
    // HEI.36 CHG2119688 IBM POENAB02 31.08.2021 HB2428 Panama CITI - bank connectivity payment file
    //   # Code added in ExportPaymentsToFile - OnAction
    // HEI.37 CHG2190168 IBM POENAB02 25.01.2023 HB2330 BKT-EFT Citi bank payment file update
    //   # Code added in ExportPaymentsToFile - OnAction, OnAfterGetRecord, OnOpenPage
    //   # Field "Value of Payment Method" added to the repeater group
    //   # 25.01.2023 Old CHG CHG2117475 was replaced with CHG2190168. Initial change was on 20.08.2021.
    // HEI.39 CHG2135905 IBM BHATTA09 07.01.2022 # HB2663 Payment remittance advice Æ French translation
    //   # Condition added for French version of the Remittance Advice
    // HEI.40 CHG2095333 IBM SRIVAS07 28.12.2022 HB1987- REWORK- SECURE PAYMENT JOURNAL TREE PROPOSAL
    //   # Commented the Code modified in OnOpenPage trigger to open the Payment Journal Tree as per the Page ID seleceted in the Gen. Jnl. Template List
    // HEI.41 CHG2181582 IBM SRIVAS07 16.03.2023 - Mozambique bank connectivity -  outgoing payments (Standard Bank - domestic)
    //   # # Code added in "Export Payments to File" - OnAction
    // HEI.42 CHG2189683 IBM POENAB02 16.03.2023 HB2183 / HB3090 Ethiopia - bank connectivity payment file
    //   # Code added in "Export Payments to File" - OnAction
    // HEI.43 CHG2189683 IBM POENAB02 29.03.2023 HB2183 / HB3090 Ethiopia - bank connectivity payment file
    //   # Commented HEI.42 - code added in "Export Payments to File" - OnAction
    //   # The logic for payment journal approval was moved from Ethiopia CHG to Mozambique CHG and it will be available for every OpCo
    // HEI.44 CHG2181582 IBM SRIVAS07 29.03.2023 - Mozambique bank connectivity -  outgoing payments (Standard Bank - domestic)
    //   # # Code added in "Export Payments to File" - OnAction
    // HEI.45 CHG2244079 VERMAA03 IBM 21.06.2024 Remittance advice for Panama - Spanish Translation
    //   # Code added for Spanish Translation of Remittance Advice - Post
    // HEI.46 CHG2244079 VERMAA03 IBM 18.07.2024 Remittance advice for Panama
    //   # Code added to pass posting date in Post - OnAction
    // HEI.47 CHG2244079 SRIVAS07 IBM 08.08.2024 #Remittance advice for Panama
    //   # Changes the Object ID and deleted one report - 50562

    // BC Upgrade KUMARS145 Nav ID Page 50092 "Payment Journal Tree"

    // BC Upgrade PATELS08 >>
    // # Blocked attribute '[InDataSet]' because it is deprecated and exposure of page variables handled automatically in BC.
    // BC Upgrade PATELS08 <<
    // BC Upgrade BHARDA11 >>
    // Move ExportPaymentsToFile to interface extension 
    // Add Expand All and Collab All Actions an some layout changes
    // BC Upgrade BHARAD11 <<

    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Payment Journal Tree';
    UsageCategory = Tasks;
    DataCaptionExpression = Rec.DataCaption();
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = Worksheet;
    Permissions = TableData "Vendor Ledger Entry" = rm;
    PromotedActionCategories = 'New,Process,Report,Bank,Prepare,Approve';
    SaveValues = true;
    SourceTable = "Gen. Journal Line";

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Batch Name';
                Lookup = true;
                ToolTip = 'Specifies the batch name on the payment journal.';
                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SaveRecord();
                    GenJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.Update(false);
                end;

                trigger OnValidate();
                begin
                    GenJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali();
                end;
            }
            field("Total No. Of Parent Lines"; Rec."Total No. Of Parent Lines FND")
            {
                ApplicationArea = all;
                ToolTip = 'Total No. Of Parent Lines';
            }
            field("Total No. Of Children Lines"; Rec."Total No. Of Child Lines FND")
            {
                ApplicationArea = all;
                ToolTip = 'Total No. Of Children Lines';
            }
            repeater(Control1)
            {
                Editable = true;
                IndentationColumn = Rec."Tree Level FND";
                IndentationControls = TotalExportedAmount;
                ShowAsTree = true;
                field("Skip WHT"; Rec."Skip WHT FND")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    ToolTip = 'Skip WHT';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies the date on the document that provides the basis for the entry on the journal line.';
                    Visible = false;
                }
                field("Execution Date"; Rec."Execution Date FND")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    ToolTip = 'Execution Date';
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies the type of document that the entry on the journal line is.';
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies a document number for the journal line.';
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the incoming document that this general journal line is created for.';
                    Visible = false;
                    trigger OnAssistEdit();
                    begin
                        if Rec."Incoming Document Entry No." > 0 then
                            Hyperlink(Rec.GetIncomingDocumentURL());
                    end;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                }
                field("Applies-to Ext. Doc. No."; Rec."Applies-to Ext. Doc. No.")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the external document number that will be exported in the payment file.';
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of account that the entry on the journal line will be posted to.';
                    trigger OnValidate();
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                    end;
                }
                field("Account No."; Rec."Account No.")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies the account number that the entry on the journal line will be posted to.';
                    trigger OnValidate();
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Vendor Name"; Rec."Vendor Name FND")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = all;
                    ToolTip = 'Vendor Name';
                }
                field("<Account No.>"; Rec."Vendor Bank Account FND")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = all;
                    ToolTip = 'Account No.';
                }
                field("Vendor Bank Acc. Name"; Rec."Vendor Bank Acc. Name FND")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = all;
                    ToolTip = 'Vendor Bank Acc. Name';
                }
                field("Vendor Bank Acc. Branch No."; Rec."Vendor Bank Acc.BranchNo. FND")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = all;
                    ToolTip = 'Vendor Bank Acc. Branch No.';
                }
                field("Vendor Bank Acc. No."; Rec."Vendor Bank Acc. No. FND")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = all;
                    ToolTip = 'Vendor Bank Acc. No.';
                }
                field("Vandor Bank Acc. Swift Code"; Rec."Vandor Bank Acc. SwiftCode FND")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = all;
                    ToolTip = 'Vandor Bank Acc. Swift Code';
                }
                field("HNK Bank Account"; Rec."HNK Bank Account FND")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = all;
                    ToolTip = 'HNK Bank Account';
                }
                field("HNK Check No."; Rec."HNK Check No. FND")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    ToolTip = 'HNK Check No.';
                }
                field("Recipient Bank Account"; Rec."Recipient Bank Account")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the bank account that the amount will be transferred to after it has been exported from the payment journal.';
                }
                field("Message to Recipient"; Rec."Message to Recipient")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the message exported to the payment file when you use the Export Payments to File function in the Payment Journal window.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies a description of the entry. The field is automatically filled when the Account No. field is filled.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the salesperson or purchaser who is linked to the journal line.';
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the number of the campaign the journal line is linked to.';
                    Visible = false;
                }
                // BC Upgrade KUMARS145 Fields dependent on Drinkit Commented.....>>
                // field("Contract Type"; Rec."Contract Type")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Service Contract No."; Rec."Service Contract No.")
                // {
                //     Visible = false;
                // }
                // field("Financial Contract No."; Rec."Financial Contract No.")
                // {
                //     Visible = false;
                // }
                // BC Upgrade KUMARS145 Fields dependent on Drinkit Commented.....<<
                field("Posting Group"; Rec."Posting Group")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ToolTip = 'Posting Group';
                    Visible = false;
                    ApplicationArea = all;
                }
                // BC Upgrade KUMARS145 Fields dependent on Drinkit Commented.....>>
                // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
                // {
                //     Visible = false;
                // }
                // field("Contract Group Code"; Rec."Contract Group Code")
                // {
                //     Visible = false;
                // }
                // field("Building No."; Rec."Building No.")
                // {
                //     Visible = false;
                // }
                // field("Item Charge Type"; Rec."Item Charge Type")
                // {
                //     Visible = false;
                // }
                // BC Upgrade KUMARS145 Fields dependent on Drinkit Commented.....<<
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = Suite;
                    AssistEdit = true;
                    ToolTip = 'Specifies the code of the currency for the amounts on the journal line.';
                    trigger OnAssistEdit();
                    begin
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        if ChangeExchangeRate.RunModal() = Action::OK then
                            Rec.Validate(Rec."Currency Factor", ChangeExchangeRate.GetParameter());
                        Clear(ChangeExchangeRate);
                    end;
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the general posting type that will be used when you post the entry on this journal line.';
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the code of the general business posting group that will be used when you post the entry on the journal line.';
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the code of the general product posting group that will be used when you post the entry on the journal line.';
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the VAT business posting group code that will be used when you post the entry on the journal line.';
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.';
                    Visible = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the payment method that was used to make the payment that resulted in the entry.';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment of the purchase invoice.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vendor who sent the purchase invoice.';
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    Style = Attention;
                    StyleExpr = HasPmtFileErr;
                    ToolTip = 'Specifies the total amount (including VAT) that the journal line consists of.';
                }
                field("Amount LCY DRC"; Rec."Amount LCY DRC FND")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    Enabled = ShowAmountLCYDRC;
                    Visible = ShowAmountLCYDRC;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a debit amount. The amount must be entered in the currency represented by the currency code on the line.';
                    Visible = false;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a credit amount. The amount must be entered in the currency represented by the currency code on the line.';
                    Visible = false;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the amount of VAT included in the total amount.';
                    Visible = false;
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the difference between the calculate VAT amount and the VAT amount that you have entered manually.';
                    Visible = false;
                }
                field("Bal. VAT Amount"; Rec."Bal. VAT Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the amount of Bal. VAT included in the total amount.';
                    Visible = false;
                }
                field("Bal. VAT Difference"; Rec."Bal. VAT Difference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the difference between the calculate VAT amount and the VAT amount that you have entered manually.';
                    Visible = false;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code for the balancing account type that should be used in this journal line.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the general ledger, customer, vendor, or bank account to which a balancing entry for the journal line will posted (for example, a cash account for cash purchases).';
                    trigger OnValidate();
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Bal. Gen. Posting Type"; Rec."Bal. Gen. Posting Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the general posting type that will be used when you post the entry on the journal line.';
                    Visible = false;
                }
                field("Bal. Gen. Bus. Posting Group"; Rec."Bal. Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the code of the general business posting group that will be used when you post the entry on the journal line.';
                    Visible = false;
                }
                field("Bal. Gen. Prod. Posting Group"; Rec."Bal. Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the code of the general product posting group that will be used when you post the entry on the journal line.';
                    Visible = false;
                }
                field("Bal. VAT Bus. Posting Group"; Rec."Bal. VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the code of the VAT business posting group that will be used when you post the entry on the journal line.';
                    Visible = false;
                }
                field("Bal. VAT Prod. Posting Group"; Rec."Bal. VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2.';
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 3.';
                    ApplicationArea = all;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code Where("Global Dimension No." = const(3), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    Visible = false;
                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 4.';
                    ApplicationArea = all;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code Where("Global Dimension No." = const(4), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    Visible = false;
                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 5.';
                    ApplicationArea = all;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code Where("Global Dimension No." = const(5), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    Visible = false;
                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 6.';
                    ApplicationArea = all;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code Where("Global Dimension No." = const(6), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    Visible = false;
                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 7.';
                    ApplicationArea = all;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code Where("Global Dimension No." = const(7), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    Visible = false;
                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 8.';
                    ApplicationArea = all;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code Where("Global Dimension No." = const(8), "Dimension Value Type" = const(Standard), Blocked = const(false));
                    Visible = false;
                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Applied (Yes/No)"; Rec.IsApplied())
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    Caption = 'Applied (Yes/No)';
                    ToolTip = 'Specifies if the payment has been applied.';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the entries that will be applied to by the journal line if you use the Apply Entries facility.';
                    Visible = false;
                }
                field(GetAppliesToDocDueDate; Rec.GetAppliesToDocDueDate())
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    Caption = 'Applies-to Doc. Due Date';
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the due date from the Applies-to Doc. on the journal line.';
                }
                field("Bank Payment Type"; Rec."Bank Payment Type")
                {

                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the code for the payment type to be used for the entry on the payment journal line.';
                }
                field("Check Printed"; Rec."Check Printed")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies whether a check has been printed for the amount on the payment journal line.';
                    Visible = false;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the reason code that has been entered on the journal lines.';
                    Visible = false;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies a comment related to registering a payment.';
                    Visible = false;
                }
                field("Exported to Payment File"; Rec."Exported to Payment File")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the payment journal line was exported to a payment file.';
                }
                field(TotalExportedAmount; Rec.TotalExportedAmount())
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Exported Amount';
                    DrillDown = true;
                    ToolTip = 'Specifies the amount for the payment journal line that has been exported to payment files that are not canceled.';
                    trigger OnDrillDown();
                    begin
                        Rec.DrillDownExportedAmount();
                    end;
                }
                field("Has Payment Export Error"; Rec."Has Payment Export Error")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that an error occurred when you used the Export Payments to File function in the Payment Journal window.';
                }
                field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Vendor Bank Account.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ToolTip = 'Specifies the Due Date.';
                    ApplicationArea = all;
                    Description = 'HEI.07';
                }
                field("Payment File Created"; Rec."Payment File Created FND")
                {
                    ToolTip = 'Specifies the Payment File Created.';
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Reversed; Rec."Reversed FND")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ToolTip = 'Specifies the Reversed.';
                    Description = 'HEI.07';
                }
                field("Customer/Vendor Bank"; Rec."Customer/Vendor Bank FND")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Customer/Vendor Bank.';
                }
                field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Fixed Asset Acquisition.';
                }
                field(IBAN; Rec."IBAN FND")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the IBAN.';
                }
                field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the WHT Business Posting Group.';
                }
                field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
                {
                    Editable = true; // BC Upgrade BHARDA11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the WHT Product Posting Group.';
                }
                field("WHT Amount"; Rec."WHT Amount FND")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the WHT Amount.';
                }
                field("WHT Amount (LCY)"; Rec."WHT Amount (LCY) FND")
                {
                    Editable = false; // BC Upgrade BHARAD11
                    ApplicationArea = all;
                    ToolTip = 'Specifies the WHT Amount (LCY).';
                }
            }
            group(Control24)
            {
                ShowCaption = false;
                fixed(Control80)
                {
                    group(Control82)
                    {
                        ShowCaption = false;
                        field(OverdueWarningText; OverdueWarningText)
                        {
                            Caption = 'OverdueWarningText';
                            ApplicationArea = Basic, Suite;
                            Style = Unfavorable;
                            StyleExpr = true;
                            ToolTip = 'Specifies the text that is displayed for overdue payments.';
                        }
                    }
                }
                fixed(Control1903561801)
                {
                    group("Account Name")
                    {
                        Caption = 'Account Name';
                        field(AccName; AccName)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account';
                            Editable = false;
                            ShowCaption = false;
                            ToolTip = 'Specifies the name of the account.';
                        }
                    }
                    group("Bal. Account Name")
                    {
                        Caption = 'Bal. Account Name';
                        field(BalAccName; BalAccName)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bal. Account Name';
                            Editable = false;
                            ToolTip = 'Specifies the name of the balancing account that has been entered on the journal line.';
                        }
                    }
                    group(Control1900545401)
                    {
                        Caption = 'Balance';
                        field(Balance; Balance + Rec."Balance (LCY)" - xRec."Balance (LCY)")
                        {
                            ApplicationArea = All;
                            AutoFormatType = 1;
                            Caption = 'Balance';
                            Editable = false;
                            ToolTip = 'Specifies the balance that has accumulated in the payment journal on the line where the cursor is.';
                            Visible = BalanceVisible;
                        }
                    }
                    group("Total Balance")
                    {
                        Caption = 'Total Balance';
                        field(TotalBalance; TotalBalance + Rec."Balance (LCY)" - xRec."Balance (LCY)")
                        {
                            ApplicationArea = All;
                            AutoFormatType = 1;
                            Caption = 'Total Balance';
                            Editable = false;
                            ToolTip = 'Specifies the total balance in the payment journal.';
                            Visible = TotalBalanceVisible;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
            }
            part("Payment File Errors"; "Payment Journal Errors Part")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment File Errors';
                SubPageLink = "Journal Template Name" = field("Journal Template Name"),
                              "Journal Batch Name" = field("Journal Batch Name"),
                              "Journal Line No." = field("Line No.");
            }
            part(Control1900919607; "Dimension Set Entries FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "Dimension Set ID" = field("Dimension Set ID");
                Visible = false;
            }
            part(WorkflowStatusBatch; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Caption = 'Batch Workflows';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatusOnBatch;
            }
            part(WorkflowStatusLine; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Caption = 'Line Workflows';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatusOnLine;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = all;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Manage)
            {
                Caption = 'Manage';

                action(ExpandAll)
                {
                    ApplicationArea = All;
                    Caption = 'Expand All';
                    Image = ExpandAll;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Expand all lines.';
                    trigger OnAction()
                    begin
                        Rec.SetRange("Journal Template Name", Rec."Journal Template Name");
                        Rec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        Rec.SetRange("Tree Level FND");
                        CurrPage.Update(false);
                    end;
                }

                action(CollapseAll)
                {
                    ApplicationArea = All;
                    Caption = 'Collapse All';
                    Image = CollapseAll;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Collapse all lines.';
                    trigger OnAction()
                    begin
                        Rec.SetRange("Journal Template Name", Rec."Journal Template Name");
                        Rec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        Rec.SetRange("Tree Level FND", 0);
                        CurrPage.Update(false);
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                    trigger OnAction();
                    begin
                        Rec.ShowDimensions();
                        CurrPage.SaveRecord();
                    end;
                }
                action(IncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document" = R;
                    ApplicationArea = All;
                    Caption = 'Incoming Document';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    Scope = Repeater;
                    ToolTip = 'View or create an incoming document record that is linked to the entry or document.';
                    trigger OnAction();
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        Rec.Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RecordId));
                    end;
                }
            }
            group("A&ccount")
            {
                Caption = 'A&ccount';
                Image = ChartOfAccounts;
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = CodeUnit "Gen. Jnl.-Show Card";
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or change detailed information about the record that is being processed on the journal line.';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger E&ntries';
                    Image = GLRegisters;
                    Promoted = true; // BC Upgrade KUMARS145 chnaged to "True" for PromotedCategory.
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    PromotedCategory = Process;
                    RunObject = CodeUnit "Gen. Jnl.-Show Entries";
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
            }
            group("&Payments")
            {
                Caption = '&Payments';
                Image = Payment;
                action(SuggestVendorPayments)
                {
                    ApplicationArea = All;
                    Caption = 'Suggest Vendor Payments';
                    Ellipsis = true;
                    Image = SuggestVendorPayments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Create payment suggestion as lines in the payment journal.';
                    trigger OnAction();
                    var
                        SuggestVendorPayments: Report "Suggest Vendor Payments";
                        SuggestPaymentVendors: CodeUnit "Suggest Vendor Payments CBN";
                        GenJournalBatch: Record "Gen. Journal Batch";
                        GenJournalLine2: Record "Gen. Journal Line";
                        ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
                        HeinekenBCUpgrade: CodeUnit "Heineken BC Upgrade";
                        GenLedgerSetup: Record "General Ledger Setup";
                    begin
                        /*HEI.08
                        Clear(SuggestVendorPayments);
                        SuggestVendorPayments.SetGenJnlLine(Rec);
                        //HEI.03>>
                        SuggestVendorPayments.SetCalledFromPaymentJournalTree(TRUE);
                        //HEI.03<<
                        SuggestVendorPayments.RunModal();
                        */
                        //HEI.08>>
                        // BC Upgrade KUMARS145 Custom funcition TryDeleteJournalBatch ....>>
                        // ApprovalsMgmt.TryDeleteJournalBatch(Rec); 
                        HeinekenBCUpgrade.TryDeleteJournalBatch(Rec);
                        // BC Upgrade KUMARS145 Custom funcition TryDeleteJournalBatch ....<<
                        HeinekenGlobal.CheckPaymentJouralTreeLines(Rec);
                        GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");

                        //HEI.26>>
                        GenLedgerSetup.Get();
                        if GenLedgerSetup."Enable WHT FND" then begin
                            SuggestPaymentVendors.SetCalledFromPaymentJournalTree(true);
                            SuggestPaymentVendors.SetCalledFromPaymentJournalTreeWHT(true);
                        end else begin
                            //HEI.26<<
                            SuggestPaymentVendors.SetCalledFromPaymentJournalTree(true);
                        end; //HEI.26

                        SuggestPaymentVendors.ShowParam(false);
                        SuggestPaymentVendors.SetRec(Rec);
                        SuggestPaymentVendors.Run(GenJournalBatch)
                        //HEI.08<<

                    end;
                }
                action(ShowSuggestVendorPaymentsFilters)
                {
                    ApplicationArea = All;
                    Caption = 'Show Suggest Vendor Payments Filters';
                    ToolTip = 'Show Suggest Vendor Payments Filters';
                    Ellipsis = true;
                    Image = ShowSelected;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction();
                    var
                        SuggestVendorPayments: Report "Suggest Vendor Payments";
                        SuggestPaymentVendors: CodeUnit "Suggest Vendor Payments CBN";
                        GenJournalBatch: Record "Gen. Journal Batch";
                        GenJournalLine2: Record "Gen. Journal Line";
                    begin
                        //HEI.08>>
                        GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
                        SuggestPaymentVendors.ShowParam(true);
                        SuggestPaymentVendors.Run(GenJournalBatch)
                        //HEI.08<<
                    end;
                }
                action(PreviewCheck)
                {
                    ApplicationArea = All;
                    Caption = 'P&review Check';
                    Image = ViewCheck;
                    RunObject = Page "Check Preview";
                    RunPageLink = "Journal Template Name" = FIELD("Journal Template Name"),
                                  "Journal Batch Name" = FIELD("Journal Batch Name"),
                                  "Line No." = FIELD("Line No.");
                    ToolTip = 'Preview the check before printing it.';
                }
                action(CashierOrder)
                {
                    ApplicationArea = All;
                    Caption = 'Print Cashier Order';
                    ToolTip = 'Print Cashier Order';
                    Description = 'HEI.06';
                    Ellipsis = true;
                    Enabled = EnabledCashierOrderPrint;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction();
                    var
                        GenJournalBatch2: Record "Gen. Journal Batch";
                        GeneralJournalLine2: Record "Gen. Journal Line";
                    begin
                        //HEI.06>>
                        if GenJournalBatch2.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then;
                        GeneralJournalLine2.SetRange("Journal Template Name", Rec."Journal Template Name");
                        GeneralJournalLine2.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        GeneralJournalLine2.SetRange("Line No.", Rec."Line No.");
                        Report.RunModal(GenJournalBatch2."Cashier Order Report ID FND", true, true, GeneralJournalLine2);
                        //HEI.06<<
                    end;
                }
                action(PrintCheck)
                {
                    AccessByPermission = TableData "Check Ledger Entry" = R;
                    ApplicationArea = All;
                    Caption = 'Print Check';
                    Ellipsis = true;
                    Image = PrintCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Prepare to print the check.';
                    trigger OnAction();
                    var
                        PaymentMethod: Record "Payment Method";
                        GenJournalBatch: Record "Gen. Journal Batch";
                        HNKBankAcc: Record "Bank Account";
                    begin
                        GenJnlLine.Reset();
                        GenJnlLine.Copy(Rec);
                        GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                        GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");

                        HNKBankAcc.Get(Rec."HNK Bank Account FND"); //HEI.23 (Added code)

                        //HEI.17>>
                        //IF TENANTID = 'ivorycoast' THEN
                        //commented by HEI.19

                        //IF TENANTID IN ['ivorycoast','ethiopia','Burundi'] THEN//HEI.19 //Hei.21
                        if HNKBankAcc."Check Report ID" <> 0 then //HEI.23 (Added code)
                            GenJnlLine.SetRange("Line No.", Rec."Line No.");
                        //HEI.17<<
                        //HEI.08>>
                        GenJournalBatch.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
                        GenJournalBatch.TestField("Payment Method Code FND");
                        PaymentMethod.SetRange(Code, GenJournalBatch."Payment Method Code FND");
                        if PaymentMethod.FindFirst() then; //HEI.09
                        PaymentMethod.TestField("Cheque FND", true);
                        //HEI.08<<
                        GenJnlLine.TestField("Bank Payment Type", "Bank Payment Type"::"Computer Check"); //HEI.09

                        //HEI.17>>
                        //IF TENANTID IN ['ivorycoast','ethiopia'] THEN BEGIN //HEI.22 //HEI.23 (comment code)
                        //IF TENANTID = 'ivorycoast' THEN BEGIN //commented by HEI.22
                        //HNKBankAcc.Reset();  //HEI.23 (comment code)
                        if HNKBankAcc.Get(Rec."HNK Bank Account FND") and (HNKBankAcc."Check Report ID" <> 0) then
                            Report.RunModal(HNKBankAcc."Check Report ID", true, false, GenJnlLine)
                        else
                            DocPrint.PrintCheck(GenJnlLine);
                        //END ELSE //HEI.23 (comment code)
                        //HEI.17<<
                        //DocPrint.PrintCheck(GenJnlLine);  //HEI.23 (comment code)
                        CodeUnit.Run(CodeUnit::"Adjust Gen. Journal Balance", Rec);
                    end;
                }
                action(BatchPrintCheck)
                {
                    AccessByPermission = TableData "Check Ledger Entry" = R;
                    ApplicationArea = All;
                    Caption = 'Print Check Batch';
                    Ellipsis = true;
                    Image = PrintCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Prepare to print the check batch.';
                    Visible = DisablePrintCheckBatch;
                    trigger OnAction();
                    var
                        PaymentMethod: Record "Payment Method";
                        GenJournalBatch: Record "Gen. Journal Batch";
                        BankAccount: Record "Bank Account";
                        GeneralOpCoSetup: Record "General OpCo Setup FND";
                    begin
                        //HEI.09>>
                        GenJournalBatch.Reset();
                        GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
                        GenJournalBatch.TestField("Payment Method Code FND");
                        PaymentMethod.SetRange(Code, GenJournalBatch."Payment Method Code FND");
                        if PaymentMethod.FindFirst() then
                            PaymentMethod.TestField("Cheque FND", true);

                        //HEI.14>>
                        GeneralOpCoSetup.Get();
                        if GeneralOpCoSetup."Enable Digital Check Printout" then begin
                            BankAccount.Get(GenJournalBatch."HNK Bank Account FND");
                            BankAccount.TestField("Last Check No.");
                            //BankAccount.TestField("Check Payment Format"); //HEI.23 (comment code)
                        end;
                        //HEI.14<<

                        //GenJnlLine.TestField("Bank Payment Type", "Bank Payment Type"::"Computer Check"); //HEI.09
                        GenJournalLine.Reset();
                        GenJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                        GenJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        GenJournalLine.SetRange("Tree Level FND", 0);
                        if GenJournalLine.FindSet() then begin
                            repeat
                                GenJournalLine.TestField("Bank Payment Type", "Bank Payment Type"::"Computer Check"); //HEI.09
                                                                                                                      //HEI.27>>
                                                                                                                      //CurrPage.SETSELECTIONFILTER(GenJournalLine);
                                                                                                                      //HEI.27<<
                            until GenJournalLine.Next() = 0; //HEI.14
                            //DocPrint.PrintCheck(GenJnlLine);  //HEI.17

                            //HEI.27>>
                            //CurrPage.SETSELECTIONFILTER(GenJournalLine); //HEI.24
                            if BankAccount.Get(Rec."HNK Bank Account FND") and (BankAccount."Check Report ID" <> 0) then
                                Report.RunModal(BankAccount."Check Report ID", true, false, GenJournalLine)
                            else
                                //HEI.27<<
                                DocPrint.PrintCheck(GenJournalLine);  //HEI.17
                            CodeUnit.Run(CodeUnit::"Adjust Gen. Journal Balance", GenJournalLine);
                            //UNTIL GenJournalLine.Next()= 0; HEI.14
                        end;
                        //HEI.09<<
                    end;
                }
                action("Void Check")
                {
                    ApplicationArea = All;
                    Caption = 'Void Check';
                    Image = VoidCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Void the check if, for example, the check is not cashed by the bank.';
                    trigger OnAction();
                    var
                        ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
                    begin
                        Rec.TestField("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                        Rec.TestField("Check Printed", true);
                        //HEI.09>>
                        /*
                        IF Confirm(Text000,FALSE,"Document No.") THEN
                          CheckManagement.VoidCheck(Rec);
                        */
                        //>>HEI.31
                        GetCurrentlySelectedLines(GenJournalLine);
                        ApprovalsMgmt.TrySendJournalLineApprovalRequests(GenJournalLine);
                        //<<HEI.31
                        //>>HEI.31
                        /*
                        //IF Confirm(Text000,FALSE,"Document No.") THEN BEGIN //commented HEI.24
                        IF Confirm(Text000,FALSE,"HNK Check No.") THEN BEGIN //HEI.24
                          //>>HEI.15
                          CheckManagement.VoidCheck(Rec);
                          //<<HEI.15
                          "Check Printed" := FALSE;
                          "HNK Check No." := '';
                        END;
                        //HEI.09<<
                        */
                        //<<HEI.31

                    end;
                }
                action("Void &All Checks")
                {
                    ApplicationArea = All;
                    Caption = 'Void &All Checks';
                    Image = VoidAllChecks;
                    ToolTip = 'Void all checks if, for example, the checks are not cashed by the bank.';

                    trigger OnAction();
                    begin
                        //HEI.03>>
                        Rec.SetRange("Tree Level FND", 0);
                        //HEI.03<<
                        if Confirm(Text001, false) then begin
                            GenJnlLine.Reset();
                            GenJnlLine.Copy(Rec);
                            GenJnlLine.SetRange("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                            GenJnlLine.SetRange("Check Printed", true);
                            if GenJnlLine.Find('-') then
                                repeat
                                    GenJnlLine2 := GenJnlLine;
                                    //HEI.09>>
                                    //commented line CheckManagement.VoidCheck(GenJnlLine2);
                                    GenJnlLine2."Check Printed" := false;
                                    GenJnlLine2."HNK Check No. FND" := '';
                                    GenJnlLine2.Modify();
                                //HEI.09<<
                                until GenJnlLine.Next() = 0;
                        end;
                    end;
                }
                action(CreditTransferRegEntries)
                {
                    ApplicationArea = All;
                    Caption = 'Credit Transfer Reg. Entries';
                    Image = ExportReceipt;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = CodeUnit "Gen. Jnl.-Show CT Entries";
                    ToolTip = 'View or edit the credit transfer entries that are related to file export for credit transfers.';
                }
                action(CreditTransferRegisters)
                {
                    ApplicationArea = All;
                    Caption = 'Credit Transfer Registers';
                    Image = ExportElectronicDocument;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Credit Transfer Registers";
                    ToolTip = 'View or edit the payment files that have been exported in connection with credit transfers.';
                }
            }
            action(Approvals)
            {
                AccessByPermission = TableData "Approval Entry" = R;
                ApplicationArea = All;
                Caption = 'Approvals';
                Image = Approvals;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';
                trigger OnAction();
                var
                    GenJournalLine: Record "Gen. Journal Line";
                    ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
                begin
                    GetCurrentlySelectedLines(GenJournalLine);
                    ApprovalsMgmt.ShowJournalApprovalEntries(GenJournalLine);
                end;
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Renumber Document Numbers")
                {
                    ApplicationArea = All;
                    Caption = 'Renumber Document Numbers';
                    Image = EditLines;
                    ToolTip = 'Resort the numbers in the Document No. column to avoid posting errors because the document numbers are not in sequence. Entry applications and line groupings are preserved.';
                    trigger OnAction();
                    begin
                        Rec.RenumberDocumentNo();
                    end;
                }
                action(ApplyEntries)
                {
                    ApplicationArea = All;
                    Caption = 'Apply Entries';
                    Ellipsis = true;
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = CodeUnit "Gen. Jnl.-Apply";
                    ShortCutKey = 'Shift+F11';
                    ToolTip = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.';
                }
                // BC Upgrade BHARDA11 >> We need to moeve this button in Interface extension--PR Pending

                // action(ExportPaymentsToFile)
                // {
                //     Visible = false;
                //     ApplicationArea = All;
                //     Caption = 'Export Payments to File';
                //     Ellipsis = true;
                //     Image = ExportFile;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     PromotedIsBig = true;
                //     ToolTip = 'Export a file with the payment information on the journal lines.';
                //     trigger OnAction();
                //     var
                //         GenJnlLine: Record "Gen. Journal Line";
                //         lBankExportImportSetup: Record "Bank Export/Import Setup";
                //         // BankConnInterfaceMgt: CodeUnit "Bank Conn. Interface Mgt."; // BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan
                //         GenJnlLineTmp: Record "Gen. Journal Line BC" temporary;
                //         lInfoSentToWS: Boolean;
                //         lText50000: Label 'Journal lines were sent to WS!';
                //         GenJournalLineBC: Record "Gen. Journal Line BC";
                //         lCurrency: Record Currency;
                //         lUserSetup: Record "User Setup";
                //         lText50001: Label 'You are not allowed to reexport the payment!';
                //         lText50002: Label 'For Line No. %1, Document No. %2, Amount cannot have decimals!';
                //         // BankConnInterfaceMgt2: CodeUnit "Bank Conn. Interface Mgt. 2"; // BC Upgrade KUMARS145 Dependent on Codeunit 50204	Bank Conn. Interface Mgt. 2	Heineken_Interface			#Bogdan
                //         BankConnSetupFound: Boolean;
                //         lText50003: Label 'There is no Bank Export/Import Setup for Bank Connectivity!';
                //         ApprovalManagement: CodeUnit "Approvals Mgmt.";
                //         GenJournalBatch: Record "Gen. Journal Batch";
                //         RestrictionManagement: CodeUnit "Gen. Jnl.-Post Batch";
                //     begin
                //         //HEI.03>>
                //         Rec.SetRange("Tree Level", 0);
                //         //HEI.03<<

                //         //HEI.16>>
                //         /*
                //         GenJnlLine.CopyFilters(Rec);
                //         GenJnlLine.FindFirst();
                //         GenJnlLine.ExportPaymentFile;
                //         */

                //         //HEI.36>>
                //         BankConnSetupFound := false;
                //         //HEI.36<<

                //         lBankExportImportSetup.Reset();
                //         lBankExportImportSetup.SetRange("Journal Template Name", Rec."Journal Template Name");
                //         lBankExportImportSetup.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                //         // lBankExportImportSetup.SetRange("Processing CodeUnit ID", CodeUnit::"Bank Conn. Interface Mgt.");// BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan
                //         //HEI.36>>
                //         lBankExportImportSetup.SetRange(OPCO, lBankExportImportSetup.OPCO::"Ivory Coast");
                //         //HEI.36<<
                //         if lBankExportImportSetup.FindFirst() then begin
                //             //HEI.44>>
                //             GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
                //             if ApprovalManagement.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
                //                 // Rec.OnCheckGenJournalLinePostRestrictions();// BC Upgrade KUMARS145 Blank Procedure in Table 81 which does not exist.
                //             end;
                //             //HEI.44<<

                //             // BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan ......>>  
                //             // if (lBankExportImportSetup."Send to WS" = true) and (lBankExportImportSetup."Processing CodeUnit ID" = CodeUnit::"Bank Conn. Interface Mgt.") then begin
                //             //     GenJnlLine.Reset();
                //             //     GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                //             //     GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                //             //     GenJnlLine.SetRange("WS Posting Allowed", true);//if payment was already exported
                //             //     if GenJnlLine.FindFirst() then
                //             //         if lUserSetup.Get(UserId) then
                //             //             if lUserSetup."Allow to Reexport Payment WS" = false then
                //             //                 Error(lText50001);

                //             //     GenJournalLineBC.Reset();
                //             //     GenJournalLineBC.SetRange("Journal Template Name", Rec."Journal Template Name");
                //             //     GenJournalLineBC.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                //             //     GenJournalLineBC.DeleteAll();

                //             //     GenJnlLine.Reset();
                //             //     GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                //             //     GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                //             //     GenJnlLine.SetFilter("Parent Line No.", '=%1', 0);
                //             //     if GenJnlLine.FindFirst() then
                //             //         repeat
                //             //             GenJnlLine.TestField("HNK Bank Account");
                //             //             GenJnlLine.TestField("Customer/Vendor Bank");
                //             //             GenJnlLine.TestField("Posting Date");
                //             //             GenJnlLine.TestField("Account Type");
                //             //             GenJnlLine.TestField("Account No.");
                //             //             if GenJnlLine."Currency Code" <> '' then
                //             //                 if lCurrency.Get(GenJnlLine."Currency Code") then begin
                //             //                     lCurrency.TestField("ISO Currency Code");
                //             //                     if lCurrency."BC - Send Without Decimals" = true then
                //             //                         if (GenJnlLine.Amount mod 1) <> 0 then
                //             //                             Error(lText50002, GenJnlLine."Line No.", GenJnlLine."Document No.");
                //             //                 end;
                //             //             if GenJnlLine."Currency Code" = '' then begin
                //             //                 if lBankExportImportSetup."BC (LCY) - Send Without Dec." = true then
                //             //                     if (GenJnlLine.Amount mod 1) <> 0 then
                //             //                         Error(lText50002, GenJnlLine."Line No.", GenJnlLine."Document No.");
                //             //             end;

                //             //             GenJournalLineBC.TransferFields(GenJnlLine);
                //             //             GenJournalLineBC.Insert();
                //             //         until GenJnlLine.Next() = 0;

                //             //     GenJnlLine.Reset();
                //             //     GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                //             //     GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                //             //     GenJnlLine.SetFilter("Parent Line No.", '=%1', 0);
                //             //     if GenJnlLine.FindFirst() then begin
                //             //         GenJnlLineTmp.TransferFields(GenJnlLine);
                //             //         GenJnlLineTmp.Insert();
                //             //     end;

                //             //     if lBankExportImportSetup."Post WS Entries" then begin
                //             //         CodeUnit.Run(CodeUnit::"Gen. Jnl.-Post", Rec);
                //             //         CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                //             //         CurrPage.Update(false);
                //             //     end;

                //             //     lInfoSentToWS := false;
                //             //     if GenJnlLineTmp.FindFirst() then
                //             //         repeat
                //             //             BankConnInterfaceMgt.CreateNonSepaPayment(GenJnlLineTmp);
                //             //             lInfoSentToWS := true;
                //             //         until GenJnlLineTmp.Next() = 0;
                //             //     if lInfoSentToWS = true then
                //             //         Message(lText50000);
                //             // end else begin
                //             //     GenJnlLine.CopyFilters(Rec);
                //             //     GenJnlLine.FindFirst();
                //             //     GenJnlLine.ExportPaymentFile();
                //             // end;
                //             // BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan......<<

                //             //HEI.36>>
                //             BankConnSetupFound := true;
                //             //HEI.36<<
                //         end;
                //         //HEI.36>>
                //         //ELSE Error(Text50001);
                //         //HEI.36<<
                //         //HEI.16<<

                //         //HEI.36>>
                //         lBankExportImportSetup.Reset();
                //         lBankExportImportSetup.SetRange("Journal Template Name", Rec."Journal Template Name");
                //         lBankExportImportSetup.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                //         //HEI.38>>
                //         // lBankExportImportSetup.SetRange("Processing CodeUnit ID", CodeUnit::"Bank Conn. Interface Mgt. 2");//HEI.44 // BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan
                //         //HEI.41>>
                //         //lBankExportImportSetup.SetFilter(OPCO,'%1|%2',lBankExportImportSetup.OPCO::Panama,lBankExportImportSetup.OPCO::"Ethiopia-CBE");
                //         //lBankExportImportSetup.SetFilter(OPCO,'%1|%2|%3',lBankExportImportSetup.OPCO::Panama,lBankExportImportSetup.OPCO::"Ethiopia-CBE",lBankExportImportSetup.OPCO::MZ); //HEI.44
                //         //HEI.41<<
                //         //HEI.38<<
                //         if lBankExportImportSetup.FindFirst() then begin

                //             //HEI.41>>
                //             //IF lBankExportImportSetup.OPCO =lBankExportImportSetup.OPCO::MZ THEN BEGIN //HEI.44
                //             GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
                //             if ApprovalManagement.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then
                //                 // Rec.OnCheckGenJournalLinePostRestrictions();// BC Upgrade KUMARS145 Blank Procedure in Table 81 which does not exist.
                //                 //END;//HEI.44
                //                 //HEI.41<<

                //                 // BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan ......>>  
                //                 // if (lBankExportImportSetup."Send to WS" = true) and (lBankExportImportSetup."Processing CodeUnit ID" = CodeUnit::"Bank Conn. Interface Mgt. 2") then begin
                //                 //     GenJnlLine.Reset();
                //                 //     GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                //                 //     GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                //                 //     GenJnlLine.SetRange("WS Posting Allowed", true);//if payment was already exported
                //                 //     if GenJnlLine.FindFirst() then
                //                 //         if lUserSetup.Get(UserId) then
                //                 //             if lUserSetup."Allow to Reexport Payment WS" = false then
                //                 //                 Error(lText50001);

                //                 //     GenJournalLineBC.Reset();
                //                 //     GenJournalLineBC.SetRange("Journal Template Name", Rec."Journal Template Name");
                //                 //     GenJournalLineBC.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                //                 //     GenJournalLineBC.DeleteAll();

                //                 //     GenJnlLine.Reset();
                //                 //     GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                //                 //     GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                //                 //     GenJnlLine.SetFilter("Parent Line No.", '=%1', 0);
                //                 //     if GenJnlLine.FindFirst() then
                //                 //         repeat
                //                 //             GenJnlLine.TestField("HNK Bank Account");
                //                 //             GenJnlLine.TestField("Customer/Vendor Bank");
                //                 //             GenJnlLine.TestField("Posting Date");
                //                 //             GenJnlLine.TestField("Account Type");
                //                 //             GenJnlLine.TestField("Account No.");
                //                 //             if GenJnlLine."Currency Code" <> '' then
                //                 //                 if lCurrency.Get(GenJnlLine."Currency Code") then begin
                //                 //                     lCurrency.TestField("ISO Currency Code");
                //                 //                     if lCurrency."BC - Send Without Decimals" = true then
                //                 //                         if (GenJnlLine.Amount mod 1) <> 0 then
                //                 //                             Error(lText50002, GenJnlLine."Line No.", GenJnlLine."Document No.");
                //                 //                 end;
                //                 //             if GenJnlLine."Currency Code" = '' then begin
                //                 //                 if lBankExportImportSetup."BC (LCY) - Send Without Dec." = true then
                //                 //                     if (GenJnlLine.Amount mod 1) <> 0 then
                //                 //                         Error(lText50002, GenJnlLine."Line No.", GenJnlLine."Document No.");
                //                 //             end;

                //                 //             GenJournalLineBC.TransferFields(GenJnlLine);
                //                 //             GenJournalLineBC.Insert();
                //                 //         until GenJnlLine.Next() = 0;

                //                 //     GenJnlLine.Reset();
                //                 //     GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                //                 //     GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                //                 //     GenJnlLine.SetFilter("Parent Line No.", '=%1', 0);
                //                 //     if GenJnlLine.FindFirst() then begin
                //                 //         GenJnlLineTmp.TransferFields(GenJnlLine);
                //                 //         GenJnlLineTmp.Insert();
                //                 //     end;

                //                 //     if lBankExportImportSetup."Post WS Entries" then begin
                //                 //         CodeUnit.Run(CodeUnit::"Gen. Jnl.-Post", Rec);
                //                 //         CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                //                 //         CurrPage.Update(false);
                //                 //     end;

                //                 //     lInfoSentToWS := false;
                //                 //     if GenJnlLineTmp.FindFirst() then
                //                 //         repeat
                //                 //             BankConnInterfaceMgt2.CreateNonSepaPayment(GenJnlLineTmp);
                //                 //             lInfoSentToWS := true;
                //                 //         until GenJnlLineTmp.Next() = 0;
                //                 //     if lInfoSentToWS = true then
                //                 //         Message(lText50000);
                //                 // end else begin
                //                 //     GenJnlLine.CopyFilters(Rec);
                //                 //     GenJnlLine.FindFirst();
                //                 //     GenJnlLine.ExportPaymentFile();
                //                 // end;
                //                 // BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan......<<

                //                 BankConnSetupFound := true;
                //         end;
                //         //HEI.36<<

                //         //HEI.36>>
                //         if BankConnSetupFound = false then
                //             Error(lText50003);
                //         //HEI.36<<

                //     end;
                // }
                // BC Upgrade BHARDA11 << We need to moeve this button in Interface extension--PR Pending
                action(ExportBankToFile)
                {
                    ApplicationArea = All;
                    Caption = 'Export Bank to File';
                    Ellipsis = true;
                    Image = ExportFile;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Export a file with the payment information on the journal lines.';

                    trigger OnAction();
                    var
                        GenJnlLine: Record "Gen. Journal Line";
                        BankAccount: Record "Bank Account";
                        GenJournalBatch: Record "Gen. Journal Batch";
                        ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
                        TempGenLine: Record "Gen. Journal Line" temporary;
                        ApprovalEntry: Record "Approval Entry";
                        ExpBankPaymRawBank: Report "Exp Bank Paym DRC RawBank CBN";
                        ExpBankPaymFBN: Report "Exp Bank Paym DRC FBN CBN";
                        ExpBankPaymCitiCDF: Report "Exp Bank Paym DRC Citi CDF CBN";
                        ExpBankPaymCitiUSDEUR: Report "Exp Bank Paym Citi USD EUR CBN";
                        ExpBankPaymBCDC: Report "Exp Bank Paym DRC BCDC CBN";
                        OpenRequest: Boolean;
                        ApprovedRequest: Boolean;
                        Error01: Label 'You are not allowed to export the payments until at least one journal entry is approved!';
                        FindJnlLineChild: Record "Gen. Journal Line";
                        ExpBankPaymDRCRawBankCDF: Report "ExpBankPaymDRCRawBankCDFCBN";
                        ExpBankPaymDRCBCDCCDF: Report "ExpBankPaymDRC-BCDC-CDF CBN";
                        ExpBankPaymCitiDRC: Report "Exp Bank Paym Citi DRC CBN";
                        lItemTMP: Record Item temporary;
                        lGenJournalTemplate: Record "Gen. Journal Template";
                    begin
                        //HEI.37>>
                        GenJournalBatch.Reset();
                        lGenJournalTemplate.Reset();
                        if lGenJournalTemplate.Get(Rec."Journal Template Name") then
                            if (lGenJournalTemplate."DRC - Show Pay. Method FND" = true) then
                                if GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then begin
                                    GenJnlLine.Reset();
                                    GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                                    GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                                    if GenJnlLine.FindSet() then
                                        repeat
                                            lItemTMP.Reset();
                                            if not lItemTMP.Get(GenJnlLine."Value of Payment Method FND") then begin
                                                lItemTMP."No." := GenJnlLine."Value of Payment Method FND";
                                                lItemTMP.Insert();
                                            end;
                                        until GenJnlLine.Next() = 0;
                                end;

                        if lItemTMP.COUNT > 1 then
                            Error(Text50002);
                        lItemTMP.DeleteAll();
                        GenJournalBatch.Reset();
                        //HEI.37<<

                        //HEI.28<<
                        if GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then
                            if BankAccount.Get(GenJournalBatch."HNK Bank Account FND") and (BankAccount."Exp. Payments Bank Rep ID FND" <> 0) then begin
                                GenJnlLine.Reset();
                                GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                                GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                                GenJnlLine.SetFilter("Parent Line No. FND", '=%1', 0);
                                if GenJnlLine.FindSet() then
                                    repeat
                                        ApprovalEntry.Reset();
                                        ApprovalEntry.SetFilter("Table ID", '%1|%2', DATABASE::"Gen. Journal Batch", DATABASE::"Gen. Journal Line");
                                        ApprovalEntry.SetFilter("Record ID to Approve", '%1|%2', GenJournalBatch.RECORDID, GenJnlLine.RECORDID);
                                        ApprovalEntry.SetRange("Related to Change", false);
                                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                                        if not ApprovalEntry.FindFirst() then begin
                                            ApprovalEntry.SetFilter("Table ID", '%1|%2', DATABASE::"Gen. Journal Batch", DATABASE::"Gen. Journal Line");
                                            ApprovalEntry.SetFilter("Record ID to Approve", '%1|%2', GenJournalBatch.RECORDID, GenJnlLine.RECORDID);
                                            ApprovalEntry.SetRange("Related to Change", false);
                                            ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                                            if ApprovalEntry.FindFirst() then begin
                                                FindJnlLineChild.Reset();
                                                FindJnlLineChild.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                                                FindJnlLineChild.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                                                FindJnlLineChild.SetRange("Parent Line No. FND", GenJnlLine."Line No.");
                                                if FindJnlLineChild.FindSet() then
                                                    repeat
                                                        if not TempGenLine.Get(FindJnlLineChild."Journal Template Name", FindJnlLineChild."Journal Batch Name", FindJnlLineChild."Line No.") then begin
                                                            TempGenLine.Init();
                                                            TempGenLine."Journal Batch Name" := FindJnlLineChild."Journal Batch Name";
                                                            TempGenLine."Journal Template Name" := FindJnlLineChild."Journal Template Name";
                                                            TempGenLine."Line No." := FindJnlLineChild."Line No.";
                                                            TempGenLine."Posting Date" := FindJnlLineChild."Posting Date";
                                                            TempGenLine."Account No." := FindJnlLineChild."Account No.";
                                                            TempGenLine.Amount := FindJnlLineChild.Amount;
                                                            TempGenLine."Currency Code" := FindJnlLineChild."Currency Code";
                                                            TempGenLine."Recipient Bank Account" := FindJnlLineChild."Recipient Bank Account";
                                                            TempGenLine."Vendor Bank Acc. No. FND" := FindJnlLineChild."Vendor Bank Acc. No. FND";
                                                            TempGenLine."Vendor Bank Account FND" := FindJnlLineChild."Vendor Bank Account FND";
                                                            TempGenLine."Payment Method Code" := FindJnlLineChild."Payment Method Code";
                                                            TempGenLine."Applies-to Ext. Doc. No." := FindJnlLineChild."Applies-to Ext. Doc. No.";
                                                            TempGenLine."Applies-to Doc. No." := FindJnlLineChild."Applies-to Doc. No.";
                                                            TempGenLine."Parent Line No. FND" := FindJnlLineChild."Parent Line No. FND";
                                                            //HEI.32>>
                                                            TempGenLine."Currency Factor" := FindJnlLineChild."Currency Factor";
                                                            //HEI.32<<
                                                            TempGenLine.Insert();
                                                        end;
                                                    until FindJnlLineChild.Next() = 0;
                                            end;
                                        end;
                                    until GenJnlLine.Next() = 0;

                                Clear(TempGenLine);
                                if not TempGenLine.FindFirst() then
                                    Error(Error01);

                                // FBN Bank flat file
                                if BankAccount."Exp. Payments Bank Rep ID FND" = REPORT::"Exp Bank Paym DRC FBN CBN" then begin
                                    if TempGenLine.FindSet() then
                                        repeat
                                            ExpBankPaymFBN.SetGenJnlLine(TempGenLine);
                                        until TempGenLine.Next() = 0;
                                    ExpBankPaymFBN.RunModal();
                                end;

                                //HEI.32>>
                                //Rawbank —? CDF file
                                if BankAccount."Exp. Payments Bank Rep ID FND" = REPORT::"ExpBankPaymDRCRawBankCDFCBN" then begin
                                    if TempGenLine.FindSet() then
                                        repeat
                                            ExpBankPaymDRCRawBankCDF.SetGenJnlLine(TempGenLine);
                                        until TempGenLine.Next() = 0;
                                    ExpBankPaymDRCRawBankCDF.RunModal();
                                end;

                                //BCDC —? CDF file
                                if BankAccount."Exp. Payments Bank Rep ID FND" = REPORT::"ExpBankPaymDRC-BCDC-CDF CBN" then begin
                                    if TempGenLine.FindSet() then
                                        repeat
                                            ExpBankPaymDRCBCDCCDF.SetGenJnlLine(TempGenLine);
                                        until TempGenLine.Next() = 0;
                                    ExpBankPaymDRCBCDCCDF.RunModal();
                                end;
                                //HEI.32<<

                                //Citi CDF Bank flat file
                                if BankAccount."Exp. Payments Bank Rep ID FND" = REPORT::"Exp Bank Paym DRC Citi CDF CBN" then begin
                                    if TempGenLine.FindSet() then
                                        repeat
                                            ExpBankPaymCitiCDF.SetGenJnlLine(TempGenLine);
                                        until TempGenLine.Next() = 0;
                                    ExpBankPaymCitiCDF.RunModal();
                                end;

                                //Citi EUR Bank flatfile
                                if BankAccount."Exp. Payments Bank Rep ID FND" = 50439 then begin
                                    if TempGenLine.FindSet() then
                                        repeat
                                            ExpBankPaymCitiUSDEUR.SetGenJnlLine(TempGenLine);
                                        until TempGenLine.Next() = 0;
                                    ExpBankPaymCitiUSDEUR.RunModal();
                                end;

                                //Raw Bank flatfile
                                if BankAccount."Exp. Payments Bank Rep ID FND" = 50440 then begin
                                    if TempGenLine.FindSet() then
                                        repeat
                                            ExpBankPaymRawBank.SetGenJnlLine(TempGenLine);
                                        until TempGenLine.Next() = 0;
                                    ExpBankPaymRawBank.RunModal();
                                end;

                                //BCDC Bank flatfile
                                if BankAccount."Exp. Payments Bank Rep ID FND" = 50441 then begin
                                    if TempGenLine.FindSet() then
                                        repeat
                                            ExpBankPaymBCDC.SetGenJnlLine(TempGenLine);
                                        until TempGenLine.Next() = 0;
                                    ExpBankPaymBCDC.RunModal();
                                end;

                                //HEI.37>>
                                if BankAccount."Exp. Payments Bank Rep ID FND" = REPORT::"Exp Bank Paym Citi DRC CBN" then begin
                                    if TempGenLine.FindSet() then
                                        repeat
                                            ExpBankPaymCitiDRC.SetGenJnlLine(TempGenLine);
                                        until TempGenLine.Next() = 0;
                                    ExpBankPaymCitiDRC.RunModal();
                                end;
                                //HEI.37<<
                            end;

                        //HEI.28>>
                    end;
                }
                action(CalculatePostingDate)
                {
                    ApplicationArea = All;
                    Caption = 'Calculate Posting Date';
                    Image = CalcWorkCenterCalendar;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Calculate the date that will appear as the posting date on the journal lines.';

                    trigger OnAction();
                    begin
                        Rec.CalculatePostingDate();
                    end;
                }
                // BC Upgrade KUMARS145 CodeUnit Dependent on Drinkit.....>>
                // action("Apply Invoice List")
                // {
                //     ApplicationArea All;
                //     Caption = 'Apply Invoice List';
                //     Description = 'DITW17.10.05  DIT-770 #761';
                //     Image = ApplyEntries;
                //     Promoted = true;
                //     PromotedCategory = Process;

                //     trigger OnAction();
                //     var
                //         lcduApplyInvList: CodeUnit "Apply Invoice list";
                //     begin
                //         // <<DITW17.10.05 WSA 08/08/14 DIT-770 #761
                //         Clear(lcduApplyInvList);
                //         lcduApplyInvList.fctApplyInvoiceList(Rec);
                //         // >>DITW17.10.05 WSA 08/08/14 DIT-770 #761
                //     end;
                // }
                // BC Upgrade KUMARS145 CodeUnit Dependent on Drinkit.....<<
                action("Insert Conv. LCY Rndg. Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Insert Conv. LCY Rndg. Lines';
                    Image = InsertCurrency;
                    RunObject = CodeUnit "Adjust Gen. Journal Balance";
                    ToolTip = 'Insert a rounding correction line in the journal. This rounding correction line will balance in LCY when amounts in the foreign currency also balance. You can then post the journal.';
                }
                action(PositivePayExport)
                {
                    ApplicationArea = All;
                    Caption = 'Positive Pay Export';
                    ToolTip = 'Positive Pay Export';
                    Image = Export;
                    Visible = false;
                    trigger OnAction();
                    var
                        GenJnlBatch: Record "Gen. Journal Batch";
                        BankAcc: Record "Bank Account";
                    begin
                        GenJnlBatch.Get(Rec."Journal Template Name", CurrentJnlBatchName);
                        if GenJnlBatch."Bal. Account Type" = GenJnlBatch."Bal. Account Type"::"Bank Account" then begin
                            BankAcc."No." := GenJnlBatch."Bal. Account No.";
                            PAGE.Run(PAGE::"Positive Pay Export", BankAcc);
                        end;
                    end;
                }
                // BC Upgrade KUMARS145 Reports Dependent on Drinkit.....>>
                // action("Suggest Route Settlement")
                // {
                //     ApplicationArea All;
                //     Caption = 'Suggest Route Settlement';
                //     Ellipsis = true;
                //     Image = Suggest;
                //     trigger OnAction();
                //     var
                //         CreateRouteSettSuggest: Report "Suggest Customer Payments";
                //     begin
                //         // <<DITW15.00.00.26 DDR 18/11/2008
                //         CreateRouteSettSuggest.SetGenJnlLine(Rec);
                //         CreateRouteSettSuggest.RunModal();
                //         Clear(CreateRouteSettSuggest);
                //     end;
                // }
                // BC Upgrade KUMARS145 Reports Dependent on Drinkit.....>>
                action(DeleteBatch)
                {
                    ApplicationArea = All;
                    Caption = 'Delete Batch';
                    ToolTip = 'Delete Batch';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        GenJournalLine: Record "Gen. Journal Line";
                        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";
                        ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
                        GenJournalLine1: Record "Gen. Journal Line";
                        VendLedgEntry: Record "Vendor Ledger Entry";
                    begin
                        //HEI.13>>
                        GenJournalLine1.Reset();
                        GenJournalLine1.SetRange("Journal Template Name", Rec."Journal Template Name");
                        GenJournalLine1.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        if GenJournalLine1.FindSet() then begin
                            repeat
                                VendLedgEntry.SetCurrentKey("Document No.", "Document Type");
                                VendLedgEntry.SetRange("Document No.", GenJournalLine1."Applies-to Doc. No.");
                                VendLedgEntry.SetRange("Document Type", GenJournalLine1."Applies-to Doc. Type");
                                if VendLedgEntry.FindFirst() then
                                    if VendLedgEntry."Batch payment name FND" <> '' then begin
                                        VendLedgEntry."Batch payment name FND" := '';
                                        VendLedgEntry."Applies-to ID" := '';
                                        VendLedgEntry.MODIFY();
                                    end;
                                GenJournalLine1."Check Printed" := false;
                                GenJournalLine1.Modify(true);
                            until GenJournalLine1.Next() = 0;
                        end;
                        //HEI.13<<

                        //HEI.08>>
                        // BC Upgrade KUMARS145 Custom funcition TryDeleteJournalBatch ....>>
                        // ApprovalsMgmt.TryDeleteJournalBatch(Rec);
                        HeinekenBCUpgrade.TryDeleteJournalBatch(Rec);
                        // BC Upgrade KUMARS145 Custom funcition TryDeleteJournalBatch ....<<

                        GenJournalLine.Reset();
                        GenJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                        GenJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        GenJournalLine.DeleteAll(true);
                        //HEI.10 CurrPage.SaveRecord();
                        CurrPage.Update(); //HEI.10
                        //HEI.08<<
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Reconcile)
                {
                    ApplicationArea = All;
                    Caption = 'Reconcile';
                    Image = Reconcile;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ShortCutKey = 'Ctrl+F11';
                    ToolTip = 'View the balances on bank accounts that are marked for reconciliation, usually liquid accounts.';

                    trigger OnAction();
                    begin
                        GLReconcile.SetGenJnlLine(Rec);
                        GLReconcile.Run();
                    end;
                }
                action(PreCheck)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Pre-Payment Journal';
                    Image = PreviewChecks;
                    ToolTip = 'View journal line entries, payment discounts, discount tolerance amounts, payment tolerance, and any errors associated with the entries. You can use the results of the report to review payment journal lines and to review the results of posting before you actually post.';

                    trigger OnAction();
                    var
                        GenJournalBatch: Record "Gen. Journal Batch";
                    begin
                        GenJournalBatch.Init();
                        GenJournalBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
                        GenJournalBatch.SetRange(Name, Rec."Journal Batch Name");
                        Report.Run(Report::"Vendor Pre-Payment Journal", true, false, GenJournalBatch);
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction();
                    begin
                        ReportPrint.PrintGenJnlLine(Rec);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction();
                    var
                        MarkvendorAccount: Code[20];
                        counter: Integer;
                        Gnlrec: Record "Gen. Journal Line";
                        lItemTMP: Record Item temporary;
                        lGenJournalTemplate: Record "Gen. Journal Template";
                        lSenderName: Text;
                        TempGJNL2: Record "Gen. Journal Line" temporary;
                    begin
                        //HEI.37>>
                        GenJournalBatch.Reset();
                        lGenJournalTemplate.Reset();
                        if lGenJournalTemplate.Get(Rec."Journal Template Name") then
                            if (lGenJournalTemplate."DRC - Show Pay. Method FND" = true) then
                                if GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then begin
                                    GenJnlLine.Reset();
                                    GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                                    GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                                    if GenJnlLine.FindFirst() then
                                        repeat
                                            lItemTMP.Reset();
                                            if not lItemTMP.Get(GenJnlLine."Value of Payment Method FND") then begin
                                                lItemTMP."No." := GenJnlLine."Value of Payment Method FND";
                                                lItemTMP.Insert();
                                            end;
                                        until GenJnlLine.Next() = 0;
                                end;

                        if lItemTMP.COUNT > 1 then
                            Error(Text50002);
                        lItemTMP.DeleteAll();
                        GenJournalBatch.Reset();
                        //HEI.37<<

                        //HEI.18>>
                        TempGJNL.DeleteAll();
                        TempGJNL1.DeleteAll();
                        TempGJNL2.DeleteAll(); //HEI.46
                        TempVLE.DeleteAll();
                        if Rec.FindSet() then begin
                            repeat
                                TempGJNL.Init();
                                TempGJNL1.Init();
                                TempGJNL.Copy(Rec);
                                TempGJNL1.Copy(Rec);
                                //HEI.46>>
                                TempGJNL2.Init();
                                TempGJNL2.Copy(Rec);
                                TempGJNL2.Insert();
                                //HEI.46<<

                                if Rec."Document No." <> '' then
                                    GENJNLDocNo := '';

                                if HNKCHECKNo = '' then
                                    HNKCHECKNo := Rec."HNK Check No. FND";
                                if GENJNLDocNo = '' then
                                    GENJNLDocNo := Rec."Document No.";

                                if Rec."Document No." <> '' then
                                    TempGJNL."Document No." := GENJNLDocNo;

                                if Rec."HNK Check No. FND" <> '' then
                                    TempGJNL."HNK Check No. FND" := HNKCHECKNo;

                                TempGJNL.Insert();
                                TempGJNL1."Document No." := GENJNLDocNo;
                                TempGJNL1."HNK Check No. FND" := HNKCHECKNo;
                                TempGJNL1.Insert();

                                if Rec."HNK Check No. FND" = '' then
                                    HNKCHECKNo := '';

                            until Rec.Next() = 0;
                        end;
                        if not TempVLE.IsEmpty then begin
                            if TempVLE.FindSet() then begin
                                repeat
                                    counter := counter + 1;
                                until TempVLE.Next() = 0;
                            end;
                        end;

                        GenJournalLine.Reset();
                        GenJournalLine.SetRange("Journal Template Name", TempGJNL."Journal Template Name");
                        GenJournalLine.SetRange("Journal Batch Name", TempGJNL."Journal Batch Name");
                        GenJournalLine.SetRange("Document Type", TempGJNL."Document Type");
                        GenJournalLine.SetFilter("Account No.", '<>%1', '');
                        if not GenJournalLine.IsEmpty then
                            //TempGJNL.SetRange("Applies-to Doc. Type",TempGJNL."Applies-to Doc. Type"::Invoice);
                            HeinekenGlobal.AutoArchiveGenJournalLine(Rec);
                        HeinekenGlobal.OnAfterDeleteGenJournalLine(Rec);
                        HeinekenGlobal.OnBeforePostPaymentJournalTreeJournal(Rec);
                        CodeUnit.Run(CodeUnit::"Gen. Jnl.-Post", Rec);
                        Rec.SetRange("Tree Level FND", 0);
                        if TempGJNL.FindSet() then begin
                            repeat
                                if MarkvendorAccount <> TempGJNL."Account No." then begin
                                    TempGJNL1.SetRange("Account No.", TempGJNL."Account No.");
                                    TempGJNL1.SetRange("Tree Level FND", 1);
                                    if TempGJNL1.FindSet() then begin
                                        repeat

                                            //******************************** working code **************************************//
                                            CompanyInformation.Get();
                                            // BC Upgrade KUMARS145 The application object or method 'ServerTempFileName' has scope 'OnPrem' and cannot be used for 'Extension' development.
                                            // ServerAttachmentFilePath := COPYSTR(FileManagement.ServerTempFileName('pdf'), 1, 250); // Don't need it as using Temp Blob to create a PDF.
                                            // BC Upgrade KUMARS145 The application object or method 'ServerTempFileName' has scope 'OnPrem' and cannot be used for 'Extension' development.

                                            Clear(RemittanceAdvice);
                                            RemittanceAdvice.SetFilterGNL(TempGJNL1);
                                            RemittanceAdvice.GetVendNoFromPayJnlTree(TempGJNL1."Account No.");//HEI.39
                                                                                                              //HEI.46>>
                                            TempGJNL2.SetRange("Account No.", TempGJNL1."Account No.");
                                            TempGJNL2.SetRange("Tree Level FND", 0);
                                            if TempGJNL2.FindFirst() then;
                                            RemittanceAdvice.GetPostingDateFromPayJnlTree(TempGJNL2."Posting Date");
                                            //HEI.46<<
                                            // BC Upgrade KUMARS Used new method to save report as PDF......>>  
                                            // RemittanceAdvice.SaveAsPDF(ServerAttachmentFilePath);
                                            TempBlobCU.CreateOutStream(OutStr);
                                            RemittanceAdvice.SaveAs('', ReportFormat::Pdf, OutStr);
                                            TempBlobCU.CreateInStream(InStr);
                                            // BC Upgrade KUMARS Used new method to save report as PDF......<<  

                                            if TempGJNL1."Account Type" = TempGJNL1."Account Type"::Vendor then begin
                                                if
                                                TempGJNL1."Account No." <> '' then
                                                    if vendor.Get(TempGJNL1."Account No.") then
                                                        //IF vendor."Remittance Email" <> '' THEN //HEI.33
                                                        if vendor."E-Mail 2 FND" <> '' then //HEI.33
                                                            SendRemittanceEmail := true;
                                            end;
                                            Commit();

                                            //CodeUnit.Run(CodeUnit::"Gen. Jnl.-Post",Rec);

                                            if (Rec.IsEmpty) or (Rec."Account No." = '') then // BC Upgrade BHARDA11 -- 09June2026
                                                SendRemittanceEmail := true
                                            else
                                                SendRemittanceEmail := false;

                                            Commit();

                                            if SendRemittanceEmail then begin
                                                CompanyInformation.TestField("E-Mail");
                                                // SMTPMailSetup.Get();// BC Upgrade KUMARS145 old smtp code commented.
                                                // Clear(SMTPMail);// BC Upgrade KUMARS145 old smtp code commented.
                                                //HEI.39>>
                                                gGenOpCoSetUp.Get();
                                                if TempGJNL1."Account Type" = TempGJNL1."Account Type"::Vendor then begin
                                                    if vendor.Get(TempGJNL1."Account No.") then
                                                        gVendLanguage := vendor."Language Code";
                                                end;

                                                //IF NOT gGenOpCoSetUp."French Payment Remittance" THEN BEGIN  //HEI.45
                                                if (not gGenOpCoSetUp."French Payment Remittance") and (not gGenOpCoSetUp."Spanish Payment Remittance") then begin //HEI.45
                                                    TestMailTitleTxt := TestMailTitleTxtEng;
                                                    TestMailBodyTxt := TestMailBodyTxtEng;
                                                    AttachmentName := AttachmentNameEng;
                                                end
                                                else begin
                                                    if gGenOpCoSetUp."Payment Remittance Language" = gVendLanguage then begin
                                                        TestMailTitleTxt := TestMailTitleTxtFr;
                                                        TestMailBodyTxt := TestMailBodyTxtFr;
                                                        AttachmentName := AttachmentNameFr;
                                                    end
                                                    //HEI.45>>
                                                    else if gGenOpCoSetUp."Payment Remittance Language Sp" = gVendLanguage then begin
                                                        TestMailTitleTxt := TestMailTitleTxtSp;
                                                        TestMailBodyTxt := TestMailBodyTxtSp;
                                                    end
                                                    //HEI.45<<
                                                    else begin
                                                        TestMailTitleTxt := TestMailTitleTxtEng;
                                                        TestMailBodyTxt := TestMailBodyTxtEng;
                                                        AttachmentName := AttachmentNameEng;
                                                        //Error(FrLangError);
                                                    end;
                                                end;
                                                //HEI.39<<
                                                //Clear(SMTPMail);

                                                //HEI.45>>
                                                Clear(lSenderName);
                                                if not gGenOpCoSetUp."Spanish Payment Remittance" then
                                                    lSenderName := CompanyInformation."E-Mail"
                                                else
                                                    lSenderName := CompanyInformation."Account Payable Email FND";
                                                //HEI.45<<
                                                // BC Upgrade KUMARS145 old SMTP code commented new block is added ......>>
                                                // SMTPMail.CreateMessage(
                                                //   '',
                                                //   //CompanyInformation."E-Mail", //HEI.45
                                                //   lSenderName,                   //HEI.45
                                                //   vendor."E-Mail 2",//HEI.33
                                                //                     //vendor."Remittance Email",//HEI.33
                                                //   TestMailTitleTxt,
                                                //   StrSubstNo(
                                                //     TestMailBodyTxt,
                                                //     vendor.Name, CompanyInformation.Name),
                                                //   true);
                                                // //SMTPMail.AddAttachment(ServerAttachmentFilePath,'Payment Remittance Advice'+ Format(WORKDATE)+'.PDF');//Old code commented//HEI.39
                                                // SMTPMail.AddAttachment(ServerAttachmentFilePath, AttachmentName + Format(WORKDATE) + '.PDF');//HEI.39
                                                //  //HEI.39>>
                                                //  /*END
                                                //  ELSE BEGIN
                                                //    IF gGenOpCoSetUp."Payment Remittance Language" = gVendLanguage THEN BEGIN
                                                //      Clear(SMTPMail);
                                                //      SMTPMail.CreateMessage(
                                                //          '',
                                                //          CompanyInformation."E-Mail",
                                                //          vendor."E-Mail 2",//HEI.33
                                                //          //vendor."Remittance Email",//HEI.33
                                                //          TestMailTitleTxtFr,
                                                //          STRSUBSTNO(
                                                //            TestMailBodyTxtFr,
                                                //            vendor.Name,CompanyInformation.Name),
                                                //          TRUE);
                                                //        SMTPMail.AddAttachment(ServerAttachmentFilePath,'Avis de paiement non versement.'+ Format(WORKDATE)+'.PDF');
                                                //    END;
                                                //  END;*/
                                                //  //HEI.39<<
                                                // SMTPMail.Send();

                                                EmailMessageCU.Create(vendor."E-Mail 2 FND", TestMailTitleTxt, StrSubstNo(TestMailBodyTxt, vendor.Name, CompanyInformation.Name), true);
                                                EmailMessageCU.AddAttachment(AttachmentName + Format(WORKDATE) + '.pdf', 'PDF', InStr);
                                                EmailCU.Send(EmailMessageCU, Enum::"Email Scenario"::Default);
                                                // BC Upgrade KUMARS145 old SMTP code commented new block is added ......<<

                                            end;

                                            MarkvendorAccount := TempGJNL1."Account No.";
                                        until TempGJNL1.Next() = 0;
                                    end;
                                end;
                            until TempGJNL.Next() = 0;

                            //******************************** working code **************************************//
                        end;

                        if SendRemittanceEmail then
                            Message(TestMailSuccessMsg, vendor."E-Mail 2 FND");//HEI.33
                                                                               //Message(TestMailSuccessMsg,vendor."Remittance Email"); //HEI.33

                        CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                        //CurrPage.Update(TRUE);
                        //GenJournalLine.DeleteAll(True);
                        CurrPage.Update(false);
                        //HEI.18<<
                        //Error(Rec."Document No.");
                        //>>HEI.31
                        Gnlrec.Reset();
                        Gnlrec.SetRange("Document No.", Rec."Document No.");
                        if Gnlrec.FindFirst() then
                            Gnlrec.Delete();
                        CurrPage.Update(false);
                        //<<HEI.31

                    end;
                }
                action(Preview)
                {
                    ApplicationArea = All;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction();
                    var
                        GenJnlPost: CodeUnit "Gen. Jnl.-Post";
                    begin
                        //HEI.03>>
                        Rec.SetRange("Tree Level FND", 0);
                        //HEI.03<<
                        GenJnlPost.Preview(Rec);
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction();
                    var
                        lItemTMP: Record Item temporary;
                        lGenJournalTemplate: Record "Gen. Journal Template";
                    begin
                        //HEI.37>>
                        GenJournalBatch.Reset();
                        lGenJournalTemplate.Reset();
                        if lGenJournalTemplate.Get(Rec."Journal Template Name") then
                            if (lGenJournalTemplate."DRC - Show Pay. Method FND" = true) then
                                if GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then begin
                                    GenJnlLine.Reset();
                                    GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                                    GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                                    if GenJnlLine.FindFirst() then
                                        repeat
                                            lItemTMP.Reset();
                                            if not lItemTMP.Get(GenJnlLine."Value of Payment Method FND") then begin
                                                lItemTMP."No." := GenJnlLine."Value of Payment Method FND";
                                                lItemTMP.Insert();
                                            end;
                                        until GenJnlLine.Next() = 0;
                                end;

                        if lItemTMP.COUNT > 1 then
                            Error(Text50002);
                        lItemTMP.DeleteAll();
                        GenJournalBatch.Reset();
                        //HEI.37<<

                        //HEI.03>>
                        HeinekenGlobal.AutoArchiveGenJournalLine(Rec);
                        HeinekenGlobal.OnAfterDeleteGenJournalLine(Rec);
                        Rec.SetRange("Tree Level FND", 0);
                        //HEI.03<<
                        CodeUnit.Run(CodeUnit::"Gen. Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                        CurrPage.Update(false);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                group(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    action(SendApprovalRequestJournalBatch)
                    {
                        ApplicationArea = All;
                        Caption = 'Journal Batch';
                        Enabled = NOT OpenApprovalEntriesOnBatchOrAnyJnlLineExist;
                        Image = SendApprovalRequest;
                        ToolTip = 'Send all journal lines for approval, also those that you may not see because of filters.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.TrySendJournalBatchApprovalRequest(Rec);
                            SetControlAppearance();
                        end;
                    }
                    action(SendApprovalRequestJournalLine)
                    {
                        ApplicationArea = All;
                        Caption = 'Selected Journal Lines';
                        Enabled = NOT OpenApprovalEntriesOnBatchOrCurrJnlLineExist;
                        Image = SendApprovalRequest;
                        ToolTip = 'Send selected journal lines for approval.';

                        trigger OnAction();
                        var
                            GenJournalLine: Record "Gen. Journal Line";
                            ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
                        begin
                            GetCurrentlySelectedLines(GenJournalLine);
                            ApprovalsMgmt.TrySendJournalLineApprovalRequests(GenJournalLine);
                        end;
                    }
                }
                group(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    action(CancelApprovalRequestJournalBatch)
                    {
                        ApplicationArea = All;
                        Caption = 'Journal Batch';
                        Enabled = CanCancelApprovalForJnlBatch;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending all journal lines for approval, also those that you may not see because of filters.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.TryCancelJournalBatchApprovalRequest(Rec);
                            SetControlAppearance();
                        end;
                    }
                    action(CancelApprovalRequestJournalLine)
                    {
                        ApplicationArea = All;
                        Caption = 'Selected Journal Lines';
                        Enabled = CanCancelApprovalForJnlLine;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending selected journal lines for approval.';

                        trigger OnAction();
                        var
                            GenJournalLine: Record "Gen. Journal Line";
                            ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
                        begin
                            GetCurrentlySelectedLines(GenJournalLine);
                            ApprovalsMgmt.TryCancelJournalLineApprovalRequests(GenJournalLine);
                        end;
                    }
                }
            }
            group(Workflow)
            {
                Caption = 'Workflow';
                action(CreateApprovalWorkflow)
                {
                    ApplicationArea = All;
                    Caption = 'Create Approval Workflow';
                    Enabled = NOT EnabledApprovalWorkflowsExist;
                    Image = CreateWorkflow;
                    ToolTip = 'Set up an approval workflow for payment journal lines, by going through a few pages that will guide you.';

                    trigger OnAction();
                    var
                        TempApprovalWorkflowWizard: Record "Approval Workflow Wizard" temporary;
                    begin
                        TempApprovalWorkflowWizard."Journal Batch Name" := Rec."Journal Batch Name";
                        TempApprovalWorkflowWizard."Journal Template Name" := Rec."Journal Template Name";
                        TempApprovalWorkflowWizard."For All Batches" := false;
                        TempApprovalWorkflowWizard.Insert();

                        Page.RunModal(Page::"Pmt. App. Workflow Setup Wzrd.", TempApprovalWorkflowWizard);
                    end;
                }
                action(ManageApprovalWorkflows)
                {
                    ApplicationArea = All;
                    Caption = 'Manage Approval Workflows';
                    Enabled = EnabledApprovalWorkflowsExist;
                    Image = WorkflowSetup;
                    ToolTip = 'View or edit existing approval workflows for payment journal lines.';

                    trigger OnAction();
                    var
                        WorkflowManagement: CodeUnit "Workflow Management";
                    begin
                        WorkflowManagement.NavigateToWorkflows(Database::"Gen. Journal Line", EventFilter);
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveGenJournalLineRequest(Rec);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectGenJournalLineRequest(Rec);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateGenJournalLineRequest(Rec);
                    end;
                }
                action(Comment1)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'View or add comments.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        GenJournalBatch: Record "Gen. Journal Batch";
                        ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
                    begin
                        if OpenApprovalEntriesOnJnlLineExist then
                            ApprovalsMgmt.GetApprovalComment(Rec)
                        else
                            if OpenApprovalEntriesOnJnlBatchExist then
                                if GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then
                                    ApprovalsMgmt.GetApprovalComment(GenJournalBatch);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        WorkflowEventHandling: CodeUnit "Workflow Event Handling";
        WorkflowManagement: CodeUnit "Workflow Management";
        TempGenJournalLine: Record "Gen. Journal Line";
    begin
        SetControlAppearance();
        StyleTxt := Rec.GetOverdueDateInteractions(OverdueWarningText);
        // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        // SetFilterSubContractPostType; // BC Upgrade KUMARS145 Dependent on Drinkit function 
        // >>DITW16.00.00.41 AHU DIT-715 #327
        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
        UpdateBalance();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);

        if GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then
            ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.PAGE.SetFilterOnWorkflowRecord(GenJournalBatch.RecordId);
        ShowWorkflowStatusOnLine := CurrPage.WorkflowStatusLine.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);

        EventFilter := WorkflowEventHandling.RunWorkflowOnSendGeneralJournalLineForApprovalCode();
        EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::"Gen. Journal Line", EventFilter);

        EnabledCashierOrderPrint := Rec."Parent Line No. FND" = 0; //HEI.06
    end;

    trigger OnAfterGetRecord();
    var
        lBankAccount: Record "Bank Account";
        lGenJournalBatch: Record "Gen. Journal Batch";
        lParentPostingDate: Date;
        lGenJournalLine: Record "Gen. Journal Line";
        lGenJournalLine2: Record "Gen. Journal Line";
        lGenJournalTemplate: Record "Gen. Journal Template";
        lDRCSetupforExpPayMeth: Record "DRC-Setup for Exp Pay Meth FND";
        lVendorBankAccount: Record "Vendor Bank Account";
        lTransitNo: Text[20];
    begin
        StyleTxt := Rec.GetOverdueDateInteractions(OverdueWarningText);
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        HasPmtFileErr := Rec.HasPaymentFileErrors();

        //HEI.32>>
        ShowAmountLCYDRC := false;

        if lGenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then
            if lBankAccount.Get(lGenJournalBatch."HNK Bank Account FND") and (lBankAccount."Activate Amount LCY DRC FND" = true) then begin
                ShowAmountLCYDRC := true;
                if Rec."Currency Code" = '' then
                    Rec."Amount LCY DRC FND" := Rec.Amount;
                if Rec."Parent Line No. FND" = 0 then
                    lParentPostingDate := Rec."Posting Date"
                else
                    if lGenJournalLine.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Parent Line No. FND") then
                        lParentPostingDate := lGenJournalLine."Posting Date";
                if Rec."Currency Code" <> '' then
                    Rec."Amount LCY DRC FND" := CurrencyExchangeRate.ExchangeAmtFCYToLCY(lParentPostingDate, Rec."Currency Code", Rec.Amount, Rec."Currency Factor");
            end;
        //HEI.32<<

        //HEI.37>>
        lGenJournalTemplate.Reset();
        if gTemplateInfoRead = false then
            if lGenJournalTemplate.Get(Rec."Journal Template Name") then begin
                if lGenJournalTemplate."DRC - Show Pay. Method FND" = true then
                    gShowValueOfPaymentMethod := true;
                if GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then;
                if gBankAccount.Get(GenJournalBatch."HNK Bank Account FND") then;
                gTemplateInfoRead := true;
            end;


        if gShowValueOfPaymentMethod = true then begin
            lDRCSetupforExpPayMeth.Reset();
            lVendorBankAccount.SetRange("Vendor No.", Rec."Account No.");
            lVendorBankAccount.SetRange(Code, Rec."Recipient Bank Account");
            if lVendorBankAccount.FindFirst() then begin
                lTransitNo := lVendorBankAccount."Transit No.";
            end
            else begin
                lVendorBankAccount.SetRange("Vendor No.", Rec."Account No.");
                lVendorBankAccount.SetRange(Code, Rec."Vendor Bank Account FND");
                if lVendorBankAccount.FindFirst() then begin
                    lTransitNo := lVendorBankAccount."Transit No.";
                end;
            end;

            lDRCSetupforExpPayMeth.SetRange("House Bank", lBankAccount."No.");
            lDRCSetupforExpPayMeth.SetRange("Receiving Bank", lVendorBankAccount.Code);
            if (Rec."Currency Code" <> '') then
                lDRCSetupforExpPayMeth.SetRange(Currency, Rec."Currency Code");
            if (Rec."Currency Code" = '') then
                lDRCSetupforExpPayMeth.SetRange(Currency, '');
            lDRCSetupforExpPayMeth.SetRange("Country Receiving Bank", lVendorBankAccount."Country/Region Code");
            if lDRCSetupforExpPayMeth.FindFirst() then
                Rec."Value of Payment Method FND" := lDRCSetupforExpPayMeth."Value for Payment Method";
        end;
        //HEI.37<<
    end;

    trigger OnDeleteRecord(): Boolean;
    var
        TempGenJournalLine: Record "Gen. Journal Line" temporary;
        foundRec: Boolean;
        VendorLedgerEntry_G: Record "Vendor Ledger Entry";
    begin
        //HEI.02>>
        //GetCurrentlySelectedLines(Rec);
        CurrPage.SetSelectionFilter(GenJournalLine);
        //HeinekenGlobal.UpdatePaymentProposal4MGenJnlLine(GenJournalLine);
        if GenJournalLine.FindSet() then
            //HeinekenGlobal.UpdatePaymentProposal4MGenJnlLine(GenJournalLine);
            //IF GenJournalLine.FindSet() THEN BEGIN
            if GenJournalLine."Applies-to Doc. No." <> '' then
                VendorLedgerEntry_G.SetRange("Document No.", GenJournalLine."Applies-to Doc. No.")
            else
                VendorLedgerEntry_G.SetRange("Document No.", GenJournalLine."Document No.");
        if VendorLedgerEntry_G.FindSet() then begin
            repeat
                //IF VendorLedgerEntry_G.Open THEN BEGIN
                VendorLedgerEntry_G.Validate("Batch payment name FND", '');
                foundRec := true;
            // END;
            until VendorLedgerEntry_G.Next() = 0;
        end;
        if foundRec then
            VendorLedgerEntry_G.Modify();
        //END;
        //HEI.02<<
    end;

    trigger OnInit();
    begin
        TotalBalanceVisible := true;
        BalanceVisible := true;
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        CheckForPmtJnlErrors();
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        HasPmtFileErr := false;
        UpdateBalance();
        Rec.SetUpNewLine(xRec, Balance, BelowxRec);
        Clear(ShortcutDimCode);
    end;

    trigger OnOpenPage();
    var
        JnlSelected: Boolean;
        GenJnlTemplL: Record "Gen. Journal Template";
        PageID: Integer;
    begin
        BalAccName := '';

        if Rec.IsOpenedFromBatch() then begin
            CurrentJnlBatchName := Rec."Journal Batch Name";
            GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
            SetControlAppearance();
            exit;
        end;
        GenJnlManagement.TemplateSelection(Page::"Payment Journal", Enum::"Gen. Journal Template Type"::Payments, false, Rec, JnlSelected);
        if not JnlSelected then
            Error('');
        GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
        SetControlAppearance();

        //HEI.37>>
        gTemplateInfoRead := false;
        gShowValueOfPaymentMethod := false;
        //HEI.37<<
    end;

    var
        Text000: Label 'Void Check %1?';
        Text001: Label 'Void all printed checks?';
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlManagement: CodeUnit GenJnlManagement;
        ReportPrint: CodeUnit "Test Report-Print";
        DocPrint: CodeUnit "Document-Print";
        CheckManagement: CodeUnit CheckManagement;
        ChangeExchangeRate: Page "Change Exchange Rate";
        GLReconcile: Page Reconciliation;
        CurrentJnlBatchName: Code[10];
        AccName: Text[50];
        BalAccName: Text[50];
        Balance: Decimal;
        TotalBalance: Decimal;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        HasPmtFileErr: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        // BC Upgrade PATELS08 >> # [InDataSet] Blocked because it is deprecated and exposure of page variables handled automatically in BC.
        // [InDataSet]
        // BC Upgrade PATELS08 <<
        BalanceVisible: Boolean;
        // BC Upgrade PATELS08 >> # [InDataSet] Blocked because it is deprecated and exposure of page variables handled automatically in BC.
        // [InDataSet]
        // BC Upgrade PATELS08 <<

        TotalBalanceVisible: Boolean;
        StyleTxt: Text;
        OverdueWarningText: Text;
        EventFilter: Text;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        OpenApprovalEntriesOnJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        ShowWorkflowStatusOnBatch: Boolean;
        ShowWorkflowStatusOnLine: Boolean;
        CanCancelApprovalForJnlBatch: Boolean;
        CanCancelApprovalForJnlLine: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        HeinekenGlobal: CodeUnit "Heineken Global";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        EnabledCashierOrderPrint: Boolean;
        DisablePrintCheckBatch: Boolean;
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        TempGJNL: Record "Gen. Journal Line" temporary;
        TempGJNL1: Record "Gen. Journal Line" temporary;
    // BC Upgrade KUMARS145 Deprecated Variables for Emails....>> 
    // SMTPMailSetup: Record "SMTP Mail Setup";
    // SMTPMail: CodeUnit "SMTP Mail";
    // BC Upgrade KUMARS145 Deprecated Variables for Emails....<<

    // BC Upgrade KUMARS145 New vars for Emailing.........>> 
    var
        EmailMessageCU: Codeunit "Email Message";
        EmailCU: Codeunit Email;
        TempBlobCU: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        // BC Upgrade KUMARS145 New vars for Emailing.........<<
        vendor: Record Vendor;
        CompanyInformation: Record "Company Information";
        ServerAttachmentFilePath: Text[1024];
        FileManagement: CodeUnit "File Management";
        GenJournalLine2: Record "Gen. Journal Line";
        SendRemittanceEmail: Boolean;
        RemittanceAdvice: Report "Remittance Advice CBN";
        TestMailSuccessMsg: TextConst Comment = '{Locked="SMTP"} %1 is an email address.', ENU = 'Remittance email has been sent \Check your email for messages to make sure that the email was delivered successfully.', FRA = 'L''e-mail test a â?stâ?s envoyâ?s â?¦ †—¿%1—¿†Ø en fonction des paramÅ tres SMTP actuels.\Contrâ?olez vos messages pour vâ?srifier que vous avez bien reâ?¡u cet e-mail.';
        EditPaymentref: Boolean;
        GENJNLDocNo: Code[20];
        HNKCHECKNo: Code[50];
        TempVLE: Record "Vendor Ledger Entry" temporary;
        RemainingAmt: Decimal;
        Text50000: Label 'Please verify Bank Export/Import Setup!';
        Text50001: Label 'Please verify Bank Export/Import Setup! Journal Template Name and Journal Batch Name cannot be blank!';
        Rec_ApprovalEntry: Record "Approval Entry";
        GeneralJournalBatch: Record "Gen. Journal Batch";
        Var_approved: Boolean;
        GenJournalLine1: Record "Gen. Journal Line";
        GenJournalLine12: Record "Gen. Journal Line";
        GeneraljournalTemplate: Record "Gen. Journal Template";
        RestrictedRecords: Record "Restricted Record";
        ShowAmountLCYDRC: Boolean;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GenJournalTest: Record "Gen. Journal Line";
        gShowValueOfPaymentMethod: Boolean;
        gTemplateInfoRead: Boolean;
        GenJournalBatch: Record "Gen. Journal Batch";
        gBankAccount: Record "Bank Account";
        gVendor: Record Vendor;
        gVendLanguage: Code[10];
        AttachmentName: Text[100];
        TestMailBodyTxtEng: Label 'Dear %1 <br><br> Please find attached your payment Remittance Advice. <br><Br> Best Regards, <br><Br> %2 <br><Br>';
        TestMailTitleTxtEng: Label 'Payment Remittance Advice.';
        TestMailTitleTxtFr: Label 'Avis de paiement non versement.';
        Text50002: Label 'There are multiple Payment Methods! File cannot be generated!';
        FrLangError: Label 'Payment Remittance is set to French, please select the same in Payment Remittance Language';
        AttachmentNameFr: Label 'Avis de paiement non versement';
        AttachmentNameEng: Label 'Payment Remittance Advice';
        TestMailTitleTxt: Text[1024];
        TestMailBodyTxt: Text[1024];
        SourceCodeSetup: Record "Source Code Setup";
        gGenOpCoSetUp: Record "General OpCo Setup FND";
        TestMailBodyTxtFr: Label 'Chère %1 <br><br> Veuillez trouver ci-joint votre avis de versement de paiement. <br><Br> Meilleures salutations, <br><Br> %2 <br><Br>';
        TestMailBodyTxtSp: Label 'Estimado %1 <br><br> Adjunto encontrará su aviso de pago. <br><Br> Saludos cordiales, <br><Br> %2 <br><Br>';
        TestMailTitleTxtSp: Label 'Aviso de Remesas de Pago.';

    local procedure CheckForPmtJnlErrors();
    var
        BankAccount: Record "Bank Account";
        BankExportImportSetup: Record "Bank Export/Import Setup";
    begin
        if HasPmtFileErr then
            if (Rec."Bal. Account Type" = Rec."Bal. Account Type"::"Bank Account") and BankAccount.Get(Rec."Bal. Account No.") then
                if BankExportImportSetup.Get(BankAccount."Payment Export Format") then
                    if BankExportImportSetup."Check Export CodeUnit" > 0 then
                        CodeUnit.Run(BankExportImportSetup."Check Export CodeUnit", Rec);
    end;

    local procedure UpdateBalance();
    var
        GenJournalLineBalance: Record "Gen. Journal Line";
        paymentJournal: page "Payment Journal";
    begin
        //HEI.04>>
        GenJournalLineBalance.SetRecFilter();
        GenJournalLineBalance.SetFilter("Tree Level FND", '%1', 0);
        //GenJnlManagement.CalcBalance(
        //  Rec,xRec,Balance,TotalBalance,ShowBalance,ShowTotalBalance);
        GenJnlManagement.CalcBalance(GenJournalLineBalance, xRec, Balance, TotalBalance, ShowBalance, ShowTotalBalance);
        //HEI.04<<
        BalanceVisible := ShowBalance;
        TotalBalanceVisible := ShowTotalBalance;
    end;

    local procedure CurrentJnlBatchNameOnAfterVali();
    begin
        CurrPage.SaveRecord();
        GenJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.Update(false);
    end;

    local procedure GetCurrentlySelectedLines(var GenJournalLine: Record "Gen. Journal Line"): Boolean;
    begin
        CurrPage.SetSelectionFilter(GenJournalLine);
        exit(GenJournalLine.FindSet());
    end;

    local procedure SetControlAppearance();
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        ApprovalsMgmt: CodeUnit "Approvals Mgmt.";
    begin
        if GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then;
        OpenApprovalEntriesExistForCurrUser :=
          ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(GenJournalBatch.RecordId) or
          ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);

        OpenApprovalEntriesOnJnlBatchExist := ApprovalsMgmt.HasOpenApprovalEntries(GenJournalBatch.RecordId);
        OpenApprovalEntriesOnJnlLineExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist := OpenApprovalEntriesOnJnlBatchExist or OpenApprovalEntriesOnJnlLineExist;

        OpenApprovalEntriesOnBatchOrAnyJnlLineExist :=
          OpenApprovalEntriesOnJnlBatchExist or
          ApprovalsMgmt.HasAnyOpenJournalLineApprovalEntries(Rec."Journal Template Name", Rec."Journal Batch Name");

        CanCancelApprovalForJnlBatch := ApprovalsMgmt.CanCancelApprovalForRecord(GenJournalBatch.RecordId);
        CanCancelApprovalForJnlLine := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;
}

