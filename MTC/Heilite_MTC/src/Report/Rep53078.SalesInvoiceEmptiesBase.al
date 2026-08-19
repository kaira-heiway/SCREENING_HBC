report 53078 "Sales Invoice Empties Base"
{
    // version HEI.07

    // HEI.01 FDD-GAPLOG006 IBM ISYED01 29.09.2017 # Algerai Local
    // # Imported  from HEI2.0 and added Reprint to Fotter
    // 
    // HEI.02 Bugfixing IBM NASTAA02 20.11.2017 # Local Algeria
    //   # Used fields "Registre de Commerce","Article d'imposition","N.I.S." from Customer Attributes table
    //   # Replaced Responsibility Center Information with Company Information
    //   # Replaced CustAddr with data from Customer
    //   # Layout improvements
    // 
    // FCE01  Only print Reprinted when the No printed >1 since it is already at 1 after printing the Fulls
    // BASE02 Set a language Code from the Sales Invoice
    // 
    // HEI.03 Defect #1462 IBM NASTAA02 07.02.2018 # Printing multiple Reports
    //   # Adjusted code to print multiple empty invoices
    // 
    // HEI.04 Bugfixing IBM NASTAA02 21.02.2018 # Local Algeria
    //   # Changed Layout to print the correct Header
    // 
    // HEI.05 Bugfixing IBM NASTAA02 23.02.2018 # Local Algeria
    //   # Used "Tax Registration" instead of "N.I.S." for Customer NIS
    //   # Added Company NIS: "Tax Registration" and Company NRC: "Industrtial Classification"
    // 
    // HEI.06 Bugfixing IBM NASTAA02 13.03.2018 # Bugfixing Algeria
    //   # Used "Home Page" from locations to fill in the Registre of Commerce in the Company info
    // 
    // HEI.07 Bugfixing IBM NASTAA02 15.03.2018 # Bugfixing Algeria
    //   # Added Phone No and Bank Information for Company
    //   # Moved Amount in Letter lower
    //   # Changed margins
    // 
    // HEI.08 INC3151985 - CHG2086115 IBM NASTAA02 05.11.2020 # Sales invoice print wrong currency code
    //   # Code changed to use 'Currency Code' for Total and Subtotal Incl. / Excl. VAT
    //   # New TextConstants created
    //   # Used new Text Constant 'AmtPaidLbl' instead of 'lblAmtPaid' on layout

    // BC Upgrade KUMARS145 Nav ID Report 50041 "Sales Invoice Empties Base"

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Sales Invoice Empties Base.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(SalesHDocNo; "Sales Invoice Header"."No.") { }
            column(Customer_NRC; CustomerAttributes."Registre de Commerce") { }
            column(Customer_NART; CustomerAttributes."Article d'imposition") { }
            column(Customer_NIF; Customer."VAT Registration No.") { }
            // BC Upgrade KUMARS145 Drinkit field commented......>>
            // column(Customer_NIS; Customer."Tax Registration No."){}
            column(Customer_NIS; '') { }
            // BC Upgrade KUMARS145 Drinkit field commented......<<
            column(SalesInvoiceHeader_NoPrinted; "No. Printed") { }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(OrderConfirmCopyCaption; DocumentTitleText) { }
                    column(SalesHCustNo; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SalesHPostDate; FORMAT("Sales Invoice Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDueDate; FORMAT("Sales Invoice Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDocDate; FORMAT("Sales Invoice Header"."Document Date", 0, 4)) { }
                    column(SalesHIncVAT; PriceIncVAT) { }
                    column(SalesHSalesPerName; SalesPerson.Name) { }
                    column(OutputNo; OutputNo) { }
                    column(SalesHOrdNo; "Sales Invoice Header"."Order No.") { }
                    column(SalesHReference; "Sales Invoice Header"."Your Reference") { }
                    column(SalesHExtRefNo; "Sales Invoice Header"."External Document No.") { }
                    column(SalesHVATRegNo; "Sales Invoice Header"."VAT Registration No.")
                    {
                        IncludeCaption = true;
                    }
                    column(PaymentTermDescrip; PaymentTerms.Description) { }
                    column(PayMethodDescrip; PaymentMethod.Description) { }
                    column(CompanyInfo_Picture; CompanyInfo.Picture) { }
                    column(CompanyInfo_Name; CompanyInfo.Name) { }
                    column(CompanyInfo_Name2; CompanyInfo."Name 2") { }
                    column(CompanyInfo_NIF; CompanyInfo."VAT Registration No.") { }
                    column(CompanyInfo_NART; CompanyInfo."Telex Answer Back") { }
                    // BC Upgrade KUMARS145 Drinkit field commented......>>
                    // column(CompanyInfo_NIS; CompanyInfo."Tax Registration No.") { }
                    column(CompanyInfo_NIS; '') { }
                    // BC Upgrade KUMARS145 Drinkit field commented......<<
                    column(CompanyInfo_NRC; CompanyNRC) { }
                    column(CompanyInfo_Address; CompanyAddress) { }
                    column(CompanyInfo_Address2; CompanyAddress2) { }
                    column(CompanyInfo_City; CompanyCity) { }
                    column(CompanyInfo_Email; CompanyEmail) { }
                    column(CompanyInfo_CapSocial; CompanyInfo."Cap. Social FND") { }
                    column(Customer_Name; Customer.Name) { }
                    column(Customer_Name2; Customer."Name 2") { }
                    column(Customer_Address; Customer.Address) { }
                    column(Customer_City; Customer.City) { }
                    column(Customer_Country; Country.Name) { }
                    column(Customer_HouseNo; CustomerAttributes."House No. 1") { }
                    column(SubTotal; ROUND(InvLineTotal, 0.01, '=')) { }
                    column(VATAmount; VATAmount) { }
                    column(TotalIncText; TotalInText) { }
                    column(SubTotalExcText; SubTotalExText) { }
                    column(TaxAmount; TaxAmout) { }
                    column(TaxAmtCaption; TotalFooterAmountText[1]) { }
                    column(DepositAmountP; DepAmountP) { }
                    column(DepositAmtCaptionP; TotalFooterAmountText[2]) { }
                    column(DepositAmountN; DepAmountN) { }
                    column(DepositAmtCaptionN; TotalFooterAmountText[3]) { }
                    column(ShippingAmount; ShipAmount) { }
                    column(ShippingAmtCaption; TotalFooterAmountText[4]) { }
                    column(InvDiscountAmt; InvDisAmount) { }
                    column(InvDiscCaption; TotalFooterAmountText[5]) { }
                    column(LineDiscountAmt; LineDisAmount) { }
                    column(LineDiscCaption; TotalFooterAmountText[6]) { }
                    column(AmountPaid; ROUND(AmttoPaid, 0.01, '=')) { }
                    column(InvTotalAmt; ROUND(InvTotalAmount, 0.01, '=')) { }
                    column(AmtLetter; AmountLetter) { }
                    column(Footertext; Footertext) { }
                    column(Text068; Text068) { }
                    column(CustAddr1; CustAddr[1]) { }
                    column(CustAddr2; CustAddr[2]) { }
                    column(CustAddr3; CustAddr[3]) { }
                    column(CustAddr4; CustAddr[4]) { }
                    column(BankInformationCaption; BankInformationLbl) { }
                    column(PhoneNoCaption; PhoneNoLbl) { }
                    column(CompanyInfo_PhoneNo; CompanyPhoneNo) { }
                    column(CompanyInfo_BankName; CompanyInfo."Bank Name") { }
                    column(CompanyInfo_BankAccNo; CompanyInfo."Bank Account No.") { }
                    column(CompanyInfo_IBAN; CompanyInfo.IBAN) { }
                    column(CompanyInfo_BankNameCaption; CompanyInfo.FIELDCAPTION("Bank Name")) { }
                    column(CompanyInfo_BankAccNoCaption; CompanyInfo.FIELDCAPTION("Bank Account No.")) { }
                    column(CompanyInfo_IBANCaption; CompanyInfo.FIELDCAPTION(IBAN)) { }
                    column(AmtPaidLbl; AmtPaid) { }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        // BC Upgrade KUMARS145 Drinkit field commented......>>
                        // DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER('"Charge (Item)"'), "Item Charge Type" = FILTER(Deposit));
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER('"Charge (Item)"'));
                        // BC Upgrade KUMARS145 Drinkit field commented......<<
                        column(SalesLType; "Sales Invoice Line".Type) { }
                        column(SalesItem; "Sales Invoice Line"."No.")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesDescrip; "Sales Invoice Line".Description)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesQty; "Sales Invoice Line".Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesUOM; "Sales Invoice Line"."Unit of Measure Code") { }
                        column(SalesPrice; ROUND("Sales Invoice Line"."Unit Price", 0.01, '=')) { }
                        column(SalesVATPer; "Sales Invoice Line"."VAT %")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesDisAmt; "Sales Invoice Line"."Line Discount Amount") { }
                        column(SalesAmount; ROUND(("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price") - "Sales Invoice Line"."Line Discount Amount", 0.01, '=')) { }
                        column(TotalQuantity; TotalQty) { }
                        dataitem(BlankLine; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(BlankLine; NUMLines) { }

                            trigger OnPreDataItem();
                            begin
                                SETRANGE(Number, 1, NUMLines)
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;
                        end;
                    }
                    // BC Upgrade KUMARS145 Drinkit dependent Table commented......>>
                    // dataitem("Delayed Disc. & Promo. Line"; "Delayed Disc. & Promo. Line")
                    // {
                    //     DataItemTableView = SORTING("Sequence No.");
                    //     column(DDPNo; "Delayed Disc. & Promo. Line"."No.") { }
                    //     column(DDPDescrip; "Delayed Disc. & Promo. Line".Description) { }
                    //     column(DDPCreateQty; "Delayed Disc. & Promo. Line"."Created Quantity") { }
                    //     column(DDPUOM; "Delayed Disc. & Promo. Line"."Unit of Measure Code") { }
                    //     column(DDPUnitPrice; "Delayed Disc. & Promo. Line"."Unit Price") { }
                    //     column(DDPLineDis; "Delayed Disc. & Promo. Line"."Line Discount %") { }
                    //     column(DDPVATPer; "Delayed Disc. & Promo. Line"."VAT %") { }
                    //     column(DDPCreatedLineDiscAmt; "Delayed Disc. & Promo. Line"."Created Line Discount Amount") { }
                    //     column(DDPCreateLineAmt; "Delayed Disc. & Promo. Line"."Created Line Amount") { }

                    //     trigger OnPreDataItem();
                    //     begin
                    //         SETRANGE("Last Post. Document Type", "Last Post. Document Type"::"Sales Invoice");
                    //         SETRANGE("Last Post. Document No.", "Sales Invoice Header"."No.");
                    //         if ISEMPTY then
                    //             CurrReport.BREAK;
                    //     end;
                    // }
                    // BC Upgrade KUMARS145 Drinkit dependent Table commented......<<
                    trigger OnAfterGetRecord();
                    begin
                        CLEAR(TotalFooterAmount);
                        CLEAR(TotalFooterAmountText);
                        CLEAR(InvTotalAmount);
                        CLEAR(AmttoPaid);
                        CLEAR(ShipAmount);
                        CLEAR(DepAmountP);
                        CLEAR(DepAmountN);
                        CLEAR(ShipAmount);
                        CLEAR(InvDisAmount);
                        CLEAR(LineDisAmount);
                        CLEAR(InvLineTotal);
                        CLEAR(AmountLetter);

                        DocumentTitleText := STRSUBSTNO(Text57001, CopyText);

                        SalesInvLineAmt.Reset();
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLineAmt.SETRANGE(Type, SalesInvLineAmt.Type::Item);
                        // BC Upgrade KUMARS145 Drinkit dependent field commented......>>
                        // SalesInvLineAmt.SETRANGE(Type, SalesInvLineAmt."Item Charge Type"::Deposit);
                        // SalesInvLineAmt.SETFILTER("Item Charge Type", '%1', SalesInvLineAmt."Item Charge Type"::Deposit);
                        // BC Upgrade KUMARS145 Drinkit dependent field commented......<<

                        if SalesInvLineAmt.FindSet() then
                            repeat
                                InvLineTotal += SalesInvLineAmt."Line Amount";
                            until SalesInvLineAmt.Next() = 0;

                        SalesInvLine.Reset();
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        // BC Upgrade KUMARS145 Drinkit dependent field commented......>>
                        // SalesInvLine.SETFILTER("Item Charge Type", '%1', SalesInvLine."Item Charge Type"::Deposit);
                        // BC Upgrade KUMARS145 Drinkit dependent field commented......<<

                        TotalFooterAmountText[2] := Text57004;
                        TotalFooterAmountText[3] := Text57005;
                        if SalesInvLine.FindSet() then
                            repeat
                                if SalesInvLine."Line Amount" > 0 then
                                    TotalFooterAmount[2] += SalesInvLine."Line Amount"
                                else
                                    if SalesInvLine."Line Amount" < 0 then
                                        TotalFooterAmount[3] += SalesInvLine."Line Amount";
                            until SalesInvLine.Next() = 0;

                        DepAmountP := TotalFooterAmount[2];
                        DepAmountN := TotalFooterAmount[3];

                        SalesInvLine.Reset();
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        // BC Upgrade KUMARS145 Drinkit dependent field commented......>>
                        // SalesInvLine.SETFILTER("Item Charge Type", '%1', SalesInvLine."Item Charge Type"::Deposit);
                        // BC Upgrade KUMARS145 Drinkit dependent field commented......<<
                        if SalesInvLine.FindSet() then
                            repeat
                                TotalFooterAmount[5] += SalesInvLine."Inv. Discount Amount";
                                TotalFooterAmountText[5] := SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                                TotalFooterAmount[6] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[6] := SalesInvLine.FIELDCAPTION("Line Discount Amount");
                            until SalesInvLine.Next() = 0;

                        InvDisAmount := TotalFooterAmount[5];
                        LineDisAmount := TotalFooterAmount[6];

                        AmttoPaid := InvLineTotal + DepAmountP - DepAmountN - LineDisAmount;
                        InvTotalAmount := AmttoPaid - InvDisAmount;

                        //HEI.01>>
                        //MontantToutLettre."Montant en texte1"(AmountLetters,ROUND(InvTotalAmount,0.01,'=')); //old
                        //HEI.05>>
                        if "Sales Invoice Header"."Currency Code" = '' then
                            MontantToutLettre."Montant en texte1"(AmountLetter, ROUND(InvTotalAmount, 0.01, '='))
                        else begin
                            //HEI.08>>
                            //MontantToutLettre."Montant en texte1"(AmountLetter,InvTotalAmount);
                            MontantToutLettre.SetCurrencyCode("Sales Invoice Header"."Currency Code");
                            MontantToutLettre."Montant en texte1"(AmountLetter, ROUND(InvTotalAmount, 0.01, '='));
                        end;
                        //HEI.08<<

                        /*IF lang = 1033 THEN BEGIN
                          RepCheck.InitTextVariable;
                          IF "Sales Invoice Header"."Currency Code" = '' THEN
                            RepCheck.FormatNoText(AmountLetters,ROUND(InvTotalAmount,0.01,'='),'')
                          ELSE
                            RepCheck.FormatNoText(AmountLetters,InvTotalAmount,'');
                            AmountLetter := AmountLetters[1] + AmountLetters[2];
                        END
                        ELSE IF lang = 1036 THEN BEGIN
                          IF "Sales Invoice Header"."Currency Code" = '' THEN
                            MontantToutLettre."Montant en texte1"(AmountLetter,ROUND(InvTotalAmount,0.01,'='))
                          ELSE
                            MontantToutLettre."Montant en texte1"(AmountLetter,InvTotalAmount);
                        END;*/
                        //HEI.01<<
                        //HEI.05<<

                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then
                        CopyText := Text52000;
                    CurrReport.PAGENO := 1;
                    OutputNo := OutputNo + 1;

                    //HEI.01>>
                    if Number > 1 then // FCe added line
                        Footertext := 'REPRINTED'
                    //HEI.01<<
                end;

                trigger OnPostDataItem();
                begin
                    SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies);
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;

                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 0;

                    //HEI.01>>
                    if "Sales Invoice Header"."No. Printed" > 1 then // FCE since the Fulls are printed first
                        Footertext := 'REPRINTED';
                    //HEI.01<<
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if CustomerAttributes.GET("Bill-to Customer No.") then; //HEI.02
                if Location.GET("Location Code") then; //HEI.06
                //HEI.01>>
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code"); //old
                // BASE03-+lang := Language.GetLanguageID(FORMAT(GLOBALLANGUAGE));
                //CurrReport.LANGUAGE := lang;//commented by syed on 2/2/2018 since we are getting error on language id also same code is wrriten already in redataitem
                // BASE03-+GLOBALLANGUAGE(lang);
                //HEI.01<<

                if RespCenter.GET("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                end;

                //FormatAddr.SalesInvBillTo(CustAddr,"Sales Invoice Header");
                if "Sales Invoice Header"."Sell-to Customer No." <> '' then
                    Customer.GET("Sales Invoice Header"."Sell-to Customer No.");
                if "Sales Invoice Header"."Bill-to Customer No." <> '' then begin
                    Customer.GET("Sales Invoice Header"."Bill-to Customer No.");
                end;
                HeinekenGlobal.CustomerAddressFormat(Customer, CustAddr);
                //RFC432>>
                SalesInvLine.Reset();
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("Location Code", '<>%1', '');
                if not SalesInvLine.FindFirst() then begin
                    CompanyAddress := CompanyInfo.Address;
                    CompanyAddress2 := CompanyInfo."Address 2";
                    CompanyCity := CompanyInfo.City;
                    CompanyEmail := CompanyInfo."E-Mail";
                    CompanyPhoneNo := CompanyInfo."Phone No.";
                    CompanyNRC := CompanyInfo."Home Page";
                end else begin
                    LocationAddr.GET(SalesInvLine."Location Code");
                    CompanyAddress := LocationAddr.Address;
                    CompanyAddress2 := LocationAddr."Address 2";
                    CompanyCity := LocationAddr.City;
                    CompanyEmail := LocationAddr."E-Mail";
                    CompanyPhoneNo := LocationAddr."Phone No.";
                    CompanyNRC := LocationAddr."Home Page";
                end;
                //RFC432<<
                if PaymentMethod.GET("Sales Invoice Header"."Payment Method Code") then;

                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Invoice Header"."Language Code");

                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalExText := STRSUBSTNO(Text52001, GLSetup."LCY Code");
                    TotalInText := STRSUBSTNO(Text52002, GLSetup."LCY Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := STRSUBSTNO(Text52005, GLSetup."LCY Code");
                    AmtPaid := STRSUBSTNO(AmtPaidLbl, 'DA'); //HEI.08
                end else begin
                    //HEI.08>>
                    //TotalExText := STRSUBSTNO(Text52001,"Currency Code");
                    //TotalInText := STRSUBSTNO(Text52002,"Currency Code");
                    //SubTotalInText := STRSUBSTNO(Text52005B,GLSetup."LCY Code");
                    //SubTotalExText := STRSUBSTNO(Text52005,GLSetup."LCY Code");
                    TotalExText := STRSUBSTNO(TotalExclVatLbl, "Currency Code");
                    TotalInText := STRSUBSTNO(TotalInclVATLbl, "Currency Code");
                    SubTotalInText := STRSUBSTNO(SubtotalInclVatLbl, "Currency Code");
                    SubTotalExText := STRSUBSTNO(SubtotalExcVatLbl, "Currency Code");
                    AmtPaid := STRSUBSTNO(AmtPaidLbl, "Currency Code");
                    //HEI.08<<
                end;

                if Customer.GET("Bill-to Customer No.") then
                    if Country.GET(Customer."Country/Region Code") then; //HEI.02
                SalesInvLine.Reset();
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                // BC Upgrade KUMARS145 Drinkit dependent field commented......>>
                // SalesInvLine.SETFILTER("Item Charge Type", '%1', SalesInvLine."Item Charge Type"::Deposit);
                // BC Upgrade KUMARS145 Drinkit dependent field commented......>>
                if not SalesInvLine.FindFirst() then
                    CurrReport.Quit();
            end;

            trigger OnPostDataItem();
            begin
                NUMLines := 20;
                LinesPrinted := 0;
            end;

            trigger OnPreDataItem();
            begin
                //SETRANGE("No.",SalesHeaderNo); //HEI.03
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Sales Order")
                {
                    Caption = 'Sales Order';
                    field("No. of Copies"; NoOfCopies)
                    {
                        ApplicationArea = all;
                        Caption = 'No. of Copies';
                        ToolTip = 'No. of Copies';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        label(lblPayTerms; ENU = 'Payment Terms', FRA = 'Conditions de réglement')
        label(lblPayMethod; ENU = 'Payment Method', FRA = 'Mode de réglement')
        label(lblAmtPaid; ENU = 'Total DA Excl. VAT', FRA = 'Total DA HT')
        label(lblSalesCondition; ENU = 'The Sale Conditions on the back side', FRA = 'Conditions generales de vento ou envers')
        lblTotalQty = 'Total Quantity';
        label(lblSalesPerson; ENU = 'Sales Person', FRA = 'Vendeur')
        label(lblUOM; ENU = 'Unit', FRA = 'Unité')
        label(lblUnitPrice; ENU = 'Unit Price', FRA = 'Prix Unité')
        label(lblSaleLAmt; ENU = 'Amount', FRA = 'Montant')
        label(lblPageNo; ENU = 'Page No.', FRA = 'Page')
        label(lblInvoiceNo; ENU = 'Invoice No.', FRA = 'N° de facture')
        label(lblVATAmt; ENU = 'VAT Amount', FRA = 'Montant TVA')
        label(lblPostDate; ENU = 'Date', FRA = 'Date')
        label(lblDiscAmt; ENU = 'Disc. Amount', FRA = 'Remise Montant')
        lblPriceIncVAT = 'Price Including VAT';
        label(lblRegNo; ENU = 'RC No. :', FRA = 'N° RC :')
        label(lblIfNo; ENU = 'I.F No. :', FRA = 'N° I.F :')
        label(lblArticleNo; ENU = 'Item No. :', FRA = 'N° ART :')
        label(lblPhone; ENU = 'Phone No. :', FRA = 'Téléphone :')
        label(lblFax; ENU = 'Fax No. :', FRA = 'N°  Télécopie :')
        label(lblAmtinWord; ENU = 'Amount in Words :', FRA = 'La présente facture est arrêtée à la somme de :')
        label(lblNIS; ENU = 'N.I.S.', FRA = 'N.I.S.')
        label(lblOrder; ENU = 'Sales Order No.', FRA = 'N° Commande')
        lblCapSocial = 'Cap. Social';
    }

    trigger OnInitReport();
    begin
        GLSetup.Get();
        SalesSetup.Get();
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.Get();
        CompanyInfo.CALCFIELDS(Picture); //HEI.04
        //FCE-
        // BC Upgrade KUMARS145 Changed to assign new Language ID....>>
        // CurrReport.LANGUAGE := LanguageRec.GetLanguageID(CompanyInfo."Language Code");
        CurrReport.LANGUAGE := GetLanguageID(CompanyInfo."Language Code FND");
        // BC Upgrade KUMARS145 Changed to assign new Language ID....<<
        // FCE+
    end;

    var
        CompanyInfo: Record "Company Information";
        LanguageRec: Record Language;
        Country: Record "Country/Region";
        VATEntry: Record "VAT Entry";
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        Customer: Record Customer;
        SalesPerson: Record "Salesperson/Purchaser";
        RespCenter: Record "Responsibility Center";
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvLineAmt: Record "Sales Invoice Line";
        TempSalesInvoiceLineDeposit: Record "Sales Invoice Line" temporary;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        MontantToutLettre: Codeunit "Heicore_Funct CBN";
        AmountLetter: Text[250];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text;
        NoOfLoops: Integer;
        NoOfCopies: Integer;
        OutputNo: Integer;
        NUMLines: Integer;
        Text52000: TextConst ENU = 'COPY', FRA = 'COPIE';
        Text52001: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 HT';
        Text52002: TextConst ENU = 'Total %1 Incl. VAT', FRA = 'Total %1 TTC';
        Text52003: TextConst ENU = 'VAT @ %1 ', FRA = 'TVA @ %1';
        InvLineTotal: Decimal;
        VatAmt: Decimal;
        VATPer: Decimal;
        AmttoPaid: Decimal;
        InvTotalAmount: Decimal;
        ItemCharge: Option " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        PriceIncVAT: Text[10];
        CopyText: Text[10];
        TotalInText: Text[30];
        TotalExText: Text[30];
        SubTotalInText: Text[30];
        SubTotalExText: Text[30];
        VATPerText: Text[30];
        LinesPrinted: Integer;
        TotalQty: Decimal;
        TotalFooterAmount: array[6] of Decimal;
        TotalFooterAmountText: array[6] of Text[50];
        CustomerNo: Code[20];
        CustomerName: Text[50];
        CustomerAddress: Text[240];
        TotalDepositFooterAmountText: array[6] of Text[50];
        TotalDepositFooterAmount: array[6] of Decimal;
        DisplayTitleHeaderType: Option Confirmation,Proforma;
        DocumentTitleText: Text[30];
        Text52004: Label 'Order Confirmation %1';
        Text52005: TextConst ENU = 'Subtotal %1 Excl. VAT', FRA = 'Sous-Total %1 Excl. TVA';
        Text52005B: Label 'Subtotal %1 Incl. VAT';
        Text52006: TextConst ENU = 'INVOICE %1', FRA = 'FACTURE %1';
        TaxAmout: Decimal;
        VATAmount: Decimal;
        DepAmountP: Decimal;
        DepAmountN: Decimal;
        ShipAmount: Decimal;
        LineDisAmount: Decimal;
        Text57000: TextConst ENU = 'INVOICE GOODS %1', FRA = 'FACTURE MARCHANDISES %1';
        Text57001: TextConst ENU = 'INVOICE EMPTIES %1', FRA = 'FACTURE EMBALLAGE %1';
        Text57002: TextConst ENU = 'Tax Charges TIC', FRA = 'Frais Taxes TIC';
        Text57003: TextConst ENU = 'Disc. Charges', FRA = 'Frais Remises';
        Text57004: TextConst ENU = 'Desposit Charges (+)', FRA = 'Frais consigne (+)';
        Text57005: TextConst ENU = 'Deposit Charges (-)', FRA = 'Frais Consigne (-)';
        Text57006: TextConst ENU = 'Transport Charges', FRA = 'Montant Transport';
        InvDisAmount: Decimal;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        ShowSplittedDeposit: Boolean;
        ShowForcePrintNoDeposit: Boolean;
        SalesHeaderNo: Code[20];
        Footertext: Text;
        RepCheck: Report Check;
        AmountLetters: array[2] of Text[250];
        lang: Integer;
        CustomerAttributes: Record "Customer Attributes FND";
        Text068: Label 'REPRINTED';
        Location: Record Location;
        HeinekenGlobal: Codeunit "Heineken Global";
        BankInformationLbl: TextConst ENU = 'Bank Information', FRA = 'Réferences Bancaires';
        PhoneNoLbl: TextConst ENU = 'Phone No.', FRA = 'N° Téléphone';
        CompanyAddress: Text;
        CompanyAddress2: Text;
        CompanyCity: Text;
        CompanyPhoneNo: Code[20];
        CompanyEmail: Text;
        LocationAddr: Record Location;
        CompanyNRC: Text;
        TotalExclVatLbl: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 sans TIC';
        TotalInclVATLbl: TextConst ENU = 'Total %1 Incl. VAT', FRA = 'Total %1 TTC';
        SubtotalExcVatLbl: TextConst ENU = 'Subtotal %1 Excl. VAT', FRA = 'Total %1 sans TIC';
        SubtotalInclVatLbl: TextConst ENU = 'Subtotal % Incl. VAT', FRA = 'Total %1';
        AmtPaidLbl: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 HT';
        AmtPaid: Text;

    procedure GetVars(InvoiceNo: Code[20]; Copies: Integer);
    begin
        SalesHeaderNo := InvoiceNo;
        NoOfCopies := Copies;
    end;

    procedure SetLanguage(pCodeLanguage: Code[10]);
    begin
        // BC Upgrade KUMARS145 Changed to assign new Language ID....>>
        // CurrReport.LANGUAGE := LanguageRec.GetLanguageID(FORMAT(pCodeLanguage));
        CurrReport.LANGUAGE := GetLanguageID(FORMAT(pCodeLanguage));
        // BC Upgrade KUMARS145 Changed to assign new Language ID....<<
    end;

    local procedure GetLanguageID(LanguageCode: Code[10]): Integer
    var
        LanguageRecLocal: Record Language;
    begin
        if LanguageRecLocal.Get(LanguageCode) then
            exit(LanguageRecLocal."Windows Language ID")
        else
            exit(WindowsLanguage);
    end;
}

