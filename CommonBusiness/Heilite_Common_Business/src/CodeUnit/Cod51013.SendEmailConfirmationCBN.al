codeunit 51013 "Send Email Confirmation CBN"
{
    // version HEI.04

    // HEI.01 IBM LAZARE02 15.01.2018 # New codeunit for handling workflow email responses
    // HEI.02 IBM SAMANR01 12.05.2023 CHG2204329 Email Validation on JOB Q & Interfaces
    //   # Create function for email validation
    // HEI.03 IBM SAMANR01 31.07.2023 CHG2212226 Test Email in Send Email Confirmation
    //   # Modify the code in order to send email for each email input
    // HEI.04 CHG2216722 IBM SISUM01 03.10.2023 Request for email functionality for Transfer Order Creation
    //   # create functions: LSRSendEmail,LSRReplacesStr

    trigger OnRun();
    begin
    end;

    var
        PurchaseOrderTxt: Label 'Purchase Order %1';
        SendMailVendor: Label 'Send mail to vendor';

    procedure SendMailToVendorCode(): Code[128];
    begin
        exit(UPPERCASE('SendMailToVendor'));
    end;

    local procedure SendMailToVendor(var PurchaseHeader: Record "Purchase Header");
    var
        CompanyInformation: Record "Company Information";
        Vendor: Record Vendor;
        PurchaseHeader2: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        //SMTPMailSetup : Record "SMTP Mail Setup";
        //SMTPMail : Codeunit "SMTP Mail";
        FileManagement: Codeunit "File Management";
        FileName: Text;
        SenderEmail: Text;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        TempBlob: Codeunit "Temp Blob";
        ReportManagement: Codeunit ReportManagement;
        OutStream: OutStream;
        InStr: InStream;

    begin
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        if PurchaseLine.ISEMPTY then
            exit;
        Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
        //SMTPMailSetup.GET;      //BC Upgrade KUMBHS03 commented 10/03/2026
        //if SMTPMailSetup."User ID" <> '' then //BC Upgrade KUMBHS03 commented 10/03/2026
        //  SenderEmail := SMTPMailSetup."User ID" //BC Upgrade KUMBHS03 commented 10/03/2026
        //else begin  //BC Upgrade KUMBHS03 commented 10/03/2026
        CompanyInformation.GET;
        SenderEmail := CompanyInformation."E-Mail";
        //end;  //BC Upgrade KUMBHS03 commented 10/03/2026

        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(Report::Order, '', ReportFormat::Pdf, OutStream, PurchaseHeader);
        FileName := PurchaseHeader."No." + '.pdf';
        EmailMessage.Create(SenderEmail, Vendor."E-Mail", StrSubstNo(PurchaseOrderTxt, PurchaseHeader."No."));
        TempBlob.CreateInStream(InStr);
        EmailMessage.AddAttachment(FileName, FileName, InStr);
        Email.Send(EmailMessage);

        // FileName := FileManagement.ServerTempFileName('pdf');  //BC Upgrade KUMBHS03 commented 10/03/2026
        // PurchaseHeader2.SETRANGE("No.", PurchaseHeader."No.");  //BC Upgrade KUMBHS03 commented 10/03/2026
        // REPORT.SAVEASPDF(REPORT::Order, FileName, PurchaseHeader2); //BC Upgrade KUMBHS03 commented 10/03/2026
        // SMTPMail.CreateMessage('', SenderEmail, Vendor."E-Mail",   
        //                        STRSUBSTNO(PurchaseOrderTxt, PurchaseHeader."No."), STRSUBSTNO(PurchaseOrderTxt, PurchaseHeader."No."), true);  //BC Upgrade KUMBHS03 commented 10/03/2026
        // SMTPMail.AddAttachment(FileName, PurchaseHeader."No." + '.pdf');  //BC Upgrade KUMBHS03 commented 10/03/2026
        // SMTPMail.Send; //BC Upgrade KUMBHS03 commented 10/03/2026
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1521, 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    // local procedure AddResponseToLibrary(WorkflowResponseHandling: Codeunit "Workflow Response Handling");
    // begin
    //     WorkflowResponseHandling.AddResponseToLibrary(SendMailToVendorCode, 0, SendMailVendor, 'GROUP 0');
    // end;   //BC Upgrade KUMBHS03 commented 10/03/2026 this procedure

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    local procedure AddResponseToLibrary()
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(
            SendMailToVendorCode,
            0,
            SendMailVendor,
            'GROUP 0'
        );
    end;


    [EventSubscriber(ObjectType::Codeunit, 1521, 'OnExecuteWorkflowResponse', '', false, false)]
    local procedure RunSendEmail(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance");
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        if WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") then
            case WorkflowResponse."Function Name" of
                SendMailToVendorCode:
                    begin
                        SendMailToVendor(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;

    //BC Upgrade KUMBHS03 Added new  10/03/2026 >>
    procedure ValidateEmailAddresses(EmailAddresses: Text; SentTestEmail: Boolean)
    var
        Regex: Codeunit Regex;
        EmailAddrArray: List of [Text];
        I: Integer;
        Text106: Label 'Email address %1 you entered is not valid';
        EmailAddress: Text;
    begin
        EmailAddresses := ConvertStr(EmailAddresses, ',', ';');
        EmailAddresses := DelChr(EmailAddresses, '<>');
        EmailAddrArray := EmailAddresses.Split(';');

        for I := 1 to EmailAddrArray.Count do begin
            EmailAddress := EmailAddrArray.Get(I);

            if not Regex.IsMatch(
                EmailAddress,
                '^[\w!#$%&*+\-/=?\^_`{|}~]+(\.[\w!#$%&*+\-/=?\^_`{|}~]+)*@((([\-\w]+\.)+[a-zA-Z]{2,})|(([0-9]{1,3}\.){3}[0-9]{1,3}))$')
            then
                Error(Text106, EmailAddress);

            if SentTestEmail then
                SendTestMail(EmailAddress);
        end;
    end;
    //BC Upgrade KUMBHS03 Added new  10/03/2026 <<

    //BC Upgrade KUMBHS03 Added new  10/03/2026 >>
    local procedure SendTestMail(EmailAddress: Text)
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        TestMailTitleTxt: TextConst ENU = 'SMTP Test Email Message', FRA = 'Message e-mail de test SMTP';
        TestMailBodyTxt: TextConst
        ENU = '<p style="font-family:Verdana,Arial;font-size:10pt"><b>This mail message has been generated by the user %1 for test purposes.</b></p><p style="font-family:Verdana,Arial;font-size:9pt"><b>Tenant ID:</b> %2</p>',
        FRA = '<p style="font-family:Verdana,Arial;font-size:10pt"><b>Cet e-mail a été généré par l''utilisateur %1 à des fins de test.</b></p><p style="font-family:Verdana,Arial;font-size:9pt"><b>ID abonné :</b> %2</p>';
        TestMailSuccessMsg: TextConst ENU = 'Test email has been sent to ''%1'' using your configured email account.\Check your inbox to confirm delivery.', FRA = 'L''e-mail test a été envoyé à « %1 » en fonction du compte e-mail configuré.\Contrôlez vos messages pour vérifier que vous avez bien reçu cet e-mail.';
    begin

        EmailMessage.Create(
            EmailAddress,
            TestMailTitleTxt,
            StrSubstNo(TestMailBodyTxt, UserId, TenantId), true);

        Email.Send(EmailMessage);

        if GuiAllowed then
            Message(TestMailSuccessMsg, EmailAddress);
    end;
    //BC Upgrade KUMBHS03 Added new  10/03/2026 <<


    //BC Upgrade KUMBHS03 Added 10032026 >>
    // procedure LSRSendEmail(SendEmailWhen: Option LSRTransferOrderIn,LSRTransferShipmentOut; ToLocation: Code[20]; LSRTransferNo: Code[20])
    // var
    //     LSRTransfersEmailIdSetup: Record "LSR Transfers Email Id Setup";
    //     ExtendedTextHeader: Record "Extended Text Header";
    //     ExtendedTextLine: Record "Extended Text Line";
    //     LSRInterfaceSetup: Record "LSR Interface Setup INT";
    //     TransferHeader: Record "Transfer Header";
    //     TransferShipmentHeader: Record "Transfer Shipment Header";
    //     EmailMessage: Codeunit "Email Message";
    //     Email: Codeunit Email;
    //     EmailAddress: Text;
    //     BodyEmail: Code[20];
    //     EmailSubjectTO: Label 'LSR-TO %1';
    //     EmailSubjectTSOUT: Label 'LSR-TS-OUT %1';
    //     EmailSubject: Text;
    //     NewString: Text;
    //     EmailBody: Text;
    //     MailSuccessMsg: Label 'Email sent successfully to %1';
    //     EmailListForLocation: Label 'Email list for To Location %1 is not setup.';
    // begin
    //     if LSRTransfersEmailIdSetup.Get(ToLocation) then begin
    //         LSRInterfaceSetup.Get;
    //         TransferHeader.SetRange("LSR Order No", LSRTransferNo);
    //         if TransferHeader.FindFirst then;

    //         case SendEmailWhen of
    //             SendEmailWhen::LSRTransferOrderIn:
    //                 begin
    //                     EmailAddress := LSRTransfersEmailIdSetup."Create Email Id";
    //                     BodyEmail := LSRInterfaceSetup."Body Email LSR-TO";
    //                     EmailSubject := StrSubstNo(EmailSubjectTO, LSRTransferNo);
    //                 end;
    //             SendEmailWhen::LSRTransferShipmentOut:
    //                 begin
    //                     EmailAddress := LSRTransfersEmailIdSetup."Shipped Email Id";
    //                     BodyEmail := LSRInterfaceSetup."Body Email LSR-TS-OUT";
    //                     EmailSubject := StrSubstNo(EmailSubjectTSOUT, LSRTransferNo);
    //                 end;
    //         end;


    //         EmailBody := '';
    //         ExtendedTextHeader.SetRange("No.", BodyEmail);
    //         ExtendedTextHeader.SetRange("All Language Codes", true);
    //         if ExtendedTextHeader.FindFirst() then begin
    //             ExtendedTextLine.SetRange("No.", ExtendedTextHeader."No.");
    //             ExtendedTextLine.SetRange("Text No.", ExtendedTextHeader."Text No.");
    //             ExtendedTextLine.SetRange("Language Code", ExtendedTextHeader."Language Code");
    //             if ExtendedTextLine.FindSet(false) then
    //                 repeat
    //                     NewString := ExtendedTextLine.Text;
    //                     NewString := LSRReplacesStr('LSR Transfer order #', 'LSR Transfer order #' + LSRTransferNo, NewString);
    //                     NewString := LSRReplacesStr('Heilite Location #', 'Heilite Location #' + ToLocation, NewString);
    //                     NewString := LSRReplacesStr('Transfer order #', 'Transfer order #' + TransferHeader."No.", NewString);

    //                     EmailBody += NewString + '<br><br>';
    //                 until ExtendedTextLine.Next = 0;
    //         end;

    //         EmailMessage.Create(EmailAddress, EmailSubject, '', true);
    //         EmailMessage.SetBody(EmailBody);
    //         Email.Send(EmailMessage);

    //         case SendEmailWhen of
    //             SendEmailWhen::LSRTransferOrderIn:
    //                 begin
    //                     TransferHeader."Email Sent-Create" := true;
    //                     TransferHeader.Modify();
    //                 end;
    //             SendEmailWhen::LSRTransferShipmentOut:
    //                 begin
    //                     TransferShipmentHeader.SetRange("LSR Order No", LSRTransferNo);
    //                     if TransferShipmentHeader.FindFirst() then begin
    //                         TransferShipmentHeader."Email Sent-Ship" := true;
    //                         TransferShipmentHeader.Modify();
    //                     end;
    //                 end;
    //         end;

    //         if GuiAllowed then
    //             Message(MailSuccessMsg, EmailAddress);
    //     end else begin
    //         if GuiAllowed then
    //             Message(EmailListForLocation, ToLocation);
    //     end;
    // end;
    //BC Upgrad KUMBHS03 Added 10032026 <<

    local procedure LSRReplacesStr(FindWhat: Text; ReplaceWith: Text; String: Text) NewString: Text;
    begin
        //HEI.04>>
        if STRPOS(String, FindWhat) > 0 then
            NewString := DELSTR(String, STRPOS(String, FindWhat)) + '<b>' + ReplaceWith + '</b>' + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat))
        else
            NewString := String;
        //HEI.04<<
    end;  // BC Upgrade NANDIS03
}

