page 90019 "Gen. Product Posting Group"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'generalProductPostingGroup';
    EntitySetCaption = 'generalProductPostingGroups';
    ODataKeyFields = SystemId;
    EntityName = 'generalProductPostingGroup';
    EntitySetName = 'generalProductPostingGroups';
    SourceTable = "Gen. Product Posting Group";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(autoInsertDefault; Rec."Auto Insert Default")
                {
                    Caption = 'Auto Insert Default';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(defVATProdPostingGroup; Rec."Def. VAT Prod. Posting Group")
                {
                    Caption = 'Def. VAT Prod. Posting Group';
                }
                field(description; Rec.Description)
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
                field(includeTimbreFND; Rec."Include Timbre FND")
                {
                    Caption = 'Include Timbre';
                }

            }
        }
    }
}
