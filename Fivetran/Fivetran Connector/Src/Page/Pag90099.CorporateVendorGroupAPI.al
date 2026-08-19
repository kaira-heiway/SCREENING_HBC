namespace J_Interface_QUA.J_Interface_QUA;

page 90099 "Corporate Vendor Group API"
{
    APIGroup = 'customEndpoints';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'corporateVendorGroupAPI';
    DelayedInsert = true;
    EntityName = 'CorporateVendorGroupapi';
    EntitySetName = 'CorporateVendorGroupapi';
    PageType = API;
    SourceTable = "Corporate Vendor Group FND";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;
    APIPublisher = 'fivetran';

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
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
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
