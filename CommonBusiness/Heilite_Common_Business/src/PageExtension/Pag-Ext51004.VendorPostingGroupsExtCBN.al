pageextension 51004 VendorPostingGroupsExtCBN extends "Vendor Posting Groups"
{
    // version NAVW110.0

    //     HEI.01 FDD-HNK PTPGAP067 IBM. ISYED01 24/10/2017
    //   # Added new field NPO Prepayment Account to the page
    // HEI.02 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "CAD Account"

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a vendor posting group code.', FRA = 'Spécifie un code pour le groupe comptabilisation fournisseur.';
        }


        modify("Payables Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post payables due to vendors in this posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider des règlements dus à des fournisseurs dans ce groupe comptabilisation.';
        }
        modify("Service Charge Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post service charges due to vendors in this posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider des frais forfaitaires dus à des fournisseurs dans ce groupe comptabilisation.';
        }
        modify("Payment Disc. Debit Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post reductions in payment discounts received from vendors in this posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider des réductions d''escomptes reçues de fournisseurs dans ce groupe comptabilisation.';
        }
        modify("Payment Disc. Credit Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post payment discounts received from vendors in this posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider des escomptes reçus de fournisseurs dans ce groupe comptabilisation.';
        }
        modify("Invoice Rounding Account")
        {
            ToolTipML = ENU = 'Specifies to which account to post amounts resulting from invoice rounding when you post transactions involving vendors.', FRA = 'Spécifie sur quel compte valider des montants qui résultent d''un arrondi facture lorsque vous validez des transactions impliquant des fournisseurs.';
        }
        modify("Debit Curr. Appln. Rndg. Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post rounding differences that can occur when you apply entries in different currencies to one another.', FRA = 'Spécifie le numéro du compte général dans lequel valider les différences d''arrondi qui apparaissent lorsque vous lettrez des écritures entre elles en différentes devises.';
        }
        modify("Credit Curr. Appln. Rndg. Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post rounding differences that can occur when you apply entries in different currencies to one another.', FRA = 'Spécifie le numéro du compte général dans lequel valider les différences d''arrondi qui apparaissent lorsque vous lettrez des écritures entre elles en différentes devises.';
        }
        modify("Debit Rounding Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post rounding differences from remaining amount.', FRA = 'Spécifie le numéro du compte général dans lequel valider les différences d''arrondi du montant ouvert.';
        }
        modify("Credit Rounding Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post rounding differences from remaining amount.', FRA = 'Spécifie le numéro du compte général dans lequel valider les différences d''arrondi du montant ouvert.';
        }
        modify("Payment Tolerance Debit Acc.")
        {
            Visible = true;
            ToolTipML = ENU = 'Specifies the general ledger account number to post purchase tolerance amounts when you post payments for purchases with this particular combination of business posting group and product posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider les montants des écarts d''achat lorsque vous validez des paiements pour des achats présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Payment Tolerance Credit Acc.")
        {
            Visible = true;
            ToolTipML = ENU = 'Specifies the general ledger account number to post purchase tolerance amounts when you post payments for purchases with this particular combination of business posting group and product posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider les montants des écarts d''achat lorsque vous validez des paiements pour des achats présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        addafter("Payment Tolerance Credit Acc.")
        {
            field("Prepayment Request Account"; Rec."Prepayment Request Account FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prepayment Request Account field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Prepayment Request Account field.';

            }
            field("CAD Account"; Rec."CAD Account FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CAD Account field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the CAD Account field.';

            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

