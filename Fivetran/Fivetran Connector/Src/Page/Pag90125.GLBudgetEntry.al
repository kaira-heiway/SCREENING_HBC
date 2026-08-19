page 90125 "G/L Budget Entry"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'G/L Budget Entry';
    EntitySetCaption = 'G/L Budget Entries';
    ODataKeyFields = SystemID;
    EntityName = 'glBudgetEntry';
    EntitySetName = 'glBudgetEntries';
    SourceTable = "G/L Budget Entry";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(gLAccountNo; Rec."G/L Account No.")
                {
                    Caption = 'G/L Account No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
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
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(budgetName; Rec."Budget Name")
                {
                    Caption = 'Budget Name';
                }
                field(businessUnitCode; Rec."Business Unit Code")
                {
                    Caption = 'Business Unit Code';
                }
                field("date"; Rec."Date")
                {
                    Caption = 'Date';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
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