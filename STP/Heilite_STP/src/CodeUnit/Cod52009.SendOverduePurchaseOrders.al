codeunit 52009 "Send Overdue Purchase Orders"
{
    // version HEI.01

    // HEI.01 CHG2241988 SAHAL01 20.08.2024 Email Notification of Open POs Sent To Requestors Managers
    //   # Created New Codeunit: 50225 - Send Overdue Purchase Orders
    //   # Created New Functions - MakeExcelDataHeader
    //                           - MakeExcelDataBody
    //                           - SendEmailWithAtachment

    //BC UPGRADE ATHUKS01>>
    //1.Added new code for make exce buffer to tempblob.
    //BC UPGRADE ATHUKS01<<
    // BC Upgrade BHARAD11 >> --IBM-STP-MED-02
    /* Change Export to excel functionality with Report. Create new report and add that report in the code. */
    // BC Upgrade BHARAD11 << --IBM-STP-MED-02
    trigger OnRun();
    var
        PurchaseHeaderL: Record "Purchase Header";
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
        PurchaseLineL: Record "Purchase Line";
        NoOfDaysL: Integer;
        UserSetupL: Record "User Setup";
        EmailToUserIDL: Code[50];
        PurchOrderOverdueEntryL: Record "Purch Order Overdue Entry FND";
        UserIDEntryBufferL: Record "User ID Entry Buffer FND";
        UserL: Record User;
        SendEmailL: Boolean;
        NearOverdueL: Integer;
        LanguageL: Record Language;
        // SMTPMailSetupL: Record "SMTP Mail Setup";//BC Upgrade SHARMP16-- SMTP not exsist
        LastExecutionDateL: Date;
        CreateNewL: Boolean;
        NoOfEmailsL: Integer;
        iL: Integer;
        UserIDEntryBufferL2: Record "User ID Entry Buffer FND";
        TempBlobL: Codeunit "Temp Blob";
        OutStr: OutStream;
        EmailAccount: Record "Email Account";
        EmailScenario: Codeunit "Email Scenario";
    begin
        //HEI.01>>
        CLEAR(ServerFileName);
        CLEAR(SenderEmail);
        PurchPaySetup.GET;
        if not PurchPaySetup."Enabled Overdue Notifi. FND" then
            exit;
        PurchPaySetup.TESTFIELD("Overdue Days Email Notify FND");
        PurchPaySetup.TESTFIELD("CC Email ID for PO Send FND");
        PurchPaySetup.TESTFIELD("Exclude PO Doc. Subtype FND");
        if PurchPaySetup."No. of Emails Send Batch FND" <> 0 then
            NoOfEmailsL := PurchPaySetup."No. of Emails Send Batch FND";
        CompInfo.GET;
        //BC Upgrade SHARMP16 BEGIN>> ----- EmailId customization.

        if EmailScenario.GetEmailAccount(Enum::"Email Scenario"::"Purchase Order", EmailAccount) then begin
            if EmailAccount."Email Address" <> '' then
                SenderEmail := EmailAccount."Email Address";
        end else begin
            SenderEmail := CompInfo."E-Mail";
        end;
        //BC Upgrade SHARMP16 END<< ----- EmailId customization.
        // SMTPMailSetupL.GET;
        // if SMTPMailSetupL."User ID" <> '' then//BC Upgrade SHARMP16-- SMTP not exsist
        //     SenderEmail := SMTPMailSetupL."User ID"//BC Upgrade SHARMP16-- SMTP not exsist
        // else//BC Upgrade SHARMP16-- SMTP not exsist
        // SenderEmail := CompInfo."E-Mail";
        if SenderEmail = '' then
            ERROR(Text001);

        CreateNewL := true;
        UserIDEntryBufferL.SETCURRENTKEY("Email Sent");
        UserIDEntryBufferL.SETRANGE("Email Sent", false);
        if UserIDEntryBufferL.FINDLAST then begin
            if PurchOrderOverdueEntryL.FINDLAST then begin
                if UserIDEntryBufferL."Last Execution Date-Time" <> 0DT then begin
                    LastExecutionDateL := DT2DATE(UserIDEntryBufferL."Last Execution Date-Time");
                    if (LastExecutionDateL = TODAY) and (UserIDEntryBufferL."Last Executed By" = USERID) then begin
                        CLEAR(CreateNewL);
                        SendEmailL := true;
                    end;
                end;
                if PurchOrderOverdueEntryL."Last Execution Date-Time" <> 0DT then begin
                    LastExecutionDateL := DT2DATE(PurchOrderOverdueEntryL."Last Execution Date-Time");
                    if (LastExecutionDateL = TODAY) and (PurchOrderOverdueEntryL."Last Executed By" = USERID) then begin
                        CLEAR(CreateNewL);
                        SendEmailL := true;
                    end else
                        CreateNewL := true;
                end;
            end;
        end else begin
            UserIDEntryBufferL.SETRANGE("Email Sent", true);
            if UserIDEntryBufferL.FINDLAST then begin
                if UserIDEntryBufferL."Last Execution Date-Time" <> 0DT then begin
                    LastExecutionDateL := DT2DATE(UserIDEntryBufferL."Last Execution Date-Time");
                    if (LastExecutionDateL = TODAY) and (UserIDEntryBufferL."Last Executed By" = USERID) then begin
                        CLEAR(CreateNewL);
                        CLEAR(SendEmailL);
                        exit;
                    end;
                end;
            end;
        end;

        if CreateNewL then begin
            CLEAR(SendEmailL);
            if STRPOS(FORMAT(PurchPaySetup."Overdue Days Email Notify FND"), Text004) <> 0 then
                EVALUATE(NoOfDaysL, DELCHR(FORMAT(PurchPaySetup."Overdue Days Email Notify FND"), '>', Text004));

            PurchaseHeaderL.SETCURRENTKEY("Document Type", Status, "Document Subtype Code FND");//BC Upgrade SHUKLP03
            PurchaseHeaderL.Reset();
            PurchaseHeaderL.SetBaseLoadFields();
            PurchaseHeaderL.SETRANGE("Document Type", PurchaseHeaderL."Document Type"::Order);
            PurchaseHeaderL.SETFILTER(Status, '%1|%2', PurchaseHeaderL.Status::Released, PurchaseHeaderL.Status::"Pending Prepayment");
            PurchaseHeaderL.SETFILTER("Document Subtype Code FND", PurchPaySetup."Exclude PO Doc. Subtype FND");//BC Upgrade SHUKLP03
            if PurchaseHeaderL.FINDSET(false) then begin
                PurchOrderOverdueEntryL.RESET;
                PurchOrderOverdueEntryL.DELETEALL(false);
                UserIDEntryBufferL.RESET;
                UserIDEntryBufferL.DELETEALL(false);
                repeat
                    CLEAR(PurchaseHeaderAddL);
                    CLEAR(EmailToUserIDL);
                    CLEAR(UserSetupL);
                    CLEAR(UserIDEntryBufferL);
                    CLEAR(UserL);
                    EmailToUserIDL := UserId;
                    if PurchaseHeaderAddL.GET(PurchaseHeaderL."Document Type", PurchaseHeaderL."No.") then;
                    if (PurchaseHeaderL."Maximo Requisition No. FND" <> '') and (PurchaseHeaderAddL."PQ Approver" <> '') then
                        EmailToUserIDL := PurchaseHeaderAddL."PQ Approver"
                    else
                        EmailToUserIDL := PurchaseHeaderL."Requester ID IBM FND"; // BC Upgrade BHARAD11 31March202

                    //  //BC Upgrade SHARMP16-- Drink-IT fields used
                    if EmailToUserIDL <> '' then begin
                        if UserSetupL.GET(EmailToUserIDL) and (UserSetupL."E-Mail" <> '') then begin
                            PurchaseLineL.RESET;
                            PurchaseLineL.SETCURRENTKEY("Document Type", "Document No.", Type, "Delivery Finalized FND", "Expected Receipt Date", "Outstanding Quantity");
                            PurchaseLineL.SETRANGE("Document Type", PurchaseHeaderL."Document Type");
                            PurchaseLineL.SETRANGE("Document No.", PurchaseHeaderL."No.");
                            PurchaseLineL.SETFILTER(Type, '<>%1', PurchaseLineL.Type::" ");
                            PurchaseLineL.SETRANGE("Delivery Finalized FND", false);
                            PurchaseLineL.SETRANGE("Expected Receipt Date", 0D, CALCDATE(PurchPaySetup."Overdue Days Email Notify FND", TODAY));
                            PurchaseLineL.SETFILTER("Outstanding Quantity", '<>0');
                            if PurchaseLineL.FINDSET(false) then begin
                                if not UserIDEntryBufferL.GET(EmailToUserIDL) then begin
                                    UserL.SETCURRENTKEY("User Name", State);
                                    UserL.SETRANGE("User Name", EmailToUserIDL);
                                    UserL.SETRANGE(State, UserL.State::Enabled);
                                    if UserL.FINDFIRST then begin
                                        UserIDEntryBufferL.INIT;
                                        UserIDEntryBufferL."User ID" := UserSetupL."User ID";
                                        UserIDEntryBufferL."Full Name" := UserL."Full Name";
                                        UserIDEntryBufferL."E-Mail ID" := UserSetupL."E-Mail";
                                        UserIDEntryBufferL."Last Execution Date-Time" := CURRENTDATETIME;
                                        UserIDEntryBufferL."Last Executed By" := USERID;
                                        UserIDEntryBufferL.INSERT(false);
                                        if not SendEmailL then
                                            SendEmailL := true;
                                    end;
                                end;
                                CLEAR(UserIDEntryBufferL);
                                if UserIDEntryBufferL.GET(EmailToUserIDL) then begin
                                    repeat
                                        CLEAR(NearOverdueL);
                                        PurchOrderOverdueEntryL.INIT;
                                        PurchOrderOverdueEntryL."Entry No." += 1;
                                        PurchOrderOverdueEntryL."Document Type" := PurchaseHeaderL."Document Type".AsInteger();
                                        PurchOrderOverdueEntryL."Document No." := PurchaseHeaderL."No.";
                                        PurchOrderOverdueEntryL."Posting Date" := PurchaseHeaderL."Posting Date";
                                        PurchOrderOverdueEntryL."Buy-from Vendor No." := PurchaseHeaderL."Buy-from Vendor No.";
                                        PurchOrderOverdueEntryL."Buy-from Vendor Name" := PurchaseHeaderL."Buy-from Vendor Name";
                                        PurchOrderOverdueEntryL."Buy-from Vendor Name 2" := PurchaseHeaderL."Buy-from Vendor Name 2";
                                        PurchOrderOverdueEntryL.Status := PurchaseHeaderL.Status.AsInteger();
                                        PurchOrderOverdueEntryL."Maximo Requisition No." := PurchaseHeaderL."Maximo Requisition No. FND";
                                        PurchOrderOverdueEntryL."Document Subtype Code" := PurchaseHeaderL."Document Subtype Code FND";//BC Upgrade SHUKLP03
                                                                                                                                   //PurchOrderOverdueEntryL."Requester ID" := PurchaseHeaderL."Requester ID";//BC Upgrade SHUKLP03 << DIT Field.
                                        PurchOrderOverdueEntryL."PQ Approver" := PurchaseHeaderAddL."PQ Approver";
                                        PurchOrderOverdueEntryL."Email To User ID" := EmailToUserIDL;
                                        PurchOrderOverdueEntryL."Line No." := PurchaseLineL."Line No.";
                                        PurchOrderOverdueEntryL.Type := PurchaseLineL.Type.AsInteger();
                                        PurchOrderOverdueEntryL."No." := PurchaseLineL."No.";
                                        PurchOrderOverdueEntryL.Description := PurchaseLineL.Description;
                                        PurchOrderOverdueEntryL."Description 2" := PurchaseLineL."Description 2";
                                        PurchOrderOverdueEntryL."Unit of Measure" := PurchaseLineL."Unit of Measure";
                                        PurchOrderOverdueEntryL.Quantity := PurchaseLineL.Quantity;
                                        PurchOrderOverdueEntryL."Outstanding Quantity" := PurchaseLineL."Outstanding Quantity";
                                        PurchOrderOverdueEntryL."Expected Receipt Date" := PurchaseLineL."Expected Receipt Date";
                                        PurchOrderOverdueEntryL."Shopping Card No." := PurchaseHeaderAddL."Shopping Card No.";
                                        if PurchOrderOverdueEntryL."Expected Receipt Date" <> 0D then begin
                                            PurchOrderOverdueEntryL.Overdue := TODAY - PurchOrderOverdueEntryL."Expected Receipt Date";
                                            if NoOfDaysL <> 0 then begin
                                                NearOverdueL := PurchOrderOverdueEntryL."Expected Receipt Date" - TODAY;
                                                if (NearOverdueL <= NoOfDaysL) and (NearOverdueL > 0) then
                                                    PurchOrderOverdueEntryL."Soon To Be Overdue" := NearOverdueL;
                                            end;
                                        end;
                                        PurchOrderOverdueEntryL."System-Created Entry" := PurchaseLineL."System-Created Entry";
                                        PurchOrderOverdueEntryL."Delivery Finalized" := PurchaseLineL."Delivery Finalized FND";
                                        PurchOrderOverdueEntryL."Last Execution Date-Time" := CURRENTDATETIME;
                                        PurchOrderOverdueEntryL."Last Executed By" := USERID;
                                        PurchOrderOverdueEntryL.INSERT(false);
                                    until PurchaseLineL.NEXT = 0;
                                end;
                            end;
                        end;
                    end;
                until PurchaseHeaderL.NEXT = 0;
            end;
        end;

        if SendEmailL then begin
            UserIDEntryBufferL.RESET;
            UserIDEntryBufferL.SETCURRENTKEY("Email Sent");
            UserIDEntryBufferL.SETRANGE("Email Sent", false);
            if UserIDEntryBufferL.FINDSET(false) then begin
                if CompInfo."Language Code FND" <> '' then
                    //  GLOBALLANGUAGE := LanguageL.GetLanguageID(CompInfo."Language Code");//BC Upgrade SHARMP16
                    //BC Upgrade SHARMP16 BEGIN>> --- replacement of above code.
                    if LanguageL.Get(CompInfo."Language Code FND") then
                        GLOBALLANGUAGE := LanguageL."Windows Language ID";
                //BC Upgrade SHARMP16 END<< --- replacement of above code.
                repeat
                    PurchOrderOverdueEntryL.RESET;
                    PurchOrderOverdueEntryL.SETCURRENTKEY("Email To User ID");
                    PurchOrderOverdueEntryL.SETRANGE("Email To User ID", UserIDEntryBufferL."User ID");
                    if PurchOrderOverdueEntryL.FINDSET(false) then begin
                        iL += 1;
                        // BC Upgrade BHARDA11 >> IBM-STP-MED-02---I have commented out the Excel Buffer logic and created a layout-based report instead. The report is converted into Excel format and sent via email. Therefore, this code is no longer required. IBM-STP-MED-02
                        // MakeExcelDataHeader;
                        // repeat
                        //     MakeExcelDataBody(PurchOrderOverdueEntryL);
                        // until PurchOrderOverdueEntryL.NEXT = 0;
                        // //TempExcelBuffer.WriteSheet('PO_' + FORMAT(TODAY, 0, '<Day,2>.<Month,2>.<Year,2>'), COMPANYNAME, USERID); //BC Upgrade KAPOOV01 Added 
                        // //TempExcelBuffer.CloseBook;
                        // MakeExcelToTempBlob(TempBlobL);
                        // Commit();
                        // BC Upgrade BHARDA11 << IBM-STP-MED-02---I have commented out the Excel Buffer logic and created a layout-based report instead. The report is converted into Excel format and sent via email. Therefore, this code is no longer required. IBM-STP-MED-02
                        SendEmailWithAttachment(UserIDEntryBufferL, TempBlobL, PurchOrderOverdueEntryL); // BC Upgrade BHARDA11 -- Add one more peremeter
                        CLEAR(UserIDEntryBufferL2);
                        UserIDEntryBufferL2.GET(UserIDEntryBufferL."User ID");
                        UserIDEntryBufferL2."Email Sent" := true;
                        UserIDEntryBufferL2."Last Email Sent Date" := TODAY;
                        UserIDEntryBufferL2."Last Email Sent Time" := TIME;
                        UserIDEntryBufferL2."Last Email Sent By" := USERID;
                        UserIDEntryBufferL2.MODIFY(false);
                        COMMIT;
                    end;
                until (UserIDEntryBufferL.NEXT = 0) or (iL = NoOfEmailsL);
            end;
        end;
        //HEI.01<<
    end;

    var
        PurchPaySetup: Record "Purchases & Payables Setup";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ServerFileName: Text[250];
        Text001: Label 'There is no Email Setup to send Email from Sender ID.';
        Text002: Label 'PO';
        Text003: Label 'PO_';
        Text004: Label 'D';
        Text005: Label 'Purchase Order No.';
        Text006: Label 'Status';
        Text007: Label 'Vendor No.';
        Text008: Label 'Vendor Name';
        Text009: Label 'Line No.';
        Text010: Label 'Type';
        Text011: Label 'No.';
        Text012: Label 'Description';
        Text013: Label 'Outstanding Quantiy';
        Text014: Label 'Expected Receipt Date';
        Text015: Label 'Shopping Cart';
        Text016: Label 'Overdue';
        Text017: Label 'Soon To Be Overdue';
        CompInfo: Record "Company Information";
        SenderEmail: Text[100];

    local procedure MakeExcelDataHeader();
    var
        FileMgtL: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
    begin
        //HEI.01>>
        // if EXISTS(ServerFileName) then
        //     ERASE(ServerFileName);
        CLEAR(ServerFileName);
        TempExcelBuffer.DELETEALL(false);
        TempExcelBuffer.ClearNewRow;
        TempExcelBuffer.NewRow;
        TempExcelBuffer.AddColumn(Text005, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Text006, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Text007, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Text008, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Text009, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Text010, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Text011, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Text012, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Text013, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Text014, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Text015, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Text016, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Text017, false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //ServerFileName := FileMgtL.ServerTempFileName('xlsx');
        //ServerFileName := 'PO_Report_' + COMPANYNAME + '_' + FORMAT(TODAY, 0, '<Day,2><Month,2><Year>') + FORMAT(TIME, 0, '<Hours24,2><Filler Character,0><Minutes,2>' + '.xlsx');
        // TempBlob.CreateOutStream(Outstr);
        // TempExcelBuffer.CreateNewBook('OverduePO.xlsx')
        //  TempExcelBuffer.CreateNewBook(Text003 + FORMAT(TODAY, 0, '<Day,2>.<Month,2>.<Year,2>'));
        // TempExcelBuffer.WriteSheet(Text003, '', '');
        TempExcelBuffer.CreateNewBook('OverduePO');
        TempExcelBuffer.WriteSheet('OverduePO', CompanyName, UserId);

        //HEI.01<<
    end;

    local procedure MakeExcelDataBody(var PurchaseOrderOverdueEntry: Record "Purch Order Overdue Entry FND");
    begin
        //HEI.01>>
        TempExcelBuffer.NewRow;
        TempExcelBuffer.AddColumn(PurchaseOrderOverdueEntry."Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseOrderOverdueEntry.Status, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseOrderOverdueEntry."Buy-from Vendor No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseOrderOverdueEntry."Buy-from Vendor Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseOrderOverdueEntry."Line No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseOrderOverdueEntry.Type, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseOrderOverdueEntry."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseOrderOverdueEntry.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseOrderOverdueEntry."Outstanding Quantity", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(PurchaseOrderOverdueEntry."Expected Receipt Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(PurchaseOrderOverdueEntry."Shopping Card No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PurchaseOrderOverdueEntry.Overdue, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(PurchaseOrderOverdueEntry."Soon To Be Overdue", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        // TempExcelBuffer.WriteSheet(Text003, '', '');
        //HEI.01<<
    end;
    //BC Upgrade SHARMP16-- SMTP not exsist
    // local procedure SendEmailWithAtachment(var UserIDEntryBuffer: Record "User ID Entry Buffer FND"; ClientFileName: Text);
    // var
    //     SMTPL: Codeunit "SMTP Mail";
    // begin
    //     //HEI.01>>
    //     if UserIDEntryBuffer."E-Mail ID" <> '' then begin
    //         SMTPL.CreateMessage(Text002 + '_' + CompInfo."Custom System Indicator Text", SenderEmail, UserIDEntryBuffer."E-Mail ID", UserIDEntryBuffer."Full Name", UserIDEntryBuffer."Full Name", true);
    //         SMTPL.AddCC(PurchPaySetup."CC Email ID for PO Send");
    //         SMTPL.AddAttachment(ClientFileName,
    //                            Text003 + UserIDEntryBuffer."Full Name" +
    //                            FORMAT(TODAY, 0, '<Day,2>-<Month,2>-<Year,2>') + ' ' +
    //                            FORMAT(TIME, 0, '<Hours24,2>-<Minutes,2>-<Seconds,2>') +
    //                            '.xlsx');
    //         SMTPL.Send;
    //     end;
    //HEI.01<<
    // end;
    //BC Upgrade SHARMP16-- SMTP not exsist
    //BC Upgrade SHARMP16  BEGIN>> --------Email functionality
    local procedure MakeExcelToTempBlob(var TempBlob: Codeunit "Temp Blob")
    var
        OutStr: OutStream;
        ServerFileName: Text;
    begin
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('OverduePO');

        //BC UPGRADE ATHUKS01>>
        // Write Excel into TempBlob
        TempBlob.CreateOutStream(OutStr);

        TempExcelBuffer.SaveToStream(OutStr, true);
        TempBlob.CreateInStream(FileInStream);
        TempExcelBuffer.UpdateBookStream(FileInStream, 'OverduePO', true);   // <-- This writes the file into the TempBlob and erase the file after completion
                                                                             //BC UPGRADE ATHUKS01<<
    end;

    local procedure SendEmailWithAttachment(
    var UserIDEntryBuffer: Record "User ID Entry Buffer FND";
    TempBlob: Codeunit "Temp Blob"; PurchOrderOverdueEntryL2: Record "Purch Order Overdue Entry FND")
    var
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        InStr: InStream;
        Base64: Codeunit "Base64 Convert";
        Base64Txt: Text;
        FileName: Text;
        Subject: Text;
        Body: Text;
        ContentType: Text;
        EmailScenario: Codeunit "Email Scenario";
        EmailAccount: Record "Email Account";
        // EmailMessage: Codeunit "Email Message";
        // BC Upgrade BHARAD11 >> --IBM-STP-MED-02
        NAVOutStream: OutStream;
        RecRef: RecordRef;
        NAVInStream: InStream;
    // BC Upgrade BHARAD11 << --IBM-STP-MED-02

    begin
        if UserIDEntryBuffer."E-Mail ID" = '' then
            exit;

        FileName := 'OverduePO' + '.xlsx';  // BC Upgrade BHARAD11 >> --IBM-STP-MED-02

        Subject := Text002 + '_' + CompInfo."Custom System Indicator Text";
        Body :=
            'Dear ' + UserIDEntryBuffer."Full Name" + ',<br><br>' +
            'Please find attached the overdue purchase order report.' + '<br><br>' +
            'Regards,<br>' + CompInfo.Name;
        //Correct Order: Create → AddRecipient → AddAttachment → Send
        // 1. Create the email message
        EmailMsg.Create(UserIDEntryBuffer."E-Mail ID", Subject, Body, true);


        // 2. Add recipients
        // EmailMsg.AddRecipient(Enum::"Email Recipient Type"::"To", UserIDEntryBuffer."E-Mail ID");

        if PurchPaySetup."CC Email ID for PO Send FND" <> '' then
            EmailMsg.AddRecipient(Enum::"Email Recipient Type"::Cc, PurchPaySetup."CC Email ID for PO Send FND");

        // 3. Convert TempBlob to Base64
        //TempBlob.CreateInStream(InStr);
        // BC Upgrade BHARDA11 >> --IBM-STP-MED-02
        TempBlob.CreateOutStream(NAVOutStream, TEXTENCODING::UTF8);
        RecRef.GetTable(PurchOrderOverdueEntryL2);
        REPORT.SAVEAS(Report::"Send Overdue Purchase Order", '', REPORTFORMAT::Excel, NAVOutStream, Recref);
        TempBlob.CreateInStream(NAVInStream);
        EmailMsg.AddAttachment(FileName, '.xlsx', NAVInStream);
        // BC Upgrade BHARAD11 << --IBM-STP-MED-02
        //Base64Txt := Base64.ToBase64(InStr);
        ContentType := 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
        //  4. Add attachment
        // BC Upgrade BHARAD11 >> --IBM-STP-MED-02
        // EmailMsg.AddAttachment(
        //     FileName + '.xlsx',
        //    ContentType,
        //     FileInStream);
        // BC Upgrade BHARAD11 << --IBM-STP-MED-02

        // 5. Send email using Purchase Order scenario
        if EmailScenario.GetEmailAccount(Enum::"Email Scenario"::"Purchase Order", EmailAccount) then begin
            if EmailAccount."Email Address" <> '' then
                Email.Send(EmailMsg, Enum::"Email Scenario"::"Purchase Order")
            else
                Email.Send(EmailMsg, Enum::"Email Scenario"::Default)
        end else begin
            Email.Send(EmailMsg, Enum::"Email Scenario"::Default);

        end;
    end;
    //BC Upgrade SHARMP16  END<< --------Email functionality

    var

        FileInStream: InStream;
}
