page 51008 "PO Purchase Order CBN"
{
    // version NAVW110.0.00.15140,OWM4.50,FINXL10.00,DITW110.00.09,HEI.19

    // FINXL7.00.001 RBE 20/03/2013 : Added field "Your Reference" on page
    // FINXL7.00.001 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)
    // FINXL8.00.001 RBE 01/12/2014: Email functionality
    // FINXL8.00.001 BSA 03/06/2015 #182: Added Field : "Emergency Order"
    // FINXL8.00.001 BSA 10/06/2015 #85 : Added Field "Last changed User ID", "Last changed Date/time"
    // 
    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 14/01/2008 Remove seperation line from Function button
    // DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                New calling functions to insert (item) charges
    // DITW15.00.00.01 DDR 27/02/2008 Drink-it Return Deposit functionnalities
    //                                Added menu "Create &Return Order" into Function button + shortcut Shift+F3
    //                                Added menu "&Return Orders" into "Order" button
    //                                Added field "No. of Return Orders" (general tab)
    // DITW15.00.00.01 DDR 11/03/2008 Added menu "Return Receipts" into "Order" button
    //                                Remove counter return orders
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //                                Correct menu "&Return Orders" into "Order" button
    // DITW15.00.00.21 DDR 18/06/2008 Added new tab "Shipping Agent"
    //                                Added function FormatMaximumControls()
    //                                Added form property CalcFields("Total Weight","Total Cubage")
    //                                Added fields (not editable)
    //                                  "Maximum Weight","Maximum Cubage",
    //                                  "Shipping Charge Type","Shipping Charge No.","Shipping Charge Per",
    //                                  "Total Weight","Total Cubage","Shipping Agent Code","Shipping Agent Service Code"
    //                                  "Shipping Unit Cost","Shipping Cost Amount"
    //                                Added field (editable)
    //                                  "Shipping Charge Per"
    //                                Replace Print Button by menu-Button
    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.23 DDR 08/08/2008 Certification rules
    //                                  Remove "Lot &No. Info." button
    //                                  Change MenuItem access keys conflict.
    //                                     "Return &Shipments" -> "R&eturn Shipments" (Order button)
    //                                     "&Return Orders" -> "Ret&urn Orders" (Order button)
    //                                     "&Create Return Order" -> "Cre&ate Return Order" (Function button)
    // 
    // DITW15.00.00.23.04 DDR 15/09/2008 Refresh Purchase Header before release document when shipping matrix to update
    // DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    // DITW15.00.00.25 DDR 09/10/2008 Bugfix refreshing fields "Maximum Weight","Maximum Cubage" with color
    //                                 into function FormatMaximumControls()
    //                                Added fields "Truck Code","Driver Code","Distance" into Shipping Agent tab
    //                                Editable fields "Shipping Agent Code","Shipping Agent Service Code"
    //                                Non-Editable "Shipping Charge Per"
    //                                Remove fields "Shipping Charge Type","Shipping Charge No.",
    //                                  "Shipping Unit Cost","Shipping Cost Amount"
    //                                Refresh Header before call Posting document
    //                     21/10/2008 Deleted field2013722 Duty Tax Type
    //                                Added fields "Vendor DTax Group Code" into Invoicing tab
    // DITW15.00.00.28 DDR 24/11/2008 Added "Fiscal Representative No." into Shipping tab
    // DITW15.00.00.31 DDR 17/02/2009 Correct Caption field "Total Cubage" into Shipping Agent tab
    // DITW15.00.00.33 DDR 07/05/2009 Move field "Customer DTax Group Code" into 'General' tab
    // DITW15.00.00.34 DDR 16/06/2009 Added auto-release document into menu 'Create Whse. shipment'
    //                     17/06/2009 Added shortcut key CTRL+F10 to switch status 'open' the current document
    //                                Changed Editable "Status" field
    //                                Added functions DocStatusRelease(),DocStatusOpen(),
    // DITW15.00.00.36 DDR 07/12/2009 issue 981 Bugfix Save/Refresh before release function
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 30/09/2010 issue 1217 Added 'Get EMCS ARC No. to Apply' menu into 'Functions' menu
    //                 DDR 27/01/2011 issue 1217 (DIT711 137) Added fields "Tax Office Code" into 'Shipping' tab
    // DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 issue 1271
    //                                Added menu 'Quality Tests' into 'Line' Button
    // DITW15.00.00.39 DDR 27/04/2011 issue 1322 NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                Added to call function StdVendPurchCode.AutoInsertPurchLines()
    //                                  from OnAfterValidate trigger field "Sell-to Customer No."
    // DITW15.00.00.39 DDR 10/05/2011 issue 1330 Upgrade editable Status to work with Prepayments
    //                                           Remove 'ShowConfirmMsg' parameter function DocStatusOpen();
    //                                           Modified functions DocStatusOpen(),DocStatusRelease()
    //                                           Modified validate trigger field "Status"
    //                     28/06/2011 issue 1330 Bugfix conflict between status "Pending Approval" and "Pending Prepayment"
    //                                             when releasing (attempt)
    //                     27/07/2011 issue 1407 Added flowfields "Disc.Promo. Order Calculated" (see "Zoom view)
    //                                           Moved/Deleted functions into codeunit414 Release Sales Document
    //                                             DocStatusRelease(),DocStatusOpen()
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                              Added to insert first line automatically
    //                     19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    // DITW15.00.00.39 DDR 22/08/2011 issue 1399 Added fields into 'Shipping' tab
    //                                             "Whse. Shipment No. (First)","Whse. Shipment Status (First)"
    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  call function SetDisableRefreshLines() before each report
    //                                                  (don't use the <RunObject> property)
    //                     12/06/2012 DIT-715 #328 Removed 'BlankZero' property field "Whse. Shipment Status (First)"
    //                     13/06/2012 DIT-715 #338 Added 'Period (Items)' menu into button 'Item\Item Item Availability by'
    //                                             Added 'Items by Period' into button 'Item'
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added 'Service/Contract' tab
    //                                             Added fields into 'Service/Contract' tab
    //                                               "DIT Sub-Contract Type","Contract Group Code","Service Contract No."
    //                                             Moved "Building No." into 'Service/Contract' tab
    //                 DDR 27/09/2012 DIT-715 #458 Bugfix width of subform60 PurchLines
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added menu 'SSCC Tracking Lines' in 'Line' buttton
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                                             NORRIQ owm - Online Warehouse Management
    //                                             Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //                                               New menu "Show N-owm activities" on Order Action.
    // 
    // DITW17.00.02 DDR 06/06/2013 DIT-770 #99 Added fields "Ship-to Country/Region Code" into 'Shipping' tab
    //                  04/07/2013 DIT-770 #99 Added fields "GWC Country/Region Code" into 'Foreign Trade' tab
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99
    // DITW17.00.02 AT  09/09/2013 DIT-770 #170 merge WHN-001 HIT0279
    //                             Status field NOT Editable
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0012.1
    //                             added requester id field
    //                             added action quote approvals
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0012.2
    //                             changed caption of "Quote no."
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0012.3
    //                             Translations
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0019.1
    //                             Order may only be printed if status = released
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added in General Tab
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 DDR 28/11/2013 DIT-770 #272 Upgrade N-OWM4.5 Nav2013 R1
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code" (General tab)
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1191 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    // DITW17.10.04 AKH 24/11/2014 DIT-770 #1001 Added Action "Print and Mail"
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214 Filter on "Resp. Center Table Filter 2"
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    //                                           Set FIeld Contract Type to Editable = FALSE
    // DITW18.00.06 DDR 07/08/2015 DIT-770 #1368 Added field "Vendor Posting Group" into 'Service/Contract' tab
    // DITW18.00.07 AKH 11/02/2016 DIT-770 #1804 Sundry Vendor
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Several adjustments
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add HasDocumentShippingCosts to General TAB
    // DITW18.00.07 AKH 28/03/2016 DIT-770 #1409 Added "ShowMandatory" property for "Vendor Shipment No." field
    // DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added field "Vendor Delivery Type" & "Delivery Time (sec.)" under Shipping Agent tab
    // DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 - #1977 Default & Mandatory Route setup + Route default values + shipment date calculation
    // DITW18.00.07 VSC 09/05/2016 DIT-770 #1971 - #1976 Totals on Purchase Order Header (weight, cubage, volume HL, shortcut unit of measures)
    // DITW18.00.07 AKH 13/05/2016 DIT-770 #1409 Restored standard code for check on "External Document No."
    // DITW18.00.07 VSC 25/05/2016 DIT-770 #1968 Add New field "Receipt Status"
    // DITW18.00.07 VSC 25/05/2016 DIT-770 #1970 Rename Tab Shipping Agent to Receiving
    //                                           Remove field "Shipping Charge Per"
    //                                           Move fields to Tab General:"Expected Receipt Date","Requested Receipt Date","Promised Receipt Date","Receipt Status"
    //                                           Set importance to Additional for fields "Requested Receipt Date", "Promised Receipt Date","Tax Date","Vendor DTax Group Code","Vendor Invoice No." and "Linked Customer No."
    //                                           Set Quickentry on "Buy-from Vendor No.","Vendor Order No.",Route,"Expected Receipt Date","Purchaser Code"
    // DITW18.00.07 VSC 26/05/2016 DIT-770 #1984 Get Setup , Remove Action &Print (double as Action order).
    //                                           Action Print > &Order  Promoted in Category Report
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    // DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"
    // DITW19.00.08 MSF 30/08/2016 BL#10387 (DIT-770 #1274) Vendor - Tax information depending on Receiving-From/Shipped-From addresses
    // DITW19.00.08 MSF 05/09/2016 BL#10387 (DIT-770 #1274) If receipt/return shipment, dont allow to modify the tax reg no or whse ref
    // DITW19.00.08 MSF 09/09/2016 BL#10387 (DIT-770 #1274) Review Code
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 03/02/2017 NRQ#20678 upgrade Usage optionstring
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.09 DDR 20/04/2017 NRQ#13107 Add all country code fields
    // HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
    //   # New field Vendor Bank Account
    // 
    // HEI.02 PTPGAP064 IBM HORTOC01 12.07.2017
    //   # New page based on standard page 50
    // HEI.03 RFC-CHG0249183 IBM.LS 30.11.2018
    //   # Added code to call "SendEmailPurchaseOrder" function. Code commented here and added in Codeunit-415.
    //   # Added fields - "BRC Purchase Order" and "SRM Order No.".
    // HEI.05 FDD-PURGAP027 - Maximo POs approval flow, IBM.POENAB02 , 28.02.2019
    //   # New field added in "General" group - 50002 Payment User. Set EDITABLE property for this field to FALSE.
    // HEI.06 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Removed Field "Payment User"
    //   # Created new Page Action "Purchase Additional"
    // 
    // HEI.07 FDD-Ethiopia_Prepayment HT628 IBM POSTOI01 04.07.2019
    //   # modify OnAfterGetCurrentRecord
    //   # add new glovbal variable ActivePrepayment : IncludeInDataset= True
    //   # change the Editable property for the following fields : "Prepayment%, "Compress Prepayment", "Prepmt.Payment Terms Code", "Prepmt.Payment Discount %"
    // HEI.08 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    //   # Made Field "Vendor Posting Group" non-editable
    // HEI.09 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //  # New Field Added License Code
    //  # Code added in triggers
    // HEi.10 CHG2081091 IBM SHANKJ03  01.10.2020
    //   # new field added Mail sent & Mail sent date time
    // HEI.11 CHG2083064 IBM.GUNERE01  21.10.2020 # Mail Sent, Mail sent date time fields set to editable false
    // HEI.13 HT1136 CHG2084917 IBM.GUNERE01 # 11.03.2020 # License Code trigger modified, OnAfterGetRecord modified
    // HEI.14 CHG2088873 IBM.GUNERE01 11.26.2020 # License Code onDrillDown, Post and Release funcs. modified
    // HEI.15 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field added in General tab: LSR Order No
    // HEI.16 CHG2155847 HB2821 IBM NANDIS01 13.01.2023 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Added new button "Process PO for Astro WMS"
    // HEI.17 CHG2170300 HB3129 IBM SRIVAS07 29-05-23 # Block editing of dimensions during PO Invoice Processing
    //   # Added EBF Combination restrictions in Release and Send for Approval Actions.
    // HEI.18 CHG2251877 MAJUMS03 05.07.2024 Warehouse Receipt Lines creation issue
    //   # Code added under OnValidate() Trigger of "Delivery Finalized" field to proper update of "Warehouse Rcpt/Shpt No." of Warehouse Request to fix
    //   the bug related to "Delivery Finalized" field in Purchase Line table and "Warehouse Rcpt/Shpt No." of Warehouse Request table. Code written on
    //   Page level to update "Warehouse Rcpt/Shpt No." of Warehouse Request table before triggering the function under Codeunit and to avoid COMMIT.
    //   # TableData Warehouse Request=rm Permission added.
    // HEI.19 CHG2251877 MAJUMS03 11.07.2024 Warehouse Receipt Lines creation issue
    //   # Code modified.
    //   # TableData Warehouse Request=rm Permission is modified as Warehouse Request=rimd.
    // BC Upgrade SHUKLP03 >> Added field "LSR Order No." in the interface ext.

    // BC Upgrade PATELP08 >>
    // # Blocking this as the Table 'Purchase Header' already defines a method called 'SetHideValidationDialog' with the same parameter types.
    // # Added Rec here because blocked the repeatative procedure "SetHideValidationDialog" already defines a method called 'SetHideValidationDialog' with the same parameter types in Purchase Header
    // BC Upgrade PATELP08 <<

    Caption = 'PO Purchase Order';
    PageType = Document;
    Permissions = TableData "Warehouse Request" = rimd;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    // UsageCategory = Documents; //BC Upgrade BHARDA11 ---No Need to show document page in search 
    SourceTableView = where("Document Type" = FILTER(Order));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit();
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    QuickEntry = true;
                    ToolTip = 'Specifies the number of the vendor you buy from.';

                    trigger OnValidate();
                    begin
                        /* //BC Upgrade Manisha Drink it code commented>>

                        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
                        if "Sundry Vendor" then
                            ShowVendorSundryInfo();
                        //>> DITW18.00.07 AKH DIT-770 #1804
                        */ //BC Upgrade Manisha Drink it code commented<<


                        if Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
                            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                                Rec.SETRANGE("Buy-from Vendor No.");

                        CurrPage.UPDATE();
                        /* //BC Upgrade Manisha Drink it code commented>>

                                                // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01)
                                                COMMIT;
                                                StdVendPurchCode.AutoInsertPurchLines(Rec);
                                                // >>DITW15.00.00.39 DDR #1323 (BE5.00.01)
                                                */ //BC Upgrade Manisha Drink it code commented<<

                    end;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Suite;
                    Caption = 'Vendor';
                    Importance = Promoted;
                    QuickEntry = false;
                    ShowMandatory = true;
                    ToolTip = 'Specifies detailed information about the vendor on the selected purchase document.';

                    trigger OnValidate();
                    begin
                        if Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
                            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                                Rec.SETRANGE("Buy-from Vendor No.");

                        CurrPage.UPDATE();
                    end;
                }
                group("Buy-from")
                {
                    Caption = 'Buy-from';
                    field("Buy-from Address"; Rec."Buy-from Address")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Address';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the vendor''s buy-from address.';
                    }
                    field("Buy-from Address 2"; Rec."Buy-from Address 2")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Address 2';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies an additional part of the vendor''s buy-from address.';
                    }
                    field("Buy-from Post Code"; Rec."Buy-from Post Code")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Post Code';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the postal code of the address.';
                    }
                    field("Buy-from City"; Rec."Buy-from City")
                    {
                        ApplicationArea = Suite;
                        Caption = 'City';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the city of the vendor who ships the items.';
                    }
                    field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                    {
                        Caption = 'Country/Region';
                        Importance = Additional;
                        ToolTip = 'Specifies the country/region code of the address.';
                    }
                    field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                    {
                        Caption = 'Contact No.';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the number of your contact at the vendor.';
                    }
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = Suite;
                    Caption = 'Contact';
                    QuickEntry = false;
                    ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Suite;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date of the vendor''s invoice.';
                }
                /* //BC Upgrade Manisha Drink it Field commented>>

                field("Tax Date"; Rec."Tax Date")
                {
                    Importance = Additional;
                    QuickEntry = false;
                }
                group(Control1100710018)
                {
                    field(RouteNew; Route)
                    {
                        QuickEntry = true;
                        ShowMandatory = RouteAsMandatory;

                        trigger OnDrillDown();
                        begin
                            //FIXME<<DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
                            DrillDownRouteCombinaison;
                            // >>DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
                        end;
                    }
                    field(RoutePlanningNew; "Route Planning No.")
                    {
                        Editable = false;
                    }
                }
                field("Vendor Tax Registration No."; Rec."Vendor Tax Registration No.")
                {
                    Description = 'DITW15.00.00.28,DITW19.00.08 BL#10387';
                    Editable = EditableVendorTax;
                }
                field("Vendor Tax Warehouse Ref."; "Vendor Tax Warehouse Ref.")
                {
                    Description = 'DITW15.00.00.38 #1217,DITW19.00.08 BL#10387';
                    Editable = EditableVendorTax;
                }
                */ //BC Upgrade Manisha Drink it Field commented<<

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the posting date of the record.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies when the purchase invoice is due for payment.';
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ShowMandatory = VendorInvoiceNoMandatory;
                    ToolTip = 'Specifies the vendor''s own invoice number.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    QuickEntry = true;
                    ToolTip = 'Specifies which purchaser is associated with the order.';

                    trigger OnValidate();
                    begin
                        PurchaserCodeOnAfterValidate();
                    end;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the number of archived versions for this document.';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTipML = ENU = 'Specifies the date you expect the items to be available in your warehouse. If you leave the field blank, it will be calculated as follows: Planned Receipt Date + Safety Lead Time + Inbound Warehouse Handling Time = Expected Receipt Date.';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. If you do not need delivery on a specific date, you can leave the field blank.';
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the vendor''s reference.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date when the item is ordered. It is calculated backwards from the Planned Receipt Date field in combination with the Lead Time Calculation field.';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    Caption = 'Purchase Quote No.';
                    Description = 'DITW17.00.02 DIT-770 #144';
                    Importance = Additional;
                    ToolTip = 'Specifies the quote number for the purchase order.';
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    QuickEntry = true;
                    ToolTip = 'Specifies the vendor''s order number.';
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ShowMandatory = VendorShipmentNoMandatory;
                    ToolTip = 'Specifies the vendor''s shipment number. It is inserted in the corresponding field on the source document during posting.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the order address code linked to the relevant vendor''s order address.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';

                    trigger OnValidate();
                    begin
                        /* //BC Upgrade Manisha Drink it code commented>>

                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        if Rec."Responsibility Center" <> xRec."Responsibility Center" then
                            CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1191
                     */ //BC Upgrade Manisha Drink it code commented<<

                    end;
                }
                /* //BC Upgrade Manisha Drink it code commented>>
                field("Physical Location Group Code"; "Physical Location Group Code")
                {
                    Importance = Additional;
                    QuickEntry = false;

                    trigger OnValidate();
                    begin
                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                            CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1191
                    end;
                }
                */ //BC Upgrade Manisha Drink it code commented<<

                field(LocationCodeNew; Rec."Location Code")
                {
                    QuickEntry = false;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';

                    trigger OnValidate();
                    begin
                        /* //BC Upgrade Manisha Drink it code commented>>

                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        if "Location Code" <> xRec."Location Code" then
                            CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1191
                        */ //BC Upgrade Manisha Drink it code commented<<

                    end;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                /* //BC Upgrade Manisha Drink it code commented>>
                field("Requester ID"; Rec."Requester ID")
                {
                    Description = 'DITW17.00.02 DIT-770 #144';
                }
                field(Status; Status)
                {
                    Description = 'DITW17.00.02 DIT-770 #170';
                    Importance = Promoted;

                    trigger OnValidate();
                    begin
                        StatusOnValidate;
                        StatusOnAfterValidate;
                    end;
                }
                field("Creation Date/Time"; "Creation Date/Time")
                {
                    Description = 'DITW18.00.07 DIT-770 #1282';
                    Importance = Additional;
                }
                field("Created By"; "Created By")
                {
                    Description = 'DITW18.00.07 DIT-770 #1282';
                    Importance = Additional;
                }
                field("Document Shipping Costs"; HasDocumentShippingCosts)
                {
                    Caption = 'Document Shipping Costs';

                    trigger OnDrillDown();
                    begin
                        //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
                        OpenDocumentShippingCosts;
                        //>> DITW18.00.07 VSC DIT-770 #1066
                    end;
                }
                

                field("Emergency Order"; Rec."Emergency Order")
                {
                }
                field("Last changed User ID"; "Last changed User ID")
                {
                    Editable = false;
                }
                field("Last changed Date/time"; "Last changed Date/time")
                {
                    Editable = false;
                }
                
                field("Linked Customer No."; Rec."Linked Customer No.")
                {
                    Importance = Additional;
                }
                */ //BC Upgrade Manisha Drink it code commented<<
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase orders.';
                }
                /* //BC Upgrade Manisha Drink it Field commented>>

                field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
                {
                    Importance = Additional;
                }
                field("Receipt Status"; "Receipt Status")
                {
                    Description = 'DITW18.00.07 #1968';
                }
                */ //BC Upgrade Manisha Drink it code commented<<

                field("BRC Purchase Order"; Rec."BRC Purchase Order FND")
                {
                    ToolTip = 'Specifies the value of the BRC Purchase Order field.';
                }
                field("SRM Order No."; Rec."SRM Order No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Order No. field.';
                }
                field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
                {
                    ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
                }
                field("Purch. Reason Code"; Rec."Purch. Reason Code FND")
                {
                    ToolTip = 'Specifies the value of the Purch. Reason Code field.';
                }
                field("License Code"; PurchaseHeaderAdditional."License Code")
                {
                    Editable = LicensiEdit;
                    ToolTip = 'Specifies the value of the License Code field.';

                    trigger OnDrillDown();
                    begin
                        // Hei.09 >>
                        if LicensiEdit = true then begin
                            OldDimSetId := 0;
                            NewDImSetId := 0;
                            OldDimSetId := Rec."Dimension Set ID";
                            if Rec.Status = Rec.Status::Open then begin
                                GenLedSetRec.RESET();
                                GenLedSetRec.GET();
                                if GenLedSetRec."License Dimension Code FND" = '' then
                                    ERROR(Text000);
                                DimValRec.RESET();
                                DimValRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                CLEAR(DimValPage);
                                DimValPage.SETRECORD(DimValRec);
                                DimValPage.SETTABLEVIEW(DimValRec);
                                DimValPage.LOOKUPMODE(true);
                                if DimValPage.RUNMODAL() = ACTION::LookupOK then begin
                                    DimValPage.GETRECORD(DimValRec);
                                    LicenseCode := DimValRec.Code;
                                    PurchaseHeaderAdditional.RESET();
                                    if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
                                        PurchaseHeaderAdditional."License Code" := DimValRec.Code;
                                        PurchaseHeaderAdditional.MODIFY();
                                    end;

                                    DimValRec.GET(GenLedSetRec."License Dimension Code FND", LicenseCode);
                                    DimMgt.GetDimensionSet(TempDimSetEntry, Rec."Dimension Set ID");
                                    //>> HEI.14
                                    if not TempDimSetEntry.GET(Rec."Dimension Set ID", GenLedSetRec."License Dimension Code FND") then begin
                                        TempDimSetEntry.INIT();
                                        TempDimSetEntry.VALIDATE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                        TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCode);
                                        TempDimSetEntry."Dimension Value ID" := DimValRec."Dimension Value ID";
                                        TempDimSetEntry."Dimension Set ID" := Rec."Dimension Set ID";
                                        TempDimSetEntry.INSERT();
                                        //      IF NOT TempDimSetEntry.INSERT THEN
                                        //        TempDimSetEntry.MODIFY;
                                    end else begin
                                        if xRec."License Code FND" <> LicenseCode then begin
                                            TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCode);
                                            TempDimSetEntry.MODIFY();
                                        end;
                                    end;
                                    //<< HEI.14
                                    //TempDimSetEntry.INSERT            (TRUE);

                                    Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

                                    Rec.MODIFY();
                                    NewDImSetId := Rec."Dimension Set ID";
                                    //VALIDATE("License Code", DimValRec.Code);
                                    //Updating All Lines
                                    PurchLineRec.RESET();
                                    PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                                    PurchLineRec.SETRANGE("Document No.", Rec."No.");
                                    if PurchLineRec.FINDFIRST() then begin
                                        if not GUIALLOWED then
                                            // BC Upgrade PATELP08 >> Added Rec here because blocked the repeatative procedure "SetHideValidationDialog" already defines a method called 'SetHideValidationDialog' with the same parameter types in Purchase Header
                                            Rec.SetHideValidationDialog(true);
                                        // BC Upgrade PATELP08 <<
                                        COMMIT();
                                        UpdateAllLineDimNew(NewDImSetId, OldDimSetId);
                                    end;

                                end;
                            end else
                                ERROR(Text003);
                        end else
                            ERROR(Text005, Rec."No.");
                        // Hei.09 <<
                    end;

                    trigger OnValidate();
                    var
                        locTempDimensionSetEntry: Record "Dimension Set Entry" temporary;
                        locPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
                        locPurchaseLine: Record "Purchase Line";
                    begin
                        // HEI.13>>
                        if Rec."License Code FND" = '' then begin
                            GenLedSetRec.RESET();
                            GenLedSetRec.GET();

                            //IF GenLedSetRec."License Dimension Code" = '' THEN BEGIN //HEI.13
                            //>> HEI.13
                            //header
                            locTempDimensionSetEntry.RESET();
                            DimSetEntryRec_2.RESET();
                            DimSetEntryRec_2.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                            if DimSetEntryRec_2.findset() then begin
                                repeat
                                    locTempDimensionSetEntry.INIT();
                                    locTempDimensionSetEntry := DimSetEntryRec_2;
                                    locTempDimensionSetEntry.INSERT();
                                until DimSetEntryRec_2.NEXT() = 0;
                            end;
                            locTempDimensionSetEntry.RESET();
                            locTempDimensionSetEntry.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                            if locTempDimensionSetEntry.FINDFIRST() then
                                locTempDimensionSetEntry.DELETE(true);

                            Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(locTempDimensionSetEntry);
                            Rec.MODIFY();
                            locTempDimensionSetEntry.DELETEALL();

                            //lines
                            locPurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                            locPurchaseLine.SETRANGE("Document No.", Rec."No.");
                            locPurchaseLine.findset();
                            repeat
                                locTempDimensionSetEntry.RESET();
                                DimSetEntryRec_2.RESET();
                                DimSetEntryRec_2.SETRANGE("Dimension Set ID", locPurchaseLine."Dimension Set ID");
                                if DimSetEntryRec_2.findset() then begin
                                    repeat
                                        locTempDimensionSetEntry.INIT();
                                        locTempDimensionSetEntry := DimSetEntryRec_2;
                                        locTempDimensionSetEntry.INSERT();
                                    until DimSetEntryRec_2.NEXT() = 0;
                                end;
                                locTempDimensionSetEntry.RESET();
                                locTempDimensionSetEntry.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                if locTempDimensionSetEntry.FINDFIRST() then
                                    locTempDimensionSetEntry.DELETE(true);

                                locPurchaseLine."Dimension Set ID" := DimMgt.GetDimensionSetID(locTempDimensionSetEntry);
                                locPurchaseLine.MODIFY();
                                locTempDimensionSetEntry.DELETEALL();
                            until locPurchaseLine.NEXT() = 0;


                            //   DimSetEntryRec_2.RESET;
                            //   DimSetEntryRec_2.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
                            //   IF DimSetEntryRec_2.FINDFIRST THEN BEGIN
                            //     DimSetEntryRec_2.DELETE;
                            //     Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryRec_2);
                            //     Rec.MODIFY;
                            //   end;

                            if locPurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
                                locPurchaseHeaderAdditional."License Code" := '';
                                locPurchaseHeaderAdditional.MODIFY();
                            end;
                            //<< HEI.13
                            //end;
                        end;
                        //HEI.13 <<
                        GenLedSetRec.RESET();
                        GenLedSetRec.GET();
                        if GenLedSetRec."License Dimension Code FND" = '' then
                            ERROR(Text000);
                        //>> HEI.13
                        // DimValRec.RESET;
                        // DimValRec.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
                        // DimValRec.SETRANGE(Code,LicenseCode);
                        // IF NOT DimValRec.FINDFIRST THEN
                        //  ERROR(Text001);
                        //<< HEI.13
                        //HEI.13 <<
                    end;
                }
                field("Mail Sent"; PurchaseHeaderAdditional."Mail Sent")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Mail Sent field.';
                }
                field("Mail Sent Date Time"; PurchaseHeaderAdditional."Mail Sent Date Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Mail Sent Date Time field.';
                }
                // BC Upgrade SHUKLP03 >> Added in interface ext.
                // field("LSR Order No."; PurchaseHeaderAdditional."LSR Order No")
                // {
                //     Editable = false;
                //     ToolTip = 'Specifies the value of the LSR Order No field.';
                // }
                // BC Upgrade SHUKLP03 << Added in interface ext.
            }
            part(PurchLines; "Purchase Order Subform")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group("Invoice Details")
            {
                Caption = 'Invoice Details';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the currency of amounts on the purchase document.';

                    trigger OnAssistEdit();
                    begin
                        CLEAR(ChangeExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE());
                        if ChangeExchangeRate.RUNMODAL() = ACTION::OK then begin
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        end;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE();
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.';

                    trigger OnValidate();
                    begin
                        PricesIncludingVATOnAfterValid();
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies which VAT business posting group was used when the VAT entry was posted.';
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    Editable = false;
                    ToolTip = 'Specifies the vendor''s market type to link business transactions to.';
                }
                /* //BC Upgrade Manisha Drink it Field commented>>

                field("Sundry Vendor"; Rec."Sundry Vendor")
                {
                }
                */ //BC Upgrade Manisha Drink it code commented<<

                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the code that represents the payment terms that apply to the purchase order.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies how payment for the purchase document must be submitted.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the number for the transaction type, for the purpose of reporting to INTRASTAT.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1.';

                    trigger OnValidate();
                    begin
                        ShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2.';

                    trigger OnValidate();
                    begin
                        ShortcutDimension2CodeOnAfterV();
                    end;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the last date on which the amount in the purchase order must be paid for the order to qualify for a payment discount.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';

                    trigger OnValidate();
                    begin
                        /* //BC Upgrade Manisha Drink it code commented>>

                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        if Rec."Location Code" <> xRec."Location Code" then
                            CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1191
                        */ //BC Upgrade Manisha Drink it code commented<<

                    end;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the code that represents the shipment method for this purchase.';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ToolTip = 'Identifies the payment of the purchase invoice.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ToolTip = 'Identifies the vendor who sent the purchase invoice.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ToolTip = 'Specifies if the posted invoice will be included in the payment suggestion.';
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the time it takes to make items part of available inventory, after the items have been posted as received.';
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the number of the customer that the items are shipped to directly from your vendor, as a drop shipment.';
                }
            }
            group("Shipping and Payment")
            {
                Caption = 'Shipping and Payment';
                group("Ship-to")
                {
                    Caption = 'Ship-to';
                    field("Ship-to Code"; Rec."Ship-to Code")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Code';
                        ToolTip = 'Specifies a ship-to code if you want a different shipment address from the one that has been automatically entered.';
                    }
                    field("Ship-to Name"; Rec."Ship-to Name")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Name';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of the company at the address to which you want the items to be shipped.';
                    }
                    field("Ship-to Address"; Rec."Ship-to Address")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Address';
                        Importance = Additional;
                        ToolTip = 'Specifies the vendor''s buy-from address.';
                    }
                    field("Ship-to Address 2"; Rec."Ship-to Address 2")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Address 2';
                        Importance = Additional;
                        ToolTip = 'Specifies an additional part of the vendor''s buy-from address.';
                    }
                    field("Ship-to Post Code"; Rec."Ship-to Post Code")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Post Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code of the address.';
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                        ApplicationArea = Suite;
                        Caption = 'City';
                        Importance = Additional;
                        ToolTip = 'Specifies the city the items in the purchase order will be shipped to.';
                    }
                    field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                    {
                        Caption = 'Country/Region';
                        Importance = Additional;
                        ToolTip = 'Specifies the country/region code of the address.';
                    }
                    field("Ship-to Contact"; Rec."Ship-to Contact")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Contact';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of a contact person for the address where the items should be shipped.';
                    }
                }
                /* //BC Upgrade Manisha Drink it Field commented>>
                field("Fiscal Representative No."; Rec."Fiscal Representative No.")
                {
                }
                field("Tax Office Code"; Rec."Tax Office Code")
                {
                }
                field("Journey Time"; Rec."Journey Time")
                {
                }
                field("Whse. Receipt No. (First)"; "Whse. Receipt No. (First)")
                {
                    Lookup = false;
                }
                field("Whse. Receipt Status (First)"; "Whse. Receipt Status (First)")
                {
                    DrillDown = false;
                    Lookup = false;
                }
                */ //BC Upgrade Manisha Drink it Field commented<<


                group("Pay-to")
                {
                    Caption = 'Pay-to';
                    field("Pay-to Name"; Rec."Pay-to Name")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Name';
                        Importance = Promoted;
                        ToolTip = 'Specifies the name of the vendor sending the invoice.';
                    }
                    field("Pay-to Address"; Rec."Pay-to Address")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Address';
                        Importance = Additional;
                        ToolTip = 'Specifies the vendor''s buy-from address.';
                    }
                    field("Pay-to Address 2"; Rec."Pay-to Address 2")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Address 2';
                        Importance = Additional;
                        ToolTip = 'Specifies an additional part of the vendor''s buy-from address.';
                    }
                    field("Pay-to Post Code"; Rec."Pay-to Post Code")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Post Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code of the address.';
                    }
                    field("Pay-to City"; Rec."Pay-to City")
                    {
                        ApplicationArea = Suite;
                        Caption = 'City';
                        Importance = Additional;
                        ToolTip = 'Specifies the city of the vendor sending the invoice.';
                    }
                    field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                    {
                        Caption = 'Country/Region';
                        Importance = Additional;
                        ToolTip = 'Specifies the country/region code of the address.';
                    }
                    field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                    {
                        Caption = 'Contact No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact who sends the invoice.';
                    }
                    field("Pay-to Contact"; Rec."Pay-to Contact")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Contact';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                    }
                    field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
                    {
                        ToolTip = 'Specifies the value of the Vendor Bank Account field.';
                    }
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies a code for the purchase header''s transaction specification here.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the code for the transport method to be used with this purchase header.';
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ToolTip = 'Specifies the code of the port of entry where the items pass into your country/region.';
                }
                field("Area"; Rec.Area)
                {
                    ToolTip = 'Specifies the code for the area of the vendor''s address.';
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                field("Prepayment %"; Rec."Prepayment %")
                {
                    Editable = ActivePrepayment;
                    Importance = Promoted;
                    ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for purchase.';

                    trigger OnValidate();
                    begin
                        Prepayment37OnAfterValidate();
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    Editable = ActivePrepayment;
                    ToolTip = 'Specifies that prepayments on the purchase order are combined if they have the same general ledger account for prepayments or the same dimensions.';
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    Editable = ActivePrepayment;
                    ToolTip = 'Specifies the code that represents the payment terms for prepayment invoices related to the purchase document.';
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies when the prepayment invoice for this purchase order is due.';
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    Editable = ActivePrepayment;
                    ToolTip = 'Specifies the payment discount percent granted on the prepayment if the vendor pays on or before the date entered in the Prepmt. Pmt. Discount Date field.';
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the last date the vendor can pay the prepayment invoice and still receive a payment discount on the prepayment amount.';
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ToolTip = 'Specifies the number that the vendor uses for the credit memo you are creating in this purchase credit memo header.';
                }
            }

            group(Receiving)
            {
                Caption = 'Receiving';

                /* //BC Upgrade Manisha Drink it Field commented>>

                                field(Route; Route)
                                {

                                    trigger OnDrillDown();
                                    begin
                                        //<< DITW18.00.07 VSC 09/05/2016 DIT-770 #1968
                                        //DrillDownRouteCombinaison;//BC Upgrade Manisha Drink it Function commented>>

                                    end;
                                }



                                                field("Shipping Agent Code"; "Shipping Agent Code")
                                                {

                                                    trigger OnValidate();
                                                    begin
                                                        //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                                                        if xRec."Shipping Agent Code" <> Rec."Shipping Agent Code" then
                                                            CurrPage.UPDATE
                                                        //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                                                    end;
                                                }
                                                field("Shipping Agent Service Code"; "Shipping Agent Service Code")
                                                {
                                                }
                                                field("Copy Shipment Method Code"; "Shipment Method Code")
                                                {
                                                }

                                                field("WHT Business Posting Group"; Rec."WHT Business Posting Group")
                                                {
                                                }
                                                field(Distance; Rec.Distance)
                                                {
                                                }
                                                field("Truck Code"; "Truck Code")
                                                {

                                                    trigger OnValidate();
                                                    begin
                                                        //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                                                        if xRec."Truck Code" <> Rec."Truck Code" then
                                                            CurrPage.UPDATE
                                                        //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                                                    end;
                                                }
                                                field("Driver Code"; "Driver Code")
                                                {

                                                    trigger OnValidate();
                                                    begin
                                                        //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                                                        if xRec."Truck Code" <> Rec."Truck Code" then
                                                            CurrPage.UPDATE
                                                        //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                                                    end;
                                                }
                                                field("Truck Zone"; "Truck Zone")
                                                {
                                                    Description = 'DITW18.00.07 #1968';
                                                }
                                                field("Require 2 Drivers"; "Require 2 Drivers")
                                                {
                                                }
                                                field("Delivery Sequence"; "Delivery Sequence")
                                                {
                                                    Description = 'DITW18.00.07 #1968';
                                                }
                                                field("Maximum Weight"; "Maximum Weight")
                                                {
                                                    Editable = false;
                                                    Style = Strong;
                                                    StyleExpr = "Maximum WeightEmphasize";
                                                    Visible = "Maximum WeightVisible";
                                                }
                                                field("Maximum Cubage"; "Maximum Cubage")
                                                {
                                                    Editable = false;
                                                    Style = Strong;
                                                    StyleExpr = "Maximum CubageEmphasize";
                                                    Visible = "Maximum CubageVisible";
                                                }
                                                field("Total Weight"; "Total Weight")
                                                {
                                                    Editable = false;
                                                }
                                                field("Total Cubage"; "Total Cubage")
                                                {
                                                    Editable = false;
                                                }
                                                field("Delivery Time 1 From"; "Delivery Time 1 From")
                                                {
                                                }
                                                field("Delivery Time 1 To"; "Delivery Time 1 To")
                                                {
                                                }
                                                field("Delivery Time 2 From"; "Delivery Time 2 From")
                                                {
                                                }
                                                field("Delivery Time 2 To"; "Delivery Time 2 To")
                                                {
                                                }
                                                field("Vendor Delivery Type"; "Vendor Delivery Type")
                                                {
                                                }
                                                field("Delivery Time (sec.)"; "Delivery Time (sec.)")
                                                {
                                                }
                                */ //BC Upgrade Manisha Drink it code commented<<

            }
            /* //BC Upgrade Manisha Drink it code commented>>

                        group("Service/Contract")
                        {
                            Caption = 'Service/Contract';
                            field("Contract Type"; Rec."Contract Type")
                            {
                                Editable = false;
                            }
                            field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
                            {
                            }
                            field("Service Contract No."; "Service Contract No.")
                            {
                                Visible = false;
                            }
                            field("Financial Contract No."; "Financial Contract No.")
                            {
                                Visible = false;
                            }
                            field("Contract Group Code"; Rec."Contract Group Code")
                            {
                            }
            */ //BC Upgrade Manisha Drink it code commented<<
        }



        area(factboxes)
        {
            part(Control23; "Pending Approval FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control1903326807; "Item Replenishment FactBox")
            {
                Provider = PurchLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                Visible = false;
            }
            part(Control1901138007; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }
            /* //BC Upgrade Manisha Drink it Page "Purchase Line FactBox2" code commented>>

            part(Control1907232107; "Purchase Line FactBox2")
            {
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = true;
            }
            */ //BC Upgrade Manisha Drink it code commented<<

            part(Control1904651607; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
                Visible = false;
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            part(Control3; "Purchase Line FactBox")
            {
                ApplicationArea = Suite;
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SAVERECORD();
                    end;
                }
                /*   action(Statistics)
                  {
                      Caption = 'Statistics';
                      Image = Statistics;
                      Promoted = true;
                      PromotedCategory = Process;
                      PromotedIsBig = true;
                      ShortCutKey = 'F7';
                      ToolTip = 'Executes the Statistics action.';

                      trigger OnAction();
                      begin
                          Rec.OpenPurchaseOrderStatistics();
                          PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                      end;
                  } */

                action(PurchaseOrderStatistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Enabled = Rec."No." <> '';
                    Image = Statistics;
                    ShortCutKey = 'F7';

                    Visible = true;
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                    RunObject = Page "Purchase Order Statistics";
                    RunPageOnRec = true;
                }
                action(Card)
                {
                    ApplicationArea = Suite;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or change detailed information about the vendor.';
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        // ApprovalEntries.Setfilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");//BC Upgrade Manisha Function name change in BC
                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");//BC Upgrade Manisha
                        ApprovalEntries.RUN();
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'Executes the Co&mments action.';
                }
                /* //BC Upgrade Manisha Drink it Page Document Shipping Cost code commented>>

                action("Shipping Costs")
                {
                    Caption = 'Shipping Costs';
                    Image = Costs;
                    RunObject = Page "Document Shipping Cost";
                    RunPageLink = "Source Type" = CONST(38),
                                  "Source No." = FIELD("No."),
                                  "Sub Type" = FIELD("Document Type");
                }
                */ //BC Upgrade Manisha Drink page Document Shipping Cost code commented<<

                action("Purchase Additional")
                {
                    Caption = 'Purchase Additional';
                    Image = Purchase;
                    RunObject = Page "Purchase Additional";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                    ToolTip = 'Executes the Purchase Additional action.';
                }
                action("Process PO for Astro WMS")
                {
                    Image = Process;
                    ToolTip = 'Executes the Process PO for Astro WMS action.';

                    trigger OnAction();
                    begin
                        /* //BC Upgrade Manisha Astro code commented>>
                         //HEI.16>>
                         if CONFIRM(STRSUBSTNO(Text50001, Rec."No."), true) then begin
                             ASTRODispatchSyncStP.SetPONumber(Rec."No.");
                             ASTRODispatchSyncStP.RUN;
                         end;
                         //HEI.16<<
                        */ // BC Upgrade Manisha Astro code commented<<
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Receipts)
                {
                    ApplicationArea = Suite;
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = sorting("Order No.");
                    ToolTip = 'Executes the Receipts action.';
                }
                action(Invoices)
                {
                    ApplicationArea = Suite;
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = sorting("Order No.");
                    ToolTip = 'Executes the Invoices action.';
                }
                action(PostedPrepaymentInvoices)
                {
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = sorting("Prepayment Order No.");
                    ToolTip = 'Executes the Prepa&yment Invoices action.';
                }
                action(PostedPrepaymentCrMemos)
                {
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = sorting("Prepayment Order No.");
                    ToolTip = 'Executes the Prepayment Credi&t Memos action.';
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                separator(Separator181)
                {
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = sorting("Source Document", "Source No.", "Location Code");
                    ToolTip = 'Executes the In&vt. Put-away/Pick Lines action.';
                }
                action("Quote Approvals")
                {
                    Caption = 'Quote Approvals';
                    ToolTip = 'Executes the Quote Approvals action.';

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        /* //BC Upgrade Manisha Drink it code commented>>
                        //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
                        ApprovalEntries.Setfilters(DATABASE::"Purchase Header", Rec."Document Type"::Quote, Rec."Quote No.");
                        ApprovalEntries.RUN;
                        //>>DITW17.00.02 TEC1 DIT-770 #144
                        */ //BC Upgrade Manisha Drink it code commented<<

                    end;
                }
                /* //BC Upgrade Manisha Drink it run page link "Link Purch. Document Type" drink it field commented>>

                                action("Ret&urn Orders")
                                {
                                    Caption = 'Ret&urn Orders';
                                    Image = ReturnOrder;
                                    RunObject = Page "Purchase Return Order List";
                                    RunPageLink = "Link Purch. Document Type" = FIELD("Document Type"),
                                                  "Link Purch. Document No." = FIELD("No.");
                                }
                

                action("R&eturn Shipments")
                {
                    Caption = 'R&eturn Shipments';
                    Image = ReturnShipment;
                    RunObject = Page "Posted Return Shipments";
                    RunPageLink = "Link Purch. Document No." = FIELD("No.");
                }
                */ //BC Upgrade Manisha Drink it run page link "Link Purch. Document Type" drink it field commented>>
                action("Whse. Receipt Lines")
                {
                    Caption = 'Whse. Receipt Lines';
                    Image = ReceiptLines;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(39),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = sorting("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ToolTip = 'Executes the Whse. Receipt Lines action.';
                }
                separator(Separator182)
                {
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action(Warehouse_GetSalesOrder)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                        ToolTip = '"Select the sales order that must be linked to the purchase order, for drop shipment. "';
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action("Get &Sales Order")
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        ToolTip = 'Executes the Get &Sales Order action.';

                        trigger OnAction();
                        var
                            PurchHeader: Record "Purchase Header";
                            DistIntegration: Codeunit "Dist. Integration";
                        begin
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
                separator(Separator1161021000)
                {
                }
                action("<Action1161021001>")
                {
                    Caption = 'Show N-owm activities';
                    Image = NewResource;
                    ToolTip = 'Executes the Show N-owm activities action.';

                    trigger OnAction();

                    var
                    // owmUtils: Codeunit "N-owm Utils";BC UPgrade Manisha  Drink it code Commented
                    begin
                        // owmUtils.ShowActivityStatus(owmUtils.ActPutAway, rec."No.", '');  //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 //BC Upgrade Manisha drink it code commented
                    end;
                }
            }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ToolTip = 'Executes the Reject action.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ToolTip = 'Executes the Delegate action.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ToolTip = 'Executes the Comments action.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group(ActionGroup13)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(Separator73)
                {
                }
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Executes the Re&lease action.';

                    trigger OnAction();
                    var
                        PurchasesPayablesSetupL: Record "Purchases & Payables Setup";
                        FinanceUtil: Codeunit "Financial-Utils";
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //HEI.17>>
                        FinanceUtil.OnBeforeSendPurchaseOrderApprovalRequest(Rec);
                        //HEI.17<<
                        //HEI.09 >>
                        GenLedSetRec.RESET();
                        GenLedSetRec.GET();
                        if GenLedSetRec."License Dimension Code FND" <> '' then begin
                            CLEAR(LicenseCodeValue);
                            PurchRec.RESET();
                            PurchRec.SETRANGE("Document Type", Rec."Document Type");
                            PurchRec.SETRANGE("No.", Rec."No.");
                            if PurchRec.FINDFIRST() then begin
                                DimSetEntryRec.RESET();
                                DimSetEntryRec.SETRANGE("Dimension Set ID", PurchRec."Dimension Set ID");
                                DimSetEntryRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                if DimSetEntryRec.FINDFIRST() then
                                    LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
                            end;
                            CLEAR(LicenseCodeValue_1);
                            PurchLineRec.RESET();
                            PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                            PurchLineRec.SETRANGE("Document No.", Rec."No.");
                            if PurchLineRec.FINDFIRST() then begin
                                repeat
                                    DimSetEntryRec_1.RESET();
                                    DimSetEntryRec_1.SETRANGE("Dimension Set ID", PurchLineRec."Dimension Set ID");
                                    DimSetEntryRec_1.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                    if DimSetEntryRec_1.FINDFIRST() then
                                        LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

                                    if LicenseCodeValue_1 <> '' then begin
                                        if LicenseCodeValue <> LicenseCodeValue_1 then
                                            ERROR(Text004);
                                    end;
                                until PurchLineRec.NEXT() = 0;
                                if LicenseCodeValue_1 <> '' then begin//HEI.11
                                    GenLedSetRec.RESET();
                                    GenLedSetRec.GET();
                                    if GenLedSetRec."License Dimension Code FND" = '' then
                                        ERROR(Text000);
                                    DimValRec.RESET();
                                    DimValRec.GET(GenLedSetRec."License Dimension Code FND", LicenseCodeValue_1);
                                    DimMgt.GetDimensionSet(TempDimSetEntry, Rec."Dimension Set ID");
                                    //>> HEI.14
                                    if not TempDimSetEntry.GET(Rec."Dimension Set ID", GenLedSetRec."License Dimension Code FND") then begin
                                        TempDimSetEntry.INIT();
                                        TempDimSetEntry.VALIDATE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                        TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCodeValue_1);
                                        TempDimSetEntry."Dimension Value ID" := DimValRec."Dimension Value ID";
                                        TempDimSetEntry.INSERT();
                                        //    IF NOT TempDimSetEntry.INSERT THEN
                                        //      TempDimSetEntry.MODIFY;
                                    end else begin
                                        if xRec."License Code FND" <> LicenseCodeValue_1 then begin
                                            TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCodeValue_1);
                                            TempDimSetEntry.MODIFY();
                                        end;
                                    end;
                                    //<< HEI.14

                                    Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

                                    Rec.MODIFY();
                                end;
                            end;//HEI.11
                        end;
                        //HEI.09 <<
                        // <<DITW15.00.00.23.04 DDR 15/09/2008 - DITW15.00.00.36 DDR 07/12/2009
                        CurrPage.UPDATE(true);
                        // >>DITW15.00.00.23.04 DDR
                        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                        ReleasePurchDoc.PerformManualRelease(Rec); // BC Upgrade BHARDA11
                        /* //BC Upgrade Manisha Drink it code commented>>
                        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
                        if "Sundry Vendor" then
                            TestSundryMandatoryFields();
                        //>> DITW18.00.07 DIT-770 #1804
                        */ //BC Upgrade Manisha Drink it code commented<<

                        // ReleasePurchDoc.DocStatusRelease(xRec, Rec);//BC Upgrade Manisha Drink it function code commented<<
                        //HEI.03>>
                        //CurrPage.UPDATE;
                        CurrPage.UPDATE(false);
                        //HEI.03<<
                        // >>DITW15.00.00.39 DDR #1330 #1407

                        ////HEI.03>>
                        //IF (Status <> xRec.Status) AND (Status = Status::Released) THEN BEGIN
                        //  PurchasesPayablesSetupL.GET;
                        //  IF PurchasesPayablesSetupL."Auto E-mail Active" AND ("SRM Order No." = '')
                        //    AND (NOT "BRC Purchase Order")
                        //  THEN
                        //    SendEmailPurchaseOrder(Rec,TRUE,TRUE);
                        //end;
                        ////HEI.03<<
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    ShortCutKey = 'Ctrl+F10';
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

                    trigger OnAction();
                    var
                        HenikenBCCustomFunction: Codeunit "Heineken BC Custom Functions";//BC Manisha Upgrade
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                        //HEI.12>>
                        if PurchSetup.GET() then begin
                            PurchaseLine.SETRANGE("Document No.", Rec."No.");
                            PurchaseLine.SETFILTER("Document Type", '%1', Rec."Document Type"::Order);
                            PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
                            PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
                            if not PurchaseLine.FINDFIRST() then
                                ItemCategoryBool := false
                            else
                                ItemCategoryBool := true;
                            if ItemCategoryBool then begin
                                //HEI.12<<
                                //HEI.11>>
                                if Rec."SRM Order No. FND" = '' then begin
                                    //ArchiveManagement.ArchivePurchDocumentOnReopen(Rec);//BC Manisha Upgrade
                                    HenikenBCCustomFunction.ArchivePurchDocumentOnReopen(Rec);//BC Manisha Upgrade
                                    CurrPage.UPDATE(false);
                                end;
                                //HEI.11<<
                                //HEI.12>>
                            end;
                        end;
                        //HEI.12<<
                        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                        //ReleasePurchDoc.PerformManualReopen(Rec);
                        //ReleasePurchDoc.DocStatusOpen(xRec, Rec);//BC Upgrade Manisha Drink it code commented
                        //CurrPage.UPDATE;//BC Upgrade Manisha Drink it code commented
                        // >>DITW15.00.00.39 DDR #1330 #1407
                        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                        //ReleasePurchDoc.PerformManualReopen(Rec);
                        //ReleasePurchDoc.DocStatusOpen(xRec, Rec);//BC Upgrade Manisha Drink it code commented
                        //CurrPage.UPDATE;//BC Upgrade Manisha Drink it code commented
                        // >>DITW15.00.00.39 DDR #1330 #1407
                    end;
                }
                separator(Separator611)
                {
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Vendor Invoice Disc." = R;
                    ApplicationArea = Suite;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the discount that can be granted based on all lines in the purchase document.';

                    trigger OnAction();
                    begin
                        ApproveCalcInvDisc();
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action("Change Sundry vendor fields")
                {
                    Caption = 'Change Sundry vendor fields';
                    Image = ChangeCustomer;
                    ToolTip = 'Executes the Change Sundry vendor fields action.';
                    //Visible = "Sundry Vendor";//Bc Upgrade Manisha Drink it field code commented

                    trigger OnAction();
                    begin
                        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
                        // ShowVendorSundryInfo();//BC Upgrade Manisha Drink it code Commented
                        //>> DITW18.00.07 DIT-770 #1804
                        //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
                        CurrPage.UPDATE(true);
                        //>> DITW18.00.07 DIT-770 #1804
                    end;
                }
                separator(Separator190)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = VendorCode;
                    ToolTip = 'Executes the Get St&d. Vend. Purchase Codes action.';

                    trigger OnAction();
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(Separator75)
                {
                }
                action(CopyDocument)
                {
                    ApplicationArea = Suite;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    ToolTip = 'Executes the Copy Document action.';

                    trigger OnAction();
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL();
                        CLEAR(CopyPurchDoc);
                        if Rec.GET(Rec."Document Type", Rec."No.") then;
                    end;
                }
                action(MoveNegativeLines)
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    ToolTip = 'Executes the Move Negative Lines action.';

                    trigger OnAction();
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL();
                        MoveNegPurchLines.ShowDocument();
                    end;
                }
                action("Cre&ate Return Order")
                {
                    Caption = 'Cre&ate Return Order';
                    Image = ReturnOrder;
                    ShortCutKey = 'Shift+F3';
                    ToolTip = 'Executes the Cre&ate Return Order action.';

                    trigger OnAction();
                    begin
                        /* //BC Upgrade Manisha Drink it code commented>>

                        // <<DITW15.00.00.01 DDR 27/02/2008
                        CODEUNIT.RUN(CODEUNIT::"Purch Ord. to Ret.Shpt.(Y/N)", Rec);

                        if not Rec.FIND('=><') then
                            Rec.INIT;
                        // >>DITW15.00.00.01 DDR
                        */ //BC Upgrade Manisha Drink it code commented<<

                    end;
                }
                separator(Separator1100083000)
                {
                }
                group(ActionGroup225)
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action(Functions_GetSalesOrder)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                        ToolTip = '"Select the sales order that must be linked to the purchase order, for drop shipment. "';
                    }
                }
                group(ActionGroup186)
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(Action187)
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        ToolTip = 'Executes the Get &Sales Order action.';

                        trigger OnAction();
                        var
                            PurchHeader: Record "Purchase Header";
                            DistIntegration: Codeunit "Dist. Integration";
                        begin
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
                action("Archive Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;
                    ToolTip = 'Executes the Archi&ve Document action.';

                    trigger OnAction();
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Send IC Purchase Order")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Purchase Order';
                    Image = IntercompanyOrder;
                    ToolTip = 'Executes the Send IC Purchase Order action.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                            ICInOutboxMgt.SendPurchDoc(Rec, false);
                    end;
                }
                separator(Separator189)
                {
                }
                /* //BC Upgrade Manisha Drink it Page Route Register Entries code commented>>

                action("Register Route Shipment entries")
                {
                    Caption = 'Register Route Shipment entries';
                    Image = Register;
                    RunObject = Page "Route Register Entries";
                    RunPageLink = "Route Planning No." = FIELD("Route Planning No."),
                                  "Source Type" = CONST(36),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                }
                */ //BC Upgrade Manisha Drink it Page Route Register Entries code commented<<

                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;
                    action(IncomingDocCard)
                    {
                        ApplicationArea = Suite;
                        Caption = 'View Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        ToolTip = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes';

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                        end;
                    }
                    action(SelectIncomingDoc)
                    {
                        AccessByPermission = TableData "Incoming Document" = R;
                        ApplicationArea = Suite;
                        Caption = 'Select Incoming Document';
                        Image = SelectLineToApply;
                        ToolTipML =;

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            Rec.VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RECORDID));
                        end;
                    }
                    action(IncomingDocAttachFile)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Create Incoming Document from File';
                        Ellipsis = true;
                        Enabled = CreateIncomingDocumentEnabled;
                        Image = Attach;
                        ToolTip = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.';

                        trigger OnAction();
                        var
                            IncomingDocumentAttachment: Record "Incoming Document Attachment";
                        begin
                            IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Remove Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = RemoveLine;
                        ToolTipML =;

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            if IncomingDocument.GET(Rec."Incoming Document Entry No.") then
                                IncomingDocument.RemoveLinkToRelatedRecord();
                            Rec."Incoming Document Entry No." := 0;
                            Rec.MODIFY(true);
                        end;
                    }
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    ToolTip = 'Executes the Send A&pproval Request action.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        FinanceUtil: Codeunit "Financial-Utils";
                    begin
                        //HEI.17>>
                        FinanceUtil.OnBeforeSendPurchaseOrderApprovalRequest(Rec);
                        //HEI.17<<
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
            group(ActionGroup17)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create &Whse. Receipt")
                {
                    AccessByPermission = TableData "Warehouse Receipt Header" = R;
                    Caption = 'Create &Whse. Receipt';
                    Image = NewReceipt;
                    ToolTip = 'Executes the Create &Whse. Receipt action.';

                    trigger OnAction();
                    var
                        PurchSetup: Record "Purchases & Payables Setup";
                        WHRcptHdr: Record "Warehouse Receipt Header";
                        WHRequest: Record "Warehouse Request";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        /* //BC Upgrade Manisha Drink it code commented>>  
                           //HEI.18>>
                           if WHRequest.GET(WHRequest.Type::Inbound, Rec."Location Code", DATABASE::"Purchase Line", WHRequest."Source Subtype"::"1", "No.") then begin
                               if WHRequest."Warehouse Rcpt/Shpt No." <> '' then begin
                                   //IF WHRcptHdr.GET(WHRequest."Warehouse Rcpt/Shpt No.") THEN BEGIN //HEI.19
                                   if not WHRcptHdr.GET(WHRequest."Warehouse Rcpt/Shpt No.") then begin //HEI.19
                                       WHRequest."Warehouse Rcpt/Shpt No." := '';
                                       WHRequest.MODIFY;
                                   end;
                               end;

                           end;
                           //HEI.18<<                       
                           // <<DITW19.00.07 MVN 25/01/2016 DIT-770 #1740 Upgrade: Variables
                           // <<DITW15.00.00.34 DDR 16/06/2009
                           PurchSetup.GET();
                           if PurchSetup."Auto.Release Document on Whse." then begin
                               // <<DITW15.00.00.39 DDR 27/07/2011 #1407
                               ReleasePurchDoc.DocStatusRelease(xRec, Rec);
                               // >>DITW15.00.00.39 DDR #1407
                               if (xRec.Status <> Status) and (Status = Status::Released) then
                                   MESSAGE(Text2014410, "Document Type", "No.");
                           end;
                           // >>DITW15.00.00.34 DDR
                           // >>DITW19.00.07 MVN DIT-770 #1740
                           */ //BC Upgrade Manisha Drink it code commented<<
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);
                        if not Rec.FIND('=><') then
                            Rec.INIT();
                    end;
                }

                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    ToolTip = 'Executes the Create Inventor&y Put-away/Pick action.';

                    trigger OnAction();
                    begin
                        Rec.CreateInvtPutAwayPick();

                        if not Rec.FIND('=><') then
                            Rec.INIT();
                    end;
                }
                separator(Separator74)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                //action(Post)//BC upgrade Manisha Function already exist with name post
                action(post1)//BC upgrade Manisha
                {
                    ApplicationArea = Suite;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    ShortCutKey = 'F9';
                    ToolTip = 'Executes the P&ost action.';

                    trigger OnAction();
                    begin
                        //HEI.09 >>
                        GenLedSetRec.RESET();
                        GenLedSetRec.GET();
                        if GenLedSetRec."License Dimension Code FND" <> '' then begin
                            CLEAR(LicenseCodeValue);
                            PurchRec.RESET();
                            PurchRec.SETRANGE("Document Type", Rec."Document Type");
                            PurchRec.SETRANGE("No.", Rec."No.");
                            if PurchRec.FINDFIRST() then begin
                                DimSetEntryRec.RESET();
                                DimSetEntryRec.SETRANGE("Dimension Set ID", PurchRec."Dimension Set ID");
                                DimSetEntryRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                if DimSetEntryRec.FINDFIRST() then
                                    LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
                            end;
                            CLEAR(LicenseCodeValue_1);
                            PurchLineRec.RESET();
                            PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                            PurchLineRec.SETRANGE("Document No.", Rec."No.");
                            if PurchLineRec.FINDFIRST() then begin
                                repeat
                                    DimSetEntryRec_1.RESET();
                                    DimSetEntryRec_1.SETRANGE("Dimension Set ID", PurchLineRec."Dimension Set ID");
                                    DimSetEntryRec_1.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                    if DimSetEntryRec_1.FINDFIRST() then
                                        LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

                                    if LicenseCodeValue_1 <> '' then begin
                                        if LicenseCodeValue <> LicenseCodeValue_1 then
                                            ERROR(Text004);
                                    end;
                                until PurchLineRec.NEXT() = 0;
                                if LicenseCodeValue_1 <> '' then begin//HEI.11
                                    GenLedSetRec.RESET();
                                    GenLedSetRec.GET();
                                    if GenLedSetRec."License Dimension Code FND" = '' then
                                        ERROR(Text000);
                                    DimValRec.RESET();
                                    DimValRec.GET(GenLedSetRec."License Dimension Code FND", LicenseCodeValue_1);
                                    DimMgt.GetDimensionSet(TempDimSetEntry, Rec."Dimension Set ID");
                                    //>> HEI.14
                                    if not TempDimSetEntry.GET(Rec."Dimension Set ID", GenLedSetRec."License Dimension Code FND") then begin
                                        TempDimSetEntry.INIT();
                                        TempDimSetEntry.VALIDATE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                        TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCodeValue_1);
                                        TempDimSetEntry."Dimension Value ID" := DimValRec."Dimension Value ID";
                                        TempDimSetEntry.INSERT();
                                        //    IF NOT TempDimSetEntry.INSERT THEN
                                        //      TempDimSetEntry.MODIFY;
                                    end else begin
                                        if xRec."License Code FND" <> LicenseCodeValue_1 then begin
                                            TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCodeValue_1);
                                            TempDimSetEntry.MODIFY();
                                        end;
                                    end;
                                    //<< HEI.14
                                    Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

                                    Rec.MODIFY();
                                end;
                            end;//HEI.11
                        end;
                        //HEI.09 <<
                        // <<DITW15.00.00.25 DDR 20/10/2008
                        CurrPage.UPDATE();
                        // >>DITW15.00.00.25 DDR
                        Post(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction();
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = Suite;
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Executes the Post and &Print action.';

                    trigger OnAction();
                    begin
                        // <<DITW15.00.00.25 DDR 20/10/2008
                        CurrPage.UPDATE();
                        // >>DITW15.00.00.25 DDR
                        Post(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'Executes the Test Report action.';

                    trigger OnAction();
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    ToolTip = 'Executes the Post &Batch action.';

                    trigger OnAction();
                    begin
                        // <<DITW15.00.00.25 DDR 20/10/2008
                        CurrPage.UPDATE();
                        // >>DITW15.00.00.25 DDR
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = Suite;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;
                    ToolTip = 'Executes the Remove From Job Queue action.';

                    trigger OnAction();
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
                separator(Separator201)
                {
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;
                    action("Prepayment Test &Report")
                    {
                        Caption = 'Prepayment Test &Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;
                        ToolTip = 'Executes the Prepayment Test &Report action.';

                        trigger OnAction();
                        begin
                            ReportPrint.PrintPurchHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ToolTip = 'Executes the Post Prepayment &Invoice action.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";

                        begin
                            // <<DITW15.00.00.25 DDR 20/10/2008
                            CurrPage.UPDATE();
                            // >>DITW15.00.00.25 DDR
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ToolTip = 'Executes the Post and Print Prepmt. Invoic&e action.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            // <<DITW15.00.00.25 DDR 20/10/2008
                            CurrPage.UPDATE();
                            // >>DITW15.00.00.25 DDR
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, true);
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ToolTip = 'Executes the Post Prepayment &Credit Memo action.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            // <<DITW15.00.00.25 DDR 20/10/2008
                            CurrPage.UPDATE();
                            // >>DITW15.00.00.25 DDR
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ToolTip = 'Executes the Post and Print Prepmt. Cr. Mem&o action.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            // <<DITW15.00.00.25 DDR 20/10/2008
                            CurrPage.UPDATE();
                            // >>DITW15.00.00.25 DDR
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, true);
                        end;
                    }
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;
                action("&Order")
                {
                    ApplicationArea = Suite;
                    Caption = '&Order';
                    Ellipsis = true;
                    Enabled = false;
                    Image = Print;
                    ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

                    trigger OnAction();
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144 - DITW110.00.08 DDR 02/01/2017 NRQ#0
                        //TESTFIELD(Status,Status::Released);
                        //>>DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
                        PurchaseHeader := Rec;
                        CurrPage.SETSELECTIONFILTER(PurchaseHeader);
                        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                        //CurrPage.PurchLines.PAGE.SetDisableRefreshLines(true);//BC Upgrade Manisha Drink it code commented
                        // >>DITW16.00.00.40 DDR DIT-715 #197
                        PurchaseHeader.PrintRecords(true);
                        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                        //CurrPage.PurchLines.PAGE.SetDisableRefreshLines(false);//BC Upgrade Manisha Drink it code commented
                        // >>DITW16.00.00.40 DDR DIT-715 #197
                    end;
                }
                action("&Shipping Agent Notice")
                {
                    Caption = '&Shipping Agent Notice';
                    Image = Print;
                    ToolTip = 'Executes the &Shipping Agent Notice action.';

                    trigger OnAction();
                    var
                        DocPrint: Codeunit "Document-Print";
                    begin
                        //? DITW110.00.08 DDR 02/01/2017 NRQ#0 TO BE REPLACED (don't use codeunit229 Document-Print)

                        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                        //CurrPage.PurchLines.PAGE.SetDisableRefreshLines(true);//BC Upgrade Manisha Drink it code commented
                        // >>DITW16.00.00.40 DDR DIT-715 #197
                        // <<DIT15.00.00.21 DDR 26/06/2008
                        // DocPrint.PrintPurchHeaderAgentNotice(Rec);//BC Upgrade Drink it code commented
                        // >>DIT15.00.00.21 DDR
                        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                        //CurrPage.PurchLines.PAGE.SetDisableRefreshLines(false);//BC Upgrade Drink it code commented
                        // >>DITW16.00.00.40 DDR DIT-715 #197
                    end;
                }
                action(SendCustom)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send';
                    Ellipsis = true;
                    Image = SendToMultiple;
                    ToolTip = 'Prepare to send the document according to the vendor''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';

                    trigger OnAction();
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader := Rec;
                        CurrPage.SETSELECTIONFILTER(PurchaseHeader);
                        PurchaseHeader.SendRecords();
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                group(Category_Category6)
                {
                    Caption = 'Posting', Comment = 'Generated from the PromotedActionCategories property index 5.';
                    ShowAs = SplitButton;

                    actionref(post1_Promoted; post1)
                    {
                    }
                    actionref("Post and Print_Promoted"; "Post and &Print")
                    {
                    }
                }
                group(Category_Category5)
                {
                    Caption = 'Release', Comment = 'Generated from the PromotedActionCategories property index 4.';
                    ShowAs = SplitButton;

                    actionref(Release_Promoted; Release)
                    {
                    }
                    actionref(Reopen_Promoted; Reopen)
                    {
                    }
                }

                actionref("Create Inventory PutAway_Promoted"; "Create Inventor&y Put-away/Pick")
                {
                }
            }
            group(Category_Prepare)
            {
                Caption = 'Prepare';

                actionref(CopyDocument_Promoted; CopyDocument)
                {
                }
                actionref("Get Std Vend_Promoted"; "Get St&d. Vend. Purchase Codes")
                {
                }
                group("Category_Incoming Document")
                {
                    Caption = 'Incoming Document';

                    actionref(IncomingDocAttachFile_Promoted; IncomingDocAttachFile)
                    {
                    }
                    actionref(SelectIncomingDoc_Promoted; SelectIncomingDoc)
                    {
                    }
                    actionref(IncomingDocCard_Promoted; IncomingDocCard)
                    {
                    }
                    actionref(RemoveIncomingDoc_Promoted; RemoveIncomingDoc)
                    {
                    }
                }
            }
            group(Category_Category4)
            {
                Caption = 'Approve', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(Approve_Promoted; Approve)
                {
                }
                actionref(Reject_Promoted; Reject)
                {
                }
                actionref(Comment_Promoted; Comment)
                {
                }
                actionref(Delegate_Promoted; Delegate)
                {
                }
            }
            group(Category_Category8)
            {
                Caption = 'Request Approval', Comment = 'Generated from the PromotedActionCategories property index 7.';

                actionref(SendApprovalRequest_Promoted; SendApprovalRequest)
                {
                }
                actionref(CancelApprovalRequest_Promoted; CancelApprovalRequest)
                {
                }
            }
            group(Category_Category5Order)
            {
                Caption = 'Order', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref(PurchaseOrderStatistics_Promoted; PurchaseOrderStatistics)
                {
                }
                actionref(Approvals_Promoted; Approvals)
                {
                }
                actionref("Comments_Promoted"; "Co&mments")
                {
                }
                actionref("PurchaseAdditional_Promoted"; "Purchase Additional")
                {
                }
                separator(Navigate_Separator)
                {
                }
                actionref(Card_Promoted; Card)
                {
                }
            }
            group(Category_Category10)
            {
                Caption = 'Print', Comment = 'Generated from the PromotedActionCategories property index 9.';

                actionref("Order_Promoted"; "&Order")
                {
                }
                actionref(SendCustom_Promoted; SendCustom)
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        /* //BC Upgrade Manisha Drink it code commented>>

        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        SETFILTER("Resp. Center Table Filter",
          UserMgt.GetRespCenterFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        SETFILTER("Phys. Location Table Filter",
          UserMgt.GetRespPhysLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        SETFILTER("Location Table Filter",
          UserMgt.GetRespLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        */ //BC Upgrade Manisha Drink it code commented<<

        // >>DITW18.00.06 DDR DIT-770 #1191
        //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //if "Responsibility Center" <> '' then//BC UPgrade Mnaisha Drink it field code commented
        //SETFILTER("Resp. Center Table Filter 2", '%1|%2', '', "Responsibility Center");//BC UPgrade Mnaisha Drink it field code commented
        //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        // <<DITW15.00.00.39 DDR 27/07/2011 #1407
        //Rec.CALCFIELDS("Disc.Promo. Order Calculated");//BC UPgrade Mnaisha Drink it field code commented
        // >>DITW15.00.00.34 DDR

        SetControlAppearance();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(rec.RECORDID);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RECORDID);

        //<< DITW18.00.07 VSC 04/05/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        //<< DITW18.00.07 VSC 26/05/2016 DIT-770 #1984
        /// DITW110.00.08 DDR 02/01/2017 NRQ#0
       // RouteAsMandatory := PurchSetup."Route Mandatory";//BC Upgrade Manisha Drink it code commented
        //>> DITW18.00.07 VSC 26/05/2016 DIT-770 #1984
        //<< DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
        //<<DITW19.00.08 MSF 09/09/2016 BL#10387
        //EditableVendorTax := not ReceivedPurchLinesExist;//BC Upgrade Manisha Drink it code commented

        //>>DITW19.00.08 MSF 09/09/2016 BL#10387
    end;

    trigger OnAfterGetRecord();
    begin
        /* //BC Upgrade Manisha Drink it code commented>>

        // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
        MaximumCubageOnFormat;
        MaximumWeightOnFormat;
        // >>DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
        */ //BC Upgrade Manisha Drink it code commented<<


        //>>HEI.07
        if (Rec."Blanket Order No. FND" <> '') or (Rec."SRM Contract No. FND" <> '') then
            ActivePrepayment := false
        else
            ActivePrepayment := true;
        //<<HEI.07
        if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then; //HEI.09
        // HEI.13 >>
        // PurchRcptHdrRec.RESET;
        // PurchRcptHdrRec.SETRANGE("Order No.",Rec."No.");
        // IF PurchRcptHdrRec.FINDFIRST THEN
        //<< HEI.09
        PurchLine2.SETRANGE("Document Type", Rec."Document Type");
        PurchLine2.SETRANGE("Document No.", Rec."No.");
        PurchLine2.SETFILTER("Quantity Received", '>%1', 0);
        if PurchLine2.FINDFIRST() then
            LicensiEdit := false;
        // HEI.13 <<
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        CurrPage.SAVERECORD();
        exit(Rec.ConfirmDeletion());
    end;

    trigger OnInit();
    begin
        // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
        "Maximum WeightVisible" := true;
        "Maximum CubageVisible" := true;
        // >>DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
        //<<DITW19.00.08 MSF 09/09/2016 BL#10387
        EditableVendorTax := true;
        //>>DITW19.00.08 MSF 09/09/2016 BL#10387

        SetExtDocNoMandatoryCondition();
        // HEI.09 >>
        LicensiEdit := true;
        //HEI.09 <<
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();

        if (not DocNoVisible) and (Rec."No." = '') then
            Rec.SetBuyFromVendorFromFilter();

        //HEI.02>>
        PurchasesPayablesSetup.GET;
        PurchasesPayablesSetup.TESTFIELD(PurchasesPayablesSetup."PO Subtype Code FND");
        Rec."Document Subtype Code FND" := PurchasesPayablesSetup."PO Subtype Code FND";  //BC Upgrade VAMSIU01 - added <<
        //HEI.02<<

    end;

    trigger OnOpenPage();
    begin
        SetDocNoVisible();
        /* //BC Upgrade Manisha Drink it code commented>>

        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1191
        //IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
        if UserMgt.GetPurchasesTextFilter <> '' then begin
            FILTERGROUP(2);
            //SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
            SETFILTER("Responsibility Center", UserMgt.GetPurchasesTextFilter);
            FILTERGROUP(0);

            //<< DITW18.00.07 VSC 26/05/2016 DIT-770 #1984 - DITW110.00.08 DDR 02/01/2017 NRQ#0
            PurchSetup.GET;
            //>> DITW18.00.07 VSC 26/05/2016 DIT-770 #1984 - DITW110.00.08 DDR NRQ#0
        end;
        // >>DITW18.00.06 DDR DIT-770 #1191
        */ //BC Upgrade Manisha Drink it code commented<<

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if not DocumentIsPosted then
            exit(Rec.ConfirmCloseUnposted());
    end;

    var
        DimSetEntryRec: Record "Dimension Set Entry";
        DimSetEntryRec_1: Record "Dimension Set Entry";
        DimSetEntryRec_2: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        TempDimSetEntry_1: Record "Dimension Set Entry";
        DimValRec: Record "Dimension Value";
        GenLedSetRec: Record "General Ledger Setup";
        PurchRcptHdrRec: Record "Purch. Rcpt. Header";
        PurchRec: Record "Purchase Header";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseLine: Record "Purchase Line";
        PurchLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        PurchLineRec: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        StdVendPurchCode: Record "Standard Vendor Purchase Code";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ArchiveManagement: Codeunit ArchiveManagement;
        DimMgt: Codeunit DimensionManagement;
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        DimValPage: Page "Dimension Values";

        ActivePrepayment: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        DocNoVisible: Boolean;
        DocumentIsPosted: Boolean;
        EditableVendorTax: Boolean;
        HasIncomingDocument: Boolean;
        HideValidationDialog: Boolean;
        ItemCategoryBool: Boolean;


        JobQueueVisible: Boolean;
        LicensiEdit: Boolean;

        "Maximum CubageEmphasize": Boolean;

        "Maximum CubageVisible": Boolean;

        "Maximum WeightEmphasize": Boolean;

        "Maximum WeightVisible": Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;

        PayToCommentBtnVisible: Boolean;

        PayToCommentPictVisible: Boolean;

        PurchHistoryBtn1Visible: Boolean;

        PurchHistoryBtnVisible: Boolean;

        RouteAsMandatory: Boolean;
        ShowWorkflowStatus: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        VendorShipmentNoMandatory: Boolean;
        DimValue: Code[10];
        LicenseCode: Code[20];
        LicenseCodeValue: Code[20];
        LicenseCodeValue_1: Code[20];
        I: Integer;
        NewDImSetId: Integer;
        OldDimSetId: Integer;
        OpenPostedPurchaseOrderQst: Label 'The order has been posted and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?';
        Text000: Label 'Please select the dimension for License Dimension in General Ledger Setup.';
        Text001: Label 'The seleced value cannot be found in the dimension value table.';
        Text002: Label 'You cannot edit the License code when the PO is created from PQ.';
        Text003: Label 'You cannot edit the License code when the PO when status is released.';
        Text004: Label 'License Dimension Value should be same for both header and line.';
        Text005: Label 'You cannot change the license code as receipts for %1 is already done.';
        Text50001: Label 'Do you want to create the outbound entries for this PO %1 for Astro WMS Interface?';
        Text2014410: Label '%1 %2 has been automatically released.';
        Text2014411: Label 'Do you want to cancel the approval request for %1 %2?';
        Text2014412: Label 'Do you want to send the approval request for %1 %2?';
        Text051: TextConst ENU = 'You may have changed a dimension.\\Do you want to update the lines?', FRA = 'Vous avez probablement modifié un axe analytique.\\Souhaitez-vous mettre à jour les lignes ?';
    // ASTRODispatchSyncStP: Report "ASTRO Dispatch Sync StP";//BC Upgrade Manisha Astro object code Commented


    local procedure Post(PostingCodeunitID: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        Rec.SendToPosting(PostingCodeunitID);

        DocumentIsPosted := not PurchaseHeader.GET(Rec."Document Type", Rec."No.");

        if Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" then
            CurrPage.CLOSE();
        CurrPage.UPDATE(false);

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
            ShowPostedConfirmationMessage();
    end;

    local procedure ApproveCalcInvDisc();
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc();
    end;

    local procedure PurchaserCodeOnAfterValidate();
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension1CodeOnAfterV();
    begin
        CurrPage.UPDATE();
    end;

    local procedure ShortcutDimension2CodeOnAfterV();
    begin
        CurrPage.UPDATE();
    end;

    local procedure PricesIncludingVATOnAfterValid();
    begin
        CurrPage.UPDATE();
    end;

    local procedure Prepayment37OnAfterValidate();
    begin
        CurrPage.UPDATE();
    end;

    local procedure SetDocNoVisible();
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Order, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.GET();
        VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory";
        //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
        //VendorShipmentNoMandatory := PurchasesPayablesSetup."Vendor Shipment No. Mandatory";//BC Upgrade Manisha Drink it code Commented

        //>> DITW18.00.07 AKH DIT-770 #1409
    end;

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');
        SetExtDocNoMandatoryCondition();

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    local procedure ShowPostedConfirmationMessage();
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        OrderPurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not OrderPurchaseHeader.GET(rec."Document Type", Rec."No.") then begin
            PurchInvHeader.SETRANGE("No.", Rec."Last Posting No.");
            if PurchInvHeader.FINDFIRST() then
                if InstructionMgt.ShowConfirm(OpenPostedPurchaseOrderQst, InstructionMgt.ShowPostedConfirmationMessageCode()) then
                    PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
        end;
    end;
    /* //BC Upgrade Manisha Drink it code commented>>

        local procedure FormatMaximumControls(pFieldNo: Integer; pMaxValue: Decimal; pTotalValue: Decimal);
        var
            lblnBold: Boolean;
            lcolor: Integer;
        begin
            // <<DIT15.00.00.21 DDR 19/06/2008
            lcolor := 0;
            lblnBold := false;

            if pMaxValue < pTotalValue then
                lcolor := 255;

            lblnBold := lcolor <> 0;

            // <<DITW15.00.00.25 DDR 09/10/2008
            "Maximum CubageVisible" := false;
            "Maximum WeightVisible" := false;
            // >>DITW15.00.00.25 DDR

            case pFieldNo of
                FIELDNO("Maximum Weight"):
                    begin
                        "Maximum WeightEmphasize" := lblnBold;
                    end;
                FIELDNO("Maximum Cubage"):
                    begin
                        "Maximum CubageEmphasize" := lblnBold;
                    end;
            end;

            // <<DITW15.00.00.25 DDR 09/10/2008
            "Maximum CubageVisible" := true;
            "Maximum WeightVisible" := true;
            // >>DITW15.00.00.25 DDR
        end;

        local procedure StatusOnAfterValidate();
        begin
            // <<DITW15.00.00.34 DDR 17/06/2009
            CurrPage.UPDATE(false);
        end;

        local procedure StatusOnValidate();
        begin
            // <<DITW15.00.00.34 DDR 17/06/2009
            if xRec.Status = Status then
                exit;

            // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
            if (xRec.Status = Status::Open) or (Status = Status::Released) then
                ReleasePurchDoc.DocStatusRelease(xRec, Rec)
            else begin
                if Status = Status::Open then
                    ReleasePurchDoc.DocStatusOpen(xRec, Rec)
                else
                    // >>DITW15.00.00.39 DDR #1330 #1407
                    TESTFIELD(Status, xRec.Status);
            end;
        end;

        local procedure MaximumCubageOnFormat();
        begin
            CALCFIELDS("Total Cubage");
            FormatMaximumControls(FIELDNO("Maximum Cubage"), "Maximum Cubage", "Total Cubage");
        end;

        local procedure MaximumWeightOnFormat();
        begin
            Rec.CALCFIELDS("Total Weight");
            FormatMaximumControls(Rec.FIELDNO(Rec."Maximum Weight"), Rec."Maximum Weight", Rec."Total Weight");
        end;
        */ //BC Upgrade Manisha Drink it code commented<<


    local procedure UpdateAllLineDimNew(NewParentDimSetID: Integer; OldParentDimSetID: Integer);
    var
        ReceivedShippedItemLineDimChangeConfirmed: Boolean;
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.
        // HEI.09 >>
        if NewParentDimSetID = OldParentDimSetID then
            exit;

        if not HideValidationDialog then
            if not CONFIRM(Text051) then
                exit;

        PurchLine.RESET();
        PurchLine.SETRANGE("Document Type", Rec."Document Type");
        PurchLine.SETRANGE("Document No.", Rec."No.");
        PurchLine.LOCKTABLE();
        if PurchLine.FIND('-') then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(PurchLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if PurchLine."Dimension Set ID" <> NewDimSetID then begin
                    PurchLine."Dimension Set ID" := NewDimSetID;

                    if not HideValidationDialog and GUIALLOWED then
                        VerifyReceivedShippedItemLineDimChange(ReceivedShippedItemLineDimChangeConfirmed);

                    DimMgt.UpdateGlobalDimFromDimSetID(
                      PurchLine."Dimension Set ID", PurchLine."Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 2 Code");
                    PurchLine.MODIFY();
                end;
            until PurchLine.NEXT() = 0;
        //HEI.09 <<
    end;
    // BC Upgrade PATELP08 >> Blocking this as the Table 'Purchase Header' already defines a method called 'SetHideValidationDialog' with the same parameter types.
    // procedure SetHideValidationDialog(NewHideValidationDialog: Boolean);
    // begin
    //     HideValidationDialog := NewHideValidationDialog;//HEI.09
    // end;
    // BC Upgrade PATELP08 <<
    local procedure VerifyReceivedShippedItemLineDimChange(var ReceivedShippedItemLineDimChangeConfirmed: Boolean);
    begin
        //HEI.09>>
        if PurchLine.IsReceivedShippedItemDimChanged() then
            if not ReceivedShippedItemLineDimChangeConfirmed then
                ReceivedShippedItemLineDimChangeConfirmed := PurchLine.ConfirmReceivedShippedItemDimChange();
        //HEI.09 <<
    end;
}

