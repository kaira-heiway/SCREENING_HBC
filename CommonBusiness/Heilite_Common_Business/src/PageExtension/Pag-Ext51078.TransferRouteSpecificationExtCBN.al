pageextension 51078 TransferRouteSpecificExtCBN extends "Transfer Route Specification"
{
    //    DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields "Driver Mandatory","Truck No. Mandatory"

    // FINXL7.00.001 RBE 20/03/2013 : Added new field 2029610 - Automatic Ship & Receive

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.12 AKH 30/03/2018 NRQ#16026 Order Shipment Planning: Sync Sales - Transfer
    // HEI.01 FDD-HT658 IBM.GUNERE01 29.08.2019 # "Shipping Agent Code Mantatory", "Ship. Ag. Serv. Code Mandatory" fields added
    // HEI.02 FDD-HT658 IBM.GUNERE01 22.10.2019 # Route field added

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("In-Transit Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location set up to be used as an in-transit location.', FRA = 'Indique le code du magasin configuré pour être utilisé comme magasin transit.';
        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies the code for the shipping agent who you usually use for this transfer route.', FRA = 'Indique le code du transporteur à qui vous faites habituellement appel pour cet acheminement transfert.';
        }
        modify("Shipping Agent Service Code")
        {
            ToolTipML = ENU = 'Specifies the code for the shipping agent service you usually use for this transfer route.', FRA = 'Indique le code prestation du transporteur à qui vous faites habituellement appel pour cet acheminement transfert.';
        }
        addafter("Shipping Agent Service Code")
        {
            // field("Driver Mandatory"; Rec."Driver Mandatory")
            // {
            // }//BC Upgrade SHARMp16 Drink-IT field
            // field("Truck No. Mandatory"; Rec."Truck No. Mandatory")
            // {
            // }//BC Upgrade SHARMp16 Drink-IT field
            field("Shipping Agent Code Mantatory"; Rec."Shipping Ag. Code Mandat. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping Agent Code Mantatory field.';
            }
            field("Ship. Ag. Serv. Code Mandatory"; Rec."Ship. Ag. Serv. Cod Mndat. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping Agent Service Code Mandatory field.';
            }
            // field("Automatic Ship & Receive"; Rec."Automatic Ship & Receive")
            // {
            //     Description = 'FINXL7.00.001';
            // }//BC Upgrade SHARMp16 Drink-IT field
            // field(Route; Rec.Route)
            // {
            // }//BC Upgrade SHARMp16 Drink-IT field
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

