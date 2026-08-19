pageextension 51183 CustomerPostingGroups_ExtCBN extends "Customer Posting Groups"
{


    layout
    {
        modify("Code")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies a customer posting group code.', FRA = 'Spécifie un code groupe compta. client.';
        }
        modify("Receivables Account")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the general ledger account number to post receivables from customers in this posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider les paiements des clients dans ce groupe comptabilisation.';
        }
        modify("Service Charge Acc.")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the general ledger account number to post service charges for customers in this posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider des frais forfaitaires pour les clients dans ce groupe comptabilisation.';
        }
        modify("Payment Disc. Debit Acc.")
        {
            applicationArea = All;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the general ledger account number to post payment discounts granted to customers in this posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider les escomptes accordés aux clients dans ce groupe comptabilisation.';
        }
        modify("Payment Disc. Credit Acc.")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the general ledger account number to post reductions in payment discounts granted to customers in this posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider des réductions d''escomptes accordés aux clients dans ce groupe comptabilisation.';
        }
        modify("Interest Account")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the general ledger account number to post interest from reminders and finance charge memos for customers in this posting group.', FRA = 'Spécifie le numéro du compte général dans lequel comptabiliser des intérêts à partir de relances et de factures d''intérêts pour les clients dans ce groupe comptabilisation.';
        }
        modify("Additional Fee Account")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the general ledger account number to post additional fees from reminders and finance charge memos for customers in this posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider les frais supplémentaires à partir de relances et de factures d''intérêts pour les clients dans ce groupe comptabilisation.';
        }
        modify("Add. Fee per Line Account")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            Visible = true;
            ToolTipML = ENU = 'Specifies the account that additional fees are posted to.', FRA = 'Spécifie le compte sur lequel des frais supplémentaires sont validés.';
        }
        modify("Invoice Rounding Account")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies to which account to post amounts resulting from invoice rounding when you post transactions involving customers.', FRA = 'Spécifie sur quel compte valider des montants qui résultent d''un arrondi facture lorsque vous validez des transactions impliquant des clients.';
        }
        modify("Debit Curr. Appln. Rndg. Acc.")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the general ledger account number to post rounding differences that can occur when you apply entries in different currencies to one another.', FRA = 'Spécifie le numéro du compte général dans lequel valider les différences d''arrondi qui apparaissent lorsque vous lettrez des écritures entre elles en différentes devises.';
        }
        modify("Credit Curr. Appln. Rndg. Acc.")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the general ledger account number to post rounding differences that can occur when you apply entries in different currencies to one another.', FRA = 'Spécifie le numéro du compte général dans lequel valider les différences d''arrondi qui apparaissent lorsque vous lettrez des écritures entre elles en différentes devises.';
        }
        modify("Debit Rounding Account")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the general ledger account number to post rounding differences from remaining amount.', FRA = 'Spécifie le numéro du compte général dans lequel valider les différences d''arrondi du montant ouvert.';
        }
        modify("Credit Rounding Account")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the general ledger account number to post rounding differences from remaining amount.', FRA = 'Spécifie le numéro du compte général dans lequel valider les différences d''arrondi du montant ouvert.';
        }
        modify("Payment Tolerance Debit Acc.")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            Visible = true;
            ToolTipML = ENU = 'Specifies the general ledger account number to post payment tolerance when you post payments for sales with this particular combination of business group and product group.', FRA = 'Spécifie le numéro du compte général dans lequel valider les écarts de règlement lorsque vous validez des paiements pour des ventes présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Payment Tolerance Credit Acc.")
        {
            ApplicationArea = all;//Bc Upgrade YADAVM09
            Visible = true;
            ToolTipML = ENU = 'Specifies the general ledger account number to post payment tolerance when you post payments for sales with this particular combination of business group and product group.', FRA = 'Spécifie le numéro du compte général dans lequel valider les écarts de règlement lorsque vous validez des paiements pour des ventes présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }


    }

    //Unsupported feature: PropertyChange. Please convert manually.

}

