pageextension 51209 CustomerLedgerEntriesExtCBN extends "Customer Ledger Entries"
{
    // version NAVW110.0,FINXL8.00,DITW110.00.11,HEI.03
    //     DITW15.00.00.25 DDR 16/10/2008 Added columns
    //                                  "Customer DTax Group Code","Customer DDeposit Group Code",
    //                                  "Truck Code","Driver Code"
    // DITW15.00.00.35 DDR 06/05/2009 Added columns
    //                                  "Contract Group Code"
    // DITW15.00.00.37 DDR 28/01/2010 Added columns
    //                                  "Building No."
    //                     01/06/2010 Added columns
    //                                  "DIT Sub-Contract Type"
    //                                Added Not visible by default for all DIT fields
    // DITW15.00.00.38 DDR 10/12/2010 issue 1221 Added columns
    //                                  "Customer Tax Registration No.","Customer Tax Warehouse Ref."
    // DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327 Added fields "DIT Sub-Contract Type","Service Contract Type","Service Contract No."
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "Item Charge Type"
    // DITW16.00.00.43 DDR 14/08/2013 DIT-715 #678 Added fields "Deposit Amount","Deposit Amount (LCY)"

    // FINXL7.00.001 RBE 20/03/2013 : Added fields "Closed at Date" and "Document Date" on form
    //                                Added field OGM on page
    // FINXL8.00.001 BSA 11/06/2015 #79 :Added Calculation of TxtName

    // DITW17.00.02 DDR 19/08/2013 DIT-715 #678 merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : New Field "Customer Posting Group" Added
    // DITW17.10.03 AT  05/02/2014 DIT-770 #340 : Customer Posting Group Made Non Editable
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added field "Invoice List Document No."
    //                                          Added action Invoice List
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
    //                                  2014109 Route Planning No.
    //                                  2014421 Document Subtype Code
    // DITW110.00.11 MSF 15/18/2017 NRQ#39758 Added Factbox CustomerStatisticsFactBox
    // HEI.01 FDD OTCGAP029 Heilite Base IBM ISYED01 11/07/2017
    //   #added code to Dispute case creation menu to open form for Dispute creatio for Document type invoice .
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 17.08.2017 # MDM Customer Card
    //   # New fields:
    //     - Rem. Amt for WHT
    //     - Rem. Amt
    //     - WHT Amount
    //     - WHT Amount (LCY)


    // HEI.03 Defect116(NavBugFix)- IBM PATHAA02 19.09.17 Added comment field
    // HEI.04 FDD-ET-HT695 IBM NASTAA02 05.07.2019 # RPM Payment Reconciliation and Offset
    //   # New Fields added: "Empties Item No.", "Deposit Quantity"
    // HEI.05 FDD-HT704 IBM BULIMC01 29.07.2019 #new field displayed: "Cashier ID"
    // HEI.06 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier"
    // HEI.07 FDD-CD-HT1350 IBM BULIMC01 16.07.2020 #new field added: "Related Sales Order No."
    // HEI.08 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field added: "Location Code"

    // BC Upgrade SHUKLP03 >> Moved in the interface ext.
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 17.08.2017 # MDM Customer Card
    //   # New fields:
    //     - Rem. Amt for WHT
    //     - Rem. Amt
    //     - WHT Amount
    //     - WHT Amount (LCY)
    // BC Upgrade SHUKLP03 << Moved in the interface ext.

    // BC Upgrade SHUKLP03 >> Added document subtype field.

    layout
    {
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the customer entry''s posting date.', FRA = 'Spécifie la date comptabilisation de l''écriture client.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the document type that the customer entry belongs to.', FRA = 'Spécifie le type de document auquel appartient l''écriture client.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the entry''s document number.', FRA = 'Spécifie le numéro de document de l''écriture.';
        }
        modify("Customer No.")
        {
            ToolTipML = ENU = 'Specifies the customer account number that the entry is linked to.', FRA = 'Spécifie le numéro du compte client auquel l''écriture est liée.';
        }
        modify("Message to Recipient")
        {
            ToolTipML = ENU = 'Specifies the message exported to the payment file when you use the Export Payments to File function in the Payment Journal window.', FRA = 'Spécifie le message exporté vers le fichier de paiement lorsque vous utilisez la fonction Exporter les paiements dans un fichier dans la fenêtre Feuille paiement.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the customer entry.', FRA = 'Spécifie la description de l''écriture client.';
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
            ToolTipML = ENU = 'Specifies the code of the intercompany partner that the transaction was with if the entry was posted from an intercompany transaction.', FRA = 'Spécifie le code du partenaire intersociété concerné si l''écriture a été validée à partir d''une transaction intersociété.';
        }
        modify("Salesperson Code")
        {
            ToolTipML = ENU = 'Specifies the code for the salesperson whom the entry is linked to.', FRA = 'Spécifie le code du vendeur auquel l''écriture est liée.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code for the amount on the line.', FRA = 'Spécifie le code devise du montant de la ligne.';
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
            ToolTipML = ENU = 'Specifies the amount that remains to be applied to before the entry has been completely applied.', FRA = 'Spécifie le montant qui reste à lettrer avant que l''écriture ne soit totalement lettrée.';
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
            ToolTipML = ENU = 'Specifies the last date the amount in the entry must be paid in order for a payment discount tolerance to be granted.', FRA = 'Spécifie la dernière date à laquelle le montant de l''écriture doit être payé pour obtenir un écart d''escompte.';
        }
        modify("Original Pmt. Disc. Possible")
        {
            ToolTipML = ENU = 'Specifies the discount that the customer can obtain if the entry is applied to before the payment discount date.', FRA = 'Spécifie l''escompte que le client peut obtenir si l''écriture est lettrée avant la date d''escompte.';
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            ToolTipML = ENU = 'Specifies the remaining payment discount that is available if the entry is totally applied to within the payment period.', FRA = 'Spécifie l''escompte ouvert disponible si l''écriture est entièrement lettrée avant l''échéance.';
        }
        modify("Max. Payment Tolerance")
        {
            ToolTipML = ENU = 'Specifies the maximum tolerated amount the entry can differ from the amount on the invoice or credit memo.', FRA = 'Spécifie l''écart maximal toléré entre l''écriture et le montant de la facture ou de l''avoir.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies the payment method that was used to make the payment that resulted in the entry.', FRA = 'Spécifie le mode de paiement qui a été utilisé pour effectuer le paiement qui a abouti à l''écriture.';
        }
        modify(Open)
        {
            ToolTipML = ENU = 'Specifies whether the amount on the entry has been fully paid or there is still a remaining amount that must be applied to.', FRA = 'Spécifie si le montant de l''écriture a été totalement payé ou si un montant reste encore à lettrer.';
        }
        modify("On Hold")
        {
            ToolTipML = ENU = 'Specifies when an entry for an unpaid invoice has been posted and you create a finance charge memo or reminder.', FRA = 'Spécifie quand une écriture a été validée pour une facture impayée et que vous créez une facture d''intérêts ou une relance.';
        }
        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user associated with the entry.', FRA = 'Spécifie le code de l''utilisateur associé à l''écriture.';
        }
        modify("Source Code")
        {
            ToolTipML = ENU = 'Specifies the source code that is linked to the entry.', FRA = 'Spécifie le code source lié à l''écriture.';
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
            ToolTipML = ENU = 'Specifies the entry number that is assigned to the entry.', FRA = 'Spécifie le numéro d''écriture qui est affecté à l''écriture.';
        }
        modify("Exported to Payment File")
        {
            ToolTipML = ENU = 'Specifies that the entry was created as a result of exporting a payment journal line.', FRA = 'Spécifie que l''écriture a été créée suite à l''exportation d''une ligne feuille paiement.';
        }
        modify("Direct Debit Mandate ID")
        {
            ToolTipML = ENU = 'Specifies the direct-debit mandate that the customer has signed to allow direct debit collection of payments.', FRA = 'Spécifie le mandat de prélèvement que le client a signé pour autoriser un prélèvement automatique des paiements.';
        }
        addafter("Customer No.")
        {
            field(Name; TxtName)
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            // BC Upgrade SHUKLP03 >> Blocked DIT Field. 
            // field(OGM; Rec.OGM)
            // {
            //     Description = 'FINXL7.00.001';
            //     ApplicationArea = All;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT Field. 

            field("Closed by Entry No."; Rec."Closed by Entry No.")
            {
                ApplicationArea = All;
            }

            // BC Upgrade SHUKLP03 >> Blocked DIT Field. 
            // field("Closed at Date"; Rec."Closed at Date")
            // {
            //     Description = 'FINXL7.00.001';
            //     Editable = false;
            //     ApplicationArea = All;
            // }
            // field("Document Date"; Rec."Document Date")
            // {
            //     Description = 'FINXL7.00.001';
            //     Editable = false;
            //     ApplicationArea = All;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT Field. 

        }
        addafter("Remaining Amt. (LCY)")
        {
            field("Related Sales Order No."; Rec."Related Sales Order No. FND")
            {
                ApplicationArea = All;
            }
        }
        addafter("Reversed Entry No.")
        {
            // BC Upgrade SHUKLP03 >> Blocked DIT Field. 
            // field("Item Charge Type"; Rec."Item Charge Type")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT Field. 

            field("Empties Item No."; Rec."Empties Item No. FND")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Deposit Quantity"; Rec."Deposit Quantity FND")
            {
                Visible = false;
                ApplicationArea = All;
            }

            // BC Upgrade SHUKLP03 >> Blocked DIT Fields. 
            // field("Customer DDeposit Group Code"; Rec."Customer DDeposit Group Code")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("Deposit Amount"; Rec."Deposit Amount")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("Deposit Amount (LCY)"; Rec."Deposit Amount (LCY)")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("Customer DTax Group Code"; Rec."Customer DTax Group Code")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("Customer Tax Registration No."; Rec."Customer Tax Registration No.")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("Customer Tax Warehouse Ref."; Rec."Customer Tax Warehouse Ref.")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("Contract Type"; Rec."Contract Type")
            // {
            //     Editable = false;
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("Service Contract No."; Rec."Service Contract No.")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("Financial Contract No."; Rec."Financial Contract No.")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("Contract Group Code"; "Contract Group Code")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("Building No."; "Building No.")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT Fields. 

        }
        addafter("Direct Debit Mandate ID")
        {
            // BC Upgrade SHUKLP03 >> Blocked DIT Fields. 
            // field("Invoice List Document No."; Rec."Invoice List Document No.")
            // {
            //     ApplicationArea = All;
            // }
            // field("Route Planning No."; Rec."Route Planning No.")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // field("Document Subtype Code"; Rec."Document Subtype Code")
            // {
            //     Visible = false;
            //     ApplicationArea = All;
            // }
            // BC Upgrade SHUKLP03 << Blocked DIT Field. 

            // BC Upgrade SHUKLP03 >> Added field.
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                Visible = false;
                ApplicationArea = All;
            }
            // BC Upgrade SHUKLP03 << Added field.

            field("Dispute Case"; Rec."Dispute Case FND")
            {
                ApplicationArea = All;
            }

            // BC Upgrade SHUKLP03 >> Moved in the interface ext.
            // field("WHT Amount"; Rec."WHT Amount")
            // {
            //     ApplicationArea = All;
            // }
            // field("WHT Amount (LCY)"; Rec."WHT Amount (LCY)")
            // {
            //     ApplicationArea = All;
            // }
            // BC Upgrade SHUKLP03 << Moved in the interface ext.

            field("Cashier ID"; Rec."Cashier ID FND")
            {
                ApplicationArea = All;
            }
            field(Comment; Rec."Comment FND")
            {
                ApplicationArea = All;
            }
            field("Source System Identifier"; Rec."Source System Identifier FND")
            {
                ApplicationArea = All;
            }
            field("Location Code"; Rec."Location Code FND")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter(IncomingDocAttachFactBox)
        {
            part(CustomerStatisticsFactBox; "Customer Statistics FactBox")
            {
                Description = 'NRQ#39758';
                SubPageLink = "No." = FIELD("Customer No.");
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Ent&ry")
        {
            CaptionML = ENU = 'Ent&ry', FRA = 'É&criture';
        }
        modify("Reminder/Fin. Charge Entries")
        {
            CaptionML = ENU = 'Reminder/Fin. Charge Entries', FRA = 'Écr. relance/fact. intérêts';
            ToolTipML = ENU = 'View the reminders and finance charge entries that you have entered for the customer.', FRA = 'Affichez les rappels et écritures factures d''intérêt que vous avez entrées pour le client.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Detailed &Ledger Entries")
        {
            CaptionML = ENU = 'Detailed &Ledger Entries', FRA = 'Écritures comptables &détaillées';
            ToolTipML = ENU = 'View a summary of the all posted entries and adjustments related to a specific customer ledger entry.', FRA = 'Affichez un récapitulatif de toutes les écritures et tous les ajustements validés en relation avec une écriture comptable d''un client spécifique.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Apply Entries")
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
            ToolTipML = ENU = 'Reverse an erroneous customer ledger entry.', FRA = 'Contre passez une écriture comptable client erronée.';
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
        addafter("Detailed &Ledger Entries")
        {
            // BC Upgrade SHUKLP03 >> Blocked because of DIT page "Invoice List".
            // action("Invoice List")
            // {
            //     CaptionML = ENU = 'Invoice List',
            //                 FRA = 'Liste des factures';
            //     Description = 'DITW17.10.05  DIT-770 #761';
            //     Image = List;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Invoice List";
            //     RunPageLink = "Document No." = FIELD("Invoice List Document No.");
            //     ApplicationArea = All;
            // }
            // BC Upgrade SHUKLP03 << Blocked because of DIT page "Invoice List".
            action("<Page Dispute Case>")
            {
                Caption = 'Dispute Cases';
                Image = LedgerEntries;
                ApplicationArea = All;

                trigger OnAction();
                var
                    DisputeCase: Record "Dispute Case FND";
                begin
                    //HEI.01>>
                    if Rec."Document Type" <> Rec."Document Type"::Invoice then begin
                        Rec.TESTFIELD("Document Type", Rec."Document Type"::Invoice);
                    end
                    else begin
                        DisputeCase.RESET();
                        DisputeCase.SETRANGE(DisputeCase."Cust. Ledger Entry No.", Rec."Entry No.");
                        if PAGE.RUNMODAL(PAGE::"Dispute Cases", DisputeCase) = ACTION::LookupOK then begin end;
                    end;
                    //HEI.01<<
                end;
            }
        }
    }

    var
        lrecCustomer: Record Customer;

    var
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
    CurrPage.CustomerStatisticsFactBox.PAGE.SetApplyFilters("Currency Code",'',"Global Dimension 1 Code","Global Dimension 2 Code");
    //>>DITW110.00.11 MSF 15/18/2017 NRQ#39758
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger (Variable: lrecCustomer)();
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
    if lrecCustomer.GET("Customer No.") then
      TxtName := lrecCustomer.Name;
    //>>FINXL8.00.001 BSA 11/06/2015 #79
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

