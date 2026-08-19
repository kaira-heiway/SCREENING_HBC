report 55037 "GL Balance Extract"
{
    // version HEI.01

    // HEI.01 FDD-RTRGAP001 IBM CHAUHB01 18.09.2017
    //   # New Report to Extract GL Balance

    // BC Upgrade KUMARS145 Nav ID Report 50030 "GL Balance Extract" 

    Permissions = TableData "G/L Account" = rimd, TableData "G/L Entry" = rimd;
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = all;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            CalcFields = "Balance at Date", "Credit Amount", "Debit Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
            DataItemTableView = WHERE("Account Type" = CONST(Posting), "Income/Balance" = FILTER("Balance Sheet"), Blocked = CONST(false));

            trigger OnAfterGetRecord();
            begin
                CreditAmtLocalCurr := 0;
                DebitAmtLocalCurr := 0;
                CreditAmtReportCurr := 0;
                DebitAmtReportCurr := 0;
                Cnt := 0;
                Cnt1 := 0;

                FileRecord := COPYSTR(DELCHR(CompanyInfo."Legal Entity Code FND", '=', '!|@|#|$|%/,_-. '), 1, 15) + FORMAT(TAB);
                FileRecord += COPYSTR(DELCHR("G/L Account"."No.", '=', '!|@|#|$|%/,_-'), 1, 8) + FORMAT(TAB);
                FileRecord += COPYSTR(DELCHR("G/L Account".Name, '=', '!|@|#|$|%/,_-'), 1, 50) + FORMAT(TAB);
                FileRecord += 'EUR' + FORMAT(TAB);
                FileRecord += '0.00' + FORMAT(TAB);
                FileRecord += COPYSTR(GenLegSetup."LCY Code", 1, 5) + FORMAT(TAB);
                FileRecord += COPYSTR(DELCHR(FORMAT("G/L Account"."Balance at Date"), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB);

                GLEntry.Reset();
                GLEntry.SETRANGE(GLEntry."G/L Account No.", "No.");
                GLEntry.SETRANGE(GLEntry."Posting Date", StartDate, EndDate);
                if GLEntry.FindSet() then
                    repeat
                        CreditAmtLocalCurr += GLEntry."Credit Amount";
                        DebitAmtLocalCurr += GLEntry."Debit Amount";
                        CreditAmtReportCurr += GLEntry."Add.-Currency Credit Amount";
                        DebitAmtReportCurr += GLEntry."Add.-Currency Debit Amount";
                        CCY3Amt1 += GLEntry.Amount;
                        CurrCode1 := GLEntry."Currency Code FND";
                        Cnt += 1;
                    until GLEntry.Next() = 0;

                BnkAccLedEntry.Reset();
                BnkAccLedEntry.SETRANGE(BnkAccLedEntry."Entry No.", GLEntry."Entry No.");
                BnkAccLedEntry.SETRANGE(BnkAccLedEntry."Posting Date", StartDate, EndDate);
                if BnkAccLedEntry.FindSet() then
                    repeat
                        BLECredit += BnkAccLedEntry."Credit Amount";
                        BLEDebit += BnkAccLedEntry."Debit Amount";
                        CCY3Amt2 += BnkAccLedEntry.Amount;
                        CurrCode2 := BnkAccLedEntry."Currency Code";
                        Cnt1 += 1;
                    until BnkAccLedEntry.Next() = 0;

                // CCY3Code
                if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::" " then
                    FileRecord += '' + FORMAT(TAB)
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"Bank Ledger Entry" then
                    FileRecord += COPYSTR(DELCHR(FORMAT(CurrCode2), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB)
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"G/L Entry" then
                    FileRecord += COPYSTR(DELCHR(FORMAT(CurrCode1), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB);


                // CCY3GLEndBalance
                if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::" " then
                    FileRecord += '' + FORMAT(TAB)
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"Bank Ledger Entry" then
                    FileRecord += COPYSTR(DELCHR(FORMAT(CCY3Amt2), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB)
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"G/L Entry" then
                    FileRecord += COPYSTR(DELCHR(FORMAT(CCY3Amt1), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB);

                FileRecord += COPYSTR(FORMAT(DATE2DMY(EndDate, 2)), 1, 2) + FORMAT(TAB);
                FileRecord += COPYSTR(FORMAT(DATE2DMY(EndDate, 3)), 1, 4) + FORMAT(TAB);


                FileRecord += COPYSTR(DELCHR(FORMAT(DebitAmtReportCurr), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB);  // CCY1NetDebits
                FileRecord += COPYSTR(DELCHR(FORMAT(DebitAmtLocalCurr), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB);   // CCY2NetDebits

                // CCY3 NetDebits
                if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::" " then
                    FileRecord += '0.00' + FORMAT(TAB)
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"Bank Ledger Entry" then
                    FileRecord += COPYSTR(DELCHR(FORMAT(BLEDebit), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB)
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"G/L Entry" then
                    FileRecord += COPYSTR(DELCHR(FORMAT(DebitAmtLocalCurr), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB);

                FileRecord += COPYSTR(DELCHR(FORMAT(CreditAmtReportCurr), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB); // CCY1NetCredits
                FileRecord += COPYSTR(DELCHR(FORMAT(CreditAmtLocalCurr), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB);  // CCY2NetCredits

                //  CCY3 NetCredits
                if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::" " then
                    FileRecord += '0.00' + FORMAT(TAB)
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"Bank Ledger Entry" then
                    FileRecord += COPYSTR(DELCHR(FORMAT(BLECredit), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB)
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"G/L Entry" then
                    FileRecord += COPYSTR(DELCHR(FORMAT(CreditAmtLocalCurr), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB);

                FileRecord += FORMAT(Cnt) + FORMAT(TAB);  //CCY1TransCount
                FileRecord += FORMAT(Cnt) + FORMAT(TAB);  //CCY2TransCount
                FileRecord += FORMAT(Cnt1);  //CCY3TransCount

                // BC Upgrade KUMARS145 old code block replaced with new onw ....>>
                // FleCIL1.WRITE(FileRecord);
                TextBuilderVar.AppendLine(FileRecord);
                // BC Upgrade KUMARS145 old code block replaced with new onw ....<<
            end;

            trigger OnPostDataItem();
            begin
                // BC Upgrade KUMARS145 old code block replaced with new onw ....>>
                // FleCIL1.CLOSE;

                tmpBlob.CreateOutStream(OutStr, TextEncoding::Windows);
                OutStr.WriteText(TextBuilderVar.ToText());
                tmpBlob.CreateInStream(InStr, TextEncoding::Windows);
                DownloadFromStream(InStr, '', '', '', FileName);
                // BC Upgrade KUMARS145 old code block replaced with new onw ....<<
            end;

            trigger OnPreDataItem();
            begin
                "G/L Account".SETFILTER("No.", '<%1', '79000000');

                "G/L Account".SETRANGE("G/L Account"."Date Filter", StartDate, EndDate);
                FileName := GenLegSetup."Cadency Temporary Path FND" + FilePath + COPYSTR(DELCHR(CompanyInfo."Legal Entity Code FND", '=', '!|@|#|$|%/,_-. '), 1, 15) + '_' + DELCHR(FORMAT(EndDate, 0, '<Month,2><Day,2><Year4>'), '=', '/-') + '.txt';

                // BC Upgrade KUMARS145 old code block replaced with new onw ....>>
                // CLEAR(FleCIL1);
                // FleCIL1.CREATE(FileName);
                // FleCIL1.TEXTMODE(true);
                // //Header in Txt file
                // FleCIL1.WRITE(Text001 + FORMAT(TAB) + Text002 + FORMAT(TAB) + Text003 + FORMAT(TAB) + Text004 + FORMAT(TAB) + Text005 + FORMAT(TAB) + Text006 + FORMAT(TAB) + Text007 + FORMAT(TAB) + Text020 + FORMAT(TAB) + Text021 + FORMAT(TAB) + Text008 + FORMAT(TAB) + Text009 + FORMAT(TAB) + Text010 + FORMAT(TAB) + Text011 + FORMAT(TAB) + Text012 + FORMAT(TAB) + Text013 + FORMAT(TAB) + Text014 + FORMAT(TAB) + Text015 + FORMAT(TAB) + Text016 + FORMAT(TAB) + Text017 + FORMAT(TAB) + Text018);

                TextBuilderVar.AppendLine(Text001 + FORMAT(TAB) + Text002 + FORMAT(TAB) + Text003 + FORMAT(TAB) + Text004 + FORMAT(TAB) + Text005 + FORMAT(TAB) + Text006 + FORMAT(TAB) + Text007 + FORMAT(TAB) + Text020 + FORMAT(TAB) + Text021 + FORMAT(TAB) + Text008 + FORMAT(TAB) + Text009 + FORMAT(TAB) + Text010 + FORMAT(TAB) + Text011 + FORMAT(TAB) + Text012 + FORMAT(TAB) + Text013 + FORMAT(TAB) + Text014 + FORMAT(TAB) + Text015 + FORMAT(TAB) + Text016 + FORMAT(TAB) + Text017 + FORMAT(TAB) + Text018);
                // BC Upgrade KUMARS145 old code block replaced with new onw ....<<
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1100710001)
                {
                    field(Period; Period)
                    {
                        ApplicationArea = all;
                        Caption = 'Period';
                        ToolTip = 'Specify the Period';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        CompanyInfo.GET();
        GenLegSetup.GET();

        CompanyInfo.TESTFIELD("Legal Entity Code FND");
        GenLegSetup.TESTFIELD("Cadency Temporary Path FND");
        TAB := 9;
    end;

    trigger OnPostReport();
    begin
        if GUIALLOWED then
            MESSAGE(Text019);
    end;

    trigger OnPreReport();
    begin
        if GLOBALLANGUAGE <> 1036 then begin
            if Period = Period::"Period-1" then begin
                PreviouMonth := CalcDate('<-1M>', WorkDate());
                StartDate := CalcDate('<-CM>', PreviouMonth);
                EndDate := CalcDate('<CM>', PreviouMonth);
            end else begin
                PreviouMonth := CalcDate('<-2M>', WorkDate());
                StartDate := CalcDate('<-CM>', PreviouMonth);
                EndDate := CalcDate('<CM>', PreviouMonth);
            end;
        end else begin
            if Period = Period::"Period-1" then begin
                PreviouMonth := CalcDate('<-1M>', WorkDate());
                StartDate := CalcDate('<-FM>', PreviouMonth);
                EndDate := CalcDate('<FM>', PreviouMonth);
            end else begin
                PreviouMonth := CalcDate('<-2M>', WorkDate());
                StartDate := CalcDate('<-FM>', PreviouMonth);
                EndDate := CalcDate('<FM>', PreviouMonth);
            end;
        end;
    end;

    var
        GLEntry: Record "G/L Entry";
        FileRecord: Text[1024];
        CommonDialogMgt: Codeunit "File Management";
        CompanyInfo: Record "Company Information";
        FleCIL1: File;
        FromFile: Text[1024];
        GenLegSetup: Record "General Ledger Setup";
        Cnt: Integer;
        FilePath: Label 'GLBAL_';
        OutStreamObj: OutStream;
        Delimeter: Label ',';
        FileName: Text[1024];
        Text001: Label 'CompanyName';
        Text002: Label 'G/LAccountNo.';
        Text003: Label 'G/LName';
        Text004: Label 'CCY1Code';
        Text005: Label 'CCY1GLEndBalance';
        Text006: Label 'CCY2Code';
        Text007: Label 'CCY2GLEndBalance';
        Text020: Label 'CCY3Code';
        Text021: Label 'CCY3GLEndBalance';
        Text008: Label 'Period';
        Text009: Label 'Year';
        Text010: Label 'CCY1NetDebits';
        Text011: Label 'CCY2NetDebits';
        Text012: Label 'CCY3NetDebits';
        Text013: Label 'CCY1NetCredits';
        Text014: Label 'CCY2NetCredits';
        TotalAmt: Decimal;
        PostDate: Text;
        MonthBefore: Date;
        CreditAmtLocalCurr: Decimal;
        DebitAmtLocalCurr: Decimal;
        Text015: Label 'CCY3NetCredits';
        Text016: Label 'CCY1TransCount';
        Text017: Label 'CCY2TransCount';
        CreditAmtReportCurr: Decimal;
        DebitAmtReportCurr: Decimal;
        Period: Option "Period-1","Period-2";
        StartDate: Date;
        EndDate: Date;
        Lastyear: Date;
        BnkAccLedEntry: Record "Bank Account Ledger Entry";
        BLECredit: Decimal;
        BLEDebit: Decimal;
        Cnt1: Integer;
        Text018: Label 'CCY3TransCount';
        Text019: Label 'File exported successfully';
        CCY3Amt1: Decimal;
        CCY3Amt2: Decimal;
        CurrCode1: Code[20];
        CurrCode2: Code[20];
        TAB: Char;
        PreviouMonth: Date;
        // BC Upgrade KUMARS145...>>
        InStr: InStream;
        OutStr: OutStream;
        tmpBlob: Codeunit "Temp Blob";
        TextBuilderVar: TextBuilder;
    // BC Upgrade KUMARS145...<<
}

