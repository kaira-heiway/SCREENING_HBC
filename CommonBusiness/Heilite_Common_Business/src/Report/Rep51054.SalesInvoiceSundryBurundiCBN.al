report 51054 "Sales Inv Sundry Burundi CBN"
{
    // version HEI.01

    // HEI.01 Report created
    // HEI.02 Defect #5011 IBM POSTOI01 11.12.2019 # Burundi FAT
    //   #TextBox 144 field from layout, change the Text Box Properties-> Number : Decimal places = 0
    // HEI.03 CHG2069329 IBM SAMANR01 08.07.2020
    //   # Change the caption ML value for below text variable
    //   # For French i.e. for 3rd party customer, rename:
    //       Sous Total incl. TVA > Total à payer
    //       Total à payer>Total facturé
    //   # For English i.e. for Intercompany customer, rename:
    //       Subtotal incl. VAT>Total to be paid
    //       Total to be paid>Total invoiced
    //   # Rename:
    //       Taxes Consommations>Autres Taxes
    //       Excise Duties>Other Taxes
    //*****************************************************************************
    //BC UPGRADE PATHAA02-18-12-25
    //Code conditions related DIT fields are commented but need to uncomment back once Aptean Ext/Code is merged.
    //LanguageG.GetLanguageId function moved to CU-Language from Table-Language

    DefaultLayout = RDLC;
    //RDLCLayout = '.\src\Sales Invoice - Sundry Burundi.rdl';BC UPGRADE PATHAA02 
    RDLCLayout = '.\src\Reportslayout\Sales Invoice - Sundry Burundi.rdl';//BC UPGRADE PATHAA02 

    CaptionML = ENU = 'Sales Invoice - Sundry Burundi',
                FRA = 'Facture Vente - Sundry Burundi',
                ENG = 'Sales Invoice - Sundry Burundi';
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(SalesHDocNo; "Sales Invoice Header"."No.")
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
            column(CompanyInfo_OpCoFooter; CompanyInfo."OpCo Footer image FND")
            {
            }
            column(CompanyText; CompanyText)
            {
            }
            column(GeneralOpCoSetup_BankName3; GeneralOpCoSetup."Bank Name 3")
            {
            }
            column(GeneralOpCoSetup_BankAcc3; GeneralOpCoSetup."Bank Account No. 3")
            {
            }
            column(GeneralOpCoSetup_IBAN3; GeneralOpCoSetup."IBAN 3")
            {
            }
            column(GeneralOpCoSetup_Swift3; GeneralOpCoSetup."SWIFT Code 3")
            {
            }
            column(GeneralOpCoSetup_InvoiceType3; GeneralOpCoSetup."Report Invoice Type 3")
            {
            }
            column(Show_BankDetails3; (GeneralOpCoSetup."Report Invoice Type 3" = GeneralOpCoSetup."Report Invoice Type 3"::Sundry) and (GeneralOpCoSetup."Bank Account No. 3" <> ''))
            {
            }
            column(GeneralOpCoSetup_BankName4; GeneralOpCoSetup."Bank Name 4")
            {
            }
            column(GeneralOpCoSetup_BankAcc4; GeneralOpCoSetup."Bank Account No. 4")
            {
            }
            column(GeneralOpCoSetup_IBAN4; GeneralOpCoSetup."IBAN 4")
            {
            }
            column(GeneralOpCoSetup_Swift4; GeneralOpCoSetup."SWIFT Code 4")
            {
            }
            column(GeneralOpCoSetup_InvoiceType4; GeneralOpCoSetup."Report Invoice Type 4")
            {
            }
            column(Show_BankDetails4; (GeneralOpCoSetup."Report Invoice Type 4" = GeneralOpCoSetup."Report Invoice Type 4"::Sundry) and (GeneralOpCoSetup."Bank Account No. 4" <> ''))
            {
            }
            column(GeneralOpCoSetup_BankName5; GeneralOpCoSetup."Bank Name 5")
            {
            }
            column(GeneralOpCoSetup_BankAcc5; GeneralOpCoSetup."Bank Account No. 5")
            {
            }
            column(GeneralOpCoSetup_IBAN5; GeneralOpCoSetup."IBAN 5")
            {
            }
            column(GeneralOpCoSetup_Swift5; GeneralOpCoSetup."SWIFT Code 5")
            {
            }
            column(GeneralOpCoSetup_InvoiceType5; GeneralOpCoSetup."Report Invoice Type 5")
            {
            }
            column(Show_BankDetails5; (GeneralOpCoSetup."Report Invoice Type 5" = GeneralOpCoSetup."Report Invoice Type 5"::Sundry) and (GeneralOpCoSetup."Bank Account No. 5" <> ''))
            {
            }
            column(GeneralOpCoSetup_BankName6; GeneralOpCoSetup."Bank Name 6")
            {
            }
            column(GeneralOpCoSetup_BankAcc6; GeneralOpCoSetup."Bank Account No. 6")
            {
            }
            column(GeneralOpCoSetup_IBAN6; GeneralOpCoSetup."IBAN 6")
            {
            }
            column(GeneralOpCoSetup_Swift6; GeneralOpCoSetup."SWIFT Code 6")
            {
            }
            column(GeneralOpCoSetup_InvoiceType6; GeneralOpCoSetup."Report Invoice Type 6")
            {
            }
            column(Show_BankDetails6; (GeneralOpCoSetup."Report Invoice Type 6" = GeneralOpCoSetup."Report Invoice Type 6"::Sundry) and (GeneralOpCoSetup."Bank Account No. 6" <> ''))
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
            column(TxtInvCurrency; TxtInvCurrency)
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
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = CONST(1));
                    column(CustomerAttributestext; CustomerAttributestext)
                    {
                    }
                    column(OrderConfirmCopyCaption; DocumentTitleText)
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
                    column(SalesPersonCode; "Sales Invoice Header"."Salesperson Code")
                    {
                    }
                    column(OutputNo; OutputNo)
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
                    column(SubTotal; ROUND(InvLineTotal, 0.01, '='))
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
                    column(SalesInvHeader_BillToName; "Sales Invoice Header"."Bill-to Name")
                    {
                    }
                    column(SalesInvHeader_BillToPostCode; "Sales Invoice Header"."Bill-to Post Code")
                    {
                    }
                    column(SalesInvHeader_BillToCity; "Sales Invoice Header"."Bill-to City")
                    {
                    }
                    column(BillToVatRegNo; BillToCustomer."VAT Registration No.")
                    {
                    }
                    column(BillToCountryName; BillToCountry.Name)
                    {
                    }
                    column(SalesInvHeader_SellToName; "Sales Invoice Header"."Sell-to Customer Name")
                    {
                    }
                    column(SalesInvHeader_SellToCity; "Sales Invoice Header"."Sell-to City")
                    {
                    }
                    column(SalesInvHeader_SellToPostCode; "Sales Invoice Header"."Sell-to Post Code")
                    {
                    }
                    column(SellToCountryName; SoldToCountry.Name)
                    {
                    }
                    column(SellToVatRegNo; SoldToCustomer."VAT Registration No.")
                    {
                    }
                    column(SalesInvHeader_BillToAddress; "Sales Invoice Header"."Bill-to Address")
                    {
                    }
                    column(SalesInvHeader_BillToAddress2; "Sales Invoice Header"."Bill-to Address 2")
                    {
                    }
                    column(SalesInvHeader_SellToAddress; "Sales Invoice Header"."Sell-to Address")
                    {
                    }
                    column(SalesInvHeader_SellToAddress2; "Sales Invoice Header"."Sell-to Address 2")
                    {
                    }
                    column(SalesInvHeader_ShipToName; "Sales Invoice Header"."Ship-to Name")
                    {
                    }
                    column(SalesInvHeader_Address; "Sales Invoice Header"."Ship-to Address")
                    {
                    }
                    column(SalesInvHeader_Address2; "Sales Invoice Header"."Ship-to Address 2")
                    {
                    }
                    column(SalesInvHeader_City; "Sales Invoice Header"."Ship-to City")
                    {
                    }
                    column(SellCustomerNo; "Sales Invoice Header"."Sell-to Customer No.")
                    {
                    }
                    column(CurrencyCode; "Sales Invoice Header"."Currency Code")
                    {
                    }
                    column(InvalidTxt; InvalidTxt)
                    {
                    }
                    column(TotalInvDis; -TotalInvDis)
                    {
                    }
                    column(TotalAmountLCY; TotalAmountLCY)
                    {
                    }
                    column(InCoTerms; "Sales Invoice Header"."InCo Terms FND")
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting("Document No.", "Line No.") where(Type = FILTER(Item | Resource | "Fixed Asset"));
                        column(SalesLType; "Sales Invoice Line".Type)
                        {
                        }
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
                        column(SalesUOM; "Sales Invoice Line"."Unit of Measure Code")
                        {
                        }
                        column(SalesPrice; ROUND("Sales Invoice Line"."Unit Price", 1, '='))
                        {
                        }
                        column(SalesVATPer; "Sales Invoice Line"."VAT %")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesAmount; "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price")
                        {
                        }
                        column(TotalQuantity; TotalQty)
                        {
                        }
                        column(SalesDiscount; "Sales Invoice Line"."Line Discount Amount")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;

                            TotalInvDis += "Sales Invoice Line"."Line Discount Amount";
                        end;
                    }
                    dataitem(SplitVatAmt; "Integer")
                    {
                        column(TEMPAccSchedKPIBuffer_VatPercent; FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast"))
                        {
                        }
                        column(TEMPAccSchedKPIBuffer_VatAmount; TEMPAccSchedKPIBuffer."Net Change Budget")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not TEMPAccSchedKPIBuffer.FIND('-') then
                                    CurrReport.BREAK();
                            end else
                                if TEMPAccSchedKPIBuffer.NEXT() = 0 then
                                    CurrReport.BREAK();
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(Number, 1, TEMPAccSchedKPIBuffer.COUNT);
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        CLEAR(TotalFooterAmount);
                        CLEAR(TotalFooterAmountText);
                        CLEAR(InvTotalAmount);
                        CLEAR(AmttoPaid);
                        CLEAR(TotalInvDis);

                        DocumentTitleText := STRSUBSTNO(Text52007, CopyText);

                        SalesInvLineAmt.RESET();
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLineAmt.SETFILTER(Type, '%1|%2|%3|%4', SalesInvLineAmt.Type::Item, SalesInvLineAmt.Type::Resource, SalesInvLineAmt.Type::"Fixed Asset", SalesInvLineAmt.Type::"Charge (Item)");
                        if SalesInvLineAmt.findset() then
                            repeat

                            //BC UPGRADE PATHAA02-DIT fields-code commented>>
                            /*

                                if not ((SalesInvLineAmt.Type = SalesInvLineAmt.Type::"Charge (Item)") and (SalesInvLineAmt."Item Charge Type" <> SalesInvLineAmt."Item Charge Type"::Discount)) then
                                    if (SalesInvLineAmt."Item Charge Type" <> SalesInvLineAmt."Item Charge Type"::"Shipping Cost") and
                                     not (((SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::Discount) and (SalesInvLineAmt."No." = 'S_SHIP') and
                                     (SalesInvLineAmt."Show Item charge on Invoice" = SalesInvLineAmt."Show Item charge on Invoice"::"Order total"))) then   //HEI.03
                                        InvLineTotal += SalesInvLineAmt.Amount; //HEI.03

                            //HEI.03 InvLineTotal += SalesInvLineAmt."Line Amount";
                            */
                            //BC UPGRADE PATHAA02-DIT fields-code commented<<

                            until SalesInvLineAmt.NEXT() = 0;

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        if SalesInvLine.findset() then
                            repeat
                            //BC UPGRADE PATHAA02-DIT("Item Charge Type")-Code commented>>
                            /*
                            case SalesInvLine."Item Charge Type" of
                                SalesInvLine."Item Charge Type"::Tax:
                                    begin
                                        TotalFooterAmount[1] += SalesInvLine.Amount;  //HEI.03

                                    end;
                                SalesInvLine."Item Charge Type"::Deposit:
                                    begin
                                        TotalFooterAmount[2] += SalesInvLine."Line Amount";

                                    end;
                                SalesInvLine."Item Charge Type"::"Shipping Cost":
                                    begin
                                        TotalFooterAmount[3] += SalesInvLine.Amount; //HEI.03
                                        TotalFooterAmountText[3] := Text52011;
                                    end;
                                SalesInvLine."Item Charge Type"::Discount:
                                    begin
                                        TotalInvDis += SalesInvLine."Line Amount";
                                        if SalesInvLine."No." = 'S_MARKUP' then begin
                                            TotalFooterAmount[5] += SalesInvLine.Amount; //HEI.03
                                            TotalFooterAmountText[5] := 'Markup Charges:';


                                        end;

                                        if SalesInvLine."No." = 'A1.PPR' then begin
                                            TotalFooterAmount[7] += SalesInvLine.Amount; //HEI.03
                                            TotalFooterAmountText[7] := 'Base Margin PPR:';
                                        end;

                                        if SalesInvLine."No." = 'S_SHIP' then begin
                                            TotalFooterAmount[6] += SalesInvLine.Amount; //HEI.03
                                        end;
                                    end;
                            end;
                            */
                            //BC UPGRADE PATHAA02-DIT("Item Charge Type")-Code commented<<
                            until SalesInvLine.NEXT() = 0;


                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];

                        ShippingChargesAmount := TotalFooterAmount[6];
                        MarkupChargesAmount := TotalFooterAmount[5];
                        BaseMarginAmt := TotalFooterAmount[7];

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        if SalesInvLine.findset() then
                            repeat
                                TotalFooterAmount[4] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[4] := Text52010;
                            until SalesInvLine.NEXT() = 0;

                        LineDisAmount := TotalFooterAmount[4];



                        AmttoPaid := InvLineTotal + VatAmt + TotalFooterAmount[1] + VatAmt + TotalFooterAmount[5] + TotalFooterAmount[6] - VatAmt + TotalFooterAmount[4];
                        InvTotalAmount := AmttoPaid + TotalFooterAmount[2];
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then
                        CopyText := Text52000;
                    CurrReport.PAGENO := 1;
                    OutputNo := OutputNo + 1;

                    CLEAR(TotalFooterAmount);
                    CLEAR(TotalFooterAmountText);
                    CLEAR(InvTotalAmount);
                    CLEAR(AmttoPaid);
                    CLEAR(TotalInvDis);
                    CLEAR(InvLineTotal);
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
                end;
            }

            trigger OnAfterGetRecord();
            begin

                //Company Text
                CLEAR(CompanyText);
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
                    if CountryInfo.GET(CompanyInfo."Country/Region Code") then
                        CompanyText += ', ' + CompanyInfo."Country/Region Code" + ' ' + CountryInfo.Name;
                //BC UPGRADE PATHAA02-DIT>>
                // if CompanyInfo."Tax Registration No." <> '' then
                //     CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                //BC UPGRADE PATHAA02-DIT<<

                if CompanyInfo."Phone No." <> '' then
                    CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                if CompanyInfo."Fax No." <> '' then
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                if CompanyInfo."E-Mail" <> '' then
                    CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";


                TEMPAccSchedKPIBuffer.DELETEALL();
                if Country.GET(CompanyInfo."Country/Region Code") then
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

                //CurrReport.LANGUAGE := Language.GetLanguageID(DocLanguage);//BC UPGRADE PATHAA02
                CurrReport.LANGUAGE := LanguageG.GetLanguageID(DocLanguage);//BC UPGRADE PATHAA02

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
                if SalesPerson.GET("Sales Invoice Header"."Salesperson Code") then;

                if ShipmentMethod.GET("Sales Invoice Header"."Shipment Method Code") then
                    ShipmentMethod.TranslateDescription(ShipmentMethod, DocLanguage);

                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, DocLanguage);

                PaymentMethod.RESET();
                if PaymentMethod.GET("Payment Method Code") then;

                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalExText := STRSUBSTNO(Text52001, GLSetup."LCY Code");
                    TotalInText := STRSUBSTNO(Text52002, GLSetup."LCY Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := STRSUBSTNO(Text52005, GLSetup."LCY Code");
                end else begin
                    TotalExText := STRSUBSTNO(Text52001, "Currency Code");
                    TotalInText := STRSUBSTNO(Text52002, "Currency Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, "Currency Code");
                    SubTotalExText := STRSUBSTNO(Text52005, "Currency Code");
                end;


                CustomerNo := '';
                CustomerName := '';
                CustomerAddress := '';
                if Customer.GET("Sales Invoice Header"."Bill-to Customer No.") then begin
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

                CLEAR(CustomerAttributestext);
                if CustomerAttributes.GET("Sales Invoice Header"."Bill-to Customer No.") then begin
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


                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.FINDFIRST() then
                    VATPer := SalesInvLine."VAT %";

                if "Sales Invoice Header"."Prices Including VAT" = true then
                    PriceIncVAT := 'Yes'
                else
                    PriceIncVAT := 'No';

                VatAmt := 0;
                lineNumberVAT := 0;
                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.findset() then
                    repeat
                        VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                        VATAmount := ABS(VatAmt);


                        TEMPAccSchedKPIBuffer.RESET();
                        TEMPAccSchedKPIBuffer.SETRANGE("Balance at Date Forecast", SalesInvLine."VAT %");
                        if TEMPAccSchedKPIBuffer.FINDFIRST() then begin

                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.MODIFY();
                        end else begin

                            lineNumberVAT += 1;
                            TEMPAccSchedKPIBuffer.INIT();
                            TEMPAccSchedKPIBuffer."No." := lineNumberVAT;
                            TEMPAccSchedKPIBuffer."Balance at Date Forecast" := SalesInvLine."VAT %";

                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.INSERT();
                        end;
                    until SalesInvLine.NEXT() = 0;

                TEMPAccSchedKPIBuffer.RESET();
                if TEMPAccSchedKPIBuffer.findset() then
                    repeat
                        Counter += 1;

                        SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%';
                        SplitVatAmount[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Net Change Budget", 0, '<Sign><Integer Thousand><Decimals,3>');
                    until TEMPAccSchedKPIBuffer.NEXT() = 0;

                BillToCustomer.GET("Sales Invoice Header"."Bill-to Customer No.");
                SoldToCustomer.GET("Sales Invoice Header"."Sell-to Customer No.");
                if BillToCountry.GET(BillToCustomer."Country/Region Code") then;
                if SoldToCountry.GET(SoldToCustomer."Country/Region Code") then;

                if "Sales Invoice Header"."No. Printed" = 0 then
                    OriginalCopy := Text50004
                else
                    OriginalCopy := Text52000;

                "Sales Invoice Header".CALCFIELDS("Amount Including VAT");
                TotalAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(TODAY, "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Amount Including VAT", CurrExchRate.ExchangeRate(TODAY, "Sales Invoice Header"."Currency Code"));

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
            area(content)
            {
                group("Sales Order")
                {
                    CaptionML = ENU = 'Sales Order',
                                ENG = 'Sales Order';
                    field("No. of Copies"; NoOfCopies)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the NoOfCopies field.';
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
                               FRA = 'Net a payer:',
                               ENG = 'Total to be paid:')
        label(LblDiscTotal; ENU = 'Disc Total:',
                           ENG = 'Disc Total:')
        label(BankInfo2Lbl; ENU = 'Bank Details 2:',
                           ENG = 'Bank Details 2:')
        label(BankInfo3Lbl; ENU = 'Bank Details 3:',
                           ENG = 'Bank Details 3:')
        label(BankInfo4Lbl; ENU = 'Bank Details 4:',
                           ENG = 'Bank Details 4:')
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        DocSubtypeCodeSetup.GET(); //BC UPGRADE SHUKLP03
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND", "OpCo Logo FND");
        GeneralOpCoSetup.GET();
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
        GLSetup: Record "General Ledger Setup";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvLineAmt: Record "Sales Invoice Line";
        SalesPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        VATEntry: Record "VAT Entry";
        //Language: Record Language; //BC UPGRADE PATHAA02
        LanguageG: Codeunit Language; //BC UPGRADE PATHAA02
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
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
        TotalFooterAmount: array[7] of Decimal;
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
        Text50001: TextConst ENU = 'Other Taxes:', FRA = 'Autres Taxes:', ENG = 'Other Taxes:';
        Text50002: TextConst ENU = 'Deposit Amount:', FRA = 'Montant Consigné:', ENG = 'Deposit Amount:';
        Text50003: TextConst ENU = 'Shipping Charges:', FRA = 'Frais de transport:', ENG = 'Shipping Charges:';
        Text50004: TextConst ENU = 'Original', FRA = 'Original', ENG = 'Original';
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND"; //BC UPGRADE SHUKLP03 <<
        Text52000: TextConst ENU = 'Copy', FRA = 'Copie', ENG = 'Copy';
        Text52001: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 HT', ENG = 'Total %1 Excl. VAT';
        Text52002: TextConst ENU = 'Total %1 Incl. VAT', FRA = 'Total %1 TTC', ENG = 'Total %1 Incl. VAT';
        Text52003: TextConst ENU = 'VAT @ %1 ', FRA = 'TVA @ %1', ENG = 'VAT @ %1 ';
        Text52004: TextConst ENU = 'Order Confirmation %1', FRA = 'Confirmation de commande %1', ENG = 'Order Confirmation %1';
        Text52004B: TextConst ENU = 'Proforma Invoice %1', FRA = 'Facture Proforma %1', ENG = 'Proforma Invoice %1';
        Text52005: TextConst ENU = 'Subtotal %1 Excl. VAT:', FRA = 'Sous-total %1 HT', ENG = 'Subtotal %1 Excl. VAT:';
        Text52005B: TextConst ENU = 'Subtotal %1 Incl. VAT:', FRA = 'Sous-total %1 TTC:', ENG = 'Subtotal %1 Incl. VAT:';
        Text52006: TextConst ENU = 'Sales Invoice', FRA = 'Facture Vente', ENG = 'Sales Invoice', FRE = 'Facture Vente';
        Text52007: TextConst ENU = 'Sundry Invoice', FRA = 'Sundry Facture', ENG = 'Sundry Invoice';
        Text52008: TextConst ENU = 'Export Invoice', FRA = 'Facture d''Export', ENG = 'Export Invoice', FRE = 'Facture d''Export';
        Text52010: TextConst ENU = 'Line Discount Amount:', FRA = 'Ligne Montant Remise', ENG = 'Line Discount Amount:';
        Text52011: TextConst ENU = 'Shippimg Amount:', FRA = 'Montant d''expédition:', ENG = 'Shippimg Amount:';
        TxtAccNo: TextConst ENU = 'Account No.:', FRA = 'No compte:', ENG = 'Account No.:';
        TxtAddress: TextConst ENU = 'Address 1:', FRA = 'Addresse 1:', ENG = 'Address 1:';
        TxtAddress2: TextConst ENU = 'Address 2:', FRA = 'Addresse 2:', ENG = 'Address 2:';
        TxtAmtPaid: TextConst ENU = 'Total to be paid:', FRA = 'Total à payer:', ENG = 'Total to be paid:';
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
        TxtInvCurrency: TextConst ENU = 'Invoice Currency:', FRA = 'Devise facturation:', ENG = 'Invoice Currency:';
        TxtInvoiceCurrency: TextConst ENU = 'Amount in BIF:', FRA = 'Montant en BIF:', ENG = 'Amount in BIF:';
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
        TxtTotalToBePaid: TextConst ENU = 'Total invoiced:', FRA = 'Total facturé:', ENG = 'Total invoiced:';
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

        if Customer.GET("Sales Invoice Header"."Bill-to Customer No.") then
            if Customer."Account Group FND" in ['Y005', 'Y006', 'Y008'] then
                ICInvoice := true;
        //BC UPGRADE SHUKLP03 >> (DocSubtypeCodeSetup,"Document Subtype Code")
        if "Sales Invoice Header"."Document Subtype Code FND" in [DocSubtypeCodeSetup."Sundry Sales Order Non Stock", DocSubtypeCodeSetup."Sundry Sales Order Stock"] then
            ExportInvoice := false
        else begin
            if "Sales Invoice Header"."Ship-to Country/Region Code" = '' then begin
                ExportInvoice := false;
            end else begin
                if "Sales Invoice Header"."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" then
                    ExportInvoice := true
                else
                    ExportInvoice := false;
            end;
        end;
        //BC UPGRADE SHUKLP03 << (DocSubtypeCodeSetup,"Document Subtype Code")
    end;
}

