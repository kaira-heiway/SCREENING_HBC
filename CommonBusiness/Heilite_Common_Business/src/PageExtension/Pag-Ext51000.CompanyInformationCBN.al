pageextension 51000 CompanyInformationExtCBN extends "Company Information"
{
    // version NAVW110.0.00.16585,FINXL8.00.001,IPLXL9.00.001,DITW110.00.08,HEI.21
    // DITW15.00.00.26 DDR 21/11/2008 Added Drink-It tab
    //                                Added field "Company Cashier" into tab Drink-It
    // DITW15.00.00.28 DDR 24/11/2008 Added fields into tab Drink-It
    //                                 "ADD Responsible No.","TAX Registration No.","ADD Nos.",
    //                                 "Qualified Authority","Authority Address","Authority City","Authority Post Code"
    //                                Added menu "AAD Responsibles" into button Company
    // DITW15.00.00.32 DDR 03/04/2009 Correct Drink-It Captions
    //                                 ("AAD Responsible No.","Tax Registration No.","AAD Nos.")
    // DITW15.00.00.35 DDR 13/10/2009 issue 590 Added field "AAD Copies" into tab Drink-It
    // DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Removed (Qualified authority) fields (data moved into table 2014423 Tax Office)
    //                                  Added fields into tab Drink-It
    //                                    "Tax Office Code","Consignor Type","Consignor Language Code","Tax Warehouse Reference"
    //                     05/10/2010   Added fields into tab Drink-It
    //                                    "Type of Origin","Destination Type"
    // DITW16.00.00.37 DDR 25/02/2011 DIT-715 #1 Upgrade RTC Page functionnalities
    //                                  Modified Post Code/City Tax Office controls (align on page)
    // DITW16.00.00.38 DDR 08/03/2011 DIT-715 #1 RTC Upgrade NAVW16.00.10 GetSystemIndicator
    //                     16/03/2011 issue 1191 Added fields into tab Drink-It
    //                                  "Ecotax Registration No.","Ecotax Release Text","Name LicenceKeeper"
    // DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 General Functionnality
    //                                             Added 'Links' tab
    //                                             Added fields "Default Printable Link"

    // FINXL7.00.001 RBE 20/03/2013 : Standard Documents
    //                                Added Tab "Payments 2" & Additional fields
    //                                Added "Registration No." to "Other" Tab
    // FINXL8.00.001 DAT 19/06/2015 #223 : Added Tab "Master Information and Fields "Same Database" , "Master Company" , "Master URL"
    // FINXL8.00.001 DAT 07/09/2015 : Added fields "Master Database Server Name" , "Master Database Name" , "Master Database Company Name"
    //                                "Master Database Login" , "Master Database Password"

    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.00.02 RPG 05/11/2013 DIT-770 #235 Added New Fields "Address Position on Documents", "Barcode Position on Documents" on Drink-It Fasttab
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // IPLXL9.00.001 IMI 04/08/2015: Added field "Interface Partner"
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // HEI.01 #FDD-GAPID013-19/07/2017
    // Field language code added by PATHAA02

    // HEI.02 FDD RTRGAP062 Heilite BASE IBM ISYED01 04/08/2017 HeiMatch Flatfile
    //   # Added field for Reporting Entity
    // HEI.03 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New fields for MDM integration: "WHT Registration ID", "RDO Code"
    // HEI.04 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added added new field "Business Type" to page
    // HEI.05 FDD-GAPLOG006 IBM ISYED01 12.07.2017 # Algerai Local
    //   # Added Fields “Cap. Social” to page.

    // HEI.07 FDD-MZ-PRDGAP001 IBM Isyed01 11.20.2018
    //   # Added new field's Invoice name,Invoice Address, Invoice City,Invoice Postcode to the page.
    // HEI.08 RFC-CHG0264787 IBM.LS 17.12.2018
    //   # New Field added: "OpCo Logo"
    // HEI.09 V1.05 HT84 IBM POENAB02 28.03.2019
    //   # New group: Other
    //   # New field in Other Group: "Enterprise No."
    // HEI.10 HT476 CHG2011084 IBM GAVANM01 17.07.2019
    //   # New Field added: "OpCo Footer image"
    // HEI.11 FDD-IC-PROGAP BRD HT417 IBM ISYED01 PO invoice layout
    //   # new filed created :RCCM Legal entity code
    // HEI.12 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New fields:
    //     # 50019 Enable French Localization in General tab
    //   # New group "Trade Register", with fields "Registration No.", "APE Code", "Legal Form", "Stock Capital", CISD
    // HEI.13 FDD-HT935 IBM POSTOI01 # Purchase Order Layout Burundi
    //   # New field showed: 50020 - PO Legal Text Box E-Mail Text 80
    // HEI.14 FDD-HT935 IBM POSTOI01 # Purchase Order Layout Burundi
    //   # create new tab Additional Address Information
    //   # Show fields created:
    //     50021 - Add. Address Text 50
    //   50022Add. CityText30
    //   50023Add. Phone No.Text30
    //   50024Add. Post CodeCode20
    // HEI.15 FDD-HT935 IBM POSTOI01 # Purchase Order Layout Burundi
    //   # Show fields created in Shipping tab:
    //     50025 - plant Opening Hrs. Text 30
    // HEI.16 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //   # New Field added "Signature Image" for report layouts
    // HEI.17 CHG2085435 IBM GAVANM01 25.11.2020 - HT1773 Sales documents layout
    //   # new fields added: "Currency" in Payment tab and "Currency 2" in Payment 2 tab
    // HEI.18 CHG2105033 BULIMC01 IBM 05.11.2021#new field added to General tab - "Opco Code for CFAO"
    // HEI.19 CHG2127496 SHIVAS05 IBM 24/12/2021#new field added to Other tab - "Save Payment Sheet"
    // HEI.20 CHG2127496 SHIVAS05 IBM 08/02/2022#Removing- "Save Payment Sheet"
    // HEI.21 CHG2244079 IBM VERMAA03 13.06.2024 HB3802 Remittance advice – Spanish translation
    //   #new field added to communication tab - "Account Payable Email"

    //Bc Upgrade YADAVM09 Drink it field blocked 
    //#APE Code
    //#Legal Form
    //#Stock Capital
    //#CISD
    //Bc Upgrade YADAVM09 addafter("Registration No.") added to handle Drink it field blocked issue.

    // BC Upgrade SHUKLP03 >> Testscript OTC221 - Added new field "Address Position on Documents", Bank Account No. 2, IBAN 2, SWIFT Code 2, Currency 2 and new group "Payments 2" in Payment FastTab.

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the company''s name and corporate form. For example, Inc. or Ltd.', FRA = 'Spécifie le nom de la société et sa raison sociale. Par exemple, S.A. ou SARL.';
        }
        modify(Address)
        {
            ToolTipML = ENU = 'Specifies the company''s address.', FRA = 'Spécifie l''adresse de la société.';
        }
        modify("Address 2")
        {
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';
        }
        modify("Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify(City)
        {
            ToolTipML = ENU = 'Specifies the company''s city.', FRA = 'Spécifie la ville de la société.';
        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region of the address.', FRA = 'Spécifie le pays/la région de l''adresse.';
        }
        modify("Phone No.")
        {
            ToolTipML = ENU = 'Specifies the company''s telephone number.', FRA = 'Spécifie le numéro de téléphone de la société.';
        }
        modify("VAT Registration No.")
        {
            ToolTipML = ENU = 'Specifies the company''s VAT registration number.', FRA = 'Spécifie le n° identif. intracomm. de la société.';
        }
        modify(GLN)
        {
            ToolTipML = ENU = 'Specifies your company in connection with electronic document exchange.', FRA = 'Spécifie votre société en relation avec l''échange de documents électroniques.';
        }
        modify("Industrial Classification")
        {
            ToolTipML = ENU = 'Specifies the company''s industrial classification code.', FRA = 'Spécifie le code classification industrielle de la société.';
        }
        modify(Picture)
        {
            ToolTipML = ENU = 'Specifies the picture that has been set up for the company, such as a company logo.', FRA = 'Spécifie l''image qui a été créée pour la société, telle qu''un logo.';
        }
        modify(Communication)
        {
            CaptionML = ENU = 'Communication', FRA = 'Communication';
        }
        modify("Phone No.2")
        {
            ToolTipML = ENU = 'Specifies the company''s telephone number.', FRA = 'Spécifie le numéro de téléphone de la société.';
        }
        modify("Fax No.")
        {
            ToolTipML = ENU = 'Specifies the company''s fax number.', FRA = 'Spécifie le numéro de télécopie de la société.';
        }
        modify("E-Mail")
        {
            ToolTipML = ENU = 'Specifies the company''s email address.', FRA = 'Spécifie l''adresse de messagerie de la société.';
        }
        modify("Home Page")
        {
            ToolTipML = ENU = 'Specifies the company''s home page address.', FRA = 'Spécifie la page d''accueil de la société.';
        }
        // modify("IC Partner Code")
        // {
        //     ToolTipML = ENU = 'Specifies your company''s intercompany partner code.', FRA = 'Spécifie le code partenaire intersociété de votre société.';
        // }
        // modify("IC Inbox Type")
        // {
        //     ToolTipML = ENU = 'Specifies what type of intercompany inbox you have, either File Location or Database.', FRA = 'Spécifie le type de boîte de réception intersociété que vous avez : Emplacement du fichier ou Base de données.';
        // }
        // modify("IC Inbox Details")
        // {
        //     ToolTipML = ENU = 'Specifies details about the location of your intercompany inbox, which can transfer intercompany transactions into your company.', FRA = 'Spécifie des informations sur l''emplacement de votre boîte de réception intersociété, qui peut transférer des transactions intersociété dans votre société.';
        // }  // BC Upgrade NANDIS03
        modify(Payments)
        {
            CaptionML = ENU = 'Payments', FRA = 'Paiements';
        }
        modify("Allow Blank Payment Info.")
        {
            ToolTipML = ENU = 'Specifies if you are allowed to create a sales invoice without filling the setup fields on this FastTab.', FRA = 'Spécifie si vous êtes autorisé à créer une facture vente sans remplir les champs de configuration sur ce raccourci.';
        }
        modify("Bank Name")
        {
            ToolTipML = ENU = 'Specifies the name of the bank the company uses.', FRA = 'Spécifie le nom de la banque avec laquelle la société travaille.';
        }
        modify("Bank Branch No.")
        {
            ToolTipML = ENU = 'Specifies the bank''s branch number.', FRA = 'Spécifie le numéro de l''établissement de la banque.';
        }
        modify("Bank Account No.")
        {
            ToolTipML = ENU = 'Specifies the company''s bank account number.', FRA = 'Spécifie le numéro du compte bancaire de la société.';

            //Unsupported feature: Change SubPageLink on ""Bank Account No."(Control 20)". Please convert manually.

        }
        modify("Payment Routing No.")
        {
            ToolTipML = ENU = 'Specifies the company''s payment routing number.', FRA = 'Spécifie le numéro de paiement automatique de la société.';
        }
        modify("Giro No.")
        {
            ToolTipML = ENU = 'Specifies the company''s giro number.', FRA = 'Spécifie le numéro de CCP de la société.';
        }
        modify("SWIFT Code")
        {
            ToolTipML = ENU = 'Specifies the SWIFT code (international bank identifier code) of your primary bank.', FRA = 'Spécifie le code SWIFT (code international d''identification bancaire) de votre banque principale.';
        }
        modify(IBAN)
        {
            ToolTipML = ENU = 'Specifies the international bank account number of your primary bank account.', FRA = 'Spécifie le numéro international de votre compte bancaire principal.';
        }
        modify(BankAccountPostingGroup)
        {
            CaptionML = ENU = ' Bank Account Posting Group', FRA = ' Groupe compta. banque';
            ToolTipML = ENU = 'Specifies a code for the bank account posting group for the company''s bank account.', FRA = 'Spécifie un code pour le groupe comptabilisation banque du compte bancaire de la société.';
        }
        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping', FRA = 'Livraison';
        }
        modify("Ship-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the location to which items for the company should be shipped.', FRA = 'Spécifie le nom du magasin où les articles de la société doivent être livrés.';
        }
        modify("Ship-to Address")
        {
            ToolTipML = ENU = 'Specifies the address of the location to which items for the company should be shipped.', FRA = 'Spécifie l''adresse du magasin où les articles de la société doivent être livrés.';
        }
        modify("Ship-to Address 2")
        {
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';
        }
        modify("Ship-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify("Ship-to City")
        {
            ToolTipML = ENU = 'Specifies the city of the address.', FRA = 'Spécifie la ville de l''adresse.';
        }
        modify("Ship-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the address.', FRA = 'Spécifie le code pays/la région de l''adresse.';
        }
        modify("Ship-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the contact person to whom items for the company should be shipped.', FRA = 'Spécifie le nom de la personne contact à laquelle les articles de la société doivent être livrés.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location code that corresponds to the company''s ship-to address.', FRA = 'Spécifie le code magasin qui correspond à l''adresse destinataire de la société.';
        }
        modify("Responsibility Center")
        {
            ToolTipML = ENU = 'Specifies the code for the default responsibility center.', FRA = 'Spécifie le code pour le centre de gestion par défaut.';
        }
        modify("Check-Avail. Period Calc.")
        {
            ToolTipML = ENU = 'Specifies a date formula that defines the length of the period after the planned shipment date on demand lines in which the system checks availability for the demand line in question.', FRA = 'Spécifie une formule date qui définit la durée de la période après la date d''expédition planifiée sur les lignes demande dans lesquelles le système vérifie la disponibilité de la ligne demande en question.';
        }
        modify("Check-Avail. Time Bucket")
        {
            ToolTipML = ENU = 'Specifies how frequently the system checks supply-demand events to discover if the item on the demand line is available on its shipment date.', FRA = 'Spécifie à quelle fréquence le système vérifie des événements offre-demande pour découvrir si l''article sur la ligne demande est disponible à sa date d''expédition.';
        }
        modify("Base Calendar Code")
        {
            ToolTipML = ENU = 'Specifies the code for the base calendar that you want to assign to your company.', FRA = 'Spécifie le code du calendrier principal que vous souhaitez affecter à votre société.';
        }
        modify("Customized Calendar")
        {
            CaptionML = ENU = 'Customized Calendar', FRA = 'Calendrier personnalisé';
            ToolTipML = ENU = 'Specifies whether or not your company has set up a customized calendar.', FRA = 'Indique si votre société a configuré un calendrier personnalisé.';
        }
        modify("Cal. Convergence Time Frame")
        {
            ToolTipML = ENU = 'Specifies how dates based on calendar and calendar-related documents are calculated.', FRA = 'Spécifie comment sont calculées les dates basées sur le calendrier et les documents qui s''y rapportent.';
        }
        // modify("System Indicator")
        // {
        //     CaptionML = ENU = 'System Indicator', FRA = 'Indicateur système';
        // }
        // modify("System Indicator")
        // {
        //     ToolTipML = ENU = 'Specifies how you want to use the system indicator when you are working with different versions of Microsoft Dynamics NAV.', FRA = 'Spécifie comment utiliser l''indicateur système lorsque vous utilisez différentes versions de Microsoft Dynamics NAV.';
        // }  // BC Upgrade NANDIS03
        modify("System Indicator Style")
        {
            ToolTipML = ENU = 'Specifies if you want to apply a certain style to the system indicator.', FRA = 'Spécifie si vous voulez appliquer un certain style à l''indicateur système.';
        }
        modify("System Indicator Text")
        {
            CaptionML = ENU = 'System Indicator Text', FRA = 'Texte indicateur système';
        }
        // modify(Control38)
        // {
        //     CaptionML = ENU = 'User Experience', FRA = 'Expérience utilisateur';
        // }
        // modify(Experience)
        // {
        //     CaptionML = ENU = 'Experience', FRA = 'Expérience';
        //     ToolTipML = ENU = 'Specifies for which application areas fields and actions are shown in the user interface. This is a way to simplify the product by hiding UI elements for features that you do not use.', FRA = 'Spécifie pour quels domaines d''application des actions et des champs sont affichés dans l''interface utilisateur. C''est une manière de simplifier le produit en masquant des éléments d''IU pour des fonctionnalités que vous n''utilisez pas.';
        //     OptionCaptionML = ENU = ',,,,,Basic,,,,,,,,,,Suite', FRA = ',,,,,Basique,,,,,,,,,,Suite';
        // }  // BC Upgrade NANDIS03
        addafter("Post Code")
        {
            field("Legal Entity Code"; Rec."Legal Entity Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Legal Entity Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Legal Entity Code field.';

            }
            field("RCCM Legal entity code"; Rec."RCCM Legal entity code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RCCM Legal entity code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the RCCM Legal entity code field.';

            }
            //BC UPGRADE KUMARR78 << 18-06-2026
            field("Legal Form FND"; Rec."Legal Form FND")
            {
                ApplicationArea = All;
                Caption = 'Legal Form';
            }
            //BC UPGRADE KUMARR78 >> 18-06-2026

        }
        addafter("Industrial Classification")
        {
            field("OpCo Logo"; Rec."OpCo Logo FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the OpCo Logo field.';
            }
        }
        addafter(Picture)
        {
            // field("Interface Partner"; Rec."Interface Partner")
            // {
            //     Description = 'IPLXL9.00.001';
            // }  // BC Upgrade NANDIS03
            field("Language Code"; Rec."Language Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Language Code field.';
                // BC Upgrade NANDIS03                                                                                                                                                                                                   ToolTip = 'Specifies the value of the Language Code field.';

            }
            field("WHT Registration ID"; Rec."WHT Registration ID FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Registration ID field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the WHT Registration ID field.';

            }
            field("RDO Code"; Rec."RDO Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RDO Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the RDO Code field.';

            }
            field("Cap. Social"; Rec."Cap. Social FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cap. Social field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Cap. Social field.';

            }
            field("OpCo Footer image"; Rec."OpCo Footer image FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the OpCo Footer image field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the OpCo Footer image field.';

            }
            field("Signature Image"; Rec."Signature Image FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Signature Image field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Signature Image field.';

            }
            field("Enable French Localization"; Rec."Enable French Localization FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable French Localization field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Enable French Localization field.';

            }
            field("OpCo Code for CFAO"; Rec."OpCo Code for CFAO FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the OpCo Code for CFAO field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the OpCo Code for CFAO field.';

            }
        }
        // BC Upgrade SHUKLP03 >> Testscript OTC221
        addafter("OpCo Code for CFAO")
        {
            field("Address Position on Documents"; Rec."Address Position on Docs FND")
            {
                ApplicationArea = All;
            }
        }
        // BC Upgrade SHUKLP03 << Testscript OTC221

        // addafter("IC Inbox Type")
        // {
        //     field("Telex Answer Back"; Rec."Telex Answer Back")
        //     {
        //         CaptionML = ENU = 'Telex Answer Back',
        //                     FRA = 'N.I.S';
        //     }
        // }  // BC Upgrade NANDIS03
        //addafter("IC Inbox Details")  // BC Upgrade NANDIS03
        addafter("Home Page")  // BC Upgrade NANDIS03
        {
            field("PO Legal Text Box E-Mail"; Rec."PO Legal Text Box E-Mail FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PO Legal Text Box E-Mail field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the PO Legal Text Box E-Mail field.';

            }
            field("Account Payable Email"; Rec."Account Payable Email FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Account Payable Email field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Account Payable Email field.';

            }
            group("Additional Address Information")
            {
                Caption = 'Additional Address Information';
                field("Add. Address"; Rec."Add. Address FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Add. Address field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Add. Address field.';

                }
                field("Add. City"; Rec."Add. City FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Add. City field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Add. City field.';

                }
                field("Add. Phone No."; Rec."Add. Phone No. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Add. Phone No. field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Add. Phone No. field.';

                }
                field("Add. Post Code"; Rec."Add. Post Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Add. Post Code field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Add. Post Code field.';

                }
            }
            group("Invoice deliver address")
            {
                CaptionML = ENU = 'Invoice deliver address',
                            FRA = 'Communication';
                field("Invoice Name"; Rec."Invoice Name FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice Name field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Invoice Name field.';

                }
                field("Invoice Address"; Rec."Invoice Address FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice Address field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Invoice Address field.';

                }
                field("Invoice Address2"; Rec."Invoice Address2 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice Address2 field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Invoice Address2 field.';

                }
                field("Invoice City"; Rec."Invoice City FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice City field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Invoice City field.';

                }
                field("Invoice Post Code"; Rec."Invoice Post Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice Post Code field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Invoice Post Code field.';

                }
            }
        }
        addafter(BankAccountPostingGroup)
        {
            field(Currency; Rec."Currency FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Currency field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Currency field.';

            }
        }
        addafter(Shipping)
        {
            group("Payments 2")
            {
                CaptionML = ENU = 'Payments 2',
                            FRA = 'Paiements 2';
                // BC Upgrade SHUKLP03 >> Testscript => Added new fields in Payments 2 group
                field("Bank Name 2"; Rec."Bank Name 2 FND")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No. 2"; Rec."Bank Account No. 2 FND")
                {
                    ApplicationArea = All;
                }
                field("IBAN 2"; Rec."IBAN 2 FND")
                {
                    ApplicationArea = All;
                }
                field("SWIFT Code 2"; Rec."SWIFT Code 2 FND")
                {
                    ApplicationArea = All;
                }  // BC Upgrade NANDIS03
                   // BC Upgrade SHUKLP03 << Testscript => Added new fields in Payments 2 group
                field("Currency 2"; Rec."Currency 2 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency 2 field.';
                    // BC Upgrade NANDIS03                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              ToolTip = 'Specifies the value of the Currency 2 field.';

                }
            }
            group(Control2029617)
            {
                CaptionML = ENU = 'Shipping',
                            FRA = 'Livraison';
                Description = 'FINXL7.00.001';
            }
        }
        addafter("Ship-to Name")
        {
            field("Ship-to Name 2"; Rec."Ship-to Name 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ship-to Name 2 field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Ship-to Name 2 field.';

            }
        }
        addafter("Cal. Convergence Time Frame")
        {
            field("Plant Opening Hrs."; Rec."Plant Opening Hrs. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Plant Opening Hrs. field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Plant Opening Hrs. field.';

            }
            // group("Trade Register")  // BC FR Upgrade KAIRAR01
            // {
            //     CaptionML = ENU = 'Trade Register',
            //                 FRA = 'Registre du commerce';
            // field("Registration No."; Rec."Registration No.")
            // {
            //     ApplicationArea = Basic, Suite;
            // }  // BC Upgrade NANDIS03

            /* //Bc Upgrade YADAVM09 Drink it field blocked>>
            field("APE Code"; Rec."APE Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTipML = ENU = 'Specifies the company''s APE code.',
                            FRA = 'Spécifie le code APE de la société.';
            }
            field("Legal Form"; Rec."Legal Form")
            {
                ApplicationArea = Basic, Suite;
                ToolTipML = ENU = 'Specifies the company''s legal form, for example, SA or SARL.',
                            FRA = 'Spécifie la forme juridique de la société, par exemple SA ou SARL.';
            }
            field("Stock Capital"; Rec."Stock Capital")
            {
                ApplicationArea = Basic, Suite;
                ToolTipML = ENU = 'Specifies the stock capital of the company.',
                            FRA = 'Spécifie le capital social de la société.';
            }
            field(CISD; Rec.CISD)
            {
                ApplicationArea = Basic, Suite;
                ToolTipML = ENU = 'Specifies the public organization in France that handles the EU Sales List and Intrastat declaration.',
                            FRA = 'Spécifie l''organisation publique en France qui traite la déclaration de liste des ventes intracommunautaires et la déclaration D.E.B (Intrastat).';
            }
            */ //Bc Upgrade YADAVM09 Drink it field blocked<<
            // }
        }
        addafter("System Indicator")
        {
            group(Links)
            {
                CaptionML = ENU = 'Links',
                            FRA = 'Liens';
                // field("Default Printable Links"; Rec."Default Printable Links")
                // {
                // }  // BC Upgrade NANDIS03
            }
            group("Drink-It")
            {
                CaptionML = ENU = 'Drink-It',
                            FRA = 'Drink-It';
                //     field("Company Cashier"; Rec."Company Cashier")
                //     {
                //     }
                //     field("Tax Registration No."; Rec."Tax Registration No.")
                //     {
                //     }
                //     field("Tax Office Code"; Rec."Tax Office Code")
                //     {

                //         trigger OnValidate();
                //         begin
                //             TaxOfficeCodeOnAfterValidate;
                //         end;
                //     }
                //     field("TaxOffice.Name"; Rec.TaxOffice.Name)
                //     {
                //         CaptionML = ENU = 'Name',
                //                     FRA = 'Nom';
                //         Editable = false;
                //     }
                //     field("TaxOffice.Address"; Rec.TaxOffice.Address)
                //     {
                //         CaptionML = ENU = 'Address',
                //                     FRA = 'Adresse';
                //         Editable = false;
                //     }
                //     field("TaxOffice.""Post Code"""; Rec.TaxOffice."Post Code")
                //     {
                //         CaptionML = ENU = 'Post Code',
                //                     FRA = 'Code postal';
                //         Editable = false;
                //     }
                //     field("TaxOffice.City"; Rec.TaxOffice.City)
                //     {
                //         CaptionML = ENU = 'City',
                //                     FRA = 'Ville';
                //         Editable = false;
                //     }
                //     field("TaxOffice.""Country/Region Code"""; Rec.TaxOffice."Country/Region Code")
                //     {
                //         CaptionML = ENU = 'Country/Region Code',
                //                     FRA = 'Code pays/région';
                //         Editable = false;
                //     }
                //     field("Tax Warehouse Reference"; Rec."Tax Warehouse Reference")
                //     {
                //     }
                //     field("Ecotax Registration No."; Rec."Ecotax Registration No.")
                //     {
                //     }
                //     field("Ecotax Release Text"; Rec."Ecotax Release Text")
                //     {

                //         trigger OnAssistEdit();
                //         begin
                //             // <<DITBE5.00.01.01 DDR 05/02/2009
                //             rText1Transl.FILTERGROUP(2);
                //             rText1Transl.SETRANGE("Table No.", DATABASE::"Company Information");
                //             rText1Transl.SETRANGE(Code, "Primary Key");
                //             rText1Transl.SETRANGE("Line No.", 0);
                //             PAGE.RUNMODAL(0, rText1Transl);
                //         end;
                //     }
                //     field("Name LicenceKeeper"; Rec."Name LicenceKeeper")
                //     {

                //         trigger OnAssistEdit();
                //         begin
                //             // <<DITBE5.00.01.01 DDR 13/02/2009
                //             rText1Transl.FILTERGROUP(2);
                //             rText1Transl.SETRANGE("Table No.", DATABASE::"Company Information");
                //             rText1Transl.SETRANGE(Code, "Primary Key");
                //             rText1Transl.SETRANGE("Line No.", 1);
                //             PAGE.RUNMODAL(0, rText1Transl);
                //         end;
                //     }
                //     field("AAD Copies"; Rec."AAD Copies")
                //     {
                //     }
                //     field("AAD Nos."; Rec."AAD Nos.")
                //     {
                //     }
                //     field("AAD Responsible No."; Rec."AAD Responsible No.")
                //     {
                //     }
                //     field("Consignor Type"; Rec."Consignor Type")
                //     {
                //     }
                //     field("Consignor Language Code"; Rec."Consignor Language Code")
                //     {
                //     }
                //     field("Type of Origin"; Rec."Type of Origin")
                //     {
                //     }
                //     field("Destination Type"; Rec."Destination Type")
                //     {
                //     }
                //     field("Address Position on Documents"; Rec."Address Position on Documents")
                //     {
                //     }
                //     field("Barcode Position on Documents"; Rec."Barcode Position on Documents")
                //     {
                //     }
                // }
                // group("Master Information")
                // {
                //     CaptionML = ENU = 'Master Information',
                //                 FRA = 'Information principale';
                //     field("Same Database"; Rec."Same Database")
                //     {

                //         trigger OnValidate();
                //         begin
                //             fctEnableMasterURL;//FINXL8.00.001 DAT 19/06/2015
                //         end;
                //     }
                //     field("Master Company"; Rec."Master Company")
                //     {
                //         Enabled = NOT blnEnableMasterURL;
                //     }
                //     group(Control2029620)
                //     {
                //         Enabled = blnEnableMasterURL;
                //         field("Master Database Server Name"; Rec."Master Database Server Name")
                //         {
                //             Enabled = blnEnableMasterURL;

                //             trigger OnDrillDown();
                //             begin
                //                 //<<FINXL8.00.001 DAT 07/09/2015
                //                 "Master Database Server Name" := cduMasterExportManagement.fctGetServerName();
                //                 //>>FINXL8.00.001 DAT 07/09/2015
                //             end;
                //         }
                //         field("Master Database Name"; Rec."Master Database Name")
                //         {
                //             Enabled = blnEnableMasterURL;
                //         }
                //         field("Master Database Company Name"; Rec."Master Database Company Name")
                //         {
                //             Enabled = blnEnableMasterURL;
                //         }
                //         field("Master Database Login"; Rec."Master Database Login")
                //         {
                //             Enabled = blnEnableMasterURL;
                //         }
                //         field("Master Database Password"; Rec."Master Database Password")
                //         {
                //             Enabled = blnEnableMasterURL;
                //         }
                //     }  // BC Upgrade NANDIS03
            }
        }
        //addafter(Control38)  // BC Upgrade NANDIS03
        // addafter(CISD)  // BC Upgrade NANDIS03//Bc Upgrade YADAVM09 Blocked to handle Drink it field'CISD'
        addafter("Registration No.")//Bc Upgrade YADAVM09 Added
        {
            group(CIL)
            {
                Caption = 'CIL';
                Description = 'HEI1.0,EDD072';
                field("Reporting Entity"; Rec."Reporting Entity FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reporting Entity field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Reporting Entity field.';

                }
                field("Business Type"; Rec."Business Type FND")
                {
                    ApplicationArea = All;  // BC Upgrade NANDIS03
                    Description = 'HEI1.0,EDD072';
                    ToolTip = 'Specifies the value of the Business Type field.';
                }
            }
            group(Other)
            {
                Caption = 'Other';
                field("Enterprise No."; Rec."Enterprise No. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enterprise No. field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Enterprise No. field.';

                }
            }
        }
    }
    actions
    {
        modify("Responsibility Centers")
        {
            CaptionML = ENU = 'Responsibility Centers', FRA = 'Centres de gestion';
            ToolTipML = ENU = 'Set up responsibility centers to administer business operations that cover multiple locations, such as a sales offices or a purchasing departments.', FRA = 'Configurez des centres de gestion pour administrer les opérations d''entreprise qui couvrent plusieurs emplacements, tels que bureaux de vente ou départements des achats.';
        }
        modify("Report Layouts")
        {
            CaptionML = ENU = 'Report Layouts', FRA = 'Présentations état';
            ToolTipML = ENU = 'Specify the layout to use on reports when viewing, printing, and saving them. The layout defines things like text font, field placement, or background.', FRA = 'Spécifiez la disposition à utiliser sur des rapports lors de leur affichage, impression et enregistrement. La disposition définit des éléments tels que la police, l''emplacement du champ ou l''arrière-plan.';
        }
        modify("Application Settings")
        {
            CaptionML = ENU = 'Application Settings', FRA = 'Paramètres application';
        }
        modify(Setup)
        {
            CaptionML = ENU = 'Setup', FRA = 'Paramètres';
        }
        modify("General Ledger Setup")
        {
            CaptionML = ENU = 'General Ledger Setup', FRA = 'Paramètres comptabilité';
            ToolTipML = ENU = 'Define your general accounting policies, such as the allowed posting period and how payments are processed. Set up your default dimensions for financial analysis.', FRA = 'Définissez vos stratégies comptables générales, comme la période de validation autorisée et le mode de traitement des paiements. Configurez vos axes analytiques par défaut pour l''analyse financière.';
        }
        modify("Sales & Receivables Setup")
        {
            CaptionML = ENU = 'Sales & Receivables Setup', FRA = 'Paramètres ventes';
            ToolTipML = ENU = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.', FRA = 'Définissez vos stratégies générales pour les retours et la facturation vente, par exemple quand afficher des avertissements de crédit et de rupture de stock et comment valider les remises vente. Configurez vos souches de numéros pour créer des clients et différents documents de vente.';
        }
        modify("Purchases & Payables Setup")
        {
            CaptionML = ENU = 'Purchases & Payables Setup', FRA = 'Paramètres achats';
            ToolTipML = ENU = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.', FRA = 'Définissez vos stratégies générales pour les retours et la facturation achat, par exemple si les numéros de facture fournisseur sont requis et comment valider les remises achat. Configurez vos souches de numéros pour créer des fournisseurs et différents documents d''achat.';
        }
        modify("Inventory Setup")
        {
            CaptionML = ENU = 'Inventory Setup', FRA = 'Paramètres stock';
            ToolTipML = ENU = 'Define your general inventory policies, such as whether to allow negative inventory and how to post and adjust item costs. Set up your number series for creating new inventory items or services.', FRA = 'Définissez vos stratégies de stock générales, par exemple si vous autorisez le stock négatif et comment valider et ajuster les coûts d''article. Configurez vos souches de numéros pour créer des services ou articles de stock.';
        }
        modify("Fixed Assets Setup")
        {
            CaptionML = ENU = 'Fixed Assets Setup', FRA = 'Paramètres immobilisations';
            ToolTipML = ENU = 'Define your accounting policies for fixed assets, such as the allowed posting period and whether to allow posting to main assets. Set up your number series for creating new fixed assets.', FRA = 'Définissez vos stratégies comptables pour les immobilisations, par exemple la période de comptabilisation autorisée et si vous autorisez la comptabilisation pour les immobilisations principales. Paramétrez vos souches de numéros pour créer des immobilisations.';
        }
        modify("Human Resources Setup")
        {
            CaptionML = ENU = 'Human Resources Setup', FRA = 'Paramètres ressources humaines';
            ToolTipML = ENU = 'Set up number series for creating new employee cards and define if employment time is measured by days or hours.', FRA = 'Paramétrez une souche de numéros pour créer des fiches salariés et définir si la durée du contrat de travail est calculée en jours ou en heures.';
        }
        modify("Jobs Setup")
        {
            CaptionML = ENU = 'Jobs Setup', FRA = 'Paramètres projets';
            ToolTipML = ENU = 'Define your accounting policies for jobs, such as which WIP method to use and whether to update job item costs automatically.', FRA = 'Définissez vos stratégies comptables pour les projets, comme la méthode TEC à utiliser et la mise à jour automatique éventuelle des coûts article projet.';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
            ToolTipML = ENU = 'Set up the number series from which a new number is automatically assigned to new cards and documents, such as item cards and sales invoices.', FRA = 'Paramétrez les souches de numéros à partir desquelles un nouveau numéro est automatiquement affecté aux nouvelles fiches et nouveaux documents, par exemple les fiches articles et les factures vente.';
        }
        modify("System Settings")
        {
            CaptionML = ENU = 'System Settings', FRA = 'Paramètres système';
        }
        modify(Users)
        {
            CaptionML = ENU = 'Users', FRA = 'Utilisateurs';
            ToolTipML = ENU = 'Set up the employees who will work in in this company.', FRA = 'Paramétrez les employés qui vont travailler dans cette société.';
        }
        modify("Permission Sets")
        {
            CaptionML = ENU = 'Permission Sets', FRA = 'Ensembles d''autorisations';
            ToolTipML = ENU = 'View or edit which feature objects that users need to access and set up the related permissions in permission sets that you can assign to the users of the database.', FRA = 'Affichez ou modifiez les objets caractéristiques auxquels les utilisateurs doivent accéder et paramétrez les autorisations associées dans les ensembles d''autorisations que vous pouvez affecter aux utilisateurs de la base de données.';
        }
        // modify("SMTP Mail Setup")
        // {
        //     CaptionML = ENU = 'SMTP Mail Setup', FRA = 'Paramétrage courrier SMTP';
        //     ToolTipML = ENU = 'Set up the integration and security of the mail server at your site that handles email.', FRA = 'Paramétrez l''intégration et la sécurité du serveur de messagerie sur votre site qui gère le courrier électronique.';
        // }  // BC Upgrade NANDIS03
        modify(Currencies)
        {
            CaptionML = ENU = 'Currencies', FRA = 'Devises';
        }
        modify(Action27)
        {
            CaptionML = ENU = 'Currencies', FRA = 'Devises';
            ToolTipML = ENU = 'Set up the different currencies that you trade in by defining which general ledger accounts the involved transactions are posted to and how the foreign currency amounts are rounded.', FRA = 'Paramétrez les différentes devises de négociation en définissant les comptes généraux dans lesquels les transactions impliquées sont validées et la méthode d''arrondi appliquée pour les montants en devise étrangère.';
        }
        modify("Regional Settings")
        {
            CaptionML = ENU = 'Regional Settings', FRA = 'Paramètres régionaux';
        }
        modify("Countries/Regions")
        {
            CaptionML = ENU = 'Countries/Regions', FRA = 'Pays/Régions';
            ToolTipML = ENU = 'Set up the country/regions where your different business partners are located, so that you can assign Country/Region codes to business partners where special local procedures are required.', FRA = 'Paramétrez le pays/la région où se trouvent vos différents partenaires, de manière à pouvoir affecter les codes pays/région aux partenaires commerciaux pour lesquels des procédures locales spéciales sont requises.';
        }
        modify("Post Codes")
        {
            CaptionML = ENU = 'Post Codes', FRA = 'Codes postaux';
            ToolTipML = ENU = 'Set up the post codes of cities where your business partners are located.', FRA = 'Paramétrez les codes postaux des villes où se trouvent vos partenaires commerciaux.';
        }
        modify("Online Map Setup")
        {
            CaptionML = ENU = 'Online Map Setup', FRA = 'Configuration Online Map';
            ToolTipML = ENU = 'Define which map provider to use and how routes and distances are displayed when you choose the Online Map field on business documents.', FRA = 'Définissez le fournisseur de carte à utiliser ainsi que le mode d''affichage des routes et des distances si vous choisissez le champ Online Map sur les documents commerciaux.';
        }
        modify(Languages)
        {
            CaptionML = ENU = 'Languages', FRA = 'Langues';
            ToolTipML = ENU = 'Set up the languages that are spoken by your different business partners, so that you can print item names or descriptions in the relevant language.', FRA = 'Paramétrez les langues de vos différents partenaires commerciaux de façon à pouvoir imprimer les noms d''articles ou leur description dans la langue appropriée.';
        }
        modify(Codes)
        {
            CaptionML = ENU = 'Codes', FRA = 'Codes';
        }
        modify("Source Codes")
        {
            CaptionML = ENU = 'Source Codes', FRA = 'Codes journaux';
            ToolTipML = ENU = 'Set up codes for your different types of business transactions, so that you can track the source of the transactions in an audit.', FRA = 'Paramétrez les codes de vos différents types de transactions commerciales de façon à pouvoir suivre la source des transactions en cours d''audit.';
        }
        modify("Reason Codes")
        {
            CaptionML = ENU = 'Reason Codes', FRA = 'Codes motif';
            ToolTipML = ENU = 'Set up codes that specify reasons why entries were created, such as Return, to specify why a purchase credit memo was posted.', FRA = 'Paramétrez des codes qui indiquent les raisons pour lesquelles des écritures ont été créées, par exemple Retour, pour spécifier le motif de validation de l''avoir achat.';
        }
        addafter("Reason Codes")
        {
            //     action("AAD Responsibles")
            //     {
            //         CaptionML = ENU = 'AAD Responsibles',
            //                     FRA = 'Responsable DAA';
            //         Image = SetupList;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         RunObject = Page "AAD Responsibles List";
            //     }
            //     group(Translations)
            //     {
            //         CaptionML = ENU = 'Translations',
            //                     FRA = 'Traductions';
            //         Image = Translations;
            //         action("Ecotax release")
            //         {
            //             CaptionML = ENU = 'Ecotax release',
            //                         FRA = 'Ecotax lancé';
            //             Ellipsis = true;
            //             RunObject = Page "Text1 Translations";
            //             RunPageLink = "Table No." = CONST(79),
            //                           Code = FIELD("Primary Key"),
            //                           "Line No." = CONST(0);
            //         }
            //         action("Name License Holder")
            //         {
            //             CaptionML = ENU = 'Name License Holder',
            //                         FRA = 'Nom détenteur de licence';
            //             RunObject = Page "Text1 Translations";
            //             RunPageLink = "Table No." = CONST(79),
            //                           Code = FIELD("Primary Key"),
            //                           "Line No." = CONST(1);
            //         }
            //     }
            //     action("Tax Offices")
            //     {
            //         CaptionML = ENU = 'Tax Offices',
            //                     FRA = 'Bureaux de taxe';
            //         Image = Addresses;
            //         RunObject = Page "Tax Office List";
            //     }
            //     separator(Separator1100066002)
            //     {
            //     }
            //     action("Record Links")
            //     {
            //         CaptionML = ENU = 'Record Links',
            //                     FRA = 'Liens enregistrement';
            //         Description = 'DIT-715 #297';
            //         Ellipsis = true;
            //         Enabled = false;
            //         Image = Link;
            //         RunObject = Page "Record Links";
            //         Visible = false;
            //     }
            // }  // BC Upgrade NANDIS03
        }


        //Unsupported feature: PropertyModification on "ReSignInMsg(Variable 1009)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //ReSignInMsg : @@@="""sign out"" and ""sign in"" are the same terms as shown in the Dynamics NAV client.";ENU=You must sign out and then sign in again to have the changes take effect.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ReSignInMsg : @@@="""sign out"" and ""sign in"" are the same terms as shown in the Dynamics NAV client.";ENU=You must sign out and then sign in again to have the changes take effect.;FRA=Vous devez vous déconnecter et vous reconnecter pour que les changements prennent effet.;
        //Variable type has not been exported.
    }
    var
        // rText1Transl: Record "Text1 Translation";
        // TaxOffice: Record "Tax Office";
        // cduMasterExportManagement: Codeunit "Master Export Management";
        blnEnableMasterURL: Boolean;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateSystemIndicator;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UpdateSystemIndicator;
    // <<DITW15.00.00.38 DDR 19/08/2010 #1217
    if not TaxOffice.GET("Tax Office Code") then
      CLEAR(TaxOffice);
    // >>DITW15.00.00.38 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "OnClosePage". Please convert manually.

    //trigger OnClosePage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ApplicationAreaSetup.IsFoundationEnabled THEN
      CompanyInformationMgt.UpdateCompanyBankAccount(Rec,BankAcctPostingGroup,BankAccount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if ApplicationAreaSetup.IsFoundationEnabled then
      CompanyInformationMgt.UpdateCompanyBankAccount(Rec,BankAcctPostingGroup,BankAccount);
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RESET;
    if not GET then begin
      INIT;
      INSERT;
    end;
    //<<FINXL8.00.001 DAT 19/06/2015
    fctEnableMasterURL;
    //>>FINXL8.00.001 DAT 19/06/2015
    */
    //end;


    //Unsupported feature: CodeModification on "UpdateSystemIndicator(PROCEDURE 1008)". Please convert manually.

    //procedure UpdateSystemIndicator();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetSystemIndicator(SystemIndicatorText,IndicatorStyle); // IndicatorStyle is not used
    SystemIndicatorTextEditable := CurrPage.EDITABLE AND ("System Indicator" = "System Indicator"::"Custom Text");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetSystemIndicator(SystemIndicatorText,IndicatorStyle); // IndicatorStyle is not used
    SystemIndicatorTextEditable := CurrPage.EDITABLE and ("System Indicator" = "System Indicator"::"Custom Text");
    */
    //end;


    //Unsupported feature: CodeModification on "SetShowMandatoryConditions(PROCEDURE 2)". Please convert manually.

    //procedure SetShowMandatoryConditions();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    BankBranchNoOrAccountNoMissing := ("Bank Branch No." = '') OR ("Bank Account No." = '');
    IBANMissing := IBAN = ''
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    BankBranchNoOrAccountNoMissing := ("Bank Branch No." = '') or ("Bank Account No." = '');
    IBANMissing := IBAN = ''
    */
    //end;

    local procedure TaxOfficeCodeOnAfterValidate();
    begin
        // <<DITW15.00.00.38 DDR 19/08/2010 #1217
        CurrPage.UPDATE();
    end;

    // local procedure fctEnableMasterURL();
    // begin
    //     //<<FINXL8.00.001 DAT 19/06/2015
    //     if "Same Database" then
    //         blnEnableMasterURL := false
    //     else
    //         blnEnableMasterURL := true;
    //     //>>FINXL8.00.001 DAT 19/06/2015
    // end;  // BC Upgrade NANDIS03

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

