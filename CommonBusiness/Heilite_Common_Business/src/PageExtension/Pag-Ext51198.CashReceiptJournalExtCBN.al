pageextension 51198 CashReceiptJournalExtCBN extends "Cash Receipt Journal"
{
    // version NAVW110.0.00.16177,DITW110.00.11,HEI.10
    //     DITW15.00.00.26 DDR 18/11/2008 Added new function "Suggest Route Settlement" into Function Button
    //                                Added button Print
    // DITW15.00.00.35 DDR 21/04/2009 Add field "Contract Group Code"
    // DITW15.00.00.37 DDR 28/01/2010 issue 879 Add field "Building No."
    //                     10/05/2010 issue 857 Add field "DIT Sub-Contract Type"
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    // DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added fields "Service Contract Type","Service Contract No."
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "item charge type"
    // DITW17.00.02 SR 10/09/2013 DIT-770 #137 : Add field "Payment Type"
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 AT  17/12/2013 DIT-770 #163 :  Added Posting Group
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.05 WSA 08/08/2014 DIT-770 #761 : Added Action Apply Invoice List
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 AKH 14/07/2017 NRQ#32867 Retored DIT code (upgrade error)
    //                                        Added field "Payment Method Code"
    // DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
    //                              Added Action Suggest Customer Payments

    // HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
    //   # New field Vendor Bank Account
    // HEI.02 FDD-ET-HT695 IBM NASTAA02 05.07.2019 # RPM Payment Reconciliation and Offset
    //   # New Fields added: "Empties Item No.", "Deposit Quantity"
    //   # If Item Chargee Type is 'Deposit' and Account Type is 'Customer', the 2 new Fields will be enabled and editable
    // HEI.03 FDD-CHG2022328 IBM POENAB02 07.07.2019 # External document No. duplication in journal
    //   #New fields added: "Source No.", "Source Type"
    //   #Code added in OnInit and in OnAfterGetCurrRecord
    //   #Changed Visible to TRUE for field "External Document No."
    // HEI.04 FDD-HT704 IBM BULIMC01 26.07.2019 #New code added
    // HEI.05 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in OnInit
    //   # Added action PrintCheckRemittanceReport in action group Functions
    // HEI.06 FDD-CD-HT1350 IBM BULIMC01 13.07.2020
    //     #2 new fields added: "Sales/Archived Order type", "Related Sales Order"
    //     #code added to "Post" function
    // HEI.07 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # Code added on Page Actions "Post" and "Post & Print"
    //   # New functions created: "SetupExternalDocNo" and "UpdateAPIInterfaceLog"
    // HEI.08 HB2487 CHG2123592 IBM MAJUMS03 #Cash Application where 92% of Customer pay in advance
    //   # Code added on Page Actions Post - OnAction() and <Action45> - OnAction() (OnAction() Trigger of “Post and &Print”).
    //   # Two new functions - CheckRelatedSOBeforePosting and UpdateCashRcptInfoInRltdSOHdr are added.
    // HEI.09 CC CHG2218025 IBM BHANDS01 29.08.2023 External Document Number Length Error
    //   # Modified the length of Global variable "ExternalDocNo" from 20 to 35
    // HEI.10 CHG2271823 IBM KAPOOV01 08.11.2024 Field to Block/Unblock General Journal templates
    //   #Modified Trigger/Functions- OnInit(),OnAfterGetRecord(),OnAfterGetCurrRecord()
    //   #Modified Enable Property of Various Actions & Action Groups

    // BC Upgrade SHUKLP03 >>
    // Moved UpdateAPIInterfaceLog() procedure in interface extension.
    // Some code part of trigger OnAfterAction of action(Post) and action(Post and &Print) moved to interface extension.
    // Created custom action("Test Report Custom") with same name to block base action("Test Report") code.
    // BC Upgrade SHUKLP03 <<



    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the batch name on the cash receipt journal.', FRA = 'Spécifie le nom de la feuille règlement.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date for the entry.', FRA = 'Spécifie la date comptabilisation de l''écriture.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on the document that provides the basis for the entry on the journal line.', FRA = 'Spécifie la date du document qui est utilisé comme document de base pour l''écriture de la ligne feuille.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the type of document that the entry on the journal line is.', FRA = 'Spécifie le type de document auquel appartient l''écriture de la ligne feuille.';
            trigger OnAfterValidate()
            var
            begin
                UpdateRPMPaymentFields(); //HEI.02
            end;
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number for the journal line.', FRA = 'Spécifie le numéro de document de la ligne feuille.';
        }
        modify("Incoming Document Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the incoming document that this general journal line is created for.', FRA = 'Spécifie le numéro du document entrant pour lequel cette ligne feuille comptabilité est créée.';
        }
        modify("External Document No.")
        {
            Visible = true;  // BC Upgrade SHUKLP03 << Made Visible true as per HEI.03
            ToolTipML = ENU = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.', FRA = 'Spécifie un numéro de document qui fait référence au programme de numérotation du client ou du fournisseur.';

            //Unsupported feature: Change Visible on ""External Document No."(Control 35)". Please convert manually.

        }
        modify("Account Type")
        {
            ToolTipML = ENU = 'Specifies the type of account that the entry on the journal line will be posted to.', FRA = 'Spécifie le type de compte sur lequel l''écriture de la ligne feuille est validée.';
            trigger OnAfterValidate()
            var
            begin
                UpdateRPMPaymentFields(); //HEI.02
            end;
        }
        modify("Account No.")
        {
            ToolTipML = ENU = 'Specifies the account number that the entry on the journal line will be posted to.', FRA = 'Spécifie le numéro de compte sur lequel l''écriture de la ligne feuille est validée.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry. The field is automatically filled when the Account No. field is filled.', FRA = 'Spécifie une description de l''écriture. Le champ est automatiquement rempli lorsque le champ N° compte est rempli.';
        }
        modify("Salespers./Purch. Code")
        {
            ToolTipML = ENU = 'Specifies the salesperson or purchaser who is linked to the journal line.', FRA = 'Spécifie le vendeur ou l''acheteur lié à la ligne feuille.';
        }
        modify("Campaign No.")
        {
            ToolTipML = ENU = 'Specifies the number of the campaign the journal line is linked to.', FRA = 'Spécifie le numéro de la campagne à laquelle la ligne feuille est liée.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the code of the currency for the amounts on the journal line.', FRA = 'Spécifie le code de la devise des montants de la ligne feuille.';
        }
        modify("Gen. Posting Type")
        {
            ToolTipML = ENU = 'Specifies the general posting type that will be used when you post the entry on this journal line.', FRA = 'Spécifie le type validation général qui est utilisé lorsque vous validez l''écriture de cette ligne feuille.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the general business posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code du groupe comptabilisation marché utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the general product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the VAT business posting group code that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation marché TVA qui est utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit TVA utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the total amount (including VAT) that the journal line consists of.', FRA = 'Spécifie le montant total (TVA incluse) qui constitue la ligne feuille.';
        }
        modify("Debit Amount")
        {
            ToolTipML = ENU = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a debit amount.', FRA = 'Spécifie le montant total (TVA incluse) qui constitue la ligne feuille, s''il s''agit d''un montant débiteur.';
        }
        modify("Credit Amount")
        {
            ToolTipML = ENU = 'Specifies the total amount (including VAT) that the journal line consists of, if it is a credit amount.', FRA = 'Spécifie le montant total (TVA incluse) qui constitue la ligne feuille, s''il s''agit d''un montant crédit.';
        }
        modify("VAT Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of VAT included in the total amount.', FRA = 'Spécifie le montant de TVA incluse dans le montant total.';
        }
        modify("VAT Difference")
        {
            ToolTipML = ENU = 'Specifies the difference between the calculate VAT amount and the VAT amount that you have entered manually.', FRA = 'Spécifie la différence entre le montant TVA calculé et le montant TVA que vous avez entré manuellement.';
        }
        modify("Bal. VAT Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of Bal. VAT included in the total amount.', FRA = 'Spécifie le montant de TVA contrepartie incluse dans le montant total.';
        }
        modify("Bal. VAT Difference")
        {
            ToolTipML = ENU = 'Specifies the difference between the calculate VAT amount and the VAT amount that you have entered manually.', FRA = 'Spécifie la différence entre le montant TVA calculé et le montant TVA que vous avez entré manuellement.';
        }
        modify("Bal. Account Type")
        {
            ToolTipML = ENU = 'Specifies the code for the balancing account type that should be used in this journal line.', FRA = 'Spécifie le code du type de compte contrepartie à utiliser dans cette ligne feuille.';
        }
        modify("Bal. Account No.")
        {
            ToolTipML = ENU = 'Specifies the number of the general ledger, customer, vendor, or bank account to which a balancing entry for the journal line will posted (for example, a cash account for cash purchases).', FRA = 'Spécifie le numéro du compte général, client, fournisseur ou bancaire sur lequel une écriture contrepartie est insérée pour la ligne feuille (par exemple, un compte caisse pour les achats).';
        }
        modify("Bal. Gen. Posting Type")
        {
            ToolTipML = ENU = 'Specifies the general posting type that will be used when you post the entry on the journal line.', FRA = 'Spécifie le type de validation qui est utilisé lorsque vous validez l''écriture de la ligne feuille.';
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the general business posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code du groupe comptabilisation marché utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the general product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT business posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation marché TVA utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit TVA utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Applied (Yes/No)")
        {
            CaptionML = ENU = 'Applied (Yes/No)', FRA = 'Lettré (Oui/Non)';
            ToolTipML = ENU = 'Specifies if the payment has been applied.', FRA = 'Indique si le paiement a été lettré.';
        }
        modify("Applies-to Doc. Type")
        {
            ToolTipML = ENU = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.', FRA = 'Spécifie le type du document validé avec lequel ce document ou cette ligne feuille sera lettré lorsque vous validez, par exemple pour enregistrer un paiement.';
        }
        modify("Applies-to Doc. No.")
        {
            ToolTipML = ENU = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.', FRA = 'Spécifie le numéro du document validé avec lequel ce document ou cette ligne feuille sera lettré lorsque vous validez, par exemple pour enregistrer un paiement.';
        }
        modify("Applies-to ID")
        {
            ToolTipML = ENU = 'Specifies the entries that will be applied to by the journal line if you use the Apply Entries facility.', FRA = 'Spécifie les écritures qui vont être lettrées avec la ligne feuille si vous utilisez l''option Ecr. ouvertes.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code that has been entered on the journal lines.', FRA = 'Spécifie le code motif qui a été saisi sur les lignes feuille.';
        }
        modify("Direct Debit Mandate ID")
        {
            ToolTipML = ENU = 'Specifies the identification of the direct-debit mandate that is being used on the journal lines to process a direct debit collection.', FRA = 'Spécifie l''identification du mandat de prélèvement qui est utilisé sur les lignes feuille pour traiter un recouvrement prélèvement.';
        }
        modify("Account Name")
        {
            CaptionML = ENU = 'Account Name', FRA = 'Nom du compte';
        }
        modify(AccName)
        {
            ToolTipML = ENU = 'Specifies the name of the account.', FRA = 'Spécifie le nom du compte.';
        }
        modify("Bal. Account Name")
        {
            CaptionML = ENU = 'Bal. Account Name', FRA = 'Nom du compte contrepartie';
        }
        modify(BalAccName)
        {
            CaptionML = ENU = 'Bal. Account Name', FRA = 'Nom du compte contrepartie';
            ToolTipML = ENU = 'Specifies the name of the balancing account that has been entered on the journal line.', FRA = 'Indique le nom du compte contrepartie qui a été saisi sur la ligne feuille où se trouve le pointeur de la souris.';
        }
        modify(Control1900545401)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify(Balance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
            ToolTipML = ENU = 'Specifies the balance that has accumulated in the cash receipt journal on the line where the cursor is.', FRA = 'Spécifie le solde accumulé dans la feuille règlement sur la ligne où se trouve le pointeur de la souris.';
        }
        modify("Total Balance")
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
        }
        modify(TotalBalance)
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
            ToolTipML = ENU = 'Specifies the total balance in the cash receipt journal.', FRA = 'Indique le solde final de la feuille règlement.';
        }
        modify(WorkflowStatusBatch)
        {
            CaptionML = ENU = 'Batch Workflows', FRA = 'Flux de travail par lots';
        }
        modify(WorkflowStatusLine)
        {
            CaptionML = ENU = 'Line Workflows', FRA = 'Flux de travail ligne';
        }

        //Unsupported feature: CodeInsertion on ""Document Type"(Control 4)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        UpdateRPMPaymentFields; //HEI.02
        */
        //end;


        //Unsupported feature: CodeModification on ""Account Type"(Control 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);

        UpdateRPMPaymentFields; //HEI.02
        */
        //end;

        // BC Upgrade SHUKLP03 >> DrinkIT fields.
        // addafter("Incoming Document Entry No.")
        // {
        //     field("Payment Type"; Rec."Payment Type")
        //     {
        //         ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT fields.
        addafter("Campaign No.")
        {
            // BC Upgrade SHUKLP03 >> DrinkIT fields.
            // field("Contract Type"; Rec."Contract Type")
            // {
            //     ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Service Contract No."; Rec."Service Contract No.")
            // {
            //     ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
            //     Visible = false;
            // }
            // field("Financial Contract No."; Rec."Financial Contract No.")
            // {
            //     ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
            //     Visible = false;
            // }
            // BC Upgrade SHUKLP03 >> DrinkIT fields.

            // BC Upgrade SHUKLP03 >> DrinkIT fields.
            // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            // {
            //     ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
            //     Visible = false;
            // }
            // field("Contract Group Code"; Rec."Contract Group Code")
            // {
            //     ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
            //     Visible = false;
            // }
            // field("Building No."; Rec."Building No.")
            // {
            //     ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
            //     Visible = false;
            // }
            // field("Item Charge Type"; Rec."Item Charge Type")
            // {
            //     ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         UpdateRPMPaymentFields; //HEI.02
            //     end;
            // }
            // BC Upgrade SHUKLP03 >> DrinkIT fields.
            field("Empties Item No."; Rec."Empties Item No. FND")
            {
                ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
                Editable = RPMPaymentEnabled;
                Enabled = RPMPaymentEnabled;
                Visible = false;
                ToolTip = 'Specifies the value of the Empties Item No. field.';
            }
            field("Deposit Quantity"; Rec."Deposit Quantity FND")
            {
                ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
                Editable = RPMPaymentEnabled;
                Enabled = RPMPaymentEnabled;
                Visible = false;
                ToolTip = 'Specifies the value of the Deposit Quantity field.';
            }
            // BC Upgrade SHUKLP03 >> DrinkIT fields.
            // field("Payment Method Code"; Rec."Payment Method Code")
            // {
            //     ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
            //     Description = 'DITW110.00.10 NRQ#32867';
            //     Visible = false;
            // }
            // BC Upgrade SHUKLP03 << DrinkIT fields.
        }
        // BC Upgrade SHUKLP03 >> DrinkIT fields.
        // addafter(Comment)
        // {
        //     field("Driver Code";Rec."Driver Code")
        //     {
        //         ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
        //         Description = '<DITW15.00.00.25>-NRQ17902';
        //         Visible = false;
        //     }
        //     field("Route Planning No.";Rec."Route Planning No.")
        //     {
        //         Visible = false;
        //     }
        // }
        // BC Upgrade SHUKLP03 >> DrinkIT fields.

        addafter("Direct Debit Mandate ID")
        {
            field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Vendor Bank Account field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Vendor Bank Account field.';

            }
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
                Editable = "Source No.Editable";
                ToolTip = 'Specifies the value of the Source No. field.';
            }
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
                Editable = SourceTypeEditable;
                ToolTip = 'Specifies the value of the Source Type field.';
            }
            field("Sales/Archived Order Type"; Rec."Sales/Archived Order Type FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Sales/Archived Order Type field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Sales/Archived Order Type field.';

            }
            field("Related Sales Order"; Rec."Related Sales Order FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Related Sales Order field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Related Sales Order field.';

            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(IncomingDoc)
        {
            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
            ToolTipML = ENU = 'View or create an incoming document record that is linked to the entry or document.', FRA = 'Affichez ou créez un enregistrement de document entrant qui est lié à l''écriture ou au document.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("A&ccount")
        {
            CaptionML = ENU = 'A&ccount', FRA = '&Compte';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
            ToolTipML = ENU = 'View or change detailed information about the record that is being processed on the journal line.', FRA = 'Affichez ou modifiez les informations détaillées sur l''enregistrement qui sont traitées sur la ligne feuille.';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the history of transactions that have been posted for the selected record.', FRA = 'Affichez l''historique des transactions qui ont été validées pour l''enregistrement sélectionné.';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Renumber Document Numbers")
        {
            CaptionML = ENU = 'Renumber Document Numbers', FRA = 'Renuméroter des documents';
            ToolTipML = ENU = 'Resort the numbers in the Document No. column to avoid posting errors because the document numbers are not in sequence. Entry applications and line groupings are preserved.', FRA = 'Réaffectez les priorités des numéros dans la colonne N° document pour éviter les erreurs de validation dues au fait que les numéros de document ne sont pas dans l''ordre. Le lettrage des écritures et les groupements de lignes sont préservés.';
        }
        modify("Apply Entries")
        {
            CaptionML = ENU = 'Apply Entries', FRA = 'Lettrer écritures';
            ToolTipML = ENU = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.', FRA = 'Sélectionnez une ou plusieurs écritures comptables que vous voulez lettrer avec cet enregistrement afin que les documents validés concernés soient fermés comme étant payés ou remboursés.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            CaptionML = ENU = 'Insert Conv. LCY Rndg. Lines', FRA = 'Insérer lignes arr. conv. DS';
            ToolTipML = ENU = 'Insert a rounding correction line in the journal. This rounding correction line will balance in LCY when amounts in the foreign currency also balance. You can then post the journal.', FRA = 'Insérez une ligne correction arrondi dans la feuille. Cette ligne correction d''arrondi permet d''équilibrer en devise société lorsque les montants en devise étrangère sont également équilibrés. Vous pouvez alors valider la feuille.';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Reconcile)
        {
            CaptionML = ENU = 'Reconcile', FRA = 'Simuler';
            ToolTipML = ENU = 'View the balances on bank accounts that are marked for reconciliation, usually liquid accounts.', FRA = 'Affichez les soldes des comptes bancaires qui sont destinés au rapprochement, en général des comptes de liquidités.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Test Report")
        {
            Visible = false; // BC Upgrade SHUKLP03 << Made it Visible false to block base code and created new action of same name.
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }

        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
            Enabled = EnableActnIfTemplateNtBlck;
            // BC Upgrade SHUKLP03 >>
            trigger OnBeforeAction()
            var
            begin
                SetupExternalDocNo(); //HEI.07
                                      //>>HEI.08
                CheckRelatedSOBeforePosting();
                //<<HEI.08
            end;

            trigger OnAfterAction()
            var
            begin
                //>>HEI.08
                UpdateCashRcptInfoInRltdSOHdr();
                //<<HEI.08
                // UpdateAPIInterfaceLog; //HEI.07 // BC Upgrade SHUKLP03 << Moved OnAfterAction triggers in interface extension because of Procedure UpdateAPIInterfaceLog().

            end;

            // BC Upgrade SHUKLP03 <<
        }

        modify(Preview)
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
            ToolTipML = ENU = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.', FRA = 'Finalisez et préparez-vous à imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenêtre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément à imprimer.';
            Enabled = EnableActnIfTemplateNtBlck;

            // BC Upgrade SHUKLP03 >> Added OnBeforeAction and OnAfterAction triggers.
            trigger OnBeforeAction()
            var
            begin
                SetupExternalDocNo(); //HEI.07
                                      //>>HEI.08
                CheckRelatedSOBeforePosting();
                //<<HEI.08
            end;

            trigger OnAfterAction()
            var
            begin
                //>>HEI.08
                UpdateCashRcptInfoInRltdSOHdr();
                //<<HEI.08
                //UpdateAPIInterfaceLog; //HEI.07  // BC Upgrade SHUKLP03 << Moved OnAfterAction triggers in interface extension because of Procedure UpdateAPIInterfaceLog().

            end;

            // BC Upgrade SHUKLP03 <<
        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send Approval Request', FRA = 'Envoyer demande d''approbation';
        }
        modify(SendApprovalRequestJournalBatch)
        {
            CaptionML = ENU = 'Journal Batch', FRA = 'Feuille';
            ToolTipML = ENU = 'Send all journal lines for approval, also those that you may not see because of filters.', FRA = 'Envoyez toutes les lignes feuilles pour approbation, y compris celles que vous ne voyez peut-être pas à cause de filtres.';
        }
        modify(SendApprovalRequestJournalLine)
        {
            CaptionML = ENU = 'Selected Journal Lines', FRA = 'Lignes feuille sélectionnées';
            ToolTipML = ENU = 'Send selected journal lines for approval.', FRA = 'Envoyez certaines lignes feuille pour approbation.';
        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Request', FRA = 'Annuler demande d''approbation';
        }
        modify(CancelApprovalRequestJournalBatch)
        {
            CaptionML = ENU = 'Journal Batch', FRA = 'Feuille';
            ToolTipML = ENU = 'Cancel sending all journal lines for approval, also those that you may not see because of filters.', FRA = 'Annulez l''envoi de toutes les lignes feuilles pour approbation, y compris celles que vous ne voyez peut-être pas à cause de filtres.';
        }
        modify(CancelApprovalRequestJournalLine)
        {
            CaptionML = ENU = 'Selected Journal Lines', FRA = 'Lignes feuille sélectionnées';
            ToolTipML = ENU = 'Cancel sending selected journal lines for approval.', FRA = 'Annulez l''envoi de certaines lignes feuilles pour approbation.';
        }
        modify(Approval)
        {
            CaptionML = ENU = 'Approval', FRA = 'Approbation';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Approve)
        {
            CaptionML = ENU = 'Approve', FRA = 'Approuver';
            ToolTipML = ENU = 'Approve the requested changes.', FRA = 'Approuvez les modifications requises.';
        }
        modify(Reject)
        {
            CaptionML = ENU = 'Reject', FRA = 'Rejeter';
            ToolTipML = ENU = 'Reject the approval request.', FRA = 'Rejetez la demande d''approbation.';
        }
        modify(Delegate)
        {
            CaptionML = ENU = 'Delegate', FRA = 'Déléguer';
            ToolTipML = ENU = 'Delegate the approval to a substitute approver.', FRA = 'Déléguez l''approbation à un approbateur remplaçant.';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comments', FRA = 'Commentaires';
            ToolTipML = ENU = 'View or add comments.', FRA = 'Affichez ou ajoutez des commentaires.';
        }

        //Unsupported feature: CodeInsertion on ""Test Report"(Action 43).OnAction". Please convert manually.

        //trigger (Variable: GenJournalLine)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Test Report"(Action 43).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReportPrint.PrintGenJnlLine(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //ReportPrint.PrintGenJnlLine(Rec); //HEI.04

        //HEI.04<<
        GenJnlTemplate.GET("Journal Template Name");
        CurrPage.SETSELECTIONFILTER(GenJournalLine);
        REPORT.RUN(GenJnlTemplate."Test Report ID",true,false, GenJournalLine);
        //HEI.04>>
        */
        //end;


        //Unsupported feature: CodeModification on "Post(Action 44).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SetupExternalDocNo; //HEI.07
        //>>HEI.08
        CheckRelatedSOBeforePosting;
        //<<HEI.08
        #1..3
        //>>HEI.08
        UpdateCashRcptInfoInRltdSOHdr;
        //<<HEI.08
        UpdateAPIInterfaceLog; //HEI.07
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Post and &Print"(Action 45).OnAction". Please convert manually.

        //trigger (Variable: CustLedgerEntry)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Post and &Print"(Action 45).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post+Print",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SetupExternalDocNo; //HEI.07
        //>>HEI.08
        CheckRelatedSOBeforePosting;
        //<<HEI.08

        #1..3
        //>>HEI.08
        UpdateCashRcptInfoInRltdSOHdr;
        //<<HEI.08
        UpdateAPIInterfaceLog; //HEI.07
        */
        //end;

        // BC Upgrade SHUKLP03 << DrinkIT actions.
        // addafter("Apply Entries")
        // {
        //     action("Apply Invoice List")
        //     {
        //         CaptionML = ENU = 'Apply Invoice List',
        //                     FRA = 'Lettrer liste facture';
        //         Description = 'DITW17.10.05  DIT-770 #761';
        //         Enabled = EnableActnIfTemplateNtBlck;
        //         Image = ApplyEntries;
        //         Promoted = true;
        //         PromotedCategory = Process;

        //         trigger OnAction();
        //         var
        //             lcduApplyInvList: Codeunit "Apply Invoice list";
        //         begin
        //             // <<DITW17.10.05 WSA 08/08/14 DIT-770 #761
        //             CLEAR(lcduApplyInvList);
        //             lcduApplyInvList.fctApplyInvoiceList(Rec);
        //             // >>DITW17.10.05 WSA 08/08/14 DIT-770 #761
        //         end;
        //     }
        // }
        // addafter("Insert Conv. LCY Rndg. Lines")
        // {
        //     separator(Separator1100083000)
        //     {
        //     }
        //     action("Suggest Route Settlement")
        //     {
        //         CaptionML = ENU = 'Suggest Route Settlement',
        //                     FRA = 'Suggérer route de déclaration';
        //         Ellipsis = true;
        //         Image = Suggest;

        //         trigger OnAction();
        //         var
        //             CreateRouteSettSuggest: Report "Suggest Customer Payments";
        //         begin
        //             // <<DITW15.00.00.26 DDR 18/11/2008
        //             CreateRouteSettSuggest.SetGenJnlLine(Rec);
        //             CreateRouteSettSuggest.RUNMODAL;
        //             CLEAR(CreateRouteSettSuggest);
        //         end;
        //     }
        //     action(SuggestCustPayments)
        //     {
        //         ApplicationArea = Basic, Suite;
        //         Caption = 'Suggest Customer Payments';
        //         Description = 'NRQ17902';
        //         Ellipsis = true;
        //         Enabled = EnableActnIfTemplateNtBlck;
        //         Image = SuggestCustomerPayments;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;
        //         ToolTip = 'Create payment suggestion as lines in the Cash Receipt Journal';

        //         trigger OnAction();
        //         var
        //             SuggestCustomerPayments: Report "Suggest Customer Payments";
        //         begin
        //             //<<DITW110.00.11 MSF 25/08/2017 NRQ#17902
        //             CLEAR(SuggestCustomerPayments);
        //             SuggestCustomerPayments.SetGenJnlLine(Rec);
        //             SuggestCustomerPayments.RUNMODAL;
        //             //>>DITW110.00.11 MSF 25/08/2017 NRQ#17902
        //         end;
        //     }
        //     separator(Separator55005)
        //     {
        //     }
        // BC Upgrade SHUKLP03 << DrinkIT actions.

        // BC Upgrade SHUKLP03 >> blocked 10843 ID report.
        // action(PrintCheckRemittanceReport)
        // {
        //     ApplicationArea = Basic, Suite;
        //     CaptionML = ENU = 'Print Check Remittance Report',
        //                 FRA = 'Imprimer bordereau de remise';
        //     Enabled = FRLocAction;
        //     Image = PrintCheck;
        //     Visible = FRLocAction;

        //     trigger OnAction();
        //     begin
        //         CreateRecapitulation.SETTABLEVIEW(Rec);
        //         CreateRecapitulation.RUNMODAL;
        //         CLEAR(CreateRecapitulation);
        //     end;
        // }

        //}
        // BC Upgrade SHUKLP03 << blocked 10843 ID report.

        addafter(Reconcile)
        {
            action("Test Report Custom")  // Created custom action with same name to block base code.
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Test Report';
                Ellipsis = true;
                Image = TestReport;
                ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                trigger OnAction()
                var
                    TestReportPrint: Codeunit "Test Report-Print";
                begin
                    //TestReportPrint.PrintGenJnlLine(Rec); //HEI.04

                    //HEI.04<<
                    GenJnlTemplate.GET(Rec."Journal Template Name");
                    CurrPage.SETSELECTIONFILTER(GenJournalLine);
                    REPORT.RUN(GenJnlTemplate."Test Report ID", TRUE, FALSE, GenJournalLine);
                    //HEI.04>>

                end;
            }

        }
        // BC Upgrade SHUKLP03 >> DrinkIT actions
        // addafter(Approval)
        // {
        //     group("&Print")
        //     {
        //         CaptionML = ENU = '&Print',
        //                     FRA = '&Imprimer';
        //         Enabled = EnableActnIfTemplateNtBlck;
        //         action("Route Settlement")
        //         {
        //             CaptionML = ENU = 'Route Settlement',
        //                         FRA = 'Déclaration Route';
        //             Ellipsis = true;
        //             Image = Route;

        //             trigger OnAction();
        //             var
        //                 lcduTransportPrint: Codeunit "Transport Report-Print";
        //             begin
        //                 // <<DITW15.00.00.26 DDR 20/11/2008
        //                 lcduTransportPrint.PrintGenJnlLineRouteSett(Rec);
        //             end;
        //         }
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT actions.
    }

    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        RPMPaymentEnabled: Boolean;
        "Source No.Editable": Boolean;
        SourceTypeEditable: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        CompanyInfo: Record "Company Information";
        FRLocAction: Boolean;
        //CreateRecapitulation: Report "Recapitulation Form";  // BC Upgrade SHUKLP03 >> blocked 10843 ID report.
        ExternalDocNo: Code[35];
        SalesOrderNo: Code[20];
        CashRcptDocType: Option Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back","Purchase Receipt","Interest Rate Credit","RPM Damage or Loss","FFE Security Payment";
        EnableActnIfTemplateNtBlck: Boolean;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    trigger OnAfterGetCurrRecord();
    begin
        EnableActnIfTemplateNtBlck := Rec.EnableActionIfTemplateNtBlock();     //HEI.10

        //HEI.03>>
        if (Rec."Account Type" = Rec."Account Type"::"G/L Account") and (Rec."Bal. Account Type" = Rec."Bal. Account Type"::"G/L Account") then begin
            SourceTypeEditable := true;
            "Source No.Editable" := true;
        end
        else begin
            SourceTypeEditable := false;
            "Source No.Editable" := false;
        end;
        //HEI.03<<
    end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT field "Item Charge Type" is used .   
        // //HEI.02>>
        // RPMPaymentEnabled := ("Item Charge Type" = "Item Charge Type"::Deposit) and
        //                      ("Account Type" = "Account Type"::Customer) and
        //                      ("Document Type" = "Document Type"::Payment);
        // //HEI.02<<
        // BC Upgrade SHUKLP03 << DrinkIT field "Item Charge Type" is used .   
    end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    trigger OnOpenPage();
    begin
        //HEI.03>>
        if (Rec."Account Type" = Rec."Account Type"::"G/L Account") and (Rec."Bal. Account Type" = Rec."Bal. Account Type"::"G/L Account") then begin
            SourceTypeEditable := true;
            "Source No.Editable" := true;
        end
        else begin
            SourceTypeEditable := false;
            "Source No.Editable" := false;
        end;
        //HEI.03<<

        // BC Upgrade SHUKLP03 >> FR Localization code is blocked.
        // //HEI.05>>
        // FRLocAction := false;
        // CompanyInfo.GET;
        // if CompanyInfo."Enable French Localization" then
        //     FRLocAction := true;
        // //HEI.05<<
        // BC Upgrade SHUKLP03 << FR Localization code is blocked.

        //HEI.10>>
        CLEAR(EnableActnIfTemplateNtBlck);
        EnableActnIfTemplateNtBlck := true;
        //HEI.10<<
    end;

    local procedure UpdateRPMPaymentFields();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT field "Item Charge Type" is used .
        //     //HEI.02>>
        //     RPMPaymentEnabled := false;
        //     if ("Item Charge Type" = "Item Charge Type"::Deposit) and
        //        ("Account Type" = "Account Type"::Customer) and
        //        ("Document Type" = "Document Type"::Payment)
        //     then begin
        //         RPMPaymentEnabled := true;
        //         CurrPage.UPDATE;
        //     end;
        //     //HEI.02<<
        // BC Upgrade SHUKLP03 >> DrinkIT field "Item Charge Type" is used .
    end;


    local procedure SetupExternalDocNo();
    begin
        //HEI.07>>
        ExternalDocNo := Rec."External Document No.";
        //HEI.07<<
    end;

    // BC Upgrade SHUKLP03 >> Moved UpdateAPIInterfaceLog procedure in interface extension.
    // local procedure UpdateAPIInterfaceLog();
    // var
    //     APIInterfaceLog: Record "API Interface Log2";
    // begin
    //     //HEI.07>>
    //     if ExternalDocNo <> '' then begin
    //         APIInterfaceLog.SETRANGE("Message ID", ExternalDocNo);
    //         if APIInterfaceLog.FINDFIRST then
    //             if APIInterfaceLog."Posting Status" = APIInterfaceLog."Posting Status"::Error then begin
    //                 APIInterfaceLog."Posting Status" := APIInterfaceLog."Posting Status"::Processed;
    //                 APIInterfaceLog.MODIFY;
    //             end;
    //     end;
    //     //HEI.07<<
    // end;
    // BC Upgrade SHUKLP03 << Moved UpdateAPIInterfaceLog procedure in interface extension.


    local procedure CheckRelatedSOBeforePosting();
    var
        SalesHeader: Record "Sales Header";
    begin
        //>>HEI.08
        SalesOrderNo := '';
        if (Rec."Sales/Archived Order Type FND" = Rec."Sales/Archived Order Type FND"::"Sales Order") and (Rec."Related Sales Order FND" <> '') then begin
            if SalesHeader.GET(SalesHeader."Document Type"::Order, Rec."Related Sales Order FND") then
                SalesOrderNo := SalesHeader."No.";
        end;
        //<<HEI.08
    end;

    local procedure UpdateCashRcptInfoInRltdSOHdr();
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SalesHeader: Record "Sales Header";
    begin
        //>>HEI.08
        if SalesOrderNo <> '' then begin
            CustLedgerEntry.RESET();
            CustLedgerEntry.SETRANGE("Related Sales Order No. FND", SalesOrderNo);
            if CustLedgerEntry.FINDLAST() then
                if not (CustLedgerEntry."Document Type" in [CustLedgerEntry."Document Type"::"Purchase Receipt", CustLedgerEntry."Document Type"::"Interest Rate Credit",
                        CustLedgerEntry."Document Type"::"RPM Damage or Loss", CustLedgerEntry."Document Type"::"FFE Security Payment"])
                then
                    if SalesHeader.GET(SalesHeader."Document Type"::Order, SalesOrderNo) then begin
                        SalesHeader."Applies-to Doc. Type" := CustLedgerEntry."Document Type";
                        SalesHeader."Applies-to Doc. No." := CustLedgerEntry."Document No.";
                        SalesHeader.MODIFY();
                    end;
        end;
        //<<HEI.08
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

