pageextension 55001 FixedAssetGLJournalRTRExt extends "Fixed Asset G/L Journal"
{
    // DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added fields "Service Contract Type","Service Contract No."
    //                                              "Contract Group Code","Building No.","DIT Sub-Contract Type"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 Defect116(NavBugFix)- IBM PATHAA02 19.09.17 Added comment field
    // HEI.03 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //   # New field "RPM Original Sales Amount" added
    // HEI.04 CHG2056568 BULIMC01 IBM 05/05/2020
    //     #new action added: "FA Mass Upload"
    //     #new fields displayed: "Auto_Cust", "Amount(LCY)", "Currency Factor"
    // HEI.05 CHG2246792 IBM POENAB02 24.04.2024 Move EBF Matrix dimension Validation to Check Lines of Gen .Journal
    //   # Modified actions Post, Post and Print, Preview Posting
    //   # New function: CheckEBFCombination
    // HEI.06 CHG2271823 IBM KAPOOV01 08.11.2024 Field to Block/Unblock General Journal templates
    //   #Modified Trigger/Functions- OnInit(),OnAfterGetRecord(),OnAfterGetCurrRecord()
    //   #Modified Enable Property of Various Actions & Action Groups
    // version NAVW110.0,DITW110.00.08,HEI.06

    //-----------------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 15.12.2025 # Field-GetAddCurrCode defined with name-AddCurrCode in base so need to change field name.
    //BC Upgrade KAPOOV01 15.12.2025 # Fields name-ShortcutDimCode[n] (n value 3 to 8) change from "ShortcutDimCode[n]" to "ShortcutDimCoden" as per base BC definition.
    //BC Upgrade KAPOOV01 15.12.2025 # Changed action name from Comment to Comments as one field with same name exits
    //BC Upgrade KAPOOV01 15.12.2025 # Oninit Trigger code related customization for EnableActnIfTemplateNtBlck added on  trigger OnOpenPage() in page extention 
    //BC Upgrade KAPOOV01 15.12.2025 # For tags- #HEI.05 & HEI.03-two HNK custom functions -CheckEBFCombinationon  and InsertRPMDifferenceLine are added for validation before standard code related to actual posting on 3 standard actions-P&ost,"Preview Posting","Post and &Print" so in order to take HNK customization, created 3 new custom actions for these three standard actions and hided these 3 standard actions-P&ost,"Preview Posting","Post and &Print".
    //BC Upgrade KAPOOV01 16.12.2025 # Modified Visible Propery(Updated to True) of two Group controls-"Account Name", "Bal. Account Name" as they are visile in NAV but Hidden in BC.


    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the name of the journal batch of the general journal.', FRA = 'Spécifie le nom du lot du journal de la feuille comptabilité.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the same date as the FA Posting Date field when the line is posted.', FRA = 'Spécifie la même date que celle du champ Date compta. immo. lorsque la ligne est validée.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on the document that provides the basis for the entry on the journal line.', FRA = 'Spécifie la date du document qui est utilisé comme document de base pour l''écriture de la ligne feuille.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the appropriate document type for the amount you want to post.', FRA = 'Spécifie le type de document approprié pour le montant à valider.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number for the journal line.', FRA = 'Spécifie le numéro de document de la ligne feuille.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number referring to the customer or vendor numbering system with whom you are trading items on this journal line.', FRA = 'Spécifie un numéro de document qui se réfère au programme de numérotation du client ou du fournisseur avec lequel vous traitez pour les articles de cette ligne feuille.';
        }
        modify("Account Type")
        {
            ToolTipML = ENU = 'Specifies the type of account that the entry on the journal line will be posted to.', FRA = 'Spécifie le type de compte sur lequel l''écriture de la ligne feuille est validée.';
        }
        modify("Account No.")
        {
            ToolTipML = ENU = 'Specifies the account that the entry on the journal line will be posted to.', FRA = 'Spécifie le compte sur lequel l''écriture de la ligne feuille est validée.';
        }
        modify("Depreciation Book Code")
        {
            ToolTipML = ENU = 'Specifies the code for the depreciation book to which the line will be posted.', FRA = 'Spécifie le code de la loi d''amortissement sur laquelle la ligne est validée.';
        }
        modify("FA Posting Type")
        {
            ToolTipML = ENU = 'Specifies the appropriate posting type for the amount you want to post.', FRA = 'Spécifie le type validation approprié pour le montant à valider.';
        }
        //BC Upgrade KAPOOV01>>

        // modify(GetAddCurrCode)
        // {
        //     CaptionML = ENU = 'FA Add.-Currency Code', FRA = 'Code DR immo.';
        //     ToolTipML = ENU = 'Specifies the code of the additional reporting currency, if you post in an additional reporting currency.', FRA = 'Spécifie le code de la devise report supplémentaire, si vous validez dans une devise report supplémentaire.';
        // }//BC Upgrade KAPOOV01 This field defined with name-AddCurrCode in base

        modify(AddCurrCode)//BC Upgrade KAPOOV01 This field defined with name-AddCurrCode in base
        {
            CaptionML = ENU = 'FA Add.-Currency Code', FRA = 'Code DR immo.';
            ToolTipML = ENU = 'Specifies the code of the additional reporting currency, if you post in an additional reporting currency.', FRA = 'Spécifie le code de la devise report supplémentaire, si vous validez dans une devise report supplémentaire.';
        }
        //BC Upgrade KAPOOV01<<
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description from the fixed asset card when the FA No. field is filled in.', FRA = 'Spécifie la description de la fiche immobilisation lorsque le champ N° immo. est renseigné.';
        }
        modify("Salespers./Purch. Code")
        {
            ToolTipML = ENU = 'Specifies the code for the salesperson or purchaser who is linked to the sale or purchase on the journal line.', FRA = 'Spécifie le code du vendeur ou de l''acheteur lié à la vente ou à l''achat de la ligne feuille.';
        }
        modify("Campaign No.")
        {
            ToolTipML = ENU = 'Specifies the number of the campaign the journal line is linked to.', FRA = 'Spécifie le numéro de la campagne à laquelle la ligne feuille est liée.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the code for the currency if the amount is in a foreign currency.', FRA = 'Spécifie le code de la devise si le montant est exprimé en devise étrangère.';
        }
        modify("Gen. Posting Type")
        {
            ToolTipML = ENU = 'Specifies the general posting type that will be used when you post the entry on this journal line.', FRA = 'Spécifie le type de validation général qui est utilisé lorsque vous validez l''écriture de cette ligne feuille.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general business posting group that applies to the entry.', FRA = 'Spécifie le groupe comptabilisation marché qui s''applique à cette écriture.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general product posting group that will be used when you post the entry on the journal line.', FRA = 'Spécifie le groupe comptabilisation produit utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the vendor''s VAT specification to link transactions made for this vendor with the appropriate general ledger account according to the VAT posting setup.', FRA = 'Spécifie le détail TVA du fournisseur pour lier les transactions effectuées pour ce fournisseur au compte général approprié en fonction des paramètres de comptabilisation TVA.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a VAT product posting group code.', FRA = 'Spécifie un code groupe comptabilisation produit TVA.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the total amount the journal line consists of.', FRA = 'Spécifie le montant total de la ligne feuille.';
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
            ToolTipML = ENU = 'Specifies the type of balancing account used in the entry: G/L Account, Bank Account, or Fixed Asset.', FRA = 'Spécifie le type du compte de contrepartie utilisé pour l''écriture : compte général, compte bancaire ou immobilisation.';
        }
        modify("Bal. Account No.")
        {
            ToolTipML = ENU = 'Specifies the number of the balancing account used on the entry.', FRA = 'Spécifie le numéro du compte de contrepartie utilisé pour l''écriture.';
        }
        modify("Bal. Gen. Posting Type")
        {
            ToolTipML = ENU = 'Specifies the general posting type associated with the balancing account that will be used when you post the entry on the journal line.', FRA = 'Spécifie le type de validation associé au compte contrepartie qui est utilisé lorsque vous validez l''écriture sur cette ligne feuille.';
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general product posting group code associated with the balancing account that will be used when you post the entry.', FRA = 'Spécifie le code groupe comptabilisation produit associé au compte contrepartie qui est utilisé lorsque vous validez l''écriture sur cette ligne feuille.';
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT business posting group associated with the balancing account that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation marché TVA associé au compte contrepartie qui est utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the VAT product posting group associated with the balancing account that will be used when you post the entry on the journal line.', FRA = 'Spécifie le code groupe comptabilisation produit TVA associé au compte contrepartie qui est utilisé lorsque vous validez l''écriture sur la ligne feuille.';
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general business posting group code associated with the balancing account that will be used when you post the entry.', FRA = 'Spécifie le code groupe comptabilisation marché associé au compte contrepartie qui est utilisé lorsque vous validez l''écriture sur cette ligne feuille.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the payment terms that apply to the entry on the journal line.', FRA = 'Spécifie le code qui représente les conditions de paiement qui s''appliquent à l''écriture de la ligne feuille.';
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
            ToolTipML = ENU = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.', FRA = 'Spécifie l''ID de lettrage des écritures lorsque vous choisissez l''action Ecr. ouvertes.';
        }
        modify("On Hold")
        {
            ToolTipML = ENU = 'Specifies if the journal line has been invoiced, and you execute the payment suggestions batch job, or you create a finance charge memo or reminder.', FRA = 'Indique si la ligne feuille a été facturée et si vous exécutez le traitement par lots de suggestion de paiements ou créez des intérêts ou une relance.';
        }
        modify("Bank Payment Type")
        {
            ToolTipML = ENU = 'Specifies the code for the payment type to be used for the entry on the payment journal line.', FRA = 'Spécifie le code du mode de paiement à utiliser pour l''écriture de la ligne feuille paiement.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code that will be inserted on the journal lines.', FRA = 'Spécifie le code motif qui va être inséré dans les lignes feuille.';
        }
        modify("FA Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date that will be used as the posting date on FA ledger entries.', FRA = 'Spécifie la date qui sera utilisée comme date comptabilisation immobilisation sur les écritures comptables immobilisation.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        //BC Upgrade KAPOOV01>> fields name-ShortcutDimCode[n] (n value 3 to 8) change from "ShortcutDimCode[n]" to "ShortcutDimCoden" as per base BC definition.
        // modify("ShortcutDimCode[3]")
        // {
        //     ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

        //     //Unsupported feature: Change TableRelation on ""ShortcutDimCode[3]"(Control 300)". Please convert manually.

        // }
        // modify("ShortcutDimCode[4]")
        // {
        //     ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

        //     //Unsupported feature: Change TableRelation on ""ShortcutDimCode[4]"(Control 302)". Please convert manually.

        // }
        // modify("ShortcutDimCode[5]")
        // {
        //     ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

        //     //Unsupported feature: Change TableRelation on ""ShortcutDimCode[5]"(Control 304)". Please convert manually.

        // }
        // modify("ShortcutDimCode[6]")
        // {
        //     ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

        //     //Unsupported feature: Change TableRelation on ""ShortcutDimCode[6]"(Control 306)". Please convert manually.

        // }
        // modify("ShortcutDimCode[7]")
        // {
        //     ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

        //     //Unsupported feature: Change TableRelation on ""ShortcutDimCode[7]"(Control 308)". Please convert manually.

        // }
        // modify("ShortcutDimCode[8]")
        // {
        //     ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

        //     //Unsupported feature: Change TableRelation on ""ShortcutDimCode[8]"(Control 310)". Please convert manually.

        // }
        modify("ShortcutDimCode3")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change TableRelation on ""ShortcutDimCode[3]"(Control 300)". Please convert manually.

        }
        modify("ShortcutDimCode4")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change TableRelation on ""ShortcutDimCode[4]"(Control 302)". Please convert manually.

        }
        modify("ShortcutDimCode5")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change TableRelation on ""ShortcutDimCode[5]"(Control 304)". Please convert manually.

        }
        modify("ShortcutDimCode6")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change TableRelation on ""ShortcutDimCode[6]"(Control 306)". Please convert manually.

        }
        modify("ShortcutDimCode7")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change TableRelation on ""ShortcutDimCode[7]"(Control 308)". Please convert manually.

        }
        modify("ShortcutDimCode8")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change TableRelation on ""ShortcutDimCode[8]"(Control 310)". Please convert manually.

        }
        //BC Upgrade KAPOOV01<<
        modify("Salvage Value")
        {
            ToolTipML = ENU = 'Specifies the estimated residual value of a fixed asset when it can no longer be used.', FRA = 'Spécifie la valeur résiduelle estimée d''une immobilisation qui est devenue inutilisable.';
        }
        modify("No. of Depreciation Days")
        {
            ToolTipML = ENU = 'Specifies the number of depreciation days if you have selected the Depreciation or Custom 1 option in the FA Posting Type field.', FRA = 'Spécifie le nombre de jours d''amortissement si vous avez sélectionné Amortissement ou Param. 1 dans le champ Type compta. immo.';
        }
        modify("Depr. until FA Posting Date")
        {
            ToolTipML = ENU = 'Specifies whether to automatically post depreciation of the existing (old) fixed asset.', FRA = 'Spécifie s''il faut valider ou non automatiquement l''amortissement de l''immobilisation existante (ancienne).';
        }
        modify("Depr. Acquisition Cost")
        {
            ToolTipML = ENU = 'Specifies whether to post an additional acquisition cost and a possible salvage value to an acquired asset.', FRA = 'Spécifie s''il faut valider ou non un coût d''acquisition supplémentaire et une valeur résiduelle possible sur un actif déjà acquis.';
        }
        modify("Maintenance Code")
        {
            ToolTipML = ENU = 'Specifies a maintenance code.', FRA = 'Spécifie un code maintenance.';
        }
        modify("Insurance No.")
        {
            ToolTipML = ENU = 'Specifies an insurance code if you have selected the Acquisition Cost option in the FA Posting Type field.', FRA = 'Spécifie un code d''assurance si vous avez sélectionné l''option Coût acquisition dans le champ Type compta. immo.';
        }
        modify("Budgeted FA No.")
        {
            ToolTipML = ENU = 'Specifies a fixed asset number.', FRA = 'Spécifie un numéro d''immobilisation.';
        }
        modify("Duplicate in Depreciation Book")
        {
            ToolTipML = ENU = 'Specifies a depreciation book code if you want the journal line to be posted to that depreciation book, as well as to the depreciation book in the Depreciation Book Code field.', FRA = 'Spécifie un code loi d''amortissement dans ce champ si vous souhaitez que la ligne feuille soit validée sur cette loi d''amortissement, mais également sur celle figurant dans le champ Code loi d''amortissement.';
        }
        modify("Use Duplication List")
        {
            ToolTipML = ENU = 'Specifies whether the line is to be posted to all depreciation books, using different journal batches and with a check mark in the Part of Duplication List field.', FRA = 'Indique si la ligne doit être validée sur toutes les lois d''amortissement qui utilisent différentes feuilles et pour lesquelles le champ Inclure dans liste duplication est activé.';
        }
        modify("FA Reclassification Entry")
        {
            ToolTipML = ENU = 'Specifies if the entry was generated from a fixed asset reclassification journal.', FRA = 'Spécifie si l''écriture a été générée à partir d''une feuille reclassement immobilisation.';
        }
        modify("FA Error Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of a posted FA ledger entry to mark as an error entry.', FRA = 'Spécifie le numéro d''une écriture comptable immobilisation validée à marquer comme écriture erronée.';
        }
        modify("Account Name")
        {
            CaptionML = ENU = 'Account Name', FRA = 'Nom du compte';
            Visible = true; //BC Upgrade KAPOOV01 16.12.2025 # Modified Visible (Updated to True) Propery of Group controls-"Account Name" as it is visile in NAV but Hidden in BC.
        }
        modify("Bal. Account Name")
        {
            CaptionML = ENU = 'Bal. Account Name', FRA = 'Nom du compte contrepartie';
            Visible = true; //BC Upgrade KAPOOV01 16.12.2025 # Modified Visible (Updated to True) Propery of Group controls-"Bal. Account Name" as it is visile in NAV but Hidden in BC.
        }
        modify(BalAccountName)
        {
            CaptionML = ENU = 'Bal. Account Name', FRA = 'Nom du compte contrepartie';
            ToolTipML = ENU = 'Specifies the name of the balancing account that has been entered on the journal line.', FRA = 'Spécifie le nom du compte contrepartie qui a été saisi sur la ligne feuille.';
        }
        modify(Control1902759701)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify(Balance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
            ToolTipML = ENU = 'Specifies the balance that has accumulated in the journal.', FRA = 'Spécifie le solde cumulé dans le journal.';
        }
        modify("Total Balance")
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
        }
        modify(TotalBalance)
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
            ToolTipML = ENU = 'Specifies the total balance in the journal.', FRA = 'Indique le solde final de la feuille.';
        }

        //Unsupported feature: CodeModification on "CurrentJnlBatchName(Control 39).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        GenJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        GenJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(false);
        */
        //end;


        //Unsupported feature: CodeModification on "GetAddCurrCode(Control 75).OnAssistEdit". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ChangeExchangeRate.SetParameterFA("FA Add.-Currency Factor",GetAddCurrCode,"Posting Date");
        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN
          "FA Add.-Currency Factor" := ChangeExchangeRate.GetParameter;

        CLEAR(ChangeExchangeRate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ChangeExchangeRate.SetParameterFA("FA Add.-Currency Factor",GetAddCurrCode,"Posting Date");
        if ChangeExchangeRate.RUNMODAL = ACTION::OK then
        #3..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Currency Code"(Control 67).OnAssistEdit". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date");
        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN
          VALIDATE("Currency Factor",ChangeExchangeRate.GetParameter);

        CLEAR(ChangeExchangeRate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date");
        if ChangeExchangeRate.RUNMODAL = ACTION::OK then
        #3..5
        */
        //end;
        addafter("Campaign No.")
        {
            //BC Upgrade KAPOOV01 Drink-IT fields>>
            // field("Contract Type"; "Contract Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Service Contract No."; "Service Contract No.")
            // {
            //     Visible = false;
            // }
            //BC Upgrade KAPOOV01<<
            field("Line No."; Rec."Line No.")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line No. field.';
            }
            //BC Upgrade KAPOOV01>>
            // field("Financial Contract No."; "Financial Contract No.")
            // {
            //     Visible = false;
            // }
            // field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
            // {
            //     Visible = false;
            // }
            // field("Contract Group Code"; "Contract Group Code")
            // {
            //     Visible = false;
            // }
            // field("Building No."; "Building No.")
            // {
            //     Visible = false;
            // }
            //BC Upgrade KAPOOV01 Drink-IT fields<<
        }
        addafter("FA Error Entry No.")
        {
            field(Comment; Rec.Comment)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies a comment about the activity on the journal line. Note that the comment is not carried forward to posted entries.';
            }
            field("RPM Original Sales Amount"; Rec."RPM Original Sales Amount FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RPM Original Sales Amount field.';
            }
            field(AutoCust; AutoCust)
            {
                Caption = 'Auto_Cust';
                TableRelation = "Dimension Value".Code where("Dimension Code" = CONST('AUTO_CUST'),
                                                              "Dimension Value Type" = CONST(Standard),
                                                              Blocked = CONST(false));
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Auto_Cust field.';

                trigger OnValidate();
                var
                    TempDimSetEntry: Record "Dimension Set Entry" temporary;
                    DimensionManagement: Codeunit DimensionManagement;
                begin
                    //HEI.04>>
                    TempDimSetEntry.RESET();
                    TempDimSetEntry.VALIDATE("Dimension Code", 'AUTO_CUST');
                    TempDimSetEntry.VALIDATE("Dimension Value Code", AutoCust);
                    TempDimSetEntry.INSERT();
                    CLEAR(TempDimSetEntry);
                    if TempDimSetEntry.FINDFIRST() then
                        Rec."Dimension Set ID" := DimensionManagement.GetDimensionSetID(TempDimSetEntry);

                    //HEI.04>>
                end;
            }
            field("Amount (LCY)"; Rec."Amount (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the total amount in local currency (including VAT) that the journal line consists of.';
            }
            field("Currency Factor"; Rec."Currency Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Currency Factor field.';
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
        modify("A&ccount")
        {
            CaptionML = ENU = 'A&ccount', FRA = '&Compte';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
            ToolTipML = ENU = 'View or edit detailed information about the fixed asset.', FRA = 'Affichez ou modifiez des informations détaillées sur l''immobilisation.';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the ledger entries for the selected fixed asset.', FRA = 'Affichez les écritures comptables de l''immobilisation sélectionnée.';
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
            ToolTipML = ENU = 'Apply open entries for the relevant account type.', FRA = 'Lettrez des écritures ouvertes pour le type de compte concerné.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Insert FA &Bal. Account")
        {
            CaptionML = ENU = 'Insert FA &Bal. Account', FRA = 'Insérer contrepartie i&mmo.';
            ToolTipML = ENU = 'Insert the balancing account(s), on new journal lines, for the main account(s) on the journal line(s). This requires that balancing accounts are set up in the FA Posting Groups window for the related fixed asset transaction, such as acquisition cost, depreciation, write-down, or maintenance.', FRA = 'Insérez les comptes contrepartie sur les nouvelles lignes feuille pour les principaux comptes des lignes feuille. Cela nécessite que les comptes contrepartie soient configurés dans la fenêtre Groupes compta. immo. pour la transaction immobilisation concernée, par exemple le coût d''acquisition, l''amortissement, la dépréciation ou la maintenance.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            CaptionML = ENU = 'Insert Conv. LCY Rndg. Lines', FRA = 'Insérer lignes arr. conv. DS';
            ToolTipML = ENU = 'Specifies amounts in LCY if you enter foreign currency amounts in a general journal. However, even if all the journal lines balance in the foreign currency, when each journal line is converted and rounded to LCY, their LCY sum may not balance. This means that a balanced transaction in foreign currency may not balance in LCY, and can therefore not be posted.', FRA = 'Spécifie les montants en DS lorsque vous saisissez des montants en devise étrangère sur une feuille comptabilité. Cependant, même si toutes les lignes feuille sont équilibrées dans la devise étrangère, la somme en devise société peut ne pas être équilibrée une fois les lignes feuille converties et arrondies en devise société. Une transaction équilibrée en devise étrangère peut ne pas l''être en devise société, et peut, de ce fait, ne pas être validée.';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Reconcile)
        {
            CaptionML = ENU = 'Reconcile', FRA = 'Simuler';
            ToolTipML = ENU = 'Review what effect posting the journal will have on general ledger accounts.', FRA = 'Examinez l''effet de la validation de la feuille sur les comptes généraux.';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify("P&ost")
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
            Enabled = EnableActnIfTemplateNtBlck;
            Visible = false;  //BC Upgrade KAPOOV01 To take HNK customization done in 3 standard actions-P&ost,"Preview Posting","Post and &Print", created 3 new custom actions for these three standard actions and hided these 3 standard actions-P&ost,"Preview Posting","Post and &Print"
        }
        modify(Preview)
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
            Visible = false;  //BC Upgrade KAPOOV01 To take HNK customization done in 3 standard actions-P&ost,"Preview Posting","Post and &Print", created 3 new custom actions for these three standard actions and hided these 3 standard actions-P&ost,"Preview Posting","Post and &Print"
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
            ToolTipML = ENU = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.', FRA = 'Finalisez et préparez-vous à imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenêtre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément à imprimer.';
            Enabled = EnableActnIfTemplateNtBlck;
            Visible = false;  //BC Upgrade KAPOOV01 To take HNK customization done in 3 standard actions-P&ost,"Preview Posting","Post and &Print", created 3 new custom actions for these three standard actions and hided these 3 standard actions-P&ost,"Preview Posting","Post and &Print"
        }


        //Unsupported feature: CodeModification on ""P&ost"(Action 50).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckEBFCombination;//HEI.05

        InsertRPMDifferenceLine; //HEI.03
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(false);
        */
        //end;


        //Unsupported feature: CodeModification on "Preview(Action 5).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GenJnlPost.Preview(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckEBFCombination;//HEI.05
        GenJnlPost.Preview(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Post and &Print"(Action 51).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post+Print",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckEBFCombination;//HEI.05

        InsertRPMDifferenceLine; //HEI.03
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post+Print",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(false);
        */
        //end;

        //BC Upgrade KAPOOV01  Defined FA Mass Upload action inside second page extention of RTR as this action needs to be added inside RTR extention >>
        addafter("Insert Conv. LCY Rndg. Lines")
        {
            action("FA Mass Upload")
            {
                Caption = 'FA Mass Upload';
                Ellipsis = true;
                Enabled = EnableActnIfTemplateNtBlck;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction();
                var
                    FAMassUpload: Report "Mass Upload";
                begin
                    //BC Upgrade KAPOOV01 - Report >>
                    //HEI.04<<
                    CLEAR(FAMassUpload);
                    FAMassUpload.SetGenJournal(Rec."Journal Template Name", Rec."Journal Batch Name");
                    FAMassUpload.RUNMODAL();
                    //HEI.04>>
                end;
            }
        }
        //BC Upgrade KAPOOV01 Defined FA Mass Upload action inside second page extention of RTR as this action needs to be added inside RTR extention <<

        addafter("P&osting")
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Description = 'HEI.02';
                Enabled = EnableActnIfTemplateNtBlck;
                group(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    Description = 'HEI.02';
                    Image = SendApprovalRequest;
                    action(SendApprovalRequestJournalBatch)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Journal Batch';
                        Description = 'HEI.02';
                        Enabled = NOT OpenApprovalEntriesOnBatchOrAnyJnlLineExist;
                        Image = SendApprovalRequest;
                        ToolTip = 'Send all journal lines for approval, also those that you may not see because of filters.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.TrySendJournalBatchApprovalRequest(Rec);
                            SetControlAppearance();
                        end;
                    }
                    action(SendApprovalRequestJournalLine)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Selected Journal Lines';
                        Description = 'HEI.02';
                        Enabled = NOT OpenApprovalEntriesOnBatchOrCurrJnlLineExist;
                        Image = SendApprovalRequest;
                        ToolTip = 'Send selected journal lines for approval.';

                        trigger OnAction();
                        var
                            GenJournalLine: Record "Gen. Journal Line";
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            GetCurrentlySelectedLines(GenJournalLine);
                            ApprovalsMgmt.TrySendJournalLineApprovalRequests(GenJournalLine);
                        end;
                    }
                }
                group(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Request';
                    Description = 'HEI.02';
                    Image = Cancel;
                    action(CancelApprovalRequestJournalBatch)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Journal Batch';
                        Description = 'HEI.02';
                        Enabled = CanCancelApprovalForJnlBatch;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending all journal lines for approval, also those that you may not see because of filters.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.TryCancelJournalBatchApprovalRequest(Rec);
                            SetControlAppearance();
                        end;
                    }
                    action(CancelApprovalRequestJournalLine)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Selected Journal Lines';
                        Description = 'HEI.02';
                        Enabled = CanCancelApprovalForJnlLine;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending selected journal lines for approval.';

                        trigger OnAction();
                        var
                            GenJournalLine: Record "Gen. Journal Line";
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            GetCurrentlySelectedLines(GenJournalLine);
                            ApprovalsMgmt.TryCancelJournalLineApprovalRequests(GenJournalLine);
                        end;
                    }
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                Description = 'HEI.02';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Description = 'HEI.02';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveGenJournalLineRequest(Rec);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Description = 'HEI.02';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectGenJournalLineRequest(Rec);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Description = 'HEI.02';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category7;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateGenJournalLineRequest(Rec);
                    end;
                }
                //BC Upgrade KAPOOV01>>
                //action(Comment)
                action(Comments)
                //BC Upgrade KAPOOV01<< Changed action name from Comment to Comments as one field with same name exits
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Description = 'HEI.02';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category7;
                    ToolTip = 'View or add comments.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        GenJournalBatch: Record "Gen. Journal Batch";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if OpenApprovalEntriesOnJnlLineExist then
                            ApprovalsMgmt.GetApprovalComment(Rec)
                        else
                            if OpenApprovalEntriesOnJnlBatchExist then
                                if GenJournalBatch.GET(Rec."Journal Template Name", Rec."Journal Batch Name") then
                                    ApprovalsMgmt.GetApprovalComment(GenJournalBatch);
                    end;
                }
            }
        }

        //BC Upgrade KAPOOV01 To take HNK customization done in 3 standard actions-P&ost,"Preview Posting","Post and &Print", created 3 new custom actions for these three standard actions and hided these 3 standard actions-P&ost,"Preview Posting","Post and &Print">>
        addafter("Post and &Print")
        {
            action("P&ost_HNK")
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'P&ost', FRA = '&Valider';
                ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
                Enabled = EnableActnIfTemplateNtBlck;
                Image = PostOrder;
                ShortCutKey = 'F9';
                Promoted = true;//BC Upgrade SHARMP16
                PromotedCategory = Process;//BC Upgrade SHARMP16
                PromotedIsBig = true;//BC Upgrade SHARMP16
                //ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                begin
                    CheckEBFCombination();//HEI.05

                    Rec.InsertRPMDifferenceLine(); //HEI.03
                    Rec.SendToPosting(Codeunit::"Gen. Jnl.-Post");
                    CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                    CurrPage.Update(false);
                end;
            }
            action(Preview_HNK)
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
                ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
                Image = ViewPostedOrder;
                ShortCutKey = 'Ctrl+Alt+F9';
                Promoted = true;//BC Upgrade SHARMP16
                PromotedCategory = Process;//BC Upgrade SHARMP16
                PromotedIsBig = true;//BC Upgrade SHARMP16
                //ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                trigger OnAction()
                var
                    GenJnlPost: Codeunit "Gen. Jnl.-Post";
                begin
                    CheckEBFCombination();//HEI.05
                    GenJnlPost.Preview(Rec);
                end;
            }
            action("Post and &Print_HNK")
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
                ToolTipML = ENU = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.', FRA = 'Finalisez et préparez-vous à imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenêtre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément à imprimer.';
                Enabled = EnableActnIfTemplateNtBlck;
                Image = PostPrint;
                ShortCutKey = 'Shift+F9';
                //ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    CheckEBFCombination();//HEI.05

                    Rec.InsertRPMDifferenceLine(); //HEI.03
                    Rec.SendToPosting(Codeunit::"Gen. Jnl.-Post+Print");
                    CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                    CurrPage.Update(false);
                end;
            }
            //BC Upgrade KAPOOV01 To take HNK customization done in 3 standard actions-P&ost,"Preview Posting","Post and &Print", created 3 new custom actions for these three standard actions and hided these 3 standard actions-P&ost,"Preview Posting","Post and &Print"<<
        }
    }

    var
        DimensionSetEntry: Record "Dimension Set Entry";
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        FinancialUtils: Codeunit "Financial-Utils";
        PayrollManagement: Codeunit "Payroll Management";
        CanCancelApprovalForJnlBatch: Boolean;
        CanCancelApprovalForJnlLine: Boolean;
        EnableActnIfTemplateNtBlck: Boolean;
        ImportPayrollTransactionsAvailable: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        OpenApprovalEntriesOnJnlLineExist: Boolean;
        AutoCust: Code[10];


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlManagement.GetAccounts(Rec,AccName,BalAccountName);
        UpdateBalance;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        EnableActnIfTemplateNtBlck := EnableActionIfTemplateNtBlock; //HEI.06
         // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        SetFilterSubContractPostType;
        // >>DITW16.00.00.41 AHU DIT-715 #327
        GenJnlManagement.GetAccounts(Rec,AccName,BalAccountName);
        UpdateBalance;
        */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
        ShowShortcutDimCode(ShortcutDimCode);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        EnableActnIfTemplateNtBlck := EnableActionIfTemplateNtBlock; //HEI.06
        ShowShortcutDimCode(ShortcutDimCode);

        //HEI.04<<
        if DimensionSetEntry.GET("Dimension Set ID",'AUTO_CUST') then
          AutoCust := DimensionSetEntry."Dimension Value Code"
        else
          AutoCust := '';
        //HEI.04>>
        */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
        TotalBalanceVisible := TRUE;
        BalanceVisible := TRUE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        TotalBalanceVisible := true;
        BalanceVisible := true;
        //HEI.06>>
        CLEAR(EnableActnIfTemplateNtBlck);
        EnableActnIfTemplateNtBlck := true;
        //HEI.06<<
        */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
        UpdateBalance;
        SetUpNewLine(xRec,Balance,BelowxRec);
        CLEAR(ShortcutDimCode);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        #1..3
        CLEAR(AutoCust); //HEI.04
        */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
        BalAccountName := '';
        IF IsOpenedFromBatch THEN BEGIN
          CurrentJnlBatchName := "Journal Batch Name";
          GenJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
          EXIT;
        end;
        GenJnlManagement.TemplateSelection(PAGE::"Fixed Asset G/L Journal",5,FALSE,Rec,JnlSelected);
        IF NOT JnlSelected THEN
          ERROR('');
        GenJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        BalAccountName := '';
        if IsOpenedFromBatch then begin
          CurrentJnlBatchName := "Journal Batch Name";
          GenJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
          exit;
        end;
        GenJnlManagement.TemplateSelection(PAGE::"Fixed Asset G/L Journal",5,false,Rec,JnlSelected);
        if not JnlSelected then
          ERROR('');
        GenJnlManagement.OpenJnl(CurrentJnlBatchName,Rec);
        */
    //end;


    //Unsupported feature: CodeModification on "GetAddCurrCode(PROCEDURE 2)". Please convert manually.

    //procedure GetAddCurrCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
        IF NOT AddCurrCodeIsFound THEN BEGIN
          AddCurrCodeIsFound := TRUE;
          GLSetup.GET;
        end;
        EXIT(GLSetup."Additional Reporting Currency");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        if not AddCurrCodeIsFound then begin
          AddCurrCodeIsFound := true;
          GLSetup.GET;
        end;
        exit(GLSetup."Additional Reporting Currency");
        */
    //end;


    //Unsupported feature: CodeModification on "CurrentJnlBatchNameOnAfterVali(PROCEDURE 19002411)". Please convert manually.

    //procedure CurrentJnlBatchNameOnAfterVali();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
        CurrPage.SAVERECORD;
        GenJnlManagement.SetName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        CurrPage.SAVERECORD;
        GenJnlManagement.SetName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(false);
     ;
    */
    //end;

    local procedure SetControlAppearance();
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //HEI.02>>
        if GenJournalBatch.GET(Rec."Journal Template Name", Rec."Journal Batch Name") then begin
            //ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.PAGE.SetFilterOnWorkflowRecord(GenJournalBatch.RECORDID);
            OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(GenJournalBatch.RECORDID);
            OpenApprovalEntriesOnJnlBatchExist := ApprovalsMgmt.HasOpenApprovalEntries(GenJournalBatch.RECORDID);
        end;
        OpenApprovalEntriesExistForCurrUser :=
          OpenApprovalEntriesExistForCurrUser or
          ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);

        OpenApprovalEntriesOnJnlLineExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist := OpenApprovalEntriesOnJnlBatchExist or OpenApprovalEntriesOnJnlLineExist;

        OpenApprovalEntriesOnBatchOrAnyJnlLineExist :=
          OpenApprovalEntriesOnJnlBatchExist or
          ApprovalsMgmt.HasAnyOpenJournalLineApprovalEntries(Rec."Journal Template Name", Rec."Journal Batch Name");

        //ShowWorkflowStatusOnLine := CurrPage.WorkflowStatusLine.PAGE.SetFilterOnWorkflowRecord(RECORDID);

        CanCancelApprovalForJnlBatch := ApprovalsMgmt.CanCancelApprovalForRecord(GenJournalBatch.RECORDID);
        CanCancelApprovalForJnlLine := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);

        SetPayrollAppearance();
        //HEI.02<<
    end;

    local procedure GetCurrentlySelectedLines(var GenJournalLine: Record "Gen. Journal Line"): Boolean;
    begin
        //HEI.02>>
        CurrPage.SETSELECTIONFILTER(GenJournalLine);
        exit(GenJournalLine.findset());
        //HEI.02<<
    end;

    local procedure SetPayrollAppearance();
    var
        TempPayrollServiceConnection: Record "Service Connection" temporary;
    begin
        //HEI.02>>
        PayrollManagement.OnRegisterPayrollService(TempPayrollServiceConnection);
        ImportPayrollTransactionsAvailable := not TempPayrollServiceConnection.ISEMPTY;
        //HEI.02<<
    end;

    local procedure CheckEBFCombination();
    begin
        //HEI.05>>
        GenJournalLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        if GenJournalLine.findset(false) then
            repeat
                FinancialUtils.CheckEbfJournalLine(GenJournalLine);
            until GenJournalLine.NEXT() = 0;
        //HEI.05<<
    end;
    //BC Upgrade KAPOOV01>>

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.06>>
        CLEAR(EnableActnIfTemplateNtBlck);
        EnableActnIfTemplateNtBlck := TRUE;
        //HEI.06<<

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        EnableActnIfTemplateNtBlck := Rec.EnableActionIfTemplateNtBlock(); //HEI.06
                                                                           //HEI.04<<
        IF DimensionSetEntry.GET(Rec."Dimension Set ID", 'AUTO_CUST') THEN
            AutoCust := DimensionSetEntry."Dimension Value Code"
        else
            AutoCust := '';
        //HEI.04>>
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        CLEAR(AutoCust); //HEI.04
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        EnableActnIfTemplateNtBlck := Rec.EnableActionIfTemplateNtBlock(); //HEI.06
    end;
    //BC Upgrade KAPOOV01<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

