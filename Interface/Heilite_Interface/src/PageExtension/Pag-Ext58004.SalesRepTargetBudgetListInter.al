namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

pageextension 58004 SalesRepTargetBudgetList_Inter extends "SalesRepTarget/BudgetCBN"
{
    // HEI.02 KS Interface IBM NASTAA02 23.08.2019 # KS Interface
    //   # Added Fields: "Actual Invoice Quantity", "Actual Cr. Memo Quantity", "Total Actual Value Invoice" and "Total Actual Value Cr. Memo"
    // Added code of trigger OnAfterGetRecord.
    layout
    {
        addafter("Currency Code")
        {
            field("Customer Price Group"; Rec."Customer Price Group INT")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Customer Price Group field.';
            }
            field("Actual Invoice Quantity"; Rec."Actual Invoice Quantity INT")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Actual Invoice Quantity field.';
            }
            field("Actual Cr. Memo Quantity"; Rec."Actual Cr. Memo Quantity INT")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Actual Cr. Memo Quantity field.';
            }
            field(ActualQuantity; ActualQuantity)
            {
                Caption = 'Quantity(Actual)';
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Quantity(Actual) field.';
            }

            field("Total Actual Value Invoice"; Rec."Total Actual Value Invoice INT")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Total Actual Value Invoice field.';
            }
            field("Total Actual Value Cr. Memo"; Rec."Total Actual Val Cr. Memo INT")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Total Actual Value Cr. Memo field.';
            }
            field(ActualValue; ActualValue)
            {
                Caption = 'Total value (Actual)';
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Total value (Actual) field.';
            }
        }

    }
    trigger OnAfterGetRecord();
    begin
        /*
        CALCFIELDS("Actual Invoice Quantity","Actual Cr. Memo Quantity","Total Actual Value Cr. Memo","Total Actual Value Invoice");
        ActualQuantity := "Actual Invoice Quantity" - "Actual Cr. Memo Quantity";
        ActualValue := "Total Actual Value Invoice" - "Total Actual Value Cr. Memo";
        */

        if STRLEN(FORMAT(Rec.Month)) = 1 then
            StringDate := '0' + FORMAT(Rec.Month) + '01' + FORMAT(Rec.Year) + 'D'
        else
            StringDate := FORMAT(Rec.Month) + '01' + FORMAT(Rec.Year) + 'D';

        EVALUATE(StartingDate, StringDate);

        FirstDate := CALCDATE('<-CM>', StartingDate);
        LastDate := CALCDATE('<CM>', StartingDate);
        SalesRepBudgetTarget.RESET();
        SalesRepBudgetTarget.SETRANGE(Year, Rec.Year);
        SalesRepBudgetTarget.SETRANGE("Sales Person Code", Rec."Sales Person Code");
        SalesRepBudgetTarget.SETRANGE("Item No", Rec."Item No");
        SalesRepBudgetTarget.SETRANGE(Month, Rec.Month);
        SalesRepBudgetTarget.SETRANGE("Date Filter", FirstDate, LastDate);
        if SalesRepBudgetTarget.FINDFIRST() then;
        SalesRepBudgetTarget.CALCFIELDS("Actual Cr. Memo Quantity INT", "Actual Invoice Quantity INT", "Total Actual Val Cr. Memo INT", "Total Actual Value Invoice INT");


        ActualQuantity := SalesRepBudgetTarget."Actual Invoice Quantity INT" - SalesRepBudgetTarget."Actual Cr. Memo Quantity INT";
        ActualValue := SalesRepBudgetTarget."Total Actual Value Invoice INT" - SalesRepBudgetTarget."Total Actual Val Cr. Memo INT";

    end;

    var
        ActualQuantity: Decimal;
        ActualValue: Decimal;
        StringDate: Text;
        StartingDate: Date;
        FirstDate: Date;
        LastDate: Date;
        SalesRepBudgetTarget: Record "Sales Rep Budget/Target FND";

}
