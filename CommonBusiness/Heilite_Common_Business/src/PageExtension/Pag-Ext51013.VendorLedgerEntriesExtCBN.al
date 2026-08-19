pageextension 51013 VendorLedgerEntriesExtCBN extends "Vendor Ledger Entries"
{
    // version NAVW110.0,FINXL8.00,DITW110.00.11,HEI.06
    //     HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
    //   # New field Vendor Bank Account, IBAN
    // HEI.02 PTPGAP029 IBM ISYED01 03.08.2017 Include item in payment journal
    //   # New field "Batch payment name"

    // HEI.03 PTPGAP041 IBM PATHAA02 20.08.17
    //  #added new field "Status Date"
    //  # removed code from "Payment status"-OnValidate----29.09.17
    //  # Aligned new field "Payment User"--29.09.17

    // HEI.04 FDD-SLSGAP001 IBM POENAB01 17.08.2017 # MDM Customer Card
    //  #added new fields "Rem. Amt for WHT", "Rem. Amt", "WHT Amount", "WHT Amount (LCY)"

    // HEI.05 Defect116(NavBugFix)- IBM PATHAA02 19.09.17 Added comment field
    // HEI.06 Defect #1438 IBM POSTOI01 02.02.2018
    //   # change "Reason Code" Editable property from FALSE->TRUE
    // HEI.07 PTPGAP085 IBM HORTOC01 23.04.2018
    //   # "Reason Code" editable based on "Batch Payment Name"
    // HEI.09 CHG2026314 IBM SAXENS01Ethiopia WHT Certificate No and date
    //   Two new fields are created
    //    # WHT Certificate No
    //    # WHT Certificate Date
    //    # commented code at OnModifyRecord and changed EDITABLE property of all fields to False
    // HEI.10 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    // HEI.11 CHG2060865 IBM AB 17/04/2020
    //   #Bug fix of CHG2026314, code uncommented which was done in HEI.09
    // HEI.13 FDD-HT1346 IBM BULIMC01 20/05/2020 #new function added "GetSelectionfilter"
    // HEI.14 CHG2083510 IBM POENAB02 15.10.2020
    //   # Added field "Recipient Bank Account" in Repeater group
    // HEI.15 CHG2019432 IBM SHANKJ03  03.23.2021
    //   # Added Code in Print Remittance action button
    //   # commented code
    // HEI.17 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "Region Code"
    // HEI.18 CHG2135905 IBM BHATTA09 02.02.2022 # HB2663 Payment remittance advice  French translation
    //   # Code added for French version of the Remittance Advice

    layout
    {
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the vendor entry''s posting date.', FRA = 'Spécifie la date comptabilisation de l''écriture fournisseur.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the document type that the vendor entry belongs to.', FRA = 'Spécifie le type de document auquel appartient l''écriture fournisseur.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the vendor entry''s document number.', FRA = 'Spécifie le numéro de document de l''écriture fournisseur.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies the external document number that was entered on the purchase header or journal line.', FRA = 'Spécifie le numéro de document externe saisi sur l''en-tête achat ou sur la ligne feuille.';
        }
        modify("Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor account that the entry is linked to.', FRA = 'Spécifie le numéro du compte fournisseur auquel l''écriture est liée.';
        }
        modify("Message to Recipient")
        {
            ToolTipML = ENU = 'Specifies the message exported to the payment file when you use the Export Payments to File function in the Payment Journal window.', FRA = 'Spécifie le message exporté vers le fichier de paiement lorsque vous utilisez la fonction Exporter les paiements dans un fichier dans la fenêtre Feuille paiement.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the vendor entry.', FRA = 'Spécifie la description de l''écriture fournisseur.';
        }
        modify("Global Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the entry.', FRA = 'Spécifie le code section analytique lié à l''écriture.';
        }
        modify("Global Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the entry.', FRA = 'Spécifie le code section analytique lié à l''écriture.';
        }
        modify("IC Partner Code")
        {
            ToolTipML = ENU = 'Specifies the customer''s IC partner code, if the customer is one of your intercompany partners.', FRA = 'Spécifie le code de partenaire IC du client si ce dernier est l''un de vos partenaires intersociétés.';
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies the code for the purchaser whom the entry is linked to.', FRA = 'Spécifie le code de l''acheteur auquel l''écriture est liée.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code for the amount on the line.', FRA = 'Spécifie le code devise du montant de la ligne.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies the payment method that was used to make the payment that resulted in the entry.', FRA = 'Spécifie le mode de paiement qui a été utilisé pour effectuer le paiement qui a abouti à l''écriture.';
        }
        modify("Payment Reference")
        {
            ToolTipML = ENU = 'Specifies the payment of the purchase invoice.', FRA = 'Spécifie le paiement de la facture achat.';
        }

        modify("Creditor No.")
        {
            ToolTipML = ENU = 'Specifies the vendor who sent the purchase invoice.', FRA = 'Spécifie le fournisseur qui a envoyé la facture achat.';
        }
        modify("Original Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of the original entry.', FRA = 'Spécifie le montant de l''écriture d''origine.';
        }
        modify("Original Amt. (LCY)")
        {
            ToolTipML = ENU = 'Specifies the amount that the entry originally consisted of, in LCY.', FRA = 'Spécifie le montant qui constituait l''écriture au départ, en devise société.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the amount of the entry.', FRA = 'Spécifie le montant de l''écriture.';
        }
        modify("Amount (LCY)")
        {
            ToolTipML = ENU = 'Specifies the amount of the entry in LCY.', FRA = 'Spécifie le montant de l''écriture en DS.';
        }
        modify("Remaining Amount")
        {
            ToolTipML = ENU = 'Specifies the amount that remains to be applied to before the entry is totally applied to.', FRA = 'Spécifie le montant qui reste à lettrer avant que l''écriture ne soit totalement lettrée.';
        }
        modify("Remaining Amt. (LCY)")
        {
            ToolTipML = ENU = 'Specifies the amount that remains to be applied to before the entry is totally applied to.', FRA = 'Spécifie le montant qui reste à lettrer avant que l''écriture ne soit totalement lettrée.';
        }
        modify("Bal. Account Type")
        {
            ToolTipML = ENU = 'Specifies the type of balancing account used on the entry.', FRA = 'Spécifie le type de compte contrepartie utilisé pour l''écriture.';
        }
        modify("Bal. Account No.")
        {
            ToolTipML = ENU = 'Specifies the balancing account number used on the entry.', FRA = 'Spécifie le numéro de compte contrepartie utilisé pour l''écriture.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the due date on the entry.', FRA = 'Spécifie la date d''échéance de l''écriture.';
        }
        modify("Pmt. Discount Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.', FRA = 'Spécifie la date à laquelle le montant de l''écriture doit être payé pour obtenir un escompte sur la commande.';
        }
        modify("Pmt. Disc. Tolerance Date")
        {
            ToolTipML = ENU = 'Specifies the latest date the amount in the entry must be paid in order for payment discount tolerance to be granted.', FRA = 'Spécifie la dernière date à laquelle le montant de l''écriture doit être payé pour obtenir un écart d''escompte.';
        }
        modify("Original Pmt. Disc. Possible")
        {
            ToolTipML = ENU = 'Specifies the discount that you can obtain if the entry is applied to before the payment discount date.', FRA = 'Spécifie l''escompte que vous pouvez obtenir si l''écriture est lettrée avant la date d''escompte.';
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            ToolTipML = ENU = 'Specifies the remaining payment discount which can be received if the payment is made before the payment discount date.', FRA = 'Spécifie l''escompte ouvert pouvant être reçu si le paiement est effectué avant la date d''escompte.';
        }
        modify("Max. Payment Tolerance")
        {
            ToolTipML = ENU = 'Specifies the maximum tolerated amount the entry can differ from the amount on the invoice or credit memo.', FRA = 'Spécifie l''écart maximal toléré entre l''écriture et le montant de la facture ou de l''avoir.';
        }
        modify(Open)
        {
            ToolTipML = ENU = 'Specifies whether the amount on the entry has been fully paid or there is still a remaining amount that must be applied to.', FRA = 'Spécifie si le montant de l''écriture a été totalement payé ou si un montant reste encore à lettrer.';
        }
        modify("On Hold")
        {
            ToolTipML = ENU = 'Specifies when a vendor ledger has been invoiced and you run the Suggest Vendor Payments batch job.', FRA = 'Spécifie lorsqu''une écriture fournisseur a été facturée et que vous exécutez le traitement par lots Proposer paiements fournisseur.';

            //Unsupported feature: Change Editable on ""On Hold"(Control 22)". Please convert manually.

        }
        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user associated with the entry.', FRA = 'Spécifie le code de l''utilisateur associé à l''écriture.';
        }
        modify("Source Code")
        {
            ToolTipML = ENU = 'Specifies the source code that is linked to the entry.', FRA = 'Spécifie le code source lié à l''écriture.';
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
            ToolTipML = ENU = 'Specifies the entry number that is assigned to the entry.', FRA = 'Spécifie le numéro d''écriture qui est affecté à l''écriture.';
        }
        modify("Exported to Payment File")
        {
            ToolTipML = ENU = 'Specifies that the entry was created as a result of exporting a payment journal line.', FRA = 'Spécifie que l''écriture a été créée suite à l''exportation d''une ligne feuille paiement.';
        }
        modify("Reason Code")
        {
            Visible = true;//BC Upgrade SHARMP16 GAPFitchanges
            Editable = true;//BC Upgrade SHARMP16 GAPFitchanges

        }
        addafter("External Document No.")
        {
            //BC UPGRADE SHARMP16 drinkit fields<<
            // field(OGM; Rec.OGM)
            // {
            // }
            //BC UPGRADE SHARMP16 drinkit fields>>
        }
        addafter("Vendor No.")
        {
            field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
            {
                ApplicationArea = all;
                Visible = false;
                ToolTip = 'Specifies the value of the Vendor Bank Account field.';
            }
            field(IBAN; Rec."IBAN FND")
            {
                ApplicationArea = all;
                Visible = false;
                ToolTip = 'Specifies the value of the IBAN field.';
            }
            field(Name; TxtName)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TxtName field.';
            }
        }
        addafter(Description)
        {
            //BC UPGRADE SHARMP16 commented because it is given by microsoft now.<<
            // field("Vendor Posting Group"; Rec."Vendor Posting Group")
            // {
            //     Editable = false;
            // }
            //BC UPGRADE SHARMP16 commented because it is given by microsoft now.<<

            field("WHT Certificate No"; Rec."WHT Certificate No FND")
            {
                ApplicationArea = all;
                Editable = CertificateNoEditable;
                ToolTip = 'Specifies the value of the WHT Certificate No field.';
            }
            field("WHT Certificate Date"; Rec."WHT Certificate Date FND")
            {
                ApplicationArea = all;
                Editable = CertificateDateEditable;
                ToolTip = 'Specifies the value of the WHT Certificate Date field.';
            }
            //BC UPGRADE SHARMP16 commented because it is given by microsoft now.<<
            // field("Closed at Date"; Rec."Closed at Date")
            // {
            //     Description = 'FINXL7.00.001';
            //     Editable = false;
            // }

            // field("Document Date"; Rec."Document Date")
            // {
            //     Description = 'FINXL7.00.001';
            //     Editable = false;
            // }
            //BC UPGRADE SHARMP16 commented because it is given by microsoft now.<<
        }
        addafter("On Hold")
        {
            field("On Hold UserID"; Rec."On Hold UserID FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the On Hold UserID field.';

            }
            field("On Hold Date"; Rec."On Hold Date FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the On Hold Date field.';
            }
            field("Payment Status"; Rec."Payment Status FND")
            {
                ApplicationArea = all;
                Editable = true;
                ToolTip = 'Specifies the value of the Payment Status field.';
            }
            //BC UPGRADE SHARMP16 commented reason code because it is given by microsoft now.<<
            // field("Reason Code";"Reason Code")
            // {
            //     Editable = ReasonCodeEditable;
            //     ToolTip = 'Specifies the reason code on the entry.';
            //     Visible = true;
            // }
            //BC UPGRADE SHARMP16 commented reason code because it is given by microsoft now.<<
            field("Status Date"; Rec."Status Date FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Status Date field.';
            }
        }
        addafter("User ID")
        {
            field("Payment User"; Rec."Payment User FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payment User field.';
            }
        }
        addafter("Reversed Entry No.")
        {
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Journal Batch Name field.';
            }
            //BC UPGRADE SHARMP16 drinkit fields<<
            // field("Item Charge Type"; Rec."Item Charge Type")
            // {
            //     Visible = false;
            // }
            // field("Vendor DDeposit Group Code"; Rec."Vendor DDeposit Group Code")
            // {
            //     Visible = false;
            // }
            // field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
            // {
            //     Visible = false;
            // }
            // field("Vendor Tax Registration No."; Rec."Vendor Tax Registration No.")
            // {
            //     Visible = false;
            // }
            // field("Vendor Tax Warehouse Ref."; Rec."Vendor Tax Warehouse Ref.")
            // {
            //     Visible = false;
            // }
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     Visible = false;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     Visible = false;
            // }
            // field("Contract Type"; Rec."Contract Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Financial Contract No."; Rec."Financial Contract No.")
            // {
            //     Visible = false;
            // }
            // field("Service Contract No."; Rec."Service Contract No.")
            // {
            //     Visible = false;
            // }
            // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            // {
            //     Visible = false;
            // }
            // field("Contract Group Code"; Rec."Contract Group Code")
            // {
            //     Visible = false;
            // }
            // field("Building No."; Rec."Building No.")
            // {
            //     Visible = false;
            // }
            //BC UPGRADE SHARMP16 drinkit fields<<
        }
        addafter("Exported to Payment File")
        {
            field("Batch payment name"; Rec."Batch payment name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Batch payment name field.';
            }
            //BC UPGRADE SHARMP16 drinkit fields<<
            // field("Route Planning No."; Rec."Route Planning No.")
            // {
            //     Visible = false;
            // }
            //BC UPGRADE SHARMP16 drinkit fields<<

            // BC UPGRADE VAMSIU01 - Field Added >>
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                Visible = false;
                ApplicationArea = All;
            }
            // BC UPGRADE VAMSIU01 - Field Added <<
            field("WHT Amount"; Rec."WHT Amount FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Amount field.';
            }
            field("WHT Amount (LCY)"; Rec."WHT Amount (LCY) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Amount (LCY) field.';
            }
            field(Comments; Rec."Comments FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Comments field.';
            }
            field("Applies-to ID"; Rec."Applies-to ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
            }
            field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
            }
            field("Recipient Bank Account"; Rec."Recipient Bank Account")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the bank account to transfer the amount to.';
            }
            field("Region Code"; Rec."Region Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Region Code field.';
            }
        }
        addafter(IncomingDocAttachFactBox)
        {
            part(VendorStatisticsFactBox; "Vendor Statistics FactBox")
            {
                ApplicationArea = all;
                Description = 'NRQ#39758';
                SubPageLink = "No." = FIELD("Vendor No.");
                Visible = false;
            }
        }
    }
    actions
    {


        modify("Ent&ry")
        {
            CaptionML = ENU = 'Ent&ry', FRA = 'É&criture';
        }
        modify(AppliedEntries)
        {
            CaptionML = ENU = 'Applied E&ntries', FRA = 'É&critures lettrées';
            ToolTipML = ENU = 'View the ledger entries that have been applied to this record.', FRA = 'Affichez les écritures comptables qui ont été lettrées avec cet enregistrement.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Detailed &Ledger Entries")
        {
            CaptionML = ENU = 'Detailed &Ledger Entries', FRA = 'Écritures comptables &détaillées';
            ToolTipML = ENU = 'View a summary of the all posted entries and adjustments related to a specific vendor ledger entry', FRA = 'Affichez un récapitulatif de toutes les écritures et tous les ajustements validés en relation avec une écriture comptable d''un fournisseur spécifique.';

            //Unsupported feature: Change RunPageView on ""Detailed &Ledger Entries"(Action 54)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Detailed &Ledger Entries"(Action 54)". Please convert manually.

        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(ActionApplyEntries)
        {
            CaptionML = ENU = 'Apply Entries', FRA = 'Lettrer écritures';
            ToolTipML = ENU = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.', FRA = 'Sélectionnez une ou plusieurs écritures comptables que vous voulez lettrer avec cet enregistrement afin que les documents validés concernés soient fermés comme étant payés ou remboursés.';
        }
        modify(UnapplyEntries)
        {
            CaptionML = ENU = 'Unapply Entries', FRA = 'Délettrer les écritures';
            ToolTipML = ENU = 'Unselect one or more ledger entries that you want to unapply this record.', FRA = 'Désélectionnez une ou plusieurs écritures comptables que vous ne souhaitez plus lettrer à cet enregistrement.';
        }
        modify(ReverseTransaction)
        {
            CaptionML = ENU = 'Reverse Transaction', FRA = 'Transaction contre-passée';
            ToolTipML = ENU = 'Reverse an erroneous vendor ledger entry.', FRA = 'Contrepassez une écriture comptable fournisseur erronée.';
        }
        modify(IncomingDocument)
        {
            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
        }
        modify(IncomingDocCard)
        {
            CaptionML = ENU = 'View Incoming Document', FRA = 'Afficher le document entrant';
            ToolTipML = ENU = 'View any incoming document records and file attachments that exist for the entry or document.', FRA = 'Affichez tout enregistrement et fichier joint de document entrant qui existe pour l''écriture ou le document.';
        }
        modify(SelectIncomingDoc)
        {
            CaptionML = ENU = 'Select Incoming Document', FRA = 'Sélectionner le document entrant';
            ToolTipML = ENU = 'Select an incoming document record and file attachment that you want to link to the entry or document.', FRA = 'Sélectionnez un fichier joint ou un enregistrement de document entrant que vous voulez associer à l''écriture ou au document.';
        }
        modify(IncomingDocAttachFile)
        {
            CaptionML = ENU = 'Create Incoming Document from File', FRA = 'Créer un document entrant à partir d''un fichier';
            ToolTipML = ENU = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.', FRA = 'Créez un enregistrement de document entrant en sélectionnant un fichier à joindre, puis associez l''enregistrement de document entrant à l''écriture ou au document.';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';
        }
        modify("Show Document")
        {
            CaptionML = ENU = 'Show Posted Document', FRA = 'Afficher doc. enreg.';
            ToolTipML = ENU = 'Show details for the posted payment, invoice, or credit memo.', FRA = 'Affichez les détails pour l''avoir, la facture ou le paiement validé.';
        }


        //Unsupported feature: CodeModification on "ReverseTransaction(Action 69).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CLEAR(ReversalEntry);
        IF Reversed THEN
          ReversalEntry.AlreadyReversedEntry(TABLECAPTION,"Entry No.");
        IF "Journal Batch Name" = '' THEN
          ReversalEntry.TestFieldError;
        TESTFIELD("Transaction No.");
        ReversalEntry.ReverseTransaction("Transaction No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CLEAR(ReversalEntry);
        if Reversed then
          ReversalEntry.AlreadyReversedEntry(TABLECAPTION,"Entry No.");

        if "Journal Batch Name" = '' then
        #5..7
        */
        //end;
        addafter("Ent&ry")
        {
            action("Co&mments Exist")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Co&mments Exist',
                            FRA = 'Commentaires existent';
                Image = Overdue;
                Promoted = true;
                PromotedIsBig = true;
                Visible = CommentVisible;
                ToolTip = 'Executes the Co&mments Exist action.';

                trigger OnAction();
                var
                    Lrec_CommentLine: Record "Comment Line";
                begin
                    //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144/#150
                    Lrec_CommentLine.RESET();
                    Lrec_CommentLine.SETRANGE("Table Name", Lrec_CommentLine."Table Name"::"Vendor Ledger Entry");
                    Lrec_CommentLine.SETRANGE("No.", FORMAT(Rec."Entry No."));
                    PAGE.RUNMODAL(PAGE::"Comment Sheet", Lrec_CommentLine);
                    //>>DITW17.00.02 TEC1 DIT-770 #144/#150
                end;
            }
            action("Co&mments")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Co&mments',
                            FRA = 'Co&mmentaires';
                Image = "8ball";
                Promoted = true;
                PromotedIsBig = true;
                Visible = NOT CommentVisible;
                ToolTip = 'Executes the Co&mments action.';

                trigger OnAction();
                var
                    Lrec_CommentLine: Record "Comment Line";
                begin
                    //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144/#150
                    Lrec_CommentLine.RESET();
                    Lrec_CommentLine.SETRANGE("Table Name", Lrec_CommentLine."Table Name"::"Vendor Ledger Entry");
                    Lrec_CommentLine.SETRANGE("No.", FORMAT(Rec."Entry No."));
                    PAGE.RUNMODAL(PAGE::"Comment Sheet", Lrec_CommentLine);
                    //>>DITW17.00.02 TEC1 DIT-770 #144/#150
                end;
            }
        }
        addafter("Create Payment")
        {
            action("Print Remitance")
            {
                ApplicationArea = all;
                ToolTip = 'Executes the Print Remitance action.';
                Image = PrintReport;
                trigger OnAction();
                var

                begin
                    //HEI.08>>
                    /*
                     VendLedEntRec1.RESET();
                     DtlVendLedRec.RESET();
                     DtlVendLedRec.SETRANGE("Applied Vend. Ledger Entry No.", Rec."Entry No.");
                     DtlVendLedRec.SETRANGE("Initial Document Type", DtlVendLedRec."Initial Document Type"::Invoice);
                     IF DtlVendLedRec.FINDFIRST() THEN
                         REPEAT
                             //DocNo += FORMAT(DtlVendLedRec."Vendor Ledger Entry No.") +'|';
                             VendLedEntRec.RESET();
                             VendLedEntRec.SETRANGE("Entry No.", DtlVendLedRec."Vendor Ledger Entry No.");
                             IF VendLedEntRec.FINDFIRST() THEN BEGIN
                                 VendLedEntRec1.INIT();
                                 VendLedEntRec1 := VendLedEntRec;
                                 VendLedEntRec1.INSERT();
                             end;
                         UNTIL DtlVendLedRec.NEXT() = 0;
                      */


                    //RecVLERemitance.RESET;
                    //RecVLERemitance.SETRANGE("Document Type",Rec."Document Type"::Invoice);
                    //RecVLERemitance.SETRANGE("Closed by Entry No.",Rec."Entry No.");
                    //RecVLERemitance.SETRANGE("Document No.",Rec."Document No.");

                    //ReportRemitance.SETTABLEVIEW(RecVLERemitance);

                    DtlVendLedRec.RESET();
                    DtlVendLedRec.SETRANGE("Applied Vend. Ledger Entry No.", Rec."Entry No.");
                    DtlVendLedRec.SETRANGE("Initial Document Type", DtlVendLedRec."Initial Document Type"::Invoice);
                    //BC UPGRADE ATHUKS01 << Uncommented code
                    //BC UPGRADE SHARMP16 dependent report ReportRemitance needs to be compiled<<
                    ReportRemitance.SETTABLEVIEW(DtlVendLedRec);
                    ReportRemitance.GetVendNoFromVLE(Rec."Vendor No.");//HEI.18
                    ReportRemitance.RUN();//HEI.18
                    //BC UPGRADE SHARMP16 dependent report ReportRemitance needs to be compiled>>
                    //BC UPGRADE ATHUKS01 >> Uncommented code
                    //REPORT.RUNMODAL(50179,TRUE,FALSE,DtlVendLedRec);//HEI.18//Old code commented
                    CLEAR(VendLedEntRec1);
                    CurrPage.UPDATE(true);
                    //HEI.08<<
                end;
            }

        }
    }


    var
        Lrec_CommentLine: Record "Comment Line";
        lrecVendor: Record Vendor;

    var
        ReportRemitance: Report "Remittance Advice VLE CBN";//BC UPGRADE SHARMP16 report needs to be compiled later.
        DtlVendLedRec: Record "Detailed Vendor Ledg. Entry";
        RecVLERemitance: Record "Vendor Ledger Entry";
        VendLedEntRec: Record "Vendor Ledger Entry";
        VendLedEntRec1: Record "Vendor Ledger Entry" temporary;
        CertificateDateEditable: Boolean;
        CertificateNoEditable: Boolean;
        CommentVisible: Boolean;
        ReasonCodeEditable: Boolean;
        TxtName: Text[80];


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    HasIncomingDocument := IncomingDocument.PostedDocExists("Document No.","Posting Date");
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    HasIncomingDocument := IncomingDocument.PostedDocExists("Document No.","Posting Date");
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    //<<DITW110.00.11 MSF 15/18/2017 NRQ#39758
    CurrPage.VendorStatisticsFactBox.PAGE.SetApplyFilters("Currency Code",'',"Global Dimension 1 Code","Global Dimension 2 Code");
    //>>DITW110.00.11 MSF 15/18/2017 NRQ#39758
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger (Variable: Lrec_CommentLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    StyleTxt := SetStyle;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    StyleTxt := SetStyle;
    //<<FINXL8.00.001 BSA 11/06/2015 #79
    if lrecVendor.GET("Vendor No.") then
      TxtName := lrecVendor.Name;
    //>>FINXL8.00.001 BSA 11/06/2015 #79
    //<<DITW17.00.02 SR 12/03/2013 DIT-770 #144
    Lrec_CommentLine.RESET;
    Lrec_CommentLine.SETRANGE("Table Name",Lrec_CommentLine."Table Name"::"Vendor Ledger Entry");
    Lrec_CommentLine.SETRANGE("No.",FORMAT("Entry No."));
     if Lrec_CommentLine.FIND('-') then
      CommentVisible := Lrec_CommentLine.COUNT <> 0
     else
      CommentVisible := false;
    //<<DITW17.00.02 SR DIT-770 #144

    ReasonCodeEditable := (Rec."Batch payment name" = '');//HEI.07

    //HEI.09
    if ("Document Type" = "Document Type"::Payment) and ("WHT Amount" <> 0) then begin
       CertificateNoEditable := true;
       CertificateDateEditable  := true;
    end else begin
      CertificateNoEditable := false;
      CertificateDateEditable  := false;
    end
    //HEI.09
    */
    //end;


    //Unsupported feature: CodeModification on "OnModifyRecord". Please convert manually.

    //trigger OnModifyRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",Rec);
    EXIT(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //>>HEI.11
    //HEI.09
    CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",Rec);
    exit(false);
    //HEI.09
    //<<HEI.11
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF FINDFIRST THEN;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<<DITW17.00.02 SR 12/03/2013 DIT-770 #144
    CommentVisible := false;
    //>>DITW17.00.02 SR 12/03/2013 DIT-770 #144

    if FINDFIRST then;
    */
    //end;

    procedure GetSelectionFilter(): Text;
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        //HEI.13<<
        CurrPage.SETSELECTIONFILTER(VendorLedgerEntry);
        // exit(SelectionFilterManagement.GetSelectionFilterForVendLedgerEntries(VendorLedgerEntry));//BC UPGRADE SHARMP16 Codeunit will be handled differently.
        //HEI.13<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    //BC UPGRADE SHARMP16 begin<<
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        ReasonCodeEditable := (Rec."Batch payment name FND" = '');//HEI.07

        //HEI.09
        IF (Rec."Document Type" = rec."Document Type"::Payment) AND (rec."WHT Amount FND" <> 0) THEN BEGIN
            CertificateNoEditable := TRUE;
            CertificateDateEditable := TRUE;
        end else BEGIN
            CertificateNoEditable := FALSE;
            CertificateDateEditable := FALSE;
        end;
        //HEI.09
        //<<FINXL8.00.001 BSA 11/06/2015 #79
        if lrecVendor.GET(Rec."Vendor No.") then
            TxtName := lrecVendor.Name;
        //>>FINXL8.00.001 BSA 11/06/2015 #79

    end;

    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        //>>HEI.11
        //HEI.09
        CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", Rec);
        EXIT(FALSE);
        //HEI.09
        //<<HEI.11
    end;
    //BC UPGRADE SHARMP16 begin<<


}

