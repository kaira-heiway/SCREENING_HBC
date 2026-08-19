// report 52014 "Remittance Advice VLE"
// {
//     // version HEI.09

//     // HEI.01 IBM ISYED01 06/10/2019 CHG2000927 Remittance Advide
//     //  #created new report for remittance advice.
//     // HEI.02 IBM SHANKJ03  03.23.2021
//     //  # New Data Source added
//     //  # Code added
//     // HEI.03 IBM SHANKJ03 CHG2109130 05.05.2021
//     //  # Code added for Var clearing
//     // HEI.04 IBM BHATTA09 CHG2135905 02.02.2022 # HB2663 Payment remittance advice – French translation
//     //  # Code added for for changing Language based on setup
//     //  # French Captions added for the labels used in the report
//     // HEI.05 FDD-HB2663 - CHG2135905 IBM NANDIS01 05.05.2022 # Payment remittance advice – French translation
//     //   # Fix on Amount related fields as those fields are not showing correct values
//     //   # Changes in report layout as well with datasource
//     // HEI.06 CHG2161203 IBM NANDIS01 17.06.2022 # Remittance Advice Omission of WHT
//     //   # Fix after receiving incident from st Lucia - INC4136277
//     // HEI.07 CHG2161203 IBM NANDIS01 08.07.2022 # Remittance Advice Omission of WHT
//     //   # Fix after receiving incident from st Lucia - INC4136277
//     // HEI.08 CHG2244079 IBM VERMAA03 25.06.2024 HB3802 Remittance advice – Spanish translation
//     //   # Code added on OnPreReport() for changing Language based on setup
//     //   # Mapped fields and added row visibility conditions in report layout.
//     // HEI.09 CHG2244079 HB3802 IBM SRIVAS07 24.07.2024 # Remittance advice – Spanish translation
//     //   # Commented few code.
//     // BC Upgrade BHARDA11 >>
//     // 1. Old Report ID - 50179.
//     // 2. Add ApplicationArea Property in Report.
//     // 3. Add layout path and Change extension RDLC to RDL.
//     // 4. Change Language to LanguageMgt and Record to Codeunit.
//     // BC Upgrade BHARDA11 <<
//     ApplicationArea = All;
//     UsageCategory = ReportsAndAnalysis;
//     DefaultLayout = RDLC;
//     RDLCLayout = '.\src\Reportslayout\Remittance Advice VLE.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.


//     dataset
//     {
//         dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
//         {
//             DataItemTableView = WHERE("Initial Document Type" = FILTER(Invoice));
//             column(InvoiceDate; VendLedEntryRec."Posting Date")
//             {
//             }
//             column(RemainingAmt; RemainingAmt)
//             {
//             }
//             column(GrosAMTVLE; GrosAMTVLE)
//             {
//             }
//             column(WHTAmount; WHTAmount)
//             {
//             }
//             column(DiscountTaken; VendorLedgerEntry."Inv. Discount (LCY)")
//             {
//             }
//             column(InvoiceNo; VLEExtrnlDoc)
//             {
//             }
//             column(PaidAmt; ChaildPaidAmount)
//             {
//             }
//             column(GenJnl_PostingDate; ParentGNJNL."Posting Date")
//             {
//             }
//             column(CurrencyCode; CurrencyCode)
//             {
//             }
//             column(SupplierName; SupplierName)
//             {
//             }
//             column(Ven_AddressLine1; Ven_AddressLine1)
//             {
//             }
//             column(Ven_AddressLine2; Ven_AddressLine2)
//             {
//             }
//             column(Ven_PostCode; Ven_PostCode)
//             {
//             }
//             column(Ven_City; Ven_City)
//             {
//             }
//             column(Ven_County; Ven_County)
//             {
//             }
//             column(Ven_VatRegNum; Ven_VatRegNum)
//             {
//             }
//             column(VendorEmail; VendorEmail)
//             {
//             }
//             column(PayingCompCodeName; PayingCompCodeName)
//             {
//             }
//             column(Comp_AddressLine1; Comp_AddressLine1)
//             {
//             }
//             column(Comp_AddressLine2; Comp_AddressLine2)
//             {
//             }
//             column(Comp_PostCode; Comp_PostCode)
//             {
//             }
//             column(Comp_City; Comp_City)
//             {
//             }
//             column(Comp_County; Comp_County)
//             {
//             }
//             column(Comp_VatRegNum; Comp_VatRegNum)
//             {
//             }
//             column(GenJnl_Paymentref; ParentGNJNL."Payment Reference")
//             {
//             }
//             column(Comp_Email; Comp_Email)
//             {
//             }
//             column(Comp_Phone; Comp_Phone)
//             {
//             }
//             column(CheckNo; CheckNo)
//             {
//             }
//             column(BankTransferId; BankTransferId)
//             {
//             }
//             column(IsLanguageSpanish; IsLanguageSpanish)
//             {
//             }
//             column(PostingDate; PostingDate)
//             {
//             }
//             column(DV64Text; DV64)
//             {
//             }

