report 51031 "Remittance Advice CBN"
{
    // version HEI.08

    // HEI.01 IBM ISYED01 06/10/2019 CHG2000927 Remittance Advide
    //  #created new report for remittance advice.
    // HEI.02 IBM SHANKJ03  03.23.2021
    //  # New Data Source added
    //  # Code added
    // HEI.03 IBM SHANKJ03 CHG2109130 05.05.2021
    //  # Code added for Var clearing
    // HEI.04 IBM BHATTA09 CHG2135905 05.05.2021 # HB2663 Payment remittance advice – French translation
    //  # Code added for for changing Language based on setup
    //  # French Captions added for the labels used in the report
    // HEI.05 CHG2244079 IBM VERMAA03 25.06.2024 HB3802 Remittance advice – Spanish translation
    //   # Added Code on OnPreReport() for changing Language based on setup
    //   # Mapped fields and added row visibility conditions in report layout.
    // HEI.06 CHG2244079 IBM VERMAA03 01.07.2024 HB3802 Remittance advice – Spanish translation
    //   # Code added and commented on Integer - OnAfterGetRecord()
    // HEI.07 CHG2244079 IBM VERMAA03 18.07.2024 HB3802 Remittance advice – Spanish translation
    //   # Code added and commented on Integer - OnAfterGetRecord()
    //   # Added new function GetPostingDateFromPayJnlTree()
    // HEI.08 CHG2244079 HB3802 IBM SRIVAS07 24.07.2024 # Remittance advice – Spanish translation
    //   # Commented few code.

    // BC Upgrade KUMARS145 Nav ID Report 50185 "Remittance Advice"

    DefaultLayout = RDLC;
    RDLCLayout = './src/ReportsLayout/Remittance Advice.rdl';

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            column(InvoiceDate; VendorLedgerEntry."Posting Date") { }
            column(RemainingAmt; RemainingAmt) { }
            column(GrosAMTVLE; GrosAMTVLE) { }
            column(WHTAmount; WHTAmount) { }
            column(DiscountTaken; VendorLedgerEntry."Inv. Discount (LCY)") { }
            column(InvoiceNo; VLEExtrnlDoc) { }
            column(PaidAmt; ChaildPaidAmount) { }
            column(GenJnl_PostingDate; ParentGNJNL."Posting Date") { }
            column(CurrencyCode; CurrencyCode) { }
            column(SupplierName; SupplierName) { }
            column(Ven_AddressLine1; Ven_AddressLine1) { }
            column(Ven_AddressLine2; Ven_AddressLine2) { }
            column(Ven_PostCode; Ven_PostCode) { }
            column(Ven_City; Ven_City) { }
            column(Ven_County; Ven_County) { }
            column(Ven_VatRegNum; Ven_VatRegNum) { }
            column(VendorEmail; VendorEmail) { }
            column(PayingCompCodeName; PayingCompCodeName) { }
            column(Comp_AddressLine1; Comp_AddressLine1) { }
            column(Comp_AddressLine2; Comp_AddressLine2) { }
            column(Comp_PostCode; Comp_PostCode) { }
            column(Comp_City; Comp_City) { }
            column(Comp_County; Comp_County) { }
            column(Comp_VatRegNum; Comp_VatRegNum) { }
            column(GenJnl_Paymentref; ParentGNJNL."Payment Reference") { }
            column(Comp_Email; Comp_Email) { }
            column(Comp_Phone; Comp_Phone) { }
            column(CheckNo; CheckNo) { }
            column(BankTransferId; BankTransferId) { }
            column(IsLanguageSpanish; IsLanguageSpanish) { }
            column(PostingDate; PostingDate) { }
            column(DV64Text; DV64) { }

            trigger OnAfterGetRecord();
            var
                lrec_WHTENtry: Record "WHT Entry FND";
            begin
                if Number = 1 then
                    ParentGNJNL.FindFirst()
                else
                    if ParentGNJNL.Next() = 0 then
                        CurrReport.Break();
                begin

                    if Vendor.Get(ParentGNJNL."Account No.") then begin
                        SupplierName := Vendor.Name;
                        Ven_AddressLine1 := Vendor.Address;
                        Ven_AddressLine2 := Vendor."Address 2";
                        Ven_City := Vendor.City;
                        if CountryRegion.Get(Vendor.County) then
                            Ven_County := Vendor.County;
                        Ven_PostCode := Vendor."Post Code";
                        Ven_VatRegNum := Vendor."VAT Registration No.";
                        VendorEmail := Vendor."E-Mail 2 FND";
                        //HEI.06>>
                        //HEI.05>>
                        //CLEAR(PostingDate);
                        //IF IsLanguageSpanish THEN
                        //  PostingDate := ParentGNJNL."Posting Date";
                        //HEI.05<<
                        //HEI.06<<
                    end;

                    if CompanyInformation.Get() then begin
                        PayingCompCodeName := CompanyInformation.Name;
                        Comp_AddressLine1 := CompanyInformation.Address;
                        Comp_AddressLine2 := CompanyInformation."Address 2";
                        Comp_City := CompanyInformation.City;
                        Comp_County := CompanyInformation.County;
                        Comp_VatRegNum := CompanyInformation."VAT Registration No.";
                        //HEI.05>>
                        if GenOpCoSetup."Spanish Payment Remittance" then
                            Comp_Email := CompanyInformation."Account Payable Email FND"
                        else
                            //HEI.05<<
                            Comp_Email := CompanyInformation."E-Mail";
                        Comp_Phone := CompanyInformation."Phone No.";
                    end;
                    GeneralLedgerSetup.Get();
                    if ParentGNJNL."Currency Code" <> '' then
                        CurrencyCode := ParentGNJNL."Currency Code"
                    else
                        CurrencyCode := GeneralLedgerSetup."LCY Code";

                    RemainingAmt := 0;
                    EntriesFound := 0;
                    //HEI.02 >>
                    VendorLedgerEntry.Reset();
                    VendorLedgerEntry.SetRange("Document Type", VendorLedgerEntry."Document Type"::Invoice);
                    VendorLedgerEntry.SetRange("Document No.", ParentGNJNL."Applies-to Doc. No.");
                    VendorLedgerEntry.SetRange("Vendor No.", ParentGNJNL."Account No.");
                    if VendorLedgerEntry.FindFirst() then begin
                        VLEExtrnlDoc := VendorLedgerEntry."External Document No.";
                        //HEI.06>>
                        Clear(PostingDate);
                        // IF IsLanguageSpanish THEN //HEI.08
                        //PostingDate := VendorLedgerEntry."Posting Date"; //HEI.07
                        PostingDate := gPayJnlTreePostingDate; //HEI.07
                                                               //HEI.06<<
                        VendorLedgerEntry.CalcFields(Amount);
                        VendorLedgerEntry.CalcFields("Original Amount");
                        VendorLedgerEntry.CalcFields("WHT Amount FND");
                        VendLedEntryRec1.Reset();
                        VendLedEntryRec1.SetRange("Closed by Entry No.", VendorLedgerEntry."Entry No.");
                        if VendLedEntryRec1.FindFirst() then begin
                            WHTEntryRec.Reset();
                            WHTEntryRec.SetRange("Document No.", VendLedEntryRec1."Document No.");
                            //WHTEntryRec.SETRANGE("Original Document No.",VendorLedgerEntry."Document No.");
                            if WHTEntryRec.FindFirst() then begin
                                if WHTEntryRec."WHT Bearer" = WHTEntryRec."WHT Bearer"::Opco then begin
                                    //GrosAMTVLE := VendorLedgerEntry."Original Amount" + VendorLedgerEntry."WHT Amount";
                                    GrosAMTVLE := VendorLedgerEntry.Amount;
                                    WHTAmount := 0;
                                    ChaildPaidAmount := VendorLedgerEntry.Amount;
                                end else if WHTEntryRec."WHT Bearer" = WHTEntryRec."WHT Bearer"::Vendor then begin
                                    WHTAmount := 0; // HEI.03
                                    GrosAMTVLE := Abs(VendorLedgerEntry."Original Amount"); //+ VendorLedgerEntry."WHT Amount";
                                                                                            //TEMP>>
                                                                                            //WHTAmount := VendorLedgerEntry."WHT Amount";
                                    lrec_WHTENtry.Reset();
                                    lrec_WHTENtry.SetRange("Document No.", VendorLedgerEntry."Document No.");
                                    lrec_WHTENtry.SetRange("Document Type", lrec_WHTENtry."Document Type"::Payment);//HEI.03
                                    if lrec_WHTENtry.FindSet() then
                                        repeat
                                            WHTAmount += lrec_WHTENtry.Amount;    //HEI.03
                                        until lrec_WHTENtry.Next() = 0;
                                    //TEMP<<
                                    ChaildPaidAmount := Abs(VendorLedgerEntry.Amount);
                                end;
                            end;
                        end else begin
                            GrosAMTVLE := Abs(VendorLedgerEntry."Original Amount") + VendorLedgerEntry."WHT Amount FND";
                            WHTAmount := VendorLedgerEntry."WHT Amount FND";
                            ChaildPaidAmount := Abs(VendorLedgerEntry.Amount);
                        end;
                        //HEI.02 <<
                        ChaildPaidAmount := ParentGNJNL.Amount;
                        //END;
                        if RemainingAmt < 0 then
                            RemainingAmt := -RemainingAmt;
                        //HEI.$$>>
                        if ParentGNJNL."HNK Check No. FND" <> '' then
                            CheckNo := ParentGNJNL."HNK Check No. FND";

                        if CheckNo = '' then begin
                            if VendorLedgerEntry."Payment Reference" <> '' then
                                BankTransferId := VendorLedgerEntry."Payment Reference"
                            else
                                BankTransferId := VendorLedgerEntry."Document No.";
                        end
                    end;
                end;

                if CheckNo = '' then begin
                    if ParentGNJNL."Payment Reference" <> '' then
                        BankTransferId := ParentGNJNL."Payment Reference"
                    else
                        BankTransferId := ParentGNJNL."Document No.";
                end;
            end;

            trigger OnPreDataItem();
            begin
                ParentGNJNL.Reset();
                SetRange(Number, 1, ParentGNJNL.Count);

                if not ParentGNJNL.FindFirst() then
                    CurrReport.Break();
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
        label(ReportHeaderlbl; ENU = 'Remittance Advice', ESP = 'AVISO DE PAGO', FRA = 'Avis de versement')
        label(ReportH1Llbl; ENU = 'For the attention of:', ESP = 'Páguese a:', FRA = '‡ l''attention de:')
        label(ReportH2Rlbl; ENU = 'Payer Company', ESP = 'Empresa pagadora', FRA = 'Entreprise payeuse')
        label(RequestedExeDatelbl; ENU = 'Requested Execution Date:', ESP = 'Fecha de ejecución solicitada:', FRA = 'Date d''exécution demandée:')
        label(Amountlbl; ENU = 'Amount:', ESP = 'Monto:', FRA = 'Montant:')
        label(Currencylbl; ENU = 'Currency:', ESP = 'Moneda:', FRA = 'Devise:')
        label(InvoiceNumberlbl; ENU = 'Invoice Number', ESP = 'Factura', FRA = 'Numéro de facture')
        label(InvoiceDatelbl; ENU = 'Invoice Date', ESP = 'Fecha', FRA = 'Date de la facture')
        label(GrossAmtlbl; ENU = 'Gross Amount', ESP = 'Monto bruto', FRA = 'Montant Brut')
        label(PaidAmtlbl; ENU = 'Paid Amount', ESP = 'Monto pagado', FRA = 'Montant Payé')
        label(Discounttakenlbl; ENU = 'Discount Taken', ESP = 'Monto descontado', FRA = 'Remise Prise')
        label(Curremcylbl; ENU = 'Currency', ESP = 'Moneda', FRA = 'Devise')
        label(Totallbl; ENU = 'Total', ESP = 'Total', FRA = 'Le Total')
        label(B1lbl; ENU = 'Dear Supplier,', ESP = 'Estimado proveedor,', FRA = 'Cher Fournisseur,')
        label(B2lbl; ENU = 'We have settled the items below by cheque / bank transfer',
                    ESP = 'Hemos liquidado los siguientes artículos mediante cheque/transferencia bancaria',
                    FRA = 'Nous avons réglé les éléments ci-dessous par chèque/virement bancaire sous réserve des biens et services fournis')
        label(B3lbl; ENU = 'subject to goods and services supplied, your cheque / bank transfer reference ID number are listed below.',
                    ESP = 'Sujeto a los bienes y servicios suministrados, el número de identificación de referencia de su cheque/transferencia bancaria se detalla a continuación.',
                    FRA = ', votre numéro d''identification de référence de chèque/virement bancaire est indiqué ci-dessous.')
        label(B4lbl; ENU = 'Transfer Instructions have been sent to the bank and payment will be executed,as per the bank cut-off time.',
                    ESP = 'Las instrucciones de transferencia se han enviado al banco y el pago se ejecutará según la hora límite del banco.',
                    FRA = 'Les instructions de transfert ont été envoyées à la banque et le paiement sera exécuté, selon l''heure limite de la banque.')
        label(B5lbl; ENU = 'Cheques are ready for collection or will be posted as per the Opco policy or agreement.',
                    ESP = 'Los cheques están listos para su cobro o se publicarán según la política o el acuerdo de Opco.',
                    FRA = 'Les chèques sont prêts à être collectés ou seront affichés conformément à la politique ou à l''accord d''Opco.')
        label(B6lbl; ENU = 'You can contact us for information at the following contact details:-',
                    ESP = 'Puede contactarnos para obtener información en los siguientes datos de contacto: -',
                    FRA = 'Vous pouvez nous contacter pour plus d''informations aux coordonnées suivantes:-')
        label(Emaillbl; ENU = 'Email:', ESP = 'Correo electrónico:', FRA = 'Email:')
        label(Phonelbl; ENU = 'Phone:', ESP = 'Teléfono:', FRA = 'Téléphone:')
        label(Chequeidlbl; ENU = 'Cheque ID', ESP = 'ID de Cheque', FRA = 'Cheque ID')
        label(BankTransferIdlbl; ENU = 'Bank Transfer ID', ESP = 'ID de Ref. Bancaria', FRA = 'Bank Transfer ID')
        label(WHTAmtlbl; ENU = 'WHT Amount', ESP = 'Monto retenido', FRA = 'WHT Amount')
    }

    trigger OnPreReport();
    begin
        //HEI.04>>
        if Vendor.Get(gVendNo) then begin
            VendLanguage := Vendor."Language Code";
            GenOpCoSetup.Get;
            if (GenOpCoSetup."French Payment Remittance" = true) and (GenOpCoSetup."Payment Remittance Language" = VendLanguage) then begin
                // CurrReport.LANGUAGE := LanguageRec.GetLanguageID(VendLanguage); // BC Upgrade KUMARS145 base function commented carried function called. 
                CurrReport.Language := GetLanguageID(VendLanguage);
            end;

            //HEI.05>>
            Clear(DV64);
            Clear(IsLanguageSpanish);
            if (GenOpCoSetup."Spanish Payment Remittance" = true) and (GenOpCoSetup."Payment Remittance Language Sp" = VendLanguage) then begin
                // CurrReport.LANGUAGE := LanguageRec.GetLanguageID(VendLanguage); // BC Upgrade KUMARS145 base function commented carried function called. 
                CurrReport.Language := GetLanguageID(VendLanguage);
                IsLanguageSpanish := true;
                DV64 := 'DV 64';
            end;
            //HEI.05<<

        end;
        //HEI.04<<
    end;

    var
        Vendor: Record Vendor;
        SupplierName: Text;
        Ven_AddressLine1: Text;
        Ven_AddressLine2: Text;
        Ven_PostCode: Code[500];
        Ven_City: Code[500];
        Ven_County: Code[500];
        Ven_VatRegNum: Text[500];
        VendorEmail: Text;
        PayingCompCodeName: Text;
        Comp_AddressLine1: Text;
        Comp_AddressLine2: Text;
        Comp_PostCode: Code[500];
        Comp_City: Code[500];
        Comp_County: Code[500];
        Comp_VatRegNum: Text;
        CompanyInformation: Record "Company Information";
        CountryRegion: Record "Country/Region";
        CurrencyCode: Code[20];
        GeneralLedgerSetup: Record "General Ledger Setup";
        Comp_Email: Text[500];
        Comp_Phone: Text[500];
        ParentGNJNL: Record "Gen. Journal Line" temporary;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        RemainingAmt: Decimal;
        BankTransferId: Code[50];
        CheckNo: Code[50];
        TempGnJNL: Record "Gen. Journal Line";
        GenJournalLine: Record "Gen. Journal Line";
        VLEExtrnlDoc: Code[20];
        ChaildPaidAmount: Decimal;
        PParentGNJNL: Record "Gen. Journal Line" temporary;
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        DetailedVendorLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        EntriesFound: Integer;
        VendLedEntryRec1: Record "Vendor Ledger Entry";
        WHTEntryRec: Record "WHT Entry FND";
        GrosAMTVLE: Decimal;
        WHTAmount: Decimal;
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        GenOpCoSetup: Record "General OpCo Setup FND";
        VendLanguage: Code[10];
        LanguageRec: Record Language;
        gVendNo: Code[20];
        IsLanguageSpanish: Boolean;
        PostingDate: Date;
        DV64: Text;
        gPayJnlTreePostingDate: Date;

    local procedure SendReportAsEmailPDF();
    begin
    end;

    procedure SetFilterGNL(var RecGNJL: Record "Gen. Journal Line" temporary);
    begin
        ParentGNJNL.DeleteAll();
        if RecGNJL.FindSet() then begin
            repeat
                ParentGNJNL.Init();
                ParentGNJNL.Copy(RecGNJL);
                ParentGNJNL.Insert();
            until RecGNJL.Next() = 0;
        end;
        Commit();
    end;

    procedure GetVendNoFromPayJnlTree(VendorNo: Code[20]);
    begin
        //HEI.04>>
        gVendNo := VendorNo;
        //HEI.04<<
    end;

    procedure GetPostingDateFromPayJnlTree(PayJnlPostingDate: Date);
    begin
        //HEI.07>>
        gPayJnlTreePostingDate := PayJnlPostingDate;
        //HEI.07<<
    end;

    // BC Upgrade KUMARS145 Carried Function from Nav .....>>
    local procedure GetLanguageID(LanguageCode: Code[10]): Integer;
    var
        LanguageLocal: Record Language;
    begin
        if LanguageCode <> '' then
            if LanguageLocal.Get(LanguageCode) then
                exit(LanguageLocal."Windows Language ID");
        LanguageLocal."Windows Language ID" := GlobalLanguage;
        exit(LanguageLocal."Windows Language ID");
    end;
    // BC Upgrade KUMARS145 Carried Function from Nav .....<<

}

