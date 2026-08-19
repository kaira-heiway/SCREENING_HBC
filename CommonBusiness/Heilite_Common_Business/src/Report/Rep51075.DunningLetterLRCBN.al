report 51075 "Dunning Letter LR CBN"
{
    // HEI.01 FDD-HT1203 IBM KUMARN15 28.04.2020
    //   #new report created
    // BC Upgrade - RD03 - NAV ID - 50451 Dunning Letter LR
    DefaultLayout = RDLC;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\src\ReportsLayout\Dunning Letter LR.rdl';

    dataset
    {
        dataitem("Issued Reminder Header"; "Issued Reminder Header")
        {
            RequestFilterFields = "No.";
            column(Name_CompInfo; CompInfo.Name)
            {
            }
            column(Address_CompInfo; CompInfo.Address)
            {
            }
            column(Address2_CompInfo; CompInfo."Address 2")
            {
            }
            column(PostCode_CompInfo; CompInfo."Post Code")
            {
            }
            column(City_CompInfo; CompInfo.City)
            {
            }
            column(PhoneNo_CompInfo; CompInfo."Phone No.")
            {
            }
            column(EMail_CompInfo; CompInfo."E-Mail")
            {
            }
            column(VATRegistrationNo_CompInfo; CompInfo."VAT Registration No.")
            {
            }
            column(SWIFTCode_CompInfo; CompInfo."SWIFT Code")
            {
            }
            column(IBAN_CompInfo; CompInfo.IBAN)
            {
            }
            column(Picture_CompInfo; CompInfo.Picture)
            {
            }
            column(Name_IssuedReminderHeader; "Issued Reminder Header".Name)
            {
            }
            column(HouseNo_IssuedReminderHeader; HouseNo)
            {
            }
            column(Address_IssuedReminderHeader; "Issued Reminder Header".Address)
            {
            }
            column(Address2_IssuedReminderHeader; "Issued Reminder Header"."Address 2")
            {
            }
            column(POBox_IssuedReminderHeader; POBox)
            {
            }
            column(PostCode_IssuedReminderHeader; "Issued Reminder Header"."Post Code")
            {
            }
            column(City_IssuedReminderHeader; "Issued Reminder Header".City)
            {
            }
            column(PostingDate_IssuedReminderHeader; FORMAT("Issued Reminder Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DocumentDate_IssuedReminderHeader; FORMAT("Issued Reminder Header"."Document Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(No_IssuedReminderHeader; "Issued Reminder Header"."No.")
            {
            }
            column(ReminderLevel_IssuedReminderHeader; "Issued Reminder Header"."Reminder Level")
            {
            }
            column(ClientCaption; ClientLbl)
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
            column(SystemReferenceCaption; SystemReference)
            {
            }
            column(PageCaption; PageLbl)
            {
            }
            column(LetterPrintDate; FORMAT(TODAY, 0, '<Day,2> <Month Text> <Year4>'))
            {
            }
            column(CustomerNo_IssuedReminderHeader; "Issued Reminder Header"."Customer No.")
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
            column(ReminderLevelCaption; ReminderLevelLbl)
            {
            }
            column(OriginalAmountCaption; OriginalAmountLbl)
            {
            }
            column(RemainingAmountCaption; RemainingAmountLbl)
            {
            }
            column(TotalCaption; TotalLbl)
            {
            }
            column(SumAmount_IssuedReminderHeader; SUMIssuedReminderLine.Amount)
            {
            }
            column(SumRemainingAmount_IssuedReminderHeader; SUMIssuedReminderLine."Remaining Amount")
            {
            }
            column(CurrencyCode_IssuedReminderHeader; CurrencyCode)
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
                column(LineNo_IssuedReminderLine; "Issued Reminder Line"."Line No.")
                {
                }
                column(DocumentDate_IssuedReminderLine; FORMAT("Issued Reminder Line"."Document Date", 0, 0))
                {
                }
                column(DocumentType_IssuedReminderLine; "Issued Reminder Line"."Document Type")
                {
                }
                column(DocumentNo_IssuedReminderLine; "Issued Reminder Line"."Document No.")
                {
                }
                column(Description_IssuedReminderLine; "Issued Reminder Line".Description)
                {
                }
                column(Disputed_IssuedReminderLine; FORMAT("Issued Reminder Line"."Disputed FND"))
                {
                }
                column(DueDate_IssuedReminderLine; FORMAT("Issued Reminder Line"."Due Date", 0, 0))
                {
                }
                column(OriginalAmount_IssuedReminderLine; "Issued Reminder Line"."Original Amount")
                {
                }
                column(RemainingAmount_IssuedReminderLine; "Issued Reminder Line"."Remaining Amount")
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
                CurrencyCode := "Issued Reminder Header"."Currency Code";
                if CurrencyCode = '' then
                    CurrencyCode := GLSetup."LCY Code";

                HouseNo := '';
                POBox := '';
                if CustomerAttributes.GET("Issued Reminder Header"."Customer No.") then begin
                    HouseNo := CustomerAttributes."House No. 1";
                    POBox := CustomerAttributes."P.O.Box";
                end;

                SUMIssuedReminderLine.SETRANGE("Reminder No.", "Issued Reminder Header"."No.");
                SUMIssuedReminderLine.CALCSUMS(Amount, "Remaining Amount");

                BeginText := '';
                EndText := '';
                ReminderText.SETRANGE("Reminder Terms Code", "Issued Reminder Header"."Reminder Terms Code");
                ReminderText.SETRANGE("Reminder Level", "Issued Reminder Header"."Reminder Level");
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
        CompInfo.GET();
        CompInfo.CALCFIELDS(Picture);
        GLSetup.GET();
    end;

    var
        CompInfo: Record "Company Information";
        ClientLbl: TextConst ENU = 'Client', FRA = 'Client';
        HouseNoLbl: TextConst ENU = 'House No.', FRA = 'House No.';
        AddressLbl: TextConst ENU = 'Address', FRA = 'Adresse';
        POBoxLbl: TextConst ENU = 'PO Box', FRA = 'PO Box';
        PostCodeLbl: TextConst ENU = 'Post Code', FRA = 'Code postal';
        CityLbl: TextConst ENU = 'City', FRA = 'Ville';
        TelephoneNoLbl: TextConst ENU = 'Telephone No.', FRA = 'N° téléphone';
        EmailLbl: TextConst ENU = 'E-mail', FRA = 'E-mail';
        VATRegistrationNoLbl: TextConst ENU = 'VAT Registration No.', FRA = 'N° de siret';
        SWIFTLbl: TextConst ENU = 'SWIFT', FRA = 'SWIFT';
        IBANLbl: TextConst ENU = 'IBAN', FRA = 'IBAN';
        PostingDateLbl: TextConst ENU = 'Posting date', FRA = 'Date comptabilisation';
        DocumentDateLbl: TextConst ENU = 'Document date', FRA = 'Date document';
        ReminderLbl: TextConst ENU = 'Reminder', FRA = 'Relance';
        SystemReference: TextConst ENU = 'System Reference', FRA = 'Référence système';
        PageLbl: TextConst ENU = 'Page', FRA = 'Page';
        DateLbl: TextConst ENU = 'Date', FRA = 'Date';
        CustomerNoLbl: TextConst ENU = 'Customer No.', FRA = 'N° client';
        DocumentNoLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        DocumentTypeLbl: TextConst ENU = 'Document Type', FRA = 'Type document';
        DocumentDateLLbl: TextConst ENU = 'Document date', FRA = 'Date document';
        DescriptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        DisputedLbl: TextConst ENU = 'Disputed', FRA = 'Contesté';
        DueDateLbl: TextConst ENU = 'Due date', FRA = 'Date d''échéance';
        ReminderLevelLbl: TextConst ENU = 'Reminder Level', FRA = 'Niveau relance';
        OriginalAmountLbl: TextConst ENU = 'Original Amount', FRA = 'Montant initial';
        RemainingAmountLbl: TextConst ENU = 'Remaining Amount', FRA = 'Montant ouvert';
        TotalLbl: TextConst ENU = 'Total', FRA = 'Total';
        GLSetup: Record "General Ledger Setup";
        CurrencyCode: Text;
        HouseNo: Text;
        POBox: Text;
        CustomerAttributes: Record "Customer Attributes FND";
        SUMIssuedReminderLine: Record "Issued Reminder Line";
        ReminderText: Record "Reminder Text";
        BeginText: Text;
        EndText: Text;
}

