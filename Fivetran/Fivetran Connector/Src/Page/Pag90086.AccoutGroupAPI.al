namespace J_Heilite_Foundation_QUA.J_Heilite_Foundation_QUA;

page 90086 "Accout Group API"
{
    APIGroup = 'customEndpoints';
    APIPublisher = 'fivetran';
    DataAccessIntent = ReadOnly;
    Editable = false;
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Account Group API';
    DelayedInsert = true;
    EntityName = 'AccountGroup';
    EntitySetName = 'AccountGroup';
    PageType = API;
    SourceTable = "Account Group FND";
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
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(tradingEndDateEnable; Rec."Trading End Date Enable")
                {
                    Caption = 'Trading End Date Enable';
                }
                field(contractTypeEditable; Rec."Contract type Editable")
                {
                    Caption = 'Contract type Editable';
                }
                field(availForSalesReturnOrder; Rec."Avail. for Sales/Return Order")
                {
                    Caption = 'Avail. for Sales/Return Order';
                }
                field(customerClassification; Rec."Customer Classification")
                {
                    Caption = 'Customer Classification';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
            }
        }
    }
}
