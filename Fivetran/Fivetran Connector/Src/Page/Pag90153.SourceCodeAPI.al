page 90153 "Source Code API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Source Code';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Source Code';
    EntitySetCaption = 'Source Code';
    EntityName = 'SourceCode';
    EntitySetName = 'SourceCode';
    SourceTable = "Source Code";
    ODataKeyFields = SystemID;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(code; Rec.Code)
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(skipDimensionControl; Rec."Skip Dimension Control FND")
                {
                    Caption = 'Skip Dimension Control';
                }
            }
        }
    }
}
