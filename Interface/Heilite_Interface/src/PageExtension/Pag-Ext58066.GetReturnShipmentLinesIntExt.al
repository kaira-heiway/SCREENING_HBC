pageextension 58066 GetReturnShipmentLinesIntExt extends "Get Return Shipment Lines"
{
    // version NAVW110.0,DITW110.00.08,HEI.02

    //  DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.01 DDR 02/01/2008 Remove Editable=No on Form (and All fields non-editable except Collapse button)
    //   DITW15.00.00.01 DDR 15/01/2007 Added property Form InsertAllowed,ModifyAllowed,DeleteAllowed=No
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.21 DDR 08/07/2008 Bugfix refresh & show CExpandCollapse column
    //   DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                    Added parmater et return value for function ReadExpansionStatus()
    //                                    Remove functions FormTotalingField()
    //                                    Rewrite functions UpdateFields(),FormTotalingField()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   DDR 30/07/2010           Remove OnFormat() field "No."
    //                   CEL 13/08/2010           Modification RTC buttons
    //                   DDR 18/08/2010 DIT717 #13 Added to keep open filters with expand-collapse (ShowAsTree in page)
    //   DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                               Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //   DITW16.00.00.38 DDR 03/03/2011 DIT-715 #62 RTC Page functionnalities
    //                                               Modified function IsFirstDocLine() in relation to new form workflow
    //   DITW16.00.00.39 DDR 18/07/2011 DIT-715 #62 Modified Button OK
    //                                              Removed 'ModifyAllowed' form property
    //                       04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    //                                                           Added functions UpdateFormatField()
    //                       26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types

    //   DITW17.00.02 DDR 12/07/2013 DIT-770 #94 Removed Expand/Collapse on List (Nav function SETSELECTIONFILTER() is not working)
    //   DITW17.00.02 AT  26/09/2013 DIT-770 #149 Merge HIT124
    //                               New fields Document Date, Return Order No. and Vendor Shipment No.
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center","Physical Location Group Code"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 PTPGAP080 IBM HORTOC01 19.03.2018
    //     # move the fields "Return Order No." and "Vendor Shipment No." from header to colums
    //   HEI.02 CHG2217161 SAHAL01 09.11.2023 SPL for Returns and GR cancellations
    //     # Added New Fields - SPL Code
    //                        - SPL Name
    //                        - Consumption SPL Code
    //*****************************************************//
    //BC UGRADE SIVA//
    //1. HEI.02 Created Page ext for Interface fields.
    //BC UPGRADE ATHUKUS01 FDD_STP008>>
    //1. added new fields in the existing page "Get Return Shipment Lines" which are required for Return order and Vendor Shipment.
    //BC UPGRADE ATHUKUS01 FDD_STP008<<

    layout
    {
        addafter("Return Qty. Shipped Not Invd.")
        {
            field("Return Order No."; Rec."Return Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the return order number this line is associated with.';
            }
            field("Vendor Shipment No."; Rec."Document No.")
            {
                Caption = 'Vendor Shipment No.';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Shipment No. field.', Comment = '%';
            }
            field("SPL Code"; Rec."SPL Code FND")
            {
                ApplicationArea = all;
                ToolTip = 'SPL Code';
            }
            field("SPL Name"; Rec."SPL Name FND")
            {
                ApplicationArea = all;
                ToolTip = 'SPL Name  ';
            }
            field("Consumption SPL Code"; Rec."Consumption SPL Code FND")
            {
                ApplicationArea = all;
                ToolTip = 'Consumption SPL Code';
                Visible = false;
            }
        }



    }
}