//             trigger OnAfterGetRecord();
//             var
//                 lrec_WHTENtry: Record "WHT Entry";
//                 l_VendorLedgerEntry: Record "Vendor Ledger Entry";
//             begin
//                 //HEI.07>>
//                 ////HEI.05>>
//                 //IF ("Detailed Vendor Ledg. Entry"."Document No." <> DVLEDocNo) THEN
//                 //  DVLEDocNo := "Detailed Vendor Ledg. Entry"."Document No."
//                 //ELSE
//                 //  CurrReport.SKIP;
//                 ////HEI.05<<

//                 //HEI.08>>
//                 CLEAR(PostingDate);
//                 //IF IsLanguageSpanish THEN BEGIN //HEI.09
//                 PostingDate := "Detailed Vendor Ledg. Entry"."Posting Date";
//                 //END; //HEI.09
//                 //HEI.08<<

//                 //HEI.07<<
//                 if Vendor.GET("Detailed Vendor Ledg. Entry"."Vendor No.") then begin
//                     SupplierName := Vendor.Name;
//                     Ven_AddressLine1 := Vendor.Address;
//                     Ven_AddressLine2 := Vendor."Address 2";
//                     Ven_City := Vendor.City;
//                     if CountryRegion.GET(Vendor.County) then
//                         Ven_County := Vendor.County;
//                     Ven_PostCode := Vendor."Post Code";
//                     Ven_VatRegNum := Vendor."VAT Registration No.";
//                     //VendorEmail       := Vendor."E-Mail";
//                     VendorEmail := Vendor."E-Mail 2";
//                 end;

//                 if CompanyInformation.GET() then begin
//                     PayingCompCodeName := CompanyInformation.Name;
//                     Comp_AddressLine1 := CompanyInformation.Address;
//                     Comp_AddressLine2 := CompanyInformation."Address 2";
//                     Comp_City := CompanyInformation.City;
//                     Comp_County := CompanyInformation.County;
//                     Comp_VatRegNum := CompanyInformation."VAT Registration No.";
//                     //HEI.08>>
//                     if GenOpCoSetup."Spanish Payment Remittance" then
//                         Comp_Email := CompanyInformation."Account Payable Email"
//                     else
//                         //HEI.08<<
//                         Comp_Email := CompanyInformation."E-Mail";

//                     Comp_Phone := CompanyInformation."Phone No.";
//                 end;

//                 GeneralLedgerSetup.GET();

//                 //HEI.07>>
//                 if VendLedEntryRec.GET("Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.") then begin
//                     if VendLedEntryRec."Currency Code" <> '' then
//                         CurrencyCode := ParentVLE."Currency Code"
//                     else
//                         CurrencyCode := GeneralLedgerSetup."LCY Code";

//                     RemainingAmt := 0;
//                     EntriesFound := 0;
//                     DetailedVendorLedgEntry.RESET;
//                     DetailedVendorLedgEntry.SETRANGE("Vendor Ledger Entry No.", VendLedEntryRec."Entry No.");
//                     DetailedVendorLedgEntry.SETRANGE("Initial Document Type", DetailedVendorLedgEntry."Initial Document Type"::Invoice);
//                     if DetailedVendorLedgEntry.FINDFIRST then begin
//                         VendLedEntryRec.RESET;
//                         VendLedEntryRec.SETRANGE("Entry No.", DetailedVendorLedgEntry."Vendor Ledger Entry No.");
//                         if VendLedEntryRec.FINDFIRST then begin
//                             VendLedEntryRec.CALCFIELDS(Amount);
//                             VendLedEntryRec.CALCFIELDS("Original Amount");
//                             VendLedEntryRec.CALCFIELDS("WHT Amount");
//                             VLEExtrnlDoc := VendLedEntryRec."External Document No.";

