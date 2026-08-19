codeunit 51024 "Send Email Cust.Statement CBN"
{
    // version HEI.01

    // HEI.01 CHG2228480-HB3631 COSTES04 02.08.2024 Sierra Leone Automate the separation of deposit and finish product
    //   # New object created
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
        CalendarManagement: Codeunit "Calendar Management";
        Monthly: Boolean;
        EndDate: Date;
        NextEarliestWorkingDate: Date;
        StartDate: Date;
        WorkingDay: Date;
        WorkingDay2: Date;
    begin
        CLEAR(Monthly);
        GetSalesSetup();
        SalesSetup.TESTFIELD("Cust. Stmt. Report Date FND");

        GetCustomerStatementMonthlySetup();
        GetCustomerStatementWeeklySetup();

        IF Rec."Parameter String" = 'MONTH' THEN
            Monthly := TRUE;

        IF Monthly THEN BEGIN
            EndDate := CALCDATE(CustomerStatementMonthlySetup."End Date", TODAY);
            StartDate := CALCDATE(CustomerStatementMonthlySetup."Start Date", EndDate);
        end else BEGIN
            EndDate := CALCDATE(CustomerStatementWeeklySetup."End Date", TODAY);
            StartDate := CALCDATE(CustomerStatementWeeklySetup."Start Date", EndDate);
        end;

        SendCustomersStatementEmail(StartDate, EndDate);

        //Setup Earliest Start Date/Time for next execution of Job Queue
        WorkingDay := GetNextMonthWorkingDay();
        WorkingDay2 := GetNextWeekWorkingDay();

        Monthly := FALSE;
        IF WorkingDay <= WorkingDay2 THEN BEGIN
            NextEarliestWorkingDate := WorkingDay;
            Monthly := TRUE;
        end else
            NextEarliestWorkingDate := WorkingDay2;


        Rec."Earliest Start Date/Time" := CREATEDATETIME(CALCDATE('<-1D>', NextEarliestWorkingDate), Rec."Starting Time");
        IF Monthly THEN
            Rec."Parameter String" := 'MONTH'
        else
            Rec."Parameter String" := '';
        Rec.MODIFY(FALSE);
    end;

    var
        CustomerStatementMonthlySetup: Record "Customer Statement Setup FND";
        CustomerStatementWeeklySetup: Record "Customer Statement Setup FND";
        SalesSetup: Record "Sales & Receivables Setup";
        Email: Codeunit Email;
        // SMTPMail: Codeunit 400; // BC Upgrade BHARDA11 --- Replace with Email Message
        SMTPMail: Codeunit "Email Message";
        SalesSetupRead: Boolean;
        CustLedgerEntriesErr: Label 'There are no Customer Ledger Entries for Customer No. %1 and Period %2';
        EmptyCustomerEmail: Label 'Email Address is mandatory for Customer %1.';
        OpenBalanceErr: Label 'There is no Open Balance at date %1 for customer %2.';

    local procedure SendCustomersStatementEmail(StartDate: Date; EndDate: Date);
    var
        Customer: Record Customer;
    begin
        GetSalesSetup();

        Customer.SETFILTER("Account Group FND", SalesSetup."Cust Stmt. Acc Grp Filter FND");
        Customer.SETFILTER(Blocked, '<>%1', Customer.Blocked::All);
        Customer.SETAUTOCALCFIELDS("Flag for Deletion FND");
        IF Customer.findset(false) THEN
            REPEAT
                IF NOT Customer."Flag for Deletion FND" THEN
                    SendMailGlobalCustStatementReport(StartDate, EndDate, Customer);
            UNTIL Customer.NEXT() = 0;
    end;

    procedure SendMailGlobalCustStatementReport(StartDate: Date; EndDate: Date; Customer: Record Customer);
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustomerReport: Record Customer;
        SendEmailGlobalStmtofCust: Report "Customer Statement SL CBN";
        SendEmailGlobalStmtofCustDeposit: Report "Customer Statement SL CBN";
        CustomLayoutReporting: Codeunit "Custom Layout Reporting";
        FileManagement: Codeunit "File Management";
        // BC Upgrade BHARDA11 >>
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        DepositEntiresCreated: Boolean;
        SalesEntriesCreated: Boolean;
        Content: File;
        InStr: InStream;
        OutStr: OutStream;
        FileName: Text;
        FileNameDeposit: Text;
        Period: Text;
    // BC Upgrade BHARDA11 <<
    begin
        CLEAR(SMTPMail);
        CLEAR(SendEmailGlobalStmtofCust);
        CLEAR(FileName);
        CLEAR(SalesEntriesCreated);
        CLEAR(DepositEntiresCreated);
        CustomerReport.SETRANGE("No.", Customer."No.");
        IF NOT CustomerReport.FINDFIRST() THEN
            EXIT;

        IF SalesSetup."Delete Cust. Email Log FND" THEN
            DeleteEmailCustomerLog(Customer."No.");

        IF NOT HasTransactions(Customer."No.", StartDate, EndDate) THEN BEGIN
            CreateEmailCustomerLog(Customer."No.", FALSE, 'No transactions in the period', StartDate, EndDate);
            EXIT;
        end;

        CustLedgerEntry.RESET();
        // CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Item Charge Type"); // BC Upgrade BHARDA11 ----Drink-IT Field ("Item Charge Type")
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date");
        CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
        CustLedgerEntry.SETRANGE("Posting Date", StartDate, EndDate);
        CustLedgerEntry.SETRANGE("Date Filter", StartDate, EndDate);
        // CustLedgerEntry.SETFILTER("Item Charge Type", '%1', CustLedgerEntry."Item Charge Type"::" "); // BC Upgrade BHARDA11 ----Drink-IT Field ("Item Charge Type")

        SalesEntriesCreated := TRUE;
        SendEmailGlobalStmtofCust.SETTABLEVIEW(CustomerReport);
        SendEmailGlobalStmtofCust.SETTABLEVIEW(CustLedgerEntry);
        SendEmailGlobalStmtofCust.SetPeriod(StartDate, EndDate);
        SendEmailGlobalStmtofCust.SetDeposit(FALSE);
        // Bc Upgrade BHARDA11 >>  ----
        // FileName := FileManagement.ServerTempFileName('pdf');
        // SendEmailGlobalStmtofCust.SAVEASPDF(FileName);
        // Bc Upgrade BHARDA11 <<
        Period := SendEmailGlobalStmtofCust.GetPeriod();


        // CustLedgerEntry.SETFILTER("Item Charge Type", '%1', CustLedgerEntry."Item Charge Type"::Deposit); // BC Upgrade BHARDA11 ----Drink-IT Field ("Item Charge Type")

        DepositEntiresCreated := TRUE;
        SendEmailGlobalStmtofCustDeposit.SETTABLEVIEW(CustomerReport);
        SendEmailGlobalStmtofCustDeposit.SETTABLEVIEW(CustLedgerEntry);
        SendEmailGlobalStmtofCustDeposit.SetPeriod(StartDate, EndDate);
        SendEmailGlobalStmtofCustDeposit.SetDeposit(TRUE);
        // BC Upgrade BHARDA11 >>
        TempBlob.CreateOutStream(OutStr);
        FileNameDeposit := StrSubstNo('Statement_%1.pdf', Customer."No.");
        SendEmailGlobalStmtofCustDeposit.SaveAs('', ReportFormat::Pdf, OutStr);
        // FileNameDeposit := FileManagement.ServerTempFileName('pdf'); // BC Upgrade BHARDA11 ---REplace With INStram & Outstream LOgic
        // SendEmailGlobalStmtofCustDeposit.SAVEASPDF(FileNameDeposit);
        // BC Upgrade BHARDA11 << 


        IF (NOT SalesEntriesCreated) AND (NOT DepositEntiresCreated) THEN
            EXIT;

        IF Customer."E-Mail" <> '' THEN BEGIN

            CreateEmailBody(Customer);

            IF SalesEntriesCreated THEN begin
                FileName := Customer.Name + ' Liquid Statement ' + Period + '.pdf';
                // SMTPMail.AddAttachment(FileName, Customer.Name + ' Liquid Statement ' + Period + '.pdf'); // BC Upgrade BHARDA11
                // BC Upgrade BHARDA11 >> 
                TempBlob.CreateInStream(InStr);
                SMTPMail.AddAttachment(FileName, 'pdf', InStr);
                // BC Upgrade BHARDA11 <<
            end;


            IF DepositEntiresCreated THEN begin
                FileName := Customer.Name + ' Empties Statement ' + Period + '.pdf';
                // SMTPMail.AddAttachment(FileNameDeposit, Customer.Name + ' Empties Statement ' + Period + '.pdf'); // BC Upgrade BHARDA11
                // BC Upgrade BHARDA11 >> 
                TempBlob.CreateInStream(InStr);
                SMTPMail.AddAttachment(FileName, 'pdf', InStr);
                // BC Upgrade BHARDA11 <<
            end;

            // IF SMTPMail.TrySend THEN // BC Upgrade BHARDA11
            if Email.Send(SMTPMail, Enum::"Email Scenario"::Default) then
                CreateEmailCustomerLog(Customer."No.", TRUE, 'Success', StartDate, EndDate)
            else
                // CreateEmailCustomerLog(Customer."No.", FALSE, COPYSTR(SMTPMail.GetLastSendMailErrorText, 1, 100), StartDate, EndDate); // BC Upgrade BHARDA11 --REplace GetLastSendMailErrorText with Getlasterrortext
                CreateEmailCustomerLog(Customer."No.", FALSE, COPYSTR(GetLastErrorText, 1, 100), StartDate, EndDate);

        end else
            CreateEmailCustomerLog(Customer."No.", FALSE, STRSUBSTNO(EmptyCustomerEmail, Customer."No."), StartDate, EndDate);
        COMMIT();
    end;

    procedure SendManualCustomerStatementEmail(var CustomerEmailLog: Record 50268);
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        SendEmailGlobalStmtofCust: Report "Customer Statement SL CBN";
        SendEmailGlobalStmtofCustDeposit: Report "Customer Statement SL CBN";
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        DepositExits: Boolean;
        SalesExist: Boolean;
        InsStr: InStream;
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

        CustLedgerEntry.RESET();
        // CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Item Charge Type"); // BC Upgrade BHARDA11 ----Drink-IT Field ("Item Charge Type")
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date");
        CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
        CustLedgerEntry.SETRANGE("Posting Date", CustomerEmailLog."Period From", CustomerEmailLog."Period To");
        CustLedgerEntry.SETRANGE("Date Filter", CustomerEmailLog."Period From", CustomerEmailLog."Period To");
        // CustLedgerEntry.SETFILTER("Item Charge Type", '%1', CustLedgerEntry."Item Charge Type"::" ");  // BC Upgrade BHARDA11 ----Drink-IT Field ("Item Charge Type")

        SalesExist := TRUE;
        SendEmailGlobalStmtofCust.SETTABLEVIEW(Customer);
        SendEmailGlobalStmtofCust.SETTABLEVIEW(CustLedgerEntry);
        SendEmailGlobalStmtofCust.SetPeriod(CustomerEmailLog."Period From", CustomerEmailLog."Period To");
        SendEmailGlobalStmtofCust.SetDeposit(FALSE);
        // BC Upgrade BHARDA11 >> --REmove old ServerTempFileName logic and repace with new version
        // FileName := FileManagement.ServerTempFileName('pdf');
        // SendEmailGlobalStmtofCust.SAVEASPDF(FileName);
        TempBlob.CreateOutStream(OutStr);
        SendEmailGlobalStmtofCust.SaveAs('', ReportFormat::Pdf, OutStr);
        // BC Upgrade BHARDA11 <<
        Period := SendEmailGlobalStmtofCust.GetPeriod();

        // CustLedgerEntry.SETFILTER("Item Charge Type", '%1', CustLedgerEntry."Item Charge Type"::Deposit); // BC Upgrade BHARDA11 ----Drink-IT Field ("Item Charge Type")
        IF NOT CustLedgerEntry.ISEMPTY THEN BEGIN
            DepositExits := TRUE;
            SendEmailGlobalStmtofCustDeposit.SETTABLEVIEW(Customer);
            SendEmailGlobalStmtofCustDeposit.SETTABLEVIEW(CustLedgerEntry);
            SendEmailGlobalStmtofCustDeposit.SetPeriod(CustomerEmailLog."Period From", CustomerEmailLog."Period To");
            SendEmailGlobalStmtofCustDeposit.SetDeposit(TRUE);
            // BC Upgrade BHARDA11 >> 
            // FileNameDeposit := FileManagement.ServerTempFileName('pdf');
            // SendEmailGlobalStmtofCustDeposit.SAVEASPDF(FileNameDeposit);
            TempBlob.CreateOutStream(OutStr);
            SendEmailGlobalStmtofCust.SaveAs('', ReportFormat::Pdf, OutStr);
            // BC Upgrade BHARDA11 <<
            Period := SendEmailGlobalStmtofCust.GetPeriod();
        end;

        CreateEmailBody(Customer);

        IF SalesExist THEN begin
            // SMTPMail.AddAttachment(FileName, Customer.Name + ' Liquid Statement ' + Period + '.pdf');
            FileName := Customer.Name + ' Liquid Statement ' + Period + '.pdf';
            // BC Upgrade BHARDA11 >> 
            TempBlob.CreateInStream(InsStr);
            SMTPMail.AddAttachment(FileName, 'pdf', InsStr);
            // BC Upgrade BHARDA11 <<
        end;

        IF DepositExits THEN begin
            // SMTPMail.AddAttachment(FileNameDeposit, Customer.Name + ' Empties Statement ' + Period + '.pdf');
            // BC Upgrade BHARDA11 >> 
            FileName := Customer.Name + ' Empties Statement ' + Period + '.pdf';
            TempBlob.CreateInStream(InsStr);
            SMTPMail.AddAttachment(FileName, 'pdf', InsStr);
            // BC Upgrade BHARDA11 <<
        end;

        // IF SMTPMail.TrySend THEN BEGIN // BC Upgrade BHARDA11 
        if Email.Send(SMTPMail, Enum::"Email Scenario"::Default) then begin // BC Upgrade BHARDA11 
            CustomerEmailLog."Report Sent" := TRUE;
            CustomerEmailLog.DateTime := CURRENTDATETIME;
            CustomerEmailLog."Error Message" := 'Success';
            CustomerEmailLog.MODIFY();
        end else BEGIN
            CustomerEmailLog."Report Sent" := FALSE;
            CustomerEmailLog.DateTime := CURRENTDATETIME;
            // CustomerEmailLog."Error Message" := COPYSTR(SMTPMail.GetLastSendMailErrorText, 1, MAXSTRLEN(CustomerEmailLog."Error Message")); // BC Upgrade BHARDA11 ----Replace GetLastSendMailErrorText with Getlasterortext
            CustomerEmailLog."Error Message" := COPYSTR(GetLastErrorText, 1, MAXSTRLEN(CustomerEmailLog."Error Message"));
            CustomerEmailLog.MODIFY();
        end;
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

    local procedure CreateEmailBody(Customer: Record Customer);
    var
        // StandardTextReport: Record 2014410; // BC Upgrade BHARDA11 ----Drink-IT Table ("StandardTextReport")
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        // Language: Record Language; // BC Upgrade BHARDA11
        LanguageMgt: Codeunit Language;
        MailBody: Text;
        MailSubject: Text;
    begin
        // BC Upgrade BHARDA11 >> ----Drink-IT Table ("StandardTextReport")
        // StandardTextReport.RESET;
        // StandardTextReport.SETRANGE("Report ID", 50559);
        // StandardTextReport.FINDFIRST;
        // BC Upgrade BHARDA11 << ----Drink-IT Table ("StandardTextReport")
        ExtendedTextHeader.RESET();
        // ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code"); // BC Upgrade BHARDA11 << ----Drink-IT Table ("StandardTextReport")
        // ExtendedTextHeader.SETRANGE("Language Code", Language.GetUserLanguage);
        ExtendedTextHeader.SETRANGE("Language Code", Format(LanguageMgt.GetLanguageIdOrDefault(Customer."Language Code"))); // BC Upgrade BHARDA11
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
        IF ExtendedTextLine.findset() THEN
            REPEAT
                MailSubject := ExtendedTextLine.Text + ' ' + Customer.Name;
                // SMTPMail.CreateMessage('', SalesSetup."Cust. Stmt. Email Address", Customer."E-Mail", MailSubject, '', TRUE);
                SMTPMail.Create(Customer."E-Mail", MailSubject, '', TRUE);
            UNTIL ExtendedTextLine.NEXT() = 0;

        //add body
        ExtendedTextHeader.SETFILTER(Description, '<>%1', 'Subject');
        ExtendedTextHeader.findset(false);
        REPEAT
            ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
            ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
            ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
            IF ExtendedTextLine.findset() THEN
                REPEAT
                    SMTPMail.AppendToBody(ExtendedTextLine.Text);
                    SMTPMail.AppendToBody('<br><Br>');
                UNTIL ExtendedTextLine.NEXT() = 0;
        UNTIL ExtendedTextHeader.NEXT() = 0;
    end;

    local procedure GetSalesSetup();
    begin
        IF NOT SalesSetupRead THEN
            SalesSetup.GET();

        SalesSetupRead := TRUE;
    end;

    local procedure GetCustomerStatementMonthlySetup();
    begin
        CustomerStatementMonthlySetup.SETRANGE(Frequency, CustomerStatementMonthlySetup.Frequency::Monthly);
        CustomerStatementMonthlySetup.FINDFIRST();
    end;

    local procedure GetCustomerStatementWeeklySetup();
    begin
        CustomerStatementWeeklySetup.SETRANGE(Frequency, CustomerStatementWeeklySetup.Frequency::Weekly);
        CustomerStatementWeeklySetup.FINDFIRST();
    end;

    local procedure HasTransactions(CustomerNo: Code[20]; PeriodFrom: Date; PeriodTo: Date): Boolean;
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        BalanceAmount: Decimal;
    begin
        CustLedgerEntry.RESET();
        // CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Item Charge Type"); // BC Upgrade BHARDA11 ----Drink-IT Field ("Item Charge Type")
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date");
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

    local procedure GetNextMonthWorkingDay(): Date;
    var
        CalendarManagement: Codeunit "Calendar Management";
        EmptyDF: DateFormula;
        DayOfMonth: Date;
        WorkingDay: Date;
    begin
        GetSalesSetup();

        DayOfMonth := CALCDATE('<-CM-1D>');
        DayOfMonth := CALCDATE(CustomerStatementMonthlySetup."Running Date", DayOfMonth);
        // WorkingDay := CalendarManagement.CalcNextWorkingDate(EmptyDF, DayOfMonth, SalesSetup."Cust. Stmt. Base Calendar"); // BC Upgrade BHARDA11 --- commented(Fn-CalcNextWorkingDate is having fuctions called which are DIT customised) due to dependecy on DIT (showCheckCustomizedDateStatus)
        IF WorkingDay > TODAY THEN
            EXIT(WorkingDay);

        DayOfMonth := CALCDATE('<CM>');
        DayOfMonth := CALCDATE(CustomerStatementMonthlySetup."Running Date", DayOfMonth);
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
        DayOfWeek := CALCDATE(CustomerStatementWeeklySetup."Running Date", DayOfWeek);
        // WorkingDay := CalendarManagement.CalcNextWorkingDate(EmptyDF, DayOfWeek, SalesSetup."Cust. Stmt. Base Calendar"); // BC Upgrade BHARDA11 --- commented(Fn-CalcNextWorkingDate is having fuctions called which are DIT customised) due to dependecy on DIT (showCheckCustomizedDateStatus)
        IF WorkingDay > TODAY THEN
            EXIT(WorkingDay);

        DayOfWeek := CALCDATE('<CW>');
        DayOfWeek := CALCDATE(CustomerStatementWeeklySetup."Running Date", DayOfWeek);
        // WorkingDay := CalendarManagement.CalcNextWorkingDate(EmptyDF, DayOfWeek, SalesSetup."Cust. Stmt. Base Calendar"); // BC Upgrade BHARDA11 --- commented(Fn-CalcNextWorkingDate is having fuctions called which are DIT customised) due to dependecy on DIT (showCheckCustomizedDateStatus)
        EXIT(WorkingDay);
    end;
}

