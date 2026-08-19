namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Sales.Document;
using System.Security.User;

pageextension 58053 SalesRetOrderInterfaceExt extends "Sales Return Order"
{
    // version NAVW110.0.00.16585,DITW110.00.11,HEI.18
    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    //   DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                  New calling functions to insert (item) charges
    //   DITW15.00.00.01 DDR 21/01/2008 Remove unused textconst
    //   DITW15.00.00.01 DDR 27/02/2008 Drink-it Return Deposit functionnalities
    //                                  Added menu "&Orders" into "Ret.Order" button
    //                                  Added field "Link Sales Document Type","Link Sales Document No." into general tab
    //   DITW15.00.00.01 DDR 11/03/2008 Hide "Link Sales Document Type" when no link document
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    //   DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code","Driver Code" into "Shipping" tab
    //                       21/10/2008 Deleted field2013722 Duty Tax Type
    //                                  Added fields "Customer DTax Group Code" into Invoicing tab
    //   DITW15.00.00.28 DDR 24/11/2008 Added "Fiscal Representative No." into Shipping tab
    //                       02/12/2008 Added "Shipping Agent" tab + fields
    //                                  Added function FormatMaximumControls()
    //                       19/12/2008 Added field "Ship-to Code" into Shipping tab
    //   DITW15.00.00.33 DDR 07/05/2009 Move field "Customer DTax Group Code" into 'General' tab
    //   DITW15.00.00.34 DDR 16/06/2009 Added auto-release document into menu 'Create Whse. shipment'
    //                       17/06/2009 Added shortcut key CTRL+F10 to switch status 'open' the current document
    //                                  Changed Editable "Status" field
    //                                  Added functions DocStatusRelease(),DocStatusOpen(),
    //   DITW15.00.00.36 DDR 07/12/2009 issue 981 Bugfix Save/Refresh before release function
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   CEL 13/08/2010           Modification RTC buttons
    //   DITW15.00.00.38 DDR 30/09/2010 issue 1217 Added 'Get EMCS ARC No. to Apply' menu into 'Functions' menu
    //                   DDR 19/11/2010 issue 1139 SSCC Functionnalities
    //                                    Added menu 'SSCC Tracking Lines' in 'Line' buttton
    //                   DDR 27/01/2011 issue 1217 (DIT711 137) Added fields "Tax Office Code" into 'Shipping' tab
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
    //   DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                    call function SetDisableRefreshLines() before each report
    //                                                    (don't use the <RunObject> property)
    //   DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added 'Service/Contract' tab
    //                                               Added fields into 'Service/Contract' tab
    //                                                 "DIT Sub-Contract Type","Contract Group Code","Service Contract No."
    //                                               Moved "Building No." into 'Service/Contract' tab

    //   FINXL7.00.001 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)
    //   DITW17.00.02 AT  12/09/2013 DIT-770 #154
    //                               Repositioned Shipment Method before Shipping Agent
    //                               Added fields
    //                               2014094 Sell-to Invoice Method
    //                               2014095 Sell-to Invoice Period
    //                               2014096 Picking Type
    //   DITW17.00.02 SR 10/16/2013 DIT-770 #155 : New Action "Change Shipping status" Added
    //                                           : Change the Editable Propert False in "Shipment status" field.
    //                                           : New Action "Register Shipment Entries" Added
    //   DITW17.00.02 SR 10/25/2013 DIT-770 #159 : New Field Added in General Tab
    //   DITW17.00.02 AT  14/11/2013 DIT-770 #154
    //                               Added fields
    //                               2014110 Delivery Time 1 From
    //                               2014111 Delivery Time 1 To
    //                               2014112 Delivery Time 2 From
    //                               2014113 Delivery Time 2 To
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added fields "Physical Location Group Code"
    //   DITW18.00.06 DDR 25/02/2015 DIT-770 #1190 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.05 DDR 07/10/2014 DIT-770 #935 Editable "Building No."
    //   DITW17.10.04 AKH 24/11/2014 DIT-770 #1001 Added Action "Print and Mail"
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added field "Trailer Code"
    //   DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214 Added Drill Down to field route
    //   DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214 Filter on "Resp. Center Table Filter 2"
    //   DITW18.00.06 MSF 09/07/2015 DIT-770 1421 Make Field Status Not editable in page 43 , 44 and 6630 like Std
    //   DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                             Rename Field Service contract Type => Contract Type
    //   DITW19.00.07 MVN 25/01/2016 DIT-770 #1740: DISABLED Approval
    //   DITW18.00.07 AKH 11/02/2016 DIT-770 #1804 Sundry Customer
    //   DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    //   DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add HasDocumentShippingCosts to General TAB
    //   DITW18.00.07 WSA 23/03/2016 DIT-770 #1723 Added Field Invoice List Customer No.
    //   DITW18.00.07 AKH 28/03/2016 DIT-770 #1409 Added "ShowMandatory" property for "External Document No." field
    //   DITW18.00.07 AKH 30/03/2016 DIT-770 #1409 Adjustment
    //   DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    //   DITW18.00.07 AKH 09/05/2016 DIT-770 #1804 Adjustment
    //   DITW18.00.07 AKH 13/05/2016 DIT-770 #1409 Restored standard code for check on "External Document No."
    //   DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    //   DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   DITW110.00.09 DDR 20/04/2017 NRQ#13107 Add all country code fields
    //   DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    //   DITW110.00.10 MSF 07/07/2017 NRQ#16224 Return Registration part 3
    //                                Added Action Returned Items
    //                                             Suggest Return Item
    //   DITW110.00.10 MSF 14/07/2017 NRQ#16224 Added fields : Several Adjustment
    //   DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added fields  Multiple Route Order
    //                                Editable Field IF not Multiple Route ORder
    //   DITW110.00.11 MSF 30/11/2017 NRQ#16082 Remove Condition EditableMultipleRouteOrder  on SOme fields
    //   HEI.01 FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>
    //     # Code added on OnOpenPage, OnNewRecord, OnInsertRecord
    //   HEI.02 FDD-AL-GAPLOG05 IBM NASTAA02 29.09.2017 # Unloading Note template for Algeria
    //     # New Action Button created to print the Unloading Note
    //   HEI.03 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //     # Code added on Post Action
    //   HEI.04 FDD-KDD0TC005 IBM NASTAA02 09.11.2017 # RPM Billing and Reporting
    //     # New page action created to run the report RPM Balance Accounting
    //   HEI.06 INC2109750 IBM NASTAA02 16.04.2019 # Promotion Group Dimensions
    //     # New function created "UpdateFreeReasonCodeDimensions" to update the Free Reason Code Dimension for Group Promotions
    //   DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
    //                                 Added Field "Disable DIT Disc. Prom."
    //   HEI.07 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    //   HEI.08 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //     # New Field added: "Suppress POS Interface"
    //     # Code added to enable editing of Field "Supress POS Interface"
    //   HEI.10 FDD-HT88 IBM BULIMC01 26/11/2019
    //       #changes for action "Customer Differences (RPM)" : moved to Actions tab - Functions, visibility property changed to YES
    //   DITW111.00.13A DDR 01/07/2019 NRQ#103938 Added visibility for Action Send Approval
    //   FINXL11.00 HBA 03/05/2018 NRQ#69018 : Added Action "Auto. Send IC Return Order"
    //   HEI.11 CHG2046145 IBM.COSTES02 20.02.2020 # Sales Order Status Addition
    //     # Mew field added : 50051 - "Approval Status"
    //   HEI.12 CHG2053242 HB1215 IBM GAVANM01 31.03.2020 Sales Order fixes
    //     # the field Shipment Date appears twice. Remove it from Shipping and Billing tab
    //   FINXL14.00.15 MSF 13/05/2020 NRQ#117628 Enable /Disable AutoSend To IC
    //   HEI.13 CHG2065153 IBM KUMARN15 23.06.2020
    //     # Added field "Source System Identifier"
    //   HEI.14 CHG2062340 HB1378 IBM GAVANM01 29.07.2020 #Retrofitting the Brewco Æ Sellco
    //     # for the action "Auto Send IC Return Order": delete Visible property, add Enabled property
    //   HEI.15 CHG2073467 HB1369 IBM GAVANM01 17.08.2020  Enhancements to the Intercompany automation functionality
    //     # new field added: IC Order No.
    //     # hide action "Send IC Return Order Cnfmn."
    //     # Properties changed for action Auto. Send IC Return Order: Promoted=yes, PromotedCategory=Process, PromotedIsBig=yes
    //   HEI.16 CHG2073468 HB1369 IBM GAVANM01 04.01.2021 Enhancements to Intercompany Part 3
    //     # New field added, Special Order
    //   HEI.17 FDD-HB899 - CHG2093015 IBM NASTAA02  19.01.2021 # LSR - Sales And Payments
    //     # Code added on "Create &Whse. Receipt" Action
    //   HEI.18 CHG2165967 DEBUSD01 26.10.2022 HL block tax and VAT modification in sales order
    //     # change editable field "Customer DTax Group Code", "VAT Bus. Posting Group"
    //*******************************************//
    //BC UPGRADE SIVA 22/01/2026
    // SUMMARY OF CHANGES:
    // 1.HEI.07  added "Load No." & "Sequence No."
    // 2.HEI.08  POS Interface
    //     # New Field added: "Suppress POS Interface"
    //     # Code added to enable editing of Field "Supress POS Interface"


    layout
    {
        addafter(Status)
        {
            field("Load No."; Rec."Load No. FND")
            {
                Visible = true;
                ApplicationArea = All;
                ToolTip = 'Load No.';
            }
            field("Sequence No."; Rec."Sequence No. FND")
            {
                Visible = true;
                ApplicationArea = All;
                ToolTip = 'Sequence No.';
            }
            field("Suppress POS Interface"; Rec."Suppress POS Interface FND")
            {
                Editable = SuppressPOSInterfaceEditable;
                ApplicationArea = All;
                ToolTip = 'Suppress POS Interface';
            }

        }
    }

    trigger OnAfterGetRecord();
    var
    begin
        //HEI.17>>
        UserSetup2.GET(USERID);
        SuppressPOSInterfaceEditable := UserSetup2."Allow Change Inter Flag FND";
        //HEI.17<<


    end;


    var
        SuppressPOSInterfaceEditable: Boolean;
        UserSetup2: Record "User Setup";

}
