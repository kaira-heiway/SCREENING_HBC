pageextension 52020 PurchaseReturnOrderExt extends "Purchase Return Order"
{
    // version NAVW110.0.00.16585,DITW110.00.11,HEI.18
    //   DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    //   DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                  New calling functions to insert (item) charges
    //   DITW15.00.00.01 DDR 21/01/2008 Remove unused textconst
    //   DITW15.00.00.01 DDR 27/02/2008 Drink-it Return Deposit functionnalities
    //                                  Added menu "&Orders" into "Ret.Order" button
    //                                  Added field "Link Purch. Document Type","Link Purch. Document No." into general tab
    //   DITW15.00.00.01 DDR 11/03/2008 Hide "Link Purchase Document Type" when no link document
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //                                  Correct menu "&Return Orders" into "Order" button
    //   DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code","Driver Code" into "Shipping" tab
    //                       21/10/2008 Deleted field2013722 Duty Tax Type
    //                                  Added fields "Vendor DTax Group Code" into Invoicing tab
    //   DITW15.00.00.28 DDR 24/11/2008 Added "Fiscal Representative No." into Shipping tab
    //                                  Replaced "Print" Button by MenuButton
    //                                  Added menu "Test AAD Document" into "Print" Button
    //                       02/12/2008 Added "Shipping Agent" tab + fields
    //                                  Added function FormatMaximumControls()
    //   DITW15.00.00.33 DDR 07/05/2009 Move field "Customer DTax Group Code" into 'General' tab
    //   DITW15.00.00.34 DDR 16/06/2009 Added auto-release document into menu 'Create Whse. shipment'
    //                       17/06/2009 Added shortcut key CTRL+F10 to switch status 'open' the current document
    //                                  Changed Editable "Status" field
    //                                  Added functions DocStatusRelease(),DocStatusOpen(),
    //   DITW15.00.00.36 DDR 07/12/2009 issue 981 Bugfix Save/Refresh before release function
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   CEL 13/08/2010           Modification RTC buttons
    //   DITW15.00.00.38 DDR 27/01/2011 issue 1217 (DIT711 137) Added fields "Tax Office Code" into 'Shipping' tab
    //   DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                             Added parameter line function RTCActionNewLine() into RTCNewLine button
    //   DITW15.00.00.39 DDR 10/05/2011 issue 1330 Upgrade editable Status to work with Approval requests
    //                                             Remove 'ShowConfirmMsg' parameter function DocStatusOpen();
    //                                             Modified functions DocStatusOpen(),DocStatusRelease()
    //                                             Modified validate trigger field "Status"
    //                       27/07/2011 issue 1407 Added flowfields "Disc.Promo. Order Calculated" (see "Zoom view)
    //                                             Moved/Deleted functions into codeunit414 Release Sales Document
    //                                               DocStatusRelease(),DocStatusOpen()
    //   DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                                Added to insert first line automatically
    //                       19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    //   DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields "Delivery Sequence" (Shipping Agent tab)
    //                       22/12/2011 DIT-715 issue 187 Added 'Comments - Transport Mode' menu into 'Order' button
    //                                                    Added fields into 'Foreign Trade' tab
    //                                                      "Transport Mode","Transport Mode Comment"
    //   DITW16.00.00.40 DDR 22/12/2011 issue 1429 Added menu 'SSCC Tracking Lines' in 'Line' buttton
    //                       11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                    call function SetDisableRefreshLines() before each report
    //                                                    (don't use the <RunObject> property)
    //   DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added 'Service/Contract' tab
    //                                               Added fields into 'Service/Contract' tab
    //                                                 "DIT Sub-Contract Type","Contract Group Code","Service Contract No."
    //                                               Moved "Building No." into 'Service/Contract' tab
    //   DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added in General Tab
    //   DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code"
    //   DITW18.00.06 DDR 25/02/2015 DIT-770 #1191 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                             Rename Field Service contract Type => Contract Type
    //   DITW18.00.07 AKH 11/02/2016 DIT-770 #1804 Sundry Vendor
    //   DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Fixed caption for field "Sundry Vendor"
    //   DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Added Field 2014300 "Submission Type" (Shipping)
    //   DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    //   DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add HasDocumentShippingCosts to General TAB
    //   DITW18.00.07 AKH 28/03/2016 DIT-770 #1409 Added field "Vendor Shipment No." with "ShowMandatory" property
    //   DITW19.00.07 MVN 25/01/2016 DIT-770 #1740: DISABLED Approval
    //   DITW18.00.07 AKH 09/05/2016 DIT-770 #1804 Adjustment
    //   DITW18.00.07 VSC 26/05/2016 DIT-770 #1984 Added Route field for Mandatory check on release document
    //   DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    //   DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"
    //   DITW19.00.08 MSF 30/08/2016 BL#10387 (DIT-770 #1274) Vendor - Tax information depending on Receiving-From/Shipped-From addresses
    //   DITW19.00.08 MSF 05/09/2016 BL#10387 (DIT-770 #1274) If receipt/return shipment, don't allow to modify the tax reg no or whse ref
    //   DITW19.00.08 MSF 09/09/2016 BL#10387 (DIT-770 #1274) Review Code

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   DITW110.00.09 DDR 20/04/2017 NRQ#13107 Add all country code fields
    //   DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    //   DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added fields
    //                                           Route Planning No.
    //                                           Multiple Route Order
    //                                           "Trailer Code"
    //                                           Field Editable IF NOT Multile Route Order
    //   DITW110.00.11 MSF 30/11/2017 NRQ#16082 Remove Condition EditableMultipleRouteOrder  on SOme fields
    //   HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to PayÆ Bank account for payment
    //     # New field Vendor Bank Account

    //   HEI.02 HLSRM02 IBM LAZARE02 01.11.2017 # New field "Blanker Order No."; New tab SRM
    //   HEI.03 RFC-CHG0246348 IBM.AB 08.10.2018
    //     # Field Purchase Reason Code added
    //     # Code added to make under Reopen action to archive and make Purchase Reason Code blank
    //   HEI.04 RFC-CHG0249183 IBM.LS 18.01.2019
    //     # Added code to execute Auto Email functionality on Release.
    //     # Added fields - "BRC Purchase Order" and "SRM Order No.".
    //   DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
    //                                 Added Field "Disable DIT Disc. Prom."
    //   HEI.06 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //     # Created new Page Action "Purchase Additional"
    //   HEI.07 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //     # New Field added: "FA Acquisition"
    //   HEI.08 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //    # New Field Added License Code
    //    # Code added in triggers
    //   HEI.09 CHG2062340 HB1378 IBM GAVANM01 29.07.2020 #Retrofitting the Brewco Æ Sellco
    //     # for the action "Auto Send IC Return Order": delete Visible property, add Enabled property
    //   FINXL11.00 HBA 03/05/2018 NRQ#69018 : Added Action "Auto. Send IC Return Order"
    //   DITW111.00.13A NLAB 25/06/2019 NRQ#113801 : Merge NRQ#69018
    //   FINXL14.00.15 MSF 13/05/2020 NRQ#117628 Enable /Disable AutoSend To IC
    //   HEI.10 CHG2073467 HB1369 IBM GAVANM01 17.08.2020  Enhancements to the Intercompany automation functionality
    //     # new field added: IC Order No.
    //     # Code added on OnAfterGetRecord trigger
    //     # hide action "Send IC Return Order"
    //     # Properties changed for Auto. Send IC Return Order: Promoted=yes, PromotedCategory=Process, PromotedIsBig=yes
    //   HEI.13 HT1136 CHG2084917 IBM.GUNERE01 11.03.2020 # OnOpenPage, OnAfterGetrecord, License code validation trigger modified
    //   HEI.14 CHG2088873 IBM.GUNERE01 11.26.2020 # License Code onDrillDown, Post and Release funcs. modified
    //   HEI.15 CHG2073468 HB1369 IBM GAVANM01 04.01.2021 Enhancements to Intercompany Part 3
    //     # New field added: PurchaseHeaderAdditional."Special Order No."
    //   HEI.16 CHG2155847 HB2821 IBM NANDIS01 10.11.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //     # Button added "Process PO for Astro WMS" to create astro entries
    //   HEI.17 CHG2155847 HB2821 IBM NANDIS01 24.11.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //     # Button "Process PO for Astro WMS" made invisible as Return Order is now out of scope
    //   HEI.18 CHG2155847 HB2821 IBM NANDIS01 19.12.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //     # Astro wms PO field added in Page witha TAB - AStro WMS
    //**********************************************//
    //BC UPGRADE SIVA 20/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.01 No changes HEI.02 
    //2.HEI.03  Added Reopen action due to code will excute before Action after base code will run.
    //3.HEI.04  Code added Release before action() due to custom code need to validate after base code will run.  
    //3.HEI.07  Added field in page layout.   
    //4.HEI.06  Added Purchase Additional action
    //5.HEI.08  Added Field & code in Onvalidate trigger.
    //6.HEI.09  Action "Auto Send IC Return Order" not exist in NAV & as same BC.
    //7.HEI.10  Added code Onaftergetrecord() trigger.
    //8.HEI.13  Added code OnOpenPage, OnAfterGetrecord, License code validation trigger modified
    //9.HEI.14  Added code in License Code onDrillDown 
    //10.HEI.15  New field added: PurchaseHeaderAdditional."Special Order No."
    //11.HEI.16  Commnered Astro action due to report is not exist ASTRO Dispatch Sync StP.
    //12 HEI.17  No change.
    //13 HEI.18  Commented Astro wms PO field added in Page witha TAB - AStro WMS
    //14 Moved SRM Tab related fields to Interface app & Pageext 58050.
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Buy-from Vendor Name")
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
        }
        modify("Buy-from")
        {
            CaptionML = ENU = 'Buy-from', FRA = 'Fournisseur';
        }
        modify("Buy-from Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
        }
        modify("Buy-from Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change ImplicitType on ""Buy-from Address 2"(Control 65)". Please convert manually.

        }
        modify("Buy-from Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify("Buy-from City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Buy-from City"(Control 67)". Please convert manually.

        }
        modify("Buy-from Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
        }
        modify("Buy-from Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }

        //Unsupported feature: Change Editable on "Status(Control 101)". Please convert manually.

        modify("Invoice Details")
        {
            CaptionML = ENU = 'Invoice Details', FRA = 'Détails facture';
        }
        modify("Shipping and Payment")
        {
            CaptionML = ENU = 'Shipping and Payment', FRA = 'Expédition et paiement';
        }
        //BC UPGRADE SIVA>> Ship-to field not exist 
        // modify("Ship-to")
        // {
        //     CaptionML = ENU = 'Ship-to', FRA = 'Destinataire';
        // }
        //BC UPGRADE SIVA<< Ship-to field not exist
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Ship-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 34)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 36)". Please convert manually.

        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify("Ship-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 38)". Please convert manually.

        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Pay-to")
        {
            CaptionML = ENU = 'Pay-to', FRA = 'Paiement';
        }
        modify("Pay-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Pay-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address"(Control 24)". Please convert manually.

        }
        modify("Pay-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address 2"(Control 26)". Please convert manually.

        }
        modify("Pay-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify("Pay-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Pay-to City"(Control 28)". Please convert manually.

        }
        modify("Pay-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
        }
        modify("Pay-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }

        //Unsupported feature: CodeModification on ""Buy-from Vendor Name"(Control 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
          if "Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
            SETRANGE("Buy-from Vendor No.");

        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5

        //<< DITW18.00.07 AKH 09/05/2016 DIT-770 #1804
        if "Sundry Vendor" then
          ShowVendorSundryInfo();
        //>> DITW18.00.07 AKH DIT-770 #1804
        */
        //end;


        //Unsupported feature: CodeInsertion on "Status(Control 101)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        StatusOnValidate;
          StatusOnAfterValidate;
        */
        //end;

        // BC UPGRADE SIVA >>  In base layout already filed is existed 

        // addafter("Buy-from City")
        // {
        //     field("Buy-from Country/Region Code";REC."Buy-from Country/Region Code")
        //     {
        //         CaptionML = ENU='Country/Region',
        //                     FRA='Pays/région';
        //         Importance = Additional;
        //     }
        // }
        // BC UPGRADE SIVA <<  In base layout already filed is existed 
        addafter("Document Date")
        {

            field("Purch. Reason Code"; Rec."Purch. Reason Code FND")
            {
                ApplicationArea = all;
                ToolTip = 'Purch. Reason Code';
                Caption = 'Purchase Reason Code';
            }
            // BC UPGRADE SIVA >>Drink IT field
            // field("Tax Date"; Rec."Tax Date")
            // {
            //     ApplicationArea =all;
            //     ToolTip ='Tax Date';
            //     QuickEntry = false;
            // }
            // BC UPGRADE SIVA <<Drink IT field
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;

            }
            // BC UPGRADE SIVA >> Drink IT Code
            // group(Control1100710018)
            // {
            //     field(RouteNew; Rec.Route)
            //     {
            //         QuickEntry = true;
            //         ShowMandatory = RouteAsMandatory;

            //         trigger OnDrillDown();
            //         begin
            //             //FIXME<<DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
            //             DrillDownRouteCombinaison;
            //             // >>DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
            //         end;
            //     }
            //     field(RoutePlanningNew; Rec."Route Planning No.")
            //     {
            //         Editable = false;
            //     }
            // }
            // BC UPGRADE SIVA << Drink IT Code

            //BC UPGRADE SIVA << Drink IT Fields 
            // field("Multiple Order Route"; Rec."Multiple Order Route")
            // {
            //     Editable = false;
            //     Importance = Additional;
            // }
            // field("Vendor Tax Registration No."; REC."Vendor Tax Registration No.")
            // {
            //     Description = 'DITW15.00.00.28,DITW19.00.08 BL#10387';
            //     Editable = EditableVendorTax;
            // }
            // field("Vendor Tax Warehouse Ref."; rec."Vendor Tax Warehouse Ref.")
            // {
            //     Description = 'DITW15.00.00.38 #1217,DITW19.00.08 BL#10387';
            //     Editable = EditableVendorTax;
            // }
            //BC UPGRADE SIVA >> Drink IT Fields

        }
        // BC UPGRADE SIVA >> Drink IT Fields
        // addafter("No. of Archived Versions")
        // {
        //     field("Link Purch. Document Type"; Rec."Link Purch. Document Type")
        //     {
        //         Editable = false;
        //         HideValue = LinkPurchDocumentTypeHideValue;
        //     }
        //     field("Link Purch. Document No."; Rec."Link Purch. Document No.")
        //     {
        //         Editable = false;
        //     }
        // }
        // BC UPGRADE SIVA << Drink IT Fields
        addafter("Vendor Authorization No.")
        {
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
                ToolTip = 'Vendor Shipment No.';
                Description = 'NRQ#16082';
                ShowMandatory = VendorShipmentNoMandatory;
            }
        }

        // BC UPGRADE SIVA >> Drink IT Fields
        addafter("Job Queue Status")
        {
            //     field("Physical Location Group Code"; REC."Physical Location Group Code")
            //     {
            //         Importance = Additional;
            //         QuickEntry = false;

            //         trigger OnValidate();
            //         begin
            //             // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
            //             if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
            //                 CurrPage.UPDATE(true);
            //             // >>DITW18.00.06 DDR DIT-770 #1191
            //         end;
            // field("Vendor DTax Group Code"; "Vendor DTax Group Code")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Vendor DTax Group Code';
            //     QuickEntry = false;
            // }
            //     }

            // BC UPGRADE SIVA >> Drink IT Fields

            field(LocationCode2; Rec."Location Code")
            {
                ApplicationArea = all;
                QuickEntry = false;
            }

        }


        addafter(Status)
        {
            //BC UPGRADE SIVA >> Drink IT fields 
            //     field("Creation Date/Time"; Rec."Creation Date/Time")
            //     {
            //         Description = 'DITW18.00.07 DIT-770 #1282';
            //         Importance = Additional;
            //     }
            //     field("Created By"; Rec."Created By")
            //     {
            //         Description = 'DITW18.00.07 DIT-770 #1282';
            //         Importance = Additional;
            //     }
            //     field("Document Shipping Costs"; REC.HasDocumentShippingCosts)
            //     {
            //         CaptionML = ENU = 'Document Shipping Costs',
            //                     FRA = 'Document Frais livraison';

            //         trigger OnDrillDown();
            //         begin
            //             //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
            //             OpenDocumentShippingCosts;
            //             //>> DITW18.00.07 VSC DIT-770 #1066
            //         end;
            //     }
            //     field("Linked Customer No."; Rec."Linked Customer No.")
            //     {
            //     }
            //BC UPGRADE SIVA  Drink IT fields 
            field("Blanket Order No."; Rec."Blanket Order No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'Blanket Order No.';
            }
            field("BRC Purchase Order"; REC."BRC Purchase Order FND")
            {
                ApplicationArea = all;
                ToolTip = 'BRC Purchase Order';


            }
            field("Fixed Asset Acquisition"; REC."Fixed Asset Acquisition FND")
            {
                ApplicationArea = all;
                ToolTip = 'Fixed Asset Acquisition';
            }
            field("IC Order No."; PurchaseHeaderAdditional."IC Order No.")
            {
                ApplicationArea = all;
                ToolTip = 'IC Order No.';
                Description = 'HEI.10';
                Editable = false;
            }
            field("License Code"; PurchaseHeaderAdditional."License Code")
            {
                ApplicationArea = all;
                ToolTip = 'License Code';
                Editable = LicenseEdit;

                trigger OnDrillDown();
                begin
                    // Hei.08 >>
                    OldDimSetId := 0;
                    NewDImSetId := 0;
                    OldDimSetId := Rec."Dimension Set ID";
                    if LicenseEdit = true then begin
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
                                    //    IF NOT TempDimSetEntry.INSERT THEN
                                    //      TempDimSetEntry.MODIFY;
                                end else begin
                                    if xRec."License Code FND" <> LicenseCode then begin
                                        TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCode);
                                        TempDimSetEntry.MODIFY;
                                    end;
                                end;
                                //<< HEI.14
                                //TempDimSetEntry.INSERT(TRUE);

                                Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

                                Rec.MODIFY();
                                NewDImSetId := Rec."Dimension Set ID";
                                //VALIDATE("License Code", DimValRec.Code);
                                //Updating All Lines
                                PurchLineRec.RESET();
                                PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                                PurchLineRec.SETRANGE("Document No.", Rec."No.");
                                if PurchLineRec.FINDFIRST() then begin
                                    if not GUIALLOWED() then
                                        Rec.SetHideValidationDialog(true);
                                    COMMIT();
                                    UpdateAllLineDimNew(NewDImSetId, OldDimSetId);
                                end;

                            end;
                        end else
                            ERROR(Text003)
                    end else
                        ERROR(Text005, Rec."No.");
                    // Hei.08 <<
                end;

                trigger OnValidate();
                var
                    locTempDimensionSetEntry: Record "Dimension Set Entry" temporary;
                    locPurchaseLine: Record "Purchase Line";
                    locPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
                begin
                    // Hei.13 >>
                    if Rec."License Code FND" = '' then begin
                        GenLedSetRec.RESET;
                        GenLedSetRec.GET;

                        //IF GenLedSetRec."License Dimension Code" = '' THEN BEGIN //HEI.13
                        //>>HEI.13
                        //header
                        locTempDimensionSetEntry.RESET;
                        DimSetEntryRec_2.RESET;
                        DimSetEntryRec_2.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                        if DimSetEntryRec_2.FINDSET then begin
                            repeat
                                locTempDimensionSetEntry.INIT;
                                locTempDimensionSetEntry := DimSetEntryRec_2;
                                locTempDimensionSetEntry.INSERT;
                            until DimSetEntryRec_2.NEXT = 0;
                        end;
                        locTempDimensionSetEntry.RESET;
                        locTempDimensionSetEntry.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                        if locTempDimensionSetEntry.FINDFIRST then
                            locTempDimensionSetEntry.DELETE(true);

                        Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(locTempDimensionSetEntry);
                        Rec.MODIFY;
                        locTempDimensionSetEntry.DELETEALL;

                        //lines
                        locPurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                        locPurchaseLine.SETRANGE("Document No.", Rec."No.");
                        locPurchaseLine.FINDSET;
                        repeat
                            locTempDimensionSetEntry.RESET;
                            DimSetEntryRec_2.RESET;
                            DimSetEntryRec_2.SETRANGE("Dimension Set ID", locPurchaseLine."Dimension Set ID");
                            if DimSetEntryRec_2.FINDSET then begin
                                repeat
                                    locTempDimensionSetEntry.INIT;
                                    locTempDimensionSetEntry := DimSetEntryRec_2;
                                    locTempDimensionSetEntry.INSERT;
                                until DimSetEntryRec_2.NEXT = 0;
                            end;
                            locTempDimensionSetEntry.RESET;
                            locTempDimensionSetEntry.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                            if locTempDimensionSetEntry.FINDFIRST then
                                locTempDimensionSetEntry.DELETE(true);

                            locPurchaseLine."Dimension Set ID" := DimMgt.GetDimensionSetID(locTempDimensionSetEntry);
                            locPurchaseLine.MODIFY;
                            locTempDimensionSetEntry.DELETEALL;
                        until locPurchaseLine.NEXT = 0;


                        //   DimSetEntryRec_2.RESET;
                        //   DimSetEntryRec_2.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
                        //   IF DimSetEntryRec_2.FINDFIRST THEN BEGIN
                        //     DimSetEntryRec_2.DELETE;
                        //     Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryRec_2);
                        //     Rec.MODIFY;
                        //   END;

                        if locPurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then begin
                            locPurchaseHeaderAdditional."License Code" := '';
                            locPurchaseHeaderAdditional.MODIFY;
                        end;
                        //<< HEI.13
                        //END;
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
                    //Hei.13 <<
                end;
            }
            field("PurchaseHeaderAdditional.""Special Order No."""; PurchaseHeaderAdditional."Special Order No.")
            {
                ApplicationArea = all;
                ToolTip = 'Special Return Order No.';
                Caption = 'Special Return Order No.';
                Editable = false;
            }
        }

        //BC UPGRADE SIVA >> Drink IT fields   
        // addafter("Expected Receipt Date")
        // {
        //     field("Fiscal Representative No."; Rec."Fiscal Representative No.")
        //     {
        //     }
        //     field("Tax Office Code"; Rec."Tax Office Code")
        //     {
        //     }
        //     field("Journey Time"; Rec."Journey Time")
        //     {
        //         Description = '<DITW15.00.00.39 #1353>-NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;
        //     }
        //     field("Submission Type"; Rec."Submission Type")
        //     {
        //     }
        // }



        // addafter("VAT Bus. Posting Group")
        // {
        //     field("Sundry Vendor"; Rec."Sundry Vendor")
        //     {
        //     }
        // }

        // addafter("Applies-to ID")
        // {
        //     field("Disable DIT Disc. Prom."; Rec."Disable DIT Disc. Prom.")
        //     {
        //         Importance = Additional;
        //     }
        // }

        //BC UPGRADE SIVA <<  Drink IT fields 

        // BC UPGRADE SIVA >> In base layout already filed is existed 
        // addafter("Ship-to City")
        // {
        //     field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
        //     {
        //         CaptionML = ENU = 'Country/Region',
        //                     FRA = 'Pays/région';
        //         Importance = Additional;
        //     }
        // }
        // addafter("Pay-to City")
        // {
        //     field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
        //     {
        //         CaptionML = ENU = 'Country/Region',
        //                     FRA = 'Pays/région';
        //         Importance = Additional;
        //     }
        // }
        // BC UPGRADE SIVA >> In base layout already filed is existed 


        addafter("Pay-to Contact")
        {
            field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
            {
                ToolTip = 'Vendor Bank Account';
                ApplicationArea = all;
            }
        }
        // BC UPGRADE SIVA >> Drink IT field
        // addafter("Transport Method")
        // {
        //     field("Transport Mode"; REC."Transport Mode")
        //     {
        //         Description = 'DIT715 #187';
        //     }
        // }
        //BC UPGRADE SIVA << Drink IT field


        // addafter("Foreign Trade")
        // {
        // BC UPGRADE SIVA >> Drink IT fields
        // group("Shipping Agent")
        // {
        //     CaptionML = ENU = 'Shipping Agent',
        //                 FRA = 'Transporteur';
        //     field("Shipment Method Code"; Rec."Shipment Method Code")
        //     {
        //         Description = 'NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;
        //     }
        //     field("Shipping Agent Code"; Rec."Shipping Agent Code")
        //     {
        //         Description = '<DITW15.00.00.21 - DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;
        //     }
        //     field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
        //     {
        //         Description = '<DITW15.00.00.21>-NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;
        //     }
        //     field(Distance; REC.Distance)
        //     {
        //         Description = '<DITW15.00.00.24>-NRQ#16082';
        //     }
        //     field("Truck Code"; Rec."Truck Code")
        //     {
        //         Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;
        //     }
        //     field("Trailer Code"; Rec."Trailer Code")
        //     {
        //         Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;
        //     }
        //     field("Driver Code"; Rec."Driver Code")
        //     {
        //         Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;
        //     }
        //     field("Truck Zone"; REC."Truck Zone")
        //     {
        //         Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
        //     }
        //     field("Require 2 Drivers"; REC."Require 2 Drivers")
        //     {
        //         Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
        //     }
        //     field("Driver 2 Code"; Rec."Driver 2 Code")
        //     {
        //         Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;
        //     }
        //     field("Delivery Sequence"; Rec."Delivery Sequence")
        //     {
        //     }
        //     field("Shipping Charge Per"; Rec."Shipping Charge Per")
        //     {
        //         Editable = false;
        //     }
        //     field("Maximum Weight"; REC."Maximum Weight")
        //     {
        //         Editable = false;
        //         Style = Strong;
        //         StyleExpr = "Maximum WeightEmphasize";
        //         Visible = "Maximum WeightVisible";
        //     }
        //     field("Maximum Cubage"; REC."Maximum Cubage")
        //     {
        //         Editable = false;
        //         Style = Strong;
        //         StyleExpr = "Maximum CubageEmphasize";
        //         Visible = "Maximum CubageVisible";
        //     }
        //     field("Total Weight"; REC."Total Weight")
        //     {
        //         Editable = false;
        //     }
        //     field("Total Cubage"; REC."Total Cubage")
        //     {
        //         Editable = false;
        //     }
        // }

        // group("Service/Contract")
        // {
        //     CaptionML = ENU = 'Service/Contract',
        //                 FRA = 'Service/ Contrat';
        //     field("Contract Type"; Rec."Contract Type")
        //     {
        //         Editable = false;
        //     }
        //     field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
        //     {
        //     }
        //     field("Service Contract No."; Rec."Service Contract No.")
        //     {
        //     }
        //     field("Financial Contract No."; Rec."Financial Contract No.")
        //     {
        //     }
        //     field("Contract Group Code"; Rec."Contract Group Code")
        //     {
        //     }
        // }
        // BC UPGRADE SIVA << Drink IT fields
        //BC UPGRADE SIVA >> InterfaceApp 
        // group(SRM)
        // {
        //     Caption = 'SRM';
        //     field("SRM Contract No."; Rec."SRM Contract No.")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'SRM Contract No.';

        //     }
        //     field("SRM Contract Name"; Rec."SRM Contract Name")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'SRM Contract Name';
        //     }
        //     field("SRM Contract Type"; Rec."SRM Contract Type")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'SRM Contract Type';
        //     }
        //     field("Shipment Method Location"; Rec."Shipment Method Location")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Shipment Method Location';
        //     }
        //     field("Valid From"; Rec."Valid From")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Valid From';
        //     }
        //     field("Valid To"; Rec."Valid To")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Valid To';
        //     }
        //     field(Channel; Rec.Channel)
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Channel';
        //     }
        //     field("Target Value Amount"; Rec."Target Value Amount")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Target Value Amount';
        //     }
        //     field(Closed; Rec.Closed)
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Closed';
        //     }
        //     field("SRM Order No."; Rec."SRM Order No.")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'SRM Order No.';
        //     }
        // }
        //BC UPGRADE SIVA <<InterfaceApp

        //BC UPGRADE SIVA >> ASTRO 
        // group("Astro WMS")
        // {
        //     Caption = 'Astro WMS';
        //     field("PurchaseHeaderAdditional.""Astro WMS PO"""; PurchaseHeaderAdditional."Astro WMS PO")
        //     {
        //         ApplicationArea = all;
        //         ToolTip = 'Astro WMS PO';
        //         Caption = 'Astro WMS PO';
        //         Editable = false;
        //     }
        // }
        //BC UPGRADE SIVA << ASTRO
        //  }
        addafter(Control1901138007)
        {

            part(Control1907232107; "Purchase Line FactBox")
            {
                ApplicationArea = all;
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
            }
        }
    }
    actions
    {
        modify("&Return Order")
        {
            CaptionML = ENU = '&Return Order', FRA = '&Retour';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify(Vendor)
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents', FRA = 'Documents';
        }
        modify("Return Shipments")
        {
            CaptionML = ENU = 'Return Shipments', FRA = 'Expéditions retour';
        }
        modify("Cred&it Memos")
        {
            CaptionML = ENU = 'Cred&it Memos', FRA = 'A&voirs';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Warehouse Shipment Lines")
        {
            CaptionML = ENU = 'Whse. Shipment Lines', FRA = 'Lignes expédition entrep.';
        }
        modify("In&vt. Put-away/Pick Lines")
        {
            CaptionML = ENU = 'In&vt. Put-away/Pick Lines', FRA = 'Lignes prélè&v./rangement stock';
        }
        modify(Approval)
        {
            CaptionML = ENU = 'Approval', FRA = 'Approbation';
        }
        modify(Approve)
        {
            CaptionML = ENU = 'Approve', FRA = 'Approuver';
        }
        modify(Reject)
        {
            CaptionML = ENU = 'Reject', FRA = 'Rejeter';
        }
        modify(Delegate)
        {
            CaptionML = ENU = 'Delegate', FRA = 'Déléguer';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comments', FRA = 'Commentaires';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        modify(Release)
        {
            CaptionML = ENU = 'Release', FRA = 'Lancer';



            //Unsupported feature: Change Name on "Release(Action 13)". Please convert manually.

        }
        modify("Re&lease")
        {
            CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
            trigger OnBeforeAction()
            var
            begin
                //HEI.11 >>
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
                    end;
                end;
                //HEI.11 <<
                // <<DITW15.00.00.36 DDR 07/12/2009
                CurrPage.UPDATE(true);
                // >>DITW15.00.00.36 DDR
                // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                //ReleasePurchDoc.PerformManualRelease(Rec);
                // ReleasePurchDoc.DocStatusRelease(xRec, Rec);BC UPGRADE SIVA Drink IT code
                //HEI.04>>
                //CurrPage.UPDATE;
                CurrPage.UPDATE(false);
                //HEI.04<<
                // >>DITW15.00.00.39 DDR #1330 #1407
            end;

            //Unsupported feature: Change Name on ""Re&lease"(Action 112)". Please convert manually.

        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open', FRA = 'R&ouvrir';
            ToolTipML = ENU = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed', FRA = 'Rouvrez le document pour le modifier après son approbation. Les documents approuvés ont le statut Lancé et doivent être ouverts pour pouvoir être modifiés.';
            //ShortCutKey = Ctrl+F10;
            trigger OnBeforeAction()
            var
                ArchiveManagement: Codeunit ArchiveManagement;
            begin
                //HEI.03>>
                if Rec."SRM Order No. FND" = '' then begin
                    ArchiveManagement.ArchivePurchDocument(Rec);
                    CurrPage.UPDATE(false);
                end;
                //HEI.03<<
                // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                //ReleasePurchDoc.PerformManualReopen(Rec);
                //ReleasePurchDoc.DocStatusOpen(xRec, Rec);//BC UPGRADE SIVA DRINK IT CODE
                // CurrPage.UPDATE(); //BC UPGRADE SIVA
                // >>DITW15.00.00.39 DDR #1330 #1407

            end;
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(GetPostedDocumentLinesToReverse)
        {
            CaptionML = ENU = 'Get Posted Doc&ument Lines to Reverse', FRA = 'Extraire lignes doc&ument enreg. à contrepasser';
        }
        modify("Apply Entries")
        {
            CaptionML = ENU = 'Apply Entries', FRA = 'Lettrer écritures';
        }
        modify(CalculateInvoiceDiscount)
        {
            CaptionML = ENU = 'Calculate &Invoice Discount', FRA = 'C&alculer remise facture';
        }
        modify(CopyDocument)
        {
            CaptionML = ENU = 'Copy Document', FRA = 'Copier document';
        }
        modify("Move Negative Lines")
        {
            CaptionML = ENU = 'Move Negative Lines', FRA = 'Déplacer lignes négatives';
        }
        modify("Archive Document")
        {
            CaptionML = ENU = 'Archive Document', FRA = 'Archiver document';
        }
        modify("Send IC Return Order")
        {
            CaptionML = ENU = 'Send IC Return Order', FRA = 'Envoyer retour IC';

            //Unsupported feature: Change Description on ""Send IC Return Order"(Action 138)". Please convert manually.


            //Unsupported feature: Change Visible on ""Send IC Return Order"(Action 138)". Please convert manually.

        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';
        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest', FRA = 'Annuler demande d''appro&bation';
        }
        modify(Action19)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Create &Warehouse Shipment")
        {
            CaptionML = ENU = 'Create &Warehouse Shipment', FRA = 'Créer e&xpédition entrepôt';
            trigger OnBeforeAction()
            begin
                //BC UPGRADE SIVA<< Drink IT code
                // PurchSetup.GET();
                // if PurchSetup."Auto.Release Document on Whse." then begin
                //     // <<DITW15.00.00.39 DDR 27/07/2011 #1407
                //     ReleasePurchDoc.DocStatusRelease(xRec, Rec);
                //     // >>DITW15.00.00.39 DDR #1407
                //     if (xRec.Status <> Status) and (Status = Status::Released) then
                //         MESSAGE(Text2014410, "Document Type", "No.");
                //BC UPGRADE SIVA>>Drink IT code
            end;

        }
        modify("Create Inventor&y Put-away/Pick")
        {
            CaptionML = ENU = 'Create Inventor&y Put-away/Pick', FRA = 'Créer prélèv./rangement stoc&k';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
        }
        modify(Preview)
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
        }
        modify(TestReport)
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify(PostAndPrint)
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
        }
        modify(PostBatch)
        {
            CaptionML = ENU = 'Post &Batch', FRA = 'Valider par l&ot';
        }
        modify(RemoveFromJobQueue)
        {
            CaptionML = ENU = 'Remove From Job Queue', FRA = 'Supprimer de la file d''attente des travaux';
        }


        //Unsupported feature: CodeModification on ""Re&lease"(Action 112).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleasePurchDoc.PerformManualRelease(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.11 >>
        GenLedSetRec.RESET;
        GenLedSetRec.GET;
        if GenLedSetRec."License Dimension Code" <> '' then begin
          CLEAR(LicenseCodeValue);
          PurchRec.RESET;
          PurchRec.SETRANGE("Document Type",Rec."Document Type");
          PurchRec.SETRANGE("No.",Rec."No.");
          if PurchRec.FINDFIRST then begin
              DimSetEntryRec.RESET;
              DimSetEntryRec.SETRANGE("Dimension Set ID",PurchRec."Dimension Set ID");
              DimSetEntryRec.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
              if DimSetEntryRec.FINDFIRST then
                LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
          end;
          CLEAR(LicenseCodeValue_1);
          PurchLineRec.RESET;
          PurchLineRec.SETRANGE("Document Type",Rec."Document Type");
          PurchLineRec.SETRANGE("Document No.",Rec."No.");
          if PurchLineRec.FINDFIRST then begin
            repeat
              DimSetEntryRec_1.RESET;
              DimSetEntryRec_1.SETRANGE("Dimension Set ID",PurchLineRec."Dimension Set ID");
              DimSetEntryRec_1.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
              if DimSetEntryRec_1.FINDFIRST then
                LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

              if LicenseCodeValue_1 <>'' then begin
                if LicenseCodeValue <> LicenseCodeValue_1 then
                  ERROR(Text004);
              end;
            until PurchLineRec.NEXT = 0;
          end;
        end;
        //HEI.11 <<
        // <<DITW15.00.00.36 DDR 07/12/2009
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.36 DDR
        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        //ReleasePurchDoc.PerformManualRelease(Rec);
        ReleasePurchDoc.DocStatusRelease(xRec,Rec);
        //HEI.04>>
        //CurrPage.UPDATE;
        CurrPage.UPDATE(false);
        //HEI.04<<
        // >>DITW15.00.00.39 DDR #1330 #1407
        */
        //end;


        //Unsupported feature: CodeModification on "Reopen(Action 113).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleasePurchDoc.PerformManualReopen(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.03>>
        if "SRM Order No." = '' then begin
          ArchiveManagement.ArchivePurchDocumentOnReopen(Rec);
          CurrPage.UPDATE(false);
        end;
        //HEI.03<<
        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        //ReleasePurchDoc.PerformManualReopen(Rec);
        ReleasePurchDoc.DocStatusOpen(xRec,Rec);
        CurrPage.UPDATE;
        // >>DITW15.00.00.39 DDR #1330 #1407
        */
        //end;


        //Unsupported feature: CodeModification on ""Create &Whse. Shipment"(Action 93).OnAction". Please convert manually.

        //trigger  Shipment"(Action 93)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSourceDocOutbound.CreateFromPurchaseReturnOrder(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.34 DDR 16/06/2009
        PurchSetup.GET();
        if PurchSetup."Auto.Release Document on Whse."then begin
          // <<DITW15.00.00.39 DDR 27/07/2011 #1407
          ReleasePurchDoc.DocStatusRelease(xRec,Rec);
          // >>DITW15.00.00.39 DDR #1407
          if (xRec.Status <> Status) and (Status = Status::Released) then
            MESSAGE(Text2014410,"Document Type","No.");
        end;
        // >>DITW15.00.00.34 DDR

        GetSourceDocOutbound.CreateFromPurchaseReturnOrder(Rec);
        */
        //end;
        addafter("Co&mments")
        {
            //BC UPGRADE SIVA >>  Drink IT Page 
            // action("Shipping Costs")
            // {
            //     CaptionML = ENU = 'Shipping Costs',
            //                 FRA = 'Coûts transport';
            //     Image = Costs;
            //     RunObject = Page "Document Shipping Cost";
            //     RunPageLink = "Source Type" = CONST(38),
            //                   "Source No." = FIELD("No."),
            //                   "Sub Type" = FIELD("Document Type");
            // }
            //BC UPGRADE SIVA << Drink IT Page
            action("Purchase Additional")
            {
                ApplicationArea = all;
                ToolTip = 'Purchase Additional';
                Caption = 'Purchase Additional';
                Image = Purchase;
                RunObject = Page "Purchase Additional";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No.");
            }
        }
        addfirst(Documents)
        {
            //BC UPGRADE SIVA >> Drink IT code
            // action("Comments - Transport Mode")
            // {
            //     ApplicationArea =all;
            //     CaptionML = ENU = 'Comments - Transport Mode',
            //                 FRA = 'Commantaires - Mode de transport';
            //     Description = 'DIT715 #187';
            //     Image = ViewComments;
            //     RunObject = Page "EMCS Comment Sheet";
            //     RunPageLink = "Table ID" = CONST(38),
            //                   "Document Type" = CONST(1),
            //                   "Document No." = FIELD("No."),
            //                   "Document Line No." = CONST(0),
            //                   "Field ID" = CONST(2014277);
            // }
            //BC UPGRADE SIVA <<
        }
        addafter("Cred&it Memos")
        {
            // action("&Orders")
            // {
            //     ApplicationArea =all;
            //     CaptionML = ENU = '&Orders',
            //                 FRA = '&Commandes';
            //     Image = Document;
            //     RunObject = Page "Purchase Order List";
            //     RunPageLink = "Document Type" = FIELD("Link Purch. Document Type"),
            //                   "No." = FIELD("Link Purch. Document No.");
            // }
        }
        addafter(GetPostedDocumentLinesToReverse)
        {
            //BC UPGRADE SIVA>> ASTRODispatc
            // action("Process PO for Astro WMS")
            // {
            //     ApplicationArea =all;
            //     ToolTip ='Process PO for Astro WMS';
            //     Image = Process;
            //     Visible = false;

            //     trigger OnAction();
            //     begin
            //         //HEI.16>>
            //         if CONFIRM(STRSUBSTNO(Text50000, Rec."No."), true) then begin
            //             ASTRODispatchSyncStP.SetPONumber(REC."No.");
            //             ASTRODispatchSyncStP.RUN;
            //         end;
            //         //HEI.16<<
            //     end;
            // }
            //BC UPGRADE SIVA<< ASTRODispatc
        }
        addafter(CalculateInvoiceDiscount)
        {
            //BC UPGRADE SIVA << Drink IT code
            // action("Change Sundry vendor fields")
            // {
            //     CaptionML = ENU = 'Change Sundry vendor fields',
            //                 FRA = 'Modifier champs fournisseurs divers';
            //     Image = ChangeCustomer;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     Visible = "Sundry Vendor";

            //     trigger OnAction();
            //     begin
            //         //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
            //         ShowVendorSundryInfo();
            //         //>> DITW18.00.07 DIT-770 #1804
            //     end;
            // }
            //BC UPGRADE SIVA >> Drink IT code
        }
        // BC UPGRADE SIVA >>Drink IT code
        // addafter("Send IC Return Order")
        // {
        //     action(AutoSendICReturnOrder)
        //     {
        //         Caption = 'Auto. Send IC Return Order';
        //         Description = 'NRQ69018-FINXL14.00.15 MSF 13/05/2020 NRQ#117628';
        //         Enabled = NOT VisibleSendIC;
        //         Image = Intercompany;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;

        //         trigger OnAction();
        //         begin
        //             //<<FINXL11.00 HBA 03/05/2018 NRQ#69018
        //             cduICWebservice.fctCopyICDocument("Document Type", "No.", 'PURCHASE');
        //             //>>FINXL11.00 HBA 03/05/2018 NRQ#69018
        //         end;
        //     }
        // }

        // addafter("P&osting")
        // {
        //     group(ActionGroup1100083119)
        //     {
        //         CaptionML = ENU = '&Print',
        //                     FRA = '&Imprimer';
        //         Image = Print;
        //         action("Order Confirmation")
        //         {
        //             CaptionML = ENU = 'Order Confirmation',
        //                         FRA = 'Confirmation de commande';
        //             Ellipsis = true;
        //             Image = Print;

        //             trigger OnAction();
        //             begin
        //                 // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //                 CurrPage.PurchLines.PAGE.SetDisableRefreshLines(true);
        //                 // >>DITW16.00.00.40 DDR DIT-715 #197
        //                 DocPrint.PrintPurchHeader(Rec);
        //                 // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //                 CurrPage.PurchLines.PAGE.SetDisableRefreshLines(false);
        //                 // >>DITW16.00.00.40 DDR DIT-715 #197
        //             end;
        //         }
        //         action("Test AAD Document")
        //         {
        //             CaptionML = ENU = 'Test AAD Document',
        //                         FRA = 'Tester document AAD';
        //             Ellipsis = true;
        //             Image = Print;

        //             trigger OnAction();
        //             begin
        //                 // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //                 CurrPage.PurchLines.PAGE.SetDisableRefreshLines(true);
        //                 // >>DITW16.00.00.40 DDR DIT-715 #197
        //                 // <<DITW15.00.00.28 DDR 26/11/2008
        //                 DocPrint.PrintPurchHeaderAAD(Rec);
        //                 // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //                 CurrPage.PurchLines.PAGE.SetDisableRefreshLines(false);
        //                 // >>DITW16.00.00.40 DDR DIT-715 #197
        //             end;
        //         }
        //     }
        // }
        // BC UPGRADE SIVA << Drink IT code
    }
    trigger OnOpenPage()
    begin
        LicenseEdit := true; //HEI.13
    end;

    trigger OnAfterGetRecord()
    begin
        IF PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") THEN; //HEI.10

        //HEI.11 >>
        //  ReturnShpHHdrRec.RESET;
        //  ReturnShpHHdrRec.SETRANGE("Return Order No.",Rec."No.");
        //  IF ReturnShpHHdrRec.FINDFIRST THEN
        //>> HEI.13
        PurchLine.SETRANGE("Document No.", Rec."No.");
        PurchLine.SETFILTER("Return Qty. Shipped", '>%1', 0);
        IF PurchLine.FINDFIRST() THEN
            LicenseEdit := FALSE;
        //<< HEI.13
        //HEI.11 <<

    end;

    var
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        PurchLine: Record "Purchase Line";


        //Unsupported feature: PropertyModification on "OpenPostedPurchaseReturnOrderQst(Variable 1015)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //OpenPostedPurchaseReturnOrderQst : ENU=The return order has been posted and moved to the Posted Purchase Credit Memos window.\\Do you want to open the posted credit memo?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //OpenPostedPurchaseReturnOrderQst : ENU=The return order has been posted and moved to the Posted Purchase Credit Memos window.\\Do you want to open the posted credit memo?;FRA=Le retour vente a été enregistré et déplacé dans la fenêtre Avoirs achat enregistrés.\\Voulez-vous ouvrir l'avoir enregistré ?;
        //Variable type has not been exported.


        //cduICWebservice: Codeunit "IC Web Service";//BC UPGRDE SIVA
        Text2014410: TextConst ENU = '%1 %2 has been automatically released.', FRA = 'Le/la %1 %2 a été automatiquement lancé(e).';
        Text2014411: TextConst ENU = 'Do you want to cancel the approval request for %1 %2?', FRA = 'Souhaitez vous annuler la demande d''approbation du/de la %1 %2?';
        Text2014412: TextConst ENU = 'Do you want to send the approval request for %1 %2?', FRA = 'Souhaitez vous envoyer la demande d''approbation du/de la %1 %2?';
        // ReleasePurchDoc: Codeunit "Release Purchase Document";

        LinkPurchDocumentTypeHideValue: Boolean;

        "Maximum CubageVisible": Boolean;

        "Maximum WeightVisible": Boolean;

        "Maximum WeightEmphasize": Boolean;

        "Maximum CubageEmphasize": Boolean;
        PurchSetup: Record "Purchases & Payables Setup";
        VendorShipmentNoMandatory: Boolean;
        RouteAsMandatory: Boolean;
        EditableVendorTax: Boolean;
        EditableMultipleRouteOrder: Boolean;
        PurchHdrArch: Record "Purchase Header Archive";
        ReasonCodeErr: Label 'You must fill in the Reason Code';
        HeinekenGlobal: Codeunit "Heineken Global";
        //ICWebService: Codeunit "IC Web Service";//BC UPGRDE SIVA
        VisibleSendIC: Boolean;
        Text000: Label 'Please select the dimension for License Dimension in General Ledger Setup.';
        LicenseCode: Code[20];
        DimValRec: Record "Dimension Value";
        GenLedSetRec: Record "General Ledger Setup";
        DimValue: Code[10];
        DimValPage: Page "Dimension Values";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        DimMgt: Codeunit DimensionManagement;
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        NewDImSetId: Integer;
        OldDimSetId: Integer;
        HideValidationDialog: Boolean;
        PurchRec: Record "Purchase Header";
        PurchLineRec: Record "Purchase Line";
        // PurchLine: Record "Purchase Line";
        LicenseCodeValue: Code[20];
        DimSetEntryRec: Record "Dimension Set Entry";
        LicenseCodeValue_1: Code[20];
        DimSetEntryRec_1: Record "Dimension Set Entry";
        Text001: Label 'The seleced value cannot be found in the dimension value table.';
        Text002: Label 'License code cannot be  changed when status is %1';
        Text051: TextConst ENU = 'You may have changed a dimension.\\Do you want to update the lines?', FRA = 'Vous avez probablement modifié un axe analytique.\\Souhaitez-vous mettre à jour les lignes ?';
        Text003: Label 'You cannot edit the License code when the PO when status is released.';
        Text004: Label 'License Dimension Value should be same for both header and line.';
        LicenseEdit: Boolean;
        DimSetEntryRec_2: Record "Dimension Set Entry";
        Text005: Label 'You cannot change the license code as shipments for %1 are already done.';
        // ASTRODispatchSyncStP: Report "ASTRO Dispatch Sync StP";//BC UPGARDE SIVA Astro object 
        Text50000: Label 'Do you want to create the outbound entries for this Return Order %1 for Astro WMS Interface?';


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);

    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
    SETFILTER("Resp. Center Table Filter",
      UserMgt.GetRespCenterFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserMgt.GetRespPhysLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserMgt.GetRespLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1191
    // <<DITW15.00.00.39 DDR 27/07/2011 #1407
    CALCFIELDS("Disc.Promo. Order Calculated");
    // >>DITW15.00.00.34 DDR
    //<< DITW18.00.07 VSC 26/05/2016 DIT-770 #1984
    /// DITW110.00.08 DDR 02/01/2017 NRQ#0
    RouteAsMandatory := PurchSetup."Route Mandatory";
    //>> DITW18.00.07 VSC 26/05/2016 DIT-770 #1984
    //<<DITW19.00.08 MSF 09/09/2016 BL#10387
    EditableVendorTax := not ReturnShipmentExist  ;
    //>>DITW19.00.08 MSF 09/09/2016 BL#10387
    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
     if not "Multiple Order Route" then
      EditableMultipleRouteOrder := true
    else
      EditableMultipleRouteOrder := false;
    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger (Variable: PurchLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetControlAppearance;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetControlAppearance;
    // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    LinkPurchDocumentTypeHideValue := false;
    LinkPurchDocumentTypeOnFormat;
    MaximumCubageOnFormat;
    MaximumWeightOnFormat;
    // >>DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
    SetExtDocNoMandatoryCondition();
    //>> DITW18.00.07 AKH DIT-770 #1409

    //<<FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    VisibleSendIC := not IsAutoSendDocEnabled ;
    //>>FINXL14.00.15 MSF 13/05/2020 NRQ#117628

    if PurchaseHeaderAdditional.GET("Document Type","No.") then; //HEI.10

    //HEI.11 >>
    //  ReturnShpHHdrRec.RESET;
    //  ReturnShpHHdrRec.SETRANGE("Return Order No.",Rec."No.");
    //  IF ReturnShpHHdrRec.FINDFIRST THEN
    //>> HEI.13
    PurchLine.SETRANGE("Document No.",Rec."No.");
    PurchLine.SETFILTER("Return Qty. Shipped",'>%1',0);
    if PurchLine.FINDFIRST then
       LicenseEdit := false;
    //<< HEI.13
    //HEI.11 <<
    */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    JobQueueUsed := PurchasesPayablesSetup.JobQueueActive;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.25 DDR 09/10/2008
    "Maximum WeightVisible" := true;
    "Maximum CubageVisible" := true;
    // >>DITW15.00.00.25 DDR 09/10/2008
    //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
    SetExtDocNoMandatoryCondition();
    //>> DITW18.00.07 AKH DIT-770 #1409
    //<<DITW19.00.08 MSF 09/09/2016 BL#10387
    EditableVendorTax := true;
    //>>DITW19.00.08 MSF 09/09/2016 BL#10387
    JobQueueUsed := PurchasesPayablesSetup.JobQueueActive;
    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
      EditableMultipleRouteOrder := true;
    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082

    //<<FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    VisibleSendIC := true;
    //>>FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if UserMgt.GetPurchasesFilter <> '' then begin
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
      FILTERGROUP(0);
    end;

    SetDocNoVisible;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1191
    //IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
    if UserMgt.GetPurchasesTextFilter <> '' then begin
      FILTERGROUP(2);
      //SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
      SETRANGE("Responsibility Center",UserMgt.GetPurchasesTextFilter);
      FILTERGROUP(0);
    end;
    // >>DITW18.00.06 DDR DIT-770 #1191

    SetDocNoVisible;
    //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
    SetExtDocNoMandatoryCondition();
    //>> DITW18.00.07 AKH DIT-770 #1409
    //<< DITW18.00.07 VSC 26/05/2016 DIT-770 #1984 - DITW110.00.08 DDR 02/01/2017 NRQ#0
    PurchSetup.GET;
    //>> DITW18.00.07 VSC 26/05/2016 DIT-770 #1984 - DITW110.00.08 DDR 02/01/2017 NRQ#0

    LicenseEdit := true; //HEI.13
    */
    //end;


    //BC UPGRADE SIVA >> Drink IT Code
    // procedure FormatMaximumControls(pFieldNo: Integer; pMaxValue: Decimal; pTotalValue: Decimal);
    // var
    //     lblnBold: Boolean;
    //     lcolor: Integer;
    // begin
    //     // <<DIT15.00.00.21 DDR 19/06/2008 - DITW15.00.00.28 DDR 02/12/2008
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

    // local procedure StatusOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.34 DDR 17/06/2009
    //     CurrPage.UPDATE(false);
    // end;

    // local procedure StatusOnValidate();
    // begin
    //     // <<DITW15.00.00.34 DDR 17/06/2009
    //     if xRec.Status = Status then
    //         exit;

    //     // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
    //     if (xRec.Status = Status::Open) or (Status = Status::Released) then
    //         ReleasePurchDoc.DocStatusRelease(xRec, Rec)
    //     else begin
    //         if Status = Status::Open then
    //             ReleasePurchDoc.DocStatusOpen(xRec, Rec)
    //         else
    //             // >>DITW15.00.00.39 DDR #1330 #1407
    //             TESTFIELD(Status, xRec.Status);
    //     end;
    // end;

    // local procedure LinkPurchDocumentTypeOnFormat();
    // begin
    //     // <<DITW15.00.00.01 DDR 11/03/2008
    //     if "Link Purch. Document No." = '' then
    //         LinkPurchDocumentTypeHideValue := true;
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure MaximumCubageOnFormat();
    // begin
    //     REC.CALCFIELDS(REC."Total Cubage");
    //     FormatMaximumControls(FIELDNO("Maximum Cubage"), "Maximum Cubage", "Total Cubage");
    // end;

    // local procedure MaximumWeightOnFormat();
    // begin
    //     CALCFIELDS("Total Weight");
    //     FormatMaximumControls(FIELDNO("Maximum Weight"), "Maximum Weight", "Total Weight");
    // end;

    // local procedure SetExtDocNoMandatoryCondition();
    // var
    //     PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    // begin
    //     //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
    //     PurchasesPayablesSetup.GET;
    //     VendorShipmentNoMandatory := PurchasesPayablesSetup."Vendor Shipment No. Mandatory";
    // end;
    //BC UPGRADE SIVA >> Drink IT Code
    local procedure UpdateAllLineDimNew(NewParentDimSetID: Integer; OldParentDimSetID: Integer);
    var
        NewDimSetID: Integer;
        ReceivedShippedItemLineDimChangeConfirmed: Boolean;
        PurchLine: Record "Purchase Line";
    begin
        // Update all lines with changed dimensions.
        //HEI.08>>
        if NewParentDimSetID = OldParentDimSetID then
            exit;

        //HEI.02>>
        if not HideValidationDialog then
            //HEI.02<<
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
        //HEI.08 <<
    end;

    // procedure SetHideValidationDialog(NewHideValidationDialog: Boolean);
    // begin
    //     HideValidationDialog := NewHideValidationDialog;//HEI.08
    // end;

    local procedure VerifyReceivedShippedItemLineDimChange(var ReceivedShippedItemLineDimChangeConfirmed: Boolean);
    begin
        //HEI,08 >>
        if PurchLine.IsReceivedShippedItemDimChanged() then
            if not ReceivedShippedItemLineDimChangeConfirmed then
                ReceivedShippedItemLineDimChangeConfirmed := PurchLine.ConfirmReceivedShippedItemDimChange();
        //HEI.08 <<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

