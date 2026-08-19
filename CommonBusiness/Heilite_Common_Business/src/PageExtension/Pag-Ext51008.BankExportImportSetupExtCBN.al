pageextension 51008 BankExportImportSetupExtCBN extends "Bank Export/Import Setup"
{
    //     HEI.01 V1.05 HT84 IBM POENAB02 22.03.2019
    //   # New fields for Bank Connectivity interface
    //     # 50000 Journal Template Name
    //     # 50001 Journal Batch Name
    //     # 50002 MESTYPE
    //     # 50003 MESCOD
    //     # 50004 MESFCT
    //     # 50005 "Post WS Entries"
    //     # 50006 "Send to WS"
    //     # 50007 "File Prefix"
    //     # 50008 "Export No. Series"
    //     # 50009 "BC (LCY) - Send Without Dec."
    // HEI.02 CHG2020184 IBM POENAB02 27.07.2019 Bank Connectivity interface
    //   # New fields:
    //     # 50010 Bank Stat. CAMT53 No. Series
    //     # 50011 Bank Stat. MT940 No. Series
    // HEI.03 CHG2119688 IBM POENAB02 31.08.2021 HB2428 Panama CITI - bank connectivity payment file
    //   # New field:
    //     # 50012 OPCO
    // HEI.04 CHG2181582 IBM SRIVAS07 16.03.2023 - Mozambique bank connectivity -  outgoing payments (Standard Bank - domestic)
    //   # New field:
    //     # 50013Batch Booking
    //     # 50014User ID Tag
    // HEI.05 CHG2189683 IBM POENAB02 16.03.2023 HB2183 / HB3090 Ethiopia - bank connectivity payment file
    //   # New field:
    //     # 50015 Use Pay. Jnl. Tree Approval
    // HEI.06 CHG2189683 IBM POENAB02 29.03.2023 HB2183 / HB3090 Ethiopia - bank connectivity payment file
    //   # Removed field 50015 Use Pay. Jnl. Tree Approval
    //   # The logic for payment journal approval was moved from Ethiopia CHG to Mozambique CHG and it will be available for every OpCo
    // HEI.07 CHG2190076 HB3104 IBM SRIVAS07 26/07/23 - Mozambique bank connectivity -  outgoing payments (Standard Bank - cross border)
    //   # New field:
    //     # 50015 "BOP Code"
    // HEI.08 CHG2190076 HB3104 IBM SRIVAS07 09/08/23 - Mozambique bank connectivity -  outgoing payments (Standard Bank - cross border)
    //   # New field:
    //     # 50016 "International payment file"
    // HEI.09 CHG2190076 HB3104 IBM SRIVAS07 26/10/23 - Mozambique bank connectivity -  outgoing payments (Standard Bank - cross border)
    //   # New field:
    //     # 50015 "BOPCode"
    //     # 50016 "International Payment File"
    // HEI.10 CHG2237440 HB3573 IBM SRIVAS07 14/06/2024 # Development-Algeria Bank Connectivity - Citi Bank local payment file development
    //     # New Field Aadded - 50017"Debtor Bank Acc. Char"Integer
    //     # New Field Aadded - 50018"Creditor Bank Acc. Char"Integer
    //     # New Field Aadded - 50019"Creditor Bank Branch Char"Integer
    // HEI.11 CHG2271163 SHARMP16 15.01.2025 #BASE BRD DRC BANK CONNECTIVITY SOLUTION - Development
    //     # New Field Added - 50020"Bank Clearing Code" Text[10]
    //     # New Field Added - 50021"Service Level Code" Text[10]

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code for the Bank Export/Import setup.', FRA = 'Spécifie le code des Paramètres exportation/importation bancaire.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the bank export/import setup.', FRA = 'Spécifie le nom des Paramètres exportation/importation bancaire.';
        }
        modify(Direction)
        {
            ToolTipML = ENU = 'Specifies if this setup will be used to import a bank file or to export a bank file.', FRA = 'Indique si ces paramètres seront utilisés pour importer ou pour exporter un fichier bancaire.';
        }
        modify("Processing Codeunit ID")
        {
            ToolTipML = ENU = 'Specifies the codeunit that will import the bank statement data.', FRA = 'Spécifie le codeunit qui importera les données du relevé bancaire.';
        }
        modify("Processing Codeunit Name")
        {
            ToolTipML = ENU = 'Specifies the name of the codeunit that will import the bank statement data.', FRA = 'Spécifie le nom du codeunit qui importera les données du relevé bancaire.';
        }
        modify("Processing XMLport ID")
        {
            ToolTipML = ENU = 'Specifies the XMLport through which the bank statement data is imported.', FRA = 'Spécifie le XMLport via lequel les données du relevé bancaire sont importées.';
        }
        modify("Processing XMLport Name")
        {
            ToolTipML = ENU = 'Specifies the name of the XMLport through which the bank statement data is imported.', FRA = 'Spécifie le nom du XMLport via lequel les données du relevé bancaire sont importées.';
        }
        modify("Data Exch. Def. Code")
        {
            ToolTipML = ENU = 'Specifies a code that represents the xml file with a data exchange definition that you have created in the Data Exchange Framework.', FRA = 'Spécifie le code qui représente le fichier xml contenant la définition d''échange de données créée dans l''infrastructure d''échange de données.';
        }
        modify("Preserve Non-Latin Characters")
        {
            ToolTipML = ENU = 'Specifies that non-latin characters in the bank statement files are preserved during import.', FRA = 'Indique que les caractères non latins présents dans les fichiers bancaires sont préservés pendant l''importation.';
        }
        modify("Check Export Codeunit")
        {
            ToolTipML = ENU = 'Specifies the codeunit that validates payment lines when you use the Export Payments to File action in the Payment Journal window.', FRA = 'Spécifie le codeunit qui valide les lignes paiement lorsque vous utilisez l''action Exporter les paiements dans un fichier dans la fenêtre Feuille paiement.';
        }
        modify("Check Export Codeunit Name")
        {
            ToolTipML = ENU = 'Specifies the name of the codeunit that validates payment lines when you use the Export Payments to File action in the Payment Journal window.', FRA = 'Spécifie le nom du codeunit qui valide les lignes paiement lorsque vous utilisez l''action Exporter les paiements dans un fichier dans la fenêtre Feuille paiement.';
        }
        addafter("Check Export Codeunit Name")
        {
            field("Journal Template Name"; Rec."Journal Template Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Journal Template Name field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Journal Template Name field.';

            }
            field("Journal Batch Name"; Rec."Journal Batch Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Journal Batch Name field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Journal Batch Name field.';

            }
            field(MESTYPE; Rec."MESTYPE FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MESTYPE field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the MESTYPE field.';

            }
            field(MESCOD; Rec."MESCOD FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MESCOD field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the MESCOD field.';

            }
            field(MESFCT; Rec."MESFCT FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MESFCT field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the MESFCT field.';

            }
            field("User ID Tag"; Rec."User ID Tag FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the User ID Tag field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the User ID Tag field.';

            }
            field(BOPCode; Rec."BOPCode FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the BOP Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the BOP Code field.';

            }
            field("File Prefix"; Rec."File Prefix FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the File Prefix field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the File Prefix field.';

            }
            field("Export No. Series"; Rec."Export No. Series FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Export No. Series field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Export No. Series field.';

            }
            field(OPCO; Rec."OPCO FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the OPCO field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the OPCO field.';

            }
            field("Batch Booking"; Rec."Batch Booking FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Batch Booking field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Batch Booking field.';

            }
            field("Post WS Entries"; Rec."Post WS Entries FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Post WS Entries field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Post WS Entries field.';

            }
            field("Debtor Bank Acc. Char"; Rec."Debtor Bank Acc. Char FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Debtor Bank Account Char Limit field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Debtor Bank Account Char Limit field.';

            }
            field("Creditor Bank Acc. Char"; Rec."Creditor Bank Acc. Char FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Creditor Bank Account Char Limit field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Creditor Bank Account Char Limit field.';

            }
            field("Creditor Bank Branch Char"; Rec."Creditor Bank Branch Char FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Creditor Bank Branch Char Limit field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Creditor Bank Branch Char Limit field.';

            }
            field("Send to WS"; Rec."Send to WS FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Send to WS field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Send to WS field.';

            }
            field("International Payment File"; Rec."International Payment File FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the International Payment File field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the International Payment File field.';

            }
            field("BC (LCY) - Send Without Dec."; Rec."BC (LCY) - Send W/O Dec. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the BC (LCY) - Send Without Decimals field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the BC (LCY) - Send Without Decimals field.';

            }
            field("Bank Stat. CAMT53 No. Series"; Rec."Bank Stat. CAMT53 No. Srs. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank Statement CAMT53 No. Series field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Bank Statement CAMT53 No. Series field.';

            }
            field("Bank Stat. MT940 No. Series"; Rec."Bank Stat. MT940 No. Srs. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank Stat. MT940 No. Series field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Bank Stat. MT940 No. Series field.';

            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

