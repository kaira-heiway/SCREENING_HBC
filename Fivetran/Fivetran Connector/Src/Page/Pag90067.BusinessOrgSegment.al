namespace fivetran.fivetran;

page 90067 "Business Org Segment"
{
    APIGroup = 'customEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Business Organizational Segment API';
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityName = 'businessOrganizationalSegment';
    EntitySetName = 'businessOrganizationalSegments';
    PageType = API;
    SourceTable = "Business Org Segment FND";

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
