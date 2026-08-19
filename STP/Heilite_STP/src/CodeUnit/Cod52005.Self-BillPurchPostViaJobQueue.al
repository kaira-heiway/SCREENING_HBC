codeunit 52005 "Self-Bill PurchPostViaJobQueue"
{
    // version SB

    // HEI.01 FDD-HD-545 IBM POSTOI01 11.10.2019 # Self-Billing
    // # new object

    // BC Upgrade KAPOOV01 >>
    //1.Commented SMTP Related functionality.
    //2.Commented FileManagement Related functionality.
    //3.Added code to replace SMTP related functionality.
    //4.Added code to replace FileManagement related functionality.
    //5.Original Codeunit ID-50102.
    // BC Upgrade KAPOOV01 <<
    //BC UPGRADE ATHUKS01 >>
    //1. Added new code for report parameters to crate attachement
    //BC UPGRADE ATHUKS01 >>

    // BC Upgrade MISHRS14 >>
    // Changed data type from option to enum of NewStatus to remove implicit warning in procedure - SetJobQueueStatus
    // BC Upgrade MISHRS14 <<

    TableNo = 472;

    trigger OnRun();
    var
        //BC Upgrade KAPOOV01 Commented SMTP Related functionality >>
        //ServerAttachmentFilePath: Text[1024];
        //SMTPMailSetup: Record "SMTP Mail Setup";  
        // Mail: DotNet "'Microsoft.Dynamics.Nav.SMTP, Version=11.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.SMTP.SmtpMessage";
        // SMTPMAIL: Codeunit "SMTP Mail";
        //BC Upgrade KAPOOV01 Commented SMTP Related functionality <<
        //BC Upgrade KAPOOV01 Added to replace SMTP & FileManagement related functionality >>
        TempBlob: Codeunit "Temp Blob";
        FileInStream: InStream;
        OutStream: OutStream;
        AttachmentBase64: Text;
        Base64Convert: Codeunit "Base64 Convert";
        EmailMessage: Codeunit "Email Message";
        BodyText: Text;
        SubjectText: Text;
        Email: Codeunit Email;
        RecRef: RecordRef;
        //BC Upgrade KAPOOV01 Added to replace SMTP & FileManagement related functionality <<
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchHeaderNo: Code[20];
        //BC UPGRADE ATHUKS01 >>
        ReportSelectionRec: Record "Report Selections";
        AllObjWithCaption: Record AllObjWithCaption;
        ReportParameters: Text;
        ReportLbl: Label '<?xml version="1.0" standalone="yes"?><ReportParameters name="%1" id="%2"><Options><Field name="NoOfCopies">0</Field><Field name="ShowInternalInfo">false</Field><Field name="LogInteraction">false</Field></Options><DataItems><DataItem name="Purch. Inv. Header">VERSION(1) SORTING(Field3) WHERE(Field3=1(%3))</DataItem><DataItem name="CopyLoop">VERSION(1) SORTING(Field1)</DataItem><DataItem name="PageLoop">VERSION(1) SORTING(Field1)</DataItem><DataItem name="DimensionLoop1">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Purch. Inv. Line">VERSION(1) SORTING(Field3,Field4)</DataItem><DataItem name="DimensionLoop2">VERSION(1) SORTING(Field1)</DataItem><DataItem name="VATCounter">VERSION(1) SORTING(Field1)</DataItem><DataItem name="VATCounterLCY">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Total">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Total2">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Total3">VERSION(1) SORTING(Field1)</DataItem><DataItem name="RemitToAddressDataItem">VERSION(1) SORTING(Field1)</DataItem></DataItems></ReportParameters>';
    //BC UPGRADE ATHUKS01 <<
    begin
        CompanyInformation.GET;
        Vendor.Reset();
        Vendor.SETRANGE("Self-Billing FND", TRUE);
        IF Vendor.FINDSET THEN BEGIN
            CounterTotal := Vendor.COUNT;
            REPEAT
                //set the posted receipts that are not invoiced
                PurchRcptLine.SETCURRENTKEY("Pay-to Vendor No.");
                PurchRcptLine.SETRANGE("Pay-to Vendor No.", Vendor."No.");
                PurchRcptLine.SETFILTER("Qty. Rcd. Not Invoiced", '<>0');
                IF PurchRcptLine.FINDSET THEN BEGIN
                    REPEAT
                        TextError := '';
                        PurchRcptLine.SETRANGE("Document No.", PurchRcptLine."Document No.");
                        CLEARLASTERROR;
                        IF NOT CODEUNIT.RUN(CODEUNIT::"Self-Bill PurchCreateInv", PurchRcptLine) THEN BEGIN
                            TextError := 'Invoice not created: ' + GETLASTERRORTEXT;
                            InsertJobQueueLogDetail(Rec, '', 'Vendor no. ' + Vendor."No." + ' Receipt no. ' + PurchRcptLine."Document No." + ' line no. ' + FORMAT(PurchRcptLine."Line No.") + ' message:' + GETLASTERRORTEXT, 2, 0, 'Error on invoice creating', 0);
                        END ELSE BEGIN
                            PurchRcptLine.SETRANGE("Document No.");
                            COMMIT;
                            //get the new created Purchase invoice header
                            PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Invoice);
                            PurchHeader.SETRANGE("No.", PurchRcptLine."Self_Billing Inv. No. FND");
                            PurchHeader.SETRANGE("Job Queue Status", PurchHeader."Job Queue Status"::Posting);
                            IF PurchHeader.FINDFIRST THEN BEGIN
                                SetJobQueueStatus(PurchHeader, PurchHeader."Job Queue Status"::Posting);
                                PurchHeaderNo := PurchHeader."No.";
                                IF NOT CODEUNIT.RUN(CODEUNIT::"Purch.-Post", PurchHeader) THEN BEGIN
                                    SetJobQueueStatus(PurchHeader, PurchHeader."Job Queue Status"::Error);
                                    TextError := 'Invoice not posted: ' + GETLASTERRORTEXT;
                                    InsertJobQueueLogDetail(Rec, PurchHeader."No.", GETLASTERRORTEXT, 2, 1, 'Error on invoice posting', 0);
                                END ELSE BEGIN
                                    //print the posted invoice
                                    //find the posted invoice
                                    PurchInvHeader.RESET;
                                    PurchInvHeader.SETRANGE("Pre-Assigned No.", PurchHeaderNo);
                                    IF PurchInvHeader.FINDFIRST THEN BEGIN

                                        ReportSelectionRec.Reset();
                                        ReportSelectionRec.SetRange(Usage, ReportSelectionRec.Usage::"P.Invoice");
                                        ReportSelectionRec.SetFilter("Report ID", '<>%1', 0);
                                        if not ReportSelectionRec.FindFirst() then
                                            exit;
                                        if AllObjWithCaption.Get(AllObjWithCaption."Object Type"::Report, ReportSelectionRec."Report ID") then;

                                        //BC Upgrade KAPOOV01 Commented FileManagement related functionality >>
                                        // ServerAttachmentFilePath := COPYSTR(FileManagement.ServerTempFileName('pdf'), 1, 250);
                                        // IF NOT REPORT.SAVEASPDF(406, ServerAttachmentFilePath, PurchInvHeader) THEN BEGIN
                                        //BC Upgrade KAPOOV01 Commented FileManagement related functionality >>

                                        //BC Upgrade KAPOOV01 Added to replace FileManagement related functionality >>
                                        //  RecRef.GetTable(PurchInvHeader);
                                        // Generate PDF to stream
                                        //TempBlob.CreateOutStream(OutStream);
                                        // if not Report.SaveAs(406, '', ReportFormat::Pdf, OutStream, RecRef) then begin
                                        //BC Upgrade KAPOOV01 Added to replace FileManagement related functionality <<

                                        //BC UPGRADE ATHUKS01 >>
                                        ReportParameters := StrSubstNo(ReportLbl, AllObjWithCaption."Object Caption", ReportSelectionRec."Report ID", PurchInvHeader."No.");
                                        TempBlob.CreateOutStream(OutStream);
                                        Report.SaveAs(ReportSelectionRec."Report ID", ReportParameters, ReportFormat::Pdf, OutStream);
                                        TempBlob.CreateInStream(FileInStream);
                                        //BC UPGRADE ATHUKS01 <<
                                        if FileInStream.Length = 0 then begin  //BC UPGRADE ATHUKS01 <<

                                            TextError := 'PDF file not generated: ' + GETLASTERRORTEXT;
                                            InsertJobQueueLogDetail(Rec, PurchInvHeader."No.", GETLASTERRORTEXT, 2, 2, 'Error on report pdf generating', 4);
                                        END ELSE BEGIN
                                            COMMIT;

                                            //BC Upgrade KAPOOV01 Commented SMTPMAIL related functionality >>
                                            // SMTPMAIL.CreateMessage(CompanyInformation.Name, Vendor."E-Mail 2",
                                            //         Vendor."E-Mail 2", 'Posted Invoice ' + PurchInvHeader."No.", '', TRUE);
                                            // SMTPMAIL.AppendBody('Dear ' + Vendor.Name);
                                            // SMTPMAIL.AppendBody('<br><br>');
                                            // SMTPMAIL.AppendBody('Please find attached your invoice.');
                                            // SMTPMAIL.AppendBody('<br><Br>');
                                            // SMTPMAIL.AppendBody('Best Regards,');
                                            // SMTPMAIL.AppendBody('<br><Br>');
                                            // SMTPMAIL.AppendBody(CompanyInformation.Name);
                                            // SMTPMAIL.AppendBody('<br><Br>');
                                            // SMTPMAIL.AddAttachment(ServerAttachmentFilePath, 'Purchase invoice' + FORMAT(WORKDATE));
                                            // IF NOT SMTPMAIL.TrySend THEN BEGIN
                                            //BC Upgrade KAPOOV01 Commented SMTPMAIL related functionality <<

                                            //BC Upgrade KAPOOV01 Added to replace SMTPMAIL related functionality >>
                                            //  TempBlob.CreateInStream(FileInStream);
                                            //AttachmentBase64 := Base64Convert.ToBase64(FileInStream);
                                            BodyText :=
                                             'Dear ' + Vendor.Name + ',' + '<br><br>' +
                                            'Please find attached your invoice.' + '<br><br>' + 'Best Regards,' + '<br><Br>' + CompanyInformation.Name +
                                             '<br><Br>';
                                            SubjectText := 'Posted Invoice ' + PurchInvHeader."No.";
                                            // Create and configure email message
                                            EmailMessage.Create(Vendor."E-Mail 2 FND", SubjectText, BodyText, true);

                                            // Add attachment
                                            EmailMessage.AddAttachment('Purchase invoice' + FORMAT(WORKDATE) + '.pdf', 'application/pdf', FileInStream);

                                            // Send the email using the default email account
                                            IF Not Email.Send(EmailMessage, Enum::"Email Scenario"::"Purchase Order") then begin
                                                //BC Upgrade KAPOOV01 Added to replace SMTPMAIL related functionality <<

                                                TextError := 'Mail not sent ';
                                                InsertJobQueueLogDetail(Rec, PurchInvHeader."No.", GETLASTERRORTEXT, 2, 3, 'Error on email sending', 4);
                                            END;
                                        END;
                                        //SMTPMAIL.Send;
                                    END;
                                END;
                            END;
                        END;
                        IF TextError = '' THEN
                            InsertJobQueueLogDetail(Rec, PurchInvHeader."No.", 'Processed', 2, 4, 'Invoice posted and emailed', 4);
                    UNTIL PurchRcptLine.NEXT = 0;
                END;
            UNTIL Vendor.NEXT = 0
        END;
    end;

    var
        Vendor: Record "Vendor";
        PurchHeader: Record "Purchase Header";
        Purch_GetReceipts: Codeunit "Purch.-Get Receipt";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        VendorBankAcc: Record "Vendor Bank Account";
        TotDocWithVAT: Decimal;
        TotDocWithoutVAT: Integer;
        LPurchLine: Record "Purchase Line";
        Text001: Label 'Posting invoices   #1########## @2@@@@@@@@@@@@@';
        Counter: Integer;
        CounterTotal: Integer;
        PurchPost: Codeunit "Purch.-Post";
        TextError: Text;
        CU50106: Codeunit "Self-Bill PurchCreateInv";
        i: Integer;
        FileManagement: Codeunit "File Management";
        CompanyInformation: Record "Company Information";

    // BC Upgrade MISHRS14 >>
    // Changed data type from option to enum of NewStatus to remove implicit warning 
    local procedure SetJobQueueStatus(var PurchHeader: Record "Purchase Header"; NewStatus: Enum "Document Job Queue Status");
    // BC Upgrade MISHRS14 <<

    begin
        PurchHeader.LOCKTABLE;
        IF PurchHeader.FIND THEN BEGIN
            PurchHeader."Job Queue Status" := NewStatus;
            PurchHeader.MODIFY;
            COMMIT;
        END;
    end;

    [TryFunction]
    local procedure MyTryFunction1();
    begin
        Purch_GetReceipts.SetPurchHeader(PurchHeader);
        Purch_GetReceipts.CreateInvLines(PurchRcptLine);
    end;

    local procedure InsertJobQueueLogDetail(JobQueueEntry: Record "Job Queue Entry"; DocNo: Code[20]; Message: Text; EntryType: Option Sale,Purchase; Status: Option Created,Posted,Printed,Email; Description: Text; DocumentType: Option Invoice,Receipt,Shipment,"Cr.Memo","Posted Invoice","Posted Receipt","Posted Shipment","Posted Cr.Memo");
    var
        JobQueueLogEntryDetails: Record "Job Queue Log Entry Detail FND";
        EntryNo: Integer;
    begin
        EntryNo := 1;
        IF JobQueueLogEntryDetails.FINDLAST THEN
            EntryNo := JobQueueLogEntryDetails."Entry No." + 1;
        JobQueueLogEntryDetails.INIT;
        JobQueueLogEntryDetails."Entry No." := EntryNo;
        JobQueueLogEntryDetails."User ID" := USERID;
        JobQueueLogEntryDetails."Execution Date/Time" := CURRENTDATETIME;
        JobQueueLogEntryDetails."Entry Type" := EntryType;
        JobQueueLogEntryDetails."Document No" := DocNo;
        JobQueueLogEntryDetails."Document Status" := Status;
        JobQueueLogEntryDetails.Message := COPYSTR(Message, 1, 250);
        JobQueueLogEntryDetails."Message 1" := COPYSTR(Message, 251, 250);
        JobQueueLogEntryDetails."Message 2" := COPYSTR(Message, 502, 250);
        JobQueueLogEntryDetails."Message 1" := COPYSTR(Message, 753, 250);
        JobQueueLogEntryDetails."Job Queue ID" := JobQueueEntry.ID;
        JobQueueLogEntryDetails."JQ Object ID to Run" := JobQueueEntry."Object ID to Run";
        JobQueueLogEntryDetails."JQ Object Type to Run" := JobQueueEntry."Object Type to Run";
        JobQueueLogEntryDetails."JQ Object Caption to Run" := JobQueueEntry."Object Caption to Run";
        JobQueueLogEntryDetails.Description := COPYSTR(Description, 1, 250);
        JobQueueLogEntryDetails."Document Type" := DocumentType;
        JobQueueLogEntryDetails.INSERT;
        COMMIT;
    end;
}

