namespace fivetran.fivetran;

page 90106 "Customer Sub-Type API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'customEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityName = 'CustomerSubTypeAPI';
    EntitySetName = 'CustomerSubTypeAPI';
    SourceTable = "Customer Sub-Type FND";
    ODataKeyFields = SystemId;

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
                field(Code; Rec.Code)
                {
                    Caption = 'Code';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(AccountGroup; Rec."Account Group")
                {
                    Caption = 'Account Group';
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
