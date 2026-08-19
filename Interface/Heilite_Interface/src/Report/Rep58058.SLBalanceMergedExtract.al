report 58058 "SL Balance Merged Extract"
{
    // version HEI.01

    // HEI.01 FDD-RTRGAP001 IBM CHAUHB01 18.09.2017
    //   # New Report to Extract SL Balance Merged

    // BC Upgrade KUMARS145 Nav ID report 50031 "SL Balance Merged Extract"

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "Cadency Value Buffer" to "Cadency Value Buffer FND".
    // BC UPGRADE PATELS08 <<

    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Customer Posting Group"; "Customer Posting Group")
        {
            DataItemTableView = SORTING(Code);

            trigger OnAfterGetRecord();
            begin
                TotalAmtLCY := 0;

                CLEAR(CLEntry);
                CLEntry.SETRANGE("Posting Date", PrevMonthFirstDay, PrevMonthLastDay);
                CLEntry.SETRANGE("Customer Posting Group", "Customer Posting Group".Code);
                if CLEntry.FINDSET() then
                    repeat
                        CLEntry.CALCFIELDS("Amount (LCY)");
                        TotalAmtLCY += CLEntry."Amount (LCY)";
                    until CLEntry.NEXT() = 0;

                if bufferTab.GET("Customer Posting Group"."Receivables Account") then begin
                    bufferTab.Amount += TotalAmtLCY;
                    bufferTab.MODIFY();
                end else begin
                    CLEAR(bufferTab);
                    bufferTab."G/L Account" := "Customer Posting Group"."Receivables Account";
                    bufferTab.Amount := TotalAmtLCY;
                    bufferTab.INSERT();
                end;
            end;
        }
        dataitem("Vendor Posting Group"; "Vendor Posting Group")
        {
            DataItemTableView = SORTING(Code);

            trigger OnAfterGetRecord();
            begin
                TotalAmtLCY := 0;

                CLEAR(VLEntry);
                VLEntry.SETRANGE("Posting Date", PrevMonthFirstDay, PrevMonthLastDay);
                VLEntry.SETRANGE("Vendor Posting Group", "Vendor Posting Group".Code);
                if VLEntry.FINDSET() then
                    repeat
                        VLEntry.CALCFIELDS("Amount (LCY)");
                        TotalAmtLCY += VLEntry."Amount (LCY)";
                    until VLEntry.NEXT() = 0;

                if bufferTab.GET("Vendor Posting Group"."Payables Account") then begin
                    bufferTab.Amount += TotalAmtLCY;
                    bufferTab.MODIFY();
                end else begin
                    CLEAR(bufferTab);
                    bufferTab."G/L Account" := "Vendor Posting Group"."Payables Account";
                    bufferTab.Amount := TotalAmtLCY;
                    bufferTab.INSERT();
                end;
            end;
        }
        dataitem("Inventory Posting Group"; "Inventory Posting Group")
        {
            DataItemTableView = SORTING(Code);
            dataitem("Inventory Posting Setup"; "Inventory Posting Setup")
            {
                DataItemLink = "Invt. Posting Group Code" = FIELD(Code);
                DataItemTableView = SORTING("Location Code", "Invt. Posting Group Code");
                dataitem(Item; Item)
                {
                    DataItemTableView = SORTING("Inventory Posting Group");

                    trigger OnAfterGetRecord();
                    begin
                        CLEAR(ValueEntry);
                        ValueEntry.SETCURRENTKEY("Item No.", "Document No.", "Posting Date", "Location Code");
                        ValueEntry.SETRANGE("Item No.", Item."No.");
                        ValueEntry.SETRANGE("Posting Date", PrevMonthFirstDay, PrevMonthLastDay);
                        ValueEntry.SETFILTER("Location Code", Item.GETFILTER("Location Filter"));

                        ValueEntry.CALCSUMS("Cost Amount (Actual)", "Cost Amount (Expected)");

                        if bufferTab.GET("Inventory Posting Setup"."Inventory Account") then begin
                            bufferTab.Amount += ValueEntry."Cost Amount (Actual)";
                            bufferTab.MODIFY();
                        end else begin
                            CLEAR(bufferTab);
                            bufferTab."G/L Account" := "Inventory Posting Setup"."Inventory Account";
                            bufferTab.Amount := ValueEntry."Cost Amount (Actual)";
                            bufferTab.INSERT();
                        end;

                        if bufferTab.GET("Inventory Posting Setup"."Inventory Account (Interim)") then begin
                            bufferTab.Amount += ValueEntry."Cost Amount (Expected)";
                            bufferTab.MODIFY();
                        end else begin
                            CLEAR(bufferTab);
                            bufferTab."G/L Account" := "Inventory Posting Setup"."Inventory Account (Interim)";
                            bufferTab.Amount := ValueEntry."Cost Amount (Expected)";
                            bufferTab.INSERT();
                        end;
                    end;

                    trigger OnPreDataItem();
                    begin
                        Item.SETRANGE("Inventory Posting Group", "Inventory Posting Setup"."Invt. Posting Group Code");
                        Item.SETRANGE("Location Filter", "Inventory Posting Setup"."Location Code");
                    end;
                }
            }
        }
        dataitem("FA Posting Group"; "FA Posting Group")
        {
            DataItemTableView = SORTING(Code) ORDER(Ascending);

            trigger OnAfterGetRecord();
            var
                DepreciationBook: Record "Depreciation Book";
            begin
                DepreciationBook.RESET();
                if DepreciationBook.FINDFIRST() then begin
                    repeat
                        if DepreciationBook."G/L Integration - Acq. Cost" then begin

                            CLEAR(FALedgerEntry);
                            FALedgerEntry.SETRANGE("FA Posting Group", "FA Posting Group".Code);
                            FALedgerEntry.SETRANGE("Posting Date", PrevMonthFirstDay, PrevMonthLastDay);
                            FALedgerEntry.SETRANGE("Depreciation Book Code", DepreciationBook.Code);
                            FALedgerEntry.SETRANGE("FA Posting Type", FALedgerEntry."FA Posting Type"::"Acquisition Cost");
                            FALedgerEntry.CALCSUMS("Amount (LCY)");

                            if bufferTab.GET("FA Posting Group"."Acquisition Cost Account") then begin
                                bufferTab.Amount += FALedgerEntry."Amount (LCY)";
                                bufferTab.MODIFY();
                            end else begin
                                CLEAR(bufferTab);
                                bufferTab."G/L Account" := "FA Posting Group"."Acquisition Cost Account";
                                bufferTab.Amount := FALedgerEntry."Amount (LCY)";
                                bufferTab.INSERT();
                            end;
                        end;
                        if DepreciationBook."G/L Integration - Depreciation" then begin
                            FALedgerEntry.SETRANGE("FA Posting Type", FALedgerEntry."FA Posting Type"::Depreciation);
                            FALedgerEntry.SETRANGE("Depreciation Book Code", DepreciationBook.Code);
                            FALedgerEntry.CALCSUMS("Amount (LCY)");

                            if bufferTab.GET("FA Posting Group"."Accum. Depreciation Account") then begin
                                bufferTab.Amount += FALedgerEntry."Amount (LCY)";
                                bufferTab.MODIFY();
                            end else begin
                                CLEAR(bufferTab);
                                bufferTab."G/L Account" := "FA Posting Group"."Accum. Depreciation Account";
                                bufferTab.Amount := FALedgerEntry."Amount (LCY)";
                                bufferTab.INSERT();
                            end;
                        end;
                    until DepreciationBook.NEXT() = 0;
                end;
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
                        ApplicationArea = ALL;
                        Caption = 'Period';
                        ToolTip = 'Select the period for which the data will be extracted. Period-1 is last month, Period-2 is month before last.';
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
        //CurrReport.USEREQUESTPAGE := GUIALLOWED ;

        CompanyInfo.GET();
        GLSetup.GET();
        CompanyInfo.TESTFIELD("Legal Entity Code FND");
        GLSetup.TESTFIELD("Cadency Temporary Path FND");
        TAB := 9;
    end;

    trigger OnPostReport();
    begin
        bufferTab.SETCURRENTKEY(bufferTab."G/L Account");
        if bufferTab.FIND('-') then
            repeat
                if GLAccount.GET(bufferTab."G/L Account") and (bufferTab."G/L Account" <> '') and (not ((bufferTab.Amount = 0) and (GLAccount.Blocked = true))) then begin

                    FileRecord := COPYSTR(DELCHR(CompanyInfo."Legal Entity Code FND", '=', '!|@|#|$|%/,_- '), 1, 10) + FORMAT(TAB);
                    FileRecord += COPYSTR(DELCHR(bufferTab."G/L Account", '=', '!|@|#|$|%/,_-'), 1, 8) + FORMAT(TAB);
                    FileRecord += COPYSTR(DELCHR(GLAccount.Name, '=', '!|@|#|$|%/_-,'), 1, 50) + FORMAT(TAB);
                    FileRecord += COPYSTR('EUR', 1, 5) + FORMAT(TAB);
                    FileRecord += COPYSTR('0.00', 1, 5) + FORMAT(TAB);
                    FileRecord += COPYSTR(GLSetup."LCY Code", 1, 5) + FORMAT(TAB);
                    FileRecord += COPYSTR(DELCHR(FORMAT(bufferTab.Amount), '=', ','), 1, 20) + FORMAT(TAB);
                    FileRecord += COPYSTR(FORMAT(DATE2DMY(PrevMonthLastDay, 2)), 1, 2) + FORMAT(TAB);
                    FileRecord += COPYSTR(FORMAT(DATE2DMY(PrevMonthLastDay, 3)), 1, 4) + FORMAT(TAB);
                    // BC Upgrade KUMARS145 Changed the Module and File handling to use TempBlob and TextBuilder...>>
                    // FleCIL1.WRITE(FileRecord);
                    TextBuilderVar.AppendLine(FileRecord);
                    // BC Upgrade KUMARS145 Changed the Module and File handling to use TempBlob and TextBuilder...>>

                    Cnt += 1;
                    TotalAmt += bufferTab.Amount;
                end;
            until bufferTab.NEXT() = 0;

        //<< Footer
        // BC Upgrade KUMARS145 Changed the Module and File handling to use TempBlob and TextBuilder...>>
        // FleCIL1.WRITE('FOOTER' + FORMAT(TAB) + FORMAT(Cnt) + FORMAT(TAB) + DELCHR(FORMAT(TotalAmt), '=', '!|@|#|$|%/,'));
        // FleCIL1.CLOSE;
        TextBuilderVar.AppendLine('FOOTER' + FORMAT(TAB) + FORMAT(Cnt) + FORMAT(TAB) + DELCHR(FORMAT(TotalAmt), '=', '!|@|#|$|%/,'));

        tmpBlob.CreateOutStream(OutStr, TextEncoding::Windows);
        OutStr.WriteText(TextBuilderVar.ToText());
        tmpBlob.CreateInStream(InStr, TextEncoding::Windows);
        DownloadFromStream(InStr, '', '', '', FileName);
        // BC Upgrade KUMARS145 Changed the Module and File handling to use TempBlob and TextBuilder...>>


        if GUIALLOWED then
            MESSAGE(Text014);
    end;

    trigger OnPreReport();
    begin
        bufferTab.DELETEALL();
        Cnt := 0;
        if GLOBALLANGUAGE <> 1036 then begin
            if Period = Period::"Period-1" then begin
                PreviousMonth := CALCDATE('<-1M>', WORKDATE());
                PrevMonthLastDay := CALCDATE('<CM>', PreviousMonth);
            end else begin
                PreviousMonth := CALCDATE('<-2M>', WORKDATE());
                PrevMonthLastDay := CALCDATE('<CM>', PreviousMonth);
            end;
        end else begin
            if Period = Period::"Period-1" then begin
                PreviousMonth := CALCDATE('<-1M>', WORKDATE());
                PrevMonthLastDay := CALCDATE('<FM>', PreviousMonth);
            end else begin
                PreviousMonth := CALCDATE('<-2M>', WORKDATE());
                PrevMonthLastDay := CALCDATE('<FM>', PreviousMonth);
            end;

        end;
        PrevMonthFirstDay := 0D;  //start date always open

        CompName := COPYSTR(DELCHR(CompanyInfo."Legal Entity Code FND", '=', '!|@|#|$|%/.,_- '), 1, 15);
        FileName := GLSetup."Cadency Temporary Path FND" + FilePath + CompName + '_' + DELCHR(FORMAT(PrevMonthLastDay, 0, '<Month,2><Day,2><Year4>'), '=', '/-') + '.txt';

        // BC Upgrade KUMARS145 Changed the Module and File handling to use TempBlob and TextBuilder...>>
        // CLEAR(FleCIL1);

        // FleCIL1.CREATE(FileName);
        // FleCIL1.TEXTMODE(true);

        // //Header in Txt file
        // FleCIL1.WRITE(Text001 + FORMAT(TAB) + Text002 + FORMAT(TAB) + Text003 + FORMAT(TAB) + Text004 + FORMAT(TAB) + Text005 + FORMAT(TAB) + Text006 + FORMAT(TAB) + Text007 + FORMAT(TAB) + Text008 + FORMAT(TAB) + Text009);

        TextBuilderVar.AppendLine(Text001 + FORMAT(TAB) + Text002 + FORMAT(TAB) + Text003 + FORMAT(TAB) + Text004 + FORMAT(TAB) + Text005 + FORMAT(TAB) + Text006 + FORMAT(TAB) + Text007 + FORMAT(TAB) + Text008 + FORMAT(TAB) + Text009);

        // BC Upgrade KUMARS145 Changed the Module and File handling to use TempBlob and TextBuilder...>>
    end;

    var
        GLAccount: Record "G/L Account";
        FileRecord: Text[1024];
        CompanyInfo: Record "Company Information";
        FleCIL1: File;
        FromFile: Text[1024];
        GLSetup: Record "General Ledger Setup";
        Cnt: Integer;
        FileName: Text[1024];
        CompName: Text;
        PrevMonthLastDay: Date;
        PrevMonthFirstDay: Date;
        FilePath: Label 'SLBAL_';
        Text001: Label 'Company';
        Text002: Label 'G/L Account No.';
        Text003: Label 'G/L Account Name';
        Text004: Label 'CCY1Code';
        Text005: Label 'CCY1SubLedger';
        Text006: Label 'CCY2Code';
        Text007: Label 'CCY2SubLedger';
        Text008: Label 'Period';
        Text009: Label 'Year';
        Text014: Label 'File exported successfully';
        bufferTab: Record "Cadency Value Buffer FND" temporary;
        TotalAmt: Decimal;
        TAB: Char;
        Period: Option "Period-1","Period-2";
        ValueEntry: Record "Value Entry";
        GLEntry: Record "G/L Entry";
        CLEntry: Record "Cust. Ledger Entry";
        VLEntry: Record "Vendor Ledger Entry";
        TotalAmtLCY: Decimal;
        PreviousMonth: Date;
        FALedgerEntry: Record "FA Ledger Entry";
        // BC Upgrade KUMARS145...>>
        InStr: InStream;
        OutStr: OutStream;
        tmpBlob: Codeunit "Temp Blob";
        TextBuilderVar: TextBuilder;
    // BC Upgrade KUMARS145...<<
}

