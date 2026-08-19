pageextension 58028 PostedPurchaseInvExtINT extends "Posted Purchase Invoice"
{
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.21 DDR 27/06/2008 Added button Shipping Transport
    //   DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    //   DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code","Driver Code" into "Shipping" tab
    //                       21/10/2008 Deleted field2013722 Duty Tax Type
    //                                  Added fields "Vendor DTax Group Code" into Invoicing tab
    //   DITW15.00.00.35 DDR 14/10/2009 issue 788 Added Form property DeleteAllowed = No
    //   DITW15.00.00.39 DDR 19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    //   DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                    call function SetDisableRefreshLines() before each report
    //                                                    (don't use the <RunObject> property)
    //   DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added 'Service/Contract' tab
    //                                               Added fields into 'Service/Contract' tab
    //                                                 "DIT Sub-Contract Type","Contract Group Code","Service Contract No."
    //                                               Moved "Building No." into 'Service/Contract' tab

    //   FINXL7.00.001 RBE 20/03/2013 : Added field "Your Reference","Posting Description" on page
    //                                  Added PDF Functionality
    //   FINXL8.00.001 BSA 16/06/2015 : Added Field OGM

    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code"
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                             Rename Field Service contract Type => Contract Type
    //   DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    //   DITW110.00.11 MSF 25/08/2017 NRQ#17902 Route settlement - Order Payments, Suggest customer and vendor payments
    //                                          Added field Document Subtype Code ,

    //   HEI.01 FDD-PTPGAP013- IBM PATHAA02   31.07.2017
    //     #New field 'Payment Status' Aligned
    //     #Modify allowoed' property changed to 'Yes'

    //   HEI.02 HLSRM02-05 IBM LAZARE02 31.07.2017
    //     #New fields for SRM integration added to SRM tab

    //   HEI.03 FDD-PTPGAP041 IBM PATHAA02 20.08.17
    //   # Aligned new fields "Payment User" and "Status Date"//29.09.17
    //   # Removed Code from on Onqueryclose page//29.09.17
    //   HEI.04 FDD-PURGAP027 IBM NASTAA02 14.06.2019 # Maximo POs Approval Flow
    //     # Created new Page Action "Purchase Invoice Additional"
    //   HEI.05 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //     # New Field added: "Fixed Asset Acquisition"
    //   HEI.06 CHG2024557 FDD-HT821 IBM SHANKJ03 12.02.2020
    //     # New field added Maximo Status
    //   HEI.07 FDD-HB2638 CHG2136725 IBM NANDIS01 23.02.2022 Block create Corrective Credit memo option in HL
    //       # Code added to control of using button - Create Corrective Credit Memo
    //HEI.07- //BC Upgrade GUNREM01 Code not added becuase its DIT Code.
    //HEI.02 //BC Upgrade GUNREM01 fields added in interface 


    //BC Upgrade GUNREM01 Added fields in interface
    layout
    {
        addafter("Shipment Method Code")
        {
            group(SRM)
            {
                Caption = 'SRM';
                field("SRM Contract No."; Rec."SRM Contract No. FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the SRM Contract No. field.';
                }
                field("SRM Contract Name"; Rec."SRM Contract Name FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the SRM Contract Name field.';
                }
                field("SRM Contract Type"; Rec."SRM Contract Type FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the SRM Contract Type field.';
                }
                field("Valid From"; Rec."Valid From FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Valid From field.';
                }
                field("Valid To"; Rec."Valid To FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Valid To field.';
                }
                field(Channel; Rec."Channel FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Channel field.';
                }
                field("Shipment Method Location"; Rec."Shipment Method Location FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Shipment Method Location field.';
                }
                field("Contract Closed"; Rec."Contract Closed FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Contract Closed field.';
                }
                field("SRM Order No."; Rec."SRM Order No. FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the SRM Order No. field.';
                }
                field("Target Value Currency"; Rec."Target Value Currency FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Target Value Currency field.';
                }
                field("Target Value Amount"; Rec."Target Value Amount FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Target Value Amount field.';
                }
            }
        }
        addafter(Corrective)
        {
            field("Maximo Status"; Rec."Maximo Status INT")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Maximo Status field.';
            }
        }
    }
    actions
    {
        addafter(Approvals)
        {
            action("Purchase Invoice Additional")
            {
                Caption = 'Purchase Invoice Additional';
                Image = Purchase;
                ApplicationArea = All;
                RunObject = Page "Purch. Inv. Additional";
                RunPageLink = "No." = FIELD("No.");
                ToolTip = 'Executes the Purchase Invoice Additional action.';

            }
        }
        // Add changes to page actions here
    }

}
