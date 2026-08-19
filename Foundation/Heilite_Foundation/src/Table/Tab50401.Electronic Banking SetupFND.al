table 50401 "Electronic Banking Setup FND"
{
    // Heilite Navision Old Id - 50134
    // version HEI.01

    // HEI.01 V1.05 HT84 IBM POENAB02 20.05.2019 # New table for Bank Connectivity interface

    // BC UPGRADE PATELS08 >>
    // # Table moved from Interfaces to Foundation Layer.
    // # Table name changed from "Electronic Banking Setup" to "Electronic Banking Setup FND".
    // BC UPGRADE PATELS08 <<

    CaptionML = ENU = 'Electronic Banking Setup',
                FRB = 'Configuration de la banque électronique',
                NLB = 'Instellen van elektronisch bankieren';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            CaptionML = ENU = 'Primary Key',
                        FRB = 'Clé primaire',
                        NLB = 'Primaire sleutel';
        }
        field(2; "Summarize Gen. Jnl. Lines"; Boolean)
        {
            CaptionML = ENU = 'Summarize Gen. Jnl. Lines',
                        FRB = 'Résumer lignes FS',
                        NLB = 'Dagboekregels samenvatten';
            InitValue = true;
        }
        field(3; "Cut off Payment Message Texts"; Boolean)
        {
            CaptionML = ENU = 'Cut off Payment Message Texts',
                        FRB = 'Couper comm. de paiement',
                        NLB = 'Betalingsmededelingen afkappen';
            InitValue = false;
        }
        field(21; "IBS Version"; Option)
        {
            CaptionML = ENU = 'IBS Version',
                        FRB = 'Version IBS',
                        NLB = 'IBS-versie';
            OptionCaptionML = ENU = ' ,1,2,3,4,5,6',
                              FRB = ' ,1,2,3,4,5,6',
                              NLB = ' ,1,2,3,4,5,6';
            OptionMembers = " ","1","2","3","4","5","6";
        }
        field(22; "Notification E-mail address"; Text[30])
        {
            CaptionML = ENU = 'Notification E-mail address',
                        FRB = 'Adresse électronique de notification',
                        NLB = 'Berichtgeving e-mailadres';
        }
        field(23; Language; Option)
        {
            CaptionML = ENU = 'Language',
                        FRB = 'Langue',
                        NLB = 'Taal';
            OptionCaptionML = ENU = 'EN,FR,NL,DE',
                              FRB = 'EN,FR,BE,DE',
                              NLB = 'EN,FR,NL,DE';
            OptionMembers = EN,FR,NL,DE;
        }
        field(24; "Upload Integration Mode"; Option)
        {
            CaptionML = ENU = 'Upload Integration Mode',
                        FRB = 'Mode d''intégration du téléchargement (amont)',
                        NLB = 'Uploadintegratiemodus';
            OptionCaptionML = ENU = 'Manual,Attended',
                              FRB = 'Manuel,Interactif',
                              NLB = 'Handmatig,deelgenomen';
            OptionMembers = Manual,Attended;

            trigger OnValidate();
            begin
                if (xRec."Upload Integration Mode" <> "Upload Integration Mode") and
                   ("Upload Integration Mode" = "Upload Integration Mode"::Attended)
                then
                    TESTFIELD("IBS Version", "IBS Version"::"6");
            end;
        }
        field(25; "Upload Path"; Text[250])
        {
            CaptionML = ENU = 'Upload Path',
                        FRB = 'Chemin du téléchargement (amont)',
                        NLB = 'Uploadpad';
        }
        field(26; "Download Integration Mode"; Option)
        {
            CaptionML = ENU = 'Download Integration Mode',
                        FRB = 'Mode d''intégration du téléchargement (aval)',
                        NLB = 'Downloadintegratiemodus';
            OptionCaptionML = ENU = 'Manual,Attended',
                              FRB = 'Manuel,Interactif',
                              NLB = 'Handmatig,deelgenomen';
            OptionMembers = Manual,Attended;

            trigger OnValidate();
            begin
                if (xRec."Download Integration Mode" <> "Download Integration Mode") and
                   ("Download Integration Mode" = "Download Integration Mode"::Attended)
                then
                    TESTFIELD("IBS Version", "IBS Version"::"6");
            end;
        }
        field(27; "Download Path"; Text[250])
        {
            CaptionML = ENU = 'Download Path',
                        FRB = 'Chemin du téléchargement (aval)',
                        NLB = 'Downloadpad';
        }
        field(28; "IBS Log Upload Nos."; Code[10])
        {
            CaptionML = ENU = 'IBS Log Upload Nos.',
                        FRB = 'Nos de téléchargement (amont) du journal IBS',
                        NLB = 'IBS-logbestand uploadnrs.';
            TableRelation = "No. Series";
        }
        field(29; "IBS Log Download Nos."; Code[10])
        {
            CaptionML = ENU = 'IBS Log Download Nos.',
                        FRB = 'Nos de téléchargement (aval) du journal IBS',
                        NLB = 'IBS-logbestand downloadnrs.';
            TableRelation = "No. Series";
        }
        field(30; "IBS Request ID"; Code[10])
        {
            CaptionML = ENU = 'IBS Request ID',
                        FRB = 'ID demande IBS',
                        NLB = 'IBS-aanvraag ID';
            TableRelation = "No. Series";
        }
        field(31; "IBS Service Version"; Code[10])
        {
            CaptionML = ENU = 'IBS Service Version',
                        FRB = 'Version de service IBS',
                        NLB = 'IBS-serviceversie';
        }
        field(40; "Test Environment"; Boolean)
        {
            CaptionML = ENU = 'Test Environment',
                        FRB = 'Environnement test',
                        NLB = 'Testomgeving';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

