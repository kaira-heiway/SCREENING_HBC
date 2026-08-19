pageextension 58051 PurchaseReturnOrderIntExt extends "Purchase Return Order"
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
    //***********************************//
    //BC UPGRADE SIVA 21/01/2026
    //1.HEI.02  For SRM integration added to SRM tab.
    layout
    {

        addafter("Foreign Trade")
        {
            group(SRM)
            {
                Caption = 'SRM';
                field("SRM Contract No."; Rec."SRM Contract No. FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'SRM Contract No.';

                }
                field("SRM Contract Name"; Rec."SRM Contract Name FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'SRM Contract Name';
                }
                field("SRM Contract Type"; Rec."SRM Contract Type FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'SRM Contract Type';
                }
                field("Shipment Method Location"; Rec."Shipment Method Location FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Shipment Method Location';
                }
                field("Valid From"; Rec."Valid From FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Valid From';
                }
                field("Valid To"; Rec."Valid To FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Valid To';
                }
                field(Channel; Rec."Channel FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Channel';
                }
                field("Target Value Amount"; Rec."Target Value Amount FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Target Value Amount';
                }
                field(Closed; Rec."Closed FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Closed';
                }
                field("SRM Order No."; Rec."SRM Order No. FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'SRM Order No.';
                }
            }

        }


    }

}