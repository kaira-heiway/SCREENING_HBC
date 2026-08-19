pageextension 51092 ItemjournalTemplateListExtCBN extends "Item Journal Template List"
{
    // HEI.01 CHG2049056 IBM.LS      06.07.2021
    //# Added Field - Type

    layout
    {
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the item journal you are creating.', FRA = 'Spécifie le nom de la feuille article que vous créez.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a brief description of the item journal template you are creating.', FRA = 'Spécifie une brève description du modèle de feuille article que vous créez.';
        }
        modify(Recurring)
        {
            ToolTipML = ENU = 'Specifies whether the item journal template will be a recurring journal.', FRA = 'Spécifie si le modèle feuille article est une feuille récurrente.';
        }
        modify("Source Code")
        {
            ToolTipML = ENU = 'Specifies the source code that is linked to the item journal template.', FRA = 'Spécifie le code journal lié au modèle feuille article.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies a reason code that will be inserted on the journal lines.', FRA = 'Spécifie un code motif qui va être inséré dans les lignes feuille.';
        }
        modify("Page ID")
        {
            ToolTipML = ENU = 'Specifies the window number for the item journal.', FRA = 'Spécifie le numéro de la fenêtre de la feuille article.';
        }
        modify("Page Caption")
        {
            ToolTipML = ENU = 'Specifies the name of the item journal template''s window.', FRA = 'Spécifie le nom de la fenêtre du modèle feuille article.';
        }
        modify("Test Report ID")
        {
            ToolTipML = ENU = 'Specifies the test report that is printed when you click Actions, point to Posting, and then click Test Report.', FRA = 'Spécifie le test qui est imprimé lorsque vous cliquez sur Actions, pointez sur Validation, puis cliquez sur Impression test.';
        }
        modify("Test Report Caption")
        {
            ToolTipML = ENU = 'Specifies the name of the test report that is printed when you print the item journal.', FRA = 'Spécifie le nom du test qui est imprimé lorsque vous imprimez la feuille article.';
        }
        modify("Posting Report ID")
        {
            ToolTipML = ENU = 'Specifies the posting report that is printed when you click Post and Print.', FRA = 'Spécifie l''état de validation qui est imprimé lorsque vous cliquez sur Valider et imprimer.';
        }
        modify("Posting Report Caption")
        {
            ToolTipML = ENU = 'Specifies the name of the report that is printed when you print the item journal.', FRA = 'Spécifie le nom de l''état qui est imprimé lorsque vous imprimez la feuille article.';
        }
        modify("Force Posting Report")
        {
            ToolTipML = ENU = 'Specifies whether a report is printed automatically when you post from the journal template.', FRA = 'Spécifie si un état est automatiquement imprimé lorsque vous validez à partir du modèle feuille.';
        }
        addafter(Description)
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the type of transaction that will be used with this item journal template.';
            }
        }
        //BC Upgrade Kamnay01>> DITW Field
        // addafter("Force Posting Report")
        // {
        //     field("Work Order Mandatory";"Work Order Mandatory")
        //     {
        //         Description = 'DIT-715 #457';
        //         Visible = false;
        //     }
        // }
        //BC Upgrade Kamnay01<< DITW Field
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

