namespace fivetran.fivetran;

using Microsoft.Inventory.Item.Attribute;

page 90084 "Item Attribute Value Mapp API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Item Attribute Value Mapping API';
    DelayedInsert = true;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;
    EntityName = 'itemAttributeValueMapping';
    EntitySetName = 'itemAttributeValueMapping';
    PageType = API;
    SourceTable = "Item Attribute Value Mapping";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(tableID; Rec."Table ID")
                {
                    Caption = 'Table ID';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(itemAttributeID; Rec."Item Attribute ID")
                {
                    Caption = 'Item Attribute ID';
                }
                field(itemAttributeValueID; Rec."Item Attribute Value ID")
                {
                    Caption = 'Item Attribute Value ID';
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
