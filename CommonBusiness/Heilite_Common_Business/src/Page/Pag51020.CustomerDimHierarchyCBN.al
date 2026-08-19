page 51020 "Customer Dim Hierarchy CBN"
{
    PageType = List;
    SourceTable = "Customer Hierarchy FND";
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Dimension Level 1 Code"; Rec."Dimension Level 1 Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Dimension Level 1 Code field.';
                }
                field("Dimension Level 1 Value Code"; Rec."Dimension Level 1 Value Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Dimension Level 1 Value Code field.';
                }
                field("Dimension Level 2 Code"; Rec."Dimension Level 2 Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Dimension Level 2 Code field.';
                }
                field("Dimension Level 2 Value Code"; Rec."Dimension Level 2 Value Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Dimension Level 2 Value Code field.';
                }
                field("Dimension Level 3 Code"; Rec."Dimension Level 3 Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Dimension Level 3 Code field.';
                }
                field("Dimension Level 3 Value Code"; Rec."Dimension Level 3 Value Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Dimension Level 3 Value Code field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Actions")
            {
                Caption = 'Actions';
                Image = ChartOfAccounts;
                action("Update Hierarchy")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Update Hierarchy action.';

                    trigger OnAction();
                    var
                        FinancialUtils: Codeunit "Financial-Utils";
                    begin
                        FinancialUtils.RUN();
                        CurrPage.UPDATE();
                    end;
                }
            }
        }
    }
}

