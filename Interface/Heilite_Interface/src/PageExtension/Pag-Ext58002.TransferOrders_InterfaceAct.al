namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Inventory.Transfer;
using System.Globalization;
using System.Email;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Warehouse.Request;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Location;

pageextension 58002 TransferOrders_InterfaceAct extends "Transfer orders"
{

    // BC Upgrade SHUKLP03 >>
    // DrinkIT code is blocked.
    // Made action("Create Whse. S&hipment") visible false, because of HEI code else condition.
    // Added action("Create &Whse. Receipt") of Transfer order in this page because interface related objects are used.
    // Created custom action("Create Whse. S&hipment Custom") of Transfer order in this page because interface related objects are used.
    // BC Upgrade SHUKLP03 <<

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "LSR Transfers Email Id Setup" to "LSR Transfer Email Setup FND".
    // BC UPGRADE PATELS08 <<

    layout
    {
        addafter("Receipt Date")
        {
            field("WMS Export"; Rec."WMS Export FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the WMS Export field.';

            }
            field("LSR Order No"; Rec."LSR Order No FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LSR Order No field.';
            }
        }
    }

    actions
    {
        addafter("Get Bin Content")
        {
            action(SendEmail)
            {
                Caption = 'Send Email';
                Ellipsis = true;
                Image = Email;
                ApplicationArea = All;
                ToolTip = 'Executes the Send Email action.';

                trigger OnAction();
                var
                    SendEmailLSR: Codeunit "Send Email Confirmation CBN";
                    SendEmailWhen: Option LSRTransferOrderIn,LSRTransferShipmentOut;
                    LSRInterfaceSetup: Record "LSR Interface Setup INT";
                    TextEmail: Label 'Email already send.';
                    TextEmail000: Label 'Nothing to send. Transfer shipment is not coming from LSR inteface or the email sending is not activated.';
                begin
                    //HEI.11>>
                    LSRInterfaceSetup.GET();
                    if (LSRInterfaceSetup."Enable Email LSR-TO") and (Rec."LSR Order No FND" <> '') then begin
                        if (not Rec."Email Sent-Create FND") then
                            LSRSendEmail(SendEmailWhen::LSRTransferOrderIn, Rec."Transfer-to Code", Rec."LSR Order No FND")
                        else
                            MESSAGE(TextEmail);
                    end else
                        MESSAGE(TextEmail000);
                    //HEI.11<<
                end;
            }
        }
        modify("Create Whse. S&hipment")
        {
            Visible = false; // BC Upgrade SHUKLP03 << Made it visible false because of HEI code else condition.
        }
        addafter("F&unctions")
        {
            action("Create Whse. S&hipment Custom")
            {
                CaptionML = ENU = 'Create Whse. S&hipment', FRA = 'Créer e&xpédition entrep.';
                ApplicationArea = All;
                ToolTip = 'Executes the Create Whse. S&hipment Custom action.';

                trigger OnAction()
                var
                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                begin
                    //HEI.04>>
                    IF LSRInterfaceSetup.GET() AND LSRInterfaceSetup."Enable LSR Interface" THEN
                        IF InterfaceSetup.GET(LSRInterfaceSetup."Transfer Shipment Interface") THEN
                            IF InterfaceSetup.Enabled THEN
                                IF Rec."LSR Order No FND" <> '' THEN BEGIN
                                    LocationFrom.GET(Rec."Transfer-from Code");
                                    IF LocationFrom."Store FND" THEN
                                        ERROR(CannotShipInHLErr);
                                END;
                    //HEI.04<<
                    //HEI.07>>
                    Onelienreceipt := FALSE;
                    MaximoDoc := FALSE;
                    IF lrec_PurchHdrAddtnl.GET(lrec_PurchHdrAddtnl."Document Type"::Order, Rec."PO Reference FND") THEN BEGIN
                        IF lrec_PurchHdrAddtnl."Import Identifier" THEN BEGIN
                            IF lrec_PurchHdr.GET(lrec_PurchHdr."Document Type"::Order, Rec."PO Reference FND") THEN
                                IF (lrec_PurchHdr."Maximo Requisition No. FND" <> '') THEN
                                    MaximoDoc := TRUE;
                            lrec_PurchLn.RESET();
                            lrec_PurchLn.SETRANGE("Document Type", lrec_PurchHdrAddtnl."Document Type");
                            lrec_PurchLn.SETRANGE("Document No.", lrec_PurchHdrAddtnl."No.");
                            IF lrec_PurchLn.findset() THEN
                                REPEAT
                                    IF (lrec_PurchLn."Quantity Received" <> 0) THEN
                                        Onelienreceipt := TRUE;
                                UNTIL (lrec_PurchLn.NEXT() = 0) OR (Onelienreceipt = TRUE);
                        END;
                    END;
                    IF MaximoDoc THEN
                        ERROR(Text50000, Rec."No.");

                    IF (Rec."PO Reference FND" <> '') THEN BEGIN
                        IF NOT MaximoDoc AND NOT Onelienreceipt THEN
                            ERROR(Text50002, Rec."No.", Rec."PO Reference FND");
                        IF NOT MaximoDoc AND Onelienreceipt THEN
                            GetSourceDocOutbound.CreateFromOutbndTransferOrder(Rec);
                    END ELSE
                        //HEI.07<<
                        GetSourceDocOutbound.CreateFromOutbndTransferOrder(Rec);

                end;
            }
        }
        modify("Create &Whse. Receipt")
        {
            CaptionML = ENU = 'Create &Whse. Receipt', FRA = 'Créer &réception entrepôt';
            trigger OnBeforeAction()
            var
            begin
                //HEI.04>>
                IF LSRInterfaceSetup.GET() AND LSRInterfaceSetup."Enable LSR Interface" THEN
                    IF InterfaceSetup.GET(LSRInterfaceSetup."Transfer Receipt Interface Out") THEN
                        IF InterfaceSetup.Enabled THEN
                            IF Rec."LSR Order No FND" <> '' THEN BEGIN
                                LocationTo.GET(Rec."Transfer-to Code");
                                IF LocationTo."Store FND" THEN
                                    ERROR(CannotReceiveInHLErr);
                            END;
                //HEI.04<<
            end;
        }
    }

    var
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        Text50002: Label 'Warehouse Shipment Doc can not be created for this Transfer Order - %1 as it is created from Import PO process and PO- %2 is not fully or partially received';
        CannotShipInHLErr: Label 'A Transfer Order from Store Location can not be shipped in Heilite.';
        CannotReceiveInHLErr: Label 'A Transfer Order to Store Location can not be received in Heilite.';
        Text50000: Label 'Warehouse Shipment Doc can not be created for this Transfer Order - %1 as it is created from Import PO process';
        LocationFrom: Record Location;
        lrec_PurchHdrAddtnl: Record "Purchase Header Additional FND";
        lrec_PurchLn: Record "Purchase Line";
        lrec_PurchHdr: Record "Purchase Header";
        MaximoDoc: Boolean;
        Onelienreceipt: Boolean;

        LocationTo: Record Location;

    procedure LSRSendEmail(SendEmailWhen: Option LSRTransferOrderIn,LSRTransferShipmentOut; ToLocation: Code[20]; LSRTransferNo: Code[20]);
    var
        LSRTransfersEmailIdSetup: Record "LSR Transfer Email Setup FND";
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        CompanyInformation: Record "Company Information";
        LSRInterfaceSetupE: Record "LSR Interface Setup INT";
        Language: Codeunit Language;
        TransferHeader: Record "Transfer Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        EmailAddress: Text;
        SenderEmail: Text;
        BodyEmail: Code[20];
        EmailTitle: Label 'Greetings All,';
        EmailSubjectTO: Label 'LSR-TO %1';
        EmailSubjectTSOUT: Label 'LSR-TS-OUT %1';
        EmailSubject: Text;
        EmailBody: Text;
        NewString: Text;
        EmailAccount: Record "Email Account";
        EmailC: Codeunit Email;
        HtmlBody: Text;
        MailSuccessMsg: Label 'Email send succesfully to %1';
        FoundTxtTransferOrder: Boolean;
        EmailCanBeSend: Boolean;
        EmailMessage: Codeunit "Email Message";
        EmailScenarioC: Codeunit "Email Scenario";
        EmailListForLocation: Label 'Email list for To Location %1 is not setup.';
    begin
        //HEI.04>>
        if LSRTransfersEmailIdSetup.GET(ToLocation) then begin
            LSRInterfaceSetupE.GET();
            TransferHeader.SETRANGE("LSR Order No FND", LSRTransferNo);
            if TransferHeader.FINDFIRST() then;

            case SendEmailWhen of
                SendEmailWhen::LSRTransferOrderIn:
                    begin
                        //SMTPMail.CheckValidEmailAddresses(LSRTransfersEmailIdSetup."Create Email Id");
                        EmailCanBeSend := true;
                        EmailAddress := LSRTransfersEmailIdSetup."Create Email Id";
                        BodyEmail := LSRInterfaceSetupE."Body Email LSR-TO";
                        EmailSubject := STRSUBSTNO(EmailSubjectTO, LSRTransferNo);

                    end;
                SendEmailWhen::LSRTransferShipmentOut:
                    begin
                        //SMTPMail.CheckValidEmailAddresses(LSRTransfersEmailIdSetup."Shipped Email Id");
                        EmailCanBeSend := true;
                        EmailAddress := LSRTransfersEmailIdSetup."Shipped Email Id";
                        BodyEmail := LSRInterfaceSetupE."Body Email LSR-TS-OUT";
                        EmailSubject := STRSUBSTNO(EmailSubjectTSOUT, LSRTransferNo);
                    end;
            end;

            if EmailCanBeSend then begin
                //SMTPMailSetup.GET;

                EmailMessage.Create(EmailAddress, EmailSubject, BodyEmail);


                // if SMTPMailSetup."User ID" <> '' then
                //     SenderEmail := SMTPMailSetup."User ID"
                // else begin
                //     CompanyInformation.GET;
                //     SenderEmail := CompanyInformation."E-Mail";
                // end;

                //SMTPMail.CreateMessage('', SenderEmail, EmailAddress, EmailSubject, '', true);

                ExtendedTextHeader.RESET();
                ExtendedTextHeader.SETRANGE("No.", BodyEmail);
                ExtendedTextHeader.SETRANGE("Language Code", Language.GetUserLanguageCode());
                if not ExtendedTextHeader.FINDFIRST() then begin
                    ExtendedTextHeader.SETRANGE("Language Code");
                    ExtendedTextHeader.SETRANGE("All Language Codes", true);
                    if not ExtendedTextHeader.FINDFIRST() then
                        ExtendedTextHeader.SETRANGE("All Language Codes");
                end;

                if ExtendedTextHeader.FINDFIRST() then begin
                    ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                    ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                    ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
                    if ExtendedTextLine.findset(false) then
                        repeat
                            FoundTxtTransferOrder := false;
                            NewString := '';
                            NewString := LSRReplacesStr('LSR Transfer order #', 'LSR Transfer order #' + LSRTransferNo, ExtendedTextLine.Text);
                            if (STRLEN(NewString) <> STRLEN(ExtendedTextLine.Text)) then
                                FoundTxtTransferOrder := true;
                            NewString := LSRReplacesStr('Heilite Location #', 'Heilite Location #' + ToLocation, NewString);
                            if (not FoundTxtTransferOrder) then
                                NewString := LSRReplacesStr('Transfer order #', 'Transfer order #' + TransferHeader."No.", NewString);

                            HtmlBody += NewString + '<br><br>';
                        // SMTPMail.AppendBody(NewString);
                        // SMTPMail.AppendBody('<br><br>');
                        until ExtendedTextLine.NEXT() = 0;
                end;

                EmailMessage.AppendToBody(HtmlBody);

                if EmailScenarioC.GetEmailAccount(Enum::"Email Scenario"::"Proforma Invoice", EmailAccount) then begin
                    if EmailAccount."Email Address" <> '' then
                        EmailC.Send(EmailMessage, Enum::"Email Scenario"::"Proforma Invoice")
                    else
                        EmailC.Send(EmailMessage, Enum::"Email Scenario"::Default)
                end else begin
                    EmailC.Send(EmailMessage, Enum::"Email Scenario"::Default);


                    //SMTPMail.Send;
                    case SendEmailWhen of
                        SendEmailWhen::LSRTransferOrderIn:
                            begin
                                TransferHeader."Email Sent-Create FND" := true;
                                TransferHeader.MODIFY();
                            end;
                        SendEmailWhen::LSRTransferShipmentOut:
                            begin
                                TransferShipmentHeader.SETRANGE("LSR Order No FND", LSRTransferNo);
                                if TransferShipmentHeader.FINDFIRST() then begin
                                    TransferShipmentHeader."Email Sent-Ship FND" := true;
                                    TransferShipmentHeader.MODIFY();
                                end;
                            end;
                    end;

                    if GUIALLOWED then
                        MESSAGE(MailSuccessMsg, EmailAddress);
                end;
            end else begin
                if GUIALLOWED then
                    MESSAGE(EmailListForLocation, ToLocation);
            end;
            //HEI.04<<
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
