namespace fivetran.fivetran;

page 90105 "Customer Type API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'customEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityName = 'CustomerTypeAPI';
    EntitySetName = 'CustomerTypeAPI';
    SourceTable = "Customer Type FND";
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
