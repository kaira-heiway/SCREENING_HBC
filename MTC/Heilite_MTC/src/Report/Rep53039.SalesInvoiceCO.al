report 53039 "Sales Invoice CO"
{
    // version HEI.11

    // HEI.01 Report created
    // HEI.03 INC1003205 IBM HORTOC01 04.12.2018 #add new item charge discount
    // HEI.04 HT434 CHG2011093 Defect # 4329 IBM GAVANM01 20.08.2019
    //   # add OpCo footer image
    // HEI.05 CHG2031911 Defect # 4329 IBM GAVANM01 19.09.2019  # add info in footer from Company Info
    // HEI.06 IBM SURYAS01  20.09.2019  # Commented code in order to aviod the Overflow error when trying to Preview the report.
    // HEI.07 FDD-HT915 IBM NASTAA02 27.09.2019 # OtC Billing – Invoice Layout local requirements for Domestic Invoice/Credit Memo/Sundry, and Export Invoice
    //   # Added 3 new Bank Accounts
    // HEI.08 IBM BULIMC01 25.10.2019 # defect 4627 # code added
    //    #new variable created (lineNumberVAT)
    //    # data item TEMPAccSchedKPIBuffer_VatPercent changed
    // HEI.09 IBM SURYAS01 9/12/2019 #defect 4448
    //   # Modified the below field values in Report Layout
    //   #"SubTotalExcText","@lblVATAmt","@lblAmtPaid",@LblTotalToBePaid
    // HEI.10 CHG2062657 HB1368 IBM GAVANM01 29.04.2020 #Correction to Invoice/Credit Note - Shipping Charge
    //   # code and layout changes
    // HEI.11 INC2918336 IBM NASTAA02 29.06.2020 # Printing multiple invoices
    //   # Implemented SetData, GetData functions on layout for the header text boxes
    // HEI.12 CHG2070324 IBM.GUNERE01 02.07.2020 # modifications on layout, DataSource SalesDiscount1 modified,
    //                                            PageLoop - OnAfterGetRecord, Sales Invoice Line - OnAfterGetRecord funcs.
    //                                            modified.
    // HEI.13 CHG2072833 IBM.MONTAU01 23.07.2020 #modify data shown in duedate field
    // HEI.14 CHG2070787 IBM GAVANM01 02.09.2020 Update all Billing documents in line with Global (for the BAHAMAS)
    //   # Add Standard Text Report functionality for footer texts
    // HEI.15 CHG2073371 HB1589 IBM GAVANM01 28.09.2020  #St Lucia Item charges Shipping Cost not working
    //   # Item charges of type Discount and Transport/Shipping Cost = TRUE should be considered as Shipping Cost
    // -------------------------------------------------------------------------------------------------------------------
    // 
    // HEI.16 CHG2105027 HT1226 IBM GAVANM01 12.05.2021 #Sales Documents Brasco
    //   #new report, copied from ID 50265
    //*********************************************//
    //BC UPGRADE ATHUKS01//
    //1.HEI.04,HEI.05,HEI.06 No changes
    //2.HEI.08 Commented drink IT code.
    //3.HEI.10,HEI.11,HEI.12,HEI.14,HEI.15 Commented drink IT code.
    //4.Change Language to LanguageMgt and record to codeunit for getting Language.
    //5.CurrReport.PAGENO is deprecated and unsupported in modern Business Central (AL language) RDLC ,often returning a constant value of 1 or causing compilation warnings.
    //6.Old Report ID 50513
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Sales Invoice CO.rdl';

    Caption = 'Sales Invoice CO';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
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
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_BankAccNo; BankAccountNo)
            {
            }
            column(CompanyInfo_BankName; BankName)
            {
            }
            column(CompanyInfo_Giro; CompanyInfo."Giro No.")
            {
            }
            column(CompanyInfo_Iban; IBAN)
            {
            }
            column(CompanyInfo_swiftCode; SWIFTCode)
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
            column(DepositOnTheNetPrice; GeneralOpCoSetup."Deposit% on the net price")
            {
            }
            column(ExportInvoice; ExportInvoice)
            {
            }
            column(CompanyInfo_OpCoFooter; CompanyInfo."OpCo Footer image FND")
            {
            }


            column(CompanyText; CompanyText)
            {
            }
            //BC UPGRADE ATHUKS01 >>  Drink IT field 
            // column(CompanyInfo_BankName2; CompanyInfo."Bank Name 2")
            // {
            // }
            // column(CompanyInfo_BankAcc2; CompanyInfo."Bank Account No. 2")
            // {
            // }
            // column(CompanyInfo_IBAN2; CompanyInfo."IBAN 2")
            // {
            // }
            // column(CompanyInfo_Swift2; CompanyInfo."SWIFT Code 2")
            // {
            // }
            column(CompanyInfo_BankName2; '')
            {
            }
            column(CompanyInfo_BankAcc2; '')
            {
            }
            column(CompanyInfo_IBAN2; '')
            {
            }
            column(CompanyInfo_Swift2; '')
            {
            }
            //BC UPGRADE ATHUKS01 <<  Drink IT field 
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
            column(Show_BankDetails3; (GeneralOpCoSetup."Report Invoice Type 3" = GeneralOpCoSetup."Report Invoice Type 3"::Invoice) and (GeneralOpCoSetup."Bank Account No. 3" <> ''))
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
            column(Show_BankDetails4; (GeneralOpCoSetup."Report Invoice Type 4" = GeneralOpCoSetup."Report Invoice Type 4"::Invoice) and (GeneralOpCoSetup."Bank Account No. 4" <> ''))
            {
            }
            column(CompanyFooter1; TextFooter[1])
            {
            }
            column(CompanyFooter2; TextFooter[2])
            {
            }
            column(CompanyFooter3; TextFooter[3])
            {
            }
            column(CurrencyCode; CurrencyCode)
            {
            }
            column(CustomerServiceEmail; SalesSetup."Customer Service E-Mail FND")
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
            column(TxtVATAmt; TxtVATAmt)
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
            column(TxtCountry; TxtCountry)
            {
            }
            column(TxtCity; TxtCity)
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
            column(TxtTaxDetails; TxtTaxDetails)
            {
            }
            column(TxtBankInfo; TxtBankInfo)
            {
            }
            column(TxtAccountNo; TxtAccountNo)
            {
            }
            column(TxtBankName; TxtBankName)
            {
            }
            column(TxtIban; TxtIban)
            {
            }
            column(TxtSwiftCode; TxtSwiftCode)
            {
            }
            column(TxtVatPercent; TxtVatPercent)
            {
            }
            column(TxtVatAmount; TxtVatAmount)
            {
            }
            column(Txtdisc; Txtdisc)
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
            column(TxtPayMethod; TxtPayMethod)
            {
            }
            column(TxtInvoiceCurrLCY; TxtInvoiceCurrLCY)
            {
            }
            column(TxtTotalToBePaid; TxtTotalToBePaid)
            {
            }
            column(TxtDiscTotal; TxtDiscTotal)
            {
            }
            column(TxtGrossWeight; TxtGrossWeight)
            {
            }
            column(TxtNetWeight; TxtNetWeight)
            {
            }
            column(TxtBillOfLadingNo; TxtBillOfLadingNo)
            {
            }
            column(TxtVesselName; TxtVesselName)
            {
            }
            column(TxtCommodityCode; TxtCommodityCode)
            {
            }
            column(TxtCustomTariffCode; TxtCustomTariffCode)
            {
            }
            column(TxtQtyCrates; TxtQtyCrates)
            {
            }
            column(TxtRate; TxtRate)
            {
            }
            column(TxtBaseAmnt; TxtBaseAmnt)
            {
            }
            column(TxtSubTotalExclVAT; TxtSubTotalExclVAT)
            {
            }
            column(TxtElectStamp; TxtElectStamp)
            {
            }
            column(TxtCAD; TxtCAD)
            {
            }
            column(TxtDeposit; TxtDeposit)
            {
            }
            column(TxtDepositVAT; TxtDepositVAT)
            {
            }
            column(TxtDepositCAD; TxtDepositCAD)
            {
            }
            column(TxtDiscLine; TxtDiscLine)
            {
            }
            column(TxtIncoTerm; TxtIncoTerm)
            {
            }
            column(TxtASDI; TxtASDI)
            {
            }
            column(TxtTSB; TxtTSB)
            {
            }
            column(TxtDescription; TxtDescription)
            {
            }
            column(FooterText2; FooterText2)
            {
            }
            column(LCY; LCY)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
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
                    column(PrintDate; FORMAT(TODAY, 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
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
                    //BC UPGRADE ATHUKS01 >>  Drink IT field 
                    // column(BillToTaxRegNo; BillToCustomer."Tax Registration No.")
                    // {
                    // }
                    column(BillToTaxRegNo; '')
                    {
                    }
                    //BC UPGRADE ATHUKS01 <<  Drink IT field 
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
                    //BC UPGRADE ATHUKS01 >>  Drink IT field 
                    // column(SellToTaxRegNo; SoldToCustomer."Tax Registration No.")
                    // {
                    // }
                    column(SellToTaxRegNo; '')
                    {
                    }
                    //BC UPGRADE ATHUKS01 <<  Drink IT field 
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
                    column(InvalidTxt; InvalidTxt)
                    {
                    }
                    column(TotalAmountLCY; TotalAmountLCY)
                    {
                    }
                    column(InCoTerms; "Sales Invoice Header"."InCo Terms FND")
                    {
                    }
                    column(SubTotalCharges; SubTotalCharges)
                    {
                    }
                    column(BillOfLadingNo; "Sales Invoice Header"."Bill Of Lading No. FND")
                    {
                    }
                    column(VesselName; "Sales Invoice Header"."Vessel Name FND")
                    {
                    }
                    column(ETD; "Sales Invoice Header"."ETD FND")
                    {
                    }
                    column(ETA; "Sales Invoice Header"."ETA FND")
                    {
                    }
                    column(AirWayBillNo; "Sales Invoice Header"."Air Way Bill No FND")
                    {
                    }
                    column(CommodityCode; "Sales Invoice Header"."Commodity Code FND")
                    {
                    }
                    column(CustomTariffCode; "Sales Invoice Header"."Custom Tariff Code FND")
                    {
                    }
                    column(TotalGrossWeight; TotalGrossWeight)
                    {
                    }
                    column(TotalNetWeight; TotalNetWeight)
                    {
                    }
                    column(InvDisAmount; InvDisAmount)
                    {
                    }
                    column(QuantityCrates; QuantityCrates)
                    {
                    }
                    column(DescriptionLine2; DescriptionLine[2])
                    {
                    }
                    column(DescriptionLine1; DescriptionLine[1])
                    {
                    }
                    column(ASDIAmount; ASDIAmount)
                    {
                    }
                    column(TSBAmount; TSBAmount)
                    {
                    }
                    column(ASDIAmountDisplayed; ASDIAmountDisplayed)
                    {
                    }
                    column(TSBAmountDisplayed; TSBAmountDisplayed)
                    {
                    }
                    column(VATDeposit; VATDeposit)
                    {
                    }
                    column(VATProduct; VATProduct)
                    {
                    }
                    column(VATProductDisplayed; VATProductDisplayed)
                    {
                    }
                    column(TimbreAmount; TimbreAmount)
                    {
                    }
                    column(TimbreAmountDisplayed; TimbreAmountDisplayed)
                    {
                    }
                    column(CADProduit; CADProduit)
                    {
                    }
                    column(CADDeposit; CADDeposit)
                    {
                    }
                    column(TaxAmountDisplayed; TaxAmoutDisplayed)
                    {
                    }
                    column(ShippingAmountDisplayed; ShipAmountDisplayed)
                    {
                    }
                    column(InvDisAmountDisplayed; InvDisAmountDisplayed)
                    {
                    }
                    column(CADProduitDisplayed; CADProduitDisplayed)
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = filter(Item | Resource | "Fixed Asset" | "Charge (Item)" | "G/L Account"));
                        column(type; Var_typechargeItem)
                        {
                        }
                        column(itemDeposit; itemDeposit)
                        {
                        }
                        column(IsDisount; IsDiscount)
                        {
                        }
                        column(SalesLineNo; "Sales Invoice Line"."Line No.")
                        {
                        }
                        column(IsDeposit; IsDeposit)
                        {
                        }
                        column(IsNotUnderitem; IsNotUnderitem)
                        {
                        }
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
                        column(SalesPrice; UnitPrice)
                        {
                        }
                        column(SalesVATPer; "Sales Invoice Line"."VAT %")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesAmount; LineAmount)
                        {
                        }
                        column(TotalQuantity; TotalQty)
                        {
                        }
                        column(SalesDiscount; ItemDiscount)
                        {
                        }
                        column(SalesDiscount1; var_Dis)
                        {
                        }
                        column(TotalInvDis; TotalInvDis + ItemDiscount)
                        {
                        }
                        column(PrintUnderLineCharge; PrintUnderLineCharge)
                        {
                        }
                        column(DiscIncluded; DiscIncluded)
                        {
                        }
                        dataitem(UnderLineCharges; "Integer")
                        {
                            column(No_TempUnderChargeLine; TempUnderChargeLine."No.")
                            {
                                IncludeCaption = true;
                            }
                            column(Description_TempUnderChargeLine; TempUnderChargeLine.Description)
                            {
                                IncludeCaption = true;
                            }
                            column(Quantity_TempUnderChargeLine; TempUnderChargeLine.Quantity)
                            {
                                IncludeCaption = true;
                            }
                            column(UnitPrice_TempUnderChargeLine; TempUnderChargeLine."Unit Price")
                            {
                            }
                            column(VATIdentifier_TempUnderChargeLine; TempUnderChargeLine."VAT Identifier")
                            {
                            }
                            column(LineAmount_TempUnderChargeLine; TempUnderChargeLine."Line Amount")
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then
                                    TempUnderChargeLine.FINDFIRST()
                                else
                                    TempUnderChargeLine.NEXT();
                            end;

                            trigger OnPostDataItem();
                            begin
                                TempUnderChargeLine.RESET();
                                TempUnderChargeLine.DELETEALL();
                            end;

                            trigger OnPreDataItem();
                            begin
                                TempUnderChargeLine.RESET();
                                TempUnderChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                SETRANGE(Number, 1, TempUnderChargeLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            OrderChargeLine: Record "Sales Invoice Line";
                            SalesChargeLine: Record "Sales Invoice Line";
                            SalesInvoiceLine: Record "Sales Invoice Line";
                        begin
                            //HEI.16<<
                            case Type of
                                Type::"G/L Account":
                                    if "No." = CustPostGroup."Invoice Rounding Account" then
                                        CurrReport.SKIP();
                                Type::Resource:
                                    if SalesSetup."Timbre Electronique FND" and ("No." = SalesSetup."Timbre Resource Code FND") then
                                        CurrReport.SKIP();
                                Type::"Charge (Item)":
                                    if ItemCh.GET("No.") and ItemCh."Transport/Shipping Cost FND" then
                                        CurrReport.SKIP();
                            end;
                            //HEI.16>>

                            if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then
                                //BC UPGRADE ATHUKS01 >>  Drink IT field 
                                // TotalGrossWeight += "Sales Invoice Line".Weight;
                                //BC UPGRADE ATHUKS01 <<  Drink IT field 
                                TotalNetWeight += "Sales Invoice Line"."Net Weight";

                            //BC UPGRADE ATHUKS01 >>  Drink IT field 
                            // if not "Sales Invoice Line"."Free Item" then
                            //     TotalInvDis := "Sales Invoice Line"."Line Discount Amount";
                            //BC UPGRADE ATHUKS01 <<  Drink IT field 

                            DiscIncluded := 0;
                            UnitPrice := "Unit Price";
                            LineAmount := "Line Amount";
                            LineAmountDiscIncl := "Line Amount";
                            var_Dis := 0;

                            //BC UPGRADE ATHUKS01 >>  Drink IT field 
                            //HEI.10>>
                            // if Type <> Type::"Charge (Item)" then begin
                            //     //BC UPGRADE ATHUKS01 >>  Drink IT field 
                            //     // if "Free Item" then
                            //     //     var_Dis -= "Unit Price";
                            //     //BC UPGRADE ATHUKS01 <<  Drink IT field 

                            //     //Include in Item Price
                            //     SalesInvoiceLine.RESET();
                            //     SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                            //     SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
                            //     SalesInvoiceLine.SETRANGE("Attached to Line No.", "Line No.");
                            //     if SalesInvoiceLine.FINDSET() then
                            //         repeat
                            //             if ItemCh.GET(SalesInvoiceLine."No.") and not ItemCh."Transport/Shipping Cost" and
                            //               (ItemCh."Show Item charge on Invoice" = ItemCh."Show Item charge on Invoice"::"Include in item price") then begin
                            //                 LineAmount += SalesInvoiceLine."Line Amount";
                            //                 LineAmountDiscIncl += SalesInvoiceLine."Line Amount";
                            //                 DiscIncluded += SalesInvoiceLine."Line Amount"; //HEI.12
                            //                 if SalesInvoiceLine.Quantity <> 0 then
                            //                     UnitPrice := LineAmountDiscIncl / ABS(Quantity);
                            //             end;   //HEI.15
                            //             if ItemCh.GET(SalesInvoiceLine."No.") and (ItemCh."Item Charge Type" = ItemCh."Item Charge Type"::Discount) and not ItemCh."Transport/Shipping Cost" and
                            //               (ItemCh."Show Item charge on Invoice" = ItemCh."Show Item charge on Invoice"::" ") then begin
                            //                 var_Dis -= SalesInvoiceLine."Unit Price";
                            //                 LineAmount += SalesInvoiceLine."Line Amount";
                            //             end;
                            //         until SalesInvoiceLine.NEXT() = 0;
                            // end else
                            //     if ItemCh.GET("No.") and not ItemCh."Transport/Shipping Cost" and
                            //       (ItemCh."Item Charge Type" <> ItemCh."Item Charge Type"::Deposit) and
                            //       (ItemCh."Show Item charge on Invoice" <> ItemCh."Show Item charge on Invoice"::"Under item line") then
                            //         CurrReport.SKIP();
                            //HEI.10<<

                            //BC UPGRADE ATHUKS01 <<  Drink IT field 

                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;

                            /*var_Dis := "Line Discount Amount"; //HEI.12
                            IF (Type = Type::"Charge (Item)") AND ("Item Charge Type" = "Item Charge Type"::Discount) THEN
                              IF ItemCh.GET("No.") AND (ItemCh."Show Item charge on Invoice" = ItemCh."Show Item charge on Invoice"::" ") THEN
                                  var_Dis += ABS("Line Amount"); //HEI.12*/

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
                        column(BaseAmount; TEMPAccSchedKPIBuffer."Net Change Actual")
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
                        CLEAR(InvLineTotal);
                        CLEAR(ASDIAmount);
                        CLEAR(TSBAmount);
                        //HEI.16<<
                        CLEAR(TimbreAmount);
                        CLEAR(CADProduit);
                        CLEAR(CADDeposit);
                        CLEAR(InvDisAmount);
                        CLEAR(InvDisAmountDisplayed);
                        CLEAR(ASDIAmountDisplayed);
                        CLEAR(TSBAmountDisplayed);
                        CLEAR(TaxAmoutDisplayed);
                        CLEAR(ShipAmountDisplayed);
                        CLEAR(TimbreAmountDisplayed);
                        CLEAR(CADProduitDisplayed);
                        //HEI.16>>

                        if not ExportInvoice then
                            DocumentTitleText := STRSUBSTNO(Text52006, CopyText)
                        else
                            DocumentTitleText := STRSUBSTNO(Text52008, CopyText);

                        SalesInvLineAmt.RESET();
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset");  //commented by HEI.15
                        //BC UPGRADE ATHUKS01 >> CAD
                        // if SalesInvLineAmt.FINDSET(0) then
                        //     repeat
                        //         //HEI.16<<
                        //         if SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::Deposit then
                        //             CADDeposit += SalesInvLineAmt."CAD Amount"
                        //         else begin
                        //             CADProduitDisplayed += SalesInvLineAmt."CAD Amount";
                        //             if not SalesInvLineAmt."Free Item" then
                        //                 CADProduit += SalesInvLineAmt."CAD Amount";
                        //         end;

                        //         if (SalesInvLineAmt.Type = SalesInvLineAmt.Type::Resource) and SalesSetup."Timbre Electronique" and (SalesInvLineAmt."No." = SalesSetup."Timbre Resource Code") then begin
                        //             TimbreAmount += SalesInvLineAmt."Line Amount";
                        //             TimbreAmountDisplayed += SalesInvLineAmt."Line Amount" + SalesInvLineAmt."Line Discount Amount";
                        //         end else begin
                        //             if (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") or (SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::" ") then  //HEI.15
                        //                 InvLineTotal += SalesInvLineAmt."Line Amount";

                        //             if (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") and SalesInvLineAmt."Free Item" then
                        //                 InvDisAmountDisplayed -= SalesInvLineAmt."Line Discount Amount";
                        //         end;
                        //     //HEI.16>>
                        //     until SalesInvLineAmt.NEXT() = 0;

                        //BC UPGRADE ATHUKS01 <<  CAD 

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        if SalesInvLine.FINDSET() then
                            repeat
                                ItemCh.GET(SalesInvLine."No.");
                            //BC UPGRADE ATHUKS01 >>  Drink IT field 
                            // case SalesInvLine."Item Charge Type" of
                            //     SalesInvLine."Item Charge Type"::Tax:
                            //         begin
                            //             if ItemCh."Excise Duties" then begin
                            //                 TotalFooterAmount[1] += SalesInvLine."Line Amount";
                            //                 TaxAmoutDisplayed += SalesInvLine."Line Amount" + SalesInvLine."Line Discount Amount";
                            //             end;
                            //             if ItemCh.ASDI then begin
                            //                 ASDIAmount += SalesInvLine."Line Amount";
                            //                 ASDIAmountDisplayed += SalesInvLine."Line Amount" + SalesInvLine."Line Discount Amount";
                            //             end;
                            //             if ItemCh.TSB then begin
                            //                 TSBAmount += SalesInvLine."Line Amount";
                            //                 TSBAmountDisplayed += SalesInvLine."Line Amount" + SalesInvLine."Line Discount Amount";
                            //             end;
                            //         end;
                            //     SalesInvLine."Item Charge Type"::Deposit:
                            //         TotalFooterAmount[2] += SalesInvLine."Line Amount";
                            //     SalesInvLine."Item Charge Type"::"Shipping Cost":
                            //         TotalFooterAmount[3] += SalesInvLine."Line Amount";
                            //     SalesInvLine."Item Charge Type"::Discount:
                            //         //HEI.15>>
                            //         begin
                            //             if ItemCh."Transport/Shipping Cost" then begin
                            //                 TotalFooterAmount[3] += SalesInvLine."Line Amount";
                            //                 ShipAmountDisplayed += SalesInvLine."Line Amount" + SalesInvLine."Line Discount Amount";
                            //             end else
                            //                 //HEI.15<<
                            //                 if ItemCh."Show Item charge on Invoice" <> ItemCh."Show Item charge on Invoice"::"Include in item price" then
                            //                     TotalFooterAmount[4] += SalesInvLine."Line Amount"; //HEI.12
                            //         end;  //HEI.15
                            // end;
                            //BC UPGRADE ATHUKS01 << Drink IT field 
                            until SalesInvLine.NEXT() = 0;

                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        ShipAmount := TotalFooterAmount[3];

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        if SalesInvLine.FINDSET() then
                            repeat
                                TotalFooterAmount[4] += ABS(SalesInvLine."Inv. Discount Amount");
                                TotalFooterAmountText[4] := SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                                TotalFooterAmount[5] += ABS(SalesInvLine."Line Discount Amount");
                                TotalFooterAmountText[5] := SalesInvLine.FIELDCAPTION("Line Discount Amount");
                            until SalesInvLine.NEXT() = 0;

                        InvDisAmount += TotalFooterAmount[4];
                        InvDisAmountDisplayed += TotalFooterAmount[4];
                        LineDisAmount := TotalFooterAmount[5];

                        AmttoPaid := InvLineTotal + VATAmount + TaxAmout + ShipAmount - InvDisAmount - LineDisAmount;
                        InvTotalAmount := AmttoPaid + DepAmount;

                        //Amount in letters
                        Check.InitTextVariable();
                        Check.FormatNoText(DescriptionLine, "Sales Invoice Header"."Amount Including VAT", CurrencyCode);
                        DescriptionLine[1] := COPYSTR(DescriptionLine[1], 6);
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then
                        CopyText := Text52000;
                    //CurrReport.PAGENO := 1; BC UPGRADE ATHUKS01
                    OutputNo := OutputNo + 1;

                    CLEAR(TotalFooterAmount);
                    CLEAR(TotalFooterAmountText);
                    CLEAR(InvTotalAmount);
                    CLEAR(AmttoPaid);
                    CLEAR(TotalInvDis);
                    CLEAR(InvLineTotal);
                    CLEAR(ASDIAmount);
                    CLEAR(TSBAmount);
                    //HEI.16<<
                    CLEAR(TimbreAmount);
                    CLEAR(CADProduit);
                    CLEAR(CADDeposit);
                    CLEAR(InvDisAmount);
                    CLEAR(ASDIAmountDisplayed);
                    CLEAR(TSBAmountDisplayed);
                    CLEAR(TaxAmoutDisplayed);
                    CLEAR(ShipAmountDisplayed);
                    CLEAR(InvDisAmountDisplayed);
                    CLEAR(TimbreAmountDisplayed);
                    CLEAR(CADProduitDisplayed);
                    //HEI.16>>
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
            var
                CurrReportID: Integer;
                i: Integer;
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
                ItemUOM: Record "Item Unit of Measure";
                BankAccount: Record "Bank Account";
            begin
                //BC UPGRADE ATHUKS01 >>  Drink IT field 
                //-----Language
                // CurrReport.LANGUAGE := LanguageR.GetLanguageID("Language Code");  //HEI.16
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageId("Language Code");
                //BC UPGRADE ATHUKS01 <<  Drink IT field 

                //HEI.14>>
                //-----Currency
                LCY := false;
                if "Currency Code" <> '' then
                    CurrencyCode := "Currency Code"
                else begin
                    CurrencyCode := GLSetup."LCY Code";
                    LCY := true;
                end;

                //-----Footer Texts
                CLEAR(CurrReportID);
                CLEAR(i);
                CLEAR(TextFooter);
                EVALUATE(CurrReportID, COPYSTR(CurrReport.OBJECTID(false), 8));
                //BC UPGRADE ATHUKS01 >>  Drink IT field 
                // StandardTextReport.SETRANGE("Report ID", CurrReportID);
                // StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);
                // if StandardTextReport.FINDSET then
                //     repeat
                //         ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                //         ExtendedTextHeader.SETRANGE("Language Code", LanguageR.GetUserLanguage);
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
                //                         FooterText2 += ExtendedTextLine.Text + ' ';
                //                     until ExtendedTextLine.NEXT = 0;
                //             until ExtendedTextHeader.NEXT = 0;
                //     until StandardTextReport.NEXT = 0;
                //HEI.14<<
                //BC UPGRADE ATHUKS01 <<  Drink IT field 

                //HEI.05>>
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
                //BC UPGRADE ATHUKS01 >>  Drink IT field 
                // if CompanyInfo."Tax Registration No." <> '' then
                //     CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                //BC UPGRADE ATHUKS01 <<  Drink IT field 
                //CompanyText += ', ' + ChOfComm;
                if CompanyInfo."Phone No." <> '' then
                    CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                if CompanyInfo."Fax No." <> '' then
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                /*IF CompanyInfo."E-Mail" <> '' THEN
                  CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";*/  //commented by HEI.14
                                                                                   //HEI.05<<

                if "Sales Invoice Header"."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" then
                    ExportInvoice := true
                else
                    ExportInvoice := false;

                if "Sales Invoice Header"."Document Subtype Code FND" in [DocSubtypeCodeSetup."Sundry Sales Order Non Stock", DocSubtypeCodeSetup."Sundry Sales Order Stock"] then // BC Upgrade VAMSIU01 >>
                    ExportInvoice := false;

                TotalGrossWeight := 0;
                TotalNetWeight := 0;

                TEMPAccSchedKPIBuffer.DELETEALL;
                if Country.GET(CompanyInfo."Country/Region Code") then
                    CompanyInfoContryName := Country.Name;

                CLEAR(SalesPerson);
                if SalesPerson.GET("Sales Invoice Header"."Salesperson Code") then;

                if ShipmentMethod.GET("Sales Invoice Header"."Shipment Method Code") then
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Invoice Header"."Language Code");

                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Invoice Header"."Language Code");

                PaymentMethod.RESET;
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

                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.FINDFIRST then
                    VATPer := SalesInvLine."VAT %";

                if "Sales Invoice Header"."Prices Including VAT" = true then
                    PriceIncVAT := 'Yes'
                else
                    PriceIncVAT := 'No';

                VatAmt := 0;
                VATProduct := 0;
                VATProductDisplayed := 0;
                VATDeposit := 0;
                lineNumberVAT := 0;  //HEI.08
                                     //BC UPGRADE ATHUKS01 >>  Drink IT field 
                                     // SalesInvLine.RESET();
                                     // SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                                     // //SalesInvLine.SETFILTER("VAT %",'<>%1',0);
                                     // if SalesInvLine.FINDSET() then
                                     //     repeat
                                     //         CLEAR(ItemCh);
                                     //         if (SalesInvLine."Free Item" or (SalesInvLine."VAT Base Amount" <> 0)) and
                                     //           ((SalesInvLine.Type <> SalesInvLine.Type::"Charge (Item)") or
                                     //           (ItemCh.GET(SalesInvLine."No.") and
                                     //             ((ItemCh."Show Item charge on Invoice" <> ItemCh."Show Item charge on Invoice"::" ") or (ItemCh."Item Charge Type" in [ItemCh."Item Charge Type"::Discount, ItemCh."Item Charge Type"::Tax, ItemCh."Item Charge Type"::" "]) or (ItemCh."Transport/Shipping Cost")))) then begin
                                     //             if SalesInvLine."Free Item" then
                                     //                 SalesInvLine."VAT Base Amount" := SalesInvLine.Quantity * SalesInvLine."Unit Price"
                                     //             else
                                     //                 if (SalesInvLine.Type <> SalesInvLine.Type::"Charge (Item)") or (ItemCh.GET(SalesInvLine."No.") and ((SalesInvLine."Item Charge Type" in [SalesInvLine."Item Charge Type"::Discount, SalesInvLine."Item Charge Type"::" "]) or ItemCh."Excise Duties" or ItemCh."Transport/Shipping Cost")) then
                                     //                     VATProduct += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;

                //             VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                //             VATAmount := ABS(VatAmt);

                //             if (SalesInvLine.Type <> SalesInvLine.Type::"Charge (Item)") or (ItemCh.GET(SalesInvLine."No.") and ((SalesInvLine."Item Charge Type" in [SalesInvLine."Item Charge Type"::Discount, SalesInvLine."Item Charge Type"::" "]) or ItemCh."Excise Duties" or ItemCh."Transport/Shipping Cost")) then
                //                 VATProductDisplayed += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;

                //             if SalesInvLine."Item Charge Type" = SalesInvLine."Item Charge Type"::Deposit then
                //                 VATDeposit += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;

                //             //HEI.08>>
                //             TEMPAccSchedKPIBuffer.RESET();
                //             TEMPAccSchedKPIBuffer.SETRANGE("Balance at Date Forecast", SalesInvLine."VAT %");
                //             if TEMPAccSchedKPIBuffer.FINDFIRST() then begin
                //                 TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                //                 TEMPAccSchedKPIBuffer."Net Change Actual" += SalesInvLine."VAT Base Amount";
                //                 TEMPAccSchedKPIBuffer.MODIFY();
                //             end else begin
                //                 lineNumberVAT += 1;
                //                 TEMPAccSchedKPIBuffer.INIT();
                //                 TEMPAccSchedKPIBuffer."No." := lineNumberVAT;
                //                 TEMPAccSchedKPIBuffer."Balance at Date Forecast" := SalesInvLine."VAT %";
                //                 TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                //                 TEMPAccSchedKPIBuffer."Net Change Actual" += SalesInvLine."VAT Base Amount";
                //                 TEMPAccSchedKPIBuffer.INSERT();
                //             end;
                //         end;
                //     until SalesInvLine.NEXT() = 0;
                //HEI.08<<

                //BC UPGRADE ATHUKS01 <<  Drink IT field 

                //HEI.06<<
                //HEI.08<< //decommented the code commented by HEI.06
                TEMPAccSchedKPIBuffer.RESET();
                if TEMPAccSchedKPIBuffer.FINDSET() then
                    repeat
                        Counter += 1;
                        // SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."No.") + '%'; //commented by HEI.08
                        SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%'; //HEI.08
                        SplitVatAmount[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Net Change Budget", 0, '<Sign><Integer Thousand><Decimals,3>');
                    until TEMPAccSchedKPIBuffer.NEXT() = 0;
                //HEI.08>> //decommented the code commented by HEI.06
                //HEI.06>>
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

                //HEI.16<<
                QuantityCrates := 0;
                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETRANGE(Type, SalesInvLine.Type::Item);
                if SalesInvLine.FINDSET() then
                    repeat
                        if ItemUOM.GET(SalesInvLine."No.", 'CRT') and (ItemUOM."Qty. per Unit of Measure" <> 0) then
                            QuantityCrates += SalesInvLine."Quantity (Base)" / ItemUOM."Qty. per Unit of Measure";
                    until SalesInvLine.NEXT() = 0;

                CLEAR(BankAccountNo);
                CLEAR(BankName);
                CLEAR(IBAN);
                CLEAR(SWIFTCode);

                if SalesSetup."Bank based on inv currency FND" then begin
                    BankAccount.RESET();
                    BankAccount.SETRANGE("Bank for invoice layout FND", true);
                    BankAccount.SETRANGE("Currency Code", "Currency Code");
                    if not BankAccount.FINDFIRST() then begin
                        BankAccount.RESET();
                        BankAccount.SETRANGE("Bank for invoice layout FND", true);
                        BankAccount.SETFILTER("Currency Code", '=%1', '');
                        if BankAccount.FINDFIRST() then;
                    end;

                    BankAccountNo := BankAccount."Bank Account No.";
                    BankName := BankAccount.Name;
                    IBAN := BankAccount.IBAN;
                    SWIFTCode := BankAccount."SWIFT Code";
                end else begin
                    BankAccountNo := CompanyInfo."Bank Account No.";
                    BankName := CompanyInfo."Bank Name";
                    IBAN := CompanyInfo.IBAN;
                    SWIFTCode := CompanyInfo."SWIFT Code";
                end;

                if CustPostGroup.GET("Sales Invoice Header"."Customer Posting Group") then;
                //HEI.16>>

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
                        Caption = 'No. of Copies';
                        ToolTip = 'No. of Copies';
                        ApplicationArea = all;
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
                          FRA = 'Conditions de paiement',
                          ENG = 'Payment Terms:')
        label(lblShipMethod; ENU = 'Shipment Method',
                            FRA = 'Condition de Livraison',
                            ENG = 'Shipment Method')
        label(lblAmtPaid; ENU = 'Total invoiced:',
                         FRA = 'Total Facturé')
        label(lblSalesCondition; ENU = 'The Sale Conditions on the back side',
                                FRA = 'Conditions generales de vento ou envers')
        lblTotalQty = 'Total Quantity'; label(lblSalesPerson; ENU = 'Sales Person ID:',
                                                            FRA = 'Contact Commercial',
                                                            ENG = 'Sales Person ID:')
        label(lblUOM; ENU = 'Unit',
                     FRA = 'Unité',
                     ENG = 'Unit')
        label(lblUnitPrice; ENU = 'Unit Price',
                           FRA = 'Prix Unitaire')
        label(lblSaleLAmt; ENU = 'Amount Excl. VAT',
                          FRA = 'Montant hors TVA',
                          ENG = 'Amount Excl. VAT')
        label(lblPageNo; ENU = 'Page No:',
                        FRA = 'Page N°:')
        label(lblOrderNo; ENU = 'SO Order No:',
                         FRA = 'N° de Commande',
                         ENG = 'SO Order No:')
        label(lblInvoiceNo; ENU = 'Invoice No:',
                           FRA = 'N° de Facture')
        label(lblVATAmt; ENU = 'Total VAT:',
                        FRA = 'TVA Produits')
        label(lblPostDate; ENU = 'Invoice Date:',
                          FRA = 'Date de facturation')
        label(lblDueDate; ENU = 'Due Date:',
                         FRA = 'Date d''échéance')
        lblPriceIncVAT = 'Price Including VAT'; lblDriver = 'Name and Driver Signature'; lblWarehouse = 'Name and Warehouse Keeper Signature'; lblSecurity = 'Name and Security Visa'; label(lblPrintDate; ENU = 'Print Date:',
                                                                                                                                                                                                      FRA = 'Date d''impression')
        label(LblBillToAddress; ENU = 'BILL TO:',
                               FRA = 'Adresse de facturation')
        label(LblCustomerName; ENU = 'Customer Name:',
                              FRA = 'Nom du client')
        label(LblAddress; ENU = 'Address 1:',
                         FRA = 'Adresse 1')
        label(LblAddress2; ENU = 'Address 2:',
                          FRA = 'Adresse 2')
        label(LblPostCode; ENU = 'Post Code:',
                          FRA = 'Code Postal')
        label(LblCity; ENU = 'City:',
                      FRA = 'Ville')
        label(LblCountry; ENU = 'Country:',
                         FRA = 'Pays')
        label(LblVatRegistrationNo; ENU = 'Vat Registration No:',
                                   FRA = 'N° d''identification TVA')
        label(LblCompanyTaxId; ENU = 'Company Tax ID:',
                              FRA = 'N° fiscal de l''entreprise')
        label(LblSoldToAddress; ENU = 'CUSTOMER:',
                               FRA = 'Client')
        label(LblCustomerPoNo; ENU = 'Customer PO No:',
                              FRA = 'N° Bon de Commande Client')
        label(LblTaxDetails; ENU = 'Tax Summary',
                            FRA = 'Résumé TVA')
        label(LblBankInfo; ENU = 'Bank Details:',
                          FRA = 'Coordonnées bancaires')
        label(LblAccountNo; ENU = 'Account No:',
                           FRA = 'N° de compte')
        label(LblBankName; ENU = 'Bank:',
                          FRA = 'Banque')
        LblGiro = 'Giro No.'; label(LblIban; ENU = 'IBAN:',
                                           FRA = 'IBAN:')
        label(LblSwiftCode; ENU = 'Swift code:',
                           FRA = 'Swift code:')
        LblSignature = 'Signature:'; label(LblVatPercent; ENU = 'Vat Percent',
                                                        FRA = 'Taux TVA')
        label(LblVatAmount; ENU = 'Vat Amount',
                           FRA = 'Montant TVA')
        LblIncoTerm = 'Incoterm'; label(Lbldisc; ENU = 'Disc.',
                                               FRA = 'Remise')
        label(LblShipToAddress; ENU = 'SHIP TO ADDRESS:',
                               FRA = 'Adresse de livraison')
        label(LblCustomerNo; ENU = 'Customer No:',
                            FRA = 'N° du client')
        label(LblInvoiceCurrency; ENU = 'Invoice Currency:',
                                 FRA = 'Devise de facturation')
        label(LblVersion; ENU = 'Version:',
                         FRA = 'Version')
        label(LblItemNo; ENU = 'Item No.',
                        FRA = 'Article N°')
        label(LblQty; ENU = 'Qty',
                     FRA = 'Qté')
        label(LblPayMethod; ENU = 'Payment Method:',
                           FRA = 'Méthode de paiement')
        label(LblInvoiceCurrLCY; ENU = 'Invoice Curr LCY:',
                                FRA = 'Devise de facturation')
        label(LblTotalToBePaid; ENU = 'Total to be paid:',
                               FRA = 'Total TTC à Payer')
        label(LblDiscTotal; ENU = 'Disc Total:',
                           FRA = 'Remise Totale')
        label(GrossWeightLbl; ENU = 'Gross Weight:',
                             FRA = 'Poids brut')
        label(NetWeightLbl; ENU = 'Net Weight:',
                           FRA = 'Poids net')
        label(BillOfLadingNoLbl; ENU = 'Bill Of Lading No:',
                                FRA = 'Connaissement non')
        label(VesselNameLbl; ENU = 'Vessel Name:',
                            FRA = 'Nom du navire')
        ETDLbl = 'ETD'; ETALbl = 'ETA'; AirWayBillNoLbl = 'Air Way Bill No'; label(CommodityCodeLbl; ENU = 'Commodity Code:',
                                                                                                 FRA = 'Code marchandise')
        label(CustomTariffCodeLbl; ENU = 'Custom Tariff Code:',
                                  FRA = 'Code tarifaire personnalisé')
        BankInfo2Lbl = 'Bank Details 2:'; BankInfo3Lbl = 'Bank Details 3:'; BankInfo4Lbl = 'Bank Details 4:'; CustomerServiceEmailLbl = 'Customer Service E-Mail:'; label(LblQtyCrates; ENU = 'Quantity of crates',
                                                                                                                                                                                   FRA = 'Quantité d''emballage')
        label(LblRate; ENU = 'Rate',
                      FRA = 'Taux')
        label(LblBaseAmnt; ENU = 'Base Amount',
                          FRA = 'Montant Base')
        label(LblSubTotalExclVAT; ENU = 'Subtotal Excl. VAT',
                                 FRA = 'Sous-total Produits hors TVA')
        label(LblASDI; ENU = 'ASDI',
                      FRA = 'ASDI')
        label(LbLTSB; ENU = 'TSB',
                     FRA = 'TSB')
        label(LbLElectStamp; ENU = 'Electronic stamp',
                            FRA = 'Timbre Electronique')
        label(LblCAD; ENU = 'CAD',
                     FRA = 'Cent. Addit. Produits')
        label(LblDeposit; ENU = 'Deposit Value',
                         FRA = 'Valeur Emballage')
        label(LblDepositVAT; ENU = 'Deposit VAT',
                            FRA = 'TVA Emballage')
        label(LblDepositCAD; ENU = 'CAD Deposit',
                            FRA = 'Cent. Addit. Emballage')
        label(LblDiscLine; ENU = '%VAT',
                          FRA = 'Taux TVA')
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        SalesSetup.GET();  //HEI.14
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND");  //HEI.04
        GeneralOpCoSetup.GET();
        DocSubtypeCodeSetup.GET; // BC Upgrade VAMSIU01 >>
    end;

    var
        var_Dis: Decimal;
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        VATEntry: Record "Area";
        LanguageR: Record Language;
        LanguageMgt: Codeunit Language;
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        Customer: Record Customer;
        SalesPerson: Record "Salesperson/Purchaser";
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvLineAmt: Record "Sales Invoice Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        NoOfLoops: Integer;
        NoOfCopies: Integer;
        OutputNo: Integer;
        NUMLines: Integer;
        Text52000: TextConst ENU = 'Copy', FRA = 'Copie';
        Text52001: Label 'Total %1 Excl. VAT';
        Text52002: Label 'Total %1 Incl. VAT';
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
        TotalFooterAmount: array[7] of Decimal;
        TotalFooterAmountText: array[7] of Text[50];
        CustomerNo: Code[20];
        CustomerName: Text[50];
        CustomerAddress: Text[240];
        TotalDepositFooterAmountText: array[6] of Text[50];
        TotalDepositFooterAmount: array[6] of Decimal;
        DisplayTitleHeaderType: Option Confirmation,Proforma;
        DocumentTitleText: Text[30];
        Text52004: Label 'Order Confirmation %1';
        Text52004B: Label 'Proforma Invoice %1';
        Text52005: Label 'Subtotal %1 Excl. VAT:';
        Text52005B: Label 'Subtotal %1 Incl. VAT:';
        Text52006: TextConst ENU = 'Sales Invoice', FRA = 'Facture de Vente';
        TaxAmout: Decimal;
        VATAmount: Decimal;
        DepAmount: Decimal;
        ShipAmount: Decimal;
        LineDisAmount: Decimal;
        ShippingChargesAmount: Decimal;
        MarkupChargesAmount: Decimal;
        CustomerAttributes: Record "Customer Attributes FND";
        CustomerAttributestext: Text[1024];
        Text52007: Label 'Sundry Invoice';
        Text52008: TextConst ENU = 'Export Invoice', FRA = 'Facture d''Exportation';
        EBMSDCInformationLbl: Label 'SDC Information';
        EBMDateLbl: Label 'Date';
        EBMSDCIDLbl: Label 'SDC ID';
        EBMSDCReceiptNumberLbl: Label 'SDC Receipt Number';
        EBMInvoiceNumberLbl: Label 'Invoice Number';
        EBMInternalDateLbl: Label 'Internal Data';
        EBMReceiptSignatureLbl: Label 'Receipt Signature';
        EBMDateTimeOfPrintingLbl: Label 'Date Time of Printing';
        EBMMRCLbl: Label 'MRC';
        EBMNotReceivedErr: Label 'You cannot print %1 %2 because EBM details are not received.';
        BaseMarginAmt: Decimal;
        TEMPAccSchedKPIBuffer: Record "Acc. Sched. KPI Buffer";
        CompanyInfoContryName: Text;
        SplitVatPercent: array[10] of Text;
        SplitVatAmount: array[10] of Text;
        Counter: Integer;
        BillToCustomer: Record Customer;
        SoldToCustomer: Record Customer;
        BillToCountry: Record "Country/Region";
        SoldToCountry: Record "Country/Region";
        PaymentMethod: Record "Payment Method";
        InvalidTxt: Label '**INVALID WITHOUT FISCAL OR REFUND RECEIPT ATTACHED**';
        TotalInvDis: Decimal;
        Text50001: TextConst ENU = 'Excise Duties', FRA = 'Droits d''Accises';
        Text50002: Label 'Deposit Amount:';
        Text50003: TextConst ENU = 'Shipping Charges:', FRA = 'Frais de Transport';
        Text50004: TextConst ENU = 'Original', FRA = 'Originale';
        OriginalCopy: Text;
        TotalAmountLCY: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        ItemDiscount: Decimal;
        PrintUnderLineCharge: Boolean;
        ItemChargeRec: Record "Item Charge";
        SubTotalCharges: Decimal;
        TempUnderChargeLine: Record "Sales Invoice Line" temporary;
        IsDiscount: Boolean;
        IsDeposit: Boolean;
        IsNotUnderitem: Boolean;
        Var_typechargeItem: Boolean;
        var_Quantity: Decimal;
        var_unitprice: Decimal;
        var_discount: Decimal;
        var_amount: Decimal;
        itemDeposit: Decimal;
        TotalGrossWeight: Decimal;
        TotalNetWeight: Decimal;
        ExportInvoice: Boolean;
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";//BC UPGRADE VAMSIU01 >>
        CompanyText: Text;
        TaxNoID: Label 'Tax Number ID:';
        ChOfComm: Label 'Chamber of commerce:';
        ContactNo: Label 'Contact Number:';
        FaxNo: Label 'Fax Number:';
        EmailComp: Label 'E-mail:';
        CountryInfo: Record "Country/Region";
        lineNumberVAT: Integer;
        InvDisAmount: Decimal;
        UnitPrice: Decimal;
        LineAmount: Decimal;
        DiscIncluded: Decimal;
        //BC UPGRADE ATHUKS01 >>  Drink IT field 
        //StandardTextReport: Record "Standard Text Report";
        //BC UPGRADE ATHUKS01 <<  Drink IT field 
        TextFooter: array[3] of Text;
        CurrencyCode: Code[10];
        ItemCh: Record "Item Charge";
        QuantityCrates: Decimal;
        BankAccountNo: Text[30];
        BankName: Text[50];
        IBAN: Code[50];
        SWIFTCode: Code[20];
        Check: Report Check;
        DescriptionLine: array[2] of Text[85];
        ASDIAmount: Decimal;
        TSBAmount: Decimal;
        VATProduct: Decimal;
        VATDeposit: Decimal;
        TimbreAmount: Decimal;
        CADProduit: Decimal;
        CADDeposit: Decimal;
        TxtPayTerms: TextConst ENU = 'Payment Terms:', FRA = 'Conditions de paiement', ENG = 'Payment Terms:';
        TxtShipMethod: TextConst ENU = 'Shipment Method', FRA = 'Condition de Livraison', ENG = 'Shipment Method';
        TxtAmtPaid: TextConst ENU = 'Total invoiced:', FRA = 'Total Facturé';
        TxtSalesCondition: TextConst ENU = 'The Sale Conditions on the back side', FRA = 'Conditions generales de vento ou envers';
        TxtSalesPerson: TextConst ENU = 'Sales Person ID:', FRA = 'Contact Commercial', ENG = 'Sales Person ID:';
        TxtUOM: TextConst ENU = 'Unit', FRA = 'Unité', ENG = 'Unit';
        TxtUnitPrice: TextConst ENU = 'Unit Price', FRA = 'Prix Unitaire';
        TxtSaleLAmt: TextConst ENU = 'Amount Excl. VAT', FRA = 'Montant hors TVA', ENG = 'Amount Excl. VAT';
        TxtPageNo: TextConst ENU = 'Page No:', FRA = 'Page N°:';
        TxtOrderNo: TextConst ENU = 'SO Order No:', FRA = 'N° de Commande', ENG = 'SO Order No:';
        TxtInvoiceNo: TextConst ENU = 'Invoice No:', FRA = 'N° de Facture';
        TxtVATAmt: TextConst ENU = 'Total VAT:', FRA = 'TVA Produits';
        TxtPostDate: TextConst ENU = 'Invoice Date:', FRA = 'Date de facturation';
        TxtDueDate: TextConst ENU = 'Due Date:', FRA = 'Date d''échéance';
        TxtPrintDate: TextConst ENU = 'Print Date:', FRA = 'Date d''impression';
        TxtBillToAddress: TextConst ENU = 'BILL TO:', FRA = 'Adresse de facturation';
        TxtCustomerName: TextConst ENU = 'Customer Name:', FRA = 'Nom du client';
        TxtAddress: TextConst ENU = 'Address 1:', FRA = 'Adresse 1';
        TxtAddress2: TextConst ENU = 'Address 2:', FRA = 'Adresse 2';
        TxtPostCode: TextConst ENU = 'Post Code:', FRA = 'Code Postal';
        TxtCity: TextConst ENU = 'City:', FRA = 'Ville';
        TxtCountry: TextConst ENU = 'Country:', FRA = 'Pays';
        TxtVatRegistrationNo: TextConst ENU = 'Vat Registration No:', FRA = 'N° d''identification TVA';
        TxtCompanyTaxId: TextConst ENU = 'Company Tax ID:', FRA = 'N° fiscal de l''entreprise';
        TxtSoldToAddress: TextConst ENU = 'CUSTOMER:', FRA = 'Client';
        TxtCustomerPoNo: TextConst ENU = 'Customer PO No:', FRA = 'N° Bon de Commande Client';
        TxtTaxDetails: TextConst ENU = 'Tax Summary', FRA = 'Résumé TVA';
        TxtBankInfo: TextConst ENU = 'Bank Details:', FRA = 'Coordonnées bancaires';
        TxtAccountNo: TextConst ENU = 'Account No:', FRA = 'N° de compte';
        TxtBankName: TextConst ENU = 'Bank:', FRA = 'Banque';
        TxtIban: TextConst ENU = 'IBAN', FRA = 'IBAN';
        TxtSwiftCode: TextConst ENU = 'Code SWIFT', FRA = 'Code SWIFT';
        TxtVatPercent: TextConst ENU = 'Vat Percent', FRA = 'Taux TVA';
        TxtVatAmount: TextConst ENU = 'Vat Amount', FRA = 'Montant TVA';
        Txtdisc: TextConst ENU = 'Disc.', FRA = 'Remise';
        TxtShipToAddress: TextConst ENU = 'SHIP TO ADDRESS:', FRA = 'Adresse de livraison';
        TxtCustomerNo: TextConst ENU = 'Customer No:', FRA = 'N° du client';
        TxtInvoiceCurrency: TextConst ENU = 'Invoice Currency:', FRA = 'Devise de facturation';
        TxtVersion: TextConst ENU = 'Version:', FRA = 'Version';
        TxtItemNo: TextConst ENU = 'Item No.', FRA = 'Article N°';
        TxtQty: TextConst ENU = 'Qty', FRA = 'Qté';
        TxtPayMethod: TextConst ENU = 'Payment Method:', FRA = 'Méthode de paiement';
        TxtInvoiceCurrLCY: TextConst ENU = 'Invoice Curr LCY:', FRA = 'Devise de facturation';
        TxtTotalToBePaid: TextConst ENU = 'Total to be paid:', FRA = 'Total TTC à Payer';
        TxtDiscTotal: TextConst ENU = 'Disc Total:', FRA = 'Remise Totale';
        TxtGrossWeight: TextConst ENU = 'Gross Weight:', FRA = 'Poids brut';
        TxtNetWeight: TextConst ENU = 'Net Weight:', FRA = 'Poids net';
        TxtBillOfLadingNo: TextConst ENU = 'Bill Of Lading No:', FRA = 'Connaissement non';
        TxtVesselName: TextConst ENU = 'Vessel Name:', FRA = 'Nom du navire';
        TxtCommodityCode: TextConst ENU = 'Commodity Code:', FRA = 'Code marchandise';
        TxtCustomTariffCode: TextConst ENU = 'Custom Tariff Code:', FRA = 'Code tarifaire personnalisé';
        TxtQtyCrates: TextConst ENU = 'Quantity of crates', FRA = 'Quantité d''emballage';
        TxtRate: TextConst ENU = 'Rate', FRA = 'Taux';
        TxtBaseAmnt: TextConst ENU = 'Base Amount', FRA = 'Montant Base';
        TxtSubTotalExclVAT: TextConst ENU = 'Subtotal Excl. VAT', FRA = 'Sous-total Produits hors TVA';
        TxtElectStamp: TextConst ENU = 'Electronic stamp', FRA = 'Timbre Electronique';
        TxtCAD: TextConst ENU = 'CAD', FRA = 'Cent. Addit. Produits';
        TxtDeposit: TextConst ENU = 'Deposit Value', FRA = 'Valeur Emballages';
        TxtDepositVAT: TextConst ENU = 'Deposit VAT', FRA = 'TVA Emballages';
        TxtDepositCAD: TextConst ENU = 'CAD Deposit', FRA = 'Cent. Addit. Emballages';
        TxtDiscLine: TextConst ENU = '%VAT', FRA = 'Taux TVA';
        TxtIncoTerm: Label 'Incoterm';
        TxtASDI: Label 'ASDI';
        TxtTSB: Label 'TSB';
        TxtDescription: Label 'Description';
        FooterText2: Text;
        CustPostGroup: Record "Customer Posting Group";
        ASDIAmountDisplayed: Decimal;
        TSBAmountDisplayed: Decimal;
        TaxAmoutDisplayed: Decimal;
        ShipAmountDisplayed: Decimal;
        VATProductDisplayed: Decimal;
        TimbreAmountDisplayed: Decimal;
        InvDisAmountDisplayed: Decimal;
        LCY: Boolean;
        CADProduitDisplayed: Decimal;
        LineAmountDiscIncl: Decimal;
}

