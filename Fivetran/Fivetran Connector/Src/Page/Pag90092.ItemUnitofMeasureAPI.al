namespace J_Interface_QUA.J_Interface_QUA;

using Microsoft.Inventory.Item;

page 90092 "Item Unit of Measure API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    DataAccessIntent = ReadOnly;
    Editable = false;
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Item Unit Of Measure API';
    DelayedInsert = true;
    EntityName = 'entityName';
    EntitySetName = 'entitySetName';
    PageType = API;
    ODataKeyFields = SystemId;
    SourceTable = "Item Unit of Measure";

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
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field(length; Rec.Length)
                {
                    Caption = 'Length';
                }
                field(width; Rec.Width)
                {
                    Caption = 'Width';
                }
                field(height; Rec.Height)
                {
                    Caption = 'Height';
                }
                field(cubage; Rec.Cubage)
                {
                    Caption = 'Cubage';
                }
                field(weight; Rec.Weight)
                {
                    Caption = 'Weight';
                }
                field(unitOfDimensionFND; Rec."Unit of Dimension FND")
                {
                    Caption = 'Unit of Dimension';
                }
                field(unitOfWeightFND; Rec."Unit of Weight FND")
                {
                    Caption = 'Unit of Weight';
                }
                field(lastUpdateFND; Rec."Last Update FND")
                {
                    Caption = 'Last Update';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
