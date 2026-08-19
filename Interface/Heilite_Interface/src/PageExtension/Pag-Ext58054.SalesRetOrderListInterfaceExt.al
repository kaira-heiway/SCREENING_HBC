namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Sales.Document;
using System.Security.User;

pageextension 58054 SalesRetOrderListInterfaceExt extends "Sales Return Order List"
{
    // version NAVW110.0.00.15052,FINXL14.00.15,DITW110.00.09,HEI.01
    // DITW15.00.00.24 DDR 07/10/2008 Added columns
    //                                   Status,"Duty Tax Type","Disc.Promo. Order Calculated",
    //                                   "Shipping Charge Per","Total Weight","Total Cubage",Distance,
    //                                   "Link Sales Document Type","Link Sales Document No."
    //   DITW15.00.00.25 DDR 21/10/2008 Deleted field2013722 Duty Tax Type
    //   DITW15.00.00.35 DDR 13/10/2009 Added columns "Building No."
    //   DITW15.00.00.38 DDR 17/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                    Added columns
    //                                      "Customer Tax Registration No.","Fiscal Representative No.",
    //                                      "Customer Tax Warehouse Ref."
    //   DITW16.00.00.40 DDR 20/02/2012 DIT-715 #244
    //                                  Added shortcut (warehouse) fields
    //                                    Control1100079000 Shortcut Unit of Measure1 Code
    //                                    Control1100079001 Shortcut Unit of Measure2 Code
    //                                    Control1100079002 Shortcut Unit of Measure3 Code
    //                                  Added Standard Global Dimension Lookup (see from 53 as reference)
    //                       20/02/2012 DIT-715 #244 Added/Moved columns
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW18.00.06 DDR 02/03/2015 DIT-770 #1190 Added fields "Responsiblity Center","Physical Location Group Code"
    //   DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field "Sundry Customer"
    //   DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Add Action to Shipping Cost Page + Removed old Shipping Costs fields
    //   DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    //   DITW18.00.07 DDR 11/04/2016 DIT-770 #1488 Updated ShowShortcutUomValue function

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   HEI.01 FDD-AL-GAPLOG05 IBM NASTAA02 29.09.2017 # Unloading Note template for Algeria
    //     # New Action Button created to print the Unloading Note
    //   DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
    //                                 Added Field "Disable DIT Disc. Prom."
    //   HEI.01 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    //   DITW111.00.13A DDR 01/07/2019 NRQ#103938 Added visibility for Action Send Approval
    //   FINXL11.00 HBA 03/05/2018 NRQ#69018 : Added Action "Auto. Send IC Return Order"
    //   DITW111.00.13A NLAB 25/06/2019 NRQ#113801 : Merge NRQ#69018

    //   HEI.02 CHG2046145 IBM.GAVANM01 16.03.2020 # Sales Order Status Addition
    //     # New field added : 50051 - "Approval Status"
    //   FINXL14.00.15 MSF 13/05/2020 NRQ#117628 Enable /Disable AutoSend To IC
    //   HEI.03 CHG2065153 IBM KUMARN15 23.06.2020
    //     # Added field "Source System Identifier"
    //   HEI.04 FDD-HB899 - CHG2093015 IBM NASTAA02  19.01.2021 # LSR - Sales And Payments
    //     # Code added on "Create &Whse. Receipt" Action
    //*********************************//
    //BC UPGRADE SIVA 21/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.01 Added action. & Moved to "Load No." & "Sequence No." Inteface app.


    layout
    {
        addafter("Salesperson Code")
        {
            field("Load No."; Rec."Load No. FND")
            {
                Visible = true;
                ApplicationArea = All;
                ToolTip = 'Load No.';
            }
            field("Sequence No."; Rec."Sequence No. FND")
            {
                Visible = true;
                ApplicationArea = All;
                ToolTip = 'Sequence No.';
            }


        }
    }





}
