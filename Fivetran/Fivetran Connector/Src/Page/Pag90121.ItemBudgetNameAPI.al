namespace fivetran.fivetran;

using Microsoft.Inventory.Analysis;

page 90121 "Item Budget Name API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Item Budget Name API';
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityName = 'itemBudgetName';
    EntitySetName = 'itemBudgetNames';
    PageType = API;
    SourceTable = "Item Budget Name";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(analysisArea; Rec."Analysis Area")
                {
                    Caption = 'Analysis Area';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
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
                field(dataVersionReferenceFND; Rec."Data Version Reference FND")
                {
                    Caption = 'Data Version Reference FND';
                }
                field(automCpyBdgtDim1FrmFND; Rec."Autom. cpy Bdgt. Dim.1 frm FND")
                {
                    Caption = 'Automatice Copy Budget Dimension 1 from';
                }
                field(automCpyBdgtDim2FrmFND; Rec."Autom. cpy Bdgt. Dim.2 frm FND")
                {
                    Caption = 'Automatice Copy Budget Dimension 2 from';
                }
                field(automCpyBdgtDim3FrmFND; Rec."Autom. cpy Bdgt. Dim.3 frm FND")
                {
                    Caption = 'Automatice Copy Budget Dimension 3 from';
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
