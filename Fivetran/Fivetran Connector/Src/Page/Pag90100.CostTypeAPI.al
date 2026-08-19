namespace J_Interface_QUA.J_Interface_QUA;

using Microsoft.CostAccounting.Account;

page 90100 "Cost Type API"
{
    APIGroup = 'standardEndpoints';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Cost Type API';
    DelayedInsert = true;
    EntityName = 'CostTypeapi';
    EntitySetName = 'CostTypeapi';
    PageType = API;
    SourceTable = "Cost Type";
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
                field(addCurrencyBalanceAtDate; Rec."Add. Currency Balance at Date")
                {
                    Caption = 'Add. Currency Balance at Date';
                }
                field(addCurrencyNetChange; Rec."Add. Currency Net Change")
                {
                    Caption = 'Add. Currency Net Change';
                }
                field(balance; Rec.Balance)
                {
                    Caption = 'Balance';
                }
                field(balanceAtDate; Rec."Balance at Date")
                {
                    Caption = 'Balance at Date';
                }
                field(balanceToAllocate; Rec."Balance to Allocate")
                {
                    Caption = 'Balance to Allocate';
                }
                field(blankLine; Rec."Blank Line")
                {
                    Caption = 'Blank Line';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(budgetAmount; Rec."Budget Amount")
                {
                    Caption = 'Budget Amount';
                }
                field(budgetCreditAmount; Rec."Budget Credit Amount")
                {
                    Caption = 'Budget Credit Amount';
                }
                field(budgetDebitAmount; Rec."Budget Debit Amount")
                {
                    Caption = 'Budget Debit Amount';
                }
                field(budgetAtDate; Rec."Budget at Date")
                {
                    Caption = 'Budget at Date';
                }
                field(cogsVarItemCatCodeFND; Rec."COGS Var Item Cat Code FND")
                {
                    Caption = 'COGS Variable Item Category Code';
                }
                field(combineEntries; Rec."Combine Entries")
                {
                    Caption = 'Combine Entries';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(costAllocationKeyFND; Rec."Cost Allocation Key FND")
                {
                    Caption = 'Cost Allocation Key';
                }
                field(costCenterCode; Rec."Cost Center Code")
                {
                    Caption = 'Cost Center Code';
                }
                field(costClassification; Rec."Cost Classification")
                {
                    Caption = 'Cost Classification';
                }
                field(costObjectCode; Rec."Cost Object Code")
                {
                    Caption = 'Cost Object Code';
                }
                field(creditAmount; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                }
                field(debitAmount; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                }
                field(dimFilter2ValueCodeFND; Rec."Dim Filter 2 Value Code FND")
                {
                    Caption = 'Dimension Filter 2 Value Code';
                }
                field(dimensionFilter1CodeFND; Rec."Dimension Filter 1 Code FND")
                {
                    Caption = 'Dimension Filter 1 Code';
                }
                field(dimensionFilter2CodeFND; Rec."Dimension Filter 2 Code FND")
                {
                    Caption = 'Dimension Filter 2 Code';
                }
                field(fixedShare; Rec."Fixed Share")
                {
                    Caption = 'Fixed Share';
                }
                field(gLAccountRange; Rec."G/L Account Range")
                {
                    Caption = 'G/L Account Range';
                }
                field(indentation; Rec.Indentation)
                {
                    Caption = 'Indentation';
                }
                field(modifiedBy; Rec."Modified By")
                {
                    Caption = 'Modified By';
                }
                field(modifiedDate; Rec."Modified Date")
                {
                    Caption = 'Modified Date';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(netChange; Rec."Net Change")
                {
                    Caption = 'Net Change';
                }
                field(newPage; Rec."New Page")
                {
                    Caption = 'New Page';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(searchName; Rec."Search Name")
                {
                    Caption = 'Search Name';
                }
                field(sourceShippingCostFND; Rec."Source Shipping Cost FND")
                {
                    Caption = 'Source Shipping Cost from Value Entries';
                }
                field(totaling; Rec.Totaling)
                {
                    Caption = 'Totaling';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(dimFilter1ValueCodeFND; Rec."Dim Filter 1 Value Code FND")
                {
                    Caption = 'Code';
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
