
codeunit 58136 InterfaceEmailFunctionalityINT
{
    procedure LSRSendEmail(SendEmailWhen: Option LSRTransferOrderIn,LSRTransferShipmentOut; ToLocation: Code[20]; LSRTransferNo: Code[20])
    var
        LSRTransfersEmailIdSetup: Record "LSR Transfer Email Setup FND";
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        TransferHeader: Record "Transfer Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailAddress: Text;
        BodyEmail: Code[20];
        EmailSubjectTO: Label 'LSR-TO %1';
        EmailSubjectTSOUT: Label 'LSR-TS-OUT %1';
        EmailSubject: Text;
        NewString: Text;
        EmailBody: Text;
        MailSuccessMsg: Label 'Email sent successfully to %1';
        EmailListForLocation: Label 'Email list for To Location %1 is not setup.';
    begin
        if LSRTransfersEmailIdSetup.Get(ToLocation) then begin
            LSRInterfaceSetup.Get;
            TransferHeader.SetRange("LSR Order No FND", LSRTransferNo);
            if TransferHeader.FindFirst then;

            case SendEmailWhen of
                SendEmailWhen::LSRTransferOrderIn:
                    begin
                        EmailAddress := LSRTransfersEmailIdSetup."Create Email Id";
                        BodyEmail := LSRInterfaceSetup."Body Email LSR-TO";
                        EmailSubject := StrSubstNo(EmailSubjectTO, LSRTransferNo);
                    end;
                SendEmailWhen::LSRTransferShipmentOut:
                    begin
                        EmailAddress := LSRTransfersEmailIdSetup."Shipped Email Id";
                        BodyEmail := LSRInterfaceSetup."Body Email LSR-TS-OUT";
                        EmailSubject := StrSubstNo(EmailSubjectTSOUT, LSRTransferNo);
                    end;
            end;


            EmailBody := '';
            ExtendedTextHeader.SetRange("No.", BodyEmail);
            ExtendedTextHeader.SetRange("All Language Codes", true);
            if ExtendedTextHeader.FindFirst() then begin
                ExtendedTextLine.SetRange("No.", ExtendedTextHeader."No.");
                ExtendedTextLine.SetRange("Text No.", ExtendedTextHeader."Text No.");
                ExtendedTextLine.SetRange("Language Code", ExtendedTextHeader."Language Code");
                if ExtendedTextLine.FindSet(false) then
                    repeat
                        NewString := ExtendedTextLine.Text;
                        NewString := LSRReplacesStr('LSR Transfer order #', 'LSR Transfer order #' + LSRTransferNo, NewString);
                        NewString := LSRReplacesStr('Heilite Location #', 'Heilite Location #' + ToLocation, NewString);
                        NewString := LSRReplacesStr('Transfer order #', 'Transfer order #' + TransferHeader."No.", NewString);

                        EmailBody += NewString + '<br><br>';
                    until ExtendedTextLine.Next = 0;
            end;

            EmailMessage.Create(EmailAddress, EmailSubject, '', true);
            EmailMessage.SetBody(EmailBody);
            Email.Send(EmailMessage);

            case SendEmailWhen of
                SendEmailWhen::LSRTransferOrderIn:
                    begin
                        TransferHeader."Email Sent-Create FND" := true;
                        TransferHeader.Modify();
                    end;
                SendEmailWhen::LSRTransferShipmentOut:
                    begin
                        TransferShipmentHeader.SetRange("LSR Order No FND", LSRTransferNo);
                        if TransferShipmentHeader.FindFirst() then begin
                            TransferShipmentHeader."Email Sent-Ship FND" := true;
                            TransferShipmentHeader.Modify();
                        end;
                    end;
            end;

            if GuiAllowed then
                Message(MailSuccessMsg, EmailAddress);
        end else begin
            if GuiAllowed then
                Message(EmailListForLocation, ToLocation);
        end;
    end;

    local procedure LSRReplacesStr(FindWhat: Text; ReplaceWith: Text; String: Text) NewString: Text;
    begin
        //HEI.04>>
        if STRPOS(String, FindWhat) > 0 then
            NewString := DELSTR(String, STRPOS(String, FindWhat)) + '<b>' + ReplaceWith + '</b>' + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat))
        else
            NewString := String;
        //HEI.04<<
    end;

}
