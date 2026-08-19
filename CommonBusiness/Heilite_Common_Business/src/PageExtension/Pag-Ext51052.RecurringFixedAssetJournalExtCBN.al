pageextension 51052 RecurringFixedAssetJnlExtCBN extends "Recurring Fixed Asset Journal"
{
    // version NAVW110.0,DITW110.00.08

    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the name of the journal batch of the fixed asset journal.', FRA = 'Spécifie le nom feuille de la feuille immobilisation.';
        }
        modify("Recurring Method")
        {
            ToolTipML = ENU = 'Specifies a recurring method, if you have indicated that the journal is recurring.', FRA = 'Spécifie une méthode récurrente, si vous avez indiqué que la feuille est récurrente.';
        }
        modify("Recurring Frequency")
        {
            ToolTipML = ENU = 'Specifies a recurring frequency if you indicated that the journal is a recurring.', FRA = 'Spécifie une périodicité de récurrence, si vous avez indiqué que la feuille est récurrente.';
        }
        modify("FA Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date that will be used as the posting date on FA ledger entries.', FRA = 'Spécifie la date qui sera utilisée comme date comptabilisation immobilisation sur les écritures comptables immobilisation.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the same date as the FA Posting Date field when the line is posted.', FRA = 'Spécifie la même date que celle du champ Date compta. immo. lorsque la ligne est validée.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the appropriate document type for the amount you want to post.', FRA = 'Spécifie le type de document approprié pour le montant à valider.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number for the journal line.', FRA = 'Spécifie le numéro de document de la ligne feuille.';
        }
        modify("FA No.")
        {
            ToolTipML = ENU = 'Specifies the number of the resource you want to post an entry for.', FRA = 'Spécifie le numéro de la ressource pour laquelle vous souhaitez valider une écriture.';
        }
        modify("Depreciation Book Code")
        {
            ToolTipML = ENU = 'Specifies the code for the depreciation book to which the line will be posted.', FRA = 'Spécifie le code de la loi d''amortissement sur laquelle la ligne est validée.';
        }
        modify("FA Posting Type")
        {
            ToolTipML = ENU = 'Specifies the appropriate posting type for the amount you want to post.', FRA = 'Spécifie le type validation approprié pour le montant à valider.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Automatically retrieves the description from the FA card when the FA No. field is filled in.', FRA = 'Récupère automatiquement la description de la fiche immobilisation lorsque le champ N° immo. est renseigné.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the total amount the journal line consists of.', FRA = 'Spécifie le montant total de la ligne feuille.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        //BC Upgrade KAPOOV01>>
        //modify("ShortcutDimCode[3]")
        modify(ShortcutDimCode3)
        //BC Upgrade KAPOOV01<<
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change TableRelation on ""ShortcutDimCode[3]"(Control 300)". Please convert manually.

        }
        //BC Upgrade KAPOOV01>>
        //modify("ShortcutDimCode[4]")
        modify(ShortcutDimCode4)
        //BC Upgrade KAPOOV01<<
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change TableRelation on ""ShortcutDimCode[4]"(Control 302)". Please convert manually.

        }
        //BC Upgrade KAPOOV01>>
        //modify("ShortcutDimCode[5]")
        modify(ShortcutDimCode5)
        //BC Upgrade KAPOOV01<<
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change TableRelation on ""ShortcutDimCode[5]"(Control 304)". Please convert manually.

        }
        //BC Upgrade KAPOOV01>>
        //modify("ShortcutDimCode[6]")
        modify(ShortcutDimCode6)
        //BC Upgrade KAPOOV01<<
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change TableRelation on ""ShortcutDimCode[6]"(Control 306)". Please convert manually.

        }
        //BC Upgrade KAPOOV01>>
        //modify("ShortcutDimCode[7]")
        modify(ShortcutDimCode7)
        //BC Upgrade KAPOOV01<<
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change TableRelation on ""ShortcutDimCode[7]"(Control 308)". Please convert manually.

        }
        //BC Upgrade KAPOOV01>>
        //modify("ShortcutDimCode[8]")
        modify(ShortcutDimCode8)
        //BC Upgrade KAPOOV01<<
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the journal line.', FRA = 'Spécifie le code section analytique lié à cette ligne feuille.';

            //Unsupported feature: Change TableRelation on ""ShortcutDimCode[8]"(Control 310)". Please convert manually.

        }
        modify("Depr. until FA Posting Date")
        {
            ToolTipML = ENU = 'Specifies whether to automatically post depreciation of the existing (old) fixed asset.', FRA = 'Spécifie s''il faut valider ou non automatiquement l''amortissement de l''immobilisation existante (ancienne).';
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
            ToolTipML = ENU = 'Automatically selects the field if the entry was generated from an FA reclassification journal.', FRA = 'Sélectionne automatiquement le champ si l''écriture a été générée à partir d''une feuille reclassement immo.';
        }
        modify("Index Entry")
        {
            ToolTipML = ENU = 'Specifies whether to post an indexation.', FRA = 'Spécifie s''il faut ou non valider une actualisation.';
        }
        modify("FA Error Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of a posted FA ledger entry to mark as an error entry.', FRA = 'Spécifie le numéro d''une écriture comptable immobilisation validée à marquer comme écriture erronée.';
        }
        modify("Expiration Date")
        {
            ToolTipML = ENU = 'Specifies the last date on which the recurring journal will be posted.', FRA = 'Spécifie la dernière date à laquelle la feuille abonnement sera validée.';
        }
        modify("FA Description")
        {
            CaptionML = ENU = 'FA Description', FRA = 'Description immo.';
        }
        modify(FADescription)
        {
            ToolTipML = ENU = 'Specifies a description of the fixed asset.', FRA = 'Spécifie une description de l''immobilisation.';
        }

        //Unsupported feature: CodeModification on "CurrentJnlBatchName(Control 42).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        FAJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        FAJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(false);
        */
        //end;
        addafter("Shortcut Dimension 2 Code")
        {
            //BC Upgrade KAPOOV01-drink-it>>
            // field("Contract Type"; "Contract Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Service Contract No."; "Service Contract No.")
            // {
            //     Visible = false;
            // }
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
            //BC Upgrade KAPOOV01-drink-it<<
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Fixed &Asset")
        {
            CaptionML = ENU = 'Fixed &Asset', FRA = 'I&mmobilisation';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
            ToolTipML = ENU = 'View or edit detailed information about the fixed asset.', FRA = 'Affichez ou modifiez des informations détaillées sur l''immobilisation.';

            //Unsupported feature: Change RunPageLink on "Card(Action 46)". Please convert manually.

        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the ledger entries for the selected fixed asset.', FRA = 'Affichez les écritures comptables de l''immobilisation sélectionnée.';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
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
        }


        //Unsupported feature: CodeModification on ""P&ost"(Action 50).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"FA. Jnl.-Post",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"FA. Jnl.-Post",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Post and &Print"(Action 51).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"FA. Jnl.-Post+Print",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"FA. Jnl.-Post+Print",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(false);
        */
        //end;
    }


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF IsOpenedFromBatch THEN BEGIN
      CurrentJnlBatchName := "Journal Batch Name";
      FAJnlManagement.OpenJournal(CurrentJnlBatchName,Rec);
      EXIT;
    end;
    FAJnlManagement.TemplateSelection(PAGE::"Recurring Fixed Asset Journal",TRUE,Rec,JnlSelected);
    IF NOT JnlSelected THEN
      ERROR('');
    FAJnlManagement.OpenJournal(CurrentJnlBatchName,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if IsOpenedFromBatch then begin
      CurrentJnlBatchName := "Journal Batch Name";
      FAJnlManagement.OpenJournal(CurrentJnlBatchName,Rec);
      exit;
    end;
    FAJnlManagement.TemplateSelection(PAGE::"Recurring Fixed Asset Journal",true,Rec,JnlSelected);
    if not JnlSelected then
      ERROR('');
    FAJnlManagement.OpenJournal(CurrentJnlBatchName,Rec);
    */
    //end;


    //Unsupported feature: CodeModification on "CurrentJnlBatchNameOnAfterVali(PROCEDURE 19002411)". Please convert manually.

    //procedure CurrentJnlBatchNameOnAfterVali();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SAVERECORD;
    FAJnlManagement.SetName(CurrentJnlBatchName,Rec);
    CurrPage.UPDATE(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.SAVERECORD;
    FAJnlManagement.SetName(CurrentJnlBatchName,Rec);
    CurrPage.UPDATE(false);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

