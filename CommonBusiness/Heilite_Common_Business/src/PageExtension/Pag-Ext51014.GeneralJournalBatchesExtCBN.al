pageextension 51014 GeneralJournalBatchesExtCBN extends "General Journal Batches"
{
    // version NAVW110.0,HEI.08
    // HEI.01 FDD PTPGAP026 - Payment Method List IBM.NAIKH01 03.08.2017
    //   # Added a new Fields Payment Method Code.
    // HEI.02 FDD-PTPGAP072 IBM NASTAA02 22.02.2018 # Cashier Order Creation
    //   # New field added "Cashier Order Report ID"
    // HEI.03 FDDD PTPGAP078 IBM POSTOI01 15.05.2018
    //   # show new field Heineken Bank Account Code
    //   # show new field Bank Payment Type
    // HEI.04 FDD-HT704 IBM BULIMC01 25.07.2019 #New field displayed "Cashier ID"

    // HEI.05 CHG2030722 IBM.LS 17.09.2019
    //   # New field added - "Amount (LCY)"
    //   # New field added - "Debit Amount (LCY)"
    //   # New field added - "Credit Amount (LCY)"

    // HEI.06 FDD-HT1211 BULIMC01 IBM 20.05.2020 #new function created "GetSelectionFilter"
    // HEI.07 CHG2255994 IBM KAPOOV01 04.07.2024 P&L Close 2022 in Production Environment
    //   # New field created:50011 - "Dim. Comb. Not Appl."
    // HEI.08 CHG2271823 IBM KAPOOV01 08.11.2024 Field to Block/Unblock General Journal templates
    //   #Modified Trigger/Functions- OnInit(),OnOpenPage()
    //   #Modified Enable Property of Various Actions & Action Groups
    layout
    {
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the journal you are creating.', FRA = 'Indiquez le nom de la feuille que vous créez.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a brief description of the journal batch you are creating.', FRA = 'Indique une brève description de la feuille que vous créez.';
        }
        modify("Bal. Account Type")
        {
            ToolTipML = ENU = 'Specifies the value you have selected in the Bal. Account Type field on the journal template. You may change this value.', FRA = 'Spécifie la valeur que vous avez sélectionnée dans le champ Type compte contrepartie du modèle feuille. Vous pouvez modifier cette valeur.';
        }
        modify("Bal. Account No.")
        {
            ToolTipML = ENU = 'Specifies a copy of the Bal. Account No. field, or the balancing account number for this general journal batch.', FRA = 'Spécifie une copie du champ Type compte contrepartie ou le numéro de compte de contrepartie pour cette feuille comptabilité.';
        }
        modify("No. Series")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign document numbers to journal lines in this journal batch.', FRA = 'Spécifie le code de la souche de numéros utilisée pour affecter des numéros de document aux lignes feuille.';
        }
        modify("Posting No. Series")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign document numbers to ledger entries that are posted from this journal batch.', FRA = 'Spécifie le code de la souche de numéros utilisée pour affecter des numéros de document aux écritures comptables validées à partir de cette feuille.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code that is linked to the general journal template.', FRA = 'Spécifie le code motif qui a été saisi sur le modèle feuille comptabilité.';
        }
        modify("Copy VAT Setup to Jnl. Lines")
        {
            ToolTipML = ENU = 'Specifies whether the program to calculate VAT for accounts and balancing accounts on the journal line of the selected journal batch.', FRA = 'Indique si vous souhaitez que le programme calcule la TVA pour les comptes et les comptes contrepartie dans la ligne feuille du traitement par lots sélectionné.';
        }
        modify("Allow VAT Difference")
        {
            ToolTipML = ENU = 'Specifies whether to allow the manual adjustment of VAT amounts in journal templates.', FRA = 'Indique s''il faut autoriser l''ajustement manuel des montants de TVA dans les modèles feuille.';
        }
        modify("Allow Payment Export")
        {
            ToolTipML = ENU = 'Specifies if you can export bank payment files from payment journal lines using this general journal batch.', FRA = 'Indique si vous pouvez exporter des fichiers de paiement bancaire à partir de lignes feuille paiement à l''aide de ce nom feuille comptabilité.';
        }
        modify("Suggest Balancing Amount")
        {
            ToolTipML = ENU = 'Specifies if the Amount field on journal lines for the same document number is automatically prefilled with the value that is required to balance the document.', FRA = 'Indique si le champ Montant des lignes feuille pour le même numéro de document est automatiquement pré-rempli avec la valeur nécessaire pour équilibrer le document.';
        }
        modify("Bank Statement Import Format")
        {
            ToolTipML = ENU = 'Specifies the format of the bank statement file that can be imported into this general journal batch.', FRA = 'Indique le format du fichier de relevé bancaire qui peut être importé dans ce nom feuille comptabilité.';
        }
        addafter("Bal. Account No.")
        {
            field("HNK Bank Account"; Rec."HNK Bank Account FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the HNK Bank Account field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the HNK Bank Account field.';

            }
            field("Bank Payment Type"; Rec."Bank Payment Type FND")
            {
                Editable = true;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank Payment Type field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Bank Payment Type field.';

            }
            field(Amount; Rec."Amount FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Amount field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Amount field.';

            }
            field("Debit Amount"; Rec."Debit Amount FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Debit Amount field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Debit Amount field.';

            }
            field("Amount (LCY)"; Rec."Amount (LCY) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Amount (LCY) field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Amount (LCY) field.';

            }
            field("Debit Amount (LCY)"; Rec."Debit Amount (LCY) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Debit Amount (LCY) field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Debit Amount (LCY) field.';

            }
            field("Credit Amount (LCY)"; Rec."Credit Amount (LCY) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Credit Amount (LCY) field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Credit Amount (LCY) field.';

            }
        }
        addafter("Bank Statement Import Format")
        {
            field("Payment Method Code"; Rec."Payment Method Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payment Method Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Payment Method Code field.';

            }
            field("Dim. Comb. Not Appl."; Rec."Dim. Comb. Not Appl. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dim. Comb. Not Appl. field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dim. Comb. Not Appl. field.';

            }
            field("Cashier ID"; Rec."Cashier ID FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cashier ID field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Cashier ID field.';

            }
            field("Cashier Order Report ID"; Rec."Cashier Order Report ID FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cashier Order Report ID field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Cashier Order Report ID field.';

            }
        }
    }
    actions
    {
        modify(EditJournal)
        {
            CaptionML = ENU = 'Edit Journal', FRA = 'Modifier feuille';
            ToolTipML = ENU = 'Edit the general journal.', FRA = 'Modifiez la feuille comptabilité.';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(TestReport)
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify("P&ost")
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
            ToolTipML = ENU = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.', FRA = 'Finalisez et préparez-vous à imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenêtre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément à imprimer.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(MarkedOnOff)
        {
            CaptionML = ENU = 'Marked On/Off', FRA = 'Marqué marche/arrêt';
            ToolTipML = ENU = 'View all journal batches or only marked journal batches. A journal batch is marked if an attempt to post the general journal fails.', FRA = 'Affichez toutes les feuilles ou uniquement celles marquées. Une feuille est marquée si une tentative de validation de celle-ci échoue.';
        }
        modify("Periodic Activities")
        {
            CaptionML = ENU = 'Periodic Activities', FRA = 'Activités périodiques';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Recurring General Journal")
        {
            CaptionML = ENU = 'Recurring General Journal', FRA = 'Feuille abonnement';
            ToolTipML = ENU = 'Define how to post transactions that recur with few or no changes to general ledger, bank, customer, vendor, and fixed assets accounts.', FRA = 'Définissez la manière de valider des transactions qui requièrent peu ou pas de modification sur les écritures comptables, les comptes bancaires, client, fournisseur et immobilisation.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("G/L Register")
        {
            CaptionML = ENU = 'G/L Register', FRA = 'Hist. trans. comptabilité';
            ToolTipML = ENU = 'View posted G/L entries.', FRA = 'Affichez les écritures comptables validées.';
        }
        modify("Detail Trial Balance")
        {
            CaptionML = ENU = 'Detail Trial Balance', FRA = 'Grand livre';
            ToolTipML = ENU = 'View detail general ledger account balances and activities.', FRA = 'Affichez les soldes et les activités comptes généraux détaillés.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Trial Balance")
        {
            CaptionML = ENU = 'Trial Balance', FRA = 'Balance';
            ToolTipML = ENU = 'View general ledger account balances and activities.', FRA = 'Affichez les soldes et activités comptes généraux.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify("Trial Balance by Period")
        {
            CaptionML = ENU = 'Trial Balance by Period', FRA = 'Balance par période';
            ToolTipML = ENU = 'View general ledger account balances and activities within a selected period.', FRA = 'Affichez les soldes et activités comptes généraux sur une période donnée.';
            Enabled = EnableActnIfTemplateNtBlck;
        }
        modify(Action10)
        {
            CaptionML = ENU = 'G/L Register', FRA = 'Hist. trans. comptabilité';
            ToolTipML = ENU = 'View posted G/L entries.', FRA = 'Affichez les écritures comptables validées.';
            Enabled = EnableActnIfTemplateNtBlck;
        }


        //Unsupported feature: CodeModification on "MarkedOnOff(Action 26).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        MARKEDONLY(NOT MARKEDONLY);
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        MARKEDONLY(not MARKEDONLY);
        CurrPage.UPDATE(false);
        */
        //end;
    }

    var
        EnableActnIfTemplateNtBlck: Boolean;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    //HEI.08>>
    CLEAR(EnableActnIfTemplateNtBlck);
    EnableActnIfTemplateNtBlck := true;
    //HEI.08<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GenJnlManagement.OpenJnlBatch(Rec);
    ShowAllowPaymentExportForPaymentTemplate;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    EnableActnIfTemplateNtBlck := EnableActionIfTemplateNtBlock;  //HEI.08
    GenJnlManagement.OpenJnlBatch(Rec);
    ShowAllowPaymentExportForPaymentTemplate;
    */
    //end;


    //Unsupported feature: CodeModification on "DataCaption(PROCEDURE 1)". Please convert manually.

    //procedure DataCaption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT CurrPage.LOOKUPMODE THEN
      IF GETFILTER("Journal Template Name") <> '' THEN
        IF GETRANGEMIN("Journal Template Name") = GETRANGEMAX("Journal Template Name") THEN
          IF GenJnlTemplate.GET(GETRANGEMIN("Journal Template Name")) THEN
            EXIT(GenJnlTemplate.Name + ' ' + GenJnlTemplate.Description);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if not CurrPage.LOOKUPMODE then
      if GETFILTER("Journal Template Name") <> '' then
        if GETRANGEMIN("Journal Template Name") = GETRANGEMAX("Journal Template Name") then
          if GenJnlTemplate.GET(GETRANGEMIN("Journal Template Name")) then
            exit(GenJnlTemplate.Name + ' ' + GenJnlTemplate.Description);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowAllowPaymentExportForPaymentTemplate(PROCEDURE 2)". Please convert manually.

    //procedure ShowAllowPaymentExportForPaymentTemplate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GenJournalTemplate.GET("Journal Template Name") THEN
      IsPaymentTemplate := GenJournalTemplate.Type = GenJournalTemplate.Type::Payments;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if GenJournalTemplate.GET("Journal Template Name") then
      IsPaymentTemplate := GenJournalTemplate.Type = GenJournalTemplate.Type::Payments;
    */
    //end;

    procedure GetSelectionFilter(): Text;
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        //HEI.06>>
        CurrPage.SETSELECTIONFILTER(GenJournalBatch);
        //exit(SelectionFilterManagement.GetSelectionFilterForGenJnlBatch(GenJournalBatch));  // BC Upgrade NANDIS03

        //HEI.06<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    // BC Upgrade NANDIS03 >>
    trigger OnOpenPage()
    begin
        EnableActnIfTemplateNtBlck := Rec.EnableActionIfTemplateNtBlock();  //HEI.08
    end;
    // BC Upgrade NANDIS03 <<

}

