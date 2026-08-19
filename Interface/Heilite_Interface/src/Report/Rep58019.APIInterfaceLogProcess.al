report 58019 "API Interface Log Process"
{
    // version HEI.04

    // HEI.01 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Interface log to re-process entries
    // HEI.02 CHG2188870 DEBUSD01 06.02.2023 Sales Order API Interface log to re-process entries
    //   # fix date filter
    //   # fix Reprocess done filter
    //   # fix total counter & end message
    // HEI.03 CHG2188870 DEBUSD01 09.02.2023 Sales Order API Interface log to re-process entries
    //   # add skip when another job queue exists to process the same log entry
    // HEI.04 CHG2194055 DEBUSD01 07.03.2023 Sales Order API Interface log to re-process posting entries
    //   # fix custom date filters with Job Queue
    // BC Upgrade BHARDA11 >>
    // 1. Old Reort ID- 50164.
    // 2. In the Place of ApplicationManagement I'M using "Filter Tokens" because ApplicationManagement obsolet in BC.
    // 3. Add ApplicationArea property in report and requestpage fields.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'API Interface Log ReProcess Entries';
    Permissions = TableData "Source Sys Identifier API FND" = rimd,
                  TableData "API Interface Log2 INT" = rimd,
                  TableData "API Interface Setup2 INT" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("API Interface Log2 INT"; "API Interface Log2 INT")
        {
            DataItemTableView = SORTING("Parent Entry No.", "Entry No.", Status, Manual, "Request Sync. Date/Time") WHERE("Call Type" = CONST(Synchronous), Status = FILTER(Pending | Error), Manual = CONST(false), "Parent Entry No." = CONST(0), "Re-processed" = CONST(false));
            RequestFilterFields = "Interface Code", "Source No.", "Source System Identifier", Status;

            trigger OnAfterGetRecord();
            var
                APIInterfaceLog2: Record "API Interface Log2 INT";
                NewAPIInterfaceLog2: Record "API Interface Log2 INT";
            begin
                Counter += 1;

                if not HideDialog and GUIALLOWED then begin
                    DialogWindow.UPDATE(1, "API Interface Log2 INT"."Entry No.");
                    DialogWindow.UPDATE(2, "API Interface Log2 INT"."Interface Code");
                    DialogWindow.UPDATE(3, "API Interface Log2 INT"."Source No.");
                    DialogWindow.UPDATE(9, ROUND(Counter / CountRecords * 10000, 1));
                end;
                APIInterfaceLog2 := "API Interface Log2 INT";
                CLEARLASTERROR;

                //HEI.03>>
                if not ISNULLGUID(APIInterfaceLog2."Job Queue Entry ID") then
                    if JobQueueEntry.GET(APIInterfaceLog2."Job Queue Entry ID") then
                        CurrReport.SKIP;
                //HEI.03<<

                if TryCallReproces(APIInterfaceLog2, NewAPIInterfaceLog2) then begin
                    //GETLASTERRORTEXT();
                    CounterProcessed += 1;
                end;

                if Counter >= NoOfRecordsInProcess then
                    CurrReport.BREAK;
            end;

            trigger OnPostDataItem();
            begin
                if not HideDialog and GUIALLOWED then begin
                    DialogWindow.CLOSE();
                    if CountRecords <> 0 then
                        //HEI.02>>
                        MESSAGE(EndMessage, CounterProcessed, CountRecords, CountRecordsAll - CounterProcessed)
                    //HEI.02<<
                    else
                        MESSAGE(NothingToProcess);
                end;
            end;

            trigger OnPreDataItem();
            begin
                //HEI.04>>
                if not (GUIALLOWED or ReqInitialized) then begin
                    //HEI.04<<
                    if NoOfRecordsInProcess = 0 then
                        NoOfRecordsInProcess := 1;
                    //HEI.04>>
                    if ReqPeriodType <> ReqPeriodType::Custom then begin
                        GetStartEndDate(WORKDATE, ReqPeriodType, ReqStartDate, ReqEndDate);
                        ValidateStartEndDate();
                    end;
                    //HEI.04<<
                end;
                //HEI.02>>
                "API Interface Log2 INT".LOCKTABLE;
                //HEI.02<<
                "API Interface Log2 INT".SETFILTER("No. of Re-processed", '<%1', APIInterfaceSetup2."Reprocess Count");
                //HEI.02>>
                CountRecordsAll := "API Interface Log2 INT".COUNT;
                //HEI.02<<
                "API Interface Log2 INT".SETFILTER("Request Sync. Date/Time", ReqDateFilterText);
                //HEI.02>>
                CountRecords := "API Interface Log2 INT".COUNT;
                if CountRecords > NoOfRecordsInProcess then
                    CountRecords := NoOfRecordsInProcess;
                //HEI.02<<

                Counter := 0;
                if not HideDialog and GUIALLOWED then
                    DialogWindow.OPEN(Text001 + Text002 + Text003 + Text009);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfProcessRecords; NoOfRecordsInProcess)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Records to Re-process';
                        MinValue = 1;
                    }
                    field("Period Type"; ReqPeriodType)
                    {
                        ApplicationArea = All;
                        Caption = 'Period Type';

                        trigger OnValidate();
                        begin
                            ValidatePeriodType();
                        end;
                    }
                    field(StartDate; ReqStartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Starting Date',
                                    FRA = 'Date début';
                        Enabled = ReqDateFilterEnabled;
                        ToolTipML = ENU = 'Specifies the date from which the report or batch job processes information.',
                                    FRA = 'Spécifie la date à partir de laquelle l''état ou le traitement par lots traite les informations.';

                        trigger OnValidate();
                        begin
                            ValidateStartEndDate;
                        end;
                    }
                    field(EndDate; ReqEndDate)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Ending Date',
                                    FRA = 'Date fin';
                        Enabled = ReqDateFilterEnabled;
                        ToolTipML = ENU = 'Specifies the date to which the report or batch job processes information.',
                                    FRA = 'Spécifie la date à laquelle l''état ou le traitement par lots traite les informations.';

                        trigger OnValidate();
                        begin
                            ValidateStartEndDate;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            //HEI.04>>
            if GUIALLOWED and not ReqInitialized then
                InitRequestPage();
            //HEI.04<<
        end;

        trigger OnOpenPage();
        begin
            //HEI.04>>
            if GUIALLOWED and not ReqInitialized and (ReqPeriodType <> ReqPeriodType::Custom) then
                ValidatePeriodType();
            RefreshRequestPage();
            //HEI.04<<
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        APIInterfaceSetup2.GET;
    end;

    var
        APIInterfaceSetup2: Record "API Interface Setup2 INT";
        JobQueueEntry: Record "Job Queue Entry";
        // AppMgt: Codeunit ApplicationManagement; // BC Upgrade BHARDA11 
        TextManagem: Codeunit "Filter Tokens"; // BC Upgrade BHARDA11 
        DialogWindow: Dialog;
        Text001: Label 'Entry No. #1########\';
        Text002: Label 'Interface Code #2########\';
        Text003: Label 'Source No. #3########\';
        Text009: TextConst ENU = 'Progress @9@@@@@@@@\', FRA = 'Code magasin     #2########\';
        HideDialog: Boolean;
        CountRecords: Integer;
        CountRecordsAll: Integer;
        Counter: Integer;
        CounterProcessed: Integer;
        EndMessage: Label '%1 / %2 records have been processed completed (remaining %3 records).';
        NothingToProcess: Label 'There is nothing to process.';
        NoOfRecordsInProcess: Integer;
        ReqDateFilterEnabled: Boolean;
        ReqPeriodType: Option Date,Week,Month,Quarter,Year,Custom;
        ReqStartDate: Date;
        ReqEndDate: Date;
        ReqDateFilterText: Text[30];
        ReqInitialized: Boolean;

    procedure SetHideDialog(Hide: Boolean);
    begin
        HideDialog := Hide;
    end;

    local procedure TryCallReproces(Rec: Record "API Interface Log2 INT"; var NewRec: Record "API Interface Log2 INT"): Boolean;
    begin
        Rec.SetHideValidationDialog(true);
        exit(Rec.Reprocess2(NewRec));
    end;

    local procedure InitRequestPage();
    begin
        APIInterfaceSetup2.GET;
        NoOfRecordsInProcess := APIInterfaceSetup2."Run BatchReProcess No.of Entry";
        ReqPeriodType := ReqPeriodType::Month;
        ValidatePeriodType();
    end;

    local procedure RefreshRequestPage();
    begin
        //HEI.04>>
        ReqDateFilterEnabled := (ReqPeriodType = ReqPeriodType::Custom);
        //HEI.04<<
    end;

    local procedure GetStartEndDate(WithDate: Date; WithPeriodType: Option Date,Week,Month,Quarter,Year,Custom; var NewStartDate: Date; var NewEndDate: Date);
    var
        DatePeriod: Record Date;
    begin
        NewStartDate := 0D;
        NewEndDate := 0D;
        if (WithPeriodType = WithPeriodType::Custom) or (WithDate = 0D) then
            exit;
        DatePeriod.ASCENDING(false);
        DatePeriod.SETRANGE("Period Type", WithPeriodType);
        DatePeriod.SETFILTER("Period Start", '..%1', WithDate);
        if DatePeriod.FINDFIRST then begin
            NewStartDate := DatePeriod."Period Start";
            //HEI.02>>
            NewEndDate := NORMALDATE(DatePeriod."Period End");
            //HEI.02<<
        end;
    end;

    local procedure ValidatePeriodType();
    begin
        ///HEI.04
        if ReqPeriodType <> ReqPeriodType::Custom then
            GetStartEndDate(WORKDATE, ReqPeriodType, ReqStartDate, ReqEndDate);
        ValidateStartEndDate();
    end;

    local procedure ValidateStartEndDate();
    begin
        if (ReqStartDate = 0D) and (ReqEndDate = 0D) then begin
            ValidateDateFilter('');
            exit;
        end;
        if ReqPeriodType > ReqPeriodType::Date then
            ValidateDateFilter(STRSUBSTNO('%1..%2', ReqStartDate, ReqEndDate))
        else
            ValidateDateFilter(STRSUBSTNO('%1', ReqStartDate));
    end;

    local procedure ValidateDateFilter(NewDateFilter: Text[30]);
    var
        TempSH: Record "Sales Header" temporary;
    begin
        // if AppMgt.MakeDateFilter(NewDateFilter) = 0 then; // BC Upgrade BHARDA11 
        TextManagem.MakeDateFilter(NewDateFilter);

        TempSH.SETFILTER("Date Filter", NewDateFilter);
        ReqDateFilterText := COPYSTR(TempSH.GETFILTER("Date Filter"), 1, MAXSTRLEN(ReqDateFilterText));
    end;
}

