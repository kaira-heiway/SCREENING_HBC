report 58020 "API Interface Log ProcessPost"
{
    // version HEI.05

    // HEI.01 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Interface log to re-process posting entries
    // HEI.02 CHG2188870 DEBUSD01 06.02.2023 Sales Order API Interface log to re-process posting entries
    //   # fix date filter
    //   # fix Reprocess done filter
    //   # fix total counter & end message
    // HEI.03 CHG2188870 DEBUSD01 09.02.2023 Sales Order API Interface log to re-process posting entries
    //   # add skip when another job queue exists to process the same log entry
    // HEI.04 CHG2194055 DEBUSD01 07.03.2023 Sales Order API Interface log to re-process posting entries
    //   # fix custom date filters with Job Queue
    //   # fix filters on DataItemTableView property
    // HEI.05 CHG2194055 BHANDS01 13.06.2023 API Sales Order Posting Reprocessing Batch
    //   # Code modified
    // BC Upgrade BHARDA11 >>
    // 1. Old Reort ID- 50165.
    // 2. In the Place of ApplicationManagement I'M using "Filter Tokens" because ApplicationManagement obsolet in BC.
    // 3. Add ApplicationArea property in report and requestpage fields.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'API Interface Log ReProcess Posting Entries';
    Permissions = TableData "Source Sys Identifier API FND" = rimd,
                  TableData "API Interface Log2 INT" = rimd,
                  TableData "API Interface Setup2 INT" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("API Interface Log2 INT"; "API Interface Log2 INT")
        {
            CalcFields = "Re-processed", "Re-processed Posting", "No. of Re-processed";
            DataItemTableView = SORTING("Entry No.") WHERE("Call Type" = CONST(Synchronous), Status = CONST(Processed), "Posting Status" = FILTER(Pending | Error), "Re-processed Posting" = CONST(false), "Re-processed Posting Batch" = CONST(false));
            RequestFilterFields = "Interface Code", "Source No.", "Source System Identifier", "Posting Status";

            trigger OnAfterGetRecord();
            var
                APIInterfaceLog2: Record "API Interface Log2 INT";
                NewAPIInterfaceLog2: Record "API Interface Log2 INT";
                APIIntLogReprocessPost: Record "API Interface Log2 INT";
            begin
                //HEI.05>>
                APIIntLogReprocessPost.RESET;
                APIIntLogReprocessPost.SETCURRENTKEY("Entry No.");
                APIIntLogReprocessPost.SETRANGE("Message ID", "API Interface Log2 INT"."Message ID");
                APIIntLogReprocessPost.SETRANGE(Status, APIIntLogReprocessPost.Status::Processed);
                if APIIntLogReprocessPost.FINDLAST then begin
                    if (APIIntLogReprocessPost."Posting Status"
                          in [APIIntLogReprocessPost."Posting Status"::Error, APIIntLogReprocessPost."Posting Status"::Pending])
                          and not APIIntLogReprocessPost."Re-processed Posting Batch" then begin
                        Counter += 1;

                        if not HideDialog and GUIALLOWED then begin
                            //HEI.05>>
                            /*
                            DialogWindow.UPDATE(1,"API Interface Log2 INT"."Entry No.");
                            DialogWindow.UPDATE(2,"API Interface Log2 INT"."Interface Code");
                            DialogWindow.UPDATE(3,"API Interface Log2 INT"."Source No.");
                            */
                            DialogWindow.UPDATE(1, APIIntLogReprocessPost."Entry No.");
                            DialogWindow.UPDATE(2, APIIntLogReprocessPost."Interface Code");
                            DialogWindow.UPDATE(3, APIIntLogReprocessPost."Source No.");
                            //HEI.05<<
                            DialogWindow.UPDATE(9, ROUND(Counter / CountRecords * 10000, 1));
                        end;
                        //    APIInterfaceLog2 := "API Interface Log2 INT"; //HEI.05
                        CLEARLASTERROR;

                        //HEI.03>>
                        if not ISNULLGUID(APIIntLogReprocessPost."Job Queue Entry ID") then //HEI.05
                            if JobQueueEntry.GET(APIIntLogReprocessPost."Job Queue Entry ID") then  //HEI.05
                                CurrReport.SKIP;
                        //HEI.03<<

                        if TryCallReproces(APIIntLogReprocessPost, NewAPIInterfaceLog2) then begin //HEI.05
                                                                                                   //GETLASTERRORTEXT();
                            CounterProcessed += 1;
                        end;

                        //HEI.05>>
                        APIInterfaceLog2.GET(NewAPIInterfaceLog2."Entry No.");
                        APIInterfaceLog2."Re-processed Posting Batch" := true;
                        APIInterfaceLog2.MODIFY;
                        //HEI.05<<

                        //HEI.05>>
                        if NoOfRecordsInProcess > 0 then begin
                            if Counter >= NoOfRecordsInProcess then
                                CurrReport.BREAK;
                        end;
                        //HEI.05<<
                    end;
                end;
                //HEI.05<<

            end;

            trigger OnPostDataItem();
            begin
                if not HideDialog and GUIALLOWED then begin
                    DialogWindow.CLOSE();
                    if CountRecords <> 0 then
                        //HEI.02>>
                        MESSAGE(EndMessage, CounterProcessed, Counter, CountRecordsAll - CounterProcessed) //HEI.05
                                                                                                           //HEI.02<<
                    else
                        MESSAGE(NothingToProcess);
                end;
            end;

            trigger OnPreDataItem();
            begin
                //HEI.05>>
                /*
                //HEI.04>>
                IF NOT (GUIALLOWED OR ReqInitialized) THEN BEGIN
                //HEI.04<<
                  IF NoOfRecordsInProcess = 0 THEN
                    NoOfRecordsInProcess := 1;
                  //HEI.04>>
                  IF ReqPeriodType <> ReqPeriodType::Custom THEN BEGIN
                    GetStartEndDate(WORKDATE,ReqPeriodType,ReqStartDate,ReqEndDate);
                    ValidateStartEndDate();
                  END;
                  //HEI.04<<
                END;
                */
                //HEI.05<<
                //HEI.05>>
                if ReqPeriodType <> ReqPeriodType::Custom then
                    GetStartEndDate(WORKDATE, ReqPeriodType, ReqStartDate, ReqEndDate);
                ValidateStartEndDate();
                //HEI.05<<

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

                if NoOfRecordsInProcess > 0 then begin  //HEI.05
                    if CountRecords > NoOfRecordsInProcess then
                        CountRecords := NoOfRecordsInProcess;
                    //HEI.02<<
                end;  //HEI.05

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
                            //HEI.04>>
                            RefreshRequestPage();
                            //HEI.04<<
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
        // AppMgt: Codeunit ApplicationManagement; // BC Upgrade BHARDA11 ---ApplicationManagement Obsolet in BC so I'm using "Filter Tokens".
        AppMgt: Codeunit "Filter Tokens";// BC Upgrade BHARDA11 ---ApplicationManagement Obsolet in BC so I'm using "Filter Tokens".
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
        ManualCreationReprocess: Boolean;
        ReqInitialized: Boolean;

    procedure SetHideDialog(Hide: Boolean);
    begin
        HideDialog := Hide;
    end;

    local procedure TryCallReproces(Rec: Record "API Interface Log2 INT"; var NewRec: Record "API Interface Log2 INT"): Boolean;
    begin
        Rec.SetHideValidationDialog(true);
        //HEI.04>>
        ManualCreationReprocess := false;
        //HEI.04<<
        exit(Rec.ReprocessPosting2(ManualCreationReprocess, NewRec));
    end;

    local procedure InitRequestPage();
    begin
        APIInterfaceSetup2.GET;
        NoOfRecordsInProcess := APIInterfaceSetup2."Run BatchReProcess No.of Entry";
        ReqPeriodType := ReqPeriodType::Date; //HEI.05
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
        AppMgt.MakeDateFilter(NewDateFilter); // BC Upgrade BHARDA11 
        TempSH.SETFILTER("Date Filter", NewDateFilter);
        ReqDateFilterText := COPYSTR(TempSH.GETFILTER("Date Filter"), 1, MAXSTRLEN(ReqDateFilterText));
    end;
}

