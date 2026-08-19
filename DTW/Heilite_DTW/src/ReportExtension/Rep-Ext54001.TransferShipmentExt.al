reportextension 54001 "TransferShipmentExt" extends "Transfer Shipment"
{
    // DITW15.00.00.37 DDR 31/05/2010 issue 480 Modified to skip all item charge lines (except items)
    //  properties DataItemTableView on dataitem "Transfer Shipment Line"
    //   DITW16.00.00.37 CEL 20/08/2010 DIT-715 #1 RTC Report/Page functionnalities & Nav SQL performances
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    //   HEI.01 Defect #3415 IBM NASTAA02 02.11.2018 # Request Order - External Doc. Number
    //     # Added Field "External Document No." to the layout
    //   HEI.02 Defect #3454 IBM NASTAA02 06.11.2018 # Transfer Shipment Report is generating a second page
    //     # Reduced margins of layout to fit on a single page
    //     # Added Transfer Order No. to layout

    //BC UPGRADE SIVA 29.01.2026 Converted NAV report & report layout in BC.

    RDLCLayout = '.\src\ReportsLayout\Transfer Shipment.rdl';
    dataset
    {
        add("Transfer Shipment Header")
        {
            column(TransferShipHeader_ExternalDocNo; "Transfer Shipment Header"."External Document No.")
            {
            }
            column(TransferShipHeader_TransferOrderNo; "Transfer Shipment Header"."Transfer Order No.")
            {
            }

        }
    }
}