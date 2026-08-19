pageextension 51149 ApplyVendorEntriesExtCBN extends "Apply Vendor Entries"
{
    // DITW15.00.00.35 DDR 10/09/2009 Added function SetService()
    //                                Added optionstring 'ServHeader' for variable CalcType
    //                     06/05/2009 Added columns (non-visible)
    //                                  "Contract Group Code"
    //                     01/10/2009 Added check to apply (direct) entries within "Contract Group Code"
    //                                Added control ApplnContractGroupCode into General tab
    // DITW15.00.00.37 DDR 27/01/2010 issue 1036 Bugfix to show value as filter for "Contract Group Code" (header)
    //                     10/05/2010 issue 857 Add field to show value as filter for "DIT Sub-Contract Type" (header/column)
    //                     01/06/2010 issue 857 Added Not visible by default for all DIT fields
    //                                          Added call function to check fields "DIT Sub-Contract Type","Contract Group Code"
    //                                          Added function GetApplyingVendLedgEntry()
    //                                          Standard Bugfix if unapply all records and click Cancel (or Escape key) the
    //                                            field "Applies-to ID" is not cleared.
    //                     29/07/2010 issue 1213 Bugfix to assign and calculate application amount while
    //                                             open from Service Purchase Header (field "Applies-to Doc. no.")
    //                     30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    // DITW15.00.00.38 DDR 10/12/2010 issue 1173 Bugfix to check "DIT Sub-Contract Type","Contract Group Code" while applying entry
    // DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added fields "Service Contract Type","Service Contract No."
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "Item Charge Type"
    //                                             Added filter on field "Item Charge Type"
    //                                             Added GL Setup field "Appln. per Source reference"
    //                 DDR 12/04/2013 DIT-715 #612 Bugfix remove filter contract group in function FindApplyingEntry()
    //                                             Bugfix std. avoid to call codeunit "Vendor Entry-Edit" when no vendor ledger entry
    // DITW16.00.00.43 DDR 21/11/2013 DIT-715 #827 Bugfixx std to set application <> header values

    // FINXL7.00.001 RBE 20/03/2013 : Advanced application

    // DITW17.00.02 DDR 21/11/2013 DIT-715 #827 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 19/12/2013 DIT-770 #163 : New Field "Vendor Posting Group" Added
    // DITW17.10.03 AT  05/02/2014 DIT-770 #340 : Added Vendor Posting Group
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field 2014319  "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Rename Option DIT Contract,Service Contract by Financial,Service
    //                                           Added blank Option to Contract Type

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
    //                                  2014109 Route Planning No.
    //                                  2014421 Document Subtype Code
    // HEI.01 defect #2452 IBM POSTOI01 08.08.2018
    //   # modify SetVendApplId : add restriction for already proposed documents to any further application
    //----------------------------------------------------------------------------------------------------------------------------------
    //BC Upgrade Kamnay01<< code in page "Apply Vendor Entries event subscribe in codeunit 50283 "Heineken Page Cu"[EventSubscriber(ObjectType::Page, Page::"Apply Vendor Entries", OnSetVendApplIdOnAfterCheckAgainstApplnCurrency, '', false, false)]


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("ApplyingVendLedgEntry.""Posting Date""")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
            ToolTipML = ENU = 'Specifies the posting date of the entry to be applied.', FRA = 'Indique la date comptabilisation de l''écriture à appliquer.';
        }
        modify("ApplyingVendLedgEntry.""Document Type""")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            ToolTipML = ENU = 'Specifies the document type of the entry to be applied.', FRA = 'Indique le type de document de l''écriture à appliquer.';
            // BC Upgrade MISHRS14 >>
            // Blocked as enum to remove warning.
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';
            // BC Upgrade MISHRS14 <<
        }
        modify("ApplyingVendLedgEntry.""Document No.""")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
            ToolTipML = ENU = 'Specifies the document number of the entry to be applied.', FRA = 'Indique le numéro de document de l''écriture à appliquer.';
        }
        modify(ApplyingVendorNo)
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
            ToolTipML = ENU = 'Specifies the vendor number of the entry to be applied.', FRA = 'Indique le numéro fournisseur de l''écriture à appliquer.';
        }
        modify(ApplyingDescription)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
            ToolTipML = ENU = 'Specifies the description of the entry to be applied.', FRA = 'Indique la description de l''écriture à appliquer.';
        }
        modify("ApplyingVendLedgEntry.""Currency Code""")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
            ToolTipML = ENU = 'Specifies the currency code of the entry to be applied.', FRA = 'Indique le code devise de l''écriture à appliquer.';
        }
        modify("ApplyingVendLedgEntry.Amount")
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
            ToolTipML = ENU = 'Specifies the amount on the entry to be applied.', FRA = 'Indique le montant de l''écriture à appliquer.';
        }
        modify("ApplyingVendLedgEntry.""Remaining Amount""")
        {
            CaptionML = ENU = 'Remaining Amount', FRA = 'Montant ouvert';
            ToolTipML = ENU = 'Specifies the amount on the entry to be applied.', FRA = 'Indique le montant de l''écriture à appliquer.';
        }
        //BC update Kamnay01>>The control '"Applies-to ID"' is not found in the target 'Apply Vendor Entries'
        // modify("Applies-to ID")
        // {
        //     ToolTipML = ENU = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.', FRA = 'Spécifie l''ID de lettrage des écritures lorsque vous choisissez l''action Ecr. ouvertes.';
        // }
        //BC update Kamnay01<<The control '"Applies-to ID"' is not found in the target 'Apply Vendor Entries'
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
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the vendor entry.', FRA = 'Spécifie la description de l''écriture fournisseur.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code for the amount on the line.', FRA = 'Spécifie le code devise du montant de la ligne.';
        }
        modify("Original Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of the original entry.', FRA = 'Spécifie le montant de l''écriture d''origine.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the amount of the entry.', FRA = 'Spécifie le montant de l''écriture.';
        }
        modify("Remaining Amount")
        {
            ToolTipML = ENU = 'Specifies the amount that remains to be applied to before the entry is totally applied to.', FRA = 'Spécifie le montant qui reste à lettrer avant que l''écriture ne soit totalement lettrée.';
        }
        modify("CalcApplnRemainingAmount(""Remaining Amount"")")
        {
            CaptionML = ENU = 'Appln. Remaining Amount', FRA = 'Montant ouvert lettrage';
            ToolTipML = ENU = 'Specifies the amount that remains to be applied to before the entry is totally applied to.', FRA = 'Spécifie le montant qui reste à lettrer avant que l''écriture ne soit totalement lettrée.';
        }
        modify("Amount to Apply")
        {
            ToolTipML = ENU = 'Specifies the amount to apply.', FRA = 'Indique le montant à appliquer.';
        }
        //BC Update Kamnay01 >>The control 'CalcApplnAmounttoApply' is not found in the target 'Apply Vendor Entries'
        // modify("CalcApplnAmounttoApply(""Amount to Apply"")")
        // {
        //     CaptionML = ENU = 'Appln. Amount to Apply', FRA = 'Application du montant à lettrer';
        //     ToolTipML = ENU = 'Specifies the amount to apply.', FRA = 'Indique le montant à appliquer.';
        // }
        //BC Update Kamnay01 <<The control 'CalcApplnAmounttoApply' is not found in the target 'Apply Vendor Entries'
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
        modify("Payment Reference")
        {
            ToolTipML = ENU = 'Specifies the payment of the purchase invoice.', FRA = 'Spécifie le paiement de la facture achat.';
        }
        modify("Original Pmt. Disc. Possible")
        {
            ToolTipML = ENU = 'Specifies the discount that you can obtain if the entry is applied to before the payment discount date.', FRA = 'Spécifie l''escompte que vous pouvez obtenir si l''écriture est lettrée avant la date d''escompte.';
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            ToolTipML = ENU = 'Specifies the remaining payment discount which can be received if the payment is made before the payment discount date.', FRA = 'Spécifie l''escompte ouvert pouvant être reçu si le paiement est effectué avant la date d''escompte.';
        }
        modify("CalcApplnRemainingAmount(""Remaining Pmt. Disc. Possible"")")
        {
            CaptionML = ENU = 'Appln. Pmt. Disc. Possible', FRA = 'Escompte possible lettrage';
            ToolTipML = ENU = 'Specifies the discount that you can obtain if the entry is applied to before the payment discount date.', FRA = 'Spécifie l''escompte que vous pouvez obtenir si l''écriture est lettrée avant la date d''escompte.';
        }
        modify("Max. Payment Tolerance")
        {
            ToolTipML = ENU = 'Specifies the maximum tolerated amount the entry can differ from the amount on the invoice or credit memo.', FRA = 'Spécifie l''écart maximal toléré entre l''écriture et le montant de la facture ou de l''avoir.';
        }
        modify(Open)
        {
            ToolTipML = ENU = 'Specifies whether the amount on the entry has been fully paid or there is still a remaining amount that must be applied to.', FRA = 'Spécifie si le montant de l''écriture a été totalement payé ou si un montant reste encore à lettrer.';
        }
        modify(Positive)
        {
            ToolTipML = ENU = 'Specifies if the entry to be applied is positive.', FRA = 'Indique si le montant de l''écriture à appliquer est positif.';
        }
        modify("Global Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code for the entry.', FRA = 'Indique le code section analytique de l''écriture.';
        }
        modify("Global Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code for the entry.', FRA = 'Indique le code section analytique de l''écriture.';
        }
        modify("Appln. Currency")
        {
            CaptionML = ENU = 'Appln. Currency', FRA = 'Dev. écriture lettrage';
        }
        modify(ApplnCurrencyCode)
        {
            ToolTipML = ENU = 'Specifies the currency code that the amount will be applied in, in case of different currencies.', FRA = 'Indique le code devise dans lequel le montant sera appliqué, en cas de devises différentes.';
        }
        modify(Control1900545201)
        {
            CaptionML = ENU = 'Amount to Apply', FRA = 'Montant à lettrer';
        }
        modify(AmountToApply)
        {
            CaptionML = ENU = 'Amount to Apply', FRA = 'Montant à lettrer';
            ToolTipML = ENU = 'Specifies the sum of the amounts on all the selected vendor ledger entries that will be applied by the entry shown in the Available Amount field. The amount is in the currency represented by the code in the Currency Code field.', FRA = 'Indique la somme des montants de toutes les écritures comptables fournisseur sélectionnées avec lesquelles vous souhaitez lettrer l''écriture mentionnée dans le champ Montant disponible. Le montant est indiqué dans la devise représentée par le code du champ Code devise.';
        }
        modify("Pmt. Disc. Amount")
        {
            CaptionML = ENU = 'Pmt. Disc. Amount', FRA = 'Paiement escompte';
        }
        //BC Update Kamnay01 >>The control 'PmtDiscAmount' is not found in the target 'Apply Vendor Entries'
        // modify(PmtDiscAmount)
        // {
        //     CaptionML = ENU = 'Pmt. Disc. Amount', FRA = 'Paiement escompte';
        //     ToolTipML = ENU = 'Specifies the sum of the payment discount amounts granted on all the selected vendor ledger entries that will be applied by the entry shown in the Available Amount field. The amount is in the currency represented by the code in the Currency Code field.', FRA = 'Indique la somme des montants de tous les escomptes tardifs accordés sur toutes les écritures comptables fournisseur sélectionnées qui seront appliquées par l''écriture mentionnée dans le champ Montant disponible. Le montant est indiqué dans la devise représentée par le code du champ Code devise.';
        // }
        //BC Update Kamnay01 <<The control 'PmtDiscAmount' is not found in the target 'Apply Vendor Entries'
        modify(Rounding)
        {
            CaptionML = ENU = 'Rounding', FRA = 'Arrondi';
        }
        modify(ApplnRounding)
        {
            CaptionML = ENU = 'Rounding', FRA = 'Arrondi';
            ToolTipML = ENU = 'Specifies the rounding difference when you apply entries in different currencies to one another. The amount is in the currency represented by the code in the Currency Code field.', FRA = 'Indique la différence d''arrondi lorsque vous lettrez des écritures en différentes devises. Le montant est indiqué dans la devise correspondant au code indiqué dans le champ Code devise.';
        }
        modify("Applied Amount")
        {
            CaptionML = ENU = 'Applied Amount', FRA = 'Montant lettré';
        }
        modify(AppliedAmount)
        {
            CaptionML = ENU = 'Applied Amount', FRA = 'Montant lettré';
            ToolTipML = ENU = 'Specifies the sum of the amounts in the Amount to Apply field, Pmt. Disc. Amount field, and the Rounding. The amount is in the currency represented by the code in the Currency Code field.', FRA = 'Indique la somme des montants des champs Montant à lettrer, Paiement escompte et Arrondi. Le montant est indiqué dans la devise correspondant au code indiqué dans le champ Code devise.';
        }
        modify("Available Amount")
        {
            CaptionML = ENU = 'Available Amount', FRA = 'Montant disponible';
        }
        modify(ApplyingAmount)
        {
            CaptionML = ENU = 'Available Amount', FRA = 'Montant disponible';
            ToolTipML = ENU = 'Specifies the amount of the journal entry, purchase credit memo, or current vendor ledger entry that you have selected as the applying entry.', FRA = 'Spécifie le montant de l''écriture feuille, de l''écriture avoir achat ou de l''écriture comptable fournisseur actuelle que vous avez sélectionnée comme écriture de lettrage.';
        }
        modify(Balance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify(ControlBalance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
            ToolTipML = ENU = 'Specifies any extra amount that will remain after the application.', FRA = 'Spécifie tout montant supplémentaire qui subsiste après le lettrage.';
        }
        //BC Update Kamnay01 >>DITW Fields 
        // addafter("ApplyingVendLedgEntry.""Currency Code""")
        // {
        //     field("ApplyingVendLedgEntry.""Vendor Posting Group""";ApplyingVendLedgEntry."Vendor Posting Group")
        //     {
        //         CaptionML = ENU='Vendor Posting Group',
        //                     FRA='Groupe compta. fournisseur';
        //         Editable = false;
        //     }
        //     field("ApplyingVendLedgEntry.""Item Charge Type""";ApplyingVendLedgEntry."Item Charge Type")
        //     {
        //         CaptionML = ENU='Item Charge Type',
        //                     FRA='Type frais annexes';
        //         Editable = false;
        //         OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                           FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     }
        //     field("ApplyingVendLedgEntry.""Contract Type""";ApplyingVendLedgEntry."Contract Type")
        //     {
        //         CaptionML = ENU='Contract Type',
        //                     FRA='Type contrat';
        //         Description = 'DIT-715 #392 #327';
        //         Editable = false;
        //         OptionCaptionML = ENU=' ,Service,Financial',
        //                           FRA=' ,Service,Financier';
        //     }
        //     field("ApplyingVendLedgEntry.""Service Contract No.""";ApplyingVendLedgEntry."Service Contract No.")
        //     {
        //         CaptionML = ENU='Service Contract No.',
        //                     FRA='N° contrat de service';
        //         Description = 'DIT-715 #392 #327';
        //         Editable = false;
        //     }
        //     field("VendLedgEntry.""DIT Sub-Contract Type""";VendLedgEntry."DIT Sub-Contract Type")
        //     {
        //         CaptionML = ENU='Sub Contract Type',
        //                     FRA='Sous type contrat';
        //         Editable = false;
        //         OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other',
        //                           FRA=' ,Location,Prêt,Mise à disposition,Maintenance,Divers';
        //     }
        //     field("ApplyingVendLedgEntry.""Contract Group Code""";ApplyingVendLedgEntry."Contract Group Code")
        //     {
        //         CaptionML = ENU='Contract Group Code',
        //                     FRA='Code groupe contrat';
        //         Editable = false;
        //     }
        // }

        // addafter(General)
        // {
        //     group("Filter")
        //     {
        //         CaptionML = ENU = 'Filter',
        //                     FRA = 'Filtre';
        //         Description = 'FINXL7.00.001';
        //         field("rVendLedgEntry.""Vendor No."""; rVendLedgEntry."Vendor No.")
        //         {
        //             CaptionML = ENU = 'Vendor No.',
        //                         FRA = 'N° fournisseur';
        //             Description = 'FINXL7.00.001';

        //             trigger OnValidate();
        //             begin
        //                 rVendLedgEntryVendorNoOnAfterV;
        //             end;
        //         }
        //         field("rVendLedgEntry.""Document Type"""; rVendLedgEntry."Document Type")
        //         {
        //             CaptionML = ENU = 'Document Type',
        //                         FRA = 'Type document';
        //             Description = 'FINXL7.00.001';
        //             OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund',
        //                               FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';

        //             trigger OnValidate();
        //             begin
        //                 rVendLedgEntryDocumentTypeOnAf;
        //             end;
        //         }
        //         field("rVendLedgEntry.""Document No."""; rVendLedgEntry."Document No.")
        //         {
        //             CaptionML = ENU = 'Document No.',
        //                         FRA = 'N° Document';
        //             Description = 'FINXL7.00.001';

        //             trigger OnValidate();
        //             begin
        //                 rVendLedgEntryDocumentNoOnAfte;
        //             end;
        //         }
        //         field("rVendLedgEntry.Description"; rVendLedgEntry.Description)
        //         {
        //             CaptionML = ENU = 'Description',
        //                         FRA = 'Désignation';
        //             Description = 'FINXL7.00.001';

        //             trigger OnValidate();
        //             begin
        //                 rVendLedgEntryDescriptionOnAft;
        //             end;
        //         }
        //         field(DatDocDateFrom; DatDocDateFrom)
        //         {
        //             CaptionML = ENU = 'Document Date From',
        //                         FRA = 'Date document de';
        //             Description = 'FINXL7.00.001';

        //             trigger OnValidate();
        //             begin
        //                 DatDocDateFromOnAfterValidate;
        //             end;
        //         }
        //         field(DatDocDateTo; DatDocDateTo)
        //         {
        //             CaptionML = ENU = 'Document Date To',
        //                         FRA = 'Date document à';
        //             Description = 'FINXL7.00.001';

        //             trigger OnValidate();
        //             begin
        //                 DatDocDateToOnAfterValidate;
        //             end;
        //         }
        //         field(AmountFrom; AmountFrom)
        //         {
        //             CaptionML = ENU = 'Amount From',
        //                         FRA = 'Montant de';
        //             Description = 'FINXL7.00.001';

        //             trigger OnValidate();
        //             begin
        //                 AmountFromOnAfterValidate;
        //             end;
        //         }
        //         field(AmountTo; AmountTo)
        //         {
        //             CaptionML = ENU = 'Amount To',
        //                         FRA = 'Montant à';
        //             Description = 'FINXL7.00.001';

        //             trigger OnValidate();
        //             begin
        //                 AmountToOnAfterValidate;
        //             end;
        //         }
        //     }
        // }

        // addafter("Global Dimension 2 Code")
        // {
        //     field("Route Planning No.";"Route Planning No.")
        //     {
        //         Visible = false;
        //     }
        // }
        //BC Update Kamnay01 <<DITW Fields
    }
    actions
    {
        modify("Ent&ry")
        {
            CaptionML = ENU = 'Ent&ry', FRA = 'É&criture';
        }
        modify("Applied E&ntries")
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
            ToolTipML = ENU = 'View a summary of the all posted entries and adjustments related to a specific vendor ledger entry.', FRA = 'Affichez un récapitulatif de toutes les écritures et tous les ajustements validés en relation avec une écriture comptable d''un fournisseur spécifique.';
        }
        modify(Navigate)
        {
            CaptionML = ENU = '&Navigate', FRA = '&Naviguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document sélectionné(e).';
        }
        modify("&Application")
        {
            CaptionML = ENU = '&Application', FRA = '&Lettrage';
        }
        modify(ActionSetAppliesToID)
        {
            CaptionML = ENU = 'Set Applies-to ID', FRA = 'Lettrer';
            ToolTipML = ENU = 'Set the Applies-to ID field on the posted entry to automatically be filled in with the document number of the entry in the journal.', FRA = 'Définissez le champ ID lettrage sur l''écriture validée comment étant automatiquement renseigné avec le numéro de document de l''écriture dans la feuille.';
        }
        modify(ActionPostApplication)
        {
            CaptionML = ENU = 'Post Application', FRA = 'Valider le lettrage';
            ToolTipML = ENU = 'Define the document number of the ledger entry to use to perform the application. In addition, you specify the Posting Date for the application.', FRA = 'Définissez le numéro de document de l''écriture comptable à utiliser pour exécuter l''application. En outre, vous pouvez spécifier la date comptabilisation de l''application.';
        }
        modify(Preview)
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
        }
        modify("-")
        {
            CaptionML = ENU = '-', FRA = '-';
        }
        modify("Show Only Selected Entries to Be Applied")
        {
            CaptionML = ENU = 'Show Only Selected Entries to Be Applied', FRA = 'Afficher uniquement les écritures à lettrer';
            ToolTipML = ENU = 'View the selected ledger entries that will be applied to the specified record.', FRA = 'Affichez les écritures comptables sélectionnées qui seront appliquées à l''enregistrement spécifié.';
        }
    }

    var
        lrAppliedVendLedgEntry: Record "Vendor Ledger Entry";


    //Unsupported feature: PropertyModification on "CalcType(Variable 1027)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CalcType : Direct,GenJnlLine,PurchHeader;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CalcType : Direct,GenJnlLine,PurchHeader,ServHeader;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1036)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You must select an applying entry before you can post the application.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You must select an applying entry before you can post the application.;FRA=Pour pouvoir valider le lettrage, vous devez sélectionner une écriture lettrage.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1035)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=You must post the application from the window where you entered the applying entry.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=You must post the application from the window where you entered the applying entry.;FRA=Vous devez valider le lettrage à partir de la fenêtre dans laquelle vous avez entré l'écriture lettrage.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotSetAppliesToIDErr(Variable 1038)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotSetAppliesToIDErr : ENU=You cannot set Applies-to ID while selecting Applies-to Doc. No.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotSetAppliesToIDErr : ENU=You cannot set Applies-to ID while selecting Applies-to Doc. No.;FRA=Vous ne pouvez pas définir l'ID lettrage lorsque vous sélectionnez le numéro doc. lettrage.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "EarlierPostingDateErr(Variable 1034)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //EarlierPostingDateErr : ENU=You cannot apply and post an entry to an entry with an earlier posting date.\\Instead, post the document of type %1 with the number %2 and then apply it to the document of type %3 with the number %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //EarlierPostingDateErr : ENU=You cannot apply and post an entry to an entry with an earlier posting date.\\Instead, post the document of type %1 with the number %2 and then apply it to the document of type %3 with the number %4.;FRA=Vous ne pouvez pas lettrer ni valider une écriture dans une écriture disposant d'une date comptabilisation antérieure.\\Validez plutôt le document de type %1 avec le numéro %2, puis lettrez-le dans le document de type %3 avec le numéro %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1043)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=The application was successfully posted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=The application was successfully posted.;FRA=Le lettrage a été validé avec succès.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text013(Variable 1044)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=The %1 entered must not be before the %1 on the %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=The %1 entered must not be before the %1 on the %2.;FRA=La %1 entrée ne doit pas être antérieure à la %1 sur %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text019(Variable 1045)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text019 : ENU=Post application process has been canceled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text019 : ENU=Post application process has been canceled.;FRA=Le processus de validation du lettrage a été annulé.;
    //Variable type has not been exported.

    var
        _CalcType: Option Direct,GenJnlLine,PurchHeader;

    var
        rVendLedgEntry: Record "Vendor Ledger Entry";
        ApplnContractGroupCode: Code[10];
        ApplnContractNo: Code[20];
        ApplnVendorPostingGroup: Code[20];
        DatDocDateFrom: Date;
        DatDocDateTo: Date;
        AmountFrom: Decimal;
        AmountTo: Decimal;
        ApplnSubContractType: Option " ",Rent,Loan,LoanInUse,Maintenance,Other;
        //DITPurchServMgtSetup: Record "Property Purch Serv Mgt. Setup"; //BC Update Kamnay01 DITW Variable
        ApplnContractType: Option " ",Service,Financial;
        ApplnItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        //BC Update Kamnay01 >>DITW Variable
        // ServPurchHeader : Record "Service Purchase Header";
        // TotalServPurchLine : Record "Service Purchase Line" temporary;
        // TotalServPurchLineLCY : Record "Service Purchase Line" temporary;
        //BC Update Kamnay01 <<DITW Variable
        Text2034840: TextConst ENU = 'All entries in one application must be in the same %1.', FRA = 'La même %1 doit être utilisée pour toutes les écritures lettrage.';
    // recFinXLSetup: Record "Finance XL Setup"; //BC Update Kamnay01 DITW Variable


    var
        Text020: Label 'The %1 document is already present on proposal in journal %2';


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if CalcType = CalcType::Direct then begin
      Vend.GET("Vendor No.");
      ApplnCurrencyCode := Vend."Currency Code";
    #4..11
      CalcApplnAmount;
    PostingDone := false;
    IsOfficeAddin := OfficeMgt.IsAvailable;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<<FINXL7.00.001 RBE 20/03/2013
    if recFinXLSetup.READPERMISSION then
      if COUNT = 0 then
        SETRANGE("Vendor No.");
    //>>FINXL7.00.001 RBE 20/03/2013

    #1..14
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnQueryClosePage". Please convert manually.

    //trigger (Variable: lrAppliedVendLedgEntry)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnQueryClosePage". Please convert manually.

    //trigger OnQueryClosePage(CloseAction : Action) : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if CloseAction = ACTION::LookupOK then
      LookupOKOnPush;
    if ApplnType = ApplnType::"Applies-to Doc. No." then begin
    #4..9
      if OK then begin
        if "Amount to Apply" = 0 then
          "Amount to Apply" := "Remaining Amount";
        CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",Rec);
      end;
    end;

    #17..19
      if AppliesToID = '' then begin
        "Applies-to ID" := '';
        "Amount to Apply" := 0;
      end;
      CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",Rec);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
        // <<DITW16.00.00.42 DDR 12/04/2013 DIT-715 #612
        if lrAppliedVendLedgEntry.GET("Entry No.") then
        // >>DITW16.00.00.42 DDR DIT-715 #612
          CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",Rec);
    #14..22
        // <<DITW16.00.00.42 DDR 12/04/2013 DIT-715 #612
        if lrAppliedVendLedgEntry.GET("Entry No.") then
        // >>DITW16.00.00.42 DDR DIT-715 #612
          CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",Rec);
      end;
    end;
    // <<DITW15.00.00.37 DDR 01/06/2010 (bug standard)
    if GenJnlLineApply and (ApplnType = ApplnType::"Applies-to ID") and ("Applies-to ID" <> '') then begin
      lrAppliedVendLedgEntry.SETCURRENTKEY("Vendor No.","Applies-to ID");
      lrAppliedVendLedgEntry.SETRANGE("Vendor No.","Vendor No.");
      lrAppliedVendLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
      if lrAppliedVendLedgEntry.ISEMPTY then
        "Applies-to ID" := '';
    end;
    // >>DITW15.00.00.37 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "SetApplyingVendLedgEntry(PROCEDURE 9)". Please convert manually.

    //procedure SetApplyingVendLedgEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    case CalcType of
      CalcType::PurchHeader:
        begin
    #4..18
          end;
          CalcApplnAmount;
        end;
      CalcType::Direct:
        begin
          if "Applying Entry" then begin
    #25..37
            ApplyingAmount := ApplyingVendLedgEntry."Remaining Amount";
            ApplnDate := ApplyingVendLedgEntry."Posting Date";
            ApplnCurrencyCode := ApplyingVendLedgEntry."Currency Code";
          end;
          CalcApplnAmount;
        end;
      CalcType::GenJnlLine:
        begin
          ApplyingVendLedgEntry."Posting Date" := GenJnlLine."Posting Date";
    #47..56
          ApplyingVendLedgEntry."Currency Code" := GenJnlLine."Currency Code";
          ApplyingVendLedgEntry.Amount := GenJnlLine.Amount;
          ApplyingVendLedgEntry."Remaining Amount" := GenJnlLine.Amount;
          CalcApplnAmount;
        end;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..21
      // <<DITW15.00.00.38 DDR 29/07/2010 #1213
      CalcType::ServHeader:
        begin
          ApplyingVendLedgEntry."Entry No." := 1;
          ApplyingVendLedgEntry."Posting Date" := ServPurchHeader."Posting Date";
          ApplyingVendLedgEntry."Document Type" := ServPurchHeader."Document Type";
          ApplyingVendLedgEntry."Document No." := ServPurchHeader."No.";
          ApplyingVendLedgEntry."Vendor No." := ServPurchHeader."Pay-to Vendor No.";
          ApplyingVendLedgEntry.Description := ServPurchHeader."Posting Description";
          ApplyingVendLedgEntry."Currency Code" := ServPurchHeader."Currency Code";
          // <<DITW15.00.00.37 DDR 10/05/2010
          ApplyingVendLedgEntry."DIT Sub-Contract Type" := ServPurchHeader."DIT Sub-Contract Type";
          ApplyingVendLedgEntry."Contract Group Code" := ServPurchHeader."Contract Group Code";
          // >>DITW15.00.00.37 DDR
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          ApplyingVendLedgEntry."Contract Type" := ApplyingVendLedgEntry."Contract Type"::Service;
          ApplyingVendLedgEntry."Service Contract No." := ServPurchHeader."Contract No.";
          // >>DITW16.00.00.41 AHU DIT-715 #327
          ApplyingVendLedgEntry."Vendor Posting Group" := ServPurchHeader."Vendor Posting Group";//DITW17.00.02 SR 19/12/2013 DIT-770 #163
          if ApplyingVendLedgEntry."Document Type" = ApplyingVendLedgEntry."Document Type"::"Credit Memo" then  begin
            ApplyingVendLedgEntry.Amount := -TotalServPurchLine."Amount Including VAT";
            ApplyingVendLedgEntry."Remaining Amount" := -TotalServPurchLine."Amount Including VAT";
          end else begin
            ApplyingVendLedgEntry.Amount := TotalServPurchLine."Amount Including VAT";
            ApplyingVendLedgEntry."Remaining Amount" := TotalServPurchLine."Amount Including VAT";
    #41..43
      // >>DITW15.00.00.38 DDR
    #22..40
            // <<DITW15.00.00.37 DDR 10/05/2010
            ApplnSubContractType := ApplyingVendLedgEntry."DIT Sub-Contract Type";
            // >>DITW15.00.00.37 DDR
            // <<DITW15.00.00.35 DDR 01/10/2009
            ApplnContractGroupCode := ApplyingVendLedgEntry."Contract Group Code";
            // >>DITW15.00.00.35 DDR
            // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
            ApplnContractType := ApplyingVendLedgEntry."Contract Type";
            //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            case ApplnContractType of
              ApplnContractType::Service :
                ApplnContractNo := ApplyingVendLedgEntry."Service Contract No.";
              ApplnContractType::Financial :
                ApplnContractNo := ApplyingVendLedgEntry."Financial Contract No.";
            end;
            //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            // >>DITW16.00.00.41 AHU DIT-715 #327
            // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
            ApplnItemChargeType := ApplyingVendLedgEntry."Item Charge Type";
            // >>DITW16.00.00.42 DDR DIT-715 #370
            ApplnVendorPostingGroup := ApplyingVendLedgEntry."Vendor Posting Group";//DITW17.00.02 SR 19/12/2013 DIT-770 #163
          end else begin
            Rec := ApplyingVendLedgEntry;
            "Applying Entry" := false;
            ApplyingVendLedgEntry.INIT;
            ApplyingVendLedgEntry."Entry No." := 0;
            SetVendApplId;
            ApplyingAmount := 0;
            ApplnDate := 0D;
            ApplnCurrencyCode := '';
            // <<DITW15.00.00.37 DDR 10/05/2010
            ApplnSubContractType := ApplnSubContractType::" ";
            // >>DITW15.00.00.37 DDR
            // <<DITW15.00.00.35 DDR 01/10/2009
            ApplnContractGroupCode := '';
            // >>DITW15.00.00.35 DDR
            // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
            ApplnContractType := ApplnContractType::Service;
            ApplnContractNo := '';
            // >>DITW16.00.00.41 AHU DIT-715 #327
            // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
            ApplnItemChargeType := 0;
            // >>DITW16.00.00.42 DDR DIT-715 #370
            ApplnVendorPostingGroup := '';//DITW17.00.02 SR 19/12/2013 DIT-770 #163
            SETRANGE("Entry No.");
          end;
          CalcApplnAmount;
        end;
    #44..59
          // <<DITW15.00.00.37 DDR 10/05/2010
          ApplyingVendLedgEntry."DIT Sub-Contract Type" := GenJnlLine."DIT Sub-Contract Type";
          // >>DITW15.00.00.37 DDR
          // <<DITW15.00.00.35 DDR 01/10/2009
          ApplyingVendLedgEntry."Contract Group Code" := GenJnlLine."Contract Group Code";
          // >>DITW15.00.00.35 DDR
          // <<DITW15.00.00.38 DDR 10/12/2010 #1173
          ApplyingVendLedgEntry."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type";
          ApplyingVendLedgEntry."Applies-to Doc. No." := GenJnlLine."Applies-to Doc. No.";
          ApplyingVendLedgEntry."Applies-to ID" := GenJnlLine."Applies-to ID";
          // >>DITW15.00.00.38 DDR #1173
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          ApplyingVendLedgEntry."Contract Type" := GenJnlLine."Contract Type";
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          case ApplyingVendLedgEntry."Contract Type" of
            ApplyingVendLedgEntry."Contract Type"::Service :
              ApplyingVendLedgEntry."Service Contract No." := GenJnlLine."Service Contract No.";
            ApplyingVendLedgEntry."Contract Type"::Financial :
              ApplyingVendLedgEntry."Financial Contract No." := GenJnlLine."Financial Contract No.";
          end;
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
          // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
          ApplyingVendLedgEntry."Item Charge Type" := GenJnlLine."Item Charge Type";
          // >>DITW16.00.00.42 DDR DIT-715 #370
          ApplyingVendLedgEntry."Vendor Posting Group" := GenJnlLine."Posting Group";//DITW17.00.02 SR 19/12/2013 DIT-770 #163
    #60..62
    */
    //end;


    //Unsupported feature: CodeModification on "SetVendApplId(PROCEDURE 10)". Please convert manually.

    //procedure SetVendApplId();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if (CalcType = CalcType::GenJnlLine) and (ApplyingVendLedgEntry."Posting Date" < "Posting Date") then
      ERROR(
        EarlierPostingDateErr,ApplyingVendLedgEntry."Document Type",ApplyingVendLedgEntry."Document No.",
        "Document Type","Document No.");

    if ApplyingVendLedgEntry."Entry No." <> 0 then
      GenJnlApply.CheckAgainstApplnCurrency(
        ApplnCurrencyCode,"Currency Code",GenJnlLine."Account Type"::Vendor,true);

    VendLedgEntry.COPY(Rec);
    CurrPage.SETSELECTIONFILTER(VendLedgEntry);
    if GenJnlLineApply then
      VendEntrySetApplID.SetApplId(VendLedgEntry,ApplyingVendLedgEntry,GenJnlLine."Applies-to ID")
    else
      VendEntrySetApplID.SetApplId(VendLedgEntry,ApplyingVendLedgEntry,PurchHeader."Applies-to ID");

    ActionPerformed := VendLedgEntry."Applies-to ID" <> '';
    CalcApplnAmount;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    //HEI.01>>
    if "Batch payment name" <> '' then
      ERROR(Text020, "Document No.", "Batch payment name");
    //HEI.01<<

    // <<DITW15.00.00.35 DDR 01/10/2009 - DITW15.00.00.37 DDR 10/05/2010
    // <<DITW15.00.00.38 DDR 10/12/2010 #1173
    if DITPurchServMgtSetup.READPERMISSION then begin
      DITPurchServMgtSetup.GET;
      if DITPurchServMgtSetup."Use 2nd Vend. Posting Group" then begin
        if (CalcType = CalcType::Direct) and
          (ApplnSubContractType <> "DIT Sub-Contract Type") and (ApplyingVendLedgEntry."Entry No." <> 0)
        then
          ERROR(Text2034840,FIELDCAPTION("DIT Sub-Contract Type"));

        // <<DITW16.00.00.43 DDR 21/11/2013 DIT-715 #827
        //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        if (CalcType = CalcType::Direct) and (ApplnContractType = ApplnContractType ::Service) and
        //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          (ApplnContractNo <> "Service Contract No.") and (ApplyingVendLedgEntry."Entry No." <> 0)
        then
          ERROR(Text2034840,FIELDCAPTION("Service Contract No."));
        // >>DITW16.00.00.43 DDR DIT-715 #827
        //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        if (CalcType = CalcType::Direct) and   (ApplnContractType = ApplnContractType ::Financial) and
          (ApplnContractNo <> "Financial Contract No.") and (ApplyingVendLedgEntry."Entry No." <> 0)
        then
          ERROR(Text2034840,FIELDCAPTION("Financial Contract No."));
        //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        if DITPurchServMgtSetup."Contract Group Mandatory" and
          (CalcType = CalcType::Direct) and
          (ApplnContractGroupCode <> "Contract Group Code") and (ApplyingVendLedgEntry."Entry No." <> 0)
        then
          ERROR(Text2034840,FIELDCAPTION("Contract Group Code"));
      end;
    end;
    // >>DITW15.00.00.38 DDR #1173

    // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
    if GLSetup."Appln. per Charge Type" and (CalcType = CalcType::Direct) and
      (ApplnItemChargeType <> "Item Charge Type") and (ApplyingVendLedgEntry."Entry No." <> 0)
    then
      ERROR(Text2034840,FIELDCAPTION("Item Charge Type"));
    // >>DITW16.00.00.42 DDR DIT-715 #370

    if ApplyingVendLedgEntry."Entry No." <> 0 then begin
      GenJnlApply.CheckAgainstApplnCurrency(
        ApplnCurrencyCode,"Currency Code",GenJnlLine."Account Type"::Vendor,true);
      // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
      if CalcType = CalcType::Direct then begin
      // >>DITW16.00.00.42 DDR DIT-715 #370
        // <<DITW15.00.00.37 DDR 01/06/2010
        if GenJnlLineApply then
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          if "Contract Type" ="Contract Type"::Service then
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            GenJnlApply.CheckAgainstApplnDitContract(
            // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
            ApplnContractType,ApplnContractNo,
            // >>DITW16.00.00.41 AHU DIT-715 #327
            ApplnSubContractType,ApplnContractGroupCode,
            // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
            "Contract Type","Service Contract No.",
            // >>DITW16.00.00.41 AHU DIT-715 #327
            "DIT Sub-Contract Type","Contract Group Code",
            GenJnlLine."Account Type"::Vendor,true)
        // >>DITW15.00.00.37 DDR
        //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        else if "Contract Type" ="Contract Type"::Financial then
          GenJnlApply.CheckAgainstApplnDitContract(
          ApplnContractType,ApplnContractNo,
          ApplnSubContractType,ApplnContractGroupCode,
          "Contract Type","Financial Contract No.",
          "DIT Sub-Contract Type","Contract Group Code",
          GenJnlLine."Account Type"::Vendor,true);
        //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        if GLSetup."Appln. per Charge Type" then
          GenJnlApply.CheckAgainstApplnItemChrgType(
            ApplnItemChargeType,"Item Charge Type",
            GenJnlLine."Account Type"::Vendor,true);
        // >>DITW16.00.00.42 DDR DIT-715 #370
      end;
    end;
    #9..11

    // <<DITW15.00.00.37 DDR 01/06/2010
    if GenJnlLineApply and (ApplyingVendLedgEntry."Entry No." <> 0) and ("Applies-to ID" = '') then
      GenJnlApply.CheckVendEntryApplnDitContract(ApplyingVendLedgEntry,VendLedgEntry);
    // >>DITW15.00.00.37 DDR
    // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
    if GenJnlLineApply and (ApplyingVendLedgEntry."Entry No." <> 0) and ("Applies-to ID" = '') then
      GenJnlApply.CheckVendEntryApplnItemChrgTyp(ApplyingVendLedgEntry,VendLedgEntry);
    // >>DITW16.00.00.42 DDR DIT-715 #370

    #12..14
      // <<DITW15.00.00.35 DDR 10/09/2009
      //VendEntrySetApplID.SetApplId(VendLedgEntry,ApplyingVendLedgEntry,PurchHeader."Applies-to ID");
      if CalcType = CalcType::PurchHeader then
        VendEntrySetApplID.SetApplId(VendLedgEntry,ApplyingVendLedgEntry,PurchHeader."Applies-to ID")
      else
        VendEntrySetApplID.SetApplId(
          VendLedgEntry,ApplyingVendLedgEntry,ServPurchHeader."Applies-to ID");
      // >>DITW15.00.00.35 DDR
    #16..18
    */
    //end;


    //Unsupported feature: CodeModification on "CheckRounding(PROCEDURE 3)". Please convert manually.

    //procedure CheckRounding();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApplnRounding := 0;

    case CalcType of
      CalcType::PurchHeader:
        exit;
      CalcType::GenJnlLine:
        if (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Payment) and
    #8..19

    if (ABS((AppliedAmount - PmtDiscAmount) + ApplyingAmount) <= ApplnRoundingPrecision) and DifferentCurrenciesInAppln then
      ApplnRounding := -((AppliedAmount - PmtDiscAmount) + ApplyingAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      // <<DITW15.00.00.35 DDR 10/09/2009
      //CalcType::PurchHeader:
      CalcType::PurchHeader,CalcType::ServHeader:
      // >>DITW15.00.00.35 DDR
    #5..22
    */
    //end;


    //Unsupported feature: CodeModification on "FindApplyingEntry(PROCEDURE 12)". Please convert manually.

    //procedure FindApplyingEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if CalcType = CalcType::Direct then begin
      VendEntryApplID := USERID;
      if VendEntryApplID = '' then
    #4..17
        ApplyingAmount := VendLedgEntry."Remaining Amount";
        ApplnDate := VendLedgEntry."Posting Date";
        ApplnCurrencyCode := VendLedgEntry."Currency Code";
      end;
      CalcApplnAmount;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..20
        // <<DITW15.00.00.37 DDR 10/05/2010
        ApplnSubContractType := VendLedgEntry."DIT Sub-Contract Type";
        // >>DITW15.00.00.37 DDR
        // <<DITW15.00.00.35 DDR 01/10/2009
        ApplnContractGroupCode := VendLedgEntry."Contract Group Code";
        // >>DITW15.00.00.35 DDR
        // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        ApplnContractType := VendLedgEntry."Contract Type";
        //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        case ApplnContractType of
          ApplnContractType::Service :
           ApplnContractNo := VendLedgEntry."Service Contract No.";
          ApplnContractType::Financial :
            ApplnContractNo := VendLedgEntry."Financial Contract No.";
        end;
        //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        // >>DITW16.00.00.41 AHU DIT-715 #327
        // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
        ApplnItemChargeType := VendLedgEntry."Item Charge Type";
        // >>DITW16.00.00.42 DDR DIT-715 #370
        ApplnVendorPostingGroup := VendLedgEntry."Vendor Posting Group";//DITW17.00.02 SR 19/12/2013 DIT-770 #163
    #21..23
    */
    //end;
    //BC Update Kamnay01 >>DITW Procedure
    // procedure SetService(NewServPurchHeader: Record "Service Purchase Header"; var NewVendLedgEntry: Record "Vendor Ledger Entry"; ApplnTypeSelect: Integer);
    // var
    //     PurchServAmountsMgt: Codeunit "Serv Purch.-Amounts Mgt.";
    // begin
    //     // <<DITW15.00.00.35 DDR 10/09/2009
    //     ServPurchHeader := NewServPurchHeader;
    //     Rec.COPYFILTERS(NewVendLedgEntry);

    //     PurchServAmountsMgt.SumServiceLines(
    //       ServPurchHeader, 0, TotalServPurchLine, TotalServPurchLineLCY,
    //       VATAmount, VATAmountText);

    //     case ServPurchHeader."Document Type" of
    //         ServPurchHeader."Document Type"::"Credit Memo":
    //             ApplyingAmount := -TotalServPurchLine."Amount Including VAT"
    //         else
    //             ApplyingAmount := TotalServPurchLine."Amount Including VAT";
    //     end;

    //     ApplnDate := ServPurchHeader."Posting Date";
    //     ApplnCurrencyCode := ServPurchHeader."Currency Code";
    //     CalcType := CalcType::ServHeader;
    //     // <<DITW15.00.00.37 DDR 10/05/2010
    //     ApplnSubContractType := ServPurchHeader."DIT Sub-Contract Type";
    //     // >>DITW15.00.00.37 DDR
    //     // <<DITW15.00.00.35 DDR 01/10/2009
    //     ApplnContractGroupCode := ServPurchHeader."Contract Group Code";
    //     // >>DITW15.00.00.35 DDR
    //     ApplnVendorPostingGroup := ServPurchHeader."Vendor Posting Group";//DITW17.00.02 SR 19/12/2013 DIT-770 #163
    //     case ApplnTypeSelect of
    //         ServPurchHeader.FIELDNO("Applies-to Doc. No."):
    //             ApplnType := ApplnType::"Applies-to Doc. No.";
    //         ServPurchHeader.FIELDNO("Applies-to ID"):
    //             ApplnType := ApplnType::"Applies-to ID";
    //     end;

    //     SetApplyingVendLedgEntry;
    // end;

    // procedure GetApplyingVendLedgEntry(var VendLedgEntry: Record "Vendor Ledger Entry");
    // begin
    //     // <<DITW15.00.00.37 DDR 01/06/2010
    //     VendLedgEntry := ApplyingVendLedgEntry;
    // end;

    // local procedure AmountFromOnAfterValidate();
    // begin
    //     //<<FINXL7.00.001 RBE 20/03/2013
    //     if (AmountFrom <> 0) or (AmountTo <> 0) then
    //         SETRANGE("Remaining Amount", AmountFrom, AmountTo)
    //     else
    //         SETRANGE("Remaining Amount");
    //     CurrPage.UPDATE(false);
    //     //>>FINXL7.00.001 RBE 20/03/2013
    // end;

    // local procedure AmountToOnAfterValidate();
    // begin
    //     //<<FINXL7.00.001 RBE 20/03/2013
    //     if (AmountFrom <> 0) or (AmountTo <> 0) then
    //         SETRANGE("Remaining Amount", AmountFrom, AmountTo)
    //     else
    //         SETRANGE("Remaining Amount");
    //     CurrPage.UPDATE(false);
    //     //>>FINXL7.00.001 RBE 20/03/2013
    // end;

    // local procedure DatDocDateFromOnAfterValidate();
    // begin
    //     //<<FINXL7.00.001 RBE 20/03/2013
    //     if DatDocDateFrom = 0D then begin
    //         if DatDocDateTo = 0D then
    //             SETRANGE("Document Date");
    //     end else begin
    //         if DatDocDateTo = 0D then
    //             DatDocDateTo := 99991231D;
    //     end;

    //     SETRANGE("Document Date", DatDocDateFrom, DatDocDateTo);

    //     CurrPage.UPDATE(false);
    //     //>>FINXL7.00.001 RBE 20/03/2013
    // end;

    // local procedure DatDocDateToOnAfterValidate();
    // begin
    //     //<<FINXL7.00.001 RBE 20/03/2013
    //     if DatDocDateFrom = 0D then begin
    //         if DatDocDateTo = 0D then
    //             SETRANGE("Document Date");
    //     end else begin
    //         if DatDocDateTo = 0D then
    //             DatDocDateTo := 99991231D;
    //         SETRANGE("Document Date", DatDocDateFrom, DatDocDateTo);
    //     end;
    //     CurrPage.UPDATE(false);
    //     //>>FINXL7.00.001 RBE 20/03/2013
    // end;

    // local procedure rVendLedgEntryDescriptionOnAft();
    // begin
    //     //<<FINXL7.00.001 RBE 20/03/2013
    //     if rVendLedgEntry.Description <> '' then
    //         SETFILTER(Description, STRSUBSTNO('@*%1*', rVendLedgEntry.Description))
    //     else
    //         SETRANGE(Description);
    //     CurrPage.UPDATE(false);
    //     //>>FINXL7.00.001 RBE 20/03/2013
    // end;

    // local procedure rVendLedgEntryVendorNoOnAfterV();
    // begin
    //     //<<FINXL7.00.001 RBE 20/03/2013
    //     if rVendLedgEntry."Vendor No." <> '' then
    //         SETRANGE("Vendor No.", rVendLedgEntry."Vendor No.")
    //     else
    //         SETRANGE("Vendor No.");
    //     CurrPage.UPDATE(false);
    //     //>>FINXL7.00.001 RBE 20/03/2013
    // end;

    // local procedure rVendLedgEntryDocumentTypeOnAf();
    // begin
    //     //<<FINXL7.00.001 RBE 20/03/2013
    //     if rVendLedgEntry."Document Type" <> rVendLedgEntry."Document Type"::" " then
    //         SETRANGE("Document Type", rVendLedgEntry."Document Type")
    //     else
    //         SETRANGE("Document Type");
    //     CurrPage.UPDATE(false);
    //     //>>FINXL7.00.001 RBE 20/03/2013
    // end;

    // local procedure rVendLedgEntryDocumentNoOnAfte();
    // begin
    //     //<<FINXL7.00.001 RBE 20/03/2013
    //     if rVendLedgEntry."Document No." <> '' then
    //         SETFILTER("Document No.", STRSUBSTNO('@*%1*', rVendLedgEntry."Document No."))
    //     else
    //         SETRANGE("Document No.");
    //     CurrPage.UPDATE(false);
    //     //>>FINXL7.00.001 RBE 20/03/2013
    // end;
    //BC Update Kamnay01 <<DITW Procedure

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

