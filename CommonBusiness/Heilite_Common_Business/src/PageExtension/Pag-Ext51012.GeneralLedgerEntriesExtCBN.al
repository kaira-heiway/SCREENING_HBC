pageextension 51012 GeneralLedgerEntriesExtCBN extends "General Ledger Entries"
{
    //HEI.01 RTRGAP038 IBM.CHAUHB01 05/08/17 Added Button Added for Apply Entries
    // HEI.02 Defect116(NavBugFix)- IBM PATHAA02 19.09.17 Added comment field
    // HEI.03 Defect1027-PATHAA02 Aligned-"Currency code" & "Source Currency Amount"
    // HEI.04 Defect #747 IBM NASTAA02 20.12.2017 # HeiMatch Export Inv. & Balance
    //   # Added field "Remaining Amount"
    // HEI.05 FDD-BA-SLSGAP01 IBM NASTAA02 01.02.2018 # Counterpoint Interface
    //   # New Field added "CP Vendor Invoice No."
    // HEI.06 INC2063759 IBM HORTOC01 - #editable false for Quantity/Open/close by date/close by amount fields
    // HEI.07 Bugfixing Bahamas IBM NASTAA02 17.04.2019 # MVMT Type Dimension
    //   # Added new column MVMT Type Dimension
    // HEI.08 IBM MATHEJ01 26.09.19 - #CHG2024586 MR Account Field.
    //   # Added new field "MR Code".
    // HEI.09 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in Actions -> ReverseTransaction
    // HEI.09 CHG2034492 Display Local
    //   # Added new field "No. 2"
    // HEI.10 CHG2047407 IBM PANDES01 28/04/20
    //  # Added new Field "Entries Posted By".
    // HEI.11 FDD-CD-HT1350 IBM BULIMC01 16.07.2020 #new field added: "Related Sales Order No."
    // HEI.12 CHG2070961/CHG2088483 IBM POENAB02 31.07.2020 Panama -  Suspense account issue related to BI
    //  # Code added in Actions -> ReverseTransaction
    //  # Sed Editable = FALSE for field "Entries Posted By"
    // HEI.13 FDD-HB1834 IBM SURYAS01 24-11-2020
    //  # Added "Document Date" field
    // HEI.14 CHG2090912 HB1641 IBM NANDIS01 01.02.2021 General Ledger Entries Description
    //   # Make visible of new field - "Additional Description"
    // HEI.15 CHG2094186 IBM BULIMC01 03.02.2020 #new page action created: "Applied Entries"
    // HEI.16 FDD-HT1330 IBM BULIMC01 08.02.2021#new dimension added for Haiti - "Maision de Vins Value Code"
    // HEI.17 CHG2012109 IBM BULIMC01 16.02.2021#new field added to the page - "Business Unit Code"
    // HEI.18 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field added: "Location Code"
    // HEI.19 CHG2119825 IBM BULIMC01 27/07/2021 #remove the restriction added by HEI.12 from the action "ReverseTransaction"(replaced in Page 179)
    // HEI.20 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "Region Code"
    // HEI.21 CHG2163558 IBM BHATTA09 21.07.2022 # New Field added: "Creation Date"
    // HEI.22 CHG2163558 IBM BHATTA09 12.08.2022 # Creation Date field Properties changed to make it non-visible and non-editable
    // HEI.23 CHG2169924 IBM SISUM01  13/01/2023 #Add field Letter and Letter Date
    // HEI.24 CHG2236692 IBM SISUM01 29.02.2024 HB3717_Development to perform revaluation for AR/AP
    //   #add to Page Action, G/L Entry Additional
    // HEI.25 CHG2236692 IBM POENAB02 13.05.2024 HB3717_Change in the process of performing revaluation for AR/AP
    //   # Added fields "Customer/Vendor No.", 'Exchange Document No."
    //   # Modified OnAfterGetRecord
    // HEI.26 CHG2255472 IBM YADAVM09 06.08.2024 HB3976_Journal Template Name and Batch to be populated on Journal Entry
    //   # Added fields "Journal Template Name", "Journal Batch Name"
    // version NAVW110.0.00.14199,FINXL9.00.000.01,DITW110.00.08,HEI.26
    //BC Upgrade ATHUKS01>>
    //1. Added property for Promoted = true; & PromotedCategory = Process for Apply entries Action.
    //BC Upgrade ATHUKS01<< 


    layout
    {
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date for the entry.', FRA = 'Spécifie la date comptabilisation de l''écriture.';

            //Unsupported feature: Change Editable on ""Posting Date"(Control 2)". Please convert manually.

        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the Document Type that the entry belongs to.', FRA = 'Spécifie le type de document auquel appartient l''écriture.';

            //Unsupported feature: Change Editable on ""Document Type"(Control 4)". Please convert manually.

        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the entry''s Document No.', FRA = 'Spécifie le numéro de document de l''écriture.';

            //Unsupported feature: Change Editable on ""Document No."(Control 6)". Please convert manually.

        }
        modify("G/L Account No.")
        {
            ToolTipML = ENU = 'Specifies the number of the account that the entry has been posted to.', FRA = 'Spécifie le numéro du compte sur lequel l''écriture a été validée.';

            //Unsupported feature: Change Editable on ""G/L Account No."(Control 8)". Please convert manually.

        }
        modify("G/L Account Name")
        {
            ToolTipML = ENU = 'Specifies the name of the account that the entry has been posted to.', FRA = 'Spécifie le nom du compte sur lequel l''écriture a été validée.';

            //Unsupported feature: Change Editable on ""G/L Account Name"(Control 40)". Please convert manually.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry.', FRA = 'Spécifie une description de l''écriture.';

            //Unsupported feature: Change Editable on "Description(Control 10)". Please convert manually.

        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the Job No. corresponding the to G/L entry.', FRA = 'Spécifie le numéro de projet correspondant à l''écriture comptable.';
        }
        modify("Global Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code that the entry is linked to.', FRA = 'Spécifie le code section analytique lié à l''écriture.';

            //Unsupported feature: Change Editable on ""Global Dimension 1 Code"(Control 28)". Please convert manually.

        }
        modify("Global Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code that the entry is linked to.', FRA = 'Spécifie le code section analytique lié à l''écriture.';

            //Unsupported feature: Change Editable on ""Global Dimension 2 Code"(Control 30)". Please convert manually.

        }
        modify("IC Partner Code")
        {
            ToolTipML = ENU = 'Specifies the code of the intercompany partner that the transaction is with if the entry was posted from an intercompany transaction.', FRA = 'Spécifie le code du partenaire intersociété concerné si l''écriture est validée à partir d''une transaction intersociété.';

            //Unsupported feature: Change Editable on ""IC Partner Code"(Control 51)". Please convert manually.

        }
        modify("Gen. Posting Type")
        {
            ToolTipML = ENU = 'Specifies the Gen. Posting Type that applies to the entry.', FRA = 'Spécifie le Type compta. TVA qui s''applique à l''écriture.';

            //Unsupported feature: Change Editable on ""Gen. Posting Type"(Control 12)". Please convert manually.

        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general business posting group that applies to the entry.', FRA = 'Spécifie le groupe comptabilisation marché qui s''applique à cette écriture.';

            //Unsupported feature: Change Editable on ""Gen. Bus. Posting Group"(Control 32)". Please convert manually.

        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general product posting group that applies to the entry.', FRA = 'Spécifie le groupe comptabilisation produit qui s''applique à cette écriture.';

            //Unsupported feature: Change Editable on ""Gen. Prod. Posting Group"(Control 14)". Please convert manually.

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity that was posted on the entry.', FRA = 'Spécifie la quantité qui a été validée sur l''écriture.';

            //Unsupported feature: Change Editable on "Quantity(Control 5)". Please convert manually.

        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the Amount of the entry.', FRA = 'Spécifie le montant de l''écriture.';

            //Unsupported feature: Change Editable on "Amount(Control 16)". Please convert manually.

        }
        modify("Additional-Currency Amount")
        {
            ToolTipML = ENU = 'Specifies the general ledger entry that is posted if you post in an additional reporting currency.', FRA = 'Spécifie l''écriture comptable qui est validée si vous validez dans une devise report.';

            //Unsupported feature: Change Editable on ""Additional-Currency Amount"(Control 54)". Please convert manually.

        }
        modify("VAT Amount")
        {
            ToolTipML = ENU = 'Specifies the VAT Amount that was posted as a result of the entry.', FRA = 'Spécifie le montant TVA qui a été validé en tant que résultat de l''écriture.';

            //Unsupported feature: Change Editable on ""VAT Amount"(Control 36)". Please convert manually.

        }
        modify("Bal. Account Type")
        {
            ToolTipML = ENU = 'Specifies the type of balancing account used in the entry: G/L Account, Bank Account, Vendor, Customer, or Fixed Asset.', FRA = 'Spécifie le type du compte de contrepartie utilisé pour l''écriture : compte général, compte bancaire, fournisseur, client ou immobilisation.';

            //Unsupported feature: Change Editable on ""Bal. Account Type"(Control 52)". Please convert manually.

        }
        modify("Bal. Account No.")
        {
            ToolTipML = ENU = 'Specifies the number of the G/L account or the bank account, that a balancing entry has been posted to.', FRA = 'Spécifie le numéro du compte général ou du compte bancaire sur lequel une écriture contrepartie a été validée.';

            //Unsupported feature: Change Editable on ""Bal. Account No."(Control 18)". Please convert manually.

        }
        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user that is associated with the entry.', FRA = 'Spécifie le code de l''utilisateur associé à l''écriture.';

            //Unsupported feature: Change Editable on ""User ID"(Control 46)". Please convert manually.

        }
        modify("Source Code")
        {
            ToolTipML = ENU = 'Specifies the Source Code that is linked to the entry.', FRA = 'Spécifie le code source lié à l''écriture.';

            //Unsupported feature: Change Editable on ""Source Code"(Control 42)". Please convert manually.

        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code on the entry.', FRA = 'Spécifie le code motif de l''écriture.';

            //Unsupported feature: Change Editable on ""Reason Code"(Control 44)". Please convert manually.

        }
        modify(Reversed)
        {
            ToolTipML = ENU = 'Specifies if the entry has been part of a reverse transaction (correction) made by the Reverse function.', FRA = 'Spécifie si l''écriture a fait partie d''une transaction contre-passée (correction) effectuée par la fonction Inverser.';

            //Unsupported feature: Change Editable on "Reversed(Control 58)". Please convert manually.

        }
        modify("Reversed by Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the correcting entry. If the field Specifies a number, the entry cannot be reversed again.', FRA = 'Spécifie le numéro de l''écriture de correction. Si le champ contient un numéro, l''écriture ne peut pas être contrepassée à nouveau.';

            //Unsupported feature: Change Editable on ""Reversed by Entry No."(Control 60)". Please convert manually.

        }
        modify("Reversed Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the original entry that was undone by the reverse transaction.', FRA = 'Spécifie le numéro de l''écriture initiale annulée par la transaction contre-passée.';

            //Unsupported feature: Change Editable on ""Reversed Entry No."(Control 62)". Please convert manually.

        }
        modify("FA Entry Type")
        {
            ToolTipML = ENU = 'This field is automatically updated.', FRA = 'Le champ est mis à jour automatiquement.';

            //Unsupported feature: Change Editable on ""FA Entry Type"(Control 34)". Please convert manually.

        }
        modify("FA Entry No.")
        {
            ToolTipML = ENU = 'This field is automatically updated.', FRA = 'Le champ est mis à jour automatiquement.';

            //Unsupported feature: Change Editable on ""FA Entry No."(Control 38)". Please convert manually.

        }
        modify("Entry No.")
        {
            ToolTipML = ENU = 'Specifies the Entry No. that the program has given the entry.', FRA = 'Spécifie le numéro de séquence affecté à l''écriture comptable par le programme.';

            //Unsupported feature: Change Editable on ""Entry No."(Control 20)". Please convert manually.

        }
        addafter("G/L Account No.")
        {
            field("No. 2"; Rec."No. 2 FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. 2 field.';
            }
            field("Closed by Entry No."; Rec."Closed by Entry No. FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Closed by Entry No. field.';
            }
            field("Closed at Date"; Rec."Closed at Date FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Closed at Date field.';
            }
            //BC Upgrade KAPOOV01- >>French Localization fields 
            // field(Letter; Rec.Letter)
            // {
            // }
            // field("Letter Date"; Rec."Letter Date")
            // {
            // }
            //BC Upgrade KAPOOV01- <<French Localization fields 
            // BC FR Upgrade KAIRAR01 Handled in General_NonFR>>
            field(Letter; Rec.LetterFND)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Letter field.';
            }
            field("Letter Date"; Rec."Letter Date FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Letter Date field.';
            }
            // BC FR Upgrade KAIRAR01 Handled in General_NonFR>>
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document Date field.';
            }
            field(Open; Rec."Open FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Open field.';
            }
        }
        addafter(Description)
        {
            field("Additional Description"; Rec."Additional Description FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Additional Description field.';
            }
            // field("Source Type";"Source Type")
            // {
            //     Description = 'FINXL7.00.001';
            //     Editable = false;
            // }
            // field("Source No.";"Source No.")
            // {
            //     Description = 'FINXL7.00.001';
            //     Editable = false;
            // }//BC Upgrade KAPOOV01 Fields already in Base page.
            field("Transaction No."; Rec."Transaction No.")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transaction No. field.';
            }
            field("<Source Description>"; txtSourceDescription)
            {
                CaptionML = ENU = 'Source Description',
                            FRA = 'Description source';
                Description = 'FINXL7.00.001';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the txtSourceDescription field.';
            }
        }
        addafter("Job No.")
        {
            field("MR Code"; Rec."MR Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MR Code field.';
            }
        }
        addafter(Amount)
        {
            // field("Debit Amount"; "Debit Amount")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Credit Amount"; "Credit Amount")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//BC Upgrade KAPOOV01 Fields already in Base page.
            field("Related Sales Order No."; Rec."Related Sales Order No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Related Sales Order No. field.';
            }
        }
        addafter("FA Entry No.")
        {
            // field("Contract Type"; "Contract Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Service Contract No."; "Service Contract No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Financial Contract No."; "Financial Contract No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Contract Group Code"; "Contract Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }BC Upgrade KAPOOV01-drink-it
        }
        //#BCUP0-55 -BC Upgrade KAIRAR01_>>_Source extension: "Record To Report" Fix: Blank column headers for R2R Add Reporting Dim 1/2 fields on General Ledger Entries 
        modify("R2R Add Reporting Dim 1 NIQ")
        {
            Visible = false;
            Enabled = false;
        }
        modify("R2R Add Reporting Dim 2 NIQ")
        {
            Visible = false;
            Enabled = false;
        }
        //#BCUP0-55 -BC Upgrade KAIRAR01_<<
        addafter("Entry No.")
        {
            field(Comment; Rec.Comment)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Comment field.';
            }
            field("Currency Code"; Rec."Currency Code FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Currency Code field.';
            }
            // field("Source Currency Amount"; "Source Currency Amount")
            // {
            //     Editable = false;
            // }BC Upgrade KAPOOV01 field already in Base Page
            field("Remaining Amount"; Rec."Remaining Amount FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remaining Amount field.';
            }
            // field("External Document No."; "External Document No.")
            // {
            //     Editable = false;
            // }BC Upgrade KAPOOV01 field already in Base Page
            field("CP Vendor Invoice No."; Rec."CP Vendor Invoice No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CP Vendor Invoice No. field.';
            }
            // field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
            // {
            //     Editable = false;
            //     Visible = false;
            // }BC Upgrade KAPOOV01 field already in Base Page
            // field("Movement Type"; MovementType)
            // {
            //     Caption = 'Movement Type';
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Movement Type field.';
            // }//Bc Upgrade YADAVM09 as shortcut Dimension field already avaliable in page<<
            field("Maison des Vins Value Code"; Rec."Maison des Vins Value Code FND")
            {
                Visible = SetMaisionDesVinsDimVisible;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Maison des Vins Value Code field.';
            }
            field("Entries Posted By"; Rec."Entries Posted By FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Entries Posted By field.';
            }
            // field("Business Unit Code"; "Business Unit Code")
            // {
            // }BC Upgrade KAPOOV01 field already in Base Page
            field("Location Code"; Rec."Location Code FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Location Code field.';
            }
            field("Region Code"; Rec."Region Code FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Region Code field.';
            }
            field("Creation Date"; Rec."Creation Date FND")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Creation Date field.';
            }
            field("CV Detailed Entry No."; Rec."CV Detailed Entry No. FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CV Detailed Entry No. field.';
            }
            field("Adj. Exchange Rate Type"; Rec."Adj. Exchange Rate Type FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Adj. Exchange Rate Type field.';
            }
            field(CustVendNo; CustVendNo)
            {
                Caption = 'Customer/Vendor No.';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer/Vendor No. field.';
            }
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Journal Batch Name field.';
            }
            field("Journal Template Name"; Rec."Journal Template Name FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Journal Template Name field.';
            }
            field(DocNo2; DocNo2)
            {
                Caption = 'Exchange Document No.';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exchange Document No. field.';
            }
        }
    }
    actions
    {
        modify("Ent&ry")
        {
            CaptionML = ENU = 'Ent&ry', FRA = 'É&criture';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(GLDimensionOverview)
        {
            CaptionML = ENU = 'G/L Dimension Overview', FRA = 'Aperçu comptabilité par axe';
            ToolTipML = ENU = 'View an overview of general ledger entries and dimensions.', FRA = 'Affichez un aperçu des axes et écritures comptables.';
        }
        modify("Value Entries")
        {
            CaptionML = ENU = 'Value Entries', FRA = 'Écritures valeur';
            ToolTipML = ENU = 'View all amounts relating to an item.', FRA = 'Affichez tous les montants associés à un article.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        //BC Upgrade KAPOOV01>>French Localization fields 
        // modify(ReverseTransaction)
        // {
        // CaptionML = ENU = 'Reverse Transaction', FRA = 'Transaction contre-passée';
        // ToolTipML = ENU = 'Reverse a posted general ledger entry.', FRA = 'Contrepassez une écriture comptable validée.';

        // trigger OnAfterAction()
        // var
        //     myInt: Integer;
        // begin

        //     //HEI.19 commented begin>>
        //     //HEI.12>>
        //     // IF NOT ((Open = TRUE) AND ("Remaining Amount" = Amount)) THEN
        //     //   ERROR(Text50000,"Entry No.");
        //     //HEI.12<<
        //     //HEI.19 commented end<<
        //     //HEI.09>>
        //     CompanyInfo.GET;
        //     IF CompanyInfo."Enable French Localization" THEN
        //         IF Rec."Entry Type" = Rec."Entry Type"::Simulation THEN
        //             Rec.FIELDERROR("Entry Type");
        //     //HEI.09<<

        //end;

        //}

        //BC Upgrade KAPOOV01 <<French Localization fields 
        modify(IncomingDocument)
        {
            CaptionML = ENU = 'Incoming Document', FRA = 'Document entrant';
        }
        modify(IncomingDocCard)
        {
            CaptionML = ENU = 'View Incoming Document', FRA = 'Afficher le document entrant';
            ToolTipML = ENU = 'View any incoming document records and file attachments that exist for the entry or document.', FRA = 'Affichez tout enregistrement et fichier joint de document entrant qui existe pour l''écriture ou le document.';
        }
        modify(SelectIncomingDoc)
        {
            CaptionML = ENU = 'Select Incoming Document', FRA = 'Sélectionner le document entrant';
            ToolTipML = ENU = 'Select an incoming document record and file attachment that you want to link to the entry or document.', FRA = 'Sélectionnez un fichier joint ou un enregistrement de document entrant que vous voulez associer à l''écriture ou au document.';
        }
        modify(IncomingDocAttachFile)
        {
            CaptionML = ENU = 'Create Incoming Document from File', FRA = 'Créer un document entrant à partir d''un fichier';
            ToolTipML = ENU = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.', FRA = 'Créez un enregistrement de document entrant en sélectionnant un fichier à joindre, puis associez l''enregistrement de document entrant à l''écriture ou au document.';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';
        }
        modify(DocsWithoutIC)
        {
            CaptionML = ENU = 'Posted Documents without Incoming Document', FRA = 'Documents validés sans document entrant';
            ToolTipML = ENU = 'View posted purchase and sales documents under the G/L account that do not have related incoming document records.', FRA = 'Affichez les documents ventes et achats validés sous le compte général qui n''a pas d''enregistrement de document entrant associé.';
        }


        //Unsupported feature: CodeModification on "GLDimensionOverview(Action 50).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ISTEMPORARY THEN BEGIN
          GLEntriesDimensionOverview.SetTempGLEntry(Rec);
          GLEntriesDimensionOverview.RUN;
        end else
          PAGE.RUN(PAGE::"G/L Entries Dimension Overview",Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ISTEMPORARY then begin
          GLEntriesDimensionOverview.SetTempGLEntry(Rec);
          GLEntriesDimensionOverview.RUN;
        end else
          PAGE.RUN(PAGE::"G/L Entries Dimension Overview",Rec);
        */
        //end;


        //Unsupported feature: CodeModification on "ReverseTransaction(Action 63).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CLEAR(ReversalEntry);
        IF Reversed THEN
          ReversalEntry.AlreadyReversedEntry(TABLECAPTION,"Entry No.");
        IF "Journal Batch Name" = '' THEN
          ReversalEntry.TestFieldError;
        TESTFIELD("Transaction No.");
        ReversalEntry.ReverseTransaction("Transaction No.")
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CLEAR(ReversalEntry);
        if Reversed then
          ReversalEntry.AlreadyReversedEntry(TABLECAPTION,"Entry No.");

        //HEI.19 commented begin>>
        //HEI.12>>
        {IF NOT ((Open = TRUE) AND ("Remaining Amount" = Amount)) THEN
          ERROR(Text50000,"Entry No."); }
        //HEI.12<<
        //HEI.19 commented end<<

        if "Journal Batch Name" = '' then
          ReversalEntry.TestFieldError;
        //HEI.09>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          if "Entry Type" = "Entry Type"::Simulation then
            FIELDERROR("Entry Type");
        //HEI.09<<
        TESTFIELD("Transaction No.");
        ReversalEntry.ReverseTransaction("Transaction No.")
        */
        //end;
        addafter("Value Entries")
        {
            action("Applied Entries CBN")
            {
                AccessByPermission = TableData Item = R;
                ApplicationArea = Basic, Suite;
                Caption = 'Applied Entries';
                Image = ApplyEntries;
                Scope = Repeater;
                ToolTip = 'View all applied entries for specific GL entries.';

                trigger OnAction();
                var
                    SeeAppliedEntriesPage: Page "Applied Entries CBN";
                    Found: Boolean;
                    ProgressBar: Dialog;
                    Filters: Text;
                begin
                    //HEI.15>>
                    Filters := Rec.GETVIEW();
                    CLEAR(SeeAppliedEntriesPage);
                    CurrPage.SETSELECTIONFILTER(Rec);
                    ProgressBar.OPEN('Loading...');
                    if Rec.findset() then
                        repeat
                            if SeeAppliedEntriesPage.SetAppliedEntries(Rec) then
                                Found := true;
                        until Rec.NEXT() = 0;

                    if Found then
                        SeeAppliedEntriesPage.RUN();
                    Rec.RESET();
                    Rec.SETVIEW(Filters);
                    ProgressBar.CLOSE();
                    //HEI.15<<
                end;
            }
            action("G/L Entry Additional CBN")
            {
                Caption = 'G/L Entry Additional';
                RunObject = Page "G/L Entry Additional CBN";
                RunPageLink = "G/L Entry No." = FIELD("Entry No.");
                ApplicationArea = All;
                ToolTip = 'Executes the G/L Entry Additional action.';
            }
        }
        addafter(ReverseTransaction)
        {
            action("Apply Entries")
            {
                CaptionML = ENU = 'Apply Entries',
                            FRA = 'Lettrer écritures',
                            FRB = 'Lettrer écritures',
                            NLB = 'Vereffenen';
                Image = ApplyEntries;
                ShortCutKey = 'Shift+F11';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Apply Entries action.';

                trigger OnAction();
                begin
                    //<< HEI.01 RTRGAP038 IBM.CHAUHB01 02/08/17
                    CLEAR(ApplyGLEntries);
                    ApplyGLEntries.SetAllEntries(Rec."G/L Account No.");
                    ApplyGLEntries.RUN();
                    //>> HEI.01 RTRGAP038 IBM.CHAUHB01 02/08/17
                end;
            }
            action("Edit Dimensions")
            {
                Image = DimensionSets;
                Visible = blnEditable;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Edit Dimensions action.';

                trigger OnAction();
                var
                    GLEntryDim: Record "G/L Entry";
                    DimensionManagement: Codeunit DimensionManagement;
                    GlobalDimVal1: Code[20];
                    GlobalDimVal2: Code[20];
                    NewDimSetID: Integer;
                begin
                    //SOICAD>>
                    NewDimSetID := Rec."Dimension Set ID";
                    //NewDimSetID := DimensionManagement.EditDimensionSet2(NewDimSetID, FORMAT(Rec."Entry No."), GlobalDimVal1, GlobalDimVal2);//BC Upgrade KAPOOV01-Codeunit
                    if NewDimSetID <> 0 then begin
                        Rec."Dimension Set ID" := NewDimSetID;
                        Rec."Global Dimension 1 Code" := GlobalDimVal1;
                        Rec."Global Dimension 2 Code" := GlobalDimVal2;
                        CurrPage.UPDATE(true);
                    end;
                    //SOICAD<<
                end;
            }
        }
    }

    var
        rBankAccount: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        rCustomer: Record Customer;
        rFixedAsset: Record "Fixed Asset";
        GLEntryAdditional: Record "G/L Entry Additional FND";
        GLSetup: Record "General Ledger Setup";
        rUserSetup: Record "User Setup";
        rVendor: Record Vendor;
        //recFinXLSetup: Record "Finance XL Setup";  //BC Upgrade KAPOOV01-drink-it
        ApplyGLEntries: Page "Apply Gen Ledger Entries CBN";

        blnEditable: Boolean;

        SetMaisionDesVinsDimVisible: Boolean;
        MovementType: Code[10];
        CustVendNo: Code[20];
        DocNo2: Code[20];
        Text50000: Label 'You cannot reverse G/L entry No. %1 because the entry has already been applied. Undo the application for the G/L entry No. %1 first.';
        txtSourceDescription: Text[50];


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    var
        DimensionSetEntry: Record "Dimension Set Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
    //begin
    /*
    //<<FINXL7.00.001 RBE 20/03/2013
    if recFinXLSetup.READPERMISSION then begin
      case "Source Type" of
        "Source Type"::Customer:
          begin
            if rCustomer.GET("Source No.") then
              txtSourceDescription := rCustomer.Name
            else
              txtSourceDescription := '';
          end;
        "Source Type"::Vendor:
          begin
            if rVendor.GET("Source No.") then
              txtSourceDescription := rVendor.Name
            else
              txtSourceDescription := '';
          end;
        "Source Type"::"Bank Account":
          begin
            if rBankAccount.GET("Source No.") then
              txtSourceDescription := rBankAccount.Name
            else
              txtSourceDescription := '';
          end;
        "Source Type"::"Fixed Asset":
          begin
            if rFixedAsset.GET("Source No.") then
              txtSourceDescription := rFixedAsset.Description
            else
              txtSourceDescription := '';
          end;
        else
          txtSourceDescription := '';
      end;
    end;
    //>>FINXL7.00.001 RBE 20/03/2013

    //HEI.07>>
    GeneralLedgerSetup.GET;
    if DimensionSetEntry.GET("Dimension Set ID",GeneralLedgerSetup."Shortcut Dimension 3 Code") then
      MovementType := DimensionSetEntry."Dimension Value Code"
    else
      MovementType := '';
    //HEI.07<<

    //HEI.25>>
    CustVendNo := '';
    DocNo2 := '';
    GLEntryAdditional.RESET;
    if GLEntryAdditional.GET("Entry No.") then
      begin
        CustVendNo := GLEntryAdditional."CV No.";
        DocNo2 := GLEntryAdditional."Document No.";
      end;
    //HEI.25<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF FINDFIRST THEN;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<<FINXL7.00.001 RBE 20/03/2013
    if recFinXLSetup.READPERMISSION then
      fctSetControlsEditable;
    //>>FINXL7.00.001 RBE 20/03/2013

    //HEI.16<<
    GLSetup.GET;
    if GLSetup."Maison des Vins Dim. Code" <> '' then
      SetMaisionDesVinsDimVisible := true
    else
      SetMaisionDesVinsDimVisible := false;
    //HEI.16>>

    if FINDFIRST then;
    */
    //end;


    //Unsupported feature: CodeModification on "GetCaption(PROCEDURE 2)". Please convert manually.

    //procedure GetCaption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GLAcc."No." <> "G/L Account No." THEN
      IF NOT GLAcc.GET("G/L Account No.") THEN
        IF GETFILTER("G/L Account No.") <> '' THEN
          IF GLAcc.GET(GETRANGEMIN("G/L Account No.")) THEN;
    EXIT(STRSUBSTNO('%1 %2',GLAcc."No.",GLAcc.Name))
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if GLAcc."No." <> "G/L Account No." then
      if not GLAcc.GET("G/L Account No.") then
        if GETFILTER("G/L Account No.") <> '' then
          if GLAcc.GET(GETRANGEMIN("G/L Account No.")) then;
    exit(STRSUBSTNO('%1 %2',GLAcc."No.",GLAcc.Name))
    */
    //end;

    procedure fctSetControlsEditable();
    begin
        //<<FINXL7.00.001 RBE 20/03/2013
        if not rUserSetup.GET(USERID) then
            rUserSetup.INIT();

        //blnEditable := rUserSetup."Allow Modify G/L Entry"//BC Upgrade KAPOOV01-drink-it
        //>>FINXL7.00.001 RBE 20/03/2013
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    //BC Upgrade KAPOOV01>>
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //HEI.07>>
        GeneralLedgerSetup.GET();
        IF DimensionSetEntry.GET(Rec."Dimension Set ID", GeneralLedgerSetup."Shortcut Dimension 3 Code") THEN
            MovementType := DimensionSetEntry."Dimension Value Code"
        else
            MovementType := '';
        //HEI.07<<

        //HEI.25>>
        CustVendNo := '';
        DocNo2 := '';
        GLEntryAdditional.RESET();
        IF GLEntryAdditional.GET(Rec."Entry No.") THEN BEGIN
            CustVendNo := GLEntryAdditional."CV No.";
            DocNo2 := GLEntryAdditional."Document No.";
        end;
        //HEI.25<<
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.16<<
        GLSetup.GET();
        IF GLSetup."Maison des Vins Dim. Code FND" <> '' THEN
            SetMaisionDesVinsDimVisible := TRUE
        else
            SetMaisionDesVinsDimVisible := FALSE;
        //HEI.16>>
    end;
    //BC Upgrade KAPOOV01<<



}

