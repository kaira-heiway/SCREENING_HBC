report 51085 "Exp Bank Paym Citi DRC CBN"
{
    // version HEI.01

    // HEI.01 CHG2190168 IBM POENAB02 25.01.2021 HB2330 BKT-EFT Citi bank payment file update
    //   # Object created
    //   # Object initialy created in 20.08.2021, but due to some changes under HEI.01, the date was changed.
    //   # 25.01.2023 Old CHG CHG2117475 was replaced with CHG2190168

    // BC Upgrade KUMARS145

    Caption = 'Export Bank Payments - Citi Bank (USD/EUR)';
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

            trigger OnPreDataItem();
            var
                lBankAccount: Record "Bank Account";
                lVendorBankAccount: Record "Vendor Bank Account";
                lVendorBankAccNo: Text[30];
                llVendorCurrency: Code[10];
                lVendorName: Text[50];
                lVendorNo: Code[20];
                lVendorBankIBAN: Code[50];
                lVendorAddress: Text[50];
                lTransitNo: Text[20];
                lSwiftCode: Code[20];
            begin
                if GenJournalBatch.Get(TempGenLine."Journal Template Name", TempGenLine."Journal Batch Name") then;
                if lBankAccount.Get(GenJournalBatch."HNK Bank Account FND") then;


                TempGenLine.Reset();
                if TempGenLine.FindFirst() then
                    repeat
                        ItemTMP.Reset();
                        GenJournalLine4TMP.Reset();
                        GenJournalLine4TMP.SetRange("Journal Batch Name", TempGenLine."Journal Batch Name");
                        GenJournalLine4TMP.SetRange("Journal Template Name", TempGenLine."Journal Template Name");
                        GenJournalLine4TMP.SetRange("Line No.", TempGenLine."Line No.");
                        if GenJournalLine4TMP.FindFirst() then begin
                            lVendorBankAccount.Reset();
                            lVendorBankAccount.SetRange("Vendor No.", GenJournalLine4TMP."Account No.");
                            lVendorBankAccount.SetRange(Code, GenJournalLine4TMP."Recipient Bank Account");
                            if lVendorBankAccount.FindFirst() then begin
                                if lVendorBankAccount."Bank Account No." <> '' then
                                    lVendorBankAccNo := lVendorBankAccount."Bank Account No."
                                else
                                    lVendorBankAccNo := GenJnlLine."Vendor Bank Acc. No. FND";
                                llVendorCurrency := lVendorBankAccount."Currency Code";
                                lVendorName := lVendorBankAccount.Name;
                                lVendorNo := lVendorBankAccount."Vendor No.";
                                lVendorBankIBAN := lVendorBankAccount.IBAN;
                                lVendorAddress := lVendorBankAccount.Address;
                                lTransitNo := lVendorBankAccount."Transit No.";
                                lSwiftCode := lVendorBankAccount."SWIFT Code";
                            end else begin
                                lVendorBankAccount.SetRange("Vendor No.", GenJournalLine4TMP."Account No.");
                                lVendorBankAccount.SetRange(Code, GenJournalLine4TMP."Vendor Bank Account FND");
                                if lVendorBankAccount.FindFirst() then begin
                                    llVendorCurrency := lVendorBankAccount."Currency Code";
                                    lVendorName := lVendorBankAccount.Name;
                                    lVendorNo := lVendorBankAccount."Vendor No.";
                                    lVendorBankIBAN := lVendorBankAccount.IBAN;
                                    lVendorAddress := lVendorBankAccount.Address;
                                    lTransitNo := lVendorBankAccount."Transit No.";
                                    lSwiftCode := lVendorBankAccount."SWIFT Code";
                                end;
                            end;

                            PayMethToExport := '';
                            DRCSetupforExpPayMeth.Reset();
                            DRCSetupforExpPayMeth.SetRange("House Bank", lBankAccount."No.");
                            DRCSetupforExpPayMeth.SetRange("Receiving Bank", lVendorBankAccount.Code);
                            if (GenJournalLine4TMP."Currency Code" <> '') then
                                DRCSetupforExpPayMeth.SetRange(Currency, GenJournalLine4TMP."Currency Code");
                            if (GenJournalLine4TMP."Currency Code" = '') then
                                DRCSetupforExpPayMeth.SetRange(Currency, '');
                            DRCSetupforExpPayMeth.SetRange("Country Receiving Bank", lVendorBankAccount."Country/Region Code");
                            if DRCSetupforExpPayMeth.FindFirst() then begin
                                PayMethToExport := DRCSetupforExpPayMeth."Value for Payment Method";
                                if not ItemTMP.Get(PayMethToExport) then begin
                                    ItemTMP."No." := PayMethToExport;
                                    if ItemTMP.Insert() then;
                                end;
                            end;
                        end;
                    until TempGenLine.Next() = 0;

                ItemTMP.Reset();
                if ItemTMP.Count > 1 then
                    Error(Text50001);
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
        ToFileName := GetFileName();
        // BC Upgrade KUMARS145 old code block replaced with new onw ....>>
        // Writer.Close;
        // if ToFileFullName = '' then
        //   ToFileFullName := FileManagement.SaveFileDialog('',ToFileName,FileManagement.GetToFilterText('','.txt'));
        // if ToFileFullName = '' then begin
        //   ERASE(OutputFileName);
        //   exit;
        // end;
        // Clear(oStream);
        // ClientTempFileName := FileManagement.DownloadTempFile(OutputFileName);
        // FileManagement.CopyClientFile(ClientTempFileName,ToFileFullName,true);
        // ERASE(OutputFileName);

        tmpBlob.CreateOutStream(OutStr, TextEncoding::Windows);
        OutStr.WriteText(TextBuilderVar.ToText());
        tmpBlob.CreateInStream(InStr, TextEncoding::Windows);
        DownloadFromStream(InStr, '', '', '', ToFileName);

        // BC Upgrade KUMARS145 old code block replaced with new onw ....>>

        Message(FileCreatedMsg);

        ItemTMP.DeleteAll();
    end;

    trigger OnPreReport();
    begin
        CompanyInformation.Get();
        // CreateServerFile();// BC Upgrade KUMARS145 on Saas Not Required
        ItemTMP.DeleteAll();
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
        Vendor: Record Vendor;
        PayMethToExport: Code[10];
        DRCSetupforExpPayMeth: Record "DRC-Setup for Exp Pay Meth FND";
        Text50000: Label 'No payment method was defined for House Bank %1, Receiving Bank %2, Currency %3, Country Receiving Bank %4!';
        GeneralLedgerSetup: Record "General Ledger Setup";
        Text50001: Label 'Proposal contains documents with different bank payment method code, please check the proposal lines and make the corrections!';
        ItemTMP: Record Item temporary;
        GenJournalLine4TMP: Record "Gen. Journal Line";
        ILE: Record "Item Ledger Entry";
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
        // Writer := Writer.StreamWriter(OutputFileName, false, encoding.Default); // append = FALSE
        // BC Upgrade KUMARS145 old module using Dotnet vars commented....>>
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

    local procedure GetFormattedDate(GnlJnlDate: Date): Text[8];
    begin
        if GnlJnlDate <> 0D then
            exit(Format(GnlJnlDate, 0, '20<Year><Month,2><Day,2>'));
        exit('')
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
        SwiftCode: Text;
        GenJnlLine2: Record "Gen. Journal Line";
        VendorBankIBAN: Code[50];
        VendorNo: Code[20];
        lVendor: Record Vendor;
        lBeneficiaryAddressLine1: Text;
        GenJnlCurrency: Code[10];
        lTextCurrencyToExport: Text;
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
            VendorCurrency := VendorBankAccount."Currency Code";
            //VendorName := VendorBankAccount.Name;
            VendorBankAccount.CalcFields("Vendor Name FND");
            VendorName := VendorBankAccount."Vendor Name FND";
            VendorNo := VendorBankAccount."Vendor No.";
            VendorBankIBAN := VendorBankAccount.IBAN;
            VendorAddress := VendorBankAccount.Address;
            TransitNo := VendorBankAccount."Transit No.";
            SwiftCode := VendorBankAccount."SWIFT Code";
        end else begin
            VendorBankAccount.SetRange("Vendor No.", GenJnlLine."Account No.");
            VendorBankAccount.SetRange(Code, GenJnlLine."Vendor Bank Account FND");
            if VendorBankAccount.FindFirst() then begin
                VendorCurrency := VendorBankAccount."Currency Code";
                //VendorName := VendorBankAccount.Name;
                VendorBankAccount.CalcFields("Vendor Name FND");
                VendorName := VendorBankAccount."Vendor Name FND";
                VendorNo := VendorBankAccount."Vendor No.";
                VendorBankIBAN := VendorBankAccount.IBAN;
                VendorAddress := VendorBankAccount.Address;
                TransitNo := VendorBankAccount."Transit No.";
                SwiftCode := VendorBankAccount."SWIFT Code";
            end;
        end;

        lBeneficiaryAddressLine1 := '';
        if lVendor.Get(GenJnlLine."Account No.") then
            lBeneficiaryAddressLine1 := lVendor.Address;

        GenJnlLine2.Reset();
        GenJnlLine2.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
        GenJnlLine2.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
        GenJnlLine2.SetRange("Line No.", GenJnlLine."Parent Line No. FND");
        if GenJnlLine2.FindFirst() then;

        GeneralLedgerSetup.Get();
        PayMethToExport := '';
        DRCSetupforExpPayMeth.Reset();
        DRCSetupforExpPayMeth.SetRange("House Bank", BankAccount."No.");
        DRCSetupforExpPayMeth.SetRange("Receiving Bank", VendorBankAccount.Code);
        if (GenJnlLine2."Currency Code" <> '') then
            DRCSetupforExpPayMeth.SetRange(Currency, GenJnlLine2."Currency Code");
        if (GenJnlLine2."Currency Code" = '') then
            DRCSetupforExpPayMeth.SetRange(Currency, '');
        DRCSetupforExpPayMeth.SetRange("Country Receiving Bank", VendorBankAccount."Country/Region Code");
        if DRCSetupforExpPayMeth.FindFirst() then begin
            PayMethToExport := DRCSetupforExpPayMeth."Value for Payment Method";
            if DRCSetupforExpPayMeth."Swift Code" = false then
                SwiftCode := '';
        end
        else
            Error(Text50000, BankAccount."No.", VendorBankAccount.Code, GenJnlLine2."Currency Code", VendorBankAccount."Country/Region Code");


        lTextCurrencyToExport := GenJnlLine2."Currency Code";
        if (GenJnlLine2."Currency Code" = '') then
            lTextCurrencyToExport := GeneralLedgerSetup."LCY Code";

        if PayMethToExport = 'BKT' then
            // BC Upgrade KUMARS145 old function replaced with new one....>>
            // Writer.WriteLine('#' + CompanyInformation."Country/Region Code" + '#' +
            //   FORMAT(PayMethToExport) + '#' +
            //   GetFormattedDate(GenJnlLine2."Posting Date") + '#####' +
            //   //GenJnlLine2."Currency Code" + '#' +
            //   lTextCurrencyToExport + '#' +
            //   FORMAT(GenJnlLine.Amount, 0, '<Sign><Integer><Decimals,3><Comma,.>') + '##' +
            //   //FORMAT(GenJnlLine.Amount,0,'<Sign><Integer Thousand><1000Character,,><Decimals,3><Comma,.>') + '##' +
            //   //BankAccount."Bank Account No." + '#############' + //debit account
            //   COPYSTR(BankAccount."Bank Account No.", 13, 9) + '#############' + //debit account
            //   GenJnlLine."Applies-to Doc. No." + '###################' +
            //   VendorBankIBAN + '#' +//credit account
            //   COPYSTR(VendorName, 1, 35) + '##' + //Beneficiary Name
            //   FORMAT(COPYSTR(lBeneficiaryAddressLine1, 1, 35)) + '#########################' +
            //   GenJnlLine."Applies-to Doc. No." +
            //   '#' + '827');
     TextBuilderVar.AppendLine('#' + CompanyInformation."Country/Region Code" + '#' +
          FORMAT(PayMethToExport) + '#' +
          GetFormattedDate(GenJnlLine2."Posting Date") + '#####' +
          //GenJnlLine2."Currency Code" + '#' +
          lTextCurrencyToExport + '#' +
          FORMAT(GenJnlLine.Amount, 0, '<Sign><Integer><Decimals,3><Comma,.>') + '##' +
          //FORMAT(GenJnlLine.Amount,0,'<Sign><Integer Thousand><1000Character,,><Decimals,3><Comma,.>') + '##' +
          //BankAccount."Bank Account No." + '#############' + //debit account
          COPYSTR(BankAccount."Bank Account No.", 13, 9) + '#############' + //debit account
          GenJnlLine."Applies-to Doc. No." + '###################' +
          VendorBankIBAN + '#' +//credit account
          COPYSTR(VendorName, 1, 35) + '##' + //Beneficiary Name
          FORMAT(COPYSTR(lBeneficiaryAddressLine1, 1, 35)) + '#########################' +
          GenJnlLine."Applies-to Doc. No." +
          '#' + '827');
        // BC Upgrade KUMARS145 old function replaced with new one....<<


        if PayMethToExport = 'EFT' then
            // BC Upgrade KUMARS145 old function replaced with new one....>>
            // Writer.WriteLine('#' + CompanyInformation."Country/Region Code" + '#' +
            //   FORMAT(PayMethToExport) + '#' +
            //   GetFormattedDate(GenJnlLine2."Posting Date") + '#Y####' +
            //   GenJnlLine2."Currency Code" + '#' +
            //   //FORMAT(GenJnlLine.Amount,0,'<Sign><Integer><Decimals,3><Comma,.>') + '##' +
            //   FORMAT(GenJnlLine.Amount, 0, '<Sign><Integer Thousand><1000Character,,><Decimals,3><Comma,.>') + '##' +
            //   BankAccount."Bank Account No." + '##########OUR###' + //debit account
            //                                                         //GenJnlLine."Applies-to Doc. No." + '###############' +
            //   GenJnlLine."Applies-to Doc. No." + '###################' +
            //   VendorBankIBAN + '#' +
            //   COPYSTR(VendorName, 1, 35) + '##' + //Beneficiary Name
            //   FORMAT(COPYSTR(lBeneficiaryAddressLine1, 1, 35)) + '###IS#' +
            //   SwiftCode + '#####################' +
            //   GenJnlLine."Applies-to Doc. No." + '####NOADVISE#ACC##' +
            //   BankAccount."Bank Account No." + '##' +
            //   'Not a bank');
            TextBuilderVar.AppendLine('#' + CompanyInformation."Country/Region Code" + '#' +
              FORMAT(PayMethToExport) + '#' +
              GetFormattedDate(GenJnlLine2."Posting Date") + '#Y####' +
              GenJnlLine2."Currency Code" + '#' +
              //FORMAT(GenJnlLine.Amount,0,'<Sign><Integer><Decimals,3><Comma,.>') + '##' +
              FORMAT(GenJnlLine.Amount, 0, '<Sign><Integer Thousand><1000Character,,><Decimals,3><Comma,.>') + '##' +
              BankAccount."Bank Account No." + '##########OUR###' + //debit account
                                                                    //GenJnlLine."Applies-to Doc. No." + '###############' +
              GenJnlLine."Applies-to Doc. No." + '###################' +
              VendorBankIBAN + '#' +
              COPYSTR(VendorName, 1, 35) + '##' + //Beneficiary Name
              FORMAT(COPYSTR(lBeneficiaryAddressLine1, 1, 35)) + '###IS#' +
              SwiftCode + '#####################' +
              GenJnlLine."Applies-to Doc. No." + '####NOADVISE#ACC##' +
              BankAccount."Bank Account No." + '##' +
              'Not a bank');
        // BC Upgrade KUMARS145 old function replaced with new one....<<

        if PayMethToExport = 'DFT' then begin
            GenJnlCurrency := 'CDF';
            if GenJnlLine."Currency Code" = '' then
                // BC Upgrade KUMARS145 old function replaced with new one....>>
                // Writer.WriteLine('#' + CompanyInformation."Country/Region Code" + '#' +
                //   'DFT' + '#' +
                //   GetFormattedDate(GenJnlLine2."Posting Date") + '#####' +
                //   GenJnlCurrency + '#' +
                //   FORMAT(ROUND(GenJnlLine."Amount LCY DRC", 1, '='), 0, '<Sign><Integer><Decimals,3><Comma,.>')
                //    + '##' +
                //   BankAccount."Bank Account No." + '##########' +
                //   'OUR' + '######################' +
                //   VendorBankIBAN + '#' +
                //   COPYSTR(VendorName, 1, 35) + '##' +
                //   VendorAddress + '####' +
                //   TransitNo + '#####################' +
                //   GenJnlLine."Applies-to Doc. No." + '####' +
                //   'NOADVISE' + '###' +
                //   BankAccount."Bank Account No." + '##' +
                //   'Not a bank' + '#####');
             TextBuilderVar.AppendLine('#' + CompanyInformation."Country/Region Code" + '#' +
                  'DFT' + '#' +
                  GetFormattedDate(GenJnlLine2."Posting Date") + '#####' +
                  GenJnlCurrency + '#' +
                  FORMAT(ROUND(GenJnlLine."Amount LCY DRC FND", 1, '='), 0, '<Sign><Integer><Decimals,3><Comma,.>')
                   + '##' +
                  BankAccount."Bank Account No." + '##########' +
                  'OUR' + '######################' +
                  VendorBankIBAN + '#' +
                  COPYSTR(VendorName, 1, 35) + '##' +
                  VendorAddress + '####' +
                  TransitNo + '#####################' +
                  GenJnlLine."Applies-to Doc. No." + '####' +
                  'NOADVISE' + '###' +
                  BankAccount."Bank Account No." + '##' +
                  'Not a bank' + '#####');
            // BC Upgrade KUMARS145 old function replaced with new one....>>

            if GenJnlLine."Currency Code" <> '' then
                // BC Upgrade KUMARS145 old function replaced with new one....>>
                // Writer.WriteLine('#' + CompanyInformation."Country/Region Code" + '#' +
                //   'DFT' + '#' +
                //   GetFormattedDate(GenJnlLine2."Posting Date") + '#####' +
                //   GenJnlCurrency + '#' +
                //   FORMAT(ROUND(GenJnlLine."Amount LCY DRC", 1, '='), 0, '<Sign><Integer><Decimals,3><Comma,.>')
                //    + '##' +
                //   BankAccount."Bank Account No." + '##########' +
                //   'OUR' + '######################' +
                //   VendorBankIBAN + '#' +
                //   COPYSTR(VendorName, 1, 35) + '##' +
                //   VendorAddress + '####' +
                //   TransitNo + '#####################' +
                //   GenJnlLine."Applies-to Doc. No." + '####' +
                //   'NOADVISE' + '###' +
                //   BankAccount."Bank Account No." + '##' +
                //   'Not a bank' + '#####');
                TextBuilderVar.AppendLine('#' + CompanyInformation."Country/Region Code" + '#' +
                  'DFT' + '#' +
                  GetFormattedDate(GenJnlLine2."Posting Date") + '#####' +
                  GenJnlCurrency + '#' +
                  FORMAT(ROUND(GenJnlLine."Amount LCY DRC FND", 1, '='), 0, '<Sign><Integer><Decimals,3><Comma,.>')
                   + '##' +
                  BankAccount."Bank Account No." + '##########' +
                  'OUR' + '######################' +
                  VendorBankIBAN + '#' +
                  COPYSTR(VendorName, 1, 35) + '##' +
                  VendorAddress + '####' +
                  TransitNo + '#####################' +
                  GenJnlLine."Applies-to Doc. No." + '####' +
                  'NOADVISE' + '###' +
                  BankAccount."Bank Account No." + '##' +
                  'Not a bank' + '#####');
            // BC Upgrade KUMARS145 old function replaced with new one....<<
        end;
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
            TempGenLine."Account No." := NewGenJnlLine."Account No.";
            TempGenLine."Currency Code" := NewGenJnlLine."Currency Code";
            TempGenLine."Vendor Bank Acc. No. FND" := NewGenJnlLine."Vendor Bank Acc. No. FND";
            TempGenLine."Vendor Bank Account FND" := NewGenJnlLine."Vendor Bank Account FND";
            TempGenLine."Recipient Bank Account" := NewGenJnlLine."Recipient Bank Account";
            TempGenLine."Payment Method Code" := NewGenJnlLine."Payment Method Code";
            TempGenLine."Applies-to Ext. Doc. No." := NewGenJnlLine."Applies-to Ext. Doc. No.";
            TempGenLine."Applies-to Doc. No." := NewGenJnlLine."Applies-to Doc. No.";
            TempGenLine."Parent Line No. FND" := NewGenJnlLine."Parent Line No. FND";
            TempGenLine.Insert();
        end;
    end;
}

