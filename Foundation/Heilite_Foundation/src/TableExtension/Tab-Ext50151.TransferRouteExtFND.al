tableextension 50151 TransferRouteExtFND extends "Transfer Route"
{
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added functions GetJourneyTime(),CalcJourneyTime()
    //                     01/08/2011 issue 1353 fill in "Journey time" with "Shipping time" when first one is empty.
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002
    //                                  Added fields
    //                                    2014065 Driver Mandatory
    //                                    2014066 Truck No. Mandatory

    // FINXL7.00.001 RBE 20/03/2013 : Added new field 2029610 - Automatic Ship & Receive

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.12 AKH 30/03/2018 NRQ#16026 Order Shipment Planning: Sync Sales - Transfer
    // HEI.01 FDD-HT658 IBM.GUNERE01 29.08.2019 # "Shipping Agent Code Mantatory", "Ship. Ag. Serv. Code Mandatory" fields added

    fields
    {
        modify("Transfer-from Code")
        {
            CaptionML = ENU = 'Transfer-from Code', FRA = 'Code prov. transfert';
        }
        modify("Transfer-to Code")
        {
            CaptionML = ENU = 'Transfer-to Code', FRA = 'Code dest. transfert';
        }
        modify("In-Transit Code")
        {
            CaptionML = ENU = 'In-Transit Code', FRA = 'Code transit';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        field(50000; "Shipping Ag. Code Mandat. FND"; Boolean)
        {
            Caption = 'Shipping Agent Code Mantatory';
            Description = 'HEI.01';
        }
        field(50001; "Ship. Ag. Serv. Cod Mndat. FND"; Boolean)
        {
            Caption = 'Shipping Agent Service Code Mandatory';
            Description = 'HEI.01';
        }
        //BC Upgrade SHARMP16 Drink-IT fields begin>>
        // field(2014065;"Driver Mandatory";Boolean)
        // {
        //     CaptionML = ENU='Driver Code Mandatory',
        //                 FRA='Code Chauffeur obligatoire';
        //     Description = 'DITW16.00.00.40 #1002';
        // }
        // field(2014066;"Truck No. Mandatory";Boolean)
        // {
        //     CaptionML = ENU='Truck Code Mandatory',
        //                 FRA='Code Camion obligatoire';
        //     Description = 'DITW16.00.00.40 #1002';
        // }
        // field(2014080;Route;Code[20])
        // {
        //     Caption = 'Route';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     TableRelation = Route;
        // }
        // field(2014081;"Delivery Sequence";Integer)
        // {
        //     BlankZero = true;
        //     Caption = 'Delivery Sequence';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     MinValue = 0;
        // }
        // field(2029610;"Automatic Ship & Receive";Boolean)
        // {
        //     CaptionML = ENU='Automatic Ship & Receive Transfer Order',
        //                 FRA='Expéd. et Récept. auto sur Ordre de transfert';
        //     Description = 'FINXL7.00.001';
        // }
        //BC Upgrade SHARMP16 Drink-IT fields end<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=The receipt date must be greater or equal to the shipment date.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=The receipt date must be greater or equal to the shipment date.;FRA=La date de réception doit supérieure ou égale à la date d'expédition.;
    //Variable type has not been exported.
}

