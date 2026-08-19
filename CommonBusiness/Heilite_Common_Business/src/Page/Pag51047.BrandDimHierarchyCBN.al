page 51047 "Brand Dim Hierarchy CBN"
{
    PageType = List;
    SourceTable = "Brand Dim Hierarchy FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Dimension Level 1 Code"; Rec."Dimension Level 1 Code")
                {
                    ToolTip = 'Dimension Level 1 Code';
                }
                field("Dimension Level 1 Value Code"; Rec."Dimension Level 1 Value Code")
                {
                    ToolTip = 'Dimension Level 1 Value Code';
                }
                field("Dimension Level 2 Code"; Rec."Dimension Level 2 Code")
                {
                    ToolTip = 'Dimension Level 2 Code';
                }
                field("Dimension Level 2 Value Code"; Rec."Dimension Level 2 Value Code")
                {
                    ToolTip = 'Dimension Level 2 Value Code';
                }
                field("Dimension Level 3 Code"; Rec."Dimension Level 3 Code")
                {
                    ToolTip = 'Dimension Level 3 Code';
                }
                field("Dimension Level 3 Value Code"; Rec."Dimension Level 3 Value Code")
                {
                    ToolTip = 'Dimension Level 3 Value Code';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Item No.';
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
                    ToolTip = 'Update Hierarchy';

                    trigger OnAction();
                    var
                        FinancialUtils: Codeunit "Financial-Utils";
                    begin
                        FinancialUtils.Run();
                        CurrPage.Update();
                    end;
                }
            }
        }
    }
}