//                             WHTEntryRec.RESET;
//                             WHTEntryRec.SETRANGE("Document No.", VendLedEntryRec."Document No.");
//                             if WHTEntryRec.FINDFIRST then begin
//                                 if WHTEntryRec."WHT Bearer" = WHTEntryRec."WHT Bearer"::Opco then begin
//                                     GrosAMTVLE := ABS(VendLedEntryRec.Amount);
//                                     WHTAmount := 0;
//                                     ChaildPaidAmount := VendLedEntryRec.Amount;
//                                 end else if WHTEntryRec."WHT Bearer" = WHTEntryRec."WHT Bearer"::Vendor then begin
//                                     WHTAmount := 0;
//                                     ChaildPaidAmount := 0;
//                                     //GrosAMTVLE := ABS(VendLedEntryRec."Original Amount") + VendLedEntryRec."WHT Amount";
//                                     lrec_WHTENtry.RESET;
//                                     lrec_WHTENtry.SETRANGE("Document No.", VendLedEntryRec."Document No.");
//                                     if lrec_WHTENtry.FINDFIRST then begin
//                                         if (lrec_WHTENtry."WHT Bus. Posting Group" <> '') and (lrec_WHTENtry."WHT Prod. Posting Group" <> '') then begin
//                                             if WHTPostingSetup.GET(lrec_WHTENtry."WHT Bus. Posting Group", lrec_WHTENtry."WHT Prod. Posting Group") then begin
//                                                 if (WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment) then
//                                                     CalculatePaidAmount := true;
//                                             end;
//                                         end;
//                                     end;
//                                     if lrec_WHTENtry.FINDSET(false, false) then
//                                         repeat
//                                             WHTAmount += lrec_WHTENtry.Amount;
//                                         until lrec_WHTENtry.NEXT = 0;
//                                     GrosAMTVLE := ABS(VendLedEntryRec."Original Amount");
//                                     if CalculatePaidAmount then
//                                         ChaildPaidAmount := GrosAMTVLE - WHTAmount
//                                     else
//                                         ChaildPaidAmount := GrosAMTVLE;
//                                     //lrec_WHTENtry.SETRANGE("Document Type",lrec_WHTENtry."Document Type"::Payment);
//                                     //IF lrec_WHTENtry.FINDSET THEN REPEAT
//                                     //  WHTAmount += lrec_WHTENtry.Amount;
//                                     //UNTIL lrec_WHTENtry.NEXT = 0;
//                                     //ChaildPaidAmount := ABS(VendLedEntryRec.Amount) - WHTAmount;
//                                 end;
//                             end else begin
//                                 GrosAMTVLE := ABS(VendLedEntryRec."Original Amount") + VendLedEntryRec."WHT Amount";
//                                 WHTAmount := VendLedEntryRec."WHT Amount";
//                                 ChaildPaidAmount := ABS(VendLedEntryRec.Amount);
//                             end;
//                         end;
//                     end;
//                 end;
//                 EntriesFound += 1;
//                 //HEI.07<<

