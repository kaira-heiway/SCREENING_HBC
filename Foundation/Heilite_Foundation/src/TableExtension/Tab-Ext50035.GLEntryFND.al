tableextension 50035 GLEntryExtFND extends "G/L Entry"
{
    // FINXL7.00.001 RBE 20/03/2013: Description changed from 30 to 80 chars

    // DITW17.00.02 SR 10/09/2013 DIT-770 #137: Add options 'Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back' to "Document Type"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field 2014319  "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // SFA 17/07/17 added field 50001 and code line on OnInsert

    // HEI.01 FDD RTRGAP062 Heilite BASE IBM ISYED01 04/08/2017 HeiMatch Flatfile
    //   # Added field for Currency Code
    //   # Added field for Remaining Amount
    //   # Added field for Source Currency Amount
    // HEI.02 RTRGAP038 IBM.CHAUHB01 02/08/17 Added field from 50005 to 50011
    // HEI.03 FDD-RTRGAP056 IBM HORTOC01 25.08.2017 - new option on "Document type" field -,Prepayment Invoice,Prepayment CreditMemo,Purchase Receipt
    // HEI.04 FDD-RTRGAP060 IBM HORTOC01 1.09.2017
    //   # New fields
    // HEI.05 Defect#116-BugFix IBM PATHAA02
    // #New field added "Comment"
    // HEI.06 PTPGAP067 IBM ISYED01 08/09/2017 Purchase To Pay downPayment
    //   # Added options Prepayment Invoice,Prepayment Credit Memo to Field Document Type
    // HEI.07 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new option on "Document type" field - "Interest Rate Credit"
    // HEI.08 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //   # New option "RPM Damage or Loss" added on "Document Type" field
    // HEI.09 FDD-KDDOTC007 IBM.NAIKH01 RPM Full-For-Empty Customer.
    //   # New option "FFE Security Payment" added on "Document Type" field
    // HEI.10 Defect #747 IBM NASTAA02 20.12.2017 # HeiMatch Export Inv. & Balance
    //   # Deleted field 50003 - "Remaining Amount."
    // HEI.11 FDD-BA-SLSGAP01 IBM NASTAA02 19.12.2018 # Counterpoint Interface
    //   # New Fields created: 50014 - Interface Code
    //                         50015  - CP Vendor Invoice No.
    // HEI.12 CHG2024918 IBM POENAB02 16.09.2019 La RËÇÜunion_France Fiscal Year Closing
    //   # New fields added
    //     # 10810 Entry Type
    //     # 10812 Letter
    //     # 10813 Letter Date
    //   # New keys:
    //     # "Source Code,Posting Date,Document No."
    //     # "G/L Account No.,Posting Date,Source Code"
    //     # "G/L Account No.,Document No.,Posting Date"
    //     # "G/L Account No.,Source Type,Source No."
    //     # "G/L Account No.,Letter"
    //     # "Entry Type,Global Dimension 2 Code,G/L Account No.,Posting Date"
    //     # "Entry Type,Business Unit Code,G/L Account No.,Posting Date"
    //     # "Posting Date"
    //     # "Document Type,Document No."
    // HEI.13 IBM MATHEJ01 26.09.19 - #CHG2024586 MR Account Field.
    //   # Created new field "MR Code".
    // HEI.14 CHG2034492 Local Display
    //   # Add new field 50017 - "No. 2"
    // HEI.15 CHG2047407 IBM PANDES01 28/04/20
    //  # Added new Field "Entries Posted By".
    // HEI.16 CHG2066589 IBM KUMARN15 01.06.2020
    //   # New key added Document Type,Source Type,Source No. with SumIndexField Amount
    // HEI.17 FDD-CD-HT1350 IBM BULIMC01 16.07.2020
    //   #new field added: 50019 - "Related Sales Order No."
    //   #code added to "CopyFromGenJnlLine" function
    // HEI.18 CHG2090912 HB1641 IBM NANDIS01 01.02.2021 General Ledger Entries Description
    //   # Added a new field 50020 - "Additional Description"
    //   # Code added under function - CopyFromGenJnlLine
    // HEI.19 FDD-HT1330 IBM BULIMC01 08.02.2021
    //   #new field added: 50021-"Maison des Vins Value Code"
    //   #new function created - GetDimCaptionCode
    // HEI.20 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field created: 50022 - Location Code
    // HEI.21 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field created: 50023 - Region Code
    // HEI.22 CHG2163558 IBM BHATTA09 21.07.2022 # New Field created: 50024 - Creation Date
    //   # Code added in OnInsert to put the Creation Date
    // HEI.23 CHG2169924 IBM SISUM01 16/01/2023 #increase the lenght of the Letter field - from 3 to 20
    // HEI.24 FDD-HB2311 CHG2200648 IBM NANDIS01 12-06-2023 #Correct posting flow FA invoicing (credit notes)
    //   # New Option String added - "Purchase Shipment" under field "Document Type"
    // HEI.25 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //   # New Field created #H&S Levy Tax Amount
    // HEI.26 CHG2255472 IBM YADAVM09 06.08.2024 HB3976_Journal Template Name and Batch to be populated on Journal Entry
    //   # Code Added in function CopyFromGenJnlLine
    // version NAVW110.0,DITW110.00.09,HEI.11,HLF160,HEI.26

    //------------------------------------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 24.11.2025 #Commented FR localization and Drink-IT Fields & Keys, Commented fields-Comment, Source Currency Amount as these fields are already defined in BC base table.
    //BC Upgrade KAPOOV01 24.11.2025 #Renamed Keys initial values- Key1 upto Key12, New Values- Key50000 upto Key50007
    //BC Upgrade KAPOOV01 24.11.2025 #For HEI.19-Created new procedure-GetDimCaptionClass, FOR HEI.19-Added new code on Trigger- OnAfterInsert.
    //BC Upgrade KAPOOV01 24.11.2025 #Commented OptionCaptionML Property of Field-Document Type as it is giving warning message that in future release this warning will become error.
    //-------------------------------BC UPgrade SHARMP16 CU 90----------------------------------
    //Created New fields for FA posting cases in Purchase..
    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N“ˆ sËÇÜquence';
        }
        modify("G/L Account No.")
        {
            CaptionML = ENU = 'G/L Account No.', FRA = 'N“ˆ compte gËÇÜnËÇÜral';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage / Loss,FFE Security Payment,Purchase Shipment', FRA = ' ,Paiement,Facture,Avoir,IntËÇÜr›åts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment pr›åt,Rembousement pr›åt,Purchase Receipt,Interest Rate Credit,RPM Damage / Loss,FFE Security Payment,Purchase Shipment';//BC Upgrade KAPOOV01 Commented OptionCaptionML Property of Field-Document Type as it is giving warning message that in future release this warning will become error.

            //Unsupported feature: Change OptionString on ""Document Type"(Field 5)". Please convert manually.


            //Unsupported feature: Change Description on ""Document Type"(Field 5)". Please convert manually.

        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N“ˆ document';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'DËÇÜsignation';
        }
        modify("Bal. Account No.")
        {

            //Unsupported feature: Change TableRelation on ""Bal. Account No."(Field 10)". Please convert manually.

            CaptionML = ENU = 'Bal. Account No.', FRA = 'N“ˆ compte contrepartie';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 23)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 24)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("System-Created Entry")
        {
            CaptionML = ENU = 'System-Created Entry', FRA = '’Écriture syst•áme';
        }
        modify("Prior-Year Entry")
        {
            CaptionML = ENU = 'Prior-Year Entry', FRA = 'Ecr. exercice prËÇÜcËÇÜdent';
        }
        modify("Job No.")
        {
            CaptionML = ENU = 'Job No.', FRA = 'N“ˆ projet';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'QuantitËÇÜ';
        }
        modify("VAT Amount")
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
        }
        modify("Business Unit Code")
        {
            CaptionML = ENU = 'Business Unit Code', FRA = 'Code centre de profit';
        }
        modify("Journal Batch Name")
        {
            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Gen. Posting Type")
        {
            CaptionML = ENU = 'Gen. Posting Type', FRA = 'Type compta. TVA';
            //OptionCaptionML = ENU = ' ,Purchase,Sale,Settlement', FRA = ' ,Achat,Vente,R•áglement';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marchËÇÜ';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("Bal. Account Type")
        {
            CaptionML = ENU = 'Bal. Account Type', FRA = 'Type compte contrepartie';
            //OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner', FRA = 'GËÇÜnËÇÜral,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';
        }
        modify("Transaction No.")
        {
            CaptionML = ENU = 'Transaction No.', FRA = 'N“ˆ transaction';
        }
        modify("Debit Amount")
        {
            CaptionML = ENU = 'Debit Amount', FRA = 'Montant dËÇÜbit';
        }
        modify("Credit Amount")
        {
            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crËÇÜdit';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N“ˆ doc. externe';
        }
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            //OptionCaptionML = ENU = ' ,Customer,Vendor,Bank Account,Fixed Asset', FRA = ' ,Client,Fournisseur,Banque,Immobilisation';
        }
        modify("Source No.")
        {

            //Unsupported feature: Change TableRelation on ""Source No."(Field 58)". Please convert manually.

            CaptionML = ENU = 'Source No.', FRA = 'N“ˆ origine';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n“ˆ';
        }
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis ËÇª recouvrement';
        }
        modify("Tax Group Code")
        {
            CaptionML = ENU = 'Tax Group Code', FRA = 'Code groupe taxes';
        }
        modify("Use Tax")
        {
            CaptionML = ENU = 'Use Tax', FRA = 'Use Tax';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marchËÇÜ TVA';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
        }
        modify("Additional-Currency Amount")
        {
            CaptionML = ENU = 'Additional-Currency Amount', FRA = 'Montant DR';
        }
        modify("Add.-Currency Debit Amount")
        {
            CaptionML = ENU = 'Add.-Currency Debit Amount', FRA = 'Montant dËÇÜbit DR';
        }
        modify("Add.-Currency Credit Amount")
        {
            CaptionML = ENU = 'Add.-Currency Credit Amount', FRA = 'Montant crËÇÜdit DR';
        }
        modify("Close Income Statement Dim. ID")
        {
            CaptionML = ENU = 'Close Income Statement Dim. ID', FRA = 'ID axe clËÇ£ture exercice comptable';
        }
        modify("IC Partner Code")
        {
            CaptionML = ENU = 'IC Partner Code', FRA = 'Code du partenaire IC';
        }
        modify(Reversed)
        {
            CaptionML = ENU = 'Reversed', FRA = 'Contre-passËÇÜ';
        }
        modify("Reversed by Entry No.")
        {
            CaptionML = ENU = 'Reversed by Entry No.', FRA = 'Contre-passËÇÜ par n“ˆ ËÇÜcriture';
        }
        modify("Reversed Entry No.")
        {
            CaptionML = ENU = 'Reversed Entry No.', FRA = 'N“ˆ ËÇÜcriture contre-passËÇÜe';
        }
        modify("G/L Account Name")
        {

            //Unsupported feature: Change CalcFormula on ""G/L Account Name"(Field 76)". Please convert manually.

            CaptionML = ENU = 'G/L Account Name', FRA = 'Nom compte gËÇÜnËÇÜral';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Prod. Order No.")
        {
            CaptionML = ENU = 'Prod. Order No.', FRA = 'N“ˆ ordre de fabrication';
        }
        modify("FA Entry Type")
        {
            CaptionML = ENU = 'FA Entry Type', FRA = 'Type ËÇÜcriture immo.';
            OptionCaptionML = ENU = ' ,Fixed Asset,Maintenance', FRA = ' ,Immobilisation,Maintenance';
        }
        modify("FA Entry No.")
        {

            //Unsupported feature: Change TableRelation on ""FA Entry No."(Field 5601)". Please convert manually.

            CaptionML = ENU = 'FA Entry No.', FRA = 'N“ˆ sËÇÜquence immo.';
        }
        //BC Upgrade KAPOOV01 FR localization>>
        // field(10810; "Entry Type"; Option)
        // {
        //     CaptionML = ENU = 'Entry Type',
        //                 FRA = 'Type ËÇÜcriture';
        //     Description = 'HEI.12';
        //     OptionCaptionML = ENU = 'Definitive,Simulation',
        //                       FRA = 'DËÇÜfinitive,Simulation';
        //     OptionMembers = Definitive,Simulation;
        // }
        // field(10812; Letter; Text[20])
        // {
        //     CaptionML = ENU = 'Letter',
        //                 FRA = 'Lettre';
        //     Description = 'HEI.12,HEI23';
        //     Editable = false;
        // }
        // field(10813; "Letter Date"; Date)
        // {
        //     CaptionML = ENU = 'Letter Date',
        //                 FRA = 'Date de la lettre';
        //     Description = 'HEI.12';
        //     Editable = false;
        // }
        //BC Upgrade KAPOOV01 FR localization<<
        field(50000; "CV Detailed Entry No. FND"; Integer)
        {
            Description = 'HEI.01';
            Caption = 'CV Detailed Entry No.';
        }
        field(50001; "Adj. Exchange Rate Type FND"; Option)
        {
            Description = 'HEI.01';
            Caption = 'Adj. Exchange Rate Type';
            OptionMembers = " ",Bank,Customer,Vendor;
        }
        field(50002; "Currency Code FND"; Code[10])
        {
            CaptionML = ENU = 'Currency Code',
                        FRA = 'Code devise';
            Description = 'HEI.01 RTRGAP062';
            TableRelation = Currency;
        }
        //BC Upgrade KAPOOV01 field-Source Currency Amount already in Base.>>
        // field(50004; "Source Currency Amount"; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     BlankZero = true;
        //     CaptionML = ENU = 'Source Currency Amount',
        //                 FRA = 'Montant devise origine';
        //     Description = 'HEI.01 RTRGAP062';
        // }//BC Upgrade KAPOOV01 field-Source Currency Amount already in Base.<<

        modify("Source Currency Amount")
        {
            //AutoFormatExpression = "Currency Code";//BC Upgrade KAPOOV01 The property 'AutoFormatExpression' cannot be customized.
            //AutoFormatType = 1;//BC Upgrade KAPOOV01 The property 'AutoFormatType' cannot be customized.
            CaptionML = ENU = 'Source Currency Amount', FRA = 'Montant devise origine';
            Description = 'HEI.01 RTRGAP062';

        }
        field(50005; "Journal Template Name FND"; Code[10])
        {
            CaptionML = ENU = 'Journal Template Name',
                        FRB = 'Nom mod•ále feuille',
                        NLB = 'Dagboeksjabloon';
            Description = 'RTRGAP038';
            TableRelation = "Gen. Journal Template";
        }
        field(50006; "Open FND"; Boolean)
        {
            CaptionML = ENU = 'Open',
                        FRB = 'Ouvert',
                        NLB = 'Openen';
            Description = 'RTRGAP038';
            InitValue = true;
        }
        field(50007; "Remaining Amount FND"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Remaining Amount',
                        FRB = 'Montant ouvert',
                        NLB = 'Restbedrag';
            Description = 'RTRGAP038';
        }
        field(50008; "Closed by Entry No. FND"; Integer)
        {
            CaptionML = ENU = 'Closed by Entry No.',
                        FRB = 'N“ˆ sËÇÜquence lettrage final',
                        NLB = 'Afgesloten door volgnr.';
            Description = 'RTRGAP038';
        }
        field(50009; "Closed at Date FND"; Date)
        {
            CaptionML = ENU = 'Closed at Date',
                        FRB = 'Date de clËÇ£ture',
                        NLB = 'Afgesloten op';
            Description = 'RTRGAP038';
        }
        field(50010; "Closed by Amount FND"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Closed by Amount',
                        FRB = 'Montant lettrage final',
                        NLB = 'Afgesloten met bedrag';
            Description = 'RTRGAP038';
        }
        // field(50011; "Applies-to ID"; Code[50]) // BC FR Upgrade KAIRAR01
        // {
        //     CaptionML = ENU = 'Applies-to ID',
        //                 FRB = 'ID lettrage',
        //                 NLB = 'Vereffenings-ID';
        //     Description = 'RTRGAP038';
        // }
        field(50012; "Forecast Line FND"; Boolean)
        {
            Description = 'HEI.04';
            Caption = 'Forecast Line';
        }
        //BC Upgrade KAPOOV01 field-Comment already in Base.>>
        // field(50013; Comment; Text[250])
        // {
        //     Description = 'HEI.05';
        // }//BC Upgrade KAPOOV01 field-Comment already in Base.<<
        field(50014; "Interface Code FND"; Code[20])
        {
            Caption = 'Interface Code';
            Description = 'HEI.11';
            //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension 
        }
        field(50015; "CP Vendor Invoice No. FND"; Code[20])
        {
            Description = 'HEI.11';
            Caption = 'CP Vendor Invoice No.';
        }
        field(50016; "MR Code FND"; Code[10])
        {
            Caption = 'MR Code';
            Description = 'HEI.13';
        }
        field(50017; "No. 2 FND"; Code[20])
        {
            CaptionML = ENU = 'No. 2',
                        ESM = 'No. 2',
                        ENC = 'No. 2';
            Description = 'HEI.14';
        }
        field(50018; "Entries Posted By FND"; Code[50])
        {
            CaptionML = ENU = 'Entries Posted By',
                        FRB = 'EntrËÇÜes publiËÇÜes par',
                        NLB = 'Inzendingen Geplaatst door';
            Description = 'CHG2047407 IBM PANDES01';
        }
        field(50019; "Related Sales Order No. FND"; Code[20])
        {
            Description = 'HEI.17';
            Caption = 'Related Sales Order No.';
        }
        field(50020; "Additional Description FND"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.18';
            Caption = 'Additional Description';
        }
        field(50021; "Maison des Vins Value Code FND"; Code[20])
        {
            CaptionClass = GetDimCaptionClass();
            Caption = 'Maison des Vins Value Code';
            Description = 'HEI.19';
        }
        field(50022; "Location Code FND"; Code[10])
        {
            CaptionML = ENU = 'Location Code',
                        FRA = 'Code magasin';
            DataClassification = ToBeClassified;
            Description = 'HEI.20';
            TableRelation = Location where("Use As In-Transit" = CONST(false));
        }
        field(50023; "Region Code FND"; Code[20])
        {
            Caption = 'Region Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.21';
            TableRelation = Location;
        }
        field(50024; "Creation Date FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.22';
            Caption = 'Creation Date';
        }
        field(50081; "H&S Levy Tax Amount FND"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.25';
            Caption = 'H&S Levy Tax Amount';
        }
        //BC UPgrade SHARMP16 CU 90
        field(55005; "FA Receipt Line No. FND"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'FA Receipt Line No.';
        }
        //BC UPgrade SHARMP16 CU 90
        // BC Upgrade KAIRAR01 >> Moved custom fields from NonFR Ext -> FoundationExt
        field(50100; "Applies-to ID FND"; Code[50])
        {
            CaptionML = ENU = 'Applies-to ID',
                        FRB = 'ID lettrage',
                        NLB = 'Vereffenings-ID';
            Description = 'RTRGAP038';
        }
        field(50101; LetterFND; Text[20])
        {
            CaptionML = ENU = 'Letter';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50102; "Letter Date FND"; Date)
        {
            CaptionML = ENU = 'Letter Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        // BC Upgrade KAIRAR01 <<
        //BC Upgrade KAPOOV01 Drink-IT>>
        // field(2014310; "Service Contract Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Contract Line No.',
        //                 FRA = 'N“ˆ ligne contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        // }
        // field(2014313; "Financial Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Financial Contract No.',
        //                 FRA = 'N“ˆ Contrat Financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                       "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
        // }
        // field(2034850; "DIT Sub-Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Sub Contract Type',
        //                 FRA = 'Sous type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA = ' ,Location,Pr›åt,Pr›åt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034872; "Contract Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Contract Group Code',
        //                 FRA = 'Code groupe contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        // TableRelation = IF ("Contract Type" = CONST(Service),
        //                     "DIT Sub-Contract Type" = FILTER(<> " ")) "Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
        // else IF ("Contract Type" = CONST(Service),
        //                              "DIT Sub-Contract Type" = CONST(" ")) "Contract Group".Code
        // else IF ("Contract Type" = CONST(Financial)) "Financial Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
        // else IF ("Contract Type" = CONST(Financial),
        //                                       "DIT Sub-Contract Type" = CONST(" ")) "Financial Contract Group".Code;
        // }
        // field(2034915; "Service Contract No."; Code[20])
        // {
        //     CaptionML = ENU = 'Service Contract No.',
        //                 FRA = 'N“ˆ contrat de service';
        //     Description = 'DITW16.00.00.41 DIT-715 #327-DITW18.00.06 MSF 31/07/2015 DIT-770 #1368';
        // TableRelation = "Service Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                 "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type")); 
        // }
        // field(2035393; "Contract Type"; Option)
        // {
        //     CaptionML = ENU = 'Contract Type',
        //                 FRA = 'Type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #327 -DITW18.00.06 MSF 31/07/2015 DIT-770 #1368';
        //     OptionCaptionML = ENU = ' ,Service,Financial',
        //                       FRA = ' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;
        // }
        //BC Upgrade KAPOOV01 Drink-IT
    }
    keys
    {
        // key(Key1; "G/L Account No.", "Service Contract No.", "Dimension Set ID", "DIT Sub-Contract Type", "Posting Date")
        // {
        //     SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        // }BC Upgrade KAPOOV01-drink-it Key having Drinkit fields.

        //BC Upgrade KAPOOV01 changed key number as in base key1 to key12 already defined.>>
        key(Key50000; "CV Detailed Entry No. FND")
        {
        }

        key(Key50001; "Source Code", "Posting Date", "Document No.")
        {
        }
        key(Key50002; "G/L Account No.", "Posting Date", "Source Code")
        {
        }
        key(Key50003; "G/L Account No.", "Document No.", "Posting Date")
        {
        }
        key(Key50004; "G/L Account No.", "Source Type", "Source No.")
        {
        }
        //BC Upgrade KAPOOV01-French Localization>>
        // key(Key7; "G/L Account No.", Letter)
        // {
        // }BC Upgrade KAPOOV01-French Localization
        // key(Key8; "Entry Type", "Global Dimension 2 Code", "G/L Account No.", "Posting Date")
        // {
        // }
        // key(Key9; "Entry Type", "Business Unit Code", "G/L Account No.", "Posting Date")
        // {
        // }
        //BC Upgrade KAPOOV01-French Localization<<
        key(Key50005; "Posting Date")
        {
        }
        key(Key50006; "Document Type", "Document No.")
        {
        }
        key(Key50007; "Document Type", "Source Type", "Source No.")
        {
            SumIndexFields = Amount;
        }
        //BC Upgrade KAPOOV01 changed key number as in base key1 to key12 already defined.>>
        key(Key50008; LetterFND)
        {
        }
    }


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //begin
    /*
    //HEI.22>>
    Rec."Creation Date" := TODAY;
    //HEI.22<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    procedure GetDimCaptionClass(): Text[250]
    var
        GLSetup: Record "General Ledger Setup";
    begin
        //HEI.19<<
        GLSetup.GET();
        IF GLSetup."Maison des Vins Dim. Code FND" <> '' THEN
            EXIT(GLSetup."Maison des Vins Dim. Code FND")
        else
            EXIT(Text001);
        //HEI.19>>

    end;
    //BC Upgrade KAPOOV01>>
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        //HEI.22>>
        Rec."Creation Date FND" := TODAY;
        //HEI.22<<
    end;
    //BC Upgrade KAPOOV01<<
    var
        Text001: Label 'Maision des Vins Value Code';
}

