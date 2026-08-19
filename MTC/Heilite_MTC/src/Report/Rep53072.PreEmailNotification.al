report 53072 "Pre-Email Notification"
{
    // HEI.01 HB2310 CHG2113088 IBM GAVANM01 16.07.2021 #Pre-Email Notification to Customers
    //   # New report created
    // BC Upgrade BHARDA11 >>
    // 1. OLD Report ID - 50518.
    // 2. Add ApplicationArea property in Report.
    // 3. Remove Drink-IT Record and related code( StandardTextReport: Record "Standard Text Report")
    // 4. Remove Drink-IT Field and related code("Item Charge Type")
    // 5. Restructure Email Codewith "Email Message" and Email codeunit.
    // BC Upgrade BHARDA11 <<
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            CalcFields = "Remaining Amt. (LCY)", "Remaining Amount", Amount;
            DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date", "Currency Code") WHERE(Open = CONST(true));

            trigger OnAfterGetRecord();
            begin
                if Customer."No." = '' then
                    Customer.GET("Cust. Ledger Entry"."Customer No.");

                if ("Cust. Ledger Entry"."Customer No." <> Customer."No.") and (Customer."E-Mail" <> '') then begin
                    TrySendEmail(Customer);
                    Customer.GET("Cust. Ledger Entry"."Customer No.");
                    BodyTable := '';
                end;

                BodyTable += '<tr><td>' + FORMAT("Posting Date", 0, '<Closing><Month,2>/<Day,2>/<Year4>') + '</td><td>' + "Document No." + '</td><td>' + "Customer No." + '</td><td>' + Customer.Name + '</td><td>' +
                             FORMAT("Due Date", 0, '<Closing><Month,2>/<Day,2>/<Year4>') + '</td><td>' + FORMAT(Amount) + '</td><td>' +
                             FORMAT("Remaining Amount") + '</td>';

                if Customer."Country/Region Code" = CompanyInformation."Country/Region Code" then
                    BodyTable += '<td>' + FORMAT("Remaining Amt. (LCY)") + '</td></tr><br>'
                else
                    BodyTable += '</tr><br><br>';
            end;

            trigger OnPostDataItem();
            begin
                if (Customer."No." <> '') and (Customer."E-Mail" <> '') then
                    TrySendEmail(Customer);
                if GUIALLOWED then
                    MESSAGE('Process completed');
            end;

            trigger OnPreDataItem();
            var
                StandardTextReport: Record "Standard Text Report FND"; // BC Upgrade SHUKLP03 ---
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
            begin
                SalesSetup.GET();
                CompanyInformation.GET();
                SETRANGE("Cust. Ledger Entry"."Document Type", "Cust. Ledger Entry"."Document Type"::Invoice);
                SETRANGE("Cust. Ledger Entry"."CM Incl. EG. Lim. Warn APS", "Cust. Ledger Entry"."CM Incl. EG. Lim. Warn APS"::" "); // BC Upgrade SHUKLP03 ----Drink-IT Field("Item Charge Type")
                SETFILTER("Cust. Ledger Entry"."Due Date", '<=%1', CALCDATE(SalesSetup."Prior Due Date Days FND", TODAY));
                SETFILTER("Cust. Ledger Entry"."Remaining Amt. (LCY)", '>=%1', SalesSetup."Remaining Amount limit FND");
                //only for testing in Q
                /*CASE TENANTID OF
                  'rwanda':
                    SETFILTER("Cust. Ledger Entry"."Customer No.",'%1|%2','0010000003','0010004953');
                  'panama':
                    SETFILTER("Cust. Ledger Entry"."Customer No.",'%1|%2','0010014154','0010015256');
                  ELSE
                    CurrReport.QUIT;
                END;*/

                BodyTable := '';
                // BC Upgrade SHUKLP03 >>
                StandardTextReport.SETRANGE("Report ID", 50518);
                StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Header);
                if StandardTextReport.FINDSET() then
                    repeat
                        ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                        if not ExtendedTextHeader.FINDFIRST() then begin
                            ExtendedTextHeader.SETRANGE("Language Code");
                            ExtendedTextHeader.SETRANGE("All Language Codes", true);
                            if not ExtendedTextHeader.FINDFIRST() then
                                ExtendedTextHeader.SETRANGE("All Language Codes");
                        end;
                        if ExtendedTextHeader.FINDSET() then
                            repeat
                                Counter += 1;
                                ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                                ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                                ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
                                if ExtendedTextLine.FINDSET() then
                                    repeat
                                        MsgText[Counter] += ExtendedTextLine.Text + ' ';
                                    until ExtendedTextLine.NEXT() = 0;
                            until ExtendedTextHeader.NEXT() = 0;
                    until StandardTextReport.NEXT() = 0;
                // BC Upgrade SHUKLP03 << ----


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

    var
        SalesSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
        BodyTable: Text;
        CompanyInformation: Record "Company Information";
        MsgText: array[6] of Text;
        Counter: Integer;
        CustomerFilter: Text;

    [TryFunction]
    local procedure TrySendEmail(Customer: Record Customer);
    var
        // SMTPMail: Codeunit "SMTP Mail"; // BC Upgrade BHARAD11 ::Blocked
        SMTPMail: Codeunit "Email Message"; // BC Upgrade BHARAD11 ::Added
        Email: Codeunit Email; // BC Upgrade BHARAD11 ::Added

        MessageText: Text;
        MailSubjectTxt: Text[100];
        ReportSelections: Record "Report Selections";
        FileName: Text;
        FileManagement: Codeunit "File Management";
        CustomerStatementofAccount: Report "Customer Statement of Account";
    begin
        CLEAR(SMTPMail);
        CLEAR(MailSubjectTxt);
        CLEAR(MessageText);

        MailSubjectTxt := MsgText[6];
        MessageText += MsgText[1] + ' ' + Customer.Name + '<br><br>';
        MessageText += MsgText[2] + '<br><br>';
        MessageText += MsgText[3] + '<br><br>';
        MessageText += '<style>table {border-collapse: collapse; width: 100%;} td, th {border: 1px solid #dddddd;text-align: left; padding: 8px;}</style>' +
                       '<table><tr><th>' + "Cust. Ledger Entry".FIELDCAPTION("Posting Date") + '</th><th>' +
                       "Cust. Ledger Entry".FIELDCAPTION("Document No.") + '</th><th>' +
                       "Cust. Ledger Entry".FIELDCAPTION("Customer No.") + '</th><th>' +
                       Customer.FIELDCAPTION(Name) + '</th><th>' +
                       "Cust. Ledger Entry".FIELDCAPTION("Due Date") + '</th><th>' +
                       "Cust. Ledger Entry".FIELDCAPTION(Amount) + '</th><th>' +
                       "Cust. Ledger Entry".FIELDCAPTION("Remaining Amount") + '</th>';
        if Customer."Country/Region Code" = CompanyInformation."Country/Region Code" then
            MessageText += '<th>' + "Cust. Ledger Entry".FIELDCAPTION("Remaining Amt. (LCY)") + '</th></tr>'
        else
            MessageText += '</tr>';

        MessageText += BodyTable + '</table><br><br>';
        MessageText += MsgText[4] + '<br><br>';
        MessageText += MsgText[5] + '<br><br>';
        // BC Upgrade BHARDA11 >> ----Restructure email Code
        // SMTPMail.CreateMessage(CompanyInformation.Name, CompanyInformation."E-Mail", Customer."E-Mail", MailSubjectTxt, MessageText, true);
        // SMTPMail.Send;
        SMTPMail.Create(Customer."E-Mail", MailSubjectTxt, MessageText, true);
        Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
        // BC Upgrade BHARDA11 << ----Restructure email Code
    end;
}