//                 //HEI.07>>
//                 // //HEI.05>>
//                 // IF VendLedEntryRec.GET("Detailed Vendor Ledg. Entry"."Applied Vend. Ledger Entry No.") THEN BEGIN
//                 //  CreateVendLedgEntry := VendLedEntryRec;
//                 //  FindApplnEntriesDtldtLedgEntry;
//                 //  //VendLedEntryRec.SETCURRENTKEY("Entry No.");
//                 //  VendLedEntryRec.SETRANGE("Entry No.");
//                 //
//                 //  IF CreateVendLedgEntry."Closed by Entry No." <> 0 THEN
//                 //    VendLedEntryRec."Entry No." := CreateVendLedgEntry."Closed by Entry No.";
//                 //
//                 //  VendLedEntryRec.SETCURRENTKEY("Closed by Entry No.");
//                 //  VendLedEntryRec.SETRANGE("Closed by Entry No.",CreateVendLedgEntry."Entry No.");
//                 //  //IF VendLedEntryRec.FIND('-') THEN REPEAT
//                 //  //UNTIL NEXT = 0;
//                 //
//                 //  //VendLedEntryRec.SETCURRENTKEY("Entry No.");
//                 //  //VendLedEntryRec.SETRANGE("Closed by Entry No.");
//                 // END;
//                 // IF VLEntry.GET("Detailed Vendor Ledg. Entry"."Applied Vend. Ledger Entry No.") THEN BEGIN
//                 //  VLEntry.CALCFIELDS(Amount);
//                 //  ChaildPaidAmount := VLEntry.Amount;
//                 // END;
//                 //
//                 // IF VendorLedgerEntry.GET(VendLedEntryRec."Entry No.") AND (VendorLedgerEntry."Document No." <> VLEDocNo) THEN BEGIN
//                 //  VLEExtrnlDoc := VendorLedgerEntry."External Document No.";
//                 //  VLEDocNo := VendorLedgerEntry."Document No.";
//                 //  WHTAmount := 0;
//                 //  VendorLedgerEntry.CALCFIELDS("Original Amount");
//                 //  VendorLedgerEntry.CALCFIELDS("WHT Amount");
//                 //  VendorLedgerEntry.CALCFIELDS(Amount);
//                 //  lrec_WHTENtry.RESET;
//                 //  lrec_WHTENtry.SETRANGE("Document No.",VendorLedgerEntry."Document No.");
//                 //  //lrec_WHTENtry.SETRANGE("Posting Date",VendorLedgerEntry."Posting Date");//HEI.06
//                 //  lrec_WHTENtry.SETFILTER("WHT Bearer",'<>%1',lrec_WHTENtry."WHT Bearer"::Opco);
//                 //  IF lrec_WHTENtry.FINDSET(FALSE,FALSE) THEN REPEAT
//                 //    WHTAmount += lrec_WHTENtry.Amount;
//                 //  UNTIL lrec_WHTENtry.NEXT = 0;
//                 //  GrosAMTVLE := ABS(VendorLedgerEntry."Original Amount");
//                 // END;


