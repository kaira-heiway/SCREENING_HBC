report 54009 "Archive Actual Product Cost"
{
    // version HEI.01

    // HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 19.04.2019 # Actual Product Costing
    //   # New Report created to insert Actual Product Cost Structure
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID is 50251
    // 2. Add ApplicationArea property in Report and Requestpage fields.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Archive Actual Product Cost';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Actual Product Cost DTW"; "Actual Product Cost DTW")
        {
            DataItemTableView = SORTING("Item No.", "Location Code", "Starting Date", "Ending Date") ORDER(Ascending) WHERE(Archived = FILTER(false));

            trigger OnAfterGetRecord();
            begin
                //IF ("Starting Date" >= StartingDate) AND ("Starting Date" <= EndingDate) THEN BEGIN
                if "Ending Date" <= EndingDate then begin
                    Archived := true;
                    MODIFY;
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

                DialogProgress.OPEN(ProgressLine1Msg + ProgressLine2Msg);
            end;
        }
        dataitem("Actual Product Cost Struct DTW"; "Actual Product Cost Struct DTW")
        {
            DataItemTableView = SORTING("Item No.", "Location Code", "Starting Date", "Ending Date") ORDER(Ascending) WHERE(Archived = FILTER(false));

            trigger OnAfterGetRecord();
            var
                ActualProductCostStructure2: Record "Actual Product Cost Struct DTW";
            begin
                if "Ending Date" <= EndingDate then begin
                    ActualProductCostStructure2.SETRANGE("Parent Line No.", "Line No.");
                    if ActualProductCostStructure2.FINDSET then
                        repeat
                            ActualProductCostStructure2.Archived := true;
                            ActualProductCostStructure2.MODIFY;
                        until ActualProductCostStructure2.NEXT = 0;
                    Archived := true;
                    MODIFY;
                end;

                //Progress dialog bar
                Counter2 += 1;
                if (Counter2 >= NoOfRecProgress2) //OR
                                                  //(TIME - TimeProgress > 1000)
                then begin
                    NoOfProgresed2 := NoOfProgresed2 + Counter2;
                    DialogProgress.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                    DialogProgress.UPDATE(2, ROUND(NoOfProgresed2 / NoOfRecords2 * 10000, 1));
                    Counter2 := 0;
                    TimeProgress2 := TIME;
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
        DeleteProdCostData: Label '%1 Product Cost lines were archived.';
        ProdCostDeleted: Integer;
        AccountingPeriod: Record "Accounting Period";
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        DialogProgress: Dialog;
        ProgressLine1Msg: Label 'Archiving Actual Product Cost Lines: @1@@@@@@@@@@@ \';
        ProgressLine2Msg: Label 'Archiving Actual Product Cost Structure Lines: @2@@@@@@@@@@@';
        NoOfRecords2: Integer;
        NoOfRecProgress2: Integer;
        NoOfProgresed2: Integer;
        Counter2: Integer;
        TimeProgress2: Time;
}

