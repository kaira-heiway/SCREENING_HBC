pageextension 51020 GeneralPostingSetupCardExtCBN extends "General Posting Setup Card"
{
    // version NAVW110.0,DITW110.00.11,HEI.06

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general business posting group that applies to the entry.', FRA = 'Spécifie le groupe comptabilisation marché qui s''applique à cette écriture.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a general product posting group.', FRA = 'Spécifie un groupe comptabilisation produit.';
        }
        modify(Sales)
        {
            CaptionML = ENU = 'Sales', FRA = 'Ventes';
        }
        modify("Sales Account")
        {
            ToolTipML = ENU = 'Specifies the number of the general ledger sales account to which the program will post sales transactions with this particular combination of business group and product group.', FRA = 'Spécifie le numéro du compte vente général sur lequel le programme valide des transactions de vente présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Sales Credit Memo Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which the program will post transactions involving sales credit memos for this particular combination of business posting group and product posting group.', FRA = 'Spécifie le numéro du compte général sur lequel le programme valide des transactions impliquant des avoirs vente pour cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Sales Line Disc. Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post customer/item and quantity discounts when you post sales transactions with this particular combination of business group and product group.', FRA = 'Spécifie le numéro du compte général dans lequel valider les remises client/article et les remises quantité lorsque vous validez des transactions pour des ventes présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Sales Inv. Disc. Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post sales invoice discount amounts when you post sales transactions for this particular combination of business group and product group.', FRA = 'Spécifie le numéro du compte général dans lequel valider des montants d''escompte de facture vente lorsque vous validez des transactions pour des ventes présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Sales Pmt. Disc. Debit Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post granted sales payment discount amounts when you post payments for sales with this particular combination of business group and product group.', FRA = 'Spécifie le numéro du compte général dans lequel valider les montants des escomptes de vente accordés lorsque vous validez des paiements pour des ventes présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Sales Pmt. Disc. Credit Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post reductions in sales payment discount amounts when you post payments for sales with this particular combination of business group and product group.', FRA = 'Spécifie le numéro du compte général dans lequel valider des réductions des montants des escomptes de vente lorsque vous validez des paiements pour des ventes présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Sales Pmt. Tol. Debit Acc.")
        {
            ToolTipML = ENU = 'Specifies the number of the G/L account to which you want the program to post payment tolerance for purchases with this combination.', FRA = 'Spécifie le numéro du compte général sur lequel vous voulez que le programme valide un écart de règlement pour des achats présentant cette combinaison.';
        }
        modify("Sales Pmt. Tol. Credit Acc.")
        {
            ToolTipML = ENU = 'Specifies the number of the G/L account to which you want the program to post payment tolerance for purchases with this combination.', FRA = 'Spécifie le numéro du compte général sur lequel vous voulez que le programme valide un écart de règlement pour des achats présentant cette combinaison.';
        }
        modify("Sales Prepayments Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post sales prepayment amounts when you post prepayment invoices from a sales order for this particular combination of business group and product group.', FRA = 'Spécifie le numéro du compte général dans lequel valider des montants acomptes vente lorsque vous validez des factures d''acompte d''une commande vente présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify(Purchases)
        {
            CaptionML = ENU = 'Purchases', FRA = 'Achats';
        }
        modify("Purch. Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which the program will post purchase transactions with this particular combination of business posting group and product posting group.', FRA = 'Spécifie le numéro du compte général sur lequel le programme valide des transactions d''achat présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Purch. Credit Memo Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which the program will post transactions involving purchase credit memos for this particular combination of business posting group and product posting group.', FRA = 'Spécifie le numéro du compte général sur lequel le programme valide des transactions impliquant des avoirs achat pour cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Purch. Line Disc. Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post purchase line discount amounts with this particular combination of business group and product group.', FRA = 'Spécifie le numéro du compte vente général sur lequel valider des montants de remise ligne achat présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Purch. Inv. Disc. Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post purchase invoice discount amounts with this particular combination of business group and product group.', FRA = 'Spécifie le numéro du compte vente général sur lequel valider des montants de remise facture achat présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Purch. Pmt. Disc. Debit Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post reductions in purchase payment discount amounts when you post payments for purchases with this particular combination of business posting group and product posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider des réduction des montants des escomptes achat accordés lorsque vous validez des paiements pour des achats présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Purch. Pmt. Disc. Credit Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post received purchase payment discount amounts when you post payments for purchases with this particular combination of business posting group and product posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider des montants des escomptes achat reçus lorsque vous validez des paiements pour des achats présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Purch. FA Disc. Account")
        {
            ToolTipML = ENU = 'Specifies the account that the line and invoice discount will be posted to when the Subtract Disc. in Purch. Inv. field is check marked.', FRA = 'Spécifie le compte dans lequel la remise ligne et la remise facture sont validées si le champ Déduire remise dans fact. achat est sélectionné.';
        }
        modify("Purch. Pmt. Tol. Debit Acc.")
        {
            ToolTipML = ENU = 'Specifies the number of the G/L account to which you want the program to post payment tolerance for purchases with this combination.', FRA = 'Spécifie le numéro du compte général sur lequel vous voulez que le programme valide un écart de règlement pour des achats présentant cette combinaison.';
        }
        modify("Purch. Pmt. Tol. Credit Acc.")
        {
            ToolTipML = ENU = 'Specifies the number of the G/L account to which you want the program to post payment tolerance for purchases with this combination.', FRA = 'Spécifie le numéro du compte général sur lequel vous voulez que le programme valide un écart de règlement pour des achats présentant cette combinaison.';
        }
        modify("Purch. Prepayments Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post purchase prepayment amounts when you post prepayment invoices from a purchase order for this particular combination of business group and product group.', FRA = 'Spécifie le numéro du compte général dans lequel valider des montants acomptes achat lorsque vous validez des factures d''acompte d''une commande achat présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify(Inventory)
        {
            CaptionML = ENU = 'Inventory', FRA = 'Stocks';
        }
        modify("COGS Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post the cost of goods sold with this particular combination of business group and product group.', FRA = 'Spécifie le numéro du compte général sur lequel valider le coût des marchandises vendues présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("COGS Account (Interim)")
        {
            ToolTipML = ENU = 'Specifies the interim G/L account number to which you want the program to post the expected cost of goods sold.', FRA = 'Spécifie le numéro du compte général en attente dans lequel vous souhaitez que le programme valide le coût prévu des marchandises vendues.';
        }
        modify("Inventory Adjmt. Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post inventory adjustments (positive and negative) with this particular combination of business posting group and product posting group.', FRA = 'Spécifie le numéro du compte général sur lequel valider des ajustements de stock (positifs et négatifs) présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Invt. Accrual Acc. (Interim)")
        {
            ToolTipML = ENU = 'Specifies the number of the G/L account to which you want the program to post expected inventory adjustments (positive and negative).', FRA = 'Spécifie le numéro du compte général dans lequel vous souhaitez que le programme valide les ajustements stock prévus (positifs et négatifs).';
        }
        modify("Direct Cost Applied Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post the direct cost applied with this particular combination of business posting group and product posting group.', FRA = 'Spécifie le numéro du compte général sur lequel valider le coût direct appliqué avec cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Overhead Applied Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post the direct cost applied with this particular combination of business posting group and product posting group.', FRA = 'Spécifie le numéro du compte général sur lequel valider le coût direct appliqué avec cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Purchase Variance Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post the direct cost applied with this particular combination of business posting group and product posting group.', FRA = 'Spécifie le numéro du compte général sur lequel valider le coût direct appliqué avec cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        addafter("Sales Prepayments Account")
        {
            field("Sales Resource Cost Acc."; Rec."Sales Resource Cost Acc. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Resource Cost Account field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Sales Resource Cost Account field.';

            }
        }
        addafter("Invt. Accrual Acc. (Interim)")
        {
            field("Accrual Acc. (Interim)"; Rec."Accrual Acc. (Interim) FND")
            {
                CaptionML = ENU = 'Accrual Acc. (Interim)',
                            FRA = 'FNP pour comptes généraux  (attente)';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Accrual Acc. (Interim) field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Accrual Acc. (Interim) field.';

            }
        }
        addafter("Overhead Applied Account")
        {
            field("Accrual Account Landed Cost"; Rec."Accrual Acc. Landed Cost FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Accrual Account Landed Cost field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Accrual Account Landed Cost field.';

            }
        }
        addafter("Purchase Variance Account")
        {
            field("PPV Adjustment Account"; Rec."PPV Adjustment Account FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PPV Adjustment Account field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the PPV Adjustment Account field.';

            }
            // group("Drink-It")
            // {
            //     CaptionML = ENU='Drink-It',
            //                 FRA='Drink-It';
            //     field("Sales Provision Account";Rec."Sales Provision Account")
            //     {
            //     }
            //     field("Sales Accrual Provision Acc.";Rec."Sales Accrual Provision Acc.")
            //     {
            //     }
            //     field("Sales Tax Recover Account";Rec."Sales Tax Recover Account")
            //     {
            //     }
            //     field("Sales Tax Due Account";"Sales Tax Due Account")
            //     {
            //     }
            //     field("Internal Tax Due Account";"Internal Tax Due Account")
            //     {
            //     }
            //     field("Internal Tax Recover Account";"Internal Tax Recover Account")
            //     {
            //     }
            //     field("Purch. Provision Account";"Purch. Provision Account")
            //     {
            //     }
            //     field("Purch. Accrual Provision Acc.";"Purch. Accrual Provision Acc.")
            //     {
            //     }
            //     field("Purch. Tax Recover Account";"Purch. Tax Recover Account")
            //     {
            //     }
            //     field("Purch. Tax Due Account";"Purch. Tax Due Account")
            //     {
            //     }
            //     field("Deposit In Goods Sold Acc.";"Deposit In Goods Sold Acc.")
            //     {
            //     }
            //     field("Deposit IGS Acc. (Interim)";"Deposit IGS Acc. (Interim)")
            //     {
            //     }
            //     field("Direct Deposit Applied Account";"Direct Deposit Applied Account")
            //     {
            //     }
            //     field("Deposit Accrual Acc. (Int.)";"Deposit Accrual Acc. (Int.)")
            //     {
            //     }
            //     field("Deposit Adjustment Acc.";"Deposit Adjustment Acc.")
            //     {
            //     }
            //     field("VAT on Free Expense Account";"VAT on Free Expense Account")
            //     {
            //     }
            //     field("Cost of Free Goods (HNK)";"Cost of Free Goods (HNK)")
            //     {
            //     }
            //     field("HNK Free Goods Offset Acc.";"HNK Free Goods Offset Acc.")
            //     {
            //     }
            // }  // BC Upgrade NANDIS03
        }
    }
    actions
    {
        modify(Copy)
        {
            CaptionML = ENU = '&Copy', FRA = '&Copier';
            ToolTipML = ENU = 'Copy a record with selected fields or all fields from the general posting setup to a new record. Before you start to copy you have to create the new record.', FRA = 'Copiez un enregistrement qui comporte des champs sélectionnés ou tous les champs des paramètres comptabilisation vers un nouvel enregistrement. Avant de commencer à copier, vous devez créer un enregistrement.';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

