codeunit 58119 "Imp. SEPA CAMT Bank Rec. BC"
{
    // version BC

    // HEI.01 CHG2020184 IBM POENAB02 26.06.2019
    //   # New codeunit for Bank Connectivity interface

    //BC UPGRADE KUMARR78 >>
    // 1. Codeunit ID Modification
    // ---------------------------------------------------------------------------
    // Old:
    //   Codeunit 50089 "Imp. SEPA CAMT Bank Rec. BC"
    //
    // New:
    //   Codeunit 58119 "Imp. SEPA CAMT Bank Rec. BC"
    //
    // ---------------------------------------------------------------------------
    // Old Code:
    //   DataExch.GET("Data Exch. Entry No.");
    //
    // New Code:
    //   DataExch.GET(Rec."Data Exch. Entry No.");
    //
    // 3. Variable Handling Standardization
    // ---------------------------------------------------------------------------
    // Old Pattern:
    //   Variable ID-based references and implicit context usage.
    //
    // New Pattern:
    //   Replaced variable ID references with explicit variable names.
    //BC UPGRADE KUMARR78 <<

    // BC UPGRADE PATELS08 >>
    // # Table name changed from Imported Bank Statements to Imported Bank Statements FND.
    // BC UPGRADE PATELS08 <<

    // BC Upgrade PATELP08>>
    // Changed name of table from "Imported Bank Statements Line" to "Imported Bank Stmt Line FND"
    // BC Upgrade PATELP08<<

    TableNo = "Imported Bank Stmt Line FND";

    trigger OnRun();
    var
        DataExch: Record "Data Exch.";
        ProcessDataExch: Codeunit "Process Data Exch.";
        RecRef: RecordRef;
    begin
        //HEI.01>>
        DataExch.GET(Rec."Data Exch. Entry No.");//BC UPGRADE KUMARR78 Adding Rec. in Get statement.
        RecRef.GETTABLE(Rec);
        PreProcess(Rec);
        ProcessDataExch.ProcessAllLinesColumnMapping(DataExch, RecRef);
        PostProcess(Rec)
        //HEI.01<<
    end;

    var
        StatementIDTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Id', FRA = '/Document/BkToCstmrStmt/Stmt/Id';
        IBANTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Acct/Id/IBAN', FRA = '/Document/BkToCstmrStmt/Stmt/Acct/Id/IBAN';
        CurrencyTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Bal/Amt[@Ccy]', FRA = '/Document/BkToCstmrStmt/Stmt/Bal/Amt[@Ccy]';
        BalTypeTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Bal/Tp/CdOrPrtry/Cd', FRA = '/Document/BkToCstmrStmt/Stmt/Bal/Tp/CdOrPrtry/Cd';
        ClosingBalTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Bal/Amt', FRA = '/Document/BkToCstmrStmt/Stmt/Bal/Amt';
        StatementDateTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/CreDtTm', FRA = '/Document/BkToCstmrStmt/Stmt/CreDtTm';
        CrdDbtIndTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Bal/CdtDbtInd', FRA = '/Document/BkToCstmrStmt/Stmt/Bal/CdtDbtInd';
        BankIDTxt: TextConst Comment = '{Locked}', ENU = '/Document/BkToCstmrStmt/Stmt/Acct/Id/Othr/Id', FRA = '/Document/BkToCstmrStmt/Stmt/Acct/Id/Othr/Id';

    local procedure PreProcess(BankAccReconciliationLine: Record "Imported Bank Stmt Line FND");
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

    local procedure PostProcess(BankAccReconciliationLine: Record "Imported Bank Stmt Line FND");
    var
        DataExch: Record "Data Exch.";
        BankAccReconciliation: Record "Imported Bank Statements FND";
        PrePostProcessXMLImport: Codeunit "Pre & Post Process XML Import";
        RecRef: RecordRef;
        lInterfaceEntryHeaderInsert: Record "Interface Entry Header INT";
        lDataExchInsert: Record "Data Exch.";
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
}

