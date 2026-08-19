pageextension 51088 ItemJournalTemplatesExtCBN extends "Item Journal Templates"
{
    //     HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 26.10.2018 # Counterpoint Interface
    //   # New Field added: "Save Batch"
    // HEI.02 CHG2180069 ZOGHLE01 03.02.2023 #Limiting selection options in Entry Type column in Item journal template SCRAP
    //   # New Field added - "Limit Type Selection"

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
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the type of transaction that will be used with this item journal template.', FRA = 'Spécifie le type de transaction qui est utilisé pour ce modèle feuille article.';
        }
        modify(Recurring)
        {
            ToolTipML = ENU = 'Specifies whether the item journal template will be a recurring journal.', FRA = 'Spécifie si le modèle feuille article est une feuille récurrente.';
        }
        modify("No. Series")
        {
            ToolTipML = ENU = 'Specifies the number series code used to assign document numbers to journal lines in this item journal template.', FRA = 'Spécifie le code des souches de numéros qui sont utilisées pour affecter des numéros de document aux lignes feuille dans ce modèle feuille article.';
        }
        modify("Posting No. Series")
        {
            ToolTipML = ENU = 'Specifies the number series code used to assign document numbers to ledger entries that are posted from journals using this template.', FRA = 'Spécifie le code souche de numéros utilisé pour affecter des numéros de document aux écritures comptables validées à partir de feuilles créées d''après ce modèle.';
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
        modify("Whse. Register Report ID")
        {
            ToolTipML = ENU = 'Specifies the ID assigned to the Whse. Register Report.', FRA = 'Spécifie l''ID qui est affecté à l''état historique transactions entrepôt.';
        }
        modify("Whse. Register Report Caption")
        {
            ToolTipML = ENU = 'Specifies the name of the report that is printed when you print the item journal.', FRA = 'Spécifie le nom de l''état qui est imprimé lorsque vous imprimez la feuille article.';
        }
        modify("Force Posting Report")
        {
            ToolTipML = ENU = 'Specifies whether a report is printed automatically when you post from the journal template.', FRA = 'Spécifie si un état est automatiquement imprimé lorsque vous validez à partir du modèle feuille.';
        }
        //BC Upgrade Kamnay01>> DITW fields
        // addafter("Reason Code")
        // {
        //     field("Def. Gen. Bus. Posting Group";"Def. Gen. Bus. Posting Group")
        //     {
        //         Description = 'DITW17.00.02 DIT-770 #143';
        //     }
        // }
        //BC Upgrade Kamnay01<< DITW fields

        //BCUP0-92 PATHAA02 08.07.26>>
        addafter("Reason Code")
        {
            field("Def. Gen. Bus. Posting Group FND"; Rec."Def. Gen. Bus. Posting Group FND")
            {
                Description = 'BCUP0-92';
                ApplicationArea = All;
            }
        }
        //BCUP0-92 PATHAA02 08.07.26<<

        addafter("Force Posting Report")
        {
            //BC Upgrade Kamnay01>> DITW fields
            // field("Work Order Mandatory";"Work Order Mandatory")
            // {
            //     Description = 'DIT-715 #457';
            // }
            //BC Upgrade Kamnay01<< DITW fields
            field("Save Batch"; Rec."Save Batch FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Save Batch field.';
            }
            field("Limit Type Selection"; Rec."Limit Type Selection FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Limit Type Selection field.';
            }
        }
    }
    actions
    {
        modify("Te&mplate")
        {
            CaptionML = ENU = 'Te&mplate', FRA = '&Modèle';
        }
        modify(Batches)
        {
            CaptionML = ENU = 'Batches', FRA = 'Noms feuilles';
            ToolTipML = ENU = 'Set up multiple item journals for a specific template. You can use batches when you need multiple journals of a certain type.', FRA = 'Configurez plusieurs feuilles article pour un modèle spécifique. Vous pouvez utiliser des lots lorsque vous avez besoin de plusieurs feuilles d''un certain type.';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

