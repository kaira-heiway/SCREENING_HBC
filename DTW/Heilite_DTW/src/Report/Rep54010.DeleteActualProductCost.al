report 54010 "Delete Actual Product Cost"
{
    // version HEI.01

    // HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 12.08.2019 # Actual Product Costing
    //   # New Report created to delete Actual Product Costs
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID is 50253
    // 2. Add ApplicationArea property in Report and Requestpage fields.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Delete Actual Product Cost';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Actual Product Cost DTW"; "Actual Product Cost DTW")
        {
            DataItemTableView = SORTING("Item No.", "Location Code", "Starting Date", "Ending Date") ORDER(Ascending);

            trigger OnAfterGetRecord();
            begin
                if "Ending Date" <= EndingDate then begin
                    DELETE();
                    ProdCostDeleted += 1;
                end;

                //Progress dialog bar
                Counter += 1;
                if (Counter >= NoOfRecProgress) //OR
                                                //(TIME - TimeProgress > 1000)
                then begin
                    NoOfProgresed := NoOfProgresed + Counter;
                    DialogProgress.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                    DialogProgress.UPDATE(2, ROUND(NoOfProgresed2 / NoOfRecords2 * 10000, 1));
                    Counter := 0;
                    TimeProgress := TIME;
                end;
            end;

            trigger OnPreDataItem();
            begin
                if EndingDate = 0D then
                    CurrReport.SKIP;

                NoOfRecords := COUNT;
                NoOfRecProgress := NoOfRecords div 100;
                Counter := 0;
                NoOfProgresed := 0;
                TimeProgress := TIME;
                NoOfRecords2 := COUNT;
                NoOfRecProgress2 := NoOfRecords2 div 100;
                Counter2 := 0;
                NoOfProgresed2 := 0;
                TimeProgress2 := TIME;
                NoOfRecords3 := COUNT;
                NoOfRecProgress3 := NoOfRecords3 div 100;
                Counter3 := 0;
                NoOfProgresed3 := 0;
                TimeProgress3 := TIME;

                DialogProgress.OPEN(ProgressLine1Msg + ProgressLine2Msg + ProgressLine3Msg);
            end;
        }
        dataitem("Actual Product Cost Struct DTW"; "Actual Product Cost Struct DTW")
        {
            DataItemTableView = SORTING("Item No.", "Location Code", "Starting Date", "Ending Date") ORDER(Ascending);

            trigger OnAfterGetRecord();
            var
                ActualProductCostStructure2: Record "Actual Product Cost Struct DTW";
            begin
                if "Ending Date" <= EndingDate then begin
                    ActualProductCostStructure2.SETRANGE("Parent Line No.", "Line No.");
                    if ActualProductCostStructure2.FINDSET then
                        repeat
                            ActualProductCostStructure2.DELETEALL;
                        until ActualProductCostStructure2.NEXT = 0;
                    DELETE;
                end;

                //Progress dialog bar
                Counter2 += 1;
                if (Counter2 >= NoOfRecProgress2) //OR
                                                  //(TIME - TimeProgress2 > 1000)
                then begin
                    NoOfProgresed2 := NoOfProgresed2 + Counter2;
                    DialogProgress.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                    DialogProgress.UPDATE(2, ROUND(NoOfProgresed2 / NoOfRecords2 * 10000, 1));
                    Counter2 := 0;
                    TimeProgress2 := TIME;
                end;
            end;
        }
        dataitem("Actual Cost Calculation DTW"; "Actual Cost Calculation DTW")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending);

            trigger OnAfterGetRecord();
            var
                ActualCostCalculation2: Record "Actual Cost Calculation DTW";
            begin
                if "Ending Date" <= EndingDate then
                    DELETE;

                //Progress dialog bar
                Counter3 += 1;
                if (Counter3 >= NoOfRecProgress3) //OR
                                                  //(TIME - TimeProgress3 > 1000)
                then begin
                    NoOfProgresed3 := NoOfProgresed3 + Counter3;
                    DialogProgress.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                    DialogProgress.UPDATE(2, ROUND(NoOfProgresed2 / NoOfRecords2 * 10000, 1));
                    DialogProgress.UPDATE(3, ROUND(NoOfProgresed3 / NoOfRecords3 * 10000, 1));
                    Counter3 := 0;
                    TimeProgress3 := TIME;
                end;
            end;

            trigger OnPostDataItem();
            begin
                DialogProgress.CLOSE;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Ending Date"; EndingDate)
                {
                    ApplicationArea = All;
                    trigger OnValidate();
                    begin
                        if EndingDate <> 0D then begin
                            AccountingPeriod.SETRANGE("Starting Date", CALCDATE('<-CM>', EndingDate));
                            if AccountingPeriod.FINDFIRST then begin
                                StartingDate := AccountingPeriod."Starting Date";
                                EndingDate := CALCDATE('<CM>', StartingDate);
                            end;
                        end;
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        MESSAGE(DeleteProdCostData, ProdCostDeleted);
    end;

    trigger OnPreReport();
    begin
        ProdCostDeleted := 0;
    end;

    var
        StartingDate: Date;
        EndingDate: Date;
        DeleteProdCostData: Label '%1 Product Cost lines were deleted.';
        ProdCostDeleted: Integer;
        AccountingPeriod: Record "Accounting Period";
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        DialogProgress: Dialog;
        ProgressLine1Msg: Label 'Deleting Actual Product Cost Lines: @1@@@@@@@@@@@ \';
        ProgressLine2Msg: Label 'Deleting Actual Product Cost Structure Lines: @2@@@@@@@@@@@';
        NoOfRecords2: Integer;
        NoOfRecProgress2: Integer;
        NoOfProgresed2: Integer;
        Counter2: Integer;
        TimeProgress2: Time;
        ProgressLine3Msg: Label 'Deleting Actual Product Cost Calculation Lines: @3@@@@@@@@@@@';
        DeleteProdCostLinesMsg: Label 'Are you sure you want to delete the Product Cost lines until %1 ?';
        EndingDateErr: Label 'Ending Date must be filled-in.';
        NoOfRecords3: Integer;
        NoOfRecProgress3: Integer;
        NoOfProgresed3: Integer;
        Counter3: Integer;
        TimeProgress3: Time;
}