//                 // IF VendLedEntryRec.GET("Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.") THEN BEGIN
//                 //  IF VendLedEntryRec."Currency Code" <> '' THEN
//                 //    CurrencyCode := ParentVLE."Currency Code"
//                 //  ELSE
//                 //    CurrencyCode := GeneralLedgerSetup."LCY Code";
//                 //
//                 //     RemainingAmt :=0;
//                 //     EntriesFound :=0;
//                 ////HEi.02>>
//                 // DetailedVendorLedgEntry.RESET;
//                 // DetailedVendorLedgEntry.SETRANGE("Vendor Ledger Entry No.",VendLedEntryRec."Entry No.");
//                 // DetailedVendorLedgEntry.SETRANGE("Initial Document Type",DetailedVendorLedgEntry."Initial Document Type"::Invoice);
//                 // IF DetailedVendorLedgEntry.FINDFIRST THEN BEGIN
//                 //   VendLedEntryRec.RESET;
//                 //   VendLedEntryRec.SETRANGE("Entry No.",DetailedVendorLedgEntry."Vendor Ledger Entry No.");
//                 //   IF VendLedEntryRec.FINDFIRST THEN BEGIN
//                 //     VendLedEntryRec.CALCFIELDS(Amount);
//                 //     VendLedEntryRec.CALCFIELDS("Original Amount");
//                 //     VendLedEntryRec.CALCFIELDS("WHT Amount");
//                 //     VLEExtrnlDoc := VendLedEntryRec."External Document No.";
//                 //
//                 //       WHTEntryRec.RESET;
//                 //       WHTEntryRec.SETRANGE("Document No.",VendLedEntryRec."Document No.");
//                 //      //WHTEntryRec.SETRANGE("Original Document No.",VendLedEntryRec."Document No.");
//                 //       IF WHTEntryRec.FINDFIRST THEN BEGIN
//                 //         IF WHTEntryRec."WHT Bearer" = WHTEntryRec."WHT Bearer"::Opco THEN BEGIN
//                 //         //GrosAMTVLE := ParentVLE."Original Amount" + ParentVLE."WHT Amount";
//                 //           GrosAMTVLE := ABS(VendLedEntryRec.Amount);
//                 //           WHTAmount := 0;
//                 //           ChaildPaidAmount := VendLedEntryRec.Amount;
//                 //          END ELSE IF WHTEntryRec."WHT Bearer" = WHTEntryRec."WHT Bearer"::Vendor THEN BEGIN
//                 //            WHTAmount := 0; //HEI.03
//                 //           GrosAMTVLE := ABS(VendLedEntryRec."Original Amount") + VendLedEntryRec."WHT Amount";
//                 //           //TEMP>>
//                 //           //WHTAmount := VendLedEntryRec."WHT Amount";
//                 //           //ChaildPaidAmount := ABS(VendLedEntryRec.Amount);
//                 //           lrec_WHTENtry.RESET;
//                 //           lrec_WHTENtry.SETRANGE("Document No.",VendLedEntryRec."Document No.");
//                 //           lrec_WHTENtry.SETRANGE("Document Type",lrec_WHTENtry."Document Type"::Payment);//HEI.03
//                 //           IF lrec_WHTENtry.FINDSET THEN REPEAT
//                 //             WHTAmount += lrec_WHTENtry.Amount;//HEI.03
//                 //           UNTIL lrec_WHTENtry.NEXT = 0;
//                 //           ChaildPaidAmount := ABS(VendLedEntryRec.Amount) - WHTAmount;
//                 //           //TEMP<<
//                 //          END;
//                 //       END ELSE BEGIN
//                 //         GrosAMTVLE := ABS(VendLedEntryRec."Original Amount") + VendLedEntryRec."WHT Amount";
//                 //         WHTAmount := VendLedEntryRec."WHT Amount";
//                 //         ChaildPaidAmount := ABS(VendLedEntryRec.Amount);
//                 //        END;
//                 //       END;
//                 //   END;
//                 //   //HEI.02 <<
//                 //END;
//                 //EntriesFound +=1;
//                 //HEI.05<<
//                 //HEI.07<<

//                 if RemainingAmt < 0 then
//                     RemainingAmt := -RemainingAmt;


//                 BankAccountLedgerEntry.SETRANGE("Document No.", VendLedEntryRec."Document No.");
//                 BankAccountLedgerEntry.SETRANGE("Posting Date", VendLedEntryRec."Posting Date");
//                 BankAccountLedgerEntry.SETRANGE("Bank Account No.", VendLedEntryRec."Bal. Account No.");
//                 if BankAccountLedgerEntry.FINDFIRST then begin
//                     CheckLedgerEntry.SETRANGE("Bank Account Ledger Entry No.", BankAccountLedgerEntry."Entry No.");
//                     CheckLedgerEntry.SETRANGE("Bank Account No.", BankAccountLedgerEntry."Bank Account No.");
//                     if CheckLedgerEntry.FINDFIRST then begin
//                         CheckNo := CheckLedgerEntry."Check No.";
//                     end;
//                 end;

