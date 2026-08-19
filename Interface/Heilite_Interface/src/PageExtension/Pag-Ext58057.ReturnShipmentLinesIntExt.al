pageextension 58057 ReturnShipmentLinesIntExt extends "Return Shipment Lines"
{
    // version NAVW110.0,DITW110.00.08,HEI.02,HEI.03

    //  DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
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
    //                                              Added IndentationColumnName property value = ActualExpansionStatusInt
    //   DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after "Quantity Invoiced" field
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW18.00.06 DDR 02/03/2015 DIT-770 #1190 Added fields "Responsiblity Center","Physical Location Group Code"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    //   HEI.01 HT2140 - CHG2105034 IBM NANDIS01 29.04.2021 - Brasco Congo: HT2140 - License Code Process Flow
    //     # New field shown - "License Code"
    //   HEI.02 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - Zycus Order Line No.
    //   HEI.03 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Field - Zycus Movement Type

    //**********************************************//
    //BC UPGRADE SIVA 22/01/2026
    // SUMMARY OF CHANGES :
    //Created new page extension 
    //1.HEI.02 Moved interface fields
    //                        - Zycus Order No.
    //                       - Zycus Order Line No.
    //2.HEI.03 Moved interface field. 
    //                        - Zycus Movement Type
    layout
    {
        addafter("Return Order Line No.")
        {
            field("Zycus Order No."; Rec."Zycus Order No. FND")
            {
                ToolTip = 'Zycus Order No.';
                ApplicationArea = all;
                Visible = false;
            }
            field("Zycus Order Line No."; Rec."Zycus Order Line No. FND")
            {
                ToolTip = 'Zycus Order Line No.';
                ApplicationArea = all;
                Visible = false;
            }
            field("Zycus Movement Type"; Rec."Zycus Movement Type FND")
            {
                ToolTip = 'Zycus Movement Type';
                ApplicationArea = all;
                Visible = false;
            }

        }

    }
}
