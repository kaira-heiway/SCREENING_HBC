namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.Bank.Setup;
using Microsoft.Foundation.NoSeries;
using System.IO;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Bank.BankAccount;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Customer;
using Microsoft.Inventory.Item;
using Microsoft.Bank.Reconciliation;

codeunit 58102 "BC Interface Management"
{
    // HEI.01 CHG2020184 IBM POENAB02 26.06.2019
    //   # New codeunit for Bank Connectivity interface

    // BC Upgrade SHUKLP03 >> 
    // Replaced codeunit NoSeriesManagement with codeunit "No. Series".
    // Nav old id - 50084
    // BC Upgrade SHUKLP03 <<

    // BC UPGRADE PATELS08 >>
    // # Table name changed from Imported Bank Statements to Imported Bank Statements FND.
    // BC UPGRADE PATELS08 <<

    // BC Upgrade PATELP08>>
    // Changed name of table from "Imported Bank Statements Line" to "Imported Bank Stmt Line FND"
    // BC Upgrade PATELP08<<

    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        FuturMasterInterfaceSetup: Record "FuturMaster Interf. Setup INT";
        GeneralInterfaceSetupRead: Boolean;
        FuturMasterInterfaceSetupRead: Boolean;
        TempSalesActualMth: Record "Ledger Entry Matching Buffer" temporary;
        PeriodType: Option Month,Week;
        Index: Integer;
        Direction: Option Up,Down;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        FuturMasterInterfaceSetup2: Record "FuturMaster Interf Setup_2 INT";
        GeneralInterfaceSetupRead2: Boolean;
        FuturMasterInterfaceSetupRead2: Boolean;
        TempGroupSalesLine: Record "Ledger Entry Matching Buffer" temporary;
        TempGroupPurchLine: Record "Ledger Entry Matching Buffer" temporary;
        TempGroupProdOrder: Record "Ledger Entry Matching Buffer" temporary;
        Item: Record Item;
        TempGroupTransfLines: Record "Ledger Entry Matching Buffer" temporary;
        HeinekenGlobal: Codeunit "Heineken Global";
        BankExportImportSetup: Record "Bank Export/Import Setup";
        gBankStatementNo: Code[20];
        _MT940_: Integer;
        Linie_86_compusa: Text[1024];
        Linie: Text[1024];
        simbol: Text[1];
        //NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade SHUKLP03 << Blocked because deprecated.
        NoSeriesMgt: Codeunit "No. Series"; // BC Upgrade SHUKLP03 << replaced codeunit NoSeriesManagement with "No. Series".
        Doc_No: Code[20];
        Valuta: Code[3];
        ContBanca: Text[30];
        BankAcc: Record "Bank Account";
        GeneralLedgerSetup: Record "General Interface Setup INT";
        Debit: Boolean;
        Credit: Boolean;
        Reverse: Boolean;
        Suma: Decimal;
        Data_60: Text[8];
        modif_data: Text[6];
        zi: Integer;
        luna: Integer;
        an: Integer;
        inceput_86: Boolean;
        identificat_tip_tranz: Boolean;
        Multiplicare: Integer;
        CustomerBank: Record "Customer Bank Account";
        VendorBank: Record "Vendor Bank Account";
        Banci: Record "Bank Account";
        //Asociere: Record "UPG Table 2013768";	 // BC Upgrade SHUKLP03 <<  Marked with orange colour(No need to work).
        Banca: Option ,BOA,BNP;
        Jurnal: Record "Gen. Journal Line";
        BankAccountFound: Boolean;
        InStr: InStream;
        txtFromFile: Text;
        txtFromFile1: Text;
        NewXML: BigText;
        OutputStream: OutStream;
        MyFile: File;
        SaveToFileName: Text[250];
        SaveToFileNameClient: Text[250];
        RBMgt: Codeunit "File Management";
        FileName: Text[250];
        Text001: Label 'Scheduled';
        Text002: Label 'Manual';
        Text003: Label 'An error occured during the processing. See the Error Interface entries!';
        Text004: Label 'The file was successfully uploaded!';
        Text005: Label 'Log data...';
        StatementIDTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Id';
        IBANTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Acct/Id/IBAN';
        CurrencyTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Bal/Amt[@Ccy]';
        BalTypeTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Bal/Tp/CdOrPrtry/Cd';
        ClosingBalTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Bal/Amt';
        StatementDateTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/CreDtTm';
        CrdDbtIndTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Bal/CdtDbtInd';
        Text50000: TextConst ENU = 'Bank Account not found!';
        BankIDTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Acct/Id/Othr/Id';


    procedure ProcessBankStatementCAMT053(InterfaceEntryHeader: Record "Interface Entry Header INT") ReturnValue: Text
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryComponentOut: Record "Interface Entry Component INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        Item: Record Item;
        EntryNo: Integer;
        lImportedBankStatements: Record "Imported Bank Statements FND";
        lImportedBankStatementsLine: Record "Imported Bank Stmt Line FND";
        lBankAccount: Record "Bank Account";
        DataExch: Record "Data Exch.";
        lBankAccountNavNo: Code[20];
        EntryNo1: Integer;
        txtFromFile: Text;
        InStream1: InStream;
        NewXML: BigText;
        lDataExhInsert: Record "Data Exch.";
    begin
        //HEI.01>>
        lImportedBankStatements.RESET;

        lDataExhInsert.GET(InterfaceEntryHeader."Data Exch. Entry No.");
        lDataExhInsert.CALCFIELDS("File Content");
        InterfaceEntryHeader.Notes := lDataExhInsert."File Content";

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN
            REPEAT
                DataExch.INIT;
                DataExch.GET(InterfaceEntryHeader."Data Exch. Entry No.");
                TransformDataExchDef(InterfaceEntryHeader, DataExch);

                lImportedBankStatements.RESET;

                BankAccountFound := FALSE;
                lBankAccount.RESET;
                IF InterfaceEntryLine."Description 2" <> '' THEN BEGIN
                    lBankAccount.SETRANGE(IBAN, InterfaceEntryLine."Description 2");
                    IF lBankAccount.FINDFIRST THEN
                        BankAccountFound := TRUE;
                END;
                IF BankAccountFound = FALSE THEN
                    IF InterfaceEntryLine.Description <> '' THEN BEGIN
                        lBankAccount.SETRANGE("Bank Account No.", InterfaceEntryLine.Description);
                        IF lBankAccount.FINDFIRST THEN
                            BankAccountFound := TRUE;
                    END;
                IF BankAccountFound = FALSE THEN
                    ERROR(Text50000);

                TransformDataExchDefStep2(InterfaceEntryHeader, DataExch, lBankAccount);

                BankExportImportSetup.GET(lBankAccount."Bank Statement Import Format");

                lImportedBankStatements.INIT;
                lImportedBankStatements."Bank Statement No." := GetNextBankStatementNo;
                gBankStatementNo := lImportedBankStatements."Bank Statement No.";

                lImportedBankStatements."Statement Type" := lImportedBankStatements."Statement Type"::"Bank Reconciliation";
                lImportedBankStatements."Bank Account No." := lBankAccount."No.";
                lImportedBankStatements."Statement No." := gBankStatementNo;

                lImportedBankStatements."Import Date" := TODAY;
                lImportedBankStatements."Import Time" := TIME;
                lImportedBankStatements."File Imported" := InterfaceEntryLine."Log Message";

                lImportedBankStatements.IBAN := lBankAccount.IBAN;
                lImportedBankStatements."Bank Branch No." := InterfaceEntryLine."Ship-to Name";
                lImportedBankStatements."Number Of Records" := InterfaceEntryLine."External Requisition Line No.";

                lImportedBankStatements.INSERT;
                lBankAccountNavNo := lBankAccount."No.";

                IF BankAccountCouldBeUsedForImport(lBankAccountNavNo) THEN
                    ImportCAMT053BankStatement(lImportedBankStatements, DataExch, InterfaceEntryLine);
            UNTIL InterfaceEntryLine.NEXT = 0;

        CLEAR(lDataExhInsert);
        lDataExhInsert.GET(InterfaceEntryHeader."Data Exch. Entry No.");
        InterfaceEntryHeader.CALCFIELDS(Notes);
        lDataExhInsert."File Content" := InterfaceEntryHeader.Notes;
        lDataExhInsert.MODIFY;
        //HEI.01<<
    end;

    LOCAL procedure BankAccountCouldBeUsedForImport(BankAccountNo: Text[30]): Boolean
    var
        BankAccount: Record "Bank Account";
    begin
        //HEI.01>>
        BankAccount.GET(BankAccountNo);
        IF BankAccount."Bank Statement Import Format" <> '' THEN
            EXIT(TRUE);

        IF BankAccount.IsLinkedToBankStatementServiceProvider THEN
            EXIT(TRUE);

        EXIT(FALSE);
        //HEI.01<<
    end;

    procedure ImportCAMT053BankStatement(BankAccRecon: Record "Imported Bank Statements FND"; DataExch: Record "Data Exch."; InterfaceEntryLine: Record "Interface Entry Line INT"): Boolean
    var
        BankAcc: Record "Bank Account";
        DataExchDef: Record "Data Exch. Def";
        DataExchMapping: Record "Data Exch. Mapping";
        DataExchLineDef: Record "Data Exch. Line Def";
        ProgressWindow: Dialog;
        TempBankAccReconLine: Record "Imported Bank Stmt Line FND" temporary;
        lInterfaceEntryHeaderInsert: Record "Interface Entry Header INT";
        lDataExchInsert: Record "Data Exch.";
        lInterfaceEntryHeader: Record "Interface Entry Header INT";
    begin
        //HEI.01>>
        BankAcc.RESET;
        BankAcc.GET(BankAccRecon."Bank Account No.");
        BankAcc.GetDataExchDef(DataExchDef);

        DataExch."Related Record" := BankAcc.RECORDID;
        DataExch."Data Exch. Def Code" := DataExchDef.Code;

        IF NOT DataExch.ImportToDataExchCAM053(DataExchDef, BankAcc) THEN
            EXIT(FALSE);

        CreateBankAccRecLineTemplate(TempBankAccReconLine, BankAccRecon, DataExch);
        DataExchLineDef.SETRANGE("Data Exch. Def Code", DataExchDef.Code);
        DataExchLineDef.FINDFIRST;

        DataExchMapping.GET(DataExchDef.Code, DataExchLineDef.Code, DATABASE::"Imported Bank Stmt Line FND");

        IF DataExchMapping."Pre-Mapping Codeunit" <> 0 THEN
            CODEUNIT.RUN(DataExchMapping."Pre-Mapping Codeunit", TempBankAccReconLine);

        DataExchMapping.TESTFIELD("Mapping Codeunit");
        CODEUNIT.RUN(DataExchMapping."Mapping Codeunit", TempBankAccReconLine);

        IF DataExchMapping."Post-Mapping Codeunit" <> 0 THEN
            CODEUNIT.RUN(DataExchMapping."Post-Mapping Codeunit", TempBankAccReconLine);

        InsertNonReconciledNonImportedLines(TempBankAccReconLine, GetStatementLineNoOffset(BankAccRecon));

        EXIT(TRUE);
        //HEI.01<<
    end;

    LOCAL procedure CreateBankAccRecLineTemplate(VAR BankAccReconLine: Record "Imported Bank Stmt Line FND"; BankAccRecon: Record "Imported Bank Statements FND"; DataExch: Record "Data Exch.")
    begin
        //HEI.01>>
        BankAccReconLine.INIT;
        BankAccReconLine."Statement Type" := BankAccRecon."Statement Type";
        BankAccReconLine."Statement No." := BankAccRecon."Statement No.";
        BankAccReconLine."Bank Account No." := BankAccRecon."Bank Account No.";
        BankAccReconLine."Data Exch. Entry No." := DataExch."Entry No.";
        //HEI.01<<
    end;

    LOCAL procedure ProcessBankStatementCAMT053ToLines(VAR ImportedBankStatementsLine: Record "Imported Bank Stmt Line FND")
    var
        DataExch: Record "Data Exch.";
        ProcessDataExch: Codeunit "Process Data Exch.";
        RecRef: RecordRef;
    begin
        //HEI.01>>
        DataExch.GET(ImportedBankStatementsLine."Data Exch. Entry No.");
        RecRef.GETTABLE(ImportedBankStatementsLine);
        PreProcess(ImportedBankStatementsLine);
        ProcessDataExch.ProcessAllLinesColumnMapping(DataExch, RecRef);
        PostProcess(ImportedBankStatementsLine)
        //HEI.01<<
    end;

    LOCAL procedure PreProcess(BankAccReconciliationLine: Record "Imported Bank Stmt Line FND")
    var
        DataExch: Record "Data Exch.";
        PrePostProcessXMLImport: Codeunit "Pre & Post Process XML Import";
    begin
        //HEI.01>>
        DataExch.GET(BankAccReconciliationLine."Data Exch. Entry No.");
        PrePostProcessXMLImport.PreProcessFile(DataExch, StatementIDTxt);
        PrePostProcessXMLImport.PreProcessBankAccount(DataExch, BankAccReconciliationLine."Bank Account No.", IBANTxt, BankIDTxt, CurrencyTxt);
        //HEI.01<<
    end;

    LOCAL procedure PostProcess(BankAccReconciliationLine: Record "Imported Bank Stmt Line FND")
    var
        DataExch: Record "Data Exch.";
        BankAccReconciliation: Record "Imported Bank Statements FND";
        PrePostProcessXMLImport: Codeunit "Pre & Post Process XML Import";
        RecRef: RecordRef;
    begin
        //HEI.01>>
        DataExch.GET(BankAccReconciliationLine."Data Exch. Entry No.");
        BankAccReconciliation.GET(
          BankAccReconciliationLine."Statement Type",
          BankAccReconciliationLine."Bank Account No.",
          BankAccReconciliationLine."Statement No.");

        RecRef.GETTABLE(BankAccReconciliation);
        PrePostProcessXMLImport.PostProcessStatementEndingBalance(DataExch, RecRef,
          BankAccReconciliation.FIELDNO("Statement Ending Balance"), 'CLBD', BalTypeTxt, ClosingBalTxt, CrdDbtIndTxt, 4);
        PrePostProcessXMLImport.PostProcessStatementDate(DataExch, RecRef, BankAccReconciliation.FIELDNO("Statement Date"),
          StatementDateTxt);
        //HEI.01<<
    end;

    LOCAL procedure InsertNonReconciledNonImportedLines(VAR TempBankAccReconLine: Record "Imported Bank Stmt Line FND" TEMPORARY; StatementLineNoOffset: Integer)
    var
        BankAccReconciliationLine: Record "Imported Bank Stmt Line FND";
        LineNo: Integer;
    begin
        //HEI.01>>
        IF TempBankAccReconLine.FINDSET THEN
            REPEAT
                IF TempBankAccReconLine.CanImport THEN BEGIN
                    BankAccReconciliationLine := TempBankAccReconLine;
                    BankAccReconciliationLine."Statement Line No." += StatementLineNoOffset;
                    BankAccReconciliationLine.INSERT;
                END;
            UNTIL TempBankAccReconLine.NEXT = 0;
        //HEI.01<<
    end;

    LOCAL procedure GetStatementLineNoOffset(BankAccRecon: Record "Imported Bank Statements FND"): Integer
    var
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
    begin
        //HEI.01>>
        BankAccReconLine.SETRANGE("Statement Type", BankAccRecon."Statement Type");
        BankAccReconLine.SETRANGE("Statement No.", BankAccRecon."Statement No.");
        BankAccReconLine.SETRANGE("Bank Account No.", BankAccRecon."Bank Account No.");
        IF BankAccReconLine.FINDLAST THEN
            EXIT(BankAccReconLine."Statement Line No.");
        EXIT(0)
        //HEI.01<<
    end;

    procedure ProcessBankStatementMT940(InterfaceEntryHeader: Record "Interface Entry Header INT") ReturnValue: Text
    begin

    end;

    LOCAL procedure GetNextBankStatementNo(): Text[35]
    begin
        //HEI.01>>
        BankExportImportSetup.TESTFIELD("Bank Stat. CAMT53 No. Srs. FND");
        EXIT(NoSeriesMgt.GetNextNo(BankExportImportSetup."Bank Stat. CAMT53 No. Srs. FND", TODAY, TRUE));
        //HEI.01<<
    end;

    LOCAL procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text): Text
    var
        NewString: Text;
    begin
        //HEI.01>>
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;

        EXIT(NewString);
        //HEI.01<<
    end;

    LOCAL procedure TransformDataExchDef(VAR InterfaceEntryHeader: Record "Interface Entry Header INT"; VAR pDataExch: Record "Data Exch.")
    var
        lInterfaceEntryLine: Record "Interface Entry Line INT";
        lInStr: InStream;
        lOutputStream: OutStream;
        lNewXML: BigText;
        ltxtFromFile: Text;
        ltxtFromFile1: Text;
        lInterfaceEntryHeaderInsert: Record "Interface Entry Header INT";
        lDataExchInsert: Record "Data Exch.";
    begin
        //HEI.01>>
        lInterfaceEntryLine.RESET;
        lInterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        IF lInterfaceEntryLine.FINDFIRST THEN
            REPEAT
                lInterfaceEntryLine.CALCFIELDS(Notes);
                lInterfaceEntryLine.Notes.CREATEINSTREAM(lInStr);
                WHILE NOT lInStr.EOS DO BEGIN
                    lInStr.READTEXT(ltxtFromFile);
                    ltxtFromFile1 := ReplaceString(ltxtFromFile, '<![CDATA[', '');
                    ltxtFromFile := ltxtFromFile1;

                    ltxtFromFile1 := ReplaceString(ltxtFromFile, ']]]]>', '');
                    ltxtFromFile := ltxtFromFile1;

                    ltxtFromFile1 := ReplaceString(ltxtFromFile, ']]>', '');
                    ltxtFromFile := ltxtFromFile1;

                    lNewXML.ADDTEXT(DELCHR(ltxtFromFile, '<>', ' '));
                END;



                pDataExch."File Content".CREATEOUTSTREAM(lOutputStream, TEXTENCODING::UTF8);
                lNewXML.WRITE(lOutputStream);
                pDataExch.MODIFY;
            UNTIL lInterfaceEntryLine.NEXT = 0;
        //HEI.01<<
    end;

    LOCAL procedure TransformDataExchDefStep2(VAR InterfaceEntryHeader: Record "Interface Entry Header INT"; VAR pDataExch: Record "Data Exch."; pBankAccount: Record "Bank Account")
    begin
        //HEI.01>>
        pDataExch."Data Exch. Def Code" := pBankAccount."Bank Statement Import Format";
        pDataExch."Data Exch. Line Def Code" := pBankAccount."Bank Statement Import Format";
        pDataExch.MODIFY;
        //HEI.01<<
    end;

}
