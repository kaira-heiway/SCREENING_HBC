pageextension 51090 ExchRateAdjmtRegisterExtCBN extends "Exchange Rate Adjmt. Register"
{
    //    HEI.01 CHG2244202 IBM KAPOOV01 16.05.2024 Adjustment needed in exchange rate related tables
    //   # Added new fields:Currency Factor,Document No.,Account No.,Reversed and set visible to false.

    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the exchange rate adjustment register.', FRA = 'Spécifie le numéro de l''historique ajustement taux de change.';
        }
        modify("Creation Date")
        {
            ToolTipML = ENU = 'Specifies the posting date for the exchange rate adjustment register.', FRA = 'Spécifie la date comptabilisation de l''historique ajustement taux de change.';
        }
        modify("Account Type")
        {
            ToolTipML = ENU = 'Specifies the account type that was adjusted for exchange rate fluctuations when you ran the Adjust Exchange Rates batch job.', FRA = 'Spécifie le type de compte ajusté pour tenir compte des fluctuations de taux de change lorsque vous avez exécuté le traitement par lots Ajuster taux de change.';
        }
        modify("Posting Group")
        {
            ToolTipML = ENU = 'Specifies the posting group of the exchange rate adjustment register on this line.', FRA = 'Spécifie le groupe comptabilisation de l''historique ajustement taux de change de cette ligne.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the code for the currency whose exchange rate was adjusted.', FRA = 'Spécifie le code de la devise dont le taux de change a été ajusté.';
        }
        modify("Adjusted Base")
        {
            ToolTipML = ENU = 'Specifies the amount that was adjusted by the batch job for customer, vendor and/or bank ledger entries.', FRA = 'Spécifie le montant qui a été ajusté par le traitement par lots pour les écritures comptables client, fournisseur et/ou banque.';
        }
        modify("Adjusted Base (LCY)")
        {
            ToolTipML = ENU = 'Specifies the amount in LCY that was adjusted by the batch job for G/L, customer, vendor and/or bank ledger entries.', FRA = 'Spécifie le montant en DS qui a été ajusté par le traitement par lots pour les écritures comptables, client, fournisseur et/ou banque.';
        }
        modify("Adjusted Amt. (LCY)")
        {
            ToolTipML = ENU = 'Specifies the amount by which the batch job has adjusted G/L, customer, vendor and/or bank ledger entries for exchange rate fluctuations.', FRA = 'Spécifie le montant avec lequel le traitement par lots a ajusté les écritures comptables, client, fournisseur et/ou banque pour tenir compte des fluctuations de taux de change.';
        }
        modify("Adjusted Base (Add.-Curr.)")
        {
            ToolTipML = ENU = 'Specifies the additional-reporting-currency amount the batch job has adjusted G/L, customer, and other entries for exchange rate fluctuations.', FRA = 'Spécifie le montant en devise report avec lequel le traitement par lots a ajusté les écritures comptables, client, fournisseur et autres pour tenir compte des fluctuations de taux de change.';
        }
        modify("Adjusted Amt. (Add.-Curr.)")
        {
            ToolTipML = ENU = 'Specifies the additional-reporting-currency amount the batch job has adjusted G/L, customer, and other entries for exchange rate fluctuations.', FRA = 'Spécifie le montant en devise report avec lequel le traitement par lots a ajusté les écritures comptables, client, fournisseur et autres pour tenir compte des fluctuations de taux de change.';
        }
        addafter("Adjusted Amt. (Add.-Curr.)")
        {
            field("Currency Factor"; Rec."Currency Factor")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Currency Factor field.';
            }
            field(Reversed; Rec."Reversed FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Reversed field.';
            }
            field("Document No."; Rec."Document No. FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document No. field.';
            }
            field("Account No."; Rec."Account No. FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Account No. field.';
            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

