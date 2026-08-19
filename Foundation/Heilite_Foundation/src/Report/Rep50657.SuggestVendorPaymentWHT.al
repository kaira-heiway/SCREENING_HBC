report 50657 "Suggest Vendor Payments WHT"
{
    // DITW16.00.00.43 DDR 09/08/2013 DIT-715 #714 Added all Contract Fields
    // 
    // DITW17.00.02 DDR 09/08/2013 DIT-715 #714 merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : New Code Added
    // DITW17.10.03 MSF 06/05/2014 DIT-770 #340 :DIT-770 340 Variable customer posting group
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field 2014319  "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
    //                              Added data Item Vendor ledger Entries Only For Filtring
    // DITW110.00.11 AKH 29/08/2017 NRQ#17902 Bugfix when running the batch with filters on Vendor Ledger entries
    // DITW110.00.11 MSF 15/11/2017 NRQ#45760 Added fields Financial Contract No.
    // 
    // HEI.01 FDD-PTPGAP029 IBM.ISYED01 31/07/2017
    //   # Created a new Function UpdatePaymentProposal with Batch name + Today.
    // HEI.02 FDD-PTPGAP013 IBM.PATHAA02 31.07.2017
    // # Code logic written to process only Payment status-'Payment Approved' for payment proposal
    // HEI.03 FDD-PTPGAP022 IBM.PATHAA02 31.07.2017
    // # Code Logic written to Exclude vendor from VLE having 'Cheque' field as YES in Payment method
    // HEI.04 FDD PTPGAP026 - Payment Method List IBM.NAIKH01 03.08.2017
    //   # Added Code on Function "GetVendLedgEntries"
    //   # PTPGAP013 - Code logic written to process only Payment status-'Payment Approved' for payment proposal
    // HEI.05 FDD PTPGAP068 IBM COSTES02 17.08.2017
    //   # Hide Summarize per vendor group
    //   # Manage the created general journal lines for showing as tree in payment journal
    // HEI.06 Defect #897 #956 IBM NASTAA02 7.11.2017 # Grouped amounts in payment proposal are not correct
    //   # Moved higher some filters
    // Hei.07 IBM HORTOC01 13.11.2017 #filter vendor dataitem by sensitive block
    // HEI.08 Defect #1026 IBM NASTAA02 12.12.2017 # Payment Tree Archive shouls consist only of posted documents
    //   # No Payment Tree Archive should be generated when Vendor Payments are suggested
    // HEI.09 Defect #991 IBM NASTAA02 15.12.2017 # Vendor doc. number not correct in the proposal
    //   # In case of Tree Payments the "Applies-to Ext. Doc No." should be populated just on the child entries
    // HEI.10  FDDPTPGAP011 IBM HORTOC01 30.01.2018
    //   #skip vendor ledger entry lines with document subtype code = PO and Payment Status = Pending Review
    // HEI.11 PTPGAP083 IBM NASTAA02 05.03.2018 # Mark Reversed Rejected Payments
    //   # Field "Reversed" should be filled-in when a transaction is reversed
    // HEI.12 PTPGAP077 IBM HORTOC01 23.03.2018
    //   #remove vendor balance check
    // 
    // HEI.13 FDD PTPGAP078 IBM POSTOI01 15.05.2018
    //   # new field on page Request Options Page HnkBankAcc , code 20 , related to Bank Account table
    //   # modify SetDefaults function :the new field HnkBankAcc should be initialized with corresponding field from current General Journal Batch
    //   # modify MakeGenJnlLines() function: save the value of HnkBankAcc request option Page to Heineken Bank Account Code, save also Bank Payment Type from Batch Bank Payment Type and set the appropiate Source Code
    //   # modify OnPreReport to check if the current journal is a Payment Journal Tree then the Source Code Setup should have a value for field Payment Journal tree
    // HEI.14 PTPGAP083 IBM NASTAA02 13.06.2018 # Mark Reversed Rejected Payments
    //   # Reversed changes from HEI.11
    // HEI.15 defect#2019 IBM POSTOI01 13.09.2018 # Vendor Ledger Entry filters not working properly
    //   # modified function
    // HEI.16 Bugfixing Bahamas 03.04.2019 # Payment Batch Name
    //   # Payment Batch Name from Vendor Ledger Entry need to be updated just when the journal lines are created
    //   # Moved code from HEI.01 to function "MakeGenJnlLine"
    // HEI.17 FDD-HT453 IBM GAVANM01 20.06.2019
    //   # if Bank Payment Type from Batch Bank Payment Type is empty, then it will be saved from the request page
    // HEI.18 V1.05 HT84 IBM POENAB02 03.07.2019
    //   # Code added in function MakeGenJnlLines
    // HEI.19 IBM MATHEJ01 17.08.19 - #CHG2018612 Enable the change of currency when issuing checks
    //   # Modified functions: OnOpenPage, SetDefaults, MakeGenJnlLines, Control55000> - OnValidate()
    //   # New Variables: BankCurr, EnableBankCurr
    //   # New local variable CurrExchRate added to the function MakeGenJnlLines
    // HEI.20 FDD-HT594 IBM NASTAA02 07.10.2019 # La Reunion FA Requirements Vendor
    //   # Added Request Option "Fixed Asset Acquisition"
    //   # Code added on functions "GetVendLedgEntries" and "MakeGenJnlLines"
    // HEI.21 CHG2044561 defect #5045 IBM GAVANM01 20.12.2019 # The length of the HnkBankAcc variable was changed to 20
    // HEI.22 defect #5099 CHG2049326 IBM GAVANM01 30.01.2020 # filter on currency code for VLE is not working
    // HEI.23 FDD-HT1103 IBM SURYAS01  13-04-2020
    //   #Added code in Function "Saveamount"
    // HEI.24 CHG2052196 IBM PANDES01 04-12-2020
    //  # Added code for document No . modification enhancement for check legder entry voiding.
    // HEI.25 CHG2089956 IBM POENAB02 Issue with "Recipient Bank Account" in Payment Journal Tree
    //  # Modified function MakeGenJnlLines

    Caption = 'Suggest Vendor Payments';
    ProcessingOnly = true;

    dataset
    {
        dataitem("WHT Posting Setup FND"; "WHT Posting Setup FND")
        {
            dataitem(VendorLedgerEntriesFilter; "Vendor Ledger Entry")
            {
                DataItemTableView = SORTING("Entry No.");
                DataItemLinkReference = "WHT Posting Setup FND"; // BC Upgrade BHARAD11 -- 16June2026
                // BC Upgrade - RD03 Drinkit Field "Route Planning No.", "Document Subtype Code", "Item Charge Type", DIT Sub-Contract Type -- >>
                //RequestFilterFields = "Payment Method Code", "Route Planning No.", "Document Subtype Code", "Item Charge Type", "DIT Sub-Contract Type", "Vendor Posting Group";
                // BC Upgrade - RD03 Drinkit Field "Route Planning No." -- <<
                RequestFilterFields = "Payment Method Code", "Vendor Posting Group";
                trigger OnPreDataItem()
                begin
                    CurrReport.BREAK();
                end;
            }
            dataitem(Vendor; Vendor)
            {
                // DataItemTableView = SORTING("No.")
                //                     WHERE(Blocked = FILTER(= ' '),
                //                           "Sensitive Payment Block FND" = FILTER("No."));
                DataItemTableView = sorting("No.") where(Blocked = filter(= ''), "Sensitive Payment Block FND" = FILTER(false));
                // BC Upgrade - RD03 Drinkit Field -->>
                //RequestFilterFields = "No.", "Payment Method Code", "Vendor Posting Group Filter";
                // BC Upgrade - RD03 Drinkit Field -- <<
                DataItemLinkReference = "WHT Posting Setup FND"; // BC Upgrade BHARAD11 -- 16June2026
                RequestFilterFields = "No.", "Payment Method Code";

                trigger OnAfterGetRecord()
                var
                    lWHTEntry: Record "WHT Entry FND";
                begin
                    //WHT
                    /*
                    IF ("WHT Posting Setup"."WHT Business Posting Group" <> '') OR ("WHT Posting Setup"."WHT Product Posting Group" <> '') THEN BEGIN //noWHT
                      lWHTEntry.SETCURRENTKEY("Bill-to/Pay-to No.", "WHT Bus. Posting Group", "WHT Prod. Posting Group", "Transaction Type", "Document Type");
                      lWHTEntry.SETRANGE("Bill-to/Pay-to No.", Vendor."No.");
                      lWHTEntry.SETRANGE("WHT Bus. Posting Group", "WHT Posting Setup"."WHT Business Posting Group");
                      lWHTEntry.SETRANGE("WHT Prod. Posting Group", "WHT Posting Setup"."WHT Product Posting Group");
                      lWHTEntry.SETRANGE("Transaction Type", lWHTEntry."Transaction Type"::Purchase);
                      lWHTEntry.SETRANGE("Document Type", lWHTEntry."Document Type"::Invoice);
                      IF NOT lWHTEntry.FINDFIRST THEN
                        CurrReport.SKIP;
                    END;
                    */
                    CLEAR(VendorBalance);
                    CALCFIELDS("Balance (LCY)");
                    VendorBalance := "Balance (LCY)";

                    IF StopPayments THEN
                        CurrReport.BREAK();
                    //WHT Window.UPDATE(1,"No.");
                    //IF VendorBalance > 0 THEN BEGIN//HEI.12
                    GetVendLedgEntries(TRUE, FALSE);
                    GetVendLedgEntries(FALSE, FALSE);
                    CheckAmounts(FALSE);
                    ClearNegative();
                    //END;

                end;

                trigger OnPostDataItem()
                begin
                    IF UsePriority AND NOT StopPayments THEN BEGIN
                        RESET();
                        COPYFILTERS(Vend2);
                        SETCURRENTKEY(Priority);
                        SETRANGE(Priority, 0);
                        IF FIND('-') THEN
                            REPEAT
                                CLEAR(VendorBalance);
                                CALCFIELDS("Balance (LCY)");
                                VendorBalance := "Balance (LCY)";
                                //IF VendorBalance > 0 THEN BEGIN//HEI.12
                                //WHT Window.UPDATE(1,"No.");
                                GetVendLedgEntries(TRUE, FALSE);
                                GetVendLedgEntries(FALSE, FALSE);
                                CheckAmounts(FALSE);
                                ClearNegative();
                            //END;
                            UNTIL (NEXT() = 0) OR StopPayments;
                    END;

                    IF UsePaymentDisc AND NOT StopPayments THEN BEGIN
                        RESET();
                        COPYFILTERS(Vend2);
                        Window2.OPEN(Text007);
                        IF FIND('-') THEN
                            REPEAT
                                CLEAR(VendorBalance);
                                CALCFIELDS("Balance (LCY)");
                                VendorBalance := "Balance (LCY)";
                                Window2.UPDATE(1, "No.");
                                PayableVendLedgEntry.SETRANGE("Vendor No.", "No.");
                                //IF VendorBalance > 0 THEN BEGIN//HEI.12
                                GetVendLedgEntries(TRUE, TRUE);
                                GetVendLedgEntries(FALSE, TRUE);
                                CheckAmounts(TRUE);
                                ClearNegative();
                            //END;
                            UNTIL (NEXT() = 0) OR StopPayments;
                        Window2.CLOSE();
                    END ELSE
                        IF FIND('-') THEN
                            REPEAT
                                ClearNegative();
                            UNTIL NEXT = 0;

                    DimSetEntry.LOCKTABLE();
                    GenJnlLine.LOCKTABLE();
                    GenJnlTemplate.GET(GenJnlLine."Journal Template Name");
                    GenJnlBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
                    GenJnlLine.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                    GenJnlLine.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                    IF GenJnlLine.FINDLAST() THEN BEGIN
                        LastLineNo := GenJnlLine."Line No.";
                        GenJnlLine.INIT();
                    END;

                    Window2.OPEN(Text008);

                    PayableVendLedgEntry.RESET();
                    PayableVendLedgEntry.SETRANGE(Priority, 1, 2147483647);
                    MakeGenJnlLines();
                    PayableVendLedgEntry.RESET();
                    PayableVendLedgEntry.SETRANGE(Priority, 0);
                    MakeGenJnlLines();

                    PayableVendLedgEntry.RESET();
                    PayableVendLedgEntry.DELETEALL();
                    //HEI.08>>
                    //HEI.05>>
                    //IF CalledFromPaymentJournalTree THEN BEGIN
                    //  GenJnlLineToArchive.SETRANGE("Journal Template Name",GenJnlTemplate.Name);
                    //  GenJnlLineToArchive.SETRANGE("Journal Batch Name",GenJnlBatch.Name);
                    //  GenJnlLineToArchive.SETRANGE("Archive Document No.",ArchiveDocumentNo);
                    //  HeinekenGlobal.AutoArchiveGenJournalLine(GenJnlLineToArchive);
                    //END;
                    //HEI.05<<
                    //HEI.08<<
                    Window2.CLOSE();
                    //WHT Window.CLOSE;
                    ShowMessage(MessageText);
                end;

                trigger OnPreDataItem()
                begin

                    IF LastDueDateToPayReq = 0D THEN
                        ERROR(Text000);
                    IF (PostingDate = 0D) AND (NOT UseDueDateAsPostingDate) THEN
                        ERROR(Text001);

                    BankPmtType := GenJnlLine2."Bank Payment Type";
                    BalAccType := GenJnlLine2."Bal. Account Type";
                    BalAccNo := GenJnlLine2."Bal. Account No.";
                    GenJnlLineInserted := FALSE;
                    SeveralCurrencies := FALSE;
                    MessageText := '';

                    IF ((BankPmtType = BankPmtType::" ") OR
                        SummarizePerVend) AND
                       (NextDocNo = '')
                    THEN
                        ERROR(Text002);

                    IF ((BankPmtType = BankPmtType::"Manual Check") AND
                        NOT SummarizePerVend AND
                        NOT DocNoPerLine)
                    THEN
                        ERROR(Text017, GenJnlLine2.FIELDCAPTION("Bank Payment Type"), SELECTSTR(BankPmtType + 1, Text023));

                    IF UsePaymentDisc AND (LastDueDateToPayReq < WORKDATE()) THEN
                        IF NOT CONFIRM(Text003, FALSE, WORKDATE()) THEN
                            ERROR(Text005);

                    Vend2.COPYFILTERS(Vendor);

                    OriginalAmtAvailable := AmountAvailable;
                    IF UsePriority THEN BEGIN
                        SETCURRENTKEY(Priority);
                        SETRANGE(Priority, 1, 2147483647);
                        UsePriority := TRUE;
                    END;
                    //WHT Window.OPEN(Text006);

                    SelectedDim.SETRANGE("User ID", USERID);
                    SelectedDim.SETRANGE("Object Type", 3);
                    //SelectedDim.SETRANGE("Object ID",REPORT::"Suggest Vendor Payments");
                    SelectedDim.SETRANGE("Object ID", Report::"Suggest Vendor Payments Hei");
                    SummarizePerDim := SelectedDim.FIND('-') AND SummarizePerVend;

                    NextEntryNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "WHT Posting Setup FND"."WHT Business Posting Group" + ' ' + "WHT Posting Setup FND"."WHT Product Posting Group");
                //WHT
                AmountAvailable := 0;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE();
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN(Text102);
                "WHT Posting Setup FND".SETCURRENTKEY("WHT Posting Setup FND"."Realized WHT Type");
                "WHT Posting Setup FND".SETASCENDING("WHT Posting Setup FND"."Realized WHT Type", FALSE);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    group("Find Payments")
                    {
                        Caption = 'Find Payments';
                        field(LastPaymentDate; LastDueDateToPayReq)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Last Payment Date';
                            Editable = NOT ShowFilters;
                            ToolTip = 'Specifies the latest payment date that can appear on the vendor ledger entries to be included in the batch job. Only entries that have a due date or a payment discount date before or on this date will be included. If the payment date is earlier than the system date, a warning will be displayed.';
                        }
                        field(FindPaymentDiscounts; UsePaymentDisc)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Find Payment Discounts';
                            Editable = NOT ShowFilters;
                            Importance = Additional;
                            MultiLine = true;
                            ToolTip = 'Specifies if you want the batch job to include vendor ledger entries for which you can receive a payment discount.';

                            trigger OnValidate()
                            begin
                                IF UsePaymentDisc AND UseDueDateAsPostingDate THEN
                                    ERROR(PmtDiscUnavailableErr);
                            end;
                        }
                        field(UseVendorPriority; UsePriority)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Use Vendor Priority';
                            Editable = NOT ShowFilters;
                            Importance = Additional;
                            ToolTip = 'Specifies if the Priority field on the vendor cards will determine in which order vendor entries are suggested for payment by the batch job. The batch job always prioritizes vendors for payment suggestions if you specify an available amount in the Available Amount (LCY) field.';

                            trigger OnValidate()
                            begin
                                IF NOT UsePriority AND (AmountAvailable <> 0) THEN
                                    ERROR(Text011);
                            end;
                        }
                        field("Available Amount (LCY)"; AmountAvailable)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Available Amount (LCY)';
                            Editable = NOT ShowFilters;
                            Importance = Additional;
                            ToolTip = 'Specifies a maximum amount (in LCY) that is available for payments. The batch job will then create a payment suggestion on the basis of this amount and the Use Vendor Priority check box. It will only include vendor entries that can be paid fully.';

                            trigger OnValidate()
                            begin
                                IF AmountAvailable <> 0 THEN
                                    UsePriority := TRUE;
                            end;
                        }
                        field(SkipExportedPayments; SkipExportedPayments)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Skip Exported Payments';
                            Editable = NOT ShowFilters;
                            Importance = Additional;
                            ToolTip = 'Specifies if you do not want the batch job to insert payment journal lines for documents for which payments have already been exported to a bank file.';
                        }
                    }
                    group("Summarize Results")
                    {
                        Caption = 'Summarize Results';
                        Visible = NOT CalledFromPaymentJournalTree;
                        field(SummarizePerVendor; SummarizePerVend)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Summarize per Vendor';
                            Editable = NOT ShowFilters;
                            ToolTip = 'Specifies if you want the batch job to make one line per vendor for each currency in which the vendor has ledger entries. If, for example, a vendor uses two currencies, the batch job will create two lines in the payment journal for this vendor. The batch job then uses the Applies-to ID field when the journal lines are posted to apply the lines to vendor ledger entries. If you do not select this check box, then the batch job will make one line per invoice.';

                            trigger OnValidate()
                            begin
                                IF SummarizePerVend AND UseDueDateAsPostingDate THEN
                                    ERROR(PmtDiscUnavailableErr);
                            end;
                        }
                        field(SummarizePerDimText; SummarizePerDimText)
                        {
                            ApplicationArea = Suite;
                            Caption = 'By Dimension';
                            Editable = false;
                            Enabled = SummarizePerDimTextEnable;
                            Importance = Additional;
                            ToolTip = 'Specifies the dimensions that you want the batch job to consider.';

                            trigger OnAssistEdit()
                            var
                                DimSelectionBuf: Record "Dimension Selection Buffer";
                            begin
                                DimSelectionBuf.SetDimSelectionMultiple(3, REPORT::"Suggest Vendor Payments", SummarizePerDimText);
                            end;
                        }
                    }
                    group("Fill in Journal Lines")
                    {
                        Caption = 'Fill in Journal Lines';
                        field(PostingDate; PostingDate)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posting Date';
                            Editable = NOT ShowFilters;
                            Importance = Promoted;
                            ToolTip = 'Specifies the date for the posting of this batch job. By default, the working date is entered, but you can change it.';

                            trigger OnValidate()
                            begin
                                ValidatePostingDate();
                            end;
                        }
                        field(ExecutionDate; ExecutionDate)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Execution Date';
                            Editable = NOT ShowFilters;
                            ToolTip = 'Execution Date';
                        }
                        field(UseDueDateAsPostingDate; UseDueDateAsPostingDate)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Calculate Posting Date from Applies-to-Doc. Due Date';
                            Editable = NOT ShowFilters;
                            Importance = Additional;
                            ToolTip = 'Specifies if the due date on the purchase invoice will be used as a basis to calculate the payment posting date.';

                            trigger OnValidate()
                            begin
                                IF UseDueDateAsPostingDate AND (SummarizePerVend OR UsePaymentDisc) THEN
                                    ERROR(PmtDiscUnavailableErr);
                                IF NOT UseDueDateAsPostingDate THEN
                                    CLEAR(DueDateOffset);
                            end;
                        }
                        field(DueDateOffset; DueDateOffset)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Applies-to-Doc. Due Date Offset';
                            Editable = NOT ShowFilters;
                            Enabled = UseDueDateAsPostingDate;
                            Importance = Additional;
                            ToolTip = 'Specifies a period of time that will separate the payment posting date from the due date on the invoice. Example 1: To pay the invoice on the Friday in the week of the due date, enter CW-2D (current week minus two days). Example 2: To pay the invoice two days before the due date, enter -2D (minus two days).';
                        }
                        field(StartingDocumentNo; NextDocNo)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Starting Document No.';
                            Editable = NOT ShowFilters;
                            ToolTip = 'Specifies the next available number in the number series for the journal batch that is linked to the payment journal. When you run the batch job, this is the document number that appears on the first payment journal line. You can also fill in this field manually.';

                            trigger OnValidate()
                            begin
                                if NextDocNo <> '' then
                                    if IncStr(NextDocNo) = '' then
                                        Error(StartingDocumentNoErr)
                            end;
                        }
                        field(NewDocNoPerLine; DocNoPerLine)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'New Doc. No. per Line';
                            Editable = NOT ShowFilters;
                            Importance = Additional;
                            ToolTip = 'Specifies if you want the batch job to fill in the payment journal lines with consecutive document numbers, starting with the document number specified in the Starting Document No. field.';

                            trigger OnValidate()
                            begin
                                IF NOT UsePriority AND (AmountAvailable <> 0) THEN
                                    ERROR(Text013);
                            end;
                        }
                        field(BalAccountType; GenJnlLine2."Bal. Account Type")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bal. Account Type';
                            Editable = NOT ShowFilters;
                            Importance = Additional;
                            OptionCaption = 'G/L Account,,,Bank Account';
                            ToolTip = 'Specifies the balancing account type that payments on the payment journal are posted to.';

                            trigger OnValidate()
                            begin
                                GenJnlLine2."Bal. Account No." := '';
                            end;
                        }
                        field(BalAccountNo; GenJnlLine2."Bal. Account No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Editable = NOT ShowFilters;
                            Importance = Additional;
                            ToolTip = 'Specifies the balancing account number that payments on the payment journal are posted to.';

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                CASE GenJnlLine2."Bal. Account Type" OF
                                    GenJnlLine2."Bal. Account Type"::"G/L Account":
                                        IF page.RUNMODAL(0, GLAcc) = ACTION::LookupOK THEN
                                            GenJnlLine2."Bal. Account No." := GLAcc."No.";
                                    GenJnlLine2."Bal. Account Type"::Customer, GenJnlLine2."Bal. Account Type"::Vendor:
                                        ERROR(Text009, GenJnlLine2.FIELDCAPTION("Bal. Account Type"));
                                    GenJnlLine2."Bal. Account Type"::"Bank Account":
                                        IF PAGE.RUNMODAL(0, BankAcc) = ACTION::LookupOK THEN
                                            GenJnlLine2."Bal. Account No." := BankAcc."No.";
                                END;
                            end;

                            trigger OnValidate()
                            begin
                                IF GenJnlLine2."Bal. Account No." <> '' THEN
                                    CASE GenJnlLine2."Bal. Account Type" OF
                                        GenJnlLine2."Bal. Account Type"::"G/L Account":
                                            GLAcc.GET(GenJnlLine2."Bal. Account No.");
                                        GenJnlLine2."Bal. Account Type"::Customer, GenJnlLine2."Bal. Account Type"::Vendor:
                                            ERROR(Text009, GenJnlLine2.FIELDCAPTION("Bal. Account Type"));
                                        GenJnlLine2."Bal. Account Type"::"Bank Account":
                                            BankAcc.GET(GenJnlLine2."Bal. Account No.");
                                    END;
                            end;
                        }
                        field(HnkBankAcc; HnkBankAcc)
                        {
                            ApplicationArea = Basic, Suite;
                            Editable = NOT ShowFilters;
                            TableRelation = "Bank Account"."No.";
                            ToolTip = 'HnkBankAcc';
                            trigger OnValidate()
                            begin
                                //HEI.19>>
                                IF HnkBankAcc <> '' THEN
                                    EnableBankCurr := TRUE
                                ELSE BEGIN
                                    BankCurr := FALSE;
                                    EnableBankCurr := FALSE;
                                END;
                                //HEI.19<<
                            end;
                        }
                        field("Same as Bank Currency"; BankCurr)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Same as Bank Currency';
                            Enabled = EnableBankCurr;
                        }
                        field(BankPaymentType; GenJnlLine2."Bank Payment Type")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bank Payment Type';
                            Editable = NOT ShowFilters;
                            Importance = Additional;
                            OptionCaption = ' ,Computer Check,Manual Check';
                            ToolTip = 'Specifies the check type to be used, if you use Bank Account as the balancing account type.';

                            trigger OnValidate()
                            begin
                                IF (GenJnlLine2."Bal. Account Type" <> GenJnlLine2."Bal. Account Type"::"Bank Account") AND
                                   (GenJnlLine2."Bank Payment Type" > 0)
                                THEN
                                    ERROR(
                                      Text010,
                                      GenJnlLine2.FIELDCAPTION("Bank Payment Type"),
                                      GenJnlLine2.FIELDCAPTION("Bal. Account Type"));
                            end;
                        }
                        field(FAAcquisition; FAAcquisition)
                        {
                            ApplicationArea = ALL;
                            Caption = 'Fixed Asset Acquisition';
                            Description = 'HEI.20';
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            SummarizePerDimTextEnable := TRUE;
            SkipExportedPayments := TRUE;
        end;

        trigger OnOpenPage()
        begin

            IF NOT ShowFilters THEN BEGIN//HEI.12
                LastDueDateToPayReq := WORKDATE();
                PostingDate := WORKDATE();
                ValidatePostingDate();

                //HEI.19>>
                EnableBankCurr := FALSE;
                BankCurr := FALSE;
                //HEI.19<<

                SetDefaults();
            END;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        COMMIT();
        IF NOT VendorLedgEntryTemp.ISEMPTY THEN
            IF CONFIRM(Text024) THEN
                PAGE.RUNMODAL(0, VendorLedgEntryTemp);
    end;

    trigger OnPreReport()
    begin

        CompanyInformation.GET();
        VendorLedgEntryTemp.DELETEALL();
        ShowPostingDateWarning := FALSE;
        //HEI.05>>
        IF CalledFromPaymentJournalTree THEN BEGIN
            SummarizePerVend := TRUE;
            PurchasesPayablesSetup.GET();
            PurchasesPayablesSetup.TESTFIELD("Payment Jnl Archive Nos. FND");
            ArchiveDocumentNo := NoSeriesMgt.GetNextNo(PurchasesPayablesSetup."Payment Jnl Archive Nos. FND", WORKDATE(), TRUE);
            //HEI.13>>
            SourceCodeSetup.GET();
            SourceCodeSetup.TESTFIELD("Payment Journal Tree FND");
            //HEI.13<<
        END;
        //HEI.05<<
    end;

    var
        Text000: Label 'In the Last Payment Date field, specify the last possible date that payments must be made.';
        Text001: Label 'In the Posting Date field, specify the date that will be used as the posting date for the journal entries.';
        Text002: Label 'In the Starting Document No. field, specify the first document number to be used.';
        Text003: Label 'The payment date is earlier than %1.\\Do you still want to run the batch job?', Comment = '%1 is a date';
        Text005: Label 'The batch job was interrupted.';
        Text006: Label 'Processing vendors     #1##########';
        Text007: Label 'Processing vendors for payment discounts #1##########';
        Text008: Label 'Inserting payment journal lines #1##########';
        Text009: Label '%1 must be G/L Account or Bank Account.';
        Text010: Label '%1 must be filled only when %2 is Bank Account.';
        Text011: Label 'Use Vendor Priority must be activated when the value in the Amount Available field is not 0.';
        Text013: Label 'Use Vendor Priority must be activated when the value in the Amount Available Amount (LCY) field is not 0.';
        Text014: Label 'Payment to vendor %1';
        Text015: Label 'Payment of %1 %2';
        Text017: Label 'If %1 = %2 and you have not selected the Summarize per Vendor field,\ then you must select the New Doc. No. per Line.', Comment = 'If Bank Payment Type = Computer Check and you have not selected the Summarize per Vendor field,\ then you must select the New Doc. No. per Line.';
        Text020: Label 'You have only created suggested vendor payment lines for the %1 %2.\ However, there are other open vendor ledger entries in currencies other than %2.\\', Comment = 'You have only created suggested vendor payment lines for the Currency Code EUR.\ However, there are other open vendor ledger entries in currencies other than EUR.';
        Text021: Label 'You have only created suggested vendor payment lines for the %1 %2.\ There are no other open vendor ledger entries in other currencies.\\', Comment = 'You have only created suggested vendor payment lines for the Currency Code EUR\ There are no other open vendor ledger entries in other currencies.\\';
        Text022: Label 'You have created suggested vendor payment lines for all currencies.\\';
        Vend2: Record Vendor;
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        DimSetEntry: Record "Dimension Set Entry";
        GenJnlLine2: Record "Gen. Journal Line";
        VendLedgEntry: Record "Vendor Ledger Entry";
        GLAcc: Record "G/L Account";
        BankAcc: Record "Bank Account";
        PayableVendLedgEntry: Record "Payable Vendor Ledger Entry" temporary;
        CompanyInformation: Record "Company Information";
        TempPaymentBuffer: Record "Vendor Payment Buffer" temporary;
        OldTempPaymentBuffer: Record "Vendor Payment Buffer" temporary;
        SelectedDim: Record "Selected Dimension";
        VendorLedgEntryTemp: Record "Vendor Ledger Entry" temporary;
        TempPaymentBuffer2: Record "Vendor Payment Buffer" temporary;
        // NoSeriesMgt: Codeunit "No. Series - Batch";
        NoSeriesMgt: Codeunit "No. Series";
        DimMgt: Codeunit DimensionManagement;
        DimBufMgt: Codeunit "Dimension Buffer Management";
        Window: Dialog;
        Window2: Dialog;
        UsePaymentDisc: Boolean;
        PostingDate: Date;
        LastDueDateToPayReq: Date;
        NextDocNo: Code[20];
        AmountAvailable: Decimal;
        OriginalAmtAvailable: Decimal;
        UsePriority: Boolean;
        SummarizePerVend: Boolean;
        SummarizePerDim: Boolean;
        SummarizePerDimText: Text[250];
        LastLineNo: Integer;
        NextEntryNo: Integer;
        DueDateOffset: DateFormula;
        UseDueDateAsPostingDate: Boolean;
        StopPayments: Boolean;
        DocNoPerLine: Boolean;
        BankPmtType: Option " ","Computer Check","Manual Check";
        BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account";
        BalAccNo: Code[20];
        MessageText: Text;
        GenJnlLineInserted: Boolean;
        SeveralCurrencies: Boolean;
        Text023: Label ' ,Computer Check,Manual Check';
        Text024: Label 'There are one or more entries for which no payment suggestions have been made because the posting dates of the entries are later than the requested posting date. Do you want to see the entries?';
        [InDataSet]
        SummarizePerDimTextEnable: Boolean;
        Text025: Label 'The %1 with the number %2 has a %3 with the number %4.';
        ShowPostingDateWarning: Boolean;
        VendorBalance: Decimal;
        ReplacePostingDateMsg: Label 'For one or more entries, the requested posting date is before the work date.\\These posting dates will use the work date.';
        PmtDiscUnavailableErr: Label 'You cannot use Find Payment Discounts or Summarize per Vendor together with Calculate Posting Date from Applies-to-Doc. Due Date, because the resulting posting date might not match the payment discount date.';
        SkipExportedPayments: Boolean;
        MessageToRecipientMsg: Label 'Payment of %1 %2 ', Comment = '%1 document type, %2 Document No.';
        StartingDocumentNoErr: Label 'Starting Document No.';
        //ServPurchPostJnl: Codeunit "2034910";
        ContractNo: Code[20];
        HeinekenGlobal: Codeunit "Heineken Global";
        PurchInvHeader: Record "Purch. Inv. Header";
        vend: Record Vendor;
        paymentmethod: Record "Payment Method";
        paymethcode: Code[10];
        CheckConstant: Label 'INCLUDED IN PAYMENT PROPOSAL';
        GenJournalBatch: Record "Gen. Journal Batch";
        Return: Boolean;
        [InDataSet]
        CalledFromPaymentJournalTree: Boolean;
        ArchiveDocumentNo: Code[20];
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        GenJnlLineToArchive: Record "Gen. Journal Line Archive FND";
        HnkBankAcc: Code[20];
        ExecutionDate: Date;
        [InDataSet]
        ShowFilters: Boolean;
        SourceCodeSetup: Record "Source Code Setup";
        BankCurr: Boolean;
        [InDataSet]
        EnableBankCurr: Boolean;
        FAAcquisition: Boolean;
        WHTEntry: Record "WHT Entry FND";
        Text102: Label 'Processing WHT posting groups     #1##########';
        Text103: Label 'Invoice %1 has different WHT %4 Posting Groups on lines : %2 and %3';

    procedure SetGenJnlLine(NewGenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine := NewGenJnlLine;
    end;

    local procedure ValidatePostingDate()
    begin
        IF GenJnlBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name") THEN;//HEI.12
        IF NOT ShowFilters THEN BEGIN//HEI.12
                                     //>>HEI.24
            IF GenJnlBatch."Bank Payment Type FND" = GenJnlBatch."Bank Payment Type FND"::"Computer Check" THEN BEGIN
                BankAcc.RESET;
                BankAcc.SETRANGE("No.", GenJnlBatch."HNK Bank Account FND");
                IF BankAcc.FINDFIRST THEN
                    NextDocNo := INCSTR(BankAcc."Last Check No.");
            END ELSE//<<HEI.24
                IF GenJnlBatch."No. Series" = '' THEN
                    NextDocNo := ''
                ELSE BEGIN
                    // NextDocNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", PostingDate, FALSE);
                    NextDocNo := NoSeriesMgt.PeekNextNo(GenJnlBatch."No. Series", PostingDate); // BC Upgrade BHARDA11 ::Added
                    CLEAR(NoSeriesMgt);
                END;
        END;
    end;

    //[Scope('Internal')]
    procedure InitializeRequest(LastPmtDate: Date; FindPmtDisc: Boolean; NewAvailableAmount: Decimal; NewSkipExportedPayments: Boolean; NewPostingDate: Date; NewStartDocNo: Code[20]; NewSummarizePerVend: Boolean; BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account"; BalAccNo: Code[20]; BankPmtType: Option " ","Computer Check","Manual Check")
    begin
        LastDueDateToPayReq := LastPmtDate;
        UsePaymentDisc := FindPmtDisc;
        AmountAvailable := NewAvailableAmount;
        SkipExportedPayments := NewSkipExportedPayments;
        PostingDate := NewPostingDate;
        NextDocNo := NewStartDocNo;
        SummarizePerVend := NewSummarizePerVend;
        GenJnlLine2."Bal. Account Type" := BalAccType;
        GenJnlLine2."Bal. Account No." := BalAccNo;
        GenJnlLine2."Bank Payment Type" := BankPmtType;
    end;

    local procedure GetVendLedgEntries(Positive: Boolean; Future: Boolean)
    var
        TempVendLedgerEntryNo: Record "Vendor Ledger Entry" temporary;
    begin
        VendLedgEntry.RESET;
        //HEI.06>>
        //<< DITW110.00.11 AKH 29/08/2017 NRQ#17902
        IF VendorLedgerEntriesFilter.GETFILTERS() <> '' THEN
            VendLedgEntry.COPYFILTERS(VendorLedgerEntriesFilter);
        //>> DITW110.00.11 AKH NRQ#17902
        //DITW17.00.02 SR 19/12/2013 DIT-770 #163
        // BC Upgrade - RD03  Drinkit Fields -- >>
        IF Vendor.GETFILTER("Vendor Posting Group") <> '' THEN
            VendLedgEntry.SETFILTER("Vendor Posting Group", Vendor.GETFILTER("Vendor Posting Group"));
        // BC Upgrade - RD03  Drinkit Fields -- <<
        //DITW17.00.02 SR DIT-770 #163
        //HEI.06<<
        VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive, "Due Date");

        //HEI.15 comment line VendLedgEntry.SETRANGE("Vendor No.",Vendor."No.");
        //HEI.15>>
        IF VendLedgEntry.GETFILTER("Vendor No.") = '' THEN
            VendLedgEntry.SETRANGE("Vendor No.", Vendor."No.")
        ELSE
            VendLedgEntry.SETFILTER("Vendor No.", VendLedgEntry.GETFILTER("Vendor No.") + '&' + Vendor."No.");
        //HEI.15<<

        VendLedgEntry.SETRANGE(Open, TRUE);
        VendLedgEntry.SETRANGE(Positive, Positive);
        VendLedgEntry.SETRANGE("Applies-to ID", '');
        /// DITW110.00.11 MSF 25/08/2017 NRQ#17902 - DITW110.00.11 AKH 29/08/2017 NRQ#17902
        IF Future THEN BEGIN
            VendLedgEntry.SETRANGE("Due Date", LastDueDateToPayReq + 1, DMY2DATE(31, 12, 9999));
            VendLedgEntry.SETRANGE("Pmt. Discount Date", PostingDate, LastDueDateToPayReq);
            VendLedgEntry.SETFILTER("Remaining Pmt. Disc. Possible", '<>0');
        END ELSE
            VendLedgEntry.SETRANGE("Due Date", 0D, LastDueDateToPayReq);
        IF SkipExportedPayments THEN
            VendLedgEntry.SETRANGE("Exported to Payment File", FALSE);
        VendLedgEntry.SETRANGE("On Hold", '');
        IF VendLedgEntry.GETFILTER("Currency Code") = '' THEN       //HEI.22
            VendLedgEntry.SETFILTER("Currency Code", Vendor.GETFILTER("Currency Filter"));
        VendLedgEntry.SETFILTER("Global Dimension 1 Code", Vendor.GETFILTER("Global Dimension 1 Filter"));
        VendLedgEntry.SETFILTER("Global Dimension 2 Code", Vendor.GETFILTER("Global Dimension 2 Filter"));
        VendLedgEntry.SETRANGE("Fixed Asset Acquisition FND", FAAcquisition); //HEI.20

        IF VendLedgEntry.FIND('-') THEN
            REPEAT
                //<<HEI.02/HEI.04
                //WHT those invoices with WHT Entry
                //  IF ("WHT Posting Setup"."WHT Business Posting Group" <> '') OR ("WHT Posting Setup"."WHT Product Posting Group" <> '' ) THEN BEGIN
                WHTEntry.RESET;
                WHTEntry.SETRANGE("Bill-to/Pay-to No.", Vendor."No.");
                WHTEntry.SETRANGE("Document Type", VendLedgEntry."Document Type");
                WHTEntry.SETRANGE("Document No.", VendLedgEntry."Document No.");
                WHTEntry.SETRANGE("WHT Bus. Posting Group", "WHT Posting Setup FND"."WHT Business Posting Group");
                WHTEntry.SETRANGE("WHT Prod. Posting Group", "WHT Posting Setup FND"."WHT Product Posting Group");
                IF WHTEntry.FINDFIRST THEN BEGIN
                    Return := HeinekenGlobal.ValidatePaymentProposalLines(VendLedgEntry, GenJnlLine);
                    //HEI.10>>
                    PurchasesPayablesSetup.GET;
                    // BC Upgrade - RD03 Drinkit fields -- >>
                    IF VendLedgEntry."Document Subtype Code FND" = PurchasesPayablesSetup."PO Subtype Code FND" THEN BEGIN
                        IF VendLedgEntry."Payment Status FND" = VendLedgEntry."Payment Status FND"::"Pending Review" THEN
                            Return := FALSE;
                    END;
                    // BC Upgrade - RD03 Drinkit fields -- <<
                    //HEI.10<<
                    IF Return THEN BEGIN
                        //>>HEI.02
                        SaveAmount;
                        //HEI.01>>
                        //HeinekenGlobal.UpdatePaymentProposal(VendLedgEntry,GenJnlLine."Journal Batch Name"); //this one updates Batch payment name HEI.16
                    END;//HEI.01<<
                    IF VendLedgEntry."Accepted Pmt. Disc. Tolerance" OR (VendLedgEntry."Accepted Payment Tolerance" <> 0) THEN BEGIN
                        MESSAGE(VendLedgEntry."Document No.");
                        VendLedgEntry."Accepted Pmt. Disc. Tolerance" := FALSE;
                        VendLedgEntry."Accepted Payment Tolerance" := 0;
                        CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);  //this one validates Reason Code
                    END;
                END;

                //for those without WHT Entry. They are all grouped in one payment parent
                WHTEntry.RESET;
                WHTEntry.SETRANGE("Bill-to/Pay-to No.", Vendor."No.");
                WHTEntry.SETRANGE("Document Type", VendLedgEntry."Document Type");
                WHTEntry.SETRANGE("Document No.", VendLedgEntry."Document No.");
                IF (NOT WHTEntry.FINDFIRST) AND ("WHT Posting Setup FND"."WHT %" = 0) THEN BEGIN
                    Return := HeinekenGlobal.ValidatePaymentProposalLines(VendLedgEntry, GenJnlLine);
                    //HEI.10>>
                    PurchasesPayablesSetup.GET;
                    // BC Upgrade - RD03 Drinkit fields -- >>
                    IF VendLedgEntry."Document Subtype Code FND" = PurchasesPayablesSetup."PO Subtype Code FND" THEN BEGIN
                        IF VendLedgEntry."Payment Status FND" = VendLedgEntry."Payment Status FND"::"Pending Review" THEN
                            Return := FALSE;
                    END;
                    // BC Upgrade - RD03 Drinkit fields -- <<
                    //HEI.10<<
                    IF Return THEN BEGIN
                        //>>HEI.02
                        SaveAmount;
                        //HEI.01>>
                        //HeinekenGlobal.UpdatePaymentProposal(VendLedgEntry,GenJnlLine."Journal Batch Name"); //this one updates Batch payment name HEI.16
                    END;//HEI.01<<
                    IF VendLedgEntry."Accepted Pmt. Disc. Tolerance" OR (VendLedgEntry."Accepted Payment Tolerance" <> 0) THEN BEGIN
                        MESSAGE(VendLedgEntry."Document No.");
                        VendLedgEntry."Accepted Pmt. Disc. Tolerance" := FALSE;
                        VendLedgEntry."Accepted Payment Tolerance" := 0;
                        CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);  //this one validates Reason Code
                    END;
                END;
            UNTIL VendLedgEntry.NEXT = 0;
    end;

    local procedure SaveAmount()
    var
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        WHTEntry: Record "WHT Entry FND";
    begin
        GenJnlLine.INIT;

        SetPostingDate(GenJnlLine, VendLedgEntry."Due Date", PostingDate);
        GenJnlLine."Execution Date FND" := ExecutionDate;//HEI.12
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
        Vend2.GET(VendLedgEntry."Vendor No.");
        Vend2.CheckBlockedVendOnJnls(Vend2, GenJnlLine."Document Type", FALSE);
        GenJnlLine.Description := Vend2.Name;

        GenJnlLine."Posting Group" := Vend2."Vendor Posting Group";
        GenJnlLine."Salespers./Purch. Code" := Vend2."Purchaser Code";
        GenJnlLine."Payment Terms Code" := Vend2."Payment Terms Code";
        //HEI.23<<
        GenJnlLine.UpdateHNKBankAccount(HnkBankAcc);
        //HEi.23>>
        GenJnlLine.VALIDATE("Bill-to/Pay-to No.", GenJnlLine."Account No.");
        GenJnlLine.VALIDATE("Sell-to/Buy-from No.", GenJnlLine."Account No.");
        GenJnlLine."Gen. Posting Type" := 0;
        GenJnlLine."Gen. Bus. Posting Group" := '';
        GenJnlLine."Gen. Prod. Posting Group" := '';
        GenJnlLine."VAT Bus. Posting Group" := '';
        GenJnlLine."VAT Prod. Posting Group" := '';
        GenJnlLine.VALIDATE("Currency Code", VendLedgEntry."Currency Code");
        GenJnlLine.VALIDATE("Payment Terms Code");
        VendLedgEntry.CALCFIELDS("Remaining Amount");
        IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(GenJnlLine, VendLedgEntry, 0, FALSE) THEN
            GenJnlLine.Amount := -(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible")
        ELSE
            GenJnlLine.Amount := -VendLedgEntry."Remaining Amount";
        GenJnlLine.VALIDATE(Amount);
        // BC Upgrade - RD03 Drinkit Fields -- >>
        // <<DITW16.00.00.43 DDR 09/08/2013 DIT-715 #714
        // "Contract Type" := VendLedgEntry."Contract Type";
        // "Service Contract Line No." := VendLedgEntry."Service Contract Line No.";
        // "DIT Sub-Contract Type" := VendLedgEntry."DIT Sub-Contract Type";
        // "Service Contract No." := VendLedgEntry."Service Contract No.";
        // //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        // "Financial Contract No." := VendLedgEntry."Financial Contract No.";
        // //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        // "Building No." := VendLedgEntry."Building No.";
        // "Contract Group Code" := VendLedgEntry."Contract Group Code";
        // //>>DITW17.10.03 MSF 06/05/2014 DIT-770 #340
        // //IF "DIT Sub-Contract Type" <> 0 THEN
        // //  "Posting Group" := ServPurchPostJnl.GetSourcePostGroupService(Vend2."No.","DIT Sub-Contract Type");
        // // >>DITW16.00.00.43 DDR DIT-715 #714
        GenJnlLine."Posting Group" := VendLedgEntry."Vendor Posting Group";
        // //<<DITW17.10.03 MSF 06/05/2014 DIT-770 #340
        // //<<DITW110.00.11 MSF 25/08/2017 NRQ#17902
        // "Route Planning No." := VendLedgEntry."Route Planning No.";
        GenJnlLine."Document Subtype Code FND" := VendLedgEntry."Document Subtype Code FND";
        //>>DITW110.00.11 MSF 25/08/2017 NRQ#17902
        // BC Upgrade - RD03 Drinkit Fields -- <<
        IF UsePriority THEN
            PayableVendLedgEntry.Priority := Vendor.Priority
        ELSE
            PayableVendLedgEntry.Priority := 0;
        PayableVendLedgEntry."Vendor No." := VendLedgEntry."Vendor No.";
        PayableVendLedgEntry."Entry No." := NextEntryNo;
        PayableVendLedgEntry."Vendor Ledg. Entry No." := VendLedgEntry."Entry No.";
        PayableVendLedgEntry.Amount := GenJnlLine.Amount;
        PayableVendLedgEntry."Amount (LCY)" := GenJnlLine."Amount (LCY)";
        PayableVendLedgEntry.Positive := (PayableVendLedgEntry.Amount > 0);
        PayableVendLedgEntry.Future := (VendLedgEntry."Due Date" > LastDueDateToPayReq);
        PayableVendLedgEntry."Currency Code" := VendLedgEntry."Currency Code";
        // <<DITW16.00.00.43 DDR 09/08/2013 DIT-715 #714
        // BC Upgrade - RD03 Drinkit Fields -- >>
        // PayableVendLedgEntry."Contract Type" := VendLedgEntry."Contract Type";
        // PayableVendLedgEntry."Service Contract Line No." := VendLedgEntry."Service Contract Line No.";
        // PayableVendLedgEntry."DIT Sub-Contract Type" := VendLedgEntry."DIT Sub-Contract Type";
        // PayableVendLedgEntry."Service Contract No." := VendLedgEntry."Service Contract No.";
        // PayableVendLedgEntry."Building No." := VendLedgEntry."Building No.";
        // PayableVendLedgEntry."Contract Group Code" := VendLedgEntry."Contract Group Code";
        // // >>DITW16.00.00.43 DDR DIT-715 #714
        // //<<DITW110.00.11 MSF 15/11/2017 NRQ#45760
        // PayableVendLedgEntry."Financial Contract No." := VendLedgEntry."Financial Contract No.";
        // //>>DITW110.00.11 MSF 15/11/2017 NRQ#45760
        // //<<DITW17.10.03 MSF 06/05/2014 DIT-770 #340
        PayableVendLedgEntry."Vendor Posting Group 101FDW" := VendLedgEntry."Vendor Posting Group";
        //>>DITW17.10.03 MSF 06/05/2014 DIT-770 #340
        // BC Upgrade - RD03 Drinkit Fields -- <<

        PayableVendLedgEntry.INSERT;
        NextEntryNo := NextEntryNo + 1;
    end;

    local procedure CheckAmounts(Future: Boolean)
    var
        CurrencyBalance: Decimal;
        PrevCurrency: Code[10];
    begin
        PayableVendLedgEntry.SETRANGE("Vendor No.", Vendor."No.");
        PayableVendLedgEntry.SETRANGE(Future, Future);
        //OriginalAmtAvailable := 0; //ipo
        IF PayableVendLedgEntry.FIND('-') THEN BEGIN
            REPEAT
                IF PayableVendLedgEntry."Currency Code" <> PrevCurrency THEN BEGIN
                    IF CurrencyBalance > 0 THEN
                        AmountAvailable := AmountAvailable - CurrencyBalance;
                    CurrencyBalance := 0;
                    PrevCurrency := PayableVendLedgEntry."Currency Code";
                END;
                IF (OriginalAmtAvailable = 0) OR
                   (AmountAvailable >= CurrencyBalance + PayableVendLedgEntry."Amount (LCY)")
                THEN
                    CurrencyBalance := CurrencyBalance + PayableVendLedgEntry."Amount (LCY)"
                ELSE
                    PayableVendLedgEntry.DELETE();
            UNTIL PayableVendLedgEntry.NEXT() = 0;
            IF OriginalAmtAvailable > 0 THEN
                AmountAvailable := AmountAvailable - CurrencyBalance;
            IF (OriginalAmtAvailable > 0) AND (AmountAvailable <= 0) THEN
                StopPayments := TRUE;
        END;
        PayableVendLedgEntry.RESET();
    end;

    local procedure MakeGenJnlLines()
    var
        GenJnlLine1: Record "Gen. Journal Line";
        DimBuf: Record "Dimension Buffer";
        Vendor: Record Vendor;
        RemainingAmtAvailable: Decimal;
        SourceCodeSetup: Record "Source Code Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        WHTEntry: Record "WHT Entry FND";
        WHTBus: Code[10];
        WHTProd: Code[10];
        lGenJournalLine: Record "Gen. Journal Line";
    begin
        TempPaymentBuffer.RESET;
        TempPaymentBuffer.DELETEALL;
        IF BalAccType = BalAccType::"Bank Account" THEN BEGIN
            CheckCurrencies(BalAccType, BalAccNo, PayableVendLedgEntry);
            SetBankAccCurrencyFilter(BalAccType, BalAccNo, PayableVendLedgEntry);
        END;

        IF OriginalAmtAvailable <> 0 THEN BEGIN
            RemainingAmtAvailable := OriginalAmtAvailable;
            RemovePaymentsAboveLimit(PayableVendLedgEntry, RemainingAmtAvailable);
        END;
        IF PayableVendLedgEntry.FIND('-') THEN
            REPEAT
                PayableVendLedgEntry.SETRANGE("Vendor No.", PayableVendLedgEntry."Vendor No.");
                PayableVendLedgEntry.FIND('-');
                REPEAT
                    VendLedgEntry.GET(PayableVendLedgEntry."Vendor Ledg. Entry No.");
                    SetPostingDate(GenJnlLine1, VendLedgEntry."Due Date", PostingDate);
                    //IF Checkif then
                    //IF NOT CheckIfTheInvoiceHasDiffWHTGroups(VendLedgEntry."Document No.", "WHT Posting Setup"."WHT Business Posting Group", "WHT Posting Setup"."WHT Product Posting Group") THEN BEGIN
                    IF VendLedgEntry."Posting Date" <= GenJnlLine1."Posting Date" THEN BEGIN
                        TempPaymentBuffer."Vendor No." := VendLedgEntry."Vendor No.";
                        TempPaymentBuffer."Fixed Asset Acquisition FND" := VendLedgEntry."Fixed Asset Acquisition FND"; //HEI.20
                                                                                                                        //HEI.19>>
                        IF BankCurr THEN BEGIN
                            BankAcc.GET(HnkBankAcc);
                            TempPaymentBuffer."Currency Code" := BankAcc."Currency Code";
                            IF TempPaymentBuffer."Currency Code" <> VendLedgEntry."Currency Code" THEN BEGIN
                                PayableVendLedgEntry.Amount :=
                                  CurrExchRate.ExchangeAmtFCYToFCY(
                                    PostingDate, PayableVendLedgEntry."Currency Code", TempPaymentBuffer."Currency Code", PayableVendLedgEntry.Amount);
                                VendLedgEntry."Remaining Amount" :=
                                  CurrExchRate.ExchangeAmtFCYToFCY(
                                    PostingDate, VendLedgEntry."Currency Code", TempPaymentBuffer."Currency Code", VendLedgEntry."Remaining Amount");
                            END;
                        END ELSE
                            //HEI.19<<
                            TempPaymentBuffer."Currency Code" := VendLedgEntry."Currency Code";
                        TempPaymentBuffer."Payment Method Code" := VendLedgEntry."Payment Method Code";
                        TempPaymentBuffer."Creditor No." := VendLedgEntry."Creditor No.";
                        TempPaymentBuffer."Payment Reference" := VendLedgEntry."Payment Reference";
                        TempPaymentBuffer."Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                        TempPaymentBuffer."Applies-to Ext. Doc. No." := VendLedgEntry."External Document No.";
                        // <<DITW16.00.00.43 DDR 09/08/2013 DIT-715 #714
                        // BC Upgrade - RD03 Drinkit fields --<<
                        // TempPaymentBuffer."Contract Type" := VendLedgEntry."Contract Type";
                        // TempPaymentBuffer."Service Contract Line No." := VendLedgEntry."Service Contract Line No.";
                        // TempPaymentBuffer."DIT Sub-Contract Type" := VendLedgEntry."DIT Sub-Contract Type";
                        // TempPaymentBuffer."Service Contract No." := VendLedgEntry."Service Contract No.";
                        // TempPaymentBuffer."Building No." := VendLedgEntry."Building No.";
                        // TempPaymentBuffer."Contract Group Code" := VendLedgEntry."Contract Group Code";
                        // // >>DITW16.00.00.43 DDR DIT-715 #714
                        // //<<DITW110.00.11 MSF 15/11/2017 NRQ#45760
                        // TempPaymentBuffer."Financial Contract No." := VendLedgEntry."Financial Contract No.";
                        // //>>DITW110.00.11 MSF 15/11/2017 NRQ#45760
                        // //<<DITW17.10.03 MSF 06/05/2014 DIT-770 #340
                        // TempPaymentBuffer."Posting Group" := VendLedgEntry."Vendor Posting Group";
                        // //>>DITW17.10.03 MSF 06/05/2014 DIT-770 #340
                        // //HEI.05>>
                        // TempPaymentBuffer."Vendor Bank Account" := VendLedgEntry."Vendor Bank Account";
                        // //HEI.05<<
                        // //<<DITW110.00.11 AKH 29/08/2017 NRQ#17902
                        // TempPaymentBuffer."Route Planning No." := VendLedgEntry."Route Planning No.";
                        // TempPaymentBuffer."Document Subtype Code" := VendLedgEntry."Document Subtype Code";
                        // BC Upgrade - RD03 Drinkit fields --<<
                        //>>DITW110.00.11 AKH NRQ#17902
                        SetTempPaymentBufferDims(DimBuf);

                        VendLedgEntry.CALCFIELDS("Remaining Amount");

                        IF SummarizePerVend THEN BEGIN
                            TempPaymentBuffer."Vendor Ledg. Entry No." := 0;
                            IF TempPaymentBuffer.FIND THEN BEGIN
                                TempPaymentBuffer.Amount := TempPaymentBuffer.Amount + PayableVendLedgEntry.Amount;
                                //HEI.09>>
                                IF CalledFromPaymentJournalTree THEN
                                    TempPaymentBuffer."Applies-to Ext. Doc. No." := VendLedgEntry."External Document No.";
                                //HEI.09<<
                                // <<DITW16.00.00.43 DDR 09/08/2013 DIT-715 #714
                                // BC Upgrade - RD03 Drinkit fields -->>
                                // IF TempPaymentBuffer."Contract Type" <> VendLedgEntry."Contract Type" THEN
                                //     TempPaymentBuffer."Contract Type" := 0;
                                // IF TempPaymentBuffer."Service Contract Line No." <> VendLedgEntry."Service Contract Line No." THEN
                                //     TempPaymentBuffer."Service Contract Line No." := 0;
                                // IF TempPaymentBuffer."DIT Sub-Contract Type" <> VendLedgEntry."DIT Sub-Contract Type" THEN
                                //     TempPaymentBuffer."DIT Sub-Contract Type" := 0;
                                // IF TempPaymentBuffer."Service Contract No." <> VendLedgEntry."Service Contract No." THEN
                                //     TempPaymentBuffer."Service Contract No." := '';
                                // IF TempPaymentBuffer."Building No." <> VendLedgEntry."Building No." THEN
                                //     TempPaymentBuffer."Building No." := '';
                                // IF TempPaymentBuffer."Contract Group Code" <> VendLedgEntry."Contract Group Code" THEN
                                //     TempPaymentBuffer."Contract Group Code" := '';
                                //<<DITW110.00.11 MSF 15/11/2017 NRQ#45760
                                // IF TempPaymentBuffer."Financial Contract No." <> VendLedgEntry."Financial Contract No." THEN
                                //     TempPaymentBuffer."Financial Contract No." := '';
                                //>>DITW110.00.11 MSF 15/11/2017 NRQ#45760
                                // >>DITW16.00.00.43 DDR DIT-715 #714
                                //<<DITW17.10.03 MSF 06/05/2014 DIT-770 #340
                                // IF TempPaymentBuffer."Posting Group" <> VendLedgEntry."Vendor Posting Group" THEN
                                //     TempPaymentBuffer."Posting Group" := '';
                                //>>DITW17.10.03 MSF 06/05/2014 DIT-770 #340
                                //<<DITW110.00.11 AKH 29/08/2017 NRQ#17902
                                // IF TempPaymentBuffer."Route Planning No." <> VendLedgEntry."Route Planning No." THEN
                                //     TempPaymentBuffer."Route Planning No." := '';
                                IF TempPaymentBuffer."Document Subtype Code FND" <> VendLedgEntry."Document Subtype Code FND" THEN
                                    TempPaymentBuffer."Document Subtype Code FND" := '';
                                // BC Upgrade - RD03 Drinkit fields --<<
                                //>>DITW110.00.11 AKH NRQ#17902
                                TempPaymentBuffer.MODIFY;
                            END ELSE BEGIN
                                TempPaymentBuffer."Document No." := NextDocNo;
                                RunIncrementDocumentNo(false);//ATHUKS01
                                // NextDocNo := INCSTR(NextDocNo); ?? BC Upgrade BHARDA11 :: Blocked
                                TempPaymentBuffer.Amount := PayableVendLedgEntry.Amount;
                                Window2.UPDATE(1, VendLedgEntry."Vendor No.");
                                TempPaymentBuffer.INSERT;
                            END;
                            //HEI.05>>
                            IF CalledFromPaymentJournalTree THEN
                                HeinekenGlobal.SuggestPaymentVendorCreatePaymentBuffer(TempPaymentBuffer, TempPaymentBuffer2, VendLedgEntry, PayableVendLedgEntry.Amount);
                            //HEI.05<<
                            VendLedgEntry."Applies-to ID" := TempPaymentBuffer."Document No.";
                            HeinekenGlobal.UpdatePaymentProposal(VendLedgEntry, GenJnlLine."Journal Batch Name"); //HEI.16
                        END ELSE
                            IF NOT IsEntryAlreadyApplied(GenJnlLine, VendLedgEntry) THEN BEGIN
                                TempPaymentBuffer."Vendor Ledg. Entry Doc. Type" := VendLedgEntry."Document Type";
                                TempPaymentBuffer."Vendor Ledg. Entry Doc. No." := VendLedgEntry."Document No.";
                                TempPaymentBuffer."Global Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code";
                                TempPaymentBuffer."Global Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code";
                                TempPaymentBuffer."Dimension Set ID" := VendLedgEntry."Dimension Set ID";
                                TempPaymentBuffer."Vendor Ledg. Entry No." := VendLedgEntry."Entry No.";
                                TempPaymentBuffer.Amount := PayableVendLedgEntry.Amount;
                                Window2.UPDATE(1, VendLedgEntry."Vendor No.");
                                TempPaymentBuffer.INSERT;
                            END;

                        VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
                        //HEI.01>>
                        //HeinekenGlobal.UpdatePaymentProposal(VendLedgEntry,GenJnlLine."Journal Batch Name");
                        //HEI.01<<
                        CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);

                    END ELSE BEGIN
                        VendorLedgEntryTemp := VendLedgEntry;
                        VendorLedgEntryTemp.INSERT;
                    END;
                    //END;
                    //end checkif
                    PayableVendLedgEntry.DELETE;
                    IF OriginalAmtAvailable <> 0 THEN BEGIN
                        RemainingAmtAvailable := RemainingAmtAvailable - PayableVendLedgEntry."Amount (LCY)";
                        RemovePaymentsAboveLimit(PayableVendLedgEntry, RemainingAmtAvailable);
                    END;

                UNTIL NOT PayableVendLedgEntry.FINDSET;
                PayableVendLedgEntry.DELETEALL;
                PayableVendLedgEntry.SETRANGE("Vendor No.");
            UNTIL NOT PayableVendLedgEntry.FIND('-');

        CLEAR(OldTempPaymentBuffer);
        TempPaymentBuffer.SETCURRENTKEY("Document No.");
        TempPaymentBuffer.SETFILTER(
          "Vendor Ledg. Entry Doc. Type", '<>%1&<>%2', TempPaymentBuffer."Vendor Ledg. Entry Doc. Type"::Refund,
          TempPaymentBuffer."Vendor Ledg. Entry Doc. Type"::Payment);
        IF TempPaymentBuffer.FIND('-') THEN
            REPEAT
                GenJnlLine.INIT;
                Window2.UPDATE(1, TempPaymentBuffer."Vendor No.");
                LastLineNo := LastLineNo + 10000;
                GenJnlLine."Line No." := LastLineNo;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Posting No. Series" := GenJnlBatch."Posting No. Series";
                IF SummarizePerVend THEN
                    GenJnlLine."Document No." := TempPaymentBuffer."Document No."
                ELSE
                    IF DocNoPerLine THEN BEGIN
                        IF TempPaymentBuffer.Amount < 0 THEN
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund;

                        GenJnlLine."Document No." := NextDocNo;
                        RunIncrementDocumentNo(false);
                        //Added
                        // NextDocNo := INCSTR(NextDocNo); // Blocked
                    END ELSE
                        IF (TempPaymentBuffer."Vendor No." = OldTempPaymentBuffer."Vendor No.") AND
                           (TempPaymentBuffer."Currency Code" = OldTempPaymentBuffer."Currency Code")
                        THEN
                            GenJnlLine."Document No." := OldTempPaymentBuffer."Document No."
                        ELSE BEGIN
                            GenJnlLine."Document No." := NextDocNo;
                            RunIncrementDocumentNo(false);
                            //Added
                            // NextDocNo := INCSTR(NextDocNo); //Blocked
                            OldTempPaymentBuffer := TempPaymentBuffer;
                            OldTempPaymentBuffer."Document No." := GenJnlLine."Document No.";
                        END;
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                GenJnlLine.SetHideValidation(TRUE);
                ShowPostingDateWarning := ShowPostingDateWarning OR
                  SetPostingDate(GenJnlLine, GetApplDueDate(TempPaymentBuffer."Vendor Ledg. Entry No."), PostingDate);
                GenJnlLine.VALIDATE("Account No.", TempPaymentBuffer."Vendor No.");
                Vendor.GET(TempPaymentBuffer."Vendor No.");
                IF (Vendor."Pay-to Vendor No." <> '') AND (Vendor."Pay-to Vendor No." <> GenJnlLine."Account No.") THEN
                    MESSAGE(Text025, Vendor.TABLECAPTION, Vendor."No.", Vendor.FIELDCAPTION("Pay-to Vendor No."),
                      Vendor."Pay-to Vendor No.");
                GenJnlLine."Bal. Account Type" := BalAccType;
                GenJnlLine.VALIDATE("Bal. Account No.", BalAccNo);
                GenJnlLine.VALIDATE("Currency Code", TempPaymentBuffer."Currency Code");
                GenJnlLine."Message to Recipient" := GetMessageToRecipient(SummarizePerVend);
                //HEI.18>>
                IF SummarizePerVend THEN
                    GenJnlLine."Message to Recipient" += ' ' + GenJnlLine."Document No.";
                //HEI.18<<
                GenJnlLine."Bank Payment Type" := BankPmtType;
                IF SummarizePerVend THEN BEGIN
                    GenJnlLine."Applies-to ID" := GenJnlLine."Document No.";
                    GenJnlLine.Description := STRSUBSTNO(Text014, TempPaymentBuffer."Vendor No.");
                END ELSE
                    GenJnlLine.Description :=
                      STRSUBSTNO(
                        Text015,
                        TempPaymentBuffer."Vendor Ledg. Entry Doc. Type",
                        TempPaymentBuffer."Vendor Ledg. Entry Doc. No.");
                GenJnlLine."Source Line No." := TempPaymentBuffer."Vendor Ledg. Entry No.";
                GenJnlLine."Shortcut Dimension 1 Code" := TempPaymentBuffer."Global Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := TempPaymentBuffer."Global Dimension 2 Code";
                GenJnlLine."Dimension Set ID" := TempPaymentBuffer."Dimension Set ID";
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                GenJnlLine."Reason Code" := GenJnlBatch."Reason Code";
                GenJnlLine.VALIDATE(Amount, TempPaymentBuffer.Amount);
                GenJnlLine."Applies-to Doc. Type" := TempPaymentBuffer."Vendor Ledg. Entry Doc. Type";
                GenJnlLine."Applies-to Doc. No." := TempPaymentBuffer."Vendor Ledg. Entry Doc. No.";
                GenJnlLine."Payment Method Code" := TempPaymentBuffer."Payment Method Code";
                GenJnlLine."Creditor No." := TempPaymentBuffer."Creditor No.";
                GenJnlLine."Payment Reference" := TempPaymentBuffer."Payment Reference";
                GenJnlLine."Exported to Payment File" := TempPaymentBuffer."Exported to Payment File";
                IF NOT CalledFromPaymentJournalTree THEN //HEI.09
                    GenJnlLine."Applies-to Ext. Doc. No." := TempPaymentBuffer."Applies-to Ext. Doc. No.";
                // <<DITW16.00.00.43 DDR 09/08/2013 DIT-715 #714
                // BC Upgrade - RD03 Drinkit fields -->>
                // "Contract Type" := TempPaymentBuffer."Contract Type";
                // "Service Contract Line No." := TempPaymentBuffer."Service Contract Line No.";
                // "DIT Sub-Contract Type" := TempPaymentBuffer."DIT Sub-Contract Type";
                // "Service Contract No." := TempPaymentBuffer."Service Contract No.";
                // "Building No." := TempPaymentBuffer."Building No.";
                // "Contract Group Code" := TempPaymentBuffer."Contract Group Code";
                // //<<DITW110.00.11 MSF 15/11/2017 NRQ#45760
                // "Financial Contract No." := TempPaymentBuffer."Financial Contract No.";
                //>>DITW110.00.11 MSF 15/11/2017 NRQ#45760
                //IF "DIT Sub-Contract Type" <> 0 THEN
                //   "Posting Group" := ServPurchPostJnl.GetSourcePostGroupService("Account No.","DIT Sub-Contract Type");
                // >>DITW16.00.00.43 DDR DIT-715 #714
                //<<DITW17.10.03 MSF 06/05/2014 DIT-770 #340
                // GenJnlLine."Posting Group" := TempPaymentBuffer."Posting Group";
                //>>DITW17.10.03 MSF 06/05/2014 DIT-770 #340
                //<<DITW110.00.11 AKH 29/08/2017 NRQ#17902
                // "Route Planning No." := TempPaymentBuffer."Route Planning No.";
                GenJnlLine."Document Subtype Code FND" := TempPaymentBuffer."Document Subtype Code FND";
                //>>DITW110.00.11 AKH NRQ#17902
                //HEI.05>>
                GenJnlLine."Vendor Bank Account FND" := TempPaymentBuffer."Vendor Bank Account FND";
                //HEI.18>>
                GenJnlLine."Customer/Vendor Bank FND" := GenJnlLine."Vendor Bank Account FND";
                //HEI.18<<
                GenJnlLine."Archive Document No. FND" := ArchiveDocumentNo;
                // BC Upgrade - RD03 Drinkit fields --<<
                //HEI.05<<
                //WHT //parent
                IF "WHT Posting Setup FND"."WHT %" <> 0 THEN BEGIN
                    GenJnlLine.VALIDATE("WHT Business Posting Group FND", "WHT Posting Setup FND"."WHT Business Posting Group");
                    GenJnlLine.VALIDATE("WHT Product Posting Group FND", "WHT Posting Setup FND"."WHT Product Posting Group");
                END ELSE BEGIN
                    GenJnlLine.VALIDATE("WHT Business Posting Group FND", '');
                    GenJnlLine.VALIDATE("WHT Product Posting Group FND", '');
                END;
                //WHT //
                //HEI.13>>
                GenJnlLine."HNK Bank Account FND" := HnkBankAcc;
                IF GenJnlBatch."Bank Payment Type FND" <> GenJnlBatch."Bank Payment Type FND"::" " THEN   //HEI.17
                    GenJnlLine."Bank Payment Type" := GenJnlBatch."Bank Payment Type FND";
                IF CalledFromPaymentJournalTree THEN BEGIN
                    SourceCodeSetup.GET;
                    IF SourceCodeSetup."Payment Journal Tree FND" <> '' THEN
                        GenJnlLine."Source Code" := SourceCodeSetup."Payment Journal Tree FND";
                END;
                GenJnlLine."Fixed Asset Acquisition FND" := TempPaymentBuffer."Fixed Asset Acquisition FND"; //HEI.20
                                                                                                             //HEI.13<<
                UpdateDimensions(GenJnlLine);
                GenJnlLine.INSERT;
                //HEI.05>>child
                //WHT
                IF "WHT Posting Setup FND"."WHT %" <> 0 THEN BEGIN
                    WHTBus := "WHT Posting Setup FND"."WHT Business Posting Group";
                    WHTProd := "WHT Posting Setup FND"."WHT Product Posting Group";
                END ELSE BEGIN
                    WHTBus := '';
                    WHTProd := '';
                END;
                IF CalledFromPaymentJournalTree THEN
                    HeinekenGlobal.SuggestPaymentVendorInsertGenJnlLineWHT(TempPaymentBuffer2, TempPaymentBuffer, LastLineNo, GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name", ArchiveDocumentNo, WHTBus, WHTProd);
                //WHT
                //HEI.05<<
                //HEI.25>>
                IF GenJnlLine."Recipient Bank Account" = '' THEN BEGIN
                    lGenJournalLine.RESET;
                    lGenJournalLine.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                    lGenJournalLine.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                    lGenJournalLine.SETRANGE("Parent Line No. FND", GenJnlLine."Line No.");
                    IF lGenJournalLine.FINDFIRST THEN
                        IF lGenJournalLine."Recipient Bank Account" <> '' THEN BEGIN
                            GenJnlLine."Recipient Bank Account" := lGenJournalLine."Recipient Bank Account";
                            GenJnlLine.MODIFY;
                        END;
                END;
                //HEI.25<<
                GenJnlLineInserted := TRUE;
            UNTIL TempPaymentBuffer.NEXT = 0;
    end;

    local procedure UpdateDimensions(var GenJnlLine: Record "Gen. Journal Line")
    var
        DimBuf: Record "Dimension Buffer";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        TempDimSetEntry2: Record "Dimension Set Entry" temporary;
        DimVal: Record "Dimension Value";
        NewDimensionID: Integer;
        DimSetIDArr: array[10] of Integer;
    begin
        NewDimensionID := GenJnlLine."Dimension Set ID";
        IF SummarizePerVend THEN BEGIN
            DimBuf.RESET;
            DimBuf.DELETEALL;
            DimBufMgt.GetDimensions(TempPaymentBuffer."Dimension Entry No.", DimBuf);
            IF DimBuf.FINDSET THEN
                REPEAT
                    DimVal.GET(DimBuf."Dimension Code", DimBuf."Dimension Value Code");
                    TempDimSetEntry."Dimension Code" := DimBuf."Dimension Code";
                    TempDimSetEntry."Dimension Value Code" := DimBuf."Dimension Value Code";
                    TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                    TempDimSetEntry.INSERT;
                UNTIL DimBuf.NEXT = 0;
            NewDimensionID := DimMgt.GetDimensionSetID(TempDimSetEntry);
            GenJnlLine."Dimension Set ID" := NewDimensionID;
            // BC Upgrade - RD03 Drinkit fields -- >>
            //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            // BC Upgrade - RD03 Drinkit field -->>
            // CASE "Contract Type" OF
            //     "Contract Type"::Service:
            //         ContractNo := "Service Contract No.";
            //     "Contract Type"::Financial:
            //         ContractNo := "Financial Contract No.";
            // END;
            // BC Upgrade - RD03 Drinkit field -->>
            //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            // CreateDim(
            //   DimMgt.TypeToTableID1("Account Type"), "Account No.",
            //   DimMgt.TypeToTableID1("Bal. Account Type"), "Bal. Account No.",
            //   DATABASE::Job, "Job No.",
            //   DATABASE::"Salesperson/Purchaser", "Salespers./Purch. Code",
            //   DATABASE::Campaign, "Campaign No.",
            //   // <<DITW15.00.00.37 DDR 28/01/2010
            //   DATABASE::Building, "Building No.",
            // >>DITW15.00.00.37 DDR
            // <<DITW16.00.00.41 AHU 06/08/2012 20/09/2012 DIT-715 #327
            //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            //DimMgt.TypeToTableID2034932(GetSourceType(), "Contract Type"), ContractNo);
            // BC Upgrade - RD03 Drinkit fields -- >>
            //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            // >>DITW16.00.00.41 AHU DIT-715 #327
            GenJnlLine.CreateDimFromDefaultDim(0);
            IF NewDimensionID <> GenJnlLine."Dimension Set ID" THEN BEGIN
                DimSetIDArr[1] := GenJnlLine."Dimension Set ID";
                DimSetIDArr[2] := NewDimensionID;
                GenJnlLine."Dimension Set ID" :=
                  DimMgt.GetCombinedDimensionSetID(DimSetIDArr, GenJnlLine."Shortcut Dimension 1 Code", GenJnlLine."Shortcut Dimension 2 Code");
            END;

            IF SummarizePerVend THEN BEGIN
                DimMgt.GetDimensionSet(TempDimSetEntry, GenJnlLine."Dimension Set ID");
                IF AdjustAgainstSelectedDim(TempDimSetEntry, TempDimSetEntry2) THEN
                    GenJnlLine."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry2);
                DimMgt.UpdateGlobalDimFromDimSetID(GenJnlLine."Dimension Set ID", GenJnlLine."Shortcut Dimension 1 Code",
                  GenJnlLine."Shortcut Dimension 2 Code");
            END;
        END;
    end;

    local procedure SetBankAccCurrencyFilter(BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account"; BalAccNo: Code[20]; var TmpPayableVendLedgEntry: Record "Payable Vendor Ledger Entry")
    var
        BankAcc: Record "Bank Account";
    begin
        IF BalAccType = BalAccType::"Bank Account" THEN
            IF BalAccNo <> '' THEN BEGIN
                BankAcc.GET(BalAccNo);
                IF BankAcc."Currency Code" <> '' THEN
                    TmpPayableVendLedgEntry.SETRANGE("Currency Code", BankAcc."Currency Code");
            END;
    end;

    local procedure ShowMessage(Text: Text)
    begin
        IF GenJnlLineInserted THEN BEGIN
            IF ShowPostingDateWarning THEN
                Text += ReplacePostingDateMsg;
            IF Text <> '' THEN
                MESSAGE(Text);
        END;
    end;

    local procedure CheckCurrencies(BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account"; BalAccNo: Code[20]; var TmpPayableVendLedgEntry: Record "Payable Vendor Ledger Entry")
    var
        BankAcc: Record "Bank Account";
        TmpPayableVendLedgEntry2: Record "Payable Vendor Ledger Entry" temporary;
    begin
        IF BalAccType = BalAccType::"Bank Account" THEN
            IF BalAccNo <> '' THEN BEGIN
                BankAcc.GET(BalAccNo);
                IF BankAcc."Currency Code" <> '' THEN BEGIN
                    TmpPayableVendLedgEntry2.RESET;
                    TmpPayableVendLedgEntry2.DELETEALL;
                    IF TmpPayableVendLedgEntry.FIND('-') THEN
                        REPEAT
                            TmpPayableVendLedgEntry2 := TmpPayableVendLedgEntry;
                            TmpPayableVendLedgEntry2.INSERT;
                        UNTIL TmpPayableVendLedgEntry.NEXT = 0;

                    TmpPayableVendLedgEntry2.SETFILTER("Currency Code", '<>%1', BankAcc."Currency Code");
                    SeveralCurrencies := SeveralCurrencies OR TmpPayableVendLedgEntry2.FINDFIRST;

                    IF SeveralCurrencies THEN
                        MessageText :=
                          STRSUBSTNO(Text020, BankAcc.FIELDCAPTION("Currency Code"), BankAcc."Currency Code")
                    ELSE
                        MessageText :=
                          STRSUBSTNO(Text021, BankAcc.FIELDCAPTION("Currency Code"), BankAcc."Currency Code");
                END ELSE
                    MessageText := Text022;
            END;
    end;

    local procedure ClearNegative()
    var
        TempCurrency: Record Currency temporary;
        PayableVendLedgEntry2: Record "Payable Vendor Ledger Entry" temporary;
        CurrencyBalance: Decimal;
    begin
        CLEAR(PayableVendLedgEntry);
        PayableVendLedgEntry.SETRANGE("Vendor No.", Vendor."No.");

        WHILE PayableVendLedgEntry.NEXT <> 0 DO BEGIN
            TempCurrency.Code := PayableVendLedgEntry."Currency Code";
            CurrencyBalance := 0;
            IF TempCurrency.INSERT THEN BEGIN
                PayableVendLedgEntry2 := PayableVendLedgEntry;
                PayableVendLedgEntry.SETRANGE("Currency Code", PayableVendLedgEntry."Currency Code");
                REPEAT
                    CurrencyBalance := CurrencyBalance + PayableVendLedgEntry."Amount (LCY)"
                UNTIL PayableVendLedgEntry.NEXT = 0;
                IF CurrencyBalance < 0 THEN BEGIN
                    PayableVendLedgEntry.DELETEALL;
                    AmountAvailable += CurrencyBalance;
                END;
                PayableVendLedgEntry.SETRANGE("Currency Code");
                PayableVendLedgEntry := PayableVendLedgEntry2;
            END;
        END;
        PayableVendLedgEntry.RESET;
    end;

    local procedure DimCodeIsInDimBuf(DimCode: Code[20]; DimBuf: Record "Dimension Buffer"): Boolean
    begin
        DimBuf.RESET;
        DimBuf.SETRANGE("Dimension Code", DimCode);
        EXIT(NOT DimBuf.ISEMPTY);
    end;

    local procedure RemovePaymentsAboveLimit(var PayableVendLedgEntry: Record "Payable Vendor Ledger Entry"; RemainingAmtAvailable: Decimal)
    begin
        PayableVendLedgEntry.SETFILTER("Amount (LCY)", '>%1', RemainingAmtAvailable);
        PayableVendLedgEntry.DELETEALL;
        PayableVendLedgEntry.SETRANGE("Amount (LCY)");
    end;

    local procedure InsertDimBuf(var DimBuf: Record "Dimension Buffer"; TableID: Integer; EntryNo: Integer; DimCode: Code[20]; DimValue: Code[20])
    begin
        DimBuf.INIT;
        DimBuf."Table ID" := TableID;
        DimBuf."Entry No." := EntryNo;
        DimBuf."Dimension Code" := DimCode;
        DimBuf."Dimension Value Code" := DimValue;
        DimBuf.INSERT;
    end;

    local procedure GetMessageToRecipient(SummarizePerVend: Boolean): Text[140]
    begin
        IF SummarizePerVend THEN
            EXIT(CompanyInformation.Name);
        EXIT(
          STRSUBSTNO(
            MessageToRecipientMsg,
            TempPaymentBuffer."Vendor Ledg. Entry Doc. Type",
            TempPaymentBuffer."Applies-to Ext. Doc. No."));
    end;

    local procedure SetPostingDate(var GenJnlLine: Record "Gen. Journal Line"; DueDate: Date; PostingDate: Date): Boolean
    begin
        IF NOT UseDueDateAsPostingDate THEN BEGIN
            GenJnlLine.VALIDATE("Posting Date", PostingDate);
            EXIT(FALSE);
        END;

        IF DueDate = 0D THEN
            DueDate := GenJnlLine.GetAppliesToDocDueDate;
        EXIT(GenJnlLine.SetPostingDateAsDueDate(DueDate, DueDateOffset));
    end;

    local procedure GetApplDueDate(VendLedgEntryNo: Integer): Date
    var
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
    begin
        IF AppliedVendLedgEntry.GET(VendLedgEntryNo) THEN
            EXIT(AppliedVendLedgEntry."Due Date");

        EXIT(PostingDate);
    end;

    local procedure AdjustAgainstSelectedDim(var TempDimSetEntry: Record "Dimension Set Entry" temporary; var TempDimSetEntry2: Record "Dimension Set Entry" temporary): Boolean
    begin
        IF SelectedDim.FINDSET THEN BEGIN
            REPEAT
                TempDimSetEntry.SETRANGE("Dimension Code", SelectedDim."Dimension Code");
                IF TempDimSetEntry.FINDFIRST THEN BEGIN
                    TempDimSetEntry2.TRANSFERFIELDS(TempDimSetEntry, TRUE);
                    TempDimSetEntry2.INSERT;
                END;
            UNTIL SelectedDim.NEXT = 0;
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    local procedure SetTempPaymentBufferDims(var DimBuf: Record "Dimension Buffer")
    var
        GLSetup: Record "General Ledger Setup";
        EntryNo: Integer;
    begin
        IF SummarizePerDim THEN BEGIN
            DimBuf.RESET;
            DimBuf.DELETEALL;
            IF SelectedDim.FIND('-') THEN
                REPEAT
                    IF DimSetEntry.GET(
                         VendLedgEntry."Dimension Set ID", SelectedDim."Dimension Code")
                    THEN
                        InsertDimBuf(DimBuf, DATABASE::"Dimension Buffer", 0, DimSetEntry."Dimension Code",
                          DimSetEntry."Dimension Value Code");
                UNTIL SelectedDim.NEXT = 0;
            EntryNo := DimBufMgt.FindDimensions(DimBuf);
            IF EntryNo = 0 THEN
                EntryNo := DimBufMgt.InsertDimensions(DimBuf);
            TempPaymentBuffer."Dimension Entry No." := EntryNo;
            IF TempPaymentBuffer."Dimension Entry No." <> 0 THEN BEGIN
                GLSetup.GET;
                IF DimCodeIsInDimBuf(GLSetup."Global Dimension 1 Code", DimBuf) THEN
                    TempPaymentBuffer."Global Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code"
                ELSE
                    TempPaymentBuffer."Global Dimension 1 Code" := '';
                IF DimCodeIsInDimBuf(GLSetup."Global Dimension 2 Code", DimBuf) THEN
                    TempPaymentBuffer."Global Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code"
                ELSE
                    TempPaymentBuffer."Global Dimension 2 Code" := '';
            END ELSE BEGIN
                TempPaymentBuffer."Global Dimension 1 Code" := '';
                TempPaymentBuffer."Global Dimension 2 Code" := '';
            END;
            TempPaymentBuffer."Dimension Set ID" := VendLedgEntry."Dimension Set ID";
        END ELSE BEGIN
            TempPaymentBuffer."Dimension Entry No." := 0;
            TempPaymentBuffer."Global Dimension 1 Code" := '';
            TempPaymentBuffer."Global Dimension 2 Code" := '';
            TempPaymentBuffer."Dimension Set ID" := 0;
        END;
    end;

    local procedure IsEntryAlreadyApplied(GenJnlLine3: Record "Gen. Journal Line"; VendLedgEntry2: Record "Vendor Ledger Entry"): Boolean
    var
        GenJnlLine4: Record "Gen. Journal Line";
    begin
        GenJnlLine4.SETRANGE("Journal Template Name", GenJnlLine3."Journal Template Name");
        GenJnlLine4.SETRANGE("Journal Batch Name", GenJnlLine3."Journal Batch Name");
        GenJnlLine4.SETRANGE("Account Type", GenJnlLine4."Account Type"::Vendor);
        GenJnlLine4.SETRANGE("Account No.", VendLedgEntry2."Vendor No.");
        GenJnlLine4.SETRANGE("Applies-to Doc. Type", VendLedgEntry2."Document Type");
        GenJnlLine4.SETRANGE("Applies-to Doc. No.", VendLedgEntry2."Document No.");
        EXIT(NOT GenJnlLine4.ISEMPTY);
    end;

    local procedure SetDefaults()
    begin
        IF NOT ShowFilters THEN BEGIN//HEI.12
            GenJnlBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
            GenJnlLine2."Bal. Account Type" := GenJnlBatch."Bal. Account Type";
            GenJnlLine2."Bal. Account No." := GenJnlBatch."Bal. Account No.";
        END;

        //HEI.13>>
        IF GenJnlBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name") THEN
            HnkBankAcc := GenJnlBatch."HNK Bank Account FND";
        //HEI.19>>
        IF HnkBankAcc <> '' THEN
            EnableBankCurr := TRUE;
        //HEI.19<<
        GenJnlLine2."Bank Payment Type" := GenJnlBatch."Bank Payment Type FND";
        //HEI.13<<
    end;

    procedure SetCalledFromPaymentJournalTree(pCalledFromPaymentJournalTree: Boolean)
    begin
        //HEI.05>>
        CalledFromPaymentJournalTree := pCalledFromPaymentJournalTree;
        //HEI.05<<
    end;

    procedure SetShowParam(ShowParam: Boolean)
    begin
        ShowFilters := ShowParam;//HEI.12
    end;

    local procedure CheckIfTheInvoiceHasDiffWHTGroups(VendLedgEntryDocNo: Code[20]; WHTBusPostingGroup: Code[10]; WHTProdPostingGroup: Code[10]): Boolean
    var
        lWHTEntry: Record "WHT Entry FND";
    begin

        lWHTEntry.SETRANGE("Document Type", lWHTEntry."Document Type"::Invoice);
        lWHTEntry.SETRANGE("Document No.", VendLedgEntryDocNo);
        lWHTEntry.SETFILTER("WHT Bus. Posting Group", '<>%1', WHTBusPostingGroup);
        IF lWHTEntry.FINDFIRST THEN BEGIN
            //MESSAGE(Text103, VendLedgEntryDocNo, WHTBusPostingGroup, lWHTEntry."WHT Bus. Posting Group");
            EXIT(TRUE);
        END;
        lWHTEntry.SETRANGE("WHT Bus. Posting Group");
        lWHTEntry.SETFILTER("WHT Prod. Posting Group", '<>%1', WHTProdPostingGroup, 'Business');
        IF lWHTEntry.FINDFIRST THEN BEGIN
            //MESSAGE(Text103, VendLedgEntryDocNo, WHTProdPostingGroup, lWHTEntry."WHT Prod. Posting Group", 'Product');
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;
    // BC Upgrade BHARDA11 >>
    local procedure RunIncrementDocumentNo(PrepareBuffer: Boolean)
    var
        NoSeriesBatch: Codeunit "No. Series - Batch";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeRunIncrementDocumentNo(GenJnlLine, GenJnlBatch, PrepareBuffer, DocNoPerLine, BalAccNo, IsHandled);
        // if IsHandled then
        //     exit;
        if not PrepareBuffer then
            NextDocNo := NoSeriesBatch.SimulateGetNextNo(GenJnlBatch."No. Series", GenJnlLine."Posting Date", NextDocNo);
    end;
    // BC Upgrade BHARDA11 <<


}

