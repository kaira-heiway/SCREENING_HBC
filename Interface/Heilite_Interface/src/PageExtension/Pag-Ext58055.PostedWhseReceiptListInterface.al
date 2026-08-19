pageextension 58055 PostedWhseReceiptListIntExt extends "Posted Whse. Receipt List"
{
    // version NAVW110.0,DITW110.00.12

    // DITW15.00.00.21 DDR 19/06/2008 added columns
    //                                  "Shipping Charge Type","Shipping Charge No.","Shipping Charge Per"
    //                                  "Shipping Agent Code","Shipping Agent Service Code","Shipment Method Code","Shipment Date"
    //                                  "Total Weight","Total Volume"
    //                                resize form + HorizGlue on control8
    //                                add form's property CalcFields
    // DITW15.00.00.25 DDR 17/10/2008 Addded columns "Truck Code","Driver Code"
    // DITW15.00.00.35 DDR 19/08/2009 issue 773 Added fields "Shipping Currency Code"
    //                 DDR 06/10/2009 issue 516 Added field "Physical Location Group Code"
    // DITW15.00.00.37 DDR 02/06/2010 issue 1061 Added default Not visible fields "Physical Location Group Code"
    // DITW16.00.00.39 DDR 29/07/2011 DIT-715 #120 Merge error design button "Receipt"
    // DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                                Added Standard Global Dimension Lookup (see from 53 as reference)
    // DITW18.00.07 VSC 15/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Removed old Shipping Costs fields from Shipping Tab

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Fields
    //                                      "Require 2 Drivers"
    //                                      "Driver 2 Code"
    //                                      Route
    //                                      "Route Planning No."
    // DITW110.00.12 MSF 23/03/2018 NRQ#64208 Return registration & Control û part 4 û Report driver differences
    //                                        Added Action Posted Return Register Control
    // HEI.01 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New fields added: LSR Order No, LSR Receipt No

    //BC Upgrade KAPOOV01--- Created new Interface Page Extension for LSR Interface related fields- LSR Order No, LSR Receipt No.

    layout
    {
        addafter("Assignment Date")
        {
            field("LSR Order No."; Rec."LSR Order No. FND")
            {
                ApplicationArea = All;
            }
            field("LSR Receipt No."; Rec."LSR Receipt No. FND")
            {
                ApplicationArea = All;
            }
        }
    }
}
