codeunit 51015 "Send EMail with Attachment CBN"
{
    // version HEI.01

    //BC Upgrade KUMBHS03 table and field are related to DITW Blocked 11032026 >>
    // HEI.01 RFC-CHG0248455 IBM.LS 14.12.2018
    //   # Code added to send E-Mail with attachment by Job Queue.
    //   # Code added to execute the report by Job Queue.
    // HEI.02 CHG2042028 IBM.MATHEJ01 09.12.2019 Correction subject and text of the email sent from Expiry Notification
    //   # Updated TextConstants value: TextL003, TextL004, TextL005
    // HEI.03 IBM.AK 08.04.21 CHG2072471
    //   # commented the condition to send emails on particular day from inventory setup, configured only based on setup- Jobqueues now
    //   # Company Name & Enviroment added to Mail text
    // HEI.04 CHG2136952 HB2677 IBM BHANDS01 01.12.2021 Update Global Statement.
    //   # Added new function SendMailGlobalCustStatementReport() .


    //BC Upgrade KUMBHS03 commented 11032026 old code>>
    // trigger OnRun();
    // var
    //     InventorySetupL : Record "Inventory Setup";
    //     DateL : Record Date;
    //     SMTPMailSetupL : Record "SMTP Mail Setup";
    //     CompanyInformationL : Record "Company Information";
    //     ItemAvailabilitybyQualityL : Report "Item Availability by Quality";
    //     FileNamePdfL : Text[250];
    //     FileNameExcelL : Text[250];
    //     FileManagementL : Codeunit "File Management";
    //     SMTPMailL : Codeunit "SMTP Mail";
    //     SenderEmailL : Text[100];
    //     RecipientsL : Text;
    //     TextL000 : Label 'There is no Sender E-mail address available neither in "SMTP Mail Setup", nor "Company Information". Please add it before sending the mail.';
    //     TextL001 : Label 'There is no Recipient''s E-mail address available in "User Setup" for Linked Users of "Organizational Role" page. Please add it before sending the mail.';
    //     TextL002 : Label 'There is no E-mail address available for this Requester %1 in "User Setup". Please add it before sending the mail.';
    //     TextL003 : Label 'Automatic email Expiry Notification';
    //     TextL004 : Label 'This email was automatically generated, please do not reply!';
    //     TextL005 : Label '"Please find attached the ""Item Availability by Quality"" report; with a list of lots approaching expiry and lots which are expired."';
    //     TextL006 : Label 'Item Availability by Quality_';
    //     TextL007 : Label 'Company Name:';
    //     TextL008 : Label 'Environment:';
    // begin
    //     //HEI.01>>
    //     InventorySetupL.GET;
    //     if InventorySetupL."Active Best Before Date" then begin
    //       DateL.SETRANGE("Period Type",DateL."Period Type"::Date);
    //       DateL.SETRANGE("Period Start",TODAY);
    //       if DateL.FINDFIRST then begin
    //         //IF DateL."Period Name" = FORMAT(InventorySetupL."Send E-Mail on Day") THEN BEGIN //HEI.03
    //           SMTPMailSetupL.GET;
    //           CompanyInformationL.GET;
    //           if SMTPMailSetupL."User ID" <> '' then
    //             SenderEmailL := SMTPMailSetupL."User ID"
    //           else
    //             SenderEmailL := CompanyInformationL."E-Mail";
    //           if SenderEmailL = '' then
    //             ERROR(TextL000);

    //           FileNameExcelL := COPYSTR(FileManagementL.ServerTempFileName('xlsx'),1,240);
    //           RecipientsL := ItemAvailabilitybyQualityL.InitAutoEmailOnWarningThreshold(true,true);
    //           ItemAvailabilitybyQualityL.SAVEASEXCEL(FileNameExcelL);

    //           if RecipientsL = '' then
    //             ERROR(TextL001);
    //           SMTPMailL.CreateMessage('',
    //                                   SenderEmailL,
    //                                   RecipientsL,
    //                                   TextL003,
    //                                   '',
    //                                   true);
    //           SMTPMailL.AddAttachment(FileNameExcelL,TextL006 + FORMAT(TODAY,0,'<Day,2>-<Month,2>-<Year4>') + '.xlsx');
    //           //HEI.03<<
    //           SMTPMailL.AppendBody(TextL007+' '+CompanyInformationL.Name);
    //           SMTPMailL.AppendBody('<br><br>');
    //           SMTPMailL.AppendBody(TextL008+' '+CompanyInformationL."Custom System Indicator Text");
    //           SMTPMailL.AppendBody('<br><br>');
    //           //HEI.03>>
    //           SMTPMailL.AppendBody(TextL004);
    //           SMTPMailL.AppendBody('<br><br>');
    //           SMTPMailL.AppendBody(TextL005);
    //           SMTPMailL.AppendBody('<br><br>');
    //           SMTPMailL.Send;
    //         end else begin
    //           FileNamePdfL := COPYSTR(FileManagementL.ServerTempFileName('pdf'),1,240);
    //           ItemAvailabilitybyQualityL.InitAutoEmailOnWarningThreshold(true,false);
    //           ItemAvailabilitybyQualityL.SAVEASPDF(FileNamePdfL);
    //         end;
    //      // END; //HEI.03
    //     end;
    //     //HEI.01<<
    // end;
    //BC Upgrade KUMBHS03 commented 11032026 old code<<


    //BC Upgrade KUMBHS03 added 11032026 new code<<
    trigger OnRun()
    var
        InventorySetupL: Record "Inventory Setup";
        DateL: Record Date;
        CompanyInformationL: Record "Company Information";
        ItemAvailabilitybyQualityL: Report "Item Availability by Qua CBN";
        RecipientsL: Text;
        SenderEmailL: Text[100];
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: InStream;
        BodyText: Text;
        ItemAvailabilityReportId: Integer;
        RecRef: RecordRef;
        TextL000: Label 'There is no Sender E-mail address available neither in "SMTP Mail Setup", nor "Company Information". Please add it before sending the mail.';
        TextL001: Label 'There is no Recipient''s E-mail address available. Please add it before sending the mail.';
        TextL003: Label 'Automatic email Expiry Notification';
        TextL004: Label 'This email was automatically generated, please do not reply!';
        TextL005: Label 'Please find attached the "Item Availability by Quality" report; with a list of lots approaching expiry and lots which are expired.';
        TextL006: Label 'Item Availability by Quality_';
        TextL007: Label 'Company Name:';
        TextL008: Label 'Environment:';
    begin
        InventorySetupL.GET;
        if InventorySetupL."Active Best Before Date FND" then begin
            DateL.SETRANGE("Period Type", DateL."Period Type"::Date);
            DateL.SETRANGE("Period Start", TODAY);
            if DateL.FINDFIRST then begin
                RecipientsL := '';
                // RecipientsL := ItemAvailabilitybyQualityL.InitAutoEmailOnWarningThreshold(true,true); //In this report Blocked entire procedure InitAutoEmailOnWarningThreshold() because 2C objects is used inside this procedure.
                if RecipientsL = '' then
                    Error(TextL001);

                CompanyInformationL.GET;
                SenderEmailL := CompanyInformationL."E-Mail";
                if SenderEmailL = '' then
                    ERROR(TextL000);

                BodyText :=
                    TextL007 + ' ' + CompanyInformationL.Name + '<br><br>' +
                    TextL008 + ' ' + CompanyInformationL."Custom System Indicator Text" + '<br><br>' +
                    TextL004 + '<br><br>' +
                    TextL005;

                EmailMessage.Create(RecipientsL, TextL003, BodyText, true);


                TempBlob.CreateOutStream(OutStream);
                ItemAvailabilityReportId := Report::"Item Availability by Qua CBN";
                Report.SaveAs(ItemAvailabilityReportId, '', ReportFormat::Excel, OutStream, RecRef);

                TempBlob.CreateInStream(InStream);
                //EmailMessage.AddAttachment(InStream, //BC Upgrade Commented KUMBHS03 11032026
                EmailMessage.AddAttachment('',  //BC Upgrade added KUMBHS03 11032026
                    TextL006 + Format(Today, 0, '<Day,2>-<Month,2>-<Year4>') + '.xlsx',
                    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');

                Email.Send(EmailMessage);
            end else begin

                TempBlob.CreateOutStream(OutStream);
                ItemAvailabilityReportId := Report::"Item Availability by Qua CBN";
                Report.SaveAs(ItemAvailabilityReportId, '', ReportFormat::Pdf, OutStream, RecRef);
            end;
        end;
    end;

    var
        BodyText: Text;
    //BC Upgrade KUMBHS03 added 11032026  new code<<


    //BC Upgrade KUMBHS03 commented old code 11032026 >>
    //procedure SendMailGlobalCustStatementReport(StartDateP : Date;EndDateP : Date;OpenEntriesP : Boolean;NewReportTypeP : Option Full,Liquids,Deposit;PeriodLengthP : DateFormula;DateChoiceP : Option "Due Date","Document Date","Posting Date";SupportedOutputMethodP : Option Print,Preview,Word,PDF,Email,XML;ChosenOutputMethodP : Integer;PrintRemainingP : Boolean;CustomerP : Record Customer);
    // var
    //     CompanyInformation : Record "Company Information";
    //     SendEmailGlobalStmtofCust : Report "Send Email Global Stmt of Cust";
    //     RequestParameters : Text;
    //     StandardTextReport : Record "Standard Text Report";
    //     ExtendedTextHeader : Record "Extended Text Header";
    //     ExtendedTextLine : Record "Extended Text Line";
    //     Language : Record Language;
    //     FileName : Text;
    //     FileManagement : Codeunit "File Management";
    //     CustomLayoutReporting : Codeunit "Custom Layout Reporting";
    //     SMTPMail : Codeunit "SMTP Mail";
    //     MailSubject : Text;
    //     MailBody : Text;
    //     Content : File;
    //     OStream : OutStream;
    //     CustLedgerEntry : Record "Cust. Ledger Entry";
    // begin
    //     //HEI.04 >>
    //     CLEAR(SMTPMail);
    //     CLEAR(SendEmailGlobalStmtofCust);
    //     CLEAR(RequestParameters);
    //     CLEAR(FileName);
    //     CLEAR(MailSubject);
    //     CLEAR(MailBody);

    //     if SupportedOutputMethodP = SupportedOutputMethodP::Email then begin
    //        SupportedOutputMethodP := SupportedOutputMethodP::Preview;
    //        ChosenOutputMethodP := CustomLayoutReporting.GetPreviewOption;
    //     end;

    //     SendEmailGlobalStmtofCust.InitAllParameters(StartDateP,EndDateP,OpenEntriesP,NewReportTypeP,PeriodLengthP,DateChoiceP,SupportedOutputMethodP,ChosenOutputMethodP,PrintRemainingP,CustomerP."No.");

    //     CustLedgerEntry.RESET;
    //     CustLedgerEntry.SETCURRENTKEY("Customer No.","Posting Date","Item Charge Type");
    //     CustLedgerEntry.SETRANGE("Customer No.",CustomerP."No.");
    //     CustLedgerEntry.SETRANGE("Posting Date",StartDateP,EndDateP);
    //     CustLedgerEntry.SETRANGE("Date Filter",StartDateP,EndDateP);

    //     if NewReportTypeP = NewReportTypeP::Full then begin
    //       CustLedgerEntry.SETFILTER(CustLedgerEntry."Item Charge Type",'%1|%2',CustLedgerEntry."Item Charge Type"::" ",CustLedgerEntry."Item Charge Type"::Deposit);
    //     end else if NewReportTypeP = NewReportTypeP::Liquids then begin
    //       CustLedgerEntry.SETRANGE(CustLedgerEntry."Item Charge Type",CustLedgerEntry."Item Charge Type"::" ");
    //     end else if NewReportTypeP = NewReportTypeP::Deposit then begin
    //       CustLedgerEntry.SETRANGE(CustLedgerEntry."Item Charge Type",CustLedgerEntry."Item Charge Type"::Deposit);
    //     end;
    //     if not CustLedgerEntry.ISEMPTY then begin
    //       FileName := FileManagement.ServerTempFileName('pdf');
    //       SendEmailGlobalStmtofCust.SAVEASPDF(FileName);
    //       CompanyInformation.GET;

    //       if CustomerP."E-Mail" <> '' then begin
    //         StandardTextReport.RESET;
    //         StandardTextReport.SETRANGE("Report ID",50504);
    //         if StandardTextReport.FINDFIRST then begin
    //           ExtendedTextHeader.RESET;
    //           ExtendedTextHeader.SETRANGE("No.",StandardTextReport."Standard Text Code");
    //           ExtendedTextHeader.SETRANGE("Language Code",Language.GetUserLanguage);
    //           if not ExtendedTextHeader.FINDFIRST then begin
    //             ExtendedTextHeader.SETRANGE("Language Code");
    //             ExtendedTextHeader.SETRANGE("All Language Codes",true);
    //             if not ExtendedTextHeader.FINDFIRST then
    //             ExtendedTextHeader.SETRANGE("All Language Codes");
    //           end;
    //             ExtendedTextHeader.SETFILTER(Description,'%1','Subject');
    //             if ExtendedTextHeader.FINDFIRST then begin
    //               ExtendedTextLine.SETRANGE("No.",ExtendedTextHeader."No.");
    //               ExtendedTextLine.SETRANGE("Text No.",ExtendedTextHeader."Text No.");
    //               ExtendedTextLine.SETRANGE("Language Code",ExtendedTextHeader."Language Code");
    //               if ExtendedTextLine.FINDSET then
    //                 repeat
    //                   MailSubject := ExtendedTextLine.Text + ' ' + CustomerP.Name;
    //                   SMTPMail.CreateMessage(CompanyInformation.Name,CompanyInformation."E-Mail",CustomerP."E-Mail",MailSubject,'',true);
    //                 until ExtendedTextLine.NEXT = 0;
    //             end;
    //             ExtendedTextHeader.SETFILTER(Description,'<>%1','Subject');
    //             if ExtendedTextHeader.FINDSET then
    //               repeat
    //                 ExtendedTextLine.SETRANGE("No.",ExtendedTextHeader."No.");
    //                 ExtendedTextLine.SETRANGE("Text No.",ExtendedTextHeader."Text No.");
    //                 ExtendedTextLine.SETRANGE("Language Code",ExtendedTextHeader."Language Code");
    //                 if ExtendedTextLine.FINDSET then
    //                   repeat
    //                       SMTPMail.AppendBody(ExtendedTextLine.Text);
    //                       SMTPMail.AppendBody('<br><Br>');
    //                   until ExtendedTextLine.NEXT = 0;
    //               until ExtendedTextHeader.NEXT = 0;
    //         end;
    //         SMTPMail.AddAttachment(FileName,'Statement for ' + CustomerP.Name +' as of ' + FORMAT(TODAY) + '.pdf');
    //         SMTPMail.Send;
    //       end else
    //         ERROR('Customer Email is blank');
    //     end;
    //     //HEI.04 <<
    // end;
    //BC Upgrade KUMBHS03 commented od code 11032026 <<


    //BC Upgrade KUMBHS03 added new code 12032026 >>
    procedure SendMailGlobalCustStatementReport(StartDateP: Date; EndDateP: Date; OpenEntriesP: Boolean; NewReportTypeP: Option Full,Liquids,Deposit; PeriodLengthP: DateFormula; DateChoiceP: Option "Due Date","Document Date","Posting Date"; SupportedOutputMethodP: Option Print,Preview,Word,PDF,Email,XML; ChosenOutputMethodP: Integer; PrintRemainingP: Boolean; CustomerP: Record Customer)
    var
        CompanyInformation: Record "Company Information";
        SendEmailGlobalStmtofCust: Report "SendEmail Cust Stmt Global CBN";
        //StandardTextReport: Record "Standard Text Report";
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        Language: Record Language;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustomLayoutReporting: Codeunit "Custom Layout Reporting";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;

        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";


        MailSubject: Text;
        MailBody: Text;
    begin

        Clear(MailSubject);
        Clear(MailBody);

        if SupportedOutputMethodP = SupportedOutputMethodP::Email then begin
            SupportedOutputMethodP := SupportedOutputMethodP::Preview;
            ChosenOutputMethodP := CustomLayoutReporting.GetPreviewOption;
        end;

        SendEmailGlobalStmtofCust.InitAllParameters(
            StartDateP,
            EndDateP,
            OpenEntriesP,
            NewReportTypeP,
            PeriodLengthP,
            DateChoiceP,
            SupportedOutputMethodP,
            ChosenOutputMethodP,
            PrintRemainingP,
            CustomerP."No.");

        CustLedgerEntry.Reset();
        // CustLedgerEntry.SetCurrentKey("Customer No.", "Posting Date", "Item Charge Type");
        CustLedgerEntry.SetRange("Customer No.", CustomerP."No.");
        CustLedgerEntry.SetRange("Posting Date", StartDateP, EndDateP);
        CustLedgerEntry.SetRange("Date Filter", StartDateP, EndDateP);

        // if NewReportTypeP = NewReportTypeP::Full then
        //     CustLedgerEntry.SetFilter("Item Charge Type", '%1|%2',
        //         CustLedgerEntry."Item Charge Type"::" ",
        //         CustLedgerEntry."Item Charge Type"::Deposit)
        // else
        //     if NewReportTypeP = NewReportTypeP::Liquids then
        //         CustLedgerEntry.SetRange("Item Charge Type",
        //             CustLedgerEntry."Item Charge Type"::" ")
        //     else
        //         if NewReportTypeP = NewReportTypeP::Deposit then
        //             CustLedgerEntry.SetRange("Item Charge Type",
        //                 CustLedgerEntry."Item Charge Type"::Deposit);

        if not CustLedgerEntry.IsEmpty() then begin

            TempBlob.CreateOutStream(OutStr);

            Report.SaveAs(
                Report::"SendEmail Cust Stmt Global CBN",
                '',
                ReportFormat::Pdf,
                OutStr,
                CustLedgerEntry);

            TempBlob.CreateInStream(InStr);

            CompanyInformation.Get();

            if CustomerP."E-Mail" = '' then
                Error('Customer Email is blank');

            //      StandardTextReport.Reset();
            //      StandardTextReport.SetRange("Report ID", 50504);

            //  if StandardTextReport.FindFirst() then begin

            Language.Reset();
            Language.SETRANGE("Windows Language ID", GLOBALLANGUAGE);
            IF Language.FINDFIRST THEN;

            ExtendedTextHeader.Reset();
            //    ExtendedTextHeader.SetRange("No.", StandardTextReport."Standard Text Code");
            ExtendedTextHeader.SetRange("Language Code", Language.Code); //

            if not ExtendedTextHeader.FindFirst() then begin
                ExtendedTextHeader.SetRange("Language Code");
                ExtendedTextHeader.SetRange("All Language Codes", true);

                if not ExtendedTextHeader.FindFirst() then
                    ExtendedTextHeader.SetRange("All Language Codes");
            end;

            ExtendedTextHeader.SetFilter(Description, '%1', 'Subject');

            if ExtendedTextHeader.FindFirst() then begin
                ExtendedTextLine.SetRange("No.", ExtendedTextHeader."No.");
                ExtendedTextLine.SetRange("Text No.", ExtendedTextHeader."Text No.");
                ExtendedTextLine.SetRange("Language Code", ExtendedTextHeader."Language Code");

                if ExtendedTextLine.FindSet() then
                    repeat
                        MailSubject := ExtendedTextLine.Text + ' ' + CustomerP.Name;
                    until ExtendedTextLine.Next() = 0;
            end;

            ExtendedTextHeader.SetFilter(Description, '<>%1', 'Subject');

            if ExtendedTextHeader.FindSet() then
                repeat
                    ExtendedTextLine.SetRange("No.", ExtendedTextHeader."No.");
                    ExtendedTextLine.SetRange("Text No.", ExtendedTextHeader."Text No.");
                    ExtendedTextLine.SetRange("Language Code", ExtendedTextHeader."Language Code");

                    if ExtendedTextLine.FindSet() then
                        repeat
                            MailBody += ExtendedTextLine.Text + '<br><br>';
                        until ExtendedTextLine.Next() = 0;

                until ExtendedTextHeader.Next() = 0;
        end;

        EmailMessage.Create(
            CustomerP."E-Mail",
            MailSubject,
            MailBody,
            true);

        EmailMessage.AddAttachment(
            'Statement for ' + CustomerP.Name + ' as of ' + Format(Today) + '.pdf',
            'application/pdf',
            InStr);

        Email.Send(EmailMessage);

    end;
    //end;
    //BC Upgrade KUMBHS03 added new code 12032026 >>
}

