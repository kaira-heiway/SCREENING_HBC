page 90132 "Shipping Cost Allocation API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'customEndpoints';
    ApplicationArea = All;
    Caption = 'Shipping Cost Allocation';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Shipping Cost Allocation';
    EntitySetCaption = 'Shipping Cost Allocation';
    EntityName = 'shippingCostAllocation';
    EntitySetName = 'shippingCostAllocation';
    SourceTable = "Shipping Cost Allocation FND";
    ODataKeyFields = SystemID;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(destinationNo; Rec."Destination No.")
                {
                    Caption = 'Destination No.';
                }
                field(destinationType; Rec."Destination Type")
                {
                    Caption = 'Destination Type';
                }
                field(genOverheadsRPMSO; Rec."Gen. Overheads RPM SO")
                {
                    Caption = 'Gen. Overheads RPM SO';
                }
                field(genOverheadsRPMST; Rec."Gen. Overheads RPM ST")
                {
                    Caption = 'Gen. Overheads RPM ST';
                }
                field(generalOverheads; Rec."General Overheads")
                {
                    Caption = 'General Overheads';
                }
                field(generalOverheadsST; Rec."General Overheads ST")
                {
                    Caption = 'General Overheads ST';
                }
                field(initialOriginST; Rec."Initial Origin ST")
                {
                    Caption = 'Initial Origin ST';
                }
                field(internalTransferST; Rec."Internal Transfer ST")
                {
                    Caption = 'Internal Transfer ST';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(lotNo; Rec."Lot No.")
                {
                    Caption = 'Lot No.';
                }
                field(netWeightKg; Rec."Net Weight (Kg)")
                {
                    Caption = 'Net Weight (Kg)';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(noOfPallets; Rec."No. of Pallets")
                {
                    Caption = 'No. of Pallets';
                }
                field(onlyRPMTransportation; Rec."Only RPM Transportation")
                {
                    Caption = 'Only RPM Transportation';
                }
                field(periodGLCostDeliveryCust; Rec."Period G/L Cost Delivery Cust.")
                {
                    Caption = 'Period G/L Cost Delivery to Customer';
                }
                field(periodGLCostOwnFleet; Rec."Period G/L Cost Own Fleet")
                {
                    Caption = 'Period G/L Cost Own Fleet';
                }
                field(pickingFactor; Rec."Picking Factor")
                {
                    Caption = 'Picking Factor';
                }
                field(postedSourceDocumentNo; Rec."Posted Source Document No.")
                {
                    Caption = 'Posted Source Document No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(primaryAllocatedAmount; Rec."Primary Allocated Amount")
                {
                    Caption = 'Primary Allocated Amount';
                }
                field(quantityBaseUoM; Rec."Quantity (Base UoM)")
                {
                    Caption = 'Quantity (Base UoM)';
                }
                field(quantityHL; Rec."Quantity HL")
                {
                    Caption = 'Quantity HL';
                }
                field(route; Rec.Route)
                {
                    Caption = 'Route';
                }
                field(rpmSO; Rec."RPM SO")
                {
                    Caption = 'RPM SO';
                }
                field(rpmST; Rec."RPM ST")
                {
                    Caption = 'RPM ST';
                }
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                    Caption = 'Shipping Agent Code';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }
                field(warehouseHandling; Rec."Warehouse Handling")
                {
                    Caption = 'Warehouse Handling';
                }
                field(warehouseHandlingST; Rec."Warehouse Handling ST")
                {
                    Caption = 'Warehouse Handling ST';
                }
                field(warehouseOverheads; Rec."Warehouse Overheads")
                {
                    Caption = 'Warehouse Overheads';
                }
                field(warehouseOverheadsST; Rec."Warehouse Overheads ST")
                {
                    Caption = 'Warehouse Overheads ST';
                }
                field(whseHandlingRPMSO; Rec."Whse. Handling RPM SO")
                {
                    Caption = 'Whse. Handling RPM SO';
                }
                field(whseHandlingRPMST; Rec."Whse. Handling RPM ST")
                {
                    Caption = 'Whse. Handling RPM ST';
                }
                field(whseOverheadsRPMSO; Rec."Whse. Overheads RPM SO")
                {
                    Caption = 'Whse. Overheads RPM SO';
                }
                field(whseOverheadsRPMST; Rec."Whse. Overheads RPM ST")
                {
                    Caption = 'Whse. Overheads RPM ST';
                }
            }
        }
    }
}
