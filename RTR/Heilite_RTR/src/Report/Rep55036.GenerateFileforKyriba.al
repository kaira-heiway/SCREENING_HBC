report 55036 "Generate File for Kyriba"
{
    // HEI.01 CHG2105033 BULIMC01 IBM 05.11.2021# File extraction for Kyriba
    //   # Object created
    // BC Upgrade BHARDA11 >>
    // 1. OLD Report OD - 50508.
    // 2. "G/L Bank Account No." is obsolet  we are using "G/L Account No."
    // 3. Restructure Export to excel code using Instream and Outstream.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Generate File for Kyriba';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = SORTING("Bank Account No.", "Posting Date") ORDER(Ascending);
            RequestFilterFields = "Bank Account No.";

            trigger OnAfterGetRecord();
            var
                GenJournalLine: Record "Gen. Journal Line";
            begin
                if BankAccount.GET("Bank Account No.") then;
                if BankAccPostingGroup.GET("Bank Acc. Posting Group") then
                    // if GLAccount.GET(BankAccPostingGroup."G/L Bank Account No.") then; // BC Upgrade BHARAD11 --"G/L Bank Account No." is obsolet  we are using "G/L Account No."
                    if GLAccount.GET(BankAccPostingGroup."G/L Account No.") then;

                CLEAR(EntryCode);
                CLEAR(Movement);
                if Amount < 0 then begin
                    EntryCode := '01';
                    Movement := 'C';
                end else begin
                    EntryCode := '04';
                    Movement := 'D';
                end;

                Col1 := CompanyInformation."OpCo Code for CFAO FND" + BankAccount."Post Code" + GLAccount."No. 2";
                Col2 := GetFormattedDate("Posting Date") + EntryCode;
                Col3 := GLSetup."LCY Code" + Movement + FORMAT(ABS(Amount), 0, '<Sign><Integer,13><Decimals,3><Comma,.>') + "Document No." + ' ' + FORMAT("Transaction No.", 7) + ' ' + COPYSTR(Description, 1, 24);
                Col4 := 'STAT:';
                Col5 := 'BORD:00000000' + '      ' + "Document No." + ' ' + 'JNL:' + COPYSTR("Journal Batch Name", 1, 3) + ' ' + 'USR:' + COPYSTR("User ID", 8, 3) + ' ' +
                        'UPDTE:' + GetFormattedDate("Posting Date") + ' ' + FORMAT("Entry No.") + ' ' + SourceCodeSetup."No. Series for Kyriba FND" + COPYSTR("User ID", 8, 3) + '00001';

                // Writer.WriteLine(PADSTR(Col1, MAXSTRLEN(Col1)) + PADSTR(Col2, MAXSTRLEN(Col2)) + PADSTR(Col3, MAXSTRLEN(Col3)) + PADSTR(Col4, MAXSTRLEN(Col4)) + PADSTR(Col5, MAXSTRLEN(Col5))); // BC Upgrade BHARDA11 ::Blocked
                TextBuilderVar.AppendLine(PADSTR(Col1, MAXSTRLEN(Col1)) + PADSTR(Col2, MAXSTRLEN(Col2)) + PADSTR(Col3, MAXSTRLEN(Col3)) + PADSTR(Col4, MAXSTRLEN(Col4)) + PADSTR(Col5, MAXSTRLEN(Col5))); // BC Upgrade BHARDA11 ::Added
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE("Posting Date", StartingDate, EndingDate);
            end;
        }
    }

    requestpage
    {
        SaveValues = false;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field(StartingDate; StartingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Starting Date';
                    }
                    field(EndingDate; EndingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Closing Date';
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

    trigger OnPostReport();
    var
        ClientTempFileName: Text[250];
    begin
        ToFileName := GetFileName;
        // BC Upgrade KUMARS145 old code block replaced with new onw ....>>
        // Writer.Close;

        // if ToFileFullName = '' then
        //     ToFileFullName := FileManagement.SaveFileDialog('', ToFileName, FileManagement.GetToFilterText('', '.txt'));

        // if ToFileFullName = '' then begin
        //     ERASE(OutputFileName);
        //     exit;
        // end;

        // CLEAR(oStream);

        // ClientTempFileName := FileManagement.DownloadTempFile(OutputFileName);
        // FileManagement.CopyClientFile(ClientTempFileName, ToFileFullName, true);

        // ERASE(OutputFileName);
        tmpBlob.CreateOutStream(OutStr, TextEncoding::Windows);
        OutStr.WriteText(TextBuilderVar.ToText());
        tmpBlob.CreateInStream(InStr, TextEncoding::Windows);
        DownloadFromStream(InStr, '', '', '', ToFileName);
        // BC Upgrade KUMARS145 old code block replaced with new onw ....>>
        MESSAGE(FileCreatedMsg);
    end;

    trigger OnPreReport();
    begin
        CompanyInformation.GET;
        GLSetup.GET;
        SourceCodeSetup.GET;

        // CreateServerFile; // BC Upgrade BHARDA11 on Saas Not Required
    end;

    var
        // BC Upgrade KUMARS145...>>
        InStr: InStream;
        OutStr: OutStream;
        tmpBlob: Codeunit "Temp Blob";
        TextBuilderVar: TextBuilder;
        // BC Upgrade KUMARS145...<<
        FileManagement: Codeunit "File Management";
        OutputFileName: Text[250];
        ToFileName: Text[250];
        ToFileFullName: Text[250];
        MissingStartingDateErr: TextConst ENU = 'You must enter a Starting Date.', FRA = 'Vous devez entrer une date de début.';
        MissingEndingDateErr: TextConst ENU = 'You must enter an Ending Date.', FRA = 'Vous devez entrer une date de fin.';
        FileCreatedMsg: TextConst ENU = 'The text file was created successfully.', FRA = 'Le fichier texte a bien été créé.';
        NoEntriestoExportErr: TextConst ENU = 'There are no entries to export within the defined filter. The file was not created.', FRA = 'Il n''y a pas d''écriture à exporter dans le filtre défini. Le fichier n''a pas été créé.';
        InvalidWindowsChrStringTxt: TextConst ENU = '""#%&*:<>?\/{|}~', FRA = '""#%&*:<>?\/{|}~';
        ServerFileExtensionTxt: TextConst ENU = 'TXT', FRA = 'TXT';
        OutputFile: File;
        oStream: OutStream;
        // BC Upgrade BHARDA11 >> ----Dotnet variables not 
        // Writer: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.StreamWriter";
        // encoding: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Text.Encoding";
        CompanyInformation: Record "Company Information";
        Text50000: Label 'No payment method was defined for House Bank %1, Receiving Bank %2, Currency %3, Country Receiving Bank %4!';
        SourceCodeSetup: Record "Source Code Setup";
        BankAccount: Record "Bank Account";
        GLSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        EntryCode: Code[10];
        Movement: Code[10];
        Col1: Text[22];
        Col2: Text[12];
        Col3: Text[62];
        Col4: Text[28];
        Col5: Text[150];
        BankAccPostingGroup: Record "Bank Account Posting Group";
        StartingDate: Date;
        EndingDate: Date;

    local procedure CreateServerFile();
    begin
        // BC Upgrade BHARDA11 >> on Saas Not Required
        // OutputFileName := FileManagement.ServerTempFileName(ServerFileExtensionTxt);
        // if EXISTS(OutputFileName) then
        //     ERASE(OutputFileName);

        // OutputFile.TEXTMODE(true);
        // OutputFile.WRITEMODE(true);
        // OutputFile.CREATEOUTSTREAM(oStream);
        // Writer := Writer.StreamWriter(OutputFileName, false, encoding.Default);
        // BC Upgrade BHARDA11 << on Saas Not Required
    end;

    local procedure GetFileName(): Text[250];
    var
        CompanyInformation: Record "Company Information";
        FileName: Text[250];
    begin
        CompanyInformation.GET;
        FileName := 'Kyriba extraction for ' + GetFormattedDate(StartingDate) + '..' + GetFormattedDate(EndingDate)
                   + ' ' + USERID + '.txt';
        exit(DELCHR(FileName, '=', InvalidWindowsChrStringTxt));
    end;

    local procedure GetFormattedDate(GnlJnlDate: Date): Text[8];
    begin
        if GnlJnlDate <> 0D then
            exit(FORMAT(GnlJnlDate, 0, '<Day,2><Month,2>20<Year>'));
        exit('')
    end;
}

