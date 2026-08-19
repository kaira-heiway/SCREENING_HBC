page 51052 "NPO Prepayment Request CBN"
{
    // version HEI.01

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
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added fields
    //                                         Route Planning No.
    //                                         Multiple Route Order
    //                                         "Trailer Code"
    //                                         Field Editable IF NOT Multile Route Order
    // 
    // HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
    //   # New field Vendor Bank Account

    // HEI.02 HLSRM02-05 IBM LAZARE02 31.07.2017
    //   #New fields for SRM integration added to SRM tab => BC Upgrade SHUKLP03 - SRM tab is not found in Navision so created.

    // HEI.03 FDD-PTPGAP007 IBM PATHAA02 28.08.2017
    // # Made property "Showmandatory" to True for the field "Vendor Bank Account"

    // HEI.04 FDD-PURGAPINT005 IBM NASTAA02 28.09.2017 # Purchase Order Layout Template Procurement
    //   # Print button should be enabled just when "SRM Order No." is empty

    // HEI.05 FDD-HNK PTPGAP067 IBM. ISYED01 24/10/2017
    //   #Code blocked on OnInit() and OnNewRecord trigger because filters are applied on DrinkIT "Document Subtype Code" field.

    // HEI.06 CHG0255417 IBM.LS 15.10.2018
    //   # Code added to restrict the field modification.
    // HEI.07 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    //   # Made Field "Vendor Posting Group" non-editable

    //DrinkIT code and fields are blocked.

    // BC Upgrade MISHRS14 >>
    // Blocked OpenPurchaseOrderStatistics on OnActiontrigger of Statistics action due to warning
    // BC Upgrade MISHRS14 <<

    // BC Upgrade SHUKLP03 >> Added document subtype related code.

    Caption = 'NPO Prepayment Request';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval,Print';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = FILTER(Order));
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    // UsageCategory = Documents; // BC Upgrade SHUKLP03 << // BC Upgrade BHARAD11 

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
                    var
                        FinancialUtils: Codeunit "Financial-Utils";
                    begin
                        // BC Upgrade SHUKLP03 >> DrinkIT code is added
                        // //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
                        // if "Sundry Vendor" then
                        //   ShowVendorSundryInfo();
                        // //>> DITW18.00.07 AKH DIT-770 #1804
                        // BC Upgrade SHUKLP03 << DrinkIT code is added

                        if Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
                            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                                Rec.SETRANGE("Buy-from Vendor No.");


                        CurrPage.UPDATE(true);

                        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
                        // // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01)
                        // COMMIT;
                        //HEI.01>>
                        FinancialUtils.InsertGLLinePrep(Rec);
                        CurrPage.UPDATE(true);
                        COMMIT();
                        //HEI.01<<
                        // StdVendPurchCode.AutoInsertPurchLines(Rec);
                        // // >>DITW15.00.00.39 DDR #1323 (BE5.00.01)
                        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
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
                    var
                        FinancialUtils: Codeunit "Financial-Utils";
                    begin
                        if Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
                            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                                Rec.SETRANGE("Buy-from Vendor No.");

                        CurrPage.UPDATE();
                        //HEI.01>>
                        FinancialUtils.InsertGLLinePrep(Rec);
                        CurrPage.UPDATE(true);
                        COMMIT();
                        //HEI.01<<
                    end;
                }
                // BC Upgrade SHUKLP03 >> Document subtype field added.
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    Editable = DocumentSubTypeEnabled;
                    ApplicationArea = All;
                } // BC Upgrade SHUKLP03 << Document subtype field added.
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
                // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                // field("Tax Date"; Rec."Tax Date")
                // {
                //     Importance = Additional;
                //     QuickEntry = false;
                // } // BC Upgrade SHUKLP03 << DrinkIT field blocked.
                group(Control1100710018)
                {
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                // field("Vendor Tax Registration No."; Rec."Vendor Tax Registration No.")
                // {
                //     Description = 'DITW15.00.00.28,DITW19.00.08 BL#10387';
                //     Editable = EditableVendorTax;
                // }
                // field("Vendor Tax Warehouse Ref."; "Vendor Tax Warehouse Ref.")
                // {
                //     Description = 'DITW15.00.00.38 #1217,DITW19.00.08 BL#10387';
                //     Editable = EditableVendorTax;
                // } // BC Upgrade SHUKLP03 << DrinkIT field blocked.
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Suite;
                    Editable = EditableMultipleRouteOrder;
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
                field("Your Reference"; Rec."Your Reference")
                {
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the vendor''s reference.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';

                    trigger OnValidate();
                    begin
                        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
                        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        // if "Responsibility Center" <> xRec."Responsibility Center" then
                        //     CurrPage.UPDATE(true);
                        // // >>DITW18.00.06 DDR DIT-770 #1191
                        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
                    end;
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                // field("Physical Location Group Code"; "Physical Location Group Code")
                // {
                //     Description = '<DITW18.00.06 DIT-770 #1191>-NRQ#16082';
                //     Editable = EditableMultipleRouteOrder;
                //     Importance = Additional;
                //     QuickEntry = false;

                //     trigger OnValidate();
                //     begin
                //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                //             CurrPage.UPDATE(true);
                //         // >>DITW18.00.06 DDR DIT-770 #1191
                //     end;
                // } // BC Upgrade SHUKLP03 << DrinkIT field blocked.
                field(LocationCodeNew; Rec."Location Code")
                {
                    Description = 'NRQ#16082';
                    Editable = EditableMultipleRouteOrder;
                    QuickEntry = false;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';

                    trigger OnValidate();
                    begin
                        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
                        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        // if "Location Code" <> xRec."Location Code" then
                        //     CurrPage.UPDATE(true);
                        // // >>DITW18.00.06 DDR DIT-770 #1191
                        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
                    end;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                // field("Requester ID"; Rec."Requester ID")
                // {
                //     Description = 'DITW17.00.02 DIT-770 #144';
                // } // BC Upgrade SHUKLP03 << DrinkIT field blocked.
                field(Status; Rec.Status)
                {
                    Description = 'DITW17.00.02 DIT-770 #170';
                    Importance = Promoted;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';

                    trigger OnValidate();
                    begin
                        StatusOnValidate();
                        StatusOnAfterValidate();
                    end;
                }
                // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
                // field("Creation Date/Time"; Rec."Creation Date/Time")
                // {
                //     Description = 'DITW18.00.07 DIT-770 #1282';
                //     Importance = Additional;
                // }
                // field("Created By"; Rec."Created By")
                // {
                //     Description = 'DITW18.00.07 DIT-770 #1282';
                //     Importance = Additional;
                // }
                // field("Document Shipping Costs"; HasDocumentShippingCosts)
                // {
                //     Caption = 'Document Shipping Costs';

                //     trigger OnDrillDown();
                //     begin
                //         //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
                //         OpenDocumentShippingCosts;
                //         //>> DITW18.00.07 VSC DIT-770 #1066
                //     end;
                // }
                // field("Emergency Order"; Rec."Emergency Order")
                // {
                // }
                // field("Last changed User ID"; Rec."Last changed User ID")
                // {
                //     Editable = false;
                // }
                // field("Last changed Date/time"; "Last changed Date/time")
                // {
                //     Editable = false;
                // }
                // field("Linked Customer No."; "Linked Customer No.")
                // {
                //     Importance = Additional;
                // } // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = JobQueueUsed;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase orders.';
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                // field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
                // {
                //     Importance = Additional;
                // } // BC Upgrade SHUKLP03 << DrinkIT field blocked.
                field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
                {
                    ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
                }
                // >> HEI.02
                group(SRM_Tab)
                {
                    field("SRM Contract Name"; Rec."SRM Contract Name FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the SRM Contract Name field.';
                    }
                    field("SRM Contract No."; Rec."SRM Contract No. FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the SRM Contract No. field.';
                    }
                    field("SRM Contract Type"; Rec."SRM Contract Type FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Contract Type field.';
                    }
                    field("SRM Order No."; Rec."SRM Order No. FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the SRM Order No. field.';
                    }
                    field("SRM Version No."; Rec."SRM Version No. FND")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the SRM Version No. field.';
                    }
                }
                // << HEI.02
            }
            part(PurchLines; "Prepayment Request Subform CBN")
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
                // BC Upgrade SHUKLP03 >> DrinkIT field blocked.
                // field("Sundry Vendor"; Rec."Sundry Vendor")
                // {
                // } // BC Upgrade SHUKLP03 << DrinkIT field blocked.
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the code that represents the payment terms that apply to the purchase order.';

                    trigger OnValidate();
                    begin
                        //HEI.06>>
                        UserSetup.GET(USERID);
                        if (Rec."Payment Terms Code" <> xRec."Payment Terms Code") and (xRec."Payment Terms Code" <> '') then begin
                            ERROR(Text0001, Rec.FIELDCAPTION("Payment Terms Code"));
                        end;
                        //HEI.06<<
                    end;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies how payment for the purchase document must be submitted.';

                    trigger OnValidate();
                    begin
                        //HEI.06>>
                        UserSetup.GET(USERID);
                        if (Rec."Payment Method Code" <> xRec."Payment Method Code") and (xRec."Payment Method Code" <> '') then begin
                            ERROR(Text0001, Rec.FIELDCAPTION("Payment Method Code"));
                        end;
                        //HEI.06<<
                    end;
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
            }
            group("Shipping and Payment")
            {
                Caption = 'Shipping and Payment';
                group("Pay-to")
                {
                    Caption = 'Pay-to';
                    field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
                    {
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the Vendor Bank Account field.';
                    }
                    field(IBAN; Rec."IBAN FND")
                    {
                        ToolTip = 'Specifies the value of the IBAN field.';
                    }
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                field("Prepayment %"; Rec."Prepayment %")
                {
                    Editable = PrepaymentEnabled;
                    Importance = Promoted;
                    ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for purchase.';

                    trigger OnValidate();
                    begin
                        Prepayment37OnAfterValidate();
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ToolTip = 'Specifies that prepayments on the purchase order are combined if they have the same general ledger account for prepayments or the same dimensions.';
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ToolTip = 'Specifies the code that represents the payment terms for prepayment invoices related to the purchase document.';
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies when the prepayment invoice for this purchase order is due.';
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ToolTip = 'Specifies the number that the vendor uses for the credit memo you are creating in this purchase credit memo header.';
                }
            }
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
            // BC Upgrade SHUKLP03 >> Blocked becaused DrinkIT page is used as a part page.
            // part(Control1907232107; "Purchase Line FactBox2")
            // {
            //     Provider = PurchLines;
            //     SubPageLink = "Document Type" = FIELD("Document Type"),
            //                   "Document No." = FIELD("Document No."),
            //                   "Line No." = FIELD("Line No.");
            //     Visible = true;
            // } // BC Upgrade SHUKLP03 << Blocked becaused DrinkIT page is used as a part page.
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
            systempart("<RecordLinks>"; Notes)
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
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SAVERECORD();
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';

                    // BC Upgrade MISHRS14 >>
                    // Blocked OpenPurchaseOrderStatistics on OnActiontrigger of Statistics action due to warning
                    trigger OnAction();
                    begin
                        //Rec.OpenPurchaseOrderStatistics();
                        // BC Upgrade MISHRS14 <<

                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Card)
                {
                    ApplicationArea = Suite;
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
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
                        ApprovalEntries.SetRecordfilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
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
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
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
                separator(Separator182)
                {
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
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
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
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
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
                    Promoted = true;
                    PromotedCategory = Category4;
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
                    Promoted = true;
                    PromotedCategory = Category4;
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
                // BC Upgrade SHUKLP03 >> Blocked because release and reopen code is written in DrinkIT created "DocStatusRelease" and "DocStatusOpen" procedure.
                // action(Release)
                // {
                //     Caption = 'Re&lease';
                //     Image = ReleaseDoc;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     ShortCutKey = 'Ctrl+F9';

                //     trigger OnAction();
                //     var
                //         ReleasePurchDoc: Codeunit "Release Purchase Document";
                //     begin
                //         // <<DITW15.00.00.23.04 DDR 15/09/2008 - DITW15.00.00.36 DDR 07/12/2009
                //         CurrPage.UPDATE(true);
                //         // >>DITW15.00.00.23.04 DDR
                //         // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                //         //ReleasePurchDoc.PerformManualRelease(Rec);
                //         //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
                //         if "Sundry Vendor" then
                //             TestSundryMandatoryFields();
                //         //>> DITW18.00.07 DIT-770 #1804
                //         ReleasePurchDoc.DocStatusRelease(xRec, Rec);
                //         CurrPage.UPDATE;
                //         // >>DITW15.00.00.39 DDR #1330 #1407
                //     end;
                // }
                // action(Reopen)
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Re&open';
                //     Enabled = Status <> Status::Open;
                //     Image = ReOpen;
                //     Promoted = true;
                //     PromotedCategory = Category5;
                //     ShortCutKey = 'Ctrl+F10';
                //     ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

                //     trigger OnAction();
                //     var
                //         ReleasePurchDoc: Codeunit "Release Purchase Document";
                //     begin
                //         // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                //         //ReleasePurchDoc.PerformManualReopen(Rec);
                //         ReleasePurchDoc.DocStatusOpen(xRec, Rec);
                //         CurrPage.UPDATE;
                //         // >>DITW15.00.00.39 DDR #1330 #1407
                //     end;
                // } // BC Upgrade SHUKLP03 >> Blocked because release and reopen code is written in DrinkIT created "DocStatusRelease" and "DocStatusOpen" procedure.
                separator(Separator611)
                {
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                // BC Upgrade SHUKLP03 >> Blocked because DrinkIT created field "Sundry Vendor" is used for group visibility and on tigger OnAction code is written by DrinkIT.     
                //     action("Change Sundry vendor fields")
                //     {
                //         Caption = 'Change Sundry vendor fields';
                //         Image = ChangeCustomer;
                //         Promoted = true;
                //         PromotedIsBig = true;
                //         Visible = "Sundry Vendor";

                //         trigger OnAction();
                //         begin
                //             //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
                //             ShowVendorSundryInfo();
                //             //>> DITW18.00.07 DIT-770 #1804
                //             //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
                //             CurrPage.UPDATE(true);
                //             //>> DITW18.00.07 DIT-770 #1804
                //         end;
                //     } // BC Upgrade SHUKLP03 >> Blocked because DrinkIT created field "Sundry Vendor" is used for group visibility and tigger OnAction code is written by DrinkIT
                separator(Separator190)
                {
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
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Copy Document action.';

                    trigger OnAction();
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL();
                        CLEAR(CopyPurchDoc);
                        if Rec.GET(Rec."Document Type", Rec."No.") then;
                    end;
                }
                separator(Separator1100083000)
                {
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
                        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
                        // // <<DITW15.00.00.25 DDR 20/10/2008
                        // CurrPage.UPDATE;
                        // // >>DITW15.00.00.25 DDR
                        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

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
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        // SETFILTER("Resp. Center Table Filter",
        //   UserMgt.GetRespCenterFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
        // SETFILTER("Phys. Location Table Filter",
        //   UserMgt.GetRespPhysLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
        // SETFILTER("Location Table Filter",
        //   UserMgt.GetRespLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
        // // >>DITW18.00.06 DDR DIT-770 #1191
        // //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        // if "Responsibility Center" <> '' then
        //   SETFILTER("Resp. Center Table Filter 2",'%1|%2','',"Responsibility Center");
        // //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        // // <<DITW15.00.00.39 DDR 27/07/2011 #1407
        // CALCFIELDS("Disc.Promo. Order Calculated");
        // // >>DITW15.00.00.34 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code is blocked.

        SetControlAppearance();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RECORDID);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RECORDID);

        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // //<< DITW18.00.07 VSC 04/05/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        // //<< DITW18.00.07 VSC 26/05/2016 DIT-770 #1984
        // /// DITW110.00.08 DDR 02/01/2017 NRQ#0
        // RouteAsMandatory := PurchSetup."Route Mandatory";
        // //>> DITW18.00.07 VSC 26/05/2016 DIT-770 #1984
        // //<< DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
        // //<<DITW19.00.08 MSF 09/09/2016 BL#10387
        // EditableVendorTax := not Rec.ReceivedPurchLinesExist;
        // //>>DITW19.00.08 MSF 09/09/2016 BL#10387
        // //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        // if not "Multiple Order Route" then
        //     EditableMultipleRouteOrder := true
        // else
        //     EditableMultipleRouteOrder := false;
        // //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

        //>>HEI.01
        PrintEnabled := Rec."SRM Order No. FND" = '';
        //<<HEI.01
    end;

    trigger OnAfterGetRecord();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
        // MaximumCubageOnFormat;
        // MaximumWeightOnFormat;
        // // >>DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        CurrPage.SAVERECORD();
        exit(Rec.ConfirmDeletion());
    end;

    trigger OnInit();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
        // "Maximum WeightVisible" := true;
        // "Maximum CubageVisible" := true;
        // // >>DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
        // //<<DITW19.00.08 MSF 09/09/2016 BL#10387
        // EditableVendorTax := true;
        // //>>DITW19.00.08 MSF 09/09/2016 BL#10387
        // //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        // EditableMultipleRouteOrder := true;
        // //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.

        JobQueueUsed := PurchasesPayablesSetup.JobQueueActive();
        SetExtDocNoMandatoryCondition();
        //HEI.05>>
        PrepaymentEnabled := false;
        DocumentSubTypeEnabled := false;
        //HEI.05>>

        // BC Upgrade SHUKLP03 >> "Document Subtype Code" code added.
        //Rec.VALIDATE("Prepayment %",100);
        PurchasesPayablesSetup.GET();
        PurchasesPayablesSetup.TESTFIELD("NPO Prepayment req.subtype FND");
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Document Subtype Code FND", PurchasesPayablesSetup."NPO Prepayment req.subtype FND");
        Rec.FILTERGROUP(0);
        //HEI.03<<
        if PurchasesPayablesSetup."NPO Prepayment req.subtype FND" <> '' then
            Rec."Document Subtype Code FND" := PurchasesPayablesSetup."NPO Prepayment req.subtype FND"
        else
            ERROR(Error001);
        // BC Upgrade SHUKLP03 << "Document Subtype Code" code added.

        //HEI.05<<
        //HEI.05<<
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();

        if (not DocNoVisible) and (Rec."No." = '') then
            Rec.SetBuyFromVendorFromFilter();

        // BC Upgrade SHUKLP03 >> "Document Subtype Code" code added.    
        //HEI.05>>
        Rec.VALIDATE("Prepayment %", 100);
        PurchSetup.RESET();
        PurchSetup.GET();

        if PurchSetup."NPO Prepayment req.subtype FND" <> '' then
            Rec."Document Subtype Code FND" := PurchSetup."NPO Prepayment req.subtype FND"
        else
            ERROR(Error001);

        //HEI.05<<
        // BC Upgrade SHUKLP03 << "Document Subtype Code" code added.
    end;

    trigger OnOpenPage();
    begin
        SetDocNoVisible();

        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1191
        // //IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
        // if UserMgt.GetPurchasesTextFilter <> '' then begin
        //     FILTERGROUP(2);
        //     //SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
        //     SETFILTER("Responsibility Center", UserMgt.GetPurchasesTextFilter);
        //     FILTERGROUP(0);

        //     //<< DITW18.00.07 VSC 26/05/2016 DIT-770 #1984 - DITW110.00.08 DDR 02/01/2017 NRQ#0
        //     PurchSetup.GET;
        //     //>> DITW18.00.07 VSC 26/05/2016 DIT-770 #1984 - DITW110.00.08 DDR NRQ#0
        // end;
        // // >>DITW18.00.06 DDR DIT-770 #1191
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if not DocumentIsPosted then
            exit(Rec.ConfirmCloseUnposted());
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        StdVendPurchCode: Record "Standard Vendor Purchase Code";
        UserSetup: Record "User Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CanCancelApprovalForRecord: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        DocNoVisible: Boolean;
        DocumentIsPosted: Boolean;
        DocumentSubTypeEnabled: Boolean;
        EditableMultipleRouteOrder: Boolean;
        EditableVendorTax: Boolean;
        HasIncomingDocument: Boolean;

        JobQueueUsed: Boolean;


        JobQueueVisible: Boolean;

        "Maximum CubageEmphasize": Boolean;

        "Maximum CubageVisible": Boolean;

        "Maximum WeightEmphasize": Boolean;

        "Maximum WeightVisible": Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;

        PayToCommentBtnVisible: Boolean;

        PayToCommentPictVisible: Boolean;
        PrepaymentEnabled: Boolean;
        PrintEnabled: Boolean;

        PurchHistoryBtn1Visible: Boolean;

        PurchHistoryBtnVisible: Boolean;

        RouteAsMandatory: Boolean;
        ShowWorkflowStatus: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        VendorShipmentNoMandatory: Boolean;
        Error001: Label 'To Create Purchase Order of Type Prepayment Request, fill docsubtype in Purchase & payble setup.';
        OpenPostedPurchaseOrderQst: Label 'The order has been posted and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?';
        Text0001: Label '"You cannot modify the field- ''%1''. "';
        Text2014410: Label '%1 %2 has been automatically released.';
        Text2014411: Label 'Do you want to cancel the approval request for %1 %2?';
        Text2014412: Label 'Do you want to send the approval request for %1 %2?';

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

        // BC Upgrade SHUKLP03 >> DrinkIT code blocked.
        // //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
        // VendorShipmentNoMandatory := PurchasesPayablesSetup."Vendor Shipment No. Mandatory";
        // //>> DITW18.00.07 AKH DIT-770 #1409
        // BC Upgrade SHUKLP03 << DrinkIT code blocked.
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
        if not OrderPurchaseHeader.GET(Rec."Document Type", Rec."No.") then begin
            PurchInvHeader.SETRANGE("No.", Rec."Last Posting No.");
            if PurchInvHeader.FINDFIRST() then
                if InstructionMgt.ShowConfirm(OpenPostedPurchaseOrderQst, InstructionMgt.ShowPostedConfirmationMessageCode()) then
                    PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
        end;
    end;

    // BC Upgrade SHUKLP03 >> Drink function blocked.
    // local procedure FormatMaximumControls(pFieldNo: Integer; pMaxValue: Decimal; pTotalValue: Decimal);
    // var
    //     lblnBold: Boolean;
    //     lcolor: Integer;
    // begin
    //     // <<DIT15.00.00.21 DDR 19/06/2008
    //     lcolor := 0;
    //     lblnBold := false;

    //     if pMaxValue < pTotalValue then
    //         lcolor := 255;

    //     lblnBold := lcolor <> 0;


    //     // <<DITW15.00.00.25 DDR 09/10/2008
    //     "Maximum CubageVisible" := false;
    //     "Maximum WeightVisible" := false;
    //     // >>DITW15.00.00.25 DDR

    //     case pFieldNo of
    //         FIELDNO("Maximum Weight"):
    //             begin
    //                 "Maximum WeightEmphasize" := lblnBold;
    //             end;
    //         FIELDNO("Maximum Cubage"):
    //             begin
    //                 "Maximum CubageEmphasize" := lblnBold;
    //             end;
    //     end;

    //     // <<DITW15.00.00.25 DDR 09/10/2008
    //     "Maximum CubageVisible" := true;
    //     "Maximum WeightVisible" := true;
    //     // >>DITW15.00.00.25 DDR
    // end;
    // BC Upgrade SHUKLP03 << Drink function blocked.

    local procedure StatusOnAfterValidate();
    begin
        // <<DITW15.00.00.34 DDR 17/06/2009
        CurrPage.UPDATE(false);
    end;

    local procedure StatusOnValidate();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
        // // <<DITW15.00.00.34 DDR 17/06/2009
        // if xRec.Status = Rec.Status then
        //   exit;

        // // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        // if (xRec.Status = Status::Open) or (Status = Status::Released) then
        //   ReleasePurchDoc.DocStatusRelease(xRec,Rec)
        // else begin
        //   if Status = Status::Open then
        //     ReleasePurchDoc.DocStatusOpen(xRec,Rec)
        //   else
        // // >>DITW15.00.00.39 DDR #1330 #1407
        // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
        Rec.TESTFIELD(Status, xRec.Status);
    end;
    //end;

    // BC Upgrade SHUKLP03 >> Drink functions are blocked 
    // local procedure MaximumCubageOnFormat();
    // begin
    //     CALCFIELDS("Total Cubage");
    //     FormatMaximumControls(FIELDNO("Maximum Cubage"), "Maximum Cubage", "Total Cubage");
    // end;

    // local procedure MaximumWeightOnFormat();
    // begin
    //     CALCFIELDS("Total Weight");
    //     FormatMaximumControls(FIELDNO("Maximum Weight"), "Maximum Weight", "Total Weight");
    // end;
    // BC Upgrade SHUKLP03 << Drink functions are blocked.
}

