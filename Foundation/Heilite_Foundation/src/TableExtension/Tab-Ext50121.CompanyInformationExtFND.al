tableextension 50121 CompanyInformationExtFND extends "Company Information"
{
    // # HEI.01 #FDD-GAPID013-19/07/2017
    //  Field "Language Code" added by PATHAA02

    // HEI.02 FDD RTRGAP062 Heilite BASE IBM ISYED01 04/08/2017 HeiMatch Flatfile
    //   # Added field Reporting Entity
    // HEI.03 FDD-PURAP05 IBM LAZARE02 14.08.2017 # Modify IBANError function
    // HEI.04 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.05 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added fileds to Business Type table
    // HEI.06 FDD-GAPLOG006 IBM ISYED01 12.07.2017
    //   # Added Fields “Cap. Social” to table.
    // HEI.07 SOICAD new field check digit
    // HEI.08 FDD-RW-GAPLOG02 IBM NASTAA02 13.09.2018 # Delivery Note
    //   # Created new Field: 50007 - Trade Register
    // HEI.09 FDD-MZ-PROGAP001 IBM Isyed01 20.11.2018
    //   # Created new fileds: Invoice name,Invoice Address,Invoice Address2, Invoice City,Invoice PostCode.
    // HEI.10 RFC-CHG0264787 IBM.LS 17.12.2018
    //   # New Field created: 50015 - "OpCo Logo"
    // HEI.10 FDD-IC-PROGAP BRD HT417 IBM ISYED01 PO invoice layout
    //   # new filed created :RCCM Legal entity code
    // HEI.12 V1.05 HT84 IBM POENAB02 28.03.2019
    //   # New fields for Bank Connectivity interface
    //     # 50016 Enterprise No.
    //     # 50017 Enterprise No. Accountant
    // HEI.13 HT476 CHG2011084 IBM GAVANM01 17.07.2019
    //   # New Field created: 50018 - "OpCo Footer image"
    // HEI.14 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New fields:
    //     # 10802 APE Code
    //     # 10803 Legal Form
    //     # 10804 Stock Capital
    //     # 10810 Default Bank Account No.
    //     # 10811 CISD
    //     # 10812 Last Intrastat Declaration ID
    //     # 50019 Enable French Localization
    //   # New functions:
    //     # GetPartyID
    //     # GetControlSum
    //     # GetSIREN
    // HEI.15 FDD-HT935 IBM POSTOI01 # Purchase Order Layout Burundi
    //   # New field created: 50020 - PO Legal Text Box E-Mail Text 80
    // HEI.16 FDD-HT935 IBM POSTOI01 # Purchase Order Layout Burundi
    //   # New fields created:
    //     50021 - Add. Address Text 50
    //   50022Add. CityText30
    //   50023Add. Phone No.Text30
    //   50024Add. Post CodeCode20
    // HEI.17 FDD-HT935 IBM POSTOI01 # Purchase Order Layout Burundi
    //   # New fields created:
    // 50025 Plant Opening Hrs. Text 30
    // HEI.18 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //   # New Field added "Signature Image" for report layouts
    // HEI.19 CHG2055075 HT1156 IBM GAVANM0101 03.08.2020 # Sales Documents DRC
    //   # increase to 25 the length of the field 50013 - RCCM Legal Entity Code
    // HEI.20 CHG2085435 IBM GAVANM01 25.11.2020 - HT1773 Sales documents layout
    //   # new fields added: 50027-Currencyand 50028-Currency 2
    //   # length increased to 50 for the following fields: 14 - Bank Account No. ,  2029611 - Bank Account No. 2
    // HEI.21 CHG2105033 BULIMC01 IBM 05.11.2021#new field created: 50029 - "Opco Code for CFAO"
    // HEI.22 CHG2127496 SHOIVAS05 IBM 24.12.2021#new field created: 50030 - "Save Payment Sheet"
    // HEI.23 CHG2127496 SHOIVAS05 IBM 08.02.2022
    //   #"Save Payment Sheet" field is not anymore require Removing: 50030 - "Save Payment Sheet"
    // HEI.24 CHG2244079 VERMAA03 IBM 13.06.2024 Remittance advice for Panama
    //   # new fields added: 50030 - "Account Payable Email"
    // version NAVW110.0,FINXL8.00.001,IPLXL9.00.001,DITW110.00.08,HEI.24

    //Bc Upgrade YADAVM09 Drink it field blocked 
    //#APE Code
    //#Legal Form
    //#Stock Capital
    //#Default Bank Account No
    //#CISD
    //#Last Intrastat Declaration ID

    // BC Upgrade SHUKLP03 >> Testscript OTC221 - Added new field "Address Position on Documents", Bank Account No. 2, IBAN 2, SWIFT Code 2, Currency 2 and new group "Payments 2" in Payment FastTab.

    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Name 2")
        {
            CaptionML = ENU = 'Name 2', FRA = 'Nom 2';
        }
        modify(Address)
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
        }
        modify("Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
        }
        modify(City)
        {

            //Unsupported feature: Change TableRelation on "City(Field 6)". Please convert manually.

            CaptionML = ENU = 'City', FRA = 'Ville';
        }
        modify("Phone No.")
        {
            CaptionML = ENU = 'Phone No.', FRA = 'N° téléphone';
        }
        modify("Phone No. 2")
        {
            CaptionML = ENU = 'Phone No. 2', FRA = 'N° téléphone 2';
        }
        modify("Telex No.")
        {
            CaptionML = ENU = 'Telex No.', FRA = 'N° télex';
        }
        modify("Fax No.")
        {
            CaptionML = ENU = 'Fax No.', FRA = 'N° télécopie';
        }
        modify("Giro No.")
        {
            CaptionML = ENU = 'Giro No.', FRA = 'N° CCP';
        }
        modify("Bank Name")
        {
            CaptionML = ENU = 'Bank Name', FRA = 'Nom de la banque';
        }
        modify("Bank Branch No.")
        {
            CaptionML = ENU = 'Bank Branch No.', FRA = 'Code établissement';
        }
        modify("Bank Account No.")
        {

            //Unsupported feature: Change Data type on ""Bank Account No."(Field 14)". Please convert manually.

            CaptionML = ENU = 'Bank Account No.', FRA = 'N° compte bancaire';

            //Unsupported feature: Change Description on ""Bank Account No."(Field 14)". Please convert manually.

        }
        modify("Payment Routing No.")
        {
            CaptionML = ENU = 'Payment Routing No.', FRA = 'N° paiement automatique';
        }
        modify("Customs Permit No.")
        {
            CaptionML = ENU = 'Customs Permit No.', FRA = 'N° autorisation douanière';
        }
        modify("Customs Permit Date")
        {
            CaptionML = ENU = 'Customs Permit Date', FRA = 'Date autorisation douanière';
        }
        modify("VAT Registration No.")
        {
            CaptionML = ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        }
        modify("Registration No.")
        {
            CaptionML = ENU = 'Registration No.', FRA = 'N° SIRET';
        }
        modify("Telex Answer Back")
        {
            CaptionML = ENU = 'Telex Answer Back', FRA = 'Télex retour';
        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Ship-to Name', FRA = 'Nom du destinataire';
        }
        modify("Ship-to Name 2")
        {
            CaptionML = ENU = 'Ship-to Name 2', FRA = 'Nom du destinataire 2';
        }
        modify("Ship-to Address")
        {
            CaptionML = ENU = 'Ship-to Address', FRA = 'Adresse destinataire';
        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Ship-to Address 2', FRA = 'Adresse destinataire 2';
        }
        modify("Ship-to City")
        {

            //Unsupported feature: Change TableRelation on ""Ship-to City"(Field 26)". Please convert manually.

            CaptionML = ENU = 'Ship-to City', FRA = 'Ville destinataire';
        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Ship-to Contact', FRA = 'Contact destinataire';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 28)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify(Picture)
        {
            CaptionML = ENU = 'Picture', FRA = 'Image';
        }
        modify("Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Post Code"(Field 30)". Please convert manually.

            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify(County)
        {
            CaptionML = ENU = 'County', FRA = 'Région';
        }
        modify("Ship-to Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Ship-to Post Code"(Field 32)". Please convert manually.

            CaptionML = ENU = 'Ship-to Post Code', FRA = 'Code postal destinataire';
        }
        modify("Ship-to County")
        {
            CaptionML = ENU = 'Ship-to County', FRA = 'Région destinataire';
        }
        modify("E-Mail")
        {
            CaptionML = ENU = 'Email', FRA = 'Adresse e-mail';
        }
        modify("Home Page")
        {
            CaptionML = ENU = 'Home Page', FRA = 'Page d''accueil';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 36)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("Ship-to Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Ship-to Country/Region Code"(Field 37)". Please convert manually.

            CaptionML = ENU = 'Ship-to Country/Region Code', FRA = 'Code pays/région destinataire';
        }
        modify(IBAN)
        {
            CaptionML = ENU = 'IBAN', FRA = 'IBAN';
        }
        modify("SWIFT Code")
        {
            CaptionML = ENU = 'SWIFT Code', FRA = 'Code SWIFT';
        }
        modify("Industrial Classification")
        {
            CaptionML = ENU = 'Industrial Classification', FRA = 'Classification des industries';
        }
        //BC Upgrade KAPOOV01 Fields Removed >>
        // modify("IC Partner Code")
        // {
        //     CaptionML = ENU = 'IC Partner Code', FRA = 'Code du partenaire IC';
        // }
        // modify("IC Inbox Type")
        // {
        //     CaptionML = ENU = 'IC Inbox Type', FRA = 'Type de boîte de réception IC';
        //     OptionCaptionML = ENU = 'File Location,Database', FRA = 'Emplacement du fichier,Base de données';
        // }
        // modify("IC Inbox Details")
        // {
        //     CaptionML = ENU = 'IC Inbox Details', FRA = 'Détails sur boîte récep IC';
        // }
        //BC Upgrade KAPOOV01 <<
        modify("System Indicator")
        {
            CaptionML = ENU = 'System Indicator', FRA = 'Indicateur système';
            OptionCaptionML = ENU = 'None,Custom Text,Company Information,Company,Database,Company+Database', FRA = 'Aucun,Texte personnalisé,Informations société,Société,Base de données,Société+Base de données';
        }
        modify("Custom System Indicator Text")
        {
            CaptionML = ENU = 'Custom System Indicator Text', FRA = 'Texte indicateur système personnalisé';
        }
        modify("System Indicator Style")
        {
            CaptionML = ENU = 'System Indicator Style', FRA = 'Style indicateur système';
            OptionCaptionML = ENU = 'Standard,Red,Blue,Green,Brown,Mauve,Black,Yellow,Green Yellowish,White', FRA = 'Standard,Accent1,Accent2,Accent3,Accent4,Accent5,Accent6,Accent7,Accent8,Accent9';

            //Unsupported feature: Change Description on ""System Indicator Style"(Field 48)". Please convert manually.

        }
        modify("Allow Blank Payment Info.")
        {
            CaptionML = ENU = 'Allow Blank Payment Info.', FRA = 'Autoriser les infos de paiements vides.';
        }
        modify(GLN)
        {
            CaptionML = ENU = 'GLN', FRA = 'GLN';
        }
        modify("Created DateTime")
        {
            CaptionML = ENU = 'Created DateTime', FRA = 'Date/heure de création';
        }
        modify("Demo Company")
        {
            CaptionML = ENU = 'Demo Company', FRA = 'Société fictive';
        }
        modify("Responsibility Center")
        {
            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
        }
        modify("Check-Avail. Period Calc.")
        {
            CaptionML = ENU = 'Check-Avail. Period Calc.', FRA = 'Horizon vérification disponibilité';
        }
        modify("Check-Avail. Time Bucket")
        {
            CaptionML = ENU = 'Check-Avail. Time Bucket', FRA = 'Période de vérification de disponibilité';
            //OptionCaptionML = ENU = 'Day,Week,Month,Quarter,Year', FRA = 'Jour,Semaine,Mois,Trimestre,Année';
        }
        modify("Base Calendar Code")
        {
            CaptionML = ENU = 'Base Calendar Code', FRA = 'Code calendrier principal';
        }
        modify("Cal. Convergence Time Frame")
        {
            CaptionML = ENU = 'Cal. Convergence Time Frame', FRA = 'Calcul délai de convergence';
        }
        //BC Upgrade KAPOOV01 Field Removed>>
        // modify("Show Chart On RoleCenter")
        // {
        //     CaptionML = ENU = 'Show Chart On RoleCenter', FRA = 'Afficher dans le graphique sur RoleCenter';
        // }
        //BC Upgrade KAPOOV01<<

        //Unsupported feature: CodeModification on "City(Field 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Ship-to City"(Field 26).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Post Code"(Field 30).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Ship-to Post Code"(Field 32).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Ship-to City","Ship-to Post Code","Ship-to County","Ship-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""IC Inbox Type"(Field 42).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "IC Inbox Type" = "IC Inbox Type"::Database THEN
          "IC Inbox Details" := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "IC Inbox Type" = "IC Inbox Type"::Database then
          "IC Inbox Details" := '';
        */
        //end;


        //Unsupported feature: CodeModification on ""IC Inbox Details"(Field 43).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("IC Partner Code");
        CASE "IC Inbox Type" OF
          "IC Inbox Type"::"File Location":
            BEGIN
              IF "IC Inbox Details" = '' THEN
                FileName := STRSUBSTNO('%1.xml',"IC Partner Code")
              else
                FileName := "IC Inbox Details" + STRSUBSTNO('\%1.xml',"IC Partner Code");

              FileName2 := FileMgt.SaveFileDialog(Text001,FileName,'');
              IF FileName <> FileName2 THEN BEGIN
                Path := FileMgt.GetDirectoryName(FileName2);
                IF Path <> '' THEN
                  "IC Inbox Details" := COPYSTR(Path,1,250);
              end;
            end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("IC Partner Code");
        case "IC Inbox Type" of
          "IC Inbox Type"::"File Location":
            begin
              if "IC Inbox Details" = '' then
                FileName := STRSUBSTNO('%1.xml',"IC Partner Code")
              else
        #8..10
              if FileName <> FileName2 then begin
                Path := FileMgt.GetDirectoryName(FileName2);
                if Path <> '' then
                  "IC Inbox Details" := COPYSTR(Path,1,250);
              end;
            end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on "GLN(Field 90).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF GLN <> '' THEN
          IF NOT GLNCalculator.IsValidCheckDigit13(GLN) THEN
            ERROR(GLNCheckDigitErr,FIELDCAPTION(GLN));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if GLN <> '' then
          if not GLNCalculator.IsValidCheckDigit13(GLN) then
            ERROR(GLNCheckDigitErr,FIELDCAPTION(GLN));
        */
        //end;

        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        field(10802; "APE Code"; Code[10])
        {
            CaptionML = ENU = 'APE Code',
                        FRA = 'Code APE';
            Description = 'HEI.14';
        }
        field(10803; "Legal Form"; Text[30])
        {
            CaptionML = ENU = 'Legal Form',
                        FRA = 'Forme juridique';
            Description = 'HEI.14';
        }
        field(10804; "Stock Capital"; Text[30])
        {
            CaptionML = ENU = 'Stock Capital',
                        FRA = 'Capital social';
            Description = 'HEI.14';
        }
        field(10810; "Default Bank Account No."; Code[20])
        {
            CaptionML = ENU = 'Default Bank Account No.',
                        FRA = 'N° compte banc. par déf.';
            Description = 'HEI.14';
            TableRelation = "Bank Account";
        }
        field(10811; CISD; Code[10])
        {
            CaptionML = ENU = 'CISD',
                        FRA = 'CISD';
            Description = 'HEI.14';
        }
        field(10812; "Last Intrastat Declaration ID"; Integer)
        {
            CaptionML = ENU = 'Last Intrastat Declaration ID',
                        FRA = 'ID dernière D.E.B.';
            Description = 'HEI.14';
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
        field(50000; "Language Code FND"; Code[10])
        {
            caption = 'Language Code';
            Description = 'HEI.01';
            TableRelation = Language.Code;
        }
        field(50001; "Reporting Entity FND"; Code[10])
        {
            Caption = 'Reporting Entity';
            Description = 'HEI.02';
        }
        field(50002; "Business Type FND"; Code[10])
        {
            Caption = 'Business Type';
            Description = 'HEI.05';
        }
        field(50003; "WHT Registration ID FND"; Text[30])
        {
            Caption = 'WHT Registration ID';
            Description = 'HEI.04';
        }
        field(50004; "RDO Code FND"; Code[3])
        {
            caption = 'RDO Code';
            Description = 'HEI.04';
        }
        field(50005; "Cap. Social FND"; Text[20])
        {
            caption = 'Cap. Social';
            Description = 'HEI.06';
        }
        field(50006; "Check Digit FND"; Text[10])
        {
            caption = 'Check Digit';
            Description = 'HEI.07';
        }
        // field(50007; "Trade Register"; Code[10]) // BC FR Upgrade KAIRAR01
        // {
        //     Description = 'HEI.08';
        // }
        field(50008; "Invoice Name FND"; Text[50])
        {
            caption = 'Invoice Name';
            Description = 'HEI.09';
        }
        field(50009; "Invoice Address FND"; Text[50])
        {
            caption = 'Invoice Address';
            Description = 'HEI.09';
        }
        field(50010; "Invoice Address2 FND"; Text[50])
        {
            caption = 'Invoice Address2';
            Description = 'HEI.09';
        }
        field(50011; "Invoice City FND"; Text[30])
        {
            CaptionML = ENU = 'City',
                        FRA = 'Ville';
            Description = 'HEI.09';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            else IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City where("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GUIALLOWED);
            end;
        }
        field(50012; "Invoice Post Code FND"; Code[20])
        {
            CaptionML = ENU = 'Post Code',
                        FRA = 'Code postal';
            Description = 'HEI.09';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".Code
            else IF ("Country/Region Code" = FILTER(<> '')) "Post Code".Code where("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GUIALLOWED);
            end;
        }
        field(50013; "RCCM Legal entity code FND"; Code[25])
        {
            caption = 'RCCM Legal entity code';
            Description = 'HEI.11, HEi.18';
        }
        field(50015; "OpCo Logo FND"; BLOB)
        {
            caption = 'OpCo Logo';
            Description = 'HEI.10';
            SubType = Bitmap;
        }
        field(50016; "Enterprise No. FND"; Text[50])
        {
            CaptionML = ENU = 'Enterprise No.',
                        FRB = 'N° de société',
                        NLB = 'Ondernemingsnr.';
            Description = 'HEI.12';

            trigger OnValidate();
            begin
                //HEI.12>>
                if "Enterprise No. FND" <> '' then begin
                    //IF NOT Country.DetermineCountry("Country/Region Code") THEN
                    //  ERROR(Text11302,FIELDCAPTION("Enterprise No. FND"));
                    if not EnterpriseNoMgt.MOD97Check("Enterprise No. FND") then
                        ERROR(Text50000, FIELDCAPTION("Enterprise No. FND"));
                    "VAT Registration No." := '';
                end;

                if ("Enterprise No. Accountant FND" = '') or ("Enterprise No. Accountant FND" = xRec."Enterprise No. Accountant FND") then
                    "Enterprise No. Accountant FND" := "Enterprise No. FND";
                //HEI.12<<
            end;
        }
        field(50017; "Enterprise No. Accountant FND"; Text[50])
        {
            CaptionML = ENU = 'Enterprise No. Accountant',
                        FRB = 'N° de société du comptable',
                        NLB = 'Ondernemingsnr. Boekhouder';
            Description = 'HEI.12';
        }
        field(50018; "OpCo Footer image FND"; BLOB)
        {
            caption = 'OpCo Footer image';
            Description = 'HEI.13';
            SubType = Bitmap;
        }
        field(50019; "Enable French Localization FND"; Boolean)
        {
            Caption = 'Enable French Localization';
            Description = 'HEI.14';
        }
        field(50020; "PO Legal Text Box E-Mail FND"; Text[80])
        {
            caption = 'PO Legal Text Box E-Mail';
            Description = 'HEI.15';
        }
        field(50021; "Add. Address FND"; Text[50])
        {
            CaptionML = ENU = 'Additional Address',
                        FRA = 'Adresse Supplémantaire';
            Description = 'HEI.16';
        }
        field(50022; "Add. City FND"; Text[30])
        {
            CaptionML = ENU = 'Additional City',
                        FRA = 'Ville Supplémantaire';
            Description = 'HEI.16';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            else IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City where("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                PostCode.ValidateCity("Add. City FND", "Add. Post Code FND", County, "Country/Region Code", (CurrFieldNo <> 0) and GUIALLOWED);
            end;
        }
        field(50023; "Add. Phone No. FND"; Text[30])
        {
            CaptionML = ENU = 'Additional Phone No.',
                        FRA = 'N° téléphone Supplémantaire';
            Description = 'HEI.16';
            ExtendedDatatype = PhoneNo;
        }
        field(50024; "Add. Post Code FND"; Code[20])
        {
            CaptionML = ENU = 'Additional Post Code',
                        FRA = 'Code postal Supplémantaire';
            Description = 'HEI.16';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".Code
            else IF ("Country/Region Code" = FILTER(<> '')) "Post Code".Code where("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                PostCode.ValidatePostCode("Add. City FND", "Add. Post Code FND", County, "Country/Region Code", (CurrFieldNo <> 0) and GUIALLOWED);
            end;
        }
        field(50025; "Plant Opening Hrs. FND"; Text[30])
        {
            caption = 'Plant Opening Hrs.';
            Description = 'HEI.17';
        }
        field(50026; "Signature Image FND"; BLOB)
        {
            caption = 'Signature Image';
            Description = 'HEI.18';
            SubType = Bitmap;
        }
        field(50027; "Currency FND"; Code[10])
        {
            caption = 'Currency';
            Description = 'HEI.20';
            TableRelation = Currency;
        }
        field(50028; "Currency 2 FND"; Code[10])
        {
            caption = 'Currency 2';
            DataClassification = ToBeClassified;
            Description = 'HEI.20';
            TableRelation = Currency;
        }
        field(50029; "OpCo Code for CFAO FND"; Code[10])
        {
            caption = 'OpCo Code for CFAO';
            DataClassification = ToBeClassified;
            Description = 'HEI.21';
        }
        field(50030; "Account Payable Email FND"; Text[50])
        {
            caption = 'Account Payable Email';
            DataClassification = ToBeClassified;
            Description = 'HEI.24';
        }
        field(50040; "Trade Register FND"; Code[10]) // BC FR Upgrade KAIRAR01
        {
            caption = 'Trade Register';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(90000; "Legal Entity Code FND"; Code[20])
        {
            caption = 'Legal Entity Code';
            Description = 'TMA BI';
        }

        // BC Upgrade SHUKLP03 >> OTC221 => fields added
        field(50031; "Bank Name 2 FND"; Text[30])
        {
            CaptionML = ENU = 'Bank Name 2',
                        FRA = 'Nom de la banque 2';
        }
        field(50032; "Bank Account No. 2 FND"; Text[50])
        {
            CaptionML = ENU = 'Bank Account No. 2',
                        FRA = 'N° compte bancaire 2';
        }
        field(50033; "IBAN 2 FND"; Code[50])
        {
            CaptionML = ENU = 'IBAN 2',
                        FRA = 'IBAN 2';

            trigger OnValidate();
            begin
                CheckIBAN("IBAN 2 FND");
            end;
        }
        field(50034; "SWIFT Code 2 FND"; Code[20])
        {
            CaptionML = ENU = 'SWIFT Code 2',
                        FRA = 'Code SWIFT 2';
        }
        field(50035; "Address Position on Docs FND"; Option)
        {
            CaptionML = ENU = 'Address Position on Documents',
                        FRA = 'Position Adresse sur le Document';
            OptionCaptionML = ENU = 'Left,Right',
                              FRA = 'Gauche,Droite';
            OptionMembers = Left,Right;
        }
        // BC Upgrade SHUKLP03 << OTC221 => fields added
        //BC UPGRADE KUMARR78 << 18-06-2026
        field(50036; "Legal Form FND"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        //BC UPGRADE KUMARR78 >> 18-06-2026


        //BC Upgrade KAPOOV01 >>
        // field(2013725; "AAD Responsible No."; Code[20])
        // {
        //     CaptionML = ENU = 'AAD Responsible No.',
        //                 FRA = 'N° responsable AAD';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "AAD Responsible";
        // }
        // field(2013726; "Tax Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'Tax Registration No.',
        //                 FRA = 'N° Registration Taxe';
        //     Description = 'DITW15.00.00.28';
        // }
        // field(2013727; "AAD Nos."; Code[10])
        // {
        //     CaptionML = ENU = 'AAD Nos.',
        //                 FRA = 'N° DAA';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "No. Series";
        // }
        // field(2013754; "AAD Copies"; Integer)
        // {
        //     CaptionML = ENU = 'AAD Copies',
        //                 FRA = 'Nombre exemplaires DAA';
        //     Description = 'DITW15.00.00.35';
        // }
        // field(2014089; "Company Cashier"; Text[50])
        // {
        //     CaptionML = ENU = 'Company Cashier',
        //                 FRA = 'Réceptionniste société';
        //     Description = 'DITW15.00.00.26';
        // }
        // field(2014268; "Consignor Type"; Option)
        // {
        //     CaptionML = ENU = 'Consignor Type',
        //                 FRA = 'Type expéditeur';
        //     Description = 'DITW15.00.00.38 #1217';
        //     OptionCaptionML = ENU = ' ,Authorised Warehouse Keeper,Registered Consignor',
        //                       FRA = ' ,L''expéditeur entrepositaire agréé,Expéditeur enregistré';
        //     OptionMembers = " ",AuthWhseKeeper,RegConsignor;
        // }
        // field(2014269; "Consignor Language Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Consignor Language Code',
        //                 FRA = 'Code langue expéditeur';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = Language;
        // }
        // field(2014270; "Type of Origin"; Option)
        // {
        //     CaptionML = ENU = 'Type of Origin (Consignor)',
        //                 FRA = 'Type d''origine (Expéditeur)';
        //     Description = 'DITW15.00.00.38 #1217';
        //     OptionCaptionML = ENU = ' ,Tax Warehouse,Import',
        //                       FRA = ' ,Entrepôt fiscal,Import';
        //     OptionMembers = " ","Tax Warehouse",Import;
        // }
        // field(2014271; "Tax Warehouse Reference"; Text[20])
        // {
        //     CaptionML = ENU = 'Tax Warehouse Reference',
        //                 FRA = 'Entrepôt fiscal de référence';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014282; "Destination Type"; Option)
        // {
        //     CaptionML = ENU = 'Destination Type (Consignee)',
        //                 FRA = 'Type destination (Destinataire)';
        //     Description = 'DITW15.00.00.38 #1217 DIT711#112';
        //     OptionCaptionML = ENU = ' ,Tax Warehouse,Registered Consignee,Temporary Registered,Direct Delivery,Exempted Organisation,Export,,Unknow',
        //                       FRA = ' ,Entrepôt Fiscal,Destinataire enregistré,Temporaire Dest. enregistré,Livraison directe,Destinataire exempté,Exportation,,Inconnue';
        //     OptionMembers = " ",TaxWhse,RConsignee,TempReg,DirDelivry,ExemptOrg,Export,UndefineNotUse,Unknow;
        // }
        // field(2014410; "Address Position on Documents"; Option)
        // {
        //     CaptionML = ENU = 'Address Position on Documents',
        //                 FRA = 'Position Adresse sur le Document';
        //     Description = 'DITW17.00.02 DIT-770 #235';
        //     OptionCaptionML = ENU = 'Left,Right',
        //                       FRA = 'Gauche,Droite';
        //     OptionMembers = Left,Right;
        // }
        // field(2014411; "Barcode Position on Documents"; Option)
        // {
        //     CaptionML = ENU = 'Barcode Position on Documents',
        //                 FRA = 'Position Code a barre sur le Document';
        //     Description = 'DITW17.00.02 DIT-770 #235';
        //     OptionCaptionML = ENU = 'No Barcode,Left,Center,Right',
        //                       FRA = 'Pas de Code à parre,Gauche,Centre,Droite';
        //     OptionMembers = "No Barcode",Left,Center,Right;
        // }
        // field(2014420; "Default Printable Links"; Boolean)
        // {
        //     CaptionML = ENU = 'Default Printable Links',
        //                 FRA = 'Liens imprimables par défaut';
        //     Description = 'DITW16.00.00.41 #297';
        // }
        // field(2014460; "Tax Office Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Office Code',
        //                 FRA = 'Code Bureau de taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Office";
        // }
        // field(2014483; "Ecotax Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'Ecotax No.',
        //                 FRA = 'N° cot. emb.';
        //     Description = 'DITBE15.00.01.01-DITW15.00.00.38 #1191';
        // }
        // field(2014484; "Ecotax Release Text"; Text[80])
        // {
        //     CaptionML = ENU = 'Ecotax release Text',
        //                 FRA = 'Texte Exonération cot. emb.';
        //     Description = 'DITBE15.00.01.01-DITW15.00.00.38 #1191';
        // }
        // field(2014485; "Name LicenceKeeper"; Text[50])
        // {
        //     CaptionML = ENU = 'Name License Holder',
        //                 FRA = 'Nom détenteur de licence';
        //     Description = 'DITBE15.00.01.01-DITW15.00.00.38 #1191';
        // }
        // field(2029610; "Bank Name 2"; Text[30])
        // {
        //     CaptionML = ENU = 'Bank Name 2',
        //                 FRA = 'Nom de la banque 2';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029611; "Bank Account No. 2"; Text[50])
        // {
        //     CaptionML = ENU = 'Bank Account No. 2',
        //                 FRA = 'N° compte bancaire 2';
        //     Description = 'FINXL7.00.001, HEI.20';
        // }
        // field(2029612; "IBAN 2"; Code[50])
        // {
        //     CaptionML = ENU = 'IBAN 2',
        //                 FRA = 'IBAN 2';
        //     Description = 'FINXL7.00.001';

        //     trigger OnValidate();
        //     begin
        //         CheckIBAN("IBAN 2");
        //     end;
        // }
        // field(2029613; "SWIFT Code 2"; Code[20])
        // {
        //     CaptionML = ENU = 'SWIFT Code 2',
        //                 FRA = 'Code SWIFT 2';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029614; "Test Company Indication"; Boolean)
        // {
        //     CaptionML = ENU = 'Test Company Indication',
        //                 FRA = 'Indication société test';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029615; "Same Database"; Boolean)
        // {
        //     CaptionML = ENU = 'Same Database',
        //                 FRA = 'Même base';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2029616; "Master Company"; Text[30])
        // {
        //     CaptionML = ENU = 'Master Company',
        //                 FRA = 'Société principale';
        //     Description = 'FINXL8.00.001';
        //     TableRelation = Company;
        //     ValidateTableRelation = false;
        // }
        // field(2029617; "Master Database Server Name"; Text[80])
        // {
        //     CaptionML = ENU = 'Master Database Server Name',
        //                 FRA = 'Nom du serveur de la base de donnée principale';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2029618; "Master Database Name"; Text[80])
        // {
        //     CaptionML = ENU = 'Master Database Name',
        //                 FRA = 'Nom de la base de donnée principale';
        //     Description = 'FINXL8.00.001';
        //     //BC Upgarde KAPOOV01>>
        //     // trigger OnLookup();
        //     // begin
        //     //     //<<FINXL8.00.001 DAT 07/09/2015
        //     //     if "Master Database Server Name" <> '' then
        //     //         cduMasterExportMgmt.fctLookupDBName("Master Database Server Name", "Master Database Name");
        //     //     //>>FINXL8.00.001 DAT 07/09/2015
        //     // end;
        //     //BC Upgarde KAPOOV01<<
        //     //BC Upgarde KAPOOV01>>
        //     // trigger OnValidate();
        //     // var
        //     //     ltxtNotNavDB: TextConst ENU = 'Database "%1" is not a NAV Database ', FRA = 'La Base de Données "%1" n''est pas une Base de Données NAV ';
        //     // begin
        //     //     //<<FINXL8.00.001 DAT 07/09/2015
        //     //     if ("Master Database Name" <> '') and
        //     //       not cduMasterExportMgmt.fctIsNAVDatabase("Master Database Server Name", "Master Database Name") then
        //     //         ERROR(ltxtNotNavDB, "Master Database Name");
        //     //     "Master Database Company Name" := '';
        //     //     //>>FINXL8.00.001 DAT 07/09/2015
        //     // end;
        //     //BC Upgarde KAPOOV01<<
        // }
        // field(2029619; "Master Database Company Name"; Text[80])
        // {
        //     CaptionML = ENU = 'Master Database Company Name',
        //                 FRA = 'Nom société  de la base de donnée principale';
        //     Description = 'FINXL8.00.001';
        //     //BC Upgarde KAPOOV01>>
        //     // trigger OnLookup();
        //     // begin
        //     //     //<<FINXL8.00.001 DAT 07/09/2015
        //     //     if ("Master Database Server Name" <> '') and ("Master Database Name" <> '') then
        //     //         cduMasterExportMgmt.fctLookupCompanyName("Master Database Server Name", "Master Database Name", "Master Database Company Name");
        //     //     //>>FINXL8.00.001 DAT 07/09/2015
        //     // end;
        //     //BC Upgarde KAPOOV01<<
        // }
        // field(2029620; "Master Database Login"; Text[80])
        // {
        //     CaptionML = ENU = 'Master Database Login',
        //                 FRA = 'Login  base de donnée principale';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2029621; "Master Database Password"; Text[80])
        // {
        //     CaptionML = ENU = 'Master Database Password',
        //                 FRA = 'Mot de passe  base de donnée principale';
        //     Description = 'FINXL8.00.001';
        //     ExtendedDatatype = Masked;
        // }
        // field(2030011; "Interface Partner"; Code[50])
        // {
        //     CaptionML = ENU = 'Interface Partner',
        //                 FRA = 'Interface Partenaire';
        //     Description = 'IPLXL9.00.001';
        //     TableRelation = "Interface Partner";
        // }
        //BC Upgrade KAPOOV01 <<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=The number that you entered may not be a valid International Bank Account Number (IBAN). Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=The number that you entered may not be a valid International Bank Account Number (IBAN). Do you want to continue?;FRA=Le numéro entré n'est peut-être pas un numéro de compte bancaire international (IBAN) valide. Voulez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=File Location for IC files;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=File Location for IC files;FRA=Emplacement des fichiers IC;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;FRA=Avant de pouvoir utiliser Online Map, vous devez compléter la fenêtre Configuration Online Map.\Consultez la section Configuration d'Online Map dans l'Aide.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "NoPaymentInfoQst(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NoPaymentInfoQst : @@@="%1 = Company Information";ENU=No payment information is provided in %1. Do you want to update it now?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoPaymentInfoQst : @@@="%1 = Company Information";ENU=No payment information is provided in %1. Do you want to update it now?;FRA=Aucune information de paiement n'est fournie dans %1. Souhaitez-vous le mettre à jour maintenant ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "NoPaymentInfoMsg(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NoPaymentInfoMsg : ENU=No payment information is provided in %1. Review the report.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoPaymentInfoMsg : ENU=No payment information is provided in %1. Review the report.;FRA=Aucune information de paiement n'est fournie dans %1. Vérifiez l'état.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "GLNCheckDigitErr(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //GLNCheckDigitErr : ENU=The %1 is not valid.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GLNCheckDigitErr : ENU=The %1 is not valid.;FRA=%1 non valide.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DevBetaModeTxt(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DevBetaModeTxt : @@@={Locked};ENU=DEV_BETA;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DevBetaModeTxt : @@@={Locked};ENU=DEV_BETA;FRA=DEV_BETA;
    //Variable type has not been exported.
    //BC Upgrade KAPOOV01>>
    procedure GetPartyID() ReturnValue: Code[18]
    var
        myInt: Integer;
    begin
        //HEI.14>>
        EXIT("Country/Region Code" + GetControlSum() + "Registration No.");
        //HEI.14<<  
    end;

    Local procedure GetControlSum() ReturnValue: Text[2]
    var
        ControlSum: Integer;
    begin
        //HEI.14>>
        ControlSum := (12 + 3 * (GetSIREN() MOD 97)) MOD 97;
        EXIT(FORMAT(ControlSum, 0, '<Integer,2><Filler,0>'));
        //HEI.14<<
    end;

    procedure GetSIREN() Result: Integer
    var
        myInt: Integer;
    begin
        //HEI.14>>
        EVALUATE(Result, COPYSTR(DELCHR("Registration No."), 1, 9));
        //HEI.14<< 
    end;

    local procedure IBANError()
    var
        myInt: Integer;
    begin
        //HEI.03>>
        //IF NOT CONFIRM(Text000) THEN
        //  ERROR('');
        IF GUIALLOWED THEN BEGIN
            IF NOT CONFIRM(Text000) THEN
                ERROR('');
        end else
            ERROR(IBANNotValidErr);
        //HEI.03<<
    end;
    //BC Upgrade KAPOOV01<<

    var
        PostCode: Record "Post Code";
        EnterpriseNoMgt: Codeunit VATLogicalTests;
        //cduMasterExportMgmt: Codeunit "Master Export Management";//BC Upgarde KAPOOV01
        IBANNotValidErr: Label 'The number that you entered is not a valid International Bank Account Number (IBAN).';
        Text000: Label 'The number that you entered may not be a valid International Bank Account Number (IBAN). Do you want to continue?';
        Text50000: TextConst ENU = '%1 is not valid.', FRB = '%1 n''est pas valide.', NLB = '%1 is niet geldig.';
}

