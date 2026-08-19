report 52033 "Send POs to Requestors"
{
    // version HEI.08

    // HEI.01 CHG2157342 HB2809 IBM NANDIS01 25.07.2022 - Email notifications of Open Po's sent to Requestors
    //   # New report developed to create excel and send the same to respective requestor's email
    // HEI.02 CHG2157342 HB2809 IBM NANDIS01 22.09.2022 - Email notifications of Open Po's sent to Requestor
    //   # Small fixes after FAT
    // HEI.03 CHG2180515 HB3249 IBM NANDIS01 12.12.2022 - Send Email Reminder to Requesters
    //   # Logic to exclude doc subtype code from setup added
    // HEI.04 CHG2180515 HB3249 IBM NANDIS01 15.12.2022 - Send Email Reminder to Requesters
    //   # Document Subtype Code filter added in query object
    // HEI.05 CHG2198581 HB2809 IBM NANDIS01 24.04.2023 - to amend the setup on the Overdue date of the report developed
    //   # Code added to consider only overdue POs
    // HEI.06 CHG2198376 IBM NANDIS01 05.05.2023 #Overdue PO list send to requestors weekly
    //   # Changed the Email Body, only text constant value changed
    // HEI.07 CHG2198376 IBM NANDIS01 08.05.2023 #Overdue PO list send to requestors weekly
    //   # Made the Email Subject and Body in French language
    // HEI.08 CHG2198376 IBM NANDIS01 09.05.2023 #Overdue PO list send to requestors weekly
    //   # Language of Body and Subject of the email should be dependant on Company Info's Language field value

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Commented function-Language.GetLanguageID() as it does not exist in table 8 (Language) in newer BC versions and replaced it with Codeunit function-LANGUAGE.GetLanguageID
    // 3. Commented Drink-IT Fields related code.
    // 4. Commented SMTP & File Mgt. Related functionality and added new functionality to replace SMTP & File Mgt. functionality.
    // 5. Old Report ID-50557
    //BC Upgrade KAPOOV01  <<

    ProcessingOnly = true;
    ApplicationArea = All;   //BC Upgrade KAPOOV01
    UsageCategory = ReportsAndAnalysis;  //BC Upgrade KAPOOV01

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number);
            MaxIteration = 1;

            trigger OnPostDataItem();
            begin
                UserSetupTemp.RESET;
                if UserSetupTemp.FINDSET(false) then
                    repeat
                        CreateExcelHeder;
                        TempPurchaseLine.RESET;
                        //TempPurchaseLine.SETCURRENTKEY(TempPurchaseLine."Requester ID");  //BC Upgrade KAPOOV01 Drink-IT
                        //TempPurchaseLine.SETRANGE("Requester ID", UserSetupTemp."User ID"); //BC Upgrade KAPOOV01 Drink-IT
                        if TempPurchaseLine.FINDSET(false) then
                            repeat
                                CreateExcelBody(TempPurchaseLine);
                            until TempPurchaseLine.NEXT = 0;
                        TempExcelBuffer.WriteSheet('PO_' + FORMAT(TODAY, 0, '<Day,2>.<Month,2>.<Year,2>'), COMPANYNAME, USERID); //BC Upgrade KAPOOV01 Added 
                        TempExcelBuffer.CloseBook;
                        SendEmailWithAtachment(UserSetupTemp, ServerFileName);
                    until UserSetupTemp.NEXT = 0;

                if GUIALLOWED then
                    MESSAGE(Text50005);
            end;

            trigger OnPreDataItem();
            begin
                CLEAR(PurchaseOrdersperUser);
                //PurchaseOrdersperUser.SETFILTER(PurchaseOrdersperUser.Document_Subtype_Code,'%1',OPCOSetup."PO Doc. Subtype excluded");  //HEI.03
                //PurchaseOrdersperUser.SETFILTER(PurchaseOrdersperUser.Document_Subtype_Code, OPCOSetup."PO Doc. Subtype excluded");  //HEI.04 //BC Upgrade KAPOOV01 Drink-IT
                PurchaseOrdersperUser.SETFILTER(PurchaseOrdersperUser.Expected_Receipt_Date, '<=%1', TODAY);  //HEI.05
                PurchaseOrdersperUser.OPEN;
                while PurchaseOrdersperUser.READ do begin
                    InsertPurchOrderTemp;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        CLEAR(UserSetupTemp);
        CLEAR(TempPurchaseLine);
        OPCOSetup.GET;
        OPCOSetup.TESTFIELD("CC id for PO Send Email");
    end;

    var
        UserSetup: Record "User Setup";
        TempPurchaseLine: Record "Purchase Line" temporary;
        UserSetupTemp: Record "User Setup" temporary;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ServerFileName: Text;
        FileMgt: Codeunit "File Management";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        Text50004: Label 'There is no email setup to send email';
        SenderEmailL: Text;
        lrec_CompInfo: Record "Company Information";
        //SMTPMailSetup: Record "SMTP Mail Setup"; //BC Upgrade KAPOOV01 Commented SMTP Related functionality
        EmailSubject: TextConst ENU = 'Outstanding POs Requested By %1', FRA = 'Bons de commande ouvert demandés par %1';
        EmailBody: TextConst ENU = 'Dear %1, <br><br> The attached file contains the list of your open orders for which there are still quantities to be received to date and with an estimated delivery date exceeded. <br><br><br> Please receive them, change the delivery date, or close them. <br><br>', FRA = 'Dear %1, <br><br> Le fichier ci-joint contient la liste de vos commandes ouvertes pour lesquelles il reste encore des quantités à recevoir à ce jour et avec une date de livraison prévue dépassée. <br><br><br> Merci de les réceptionner, de changer la date de livraison, ou de les clôturer.';
        OPCOSetup: Record "OPCO Setup FND";
        Savepath: Text;
        Text50005: Label 'Process completed';
        PurchaseOrdersperUser: Query "Purchase Orders per User";
        ClientFileName: Text;
        ToEmail: Text;
        ToEmailName: Text;
        User: Record User;
        //BC Upgrade KAPOOV01 replaced with Table-Language with CU-LANGUAGE >>
        //Language: Record Language;
        LanguageCU: Codeunit LANGUAGE; //BC Upgrade KAPOOV01 Added
        //BC Upgrade KAPOOV01 replaced with Table-Language with CU-LANGUAGE <<

        //BC Upgrade KAPOOV01 >>
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
    //BC Upgrade KAPOOV01 <<

    procedure InsertPurchOrderTemp();
    begin
        if (PurchaseOrdersperUser.Maximo_Requisition_No = '') then begin
            TempPurchaseLine.INIT;
            TempPurchaseLine."Document Type" := PurchaseOrdersperUser.Document_Type;
            TempPurchaseLine."Document No." := PurchaseOrdersperUser.Document_No;
            TempPurchaseLine."Line No." := PurchaseOrdersperUser.Line_No;
            //TempPurchaseLine."Requester ID" := PurchaseOrdersperUser.Requester_ID; //BC Upgrade KAPOOV01 Drink-IT
            TempPurchaseLine."Machine Reference Number FND" := FORMAT(PurchaseOrdersperUser.Status);
            TempPurchaseLine."Buy-from Vendor No." := PurchaseOrdersperUser.Buy_from_Vendor_No;
            TempPurchaseLine."Description 2" := PurchaseOrdersperUser.Buy_from_Vendor_Name;
            TempPurchaseLine.Type := PurchaseOrdersperUser.Type;
            TempPurchaseLine."No." := PurchaseOrdersperUser.No;
            TempPurchaseLine.Description := PurchaseOrdersperUser.Description;
            TempPurchaseLine."Outstanding Quantity" := PurchaseOrdersperUser.Outstanding_Quantity;
            TempPurchaseLine."Expected Receipt Date" := PurchaseOrdersperUser.Expected_Receipt_Date;
            if PurchaseHeaderAdditional.GET(PurchaseHeaderAdditional."Document Type"::Order, PurchaseOrdersperUser.Document_No) then
                TempPurchaseLine."Additional Description FND" := PurchaseHeaderAdditional."Shopping Card No.";
            //HEI.02>>
            //IF (PurchaseOrdersperUser.Expected_Receipt_Date <> 0D) THEN
            if (PurchaseOrdersperUser.Expected_Receipt_Date <> 0D) and (PurchaseOrdersperUser.Expected_Receipt_Date <= TODAY) then
                //HEI.02<<
                TempPurchaseLine."Receipt Line No." := WORKDATE - PurchaseOrdersperUser.Expected_Receipt_Date;
            TempPurchaseLine.INSERT;
            //BC Upgrade KAPOOV01 Drink-IT- Code Block dependent on DRINK-IT Field-Requester_ID of Query- PurchaseOrdersperUser >>
            // if (PurchaseOrdersperUser.Requester_ID <> '') then
            //     if not UserSetupTemp.GET(PurchaseOrdersperUser.Requester_ID) then begin
            //         UserSetupTemp.INIT;
            //         UserSetupTemp."User ID" := PurchaseOrdersperUser.Requester_ID;
            //         UserSetupTemp.INSERT;
            //     end;
            //BC Upgrade KAPOOV01 Drink-IT- Code Block dependent on DRINK-IT Field-Requester_ID of Query- PurchaseOrdersperUser <<
        end else begin
            TempPurchaseLine.INIT;
            TempPurchaseLine."Document Type" := PurchaseOrdersperUser.Document_Type;
            TempPurchaseLine."Document No." := PurchaseOrdersperUser.Document_No;
            TempPurchaseLine."Line No." := PurchaseOrdersperUser.Line_No;
            //TempPurchaseLine."Requester ID" := PurchaseOrdersperUser.PQ_Approver; //BC Upgrade KAPOOV01 Drink-IT
            TempPurchaseLine."Machine Reference Number FND" := FORMAT(PurchaseOrdersperUser.Status);
            TempPurchaseLine."Buy-from Vendor No." := PurchaseOrdersperUser.Buy_from_Vendor_No;
            TempPurchaseLine."Description 2" := PurchaseOrdersperUser.Buy_from_Vendor_Name;
            TempPurchaseLine.Type := PurchaseOrdersperUser.Type;
            TempPurchaseLine."No." := PurchaseOrdersperUser.No;
            TempPurchaseLine.Description := PurchaseOrdersperUser.Description;
            TempPurchaseLine."Outstanding Quantity" := PurchaseOrdersperUser.Outstanding_Quantity;
            TempPurchaseLine."Expected Receipt Date" := PurchaseOrdersperUser.Expected_Receipt_Date;
            if PurchaseHeaderAdditional.GET(PurchaseHeaderAdditional."Document Type"::Order, PurchaseOrdersperUser.Document_No) then
                TempPurchaseLine."Additional Description FND" := PurchaseHeaderAdditional."Shopping Card No.";
            //HEI.02>>
            //IF (PurchaseOrdersperUser.Expected_Receipt_Date <> 0D) THEN
            if (PurchaseOrdersperUser.Expected_Receipt_Date <> 0D) and (PurchaseOrdersperUser.Expected_Receipt_Date <= TODAY) then
                //HEI.02<<
                TempPurchaseLine."Receipt Line No." := WORKDATE - PurchaseOrdersperUser.Expected_Receipt_Date;
            TempPurchaseLine.INSERT;
            //IF (PurchaseOrdersperUser.Requester_ID <> '') THEN  //HEI.02
            if (PurchaseOrdersperUser.PQ_Approver <> '') then  //HEI.02
                if not UserSetupTemp.GET(PurchaseOrdersperUser.PQ_Approver) then begin
                    UserSetupTemp.INIT;
                    UserSetupTemp."User ID" := PurchaseOrdersperUser.PQ_Approver;
                    UserSetupTemp.INSERT;
                end;
        end;
    end;

    local procedure CreateExcelHeder();
    begin
        CLEAR(TempExcelBuffer);
        TempExcelBuffer.DELETEALL(false);
        TempExcelBuffer.ClearNewRow;
        TempExcelBuffer.NewRow;
        TempExcelBuffer.AddColumn('PO Number', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Status', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Vendor No', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Vendor Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Line No', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Type', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('No', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Description', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Outstanding Qty', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Expected Receipt Date', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Shopping Cart', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Overdue', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);

        //BC Upgrade KAPOOV01 Commented FileMgt related functionality >>
        // ServerFileName := FileMgt.ServerTempFileName('xlsx');
        // TempExcelBuffer.CreateBook(ServerFileName, 'PO_' + FORMAT(TODAY, 0, '<Day,2>.<Month,2>.<Year,2>'));
        // TempExcelBuffer.WriteSheet('PO_' + FORMAT(TODAY, 0, '<Day,2>.<Month,2>.<Year,2>'), COMPANYNAME, USERID);
        //BC Upgrade KAPOOV01 Commented FileMgt related functionality <<


        //BC Upgrade KAPOOV01 Added to replace FileMgt. related functionality >>
        ServerFileName := 'PO_Report_' + COMPANYNAME + '_' + FORMAT(TODAY, 0, '<Day,2><Month,2><Year>') + FORMAT(TIME, 0, '<Hours24,2><Filler Character,0><Minutes,2>' + '.xlsx'); //BC Upgrade KAPOOV01 update ServerFileName.
        TempBlob.CreateOutStream(OutStr);  //BC Upgrade KAPOOV01 Create Outstream.
        TempExcelBuffer.CreateNewBook('PO_' + FORMAT(TODAY, 0, '<Day,2>.<Month,2>.<Year,2>'));//BC Upgrade KAPOOV01 replaced CreateBook with CreateNewBook.
                                                                                              //BC Upgrade KAPOOV01 Added to replace FileMgt. related functionality <<

    end;

    local procedure CreateExcelBody(TempPurchaseLine: Record "Purchase Line" temporary);
    begin
        TempExcelBuffer.NewRow;
        TempExcelBuffer.AddColumn(TempPurchaseLine."Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TempPurchaseLine."Machine Reference Number FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TempPurchaseLine."Buy-from Vendor No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TempPurchaseLine."Description 2", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TempPurchaseLine."Line No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TempPurchaseLine.Type, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TempPurchaseLine."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TempPurchaseLine.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //TempExcelBuffer.AddColumn(TempPurchaseLine."Outstanding Quantity" ,FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);  //HEI.02
        TempExcelBuffer.AddColumn(TempPurchaseLine."Outstanding Quantity", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);  //HEI.02
        //TempExcelBuffer.AddColumn(TempPurchaseLine."Expected Receipt Date",FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);  //HEI.02
        TempExcelBuffer.AddColumn(TempPurchaseLine."Expected Receipt Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);  //HEI.02
        TempExcelBuffer.AddColumn(TempPurchaseLine."Additional Description FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //TempExcelBuffer.AddColumn(TempPurchaseLine."Receipt Line No.",FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);  //HEI.02
        TempExcelBuffer.AddColumn(TempPurchaseLine."Receipt Line No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);  //HEI.02
        //TempExcelBuffer.WriteSheet('PO_' + FORMAT(TODAY, 0, '<Day,2>.<Month,2>.<Year,2>'), COMPANYNAME, USERID);   //BC Upgrade KAPOOV01 Commented
    end;

    local procedure SendEmailWithAtachment(UserSetupTemp: Record "User Setup" temporary; ClientFileName: Text);
    var
        //SMTPMailSetup: Record "SMTP Mail Setup";  //BC Upgrade KAPOOV01 Commented SMTP Related functionality
        //SMTP: Codeunit "SMTP Mail";  //BC Upgrade KAPOOV01 Commented SMTP Related functionality
        Email: Codeunit Email; //BC Upgrade KAPOOV01 Added
        EmailMessage: Codeunit "Email Message"; //BC Upgrade KAPOOV01 Added
        FileInStream: InStream; //BC Upgrade KAPOOV01 Added

    begin
        //CLEAR(SMTP); //BC Upgrade KAPOOV01 Commented SMTP Related functionality
        ToEmail := '';  //HEI.02
        ToEmailName := '';  //HEI.02
        lrec_CompInfo.GET;

        //HEI.02>>
        //IF UserSetup.GET(UserSetupTemp."User ID") THEN;
        if UserSetup.GET(UserSetupTemp."User ID") then begin
            ToEmail := UserSetup."E-Mail";
            User.RESET;
            User.SETRANGE("User Name", UserSetup."User ID");
            if User.FINDFIRST then
                ToEmailName := User."Full Name";
        end;
        //HEI.02<<
        //BC Upgrade KAPOOV01 Commented SMTP Related functionality >>
        // SMTPMailSetup.GET;
        // if SMTPMailSetup."User ID" <> '' then
        //     SenderEmailL := SMTPMailSetup."User ID"
        // else
        //BC Upgrade KAPOOV01 Commented SMTP Related functionality <<
        SenderEmailL := lrec_CompInfo."E-Mail";
        if SenderEmailL = '' then
            ERROR(Text50004);

        //HEI.08>>
        if (lrec_CompInfo."Language Code FND" <> '') then
            //CurrReport.LANGUAGE := Language.GetLanguageID(lrec_CompInfo."Language Code"); //BC Upgrade KAPOOV01 Commented-Language.GetLanguageID() does not exist in table 8 (Language) in newer BC versions.
            CurrReport.LANGUAGE := LanguageCU.GetLanguageID(lrec_CompInfo."Language Code FND"); //BC Upgrade KAPOOV01 Added replaced with Table-Language with CU-LANGUAGE.
        //HEI.08<<
        if (UserSetup."E-Mail" <> '') then begin
            //SMTP.CreateMessage('PO',SenderEmailL,UserSetup."E-Mail",EmailSubject,EmailBody,TRUE);  //HEI.02

            //BC Upgrade KAPOOV01 Commented SMTP Related functionality >>
            // SMTP.CreateMessage('PO', SenderEmailL, ToEmail, STRSUBSTNO(EmailSubject, ToEmailName), STRSUBSTNO(EmailBody, ToEmailName), true);  //HEI.02
            // SMTP.AddCC(OPCOSetup."CC id for PO Send Email");
            // SMTP.AddAttachment(ClientFileName,
            //                    //'PO_RequesterID' +  HEI.02
            //                    'PO_' + ToEmailName +  //HEI.02
            //                    FORMAT(TODAY, 0, '<Day,2>-<Month,2>-<Year,2>') + ' ' +
            //                    FORMAT(TIME, 0, '<Hours24,2>-<Minutes,2>-<Seconds,2>') +
            //                    '.xlsx');
            // SMTP.Send;
            //BC Upgrade KAPOOV01 Commented SMTP Related functionality <<

            //BC Upgrade KAPOOV01 Added to replace SMTP Related functionality >>

            TempExcelBuffer.SaveToStream(OutStr, true);
            TempBlob.CreateInStream(FileInStream);

            // Create email message
            EmailMessage.Create(
                ToEmail, EmailSubject, EmailBody, TRUE);

            // Add CC if needed
            EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, OPCOSetup."CC id for PO Send Email");

            // Add attachment
            EmailMessage.AddAttachment(ClientFileName, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', FileInStream);

            // Send email added "Email Scenario"::Default should be based on Setup required by user.
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

            //BC Upgrade KAPOOV01 Added to replace SMTP Related functionality <<

        end;
    end;
}

