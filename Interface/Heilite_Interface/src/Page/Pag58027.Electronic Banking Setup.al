page 58027 "Electronic Banking Setup"
{
    // Heilite Navision Old Id - 50323

    // version HEI.01

    // HEI.01 V1.05 HT84 IBM POENAB02 20.05.2019 # New page for Bank Connectivity interface

    
    // BC UPGRADE PATELS08 >>
    // # Table name changed from "Electronic Banking Setup" to "Electronic Banking Setup FND".
    // BC UPGRADE PATELS08 <<

    CaptionML = ENU = 'Electronic Banking Setup',
                FRB = 'Configuration de la banque électronique',
                NLB = 'Instellen van elektronisch bankieren';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Electronic Banking Setup FND";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General',
                            FRB = 'Général',
                            NLB = 'Algemeen';
                field("Summarize Gen. Jnl. Lines"; Rec."Summarize Gen. Jnl. Lines")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies whether to summarize the payment journal lines by vendor, when you transfer the electronic banking journal lines.',
                                FRB = 'Spécifie si vous souhaitez résumer les lignes feuille paiement par fournisseur lorsque vous transférez les lignes feuille bancaire électronique.',
                                NLB = 'Hiermee wordt aangegeven of de betalingsdagboekregels worden samengevat volgens leverancier wanneer u de elektronische bankdagboekregels overzet.';
                }
                field("Cut off Payment Message Texts"; Rec."Cut off Payment Message Texts")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies if you want the payment message text to be truncated.',
                                FRB = 'Spécifie si vous souhaitez que la communication de paiement soit tronquée.',
                                NLB = 'Hiermee wordt aangegeven of u wilt dat de tekst van het betalingsbericht wordt afgekort.';
                }
                field("IBS Version"; Rec."IBS Version")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the version of Isabel that is used for electronic banking in your organization.',
                                FRB = 'Spécifie la version d''Isabel utilisée pour la fonction de banque électronique dans votre organisation.',
                                NLB = 'Hiermee wordt aangegeven welke versie van Isabel wordt gebruikt voor elektronisch bankieren in uw organisatie.';
                }
                field("Notification E-mail address"; Rec."Notification E-mail address")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the notification email address to use for electronic banking balance and transaction messages.',
                                FRB = 'Spécifie l''adresse électronique de notification à utiliser pour les messages concernant les opérations et le solde de la banque électronique.',
                                NLB = 'Hiermee wordt aangegeven welk e-mailadres wordt gebruikt voor berichten over elektronisch bankieren en transacties.';
                }
                field(Language; Rec.Language)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the language to use for electronic bank balance and transaction messages.',
                                FRB = 'Spécifie la langue à utiliser pour les messages concernant les opérations et le solde de la banque électronique.',
                                NLB = 'Hiermee wordt aangegeven welke taal wordt gebruikt voor berichten over elektronisch bankieren en transacties.';
                }
                field("IBS Service Version"; Rec."IBS Service Version")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the service version that is used to communicate with the Isabel server.',
                                FRB = 'Spécifie la version du service utilisé pour communiquer avec le serveur Isabel.',
                                NLB = 'Hiermee wordt de serviceversie aangegeven die wordt gebruikt om te communiceren met de Isabel-server.';
                }
            }
            group(Upload)
            {
                CaptionML = ENU = 'Upload',
                            FRB = 'Télécharger',
                            NLB = 'Uploaden';
                field("Upload Integration Mode"; Rec."Upload Integration Mode")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the mode to use to upload content to the Isabel server.',
                                FRB = 'Spécifie le mode à utiliser pour télécharger du contenu sur le serveur Isabel.',
                                NLB = 'Hiermee wordt de modus aangegeven die wordt gebruikt om content te uploaden naar de Isabel-server.';
                }
                field("Upload Path"; Rec."Upload Path")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the path to the folder where the files will be saved during the upload process.',
                                FRB = 'Spécifie le chemin d''accès au dossier où les fichiers sont enregistrés au cours du téléchargement sur le serveur.',
                                NLB = 'Hiermee wordt het pad aangegeven naar de map waar de bestanden worden opgeslagen tijdens het uploadproces.';
                }
            }
            group(Download)
            {
                CaptionML = ENU = 'Download',
                            FRB = 'Télécharger',
                            NLB = 'Downloaden';
                field("Download Integration Mode"; Rec."Download Integration Mode")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the mode to use to download content to the Isabel server.',
                                FRB = 'Spécifie le mode à utiliser pour télécharger du contenu du serveur Isabel.',
                                NLB = 'Hiermee wordt de modus aangegeven die wordt gebruikt om content te downloaden naar de Isabel-server.';
                }
                field("Download Path"; Rec."Download Path")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the path to the folder where the files will be saved during the download process.',
                                FRB = 'Spécifie le chemin d''accès au dossier où les fichiers sont enregistrés au cours du téléchargement depuis le serveur.',
                                NLB = 'Hiermee wordt het pad aangegeven naar de map waar de bestanden worden opgeslagen tijdens het downloadproces.';
                }
            }
            group(Numbering)
            {
                CaptionML = ENU = 'Numbering',
                            FRB = 'Numérotation',
                            NLB = 'Nummering';
                field("IBS Log Upload Nos."; Rec."IBS Log Upload Nos.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the number series that is used for Isabel log entries that are created during the file upload process.',
                                FRB = 'Spécifie la souche de numéros utilisée pour les écritures journal Isabel qui sont créées pendant le processus de téléchargement de fichiers sur le serveur.',
                                NLB = 'Hiermee wordt het aantal reeksen aangegeven dat wordt gebruikt voor registraties in het Isabel-logboek tijdens het uploaden van het bestand.';
                }
                field("IBS Log Download Nos."; Rec."IBS Log Download Nos.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the number series that is used for Isabel log entries created during the file download process.',
                                FRB = 'Spécifie la souche de numéros utilisée pour les écritures journal Isabel qui sont créées pendant le processus de téléchargement des fichiers du serveur.',
                                NLB = 'Hiermee wordt het aantal reeksen aangegeven dat wordt gebruikt voor registraties in het Isabel-logboek tijdens het downloaden van het proces.';
                }
                field("IBS Request ID"; Rec."IBS Request ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the number series that is used to uniquely identify the request from the Isabel server.',
                                FRB = 'Spécifie la souche de numéros utilisée pour identifier la requête du serveur Isabel de manière unique.',
                                NLB = 'Hiermee wordt het aantal reeksen aangegeven dat wordt gebruikt om het verzoek van de Isabel-server op een unieke manier te identificeren.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        rec.RESET();
        if not rec.GET() then begin
            rec.INIT();
            rec.INSERT();
        end;
    end;
}

