namespace fivetran.fivetran;

using Microsoft.Inventory.Item.Attribute;

page 90083 "Item Attribute Value API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Item Attribute Value API';
    DelayedInsert = true;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;
    EntityName = 'itemAttributeValue';
    EntitySetName = 'itemAttributeValues';
    PageType = API;
    SourceTable = "Item Attribute Value";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(attributeID; Rec."Attribute ID")
                {
                    Caption = 'Attribute ID';
                }
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field("value"; Rec."Value")
                {
                    Caption = 'Value';
                }
                field(numericValue; Rec."Numeric Value")
                {
                    Caption = 'Numeric Value';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(descriptionFND; Rec."Description FND")
                {
                    Caption = 'Description';
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
