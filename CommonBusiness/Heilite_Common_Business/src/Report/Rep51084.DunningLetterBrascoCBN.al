report 51084 "Dunning Letter Brasco CBN"
{
    // version HEI.03

    // HEI.01 HT2127 - CHG2105025 IBM SAMANR01 08.04.2021 # Brasco - Dunning Letters
    //   # New Report created based on 50451 - Dunning Letter LR
    // HEI.02 Defect # 6380 IBM NASTAA02 08.07.2021 # OTC - reminders few defects
    //   # Layout adjustments
    // HEI.03 Defect #6381 IBM NASTAA02 08.07.2021 # OTC - 2nd reminder letter text adjustments
    //   # Updated letter for Reminder 2
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea property in Report 
    // 2. Add layout path and change layout extension rdlc to rdl.
    // 3. Remove Drink-IT Record related code(StandardTextReport: Record "Standard Text Report")
    // 4. Block Language Record Language variable and relpace with LanguageMgt : codeunit Language variable in Code also.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Dunning Letter Brasco.rdl'; // BC Upgrade BHARDA11 ---Add Path and change extension rdlc to rdl

    Caption = 'Dunning Letter Brasco';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Issued Reminder Header"; "Issued Reminder Header")
        {
            RequestFilterFields = "No.";
            column(ForeignCustomer; ForeignCustomer)
            {
            }
            column(SameCurrency; GLSetup."LCY Code" = CurrencyCode)
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
            column(Footer; Footer)
            {
            }
            column(Fulladdress; FullAddress)
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
                        CurrReport.SKIP;
                end;
            }

            trigger OnAfterGetRecord();
            var
                // StandardTextReport: Record "Standard Text Report"; // BC Upgrade BHARDA11 ----Drink-IT Record("Standard Text Report")
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
            begin
                Customer.GET("Customer No.");
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageID('FRA');

                ForeignCustomer := false;
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

                Char13 := 13;
                Char10 := 10;

                if "Issued Reminder Header".Address <> '' then
                    FullAddress := "Issued Reminder Header".Address + FORMAT(Char13) + FORMAT(Char10);
                if "Issued Reminder Header"."Address 2" <> '' then
                    FullAddress := FullAddress + "Issued Reminder Header"."Address 2" + FORMAT(Char13) + FORMAT(Char10);
                if "Issued Reminder Header".City <> '' then
                    FullAddress := FullAddress + "Issued Reminder Header".City;
                if "Issued Reminder Header"."Post Code" <> '' then
                    FullAddress := FullAddress + '-' + "Issued Reminder Header"."Post Code";

                BeginText := '';
                EndText := '';

                //HEI.02>>
                //Letter to be used from Std Text Selection
                ReminderText.SETRANGE("Reminder Terms Code", "Reminder Terms Code");
                ReminderText.SETRANGE("Reminder Level", "Reminder Level");
                ReminderText.SETRANGE(Position, ReminderText.Position::Beginning);
                if ReminderText.FINDSET then
                    repeat
                        BeginText += ReminderText.Text;
                    until ReminderText.NEXT = 0;

                ReminderText.SETRANGE(Position, ReminderText.Position::Ending);
                if ReminderText.FINDSET then
                    repeat
                        EndText += ReminderText.Text;
                    until ReminderText.NEXT = 0;

                //Footer Text from Report Selection - Standard Text
                // BC Upgrade BHARDA11 >> ----Drink-IT Record(StandardTextReport)
                // Footer := '';
                // StandardTextReport.SETRANGE("Report ID", 50507);
                // StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);
                // if StandardTextReport.FINDSET then
                //     repeat
                //         ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                //         ExtendedTextHeader.SETRANGE("Print on Customer Statement", true);
                //         ExtendedTextHeader.SETRANGE("Language Code", Language.GetUserLanguage);
                //         if not ExtendedTextHeader.FINDFIRST then begin
                //             ExtendedTextHeader.SETRANGE("Language Code");
                //             ExtendedTextHeader.SETRANGE("All Language Codes", true);
                //             if not ExtendedTextHeader.FINDFIRST then
                //                 ExtendedTextHeader.SETRANGE("All Language Codes");
                //         end;
                //         if ExtendedTextHeader.FINDSET then
                //             repeat
                //                 ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                //                 ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                //                 ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
                //                 if ExtendedTextLine.FINDSET then
                //                     repeat
                //                         Footer += ExtendedTextLine.Text + ' ';
                //                     until ExtendedTextLine.NEXT = 0;
                //             until ExtendedTextHeader.NEXT = 0;
                //     until StandardTextReport.NEXT = 0;
                // BC Upgrade BHARDA11 << ----Drink-IT Record(StandardTextReport)



                // IF "Reminder Level" =1 THEN BEGIN
                //  BeginText :=
                //    'Cher Client,'
                //    + FORMAT(Char13) + FORMAT(Char10) //HEI.02
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +'Sauf erreur ou omission de notre part, à ce jour nous n’avons pas reçu de paiement pour les factures listées ci-dessous:';
                //  EndText :=
                //    'Comme stipulé dans nos délais de paiements contractuels, le solde arriéré doit être payé à réception de la présente. Si le paiement a été effectué, merci de ne pas tenir compte de cette lettre.'
                //    +FORMAT(Char13) + FORMAT(Char10)
                //    +FORMAT(Char13) + FORMAT(Char10)
                //    +FORMAT(Char13) + FORMAT(Char10)
                //    +'Dans l’attente du règlement, nous vous prions d’agréer, cher client, nos salutations distinguées.'
                //    +FORMAT(Char13) + FORMAT(Char10)
                //    +FORMAT(Char13) + FORMAT(Char10)
                //    +FORMAT(Char13) + FORMAT(Char10)
                //    +'Cordialement,'
                //    +FORMAT(Char13) + FORMAT(Char10)
                //    +FORMAT(Char13) + FORMAT(Char10)
                //    +'Département Finance'
                // END;
                //
                // IF "Reminder Level" =2 THEN BEGIN
                //  BeginText :=
                //    'Cher Client,'
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    //HEI.03>>
                //    //+STRSUBSTNO('Sauf erreur ou omission de notre part, malgré notre précédent rappel (Référence:"%1") les factures référencées ci-dessous demeurent toujours impayées.',"No.");
                //    + STRSUBSTNO('Sauf erreur ou omission de notre part, malgré notre précédent rappel (Référence: Relance 1) les factures référencées ci-dessous demeurent toujours impayées.',"No.");
                //    //HEI.03<<
                //  EndText :=
                //    'Comme stipulé dans nos délais de paiements contractuels, le solde arriéré doit être payé à réception de la présente.'
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +'Nous vous remercions de bien vouloir régler ce solde afin d’éviter toute action en recouvrement forcé avec le calcul des intérêts de retard et l’annulation de nouvelles commandes.'
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +'Dans le cas où le paiement demandé a été effectué, nous vous remercions de ne pas tenir compte de la présente lettre de relance.'
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +'Dans l’attente du règlement, nous vous prions d’agréer, cher client, nos salutations distinguées.'
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +'Cordialement,'
                //    +FORMAT(Char13) + FORMAT(Char10)
                //    +FORMAT(Char13) + FORMAT(Char10)
                //    +'Département Finance'
                // END;
                //
                // IF "Reminder Level" =3 THEN BEGIN
                //  BeginText :=
                //    'Cher Client,'
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +'Par courrier, en date du ……………….. et du ……………….. (1ère et 2ème relance), nous vous adressions deux relances de paiement concernant vos dettes en nos livres.'
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +'Or, à ce jour, sauf erreur ou omission de notre part, cette dette reste impayée et se présente comme ci-dessous:';
                //  EndText :=
                //    'Nous sommes, par conséquent, contraints de vous mettre en demeure de payer la somme due sous huitaine à compter de la réception de cette lettre avec avis de réception.'
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +'Si malgré cette mise en demeure vous n''exécutiez pas votre obligation de payer, nous nous réservons le droit d''obtenir très rapidement la somme due, par tous les moyens légaux prévus avec une fermeture définitive de vos comptes en nos livres.'
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +'Si toutefois vous aviez procédé à un règlement, nous vous demandons de ne pas tenir compte de ce courrier.'
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +'Dans l’attente d’un règlement, nous vous prions d’agréer, Monsieur, nos salutations distinguées.'
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +FORMAT(Char13)+FORMAT(Char10)
                //    +'Cordialement,'
                //    +FORMAT(Char13) + FORMAT(Char10)
                //    +FORMAT(Char13) + FORMAT(Char10)
                //    +'Département Finance';
                // END;
                //
                // Footer :='';
                // Footer :=
                //  'Brasseries du Congo – S.A. au capital de 60 593 967 000 F CFA – R.C.C.M.: CG-BZV-01-1968-B14-00006 – Régime Fiscal: IS/UGE-BZV – NIU: M20000000170390J'
                //  +FORMAT(Char13) + FORMAT(Char10)
                //  +'Siège Social: Avenue Edith Lucie Bongo Ondimba – B.P. 105 – Brazzaville – République du Congo'
                //  +FORMAT(Char13) + FORMAT(Char10)
                //  +'Agence Pointe-Noire: Boulevard Bitelika Dombi – B.P. 1147 – Pointe-Noire –  République du Congo'
                //  +FORMAT(Char13) + FORMAT(Char10)
                //  +'Agence OYO: Avenue Marcel OKOYO, Quartier BIALA – Agence Dolisie: Route Nationale N° 1, Quartier Lissanga Mbounda'
                //HEI.03<<
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
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        GLSetup.GET;
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
        CustomerNoLbl: TextConst ENU = 'Account No.', FRA = 'N° compte client';
        DocumentNoLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        DocumentTypeLbl: TextConst ENU = 'Document Type', FRA = 'Type document';
        DocumentDateLLbl: TextConst ENU = 'Document Date', FRA = 'Date du document';
        DescriptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        DisputedLbl: TextConst ENU = 'Disputed', FRA = 'Contesté';
        DueDateLbl: TextConst ENU = 'Due Date', FRA = 'Date d''échéance';
        ReminderLevelLbl: TextConst ENU = 'Dunning Level', FRA = 'Relance';
        OriginalAmountLbl: TextConst ENU = 'Original Amount', FRA = 'Montant initial';
        RemainingAmountLbl: TextConst ENU = 'Remaining Amount', FRA = 'Montant ouvert';
        TotalLbl: TextConst ENU = 'Total', FRA = 'Total dû';
        GLSetup: Record "General Ledger Setup";
        CurrencyCode: Text;
        CustomerAttributes: Record "Customer Attributes FND";
        SUMIssuedReminderLine: Record "Issued Reminder Line";
        ReminderText: Record "Reminder Text";
        BeginText: Text;
        EndText: Text;
        PageNoLbl: TextConst ENU = 'Page No.', FRA = 'Page N°';
        // Language: Record Language; // BC Upgrade BHARDA11 ::Blocked
        LanguageMgt: Codeunit Language; // BC Upgrade BHARDA11 ::Added

        Customer: Record Customer;
        CompanyNameLbl: Label 'Company Name';
        BankNameLbl: TextConst ENU = 'Bank Name', FRA = 'Banque';
        BankNoLbl: TextConst ENU = 'Bank No.', FRA = 'N° compte';
        ContactPerson: Text[250];
        DocumentCurrencyLbl: TextConst ENU = 'Document Currency', FRA = 'Monnaie du document';
        DateDeComptabilisationLbl: TextConst ENU = 'Date de comptabilisation', FRA = 'Date de comptabilisation';
        ForeignCustomer: Boolean;
        Char13: Char;
        Char10: Char;
        Footer: Text;
        FullAddress: Text;
}

