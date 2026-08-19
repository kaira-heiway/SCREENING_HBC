page 50295 "Gen Temp. for  lookup"
{
    // version HEI.01

    // HEI.01 CHG2238142 IBM YADAVM09 20.03.2024 #Harmonization of RTR templates plus disabling old templates
    //   #New page created for lookup

    CaptionML = ENU = 'General Journal Template List',
                FRA = 'Liste modèles f. comptabilité';
    Editable = false;
    PageType = List;
    SourceTable = "Gen. Journal Template";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the name of the journal template you are creating.',
                                FRA = 'Spécifie le nom du modèle de feuille que vous créez.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies a brief description of the journal template you are creating.',
                                FRA = 'Spécifie une brève description du modèle de feuille que vous créez.';
                }
                field(Type; Rec.Type)
                {
                    ToolTipML = ENU = 'Specifies the journal type.',
                                FRA = 'Indique le type de feuille.';
                    Visible = false;
                }
                field(Recurring; Rec.Recurring)
                {
                    ToolTipML = ENU = 'Specifies whether the journal template will be a recurring journal.',
                                FRA = 'Spécifie si le modèle feuille est une feuille récurrente.';
                    Visible = false;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ToolTipML = ENU = 'Specifies the source code linked to the journal template.',
                                FRA = 'Spécifie le code source lié au modèle feuille.';
                    Visible = false;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTipML = ENU = 'Specifies a reason code that will be inserted on the journal lines.',
                                FRA = 'Spécifie un code motif qui va être inséré dans les lignes feuille.';
                    Visible = false;
                }
                field("Force Doc. Balance"; Rec."Force Doc. Balance")
                {
                    ToolTipML = ENU = 'Specifies whether transactions that are posted in the general journal must balance by document number and document type.',
                                FRA = 'Indique si les transactions qui sont validées dans la feuille doivent être équilibrées par numéro et par type de document.';
                    Visible = false;
                }
                field("Page ID"; Rec."Page ID")
                {
                    LookupPageID = Objects;
                    ToolTipML = ENU = 'Specifies the window number used by the program for this journal template.',
                                FRA = 'Spécifie le numéro de la fenêtre utilisée par le programme pour ce modèle feuille.';
                    Visible = false;
                }
                field("Page Caption"; Rec."Page Caption")
                {
                    DrillDown = false;
                    ToolTipML = ENU = 'Specifies the name of the journal template''s window.',
                                FRA = 'Spécifie le nom de la fenêtre du modèle feuille.';
                    Visible = false;
                }
                field("Test Report ID"; Rec."Test Report ID")
                {
                    LookupPageID = Objects;
                    ToolTipML = ENU = 'Specifies the test report that is printed when you click Test Report.',
                                FRA = 'Spécifie le test qui est imprimé lorsque vous cliquez sur Impression test.';
                    Visible = false;
                }
                field("Test Report Caption"; Rec."Test Report Caption")
                {
                    DrillDown = false;
                    ToolTipML = ENU = 'Specifies the name of the test report that is printed when you print a journal under this journal template.',
                                FRA = 'Spécifie le nom de l''impression test qui est imprimée lorsque vous imprimez une feuille dans ce modèle feuille.';
                    Visible = false;
                }
                field("Posting Report ID"; Rec."Posting Report ID")
                {
                    LookupPageID = Objects;
                    ToolTipML = ENU = 'Specifies the posting report that is printed when you choose Post and Print.',
                                FRA = 'Spécifie l''état de validation qui est imprimé lorsque vous cliquez sur Valider et imprimer.';
                    Visible = false;
                }
                field("Posting Report Caption"; Rec."Posting Report Caption")
                {
                    DrillDown = false;
                    ToolTipML = ENU = 'Specifies the name of the report that is printed when you print the journal.',
                                FRA = 'Spécifie le nom de l''état qui est imprimé lorsque vous imprimez la feuille.';
                    Visible = false;
                }
                field("Force Posting Report"; Rec."Force Posting Report")
                {
                    ToolTipML = ENU = 'Specifies whether a report is printed automatically when you post.',
                                FRA = 'Spécifie si un état est automatiquement imprimé lorsque vous validez.';
                    Visible = false;
                }
                field("Customer Mandate"; Rec."Customer Mandate FND")
                {
                    ToolTip = 'Specifies the value of the Customer Mandate field.';
                }
                field("Ext. Doc. No. Mandatory"; Rec."Ext. Doc. No. Mandatory FND")
                {
                    ToolTip = 'Specifies the value of the Ext. Doc. No. Mandatory field.';
                }
                field("Restrct Duplicate Extrn Doc"; Rec."Restrct Dplct. Extrn Doc FND")
                {
                    ToolTip = 'Specifies the value of the Restrct Duplicate Extrn Doc field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

