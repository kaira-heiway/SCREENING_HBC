pageextension 51093 ItemJournalBatchesExtCBN extends "Item Journal Batches"
{
    //     HEI.01 CHG2049056 IBM.LS      01.03.2021
    //   # Added New Field - Use in Workflow
    //   # Added Field - Template Type
    // HEI.02 CHG2118467 IBM.LS      22.09.2021
    //   # Added New Field - Use in Bulk Transfer
    // HEI.03 CHG2219877 PRASAA03 10.10.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    //   # Added Mand. Global dimension 1 and Mand. Global dimension 2 fields in front end.

    layout
    {
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the item journal you are creating.', FRA = 'Spécifie le nom de la feuille article que vous créez.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a brief description of the item journal batch you are creating.', FRA = 'Indique une brève description de la feuille article que vous créez.';
        }
        modify("No. Series")
        {
            ToolTipML = ENU = 'Specifies the number series code used to assign document numbers to journal lines in this journal batch.', FRA = 'Spécifie le code des souches de numéros utilisé pour affecter des numéros de document aux lignes feuille dans cette feuille comptabilité.';
        }
        modify("Posting No. Series")
        {
            ToolTipML = ENU = 'Specifies the number series code used to assign document numbers to ledger entries that are posted from this journal batch.', FRA = 'Spécifie le code souche de numéros utilisé pour affecter des numéros de document aux écritures comptables validées à partir de cette feuille.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code that has been entered on the item journal template.', FRA = 'Spécifie le code motif qui a été saisi sur le modèle feuille article.';
        }
        addafter("Reason Code")
        {
            field("Use in Workflow"; Rec."Use in Workflow FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Use in Workflow field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Use in Workflow field.';

            }
            field("Mand. Global DImension 1"; Rec."Mand. Global DImension 1 FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Mand. Global DImension 1 field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Mand. Global DImension 1 field.';

            }
            field("Mand. Global DImension 2"; Rec."Mand. Global DImension 2 FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Mand. Global DImension 2 field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Mand. Global DImension 2 field.';

            }
            field("Use in Bulk Transfer"; Rec."Use in Bulk Transfer FND")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Visible = false;
                ToolTip = 'Specifies the value of the Use in Bulk Transfer field.';
            }
            field("Template Type"; Rec."Template Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Template Type field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Template Type field.';

            }
        }
    }
    actions
    {
        modify("Edit Journal")
        {
            CaptionML = ENU = 'Edit Journal', FRA = 'Modifier feuille';
            ToolTipML = ENU = 'Open a journal based on the journal batch that you selected.', FRA = 'Ouvrez une feuille en fonction de celle sélectionnée.';
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
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
            ToolTipML = ENU = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.', FRA = 'Finalisez et préparez-vous à imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenêtre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément à imprimer.';
        }
    }

    var
        ItemJnlTemplate: Record "Item Journal Template";

    var
        UserJournalTemplate: Record "User Gen. Journal Setup FND";
        ItemJournalTemplateName: Text[100];


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger (Variable: ItemJnlTemplate)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemJnlMgt.OpenJnlBatch(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemJnlMgt.OpenJnlBatch(Rec);
    //CurrPage.UPDATE(TRUE);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

