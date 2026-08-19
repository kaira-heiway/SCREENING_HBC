table 50028 "G/L Entry Application Bffr FND"
{
    // version HEI.07

    // HEI.01 RTRGAP038 IBM.CHAUHB01 02/08/17 Added New Table
    //  # G/L Entry Application
    // HEI.02 CHG2047407 IBM PANDES01 01/04/20
    //  # Added new Field "Entries Posted By".
    // HEI.03 CHG2047407 IBM PANDES01 28/04/20
    //  # Added CaptionML on new Field "Entries Posted By".
    // HEI.04 CHG2070961/CHG2088483 IBM POENAB02 31.07.2020 Panama -  Suspense account issue related to BI
    //  # Added new field 73 Reversed
    // HEI.05 CHG2065276 BULIMC01 IBM 29.09.2020 #new field added: 50019 - "Comment"
    // HEI.06 INC4277941 SISUM01 IBM 31/08/2022  #add CaptionML on field 50019
    // HEI.07 CHG2169924 SISUM01 IBM 18/01/2023 #Add fields Letter and Letter Date

    CaptionML = ENU = 'G/L Entry Application Buffer',
                FRB = 'Tampon lettrage écr. comptables',
                NLB = 'Grootboekpostvereff.-buffer';
    DrillDownPageID = "General Ledger Entries";
    LookupPageID = "General Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            CaptionML = ENU = 'Entry No.',
                        FRB = 'N° séquence',
                        NLB = 'Volgnummer';
        }
        field(3; "G/L Account No."; Text[20])
        {
            CaptionML = ENU = 'G/L Account No.',
                        FRB = 'N° compte général',
                        NLB = 'Grootboekrekeningnr.';
            TableRelation = "G/L Account";
        }
        field(4; "Posting Date"; Date)
        {
            CaptionML = ENU = 'Posting Date',
                        FRB = 'Date comptabilisation',
                        NLB = 'Boekingsdatum';
            ClosingDates = true;
        }
        field(5; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type',
                        FRB = 'Type document',
                        NLB = 'Documentsoort';
            OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund',
                              FRB = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement',
                              NLB = ' ,Betaling,Factuur,Creditnota,Rentefactuur,Aanmaning,Terugbetaling';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(6; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        FRB = 'N° document',
                        NLB = 'Documentnr.';
        }
        field(7; Description; Text[80])
        {
            CaptionML = ENU = 'Description',
                        FRB = 'Désignation',
                        NLB = 'Omschrijving';
        }
        field(10; "Bal. Account No."; Code[20])
        {
            CaptionML = ENU = 'Bal. Account No.',
                        FRB = 'N° compte contrepartie',
                        NLB = 'Tegenrekeningnr.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            else IF ("Bal. Account Type" = CONST(Customer)) Customer
            else IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            else IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            else IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset";
        }
        field(17; Amount; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Amount',
                        FRB = 'Montant',
                        NLB = 'Bedrag';
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            CaptionML = ENU = 'Global Dimension 1 Code',
                        FRB = 'Code axe principal 1',
                        NLB = 'Code globale dimensie 1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(1));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            CaptionML = ENU = 'Global Dimension 2 Code',
                        FRB = 'Code axe principal 2',
                        NLB = 'Code globale dimensie 2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(2));
        }
        field(27; "User ID"; Code[50])
        {
            CaptionML = ENU = 'User ID',
                        FRB = 'Code utilisateur',
                        NLB = 'Gebruikers-ID';
            //TableRelation = User;  // BC Upgrade NANDIS03
            TableRelation = User."User Name";  // BC Upgrade NANDIS03
            ValidateTableRelation = false; // BC Upgrade NANDIS03
            //This property is currently not supported
            //TestTableRelation = false;


            trigger OnLookup();
            var
                //LoginMgt: Codeunit "User Management";  // BC Upgrade NANDIS03
                UserSelection: Codeunit "User Selection";  // BC Upgrade NANDIS03
            begin
                //LoginMgt.LookupUserID("User ID");  // BC Upgrade NANDIS03
                UserSelection.ValidateUserName("User ID");  // BC Upgrade NANDIS03
            end;
        }
        field(28; "Source Code"; Code[10])
        {
            CaptionML = ENU = 'Source Code',
                        FRB = 'Code journal',
                        NLB = 'Broncode';
            TableRelation = "Source Code";
        }
        field(29; "System-Created Entry"; Boolean)
        {
            CaptionML = ENU = 'System-Created Entry',
                        FRB = 'Ecriture système',
                        NLB = 'Automatisch';
        }
        field(30; "Prior-Year Entry"; Boolean)
        {
            CaptionML = ENU = 'Prior-Year Entry',
                        FRB = 'Ecr. exercice précédent',
                        NLB = 'Naboeking';
        }
        field(41; "Job No."; Code[20])
        {
            CaptionML = ENU = 'Job No.',
                        FRB = 'N° projet',
                        NLB = 'Projectnr.';
            TableRelation = Job;
        }
        field(42; Quantity; Decimal)
        {
            CaptionML = ENU = 'Quantity',
                        FRB = 'Quantité',
                        NLB = 'Aantal';
            DecimalPlaces = 0 : 5;
        }
        field(43; "VAT Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'VAT Amount',
                        FRB = 'Montant TVA',
                        NLB = 'BTW-bedrag';
        }
        field(45; "Business Unit Code"; Code[10])
        {
            CaptionML = ENU = 'Business Unit Code',
                        FRB = 'Code centre de profit',
                        NLB = 'Bedrijfsunit';
            TableRelation = "Business Unit";
        }
        field(46; "Journal Batch Name"; Code[10])
        {
            CaptionML = ENU = 'Journal Batch Name',
                        FRB = 'Nom feuille',
                        NLB = 'Dagboekbatch';
        }
        field(47; "Reason Code"; Code[10])
        {
            CaptionML = ENU = 'Reason Code',
                        FRB = 'Code motif',
                        NLB = 'Redencode';
            TableRelation = "Reason Code";
        }
        field(48; "Gen. Posting Type"; Option)
        {
            CaptionML = ENU = 'Gen. Posting Type',
                        FRB = 'Type compta. TVA',
                        NLB = 'BTW-soort';
            OptionCaptionML = ENU = ' ,Purchase,Sale,Settlement',
                              FRB = ' ,Achat,Vente,Règlement',
                              NLB = ' ,Inkoop,Verkoop,Vereffening';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(49; "Gen. Bus. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group',
                        FRB = 'Groupe compta. marché',
                        NLB = 'Bedrijfsboekingsgroep';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50; "Gen. Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group',
                        FRB = 'Groupe compta. produit',
                        NLB = 'Prod.-boekingsgroep';
            TableRelation = "Gen. Product Posting Group";
        }
        field(51; "Bal. Account Type"; Option)
        {
            CaptionML = ENU = 'Bal. Account Type',
                        FRB = 'Type compte contrepartie',
                        NLB = 'Tegenrekeningsoort';
            OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset',
                              FRB = 'Général,Client,Fournisseur,Banque,Immobilisation',
                              NLB = 'Grootboekrekening,Klant,Leverancier,Bank,Vast activum';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(52; "Transaction No."; Integer)
        {
            CaptionML = ENU = 'Transaction No.',
                        FRB = 'N° transaction',
                        NLB = 'Transactienr.';
        }
        field(53; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CaptionML = ENU = 'Debit Amount',
                        FRB = 'Montant débit',
                        NLB = 'Debetbedrag';
        }
        field(54; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CaptionML = ENU = 'Credit Amount',
                        FRB = 'Montant crédit',
                        NLB = 'Creditbedrag';
        }
        field(55; "Document Date"; Date)
        {
            CaptionML = ENU = 'Document Date',
                        FRB = 'Date document',
                        NLB = 'Documentdatum';
            ClosingDates = true;
        }
        field(56; "External Document No."; Code[35])
        {
            CaptionML = ENU = 'External Document No.',
                        FRB = 'N° doc. externe',
                        NLB = 'Extern documentnr.';
        }
        field(57; "Source Type"; Option)
        {
            CaptionML = ENU = 'Source Type',
                        FRB = 'Type origine',
                        NLB = 'Bronsoort';
            OptionCaptionML = ENU = ' ,Customer,Vendor,Bank Account,Fixed Asset',
                              FRB = ' ,Client,Fournisseur,Banque,Immobilisation',
                              NLB = ' ,Klant,Leverancier,Bank,Vast activum';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(58; "Source No."; Code[20])
        {
            CaptionML = ENU = 'Source No.',
                        FRB = 'N° origine',
                        NLB = 'Bronnr.';
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            else IF ("Source Type" = CONST(Vendor)) Vendor
            else IF ("Source Type" = CONST("Bank Account")) "Bank Account"
            else IF ("Source Type" = CONST("Fixed Asset")) "Fixed Asset";
        }
        field(59; "No. Series"; Code[10])
        {
            CaptionML = ENU = 'No. Series',
                        FRB = 'Souches de n°',
                        NLB = 'Nr.-reeks';
            TableRelation = "No. Series";
        }
        field(60; "Tax Area Code"; Code[20])
        {
            CaptionML = ENU = 'Tax Area Code',
                        FRB = 'Code zone recouvrement',
                        NLB = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(61; "Tax Liable"; Boolean)
        {
            CaptionML = ENU = 'Tax Liable',
                        FRB = 'Soumis à recouvrement',
                        NLB = 'Tax Liable';
        }
        field(62; "Tax Group Code"; Code[10])
        {
            CaptionML = ENU = 'Tax Group Code',
                        FRB = 'Code groupe taxes',
                        NLB = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(63; "Use Tax"; Boolean)
        {
            CaptionML = ENU = 'Use Tax',
                        FRB = 'Use Tax',
                        NLB = 'Use Tax';
        }
        field(64; "VAT Bus. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'VAT Bus. Posting Group',
                        FRB = 'Groupe compta. marché TVA',
                        NLB = 'BTW-bedrijfsboekingsgroep';
            TableRelation = "VAT Business Posting Group";
        }
        field(65; "VAT Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'VAT Prod. Posting Group',
                        FRB = 'Groupe compta. produit TVA',
                        NLB = 'BTW-productboekingsgroep';
            TableRelation = "VAT Product Posting Group";
        }
        field(68; "Additional-Currency Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CaptionML = ENU = 'Additional-Currency Amount',
                        FRB = 'Montant DR',
                        NLB = 'Bedrag (Rapp.-val.)';
        }
        field(69; "Add.-Currency Debit Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CaptionML = ENU = 'Add.-Currency Debit Amount',
                        FRB = 'Montant débit DR',
                        NLB = 'Debetbedrag (Rapp.-val.)';
        }
        field(70; "Add.-Currency Credit Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CaptionML = ENU = 'Add.-Currency Credit Amount',
                        FRB = 'Montant crédit DR',
                        NLB = 'Creditbedrag (Rapp.-val.)';
        }
        field(71; "Close Income Statement Dim. ID"; Integer)
        {
            CaptionML = ENU = 'Close Income Statement Dim. ID',
                        FRB = 'ID axe clôture exercice comptable',
                        NLB = 'Afsluiten WV-rekeningsdim.-ID';
        }
        field(73; Reversed; Boolean)
        {
            CaptionML = ENU = 'Reversed',
                        FRA = 'Contre-passé';
            Description = 'HEI.04';
        }
        field(5400; "Prod. Order No."; Code[20])
        {
            CaptionML = ENU = 'Prod. Order No.',
                        FRB = 'N° ordre de fabrication',
                        NLB = 'Prod.-ordernr.';
        }
        field(5600; "FA Entry Type"; Option)
        {
            CaptionML = ENU = 'FA Entry Type',
                        FRB = 'Type écriture immo.',
                        NLB = 'VA-postsoort';
            OptionCaptionML = ENU = ' ,Fixed Asset,Maintenance',
                              FRB = ' ,Immobilisation,Maintenance',
                              NLB = ' ,Vast activum,Onderhoud';
            OptionMembers = " ","Fixed Asset",Maintenance;
        }
        field(5601; "FA Entry No."; Integer)
        {
            BlankZero = true;
            CaptionML = ENU = 'FA Entry No.',
                        FRB = 'N° séquence immo.',
                        NLB = 'VA-postvolgnr.';
            TableRelation = IF ("FA Entry Type" = CONST("Fixed Asset")) "FA Ledger Entry"
            else IF ("FA Entry Type" = CONST(Maintenance)) "Maintenance Ledger Entry";
        }
        field(10812; Letter; Text[20])
        {
            CaptionML = ENU = 'Letter',
                        FRA = 'Lettre';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
            Editable = false;
        }
        field(10813; "Letter Date"; Date)
        {
            CaptionML = ENU = 'Letter Date',
                        FRA = 'Date de la lettre';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
            Editable = false;
        }
        field(11307; Positive; Boolean)
        {
            CaptionML = ENU = 'Positive',
                        FRB = 'Positif',
                        NLB = 'Positief';
        }
        field(50005; "Journal Template Name"; Code[10])
        {
            CaptionML = ENU = 'Journal Template Name',
                        FRB = 'Nom modèle feuille',
                        NLB = 'Dagboeksjabloon';
            Description = 'RTRGAP038';
            TableRelation = "Gen. Journal Template";
        }
        field(50006; Open; Boolean)
        {
            CaptionML = ENU = 'Open',
                        FRB = 'Ouvert',
                        NLB = 'Openen';
            Description = 'RTRGAP038';
            InitValue = true;
        }
        field(50007; "Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Remaining Amount',
                        FRB = 'Montant ouvert',
                        NLB = 'Restbedrag';
            Description = 'RTRGAP038';
        }
        field(50008; "Closed by Entry No."; Integer)
        {
            CaptionML = ENU = 'Closed by Entry No.',
                        FRB = 'N° séquence lettrage final',
                        NLB = 'Afgesloten door volgnr.';
            Description = 'RTRGAP038';
        }
        field(50009; "Closed at Date"; Date)
        {
            CaptionML = ENU = 'Closed at Date',
                        FRB = 'Date de clôture',
                        NLB = 'Afgesloten op';
            Description = 'RTRGAP038';
        }
        field(50010; "Closed by Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Closed by Amount',
                        FRB = 'Montant lettrage final',
                        NLB = 'Afgesloten met bedrag';
            Description = 'RTRGAP038';
        }
        field(50011; "Applies-to ID"; Code[50])
        {
            CaptionML = ENU = 'Applies-to ID',
                        FRB = 'ID lettrage',
                        NLB = 'Vereffenings-ID';
            Description = 'RTRGAP038';
        }
        field(50018; "Entries Posted By"; Code[50])
        {
            CaptionML = ENU = 'Entries Posted By',
                        FRB = 'Entrées publiées par',
                        NLB = 'Inzendingen Geplaatst door';
            Description = 'CHG2047407 IBM PANDES01';
        }
        field(50019; Comment; Text[250])
        {
            CaptionML = ENU = 'Comment',
                        FRB = 'Commentaires',
                        NLB = 'Comment';
            Description = 'HEI.05,HEI.06';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "G/L Account No.", "Posting Date", "Entry No.", Open)
        {
        }
        key(Key3; "Applies-to ID")
        {
        }
        key(Key4; "Closed by Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        GLSetup: Record "General Ledger Setup";
        //DimMgt: Codeunit DimensionManagement;  // BC Upgrade NANDIS03 - No Use
        GLSetupRead: Boolean;

    procedure GetCurrencyCode(): Code[10];
    begin
        if not GLSetupRead then begin
            GLSetup.GET();
            GLSetupRead := true;
        end;
        exit(GLSetup."Additional Reporting Currency");
    end;
}

