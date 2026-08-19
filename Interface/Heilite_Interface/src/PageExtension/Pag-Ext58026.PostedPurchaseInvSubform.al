pageextension 58026 PostedPurchInvsubformExt extends "Posted Purch. Invoice Subform"
{
    // version NAVW110.0,DITW110.00.10,HEI.05,HEI.06
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.01 DDR 02/01/2008 Added column "Line No." (not editable)
    //                                  property Editable Form = yes (but all fields are non editable except Collapse button)
    //   DITW15.00.00.01 DDR 15/01/2008 Added property Form InsertAllowed,ModifyAllowed,DeleteAllowed=No
    //   DITW15.00.00.01 DDR 15/02/2008 Added function UpdateFormatField()
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.24 DDR 14/08/2008 Added fields (not editable) "Weight","Cubage",
    //   DITW15.00.00.25 DDR 17/10/2008 Non-Editable Cubage,Weight,Distance
    //   DITW15.00.00.28 DDR 24/11/2008 Added fields "AAD No."
    //   DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                    "Empty Goods Item No."
    //   DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //   DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                    Remove functions FormTotalingField()
    //                                    Rewrite functions UpdateFields(),FormTotalingField()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   DDR 30/07/2010           Remove OnFormat() field "No."
    //                   CEL 13/08/2010           Modification RTC buttons
    //   DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                    Added fields
    //                                      "LRN No.","ARC No.","SAD No."
    //                                    Hidden fields
    //                                      "AAD No."
    //                       05/10/2010   Added fields
    //                                      "ARC Line No.","Unsatisfactory reason","Unsatisfactory quantity","unsatisfactory comments"
    //                                    Added functions
    //                                      ShowLineUnstatisfactoryCmts()
    //                                    Set not editable fields if undo is done
    //                       26/11/2010 #1217 (DIT711 56)
    //                                    Added fields "Arc Line No." (editable)
    //                       17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                                    non editable field "Free Item"
    //                       03/01/2011 issue 1217 (DIT711 56) Removed non editable when Arc Line No. is filled
    //   DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                               Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //   DITW15.00.00.39 DDR 11/07/2011 issue 1369 Added fields "Applies-to AAD Trck. Entry No."
    //   DITW16.00.00.39 DDR 26/09/2011 DIT-715 #141 Added "Total Amount" column for all line types
    //   DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                    Added function SetDisableRefreshLines() to call before/after each report object
    //                                                   (don't use the <RunObject> property)
    //   DITW16.00.00.41 AHU 06/11/2012 DIT-715 #393 Added "Description 2" field

    //   DITW17.00.02 DDR 04/07/2013 DIT-770 #99 Removed field "Ship-to Country/Region Code"
    //                                           Added fields "GWC Country/Region Code"
    //                    28/08/2013 DIT-770 #178 Remove DIT-770 #99
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center","Physical Location Group Code"
    //   DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Changes for backorders
    //   HEI.01 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //     # New Field added: "CAD Amount"
    //     # Code added on 'OnOpenPage' trigger

    //   HEI.02 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //     # SPL Code, SPL Name - fields created
    //   HEI.03 CHG2201773 HB3442 IBM SRIVAS07 16.02.24 # Finetuning - Undoing a Goods Receipt for Fixed Asset
    //     # Added few code in UndoReceiptLine()
    //   HEI.04 CHG2229933 HB3689 IBM SRIVAS07 25.04.2024 # SRM Reference Document Mapping - Development
    //     # Added field - "Vendor Shipment No."
    //   HEI.05 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - Zycus Order Line No.
    //                        - Zycus PR Reference No.
    //                        - Zycus PO Type Code
    //                        - Zycus PO Line Type Code
    //                        - Zycus PO Line Validated
    //   HEI.06 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Field - Zycus Movement Type
    //HEI.05 and HEI.06 BC upgrade GUNREM01 added fields 
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {

            field("Zycus Order No."; Rec."Zycus Order No. FND")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus Order No. field.';
            }
            field("Zycus Order Line No."; Rec."Zycus Order Line No. FND")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus Order Line No. field.';
            }
            field("Zycus PR Reference No."; Rec."Zycus PR Reference No. FND")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus PR Reference No. field.';
            }
            field("Zycus PO Type Code"; Rec."Zycus PO Type Code FND")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus PO Type Code field.';
            }
            field("Zycus PO Line Type Code"; Rec."Zycus PO Line Type Code FND")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus PO Line Type Code field.';
            }
            field("Zycus PO Line Validated"; Rec."Zycus PO Line Validated FND")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus PO Line Validated field.';
            }
            field("Zycus Movement Type"; Rec."Zycus Movement Type FND")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus Movement Type field.';
            }
        }
    }



    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
