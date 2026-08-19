pageextension 51151 ItemListExtCBN extends "Item List"
{
    //   DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    //                                 added menu item charges into Sales & Purchases buttons
    // DITW15.00.00.01 DDR 26/12/2007 Added Drink-it Tax Item Charges functionnalities
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 21/01/2008 Added Drink-it Disc.& Promotion functionalities
    //                                added menu into item, Sales & Purchases
    // DITW15.00.00.01 DDR 05/02/2008 Change captions menu (Drink-it)
    // DITW15.00.00.01 DDR 19/03/2008 Added menu Deposit Limits into Sales button
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.16 DDR 28/03/2008 Added itemmenu "Empty Goods Tracking" (item button)
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.20 DDR 06/06/2008 Certification rules
    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    //                     12/08/2008 Certification Rules
    //                                  Rename Standards -> Quality Standards (Item button)
    //                                Added menu "Quality Item Test History" (Item button)
    // DITW15.00.00.24 DDR 22/09/2008 Added menu button Sales\Specifications - Tariffs
    //                                Added menu button Sales\Internal Tax Charges
    // DITW15.00.00.35 DDR 24/06/2009 Added fields
    //                                  "Gen. Bus. Posting Free Group","Free Item Posting Type","Free item"
    //                                  "Location Code"
    //                     13/10/2009 issue 722 Added flowfield "As Empty Good"
    // DITW15.00.00.38 DDR 14/10/2010 issue 1139 SSCC Functionnalities
    //                                  Added menu 'SSCC Entries' into 'Item\Entries' menu button
    //                                  Modified Caption menu 'SSCC Tracking Entries' + call function
    // DITW16.00.00.38 DDR 04/03/2011 DIT-715 #65 RTC Upgrade & Performances
    //                                  Added menu to synchronize with the card
    //                                   Functions\ Packing list
    // DITW15.00.00.39 DDR 09/05/2011 issue 1328 Shop (iPos) Functionnalities
    //                                  Added fields "Pos System","Pos System Timestamp"
    //                                  Added menu "SOM Synchronize" into 'Item' button
    // DITW15.00.00.39 DDR 26/08/2011 issue 1393 Added fields "Treeview Code","Belongs Item No."
    //                     29/08/2011 issue 1396 Added fields "No. of Exclusivity Groups" into 'Drink-it' tab
    //                                           Added 'Exclusivity Groups' menu into 'Item' button
    //                                           Added 'Item Exclusivity' menu into 'Sales','Purchases' button
    // DITW16.00.00.40 PRODW14.00.00.08.19 DDR 20/12/2011 issue 1466 Added menu 'Sales\Quality Standards'
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added fields "Allow VAT Calculation (Free)" into 'Drink-it' tab
    //                     16/04/2012 DIT-715 #247 Sponsoring & Events functionnality
    //                                 Added fields "Reverse Location Code"
    //                     18/04/2012 DIT-715 #243 Loyalty functionnality
    //                                  Added fields "No. of Loyalty Groups" into 'Drink-it' tab
    //                                  Added 'Item Loyalty Statistics' menu into 'Customer' button
    //                                  Added 'Loyalty Groups' menu into 'Item' button
    //                                  Added 'Loyalty Items' menu into 'Sales' button
    //                                  Moved menu "SOM Synchronize" into 'Functions' button
    //                     13/06/2012 DIT-715 #338 Added 'Period (Items)' menu into button 'Item\Item Item Availability by'
    //                                             Added 'Items by Period' into button 'Item'
    // DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                  Added 'Component' menu button

    // FINXL7.00.001 DAT 07/04/2014 : Added Action "Item Properties"
    // FINXL7.00.001 KLU 27/06/2014 #42: Added menuitem "Recycle Charges"

    // MANXL7.00.001 DAT 03/03/2014 #12: Added new menu-item to open the Item Minor Revision
    // FINXL7.00.001 KLU 27/06/2014 #42: Added menuitem "Recycle Charges"
    // FINXL8.00.001 BSA 27/05/2015 #186: Added Field "No. 2"

    // DITW17.00.02 DDR 09/08/2013 DIT-770 #102 Added 'Tax Groups' Action into 'Relation' button
    // DITW17.00.02 RPG 05/11/2013 DIT-770 #235 Added Field "Description 2"
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #623 New Customer Exception Tax Group functionality
    //                                          Added menu to "Customer Exception Tax Groups"
    // DITW17.10.03 DDR 13/06/14 DIT-770 #392 Item Quota Management Functionality
    //                                        Added menu "Quota Group","Item Quota Group"
    //                                        Added field "No. of Quota Groups"
    // DITW18.00.06 MSF 16/02/2015 DIT-770 #1185 Added Actions to calculate Stdandard cost for SKUs
    //                  20/02/2015 DIT-770 #1185 Modify caption Calculate std cost
    // DITW18.00.06 MSF 09/03/2015 DIT-770 #1186 Change caption uncluding SKU --> SKU Only
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.07 AKH 07/01/2016 DIT-770 #1806 Added fields: Inventory, "Qty. on Sales Order" (Visible FALSE)
    // DITW18.00.07 AKH 16/03/2016 DIT-770 #1806 Added fields: "Qty. on Assembly Order", "Qty. on Asm. Component" (Visible FALSE)
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW19.00.07 MSF 04/07/2016 DIT-770 #1965  Item and Item list/ customer and Customer List - navigate ribbon
    //                                            Check And fix  Ribbon
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) Added fields "Item DDeposit Group Code","Item DTax Group Code"
    //                                                      Look&Feel minor correction
    // DITW19.00.08 DDR 29/09/2016 BL#10443 Look&Feel minor correction (application worksheet bad ribbon group)

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL10.00 AKH 20/01/2017 Set property VISBLE to FALSE for actions Attributes, FilterByAttributes & ClearAttributes
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Added new fields "Backorder Type" and "Qty. on Sales Blanket Order"
    // DITW110.00.12A ISL 21/06/2018 NRQ#67425 Added new fields  "Free Item (Purchase)"
    //                                                           "Free Reason Code (Purchase)"
    // HEI.01 FDD PRDGAP038 IBM COSTES02 07.08.2017 Added new fields : Quantity Quality Hold,Quantity Unrestricted (Pass),Quantity Blocked (Fail)
    // HEI.02 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
    //   # New Field added: "Available Inv. (Whse)"
    // HEI.03 CHG2056363 IBM.AK new page-Sales Inventory attached in Actions to show Item Fields.
    // HEI.04 IBM.AK CHG2072471 28.12.2020
    // # Added Report in page Actions(Action group 79) with name Quality-->R50018
    // Hei.05 IBM.AK CHG2126968 10-01-2022
    // #Added 3 new fields Strength Specific Code, Strength Specific Value, Strength Method
    // HEI.06 CHG2147859 SAHAL01 22.07.2022
    //   # Added New Fields - Item Interface Code for Astro
    //                      - Item Parked for Astro
    //                      - Last Parked Date for Astro
    //                      - Last Parked Time for Astro
    //   # Added Code to visible Astro Fields

    layout
    {
        //BC Upgrade KAMNAY01>> The control 'Item' is not found in the target 'Item List'
        // modify(Item)
        // {
        //     CaptionML = ENU='Item',FRA='Article';

        //     //Unsupported feature: Change FreezeColumnID on "Item(Control 1)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<< The control 'Item' is not found in the target 'Item List'


        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item.', FRA = 'Spécifie le numéro de l''article.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the item.', FRA = 'Spécifie une description de l''élément.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies if the item card represents a physical item (Inventory) or a service (Service).', FRA = 'Spécifie si la fiche article représente un article physique (Stock) ou un service (Service).';
        }
        //BC Upgrade KAMNAY01>> The control 'Inventory' is not found in the target 'Item List'
        // modify(Inventory)
        // {
        //     ToolTipML = ENU='Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.',FRA='Spécifie le nombre d''unités (par exemple des pièces, des boîtes ou des palettes) en stock.';
        // }
        //BC Upgrade KAMNAY01<< The control 'Inventory' is not found in the target 'Item List'
        modify("Substitutes Exist")
        {
            ToolTipML = ENU = 'Specifies that a substitute exists for this item.', FRA = 'Spécifie qu''un substitut existe pour cet article.';

            //Unsupported feature: Change Visible on ""Substitutes Exist"(Control 97)". Please convert manually.

        }
        modify("Base Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit in which the item is held in inventory.', FRA = 'Spécifie l''unité dans laquelle l''article est stocké.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the cost per unit of the item.', FRA = 'Spécifie le coût par unité de l''article.';
        }
        modify("Unit Price")
        {
            ToolTipML = ENU = 'Specifies the price for one unit of the item, in LCY.', FRA = 'Spécifie le prix unitaire, en DS, de l''article.';
        }
        modify("Tariff No.")
        {
            ToolTipML = ENU = 'Specifies a code for the item''s tariff number.', FRA = 'Spécifie un code pour la nomenclature produit de l''article.';
        }
        modify("Default Deferral Template Code")
        {
            CaptionML = ENU = 'Default Deferral Template', FRA = 'Modèle échelonnement par défaut';
            ToolTipML = ENU = 'Specifies the default template that governs how to defer revenues and expenses to the periods when they occurred.', FRA = 'Spécifie le modèle par défaut qui régit la manière de reporter les revenus et les dépenses aux périodes auxquelles ils se sont produits.';
        }
        moveafter("No."; "No. 2") //BC Version 28.0 Compatibility Fix
        modify("No. 2") //BC Version 28.0 Compatibility Fix
        {
            Visible = true;
            ToolTip = 'Specifies the alternative number of the item.';
        }
        // addafter("No.")
        // {
        //     field("No. 2"; Rec."No. 2") //BC Version 28.0 Compatibility Fix
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the alternative number of the item.';
        //     }
        // }
        //BC Upgrade KAMNAY01>> A member of type Field with name 'Description 2' is already defined in Page 'Item List' by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
        // addafter(Description)
        // {
        //     field("Description 2";Rec."Description 2")
        //     {
        //         Visible = false;
        //     }
        // }
        //BC Upgrade KAMNAY01<< A member of type Field with name 'Description 2' is already defined in Page 'Item List' by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
        addafter("Vendor No.")
        {
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies how many units of the item are allocated to sales orders, meaning listed on outstanding sales orders lines.';
            }
            //BC Upgrade KAMNAY01>> Added new field
            field("Production Unit of Measure"; Rec."Production Unit of Measure FND")
            {
                ApplicationArea = All;
            }
            //BC Upgrade KAMNAY01<< Added new fields
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies how many units of the item are inbound on purchase orders, meaning listed on outstanding purchase order lines.';
            }
            field("Qty. in Transit"; Rec."Qty. in Transit")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of the items that are currently in transit.';
            }
            field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies how many units of the item are allocated to production orders, meaning listed on outstanding production order lines.';
            }
            field("Qty. on Component Lines"; Rec."Qty. on Component Lines")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies how many units of the item are allocated as production order components, meaning listed under outstanding production order lines.';
            }
            field("Qty. on Assembly Order"; Rec."Qty. on Assembly Order")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Qty. on Assembly Order field.';
            }
            field("Qty. on Asm. Component"; Rec."Qty. on Asm. Component")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Qty. on Asm. Component field.';
            }
            //BC Upgrade KAMNAY01>> DITW fields
            // field("Qty. on Sales Blanket Order";Rec."Qty. on Sales Blanket Order")
            // {
            //     Visible = false;
            // }
            //BC Upgrade KAMNAY01<< DITW fields
        }
        //BC Upgrade KAMNAY01>> DITW fields
        // addafter("Search Description")
        // {
        //     field("Treeview Code";Rec."Treeview Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Belongs Item No.";Rec."Belongs Item No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Empty Good";Rec."Empty Good")
        //     {
        //     }
        //     field("Location Code";Rec."Location Code")
        //     {
        //     }
        //     field("Reverse Location Code";Rec."Reverse Location Code")
        //     {
        //     }
        //     field("Gen. Prod. Posting Free Group";Rec."Gen. Prod. Posting Free Group")
        //     {
        //         Visible = false;
        //     }
        //     field("Free Item Posting Type";Rec."Free Item Posting Type")
        //     {
        //         Visible = false;
        //     }
        //     field("Free Item";Rec."Free Item")
        //     {
        //     }
        //     field("Allow VAT Calculation (Free)";Rec."Allow VAT Calculation (Free)")
        //     {
        //         Visible = false;
        //     }
        //     field("Gift Box Item";Rec."Gift Box Item")
        //     {
        //     }
        // }
        //BC Upgrade KAMNAY01<< DITW fields
        addafter("Default Deferral Template Code")
        {
            //BC Upgrade KAMNAY01>> DITW fields
            // field("Item DTax Group Code";Rec."Item DTax Group Code")
            // {
            //     Visible = false;
            // }
            // field("Item DDeposit Group Code";Rec."Item DDeposit Group Code")
            // {
            //     Visible = false;
            // }
            // field("Pos System";Rec."Pos System")
            // {
            //     Visible = false;
            // }
            // field("Pos System Timestamp";Rec."Pos System Timestamp")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 1 Code";"Shortcut Property 1 Code")
            // {
            //     Description = 'FinXL7.00.00';
            //     Visible = false;
            // }
            // field("Shortcut Property 2 Code";"Shortcut Property 2 Code")
            // {
            //     Description = 'FinXL7.00.00';
            //     Visible = false;
            // }
            // field("Shortcut Property 3 Code";"Shortcut Property 3 Code")
            // {
            //     Description = 'FinXL7.00.00';
            //     Visible = false;
            // }
            // field("Shortcut Property 4 Code";"Shortcut Property 4 Code")
            // {
            //     Description = 'FinXL7.00.00';
            //     Visible = false;
            // }
            // field("Shortcut Property 5 Code";"Shortcut Property 5 Code")
            // {
            //     Description = 'FinXL7.00.00';
            //     Visible = false;
            // }
            // field("Shortcut Property 6 Code";"Shortcut Property 6 Code")
            // {
            //     Description = 'FinXL7.00.00';
            //     Visible = false;
            // }
            // field("Shortcut Property 7 Code";"Shortcut Property 7 Code")
            // {
            //     Description = 'FinXL7.00.00';
            //     Visible = false;
            // }
            // field("Shortcut Property 8 Code";"Shortcut Property 8 Code")
            // {
            //     Description = 'FinXL7.00.00';
            //     Visible = false;
            // }
            // field("Shortcut Property 9 Code";"Shortcut Property 9 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 10 Code";"Shortcut Property 10 Code")
            // {
            //     Description = 'FinXL7.00.00';
            //     Visible = false;
            // }
            // field("Backorder Type";Rec."Backorder Type")
            // {
            //     OptionCaption = '" ,Backorder,No Backorder"';
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
            //BC Upgrade KAMNAY01>> DITW fields
            // field("Free Item (Purchase)";"Free Item (Purchase)")
            // {
            //     Description = 'DITW110.00.12A NRQ#67425';
            //     Visible = false;
            // }
            // field("Free Reason Code (Purchase)";"Free Reason Code (Purchase)")
            // {
            //     Description = 'DITW110.00.12A NRQ#67425';
            //     Visible = false;
            // }
            //BC Upgrade KAMNAY01<< DITW fields
            field("Item Type"; Rec."Item Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type field.';
            }
            field("RPM Solution"; Rec."RPM Solution FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RPM Solution field.';
            }
            field("RPM Type"; Rec."RPM Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RPM Type field.';
            }
            field("Available Inv. (Whse)"; Rec."Available Inv. (Whse) FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Available Inv. (Whse) field.';
            }
            field("Inventory Value Zero"; Rec."Inventory Value Zero")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the item on inventory must be excluded from inventory valuation. This is relevant if the item is kept on inventory on someone else''s behalf.';
            }
            //BC Upgrade KAMNAY01>> DITW fields
            // field("Strength Method";Rec."Strength Method")
            // {
            // }
            // field("Strength Spec. Code";Rec."Strength Spec. Code")
            // {
            // }
            // field("Strength Spec. Value";Rec."Strength Spec. Value")
            // {
            // }
            //BC Upgrade KAMNAY01<< DITW fields

            //BC Upgrade KAMNAY01>> Astro Fields 
            // field("Item Interface Code for Astro"; Rec."Item Interface Code for Astro")
            // {
            //     Visible = VisibleAstro;
            // }
            // field("Item Parked for Astro"; Rec."Item Parked for Astro")
            // {
            //     Visible = VisibleAstro;
            // }
            // field("Last Parked Date for Astro"; Rec."Last Parked Date for Astro")
            // {
            //     Visible = VisibleAstro;
            // }
            // field("Last Parked Time for Astro"; Rec."Last Parked Time for Astro")
            // {
            //     Visible = VisibleAstro;
            // }
            //BC Upgrade KAMNAY01<< Astro Fields 
        }
    }
    actions
    {//BC Upgrade KAMNAY01>> The control 'Item' is not found in the target 'Item List'
        // modify(Item)
        // {
        //     CaptionML = ENU='Item',FRA='Article';
        // }
        //BC Upgrade KAMNAY01<< The control 'Item' is not found in the target 'Item List'
        modify("&Units of Measure")
        {
            CaptionML = ENU = '&Units of Measure', FRA = '&Unités';
            ToolTipML = ENU = 'Set up the different units that the selected item can be traded in, such as piece, box, or hour.', FRA = 'Configurez les différentes unités dans lesquelles l''article sélectionné peut être négocié, par exemple pièce, boîte ou heure.';
        }
        modify(Attributes)
        {
            CaptionML = ENU = 'Attributes', FRA = 'Attributs';
            ToolTipML = ENU = 'View or edit the item''s attributes, such as color, size, or other characteristics that help to describe the item.', FRA = 'Affichez ou modifiez les attributs de l''article, tels que la couleur, la taille ou d''autres caractéristiques permettant de le décrire.';

            //Unsupported feature: Change Visible on "Attributes(Action 137)". Please convert manually.

        }
        modify(FilterByAttributes)
        {
            CaptionML = ENU = 'Filter by Attributes', FRA = 'Filtrer par attributs';
            ToolTipML = ENU = 'Find items that match specific attributes.', FRA = 'Recherchez des articles qui correspondent aux attributs spécifiques.';

            //Unsupported feature: Change Visible on "FilterByAttributes(Action 138)". Please convert manually.

        }
        modify(ClearAttributes)
        {
            CaptionML = ENU = 'Clear Attributes Filter', FRA = 'Effacer le filtre d''attributs';
            ToolTipML = ENU = 'Remove the filter for specific item attributes.', FRA = 'Supprimez le filtre pour les attributs article spécifiques.';

            //Unsupported feature: Change Visible on "ClearAttributes(Action 139)". Please convert manually.

        }
        modify("Va&riants")
        {
            CaptionML = ENU = 'Va&riants', FRA = '&Variantes';
        }
        modify("Substituti&ons")
        {
            CaptionML = ENU = 'Substituti&ons', FRA = 'Articles de su&bstitution';
        }
        modify(Identifiers)
        {
            CaptionML = ENU = 'Identifiers', FRA = 'Identifiants';
        }
        //BC Upgrade KAMNAY01>> The action '"Cross Re&ferences"' is not found in the target 'Item List'
        // modify("Cross Re&ferences")
        // {
        //     CaptionML = ENU = 'Cross Re&ferences', FRA = '&Références externes';
        //     ToolTipML = ENU = 'Set up a customer''s or vendor''s own identification of the selected item. Cross-references to the customer''s item number means that the item number is automatically shown on sales documents instead of the number that you use.', FRA = 'Configurez la manière dont un client ou un fournisseur identifie l''article sélectionné. Les références externes au numéro d''article du client impliquent que le numéro d''article est automatiquement affiché sur les documents vente au lieu du numéro que vous utilisez.';
        // }
        //BC Upgrade KAMNAY01<< The action '"Cross Re&ferences"' is not found in the target 'Item List'
        modify("E&xtended Texts")
        {
            CaptionML = ENU = 'E&xtended Texts', FRA = 'Te&xtes étendus';
            ToolTipML = ENU = 'Set up additional text for the description of the selected item. Extended text can be inserted under the Description field on document lines for the item.', FRA = 'Définissez un texte supplémentaire pour la description de l''article sélectionné. Un texte plus long peut être inséré sous le champ Description sur les lignes document de l''article.';
        }
        modify(Translations)
        {
            CaptionML = ENU = 'Translations', FRA = 'Traductions';
            ToolTipML = ENU = 'Set up translated item descriptions for the selected item. Translated item descriptions are automatically inserted on documents according to the language code.', FRA = 'Configurez des descriptions traduites pour l''article sélectionné. Les descriptions d''articles traduites sont automatiquement insérées dans les documents en fonction du code de langue.';
        }
        modify(AdjustInventory)
        {
            CaptionML = ENU = 'Adjust Inventory', FRA = 'Ajuster stock';
            ToolTipML = ENU = 'Increase or decrease the item''s inventory quantity manually by entering a new quantity. Adjusting the inventory quantity manually may be relevant after a physical count or if you do not record purchased quantities.', FRA = 'Vous pouvez augmenter ou diminuer manuellement la quantité en stock d''un article en entrant une nouvelle quantité. Il peut s''avérer utile d''ajuster manuellement la quantité d''inventaire après un décompte physique ou si vous n''enregistrez pas les quantités achetées.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
        }
        //BC Upgrade KAMNAY01>> The action 'Dimensions-Single' AND "Dimensions-&Multiple" is not found in the target 'Item List'
        // modify("Dimensions-Single")
        // {
        //     CaptionML = ENU = 'Dimensions-Single', FRA = 'Affectations - Simples';
        // }
        // modify("Dimensions-&Multiple")
        // {
        //     CaptionML = ENU = 'Dimensions-&Multiple', FRA = 'Affectations - &Multiples';
        // }
        //BC Upgrade KAMNAY01<< The action 'Dimensions-Single' AND "Dimensions-&Multiple" is not found in the target 'Item List'
        modify(History)
        {
            CaptionML = ENU = 'History', FRA = 'Historique';
        }
        modify("E&ntries")
        {
            CaptionML = ENU = 'E&ntries', FRA = 'É&critures';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the history of positive and negative inventory changes that reflect transactions with the selected item.', FRA = 'Affichez l''historique des modifications de stock positives et négatives qui reflètent les transactions avec l''article sélectionné.';
        }
        modify("&Phys. Inventory Ledger Entries")
        {
            CaptionML = ENU = '&Phys. Inventory Ledger Entries', FRA = 'Écritures comptables &inventaire';
        }
        modify(PricesandDiscounts)
        {
            CaptionML = ENU = 'Prices and Discounts', FRA = 'Prix et remises';
        }
        // modify("Prices_Prices")
        // {
        //     CaptionML = ENU = 'Special Prices', FRA = 'Prix spéciaux';
        //     ToolTipML = ENU = 'Set up different prices for the selected item. An item price is automatically used on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', FRA = 'Configurez des prix différents pour l''article sélectionné. Un prix article est automatiquement utilisé sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin.';
        // }
        // modify("Prices_LineDiscounts")
        // {
        //     CaptionML = ENU = 'Special Discounts', FRA = 'Remises spéciales';
        //     ToolTipML = ENU = 'Set up different discounts for the selected item. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', FRA = 'Configurez des remises différentes pour l''article sélectionné. Une remise article est automatiquement affectée sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin.';
        // }
        // modify(PricesDiscountsOverview)
        // {
        //     CaptionML = ENU = 'Special Prices & Discounts Overview', FRA = 'Aperçu des prix et remises spéciaux';
        // }
        // modify("Sales Price Worksheet")
        // {
        //     CaptionML = ENU = 'Sales Price Worksheet', FRA = 'Feuille prix vente';
        // }
        //BC Upgrade KAMNAY01>> The action 'Periodic Activities' is not found in the target 'Item List'
        // modify("Periodic Activities")
        // {
        //     CaptionML = ENU = 'Periodic Activities', FRA = 'Traitements';
        // }
        //BC Upgrade KAMNAY01<< The action 'Periodic Activities' is not found in the target 'Item List'
        modify("Adjust Cost - Item Entries")
        {
            CaptionML = ENU = 'Adjust Cost - Item Entries', FRA = 'Ajuster coûts : Écr. article';
            ToolTipML = ENU = 'Adjust inventory values in value entries so that you use the correct adjusted cost for updating the general ledger and so that sales and profit statistics are up to date.', FRA = 'Ajustez les valeurs de stocks des écritures valeur afin que vous utilisiez le coût ajusté correct pour la mise à jour de la comptabilité et que les statistiques vente et profit soient à jour.';
        }
        modify("Post Inventory Cost to G/L")
        {
            CaptionML = ENU = 'Post Inventory Cost to G/L', FRA = 'Valider coûts ajustés';
            ToolTipML = ENU = 'Post the quantity and value changes to the inventory in the item ledger entries and the value entries when you post inventory transactions, such as sales shipments or purchase receipts.', FRA = 'Validez les changements de quantité et de valeur en stock dans les écritures comptables article et les écritures valeur lorsque vous validez des mouvements de stocks, tels que des expéditions vente ou des réceptions achat.';
        }
        modify("Physical Inventory Journal")
        {
            CaptionML = ENU = 'Physical Inventory Journal', FRA = 'Feuille inventaire phys.';
            ToolTipML = ENU = 'Select how you want to maintain an up-to-date record of your inventory at different locations.', FRA = 'Sélectionnez comment vous souhaitez conserver un enregistrement mis à jour du stock dans différents magasins.';
        }
        modify("Revaluation Journal")
        {
            CaptionML = ENU = 'Revaluation Journal', FRA = 'Feuille réévaluation';
            ToolTipML = ENU = 'View or edit the inventory value of items, which you can change, such as after doing a physical inventory.', FRA = 'Affichez ou modifiez la valeur stock des articles, que vous pouvez modifier, par exemple, après avoir effectué un inventaire.';
        }
        //BC Upgrade KAMNAY01>> The action 'Approval' is not found in the target 'Item List'
        // modify("Request Approval")
        // {
        //     CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
        // }
        //BC Upgrade KAMNAY01<< The action 'Approval' is not found in the target 'Item List'
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
        //BC Upgrade KAMNAY01>> The action 'Functions' is not found in the target 'Item List'
        // modify("F&unctions")
        // {
        //     CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        // }
        //BC Upgrade KAMNAY01<< The action 'Functions' is not found in the target 'Item List'
        modify("&Create Stockkeeping Unit")
        {
            CaptionML = ENU = '&Create Stockkeeping Unit', FRA = '&Créer point de stock';
        }
        modify("C&alculate Counting Period")
        {
            CaptionML = ENU = 'C&alculate Counting Period', FRA = 'C&alculer période d''inventaire';
        }
        modify("Requisition Worksheet")
        {
            CaptionML = ENU = 'Requisition Worksheet', FRA = 'Demande achat';
        }
        modify("Item Journal")
        {
            CaptionML = ENU = 'Item Journal', FRA = 'Feuille article';
        }
        modify("Item Reclassification Journal")
        {
            CaptionML = ENU = 'Item Reclassification Journal', FRA = 'Feuille reclassement article';
        }
        modify("Item Tracing")
        {
            CaptionML = ENU = 'Item Tracing', FRA = 'Traçabilité';
        }
        modify("Adjust Item Cost/Price")
        {
            CaptionML = ENU = 'Adjust Item Cost/Price', FRA = 'Ajuster coût et prix article';
        }
        //BC Upgrade KAMNAY01>> The action '"ActionGroup127"' is not found in the target 'Item List'
        // modify(ActionGroup127)
        // {
        //     CaptionML = ENU = 'Assembly/Production', FRA = 'Assemblage/Production';
        // }
        //BC Upgrade KAMNAY01<< The action  'ActionGroup127' is not found in the target 'Item List'
        modify("Assemble to Order - Sales")
        {
            CaptionML = ENU = 'Assemble to Order - Sales', FRA = 'Assemblage à la commande - Ventes';
        }
        modify("Where-Used (Top Level)")
        {
            CaptionML = ENU = 'Where-Used (Top Level)', FRA = 'Cas d''emploi (multi-niveau)';
        }
        modify("Quantity Explosion of BOM")
        {
            CaptionML = ENU = 'Quantity Explosion of BOM', FRA = 'Nomenclature multi-niveau';
        }
        modify(Costing)
        {
            CaptionML = ENU = 'Costing', FRA = 'Evaluation stock';
        }
        modify("Inventory Valuation - WIP")
        {
            CaptionML = ENU = 'Inventory Valuation - WIP', FRA = 'Évaluation du stock d''en-cours';
        }
        modify("Cost Shares Breakdown")
        {
            CaptionML = ENU = 'Cost Shares Breakdown', FRA = 'Analyse des coûts';
        }
        modify("Detailed Calculation")
        {
            CaptionML = ENU = 'Detailed Calculation', FRA = 'Coût détaillé';
        }
        modify("Rolled-up Cost Shares")
        {
            CaptionML = ENU = 'Rolled-up Cost Shares', FRA = 'Coût multi-niveau détaillé';
        }
        modify("Single-Level Cost Shares")
        {
            CaptionML = ENU = 'Single-Level Cost Shares', FRA = 'Coût mono-niveau détaillé';
        }
        modify(Inventory)
        {
            CaptionML = ENU = 'Inventory', FRA = 'Stocks';
        }
        modify("Inventory - List")
        {
            CaptionML = ENU = 'Inventory - List', FRA = 'Stocks : Liste des articles';
        }
        modify("Inventory - Availability Plan")
        {
            CaptionML = ENU = 'Inventory - Availability Plan', FRA = 'Stocks : Échéancier des dispo.';
        }
        modify("Item/Vendor Catalog")
        {
            CaptionML = ENU = 'Item/Vendor Catalog', FRA = 'Articles : Catalogue fourn.';
        }
        modify("Phys. Inventory List")
        {
            CaptionML = ENU = 'Phys. Inventory List', FRA = 'Liste d''inventaire';
        }
        //BC Upgrade KAMNAY01>> The action '"Nonstock Item Sales"' is not found in the target 'Item List'
        // modify("Nonstock Item Sales")
        // {
        //     CaptionML = ENU = 'Nonstock Item Sales', FRA = 'Ventes d''articles non stockés';
        // }
        //BC Upgrade KAMNAY01<< The action '"Nonstock Item Sales"' is not found in the target 'Item List'
        modify("Item Substitutions")
        {
            CaptionML = ENU = 'Item Substitutions', FRA = 'Articles de substitution';
            ToolTipML = ENU = 'View or edit any substitute items that are set up to be traded instead of the item in case it is not available.', FRA = 'Affichez ou modifiez les articles de substitution qui sont configurés pour être négociés à la place de l''article, s''il n''est pas disponible.';
        }
        // modify("Price List")
        // {
        //     CaptionML = ENU = 'Price List', FRA = 'Liste des prix';
        //     ToolTipML = ENU = 'View, print, or save a list of your items and their prices, for example, to send to customers. You can create the list for specific customers, campaigns, currencies, or other criteria.', FRA = 'Affichez, imprimez ou enregistrez une liste de vos articles ainsi que leur prix, par exemple, pour envoyer aux clients. Vous pouvez créer la liste pour des clients, des campagnes ou des devises spécifiques ou encore pour d''autres critères.';
        // }BCUPG Action 'Price List' is marked for removal. Reason: Replaced by the Item Price List report. Tag: 19.0.
        modify("Inventory Cost and Price List")
        {
            CaptionML = ENU = 'Inventory Cost and Price List', FRA = 'Prix et coûts article';
            ToolTipML = ENU = 'View, print, or save a list of your items and their price and cost information. The report specifies direct unit cost, last direct cost, unit price, profit percentage, and profit.', FRA = 'Affichez, imprimez ou enregistrez une liste de vos articles, ainsi que leur prix et des informations sur leur coût. L''état spécifie le coût unitaire direct, le dernier coût direct, le prix unitaire, le pourcentage de marge et la marge.';
        }
        modify("Inventory Availability")
        {
            CaptionML = ENU = 'Inventory Availability', FRA = 'Disponibilité articles';
            ToolTipML = ENU = 'View, print, or save a summary of historical inventory transactions with selected items, for example, to decide when to purchase the items. The report specifies quantity on sales order, quantity on purchase order, back orders from vendors, minimum inventory, and whether there are reorders.', FRA = 'Affichez, imprimez ou enregistrez un résumé des mouvements de stock historiques avec les articles sélectionnés, par exemple, pour décider quand acheter les articles. L''état spécifie la quantité sur commande vente, la quantité sur commande achat, les commandes à livrer des fournisseurs, le stock minimal et la présence éventuelle de réapprovisionnements.';
        }
        modify("Item Register")
        {
            CaptionML = ENU = 'Item Register', FRA = 'Historique des transactions article';
        }
        modify("Item Register - Quantity")
        {
            CaptionML = ENU = 'Item Register - Quantity', FRA = 'Hist trans article - Qté';
        }
        modify("Item Register - Value")
        {
            CaptionML = ENU = 'Item Register - Value', FRA = 'Transactions article : Valeur';
        }
        //BC Upgrade KAMNAY01>> The action 'ActionGroup130' is not found in the target 'Item List'
        // modify(ActionGroup130)
        // {
        //     CaptionML = ENU = 'Costing', FRA = 'Evaluation stock';
        // }
        //BC Upgrade KAMNAY01<< The action 'ActionGroup130' is not found in the target 'Item List'
        modify("Inventory - Cost Variance")
        {
            CaptionML = ENU = 'Inventory - Cost Variance', FRA = 'Stocks : Évolution des coûts';
        }
        modify("Invt. Valuation - Cost Spec.")
        {
            CaptionML = ENU = 'Invt. Valuation - Cost Spec.', FRA = 'Éval. stock : Composante coût';
        }
        // modify("Compare List")
        // {
        //     CaptionML = ENU = 'Compare List', FRA = 'Liste de comparaison';
        // }BCUPG Action 'Compare List' is marked for removal. Reason: This report has been replaced by the "Compare Production Cost Shares" report and will be removed in a future release.. Tag: 27.0.
        modify("Inventory Details")
        {
            CaptionML = ENU = 'Inventory Details', FRA = 'Détails stock';
        }
        modify("Inventory - Transaction Detail")
        {
            CaptionML = ENU = 'Inventory - Transaction Detail', FRA = 'Stocks : Liste des mouvements';
        }
        modify("Item Charges - Specification")
        {
            CaptionML = ENU = 'Item Charges - Specification', FRA = 'Frais annexes : Composante';
        }
        //BC Upgrade KAMNAY01>> The action 'Item Age Composition - Qty.' is not found in the target 'Item List'
        // modify("Item Age Composition - Qty.")
        // {
        //     CaptionML = ENU = 'Item Age Composition - Qty.', FRA = 'Ancienneté stock : Qté';
        //     ToolTipML = ENU = 'View, print, or save an overview of the current age composition of selected items in your inventory.', FRA = 'Affichez, imprimez ou enregistrez un aperçu de l''ancienneté des articles sélectionnés dans votre stock.';
        // }
        //BC Upgrade KAMNAY01<< The action 'Item Age Composition - Qty.' is not found in the target 'Item List'
        modify("Item Expiration - Quantity")
        {
            CaptionML = ENU = 'Item Expiration - Quantity', FRA = 'Péremption article - Quantité';
        }
        modify(Reports)
        {
            CaptionML = ENU = 'Inventory Statistics', FRA = 'Statistiques stock';
        }
        modify("Inventory - Sales Statistics")
        {
            CaptionML = ENU = 'Inventory - Sales Statistics', FRA = 'Stocks : Statistiques vente';
            ToolTipML = ENU = 'View, print, or save a summary of selected items'' sales per customer, for example, to analyze the profit on individual items or trends in revenues and profit. The report specifies direct unit cost, unit price, sales quantity, sales in LCY, profit percentage, and profit.', FRA = 'Affichez, imprimez ou enregistrez un résumé des ventes d''articles sélectionnés par client, par exemple, pour analyser la marge sur des articles spécifiques ou les tendances en termes de revenus et de marge. L''état spécifie le coût unitaire direct, le prix unitaire, la quantité vendue, les ventes en devise société, le pourcentage de marge et la marge.';
        }
        modify("Inventory - Customer Sales")
        {
            CaptionML = ENU = 'Inventory - Customer Sales', FRA = 'Stocks : Ventes par client';
            ToolTipML = ENU = 'View, print, or save a list of customers that have purchased selected items within a selected period, for example, to analyze customers'' purchasing patterns. The report specifies quantity, amount, discount, profit percentage, and profit.', FRA = 'Affichez, imprimez ou enregistrez une liste des clients qui ont acheté des articles sélectionnés pendant une période sélectionnée, par exemple, pour analyser les habitudes d''achat des clients. L''état spécifie la quantité, le montant, la remise, le pourcentage de marge et la marge.';
        }
        modify("Inventory - Top 10 List")
        {
            CaptionML = ENU = 'Inventory - Top 10 List', FRA = 'Stocks : Palmarès articles';
            ToolTipML = ENU = 'View, print, or save a list of the top items by sales, quantity on hand, or inventory value. The report includes a bar graph to show you how the items rank.', FRA = 'Affichez, imprimez ou enregistrez une liste des principaux articles par valeur de vente, de quantité disponible ou du stock. Le rapport inclut un graphique à barres pour vous illustrer la manière dont les articles sont classés.';
        }
        modify("Finance Reports")
        {
            CaptionML = ENU = 'Finance Reports', FRA = 'États financiers';
        }
        modify("Inventory Valuation")
        {
            CaptionML = ENU = 'Inventory Valuation', FRA = 'Évaluation du stock';
            ToolTipML = ENU = 'View, print, or save a list of the values of the on-hand quantity of each inventory item.', FRA = 'Affichez, imprimez ou enregistrez une liste des valeurs de la quantité disponible de chaque article en stock.';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            ToolTipML = ENU = 'View, print, or save the status of partially filled or unfilled orders so you can determine what effect filling these orders may have on your inventory.', FRA = 'Affichez, imprimez ou enregistrez le statut des commandes partiellement satisfaites ou insatisfaites afin que vous puissiez déterminer quel effet la satisfaction de ces commandes peut avoir sur votre stock.';
        }
        modify("Item Age Composition - Value")
        {
            CaptionML = ENU = 'Item Age Composition - Value', FRA = 'Ancienneté stock : Valeur';
            ToolTipML = ENU = 'View, print, or save an overview of the current age composition of selected items in your inventory.', FRA = 'Affichez, imprimez ou enregistrez un aperçu de l''ancienneté des articles sélectionnés dans votre stock.';
        }
        modify(Orders)
        {
            CaptionML = ENU = 'Orders', FRA = 'Commandes';
        }
        modify("Inventory Order Details")
        {
            CaptionML = ENU = 'Inventory Order Details', FRA = 'Commandes vente en cours';
        }
        modify("Inventory Purchase Orders")
        {
            CaptionML = ENU = 'Inventory Purchase Orders', FRA = 'Commandes achat en cours';
        }
        modify("Inventory - Vendor Purchases")
        {
            CaptionML = ENU = 'Inventory - Vendor Purchases', FRA = 'Stocks : Achats par fourn.';
        }
        modify("Inventory - Reorders")
        {
            CaptionML = ENU = 'Inventory - Reorders', FRA = 'Stocks : Réappro. à effectuer';
        }
        modify("Inventory - Sales Back Orders")
        {
            CaptionML = ENU = 'Inventory - Sales Back Orders', FRA = 'Stocks : Commandes à livrer';
        }
        //BC Upgrade KAMNAY01>> The action 'ActionGroup126' is not found in the target 'Item List'
        // modify(ActionGroup126)
        // {
        //     CaptionML = ENU = 'Item', FRA = 'Article';
        // }
        //BC Upgrade KAMNAY01<< The action 'ActionGroup126' is not found in the target 'Item List'
        modify(ApprovalEntries)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify(Availability)
        {
            CaptionML = ENU = 'Availability', FRA = 'Disponibilité';
        }
        modify("Items b&y Location")
        {
            CaptionML = ENU = 'Items b&y Location', FRA = 'Articles &par magasin';
            ToolTipML = ENU = 'Show a list of items grouped by location.', FRA = 'Affichez la liste des articles regroupés par emplacement.';
        }
        modify("&Item Availability by")
        {
            CaptionML = ENU = '&Item Availability by', FRA = 'Disponibi&lité article par';
        }
        modify("<Action5>")
        {
            CaptionML = ENU = 'Event', FRA = 'Événement';
        }
        //BC Upgrade KAMNAY01>>
        // modify(Period)   // modify(Period) 'Period' is an ambiguous reference between 'Period' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Period' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.ALAL0275
        // {
        //     CaptionML = ENU = 'Period', FRA = 'Période';

        //     //Unsupported feature: Change Name on "Period(Action 21)". Please convert manually.

        // }
        // modify(Variant)         // modify(Variant)  'Variant' is an ambiguous reference between 'Variant' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Variant' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.ALAL0275
        // {
        //     CaptionML = ENU = 'Variant', FRA = 'Variante';

        //     //Unsupported feature: Change Name on "Variant(Action 80)". Please convert manually.

        // }
        // modify(Location) // modify(Location) 'Location' is an ambiguous reference between 'Location' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Location' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.ALAL0275
        // {
        //     CaptionML = ENU = 'Location', FRA = 'Magasin';

        //     //Unsupported feature: Change Name on "Location(Action 78)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<<
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
        }
        //BC Upgrade KAMNAY01>> The action 'Timeline' is not found in the target 'Item List'
        // modify(Timeline)
        // {
        //     CaptionML = ENU = 'Timeline', FRA = 'Chronologie';
        // }
        //BC Upgrade KAMNAY01<< The action 'Timeline' is not found in the target 'Item List'
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
        modify("Assembly/Production")
        {
            CaptionML = ENU = 'Assembly/Production', FRA = 'Assemblage/Production';
        }
        modify(Structure)
        {
            CaptionML = ENU = 'Structure', FRA = 'Structure';
        }
        modify("Cost Shares")
        {
            CaptionML = ENU = 'Cost Shares', FRA = 'Coûts totaux';
        }
        //BC Upgrade KAMNAY01>> The action 'Assemb&ly' is not found in the target 'Item List'
        // modify("Assemb&ly")
        // {
        //     CaptionML = ENU = 'Assemb&ly', FRA = 'Assemb&lage';
        // }
        //BC Upgrade KAMNAY01<< The action 'Assemb&ly' is not found in the target 'Item List'
        modify("<Action32>")
        {
            CaptionML = ENU = 'Assembly BOM', FRA = 'Nomenclature d''assemblage';
        }
        //BC Upgrade KAMNAY01>>
        // modify("Where-Used") //'Where-Used' is an ambiguous reference between 'Where-Used' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Where-Used' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'
        // {
        //     CaptionML = ENU = 'Where-Used', FRA = 'Cas d''emploi';

        //     //Unsupported feature: Change Name on ""Where-Used"(Action 47)". Please convert manually.

        // }
        // modify("Calc. Stan&dard Cost")//'Calc. Stan&dard Cost' is an ambiguous reference between 'Calc. Stan&dard Cost' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Calc. Stan&dard Cost' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.
        // {
        //     CaptionML = ENU = 'Calc. Stan&dard Cost ( Excluding SKU )', FRA = 'Calculer coût stan&dard';

        //     //Unsupported feature: Change Name on ""Calc. Stan&dard Cost"(Action 46)". Please convert manually.


        //     //Unsupported feature: Change Description on ""Calc. Stan&dard Cost"(Action 46)". Please convert manually.

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
        modify(Action29)
        {
            CaptionML = ENU = 'Where-Used', FRA = 'Cas d''emploi';
        }
        modify(Action24)
        {
            CaptionML = ENU = 'Calc. Stan&dard Cost', FRA = 'Calculer coût stan&dard';
        }
        modify("&Reservation Entries")
        {
            CaptionML = ENU = '&Reservation Entries', FRA = 'Écritures &réservation';
        }
        modify("&Value Entries")
        {
            CaptionML = ENU = '&Value Entries', FRA = 'Écritures &valeur';
        }
        modify("Item &Tracking Entries")
        {
            CaptionML = ENU = 'Item &Tracking Entries', FRA = '&Ecritures traçabilité';
        }
        //BC Upgrade KAMNAY01>>'Statistics' is an ambiguous reference between 'Statistics' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Statistics' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.
        // modify(Statistics)
        // {
        //     CaptionML = ENU = 'Statistics', FRA = 'Statistiques';

        //     //Unsupported feature: Change Name on "Statistics(Action 85)". Please convert manually.


        //     //Unsupported feature: Change Description on "Statistics(Action 85)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<<'Statistics' is an ambiguous reference between 'Statistics' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Statistics' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.
        modify(Action16)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("Entry Statistics")
        {
            CaptionML = ENU = 'Entry Statistics', FRA = 'Statistiques écritures';
        }
        modify("T&urnover")
        {
            CaptionML = ENU = 'T&urnover', FRA = '&Rotation';
        }
        modify("Prepa&yment Percentages")
        {
            CaptionML = ENU = 'Prepa&yment Percentages', FRA = 'Pourcentages acom&pte';

            //Unsupported feature: Change Name on ""Prepa&yment Percentages"(Action 124)". Please convert manually.

        }
        modify(Action37)
        {
            CaptionML = ENU = 'Orders', FRA = 'Commandes';
        }
        modify("Returns Orders")
        {
            CaptionML = ENU = 'Returns Orders', FRA = 'Retours';
        }
        //BC Upgrade KAMNAY01>> The action '&Purchases' is not found in the target 'Item List'
        // modify("&Purchases")
        // {
        //     CaptionML = ENU = '&Purchases', FRA = 'Ac&hats';
        // }
        //BC Upgrade KAMNAY01<< The action '&Purchases' is not found in the target 'Item List'
        modify("Ven&dors")
        {
            CaptionML = ENU = 'Ven&dors', FRA = '&Fournisseurs';
        }
        /*     modify(Prices)
            {
                CaptionML = ENU = 'Prices', FRA = 'Prix';
            }
            modify("Line Discounts")
            {
                CaptionML = ENU = 'Line Discounts', FRA = 'Remises ligne';
            } */
        modify(Action125)
        {
            CaptionML = ENU = 'Prepa&yment Percentages', FRA = 'Pourcentages acom&pte';

            //Unsupported feature: Change Name on "Action125(Action 125)". Please convert manually.

        }
        modify(Action40)
        {
            CaptionML = ENU = 'Orders', FRA = 'Commandes';
        }
        modify("Return Orders")
        {
            CaptionML = ENU = 'Return Orders', FRA = 'Retours';
        }
        //BC Upgrade KAMNAY01>> The action '"Nonstoc&k Items"' is not found in the target 'Item List'
        // modify("Nonstoc&k Items")
        // {
        //     CaptionML = ENU = 'Nonstoc&k Items', FRA = 'Articles &non stockés';
        // }
        //BC Upgrade KAMNAY01<< The action '"Nonstoc&k Items"' is not found in the target 'Item List'
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        //BC Upgrade KAMNAY01>> '&Bin Contents' is an ambiguous reference between '&Bin Contents' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and '&Bin Contents' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.
        // modify("&Bin Contents")
        // {
        //     CaptionML = ENU = '&Bin Contents', FRA = 'C&ontenu emplacement';

        //     //Unsupported feature: Change Name on ""&Bin Contents"(Action 116)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<< '&Bin Contents' is an ambiguous reference between '&Bin Contents' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and '&Bin Contents' defined by the extension 'BCIBM by Default Publisher (
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

            //Unsupported feature: Change Level on ""Ser&vice Items"(Action 103)". Please convert manually.

            CaptionML = ENU = 'Ser&vice Items', FRA = '&Articles de service';
        }
        //BC Upgrade KAMNAY01>> 'Troubleshooting' is an ambiguous reference between 'Troubleshooting' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)' and 'Troubleshooting' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
        // modify(Troubleshooting)
        // {

        //     //Unsupported feature: Change Level on "Troubleshooting(Action 11)". Please convert manually.

        //     CaptionML = ENU = 'Troubleshooting', FRA = 'Incident';

        //     //Unsupported feature: Change Name on "Troubleshooting(Action 11)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<< 'Troubleshooting' is an ambiguous reference between 'Troubleshooting' defined by the extension 'BCIBM by Default Publisher (
        modify("Troubleshooting Setup")
        {
            CaptionML = ENU = 'Troubleshooting Setup', FRA = 'Paramètres incidents';
        }
        modify(Resources)
        {
            CaptionML = ENU = 'Resources', FRA = 'Ressources';

            //Unsupported feature: Change Description on "Resources(Action 62)". Please convert manually.


            //Unsupported feature: Change Visible on "Resources(Action 62)". Please convert manually.

        }
        //BC Upgrade KAMNAY01>> Cannot use 'R&esource' in Page 'Item List' before it is declared.
        // modify("R&esource")
        // {
        //     CaptionML = ENU = 'R&esource', FRA = 'Re&ssource';

        //     //Unsupported feature: Change Name on ""R&esource"(Action 107)". Please convert manually.

        // }
        //BC Upgrade KAMNAY01<< Cannot use 'R&esource' in Page 'Item List' before it is declared.
        modify("Resource &Skills")
        {
            CaptionML = ENU = 'Resource &Skills', FRA = '&Compétences ressources';
            ToolTipML = ENU = 'View the assignment of skills to resources, items, service item groups, and service items. You can use skill codes to allocate skilled resources to service items or items that need special skills for servicing.', FRA = 'Affichez l''affectation des compétences aux ressources, aux articles, aux groupes articles de service et aux articles de service. Vous pouvez utiliser les codes compétence pour affecter des ressources compétentes aux articles de service ou aux articles nécessitant des compétences spéciales pour la maintenance.';
        }
        modify("Skilled R&esources")
        {
            CaptionML = ENU = 'Skilled R&esources', FRA = '&Ressources compétentes';
            ToolTipML = ENU = 'View a list of all registered resources with information about whether they have the skills required to service the particular service item group, item, or service item.', FRA = 'Affichez la liste de toutes les ressources enregistrées. Cette fenêtre indique si ces dernières possèdent les compétences nécessaires pour effectuer des opérations de service sur le groupe articles de service, l''article ou l''article de service particulier.';
        }


        //Unsupported feature: CodeModification on ""Calc. Stan&dard Cost"(Action 46).OnAction". Please convert manually.

        //trigger  Stan&dard Cost"(Action 46)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CalculateStdCost.CalcItem("No.",true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CLEAR(CalculateStdCost);
        CalculateStdCost.CalcItem("No.",true);
        */
        //end;
        //BC Upgrade KAMNAY01>>
        // modify("&Warehouse Entries") //'&Warehouse Entries' is an ambiguous reference between '&Warehouse Entries' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and '&Warehouse Entries' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.
        // {
        //     Visible = false;
        // }
        // modify("Co&mments") //'Co&mments' is an ambiguous reference between 'Co&mments' defined by the extension 'Base Application by Microsoft (26.0.30643.33317)' and 'Co&mments' defined by the extension 'BCIBM by Default Publisher (1.0.0.0)'.
        // {
        //     Visible = false;
        // }
        //BC Upgrade KAMNAY01<<
        addafter("Item &Tracking Entries")
        {
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
            //BC Upgrade KAMNAY01>> A member of type Action with name '&Warehouse Entries' is already defined in Page 'Item List' by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
            // action("&Warehouse Entries")
            // {
            //     CaptionML = ENU = '&Warehouse Entries',
            //                 FRA = 'Écritures &entrepôt';
            //     Image = BinLedger;
            //     RunObject = Page "Warehouse Entries";
            //     RunPageLink = "Item No." = FIELD("No.");
            //     RunPageView = sorting("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type", Dedicated);
            // }
            //BC Upgrade KAMNAY01<< A member of type Action with name '&Warehouse Entries' is already defined in Page 'Item List' by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
            action("Application Worksheet")
            {
                CaptionML = ENU = 'Application Worksheet',
                            FRA = 'Feuille lettrage';
                Image = ApplicationWorksheet;
                RunObject = Page "Application Worksheet";
                RunPageLink = "Item No." = FIELD("No.");
                ApplicationArea = All;
                ToolTip = 'Executes the Application Worksheet action.';
            }
        }
        //BC Upgrade KAMNAY01>> A member of type Group with name 'Statistics' is already defined in Page 'Item List' by the extension 'Base Application by Microsoft
        // addfirst(Statistics)
        // {
        //     action(Statistics)
        //     {
        //         CaptionML = ENU = 'Statistics',
        //                     FRA = 'Statistiques';
        //         Image = Statistics;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         ShortCutKey = 'F7';

        //         trigger OnAction();
        //         var
        //             ItemStatistics: Page "Item Statistics";
        //         begin
        //             ItemStatistics.SetItem(Rec);
        //             ItemStatistics.RUNMODAL;
        //         end;
        //     }
        // }
        //BC Upgrade KAMNAY01<< A member of type Group with name 'Statistics' is already defined in Page 'Item List' by the extension 'Base Application by Microsoft
        // BC Upgrade KAMNAY01>> DITW Actions
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
        //BC Upgrade KAMNAY01<< DITW Actions
        addafter("C&alculate Counting Period")
        {
            separator(Separator1100710013)
            {
            }
            action("Apply Template")
            {
                CaptionML = ENU = 'Apply Template',
                            FRA = 'Appliquer modèle';
                Ellipsis = true;
                Image = ApplyTemplate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the Apply Template action.';

                trigger OnAction();
                var
                    ConfigTemplateMgt: Codeunit "Config. Template Management";
                    RecRef: RecordRef;
                begin
                    RecRef.GETTABLE(Rec);
                    ConfigTemplateMgt.UpdateFromTemplateSelection(RecRef);
                end;
            }
            separator(Separator1100710011)
            {
            }
            //BC Upgrade KAMNAY01>> DITW Actions
            // action("Copy Item")
            // {
            //     CaptionML = ENU = 'Copy Item',
            //                 FRA = 'Copier article';
            //     Description = 'FINXL7.00.001';
            //     Image = CopyItem;

            //     trigger OnAction();
            //     var
            //         lrepCopyItem: Report "Copy Item (Norriq XL)";
            //     begin
            //         //<<FINXL7.00.001 RBE 20/03/2013
            //         lrepCopyItem.SetItem(Rec);
            //         lrepCopyItem.RUNMODAL;
            //         CLEAR(lrepCopyItem);
            //         //>>FINXL7.00.001 RBE 20/03/2013
            //     end;
            // }
            // action("Copy Item From Package")
            // {
            //     CaptionML = ENU = 'Copy Item From Package',
            //                 FRA = 'Copier article à partir du paquet';
            //     Description = 'FINXL7.00.001';
            //     Image = CopyItem;
            //     Visible = false;

            //     trigger OnAction();
            //     var
            //         lpgeCopyItem: Page "Copy Item (NORRIQXL)";
            //     begin
            //         //<<FINXL7.00.001 RBE 17/04/2014
            //         lpgeCopyItem.fctSetParam("No.", '', '');
            //         lpgeCopyItem.RUNMODAL();
            //         //>>FINXL7.00.001 RBE 17/04/2014
            //     end;
            // }
            // action("Create Item Wizard")
            // {
            //     CaptionML = ENU = 'Create Item Wizard',
            //                 FRA = 'Créer article avec assistant';
            //     Description = 'MANXL7.00.001';

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
            // separator(Separator1100710005)
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
            //BC Upgrade KAMNAY01<< DITW Actions
        }
        addfirst(navigation)
        {
            group(BTComponent)
            {
                CaptionML = ENU = '&Component',
                            FRA = '&Composant';
                Visible = BTComponentVisible;
                //BC Upgrade KAMNAY01>> DITW Action
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
                //BC Upgrade KAMNAY01<< DITW Action
                group(ActionGroup1100710201)
                {
                    CaptionML = ENU = 'E&ntries',
                                FRA = 'É&critures';
                    Image = Entries;
                    action(Action1100710200)
                    {
                        CaptionML = ENU = 'Ledger E&ntries',
                                    FRA = '&Ecritures comptables';
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = sorting("Item No.");
                        ShortCutKey = 'Ctrl+F7';
                        ApplicationArea = All;
                        ToolTip = 'Executes the Action1100710200 action.';
                    }
                    action(Action1100710199)
                    {
                        CaptionML = ENU = '&Reservation Entries',
                                    FRA = 'Écritures &réservation';
                        Image = ReservationLedger;
                        RunObject = Page "Reservation Entries";
                        RunPageLink = "Reservation Status" = CONST(Reservation),
                                      "Item No." = FIELD("No.");
                        RunPageView = sorting("Item No.", "Variant Code", "Location Code", "Reservation Status");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Action1100710199 action.';
                    }
                    action(Action1100710198)
                    {
                        CaptionML = ENU = '&Value Entries',
                                    FRA = 'Écritures &valeur';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = sorting("Item No.");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Action1100710198 action.';
                    }
                    //BC Upgrade KAMNAY01<< DITW Action
                    // action(Action1100710197)
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

                    // action(Action1100710196)
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
                    //BC Upgrade KAMNAY01>> DITW Action
                    action(Action1100710195)
                    {
                        CaptionML = ENU = 'Application Worksheet',
                                    FRA = 'Feuille lettrage';
                        Image = ApplicationWorksheet;
                        RunObject = Page "Application Worksheet";
                        RunPageLink = "Item No." = FIELD("No.");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Action1100710195 action.';
                    }
                }
                group(ActionGroup1100710194)
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
                    action(Action1100710192)
                    {
                        CaptionML = ENU = 'Entry Statistics',
                                    FRA = 'Statistiques écritures';
                        Image = EntryStatistics;
                        RunObject = Page "Item Entry Statistics";
                        RunPageLink = "No." = FIELD("No."),
                                      "Date Filter" = FIELD("Date Filter"),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Action1100710192 action.';
                    }
                    action(Action1100710191)
                    {
                        CaptionML = ENU = 'T&urnover',
                                    FRA = '&Rotation';
                        Image = Turnover;
                        RunObject = Page "Item Turnover";
                        RunPageLink = "No." = FIELD("No."),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Action1100710191 action.';
                    }
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
                    //BC Upgrade KAMNAY01>> DITW Action
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
                    //BC Upgrade KAMNAY01<< DITW Action
                }
                group("&Component Availability by")
                {
                    CaptionML = ENU = '&Component Availability by',
                                FRA = '&Composant disponibilité par';
                    Image = ItemAvailability;
                    // //BC Upgrade KAMNAY01>> 'Period' , "Variant"  And Location  is already defined in Page 'Item List' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
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
                    // //BC Upgrade KAMNAY01<< 'Period' , "Variant"  And Location  is already defined in Page 'Item List' by the extension 'Base Application by Microsoft (26.0.30643.33317)'
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
                separator(Separator1100710183)
                {
                }
                //BC Upgrade KAMNAY01>>A member of type Action with name '&Bin Contents'  And "Co&mments" is already defined in Page 'Item List' by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
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
                //BC Upgrade KAMNAY01<<A member of type Action with name '&Bin Contents'  And "Co&mments" is already defined in Page 'Item List' by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
                action(Action1100710180)
                {
                    CaptionML = ENU = 'Dimensions',
                                FRA = 'Axes analytiques';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(27),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Action1100710180 action.';
                }
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
                separator(Separator1100710178)
                {
                }
                action(Action1100710177)
                {
                    CaptionML = ENU = '&Units of Measure',
                                FRA = '&Unités';
                    Image = UnitOfMeasure;
                    RunObject = Page "Item Units of Measure";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                    ToolTip = 'Executes the Action1100710177 action.';
                }
                action(Action1100710176)
                {
                    CaptionML = ENU = 'Va&riants',
                                FRA = '&Variantes';
                    Image = ItemVariant;
                    RunObject = Page "Item Variants";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                    ToolTip = 'Executes the Action1100710176 action.';
                }
                separator(Separator1100710175)
                {
                }
                action(Action1100710174)
                {
                    CaptionML = ENU = 'Translations',
                                FRA = 'Traductions';
                    Image = Text;
                    RunObject = Page "Item Translations";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                    ToolTip = 'Executes the Action1100710174 action.';
                }
                action(Action1100710173)
                {
                    CaptionML = ENU = 'E&xtended Texts',
                                FRA = 'Te&xtes étendus';
                    Image = Text;
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name" = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = sorting("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                    ApplicationArea = All;
                    ToolTip = 'Executes the Action1100710173 action.';
                }
                separator(Separator1100710172)
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
                    //BC Upgrade KAMNAY01>>A member of type Action with name 'Calc. Stan&dard Cost' is already defined in Page 'Item List' by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
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
                    //BC Upgrade KAMNAY01<<A member of type Action with name 'Calc. Stan&dard Cost' is already defined in Page 'Item List' by the extension 'Base Application by Microsoft (26.0.30643.33317)'.
                }
                group("Manufa&cturing")
                {
                    CaptionML = ENU = 'Manufa&cturing',
                                FRA = 'Pr&oduction';
                    Image = "Where-Used";
                    //BC Upgrade KAMNAY01>> 'Where-Used' is already defined in Page 'Item List' by the action("Where-Used") in the extension 'Base Application by Microsoft (26.0.30643.33317)'.

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
                    //BC Upgrade KAMNAY01<< 'Where-Used' is already defined in Page 'Item List' by the action("Where-Used") in the extension 'Base Application by Microsoft (26.0.30643.33317)'.
                    action(Action1100710165)
                    {
                        CaptionML = ENU = 'Calc. Stan&dard Cost',
                                    FRA = 'C&alculer coût standard';
                        ApplicationArea = All;
                        ToolTip = 'Executes the Action1100710165 action.';

                        trigger OnAction();
                        begin
                            CLEAR(CalculateStdCost);
                            CalculateStdCost.CalcItem(Rec."No.", false);
                        end;
                    }
                }
                separator(Separator1100710164)
                {
                }
                ////BC Upgrade KAMNAY01>> DITW Action
                // action("&Equipments")
                // {
                //     CaptionML = ENU = '&Equipments',
                //                 FRA = '&Équimpements';
                //     Image = Tools;
                //     RunObject = Page "Service Items List PM";
                //     RunPageLink = "Item No." = FIELD("No.");
                //     RunPageView = sorting("Item No.");
                // }
                //BC Upgrade KAMNAY01<< DITW Action
                // //BC Upgrade KAMNAY01>> Troubleshooting' is already defined in PageExtension 'Serv. Item List' by the extension 'Base Application by Microsoft 
                // action(Troubleshooting)
                // {
                //     CaptionML = ENU = 'Troubleshooting',
                //                 FRA = 'Incident';
                //     Image = Troubleshoot;
                //     RunObject = Page "Troubleshooting Setup";
                //     RunPageLink = Type = CONST(Item),
                //                   "No." = FIELD("No.");
                // }
                // //BC Upgrade KAMNAY01<< Troubleshooting' is already defined in PageExtension 'Serv. Item List' by the extension 'Base Application by Microsoft
                group("R&esource")
                {
                    CaptionML = ENU = 'R&esource',
                                FRA = 'Re&ssource';
                    Image = Resource;
                    action("Resource Skills")
                    {
                        CaptionML = ENU = 'Resource Skills',
                                    FRA = 'Compétences ressource';
                        RunObject = Page "Resource Skills";
                        RunPageLink = Type = CONST(Item),
                                      "No." = FIELD("No.");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Resource Skills action.';
                    }
                    action("Skilled Resources")
                    {
                        CaptionML = ENU = 'Skilled Resources',
                                    FRA = 'Ressources compétentes';
                        ApplicationArea = All;
                        ToolTip = 'Executes the Skilled Resources action.';

                        trigger OnAction();
                        var
                            ResourceSkill: Record "Resource Skill";
                            SkilledResourceList: Page "Skilled Resource List"; //BC Upgrade KAMNAY01>> 
                        begin
                            CLEAR(SkilledResourceList);
                            SkilledResourceList.Initialize(ResourceSkill.Type::Item, Rec."No.", Rec.Description);
                            SkilledResourceList.RUNMODAL();
                        end;
                    }
                }
                separator(Separator1100710158)
                {
                }
                action(Action1100710157)
                {
                    CaptionML = ENU = 'Identifiers',
                                FRA = 'Identifiants';
                    Image = EncryptionKeys;
                    RunObject = Page "Item Identifiers";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = sorting("Item No.", "Variant Code", "Unit of Measure Code");
                    ApplicationArea = All;
                    ToolTip = 'Executes the Action1100710157 action.';
                }
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
                action(Action1100910000)
                {
                    CaptionML = ENU = 'Co&mments',
                                FRA = 'Co&mmentaires';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Item),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                    ToolTip = 'Executes the Action1100910000 action.';
                }
                separator(Separator1100710115)
                {
                }
                //BC Upgrade KAMNAY01>> DITW Action
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
                //BC Upgrade KAMNAY01<< DITW Action
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

                // group(ActionGroup1100710130)
                // {
                //     CaptionML = ENU = 'Quality',
                //                 FRA = 'Qualité';
                //     Image = TaskQualityMeasure;
                //     action("&Quality Standards")
                //     {
                //         CaptionML = ENU = '&Quality Standards',
                //                     FRA = '&Qaulité Standards';
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
                //         Image = History;

                //         trigger OnAction();
                //         var
                //             ItemTestHistory: Page "Item Test History";
                //         begin
                //             ItemTestHistory.SETRECORD(Rec);
                //             ItemTestHistory.RUNMODAL;
                //         end;
                //     }
                // }
                //BC Upgrade KAMNAY01<< DITW Action
            }
        }
        //BC Upgrade KAMNAY01>> priya is working on this Report "Item Availability by Quality" 
        addafter(Assembly)
        {
            action(Quality)
            {
                Caption = 'Quality';
                Image = InwardEntry;
                RunObject = Report "Item Availability by Qua CBN";
                ApplicationArea = All;
                ToolTip = 'Executes the Quality action.';
            }
        }
        addafter("Calc. Stan&dard Cost")
        {
            action(Action1100710037)
            {
                Caption = 'Calc. Unit Price';
                Image = SuggestItemPrice;
                ApplicationArea = All;
                ToolTip = 'Executes the Calc. Unit Price action.';

                trigger OnAction();
                begin
                    CLEAR(CalculateStdCost);
                    CalculateStdCost.CalcAssemblyItemPrice(Rec."No.")
                end;
            }
        }
        addafter("Line Discounts")
        {
            //BC Upgrade KAMNAY01>> DITW Action
            // action("D&iscount Charges")
            // {
            //     CaptionML = ENU = 'D&iscount Charges',
            //                 FRA = 'Frais de remise';
            //     Image = TaxSetup;
            //     RunObject = Page "Purchase Discount Item Charges";
            //     RunPageLink = "Source Type" = CONST(Item),
            //                   "Source No." = FIELD("No.");
            // }
            // action("Promotio&n Charges")
            // {
            //     CaptionML = ENU = 'Promotio&n Charges',
            //                 FRA = 'Frais de promotion';
            //     Image = TaxSetup;
            //     RunObject = Page "Purch. Promotion Item Charges";
            //     RunPageLink = "Source Type" = CONST(Item),
            //                   "Source No." = FIELD("No.");
            // }
            // group("Drink-It Charges")
            // {
            //     CaptionML = ENU = 'Drink-It Charges',
            //                 FRA = 'Frais Drink-IT';
            //     Image = TaxSetup;
            //     action("Ta&x Charges")
            //     {
            //         CaptionML = ENU = 'Ta&x Charges',
            //                     FRA = 'Taxe d''impôt';
            //         Description = 'DITW15.00.00.01';
            //         Image = TaxSetup;
            //         RunObject = Page "Purchase Tax Item Charges";
            //         RunPageLink = "Source Type" = CONST(Item),
            //                       "Source No." = FIELD("No.");
            //     }
            //     action("D&eposit Charges")
            //     {
            //         CaptionML = ENU = 'D&eposit Charges',
            //                     FRA = 'Friais de dépôt';
            //         Description = 'DITW15.00.00.01';
            //         Image = TaxSetup;
            //         RunObject = Page "Purchase Deposit Item Charges";
            //         RunPageLink = "Source Type" = CONST(Item),
            //                       "Source No." = FIELD("No.");
            //     }
            //     action(Action1100710080)
            //     {
            //         CaptionML = ENU = 'D&iscount Charges',
            //                     FRA = 'Frais de remise';
            //         Image = TaxSetup;
            //         RunObject = Page "Purchase Discount Item Charges";
            //         RunPageLink = "Source Type" = CONST(Item),
            //                       "Source No." = FIELD("No.");
            //     }
            //     action(Action1100710079)
            //     {
            //         CaptionML = ENU = 'Promotio&n Charges',
            //                     FRA = 'Frais de promotion';
            //         Image = TaxSetup;
            //         RunObject = Page "Purch. Promotion Item Charges";
            //         RunPageLink = "Source Type" = CONST(Item),
            //                       "Source No." = FIELD("No.");
            //     }
            // }

            // group(Others)
            // {
            //     CaptionML = ENU = 'Others',
            //                 FRA = 'Autres';
            //     Image = Item;
            //     action("Items &Exclusivity")
            //     {
            //         CaptionML = ENU = 'Items &Exclusivity',
            //                     FRA = 'Articles &Exclusivité';
            //         Image = Item;
            //         RunObject = Page "Purchase Items Exclusivity";
            //         RunPageLink = "Source Type" = CONST(Item),
            //                       "Source No." = FIELD("No.");
            //     }
            // }

        }
        // addafter("Nonstoc&k Items")
        // {
        //     separator(Separator1100710073)
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
        // }
        // addafter("Sales_LineDiscounts")
        // {
        //     action(Action1100710065)
        //     {
        //         Caption = 'D&iscount Charges';
        //         Image = TaxSetup;
        //         RunObject = Page "Sales Discount Item Charges";
        //         RunPageLink = "Source Type" = CONST(Item),
        //                       "Source No." = FIELD("No.");
        //     }
        //     action(Action1100710064)
        //     {
        //         Caption = 'Promotio&n Charges';
        //         Image = TaxSetup;
        //         RunObject = Page "Sales Promotion Item Charges";
        //         RunPageLink = "Source Type" = CONST(Item),
        //                       "Source No." = FIELD("No.");
        //     }
        //     group(ActionGroup1100710063)
        //     {
        //         CaptionML = ENU = 'Drink-It Charges',
        //                     FRA = 'Frais Drink-IT';
        //         Image = TaxSetup;
        //         action(Action1100710062)
        //         {
        //             CaptionML = ENU = 'Ta&x Charges',
        //                         FRA = 'Taxe d''impôt';
        //             Description = 'DITW15.00.00.01';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Tax Item Charges";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //         action(Action1100710061)
        //         {
        //             CaptionML = ENU = 'Exception Tax Groups',
        //                         FRA = 'Groupes taxe excéption';
        //             Image = TaxSetup;
        //             RunObject = Page "Customer Exception Tax Groups";
        //         }
        //         action(Action1100710060)
        //         {
        //             CaptionML = ENU = 'D&eposit Charges',
        //                         FRA = 'Friais de dépôt';
        //             Description = 'DITW15.00.00.01';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Deposit Item Charges";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //         action(Action1100710059)
        //         {
        //             CaptionML = ENU = 'D&iscount Charges',
        //                         FRA = 'Frais de remise';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Discount Item Charges";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //         action(Action1100710058)
        //         {
        //             CaptionML = ENU = 'Promotio&n Charges',
        //                         FRA = 'Frais de promotion';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Promotion Item Charges";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //     }
        //     group("Credit Limits")
        //     {
        //         CaptionML = ENU = 'Credit Limits',
        //                     FRA = 'Limite crédit';
        //         Image = LimitedCredit;
        //         action("Deposit Li&mits")
        //         {
        //             CaptionML = ENU = 'Deposit Li&mits',
        //                         FRA = 'Limite dépôt';
        //             Image = LimitedCredit;
        //             RunObject = Page "Sales Deposit Limits";
        //             RunPageLink = "Item No." = FIELD("No.");
        //         }
        //     }
        //     group(ActionGroup1100710049)
        //     {
        //         CaptionML = ENU = 'Others',
        //                     FRA = 'Autres';
        //         Image = Item;
        //         action(Action1100710048)
        //         {
        //             CaptionML = ENU = 'Items &Exclusivity',
        //                         FRA = 'Articles &Exclusivité';
        //             Image = Item;
        //             RunObject = Page "Sales Items Exclusivity";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //         action("Items &Quota")
        //         {
        //             CaptionML = ENU = 'Items &Quota',
        //                         FRA = 'Articles &Quota';
        //             Image = Item;
        //             RunObject = Page "Sales Items Quota";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //         action("Loyalty Items")
        //         {
        //             CaptionML = ENU = 'Loyalty Items',
        //                         FRA = 'Articles de fidelité';
        //             Description = 'DIT715 #243';
        //             Image = Item;
        //             RunObject = Page "Sales Loyalty Points & Amounts";
        //             RunPageLink = "Source Type" = CONST(Item),
        //                           "Source No." = FIELD("No.");
        //         }
        //         action("Quality Standards")
        //         {
        //             CaptionML = ENU = 'Quality Standards',
        //                         FRA = 'Standards de qualité';
        //             Image = TaskQualityMeasure;
        //             RunObject = Page "Sales Standards";
        //             RunPageLink = "Item No." = FIELD("No.");
        //             RunPageView = sorting("Item No.", "Sales Type", "Sales Code", "Starting Date", "Variant Code", "Qlty. Measure Code");
        //         }
        //     }
        //     separator(Separator1100710054)
        //     {
        //     }
        // }
        //BC Upgrade KAMNAY01<< DITW Action
        addafter("Returns Orders")
        {
            separator(Separator1100710051)
            {
            }
            //BC Upgrade KAMNAY01>> DITW Action
            // action("Recycle Charges")
            // {
            //     CaptionML = ENU = 'Recycle Charges',
            //                 FRA = 'Recyclage annexes';
            //     Description = 'FINXL7.00.001 KLU 27/06/2014 #42';
            //     Image = Reuse;
            //     RunObject = Page "Item Recycle Charge";
            //     RunPageLink = "Item No." = FIELD("No.");
            // }
            //BC Upgrade KAMNAY01<< DITW Action
            separator(Separator55004)
            {
            }
            action("SKU Sales Inventory CBN")
            {
                Caption = 'SKU Sales Inventory';
                Description = 'HEI.03';
                Image = InventoryJournal;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "SKU Sales Inventory CBN";
                ApplicationArea = All;
                ToolTip = 'Executes the SKU Sales Inventory action.';
            }
        }
        //BC Upgrade KAMNAY01>> DITW Action
        // addafter("Stockkeepin&g Units")
        // {
        //     group(ActionGroup1100710029)
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
        //     group(ActionGroup1100710025)
        //     {
        //         CaptionML = ENU = 'Service',
        //                     FRA = 'Service';
        //         Description = 'DITW18.00.06 GVC 07/05/2015  DIT-770  #1335';
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
                        CaptionML = ENU = 'by Default Dimension',
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
        moveafter("&Phys. Inventory Ledger Entries"; "&Reservation Entries")

    }


    var
        CalculateStdCost: Codeunit "Calculate Standard Cost";

        BTComponentVisible: Boolean;

        BTItemVisible: Boolean;
        RunModeCaptionPM: Boolean;
        VisibleAstro: Boolean;
        Text2014310_0: TextConst ENU = 'Component List', FRA = 'Liste des composants';


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
    BTComponentVisible := true;
    BTItemVisible := true;
    // >>DITW16.00.00.41 DDR DIT-715 #297
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
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    IsFoundationEnabled := ApplicationAreaSetup.IsFoundationEnabled;
    SetWorkflowManagementEnabledState;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3

    // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
    SETRANGE("No.");
    RunModeCaptionPM := SetCaptionClassPM();
    if RunModeCaptionPM then begin
      CurrPage.CAPTION := Text2014310_0;
    end;
    BTItemVisible := not RunModeCaptionPM;
    BTComponentVisible := RunModeCaptionPM;
    // >>DITW16.00.00.41 DDR DIT-715 #297

    //HEI.06>>
    CLEAR(VisibleAstro);
    if AstroInterfaceSetupL.GET and AstroInterfaceSetupL."Enabled Astro Integration" then begin
      if AstroInterfaceSetupL."Activate Material Master" and (AstroInterfaceSetupL."Item Create/Update Interface" <> '') then
        if InterfaceSetupL.GET(AstroInterfaceSetupL."Item Create/Update Interface") then
          VisibleAstro := true;
    end;
    //HEI.06<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

