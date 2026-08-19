page 90128 "Warehouse Entry API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Warehouse Entry';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Warehouse Entry';
    EntitySetCaption = 'Warehouse Entry';
    EntityName = 'warehouseEntry';
    EntitySetName = 'warehouseEntry';
    SourceTable = "Warehouse Entry";
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
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(entryType; Rec."Entry Type")
                {
                    Caption = 'Entry Type';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(expirationDate; Rec."Expiration Date")
                {
                    Caption = 'Expiration Date';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(lotNo; Rec."Lot No.")
                {
                    Caption = 'Lot No.';
                }
                field(qtyBase; Rec."Qty. (Base)")
                {
                    Caption = 'Qty.';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(referenceNo; Rec."Reference No.")
                {
                    Caption = 'Reference No.';
                }
                field(registeringDate; Rec."Registering Date")
                {
                    Caption = 'Registering Date';
                }
                field(sourceDocument; Rec."Source Document")
                {
                    Caption = 'Source Document';
                }
                field(sourceLineNo; Rec."Source Line No.")
                {
                    Caption = 'Source Line No.';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(whseDocumentNo; Rec."Whse. Document No.")
                {
                    Caption = 'Whse. Document No.';
                }
                field(zoneCode; Rec."Zone Code")
                {
                    Caption = 'Zone Code';
                }
            }
        }
    }
}
