tableextension 50004 BankExportImportSetupExtFND extends "Bank Export/Import Setup"
{
    //     HEI.01 V1.05 HT84 IBM POENAB02 22.03.2019
    //   # New fields for Bank Connectivity interface
    //     # 50000 Journal Template Name
    //     # 50001 Journal Batch Name
    //     # 50002 MESTYPE
    //     # 50003 MESCOD
    //     # 50004 MESFCT
    //     # 50005 Post WS Entries
    //     # 50006 Send to WS
    //     # 50007 File Prefix
    //     # 50008 Export No. Series
    //     # 50009 BC (LCY) - Send Without Dec.

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
    //   # Added New Option - MZ - 50012 OPCO
    // HEI.05 CHG2189683 IBM POENAB02 16.03.2023 HB2183 / HB3090 Ethiopia - bank connectivity payment file
    //   # New field:
    //     # 50015 Use Pay. Jnl. Tree Approval
    // HEI.06 CHG2189683 IBM POENAB02 29.03.2023 HB2183 / HB3090 Ethiopia - bank connectivity payment file
    //   # Removed field 50015 Use Pay. Jnl. Tree Approval
    //   # The logic for payment journal approval was moved from Ethiopia CHG to Mozambique CHG and it will be available for every OpCo
    // HEI.07 CHG2190076 HB3104 IBM SRIVAS07 26/07/23 - Mozambique bank connectivity -  outgoing payments (Standard Bank - cross border)
    //   # New field:
    //     # 50015 BOP Code
    // HEI.08 CHG2190076 HB3104 IBM SRIVAS07 09/08/23 - Mozambique bank connectivity -  outgoing payments (Standard Bank - cross border)
    //   # New field:
    //     # 50016 International payment file
    // HEI.09 CHG2190076 HB3104 IBM SRIVAS07 26/10/23 - Mozambique bank connectivity -  outgoing payments (Standard Bank - cross border)
    //   # New field:
    //     # 50015 BOPCode
    //     # 50016 International Payment File
    // HEI.10 CHG2237440 HB3573 IBM SRIVAS07 17/04/2024 # Development-Algeria Bank Connectivity - Citi Bank local payment file development
    //     # Added New Option - Algeria - 50012 OPCO
    // HEI.11 CHG2236071 IBM POENAB02 10.06.2024 Bank connectivity Bahamas - Citi Bank
    //   # Added new option in field 50012 OPCO - Bahamas
    // HEI.12 CHG2237440 HB3573 IBM SRIVAS07 14/06/2024 # Development-Algeria Bank Connectivity - Citi Bank local payment file development
    //     # New Field Aadded - 50017"Debtor Bank Acc. Char"Integer
    //     # New Field Aadded - 50018"Creditor Bank Acc. Char"Integer
    //     # New Field Aadded - 50019"Creditor Bank Branch Char"Integer
    // HEI.13 CHG2271163 SHARMP16 15.01.2025 # BASE BRD DRC BANK CONNECTIVITY SOLUTION - Development
    //  # Added New Option - DRC - 50012 OPCO - DRC
    //  # New Field Added - 50020"Bank Clearing Code" Text[10]
    //  # New Field Added - 50021"Service Level Code" Text[10]

    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify(Direction)
        {
            CaptionML = ENU = 'Direction', FRA = 'Direction';
            OptionCaptionML = ENU = 'Export,Import,Export-Positive Pay', FRA = 'Exportation,Importation,Exportation-Positive Pay';
        }
        modify("Processing Codeunit ID")
        {

            //Unsupported feature: Change TableRelation on ""Processing Codeunit ID"(Field 4)". Please convert manually.

            CaptionML = ENU = 'Processing Codeunit ID', FRA = 'ID Codeunit traitement';
        }
        modify("Processing Codeunit Name")
        {

            //Unsupported feature: Change CalcFormula on ""Processing Codeunit Name"(Field 5)". Please convert manually.

            CaptionML = ENU = 'Processing Codeunit Name', FRA = 'Nom Codeunit traitement';
        }
        modify("Processing XMLport ID")
        {

            //Unsupported feature: Change TableRelation on ""Processing XMLport ID"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Processing XMLport ID', FRA = 'ID XMLPort traitement';
        }
        modify("Processing XMLport Name")
        {

            //Unsupported feature: Change CalcFormula on ""Processing XMLport Name"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Processing XMLport Name', FRA = 'Nom XMLPort traitement';
        }
        modify("Data Exch. Def. Code")
        {

            //Unsupported feature: Change TableRelation on ""Data Exch. Def. Code"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Data Exch. Def. Code', FRA = 'Code déf. échange données';
        }
        modify("Data Exch. Def. Name")
        {

            //Unsupported feature: Change CalcFormula on ""Data Exch. Def. Name"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Data Exch. Def. Name', FRA = 'Nom déf. échange données';
        }
        modify("Preserve Non-Latin Characters")
        {

            //Unsupported feature: Change InitValue on ""Preserve Non-Latin Characters"(Field 10)". Please convert manually.

            CaptionML = ENU = 'Preserve Non-Latin Characters', FRA = 'Conserver les caractères non latins';
        }
        modify("Check Export Codeunit")
        {

            //Unsupported feature: Change TableRelation on ""Check Export Codeunit"(Field 11)". Please convert manually.

            CaptionML = ENU = 'Check Export Codeunit', FRA = 'Codeunit vérification exportation';
        }
        modify("Check Export Codeunit Name")
        {

            //Unsupported feature: Change CalcFormula on ""Check Export Codeunit Name"(Field 12)". Please convert manually.

            CaptionML = ENU = 'Check Export Codeunit Name', FRA = 'Nom Codeunit vérification exportation';
        }

        //Unsupported feature: CodeModification on "Direction(Field 3).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Direction = Direction::"Export-Positive Pay" THEN
          "Processing Codeunit ID" := CODEUNIT::"Exp. Launcher Pos. Pay"
        else
          IF "Processing Codeunit ID" = CODEUNIT::"Exp. Launcher Pos. Pay" THEN
            "Processing Codeunit ID" := 0;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Direction = Direction::"Export-Positive Pay" then
          "Processing Codeunit ID" := CODEUNIT::"Exp. Launcher Pos. Pay"
        else
          if "Processing Codeunit ID" = CODEUNIT::"Exp. Launcher Pos. Pay" then
            "Processing Codeunit ID" := 0;
        */
        //end;
        field(50000; "Journal Template Name FND"; Code[10])
        {
            CaptionML = ENU = 'Journal Template Name',
                        FRA = 'Nom modèle feuille';
            Description = 'HEI.01';
            TableRelation = "Gen. Journal Template";

            trigger OnValidate();
            begin
                //bogdan>>
                if Rec."Journal Template Name FND" <> xRec."Journal Template Name FND" then
                    "Journal Batch Name FND" := '';
                //bogdan<<
            end;
        }
        field(50001; "Journal Batch Name FND"; Code[10])
        {
            CaptionML = ENU = 'Journal Batch Name',
                        FRA = 'Nom feuille';
            Description = 'HEI.01';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = FIELD("Journal Template Name FND"));
        }
        field(50002; "MESTYPE FND"; Text[50])
        {
            Caption = 'MESTYPE';
            Description = 'HEI.01';
        }
        field(50003; "MESCOD FND"; Text[10])
        {
            Caption = 'MESCOD';
            Description = 'HEI.01';
        }
        field(50004; "MESFCT FND"; Text[10])
        {
            Caption = 'MESFCT';
            Description = 'HEI.01';
        }
        field(50005; "Post WS Entries FND"; Boolean)
        {
            Caption = 'Post WS Entries';
            Description = 'HEI.01';
        }
        field(50006; "Send to WS FND"; Boolean)
        {
            Description = 'HEI.01';
            Caption = 'Send to WS';
        }
        field(50007; "File Prefix FND"; Code[20])
        {
            Caption = 'File Prefix';
            Description = 'HEI.01';
        }
        field(50008; "Export No. Series FND"; Code[10])
        {
            CaptionML = ENU = 'Export No. Series',
                        FRB = 'Souche de n° d''exportation',
                        NLB = 'Exportnr. series';
            Description = 'HEI.01';
            TableRelation = "No. Series".Code;
        }
        field(50009; "BC (LCY) - Send W/O Dec. FND"; Boolean)
        {
            Caption = 'BC (LCY) - Send Without Decimals';
            Description = 'HEI.01';
        }
        field(50010; "Bank Stat. CAMT53 No. Srs. FND"; Code[10])
        {
            Caption = 'Bank Statement CAMT53 No. Series';
            Description = 'HEI.02';
            TableRelation = "No. Series".Code;
        }
        field(50011; "Bank Stat. MT940 No. Srs. FND"; Code[10])
        {
            Caption = 'Bank Stat. MT940 No. Series';
            Description = 'HEI.02';
            TableRelation = "No. Series".Code;
        }
        //---BC Upgrade KAMNAY01>>---Added New Option - DRC - 50012 OPCO - DRC
        field(50012; "OPCO FND"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
            Caption = 'OPCO';
            OptionCaption = ' ,Ivory Coast,Panama,Ethiopia-CBE,Ethiopia-Dashen,MZ,Algeria,Bahamas,DRC';
            OptionMembers = " ","Ivory Coast",Panama,"Ethiopia-CBE","Ethiopia-Dashen",MZ,Algeria,Bahamas,DRC;
        }
        //---BC Upgrade KAMNAY01<<---Added New Option - DRC - 50012 OPCO - DRC
        field(50013; "Batch Booking FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Caption = 'Batch Booking';
        }
        field(50014; "User ID Tag FND"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Caption = 'User ID Tag';
        }
        field(50015; "BOPCode FND"; Text[70])
        {
            Caption = 'BOP Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(50016; "International Payment File FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
            Caption = 'International Payment File';
        }
        field(50017; "Debtor Bank Acc. Char FND"; Integer)
        {
            Caption = 'Debtor Bank Account Char Limit';
            DataClassification = ToBeClassified;
            Description = 'HEI.12';
        }
        field(50018; "Creditor Bank Acc. Char FND"; Integer)
        {
            Caption = 'Creditor Bank Account Char';
            DataClassification = ToBeClassified;
            Description = 'HEI.12';
        }
        field(50019; "Creditor Bank Branch Char FND"; Integer)
        {
            Caption = 'Creditor Bank Branch Char Limit';
            DataClassification = ToBeClassified;
            Description = 'HEI.12';
        }
        //---BC Upgrade KAMNAY01>>---New Field added (15.01.2025)
        field(50020; "Bank Clearing Code FND"; Text[10])
        {
            Caption = 'Bank Clearing Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }

        field(50021; "Service Level Code FND"; Text[10])
        {
            Caption = 'Service Level Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        //---BC Upgrade KAMNAY01<<---New Field added (15.01.2025)

    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

