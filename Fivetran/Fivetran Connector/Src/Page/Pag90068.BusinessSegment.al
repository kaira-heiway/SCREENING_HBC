namespace fivetran.fivetran;

page 90068 "Business Segment"
{
    APIGroup = 'customEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Business Segment API';
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityName = 'businessSegment';
    EntitySetName = 'businessSegments';
    PageType = API;
    SourceTable = "Business Segment FND";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
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
