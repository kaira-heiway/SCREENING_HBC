page 90126 "G/L Budget Name"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'G/L Budget Name';
    EntitySetCaption = 'G/L Budget Names';
    ODataKeyFields = SystemID;
    EntityName = 'glBudgetName';
    EntitySetName = 'glBudgetNames';
    SourceTable = "G/L Budget Name";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(dataVersionRefrenceFND; Rec."Data Version Refrence FND")
                {
                    Caption = 'Data Version Refrence FND';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(budgetDimension1Code; Rec."Budget Dimension 1 Code")
                {
                    Caption = 'Budget Dimension 1 Code';
                }
                field(budgetDimension2Code; Rec."Budget Dimension 2 Code")
                {
                    Caption = 'Budget Dimension 2 Code';
                }
                field(budgetDimension3Code; Rec."Budget Dimension 3 Code")
                {
                    Caption = 'Budget Dimension 3 Code';
                }
                field(budgetDimension4Code; Rec."Budget Dimension 4 Code")
                {
                    Caption = 'Budget Dimension 4 Code';
                }
                field(chkWhenPstgPurchDocFND; Rec."Chk. When Pstg. Purch Doc FND")
                {
                    Caption = 'Check When Posting Purch Doc';
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