//                 if CheckNo = '' then begin
//                     if VendLedEntryRec."Payment Reference" <> '' then
//                         BankTransferId := VendLedEntryRec."Payment Reference"
//                     else
//                         BankTransferId := VendLedEntryRec."Document No.";
//                 end
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//         label(ReportHeaderlbl; ENU = 'Remittance Advice',
//                               ESP = 'AVISO DE PAGO',
//                               FRA = 'Avis de versement')
//         label(ReportH1Llbl; ENU = 'For the attention of:',
//                            ESP = 'Páguese a:',
//                            FRA = 'À l''attention de:')
//         label(ReportH2Rlbl; ENU = 'Payer Company',
//                            ESP = 'Empresa pagadora',
//                            FRA = 'Entreprise payeuse')
//         label(RequestedExeDatelbl; ENU = 'Requested Execution Date:',
//                                   ESP = 'Fecha de ejecución solicitada:',
//                                   FRA = 'Date d''exécution demandée:')
//         label(Amountlbl; ENU = 'Amount:',
//                         ESP = 'Monto:',
//                         FRA = 'Montant:')
//         label(Currencylbl; ENU = 'Currency:',
//                           ESP = 'Moneda:',
//                           FRA = 'Devise:')
//         label(InvoiceNumberlbl; ENU = 'Invoice Number',
//                                ESP = 'Factura',
//                                FRA = 'Numéro de facture')
//         label(InvoiceDatelbl; ENU = 'Invoice Date',
//                              ESP = 'Fecha',
//                              FRA = 'Date de la facture')
//         label(GrossAmtlbl; ENU = 'Gross Amount',
//                           ESP = 'Monto bruto',
//                           FRA = 'Montant Brut')
//         label(PaidAmtlbl; ENU = 'Paid Amount',
//                          ESP = 'Monto pagado',
//                          FRA = 'Montant Payé')
//         label(Discounttakenlbl; ENU = 'Discount Taken',
//                                ESP = 'Monto descontado',
//                                FRA = 'Remise Prise')
//         label(Curremcylbl; ENU = 'Currency',
//                           ESP = 'Moneda',
//                           FRA = 'Devise')
//         label(Totallbl; ENU = 'Total',
//                        ESP = 'Total',
//                        FRA = 'Le Total')
//         label(B1lbl; ENU = 'Dear Supplier,',
//                     ESP = 'Estimado proveedor,',
//                     FRA = 'Cher Fournisseur,')
//         label(B2lbl; ENU = 'We have settled the items below by cheque / bank transfer',
//                     ESP = 'Hemos liquidado los siguientes artículos mediante cheque/transferencia bancaria',
//                     FRA = 'Nous avons réglé les éléments ci-dessous par chèque/virement bancaire sous réserve des biens et services fournis')
//         label(B3lbl; ENU = 'subject to goods and services supplied, your cheque / bank transfer reference ID number are listed below.',
//                     ESP = 'Sujeto a los bienes y servicios suministrados, el número de identificación de referencia de su cheque/transferencia bancaria se detalla a continuación.',
//                     FRA = ', votre numéro d''identification de référence de chèque/virement bancaire est indiqué ci-dessous.')
//         label(B4lbl; ENU = 'Transfer Instructions have been sent to the bank and payment will be executed,as per the bank cut-off time.',
//                     ESP = 'Las instrucciones de transferencia se han enviado al banco y el pago se ejecutará según la hora límite del banco.',
//                     FRA = 'Les instructions de transfert ont été envoyées à la banque et le paiement sera exécuté, selon l''heure limite de la banque.')
//         label(B5lbl; ENU = 'Cheques are ready for collection or will be posted as per the Opco policy or agreement.',
//                     ESP = 'Los cheques están listos para su cobro o se publicarán según la política o el acuerdo de Opco.',
//                     FRA = 'Les chèques sont prêts à être collectés ou seront affichés conformément à la politique ou à l''accord d''Opco.')
//         label(B6lbl; ENU = 'You can contact us for information at the following contact details:-',
//                     ESP = 'Puede contactarnos para obtener información en los siguientes datos de contacto: -',
//                     FRA = 'Vous pouvez nous contacter pour plus d''informations aux coordonnées suivantes:-')
//         label(Emaillbl; ENU = 'Email:',
//                        ESP = 'Correo electrónico:',
//                        FRA = 'Email:')
//         label(Phonelbl; ENU = 'Phone:',
//                        ESP = 'Teléfono:',
//                        FRA = 'Téléphone:')
//         label(Chequeidlbl; ENU = 'Cheque ID',
//                           ESP = 'ID de Cheque',
//                           FRA = 'Cheque ID')
//         label(BankTransferIdlbl; ENU = 'Bank Transfer ID',
//                                 ESP = 'ID de Ref. Bancaria',
//                                 FRA = 'Bank Transfer ID')
//         label(WHTAmtlbl; ENU = 'WHT Amount',
//                         ESP = 'Monto retenido')
//     }

