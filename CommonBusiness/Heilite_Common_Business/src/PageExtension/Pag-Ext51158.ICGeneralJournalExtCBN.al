pageextension 51158 ICGeneralJournalExtCBN extends "IC General Journal"
{
    // version NAVW110.0,HEI.01
    // HEI.01 CHG2271823 IBM KAPOOV01 08.11.2024 Field to Block/Unblock General Journal templates
    //   #Modified Trigger/Functions- OnInit(),OnAfterGetRecord(),OnAfterGetCurrRecord()
    //   #Modified Enable Property of Various Actions & Action Groups
    //*********************************************************************************************************
    //BC UPGRADE PATHAA02-27/11/25-Done
    // Code cannot be extended on Oninit-->so moved the code to OnOpenPage trigger; 
    // Also, added code to OnAfterGetCurrRecord and OnAfterGetRecord triggers to handle action enabling/disabling
    // #Modified Enable Property of Various Actions & Action Groups-Done

    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
        }
        modify("Account Name")
        {
            CaptionML = ENU = 'Account Name', FRA = 'Nom du compte';
        }
        modify("Bal. Account Name")
        {
            CaptionML = ENU = 'Bal. Account Name', FRA = 'Nom du compte contrepartie';
        }
        modify(BalAccName)
        {
            CaptionML = ENU = 'Bal. Account Name', FRA = 'Nom du compte contrepartie';
        }
        modify(Control1902759701)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify(Balance)
        {
            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify("Total Balance")
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
        }
        modify(TotalBalance)
        {
            CaptionML = ENU = 'Total Balance', FRA = 'Solde final';
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
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
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
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
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
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            CaptionML = ENU = 'Insert Conv. LCY Rndg. Lines', FRA = 'Insérer lignes arr. conv. DS';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Reconcile)
        {
            CaptionML = ENU = 'Reconcile', FRA = 'Simuler';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify("P&ost")
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Preview)
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
            Enabled = EnableActnIfTemplateNtBlck;
        }
    }
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        EnableActnIfTemplateNtBlck: Boolean;

    //BC UPGRADE PATHAA02>>
    trigger OnOpenPage()
    begin
        Clear(EnableActnIfTemplateNtBlck);
        EnableActnIfTemplateNtBlck := true;   //HEI.01
    end;

    trigger OnAfterGetCurrRecord();
    begin
        EnableActnIfTemplateNtBlck := Rec.EnableActionIfTemplateNtBlock();   //HEI.01   
    end;

    trigger OnAfterGetRecord();
    begin
        EnableActnIfTemplateNtBlck := Rec.EnableActionIfTemplateNtBlock();   //HEI.01
    end;
    //BC UPGRADE PATHAA02<<


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
    UpdateBalance;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EnableActnIfTemplateNtBlck := EnableActionIfTemplateNtBlock;   //HEI.01
    GenJnlManagement.GetAccounts(Rec,AccName,BalAccName);
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
    EnableActnIfTemplateNtBlck := EnableActionIfTemplateNtBlock;   //HEI.01
    ShowShortcutDimCode(ShortcutDimCode);
    */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TotalBalanceVisible := true;
    BalanceVisible := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TotalBalanceVisible := true;
    BalanceVisible := true;
    //HEI.01>>
    CLEAR(EnableActnIfTemplateNtBlck);
    EnableActnIfTemplateNtBlck := true;
    //HEI.01<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


}

