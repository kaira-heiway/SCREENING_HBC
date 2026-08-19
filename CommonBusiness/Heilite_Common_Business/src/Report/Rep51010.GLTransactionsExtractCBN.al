report 51010 "GL Transactions Extract CBN"
{
    // version HEI.01

    // HEI.01 FDD-RTRGAP001 IBM CHAUHB01 19.09.2017
    //   # New Report to Extract GL Transaction

    // BC Upgrade KUMARS145 Nav ID Report 50029 "GL Transactions Extract" 

    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = all;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = WHERE("Cadency Transaction Export FND" = FILTER(true), "Income/Balance" = CONST("Balance Sheet"));

            trigger OnAfterGetRecord();
            begin
                GLEntry.Reset();
                GLEntry.SetRange(GLEntry."G/L Account No.", "No.");
                GLEntry.SetRange(GLEntry."Posting Date", StartDate, EndDate);

                GLEntry.SetRange(GLEntry."Open FND", true);
                if GLEntry.FindSet() then
                    repeat

                        FileRecord := CopyStr(DELCHR(CompanyInfo."Legal Entity Code FND", '=', '!|@|#|$|%/,_- '), 1, 10) + FORMAT(TAB);
                        FileRecord += CopyStr(DELCHR(GLEntry."G/L Account No.", '=', '!|@|#|$|%/,_- '), 1, 8) + FORMAT(TAB);

                        FileRecord += CopyStr(Mnt + '/' + Day + '/' + Yr, 1, 10) + FORMAT(TAB);

                        if GLEntry."Posting Date" <> 0D then
                            FileRecord += CopyStr(FORMAT(GLEntry."Posting Date"), 1, 10) + FORMAT(TAB)
                        else
                            FileRecord += '' + FORMAT(TAB);

                        FileRecord += CopyStr(GenLegSetup."LCY Code", 1, 5) + FORMAT(TAB);
                        FileRecord += CopyStr(DELCHR(FORMAT(GLEntry."Remaining Amount FND"), '=', '!|@|#|$|%/,'), 1, 20) + FORMAT(TAB);

                        if GLEntry."Document No." <> '' then
                            FileRecord += CopyStr(GLEntry."Document No.", 1, 20) + FORMAT(TAB)
                        else
                            FileRecord += '' + FORMAT(TAB);

                        if GLEntry.Description <> '' then
                            FileRecord += CopyStr(DELCHR(FORMAT(GLEntry.Description), '=', '!|@|#|$|%/,_-'), 1, 50) + FORMAT(TAB)
                        else
                            FileRecord += '' + FORMAT(TAB);

                        if GLEntry."Document Type" <> GLEntry."Document Type"::" " then
                            FileRecord += CopyStr(FORMAT(GLEntry."Document Type"), 1, 20) + FORMAT(TAB)
                        else
                            FileRecord += '' + FORMAT(TAB);

                        if GLEntry."External Document No." <> '' then
                            FileRecord += CopyStr(GLEntry."External Document No.", 1, 20) + FORMAT(TAB)
                        else
                            FileRecord += '' + FORMAT(TAB);

                        if GLEntry."Source No." <> '' then
                            FileRecord += CopyStr(GLEntry."Source No.", 1, 25) + FORMAT(TAB)
                        else
                            FileRecord += '' + FORMAT(TAB);

                        if GLEntry."User ID" <> '' then
                            FileRecord += CopyStr(FORMAT(GLEntry."User ID"), 1, 25)
                        else begin
                            GLRegister.SETFILTER(GLRegister."From Entry No.", '<%1', GLEntry."Entry No.");
                            GLRegister.SETFILTER(GLRegister."To Entry No.", '>%1', GLEntry."Entry No.");
                            if GLRegister.FindSet() then
                                FileRecord += CopyStr(FORMAT(GLRegister."User ID"), 1, 25);
                        end;

                        Cnt += 1;
                        TotalAmt += GLEntry."Remaining Amount FND";
                        // BC Upgrade KUMARS145 old function replaced with new one....>>
                        // FleCIL1.WRITE(FileRecord);
                        TextBuilderVar.AppendLine(FileRecord);
                    // BC Upgrade KUMARS145 old function replaced with new one....>>

                    until GLEntry.Next() = 0;
            end;

            trigger OnPostDataItem();
            begin
                //<< Footer
                // BC Upgrade KUMARS145 old function replaced with new one....>>
                // FleCIL1.WRITE(Text013 + FORMAT(TAB) + FORMAT(Cnt) + FORMAT(TAB) + DELCHR(FORMAT(TotalAmt), '=', '!|@|#|$|%/,'));
                TextBuilderVar.AppendLine(Text013 + FORMAT(TAB) + FORMAT(Cnt) + FORMAT(TAB) + DELCHR(FORMAT(TotalAmt), '=', '!|@|#|$|%/,'));
                // FleCIL1.CLOSE;

                tmpBlob.CreateOutStream(OutStr, TextEncoding::Windows);
                OutStr.WriteText(TextBuilderVar.ToText());
                tmpBlob.CreateInStream(InStr, TextEncoding::Windows);
                DownloadFromStream(InStr, '', '', '', FileName);
                // BC Upgrade KUMARS145 old function replaced with new one....>>
            end;

            trigger OnPreDataItem();
            begin
                FileName := GenLegSetup."Cadency Temporary Path FND" + FilePath + CopyStr(DELCHR(CompanyInfo."Legal Entity Code FND", '=', '!|@|#|$|%/,_- '), 1, 10) + '_' + DELCHR(FORMAT(EndDate, 0, '<Month,2><Day,2><Year4>'), '=', '/-') + '.txt';
                // BC Upgrade KUMARS145 old code block replaced with new onw ....>>
                // CLEAR(FleCIL1);
                // FleCIL1.CREATE(FileName);
                // FleCIL1.TEXTMODE(true);
                // //<< Header in Txt file
                // FleCIL1.WRITE(Text001 + FORMAT(TAB) + Text002 + FORMAT(TAB) + Text003 + FORMAT(TAB) + Text004 + FORMAT(TAB) + Text005 + FORMAT(TAB) + Text006 + FORMAT(TAB) + Text007 + FORMAT(TAB) + Text008 + FORMAT(TAB) + Text009 + FORMAT(TAB) + Text010 + FORMAT(TAB) + Text011 + FORMAT(TAB) + Text012);
                TextBuilderVar.AppendLine(Text001 + FORMAT(TAB) + Text002 + FORMAT(TAB) + Text003 + FORMAT(TAB) + Text004 + FORMAT(TAB) + Text005 + FORMAT(TAB) + Text006 + FORMAT(TAB) + Text007 + FORMAT(TAB) + Text008 + FORMAT(TAB) + Text009 + FORMAT(TAB) + Text010 + FORMAT(TAB) + Text011 + FORMAT(TAB) + Text012);

                // //<< Creating a Batch ID

                // FleCIL1.WRITE(CopyStr(DELCHR(CompanyInfo."Legal Entity Code", '=', '!|@|#|$|%/.,_- '), 1, 8) + Day + Mnt + Yr);
                TextBuilderVar.AppendLine(CopyStr(DELCHR(CompanyInfo."Legal Entity Code FND", '=', '!|@|#|$|%/.,_- '), 1, 8) + Day + Mnt + Yr);

                // BC Upgrade KUMARS145 old code block replaced with new onw ....>>
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
                    field(OpenPeriod; OpenPeriod)
                    {
                        ApplicationArea = all;
                        Caption = 'Open Start Date';
                        ToolTip = 'Specify the Open Start Date';
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
        CurrReport.USEREQUESTPAGE := GUIALLOWED;

        CompanyInfo.GET();
        GenLegSetup.GET();
        CompanyInfo.TESTFIELD("Legal Entity Code FND");
        GenLegSetup.TESTFIELD("Cadency Temporary Path FND");
        TAB := 9;
    end;

    trigger OnPostReport();
    begin
        if GUIALLOWED then
            MESSAGE(Text014);
    end;

    trigger OnPreReport();
    begin
        if GLOBALLANGUAGE <> 1036 then begin
            if OpenPeriod then begin
                StartDate := 0D;
                PreviouMonth := CalcDate('<-1M>', WorkDate());
            end else begin
                PreviouMonth := CalcDate('<-1M>', WorkDate());
                StartDate := CalcDate('<-CM>', PreviouMonth);
            end;
            EndDate := CalcDate('<CM>', PreviouMonth);
        end else begin
            if OpenPeriod then begin
                StartDate := 0D;
                PreviouMonth := CalcDate('<-1M>', WorkDate());
            end else begin
                PreviouMonth := CalcDate('<-1M>', WorkDate());
                StartDate := CalcDate('<-FM>', PreviouMonth);
            end;
            EndDate := CalcDate('<FM>', PreviouMonth);
        end;
        Day := CopyStr(FORMAT(DATE2DMY(EndDate, 1)), 1, 2);
        Mnt := CopyStr(FORMAT(DATE2DMY(EndDate, 2)), 1, 2);
        Yr := CopyStr(FORMAT(DATE2DMY(EndDate, 3)), 1, 4);
    end;

    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        FileRecord: Text[1024];
        CommonDialogMgt: Codeunit "File Management";
        CompanyInfo: Record "Company Information";
        FleCIL1: File;
        GenLegSetup: Record "General Ledger Setup";
        Cnt: Integer;
        FilePath: Label 'GLTRAN_';
        Delimeter: Label ',';
        FileName: Text[1024];
        Text001: Label 'Company';
        Text002: Label 'G/L Account No.';
        Text003: Label 'EffectiveDate';
        Text004: Label 'Date1';
        Text005: Label 'CCY2Code';
        Text006: Label 'CCY2Amount';
        Text007: Label 'Document No';
        Text008: Label 'Description';
        Text009: Label 'Document Type';
        Text010: Label 'External Document No.';
        Text011: Label 'Customer No';
        Text012: Label 'User ID';
        Text013: Label 'FOOTER';
        TotalAmt: Decimal;
        StartDate: Date;
        EndDate: Date;
        Text014: Label 'File exported successfully';
        GLRegister: Record "G/L Register";
        Day: Text;
        Mnt: Text;
        Yr: Text;
        TAB: Char;
        OpenPeriod: Boolean;
        PreviouMonth: Date;
        // BC Upgrade KUMARS145...>>
        InStr: InStream;
        OutStr: OutStream;
        tmpBlob: Codeunit "Temp Blob";
        TextBuilderVar: TextBuilder;
    // BC Upgrade KUMARS145...<<

}

