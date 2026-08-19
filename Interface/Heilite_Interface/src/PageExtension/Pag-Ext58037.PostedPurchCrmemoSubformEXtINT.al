pageextension 58037 PostedPurchCrmemoSubformEXtINT extends "Posted Purch. Cr. Memo Subform"
{
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.01 DDR 02/01/2008 Added column "Line No." (not editable)
    //                                  property Editable Form = yes (but all fields are non editable except Collapse button)
    //   DITW15.00.00.01 DDR 15/01/2008 Added property Form InsertAllowed,ModifyAllowed,DeleteAllowed=No
    //   DITW15.00.00.01 DDR 15/02/2008 Added function UpdateFormatField()
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                    "Empty Goods Item No."
    //   DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                       21/08/2009 issue 727 Added HorzAlign property in field "Direct Unit Cost","Line Amount"
    //   DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                    Remove functions FormTotalingField()
    //                                    Rewrite functions UpdateFields(),FormTotalingField()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   DDR 30/07/2010           Remove OnFormat() field "No."
    //                                            Remove OnOpenForm() to set fields as non-editable
    //                   CEL 13/08/2010           Modification RTC buttons
    //   DITW15.00.00.38 DDR 17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                                    non editable field "Free Item"
    //   DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                               Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //   DITW16.00.00.39 DDR 26/09/2011 DIT-715 #141 Added "Total Amount" column for all line types
    //   DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                    Added function SetDisableRefreshLines() to call before/after each report object
    //                                                   (don't use the <RunObject> property)
    //   DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added to call function SetFilterSubContractPostType() on AfterGetCurrRecord();
    //                                               Added to call function SetFilterSubContractPostType2() on OnNewRecord()
    //                                               Added fields "DIT Sub-Contract Type","Service Contract No.""Contract Group Code"
    //                   AHU 06/11/2012 DIT-715 #393 Added "Description 2" field

    //   FINXL7.00.001 RBE 25/03/2013 : Added field: "Auto. Acc. Group"

    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                             Rename Field Service contract Type => Contract Type

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //     # New Field added - "TIN No."
    //   HEI.03 CHG2090912 HB1641 IBM NANDIS01 01.02.2021 General Ledger Entries Description
    //     # Make visible of new field - "Additional Description"
    //   HEI.04 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //     # New Field added: "CAD Amount"
    //     # Code added on 'OnOpenPage' trigger
    //   HEI.05 CHG2217161 SAHAL01 09.11.2023 SPL for Returns and GR cancellations
    //     # Added New Fields - SPL Code
    //                        - SPL Name
    //                        - Consumption SPL Code
    //   HEI.06 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //    #New field Added #H&S Levy Tax Amount
    //   HEI.07 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - Zycus Order Line No.
    //                        - Zycus PR Reference No.
    //                        - Zycus PO Type Code
    //                        - Zycus PO Line Type Code
    //                        - Zycus PO Line Validated
    //   HEI.08 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Field - Zycus Movement Type
    //BC Upgrdae GUNREM01 Added
    layout
    {
        // Add changes to page layout here
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