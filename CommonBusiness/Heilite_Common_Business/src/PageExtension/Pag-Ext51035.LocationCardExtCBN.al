pageextension 51035 LocationCardExtCBN extends "Location Card"
{
    // version NAVW110.0,FINXL10.00,MANXL7.00.001,QXL10.01,DITW110.00.11,HEI.16
    // DITW15.00.00.01 DDR 26/12/2007 Added Drink-it Tax Item Charges functionnalities
    // DITW15.00.00.01 DDR 27/12/2007 added fields
    //                                  2034676 Use As Duty
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.21 DDR 19/06/2008 Added field "Allow Calculate Weight Cubage" (linking to field "Directed Put-away and Pick")
    // DITW15.00.00.25 DDR 21/10/2008 Removed field "Use As Duty"
    // DITW15.00.00.28 DDR 24/11/2008 Added tab 'Drink-It'
    //                                Added fields "Tax Registration No.","ADD Nos." into 'Drink-It' tab
    // DITW15.00.00.29 DDR 22/12/2008 Added fields "Location Group Code" into 'Drink-It' tab
    //                                Added menu "Internal Ta&x Item Charges" + group into "Location" button
    // DITW15.00.00.35 DLE 06/09/2009 issue 516 Added field "Physical Location Group Code"
    //                                  Added "Physical Location Group Code" + Group into "Location" button
    // DITW15.00.00.37 DDR 10/06/2010 issue 1061 Modified LookupFormID property for fields
    //                                             "Location Group Code","Physical Location Group Code"
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151 Added 'Quality' tab + fields
    // DITW15.00.00.38 DDR 16/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields into 'Drink-it' tab
    //                                    "Tax Office Code","Consignor Type","Tax Warehouse Reference","Type of Origin"
    //                     05/10/2010   Added fields into tab Drink-It
    //                                    "Type of Origin","Destination Type"
    //                     17/12/2010 issue 458 Added menu Sales/Purchase Tax per Location group
    //                     27/01/2011 issue 1217 (DIT711 136) Added fields "VAT Registration No." into 'Drink-it' tab
    // DITW16.00.00.37 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Bugfix RunPageLink menus Tax Charges (sales/purchase)
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added field "Journey Time" (Drink-It)
    // DITW15.00.00.39 DDR 19/08/2011 issue 1366 Added field "Use As Quarantine" (General & Drink-It)
    //                     15/09/2011 issue 1343 Modified Caption for "Location Group Code" field
    //                     15/09/2011 issue 1365 Added field "Parent Location Relationship"
    // DITW16.00.00.40 DDR 09/03/2012 #1331 Added fields "Use FEFO Tracking Add-Bins"
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added 'Maintenance' tab
    //                                             Added fields into 'Maintenance' tab
    //                                               "Work Order Mandatory","W.Order Alloc. Location Code","W.Order Allocation Bin Code"
    // DITW16.00.00.43 DDR 02/09/2013 DIT-715 #733 Added fields "Exclude from EMCS " (Drink-It tab)
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM

    // MANXL7.00.001 DAT 26/02/2014 #6: added posting bins

    // DITW17.00.02 DDR 17/05/2013 DIT-770 #95 Added fields "Name 2"
    //                  31/05/2013 DIT-770 #100 Added fields "UK Deferment Account Num Type","UK Deferment Account No." (tab Tax Report UK)
    //                  04/06/2013 DIT-770 #100 Added fields "Customer No."
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #95 #100
    //              DDR 04/09/2013 DIT-715 #733 merge
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.05 WSA 10/10/2014 DIT-770 #930 Added field "Default Origin Type"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 DDR 26/01/2015 DIT-770 #271 Modified workflow "Allow Calculate Weight Cubage"
    // DITW18.00.06 MSF 06/02/2015 DIT-770 #1180 Added Field "Responsibility Center"
    // DITW18.00.06 AKH 12/02/2015 DIT-770 #1198 Multisite - Items by Location : Displayed Field "Finished Goods Location"
    // DITW18.00.06 MSF 19/02/2015 DIT-770 #1180 Delete Field "Responsibility Center"
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.07 MVN 15/01/2016 DIT-770 #1397 Added Field 2014300 "Submission Type for Export" (Drink-It)
    // DITW18.00.07 VSC 16/02/2016 DIT-770 #1703 New fields for managing partial Warehouse shipments\receipts
    //                                           "No Whse Shipment Backorder" , "No Whse Receipt Backorder"
    // DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Moved Field 2014300 "Submission Type for Export" to EMCS fields
    // DITW18.00.07 AKH 29/02/2016 DIT-770 #1425 Automatic Drop Shipments and Special orders: Added field "Purchasing Code"
    // DITW18.00.07 VSC 01/03/2016 DIT-770 #1702 Add New Field "Manually Close Shipping Status"
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 New Field "Auto Create Shipping Cost"
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW18.00.07 VSC 18/06/2016 DIT-770 #1703 Add new field "Manually Close Receipt Status"
    // DITW19.00.08A AKH 06/01/2017 BL#17581 Deleted field "Default Origin Type" (Related to DE Beertax)
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL10.00 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1 Changed PromotedCategory of "Properties" button
    // DITW110.00.09 YHE 15/03/2017 NRQ#24111 merge DIT2016 W1 R8A
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Removed "No Whse Shipment Backorder" since it won't be used anymore.
    // DITW110.00.10 VSC 26/07/2017 NRQ#27479 Add Missing field "Preparation Bin Code" on page
    // DITW110.00.11 VSC 26/09/2017 NRQ#30577 Merge - QXL10.01 VSC 26/09/2017 NRQ#38341 : Multisite – Quality tracking per Location
    // DITW110.00.11 VSC 03/10/2017 NRQ#33755 Removed Group Warehouse and Field "No Whse Receipt Backorder"
    // DITW110.00.12 AKH 30/03/2018 NRQ#16026 Order Shipment Planning: Sync Sales - Transfer
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #new fields Transit Zone,Zone Mandatory,Transit Bin
    // HEI.02 FDD-PRDGAP004 IBM.NAIKH01
    //   # Addded a new field "Plant ID" and "Batch sequential number"
    // HEI.04 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Group created" "Gate Control"
    //   # New Fields added: "Purchase Gate Entry Mandatory", "Sales Gate Entry Mandatory", "Transfer Gate Entry Mandatory", "Gate Weighing Mandatory"
    // HEI.05 RFC-CHG0248455 IBM.LS 03.12.2018
    //   # New Field added: "Warning Threshold Days"
    // HEI.06 FDD-HT620 IBM BULIMC01 02.08.2019 #new field displayed "Consump. Tolerance Limit %"
    // HEI.07 FDD_CHG2030239 FA Master Data IBM  SAXENS01 17.09.2019
    //   Added new field "InBound Automatic Registration" and "Enable Inbound Validation"
    // HEI.08 CHG2008448 IBM.LS 12.12.2019
    //   # New Fields added: "Print Invoice for W/h Ship."
    //                     : "Print DN for W/h Ship."
    //                     : "Print Load Note for W/h Ship."
    // HEI.09 FDD-HT1075 CHG2039144 IBM.GUNERE01 14.01.2020 # Field 50027 : Create Doc. Shipping Cost On field added
    //                                                                      "Auto Create Shipping Cost" made visible false
    // HEI.10 CHG2010375 IBM.LS 22.01.2020
    //   # New Fields added: "Printer Name"
    // HEI.11 FDD-HB503 IBM NASTAA02 30.01.2019 # Post & Print
    //   # New Field added: "Print DN (Sales Inv)"
    // HEI.12 CHG2010375 IBM.LS 12.02.2020
    //   # New Field added: "Logistics E-Mail"
    // HEI.13 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Field added: "IC Partner Code"
    // HEI.14 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # new field added in General tab: Store
    // HEI.15 CHG2164305 IBM COSTES04 20.12.2022 - Primary_Secondary CCC Shipping Cost Allocation
    //   # New fields Cost Center Pr. Trans. Out. , Cost Center Pr. Trans. Export, Cost Center Sec. Trans. Out.
    // HEI.16 CHG2149734 SAHAL01 24.03.2023 Astro - I/F Production - ProductionOrderSync
    //   # Added New Field - Allow to Astro
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a location code for the warehouse or distribution center where your items are handled and stored before being sold.', FRA = 'Spécifie un code magasin pour l''entrepôt ou le centre de distribution gérant et stockant les articles avant leur vente.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name or address of the location.', FRA = 'Spécifie le nom ou l''adresse du magasin.';
        }
        modify(Address)
        {
            ToolTipML = ENU = 'Specifies the location address.', FRA = 'Spécifie l''adresse du magasin.';
        }
        modify("Address 2")
        {
            ToolTipML = ENU = 'Specifies an additional line of the location address.', FRA = 'Spécifie une ligne supplémentaire à l''adresse du magasin.';
        }
        modify("Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the location.', FRA = 'Spécifie le code postal du magasin.';
        }
        modify(City)
        {
            ToolTipML = ENU = 'Specifies the city of the address.', FRA = 'Spécifie la ville de l''adresse.';
        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region of the location.', FRA = 'Spécifie le pays/la région du magasin.';
        }
        modify(Contact)
        {
            ToolTipML = ENU = 'Specifies the name of the contact person to whom items for the location will be shipped.', FRA = 'Spécifie le nom de la personne à qui les articles de l''emplacement doivent être livrés.';
        }
        modify("Use As In-Transit")
        {
            ToolTipML = ENU = 'Specifies this location is an in-transit location.', FRA = 'Indique que ce magasin est un magasin de transit.';
        }
        // modify(Communication)
        // {
        //     CaptionML = ENU = 'Communication', FRA = 'Communication';
        // }  // BC Upgrade NANDIS03
        modify("Phone No.")
        {
            ToolTipML = ENU = 'Specifies the telephone number of the location.', FRA = 'Indique le numéro de téléphone du magasin.';
        }
        modify("Fax No.")
        {
            ToolTipML = ENU = 'Specifies the fax number of the location.', FRA = 'Indique le numéro de télécopie du magasin.';
        }
        modify("E-Mail")
        {
            ToolTipML = ENU = 'Specifies the email address of the location.', FRA = 'Spécifie l''adresse électronique du magasin.';
        }
        modify("Home Page")
        {
            ToolTipML = ENU = 'Specifies the home page address of the location.', FRA = 'Spécifie la page d''accueil du magasin.';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Require Receive")
        {
            ToolTipML = ENU = 'Specifies whether you require the location to use the Receive function on the Warehouse Management menu.', FRA = 'Indique si le magasin doit utiliser la fonction Réceptionner du menu Distribution - Entrepôts.';
        }
        modify("Require Shipment")
        {
            ToolTipML = ENU = 'Specifies whether you require the location to use the Shipment function on the Warehouse Management menu.', FRA = 'Indique si le magasin doit utiliser la fonction Expédition du menu Distribution - Entrepôts.';
        }
        modify("Require Put-away")
        {
            ToolTipML = ENU = 'Specifies whether you must perform put-away activities in the warehouse at this location.', FRA = 'Indique si vous devez effectuer des activités de rangement dans l''entrepôt de ce magasin.';
        }
        modify("Use Put-away Worksheet")
        {
            ToolTipML = ENU = 'Specifies that put-always are not created for direct action by warehouse employees, when you post a warehouse receipt.', FRA = 'Spécifie que les rangements ne sont pas créés en vue d''une action directe de la part des magasiniers lorsque vous validez une réception entrepôt.';
        }
        modify("Require Pick")
        {
            ToolTipML = ENU = 'Specifies whether you must perform pick activities in the warehouse at this location.', FRA = 'Indique si vous devez effectuer des prélèvements dans l''entrepôt de ce magasin.';
        }
        modify("Bin Mandatory")
        {
            ToolTipML = ENU = 'Specifies that this location should use bins in all transactions with items.', FRA = 'Spécifie que le magasin doit utiliser des emplacements dans toutes les transactions portant sur des articles.';
        }
        modify("Directed Put-away and Pick")
        {
            ToolTipML = ENU = 'Specifies if you require the location to use advanced warehouse functionality, such as calculated bin suggestion.', FRA = 'Indique si vous voulez que le magasin utilise une fonctionnalité entrepôt évoluée comme le calcul de suggestion d''emplacement.';
        }
        modify("Use ADCS")
        {
            ToolTipML = ENU = 'Specifies the automatic data capture system that warehouse employees must use to keep track of items within the warehouse.', FRA = 'Spécifie le système de saisie automatisée dont les magasiniers doivent se servir pour effectuer le suivi des articles en entrepôt.';
        }
        modify("Default Bin Selection")
        {
            ToolTipML = ENU = 'Specifies the method used to select the default bin.', FRA = 'Spécifie la méthode utilisée pour sélectionner l''emplacement par défaut.';
        }
        modify("Outbound Whse. Handling Time")
        {
            ToolTipML = ENU = 'Specifies a date formula for the outbound warehouse handling time for the location.', FRA = 'Spécifie une formule de date pour le délai désenlogement pour le magasin.';
        }
        modify("Inbound Whse. Handling Time")
        {
            ToolTipML = ENU = 'Specifies a date formula for the inbound warehouse handling time for the location.', FRA = 'Spécifie une formule de date pour le délai enlogement pour le magasin.';
        }
        modify("Base Calendar Code")
        {
            ToolTipML = ENU = 'Specifies the code for the base calendar you want to assign to your location.', FRA = 'Spécifie le code du calendrier principal que vous souhaitez affecter à votre magasin.';
        }
        modify("Customized Calendar")
        {
            CaptionML = ENU = 'Customized Calendar', FRA = 'Calendrier personnalisé';
            ToolTipML = ENU = 'Indicates whether you have set up a customized calendar for the location.', FRA = 'Spécifie si vous avez configuré un calendrier personnalisé pour le magasin.';
        }
        modify("Use Cross-Docking")
        {
            ToolTipML = ENU = 'Specifies if you want to activate the cross-docking functionality at the location.', FRA = 'Indique si vous souhaitez activer la fonctionnalité de transbordement dans le magasin.';
        }
        modify("Cross-Dock Due Date Calc.")
        {
            ToolTipML = ENU = 'Specifies the cross-dock due date calculation.', FRA = 'Spécifie le délai transbordement.';
        }
        modify(Bins)
        {
            CaptionML = ENU = 'Bins', FRA = 'Emplacements';
        }
        modify(Receipt)
        {
            CaptionML = ENU = 'Receipt', FRA = 'Réception';
        }
        modify("Receipt Bin Code")
        {
            ToolTipML = ENU = 'Specifies the default receipt bin code.', FRA = 'Indique le code emplacement de réception par défaut.';
        }
        modify(Shipment)
        {
            CaptionML = ENU = 'Shipment', FRA = 'Expédition';
        }
        modify("Shipment Bin Code")
        {
            ToolTipML = ENU = 'Specifies the default shipment bin code.', FRA = 'Indique le code emplacement d''expédition par défaut.';
        }
        modify(Production)
        {
            CaptionML = ENU = 'Production', FRA = 'Fabrication';
        }
        modify("Open Shop Floor Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin that functions as the default open shop floor bin at this location.', FRA = 'Spécifie l''emplacement qui fonctionne comme emplacement atelier ouvert par défaut dans ce magasin.';
        }
        modify("To-Production Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin in the production area where components picked for production are placed by default, before they can be consumed.', FRA = 'Spécifie l''emplacement dans la zone de production où les composants qui sont prélevés pour la production sont stockés par défaut avant de pouvoir être consommés.';
        }
        modify("From-Production Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin in the production area, where finished end items are taken from by default, when the process involves warehouse activity.', FRA = 'Spécifie l''emplacement dans la zone de production où les produits finis sont extraits par défaut si le processus implique l''activité entrepôt.';
        }
        modify(Adjustment)
        {
            CaptionML = ENU = 'Adjustment', FRA = 'Ajustement';
        }
        modify("Adjustment Bin Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin in which you record observed differences in inventory quantities.', FRA = 'Indique le code emplacement dans lequel vous enregistrez les différences observées dans les quantités de stock.';
        }
        modify("Cross-Dock")
        {
            CaptionML = ENU = 'Cross-Dock', FRA = 'Transbordement';
        }
        modify("Cross-Dock Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin code that is used as default for the receipt of items to be cross-docked.', FRA = 'Indique le code emplacement utilisé comme valeur par défaut pour la réception des articles devant faire l''objet d''un transbordement.';
        }
        modify(Assembly)
        {
            CaptionML = ENU = 'Assembly', FRA = 'Assemblage';
        }
        modify("To-Assembly Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin in the assembly area where components are placed by default before they can be consumed in assembly.', FRA = 'Spécifie l''emplacement dans la zone d''assemblage où les composants sont stockés par défaut avant de pouvoir être consommés dans l''assemblage.';
        }
        modify("From-Assembly Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin in the assembly area where finished assembly items are posted to when they are assembled to stock.', FRA = 'Spécifie l''emplacement de la zone d''assemblage au niveau duquel les articles d''assemblage terminés sont validés lorsqu''ils sont associés au stock.';
        }
        modify("Asm.-to-Order Shpt. Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin where finished assembly items are posted to when they are assembled to a linked sales order.', FRA = 'Spécifie l''emplacement au niveau duquel les articles d''assemblage terminés sont validés lorsqu''ils sont associés à une commande vente.';
        }
        modify("Bin Policies")
        {
            CaptionML = ENU = 'Bin Policies', FRA = 'Config. emplacement';
        }
        modify("Special Equipment")
        {
            ToolTipML = ENU = 'Indicates where the program will first look for a special equipment designation for warehouse activities.', FRA = 'Indique le premier endroit où le programme recherche une désignation d''équipement spécial pour les activités de l''entrepôt.';
        }
        modify("Bin Capacity Policy")
        {
            ToolTipML = ENU = 'Defines how bins are automatically filled, according to their capacity.', FRA = 'Définit le remplissage automatique des emplacements en fonction de leur capacité.';
        }
        modify("Allow Breakbulk")
        {
            ToolTipML = ENU = 'Specifies the order is met with items stored in alternate units of measure, if an item stored in the requested unit of measure is not found.', FRA = 'Spécifie que la commande est remplie avec les articles stockés dans d''autres unités si un article stocké dans l''unité de mesure demandée dans un ordre de désenlogement est introuvable.';
        }
        modify("Put-away")
        {
            CaptionML = ENU = 'Put-away', FRA = 'Rangement';
        }
        modify("Put-away Template Code")
        {
            ToolTipML = ENU = 'Specifies the code of the put-away template used for the location.', FRA = 'Spécifie le code du modèle de rangement utilisé pour le magasin.';
        }
        modify("Always Create Put-away Line")
        {
            ToolTipML = ENU = 'Specifies that a put-away line is created, even if an appropriate zone and bin in which to place the items cannot be found.', FRA = 'Spécifie qu''une ligne rangement est créée même si une zone et un emplacement appropriés dans lesquels placer les articles sont introuvables.';
        }
        modify(Pick)
        {
            CaptionML = ENU = 'Pick', FRA = 'Prélèvement';
        }
        modify("Always Create Pick Line")
        {
            ToolTipML = ENU = 'Specifies that a pick line is created, even if an appropriate zone and bin from which to pick the item cannot be found.', FRA = 'Spécifie qu''une ligne prélèvement est créée même si une zone et un emplacement appropriés à partir desquels prélever l''article sont introuvables.';
        }
        modify("Pick According to FEFO")
        {
            ToolTipML = ENU = 'Specifies whether to use the First-Expired-First-Out (FEFO) method to determine which items to pick, according to expiration dates.', FRA = 'Spécifie si la méthode FEFO (First-Expired-First-Out, premier expiré, premier sorti) est utilisée ou non pour déterminer les articles suivis à prélever en fonction de leur date d''expiration.';
        }
        addafter(Name)
        {
            field("Name 2"; Rec."Name 2")
            {
                Importance = Additional;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Name 2 field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Name 2 field.';

            }
        }
        addafter("Use As In-Transit")
        {
            // field("Use As Finished Goods"; Rec."Use As Finished Goods")
            // {
            // }
            // field("Use As Quarantine"; Rec."Use As Quarantine")
            // {
            // }
            // field("No. of Location Relationships"; Rec."No. of Location Relationships")
            // {
            // }
            // field("Purchasing Code"; Rec."Purchasing Code")
            // {
            // }  // BC Upgrade NANDIS03
            field("Plant ID"; Rec."Plant ID FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Plant ID field.';
                // BC Upgrade NANDIS03                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ToolTip = 'Specifies the value of the Plant ID field.';

            }
            field("Batch sequential number"; Rec."Batch sequential number FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Batch sequential number field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Batch sequential number field.';

            }
            field("Warning Threshold Days"; Rec."Warning Threshold Days FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Expiry Warning Threshold Days field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Expiry Warning Threshold Days field.';

            }
            field("Consump. Tolerance Limit %"; Rec."Consump. Tolerance Limit % FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Consump. Tolerance Limit % field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Consump. Tolerance Limit % field.';

            }
            field("Print Invoice"; Rec."Print Invoice FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print Invoice field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Print Invoice field.';

            }
            field("Print DN (Sales Ship)"; Rec."Print DN (Sales Ship) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print Delivery Note (Sales Shipment) field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Print Delivery Note (Sales Shipment) field.';

            }
            field("Print DN (Whse Ship)"; Rec."Print DN (Whse Ship) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print Delivery Note (Whse Shipment) field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Print Delivery Note (Whse Shipment) field.';

            }
            field("Print Loading Note"; Rec."Print Loading Note FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print Loading Note field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Print Loading Note field.';

            }
            field("Printer Name"; Rec."Printer Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Printer Name field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Printer Name field.';

            }
            field("IC Partner Code"; Rec."IC Partner Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the IC Partner Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the IC Partner Code field.';

            }
            field(Store; Rec."Store FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the STORE field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the STORE field.';

            }
            field("Allow to Astro"; Rec."Allow to Astro FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow to Astro field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Allow to Astro field.';

            }
        }
        addafter("Home Page")
        {
            field("Logistics E-Mail"; Rec."Logistics E-Mail FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Logistics E-Mail field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Logistics E-Mail field.';

            }
        }
        addafter("Use ADCS")
        {
            // field("Allow Calculate Weight Cubage"; Rec."Allow Calculate Weight Cubage")
            // {

            //     trigger OnValidate();
            //     begin
            //         UpdateEnabled;
            //     end;
            // }  // BC Upgrade NANDIS03
        }
        addafter("Cross-Dock Due Date Calc.")
        {
            // field("Skip Consumption Put-Away"; Rec."Skip Consumption Put-Away")
            // {
            //     Description = 'DIT-715 #806';
            // }
            // field("Release Receipt to Scanner"; Rec."Release Receipt to Scanner")
            // {
            //     Description = 'DIT-715 #806';
            // }
            // field("Auto Post Put-away"; Rec."Auto Post Put-away")
            // {
            //     Description = 'DIT-715 #806';
            // }  // BC Upgrade NANDIS03
            group(Heilite)
            {
                Caption = 'Heilite';
                group(Control50001)
                {
                    Caption = 'Warehouse';
                    field("Zone Mandatory"; Rec."Zone Mandatory FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Zone Mandatory field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the Zone Mandatory field.';

                    }
                    field("Transit Zone"; Rec."Transit Zone FND")
                    {
                        ApplicationArea = All;  // BC Upgrade NANDIS03
                        LookupPageID = "Zone List";
                        ToolTip = 'Specifies the value of the Transit Zone field.';
                    }
                    field("Transit Bin"; Rec."Transit Bin FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Transit Bin field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the Transit Bin field.';

                    }
                }
                group("Cash Van Sales")
                {
                    Caption = 'Cash Van Sales';
                    field("Van Sales Route"; Rec."Van Sales Route FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Van Sales Route field.';
                        // BC Upgrade NANDIS03                        ToolTip = 'Specifies the value of the Van Sales Route field.';

                    }
                }
            }
        }
        addafter("Shipment Bin Code")
        {
            // field("Default Picking Bin Code"; Rec."Default Picking Bin Code")
            // {
            //     Description = 'DIT-715 #806';
            // }
            // field("Preparation Bin Code"; Rec."Preparation Bin Code")
            // {
            //     Description = 'NRQ#27479';
            // }  // BC Upgrade NANDIS03
        }
        addafter(Assembly)
        {
            group(Posting)
            {
                CaptionML = ENU = 'Posting',
                            FRA = 'Validation';
                Description = 'MANXL7.00.001';
                // field("Blocked Bin Code"; Rec."Blocked Bin Code")
                // {
                //     Description = 'MANXL7.00.001';
                // }
                // field("Scrap Bin Code"; Rec."Scrap Bin Code")
                // {
                //     Description = 'MANXL7.00.001';
                // }  // BC Upgrade NANDIS03
            }
        }
        // addafter("Allow Breakbulk")
        // {
        //     field("Use FEFO Tracking Add-Bins"; Rec."Use FEFO Tracking Add-Bins")
        //     {
        //     }
        // }  // BC Upgrade NANDIS03
        addafter("Bin Policies")
        {
            group("Drink-It")
            {
                CaptionML = ENU = 'Drink-It',
                            FRA = 'Drink-It';
                group(Taxes)
                {
                    CaptionML = ENU = 'Taxes',
                                FRA = 'Impôts et Taxes';
                    // field("Tax Registration No."; Rec."Tax Registration No.")
                    // {
                    // }
                    // field("AAD Nos."; Rec."AAD Nos.")
                    // {
                    // }
                    // field("Tax Office Code"; Rec."Tax Office Code")
                    // {
                    // }
                    // field("Consignor Type"; Rec."Consignor Type")
                    // {
                    // }
                    // field("Tax Warehouse Reference"; Rec."Tax Warehouse Reference")
                    // {
                    // }
                    // field("Type of Origin"; Rec."Type of Origin")
                    // {
                    // }
                    // field("Destination Type"; Rec."Destination Type")
                    // {
                    // }
                    // field("VAT Registration No."; Rec."VAT Registration No.")
                    // {
                    // }
                    // field("Location Group Code"; Rec."Location Group Code")
                    // {
                    //     LookupPageID = "Location Groups";
                    // }
                    // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                    // {
                    //     LookupPageID = "Physical Location Groups";
                    // }
                    // field("Exclude from EMCS"; Rec."Exclude from EMCS")
                    // {
                    // }
                    // field("Journey Time"; Rec."Journey Time")
                    // {
                    // }
                    // field("Submission Type for Export"; Rec."Submission Type for Export")
                    // {
                    // }  // BC Upgrade NANDIS03
                }
                group(Shipping)
                {
                    CaptionML = ENU = 'Shipping',
                                FRA = 'Livraison';
                    // field("Manually Close Shipping Status"; Rec."Manually Close Shipping Status")
                    // {
                    // }
                    // field("Manually Close Receipt Status"; Rec."Manually Close Receipt Status")
                    // {
                    //     Description = 'DIT-770 #1703';
                    // }
                    // field("Auto Create Shipping Cost"; Rec."Auto Create Shipping Cost")
                    // {
                    //     Enabled = false;
                    //     Visible = false;
                    // }  // BC Upgrade NANDIS03
                    field("Create Doc. Shipping Cost On"; Rec."Create Doc. Ship. Cost On FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Create Doc. Shipping Cost On field.';
                        // BC Upgrade NANDIS03                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ToolTip = 'Specifies the value of the Create Doc. Shipping Cost On field.';

                    }
                }
            }
            group(Quality)
            {
                CaptionML = ENU = 'Quality',
                            FRA = 'Qualité';
                // field("Auto.Create QualityTest Method"; Rec."Auto.Create QualityTest Method")
                // {
                // }  // BC Upgrade NANDIS03
            }
            group(Maintenance)
            {
                CaptionML = ENU = 'Maintenance',
                            FRA = 'Maintenance';
                // field("Work Order Mandatory"; Rec."Work Order Mandatory")
                // {
                //     Description = 'DIT-715 #457';
                // }
                // field("W.Order Alloc. Location Code"; Rec."W.Order Alloc. Location Code")
                // {
                // }
                // field("W. Order Allocation Bin Code"; Rec."W. Order Allocation Bin Code")
                // {
                // }  // BC Upgrade NANDIS03
            }
            group("Gate Control")
            {
                Caption = 'Gate Control';
                field("Purchase Gate Entry Mandatory"; Rec."Purchase Gate Entry Mandat FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Gate Entry Mandatory field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Purchase Gate Entry Mandatory field.';

                }
                field("Sales Gate Entry Mandatory"; Rec."Sales Gate Entry Mandatory FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Gate Entry Mandatory field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Sales Gate Entry Mandatory field.';

                }
                field("Transfer Gate Entry Mandatory"; Rec."Transfer Gate Entry Mandat FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transfer Gate Entry Mandatory field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Transfer Gate Entry Mandatory field.';

                }
                field("Gate Weighing Mandatory"; Rec."Gate Weighing Mandatory FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gate Weighing Mandatory field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Gate Weighing Mandatory field.';

                }
                field("InBound Automatic Registration"; Rec."InBound Auto Registration FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the InBound Automatic Registration field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the InBound Automatic Registration field.';

                }
                field("Enable Inbound Validation"; Rec."Enable Inbound Validation FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enable Inbound Validation field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Enable Inbound Validation field.';

                }
            }
            // group(Properties)
            // {
            //     CaptionML = ENU = 'Properties',
            //                 FRA = 'Propriétés';
            //     field("Shortcut Property 1 Code"; Rec."Shortcut Property 1 Code")
            //     {
            //     }
            //     field("Shortcut Property 2 Code"; Rec."Shortcut Property 2 Code")
            //     {
            //     }
            //     field("Shortcut Property 3 Code"; Rec."Shortcut Property 3 Code")
            //     {
            //     }
            //     field("Shortcut Property 4 Code"; Rec."Shortcut Property 4 Code")
            //     {
            //     }
            //     field("Shortcut Property 5 Code"; Rec."Shortcut Property 5 Code")
            //     {
            //     }
            //     field("Shortcut Property 6 Code"; Rec."Shortcut Property 6 Code")
            //     {
            //     }
            //     field("Shortcut Property 7 Code"; Rec."Shortcut Property 7 Code")
            //     {
            //     }
            //     field("Shortcut Property 8 Code"; Rec."Shortcut Property 8 Code")
            //     {
            //     }
            //     field("Shortcut Property 9 Code"; Rec."Shortcut Property 9 Code")
            //     {
            //     }
            //     field("Shortcut Property 10 Code"; Rec."Shortcut Property 10 Code")
            //     {
            //     }
            // }  // BC Upgrade NANDIS03
            group("Transport Cost Center Dimensions")
            {
                Caption = 'Transport Cost Center Dimensions';
                field("Cost Center Pr. Trans. Out."; Rec."Cost Center Pr. Trans. Out FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Center for Primary Transport Outbound field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Cost Center for Primary Transport Outbound field.';

                }
                field("Cost Center Pr. Trans. Export"; Rec."Cost Center Pr. Trans. Exp FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Center for Primary Transport Export field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Cost Center for Primary Transport Export field.';

                }
                field("Cost Center Sec. Trans. Out."; Rec."Cost Center Sec. Trans.Out FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Center for Secondary Transport field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Cost Center for Secondary Transport field.';

                }
            }
        }
    }
    actions
    {
        modify("&Location")
        {
            CaptionML = ENU = '&Location', FRA = '&Magasin';
        }
        modify("&Resource Locations")
        {
            CaptionML = ENU = '&Resource Locations', FRA = '&Magasins ressource';

            //Unsupported feature: Change RunPageLink on ""&Resource Locations"(Action 32)". Please convert manually.

        }
        modify("&Zones")
        {
            CaptionML = ENU = '&Zones', FRA = '&Zones';

            //Unsupported feature: Change RunPageLink on ""&Zones"(Action 7300)". Please convert manually.

        }
        modify("&Bins")
        {
            CaptionML = ENU = '&Bins', FRA = '&Emplacements';

            //Unsupported feature: Change RunPageLink on ""&Bins"(Action 7302)". Please convert manually.

        }
        modify("Online Map")
        {
            CaptionML = ENU = 'Online Map', FRA = 'Online Map';
        }


        //Unsupported feature: CodeInsertion on ""&Bins"(Action 7302)". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 PRODW14.00.00.16 DDR
        */
        //end;
        // addafter("Online Map")
        // {
        //     separator(Separator1101000003)
        //     {
        //     }
        //     action(Properties)
        //     {
        //         CaptionML = ENU = 'Properties',
        //                     FRA = 'Propriétés';
        //         Description = 'FINXL9.00';
        //         Image = Category;
        //         Promoted = true;
        //         PromotedCategory = Category4;
        //         RunObject = Page "Master Data Properties";
        //         RunPageLink = "Table ID" = CONST(14),
        //                       Code = FIELD(Code);
        //     }
        //     separator(Separator1100083020)
        //     {
        //     }
        //     action("Location &Relationships")
        //     {
        //         CaptionML = ENU = 'Location &Relationships',
        //                     FRA = 'Magasin &Relations';
        //         Image = Relationship;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         RunObject = Page "Location Relationships";
        //         RunPageLink = Code = FIELD(Code);
        //     }
        //     action("Location Tax Groups")
        //     {
        //         CaptionML = ENU = 'Location Tax Groups',
        //                     FRA = 'Groupes magasin taxe';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 ';
        //         Image = Zones;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         RunObject = Page "Location Groups";
        //     }
        //     action("Physical Location Groups")
        //     {
        //         CaptionML = ENU = 'Physical Location Groups',
        //                     FRA = 'Groupes magasins réels';
        //         Image = Zones;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         RunObject = Page "Physical Location Groups";
        //     }
        //     separator(Separator1100083013)
        //     {
        //     }
        //     action("Internal Ta&x Item Charges")
        //     {
        //         CaptionML = ENU = 'Internal Ta&x Item Charges',
        //                     FRA = 'Frais anne&xes interne';
        //         Image = TaxSetup;
        //         RunObject = Page "Internal Tax Item Charges";
        //         RunPageLink = "Location From Type" = CONST(Location),
        //                       "Location From Code" = FIELD(Code);
        //     }
        //     separator(Separator1100083039)
        //     {
        //     }
        //     action("Internal Tax Item Charges - Group")
        //     {
        //         CaptionML = ENU = 'Internal Tax Item Charges - Group',
        //                     FRA = 'Frais anne&xes interne - Groupe';
        //         Image = TaxSetup;
        //         RunObject = Page "Internal Tax Item Charges";
        //         RunPageLink = "Location From Type" = CONST("Location Group"),
        //                       "Location From Code" = FIELD("Location Group Code");
        //     }
        //     separator(Separator1100083002)
        //     {
        //     }
        //     separator(Separator1100083016)
        //     {
        //     }
        //     separator(Separator1100083025)
        //     {
        //     }
        //     action("Delivery Times")
        //     {
        //         Caption = 'Delivery Times';
        //         Description = 'DITW110.00.12 NRQ#16026';
        //         Image = Relationship;
        //         RunObject = Page "Delivery Times";
        //         RunPageLink = "No." = FIELD(Code);
        //         RunPageView = sorting("No.", "Address Code")
        //                       where("Source Type" = CONST(Location));
        //     }
        //     group(Sales)
        //     {
        //         CaptionML = ENU = 'Sales',
        //                     FRA = 'Ventes';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 ';
        //         action("&Tax Charges (Sales)")
        //         {
        //             CaptionML = ENU = '&Tax Charges (Sales)',
        //                         FRA = '&Charges d''impôt (Vente)';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Tax Item Charges";
        //             RunPageLink = "Location Code" = FIELD(Code),
        //                           "Location From Type" = CONST(Location);
        //         }
        //         action("Tax Charges (Sales) - Group")
        //         {
        //             CaptionML = ENU = 'Tax Charges (Sales) - Group',
        //                         FRA = 'Charges d''impôt (Vente) - Groupe';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Tax Item Charges";
        //             RunPageLink = "Location From Type" = CONST("Location Group"),
        //                           "Location Code" = FIELD("Location Group Code");
        //         }
        //         action("&Deposit Charges (Sales)")
        //         {
        //             CaptionML = ENU = '&Deposit Charges (Sales)',
        //                         FRA = '&Frais consignet (Vente)';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Deposit Item Charges";
        //             RunPageLink = "Location Code" = FIELD(Code);
        //         }
        //         action("D&iscount Charges (Sales)")
        //         {
        //             CaptionML = ENU = 'D&iscount Charges (Sales)',
        //                         FRA = '&Frais de remise (Vente)';
        //             Image = Discount;
        //             RunObject = Page "Sales Discount Item Charges";
        //             RunPageLink = "Location Code" = FIELD(Code);
        //         }
        //         action("&Promotion Charges (Sales)")
        //         {
        //             CaptionML = ENU = '&Promotion Charges (Sales)',
        //                         FRA = 'Frais de &Promotion (Vente)';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Promotion Item Charges";
        //             RunPageLink = "Location Code" = FIELD(Code);
        //         }
        //     }
        //     group(Purchases)
        //     {
        //         CaptionML = ENU = 'Purchases',
        //                     FRA = 'Achats';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 ';
        //         action("T&ax Charges (Purchase)")
        //         {
        //             CaptionML = ENU = 'T&ax Charges (Purchase)',
        //                         FRA = '&Charges d''impôt (Achat)';
        //             Image = TaxSetup;
        //             RunObject = Page "Purchase Tax Item Charges";
        //             RunPageLink = "Location Code" = FIELD(Code),
        //                           "Location From Type" = CONST(Location);
        //         }
        //         action("Tax Charges (Purchase) - Group")
        //         {
        //             CaptionML = ENU = 'Tax Charges (Purchase) - Group',
        //                         FRA = '&Charges d''impôt (Achat) - Groupe';
        //             Image = TaxSetup;
        //             RunObject = Page "Purchase Tax Item Charges";
        //             RunPageLink = "Location From Type" = CONST("Location Group"),
        //                           "Location Code" = FIELD("Location Group Code");
        //         }
        //         action("D&eposit Charges (Purchase)")
        //         {
        //             CaptionML = ENU = 'D&eposit Charges (Purchase)',
        //                         FRA = '&Frais de dépôt (Achat)';
        //             Image = TaxSetup;
        //             RunObject = Page "Purchase Deposit Item Charges";
        //             RunPageLink = "Location Code" = FIELD(Code);
        //         }
        //         action("Di&scount Charges (Purchase)")
        //         {
        //             CaptionML = ENU = 'Di&scount Charges (Purchase)',
        //                         FRA = '&Frais de remise (Achat)';
        //             Image = Discount;
        //             RunObject = Page "Purchase Discount Item Charges";
        //             RunPageLink = "Location Code" = FIELD(Code);
        //         }
        //         action("Pr&omotion Charges (Purchase)")
        //         {
        //             CaptionML = ENU = 'Pr&omotion Charges (Purchase)',
        //                         FRA = 'Frais de &Promotion (Achat)';
        //             Image = TaxSetup;
        //             RunObject = Page "Purch. Promotion Item Charges";
        //             RunPageLink = "Location Code" = FIELD(Code);
        //         }
        //     }
        // }  // BC Upgrade NANDIS03
    }


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UseCrossDockingEnable := TRUE;
    UsePutAwayWorksheetEnable := TRUE;
    BinMandatoryEnable := TRUE;
    RequireShipmentEnable := TRUE;
    RequireReceiveEnable := TRUE;
    RequirePutAwayEnable := TRUE;
    RequirePickEnable := TRUE;
    DefaultBinSelectionEnable := TRUE;
    UseADCSEnable := TRUE;
    DirectedPutawayandPickEnable := TRUE;
    CrossDockBinCodeEnable := TRUE;
    PickAccordingToFEFOEnable := TRUE;
    AdjustmentBinCodeEnable := TRUE;
    ShipmentBinCodeEnable := TRUE;
    ReceiptBinCodeEnable := TRUE;
    FromProductionBinCodeEnable := TRUE;
    ToProductionBinCodeEnable := TRUE;
    OpenShopFloorBinCodeEnable := TRUE;
    ToAssemblyBinCodeEnable := TRUE;
    FromAssemblyBinCodeEnable := TRUE;
    AssemblyShipmentBinCodeEnable := TRUE;
    CrossDockDueDateCalcEnable := TRUE;
    AlwaysCreatePutawayLineEnable := TRUE;
    AlwaysCreatePickLineEnable := TRUE;
    PutAwayTemplateCodeEnable := TRUE;
    AllowBreakbulkEnable := TRUE;
    SpecialEquipmentEnable := TRUE;
    BinCapacityPolicyEnable := TRUE;
    BaseCalendarCodeEnable := TRUE;
    InboundWhseHandlingTimeEnable := TRUE;
    OutboundWhseHandlingTimeEnable := TRUE;
    EditInTransit := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UseCrossDockingEnable := true;
    UsePutAwayWorksheetEnable := true;
    BinMandatoryEnable := true;
    RequireShipmentEnable := true;
    RequireReceiveEnable := true;
    RequirePutAwayEnable := true;
    RequirePickEnable := true;
    DefaultBinSelectionEnable := true;
    UseADCSEnable := true;
    DirectedPutawayandPickEnable := true;
    CrossDockBinCodeEnable := true;
    PickAccordingToFEFOEnable := true;
    AdjustmentBinCodeEnable := true;
    ShipmentBinCodeEnable := true;
    ReceiptBinCodeEnable := true;
    FromProductionBinCodeEnable := true;
    ToProductionBinCodeEnable := true;
    OpenShopFloorBinCodeEnable := true;
    ToAssemblyBinCodeEnable := true;
    FromAssemblyBinCodeEnable := true;
    AssemblyShipmentBinCodeEnable := true;
    CrossDockDueDateCalcEnable := true;
    AlwaysCreatePutawayLineEnable := true;
    AlwaysCreatePickLineEnable := true;
    PutAwayTemplateCodeEnable := true;
    AllowBreakbulkEnable := true;
    SpecialEquipmentEnable := true;
    BinCapacityPolicyEnable := true;
    BaseCalendarCodeEnable := true;
    InboundWhseHandlingTimeEnable := true;
    OutboundWhseHandlingTimeEnable := true;
    EditInTransit := true;
    */
    //end;


    //Unsupported feature: CodeModification on "UpdateEnabled(PROCEDURE 1)". Please convert manually.

    //procedure UpdateEnabled();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RequirePickEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    RequirePutAwayEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    RequireReceiveEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    RequireShipmentEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    OutboundWhseHandlingTimeEnable := NOT "Use As In-Transit";
    InboundWhseHandlingTimeEnable := NOT "Use As In-Transit";
    BinMandatoryEnable := NOT "Use As In-Transit" AND NOT "Directed Put-away and Pick";
    DirectedPutawayandPickEnable := NOT "Use As In-Transit" AND "Bin Mandatory";
    BaseCalendarCodeEnable := NOT "Use As In-Transit";

    BinCapacityPolicyEnable := "Directed Put-away and Pick";
    SpecialEquipmentEnable := "Directed Put-away and Pick";
    AllowBreakbulkEnable := "Directed Put-away and Pick";
    PutAwayTemplateCodeEnable := "Directed Put-away and Pick";
    UsePutAwayWorksheetEnable :=
      "Directed Put-away and Pick" OR ("Require Put-away" AND "Require Receive" AND NOT "Use As In-Transit");
    AlwaysCreatePickLineEnable := "Directed Put-away and Pick";
    AlwaysCreatePutawayLineEnable := "Directed Put-away and Pick";

    UseCrossDockingEnable := NOT "Use As In-Transit" AND "Require Receive" AND "Require Shipment" AND "Require Put-away" AND
      "Require Pick";
    CrossDockDueDateCalcEnable := "Use Cross-Docking";

    OpenShopFloorBinCodeEnable := "Bin Mandatory";
    ToProductionBinCodeEnable := "Bin Mandatory";
    FromProductionBinCodeEnable := "Bin Mandatory";
    ReceiptBinCodeEnable := "Bin Mandatory" AND "Require Receive";
    ShipmentBinCodeEnable := "Bin Mandatory" AND "Require Shipment";
    AdjustmentBinCodeEnable := "Directed Put-away and Pick";
    CrossDockBinCodeEnable := "Bin Mandatory" AND "Use Cross-Docking";
    ToAssemblyBinCodeEnable := "Bin Mandatory";
    FromAssemblyBinCodeEnable := "Bin Mandatory";
    AssemblyShipmentBinCodeEnable := "Bin Mandatory" AND NOT ShipmentBinCodeEnable;
    DefaultBinSelectionEnable := "Bin Mandatory" AND NOT "Directed Put-away and Pick";
    UseADCSEnable := NOT "Use As In-Transit" AND "Directed Put-away and Pick";
    PickAccordingToFEFOEnable := "Require Pick" AND "Bin Mandatory";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RequirePickEnable := not "Use As In-Transit" and not "Directed Put-away and Pick";
    RequirePutAwayEnable := not "Use As In-Transit" and not "Directed Put-away and Pick";
    RequireReceiveEnable := not "Use As In-Transit" and not "Directed Put-away and Pick";
    RequireShipmentEnable := not "Use As In-Transit" and not "Directed Put-away and Pick";
    OutboundWhseHandlingTimeEnable := not "Use As In-Transit";
    InboundWhseHandlingTimeEnable := not "Use As In-Transit";
    BinMandatoryEnable := not "Use As In-Transit" and not "Directed Put-away and Pick";
    DirectedPutawayandPickEnable := not "Use As In-Transit" and "Bin Mandatory";
    BaseCalendarCodeEnable := not "Use As In-Transit";
    #10..15
      "Directed Put-away and Pick" or ("Require Put-away" and "Require Receive" and not "Use As In-Transit");
    #17..19
    UseCrossDockingEnable := not "Use As In-Transit" and "Require Receive" and "Require Shipment" and "Require Put-away" and
    #21..26
    ReceiptBinCodeEnable := "Bin Mandatory" and "Require Receive";
    ShipmentBinCodeEnable := "Bin Mandatory" and "Require Shipment";
    AdjustmentBinCodeEnable := "Directed Put-away and Pick";
    CrossDockBinCodeEnable := "Bin Mandatory" and "Use Cross-Docking";
    ToAssemblyBinCodeEnable := "Bin Mandatory";
    FromAssemblyBinCodeEnable := "Bin Mandatory";
    AssemblyShipmentBinCodeEnable := "Bin Mandatory" and not ShipmentBinCodeEnable;
    DefaultBinSelectionEnable := "Bin Mandatory" and not "Directed Put-away and Pick";
    UseADCSEnable := not "Use As In-Transit" and "Directed Put-away and Pick";
    PickAccordingToFEFOEnable := "Require Pick" and "Bin Mandatory";
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

