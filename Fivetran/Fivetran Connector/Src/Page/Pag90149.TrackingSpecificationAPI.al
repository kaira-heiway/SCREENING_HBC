page 90149 "Tracking Specification API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Tracking Specification';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Tracking Specification';
    EntitySetCaption = 'Tracking Specification';
    EntityName = 'trackingSpecification';
    EntitySetName = 'trackingSpecification';
    SourceTable = "Tracking Specification";
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
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(creationDate; Rec."Creation Date")
                {
                    Caption = 'Creation Date';
                }
                field(sourceType; Rec."Source Type")
                {
                    Caption = 'Source Type';
                }
                field(sourceSubtype; Rec."Source Subtype")
                {
                    Caption = 'Source Subtype';
                }
                field(sourceID; Rec."Source ID")
                {
                    Caption = 'Source ID';
                }
                field(sourceBatchName; Rec."Source Batch Name")
                {
                    Caption = 'Source Batch Name';
                }
                field(sourceProdOrderLine; Rec."Source Prod. Order Line")
                {
                    Caption = 'Source Prod. Order Line';
                }
                field(sourceRefNo; Rec."Source Ref. No.")
                {
                    Caption = 'Source Ref. No.';
                }
                field(itemLedgerEntryNo; Rec."Item Ledger Entry No.")
                {
                    Caption = 'Item Ledger Entry No.';
                }
                field(transferItemEntryNo; Rec."Transfer Item Entry No.")
                {
                    Caption = 'Transfer Item Entry No.';
                }
                field(serialNo; Rec."Serial No.")
                {
                    Caption = 'Serial No.';
                }
                field(positive; Rec.Positive)
                {
                    Caption = 'Positive';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field(applToItemEntry; Rec."Appl.-to Item Entry")
                {
                    Caption = 'Appl.-to Item Entry';
                }
                field(warrantyDate; Rec."Warranty Date")
                {
                    Caption = 'Warranty Date';
                }
                field(expirationDate; Rec."Expiration Date")
                {
                    Caption = 'Expiration Date';
                }
                field(qtyToHandleBase; Rec."Qty. to Handle (Base)")
                {
                    Caption = 'Qty. to Handle (Base)';
                }
                field(qtyToInvoiceBase; Rec."Qty. to Invoice (Base)")
                {
                    Caption = 'Qty. to Invoice (Base)';
                }
                field(quantityHandledBase; Rec."Quantity Handled (Base)")
                {
                    Caption = 'Quantity Handled (Base)';
                }
                field(quantityInvoicedBase; Rec."Quantity Invoiced (Base)")
                {
                    Caption = 'Quantity Invoiced (Base)';
                }
                field(qtyToHandle; Rec."Qty. to Handle")
                {
                    Caption = 'Qty. to Handle';
                }
                field(qtyToInvoice; Rec."Qty. to Invoice")
                {
                    Caption = 'Qty. to Invoice';
                }
                field(bufferStatus; Rec."Buffer Status")
                {
                    Caption = 'Buffer Status';
                }
                field(bufferStatus2; Rec."Buffer Status2")
                {
                    Caption = 'Buffer Status2';
                }
                field(bufferValue1; Rec."Buffer Value1")
                {
                    Caption = 'Buffer Value1';
                }
                field(bufferValue2; Rec."Buffer Value2")
                {
                    Caption = 'Buffer Value2';
                }
                field(bufferValue3; Rec."Buffer Value3")
                {
                    Caption = 'Buffer Value3';
                }
                field(bufferValue4; Rec."Buffer Value4")
                {
                    Caption = 'Buffer Value4';
                }
                field(bufferValue5; Rec."Buffer Value5")
                {
                    Caption = 'Buffer Value5';
                }
                field(newSerialNo; Rec."New Serial No.")
                {
                    Caption = 'New Serial No.';
                }
                field(newLotNo; Rec."New Lot No.")
                {
                    Caption = 'New Lot No.';
                }
                field(prohibitCancellation; Rec."Prohibit Cancellation")
                {
                    Caption = 'Prohibit Cancellation';
                }
                field(lotNo; Rec."Lot No.")
                {
                    Caption = 'Lot No.';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field(applFromItemEntry; Rec."Appl.-from Item Entry")
                {
                    Caption = 'Appl.-from Item Entry';
                }
                field(correction; Rec.Correction)
                {
                    Caption = 'Correction';
                }
                field(newExpirationDate; Rec."New Expiration Date")
                {
                    Caption = 'New Expiration Date';
                }
                field(quantityActualHandledBase; Rec."Quantity actual Handled (Base)")
                {
                    Caption = 'Quantity actual Handled (Base)';
                }
                field(zoneCode; Rec."Zone Code FND")
                {
                    Caption = 'Zone Code';
                }
                field(kgHL; Rec."KG/HL FND")
                {
                    Caption = 'KG/HL';
                }
                field(weightOfExtract; Rec."Weight of Extract FND")
                {
                    Caption = 'Weight of Extract';
                }
                field(referenceNo; Rec."Reference No. FND")
                {
                    Caption = 'Reference No.';
                }
            }
        }
    }
}
