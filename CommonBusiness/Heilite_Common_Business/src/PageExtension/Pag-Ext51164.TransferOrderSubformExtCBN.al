pageextension 51164 TransferOrderSubformExtCBN extends "Transfer Order Subform"
{
    // version NAVW110.0,FINXL8.00.001,MANXL7.00.001,QXL9.00.001,DITW110.00.08
    //     DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    // DITW15.00.00.25 DDR 10/10/2008 Added fields "Truck Code","Driver Code" (non-visible default)
    // DITW15.00.00.36 DDR 17/12/2009 issue 594 Added fields "AAD No. Series - Shipment","AAD No. - Shipment","AAD No. - Receipt"
    // DITW15.00.00.37 DDR 04/01/2010 issue 594 Non editable AAD fields if automatically filled
    //                     08/02/2010 issue 480 Added Internal Taxes functionnality
    //                                          Added fields "Transfer-from Code","Transfer-to Code","Item Charge No."
    //                                            "Collapse",ActualExpansionStatus
    //                                          Added functions InsertExtendedCharges(),UpdateFields(),
    //                                            DoExpandCollapse(),DoExpandAll(),DoCollapseAll(),UpdateFormatField(),UpdateExpandStatus()
    //                                            UpdateADDFields()
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "Item No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    "LRN Nos Series","LRN No.","ARC No.","SAD No."
    //                                  Hidden fields
    //                                    "AAD Nos Series - Shipment","AAD No. - Shipment","AAD No. - Receipt"
    //                     04/10/2010   Added fields
    //                                    "ARC No. - Reciept"
    // DITW15.00.00.38 DDR 15/11/2010 issue 1139 SSCC Functionnalities
    //                                       Added functions OpenSSCCTrackingLines()
    //                     21/12/2010 issue 1171 Added fields "Unit Amount","Line Amount" (non-editable)
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                                             Modified "Item Charge No." as non-editable (function UpdateFields)
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #1 RTC Upgrade Page functionnalities
    //                                             Modified function UpdateFields()
    // DITW16.00.00.38 DDR 07/03/2011 DIT-715 #71 RTC Upgrade Page functionnalities
    //                                             Modified order position RTC buttons
    //                                               contol1102601007 RTCNewLine
    //                                               contol1102601008 RTCDeleteLine
    //                                               contol1102601009 RTCDleteAllLines
    //                     11/03/2011 issue 703 Added Column "Tracking Item No." (on item charges)
    //                     16/03/2011 issue 1217 (DIT711 161) Added field "Packaging Type Code"
    // DITW15.00.00.39 DDR 12/04/2011 issue 1296 Added AAD/ARC functionnality
    //                                           Added editable "ARC No. - Receipt" when mandatory
    //                                           Added function ShowGetARCNoEDI()
    //                                           Added text constant Text2014260
    //                     11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
    //                     26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    // DITW16.00.00.39 DDR 26/09/2011 DIT-715 #141 Added "Total Amount" column for all line types
    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  Added function SetDisableRefreshLines() to call before/after each report object
    //                                                 (don't use the <RunObject> property)
    // DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244 Added shortcut (warehouse) fields
    //                                       Control1100079000 Shortcut Unit of Measure1 Code
    //                                       Control1100079001 Shortcut Unit of Measure2 Code
    //                                       Control1100079002 Shortcut Unit of Measure3 Code
    //                     15/11/2011 issue 1462 Bugfix several test on production fields for Internal item charges
    //                     05/01/2012 DIT-715 #172 Added fields
    //                                    2013803 Allow VAT Calculation (Free)
    //                     03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                       Added function FEFOTracking()
    //                                       Added functions CreateFEFOTracking(),CreateFEFOTrackingJournal()
    //                                       Rewrite function CreateFEFOTrackingJournal()
    //                                       Added error message on "Entry Type" field for FEFOTracking()
    //                     21/03/2012 #1331 Bugfix function CreateFEFOTrackingJournal()
    //                     03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                       Modified OnAssistEdit trigger field "No."
    //                     13/06/2012 DIT-715 #332 RTC remove temporary new blank lines while closing form/page
    //                     13/06/2012 DIT-715 #338 Added functions AllItemsAvailability()

    // MANXL7.00.001 DAT 05/03/2014 #18: Added field "Requester ID"
    // FINXL8.00.001 BSA 29/05/2015 #180: Added Replenishment Status
    // FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No.", "Emergency Order"

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Unit Amount"
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code","Vol-Strength Spec. Value","Unit Volume HL"
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Removed 'Editable' property for fields "strength Spec. Value","vol-strength Spec. Value"
    // DITW19.00.08 DDR 14/11/2016 BL#10443 Added from sales/purchase functionality

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW111.00.13A MSF 30/04/2019 NRQ#106834 AUTO FEFO and Undo Tracking Lines functions for transfer orders
    //                                           Added Action &Automatic FEFO Tracking for Order

    // BC Upgrade SHUKLP03 >>
    // Table Transfer Line => Table HEI.01 code added here, description made editable false on page "Transfer Order Subform". 
    // BC Upgrade SHUKLP03 <<

    layout
    {
        modify(Description)
        {
            Editable = FALSE; // HEI.01
        }
        //BC Upgrade GUNREM01 >> Added new fields "Transfer-from Code","Transfer-to Code" and made them visible on page.
        modify("Transfer-from Bin Code")
        {
            Visible = true;
        }
        modify("Transfer-to Bin Code")
        {
            Visible = true;
        }
        addafter("Transfer-from Bin Code")
        {
            field("Transfer-from Code"; Rec."Transfer-from Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Transfer-to Bin Code")
        {
            field("Transfer-to Code"; Rec."Transfer-to Code")
            {
                ApplicationArea = All;
            }

        }
        //BC Upgrade GUNREM01 << Added new fields "Transfer-from Code","Transfer-to Code" and made them visible on page.

    }


}