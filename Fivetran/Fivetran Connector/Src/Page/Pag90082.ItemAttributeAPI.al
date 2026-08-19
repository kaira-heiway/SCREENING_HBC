namespace fivetran.fivetran;

using Microsoft.Inventory.Item.Attribute;

page 90082 "Item Attribute API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Item Attribute API';
    DelayedInsert = true;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;
    EntityName = 'itemAttribute';
    EntitySetName = 'itemAttributes';
    PageType = API;
    SourceTable = "Item Attribute";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                }
                field(valueFormatFND; Rec."Value Format FND")
                {
                    Caption = 'Value Format';
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
