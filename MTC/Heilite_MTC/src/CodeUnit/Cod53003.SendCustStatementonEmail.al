namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.Foundation.Calendar;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Setup;
using Microsoft.Foundation.Company;
using System.Threading;
using System.Email;
using System.Utilities;
using System.IO;
using Microsoft.Foundation.Reporting;

codeunit 53003 "Send Cust. Statement on Email"
{
    // HEI.01 HB2339 - CHG2109497 IBM NASTAA02 08.07.2021 # Customer Statements to be issued automatically at month end
    //   # New Codeunit created

    // BC Upgrade SHUKLP03 >> 
    // Nav old id - 50166
    // Replaced SMTP codeunit with Email and Email Message codeunit.
    // Blocked some part of code of OnRun() because procedure CalcNextWorkingDate() is not added as it is dependent on DIT procedure CheckCustomizedDateStatus(). 
    // BC Upgrade SHUKLP03 <<

    var
        SalesSetup: Record "Sales & Receivables Setup";
        CompanyInformation: Record "Company Information";

    trigger OnRun()
    var
        CalendarManagement: Codeunit "Calendar Management";
        JobQueueEntry: Record "Job Queue Entry";
        WorkingDay: Date;
        WorkingDayNextMonth: Date;
    begin
        //Find 3rd Working Day of the Month
        SalesSetup.GET();
        CompanyInformation.GET();

        // BC Upgrade SHUKLP03 >> Blocked code because procedure CalcNextWorkingDate() is not added as it is dependent on DIT procedure CheckCustomizedDateStatus(). 
        //WorkingDay := CalendarManagement.CalcNextWorkingDate(SalesSetup."Cust. Stmt. Report Date", CALCDATE('<-CM-1D>'), SalesSetup."Cust. Stmt. Base Calendar");
        // BC Upgrade SHUKLP03 << Blocked code because procedure CalcNextWorkingDate() is not added as it is dependent on DIT procedure CheckCustomizedDateStatus(). 

        //Send Customer Statement Report just for the 3rd Working Day of the Month
        IF WorkingDay = TODAY THEN
            SendCustomerStatementOnEmail();

        //Setup Earliest Start Date/Time for next execution of Job Queue
        // BC Upgrade SHUKLP03 >> Blocked code because procedure CalcNextWorkingDate() is not added as it is dependent on DIT procedure CheckCustomizedDateStatus(). 
        //WorkingDayNextMonth := CalendarManagement.CalcNextWorkingDate(SalesSetup."Cust. Stmt. Report Date", CALCDATE('<CM>'), SalesSetup."Cust. Stmt. Base Calendar");
        // BC Upgrade SHUKLP03 >> Blocked code because procedure CalcNextWorkingDate() is not added as it is dependent on DIT procedure CheckCustomizedDateStatus(). 

        JobQueueEntry.SETRANGE("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.SETRANGE("Object ID to Run", Codeunit::"Send Cust. Statement on Email");
        IF JobQueueEntry.FINDFIRST() THEN BEGIN
            JobQueueEntry.VALIDATE("Earliest Start Date/Time", CREATEDATETIME(CALCDATE('<-1D>', WorkingDayNextMonth), 0T));
            JobQueueEntry.MODIFY(TRUE);
        END;
    end;

    LOCAL procedure SendCustomerStatementOnEmail()
    var
        Customer: Record Customer;
        FailedCustomerNos: Text;
        SentCustomerEmails: Integer;
        //SMTPMail: Codeunit "SMTP Mail"; // BC Upgrade SHUKLP03 << Codeunit removed.
        EmailCU: Codeunit Email;  // BC Upgrade SHUKLP03 << 
        EmailMsg: Codeunit "Email Message";  // BC Upgrade SHUKLP03 << 
        MessageText: Text;
        MailSubjectTxt: Text[100];
        FileName: Text;
    begin
        Customer.SETFILTER("Account Group FND", SalesSetup."Cust Stmt. Acc Grp Filter FND");
        Customer.SETFILTER("E-Mail", '<>%1', '');
        IF Customer.FINDSET() THEN BEGIN
            REPEAT
                IF TrySendEmail(Customer) THEN
                    SentCustomerEmails += 1
                ELSE
                    FailedCustomerNos += Customer."No." + '|';
            UNTIL Customer.NEXT() = 0;

            //Send Summary Email
            //CLEAR(SMTPMail);
            CLEAR(MailSubjectTxt);
            CLEAR(MessageText);

            MailSubjectTxt := 'Summary Customer Statements Account sent ' + '_' + FORMAT(CALCDATE('<-CM-1D>'));
            IF SentCustomerEmails > 1 THEN
                MessageText := FORMAT(SentCustomerEmails) + ' Customer Statement Account Reports were sent successfully.' + '<br><br>'
            ELSE IF SentCustomerEmails = 1 THEN
                MessageText := FORMAT(SentCustomerEmails) + ' Customer Statement Account Report was sent successfully.' + '<br><br>';

            IF FailedCustomerNos <> '' THEN BEGIN
                MessageText += 'Email sending failed for next Customers: ' + '<br>';
                MessageText += DELSTR(FailedCustomerNos, STRLEN(FailedCustomerNos));
                MessageText += '<br><br>';
            END;

            // BC Upgrade SHUKLP03 >> Blocked SMTP code and replaced with Email and Email Messages codeunit.
            // SMTPMail.CreateMessage(CompanyInformation.Name, CompanyInformation."E-Mail", SalesSetup."Cust. Stmt. Email Address", MailSubjectTxt, MessageText, TRUE);
            // SMTPMail.Send;
            EmailMsg.Create(SalesSetup."Cust. Stmt. Email Address FND", MailSubjectTxt, MessageText, TRUE);
            EmailCU.Send(EmailMsg, Enum::"Email Scenario"::Default)
            // BC Upgrade SHUKLP03 << Blocked SMTP code and replaced with Email and Email Messages codeunit.

        END;
    end;

    [TryFunction]
    LOCAL procedure TrySendEmail(Customer: Record Customer)
    VAR
        //SMTPMail: Codeunit SMTP Mail	// BC Upgrade SHUKLP03 << Codeunit removed.
        MessageText: Text;
        MailSubjectTxt: Text[100];
        ReportSelections: Record "Report Selections";
        FileName: Text[250];
        FileManagement: Codeunit "File Management";
        CustomerStatementofAccount: Report "Customer Statement of Account";
        EmailCU: Codeunit Email;   // BC Upgrade SHUKLP03 << 
        EmailMsg: Codeunit "Email Message";  // BC Upgrade SHUKLP03 << 
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade SHUKLP03 <<
        InStr: InStream;   // BC Upgrade SHUKLP03 <<
        OutStr: OutStream; // BC Upgrade SHUKLP03 <<

    begin
        //CLEAR(SMTPMail);  / BC Upgrade SHUKLP03 << blocked because deprecated. 
        CLEAR(MailSubjectTxt);
        CLEAR(MessageText);
        CLEAR(CustomerStatementofAccount);

        //FileName := FileManagement.ServerTempFileName('pdf');  // BC Upgrade SHUKLP03 << blocked because deprecated.

        CustomerStatementofAccount.InitAllVariables(TRUE, TRUE, 0, CALCDATE('<-CM-1M>'), CALCDATE('<-CM-1D>'), SalesSetup."Cust. Stmt. Aging Interval FND", TRUE, Customer."No.");
        //CustomerStatementofAccount.SAVEASPDF(FileName);  // BC Upgrade SHUKLP03 << blocked because deprecated.

        // BC Upgrade SHUKLP03 >> Added code for BC Saas
        TempBlob.CreateOutStream(OutStr);
        CustomerStatementofAccount.SaveAs('', ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);
        // BC Upgrade SHUKLP03 << Added code for BC Saas

        MailSubjectTxt := 'Customer Statement Account ' + Customer.Name + '_' + FORMAT(CALCDATE('<-CM-1D>'));
        MessageText := 'Dear ' + Customer.Name + ',' + '<br><br>';
        MessageText += 'Please find the Customer Statement Account Report for the period end ' + FORMAT(CALCDATE('<-CM-1D>')) + '.' + '<br><br>';

        // BC Upgrade SHUKLP03 >> Added code for BC Saas.
        // SMTPMail.CreateMessage(CompanyInformation.Name, CompanyInformation."E-Mail", Customer."E-Mail", MailSubjectTxt, MessageText, TRUE);
        // SMTPMail.AddCC(SalesSetup."Cust. Stmt. Email Address");
        // SMTPMail.AddAttachment(FileName, Customer.Name + '.pdf');
        // SMTPMail.Send;
        EmailMsg.Create(Customer."E-Mail", MailSubjectTxt, MessageText, TRUE);
        EmailMsg.AddRecipient(Enum::"Email Recipient Type"::Cc, SalesSetup."Cust. Stmt. Email Address FND");
        EmailMsg.AddAttachment(FileName, 'application/pdf', InStr);
        EmailCU.Send(EmailMsg, Enum::"Email Scenario"::DEFAULT)
        // BC Upgrade SHUKLP03 << Added code for BC Saas.

    end;

}
