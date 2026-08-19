page 90136 "Sales Line Archive API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Sales Line Archive';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Sales Line Archive';
    EntitySetCaption = 'Sales Line Archive';
    EntityName = 'salesLineArchive';
    EntitySetName = 'salesLineArchive';
    SourceTable = "Sales Line Archive";
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
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(docNoOccurrence; Rec."Doc. No. Occurrence")
                {
                    Caption = 'Doc. No. Occurrence';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
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
                field(plannedDeliveryDate; Rec."Planned Delivery Date")
                {
                    Caption = 'Planned Delivery Date';
                }
                field(postingGroup; Rec."Posting Group")
                {
                    Caption = 'Posting Group';
                }
                field(qtyInvoicedBase; Rec."Qty. Invoiced (Base)")
                {
                    Caption = 'Qty. Invoiced (Base)';
                }
                field(qtyShippedBase; Rec."Qty. Shipped (Base)")
                {
                    Caption = 'Qty. Shipped (Base)';
                }
                field(qtyShippedNotInvoiced; Rec."Qty. Shipped Not Invoiced")
                {
                    Caption = 'Qty. Shipped Not Invoiced';
                }
                field(qtyToInvoice; Rec."Qty. to Invoice")
                {
                    Caption = 'Qty. to Invoice';
                }
                field(qtyToShip; Rec."Qty. to Ship")
                {
                    Caption = 'Qty. to Ship';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(quantityDiscCode; Rec."Quantity Disc. Code")
                {
                    Caption = 'Quantity Disc. Code';
                }
                field(returnQtyToReceive; Rec."Return Qty. to Receive")
                {
                    Caption = 'Return Qty. to Receive';
                }
                field(returnQtyToReceiveBase; Rec."Return Qty. to Receive (Base)")
                {
                    Caption = 'Return Qty. to Receive (Base)';
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                    Caption = 'Return Reason Code';
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(versionNo; Rec."Version No.")
                {
                    Caption = 'Version No.';
                }
            }
        }
    }
}
