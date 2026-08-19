pageextension 58045 PostedPurchCrmemoLinesExtINT extends "Posted Purchase Cr. Memo Lines"
{
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.21 DDR 08/07/2008 Bugfix refresh & show CExpandCollapse column
    //   DITW15.00.00.24 DDR 10/09/2008 Form Editable but all columns not editable except Collapse/Expand column
    //   DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                    Remove functions FormTotalingField()
    //                                    Rewrite functions UpdateFields(),FormTotalingField()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT715 #1 RTC Page functionnalities & Nav SQL performances
    //                   DDR 30/07/2010           Remove OnFormat() field "No."
    //                   CEL 13/08/2010           Modification RTC buttons
    //                   DDR 18/08/2010 DIT717 #13 Added to keep open filters with expand-collapse (ShowAsTree in page)
    //   DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                               Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //   DITW16.00.00.39 DDR 26/09/2011 DIT-715 #141 Added "Total Amount" column for all line types
    //   DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after "Budgeted FA No." field
    //   DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Responsibility Center","Physical Location Group Code",
    //                                                           "Location Code"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //     # New Field added: "CAD Amount"
    //     # Code added on 'OnOpenPage' trigger
    //   HEI.02 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - Zycus Order Line No.
    //                        - Zycus PR Reference No.
    //                        - Zycus PO Type Code
    //                        - Zycus PO Line Type Code
    //                        - Zycus PO Line Validated
    //   HEI.03 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Field - Zycus Movement Type

    //BC Upgrade GUNREM01 Added interface related fields
    layout
    {
        // Add changes to page layout here
        addafter("Budgeted FA No.")
        {
            field("Zycus Order No."; Rec."Zycus Order No. FND")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Zycus Order Line No."; Rec."Zycus Order Line No. FND")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Zycus PR Reference No."; Rec."Zycus PR Reference No. FND")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Zycus PO Type Code"; Rec."Zycus PO Type Code FND")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Zycus PO Line Type Code"; Rec."Zycus PO Line Type Code FND")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Zycus PO Line Validated"; Rec."Zycus PO Line Validated FND")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Zycus Movement Type"; Rec."Zycus Movement Type FND")
            {
                ApplicationArea = all;
                Visible = false;
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