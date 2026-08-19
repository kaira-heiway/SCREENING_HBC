page 90034 Company
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'company';
    DelayedInsert = true;
    EntityName = 'rawCompany';
    EntitySetName = 'rawCompanies';
    PageType = API;
    SourceTable = Company;
    Editable = false;
    DataAccessIntent = ReadOnly;
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(businessProfileId; Rec."Business Profile Id")
                {
                    Caption = 'Business Profile Id';
                }
                field(displayName; Rec."Display Name")
                {
                    Caption = 'Display Name';
                }
                field(evaluationCompany; Rec."Evaluation Company")
                {
                    Caption = 'Evaluation Company';
                }
                field(id; Rec.Id)
                {
                    Caption = 'Id';
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
