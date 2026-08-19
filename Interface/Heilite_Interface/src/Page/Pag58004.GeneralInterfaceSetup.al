page 58004 "General Interface Setup INT"
{
    // Heilite Navision Old Id - 50057
    // version HEI.11,FM,Esker,HEI.55

    // HEI.01 FDD-GAPID001 IBM LAZARE02 14.07.2017 # New page for Interface Common Framework
    // HEI.02 FDD-HNK LOGGAP001 03/12/2017 IBM.CHAUHB01, Following field displayed under RouteNet TAB.
    //   Export Path
    //   Import Path
    //   Route UNIDADES Item UOMCode
    //   Route CAJAS Item UOMCode
    //   Route BANCOS Item UOMCode
    //   Route Item Category Code 1
    //   Route Item Category Code 2
    //   Route Return Reason Code 1
    //   Route Return Reason Code 2
    //   Route REGION/AGENCY Dimension
    //   Route CHANNEL DimensionCode
    //   Route CHANNEL Dimension Value
    // HEI.03 FDD-HNK LOGGAP002 01/12/2018 IBM.CHAUHB01, Following field displayed under Pepperi Interface TAB.
    //   "Peperi SO Interface"
    //   "Pepperi Import Path"
    //   "Pepperi Import Archive Path"
    //   "Sales Order Prefix"
    //   "Order Tracking UoM"
    //   "Product Exchange UoM"
    //   "General Journal Template"
    //   "Item Main Category"
    //   "Sales Order Nos."
    //   "Sales Return Order Nos."
    //   "Cash Paymet Terms"
    //   "Ret. Reason Code-Ord. Tracking"
    // HEI.04 FDD-OTCGAP01 IBM ISYED01 23.02.2018
    //   # Added fileds below to page for Fiscal Printer Interface
    //   #Default Fiscal Printer Id,Fiscal Printer XML Directory,Fiscal Printer Input Directory,Fiscal Printer Input Prc. Dir.,
    //     Active Fiscal Printer,Non Fiscal Invoice Report,Fiscal Printer XML Backup,Non Fiscal Cr.Memo Report,Fiscal Invoice Report,
    //     Fiscal Cr.Memo Report
    // 
    // HEI.05 FDD-OTCGAP01 IBM NAIKH01 09.03.2018
    //   # Added new field "Fiscal Cr.Memo Report Code" and "Fiscal Invoice Report Code"
    // 
    // HEI.06 FDD-MZ-PRDGAP001 IBM LAZARE02 25.07.2018
    //   # Added new fields Enable IC Item Numbering, Item Numbering Format in the Mendix tab
    // HEI.07 FDD-PURGAP026 IBM NASTAA02 27.07.2018 # Item Selection Heilite-Maximo Interface
    //   # Deleted Field "Maximo Item Category Filter"
    //   # New Page Action "Maximo Item Filters" created to setup the Maximo Item Category Filter
    // HEI.08 FDD-GAPLOG01 IBM HORTOC01 28.08.2018 - new action "CVS Interface Setup"
    // HEI.09 FDD_Rwanda_Bralirwa_Esker_ Interface_V0.3_HT75 IBM POSTOI01 12.09.2018
    //   # new action "Esker Interface Setup"
    // HEI.10 FuturMaster IBM LAZARE02 # FuturMaster Interfaces
    //   # new Page Action FuturMAster Interface Setup
    // HEI.11 FDD-BA-SLSGAP01 IBM NASTAA02 19.10.2018 # Counterpoint Interface
    //   # New Action created: "Counterpoint Interface Setup"
    // HEI.12 FDD-GAPLOG08 IBM LAZARE02 # EBM Interfaces
    // 
    // HEI.13 FDD-RTRGAP073 BRD HB142- Trintech connection IBM NAIKH01 25.02.2019 # Trintech Interface
    //   # New Action created: "Trintech Interface Setup"
    // HEI.15 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new action Ortec Interface Setup
    // HEI.16 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Page Action created: "Maraki Interface Setup"
    // HEI.17 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 04.10.2019 - #new action EDI Interface Setup
    // HEI.18 FDD-HT318 BULIMC01 IBM 3.10.2019 #new action for WMS Interface
    // HEI.19 FDD-HT610 IBM NASTAA02 11.12.2019 # La Reunion Futur Master
    //   # New Page Action created: "Legacy Futur Master Interface Setup"
    // HEI.20 CHG2026335 IBM GAVANM01 09.01.2020 # new field in General tab, "Local Interfaces"
    // HEI.21 CHG2040517 HB1009 GUNERE01 09.01.2020 # "Processing Codeunit ID" field added to Administration tab
    // HEI.22 CHG2041871 IBM PANDES01 21.01.2020
    //  # Added new Action SRM interface Setup.
    // HEI.23 CHG2040517 HB1009 GUNERE01 09.01.2020 # "Outbound Process Cdu ID." field added to Administration tab
    // HEI.24 FDD-HT664 IBM SURYAS01 12-02-2020
    //   #Created New Page Action-"SAGE Interface Setup"
    // HEI.26 CHG2042951 IBM POENAB02 10.04.2020 # Procurement of Services Maximo - HeiLite
    //  # Added field 59050 Services in group Maximo
    // HEI.27 CHG2060197 IBM KUMARN15 14.04.2020
    //   # New field added "Use TLS1.1 TLS1.2"
    // HEI.28 FDD-HT1139A IBM NASTAA02 12.05.2020 # DRC - BVM Interface
    //         # New Page Action created: "BVM Interface Setup"
    // HEI.29 CHG2013123 IBM.LS 14.05.2020
    //   # New Field added: "Sugar by Volume Attr ID"
    //   # New Field added: "Artificially Sweetened Attr ID"
    // HEI.30 CHG2065153 IBM KUMARN15 23.06.2020
    //   # New action API Interface Setup added
    // HEI.31 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Tab created: "IC Setup"
    //   # New Fields added: "IC Item Jnl Template", "IC Item Jnl Batch"
    // HEI.32 FDD-HT1398 CHG2065738 IBM.GUNERE01 13.07.2020 # "WS Username","WS Password","WS Link" fields added to
    //                                                         Administration tab.
    // HEI.33 FDD-HT1398 CHG2065738 IBM.GUNERE01 14.07.2020 # "WS Username","WS Password","WS Link" fields removed from
    //                                                         Administration tab.
    // HEI.34 FDD-HT678 IBM NASTAA02 25.08.2020 # DMS / DDE Integration
    //   # New Page Action created: "DDE Interface Setup"
    // HEI.35 CHG2069321 GAVANM01 IBM 13.10.2020 #PowerApps Integration
    //   # New Page Action created: "PowerApps Interface Setup"
    // HEI.36 FDD-HB1268 - CHG2068666 IBM NASTAA02 26.10.2020 # DMS Integration Ivory Coast
    //   # New Page Action created: "DMS Interface Setup"
    // HEI.37 FDD-HB899 - CHG2044703 IBM GAVANM01 13.12.2020 # New POS System Required for OPCO
    //   # New Page Action created: "LSR Interface Setup"
    // HEI.38 FDD-HB1234 - CHG2053453 IBM NASTAA02 15.02.2021 # B2B Order Status
    //   # New Page Action created: "B2B Interface Setup"
    // HEI.40 FDD-HB1916 CHG2095242 IBM NANDIS01 20.04.2021 - Unit of Measure conversion Maximo-HeiLite interface
    //   # "Maximo UnitofMeasure Interface" field shown in Maximo tab
    // HEI.41 CHG2112882 IBM.LS      02.06.2021
    //   # Added New Field - Ccc Code Attribute ID
    // HEI.42 FDD-HB2174 CHG2104952 IBM NANDIS01 31.05.2021 Ibecor - PO API
    //   # New button added "Ibecor Interface Setup"
    // HEI.43 CHG2115040 HB2342 IBM GAVANM01 16.08.2021 #SEM Customer Integration
    //   # New Page Action created: "SEM Interface Setup"
    // HEI.44 FDD - HB1797 CHG2086227 IBM NANDIS01 24.08.2021 - LOG_GR Acknowledgement Message to Global Maximo (aka req.2 of HB1688)
    //   # New field - "Maximo Purch. Rcpt. Confirmtn." added in Page under Maximo tab
    // HEI.46 CHG2132748 IBM SAXENA03 09.11.2021
    //   # Added HeiFLOW Interface Setup Page
    // HEI.47 CHG2129985 IBM.LS      21.02.2022
    //   # Changed Page Action (ID: 55068) Name from "WMS Interface Setup" to "WMS & LogoPak Interface Setup"
    // HEI.48 CHG2147859 SAHAL01 22.07.2022
    //   # Created New Page Action (ID: 55079) - "Astro Interface Setup" for ASTRO Interface
    // HEI.49 CHG2147491 HB2802 NORRIQ KOROLA04 22.09.2022
    //   # New field - "WH Material Group Dim. Code" added under Dimension section
    // HEI.50 CHG2151260-HB2788 IBM SOICAD02 06.11.2022 New action
    // 
    // HEI.51 CHG2224414 IBM PANDEA04 17.10.2023 #HeiDM xml request payloads
    //   #New Group "Heidm Payload" Addded
    //   #New field "Heidm XML Payload Path" added
    // HEI.52 CHG2194603 HB3289 COSTES04 26.10.2023 Electronic invoice interface
    //   # New action PAC Electronic Invoice added
    // HEI.53 CHG2210794 SAHAL01 04.12.2023 Zycus - BASE HL Integration Master Dimension
    //   # Created New Page Action (ID: 55095) - "Zycus Interface Setup"
    // HEI.54 CHG2258298 HLP0-5005 IBM VERMAA03 10.07.2024 #Ethiopia Astro interface log deletion
    //   # New field added - "Interface Code"
    //                       "Synchronize Date Range"
    //                       "Move To Interface Log"
    // HEI.55 CHG2249376 COSTES04 10.10.2024 CNET Integration for Sales Order Management
    //   # New action added CNET Interface Setup

    Caption = 'General Interface Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Mendix';  // BC Upgrade NANDIS03
    SourceTable = "General Interface Setup INT";
    UsageCategory = Lists;  // BC Upgrade NANDIS03
    ApplicationArea = All;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Company Code ID"; Rec."Company Code ID")
                {
                    ToolTip = 'Specifies the value of the Company Code ID field.';
                }
                field("XML Encoding"; Rec."XML Encoding")
                {
                    ToolTip = 'Specifies the value of the XML Encoding field.';
                }
                field("Local Interfaces"; Rec."Local Interfaces")
                {
                    ToolTip = 'Specifies the value of the Local Interfaces field.';
                }
                field("Use TLS1.1 TLS1.2"; Rec."Use TLS1.1 TLS1.2")
                {
                    ToolTip = 'Specifies the value of the Use TLS1.1 TLS1.2 field.';
                }
            }
            group(Mendix)
            {
                field("Material Interface"; Rec."Material Interface")
                {
                    ToolTip = 'Specifies the value of the Material Interface field.';
                }
                field("Items Global Interface"; Rec."Items Global Interface")
                {
                    ToolTip = 'Specifies the value of the Item Global Interface field.';
                }
                field("Items Local Finance Interface"; Rec."Items Local Finance Interface")
                {
                    ToolTip = 'Specifies the value of the Item Local Finance Interface field.';
                }
                field("Items Local Planning Interface"; Rec."Items Local Planning Interface")
                {
                    ToolTip = 'Specifies the value of the Items Local Planning Interface field.';
                }
                field("Items Local Site Interface"; Rec."Items Local Site Interface")
                {
                    ToolTip = 'Specifies the value of the Items Local Site Interface field.';
                }
                field("Vendor Interface"; Rec."Vendor Interface")
                {
                    ToolTip = 'Specifies the value of the Vendor Interface field.';
                }
                field("Vendors Global Interface"; Rec."Vendors Global Interface")
                {
                    ToolTip = 'Specifies the value of the Vendors Global Interface field.';
                }
                field("Vendor Bank Interface"; Rec."Vendor Bank Interface")
                {
                    ToolTip = 'Specifies the value of the Vendor Bank Interface field.';
                }
                field("Vend. Local Finance Interface"; Rec."Vend. Local Finance Interface")
                {
                    ToolTip = 'Specifies the value of the Vendors Local Finance Interface field.';
                }
                field("Vend. Local Purch. Interface"; Rec."Vend. Local Purch. Interface")
                {
                    ToolTip = 'Specifies the value of the Vendors Local Purchasing Interface field.';
                }
                field("Customer Interface"; Rec."Customer Interface")
                {
                    ToolTip = 'Specifies the value of the Customer Interface field.';
                }
                field("Duplicate Check Limit Distance"; Rec."Duplicate Check Limit Distance")
                {
                    ToolTip = 'Specifies the value of the Duplicate Check Limit Distance field.';
                }
                field("MD Default Field Priority"; Rec."MD Default Field Priority")
                {
                    ToolTip = 'Specifies the value of the Master Data Default Field Priority field.';
                }
                field("Enable IC Item Numbering"; Rec."Enable IC Item Numbering")
                {
                    ToolTip = 'Specifies the value of the Enable Intercompany Item Numbering field.';
                }
                field("Item Numbering Format"; Rec."Item Numbering Format")
                {
                    ToolTip = 'Specifies the value of the Item Numbering Format field.';
                }
            }
            group(Maximo)
            {
                Caption = 'Maximo';
                field("Maximo Vendor Interface"; Rec."Maximo Vendor Interface")
                {
                    ToolTip = 'Specifies the value of the Maximo Vendor Interface field.';
                }
                field("Maximo Item Interface"; Rec."Maximo Item Interface")
                {
                    ToolTip = 'Specifies the value of the Maximo Item Interface field.';
                }
                field("Maximo PR Interface"; Rec."Maximo PR Interface")
                {
                    ToolTip = 'Specifies the value of the Maximo PR Interface field.';
                }
                field("Maximo PO Interface"; Rec."Maximo PO Interface")
                {
                    ToolTip = 'Specifies the value of the Maximo PO Interface field.';
                }
                field("Maximo Purch. Rcpt. Interface"; Rec."Maximo Purch. Rcpt. Interface")
                {
                    ToolTip = 'Specifies the value of the Maximo Purchase Receipt Interface field.';
                }
                field("Maximo Purch. Rcpt. Confirmtn."; Rec."Maximo Purch. Rcpt. Confirmtn.")
                {
                    ToolTip = 'Specifies the value of the Maximo Purch. Rcpt. Confirmtn. field.';
                }
                field("Maximo Goods Issue Interface"; Rec."Maximo Goods Issue Interface")
                {
                    ToolTip = 'Specifies the value of the Maximo Goods Issue Interface field.';
                }
                field("Maximo Stock Adjmt. Interface"; Rec."Maximo Stock Adjmt. Interface")
                {
                    ToolTip = 'Specifies the value of the Maximo Stock Adjmt. Interface field.';
                }
                field("Maximo Unit Cost Interface"; Rec."Maximo Unit Cost Interface")
                {
                    ToolTip = 'Specifies the value of the Maximo Unit Cost Interface field.';
                }
                field("Maximo UnitofMeasure Interface"; Rec."Maximo UnitofMeasure Interface")
                {
                    ToolTip = 'Specifies the value of the Maximo UnitofMeasure Interface field.';
                }
                field("Maximo Item Vendor Interface"; Rec."Maximo Item Vendor Interface")
                {
                    ToolTip = 'Specifies the value of the Maximo Item Vendor Interface field.';
                }
                field("Maximo Goods Transf. Interface"; Rec."Maximo Goods Transf. Interface")
                {
                    ToolTip = 'Specifies the value of the Maximo Goods Transfer Interface field.';
                }
                field("Maximo Default Language Code"; Rec."Maximo Default Language Code")
                {
                    ToolTip = 'Specifies the value of the Maximo Default Language Code field.';
                }
                field("Maximo Consumption Prod. Order"; Rec."Maximo Consumption Prod. Order")
                {
                    ToolTip = 'Specifies the value of the Maximo Consumption Prod. Order field.';
                }
                field("Maximo Location Filter"; Rec."Maximo Location Filter")
                {
                    ToolTip = 'Specifies the value of the Maximo Location Filter field.';
                }
                field("Maximo Default PR Vendor No."; Rec."Maximo Default PR Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Maximo Default PR Vendor No. field.';
                }
                field("Ibecor Vendor No."; Rec."Ibecor Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Ibecor Vendor No. field.';
                }
                field(Services; Rec.Services)
                {
                    ToolTip = 'Specifies the value of the Services field.';
                }
            }
            group(Attributes)
            {
                Caption = 'Attributes';
                field("CMG Attribute ID"; Rec."CMG Attribute ID")
                {
                    ToolTip = 'Specifies the value of the CMG Attribute ID field.';
                }
                field("Brand Attribute ID"; Rec."Brand Attribute ID")
                {
                    ToolTip = 'Specifies the value of the Brand Attribute ID field.';
                }
                field("Ccc Code Attribute ID"; Rec."Ccc Code Attribute ID")
                {
                    ToolTip = 'Specifies the value of the Ccc Code Attribute ID field.';
                }
                field("Line Extension Attr. ID"; Rec."Line Extension Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Line Extension Attribute ID field.';
                }
                field("Product Group Attr. ID"; Rec."Product Group Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Product Group Attribute ID field.';
                }
                field("Product Type Attr. ID"; Rec."Product Type Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Product Type Attribute ID field.';
                }
                field("Group 3rdParty Attr. ID"; Rec."Group 3rdParty Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Group 3rd Party Attribute ID field.';
                }
                field("Primary Pack Type Attr. ID"; Rec."Primary Pack Type Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Primary Pack Type Attribute ID field.';
                }
                field("Primary PT Group Attr. ID"; Rec."Primary PT Group Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Primary Pack Type Group Attribute ID field.';
                }
                field("Primary Pack Size Attr. ID"; Rec."Primary Pack Size Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Primary Pack Size Attr. ID Attribute ID field.';
                }
                field("SPT Outer Layer Attr. ID"; Rec."SPT Outer Layer Attr. ID")
                {
                    ToolTip = 'Specifies the value of the SPT Outer Layer Attribute ID field.';
                }
                field("SPT Unit Per Outer Attr. ID"; Rec."SPT Unit Per Outer Attr. ID")
                {
                    ToolTip = 'Specifies the value of the SPT Unit Per Outer Attribute ID field.';
                }
                field("SPT In Betw. Layer Attr. ID"; Rec."SPT In Betw. Layer Attr. ID")
                {
                    ToolTip = 'Specifies the value of the SPT In Betw. Layer Attribute ID field.';
                }
                field("SPT Units In Betw. Attr. ID"; Rec."SPT Units In Betw. Attr. ID")
                {
                    ToolTip = 'Specifies the value of the SPT Units In Betw. Attribute ID field.';
                }
                field("Alcohol By Volume Attr. ID"; Rec."Alcohol By Volume Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Alcohol By Volume Attribute ID field.';
                }
                field("Alcohol By Weight Attr. ID"; Rec."Alcohol By Weight Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Alcohol By Weight Attribute ID field.';
                }
                field("Returnable Indicat. Attr. ID"; Rec."Returnable Indicat. Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Returnable Indicator Attribute ID field.';
                }
                field("Sparkling Still Attr. ID"; Rec."Sparkling Still Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Sparkling Still Attribute ID field.';
                }
                field("Wine Category Attr. ID"; Rec."Wine Category Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Wine Category Attribute ID field.';
                }
                field("Denomination Attr. ID"; Rec."Denomination Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Denomination Attribute ID field.';
                }
                field("Region Of Origin Attr. ID"; Rec."Region Of Origin Attr. ID")
                {
                    ToolTip = 'Specifies the value of the Region Of Origin Attribute ID field.';
                }
                field("Sugar by Volume Attr ID"; Rec."Sugar by Volume Attr ID")
                {
                    ToolTip = 'Specifies the value of the Sugar by Volume Attr ID field.';
                }
                field("Artificially Sweetened Attr ID"; Rec."Artificially Sweetened Attr ID")
                {
                    ToolTip = 'Specifies the value of the Artificially Sweetened Attr ID field.';
                }
            }
            group(Dimensions)
            {
                Caption = 'Dimensions';
                field("Cost Center Dimension Code"; Rec."Cost Center Dimension Code")
                {
                    ToolTip = 'Specifies the value of the Cost Center Dimension Code field.';
                }
                field("Project Dimension Code"; Rec."Project Dimension Code")
                {
                    ToolTip = 'Specifies the value of the Project Dimension Code field.';
                }
                field("CMG Dimension Code"; Rec."CMG Dimension Code")
                {
                    ToolTip = 'Specifies the value of the CMG Dimension Code field.';
                }
                field("Brand Dim. Code"; Rec."Brand Dim. Code")
                {
                    ToolTip = 'Specifies the value of the Brand Dimension Code field.';
                }
                field("Line Extension Dim. Code"; Rec."Line Extension Dim. Code")
                {
                    ToolTip = 'Specifies the value of the Line Extension Dimension Code field.';
                }
                field("Product Group Dim. Code"; Rec."Product Group Dim. Code")
                {
                    ToolTip = 'Specifies the value of the Product Group Dimension Code field.';
                }
                field("Product Type  Dim. Code"; Rec."Product Type  Dim. Code")
                {
                    ToolTip = 'Specifies the value of the Product Type  Dimension Code field.';
                }
                field("Group 3rdParty Dim. Code"; Rec."Group 3rdParty Dim. Code")
                {
                    ToolTip = 'Specifies the value of the Group 3rd Party Dimension Code field.';
                }
                field("Primary Pack Type Dim. Code"; Rec."Primary Pack Type Dim. Code")
                {
                    ToolTip = 'Specifies the value of the Primary Pack Type Dimension Code field.';
                }
                field("Primary PT Group Dim. Code"; Rec."Primary PT Group Dim. Code")
                {
                    ToolTip = 'Specifies the value of the Primary Pack Type Group Dimension Code field.';
                }
                field("Primary Pack Size Dim. Code"; Rec."Primary Pack Size Dim. Code")
                {
                    ToolTip = 'Specifies the value of the Primary Pack Size Dimension Code field.';
                }
                field("SPT Outer Layer Dim. Code"; Rec."SPT Outer Layer Dim. Code")
                {
                    ToolTip = 'Specifies the value of the SPT Outer Layer Dimension Code field.';
                }
                field("Returnable Indicator Dim. Code"; Rec."Returnable Indicator Dim. Code")
                {
                    ToolTip = 'Specifies the value of the Returnable Indicator Dimension Code field.';
                }
                field("Trading Partner Dim. Code"; Rec."Trading Partner Dim. Code")
                {
                    ToolTip = 'Specifies the value of the Trading Partner Dimension Code field.';
                }
                field("WH Material Group Dim. Code"; Rec."WH Material Group Dim. Code")
                {
                    ToolTip = 'Specifies the value of the WH Material Group Dimension Code field.';
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field("Notify User ID 1"; Rec."Notify User ID 1")
                {
                    ToolTip = 'Specifies the value of the Notify User ID 1 field.';
                }
                field("Notify User ID 2"; Rec."Notify User ID 2")
                {
                    ToolTip = 'Specifies the value of the Notify User ID 2 field.';
                }
                field("Interface Job Queue Category"; Rec."Interface Job Queue Category")
                {
                    ToolTip = 'Specifies the value of the Interface Job Queue Category field.';
                }
                field("Interface Job Queue User ID"; Rec."Interface Job Queue User ID")
                {
                    ToolTip = 'Specifies the value of the Interface Job Queue User ID field.';
                }
                field("Processing Codeunit ID"; Rec."Processing Codeunit ID")
                {
                    ToolTip = 'Specifies the value of the Processing Codeunit ID field.';
                }
                field("Outbound Process Cdu ID."; Rec."Outbound Process Cdu ID.")
                {
                    ToolTip = 'Specifies the value of the Outbound Process Cdu ID. field.';
                }
            }
            group(RouteNet)
            {
                Caption = 'RouteNet';
                field("Export Path"; Rec."Export Path")
                {
                    ToolTip = 'Specifies the value of the Export Path field.';
                }
                field("Import Path"; Rec."Import Path")
                {
                    ToolTip = 'Specifies the value of the Import Path field.';
                }
                field("Route BANCOS Item UOM"; Rec."Route BANCOS Item UOM")
                {
                    ToolTip = 'Specifies the value of the Route BANCOS Item UOM field.';
                }
                field("Route UNIDADES Item UOM"; Rec."Route UNIDADES Item UOM")
                {
                    ToolTip = 'Specifies the value of the Route UNIDADES Item UOM field.';
                }
                field("Route CAJAS Item UOM"; Rec."Route CAJAS Item UOM")
                {
                    ToolTip = 'Specifies the value of the Route CAJAS Item UOM field.';
                }
                field("Route Return Reason Code 1"; Rec."Route Return Reason Code 1")
                {
                    ToolTip = 'Specifies the value of the Route Return Reason Code 1 field.';
                }
                field("Route Return Reason Code 2"; Rec."Route Return Reason Code 2")
                {
                    ToolTip = 'Specifies the value of the Route Return Reason Code 2 field.';
                }
                field("Route REGION/AGENCY Dimension"; Rec."Route REGION/AGENCY Dimension")
                {
                    ToolTip = 'Specifies the value of the Route REGION/AGENCY Dimension field.';
                }
                field("Route CHANNEL Dimension"; Rec."Route CHANNEL Dimension")
                {
                    ToolTip = 'Specifies the value of the Route CHANNEL Dimension field.';
                }
                field("Route CHANNEL Dimension Value"; Rec."Route CHANNEL Dimension Value")
                {
                    ToolTip = 'Specifies the value of the Route CHANNEL Dimension Value field.';
                }
            }
            group("Pepperi Interface")
            {
                Caption = 'Pepperi Interface';
                field("Peperi SO Interface"; Rec."Peperi SO Interface")
                {
                    ToolTip = 'Specifies the value of the Peperi SO Interface field.';
                }
                field("Pepperi Import Path"; Rec."Pepperi Import Path")
                {
                    ToolTip = 'Specifies the value of the Pepperi Import Path field.';
                }
                field("Pepperi Import Archive Path"; Rec."Pepperi Import Archive Path")
                {
                    ToolTip = 'Specifies the value of the Pepperi Import Archive Path field.';
                }
                field("Pepperi Export Path"; Rec."Pepperi Export Path")
                {
                    ToolTip = 'Specifies the value of the Pepperi Export Path field.';
                }
                field("Pepperi Export Archive Path"; Rec."Pepperi Export Archive Path")
                {
                    ToolTip = 'Specifies the value of the Pepperi Export Archive Path field.';
                }
                field("Pepperi Customer No."; Rec."Pepperi Customer No.")
                {
                    ToolTip = 'Specifies the value of the Pepperi Customer No. field.';
                }
                field("Account Group"; Rec."Account Group")
                {
                    ToolTip = 'Specifies the value of the Account Group field.';
                }
                field("Pepperi Item category"; Rec."Pepperi Item category")
                {
                    ToolTip = 'Specifies the value of the Pepperi Item category field.';
                }
                field("Sales Order Prefix"; Rec."Sales Order Prefix")
                {
                    ToolTip = 'Specifies the value of the Sales Order Prefix field.';
                }
                field("Product Change Prefix"; Rec."Product Change Prefix")
                {
                    ToolTip = 'Specifies the value of the Product Change Prefix field.';
                }
                field("AR Collection Prefix"; Rec."AR Collection Prefix")
                {
                    ToolTip = 'Specifies the value of the AR Collection Prefix field.';
                }
                field("Order Tracking UoM"; Rec."Order Tracking UoM")
                {
                    ToolTip = 'Specifies the value of the Order Tracking UoM field.';
                }
                field("Product Exchange UoM"; Rec."Product Exchange UoM")
                {
                    ToolTip = 'Specifies the value of the Product Exchange UoM field.';
                }
                field("General Journal Template"; Rec."General Journal Template")
                {
                    ToolTip = 'Specifies the value of the General Journal Template field.';
                }
                field("Item Main Category"; Rec."Item Main Category")
                {
                    ToolTip = 'Specifies the value of the Item Main Category field.';
                }
                field("Cash Paymet Terms"; Rec."Cash Paymet Terms")
                {
                    ToolTip = 'Specifies the value of the Cash Paymet Terms field.';
                }
                field("Ret. Reason Code-Ord. Tracking"; Rec."Ret. Reason Code-Ord. Tracking")
                {
                    ToolTip = 'Specifies the value of the Ret. Reason Code-Ord. Tracking field.';
                }
            }
            group("Payroll Import")
            {
                Caption = 'Payroll Import';
                field("Payroll Interface"; Rec."Payroll Interface")
                {
                    ToolTip = 'Specifies the value of the Payroll Interface field.';
                }
                field("Payroll Import Path"; Rec."Payroll Import Path")
                {
                    ToolTip = 'Specifies the value of the Payroll Import Path field.';
                }
                field("Payroll Import Archive Path"; Rec."Payroll Import Archive Path")
                {
                    ToolTip = 'Specifies the value of the Payroll Import Archive Path field.';
                }
                field("Payroll Gen. Jnl. Template"; Rec."Payroll Gen. Jnl. Template")
                {
                    ToolTip = 'Specifies the value of the Payroll Gen. Jnl. Template field.';
                }
                field("Payroll Gen. Jnl. Batch"; Rec."Payroll Gen. Jnl. Batch")
                {
                    ToolTip = 'Specifies the value of the Payroll Gen. Jnl. Batch field.';
                }
            }
            group("Fiscal Printer")
            {
                Caption = 'Fiscal Printer';
                field("Default Fiscal Printer Id"; Rec."Default Fiscal Printer Id")
                {
                    ToolTip = 'Specifies the value of the Default Fiscal Printer Id field.';
                }
                field("Fiscal Printer XML Directory"; Rec."Fiscal Printer XML Directory")
                {
                    ToolTip = 'Specifies the value of the Fiscal Printer XML Directory field.';
                }
                field("Fiscal Printer Input Directory"; Rec."Fiscal Printer Input Directory")
                {
                    ToolTip = 'Specifies the value of the Fiscal Printer Input Directory field.';
                }
                field("Fiscal Printer Input Prc. Dir."; Rec."Fiscal Printer Input Prc. Dir.")
                {
                    ToolTip = 'Specifies the value of the Fiscal Printer Input Prc. Dir. field.';
                }
                field("Non Fiscal Invoice Report"; Rec."Non Fiscal Invoice Report")
                {
                    ToolTip = 'Specifies the value of the Non Fiscal Invoice Report field.';
                }
                field("Fiscal Printer XML Backup"; Rec."Fiscal Printer XML Backup")
                {
                    ToolTip = 'Specifies the value of the Fiscal Printer XML Backup field.';
                }
                field("Non Fiscal Cr.Memo Report"; Rec."Non Fiscal Cr.Memo Report")
                {
                    ToolTip = 'Specifies the value of the Non Fiscal Cr.Memo Report field.';
                }
                field("Fiscal Invoice Report Code"; Rec."Fiscal Invoice Report Code")
                {
                    ToolTip = 'Specifies the value of the Fiscal Invoice Report Code field.';
                }
                field("Fiscal Cr.Memo Report Code"; Rec."Fiscal Cr.Memo Report Code")
                {
                    ToolTip = 'Specifies the value of the Fiscal Cr.Memo Report Code field.';
                }
                field("Automatic Posting Invoice"; Rec."Automatic Posting Invoice")
                {
                    ToolTip = 'Specifies the value of the Automatic Posting Invoice field.';
                }
                field("Automatic Posting Credit Memo"; Rec."Automatic Posting Credit Memo")
                {
                    ToolTip = 'Specifies the value of the Automatic Posting Credit Memo field.';
                }
            }
            group("IC Setup")
            {
                Caption = 'IC Setup';
                field("IC Item Jnl Template"; Rec."IC Item Jnl Template")
                {
                    ToolTip = 'Specifies the value of the IC Item Journal Template field.';
                }
                field("IC Item Jnl Batch"; Rec."IC Item Jnl Batch")
                {
                    ToolTip = 'Specifies the value of the IC Item Journal Batch field.';
                }
            }
            group("Heidm Payload")
            {
                Caption = 'Heidm Payload';
                field("Heidm XML Payload Path"; Rec."Heidm XML Payload Path")
                {
                    ToolTip = 'Specifies the value of the Heidm XML Payload Path field.';
                }
            }
            group("Interface Log Maintenance")
            {
                Caption = 'Interface Log Maintenance';
                field("Interface Code"; Rec."Interface Code")
                {
                    ToolTip = 'Specifies the value of the Interface Code field.';
                }
                field("Synchronize Date Range"; Rec."Synchronize Date Range")
                {
                    ToolTip = 'Specifies the value of the Synchronize Date Range field.';
                }
                field("Move To Interface Log"; Rec."Move To Interface Log")
                {
                    ToolTip = 'Specifies the value of the Move To Interface Log field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Interface Incoming Data Mapping")
            {
                Caption = 'Interface Incoming Data Mapping';
                Image = MapAccounts;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Interf. Incoming Data Mapping";
                ToolTip = 'Open the mapping for the incoming data';
            }
            action("Master Data Validate Priority")
            {
                Caption = 'Master Data Validate Priority';
                Image = Hierarchy;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Master Data Validate Priority";
                ToolTip = 'Executes the Master Data Validate Priority action.';
            }
            action("Server Instance Details")
            {
                Caption = 'Server Instance Details';
                Image = Server;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Server Instance Details";
                ToolTip = 'Executes the Server Instance Details action.';
            }
            action("User Setup")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'User Setup',
                            FRA = 'Paramètres utilisateur';
                Image = UserSetup;
                RunObject = Page "User Setup";
                ToolTipML = ENU = 'Set up users to restrict access to post to the general ledger.',
                            FRA = 'Paramétrez les utilisateurs afin de limiter l''accès pour valider en comptabilité.';
            }
            action("Maximo Item Filters")
            {
                Caption = 'Maximo Item Filters';
                Description = 'HEI.07';
                Image = "Filter";
                RunObject = Page "Maximo Item Category Filter";
                ToolTip = 'Executes the Maximo Item Filters action.';
            }
            action("FuturMaster Interface Setup")
            {
                Caption = 'FuturMaster Interface Setup';
                Description = 'HEI.10';
                Image = Setup;
                RunObject = Page "FuturMaster Interface Setup";
                ToolTip = 'Executes the FuturMaster Interface Setup action.';
            }
            action("CVS Interface Setup")
            {
                Caption = 'CVS Interface Setup';
                Description = 'HEI.08';
                Image = Setup;
                RunObject = Page "Cash Van Sales Interface Setup";
                ToolTip = 'Executes the CVS Interface Setup action.';
            }
            action("Esker Interface Setup")
            {
                Caption = 'Esker Interface Setup';
                Description = 'HEI.09';
                Image = Setup;
                RunObject = Page "Esker Interface Setup";
                ToolTip = 'Executes the Esker Interface Setup action.';
            }
            action("EBM Interface Setup")
            {
                Caption = 'EBM Interface Setup';
                Description = 'HEI.12';
                Image = Setup;
                RunObject = Page "EBM Interface Setup";
                ToolTip = 'Executes the EBM Interface Setup action.';
            }
            action("<CounterPoint Interface Setup>")
            {
                Caption = 'CounterPoint Interface Setup';
                Image = Setup;
                RunObject = Page "Counterpoint Interface Setup";
                ToolTip = 'Executes the CounterPoint Interface Setup action.';
            }
            action("Trintech Interface setup")
            {
                Caption = 'Trintech Interface setup';
                Image = Setup;
                RunObject = Page "Trintech Interface Setup";
                ToolTip = 'Executes the Trintech Interface setup action.';
            }
            action("Bank Connectivity Interface setup")
            {
                Caption = 'Bank Connectivity Interface setup';
                Image = Setup;
                RunObject = Page "Bank Conn. Interface Setup";
                ToolTip = 'Executes the Bank Connectivity Interface setup action.';
            }
            action("Ortec & KStore Interface Setup")
            {
                Caption = 'Ortec & KStore Interface Setup';
                Description = 'HEI.15';
                Image = Setup;
                RunObject = Page "Ortec & KStore Interface Setup";
                ToolTip = 'Executes the Ortec & KStore Interface Setup action.';
            }
            action("Maraki Interface Setup")
            {
                Caption = 'Maraki Interface Setup';
                Image = Setup;
                RunObject = Page "Maraki Interface Setup";
                ToolTip = 'Executes the Maraki Interface Setup action.';
            }
            action("EDI Interface Setup")
            {
                Caption = 'EDI Interface Setup';
                Description = 'HEI.17';
                Image = Setup;
                RunObject = Page "EDI Interface Setup";
                ToolTip = 'Executes the EDI Interface Setup action.';
            }
            action("<Page WMS & LogoPak Interface Setup>")
            {
                Caption = 'WMS & LogoPak Interface Setup';
                Description = 'HEI.18';
                Enabled = true;
                Image = Setup;
                RunObject = Page "WMS & LogoPak Interface Setup";
                ToolTip = 'Executes the WMS & LogoPak Interface Setup action.';
            }
            action("Legacy Futur Master Interface Setup")
            {
                Caption = 'Legacy Futur Master Interface Setup';
                Image = Setup;
                RunObject = Page "Legacy Futur Master Int Setup";
                ToolTip = 'Executes the Legacy Futur Master Interface Setup action.';
            }
            action("SRM Interface Setup")
            {
                Image = Setup;
                RunObject = Page "SRM Interface Setup";
                ToolTip = 'Executes the SRM Interface Setup action.';
            }
            action("Rub SRM")
            {
                Image = Setup;
                ToolTip = 'Executes the Rub SRM action.';
                //RunObject = codeunit 50021;  // BC Upgrade NANDIS03 - Blocked trmporarily
            }
            action("SAGE Interface Setup")
            {
                Image = Setup;
                RunObject = Page "Sage Interface Setup";
                ToolTip = 'Executes the SAGE Interface Setup action.';
            }
            action("BVM Interface Setup")
            {
                Caption = 'BVM Interface Setup';
                Image = Setup;
                RunObject = Page "BVM Interface Setup";
                ToolTip = 'Executes the BVM Interface Setup action.';
            }
            action("API Interface Setup")
            {
                Caption = 'API Interface Setup';
                Image = Setup;
                RunObject = Page "API Interface Setup2";
                ToolTip = 'Executes the API Interface Setup action.';
            }
            action("DDE Interface Setup")
            {
                Caption = 'DDE Interface Setup';
                Image = Setup;
                RunObject = Page "DDE Interface Setup";
                ToolTip = 'Executes the DDE Interface Setup action.';
            }
            action("PowerApps Interface Setup")
            {
                Image = Setup;
                RunObject = Page "PowerApps Interface Setup";
                ToolTip = 'Executes the PowerApps Interface Setup action.';
            }
            action("DMS Interface Setup")
            {
                Caption = 'DMS Interface Setup';
                Image = Setup;
                RunObject = Page "DMS Interface Setup";
                ToolTip = 'Executes the DMS Interface Setup action.';
            }
            action("LSR Interface Setup")
            {
                Caption = 'LSR Interface Setup';
                Image = Setup;
                RunObject = Page "LSR Interface Setup";
                ToolTip = 'Executes the LSR Interface Setup action.';
            }
            action("B2B Interface Setup")
            {
                Caption = 'B2B Interface Setup';
                Image = Setup;
                RunObject = Page "B2B Interface Setup";
                ToolTip = 'Executes the B2B Interface Setup action.';
            }
            action("Ibecor Interface Setup")
            {
                Image = Setup;
                RunObject = Page "Ibecor Interface Setup";
                ToolTip = 'Executes the Ibecor Interface Setup action.';
            }
            action("SEM Interface Setup")
            {
                Caption = 'SEM Interface Setup';
                Image = Setup;
                RunObject = Page "SEM Interface Setup";
                ToolTip = 'Executes the SEM Interface Setup action.';
            }
            action("HeiFlow Interface Setup")
            {
                Image = Setup;
                RunObject = Page "HeiFLOW Interface Setup";
                ToolTip = 'Executes the HeiFlow Interface Setup action.';
            }
            action("Astro Interface Setup")
            {
                Caption = 'Astro Interface Setup';
                Description = 'HEI.48';
                Image = Setup;
                ToolTip = 'Executes the Astro Interface Setup action.';
                //RunObject = Page "Astro Interface Setup";  // BC Upgrade NANDIS03 - Blocked as interface not req
            }
            action("EBMS Interface Setup")
            {
                Caption = 'EBMS Interface Setup';
                Description = 'HEI.48';
                Image = Setup;
                RunObject = Page "EBMS Inferface";
                ToolTip = 'Executes the EBMS Interface Setup action.';
            }
            action("PAC Interface Setup")
            {
                Caption = 'PAC Interface Setup';
                Description = 'HEI.52';
                Image = Setup;
                ToolTip = 'Executes the PAC Interface Setup action.';
                //RunObject = Page "PAC Electronic Invoicing Setup";  // BC Upgrade NANDIS03 - Blocked as interface not req
            }
            action("Zycus Interface Setup")
            {
                Caption = 'Zycus Interface Setup';
                Description = 'HEI.53';
                Image = Setup;
                RunObject = Page "Zycus Interface Setup";
                ToolTip = 'Executes the Zycus Interface Setup action.';
            }
            action("CNET Interface Setup")
            {
                Caption = 'CNET Interface Setup';
                Description = 'HEI.55';
                Image = Setup;
                ToolTip = 'Executes the CNET Interface Setup action.';
                //RunObject = Page "CNET Interface Setup";  // BC Upgrade NANDIS03 - Blocked as interface not req
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.RESET();
        if not Rec.GET() then begin
            REC.INIT();
            REC.INSERT();
        end;
    end;
}

