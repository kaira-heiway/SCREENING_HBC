codeunit 58132 "DDE Interface Mgmt."
{
    // version HEI.04

    // HEI.01 FDD-HT678 IBM NASTAA02 25.08.2020 # DMS / DDE Integration
    //   # New Codeunit created for DMS / DDE Interfaces
    // HEI.02 HB2300 - CHG2113543 IBM NASTAA02 16.12.2021 # DDE DRC
    //   # Added Tenant and Company to the Shipment Interface
    // HEI.03 CHG2223925 IBM SISUM01 13.11.2023 HB3575 HTI | DMS - BASE Include "IsGift" field in BASE related to DDE shipment
    //   #Add IsGrift value to send to xml file
    // HEI.04 CHG2249480 IBM COSTES04 21.06.2024 Burundi-shipment to DDE – sending all distributors related shipments to DDE
    //   # new function IsManualDDEShipmentEnabled

    // BC Upgrade VAMSIU01 >>
    // # Old Nav ID - 50120.
    // # Codeunit 50141 ID is changed to 58113 where OnAfterCreateSalesDocument event is Subscribed to write the code.
    // # Filemanagement is handled using tempblob.
    // # SMTP is handled using BC base Email Functionality.
    // BC Upgrade VAMSIU01 <<

    // BC Upgrade MISHRS14 >>
    // Added HEI.05 Tag
    // HEI.05 CHG2326215-CC IBM ADHIKG01 09.10.2025 Job queue failure due to missing INV_LEV dimension
    // # Modified the function CreateEmailNotificationOnAfterRelease to update the "No. Printed" field
    // BC Upgrade MISHRS14 <<

    trigger OnRun();
    begin
    end;

    var
        DDEInterfaceSetup: Record "DDE Interface Setup INT";

    [EventSubscriber(ObjectType::Codeunit, 58113, 'OnAfterCreateSalesDocument', '', false, false)]
    local procedure CreateEmailNotificationOnAfterInsertOrder(SalesHeader: Record "Sales Header");
    var
        Customer: Record Customer;
        APIInterfaceLog2: Record "API Interface Log2 INT";
        APIInterfaceSetup2: Record "API Interface Setup2 INT";

        // BC Upgrade VAMSIU01 >>
        //SMTPMail: Codeunit "SMTP Mail";
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailAccount: Record "Email Account";
        // BC Upgrade VAMSIU01 <<

        MessageText: Text;
        MailSubjectTxt: Text[100];
        ReportSelections: Record "Report Selections";
        FileName: Text;
        FileManagement: Codeunit "File Management";
        SalesHeader2: Record "Sales Header" temporary;
        EmailScenario: Codeunit "Email Scenario";

    begin
        APIInterfaceLog2.SETRANGE("Source No.", SalesHeader."No.");
        if not APIInterfaceLog2.FINDFIRST then
            exit;

        if APIInterfaceLog2."Source System Identifier" <> 'DDE' then
            exit;

        CLEAR(FileName);

        if APIInterfaceSetup2.GET then
            if APIInterfaceSetup2."SO/SRO Interface Request" = APIInterfaceLog2."Interface Code" then
                if Customer.GET(SalesHeader."Sell-to Customer No.") then
                    if Customer."E-Mail" <> '' then begin

                        //FileName := FileManagement.ServerTempFileName('pdf'); // BC Upgrade VAMSIU01 >>

                        SalesHeader2.RESET;
                        SalesHeader2.COPY(SalesHeader);
                        SalesHeader2.INSERT(false);
                        SalesHeader2.SETRECFILTER;

                        ReportSelections.RESET;
                        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
                            ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"S.Order")
                        else if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                            ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"S.Return");
                        ReportSelections.SETRANGE("Document Subtype Code FND", SalesHeader."Document Subtype Code FND");
                        ReportSelections.SETFILTER("Report ID", '<>%1', 0);
                        if not ReportSelections.FINDFIRST then
                            exit;
                        //REPORT.SAVEASPDF(ReportSelections."Report ID", FileName, SalesHeader2); // BC Upgrade VAMSIU01 >>

                        TempBlob.CreateOutStream(OutStr);
                        RecRef.GetTable(SalesHeader2);
                        Report.SaveAs(ReportSelections."Report ID", '', ReportFormat::Pdf, OutStr, RecRef);

                        TempBlob.CreateInStream(InStr);

                        FileName := SalesHeader."External Document No." + '.pdf';

                        MailSubjectTxt := FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."External Document No." + ' is received in Heilite';
                        MessageText := 'Dear ' + SalesHeader."Sell-to Customer Name" + ',' + '<br><br>';
                        MessageText += 'Your order is successfully received. Find your order details below.' + '<br><br>';
                        MessageText += 'Order No: #' + SalesHeader."External Document No." + '<br><br>';
                        MessageText += 'Thank you for your Order!' + '<br><br>';

                        // BC Upgrade VAMSIU01 >>
                        // SMTPMail.CreateMessage('Heilite DDE Interface', 'ddeinterface@heineken.com', Customer."E-Mail", MailSubjectTxt, MessageText, true);
                        // SMTPMail.AddAttachment(FileName, SalesHeader."External Document No." + '.pdf');
                        // SMTPMail.Send;

                        // EmailAccount.Setrange(EmailAccount."Email Address", 'reach2agni786@gmail.com'); //ddeinterface@heineken.com BC Upgrade SHUKLP03 << We can not pass Email Address as primary key. The Get() method expects a GUID (Account Id).
                        // if EmailAccount.FindFirst then
                        //     Error('Email account not configured.');

                        // Create Email
                        EmailMessage.Create(Customer."E-Mail", MailSubjectTxt, MessageText, true);
                        // Add Attachment
                        EmailMessage.AddAttachment(FileName, 'application/pdf', InStr);

                        // BC Upgrade SHUKLP03 >>
                        if EmailScenario.GetEmailAccount(Enum::"Email Scenario"::"DDE Sales Order", EmailAccount) then
                            if EmailAccount."Email Address" <> '' then
                                Email.Send(EmailMessage, Enum::"Email Scenario"::"DDE Sales Order")
                            else
                                Error('Email account not configured.');
                        // BC Upgrade SHUKLP03 <<
                        // Send Email
                        // Email.Send(EmailMessage, EmailAccount);
                        // BC Upgrade VAMSIU01 <<
                    end;
    end;

    procedure CreateEmailNotificationOnAfterRelease(SalesHeader: Record "Sales Header");
    var
        Customer: Record Customer;
        APIInterfaceSetup2: Record "API Interface Setup2 INT";
        APIInterfaceLog2: Record "API Interface Log2 INT";
        //BC Upgrade VAMSIU01 >>
        //SMTPMail: Codeunit "SMTP Mail";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        RecRef: RecordRef;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailAccount: Record "Email Account";
        //BC Upgrade VAMSIU01 <<
        MessageText: Text;
        MailSubjectTxt: Text[100];
        ReportSelections: Record "Report Selections";
        FileName: Text;
        FileManagement: Codeunit "File Management";
        SalesHeader2: Record "Sales Header" temporary;
        EmailScenario: Codeunit "Email Scenario";

        // HEI.05 >>
        SessionGlobal: Codeunit "Session Globals";
        // HEI.05 <<

    begin
        APIInterfaceLog2.SETRANGE("Source No.", SalesHeader."No.");
        if not APIInterfaceLog2.FINDFIRST then
            exit;

        if APIInterfaceLog2."Source System Identifier" <> 'DDE' then
            exit;

        CLEAR(FileName);

        if APIInterfaceSetup2.GET then
            if APIInterfaceSetup2."SO/SRO Interface Request" = APIInterfaceLog2."Interface Code" then
                if Customer.GET(SalesHeader."Sell-to Customer No.") then
                    if Customer."E-Mail" <> '' then begin

                        //FileName := FileManagement.ServerTempFileName('pdf'); //BC Upgrade VAMSIU01 >>
                        SalesHeader2.RESET;
                        SalesHeader2.COPY(SalesHeader);
                        SalesHeader2.INSERT;
                        SalesHeader2.SETRECFILTER;

                        ReportSelections.RESET;
                        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"S.Order");
                        ReportSelections.SETRANGE("Document Subtype Code FND", SalesHeader."Document Subtype Code FND");
                        ReportSelections.SETFILTER("Report ID", '<>%1', 0);
                        if not ReportSelections.FINDFIRST then
                            exit;
                        // REPORT.SAVEASPDF(ReportSelections."Report ID", FileName, SalesHeader2); //BC Upgrade VAMSIU01 >>
                        
                        // BC Upgrade MISHRS14 >>
                        //HEI.05>>
                        IF ReportSelections.FINDFIRST THEN BEGIN
                        SessionGlobal.SetCalledFromDDE(TRUE);
                        //HEI.05<<

                        //BC Upgrade VAMSIU01 >> // Generate PDF
                        TempBlob.CreateOutStream(OutStr);
                        RecRef.GetTable(SalesHeader2);

                        Report.SaveAs(ReportSelections."Report ID", '', ReportFormat::Pdf, OutStr, RecRef);

                        TempBlob.CreateInStream(InStr);
                        FileName := SalesHeader."External Document No." + '.pdf';
                        //BC Upgrade VAMSIU01 <<
                        
                        //HEI.05>>
                        SessionGlobal.SetCalledFromDDE(FALSE);
                        SalesHeader."No. Printed" += 1;
                        SalesHeader.MODIFY;
                        END;
                        //HEI.05<<
                        // BC Upgrade MISHRS14 <<

                        MailSubjectTxt := 'Your Order Confirmation ' + SalesHeader."External Document No.";
                        MessageText := FORMAT(SalesHeader."Document Type") + ': #' + SalesHeader."External Document No." + '<br>';
                        MessageText += 'Order Date: ' + FORMAT(SalesHeader."Order Date") + '<br><br>';
                        MessageText += 'Shipping to: ' + FORMAT(SalesHeader."Ship-to Name") + '<br>';
                        MessageText += 'Address: ' + FORMAT(SalesHeader."Ship-to Address") + '<br>';
                        MessageText += SalesHeader."Ship-to Post Code" + ' ' + SalesHeader."Ship-to City" + ' ' + SalesHeader."Ship-to Country/Region Code" + '<br><br>';
                        MessageText += 'Thank you!' + '<br><br>';

                        //BC Upgrade VAMSIU01 >>
                        // SMTPMail.CreateMessage('Heilite DDE Interface', 'ddeinterface@heineken.com', Customer."E-Mail", MailSubjectTxt, MessageText, true);
                        // SMTPMail.AddAttachment(FileName, SalesHeader."External Document No." + '.pdf');
                        // SMTPMail.Send;

                        // if not EmailAccount.Get('ddeinterface@heineken.com') then
                        //     Error('Email account not configured.');

                        EmailMessage.Create(Customer."E-Mail", MailSubjectTxt, MessageText, true);
                        EmailMessage.AddAttachment(FileName, 'application/pdf', InStr);

                        // BC Upgrade SHUKLP03 >>
                        if EmailScenario.GetEmailAccount(Enum::"Email Scenario"::"DDE Sales Order", EmailAccount) then
                            if EmailAccount."Email Address" <> '' then
                                Email.Send(EmailMessage, Enum::"Email Scenario"::"DDE Sales Order")
                            else
                                Error('Email account not configured.');
                        // BC Upgrade SHUKLP03 <<

                        // Email.Send(EmailMessage, EmailAccount);
                        //BC Upgrade VAMSIU01 <<
                    end;
    end;

    procedure CreateEmailNotificationOnAfterPostShip(SalesShipmentHeader: Record "Sales Shipment Header");
    var
        Customer: Record Customer;
        APIInterfaceLog2: Record "API Interface Log2 INT";
        APIInterfaceSetup2: Record "API Interface Setup2 INT";
        //BC Upgrade VAMSIU01 >>
        //SMTPMail: Codeunit "SMTP Mail";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        RecRef: RecordRef;

        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailAccount: Record "Email Account";
        //BC Upgrade VAMSIU01 <<
        MessageText: Text;
        MailSubjectTxt: Text[100];
        ReportSelections: Record "Report Selections";
        FileName: Text;
        FileManagement: Codeunit "File Management";
        SalesShipmentHeader2: Record "Sales Shipment Header" temporary;
        EmailScenario: Codeunit "Email Scenario";
    // Truck: Record "Whse. Shipping Truck";
    // Driver: Record "Whse. Shipping Driver";
    begin
        APIInterfaceLog2.SETRANGE("Source No.", SalesShipmentHeader."Order No.");
        if not APIInterfaceLog2.FINDFIRST then
            exit;

        if APIInterfaceLog2."Source System Identifier" <> 'DDE' then
            exit;

        CLEAR(FileName);

        if APIInterfaceSetup2.GET then
            if APIInterfaceSetup2."SO/SRO Interface Request" = APIInterfaceLog2."Interface Code" then
                if Customer.GET(SalesShipmentHeader."Sell-to Customer No.") then
                    if Customer."E-Mail" <> '' then begin

                        //BC Upgrade VAMSIU01 >>
                        // FileName := FileManagement.ServerTempFileName('pdf');
                        // if Truck.GET(SalesShipmentHeader."Truck Code") then;
                        // if Driver.GET(SalesShipmentHeader."Driver Code") then;
                        //BC Upgrade VAMSIU01 <<

                        SalesShipmentHeader2.RESET;
                        SalesShipmentHeader2.COPY(SalesShipmentHeader);
                        SalesShipmentHeader2.INSERT;
                        SalesShipmentHeader2.SETRECFILTER;

                        ReportSelections.RESET;
                        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"S.Shipment");
                        ReportSelections.SETRANGE("Document Subtype Code FND", SalesShipmentHeader."Document Subtype Code FND");
                        ReportSelections.SETFILTER("Report ID", '<>%1', 0);
                        if not ReportSelections.FINDFIRST then
                            exit;
                        //REPORT.SAVEASPDF(ReportSelections."Report ID", FileName, SalesShipmentHeader2); //BC Upgrade VAMSIU01 >>

                        // BC Upgrade VAMSIU01 << Generate PDF (SaaS way)
                        TempBlob.CreateOutStream(OutStr);
                        RecRef.GetTable(SalesShipmentHeader2);

                        Report.SaveAs(ReportSelections."Report ID", '', ReportFormat::Pdf, OutStr, RecRef);

                        TempBlob.CreateInStream(InStr);
                        FileName := SalesShipmentHeader."External Document No." + '.pdf';
                        // BC Upgrade VAMSIU01 <<

                        MailSubjectTxt := 'Your Order ' + SalesShipmentHeader."External Document No." + ' is on its way';
                        MessageText := 'Summary: ' + '<br>';
                        MessageText += 'Order No: #' + SalesShipmentHeader."External Document No." + '<br>';
                        MessageText += 'Order Date: ' + FORMAT(SalesShipmentHeader."Order Date") + '<br>';
                        MessageText += 'Shipment Date: ' + FORMAT(SalesShipmentHeader."Shipment Date") + '<br>';
                        // MessageText += 'Truck No.: ' + Truck.Description + '<br>'; //BC Upgrade VAMSIU01 >>
                        // MessageText += 'Driver: ' + Driver.Description + '<br>'; //BC Upgrade VAMSIU01 >>
                        MessageText += 'Shipping to: ' + FORMAT(SalesShipmentHeader."Ship-to Name") + '<br>';
                        MessageText += 'Address: ' + FORMAT(SalesShipmentHeader."Ship-to Address") + '<br>';
                        MessageText += SalesShipmentHeader."Ship-to Post Code" + ' ' + SalesShipmentHeader."Ship-to City" + ' ' + SalesShipmentHeader."Ship-to Country/Region Code" + '<br><br>';
                        MessageText += 'Thank you!' + '<br><br>';

                        //BC Upgrade VAMSIU01 >>
                        // SMTPMail.CreateMessage('Heilite DDE Interface', 'ddeinterface@heineken.com', Customer."E-Mail", MailSubjectTxt, MessageText, true);
                        // SMTPMail.AddAttachment(FileName, SalesShipmentHeader."External Document No." + '.pdf');
                        // SMTPMail.Send;
                        // if not EmailAccount.Get('ddeinterface@heineken.com') then
                        //     Error('Email account not configured.');

                        EmailMessage.Create(Customer."E-Mail", MailSubjectTxt, MessageText, true);
                        EmailMessage.AddAttachment(FileName, 'application/pdf', InStr);

                        // BC Upgrade SHUKLP03 >>
                        if EmailScenario.GetEmailAccount(Enum::"Email Scenario"::"DDE Sales Order", EmailAccount) then
                            if EmailAccount."Email Address" <> '' then
                                Email.Send(EmailMessage, Enum::"Email Scenario"::"DDE Sales Order")
                            else
                                Error('Email account not configured.');
                        // BC Upgrade SHUKLP03 <<

                        // Email.Send(EmailMessage, EmailAccount);
                        //BC Upgrade VAMSIU01 >>
                    end;
    end;

    procedure CreateEmailNotificationOnAfterPostRcpt(ReturnReceiptHeader: Record "Return Receipt Header");
    var
        Customer: Record Customer;
        APIInterfaceSetup2: Record "API Interface Setup2 INT";
        APIInterfaceLog2: Record "API Interface Log2 INT";
        //BC Upgrade VAMSIU01 >>
        //SMTPMail: Codeunit "SMTP Mail";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        RecRef: RecordRef;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailAccount: Record "Email Account";
        //BC Upgrade VAMSIU01 <<
        MessageText: Text;
        MailSubjectTxt: Text[100];
        ReportSelections: Record "Report Selections";
        FileName: Text;
        FileManagement: Codeunit "File Management";
        ReturnReceiptHeader2: Record "Return Receipt Header" temporary;
        EmailScenario: Codeunit "Email Scenario";
    begin
        APIInterfaceLog2.SETRANGE("Source No.", ReturnReceiptHeader."Return Order No.");
        if not APIInterfaceLog2.FINDFIRST then
            exit;

        if APIInterfaceLog2."Source System Identifier" <> 'DDE' then
            exit;

        CLEAR(FileName);

        if APIInterfaceSetup2.GET then
            if APIInterfaceSetup2."SO/SRO Interface Request" = APIInterfaceLog2."Interface Code" then
                if Customer.GET(ReturnReceiptHeader."Sell-to Customer No.") then
                    if Customer."E-Mail" <> '' then begin

                        //FileName := FileManagement.ServerTempFileName('pdf'); //BC Upgrade VAMSIU01 >>

                        ReturnReceiptHeader2.RESET;
                        ReturnReceiptHeader2.COPY(ReturnReceiptHeader);
                        ReturnReceiptHeader2.INSERT;
                        ReturnReceiptHeader2.SETRECFILTER;

                        ReportSelections.RESET;
                        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"S.Ret.Rcpt.");
                        ReportSelections.SETRANGE("Document Subtype Code FND", ReturnReceiptHeader."Document Subtype Code FND");
                        ReportSelections.SETFILTER("Report ID", '<>%1', 0);
                        if not ReportSelections.FINDFIRST then
                            exit;
                        //REPORT.SAVEASPDF(ReportSelections."Report ID", FileName, ReturnReceiptHeader2); //BC Upgrade VAMSIU01 >>

                        // BC Upgrade VAMSIU01 - Generate PDF (SaaS way) >>
                        TempBlob.CreateOutStream(OutStr);
                        RecRef.GetTable(ReturnReceiptHeader2);

                        Report.SaveAs(ReportSelections."Report ID", '', ReportFormat::Pdf, OutStr, RecRef);

                        TempBlob.CreateInStream(InStr);
                        FileName := ReturnReceiptHeader."External Document No." + '.pdf';
                        // BC Upgrade VAMSIU01 <<

                        MailSubjectTxt := 'Return Order' + ' ' + ReturnReceiptHeader."Return Order No." + ' Receipt Confirmation';
                        MessageText := 'Summary: ' + '<br>';
                        MessageText += 'Order No: #' + ReturnReceiptHeader."External Document No." + '<br>';
                        MessageText += 'Order Date: ' + FORMAT(ReturnReceiptHeader."Order Date") + '<br>';
                        MessageText += 'Shipment Date: ' + FORMAT(ReturnReceiptHeader."Shipment Date") + '<br>';
                        MessageText += 'Thank you!' + '<br><br>';

                        //BC Upgrade VAMSIU01 >>
                        // SMTPMail.CreateMessage('Heilite DDE Interface', 'ddeinterface@heineken.com', Customer."E-Mail", MailSubjectTxt, MessageText, true);
                        // SMTPMail.AddAttachment(FileName, ReturnReceiptHeader."External Document No." + '.pdf');
                        // SMTPMail.Send;

                        // if not EmailAccount.Get('ddeinterface@heineken.com') then
                        //     Error('Email account not configured.');

                        EmailMessage.Create(Customer."E-Mail", MailSubjectTxt, MessageText, true);
                        EmailMessage.AddAttachment(FileName, 'application/pdf', InStr);

                        // BC Upgrade SHUKLP03 >>
                        if EmailScenario.GetEmailAccount(Enum::"Email Scenario"::"DDE Sales Order", EmailAccount) then
                            if EmailAccount."Email Address" <> '' then
                                Email.Send(EmailMessage, Enum::"Email Scenario"::"DDE Sales Order")
                            else
                                Error('Email account not configured.');
                        // BC Upgrade SHUKLP03 <<


                        // Email.Send(EmailMessage, EmailAccount);
                        //BC Upgrade VAMSIU01 <<

                    end;
    end;

    procedure CreateDDEShipmentInterface(var SalesShipmentHeader: Record "Sales Shipment Header"; DMSTenantID: Text[50]);
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
    begin
        if not DDEInterfaceSetup.GET then
            exit;

        if not DDEInterfaceSetup."Enable DDE Ship Interface" then
            exit;

        DDEInterfaceSetup.TESTFIELD("DDE Ship Interface Code");
        InterfaceSetup.GET(DDEInterfaceSetup."DDE Ship Interface Code");
        if not InterfaceSetup.Enabled then
            exit;

        //Create Outbound Interface Entry
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreateShipmentResponse(SalesShipmentHeader, DMSTenantID, InterfaceEntryHeaderOut);
        //ProcessOutboundEntry(InterfaceEntryHeaderOut);
    end;

    local procedure CreateShipmentResponse(SalesShipmentHeader: Record "Sales Shipment Header"; DMSTenantID: Text[50]; var InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        SalesShipmentLine: Record "Sales Shipment Line";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        EntryNo: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
        APIInterfaceLog: Record "API Interface Log2 INT";
    begin
        CLEAR(InterfaceEntryHeader);
        EntryNo := 0;

        APIInterfaceLog.RESET;
        APIInterfaceLog.SETRANGE("Source No.", SalesShipmentHeader."Order No.");
        //HEI.04>>
        //APIInterfaceLog.FINDFIRST;
        if APIInterfaceLog.FINDFIRST then;
        //HEI.04<<
        InterfaceEntryHeader2.FINDLAST;
        InterfaceEntryHeader."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
        InterfaceEntryHeader."Interface Code" := DDEInterfaceSetup."DDE Ship Interface Code";
        InterfaceEntryHeader.Direction := InterfaceEntryHeader.Direction::Outbound;
        InterfaceEntryHeader.INSERT(true);

        InterfaceEntryHeader.Name := 'Order';
        InterfaceEntryHeader."Source No." := SalesShipmentHeader."Order No.";
        InterfaceEntryHeader."Sell-to Customer No." := SalesShipmentHeader."Sell-to Customer No.";
        //InterfaceEntryHeader."External Document No." := SalesShipmentHeader."External Document No.";
        InterfaceEntryHeader."Address 2" := APIInterfaceLog."Message ID"; //Keep DMS formatting
        InterfaceEntryHeader."Document Date" := SalesShipmentHeader."Order Date";
        InterfaceEntryHeader."Requested Receipt Date" := SalesShipmentHeader."Requested Delivery Date";
        InterfaceEntryHeader.Address := DMSTenantID;
        InterfaceEntryHeader."External Contract No." := SalesShipmentHeader."No.";
        //HEI.02>>
        InterfaceEntryHeader.Contact := UPPERCASE(TENANTID);
        InterfaceEntryHeader."E-Mail" := UPPERCASE(COMPANYNAME);
        //HEI.02<<
        InterfaceEntryHeader.MODIFY(true);

        SalesShipmentLine.RESET;
        SalesShipmentLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
        SalesShipmentLine.SETRANGE(Type, SalesShipmentLine.Type::Item); // just Items
        if SalesShipmentLine.FINDSET then
            repeat
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
                ItemLedgerEntry.SETRANGE("Document No.", SalesShipmentHeader."No.");
                ItemLedgerEntry.SETRANGE("Document Line No.", SalesShipmentLine."Line No.");
                if ItemLedgerEntry.FINDSET then
                    repeat
                        EntryNo += 10000;
                        InterfaceEntryLine.INIT;
                        InterfaceEntryLine."Header Entry No." := InterfaceEntryHeader."Entry No.";
                        InterfaceEntryLine."Entry No." := EntryNo;
                        InterfaceEntryLine.INSERT(true);

                        InterfaceEntryLine."Source Line No." := SalesShipmentLine."Order Line No.";
                        InterfaceEntryLine."No." := SalesShipmentLine."No.";
                        InterfaceEntryLine.Quantity := ABS(ItemLedgerEntry.Quantity) / ItemLedgerEntry."Qty. per Unit of Measure";
                        InterfaceEntryLine.Description := ItemLedgerEntry."Lot No.";
                        InterfaceEntryLine."Posting Date" := ItemLedgerEntry."Expiration Date";

                        //InterfaceEntryLine."Over Percent Indicator" := SalesShipmentLine."Free Item"; //HEI.03 //BC Upgrade VAMSIU01  - Blocked field not available.

                        //BC UPGRADE KUMARR78 25-05-2026
                        if SalesShipmentLine."Line Discount %" <> 0 then
                            InterfaceEntryLine."Over Percent Indicator" := true
                        else
                            InterfaceEntryLine."Over Percent Indicator" := false;
                        //BC UPGRADE KUMARR78 25-05-2026

                        //Manufacturing Date
                        ItemLedgerEntry2.RESET;
                        ItemLedgerEntry2.SETRANGE("Item No.", ItemLedgerEntry."Item No.");
                        ItemLedgerEntry2.SETRANGE("Lot No.", ItemLedgerEntry."Lot No.");
                        ItemLedgerEntry2.SETRANGE("Location Code", ItemLedgerEntry."Location Code");
                        ItemLedgerEntry2.SETFILTER(Quantity, '>%1', 0);
                        if ItemLedgerEntry2.FINDFIRST then
                            InterfaceEntryLine."Document Date" := ItemLedgerEntry2."Posting Date";
                        InterfaceEntryLine.MODIFY(true);

                    until ItemLedgerEntry.NEXT = 0;
            until SalesShipmentLine.NEXT = 0;
    end;

    local procedure ProcessOutboundEntry(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
    begin
        COMMIT;
        if CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeader) then begin
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
        end else
            InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GETLASTERRORTEXT);
    end;

    procedure IsManualDDEShipmentEnabled(CustomerNo: Code[20]): Boolean;
    var
        DDEInterfaceSetup: Record "DDE Interface Setup INT";
        DDECustomerIncluded: Record "DDE Customer Included FND";
    begin
        //HEI.04>>
        if not DDEInterfaceSetup.GET then
            exit(false);

        if not DDEInterfaceSetup."Enable Manual DDE Shipment" then
            exit(false);

        DDECustomerIncluded.SETRANGE("Customer No.", CustomerNo);
        DDECustomerIncluded.SETRANGE(Included, true);
        exit(not DDECustomerIncluded.ISEMPTY);
        //HEI.04<<
    end;
}

