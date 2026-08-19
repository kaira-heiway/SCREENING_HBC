report 51001 "Global Sales Invoice CBN"
{
    // version HEI.02

    // HEI:INC0259274:1:1 28/07/16 IBM.AV
    //   #Code Corrections to fix issues reported in INC0259274.
    // HEI:CHG0153013:1:1 14/12/16 IBM.AV
    //   #Code correction to include Fixed asset totalling in filter.
    // 
    // HEI:CHG0187935:1:1 24/08/17 IBM.SP
    //    # Code Correction against INC0523786.
    // 
    // HEI: FDD-GAPLOG006 IBM ISYED01 29.09.2017 # Algerai Local
    // # Imported  from HEI2.0 and added Reprint to Fotter
    // 
    // HEI.01 FDD-KDD0TC005 IBM NASTAA02 9.11.2017 # RPM Billing and Reporting
    //   # Copied Report 50040
    //   # New DataItem added on Sales Cr.Memo Line
    // 
    // HEI.02 Bugfixing IBM NASTAA02 20.11.2017 # Local Algeria
    //   # Used fields "Registre de Commerce","Article d'imposition","N.I.S." from Customer Attributes table
    //   # Replaced Responsibility Center Information with Company Information
    //   # Replaced CustAddr with data from Customer
    // BC Upgrade BHARAD11 >>
    // 1. Remove Drink-IT Fields ("Item Charge Type","Link Sales Document No.")
    // 2. Replace GetLanguageID with GetLanguageIdOrDefault.
    // 3. Add ApplicationArea Property in Report and fields. 
    // 4. Add layout Path.
    // BC Upgrade BHARDA11 <<
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Global Sales Invoice.rdl'; // BC Upgrade BHARDA11 ---Add Path and change extension rdlc to rdl
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(SalesHDocNo; "Sales Invoice Header"."No.")
            {
            }
            column(CustRC; CustomerAttributes."Registre de Commerce")
            {
            }
            column(CustVATNo; Customer."VAT Registration No.")
            {
            }
            column(CustTaxItem; CustomerAttributes."Article d'imposition")
            {
            }
            column(CustNIS; CustomerAttributes."N.I.S.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(OrderConfirmCopyCaption; DocumentTitleText)
                    {
                    }
                    column(InvDiscountAmtCaption; InvDiscountAmtCaptionLbl)
                    {
                    }
                    column(SubtotalCaption; SubtotalCaptionLbl)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(TotalExclVATText; TotalExclVATText)
                    {
                    }
                    column(TotalInclVATText; TotalInclVATText)
                    {
                    }
                    column(SalesHCustNo; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SalesHPostDate; FORMAT("Sales Invoice Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesHDueDate; FORMAT("Sales Invoice Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesHDocDate; FORMAT("Sales Invoice Header"."Document Date", 0, 4))
                    {
                    }
                    column(SalesHIncVAT; PriceIncVAT)
                    {
                    }
                    column(SalesHSalesPerName; SalesPerson.Name)
                    {
                    }
                    column(SalesHOrdNo; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(SalesHReference; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(SalesHExtRefNo; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(SalesHVATRegNo; "Sales Invoice Header"."VAT Registration No.")
                    {
                        IncludeCaption = true;
                    }
                    column(PaymentTermDescrip; PaymentTerms.Description)
                    {
                    }
                    column(PayMethodDescrip; PaymentMethod.Description)
                    {
                    }
                    column(CompanyInfo_Name; CompanyInfo.Name)
                    {
                    }
                    column(CompanyInfo_Name2; CompanyInfo."Name 2")
                    {
                    }
                    column(CompanyInfo_VATNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo_Telex; CompanyInfo."Telex Answer Back")
                    {
                    }
                    column(CompanyInfo_Address; CompanyInfo.Address)
                    {
                        IncludeCaption = true;
                    }
                    column(CompanyInfo_Address2; CompanyInfo."Address 2")
                    {
                    }
                    column(CompanyInfoCity; CompanyInfo.City)
                    {
                    }
                    column(CompanyInfo_Email; CompanyInfo."E-Mail")
                    {
                    }
                    column(Customer_Name; Customer.Name)
                    {
                    }
                    column(Customer_Name2; Customer."Name 2")
                    {
                    }
                    column(Customer_Address; Customer.Address)
                    {
                    }
                    column(Customer_City; Customer.City)
                    {
                    }
                    column(Customer_Country; Country.Name)
                    {
                    }
                    column(Customer_HouseNo; CustomerAttributes."House No. 1")
                    {
                    }
                    column(SubTotal; ROUND(InvLineTotal, 0.01, '='))
                    {
                    }
                    column(VATAmount; ROUND(VATAmount, 0.01, '='))
                    {
                    }
                    column(TotalIncText; TotalInText)
                    {
                    }
                    column(SubTotalExcText; SubTotalExText)
                    {
                    }
                    column(TaxAmount; TaxAmout)
                    {
                    }
                    column(TaxAmtCaption; TotalFooterAmountText[1])
                    {
                    }
                    column(DepositAmountP; DepAmountP)
                    {
                    }
                    column(DepositAmtCaptionP; TotalFooterAmountText[2])
                    {
                    }
                    column(DepositAmountN; DepAmountN)
                    {
                    }
                    column(DepositAmtCaptionN; TotalFooterAmountText[3])
                    {
                    }
                    column(ShippingAmount; ShipAmount)
                    {
                    }
                    column(ShippingAmtCaption; TotalFooterAmountText[4])
                    {
                    }
                    column(InvDiscountAmt; InvDisAmount)
                    {
                    }
                    column(InvDiscCaption; TotalFooterAmountText[5])
                    {
                    }
                    column(LineDiscountAmt; LineDisAmount)
                    {
                    }
                    column(LineDiscCaption; TotalFooterAmountText[6])
                    {
                    }
                    column(AmountPaid; ROUND(AmttoPaid, 0.01, '='))
                    {
                    }
                    column(InvTotalAmt; ROUND(InvTotalAmount, 0.01, '='))
                    {
                    }
                    column(AmtLetter; AmountLetter)
                    {
                    }
                    column(Footertext; Footertext)
                    {
                    }
                    column(SITotalSubTotal; ROUND(SITotalSubTotal, 0.01, '='))
                    {
                    }
                    column(SITotalInvDiscAmount; ROUND(SITotalInvDiscAmount, 0.01, '='))
                    {
                    }
                    column(SITotalAmount; ROUND(SITotalAmount, 0.01, '='))
                    {
                    }
                    column(SITotalAmountVAT; ROUND(SITotalAmountVAT, 0.01, '='))
                    {
                    }
                    column(SITotalAmountInclVAT; ROUND(SITotalAmountInclVAT, 0.01, '='))
                    {
                    }
                    column(SCMTotalSubTotal; ROUND(SCMTotalSubTotal, 0.01, '='))
                    {
                    }
                    column(SCMTotalInvDiscAmount; ROUND(SCMTotalInvDiscAmount, 0.01, '='))
                    {
                    }
                    column(SCMTotalAmount; ROUND(SCMTotalAmount, 0.01, '='))
                    {
                    }
                    column(SCMTotalAmountVAT; ROUND(SCMTotalAmountVAT, 0.01, '='))
                    {
                    }
                    column(SCMTotalAmountInclVAT; ROUND(SCMTotalAmountInclVAT, 0.01, '='))
                    {
                    }
                    column(TotalAmountLetters; TotalAmountLetters)
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(DocumentNo; "Document No.")
                        {
                        }
                        column(SalesItem; "No.")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesDescrip; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesQty; Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesUOM; "Unit of Measure Code")
                        {
                        }
                        column(SalesPrice; ROUND("Unit Price", 0.01, '='))
                        {
                        }
                        column(SalesDisAmt; "Line Discount Amount")
                        {
                        }
                        column(SalesAmount; ROUND((Quantity * "Unit Price") - "Line Discount Amount", 0.01, '='))
                        {
                        }
                    }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
                        column(SalesCrMemo_DocumentNo; "Document No.")
                        {
                        }
                        column(SalesCrMemo_No; "No.")
                        {
                        }
                        column(SalesCrMemo_Description; Description)
                        {
                        }
                        column(SalesCrMemo_Quantity; Quantity)
                        {
                        }
                        column(SalesCrMemo_UOM; "Unit of Measure Code")
                        {
                        }
                        column(SalesCrMemo_UnitPrice; ROUND("Unit Price", 0.01, '='))
                        {
                        }
                        column(SalesCrMemo_LineDiscountAmt; "Line Discount Amount")
                        {
                        }
                        column(SalesCrMemo_Amount; ROUND((Quantity * "Unit Price") - "Line Discount Amount", 0.01, '='))
                        {
                        }
                        column(SalesCrMemo_RPMType; RPMType)
                        {
                        }
                        column(SalesCrMemo_RPMTypeNotBlank; RPMType <> '')
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            //HEI.01>>
                            if PrintPerRPMType and (Type = Type::Item) and Item.GET("No.") then
                                RPMType := Item."RPM Type FND";
                            //HEI.01>>
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE("Document No.", SalesCrMemoHeader."No."); //HEI.01
                        end;
                    }

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

                        DocumentTitleText := STRSUBSTNO(DocumentCaption2, CopyText);

                        SalesInvLineAmt.RESET;
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        //>>HEI:CHG0153013:1:1 14/12/16 IBM.AV
                        //SalesInvLineAmt.SETRANGE(Type,SalesInvLineAmt.Type::Item); //commented
                        SalesInvLineAmt.SETRANGE(Type, SalesInvLineAmt.Type::Item, SalesInvLineAmt.Type::"Fixed Asset");   //added
                        //<<HEI:CHG0153013:1:1 14/12/16 IBM.AV
                        if SalesInvLineAmt.FINDSET then
                            repeat
                                InvLineTotal += SalesInvLineAmt."Line Amount" + SalesInvLineAmt."Line Discount Amount";
                            until SalesInvLineAmt.NEXT = 0;

                        //<<HEI:CHG0187935:1:1 24/08/17 IBM.SP
                        SalesInvLineAmt.RESET;
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLineAmt.SETRANGE(Type, SalesInvLineAmt.Type::"G/L Account");   //sP
                        if SalesInvLineAmt.FINDSET then
                            repeat
                                InvLineTotal += SalesInvLineAmt."Line Amount" + SalesInvLineAmt."Line Discount Amount";
                            until SalesInvLineAmt.NEXT = 0;

                        //<<HEI:CHG0187935:1:1 24/08/17 IBM.SP


                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");

                        if SalesInvLine.FINDSET then
                            repeat
                            // BC Upgrade BHARDA11 >> ----Drink-IT Field("Item Charge Type")
                            // case SalesInvLine."Item Charge Type" of
                            //     SalesInvLine."Item Charge Type"::Tax:
                            //         begin
                            //             TotalFooterAmount[1] += SalesInvLine."Line Amount";
                            //             TotalFooterAmountText[1] := Text57002;
                            //         end;
                            //     SalesInvLine."Item Charge Type"::Deposit:
                            //         begin
                            //             if SalesInvLine."Line Amount" > 0 then begin
                            //                 TotalFooterAmount[2] += SalesInvLine."Line Amount";
                            //                 TotalFooterAmountText[2] := Text57004;
                            //             end else if SalesInvLine."Line Amount" < 0 then begin
                            //                 TotalFooterAmount[3] += SalesInvLine."Line Amount";
                            //                 TotalFooterAmountText[3] := Text57005;
                            //             end;
                            //         end;
                            //     SalesInvLine."Item Charge Type"::"Shipping Cost":
                            //         begin
                            //             TotalFooterAmount[4] += SalesInvLine."Line Amount";
                            //             TotalFooterAmountText[4] := Text57006;
                            //         end;
                            //     SalesInvLine."Item Charge Type"::Discount:
                            //         begin
                            //             //>>HEI:INC0259274:1:1 28/07/16 IBM.AV
                            //             // TotalFooterAmount[5] += SalesInvLine."Line Amount";        // Commented
                            //             TotalFooterAmount[5] += ABS(SalesInvLine."Line Amount");        // Added
                            //                                                                             //>>HEI:INC0259274:1:1 28/07/16 IBM.AV
                            //             TotalFooterAmountText[5] := 'Invoice Discounts';
                            //         end;
                            // end;
                            // BC Upgrade BHARDA11 << ----Drink-IT Field("Item Charge Type")
                            until SalesInvLine.NEXT = 0;

                        TaxAmout := TotalFooterAmount[1];
                        DepAmountP := TotalFooterAmount[2];
                        DepAmountN := TotalFooterAmount[3];
                        ShipAmount := TotalFooterAmount[4];

                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");

                        if SalesInvLine.FINDSET then
                            repeat
                                TotalFooterAmount[5] += SalesInvLine."Inv. Discount Amount";
                                TotalFooterAmountText[5] := SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                                TotalFooterAmount[6] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[6] := SalesInvLine.FIELDCAPTION("Line Discount Amount");
                            until SalesInvLine.NEXT = 0;

                        InvDisAmount := TotalFooterAmount[5];
                        LineDisAmount := TotalFooterAmount[6];

                        //>>HEI:INC0259274:1:1 28/07/16 IBM.AV
                        //InvTotalAmount := AmttoPaid+VATAmount+InvDisAmount;       // Commented
                        InvTotalAmount := AmttoPaid + VATAmount - ABS(InvDisAmount);        // Added
                        //<<HEI:INC0259274:1:1 28/07/16 IBM.AV

                        //HEI>>
                        //MontantToutLettre."Montant en texte1"(AmountLetters,ROUND(InvTotalAmount,0.01,'=')); //old
                        if lang = 1033 then begin
                            RepCheck.InitTextVariable;
                            if "Sales Invoice Header"."Currency Code" = '' then
                                RepCheck.FormatNoText(AmountLetters, ROUND(InvTotalAmount, 0.01, '='), '')
                            else
                                RepCheck.FormatNoText(AmountLetters, InvTotalAmount, '');
                            AmountLetter := AmountLetters[1] + AmountLetters[2];
                        end
                        else if lang = 1036 then begin
                            if "Sales Invoice Header"."Currency Code" = '' then
                                MontantToutLettre."Montant en texte1"(AmountLetter, ROUND(InvTotalAmount, 0.01, '='))
                            else
                                MontantToutLettre."Montant en texte1"(AmountLetter, InvTotalAmount);
                        end;
                        //HEI<<

                        //HEI.01>>
                        SITotalSubTotal := 0;
                        SITotalInvDiscAmount := 0;
                        SITotalAmount := 0;
                        SITotalAmountVAT := 0;
                        SITotalAmountInclVAT := 0;

                        SCMTotalSubTotal := 0;
                        SCMTotalInvDiscAmount := 0;
                        SCMTotalAmount := 0;
                        SCMTotalAmountVAT := 0;
                        SCMTotalAmountInclVAT := 0;

                        SalesInvoiceLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        if SalesInvLine.FINDSET then
                            repeat
                                SITotalSubTotal += SalesInvoiceLine."Line Amount";
                                SITotalInvDiscAmount -= SalesInvoiceLine."Inv. Discount Amount";
                                SITotalAmount += SalesInvoiceLine.Amount;
                                SITotalAmountVAT += SalesInvoiceLine."Amount Including VAT" - SalesInvoiceLine.Amount;
                                SITotalAmountInclVAT += SalesInvoiceLine."Amount Including VAT";
                            until SalesInvoiceLine.NEXT = 0;

                        SalesCreditMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                        if SalesCreditMemoLine.FINDSET then
                            repeat
                                SCMTotalSubTotal += SalesCreditMemoLine."Line Amount";
                                SCMTotalInvDiscAmount -= SalesCreditMemoLine."Inv. Discount Amount";
                                SCMTotalAmount += SalesCreditMemoLine.Amount;
                                SCMTotalAmountVAT += SalesCreditMemoLine."Amount Including VAT" - SalesCreditMemoLine.Amount;
                                SCMTotalAmountInclVAT += SalesCreditMemoLine."Amount Including VAT";
                            until SalesCreditMemoLine.NEXT = 0;

                        MontantToutLettre."Montant en texte1"(TotalAmountLetters, ABS(ROUND(SITotalAmountInclVAT, 0.01, '=') - ROUND(SCMTotalAmountInclVAT, 0.01, '=')));
                        if SITotalAmountInclVAT - SCMTotalAmountInclVAT < 0 then
                            TotalAmountLetters := '- ' + TotalAmountLetters;
                        //HEI.01>>
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        CopyText := Text52000;
                        CurrReport.PAGENO := 1;
                        OutputNo := OutputNo + 1;

                        //HEI>>
                        Footertext := 'REPRINTED'
                        //HEI<<
                    end;
                end;

                trigger OnPostDataItem();
                begin
                    //HEI>>
                    if not CurrReport.PREVIEW then
                        //HEI<<
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


                    //HEI>>
                    if "Sales Invoice Header"."No. Printed" > 0 then
                        Footertext := 'REPRINTED';
                    //HEI<<
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if CustomerAttributes.GET("Bill-to Customer No.") then; //HEI.02

                //>>HEI.01
                if ("Order No." = '') then
                    CurrReport.SKIP
                else begin
                    SalesCrMemoHeader.SETRANGE("Return Order No.", "Order No.");
                    // SalesCrMemoHeader.SETFILTER("Link Sales Document No.", '<> %1', ''); // BC Upgrade BHARDA11 ----Drink-IT Field("Link Sales Document No.")
                    if SalesCrMemoHeader.FINDFIRST then;
                end;

                FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
                //<<HEI.01

                //HEI>>
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code"); //old
                // BC Upgrade BHARDA11 >> ---Replace GetLanguageID with GetLanguageIdOrDefault
                // lang := Language.GetLanguageID(FORMAT(GLOBALLANGUAGE));
                // CurrReport.LANGUAGE := lang;
                lang := LanguagMgt.GetLanguageIdOrDefault(FORMAT(GLOBALLANGUAGE));
                CurrReport.Language := lang;
                // BC Upgrade BHARDA11 << ---Replace GetLanguageID with GetLanguageIdOrDefault
                GLOBALLANGUAGE(lang);

                //HEI<<

                if RespCenter.GET("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                end;

                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");

                if PaymentMethod.GET("Sales Invoice Header"."Payment Method Code") then;

                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Invoice Header"."Language Code");

                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalExText := STRSUBSTNO(Text52001, GLSetup."LCY Code");
                    TotalInText := STRSUBSTNO(Text52002, GLSetup."LCY Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := STRSUBSTNO(Text52005, GLSetup."LCY Code");
                end else begin
                    TotalExText := STRSUBSTNO(Text52001, "Currency Code");
                    TotalInText := STRSUBSTNO(Text52002, "Currency Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := STRSUBSTNO(Text52005, GLSetup."LCY Code");
                end;

                VATEntry.RESET;
                VATEntry.SETRANGE(Type, VATEntry.Type::Sale);
                VATEntry.SETRANGE("Document Type", VATEntry."Document Type"::Invoice);
                VATEntry.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                if VATEntry.FINDSET then
                    repeat
                        VatAmt += VATEntry.Amount;
                    until VATEntry.NEXT = 0;
                VATAmount := -VatAmt;

                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.FINDFIRST then
                    VATPer := SalesInvLine."VAT %";

                if Customer.GET("Bill-to Customer No.") then
                    if Country.GET(Customer."Country/Region Code") then; //HEI.03
            end;

            trigger OnPostDataItem();
            begin
                NUMLines := 20;
                LinesPrinted := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("Sales Order")
                {
                    Caption = 'Sales Order';
                    field("No. of Copies"; NoOfCopies)
                    {
                        ApplicationArea = All;
                    }
                    field(PrintPerRPMType; PrintPerRPMType)
                    {
                        ApplicationArea = All;
                        Caption = 'Print per RPM Type';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            RequestPageUsed := true;
        end;
    }

    labels
    {
        label(lblPayTerms; ENU = 'Payment Terms',
                          FRA = 'Conditions de réglement')
        label(lblPayMethod; ENU = 'Payment Method',
                           FRA = 'Mode de réglement')
        label(lblAmtPaid; ENU = 'Total DA Excl. VAT',
                         FRA = 'Total DA HT')
        label(lblSalesCondition; ENU = 'The Sale Conditions on the back side',
                                FRA = 'Conditions generales de vento ou envers')
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
        label(lblInvoiceNo; ENU = 'Invoice No.',
                           FRA = 'N° de facture')
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
        label(lblNIS; ENU = 'N.I.S.',
                     FRA = 'N.I.S.')
        label(lblPhone; ENU = 'Phone No. :',
                       FRA = 'Téléphone :')
        label(lblFax; ENU = 'Fax No. :',
                     FRA = 'N°  Télécopie :')
        label(lblAmtinWord; ENU = 'Amount in Words :',
                           FRA = 'La présente facture est arrêtée à la somme de :')
        label(lblOrder; ENU = 'Sales Order No.',
                       FRA = 'N° Commande')
        RPMTypeLbl = 'RPM Type:'; TotalLbl = 'Total';
    }

    trigger OnInitReport();
    begin
        GLSetup.GET;
        CompanyInfo.GET;
        SalesSetup.GET;
    end;

    var
        CompanyInfo: Record "Company Information";
        // Language: Record Language; // BC Upgrade BHARDA11 ---Replace Language to language codeunit 
        LanguagMgt: Codeunit Language; // BC Upgrade BHARDA11
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
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        // ReportEmpties: Report "Sales Invoice Empties Base"; // 50041 Report
        Check: Report Check;
        Currency: Record Currency;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        MontantToutLettre: Codeunit "Heicore_Funct CBN"; //50036 codeunit
        AmountLetter: Text[250];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
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
        SplitNo: Integer;
        RequestPageUsed: Boolean;
        Footertext: Text;
        RepCheck: Report Check;
        AmountLetters: array[2] of Text[250];
        lang: Integer;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        RPMType: Code[20];
        PrintPerRPMType: Boolean;
        Item: Record Item;
        SITotalSubTotal: Decimal;
        SITotalInvDiscAmount: Decimal;
        SITotalAmount: Decimal;
        SITotalAmountVAT: Decimal;
        SITotalAmountInclVAT: Decimal;
        SCMTotalSubTotal: Decimal;
        SCMTotalInvDiscAmount: Decimal;
        SCMTotalAmount: Decimal;
        SCMTotalAmountVAT: Decimal;
        SCMTotalAmountInclVAT: Decimal;
        InvDiscountAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        FormatDocument: Codeunit "Format Document";
        TotalAmountLetters: Text;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCreditMemoLine: Record "Sales Cr.Memo Line";
        CustomerAttributes: Record "Customer Attributes FND";

    procedure DocumentCaption2(): Text[250];
    begin
        exit(Text52006);
    end;
}

