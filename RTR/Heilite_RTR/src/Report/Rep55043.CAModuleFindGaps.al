report 55043 "CA Module - Find Gaps"
{
    // HEI.01 CHG2061485 IBM BULIMC01 16/05/2020 #new report created to find the gaps between GL Amount and Cost Journal amount
    //Bc Upgrade YADAVM09 old id is 50414.

    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportsLayout\CA Module - Find Gaps.rdl';

    Caption = 'GL - Cost Journal Gaps';
    ApplicationArea = All;

    dataset
    {
        dataitem("Cost Type"; "Cost Type")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("G/L Account Range" = FILTER(<> ''));
            RequestFilterFields = "No.";
            column(No_CostType; "Cost Type"."No.")
            {
                IncludeCaption = true;
            }
            column(Name_CostType; "Cost Type".Name)
            {
                IncludeCaption = true;
            }
            column(GLAccountRange_CostType; "Cost Type"."G/L Account Range")
            {
                IncludeCaption = true;
            }
            column(DimensionFilter1Code_CostType; "Cost Type"."Dimension Filter 1 Code FND")
            {
                IncludeCaption = true;
            }
            column(DimensionFilter1ValueCode_CostType; "Cost Type"."Dim Filter 1 Value Code FND")
            {
                IncludeCaption = true;
            }
            column(GlEntry_TotalAmount; ROUND(GLAmount, 0.01))
            {
            }
            column(CostJournal_TotalAmount; ROUND(CAAmount, 0.01))
            {
            }

            trigger OnAfterGetRecord();
            var
                CostJnllLine: Record "Cost Journal Line";
            begin
                if "Cost Type"."G/L Account Range" = '' then
                    CurrReport.SKIP;

                CLEAR(GLAmount);
                CLEAR(CAAmount);
                GLAcc.SETFILTER("No.", "G/L Account Range");
                GLAcc.SETRANGE("Acc Type FND", GLAcc."Acc Type FND"::Expense);
                if GLAcc.FINDSET then
                    repeat
                        GLEntry.SETCURRENTKEY("G/L Account No.", "Posting Date");
                        GLEntry.SETRANGE("G/L Account No.", GLAcc."No.");
                        GLEntry.SETRANGE("Posting Date", StartingDate, EndingDate);
                        if GLEntry.FINDFIRST then
                            repeat
                                SkipGL := false;
                                if "Dimension Filter 1 Code FND" <> '' then begin
                                    CLEAR(DimSetEntry);
                                    DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                    DimSetEntry.SETRANGE("Dimension Code", "Dimension Filter 1 Code FND");
                                    DimSetEntry.SETFILTER("Dimension Value Code", "Dim Filter 1 Value Code FND");
                                    if not DimSetEntry.FINDFIRST then
                                        SkipGL := true;
                                end;
                                if "Dimension Filter 2 Code FND" <> '' then begin
                                    CLEAR(DimSetEntry);
                                    DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                                    DimSetEntry.SETRANGE("Dimension Code", "Dimension Filter 2 Code FND");
                                    DimSetEntry.SETFILTER("Dimension Value Code", "Dim Filter 2 Value Code FND");
                                    if not DimSetEntry.FINDFIRST then
                                        SkipGL := true;
                                end;

                                if not SkipGL then begin
                                    GLAmount += GLEntry.Amount;
                                end;
                            until GLEntry.NEXT = 0;
                    until GLAcc.NEXT = 0;

                CostJnlLine.RESET;
                CostJnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name");
                CostJnlLine.SETRANGE("Journal Template Name", CostJournalLine."Journal Template Name");
                CostJnlLine.SETRANGE("Journal Batch Name", CostJournalLine."Journal Batch Name");
                CostJnlLine.SETRANGE("Cost Type No.", "Cost Type"."No.");
                if CostJnlLine.FINDFIRST then
                    repeat
                        CAAmount += CostJnlLine.Amount;
                    until CostJnlLine.NEXT = 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = false;

        layout
        {
            area(content)
            {
                field(StartingDate; StartingDate)
                {
                    Caption = 'Starting Date';
                    ApplicationArea = All;
                }
                field(EndingDate; EndingDate)
                {
                    Caption = 'Ending Date';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        GLAmount = 'G/L Entry Amount'; CostJournalAmount = 'Cost Journal Amount';
    }

    trigger OnPreReport();
    begin
        if (StartingDate = 0D) or (EndingDate = 0D) then
            ERROR(Text001);
    end;

    var
        GLAcc: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        CostJournalLine: Record "Cost Journal Line";
        GLAmount: Decimal;
        CAAmount: Decimal;
        DimSetEntry: Record "Dimension Set Entry";
        SkipGL: Boolean;
        CostJnlLine: Record "Cost Journal Line";
        StartingDate: Date;
        EndingDate: Date;
        SkuNo: Code[20];
        CustNo: Code[20];
        Text001: Label 'Starting date and ending date must not be blank!';

    procedure SetDocNo(ToCostJournalLine: Record "Cost Journal Line");
    begin
        CostJournalLine := ToCostJournalLine;
    end;
}

