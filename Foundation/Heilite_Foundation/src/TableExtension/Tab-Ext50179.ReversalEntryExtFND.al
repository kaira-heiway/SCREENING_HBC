tableextension 50179 "ReversalEntryExtFND" extends "Reversal Entry"
{
    // version NAVW110.0.00.15601,DITW110.00.09,HEI.01

    // FINXL9.00.001 DAT 25/02/2016 : Extend field Description from 50 -> 80 chars

    // DITW15.00.00.24 DDR 14/08/2008 !TEMP UNTIL NEXT RELEASE: Block Reversal Entries if link to Disc/Promotion or Shipping Cost
    // DITW18.00.06 MSF 20/08/2015 DIT-770 #1494 G/L Reverse entry function has obsolete code NAV'2009 to insert reversal entries

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // DITW110.00.09 AKH 30/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // HEI.01 SOICAD01
    // HEI.02 PATHAA02
    // HEI.03 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New code added
    // HEI.04 CHG2052196 IBM PANDES01 26.10.2020
    //  # Added code for reverse entry for check ledger entry.

    fields
    {
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Entry Type")
        {
            CaptionML = ENU = 'Entry Type', FRA = 'Type écriture';
            //OptionCaptionML = ENU = ' ,G/L Account,Customer,Vendor,Bank Account,Fixed Asset,Maintenance,VAT,,,WHT', FRA = ' ,Compte général,Client,Fournisseur,Banque,Immobilisation,Maintenance,TVA,,,WHT';

            //Unsupported feature: Change OptionString on ""Entry Type"(Field 2)". Please convert manually.

        }
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("G/L Register No.")
        {
            CaptionML = ENU = 'G/L Register No.', FRA = 'N° hist. transaction compta.';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("Journal Batch Name")
        {
            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Transaction No.")
        {
            CaptionML = ENU = 'Transaction No.', FRA = 'N° transaction';
        }
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            //OptionCaptionML = ENU = ' ,Customer,Vendor,Bank Account,Fixed Asset,IC Partner', FRA = ' ,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';
        }
        modify("Source No.")
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Debit Amount")
        {
            CaptionML = ENU = 'Debit Amount', FRA = 'Montant débit';
        }
        modify("Credit Amount")
        {
            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crédit';
        }
        modify("Amount (LCY)")
        {
            CaptionML = ENU = 'Amount (LCY)', FRA = 'Montant DS';
        }
        modify("Debit Amount (LCY)")
        {
            CaptionML = ENU = 'Debit Amount (LCY)', FRA = 'Montant débit DS';
        }
        modify("Credit Amount (LCY)")
        {
            CaptionML = ENU = 'Credit Amount (LCY)', FRA = 'Montant crédit DS';
        }
        modify("VAT Amount")
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Account No.")
        {
            CaptionML = ENU = 'Account No.', FRA = 'N° compte';
        }
        modify("Account Name")
        {
            CaptionML = ENU = 'Account Name', FRA = 'Nom du compte';
        }
        modify("Bal. Account Type")
        {
            CaptionML = ENU = 'Bal. Account Type', FRA = 'Type compte contrepartie';
            //OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner', FRA = 'Général,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';
        }
        modify("Bal. Account No.")
        {
            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify("FA Posting Category")
        {
            CaptionML = ENU = 'FA Posting Category', FRA = 'Catégorie compta. immo.';
            //OptionCaptionML = ENU = ' ,Disposal,Bal. Disposal', FRA = ' ,Cession,Contrepartie cession';
        }
        modify("FA Posting Type")
        {
            CaptionML = ENU = 'FA Posting Type', FRA = 'Type compta. immo.';
            //OptionCaptionML = ENU = ' ,Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Proceeds on Disposal,Salvage Value,Gain/Loss,Book Value on Disposal', FRA = ' ,Coût acquisition,Amortissement,Dépréciation,Réévaluation,Param. 1,Param. 2,Produit de cession,Valeur résiduelle,Gain/Perte,Valeur comptable cession';
        }
        modify("Reversal Type")
        {
            CaptionML = ENU = 'Reversal Type', FRA = 'Type de contrepassation';
            OptionCaptionML = ENU = 'Transaction,Register', FRA = 'Transaction,Registre';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    var
        SourceCodeSetup: Record "Source Code Setup";
        IsExchRateAdjmt: Boolean;
        Text006_Lbl: Label 'You cannot reverse %1 No. %2 because the entry is closed.';


    //Unsupported feature: PropertyModification on "Text000(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot reverse %1 No. %2 because the entry is either applied to an entry or has been changed by a batch job.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot reverse %1 No. %2 because the entry is either applied to an entry or has been changed by a batch job.;FRA=Vous ne pouvez pas contrepasser %1 n° %2 car l'écriture est lettrée sur une écriture ou a été modifiée par un traitement par lots.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot reverse %1 No. %2 because the posting date is not within the allowed posting period.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot reverse %1 No. %2 because the posting date is not within the allowed posting period.;FRA=Vous ne pouvez pas contrepasser %1 n° %2, car la date de comptabilisation n'est pas comprise dans la période de comptabilisation autorisée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1016)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot reverse the transaction because it is out of balance.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot reverse the transaction because it is out of balance.;FRA=Vous ne pouvez pas contrepasser la transaction, car elle présente un déséquilibre.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=You cannot reverse %1 No. %2 because the entry has a related check ledger entry.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=You cannot reverse %1 No. %2 because the entry has a related check ledger entry.;FRA=Vous ne pouvez pas contrepasser %1 n° %2, car l'écriture comptable est associée à une écriture chèque.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1018)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=You can only reverse entries that were posted from a journal.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=You can only reverse entries that were posted from a journal.;FRA=Vous ne pouvez contrepasser que les écritures enregistrées à partir d'une feuille.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=You cannot reverse %1 No. %2 because the %3 is not within the allowed posting period.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=You cannot reverse %1 No. %2 because the %3 is not within the allowed posting period.;FRA=Vous ne pouvez pas contrepasser %1 n° %2, car l'/le/la %3 n'est pas compris(e) dans la période de comptabilisation autorisée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1022)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=You cannot reverse %1 No. %2 because the entry is closed.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=You cannot reverse %1 No. %2 because the entry is closed.;FRA=Vous ne pouvez pas contrepasser %1 n° %2, car l'écriture est clôturée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You cannot reverse %1 No. %2 because the entry is included in a bank account reconciliation line. The bank reconciliation has not yet been posted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You cannot reverse %1 No. %2 because the entry is included in a bank account reconciliation line. The bank reconciliation has not yet been posted.;FRA=Vous ne pouvez pas Vous ne pouvez pas contrepasser %1 n° %2, car l'écriture figure dans une ligne de rapprochement bancaire. Le rapprochement bancaire n'a pas encore été enregistré.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=You cannot reverse the transaction because the %1 has been sold.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=You cannot reverse the transaction because the %1 has been sold.;FRA=Vous ne pouvez pas contrepasser la transaction, car l'/le/la %1 a été vendu(e).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1025)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=The transaction cannot be reversed, because the %1 has been compressed or a %2 has been deleted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=The transaction cannot be reversed, because the %1 has been compressed or a %2 has been deleted.;FRA=La transaction ne peut pas être contrepassée, car l'/le/la %1 a été compressé(e) ou un/une %2 a été supprimé(e).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1023)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=You cannot reverse %1 No. %2 because the register has already been involved in a reversal.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : ENU=You cannot reverse %1 No. %2 because the register has already been involved in a reversal.;FRA=Vous ne pouvez pas contrepasser %1 n° %2, car le registre a déjà été impliqué dans une contrepassation.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1026)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=You cannot reverse %1 No. %2 because the entry has already been involved in a reversal.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=You cannot reverse %1 No. %2 because the entry has already been involved in a reversal.;FRA=Vous ne pouvez pas contrepasser %1 n° %2, car l'écriture a déjà été impliquée dans une contrepassation.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1028)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=You cannot reverse register No. %1 because it contains customer or vendor ledger entries that have been posted and applied in the same transaction.\\You must reverse each transaction in register No. %1 separately.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=You cannot reverse register No. %1 because it contains customer or vendor ledger entries that have been posted and applied in the same transaction.\\You must reverse each transaction in register No. %1 separately.;FRA=Vous ne pouvez pas contrepasser le registre n° %1 car il contient des écritures comptables client et fournisseur ayant été validées et appliquées dans la même transaction.\\Vous devez contrepasser les transactions du registre N° %1 une par une.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text013(Variable 1039)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=You cannot reverse %1 No. %2 because the entry has an associated Realized Gain/Loss entry.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=You cannot reverse %1 No. %2 because the entry has an associated Realized Gain/Loss entry.;FRA=Vous ne pouvez pas contrepasser %1 n° %2 car l'écriture est associée à une écriture gain/perte réalisée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "UnrealizedVATReverseErr(Variable 1027)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //UnrealizedVATReverseErr : ENU=You cannot reverse %1 No. %2 because the entry has an associated Unrealized VAT Entry.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UnrealizedVATReverseErr : ENU=You cannot reverse %1 No. %2 because the entry has an associated Unrealized VAT Entry.;FRA=Vous ne pouvez pas contrepasser %1 n° %2 car l'écriture est associée à une écriture TVA sur encaissement.;
    //Variable type has not been exported.

    var
        WHTEntry: Record "WHT Entry FND";

    var
        //BC Upgrade POENAB02 >>
        //Variables belong to Aptean. Code is commented.
        /*
        rSalesDiscPromoEntry: Record "Sales Discount.-Promo. Entry";
        rGLShipCostLedgRelation: Record "G/L - Ship Cost Ldg. Relation";
        rShipCostEntry: Record "Shipping Hdr-Whse. Entry";
        */
        //BC Upgrade POENAB02 <<
        CompanyInfo: Record "Company Information";

    // Already defined in base and whole code is also blocked excepct variable description and has no reference.
    // procedure CheckEntries()
    // var
    //     DateComprReg: Record "Date Compr. Register";
    //     DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    //     DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
    //     GLAcc: Record "G/L Account";
    //     BalanceCheckAddCurrAmount: Decimal;
    //     BalanceCheckAmount: Decimal;
    // begin
    //     //BC Upgrade POENAB02 >>
    //     //Function below contains standard code and Aptean code. It is commented, 
    //     //as the Aptean code should be analyzed and should be part of the Aptean extension        
    //     /*
    //     DtldCustLedgEntry.LOCKTABLE;
    //     DtldVendLedgEntry.LOCKTABLE;
    //     GLEntry.LOCKTABLE;
    //     CustLedgEntry.LOCKTABLE;
    //     VendLedgEntry.LOCKTABLE;
    //     BankAccLedgEntry.LOCKTABLE;
    //     FALedgEntry.LOCKTABLE;
    //     MaintenanceLedgEntry.LOCKTABLE;
    //     VATEntry.LOCKTABLE;
    //     WHTEntry.LOCKTABLE;
    //     GLReg.LOCKTABLE;
    //     FAReg.LOCKTABLE;
    //     GLSetup.GET;
    //     MaxPostingDate := 0D;
    //     IF NOT GLEntry.FIND('-') THEN
    //         ERROR(Text009, GLEntry.TABLECAPTION, GLAcc.TABLECAPTION);
    //     IF GLEntry.FIND('-') THEN BEGIN
    //         IF GLEntry."Journal Batch Name" = '' THEN
    //             TestFieldError;
    //         REPEAT
    //             CheckGLAcc(GLEntry, BalanceCheckAmount, BalanceCheckAddCurrAmount);
    //         UNTIL GLEntry.NEXT = 0;
    //     end;
    //     IF (BalanceCheckAmount <> 0) OR (BalanceCheckAddCurrAmount <> 0) THEN
    //         ERROR(Text002);

    //     IF CustLedgEntry.FIND('-') THEN
    //         REPEAT
    //             CheckCust(CustLedgEntry);
    //         UNTIL CustLedgEntry.NEXT = 0;

    //     IF VendLedgEntry.FIND('-') THEN
    //         REPEAT
    //             CheckVend(VendLedgEntry);
    //         UNTIL VendLedgEntry.NEXT = 0;

    //     IF BankAccLedgEntry.FIND('-') THEN
    //         REPEAT
    //             CheckBankAcc(BankAccLedgEntry);
    //         UNTIL BankAccLedgEntry.NEXT = 0;

    //     IF FALedgEntry.FIND('-') THEN
    //         REPEAT
    //             CheckFA(FALedgEntry);
    //         UNTIL FALedgEntry.NEXT = 0;

    //     IF MaintenanceLedgEntry.FIND('-') THEN
    //         REPEAT
    //             CheckMaintenance(MaintenanceLedgEntry);
    //         UNTIL MaintenanceLedgEntry.NEXT = 0;

    //     IF VATEntry.FIND('-') THEN
    //         REPEAT
    //             CheckVAT(VATEntry);
    //         UNTIL VATEntry.NEXT = 0;
    //     IF WHTEntry.FIND('-') THEN
    //         REPEAT
    //             CheckWHT(WHTEntry);
    //         UNTIL WHTEntry.NEXT = 0;
    //     DateComprReg.CheckMaxDateCompressed(MaxPostingDate, 1);

    //     // <<DITW15.00.00.24 DDR 14/08/2008 TEMP
    //     rSalesDiscPromoEntry.SETCURRENTKEY("G/L Entry No.");
    //     IF GLEntry.FINDFIRST THEN
    //         REPEAT
    //             rSalesDiscPromoEntry.SETRANGE("G/L Entry No.", GLEntry."Entry No.");
    //             IF rSalesDiscPromoEntry.FINDFIRST THEN
    //                 rSalesDiscPromoEntry.FIELDERROR("G/L Entry No.");

    //             rGLShipCostLedgRelation.SETRANGE("G/L Entry No.", GLEntry."Entry No.");
    //             IF rGLShipCostLedgRelation.FINDFIRST THEN BEGIN
    //                 rShipCostEntry.GET(rGLShipCostLedgRelation."Shipping Entry No.");
    //                 rShipCostEntry.FIELDERROR("Entry No.");
    //             end;
    //         UNTIL GLEntry.NEXT = 0;
    //     // >>DITW15.00.00.24 DDR
    //     */
    //     //BC Upgrade POENAB02 <<        
    // end;

    procedure ReverseTransactionforchecks(TransactionNo: Integer)
    begin
        //>>HEI.04
        ReverseEntriesforchecks(TransactionNo, "Reversal Type"::Transaction);
        //<<HEI.04
    end;

    //BC UPGRADE GUPTAK03 WHT functions migrated -->>
    PROCEDURE CheckWHT(WHTEntry: Record "WHT Entry FND");
    BEGIN
        CheckPostingDate(
          WHTEntry."Posting Date", WHTEntry.TABLECAPTION, WHTEntry."Entry No.");
        IF WHTEntry.Closed THEN
            ERROR(
              Text006_Lbl, WHTEntry.TABLECAPTION, WHTEntry."Entry No.");
        IF WHTEntry.Reversed THEN
            AlreadyReversedEntry(WHTEntry.TABLECAPTION, WHTEntry."Entry No.");
    END;

    PROCEDURE InsertFromWHTEntry(var TempRevertTransactionNo: Record Integer temporary; Number: Integer; RevType: Option Transaction,Register; VAR NextLineNo: Integer);
    BEGIN
        TempRevertTransactionNo.FINDSET();
        REPEAT
            IF RevType = RevType::Transaction THEN
                WHTEntry.SETRANGE("Transaction No.", TempRevertTransactionNo.Number);
            IF WHTEntry.FIND('-') THEN
                REPEAT
                    CLEAR(TempReversalEntry);
                    IF RevType = RevType::Register THEN
                        TempReversalEntry."G/L Register No." := Number;
                    TempReversalEntry."Reversal Type" := RevType;
                    TempReversalEntry."Entry Type" := TempReversalEntry."Entry Type"::WHT;
                    TempReversalEntry."Entry No." := WHTEntry."Entry No.";
                    TempReversalEntry."Posting Date" := WHTEntry."Posting Date";
                    TempReversalEntry."Source Code" := WHTEntry."Source Code";
                    TempReversalEntry."Transaction No." := WHTEntry."Transaction No.";
                    TempReversalEntry.Amount := WHTEntry.Amount;
                    TempReversalEntry."Amount (LCY)" := WHTEntry.Amount;
                    TempReversalEntry."Document Type" := WHTEntry."Document Type";
                    TempReversalEntry."Document No." := WHTEntry."Document No.";
                    TempReversalEntry."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + 1;
                    TempReversalEntry.INSERT();
                UNTIL WHTEntry.NEXT() = 0;
        UNTIL TempRevertTransactionNo.NEXT() = 0;
    END;
    //BC UPGRADE GUPTAK03 WHT functions migrated --<<

    local procedure ReverseEntriesforchecks(Number: Integer; RevType: Option Transaction,Register)
    var
        ReversalPost: Codeunit "Reversal-Post";
    begin
        //>>HEI.04
        InsertReversalEntry(Number, RevType);
        TempReversalEntry.SetCurrentKey("Document No.", "Posting Date", "Entry Type", "Entry No.");
        //IF NOT HideDialog THEN
        // PAGE.RUNMODAL(PAGE::"Reverse Entries",TempReversalEntry)
        //else BEGIN
        ReversalPost.SetPrint(FALSE);
        ReversalPost.SetHideDialog(TRUE);
        ReversalPost.Run(TempReversalEntry);
        //end;
        TempReversalEntry.DeleteAll();
        //<<HEI.04
    end;
}