//     trigger OnPreReport();
//     begin
//         //HEI.04>>
//         if Vendor.GET(gVendNo) then begin
//             VendLanguage := Vendor."Language Code";
//             GenOpCoSetup.GET;
//             if (GenOpCoSetup."French Payment Remittance" = true) and (GenOpCoSetup."Payment Remittance Language" = VendLanguage) then begin
//                 // CurrReport.LANGUAGE := Language.GetLanguageID(VendLanguage); // BC Upgrade BHARDA11 :: Change Language to LanguageMgt
//                 CurrReport.LANGUAGE := LanguageMgt.GetLanguageID(VendLanguage);

//             end;

//             //HEI.08>>
//             CLEAR(DV64);
//             CLEAR(IsLanguageSpanish);
//             if (GenOpCoSetup."Spanish Payment Remittance" = true) and (GenOpCoSetup."Payment Remittance Language Sp" = VendLanguage) then begin
//                 CurrReport.LANGUAGE := LanguageMgt.GetLanguageID(VendLanguage); // BC Upgrade BHARDA11 :: Change Language to LanguageMgt
//                 IsLanguageSpanish := true;
//                 DV64 := 'DV 64';
//             end;
//             //HEI.08<<

//         end;
//         //HEI.04<<
//     end;

//     var
//         Vendor: Record Vendor;
//         SupplierName: Text;
//         Ven_AddressLine1: Text;
//         Ven_AddressLine2: Text;
//         Ven_PostCode: Code[500];
//         Ven_City: Code[500];
//         Ven_County: Code[500];
//         Ven_VatRegNum: Text[500];
//         VendorEmail: Text;
//         PayingCompCodeName: Text;
//         Comp_AddressLine1: Text;
//         Comp_AddressLine2: Text;
//         Comp_PostCode: Code[500];
//         Comp_City: Code[500];
//         Comp_County: Code[500];
//         Comp_VatRegNum: Text;
//         CompanyInformation: Record "Company Information";
//         CountryRegion: Record "Country/Region";
//         CurrencyCode: Code[20];
//         GeneralLedgerSetup: Record "General Ledger Setup";
//         Comp_Email: Text[500];
//         Comp_Phone: Text[500];
//         ParentGNJNL: Record "Gen. Journal Line" temporary;
//         VendorLedgerEntry: Record "Vendor Ledger Entry";
//         RemainingAmt: Decimal;
//         BankTransferId: Code[50];
//         CheckNo: Code[50];
//         TempGnJNL: Record "Gen. Journal Line";
//         GenJournalLine: Record "Gen. Journal Line";
//         VLEExtrnlDoc: Code[50];
//         ChaildPaidAmount: Decimal;
//         PParentGNJNL: Record "Gen. Journal Line" temporary;
//         DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
//         DetailedVendorLedgEntry1: Record "Detailed Vendor Ledg. Entry";
//         EntriesFound: Integer;
//         GrosAMTVLE: Decimal;
//         WHTAmount: Decimal;
//         BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
//         CheckLedgerEntry: Record "Check Ledger Entry";
//         VendLedEntryRec: Record "Vendor Ledger Entry";
//         WHTEntryRec: Record "WHT Entry";
//         ParentVLE: Record "Vendor Ledger Entry" temporary;
//         LanguageMgt: Codeunit Language; // BC Upgrade BHARDA11 ----Change Language to ManguageMgt and Record to codeunit
//         gVendNo: Code[20];
//         VendLanguage: Code[10];
//         GenOpCoSetup: Record "General OpCo Setup";
//         CreateVendLedgEntry: Record "Vendor Ledger Entry";
//         VLEDocNo: Code[20];
//         DVLEDocNo: Code[20];
//         VLEntry: Record "Vendor Ledger Entry";
//         WHTPostingSetup: Record "WHT Posting Setup";
//         CalculatePaidAmount: Boolean;
//         IsLanguageSpanish: Boolean;
//         PostingDate: Date;
//         DV64: Text;

//     local procedure SendReportAsEmailPDF();
//     begin
//     end;

