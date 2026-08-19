pageextension 58043 PostedPurchReciptLinesExtINT extends "Posted Purchase Receipt Lines"
{
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.21 DDR 13/06/2008 Added Columns "Weight","Cubage"
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
    //                                           !!  Added IndentationColumnName property value = ActualExpansionStatusInt
    //   DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after "Cubage" field
    //   DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center","Physical Location Group Code"
    //   DITW18.00.07 AKH 16/05/2016 DIT-770 #1346 Added field "Delivery Time (sec.)"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //     # New Field added: "CAD Amount"
    //     # Code added on 'OnOpenPage' trigger
    //   HEI.02 CHG2207454 FDD-3487 IBM MAJUMS03 23.06.2023 # Add columns to Posted Purchase Receipt Lines Report
    //     # Fields added - "Order No."(Field ID. 65), "Order Line No."(Field ID. 66) and "Posting Date"(Field ID. 131).
    //   HEI.03 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - Zycus Order Line No.
    //                        - Zycus PR Reference No.
    //                        - Zycus PO Type Code
    //                        - Zycus PO Line Type Code
    //                        - Zycus PO Line Validated
    //   HEI.04 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Field - Zycus Movement Type

    //BC Upgrade GUNREM01 Added interface related fields
    layout
    {
        // Add changes to page layout here
        addafter("Quantity Invoiced")
        {
            field("Zycus Order No."; Rec."Zycus Order No. FND")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Zycus Order Line No."; Rec."Zycus Order Line No. FND")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Zycus PR Reference No."; Rec."Zycus PR Reference No. FND")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Zycus PO Type Code"; Rec."Zycus PO Type Code FND")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Zycus PO Line Type Code"; Rec."Zycus PO Line Type Code FND")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Zycus PO Line Validated"; Rec."Zycus PO Line Validated FND")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Zycus Movement Type"; Rec."Zycus Movement Type FND")
            {
                Visible = false;
                ApplicationArea = all;
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