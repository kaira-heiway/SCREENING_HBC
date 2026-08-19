page 90113 "API - Local Customer Sub-Types"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'customEndpoints';
    DataAccessIntent = ReadOnly;
    EntityName = 'localCustomerSubType';
    EntitySetName = 'localCustomerSubTypes';
    SourceTable = "Local Customer Sub-Type FND";
    Editable = false;
    ODataKeyFields = SystemId;
    DelayedInsert = true;

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
                field(code; Rec.Code)
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(globalCustSubTypeFND; Rec."Global Cust. Sub-Type")
                {
                    Caption = 'Global Cust. Sub-Type';
                }
                field(accountGroupFND; Rec."Account Group")
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