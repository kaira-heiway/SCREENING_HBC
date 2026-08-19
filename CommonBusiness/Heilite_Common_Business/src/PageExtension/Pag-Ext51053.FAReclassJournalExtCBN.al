pageextension 51053 FAReclassJournalExtCBN extends "FA Reclass. Journal"
{
    // HEI.01 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Added field "Reclassify Derogatory"
    // version NAVW110.0,DITW110.00.08

    //Bc Upgrade YADAVM09 Drink it field commented -Reclassify Derogatory.

    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the name of the journal batch of the fixed asset reclassification journal.', FRA = 'Spécifie le nom feuille de la feuille reclassement immobilisation.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the same date as the FA Posting Date field when the line is posted.', FRA = 'Spécifie la même date que celle du champ Date compta. immo. lorsque la ligne est validée.';
        }
        modify("FA Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date that will be used as the posting date on FA ledger entries.', FRA = 'Spécifie la date qui sera utilisée comme date comptabilisation immobilisation sur les écritures comptables immobilisation.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies a value depending on how you have set up the number series that is assigned to the current journal batch.', FRA = 'Spécifie une valeur qui dépend de la manière dont vous avez défini les souches de numéros affectées à la feuille.';
        }
        modify("FA No.")
        {
            ToolTipML = ENU = 'Specifies the number of the fixed asset you want to reclassify from.', FRA = 'Spécifie le numéro de l''immobilisation à partir de laquelle vous souhaitez reclasser.';
        }
        modify("New FA No.")
        {
            ToolTipML = ENU = 'Specifies the number of the fixed asset you want to reclassify to.', FRA = 'Spécifie le numéro de l''immobilisation vers laquelle vous souhaitez reclasser.';
        }
        modify("Depreciation Book Code")
        {
            ToolTipML = ENU = 'Specifies the code for the depreciation book the line will be posted to.', FRA = 'Spécifie le code de la loi d''amortissement sur laquelle la ligne est validée.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the asset entered in the FA No field. field.', FRA = 'Spécifie la description de l''immobilisation saisie dans le champ N° immo.';
        }
        modify("Reclassify Acq. Cost Amount")
        {
            ToolTipML = ENU = 'Specifies the acquisition amount you want to reclassify.', FRA = 'Spécifie le montant acquisition que vous souhaitez reclasser.';
        }
        modify("Reclassify Acq. Cost %")
        {
            ToolTipML = ENU = 'Specifies the percentage of the acquisition cost you want to reclassify.', FRA = 'Spécifie le pourcentage coût acquisition que vous souhaitez reclasser.';
        }
        modify("Reclassify Acquisition Cost")
        {
            ToolTipML = ENU = 'Specifies the reclassification of the acquisition cost for the fixed asset entered in the FA No. field, to the fixed asset entered in the New FA No. field.', FRA = 'Spécifie le reclassement du coût d''acquisition de l''immobilisation saisie dans le champ N° immo. en fonction de l''immobilisation saisie dans le champ Nouveau N° immo.';
        }
        modify("Reclassify Depreciation")
        {
            ToolTipML = ENU = 'Specifies the reclassification of the accumulated depreciation for the fixed asset entered in the FA No. field, to the fixed asset entered in the New FA No. field.', FRA = 'Spécifie le reclassement de l''amortissement cumulé de l''immobilisation saisie dans le champ N° immo. en fonction de l''immobilisation saisie dans le champ Nouveau N° immo.';
        }
        modify("Reclassify Write-Down")
        {
            ToolTipML = ENU = 'Specifies the reclassification of all write-down entries for the fixed asset entered in the FA No. field to the fixed asset you have entered in the New FA No. field.', FRA = 'Spécifie le reclassement des écritures dépréciation de l''immobilisation saisie dans le champ N° immo. en fonction de l''immobilisation saisie dans le champ Nouveau N° immo.';
        }
        modify("Reclassify Appreciation")
        {
            ToolTipML = ENU = 'Specifies the reclassification of all appreciation entries for the fixed asset entered in the FA No. field to the fixed asset entered in the New FA No. field.', FRA = 'Spécifie le reclassement de toutes les écritures réévaluation de l''immobilisation saisie dans le champ N° immo. en fonction de l''immobilisation saisie dans le champ Nouveau N° immo.';
        }
        modify("Reclassify Custom 1")
        {
            ToolTipML = ENU = 'Specifies the reclassification of all custom 1 entries for the fixed asset entered in the FA No. field to the fixed asset entered in the New FA No. field.', FRA = 'Spécifie le reclassement de toutes les écritures Param. 1 de l''immobilisation saisie dans le champ N° immo. en fonction de l''immobilisation saisie dans le champ Nouveau N° immo.';
        }
        modify("Reclassify Custom 2")
        {
            ToolTipML = ENU = 'Specifies the reclassification of all custom 2 entries for the fixed asset entered in the FA No. field to the fixed asset entered in the New FA No. field.', FRA = 'Spécifie le reclassement de toutes les écritures Param. 2 de l''immobilisation saisie dans le champ N° immo. en fonction de l''immobilisation saisie dans le champ Nouveau N° immo.';
        }
        modify("Reclassify Salvage Value")
        {
            ToolTipML = ENU = 'Specifies the salvage value for the fixed asset to be reclassified to the fixed asset entered in the New FA No. field.', FRA = 'Spécifie la valeur résiduelle de l''immobilisation à reclasser en fonction de l''immobilisation saisie dans le champ Nouveau N° immo.';
        }
        modify("Insert Bal. Account")
        {
            ToolTipML = ENU = 'Specifies whether to create one or more balancing entry lines in the FA general ledger journal or FA Journal.', FRA = 'Spécifie s''il faut créer ou non une ou plusieurs lignes écriture contrepartie dans la feuille cpta. immobilisation ou dans la feuille immobilisation.';
        }
        modify("Calc. DB1 Depr. Amount")
        {
            ToolTipML = ENU = 'Specifies that the Reclassify function fills in the Temp. Ending Date and Temp. Fixed Depr. Amount fields on the FA depreciation book.', FRA = 'Spécifie que la fonction Reclasser complète les champs Date fin temp. et Montant annuité amortissement temp. dans le plan amortissement.';
        }
        modify("FA Description")
        {
            CaptionML = ENU = 'FA Description', FRA = 'Description immo.';
        }
        modify(FADescription)
        {
            ToolTipML = ENU = 'Specifies a description of the fixed asset.', FRA = 'Spécifie une description de l''immobilisation.';
        }
        modify("New FA Description")
        {
            CaptionML = ENU = 'New FA Description', FRA = 'Nouvelle désignation immo.';
        }
        modify(NewFADescription)
        {
            CaptionML = ENU = 'New FA Description', FRA = 'Nouvelle désignation immo.';
            ToolTipML = ENU = 'Specifies a description of the fixed asset that is entered in the New FA No. field on the line.', FRA = 'Spécifie une description de l''immobilisation saisie dans le champ Nouveau N° immo. de la ligne.';
        }

        //Unsupported feature: CodeModification on "CurrentJnlBatchName(Control 10).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        FAReclassJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        FAReclassJnlManagement.LookupName(CurrentJnlBatchName,Rec);
        CurrPage.UPDATE(false);
        */
        //end;
        /*//Bc Upgrade YADAVM09 Drink it field>>
        addafter("Reclassify Salvage Value")
        {
            field("Reclassify Derogatory"; Rec."Reclassify Derogatory")
            {
                ApplicationArea = FixedAssets;
                Enabled = FRLocAction;
                ToolTipML = ENU = 'Specifies that you want to reclassify the accumulated derogatory depreciation in the FA No. field to the fixed asset in the New FA No. field.',
                            FRA = 'Spécifie que vous voulez reclasser l''amortissement dérogatoire cumulé dans le champ N° immo. en fonction de l''immobilisation saisie dans le champ Nouveau N° immo.';
                Visible = false;
            }
        }
        *///Bc Upgrade YADAVM09 Drink it field<<
        addafter("Calc. DB1 Depr. Amount")
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
        modify(Reclassify)
        {
            CaptionML = ENU = 'Recl&assify', FRA = '&Reclasser';
            ToolTipML = ENU = 'Reclassify the fixed asset information on the journal lines.', FRA = 'Reclassez les informations d''immobilisation sur les lignes feuille.';
        }


        //Unsupported feature: CodeModification on "Reclassify(Action 30).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"FA Reclass. Jnl.-Transfer",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"FA Reclass. Jnl.-Transfer",Rec);
        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
        CurrPage.UPDATE(false);
        */
        //end;
    }

    var
        CompanyInfo: Record "Company Information";
        FRLocAction: Boolean;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF IsOpenedFromBatch THEN BEGIN
      CurrentJnlBatchName := "Journal Batch Name";
      FAReclassJnlManagement.OpenJournal(CurrentJnlBatchName,Rec);
      EXIT;
    end;
    FAReclassJnlManagement.TemplateSelection(PAGE::"FA Reclass. Journal",Rec,JnlSelected);
    IF NOT JnlSelected THEN
      ERROR('');

    FAReclassJnlManagement.OpenJournal(CurrentJnlBatchName,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //HEI.01>>
    CompanyInfo.GET;
    FRLocAction := false;
    if CompanyInfo."Enable French Localization" then
      FRLocAction := true;
    //HEI.01<<

    if IsOpenedFromBatch then begin
      CurrentJnlBatchName := "Journal Batch Name";
      FAReclassJnlManagement.OpenJournal(CurrentJnlBatchName,Rec);
      exit;
    end;
    FAReclassJnlManagement.TemplateSelection(PAGE::"FA Reclass. Journal",Rec,JnlSelected);
    if not JnlSelected then
    #8..10
    */
    //end;


    //Unsupported feature: CodeModification on "CurrentJnlBatchNameOnAfterVali(PROCEDURE 19002411)". Please convert manually.

    //procedure CurrentJnlBatchNameOnAfterVali();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SAVERECORD;
    FAReclassJnlManagement.SetName(CurrentJnlBatchName,Rec);
    CurrPage.UPDATE(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.SAVERECORD;
    FAReclassJnlManagement.SetName(CurrentJnlBatchName,Rec);
    CurrPage.UPDATE(false);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

