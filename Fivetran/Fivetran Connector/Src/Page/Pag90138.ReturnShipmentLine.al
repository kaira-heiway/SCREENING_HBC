page 90138 "Return Shipment Line API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Return Shipment Line';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Return Shipment Line';
    EntitySetCaption = 'Return Shipment Line';
    EntityName = 'returnShipmentLine';
    EntitySetName = 'returnShipmentLine';
    SourceTable = "Return Shipment Line";
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
                field(buyFromVendorNo; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(returnOrderLineNo; Rec."Return Order Line No.")
                {
                    Caption = 'Return Order Line No.';
                }
                field(returnOrderNo; Rec."Return Order No.")
                {
                    Caption = 'Return Order No.';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                }
            }
        }
    }
}
