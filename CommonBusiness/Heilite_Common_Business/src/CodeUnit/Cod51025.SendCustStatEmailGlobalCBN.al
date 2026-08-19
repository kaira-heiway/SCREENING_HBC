codeunit 51025 "SendCust.Stat EmailGlobal CBN"
{
    // version HEI.02

    // HEI.01 CHG2250653-HB3631 COSTES04 27.08.2024 Customer Statement should show dates in sequency
    //   # New OBject
    // HEI.02 CHG2289382 COSTES04 10.02.2024 Mozambique customer statement fix
    //   # Manage file not successfully created exception
    // BC Upgrade BHARDA11 >>
    // 1. Change SMTPMail to Email Mesage 
    // 2. Remove old Report.saveaspdf logic to new version
    // 3. Comment  CalcNextWorkingDate  commented(Fn-CalcNextWorkingDate is having fuctions called which are DIT customised) due to dependecy on DIT (showCheckCustomizedDateStatus)
    // 4. Remove Drink-IT Fields and related code
    // 5. Change Attachment Logic
    // BC Upgrade BHARDA11 <<

    TableNo = "Job Queue Entry";

    trigger OnRun();
    var
        EarliestStartingDate: Date;
    begin
        GetSalesSetup();

        CASE Rec."Parameter String" OF
            'WEEKLY':
                Frequency := Frequency::Weekly;
            'MONTHLY':
                Frequency := Frequency::Monthly;
            else
                ERROR(ParameterStringError, Rec.FIELDCAPTION("Parameter String"), Frequency::Weekly, Frequency::Monthly);
        end;

        GetCustomerStatementSetup(Frequency);

        CalcReportPeriod();

        SendCustomersStatementEmail();

        EarliestStartingDate := GetNexEarliestStartingDate(Frequency);

        Rec."Earliest Start Date/Time" := CREATEDATETIME(CALCDATE('<-1D>', EarliestStartingDate), Rec."Starting Time");
        Rec.MODIFY();
    end;

    var
        CustomerStatementSetup: Record "Customer Statement Setup FND";
        SalesSetup: Record "Sales & Receivables Setup";
        Email: Codeunit Email;
        // SMTPMail: Codeunit 400; // BC Upgrade BHARDA11 ---SMTPMAil --> Email Message"
        SMTPMail: Codeunit "Email Message";
        SalesSetupRead: Boolean;
        EndDate: Date;
        StartDate: Date;
        ReportID: Integer;
        EmptyCustomerEmail: Label 'Email Address is mandatory for Customer %1.';
        EmptyFileNameErr: Label 'Customer Statement File could not be generated %1.';
        FrequencyErr: Label 'Frequency not supported.';
        OpenBalanceErr: Label 'There is no Open Balance at date %1 for customer %2.';
        ParameterStringError: Label 'Please setup %1 with one of existing options: %2.%3';
        ReportIDErr: Label 'Report %1 is not covered by Send Customer Statement Functionlity.';

        Frequency: Option Weekly,Monthly;

    local procedure SendCustomersStatementEmail();
    var
        Customer: Record Customer;
    begin
        GetSalesSetup();

        ReportID := GetReportID();

        Customer.SETFILTER("Account Group FND", SalesSetup."Cust Stmt. Acc Grp Filter FND");
        Customer.SETFILTER(Blocked, '<>%1', Customer.Blocked::All);
        Customer.SETAUTOCALCFIELDS("Flag for Deletion FND");
        IF Customer.findset(false) THEN
            REPEAT
                IF NOT Customer."Flag for Deletion FND" THEN
                    ProcessCustomer(Customer, ReportID);
            UNTIL Customer.NEXT() = 0;
    end;

    local procedure ProcessCustomer(Customer: Record Customer; CustStatReportID: Integer);
    var
        CustomerReport: Record Customer;
        CustomerStatementofAccount: Report "SendEmail Cust Stmt Global CBN";
        Email: Codeunit Email;
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        InStr: InStream;
        OutStr: OutStream;
        FileName: Text;

    begin
        CLEAR(SMTPMail);
        CLEAR(FileName);
        CustomerReport.SETRANGE("No.", Customer."No.");
        IF NOT CustomerReport.FINDFIRST() THEN
            EXIT;

        IF SalesSetup."Delete Cust. Email Log FND" THEN
            DeleteEmailCustomerLog(Customer."No.");

        IF Customer."E-Mail" = '' THEN BEGIN
            CreateEmailCustomerLog(Customer."No.", FALSE, STRSUBSTNO(EmptyCustomerEmail, Customer."No."), StartDate, EndDate);
            EXIT;
        end;

        IF NOT HasTransactions(Customer."No.", StartDate, EndDate) THEN BEGIN
            CreateEmailCustomerLog(Customer."No.", FALSE, 'No transactions in the period', StartDate, EndDate);
            EXIT;
        end;

        //generate customer statement pdf
        //new report options can be added here
        CASE CustStatReportID OF
            REPORT::"SendEmail Cust Stmt Global CBN":
                FileName := CreateCustomerStatementMzmb(Customer, StartDate, EndDate)
            else
                ERROR(STRSUBSTNO(ReportIDErr, ReportID));
        end;

        // BC Upgrade BHARDA11 >> ---Remove old code and replace with new code
        // //IF FileName = '' THEN BEGIN//HEI.02
        // IF (FileName = '') OR (NOT FILE.EXISTS(FileName)) THEN BEGIN//HEI.02
        //     CreateEmailCustomerLog(Customer."No.", FALSE, STRSUBSTNO(EmptyFileNameErr, Customer."No."), StartDate, EndDate);
        //     EXIT;
        // end;
        if (FileName = '') or (not FileManagement.ServerFileExists(FileName)) then begin//HEI.02
            CreateEmailCustomerLog(Customer."No.", false, StrSubstNo(EmptyFileNameErr, Customer."No."), StartDate, EndDate);
            exit;
        end;
        // BC Upgrade BHARDA11 << ---Remove old code and replace with new code

        CreateEmailBody(Customer);

        // BC Upgrade BHARDA11 >> ----For Report Attachment
        CustomerStatementofAccount.InitAllParameters(
                StartDate, EndDate, FALSE, 0,
                SalesSetup."Cust. Stmt. Aging Interval FND",
                0, 3, 3, FALSE, Customer."No.");

        TempBlob.CreateOutStream(OutStr);
        CustomerStatementofAccount.SaveAs('', ReportFormat::Pdf, OutStr);

        // FileName := StrSubstNo('Statement_%1.pdf', Customer."No.");
        TempBlob.CreateInStream(InStr);
        SMTPMail.AddAttachment(FileName, 'pdf', InStr);
        // BC Upgrade BHARDA11 << ----For Report Attachment

        // SMTPMail.AddAttachment(FileName, Customer.Name + ' Statement ' + '.pdf'); // BC Upgrade BHARDA11

        // IF SMTPMail.TrySend THEN // BC Upgrade BHARDA11
        if Email.Send(SMTPMail, Enum::"Email Scenario"::Default) then // BC Upgrade BHARDA11
            CreateEmailCustomerLog(Customer."No.", TRUE, 'Success', StartDate, EndDate)
        else
            // CreateEmailCustomerLog(Customer."No.", FALSE, COPYSTR(SMTPMail.GetLastSendMailErrorText, 1, 100), StartDate, EndDate); // BC Upgrade BHARDA11 -- REmove  SMTPMail.GetLastSendMailErrorText and replace with getlsterrortext
            CreateEmailCustomerLog(Customer."No.", FALSE, COPYSTR(GetLastErrorText, 1, 100), StartDate, EndDate);

        COMMIT();
    end;

    local procedure CreateCustomerStatementMzmb(Customer: Record Customer; StartDate: Date; EndDate: Date): Text;
    var
        CustomerStatementofAccount: Report "SendEmail Cust Stmt Global CBN"; // BC Upgrade BHARDA11
        FileManagement: Codeunit "File Management";
        // BC Upgrade BHARAD11  >>
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        FileName: Text;
    // BC Upgrade BHARAD11  <<

    begin
        CustomerStatementofAccount.InitAllParameters(StartDate, EndDate, FALSE, 0, SalesSetup."Cust. Stmt. Aging Interval FND", 0, 3, 3, FALSE, Customer."No.");
        // BC Upgrade BHARDA11 >>
        // FileName := FileManagement.ServerTempFileName('pdf');
        // CustomerStatementofAccount.SAVEASPDF(FileName);
        TempBlob.CreateOutStream(OutStr);
        CustomerStatementofAccount.SaveAs('', ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);
        FileName := StrSubstNo('Customer_Statement_%1.pdf', Customer."No.");
        // BC Upgrade BHARDA11 <<

        // CustomerStatementofAccount.SaveAs()


        EXIT(FileName);
    end;

    procedure SendManualCustomerStatementEmail(var CustomerEmailLog: Record "Customer Email Log FND");
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        CustomerStatementofAccount: Report "SendEmail Cust Stmt Global CBN"; // BC Upgrade BHARDA11
        SendEmailGlobalStmtofCust: Report "Customer Statement SL CBN";
        SendEmailGlobalStmtofCustDeposit: Report "Customer Statement SL CBN";
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        DepositExits: Boolean;
        SalesExist: Boolean;
        InStr: InStream;
        OutStr: OutStream;
        FileName: Text;
        FileNameDeposit: Text;
        Period: Text;


    begin
        CustomerEmailLog.TESTFIELD("Report Sent", FALSE);

        Customer.GET(CustomerEmailLog."Customer No.");
        Customer.SETRANGE("No.", CustomerEmailLog."Customer No.");
        Customer.TESTFIELD("E-Mail");

        CustomerEmailLog.DateTime := CURRENTDATETIME;
        CustomerEmailLog.MODIFY();

        GetSalesSetup();

        IF NOT HasTransactions(Customer."No.", CustomerEmailLog."Period From", CustomerEmailLog."Period To") THEN
            ERROR(OpenBalanceErr, CustomerEmailLog."Period To", Customer."No.");

        ReportID := GetReportID();
        //generate customer statement pdf
        //new report options can be added here
        CASE ReportID OF
            REPORT::"SendEmail Cust Stmt Global CBN":
                FileName := CreateCustomerStatementMzmb(Customer, CustomerEmailLog."Period From", CustomerEmailLog."Period To")
            else
                ERROR(STRSUBSTNO(ReportIDErr, ReportID));
        end;

        CreateEmailBody(Customer);
        // BC Upgrade BHARDA11 >> ----For Report Attachment
        CustomerStatementofAccount.InitAllParameters(
                CustomerEmailLog."Period From", CustomerEmailLog."Period To", FALSE, 0,
                SalesSetup."Cust. Stmt. Aging Interval FND",
                0, 3, 3, FALSE, Customer."No.");

        TempBlob.CreateOutStream(OutStr);
        CustomerStatementofAccount.SaveAs('', ReportFormat::Pdf, OutStr);

        // FileName := StrSubstNo('Statement_%1.pdf', Customer."No.");
        TempBlob.CreateInStream(InStr);
        SMTPMail.AddAttachment(FileName, 'pdf', InStr);
        // BC Upgrade BHARDA11 << ----For Report Attachment
        // SMTPMail.AddAttachment(FileName, Customer.Name + ' Statement ' + '.pdf'); // BC Upgrade BHARDA11
        if Email.Send(SMTPMail, Enum::"Email Scenario"::Default) then begin // BC Upgrade BHARDA11
            // IF SMTPMail.TrySend THEN BEGIN // BC Upgrade BHARDA11
            CustomerEmailLog."Report Sent" := TRUE;
            CustomerEmailLog.DateTime := CURRENTDATETIME;
            CustomerEmailLog."Error Message" := 'Success';
            CustomerEmailLog.MODIFY();
        end else BEGIN
            CustomerEmailLog."Report Sent" := FALSE;
            CustomerEmailLog.DateTime := CURRENTDATETIME;
            // CustomerEmailLog."Error Message" := COPYSTR(SMTPMail.GetLastSendMailErrorText, 1, MAXSTRLEN(CustomerEmailLog."Error Message")); // BC Upgrade BHARDA11 
            CustomerEmailLog."Error Message" := COPYSTR(GetLastErrorText, 1, MAXSTRLEN(CustomerEmailLog."Error Message"));
            CustomerEmailLog.MODIFY();
        end;
    end;

    local procedure CreateEmailBody(Customer: Record 18);
    var
        // StandardTextReport: Record 2014410; // BC Upgrade BHARDA11 ----Drink-IT Table (StandardTextReport)
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        Language: Record Language;
        LanguageMgt: Codeunit Language;
        LanguageID: Integer; // BC Upgrade BHARDA11
        MailBody: Text;
        MailSubject: Text;
    begin
        // BC Upgrade BHARDA11 >> ---Drink-IT Table (StandardTextReport)
        // StandardTextReport.RESET;
        // StandardTextReport.SETRANGE("Report ID", ReportID);
        // StandardTextReport.FINDFIRST;
        // BC Upgrade BHARDA11 << ---Drink-IT Table (StandardTextReport)
        ExtendedTextHeader.RESET();
        // ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code"); // BC Upgrade BHARDA11 ----Drink-IT Table StandardTextReport.
        // ExtendedTextHeader.SETRANGE("Language Code", Language.GetUserLanguage); // Bc Upgrade BHARDA11 --Replace Language Logic 
        ExtendedTextHeader.SETRANGE("Language Code", format(LanguageMgt.GetLanguageIdOrDefault(Customer."Language Code"))); // Bc Upgrade BHARDA11 --Replace Language Logic 

        IF NOT ExtendedTextHeader.FINDFIRST() THEN BEGIN
            ExtendedTextHeader.SETRANGE("Language Code");
            ExtendedTextHeader.SETRANGE("All Language Codes", TRUE);
            IF NOT ExtendedTextHeader.FINDFIRST() THEN
                ExtendedTextHeader.SETRANGE("All Language Codes");
        end;

        //Add subject
        ExtendedTextHeader.SETFILTER(Description, '%1', 'Subject');
        ExtendedTextHeader.FINDFIRST();
        ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
        ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
        ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
        IF ExtendedTextLine.findset(false) THEN
            REPEAT
                MailSubject := ExtendedTextLine.Text + ' ' + Customer.Name;
                // SMTPMail.CreateMessage('', SalesSetup."Cust. Stmt. Email Address", Customer."E-Mail", MailSubject, '', TRUE); // BC Upgrade BHARDA11
                SMTPMail.Create(Customer."E-Mail", MailSubject, '', true); // BC Upgrade BHARDA11
            UNTIL ExtendedTextLine.NEXT() = 0;

        //add body
        ExtendedTextHeader.SETFILTER(Description, '<>%1', 'Subject');
        ExtendedTextHeader.findset(false);
        REPEAT
            ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
            ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
            ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
            IF ExtendedTextLine.findset(false) THEN
                REPEAT
                    SMTPMail.AppendToBody(ExtendedTextLine.Text);
                    SMTPMail.AppendToBody('<br><Br>');
                UNTIL ExtendedTextLine.NEXT() = 0;
        UNTIL ExtendedTextHeader.NEXT() = 0;
    end;

    local procedure CreateEmailCustomerLog(CustomerNo: Code[20]; Success: Boolean; ErrorMessage: Text; PeriodFrom: Date; PeriodTo: Date);
    var
        CustomerEmailLog: Record "Customer Email Log FND";
    begin
        CustomerEmailLog.INIT();
        CustomerEmailLog."Customer No." := CustomerNo;
        CustomerEmailLog."Report Sent" := Success;
        CustomerEmailLog."Error Message" := COPYSTR(ErrorMessage, 1, MAXSTRLEN(CustomerEmailLog."Error Message"));
        CustomerEmailLog.DateTime := CURRENTDATETIME;
        CustomerEmailLog."Period From" := PeriodFrom;
        CustomerEmailLog."Period To" := PeriodTo;
        CustomerEmailLog.INSERT();
    end;

    local procedure DeleteEmailCustomerLog(CustomerNo: Code[20]);
    var
        CustomerEmailLog: Record "Customer Email Log FND";
    begin
        CustomerEmailLog.SETRANGE("Customer No.", CustomerNo);
        CustomerEmailLog.DELETEALL();
    end;

    local procedure HasTransactions(CustomerNo: Code[20]; PeriodFrom: Date; PeriodTo: Date): Boolean;
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        BalanceAmount: Decimal;
    begin
        CustLedgerEntry.RESET();
        // CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Item Charge Type"); // BC Upgrade BHARDA11 ----Drink-IT Field ("Item Charge Type")
        CustLedgerEntry.SETRANGE("Customer No.", CustomerNo);
        CustLedgerEntry.SETRANGE("Posting Date", PeriodFrom, PeriodTo);
        IF NOT CustLedgerEntry.ISEMPTY THEN
            EXIT(TRUE);

        DetailedCustLedgEntry.SETRANGE("Customer No.", CustomerNo);
        DetailedCustLedgEntry.SETFILTER("Posting Date", '<%1', PeriodFrom);
        DetailedCustLedgEntry.CALCSUMS(Amount);
        BalanceAmount := DetailedCustLedgEntry.Amount;
        IF BalanceAmount <> 0 THEN
            EXIT(TRUE);

        EXIT(FALSE);
    end;

    local procedure CalcReportPeriod();
    var
        EmptyDateFormula: DateFormula;
    begin
        IF CustomerStatementSetup."End Date" = EmptyDateFormula THEN
            EndDate := TODAY
        else
            EndDate := CALCDATE(CustomerStatementSetup."End Date", TODAY);

        IF CustomerStatementSetup."Start Date" = EmptyDateFormula THEN
            StartDate := 0D
        else
            StartDate := CALCDATE(CustomerStatementSetup."Start Date", EndDate);
    end;

    local procedure GetReportID() ReportD: Integer;
    var
        ReportSelections: Record "Report Selections";
    begin
        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"C.Statement");
        ReportSelections.FINDFIRST();

        EXIT(ReportSelections."Report ID");
    end;

    local procedure GetSalesSetup();
    begin
        IF NOT SalesSetupRead THEN
            SalesSetup.GET();

        SalesSetupRead := TRUE;
    end;

    local procedure GetCustomerStatementSetup(Freq: Integer);
    begin
        CustomerStatementSetup.SETRANGE(Frequency, Freq);
        CustomerStatementSetup.FINDFIRST();
    end;

    local procedure GetNexEarliestStartingDate(Freq: Integer): Date;
    var
        CustomerStatementSetup: Record "Customer Statement Setup FND";
    begin
        CASE Freq OF
            CustomerStatementSetup.Frequency::Weekly:
                EXIT(GetNextWeekWorkingDay());
            CustomerStatementSetup.Frequency::Monthly:
                EXIT(GetNextMonthWorkingDay());
        end;
    end;

    local procedure GetNextMonthWorkingDay(): Date;
    var
        CalendarManagement: Codeunit "Calendar Management";
        EmptyDF: DateFormula;
        DayOfMonth: Date;
        WorkingDay: Date;
    begin
        GetSalesSetup();

        DayOfMonth := CALCDATE('<-CM-1D>');
        DayOfMonth := CALCDATE(CustomerStatementSetup."Running Date", DayOfMonth);
        // WorkingDay := CalendarManagement.CalcNextWorkingDate(EmptyDF, DayOfMonth, SalesSetup."Cust. Stmt. Base Calendar"); // BC Upgrade BHARDA11 --- commented(Fn-CalcNextWorkingDate is having fuctions called which are DIT customised) due to dependecy on DIT (showCheckCustomizedDateStatus)

        IF WorkingDay > TODAY THEN
            EXIT(WorkingDay);

        DayOfMonth := CALCDATE('<CM>');
        DayOfMonth := CALCDATE(CustomerStatementSetup."Running Date", DayOfMonth);
        // WorkingDay := CalendarManagement.CalcNextWorkingDate(EmptyDF, DayOfMonth, SalesSetup."Cust. Stmt. Base Calendar"); // BC Upgrade BHARDA11 --- commented(Fn-CalcNextWorkingDate is having fuctions called which are DIT customised) due to dependecy on DIT (showCheckCustomizedDateStatus)
        EXIT(WorkingDay);
    end;

    local procedure GetNextWeekWorkingDay(): Date;
    var
        CalendarManagement: Codeunit "Calendar Management";
        EmptyDF: DateFormula;
        DayOfWeek: Date;
        WorkingDay: Date;
    begin
        GetSalesSetup();

        DayOfWeek := CALCDATE('<-CW-1D>');
        DayOfWeek := CALCDATE(CustomerStatementSetup."Running Date", DayOfWeek);
        // WorkingDay := CalendarManagement.CalcNextWorkingDate(EmptyDF, DayOfWeek, SalesSetup."Cust. Stmt. Base Calendar"); // BC Upgrade BHARDA11 --- commented(Fn-CalcNextWorkingDate is having fuctions called which are DIT customised) due to dependecy on DIT (showCheckCustomizedDateStatus)
        IF WorkingDay > TODAY THEN
            EXIT(WorkingDay);

        DayOfWeek := CALCDATE('<CW>');
        DayOfWeek := CALCDATE(CustomerStatementSetup."Running Date", DayOfWeek);
        // WorkingDay := CalendarManagement.CalcNextWorkingDate(EmptyDF, DayOfWeek, SalesSetup."Cust. Stmt. Base Calendar"); // BC Upgrade BHARDA11 --- commented(Fn-CalcNextWorkingDate is having fuctions called which are DIT customised) due to dependecy on DIT (showCheckCustomizedDateStatus)
        EXIT(WorkingDay);
    end;
}

