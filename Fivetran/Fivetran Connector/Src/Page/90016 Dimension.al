page 90016 "Dimension"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Dimension';
    EntitySetCaption = 'Dimensions';
    ODataKeyFields = SystemId;
    EntityName = 'dimension';
    EntitySetName = 'dimensions';
    SourceTable = Dimension;

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
                field(codeCaption; Rec."Code Caption")
                {
                    Caption = 'Code Caption';
                }
                field(consolidationCode; Rec."Consolidation Code")
                {
                    Caption = 'Consolidation Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(filterCaption; Rec."Filter Caption")
                {
                    Caption = 'Filter Caption';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                field(mapToICDimensionCode; Rec."Map-to IC Dimension Code")
                {
                    Caption = 'Map-to IC Dimension Code';
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
                field(mandatoryCustomerFND; Rec."Mandatory Customer FND")
                {
                    Caption = 'Mandatory Customer';
                }
            }
        }
    }
}
