namespace fivetran.fivetran;

page 90076 "Gate Entry Line API"
{
    APIGroup = 'customEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Gate Entry Line API';
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityName = 'gateEntryLine';
    EntitySetName = 'gateEntryLines';
    PageType = API;
    SourceTable = "Gate Entry Line FND";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(gateEntryDocumentNo; Rec."Gate Entry Document No.")
                {
                    Caption = 'Gate Entry Document No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(unitOfMeasureCode; Rec."Unit Of Measure Code")
                {
                    Caption = 'Unit Of Measure Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(quantityOnArrival; Rec."Quantity on Arrival")
                {
                    Caption = 'Quantity on Arrival';
                }
                field(quantityOnDeparture; Rec."Quantity on Departure")
                {
                    Caption = 'Quantity on Departure';
                }
                field(postedQuantityInbound; Rec."Posted Quantity Inbound")
                {
                    Caption = 'Posted Quantity Inbound';
                }
                field(postedQuantityOutbound; Rec."Posted Quantity Outbound")
                {
                    Caption = 'Posted Quantity Outbound';
                }
                field(referenceDocument; Rec."Reference Document")
                {
                    Caption = 'Reference Document';
                }
                field(referenceNo; Rec."Reference No.")
                {
                    Caption = 'Reference No.';
                }
                field(quantityShipment; Rec."Quantity Shipment")
                {
                    Caption = 'Quantity Shipment';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(zoneCode; Rec."Zone Code")
                {
                    Caption = 'Zone Code';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
