report 51082 "ExpBankPaymDRCRawBankCDFCBN"
{
    // HEI.01 CHG2086827 IBM POENAB02 23.11. 2020 Bank Connectivity DRC  complementing BRD HT84
    //  # Object created.

    // BC Upgrade KUMARS145 Nav ID Report 50497 "ExpBankPaymDRCRawBankCDFCBN"

    Caption = 'Export Bank Payments - Raw Bank CDF';
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(GenJnlLine; "Gen. Journal Line")
        {
            trigger OnAfterGetRecord();
            var
                GenJournalLine: Record "Gen. Journal Line";
            begin
                Clear(TempGenLine);
                TempGenLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                TempGenLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                TempGenLine.SetRange("Line No.", GenJnlLine."Line No.");
                if TempGenLine.FindFirst() then
                    WriteGnlJnlLineToFile(TempGenLine);
            end;
        }
    }

    requestpage
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
        //   ToFileFullName := FileManagement.SaveFileDialog('',ToFileName,FileManagement.GetToFilterText('','.txt'));
        // if ToFileFullName = '' then begin
        //   ERASE(OutputFileName);
        //   exit;
        // end;
        // CLEAR(oStream);
        // ClientTempFileName := FileManagement.DownloadTempFile(OutputFileName);
        // FileManagement.CopyClientFile(ClientTempFileName,ToFileFullName,true);
        // ERASE(OutputFileName);

        tmpBlob.CreateOutStream(OutStr, TextEncoding::Windows);
        OutStr.WriteText(TextBuilderVar.ToText());
        tmpBlob.CreateInStream(InStr, TextEncoding::Windows);
        DownloadFromStream(InStr, '', '', '', ToFileName);

        // BC Upgrade KUMARS145 old code block replaced with new onw ....>>

        Message(FileCreatedMsg);
    end;

    trigger OnPreReport();
    begin
        CompanyInformation.Get();
        // CreateServerFile(); // BC Upgrade KUMARS145 on Saas Not Required
    end;

    var
        FileManagement: Codeunit "File Management";
        OutputFileName: Text[250];
        StartingDate: Date;
        EndingDate: Date;
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
        // BC Upgrade KUMARS145 old DotNet vars commented....>>
        // Writer: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.StreamWriter";
        // encoding: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Text.Encoding";
        // BC Upgrade KUMARS145 old DotNet vars commented....<<
        CurrentTransactionNo: Integer;
        GenJournalBatch: Record "Gen. Journal Batch";
        HNKBankAcc: Code[10];
        CompanyInformation: Record "Company Information";
        TempGenLine: Record "Gen. Journal Line" temporary;
        GenJnlCurrency: Code[10];
        Vendor: Record Vendor;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        // BC Upgrade KUMARS145...>>
        InStr: InStream;
        OutStr: OutStream;
        tmpBlob: Codeunit "Temp Blob";
        TextBuilderVar: TextBuilder;
    // BC Upgrade KUMARS145...<<


    local procedure CreateServerFile();
    begin
        // BC Upgrade KUMARS145 old module using Dotnet vars commented....>>
        // OutputFileName := FileManagement.ServerTempFileName(ServerFileExtensionTxt);
        // if EXISTS(OutputFileName) then
        //     ERASE(OutputFileName);
        // OutputFile.TEXTMODE(true);
        // OutputFile.WRITEMODE(true);
        // OutputFile.CREATEOUTSTREAM(oStream);
        // Writer := Writer.StreamWriter(OutputFileName, false, encoding.Default);
        // BC Upgrade KUMARS145 old module using Dotnet vars commented....>>
    end;

    local procedure FormatAmount(Amount: Decimal): Text[250];
    begin
        exit(DelChr(Format(Amount, 0, '<Sign><Integer><Decimals,3><Comma, >')));
    end;

    local procedure GetFileName(): Text[250];
    var
        CompanyInformation: Record "Company Information";
        FileName: Text[250];
    begin
        CompanyInformation.Get();
        FileName := GenJournalBatch."HNK Bank Account FND" + '.txt';
        exit(DelChr(FileName, '=', InvalidWindowsChrStringTxt));
    end;

    local procedure GetFormattedDate(GLEntryDate: Date): Text[8];
    begin
        if GLEntryDate <> 0D then
            exit(Format(GLEntryDate, 8, '<Year4><Month,2><Day,2>'));
        exit('')
    end;

    local procedure ResetTransactionData();
    begin
    end;

    local procedure WriteHeaderToFile();
    begin
        // BC Upgrade KUMARS145 old function replaced with new one....>>
        // Writer.WriteLine('HNKBankAccount|VendorBankAccount|CurrencyCode|VendorName|Amount|CurrencyCodeJNL|Virement|Applies');
        TextBuilderVar.AppendLine('HNKBankAccount|VendorBankAccount|CurrencyCode|VendorName|Amount|CurrencyCodeJNL|Virement|Applies');
        // BC Upgrade KUMARS145 old function replaced with new one....<<
    end;

    local procedure WriteGnlJnlLineToFile(GenJnlLine: Record "Gen. Journal Line");
    var
        VendorBankAccount: Record "Vendor Bank Account";
        VendorBankAccNo: Text[30];
        VendorCurrency: Code[10];
        VendorName: Text[50];
        BankAccount: Record "Bank Account";
        VendorAddress: Text;
        TransitNo: Text;
        VendorBankIBAN: Code[50];
        lParentPostingDate: Date;
        lGenJournalLine: Record "Gen. Journal Line";
    begin
        if GenJournalBatch.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name") then;
        if BankAccount.Get(GenJournalBatch."HNK Bank Account FND") then;

        VendorBankAccount.Reset();
        VendorBankAccount.SetRange("Vendor No.", GenJnlLine."Account No.");
        VendorBankAccount.SetRange(Code, GenJnlLine."Recipient Bank Account");
        if VendorBankAccount.FindFirst() then begin
            if VendorBankAccount."Bank Account No." <> '' then
                VendorBankAccNo := VendorBankAccount."Bank Account No."
            else
                VendorBankAccNo := GenJnlLine."Vendor Bank Acc. No. FND";
            if VendorBankAccount."Currency Code" <> '' then
                VendorCurrency := VendorBankAccount."Currency Code"
            else
                VendorCurrency := 'CDF';
            VendorName := VendorBankAccount.Name;
            VendorBankIBAN := VendorBankAccount.IBAN;
            if Vendor.Get(VendorBankAccount."Vendor No.") then
                VendorName := Vendor.Name;
            VendorAddress := VendorBankAccount.Address;
            TransitNo := VendorBankAccount."Transit No.";
        end else begin
            VendorBankAccount.SetRange(Code, GenJnlLine."Vendor Bank Account FND");
            VendorBankAccount.SetRange("Vendor No.", GenJnlLine."Account No.");
            if VendorBankAccount.FindFirst() then begin
                if VendorBankAccount."Currency Code" <> '' then
                    VendorCurrency := VendorBankAccount."Currency Code"
                else
                    VendorCurrency := 'CDF';
                VendorName := VendorBankAccount.Name;
                VendorBankIBAN := VendorBankAccount.IBAN;
                if Vendor.Get(VendorBankAccount."Vendor No.") then
                    VendorName := Vendor.Name;
                VendorAddress := VendorBankAccount.Address;
                TransitNo := VendorBankAccount."Transit No.";
            end else
                VendorCurrency := 'CDF';
        end;

        if GenJnlLine."Currency Code" = '' then
            GenJnlLine."Amount LCY DRC FND" := GenJnlLine.Amount;
        if GenJnlLine."Parent Line No. FND" = 0 then
            lParentPostingDate := GenJnlLine."Posting Date"
        else
            if lGenJournalLine.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name", GenJnlLine."Parent Line No. FND") then
                lParentPostingDate := lGenJournalLine."Posting Date";

        if GenJnlLine."Currency Code" <> '' then
            GenJnlLine."Amount LCY DRC FND" := CurrencyExchangeRate.ExchangeAmtFCYToLCY(lParentPostingDate, GenJnlLine."Currency Code", GenJnlLine.Amount, GenJnlLine."Currency Factor");

        /*
        IF GenJnlLine."Currency Code" <> '' THEN
          GenJnlCurrency := GenJnlLine."Currency Code"
        ELSE GenJnlCurrency := 'CDF';
        */
        GenJnlCurrency := 'CDF';

        // BC Upgrade KUMARS145 old function replaced with new one....>>
        // Writer.WriteLine(BankAccount."Bank Account No." + '|' +
        //     VendorBankIBAN + '|' +
        //     VendorCurrency + '|' +
        //     VendorName + '|' +
        //     //FormatAmount(GenJnlLine.Amount) + '|' +
        //     //DELCHR(FORMAT(ROUND(GenJnlLine."Amount LCY DRC",1,'='),0,'<Sign><Integer><Decimals,0>')) + '|' +
        //     //DELCHR(FORMAT(GenJnlLine."Amount LCY DRC",0,'<Sign><Integer><Decimals,3><Comma, >')) + '|' +
        //     DELCHR(FORMAT(GenJnlLine."Amount LCY DRC", 0, '<Precision,2><Sign><Integer><Decimals,3><Comma, >')) + '|' +
        //     GenJnlCurrency + '|' + 'Virement immediat' + '|' +
        //     GenJnlLine."Applies-to Ext. Doc. No." + ' '
        //     + GenJnlLine."Applies-to Doc. No." + '|');

        TextBuilderVar.AppendLine(BankAccount."Bank Account No." + '|' +
                  VendorBankIBAN + '|' +
                  VendorCurrency + '|' +
                  VendorName + '|' +
                  //FormatAmount(GenJnlLine.Amount) + '|' +
                  //DELCHR(FORMAT(ROUND(GenJnlLine."Amount LCY DRC",1,'='),0,'<Sign><Integer><Decimals,0>')) + '|' +
                  //DELCHR(FORMAT(GenJnlLine."Amount LCY DRC",0,'<Sign><Integer><Decimals,3><Comma, >')) + '|' +
                  DelChr(Format(GenJnlLine."Amount LCY DRC FND", 0, '<Precision,2><Sign><Integer><Decimals,3><Comma, >')) + '|' +
                  GenJnlCurrency + '|' + 'Virement immediat' + '|' +
                  GenJnlLine."Applies-to Ext. Doc. No." + ' '
                  + GenJnlLine."Applies-to Doc. No." + '|');
        // BC Upgrade KUMARS145 old function replaced with new one....<<

    end;

    procedure SetGenJnlLine(NewGenJnlLine: Record "Gen. Journal Line");
    begin
        if not TempGenLine.Get(NewGenJnlLine."Journal Template Name", NewGenJnlLine."Journal Batch Name", NewGenJnlLine."Line No.") then begin
            TempGenLine.Init();
            TempGenLine."Journal Batch Name" := NewGenJnlLine."Journal Batch Name";
            TempGenLine."Journal Template Name" := NewGenJnlLine."Journal Template Name";
            TempGenLine."Line No." := NewGenJnlLine."Line No.";
            TempGenLine."Posting Date" := NewGenJnlLine."Posting Date";
            TempGenLine.Amount := NewGenJnlLine.Amount;
            TempGenLine."Currency Code" := NewGenJnlLine."Currency Code";
            TempGenLine."Vendor Bank Acc. No. FND" := NewGenJnlLine."Vendor Bank Acc. No. FND";
            TempGenLine."Account No." := NewGenJnlLine."Account No.";
            TempGenLine."Vendor Bank Account FND" := NewGenJnlLine."Vendor Bank Account FND";
            TempGenLine."Recipient Bank Account" := NewGenJnlLine."Recipient Bank Account";
            TempGenLine."Payment Method Code" := NewGenJnlLine."Payment Method Code";
            TempGenLine."Applies-to Ext. Doc. No." := NewGenJnlLine."Applies-to Ext. Doc. No.";
            TempGenLine."Applies-to Doc. No." := NewGenJnlLine."Applies-to Doc. No.";
            TempGenLine."Parent Line No. FND" := NewGenJnlLine."Parent Line No. FND";
            TempGenLine."Currency Factor" := NewGenJnlLine."Currency Factor";
            TempGenLine.Insert();
        end;
    end;
}

