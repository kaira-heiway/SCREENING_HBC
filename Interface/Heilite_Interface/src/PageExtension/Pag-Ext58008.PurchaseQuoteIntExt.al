pageextension 58008 PurchaseQuoteIntExt extends "Purchase Quote"
{
    //BC Upgrade SHARMP16----- Interface related fields shifted from main Ext
    // HEI.01 HLSRM02 IBM LAZARE02 26.09.2017 # New tab SRM
    //     HEI.02 FDD-PURGAP027 - Maximo POs approval flow, IBM.POENAB02 , 28.02.2019
    //   # New field added in "General" group - 50002 Payment User. Set EDITABLE property for this field to FALSE.
    // HEI.03 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Removed Field "Payment User"
    //   # Added Field “PQ Approver”
    //   # Created new Page Action "Purchase Additional"
    //-------------------------------------------------------
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                New calling functions to insert (item) charges
    // DITW15.00.00.01 DDR 21/01/2008 Remove unused textconst
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    // DITW15.00.00.25 DDR 21/10/2008 Deleted field2013722 Duty Tax Type
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 14/12/2010 issue 1245 Resize width form (fix import text merge?)
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
    // DITW15.00.00.39 DDR 27/04/2011 issue 1323 NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                Added to call function StdVendPurchCode.AutoInsertPurchLines()
    //                                  from OnAfterValidate trigger field "Sell-to Customer No."
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                              Added to insert first line automatically
    //                     19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab

    // FINXL7.00.001 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0012.1
    //                             added requester id
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added in General Tab
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code"
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1191 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    // DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4

    // HEI.01 HLSRM02 IBM LAZARE02 26.09.2017 # New tab SRM
    // HEI.02 FDD-PURGAP027 - Maximo POs approval flow, IBM.POENAB02 , 28.02.2019
    //   # New field added in "General" group - 50002 Payment User. Set EDITABLE property for this field to FALSE.
    // HEI.03 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Removed Field "Payment User"
    //   # Added Field “PQ Approver”
    //   # Created new Page Action "Purchase Additional"
    // HEI.04 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    // HEI.06 CHG2046174 IBM Shankj03
    //   # Field added "Lead Time Calculation.
    // HEI.07 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //  # New Field Added License Code
    //  # Code added in triggers
    // HEI.08 FDD-HB1341 CHG2065548 IBM SHANKJ03  10.08.2020
    //  #Code Added in Archieve & Delete Action button
    // HEI.10 HT1136 CHG2084917 IBM.GUNERE01 11.03.2020 # Added Code in License Code Onvalidate trigger
    // HEI.11 CHG2088708 IBM PANDES01 23-12-2020
    //  # Added Action Purchase quote Approval.
    // HEI.12 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field added in General tab: LSR Order No
    //   # code added in OnAfterGetRecord()
    // Hei.13  CHG2096764 IBM. PANDES01  12.03.2021
    //  # Added code for Requesters ID.
    // HEI.14 CHG2105495- Defect - 6206 IBM NANDIS01 07.04.2021 - Haiti fix for defect 6206 Location error when approving PO/PQ
    //   # Defect raised from Haiti opco - location code should be mandatory while sending the doc to approver
    // HEI.15 FDD-HB1195 CHG2070051 IBM GUNERE01 04.02.2021 # Import Identifier field added
    // HEI.16 CHG2123487 IBM BHATTA  20.10.2021
    //   # Code added for CMG Dimension mandatory for Shipping Cost type Item Charges
    // BC Upgrade SHUKLP03 >> Added field "LSR Order No."
    layout
    {
        addafter("Foreign Trade")
        {
            group(Maximo)
            {
                Caption = 'Maximo';
                field("Maximo Requisition No."; Rec."Maximo Requisition No. FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Maximo Requisition No. field.';
                }
                field("Import Identifier"; PurchaseHeaderAdditional."Import Identifier")
                {
                    Caption = 'Import Identifier';
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Import Identifier field.';
                }
            }
            group(SRM)
            {
                Caption = 'SRM';
                field("SRM Contract No."; Rec."SRM Contract No. FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the SRM Contract No. field.';
                }
                field("SRM Contract Name"; Rec."SRM Contract Name FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the SRM Contract Name field.';
                }
                field("SRM Contract Type"; Rec."SRM Contract Type FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Contract Type field.';
                }
                field("Shipment Method Location"; Rec."Shipment Method Location FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Shipment Method Location field.';
                }
                field("Valid From"; Rec."Valid From FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Valid From field.';
                }
                field("Valid To"; Rec."Valid To FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Valid To field.';
                }
                field(Channel; Rec."Channel FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Channel field.';
                }
                field("Target Value Amount"; Rec."Target Value Amount FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Target Value Amount field.';
                }
                field(Closed; Rec."Closed FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                // BC Upgrade SHUKLP03 >>
                // field("LSR Order No."; PurchaseHeaderAdditional."LSR Order No")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                //     ToolTip = 'Specifies the value of the LSR Order No field.';
                // }//BC Upgrade SHARMP16-- Purchase Page Formatting changes.
                // BC Upgrade SHUKLP03 <<
            }
        }
        //BC Upgrade SHARMP16 BEGIN>>-- Purchase Page Formatting changes.
        addafter(LicenseCode)
        {
            field("LSR Order No. INT"; PurchaseHeaderAdditional."LSR Order No INT")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                ToolTip = 'Specifies the value of the LSR Order No field.';
            }
        }
        //BC Upgrade SHARMP16 END<<-- Purchase Page Formatting changes.
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
}