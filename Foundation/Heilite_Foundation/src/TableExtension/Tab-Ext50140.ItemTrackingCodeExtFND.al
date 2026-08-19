tableextension 50140 ItemTrackingCodeExtFND extends "Item Tracking Code"
{
    //     DITW15.00.00.38 DDR 14/10/2010 issue 1139 SSCC Functionnalities
    //                                  Added fields
    //                                    2035048 SSCC Lot Tracking
    //                     29/11/2010 #1139 Added test to block SN Tracking while using SSCC
    //                                      Added checking of existing sscc ledger entries
    //                                      Added functions
    //                                        TestSetSpecificSSCC(),TestRemoveSpecificSSCC()
    // DITW16.00.00.40 DDR 21/03/2012 issue 1331
    //                                  Added fields
    //                                    2035059 Allow FEFO Trkg Blocked Lots
    // DITW16.00.00.42 DDR 01/03/2013 DIT-715 #563 Added fields
    //                                               2035060 SSCC Warehouse Tracking
    //                                               2035061 SSCC Purchase Inb. Tracking
    //                                               2035062 SSCC Purchases Outb. Tracking
    //                                               2035063 SSCC Sales Inbound Tracking
    //                                               2035064 SSCC Sales Outbound Tracking
    //                                               2035065 SSCC Pos. Adj. Inb. Tracking
    //                                               2035066 SSCC Pos. Adj. Outb. Tracking
    //                                               2035067 SSCC Neg. Adj. Inb. Tracking
    //                                               2035068 SSCC Neg. Adj. Outb. Tracking
    //                                               2035069 SSCC Transfer Tracking
    //                                               2035070 SSCC Manuf. Inbound Tracking
    //                                               2035071 SSCC Manuf. Outbound Tracking
    //                                               2035072 SSCC Manuf. Inbound Tracking
    //                                               2035073 SSCC Manuf. Outbound Tracking
    //                                             Renamed name field2035048
    //                                             Added functions HasSetupSSCC(),HasSetupInboundSSCC(),HasSetupOutboundSSCC()
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added fields
    //                                               2035049 Check SSCC/Lot Qty. Balance
    //                                             Added functions HasCheckBalanceSSCC(),HasSetupLot(),
    //                                               HasSetupInboundLot(),HasSetupOutboundLot()
    //                 DDR 05/11/2013 DIT-715 #813 Removed field2035049 Check SSCC/Lot Qty. Balance
    //                                             Removed function HasCheckBalanceSSCC()
    //                 DDR 06/11/2013 DIT-715 #801 Added fields
    //                                               2035040 Use SSCC Avail. Inventory

    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.00.02 DDR 05/11/2013 DIT-715 #813 Merge
    // DITW17.00.02 DDR 06/11/2013 DIT-715 #801 Merge

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 28/03/2017 NRQ#25094 Added checks to link SSCC tracking to std tracking
    // QXL11.01 MTR 13/09/2018 NRQ#24975 : Added field 2035098 "Your Reference Required" (Boolean)
    // HEI.01 CHG2119725 FDD-HB2359 IBM.GUNERE01 09.08.2021 # FA related field added
    fields
    {
        field(50000; "FA Related FND"; Boolean)
        {
            Description = 'HEI.01';
            Caption = 'FA Related';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}