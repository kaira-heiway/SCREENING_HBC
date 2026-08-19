pageextension 51150 ItemCardExtCBN extends "Item Card"
{
    //     DITW15.00.00.01 DDR 18/12/2007 Added Drink-it Tax Item Charges functionnalities
    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    //                                  2034646 "Autom. Item Charge"
    //                                  splitting Item Charges menu to Sales/Purchase
    // DITW15.00.00.01 DDR 21/12/2007 added tab "Drink Tax"
    //                                added fields
    //                                  2034647 Drink Tax Group Code
    // DITW15.00.00.01 DDR 03/01/2008 Rename tab "Drink Tax" -> "Drink-It"
    //                                added fields
    //                                  2013630 Item DDeposit Group Code
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 15/01/2008 Default value "Auto. Item Charge"
    // DITW15.00.00.01 DDR 21/01/2008 Added Drink-it Disc.& Promotion functionalities
    //                                added "No. of Drink Disc. Groups","No. of Promotion Groups"
    //                                added menu into item, Sales & Purchases
    //                                added field "Unit Volume in HL"
    // DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    //                                Added column "Price Incl. Reversing Calc."
    // DITW15.00.00.01 DDR 05/02/2008 Change captions menu (Drink-it)
    // DITW15.00.00.01 DDR 19/03/2008 Added menu Deposit Limits into Sales button
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.16 DDR 28/03/2008 Added property RunFormLinkType = OnUpdate for menu "Empty Goods Tracking" (item button)
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.19 DDR 23/05/2008 added fields
    //                                  2013622 Allow Empty Goods Neg. Qty.
    // DITW15.00.00.20 DDR 06/06/2008 Certification rules
    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    //                                  DLE 25/04/2008 Added field "Auto Receive after Qlty. Test"
    //                                      Added menu Item, Test history
    // DITW15.00.00.23 DDR 28/07/2008 Added CurrForm.UPDATECONTROLS() into AfterGetCurrRec trigger
    //                     12/08/2008 Certification Rules
    //                                  Rename Standards -> Quality Standards (Item button)
    //                                  Rename Test History -> Quality Item Test History (Item button)
    // DITW15.00.00.24 DDR 22/09/2008 Added menu button Sales\Specifications - Tariffs
    //                                Added menu button Sales\Internal Tax Charges
    //                                Added Shortcut fields about Tax Specification - Tariffs
    //                                Added function EnableTaxSpecControls()
    // DITW15.00.00.28 DDR 24/11/2008 Added fields "AAD Nos." into tab Drink-It
    // DITW15.00.00.28,HLW15.00.01.01 DDR 28/11/2008 Added menu "Packing List" in "Functions" button
    // DITW15.00.00.30 DDR 09/01/2009 Added "Shipping" tab
    //                                Added fields into "Shipping"
    //                                  2014441 Location Code
    // DITW15.00.00.31 DDR 19/02/2009 Removed menus (not used)
    //                                  "Packing list" from Functions button
    // DITW15.00.00.31 DDR 19/02/2009 Removed field "Allow Empty Goods Neg. Qty." tab "Drink-it"
    //                                Added standard fields
    //                                 "Country/Region Purchased Code" into 'Foreign Trade' tab
    // DITW15.00.00.32 DDR 09/04/2009 Added property AutoFormatType for all ShortcutTaxSpecValues
    // DITW15.00.00.33 DDR 11/05/2009 Added field "AAD Text (Area 23) Code" into Drink-It tab
    //  HLW15.00.01.01 DDR 05/06/2009 Added menu "Packing List" in "Functions" button
    // DITW15.00.00.35 DDR 24/06/2009 Added field into Drink-It tab
    //                                  "Gen. Bus. Posting Free Group","Free Item Posting Type","Free item"
    //                                issue 772 save record before lookup Drink Discount/Promotion groups
    // DITW15.00.00.35 DDR 13/10/2009 issue 722 Added "As Empty Good" into 'General' tab
    // DITW15.00.00.36 DDR 18/12/2009 issue 701 Added fields "Douane" (for proforma invoice)
    // DITW15.00.00.37 DDR 04/01/2010 issue 701 merge Drink-it2 -> Drink-it tab
    //                     02/02/2010 issue 954 Removed default value in NewRecord()
    //                     02/02/2010 issue 960 Added standard field "Inventory Value Zero" tab 'Invoicing'
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                     06/08/2010           Hide Tax Specification shortcuts (Drink-It tab)
    //                 CEL 13/08/2010           Bugfix open Form in menu button1100083003 'Tax Charge'
    //                 DDR 13/01/2011 DIT-715 issue 42 RTC Upgrade: Added lookup triggers for flowfields
    //                                             "No. of Drink Disc. Groups","No. of Promotion Groups"
    // DITW15.00.00.38 DDR 12/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added "Tax Product Unit Index" into 'DrinkIt' tab
    //                                  Remove Text control1100083031
    //                                  Added update form after validate "Item Dtax Group code"
    //                                  Modified controls for 'LookupFormID' property
    //                                    "Customer DTax Group Code","Customer DDeposit Group Code"
    //                                  Added fields into 'Foreign Trade','Drink-It' tabs
    //                                    "Wine Product Category","Wine Growing zone","Wine Operation Code"
    // DITW15.00.00.38 DDR 14/10/2010 issue 1139 SSCC Functionnalities
    //                                  Added menu 'SSCC Entries' into 'Item\Entries' menu button
    //                                  Added SSCC fields into 'Shipping' tab
    //                                  Modified Caption menu 'SSCC Tracking Entries' + Call function
    //                     09/12/2010 issue 1139 (DIT711 100)
    //                                  Added fields (Shipping tab) "SSCC Company No."
    // DITW15.00.00.39 DDR 09/05/2011 issue 1328 Shop (iPos) Functionnalities
    //                                  Added tab 'Drink-It (Pos)'
    //                                  Added fields (tab 'Drink-It (Pos)')
    //                                    "Pos System","Pos System Timestamp"
    //                                  Added menu "SOM Synchronize" into 'Item' button
    //                     22/08/2011 issue 1366 Added control "Quarantine Inventory" (as flowfield) into tab 'General','Shipping'
    //                     25/08/2011 issue 1393 Added fields "Treeview Group Code" into 'General' tab
    //                     29/08/2011 issue 1396 Added fields "No. of Exclusivity Groups" into 'Drink-it' tab
    //                                           Added 'Exclusivity Groups' menu into 'Item' button
    //                                           Added 'Item Exclusivity' menu into 'Sales','Purchases' button
    //                     12/09/2011 issue 1393 Bugfix field "Treeview Group Code" property 'LookupFormID'
    //                     28/10/2011 issue 1457 Modified many ML captions
    // DITW16.00.00.40 PRODW14.00.00.08.19 DDR 20/12/2011 issue 1466 Added menu 'Sales\Quality Standards'
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added fields "Allow VAT Calculation (Free)" into 'Drink-it' tab
    //                     13/01/2012 DIT-715 #188 RTC Design 'Drink-it' tab
    //                     16/04/2012 DIT-715 #247 Sponsoring & Events functionnality
    //                                 Added fields "Reverse Location Code" into 'Shipping' tab
    //                     18/04/2012 DIT-715 #243 Loyalty functionnality
    //                                  Added fields "No. of Loyalty Groups" into 'Drink-it' tab
    //                                  Added 'Item Loyalty Statistics' menu into 'Item' button
    //                                  Added 'Loyalty Groups' menu into 'Item' button
    //                                  Added 'Loyalty Items' menu into 'Sales' button
    //                                  Moved menu "SOM Synchronize" into 'Functions' button
    //                     13/06/2012 DIT-715 #338 Added 'Period (Items)' menu into button 'Item\Item Item Availability by'
    //                                             Added 'Items by Period' into button 'Item'
    // DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                             Added 'Component' menu button
    //                 DDR 28/09/2012 DIT-715 #454 Added fields into 'Replenishment' tab
    //                                              "Org.Manufacturer (OEM)","Suggested Vendor (OEM)","Default Service Item No. (OEM)"
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "Split Deposit on Invoice" into 'Drink-It' tab
    // DITW16.00.00.43 AHU 28/05/2013 DIT-715 #497 Added fields "Exclusivity"
    //                 DDR 14/08/2013 DIT-715 #605 Added fields "Modified Unit Price"
    //                 DDR 25/09/2013 DIT-715 #519 Added fields "Gift Box Item" (Drink-It tab)
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                 DDR 30/01/2014 DIT-715 #605 Removed editable on "Unit Price"

    // FINXLXL7.00 RBE 20/03/2013 : Code for allowing insert or not
    //                                  Renumber Copy Item report 2036301 -> 2029613
    // FINXLXL7.00 KLU 16/10/2013 : Renamed controls because of conflict with variable names
    //                                    PreventNegInventoryDefaultYes --> PrevNegInventoryDefaultYes
    //                                    PreventNegInventoryDefaultNo --> PrevNegInventoryDefaultNo
    // FINXL7.00 DAT 07/04/2014 : Added Action "Item Properties"
    //               RBE 17/04/2014 : Added tab properties
    //                                Added action "Copy Item From Package"
    // FINXL7.00 KLU 27/06/2014 #42: Added menuitem "Recycle Charges"
    // FINXL8.00.001 BSA 04/06/2015 #51: Added Field "Location Code" and Tab Shipping
    // FINXL8.00.001 BSA 23/06/2015 #161: Apply Template when Create new Item
    // FINXL8.00.001 BSA 25/06/2015 #181 : Create Advanced SKU
    // FINXL8.00.001 BSA 10/07/2015 : delete action copy item
    // MANXL7.00 DAT 26/02/2014 #2: Open Routing and BOM from Item
    // MANXL7.00 DAT 03/03/2014 #10: Added fields "Planning Group" + "Production Group"
    // MANXL7.00 DAT 03/03/2014 #12: Version Management
    // MANXL7.00 WSA 11/07/2014 #87: Added code MANXL security

    // MANXL7.00.001 DAT 26/02/2014 #2: Open Routing and BOM from Item
    // MANXL7.00.001 DAT 03/03/2014 #10: Added fields "Planning Group" + "Production Group"
    // MANXL7.00.001 DAT 03/03/2014 #12: Version Management
    // MANXL7.00.001 WSA 11/07/2014 #87: Added code MANXL security

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 28/05/2013 DIT-715 #497 merge
    //              DDR 09/08/2013 DIT-770 #102 Modified 'LookupPageID' property field "Drink Tax Group"
    //                                          Added 'Tax Groups' Action into 'Relation' button
    //              DDR 14/08/2013 DIT-715 #605 merge
    // DITW17.00.02 AT  09/09/2013 DIT-770 #145 merge WHN-001 HIT0016
    //                             Added field "St. Return reason code" on page
    // DITW17.00.02 SR 10/09/2013 DIT-770 #143 : change log entries view
    // DITW17.00.02 AT  12/09/2013 DIT-770 #132 merge WHN-006 HIT0122.1
    //                             Add new field to DIT #376 promotion reason codes
    //              DDR 01/10/2013 DIT-715 #519 Merge

    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.00.02 RPG 05/11/2013 DIT-770 #235 Added Field "Description 2" on General Fasttab
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 12/03/2013 DIT-770 #147 : New Field "Volume Unit" Added in Drink-It Tab
    // DITW17.00.02 DDR 30/01/2014 DIT-715 #605 merge
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #623 New Customer Exception Tax Group functionality
    //                                          Added menu to "Customer Exception Tax Groups"
    // DITW17.10.03 DDR 13/06/14 DIT-770 #392 Item Quota Management Functionality
    //                                        Added menu "Quota Group","Item Quota Group"
    //                                        Added field "No. of Quota Groups"
    // DITW17.10.03 DDR 03/07/14 DIT-770 #393 Brand Price List functionnality
    //                                        Added "Brand Code" (tab General)
    // DITW18.00.06 MSF 03/02/2015 DIT-770 #1182 Added Option Assembly on field "Replenishment System"
    // DITW18.00.06 MSF 16/02/2015 DIT-770 #1185 Added Action to calcualate Std cost for SKUs
    //                  20/02/2015 DIT-770 #1185 Modify Caption to calculate Std cost
    // DITW18.00.06 MSF 09/03/2015 DIT-770 #1186 Change caption uncluding SKU --> SKU Only
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 MSF  04/10/14 DIT-770 #857 :Replenishment system "Assembly" not available on teh Item card page
    //                                           "Replenishment System"  (fix number of option like STD )
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.07 VSC 22/01/2016 DIT-770 #1702 Assign "Manco/Surplus Tolerance %" from ItemCat.
    // DITW18.00.07 VSC 01/03/2016 DIT-770 #1702 Move Field "Manco/Surplus Tolerance %" to Tab Shipping
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW19.00.07 MVN 25/05/2016 DIT-770 #1937 Removed Group + Field 2029620 "Location Code XL"
    // DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added field "Item Delivery Type" under Shipping tab
    // DITW19.00.07 MSF 04/07/2016 DIT-770 #1965  Item and Item list/ customer and Customer List - navigate ribbon
    //                                            Check And fix  Ribbon
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionalit<<<<<y
    //                                           Look&Feel minor correction
    //                                           Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code","Vol-Strength Spec. Value","Strength Method
    // DITW19.00.08 DDR 29/09/2016 BL#10443 Look&feel minor correction (field moved to shipping tab)

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 09/02/2017 NRQ#0 Moved DIT factboxes below
    // DITW110.00.08 DDR 21/02/2017 NRQ#20692 temporary visible "Product Group Code" NAV field back. (NAV2017= non-visible)
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // FINXL9.00.001 ACH 26/07/2016 : set the visibility of the report (copy item) OnOpenPage
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL10.00 AKH 20/01/2017 Set property VISBLE to FALSE for action Attributes
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Added new fields "Backorder Type" and "Qty. on Sales Blanket Order"
    // DITW110.00.10 MSF 14/07/2017 NRQ#16224 Modify lookup Page for Item Deposit group
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New fields
    //                                         2013653 "Deposit Value Method"
    //                                         2013654 "Deposit Value"
    // FINXL10.01 OFE 31/08/017 NRQ#10433: Added fields - "Purchase Price Warning"
    //                                                  - "Sales Price Warning"
    // DITW110.00.11 SFI 12/12/2017 NRQ#10509 Sales and purchase gross net prices
    // DITW110.00.12 AKH 21/03/2018 NRQ#64704 Added fields "Production Unit of Measure" under Replenishment tab
    //                                                     "Inventory Unit of Measure" under Inventory tab
    // DITW110.00.12 AHU 21/03/2018 NRQ#64704 Invt. UOM and Prod. UOM
    // DITW110.00.12A ISL 21/06/2018 NRQ#67425 Added new fields  "Free Item (Purchase)"
    //                                                           "Free Reason Code (Purchase)"
    //HEI.01 FDD PRDGAP038 IBM COSTES02 07.08.2017 Added new fields : Quantity Quality Hold,Quantity Unrestricted (Pass),Quantity Blocked (Fail)
    // HEI.02 FDD-GAPID043 IBM LAZARE02 05.07.2017
    //   # New fields: Batch Number Policy, Cross Plant Material Status
    //   # Make the Attributes action visible
    // HEI.03 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New field: "WHT Product Posting Group"
    // HEI.04 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added "CIL CODE "and  "CIL2 Code" to page
    // HEI.05 FDD-PRDGAP36B IBM.ISYED01 22.08.2017 Item LifeCycle Status
    //   # New feild added to the Page "Cross-Plant Material Status" and "Plant-Specific Material Status"
    // HEI.06 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # check field RPM Solution
    // `HEI.07 FDD-KDD0TC001 IBM HORTOC01 02.10.2017
    //   # check fields
    // HEI.08 FDD-RFC141 IBM LAZARE02 20.09.2017
    //   # New fields for Maximo in the Inventory tab
    // HEI.09 Defect #1328 #1329 IBM NASTAA02 19.12.2017 # Missing fields in file creation
    //   # Added new field
    // HEI.10 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field added "Full BOM Counterpart"
    // HEI.11 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
    //   # New Field added: "Available Inv. (Whse)"
    // HEI.12 FDD-HB722 IBM SURYAS01 10.10.2019
    //   #Removed the following fields From Inventory Tab:
    //   –Machine Reference Number
    //   –Rotating Item
    //   –Certification Required
    //   –Item Segmentation
    // HEI.13 CHG2147859 SAHAL01 22.07.2022
    //   # Added New Tab - Astro
    //   # Added New Fields - Item Interface Code for Astro
    //                      - Item Parked for Astro
    //                      - Last Parked Date for Astro
    //                      - Last Parked Time for Astro
    //   # Added Code to visible Astro Tab
    // HEI.14 CHG2224401 HB3624 YADAVM09 09.02.2024 Health and Security Levy Tax
    //   # New Field Added #H&S Levy Tax Posting Group

    // BC Upgrade Kamnay01 in Heineken_RTR extension is created for adding CIL ID Code and CIL ID2 Code fields to Item card page 
    //bc Upgrade YADAVM09 field Added "Product Group Code".
    //****************************************************************
    //HEI.15 BC UPGRADE PATHAA02-13.03.26; #Inventory UoM functionality added.
    //# Added DIT field "Inventory Unit of Measure" 

    layout
    {
        modify(Item)
        {
            CaptionML = ENU = 'Item', FRA = 'Article';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item.', FRA = 'Spécifie le numéro de l''article.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the item.', FRA = 'Spécifie une description de l''élément.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies that transactions with the item cannot be posted, for example, because the item is in quarantine.', FRA = 'Indique que les transactions avec l''article ne peuvent pas être validées, par exemple, parce que l''article est en quarantaine.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies if the item card represents a physical item (Inventory) or a service (Service).', FRA = 'Spécifie si la fiche article représente un article physique (Stock) ou un service (Service).';
        }
        modify("Base Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit in which the item is held in inventory.', FRA = 'Spécifie l''unité dans laquelle l''article est stocké.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the item card was last modified.', FRA = 'Spécifie la date à laquelle la fiche article a été modifiée pour la dernière fois.';
        }
        modify(GTIN)
        {
            ToolTipML = ENU = 'Specifies the item in connection with electronic document sending and receiving.', FRA = 'Spécifie l''article en relation avec l''envoi et la réception de documents électroniques.';
        }
        modify("Item Category Code")
        {

            //Unsupported feature: Change Level on ""Item Category Code"(Control 170)". Please convert manually.

            ToolTipML = ENU = 'Specifies the category that the item belongs to.', FRA = 'Spécifie la catégorie à laquelle l''article appartient.';
        }

        //BC Upgrade Kamnay01>> -Field is Deprecated >>
        // modify("Product Group Code")
        // {

        //     //Unsupported feature: Change Level on ""Product Group Code"(Control 168)". Please convert manually.

        //     ToolTipML = ENU = 'Contains a product group code associated with the item category.', FRA = 'Contient un code groupe produits associé à la catégorie article.';

        //     //Unsupported feature: Change Visible on ""Product Group Code"(Control 168)". Please convert manually.


        //     //Unsupported feature: Change Description on ""Product Group Code"(Control 168)". Please convert manually.

        // }
        //BC Upgrade Kamnay01<< -Field is Deprecated >>
        modify("Service Item Group")
        {

            //Unsupported feature: Change Level on ""Service Item Group"(Control 180)". Please convert manually.

            ToolTipML = ENU = 'Contains the code of the service item group that the item belongs to.', FRA = 'Contient le code du groupe articles de service auquel appartient l''article.';
        }
        modify(InventoryGrp)
        {
            CaptionML = ENU = 'Inventory', FRA = 'Stocks';
        }
        modify("Shelf No.")
        {

            //Unsupported feature: Change Level on ""Shelf No."(Control 10)". Please convert manually.

            ToolTipML = ENU = 'Specifies where to find the item in the warehouse.', FRA = 'Spécifie où trouver l''article dans l''entrepôt.';
        }
        modify("Created From Nonstock Item")
        {

            //Unsupported feature: Change Level on ""Created From Nonstock Item"(Control 164)". Please convert manually.

            ToolTipML = ENU = 'Specifies that the item was created from a nonstock item.', FRA = 'Spécifie que l''article a été créé à partir d''un article non stocké.';
        }
        modify(Inventory)
        {

            //Unsupported feature: Change Level on "Inventory(Control 14)". Please convert manually.

            ToolTipML = ENU = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.', FRA = 'Spécifie le nombre d''unités (par exemple des pièces, des boîtes ou des palettes) en stock.';
        }
        modify(InventoryNonFoundation)
        {

            //Unsupported feature: Change Level on "InventoryNonFoundation(Control 205)". Please convert manually.

            CaptionML = ENU = 'Inventory', FRA = 'Stock';
            ToolTipML = ENU = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.', FRA = 'Spécifie le nombre d''unités (par exemple des pièces, des boîtes ou des palettes) en stock.';
        }
        modify("Qty. on Purch. Order")
        {

            //Unsupported feature: Change Level on ""Qty. on Purch. Order"(Control 16)". Please convert manually.

            ToolTipML = ENU = 'Shows how many units of the item are inbound on purchase orders, meaning listed on outstanding purchase order lines.', FRA = 'Spécifie le nombre d''unités de l''article entrant sur les commandes achat, à savoir mentionné sur des lignes commande achat ouvertes.';
        }
        modify("Qty. on Prod. Order")
        {

            //Unsupported feature: Change Level on ""Qty. on Prod. Order"(Control 172)". Please convert manually.

            ToolTipML = ENU = 'Shows how many units of the item are allocated to production orders, meaning listed on outstanding production order lines.', FRA = 'Spécifie le nombre d''unités de l''article alloué aux ordres de fabrication, à savoir mentionné sur des lignes d''ordres de fabrication ouvertes.';
        }
        modify("Qty. on Component Lines")
        {

            //Unsupported feature: Change Level on ""Qty. on Component Lines"(Control 174)". Please convert manually.

            ToolTipML = ENU = 'Shows how many units of the item are allocated as production order components, meaning listed under outstanding production order lines.', FRA = 'Spécifie le nombre d''unités de l''article alloué en tant que composants d''ordres de fabrication, à savoir mentionné sous les lignes d''ordres de fabrication ouvertes.';
        }
        modify("Qty. on Sales Order")
        {

            //Unsupported feature: Change Level on ""Qty. on Sales Order"(Control 18)". Please convert manually.

            ToolTipML = ENU = 'Shows how many units of the item are allocated to sales orders, meaning listed on outstanding sales orders lines.', FRA = 'Spécifie le nombre d''unités de l''article alloué aux ordres de vente, c''est-à-dire mentionné sur des lignes commande vente restantes.';
        }
        modify("Qty. on Service Order")
        {

            //Unsupported feature: Change Level on ""Qty. on Service Order"(Control 189)". Please convert manually.

            ToolTipML = ENU = 'Shows how many units of the item are allocated to service orders, meaning listed on outstanding service order lines.', FRA = 'Spécifie le nombre d''unités de l''article alloué aux commandes service, à savoir mentionné sur des lignes commande service ouvertes.';
        }
        modify("Qty. on Job Order")
        {

            //Unsupported feature: Change Level on ""Qty. on Job Order"(Control 152)". Please convert manually.

            ToolTipML = ENU = 'Shows how many units of the item are allocated to jobs, meaning listed on outstanding job planning lines.', FRA = 'Spécifie le nombre d''unités de l''article alloué aux projets, à savoir mentionné sur des lignes planning projet ouvertes.';
        }
        modify("Qty. on Assembly Order")
        {

            //Unsupported feature: Change Level on ""Qty. on Assembly Order"(Control 7)". Please convert manually.

            ToolTipML = ENU = 'Shows how many units of the item are allocated to assembly orders, which is how many are listed on outstanding assembly order headers.', FRA = 'Spécifie le nombre d''unités de l''article qui sont affectées aux ordres d''assemblage, qui est le nombre répertorié dans les en-têtes ordre d''assemblage en attente.';
        }
        modify("Qty. on Asm. Component")
        {

            //Unsupported feature: Change Level on ""Qty. on Asm. Component"(Control 9)". Please convert manually.

            ToolTipML = ENU = 'Shows how many units of the item are allocated as assembly components, which means how many are listed on outstanding assembly order lines.', FRA = 'Spécifie le nombre d''unités de l''article alloué en tant que composants d''assemblage, ce qui signifie le nombre répertorié dans les lignes ordre d''assemblage ouvertes.';
        }
        modify(StockoutWarningDefaultYes)
        {

            //Unsupported feature: Change Level on "StockoutWarningDefaultYes(Control 113)". Please convert manually.

            CaptionML = FRA = 'Alerte rupture stock';
            ToolTipML = ENU = 'Specifies if a warning is displayed when you enter a quantity on a sales document that brings the item''s inventory below zero.', FRA = 'Spécifie si un avertissement s''affiche lorsque vous entrez une quantité sur un document vente qui fait passer le stock de l''article en dessous de zéro.';
            OptionCaptionML = ENU = 'Default (Yes),No,Yes', FRA = 'Par défaut (Oui),Non,Oui';
        }
        modify(StockoutWarningDefaultNo)
        {

            //Unsupported feature: Change Level on "StockoutWarningDefaultNo(Control 115)". Please convert manually.

            CaptionML = FRA = 'Alerte rupture stock';
            ToolTipML = ENU = 'Specifies if a warning is displayed when you enter a quantity on a sales document that brings the item''s inventory below zero.', FRA = 'Spécifie si un avertissement s''affiche lorsque vous entrez une quantité sur un document vente qui fait passer le stock de l''article en dessous de zéro.';
            OptionCaptionML = ENU = 'Default (No),No,Yes', FRA = 'Par défaut (Non),Non,Oui';
        }
        modify(PreventNegInventoryDefaultYes)
        {

            //Unsupported feature: Change Level on "PreventNegInventoryDefaultYes(Control 120)". Please convert manually.

            CaptionML = FRA = 'Éviter stock négatif';
            ToolTipML = ENU = 'Specifies if you can post a transaction that will bring the item''s inventory below zero.', FRA = 'Indique si vous pouvez valider une transaction qui entraînerait un stock de l''article négatif.';
            OptionCaptionML = ENU = 'Default (Yes),No,Yes', FRA = 'Par défaut (Oui),Non,Oui';
        }
        modify(PreventNegInventoryDefaultNo)
        {

            //Unsupported feature: Change Level on "PreventNegInventoryDefaultNo(Control 130)". Please convert manually.

            CaptionML = FRA = 'Éviter stock négatif';
            ToolTipML = ENU = 'Specifies if you can post a transaction that will bring the item''s inventory below zero.', FRA = 'Indique si vous pouvez valider une transaction qui entraînerait un stock de l''article négatif.';
            OptionCaptionML = ENU = 'Default (No),No,Yes', FRA = 'Par défaut (Non),Non,Oui';
        }
        modify("Net Weight")
        {

            //Unsupported feature: Change Level on ""Net Weight"(Control 196)". Please convert manually.

            ToolTipML = ENU = 'Specifies the net weight of the item.', FRA = 'Indique le poids net de l''article.';
        }
        modify("Gross Weight")
        {

            //Unsupported feature: Change Level on ""Gross Weight"(Control 235)". Please convert manually.

            ToolTipML = ENU = 'Specifies the gross weight of the item.', FRA = 'Indique le poids brut de l''article.';
        }
        //BC Upgrade Kamnay01>> - The control '"Price & Posting"' is not found in the target 'Item Card'
        // modify("Price & Posting")
        // {
        //     CaptionML = ENU = 'Price & Posting', FRA = 'Prix et validation';
        // }
        //BC Upgrade Kamnay01<< - The control '"Price & Posting"' is not found in the target 'Item Card'
        modify("Unit Price")
        {
            ToolTipML = ENU = 'Specifies the price for one unit of the item, in LCY.', FRA = 'Spécifie le prix unitaire, en DS, de l''article.';
        }
        modify(CalcUnitPriceExclVAT)
        {
            ToolTipML = ENU = 'Specifies the unit price excluding VAT.', FRA = 'Spécifie le prix unitaire hors TVA.';
        }
        modify("Price Includes VAT")
        {
            ToolTipML = ENU = 'Specifies if the Unit Price and Line Amount fields on sales document lines for this item should be shown with or without VAT.', FRA = 'Spécifie si les champs Prix unitaire et Montant ligne sur les lignes document vente pour cet article doivent être affichés avec ou sans la TVA.';
        }
        modify("Price/Profit Calculation")
        {
            ToolTipML = ENU = 'Specifies if the Profit Percentage field, the Unit Price field, or neither field is calculated and filled.', FRA = 'Spécifie si le champ Pourcentage marge sur vente, le champ Prix unitaire ou aucun des deux champs est calculé et renseigné.';
        }
        // modify(SpecialPricesAndDiscountsTxt)
        // {
        //     CaptionML = ENU = 'Special Prices & Discounts', FRA = 'Prix et remises spéciaux';
        //     ToolTipML = ENU = 'Specifies special prices and line discounts for the item.', FRA = 'Indique des prix spéciaux et des remises ligne pour l''article.';
        // }
        modify("Profit %")
        {
            ToolTipML = ENU = 'Specifies the profit margin you want to sell the item at.', FRA = 'Spécifie la marge bénéficiaire à laquelle vous souhaitez vendre l''article.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the cost per unit of the item.', FRA = 'Spécifie le coût par unité de l''article.';
        }
        modify("Overhead Rate")
        {
            ToolTipML = ENU = 'Specifies the item''s indirect cost as an absolute amount.', FRA = 'Spécifie le coût indirect de l''article en tant que montant absolu.';
        }
        modify("Allow Invoice Disc.")
        {
            ToolTipML = ENU = 'Specifies if the item should be included in the calculation of an invoice discount on documents where the item is traded.', FRA = 'Spécifie si l''article doit être inclus dans le calcul d''une remise facture sur les documents dans lesquels l''article est négocié.';
        }
        modify("Item Disc. Group")
        {
            ToolTipML = ENU = 'Specifies an item group code that can be used as a criterion to grant a discount when the item is sold to a certain customer.', FRA = 'Indique le code groupe articles qui peut être utilisé comme critère pour obtenir un escompte lorsque l''article est vendu à un client particulier.';
        }
        modify("Cost Details")
        {
            CaptionML = ENU = 'Cost Details', FRA = 'Détails de coûts';
        }
        modify("Costing Method")
        {
            ToolTipML = ENU = 'Specifies how the item''s cost flow is recorded and whether an actual or budgeted value is capitalized and used in the cost calculation.', FRA = 'Spécifie la manière dont le flux des coûts de l''article est enregistré et si une valeur réelle ou budgétée est capitalisée et utilisée dans le calcul des coûts.';
        }
        modify("Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the percentage of the item''s direct unit cost that makes up indirect costs, such as freight and warehouse handling.', FRA = 'Spécifie le pourcentage du coût unitaire direct de l''article qui constitue les coûts indirects comme la gestion du fret et des entrepôts.';
        }
        modify("Last Direct Cost")
        {
            CaptionML = ENU = 'Last Purchase Cost', FRA = 'Dernier coût d''achat';
            ToolTipML = ENU = 'Specifies the most recent direct unit cost of the item.', FRA = 'Spécifie le dernier coût unitaire direct de l''article.';
        }
        //BC Upgrade Kamnay01>> - The control '"Financial Details"' is not found in the target 'Item Card'
        // modify("Financial Details")
        // {
        //     CaptionML = ENU = 'Financial Details', FRA = 'Détails financiers';
        // }
        //BC Upgrade Kamnay01<< - The control '"Financial Details"' is not found in the target 'Item Card'
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the item''s general product posting group. It links business transactions made for this item with the general ledger to account for the value of trade with the item.', FRA = 'Spécifie le groupe comptabilisation produit de l''article. Lie les transactions effectuées pour cet article avec les écritures comptables pour représenter la valeur découlant de la vente de l''article.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the VAT product posting group. Links business transactions made for this item with the general ledger, to account for VAT amounts resulting from trade with the item.', FRA = 'Spécifie le groupe comptabilisation produit TVA. Lie les transactions effectuées pour cet article avec les écritures comptables pour représenter les montants de TVA découlant de la vente de l''article.';
        }
        modify("Inventory Posting Group")
        {
            ToolTipML = ENU = 'Specifies the inventory posting group. Links business transactions made for the item with an inventory account in the general ledger, to group amounts for that item type.', FRA = 'Spécifie le groupe comptabilisation stock. Lie les transactions commerciales effectuées pour l''article à un compte stock en comptabilité pour regrouper les montants pour ce type d''article.';
        }
        modify(ForeignTrade)
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }
        modify("Tariff No.")
        {
            ToolTipML = ENU = 'Specifies a code for the item''s tariff number.', FRA = 'Spécifie un code pour la nomenclature produit de l''article.';
        }
        modify("Country/Region of Origin Code")
        {
            ToolTipML = ENU = 'Specifies a code for the country/region where the item was produced or processed.', FRA = 'Spécifie un code pour le pays/la région où l''article a été produit ou traité.';
        }
        //BC Upgrade Kamnay01>> - The control '"Invoicing"' is not found in the target 'Item Card'
        // modify(Invoicing)
        // {
        //     CaptionML = ENU = 'Invoicing', FRA = 'Facturation';
        // }
        //BC Upgrade Kamnay01<< - The control '"Invoicing"' is not found in the target 'Item Card'
        modify("Cost is Adjusted")
        {
            ToolTipML = ENU = 'Specifies whether the item''s unit cost has been adjusted, either automatically or manually.', FRA = 'Spécifie si le coût unitaire de l''article a été ajusté automatiquement ou manuellement.';
        }
        modify("Cost is Posted to G/L")
        {
            ToolTipML = ENU = 'Specifies that all the inventory costs for this item have been posted to the general ledger.', FRA = 'Spécifie que tous les coûts stock en relation avec cet article ont été validés dans la comptabilité.';
        }
        modify("Standard Cost")
        {
            ToolTipML = ENU = 'Specifies the unit cost that is used as a standard measure.', FRA = 'Spécifie le coût unitaire utilisé comme mesure standard.';
        }
        modify("Default Deferral Template Code")
        {
            CaptionML = ENU = 'Default Deferral Template', FRA = 'Modèle échelonnement par défaut';
            ToolTipML = ENU = 'Specifies how revenue or expenses for the item are deferred to other accounting periods by default.', FRA = 'Spécifie comment les revenus ou les dépenses pour l''article sont échelonnés sur d''autres périodes comptables par défaut.';
        }
        modify("Net Invoiced Qty.")
        {
            ToolTipML = ENU = 'Shows how many units of the item in inventory have been invoiced.', FRA = 'Affiche le nombre d''unités de l''article en stock qui ont été facturées.';
        }
        modify("Sales Unit of Measure")
        {
            ToolTipML = ENU = 'Contains the unit of measure code used when you sell the item.', FRA = 'Contient le code unité de mesure utilisé lorsque vous vendez l''article.';
        }
        modify("Application Wksh. User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of a user who is working in the Application Worksheet window.', FRA = 'Spécifie le code d''un utilisateur qui utilise la fenêtre Feuille lettrage.';
        }
        modify(Replenishment)
        {
            CaptionML = ENU = 'Replenishment', FRA = 'Réapprovisionnement';
        }
        modify("Replenishment System")
        {
            ToolTipML = ENU = 'Specifies the type of supply order created by the planning system when the item needs to be replenished.', FRA = 'Spécifie le type de commande approvisionnement créée par le système de planification lorsque l''article doit être réapprovisionné.';
            // OptionCaptionML = ENU = 'Purchase,Prod. Order,,Assembly', FRA = 'Achat,O.F.,,Assemblage';
        }
        modify("Lead Time Calculation")
        {
            ToolTipML = ENU = 'Specifies a date formula for the amount of time it takes to replenish the item.', FRA = 'Spécifie une formule date pour le délai nécessaire au réapprovisionnement de l''article.';
        }
        modify(Purchase)
        {
            CaptionML = ENU = 'Purchase', FRA = 'Achats';
        }
        modify("Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the vendor code of who supplies this item by default.', FRA = 'Spécifie le code du fournisseur qui fournit cet article par défaut.';
        }
        modify("Vendor Item No.")
        {
            ToolTipML = ENU = 'Specifies the number that the vendor uses for this item.', FRA = 'Spécifie le numéro que le fournisseur utilise pour cet article.';
        }
        modify("Purch. Unit of Measure")
        {
            ToolTipML = ENU = 'Contains the unit of measure code used when you purchase the item.', FRA = 'Contient le code unité de mesure utilisé lorsque vous achetez l''article.';
        }
        //BC Upgrade Kamnay01>> - The control '"Production"' is not found in the target 'Item Card'
        // modify(Production)
        // {
        //     CaptionML = ENU = 'Production', FRA = 'Fabrication';
        // }
        //BC Upgrade Kamnay01<< - The control '"Production"' is not found in the target 'Item Card'
        modify("Manufacturing Policy")
        {
            ToolTipML = ENU = 'Defines whether additional orders for any related components are calculated.', FRA = 'Détermine si les commandes supplémentaires pour tout composant connexe sont calculées.';
        }
        modify("Routing No.")
        {
            ToolTipML = ENU = 'Specifies the number of the routing.', FRA = 'Spécifie le numéro de la gamme.';
        }
        modify("Production BOM No.")
        {
            ToolTipML = ENU = 'Specifies the number of the production BOM.', FRA = 'Spécifie le numéro de la nomenclature de production.';

            //Unsupported feature: Change Description on ""Production BOM No."(Control 139)". Please convert manually.

        }
        modify("Rounding Precision")
        {
            ToolTipML = ENU = 'Defines how calculated consumption quantities are rounded when entered on consumption journal lines.', FRA = 'Définit comment les quantités consommées calculées sont arrondies une fois saisies sur les lignes feuille consommation.';
        }
        modify("Flushing Method")
        {
            ToolTipML = ENU = 'Specifies the method used to calculate and handle the consumption of the item as a component in production processes.', FRA = 'Spécifie la méthode utilisée pour calculer et gérer la consommation de l''article en tant que composant dans les processus de production.';
        }
        modify("Scrap %")
        {
            ToolTipML = ENU = 'Specifies the percentage of the item that you expect to be scrapped in the production process.', FRA = 'Spécifie le taux de rebut prévu pour l''article lors du processus de production.';
        }
        modify("Lot Size")
        {
            ToolTipML = ENU = 'Specifies how many units of the item are processed in one production operation by default.', FRA = 'Spécifie le nombre d''unités de l''article traitées dans une opération de production par défaut.';
        }
        //BC Upgrade Kamnay01>> - The control '"Assembly"' is not found in the target 'Item Card'
        // modify(Assembly)
        // {
        //     CaptionML = ENU = 'Assembly', FRA = 'Assemblage';
        // }
        //BC Upgrade Kamnay01<< - The control '"Assembly"' is not found in the target 'Item Card'
        modify("Assembly Policy")
        {
            ToolTipML = ENU = 'Specifies which default order flow is used to supply this assembly item.', FRA = 'Spécifie le flux de commandes par défaut utilisé pour fournir cet article d''assemblage.';
        }
        //BC Upgrade Kamnay01>> - The control '"Assembly BOM"' is not found in the target 'Item Card'
        // modify("Assembly BOM")
        // {
        //     ToolTipML = ENU = 'Indicates if the item is an assembly BOM.', FRA = 'Spécifie si l''article est une nomenclature d''assemblage.';
        // }
        //BC Upgrade Kamnay01<< - The control '"Assembly BOM"' is not found in the target 'Item Card'
        modify(Planning)
        {
            CaptionML = ENU = 'Planning', FRA = 'Planning';
        }
        modify("Reordering Policy")
        {
            ToolTipML = ENU = 'Specifies the reordering policy.', FRA = 'Spécifie la méthode de réapprovisionnement.';
        }
        modify(Reserve)
        {
            ToolTipML = ENU = 'Indicates whether the program will allow reservations to be made for this item.', FRA = 'Indique si le programme autorise les réservations pour cet article.';
        }
        modify("Order Tracking Policy")
        {
            ToolTipML = ENU = 'Specifies if and how order tracking entries are created and maintained between supply and its corresponding demand.', FRA = 'Spécifie si et comment les écritures chaînage sont créées et mises à jour entre l''offre et la demande correspondante.';
        }
        modify("Stockkeeping Unit Exists")
        {
            ToolTipML = ENU = 'Specifies that a SKU exists for this item.', FRA = 'Spécifie qu''un point de stock existe pour cet article.';
        }
        modify("Dampener Period")
        {
            ToolTipML = ENU = 'Specifies a period of time during which you do not want the planning system to propose to reschedule existing supply orders.', FRA = 'Spécifie la période pendant laquelle vous ne souhaitez pas que le système de planification propose de replanifier les commandes approvisionnement existantes.';
        }
        modify("Dampener Quantity")
        {
            ToolTipML = ENU = 'Specifies a dampener quantity to block insignificant change suggestions for an existing supply, if the change quantity is lower than the dampener quantity.', FRA = 'Spécifie une quantité tampon pour bloquer les propositions de modification non significatives pour un approvisionnement existant si la quantité de modification est inférieure à la quantité tampon.';
        }
        modify(Critical)
        {
            ToolTipML = ENU = 'Specifies if the item is included in availability calculations to promise a shipment date for its parent item.', FRA = 'Spécifie si l''article est inclus dans les calculs de disponibilité pour promettre une date expédition pour son article parent.';
        }
        modify("Safety Lead Time")
        {
            ToolTipML = ENU = 'Defines a date formula to indicate a safety lead time that can be used as a buffer period for production and other delays.', FRA = 'Définit une formule date pour indiquer un délai de sécurité qui peut être utilisé comme période tampon pour la production et autres retards.';
        }
        modify("Safety Stock Quantity")
        {
            ToolTipML = ENU = 'Defines a quantity of stock to have in inventory to protect against supply-and-demand fluctuations during replenishment lead time.', FRA = 'Définit une quantité que vous souhaitez avoir en stock pour vous protéger contre les fluctuations de l''offre et de la demande lors du délai de réapprovisionnement pour l''article.';
        }
        //BC Upgrade Kamnay01>> - The control '"Lot-for-Lot Parameters"' is not found in the target 'Item Card'
        // modify("Lot-for-Lot Parameters")
        // {
        //     CaptionML = ENU = 'Lot-for-Lot Parameters', FRA = 'Paramètres Lot pour lot';
        // }
        //BC Upgrade Kamnay01<< - The control '"Lot-for-Lot Parameters"' is not found in the target 'Item Card'
        modify("Include Inventory")
        {
            ToolTipML = ENU = 'Includes inventory in the projected available balance when replenishment orders are calculated.', FRA = 'Inclut les stocks dans le stock prévisionnel lorsque les commandes réapprovisionnement sont calculées.';
        }
        modify("Lot Accumulation Period")
        {
            ToolTipML = ENU = 'Defines a period in which multiple demands are accumulated into one supply order when you use the Lot-for-Lot reordering policy.', FRA = 'Définit une période pendant laquelle plusieurs demandes sont cumulées en une commande d''approvisionnement lorsque vous utilisez la méthode de réapprovisionnement Lot pour lot.';
        }
        modify("Rescheduling Period")
        {
            ToolTipML = ENU = 'Defines a period within which any suggestion to change a supply date always consists of a Reschedule action and never a Cancel + New action.', FRA = 'Définit une période pendant laquelle toute suggestion visant à modifier une date d''approvisionnement est toujours constituée d''une action Replanifier et jamais d''une action Annuler + Nouveau.';
        }
        //BC Upgrade Kamnay01>> - The control '"Reorder-Point Parameters"' is not found in the target 'Item Card'
        // modify("Reorder-Point Parameters")
        // {
        //     CaptionML = ENU = 'Reorder-Point Parameters', FRA = 'Paramètres Point de commande';
        // }
        //BC Upgrade Kamnay01<< - The control '"Reorder-Point Parameters"' is not found in the target 'Item Card'
        modify("Reorder Point")
        {
            ToolTipML = ENU = 'Specifies a stock quantity that sets the inventory below the level that you must replenish the item.', FRA = 'Spécifie une quantité de stock qui définit le niveau de stock en dessous duquel vous devez réapprovisionner l''article.';
        }
        modify("Reorder Quantity")
        {
            ToolTipML = ENU = 'Specifies a standard lot size quantity to be used for all order proposals.', FRA = 'Spécifie une quantité taille lot standard à utiliser pour toutes les propositions de commandes.';
        }
        modify("Maximum Inventory")
        {
            ToolTipML = ENU = 'Specifies a quantity that you want to use as a maximum inventory level.', FRA = 'Spécifie une quantité à utiliser comme niveau stock maximum.';
        }
        modify("Overflow Level")
        {
            ToolTipML = ENU = 'Specifies a quantity you allow projected inventory to exceed the reorder point, before the system suggests to decrease supply orders.', FRA = 'Spécifie une quantité que vous autorisez le stock prévisionnel à dépasser dans le point de commande avant que le système suggère de limiter les commandes approvisionnement.';
        }
        modify("Time Bucket")
        {
            ToolTipML = ENU = 'Specifies a time period that defines the recurring planning horizon used with Fixed Reorder Qty. or Maximum Qty. reordering policies.', FRA = 'Spécifie une plage horaire qui définit l''horizon de planification récurrent utilisé avec la méthode de réapprovisionnement Qté fixe de commande ou Qté maximum.';
        }
        //BC Upgrade Kamnay01>> - The control '"Order Modifiers"' is not found in the target 'Item Card'
        // modify("Order Modifiers")
        // {
        //     CaptionML = ENU = 'Order Modifiers', FRA = 'Modificateur ordre';
        // }
        //BC Upgrade Kamnay01<< - The control '"Order Modifiers"' is not found in the target 'Item Card'
        modify("Minimum Order Quantity")
        {
            ToolTipML = ENU = 'Defines a minimum allowable quantity for an item order proposal.', FRA = 'Définit une quantité minimale autorisée pour une proposition commande article.';
        }
        modify("Maximum Order Quantity")
        {
            ToolTipML = ENU = 'Specifies a maximum allowable quantity for an item order proposal.', FRA = 'Spécifie une quantité maximale autorisée pour une proposition commande article.';
        }
        modify("Order Multiple")
        {
            ToolTipML = ENU = 'Defines a parameter used by the planning system to modify the quantity of planned supply orders.', FRA = 'Définit un paramètre utilisé par le système de planification pour modifier la quantité des commandes approvisionnement planifiées.';
        }
        //BC Upgrade Kamnay01>> - The control '"Item Tracking"' is not found in the target 'Item Card'
        // modify("Item Tracking")
        // {
        //     CaptionML = ENU = 'Item Tracking', FRA = 'Traçabilité';
        // }
        //BC Upgrade Kamnay01<< - The control '"Item Tracking"' is not found in the target 'Item Card'
        modify("Item Tracking Code")
        {
            ToolTipML = ENU = 'Contains the code that indicates how the program will track the item in inventory.', FRA = 'Contient le code qui indique la manière dont le programme suit l''article dans le stock.';
        }
        modify("Serial Nos.")
        {
            ToolTipML = ENU = 'Specifies a number series code to assign consecutive serial numbers to items produced.', FRA = 'Spécifie un code souche de numéros pour que le programme affecte des numéros de série consécutifs aux articles produits.';
        }
        modify("Lot Nos.")
        {
            ToolTipML = ENU = 'Contains the number series code that will be used when assigning lot numbers.', FRA = 'Contient le code souche de numéros qui est utilisé lors de l''affectation des numéros de lot.';
        }
        modify("Expiration Calculation")
        {
            ToolTipML = ENU = 'Contains the formula for calculating the expiration date on the item tracking line.', FRA = 'Contient la formule de calcul de la date expiration des lignes traçabilité article.';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Warehouse Class Code")
        {
            ToolTipML = ENU = 'Specifies the warehouse class code for the item.', FRA = 'Spécifie le code classe entrepôt pour l''article.';
        }
        modify("Special Equipment Code")
        {
            ToolTipML = ENU = 'Contains the code of the equipment that warehouse employees must use when handling the item.', FRA = 'Contient le code de l''équipement dont doivent se servir les magasiniers lors du traitement de l''article.';
        }
        modify("Put-away Template Code")
        {
            ToolTipML = ENU = 'Contains the code of the put-away template by which the program determines the most appropriate zone and bin for storage of the item after receipt.', FRA = 'Contient le code modèle rangement à l''aide duquel le programme détermine la zone et l''emplacement les plus adaptés au stockage de l''article après réception.';
        }
        modify("Put-away Unit of Measure Code")
        {
            ToolTipML = ENU = 'Contains the code of the item unit of measure in which the program will put the item away.', FRA = 'Contient le code de l''unité article dans laquelle le programme range l''article.';
        }
        modify("Phys Invt Counting Period Code")
        {
            ToolTipML = ENU = 'Contains the code of the counting period that indicates how often you want to count the item in a physical inventory.', FRA = 'Contient le code de la période d''inventaire qui indique la fréquence d''inventaire de l''article lors d''un inventaire.';
        }
        modify("Last Phys. Invt. Date")
        {
            ToolTipML = ENU = 'Contains the date on which you last posted the results of a physical inventory for the item to the item ledger.', FRA = 'Contient la date de la dernière validation des résultats de l''inventaire d''un article donné dans l''écriture article.';
        }
        modify("Last Counting Period Update")
        {
            ToolTipML = ENU = 'Contains the last date on which you calculated the counting period. It is updated when you use the function Calculate Counting Period.', FRA = 'Indique la dernière date à laquelle vous avez calculé la période d''inventaire. Ce champ est mis à jour lorsque vous utilisez la fonction Calculer période inventaire.';
        }
        modify("Identifier Code")
        {
            ToolTipML = ENU = 'Contains a unique code for the item in terms that are useful for automatic data capture.', FRA = 'Contient un code unique propre à l''article utile à la saisie automatisée.';
        }
        modify("Use Cross-Docking")
        {
            ToolTipML = ENU = 'Specifies if this item can be cross-docked.', FRA = 'Spécifie si cet article peut être transbordé.';
        }
        modify(ItemPicture)
        {
            CaptionML = ENU = 'Picture', FRA = 'Image';
        }
        //BC Upgrade Kamnay01 make field non editable IBM GAP DTW 81 >>
        modify("Unit Volume STD  101FDW") ///Unit volume HL Field
        {
            Editable = false;
        }
        //BC Upgrade Kamnay01 make field non editable IBM GAP DTW 81 <<
        //Unsupported feature: CodeInsertion on ""Unit Price"(Control 38)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW16.00.00.43 DDR 14/08/2013 DIT-715 #605
        CurrPage.UPDATE(true);
        // >>DITW16.00.00.43 DDR DIT-715 #605
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Production BOM No."(Control 139)". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        // var
        //     lrecProdBOMHeader : Record "Production BOM Header";
        //begin
        /*
        //<<MANXL7.00 DAT 26/02/2014 #2
        if lrecProdBOMHeader.GET("Production BOM No.") then
          PAGE.RUN(PAGE::"Production BOM",lrecProdBOMHeader)
        //>>MANXL7.00 DAT 26/02/2014 #2
        */
        //end;
        moveafter("No."; "No. 2") //BC Version 28.0 Compatibility Fix
        modify("No. 2") //BC Version 28.0 Compatibility Fix
        {
            Visible = true;
            ToolTip = 'Specifies the alternative number of the item.';
        }
        addafter("No.")
        {
            // field("No. 2"; Rec."No. 2") //BC Version 28.0 Compatibility Fix
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the alternative number of the item.';
            // }
            //BC Upgrade Kamnay01>>DITW fields
            field("Production Unit of Measure"; Rec."Production Unit of Measure FND")
            {
                ApplicationArea = All;
            }
            //BC Upgrade Kamnay01<<DITW fields
        }
        //---BC Upgrade KAMNAY01>>  A member of type Field with name 'Description 2' is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft
        // addafter(Description)
        // {
        //     field("Description 2";Rec."Description 2")
        //     {
        //     }
        // }
        //---BC Upgrade KAMNAY01<< A member of type Field with name 'Description 2' is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft
        addafter("Automatic Ext. Texts")
        {   //BC Upgrade KAMNAY01>> DITW fields
            // field(Template; Rec.Template)
            // {
            //     Description = 'MANXL7.00.001';
            //     Importance = Additional;
            // }
            // field("fctGetLastActiveRevision(""No."")"; fctGetLastActiveRevision("No."))
            // {
            //     CaptionML = ENU = 'Recent Active Item Revision',
            //                 FRA = 'Révison active récente';
            //     Description = 'MANXL7.00.001';
            //     Editable = false;
            //     Importance = Additional;
            // }
            // field("Product Group Code R1"; "Product Group Code R1")
            // {
            // }
            //BC Upgrade KAMNAY01<< DITW fields
            // BC Upgrade Kamnay01 in Heineken_RTR extension is created for adding CIL ID Code and CIL ID2 Code fields to Item card page 
            // field("CIL ID Code"; Rec."CIL ID Code")
            // {
            //     ApplicationArea=All;
            // }
            // field("CIL ID2 Code"; Rec."CIL ID2 Code")
            // {
            //     ApplicationArea=All;
            // }
            // BC Upgrade Kamnay01 in Heineken_RTR extension is created for adding CIL ID Code and CIL ID2 Code fields to Item card page 
        }

        //Bc Upgrade YADAVM09>>
        addafter("Over-Receipt Code")
        {
            field("Product Group Code"; Rec."Product Group Code FND")
            {
                ApplicationArea = all;
            }
            //HEI.15>>
            field("Inventory Unit of Measure"; Rec."Inventory Unit of Measure FND")
            {
                ApplicationArea = all;
            }
            //HEI.15<<
        }
        //Bc Upgrade YADAVM09<<
        addfirst(InventoryGrp)
        {
            group(Control110100002)
            {
            }
        }
        //BC Upgrade KAMNAY01>> DITW fields
        // addfirst("Product Group Code")
        // {
        //     field("Brand Code"; "Brand Code")
        //     {
        //         Description = 'DIT-770 393';
        //     }
        // }

        // addfirst("Service Item Group")
        // {
        //     field("Planning Group"; "Planning Group")
        //     {
        //         Description = 'MANXL7.00.001';
        //     }
        //     field("Production Group"; "Production Group")
        //     {
        //         Description = 'MANXL7.00.001';
        //     }
        // }

        // addfirst("Gross Weight")
        // {
        //     field("Return Reason Code"; "Return Reason Code")
        //     {
        //         Description = 'DITW17.00.02 DIT-770 #145';
        //     }
        // }

        // addfirst("Shelf No.")
        // {
        //     field("Inventory Unit of Measure"; Rec."Inventory Unit of Measure")
        //     {
        //     }
        // }
        //BC Upgrade KAMNAY01<< DITW fields
        addfirst(Item)
        {
            field("Item Type"; Rec."Item Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type field.';
            }
            field("RPM Solution"; Rec."RPM Solution FND")
            {
                ApplicationArea = All;
                //OptionCaption = '" ,Deposit,Full-for-Empty with revenue impact (FFE with revenue),Full-for Empty without revenue impact (FFE w/o revenue)"';
                ToolTip = 'Specifies the value of the RPM Solution field.';
            }
            field("RPM Type"; Rec."RPM Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RPM Type field.';
            }
            group(Control110100003)
            {
            }
        }
        addfirst(InventoryGrp)
        {
            field("Available Inv. (Whse)"; Rec."Available Inv. (Whse) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Available Inv. (Whse) field.';
            }
            //BC Upgrade KAMNAY01>> DITW fields
            // field("Inventory HL"; Rec."Inventory HL")
            // {
            //     Importance = Additional;
            // }
            // field("Inventory (Degrees)"; Rec."Inventory (Degrees)")
            // {
            //     Importance = Additional;
            // }

            // field(QuarantineInvtQty; QuarantineInvtQty)
            // {
            //     CaptionML = ENU = 'Quarantine Inventory',
            //                 FRA = 'Stock quarantaine';
            //     DecimalPlaces = 0 : 5;
            //     Description = 'MANXL9.00.001';
            //     Editable = false;
            //     Importance = Additional;

            //     trigger OnDrillDown();
            //     begin
            //         //<<MANXL9.00.001 DAT 23/03/2016
            //         DrilldownInvtLocQuarantine(FIELDNO(Inventory));
            //         //>>MANXL9.00.001 DAT 23/03/2016
            //     end;
            // }
            //BC Upgrade KAMNAY01<< DITW fields
        }
        //BC Upgrade KAMNAY01>> DITW fields
        // addfirst("Qty. on Asm. Component")
        // {
        //     field("Qty. on Sales Blanket Order"; Rec."Qty. on Sales Blanket Order")
        //     {
        //         Importance = Additional;
        //     }
        // }

        // addfirst("Price & Posting")
        // {
        //     field("Modified Unit Price"; Rec."Modified Unit Price")
        //     {
        //         Editable = false;
        //         Importance = Additional;
        //     }
        // }

        // addafter("Unit Cost")
        // {
        //     field("Purchase Net Cost"; "Purchase Net Cost")
        //     {
        //         Importance = Additional;

        //         trigger OnDrillDown();
        //         var
        //             ShowAvgCalcItem: Codeunit "Show Avg. Calc. - Item";
        //         begin
        //             // <<HIT0016.1 YHE 20/04/2016 FRH-004 #30
        //             ShowAvgCalcItem.DrillDownPurchaseNetCost(Rec)
        //             // >>HIT0016.1 YHE 20/04/2016 FRH-004 #30
        //         end;
        //     }
        // }
        //BC Upgrade KAMNAY01<< DITW fields
        addafter("Item Disc. Group")
        {
            //BC Upgrade KAMNAY01>> DITW fields
            // field("Purchase Warning No Warning"; "Purchase Price Warning")
            // {
            //     OptionCaption = 'Default (No Warning),No Warning,Warning,Blocked';
            //     Visible = bolShowPurchaseNoWarning;
            // }
            // field("Purchase Warning Warning"; "Purchase Price Warning")
            // {
            //     OptionCaption = 'Default (Warning),No Warning,Warning,Blocked';
            //     Visible = bolShowPurchaseWarning;
            // }
            // field("Purchase Warning Blocked"; "Purchase Price Warning")
            // {
            //     OptionCaption = 'Default (Blocked),No Warning,Warning,Blocked';
            //     Visible = bolShowPurchaseBlocked;
            // }
            // field("Sales Warning No Warning"; "Sales Price Warning")
            // {
            //     OptionCaption = 'Default (No Warning),No Warning,Warning,Blocked';
            //     Visible = bolShowSalesNoWarning;
            // }
            // field("Sales Warning Warning"; "Sales Price Warning")
            // {
            //     OptionCaption = 'Default (Warning),No Warning,Warning,Blocked';
            //     Visible = bolShowSalesWarning;
            // }
            // field("Sales Warning Blocked"; "Sales Price Warning")
            // {
            //     OptionCaption = 'Default (Blocked),No Warning,Warning,Blocked';
            //     Visible = bolShowSalesBlocked;
            // }
            //BC Upgrade KAMNAY01<< DITW fields
            field("H&S Levy Tax Posting Group"; Rec."H&S Levy Tax Posting Group FND")
            {
                Visible = EnableHSLevy;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the H&S Levy Tax Posting Group field.';
            }
        }
        addafter("Inventory Posting Group")
        {
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WHT Product Posting Group field.';
            }
        }
        addafter("Country/Region of Origin Code")
        {
            field("Country/Region Purchased Code"; Rec."Country/Region Purchased Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Country/Region Purchased Code field.';
            }
            //BC Upgrade KAMNAY01>>DITW fields
            // field("Value Douane"; Rec."Value Douane")
            // {
            // }
            // field("Wine Product Category"; Rec."Wine Product Category")
            // {
            // }
            // field("Wine Growing zone"; Rec."Wine Growing zone")
            // {
            // }
            // field("Wine Operation Code"; Rec."Wine Operation Code")
            // {
            // }

            // group(Shipping)
            // {
            //     CaptionML = ENU = 'Shipping',
            //                 FRA = 'Livraison';
            //     field("Location Code"; Rec."Location Code")
            //     {
            //         Importance = Promoted;
            //     }
            //     field("Reverse Location Code"; Rec."Reverse Location Code")
            //     {
            //     }
            //     field("Backorder Type"; Rec."Backorder Type")
            //     {
            //     }
            //     group(Routes)
            //     {
            //         CaptionML = ENU = 'Routes',
            //                     FRA = 'Routes';
            //         field("Item Delivery Type"; Rec."Item Delivery Type")
            //         {
            //         }
            //     }
            //     group("Manco/Surplus")
            //     {
            //         CaptionML = ENU = 'Manco/Surplus',
            //                     FRA = 'Manco/Surplus';
            //         field("Manco/Surplus Tolerance %"; Rec."Manco/Surplus Tolerance %")
            //         {
            //         }
            //     }
            // }
            //BC Upgrade KAMNAY01<< DITW fields
        }
        //BC Upgrade KAMNAY01>> A member of type Field with name 'Inventory Value Zero' is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
        // addafter("Application Wksh. User ID")
        // {
        //     field("Inventory Value Zero"; Rec."Inventory Value Zero")
        //     {
        //     }
        // }
        //BC Upgrade KAMNAY01<< A member of type Field with name 'Inventory Value Zero' is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
        //BC Upgrade KAMNAY01>> DITW fields
        // addafter("Lead Time Calculation")
        // {
        //     field("Org. Manufacturer (OEM)"; Rec."Org. Manufacturer (OEM)")
        //     {
        //     }
        //     field("Suggested Vendor (OEM)"; Rec."Suggested Vendor (OEM)")
        //     {
        //     }
        //     field("Default Service Item No. (OEM)"; Rec."Default Service Item No. (OEM)")
        //     {
        //     }
        // }

        // addafter("Manufacturing Policy")
        // {
        //     field("Production Unit of Measure"; Rec."Production Unit of Measure")
        //     {
        //     }
        // }
        // addafter(Critical)
        // {
        //     field("Planning Colour"; Rec."Planning Colour")
        //     {
        //     }
        // }
        //BC Upgrade KAMNAY01<< DITW fields
        addafter("Safety Stock Quantity")
        {
            field("Cross-Plant Material Status"; Rec."Cross-Plant Mtrl. Status FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cross-Plant Material Status field.';
            }
        }
        addafter("Expiration Calculation")
        {
            field("Batch Number Policy"; Rec."Batch Number Policy FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Batch Number Policy field.';
            }
            //BC Upgrade KAMNAY01>>DITW fields
            // group("SSCC Tracking")
            // {
            //     CaptionML = ENU = 'SSCC Tracking',
            //                 FRA = 'Traçabilité SSCC';
            //     field("SSCC Nos.";  Rec."SSCC Nos.")
            //     {
            //     }
            //     field("EAN Unit of Measure Code";  Rec."EAN Unit of Measure Code")
            //     {
            //     }
            //     field("GTIN Unit of Measure Code";  Rec."GTIN Unit of Measure Code")
            //     {
            //     }
            //     field(Stackable; Rec.Stackable)
            //     {
            //     }
            //     field("SSCC Company No.";  Rec."SSCC Company No.")
            //     {
            //         Numeric = true;
            //     }
            //     field("Bartender Label Layout SSCC";  Rec."Bartender Label Layout SSCC")
            //     {
            //         Description = 'DIT-715 #806';
            //     }
            // }
            //BC Upgrade KAMNAY01<< DITW fields
        }

        //BC UPGRADE PATHAA02 StdCost-FDD DTW 16>>
        addafter("Routing No.")
        {
            field("New Location Code"; Rec."New Location Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the New Location Code field.';
            }
        }
        //BC UPGRADE PATHAA02 StdCost-FDD DTW 16<<

        addafter(Warehouse)
        {//BC Upgrade KAMNAY01>> DITW fields
         // group(Quality)
         // {
         //     CaptionML = ENU = 'Quality',
         //                 FRA = 'Qualité';
         //     Description = 'QXL9.00.001';

            // field("Quality Standard No.";  Rec."Quality Standard No.")
            // {
            //     Description = 'QXL9.00.001';
            // }
            // field("Quarantine Posting Policy";  Rec."Quarantine Posting Policy")
            // {
            //     Description = 'QXL9.00.001';
            // }
            // field("Auto Receive after Qlty. Test";  Rec."Auto Receive after Qlty. Test")
            // {
            //     Description = 'QXL9.00.001';
            // }
            // field("Qty. Quarantined (Base)";  Rec."Qty. Quarantined (Base)")
            // {
            //     Description = 'QXL9.00.001';
            // }
            // field("Qty. Passed (Base)";  Rec."Qty. Passed (Base)")
            // {
            //     Description = 'QXL9.00.001';
            // }
            // field("Qty. Failed (Base)";  Rec."Qty. Failed (Base)")
            // {
            //     Description = 'QXL9.00.001';
            // }
            // field("Qty. Concessioned (Base)";  Rec."Qty. Concessioned (Base)")
            // {
            //     Description = 'QXL9.00.001';
            // }
            //BC Upgrade KAMNAY01<< DITW fields
            field("Quantity Quality Hold"; Rec."Quantity Quality Hold FND")
            {
                Description = 'HEI.01 ';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Quality Hold (Quarantine) field.';
            }
            field("Quantity Unrestricted (Pass)"; Rec."Qty Unrestricted (Pass) FND")
            {
                Description = 'HEI.01 ';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Unrestricted (Pass) field.';
            }
            field("Quantity Blocked (Fail)"; Rec."Quantity Blocked (Fail) FND")
            {
                Description = 'HEI.01 ';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Blocked (Fail) field.';
            }
            field("Full BOM Counterpart"; Rec."Full BOM Counterpart FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Full BOM Counterpart field.';
            }
            //BC Upgrade KAMNAY01>> DITW fields
            // } // //BC Upgrade KAMNAY01>> Curly braces comment closed for Quality group
            // group("Drink-It")
            // {
            //     CaptionML = ENU = 'Drink-It',
            //                 FRA = 'Drink-It';
            //     field("Autom. Item Charge"; Rec."Autom. Item Charge")
            //     {
            //     }
            //     group("Volume Type")
            //     {
            //         CaptionML = ENU = 'Volume Type',
            //                     FRA = 'Type Volume';
            //         field("Volume Unit of Measure Code"; REC."Volume Unit of Measure Code")
            //         {
            //         }
            //         field("Unit Volume HL"; Rec."Unit Volume HL")
            //         {
            //         }
            //     }
            //     group(Taxes)
            //     {
            //         CaptionML = ENU = 'Taxes',
            //                     FRA = 'Taxes';
            //         field("Item DTax Group Code"; Rec."Item DTax Group Code")
            //         {
            //             Importance = Promoted;
            //             LookupPageID = "Drink Item Tax Groups";

            //             trigger OnValidate();
            //             begin
            //                 ItemDTaxGroupCodeOnAfterValida;
            //             end;
            //         }
            //         field("AAD Nos."; Rec."AAD Nos.")
            //         {
            //         }
            //         field("AAD Field (Area 23) Code";Rec."AAD Field (Area 23) Code")
            //         {
            //         }
            //         field("Copy Value Douane"; Rec."Value Douane")
            //         {
            //             Importance = Promoted;
            //         }
            //         field("Product Tax Code"; Rec."Product Tax Code")
            //         {
            //         }
            //         field("Fiscal Mark Code"; Rec."Fiscal Mark Code")
            //         {
            //         }
            //         field("Copy Wine Product Category"; Rec."Wine Product Category")
            //         {
            //         }
            //         field("Copy Wine Growing zone"; Rec."Wine Growing zone")
            //         {
            //         }
            //         field("Copy Wine Operation Code"; Rec."Wine Operation Code")
            //         {
            //         }
            //         field("Strength Method"; Rec."Strength Method")
            //         {
            //         }
            //         field("Strength Spec. Code"; Rec."Strength Spec. Code")
            //         {

            //             trigger OnValidate();
            //             begin
            //                 CurrPage.UPDATE;
            //             end;
            //         }
            //         field("Strength Spec. Value"; Rec."Strength Spec. Value")
            //         {
            //             Editable = GlobalTax1ValueEditable;

            //             trigger OnValidate();
            //             begin
            //                 CurrPage.UPDATE(true);
            //             end;
            //         }
            //         field("Vol-Strength Spec. Code"; Rec."Vol-Strength Spec. Code")
            //         {

            //             trigger OnValidate();
            //             begin
            //                 CurrPage.UPDATE;
            //             end;
            //         }
            //         field("Vol-Strength Spec. Value"; Rec."Vol-Strength Spec. Value")
            //         {
            //             Editable = GlobalTax2ValueEditable;

            //             trigger OnValidate();
            //             begin
            //                 CurrPage.UPDATE(true);
            //             end;
            //         }
            //     }
            //     group("Deposits & Empty Goods")
            //     {
            //         CaptionML = ENU = 'Deposits & Empty Goods',
            //                     FRA = 'Consigne';
            //         field("Item DDeposit Group Code"; Rec."Item DDeposit Group Code")
            //         {
            //             Description = '<DITW15.00.00.01>-NRQ#16224';
            //             LookupPageID = "Item Drink Deposit Groups";
            //         }
            //         field("Empty Good"; Rec."Empty Good")
            //         {
            //         }
            //         field("Split Deposit on Invoice"; Rec."Split Deposit on Invoice")
            //         {
            //         }
            //         field("Deposit Value Method"; Rec."Deposit Value Method")
            //         {
            //         }
            //         field("Deposit Value"; Rec."Deposit Value")
            //         {
            //         }
            //     }
            //     group(Discounts)
            //     {
            //         CaptionML = ENU = 'Discounts',
            //                     FRA = 'Remise & Promotion';
            //         field("No. of Drink Disc. Groups"; Rec."No. of Drink Disc. Groups")
            //         {
            //             DrillDown = false;

            //             trigger OnLookup(Text: Text): Boolean;
            //             var
            //                 DDiscountRel: Record "Drink Discount Relation";
            //             begin
            //                 // <<DITW16.00.00.37 DDR 13/01/2011 DIT-715 #42
            //                 CurrPage.SAVERECORD;
            //                 COMMIT;
            //                 DDiscountRel.FILTERGROUP(2);
            //                 DDiscountRel.SETRANGE("Source Type", DDiscountRel."Source Type"::Item);
            //                 DDiscountRel.SETRANGE("Source No.", "No.");
            //                 DDiscountRel.FILTERGROUP(0);
            //                 PAGE.RUNMODAL(0, DDiscountRel);
            //                 CurrPage.UPDATE(false);
            //             end;
            //         }
            //     }
            //     group(Promotions)
            //     {
            //         CaptionML = ENU = 'Promotions',
            //                     FRA = 'Promotions';
            //         field("No. of Promotion Groups"; Rec."No. of Promotion Groups")
            //         {
            //             DrillDown = false;

            //             trigger OnLookup(Text: Text): Boolean;
            //             var
            //                 DPromotionRel: Record "Drink Promotion Relation";
            //             begin
            //                 // <<DITW16.00.00.37 DDR 13/01/2011 DIT-715 #42
            //                 CurrPage.SAVERECORD;
            //                 COMMIT;
            //                 DPromotionRel.FILTERGROUP(2);
            //                 DPromotionRel.SETRANGE("Source Type", DPromotionRel."Source Type"::Item);
            //                 DPromotionRel.SETRANGE("Source No.", "No.");
            //                 DPromotionRel.FILTERGROUP(0);
            //                 PAGE.RUNMODAL(0, DPromotionRel);
            //                 CurrPage.UPDATE(false);
            //             end;
            //         }
            //         field("Free Item Posting Type"; Rec."Free Item Posting Type")
            //         {
            //         }
            //         field("Gen. Prod. Posting Free Group"; Rec."Gen. Prod. Posting Free Group")
            //         {
            //         }
            //         field("Free Item"; Rec."Free Item")
            //         {
            //         }
            //         field("Free Reason Code"; Rec."Free Reason Code")
            //         {
            //             Description = 'DITW17.00.02 DIT-770 #132';
            //         }
            //         field("Allow VAT Calculation (Free)"; Rec."Allow VAT Calculation (Free)")
            //         {
            //         }
            //         field("Free Item (Purchase)"; Rec."Free Item (Purchase)")
            //         {
            //             Description = 'DITW110.00.12A NRQ#67425';
            //         }
            //         field("Free Reason Code (Purchase)"; Rec."Free Reason Code (Purchase)")
            //         {
            //             Description = 'DITW110.00.12A NRQ#67425';
            //         }
            //         field("Full BOM Counterpart"; Rec."Full BOM Counterpart")
            //         {
            //         }
            //     }
            //     group(Others)
            //     {
            //         CaptionML = ENU = 'Others',
            //                     FRA = 'Autre';
            //         field(Exclusivity;Rec.Exclusivity)
            //         {
            //         }
            //         field("No. of Exclusivity Groups"; Rec."No. of Exclusivity Groups")
            //         {
            //         }
            //         field("No. of Loyalty Groups"; "No. of Loyalty Groups")
            //         {
            //             Description = 'DIT715 #243';
            //         }
            //         field("No. of Quota Groups"; Rec."No. of Quota Groups")
            //         {
            //         }
            //         field("Gift Box Item"; Rec."Gift Box Item")
            //         {
            //         }
            //     }
            //     group("Tax Specifications - Tariffs")
            //     {
            //         CaptionML = ENU = 'Tax Specifications - Tariffs',
            //                     FRA = 'Spécifiactions taxes';
            //         field("Tax Spec. View Code"; Rec."Tax Spec. View Code")
            //         {
            //             Importance = Promoted;

            //             trigger OnValidate();
            //             begin
            //                 TaxSpecViewCodeOnAfterValidate;
            //             end;
            //         }
            //     }
            // }

            // group(Control1100910008)
            // {
            //     CaptionML = ENU = 'Tax Specifications - Tariffs',
            //                 FRA = 'Spécifiactions taxes';
            //     Description = 'see factbox, disabled DITW16.00.00.37 06/08/2010 #1';
            //     field(ShortcutTaxSpec1; ShortcutTaxSpecValue[1])
            //     {
            //         AutoFormatExpression = ShortcutTaxSpecFormatType[1];
            //         AutoFormatType = 2013664;
            //         CaptionClass = GetTaxSpecViewCaption(1);
            //         Editable = ShortcutTaxSpec1Editable;
            //         Enabled = ShortcutTaxSpec1Enable;
            //         MinValue = 0;
            //         Visible = ShortcutTaxSpec1Visible;

            //         trigger OnLookup(Text: Text): Boolean;
            //         begin
            //             LookupShortcutTaxSpecValue(1, ShortcutTaxSpecValue[1]);
            //         end;

            //         trigger OnValidate();
            //         begin
            //             ValidateShortcutTaxSpecCode(1, ShortcutTaxSpecValue[1]);
            //         end;
            //     }
            //     field(ShortcutTaxSpec2; ShortcutTaxSpecValue[2])
            //     {
            //         AutoFormatExpression = ShortcutTaxSpecFormatType[2];
            //         AutoFormatType = 2013664;
            //         CaptionClass = GetTaxSpecViewCaption(2);
            //         Editable = ShortcutTaxSpec2Editable;
            //         Enabled = ShortcutTaxSpec2Enable;
            //         MinValue = 0;
            //         Visible = ShortcutTaxSpec2Visible;

            //         trigger OnLookup(Text: Text): Boolean;
            //         begin
            //             LookupShortcutTaxSpecValue(2, ShortcutTaxSpecValue[2]);
            //         end;

            //         trigger OnValidate();
            //         begin
            //             ValidateShortcutTaxSpecCode(2, ShortcutTaxSpecValue[2]);
            //         end;
            //     }
            //     field(ShortcutTaxSpec3; ShortcutTaxSpecValue[3])
            //     {
            //         AutoFormatExpression = ShortcutTaxSpecFormatType[3];
            //         AutoFormatType = 2013664;
            //         CaptionClass = GetTaxSpecViewCaption(3);
            //         Editable = ShortcutTaxSpec3Editable;
            //         Enabled = ShortcutTaxSpec3Enable;
            //         MinValue = 0;
            //         Visible = ShortcutTaxSpec3Visible;

            //         trigger OnLookup(Text: Text): Boolean;
            //         begin
            //             LookupShortcutTaxSpecValue(3, ShortcutTaxSpecValue[3]);
            //         end;

            //         trigger OnValidate();
            //         begin
            //             ValidateShortcutTaxSpecCode(3, ShortcutTaxSpecValue[3]);
            //         end;
            //     }
            //     field(ShortcutTaxSpec4; ShortcutTaxSpecValue[4])
            //     {
            //         AutoFormatExpression = ShortcutTaxSpecFormatType[4];
            //         AutoFormatType = 2013664;
            //         CaptionClass = GetTaxSpecViewCaption(4);
            //         Editable = ShortcutTaxSpec4Editable;
            //         Enabled = ShortcutTaxSpec4Enable;
            //         MinValue = 0;
            //         Visible = ShortcutTaxSpec4Visible;

            //         trigger OnLookup(Text: Text): Boolean;
            //         begin
            //             LookupShortcutTaxSpecValue(4, ShortcutTaxSpecValue[4]);
            //         end;

            //         trigger OnValidate();
            //         begin
            //             ValidateShortcutTaxSpecCode(4, ShortcutTaxSpecValue[4]);
            //         end;
            //     }
            //     field(ShortcutTaxSpec5; ShortcutTaxSpecValue[5])
            //     {
            //         AutoFormatExpression = ShortcutTaxSpecFormatType[5];
            //         AutoFormatType = 2013664;
            //         CaptionClass = GetTaxSpecViewCaption(5);
            //         Editable = ShortcutTaxSpec5Editable;
            //         Enabled = ShortcutTaxSpec5Enable;
            //         MinValue = 0;
            //         Visible = ShortcutTaxSpec5Visible;

            //         trigger OnLookup(Text: Text): Boolean;
            //         begin
            //             LookupShortcutTaxSpecValue(5, ShortcutTaxSpecValue[5]);
            //         end;

            //         trigger OnValidate();
            //         begin
            //             ValidateShortcutTaxSpecCode(5, ShortcutTaxSpecValue[5]);
            //         end;
            //     }
            //     field(ShortcutTaxSpec6; ShortcutTaxSpecValue[6])
            //     {
            //         AutoFormatExpression = ShortcutTaxSpecFormatType[6];
            //         AutoFormatType = 2013664;
            //         CaptionClass = GetTaxSpecViewCaption(6);
            //         Editable = ShortcutTaxSpec6Editable;
            //         Enabled = ShortcutTaxSpec6Enable;
            //         MinValue = 0;
            //         Visible = ShortcutTaxSpec6Visible;

            //         trigger OnLookup(Text: Text): Boolean;
            //         begin
            //             LookupShortcutTaxSpecValue(6, ShortcutTaxSpecValue[6]);
            //         end;

            //         trigger OnValidate();
            //         begin
            //             ValidateShortcutTaxSpecCode(6, ShortcutTaxSpecValue[6]);
            //         end;
            //     }
            //     field(ShortcutTaxSpec7; ShortcutTaxSpecValue[7])
            //     {
            //         AutoFormatExpression = ShortcutTaxSpecFormatType[7];
            //         AutoFormatType = 2013664;
            //         CaptionClass = GetTaxSpecViewCaption(7);
            //         Editable = ShortcutTaxSpec7Editable;
            //         Enabled = ShortcutTaxSpec7Enable;
            //         MinValue = 0;
            //         Visible = ShortcutTaxSpec7Visible;

            //         trigger OnLookup(Text: Text): Boolean;
            //         begin
            //             LookupShortcutTaxSpecValue(7, ShortcutTaxSpecValue[7]);
            //         end;

            //         trigger OnValidate();
            //         begin
            //             ValidateShortcutTaxSpecCode(7, ShortcutTaxSpecValue[7]);
            //         end;
            //     }
            //     field(ShortcutTaxSpec8; ShortcutTaxSpecValue[8])
            //     {
            //         AutoFormatExpression = ShortcutTaxSpecFormatType[8];
            //         AutoFormatType = 2013664;
            //         CaptionClass = GetTaxSpecViewCaption(8);
            //         Editable = ShortcutTaxSpec8Editable;
            //         Enabled = ShortcutTaxSpec8Enable;
            //         MinValue = 0;
            //         Visible = ShortcutTaxSpec8Visible;

            //         trigger OnLookup(Text: Text): Boolean;
            //         begin
            //             LookupShortcutTaxSpecValue(8, ShortcutTaxSpecValue[8]);
            //         end;

            //         trigger OnValidate();
            //         begin
            //             ValidateShortcutTaxSpecCode(8, ShortcutTaxSpecValue[8]);
            //         end;
            //     }
            //     field(ShortcutTaxSpec9; ShortcutTaxSpecValue[9])
            //     {
            //         AutoFormatExpression = ShortcutTaxSpecFormatType[9];
            //         AutoFormatType = 2013664;
            //         CaptionClass = GetTaxSpecViewCaption(9);
            //         Editable = ShortcutTaxSpec9Editable;
            //         Enabled = ShortcutTaxSpec9Enable;
            //         MinValue = 0;
            //         Visible = ShortcutTaxSpec9Visible;

            //         trigger OnLookup(Text: Text): Boolean;
            //         begin
            //             LookupShortcutTaxSpecValue(9, ShortcutTaxSpecValue[9]);
            //         end;

            //         trigger OnValidate();
            //         begin
            //             ValidateShortcutTaxSpecCode(9, ShortcutTaxSpecValue[9]);
            //         end;
            //     }
            //     field(ShortcutTaxSpec10; ShortcutTaxSpecValue[10])
            //     {
            //         AutoFormatExpression = ShortcutTaxSpecFormatType[10];
            //         AutoFormatType = 2013664;
            //         CaptionClass = GetTaxSpecViewCaption(10);
            //         Editable = ShortcutTaxSpec10Editable;
            //         Enabled = ShortcutTaxSpec10Enable;
            //         MinValue = 0;
            //         Visible = ShortcutTaxSpec10Visible;

            //         trigger OnLookup(Text: Text): Boolean;
            //         begin
            //             LookupShortcutTaxSpecValue(10, ShortcutTaxSpecValue[10]);
            //         end;

            //         trigger OnValidate();
            //         begin
            //             ValidateShortcutTaxSpecCode(10, ShortcutTaxSpecValue[10]);
            //         end;
            //     }
            // }
            //BC Upgrade KAMNAY01<< DITW fields
            group("Search & Treeview")
            {
                CaptionML = ENU = 'Search & Treeview',
                            FRA = 'Recherche & Treeview';
                //BC Upgrade KAMNAY01>>DITW fields

                // field("Treeview Code"; Rec."Treeview Code")
                // {
                //     Importance = Promoted;
                //     LookupPageID = "Treeview Setup - Groups List";
                // }
                // field("Belongs Item No."; Rec."Belongs Item No.")
                // {

                //     trigger OnValidate();
                //     begin
                //         BelongsItemNoOnAfterValidate;
                //     end;
                // }
                //BC Upgrade KAMNAY01<< DITW fields

                field(BelongsItemDescription; BelongsItemDescription)
                {
                    CaptionML = ENU = 'Related to Item - Description',
                                FRA = 'Article lié - Désignation';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BelongsItemDescription field.';
                }
                field(BelongsItemLevel; BelongsItemLevel)
                {
                    BlankZero = true;
                    ApplicationArea = All;
                    CaptionML = ENU = 'Related Item && level',
                                FRA = 'Niveau Article Lié';
                    Editable = false;
                    ToolTip = 'Specifies the value of the BelongsItemLevel field.';
                }
            }
            //BC Upgrade KAMNAY01>>DITW fields
            // group("Pos System")
            // {
            //     CaptionML = ENU = 'Pos System',
            //                 FRA = 'Systéme POS';
            //     field("Pos System"; Rec."Pos System")
            //     {
            //     }
            //     field("Pos System Timestamp"; "Pos System Timestamp")
            //     {
            //         Editable = false;
            //     }
            // }

            // group(Properties)
            // {
            //     CaptionML = ENU = 'Properties',
            //                 FRA = 'Propriétés';
            //     Description = 'FINXL7.00';
            //     field("Shortcut Property 1 Code"; "Shortcut Property 1 Code")
            //     {
            //         Description = 'FINXL7.00';
            //     }
            //     field("Shortcut Property 2 Code"; "Shortcut Property 2 Code")
            //     {
            //         Description = 'FINXL7.00';
            //     }
            //     field("Shortcut Property 3 Code"; "Shortcut Property 3 Code")
            //     {
            //         Description = 'FINXL7.00';
            //     }
            //     field("Shortcut Property 4 Code"; "Shortcut Property 4 Code")
            //     {
            //         Description = 'FINXL7.00';
            //     }
            //     field("Shortcut Property 5 Code"; "Shortcut Property 5 Code")
            //     {
            //         Description = 'FINXL7.00';
            //     }
            //     field("Shortcut Property 6 Code"; "Shortcut Property 6 Code")
            //     {
            //         Description = 'FINXL7.00';
            //     }
            //     field("Shortcut Property 7 Code"; "Shortcut Property 7 Code")
            //     {
            //         Description = 'FINXL7.00';
            //     }
            //     field("Shortcut Property 8 Code"; "Shortcut Property 8 Code")
            //     {
            //         Description = 'FINXL7.00';
            //     }
            //     field("Shortcut Property 9 Code"; "Shortcut Property 9 Code")
            //     {
            //         Description = 'FINXL7.00';
            //     }
            //     field("Shortcut Property 10 Code"; "Shortcut Property 10 Code")
            //     {
            //         Description = 'FINXL7.00';
            //     }
            // }
            //BC Upgrade KAMNAY01<< DITW fields

            //BC Upgrade KAMNAY01>>  Astro Field
            //     group(Astro)
            //     {
            //         Caption = 'Astro';
            //         Visible = VisibleAstro;
            //         field("Item Interface Code for Astro"; Rec."Item Interface Code for Astro")
            //         {
            //         }
            //         field("Item Parked for Astro"; Rec."Item Parked for Astro")
            //         {
            //         }
            //         field("Last Parked Date for Astro"; Rec."Last Parked Date for Astro")
            //         {
            //         }
            //         field("Last Parked Time for Astro"; Rec."Last Parked Time for Astro")
            //         {
            //         }
            //     }
            //BC Upgrade KAMNAY01<< Astro Field
        }


        //BC Upgrade KAMNAY01>> DITW Page
        // addafter(WorkflowStatus)
        // {
        //     part(Control1902612307; "_Item Tax Spec. Factbox")
        //     {
        //         SubPageLink = "No." = FIELD("No.");
        //         Visible = true;
        //     }
        // }
        //BC Upgrade KAMNAY01<< DITW Page
        moveafter(Description; "Search Description")
        moveafter(GTIN; "Automatic Ext. Texts")
        moveafter("Service Item Group"; "Net Weight")
    }
    actions
    {
        //BC Upgrade KAMNAY01>>The action 'Item' is not found in the target 'Item Card'
        // modify(Item)
        // {
        //     CaptionML = ENU = 'Item', FRA = 'Article';
        // }
        //BC Upgrade KAMNAY01<<The action 'Item' is not found in the target 'Item Card'
        modify(Attributes)
        {
            CaptionML = ENU = 'Attributes', FRA = 'Attributs';
            ToolTipML = ENU = 'View or edit the item''s attributes, such as color, size, or other characteristics that help to describe the item.', FRA = 'Affichez ou modifiez les attributs de l''article, tels que la couleur, la taille ou d''autres caractéristiques permettant de le décrire.';

            //Unsupported feature: Change Visible on "Attributes(Action 199)". Please convert manually.

        }
        modify(AdjustInventory)
        {
            CaptionML = ENU = 'Adjust Inventory', FRA = 'Ajuster stock';
            ToolTipML = ENU = 'Increase or decrease the item''s inventory quantity manually by entering a new quantity. Adjusting the inventory quantity manually may be relevant after a physical count or if you do not record purchased quantities.', FRA = 'Vous pouvez augmenter ou diminuer manuellement la quantité en stock d''un article en entrant une nouvelle quantité. Il peut s''avérer utile d''ajuster manuellement la quantité d''inventaire après un décompte physique ou si vous n''enregistrez pas les quantités achetées.';
        }
        modify("Va&riants")
        {
            CaptionML = ENU = 'Va&riants', FRA = '&Variantes';
        }
        modify(Identifiers)
        {
            CaptionML = ENU = 'Identifiers', FRA = 'Identifiants';
        }
        modify(PricesandDiscounts)
        {
            CaptionML = ENU = 'Special Prices & Discounts', FRA = 'Prix et remises spéciaux';
        }
        /*   modify("Set Special Prices")
          {
              CaptionML = ENU = 'Set Special Prices', FRA = 'Définir les prix spéciaux';
              ToolTipML = ENU = 'Set up different prices for the item. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', FRA = 'Configurez des prix différents pour l''article. Un prix article est automatiquement affecté sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin.';
          }
          modify("Set Special Discounts")
          {
              CaptionML = ENU = 'Set Special Discounts', FRA = 'Définir les remises spéciales';
              ToolTipML = ENU = 'Set up different discounts for the item. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', FRA = 'Configurez des remises différentes pour l''article. Une remise article est automatiquement affectée sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin.';
          }
          modify(PricesDiscountsOverview)
          {
              CaptionML = ENU = 'Special Prices & Discounts Overview', FRA = 'Aperçu des prix et remises spéciaux';
              ToolTipML = ENU = 'View the special prices and line discounts that you grant for this item when certain criteria are met, such as customer, quantity, or ending date.', FRA = 'Affichez les prix spéciaux et les remises ligne que vous accordez pour cet article lorsque des critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin.';
          } */ // BCUPG Action 'Set Special Prices' is marked for removal. Reason: Replaced by the new implementation (V16) of price calculation.. Tag: 17.0.
        modify(Approval)
        {
            CaptionML = ENU = 'Approval', FRA = 'Approbation';
        }
        modify(Approve)
        {
            CaptionML = ENU = 'Approve', FRA = 'Approuver';
            ToolTipML = ENU = 'Approve the requested changes.', FRA = 'Approuvez les modifications requises.';
        }
        modify(Reject)
        {
            CaptionML = ENU = 'Reject', FRA = 'Rejeter';
            ToolTipML = ENU = 'Reject the approval request.', FRA = 'Rejetez la demande d''approbation.';
        }
        modify(Delegate)
        {
            CaptionML = ENU = 'Delegate', FRA = 'Déléguer';
            ToolTipML = ENU = 'Delegate the approval to a substitute approver.', FRA = 'Déléguez l''approbation à un approbateur remplaçant.';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comments', FRA = 'Commentaires';
            ToolTipML = ENU = 'View or add comments.', FRA = 'Affichez ou ajoutez des commentaires.';
        }
        //BC Upgrade KAMNAY01>> The action '"Request Approval"' is not found in the target 'Item Card'
        // modify("Request Approval")
        // {
        //     CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
        // }
        //BC Upgrade KAMNAY01<< The action '"Request Approval"' is not found in the target 'Item Card'
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';
            ToolTipML = ENU = 'Send an approval request.', FRA = 'Envoyez une demande d''approbation.';
        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest', FRA = 'Annuler demande d''appro&bation';
            ToolTipML = ENU = 'Cancel the approval request.', FRA = 'Annulez la demande d''approbation.';
        }
        modify(Workflow)
        {
            CaptionML = ENU = 'Workflow', FRA = 'Flux de travail';
        }
        modify(CreateApprovalWorkflow)
        {
            CaptionML = ENU = 'Create Approval Workflow', FRA = 'Créer flux de travail approbation';
            ToolTipML = ENU = 'Set up an approval workflow for creating or changing items, by going through a few pages that will guide you.', FRA = 'Configurez un flux de travail approbation pour créer ou modifier des articles, en consultant quelques pages qui vous guideront.';
        }
        modify(ManageApprovalWorkflow)
        {
            CaptionML = ENU = 'Manage Approval Workflow', FRA = 'Gérer le flux de travail approbation';
            ToolTipML = ENU = 'View or edit existing approval workflows for creating or changing items.', FRA = 'Affichez ou modifiez des flux de travail approbation existants pour créer ou modifier des articles.';
        }
        //BC Upgrade KAMNAY01>> The action 'Functions' is not found in the target 'Item Card'
        // modify("F&unctions")
        // {
        //     CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        // }
        //BC Upgrade KAMNAY01<< The action 'Functions' is not found in the target 'Item Card'
        modify("&Create Stockkeeping Unit")
        {
            CaptionML = ENU = '&Create Stockkeeping Unit', FRA = '&Créer point de stock';
        }
        modify(CalculateCountingPeriod)
        {
            CaptionML = ENU = 'C&alculate Counting Period', FRA = 'C&alculer période d''inventaire';
        }
        modify(Templates)
        {
            CaptionML = ENU = 'Templates', FRA = 'Modèles';
            ToolTipML = ENU = 'View or edit item templates.', FRA = 'Affichez ou modifiez des modèles article.';
        }
        modify(ApplyTemplate)
        {
            CaptionML = ENU = 'Apply Template', FRA = 'Appliquer modèle';
            ToolTipML = ENU = 'Use a template to quickly create a new item card.', FRA = 'Utilisez un modèle pour créer rapidement une fiche article.';
        }
        modify(SaveAsTemplate)
        {
            CaptionML = ENU = 'Save as Template', FRA = 'Sauvegarder comme modèle';
            ToolTipML = ENU = 'Save the item card as a template that can be reused to create new item cards. Item templates contain preset information to help you fill in fields on item cards.', FRA = 'Enregistrez la fiche article comme modèle que vous pourrez réutiliser pour créer de nouvelles fiches article. Les modèles article contiennent des informations prédéfinies pour vous aider à compléter les fiches article.';
        }
        modify("Requisition Worksheet")
        {

            //Unsupported feature: Change Level on ""Requisition Worksheet"(Action 1905370404)". Please convert manually.

            CaptionML = ENU = 'Requisition Worksheet', FRA = 'Demande achat';
        }
        modify("Item Journal")
        {

            //Unsupported feature: Change Level on ""Item Journal"(Action 1904344904)". Please convert manually.

            CaptionML = ENU = 'Item Journal', FRA = 'Feuille article';
        }
        modify("Item Reclassification Journal")
        {

            //Unsupported feature: Change Level on ""Item Reclassification Journal"(Action 1906716204)". Please convert manually.

            CaptionML = ENU = 'Item Reclassification Journal', FRA = 'Feuille reclassement article';
        }
        modify("Item Tracing")
        {

            //Unsupported feature: Change Level on ""Item Tracing"(Action 1902532604)". Please convert manually.

            CaptionML = ENU = 'Item Tracing', FRA = 'Traçabilité';
        }
        modify(History)
        {
            CaptionML = ENU = 'History', FRA = 'Historique';
        }
        //BC Upgrade Kamnay01>>Cannot move or modify the Group 'E&ntries'&"Ledger E&ntries" in the same 'PageExtension' that you added. This warning will become an error in a future release.
        // modify("E&ntries")
        // {
        //     CaptionML = ENU = 'E&ntries', FRA = 'É&critures';

        //     //Unsupported feature: Change Name on ""E&ntries"(Action 101)". Please convert manually.

        // }
        // modify("Ledger E&ntries")
        // {
        //     CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
        //     ToolTipML = ENU = 'View the history of transactions that have been posted for the selected record.', FRA = 'Affichez l''historique des transactions qui ont été validées pour l''enregistrement sélectionné.';

        //     //Unsupported feature: Change Name on ""Ledger E&ntries"(Action 105)". Please convert manually.

        // }
        //BC Upgrade Kamnay01<<Cannot move or modify the Group 'E&ntries'&"Ledger E&ntries" in the same 'PageExtension' that you added. This warning will become an error in a future release.
        modify("&Phys. Inventory Ledger Entries")
        {
            CaptionML = ENU = '&Phys. Inventory Ledger Entries', FRA = 'Écritures comptables &inventaire';
            ToolTipML = ENU = 'View how many units of the item you had in stock at the last physical count.', FRA = 'Affichez le nombre d''unités de l''article que vous aviez en stock au dernier comptage physique.';
        }
        ////BC Upgrade Kamnay01>>

        // modify("&Reservation Entries")   '&Reservation Entries' is an ambiguous reference between '&Reservation Entries' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and '&Reservation Entries' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.ALAL0275
        // {
        //     CaptionML = ENU = '&Reservation Entries', FRA = 'Écritures &réservation';

        //     //Unsupported feature: Change Name on ""&Reservation Entries"(Action 75)". Please convert manually.

        // }

        // modify("&Value Entries")     
        // {
        //     CaptionML = ENU = '&Value Entries', FRA = 'Écritures &valeur';

        //     //Unsupported feature: Change Name on ""&Value Entries"(Action 5800)". Please convert manually.

        // }


        // modify("Item &Tracking Entries") //'Item &Tracking Entries' is an ambiguous reference between 'Item &Tracking Entries' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Item &Tracking Entries' defined by the extension 'BCIBM by Default Publisher 
        // {
        //     CaptionML = ENU = 'Item &Tracking Entries', FRA = 'Ecritures &traçabilité';

        //     //Unsupported feature: Change Name on ""Item &Tracking Entries"(Action 6500)". Please convert manually.

        // }
        //BC Upgrade Kamnay01<<
        modify("&Warehouse Entries")
        {
            CaptionML = ENU = '&Warehouse Entries', FRA = 'É&critures entrepôt';
        }
        //BC Upgrade KAMNAY01>>  'Application Worksheet' is an ambiguous reference between 'Application Worksheet' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Application Worksheet' defined by the extension 'BCIBM by Default Publisher 
        // modify("Application Worksheet")
        // {
        //     CaptionML = ENU = 'Application Worksheet', FRA = 'Feuille lettrage';

        //     //Unsupported feature: Change Name on ""Application Worksheet"(Action 237)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<<  'Application Worksheet' is an ambiguous reference between 'Application Worksheet' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Application Worksheet' defined by the extension 'BCIBM by Default Publisher
        //BC Upgrade KAMNAY01>> The action ActionGroup190 is not found in the target 'Item Card'
        // modify(ActionGroup190)
        // {
        //     CaptionML = ENU = 'Item', FRA = 'Article';
        // }
        //BC Upgrade KAMNAY01<< The action ActionGroup190 is not found in the target 'Item Card'

        //BC Upgrade KAMNAY01>> 'Dimensions' is an ambiguous reference between 'Dimensions' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Dimensions' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.ALAL0275
        // modify(Dimensions)
        // {
        //     CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
        //     ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

        //     //Unsupported feature: Change Name on "Dimensions(Action 184)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<< 'Dimensions' is an ambiguous reference between 'Dimensions' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Dimensions' defined by the extension 'BCIBM by Default Publisher (

        //BC Upgrade KAMNAY01>> The action "Cross Re&ferences" is not found in the target 'Item Card'
        // modify("Cross Re&ferences")
        // {
        //     CaptionML = ENU = 'Cross Re&ferences', FRA = '&Références externes';
        //     ToolTipML = ENU = 'Set up a customer''s or vendor''s own identification of the item. Cross-references to the customer''s item number means that the item number is automatically shown on sales documents instead of the number that you use.', FRA = 'Configurez la manière dont un client ou un fournisseur identifie l''article. Les références externes au numéro d''article du client impliquent que le numéro d''article est automatiquement affiché sur les documents vente au lieu du numéro que vous utilisez.';
        // }
        //BC Upgrade KAMNAY01<< The action "Cross Re&ferences" is not found in the target 'Item Card'

        //BC Upgrade KAMNAY01>>
        // modify("&Units of Measure")  '&Units of Measure' is an ambiguous reference between '&Units of Measure' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and '&Units of Measure' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.ALAL0275
        // {
        //     CaptionML = ENU = '&Units of Measure', FRA = '&Unités';
        //     ToolTipML = ENU = 'Set up the different units that the item can be traded in, such as piece, box, or hour.', FRA = 'Configurez les différentes unités dans lesquelles l''article peut être négocié, par exemple pièce, boîte ou heure.';

        //     //Unsupported feature: Change Name on ""&Units of Measure"(Action 114)". Please convert manually.

        // }
        // modify("E&xtended Texts")  'E&xtended Texts' is an ambiguous reference between 'E&xtended Texts' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'E&xtended Texts' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'
        // {
        //     CaptionML = ENU = 'E&xtended Texts', FRA = 'Te&xtes étendus';
        //     ToolTipML = ENU = 'Set up additional text for the description of the item. Extended text can be inserted under the Description field on document lines for the item.', FRA = 'Définissez un texte supplémentaire pour la description de l''article. Un texte plus long peut être inséré sous le champ Description sur les lignes document de l''article.';

        //     //Unsupported feature: Change Name on ""E&xtended Texts"(Action 117)". Please convert manually.

        // }
        // modify(Translations) 'Translations' is an ambiguous reference between 'Translations' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Translations' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.ALAL0275
        // {
        //     CaptionML = ENU = 'Translations', FRA = 'Traductions';
        //     ToolTipML = ENU = 'View or edit translated item descriptions. Translated item descriptions are automatically inserted on documents according to the language code.', FRA = 'Affichez ou modifiez des descriptions d''article traduites. Les descriptions d''articles traduites sont automatiquement insérées dans les documents en fonction du code de langue.';

        //     //Unsupported feature: Change Name on "Translations(Action 116)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<<
        modify("Substituti&ons")
        {
            CaptionML = ENU = 'Substituti&ons', FRA = 'Articles de su&bstitution';
        }
        modify(ApprovalEntries)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify(ActionGroupCRM)
        {
            CaptionML = ENU = 'Dynamics CRM', FRA = 'Dynamics CRM';
        }
        modify(CRMGoToProduct)
        {
            CaptionML = ENU = 'Product', FRA = 'Produit';
            ToolTipML = ENU = 'Open the coupled Microsoft Dynamics CRM product.', FRA = 'Ouvrez le produit Microsoft Dynamics CRM couplé.';
        }
        modify(CRMSynchronizeNow)
        {
            CaptionML = ENU = 'Synchronize Now', FRA = 'Synchroniser maintenant';
            ToolTipML = ENU = 'Send updated data to Microsoft Dynamics CRM.', FRA = 'Envoyez des données mises à jour à Microsoft Dynamics CRM.';
        }
        //BC Upgrade KAMNAY01>> 
        // modify(Coupling)
        // {
        //     CaptionML = @@@='Coupling is a noun',ENU = 'Coupling', FRA = 'Couplage';
        //     ToolTipML = ENU = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.', FRA = 'Créez, modifiez ou supprimez un couplage entre l''enregistrement Microsoft Dynamics NAV et un enregistrement Microsoft Dynamics CRM.';
        // }
        //BC Upgrade KAMNAY01<<
        modify(ManageCRMCoupling)
        {
            CaptionML = ENU = 'Set Up Coupling', FRA = 'Configurer le couplage';
            ToolTipML = ENU = 'Create or modify the coupling to a Microsoft Dynamics CRM product.', FRA = 'Créez ou modifiez le couplage avec un produit Microsoft Dynamics CRM.';
        }
        modify(DeleteCRMCoupling)
        {
            CaptionML = ENU = 'Delete Coupling', FRA = 'Supprimer le couplage';
            ToolTipML = ENU = 'Delete the coupling to a Microsoft Dynamics CRM product.', FRA = 'Supprimez le couplage avec un produit Microsoft Dynamics CRM.';
        }
        modify(Availability)
        {
            CaptionML = ENU = 'Availability', FRA = 'Disponibilité';
        }
        modify(ItemsByLocation)
        {
            CaptionML = ENU = 'Items b&y Location', FRA = 'Articles &par magasin';
            ToolTipML = ENU = 'Show a list of items grouped by location.', FRA = 'Affichez la liste des articles regroupés par emplacement.';
        }
        //BC Upgrade KAMNAY01>> The action 'Item Availability by' is not found in the target 'Item Card'
        // modify("&Item Availability by")
        // {
        //     CaptionML = ENU = '&Item Availability by', FRA = '&Disponibilité article par';
        // }
        //BC Upgrade KAMNAY01<< The action 'Item Availability by' is not found in the target 'Item Card'
        modify("<Action110>")
        {
            CaptionML = ENU = 'Event', FRA = 'Événement';
            ToolTipML = ENU = 'View how the actual and projected inventory level of an item will develop over time according to supply and demand events.', FRA = 'Affichez le développement du niveau de stock réel et prévisionnel d''un article dans le temps en fonction des événements de l''offre et de la demande.';
        }
        //BC Upgrade KAMNAY01>> 
        // modify(Period) 'Period' is an ambiguous reference between 'Period' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Period' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.ALAL0275
        // {
        //     CaptionML = ENU = 'Period', FRA = 'Période';
        //     ToolTipML = ENU = 'Show the actual and projected quantity of an item over time according to a specified time interval, such as by day, week or month.', FRA = 'Affiche la quantité réelle et prévisionnelle d''un article dans le temps en fonction d''un intervalle de temps donné, par exemple par jour, par semaine ou par mois.';

        //     //Unsupported feature: Change Name on "Period(Action 110)". Please convert manually.

        // }
        // modify(Variant)  'Variant' is an ambiguous reference between 'Variant' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Variant' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.ALAL0275
        // {
        //     CaptionML = ENU = 'Variant', FRA = 'Variante';
        //     ToolTipML = ENU = 'View how the inventory level of an item will develop over time according to the variant that you select.', FRA = 'Affichez le développement du niveau de stock d''un article dans le temps en fonction de la variante que vous sélectionnez.';

        //     //Unsupported feature: Change Name on "Variant(Action 77)". Please convert manually.

        // }
        // modify(Location) 'Location' is an ambiguous reference between 'Location' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Location' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.ALAL0275
        // {
        //     CaptionML = ENU = 'Location', FRA = 'Magasin';

        //     //Unsupported feature: Change Name on "Location(Action 69)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<<
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
            ToolTipML = ENU = 'View availability figures for BOM items that indicate how many units of a parent you can make based on the availability of child items on underlying lines.', FRA = 'Affichez les chiffres de disponibilité pour les articles nomenclature qui indiquent combien d''unités d''un parent vous pouvez effectuer sur la base de la disponibilité des éléments enfant sur les lignes sous-jacentes.';
        }
        //BC Upgrade Kamnay01>> The action 'Timeline' & ActionGroup102 is not found in the target 'Item Card'
        // modify(Timeline)
        // {
        //     CaptionML = ENU = 'Timeline', FRA = 'Chronologie';
        //     ToolTipML = ENU = 'View a graphical view of an item''s projected inventory based on future supply and demand events, with or without planning suggestions.', FRA = 'Affichez une vue graphique du stock prévisionnel d''un article en fonction des prochains événements d''offre et de demande, avec ou sans propositions de planning.';
        // }
        // modify(ActionGroup102)
        // {
        //     CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        // }
        //BC Upgrade Kamnay01<< The action 'Timeline' & ActionGroup102 is not found in the target 'Item Card'
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
            ToolTipML = ENU = 'View statistical information, such as the value of posted entries, for the record.', FRA = 'Affichez les informations statistiques telles que la valeur des écritures validées pour l''enregistrement.';
        }
        //BC Upgrade KAMNAY01>>
        // modify("Entry Statistics")  'Entry Statistics' is an ambiguous reference between 'Entry Statistics' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Entry Statistics' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)
        // {
        //     CaptionML = ENU = 'Entry Statistics', FRA = 'Statistiques écritures';
        //     ToolTipML = ENU = 'View statistics for item ledger entries.', FRA = 'Affichez les statistiques des écritures comptables article.';

        //     //Unsupported feature: Change Name on ""Entry Statistics"(Action 108)". Please convert manually.

        // }
        // modify("T&urnover") //'T&urnover' is an ambiguous reference between 'T&urnover' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'T&urnover' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.
        // {
        //     CaptionML = ENU = 'T&urnover', FRA = '&Rotation';
        //     ToolTipML = ENU = 'View a detailed account of item turnover by periods after you have set the relevant filters for location and variant.', FRA = 'Affichez le compte détaillé de la rotation article par période après avoir défini les filtres magasin et variante appropriés.';

        //     //Unsupported feature: Change Name on ""T&urnover"(Action 111)". Please convert manually.

        // }
        // modify("Co&mments")//'Co&mments' is an ambiguous reference between 'Co&mments' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Co&mments' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.ALAL0275
        // {
        //     CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        //     ToolTipML = ENU = 'View or add comments.', FRA = 'Affichez ou ajoutez des commentaires.';

        //     //Unsupported feature: Change Name on ""Co&mments"(Action 106)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<<
        //BC Upgrade KAMNAY01>> The action 'Purchases' is not found in the target 'Item Card'
        // modify("&Purchases")
        // {
        //     CaptionML = ENU = '&Purchases', FRA = 'Ac&hats';
        // }
        //BC Upgrade KAMNAY01<< The action 'Purchases' is not found in the target 'Item Card'
        modify("Ven&dors")
        {
            CaptionML = ENU = 'Ven&dors', FRA = '&Fournisseurs';
        }
        /*  modify(Action85)
         {
             CaptionML = ENU = 'Set Special Prices', FRA = 'Définir les prix spéciaux';
         }
         modify(Action86)
         {
             CaptionML = ENU = 'Set Special Discounts', FRA = 'Définir les remises spéciales';
         } */
        modify("Prepa&yment Percentages")
        {
            CaptionML = ENU = 'Prepa&yment Percentages', FRA = 'Pourcentages acom&pte';
        }
        modify(Orders)
        {
            CaptionML = ENU = 'Orders', FRA = 'Commandes';
        }
        modify("Return Orders")
        {
            CaptionML = ENU = 'Return Orders', FRA = 'Retours';
        }
        //BC Upgrade KAMNAY01>> The action 'Nonstock Items'  and S&ales not found in the target 'Item Card'
        // modify("Nonstoc&k Items")
        // {
        //     CaptionML = ENU = 'Nonstoc&k Items', FRA = 'Articles &non stockés';
        // }
        // modify("S&ales")
        // {
        //     CaptionML = ENU = 'S&ales', FRA = '&Ventes';
        // }
        //BC Upgrade KAMNAY01<< The action 'Nonstock Items'  and S&ales not found in the target 'Item Card'
        modify(Action300)
        {
            CaptionML = ENU = 'Prepa&yment Percentages', FRA = 'Pourcentages acom&pte';
        }
        modify(Action83)
        {
            CaptionML = ENU = 'Orders', FRA = 'Commandes';
        }
        modify(Action163)
        {
            CaptionML = ENU = 'Return Orders', FRA = 'Retours';
        }
        //BC Upgrade KAMNAY01>>The action "Assembly/Production'  and Structure not found in the target 'Item Card'
        // modify("Assembly/Production")
        // {
        //     CaptionML = ENU = 'Assembly/Production', FRA = 'Assemblage/Production';
        // }
        // modify(Structure)
        // {
        //     CaptionML = ENU = 'Structure', FRA = 'Structure';
        // }
        //BC Upgrade KAMNAY01<<The action "Assembly/Production'  and Structure not found in the target 'Item Card'
        modify("Cost Shares")
        {
            CaptionML = ENU = 'Cost Shares', FRA = 'Coûts totaux';
        }
        //BC Upgrade KAMNAY01>>The action Assemb&ly not found in the target 'Item Card'
        // modify("Assemb&ly")
        // {
        //     CaptionML = ENU = 'Assemb&ly', FRA = 'Assemb&lage';
        // }
        //BC Upgrade KAMNAY01<<The action Assemb&ly not found in the target 'Item Card'
        modify("Assembly BOM")
        {
            CaptionML = ENU = 'Assembly BOM', FRA = 'Nomenclature d''assemblage';
        }
        //BC Upgrade KAMNAY01>>
        // modify("Where-Used") //'Where-Used' is an ambiguous reference between 'Where-Used' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Where-Used' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'
        // {
        //     CaptionML = ENU = 'Where-Used', FRA = 'Cas d''emploi';

        //     //Unsupported feature: Change Name on ""Where-Used"(Action 96)". Please convert manually.

        // }
        // modify("Calc. Stan&dard Cost")//'Calc. Stan&dard Cost' is an ambiguous reference between 'Calc. Stan&dard Cost' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)' and 'Calc. Stan&dard Cost' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)'.ALAL0275
        // {
        //     CaptionML = ENU = 'Calc. Stan&dard Cost ( Excluding SKU )', FRA = 'Calculer coût stan&dard';

        //     //Unsupported feature: Change Name on ""Calc. Stan&dard Cost"(Action 94)". Please convert manually.


        //     //Unsupported feature: Change Description on ""Calc. Stan&dard Cost"(Action 94)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<<
        modify("Calc. Unit Price")
        {
            CaptionML = ENU = 'Calc. Unit Price', FRA = 'Calculer prix unitaire';
        }
        modify(Production)
        {
            CaptionML = ENU = 'Production', FRA = 'Fabrication';
        }
        modify("Production BOM")
        {
            CaptionML = ENU = 'Production BOM', FRA = 'Nomenclature de production';
        }
        modify(Action78)
        {
            CaptionML = ENU = 'Where-Used', FRA = 'Cas d''emploi';
        }
        modify(Action5)
        {
            CaptionML = ENU = 'Calc. Stan&dard Cost ( Excluding SKU )', FRA = 'Calculer coût stan&dard';

            //Unsupported feature: Change Description on "Action5(Action 5)". Please convert manually.

        }
        //BC Upgrade KAMNAY01>> The action 'Warehouse' is not found in the target 'Item Card'
        // modify(Warehouse)
        // {
        //     CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        // }
        //BC Upgrade KAMNAY01<< The action 'Warehouse' is not found in the target 'Item Card'
        // modify("&Bin Contents") //'&Bin Contents' is an ambiguous reference between '&Bin Contents' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and '&Bin Contents' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.
        // {
        //     CaptionML = ENU = '&Bin Contents', FRA = 'C&ontenu emplacement';

        //     //Unsupported feature: Change Name on ""&Bin Contents"(Action 212)". Please convert manually.

        // }
        modify("Stockkeepin&g Units")
        {
            CaptionML = ENU = 'Stockkeepin&g Units', FRA = 'Point de stoc&k';
        }
        modify(Service)
        {
            CaptionML = ENU = 'Service', FRA = 'Service';
        }
        modify("Ser&vice Items")
        {

            //Unsupported feature: Change Level on ""Ser&vice Items"(Action 183)". Please convert manually.

            CaptionML = ENU = 'Ser&vice Items', FRA = '&Articles de service';
        }
        //BC Upgrade KAMNAY01>> 'Troubleshooting' is an ambiguous reference between 'Troubleshooting' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)' and 'Troubleshooting' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
        // modify(Troubleshooting)
        // {

        //     //Unsupported feature: Change Level on "Troubleshooting(Action 17)". Please convert manually.

        //     CaptionML = ENU = 'Troubleshooting', FRA = 'Incident';

        //     //Unsupported feature: Change Name on "Troubleshooting(Action 17)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<< 'Troubleshooting' is an ambiguous reference between 'Troubleshooting' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)' and 'Troubleshooting' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)'.

        modify("Troubleshooting Setup")
        {

            //Unsupported feature: Change Level on ""Troubleshooting Setup"(Action 185)". Please convert manually.

            CaptionML = ENU = 'Troubleshooting Setup', FRA = 'Paramètres incidents';
        }
        modify(Resources)
        {
            CaptionML = ENU = 'Resources', FRA = 'Ressources';

            //Unsupported feature: Change Description on "Resources(Action 127)". Please convert manually.


            //Unsupported feature: Change Visible on "Resources(Action 127)". Please convert manually.

        }
        //BC Upgrade KAMNAY01>> Cannot use 'R&esource' in Page 'Item Card' before it is declared.
        // modify("R&esource")
        // {
        //     CaptionML = ENU = 'R&esource', FRA = 'Re&ssource';

        //     //Unsupported feature: Change Name on ""R&esource"(Action 151)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<< Cannot use 'Resource' in Page 'Item Card' before it is declared.
        //BC Upgrade KAMNAY01>>
        // modify("Resource Skills") // 'Resource Skills' is an ambiguous reference between 'Resource Skills' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)' and 'Resource Skills' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
        // {
        //     CaptionML = ENU = 'Resource Skills', FRA = 'Compétences ressource';
        //     ToolTipML = ENU = 'View the assignment of skills to resources, items, service item groups, and service items. You can use skill codes to allocate skilled resources to service items or items that need special skills for servicing.', FRA = 'Affichez l''affectation des compétences aux ressources, aux articles, aux groupes articles de service et aux articles de service. Vous pouvez utiliser les codes compétence pour affecter des ressources compétentes aux articles de service ou aux articles nécessitant des compétences spéciales pour la maintenance.';

        //     //Unsupported feature: Change Name on ""Resource Skills"(Action 187)". Please convert manually.

        // }
        // modify("Skilled Resources") // 'Resource Skills' is an ambiguous reference between 'Resource Skills' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)' and 'Resource Skills' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
        // {
        //     CaptionML = ENU = 'Skilled Resources', FRA = 'Ressources compétentes';
        //     ToolTipML = ENU = 'View a list of all registered resources with information about whether they have the skills required to service the particular service item group, item, or service item.', FRA = 'Affichez la liste de toutes les ressources enregistrées. Cette fenêtre indique si ces dernières possèdent les compétences nécessaires pour effectuer des opérations de service sur le groupe articles de service, l''article ou l''article de service particulier.';

        //     //Unsupported feature: Change Name on ""Skilled Resources"(Action 188)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<<
        addafter(Identifiers)
        {
            //BC Upgrade KAMNAY01>> DITW Action
            // action(Properties)
            // {
            //     CaptionML = ENU = 'Properties',
            //                 FRA = 'Propriétés';
            //     Description = 'FINXL9.00';
            //     Image = Category;
            //     RunObject = Page "Master Data Properties";
            //     RunPageLink = "Table ID" = CONST(27),
            //                   Code = FIELD("No.");
            // }
            //BC Upgrade KAMNAY01<< DITW Action
            separator(Separator2036008)
            {
            }
            // //BC Upgrade KAMNAY01>> DITW Action
            // group("Relation Groups")
            // {
            //     CaptionML = ENU = 'Relation Groups',
            //                 FRA = 'Groupes de relations';
            //     Image = Relationship;

            //     action("Tax Groups")
            //     {
            //         CaptionML = ENU = 'Tax Groups',
            //                     FRA = 'Groupes taxes';
            //         Image = Relationship;
            //         RunObject = Page "Drink Item Tax Groups";
            //         RunPageLink = "Source Type" = CONST(Item);
            //         RunPageView = where("Source Type" = CONST(Item));
            //     }

            //     action("Exception Tax Groups")
            //     {
            //         CaptionML = ENU = 'Exception Tax Groups',
            //                     FRA = 'Groupes taxe excéption';
            //         Image = Relationship;
            //         RunObject = Page "Customer Exception Tax Groups";
            //     }
            //     action("Deposit Groups")
            //     {
            //         CaptionML = ENU = 'Deposit Groups',
            //                     FRA = 'Groupes consignes';
            //         Image = Relationship;
            //         RunObject = Page "Drink Deposit Groups";
            //         RunPageLink = "Source Type" = CONST(Item);
            //         RunPageView = where("Source Type" = CONST(Item));
            //     }
            //     action("Di&scount Groups (Drink-It)")
            //     {
            //         CaptionML = ENU = 'Di&scount Groups (Drink-It)',
            //                     FRA = 'Groupes remise (Drink-IT)';
            //         Image = Relationship;
            //         RunObject = Page "Relation Drink Discount Groups";
            //         RunPageLink = "Source Type" = CONST(Item),
            //                       "Source No." = FIELD("No.");
            //     }
            //     action("Promotion G&roups")
            //     {
            //         CaptionML = ENU = 'Promotion G&roups',
            //                     FRA = 'Groupes &Promotion';
            //         Image = Relationship;
            //         RunObject = Page "Relation Promotion Groups";
            //         RunPageLink = "Source Type" = CONST(Item),
            //                       "Source No." = FIELD("No.");
            //     }
            //     action("&Exclusivity Groups")
            //     {
            //         CaptionML = ENU = '&Exclusivity Groups',
            //                     FRA = 'Groupes &Exculisivité';
            //         Image = Relationship;
            //         RunObject = Page "Relation Exclusivity Groups";
            //         RunPageLink = "Source Type" = CONST(Item),
            //                       "Source No." = FIELD("No.");
            //     }
            //     action("Loyalty Groups")
            //     {
            //         CaptionML = ENU = 'Loyalty Groups',
            //                     FRA = 'Groupes Fidélité';
            //         Description = 'DIT715 #243';
            //         Image = Relationship;
            //         RunObject = Page "Relation Loyalty Groups";
            //         RunPageLink = "Source Type" = CONST(Item),
            //                       "Source No." = FIELD("No.");
            //     }
            //     action("&Quota Groups")
            //     {
            //         CaptionML = ENU = '&Quota Groups',
            //                     FRA = 'Groupes &Devis';
            //         Image = Relationship;
            //         RunObject = Page "Relation Quota Groups";
            //         RunPageLink = "Source Type" = CONST(Item),
            //                       "Source No." = FIELD("No.");
            //     }
            // }

            // group("Tax Charges")
            // {
            //     CaptionML = ENU = 'Tax Charges',
            //                 FRA = 'Taxes d''impôt';
            //     Image = TaxSetup;
            //     action("Specifications - Tariffs")
            //     {
            //         CaptionML = ENU = 'Specifications - Tariffs',
            //                     FRA = 'Spécification - Tarifs';
            //         Image = TaxSetup;
            //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //         //PromotedCategory = Process;
            //         RunObject = Page "Default Tax Specifications";
            //         RunPageLink = "Parent Item No." = FIELD("No.");
            //     }
            //     action("Internal Tax Charges")
            //     {
            //         CaptionML = ENU = 'Internal Tax Charges',
            //                     FRA = 'Taxes d''impôt internes';
            //         Image = TaxSetup;
            //         RunObject = Page "Internal Tax Item Charges";
            //         RunPageLink = "Source Type" = CONST(Item),
            //                       "Source No." = FIELD("No.");
            //     }
            // }

            // group(Quality)
            // {
            //     CaptionML = ENU = 'Quality',
            //                 FRA = 'Qualité';
            //     Description = 'QXL9.00.001';
            //     Image = TaskQualityMeasure;
            //     action("&Quality Standards")
            //     {
            //         CaptionML = ENU = '&Quality Standards',
            //                     FRA = '&Qaulité Standards';
            //         Description = 'QXL9.00.001';
            //         Image = TaskQualityMeasure;
            //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //         //PromotedCategory = Process;
            //         RunObject = Page "Quality Standard List";
            //         RunPageLink = "No." = FIELD("No.");
            //     }
            //     action("Quality Item Test History")
            //     {
            //         CaptionML = ENU = 'Quality Item Test History',
            //                     FRA = 'Historique des testes qualité article';
            //         Description = 'QXL9.00.001';
            //         Image = History;

            //         trigger OnAction();
            //         var
            //             ItemTestHistory: Page "Item Test History";
            //         begin
            //             ItemTestHistory.SETRECORD(Rec);
            //             ItemTestHistory.RUNMODAL;
            //         end;
            //     }
            //     action("Quality Standards")
            //     {
            //         CaptionML = ENU = 'Quality Standards',
            //                     FRA = 'Standards de qualité';
            //         Description = 'QXL9.00.001';
            //         Image = TaskQualityMeasure;
            //         RunObject = Page "Sales Standards";
            //         RunPageLink = "Item No." = FIELD("No.");
            //         RunPageView = sorting("Item No.", "Sales Type", "Sales Code", "Starting Date", "Variant Code", "Qlty. Measure Code");
            //     }
            // }
            //BC Upgrade KAMNAY01<< DITW Action
        }
        ////BC Upgrade KAMNAY01>> DITW Action
        // addafter("&Create Stockkeeping Unit")
        // {
        //     action("&Advanced Create Stockkeeping Unit")
        //     {
        //         AccessByPermission = TableData "Stockkeeping Unit" = R;
        //         CaptionML = ENU = '&Advanced Create Stockkeeping Unit',
        //                     FRA = 'Création &avancée point de stock';
        //         Image = CreateSKU;

        //         trigger OnAction();
        //         var
        //             Item: Record Item;
        //         begin
        //             //<<FINXL8.00.001 BSA 25/06/2015 #181
        //             Item.SETRANGE("No.", "No.");
        //             REPORT.RUNMODAL(REPORT::"Create SKU FINXL", true, false, Item);
        //             //>>FINXL8.00.001 BSA 25/06/2015 #181
        //         end;
        //     }
        // }
        ////BC Upgrade KAMNAY01<< DITW Action
        addafter(SaveAsTemplate)
        {
            separator(Separator2029611)
            {
            }
            ////BC Upgrade KAMNAY01>> DITW Action
            // action("Copy Item From Package")
            // {
            //     CaptionML = ENU = 'Copy Item From Package',
            //                 FRA = 'Copier article';
            //     Description = 'FINXL7.00';
            //     Image = CopyItem;
            //     Visible = false;

            //     trigger OnAction();
            //     var
            //         lpgeCopyItem: Page "Copy Item (NORRIQXL)";
            //     begin
            //         //<<FINXL7.00 RBE 17/04/2014
            //         lpgeCopyItem.fctSetParam("No.", '', '');
            //         lpgeCopyItem.RUNMODAL();
            //         //>>FINXL7.00 RBE 17/04/2014
            //     end;
            // }
            // action("Copy Item")
            // {
            //     CaptionML = ENU = 'Copy Item',
            //                 FRA = 'Copier article';
            //     Image = CopyItem;
            //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedCategory = Process;
            //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedIsBig = true;
            //     RunObject = Report "Copy Item (Norriq XL)";
            //     Visible = blnCopyItemVisible;

            //     trigger OnAction();
            //     var
            //         lrecItem: Record Item;
            //     begin
            //     end;
            // }
            // action("Create Item Wizard")
            // {
            //     CaptionML = ENU = 'Create Item Wizard',
            //                 FRA = 'Créer article avec assistant';
            //     Description = 'MANXL7.00.001';
            //     Image = AddAction;

            //     trigger OnAction();
            //     var
            //         lpgeItemCreateWizard: Page "Item Creation Wizard";
            //         lblnCreated: Boolean;
            //         lcodItemNo: Code[20];
            //     begin
            //         //<<MANXL7.00.001 DAT 03/03/2014 #12
            //         lpgeItemCreateWizard.fctSetParameters("No.", "No. Series");
            //         lpgeItemCreateWizard.RUNMODAL();
            //         lpgeItemCreateWizard.fctGetParameter(lcodItemNo, lblnCreated);
            //         if lblnCreated then
            //             GET(lcodItemNo);
            //         //>>MANXL7.00.001 DAT 03/03/2014 #12
            //     end;
            // }

            // separator(Separator1100083022)
            // {
            // }
            // action("SOM Synchronize")
            // {
            //     CaptionML = ENU = 'SOM Synchronize',
            //                 FRA = 'Synchroniser SOM';
            //     Image = Reconcile;

            //     trigger OnAction();
            //     var
            //         Item: Record Item;
            //     begin
            //         Item := Rec;
            //         Item.SETRECFILTER;
            //         Item.SomSynchronize();
            //     end;
            // }
            ////BC Upgrade KAMNAY01<< DITW Action
        }
        addfirst(navigation)
        {
            group(BTComponent)
            {
                CaptionML = ENU = '&Component',
                            FRA = '&Composant';
                Visible = BTComponentVisible;
                //   ////BC Upgrade KAMNAY01>> DITW Action
                // action(List)
                // {
                //     CaptionML = ENU = 'List',
                //                 FRA = 'Lister';
                //     Image = List;
                //     ShortCutKey = 'Shift+Ctrl+L';

                //     trigger OnAction();
                //     begin
                //         // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
                //         if PAGE.RUNMODAL(PAGE::"Item List PM", Rec) = ACTION::LookupOK then;
                //     end;
                // }
                ////BC Upgrade KAMNAY01<< DITW Action
                group("E&ntries")
                {
                    CaptionML = ENU = 'E&ntries',
                                FRA = 'É&critures';
                    Image = Entries;
                    //BC Upgrade KAMNAY01>> 'Ledger E&ntries',"&Reservation Entries",&Value Entries,"Item &Tracking Entries" is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft
                    // action("Ledger E&ntries")
                    // {
                    //     CaptionML = ENU = 'Ledger E&ntries',
                    //                 FRA = '&Ecritures comptables';
                    //     RunObject = Page "Item Ledger Entries";
                    //     RunPageLink = "Item No." = FIELD("No.");
                    //     RunPageView = sorting("Item No.");
                    //     ShortCutKey = 'Ctrl+F7';
                    // }
                    // action("&Reservation Entries")
                    // {
                    //     CaptionML = ENU = '&Reservation Entries',
                    //                 FRA = 'Écritures &réservation';
                    //     Image = ReservationLedger;
                    //     RunObject = Page "Reservation Entries";
                    //     RunPageLink = "Reservation Status" = CONST(Reservation),
                    //                   "Item No." = FIELD("No.");
                    //     RunPageView = sorting("Item No.", "Variant Code", "Location Code", "Reservation Status");
                    // }
                    // action("&Value Entries")
                    // {
                    //     CaptionML = ENU = '&Value Entries',
                    //                 FRA = 'Écritures &valeur';
                    //     Image = ValueLedger;
                    //     RunObject = Page "Value Entries";
                    //     RunPageLink = "Item No." = FIELD("No.");
                    //     RunPageView = sorting("Item No.");
                    // }
                    // action("Item &Tracking Entries")
                    // {
                    //     CaptionML = ENU = 'Item &Tracking Entries',
                    //                 FRA = '&Ecritures traçabilité';
                    //     Image = ItemTrackingLedger;

                    //     trigger OnAction();
                    //     var
                    //         ItemTrackingMgt: Codeunit "Item Tracking Management";
                    //     begin
                    //         ItemTrackingMgt.CallItemTrackingEntryForm(3, '', "No.", '', '', '', '');
                    //     end;
                    // }
                    //BC Upgrade KAMNAY01<< 'Ledger E&ntries',"&Reservation Entries",&Value Entries,"Item &Tracking Entries" is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft

                    //BC Upgrade KAMNAY01>> DITW Action
                    // action("SSCC Tracking Entries")
                    // {
                    //     CaptionML = ENU = 'SSCC Tracking Entries',
                    //                 FRA = 'Ecritures traçablité SSCC';
                    //     Image = ItemTrackingLedger;

                    //     trigger OnAction();
                    //     var
                    //         SSCCTrackingMgt: Codeunit "SSCC Tracking Management";
                    //     begin
                    //         // <<DITW15.00.00.38 DDR 19/11/2010 #1139
                    //         SSCCTrackingMgt.CallSSCCTrackingEntryForm(3, '', "No.", '', '', '', '', 0);
                    //     end;
                    // }
                    //BC Upgrade KAMNAY01<< DITW Action

                    //BC Upgrade KAMNAY01>> "Application Worksheet" is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft
                    // action("Application Worksheet")
                    // {
                    //     CaptionML = ENU = 'Application Worksheet',
                    //                 FRA = 'Feuille lettrage';
                    //     Image = ApplicationWorksheet;
                    //     RunObject = Page "Application Worksheet";
                    //     RunPageLink = "Item No." = FIELD("No.");
                    // }
                    //BC Upgrade KAMNAY01<< "Application Worksheet" is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft
                }
                group(ActionGroup1100076040)
                {
                    CaptionML = ENU = 'Statistics',
                                FRA = 'Statistiques';
                    Image = Statistics;
                    action("Component Statistics")
                    {
                        CaptionML = ENU = 'Component Statistics',
                                    FRA = 'Statistiques composant';
                        Image = Statistics;
                        Promoted = true;
                        PromotedCategory = Process;
                        ShortCutKey = 'F7';
                        ApplicationArea = All;
                        ToolTip = 'Executes the Component Statistics action.';

                        trigger OnAction();
                        var
                            ItemStatistics: Page "Item Statistics";
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RUNMODAL();
                        end;
                    }
                    //BC Upgrade KAMNAY01>> 'Entry Statistics' And "T&urnover"  is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                    // action("Entry Statistics")
                    // {
                    //     CaptionML = ENU = 'Entry Statistics',
                    //                 FRA = 'Statistiques écritures';
                    //     Image = EntryStatistics;
                    //     RunObject = Page "Item Entry Statistics";
                    //     RunPageLink = "No." = FIELD("No."),
                    //                   "Date Filter" = FIELD("Date Filter"),
                    //                   "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                    //                   "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                    //                   "Location Filter" = FIELD("Location Filter"),
                    //                   "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                    //                   "Variant Filter" = FIELD("Variant Filter");
                    // }
                    // action("T&urnover")
                    // {
                    //     CaptionML = ENU = 'T&urnover',
                    //                 FRA = '&Rotation';
                    //     Image = Turnover;
                    //     RunObject = Page "Item Turnover";
                    //     RunPageLink = "No." = FIELD("No."),
                    //                   "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                    //                   "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                    //                   "Location Filter" = FIELD("Location Filter"),
                    //                   "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                    //                   "Variant Filter" = FIELD("Variant Filter");
                    // }
                    //BC Upgrade KAMNAY01<< 'Entry Statistics' And "T&urnover"  is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                    action("Components b&y Location")
                    {
                        CaptionML = ENU = 'Components b&y Location',
                                    FRA = 'Composant par magasin';
                        Image = ItemAvailbyLoc;
                        ApplicationArea = All;
                        ToolTip = 'Executes the Components b&y Location action.';

                        trigger OnAction();
                        var
                            ItemsByLocation: Page "Items by Location";
                        begin
                            ItemsByLocation.SETRECORD(Rec);
                            ItemsByLocation.RUN();
                        end;
                    }
                    //BC Upgrade KAMNAY01>>DITW Actions
                    // action("Components by Period")
                    // {
                    //     CaptionML = ENU = 'Components by Period',
                    //                 FRA = 'Composant par période';
                    //     Description = 'DIT-715 #338';
                    //     Image = ItemAvailabilitybyPeriod;
                    //     RunObject = Page "Item Availability by Period3";
                    //     RunPageLink = "No." = FIELD("No."),
                    //                   "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                    //                   "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                    //                   "Location Filter" = FIELD("Location Filter"),
                    //                   "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                    //                   "Variant Filter" = FIELD("Variant Filter");
                    // }
                    //BC Upgrade KAMNAY01<<DITW Actions
                }
                group("&Component Availability by")
                {
                    CaptionML = ENU = '&Component Availability by',
                                FRA = '&Composant disponibilité par';
                    Image = ItemAvailability;
                    // //BC Upgrade KAMNAY01>> 'Period' , "Variant"  And Location  is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                    // action(Period)
                    // {
                    //     CaptionML = ENU = 'Period',
                    //                 FRA = 'Période';
                    //     Image = Period;
                    //     RunObject = Page "Item Availability by Periods";
                    //     RunPageLink = "No." = FIELD("No."),
                    //                   "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                    //                   "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                    //                   "Location Filter" = FIELD("Location Filter"),
                    //                   "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                    //                   "Variant Filter" = FIELD("Variant Filter");
                    // }
                    // action(Variant)
                    // {
                    //     CaptionML = ENU = 'Variant',
                    //                 FRA = 'Variante';
                    //     Image = ItemVariant;
                    //     RunObject = Page "Item Availability by Variant";
                    //     RunPageLink = "No." = FIELD("No."),
                    //                   "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                    //                   "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                    //                   "Location Filter" = FIELD("Location Filter"),
                    //                   "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                    //                   "Variant Filter" = FIELD("Variant Filter");
                    // }
                    // action(Location)
                    // {
                    //     CaptionML = ENU = 'Location',
                    //                 FRA = 'Magasin';
                    //     Image = Warehouse;
                    //     RunObject = Page "Item Availability by Location";
                    //     RunPageLink = "No." = FIELD("No."),
                    //                   "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                    //                   "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                    //                   "Location Filter" = FIELD("Location Filter"),
                    //                   "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                    //                   "Variant Filter" = FIELD("Variant Filter");
                    // }
                    // //BC Upgrade KAMNAY01<<'Period' , "Variant"  And Location  is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                    //BC Upgrade KAMNAY01>> DITW Action
                    // action("Period (Components)")
                    // {
                    //     CaptionML = ENU = 'Period (Components)',
                    //                 FRA = 'Période (Composant)';
                    //     Description = 'DIT-715 #338';
                    //     Image = Period;
                    //     RunObject = Page "Item Availability by Period2";
                    //     RunPageLink = "No." = FIELD("No."),
                    //                   "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                    //                   "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                    //                   "Location Filter" = FIELD("Location Filter"),
                    //                   "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                    //                   "Variant Filter" = FIELD("Variant Filter");
                    // }
                    //BC Upgrade KAMNAY01<< DITW Action
                }
                separator(Separator1100076053)
                {
                }
                //BC Upgrade KAMNAY01>> '&Bin Contents' , "Co&mments"  And Dimensions  is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                // action("&Bin Contents")
                // {
                //     CaptionML = ENU = '&Bin Contents',
                //                 FRA = 'C&ontenu emplacement';
                //     Image = BinContent;
                //     RunObject = Page "Item Bin Contents";
                //     RunPageLink = "Item No." = FIELD("No.");
                //     RunPageView = sorting("Item No.");
                // }
                // action("Co&mments")
                // {
                //     CaptionML = ENU = 'Co&mments',
                //                 FRA = 'Co&mmentaires';
                //     Image = ViewComments;
                //     RunObject = Page "Comment Sheet";
                //     RunPageLink = "Table Name" = CONST(Item),
                //                   "No." = FIELD("No.");
                // }
                // action(Dimensions)
                // {
                //     CaptionML = ENU = 'Dimensions',
                //                 FRA = 'Axes analytiques';
                //     Image = Dimensions;
                //     RunObject = Page "Default Dimensions";
                //     RunPageLink = "Table ID" = CONST(27),
                //                   "No." = FIELD("No.");
                //     ShortCutKey = 'Shift+Ctrl+D';
                // }
                //BC Upgrade KAMNAY01<< '&Bin Contents' , "Co&mments"  And Dimensions  is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                action("&Picture")
                {
                    CaptionML = ENU = '&Picture',
                                FRA = '&Image';
                    Image = Picture;
                    RunObject = Page "Item Picture";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Location Filter" = FIELD("Location Filter"),
                                  "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                  "Variant Filter" = FIELD("Variant Filter");
                    ApplicationArea = All;
                    ToolTip = 'Executes the &Picture action.';
                }
                separator(Separator1100076058)
                {
                }
                //BC Upgrade KAMNAY01>> '&Units of Measure' is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                // action("&Units of Measure")
                // {
                //     CaptionML = ENU = '&Units of Measure',
                //                 FRA = '&Unités';
                //     Image = UnitOfMeasure;
                //     RunObject = Page "Item Units of Measure";
                //     RunPageLink = "Item No." = FIELD("No.");
                // }
                //BC Upgrade KAMNAY01<< '&Units of Measure' is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                action(Action1100076060)
                {
                    CaptionML = ENU = 'Va&riants',
                                FRA = '&Variantes';
                    Image = ItemVariant;
                    RunObject = Page "Item Variants";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                    ToolTip = 'Executes the Action1100076060 action.';
                }
                separator(Separator1100076072)
                {
                }
                //BC Upgrade KAMNAY01>> 'Translations' And "E&xtended Texts"  is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                // action(Translations)
                // {
                //     CaptionML = ENU = 'Translations',
                //                 FRA = 'Traductions';
                //     Image = Text;
                //     RunObject = Page "Item Translations";
                //     RunPageLink = "Item No." = FIELD("No.");
                // }
                // action("E&xtended Texts")
                // {
                //     CaptionML = ENU = 'E&xtended Texts',
                //                 FRA = 'Te&xtes étendus';
                //     Image = Text;
                //     RunObject = Page "Extended Text List";
                //     RunPageLink = "Table Name" = CONST(Item),
                //                   "No." = FIELD("No.");
                //     RunPageView = sorting("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                // }
                //BC Upgrade KAMNAY01<< 'Translations' And "E&xtended Texts"  is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                separator(Separator1100076075)
                {
                }
                //BC Upgrade KAMNAY01>> DITW Action
                // action("Packing list")
                // {
                //     CaptionML = ENU = 'Packing list',
                //                 FRA = 'Liste de colisage';
                //     Image = Document;

                //     trigger OnAction();
                //     var
                //         lrecPackingListLine: Record "Packing List Line";
                //     begin
                //         // <<DITW15.00.00.33-HLW15.00.01.01 DDR 05/06/2009
                //         lrecPackingListLine.SETRANGE("Table ID", DATABASE::Item);
                //         lrecPackingListLine.SETRANGE("Document Type", lrecPackingListLine."Document Type"::Item);
                //         lrecPackingListLine.SETRANGE("Document No.", "No.");
                //         PAGE.RUNMODAL(PAGE::"Packing List Lines", lrecPackingListLine);
                //     end;
                // }
                //BC Upgrade KAMNAY01<< DITW Action
                group("Assembly List")
                {
                    CaptionML = ENU = 'Assembly List',
                                FRA = 'Liste d''assemblage';
                    Image = AssemblyBOM;
                    action("Bill of Materials")
                    {
                        CaptionML = ENU = 'Bill of Materials',
                                    FRA = 'Nomenclature';
                        RunObject = Page "Assembly BOM";
                        RunPageLink = "Parent Item No." = FIELD("No.");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Bill of Materials action.';
                    }
                    action("Where-Used List")
                    {
                        CaptionML = ENU = 'Where-Used List',
                                    FRA = 'Liste des cas d''emploi';
                        RunObject = Page "Where-Used List";
                        RunPageLink = Type = CONST(Item),
                                      "No." = FIELD("No.");
                        RunPageView = sorting(Type, "No.");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Where-Used List action.';
                    }
                    //BC Upgrade KAMNAY01>> 'Calc. Stan&dard Cost' is already defined in PageExtension 'Asm. Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
                    // action("Calc. Stan&dard Cost")
                    // {
                    //     CaptionML = ENU = 'Calc. Stan&dard Cost',
                    //                 FRA = 'C&alculer coût standard';

                    //     trigger OnAction();
                    //     begin
                    //         CLEAR(CalculateStdCost);
                    //         CalculateStdCost.CalcItem("No.", true);
                    //     end;
                    // }
                    // //BC Upgrade KAMNAY01<< 'Calc. Stan&dard Cost' is already defined in PageExtension 'Asm. Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
                }
                group("Manufa&cturing")
                {
                    CaptionML = ENU = 'Manufa&cturing',
                                FRA = 'Pr&oduction';
                    Image = "Where-Used";
                    //BC Upgrade KAMNAY01>> 'Where-Used' is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                    // action("Where-Used")
                    // {
                    //     CaptionML = ENU = 'Where-Used',
                    //                 FRA = 'Cas d''emploi';

                    //     trigger OnAction();
                    //     var
                    //         ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
                    //     begin
                    //         ProdBOMWhereUsed.SetItem(Rec, WORKDATE);
                    //         ProdBOMWhereUsed.RUNMODAL;
                    //     end;
                    // }
                    //BC Upgrade KAMNAY01<< 'Where-Used' is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                    action(Action1100076082)
                    {
                        CaptionML = ENU = 'Calc. Stan&dard Cost',
                                    FRA = 'C&alculer coût standard';
                        ApplicationArea = All;
                        ToolTip = 'Executes the Action1100076082 action.';

                        trigger OnAction();
                        begin
                            CLEAR(CalculateStdCost);
                            CalculateStdCost.CalcItem(Rec."No.", false);
                        end;
                    }
                }
                separator(Separator1100076083)
                {
                }
                //BC Upgrade KAMNAY01>> DITW Action
                //action("&Equipments")
                // {
                //     CaptionML = ENU = '&Equipments',
                //                 FRA = '&Équimpements';
                //     Image = Tools;
                //     RunObject = Page "Service Items List PM";
                //     RunPageLink = "Item No." = FIELD("No.");
                //     RunPageView = sorting("Item No.");
                // }
                //BC Upgrade KAMNAY01<< DITW Action
                //BC Upgrade KAMNAY01>> 'Troubleshooting' is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                // action(Troubleshooting)
                // {
                //     CaptionML = ENU = 'Troubleshooting',
                //                 FRA = 'Incident';
                //     Image = Troubleshoot;
                //     RunObject = Page "Troubleshooting Setup";
                //     RunPageLink = Type = CONST(Item),
                //                   "No." = FIELD("No.");
                // }
                //BC Upgrade KAMNAY01<< 'Troubleshooting' is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                group("R&esource")
                {
                    CaptionML = ENU = 'R&esource',
                                FRA = 'Re&ssource';
                    Image = Resource;
                    //BC Upgrade KAMNAY01>> 'Resource Skills' is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                    // action("Resource Skills")
                    // {
                    //     CaptionML = ENU = 'Resource Skills',
                    //                 FRA = 'Compétences ressource';
                    //     RunObject = Page "Resource Skills";
                    //     RunPageLink = Type = CONST(Item),
                    //                   "No." = FIELD("No.");
                    // }
                    //BC Upgrade KAMNAY01<< 'Resource Skills' is already defined in Page 'Item Card' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
                    //BC Upgrade KAMNAY01>> Skilled Resources' is already defined in PageExtension 'Serv. Item Card' by the extension 'Base Application by Microsoft
                    // action("Skilled Resources")
                    // {
                    //     CaptionML = ENU = 'Skilled Resources',
                    //                 FRA = 'Ressources compétentes';

                    //     trigger OnAction();
                    //     var
                    //         ResourceSkill: Record "Resource Skill";
                    //     begin
                    //         CLEAR(SkilledResourceList);
                    //         SkilledResourceList.Initialize(ResourceSkill.Type::Item, "No.", Description);
                    //         SkilledResourceList.RUNMODAL;
                    //     end;
                    // }
                    //BC Upgrade KAMNAY01<< Skilled Resources' is already defined in PageExtension 'Serv. Item Card' by the extension 'Base Application by Microsoft
                }
                separator(Separator1100076092)
                {
                }
                action(Action1100076093)
                {
                    CaptionML = ENU = 'Identifiers',
                                FRA = 'Identifiants';
                    Image = EncryptionKeys;
                    RunObject = Page "Item Identifiers";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = sorting("Item No.", "Variant Code", "Unit of Measure Code");
                    ApplicationArea = All;
                    ToolTip = 'Executes the Action1100076093 action.';
                }
            }
        }
        //BC Upgrade KAMNAY01>> DITW Action
        // addafter("Item &Tracking Entries")
        // { 
        // action(Action1100083090)
        // {
        //     CaptionML = ENU = 'SSCC Tracking Entries',
        //                 FRA = 'Ecritures traçablité SSCC';
        //     Image = ItemTrackingLedger;

        //     trigger OnAction();
        //     var
        //         SSCCTrackingMgt: Codeunit "SSCC Tracking Management";
        //     begin
        //         // <<DITW15.00.00.38 DDR 19/11/2010 #1139
        //         SSCCTrackingMgt.CallSSCCTrackingEntryForm(3, '', "No.", '', '', '', '', 0);
        //     end;
        // }

        //}
        // addafter("T&urnover")
        // {
        //     action("Items by Period")
        //     {
        //         CaptionML = ENU = 'Items by Period',
        //                     FRA = 'Articles par période';
        //         Description = 'DIT-715 #338';
        //         Image = Period;
        //         RunObject = Page "Item Availability by Period3";
        //         RunPageLink = "No." = FIELD("No."),
        //                       "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
        //                       "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
        //                       "Location Filter" = FIELD("Location Filter"),
        //                       "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
        //                       "Variant Filter" = FIELD("Variant Filter");
        //     }
        //     action("Period (Items)")
        //     {
        //         CaptionML = ENU = 'Period (Items)',
        //                     FRA = 'Période (Article)';
        //         Description = 'DIT-715 #338';
        //         Image = Period;
        //         RunObject = Page "Item Availability by Period2";
        //         RunPageLink = "No." = FIELD("No."),
        //                       "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
        //                       "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
        //                       "Location Filter" = FIELD("Location Filter"),
        //                       "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
        //                       "Variant Filter" = FIELD("Variant Filter");
        //     }
        //     action("Empty Goods Tracking")
        //     {
        //         CaptionML = ENU = 'Empty Goods Tracking',
        //                     FRA = 'Traçablité vidange';
        //         Image = ItemTrackingLines;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         RunObject = Page "Empty Goods Tracking Overview";
        //         RunPageLink = Code = FIELD("No."),
        //                       "Date Filter" = FIELD("Date Filter"),
        //                       "Variant Filter" = FIELD("Variant Filter"),
        //                       "Location Filter" = FIELD("Location Filter"),
        //                       "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
        //                       "Global Dimension 2 Filter" = FIELD("Global Dimension 1 Filter");
        //     }
        //     action("Item Loyalty Statistics")
        //     {
        //         CaptionML = ENU = 'Item Loyalty Statistics',
        //                     FRA = 'Statistique article de fidélité';
        //         Description = 'DIT715 #243';
        //         Image = Statistics;
        //         RunObject = Page "Item Loyalty by Customer";
        //         RunPageLink = "No." = FIELD("No.");
        //     }
        // }

        // addafter(Action86)
        // {  //BC Upgrade KAMNAY01>> DITW Action
        //     // action("Purchase Net Cost")
        //     // {
        //     //     CaptionML = DEU = 'Netto EK Preise',
        //     //                 ENU = 'Purchase Net Cost';

        //     //     trigger OnAction();
        //     //     var
        //     //         lrPurchaseNetCost: Record "Purchase Net Cost";
        //     //         lpgePurchaseNetCost: Page "Purchase Net Cost";
        //     //     begin
        //     //         // << DITW110.00.11 SFI 12/12/2017 BL#XXXXX
        //     //         lrPurchaseNetCost.RESET;
        //     //         lrPurchaseNetCost.SETRANGE("Vendor No.", "Vendor No.");
        //     //         lrPurchaseNetCost.SETRANGE("Item No.", "No.");
        //     //         lrPurchaseNetCost.SETRANGE("Variant Code");
        //     //         lrPurchaseNetCost.SETRANGE("Location Code");
        //     //         lrPurchaseNetCost.SETFILTER("As Per date", '<=%1', WORKDATE);
        //     //         if lrPurchaseNetCost.FINDLAST then begin
        //     //             PAGE.RUNMODAL(PAGE::"Purchase Net Cost", lrPurchaseNetCost);
        //     //         end;
        //     //         // >> DITW110.00.11 SFI BL#XXXXX
        //     //     end;
        //     // }
        //     action("D&iscount Charges")
        //     {
        //         CaptionML = ENU = 'D&iscount Charges',
        //                     FRA = 'Frais de remise';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //         Image = TaxSetup;
        //         RunObject = Page "Purchase Discount Item Charges";
        //         RunPageLink = "Source Type" = CONST(Item),
        //                       "Source No." = FIELD("No.");
        //     }
        //     action("Promotio&n Charges")
        //     {
        //         CaptionML = ENU = 'Promotio&n Charges',
        //                     FRA = 'Frais de promotion';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //         Image = TaxSetup;
        //         RunObject = Page "Purch. Promotion Item Charges";
        //         RunPageLink = "Source Type" = CONST(Item),
        //                       "Source No." = FIELD("No.");
        //     }
        //     group("Drink-It Charges")
        //     {
        //         CaptionML = ENU = 'Drink-It Charges',
        //                     FRA = 'Frais Drink-IT';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //         Image = TaxSetup;
        //         action("Ta&x Charges")
        //         {
        //             CaptionML = ENU = 'Ta&x Charges',
        //                         FRA = 'Taxe d''impôt';
        //             Description = 'DITW15.00.00.01';
        //             Image = TaxSetup;
        //             RunObject = Page "Purchase Tax Item Charges";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //         action("D&eposit Charges")
        //         {
        //             CaptionML = ENU = 'D&eposit Charges',
        //                         FRA = 'Friais de dépôt';
        //             Description = 'DITW15.00.00.01';
        //             Image = TaxSetup;
        //             RunObject = Page "Purchase Deposit Item Charges";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //         action(Action1100710013)
        //         {
        //             CaptionML = ENU = 'D&iscount Charges',
        //                         FRA = 'Frais de remise';
        //             Image = TaxSetup;
        //             RunObject = Page "Purchase Discount Item Charges";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //         action(Action1100710012)
        //         {
        //             CaptionML = ENU = 'Promotio&n Charges',
        //                         FRA = 'Frais de promotion';
        //             Image = TaxSetup;
        //             RunObject = Page "Purch. Promotion Item Charges";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //     }
        // }

        // addafter("Nonstoc&k Items")
        // {
        //     separator(Separator2036009)
        //     {
        //     }
        //     action("Item Minor Revision(s)")
        //     {
        //         CaptionML = ENU = 'Item Minor Revision(s)',
        //                     FRA = 'Révision(s) d''article mineur';
        //         Description = 'MANXL7.00.001';
        //         RunObject = Page "Item Minor Revisions";
        //         RunPageLink = "Item No." = FIELD("No.");
        //         RunPageView = sorting("Item No.", "Revision No.")
        //                       ORDER(Ascending);
        //     }
        //     group(Others)
        //     {
        //         CaptionML = ENU = 'Others',
        //                     FRA = 'Autres';
        //         Image = Item;
        //         action("Items &Exclusivity")
        //         {
        //             CaptionML = ENU = 'Items &Exclusivity',
        //                         FRA = 'Articles &Exclusivité';
        //             Image = Item;
        //             RunObject = Page "Purchase Items Exclusivity";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //     }
        // }

        // addfirst("S&ales")
        // {
        //     action(Action1100710011)
        //     {
        //         CaptionML = ENU = 'D&iscount Charges',
        //                     FRA = 'Frais de remise';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //         Image = TaxSetup;
        //         RunObject = Page "Sales Discount Item Charges";
        //         RunPageLink = "Source Type" = CONST(Item),
        //                       "Source No." = FIELD("No.");
        //     }
        //     action(Action1100710010)
        //     {
        //         CaptionML = ENU = 'Promotio&n Charges',
        //                     FRA = 'Frais de promotion';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //         Image = TaxSetup;
        //         RunObject = Page "Sales Promotion Item Charges";
        //         RunPageLink = "Source Type" = CONST(Item),
        //                       "Source No." = FIELD("No.");
        //     }
        //     group(ActionGroup1100710009)
        //     {
        //         CaptionML = ENU = 'Drink-It Charges',
        //                     FRA = 'Frais Drink-IT';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //         Image = TaxSetup;
        //         action(Action1100710008)
        //         {
        //             CaptionML = ENU = 'Ta&x Charges',
        //                         FRA = 'Taxe d''impôt';
        //             Description = 'DITW15.00.00.01';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Tax Item Charges";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //         action(Action1100710007)
        //         {
        //             CaptionML = ENU = 'Exception Tax Groups',
        //                         FRA = 'Groupes taxe excéption';
        //             Image = TaxSetup;
        //             RunObject = Page "Customer Exception Tax Groups";
        //         }
        //         action(Action1100710006)
        //         {
        //             CaptionML = ENU = 'D&eposit Charges',
        //                         FRA = 'Friais de dépôt';
        //             Description = 'DITW15.00.00.01';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Deposit Item Charges";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //         action(Action1100710005)
        //         {
        //             CaptionML = ENU = 'D&iscount Charges',
        //                         FRA = 'Frais de remise';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Discount Item Charges";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //         action(Action1100710004)
        //         {
        //             CaptionML = ENU = 'Promotio&n Charges',
        //                         FRA = 'Frais de promotion';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Promotion Item Charges";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //     }
        // }

        // addafter(Action163)
        // {
        // group("Credit Limits")
        // {
        //     CaptionML = ENU = 'Credit Limits',
        //                 FRA = 'Limite crédit';
        //     Image = LimitedCredit;
        //     action("Deposit Li&mits")
        //     {
        //         CaptionML = ENU = 'Deposit Li&mits',
        //                     FRA = 'Limite dépôt';
        //         Image = LimitedCredit;
        //         RunObject = Page "Sales Deposit Limits";
        //         RunPageLink = "Item No." = FIELD("No.");
        //     }
        // }
        // group(ActionGroup1100066003)
        // {
        //     CaptionML = ENU = 'Others',
        //                 FRA = 'Autres';
        //     Image = Item;
        //     action(Action1100076114)
        //     {
        //         CaptionML = ENU = 'Items &Exclusivity',
        //                     FRA = 'Articles &Exclusivité';
        //         Image = Item;
        //         RunObject = Page "Sales Items Exclusivity";
        //         RunPageLink = "Source Type" = CONST(Item),
        //                       "Source No." = FIELD("No.");
        //     }
        //     action("Items &Quota")
        //     {
        //         CaptionML = ENU = 'Items &Quota',
        //                     FRA = 'Articles &Quota';
        //         Image = Item;
        //         RunObject = Page "Sales Items Quota";
        //         RunPageLink = "Source Type" = CONST(Item),
        //                       "Source No." = FIELD("No.");
        //     }
        //     action("Loyalty Items")
        //     {
        //         CaptionML = ENU = 'Loyalty Items',
        //                     FRA = 'Articles de fidelité';
        //         Description = 'DIT715 #243';
        //         Image = Item;
        //         RunObject = Page "Sales Loyalty Points & Amounts";
        //         RunPageLink = "Source Type" = CONST(Item),
        //                       "Source No." = FIELD("No.");
        //     }
        //     action(Action110183173)
        //     {
        //         CaptionML = ENU = 'Quality Standards',
        //                     FRA = 'Standards de qualité';
        //         Image = TaskQualityMeasure;
        //         RunObject = Page "Sales Standards";
        //         RunPageLink = "Item No." = FIELD("No.");
        //         RunPageView = sorting("Item No.", "Sales Type", "Sales Code", "Starting Date", "Variant Code", "Qlty. Measure Code");
        //     }
        // }
        //     separator(Separator2036000)
        //     {
        //     }
        //     action("Recycle Charges")
        //     {
        //         CaptionML = ENU = 'Recycle Charges',
        //                     FRA = 'Recyclage annexes';
        //         Description = 'FINXL7.00.001 KLU 27/06/2014 #42';
        //         Image = Reuse;
        //         RunObject = Page "Item Recycle Charge";
        //         RunPageLink = "Item No." = FIELD("No.");
        //     }
        // }

        // addafter("Stockkeepin&g Units")
        // {
        //     group(ActionGroup1100710002)
        //     {
        //         CaptionML = ENU = 'Calc. Stan&dard Cost',
        //                     FRA = 'C&alculer coût standard';
        //         Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //         Image = CalculateCost;
        //         action("Calc. for Assembly ( SKU only )")
        //         {
        //             CaptionML = ENU = 'Calc. for Assembly ( SKU only )',
        //                         FRA = 'Calc. pour assemblage (point de stock uniquement)';
        //             Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //             Image = AssemblyBOM;

        //             trigger OnAction();
        //             begin
        //                 // << DITW18.00.06 MSF 09/02/2015 DIT-770 #1185
        //                 CLEAR(CalculateStdCost);
        //                 CalculateStdCost.CalcStdCostAllSKU("No.", true);
        //                 // >> DITW18.00.06 MSF 09/02/2015 DIT-770 #1185
        //             end;
        //         }
        //         action("Calc. for prod. order ( SKU only )")
        //         {
        //             CaptionML = ENU = 'Calc. for prod. order ( SKU only )',
        //                         FRA = 'Calc. pour OF (Point de stock uniquement)';
        //             Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //             Image = Production;

        //             trigger OnAction();
        //             begin
        //                 // << DITW18.00.06 MSF 09/02/2015 DIT-770 #1185
        //                 CLEAR(CalculateStdCost);
        //                 CalculateStdCost.CalcStdCostAllSKU("No.", false);
        //                 // >> DITW18.00.06 MSF 09/02/2015 DIT-770 #1185
        //             end;
        //         }
        //     }
        // }

        // addfirst(Service)
        // {
        //     group(ActionGroup1100710003)
        //     {
        //         CaptionML = ENU = 'Service',
        //                     FRA = 'Service';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //         Image = ServiceItem;
        //     }
        // }
        //BC Upgrade KAMNAY01<< DITW Action
        addafter(Resources)
        {
            group("<Action1000000001>")
            {
                CaptionML = ENU = 'Change Log',
                            FRA = 'Journal Modification';
                Image = Log;
                group("Change Log Entries")
                {
                    CaptionML = ENU = 'Change Log Entries',
                                FRA = 'Écritures journal modification';
                    Image = Log;
                    action("<Action1000000002>")
                    {
                        CaptionML = ENU = 'by Item',
                                    FRA = 'Article';
                        Image = Log;
                        RunObject = Page "Change Log Entries";
                        RunPageLink = "Table No." = FILTER(27),
                                      "Primary Key Field 1 Value" = FIELD("No.");
                        ApplicationArea = All;
                        ToolTip = 'Executes the <Action1000000002> action.';
                    }
                    action("<Action1000000003>")
                    {
                        CaptionML = ENU = 'by Default dimension',
                                    FRA = 'Affectation analytique';
                        Image = Log;
                        RunObject = Page "Change Log Entries";
                        RunPageLink = "Table No." = FILTER(352),
                                      "Primary Key Field 1 Value" = FILTER(27),
                                      "Primary Key Field 2 Value" = FIELD("No.");
                        ApplicationArea = All;
                        ToolTip = 'Executes the <Action1000000003> action.';
                    }
                }
            }
        }
        // moveafter("Cross Re&ferences"; "Co&mments") //BC Upgrade KAMNAY01
        moveafter(Action300; Action83)
    }




    //Unsupported feature: PropertyModification on "CreateNewTxt(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreateNewTxt : ENU=Create New...;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateNewTxt : ENU=Create New...;FRA=Créer...;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ViewOrChangeExistingTxt(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ViewOrChangeExistingTxt : ENU=View or Change Existing...;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ViewOrChangeExistingTxt : ENU=View or Change Existing...;FRA=Afficher ou modifier des valeurs existantes...;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreateNewSpecialPriceTxt(Variable 1023)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreateNewSpecialPriceTxt : ENU=Create New Special Price...;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateNewSpecialPriceTxt : ENU=Create New Special Price...;FRA=Créer un prix spécial...;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreateNewSpecialDiscountTxt(Variable 1024)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreateNewSpecialDiscountTxt : ENU=Create New Special Discount...;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateNewSpecialDiscountTxt : ENU=Create New Special Discount...;FRA=Créer une remise spéciale...;
    //Variable type has not been exported.
    ///
    //BC Upgrade KAMNAY01>>
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.14>>
        PurchasesPayablesSetup.GET();
        EnableHSLevy := PurchasesPayablesSetup."H&S Levy Tax FND";
        //HEI.14<<
    end;
    //BC Upgrade KAMNAY01<<
    var
        rManufacturingSetup: Record "Manufacturing Setup";
        //VisibleAstro: Boolean; //BC Upgrade KAMNAY01 Astro variables removed
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        // recFinXLSetup: Record "Finance XL Setup"; //BC Upgrade KAMNAY01>> 
        blnCopyItemVisible: Boolean;
        bolShowPurchaseBlocked: Boolean;
        //"_FINXL10.01.VAR": Integer; //BC Upgrade KAMNAY01
        bolShowPurchaseNoWarning: Boolean;
        bolShowPurchaseWarning: Boolean;
        bolShowSalesBlocked: Boolean;
        bolShowSalesNoWarning: Boolean;
        bolShowSalesWarning: Boolean;

        BTComponentVisible: Boolean;

        BTItemVisible: Boolean;
        EnableHSLevy: Boolean;

        GlobalTax1ValueEditable: Boolean;

        GlobalTax2ValueEditable: Boolean;
        RunModeCaptionPM: Boolean;

        ShortcutTaxSpec1Editable: Boolean;

        ShortcutTaxSpec1Enable: Boolean;

        ShortcutTaxSpec1Visible: Boolean;

        ShortcutTaxSpec2Editable: Boolean;

        ShortcutTaxSpec2Enable: Boolean;

        ShortcutTaxSpec2Visible: Boolean;

        ShortcutTaxSpec3Editable: Boolean;

        ShortcutTaxSpec3Enable: Boolean;

        ShortcutTaxSpec3Visible: Boolean;

        ShortcutTaxSpec4Editable: Boolean;

        ShortcutTaxSpec4Enable: Boolean;

        ShortcutTaxSpec4Visible: Boolean;

        ShortcutTaxSpec5Editable: Boolean;

        ShortcutTaxSpec5Enable: Boolean;

        ShortcutTaxSpec5Visible: Boolean;

        ShortcutTaxSpec6Editable: Boolean;

        ShortcutTaxSpec6Enable: Boolean;

        ShortcutTaxSpec6Visible: Boolean;

        ShortcutTaxSpec7Editable: Boolean;

        ShortcutTaxSpec7Enable: Boolean;

        ShortcutTaxSpec7Visible: Boolean;

        ShortcutTaxSpec8Editable: Boolean;

        ShortcutTaxSpec8Enable: Boolean;

        ShortcutTaxSpec8Visible: Boolean;

        ShortcutTaxSpec9Editable: Boolean;

        ShortcutTaxSpec9Enable: Boolean;

        ShortcutTaxSpec9Visible: Boolean;

        ShortcutTaxSpec10Editable: Boolean;

        ShortcutTaxSpec10Enable: Boolean;

        ShortcutTaxSpec10Visible: Boolean;
        QuarantineInvtQty: Decimal;
        ShortcutTaxSpecValue: array[10] of Decimal;
        BelongsItemLevel: Integer;
        //rMANXLSetup: Record "Manufacturing XL Setup"; //BC Upgrade KAMNAY01>> 
        intAccessTime: Integer;
        BelongsItemDescription: Text[30];
        ShortcutTaxSpecFormatType: array[10] of Text[80];
        Text2014310_0: TextConst ENU = 'Component Card', FRA = 'Fiche composant';


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CreateItemFromTemplate;
    CRMIsCoupledToRecord := CRMIntegrationEnabled and CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
    #4..9
    EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Item,EventFilter);

    CurrPage.ItemAttributesFactbox.PAGE.LoadItemAttributesData("No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12

    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    ShowShortcutTaxSpecValue(ShortcutTaxSpecValue,ShortcutTaxSpecFormatType);
    EnableTaxSpecControls();
    // >>DITW19.00.08 DDR BL#10443
    // <<DITW15.00.00.39 DDR 22/08/2011 #1366
    QuarantineInvtQty := InvtLocationQuarantine(FIELDNO(Inventory));
    // >>DITW15.00.00.39 DDR #1366
    // <<DITW15.00.00.39 DDR 26/08/2011 #1393
    GetTreeItem("No.",BelongsItemDescription,BelongsItemLevel);
    // >>DITW15.00.00.23 DDR
    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    GlobalTax1ValueEditable := HasTaxSpecEditable("Strength Spec. Code");
    "Strength Spec. Value" := GetGlobalTaxSpecValue("Strength Spec. Code");
    GlobalTax2ValueEditable := HasTaxSpecEditable("Vol-Strength Spec. Code");
    "Vol-Strength Spec. Value" := GetGlobalTaxSpecValue("Vol-Strength Spec. Code");
    // >>DITW19.00.08 DDR BL#10443
    */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitControls
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InitControls;
    // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
    InitControlsDIT;
    // >>DITW110.00.08 DDR NRQ#0
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsertRecord". Please convert manually.

    //trigger OnInsertRecord(BelowxRec : Boolean) : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InsertItemUnitOfMeasure;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    if rMANXLSetup.READPERMISSION then
    //>>MANXL7.00.001 WSA 11/07/2014 #87
      //<<MANXL7.00.001 DAT 03/03/2014 #12
      if rManufacturingSetup."Item Create Wizard" then
        exit(false);
      //>>MANXL7.00.001 DAT 03/03/2014 #12

    InsertItemUnitOfMeasure;
    */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnNewRec
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<<FINXL8.00.001 BSA 23/06/2015 #161
    if recFinXLSetup.READPERMISSION then
      AutomaticApplyTemplate;
    //>>FINXL8.00.001 BSA 23/06/2015 #161

    OnNewRec;
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger (Variable: AstroInterfaceSetupL)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsFoundationEnabled := ApplicationAreaSetup.IsFoundationEnabled;
    EnableControls;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    if rMANXLSetup.READPERMISSION then begin
    //>>MANXL7.00.001 WSA 11/07/2014 #87
      //<<MANXL7.00.001 DAT 03/03/2014 #12
      if rManufacturingSetup.GET then
        if (rManufacturingSetup."Item Create Wizard") and ("No." = '') then
          ERROR('');
      //>>MANXL7.00.001 DAT 03/03/2014 #12
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    end;
    //>>MANXL7.00.001 WSA 11/07/2014 #87
    // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
    RunModeCaptionPM := SetCaptionClassPM();
    if RunModeCaptionPM then begin
      CurrPage.CAPTION := Text2014310_0;
    end;
    BTItemVisible := not RunModeCaptionPM;
    BTComponentVisible := RunModeCaptionPM;
    // >>DITW16.00.00.41 DDR DIT-715 #297

    IsFoundationEnabled := ApplicationAreaSetup.IsFoundationEnabled;
    EnableControls;
    //<<FINXL9.00.001 ACH 26/07/2016
    if recFinXLSetup.READPERMISSION then begin
      recFinXLSetup.GET;
      blnCopyItemVisible := recFinXLSetup."Copy item wizard";
    end;
    //>>FINXL9.00.001 ACH 26/07/2016

    //HEI.13>>
    CLEAR(VisibleAstro);
    if AstroInterfaceSetupL.GET and AstroInterfaceSetupL."Enabled Astro Integration" then begin
      if AstroInterfaceSetupL."Activate Material Master" and (AstroInterfaceSetupL."Item Create/Update Interface" <> '') then
        if InterfaceSetupL.GET(AstroInterfaceSetupL."Item Create/Update Interface") then
          VisibleAstro := true;
    end;
    //HEI.13<<
    //HEI.14>>
    PurchasesPayablesSetup.GET;
    EnableHSLevy := PurchasesPayablesSetup."H&S Levy Tax";
    //HEI.14<<
    */
    //end;

    procedure "_FINXL10.01.VAR"();
    begin
    end;

    procedure lrecPurchSetup();
    begin
    end;


    //Unsupported feature: CodeModification on "EnableShowStockOutWarning(PROCEDURE 4)". Please convert manually.

    //procedure EnableShowStockOutWarning();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesSetup.GET;
    ShowStockoutWarningDefaultYes := SalesSetup."Stockout Warning";
    ShowStockoutWarningDefaultNo := not ShowStockoutWarningDefaultYes;

    EnableShowShowEnforcePositivInventory
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    //<<FINXL10.01 OFE 30/08/017 NRQ#10433
    lrecPurchSetup.GET;
    bolShowPurchaseNoWarning := lrecPurchSetup."Purchase price mandatory" = lrecPurchSetup."Purchase price mandatory"::"No Warning";
    bolShowPurchaseWarning := lrecPurchSetup."Purchase price mandatory" = lrecPurchSetup."Purchase price mandatory"::Warning;
    bolShowPurchaseBlocked := lrecPurchSetup."Purchase price mandatory" = lrecPurchSetup."Purchase price mandatory"::Blocked;
    bolShowSalesNoWarning := SalesSetup."Sales prices mandatory" = SalesSetup."Sales prices mandatory"::"No Warning";
    bolShowSalesWarning := SalesSetup."Sales prices mandatory" = SalesSetup."Sales prices mandatory"::Warning;
    bolShowSalesBlocked := SalesSetup."Sales prices mandatory" = SalesSetup."Sales prices mandatory"::Blocked;
    //>>FINXL10.01 OFE 30/08/017 NRQ#10433
    EnableShowShowEnforcePositivInventory
    */
    //end;
    //BC Upgrade KAMNAY01>> DITW Code   
    // local procedure AutomaticApplyTemplate();
    // var
    //     RecRef: RecordRef;
    //     lrecRefItem: RecordRef;
    //     CuConf: Codeunit "Config. Template Management";
    //     CodePackageID: Code[10];
    //     ConfigTemplateHeader: Record "Config. Template Header";
    //     lrecGeneralLedgerSetup: Record "General Ledger Setup";
    // begin
    //     //<<FINXL8.00.001 BSA 23/06/2015 #161
    //     lrecGeneralLedgerSetup.GET;
    //     if lrecGeneralLedgerSetup."Apply template" then begin
    //         RecRef.GETTABLE(Rec);
    //         ConfigTemplateHeader.SETRANGE("Table ID", RecRef.NUMBER);
    //         if PAGE.RUNMODAL(PAGE::"Config. Template List", ConfigTemplateHeader, ConfigTemplateHeader.Code) = ACTION::LookupOK then begin
    //             lrecRefItem.GETTABLE(Rec);
    //             CuConf.InsertTemplate2(lrecRefItem, ConfigTemplateHeader);
    //             lrecRefItem.SETTABLE(Rec);
    //         end;
    //     end;
    //     //>>FINXL8.00.001 BSA 23/06/2015 #161
    // end;

    // procedure EnableTaxSpecControls();
    // var
    //     TaxSpecEnabled: array[10] of Boolean;
    //     TaxSpecEditable: array[10] of Boolean;
    // begin
    //     // <<DITW15.00.00.24 DDR 22/09/2008
    //     SetUpTaxSpecControls(TaxSpecEnabled, TaxSpecEditable);
    //     ShortcutTaxSpec1Enable := TaxSpecEnabled[1];
    //     ShortcutTaxSpec2Enable := TaxSpecEnabled[2];
    //     ShortcutTaxSpec3Enable := TaxSpecEnabled[3];
    //     ShortcutTaxSpec4Enable := TaxSpecEnabled[4];
    //     ShortcutTaxSpec5Enable := TaxSpecEnabled[5];
    //     ShortcutTaxSpec6Enable := TaxSpecEnabled[6];
    //     ShortcutTaxSpec7Enable := TaxSpecEnabled[7];
    //     ShortcutTaxSpec8Enable := TaxSpecEnabled[8];
    //     ShortcutTaxSpec9Enable := TaxSpecEnabled[9];
    //     ShortcutTaxSpec10Enable := TaxSpecEnabled[10];
    //     ShortcutTaxSpec1Editable := TaxSpecEditable[1];
    //     ShortcutTaxSpec2Editable := TaxSpecEditable[2];
    //     ShortcutTaxSpec3Editable := TaxSpecEditable[3];
    //     ShortcutTaxSpec4Editable := TaxSpecEditable[4];
    //     ShortcutTaxSpec5Editable := TaxSpecEditable[5];
    //     ShortcutTaxSpec6Editable := TaxSpecEditable[6];
    //     ShortcutTaxSpec7Editable := TaxSpecEditable[7];
    //     ShortcutTaxSpec8Editable := TaxSpecEditable[8];
    //     ShortcutTaxSpec9Editable := TaxSpecEditable[9];
    //     ShortcutTaxSpec10Editable := TaxSpecEditable[10];
    // end;

    // local procedure BelongsItemNoOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.39 DDR 26/08/2011 #1393
    //     GetTreeItem("No.", BelongsItemDescription, BelongsItemLevel);
    // end;
    //BC Upgrade KAMNAY01<< DITW Code
    local procedure TaxSpecViewCodeOnAfterValidate();
    begin
        CurrPage.UPDATE(true);
    end;
    //BC Upgrade KAMNAY01>> DITW Code
    // local procedure ItemDTaxGroupCodeOnAfterValida();
    // begin
    //     // <<DITW15.00.00.38 DDR 12/08/2010 #1217
    //     CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.38 DDR
    // end;

    // local procedure NoofDrinkDiscGroupsOnActivate();
    // begin
    //     // <<DITW15.00.00.35 DDR 19/08/2009
    //     CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure NoofPromotionGroupsOnActivate();
    // begin
    //     // <<DITW15.00.00.35 DDR 19/08/2009
    //     CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.35 DDR
    // end;
    //BC Upgrade KAMNAY01<<ITW Code
    local procedure NoofExclusivityGroupsOnActivat();
    begin
        CurrPage.UPDATE(true);
    end;

    local procedure NoofLoyaltyGroupsOnActivate();
    begin
        CurrPage.UPDATE(true);
    end;

    local procedure NoofQuotaGroupsOnActivat();
    begin
        CurrPage.UPDATE(true);
    end;
    //BC Upgrade KAMNAY01>> DITW Code
    // local procedure InitControlsDIT();
    // begin
    //     // <<DITW16.00.00.37 DDR 06/08/2010 #1
    //     ShortcutTaxSpec10Enable := true;
    //     ShortcutTaxSpec9Enable := true;
    //     ShortcutTaxSpec8Enable := true;
    //     ShortcutTaxSpec7Enable := true;
    //     ShortcutTaxSpec6Enable := true;
    //     ShortcutTaxSpec5Enable := true;
    //     ShortcutTaxSpec4Enable := true;
    //     ShortcutTaxSpec3Enable := true;
    //     ShortcutTaxSpec2Enable := true;
    //     ShortcutTaxSpec1Enable := true;
    //     ShortcutTaxSpec10Editable := true;
    //     ShortcutTaxSpec9Editable := true;
    //     ShortcutTaxSpec8Editable := true;
    //     ShortcutTaxSpec7Editable := true;
    //     ShortcutTaxSpec6Editable := true;
    //     ShortcutTaxSpec5Editable := true;
    //     ShortcutTaxSpec4Editable := true;
    //     ShortcutTaxSpec3Editable := true;
    //     ShortcutTaxSpec2Editable := true;
    //     ShortcutTaxSpec1Editable := true;
    //     BTComponentVisible := true;
    //     BTItemVisible := true;
    //     ShortcutTaxSpec10Visible := true;
    //     ShortcutTaxSpec9Visible := true;
    //     ShortcutTaxSpec8Visible := true;
    //     ShortcutTaxSpec7Visible := true;
    //     ShortcutTaxSpec6Visible := true;
    //     ShortcutTaxSpec5Visible := true;
    //     ShortcutTaxSpec4Visible := true;
    //     ShortcutTaxSpec3Visible := true;
    //     ShortcutTaxSpec2Visible := true;
    //     ShortcutTaxSpec1Visible := true;
    //     // >>DITW16.00.00.37 DDR 06/08/2010 #1
    //     // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    //     GlobalTax1ValueEditable := true;
    //     GlobalTax2ValueEditable := true;
    //     // >>DITW19.00.08 DDR BL#10443
    // end;
    //BC Upgrade KAMNAY01<< DITW Code

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

