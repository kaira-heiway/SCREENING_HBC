tableextension 50012 LocationExtFND extends Location
{
    // version NAVW110.0.00.16996,FINXL10.00,MANXL7.00.001,QXL10.01,DITW110.00.11,HEI.18

    // DITW15.00.00.01 DDR 27/12/2007 added fields
    //                                  2034676 Use As Duty
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.21 DDR 19/06/2008 Added field
    //                                  2014069 Allow Calculate Weight Cubage (like Navision allowed by field "Directed Put-away and Pick")
    // DITW15.00.00.25 DDR 21/10/2008 Deleted fields
    //                                  2013696 "Use As Duty"
    // DITW15.00.00.28 DDR 24/11/2008 Added fields
    //                                  2013726 Tax Registration No.
    //                                  2013727 AAD Nos.
    // DITW15.00.00.29 DDR 22/12/2008 Added fields
    //                                  2013696 Location Group Code
    //                                Added keys
    //                                  "Location Group Code"
    // DITW15.00.00.35 DLE 06/09/2009 issue 516 Added field
    //                                  2014094 Physical Location Group Code
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151 Added fields
    //                                  2035204 Auto.Create QualityTest Method
    // DITW15.00.00.38 DDR 16/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    2014460 Tax Office Code
    //                                    2014268 Consignor Type
    //                                    2014269 Consignor Language Code
    //                                    2014270 Type of Origin
    //                                    2014271 Tax Warehouse Reference
    //                     05/10/2010   Added fields
    //                                    2014282 Type of Destination
    //                     28/10/2010 DIT711 issue 76 Added key "Tax Registration"
    //                     04/01/2011 issue 1217 (DIT711 112) Modified optionstring field "Destination Type"
    //                     27/01/2011 issue 1217 (DIT711 136) Added fields
    //                                    2014481 VAT Registration No.
    //                     11/03/2011 issue 458 Replaced caption field2013696 'Location Group' -> 'Location Tax Group'
    //                                                           field2014094 (dutch)
    //                     16/03/2011 issue 1191 Added key "Tax Registration"
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added fields
    //                                   2014290 Journey Time
    //                     04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
    //                     19/08/2011 issue 1366 Added fields
    //                                   2014509 Use As Quarantine
    //                     15/09/2011 issue 1365
    //                                  Added fields
    //                                    2014504 No. of Location Relationships
    //                                    2014415 Indentation
    //                                    2014418 Indentation Line
    //                                  Added key "Indentation Line,Indentation,Code"
    // DITW16.00.00.40 DDR 09/03/2012 #1331
    //                                  Added fields
    //                                    2035058 Allow FEFO Tracking Add-Bins
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457
    //                                  Added fields
    //                                    2034983 Work Order Mandatory
    //                                    2034984 W.Order Alloc. Location Code
    //                                    2034985 W.Order Allocation Bin Code
    // DITW16.00.00.43 DDR 02/09/2013 DIT-715 #733
    //                                  Added fields
    //                                    2014267 Exclude from EMCS
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM

    // DITW17.00.02 DDR 31/05/2013 DIT-770 #100 Added fields
    //                                            2014560 UK Deferment Account Num Type
    //                                            2014561 UK Deferment Account No.
    //                                          Added key "UK Deferment Account No.
    //                  04/06/2013 DIT-770 #100 Modified 'Caption' property field 2014561
    //                                          Added fields
    //                                            2014562 Consigment Customer No.
    //                  23/07/2013 DIT-770 #101 Modified key
    //                                            'Physical Location Group Code,UK Deferment Account No.'
    //                  09/08/2013 DIT-770 #101 Added key
    //                                            'UK Deferment Account No.'
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #100 #101

    // MANXL7.00.001 DAT 26/02/2014 #6: Added Blocked + Scrap Bin Code

    // DITW17.00.02 DDR 04/09/2013 DIT-715 #733 merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 WSA 10/10/2014 DIT-770 #930 Added field "Default Origin Type"
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW17.10.05 DDR 26/01/2015 DIT-770 #271 Modified workflow "Allow Calculate Weight Cubage"
    // DITW18.00.06 MSF 06/02/2015 DIT-770 #1180 Added Field 2014410 "Responsibility Center"
    // DITW18.00.06 AKH 12/02/2015 DIT-770 #1198 Multisite - Items by Location : Added Field 2014411 "Finished Goods Location"
    // DITW18.00.06 MSF 19/02/2015 DIT-770 #1180 Delete Field 2014410 "Responsibility Center"
    // DITW18.00.07 MVN 21/01/2016 DIT-770 #1397 Added Field 2014300 "Submission Type for Export"
    // DITW18.00.07 VSC 16/02/2016 DIT-770 #1703 New fields for managing partial Warehouse shipments\receipts
    //                                           "No Whse Shipment Backorder" , "No Whse Receipt Backorder"
    // DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Changed CaptionML Field 2014300 "Submission Type for Export (EMCS)"
    // DITW18.00.07 VSC 24/02/2016 DIT-770 #1703 Changed ENU Captions on Fields "No Whse Shipment Backorder" , "No Whse Receipt Backorder"
    // DITW18.00.07 AKH 29/02/2016 DIT-770 #1425 Automatic Drop Shipments and Special orders : Added new field 2014062 "Purchasing Code"
    // DITW18.00.07 VSC 01/03/2016 DIT-770 #1702 Add New Field "Manually Close Shipping Status"
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 New Field "Auto Create Shipping Cost"
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW18.00.07 VSC 18/06/2016 DIT-770 #1703 Add new field "Manually Close Receipt Status"
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW19.00.08A AKH 06/01/2017 BL#17581 Deleted field 2014561 "Default Origin Type" (Related to DE Beertax)

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 YHE 15/03/2017 NRQ#24111 merge DIT2016 W1 R8A
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Deactivated "No Whse Shipment Backorder" since it won't be used anymore.
    // DITW110.00.11 VSC 26/09/2017 NRQ#30577 Merge - QXL10.01 VSC 26/09/2017 NRQ#38341 : Multisite – Quality tracking per Location
    //                                     Change caption on field "2035090" to "Auto  Tests Creation on Transfer"
    // DITW110.00.11 VSC 04/10/2017 NRQ#33755 Delete Fields "Whse Shipment Backorder" AND "Whse Receipt Backorder"
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 # Added fields Transit Zone, Zone Mandatory, Transit Bin
    //    #Zone mandatory when Bin mandatory = true
    // HEI.02 FDD-PRDGAP004 - Automatic Batch Number Generation , 10.09.2017 IBM.NAIKH01
    //   # Addde 2 new fields "Plant ID" and "Batch sequential number"
    // HEI.03 Cash Van Sales Interface IBM HORTOC01  30.07.2018 # new fields
    // HEI.04 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Fields created: 50007 - Purchase Gate Entry Mandatory
    //                        50008 - Sales Gate Entry Mandatory
    //                        50009 - Transfer Gate Entry Mandatory
    //                        50010 - Gate Weighing Mandatory
    // HEI.05 RFC-CHG0248455 IBM.LS 03.12.2018
    //   # New Field created: 50020 - "Warning Threshold Days" (Caption - Expiry Warning Threshold Days)
    // HEI.06 FDD-HT620 IBM BULIMC01 02.08.2019 # New field created "Consump. Tolerance Limit %"
    // HEI.07 FDD-CHG2024489 Gate Control IBM SAXENS01
    //   Two New Field Added
    //     # "InBound Automatic Registration"
    //     # "Enable Inbound Validation"
    // HEI.08 RFC-CHG2008448 IBM.LS 12.12.2019
    //   # New Fields created: 50024 - Print Invoice for W/h Ship.
    //                         50025 - Print DN for W/h Ship.
    //                         50026 - Print Load Note for W/h Ship.
    // HEI.09 FDD-HT1075 CHG2039144 IBM.GUNERE01 14.01.2020 # Field 50027 : Create Doc. Shipping Cost On field added
    // HEI.10 CHG2010375 IBM.LS 22.01.2020
    //   # New Fields created: 50028 - "Printer Name"
    //   # Code added.
    // HEI.11 FDD-HB503 IBM NASTAA02 30.01.2020 # Post & Print
    //   # New Field created: 50029 - Print DN (Sales Inv)
    //   # Renamed Fields: 50024 - Print Invoice (Whse Ship)
    //                     50025 - Print DN (Whse Ship)
    //                     50026 - Print LN (Whse Ship)
    // HEI.12 CHG2010375 IBM.LS 12.02.2020
    //   # New Field created: 50030 - "Logistics E-Mail"
    // HEI.13 FDD-HB503 IBM NASTAA02 31.03.2020 # Post & Print
    //   # Renamed Fields: 50024 - Print Invoice
    //                     50029 - Print DN (Sales Ship)
    //                     50026 - Print Loading Note
    // HEI.14 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Field created : 50031 - IC Partner Code
    //   # Code added on OnValidate Trigger of 'IC Partner Code' Field
    // HEI.15 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field added: 50032 - Store
    // HEI.16 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions DisplayMap(), WMSCheckWarehouse()
    // HEI.17 CHG2164305 IBM COSTES04 20.12.2022 - Primary_Secondary CCC Shipping Cost Allocation
    //   # New fields Cost Center Pr. Trans. Out. , Cost Center Pr. Trans. Export, Cost Center Sec. Trans. Out.
    // HEI.18 CHG2149734 SAHAL01 24.03.2023 Astro - I/F Production - ProductionOrderSync
    //   # Created New Field: 50015 - Allow to Astro

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
        modify("Default Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Default Bin Code"(Field 130)". Please convert manually.

            CaptionML = ENU = 'Default Bin Code', FRA = 'Code emplacement par défaut';
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

            //Unsupported feature: Change TableRelation on "City(Field 5703)". Please convert manually.

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
        modify(Contact)
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Post Code"(Field 5714)". Please convert manually.

            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify(County)
        {
            CaptionML = ENU = 'County', FRA = 'Région';
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

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 5720)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("Use As In-Transit")
        {
            CaptionML = ENU = 'Use As In-Transit', FRA = 'Magasin de transit';
        }
        modify("Require Put-away")
        {
            CaptionML = ENU = 'Require Put-away', FRA = 'Rangement requis';
        }
        modify("Require Pick")
        {
            CaptionML = ENU = 'Require Pick', FRA = 'Prélèvement requis';
        }
        modify("Cross-Dock Due Date Calc.")
        {
            CaptionML = ENU = 'Cross-Dock Due Date Calc.', FRA = 'Délai transbordement';
        }
        modify("Use Cross-Docking")
        {
            CaptionML = ENU = 'Use Cross-Docking', FRA = 'Utiliser transbordement';
        }
        modify("Require Receive")
        {
            CaptionML = ENU = 'Require Receive', FRA = 'Réception requise';
        }
        modify("Require Shipment")
        {
            CaptionML = ENU = 'Require Shipment', FRA = 'Expédition requise';
        }
        modify("Bin Mandatory")
        {
            CaptionML = ENU = 'Bin Mandatory', FRA = 'Emplacement obligatoire';
        }
        modify("Directed Put-away and Pick")
        {
            CaptionML = ENU = 'Directed Put-away and Pick', FRA = 'Prélèv. et rangement suggérés';
        }
        modify("Default Bin Selection")
        {
            CaptionML = ENU = 'Default Bin Selection', FRA = 'Sélection emplacement par déf.';
            // OptionCaptionML = ENU = ' ,Fixed Bin,Last-Used Bin', FRA = ' ,Emplacement fixe,Dernier emplacement utilisé';
        }
        modify("Outbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Outbound Whse. Handling Time', FRA = 'Délai désenlogement';
        }
        modify("Inbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Inbound Whse. Handling Time', FRA = 'Délai enlogement';
        }
        modify("Put-away Template Code")
        {
            CaptionML = ENU = 'Put-away Template Code', FRA = 'Code modèle rangement';
        }
        modify("Use Put-away Worksheet")
        {
            CaptionML = ENU = 'Use Put-away Worksheet', FRA = 'Utiliser feuille rangement';
        }
        modify("Pick According to FEFO")
        {
            CaptionML = ENU = 'Pick According to FEFO', FRA = 'Prélèvement selon FEFO';
        }
        modify("Allow Breakbulk")
        {
            CaptionML = ENU = 'Allow Breakbulk', FRA = 'Autoriser déconditionnement';
        }
        modify("Bin Capacity Policy")
        {
            CaptionML = ENU = 'Bin Capacity Policy', FRA = 'Politique capacité empl.';
            OptionCaptionML = ENU = 'Never Check Capacity,Allow More Than Max. Capacity,Prohibit More Than Max. Cap.', FRA = 'Ne pas vérifier la capacité,Autoriser dépassement capacité max.,Interdire dépassement capacité max.';
        }
        modify("Open Shop Floor Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Open Shop Floor Bin Code"(Field 7313)". Please convert manually.

            CaptionML = ENU = 'Open Shop Floor Bin Code', FRA = 'Code empl. atelier ouvert';
        }
        modify("To-Production Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""To-Production Bin Code"(Field 7314)". Please convert manually.

            CaptionML = ENU = 'To-Production Bin Code', FRA = 'Code empl. des consommations';
        }
        modify("From-Production Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""From-Production Bin Code"(Field 7315)". Please convert manually.

            CaptionML = ENU = 'From-Production Bin Code', FRA = 'Code empl. après production';
        }
        modify("Adjustment Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Adjustment Bin Code"(Field 7317)". Please convert manually.

            CaptionML = ENU = 'Adjustment Bin Code', FRA = 'Code empl. ajustement';
        }
        modify("Always Create Put-away Line")
        {
            CaptionML = ENU = 'Always Create Put-away Line', FRA = 'Toujours créer ligne rangement';
        }
        modify("Always Create Pick Line")
        {
            CaptionML = ENU = 'Always Create Pick Line', FRA = 'Toujours créer ligne prélèv.';
        }
        modify("Special Equipment")
        {
            CaptionML = ENU = 'Special Equipment', FRA = 'Equipement spécial';
            OptionCaptionML = ENU = ' ,According to Bin,According to SKU/Item', FRA = ' ,Selon emplacement,Selon point de stock/article';
        }
        modify("Receipt Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Receipt Bin Code"(Field 7323)". Please convert manually.

            CaptionML = ENU = 'Receipt Bin Code', FRA = 'Code empl. réception';
        }
        modify("Shipment Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Shipment Bin Code"(Field 7325)". Please convert manually.

            CaptionML = ENU = 'Shipment Bin Code', FRA = 'Code empl. expédition';
        }
        modify("Cross-Dock Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Cross-Dock Bin Code"(Field 7326)". Please convert manually.

            CaptionML = ENU = 'Cross-Dock Bin Code', FRA = 'Code empl. transbord.';
        }
        modify("To-Assembly Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""To-Assembly Bin Code"(Field 7330)". Please convert manually.

            CaptionML = ENU = 'To-Assembly Bin Code', FRA = 'Code empl. vers assemblage';
        }
        modify("From-Assembly Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""From-Assembly Bin Code"(Field 7331)". Please convert manually.

            CaptionML = ENU = 'From-Assembly Bin Code', FRA = 'Code empl. depuis assemblage';
        }
        modify("Asm.-to-Order Shpt. Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Asm.-to-Order Shpt. Bin Code"(Field 7332)". Please convert manually.

            CaptionML = ENU = 'Asm.-to-Order Shpt. Bin Code', FRA = 'Code empl. exp. ass. pr comm.';
        }
        modify("Base Calendar Code")
        {
            CaptionML = ENU = 'Base Calendar Code', FRA = 'Code calendrier principal';
        }
        modify("Use ADCS")
        {
            CaptionML = ENU = 'Use ADCS', FRA = 'Saisie automatisée';
        }

        //Unsupported feature: CodeModification on "City(Field 5703).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Postcode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Postcode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Post Code"(Field 5714).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Postcode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Postcode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Use As In-Transit"(Field 5724).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Use As In-Transit" THEN BEGIN
          TESTFIELD("Require Put-away",FALSE);
          TESTFIELD("Require Pick",FALSE);
          TESTFIELD("Use Cross-Docking",FALSE);
          TESTFIELD("Require Receive",FALSE);
          TESTFIELD("Require Shipment",FALSE);
          TESTFIELD("Bin Mandatory",FALSE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Use As In-Transit" then begin
          TESTFIELD("Require Put-away",false);
          TESTFIELD("Require Pick",false);
          TESTFIELD("Use Cross-Docking",false);
          TESTFIELD("Require Receive",false);
          TESTFIELD("Require Shipment",false);
          TESTFIELD("Bin Mandatory",false);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Require Put-away"(Field 5726).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhseRcptHeader.SETRANGE("Location Code",Code);
        IF NOT WhseRcptHeader.ISEMPTY THEN
          ERROR(Text008,FIELDCAPTION("Require Put-away"),xRec."Require Put-away",WhseRcptHeader.TABLECAPTION);

        IF NOT "Require Put-away" THEN BEGIN
          TESTFIELD("Directed Put-away and Pick",FALSE);
          WhseActivHeader.SETRANGE(Type,WhseActivHeader.Type::"Put-away");
          WhseActivHeader.SETRANGE("Location Code",Code);
          IF NOT WhseActivHeader.ISEMPTY THEN
            ERROR(Text008,FIELDCAPTION("Require Put-away"),TRUE,WhseActivHeader.TABLECAPTION);
          "Use Cross-Docking" := FALSE;
          "Cross-Dock Bin Code" := '';
        end else
          CreateInboundWhseRequest;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        WhseRcptHeader.SETRANGE("Location Code",Code);
        if not WhseRcptHeader.ISEMPTY then
          ERROR(Text008,FIELDCAPTION("Require Put-away"),xRec."Require Put-away",WhseRcptHeader.TABLECAPTION);

        if not "Require Put-away" then begin
          TESTFIELD("Directed Put-away and Pick",false);
          WhseActivHeader.SETRANGE(Type,WhseActivHeader.Type::"Put-away");
          WhseActivHeader.SETRANGE("Location Code",Code);
          if not WhseActivHeader.ISEMPTY then
            ERROR(Text008,FIELDCAPTION("Require Put-away"),true,WhseActivHeader.TABLECAPTION);
          "Use Cross-Docking" := false;
          "Cross-Dock Bin Code" := '';
        end else
          CreateInboundWhseRequest;
        */
        //end;


        //Unsupported feature: CodeModification on ""Require Pick"(Field 5727).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhseShptHeader.SETRANGE("Location Code",Code);
        IF NOT WhseShptHeader.ISEMPTY THEN
          ERROR(Text008,FIELDCAPTION("Require Pick"),xRec."Require Pick",WhseShptHeader.TABLECAPTION);

        IF NOT "Require Pick" THEN BEGIN
          TESTFIELD("Directed Put-away and Pick",FALSE);
          WhseActivHeader.SETRANGE(Type,WhseActivHeader.Type::Pick);
          WhseActivHeader.SETRANGE("Location Code",Code);
          IF NOT WhseActivHeader.ISEMPTY THEN
            ERROR(Text008,FIELDCAPTION("Require Pick"),TRUE,WhseActivHeader.TABLECAPTION);
          "Use Cross-Docking" := FALSE;
          "Cross-Dock Bin Code" := '';
          "Pick According to FEFO" := FALSE;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        WhseShptHeader.SETRANGE("Location Code",Code);
        if not WhseShptHeader.ISEMPTY then
          ERROR(Text008,FIELDCAPTION("Require Pick"),xRec."Require Pick",WhseShptHeader.TABLECAPTION);

        if not "Require Pick" then begin
          TESTFIELD("Directed Put-away and Pick",false);
          WhseActivHeader.SETRANGE(Type,WhseActivHeader.Type::Pick);
          WhseActivHeader.SETRANGE("Location Code",Code);
          if not WhseActivHeader.ISEMPTY then
            ERROR(Text008,FIELDCAPTION("Require Pick"),true,WhseActivHeader.TABLECAPTION);
          "Use Cross-Docking" := false;
          "Cross-Dock Bin Code" := '';
          "Pick According to FEFO" := false;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Use Cross-Docking"(Field 5729).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Use Cross-Docking" THEN BEGIN
          TESTFIELD("Require Receive");
          TESTFIELD("Require Shipment");
          TESTFIELD("Require Put-away");
          TESTFIELD("Require Pick");
        end else
          "Cross-Dock Bin Code" := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Use Cross-Docking" then begin
        #2..5
        end else
          "Cross-Dock Bin Code" := '';
        */
        //end;


        //Unsupported feature: CodeModification on ""Require Receive"(Field 5730).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Require Receive" THEN BEGIN
          TESTFIELD("Directed Put-away and Pick",FALSE);
          WhseRcptHeader.SETRANGE("Location Code",Code);
          IF NOT WhseRcptHeader.ISEMPTY THEN
            ERROR(Text008,FIELDCAPTION("Require Receive"),TRUE,WhseRcptHeader.TABLECAPTION);
          "Receipt Bin Code" := '';
          "Use Cross-Docking" := FALSE;
          "Cross-Dock Bin Code" := '';
        end else BEGIN
          WhseActivHeader.SETRANGE(Type,WhseActivHeader.Type::"Put-away");
          WhseActivHeader.SETRANGE("Location Code",Code);
          IF NOT WhseActivHeader.ISEMPTY THEN
            ERROR(Text008,FIELDCAPTION("Require Receive"),FALSE,WhseActivHeader.TABLECAPTION);

          CreateInboundWhseRequest;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Require Receive" then begin
          TESTFIELD("Directed Put-away and Pick",false);
          WhseRcptHeader.SETRANGE("Location Code",Code);
          if not WhseRcptHeader.ISEMPTY then
            ERROR(Text008,FIELDCAPTION("Require Receive"),true,WhseRcptHeader.TABLECAPTION);
          "Receipt Bin Code" := '';
          "Use Cross-Docking" := false;
          "Cross-Dock Bin Code" := '';
        end else begin
          WhseActivHeader.SETRANGE(Type,WhseActivHeader.Type::"Put-away");
          WhseActivHeader.SETRANGE("Location Code",Code);
          if not WhseActivHeader.ISEMPTY then
            ERROR(Text008,FIELDCAPTION("Require Receive"),false,WhseActivHeader.TABLECAPTION);

          // <<DITW17.10.05 DDR 26/01/2015 DIT-770 #271
          "Allow Calculate Weight Cubage" := true;
          // >>DITW17.10.05 DDR DIT-770 #271

          CreateInboundWhseRequest;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Require Shipment"(Field 5731).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Require Shipment" THEN BEGIN
          TESTFIELD("Directed Put-away and Pick",FALSE);
          WhseShptHeader.SETRANGE("Location Code",Code);
          IF NOT WhseShptHeader.ISEMPTY THEN
            ERROR(Text008,FIELDCAPTION("Require Shipment"),TRUE,WhseShptHeader.TABLECAPTION);
          "Shipment Bin Code" := '';
          "Use Cross-Docking" := FALSE;
          "Cross-Dock Bin Code" := '';
        end else BEGIN
          WhseActivHeader.SETRANGE(Type,WhseActivHeader.Type::Pick);
          WhseActivHeader.SETRANGE("Location Code",Code);
          IF NOT WhseActivHeader.ISEMPTY THEN
            ERROR(Text008,FIELDCAPTION("Require Shipment"),FALSE,WhseActivHeader.TABLECAPTION);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Require Shipment" then begin
          TESTFIELD("Directed Put-away and Pick",false);
          WhseShptHeader.SETRANGE("Location Code",Code);
          if not WhseShptHeader.ISEMPTY then
            ERROR(Text008,FIELDCAPTION("Require Shipment"),true,WhseShptHeader.TABLECAPTION);
          "Shipment Bin Code" := '';
          "Use Cross-Docking" := false;
          "Cross-Dock Bin Code" := '';
        end else begin
          WhseActivHeader.SETRANGE(Type,WhseActivHeader.Type::Pick);
          WhseActivHeader.SETRANGE("Location Code",Code);
          if not WhseActivHeader.ISEMPTY then
            ERROR(Text008,FIELDCAPTION("Require Shipment"),false,WhseActivHeader.TABLECAPTION);

          // <<DITW17.10.05 DDR 26/01/2015 DIT-770 #271
          "Allow Calculate Weight Cubage" := true;
          // >>DITW17.10.05 DDR DIT-770 #271
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Mandatory"(Field 5732).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bin Mandatory" AND NOT xRec."Bin Mandatory" THEN BEGIN
          Window.OPEN(Text010);
          ItemLedgEntry.SETRANGE(Open,TRUE);
          ItemLedgEntry.SETRANGE("Location Code",Code);
          IF NOT ItemLedgEntry.ISEMPTY THEN
            ERROR(Text009,FIELDCAPTION("Bin Mandatory"));

          "Default Bin Selection" := "Default Bin Selection"::"Fixed Bin";
        end;

        WhseActivHeader.SETRANGE("Location Code",Code);
        IF NOT WhseActivHeader.ISEMPTY THEN
          ERROR(Text008,FIELDCAPTION("Bin Mandatory"),xRec."Bin Mandatory",WhseActivHeader.TABLECAPTION);

        WhseRcptHeader.SETCURRENTKEY("Location Code");
        WhseRcptHeader.SETRANGE("Location Code",Code);
        IF NOT WhseRcptHeader.ISEMPTY THEN
          ERROR(Text008,FIELDCAPTION("Bin Mandatory"),xRec."Bin Mandatory",WhseRcptHeader.TABLECAPTION);

        WhseShptHeader.SETCURRENTKEY("Location Code");
        WhseShptHeader.SETRANGE("Location Code",Code);
        IF NOT WhseShptHeader.ISEMPTY THEN
          ERROR(Text008,FIELDCAPTION("Bin Mandatory"),xRec."Bin Mandatory",WhseShptHeader.TABLECAPTION);

        IF NOT "Bin Mandatory" AND xRec."Bin Mandatory" THEN BEGIN
          WhseEntry.SETRANGE("Location Code",Code);
          WhseEntry.CALCSUMS("Qty. (Base)");
          IF WhseEntry."Qty. (Base)" <> 0 THEN
            ERROR(Text002,FIELDCAPTION("Bin Mandatory"));
        end;

        IF NOT "Bin Mandatory" THEN BEGIN
          "Open Shop Floor Bin Code" := '';
          "To-Production Bin Code" := '';
          "From-Production Bin Code" := '';
          "Adjustment Bin Code" := '';
          "Receipt Bin Code" := '';
          "Shipment Bin Code" := '';
          "Cross-Dock Bin Code" := '';
          "To-Assembly Bin Code" := '';
          "From-Assembly Bin Code" := '';
          WhseIntegrationMgt.CheckLocationOnManufBins(Rec);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bin Mandatory" and not xRec."Bin Mandatory" then begin
          Window.OPEN(Text010);
          ItemLedgEntry.SETRANGE(Open,true);
          ItemLedgEntry.SETRANGE("Location Code",Code);
          if not ItemLedgEntry.ISEMPTY then
        #6..8
        end;
        //HEI.01 PRDGAP024>>
        if "Bin Mandatory" then
          "Zone Mandatory" := true;
        //HEI.01 PRDGAP024<<
        WhseActivHeader.SETRANGE("Location Code",Code);
        if not WhseActivHeader.ISEMPTY then
        #13..16
        if not WhseRcptHeader.ISEMPTY then
        #18..21
        if not WhseShptHeader.ISEMPTY then
          ERROR(Text008,FIELDCAPTION("Bin Mandatory"),xRec."Bin Mandatory",WhseShptHeader.TABLECAPTION);

        if not "Bin Mandatory" and xRec."Bin Mandatory" then begin
          WhseEntry.SETRANGE("Location Code",Code);
          WhseEntry.CALCSUMS("Qty. (Base)");
          if WhseEntry."Qty. (Base)" <> 0 then
            ERROR(Text002,FIELDCAPTION("Bin Mandatory"));
        end;

        if not "Bin Mandatory" then begin
        #33..42
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Directed Put-away and Pick"(Field 5733).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhseActivHeader.SETRANGE("Location Code",Code);
        IF NOT WhseActivHeader.ISEMPTY THEN
          ERROR(Text014,FIELDCAPTION("Directed Put-away and Pick"),WhseActivHeader.TABLECAPTION);

        WhseRcptHeader.SETCURRENTKEY("Location Code");
        WhseRcptHeader.SETRANGE("Location Code",Code);
        IF NOT WhseRcptHeader.ISEMPTY THEN
          ERROR(Text014,FIELDCAPTION("Directed Put-away and Pick"),WhseRcptHeader.TABLECAPTION);

        WhseShptHeader.SETCURRENTKEY("Location Code");
        WhseShptHeader.SETRANGE("Location Code",Code);
        IF NOT WhseShptHeader.ISEMPTY THEN
          ERROR(Text014,FIELDCAPTION("Directed Put-away and Pick"),WhseShptHeader.TABLECAPTION);

        IF "Directed Put-away and Pick" THEN BEGIN
          TESTFIELD("Use As In-Transit",FALSE);
          TESTFIELD("Bin Mandatory");
          VALIDATE("Require Receive",TRUE);
          VALIDATE("Require Shipment",TRUE);
          VALIDATE("Require Put-away",TRUE);
          VALIDATE("Require Pick",TRUE);
          VALIDATE("Use Cross-Docking",TRUE);
          "Default Bin Selection" := "Default Bin Selection"::" ";
        end else
          VALIDATE("Adjustment Bin Code",'');

        IF (NOT "Directed Put-away and Pick") AND xRec."Directed Put-away and Pick" THEN BEGIN
          "Default Bin Selection" := "Default Bin Selection"::"Fixed Bin";
          "Use Put-away Worksheet" := FALSE;
          VALIDATE("Use Cross-Docking",FALSE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        WhseActivHeader.SETRANGE("Location Code",Code);
        if not WhseActivHeader.ISEMPTY then
        #3..6
        if not WhseRcptHeader.ISEMPTY then
        #8..11
        if not WhseShptHeader.ISEMPTY then
          ERROR(Text014,FIELDCAPTION("Directed Put-away and Pick"),WhseShptHeader.TABLECAPTION);

        if "Directed Put-away and Pick" then begin
          TESTFIELD("Use As In-Transit",false);
          TESTFIELD("Bin Mandatory");
          VALIDATE("Require Receive",true);
          VALIDATE("Require Shipment",true);
          VALIDATE("Require Put-away",true);
          VALIDATE("Require Pick",true);
          VALIDATE("Use Cross-Docking",true);
          "Default Bin Selection" := "Default Bin Selection"::" ";
        end else
          VALIDATE("Adjustment Bin Code",'');

        if (not "Directed Put-away and Pick") and xRec."Directed Put-away and Pick" then begin
          "Default Bin Selection" := "Default Bin Selection"::"Fixed Bin";
          "Use Put-away Worksheet" := false;
          VALIDATE("Use Cross-Docking",false);
        end;

        // <<DITW17.10.05 DDR 26/01/2015 DIT-770 #271
        if "Directed Put-away and Pick" then
        // <<DITW15.00.00.21 DDR 19/06/2008
          "Allow Calculate Weight Cubage" := true;
        // >>DITW15.00.00.21 DDR
        // >>DITW17.10.05 DDR DIT-770 #271
        */
        //end;


        //Unsupported feature: CodeModification on ""Default Bin Selection"(Field 5734).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Default Bin Selection" <> xRec."Default Bin Selection") AND ("Default Bin Selection" = "Default Bin Selection"::" ") THEN
          TESTFIELD("Directed Put-away and Pick");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Default Bin Selection" <> xRec."Default Bin Selection") and ("Default Bin Selection" = "Default Bin Selection"::" ") then
          TESTFIELD("Directed Put-away and Pick");
        */
        //end;


        //Unsupported feature: CodeModification on ""Adjustment Bin Code"(Field 7317).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Adjustment Bin Code" <> xRec."Adjustment Bin Code" THEN BEGIN
          IF "Adjustment Bin Code" = '' THEN
            CheckEmptyBin(
              xRec."Adjustment Bin Code",FIELDCAPTION("Adjustment Bin Code"))
          else
            CheckEmptyBin(
              "Adjustment Bin Code",FIELDCAPTION("Adjustment Bin Code"));

          CheckWhseAdjmtJnl;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Adjustment Bin Code" <> xRec."Adjustment Bin Code" then begin
          if "Adjustment Bin Code" = '' then
            CheckEmptyBin(
              xRec."Adjustment Bin Code",FIELDCAPTION("Adjustment Bin Code"))
          else
        #6..9
        end;
        */
        //end;
        field(50000; "Transit Zone FND"; Code[10])
        {
            caption = 'Transit Zone';
            Description = 'HEI.01 PRDGAP024';
            TableRelation = Zone.Code where("Location Code" = FIELD(Code));
        }
        field(50001; "Zone Mandatory FND"; Boolean)
        {
            caption = 'Zone Mandatory';
            Description = 'HEI.01 PRDGAP024';
        }
        field(50002; "Transit Bin FND"; Code[20])
        {
            caption = 'Transit Bin';
            Description = 'HEI.01 PRDGAP024';
            TableRelation = Bin.Code where("Location Code" = FIELD(Code),
                                            "Zone Code" = FIELD("Transit Zone FND"));
        }
        field(50003; "Plant ID FND"; Text[1])
        {
            caption = 'Plant ID';
            Description = 'PRDGAP004';
        }
        field(50004; "Batch sequential number FND"; Code[10])
        {
            caption = 'Batch sequential number';
            Description = 'PRDGAP004';
            TableRelation = "No. Series";
        }
        field(50005; "Default Physical Location FND"; Boolean)
        {
            caption = 'Default Physical Location';
            Description = 'PRDGAP004';
        }
        field(50006; "Van Sales Route FND"; Code[20])
        {
            Caption = 'Van Sales Route';
            Description = 'HEI.03';
            //TableRelation = Route;  // BC Upgrade NANDIS03 - Aptean table
        }
        field(50007; "Purchase Gate Entry Mandat FND"; Boolean)
        {
            caption = 'Purchase Gate Entry Mandat';
            Description = 'HEI.04';
        }
        field(50008; "Sales Gate Entry Mandatory FND"; Boolean)
        {
            caption = 'Sales Gate Entry Mandatory';
            Description = 'HEI.04';
        }
        field(50009; "Transfer Gate Entry Mandat FND"; Boolean)
        {
            caption = 'Transfer Gate Entry Mandat';
            Description = 'HEI.04';
        }
        field(50010; "Gate Weighing Mandatory FND"; Boolean)
        {
            caption = 'Gate Weighing Mandatory';
            Description = 'HEI.04';
        }
        field(50015; "Allow to Astro FND"; Boolean)
        {
            Caption = 'Allow to Astro';
            Description = 'HEI.18';

        }
        field(50020; "Warning Threshold Days FND"; Integer)
        {
            Caption = 'Expiry Warning Threshold Days';
            Description = 'HEI.05';
        }
        field(50021; "Consump. Tolerance Limit % FND"; Decimal)
        {
            Caption = 'Consump. Tolerance Limit %';
            Description = 'HEI.06';
        }
        field(50022; "InBound Auto Registration FND"; Boolean)
        {
            caption = 'InBound Auto Registration';
            Description = 'HEI.07';

        }
        field(50023; "Enable Inbound Validation FND"; Boolean)
        {
            caption = 'Enable Inbound Validation';
            Description = 'HEI.07';
        }
        field(50024; "Print Invoice FND"; Boolean)
        {
            Caption = 'Print Invoice';
            Description = 'HEI.08,HEI.11,HEI.13';
        }
        field(50025; "Print DN (Whse Ship) FND"; Boolean)
        {
            Caption = 'Print Delivery Note (Whse Shipment)';
            Description = 'HEI.08,HEI.11';
        }
        field(50026; "Print Loading Note FND"; Boolean)
        {
            Caption = 'Print Loading Note';
            Description = 'HEI.08,HEI.11,HEI.13';
        }
        field(50027; "Create Doc. Ship. Cost On FND"; Option)
        {
            caption = 'Create Doc. Ship. Cost On';
            Description = 'HEI.09';
            OptionCaption = 'Shipment,Receipt';
            OptionMembers = Shipment,Receipt;
        }
        field(50028; "Printer Name FND"; Text[250])
        {
            CaptionML = ENU = 'Printer Name',
                        FRA = 'Nom de l''imprimante';
            Description = 'HEI.10';

            trigger OnLookup();
            var
                PrinterL: Record Printer;
                ServerPrintersL: Page "Server Printers";
            begin
                //HEI.10>>
                ServerPrintersL.SetSelectedPrinterName("Printer Name FND");
                if ServerPrintersL.RUNMODAL() = ACTION::OK then begin
                    ServerPrintersL.GETRECORD(PrinterL);
                    "Printer Name FND" := PrinterL.ID;
                end;
                //HEI.10<<
            end;

            trigger OnValidate();
            var
                InitServerPrinterTableL: Codeunit "Init. Server Printer Table";
            begin
                //HEI.10>>
                if "Printer Name FND" = '' then
                    exit;
                InitServerPrinterTableL.ValidatePrinterName("Printer Name FND");
                //HEI.10<<
            end;
        }
        field(50029; "Print DN (Sales Ship) FND"; Boolean)
        {
            Caption = 'Print Delivery Note (Sales Shipment)';
            Description = 'HEI.11,HEI.13';
        }
        field(50030; "Logistics E-Mail FND"; Text[80])
        {
            CaptionML = ENU = 'Logistics Email',
                        FRA = 'Adresse Logistique Email';
            Description = 'HEI.12';
            ExtendedDatatype = EMail;
        }
        field(50031; "IC Partner Code FND"; Code[20])
        {
            Caption = 'IC Partner Code';
            Description = 'HEI.14';
            TableRelation = "IC Partner";

            trigger OnValidate();
            var
                ICPartner: Record "IC Partner";
                ICPartnerCodeAssignedErr: TextConst ENU = 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.', FRA = 'La valeur %1 %2 a été affectée à %3 %4.\La même valeur %1 ne peut pas être entrée sur plus d''un/une %3. Entrez un autre code.';
            begin
                //HEI.14>>
                if "IC Partner Code FND" <> '' then begin
                    ICPartner.GET("IC Partner Code FND");
                    if (ICPartner."Location Code FND" <> '') and (ICPartner."Location Code FND" <> Code) then
                        ERROR(ICPartnerCodeAssignedErr, FIELDCAPTION("IC Partner Code FND"), "IC Partner Code FND", TABLECAPTION, ICPartner."Location Code FND");
                    ICPartner."Location Code FND" := Code;
                    ICPartner.MODIFY();
                end;

                if (xRec."IC Partner Code FND" <> "IC Partner Code FND") and ICPartner.GET(xRec."IC Partner Code FND") then begin
                    ICPartner."Location Code FND" := '';
                    ICPartner.MODIFY();
                end;
                //HEI.14<<
            end;
        }
        field(50032; "Store FND"; Boolean)
        {
            Caption = 'STORE';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
        }
        field(50033; "Cost Center Pr. Trans. Out FND"; Code[20])
        {
            Caption = 'Cost Center for Primary Transport Outbound';
            DataClassification = CustomerContent;
            Description = 'HEI.17';

            trigger OnLookup();
            var
                DimensionValue: Record "Dimension Value";
                GeneralLedgerSetup: Record "General Ledger Setup";
                DimensionValueList: Page "Dimension Value List";
            begin
                //HEI.17
                GeneralLedgerSetup.GET();
                DimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Cost Center Dimension Code FND");
                DimensionValue.SETRANGE("Dimension Value Type", DimensionValue."Dimension Value Type"::Standard);
                DimensionValue.SETRANGE(Blocked, false);
                DimensionValueList.LOOKUPMODE(true);
                DimensionValueList.SETTABLEVIEW(DimensionValue);
                if DimensionValueList.RUNMODAL() = ACTION::LookupOK then begin
                    DimensionValueList.GETRECORD(DimensionValue);
                    "Cost Center Pr. Trans. Out FND" := DimensionValue.Code;
                end;
            end;
        }
        field(50034; "Cost Center Pr. Trans. Exp FND"; Code[20])
        {
            Caption = 'Cost Center for Primary Transport Export';
            DataClassification = CustomerContent;
            Description = 'HEI.17';

            trigger OnLookup();
            var
                DimensionValue: Record "Dimension Value";
                GeneralLedgerSetup: Record "General Ledger Setup";
                DimensionValueList: Page "Dimension Value List";
            begin
                //HEI.17
                GeneralLedgerSetup.GET();
                DimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Cost Center Dimension Code FND");
                DimensionValue.SETRANGE("Dimension Value Type", DimensionValue."Dimension Value Type"::Standard);
                DimensionValue.SETRANGE(Blocked, false);
                DimensionValueList.LOOKUPMODE(true);
                DimensionValueList.SETTABLEVIEW(DimensionValue);
                if DimensionValueList.RUNMODAL() = ACTION::LookupOK then begin
                    DimensionValueList.GETRECORD(DimensionValue);
                    "Cost Center Pr. Trans. Exp FND" := DimensionValue.Code;
                end;
            end;
        }
        field(50035; "Cost Center Sec. Trans.Out FND"; Code[20])
        {
            Caption = 'Cost Center for Secondary Transport';
            DataClassification = CustomerContent;
            Description = 'HEI.17';

            trigger OnLookup();
            var
                DimensionValue: Record "Dimension Value";
                GeneralLedgerSetup: Record "General Ledger Setup";
                DimensionValueList: Page "Dimension Value List";
            begin
                //HEI.17
                GeneralLedgerSetup.GET();
                DimensionValue.SETRANGE("Dimension Code", GeneralLedgerSetup."Cost Center Dimension Code FND");
                DimensionValue.SETRANGE("Dimension Value Type", DimensionValue."Dimension Value Type"::Standard);
                DimensionValue.SETRANGE(Blocked, false);
                DimensionValueList.LOOKUPMODE(true);
                DimensionValueList.SETTABLEVIEW(DimensionValue);
                if DimensionValueList.RUNMODAL() = ACTION::LookupOK then begin
                    DimensionValueList.GETRECORD(DimensionValue);
                    "Cost Center Sec. Trans.Out FND" := DimensionValue.Code;
                end;
            end;
        }
        // field(2013696; "Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Tax Group Code',
        //                 FRA = 'Code groupe magasin taxe';
        //     Description = 'DITW15.00.00.29';
        //     TableRelation = "Location Group";
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
        //                 FRA = 'N° AAD';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "No. Series";
        // }
        // field(2014062; "Purchasing Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Purchasing Code',
        //                 FRA = 'Code Achat';
        //     Description = 'DITW18.00.07 DIT-770 #1425';
        //     TableRelation = Purchasing;
        // }
        // field(2014063; "Manually Close Shipping Status"; Option)
        // {
        //     CaptionML = ENU = 'Manually Close Sales Lines From Shipping Status',
        //                 FRA = 'Fermer Manuellement les ligens commandes à partir du Statut Expédition';
        //     Description = 'DIT-770 #1702';
        //     OptionCaptionML = ENU = 'Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice',
        //                       FRA = 'Ouvert,Prélèvement imprimé,Affecté,Prélevé,Expédié,Retour terminée,Facturée';
        //     OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;
        // }
        // field(2014064; "Auto Create Shipping Cost"; Option)
        // {
        //     CaptionML = ENU = 'Auto Create Shipping Cost On Source Doc.',
        //                 FRA = 'Création automatique des frais de livraison sur document d''origine';
        //     Description = 'DIT-770 #1066';
        //     OptionCaptionML = ENU = ' ,Never,Always',
        //                       FRA = ' ,Jamais,Toujours';
        //     OptionMembers = " ",Never,Always;
        // }
        // field(2014065; "Manually Close Receipt Status"; Option)
        // {
        //     CaptionML = ENU = 'Manually Close Purchase Lines From Receipt Status',
        //                 FRA = 'Fermer manuellement les lignes achats à partir du statut réception';
        //     Description = 'DIT-770 #1703';
        //     OptionCaptionML = ENU = 'Open,Order Printed,Order Sent,Order Confirmed,To Receive,Receipt Completed,Invoice',
        //                       FRA = 'Ouvert,Commande Imprimée,Commande Envoyée,Commande Confirmée,A réceptionner,Réception Complete,Facturée';
        //     OptionMembers = Open,"Order Printed","Order Sent","Order Confirmed","To Receive","Receipt Completed",Invoice;
        // }
        // field(2014069; "Allow Calculate Weight Cubage"; Boolean)
        // {
        //     CaptionML = ENU = 'Allow Calculate Weight Cubage',
        //                 FRA = 'Autoriser Calcule Poids et Cubage';
        //     Description = 'DITW15.00.00.21';

        //     trigger OnValidate();
        //     var
        //         WhseActivHeader: Record "Warehouse Activity Header";
        //         WhseShptHeader: Record "Warehouse Shipment Header";
        //         WhseRcptHeader: Record "Warehouse Receipt Header";
        //     begin
        //         // <<DITW15.00.00.21 DDR 19/06/2008
        //         if "Directed Put-away and Pick" then
        //             TESTFIELD("Allow Calculate Weight Cubage", true);

        //         if "Allow Calculate Weight Cubage" then begin
        //         end else begin
        //             WhseActivHeader.SETRANGE("Location Code", Code);
        //             if WhseActivHeader.FINDFIRST then
        //                 ERROR(Text008,
        //                   FIELDCAPTION("Allow Calculate Weight Cubage"), xRec."Allow Calculate Weight Cubage", WhseActivHeader.TABLECAPTION);

        //             WhseRcptHeader.SETCURRENTKEY("Location Code");
        //             WhseRcptHeader.SETRANGE("Location Code", Code);
        //             if WhseRcptHeader.FINDFIRST then
        //                 ERROR(Text008,
        //                   FIELDCAPTION("Allow Calculate Weight Cubage"), xRec."Allow Calculate Weight Cubage", WhseRcptHeader.TABLECAPTION);

        //             WhseShptHeader.SETCURRENTKEY("Location Code");
        //             WhseShptHeader.SETRANGE("Location Code", Code);
        //             if WhseShptHeader.FINDFIRST then
        //                 ERROR(Text008,
        //                   FIELDCAPTION("Allow Calculate Weight Cubage"), xRec."Allow Calculate Weight Cubage", WhseShptHeader.TABLECAPTION);
        //         end;
        //         // >>DITW15.00.00.21 DDR
        //     end;
        // }
        // field(2014094; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014267; "Exclude from EMCS"; Boolean)
        // {
        //     CaptionML = ENU = 'Exclude from EMCS',
        //                 FRA = 'Exclure de EMCS';
        //     Description = 'DITW16.00.00.43 DIT-715 #733';
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
        //     OptionMembers = " ",TaxWhse,RConsignee,TempReg,DirDelivry,ExemptOrg,Export,,Unknow;
        // }
        // field(2014290; "Journey Time"; DateFormula)
        // {
        //     CaptionML = ENU = 'Journey Time (EMCS)',
        //                 FRA = 'Temps de trajet (EMCS)';
        //     Description = 'DITW15.00.00.39 #1353';
        // }
        // field(2014300; "Submission Type for Export"; Option)
        // {
        //     CaptionML = ENU = 'Submission Type for Export (EMCS)',
        //                 FRA = 'Type d''Envoi Pour Export (EMCS)';
        //     Description = 'DITW18.00.07 DIT-770 #1397';
        //     OptionCaptionML = ENU = ' ,Type 1,Type 2',
        //                       FRA = ' ,Type 1,Type 2';
        //     OptionMembers = " ","Type 1","Type 2";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW18.00.07 MVN 21/01/2016 DIT-770 #1397
        //         if not EMCSSetup.READPERMISSION then begin
        //             TESTFIELD("Submission Type for Export", 0);
        //         end else begin
        //             if "Submission Type for Export" <> 0 then begin
        //                 EMCSSetup.GET;
        //                 if EMCSSetup."Submission Type for Export" <> EMCSSetup."Submission Type for Export"::"Type 1/Type 2" then
        //                     TESTFIELD("Submission Type for Export", EMCSSetup."Submission Type for Export" + 1);
        //             end;
        //         end;
        //         // >>DITW18.00.07 MVN DIT-770 #1397
        //     end;
        // }
        // field(2014411; "Use As Finished Goods"; Boolean)
        // {
        //     CaptionML = ENU = 'Use As Finished Goods',
        //                 FRA = 'Magasin Produits Finis';
        //     Description = 'DITW17.10.06 DIT-770 #1198';
        // }
        // field(2014415; Indentation; Integer)
        // {
        //     CaptionML = ENU = 'Indentation',
        //                 FRA = 'Indentation';
        //     Description = 'DITW15.00.00.39 #1365';
        //     MinValue = 0;
        // }
        // field(2014418; "Indentation Line"; Integer)
        // {
        //     CaptionML = ENU = 'Indentation Line',
        //                 FRA = 'Ligne Indentation';
        //     Description = 'DITW15.00.00.39 #1365';
        // }
        // field(2014460; "Tax Office Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Office Code',
        //                 FRA = 'Code Bureau de taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Office";
        // }
        // field(2014481; "VAT Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'VAT Registration No.',
        //                 FRA = 'N° identif. intracomm.';
        //     Description = 'DITW15.00.00.38 #1217 (DIT711 136)';

        //     trigger OnValidate();
        //     var
        //         VATRegNoFormat: Record "VAT Registration No. Format";
        //     begin
        //         VATRegNoFormat.Test("VAT Registration No.", "Country/Region Code", Code, DATABASE::Location);
        //     end;
        // }
        // field(2014504; "No. of Location Relationships"; Integer)
        // {
        //     CalcFormula = Count("Location Relationship" where(Code = FIELD(Code)));
        //     CaptionML = ENU = 'No. of Location Relationships',
        //                 FRA = 'Nombre de magasins associées';
        //     Description = 'DITW15.00.00.39 #1365';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014509; "Use As Quarantine"; Boolean)
        // {
        //     CaptionML = ENU = 'Use As Quarantine',
        //                 FRA = 'Magasin de quarantaine';
        //     Description = 'DITW15.00.00.39 #1366';

        //     trigger OnValidate();
        //     begin
        //         if "Use As In-Transit" then begin
        //             TESTFIELD("Require Put-away", false);
        //             TESTFIELD("Require Pick", false);
        //             TESTFIELD("Use Cross-Docking", false);
        //             TESTFIELD("Require Receive", false);
        //             TESTFIELD("Require Shipment", false);
        //             TESTFIELD("Bin Mandatory", false);
        //         end;
        //     end;
        // }
        // field(2029610; "Shortcut Property 1 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,1/14';
        //     CaptionML = ENU = 'Shortcut Property 1 Code',
        //                 FRA = 'Code raccourci propriété 1';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(14),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(1));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 1 Code" := fctValidateShortcutPropertyCode(1, "Shortcut Property 1 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029611; "Shortcut Property 2 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,2/14';
        //     CaptionML = ENU = 'Shortcut Property 2 Code',
        //                 FRA = 'Code raccourci propriété 2';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(14),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(2));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 2 Code" := fctValidateShortcutPropertyCode(2, "Shortcut Property 2 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029612; "Shortcut Property 3 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,3/14';
        //     CaptionML = ENU = 'Shortcut Property 3 Code',
        //                 FRA = 'Code raccourci propriété 3';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(14),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(3));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 3 Code" := fctValidateShortcutPropertyCode(3, "Shortcut Property 3 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029613; "Shortcut Property 4 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,4/14';
        //     CaptionML = ENU = 'Shortcut Property 4 Code',
        //                 FRA = 'Code raccourci propriété 4';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(14),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(4));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 4 Code" := fctValidateShortcutPropertyCode(4, "Shortcut Property 4 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029614; "Shortcut Property 5 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,5/14';
        //     CaptionML = ENU = 'Shortcut Property 5 Code',
        //                 FRA = 'Code raccourci propriété 5';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(14),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(5));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 5 Code" := fctValidateShortcutPropertyCode(5, "Shortcut Property 5 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029615; "Shortcut Property 6 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,6/14';
        //     CaptionML = ENU = 'Shortcut Property 6 Code',
        //                 FRA = 'Code raccourci propriété 6';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(14),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(6));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 6 Code" := fctValidateShortcutPropertyCode(6, "Shortcut Property 6 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029616; "Shortcut Property 7 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,7/14';
        //     CaptionML = ENU = 'Shortcut Property 7 Code',
        //                 FRA = 'Code raccourci propriété 7';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(14),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(7));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 7 Code" := fctValidateShortcutPropertyCode(7, "Shortcut Property 7 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029617; "Shortcut Property 8 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,8/14';
        //     CaptionML = ENU = 'Shortcut Property 8 Code',
        //                 FRA = 'Code raccourci propriété 8';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(14),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(8));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 8 Code" := fctValidateShortcutPropertyCode(8, "Shortcut Property 8 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029618; "Shortcut Property 9 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,9/14';
        //     CaptionML = ENU = 'Shortcut Property 9 Code',
        //                 FRA = 'Code raccourci propriété 9';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(14),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(9));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 9 Code" := fctValidateShortcutPropertyCode(9, "Shortcut Property 9 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029619; "Shortcut Property 10 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,10/14';
        //     CaptionML = ENU = 'Shortcut Property 10 Code',
        //                 FRA = 'Code raccourci propriété 10';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(14),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(10));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 10 Code" := fctValidateShortcutPropertyCode(10, "Shortcut Property 10 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2034982; "Work Order Mandatory"; Boolean)
        // {
        //     CaptionML = ENU = 'Work Order Mandatory',
        //                 FRA = 'Commande d''intervention oblgatoire';
        //     Description = 'DIT-715 #457';

        //     trigger OnValidate();
        //     var
        //         lrecItemLedgerEntry: Record "Item Ledger Entry";
        //     begin
        //         // <<DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457
        //         if "Work Order Mandatory" and (not xRec."Work Order Mandatory") then begin
        //             lrecItemLedgerEntry.RESET;
        //             lrecItemLedgerEntry.SETCURRENTKEY("Work Order No.", "Work Order Line No.", "Location Code", "Item No.", Open);
        //             lrecItemLedgerEntry.SETRANGE("Work Order No.", '');
        //             lrecItemLedgerEntry.SETRANGE("Location Code", Code);
        //             lrecItemLedgerEntry.SETRANGE(Open, true);
        //             if not lrecItemLedgerEntry.ISEMPTY then
        //                 ERROR(Text2034942, FIELDCAPTION("Work Order Mandatory"));
        //         end;
        //     end;
        // }
        // field(2034983; "W.Order Alloc. Location Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Work Order Allocation Location Code',
        //                 FRA = 'Code magasin ventilation cmde. d''intervention';
        //     Description = 'DIT-715 #457';
        //     TableRelation = Location where("Use As In-Transit" = CONST(false));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457
        //         if "W.Order Alloc. Location Code" = Code then
        //             FIELDERROR("W.Order Alloc. Location Code");
        //         if xRec."W.Order Alloc. Location Code" <> "W.Order Alloc. Location Code" then
        //             VALIDATE("W. Order Allocation Bin Code", '');
        //     end;
        // }
        // field(2034984; "W. Order Allocation Bin Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Work Order Allocation Bin Code',
        //                 FRA = 'Code emplacement ventillation cmde. d''intervention';
        //     Description = 'DIT-715 #457';
        //     TableRelation = Bin.Code where("Location Code" = FIELD("W.Order Alloc. Location Code"));
        // }
        // field(2035040; "Preparation Bin Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Preparation Bin Code',
        //                 FRA = 'Code Emplacement Préparation';
        //     Description = 'DIT-715 #806';
        //     TableRelation = Bin.Code where("Location Code" = FIELD(Code));
        // }
        // field(2035041; "Default Picking Bin Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Default Picking Bin Code',
        //                 FRA = 'Code Emplacement Par Defaut';
        //     Description = 'DIT-715 #806';
        // }
        // field(2035042; "Default Tech. Bin Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Default Tech. Bin Code',
        //                 FRA = 'Code Emplacement Tech. Par Defaut';
        //     Description = 'DIT-715 #806';
        //     TableRelation = Bin.Code where("Location Code" = FIELD(Code));
        // }
        // field(2035043; "Skip Consumption Put-Away"; Boolean)
        // {
        //     CaptionML = ENU = 'Skip Consumption Put-Away',
        //                 FRA = 'Sauter La Consommation Rangement';
        //     Description = 'DIT-715 #806';
        // }
        // field(2035044; "Release Receipt to Scanner"; Boolean)
        // {
        //     CaptionML = ENU = 'Release Receipt to Scanner',
        //                 FRA = 'Lancer réception au scanner';
        //     Description = 'DIT-715 #806';
        // }
        // field(2035045; "Auto Post Put-away"; Boolean)
        // {
        //     CaptionML = ENU = 'Auto Post Put-away',
        //                 FRA = 'Valider Automatiqument les Rangements';
        //     Description = 'DIT-715 #806';
        // }
        // field(2035058; "Use FEFO Tracking Add-Bins"; Boolean)
        // {
        //     CaptionML = ENU = 'Explode FEFO Tracking on Additionnal Bins (Item Journal)',
        //                 FRA = 'Eclater Tracibilité FEFO sur emplacements secondaires (Feuille article)';
        //     Description = 'DITW16.00.00.40 #1331';
        // }
        // field(2035090; "Auto.Create QualityTest Method"; Option)
        // {
        //     CaptionML = ENU = 'Auto  Tests Creation on Transfer',
        //                 FRA = 'Méthode auto. création des tests de qualité';
        //     Description = 'QXL9.00.001';
        //     OptionCaptionML = ENU = ' ,Location,Bin,Both',
        //                       FRA = ' ,Magasin,Emplacement,Les deux';
        //     OptionMembers = " ",Location,Bin,Both;
        // }
        // field(2036302; "Blocked Bin Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Blocked Bin Code',
        //                 FRA = 'Code emplacement bloqué';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = Bin.Code where("Location Code" = FIELD(Code));
        // }
        // field(2036303; "Scrap Bin Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Scrap Bin Code',
        //                 FRA = 'Code emplacement rebut';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = Bin.Code where("Location Code" = FIELD(Code));
        // }  // BC Upgrade NANDIS03
    }
    // keys
    // {
    //     key(Key1; "Location Group Code")
    //     {
    //     }
    //     key(Key2; "Tax Registration No.")
    //     {
    //     }
    //     key(Key3; "Indentation Line", Indentation, "Code")
    //     {
    //     }
    // }  // BC Upgrade NANDIS03


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    StockkeepingUnit.SETRANGE("Location Code",Code);
    IF NOT StockkeepingUnit.ISEMPTY THEN
      ERROR(CannotDeleteLocSKUExistErr,Code);

    WMSCheckWarehouse;
    #6..10
    TransferRoute.DELETEALL;

    WhseEmployee.SETRANGE("Location Code",Code);
    WhseEmployee.DELETEALL(TRUE);

    WorkCenter.SETRANGE("Location Code",Code);
    IF WorkCenter.findset(TRUE) THEN
      REPEAT
        WorkCenter.VALIDATE("Location Code",'');
        WorkCenter.MODIFY(TRUE);
      UNTIL WorkCenter.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    StockkeepingUnit.SETRANGE("Location Code",Code);
    if not StockkeepingUnit.ISEMPTY then
    #3..13
    WhseEmployee.DELETEALL(true);

    WorkCenter.SETRANGE("Location Code",Code);
    if WorkCenter.findset(true) then
      repeat
        WorkCenter.VALIDATE("Location Code",'');
        WorkCenter.MODIFY(true);
      until WorkCenter.NEXT = 0;

    // <<DITW15.00.00.39 DDR 15/09/2011 #1365
    LocationRelation.RESET;
    LocationRelation.SETRANGE(Code,Code);
    LocationRelation.DELETEALL(true);
    // >>DITW15.00.00.39 DDR #1365
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "GetRequirementText(PROCEDURE 6).Text000(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //GetRequirementText : ENU=Shipment,Receive,Pick,Put-Away;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //GetRequirementText : ENU=Shipment,Receive,Pick,Put-Away;FRA=Expédition,Réception,Prélèvement,Rangement;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text000(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot delete the %1 %2, because they contain items.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot delete the %1 %2, because they contain items.;FRA=Vous ne pouvez pas supprimer l'enregistrement %1 %2, car il contient des articles.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot delete the %1 %2, because one or more Warehouse Activity Lines exist for this %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot delete the %1 %2, because one or more Warehouse Activity Lines exist for this %1.;FRA=Vous ne pouvez pas supprimer le %1 %2, car il existe au moins une ligne activité entrepôt pour ce %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=%1 must be Yes, because the bins contain items.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=%1 must be Yes, because the bins contain items.;FRA=La valeur du champ %1 doit être Oui car les emplacements contiennent des articles.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Cancelled.;FRA=Annulé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=The total quantity of items in the warehouse is 0, but the Adjustment Bin contains a negative quantity and other bins contain a positive quantity.\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=The total quantity of items in the warehouse is 0, but the Adjustment Bin contains a negative quantity and other bins contain a positive quantity.\;FRA=La quantité totale d'articles dans le entrepôt est 0, mais l'emplacement ajustement comporte une quantité négative et d'autres emplacements une quantité positive.\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=Do you still want to delete this %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=Do you still want to delete this %1?;FRA=Souhaitez-vous quand même supprimer cet enregistrement %1?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=You cannot change the %1 until the inventory stored in %2 %3 is 0.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=You cannot change the %1 until the inventory stored in %2 %3 is 0.;FRA=Vous ne pouvez pas modifier la valeur du champ %1 tant que le stock du %2 %3 est 0.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You have to delete all Adjustment Warehouse Journal Lines first before you can change the %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You have to delete all Adjustment Warehouse Journal Lines first before you can change the %1.;FRA=Vous devez supprimer toutes les lignes feuille entrepôt ajustement avant de pouvoir modifier la valeur du champ %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=%1 must be %2, because one or more %3 exist.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=%1 must be %2, because one or more %3 exist.;FRA=La valeur %1 doit être %2, car il existe au moins un %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=You cannot change %1 because there are one or more open ledger entries on this location.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=You cannot change %1 because there are one or more open ledger entries on this location.;FRA=Vous ne pouvez pas modifier la valeur %1 car il existe une ou plusieurs écritures comptables ouvertes pour cet emplacement.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=Checking item ledger entries for open entries...;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : ENU=Checking item ledger entries for open entries...;FRA=Vérification des écritures comptables article pour les écritures ouvertes...;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1016)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=You cannot change the %1 to %2 until the inventory stored in this bin is 0.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=You cannot change the %1 to %2 until the inventory stored in this bin is 0.;FRA=Vous ne pouvez pas remplacer %1 par %2 tant que le stock placé dans cet emplacement n'est pas de 0.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;FRA=Avant de pouvoir utiliser Online Map, vous devez compléter la fenêtre Configuration Online Map.\Consultez la section Configuration d'Online Map dans l'Aide.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text013(Variable 1018)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=You cannot delete %1 because there are one or more ledger entries on this location.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=You cannot delete %1 because there are one or more ledger entries on this location.;FRA=Vous ne pouvez pas supprimer la valeur %1 car il existe une ou plusieurs écritures comptables pour cet emplacement.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text014(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : ENU=You cannot change %1 because one or more %2 exist.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : ENU=You cannot change %1 because one or more %2 exist.;FRA=Vous ne pouvez pas modifier %1 car il existe un ou plusieurs %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotDeleteLocSKUExistErr(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotDeleteLocSKUExistErr : @@@=%1: Field(Code);ENU=You cannot delete %1 because one or more stockkeeping units exist at this location.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotDeleteLocSKUExistErr : @@@=%1: Field(Code);ENU=You cannot delete %1 because one or more stockkeeping units exist at this location.;FRA=You cannot delete %1 because one or more stockkeeping units exist at this location.;
    //Variable type has not been exported.

    var
        //LocationRelation: Record "Location Relationship";  // BC Upgrade NANDIS03
        Text2034942: TextConst ENU = 'You cannot change %1 because there are one or more open item ledger entries without work order nos. for this location.', FRA = 'Vous ne pouvez pas modifier %1 car il existe des écritures comptables article ouvertes associées à ce magasin sans n° de cmde. d''intervention.';
    //EMCSSetup: Record "EMCS Setup";  // BC Upgrade NANDIS03
}

