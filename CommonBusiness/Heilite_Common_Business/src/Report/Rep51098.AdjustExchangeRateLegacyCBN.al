report 51098 "Adjust Exch Rate Legacy CBN"
{
    // HEI.01 soica
    // HEI.02 RFC-CHG0260636 IBM.LS 21.11.2018
    //   # Reversal functionality has been scrapped for Vendors, Customer & Bank exchange rates Adjustments.
    // 
    // HEI.03 CHG2108429 IBM SURYAS01 29.04.2021 Ethiopia
    //  # modified code on trigger : Detailed Vendor Ledg. Entry - OnAfterGetRecord() and Detailed Cust. Ledg. Entry - OnAfterGetRecord()
    // HEI.04 CHG2225264 IBM SISUM01 12.01.2024 HB3640_BRD_GT_FX on Working capital payables & receivables (excluding derivatives)
    //   # code change in HandlePostAdjmt function to get new setup field if functionality is enabled
    // HEI.05  CHG2236692 IBM SISUM01 06.03.2024 HB3717_Development to perform revaluation for AR/AP
    //   #Reverse reevaluation for document that are applied.
    //   #Add the following functions ReverseUnrealizLossGainDCLE, ReverseUnrealizLossGainDVLE, ReversalCreateGenJnlLine,ReversalHandlePostAdjmt
    //   #Layout is print even if is not test mode (remove from ssrs the show option)
    // HEI.06 CHG2236692 IBM POENAB02 09.04.2024 HB3717_Change in the process of performing revaluation for AR/AP
    //   # Modified functions Detailed Cust. Ledg. Entry - OnAfterGetRecord, HandlePostAdjmt, AdjustCustomerLedgerEntry,
    //     ReverseUnrealizLossGainDCLE, ReverseUnrealizLossGainDVLE
    // HEI.07 CHG2236692 IBM POENAB02 13.05.2024 HB3717_Change in the process of performing revaluation for AR/AP
    //   # Modified functions ReverseUnrealizLossGainDCLE, ReverseUnrealizLossGainDVLE
    // HEI.08 CHG2244202 IBM KAPOOV01 15.05.2024 Adjustment needed in exchange rate related tables
    //   # Modified functions: HandlePostAdjmt(),AdjustCustomerLedgerEntry(),AdjustVendorLedgerEntry()
    // HEI.09 CHG2236692 IBM POENAB02 18.06.2024 HB3717_Change in the process of performing revaluation for AR/AP
    //   # Modified functions ReversalCreateGenJnlLine, AdjustCustomerLedgerEntry, AdjustVendorLedgerEntry
    // HEI.10 CHG2258330 IBM POENAB02 03.07.2024 Permission Revaluation error in DRC Kinshasa for vendors USD currency
    //   # Added permissions for table 50259 Detailed CV Ledger Entry Addit

    // # BC Upgrade RD03 
    //1. due to Processing only property changed in standard report, converted Cal to AL and created a new report in BC
    //2. custom report layout is available in NAV not in BC, the same layout has converted rdlc to rdl and mapped to this report
    // BC Upgrade RD03 - Fixed syntax issues as per BC syntax
    // BC Upgrade RD03 - Changed the Filter, Sorting expresions as per BC syntax

    //BC Upgrade POENAB02, 06.04.2026, "RTR112-Revaluation of AR"
    //BC Upgrade POENAB02, 23.04.2026, "RTR112-Revaluation of AR", correction for "Test Mode" issue
    //BC Upgrade YADAVM09 BCUP0124 code added to save value on request page and run report in live mode.
    //BC Upgrade ATHUKS01, 04.08.2026, "BCUP0124-Revaluation of AR", "Test Mode" is default to true.
    DefaultLayout = RDLC;
    //BC Upgrade POENAB02, 06.04.2026>>
    //RDLCLayout = '.\src\Reportslayout\AdjustExchangeRatesLegacy.rdl';
    RDLCLayout = '.\src\Reportslayout\AdjustExchangeRateLegacy.rdl';
    //BC Upgrade POENAB02, 06.04.2026<<
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;


    Caption = 'Adjust Exchange Rates HeiLite';
    Permissions = TableData 21 = rimd,
                  TableData 25 = rimd,
                  TableData 86 = rimd,
                  TableData 254 = rimd,
                  TableData 379 = rimd,
                  TableData 380 = rimd,
                  TableData 50259 = rimd;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(ReportTitle_lbl; ReportTitle_lbl)
            {
            }
            column(PageCaption_lbl; PageCaption_lbl)
            {
            }
            column(TestMode_lbl; TestMode_lbl)
            {
            }
            column(TestMode; TestMode)
            {
            }
            column(AdjBank; AdjBank)
            {
            }
            column(AdjCust; AdjCust)
            {
            }
            column(AdjVend; MaxAdjExchRateBufIndex)
            {
            }
            column(CurrencyFactor_Lbl; CurrencyFactor_Lbl)
            {
            }
            column(AdjBalanceAtDateLCY_lbl; AdjBalanceAtDateLCY_lbl)
            {
            }
            column(AdjustedFactorCaption; AdjustedFactorCaptionLbl)
            {
            }
            column(AdjDebitCaption; AdjDebit_CaptionLbl)
            {
            }
            column(AdjCreditCaption; AdjCredit_CaptionLbl)
            {
            }
            column(GainOrLossCaption; GainOrLoss_CaptionLbl)
            {
            }
            column(TotalCrAmtCaption; TotalCrAmt_CaptionLbl)
            {
            }
            column(Document_Type_Caption; Document_Type_CaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(Posting_Date_Caption; Posting_Date_CaptionLbl)
            {
            }
            column(Currency_Code_Caption; Currency_Code_CaptionLbl)
            {
            }
            column(Original_Currency_Factor_Caption; Original_Currency_Factor_CaptionLbl)
            {
            }
            column(Remaining_Amount_Caption; Remaining_Amount_CaptionLbl)
            {
            }
            column(Remaining_Amt_LCY_Caption; Remaining_Amt_LCY_CaptionLbl)
            {
            }
            column(Remaining_Amt_LCY___AdjAmountCaption; Remaining_Amt_LCY___AdjAmountCaptionLbl)
            {
            }
            dataitem(Currency; Currency)
            {
                DataItemTableView = SORTING(Code);
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Code";
                column(Currency_Code; Code)
                {
                }
                column(TotalDtAmt; TotalDtAmt)
                {
                }
                column(TotalCrAmt; -TotalCrAmt)
                {
                }
                dataitem("Bank Account"; "Bank Account")
                {
                    DataItemLink = "Currency Code" = FIELD(Code);
                    DataItemTableView = SORTING("Bank Acc. Posting Group");
                    RequestFilterFields = "No.";
                    column(Bank_Account_TABLECAPTION; "Bank Account".TABLECAPTION)
                    {
                    }
                    column(Bank_Account_No_Caption; "Bank Account".FIELDCAPTION("No."))
                    {
                    }
                    column(Bank_Account_Name_Caption; "Bank Account".FIELDCAPTION(Name))
                    {
                    }
                    column(Bank_Account_Currency_Code_Caption; "Bank Account".FIELDCAPTION("Currency Code"))
                    {
                    }
                    column(Bank_Account_Balance_at_Date_Caption; "Bank Account".FIELDCAPTION("Balance at Date"))
                    {
                    }
                    column(Bank_Account_Balance_at_Date_LCY_Caption; "Bank Account".FIELDCAPTION("Balance at Date (LCY)"))
                    {
                    }
                    column(Bank_Account_No; "No.")
                    {
                    }
                    column(Bank_Account_Name; Name)
                    {
                    }
                    column(Bank_Account_Bank_Acc_Posting_Group; "Bank Acc. Posting Group")
                    {
                    }
                    column(Bank_Account_Currency_Code; "Currency Code")
                    {
                    }
                    column(Bank_Account_Balance_at_Date; "Balance at Date")
                    {
                    }
                    column(Bank_Account_Balance_at_Date_LCY; "Balance at Date (LCY)")
                    {
                    }
                    column(Bank_Account_Currency_Factor; ROUND(1 / Currency."Currency Factor", 0.0001))
                    {
                    }
                    column(AdjAmount_Balance_at_Date_LCY; AdjAmount + "Balance at Date (LCY)")
                    {
                    }
                    column(AdjDebit; AdjDebit)
                    {
                    }
                    column(AdjCredit; -AdjCredit)
                    {
                    }
                    column(AdjAmount; AdjAmount)
                    {
                    }
                    column(GainOrLoss; GainOrLoss)
                    {
                    }
                    dataitem(BankAccountGroupTotal; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        MaxIteration = 1;

                        trigger OnAfterGetRecord()
                        var
                            BankAccount: Record "Bank Account";
                            GroupTotal: Boolean;
                        begin
                            BankAccount.COPY("Bank Account");
                            IF BankAccount.NEXT() = 1 THEN BEGIN
                                IF BankAccount."Bank Acc. Posting Group" <> "Bank Account"."Bank Acc. Posting Group" THEN
                                    GroupTotal := TRUE;
                            END ELSE
                                GroupTotal := TRUE;

                            IF GroupTotal THEN
                                IF TotalAdjAmount <> 0 THEN BEGIN
                                    AdjExchRateBufferUpdate(
                                      "Bank Account"."Currency Code", "Bank Account"."Bank Acc. Posting Group",
                                      //HEI.01 delete line TotalAdjBase,TotalAdjBaseLCY,TotalAdjAmount,0,0,0,PostingDate,'');
                                      //HEI.05>>
                                      //TotalAdjBase,TotalAdjBaseLCY,TotalAdjAmount,0,0,0,PostingDate,'',0,1);//HEI.01 new line
                                      TotalAdjBase, TotalAdjBaseLCY, TotalAdjAmount, 0, 0, 0, PostingDate, '', 0, 1, 0);
                                    //HEI.05<<
                                    //HEI.01 delete InsertExchRateAdjmtReg(3,"Bank Account"."Bank Acc. Posting Group","Bank Account"."Currency Code");
                                    InsertExchRateAdjmtReg(valueforenum::"Bank Account", "Bank Account"."Bank Acc. Posting Group", "Bank Account"."Currency Code", 0, '');//HEI.01 new line
                                    AdjExchRateBuffer.RESET();
                                    AdjExchRateBuffer.DELETEALL();
                                    TotalAdjBase := 0;
                                    TotalAdjBaseLCY := 0;
                                    TotalAdjAmount := 0;
                                END;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //HEI.01>>
                        AdjDebit := 0;
                        AdjCredit := 0;
                        //comment line: TempEntryNoAmountBuf.DELETEALL;
                        //HEI.01>>

                        BankAccNo := BankAccNo + 1;
                        Window.UPDATE(1, ROUND(BankAccNo / BankAccNoTotal * 10000, 1));

                        TempDimSetEntry.RESET();
                        TempDimSetEntry.DELETEALL();
                        TempDimBuf.RESET();
                        TempDimBuf.DELETEALL();

                        CALCFIELDS("Balance at Date", "Balance at Date (LCY)");
                        AdjBase := "Balance at Date";
                        AdjBaseLCY := "Balance at Date (LCY)";
                        AdjAmount :=
                          ROUND(
                            CurrExchRate.ExchangeAmtFCYToLCYAdjmt(
                              PostingDate, Currency.Code, "Balance at Date", Currency."Currency Factor")) -
                          "Balance at Date (LCY)";

                        IF AdjAmount <> 0 THEN BEGIN
                            GenJnlLine.VALIDATE("Posting Date", PostingDate);
                            GenJnlLine."Document No." := PostingDocNo;
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                            GenJnlLine.VALIDATE("Account No.", "No.");
                            //HEI.01>>
                            //GenJnlLine.Description := PADSTR(STRSUBSTNO(PostingDescription,Currency.Code,AdjBase),STRLEN(PostingDescription));
                            GenJnlLine.Description := STRSUBSTNO(PostingDescription, Currency.Code, AdjBase, '', '');
                            //HEI.01>>
                            GenJnlLine.VALIDATE(Amount, 0);
                            GenJnlLine."Amount (LCY)" := AdjAmount;
                            GenJnlLine."Source Currency Code" := Currency.Code;
                            IF Currency.Code = GLSetup."Additional Reporting Currency" THEN
                                GenJnlLine."Source Currency Amount" := 0;
                            GenJnlLine."Source Code" := SourceCodeSetup."Exchange Rate Adjmt.";
                            GenJnlLine."System-Created Entry" := TRUE;
                            IF NOT TestMode THEN BEGIN //HEI.01
                                GetJnlLineDefDim(GenJnlLine, TempDimSetEntry);
                                CopyDimSetEntryToDimBuf(TempDimSetEntry, TempDimBuf);
                                PostGenJnlLine(GenJnlLine, TempDimSetEntry);
                                TempEntryNoAmountBuf.INIT();
                                TempEntryNoAmountBuf."Business Unit Code" := '';
                                TempEntryNoAmountBuf."Entry No." := TempEntryNoAmountBuf."Entry No." + 1;
                                TempEntryNoAmountBuf.Amount := AdjAmount;
                                TempEntryNoAmountBuf.Amount2 := AdjBase;
                                TempEntryNoAmountBuf.INSERT();
                                TempDimBuf2.INIT();
                                TempDimBuf2."Table ID" := TempEntryNoAmountBuf."Entry No.";
                                TempDimBuf2."Entry No." := GetDimCombID(TempDimBuf);
                                TempDimBuf2.INSERT();
                            END; //HEI.01
                                 //HEI.01>>
                            IF AdjAmount > 0 THEN
                                GainOrLoss := Text50002
                            ELSE
                                GainOrLoss := Text50003;
                            SetAdjDebitCredit(AdjAmount, AdjCredit, AdjDebit);
                            //HEI.01>>
                            TotalAdjBase := TotalAdjBase + AdjBase;
                            TotalAdjBaseLCY := TotalAdjBaseLCY + AdjBaseLCY;
                            TotalAdjAmount := TotalAdjAmount + AdjAmount;
                            Window.UPDATE(4, TotalAdjAmount);

                            IF TempEntryNoAmountBuf.Amount <> 0 THEN BEGIN
                                TempDimSetEntry.RESET();
                                TempDimSetEntry.DELETEALL();
                                TempDimBuf.RESET();
                                TempDimBuf.DELETEALL();
                                TempDimBuf2.SETRANGE("Table ID", TempEntryNoAmountBuf."Entry No.");
                                IF TempDimBuf2.FINDFIRST() THEN
                                    DimBufMgt.GetDimensions(TempDimBuf2."Entry No.", TempDimBuf);
                                DimMgt.CopyDimBufToDimSetEntry(TempDimBuf, TempDimSetEntry);
                                IF TempEntryNoAmountBuf.Amount > 0 THEN BEGIN
                                    Currency.TESTFIELD("Realized Gains Acc.");
                                    PostAdjmt(
                                      Currency."Realized Gains Acc.", -TempEntryNoAmountBuf.Amount, TempEntryNoAmountBuf.Amount2,
                                      //HEI.01 delete "Currency Code",TempDimSetEntry,PostingDate,'');
                                      //HEI.05>>
                                      //"Currency Code",TempDimSetEntry,PostingDate,'',0,1);//HEI.01 new line
                                      "Currency Code", TempDimSetEntry, PostingDate, '', 0, 1, '');
                                    //HEI.05<<
                                END ELSE BEGIN
                                    Currency.TESTFIELD("Realized Losses Acc.");
                                    PostAdjmt(
                                      Currency."Realized Losses Acc.", -TempEntryNoAmountBuf.Amount, TempEntryNoAmountBuf.Amount2,
                                      //HEI.01 delete "Currency Code",TempDimSetEntry,PostingDate,'');
                                      //HEI.05>>
                                      //"Currency Code",TempDimSetEntry,PostingDate,'',0,1);//HEI.01 new line
                                      "Currency Code", TempDimSetEntry, PostingDate, '', 0, 1, '');
                                    //HEI.05<<
                                END;
                            END;
                        END;
                        TempDimBuf2.DELETEALL();
                    end;

                    trigger OnPreDataItem()
                    begin
                        //HEI.01>>
                        IF NOT AdjBank THEN
                            CurrReport.BREAK();
                        //HEI.01>>

                        SETRANGE("Date Filter", StartDate, EndDate);
                        TempDimBuf2.DELETEALL();
                        //HEI.01>>
                        TempEntryNoAmountBuf.DELETEALL();
                        CurrReport.CREATETOTALS(AdjBase, AdjBaseLCY, AdjAmount);
                        //HEI.01>>
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    "Last Date Adjusted" := PostingDate;
                    IF NOT TestMode THEN //HEI.01
                        MODIFY();

                    "Currency Factor" :=
                      CurrExchRate.ExchangeRateAdjmt(PostingDate, Code);

                    Currency2 := Currency;
                    Currency2.INSERT();
                end;

                trigger OnPostDataItem()
                begin
                    //HEI.01>>
                    //comment line: IF (Code = '') AND AdjCustVendBank THEN
                    IF (Code = '') AND AdjBank THEN
                        //HEI.01>>
                        ERROR(Text011);
                end;

                trigger OnPreDataItem()
                begin
                    CheckPostingDate();
                    //HEI.01>> comment lines
                    //IF NOT AdjCustVendBank THEN
                    //  CurrReport.BREAK;
                    //HEI.01>>

                    Window.OPEN(
                      Text006 +
                      Text007 +
                      Text008 +
                      Text009 +
                      Text010);

                    CustNoTotal := Customer.COUNT;
                    VendNoTotal := Vendor.COUNT;
                    COPYFILTER(Code, "Bank Account"."Currency Code");
                    FILTERGROUP(2);
                    "Bank Account".SETFILTER("Currency Code", '<>%1', '');
                    FILTERGROUP(0);
                    BankAccNoTotal := "Bank Account".COUNT;
                    "Bank Account".RESET();

                    //HEI.01>>
                    TotalDtAmt := 0;
                    TotalCrAmt := 0;
                    //HEI.01>>
                end;
            }
            dataitem(Customer; Customer)
            {
                DataItemTableView = SORTING("No.");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.", "Customer Posting Group";
                column(CustLedgerEntry_TABLECAPTION; CustLedgerEntry.TABLECAPTION)
                {
                }
                column(Customer_TotalDtAmt; TotalDtAmt)
                {
                }
                column(Customer_TotalCrAmt; -TotalCrAmt)
                {
                }
                column(Customer_No; "No.")
                {
                }
                column(Customer_Name; Name)
                {
                }
                dataitem(Integer1; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    column(CustLedgerEntry_Currency_Code; CustLedgerEntry."Currency Code")
                    {
                    }
                    column(CustLedgerEntry_Original_Currency_Factor; ROUND(1 / CustLedgerEntry."Original Currency Factor", 0.0001))
                    {
                    }
                    column(CustLedgerEntry_AdjustedFactor; AdjustedFactor)
                    {
                    }
                    column(CustLedgerEntry_AdjDebit1; AdjDebit)
                    {
                    }
                    column(CustLedgerEntry_AdjCredit1; -AdjCredit)
                    {
                    }
                    column(CustLedgerEntry_GainOrLoss1; GainOrLoss)
                    {
                    }
                    column(CustLedgerEntry_Document_Type; FORMAT(CustLedgerEntry."Document Type"))
                    {
                    }
                    column(CustLedgerEntry_Document_No; CustLedgerEntry."Document No.")
                    {
                    }
                    column(CustLedgerEntry_Posting_Date; CustLedgerEntry."Posting Date")
                    {
                    }
                    column(CustLedgerEntry_Remaining_Amount; CustLedgerEntry."Remaining Amount")
                    {
                    }
                    column(CustLedgerEntry_Remaining_Amt_LCY; CustLedgerEntry."Remaining Amt. (LCY)")
                    {
                    }
                    column(CustLedgerEntry_Remaining_Amt_LCY___AdjAmount; CustLedgerEntry."Remaining Amt. (LCY)" + AdjAmount)
                    {
                    }
                    column(CustLedgerEntry_Remaining_Amt_LCY___AdjAmount1; CustLedgerEntry."Remaining Amt. (LCY)" - AdjDebit - AdjCredit)
                    {
                    }
                    column(CustLedgerEntry_Remaining_Amt_LCY___AdjAmount2; CustLedgerEntry."Remaining Amt. (LCY)" - AdjDebit2 - AdjCredit2)
                    {
                    }
                    column(CustLedgerEntry_GainOrLoss2; GainOrLoss2)
                    {
                    }
                    column(CustLedgerEntry_AdjDebit2; AdjDebit2)
                    {
                    }
                    column(CustLedgerEntry_AdjCredit2; -AdjCredit2)
                    {
                    }
                    column(CustomerLedgerEntryLoop_Number; Number)
                    {
                    }
                    column(CustLedgerEntry_AdjAmount; AdjAmount)
                    {
                    }
                    column(CustTotalGainsAmount; AdjExchRateBuffer.TotalGainsAmount)
                    {
                    }
                    column(CustTotalLossesAmount; AdjExchRateBuffer.TotalLossesAmount)
                    {
                    }
                    dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                    {
                        DataItemTableView = SORTING("Cust. Ledger Entry No.", "Posting Date");

                        trigger OnAfterGetRecord()
                        begin
                            //HEI.06>>
                            //AdjustCustomerLedgerEntry(CustLedgerEntry,"Posting Date");
                            AdjustCustomerLedgerEntry(CustLedgerEntry, PostingDate);
                            //HEI.06<<
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETCURRENTKEY("Cust. Ledger Entry No.");
                            SETRANGE("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                            SETFILTER("Posting Date", '%1..', CALCDATE('<+1D>', PostingDate));
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        InitAdjDebitCredit(); //HEI.01

                        IF FirstEntry THEN BEGIN
                            TempCustLedgerEntry.FIND('-');
                            FirstEntry := FALSE
                        END ELSE
                            IF TempCustLedgerEntry.NEXT() = 0 THEN
                                CurrReport.BREAK();
                        CustLedgerEntry.GET(TempCustLedgerEntry."Entry No.");
                        //HEI.01>>
                        CustLedgerEntry.SETFILTER("Date Filter", '..%1', EndDate);
                        CustLedgerEntry.CALCFIELDS("Remaining Amount", "Remaining Amt. (LCY)");
                        //HEI.01<<
                        AdjustCustomerLedgerEntry(CustLedgerEntry, PostingDate);

                        UpdateAdjDebitCredit(); //HEI.01
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT TempCustLedgerEntry.FIND('-') THEN
                            CurrReport.BREAK();
                        FirstEntry := TRUE;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CustNo := CustNo + 1;
                    Window.UPDATE(2, ROUND(CustNo / CustNoTotal * 10000, 1));

                    TempCustLedgerEntry.DELETEALL();

                    Currency.COPYFILTER(Code, CustLedgerEntry."Currency Code");
                    CustLedgerEntry.FILTERGROUP(2);
                    CustLedgerEntry.SETFILTER("Currency Code", '<>%1', '');
                    CustLedgerEntry.FILTERGROUP(0);

                    DtldCustLedgEntry.RESET();
                    DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Entry Type");
                    DtldCustLedgEntry.SETRANGE("Customer No.", "No.");
                    DtldCustLedgEntry.SETRANGE("Posting Date", CALCDATE('<+1D>', EndDate), DMY2DATE(31, 12, 9999));
                    IF DtldCustLedgEntry.FIND('-') THEN
                        REPEAT
                            CustLedgerEntry."Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
                            IF CustLedgerEntry.FIND('=') THEN
                                IF (CustLedgerEntry."Posting Date" >= StartDate) AND
                                   (CustLedgerEntry."Posting Date" <= EndDate)
                                THEN BEGIN
                                    TempCustLedgerEntry."Entry No." := CustLedgerEntry."Entry No.";
                                    IF TempCustLedgerEntry.INSERT() THEN;
                                END;

                        UNTIL DtldCustLedgEntry.NEXT() = 0;

                    CustLedgerEntry.SETCURRENTKEY("Customer No.", Open);
                    CustLedgerEntry.SETRANGE("Customer No.", "No.");
                    CustLedgerEntry.SETRANGE(Open, TRUE);
                    CustLedgerEntry.SETRANGE("Posting Date", 0D, EndDate);
                    IF CustLedgerEntry.FIND('-') THEN
                        REPEAT
                            TempCustLedgerEntry."Entry No." := CustLedgerEntry."Entry No.";
                            IF TempCustLedgerEntry.INSERT() THEN;
                        UNTIL CustLedgerEntry.NEXT() = 0;
                    CustLedgerEntry.RESET();
                end;

                trigger OnPostDataItem()
                begin
                    //HEI.01>>
                    //comment line: IF CustNo <> 0 THEN
                    IF (CustNo <> 0) AND AdjCust THEN
                        //HEI.01>>
                        HandlePostAdjmt(1); // Customer
                    IF AdjCust THEN BEGIN
                        CLEAR(DtldCustLedgEntry);
                        IF DtldCustLedgEntry.FIND('+') THEN
                            NewEntryNo := DtldCustLedgEntry."Entry No." + 1
                        ELSE
                            NewEntryNo := 1;
                        CLEAR(TmpDetailedCustLedgEntry);

                        IF TmpDetailedCustLedgEntry.FINDSET() THEN
                            REPEAT
                                CLEAR(DtldCustLedgEntry);
                                DtldCustLedgEntry.TRANSFERFIELDS(TmpDetailedCustLedgEntry);
                                DtldCustLedgEntry."Entry No." := NewEntryNo;
                                DtldCustLedgEntry.INSERT();
                                NewEntryNo += 1;
                            UNTIL TmpDetailedCustLedgEntry.NEXT() = 0;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    //HEI.01>>
                    //comment: IF NOT AdjCustVendBank THEN
                    IF NOT AdjCust THEN
                        //HEI.01>>
                        CurrReport.BREAK();

                    DtldCustLedgEntry.LOCKTABLE();
                    CustLedgerEntry.LOCKTABLE();

                    CustNo := 0;

                    IF DtldCustLedgEntry.FIND('+') THEN
                        NewEntryNo := DtldCustLedgEntry."Entry No." + 1
                    ELSE
                        NewEntryNo := 1;

                    CLEAR(DimMgt);
                    TempEntryNoAmountBuf.DELETEALL();

                    //HEI.01>>
                    TotalDtAmt := 0;
                    TotalCrAmt := 0;
                    //HEI.01>>
                end;
            }
            dataitem(Vendor; Vendor)
            {
                DataItemTableView = SORTING("No.");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.", "Vendor Posting Group";
                column(VendorLedgerEntry_TABLECAPTION; VendorLedgerEntry.TABLECAPTION)
                {
                }
                column(Vendor_No; "No.")
                {
                }
                column(Vendor_Name; Name)
                {
                }
                dataitem(VendorLedgerEntryLoop; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    column(VendorLedgerEntry_Currency_Code; VendorLedgerEntry."Currency Code")
                    {
                    }
                    column(VendorLedgerEntry_Original_Currency_Factor; ROUND(1 / VendorLedgerEntry."Original Currency Factor", 0.0001))
                    {
                    }
                    column(VendorLedgerEntry_AdjustedFactor; AdjustedFactor)
                    {
                    }
                    column(VendorLedgerEntry_AdjDebit1; AdjDebit)
                    {
                    }
                    column(VendorLedgerEntry_AdjCredit1; -AdjCredit)
                    {
                    }
                    column(VendorLedgerEntry_GainOrLoss1; GainOrLoss)
                    {
                    }
                    column(VendorLedgerEntry_Document_Type; FORMAT(VendorLedgerEntry."Document Type"))
                    {
                    }
                    column(VendorLedgerEntry_Document_No; VendorLedgerEntry."Document No.")
                    {
                    }
                    column(VendorLedgerEntry_Posting_Date; VendorLedgerEntry."Posting Date")
                    {
                    }
                    column(VendorLedgerEntry_Remaining_Amount; VendorLedgerEntry."Remaining Amount")
                    {
                    }
                    column(VendorLedgerEntry_Remaining_Amt_LCY; VendorLedgerEntry."Remaining Amt. (LCY)")
                    {
                    }
                    column(VendorLedgerEntry_Remaining_Amt_LCY___AdjAmount; VendorLedgerEntry."Remaining Amt. (LCY)" + AdjAmount)
                    {
                    }
                    column(VendorLedgerEntry_Remaining_Amt_LCY___AdjAmount1; VendorLedgerEntry."Remaining Amt. (LCY)" - AdjDebit - AdjCredit)
                    {
                    }
                    column(VendorLedgerEntry_Remaining_Amt_LCY___AdjAmount2; VendorLedgerEntry."Remaining Amt. (LCY)" - AdjDebit2 - AdjCredit2)
                    {
                    }
                    column(VendorLedgerEntry_GainOrLoss2; GainOrLoss2)
                    {
                    }
                    column(VendorLedgerEntry_AdjDebit2; AdjDebit2)
                    {
                    }
                    column(VendorLedgerEntry_AdjCredit2; -AdjCredit2)
                    {
                    }
                    column(VendorLedgerEntryLoop_Number; Number)
                    {
                    }
                    column(VendorLedgerEntry_AdjAmount; AdjAmount)
                    {
                    }
                    column(VendTotalGainsAmount; AdjExchRateBuffer.TotalGainsAmount)
                    {
                    }
                    column(VendTotalLossesAmount; AdjExchRateBuffer.TotalLossesAmount)
                    {
                    }
                    column(Vendor_TotalDtAmt; TotalDtAmt)
                    {
                    }
                    column(Vendor_TotalCrAmt; -TotalCrAmt)
                    {
                    }
                    dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                    {
                        DataItemTableView = SORTING("Vendor Ledger Entry No.", "Posting Date");

                        trigger OnAfterGetRecord()
                        begin
                            //HEI.03<<
                            AdjustVendorLedgerEntry(VendorLedgerEntry, PostingDate);
                            //AdjustVendorLedgerEntry(VendorLedgerEntry,"Posting Date"); // HEI.03 commented the Line,Because wrong Posting date is displaying in the detailed Vend ledger entry once adjustment is done.
                            //HEI.03>>
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETCURRENTKEY("Vendor Ledger Entry No.");
                            SETRANGE("Vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
                            SETFILTER("Posting Date", '%1..', CALCDATE('<+1D>', PostingDate));
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        InitAdjDebitCredit(); //HEI.01

                        IF FirstEntry THEN BEGIN
                            TempVendorLedgerEntry.FIND('-');
                            FirstEntry := FALSE
                        END ELSE
                            IF TempVendorLedgerEntry.NEXT() = 0 THEN
                                CurrReport.BREAK();
                        VendorLedgerEntry.GET(TempVendorLedgerEntry."Entry No.");
                        //HEI.01>>
                        VendorLedgerEntry.SETFILTER("Date Filter", '..%1', EndDate);
                        VendorLedgerEntry.CALCFIELDS("Remaining Amount", "Remaining Amt. (LCY)");
                        //HEI.01>>
                        AdjustVendorLedgerEntry(VendorLedgerEntry, PostingDate);

                        UpdateAdjDebitCredit(); //HEI.01
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT TempVendorLedgerEntry.FIND('-') THEN
                            CurrReport.BREAK();
                        FirstEntry := TRUE;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    VendNo := VendNo + 1;
                    Window.UPDATE(3, ROUND(VendNo / VendNoTotal * 10000, 1));

                    TempVendorLedgerEntry.DELETEALL();

                    Currency.COPYFILTER(Code, VendorLedgerEntry."Currency Code");
                    VendorLedgerEntry.FILTERGROUP(2);
                    VendorLedgerEntry.SETFILTER("Currency Code", '<>%1', '');
                    VendorLedgerEntry.FILTERGROUP(0);

                    DtldVendLedgEntry.RESET();
                    DtldVendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date", "Entry Type");
                    DtldVendLedgEntry.SETRANGE("Vendor No.", "No.");
                    DtldVendLedgEntry.SETRANGE("Posting Date", CALCDATE('<+1D>', EndDate), DMY2DATE(31, 12, 9999));
                    IF DtldVendLedgEntry.FIND('-') THEN
                        REPEAT
                            VendorLedgerEntry."Entry No." := DtldVendLedgEntry."Vendor Ledger Entry No.";
                            IF VendorLedgerEntry.FIND('=') THEN
                                IF (VendorLedgerEntry."Posting Date" >= StartDate) AND
                                   (VendorLedgerEntry."Posting Date" <= EndDate)
                                THEN BEGIN
                                    TempVendorLedgerEntry."Entry No." := VendorLedgerEntry."Entry No.";
                                    IF TempVendorLedgerEntry.INSERT() THEN;
                                END;
                        UNTIL DtldVendLedgEntry.NEXT() = 0;

                    VendorLedgerEntry.SETCURRENTKEY("Vendor No.", Open);
                    VendorLedgerEntry.SETRANGE("Vendor No.", "No.");
                    VendorLedgerEntry.SETRANGE(Open, TRUE);
                    VendorLedgerEntry.SETRANGE("Posting Date", 0D, EndDate);
                    IF VendorLedgerEntry.FIND('-') THEN
                        REPEAT
                            TempVendorLedgerEntry."Entry No." := VendorLedgerEntry."Entry No.";
                            IF TempVendorLedgerEntry.INSERT() THEN;
                        UNTIL VendorLedgerEntry.NEXT() = 0;
                    VendorLedgerEntry.RESET();
                end;

                trigger OnPostDataItem()
                begin
                    //HEI.01>>
                    //comment line: IF VendNo <> 0 THEN
                    IF (VendNo <> 0) AND MaxAdjExchRateBufIndex THEN
                        //HEI.01>>
                        HandlePostAdjmt(2); // Vendor

                    //HEI.02>>
                    //HEI.01>>
                    //IF AdjCust AND (NOT TestMode) THEN BEGIN
                    IF MaxAdjExchRateBufIndex AND (NOT TestMode) THEN BEGIN
                        //HEI.02<<
                        CLEAR(DtldVendLedgEntry);
                        IF DtldVendLedgEntry.FIND('+') THEN
                            NewEntryNo := DtldVendLedgEntry."Entry No." + 1
                        ELSE
                            NewEntryNo := 1;
                        CLEAR(TmpDetailedVendLedgEntry);
                        //ERROR('%1',TmpDetailedVendLedgEntry.COUNT);
                        IF TmpDetailedVendLedgEntry.FINDSET() THEN
                            REPEAT
                                CLEAR(DtldVendLedgEntry);
                                DtldVendLedgEntry.TRANSFERFIELDS(TmpDetailedVendLedgEntry);
                                DtldVendLedgEntry."Entry No." := NewEntryNo;
                                DtldVendLedgEntry.INSERT();
                                NewEntryNo += 1;
                            UNTIL TmpDetailedVendLedgEntry.NEXT() = 0;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    //HEI.01>>
                    //comment line: IF NOT AdjCustVendBank THEN
                    IF NOT MaxAdjExchRateBufIndex THEN
                        //HEI.01>>
                        CurrReport.BREAK();

                    DtldVendLedgEntry.LOCKTABLE();
                    VendorLedgerEntry.LOCKTABLE();

                    VendNo := 0;
                    IF DtldVendLedgEntry.FIND('+') THEN
                        NewEntryNo := DtldVendLedgEntry."Entry No." + 1
                    ELSE
                        NewEntryNo := 1;

                    CLEAR(DimMgt);
                    TempEntryNoAmountBuf.DELETEALL();

                    //HEI.01>>
                    TotalDtAmt := 0;
                    TotalCrAmt := 0;
                    //HEI.01>>
                end;
            }
            dataitem("VAT Posting Setup"; "VAT Posting Setup")
            {
                DataItemTableView = SORTING("VAT Bus. Posting Group", "VAT Prod. Posting Group");

                trigger OnAfterGetRecord()
                begin
                    VATEntryNo := VATEntryNo + 1;
                    Window.UPDATE(1, ROUND(VATEntryNo / VATEntryNoTotal * 10000, 1));

                    VATEntry.SETRANGE("VAT Bus. Posting Group", "VAT Bus. Posting Group");
                    VATEntry.SETRANGE("VAT Prod. Posting Group", "VAT Prod. Posting Group");

                    IF "VAT Calculation Type" <> "VAT Calculation Type"::"Sales Tax" THEN BEGIN
                        AdjustVATEntries(VATEntry.Type::Purchase.AsInteger(), FALSE);
                        IF (VATEntry2.Amount <> 0) OR (VATEntry2."Additional-Currency Amount" <> 0) THEN BEGIN
                            TESTFIELD("Purchase VAT Account");
                            AdjustVATAccount(
                              "Purchase VAT Account",
                              VATEntry2.Amount, VATEntry2."Additional-Currency Amount",
                              VATEntryTotalBase.Amount, VATEntryTotalBase."Additional-Currency Amount");
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT" THEN BEGIN
                                TESTFIELD("Reverse Chrg. VAT Acc.");
                                AdjustVATAccount(
                                  "Reverse Chrg. VAT Acc.",
                                  -VATEntry2.Amount, -VATEntry2."Additional-Currency Amount",
                                  -VATEntryTotalBase.Amount, -VATEntryTotalBase."Additional-Currency Amount");
                            END;
                        END;
                        IF (VATEntry2."Remaining Unrealized Amount" <> 0) OR
                           (VATEntry2."Add.-Curr. Rem. Unreal. Amount" <> 0)
                        THEN BEGIN
                            TESTFIELD("Unrealized VAT Type");
                            TESTFIELD("Purch. VAT Unreal. Account");
                            AdjustVATAccount(
                              "Purch. VAT Unreal. Account",
                              VATEntry2."Remaining Unrealized Amount",
                              VATEntry2."Add.-Curr. Rem. Unreal. Amount",
                              VATEntryTotalBase."Remaining Unrealized Amount",
                              VATEntryTotalBase."Add.-Curr. Rem. Unreal. Amount");
                            IF "VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT" THEN BEGIN
                                TESTFIELD("Reverse Chrg. VAT Unreal. Acc.");
                                AdjustVATAccount(
                                  "Reverse Chrg. VAT Unreal. Acc.",
                                  -VATEntry2."Remaining Unrealized Amount",
                                  -VATEntry2."Add.-Curr. Rem. Unreal. Amount",
                                  -VATEntryTotalBase."Remaining Unrealized Amount",
                                  -VATEntryTotalBase."Add.-Curr. Rem. Unreal. Amount");
                            END;
                        END;

                        AdjustVATEntries(VATEntry.Type::Sale.AsInteger(), FALSE);
                        IF (VATEntry2.Amount <> 0) OR (VATEntry2."Additional-Currency Amount" <> 0) THEN BEGIN
                            TESTFIELD("Sales VAT Account");
                            AdjustVATAccount(
                              "Sales VAT Account",
                              VATEntry2.Amount, VATEntry2."Additional-Currency Amount",
                              VATEntryTotalBase.Amount, VATEntryTotalBase."Additional-Currency Amount");
                        END;
                        IF (VATEntry2."Remaining Unrealized Amount" <> 0) OR
                           (VATEntry2."Add.-Curr. Rem. Unreal. Amount" <> 0)
                        THEN BEGIN
                            TESTFIELD("Unrealized VAT Type");
                            TESTFIELD("Sales VAT Unreal. Account");
                            AdjustVATAccount(
                              "Sales VAT Unreal. Account",
                              VATEntry2."Remaining Unrealized Amount",
                              VATEntry2."Add.-Curr. Rem. Unreal. Amount",
                              VATEntryTotalBase."Remaining Unrealized Amount",
                              VATEntryTotalBase."Add.-Curr. Rem. Unreal. Amount");
                        END;
                    END ELSE BEGIN
                        IF TaxJurisdiction.FIND('-') THEN
                            REPEAT
                                VATEntry.SETRANGE("Tax Jurisdiction Code", TaxJurisdiction.Code);
                                AdjustVATEntries(VATEntry.Type::Purchase.AsInteger(), FALSE);
                                AdjustPurchTax(FALSE);
                                AdjustVATEntries(VATEntry.Type::Purchase.AsInteger(), TRUE);
                                AdjustPurchTax(TRUE);
                                AdjustVATEntries(VATEntry.Type::Sale.AsInteger(), FALSE);
                                AdjustSalesTax();
                            UNTIL TaxJurisdiction.NEXT() = 0;
                        VATEntry.SETRANGE("Tax Jurisdiction Code");
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF NOT AdjGLAcc OR
                       (GLSetup."VAT Exchange Rate Adjustment" = GLSetup."VAT Exchange Rate Adjustment"::"No Adjustment")
                    THEN
                        CurrReport.BREAK();

                    Window.OPEN(
                      Text012 +
                      Text013);

                    VATEntryNoTotal := VATEntry.COUNT;
                    IF NOT
                       VATEntry.SETCURRENTKEY(
                         Type, Closed, "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Posting Date")
                    THEN
                        VATEntry.SETCURRENTKEY(
                          Type, Closed, "Tax Jurisdiction Code", "Use Tax", "Posting Date");
                    VATEntry.SETRANGE(Closed, FALSE);
                    VATEntry.SETRANGE("Posting Date", StartDate, EndDate);
                end;
            }
            dataitem("G/L Account"; "G/L Account")
            {
                //BC Upgrade RD03
                DataItemTableView = SORTING("No.")
                                    WHERE("Exchange Rate Adjustment" = FILTER("Exch. Rate Adjustment Type"::"Adjust Amount" .. "Exch. Rate Adjustment Type"::"Adjust Additional-Currency Amount"));
                //(Adjust Amount..Adjust Additional-Currency Amount));
                //BC Upgrade RD03
                trigger OnAfterGetRecord()
                begin
                    GLAccNo := GLAccNo + 1;
                    Window.UPDATE(1, ROUND(GLAccNo / GLAccNoTotal * 10000, 1));
                    IF "Exchange Rate Adjustment" = "Exchange Rate Adjustment"::"No Adjustment" THEN
                        CurrReport.SKIP();

                    TempDimSetEntry.RESET();
                    TempDimSetEntry.DELETEALL();
                    CALCFIELDS("Net Change", "Additional-Currency Net Change");
                    CASE "Exchange Rate Adjustment" OF
                        "Exchange Rate Adjustment"::"Adjust Amount":
                            PostGLAccAdjmt(
                              "No.", "Exchange Rate Adjustment"::"Adjust Amount".AsInteger(),
                              ROUND(
                                CurrExchRate2.ExchangeAmtFCYToLCYAdjmt(
                                  PostingDate, GLSetup."Additional Reporting Currency",
                                  "Additional-Currency Net Change", AddCurrCurrencyFactor) -
                                "Net Change"),
                              "Net Change",
                              "Additional-Currency Net Change");
                        "Exchange Rate Adjustment"::"Adjust Additional-Currency Amount":
                            PostGLAccAdjmt(
                              "No.", "Exchange Rate Adjustment"::"Adjust Additional-Currency Amount".AsInteger(),
                              ROUND(
                                CurrExchRate2.ExchangeAmtLCYToFCY(
                                  PostingDate, GLSetup."Additional Reporting Currency",
                                  "Net Change", AddCurrCurrencyFactor) -
                                "Additional-Currency Net Change",
                                Currency3."Amount Rounding Precision"),
                              "Net Change",
                              "Additional-Currency Net Change");
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    IF AdjGLAcc THEN BEGIN
                        GenJnlLine."Document No." := PostingDocNo;
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine."Posting Date" := PostingDate;
                        GenJnlLine."Source Code" := SourceCodeSetup."Exchange Rate Adjmt.";

                        IF GLAmtTotal <> 0 THEN BEGIN
                            IF GLAmtTotal < 0 THEN
                                GenJnlLine."Account No." := Currency3."Realized G/L Losses Account"
                            ELSE
                                GenJnlLine."Account No." := Currency3."Realized G/L Gains Account";
                            GenJnlLine.Description :=
                              STRSUBSTNO(
                                PostingDescription,
                                GLSetup."Additional Reporting Currency",
                                //HEI.01>>
                                //GLAddCurrNetChangeTotal);
                                GLAddCurrNetChangeTotal, '', '');
                            //HEI.01>>
                            GenJnlLine."Additional-Currency Posting" := GenJnlLine."Additional-Currency Posting"::"Amount Only";
                            GenJnlLine."Currency Code" := '';
                            GenJnlLine.Amount := -GLAmtTotal;
                            GenJnlLine."Amount (LCY)" := -GLAmtTotal;
                            IF NOT TestMode THEN BEGIN //HEI.01
                                GetJnlLineDefDim(GenJnlLine, TempDimSetEntry);
                                PostGenJnlLine(GenJnlLine, TempDimSetEntry);
                            END; //HEI.01
                        END;
                        IF GLAddCurrAmtTotal <> 0 THEN BEGIN
                            IF GLAddCurrAmtTotal < 0 THEN
                                GenJnlLine."Account No." := Currency3."Realized G/L Losses Account"
                            ELSE
                                GenJnlLine."Account No." := Currency3."Realized G/L Gains Account";
                            GenJnlLine.Description :=
                              STRSUBSTNO(
                                PostingDescription, '',
                                //HEI.01>>
                                //GLNetChangeTotal);
                                GLNetChangeTotal, '', '');
                            //HEI.01>>
                            GenJnlLine."Additional-Currency Posting" := GenJnlLine."Additional-Currency Posting"::"Additional-Currency Amount Only";
                            GenJnlLine."Currency Code" := GLSetup."Additional Reporting Currency";
                            GenJnlLine.Amount := -GLAddCurrAmtTotal;
                            GenJnlLine."Amount (LCY)" := 0;
                            IF NOT TestMode THEN BEGIN //HEI.01
                                GetJnlLineDefDim(GenJnlLine, TempDimSetEntry);
                                PostGenJnlLine(GenJnlLine, TempDimSetEntry);
                            END; //HEI.01
                        END;

                        ExchRateAdjReg."No." := ExchRateAdjReg."No." + 1;
                        ExchRateAdjReg."Creation Date" := PostingDate;
                        ExchRateAdjReg."Account Type" := ExchRateAdjReg."Account Type"::"G/L Account";
                        ExchRateAdjReg."Posting Group" := '';
                        ExchRateAdjReg."Currency Code" := GLSetup."Additional Reporting Currency";
                        ExchRateAdjReg."Currency Factor" := CurrExchRate2."Adjustment Exch. Rate Amount";
                        ExchRateAdjReg."Adjusted Base" := 0;
                        ExchRateAdjReg."Adjusted Base (LCY)" := GLNetChangeBase;
                        ExchRateAdjReg."Adjusted Amt. (LCY)" := GLAmtTotal;
                        ExchRateAdjReg."Adjusted Base (Add.-Curr.)" := GLAddCurrNetChangeBase;
                        ExchRateAdjReg."Adjusted Amt. (Add.-Curr.)" := GLAddCurrAmtTotal;
                        IF NOT TestMode THEN
                            //HEI.01
                            ExchRateAdjReg.INSERT();
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF NOT AdjGLAcc THEN
                        CurrReport.BREAK();

                    Window.OPEN(
                      Text014 +
                      Text015);

                    GLAccNoTotal := COUNT;
                    SETRANGE("Date Filter", StartDate, EndDate);
                end;
            }
        }
    }

    requestpage
    {
        //BC Upgrade POENAB02, 23.04.2026>>
        SaveValues = true;//BC Upgrade YADAVM09 BCUP0124<<
        //SaveValues = false;
        //BC Upgrade POENAB02, 23.04.2026<<

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    group("Adjustment Period")
                    {
                        Caption = 'Adjustment Period';
                        field(StartingDate; StartDate)
                        {
                            ApplicationArea = all;
                            Caption = 'Starting Date';
                            ToolTip = 'Specifies the beginning of the period for which entries are adjusted. This field is usually left blank, but you can enter a date.';
                        }
                        field(EndingDate; EndDateReq)
                        {
                            ApplicationArea = all;
                            Caption = 'Ending Date';
                            ToolTip = 'Specifies the last date for which entries are adjusted. This date is usually the same as the posting date in the Posting Date field.';

                            trigger OnValidate()
                            begin
                                PostingDate := EndDateReq;
                                //HEI.02>>
                                ////HEI.01>>
                                //IF PostingDate <> 0D THEN
                                //  ReversalPostingDate := PostingDate + 1
                                //ELSE
                                //  ReversalPostingDate := 0D;
                                ////HEI.01>>
                                //HEI.02<<
                            end;
                        }
                    }
                    field(PostingDescription; PostingDescription)
                    {
                        ApplicationArea = all;
                        Caption = 'Posting Description';
                        ToolTip = 'Specifies text for the general ledger entries that are created by the batch job. The default text is Exchange Rate Adjmt. of %1 %2, in which %1 is replaced by the currency code and %2 is replaced by the currency amount that is adjusted. For example, Exchange Rate Adjmt. of DEM 38,000.';
                    }
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = all;
                        Caption = 'Posting Date';
                        ToolTip = 'Specifies the date on which the general ledger entries are posted. This date is usually the same as the ending date in the Ending Date field.';

                        trigger OnValidate()
                        begin
                            CheckPostingDate();
                            //HEI.02>>
                            ////HEI.01>>
                            //IF PostingDate <> 0D THEN
                            //  ReversalPostingDate := PostingDate + 1
                            //ELSE
                            //  ReversalPostingDate := 0D;
                            ////HEI.01>>
                            //HEI.02<<
                        end;
                    }
                    field(ReversalPostingDate; ReversalPostingDate)
                    {
                        ApplicationArea = all;
                        Caption = 'Reversal Posting Date';
                        Visible = false;
                    }
                    field(DocumentNo; PostingDocNo)
                    {
                        ApplicationArea = all;
                        Caption = 'Document No.';
                        ToolTip = 'Specifies the document number that will appear on the general ledger entries that are created by the batch job.';
                    }
                    field(AdjBank; AdjBank)
                    {
                        ApplicationArea = all;
                        Caption = 'Adjust Bank';
                        MultiLine = true;
                        ToolTip = 'Specifies if you want to adjust customer, vendor, and bank accounts for currency fluctuations.';
                    }
                    field(AdjCust; AdjCust)
                    {
                        ApplicationArea = all;
                        Caption = 'Adjust Customer';
                    }
                    field(MaxAdjExchRateBufIndex; MaxAdjExchRateBufIndex)
                    {
                        ApplicationArea = all;
                        Caption = 'Adjust Vendor';
                    }
                    field(AdjGLAcc; AdjGLAcc)
                    {
                        ApplicationArea = all;
                        Caption = 'Adjust G/L Accounts for Add.-Reporting Currency';
                        MultiLine = true;
                        ToolTip = 'Specifies if you want to post in an additional reporting currency and adjust general ledger accounts for currency fluctuations between $ and the additional reporting currency.';
                    }
                    field(TestMode; TestMode)
                    {
                        ApplicationArea = all;
                        Caption = 'Test Mode';
                        MultiLine = true;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF PostingDescription = '' THEN
                PostingDescription := Text016;
            //HEI.01 comment line: IF NOT (AdjCustVendBank OR AdjGLAcc) THEN
            //HEI.01 comment line:  AdjCustVendBank := TRUE;
            IF NOT (AdjCust OR MaxAdjExchRateBufIndex OR AdjBank OR AdjGLAcc) THEN BEGIN
                AdjCust := TRUE;
                MaxAdjExchRateBufIndex := TRUE;
                AdjBank := TRUE;
            END;
            //BC Upgrade ATHUKS01, 04.08.2026>>
            TestMode := TRUE; //BC Upgrade YADAVM09 BCUP0124<<
            //BC Upgrade ATHUKS01, 04.08.2026<<
            //HEI.01<<
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        //HEI.02>>
        ////HEI.01
        //CLEAR(TempGenJournalLine);
        //IF NOT TestMode THEN BEGIN
        //  IF TempGenJournalLine.FINDSET THEN REPEAT
        //    GenJnlPostLine.RUN(TempGenJournalLine);
        //  UNTIL TempGenJournalLine.NEXT = 0;
        //END;
        ////HEI.01
        //HEI.02<<
        UpdateAnalysisView.UpdateAll(0, TRUE);
    end;

    trigger OnPreReport()
    begin
        IF EndDateReq = 0D THEN
            EndDate := DMY2DATE(31, 12, 9999)
        ELSE
            EndDate := EndDateReq;

        //HEI.01>>
        AdjCustVendBank :=
          AdjCust OR MaxAdjExchRateBufIndex OR AdjBank;

        IF NOT TestMode THEN
            IF NOT CONFIRM(Text50000, FALSE) THEN
                ERROR(Text005);
        //HEI.01<<

        //HEI.01>>
        //IF PostingDocNo = '' THEN
        IF (NOT TestMode) AND (PostingDocNo = '') THEN
            //HEI.01>>
            ERROR(Text000, GenJnlLine.FIELDCAPTION("Document No."));

        IF NOT AdjCustVendBank AND AdjGLAcc THEN
            IF NOT CONFIRM(Text001 + Text004, FALSE) THEN
                ERROR(Text005);

        SourceCodeSetup.GET();

        IF ExchRateAdjReg.FINDLAST() THEN
            ExchRateAdjReg.INIT();

        GLSetup.GET();

        IF AdjGLAcc THEN BEGIN
            GLSetup.TESTFIELD("Additional Reporting Currency");

            Currency3.GET(GLSetup."Additional Reporting Currency");
            Currency3.TESTFIELD("Realized G/L Gains Account");
            "G/L Account".GET(Currency3."Realized G/L Gains Account");
            "G/L Account".TESTFIELD(
              "Exchange Rate Adjustment",
              "G/L Account"."Exchange Rate Adjustment"::"No Adjustment");

            Currency3.TESTFIELD("Realized G/L Losses Account");
            "G/L Account".GET(Currency3."Realized G/L Losses Account");
            "G/L Account".TESTFIELD(
              "Exchange Rate Adjustment",
              "G/L Account"."Exchange Rate Adjustment"::"No Adjustment");

            IF VATPostingSetup2.FIND('-') THEN
                REPEAT
                    IF VATPostingSetup2."VAT Calculation Type" <> VATPostingSetup2."VAT Calculation Type"::"Sales Tax" THEN BEGIN
                        CheckExchRateAdjustment(
                          VATPostingSetup2."Purchase VAT Account", VATPostingSetup2.TABLECAPTION, VATPostingSetup2.FIELDCAPTION("Purchase VAT Account"));
                        CheckExchRateAdjustment(
                          VATPostingSetup2."Reverse Chrg. VAT Acc.", VATPostingSetup2.TABLECAPTION, VATPostingSetup2.FIELDCAPTION("Reverse Chrg. VAT Acc."));
                        CheckExchRateAdjustment(
                          VATPostingSetup2."Purch. VAT Unreal. Account", VATPostingSetup2.TABLECAPTION, VATPostingSetup2.FIELDCAPTION("Purch. VAT Unreal. Account"));
                        CheckExchRateAdjustment(
                          VATPostingSetup2."Reverse Chrg. VAT Unreal. Acc.", VATPostingSetup2.TABLECAPTION, VATPostingSetup2.FIELDCAPTION("Reverse Chrg. VAT Unreal. Acc."));
                        CheckExchRateAdjustment(
                          VATPostingSetup2."Sales VAT Account", VATPostingSetup2.TABLECAPTION, VATPostingSetup2.FIELDCAPTION("Sales VAT Account"));
                        CheckExchRateAdjustment(
                          VATPostingSetup2."Sales VAT Unreal. Account", VATPostingSetup2.TABLECAPTION, VATPostingSetup2.FIELDCAPTION("Sales VAT Unreal. Account"));
                    END;
                UNTIL VATPostingSetup2.NEXT() = 0;

            IF TaxJurisdiction2.FIND('-') THEN
                REPEAT
                    CheckExchRateAdjustment(
                      TaxJurisdiction2."Tax Account (Purchases)", TaxJurisdiction2.TABLECAPTION, TaxJurisdiction2.FIELDCAPTION("Tax Account (Purchases)"));
                    CheckExchRateAdjustment(
                      TaxJurisdiction2."Reverse Charge (Purchases)", TaxJurisdiction2.TABLECAPTION, TaxJurisdiction2.FIELDCAPTION("Reverse Charge (Purchases)"));
                    CheckExchRateAdjustment(
                      TaxJurisdiction2."Unreal. Tax Acc. (Purchases)", TaxJurisdiction2.TABLECAPTION, TaxJurisdiction2.FIELDCAPTION("Unreal. Tax Acc. (Purchases)"));
                    CheckExchRateAdjustment(
                      TaxJurisdiction2."Unreal. Rev. Charge (Purch.)", TaxJurisdiction2.TABLECAPTION, TaxJurisdiction2.FIELDCAPTION("Unreal. Rev. Charge (Purch.)"));
                    CheckExchRateAdjustment(
                      TaxJurisdiction2."Tax Account (Sales)", TaxJurisdiction2.TABLECAPTION, TaxJurisdiction2.FIELDCAPTION("Tax Account (Sales)"));
                    CheckExchRateAdjustment(
                      TaxJurisdiction2."Unreal. Tax Acc. (Sales)", TaxJurisdiction2.TABLECAPTION, TaxJurisdiction2.FIELDCAPTION("Unreal. Tax Acc. (Sales)"));
                UNTIL TaxJurisdiction2.NEXT() = 0;

            AddCurrCurrencyFactor :=
              CurrExchRate2.ExchangeRateAdjmt(PostingDate, GLSetup."Additional Reporting Currency");
        END;
    end;

    var
        valueforenum: Enum "Exch. Rate Adjmt. Account Type";
        Text000: Label '%1 must be entered.';
        Text001: Label 'Do you want to adjust general ledger entries for currency fluctuations without adjusting customer, vendor and bank ledger entries? This may result in incorrect currency adjustments to payables, receivables and bank accounts.\\ ';
        Text004: Label 'Do you wish to continue?';
        Text005: Label 'The adjustment of exchange rates has been canceled.';
        Text006: Label 'Adjusting exchange rates...\\';
        Text007: Label 'Bank Account    @1@@@@@@@@@@@@@\\';
        Text008: Label 'Customer        @2@@@@@@@@@@@@@\';
        Text009: Label 'Vendor          @3@@@@@@@@@@@@@\';
        Text010: Label 'Adjustment      #4#############';
        Text011: Label 'No currencies have been found.';
        Text012: Label 'Adjusting Tax Entries...\\';
        Text013: Label 'Tax Entry       @1@@@@@@@@@@@@@';
        Text014: Label 'Adjusting general ledger...\\';
        Text015: Label 'G/L Account     @1@@@@@@@@@@@@@';
        Text016: Label 'Adjmt. of %1 %2, Ex.Rate Adjust.', Comment = '%1 = Currency Code, %2= Adjust Amount';
        Text017: Label '%1 on %2 %3 must be %4. When this %2 is used in %5, the exchange rate adjustment is defined in the %6 field in the %7. %2 %3 is used in the %8 field in the %5. ';
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        TempDtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry" temporary;
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        TempDtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry" temporary;
        ExchRateAdjReg: Record "Exch. Rate Adjmt. Reg.";
        CustPostingGr: Record "Customer Posting Group";
        VendPostingGr: Record "Vendor Posting Group";
        GenJnlLine: Record "Gen. Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        //BC Upgrade POENAB02, 06.04.2026>>
        // AdjExchRateBuffer: Record "Adjust Exchange Rate Buffer" temporary;
        // AdjExchRateBuffer2: Record "Adjust Exchange Rate Buffer" temporary;
        AdjExchRateBuffer: Record AdjustExchangeRateBufferHNKFND temporary;
        AdjExchRateBuffer2: Record AdjustExchangeRateBufferHNKFND temporary;
        //BC Upgrade POENAB02, 06.04.2026<<
        Currency2: Record Currency temporary;
        Currency3: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        CurrExchRate2: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
        VATEntry: Record "VAT Entry";
        VATEntry2: Record "VAT Entry";
        VATEntryTotalBase: Record "VAT Entry";
        TaxJurisdiction: Record "Tax Jurisdiction";
        VATPostingSetup2: Record "VAT Posting Setup";
        TaxJurisdiction2: Record "Tax Jurisdiction";
        TempDimBuf: Record "Dimension Buffer" temporary;
        TempDimBuf2: Record "Dimension Buffer" temporary;
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        TempEntryNoAmountBuf: Record "Entry No. Amount Buffer" temporary;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        TempCustLedgerEntry: Record "Cust. Ledger Entry" temporary;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        TempVendorLedgerEntry: Record "Vendor Ledger Entry" temporary;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        UpdateAnalysisView: Codeunit "Update Analysis View";
        DimMgt: Codeunit DimensionManagement;
        DimBufMgt: Codeunit "Dimension Buffer Management";
        Window: Dialog;
        TotalAdjBase: Decimal;
        TotalAdjBaseLCY: Decimal;
        TotalAdjAmount: Decimal;
        GainsAmount: Decimal;
        LossesAmount: Decimal;
        PostingDate: Date;
        PostingDescription: Text[50];
        AdjBase: Decimal;
        AdjBaseLCY: Decimal;
        AdjAmount: Decimal;
        CustNo: Decimal;
        CustNoTotal: Decimal;
        VendNo: Decimal;
        VendNoTotal: Decimal;
        BankAccNo: Decimal;
        BankAccNoTotal: Decimal;
        GLAccNo: Decimal;
        GLAccNoTotal: Decimal;
        GLAmtTotal: Decimal;
        GLAddCurrAmtTotal: Decimal;
        GLNetChangeTotal: Decimal;
        GLAddCurrNetChangeTotal: Decimal;
        GLNetChangeBase: Decimal;
        GLAddCurrNetChangeBase: Decimal;
        PostingDocNo: Code[20];
        StartDate: Date;
        EndDate: Date;
        EndDateReq: Date;
        Correction: Boolean;
        OK: Boolean;
        AdjCustVendBank: Boolean;
        AdjGLAcc: Boolean;
        AddCurrCurrencyFactor: Decimal;
        VATEntryNoTotal: Decimal;
        VATEntryNo: Decimal;
        NewEntryNo: Integer;
        Text018: Label 'This posting date cannot be entered because it does not occur within the adjustment period. Reenter the posting date.';
        FirstEntry: Boolean;
        CVLedgEntryBuffer: Record "CV Ledger Entry Buffer" temporary;
        AdjCust: Boolean;
        MaxAdjExchRateBufIndex: Boolean;
        AdjBank: Boolean;
        TestMode: Boolean;
        Text50000: Label 'Do you want to calculate and post the adjustment?';
        AdjustedFactor: Decimal;
        AdjDebit: Decimal;
        AdjDebit2: Decimal;
        AdjCredit: Decimal;
        AdjCredit2: Decimal;
        TotalDtAmt: Decimal;
        TotalCrAmt: Decimal;
        GainOrLoss: Text[30];
        GainOrLoss2: Text[30];
        Text50001: Label 'Yes';
        Text50002: Label 'Gain';
        Text50003: Label 'Loss';
        Text50004: Label 'To run the report in Test Mode, set Summarize Entries to No.';
        Text50005: Label 'Exchange Rate Adjmt. of %1 %2 %3 %4';
        ReportTitle_lbl: Label 'Adjust Exchange Rates';
        PageCaption_lbl: Label 'Page';
        TestMode_lbl: Label 'Test Mode:';
        Gain_lbl: Label 'Gain';
        Loss_lbl: Label 'Loss';
        CurrencyFactor_Lbl: Label 'Factor';
        AdjBalanceAtDateLCY_lbl: Label 'Adj. Balance at Date (LCY)';
        AdjDebit_CaptionLbl: Label 'Adj. Amount - Debit';
        AdjCredit_CaptionLbl: Label 'Adj. Amount - Credit';
        GainOrLoss_CaptionLbl: Label 'Gain / Loss';
        TotalCrAmt_CaptionLbl: Label 'Total';
        Document_Type_CaptionLbl: Label 'Document Type';
        Document_No_CaptionLbl: Label 'Document No.';
        Posting_Date_CaptionLbl: Label 'Posting Date';
        Currency_Code_CaptionLbl: Label 'Currency Code';
        Original_Currency_Factor_CaptionLbl: Label 'Original Currency';
        AdjustedFactorCaptionLbl: Label 'Adjusted';
        Remaining_Amount_CaptionLbl: Label 'Remaining Amount';
        Remaining_Amt_LCY_CaptionLbl: Label 'Remaining Amt.(LCY)';
        Remaining_Amt_LCY___AdjAmountCaptionLbl: Label 'Adj. Remaining Amt.(LCY)';
        TempGenJournalLine: Record "Gen. Journal Line" temporary;
        TmpDetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry" temporary;
        TmpDetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry" temporary;
        NextLineNoC: Integer;
        NextLineNoV: Integer;
        NextLineGL: Integer;
        ReversalPostingDate: Date;
        GenJnlLineReverse: Record "Gen. Journal Line";
        DimSetEntryReverse: Record "Dimension Set Entry";
        LineNo: Integer;
        TempReverseDtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry" temporary;
        TempReverseDtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry" temporary;
        DtldCVLedgerEntryAddit: Record "Detail CVLedgerEntry Addit FND";

    local procedure PostAdjmt(GLAccNo: Code[20]; PostingAmount: Decimal; AdjBase2: Decimal; CurrencyCode2: Code[10]; var DimSetEntry: Record "Dimension Set Entry"; PostingDate2: Date; ICCode: Code[20]; DetailedEntryNo: Integer; AccType: Integer; CVLENo: Text)
    var
        DocNo: Code[20];
        DocType: Text[30];
    begin
        //create lines in GL Entry with description that does not contain "R-"
        IF PostingAmount <> 0 THEN BEGIN
            GenJnlLine.INIT();
            GenJnlLine.VALIDATE("Posting Date", PostingDate);
            GenJnlLine."Document No." := PostingDocNo;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            //HEI.02>>
            ////HEI.01>>
            //"System-Created Entry" := TRUE;
            ////HEI.01<<
            //HEI.02<<
            GenJnlLine.VALIDATE("Account No.", GLAccNo);
            GenJnlLine.Description := PADSTR(STRSUBSTNO(PostingDescription, CurrencyCode2, AdjBase2), STRLEN(PostingDescription));
            DocNo := CVLedgEntryBuffer."Document No.";
            DocType := FORMAT(CVLedgEntryBuffer."Document Type");
            GenJnlLine.VALIDATE(Amount, PostingAmount);
            GenJnlLine."Source Currency Code" := CurrencyCode2;
            GenJnlLine."IC Partner Code" := ICCode;
            //HEI.01>>
            GenJnlLine."CV Detailed Entry No. FND" := DetailedEntryNo;
            GenJnlLine."Adj. Exchange Rate Type FND" := AccType;
            //HEI.01<<
            IF CurrencyCode2 = GLSetup."Additional Reporting Currency" THEN
                GenJnlLine."Source Currency Amount" := 0;
            GenJnlLine."Source Code" := SourceCodeSetup."Exchange Rate Adjmt.";
            GenJnlLine."System-Created Entry" := TRUE;
            GenJnlLine."Additional Description FND" := CVLENo;
            //HEI.05
            IF NOT TestMode THEN
                //HEI.01
                PostGenJnlLine(GenJnlLine, DimSetEntry);
        END;
    end;

    local procedure InsertExchRateAdjmtReg(AdjustAccType: Enum "Exch. Rate Adjmt. Account Type"; PostingGrCode: Code[10]; CurrencyCode: Code[10]; CVDetailedEntryNo: Integer; AccountNo: Code[20])
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        IF Currency2.Code <> CurrencyCode THEN
            Currency2.GET(CurrencyCode);

        ExchRateAdjReg."No." := ExchRateAdjReg."No." + 1;
        ExchRateAdjReg."Creation Date" := PostingDate;
        ExchRateAdjReg."Account Type" := AdjustAccType;
        ExchRateAdjReg."Posting Group" := PostingGrCode;
        ExchRateAdjReg."Currency Code" := Currency2.Code;
        ExchRateAdjReg."Currency Factor" := Currency2."Currency Factor";
        ExchRateAdjReg."Adjusted Base" := AdjExchRateBuffer.AdjBase;
        ExchRateAdjReg."Adjusted Base (LCY)" := AdjExchRateBuffer.AdjBaseLCY;
        ExchRateAdjReg."Adjusted Amt. (LCY)" := AdjExchRateBuffer.AdjAmount;
        //HEI.01>>
        CASE ExchRateAdjReg."Account Type" OF
            ExchRateAdjReg."Account Type"::"Bank Account":
                ExchRateAdjReg."Account No. FND" := ExchRateAdjReg."Account No. FND";
            ExchRateAdjReg."Account Type"::Customer:
                BEGIN
                    TempDtldCustLedgEntry.GET(CVDetailedEntryNo);
                    CustLedgerEntry.GET(TempDtldCustLedgEntry."Cust. Ledger Entry No.");
                    ExchRateAdjReg."Account No. FND" := CustLedgerEntry."Customer No.";
                    ExchRateAdjReg."Document No. FND" := CustLedgerEntry."Document No.";
                END;
            ExchRateAdjReg."Account Type"::Vendor:
                BEGIN
                    TempDtldVendLedgEntry.GET(CVDetailedEntryNo);
                    VendLedgerEntry.GET(TempDtldVendLedgEntry."Vendor Ledger Entry No.");
                    ExchRateAdjReg."Account No. FND" := VendLedgerEntry."Vendor No.";
                    ExchRateAdjReg."Document No. FND" := VendLedgerEntry."Document No.";
                END;
        END;
        //HEI.01<<
        IF NOT TestMode THEN
            //HEI.01
            ExchRateAdjReg.INSERT();
    end;

    //[Scope('Internal')]
    procedure InitializeRequest(NewStartDate: Date; NewEndDate: Date; NewPostingDescription: Text[50]; NewPostingDate: Date)
    begin
        StartDate := NewStartDate;
        EndDate := NewEndDate;
        PostingDescription := NewPostingDescription;
        PostingDate := NewPostingDate;
        IF EndDate = 0D THEN
            EndDateReq := DMY2DATE(31, 12, 9999)
        ELSE
            EndDateReq := EndDate;
    end;

    //[Scope('Internal')]
    procedure InitializeRequest2(NewStartDate: Date; NewEndDate: Date; NewPostingDescription: Text[50]; NewPostingDate: Date; NewPostingDocNo: Code[20]; NewAdjCustVendBank: Boolean; NewAdjGLAcc: Boolean; NewAdjBank: Boolean; NewAdjCust: Boolean; NewAdjVend: Boolean; NewTestMode: Boolean; NewSummarizeEntries: Boolean)
    begin
        InitializeRequest(NewStartDate, NewEndDate, NewPostingDescription, NewPostingDate);
        PostingDocNo := NewPostingDocNo;
        AdjCustVendBank := NewAdjCustVendBank;
        //HEI.01>>
        MaxAdjExchRateBufIndex := NewAdjVend;
        AdjBank := NewAdjBank;
        AdjCust := NewAdjCust;
        TestMode := NewTestMode;
        //HEI.01>>
        AdjGLAcc := NewAdjGLAcc;
    end;

    local procedure AdjExchRateBufferUpdate(CurrencyCode2: Code[10]; PostingGroup2: Code[10]; AdjBase2: Decimal; AdjBaseLCY2: Decimal; AdjAmount2: Decimal; GainsAmount2: Decimal; LossesAmount2: Decimal; DimEntryNo: Integer; Postingdate2: Date; ICCode: Code[20]; DetailedEntryNo: Integer; AccType: Integer; CVLedgerEntryNo: Integer)
    var
        AdjExchRateBufferAdjBase: Decimal;
        AdjExchRateBufferAdjBaseLCY: Decimal;
        AdjExchRateBufferAdjAmount: Decimal;
        AdjExchRateBufferTotalGainsAmount: Decimal;
        AdjExchRateBufferTotalLossesAmount: Decimal;
    begin
        AdjExchRateBuffer.INIT();
        OK := AdjExchRateBuffer.GET(CurrencyCode2, PostingGroup2, DimEntryNo, Postingdate2, ICCode);

        AdjExchRateBuffer.AdjBase := AdjExchRateBuffer.AdjBase + AdjBase2;
        AdjExchRateBuffer.AdjBaseLCY := AdjExchRateBuffer.AdjBaseLCY + AdjBaseLCY2;
        AdjExchRateBuffer.AdjAmount := AdjExchRateBuffer.AdjAmount + AdjAmount2;
        AdjExchRateBuffer.TotalGainsAmount := AdjExchRateBuffer.TotalGainsAmount + GainsAmount2;
        AdjExchRateBuffer.TotalLossesAmount := AdjExchRateBuffer.TotalLossesAmount + LossesAmount2;

        IF NOT OK THEN BEGIN
            AdjExchRateBuffer."Currency Code" := CurrencyCode2;
            AdjExchRateBuffer."Posting Group" := PostingGroup2;
            AdjExchRateBuffer."Dimension Entry No." := DimEntryNo;
            AdjExchRateBuffer."Posting Date" := Postingdate2;
            AdjExchRateBuffer."IC Partner Code" := ICCode;
            //HEI.01>>
            AdjExchRateBuffer."Detailed Entry No." := DetailedEntryNo;
            AdjExchRateBuffer."Acc Type" := AccType;
            //HEI.01<<

            AdjExchRateBuffer."CV Ledger Entry No." := CVLedgerEntryNo; //HEI.05

            AdjExchRateBuffer.INSERT();
        END ELSE
            AdjExchRateBuffer.MODIFY();

        //HEI.01>>
        //soica
        // AdjExchRateBuffer.INIT;
        // OK := AdjExchRateBuffer.GET(CurrencyCode2,PostingGroup2,DimEntryNo,Postingdate2+1,ICCode);
        //
        // AdjExchRateBuffer.AdjBase := AdjExchRateBufferAdjBase;
        // AdjExchRateBuffer.AdjBaseLCY := AdjExchRateBufferAdjBaseLCY;
        // AdjExchRateBuffer.AdjAmount := AdjExchRateBufferAdjAmount;
        // AdjExchRateBuffer.TotalGainsAmount := AdjExchRateBufferTotalGainsAmount;
        // AdjExchRateBuffer.TotalLossesAmount := AdjExchRateBufferTotalLossesAmount;
        //
        // IF NOT OK THEN BEGIN
        //  AdjExchRateBuffer."Currency Code" := CurrencyCode2;
        //  AdjExchRateBuffer."Posting Group" := PostingGroup2;
        //  AdjExchRateBuffer."Dimension Entry No." := DimEntryNo;
        //  AdjExchRateBuffer."Posting Date" := Postingdate2+1;
        //  AdjExchRateBuffer."IC Partner Code" := ICCode;
        //  //HEI.01>>
        //  AdjExchRateBuffer."Detailed Entry No." := DetailedEntryNo;
        //  AdjExchRateBuffer."Acc Type" := AccType;
        //  //HEI.01<<
        //  AdjExchRateBuffer.INSERT;
        // END ELSE
        //  AdjExchRateBuffer.MODIFY;
        //HEI.01<<
    end;

    local procedure HandlePostAdjmt(AdjustAccType: Integer)
    var
        GLEntry: Record "G/L Entry";
        DtldCVLedgerEntryAddit: Record "Detail CVLedgerEntry Addit FND";

    begin
        IF AdjExchRateBuffer.FIND('-') THEN BEGIN
            // Summarize per currency and dimension combination
            REPEAT
                AdjExchRateBuffer2.INIT();
                OK :=
                  AdjExchRateBuffer2.GET(
                    AdjExchRateBuffer."Currency Code",
                    '',
                    AdjExchRateBuffer."Dimension Entry No.",
                    AdjExchRateBuffer."Posting Date",
                    AdjExchRateBuffer."IC Partner Code",
                    AdjExchRateBuffer."Detailed Entry No.");//HEI.01

                AdjExchRateBuffer2.AdjBase := AdjExchRateBuffer2.AdjBase + AdjExchRateBuffer.AdjBase;
                AdjExchRateBuffer2.TotalGainsAmount := AdjExchRateBuffer2.TotalGainsAmount + AdjExchRateBuffer.TotalGainsAmount;
                AdjExchRateBuffer2.TotalLossesAmount := AdjExchRateBuffer2.TotalLossesAmount + AdjExchRateBuffer.TotalLossesAmount;
                IF NOT OK THEN BEGIN
                    AdjExchRateBuffer2."Currency Code" := AdjExchRateBuffer."Currency Code";
                    AdjExchRateBuffer2."Dimension Entry No." := AdjExchRateBuffer."Dimension Entry No.";
                    AdjExchRateBuffer2."Posting Date" := AdjExchRateBuffer."Posting Date";
                    AdjExchRateBuffer2."IC Partner Code" := AdjExchRateBuffer."IC Partner Code";
                    AdjExchRateBuffer2."Detailed Entry No." := AdjExchRateBuffer."Detailed Entry No.";//HEI.01
                    AdjExchRateBuffer2."CV Ledger Entry No." := AdjExchRateBuffer."CV Ledger Entry No."; //HEI.05
                    AdjExchRateBuffer2.INSERT();
                END ELSE
                    AdjExchRateBuffer2.MODIFY();
            UNTIL AdjExchRateBuffer.NEXT() = 0;

            // Post per posting group and per currency
            IF AdjExchRateBuffer2.FIND('-') THEN
                REPEAT
                    AdjExchRateBuffer.SETRANGE("Currency Code", AdjExchRateBuffer2."Currency Code");
                    AdjExchRateBuffer.SETRANGE("Dimension Entry No.", AdjExchRateBuffer2."Dimension Entry No.");
                    AdjExchRateBuffer.SETRANGE("Posting Date", AdjExchRateBuffer2."Posting Date");
                    AdjExchRateBuffer.SETRANGE("IC Partner Code", AdjExchRateBuffer2."IC Partner Code");
                    AdjExchRateBuffer.SETRANGE("Detailed Entry No.", AdjExchRateBuffer2."Detailed Entry No.");//HEI.01
                    TempDimBuf.RESET();
                    TempDimBuf.DELETEALL();
                    TempDimSetEntry.RESET();
                    TempDimSetEntry.DELETEALL();
                    AdjExchRateBuffer.FIND('-');
                    DimBufMgt.GetDimensions(AdjExchRateBuffer."Dimension Entry No.", TempDimBuf);
                    DimMgt.CopyDimBufToDimSetEntry(TempDimBuf, TempDimSetEntry);
                    REPEAT
                        IF AdjExchRateBuffer.AdjAmount <> 0 THEN
                            CASE AdjustAccType OF
                                1:
                                    // Customer
                                    BEGIN
                                        //HEI.08>>
                                        //CustPostingGr.GET("Posting Group");
                                        CustPostingGr.GET(AdjExchRateBuffer."Posting Group");
                                        //HEI.08<<
                                        CustPostingGr.TESTFIELD("Receivables Account");
                                        PostAdjmt(
                                          CustPostingGr."Receivables Account", AdjExchRateBuffer.AdjAmount, AdjExchRateBuffer.AdjBase, AdjExchRateBuffer."Currency Code", TempDimSetEntry,
                                          //AdjExchRateBuffer2."Posting Date","IC Partner Code");//HEI.01 delete
                                          //HEI.05>>
                                          //AdjExchRateBuffer2."Posting Date","IC Partner Code","Detailed Entry No.",2);//HEI.01 new line
                                          AdjExchRateBuffer2."Posting Date", AdjExchRateBuffer."IC Partner Code", AdjExchRateBuffer."Detailed Entry No.", AdjustAccType + 1, FORMAT(AdjExchRateBuffer."CV Ledger Entry No."));
                                        //HEI.05<<
                                        //HEI.08>>
                                        //InsertExchRateAdjmtReg(1,"Posting Group","Currency Code","Detailed Entry No.",'');//HEI.01 new line
                                        InsertExchRateAdjmtReg(valueforenum::Customer, AdjExchRateBuffer."Posting Group", AdjExchRateBuffer."Currency Code", AdjExchRateBuffer."Detailed Entry No.", '');//HEI.01 new line
                                                                                                                                                                                                         //HEI.08<<
                                    END;
                                2:
                                    // Vendor
                                    BEGIN
                                        //HEI.08>>
                                        VendPostingGr.GET(AdjExchRateBuffer."Posting Group");
                                        //VendPostingGr.GET("Posting Group");
                                        //HEI.08<<
                                        VendPostingGr.TESTFIELD("Payables Account");
                                        PostAdjmt(
                                          VendPostingGr."Payables Account", AdjExchRateBuffer.AdjAmount, AdjExchRateBuffer.AdjBase, AdjExchRateBuffer."Currency Code", TempDimSetEntry,
                                          //AdjExchRateBuffer2."Posting Date","IC Partner Code");//HEI.01 delete
                                          //HEI.05>>
                                          //AdjExchRateBuffer2."Posting Date","IC Partner Code","Detailed Entry No.",1);//HEI.01 new line
                                          AdjExchRateBuffer2."Posting Date", AdjExchRateBuffer."IC Partner Code", AdjExchRateBuffer."Detailed Entry No.", AdjustAccType + 1, FORMAT(AdjExchRateBuffer."CV Ledger Entry No."));
                                        //HEI.05<<
                                        //HEI.08>>
                                        //InsertExchRateAdjmtReg(2,"Posting Group","Currency Code","Detailed Entry No.",'');//HEI.01 new line
                                        InsertExchRateAdjmtReg(valueforenum::Vendor, AdjExchRateBuffer."Posting Group", AdjExchRateBuffer."Currency Code", AdjExchRateBuffer."Detailed Entry No.", '');//HEI.01 new line
                                                                                                                                                                                                       //HEI.08<<
                                    END;
                            END;
                    UNTIL AdjExchRateBuffer.NEXT() = 0;

                    Currency2.GET(AdjExchRateBuffer2."Currency Code");
                    IF AdjExchRateBuffer2.TotalGainsAmount <> 0 THEN BEGIN
                        //HEI.04>>
                        IF (GLSetup."Enable GT FX FND" = FALSE) THEN BEGIN
                            //HEI.04<<
                            Currency2.TESTFIELD("Unrealized Gains Acc.");
                            PostAdjmt(
                              Currency2."Unrealized Gains Acc.", -AdjExchRateBuffer2.TotalGainsAmount, AdjExchRateBuffer2.AdjBase, AdjExchRateBuffer2."Currency Code", TempDimSetEntry,
                              AdjExchRateBuffer2."Posting Date", AdjExchRateBuffer2."IC Partner Code",
                              //HEI.05>>
                              //"Detailed Entry No.","Acc Type");//HEI.01 new line
                              AdjExchRateBuffer2."Detailed Entry No.", AdjustAccType + 1, FORMAT(AdjExchRateBuffer2."CV Ledger Entry No."));
                            //HEI.05<<
                            //HEI.04>>
                        END ELSE BEGIN
                            CASE AdjustAccType OF
                                1:
                                    //Customer
                                    BEGIN
                                        Currency2.TESTFIELD("Unrealized GainAcc.Receiv. FND");
                                        PostAdjmt(
                                          Currency2."Unrealized GainAcc.Receiv. FND", -AdjExchRateBuffer2.TotalGainsAmount, AdjExchRateBuffer2.AdjBase, AdjExchRateBuffer2."Currency Code", TempDimSetEntry,
                                          AdjExchRateBuffer2."Posting Date", AdjExchRateBuffer2."IC Partner Code",
                                          //HEI.05>>
                                          //"Detailed Entry No.","Acc Type");//HEI.01 new line
                                          AdjExchRateBuffer2."Detailed Entry No.", AdjustAccType + 1, FORMAT(AdjExchRateBuffer2."CV Ledger Entry No."));
                                        //HEI.05<<
                                    END;
                                2:
                                    //Vendor
                                    BEGIN
                                        Currency2.TESTFIELD("Unrealized GainAcc.Payable FND");
                                        PostAdjmt(
                                          Currency2."Unrealized GainAcc.Payable FND", -AdjExchRateBuffer2.TotalGainsAmount, AdjExchRateBuffer2.AdjBase, AdjExchRateBuffer2."Currency Code", TempDimSetEntry,
                                          AdjExchRateBuffer2."Posting Date", AdjExchRateBuffer2."IC Partner Code",
                                          //HEI.05>>
                                          //"Detailed Entry No.","Acc Type");//HEI.01 new line
                                          AdjExchRateBuffer2."Detailed Entry No.", AdjustAccType + 1, FORMAT(AdjExchRateBuffer2."CV Ledger Entry No."));
                                        //HEI.05<<
                                    END;
                            END;
                        END;
                        //HEI.04<<
                    END;
                    IF AdjExchRateBuffer2.TotalLossesAmount <> 0 THEN BEGIN
                        //HEI.04>>
                        IF (GLSetup."Enable GT FX FND" = FALSE) THEN BEGIN
                            //HEI.04<<
                            Currency2.TESTFIELD("Unrealized Losses Acc.");
                            PostAdjmt(
                              Currency2."Unrealized Losses Acc.", -AdjExchRateBuffer2.TotalLossesAmount, AdjExchRateBuffer2.AdjBase, AdjExchRateBuffer2."Currency Code", TempDimSetEntry,
                              AdjExchRateBuffer2."Posting Date", AdjExchRateBuffer2."IC Partner Code",
                              //HEI.05>>
                              //"Detailed Entry No.","Acc Type");//HEI.01 new line
                              AdjExchRateBuffer2."Detailed Entry No.", AdjustAccType + 1, FORMAT(AdjExchRateBuffer2."CV Ledger Entry No."));
                            //HEI.05<<
                            //HEI.04>>
                        END ELSE BEGIN
                            CASE AdjustAccType OF
                                1:
                                    //Customer
                                    BEGIN
                                        Currency2.TESTFIELD("Unrealized LossAcc.Receiv. FND");
                                        PostAdjmt(
                                          Currency2."Unrealized LossAcc.Receiv. FND", -AdjExchRateBuffer2.TotalLossesAmount, AdjExchRateBuffer2.AdjBase, AdjExchRateBuffer2."Currency Code", TempDimSetEntry,
                                          AdjExchRateBuffer2."Posting Date", AdjExchRateBuffer2."IC Partner Code",
                                          //HEI.05>>
                                          //"Detailed Entry No.","Acc Type");//HEI.01 new line
                                          AdjExchRateBuffer2."Detailed Entry No.", AdjustAccType + 1, FORMAT(AdjExchRateBuffer2."CV Ledger Entry No."));
                                        //HEI.05<<
                                    END;
                                2:
                                    //Vendor
                                    BEGIN
                                        Currency2.TESTFIELD("Unrealized LossAcc.Payable FND");
                                        PostAdjmt(
                                          Currency2."Unrealized LossAcc.Payable FND", -AdjExchRateBuffer2.TotalLossesAmount, AdjExchRateBuffer2.AdjBase, AdjExchRateBuffer2."Currency Code", TempDimSetEntry,
                                          AdjExchRateBuffer2."Posting Date", AdjExchRateBuffer2."IC Partner Code",
                                          //HEI.05>>
                                          //"Detailed Entry No.","Acc Type");//HEI.01 new line
                                          AdjExchRateBuffer2."Detailed Entry No.", AdjustAccType + 1, FORMAT(AdjExchRateBuffer2."CV Ledger Entry No."));
                                        //HEI.05<<
                                    END;
                            END;
                        END;
                        //HEI.04<<
                    END;
                UNTIL AdjExchRateBuffer2.NEXT() = 0;

            IF NOT TestMode THEN BEGIN //HEI.01
                GLEntry.FINDLAST();
                CASE AdjustAccType OF
                    1: // Customer
                        BEGIN //HEI.06
                            IF TempDtldCustLedgEntry.FIND('-') THEN
                                REPEAT
                                    TempDtldCustLedgEntry."Transaction No." := GLEntry."Transaction No.";
                                    DtldCustLedgEntry := TempDtldCustLedgEntry;
                                    DtldCustLedgEntry.INSERT();
                                UNTIL TempDtldCustLedgEntry.NEXT() = 0;

                            //HEI.06>>
                            IF TempReverseDtldCustLedgEntry.FIND('-') THEN
                                REPEAT
                                    TempReverseDtldCustLedgEntry."Transaction No." := GLEntry."Transaction No.";
                                    DtldCustLedgEntry := TempReverseDtldCustLedgEntry;
                                    DtldCustLedgEntry.INSERT();

                                    DtldCVLedgerEntryAddit."Detaile CV Ledger Entry No." := TempReverseDtldCustLedgEntry."Entry No.";
                                    DtldCVLedgerEntryAddit."Source Type" := DtldCVLedgerEntryAddit."Source Type"::Customer;
                                    DtldCVLedgerEntryAddit."Reverse Unrealiz Gain/Loss" := TRUE;
                                    DtldCVLedgerEntryAddit."CV Ledger Entry No." := TempReverseDtldCustLedgEntry."Cust. Ledger Entry No.";
                                    IF DtldCVLedgerEntryAddit.INSERT() THEN;

                                UNTIL TempReverseDtldCustLedgEntry.NEXT() = 0;
                            //HEI.06<<
                        END; //HEI.06
                    2: // Vendor
                        BEGIN //HEI.05
                            IF TempDtldVendLedgEntry.FIND('-') THEN
                                REPEAT
                                    TempDtldVendLedgEntry."Transaction No." := GLEntry."Transaction No.";
                                    DtldVendLedgEntry := TempDtldVendLedgEntry;
                                    DtldVendLedgEntry.INSERT();
                                UNTIL TempDtldVendLedgEntry.NEXT() = 0;

                            //HEI.05>>
                            IF TempReverseDtldVendLedgEntry.FIND('-') THEN
                                REPEAT
                                    TempReverseDtldVendLedgEntry."Transaction No." := GLEntry."Transaction No.";
                                    DtldVendLedgEntry := TempReverseDtldVendLedgEntry;
                                    DtldVendLedgEntry.INSERT();

                                    DtldCVLedgerEntryAddit."Detaile CV Ledger Entry No." := TempReverseDtldVendLedgEntry."Entry No.";
                                    DtldCVLedgerEntryAddit."Source Type" := DtldCVLedgerEntryAddit."Source Type"::Vendor;
                                    DtldCVLedgerEntryAddit."Reverse Unrealiz Gain/Loss" := TRUE;
                                    DtldCVLedgerEntryAddit."CV Ledger Entry No." := TempReverseDtldVendLedgEntry."Vendor Ledger Entry No."; //HEI.06
                                    IF DtldCVLedgerEntryAddit.INSERT() THEN;

                                UNTIL TempReverseDtldVendLedgEntry.NEXT() = 0;
                        END;
                //HEI.05<<
                END;
            END; //HEI.01

            AdjExchRateBuffer.RESET();
            AdjExchRateBuffer.DELETEALL();
            AdjExchRateBuffer2.RESET();
            AdjExchRateBuffer2.DELETEALL();
            TempDtldCustLedgEntry.RESET();
            TempDtldCustLedgEntry.DELETEALL();
            TempDtldVendLedgEntry.RESET();
            TempDtldVendLedgEntry.DELETEALL();
        END;
    end;

    local procedure AdjustVATEntries(VATType: Integer; UseTax: Boolean)
    begin
        CLEAR(VATEntry2);
        VATEntry.SETRANGE(Type, VATType);
        VATEntry.SETRANGE("Use Tax", UseTax);
        IF VATEntry.FIND('-') THEN
            REPEAT
                Accumulate(VATEntry2.Base, VATEntry.Base);
                Accumulate(VATEntry2.Amount, VATEntry.Amount);
                Accumulate(VATEntry2."Unrealized Amount", VATEntry."Unrealized Amount");
                Accumulate(VATEntry2."Unrealized Base", VATEntry."Unrealized Base");
                Accumulate(VATEntry2."Remaining Unrealized Amount", VATEntry."Remaining Unrealized Amount");
                Accumulate(VATEntry2."Remaining Unrealized Base", VATEntry."Remaining Unrealized Base");
                Accumulate(VATEntry2."Additional-Currency Amount", VATEntry."Additional-Currency Amount");
                Accumulate(VATEntry2."Additional-Currency Base", VATEntry."Additional-Currency Base");
                Accumulate(VATEntry2."Add.-Currency Unrealized Amt.", VATEntry."Add.-Currency Unrealized Amt.");
                Accumulate(VATEntry2."Add.-Currency Unrealized Base", VATEntry."Add.-Currency Unrealized Base");
                Accumulate(VATEntry2."Add.-Curr. Rem. Unreal. Amount", VATEntry."Add.-Curr. Rem. Unreal. Amount");
                Accumulate(VATEntry2."Add.-Curr. Rem. Unreal. Base", VATEntry."Add.-Curr. Rem. Unreal. Base");

                Accumulate(VATEntryTotalBase.Base, VATEntry.Base);
                Accumulate(VATEntryTotalBase.Amount, VATEntry.Amount);
                Accumulate(VATEntryTotalBase."Unrealized Amount", VATEntry."Unrealized Amount");
                Accumulate(VATEntryTotalBase."Unrealized Base", VATEntry."Unrealized Base");
                Accumulate(VATEntryTotalBase."Remaining Unrealized Amount", VATEntry."Remaining Unrealized Amount");
                Accumulate(VATEntryTotalBase."Remaining Unrealized Base", VATEntry."Remaining Unrealized Base");
                Accumulate(VATEntryTotalBase."Additional-Currency Amount", VATEntry."Additional-Currency Amount");
                Accumulate(VATEntryTotalBase."Additional-Currency Base", VATEntry."Additional-Currency Base");
                Accumulate(VATEntryTotalBase."Add.-Currency Unrealized Amt.", VATEntry."Add.-Currency Unrealized Amt.");
                Accumulate(VATEntryTotalBase."Add.-Currency Unrealized Base", VATEntry."Add.-Currency Unrealized Base");
                Accumulate(
                  VATEntryTotalBase."Add.-Curr. Rem. Unreal. Amount", VATEntry."Add.-Curr. Rem. Unreal. Amount");
                Accumulate(VATEntryTotalBase."Add.-Curr. Rem. Unreal. Base", VATEntry."Add.-Curr. Rem. Unreal. Base");

                AdjustVATAmount(VATEntry.Base, VATEntry."Additional-Currency Base");
                AdjustVATAmount(VATEntry.Amount, VATEntry."Additional-Currency Amount");
                AdjustVATAmount(VATEntry."Unrealized Amount", VATEntry."Add.-Currency Unrealized Amt.");
                AdjustVATAmount(VATEntry."Unrealized Base", VATEntry."Add.-Currency Unrealized Base");
                AdjustVATAmount(VATEntry."Remaining Unrealized Amount", VATEntry."Add.-Curr. Rem. Unreal. Amount");
                AdjustVATAmount(VATEntry."Remaining Unrealized Base", VATEntry."Add.-Curr. Rem. Unreal. Base");
                IF NOT TestMode THEN
                    //HEI.01
                    VATEntry.MODIFY();

                Accumulate(VATEntry2.Base, -VATEntry.Base);
                Accumulate(VATEntry2.Amount, -VATEntry.Amount);
                Accumulate(VATEntry2."Unrealized Amount", -VATEntry."Unrealized Amount");
                Accumulate(VATEntry2."Unrealized Base", -VATEntry."Unrealized Base");
                Accumulate(VATEntry2."Remaining Unrealized Amount", -VATEntry."Remaining Unrealized Amount");
                Accumulate(VATEntry2."Remaining Unrealized Base", -VATEntry."Remaining Unrealized Base");
                Accumulate(VATEntry2."Additional-Currency Amount", -VATEntry."Additional-Currency Amount");
                Accumulate(VATEntry2."Additional-Currency Base", -VATEntry."Additional-Currency Base");
                Accumulate(VATEntry2."Add.-Currency Unrealized Amt.", -VATEntry."Add.-Currency Unrealized Amt.");
                Accumulate(VATEntry2."Add.-Currency Unrealized Base", -VATEntry."Add.-Currency Unrealized Base");
                Accumulate(VATEntry2."Add.-Curr. Rem. Unreal. Amount", -VATEntry."Add.-Curr. Rem. Unreal. Amount");
                Accumulate(VATEntry2."Add.-Curr. Rem. Unreal. Base", -VATEntry."Add.-Curr. Rem. Unreal. Base");
            UNTIL VATEntry.NEXT() = 0;
    end;

    local procedure AdjustVATAmount(var AmountLCY: Decimal; var AmountAddCurr: Decimal)
    begin
        CASE GLSetup."VAT Exchange Rate Adjustment" OF
            GLSetup."VAT Exchange Rate Adjustment"::"Adjust Amount":
                AmountLCY :=
                  ROUND(
                    CurrExchRate2.ExchangeAmtFCYToLCYAdjmt(
                      PostingDate, GLSetup."Additional Reporting Currency",
                      AmountAddCurr, AddCurrCurrencyFactor));
            GLSetup."VAT Exchange Rate Adjustment"::"Adjust Additional-Currency Amount":
                AmountAddCurr :=
                  ROUND(
                    CurrExchRate2.ExchangeAmtLCYToFCY(
                      PostingDate, GLSetup."Additional Reporting Currency",
                      AmountLCY, AddCurrCurrencyFactor));
        END;
    end;

    local procedure AdjustVATAccount(AccNo: Code[20]; AmountLCY: Decimal; AmountAddCurr: Decimal; BaseLCY: Decimal; BaseAddCurr: Decimal)
    begin
        "G/L Account".GET(AccNo);
        "G/L Account".SETRANGE("Date Filter", StartDate, EndDate);
        CASE GLSetup."VAT Exchange Rate Adjustment" OF
            GLSetup."VAT Exchange Rate Adjustment"::"Adjust Amount":
                PostGLAccAdjmt(
                  AccNo, GLSetup."VAT Exchange Rate Adjustment"::"Adjust Amount".AsInteger(),
                  -AmountLCY, BaseLCY, BaseAddCurr);
            GLSetup."VAT Exchange Rate Adjustment"::"Adjust Additional-Currency Amount":
                PostGLAccAdjmt(
                  AccNo, GLSetup."VAT Exchange Rate Adjustment"::"Adjust Additional-Currency Amount".AsInteger(),
                  -AmountAddCurr, BaseLCY, BaseAddCurr);
        END;
    end;

    local procedure AdjustPurchTax(UseTax: Boolean)
    begin
        IF (VATEntry2.Amount <> 0) OR (VATEntry2."Additional-Currency Amount" <> 0) THEN BEGIN
            TaxJurisdiction.TESTFIELD("Tax Account (Purchases)");
            AdjustVATAccount(
              TaxJurisdiction."Tax Account (Purchases)",
              VATEntry2.Amount, VATEntry2."Additional-Currency Amount",
              VATEntryTotalBase.Amount, VATEntryTotalBase."Additional-Currency Amount");
            IF UseTax THEN BEGIN
                TaxJurisdiction.TESTFIELD("Reverse Charge (Purchases)");
                AdjustVATAccount(
                  TaxJurisdiction."Reverse Charge (Purchases)",
                  -VATEntry2.Amount, -VATEntry2."Additional-Currency Amount",
                  -VATEntryTotalBase.Amount, -VATEntryTotalBase."Additional-Currency Amount");
            END;
        END;
        IF (VATEntry2."Remaining Unrealized Amount" <> 0) OR
           (VATEntry2."Add.-Curr. Rem. Unreal. Amount" <> 0)
        THEN BEGIN
            TaxJurisdiction.TESTFIELD("Unrealized VAT Type");
            TaxJurisdiction.TESTFIELD("Unreal. Tax Acc. (Purchases)");
            AdjustVATAccount(
              TaxJurisdiction."Unreal. Tax Acc. (Purchases)",
              VATEntry2."Remaining Unrealized Amount", VATEntry2."Add.-Curr. Rem. Unreal. Amount",
              VATEntryTotalBase."Remaining Unrealized Amount", VATEntry2."Add.-Curr. Rem. Unreal. Amount");

            IF UseTax THEN BEGIN
                TaxJurisdiction.TESTFIELD("Unreal. Rev. Charge (Purch.)");
                AdjustVATAccount(
                  TaxJurisdiction."Unreal. Rev. Charge (Purch.)",
                  -VATEntry2."Remaining Unrealized Amount",
                  -VATEntry2."Add.-Curr. Rem. Unreal. Amount",
                  -VATEntryTotalBase."Remaining Unrealized Amount",
                  -VATEntryTotalBase."Add.-Curr. Rem. Unreal. Amount");
            END;
        END;
    end;

    local procedure AdjustSalesTax()
    begin
        TaxJurisdiction.TESTFIELD("Tax Account (Sales)");
        AdjustVATAccount(
          TaxJurisdiction."Tax Account (Sales)",
          VATEntry2.Amount, VATEntry2."Additional-Currency Amount",
          VATEntryTotalBase.Amount, VATEntryTotalBase."Additional-Currency Amount");
        IF (VATEntry2."Remaining Unrealized Amount" <> 0) OR
           (VATEntry2."Add.-Curr. Rem. Unreal. Amount" <> 0)
        THEN BEGIN
            TaxJurisdiction.TESTFIELD("Unrealized VAT Type");
            TaxJurisdiction.TESTFIELD("Unreal. Tax Acc. (Sales)");
            AdjustVATAccount(
              TaxJurisdiction."Unreal. Tax Acc. (Sales)",
              VATEntry2."Remaining Unrealized Amount",
              VATEntry2."Add.-Curr. Rem. Unreal. Amount",
              VATEntryTotalBase."Remaining Unrealized Amount",
              VATEntryTotalBase."Add.-Curr. Rem. Unreal. Amount");
        END;
    end;

    local procedure Accumulate(var TotalAmount: Decimal; AmountToAdd: Decimal)
    begin
        TotalAmount := TotalAmount + AmountToAdd;
    end;

    local procedure PostGLAccAdjmt(GLAccNo: Code[20]; ExchRateAdjmt: Integer; Amount: Decimal; NetChange: Decimal; AddCurrNetChange: Decimal)
    begin
        GenJnlLine.INIT();
        CASE ExchRateAdjmt OF
            "G/L Account"."Exchange Rate Adjustment"::"Adjust Amount".AsInteger():
                BEGIN
                    GenJnlLine."Additional-Currency Posting" := GenJnlLine."Additional-Currency Posting"::"Amount Only";
                    GenJnlLine."Currency Code" := '';
                    GenJnlLine.Amount := Amount;
                    GenJnlLine."Amount (LCY)" := GenJnlLine.Amount;
                    GLAmtTotal := GLAmtTotal + GenJnlLine.Amount;
                    GLAddCurrNetChangeTotal := GLAddCurrNetChangeTotal + AddCurrNetChange;
                    GLNetChangeBase := GLNetChangeBase + NetChange;
                END;
            "G/L Account"."Exchange Rate Adjustment"::"Adjust Additional-Currency Amount".AsInteger():
                BEGIN
                    GenJnlLine."Additional-Currency Posting" := GenJnlLine."Additional-Currency Posting"::"Additional-Currency Amount Only";
                    GenJnlLine."Currency Code" := GLSetup."Additional Reporting Currency";
                    GenJnlLine.Amount := Amount;
                    GenJnlLine."Amount (LCY)" := 0;
                    GLAddCurrAmtTotal := GLAddCurrAmtTotal + GenJnlLine.Amount;
                    GLNetChangeTotal := GLNetChangeTotal + NetChange;
                    GLAddCurrNetChangeBase := GLAddCurrNetChangeBase + AddCurrNetChange;
                END;
        END;
        IF GenJnlLine.Amount <> 0 THEN BEGIN
            GenJnlLine."Document No." := PostingDocNo;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := GLAccNo;
            GenJnlLine."Posting Date" := PostingDate;
            CASE GenJnlLine."Additional-Currency Posting" OF
                GenJnlLine."Additional-Currency Posting"::"Amount Only":
                    GenJnlLine.Description :=
                      STRSUBSTNO(
                        PostingDescription,
                        GLSetup."Additional Reporting Currency",
                        //HEI.01>>
                        //AddCurrNetChange);
                        AddCurrNetChange, '', '');
                //HEI.01>>
                GenJnlLine."Additional-Currency Posting"::"Additional-Currency Amount Only":
                    GenJnlLine.Description :=
                      STRSUBSTNO(
                        PostingDescription,
                        '',
                        //HEI.01>>
                        //NetChange);
                        NetChange, '', '');
            //HEI.01>>
            END;
            GenJnlLine."System-Created Entry" := TRUE;
            GenJnlLine."Source Code" := SourceCodeSetup."Exchange Rate Adjmt.";
            IF NOT TestMode THEN BEGIN //HEI.01
                GetJnlLineDefDim(GenJnlLine, TempDimSetEntry);
                PostGenJnlLine(GenJnlLine, TempDimSetEntry);
            END; //HEI.01
        END;
    end;

    local procedure CheckExchRateAdjustment(AccNo: Code[20]; SetupTableName: Text[100]; SetupFieldName: Text[100])
    var
        GLAcc: Record "G/L Account";
        GLSetup: Record "General Ledger Setup";
    begin
        IF AccNo = '' THEN
            EXIT;
        GLAcc.GET(AccNo);
        IF GLAcc."Exchange Rate Adjustment" <> GLAcc."Exchange Rate Adjustment"::"No Adjustment" THEN BEGIN
            GLAcc."Exchange Rate Adjustment" := GLAcc."Exchange Rate Adjustment"::"No Adjustment";
            ERROR(
              Text017,
              GLAcc.FIELDCAPTION("Exchange Rate Adjustment"), GLAcc.TABLECAPTION,
              GLAcc."No.", GLAcc."Exchange Rate Adjustment",
              SetupTableName, GLSetup.FIELDCAPTION("VAT Exchange Rate Adjustment"),
              GLSetup.TABLECAPTION, SetupFieldName);
        END;
    end;

    local procedure HandleCustDebitCredit(Amount: Decimal; AmountLCY: Decimal; Correction: Boolean; AdjAmount: Decimal)
    begin
        IF ((Amount > 0) OR (AmountLCY > 0)) AND (NOT Correction) OR
           ((Amount < 0) OR (AmountLCY < 0)) AND Correction
        THEN BEGIN
            TempDtldCustLedgEntry."Debit Amount (LCY)" := AdjAmount;
            TempDtldCustLedgEntry."Credit Amount (LCY)" := 0;
        END ELSE BEGIN
            TempDtldCustLedgEntry."Debit Amount (LCY)" := 0;
            TempDtldCustLedgEntry."Credit Amount (LCY)" := -AdjAmount;
        END;
    end;

    local procedure HandleVendDebitCredit(Amount: Decimal; AmountLCY: Decimal; Correction: Boolean; AdjAmount: Decimal)
    begin
        IF ((Amount > 0) OR (AmountLCY > 0)) AND (NOT Correction) OR
           ((Amount < 0) OR (AmountLCY < 0)) AND Correction
        THEN BEGIN
            TempDtldVendLedgEntry."Debit Amount (LCY)" := AdjAmount;
            TempDtldVendLedgEntry."Credit Amount (LCY)" := 0;
        END ELSE BEGIN
            TempDtldVendLedgEntry."Debit Amount (LCY)" := 0;
            TempDtldVendLedgEntry."Credit Amount (LCY)" := -AdjAmount;
        END;
    end;

    local procedure GetJnlLineDefDim(var GenJnlLine: Record "Gen. Journal Line"; var DimSetEntry: Record "Dimension Set Entry")
    var
        TableID: array[10] of Integer;
        Table_ID: Integer;//BC Upgrade RD03
        No: array[10] of Code[20];
        "No.": Code[20];//BC Upgrade RD03
        DimManagement: Codeunit DimensionManagement;//BC Upgrade RD03
        DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];//BC Upgrade RD03
    begin
        CASE GenJnlLine."Account Type" OF
            GenJnlLine."Account Type"::"G/L Account":
                TableID[1] := DATABASE::"G/L Account";
            GenJnlLine."Account Type"::"Bank Account":
                TableID[1] := DATABASE::"Bank Account";
        END;
        No[1] := GenJnlLine."Account No.";
        Table_ID := TableID[1];//BC Upgrade RD03
        "No." := No[1];//BC Upgrade RD03
                       //DimMgt.GetDefaultDimID(TableID, No, "Source Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Dimension Set ID");
        DimManagement.AddDimSource(DefaultDimSource, Table_ID, "No.");//BC Upgrade RD03
        DimMgt.GetDefaultDimID(DefaultDimSource, SourceCodeSetup.Reminder, GenJnlLine."Shortcut Dimension 1 Code", GenJnlLine."Shortcut Dimension 2 Code", 0, 0);//BC Upgrade RD03
        DimMgt.GetDimSetEntryDefaultDim(DimSetEntry);
    end;

    local procedure CopyDimSetEntryToDimBuf(var DimSetEntry: Record "Dimension Set Entry"; var DimBuf: Record "Dimension Buffer")
    begin
        IF DimSetEntry.FIND('-') THEN
            REPEAT
                DimBuf."Table ID" := DATABASE::"Dimension Buffer";
                DimBuf."Entry No." := 0;
                DimBuf."Dimension Code" := DimSetEntry."Dimension Code";
                DimBuf."Dimension Value Code" := DimSetEntry."Dimension Value Code";
                DimBuf.INSERT();
            UNTIL DimSetEntry.NEXT() = 0;
    end;

    local procedure GetDimCombID(var DimBuf: Record "Dimension Buffer"): Integer
    var
        DimEntryNo: Integer;
    begin
        DimEntryNo := DimBufMgt.FindDimensions(DimBuf);
        IF DimEntryNo = 0 THEN
            DimEntryNo := DimBufMgt.InsertDimensions(DimBuf);
        EXIT(DimEntryNo);
    end;

    local procedure PostGenJnlLine(var GenJnlLine: Record "Gen. Journal Line"; var DimSetEntry: Record "Dimension Set Entry")
    begin
        GenJnlLine."Shortcut Dimension 1 Code" := GetGlobalDimVal(GLSetup."Global Dimension 1 Code", DimSetEntry);
        GenJnlLine."Shortcut Dimension 2 Code" := GetGlobalDimVal(GLSetup."Global Dimension 2 Code", DimSetEntry);
        GenJnlLine."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
        //HEI.02>>
        ////HEI.01>>
        //GenJnlLine."System-Created Entry" := TRUE;
        //InsertReversalGLEntry(GenJnlLine);
        ////HEI.01<<
        //HEI.02<<
        GenJnlPostLine.RUN(GenJnlLine);
    end;

    local procedure GetGlobalDimVal(GlobalDimCode: Code[20]; var DimSetEntry: Record "Dimension Set Entry"): Code[20]
    var
        DimVal: Code[20];
    begin
        IF GlobalDimCode = '' THEN
            DimVal := ''
        ELSE BEGIN
            DimSetEntry.SETRANGE("Dimension Code", GlobalDimCode);
            IF DimSetEntry.FIND('-') THEN
                DimVal := DimSetEntry."Dimension Value Code"
            ELSE
                DimVal := '';
            DimSetEntry.SETRANGE("Dimension Code");
        END;
        EXIT(DimVal);
    end;

    //[Scope('Internal')]
    procedure CheckPostingDate()
    begin
        IF PostingDate < StartDate THEN
            ERROR(Text018);
        IF PostingDate > EndDateReq THEN
            ERROR(Text018);
    end;

    //[Scope('Internal')]
    procedure AdjustCustomerLedgerEntry(CusLedgerEntry: Record "Cust. Ledger Entry"; PostingDate2: Date)
    var
        DimSetEntry: Record "Dimension Set Entry";
        DimEntryNo: Integer;
        OldAdjAmount: Decimal;
        Adjust: Boolean;
        OldAdjCurrFactor: Decimal;
        ReversalAmt: Decimal;
        ReversalAmtLCY: Decimal;
        DtldCustLedgEntryReversal: Record "Detailed Cust. Ledg. Entry";

        DtldVendLedgEntryAdd: Record "Detail CVLedgerEntry Addit FND";

    begin
        CusLedgerEntry.SETRANGE("Date Filter", 0D, PostingDate2);
        Currency2.GET(CusLedgerEntry."Currency Code");
        GainsAmount := 0;
        LossesAmount := 0;
        OldAdjAmount := 0;
        Adjust := FALSE;
        //HEI.06>>
        ReversalAmt := 0;
        ReversalAmtLCY := 0;
        //HEI.06<<
        TempDimSetEntry.RESET();
        TempDimSetEntry.DELETEALL();
        TempDimBuf.RESET();
        TempDimBuf.DELETEALL();
        DimSetEntry.SETRANGE("Dimension Set ID", CusLedgerEntry."Dimension Set ID");
        CopyDimSetEntryToDimBuf(DimSetEntry, TempDimBuf);
        DimEntryNo := GetDimCombID(TempDimBuf);

        CusLedgerEntry.CALCFIELDS(
          Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)", "Original Amt. (LCY)",
          "Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)");
        // Calculate Old Unrealized GainLoss
        DtldCustLedgEntry.RESET();
        DtldCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
        DtldCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CusLedgerEntry."Entry No.");
        DtldCustLedgEntry.SETRANGE(
          "Entry Type",
          DtldCustLedgEntry."Entry Type"::"Unrealized Loss",
          DtldCustLedgEntry."Entry Type"::"Unrealized Gain");
        DtldCustLedgEntry.CALCSUMS("Amount (LCY)");
        //HEI.06>>
        //calculate reversal
        DtldCustLedgEntryReversal.RESET();
        DtldCustLedgEntryReversal.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
        DtldCustLedgEntryReversal.SETRANGE("Cust. Ledger Entry No.", CusLedgerEntry."Entry No.");
        DtldCustLedgEntryReversal.SETRANGE(
          "Entry Type",
          DtldCustLedgEntryReversal."Entry Type"::"Unrealized Loss",
          DtldCustLedgEntryReversal."Entry Type"::"Unrealized Gain");
        IF DtldCustLedgEntryReversal.FINDFIRST() THEN
            REPEAT
                IF DtldVendLedgEntryAdd.GET(DtldCustLedgEntryReversal."Entry No.", DtldVendLedgEntryAdd."Source Type"::Customer) THEN BEGIN
                    ReversalAmt += DtldCustLedgEntryReversal.Amount;
                    ReversalAmtLCY += DtldCustLedgEntryReversal."Amount (LCY)";
                END;
            UNTIL DtldCustLedgEntryReversal.NEXT() = 0;
        //HEI.06<<
        TempDtldCustLedgEntry.RESET();
        TempDtldCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
        TempDtldCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CusLedgerEntry."Entry No.");
        TempDtldCustLedgEntry.SETRANGE(
          "Entry Type",
          TempDtldCustLedgEntry."Entry Type"::"Unrealized Loss",
          TempDtldCustLedgEntry."Entry Type"::"Unrealized Gain");
        TempDtldCustLedgEntry.CALCSUMS("Amount (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)");
        OldAdjAmount := DtldCustLedgEntry."Amount (LCY)" + TempDtldCustLedgEntry."Amount (LCY)";
        CusLedgerEntry."Remaining Amt. (LCY)" := CusLedgerEntry."Remaining Amt. (LCY)" + TempDtldCustLedgEntry."Amount (LCY)";
        CusLedgerEntry."Debit Amount (LCY)" := CusLedgerEntry."Debit Amount (LCY)" + TempDtldCustLedgEntry."Amount (LCY)";
        CusLedgerEntry."Credit Amount (LCY)" := CusLedgerEntry."Credit Amount (LCY)" + TempDtldCustLedgEntry."Amount (LCY)";
        TempDtldCustLedgEntry.RESET();
        //HEI.01>>
        OldAdjCurrFactor := CusLedgerEntry."Adjusted Currency Factor";
        //HEI.01<<
        // Modify Currency factor on Customer Ledger Entry
        IF CusLedgerEntry."Adjusted Currency Factor" <> Currency2."Currency Factor" THEN BEGIN
            //HEI.01 DELETE "Adjusted Currency Factor" := Currency2."Currency Factor";
            IF NOT TestMode THEN
                //HEI.01
                CusLedgerEntry.MODIFY();
        END;
        //HEI.01>>
        //HEI.05>>
        //AdjustedFactor := ROUND(1 / "Adjusted Currency Factor",0.0001);
        IF (Currency2."Currency Factor" <> 0) THEN
            AdjustedFactor := ROUND(1 / Currency2."Currency Factor", 0.0001);
        //HEI.05<<
        OldAdjAmount := 0;
        //HEI.01>>
        // Calculate New Unrealized GainLoss
        //HEI.06>>
        /*
        AdjAmount :=
          ROUND(
            CurrExchRate.ExchangeAmtFCYToLCYAdjmt(
              PostingDate2,Currency2.Code,"Remaining Amount",Currency2."Currency Factor")) -
          "Remaining Amt. (LCY)";
        */
        //HEI.09>>
        /*
        AdjAmount :=
          ROUND(
            CurrExchRate.ExchangeAmtFCYToLCYAdjmt(
              PostingDate2,Currency2.Code,"Remaining Amount",Currency2."Currency Factor")) -
          "Remaining Amt. (LCY)" + ReversalAmtLCY;
        */
        AdjAmount :=
          ROUND(
            CurrExchRate.ExchangeAmtFCYToLCYAdjmt(
              PostingDate2, Currency2.Code, CusLedgerEntry."Remaining Amount", Currency2."Currency Factor")) -
          CusLedgerEntry."Remaining Amt. (LCY)";
        //HEI.06<<
        //HEI.09<<
        IF AdjAmount <> 0 THEN BEGIN
            TempDtldCustLedgEntry.INIT();
            TempDtldCustLedgEntry."Entry No." := NewEntryNo;
            TempDtldCustLedgEntry."Cust. Ledger Entry No." := CusLedgerEntry."Entry No.";
            TempDtldCustLedgEntry."Posting Date" := PostingDate2;
            TempDtldCustLedgEntry."Document No." := PostingDocNo;
            TempDtldCustLedgEntry.Amount := 0;
            TempDtldCustLedgEntry."Customer No." := CusLedgerEntry."Customer No.";
            TempDtldCustLedgEntry."Currency Code" := CusLedgerEntry."Currency Code";
            TempDtldCustLedgEntry."User ID" := USERID;
            TempDtldCustLedgEntry."Source Code" := SourceCodeSetup."Exchange Rate Adjmt.";
            TempDtldCustLedgEntry."Journal Batch Name" := CusLedgerEntry."Journal Batch Name";
            TempDtldCustLedgEntry."Reason Code" := CusLedgerEntry."Reason Code";
            TempDtldCustLedgEntry."Initial Entry Due Date" := CusLedgerEntry."Due Date";
            TempDtldCustLedgEntry."Initial Entry Global Dim. 1" := CusLedgerEntry."Global Dimension 1 Code";
            TempDtldCustLedgEntry."Initial Entry Global Dim. 2" := CusLedgerEntry."Global Dimension 2 Code";
            TempDtldCustLedgEntry."Initial Document Type" := CusLedgerEntry."Document Type";
            //HEI.01>>
            TempDtldCustLedgEntry."Posting Group" := CusLedgerEntry."Customer Posting Group";
            //    TempDtldCustLedgEntry."Last Adjusted Curr. Factor" := OldAdjCurrFactor;
            //HEI.01<<
            Correction :=
              (CusLedgerEntry."Debit Amount" < 0) OR
              (CusLedgerEntry."Credit Amount" < 0) OR
              (CusLedgerEntry."Debit Amount (LCY)" < 0) OR
              (CusLedgerEntry."Credit Amount (LCY)" < 0);

            IF OldAdjAmount > 0 THEN
                CASE TRUE OF
                    (AdjAmount > 0):
                        BEGIN
                            TempDtldCustLedgEntry."Amount (LCY)" := AdjAmount;
                            TempDtldCustLedgEntry."Entry Type" := TempDtldCustLedgEntry."Entry Type"::"Unrealized Gain";
                            HandleCustDebitCredit(
                              CusLedgerEntry.Amount, CusLedgerEntry."Amount (LCY)", Correction, TempDtldCustLedgEntry."Amount (LCY)");
                            TempDtldCustLedgEntry.INSERT();
                            NewEntryNo := NewEntryNo + 1;
                            //HEI.02>>
                            //InsertReverseCLE(TempDtldCustLedgEntry,CusLedgerEntry);//HEI.01
                            //HEI.02<<
                            ReverseUnrealizLossGainDCLE(TempDtldCustLedgEntry, DimEntryNo);
                            //HEI.06
                            GainsAmount := AdjAmount;
                            Adjust := TRUE;
                        END;
                    (AdjAmount < 0):
                        IF -AdjAmount <= OldAdjAmount THEN BEGIN
                            TempDtldCustLedgEntry."Amount (LCY)" := AdjAmount;
                            TempDtldCustLedgEntry."Entry Type" := TempDtldCustLedgEntry."Entry Type"::"Unrealized Gain";
                            HandleCustDebitCredit(
                              CusLedgerEntry.Amount, CusLedgerEntry."Amount (LCY)", Correction, TempDtldCustLedgEntry."Amount (LCY)");
                            TempDtldCustLedgEntry.INSERT();
                            NewEntryNo := NewEntryNo + 1;
                            //HEI.02>>
                            //InsertReverseCLE(TempDtldCustLedgEntry,CusLedgerEntry);//HEI.01
                            //HEI.02<<
                            ReverseUnrealizLossGainDCLE(TempDtldCustLedgEntry, DimEntryNo);
                            //HEI.06
                            GainsAmount := AdjAmount;
                            Adjust := TRUE;
                        END ELSE BEGIN
                            AdjAmount := AdjAmount + OldAdjAmount;
                            TempDtldCustLedgEntry."Amount (LCY)" := -OldAdjAmount;
                            TempDtldCustLedgEntry."Entry Type" := TempDtldCustLedgEntry."Entry Type"::"Unrealized Gain";
                            HandleCustDebitCredit(
                              CusLedgerEntry.Amount, CusLedgerEntry."Amount (LCY)", Correction, TempDtldCustLedgEntry."Amount (LCY)");
                            TempDtldCustLedgEntry.INSERT();
                            NewEntryNo := NewEntryNo + 1;
                            //HEI.02>>
                            //InsertReverseCLE(TempDtldCustLedgEntry,CusLedgerEntry);//HEI.01
                            //HEI.02<<
                            ReverseUnrealizLossGainDCLE(TempDtldCustLedgEntry, DimEntryNo);
                            //HEI.06
                            AdjExchRateBufferUpdate(
                              CusLedgerEntry."Currency Code",
                               //HEI.08>>
                               //Customer."Customer Posting Group",
                               TempDtldCustLedgEntry."Posting Group",

                               //HEI.08<<
                               //HEI.01 delete line 0,0,-OldAdjAmount,-OldAdjAmount,0,DimEntryNo,PostingDate2,Customer."IC Partner Code");
                               //HEI.05>>
                               //0,0,-OldAdjAmount,-OldAdjAmount,0,DimEntryNo,PostingDate2,Customer."IC Partner Code",TempDtldCustLedgEntry."Entry No.",2);//HEI.01 new line
                               0, 0, -OldAdjAmount, -OldAdjAmount, 0, DimEntryNo, PostingDate2, Customer."IC Partner Code", TempDtldCustLedgEntry."Entry No.", 2, TempDtldCustLedgEntry."Cust. Ledger Entry No.");
                            //HEI.05<<
                            //ReverseUnrealizLossGainDCLE(TempDtldCustLedgEntry,DimEntryNo);//HEI.05>> //HEI.06
                            Adjust := FALSE;
                        END;
                END;
            IF OldAdjAmount < 0 THEN
                CASE TRUE OF
                    (AdjAmount < 0):
                        BEGIN
                            TempDtldCustLedgEntry."Amount (LCY)" := AdjAmount;
                            TempDtldCustLedgEntry."Entry Type" := TempDtldCustLedgEntry."Entry Type"::"Unrealized Loss";
                            HandleCustDebitCredit(
                              CusLedgerEntry.Amount, CusLedgerEntry."Amount (LCY)", Correction, TempDtldCustLedgEntry."Amount (LCY)");
                            TempDtldCustLedgEntry.INSERT();
                            NewEntryNo := NewEntryNo + 1;
                            //HEI.02>>
                            //InsertReverseCLE(TempDtldCustLedgEntry,CusLedgerEntry);//HEI.01
                            //HEI.02<<
                            ReverseUnrealizLossGainDCLE(TempDtldCustLedgEntry, DimEntryNo);
                            //HEI.06
                            LossesAmount := AdjAmount;
                            Adjust := TRUE;
                        END;
                    (AdjAmount > 0):
                        IF AdjAmount <= -OldAdjAmount THEN BEGIN
                            TempDtldCustLedgEntry."Amount (LCY)" := AdjAmount;
                            TempDtldCustLedgEntry."Entry Type" := TempDtldCustLedgEntry."Entry Type"::"Unrealized Loss";
                            HandleCustDebitCredit(
                              CusLedgerEntry.Amount, CusLedgerEntry."Amount (LCY)", Correction, TempDtldCustLedgEntry."Amount (LCY)");
                            TempDtldCustLedgEntry.INSERT();
                            NewEntryNo := NewEntryNo + 1;
                            //HEI.02>>
                            //InsertReverseCLE(TempDtldCustLedgEntry,CusLedgerEntry);//HEI.01
                            //HEI.02<<
                            ReverseUnrealizLossGainDCLE(TempDtldCustLedgEntry, DimEntryNo);
                            //HEI.06
                            LossesAmount := AdjAmount;
                            Adjust := TRUE;
                        END ELSE BEGIN
                            AdjAmount := OldAdjAmount + AdjAmount;
                            TempDtldCustLedgEntry."Amount (LCY)" := -OldAdjAmount;
                            TempDtldCustLedgEntry."Entry Type" := TempDtldCustLedgEntry."Entry Type"::"Unrealized Loss";
                            HandleCustDebitCredit(
                              CusLedgerEntry.Amount, CusLedgerEntry."Amount (LCY)", Correction, TempDtldCustLedgEntry."Amount (LCY)");
                            TempDtldCustLedgEntry.INSERT();
                            NewEntryNo := NewEntryNo + 1;

                            ReverseUnrealizLossGainDCLE(TempDtldCustLedgEntry, DimEntryNo);
                            //HEI.06
                            AdjExchRateBufferUpdate(
                              CusLedgerEntry."Currency Code",
                               //HEI.08>>
                               //Customer."Customer Posting Group",
                               TempDtldCustLedgEntry."Posting Group",

                               //HEI.08<<
                               //HEI.01 delete line 0,0,-OldAdjAmount,0,-OldAdjAmount,DimEntryNo,PostingDate2,Customer."IC Partner Code");
                               //HEI.05>>
                               //0,0,-OldAdjAmount,0,-OldAdjAmount,DimEntryNo,PostingDate2,Customer."IC Partner Code",TempDtldCustLedgEntry."Entry No.",2);
                               0, 0, -OldAdjAmount, 0, -OldAdjAmount, DimEntryNo, PostingDate2, Customer."IC Partner Code", TempDtldCustLedgEntry."Entry No.", 2, TempDtldCustLedgEntry."Cust. Ledger Entry No.");
                            //HEI.05<<
                            //HEI.02>>
                            ////HEI.01>>
                            //InsertReverseCLE(TempDtldCustLedgEntry,CusLedgerEntry);
                            ////HEI.01<<
                            //HEI.02<<
                            Adjust := FALSE;
                        END;
                END;
            IF NOT Adjust THEN BEGIN
                TempDtldCustLedgEntry."Amount (LCY)" := AdjAmount;
                HandleCustDebitCredit(CusLedgerEntry.Amount, CusLedgerEntry."Amount (LCY)", Correction, TempDtldCustLedgEntry."Amount (LCY)");
                TempDtldCustLedgEntry."Entry No." := NewEntryNo;
                IF AdjAmount < 0 THEN BEGIN
                    TempDtldCustLedgEntry."Entry Type" := TempDtldCustLedgEntry."Entry Type"::"Unrealized Loss";
                    GainsAmount := 0;
                    LossesAmount := AdjAmount;
                END ELSE
                    IF AdjAmount > 0 THEN BEGIN
                        TempDtldCustLedgEntry."Entry Type" := TempDtldCustLedgEntry."Entry Type"::"Unrealized Gain";
                        GainsAmount := AdjAmount;
                        LossesAmount := 0;
                    END;
                TempDtldCustLedgEntry.INSERT();
                NewEntryNo := NewEntryNo + 1;

                ReverseUnrealizLossGainDCLE(TempDtldCustLedgEntry, DimEntryNo);
                //HEI.06
                //HEI.02>>
                //InsertReverseCLE(TempDtldCustLedgEntry,CusLedgerEntry);//HEI.01
                //HEI.02<<
            END;

            TotalAdjAmount := TotalAdjAmount + AdjAmount;
            Window.UPDATE(4, TotalAdjAmount);
            AdjExchRateBufferUpdate(
              CusLedgerEntry."Currency Code",
              //HEI.08>>
              //Customer."Customer Posting Group",
              TempDtldCustLedgEntry."Posting Group",
              //HEI.08<<
              CusLedgerEntry."Remaining Amount", CusLedgerEntry."Remaining Amt. (LCY)", TempDtldCustLedgEntry."Amount (LCY)",
              //HEI.01 delete GainsAmount,LossesAmount,DimEntryNo,PostingDate2,Customer."IC Partner Code");
              //HEI.05>>
              //GainsAmount,LossesAmount,DimEntryNo,PostingDate2,Customer."IC Partner Code",TempDtldCustLedgEntry."Entry No.",2);
              GainsAmount, LossesAmount, DimEntryNo, PostingDate2, Customer."IC Partner Code", TempDtldCustLedgEntry."Entry No.", 2, TempDtldCustLedgEntry."Cust. Ledger Entry No.");
            //HEI.05<<
        END;

    end;

    //[Scope('Internal')]
    procedure AdjustVendorLedgerEntry(VendLedgerEntry: Record "Vendor Ledger Entry"; PostingDate2: Date)
    var
        DimSetEntry: Record "Dimension Set Entry";
        DimEntryNo: Integer;
        OldAdjAmount: Decimal;
        Adjust: Boolean;
        OldAdjCurrFactor: Decimal;
        DtldVendLedgEntryReversal: Record "Detailed Vendor Ledg. Entry";
        DtldVendLedgEntryAdd: Record "Detail CVLedgerEntry Addit FND";
        ReversalAmt: Decimal;
        ReversalAmtLCY: Decimal;
        i: Integer;
        a: Decimal;
        b: Decimal;
        c: Decimal;
        lEntryAlreadyReversed: Boolean;
        lAmtAdjusted: Decimal;
    begin
        VendLedgerEntry.SETRANGE("Date Filter", 0D, PostingDate2);
        Currency2.GET(VendLedgerEntry."Currency Code");
        GainsAmount := 0;
        LossesAmount := 0;
        OldAdjAmount := 0;
        Adjust := FALSE;
        //HEI.05>>
        ReversalAmt := 0;
        ReversalAmtLCY := 0;
        //HEI.05<<
        TempDimBuf.RESET();
        TempDimBuf.DELETEALL();
        DimSetEntry.SETRANGE("Dimension Set ID", VendLedgerEntry."Dimension Set ID");
        CopyDimSetEntryToDimBuf(DimSetEntry, TempDimBuf);
        DimEntryNo := GetDimCombID(TempDimBuf);

        VendLedgerEntry.CALCFIELDS(
          Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)", "Original Amt. (LCY)",
          "Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)");
        // Calculate Old Unrealized GainLoss
        DtldVendLedgEntry.RESET();
        DtldVendLedgEntry.SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type");
        DtldVendLedgEntry.SETRANGE("Vendor Ledger Entry No.", VendLedgerEntry."Entry No.");
        DtldVendLedgEntry.SETRANGE(
          "Entry Type",
          DtldVendLedgEntry."Entry Type"::"Unrealized Loss",
          DtldVendLedgEntry."Entry Type"::"Unrealized Gain");
        DtldVendLedgEntry.CALCSUMS("Amount (LCY)");
        OldAdjAmount := DtldVendLedgEntry."Amount (LCY)";
        //HEI.05>>
        //calculate reversal
        DtldVendLedgEntryReversal.RESET();
        DtldVendLedgEntryReversal.SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type");
        DtldVendLedgEntryReversal.SETRANGE("Vendor Ledger Entry No.", VendLedgerEntry."Entry No.");
        DtldVendLedgEntryReversal.SETRANGE(
          "Entry Type",
          DtldVendLedgEntryReversal."Entry Type"::"Unrealized Loss",
          DtldVendLedgEntryReversal."Entry Type"::"Unrealized Gain");
        IF DtldVendLedgEntryReversal.FINDFIRST() THEN
            REPEAT
                IF DtldVendLedgEntryAdd.GET(DtldVendLedgEntryReversal."Entry No.", 1) THEN BEGIN
                    ReversalAmt += DtldVendLedgEntryReversal.Amount;
                    ReversalAmtLCY += DtldVendLedgEntryReversal."Amount (LCY)"
                END;
            UNTIL DtldVendLedgEntryReversal.NEXT() = 0;
        //HEI.05<<
        TempDtldVendLedgEntry.RESET();
        TempDtldVendLedgEntry.SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type");
        TempDtldVendLedgEntry.SETRANGE("Vendor Ledger Entry No.", VendLedgerEntry."Entry No.");
        TempDtldVendLedgEntry.SETRANGE(
          "Entry Type",
          TempDtldVendLedgEntry."Entry Type"::"Unrealized Loss",
          TempDtldVendLedgEntry."Entry Type"::"Unrealized Gain");
        TempDtldVendLedgEntry.CALCSUMS("Amount (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)");
        OldAdjAmount := DtldVendLedgEntry."Amount (LCY)" + TempDtldVendLedgEntry."Amount (LCY)";
        VendLedgerEntry."Remaining Amt. (LCY)" := VendLedgerEntry."Remaining Amt. (LCY)" + TempDtldVendLedgEntry."Amount (LCY)";
        VendLedgerEntry."Debit Amount (LCY)" := VendLedgerEntry."Debit Amount (LCY)" + TempDtldVendLedgEntry."Amount (LCY)";
        VendLedgerEntry."Credit Amount (LCY)" := VendLedgerEntry."Credit Amount (LCY)" + TempDtldVendLedgEntry."Amount (LCY)";
        TempDtldVendLedgEntry.RESET();
        //HEI.01>>
        OldAdjCurrFactor := VendLedgerEntry."Adjusted Currency Factor";
        //HEI.01<<
        // Modify Currency factor on Vendor Ledger Entry
        IF VendLedgerEntry."Adjusted Currency Factor" <> Currency2."Currency Factor" THEN BEGIN
            //HEI.01 DELETE "Adjusted Currency Factor" := Currency2."Currency Factor";
            IF NOT TestMode THEN
                //HEI.01
                VendLedgerEntry.MODIFY();
        END;
        //HEI.01>>
        //HEI.05>>
        //AdjustedFactor := ROUND(1 / "Adjusted Currency Factor",0.0001);
        IF (Currency2."Currency Factor" <> 0) THEN
            AdjustedFactor := ROUND(1 / Currency2."Currency Factor", 0.0001);
        //HEI.05<<
        OldAdjAmount := 0;
        //HEI.01>>
        // Calculate New Unrealized GainLoss
        //HEI.05>>
        /*
        AdjAmount :=
          ROUND(
            CurrExchRate.ExchangeAmtFCYToLCYAdjmt(
              PostingDate2,Currency2.Code,"Remaining Amount",Currency2."Currency Factor")) -
          "Remaining Amt. (LCY)";
        */
        //HEI.09>>
        /*
        AdjAmount :=
          ROUND(
            CurrExchRate.ExchangeAmtFCYToLCYAdjmt(
              PostingDate2,Currency2.Code,"Remaining Amount",Currency2."Currency Factor")) -
          "Remaining Amt. (LCY)" + ReversalAmtLCY;
        */
        AdjAmount :=
          ROUND(
            CurrExchRate.ExchangeAmtFCYToLCYAdjmt(
              PostingDate2, Currency2.Code, VendLedgerEntry."Remaining Amount", Currency2."Currency Factor")) -
          VendLedgerEntry."Remaining Amt. (LCY)";
        //HEI.05<<
        //HEI.09<<
        IF AdjAmount <> 0 THEN BEGIN
            TempDtldVendLedgEntry.INIT();
            TempDtldVendLedgEntry."Entry No." := NewEntryNo;
            TempDtldVendLedgEntry."Vendor Ledger Entry No." := VendLedgerEntry."Entry No.";
            TempDtldVendLedgEntry."Posting Date" := PostingDate2;
            TempDtldVendLedgEntry."Document No." := PostingDocNo;
            TempDtldVendLedgEntry.Amount := 0;
            TempDtldVendLedgEntry."Vendor No." := VendLedgerEntry."Vendor No.";
            TempDtldVendLedgEntry."Currency Code" := VendLedgerEntry."Currency Code";
            TempDtldVendLedgEntry."User ID" := USERID;
            TempDtldVendLedgEntry."Source Code" := SourceCodeSetup."Exchange Rate Adjmt.";
            TempDtldVendLedgEntry."Journal Batch Name" := VendLedgerEntry."Journal Batch Name";
            TempDtldVendLedgEntry."Reason Code" := VendLedgerEntry."Reason Code";
            TempDtldVendLedgEntry."Initial Entry Due Date" := VendLedgerEntry."Due Date";
            TempDtldVendLedgEntry."Initial Entry Global Dim. 1" := VendLedgerEntry."Global Dimension 1 Code";
            TempDtldVendLedgEntry."Initial Entry Global Dim. 2" := VendLedgerEntry."Global Dimension 2 Code";
            TempDtldVendLedgEntry."Initial Document Type" := VendLedgerEntry."Document Type";
            //HEI.01>>
            TempDtldVendLedgEntry."Posting Group" := VendLedgerEntry."Vendor Posting Group";
            //TempDtldVendLedgEntry."Last Adjusted Curr. Factor" := OldAdjCurrFactor;
            //HEI.01<<
            Correction :=
              (VendLedgerEntry."Debit Amount" < 0) OR
              (VendLedgerEntry."Credit Amount" < 0) OR
              (VendLedgerEntry."Debit Amount (LCY)" < 0) OR
              (VendLedgerEntry."Credit Amount (LCY)" < 0);

            IF OldAdjAmount > 0 THEN
                CASE TRUE OF
                    (AdjAmount > 0):
                        BEGIN
                            TempDtldVendLedgEntry."Amount (LCY)" := AdjAmount;
                            TempDtldVendLedgEntry."Entry Type" := TempDtldVendLedgEntry."Entry Type"::"Unrealized Gain";
                            HandleVendDebitCredit(VendLedgerEntry.Amount, VendLedgerEntry."Amount (LCY)", Correction, TempDtldVendLedgEntry."Amount (LCY)");
                            //HEI.02>>
                            //InsertReverseVLE(TempDtldVendLedgEntry,VendLedgerEntry);//HEI.01
                            //HEI.02<<
                            TempDtldVendLedgEntry.INSERT();
                            NewEntryNo := NewEntryNo + 1;

                            ReverseUnrealizLossGainDVLE(TempDtldVendLedgEntry, DimEntryNo);
                            //HEI.05
                            GainsAmount := AdjAmount;
                            Adjust := TRUE;
                        END;
                    (AdjAmount < 0):
                        IF -AdjAmount <= OldAdjAmount THEN BEGIN
                            TempDtldVendLedgEntry."Amount (LCY)" := AdjAmount;
                            TempDtldVendLedgEntry."Entry Type" := TempDtldVendLedgEntry."Entry Type"::"Unrealized Gain";
                            HandleVendDebitCredit(
                              VendLedgerEntry.Amount, VendLedgerEntry."Amount (LCY)", Correction, TempDtldVendLedgEntry."Amount (LCY)");
                            //HEI.02>>
                            //InsertReverseVLE(TempDtldVendLedgEntry,VendLedgerEntry);//HEI.01
                            //HEI.02<<
                            TempDtldVendLedgEntry.INSERT();
                            NewEntryNo := NewEntryNo + 1;

                            ReverseUnrealizLossGainDVLE(TempDtldVendLedgEntry, DimEntryNo);
                            //HEI.05
                            GainsAmount := AdjAmount;
                            Adjust := TRUE;
                        END ELSE BEGIN
                            AdjAmount := AdjAmount + OldAdjAmount;
                            TempDtldVendLedgEntry."Amount (LCY)" := -OldAdjAmount;
                            TempDtldVendLedgEntry."Entry Type" := TempDtldVendLedgEntry."Entry Type"::"Unrealized Gain";
                            HandleVendDebitCredit(
                              VendLedgerEntry.Amount, VendLedgerEntry."Amount (LCY)", Correction, TempDtldVendLedgEntry."Amount (LCY)");
                            TempDtldVendLedgEntry.INSERT();
                            NewEntryNo := NewEntryNo + 1;

                            ReverseUnrealizLossGainDVLE(TempDtldVendLedgEntry, DimEntryNo);
                            //HEI.05
                            AdjExchRateBufferUpdate(
                              VendLedgerEntry."Currency Code",
                              //HEI.08>>
                              //Vendor."Vendor Posting Group",
                              TempDtldVendLedgEntry."Posting Group",
                              //HEI.08<<
                              //HEI.01 delete line 0,0,-OldAdjAmount,-OldAdjAmount,0,DimEntryNo,PostingDate2,Vendor."IC Partner Code");
                              //HEI.05>>
                              //0,0,-OldAdjAmount,-OldAdjAmount,0,DimEntryNo,PostingDate2,Vendor."IC Partner Code",TempDtldVendLedgEntry."Entry No.",3);//HEI.01 new line
                              0, 0, -OldAdjAmount, -OldAdjAmount, 0, DimEntryNo, PostingDate2, Vendor."IC Partner Code", TempDtldVendLedgEntry."Entry No.", 3, TempDtldVendLedgEntry."Vendor Ledger Entry No.");
                            //HEI.05<<
                            Adjust := FALSE;
                        END;
                END;
            IF OldAdjAmount < 0 THEN
                CASE TRUE OF
                    (AdjAmount < 0):
                        BEGIN
                            TempDtldVendLedgEntry."Amount (LCY)" := AdjAmount;
                            TempDtldVendLedgEntry."Entry Type" := TempDtldVendLedgEntry."Entry Type"::"Unrealized Loss";
                            HandleVendDebitCredit(VendLedgerEntry.Amount, VendLedgerEntry."Amount (LCY)", Correction, TempDtldVendLedgEntry."Amount (LCY)");
                            //HEI.02>>
                            //InsertReverseVLE(TempDtldVendLedgEntry,VendLedgerEntry);//HEI.01
                            //HEI.02<<
                            TempDtldVendLedgEntry.INSERT();
                            NewEntryNo := NewEntryNo + 1;

                            ReverseUnrealizLossGainDVLE(TempDtldVendLedgEntry, DimEntryNo);
                            //HEI.05
                            LossesAmount := AdjAmount;
                            Adjust := TRUE;
                        END;
                    (AdjAmount > 0):
                        IF AdjAmount <= -OldAdjAmount THEN BEGIN
                            TempDtldVendLedgEntry."Amount (LCY)" := AdjAmount;
                            TempDtldVendLedgEntry."Entry Type" := TempDtldVendLedgEntry."Entry Type"::"Unrealized Loss";
                            HandleVendDebitCredit(
                              VendLedgerEntry.Amount, VendLedgerEntry."Amount (LCY)", Correction, TempDtldVendLedgEntry."Amount (LCY)");
                            //HEI.02>>
                            //InsertReverseVLE(TempDtldVendLedgEntry,VendLedgerEntry);//HEI.01
                            //HEI.02<<
                            TempDtldVendLedgEntry.INSERT();
                            NewEntryNo := NewEntryNo + 1;

                            ReverseUnrealizLossGainDVLE(TempDtldVendLedgEntry, DimEntryNo);
                            //HEI.05
                            LossesAmount := AdjAmount;
                            Adjust := TRUE;
                        END ELSE BEGIN
                            AdjAmount := OldAdjAmount + AdjAmount;
                            TempDtldVendLedgEntry."Amount (LCY)" := -OldAdjAmount;
                            TempDtldVendLedgEntry."Entry Type" := TempDtldVendLedgEntry."Entry Type"::"Unrealized Loss";
                            HandleVendDebitCredit(
                              VendLedgerEntry.Amount, VendLedgerEntry."Amount (LCY)", Correction, TempDtldVendLedgEntry."Amount (LCY)");
                            //HEI.02>>
                            //InsertReverseVLE(TempDtldVendLedgEntry,VendLedgerEntry);//HEI.01
                            //HEI.02<<
                            TempDtldVendLedgEntry.INSERT();
                            NewEntryNo := NewEntryNo + 1;

                            ReverseUnrealizLossGainDVLE(TempDtldVendLedgEntry, DimEntryNo);
                            //HEI.05
                            AdjExchRateBufferUpdate(
                              VendLedgerEntry."Currency Code",
                              //HEI.08>>
                              //Vendor."Vendor Posting Group",
                              TempDtldVendLedgEntry."Posting Group",
                              //HEI.08<<
                              //HEI.01 delete line 0,0,-OldAdjAmount,0,-OldAdjAmount,DimEntryNo,PostingDate2,Vendor."IC Partner Code");
                              //HEI.05>>
                              //0,0,-OldAdjAmount,0,-OldAdjAmount,DimEntryNo,PostingDate2,Vendor."IC Partner Code",TempDtldVendLedgEntry."Entry No.",3);
                              0, 0, -OldAdjAmount, 0, -OldAdjAmount, DimEntryNo, PostingDate2, Vendor."IC Partner Code", TempDtldVendLedgEntry."Entry No.", 3, TempDtldVendLedgEntry."Vendor Ledger Entry No.");
                            //HEI.05<<
                            Adjust := FALSE;
                        END;
                END;

            IF NOT Adjust THEN BEGIN
                TempDtldVendLedgEntry."Amount (LCY)" := AdjAmount;
                HandleVendDebitCredit(VendLedgerEntry.Amount, VendLedgerEntry."Amount (LCY)", Correction, TempDtldVendLedgEntry."Amount (LCY)");
                TempDtldVendLedgEntry."Entry No." := NewEntryNo;
                IF AdjAmount < 0 THEN BEGIN
                    TempDtldVendLedgEntry."Entry Type" := TempDtldVendLedgEntry."Entry Type"::"Unrealized Loss";
                    GainsAmount := 0;
                    LossesAmount := AdjAmount;
                END ELSE
                    IF AdjAmount > 0 THEN BEGIN
                        TempDtldVendLedgEntry."Entry Type" := TempDtldVendLedgEntry."Entry Type"::"Unrealized Gain";
                        GainsAmount := AdjAmount;
                        LossesAmount := 0;
                    END;
                //HEI.02>>
                //InsertReverseVLE(TempDtldVendLedgEntry,VendLedgerEntry);//HEI.01
                //HEI.02<<
                TempDtldVendLedgEntry.INSERT();
                NewEntryNo := NewEntryNo + 1;

                ReverseUnrealizLossGainDVLE(TempDtldVendLedgEntry, DimEntryNo);
                //HEI.05
            END;

            TotalAdjAmount := TotalAdjAmount + AdjAmount;
            Window.UPDATE(4, TotalAdjAmount);
            AdjExchRateBufferUpdate(
              VendLedgerEntry."Currency Code",
              //HEI.08>>
              //Vendor."Vendor Posting Group",
              TempDtldVendLedgEntry."Posting Group",
              //HEI.08<<
              VendLedgerEntry."Remaining Amount", VendLedgerEntry."Remaining Amt. (LCY)",
              //HEI.01 delete TempDtldVendLedgEntry."Amount (LCY)",GainsAmount,LossesAmount,DimEntryNo,PostingDate2,Vendor."IC Partner Code");
              //HEI.05>>
              //TempDtldVendLedgEntry."Amount (LCY)",GainsAmount,LossesAmount,DimEntryNo,PostingDate2,Vendor."IC Partner Code",TempDtldVendLedgEntry."Entry No.",3);//HEI.01 new line
              TempDtldVendLedgEntry."Amount (LCY)", GainsAmount, LossesAmount, DimEntryNo, PostingDate2, Vendor."IC Partner Code", TempDtldVendLedgEntry."Entry No.", 3, TempDtldVendLedgEntry."Vendor Ledger Entry No.");
            //HEI.05<<
        END;

    end;

    local procedure CustLedgEntryToCVLedgEntry("Entry No.": Integer)
    begin
        //HEI.01>>
        IF CustLedgerEntry.GET("Entry No.") THEN BEGIN
            CVLedgEntryBuffer."Document Type" := CustLedgerEntry."Document Type";
            CVLedgEntryBuffer."Document No." := CustLedgerEntry."Document No.";
        END;
        //HEI.01>>
    end;

    local procedure VendLedgEntryToCVLedgEntry("Entry No.": Integer)
    begin
        //HEI.01>>
        IF VendorLedgerEntry.GET("Entry No.") THEN BEGIN
            CVLedgEntryBuffer."Document Type" := VendorLedgerEntry."Document Type";
            CVLedgEntryBuffer."Document No." := VendorLedgerEntry."Document No.";
        END;
        //HEI.01>>
    end;

    local procedure UpdateAdjDebitCredit()
    begin
        //HEI.01>>
        IF AdjAmount <> 0 THEN BEGIN
            IF AdjExchRateBuffer.TotalGainsAmount <> 0 THEN BEGIN
                GainOrLoss := Text50002;
                SetAdjDebitCredit(-AdjExchRateBuffer.TotalGainsAmount, AdjCredit, AdjDebit);
            END;
            IF AdjExchRateBuffer.TotalLossesAmount <> 0 THEN BEGIN
                GainOrLoss2 := Text50003;
                SetAdjDebitCredit(-AdjExchRateBuffer.TotalLossesAmount, AdjCredit2, AdjDebit2);
            END;
        END;
        //HEI.01>>
    end;

    local procedure SetAdjDebitCredit(TotalCreditDebitAmount: Decimal; var VarAdjCredit: Decimal; var VarAdjDebit: Decimal)
    begin
        //HEI.01>>
        IF TotalCreditDebitAmount > 0 THEN
            VarAdjDebit := TotalCreditDebitAmount
        ELSE
            VarAdjCredit := TotalCreditDebitAmount;
        TotalDtAmt := TotalDtAmt + VarAdjDebit;
        TotalCrAmt := TotalCrAmt + VarAdjCredit;
        //HEI.01<<
    end;

    local procedure InitAdjDebitCredit()
    begin
        //HEI.01>>
        AdjDebit := 0;
        AdjCredit := 0;
        AdjDebit2 := 0;
        AdjCredit2 := 0;
        //HEI.01<<
    end;

    local procedure InsertReverseCLE(var OldDetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; var OldCustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        IF TestMode THEN
            EXIT;
        NextLineNoC := NextLineNoC + 1;
        TmpDetailedCustLedgEntry.TRANSFERFIELDS(OldDetailedCustLedgEntry);
        TmpDetailedCustLedgEntry."Posting Date" := ReversalPostingDate;
        TmpDetailedCustLedgEntry.Amount := -OldDetailedCustLedgEntry.Amount;
        TmpDetailedCustLedgEntry."Amount (LCY)" := -OldDetailedCustLedgEntry."Amount (LCY)";
        TmpDetailedCustLedgEntry."Debit Amount" := -OldDetailedCustLedgEntry."Debit Amount";
        TmpDetailedCustLedgEntry."Credit Amount" := -OldDetailedCustLedgEntry."Credit Amount";
        TmpDetailedCustLedgEntry."Debit Amount (LCY)" := -OldDetailedCustLedgEntry."Debit Amount (LCY)";
        TmpDetailedCustLedgEntry."Credit Amount (LCY)" := -OldDetailedCustLedgEntry."Credit Amount (LCY)";
        TmpDetailedCustLedgEntry."Entry No." := NextLineNoC;
        TmpDetailedCustLedgEntry.INSERT();
    end;

    local procedure InsertReverseVLE(var OldDetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; var OldVendLedgerEntry: Record "Vendor Ledger Entry")
    begin
        IF TestMode THEN
            EXIT;
        NextLineNoV := NextLineNoV + 1;
        TmpDetailedVendLedgEntry.TRANSFERFIELDS(OldDetailedVendLedgEntry);
        TmpDetailedVendLedgEntry."Posting Date" := ReversalPostingDate;
        TmpDetailedVendLedgEntry.Amount := -OldDetailedVendLedgEntry.Amount;
        TmpDetailedVendLedgEntry."Amount (LCY)" := -OldDetailedVendLedgEntry."Amount (LCY)";
        TmpDetailedVendLedgEntry."Debit Amount" := -OldDetailedVendLedgEntry."Debit Amount";
        TmpDetailedVendLedgEntry."Credit Amount" := -OldDetailedVendLedgEntry."Credit Amount";
        TmpDetailedVendLedgEntry."Debit Amount (LCY)" := -OldDetailedVendLedgEntry."Debit Amount (LCY)";
        TmpDetailedVendLedgEntry."Credit Amount (LCY)" := -OldDetailedVendLedgEntry."Credit Amount (LCY)";
        TmpDetailedVendLedgEntry."Entry No." := NextLineNoV;
        TmpDetailedVendLedgEntry.INSERT();
    end;

    local procedure InsertReversalGLEntry(var InsertedGLJnl: Record "Gen. Journal Line")
    begin
        IF TestMode THEN
            EXIT;

        NextLineGL += 1;
        TempGenJournalLine.INIT();
        TempGenJournalLine.TRANSFERFIELDS(InsertedGLJnl);
        //HEI.02>>
        //TempGenJournalLine.VALIDATE("Posting Date",ReversalPostingDate);
        TempGenJournalLine.VALIDATE("Posting Date", PostingDate);
        //HEI.02<<
        TempGenJournalLine.Amount := -InsertedGLJnl.Amount;
        TempGenJournalLine."Amount (LCY)" := -InsertedGLJnl."Amount (LCY)";
        //TempGenJournalLine."Debit Amount" := - InsertedGLJnl."Credit Amount";
        //TempGenJournalLine."Credit Amount" := - InsertedGLJnl."Debit Amount";}
        TempGenJournalLine."Line No." := NextLineGL;
        TempGenJournalLine.INSERT();

        //GenJnlPostLine.RUN(TempGenJournalLine);

        //TempGenJournalLine.INSERT;
        //TempGenJournalLine.am
    end;

    local procedure ReverseUnrealizLossGainDCLE(InitialTempDetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry" temporary; DimEntryNo: Integer)
    var
        lDetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        AppAmt: Decimal;
        lDetailedCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        lAmt2: Decimal;
        lDetailedCustLedgEntry3: Record "Detailed Cust. Ledg. Entry";
    begin
        //creates lines in Detailed Cust. Ledger Entry
        //HEI.05>>
        //HEI.06>>
        /*
        IF (PostingDate >= GLSetup."Reversal Reev. Activate Date")
          AND (GLSetup."Reversal Reev. Activate Date" <> 0D)
        THEN BEGIN
        */
        //HEI.06<<
        lDetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", InitialTempDetailedCustLedgEntry."Cust. Ledger Entry No.");
        lDetailedCustLedgEntry.SETFILTER("Posting Date", '>%1', PostingDate);
        lDetailedCustLedgEntry.SETFILTER("Entry Type", '%1', lDetailedCustLedgEntry."Entry Type"::Application);
        lDetailedCustLedgEntry.CALCSUMS(Amount);
        AppAmt := lDetailedCustLedgEntry.Amount;
        IF AppAmt <> 0 THEN BEGIN
            TempReverseDtldCustLedgEntry.INIT();
            TempReverseDtldCustLedgEntry.TRANSFERFIELDS(InitialTempDetailedCustLedgEntry);
            TempReverseDtldCustLedgEntry."Entry No." := NewEntryNo;
            TempReverseDtldCustLedgEntry."Amount (LCY)" := -InitialTempDetailedCustLedgEntry."Amount (LCY)";
            TempReverseDtldCustLedgEntry."Debit Amount (LCY)" := -InitialTempDetailedCustLedgEntry."Debit Amount (LCY)";
            TempReverseDtldCustLedgEntry."Credit Amount (LCY)" := -InitialTempDetailedCustLedgEntry."Credit Amount (LCY)";
            //HEI.07>>
            //HEI.09>>
            /*
            lDetailedCustLedgEntry2.RESET;
            lDetailedCustLedgEntry2.SETCURRENTKEY("Cust. Ledger Entry No.","Entry Type");
            lDetailedCustLedgEntry2.SETRANGE("Cust. Ledger Entry No.",TempReverseDtldCustLedgEntry."Cust. Ledger Entry No.");
            lDetailedCustLedgEntry2.CALCSUMS(Amount);
            lAmt2 := lDetailedCustLedgEntry2.Amount;
            IF lAmt2 = 0 THEN
              BEGIN
            */
            //HEI.09<<
            lDetailedCustLedgEntry3.RESET();
            lDetailedCustLedgEntry3.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
            lDetailedCustLedgEntry3.SETRANGE("Cust. Ledger Entry No.", TempReverseDtldCustLedgEntry."Cust. Ledger Entry No.");
            lDetailedCustLedgEntry3.SETRANGE("Entry Type", lDetailedCustLedgEntry3."Entry Type"::Application);
            IF lDetailedCustLedgEntry3.FINDLAST() THEN
                IF (TempReverseDtldCustLedgEntry."Posting Date" < lDetailedCustLedgEntry3."Posting Date") THEN
                    TempReverseDtldCustLedgEntry."Posting Date" := lDetailedCustLedgEntry3."Posting Date";
            //END; //HEI.09
            //HEI.07<<
            TempReverseDtldCustLedgEntry.INSERT();
            NewEntryNo += 1;
            IF NOT TestMode THEN
                ReversalHandlePostAdjmt(1, TempReverseDtldCustLedgEntry."Amount (LCY)", TempReverseDtldCustLedgEntry, TempReverseDtldVendLedgEntry, DimEntryNo);
        END;
        //END; //HEI.06
        //HEI.05<<

    end;

    local procedure ReverseUnrealizLossGainDVLE(InitialTempDetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry" temporary; DimEntryNo: Integer)
    var
        lDetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        AppAmt: Decimal;
        lVendLedEntry: Record "Vendor Ledger Entry";
        lDetailedVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
        lAmt2: Decimal;
        lDetailedVendLedgEntry3: Record "Detailed Vendor Ledg. Entry";
    begin
        //creates lines in Detailed Vendor Ledger Entry
        //HEI.05>>
        //HEI.06>>
        /*
        IF (PostingDate >= GLSetup."Reversal Reev. Activate Date")
            AND (GLSetup."Reversal Reev. Activate Date" <> 0D)
        THEN BEGIN
        */
        //HEI.06<<
        lDetailedVendLedgEntry.SETRANGE("Vendor Ledger Entry No.", InitialTempDetailedVendLedgEntry."Vendor Ledger Entry No.");
        lDetailedVendLedgEntry.SETFILTER("Posting Date", '>%1', PostingDate);
        lDetailedVendLedgEntry.SETFILTER("Entry Type", '%1', lDetailedVendLedgEntry."Entry Type"::Application);
        lDetailedVendLedgEntry.CALCSUMS(Amount);
        AppAmt := lDetailedVendLedgEntry.Amount;
        IF AppAmt <> 0 THEN BEGIN
            TempReverseDtldVendLedgEntry.INIT();
            TempReverseDtldVendLedgEntry.TRANSFERFIELDS(InitialTempDetailedVendLedgEntry);
            TempReverseDtldVendLedgEntry."Entry No." := NewEntryNo;
            TempReverseDtldVendLedgEntry."Amount (LCY)" := -InitialTempDetailedVendLedgEntry."Amount (LCY)";
            TempReverseDtldVendLedgEntry."Debit Amount (LCY)" := -InitialTempDetailedVendLedgEntry."Debit Amount (LCY)";
            TempReverseDtldVendLedgEntry."Credit Amount (LCY)" := -InitialTempDetailedVendLedgEntry."Credit Amount (LCY)";
            //HEI.07>>
            //HEI.09>>
            /*
            lDetailedVendLedgEntry2.RESET;
            lDetailedVendLedgEntry2.SETCURRENTKEY("Vendor Ledger Entry No.","Entry Type");
            lDetailedVendLedgEntry2.SETRANGE("Vendor Ledger Entry No.",TempReverseDtldVendLedgEntry."Vendor Ledger Entry No.");
            lDetailedVendLedgEntry2.CALCSUMS(Amount);
            lAmt2 := lDetailedVendLedgEntry2.Amount;
            IF lAmt2 = 0 THEN
              BEGIN
            */
            //HEI.09<<
            lDetailedVendLedgEntry3.RESET();
            lDetailedVendLedgEntry3.SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type");
            lDetailedVendLedgEntry3.SETRANGE("Vendor Ledger Entry No.", TempReverseDtldVendLedgEntry."Vendor Ledger Entry No.");
            lDetailedVendLedgEntry3.SETRANGE("Entry Type", lDetailedVendLedgEntry3."Entry Type"::Application);
            IF lDetailedVendLedgEntry3.FINDLAST() THEN
                IF (TempReverseDtldVendLedgEntry."Posting Date" < lDetailedVendLedgEntry3."Posting Date") THEN
                    TempReverseDtldVendLedgEntry."Posting Date" := lDetailedVendLedgEntry3."Posting Date";
            //END; //HEI.09
            //HEI.07<<
            TempReverseDtldVendLedgEntry.INSERT();
            NewEntryNo += 1;
            IF NOT TestMode THEN
                ReversalHandlePostAdjmt(2, TempReverseDtldVendLedgEntry."Amount (LCY)", TempReverseDtldCustLedgEntry, TempReverseDtldVendLedgEntry, DimEntryNo);
        END;
        //END; //HEI.06
        //HEI.05<<

    end;

    local procedure ReversalCreateGenJnlLine(GLAccNo: Code[20]; PostingAmount: Decimal; AdjBase2: Decimal; CurrencyCode2: Code[10]; PostingDate2: Date; CVEntryNo: Integer; var DimSetEntry: Record "Dimension Set Entry"; AccType: Integer; CVLedgEntryNo: Text)
    var
        lCustLedgEntry: Record "Cust. Ledger Entry";
        lVendLedgEntry: Record "Vendor Ledger Entry";
        lPostingDate: Date;
        lDetCustLedEntry: Record "Detailed Cust. Ledg. Entry";
        lDetVendLedEntry: Record "Detailed Vendor Ledg. Entry";
        lCVLedgEntryNoInt: Integer;
        lAmt2: Decimal;
        lDetCustLedEntry2: Record "Detailed Cust. Ledg. Entry";
        lDetVendLedEntry2: Record "Detailed Vendor Ledg. Entry";
    begin
        //create lines in GL Entry with description that contains "R-"
        //HEI.05>>
        IF PostingAmount <> 0 THEN BEGIN
            GenJnlLine.INIT();
            //HEI.09>>
            //VALIDATE("Posting Date",PostingDate);
            lPostingDate := PostingDate;
            EVALUATE(lCVLedgEntryNoInt, CVLedgEntryNo);
            CASE AccType OF
                1:
                    // Customer
                    BEGIN
                        lDetCustLedEntry2.RESET();
                        lDetCustLedEntry2.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type");
                        lDetCustLedEntry2.SETRANGE("Cust. Ledger Entry No.", lCVLedgEntryNoInt);
                        lDetCustLedEntry2.SETRANGE("Entry Type", lDetCustLedEntry2."Entry Type"::Application);
                        IF lDetCustLedEntry2.FINDLAST() THEN
                            IF (PostingDate2 < lDetCustLedEntry2."Posting Date") THEN
                                lPostingDate := lDetCustLedEntry2."Posting Date";
                    END;
                2:
                    // Vendor
                    BEGIN
                        lDetVendLedEntry2.RESET();
                        lDetVendLedEntry2.SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type");
                        lDetVendLedEntry2.SETRANGE("Vendor Ledger Entry No.", lCVLedgEntryNoInt);
                        lDetVendLedEntry2.SETRANGE("Entry Type", lDetVendLedEntry2."Entry Type"::Application);
                        IF lDetVendLedEntry2.FINDLAST() THEN
                            IF (PostingDate2 < lDetVendLedEntry2."Posting Date") THEN
                                lPostingDate := lDetVendLedEntry2."Posting Date";
                    END;
            END;
            GenJnlLine.VALIDATE("Posting Date", lPostingDate);
            //HEI.09<<
            GenJnlLine."Document No." := PostingDocNo;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine.VALIDATE("Account No.", GLAccNo);
            GenJnlLine.Description := PADSTR(STRSUBSTNO('R-' + PostingDescription, CurrencyCode2, AdjBase2), STRLEN(PostingDescription));
            GenJnlLine.VALIDATE(Amount, PostingAmount);
            GenJnlLine."Source Currency Code" := CurrencyCode2;
            GenJnlLine."CV Detailed Entry No. FND" := CVEntryNo;
            GenJnlLine."Adj. Exchange Rate Type FND" := AccType + 1;
            IF CurrencyCode2 = GLSetup."Additional Reporting Currency" THEN
                GenJnlLine."Source Currency Amount" := 0;
            GenJnlLine."Source Code" := SourceCodeSetup."Exchange Rate Adjmt.";
            GenJnlLine."System-Created Entry" := TRUE;
            GenJnlLine."Additional Description FND" := CVLedgEntryNo;
            IF NOT TestMode THEN
                PostGenJnlLine(GenJnlLine, DimSetEntry);
        END;
        //HEI.05<<
    end;

    local procedure ReversalHandlePostAdjmt(AdjustAccType: Integer; ReversalAmount: Decimal; lDtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; lDtldVendLedgerEntry: Record "Detailed Vendor Ledg. Entry"; DimEntryNo: Integer)
    var
        GLEntry: Record "G/L Entry";
        lCustLedgEntry: Record "Cust. Ledger Entry";
        lVendLedgEntry: Record "Vendor Ledger Entry";
        lTempDimBuf: Record "Dimension Buffer" temporary;
        lTempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimSetEntry: Record "Dimension Selection Buffer";
        CurrCode: Code[10];
    begin
        //HEI.05>>
        TempDimSetEntry.RESET();
        TempDimSetEntry.DELETEALL();
        TempDimBuf.RESET();
        TempDimBuf.DELETEALL();

        CASE AdjustAccType OF
            1: // Customer
                BEGIN
                    lCustLedgEntry.GET(lDtldCustLedgEntry."Cust. Ledger Entry No.");
                    lCustLedgEntry.SETRANGE("Date Filter", 0D, EndDate);
                    lCustLedgEntry.CALCFIELDS("Remaining Amount");
                    DimBufMgt.GetDimensions(DimEntryNo, TempDimBuf);
                    DimMgt.CopyDimBufToDimSetEntry(TempDimBuf, TempDimSetEntry);
                    CurrCode := lCustLedgEntry."Currency Code";
                END;
            2: // Vendor
                BEGIN
                    lVendLedgEntry.GET(lDtldVendLedgerEntry."Vendor Ledger Entry No.");
                    lVendLedgEntry.SETRANGE("Date Filter", 0D, EndDate);
                    lVendLedgEntry.CALCFIELDS("Remaining Amount");
                    DimBufMgt.GetDimensions(DimEntryNo, TempDimBuf);
                    DimMgt.CopyDimBufToDimSetEntry(TempDimBuf, TempDimSetEntry);
                    CurrCode := lVendLedgEntry."Currency Code";
                END;
        END;
        IF ReversalAmount <> 0 THEN BEGIN
            CASE AdjustAccType OF
                1: // Customer
                    BEGIN
                        CustPostingGr.GET(lDtldCustLedgEntry."Posting Group");
                        CustPostingGr.TESTFIELD("Receivables Account");
                        ReversalCreateGenJnlLine(CustPostingGr."Receivables Account", ReversalAmount, lCustLedgEntry."Remaining Amount", lCustLedgEntry."Currency Code", PostingDate, lDtldCustLedgEntry."Entry No.",
                                                TempDimSetEntry, AdjustAccType, FORMAT(lCustLedgEntry."Entry No."));
                    END;
                2: // Vendor
                    BEGIN
                        VendPostingGr.GET(lDtldVendLedgerEntry."Posting Group");
                        VendPostingGr.TESTFIELD("Payables Account");
                        ReversalCreateGenJnlLine(VendPostingGr."Payables Account", ReversalAmount, lVendLedgEntry."Remaining Amount", lVendLedgEntry."Currency Code", PostingDate, lDtldVendLedgerEntry."Entry No.",
                                                TempDimSetEntry, AdjustAccType, FORMAT(lVendLedgEntry."Entry No."));
                    END;
            END;

            Currency2.GET(CurrCode);
            CASE AdjustAccType OF
                1: //Customer
                    BEGIN
                        IF (lDtldCustLedgEntry."Entry Type" = lDtldCustLedgEntry."Entry Type"::"Unrealized Gain") THEN BEGIN
                            IF (GLSetup."Enable GT FX FND" = FALSE) THEN BEGIN
                                Currency2.TESTFIELD("Unrealized Gains Acc.");
                                ReversalCreateGenJnlLine(Currency2."Unrealized Gains Acc.", -ReversalAmount, lCustLedgEntry."Remaining Amount", lCustLedgEntry."Currency Code", PostingDate, lDtldCustLedgEntry."Entry No.",
                                            TempDimSetEntry, AdjustAccType, FORMAT(lCustLedgEntry."Entry No."));
                            END ELSE BEGIN
                                Currency2.TESTFIELD("Unrealized GainAcc.Receiv. FND");
                                ReversalCreateGenJnlLine(Currency2."Realized Gain Acc. Receiv. FND", -ReversalAmount, lCustLedgEntry."Remaining Amount", lCustLedgEntry."Currency Code", PostingDate, lDtldCustLedgEntry."Entry No.",
                                  TempDimSetEntry, AdjustAccType, FORMAT(lCustLedgEntry."Entry No."));
                            END;
                        END;
                        IF (lDtldCustLedgEntry."Entry Type" = lDtldCustLedgEntry."Entry Type"::"Unrealized Loss") THEN BEGIN
                            IF (GLSetup."Enable GT FX FND" = FALSE) THEN BEGIN
                                Currency2.TESTFIELD("Unrealized Losses Acc.");
                                ReversalCreateGenJnlLine(Currency2."Unrealized Losses Acc.", -ReversalAmount, lCustLedgEntry."Remaining Amount", lCustLedgEntry."Currency Code", PostingDate, lDtldCustLedgEntry."Entry No.",
                                            TempDimSetEntry, AdjustAccType, FORMAT(lCustLedgEntry."Entry No."));
                            END ELSE BEGIN
                                Currency2.TESTFIELD("Unrealized GainAcc.Receiv. FND");
                                ReversalCreateGenJnlLine(Currency2."Unrealized LossAcc.Receiv. FND", -ReversalAmount, lCustLedgEntry."Remaining Amount", lCustLedgEntry."Currency Code", PostingDate, lDtldCustLedgEntry."Entry No.",
                                            TempDimSetEntry, AdjustAccType, FORMAT(lCustLedgEntry."Entry No."));
                            END;
                        END;
                    END;
                2: //Vendor
                    BEGIN
                        IF (lDtldVendLedgerEntry."Entry Type" = lDtldVendLedgerEntry."Entry Type"::"Unrealized Gain") THEN BEGIN
                            IF (GLSetup."Enable GT FX FND" = FALSE) THEN BEGIN
                                Currency2.TESTFIELD("Unrealized Gains Acc.");
                                ReversalCreateGenJnlLine(Currency2."Unrealized Gains Acc.", -ReversalAmount, lVendLedgEntry."Remaining Amount", lVendLedgEntry."Currency Code", PostingDate, lDtldVendLedgerEntry."Entry No.",
                                                      TempDimSetEntry, AdjustAccType, FORMAT(lVendLedgEntry."Entry No."));
                            END ELSE BEGIN
                                Currency2.TESTFIELD("Unrealized LossAcc.Payable FND");
                                ReversalCreateGenJnlLine(Currency2."Unrealized GainAcc.Payable FND", -ReversalAmount, lVendLedgEntry."Remaining Amount", lVendLedgEntry."Currency Code", PostingDate, lDtldVendLedgerEntry."Entry No.",
                                                      TempDimSetEntry, AdjustAccType, FORMAT(lVendLedgEntry."Entry No."));
                            END;
                        END;
                        IF (lDtldVendLedgerEntry."Entry Type" = lDtldVendLedgerEntry."Entry Type"::"Unrealized Loss") THEN BEGIN
                            IF (GLSetup."Enable GT FX FND" = FALSE) THEN BEGIN
                                Currency2.TESTFIELD("Unrealized Losses Acc.");
                                ReversalCreateGenJnlLine(Currency2."Unrealized Losses Acc.", -ReversalAmount, lVendLedgEntry."Remaining Amount", lVendLedgEntry."Currency Code", PostingDate, lDtldVendLedgerEntry."Entry No.",
                                                      TempDimSetEntry, AdjustAccType, FORMAT(lVendLedgEntry."Entry No."));

                            END ELSE BEGIN
                                Currency2.TESTFIELD("Unrealized LossAcc.Payable FND");
                                ReversalCreateGenJnlLine(Currency2."Unrealized LossAcc.Payable FND", -ReversalAmount, lVendLedgEntry."Remaining Amount", lVendLedgEntry."Currency Code", PostingDate, lDtldVendLedgerEntry."Entry No.",
                                            TempDimSetEntry, AdjustAccType, FORMAT(lVendLedgEntry."Entry No."));
                            END;
                        END;
                    END;
            END;
        END;
        //HEI.05<<
    end;
}

