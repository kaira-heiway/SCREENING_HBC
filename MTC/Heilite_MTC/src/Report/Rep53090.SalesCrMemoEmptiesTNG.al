report 53090 "Sales Cr. Memo Empties TNG"
{
    // version HEI.08

    // HEI.01 FDD-AL-OTCGAP01a IBM HORTOC01 29.09.2017
    //   # New report
    // 
    // HEI.02 FDD-KDD0TC005 IBM NASTAA02 9.11.2017 # RPM Billing and Reporting
    //   # New groupping added on "RPM Type"
    // 
    // HEI.03 Bugfixing IBM NASTAA02 20.11.2017 # Local Algeria
    //   # Used fields "Registre de Commerce","Article d'imposition","N.I.S." from Customer Attributes table
    //   # Replaced Responsibility Center Information with Company Information
    //   # Replaced CustAddr with data from Customer
    // BASE FCE01- 30.01.2018 FCe   Changed the Laguage value
    // 
    // HEI.04 Defect #1462 IBM NASTAA02 07.02.2018 # Printing multiple Reports
    //   # Adjusted code to print multiple empty invoices
    //   # Adjusted layout to print different headers
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
    // HEI.08 Defect #1396 IBM NASTAA02 03.04.2018 # Credit Memo
    //   # Removed Payment terms from layout
    // 
    // HEI.13 Defect #1396 IBM NASTAA02 03.04.2018 # Credit Memo
    //   # Removed Payment Method from layout
    // 
    // HEI.14 INC3151985 - CHG2086115 IBM NASTAA02 05.11.2020 # Sales invoice print wrong currency code
    //   # Code changed to use 'Currency Code' for Total and Subtotal Incl. / Excl. VAT
    //   # New TextConstants created
    //   # Used new Text Constant 'AmtPaidLbl' instead of 'lblAmtPaid' on layout

    // BC Upgrade KUMARS145 Nav ID Report 50039 "Sales Cr. Memo Empties TNG"

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Sales Cr. Memo Empties TNG.rdl';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(SalesHDocNo; "Sales Cr.Memo Header"."No.") { }
            column(Customer_NRC; CustomerAttributes."Registre de Commerce") { }
            column(Customer_NART; CustomerAttributes."Article d'imposition") { }
            column(Customer_NIF; Customer."VAT Registration No.") { }
            // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field......>>
            // column(Customer_NIS; Customer."Tax Registration No.") { } 
            column(Customer_NIS; '') { }
            // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field....<<
            column(CurrentTime; TIME) { }
            column(No_SalesHeader; "No.") { }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(ReprintedText; ReprintedText) { }
                    column(OrderConfirmCopyCaption; DocumentTitleText) { }
                    column(SalesHCustNo; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SalesHPostDate; FORMAT("Sales Cr.Memo Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDueDate; FORMAT("Sales Cr.Memo Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDocDate; FORMAT("Sales Cr.Memo Header"."Document Date", 0, 4)) { }
                    column(SalesHIncVAT; PriceIncVAT) { }
                    column(SalesHSalesPerName; SalesPerson.Name) { }
                    column(OutputNo; OutputNo) { }
                    column(SalesHOrdNo; "Sales Cr.Memo Header"."Return Order No.") { }
                    column(SalesHReference; "Sales Cr.Memo Header"."Your Reference") { }
                    column(SalesHExtRefNo; "Sales Cr.Memo Header"."External Document No.") { }
                    column(SalesHVATRegNo; "Sales Cr.Memo Header"."VAT Registration No.")
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
                    // BC Upgrade KUMARS145 Replaced as the field it was depended on Drikit Field.......>>
                    // column(CompanyInfo_NIS; CompanyInfo."Tax Registration No.") { }
                    column(CompanyInfo_NIS; CompanyInfo."VAT Registration No.") { }
                    // BC Upgrade KUMARS145 Replaced as the field it was depended on Drikit Field......<<
                    column(CompanyInfo_NRC; CompanyNRC) { }
                    column(CompanyInfo_Address; CompanyAddress) { }
                    column(CompanyInfo_Address2; CompanyAddress2) { }
                    column(CompanyInfo_City; CompanyCity) { }
                    column(CompanyInfo_Email; CompanyEmail) { }
                    column(Customer_Name; Customer.Name) { }
                    column(Customer_Name2; Customer."Name 2") { }
                    column(Customer_Address; Customer.Address) { }
                    column(Customer_City; Customer.City) { }
                    column(Customer_Country; Country.Name) { }
                    column(CompanyInfo_CapSocial; CompanyInfo."Cap. Social FND") { }
                    column(CompanyInfo__PhoneNo; CompanyInfo."Phone No.") { }
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
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        // BC Upgrade KUMARS145 chnaged the code it was dependent on Deinkit......>>
                        // DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER('"Charge (Item)"'), "Item Charge Type" = FILTER(Deposit));
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER('"Charge (Item)"'));// , "Item Charge Type" = FILTER(Deposit));
                        // BC Upgrade KUMARS145 chnaged the code it was dependent on Deinkit......<<
                        column(SalesLType; "Sales Cr.Memo Line".Type) { }
                        column(SalesItem; "Sales Cr.Memo Line"."No.")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesDescrip; "Sales Cr.Memo Line".Description)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesQty; "Sales Cr.Memo Line".Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesUOM; "Sales Cr.Memo Line"."Unit of Measure Code") { }
                        column(SalesPrice; ROUND("Sales Cr.Memo Line"."Unit Price", 0.01, '=')) { }
                        column(SalesVATPer; "Sales Cr.Memo Line"."VAT %")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesDisAmt; "Sales Cr.Memo Line"."Line Discount Amount") { }
                        column(SalesAmount; ROUND(("Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Price") - "Sales Cr.Memo Line"."Line Discount Amount", 0.01, '=')) { }
                        column(TotalQuantity; TotalQty) { }
                        column(RPMType; RPMType) { }
                        column(RPMTypeNotBlank; RPMType <> '') { }
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

                            //HEI.02>>
                            if PrintPerRPMType and (Type = Type::Item) and Item.GET("No.") then
                                RPMType := Item."RPM Type FND";
                            //HEI.02>>
                        end;
                    }
                    // BC Upgrade KUMARS145 dataitem was commented as it was dependent on Drinkit Table....>>
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
                    //         SETRANGE("Last Post. Document Type", "Last Post. Document Type"::"Sales Credit Memo");
                    //         SETRANGE("Last Post. Document No.", "Sales Cr.Memo Header"."No.");
                    //         if ISEMPTY then
                    //             CurrReport.BREAK();
                    //     end;
                    // }
                    // BC Upgrade KUMARS145 dataitem was commented as it was dependent on Drinkit Table....<<

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
                        CLEAR(AmountLetter);

                        DocumentTitleText := STRSUBSTNO(Text57001, CopyText);

                        SalesInvLineAmt.RESET();
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        SalesInvLineAmt.SETRANGE(Type, SalesInvLineAmt.Type::Item);
                        // SalesInvLineAmt.SETRANGE(Type, SalesInvLineAmt."Item Charge Type"::Deposit); // BC Upgrade KUMARS145 Code comented as it was dependent on Drinkit.
                        // SalesInvLineAmt.SETFILTER("Item Charge Type", '%1', SalesInvLineAmt."Item Charge Type"::Deposit); // BC Upgrade KUMARS145 Code comented as it was dependent on Drinkit.

                        if SalesInvLineAmt.FINDSET() then
                            repeat
                                InvLineTotal += SalesInvLineAmt."Line Amount";
                            until SalesInvLineAmt.NEXT() = 0;

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        // SalesInvLine.SETFILTER("Item Charge Type", '%1', SalesInvLine."Item Charge Type"::Deposit);// BC Upgrade KUMARS145 Code comented as it was dependent on Drinkit.

                        TotalFooterAmountText[2] := Text57004;
                        TotalFooterAmountText[3] := Text57005;

                        if SalesInvLine.FINDSET() then
                            repeat
                                if SalesInvLine."Line Amount" > 0 then
                                    TotalFooterAmount[2] += SalesInvLine."Line Amount"
                                else if SalesInvLine."Line Amount" < 0 then
                                    TotalFooterAmount[3] += SalesInvLine."Line Amount";
                            until SalesInvLine.NEXT() = 0;

                        DepAmountP := TotalFooterAmount[2];
                        DepAmountN := TotalFooterAmount[3];

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        // SalesInvLine.SETFILTER("Item Charge Type", '%1', SalesInvLine."Item Charge Type"::Deposit);// BC Upgrade KUMARS145 Code comented as it was dependent on Drinkit.
                        if SalesInvLine.FINDSET() then
                            repeat
                                TotalFooterAmount[5] += SalesInvLine."Inv. Discount Amount";
                                TotalFooterAmountText[5] := SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                                TotalFooterAmount[6] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[6] := SalesInvLine.FIELDCAPTION("Line Discount Amount");
                            until SalesInvLine.NEXT() = 0;

                        InvDisAmount := TotalFooterAmount[5];
                        LineDisAmount := TotalFooterAmount[6];

                        AmttoPaid := InvLineTotal + DepAmountP - DepAmountN - LineDisAmount;
                        InvTotalAmount := AmttoPaid - InvDisAmount;

                        //HeinekenGlobal.AmountInLetter(AmountLetter,ROUND(InvTotalAmount,0.01,'='));

                        //HEI.01>>
                        //MontantToutLettre."Montant en texte1"(AmountLetters,ROUND(InvTotalAmount,0.01,'=')); //old
                        if lang = 1033 then begin
                            RepCheck.InitTextVariable();
                            if "Sales Cr.Memo Header"."Currency Code" = '' then
                                RepCheck.FormatNoText(AmountLetters, ROUND(InvTotalAmount, 0.01, '='), '')
                            else
                                RepCheck.FormatNoText(AmountLetters, InvTotalAmount, '');
                            AmountLetter := AmountLetters[1] + AmountLetters[2];
                        end else
                            if lang = 1036 then //begin
                                if "Sales Cr.Memo Header"."Currency Code" = '' then
                                    MontantToutLettre."Montant en texte1"(AmountLetter, ROUND(InvTotalAmount, 0.01, '='))
                                else begin
                                    //HEI.15>>
                                    //MontantToutLettre."Montant en texte1"(AmountLetter,InvTotalAmount);
                                    MontantToutLettre.SetCurrencyCode("Sales Cr.Memo Header"."Currency Code");
                                    MontantToutLettre."Montant en texte1"(AmountLetter, ROUND(InvTotalAmount, 0.01, '='));
                                end;
                        //HEI.15<<
                        // end;
                        //HEI.01<<
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then
                        CopyText := Text52000;
                    CurrReport.PAGENO := 1;
                    OutputNo := OutputNo + 1;

                    //HEI.01>>
                    if "Sales Cr.Memo Header"."No. Printed" > 0 then
                        ReprintedText := Reprintedlbl;
                    //HEI.01<<
                end;

                trigger OnPostDataItem();
                begin
                    if not CurrReport.PREVIEW then
                        SalesCrMemoCountPrinted.RUN("Sales Cr.Memo Header");
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies);
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;

                    CopyText := '';
                    ReprintedText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                //HEI.01>>
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code"); //old
                lang := GetLanguageID(FORMAT(PrintLanguage)); // BASe FCE
                CurrReport.LANGUAGE := lang;
                GLOBALLANGUAGE(lang);
                //HEI.01<<

                if Location.GET("Location Code") then; //HEI.06

                if CustomerAttributes.GET("Sales Cr.Memo Header"."Sell-to Customer No.") then;
                Customer.GET("Sales Cr.Memo Header"."Sell-to Customer No.");
                if "Sales Cr.Memo Header"."Bill-to Customer No." <> '' then begin
                    Customer.GET("Sales Cr.Memo Header"."Bill-to Customer No.");
                    CustomerAttributes.GET("Sales Cr.Memo Header"."Bill-to Customer No.");
                end;
                if RespCenter.GET("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);


                //RFC432>>
                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                SalesInvLine.SETFILTER("Location Code", '<>%1', '');
                if not SalesInvLine.FINDFIRST() then begin
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
                HeinekenGlobal.CustomerAddressFormat(Customer, CustAddr);
                //FormatAddr.SalesCrMemoBillTo(CustAddr,"Sales Cr.Memo Header");

                if PaymentMethod.GET("Sales Cr.Memo Header"."Payment Method Code") then;

                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Cr.Memo Header"."Language Code");

                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalExText := STRSUBSTNO(Text52001, GLSetup."LCY Code");
                    TotalInText := STRSUBSTNO(Text52002, GLSetup."LCY Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := STRSUBSTNO(Text52005, GLSetup."LCY Code");
                    AmtPaid := STRSUBSTNO(AmtPaidLbl, 'DA'); //HEI.14
                end else begin
                    //HEI.14>>
                    //TotalExText := STRSUBSTNO(Text52001,"Currency Code");
                    //TotalInText := STRSUBSTNO(Text52002,"Currency Code");
                    //SubTotalInText := STRSUBSTNO(Text52005B,GLSetup."LCY Code");
                    //SubTotalExText := STRSUBSTNO(Text52005,GLSetup."LCY Code");
                    TotalExText := STRSUBSTNO(TotalExclVatLbl, "Currency Code");
                    TotalInText := STRSUBSTNO(TotalInclVATLbl, "Currency Code");
                    SubTotalInText := STRSUBSTNO(SubtotalInclVatLbl, "Currency Code");
                    SubTotalExText := STRSUBSTNO(SubtotalExcVatLbl, "Currency Code");
                    AmtPaid := STRSUBSTNO(AmtPaidLbl, "Currency Code");
                    //HEI.14<<
                end;

                if Customer.GET("Bill-to Customer No.") then
                    if Country.GET(Customer."Country/Region Code") then; //HEI.03

                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                // SalesInvLine.SETFILTER("Item Charge Type", '%1', SalesInvLine."Item Charge Type"::Deposit);// BC Upgrade KUMARS145 Code comented as it was dependent on Drinkit.
                if not SalesInvLine.FINDFIRST() then
                    CurrReport.QUIT();
            end;

            trigger OnPostDataItem();
            begin
                NUMLines := 20;
                LinesPrinted := 0;
            end;

            trigger OnPreDataItem();
            begin
                //SETRANGE("No.",SalesHeaderNo); //HEI.04
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
                    }
                    field(PrintPerRPMType; PrintPerRPMType)
                    {
                        ApplicationArea = all;
                        Caption = 'Print per RPM Type';
                    }
                    field(PrintLanguage; PrintLanguage)
                    {
                        ApplicationArea = all;
                        Caption = 'Printlanguage';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            ShowSplittedDeposit := true;
        end;

        trigger OnOpenPage();
        begin
            RequestPageUsed := true;
        end;
    }

    labels
    {
        label(lblPayTerms; ENU = 'Payment Terms',
                          FRA = 'Conditions Paiement')
        label(lblPayMethod; ENU = 'Payment Method',
                           FRA = 'Mode de réglement')
        label(lblAmtPaid; ENU = 'Total DA Excl. VAT',
                         FRA = 'Total DA HT')
        lblTotalQty = 'Total Quantity'; label(lblSalesPerson; ENU = 'Sales Person',
                                                            FRA = 'Vendeur')
        label(lblUOM; ENU = 'Unit',
                     FRA = 'Unité')
        label(lblUnitPrice; ENU = 'Unit Price',
                           FRA = 'Prix Unité')
        label(lblSaleLAmt; ENU = 'Amount',
                          FRA = 'Montant')
        label(lblPageNo; ENU = 'Page No.',
                        FRA = 'Page')
        label(lblInvoiceNo; ENU = 'Credit Memo No.',
                           FRA = 'N° Avoir')
        label(lblVATAmt; ENU = 'VAT Amount',
                        FRA = 'Montant TVA')
        label(lblPostDate; ENU = 'Date',
                          FRA = 'Date')
        label(lblDiscAmt; ENU = 'Disc. Amount',
                         FRA = 'Remise Montant')
        lblPriceIncVAT = 'Price Including VAT'; label(lblRegNo; ENU = 'RC No. :',
                                                              FRA = 'N° RC :')
        label(lblIfNo; ENU = 'I.F No. :',
                      FRA = 'N° I.F :')
        label(lblArticleNo; ENU = 'Item No. :',
                           FRA = 'N° ART :')
        label(lblPhone; ENU = 'Phone No. :',
                       FRA = 'Téléphone :')
        label(lblFax; ENU = 'Fax No. :',
                     FRA = 'N°  Télécopie :')
        label(lblAmtinWord; ENU = 'Amount in Words :',
                           FRA = 'La présente avoir est arrêtée à la somme de :')
        label(lblNIS; ENU = 'N.I.S.',
                     FRA = 'N.I.S.')
        label(lblOrder; ENU = 'Return Order No.',
                       FRA = 'N° Retour')
        label(lblTime; ENU = 'Time',
                      FRA = 'Temps')
        RPMTypeLbl = 'RPM Type:'; TotalLbl = 'Total'; lblCapSocial = 'Cap. Social :'; label(lblCompanyBankInfo; ENU = 'Bank information :',
                                                                                                            FRA = 'Référence Bancaire : ')
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture); //HEI.05
        SalesSetup.GET();
        // BASE FCE01-
        PrintLanguage := CompanyInfo."Language Code FND";
        // BASe FCE01+
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
        SalesInvLine: Record "Sales Cr.Memo Line";
        SalesInvLineAmt: Record "Sales Cr.Memo Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        Item: Record Item;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SalesCrMemoCountPrinted: Codeunit "Sales Cr. Memo-Printed";
        HeinekenGlobal: Codeunit "Heineken Global";
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
        Text52005B: TextConst ENU = 'Subtotal %1 Incl. VAT', FRA = 'Sous-Total %1 Incl. TVA';
        Text52006: TextConst ENU = 'CREDIT MEMO', FRA = 'AVOIR';
        TaxAmout: Decimal;
        VATAmount: Decimal;
        Text57000: TextConst ENU = 'CREDIT MEMO GOODS %1', FRA = 'AVOIR MARCHANDISES %1';
        Text57001: TextConst ENU = 'CREDIT MEMO EMPTIES %1', FRA = 'AVOIR EMBALLAGE %1';
        Text57002: TextConst ENU = 'Tax Charges TIC', FRA = 'Frais Taxes TIC';
        Text57003: TextConst ENU = 'Disc. Charges', FRA = 'Frais Remises';
        Text57004: TextConst ENU = 'Desposit Charges (+)', FRA = 'Frais consigne (+)';
        Text57005: TextConst ENU = 'Deposit Charges (-)', FRA = 'Frais Consigne (-)';
        Text57006: TextConst ENU = 'Transport Charges', FRA = 'Montant Transport';
        DepAmountP: Decimal;
        DepAmountN: Decimal;
        ShipAmount: Decimal;
        LineDisAmount: Decimal;
        InvDisAmount: Decimal;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        ShowSplittedDeposit: Boolean;
        ShowForcePrintNoDeposit: Boolean;
        SplitNo: Integer;
        RequestPageUsed: Boolean;
        SalesHeaderNo: Code[20];
        CustomerAttributes: Record "Customer Attributes FND";
        Reprintedlbl: Label 'REPRINTED';
        ReprintedText: Text;
        RPMType: Code[20];
        PrintPerRPMType: Boolean;
        RepCheck: Report Check;
        lang: Integer;
        AmountLetters: array[2] of Text[250];
        MontantToutLettre: Codeunit "Heicore_Funct CBN";
        PrintLanguage: Code[10];
        Location: Record Location;
        BankInformationLbl: TextConst ENU = 'Bank Information', FRA = 'Réferences Bancaires';
        PhoneNoLbl: TextConst ENU = 'Phone No.', FRA = 'N° Téléphone';
        CompanyAddress: Text;
        CompanyAddress2: Text;
        CompanyCity: Text;
        CompanyPhoneNo: Code[30];
        CompanyEmail: Text;
        LocationAddr: Record Location;
        CompanyNRC: Text;
        TotalExclVatLbl: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 sans TIC';
        TotalInclVATLbl: TextConst ENU = 'Total %1 Incl. VAT', FRA = 'Total %1 TTC';
        SubtotalExcVatLbl: TextConst ENU = 'Subtotal %1 Excl. VAT', FRA = 'Total %1 sans TIC';
        SubtotalInclVatLbl: TextConst ENU = 'Subtotal % Incl. VAT', FRA = 'Total %1';
        AmtPaid: Text;
        AmtPaidLbl: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 HT';

    procedure GetVars(InvoiceNo: Code[20]; Copies: Integer);
    begin
        SalesHeaderNo := InvoiceNo;
        NoOfCopies := Copies;
    end;

    local procedure GetLanguageID(CodePar: Text): Integer
    var
        LanguageRecLocal: Record Language;
    begin
        if LanguageRecLocal.Get(CodePar) then
            exit(LanguageRecLocal."Windows Language ID");
        exit(0);
    end;
}

