report 51039 "Check IvC STANBIC CBN"
{
    // version NAVW110.0,HEI.04

    // HEI.01 FDD BA-PTPGAP03 IBM NASTAA02 04.02.2019 # Digital Checks Printout
    //   # New Report created based on Standard Report 1401 - Check
    //   # In Heilite Bal. Account Type should always be "G/L Account"
    // HEI.02 HT971 CHG2040699 IBM POSTOI01 06.02.2020 # add deduct the WHT Amount
    // 
    // HEI.04 FDD CHG2037399 IBM NANDIS01 17.03.2020 - Cheque Printing
    //   # Remove Field "Check Payment Format"
    //   # Deleted dataset BankAcc2."Check Payment Format"
    //   # Code added for bank account populate in request page
    //   # SaveValues property of TRUE deleted


    // BC Upgrade KUMARS145 Nav ID Report 50284 "Check IvC STANBIC"

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Check IvC STANBIC.rdl';
    Caption = 'Check IvC STANBIC';
    Permissions = TableData "Bank Account" = m;
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(VoidGenJnlLine; "Gen. Journal Line")
        {
            DataItemTableView = Sorting("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Posting Date";

            trigger OnAfterGetRecord();
            begin
                CheckManagement.VoidCheck(VoidGenJnlLine);
            end;

            trigger OnPreDataItem();
            begin
                //IF CurrReport.PREVIEW THEN
                //  Error(Text000);

                if UseCheckNo = '' then
                    Error(Text001);

                if TestPrint then
                    CurrReport.Break();

                if not ReprintChecks then
                    CurrReport.Break();

                //IF (GetFilter("Line No.") <> '') OR (GetFilter("Document No.") <> '') THEN   //HEI.02
                if (GetFilter("Document No.") <> '') then
                    Error(Text002, FieldCaption("Line No."), FieldCaption("Document No."));
                SetRange("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                SetRange("Check Printed", true);
                SetRange("Parent Line No. FND", 0); //HEI.01
            end;
        }
        dataitem(GenJnlLine; "Gen. Journal Line")
        {
            DataItemTableView = Sorting("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            column(CompName; CompanyInfo.Name) { }
            column(CompCity; CompanyInfo.City) { }
            column(JournalTempName_GenJnlLine; "Journal Template Name") { }
            column(JournalBatchName_GenJnlLine; "Journal Batch Name") { }
            column(LineNo_GenJnlLine; "Line No.") { }
            column(GenJnlLine_DocumentNo; "Document No.") { }
            column(GenJnlLine_PostingDate; Format("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(Vendor_No; Vend."No.") { }
            column(Vendor_Name; Vend.Name) { }
            column(VendorName_1; VendorName_1) { }
            column(VendorName_2; VendorName_2) { }
            column(Vendor_Name_Concat; Vendor_Name_Concat) { }
            column(Vendor_POBox; Vend."P.O. Box FND") { }
            column(Vendor_Address; Vend."House Number FND" + ' ' + Vend.Address) { }
            column(Vendor_City; Vend.City) { }
            column(VendPhone; Vend."Phone No.") { }
            column(VendVATReg; Vend."VAT Registration No.") { }
            column(AmountText; MntLettres) { }
            column(AmountText2; MntLettres2) { }
            column(Amount; GenJnlLine.Amount - GenJnlLine."WHT Amount FND") { }
            column(HNKBankAcc; BankAccount3.Name) { }
            dataitem(CheckPages; "Integer")
            {
                DataItemTableView = Sorting(Number);
                column(FirstPage; FirstPage) { }
                column(PreprintedStub; PreprintedStub) { }
                dataitem(PrintSettledLoop; "Integer")
                {
                    DataItemTableView = Sorting(Number);
                    MaxIteration = 30;

                    trigger OnAfterGetRecord();
                    begin
                        if not TestPrint then begin
                            if FoundLast then begin
                                if RemainingAmount <> 0 then begin
                                    DocNo := '';
                                    ExtDocNo := '';
                                    DocDate := 0D;
                                    LineAmount := RemainingAmount;
                                    LineAmount2 := RemainingAmount;
                                    CurrentLineAmount := LineAmount2;
                                    LineDiscount := 0;
                                    RemainingAmount := 0;
                                end else
                                    CurrReport.Break();
                            end else
                                case ApplyMethod of
                                    ApplyMethod::OneLineOneEntry:
                                        begin
                                            case BalancingType of
                                                BalancingType::Customer:
                                                    begin
                                                        CustLedgEntry.Reset();
                                                        CustLedgEntry.SetCurrentKey(
                                                        "Document No.");
                                                        CustLedgEntry.SetRange("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                        CustLedgEntry.SetRange("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                        CustLedgEntry.SetRange("Customer No.", BalancingNo);
                                                        CustLedgEntry.Find('-');
                                                        CustUpdateAmounts(CustLedgEntry, RemainingAmount);
                                                    end;
                                                BalancingType::Vendor:
                                                    begin
                                                        VendLedgEntry.Reset();
                                                        VendLedgEntry.SetCurrentKey(
                                                        "Document No.");
                                                        VendLedgEntry.SetRange("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                        VendLedgEntry.SetRange("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                        VendLedgEntry.SetRange("Vendor No.", BalancingNo);
                                                        VendLedgEntry.Find('-');
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
                                                        FoundLast := (CustLedgEntry.Next() = 0) or (RemainingAmount <= 0);
                                                        if FoundLast and not FoundNegative then begin
                                                            CustLedgEntry.SetRange(Positive, false);
                                                            FoundLast := not CustLedgEntry.Find('-');
                                                            FoundNegative := true;
                                                        end;
                                                    end;
                                                BalancingType::Vendor:
                                                    begin
                                                        VendUpdateAmounts(VendLedgEntry, RemainingAmount);
                                                        FoundLast := (VendLedgEntry.Next() = 0) or (RemainingAmount <= 0);
                                                        if FoundLast and not FoundNegative then begin
                                                            VendLedgEntry.SetRange(Positive, false);
                                                            FoundLast := not VendLedgEntry.Find('-');
                                                            FoundNegative := true;
                                                        end;
                                                    end;
                                            end;
                                            RemainingAmount := RemainingAmount - LineAmount2;
                                            CurrentLineAmount := LineAmount2;
                                        end;
                                    ApplyMethod::MoreLinesOneEntry:
                                        begin
                                            CurrentLineAmount := GenJnlLine2.Amount;
                                            LineAmount2 := CurrentLineAmount;

                                            if GenJnlLine2."Applies-to ID" <> '' then
                                                Error(Text016);
                                            GenJnlLine2.TestField("Check Printed", false);
                                            GenJnlLine2.TestField("Bank Payment Type", GenJnlLine2."Bank Payment Type"::"Computer Check");
                                            if BankAcc2."Currency Code" <> GenJnlLine2."Currency Code" then
                                                Error(Text005);
                                            if GenJnlLine2."Applies-to Doc. No." = '' then begin
                                                DocNo := '';
                                                ExtDocNo := '';
                                                DocDate := 0D;
                                                LineAmount := CurrentLineAmount;
                                                LineDiscount := 0;
                                            end else
                                                case BalancingType of
                                                    BalancingType::"G/L Account":
                                                        begin
                                                            DocNo := GenJnlLine2."Document No.";
                                                            ExtDocNo := GenJnlLine2."External Document No.";
                                                            LineAmount := CurrentLineAmount;
                                                            LineDiscount := 0;
                                                        end;
                                                    BalancingType::Customer:
                                                        begin
                                                            CustLedgEntry.Reset();
                                                            CustLedgEntry.SetCurrentKey(
                                                            "Document No.");
                                                            CustLedgEntry.SetRange("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                            CustLedgEntry.SetRange("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                            CustLedgEntry.SetRange("Customer No.", BalancingNo);
                                                            CustLedgEntry.Find('-');
                                                            CustUpdateAmounts(CustLedgEntry, CurrentLineAmount);
                                                            LineAmount := CurrentLineAmount;
                                                        end;
                                                    BalancingType::Vendor:
                                                        begin
                                                            VendLedgEntry.Reset();
                                                            if GenJnlLine2."Source Line No." <> 0 then
                                                                VendLedgEntry.SetRange("Entry No.", GenJnlLine2."Source Line No.")
                                                            else begin
                                                                VendLedgEntry.SetCurrentKey(
                                                                "Document No.");
                                                                VendLedgEntry.SetRange("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                                VendLedgEntry.SetRange("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                                VendLedgEntry.SetRange("Vendor No.", BalancingNo);
                                                            end;
                                                            VendLedgEntry.Find('-');
                                                            VendUpdateAmounts(VendLedgEntry, CurrentLineAmount);
                                                            LineAmount := CurrentLineAmount;
                                                        end;
                                                    BalancingType::"Bank Account":
                                                        begin
                                                            DocNo := GenJnlLine2."Document No.";
                                                            ExtDocNo := GenJnlLine2."External Document No.";
                                                            LineAmount := CurrentLineAmount;
                                                            LineDiscount := 0;
                                                        end;
                                                end;
                                            FoundLast := GenJnlLine2.Next() = 0;
                                        end;
                                end;

                            TotalLineAmount := TotalLineAmount + LineAmount2;
                            TotalLineDiscount := TotalLineDiscount + LineDiscount;
                        end else begin
                            if FoundLast then
                                CurrReport.Break();
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
                                                    CustLedgEntry.Reset();
                                                    CustLedgEntry.SetCurrentKey(
                                                    "Customer No.", Open, Positive);
                                                    CustLedgEntry.SetRange("Customer No.", BalancingNo);
                                                    CustLedgEntry.SetRange(Open, true);
                                                    CustLedgEntry.SetRange(Positive, true);
                                                    CustLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID");
                                                    FoundLast := not CustLedgEntry.Find('-');
                                                    if FoundLast then begin
                                                        CustLedgEntry.SetRange(Positive, false);
                                                        FoundLast := not CustLedgEntry.Find('-');
                                                        FoundNegative := true;
                                                    end else
                                                        FoundNegative := false;
                                                end;
                                            BalancingType::Vendor:
                                                begin
                                                    VendLedgEntry.Reset();
                                                    VendLedgEntry.SetCurrentKey(
                                                    "Vendor No.", Open, Positive);
                                                    VendLedgEntry.SetRange("Vendor No.", BalancingNo);
                                                    VendLedgEntry.SetRange(Open, true);
                                                    VendLedgEntry.SetRange(Positive, true);
                                                    VendLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID");
                                                    FoundLast := not VendLedgEntry.Find('-');
                                                    if FoundLast then begin
                                                        VendLedgEntry.SetRange(Positive, false);
                                                        FoundLast := not VendLedgEntry.Find('-');
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
                            NetAmount := StrSubstNo(Text063, GenJnlLine."Currency Code")
                        else begin
                            GLSetup.Get();
                            NetAmount := StrSubstNo(Text063, GLSetup."LCY Code");
                        end;

                        //HEI.01>>
                        if Currency.Get(CurrencyCode2) then
                            CurrencyDescription := Currency.Description
                        else
                            CurrencyDescription := BNSCurrencyDescription;
                        //HEI.01<<
                    end;
                }
                dataitem(PrintCheck; "Integer")
                {
                    DataItemTableView = Sorting(Number);
                    MaxIteration = 1;
                    column(TotalLineAmount; TotalLineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(CheckNoText; CheckNoText) { }
                    column(Currency_Description; CurrencyDescription) { }
                    column(CheckAmountText; CheckAmountText2) { }
                    column(DescriptionLine1; DescriptionLine[1] + ' ***') { }
                    column(DescriptionLine2; DescriptionLine[2]) { }
                    column(TotalText; TotalText) { }
                    column(VoidText; VoidText) { }
                    column(Vendor_Country; CountryRegion.Name) { }
                    column(BankAcc_Signature; BankAcc2."Check Electronic Signature FND") { }
                    column(ShowBNS; ShowBNS) { }
                    column(ShowFCIB; ShowFCIB) { }
                    dataitem("Payment Line"; "Gen. Journal Line")
                    {
                        DataItemTableView = Sorting("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                        column(PL_DocNo; PostedPurInv."No.") { }
                        column(LineNo; LineNo) { }
                        column(PlineLineNo; "Payment Line"."Line No.") { }
                        column(ExternalDocumentNo_PaymentLine; PostedPurInv."Vendor Invoice No.") { }
                        column(AmountLine1; Format(Amount - "WHT Amount FND", 0, AmountFormatStr)) { }
                        column(AmountLine; Round(Amount - "WHT Amount FND", Perssion, '=')) { }
                        column(VendorCode; "Payment Line"."Account No.") { }
                        column(VendorBankAccCode; Format("Payment Line"."Vendor Bank Account FND")) { }
                        column(DueDate; PostedPurInv."Due Date") { }
                        column(AmountLineLCY; Round(AmountLCY, Perssion, '=')) { }

                        trigger OnAfterGetRecord();
                        begin
                            LineNo += 1;

                            if "Payment Line"."Amount (LCY)" <> 0 then
                                AmountLCY := "Payment Line"."Amount (LCY)" - "Payment Line"."WHT Amount (LCY) FND" //HEI.02
                            else
                                AmountLCY := "Payment Line".Amount - "Payment Line"."WHT Amount FND"; //HEI.02

                            if "Payment Line"."Applies-to Doc. Type" = "Payment Line"."Applies-to Doc. Type"::Invoice then
                                if PostedPurInv.Get("Payment Line"."Applies-to Doc. No.") then;
                        end;

                        trigger OnPreDataItem();
                        begin
                            LineNo := 0;//IBM PATHAA02 24.10.2017
                            //HEI.02>>
                            "Payment Line".SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                            "Payment Line".SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            "Payment Line".SetRange("Parent Line No. FND", GenJnlLine."Line No.");
                            //HEI.02<<
                        end;
                    }

                    trigger OnAfterGetRecord();
                    var
                        Decimals: Decimal;
                        CheckLedgEntryAmount: Decimal;
                    begin
                        if not TestPrint then begin
                            //with GenJnlLine do begin // BC upgrade KUMARS145 Removed 'with' statement as it is deprecated.
                            CheckLedgEntry.Init();
                            CheckLedgEntry."Bank Account No." := BankAcc2."No.";
                            CheckLedgEntry."Posting Date" := GenJnlLine."Posting Date";
                            CheckLedgEntry."Document Type" := GenJnlLine."Document Type";
                            CheckLedgEntry."Document No." := UseCheckNo;
                            CheckLedgEntry.Description := GenJnlLine.Description;
                            CheckLedgEntry."Bank Payment Type" := GenJnlLine."Bank Payment Type";
                            // BC Upgrade MISHRS14 >> TO RMEOVE WARNING OF IMPLICIT CONVERSION
                            if BalancingType = BalancingType::"G/L Account" then
                                CheckLedgEntry."Bal. Account Type" := CheckLedgEntry."Bal. Account Type"::"G/L Account"
                            else
                                if BalancingType = BalancingType::Customer then
                                    CheckLedgEntry."Bal. Account Type" := CheckLedgEntry."Bal. Account Type"::Customer
                            else
                                if BalancingType = BalancingType::Vendor then
                                    CheckLedgEntry."Bal. Account Type" := CheckLedgEntry."Bal. Account Type"::Vendor
                            else
                                if BalancingType = BalancingType::"Bank Account" then
                                    CheckLedgEntry."Bal. Account Type" := CheckLedgEntry."Bal. Account Type"::"Bank Account";
                            // BC Upgrade MISHRS14 <<
                            CheckLedgEntry."Bal. Account No." := BalancingNo;
                            if FoundLast then begin
                                if TotalLineAmount <= 0 then
                                    Error(
                                      Text020,
                                      UseCheckNo, TotalLineAmount);
                                CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Printed;
                                CheckLedgEntry.Amount := TotalLineAmount;
                            end else begin
                                CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Voided;
                                CheckLedgEntry.Amount := 0;
                            end;
                            CheckLedgEntry."Check Date" := GenJnlLine."Posting Date";
                            CheckLedgEntry."Check No." := UseCheckNo;
                            CheckManagement.InsertCheck(CheckLedgEntry, RECORDID);

                            if FoundLast then begin
                                if BankAcc2."Currency Code" <> '' then
                                    Currency.Get(BankAcc2."Currency Code")
                                else
                                    Currency.InitRoundingPrecision();
                                CheckLedgEntryAmount := CheckLedgEntry.Amount;
                                Decimals := CheckLedgEntry.Amount - Round(CheckLedgEntry.Amount, 1, '<');
                                if StrLen(Format(Decimals)) < StrLen(Format(Currency."Amount Rounding Precision")) then
                                    if Decimals = 0 then
                                        CheckAmountText := Format(CheckLedgEntryAmount, 0, 0) +
                                          CopyStr(Format(0.01), 2, 1) +
                                          PADSTR('', StrLen(Format(Currency."Amount Rounding Precision")) - 2, '0')
                                    else
                                        CheckAmountText := Format(CheckLedgEntryAmount, 0, 0) +
                                          PADSTR('', StrLen(Format(Currency."Amount Rounding Precision")) - StrLen(Format(Decimals)), '0')
                                else
                                    CheckAmountText := Format(CheckLedgEntryAmount, 0, 0);
                                FormatNoText(DescriptionLine, CheckLedgEntry.Amount, BankAcc2."Currency Code");
                                VoidText := '';
                            end else begin
                                Clear(CheckAmountText);
                                Clear(DescriptionLine);
                                TotalText := Text065;
                                DescriptionLine[1] := Text021;
                                DescriptionLine[2] := DescriptionLine[1];
                                VoidText := Text022;
                            end;
                            // end;
                        end else begin

                            //with GenJnlLine do begin // BC upgrade KUMARS145 Removed 'with' statement as it is deprecated.
                            CheckLedgEntry.Init();
                            CheckLedgEntry."Bank Account No." := BankAcc2."No.";
                            CheckLedgEntry."Posting Date" := GenJnlLine."Posting Date";
                            CheckLedgEntry."Document No." := UseCheckNo;
                            CheckLedgEntry.Description := Text023;
                            CheckLedgEntry."Bank Payment Type" := "Bank Payment Type"::"Computer Check";
                            CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::"Test Print";
                            CheckLedgEntry."Check Date" := GenJnlLine."Posting Date";
                            CheckLedgEntry."Check No." := UseCheckNo;
                            CheckManagement.InsertCheck(CheckLedgEntry, RECORDID);

                            CheckAmountText := Text024;
                            DescriptionLine[1] := Text025;
                            DescriptionLine[2] := DescriptionLine[1];
                            VoidText := Text022;
                            // end;
                        end;

                        ChecksPrinted := ChecksPrinted + 1;
                        FirstPage := false;

                        //HEI.01>>
                        if CountryRegion.Get(Vend."Country/Region Code") then;
                        if ShowFCIB then
                            CheckAmountText2 := '*** ' + CheckAmountText + ' *';
                        if ShowBNS then
                            CheckAmountText2 := '********* ' + CheckAmountText + ' * ' + Currency.Code;
                        //HEI.01<<
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if FoundLast then
                        CurrReport.Break();

                    UseCheckNo := IncStr(UseCheckNo);
                    if not TestPrint then
                        CheckNoText := UseCheckNo
                    else
                        CheckNoText := Text011;
                end;

                trigger OnPostDataItem();
                begin
                    if not TestPrint then begin
                        if UseCheckNo <> GenJnlLine."Document No." then begin
                            GenJnlLine3.Reset();
                            GenJnlLine3.SetCurrentKey(
                            "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                            GenJnlLine3.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                            GenJnlLine3.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            GenJnlLine3.SetRange("Posting Date", GenJnlLine."Posting Date");
                            GenJnlLine3.SetRange("Document No.", UseCheckNo);
                            if GenJnlLine3.Find('-') then
                                GenJnlLine3.FieldError("Document No.", StrSubstNo(Text013, UseCheckNo));
                        end;

                        if ApplyMethod <> ApplyMethod::MoreLinesOneEntry then begin
                            GenJnlLine3 := GenJnlLine;
                            GenJnlLine3.TestField("Posting No. Series", '');
                            //GenJnlLine3."Document No." := UseCheckNo; //HEI.01
                            GenJnlLine3."Check Printed" := true;
                            GenJnlLine3."HNK Check No. FND" := UseCheckNo; //HEI.01
                            GenJnlLine3.Modify();
                        end else begin
                            if GenJnlLine2.Find('-') then begin
                                HighestLineNo := GenJnlLine2."Line No.";
                                repeat
                                    if GenJnlLine2."Line No." > HighestLineNo then
                                        HighestLineNo := GenJnlLine2."Line No.";
                                    GenJnlLine3 := GenJnlLine2;
                                    GenJnlLine3.TestField("Posting No. Series", '');
                                    GenJnlLine3."Bal. Account No." := '';
                                    GenJnlLine3."Bank Payment Type" := GenJnlLine3."Bank Payment Type"::" ";
                                    //GenJnlLine3."Document No." := UseCheckNo; //HEI.01
                                    GenJnlLine3."Check Printed" := true;
                                    GenJnlLine3.Validate(Amount);
                                    GenJnlLine3.Modify();
                                until GenJnlLine2.Next() = 0;
                            end;

                            GenJnlLine3.Reset();
                            GenJnlLine3 := GenJnlLine;
                            GenJnlLine3.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                            GenJnlLine3.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            GenJnlLine3."Line No." := HighestLineNo;
                            if GenJnlLine3.Next() = 0 then
                                GenJnlLine3."Line No." := HighestLineNo + 10000
                            else begin
                                while GenJnlLine3."Line No." = HighestLineNo + 1 do begin
                                    HighestLineNo := GenJnlLine3."Line No.";
                                    if GenJnlLine3.Next() = 0 then
                                        GenJnlLine3."Line No." := HighestLineNo + 20000;
                                end;
                                GenJnlLine3."Line No." := (GenJnlLine3."Line No." + HighestLineNo) div 2;
                            end;
                            GenJnlLine3.Init();
                            GenJnlLine3.Validate("Posting Date", GenJnlLine."Posting Date");
                            GenJnlLine3."Document Type" := GenJnlLine."Document Type";
                            //GenJnlLine3."Document No." := UseCheckNo; //HEI.01
                            GenJnlLine3."Account Type" := GenJnlLine3."Account Type"::"Bank Account";
                            GenJnlLine3.Validate("Account No.", BankAcc2."No.");
                            if BalancingType <> BalancingType::"G/L Account" then
                                GenJnlLine3.Description := StrSubstNo(Text014, SelectStr(BalancingType + 1, Text062), BalancingNo);
                            GenJnlLine3.Validate(Amount, -TotalLineAmount);
                            GenJnlLine3."Bank Payment Type" := GenJnlLine3."Bank Payment Type"::"Computer Check";
                            GenJnlLine3."Check Printed" := true;
                            GenJnlLine3."HNK Check No. FND" := UseCheckNo; //HEI.01
                            GenJnlLine3."Source Code" := GenJnlLine."Source Code";
                            GenJnlLine3."Reason Code" := GenJnlLine."Reason Code";
                            GenJnlLine3."Allow Zero-Amount Posting" := true;
                            GenJnlLine3.Insert();
                        end;
                    end;

                    BankAcc2."Last Check No." := UseCheckNo;
                    BankAcc2.Modify();

                    Clear(CheckManagement);
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
            begin
                if OneCheckPrVendor and ("Currency Code" <> '') and
                   ("Currency Code" <> Currency.Code)
                then begin
                    Currency.Get("Currency Code");
                    Currency.TestField("Conv. LCY Rndg. Debit Acc.");
                    Currency.TestField("Conv. LCY Rndg. Credit Acc.");
                end;

                //HEI.02>>
                MntLettres := '';
                if "Currency Code" = '' then
                    MontantEnTexte(MntLettres, Round(Abs(Amount), Perssion, '='))
                else
                    "Montant DEVISE"(MntLettres, Round(Abs(Amount), Perssion, '='), "Currency Code");
                //HEI.02<<

                MntLettres2 := CopyStr(MntLettres, 40 + STRPOS(CopyStr(MntLettres, 40), ' '));
                MntLettres := CopyStr(MntLettres, 1, 40 + STRPOS(CopyStr(MntLettres, 40), ' ') - 1);

                //HEI.01>>
                //IF BankAcc2."No." = '' THEN BEGIN
                //  BankAcc2."No." := GenJnlLine."HNK Bank Account";
                //END;
                //HEI.01<<

                if BankAccount3.Get(GenJnlLine."HNK Bank Account FND") then;

                if "Bank Payment Type" = "Bank Payment Type"::"Computer Check" then
                    TESTFIELD("Exported to Payment File", false);

                if not TestPrint then begin
                    if Amount = 0 then
                        CurrReport.Skip();

                    //HEI.01>>
                    //TESTFIELD("Bal. Account Type","Bal. Account Type"::"Bank Account");
                    //IF "Bal. Account No." <> BankAcc2."No." THEN
                    //CurrReport.Skip();
                    //HEI.01<<

                    if ("Account No." <> '') and ("Bal. Account No." <> '') then begin
                         // BC Upgrade MISHRS14 >> TO REMOVE WARNING OF IMPLICIT CONVERSION
                       if "Account Type" = "Account Type"::"G/L Account" then
                            BalancingType := BalancingType::"G/L Account"
                        else
                            if "Account Type" = "Account Type"::Customer then
                            BalancingType := BalancingType::Customer
                        else
                            if "Account Type" = "Account Type"::Vendor then
                            BalancingType := BalancingType::Vendor
                        else
                            if "Account Type" = "Account Type"::"Bank Account" then
                                BalancingType := BalancingType::"Bank Account";
                        // BC Upgrade MISHRS14 <<
                        BalancingNo := "Account No.";
                        //HEI.02>>
                        RemainingAmount := Amount - "WHT Amount FND";
                        //HEI.02<<
                        //HEI.02 RemainingAmount := Amount;
                        if OneCheckPrVendor then begin
                            ApplyMethod := ApplyMethod::MoreLinesOneEntry;
                            GenJnlLine2.Reset();
                            GenJnlLine2.SetCurrentKey(
                            "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                            GenJnlLine2.SetRange("Journal Template Name", "Journal Template Name");
                            GenJnlLine2.SetRange("Journal Batch Name", "Journal Batch Name");
                            GenJnlLine2.SetRange("Posting Date", "Posting Date");
                            GenJnlLine2.SetRange("Document No.", "Document No.");
                            GenJnlLine2.SetRange("Account Type", "Account Type");
                            GenJnlLine2.SetRange("Account No.", "Account No.");
                            GenJnlLine2.SetRange("Bal. Account Type", "Bal. Account Type");
                            GenJnlLine2.SetRange("Bal. Account No.", "Bal. Account No.");
                            GenJnlLine2.SetRange("Bank Payment Type", "Bank Payment Type");
                            GenJnlLine2.Find('-');
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
                            FieldError("Account No.", Text004)
                        else
                            FieldError("Bal. Account No.", Text004);

                    Clear(CheckToAddr);
                    Clear(SalesPurchPerson);
                    case BalancingType of
                        BalancingType::"G/L Account":
                            CheckToAddr[1] := Description;
                        BalancingType::Customer:
                            begin
                                Cust.Get(BalancingNo);
                                if Cust.Blocked = Cust.Blocked::All then
                                    Error(Text064, Cust.FieldCaption(Blocked), Cust.Blocked, Cust.TableCaption, Cust."No.");
                                Cust.Contact := '';
                                FormatAddr.Customer(CheckToAddr, Cust);
                                if BankAcc2."Currency Code" <> "Currency Code" then
                                    Error(Text005);
                                if Cust."Salesperson Code" <> '' then
                                    SalesPurchPerson.Get(Cust."Salesperson Code");
                            end;
                        BalancingType::Vendor:
                            begin
                                Vend.Get(BalancingNo);
                                //HEI.03>>
                                Vendor_Name_Concat := Vend.Name + ' ' + Vend."Name 2" + ' ' + Vend."Name 3 FND" + ' ' + Vend."Name 4 FND";
                                Vendor_Name_Concat := CopyStr(Vendor_Name_Concat, 1, 72);
                                LastSpacePos := FindLastSpace(CopyStr(Vendor_Name_Concat, 1, 36));
                                VendorName_1 := CopyStr(Vendor_Name_Concat, 1, LastSpacePos);
                                if 71 - LastSpacePos < 36 then
                                    VendorName_2 := CopyStr(Vendor_Name_Concat, LastSpacePos + 2, 71 - LastSpacePos)
                                else
                                    VendorName_2 := CopyStr(Vendor_Name_Concat, LastSpacePos + 2, 36);
                                Vendor_Name_Concat := VendorName_1 + ' ' + VendorName_2;
                                //HEI.03<<

                                if Vend.Blocked in [Vend.Blocked::All, Vend.Blocked::Payment] then
                                    Error(Text064, Vend.FieldCaption(Blocked), Vend.Blocked, Vend.TableCaption, Vend."No.");
                                Vend.Contact := '';
                                FormatAddr.Vendor(CheckToAddr, Vend);
                                if BankAcc2."Currency Code" <> "Currency Code" then
                                    Error(Text005);
                                if Vend."Purchaser Code" <> '' then
                                    SalesPurchPerson.Get(Vend."Purchaser Code");
                            end;
                        BalancingType::"Bank Account":
                            begin
                                BankAcc.Get(BalancingNo);
                                BankAcc.TestField(Blocked, false);
                                BankAcc.Contact := '';
                                FormatAddr.BankAcc(CheckToAddr, BankAcc);
                                if BankAcc2."Currency Code" <> BankAcc."Currency Code" then
                                    Error(Text008);
                                if BankAcc."Our Contact Code" <> '' then
                                    SalesPurchPerson.Get(BankAcc."Our Contact Code");
                            end;
                    end;

                    CheckDateText := Format("Posting Date", 0, 4);
                end else begin
                    if ChecksPrinted > 0 then
                        CurrReport.Break();
                    BalancingType := BalancingType::Vendor;
                    BalancingNo := Text010;
                    Clear(CheckToAddr);
                    for i := 1 to 5 do
                        CheckToAddr[i] := Text003;
                    Clear(SalesPurchPerson);
                    CheckNoText := Text011;
                    CheckDateText := Text012;
                end;
            end;

            trigger OnPreDataItem();
            begin
                Copy(VoidGenJnlLine);
                CompanyInfo.Get();
                if not TestPrint then begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    //HEI.01>>
                    //IF BankAcc2.Get(GenJnlLine."HNK Bank Account") THEN;
                    BankAcc2.Get(BankAcc2."No.");
                    BankAcc2.TestField(Blocked, false);
                    BankAcc2.CalcFields("Check Electronic Signature FND");
                    //HEI.04>>
                    //ShowBNS := BankAcc2."Check Payment Format" = BankAcc2."Check Payment Format"::"Bahamas BNS";
                    //ShowFCIB := BankAcc2."Check Payment Format" = BankAcc2."Check Payment Format"::"Bahamas FCIB";
                    //HEI.04<<
                    //HEI.01<<
                    Copy(VoidGenJnlLine);
                    SetRange("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                    SetRange("Check Printed", false);
                end else begin
                    Clear(CompanyAddr);
                    for i := 1 to 5 do
                        CompanyAddr[i] := Text003;
                end;
                ChecksPrinted := 0;

                SetRange("Account Type", "Account Type"::"Fixed Asset");
                if FIND('-') then
                    FieldError("Account Type");
                SetRange("Account Type");
                SetRange("Parent Line No. FND", 0); //HEI.01
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(BankAccount; BankAcc2."No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account';
                        TableRelation = "Bank Account";
                        ToolTip = 'Specifies the bank account that the printed checks will be drawn from.';

                        trigger OnValidate();
                        begin
                            InputBankAccount();
                        end;
                    }
                    field(LastCheckNo; UseCheckNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Last Check No.';
                        ToolTip = 'Specifies the value of the Last Check No. field on the bank account card.';
                    }
                    field(ReprintChecks; ReprintChecks)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Reprint Checks';
                        ToolTip = 'Specifies if checks are printed again if you canceled the printing due to a problem.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            //HEI.04>>
            grec_genJnlLn.Reset();
            grec_genJnlLn.SetRange(grec_genJnlLn."Journal Template Name", Format(VoidGenJnlLine.GetFilter("Journal Template Name")));
            grec_genJnlLn.SetRange(grec_genJnlLn."Journal Batch Name", Format(VoidGenJnlLine.GetFilter("Journal Batch Name")));
            if VoidGenJnlLine.GetFilter("Line No.") <> '' then begin
                Evaluate(ConvertLnIntgr, Format(VoidGenJnlLine.GetFilter("Line No.")));
                grec_genJnlLn.SetRange(grec_genJnlLn."Line No.", ConvertLnIntgr);
            end;
            if grec_genJnlLn.FindFirst() then
                BankAcc2.Validate("No.", grec_genJnlLn."HNK Bank Account FND");

            //BankAcc2."No." := GenJnlLine."HNK Bank Account";
            //HEI.04<<

            if BankAcc2."No." <> '' then
                if BankAcc2.Get(BankAcc2."No.") then
                    UseCheckNo := BankAcc2."Last Check No."
                else begin
                    BankAcc2."No." := '';
                    UseCheckNo := '';
                end;
        end;
    }

    labels
    {
        POBoxNoLbl = 'P.O. BOX'; PayToTheOrderOfLbl = 'Pay to the order of'; FirstCarrBankLbl = 'First Caribbean Int. Bank'; AddressLbl = '308 East Bay Street PO Box N 8329 Nassau'; NoLbl = '22606410'; PayDocLbl = 'Payment Document:'; ChequeDateLbl = 'Cheque Date:'; ChequeNoLbl = 'Cheque Number:'; ChequeAmtLbl = 'Cheque Amount:'; SignatureLbl = 'Signature:'; SignaturesLbl = 'Signatures'; label(LineNoLB; ENU = 'Line No',
                                                                                                                                                                                                                                                                                                                                                                                                           FRA = 'Line No')
        label(VendorNoLB; ENU = 'Vendor No',
                         FRA = 'Vendor No')
        label(VendorNameLB; ENU = 'Vendor Name',
                           FRA = 'NOM')
        label(VendorBankLB; ENU = 'Vendor Bank',
                           FRA = 'N° DE COMPTE BANCAIRE')
        label(VendorAddressLB; ENU = 'Address',
                              FRA = 'ADRESSE')
        label(InvoiceNoLB; ENU = 'Invoice No',
                          FRA = 'N° DES FACTURES')
        ExternalDocNoLB = 'External Doc No.'; label(AmountLB; ENU = 'Amount',
                                                            FRA = 'MONTANT')
        label(DeviseLB; ENU = 'Devise',
                       FRA = 'Devise')
        label(AmountLCYLB; ENU = 'Amount LCY',
                          FRA = 'MONTANT LCY')
        label(DueDateLB; ENU = 'Due Date',
                        FRA = 'DATE D''ECHEANCE')
        label(BankLB; ENU = 'Bank',
                     FRA = 'Banque')
        TotalLbl = 'Total by Vendor'; SignatureLB = 'Signature';
    }

    trigger OnInitReport();
    begin
        Perssion := 1; //HEI.02

        CompanyInfo.Get();
    end;

    trigger OnPreReport();
    begin
        InitTextVariable();

        /*GenJnlLine3.Reset();
        GenJnlLine3.SetRange("Journal Template Name",VoidGenJnlLine.GetFilter("Journal Template Name"));
        GenJnlLine3.SetRange("Journal Batch Name",VoidGenJnlLine.GetFilter("Journal Batch Name"));
        GenJnlLine3.SetRange("Parent Line No.",'=%1',0);
        IF GenJnlLine3.FindFirst() THEN
          REPEAT
            GenJnlLine3."Check Printed" := FALSE;
            GenJnlLine3.Modify();
            COMMIT;
          UNTIL GenJnlLine3.Next()= 0;*/

    end;

    var
        Text000: Label 'Preview is not allowed.';
        Text001: Label 'Last Check No. must be filled in.';
        Text002: Label 'Filters on %1 and %2 are not allowed.';
        Text003: Label 'XXXXXXXXXXXXXXXX';
        Text004: Label 'must be entered.';
        Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
        Text008: Label 'Both Bank Accounts must have the same currency.';
        Text010: Label 'XXXXXXXXXX';
        Text011: Label 'XXXX';
        Text012: Label 'XX.XXXXXXXXXX.XXXX';
        Text013: Label '%1 already exists.';
        Text014: Label 'Check for %1 %2';
        Text016: Label 'In the Check report, One Check per Vendor and Document No.\must not be activated when Applies-to ID is specified in the journal lines.';
        Text019: Label 'Total';
        Text020: Label 'The total amount of check %1 is %2. The amount must be positive.';
        Text021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        Text022: Label 'NON-NEGOTIABLE';
        Text023: Label 'Test print';
        Text024: Label 'XXXX.XX';
        Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text030: Label '" is already applied to %1 %2 for customer %3."';
        Text031: Label '" is already applied to %1 %2 for vendor %3."';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
        CompanyInfo: Record "Company Information";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
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
        GLSetup: Record "General Ledger Setup";
        FormatAddr: Codeunit "Format Address";
        CheckManagement: Codeunit CheckManagement;
        CompanyAddr: array[8] of Text[50];
        CheckToAddr: array[8] of Text[50];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        BalancingType: Option "G/L Account",Customer,Vendor,"Bank Account";
        BalancingNo: Code[20];
        CheckNoText: Text[50];
        CheckDateText: Text[30];
        CheckAmountText: Text[30];
        DescriptionLine: array[2] of Text[80];
        DocNo: Text[30];
        ExtDocNo: Text[35];
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
        Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
        CurrencyCode2: Code[10];
        NetAmount: Text[30];
        LineAmount2: Decimal;
        Text063: Label 'Net Amount %1';
        Text064: Label '%1 must not be %2 for %3 %4.';
        Text065: Label 'Subtotal';
        CheckNoTextCaptionLbl: Label 'Check No.';
        LineAmountCaptionLbl: Label 'Net Amount';
        LineDiscountCaptionLbl: Label 'Discount';
        AmountCaptionLbl: Label 'Amount';
        DocNoCaptionLbl: Label 'Document No.';
        DocDateCaptionLbl: Label 'Document Date';
        CurrencyCodeCaptionLbl: Label 'Currency Code';
        YourDocNoCaptionLbl: Label 'Your Doc. No.';
        TransportCaptionLbl: Label 'Transport';
        CountryRegion: Record "Country/Region";
        ShowBNS: Boolean;
        ShowFCIB: Boolean;
        CheckAmountText2: Text[50];
        CurrencyDescription: Text[50];
        BNSCurrencyDescription: Label 'BAHAMIAN DOLLARS';
        LineNo: Integer;
        Perssion: Decimal;
        PostedPurInv: Record "Purch. Inv. Header";
        AmountFormatStr: Text;
        entiere: Integer;
        decimal: Integer;
        nbre: Integer;
        nbre1: Integer;
        chaine1: Text[30];
        million: Text[250];
        mille: Text[250];
        cent: Text[250];
        MntLettres: Text[200];
        VarDeviseEntiere: Text[30];
        VarDeviseDecimal: Text[30];
        MntLettres2: Text[200];
        AmountLCY: Decimal;
        BankAccount3: Record "Bank Account";
        Vendor_Name_Concat: Text;
        VendorName_1: Text;
        VendorName_2: Text;
        LastSpacePos: Integer;
        grec_genJnlLn: Record "Gen. Journal Line";
        ConvertLnIntgr: Integer;

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
        Clear(NoText);
        NoTextIndex := 1;
        NoText[1] := '***';
        GLSetup.Get();

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
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
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
        AddToNoText(NoText, NoTextIndex, PrintExponent, (Format(No * DecimalPosition) + '/' + Format(DecimalPosition)));

        if CurrencyCode <> '' then
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30]);
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(Text029, AddText);
        end;

        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    local procedure CustUpdateAmounts(var CustLedgEntry2: Record "Cust. Ledger Entry"; RemainingAmount2: Decimal);
    begin
        if (ApplyMethod = ApplyMethod::OneLineOneEntry) or
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        then begin
            GenJnlLine3.Reset();
            GenJnlLine3.SetCurrentKey(
            "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SetRange("Account Type", GenJnlLine3."Account Type"::Customer);
            GenJnlLine3.SetRange("Account No.", CustLedgEntry2."Customer No.");
            GenJnlLine3.SetRange("Applies-to Doc. Type", CustLedgEntry2."Document Type");
            GenJnlLine3.SetRange("Applies-to Doc. No.", CustLedgEntry2."Document No.");
            if ApplyMethod = ApplyMethod::OneLineOneEntry then
                GenJnlLine3.SetFilter("Line No.", '<>%1', GenJnlLine."Line No.")
            else
                GenJnlLine3.SetFilter("Line No.", '<>%1', GenJnlLine2."Line No.");
            if CustLedgEntry2."Document Type" <> CustLedgEntry2."Document Type"::" " then
                if GenJnlLine3.Find('-') then
                    GenJnlLine3.FieldError(
                      "Applies-to Doc. No.",
                      StrSubstNo(
                        Text030,
                        CustLedgEntry2."Document Type", CustLedgEntry2."Document No.",
                        CustLedgEntry2."Customer No."));
        end;

        DocNo := CustLedgEntry2."Document No.";
        ExtDocNo := CustLedgEntry2."External Document No.";
        DocDate := CustLedgEntry2."Posting Date";
        CurrencyCode2 := CustLedgEntry2."Currency Code";

        CustLedgEntry2.CalcFields("Remaining Amount");

        LineAmount :=
          -ABSMin(
            CustLedgEntry2."Remaining Amount" -
            CustLedgEntry2."Remaining Pmt. Disc. Possible" -
            CustLedgEntry2."Accepted Payment Tolerance",
            CustLedgEntry2."Amount to Apply");
        LineAmount2 :=
          Round(
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
               Round(
                 -ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                   CustLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision")
            then
                LineAmount2 :=
                  Round(
                    -ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                      CustLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision")
            else begin
                LineAmount2 := RemainingAmount2;
                LineAmount :=
                  Round(
                    ExchangeAmt(CustLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                      LineAmount2), Currency."Amount Rounding Precision");
            end;
            LineDiscount := 0;
        end;
    end;

    local procedure VendUpdateAmounts(var VendLedgEntry2: Record "Vendor Ledger Entry"; RemainingAmount2: Decimal);
    begin
        if (ApplyMethod = ApplyMethod::OneLineOneEntry) or
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        then begin
            GenJnlLine3.Reset();
            GenJnlLine3.SetCurrentKey(
            "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SetRange("Account Type", GenJnlLine3."Account Type"::Vendor);
            GenJnlLine3.SetRange("Account No.", VendLedgEntry2."Vendor No.");
            GenJnlLine3.SetRange("Applies-to Doc. Type", VendLedgEntry2."Document Type");
            GenJnlLine3.SetRange("Applies-to Doc. No.", VendLedgEntry2."Document No.");
            if ApplyMethod = ApplyMethod::OneLineOneEntry then
                GenJnlLine3.SetFilter("Line No.", '<>%1', GenJnlLine."Line No.")
            else
                GenJnlLine3.SetFilter("Line No.", '<>%1', GenJnlLine2."Line No.");
            if VendLedgEntry2."Document Type" <> VendLedgEntry2."Document Type"::" " then
                if GenJnlLine3.Find('-') then
                    GenJnlLine3.FieldError(
                      "Applies-to Doc. No.",
                      StrSubstNo(
                        Text031,
                        VendLedgEntry2."Document Type", VendLedgEntry2."Document No.",
                        VendLedgEntry2."Vendor No."));
        end;

        DocNo := VendLedgEntry2."Document No.";
        ExtDocNo := VendLedgEntry2."External Document No.";
        DocDate := VendLedgEntry2."Posting Date";
        CurrencyCode2 := VendLedgEntry2."Currency Code";
        VendLedgEntry2.CalcFields("Remaining Amount");

        LineAmount :=
          -ABSMin(
            VendLedgEntry2."Remaining Amount" -
            VendLedgEntry2."Remaining Pmt. Disc. Possible" -
            VendLedgEntry2."Accepted Payment Tolerance",
            VendLedgEntry2."Amount to Apply");

        LineAmount2 :=
          Round(
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
            if Abs(RemainingAmount2) >=
               Abs(Round(
                   ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                     VendLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision"))
            then begin
                LineAmount2 :=
                  Round(
                    -ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                      VendLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision");
                LineAmount :=
                  Round(
                    ExchangeAmt(VendLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                      LineAmount2), Currency."Amount Rounding Precision");
            end else begin
                LineAmount2 := RemainingAmount2;
                LineAmount :=
                  Round(
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
            if BankAcc2.Get(BankAcc) then begin
                UseCheckNo := LastCheckNo;
                OneCheckPrVendor := NewOneCheckPrVend;
                ReprintChecks := NewReprintChecks;
                TestPrint := NewTestPrint;
                PreprintedStub := NewPreprintedStub;
            end;
    end;

    local procedure ExchangeAmt(PostingDate: Date; CurrencyCode: Code[10]; CurrencyCode2: Code[10]; Amount: Decimal) Amount2: Decimal;
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

    local procedure ABSMin(Decimal1: Decimal; Decimal2: Decimal): Decimal;
    begin
        if Abs(Decimal1) < Abs(Decimal2) then
            exit(Decimal1);
        exit(Decimal2);
    end;

    procedure InputBankAccount();
    begin
        if BankAcc2."No." <> '' then begin
            BankAcc2.Get(BankAcc2."No.");
            BankAcc2.TestField("Last Check No.");
            UseCheckNo := BankAcc2."Last Check No.";
        end;
    end;

    local procedure GetAmtDecimalPosition(): Decimal;
    var
        Currency: Record Currency;
    begin
        if GenJnlLine."Currency Code" = '' then
            Currency.InitRoundingPrecision
        else begin
            Currency.Get(GenJnlLine."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;
        exit(1 / Currency."Amount Rounding Precision");
    end;

    procedure MontantEnTexte(var strprix: Text[250]; prix: Decimal);
    var
        entiere: Decimal;
        decimal: Decimal;
        nbre: Decimal;
        million: Text;
        mille: Text;
        cent: Text;
        nbre1: Decimal;
    begin
        entiere := Round(prix, 1, '<');
        decimal := Round((prix - entiere) * 1000, 1, '<');

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
            strprix := strprix + ' FCFA ';
        if entiere = 1 then
            strprix := strprix + ' dinar';

        cent := '';
        if decimal <> 0 then begin
            Centaine(cent, decimal);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if decimal = 1 then
                strprix := strprix + ' millime'
            else
                strprix := strprix + ' millimes';
        end;

        strprix := UpperCase(strprix);
    end;

    procedure "Montant DEVISE"(var strprix: Text[250]; prix: Decimal; Devise: Code[20]);
    var
        Devisetext: Text[30];
    begin
        entiere := Round(prix, 1, '<');
        //decimal := Round((prix - entiere) * 1000,1,'<');
        decimal := Round((prix - entiere) * 100, 1, '<');
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
        if Devise = 'EUR' then
            Devisetext := 'EURO'
        else
            Devisetext := Format(Devise);
        QuelleDevise(Devisetext, 0);
        if entiere > 1 then
            strprix := strprix + ' ' + Devisetext;
        if entiere = 1 then
            strprix := strprix + ' ' + Devisetext + 'S';

        if decimal <> 0 then begin
            if strprix <> '' then
                strprix := strprix + ' ' + Format(decimal, 2)
            else
                strprix := strprix + Format(decimal, 2);
            if decimal = 1 then
                strprix := strprix + ' Centime'
            else
                strprix := strprix + ' Centimes';
        end;

        strprix := UpperCase(strprix);
    end;

    procedure Centaine(var chaine: Text[250]; i: Integer);
    var
        k: Integer;
    begin
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
    end;

    procedure Dizaine(var chaine: Text[250]; i: Integer);
    var
        k: Integer;
        l: Integer;
        chaine1: Text;
    begin
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
    end;

    procedure "Unité"(var chaine: Text[250]; i: Integer);
    var
        chaine1: Text;
    begin
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
    end;

    procedure MontantEnTexteSansMillimes(var strprix: Text[250]; prix: Decimal);
    var
        entiere: Decimal;
        decimal: Decimal;
        nbre: Decimal;
        million: Text;
        mille: Text;
        cent: Text;
        nbre1: Decimal;
    begin
        entiere := Round(prix, 1, '<');
        decimal := Round((prix - entiere) * 1000, 1, '<');

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
            strprix := strprix + ' FCFA ';
        if entiere = 1 then
            strprix := strprix + ' dinar';

        if decimal <> 0 then begin
            if strprix <> '' then
                strprix := strprix + ' ' + Format(decimal)
            else
                strprix := strprix + Format(decimal);
            if decimal = 1 then
                strprix := strprix + ' millime'
            else
                strprix := strprix + ' millimes';
        end;

        strprix := UpperCase(strprix);
    end;

    procedure QuelleDevise(var StrDevise: Text[30]; lng: Integer);
    begin

        if StrDevise = 'USD' then
            case lng of
                1033:
                    begin
                        VarDeviseEntiere := 'US Dollars';
                        VarDeviseDecimal := 'Cents';
                    end;
                else begin
                    VarDeviseEntiere := 'Dollars US';
                    VarDeviseDecimal := 'Cents';
                end;
            end;

        if StrDevise = 'EURO' then
            case lng of
                1033:
                    begin
                        VarDeviseEntiere := 'Euro';
                        VarDeviseDecimal := 'EuroCents';
                    end;
                else begin
                    VarDeviseEntiere := 'Euro';
                    VarDeviseDecimal := 'Centimes';
                end;
            end;

        if StrDevise = '£' then
            case lng of
                1033:
                    begin
                        VarDeviseEntiere := 'Pounds';
                        VarDeviseDecimal := 'Cents';
                    end;
                else begin
                    VarDeviseEntiere := 'Livres Sterling';
                    VarDeviseDecimal := 'Cents';
                end;
            end;
    end;

    local procedure FindLastSpace(String: Text[200]): Integer;
    var
        i: Integer;
    begin
        for i := 1 to StrLen(String) do begin
            if String[StrLen(String) + 1 - i] = ' ' then
                exit(StrLen(String) - i);
        end;
    end;
}

