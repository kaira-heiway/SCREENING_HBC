page 51077 "SalesRepTarget/BudgetCBN"
{
    // HEI.02 KS Interface IBM NASTAA02 23.08.2019 # KS Interface
    //   # Added Fields: "Actual Invoice Quantity", "Actual Cr. Memo Quantity", "Total Actual Value Invoice" and "Total Actual Value Cr. Memo"

    // BC Upgrade SHUKLP03 >>
    // HEI.02 => fields  "Actual Invoice Quantity", "Actual Cr. Memo Quantity", "Total Actual Value Invoice" , "Total Actual Value Cr. Memo",ActualQuantity And ActualValue shared with Sakshi.

    // BC Upgrade SHUKLP03 <<

    DelayedInsert = true;
    PageType = List;
    SourceTable = "Sales Rep Budget/Target FND";
    ApplicationArea = ALL;  // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists;  // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Budget; Rec.Budget)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Budget field.';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Year field.';
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Month field.';
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Day field.';
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Customer Code field.';
                }
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Sales Person Code field.';
                }
                field("Sales Person Name"; Rec."Sales Person Name")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Sales Person Name field.';
                }
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Item No field.';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Item Description field.';
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Unit Of Measure Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Total Value (budget)"; Rec."Total Value (budget)")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Total Value (budget) field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
            }
        }
    }

    actions
    {
    }
    // BC Upgrade SHUKLP03 >> Interface fields are used  shared with Sakshi.
    // trigger OnAfterGetRecord();
    // begin
    //     /*
    //     CALCFIELDS("Actual Invoice Quantity","Actual Cr. Memo Quantity","Total Actual Value Cr. Memo","Total Actual Value Invoice");
    //     ActualQuantity := "Actual Invoice Quantity" - "Actual Cr. Memo Quantity";
    //     ActualValue := "Total Actual Value Invoice" - "Total Actual Value Cr. Memo";
    //     */

    //     if STRLEN(FORMAT(Rec.Month)) = 1 then
    //         StringDate := '0' + FORMAT(Rec.Month) + '01' + FORMAT(Rec.Year) + 'D'
    //     else
    //         StringDate := FORMAT(Rec.Month) + '01' + FORMAT(Rec.Year) + 'D';

    //     EVALUATE(StartingDate, StringDate);

    //     FirstDate := CALCDATE('<-CM>', StartingDate);
    //     LastDate := CALCDATE('<CM>', StartingDate);
    //     SalesRepBudgetTarget.RESET;
    //     SalesRepBudgetTarget.SETRANGE(Year, Rec.Year);
    //     SalesRepBudgetTarget.SETRANGE("Sales Person Code", Rec."Sales Person Code");
    //     SalesRepBudgetTarget.SETRANGE("Item No", Rec."Item No");
    //     SalesRepBudgetTarget.SETRANGE(Month, Rec.Month);
    //     SalesRepBudgetTarget.SETRANGE("Date Filter", FirstDate, LastDate);
    //     if SalesRepBudgetTarget.FINDFIRST then;
    //     SalesRepBudgetTarget.CALCFIELDS("Actual Cr. Memo Quantity", "Actual Invoice Quantity", "Total Actual Value Cr. Memo", "Total Actual Value Invoice");


    //     ActualQuantity := SalesRepBudgetTarget."Actual Invoice Quantity" - SalesRepBudgetTarget."Actual Cr. Memo Quantity";
    //     ActualValue := SalesRepBudgetTarget."Total Actual Value Invoice" - SalesRepBudgetTarget."Total Actual Value Cr. Memo";

    // end;
    // BC Upgrade SHUKLP03 << Interface fields are used  shared with Sakshi.
    var
        SalesRepBudgetTarget: Record "Sales Rep Budget/Target FND";
        FirstDate: Date;
        LastDate: Date;
        StartingDate: Date;
        ActualQuantity: Decimal;
        ActualValue: Decimal;
        StringDate: Text;
}

