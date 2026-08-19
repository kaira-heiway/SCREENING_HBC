page 90024 "Item Variant"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Item Variant';
    EntitySetCaption = 'Item Variant';
    ODataKeyFields = SystemId;
    EntityName = 'itemVariant';
    EntitySetName = 'itemVariants';
    SourceTable = "Item Variant";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(itemId; Rec."Item Id")
                {
                    Caption = 'Item Id';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(purchasingBlocked; Rec."Purchasing Blocked")
                {
                    Caption = 'Purchasing Blocked';
                }
                field(salesBlocked; Rec."Sales Blocked")
                {
                    Caption = 'Sales Blocked';
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
