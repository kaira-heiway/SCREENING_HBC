codeunit 50077 "Follow Email pattern"
{
    // HEI.01 CHG2000416 IBM.AB 22.04.2019
    //   #new Codeunit created for Dunning Letter functionality

    // BC Upgrade BHARDA11 >>
    // 1. Change SMTP Mail to Email Message and Create one more variable to send email (Email: Codeunit Email;)
    // 2. Add new Local variable FileName1 in Functions (SendOpenCustomerEntries,SendEmail)
    // 3. Comment Unused functions (GenMailBody,GenerateEmailBody)
    // 4. Add (var NAVInStream: InStream) Peremeters in Function (GenMailAtt3,GenMailAttachment1,GenMailAttachment2,GenMailAttachment3) because here we we can add attachment threw instream.
    // 5. Comment old Createmesage and addattachment code and add new code.
    // BC Upgrade BHARDA11 <<
    // BC UPGRADE SHIKHD02 >>
    // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in procedures wherever required
    // BC UPGRADE SHIKHD02 <<

    trigger OnRun();
    begin
    end;

    var
        CompanyInformation: Record "Company Information";
        TempEmailItem: Record "Email Item" temporary;
        // BodyStream: OutStream;
        // SMTPMailSetup: Record "SMTP Mail Setup"; 
        // emailSetup: Record s
        // SMTPMail: Codeunit "SMTP Mail"; // BC Upgrade BHARDA11 ----Change "SMTP Mail" to "Email Message"
        Email: Codeunit Email; // BC Upgrade BHARDA11 ---- New Email Codeunit for sending

        SMTPMail: Codeunit "Email Message";
        InsStream: InStream;



    procedure SendOpenCustomerEntries(ReminderHeader: Record "Reminder Header"): Boolean;
    var
        // EmailBody: Record TempBlob;
        Cust: Record Customer;
        CustAttributes: Record "Customer Attributes FND";
        FileName1: Text; // BC Upgrade BHARDA11--- Add new variable
    begin
        CLEAR(TempEmailItem);
        // BC UPGRADE SHIKHD02 >> 
        // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases
        // with TempEmailItem do begin
        //     CustAttributes.RESET;
        //     CustAttributes.SETRANGE(CustAttributes."Customer No.", ReminderHeader."Customer No.");
        //     if CustAttributes.FINDFIRST then begin
        //         "Send to" := CustAttributes."Invoice Email Address";
        //     end;
        //     /*Subject := 'Sales Statistics';
        //     CLEAR(EmailBody);
        //     GenerateEmailBody(ReminderHeader,EmailBody);
        //     Body := EmailBody.Blob;
        //     "Attachment File Path" := GenerateEmailAttachment(ReminderHeader."Customer No.");
        //     "Attachment Name" := 'Dunning Letter 1.pdf';
        //     "Plaintext Formatted" := FALSE;
        //     //Send(TRUE);
        //     //EXIT(Send(TRUE));                               //Set FALSE is you want to see dialoug before sending
        //     CLEAR(BodyStream);
        //     */
        //     //Other Parameters
        //     //From Name               --Optional will be picked from setup as per user, Fill if using Job Queue.
        //     //From Address            --Optional will be picked from setup as per user, Fill if using Job Queue.
        //     //"Send CC" :=            -- Add CC Email Address if Required
        //     //"Send BCC" :=           -- Add BCC Email Address if Required
        //     CompanyInformation.GET();
        //     CompanyInformation.TESTFIELD("E-Mail");
        //     if ReminderHeader."Reminder Level" = 1 then begin
        //         // SMTPMailSetup.GET;
        //         SMTPMail.Create(CustAttributes."Invoice Email Address", 'Dunning Letter 1', STRSUBSTNO('Please find the attached', ReminderHeader.Name, CompanyInformation.Name), TRUE); // BC Upgrade BHARDA11 ::Aded
        //         // SMTPMail.CreateMessage('', CompanyInformation."E-Mail", CustAttributes."Invoice Email Address", 'Dunning Letter 1',
        //         //                       STRSUBSTNO('Please find the attached', ReminderHeader.Name, CompanyInformation.Name), true); // BC Upgrade BHARAD11 ::Blocked
        //         GenMailAttachment1(ReminderHeader."No.", InsStream, SMTPMail); // BC Upgrade BHARAD11 ::Added
        //         // SMTPMail.AddAttachment(FileName1, 'pdf', InsStream); // BC Upgrade BHARAD11 ::Added
        //         // SMTPMail.AddAttachment(GenMailAttachment1(ReminderHeader."No."), 'Dunning Letter 1' + FORMAT(WORKDATE) + '.PDF'); // BC Upgrade BHARAD11 ::Blocked
        //         // SMTPMail.Send; // BC Upgrade BHARAD11 ::Blocked
        //         // Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
        //     end;

        //     if ReminderHeader."Reminder Level" = 2 then begin
        //         // BC Upgrade BHARAD11 >> ::Blocked
        //         // SMTPMailSetup.GET; 
        //         // SMTPMail.CreateMessage('', CompanyInformation."E-Mail", CustAttributes."Invoice Email Address", 'Dunning Letter 2',
        //         //                       STRSUBSTNO('Please find the attached', ReminderHeader.Name, CompanyInformation.Name), true);
        //         // SMTPMail.AddAttachment(GenMailAttachment2(ReminderHeader."No."), 'Dunning Letter 2' + FORMAT(WORKDATE) + '.PDF');
        //         // SMTPMail.Send;
        //         // BC Upgrade BHARAD11 << ::Blocked
        //         // BC Upgrade BHARDA11 >> ----Adding new code
        //         SMTPMail.Create(CustAttributes."Invoice Email Address", 'Dunning Letter 2', STRSUBSTNO('Please find the attached', ReminderHeader.Name, CompanyInformation.Name), true);
        //         GenMailAttachment2(ReminderHeader."No.", InsStream, SMTPMail);

        //         // BC Upgrade BHARDA11 << ----Adding New Code
        //     end;

        //     if ReminderHeader."Reminder Level" = 3 then begin
        //         // BC Upgrade BHARDA11 >> ::Blocked
        //         // SMTPMailSetup.GET;
        //         // SMTPMail.CreateMessage('', CompanyInformation."E-Mail", CustAttributes."Invoice Email Address", 'Dunning Letter 3',
        //         //                       STRSUBSTNO('Please find the attached', Cust.Name, CompanyInformation.Name), true);
        //         // SMTPMail.AddAttachment(GenMailAtt3(ReminderHeader."No."), 'Dunning Letter 3' + FORMAT(WORKDATE) + '.PDF');
        //         // SMTPMail.Send;
        //         // BC Upgrade BHARDA11 << ::Blocked
        //         // BC Upgrade BHARDA11 >> ::Added
        //         SMTPMail.Create(CustAttributes."Invoice Email Address", 'Dunning Letter 3', STRSUBSTNO('Please find the attached', Cust.Name, CompanyInformation.Name), true);
        //         GenMailAtt3(ReminderHeader."No.", InsStream, SMTPMail);

        //         // BC Upgrade BHARDA11 << ::Added
        //     end;
        // end;
        CustAttributes.RESET;
        CustAttributes.SETRANGE(CustAttributes."Customer No.", ReminderHeader."Customer No.");
        if CustAttributes.FINDFIRST then begin
            TempEmailItem."Send to" := CustAttributes."Invoice Email Address";
        end;
        /*Subject := 'Sales Statistics';
        CLEAR(EmailBody);
        GenerateEmailBody(ReminderHeader,EmailBody);
        Body := EmailBody.Blob;
        "Attachment File Path" := GenerateEmailAttachment(ReminderHeader."Customer No.");
        "Attachment Name" := 'Dunning Letter 1.pdf';
        "Plaintext Formatted" := FALSE;
        //Send(TRUE);
        //EXIT(Send(TRUE));                               //Set FALSE is you want to see dialoug before sending
        CLEAR(BodyStream);
        */
        //Other Parameters
        //From Name               --Optional will be picked from setup as per user, Fill if using Job Queue.
        //From Address            --Optional will be picked from setup as per user, Fill if using Job Queue.
        //"Send CC" :=            -- Add CC Email Address if Required
        //"Send BCC" :=           -- Add BCC Email Address if Required
        CompanyInformation.GET();
        CompanyInformation.TESTFIELD("E-Mail");
        if ReminderHeader."Reminder Level" = 1 then begin
            // SMTPMailSetup.GET;
            SMTPMail.Create(CustAttributes."Invoice Email Address", 'Dunning Letter 1', STRSUBSTNO('Please find the attached', ReminderHeader.Name, CompanyInformation.Name), TRUE); // BC Upgrade BHARDA11 ::Aded
            // SMTPMail.CreateMessage('', CompanyInformation."E-Mail", CustAttributes."Invoice Email Address", 'Dunning Letter 1',
            //                       STRSUBSTNO('Please find the attached', ReminderHeader.Name, CompanyInformation.Name), true); // BC Upgrade BHARAD11 ::Blocked
            GenMailAttachment1(ReminderHeader."No.", InsStream, SMTPMail); // BC Upgrade BHARAD11 ::Added
            // SMTPMail.AddAttachment(FileName1, 'pdf', InsStream); // BC Upgrade BHARAD11 ::Added
            // SMTPMail.AddAttachment(GenMailAttachment1(ReminderHeader."No."), 'Dunning Letter 1' + FORMAT(WORKDATE) + '.PDF'); // BC Upgrade BHARAD11 ::Blocked
            // SMTPMail.Send; // BC Upgrade BHARAD11 ::Blocked
            // Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
        end;

        if ReminderHeader."Reminder Level" = 2 then begin
            // BC Upgrade BHARAD11 >> ::Blocked
            // SMTPMailSetup.GET; 
            // SMTPMail.CreateMessage('', CompanyInformation."E-Mail", CustAttributes."Invoice Email Address", 'Dunning Letter 2',
            //                       STRSUBSTNO('Please find the attached', ReminderHeader.Name, CompanyInformation.Name), true);
            // SMTPMail.AddAttachment(GenMailAttachment2(ReminderHeader."No."), 'Dunning Letter 2' + FORMAT(WORKDATE) + '.PDF');
            // SMTPMail.Send;
            // BC Upgrade BHARAD11 << ::Blocked
            // BC Upgrade BHARDA11 >> ----Adding new code
            SMTPMail.Create(CustAttributes."Invoice Email Address", 'Dunning Letter 2', STRSUBSTNO('Please find the attached', ReminderHeader.Name, CompanyInformation.Name), true);
            GenMailAttachment2(ReminderHeader."No.", InsStream, SMTPMail);

            // BC Upgrade BHARDA11 << ----Adding New Code
        end;

        if ReminderHeader."Reminder Level" = 3 then begin
            // BC Upgrade BHARDA11 >> ::Blocked
            // SMTPMailSetup.GET;
            // SMTPMail.CreateMessage('', CompanyInformation."E-Mail", CustAttributes."Invoice Email Address", 'Dunning Letter 3',
            //                       STRSUBSTNO('Please find the attached', Cust.Name, CompanyInformation.Name), true);
            // SMTPMail.AddAttachment(GenMailAtt3(ReminderHeader."No."), 'Dunning Letter 3' + FORMAT(WORKDATE) + '.PDF');
            // SMTPMail.Send;
            // BC Upgrade BHARDA11 << ::Blocked
            // BC Upgrade BHARDA11 >> ::Added
            SMTPMail.Create(CustAttributes."Invoice Email Address", 'Dunning Letter 3', STRSUBSTNO('Please find the attached', Cust.Name, CompanyInformation.Name), true);
            GenMailAtt3(ReminderHeader."No.", InsStream, SMTPMail);

            // BC Upgrade BHARDA11 << ::Added
        end;
        // BC UPGRADE SHIKHD02 <<
    end;

    procedure SendEmail(LIssuedReminder: Record "Issued Reminder Header"): Boolean;
    var
        // EmailBody: Record TempBlob;
        Cust: Record Customer;
        CustAttributes: Record "Customer Attributes FND";
        FileName1: Text; // BC Upgrade BHARDA11--- Add new variable
    begin
        CLEAR(TempEmailItem);
        //BC UPGRADE SHIKHD02 >>
        // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases
        // with TempEmailItem do begin
        //     CustAttributes.RESET;
        //     CustAttributes.SETRANGE(CustAttributes."Customer No.", LIssuedReminder."Customer No.");
        //     if CustAttributes.FINDFIRST then begin
        //         "Send to" := CustAttributes."Invoice Email Address";
        //     end;

        //     CompanyInformation.GET;
        //     CompanyInformation.TESTFIELD("E-Mail");

        //     if LIssuedReminder."Reminder Level" = 1 then begin
        //         // BC Upgrade BHARDA11 >> ::Blocked
        //         // SMTPMailSetup.GET;
        //         // SMTPMail.CreateMessage('', CompanyInformation."E-Mail", CustAttributes."Invoice Email Address", 'Dunning Letter 1',
        //         //                       STRSUBSTNO('Please find the attached', LIssuedReminder.Name, CompanyInformation.Name), true);
        //         // SMTPMail.AddAttachment(GenMailAttachment1(LIssuedReminder."No."), 'Dunning Letter 1' + FORMAT(WORKDATE) + '.PDF');
        //         // SMTPMail.Send;
        //         // BC Upgrade BHARDA11 << ::Blocked
        //         // BC Upgrade BHARDA11 >> ::Added
        //         SMTPMail.Create(CustAttributes."Invoice Email Address", 'Dunning Letter 1', STRSUBSTNO('Please find the attached', LIssuedReminder.Name, CompanyInformation.Name), true);
        //         GenMailAttachment1(LIssuedReminder."No.", InsStream, SMTPMail);
        //         // SMTPMail.AddAttachment(FileName1, 'pdf', InsStream);
        //         // Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
        //         // BC Upgrade BHARDA11 << ::Added
        //     end;

        //     if LIssuedReminder."Reminder Level" = 2 then begin
        //         // BC Upgrade BHARDA11 >> ::Blocked
        //         // SMTPMailSetup.GET;
        //         // SMTPMail.CreateMessage('', CompanyInformation."E-Mail", CustAttributes."Invoice Email Address", 'Dunning Letter 2',
        //         //                       STRSUBSTNO('Please find the attached', LIssuedReminder.Name, CompanyInformation.Name), true);
        //         // SMTPMail.AddAttachment(GenMailAttachment2(LIssuedReminder."No."), 'Dunning Letter 2' + FORMAT(WORKDATE) + '.PDF');
        //         // SMTPMail.Send;
        //         // BC Upgrade BHARDA11 << ::Blocked
        //         // BC Upgrade BHARDA11 >> ::Added
        //         SMTPMail.Create(CustAttributes."Invoice Email Address", 'Dunning Letter 2', STRSUBSTNO('Please find the attached', LIssuedReminder.Name, CompanyInformation.Name), true);
        //         GenMailAttachment2(LIssuedReminder."No.", InsStream, SMTPMail);
        //         // SMTPMail.AddAttachment(FileName1, 'pdf', InsStream);
        //         // Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
        //         // BC Upgrade BHARDA11 << ::Added
        //     end;

        //     if LIssuedReminder."Reminder Level" = 3 then begin
        //         // BC Upgrade BHARDA11 >> ::Blocked
        //         // SMTPMailSetup.GET;
        //         // SMTPMail.CreateMessage('', CompanyInformation."E-Mail", CustAttributes."Invoice Email Address", 'Dunning Letter 3',
        //         //                       STRSUBSTNO('Please find the attached', LIssuedReminder.Name, CompanyInformation.Name), true);
        //         // SMTPMail.AddAttachment(GenMailAttachment3(LIssuedReminder."No."), 'Dunning Letter 3' + FORMAT(WORKDATE) + '.PDF');
        //         // SMTPMail.Send;
        //         // BC Upgrade BHARDA11 << ::Blocked
        //         // BC Upgrade BHARDA11 >> ::Added
        //         SMTPMail.Create(CustAttributes."Invoice Email Address", 'Dunning Letter 3', STRSUBSTNO('Please find the attached', LIssuedReminder.Name, CompanyInformation.Name), true);
        //         GenMailAttachment3(LIssuedReminder."No.", InsStream, SMTPMail);

        //         // BC Upgrade BHARDA11 << ::Added
        //     end;
        // end;
        CustAttributes.RESET;
        CustAttributes.SETRANGE(CustAttributes."Customer No.", LIssuedReminder."Customer No.");
        if CustAttributes.FINDFIRST then begin
            TempEmailItem."Send to" := CustAttributes."Invoice Email Address";
        end;

        CompanyInformation.GET;
        CompanyInformation.TESTFIELD("E-Mail");

        if LIssuedReminder."Reminder Level" = 1 then begin
            // BC Upgrade BHARDA11 >> ::Blocked
            // SMTPMailSetup.GET;
            // SMTPMail.CreateMessage('', CompanyInformation."E-Mail", CustAttributes."Invoice Email Address", 'Dunning Letter 1',
            //                       STRSUBSTNO('Please find the attached', LIssuedReminder.Name, CompanyInformation.Name), true);
            // SMTPMail.AddAttachment(GenMailAttachment1(LIssuedReminder."No."), 'Dunning Letter 1' + FORMAT(WORKDATE) + '.PDF');
            // SMTPMail.Send;
            // BC Upgrade BHARDA11 << ::Blocked
            // BC Upgrade BHARDA11 >> ::Added
            SMTPMail.Create(CustAttributes."Invoice Email Address", 'Dunning Letter 1', STRSUBSTNO('Please find the attached', LIssuedReminder.Name, CompanyInformation.Name), true);
            GenMailAttachment1(LIssuedReminder."No.", InsStream, SMTPMail);
            // SMTPMail.AddAttachment(FileName1, 'pdf', InsStream);
            // Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
            // BC Upgrade BHARDA11 << ::Added
        end;

        if LIssuedReminder."Reminder Level" = 2 then begin
            // BC Upgrade BHARDA11 >> ::Blocked
            // SMTPMailSetup.GET;
            // SMTPMail.CreateMessage('', CompanyInformation."E-Mail", CustAttributes."Invoice Email Address", 'Dunning Letter 2',
            //                       STRSUBSTNO('Please find the attached', LIssuedReminder.Name, CompanyInformation.Name), true);
            // SMTPMail.AddAttachment(GenMailAttachment2(LIssuedReminder."No."), 'Dunning Letter 2' + FORMAT(WORKDATE) + '.PDF');
            // SMTPMail.Send;
            // BC Upgrade BHARDA11 << ::Blocked
            // BC Upgrade BHARDA11 >> ::Added
            SMTPMail.Create(CustAttributes."Invoice Email Address", 'Dunning Letter 2', STRSUBSTNO('Please find the attached', LIssuedReminder.Name, CompanyInformation.Name), true);
            GenMailAttachment2(LIssuedReminder."No.", InsStream, SMTPMail);
            // SMTPMail.AddAttachment(FileName1, 'pdf', InsStream);
            // Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
            // BC Upgrade BHARDA11 << ::Added
        end;

        if LIssuedReminder."Reminder Level" = 3 then begin
            // BC Upgrade BHARDA11 >> ::Blocked
            // SMTPMailSetup.GET;
            // SMTPMail.CreateMessage('', CompanyInformation."E-Mail", CustAttributes."Invoice Email Address", 'Dunning Letter 3',
            //                       STRSUBSTNO('Please find the attached', LIssuedReminder.Name, CompanyInformation.Name), true);
            // SMTPMail.AddAttachment(GenMailAttachment3(LIssuedReminder."No."), 'Dunning Letter 3' + FORMAT(WORKDATE) + '.PDF');
            // SMTPMail.Send;
            // BC Upgrade BHARDA11 << ::Blocked
            // BC Upgrade BHARDA11 >> ::Added
            SMTPMail.Create(CustAttributes."Invoice Email Address", 'Dunning Letter 3', STRSUBSTNO('Please find the attached', LIssuedReminder.Name, CompanyInformation.Name), true);
            GenMailAttachment3(LIssuedReminder."No.", InsStream, SMTPMail);

            // BC Upgrade BHARDA11 << ::Added
        end;
        // BC UPGRADE SHIKHD02 <<
    end;
    // BC Upgrade BHARDA11 >> ----This function not use anywhere
    /*  local procedure GenMailBody(LIssuedReminder: Record "Issued Reminder Header"; var BodyBlob: Record TempBlob);
     begin
         BodyBlob.Blob.CREATEOUTSTREAM(BodyStream);
         BodyStream.WRITETEXT('Dear ' + LIssuedReminder.Name);
         BodyStream.WRITETEXT('<br><br>');
         BodyStream.WRITETEXT('Please find attached.');
         BodyStream.WRITETEXT('<br><br>');
         BodyStream.WRITETEXT('Kind Regards,');
         BodyStream.WRITETEXT('<br>');
         BodyStream.WRITETEXT('OTC Collection & Dispute Administrator');
         BodyStream.WRITETEXT('<br><br>');
         //BodyStream.WRITETEXT('<HR>');
         //BodyStream.WRITETEXT('This is a system generated mail. Please do not reply to this email ID.');
     end; */
    // BC Upgrade BHARDA11 << ----This function not use anywhere
    // BC Upgrade BHARDA11 >> ---- This Function not Call anywhere 
    /*  local procedure GenerateEmailBody(ReminderHeader: Record "Reminder Header"; var BodyBlob: Record TempBlob);
     begin
         BodyBlob.Blob.CREATEOUTSTREAM(BodyStream);
         BodyStream.WRITETEXT('Dear ' + ReminderHeader.Name);
         BodyStream.WRITETEXT('<br><br>');
         BodyStream.WRITETEXT('Please find attached.');
         BodyStream.WRITETEXT('<br><br>');
         BodyStream.WRITETEXT('Kind Regards,');
         BodyStream.WRITETEXT('<br>');
         BodyStream.WRITETEXT('OTC Collection & Dispute Administrator');
         BodyStream.WRITETEXT('<br><br>');
         //BodyStream.WRITETEXT('<HR>');
         //BodyStream.WRITETEXT('This is a system generated mail. Please do not reply to this email ID.');
     end; */
    // BC Upgrade BHARDA11 << ---- This Function not Call anywhere 
    // local procedure GenMailAtt3(RemHeaderNo: Code[20]): Text; // BC Upgrade BHARDA11 ::Blocked
    local procedure GenMailAtt3(RemHeaderNo: Code[20]; var NAVInStream: InStream; EmailMess: Codeunit "Email Message") // BC Upgrade BHARDA11 ::Added Add peremeter
    var
        LRemHeader: Record "Reminder Header";
        LDunningLetter3: Report "Dunning Letter 3";
        LFilePath: Text;
        LFileManagement: Codeunit "File Management";
        // BC Upgrade BHARDA11 >> ----Add new variables
        filename: Text;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        NAVOutStream: OutStream;
    // BC Upgrade BHARDA11 << ----Add new variables.
    begin
        CLEAR(LFilePath);
        // LFilePath := COPYSTR(LFileManagement.ServerTempFileName('pdf'), 1, 250); // BC Upgrade BHARDA11 ::Blocked

        LRemHeader.RESET();
        LRemHeader.SETRANGE(LRemHeader."No.", RemHeaderNo);
        LRemHeader.FINDFIRST();
        CLEAR(LDunningLetter3);
        // BC Upgrade BHARAD11 >> ----Add New code
        Clear(TempBlob);
        TempBlob.CreateOutStream(NAVOutStream, TextEncoding::UTF8);
        RecRef.GetTable(LRemHeader);
        Report.SaveAs(Report::"Dunning Letter 3", '', REPORTFORMAT::Pdf, NAVOutStream, Recref);
        TempBlob.CreateInStream(NAVInStream);
        filename := CONVERTSTR('Dunning Letter 3' + FORMAT(WorkDate()), '/', '-') + '.pdf';
        EmailMess.AddAttachment(filename, 'pdf', NAVInStream);
        Email.Send(EmailMess, Enum::"Email Scenario"::Default);
        // BC Upgrade BHARDA11 << ----Add New code
        // BC Upgrade BHARDA11 >> :: Blocked
        // LDunningLetter3.SETTABLEVIEW(LRemHeader);
        // LDunningLetter3.SAVEASPDF(LFilePath);
        // exit(LFilePath);
        // BC Upgrade BHARDA11 << :: Blocked
    end;

    // local procedure GenMailAttachment1(LIssuedReminderNo: Code[20]): Text; // BC Upgrade BHARDA11 ----Change Peremeters add instream
    local procedure GenMailAttachment1(LIssuedReminderNo: Code[20]; Var NAVInStream: instream; EmailMessage: Codeunit "Email Message")
    var
        LIssuedReminder: Record "Issued Reminder Header";
        LDunningLetter1: Report "Dunning Letter 1";
        LFilePath: Text;
        LFileManagement: Codeunit "File Management";
        // BC Upgrade BHARDA11 >> ----Add new variables
        filename: Text;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        NAVOutStream: OutStream;
    // NAVInStream: InStream;
    // BC Upgrade BHARDA11 << ----Add new variables.
    begin
        CLEAR(LFilePath);
        // LFilePath := COPYSTR(LFileManagement.ServerTempFileName('pdf'), 1, 250); // BC Upgrade BHARAD11
        LIssuedReminder.RESET;
        LIssuedReminder.SETRANGE(LIssuedReminder."No.", LIssuedReminderNo);
        LIssuedReminder.FINDFIRST;
        CLEAR(LDunningLetter1);
        // BC Upgrade BHARAD11 >>
        Clear(TempBlob);
        TempBlob.CreateOutStream(NAVOutStream, TextEncoding::UTF8);
        RecRef.GetTable(LIssuedReminder);
        Report.SaveAs(Report::"Dunning Letter 1", '', REPORTFORMAT::Pdf, NAVOutStream, Recref);
        TempBlob.CreateInStream(NAVInStream);
        filename := CONVERTSTR('Dunning Letter 1' + FORMAT(WorkDate()), '/', '-') + '.pdf';
        EmailMessage.AddAttachment(filename, 'pdf', NAVInStream); // BC Upgrade BHARAD11 ::Added
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        // BC Upgrade BHARDA11 <<
        // BC Upgrade BHARDA11 >> ::Blocked
        // LDunningLetter1.SETTABLEVIEW(LIssuedReminder);
        // LDunningLetter1.SAVEASPDF(LFilePath);
        // exit(LFilePath);
        // BC Upgrade BHARDA11 << ::Blocked

    end;

    // local procedure GenMailAttachment2(LIssuedReminderNo: Code[20]): Text; // BC Upgrade BHARDA11 :: Blocked
    local procedure GenMailAttachment2(LIssuedReminderNo: Code[20]; var NAVInStream: InStream; EmailMess: Codeunit "Email Message") // BC Upgrade BHARDA11 ::Added Peremeter
    var
        LIssuedReminder: Record "Issued Reminder Header";
        LDunningLetter2: Report "Dunning Letter 2";
        LFilePath: Text;
        LFileManagement: Codeunit "File Management";
        // BC Upgrade BHARDA11 >> ----Add new variables
        filename: Text;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        NAVOutStream: OutStream;
    // BC Upgrade BHARDA11 << ----Add new variables.
    begin
        CLEAR(LFilePath);
        // LFilePath := COPYSTR(LFileManagement.ServerTempFileName('pdf'), 1, 250); // BC Upgrade BHARDA11 :: Blocked
        LIssuedReminder.RESET;
        LIssuedReminder.SETRANGE(LIssuedReminder."No.", LIssuedReminderNo);
        LIssuedReminder.FINDFIRST;
        CLEAR(LDunningLetter2);
        // BC Upgrade BHARAD11 >> ----Add New code
        Clear(TempBlob);
        TempBlob.CreateOutStream(NAVOutStream, TextEncoding::UTF8);
        RecRef.GetTable(LIssuedReminder);
        Report.SaveAs(Report::"Dunning Letter 2", '', REPORTFORMAT::Pdf, NAVOutStream, Recref);
        TempBlob.CreateInStream(NAVInStream);
        filename := CONVERTSTR('Dunning Letter 2' + FORMAT(WorkDate()), '/', '-') + '.pdf';
        EmailMess.AddAttachment(filename, 'pdf', NAVInStream);
        Email.Send(EmailMess, Enum::"Email Scenario"::Default);
        // BC Upgrade BHARDA11 <<
        // BC Upgrade BHARDA11 >>
        // BC Upgrade BHARDA11 <<
        // BC Upgrade BHARDA11 >> ::Blocked
        // LDunningLetter2.SETTABLEVIEW(LIssuedReminder);
        // LDunningLetter2.SAVEASPDF(LFilePath);
        // exit(LFilePath);
        // BC Upgrade BHARDA11 << ::Blocked
    end;

    // local procedure GenMailAttachment3(LIssuedReminderNo: Code[20]): Text; // BC Upgrade BHARDA11 ::Blocked
    local procedure GenMailAttachment3(LIssuedReminderNo: Code[20]; var NAVInStream: InStream; EmailMess: Codeunit "Email Message")// BC Upgrae BHARAD11 ----Add Peremeter
    var
        LIssuedReminder: Record "Issued Reminder Header";
        LDunningLetter3: Report "Dunning Letter 3";
        LFilePath: Text;
        LFileManagement: Codeunit "File Management";
        // BC Upgrade BHARDA11 >> ----Add new variables
        filename: Text;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        NAVOutStream: OutStream;
    // BC Upgrade BHARDA11 << ----Add new variables.
    begin
        CLEAR(LFilePath);
        // LFilePath := COPYSTR(LFileManagement.ServerTempFileName('pdf'), 1, 250); // BC Upgrade BHARDA11 :: Blocked
        LIssuedReminder.RESET();
        LIssuedReminder.SETRANGE(LIssuedReminder."No.", LIssuedReminderNo);
        LIssuedReminder.FINDFIRST();
        CLEAR(LDunningLetter3);
        // BC Upgrade BHARAD11 >> ----Add New code
        Clear(TempBlob);
        TempBlob.CreateOutStream(NAVOutStream, TextEncoding::UTF8);
        RecRef.GetTable(LIssuedReminder);
        Report.SaveAs(Report::"Dunning Letter 3", '', REPORTFORMAT::Pdf, NAVOutStream, Recref);
        TempBlob.CreateInStream(NAVInStream);
        filename := CONVERTSTR('Dunning Letter 3' + FORMAT(WorkDate()), '/', '-') + '.pdf';
        EmailMess.AddAttachment(filename, 'pdf', InsStream);
        Email.Send(EmailMess, Enum::"Email Scenario"::Default);
        // BC Upgrade BHARDA11 <<
        // BC Upgrade BHARDA11 >> :: Blocked
        // LDunningLetter3.SETTABLEVIEW(LIssuedReminder);
        // LDunningLetter3.SAVEASPDF(LFilePath);
        // exit(LFilePath);
        // BC Upgrade BHARDA11 << :: Bocked
    end;

}

