page 58127 "KS SalesRep Target/Budget Exp"
{
    // BC UPGRADE PATELP08 >>
    //    # old object id - 50343
    //    # new object id - 58127
    //    # Added application area and usage category
    //    # in fields added Rec. before field name as per new syntax change in BC upgrade
    // BC UPGRADE PATELP08 <<

    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Rep Budget/Target FND";

    // BC UPGRADE PATELP08 >> added application area and usage category
    ApplicationArea = All;
    UsageCategory = Lists;
    // BC UPGRADE PATELP08 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // BC UPGRADE PATELP08 >>  added Rec. before field name
                field(Budget; Rec.Budget)
                {
                }
                field(Year; Rec.Year)
                {
                }
                field(Month; Rec.Month)
                {
                }
                field(ItemCode; Rec."Item No")
                {
                }
                field(Resource; Rec."Sales Person Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(ActualQuantity; ActualQuantity)
                {
                    Caption = 'Quantity(Actual)';
                }
                field(ActualValue; ActualValue)
                {
                    Caption = 'Total value (Actual)';
                }
                field("ConvertDate(""Last Date Modified"")"; ConvertDate(Rec."Last Date Modified"))
                {
                }
                field(CustomerCode; Rec."Customer Code")
                {
                }
                field(TotalAmount; Rec."Total Value (budget)")
                {
                }
                field(Day; Rec.Day)
                {
                }
                field(ItemAssortment; DefaultDimension."Dimension Value Code")
                {
                }
                field(Last_Date_Modified; Rec."Last Date Modified")
                {
                }
                // BC UPGRADE PATELP08 <<
            }
        }
    }

    actions
    {
    }

    // BC UPGRADE PATELP08 >> Added Rec. before some fields
    trigger OnAfterGetRecord();
    var
        SalesRepBudgetTarget: Record "Sales Rep Budget/Target FND";
        StartingDate: Date;
        endingDate: Date;
    begin
        //CALCFIELDS("Actual Invoice Quantity","Actual Cr. Memo Quantity","Total Actual Value Cr. Memo","Total Actual Value Invoice");

        if STRLEN(FORMAT(Rec.Month)) = 1 then
            StringDate := '0' + FORMAT(Rec.Month) + '01' + FORMAT(Rec.Year) + 'D'
        else
            StringDate := FORMAT(Rec.Month) + '01' + FORMAT(Rec.Year) + 'D';

        EVALUATE(StartingDate, StringDate);

        FirstDate := CALCDATE('<-CM>', StartingDate);
        LastDate := CALCDATE('<CM>', StartingDate);
        SalesRepBudgetTarget.RESET;
        SalesRepBudgetTarget.SETRANGE(Year, Rec.Year);
        SalesRepBudgetTarget.SETRANGE("Sales Person Code", Rec."Sales Person Code");
        SalesRepBudgetTarget.SETRANGE("Item No", Rec."Item No");
        SalesRepBudgetTarget.SETRANGE(Month, Rec.Month);
        SalesRepBudgetTarget.SETRANGE("Date Filter", FirstDate, LastDate);
        if SalesRepBudgetTarget.FINDFIRST then;
        SalesRepBudgetTarget.CALCFIELDS("Actual Cr. Memo Quantity INT", "Actual Invoice Quantity INT", "Total Actual Val Cr. Memo INT", "Total Actual Value Invoice INT");


        ActualQuantity := SalesRepBudgetTarget."Actual Invoice Quantity INT" - SalesRepBudgetTarget."Actual Cr. Memo Quantity INT";
        ActualValue := SalesRepBudgetTarget."Total Actual Value Invoice INT" - SalesRepBudgetTarget."Total Actual Val Cr. Memo INT";

        if DefaultDimension.GET(27, Rec."Item No", GeneralLedgerSetup."Brand Dimension Code FND") then;
    end;
    // BC UPGRADE PATELP08 <<
    trigger OnInit();
    begin
        GeneralLedgerSetup.GET();
    end;

    trigger OnOpenPage();
    begin
        //SETRANGE(Year,DATE2DMY(TODAY,3));
    end;

    var
        ActualQuantity: Decimal;
        ActualValue: Decimal;
        DefaultDimension: Record "Default Dimension";
        GeneralLedgerSetup: Record "General Ledger Setup";
        StringDate: Text;
        FirstDate: Date;
        LastDate: Date;

    local procedure ConvertDate(SysModified: Date): Text;
    var
        ReturnDate: Text;
    begin
        ReturnDate := FORMAT(SysModified, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:' + '00:00.000+00:00';
        exit(ReturnDate);
    end;
}