//     procedure SetFilterGNL(var RecGNJL: Record "Gen. Journal Line" temporary);
//     begin
//         ParentGNJNL.DELETEALL;
//         if RecGNJL.FINDSET then begin
//             repeat
//                 ParentGNJNL.INIT;
//                 ParentGNJNL.COPY(RecGNJL);
//                 ParentGNJNL.INSERT;
//             until RecGNJL.NEXT = 0;
//         end;
//         COMMIT;
//     end;

//     procedure SetFilterVLE(var RecVLE: Record "Vendor Ledger Entry" temporary);
//     begin
//         ParentVLE.DELETEALL;
//         if RecVLE.FINDSET then begin
//             repeat
//                 ParentVLE.INIT;
//                 ParentVLE.COPY(RecVLE);
//                 ParentVLE.INSERT;
//             until RecVLE.NEXT = 0;
//         end;
//         MESSAGE('%1', ParentVLE.COUNT);
//         COMMIT;
//     end;

//     procedure GetVendNoFromVLE(VendorNo: Code[20]);
//     begin
//         //HEI.04>>
//         gVendNo := VendorNo;
//         //HEI.04<<
//     end;

//     local procedure FindApplnEntriesDtldtLedgEntry();
//     var
//         DtldVendLedgEntry1: Record "Detailed Vendor Ledg. Entry";
//         DtldVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
//     begin
//         //HEI.07>>
//         // //HEI.05>>
//         // DtldVendLedgEntry1.SETCURRENTKEY("Vendor Ledger Entry No.");
//         // DtldVendLedgEntry1.SETRANGE("Vendor Ledger Entry No.",CreateVendLedgEntry."Entry No.");
//         // DtldVendLedgEntry1.SETRANGE(Unapplied,FALSE);
//         // //IF DtldVendLedgEntry1.FIND('-') THEN REPEAT
//         // IF DtldVendLedgEntry1.FINDSET(FALSE,FALSE) THEN REPEAT
//         //  IF DtldVendLedgEntry1."Vendor Ledger Entry No." = DtldVendLedgEntry1."Applied Vend. Ledger Entry No." THEN BEGIN
//         //    DtldVendLedgEntry2.INIT;
//         //    DtldVendLedgEntry2.SETCURRENTKEY("Applied Vend. Ledger Entry No.","Entry Type");
//         //    DtldVendLedgEntry2.SETRANGE("Applied Vend. Ledger Entry No.",DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
//         //    DtldVendLedgEntry2.SETRANGE("Entry Type",DtldVendLedgEntry2."Entry Type"::Application);
//         //    DtldVendLedgEntry2.SETRANGE(Unapplied,FALSE);
//         //    //IF DtldVendLedgEntry2.FIND('-') THEN REPEAT
//         //    IF DtldVendLedgEntry2.FINDSET(FALSE,FALSE) THEN REPEAT
//         //      IF DtldVendLedgEntry2."Vendor Ledger Entry No." <> DtldVendLedgEntry2."Applied Vend. Ledger Entry No." THEN BEGIN
//         //        //VendLedEntryRec.SETCURRENTKEY("Entry No.");//Changed
//         //        VendLedEntryRec.SETRANGE("Entry No.",DtldVendLedgEntry2."Vendor Ledger Entry No.");//Changed
//         //        //IF VendLedEntryRec.FIND('-') THEN //Changed
//         //        IF VendLedEntryRec.FINDSET(FALSE,FALSE) THEN //Changed
//         //          VendLedEntryRec.MARK(TRUE); //Changed
//         //      END;
//         //    UNTIL DtldVendLedgEntry2.NEXT = 0;
//         //  END ELSE BEGIN
//         //    //VendLedEntryRec.SETCURRENTKEY("Entry No.");//changed
//         //    VendLedEntryRec.SETRANGE("Entry No.",DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");//Changed
//         //    //IF VendLedEntryRec.FIND('-') THEN //Changed
//         //    IF VendLedEntryRec.FINDSET(FALSE,FALSE) THEN //Changed
//         //      VendLedEntryRec.MARK(TRUE); //Changed
//         //  END;
//         // UNTIL DtldVendLedgEntry1.NEXT = 0;
//         // //HEI.05<<
//         //HEI.07<<
//     end;
// }

