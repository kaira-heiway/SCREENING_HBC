pageextension 58052 PurchaseReturnOrderSubIntExt extends "Purchase Return Order Subform"
{
    // version NAVW110.0,FINXL7.00.001,QXL9.00.001,DITW110.00.09,HEI.07,HEI.08
    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    //   DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.01 DDR 02/01/2007 Added column "Line No." (not editable)
    //                                  Bugfix AutoSplitKey process on new record with Collapse/Expand functionnality
    //   DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    //   DITW15.00.00.01 DDR 10/01/2008 Bugfix using F8 on new line
    //                                  Change property HorzAlign=Right for collapsed total fields (line amount)
    //                                  Added parameter BlankZero for function UpdateFormatField()
    //                                  Remove ProcessTaxItemCharge();ProcessUpdateUnitPrice();InsertTaxItemCharge();
    //   DITW15.00.00.01 DDR 23/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    //                                  Added field "Collapse"
    //                                  Bugfix Refresh columns
    //                                  Added function UpdateExpandStatus
    //                                  Change function UpdateFields for Discount & Promotion
    //   DITW15.00.00.01 DDR 19/03/2008 move function InsertExtendedCharges()
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.16 DDR 26/03/2008 Remove (move into function) confirm message from function InsertExtendedCharges()
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.23 DDR 29/07/2008 Remove call function InsertExtendedCharges() from trigger OnAfterValidate field "No."
    //                                  Updated function into InsertExtendedCharges()
    //                       31/07/2008 Move NewRecord() function into OnNewRecord trigger
    //   DITW15.00.00.28 DDR 24/11/2008 Added fields "AAD No. Series","Tariff No."
    //   DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                    "Empty Goods Item No."
    //   DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                       21/08/2009 issue 727 Added HorzAlign property in field "Direct Unit Cost"
    //                   DLE 06/09/2009 issue 516 Added field "Physical Location Group Code"
    //                   DDR 14/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    //   DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                  Added function FormTotalingField()
    //   DITW15.00.00.37 DDR 26/01/2009 issue 939 Performance SQL error call function into OnModify() trigger
    //                       01/06/2010 issue 959 Moved column field "AAD No."
    //                       02/06/2010 issue 1061 Added default Not visible fields "Physical Location Group Code"
    //   DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    //   DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                    Added parmater et return value for function ReadExpansionStatus()
    //                                    Remove functions FormTotalingField()
    //                                    Rewrite functions UpdateFields(),FormTotalingField()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   DDR 30/07/2010           Remove OnFormat() field "No."
    //                   CEL 13/08/2010           Modification RTC buttons
    //   DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                    Added fields
    //                                      "EMCS LRN Nos Series"
    //                                    Hidden fields
    //                                      "AAD Nos Series"
    //                       08/10/2010   Added fields
    //                                      "SAD No."
    //                       17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                       27/01/2011 issue 1259 Added update() on field "Cross-Reference No."
    //                                             Added non-editable when item is (free) item charge
    //   DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                               Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //   DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                             Added parameter line function RTCActionNewLine() into RTCNewLine button
    //   DITW16.00.00.38 DDR 03/03/2011 DIT-715 #1 RTC Upgrade Page functionnalities
    //                                               Modified function UpdateFields()
    //   DITW16.00.00.38 DDR 07/03/2011 DIT-715 #71 RTC Upgrade Page functionnalities
    //                                               Modified order position RTC buttons
    //                                                 contol1102601007 RTCNewLine
    //                                                 contol1102601008 RTCDeleteLine
    //                                                 contol1102601009 RTCDleteAllLines
    //                       15/03/2011 issue 1291 Modified trigger field "No." activate function InsertExtendedText() other than items
    //                       16/03/2011 issue 1217 (DIT711 161) Added field "Packaging Type Code"
    //   DITW15.00.00.39 DDR 11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
    //   DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    //                       26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                       26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    //   DITW16.00.00.40 DDR 22/12/2011 issue 1429 Added functions OpenSSCCTrackingLines()
    //   DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                       11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                    Added function SetDisableRefreshLines() to call before/after each report object
    //                                                   (don't use the <RunObject> property)
    //                       03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                               Modified OnAssistEdit trigger field "No."
    //   DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added to call function SetFilterSubContractPostType() on AfterGetCurrRecord();
    //                                               Added to call function SetFilterSubContractPostType2() on OnNewRecord()
    //                                               Added fields "DIT Sub-Contract Type","Service Contract No.""Contract Group Code"
    //                   AHU 06/11/2012 DIT-715 #393 Added "Description 2" field

    //   FINXL7.00.001 RBE 20/03/2013 : Added fields "Tariff No." & "Net Weight" (not visible)
    //                                  Added field: "Auto. Acc. Group"
    //   DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    //   DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //                               added approved prod group + approved line amount
    //   DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW17.10.03 DDR 10/06/2014 DIT-770 #541 Modified 'QuickEntry' property fields "Has Item Charge","Collapse"
    //                                            Removed 'IndentationControls' field1 Group Repeater
    //   DITW17.10.03 DDR 10/07/2014 DIT-770 #541 Added editable other types than Item
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center"
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                             Rename Field Service contract Type => Contract Type

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   QXL9.00.001 DAT 23/03/2016 : Quality Management
    //   DITW110.00.09 DDR 13/04/2017 NRQ#13107 Added missing EMCS Fields
    //   DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackUnitPriceItem()
    //   HEI.07 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - Zycus Order Line No.
    //                        - Zycus PR Reference No.
    //                        - Zycus PO Type Code
    //                        - Zycus PO Line Type Code
    //                        - Zycus PO Line Validated
    //   HEI.08 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Field - Zycus Movement Type
    //*************************************************//
    //BC UPGRADE SIVA 21/01/2026
    //1. HEI.07,HEI.08 Interface related fields shifted to General app Purch Ret Order subform to Inteface app  

    layout
    {
        addafter("Budgeted FA No.")

        {
            field("SRM Contract No."; Rec."SRM Contract No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'SRM Contract No.';

            }
            field("SRM Contract Line No."; REc."SRM Contract Line No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'SRM Contract Line No.';
            }
            field("SRM Contract Type"; Rec."SRM Contract Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRM Contract Type field.';
            }
            field("SRM Order Line No."; Rec."SRM Order Line No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRM Order Line No. field.';
            }
            field("SRM Order No."; Rec."SRM Order No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRM Order No. field.';
            }

            field("Zycus Order No."; Rec."Zycus Order No. FND")
            {
                ToolTip = 'Zycus Order No.';
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
            field("Zycus Order Line No."; Rec."Zycus Order Line No. FND")
            {
                ToolTip = 'Zycus Order Line No.';
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
            field("Zycus PR Reference No."; Rec."Zycus PR Reference No. FND")
            {
                ToolTip = 'Zycus PR Reference No.';
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
            field("Zycus PO Type Code"; Rec."Zycus PO Type Code FND")
            {
                ToolTip = 'Zycus PO Type Code';
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
            field("Zycus PO Line Type Code"; Rec."Zycus PO Line Type Code FND")
            {
                ToolTip = 'Zycus PO Line Type Code';
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
            field("Zycus PO Line Validated"; Rec."Zycus PO Line Validated FND")
            {
                ToolTip = 'Zycus PO Line Validated';
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
            field("Zycus Movement Type"; Rec."Zycus Movement Type FND")
            {
                ToolTip = 'Zycus Movement Type';
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
        }
    }


}