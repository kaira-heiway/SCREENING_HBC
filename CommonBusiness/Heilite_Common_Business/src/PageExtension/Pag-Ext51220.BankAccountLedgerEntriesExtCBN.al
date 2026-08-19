pageextension 51220 BankAccountLedgerEntriesExtCBN extends "Bank Account Ledger Entries"
{
    // version NAVW110.0,HEI.01
    //  HEI.01 Defect116(NavBugFix)- IBM PATHAA02 19.09.17 Added comment field
    //   HEI.02 CHG2024918 IBM POENAB02 16.09.2019 La R‚union_France Fiscal Year Closing
    //     # Code added in trigger OnOpenPage
    //     # New fields: "Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)"
    //   HEI.03 CHG2020184 IBM POENAB02 26.06.2019
    //     # New fields added: "Closed at Date", "Statement No.", "Statement No. Imported"

    //   HEI.04 FDD-HT626 IBM SURYAS01 16-12-2019 Bank Connection Setup_La R‚union
    //     #New Field's added: "Transaction Code" & "Exported"
    //   HEI.05 FDD-HB1834 IBM SURYAS01 24-11-2020
    //    # Added field : "Document Date"
    //*********************************************//
    //BC UPGRADE SIVA//
    //1.HEI.01 Added comment field in page layout.
    //2.HEI.02 Commented FrenchLocalization code.
    //3.HEI.03 Added "Closed at Date", "Statement No.", "Statement No. Imported" fields on page layout
    //4.HEI.04 Added "Transaction Code" & "Exported" on page layout
    //5.HEI.05 Added "Document Date" on page layout.
    layout
    {
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date for the entry.', FRA = 'Spécifie la date comptabilisation de l''écriture.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the document type on the bank account entry. The document type will be Payment, Refund, or the field will be blank.', FRA = 'Spécifie le type de document de l''écriture compte bancaire. Le type de document peut être Paiement ou Remboursement, ou le champ peut être vierge.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number on the bank account entry.', FRA = 'Spécifie le numéro de document de l''écriture compte bancaire.';
        }
        modify("Bank Account No.")
        {
            ToolTipML = ENU = 'Specifies the number of the bank account used for the entry.', FRA = 'Spécifie le numéro du compte bancaire utilisé pour l''écriture.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the bank account entry.', FRA = 'Spécifie la description de l''écriture compte bancaire.';
        }
        modify("Global Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension value linked to the entry.', FRA = 'Spécifie le code de la valeur dimension liée à l''écriture.';
        }
        modify("Global Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension value linked to the entry.', FRA = 'Spécifie le code de la valeur dimension liée à l''écriture.';
        }
        modify("Our Contact Code")
        {
            ToolTipML = ENU = 'Specifies the code for the employee who is responsible for the bank account.', FRA = 'Spécifie le code de l''employé responsable du compte bancaire.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code used in the entry.', FRA = 'Spécifie le code devise utilisé pour l''écriture.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the amount of the entry denominated in the applicable foreign currency.', FRA = 'Spécifie le montant de l''écriture dans la devise étrangère applicable.';
        }
        modify("Amount (LCY)")
        {
            ToolTipML = ENU = 'Specifies the amount of the entry in LCY.', FRA = 'Spécifie le montant de l''écriture en DS.';
        }
        modify("Remaining Amount")
        {
            ToolTipML = ENU = 'Specifies the amount that remains to be applied to if the entry has not been completely applied to.', FRA = 'Spécifie le montant qui reste à lettrer si l''écriture n''a pas été entièrement lettrée.';
        }
        modify("Bal. Account Type")
        {
            ToolTipML = ENU = 'Specifies the type of balancing account used in the entry.', FRA = 'Spécifie le type du compte de contrepartie utilisé pour l''écriture.';
        }
        modify("Bal. Account No.")
        {
            ToolTipML = ENU = 'Specifies the number of the balancing account used in the entry.', FRA = 'Spécifie le numéro du compte de contrepartie utilisé pour l''écriture.';
        }
        modify(Open)
        {
            ToolTipML = ENU = 'Specifies whether the amount on the bank account entry has been fully applied to or if there is still a remaining amount that must be applied to.', FRA = 'Indique si le montant de l''écriture compte bancaire a été totalement lettré ou s''il y a encore un montant ouvert qui doit être lettré.';
        }
        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user that is associated with the entry.', FRA = 'Spécifie le code de l''utilisateur associé à l''écriture.';
        }
        modify("Source Code")
        {
            ToolTipML = ENU = 'Specifies the source code linked to the bank account entry.', FRA = 'Spécifie le code source lié à l''écriture compte bancaire.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code on the entry.', FRA = 'Spécifie le code motif de l''écriture.';
        }
        modify(Reversed)
        {
            ToolTipML = ENU = 'Specifies if the entry has been part of a reverse transaction.', FRA = 'Spécifie si l''écriture a fait partie d''une transaction contre-passée.';
        }
        modify("Reversed by Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the correcting entry that replaced the original entry in the reverse transaction.', FRA = 'Spécifie le numéro de l''écriture de correction qui a remplacé l''écriture originale dans la transaction contre-passée.';
        }
        modify("Reversed Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the original entry that was undone by the reverse transaction.', FRA = 'Spécifie le numéro de l''écriture initiale annulée par la transaction contre-passée.';
        }
        modify("Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number that the program has assigned the entry.', FRA = 'Spécifie le numéro que le programme a affecté à l''écriture.';
        }
        //BC UPGRADE SIVA >> Base App Already Page layout exist Fields 
        // addafter(Amount)
        // {
        //     field("Debit Amount"; Rec."Debit Amount")
        //     {
        //         ApplicationArea = Basic, Suite;
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        //     field("Credit Amount"; Rec."Credit Amount")
        //     {

        //         ApplicationArea = Basic, Suite;
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        // }
        // addafter("Amount (LCY)")
        // {
        //     field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
        //     {
        //         ApplicationArea =all;
        //         Enabled = FRLocAction;
        //         Visible = false;
        //     }
        //     field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
        //     {
        //         ApplicationArea =all;
        //         Enabled = FRLocAction;
        //         Visible = false;
        //     }
        // }
        //BC UPGRADE SIVA << Base App Already Page layout exist Fields
        addafter("Entry No.")
        {
            field(Comment; Rec."Comment FND")
            {
                ApplicationArea = all;
                ToolTip = 'Comment';
            }
            field("Closed at Date"; Rec."Closed at Date")
            {
                ApplicationArea = all;
                ToolTip = 'Closed at Date';
            }
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = all;
                ToolTip = 'Document Date';
            }
            field("Statement No."; Rec."Statement No.")
            {
                ApplicationArea = all;
                ToolTip = 'Statement No.';
            }
            field("Statement No. Imported"; REc."Statement No. Imported FND")
            {
                ApplicationArea = all;
                ToolTip = 'Statement No. Imported';
            }
            field("Transaction Code"; Rec."Transaction Code FND")
            {
                ApplicationArea = all;
                ToolTip = 'Transaction Code';
            }
            field(Exported; Rec."Exported FND")
            {
                ApplicationArea = all;
                ToolTip = 'Exported';
            }
        }
    }
    actions
    {
        modify("Ent&ry")
        {
            CaptionML = ENU = 'Ent&ry', FRA = 'É&criture';
        }
        modify("Check Ledger E&ntries")
        {
            CaptionML = ENU = 'Check Ledger E&ntries', FRA = 'Écritures comptables c&hèque';
            ToolTipML = ENU = 'View check ledger entries that result from posting transactions in a payment journal for the relevant bank account.', FRA = 'Affichez des écritures comptables chèque qui proviennent de la validation de transactions dans une feuille paiement pour le compte bancaire approprié.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Reverse Transaction")
        {
            CaptionML = ENU = 'Reverse Transaction', FRA = 'Transaction contre-passée';
            ToolTipML = ENU = 'Undo an erroneous journal posting.', FRA = 'Annulez une validation feuille erronée.';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';
        }
    }

    var
        CompanyInfo: Record "Company Information";
        FRLocAction: Boolean;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //BC UPGRADE SIVA >>FrenchLocalization
    // trigger OnOpenPage();
    // begin
    //HEI.02>>
    //     FRLocAction := false;
    //     CompanyInfo.GET();
    //     if CompanyInfo."Enable French Localization" then
    //         FRLocAction := true;
    //HEI.02<<
    // end;
    //BC UPGRADE SIVA <<FrenchLocalization

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

