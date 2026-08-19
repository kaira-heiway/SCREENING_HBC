report 51100 "GL Account Application CBN"
{
    // HEI.01 CHG2290168 IBM POENAB02 11.03.2025 GL account application report
    //   # Object created

    // BC UPGRADE PATELS08 >>
    // # Created Object
    // # Nav ID : 50608
    // BC UPGRADE PATELS08 <<

    ApplicationArea = All;
    Caption = 'GL Account Application';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\GLAccountApplication.rdl';

    dataset
    {
        dataitem(GLAccountDataItem; "G/L Account")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            
           

            column(ReportTitleCapLbl;ReportTitleCapLbl){}
            column(GLAccLbl;GLAccLbl){}
            column(FromDateToDateLbl;FromDateToDateLbl){}
            column(AmountFilterLbl;AmountFilterLbl){}
            column(TestModeLbl;TestModeLbl){}
            column(GLAccountFilter;GLAccountFilter){}
            column(AmountRange;AmountRange){}
            column(TestMode;TestMode){}
            column(FromDateToDateText;FromDateToDateText){}
            column(TestModeBoolean2Txt;TestModeBoolean2Txt){}

            

            dataitem(GLEntryDataItem; "G/L Entry")
            {
                DataItemTableView = SORTING("G/L Account No.", "Posting Date") ORDER(Ascending) WHERE("Open FND"=FILTER(True), "Remaining Amount FND"=FILTER(<>0));
                DataItemLink = "G/L Account No."=FIELD("No.");
                RequestFilterFields = "Entry No.";

                column(GLEntryEntryNo; "Entry No.")
                {
                }
                column(GLEntryTMPEntryNo; GLEntryTMPEntryNo)
                {
                }
                column(GLEntryPostingDate; "Posting Date")
                {
                }
                column(GLEntryDocumentNo; "Document No.")
                {
                }
                column(GLEntryGLAccountNo; "G/L Account No.")
                {
                }
                column(GLEntryDescription; Description)
                {
                }
                column(GLEntryAmount; Amount)
                {
                }
                column(GLEntryDebitAmount; "Debit Amount")
                {
                }
                column(GLEntryCreditAmount; "Credit Amount")
                {
                }
                column(GLEntryRemainingAmount; "Remaining Amount FND")
                {
                }
                column(CorrespondingPostingDate; CorrespondingPostingDate)
                {
                }
                column(CorrespondingDocumentNo; CorrespondingDocumentNo)
                {
                }
                column(CorrespondingGLAccNo; CorrespondingGLAccNo)
                {
                }
                column(CorrespondingDescription; CorrespondingDescription)
                {
                }
                column(CorrespondingAmount; CorrespondingAmount)
                {
                }
                column(CorrespondingDebitAmt; CorrespondingDebitAmt)
                {
                }
                column(CorrespondingCreditAmt; CorrespondingCreditAmt)
                {
                }
                column(RemainingAmt; RemainingAmt)
                {
                }
                column(GLEntryRemainingAmountToDisplay; GLEntryRemainingAmountToDisplay)
                {
                }
                column(CorrespondingRemainingAmtToDisplay; CorrespondingRemainingAmtToDisplay)
                {
                }
                column(CorrespondingEntryNo; CorrespondingEntryNo)
                {
                }

                trigger OnPreDataItem()
                begin
                    SETFILTER("Posting Date",'%1..%2',FromDate,ToDate);

                    IF AmountRange <> '' THEN
                    BEGIN
                        IF AmountRangeExists THEN
                        SETFILTER(Amount,'%1..%2',AmountRangeMin,AmountRangeMax);
                        IF NOT AmountRangeExists THEN
                        SETFILTER(Amount,'=%1',AmountRangeMin);
                    END;
                    IF AmountRange = '' THEN
                    SETFILTER(Amount,'>%1',0);
                end;

                trigger OnAfterGetRecord()
                var
                    NegAmt : Decimal;
                begin
                    CorrespondingEntryNo := 0;
                    CorrespondingAmount := 0;
                    GLEntryTMP.RESET;
                    GLEntryTMP.DELETEALL;
                    TempGLEntryBuf.RESET;
                    TempGLEntryBuf.DELETEALL;
                    TempGLEntryBuf3.RESET;
                    TempGLEntryBuf3.DELETEALL;
                    IF Amount <> "Remaining Amount FND" THEN
                    CurrReport.SKIP;


                    GLEntry2.RESET;
                    GLEntry2.SETCURRENTKEY("G/L Account No.","Posting Date");
                    GLEntry2.SETRANGE("G/L Account No.",GLEntryDataItem."G/L Account No.");
                    GLEntry2.SETFILTER("Posting Date",'%1..%2',FromDate,ToDate);
                    GLEntry2.SETFILTER("Entry No.",'<>%1',GLEntryDataItem."Entry No.");
                    GLEntry2.SETRANGE(Amount,GLEntryDataItem.Amount);
                    IF GLEntry2.FINDFIRST THEN
                    CurrReport.SKIP;

                    NegAmt := -Amount;
                    GLEntry3.RESET;
                    GLEntry3.SETCURRENTKEY("G/L Account No.","Posting Date");
                    GLEntry3.SETRANGE("G/L Account No.",GLEntryDataItem."G/L Account No.");
                    GLEntry3.SETFILTER("Posting Date",'%1..%2',FromDate,ToDate);
                    GLEntry3.SETRANGE("Open FND",TRUE);
                    GLEntry3.SETRANGE(Amount,NegAmt);
                    GLEntry3.SETFILTER("Entry No.",'<>%1',GLEntryDataItem."Entry No.");
                    NoOfEntries := GLEntry3.COUNT;
                    IF NoOfEntries = 1 THEN
                    IF GLEntry3.FINDFIRST THEN
                        BEGIN
                        IF (ABS(GLEntry3.Amount) <> ABS(GLEntry3."Remaining Amount FND")) THEN
                            CurrReport.SKIP;
                        CorrespondingPostingDate := GLEntry3."Posting Date";
                        CorrespondingDocumentNo := GLEntry3."Document No.";
                        CorrespondingGLAccNo := GLEntry3."G/L Account No.";
                        CorrespondingDescription := GLEntry3.Description;
                        CorrespondingAmount := GLEntry3.Amount;
                        CorrespondingDebitAmt := GLEntry3."Debit Amount";
                        CorrespondingCreditAmt := GLEntry3."Credit Amount";
                        RemainingAmt := GLEntry3."Remaining Amount FND";
                        CorrespondingEntryNo := GLEntry3."Entry No.";

                        TransferGLEntry(TempGLEntryBuf,GLEntryDataItem);
                        TransferGLEntry(TempGLEntryBuf,GLEntry3);
                        SetApplId(TempGLEntryBuf);
                        ApplicationsFound := TRUE;
                        END;

                    GLEntryRemainingAmountToDisplay := GLEntryDataItem."Remaining Amount FND";
                    CorrespondingRemainingAmtToDisplay := RemainingAmt;

                    //post application
                    IF TestMode = FALSE THEN
                    BEGIN
                        GLEntryRemainingAmountToDisplay := 0;
                        CorrespondingRemainingAmtToDisplay := 0;
                        TempGLEntryBuf.RESET;
                        TempGLEntryBuf.SETFILTER("Applies-to ID",'<>%1','');
                        IF TempGLEntryBuf.FINDFIRST THEN
                        REPEAT
                            TempGLEntryBuf3.RESET;
                            TempGLEntryBuf3.SETRANGE("Applies-to ID",TempGLEntryBuf."Applies-to ID");
                            IF NOT TempGLEntryBuf3.FINDFIRST THEN
                            BEGIN
                                TempGLEntryBuf3.TRANSFERFIELDS(TempGLEntryBuf);
                                IF TempGLEntryBuf3.INSERT THEN;
                            END;
                        UNTIL TempGLEntryBuf.NEXT = 0;

                        IF TempGLEntryBuf3.COUNT = 1 THEN
                        BEGIN
                            TempGLEntryBuf.COPY(TempGLEntryBuf3);
                            Apply(TempGLEntryBuf);
                        END;

                        IF TempGLEntryBuf3.COUNT > 1 THEN
                        REPEAT
                            TempGLEntryBuf.RESET;
                            TempGLEntryBuf.COPY(TempGLEntryBuf3);
                            Apply(TempGLEntryBuf);
                        UNTIL TempGLEntryBuf3.NEXT = 0;
                    END;
                end;

            }

            trigger OnPreDataItem()
            begin
                GLAccountDataItem.SetRange("No.", GLAccountFilter);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                field(GLAccountFilter; GLAccountFilter)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'G/L Account Filter';
                    ToolTipML = ENU = 'Can Contain one one GL Account!';
                    TableRelation = "G/L Account"."No.";
                }

                field(FromDate; FromDate)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'From Date';
                    ToolTipML = ENU = 'Cannot be empty! Can correspond with "To Date".';

                    trigger OnValidate()
                    begin
                        IF ToDate <> 0D THEN
                        IF FromDate > ToDate THEN
                            MESSAGE(Text50004);
                    end;
                }

                field(ToDate; ToDate)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'To Date';
                    ToolTipML = ENU = 'Cannot be empty! Can correspond with "From Date".';

                    trigger OnValidate()
                    begin
                        IF FromDate <> 0D THEN
                        IF FromDate > ToDate THEN
                            MESSAGE(Text50004);
                    end;
                }

                field(AmountRange; AmountRange)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Amount Range';
                    ToolTipML = ENU= 'Must be a decimal. Or, if it is an interval, must be in AA..BB format (Min and Max must be separated by "..")!';
                }

                field(TestMode; TestMode)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Test Mode';
                    ToolTipML = ENU = 'If report is run in test mode, the applications are not done.';
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnInitReport()
    begin
        TestMode := TRUE;
    end;

    trigger OnPreReport()
    begin
        GLSetup.GET;
        AmountRangeExists := FALSE;
        ApplicationsFound := FALSE;

        IF GLAccountFilter = '' THEN
        ERROR(Text50008);

        IF NOT GLAccount.GET(GLAccountFilter) THEN
        ERROR(Text50000,GLAccountFilter);

        IF GLAccount.Blocked THEN
        ERROR(Text50001,GLAccount."No.");

        IF GLAccount."Account Type" <> GLAccount."Account Type"::Posting THEN
        ERROR(Text50011);

        IF FORMAT(FromDate) = '' THEN
        ERROR(Text50002);

        IF FORMAT(ToDate) = '' THEN
        ERROR(Text50003);

        IF FromDate > ToDate THEN
        ERROR(Text50004);

        FromDateToDateText := FORMAT(FromDate) + '..' + FORMAT(ToDate);
        FromDateMonth := DATE2DMY(FromDate,2);
        ToDateMonth := DATE2DMY(ToDate,2);

        IF FromDateMonth <> ToDateMonth THEN
        ERROR(Text50006);

        GLEntryNoFilter := GLEntryDataItem.GETFILTER("Entry No.");
        IF (GLEntryNoFilter <> '') THEN
        GLEntryNoFilter := GLEntryDataItem.FIELDCAPTION("Entry No.") + ': ' + GLEntryNoFilter;
        GLEntryFilters := GLEntryDataItem.GETFILTERS;
        IF (GLEntryNoFilter <> GLEntryFilters) THEN
        ERROR(Text50012);

        IF AmountRange <> '' THEN
        BEGIN
            lPosition := 0;
            lPosition := STRPOS(AmountRange,'..');
            IF lPosition <> 0 THEN
            BEGIN
                AmountRangeExists := TRUE;
                EVALUATE(AmountRangeMin,COPYSTR(AmountRange,1,lPosition-1));
                EVALUATE(AmountRangeMax,COPYSTR(AmountRange,lPosition+2,STRLEN(AmountRange)));
                IF AmountRangeMin < 0 THEN
                ERROR(Text50005);
            END
            ELSE
                BEGIN
                AmountRangeExists := FALSE;
                EVALUATE(AmountRangeMin,AmountRange);
                END;
        END;

        IF TestMode THEN
            TestModeBoolean2Txt := Text50009
        ELSE
            TestModeBoolean2Txt := Text50010;

    end;

    trigger OnPostReport()
    begin
        GLEntryTMP.DELETEALL;

        IF ApplicationsFound = FALSE  THEN
        MESSAGE(Text50007);
    end;

    var
        TestMode : Boolean;
        GLAccountFilter : Code[20];
        FromDate : Date;
        ToDate : Date;
        AmountRange : Text;
        GLAccount : Record "G/L Account";
        MinAmountRange : Decimal;
        MaxAmountRange : Decimal;
        AmountRange2 : Text;
        AmountRangeMin : Decimal;
        AmountRangeMax : Decimal;
        lPosition : Integer;
        AmountRangeExists : Boolean;
        FromDateMonth : Integer;
        ToDateMonth : Integer;
        GLEntry : Record "G/L Entry";
        GLEntryTMP : Record "G/L Entry" temporary;
        GLEntryTMPEntryNo : Integer;
        NoOfEntries : Integer;
        TempGLEntryBuf : Record "G/L Entry Application Bffr FND" temporary;
        GLEntryApplID : Code[50];
        ShowTotalAppliedAmount : Decimal;
        TempGLEntryBuf3 : Record "G/L Entry Application Bffr FND" temporary;
        PageApplyGeneralLedgerEntries : Page "Apply Gen Ledger Entries CBN";

        AllowPartialApplication : Boolean;
        GLSetup : Record "General Ledger Setup";
        CorrespondingPostingDate : Date;
        CorrespondingDocumentNo : Code[20];
        CorrespondingGLAccNo : Code[20];
        CorrespondingDescription : Text[50];
        CorrespondingAmount : Decimal;
        CorrespondingDebitAmt : Decimal;
        CorrespondingCreditAmt  : Decimal;
        RemainingAmt : Decimal;
        ApplicationsFound : Boolean;
        GLEntry2 : Record "G/L Entry";
        GLEntryRemainingAmountToDisplay : Decimal;
        FromDateToDateText : Text;
        TestModeBoolean2Txt : Text;
        CorrespondingRemainingAmtToDisplay : Decimal;

        CorrespondingEntryNo : Integer;
        GLEntry3 : Record "G/L Entry";
        GLEntryNoFilter : Text;
        GLEntryFilters : Text;

        Text50000 : Label 'Value %1 is not correct for G/L Account filter!';
        Text50001 : Label 'GL Account %1 cannot be used because it is blocked!';
        Text50002 : Label 'Field From Date cannot be empty!';
        Text50003 : Label 'Field To Date cannot be empty!';
        Text50004 : Label 'From Date needs to be smaller or equal with To Date!';
        Text50005 : Label 'Amount Range must be positive!';
        Text50006 : Label 'From Date and To Date must be in the same month!';
        TXT50001 : Label 'You cannot apply the G/L entries because the final reporting isn''t extracted yet.';
        TXT50000 : Label 'Partial application  isn''t allowed';
        Text11301 : Label 'Another user has modified the record for this %1 after you retrieved it from the database.';
        Text50007 : Label 'No data found for application within the specified filters.';
        CurrReportPageNoCaptionLbl : Label 'Page';
        ReportTitleCapLbl : Label 'GL Account Application';
        GLAccLbl : Label 'G/L Account:';
        FromDateToDateLbl : Label 'From Date - To Date:';
        AmountFilterLbl : Label 'Amount Filter:';
        TestModeLbl : Label 'Test Mode:';
        Text50008 : Label 'Field GL Account Filter must have a value!';
        Text50009 : Label 'Yes';
        Text50010 : Label 'No';
        Text50011 : Label 'Account Type must be Posting for the selected GL Account!';
        Text50012 : Label 'Only the Entry No. filter can be used for "G/L Entry"!';


    local procedure TransferGLEntry(var GLEntryBuf: Record "G/L Entry Application Bffr FND"; GLEntry: Record "G/L Entry")
    begin
        GLEntryBuf.TRANSFERFIELDS(GLEntry);
        GLEntryBuf.Positive := GLEntry.Amount > 0;
        GLEntryBuf.Comment := GLEntry.Comment;
        GLEntryBuf.INSERT();
    end;

    local procedure SetApplId(var GLEntryBuf: Record "G/L Entry Application Bffr FND")
    begin
        GLEntryBuf.TESTFIELD(Open,TRUE);
        IF GLEntryBuf.FIND('-') THEN BEGIN
        // Make Applies-to ID
        IF GLEntryBuf."Applies-to ID" <> '' THEN BEGIN
            GLEntryApplID := '';
            ShowTotalAppliedAmount := ShowTotalAppliedAmount - GLEntryBuf."Remaining Amount";
        END ELSE BEGIN
            GLEntryApplID := USERID;
            IF GLEntryApplID = '' THEN
            GLEntryApplID := '***';
            ShowTotalAppliedAmount := ShowTotalAppliedAmount + GLEntryBuf."Remaining Amount";
        END;

        // Set Applies-to ID
        REPEAT
            GLEntryBuf.TESTFIELD(Open,TRUE);
            GLEntryBuf."Applies-to ID" := GLEntryApplID;
            GLEntryBuf.MODIFY;
        UNTIL GLEntryBuf.NEXT = 0;
        END;
    end;

    local procedure Apply(var GLEntryBuf: Record "G/L Entry Application Bffr FND")
    var
        GLEntry : Record "G/L Entry";
        AppliedAmount : Decimal;
        TotalAppliedAmount : Decimal;
        RemainingAmount : Integer;
        BaseEntryNo : Integer;
        LetterNoSeries : Text;
        LetterDate : Date;
        TotalBalanced : Decimal;
        GLEntryBufBalanced : Record "G/L Entry Application Bffr FND";
        AccountingPeriod : Record "Accounting Period";
        LoopReturn: Integer;
        NoSeriesMgt : Codeunit "GlobalNoSeriesManagement";
        GeneralLedSetup : Record "General Ledger Setup";

    begin
        GLEntryBuf.TESTFIELD("Applies-to ID");
        BaseEntryNo := TempGLEntryBuf."Entry No.";
        RemainingAmount := GLEntryBuf."Remaining Amount";

        GLEntry.GET(TempGLEntryBuf."Entry No.");

        RealEntryChanged(TempGLEntryBuf,GLEntry);
        TotalBalanced := 0;

        GLEntryBufBalanced.COPY(GLEntryBuf,TRUE);
        GLEntryBufBalanced.SETCURRENTKEY("Applies-to ID");
        GLEntryBufBalanced.SETRANGE("Applies-to ID",GLEntryBuf."Applies-to ID");
        IF GLEntryBufBalanced.FINDSET(FALSE) THEN BEGIN
        REPEAT
            GeneralLedSetup.GET;
            IF GeneralLedSetup."Final Reporting Extracted FND" = TRUE THEN BEGIN
            IF AccountingPeriod.GET(CALCDATE('<CM+1D-2M>',FromDate)) AND (NOT AccountingPeriod."Final Reporting Extracted FND") THEN BEGIN
                ERROR(TXT50001);
            END;
            END;
            TotalBalanced += GLEntryBufBalanced."Remaining Amount";
        UNTIL GLEntryBufBalanced.NEXT = 0;
        END;
        IF (NOT AllowPartialApplication) AND (TotalBalanced <> 0) THEN
        ERROR(TXT50000);

        GLSetup.TESTFIELD("G/L Application No. Series fnd");
        LetterNoSeries := NoSeriesMgt.GetNextGlobalNo(GLSetup."G/L Application No. Series FND",TODAY(),TRUE);
        LetterDate     := TODAY();

        GLEntryBuf.SETCURRENTKEY("Applies-to ID");
        GLEntryBuf.SETRANGE("Applies-to ID",GLEntryBuf."Applies-to ID");
        GLEntryBuf.SETFILTER("Entry No.",'<> %1',GLEntryBuf."Entry No.");
        IF GLEntryBuf.FIND('-') THEN BEGIN
        REPEAT
            GLEntryBuf.TESTFIELD("G/L Account No.",GLEntryBuf."G/L Account No.");
            GLEntryBuf.TESTFIELD(Open,TRUE);
            AppliedAmount := -GLEntryBuf."Remaining Amount";
            TotalAppliedAmount := TotalAppliedAmount + AppliedAmount;
            RealEntryChanged(GLEntryBuf,GLEntry);
            UpdateTempTable(GLEntryBuf,0,FALSE,BaseEntryNo,GLEntryBuf."Posting Date",-AppliedAmount,'',LetterNoSeries,LetterDate);
            UpdateRealTable(GLEntry,0,FALSE,BaseEntryNo,GLEntryBuf."Posting Date",-AppliedAmount,'',LetterNoSeries,LetterDate);
        UNTIL GLEntryBuf.NEXT = 0;
        END ELSE
        EXIT;
        // Update entry where cursor is on
        // Update real Table
        GLEntry.GET(BaseEntryNo);
        UpdateRealTable(
            GLEntry, GLEntry."Remaining Amount FND" - TotalAppliedAmount,
            (GLEntry."Remaining Amount FND" - TotalAppliedAmount) <> 0, 0, 0D, 0, '', LetterNoSeries, LetterDate);
        // Update Temporary Table
        TempGLEntryBuf.GET(BaseEntryNo);
        UpdateTempTable(
            TempGLEntryBuf, TempGLEntryBuf."Remaining Amount" - TotalAppliedAmount,
            (TempGLEntryBuf."Remaining Amount" - TotalAppliedAmount) <> 0, 0, 0D, 0, '', LetterNoSeries, LetterDate);

        ShowTotalAppliedAmount := 0;
    end;

    procedure RealEntryChanged(TempEntry : Record "G/L Entry Application Bffr FND";VAR GlEntry : Record "G/L Entry")
    begin
        // 'Real' G/L Entry changed
        GlEntry.LOCKTABLE;
        GlEntry.GET(TempEntry."Entry No.");
        IF (GlEntry."Remaining Amount FND" <> TempEntry."Remaining Amount") OR
            (GlEntry."Open FND" <> TempEntry.Open) OR
            (GlEntry."Closed by Entry No. FND" <> TempEntry."Closed by Entry No.") OR
            (GlEntry."Closed at Date FND" <> TempEntry."Closed at Date") OR
            (GlEntry."Closed by Amount FND" <> TempEntry."Closed by Amount")
        THEN
            ERROR(Text11301, GlEntry.TABLECAPTION);
    end;

    procedure UpdateTempTable(VAR TempEntry : Record "G/L Entry Application Bffr FND";RemainingAmt : Decimal;IsOpen : Boolean;ClosedbyEntryNo : Integer;ClosedbyDate : Date;ClosedbyAmt : Decimal;AppliesToID : Code[50];LetterNoSeries : Text[20];LetterDate : Date)
    begin
        // Update Temporary Table
        TempEntry."Remaining Amount" := RemainingAmt;
        TempEntry.Open := IsOpen;
        TempEntry."Closed by Entry No." := ClosedbyEntryNo;
        TempEntry."Closed at Date" := ClosedbyDate;
        TempEntry."Closed by Amount" := ClosedbyAmt;
        TempEntry."Applies-to ID" := AppliesToID;
        TempEntry."Entries Posted By" := USERID;
        TempEntry.Letter := LetterNoSeries;
        TempEntry."Letter Date" := LetterDate;
        TempEntry.MODIFY;
    end;

    procedure UpdateRealTable(RealEntry : Record "G/L Entry";RemainingAmt : Decimal;IsOpen : Boolean;ClosedbyEntryNo : Integer;ClosedbyDate : Date;ClosedbyAmt : Decimal;AppliesToID : Code[50];LetterNoSeries : Text[20];LetterDate : Date)
    begin
        // Update Temporary Table     
        RealEntry."Remaining Amount FND" := RemainingAmt;
        RealEntry."Open FND" := IsOpen;
        RealEntry."Closed by Entry No. FND" := ClosedbyEntryNo;
        RealEntry."Closed at Date FND" := ClosedbyDate;
        RealEntry."Closed by Amount FND" := ClosedbyAmt;
        RealEntry."Applies-to ID FND" := AppliesToID;
        RealEntry."Entries Posted By FND" := USERID;
        RealEntry.LetterFND := LetterNoSeries;
        RealEntry."Letter Date FND" := LetterDate;
        RealEntry.MODIFY();
    end;
}
