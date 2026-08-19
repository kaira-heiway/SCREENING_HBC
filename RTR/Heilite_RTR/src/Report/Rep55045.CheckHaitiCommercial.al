report 55045 "Check Haiti Commercial"
{
    // version NAVW17.10.00.36078

    // HEI.01 CHG2096768 IBM POENAB02 18.02.2021 Haiti check printing
    //   # Object created
    // HEI.02 INC3446207 IBM BULIMC01 26/05/2021#code added to calculate the Remaining Amount based on the WHT Barear

    // BC Upgrade PATELS08 >>
    // # Old Object ID : 50492
    // # Added UsageCategory at Report level
    // # Code Change in OnPreDataItem trigger of PrintSettledLoop2 dataitem to create totals for LineAmountTotal, LineAmount2Total, LineAmount3Total, LineDiscountTotal
    // # Changed Global Variable 'Language' to 'LanguageRec' as it conflicted with built-in member Lanaguage.
    // # Code Change in OnAfterGetRecord trigger of PrintCheck dataitem to get the language id for French using LanguageRec record and blocked 'With' statement as it is deprecated.
    // # Updated GetBankPostAcc() to align with BC field rename: "G/L Bank Account No." → "G/L Account No."
    // BC Upgrade PATELS08 <<

    CaptionML = ENU = 'Check', FRA = 'Chèque';
    Permissions = TableData "Bank Account" = m;
    // BC Upgrade PATELS08 >>
    UsageCategory = ReportsAndAnalysis;
    // BC Upgrade PATELS08 <<
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Check Haiti Commercial.rdl';
    ApplicationArea = All;


    dataset
    {
        dataitem(VoidGenJnlLine; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Posting Date";

            trigger OnAfterGetRecord();
            begin
                CheckManagement.VoidCheck(VoidGenJnlLine);
            end;

            trigger OnPreDataItem();
            begin
                if UseCheckNo = '' then
                    ERROR(Text001);

                if TestPrint then
                    CurrReport.BREAK();

                if not ReprintChecks then
                    CurrReport.BREAK();

                if (GETFILTER("Document No.") <> '') then
                    ERROR(
                      Text002, FIELDCAPTION("Line No."), FIELDCAPTION("Document No."));
                SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                SETRANGE("Check Printed", true);
                SETRANGE("Parent Line No. FND", 0);
            end;
        }
        dataitem(GenJnlLine; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            column(JournalTempName_GenJnlLine; "Journal Template Name")
            {
            }
            column(JournalBatchName_GenJnlLine; "Journal Batch Name")
            {
            }
            column(LineNo_GenJnlLine; "Line No.")
            {
            }
            column(CheckDateText1_2; CheckDateText1[2])
            {
            }
            column(CheckDateText1_3; CheckDateText1[3])
            {
            }
            column(AmountLCY_GenJnlLine; GenJnlLine."Amount (LCY)")
            {
            }
            column(Amount_GenJnlLine1; GenAmount)
            {
            }
            column(City_Companyinfo; CompanyInfo.City)
            {
            }
            column(PostingDate_GenjnlLine1; FORMAT(GenJnlLine."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(Description_GenJnlLine; GenJnlLine.Description)
            {
            }
            column(ExtDocNo; ExtDocNo)
            {
            }
            dataitem(CheckPages; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(CheckToAddr1; CheckToAddr[1])
                {
                }
                column(CheckDateText; CheckDateText)
                {
                }
                column(CheckNoText; CheckNoText)
                {
                }
                column(FirstPage; FirstPage)
                {
                }
                column(PreprintedStub; PreprintedStub)
                {
                }
                column(CheckNoTextCaption; CheckNoTextCaptionLbl)
                {
                }
                dataitem(PrintSettledLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 0;
                    column(NetAmount; NetAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalLineDiscountLineDiscount; TotalLineDiscount - LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalLineAmountLineAmount; TotalLineAmount - LineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalLineAmountLineAmount2; TotalLineAmount - LineAmount2)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmount; LineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineDiscount; LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmountLineDiscount; LineAmount + LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(DocNo; DocNo)
                    {
                    }
                    column(DocDate; DocDate)
                    {
                    }
                    column(CurrencyCode2; CurrencyCode2)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(CurrentLineAmount; CurrentLineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmountCaption; LineAmountCaptionLbl)
                    {
                    }
                    column(LineDiscountCaption; LineDiscountCaptionLbl)
                    {
                    }
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(DocNoCaption; DocNoCaptionLbl)
                    {
                    }
                    column(DocDateCaption; DocDateCaptionLbl)
                    {
                    }
                    column(CurrencyCodeCaption; CurrencyCodeCaptionLbl)
                    {
                    }
                    column(YourDocNoCaption; YourDocNoCaptionLbl)
                    {
                    }
                    column(TransportCaption; TransportCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if not TestPrint then begin
                            if FoundLast then begin
                                if RemainingAmount <> 0 then begin
                                    DocNo := '';
                                    DocDate := 0D;
                                    LineAmount := RemainingAmount;
                                    LineAmount2 := RemainingAmount;
                                    CurrentLineAmount := LineAmount2;
                                    LineDiscount := 0;
                                    RemainingAmount := 0;
                                end else
                                    CurrReport.BREAK();
                            end else
                                case ApplyMethod of
                                    ApplyMethod::OneLineOneEntry:
                                        begin
                                            case BalancingType of
                                                BalancingType::Customer:
                                                    begin
                                                        CustLedgEntry.RESET();
                                                        CustLedgEntry.SETCURRENTKEY("Document No.");
                                                        CustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                        CustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                        CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                        CustLedgEntry.FIND('-');
                                                        CustUpdateAmounts(CustLedgEntry, RemainingAmount);
                                                    end;
                                                BalancingType::Vendor:
                                                    begin
                                                        VendLedgEntry.RESET();
                                                        VendLedgEntry.SETCURRENTKEY("Document No.");
                                                        VendLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                        VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                        VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                        VendLedgEntry.FIND('-');
                                                        VendUpdateAmounts(VendLedgEntry, RemainingAmount);
                                                    end;
                                            end;
                                            RemainingAmount := RemainingAmount - LineAmount2;
                                            CurrentLineAmount := LineAmount2;
                                            FoundLast := true;
                                        end;
                                    ApplyMethod::OneLineID:
                                        begin
                                            case BalancingType of
                                                BalancingType::Customer:
                                                    begin
                                                        CustUpdateAmounts(CustLedgEntry, RemainingAmount);
                                                        FoundLast := (CustLedgEntry.NEXT() = 0) or (RemainingAmount <= 0);
                                                        if FoundLast and not FoundNegative then begin
                                                            CustLedgEntry.SETRANGE(Positive, false);
                                                            FoundLast := not CustLedgEntry.FIND('-');
                                                            FoundNegative := true;
                                                        end;
                                                    end;
                                                BalancingType::Vendor:
                                                    begin
                                                        VendUpdateAmounts(VendLedgEntry, RemainingAmount);
                                                        FoundLast := (VendLedgEntry.NEXT() = 0) or (RemainingAmount <= 0);
                                                        if FoundLast and not FoundNegative then begin
                                                            VendLedgEntry.SETRANGE(Positive, false);
                                                            FoundLast := not VendLedgEntry.FIND('-');
                                                            FoundNegative := true;
                                                        end;
                                                    end;
                                            end;
                                            RemainingAmount := RemainingAmount - LineAmount2;
                                            CurrentLineAmount := LineAmount2;
                                        end;
                                    ApplyMethod::MoreLinesOneEntry:
                                        begin
                                            /*//HEI.02>>
                                            IF WHTPostingSetup.GET(GenJnlLine2."WHT Business Posting Group",GenJnlLine2."WHT Product Posting Group") THEN BEGIN
                                              IF WHTPostingSetup."WHT Bearer" = WHTPostingSetup."WHT Bearer"::Opco THEN
                                                CurrentLineAmount := GenJnlLine2.Amount
                                              ELSE
                                                CurrentLineAmount := GenJnlLine2.Amount - GenJnlLine2."WHT Amount";
                                            END ELSE
                                              //HEI.02<<*/
                                            CurrentLineAmount := GenJnlLine2.Amount - GenJnlLine2."WHT Amount FND";
                                            LineAmount2 := CurrentLineAmount;

                                            if GenJnlLine2."Applies-to ID" <> '' then
                                                ERROR(Text016);
                                            GenJnlLine2.TESTFIELD("Check Printed", false);
                                            GenJnlLine2.TESTFIELD("Bank Payment Type", GenJnlLine2."Bank Payment Type"::"Computer Check");
                                            if BankAcc2."Currency Code" <> GenJnlLine2."Currency Code" then
                                                ERROR(Text005);
                                            if GenJnlLine2."Applies-to Doc. No." = '' then begin
                                                DocNo := '';
                                                DocDate := 0D;
                                                LineAmount := CurrentLineAmount;
                                                LineDiscount := 0;
                                            end else
                                                case BalancingType of
                                                    BalancingType::"G/L Account":
                                                        begin
                                                            DocNo := GenJnlLine2."Document No.";
                                                            ExtDocNo := GenJnlLine2."External Document No." + 'B1';//bogdan
                                                            LineAmount := CurrentLineAmount;
                                                            LineDiscount := 0;
                                                        end;
                                                    BalancingType::Customer:
                                                        begin
                                                            CustLedgEntry.RESET();
                                                            CustLedgEntry.SETCURRENTKEY("Document No.");
                                                            CustLedgEntry.SETRANGE("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                            CustLedgEntry.SETRANGE("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                            CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                            CustLedgEntry.FIND('-');
                                                            CustUpdateAmounts(CustLedgEntry, CurrentLineAmount);
                                                            LineAmount := CurrentLineAmount;
                                                        end;
                                                    BalancingType::Vendor:
                                                        begin
                                                            VendLedgEntry.RESET();
                                                            if GenJnlLine2."Source Line No." <> 0 then
                                                                VendLedgEntry.SETRANGE("Entry No.", GenJnlLine2."Source Line No.")
                                                            else begin
                                                                VendLedgEntry.SETCURRENTKEY("Document No.");
                                                                VendLedgEntry.SETRANGE("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                                VendLedgEntry.SETRANGE("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                                VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                            end;
                                                            VendLedgEntry.FIND('-');
                                                            VendUpdateAmounts(VendLedgEntry, CurrentLineAmount);
                                                            LineAmount := CurrentLineAmount;
                                                        end;
                                                    BalancingType::"Bank Account":
                                                        begin
                                                            DocNo := GenJnlLine2."Document No.";
                                                            ExtDocNo := GenJnlLine2."External Document No." + 'B2';//bogdan
                                                            LineAmount := CurrentLineAmount;
                                                            LineDiscount := 0;
                                                        end;
                                                end;
                                            FoundLast := GenJnlLine2.NEXT() = 0;
                                        end;
                                end;

                            TotalLineAmount := TotalLineAmount + LineAmount2;
                            TotalLineDiscount := TotalLineDiscount + LineDiscount;
                        end else begin
                            if FoundLast then
                                CurrReport.BREAK();
                            FoundLast := true;
                            DocNo := Text010;
                            ExtDocNo := Text010;
                            LineAmount := 0;
                            LineDiscount := 0;
                        end;

                    end;

                    trigger OnPreDataItem();
                    begin
                        if not TestPrint then
                            if FirstPage then begin
                                FoundLast := true;
                                case ApplyMethod of
                                    ApplyMethod::OneLineOneEntry:
                                        FoundLast := false;
                                    ApplyMethod::OneLineID:
                                        case BalancingType of
                                            BalancingType::Customer:
                                                begin
                                                    CustLedgEntry.RESET();
                                                    CustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive);
                                                    CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                    CustLedgEntry.SETRANGE(Open, true);
                                                    CustLedgEntry.SETRANGE(Positive, true);
                                                    CustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                                                    FoundLast := not CustLedgEntry.FIND('-');
                                                    if FoundLast then begin
                                                        CustLedgEntry.SETRANGE(Positive, false);
                                                        FoundLast := not CustLedgEntry.FIND('-');
                                                        FoundNegative := true;
                                                    end else
                                                        FoundNegative := false;
                                                end;
                                            BalancingType::Vendor:
                                                begin
                                                    VendLedgEntry.RESET();
                                                    VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive);
                                                    VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                    VendLedgEntry.SETRANGE(Open, true);
                                                    VendLedgEntry.SETRANGE(Positive, true);
                                                    VendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                                                    FoundLast := not VendLedgEntry.FIND('-');
                                                    if FoundLast then begin
                                                        VendLedgEntry.SETRANGE(Positive, false);
                                                        FoundLast := not VendLedgEntry.FIND('-');
                                                        FoundNegative := true;
                                                    end else
                                                        FoundNegative := false;
                                                end;
                                        end;
                                    ApplyMethod::MoreLinesOneEntry:
                                        FoundLast := false;
                                end;
                            end
                            else
                                FoundLast := false;

                        if DocNo = '' then
                            CurrencyCode2 := GenJnlLine."Currency Code";

                        if PreprintedStub then
                            TotalText := ''
                        else
                            TotalText := Text019;

                        if GenJnlLine."Currency Code" <> '' then
                            NetAmount := STRSUBSTNO(Text063, GenJnlLine."Currency Code")
                        else begin
                            GLSetup.GET();
                            NetAmount := STRSUBSTNO(Text063, GLSetup."LCY Code");
                        end;
                    end;
                }
                dataitem(PrintSettledLoop2; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 0;
                    column(DocDateLine_New; FORMAT(DocDateLine[Number]))
                    {
                    }
                    column(DocDescriptionLine_New; DocDescriptionLine[Number])
                    {
                    }
                    column(DocNoLine_New; DocNoLine[Number])
                    {
                    }
                    column(LineAmountLine_New; LineAmountLine[Number])
                    {
                    }
                    column(LineAmount2Total_New; LineAmount2Total[2])
                    {
                    }
                    column(LineAmountTotal_1; LineAmountTotal[1])
                    {
                    }

                    trigger OnPreDataItem();
                    begin
                        SETRANGE(Number, 1, LineCount);
                        // BC Upgrade PATELS08 >>
                        // CurrReport.CREATETOTALS(LineAmountTotal,LineAmount2Total,LineAmount3Total,LineDiscountTotal); // BC Upgrade PATELS08 - Error : thus seperated them out as follows:
                        CurrReport.CREATETOTALS(LineAmountTotal);
                        CurrReport.CREATETOTALS(LineAmount2Total);
                        CurrReport.CREATETOTALS(LineAmount3Total);
                        CurrReport.CREATETOTALS(LineDiscountTotal);
                        CurrReport.CREATETOTALS(TaxAmtTotal2);
                        // BC Upgrade PATELS08 <<
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        LineAmountTotal[1] := LineAmountLine[Number];
                        LineDiscountTotal[1] := LineDiscountLine[Number];
                        if LineAmount2Line[Number] > 0 then begin
                            LineAmount2Total[1] := LineAmount2Line[Number];
                            DebitLineAmt := LineAmount2Line[Number];
                            CreditLineAmt := 0;
                        end else begin
                            LineAmount3Total[1] := -LineAmount2Line[Number];
                            DebitLineAmt := 0;
                            CreditLineAmt := -LineAmount2Line[Number];
                        end;

                        TaxAmtTotal[1, 1] := TaxAmtLine[1, Number];
                        TaxAmtTotal[2, 1] := TaxAmtLine[2, Number];
                        TaxAmtTotal[3, 1] := TaxAmtLine[3, Number];

                        TaxAmtTotal2[1] := TaxAmtLine[1, Number];
                        TaxAmtTotal2[2] := TaxAmtLine[2, Number];
                        TaxAmtTotal2[3] := TaxAmtLine[3, Number];

                        if Number > MaxLine then begin
                            LineAmountTotal[2] := LineAmountLine[Number];

                            if LineAmount2Line[Number] > 0 then
                                LineAmount2Total[2] := LineAmount2Line[Number]
                            else
                                LineAmount3Total[2] := -LineAmount2Line[Number];
                            LineDiscountTotal[2] := LineDiscountLine[Number];

                            TaxAmtTotal[1, 2] := TaxAmtLine[1, Number];
                            TaxAmtTotal[2, 2] := TaxAmtLine[2, Number];
                            TaxAmtTotal[3, 2] := TaxAmtLine[3, Number];
                        end else
                            i += 1;

                        ApplDocType := GenJnlLine."Applies-to Doc. Type".AsInteger();

                        if (Number <= MaxLine) then
                            ShowLine := 1;
                    end;


                }
                dataitem(PrintSignature; "Integer")
                {
                    DataItemTableView = SORTING(Number);

                    trigger OnPreDataItem();
                    begin
                        SETRANGE(Number, 1, MaxLine - LineCount);
                    end;
                }
                dataitem(PrintCheck; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(CheckAmountText; CheckAmountText)
                    {
                    }
                    column(CheckDateTextControl2; CheckDateText)
                    {
                    }
                    column(DescriptionLine2; DescriptionLine[2])
                    {
                    }
                    column(DescriptionLine1; DescriptionLine[1] + ' ' + DescriptionLine[2])
                    {
                    }
                    column(CheckToAddr1Control7; CheckToAddr[1])
                    {
                    }
                    column(CheckToAddr2; CheckToAddr[2])
                    {
                    }
                    column(CheckToAddr4; CheckToAddr[4])
                    {
                    }
                    column(CheckToAddr3; CheckToAddr[3])
                    {
                    }
                    column(CheckToAddr5; CheckToAddr[5])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr8; CompanyAddr[8])
                    {
                    }
                    column(CompanyAddr7; CompanyAddr[7])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CheckNoTextControl21; CheckNoText)
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(TotalLineAmount; TotalLineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(VoidText; VoidText)
                    {
                    }
                    column(InfoText_3; InfoText[3])
                    {
                    }
                    column(ExternalDocNo_GenJnlLine; ExtDocNo)
                    {
                    }
                    column(PostingDate_GenjnlLine; GenJnlLine."Posting Date")
                    {
                    }
                    column(MessageToReceipt; MessageToReceipt)
                    {
                    }
                    column(Amount_GenJnlLine; GenJnlLine.Amount)
                    {
                    }

                    trigger OnAfterGetRecord();
                    var
                        Decimals: Decimal;
                        CheckLedgEntryAmount: Decimal;
                    begin
                        if not TestPrint then begin
                            // BC Upgrade PATELS08 >> # Blocked With statement as it is deprecated in AL.
                            // with GenJnlLine do begin 
                            // BC Upgrade PATELS08 <<
                            CheckLedgEntry.INIT();
                            CheckLedgEntry."Bank Account No." := BankAcc2."No.";

                            // BC Upgrade PATELS08 >> # Added 'GenJnlLine.' prefix to the following fields
                            // CheckLedgEntry."Posting Date" := "Posting Date";
                            // CheckLedgEntry."Document Type" := "Document Type";
                            // CheckLedgEntry.Description := Description;
                            // CheckLedgEntry."Bank Payment Type" := "Bank Payment Type";
                            CheckLedgEntry."Posting Date" := GenJnlLine."Posting Date";
                            CheckLedgEntry."Document Type" := GenJnlLine."Document Type";
                            CheckLedgEntry.Description := GenJnlLine.Description;
                            CheckLedgEntry."Bank Payment Type" := GenJnlLine."Bank Payment Type";
                            // BC Upgrade PATELS08 <<

                            CheckLedgEntry."Document No." := UseCheckNo;
                            CheckLedgEntry."Bal. Account Type" := BalancingType;
                            CheckLedgEntry."Bal. Account No." := BalancingNo;
                            if FoundLast then begin
                                if TotalLineAmount <= 0 then
                                    ERROR(
                                      Text020,
                                      UseCheckNo, TotalLineAmount);
                                CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Printed;
                                CheckLedgEntry.Amount := TotalLineAmount;
                            end else begin
                                CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Voided;
                                CheckLedgEntry.Amount := 0;
                            end;

                            // BC Upgrade PATELS08 >> # Added 'GenJnlLine.' prefix to the field 'Posting Date'
                            // CheckLedgEntry."Check Date" := "Posting Date";
                            CheckLedgEntry."Check Date" := GenJnlLine."Posting Date";
                            // BC Upgrade PATELS08 <<
                            CheckLedgEntry."Check No." := UseCheckNo;
                            CheckManagement.InsertCheck(CheckLedgEntry, RECORDID);

                            // BC Upgrade PATELS08 >>  # Added 'GenJnlLine.' prefix to the fields used in the below code block
                            // if "Message to Recipient" <> '' then
                            //     MessageToReceipt := "Message to Recipient"
                            // else
                            //     MessageToReceipt := Description;

                            if GenJnlLine."Message to Recipient" <> '' then
                                MessageToReceipt := GenJnlLine."Message to Recipient"
                            else
                                MessageToReceipt := GenJnlLine.Description;
                            // BC Upgrade PATELS08 <<

                            if FoundLast then begin
                                if BankAcc2."Currency Code" <> '' then
                                    Currency.GET(BankAcc2."Currency Code")
                                else
                                    Currency.InitRoundingPrecision();
                                CheckLedgEntryAmount := CheckLedgEntry.Amount;
                                Decimals := CheckLedgEntry.Amount - ROUND(CheckLedgEntry.Amount, 1, '<');
                                if STRLEN(FORMAT(Decimals)) < STRLEN(FORMAT(Currency."Amount Rounding Precision")) then
                                    if Decimals = 0 then
                                        CheckAmountText := FORMAT(CheckLedgEntryAmount, 0, 0) +
                                          COPYSTR(FORMAT(0.01), 2, 1) +
                                          PADSTR('', STRLEN(FORMAT(Currency."Amount Rounding Precision")) - 2, '0')
                                    else
                                        CheckAmountText := FORMAT(CheckLedgEntryAmount, 0, 0) +
                                          PADSTR('', STRLEN(FORMAT(Currency."Amount Rounding Precision")) - STRLEN(FORMAT(Decimals)), '0')
                                else
                                    CheckAmountText := FORMAT(CheckLedgEntryAmount, 0, 0);

                                // BC Upgrade PATELS08 >> # Changed 'Language' to 'LanguageRec'
                                // FrLanguageCode := Language.GetLanguageID('FR');
                                FrLanguageCode := LanguageRec.GetLanguageID('FR');
                                // BC Upgrade PATELS08 <<

                                if GLOBALLANGUAGE = 1036 then
                                    FormatNoTextFR(DescriptionLine, GenJnlLine.Amount, BankAcc2."Currency Code") //HEI.02
                                                                                                                 //FormatNoTextFR(DescriptionLine,GenAmount,BankAcc2."Currency Code")// HEI.02
                                else
                                    FormatNoText(DescriptionLine, GenJnlLine.Amount, BankAcc2."Currency Code"); //HEI.02
                                                                                                                //FormatNoText(DescriptionLine,GenAmount,BankAcc2."Currency Code"); // HEI.02
                                VoidText := '';
                            end else begin
                                CLEAR(CheckAmountText);
                                CLEAR(DescriptionLine);
                                TotalText := Text065;
                                DescriptionLine[1] := Text021;
                                DescriptionLine[2] := DescriptionLine[1];
                                VoidText := Text022;
                            end;

                            // BC Upgrade PATELS08 >> # Blocked 'end' for the 'begin' of 'With' statement.
                            // end;
                            // BC Upgrade PATELS08 <<
                        end else
                            // BC Upgrade PATELS08 >> # Blocked With statement as it is deprecated in AL.
                            // with GenJnlLine do begin
                            // BC Upgrade PATELS08 <<
                                CheckLedgEntry.INIT();
                        CheckLedgEntry."Bank Account No." := BankAcc2."No.";
                        // BC Upgrade PATELS08 >> # Added 'GenJnlLine.' prefix to the following field
                        // CheckLedgEntry."Posting Date" := "Posting Date";
                        CheckLedgEntry."Posting Date" := GenJnlLine."Posting Date";
                        // BC Upgrade PATELS08 <<
                        CheckLedgEntry."Document No." := UseCheckNo;
                        CheckLedgEntry.Description := Text023;
                        CheckLedgEntry."Bank Payment Type" := "Bank Payment Type"::"Computer Check";
                        CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::"Test Print";
                        // BC Upgrade PATELS08 >> # Added 'GenJnlLine.' prefix to the field 'Posting Date'
                        // CheckLedgEntry."Check Date" := "Posting Date";
                        CheckLedgEntry."Check Date" := GenJnlLine."Posting Date";
                        // BC Upgrade PATELS08 <<
                        CheckLedgEntry."Check No." := UseCheckNo;
                        CheckManagement.InsertCheck(CheckLedgEntry, RECORDID);

                        CheckAmountText := Text024;
                        DescriptionLine[1] := Text025;
                        DescriptionLine[2] := DescriptionLine[1];
                        VoidText := Text022;
                        // BC Upgrade PATELS08 >> # Blocked 'end' for the 'begin' of 'With' statement.
                        // end;
                        // BC Upgrade PATELS08 <<

                        if GenJnlLine."Message to Recipient" <> '' then
                            MessageToReceipt := GenJnlLine."Message to Recipient"
                        else
                            MessageToReceipt := GenJnlLine.Description;

                        if Vendor.GET(GenJnlLine."Account No.") then
                            VendorName := Vendor.Name;

                        Vendor.RESET();
                        CLEAR(InfoText);
                        if Vendor.GET(GenJnlLine."Account No.") then begin
                            InfoText[1] := Vendor.Name + ' ' + Vendor."Name 2";
                            InfoText[2] := Vendor.Address + ' ' + Vendor."Address 2";
                            InfoText[3] := Vendor.Name;
                            InfoText[4] := Vendor."Post Code";
                            InfoText[5] := Vendor.City;
                            InfoText[6] := Vendor."Country/Region Code";

                        end;

                        ChecksPrinted := ChecksPrinted + 1;
                        FirstPage := false;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if FoundLast then
                        CurrReport.BREAK();

                    UseCheckNo := INCSTR(UseCheckNo);
                    if not TestPrint then
                        CheckNoText := UseCheckNo
                    else
                        CheckNoText := Text011;
                end;

                trigger OnPostDataItem();
                begin
                    BankAcc2."Last Check No." := UseCheckNo;
                    BankAcc2.MODIFY();
                    GenJnlLine."HNK Check No. FND" := UseCheckNo;
                    if not TestPrint then
                        GenJnlLine."Check Printed" := true;
                    GenJnlLine.MODIFY();
                    CLEAR(CheckManagement);
                end;

                trigger OnPreDataItem();
                begin
                    FirstPage := true;
                    FoundLast := false;
                    TotalLineAmount := 0;
                    TotalLineDiscount := 0;
                end;
            }

            trigger OnAfterGetRecord();
            var
                Month: Text[50];
            begin
                if OneCheckPrVendor and ("Currency Code" <> '') and
                   ("Currency Code" <> Currency.Code)
                then begin
                    Currency.GET("Currency Code");
                    Currency.TESTFIELD("Conv. LCY Rndg. Debit Acc.");
                    Currency.TESTFIELD("Conv. LCY Rndg. Credit Acc.");
                end;

                if "Bank Payment Type" = "Bank Payment Type"::"Computer Check" then
                    TESTFIELD("Exported to Payment File", false);

                if not TestPrint then begin
                    if Amount = 0 then
                        CurrReport.SKIP();
                    TESTFIELD("HNK Bank Account FND");
                    if "HNK Bank Account FND" <> BankAcc2."No." then
                        CurrReport.SKIP();

                    if ("Account No." <> '') and ("Bal. Account No." <> '') then begin
                        BalancingType := "Account Type";
                        BalancingNo := "Account No.";
                        //HEI.02>>
                        //IF WHTPostingSetup.GET("WHT Business Posting Group","WHT Product Posting Group") THEN BEGIN

                        //END ELSE BEGIN
                        //HEI.02<<
                        RemainingAmount := Amount - GenJnlLine."WHT Amount FND";
                        GenAmount := Amount - GenJnlLine."WHT Amount FND";
                        //END;

                        if OneCheckPrVendor then begin
                            ApplyMethod := ApplyMethod::MoreLinesOneEntry;
                            GenJnlLine2.RESET();
                            GenJnlLine2.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                            GenJnlLine2.SETRANGE("Journal Template Name", "Journal Template Name");
                            GenJnlLine2.SETRANGE("Journal Batch Name", "Journal Batch Name");
                            GenJnlLine2.SETRANGE("Posting Date", "Posting Date");
                            GenJnlLine2.SETRANGE("Document No.", "Document No.");
                            GenJnlLine2.SETRANGE("Account Type", "Account Type");
                            GenJnlLine2.SETRANGE("Account No.", "Account No.");
                            GenJnlLine2.SETRANGE("Bal. Account Type", "Bal. Account Type");
                            GenJnlLine2.SETRANGE("Bal. Account No.", "Bal. Account No.");
                            GenJnlLine2.SETRANGE("Bank Payment Type", "Bank Payment Type");
                            GenJnlLine2.FIND('-');
                            RemainingAmount := 0;
                        end else
                            if "Applies-to Doc. No." <> '' then
                                ApplyMethod := ApplyMethod::OneLineOneEntry
                            else
                                if "Applies-to ID" <> '' then
                                    ApplyMethod := ApplyMethod::OneLineID
                                else
                                    ApplyMethod := ApplyMethod::Payment;
                    end else
                        if "Account No." = '' then
                            FIELDERROR("Account No.", Text004)
                        else
                            FIELDERROR("Bal. Account No.", Text004);

                    CLEAR(CheckToAddr);
                    CLEAR(SalesPurchPerson);
                    case BalancingType of
                        BalancingType::"G/L Account":
                            CheckToAddr[1] := Description;
                        BalancingType::Customer:
                            begin
                                Cust.GET(BalancingNo);
                                if Cust.Blocked = Cust.Blocked::All then
                                    ERROR(Text064, Cust.FIELDCAPTION(Blocked), Cust.Blocked, Cust.TABLECAPTION, Cust."No.");
                                Cust.Contact := '';
                                FormatAddr.Customer(CheckToAddr, Cust);
                                if BankAcc2."Currency Code" <> "Currency Code" then
                                    ERROR(Text005);
                                if Cust."Salesperson Code" <> '' then
                                    SalesPurchPerson.GET(Cust."Salesperson Code");
                            end;
                        BalancingType::Vendor:
                            begin
                                Vend.GET(BalancingNo);
                                if Vend.Blocked in [Vend.Blocked::All, Vend.Blocked::Payment] then
                                    ERROR(Text064, Vend.FIELDCAPTION(Blocked), Vend.Blocked, Vend.TABLECAPTION, Vend."No.");
                                Vend.Contact := '';
                                FormatAddr.Vendor(CheckToAddr, Vend);
                                if Vend."Purchaser Code" <> '' then
                                    SalesPurchPerson.GET(Vend."Purchaser Code");
                            end;
                        BalancingType::"Bank Account":
                            begin
                                BankAcc.GET(BalancingNo);
                                BankAcc.TESTFIELD(Blocked, false);
                                BankAcc.Contact := '';
                                FormatAddr.BankAcc(CheckToAddr, BankAcc);
                                if BankAcc2."Currency Code" <> BankAcc."Currency Code" then
                                    ERROR(Text008);
                                if BankAcc."Our Contact Code" <> '' then
                                    SalesPurchPerson.GET(BankAcc."Our Contact Code");
                            end;
                    end;

                    CheckDateText := FORMAT("Posting Date", 0, 4);
                end else begin
                    if ChecksPrinted > 0 then
                        CurrReport.BREAK();
                    BalancingType := BalancingType::Vendor;
                    BalancingNo := Text010;
                    CLEAR(CheckToAddr);
                    for i := 1 to 5 do
                        CheckToAddr[i] := Text003;
                    CLEAR(SalesPurchPerson);
                    CheckNoText := Text011;
                    CheckDateText := Text012;
                end;

                if "Applies-to ID" <> '' then begin
                    CLEAR(ExtDocNo);
                    ExtVendorledgerEntry.RESET();
                    ExtVendorledgerEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                    if ExtVendorledgerEntry.FINDSET() then
                        repeat
                            if ExtDocNo = '' then
                                ExtDocNo := ExtVendorledgerEntry."External Document No."
                            else
                                ExtDocNo += '; ' + ExtVendorledgerEntry."External Document No.";
                        until ExtVendorledgerEntry.NEXT() = 0;
                end;
            end;

            trigger OnPreDataItem();
            begin
                COPY(VoidGenJnlLine);
                CompanyInfo.GET();
                if not TestPrint then begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    ShowCOM := true;
                    COPY(VoidGenJnlLine);
                    SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                    SETRANGE("Check Printed", false);
                end else begin
                    CLEAR(CompanyAddr);
                    for i := 1 to 5 do
                        CompanyAddr[i] := Text003;
                end;
                ChecksPrinted := 0;

                SETRANGE("Account Type", "Account Type"::"Fixed Asset");
                if FIND('-') then
                    FIELDERROR("Account Type");
                SETRANGE("Account Type");
                SETRANGE("Parent Line No. FND", 0);//HEI.01
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
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field(BankAccount; BankAcc2."No.")
                    {
                        CaptionML = ENU = 'Bank Account',
                                    FRA = 'Compte bancaire';
                        TableRelation = "Bank Account";
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            InputBankAccount();
                        end;
                    }
                    field(LastCheckNo; UseCheckNo)
                    {
                        CaptionML = ENU = 'Last Check No.',
                                    FRA = 'N° dern. chèque';
                        ApplicationArea = All;
                    }
                    field(OneCheckPerVendorPerDocumentNo; OneCheckPrVendor)
                    {
                        CaptionML = ENU = 'One Check per Vendor per Document No.',
                                    FRA = 'Un chèque par fournisseur par n° document';
                        MultiLine = true;
                        ApplicationArea = All;
                    }
                    field(ReprintChecks; ReprintChecks)
                    {
                        CaptionML = ENU = 'Reprint Checks',
                                    FRA = 'Réimprimer les chèques';
                        ApplicationArea = All;
                    }
                    field(TestPrinting; TestPrint)
                    {
                        CaptionML = ENU = 'Test Print',
                                    FRA = 'Impression test';
                        ApplicationArea = All;
                    }
                    field(PreprintedStub; PreprintedStub)
                    {
                        CaptionML = ENU = 'Preprinted Stub',
                                    FRA = 'Formulaire préimprimé';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            //HEI.05>>
            grec_genJnlLn.RESET();
            grec_genJnlLn.SETRANGE(grec_genJnlLn."Journal Template Name", FORMAT(VoidGenJnlLine.GETFILTER("Journal Template Name")));
            grec_genJnlLn.SETRANGE(grec_genJnlLn."Journal Batch Name", FORMAT(VoidGenJnlLine.GETFILTER("Journal Batch Name")));
            if VoidGenJnlLine.GETFILTER("Line No.") <> '' then begin
                EVALUATE(ConvertLnIntgr, FORMAT(VoidGenJnlLine.GETFILTER("Line No.")));
                grec_genJnlLn.SETRANGE(grec_genJnlLn."Line No.", ConvertLnIntgr);
            end;
            if grec_genJnlLn.FINDFIRST() then begin
                BankAcc2.VALIDATE("No.", grec_genJnlLn."HNK Bank Account FND");
            end;
            //HEI.05<<

            if BankAcc2."No." <> '' then
                if BankAcc2.GET(BankAcc2."No.") then
                    UseCheckNo := BankAcc2."Last Check No."
                else begin
                    BankAcc2."No." := '';
                    UseCheckNo := '';
                end;
        end;
    }

    labels
    {
        label(OtherConceptsLbl; ENU = 'Other concepts', ESP = 'Otros conceptos', ESS = 'Otros conceptos')
    }

    trigger OnPreReport();
    begin
        InitTextVariable();
        GLSetup.GET();
    end;

    var
        CompanyInfo: Record "Company Information";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        Cust: Record Customer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        Vend: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        BankAcc: Record "Bank Account";
        BankAcc2: Record "Bank Account";
        CheckLedgEntry: Record "Check Ledger Entry";
        Currency: Record Currency;
        FormatAddr: Codeunit "Format Address";
        CheckManagement: Codeunit CheckManagement;
        CompanyAddr: array[8] of Text[50];
        CheckToAddr: array[8] of Text[50];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        // BC Upgrade PATELS08 >> # Type Change Option -> Enum, as assignment of Enum to Option or Vice-versa can lead to runtime error, options values matches with Enum "Gen. Journal Account Type"
        // BalancingType: Option "G/L Account",Customer,Vendor,"Bank Account";
        BalancingType: Enum "Gen. Journal Account Type";
        // BC Upgrade PATELS08 <<
        BalancingNo: Code[20];
        ContactText: Text[30];
        CheckNoText: Text[30];
        CheckDateText: Text[30];
        CheckAmountText: Text[30];
        DescriptionLine: array[2] of Text[80];
        DocType: Text[30];
        DocNo: Text[30];
        ExtDocNo: Text;
        VoidText: Text[30];
        LineAmount: Decimal;
        LineDiscount: Decimal;
        TotalLineAmount: Decimal;
        TotalLineDiscount: Decimal;
        RemainingAmount: Decimal;
        CurrentLineAmount: Decimal;
        UseCheckNo: Code[20];
        FoundLast: Boolean;
        ReprintChecks: Boolean;
        TestPrint: Boolean;
        FirstPage: Boolean;
        OneCheckPrVendor: Boolean;
        FoundNegative: Boolean;
        ApplyMethod: Option Payment,OneLineOneEntry,OneLineID,MoreLinesOneEntry;
        ChecksPrinted: Integer;
        HighestLineNo: Integer;
        PreprintedStub: Boolean;
        TotalText: Text[10];
        DocDate: Date;
        i: Integer;
        CurrencyCode2: Code[10];
        NetAmount: Text[30];
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        LineAmount2: Decimal;
        GLSetup: Record "General Ledger Setup";
        DocGlobalDim1: Code[20];
        DocGlobalDim2: Code[20];
        DocAccNo: Text[20];
        DocVATRegNo: Code[20];
        DocDescription: Text[50];
        DocExtNo: Code[35];
        UseAmountLCY: Boolean;
        VATNoText: Text[30];
        VATRegNo: Code[20];
        CheckDateText1: array[3] of Text[30];
        CheckCity: Text[30];
        Country: Record "Country/Region";
        LineCount: Integer;
        DocNoLine: array[100] of Text[30];
        DocExtNoLine: array[100] of Code[35];
        LineAmountLine: array[100] of Decimal;
        LineAmount2Line: array[100] of Decimal;
        LineDiscountLine: array[100] of Decimal;
        DocDateLine: array[100] of Date;
        CurrCode2Line: array[100] of Code[10];
        DocDim1Line: array[100] of Code[20];
        DocDim2Line: array[100] of Code[20];
        DocAccNoLine: array[100] of Text[20];
        DocAccDescLine: array[100] of Text[50];
        DocVATRegNoLine: array[100] of Code[20];
        DocDescriptionLine: array[100] of Text[50];
        GLAcc: Record "G/L Account";
        TaxAmtLine: array[3, 100] of Decimal;
        TaxAmt: array[3] of Decimal;
        LineAmountTotal: array[2] of Decimal;
        LineAmount2Total: array[2] of Decimal;
        LineAmount3Total: array[2] of Decimal;
        LineDiscountTotal: array[2] of Decimal;
        ApplDocType: Option ,Pago,Factura,"Nota Crédito","Nota de Cambio",Recordatorio,Reembolso,"Nota Débito";

        InfoText: array[6] of Text[150];
        Vendor: Record Vendor;
        MaxLine: Integer;
        TaxAmtTotal: array[3, 2] of Decimal;
        CreditLineAmt: Decimal;
        DebitLineAmt: Decimal;
        TaxAmtTotal2: array[3] of Decimal;
        ShowLine: Integer;
        Text000: TextConst ENU = 'Preview is not allowed.', FRA = 'L''aperçu n''est pas autorisé.';
        Text001: TextConst ENU = 'Last Check No. must be filled in.', FRA = 'Le numéro du dernier chèque doit être renseigné.';
        Text002: TextConst ENU = 'Filters on %1 and %2 are not allowed.', FRA = 'Les filtres sur %1 et %2 ne sont pas autorisés.';
        Text003: TextConst ENU = 'XXXXXXXXXXXXXXXX', FRA = 'XXXXXXXXXXXXXXXX';
        Text004: TextConst ENU = 'must be entered.', FRA = 'doit être entré(e).';
        Text005: TextConst ENU = 'The Bank Account and the General Journal Line must have the same currency.', FRA = 'Le compte bancaire et la ligne feuille doivent indiquer la même devise.';
        Text006: TextConst ENU = 'Salesperson', FRA = 'Vendeur';
        Text007: TextConst ENU = 'Purchaser', FRA = 'Acheteur';
        Text008: TextConst ENU = 'Both Bank Accounts must have the same currency.', FRA = 'Les deux comptes bancaires doivent indiquer la même devise.';
        Text009: TextConst ENU = 'Our Contact', FRA = 'Notre contact';
        Text010: TextConst ENU = 'XXXXXXXXXX', FRA = 'XXXXXXXXXX';
        Text011: TextConst ENU = 'XXXX', FRA = 'XXXX';
        Text012: TextConst ENU = 'XX.XXXXXXXXXX.XXXX', FRA = 'XX.XXXXXXXXXX.XXXX';
        Text013: TextConst ENU = '%1 already exists.', FRA = '%1 existe déjà.';
        Text014: TextConst ENU = 'Check for %1 %2', FRA = 'Chèque pour %1 %2';
        Text015: TextConst ENU = 'Payment', FRA = 'Paiement';
        Text016: TextConst ENU = 'In the Check report, One Check per Vendor and Document No.\must not be activated when Applies-to ID is specified in the journal lines.', FRA = 'Dans l''état Chèque, les options Un chèque par fournisseur et par N° document\ne doivent pas être activées si ID lettrage est spécifié dans les lignes feuille.';
        Text018: TextConst ENU = 'XXX', FRA = 'XXX';
        Text017: TextConst ENU = 'must not be activated when Applies-to ID is specified in the journal lines.', ESP = 'no se debe activar cuando se ha usado Liquidar por Id en las líneas de diario.', ESS = 'no se debe activar cuando se ha usado Liquidar por Id en las líneas de diario.';
        Text019: TextConst ENU = 'Total', FRA = 'Total';
        Text020: TextConst ENU = 'The total amount of check %1 is %2. The amount must be positive.', FRA = 'Le montant total du chèque %1 est de %2. Le montant doit être positif.';
        Text021: TextConst ENU = 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID', FRA = 'NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL NUL';
        Text022: TextConst ENU = 'NON-NEGOTIABLE', FRA = 'NON NEGOCIABLE';
        Text023: TextConst ENU = 'Test print', FRA = 'Impression test';
        Text024: TextConst ENU = 'XXXX.XX', FRA = 'XXXX.XX';
        Text025: TextConst ENU = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', FRA = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text026: TextConst ENU = 'ZERO', FRA = 'ZERO';
        Text027: TextConst ENU = 'HUNDRED', FRA = 'CENT';
        Text028: TextConst ENU = 'AND', FRA = 'ET';
        Text029: TextConst ENU = '%1 results in a written number that is too long.', FRA = '%1 résultat(s) en toutes lettres trop long(s).';
        Text030: TextConst ENU = ' is already applied to %1 %2 for customer %3.', FRA = ' est déjà lettré(e) avec %1 %2 pour le client %3.';
        Text031: TextConst ENU = ' is already applied to %1 %2 for vendor %3.', FRA = ' est déjà lettré(e) avec %1 %2 pour le fournisseur %3.';
        Text032: TextConst ENU = 'ONE', FRA = 'UN';
        Text033: TextConst ENU = 'TWO', FRA = 'DEUX';
        Text034: TextConst ENU = 'THREE', FRA = 'TROIS';
        Text035: TextConst ENU = 'FOUR', FRA = 'QUATRE';
        Text036: TextConst ENU = 'FIVE', FRA = 'CINQ';
        Text037: TextConst ENU = 'SIX', FRA = 'SIX';
        Text038: TextConst ENU = 'SEVEN', FRA = 'SEPT';
        Text039: TextConst ENU = 'EIGHT', FRA = 'HUIT';
        Text040: TextConst ENU = 'NINE', FRA = 'NEUF';
        Text041: TextConst ENU = 'TEN', FRA = 'DIX';
        Text042: TextConst ENU = 'ELEVEN', FRA = 'ONZE';
        Text043: TextConst ENU = 'TWELVE', FRA = 'DOUZE';
        Text044: TextConst ENU = 'THIRTEEN', FRA = 'TREIZE';
        Text045: TextConst ENU = 'FOURTEEN', FRA = 'QUATORZE';
        Text046: TextConst ENU = 'FIFTEEN', FRA = 'QUINZE';
        Text047: TextConst ENU = 'SIXTEEN', FRA = 'SEIZE';
        Text048: TextConst ENU = 'SEVENTEEN', FRA = 'DIX-SEPT';
        Text049: TextConst ENU = 'EIGHTEEN', FRA = 'DIX-HUIT';
        Text050: TextConst ENU = 'NINETEEN', FRA = 'DIX-NEUF';
        Text051: TextConst ENU = 'TWENTY', FRA = 'VINGT';
        Text052: TextConst ENU = 'THIRTY', FRA = 'TRENTE';
        Text053: TextConst ENU = 'FORTY', FRA = 'QUARANTE';
        Text054: TextConst ENU = 'FIFTY', FRA = 'CINQUANTE';
        Text055: TextConst ENU = 'SIXTY', FRA = 'SOIXANTE';
        Text056: TextConst ENU = 'SEVENTY', FRA = 'SOIXANTE-DIX';
        Text057: TextConst ENU = 'EIGHTY', FRA = 'QUATRE-VINGT';
        Text058: TextConst ENU = 'NINETY', FRA = 'QUATRE-DIX';
        Text059: TextConst ENU = 'THOUSAND', FRA = 'MILLE';
        Text060: TextConst ENU = 'MILLION', FRA = 'MILLION';
        Text061: TextConst ENU = 'BILLION', FRA = 'MILLIARD';
        Text062: TextConst ENU = 'G/L Account,Customer,Vendor,Bank Account', FRA = 'Général,Client,Fournisseur,Banque';
        Text063: TextConst ENU = 'Net Amount %1', FRA = 'Montant net %1';
        Text064: TextConst ENU = '%1 must not be %2 for %3 %4.', FRA = '%1 ne doit pas être %2 pour %3 %4.';
        Text065: TextConst ENU = 'Subtotal', FRA = 'Sous-total';
        Text10800: TextConst ENU = 'GOURDES', FRA = 'GOURDES';
        Text10801: TextConst ENU = 'CENT', FRA = 'CENTIME';
        CheckNoTextCaptionLbl: TextConst ENU = 'Check No.', FRA = 'N° chèque';
        LineAmountCaptionLbl: TextConst ENU = 'Net Amount', FRA = 'Montant net';
        LineDiscountCaptionLbl: TextConst ENU = 'Discount', FRA = 'Remise';
        AmountCaptionLbl: TextConst ENU = 'Amount', FRA = 'Montant';
        DocNoCaptionLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        DocDateCaptionLbl: TextConst ENU = 'Document Date', FRA = 'Date document';
        CurrencyCodeCaptionLbl: TextConst ENU = 'Currency Code', FRA = 'Code devise';
        YourDocNoCaptionLbl: TextConst ENU = 'Your Doc. No.', FRA = 'Votre n° doc.';
        TransportCaptionLbl: TextConst ENU = 'Transport', FRA = 'Transport';
        Text34001101: TextConst ENU = 'The Currency Code on the Bank must be %1 or blank to print this Check.', ESP = 'El cód. divisa del banco debe ser %1 o en blanco para imprimir este cheque.', ESS = 'El cód. divisa del banco debe ser %1 o en blanco para imprimir este cheque.';
        Text34001100: TextConst ENU = 'The Stub Section may not contain more than %1 lines.', ESP = 'El máximo número de líneas para el comprobante son %1 líneas.', ESS = 'El máximo número de líneas para el comprobante son %1 líneas.';
        MessageToReceipt: Text;
        VendorName: Text;
        ExtVendorledgerEntry: Record "Vendor Ledger Entry";
        ExternalDocumentNo: array[5] of Text;
        j: Integer;
        Position: Integer;
        // BC Upgrade PATELS08 >>
        // Language : Record Language;
        LanguageRec: Record Language;
        // BC Upgrade PATELS08 <<
        FrLanguageCode: Integer;
        grec_genJnlLn: Record "Gen. Journal Line";
        ConvertLnIntgr: Integer;
        ShowCOM: Boolean;
        WHTPostingSetup: Record "WHT Posting Setup FND";
        GenAmount: Decimal;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10]);
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';
        GLSetup.GET();

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        else
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div POWER(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);//syed commented; bec of error Index out of bound //HEI.03 IBM SHANKJ03 20.01.2020 Uncommented Standard code
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            end;

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        DecimalPosition := GetAmtDecimalPosition();
        AddToNoText(NoText, NoTextIndex, PrintExponent, (FORMAT(No * DecimalPosition) + '/' + FORMAT(DecimalPosition)));

        /*
        IF CurrencyCode <> '' THEN
          AddToNoText(NoText,NoTextIndex,PrintExponent,CurrencyCode);
        */

    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30]);
    begin
        PrintExponent := true;
        while STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) - 33 do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ARRAYLEN(NoText) then
                ERROR(Text029, AddText);
        end;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    local procedure CustUpdateAmounts(var CustLedgEntry2: Record "Cust. Ledger Entry"; RemainingAmount2: Decimal);
    begin
        if (ApplyMethod = ApplyMethod::OneLineOneEntry) or
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        then begin
            GenJnlLine3.RESET();
            GenJnlLine3.SETCURRENTKEY(
              "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Customer);
            GenJnlLine3.SETRANGE("Account No.", CustLedgEntry2."Customer No.");
            GenJnlLine3.SETRANGE("Applies-to Doc. Type", CustLedgEntry2."Document Type");
            GenJnlLine3.SETRANGE("Applies-to Doc. No.", CustLedgEntry2."Document No.");
            if ApplyMethod = ApplyMethod::OneLineOneEntry then
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
            else
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
            if CustLedgEntry2."Document Type" <> CustLedgEntry2."Document Type"::" " then
                if GenJnlLine3.FIND('-') then
                    GenJnlLine3.FIELDERROR(
                      "Applies-to Doc. No.",
                      STRSUBSTNO(
                        Text030,
                        CustLedgEntry2."Document Type", CustLedgEntry2."Document No.",
                        CustLedgEntry2."Customer No."));
        end;

        DocNo := CustLedgEntry2."Document No.";
        ExtDocNo := CustLedgEntry2."External Document No." + 'B3';//bogdan
        DocDate := CustLedgEntry2."Posting Date";
        CurrencyCode2 := CustLedgEntry2."Currency Code";

        CustLedgEntry2.CALCFIELDS("Remaining Amount");

        LineAmount :=
          -ABSMin(
            CustLedgEntry2."Remaining Amount" -
            CustLedgEntry2."Remaining Pmt. Disc. Possible" -
            CustLedgEntry2."Accepted Payment Tolerance",
            CustLedgEntry2."Amount to Apply");
        LineAmount2 :=
          ROUND(
            ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, LineAmount),
            Currency."Amount Rounding Precision");

        if ((CustLedgEntry2."Document Type" in [CustLedgEntry2."Document Type"::Invoice,
                                                CustLedgEntry2."Document Type"::"Credit Memo"]) and
            (CustLedgEntry2."Remaining Pmt. Disc. Possible" <> 0) and
            (CustLedgEntry2."Posting Date" <= CustLedgEntry2."Pmt. Discount Date")) or
           CustLedgEntry2."Accepted Pmt. Disc. Tolerance"
        then begin
            LineDiscount := -CustLedgEntry2."Remaining Pmt. Disc. Possible";
            if CustLedgEntry2."Accepted Payment Tolerance" <> 0 then
                LineDiscount := LineDiscount - CustLedgEntry2."Accepted Payment Tolerance";
        end else begin
            if RemainingAmount2 >=
               ROUND(
                 -ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                   CustLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision")
            then
                LineAmount2 :=
                  ROUND(
                    -ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                      CustLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision")
            else begin
                LineAmount2 := RemainingAmount2;
                LineAmount :=
                  ROUND(
                    ExchangeAmt(CustLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                      LineAmount2), Currency."Amount Rounding Precision");
            end;
            LineDiscount := 0;
        end;
    end;

    local procedure VendUpdateAmounts(var VendLedgEntry2: Record "Vendor Ledger Entry"; RemainingAmount2: Decimal);
    var
        LocalGenJournalLine: Record "Gen. Journal Line";
    begin
        if (ApplyMethod = ApplyMethod::OneLineOneEntry) or
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        then begin
            GenJnlLine3.RESET();
            GenJnlLine3.SETCURRENTKEY(
              "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Vendor);
            GenJnlLine3.SETRANGE("Account No.", VendLedgEntry2."Vendor No.");
            GenJnlLine3.SETRANGE("Applies-to Doc. Type", VendLedgEntry2."Document Type");
            GenJnlLine3.SETRANGE("Applies-to Doc. No.", VendLedgEntry2."Document No.");
            if ApplyMethod = ApplyMethod::OneLineOneEntry then
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
            else
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
            if VendLedgEntry2."Document Type" <> VendLedgEntry2."Document Type"::" " then
                if GenJnlLine3.FIND('-') then
                    GenJnlLine3.FIELDERROR(
                      "Applies-to Doc. No.",
                      STRSUBSTNO(
                        Text031,
                        VendLedgEntry2."Document Type", VendLedgEntry2."Document No.",
                        VendLedgEntry2."Vendor No."));
        end;

        DocNo := VendLedgEntry2."Document No.";

        DocDate := VendLedgEntry2."Posting Date";
        CurrencyCode2 := VendLedgEntry2."Currency Code";
        VendLedgEntry2.CALCFIELDS("Remaining Amount");

        LineAmount :=
          -ABSMin(
            VendLedgEntry2."Remaining Amount" -
            VendLedgEntry2."Remaining Pmt. Disc. Possible" -
            VendLedgEntry2."Accepted Payment Tolerance",
            VendLedgEntry2."Amount to Apply");

        LineAmount2 :=
          ROUND(
            ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, LineAmount),
            Currency."Amount Rounding Precision");

        if ((VendLedgEntry2."Document Type" in [VendLedgEntry2."Document Type"::Invoice,
                                                VendLedgEntry2."Document Type"::"Credit Memo"]) and
            (VendLedgEntry2."Remaining Pmt. Disc. Possible" <> 0) and
            (GenJnlLine."Posting Date" <= VendLedgEntry2."Pmt. Discount Date")) or
           VendLedgEntry2."Accepted Pmt. Disc. Tolerance"
        then begin
            LineDiscount := -VendLedgEntry2."Remaining Pmt. Disc. Possible";
            if VendLedgEntry2."Accepted Payment Tolerance" <> 0 then
                LineDiscount := LineDiscount - VendLedgEntry2."Accepted Payment Tolerance";
        end else begin
            if ABS(RemainingAmount2) >=
               ABS(ROUND(
                   ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                     VendLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision"))
            then begin
                LineAmount2 :=
                  ROUND(
                    -ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                      VendLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision");
                LineAmount :=
                  ROUND(
                    ExchangeAmt(VendLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                      LineAmount2), Currency."Amount Rounding Precision");
            end else begin
                LineAmount2 := RemainingAmount2;
                LineAmount :=
                  ROUND(
                    ExchangeAmt(VendLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                      LineAmount2), Currency."Amount Rounding Precision");
            end;
            LineDiscount := 0;
        end;
    end;

    procedure InitTextVariable();
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;

    procedure InitializeRequest(BankAcc: Code[20]; LastCheckNo: Code[20]; NewOneCheckPrVend: Boolean; NewReprintChecks: Boolean; NewTestPrint: Boolean; NewPreprintedStub: Boolean);
    begin
        if BankAcc <> '' then
            if BankAcc2.GET(BankAcc) then begin
                UseCheckNo := LastCheckNo;
                OneCheckPrVendor := NewOneCheckPrVend;
                ReprintChecks := NewReprintChecks;
                TestPrint := NewTestPrint;
                PreprintedStub := NewPreprintedStub;
            end;
    end;

    procedure ExchangeAmt(PostingDate: Date; CurrencyCode: Code[10]; CurrencyCode2: Code[10]; Amount: Decimal) Amount2: Decimal;
    begin
        if (CurrencyCode <> '') and (CurrencyCode2 = '') then
            Amount2 :=
              CurrencyExchangeRate.ExchangeAmtLCYToFCY(
                PostingDate, CurrencyCode, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode))
        else
            if (CurrencyCode = '') and (CurrencyCode2 <> '') then
                Amount2 :=
                  CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                    PostingDate, CurrencyCode2, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode2))
            else
                if (CurrencyCode <> '') and (CurrencyCode2 <> '') and (CurrencyCode <> CurrencyCode2) then
                    Amount2 := CurrencyExchangeRate.ExchangeAmtFCYToFCY(PostingDate, CurrencyCode2, CurrencyCode, Amount)
                else
                    Amount2 := Amount;
    end;

    procedure ABSMin(Decimal1: Decimal; Decimal2: Decimal): Decimal;
    begin
        if ABS(Decimal1) < ABS(Decimal2) then
            exit(Decimal1);
        exit(Decimal2);
    end;

    procedure InputBankAccount();
    begin
        if BankAcc2."No." <> '' then begin
            BankAcc2.GET(BankAcc2."No.");
            BankAcc2.TESTFIELD("Last Check No.");
            UseCheckNo := BankAcc2."Last Check No.";
        end;
    end;

    local procedure GetAmtDecimalPosition(): Decimal;
    var
        Currency: Record Currency;
    begin
        if GenJnlLine."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.GET(GenJnlLine."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        end;
        exit(1 / Currency."Amount Rounding Precision");
    end;

    procedure AccUpdateAmounts(NewGenJnlLine: Record "Gen. Journal Line"; NewCurrentLineAmount: Decimal);
    begin

        LineAmount2 := NewCurrentLineAmount;

        DocType := FORMAT(NewGenJnlLine."Document Type");
        DocNo := NewGenJnlLine."Document No.";
        DocDate := NewGenJnlLine."Posting Date";
        CurrencyCode2 := NewGenJnlLine."Currency Code";
        DocExtNo := NewGenJnlLine."External Document No.";
        DocGlobalDim1 := NewGenJnlLine."Shortcut Dimension 1 Code";
        DocGlobalDim2 := NewGenJnlLine."Shortcut Dimension 2 Code";
        case NewGenJnlLine."Account Type" of
            NewGenJnlLine."Account Type"::"G/L Account":
                DocAccNo := NewGenJnlLine."Account No.";
            NewGenJnlLine."Account Type"::Vendor:
                DocAccNo := GetVendPostAcc(NewGenJnlLine."Account No.");
            NewGenJnlLine."Account Type"::Customer:
                DocAccNo := GetCustPostAcc(NewGenJnlLine."Account No.");
            NewGenJnlLine."Account Type"::"Bank Account":
                DocAccNo := GetBankPostAcc(NewGenJnlLine."Account No.");
        end;
        DocVATRegNo := NewGenJnlLine."VAT Registration No.";
        DocDescription := NewGenJnlLine.Description;
    end;

    procedure GetBankPostAcc(BankNo: Code[20]): Text[20];
    var
        Bank: Record "Bank Account";
        BankPostGroup: Record "Bank Account Posting Group";
    begin

        Bank.GET(BankNo);
        if BankPostGroup.GET(Bank."Bank Acc. Posting Group") then begin
            // BC Upgrade PATELS08 >> 
            // exit(BankPostGroup."G/L Bank Account No."); //BC Upgrade PATELS08 - Navision 'G/L Bank Account No.' -> Business Central 'G/L Account No.'
            exit(BankPostGroup."G/L Account No.");
            // BC Upgrade PATELS08 <<
        end else
            exit('');
    end;

    procedure GetCustPostAcc(CustomerNo: Code[20]): Text[20];
    var
        Customer: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
    begin

        Customer.GET(CustomerNo);
        if CustPostGroup.GET(Customer."Customer Posting Group") then begin
            exit(CustPostGroup."Receivables Account");
        end else
            exit('');
    end;

    procedure GetVendPostAcc(VendorNo: Code[20]): Text[20];
    var
        Vendor: Record Vendor;
        VendPostGroup: Record "Vendor Posting Group";
    begin

        Vendor.GET(VendorNo);
        if VendPostGroup.GET(Vendor."Vendor Posting Group") then begin
            exit(VendPostGroup."Payables Account");
        end else
            exit('');
    end;

    procedure GetVATEntry(DocumentNo: Code[20]; PostingDate: Date; VATEntryType: Integer);
    var
        VATEntry: Record "VAT Entry";
    begin
    end;

    procedure LanguageMonth(Month: Text[30]): Text[30];
    var
        Text59001: TextConst ENU = 'JANUARY', ESA = 'ENERO';
        Text59002: TextConst ENU = 'FEBRUARY', ESA = 'FEBRERO';
        Text59003: TextConst ENU = 'MARCH', ESA = 'MARZO';
        Text59004: TextConst ENU = 'APRIL', ESA = 'ABRIL';
        Text59005: TextConst ENU = 'MAY', ESA = 'MAYO';
        Text59006: TextConst ENU = 'JUNE', ESA = 'JUNIO';
        Text59007: TextConst ENU = 'JULY', ESA = 'JULIO';
        Text59008: TextConst ENU = 'AUGUST', ESA = 'AGOSTO';
        Text59009: TextConst ENU = 'SEPTEMBER', ESA = 'SEPTIEMBRE';
        Text59010: TextConst ENU = 'OCTOBER', ESA = 'OCTUBRE';
        Text59011: TextConst ENU = 'NOVEMBER', ESA = 'NOVIEMBRE';
        Text59012: TextConst ENU = 'DECEMBER', ESA = 'DICIEMBRE';
    begin

        case Month of
            '1':
                exit(Text59001);
            '2':
                exit(Text59002);
            '3':
                exit(Text59003);
            '4':
                exit(Text59004);
            '5':
                exit(Text59005);
            '6':
                exit(Text59006);
            '7':
                exit(Text59007);
            '8':
                exit(Text59008);
            '9':
                exit(Text59009);
            '10':
                exit(Text59010);
            '11':
                exit(Text59011);
            '12':
                exit(Text59012);
        end;
    end;

    procedure FormatNoTextFR(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10]);
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        else begin
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div POWER(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;

                if Hundreds = 1 then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027)
                else begin
                    if Hundreds > 1 then begin
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                        if (Tens * 10 + Ones) = 0 then
                            AddToNoText(NoText, NoTextIndex, PrintExponent, Text027 + 'S')
                        else
                            AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                    end;
                end;

                FormatTens(NoText, NoTextIndex, PrintExponent, Exponent, Hundreds, Tens, Ones);

                if PrintExponent and (Exponent > 1) then
                    if ((Hundreds * 100 + Tens * 10 + Ones) > 1) and (Exponent <> 2) then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent] + 'S')
                    else
                        AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);

                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            end;
        end;

        /*
        IF CurrencyCode = '' THEN
          AddToNoText(NoText,NoTextIndex,PrintExponent,Text10800)
        ELSE BEGIN
          Currency.GET(CurrencyCode);
          AddToNoText(NoText,NoTextIndex,PrintExponent,UPPERCASE(Currency.Description));
        END;
        */

        /*
        No := No * 100;
        Ones := No MOD 10;
        Tens := No DIV 10;
        FormatTens(NoText,NoTextIndex,PrintExponent,Exponent,Hundreds,Tens,Ones);
        
        CASE TRUE OF
          No = 1: AddToNoText(NoText,NoTextIndex,PrintExponent,Text10801);
          No > 1: AddToNoText(NoText,NoTextIndex,PrintExponent,Text10801 + 'S');
        END;
        */

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        DecimalPosition := GetAmtDecimalPosition();
        AddToNoText(NoText, NoTextIndex, PrintExponent, (FORMAT(No * DecimalPosition) + '/' + FORMAT(DecimalPosition)));

    end;

    procedure FormatTens(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; Exponent: Integer; Hundreds: Integer; Tens: Integer; Ones: Integer);
    begin
        case Tens of
            9:
                begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text057);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones + 10]);
                end;

            8:
                begin
                    if Ones = 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, Text057 + 'S')
                    else begin
                        AddToNoText(NoText, NoTextIndex, PrintExponent, Text057);
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                    end;
                end;

            7:
                begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text055);
                    if Ones = 1 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones + 10]);
                end;

            2:
                begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text051);
                    if Ones > 0 then begin
                        if Ones = 1 then
                            AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                    end;
                end;

            1:
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);

            0:
                begin
                    if Ones > 0 then
                        if (Ones = 1) and (Hundreds < 1) and (Exponent = 2) then
                            PrintExponent := true
                        else
                            AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end;

            else begin
                AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                if Ones > 0 then begin
                    if Ones = 1 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, 'ET');
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end;
            end;
        end;
    end;
}

