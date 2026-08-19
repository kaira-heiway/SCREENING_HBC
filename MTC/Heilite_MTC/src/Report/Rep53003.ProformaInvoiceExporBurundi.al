report 53003 "Proforma Invoice Expor Burundi"
{
    // version HEI.01

    // HEI.01 Report created
    // HEI.02 Defect #5011 IBM POSTOI01 11.12.2019 # Burundi FAT
    //   #TextBox 144 field from layout, change the Text Box Properties-> Number : Decimal places = 0
    // HEI.04 CHG2064677 IBM SHANKJ03
    //   # replication report created from 50386 or export condition

    // BC Upgrade RAHUL>> 
    // 1. Blocking Drink-IT Field ("Tax Registration No.").
    // 2. Adding Application Area to the Action on Request Page to Field(No. of Copies).
    // 3. Remove Drink-IT Field("Sales Header"."Order No.").
    // 4. Blocked whole loop as dependency on DIT(Field-"Item Charge Type").
    // 5. Commenting As Function Moved from Table to Codeunit. (Language: Record Language).
    // 6. Blocked because of DIT Object(DocSubtypeCodeSetup."Sundry Sales Order Non Stock", DocSubtypeCodeSetup."Sundry Sales Order Stock").
    // 7. Blocking Colomn As DIT Field("Sales Header"."Order No.");
    // 8. Old report ID is 50443.
    // BC Upgrade RAHUL<<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Proforma Invoice Expor Burundi.rdl';

    CaptionML = ENU = 'Proforma Invoice Burundi',
                FRA = 'Facture Proforma Burundi',
                ENG = 'Proforma Invoice Burundi';
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeadingML = ENU = 'Proforma Invoice',
                                     FRA = 'Proforma commande vente',
                                     ENG = 'Proforma Invoice';
            column(SalesHDocNo; "Sales Header"."No.")
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
            column(CompanyInfoContryName; CompanyInfoContryName)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo."OpCo Logo FND")
            {
            }
            column(CompanyInfo_BankAccNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyInfo_BankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfo_Giro; CompanyInfo."Giro No.")
            {
            }
            column(CompanyInfo_Iban; CompanyInfo.IBAN)
            {
            }
            column(CompanyInfo_swiftCode; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(OriginalCopy; OriginalCopy)
            {
            }
            column(CompanyInfo_OpCoFooterImage; CompanyInfo."OpCo Footer image FND")
            {
            }
            column(CompanyText; CompanyText)
            {
            }
            column(TxtPayTerms; TxtPayTerms)
            {
            }
            column(TxtShipMethod; TxtShipMethod)
            {
            }
            column(TxtAmtPaid; TxtAmtPaid)
            {
            }
            column(TxtSalesCondition; TxtSalesCondition)
            {
            }
            column(TxtSalesPerson; TxtSalesPerson)
            {
            }
            column(TxtUOM; TxtUOM)
            {
            }
            column(TxtUnitPrice; TxtUnitPrice)
            {
            }
            column(TxtSaleLAmt; TxtSaleLAmt)
            {
            }
            column(TxtPageNo; TxtPageNo)
            {
            }
            column(TxtOrderNo; TxtOrderNo)
            {
            }
            column(TxtInvoiceNo; TxtInvoiceNo)
            {
            }
            column(TxtPostDate; TxtPostDate)
            {
            }
            column(TxtDueDate; TxtDueDate)
            {
            }
            column(TxtPrintDate; TxtPrintDate)
            {
            }
            column(TxtBillToAddress; TxtBillToAddress)
            {
            }
            column(TxtCustomerName; TxtCustomerName)
            {
            }
            column(TxtAddress; TxtAddress)
            {
            }
            column(TxtAddress2; TxtAddress2)
            {
            }
            column(TxtPostCode; TxtPostCode)
            {
            }
            column(TxtCity; TxtCity)
            {
            }
            column(TxtCountry; TxtCountry)
            {
            }
            column(TxtVatRegistrationNo; TxtVatRegistrationNo)
            {
            }
            column(TxtCompanyTaxId; TxtCompanyTaxId)
            {
            }
            column(TxtSoldToAddress; TxtSoldToAddress)
            {
            }
            column(TxtCustomerPoNo; TxtCustomerPoNo)
            {
            }
            column(TxtShipToAddress; TxtShipToAddress)
            {
            }
            column(TxtCustomerNo; TxtCustomerNo)
            {
            }
            column(TxtInvoiceCurrency; TxtInvoiceCurrency)
            {
            }
            column(TxtVersion; TxtVersion)
            {
            }
            column(TxtItemNo; TxtItemNo)
            {
            }
            column(TxtQty; TxtQty)
            {
            }
            column(TxtTotalToBePaid; TxtTotalToBePaid)
            {
            }
            column(TxtDisc; TxtDisc)
            {
            }
            column(TxtVATPer; TxtVATPer)
            {
            }
            column(TxtDiscTotal; TxtDiscTotal)
            {
            }
            column(TxtVATAmt; TxtVATAmt)
            {
            }
            column(TxtDescrip; TxtDescrip)
            {
            }
            column(TxtTaxDetails; TxtTaxDetails)
            {
            }
            column(TxtBankDetails; TxtBankDetails)
            {
            }
            column(TxtAccNo; TxtAccNo)
            {
            }
            column(TxtBank; TxtBank)
            {
            }
            column(TxtIBAN; TxtIBAN)
            {
            }
            column(TxtCodeSwift; TxtCodeSwift)
            {
            }
            column(TxtPaymTerms; TxtPaymTerms)
            {
            }
            column(TxtInCoTerms; TxtInCoTerms)
            {
            }
            column(TxtInvCurr; TxtInvCurr)
            {
            }
            column(TxtPaymMethod; TxtPaymMethod)
            {
            }
            column(FooterTextLbl; FooterText)
            {
            }
            column(FooterText2Lbl; FooterText2)
            {
            }
            column(FooterText1Lbl; FooterText1)
            {
            }
            column(TxtTTESTE; TxtTTESTE)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(Proforma_InvoiceNo; "Sales Header"."Posting No.")
                    {
                    }
                    column(CustomerAttributestext; CustomerAttributestext)
                    {
                    }
                    column(OrderConfirmCopyCaption; DocumentTitleText)
                    {
                    }
                    column(SalesHCustNo; "Sales Header"."Bill-to Customer No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SalesHPostDate; Format("Sales Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesHDueDate; Format("Sales Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesHDocDate; Format("Sales Header"."Document Date", 0, 4))
                    {
                    }
                    column(SalesHIncVAT; PriceIncVAT)
                    {
                    }
                    column(SalesHSalesPerName; SalesPerson.Name)
                    {
                    }
                    column(SalesPersonCode; "Sales Header"."Salesperson Code")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    // column(SalesHOrdNo; "Sales Header"."Order No.")BC Upgrade RAHUL DIT field Dependency
                    // {
                    // } 
                    column(SalesHReference; "Sales Header"."Your Reference")
                    {
                    }
                    column(SalesHExtRefNo; "Sales Header"."External Document No.")
                    {
                    }
                    column(SalesHVATRegNo; "Sales Header"."VAT Registration No.")
                    {
                        IncludeCaption = true;
                    }
                    column(PaymentTermDescrip; PaymentTerms.Description)
                    {
                    }
                    column(PaymentMethodDesc; PaymentMethod.Description)
                    {
                    }
                    column(ShipMethodDescrip; ShipmentMethod.Description)
                    {
                    }
                    column(CustName; CustomerName)
                    {
                    }
                    column(CustAddress; CustomerAddress)
                    {
                    }
                    column(SubTotal; Round(InvLineTotal, 0.01, '='))
                    {
                    }
                    column(VATAmount; VATAmount)
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
                    column(DepositAmount; DepAmount)
                    {
                    }
                    column(DepositAmtCaption; TotalFooterAmountText[2])
                    {
                    }
                    column(ShippingAmount; ShipAmount)
                    {
                    }
                    column(ShippingAmtCaption; TotalFooterAmountText[3])
                    {
                    }
                    column(LineDiscountAmt; LineDisAmount)
                    {
                    }
                    column(LineDiscCaption; TotalFooterAmountText[4])
                    {
                    }
                    column(AmountPaid; AmttoPaid)
                    {
                    }
                    column(InvTotalAmt; InvTotalAmount)
                    {
                    }
                    column(ShippingChargesAmount; ShippingChargesAmount)
                    {
                    }
                    column(ShippingChargeAmtCaption; TotalFooterAmountText[6])
                    {
                    }
                    column(MarkupChargeAmtCaption; TotalFooterAmountText[5])
                    {
                    }
                    column(MarkupChargesAmount; MarkupChargesAmount)
                    {
                    }
                    column(BaseMarginAmt; BaseMarginAmt)
                    {
                    }
                    column(BaseMarginAmtCaption; TotalFooterAmountText[7])
                    {
                    }
                    column(TotalDiscount; TotalDiscount)
                    {
                    }
                    column(SplitVatPercent1; SplitVatPercent[1])
                    {
                    }
                    column(SplitVatPercent2; SplitVatPercent[2])
                    {
                    }
                    column(SplitVatPercent3; SplitVatPercent[3])
                    {
                    }
                    column(SplitVatAmount1; SplitVatAmount[1])
                    {
                    }
                    column(SplitVatAmount2; SplitVatAmount[2])
                    {
                    }
                    column(SplitVatAmount3; SplitVatAmount[3])
                    {
                    }
                    column(SalesInvHeader_BillToName; "Sales Header"."Bill-to Name")
                    {
                    }
                    column(SalesInvHeader_BillToPostCode; "Sales Header"."Bill-to Post Code")
                    {
                    }
                    column(SalesInvHeader_BillToCity; "Sales Header"."Bill-to City")
                    {
                    }
                    column(BillToVatRegNo; BillToCustomer."VAT Registration No.")
                    {
                    }
                    column(BillToCountryName; BillToCountry.Name)
                    {
                    }
                    column(SalesInvHeader_SellToName; "Sales Header"."Sell-to Customer Name")
                    {
                    }
                    column(SalesInvHeader_SellToCity; "Sales Header"."Sell-to City")
                    {
                    }
                    column(SalesInvHeader_SellToPostCode; "Sales Header"."Sell-to Post Code")
                    {
                    }
                    column(SellToCountryName; SoldToCountry.Name)
                    {
                    }
                    column(SellToVatRegNo; SoldToCustomer."VAT Registration No.")
                    {
                    }
                    column(SalesInvHeader_BillToAddress; "Sales Header"."Bill-to Address")
                    {
                    }
                    column(SalesInvHeader_BillToAddress2; "Sales Header"."Bill-to Address 2")
                    {
                    }
                    column(SalesInvHeader_SellToAddress; "Sales Header"."Sell-to Address")
                    {
                    }
                    column(SalesInvHeader_SellToAddress2; "Sales Header"."Sell-to Address 2")
                    {
                    }
                    column(SalesInvHeader_ShipToName; "Sales Header"."Ship-to Name")
                    {
                    }
                    column(SalesInvHeader_Address; "Sales Header"."Ship-to Address")
                    {
                    }
                    column(SalesInvHeader_Address2; "Sales Header"."Ship-to Address 2")
                    {
                    }
                    column(SalesInvHeader_City; "Sales Header"."Ship-to City")
                    {
                    }
                    column(SellCustomerNo; "Sales Header"."Sell-to Customer No.")
                    {
                    }
                    column(CurrencyCode; "Sales Header"."Currency Code")
                    {
                    }
                    column(InvalidTxt; InvalidTxt)
                    {
                    }
                    column(TotalInvDis; TotalInvDis)
                    {
                    }
                    column(TotalAmountLCY; TotalAmountLCY)
                    {
                    }
                    column(DescriptionLine2; DescriptionLine[2])
                    {
                    }
                    column(DescriptionLine1; DescriptionLine[1])
                    {
                    }
                    column(InCoTerms; "Sales Header"."InCo Terms FND")
                    {
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where(Type = filter(Item | Resource | "Fixed Asset"));
                        column(SalesLType; "Sales Line".Type)
                        {
                        }
                        column(SalesItem; "Sales Line"."No.")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesDescrip; "Sales Line".Description)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesQty; "Sales Line".Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesUOM; "Sales Line"."Unit of Measure Code")
                        {
                        }
                        column(SalesPrice; Round("Sales Line"."Unit Price", 1, '='))
                        {
                        }
                        column(SalesVATPer; "Sales Line"."VAT %")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesAmount; "Sales Line".Quantity * "Sales Line"."Unit Price")
                        {
                        }
                        column(TotalQuantity; TotalQty)
                        {
                        }
                        column(SalesDiscount; "Sales Line"."Line Discount Amount")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;

                            TotalInvDis += "Sales Line"."Line Discount Amount";
                        end;
                    }
                    dataitem(SplitVatAmt; "Integer")
                    {
                        column(TEMPAccSchedKPIBuffer_VatPercent; Format(TEMPAccSchedKPIBuffer."Balance at Date Forecast"))
                        {
                        }
                        column(TEMPAccSchedKPIBuffer_VatAmount; TEMPAccSchedKPIBuffer."Net Change Budget")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not TEMPAccSchedKPIBuffer.Find('-') then
                                    CurrReport.Break();
                            end else
                                if TEMPAccSchedKPIBuffer.Next() = 0 then
                                    CurrReport.Break();
                        end;

                        trigger OnPreDataItem();
                        begin
                            SetRange(Number, 1, TEMPAccSchedKPIBuffer.Count);
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        Clear(TotalFooterAmount);
                        Clear(TotalFooterAmountText);
                        Clear(InvTotalAmount);
                        Clear(AmttoPaid);
                        Clear(TotalInvDis);

                        DocumentTitleText := StrSubstNo(Text52006, CopyText);
                        //DocumentTitleText := STRSUBSTNO(Text52004B,CopyText);
                        SalesInvLineAmt.Reset();
                        SalesInvLineAmt.SetRange("Document Type", "Sales Header"."Document Type");
                        SalesInvLineAmt.SetRange("Document No.", "Sales Header"."No.");
                        SalesInvLineAmt.SetFilter(Type, '%1|%2|%3', SalesInvLineAmt.Type::Item, SalesInvLineAmt.Type::Resource, SalesInvLineAmt.Type::"Fixed Asset");
                        if SalesInvLineAmt.FindSet() then
                            repeat
                                //HEI.03 InvLineTotal += SalesInvLineAmt."Line Amount";
                                InvLineTotal += SalesInvLineAmt.Amount; //HEI03
                            until SalesInvLineAmt.Next() = 0;

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;

                        // BC Upgrade RAHUL >> - Blocked whole for loop  as dependency on DIT
                        // SalesInvLine.Reset();
                        // SalesInvLine.SetRange("Document Type", "Sales Header"."Document Type");
                        // SalesInvLine.SetRange("Document No.", "Sales Header"."No.");
                        // SalesInvLine.SetRange(Type, SalesInvLine.Type::"Charge (Item)");
                        // if SalesInvLine.FindSet() then
                        //     repeat
                        //         case SalesInvLine."Item Charge Type" of
                        //             SalesInvLine."Item Charge Type"::Tax:
                        //                 begin
                        //                     TotalFooterAmount[1] += SalesInvLine.Amount;  //hei.03
                        //                                                                   //TotalFooterAmountText[1]:= 'Excise Duties';
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::Deposit:
                        //                 begin
                        //                     TotalFooterAmount[2] += SalesInvLine."Line Amount";
                        //                     //TotalFooterAmountText[2]:= 'Deposit Amount';
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::ShippingCost:
                        //                 begin
                        //                     TotalFooterAmount[3] += SalesInvLine.Amount;  //hei.03
                        //                     TotalFooterAmountText[3] := Text52011;
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::Discount:
                        //                 begin
                        //                     if SalesInvLine."No." = 'S_MARKUP' then begin
                        //                         TotalFooterAmount[5] += SalesInvLine.Amount; //HEI.03
                        //                         TotalFooterAmountText[5] := 'Markup Charges:';


                        //                     end;

                        //                     if SalesInvLine."No." = 'A1.PPR' then begin
                        //                         TotalFooterAmount[7] += SalesInvLine.Amount; //HEI.03
                        //                         TotalFooterAmountText[7] := 'Base Margin PPR:';
                        //                     end;

                        //                     if SalesInvLine."No." = 'S_SHIP' then begin
                        //                         TotalFooterAmount[6] += SalesInvLine.Amount; //HEI.03
                        //                     end else
                        //                         TotalFooterAmount[8] += SalesInvLine.Amount;//HEI.04
                        //                 end;
                        //         end;
                        //     until SalesInvLine.Next() = 0;
                        // BC Upgrade RAHUL << - Blocked whole loop as dependency on Drink-IT Field


                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];

                        ShippingChargesAmount := TotalFooterAmount[6];
                        MarkupChargesAmount := TotalFooterAmount[5];
                        BaseMarginAmt := TotalFooterAmount[7];
                        TotalDiscount := TotalFooterAmount[8];

                        SalesInvLine.Reset();
                        SalesInvLine.SetRange("Document Type", "Sales Header"."Document Type");
                        SalesInvLine.SetRange("Document No.", "Sales Header"."No.");
                        SalesInvLine.SetRange(Type, SalesInvLine.Type::"Charge (Item)");
                        if SalesInvLine.FindSet() then
                            repeat
                                TotalFooterAmount[4] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[4] := Text52010;
                            until SalesInvLine.Next() = 0;

                        LineDisAmount := TotalFooterAmount[4];



                        AmttoPaid := InvLineTotal + VatAmt + TotalFooterAmount[1] + VatAmt + TotalFooterAmount[5] + TotalFooterAmount[6] - VatAmt + TotalFooterAmount[4];
                        InvTotalAmount := AmttoPaid + TotalFooterAmount[2];

                        //Amount in letters
                        Check.InitTextVariable();
                        if "Sales Header"."Prices Including VAT" then
                            Check.FormatNoText(DescriptionLine, Round(DepAmount + Round(InvLineTotal, 1, '=') + TaxAmout + BaseMarginAmt, 0.01, '='), "Sales Header"."Currency Code")
                        else
                            Check.FormatNoText(DescriptionLine, Round(Round(InvLineTotal, 1, '=') + TaxAmout + VATAmount + DepAmount + ShippingChargesAmount + MarkupChargesAmount + TotalDiscount, 0.01, '='), "Sales Header"."Currency Code");//HEI.04
                                                                                                                                                                                                                                                //Check.FormatNoText(DescriptionLine,ROUND(ROUND(InvLineTotal,1,'=') + TaxAmout + VATAmount + DepAmount + ShippingChargesAmount + MarkupChargesAmount + BaseMarginAmt,0.01,'='),"Sales Header"."Currency Code");

                        DescriptionLine[1] := CopyStr(DescriptionLine[1], 6);

                        if DescriptionLine[2] <> '' then
                            DescriptionLine[2] += ' ONLY'
                        else
                            DescriptionLine[1] += ' ONLY';
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then
                        CopyText := Text52000;
                    CurrReport.PageNo := 1;
                    OutputNo := OutputNo + 1;

                    Clear(TotalFooterAmount);
                    Clear(TotalFooterAmountText);
                    Clear(InvTotalAmount);
                    Clear(AmttoPaid);
                    Clear(TotalInvDis);
                    Clear(InvLineTotal);
                end;

                trigger OnPostDataItem();
                begin
                    SalesInvCountPrinted.Run("Sales Header");
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := Abs(NoOfCopies);
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;

                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord();
            begin

                //Company Text
                Clear(CompanyText);
                CompanyText := CompanyInfo.Name;
                if (CompanyInfo.Address <> '') then
                    CompanyText += ', ' + CompanyInfo.Address;
                if (CompanyInfo."Address 2" <> '') then
                    CompanyText += ', ' + CompanyInfo."Address 2";
                if (CompanyInfo."Post Code" <> '') then
                    CompanyText += ', ' + CompanyInfo."Post Code";
                if (CompanyInfo.City <> '') then
                    CompanyText += ' ' + CompanyInfo.City;
                if (CompanyInfo."Country/Region Code" <> '') then
                    if CountryInfo.Get(CompanyInfo."Country/Region Code") then
                        CompanyText += ', ' + CompanyInfo."Country/Region Code" + ' ' + CountryInfo.Name;
                // BC Upgrade RAHUL >> ----Drink-IT Field ("Tax Registration No.")
                // if CompanyInfo."Tax Registration No." <> '' then
                //     CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                // BC Upgrade RAHUL << ----Drink-IT Field ("Tax Registration No.")
                //CompanyText += ', ' + ChOfComm;
                if CompanyInfo."Phone No." <> '' then
                    CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                if CompanyInfo."Fax No." <> '' then
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                if CompanyInfo."E-Mail" <> '' then
                    CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";


                TEMPAccSchedKPIBuffer.DeleteAll();
                if Country.Get(CompanyInfo."Country/Region Code") then
                    CompanyInfoContryName := Country.Name;

                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                //decide if export invoice/intercompany or not and set de report language
                SetExportICInvoice();

                //set the invoice language
                DocLanguage := 'ENG';
                if ICInvoice then begin
                    DocLanguage := 'ENG';
                end else begin
                    if ExportInvoice then
                        DocLanguage := 'ENG'
                    else
                        DocLanguage := 'FRA';
                end;

                // CurrReport.Language := Language.GetLanguageID(DocLanguage); //GetlanguageId moved from Table to CU.
                CurrReport.Language := LanguageG.GetLanguageId(DocLanguage); //GetlanguageId moved from Table to CU.

                //footer texts
                FooterText := CompanyInfo.Address;
                if CompanyInfo."Post Code" <> '' then
                    FooterText := FooterText + ' - ' + CompanyInfo."Post Code";
                if CompanyInfo.City <> '' then
                    FooterText := FooterText + ' ' + CompanyInfo.City;
                if CompanyInfo."Phone No." <> '' then
                    FooterText := FooterText + ' - Tel: ' + CompanyInfo."Phone No.";
                if CompanyInfo."Fax No." <> '' then
                    FooterText := FooterText + ' - Fax: ' + CompanyInfo."Fax No.";
                FooterText1 := CompanyInfo."Add. Address FND";

                if CompanyInfo."Add. Post Code FND" <> '' then
                    FooterText1 := FooterText1 + ' - ' + CompanyInfo."Add. Post Code FND";
                if CompanyInfo."Add. City FND" <> '' then
                    FooterText1 := FooterText1 + ' ' + CompanyInfo."Add. City FND";
                if CompanyInfo."Add. Phone No. FND" <> '' then
                    FooterText1 := FooterText1 + ' - Tel: ' + CompanyInfo."Add. Phone No. FND";
                FooterText2 := FooterSubText + ' ' + CompanyInfo."Home Page";

                if FooterText = '' then begin
                    FooterText := FooterText1;
                    FooterText1 := FooterText2;
                    FooterText2 := '';
                end else begin
                    if FooterText1 = '' then begin
                        FooterText1 := FooterText2;
                        FooterText2 := '';
                    end;
                end;
                /*
                FooterText := CompanyInfo.Address + '-' + CompanyInfo."Post Code" +' '+ CompanyInfo.City + '-Tel : ' + CompanyInfo."Phone No." + '-' + ' Fax : ' + CompanyInfo."Fax No.";
                FooterText1 := CompanyInfo."Add. Address" + '-' + CompanyInfo."Add. Post Code" +' '+ CompanyInfo."Add. City" + '-Tel : ' + CompanyInfo."Add. Phone No.";
                FooterText2 := FooterSubText + ' ' + CompanyInfo."Home Page";
                */
                if SalesPerson.Get("Sales Header"."Salesperson Code") then;

                if ShipmentMethod.Get("Sales Header"."Shipment Method Code") then
                    ShipmentMethod.TranslateDescription(ShipmentMethod, DocLanguage);

                if PaymentTerms.Get("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, DocLanguage);

                PaymentMethod.Reset();
                if PaymentMethod.Get("Payment Method Code") then;

                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalExText := StrSubstNo(Text52001, GLSetup."LCY Code");
                    TotalInText := StrSubstNo(Text52002, GLSetup."LCY Code");
                    SubTotalInText := StrSubstNo(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := StrSubstNo(Text52005, GLSetup."LCY Code");
                end else begin
                    TotalExText := StrSubstNo(Text52001, "Currency Code");
                    TotalInText := StrSubstNo(Text52002, "Currency Code");
                    SubTotalInText := StrSubstNo(Text52005B, "Currency Code");
                    SubTotalExText := StrSubstNo(Text52005, "Currency Code");
                end;


                CustomerNo := '';
                CustomerName := '';
                CustomerAddress := '';
                if Customer.Get("Sales Header"."Bill-to Customer No.") then begin
                    ;
                    CustomerNo := "Bill-to Customer No.";
                    CustomerName := "Bill-to Name";
                    CustomerAddress := "Bill-to City" + ', ' + "Bill-to Address" + ', ' + "Bill-to Address 2";
                    if ("Bill-to City" <> '') and ("Bill-to Address" <> '') and ("Bill-to Address 2" <> '') then
                        CustomerAddress := "Bill-to City" + ', ' + "Bill-to Address" + ', ' + "Bill-to Address 2";

                    if ("Bill-to City" = '') and ("Bill-to Address" <> '') and ("Bill-to Address 2" <> '') then
                        CustomerAddress := "Bill-to Address" + ', ' + "Bill-to Address 2";
                    if ("Bill-to City" <> '') and ("Bill-to Address" = '') and ("Bill-to Address 2" <> '') then
                        CustomerAddress := "Bill-to City" + ', ' + "Bill-to Address 2";
                    if ("Bill-to City" <> '') and ("Bill-to Address" <> '') and ("Bill-to Address 2" = '') then
                        CustomerAddress := "Bill-to City" + ', ' + "Bill-to Address";

                    if ("Bill-to City" = '') and ("Bill-to Address" = '') and ("Bill-to Address 2" <> '') then
                        CustomerAddress := "Bill-to Address 2";
                    if ("Bill-to City" <> '') and ("Bill-to Address" = '') and ("Bill-to Address 2" = '') then
                        CustomerAddress := "Bill-to City";
                    if ("Bill-to City" = '') and ("Bill-to Address" <> '') and ("Bill-to Address 2" = '') then
                        CustomerAddress := "Bill-to Address";
                end;

                Clear(CustomerAttributestext);
                if CustomerAttributes.Get("Sales Header"."Bill-to Customer No.") then begin
                    if CustomerAttributes."Name 3" <> '' then
                        CustomerAttributestext += CustomerAttributes."Name 3" + '<br/>';
                    if CustomerAttributes."Name 4" <> '' then
                        CustomerAttributestext += CustomerAttributes."Name 4" + '<br/>';
                    if CustomerAttributes."Street 3" <> '' then
                        CustomerAttributestext += CustomerAttributes."Street 3" + '<br/>';
                    if CustomerAttributes."Street 4" <> '' then
                        CustomerAttributestext += CustomerAttributes."Street 4" + '<br/>';
                    if CustomerAttributes."Street 5" <> '' then
                        CustomerAttributestext += CustomerAttributes."Street 5" + '<br/>';
                    if CustomerAttributes."House No. 1" <> '' then
                        CustomerAttributestext += CustomerAttributes."House No. 1" + '<br/>';
                    if CustomerAttributes."House Supplement 2" <> '' then
                        CustomerAttributestext += CustomerAttributes."House Supplement 2" + '<br/>';
                end;

                /*VATEntry.RESET;
                VATEntry.SETRANGE(Type,VATEntry.Type::Sale);
                VATEntry.SETRANGE("Document Type",VATEntry."Document Type"::Invoice);
                VATEntry.SETRANGE("Document No.","Sales Invoice Header"."No.");
                IF VATEntry.FINDSET THEN REPEAT
                  //VatAmt += ABS(VATEntry.Amount);
                  VatAmt += VATEntry.Amount;
                UNTIL VATEntry.NEXT=0;
                VATAmount := ABS(VatAmt);*/



                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document Type", "Sales Header"."Document Type");
                SalesInvLine.SetRange("Document No.", "Sales Header"."No.");
                SalesInvLine.SetFilter("VAT %", '<>%1', 0);
                if SalesInvLine.FindFirst() then
                    VATPer := SalesInvLine."VAT %";

                if "Sales Header"."Prices Including VAT" = true then
                    PriceIncVAT := 'Yes'
                else
                    PriceIncVAT := 'No';

                VatAmt := 0;
                lineNumberVAT := 0;
                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document Type", "Sales Header"."Document Type");
                SalesInvLine.SetRange("Document No.", "Sales Header"."No.");
                SalesInvLine.SetFilter("VAT %", '<>%1', 0);
                if SalesInvLine.FindSet() then
                    repeat
                        VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                        VATAmount := Abs(VatAmt);

                        //split VAT
                        TEMPAccSchedKPIBuffer.Reset();
                        TEMPAccSchedKPIBuffer.SetRange("Balance at Date Forecast", SalesInvLine."VAT %");
                        if TEMPAccSchedKPIBuffer.FindFirst() then begin

                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.Modify();
                        end else begin
                            lineNumberVAT += 1;
                            TEMPAccSchedKPIBuffer.Init();
                            TEMPAccSchedKPIBuffer."No." := lineNumberVAT;
                            TEMPAccSchedKPIBuffer."Balance at Date Forecast" := SalesInvLine."VAT %";
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.Insert();
                        end;
                    until SalesInvLine.Next() = 0;

                TEMPAccSchedKPIBuffer.Reset();
                if TEMPAccSchedKPIBuffer.FindSet() then
                    repeat
                        Counter += 1;

                        SplitVatPercent[Counter] := Format(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%';
                        SplitVatAmount[Counter] := Format(TEMPAccSchedKPIBuffer."Net Change Budget", 0, '<Sign><Integer Thousand><Decimals,3>');
                    until TEMPAccSchedKPIBuffer.Next() = 0;

                BillToCustomer.Get("Sales Header"."Bill-to Customer No.");
                SoldToCustomer.Get("Sales Header"."Sell-to Customer No.");
                if BillToCountry.Get(BillToCustomer."Country/Region Code") then;
                if SoldToCountry.Get(SoldToCustomer."Country/Region Code") then;

                if "Sales Header"."No. Printed" = 0 then
                    OriginalCopy := Text50004
                else
                    OriginalCopy := Text52000;

                "Sales Header".CalcFields("Amount Including VAT");
                TotalAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(Today, "Sales Header"."Currency Code", "Sales Header"."Amount Including VAT", CurrExchRate.ExchangeRate(Today, "Sales Header"."Currency Code"));

            end;

            trigger OnPostDataItem();
            begin
                NUMLines := 1;
                LinesPrinted := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group("Sales Order")
                {
                    CaptionML = ENU = 'Sales Order',
                                ENG = 'Sales Order';
                    field("No. of Copies"; NoOfCopies)
                    {
                        ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea to the Action Button
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
        label(lblPayTerms; ENU = 'Payment Terms:',
                          FRA = 'Conditions Paiement',
                          ENG = 'Payment Terms:')
        label(lblShipMethod; ENU = 'Shipment Method',
                            FRA = 'Condition de Livraison',
                            ENG = 'Shipment Method')
        label(lblAmtPaid; ENU = 'Subtotal incl. VAT:',
                         FRA = 'Montant A Payer',
                         ENG = 'Subtotal incl. VAT:')
        label(lblSalesCondition; ENU = 'The Sale Conditions on the back side',
                                FRA = 'Conditions generales de vento ou envers',
                                ENG = 'The Sale Conditions on the back side')
        label(lblTotalQty; ENU = 'Total Quantity',
                          ENG = 'Total Quantity')
        label(lblSalesPerson; ENU = 'Sales Person ID:',
                             ENG = 'Sales Person ID:')
        label(lblUOM; ENU = 'Unit',
                     ENG = 'Unit')
        label(lblUnitPrice; ENU = 'Unit Price',
                           ENG = 'Unit Price')
        label(lblSaleLAmt; ENU = 'Amount Excl. VAT',
                          ENG = 'Amount Excl. VAT')
        label(lblPageNo; ENU = 'Page No:',
                        ENG = 'Page No:')
        label(lblOrderNo; ENU = 'SO Order No:',
                         ENG = 'SO Order No:')
        label(lblInvoiceNo; ENU = 'Invoice No:',
                           ENG = 'Invoice No:')
        label(lblVATAmt; ENU = 'Total VAT:',
                        ENG = 'Total VAT:')
        label(lblPostDate; ENU = 'Invoice Date:',
                          ENG = 'Invoice Date:')
        label(lblDueDate; ENU = 'Due Date:',
                         ENG = 'Due Date:')
        label(lblPriceIncVAT; ENU = 'Price Including VAT',
                             ENG = 'Price Including VAT')
        label(lblDriver; ENU = 'Name and Driver Signature',
                        ENG = 'Name and Driver Signature')
        label(lblWarehouse; ENU = 'Name and Warehouse Keeper Signature',
                           ENG = 'Name and Warehouse Keeper Signature')
        label(lblSecurity; ENU = 'Name and Security Visa',
                          ENG = 'Name and Security Visa')
        label(lblPrintDate; ENU = 'Print Date:',
                           FRA = 'Date d''impression',
                           ENG = 'Print Date:')
        label(LblBillToAddress; ENU = 'BILL TO:',
                               ENG = 'BILL TO:')
        label(LblCustomerName; ENU = 'Customer Name:',
                              ENG = 'Customer Name:')
        label(LblAddress; ENU = 'Address 1:',
                         ENG = 'Address 1:')
        label(LblAddress2; ENU = 'Address 2:',
                          ENG = 'Address 2:')
        label(LblPostCode; ENU = 'Post Code:',
                          ENG = 'Post Code:')
        label(LblCity; ENU = 'City:',
                      ENG = 'City:')
        label(LblCountry; ENU = 'Country:',
                         ENG = 'Country:')
        label(LblVatRegistrationNo; ENU = 'Vat Registration No:',
                                   ENG = 'Vat Registration No:')
        label(LblCompanyTaxId; ENU = 'Company Tax ID:',
                              ENG = 'Company Tax ID:')
        label(LblSoldToAddress; ENU = 'CUSTOMER:',
                               ENG = 'CUSTOMER:')
        label(LblCustomerPoNo; ENU = 'Customer PO No:',
                              ENG = 'Customer PO No:')
        label(LblTaxDetails; ENU = 'Tax Summary',
                            ENG = 'Tax Summary')
        label(LblBankInfo; ENU = 'Bank Details:',
                          ENG = 'Bank Details:')
        label(LblAccountNo; ENU = 'Account No:',
                           ENG = 'Account No:')
        label(LblBankName; ENU = 'Bank:',
                          ENG = 'Bank:')
        label(LblGiro; ENU = 'Giro No.',
                      ENG = 'Giro No.')
        label(LblIban; ENU = 'Iban:',
                      ENG = 'Iban:')
        label(LblSwiftCode; ENU = 'Swift Code:',
                           ENG = 'Swift Code:')
        label(LblSignature; ENU = 'Signature:',
                           ENG = 'Signature:')
        label(LblVatPercent; ENU = 'Vat Percent',
                            ENG = 'Vat Percent')
        label(LblVatAmount; ENU = 'Vat Amount',
                           ENG = 'Vat Amount')
        label(LblIncoTerm; ENU = 'InCo Terms:',
                          ENG = 'InCo Terms:')
        label(Lbldisc; ENU = 'Disc.',
                      ENG = 'Disc.')
        label(LblShipToAddress; ENU = 'SHIP TO ADDRESS:',
                               ENG = 'SHIP TO ADDRESS:')
        label(LblCustomerNo; ENU = 'Customer No:',
                            ENG = 'Customer No:')
        label(LblInvoiceCurrency; ENU = 'Invoice Currency:',
                                 ENG = 'Invoice Currency:')
        label(LblVersion; ENU = 'Version:',
                         ENG = 'Version:')
        label(LblItemNo; ENU = 'Item No.',
                        ENG = 'Item No.')
        label(LblQty; ENU = 'Qty',
                     ENG = 'Qty')
        label(LblPayMethod; ENU = 'Payment Method:',
                           ENG = 'Payment Method:')
        label(LblInvoiceCurrLCY; ENU = 'Invoice Curr LCY:',
                                ENG = 'Invoice Curr LCY:')
        label(LblTotalToBePaid; ENU = 'Total to be paid:',
                               ENG = 'Total to be paid:')
        label(LblDiscTotal; ENU = 'Disc Total:',
                           ENG = 'Disc Total:')
    }

    trigger OnInitReport();
    begin
        GLSetup.Get();
        DocSubtypeCodeSetup.GET; // BC Upgrade VAMSIU01 >>
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture, "OpCo Footer image FND", "OpCo Logo FND");
    end;

    var
        TEMPAccSchedKPIBuffer: Record "Acc. Sched. KPI Buffer";
        CompanyInfo: Record "Company Information";
        BillToCountry: Record "Country/Region";
        Country: Record "Country/Region";
        CountryInfo: Record "Country/Region";
        SoldToCountry: Record "Country/Region";
        CurrExchRate: Record "Currency Exchange Rate";
        BillToCustomer: Record Customer;
        Customer: Record Customer;
        SoldToCustomer: Record Customer;
        CustomerAttributes: Record "Customer Attributes FND";
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND"; // BC Upgrade VAMSIU01 >>
        GLSetup: Record "General Ledger Setup";
        // Language: Record Language; // BC Upgrade RAHUL Commenting As Function Moved from Table to Codeunit.
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesInvLine: Record "Sales Line";
        LanguageG: Codeunit Language;//BC UPGRADE RAHUL Adding Codeunit as Function Moved from Record to Codeunit.
        SalesInvLineAmt: Record "Sales Line";
        SalesPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        VATEntry: Record "VAT Entry";
        Check: Report Check;
        SalesInvCountPrinted: Codeunit "Sales-Printed";
        ExportInvoice: Boolean;
        ICInvoice: Boolean;
        DocLanguage: Code[10];
        CustomerNo: Code[20];
        AmttoPaid: Decimal;
        BaseMarginAmt: Decimal;
        DepAmount: Decimal;
        InvLineTotal: Decimal;
        InvTotalAmount: Decimal;
        LineDisAmount: Decimal;
        MarkupChargesAmount: Decimal;
        ShipAmount: Decimal;
        ShippingChargesAmount: Decimal;
        TaxAmout: Decimal;
        TotalAmountLCY: Decimal;
        TotalDepositFooterAmount: array[6] of Decimal;
        TotalDiscount: Decimal;
        TotalFooterAmount: array[8] of Decimal;
        TotalInvDis: Decimal;
        TotalQty: Decimal;
        VATAmount: Decimal;
        VatAmt: Decimal;
        VATPer: Decimal;
        Counter: Integer;
        lineNumberVAT: Integer;
        LinesPrinted: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        NUMLines: Integer;
        OutputNo: Integer;
        ItemCharge: Option " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        DisplayTitleHeaderType: Option Confirmation,Proforma;
        CompanyInfoContryName: Text;
        CompanyText: Text;
        OriginalCopy: Text;
        SplitVatAmount: array[10] of Text;
        SplitVatPercent: array[10] of Text;
        CopyText: Text[10];
        PriceIncVAT: Text[10];
        DocumentTitleText: Text[30];
        SubTotalExText: Text[30];
        SubTotalInText: Text[30];
        TotalExText: Text[30];
        TotalInText: Text[30];
        VATPerText: Text[30];
        CustomerName: Text[50];
        TotalDepositFooterAmountText: array[6] of Text[50];
        TotalFooterAmountText: array[7] of Text[50];
        DescriptionLine: array[2] of Text[85];
        CustomerAddress: Text[240];
        FooterText: Text[500];
        FooterText1: Text[500];
        FooterText2: Text[500];
        CustomerAttributestext: Text[1024];
        ChOfComm: TextConst ENU = 'Chamber of commerce:', ENG = 'Chamber of commerce:';
        ContactNo: TextConst ENU = 'Contact Number:', ENG = 'Contact Number:';
        EBMDateLbl: TextConst ENU = 'Date', ENG = 'Date';
        EBMDateTimeOfPrintingLbl: TextConst ENU = 'Date Time of Printing', ENG = 'Date Time of Printing';
        EBMInternalDateLbl: TextConst ENU = 'Internal Data', ENG = 'Internal Data';
        EBMInvoiceNumberLbl: TextConst ENU = 'Invoice Number', ENG = 'Invoice Number';
        EBMMRCLbl: TextConst ENU = 'MRC', ENG = 'MRC';
        EBMNotReceivedErr: TextConst ENU = 'You cannot print %1 %2 because EBM details are not received.', ENG = 'You cannot print %1 %2 because EBM details are not received.';
        EBMReceiptSignatureLbl: TextConst ENU = 'Receipt Signature', ENG = 'Receipt Signature';
        EBMSDCIDLbl: TextConst ENU = 'SDC ID', ENG = 'SDC ID';
        EBMSDCInformationLbl: TextConst ENU = 'SDC Information', ENG = 'SDC Information';
        EBMSDCReceiptNumberLbl: TextConst ENU = 'SDC Receipt Number', ENG = 'SDC Receipt Number';
        EmailComp: TextConst ENU = 'E-mail:', ENG = 'E-mail:';
        FaxNo: TextConst ENU = 'Fax Number:', ENG = 'Fax Number:';
        FooterSubText: TextConst ENU = 'Site Internet:', ENG = 'Site Internet:';
        InvalidTxt: TextConst ENU = '**INVALID WITHOUT FISCAL OR REFUND RECEIPT ATTACHED**', ENG = '**INVALID WITHOUT FISCAL OR REFUND RECEIPT ATTACHED**';
        TaxNoID: TextConst ENU = 'Tax Number ID:', ENG = 'Tax Number ID:';
        Text50001: TextConst ENU = 'Excise Duties:', FRA = 'Taxes consommations:', ENG = 'Excise Duties:';
        Text50002: TextConst ENU = 'Deposit Amount:', FRA = 'Montant Consigné:', ENG = 'Deposit Amount:';
        Text50003: TextConst ENU = 'Shipping Charges:', FRA = 'Frais de transport:', ENG = 'Shipping Charges:';
        Text50004: TextConst ENU = 'Original', FRA = 'Original', ENG = 'Original';
        Text52000: TextConst ENU = 'Copy', FRA = 'Copie', ENG = 'Copy';
        Text52001: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 HT', ENG = 'Total %1 Excl. VAT';
        Text52002: TextConst ENU = 'Total %1 Incl. VAT', FRA = 'Total %1 TTC', ENG = 'Total %1 Incl. VAT';
        Text52003: TextConst ENU = 'VAT @ %1 ', FRA = 'TVA @ %1', ENG = 'VAT @ %1 ';
        Text52004: TextConst ENU = 'Order Confirmation %1', FRA = 'Confirmation de commande %1', ENG = 'Order Confirmation %1';
        Text52004B: TextConst ENU = 'Proforma Invoice %1', FRA = 'Facture Proforma %1', ENG = 'Proforma Invoice %1';
        Text52005: TextConst ENU = 'Subtotal %1 Excl. VAT:', FRA = 'Sous-total %1 HT', ENG = 'Subtotal %1 Excl. VAT:';
        Text52005B: TextConst ENU = 'Subtotal %1 Incl. VAT:', FRA = 'Sous-total %1 TTC:', ENG = 'Subtotal %1 Incl. VAT:';
        Text52006: TextConst ENU = 'Proforma Invoice', FRA = 'Facture Proforma', ENG = 'Proforma Invoice', FRE = 'Facture Proforma';
        Text52007: TextConst ENU = 'Sundry Invoice', FRA = 'Sundry Facture', ENG = 'Sundry Invoice';
        Text52008: TextConst ENU = 'Export Invoice', FRA = 'Facture d''Export', ENG = 'Export Invoice', FRE = 'Facture d''Export';
        Text52010: TextConst ENU = 'Line Discount Amount:', FRA = 'Ligne Montant Remise', ENG = 'Line Discount Amount:';
        Text52011: TextConst ENU = 'Shippimg Amount:', FRA = 'Montant d''expédition:', ENG = 'Shippimg Amount:';
        TxtAccNo: TextConst ENU = 'Account No.:', FRA = 'No compte:', ENG = 'Account No.:';
        TxtAddress: TextConst ENU = 'Address 1:', FRA = 'Addresse 1:', ENG = 'Address 1:';
        TxtAddress2: TextConst ENU = 'Address 2:', FRA = 'Addresse 2:', ENG = 'Address 2:';
        TxtAmtPaid: TextConst ENU = 'Subtotal incl. VAT:', FRA = 'Sous Total incl.TVA:', ENG = 'Subtotal incl. VAT:';
        TxtBank: TextConst ENU = 'Bank:', FRA = 'Banque:', ENG = 'Bank:';
        TxtBankDetails: TextConst ENU = 'Bank Details:', FRA = 'Détails Banque:', ENG = 'Bank Details:';
        TxtBillToAddress: TextConst ENU = 'BILL TO:', FRA = 'ADRESSE FACTURATION:', ENG = 'BILL TO:';
        TxtCity: TextConst ENU = 'City:', FRA = 'Ville:', ENG = 'City:';
        TxtCodeSwift: TextConst ENU = 'Swift Code:', FRA = 'Code Swift:', ENG = 'Swift Code:';
        TxtCompanyTaxId: TextConst ENU = 'Company Tax ID:', FRA = 'Regime TVA:', ENG = 'Company Tax ID:';
        TxtCountry: TextConst ENU = 'Country:', FRA = 'Pays:', ENG = 'Country:';
        TxtCustomerName: TextConst ENU = 'Customer Name:', FRA = 'Nom du client:', ENG = 'Customer Name:';
        TxtCustomerNo: TextConst ENU = 'Customer No:', FRA = 'No du client:', ENG = 'Customer No:';
        TxtCustomerPoNo: TextConst ENU = 'Customer PO No:', FRA = 'No BC du client:', ENG = 'Customer PO No:';
        TxtDescrip: TextConst ENU = 'Description', FRA = 'Désignation', ENG = 'Description';
        TxtDisc: TextConst ENU = 'Disc.', FRA = 'Remise', ENG = 'Disc.';
        TxtDiscTotal: TextConst ENU = 'Discount Total:', FRA = 'Remise Total:', ENG = 'Discount Total:';
        TxtDueDate: TextConst ENU = 'Due Date:', FRA = 'Date échéance:', ENG = 'Due Date:';
        TxtIBAN: TextConst ENU = 'IBAN:', ENG = 'IBAN:';
        TxtInCoTerms: TextConst ENU = 'InCo Terms:', FRA = 'InCo Termes:', ENG = 'InCo Terms:';
        TxtInvCurr: TextConst ENU = 'Invoice Curr LCY:', FRA = 'Facture en BIF:', ENG = 'Invoice Curr LCY:';
        TxtInvoiceCurrency: TextConst ENU = 'Invoice Currency:', FRA = 'Devise facturation:', ENG = 'Invoice Currency:';
        TxtInvoiceNo: TextConst ENU = 'Invoice No:', FRA = 'No Facture:', ENG = 'Invoice No:';
        TxtItemNo: TextConst ENU = 'Item No.', FRA = 'Code article.', ENG = 'Item No.';
        TxtOrderNo: TextConst ENU = 'SO Order No:', FRA = 'No commande:', ENG = 'SO Order No:';
        TxtPageNo: TextConst ENU = 'Page No:', FRA = 'Page No:', ENG = 'Page No:';
        TxtPaymMethod: TextConst ENU = 'Payment Method:', FRA = 'Méthode Paiement:', ENG = 'Payment Method:';
        TxtPaymTerms: TextConst ENU = 'Payment Terms:', FRA = 'Délais de Paiement:', ENG = 'Payment Terms:';
        TxtPayTerms: TextConst ENU = 'Payment Terms:', FRA = 'Conditions Paiement:', ENG = 'Payment Terms:';
        TxtPostCode: TextConst ENU = 'Post Code:', FRA = 'Code postal:', ENG = 'Post Code:';
        TxtPostDate: TextConst ENU = 'Invoice Date:', FRA = 'Date Facturation:', ENG = 'Invoice Date:';
        TxtPrintDate: TextConst ENU = 'Print Date:', FRA = 'Date d''impression:', ENG = 'Print Date:';
        TxtQty: TextConst ENU = 'Qty', FRA = 'Qté', ENG = 'Qty';
        TxtSaleLAmt: TextConst ENU = 'Amount Excl. VAT', FRA = 'Montant hors TVA', ENG = 'Amount Excl. VAT';
        TxtSalesCondition: TextConst ENU = 'The Sale Conditions on the back side', FRA = 'Conditions generales de vento ou envers', ENG = 'The Sale Conditions on the back side';
        TxtSalesPerson: TextConst ENU = 'Sales Person ID:', FRA = 'Contact Commercial:', ENG = 'Sales Person ID:';
        TxtShipMethod: TextConst ENU = 'Shipment Method', FRA = 'Condition de Livraison', ENG = 'Shipment Method';
        TxtShipToAddress: TextConst ENU = 'SHIP TO ADDRESS:', FRA = 'ADRESSE LIVRAISON:', ENG = 'SHIP TO ADDRESS:';
        TxtSoldToAddress: TextConst ENU = 'CUSTOMER:', FRA = 'CLIENT:', ENG = 'CUSTOMER:';
        TxtTaxDetails: TextConst ENU = 'Tax Summary', FRA = 'Synthèse Taxes', ENG = 'Tax Summary';
        TxtTotalToBePaid: TextConst ENU = 'Total to be paid:', FRA = 'Total à payer:', ENG = 'Total to be paid:';
        TxtTTESTE: TextConst ENU = 'teste', FRA = 'des testes', ENG = 'teste';
        TxtUnitPrice: TextConst ENU = 'Unit Price', FRA = 'Prix Unitaire', ENG = 'Unit Price';
        TxtUOM: TextConst ENU = 'Unit', FRA = 'Unité', ENG = 'Unit';
        TxtVATAmt: TextConst ENU = 'Total VAT:', FRA = 'Total TVA:', ENG = 'Total VAT:';
        TxtVATPer: TextConst ENU = 'VAT Rate', FRA = 'Taux TVA', ENG = 'VAT Rate';
        TxtVatRegistrationNo: TextConst ENU = 'Vat Registration No:', FRA = 'Num. d''identif. fiscal:', ENG = 'Vat Registration No:';
        TxtVersion: TextConst ENU = 'Version:', FRA = 'Version:', ENG = 'Version:';

    local procedure SetExportICInvoice();
    begin
        ICInvoice := false;
        ExportInvoice := false;

        if Customer.Get("Sales Header"."Bill-to Customer No.") then
            if Customer."Account Group FND" in ['Y005', 'Y006', 'Y008'] then
                ICInvoice := true;

        if "Sales Header"."Document Subtype Code FND" in [DocSubtypeCodeSetup."Sundry Sales Order Non Stock", DocSubtypeCodeSetup."Sundry Sales Order Stock"] then // BC Upgrade VAMSIU01 >>
            ExportInvoice := false
        else begin
            if "Sales Header"."Ship-to Country/Region Code" = '' then begin
                ExportInvoice := false;
            end else begin
                if "Sales Header"."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" then
                    ExportInvoice := true
                else
                    ExportInvoice := false;
            end;
        end;
    end;
}

