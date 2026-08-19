tableextension 50206 AppliedPaymentEntryExtFND extends "Applied Payment Entry"
{
    // version NAVW110.0.00.16996
    //-----------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 02.12.2025 #Commented OptionCaptionML property for fields-Statement Type,Account Type,Document Type,Match Confidence.
    //BC Upgrade KAPOOV01 02.12.2025 #Created new procedure-GetRemAmt2() and for this procedure added three functions-GetCustLedgEntryRemAmt2, GetVendLedgEntryRemAmt2,GetBankAccLedgEntryRemAmt.
    //BC Upgrade KAPOOV01 02.12.2025 #Created new function -OnGetCustLedgEntryRemAmtOnBeforeCalcFields and subscribed it to event-OnGetCustLedgEntryRemAmtOnBeforeCalcFields for function-GetCustLedgEntryRemAmt related customization. 
    //BC Upgrade KAPOOV01 02.12.2025 #Created new function -OnGetVendLedgEntryRemAmtOnBeforeCalcFields and subscribed it to event-OnGetVendLedgEntryRemAmtOnBeforeCalcFields for function-GetVendLedgEntryRemAmt related customization.
    //BC Upgrade KAPOOV01 02.12.2025 #Created new function -OnUpdateParentBankAccReconLineOnBeforeBankAccReconLineModify for function-UpdateParentBankAccReconLine related customization.




    fields
    {
        modify("Bank Account No.")
        {
            CaptionML = ENU = 'Bank Account No.', FRA = 'N° compte bancaire';
        }
        modify("Statement No.")
        {
            CaptionML = ENU = 'Statement No.', FRA = 'N° relevé';
        }
        modify("Statement Line No.")
        {
            CaptionML = ENU = 'Statement Line No.', FRA = 'N° ligne relevé';
        }
        modify("Statement Type")
        {
            CaptionML = ENU = 'Statement Type', FRA = 'Type relevé';
            //OptionCaptionML = ENU = 'Bank Reconciliation,Payment Application', FRA = 'Rapprochement bancaire,Lettrage paiement'; //BC Upgrade KAPOOV01 commented OptionCaptionML property

        }
        modify("Account Type")
        {
            CaptionML = ENU = 'Account Type', FRA = 'Type compte';
            //OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner', FRA = 'Général,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';//BC Upgrade KAPOOV01 commented OptionCaptionML property

        }
        modify("Account No.")
        {
            CaptionML = ENU = 'Account No.', FRA = 'N° compte';
        }
        modify("Applies-to Entry No.")
        {

            //Unsupported feature: Change TableRelation on ""Applies-to Entry No."(Field 23)". Please convert manually.

            CaptionML = ENU = 'Applies-to Entry No.', FRA = 'N° séquence lettrage';
        }
        modify("Applied Amount")
        {
            CaptionML = ENU = 'Applied Amount', FRA = 'Montant lettré';
        }
        modify("Applied Pmt. Discount")
        {
            CaptionML = ENU = 'Applied Pmt. Discount', FRA = 'Escompte lettré';
        }
        modify(Quality)
        {
            CaptionML = ENU = 'Quality', FRA = 'Qualité';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement'; //BC Upgrade KAPOOV01 commented OptionCaptionML property
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Délai';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify("Match Confidence")
        {
            CaptionML = ENU = 'Match Confidence', FRA = 'Fiabilité correspondance';
            //OptionCaptionML = ENU = 'None,Low,Medium,High,High - Text-to-Account Mapping,Manual,Accepted', FRA = 'Aucune,Faible,Moyenne,Élevée,Élevée - Correspondance texte et compte,Manuelle,Acceptée'; //BC Upgrade KAPOOV01 commented OptionCaptionML property
        }

        //Unsupported feature: CodeModification on ""Applied Amount"(Field 24).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Applies-to Entry No." <> 0 then
          TESTFIELD("Applied Amount");
        CheckEntryAmt;
        UpdatePaymentDiscount(SuggestDiscToApply(true));
        if "Applied Pmt. Discount" <> 0 then
          "Applied Amount" := SuggestAmtToApply;

        UpdateParentBankAccReconLine(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.01 delete
        // IF "Applies-to Entry No." <> 0 THEN
        //  TESTFIELD("Applied Amount");

        CheckEntryAmt;
        //HEI.01 delete UpdatePaymentDiscount(SuggestDiscToApply(TRUE));
        UpdatePaymentDiscount(SuggestDiscToApply(false));///HEI.01
        #5..8
        */
        //end;
        field(50567; "Rem. Amount FND"; Decimal)
        {
            Caption = 'Rem. Amount';
        }
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""Statement Type","Bank Account No.","Statement No.","Statement Line No.","Account Type","Account No.","Applies-to Entry No."(Key)". Please convert manually.

    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Applies-to Entry No." <> 0 then
      TESTFIELD("Applied Amount");

    CheckApplnIsSameAcc;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //HEI.01 delete
    // IF "Applies-to Entry No." <> 0 THEN
    //  TESTFIELD("Applied Amount");

    CheckApplnIsSameAcc;
    */
    //end;

    //Unsupported feature: PropertyChange. Please convert manually.

    //BC Upgrade KAPOOV01>>
    procedure GetRemAmt2(): Decimal
    var
        myInt: Integer;
    begin
        //HEI.01>>
        IF "Account No." = '' THEN
            EXIT(0);
        IF "Applies-to Entry No." = 0 THEN
            EXIT(GetStmtLineRemAmtToApply());

        CASE "Account Type" OF
            "Account Type"::Customer:
                EXIT(GetCustLedgEntryRemAmt2());
            "Account Type"::Vendor:
                EXIT(GetVendLedgEntryRemAmt2());
            "Account Type"::"Bank Account":
                EXIT(GetBankAccLedgEntryRemAmt());

        end;
        //HEI.01<<
    end;

    local procedure GetCustLedgEntryRemAmt2(): Decimal
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        //soicad>>
        CustLedgEntry.GET("Applies-to Entry No.");
        IF IsBankLCY() AND (CustLedgEntry."Currency Code" <> '') THEN BEGIN
            CustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
            EXIT(CustLedgEntry."Remaining Amt. (LCY)");
        end;
        CustLedgEntry.CALCFIELDS("Remaining Amount");
        EXIT(CustLedgEntry."Remaining Amount");
        //soicad<<
    end;

    local procedure IsBankLCY(): Boolean
    var
        BankAcc: Record "Bank Account";
    begin
        BankAcc.GET("Bank Account No.");
        EXIT(BankAcc.IsInLocalCurrency());
    end;

    local procedure GetVendLedgEntryRemAmt2(): Decimal
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        //soicad<<
        VendLedgEntry.GET("Applies-to Entry No.");
        IF IsBankLCY() AND (VendLedgEntry."Currency Code" <> '') THEN BEGIN
            VendLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
            EXIT(VendLedgEntry."Remaining Amt. (LCY)");
        end;
        VendLedgEntry.CALCFIELDS("Remaining Amount");
        EXIT(VendLedgEntry."Remaining Amount");
        //soicad<<
    end;

    local procedure GetBankAccLedgEntryRemAmt(): Decimal
    var
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccLedgEntry.GET("Applies-to Entry No.");
        IF IsBankLCY() THEN
            EXIT(
              ROUND(
                BankAccLedgEntry."Remaining Amount" *
                BankAccLedgEntry."Amount (LCY)" / BankAccLedgEntry.Amount));
        EXIT(BankAccLedgEntry."Remaining Amount");
    end;

    //BC Upgrade KAPOOV01<<


    var
        CLE: Record "Cust. Ledger Entry";


    //Unsupported feature: PropertyModification on "CurrencyMismatchErr(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CurrencyMismatchErr : ENU=Currency codes on bank account %1 and ledger entry %2 do not match.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CurrencyMismatchErr : ENU=Currency codes on bank account %1 and ledger entry %2 do not match.;FRA=Les codes devise sur le compte bancaire %1 et l'écriture comptable %2 ne correspondent pas.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "AmtCannotExceedErr(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //AmtCannotExceedErr : ENU=The Amount to Apply cannot exceed %1. This is because the Remaining Amount on the entry is %2 and the amount assigned to other statement lines is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AmtCannotExceedErr : ENU=The Amount to Apply cannot exceed %1. This is because the Remaining Amount on the entry is %2 and the amount assigned to other statement lines is %3.;FRA=Le montant à lettrer ne peut pas dépasser %1. En effet, le montant ouvert sur l'écriture est %2 et le montant affecté à d'autres lignes relevé est %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotApplyStmtLineErr(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotApplyStmtLineErr : @@@="%1 = Account Type, %2 = Account No., %3 = Account Type, %4 = Account No.";ENU=You cannot apply to %1 %2 because the statement line already contains an application to %3 %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotApplyStmtLineErr : @@@="%1 = Account Type, %2 = Account No., %3 = Account Type, %4 = Account No.";ENU=You cannot apply to %1 %2 because the statement line already contains an application to %3 %4.;FRA=Il est impossible de lettrer avec %1 %2 car la ligne relevé contient déjà un lettrage avec %3 %4.;
    //Variable type has not been exported.
}

