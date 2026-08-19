report 51078 "Dunning Letter Haiti CBN"
{
    // version HEI.01

    // HEI.01 HT2051 - CHG2099838 IBM NASTAA02 12.032.2021 # Haiti - Dunning Letters
    //   # New Report created based on 50450 - Dunning Letter LR
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Dunning Letter Haiti.rdl';

    Caption = 'Dunning Letter Haiti';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    //*********************//
    //BC UPGRADE ATHUKS01 //
    //1.Old Report ID 50472.
    //2.Change Language to LanguageMgt and record to codeunit for getting Language.
    //3. No Drink IT code.
    dataset
    {
        dataitem("Issued Reminder Header"; "Issued Reminder Header")
        {
            RequestFilterFields = "No.";
            column(ForeignCustomer; ForeignCustomer)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_VATRegistrationNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_SwiftCode; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanyInfo_IBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanyInfo_BankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfo_BankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(IssuedReminderHeader_No; "No.")
            {
            }
            column(IssuedReminderHeader_ReminderLevel; "Reminder Level")
            {
            }
            column(IssuedReminderHeader_CustomerNo; "Customer No.")
            {
            }
            column(IssuedReminderHeader_CustomerName; Name)
            {
            }
            column(IssuedReminderHeader_Address; Address)
            {
            }
            column(IssuedReminderHeader_Address2; "Address 2")
            {
            }
            column(IssuedReminderHeader_PostCode; "Post Code")
            {
            }
            column(IssuedReminderHeader_City; City)
            {
            }
            column(HouseNo_IssuedReminderHeader; CustomerAttributes."House No. 1")
            {
            }
            column(POBox_IssuedReminderHeader; CustomerAttributes."P.O.Box")
            {
            }
            column(IssuedReminderHeader_PostingDate; FORMAT("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(IssuedReminderHeader_DocumentDate; FORMAT("Document Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(LetterPrintDate; FORMAT(TODAY, 0, '<Day,2> <Month Text> <Year4>'))
            {
            }
            column(IssuedReminderHeader_SumAmount; SUMIssuedReminderLine.Amount)
            {
            }
            column(IssuedReminderHeader_SumRemainingAmount; SUMIssuedReminderLine."Remaining Amount")
            {
            }
            column(IssuedReminderHeader_CurrencyCode; CurrencyCode)
            {
            }
            column(ClientCaption; ClientLbl)
            {
            }
            column(CompanyNameCaption; CompanyNameLbl)
            {
            }
            column(HouseNoCaption; HouseNoLbl)
            {
            }
            column(AddressCaption; AddressLbl)
            {
            }
            column(POBoxCaption; POBoxLbl)
            {
            }
            column(PostCodeCaption; PostCodeLbl)
            {
            }
            column(CityCaption; CityLbl)
            {
            }
            column(TelephoneNoCaption; TelephoneNoLbl)
            {
            }
            column(EmailCaption; EmailLbl)
            {
            }
            column(VATRegistrationNoCaption; VATRegistrationNoLbl)
            {
            }
            column(SWIFTCaption; SWIFTLbl)
            {
            }
            column(IBANCaption; IBANLbl)
            {
            }
            column(PostingDateCaption; PostingDateLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateLbl)
            {
            }
            column(ReminderCaption; ReminderLbl)
            {
            }
            column(SystemReferenceCaption; SystemNoLbl)
            {
            }
            column(PageCaption; PageNoLbl)
            {
            }
            column(DateCaption; DateLbl)
            {
            }
            column(CustomerNoCaption; CustomerNoLbl)
            {
            }
            column(DocumentNoCaption; DocumentNoLbl)
            {
            }
            column(DocumentTypeCaption; DocumentTypeLbl)
            {
            }
            column(DocumentDateLineCaption; DocumentDateLLbl)
            {
            }
            column(DescriptionCaption; DescriptionLbl)
            {
            }
            column(DisputedCaption; DisputedLbl)
            {
            }
            column(DueDateCaption; DueDateLbl)
            {
            }
            column(OriginalAmountCaption; OriginalAmountLbl)
            {
            }
            column(RemainingAmountCaption; RemainingAmountLbl)
            {
            }
            column(ReminderLevelCaption; ReminderLevelLbl)
            {
            }
            column(BankNameCaption; BankNameLbl)
            {
            }
            column(BankNoCaption; BankNoLbl)
            {
            }
            column(DocumentCurrencyCaption; DocumentCurrencyLbl)
            {
            }
            column(DateDeComptabilisationCaption; DateDeComptabilisationLbl)
            {
            }
            column(TotalCaption; TotalLbl)
            {
            }
            column(BeginText; BeginText)
            {
            }
            column(EndText; EndText)
            {
            }
            dataitem("Issued Reminder Line"; "Issued Reminder Line")
            {
                CalcFields = "Disputed FND";
                DataItemLink = "Reminder No." = FIELD("No.");
                DataItemTableView = SORTING("Reminder No.", "Line No.");
                column(IssuedReminderLine_LineNo; "Line No.")
                {
                }
                column(IssuedReminderLine_DocumentDate; FORMAT("Document Date", 0, 0))
                {
                }
                column(IssuedReminderLine_DocumentType; "Document Type")
                {
                }
                column(IssuedReminderLine_DocumentNo; "Document No.")
                {
                }
                column(IssuedReminderLine_Description; Description)
                {
                }
                column(IssuedReminderLine_Disputed; FORMAT("Disputed FND"))
                {
                }
                column(IssuedReminderLine_DueDate; FORMAT("Due Date", 0, 0))
                {
                }
                column(IssuedReminderLine_OriginalAmount; "Original Amount")
                {
                }
                column(IssuedReminderLine_RemainingAmount; "Remaining Amount")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    if (Type = "Issued Reminder Line".Type::" ") and ("Document Type" = "Issued Reminder Line"."Document Type"::" ") then
                        CurrReport.SKIP();
                end;
            }

            trigger OnAfterGetRecord();
            begin
                Customer.GET("Customer No.");
                //BC UPGRADE ATHUKS01 >>
                //CurrReport.LANGUAGE := Language.GetLanguageID(Customer."Language Code");
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageID(Customer."Language Code");
                //BC UPGRADE ATHUKS01 <<
                ForeignCustomer := Customer."Language Code" <> 'FRA';

                CurrencyCode := "Currency Code";
                if CurrencyCode = '' then
                    CurrencyCode := GLSetup."LCY Code";

                if CustomerAttributes.GET("Customer No.") then;

                ContactPerson := '';
                if Contact <> '' then
                    ContactPerson := Contact
                else
                    ContactPerson := Customer.Contact;

                SUMIssuedReminderLine.SETRANGE("Reminder No.", "Issued Reminder Header"."No.");
                SUMIssuedReminderLine.CALCSUMS(Amount, "Remaining Amount");

                BeginText := '';
                EndText := '';
                //ReminderText.SETRANGE("Reminder Terms Code","Reminder Terms Code");
                if ForeignCustomer then
                    ReminderText.SETRANGE("Reminder Terms Code", 'FOREIGN')
                else
                    ReminderText.SETRANGE("Reminder Terms Code", 'DOMESTIC');
                ReminderText.SETRANGE("Reminder Level", "Reminder Level");
                ReminderText.SETRANGE(Position, ReminderText.Position::Beginning);
                if ReminderText.FINDSET() then
                    repeat
                        BeginText += ReminderText.Text;
                    until ReminderText.NEXT() = 0;

                ReminderText.SETRANGE(Position, ReminderText.Position::Ending);
                if ReminderText.FINDSET() then
                    repeat
                        EndText += ReminderText.Text;
                    until ReminderText.NEXT() = 0;
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
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);
        GLSetup.GET();
    end;

    var
        CompanyInfo: Record "Company Information";
        ClientLbl: TextConst ENU = 'Customer Name', FRA = 'Client';
        HouseNoLbl: TextConst ENU = 'House No.', FRA = 'House No.';
        AddressLbl: TextConst ENU = 'Address', FRA = 'Adresse';
        POBoxLbl: TextConst ENU = 'PO Box', FRA = 'PO Box';
        PostCodeLbl: TextConst ENU = 'Post Code', FRA = 'Code postal';
        CityLbl: TextConst ENU = 'City', FRA = 'Ville';
        TelephoneNoLbl: TextConst ENU = 'Telephone No.', FRA = 'N° téléphone';
        EmailLbl: TextConst ENU = 'E-mail', FRA = 'E-mail';
        VATRegistrationNoLbl: TextConst ENU = 'VAT Registration No.', FRA = 'N° de société';
        SWIFTLbl: TextConst ENU = 'SWIFT', FRA = 'SWIFT';
        IBANLbl: TextConst ENU = 'IBAN', FRA = 'IBAN';
        PostingDateLbl: TextConst ENU = 'Posting date', FRA = 'Date comptabilisation';
        DocumentDateLbl: TextConst ENU = 'Document Date', FRA = 'Date du document';
        ReminderLbl: TextConst ENU = 'Dunning letter', FRA = 'Relance';
        SystemNoLbl: TextConst ENU = 'System No.', FRA = 'Référence système';
        DateLbl: TextConst ENU = 'Date', FRA = 'Date';
        CustomerNoLbl: TextConst ENU = 'Account No.', FRA = 'N° client';
        DocumentNoLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        DocumentTypeLbl: TextConst ENU = 'Document Type', FRA = 'Type document';
        DocumentDateLLbl: TextConst ENU = 'Document Date', FRA = 'Date du document';
        DescriptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        DisputedLbl: TextConst ENU = 'Disputed', FRA = 'Contesté';
        DueDateLbl: TextConst ENU = 'Due Date', FRA = 'Date d''échéance';
        ReminderLevelLbl: TextConst ENU = 'Dunning Level', FRA = 'Relance';
        OriginalAmountLbl: TextConst ENU = 'Original Amount', FRA = 'Montant initial';
        RemainingAmountLbl: TextConst ENU = 'Remaining Amount', FRA = 'Montant ouvert';
        TotalLbl: TextConst ENU = 'Total', FRA = 'Total';
        GLSetup: Record "General Ledger Setup";
        CurrencyCode: Text;
        CustomerAttributes: Record "Customer Attributes FND";
        SUMIssuedReminderLine: Record "Issued Reminder Line";
        ReminderText: Record "Reminder Text";
        BeginText: Text;
        EndText: Text;
        PageNoLbl: TextConst ENU = 'Page No.', FRA = 'Page Non';
        //Language: Record Language; //BC UPGRADE ATHUKS01
        LanguageMgt: Codeunit Language; //BC UPGRADE ATHUKS01
        Customer: Record Customer;
        CompanyNameLbl: Label 'Company Name';
        BankNameLbl: Label 'Bank Name';
        BankNoLbl: Label 'Bank No.';
        ContactPerson: Text[250];
        DocumentCurrencyLbl: TextConst ENU = 'Document Currency', FRA = 'Monnaie du document';
        DateDeComptabilisationLbl: TextConst ENU = 'Date de comptabilisation', FRA = 'Date de comptabilisation';
        ForeignCustomer: Boolean;
}

