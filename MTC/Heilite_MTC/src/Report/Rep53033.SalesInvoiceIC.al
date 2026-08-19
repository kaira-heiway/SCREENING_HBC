report 53033 "Sales Invoice ICcheck"
{
    // version IBM 1001

    // HEI.01 Report created
    // HEI.03 INC1003205 IBM HORTOC01 04.12.2018 #add new item charge discount
    // HEI.04 INC2369080 IBM HORTOC01 11.09.2019 #display name + name 2 for the customer
    // HEI.05 INC2377214 IBM GAVANM01 18.09.2019 #issues with sub-totals solved
    // HEI.07 CHG2032964 IBM.LS       05.11.2019
    //   # Multiple customization required as per RFC.
    //   # Additional bug fixed in following fields calculation;
    //     1) Montant HT Liquide
    //     2) Subtotal incl. VAT
    //     3) Total to be paid
    // HEI.08 CHG2065016 IBM SAMANR01 22.06.2020
    //   # fix the Invoice Layout Error
    //   # Include type filter "G/L Account"
    // HEI.09 CHG2107018 IBM SAMANR01 19.04.2021
    //   # fix the language code issue on auto billing

    // BC Upgrade SHUKLP03 >>
    //some part of code written on dataitem's Trigger OnAfterGetRecord is blocked because dependency on DIT fields "Item Charge Type" and "Show Item charge on Invoice".
    // Nav old id - 50276 
    // BC Upgrade SHUKLP03 <<

    // BC Upgrade MISHRS14 >>
    // Added HEI.11 Tag
    // HEI.11 CHG2349259 IBM COSTES04 30.03.2026 MODIFICATION TAX NUMBER & VAT REGISTRATION NUMBER
    // # Add Vat registration no. and Tax Number 1 to the right place
    // BC Upgrade MISHRS14 <<
    

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Sales Invoice IC.rdl';

    CaptionML = ENU = 'Sales Invoice IC',
                FRA = 'Facture vente IC';
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = ReportsAndAnalysis; // BC Upgrade SHUKLP03 <<

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
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_VATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_RCCM; CompanyInfo."RCCM Legal entity code FND")
            {
            }
            column(CompanyInfo_HomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfo_CapSocial; CompanyInfo."Cap. Social FND")
            {
            }
            column(CompanyInfo_OpCoFooter; CompanyInfo."OpCo Footer image FND")
            {
            }
            column(OriginalCopy; OriginalCopy)
            {
            }
            column(DepositOnTheNetPrice; GeneralOpCoSetup."Deposit% on the net price")
            {
            }
            column(TextDepositPaid; TextDepositPaid)
            {
            }
            column(ExportInvoice; ExportInvoice)
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
                    column(SubTotal; ROUND(InvLineTotal, 1, '='))
                    {
                    }
                    column(VATAmount; ROUND(VATAmount, 1, '='))
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
                    column(DepositToBeIncl; ROUND(DepAmount * GeneralOpCoSetup."Deposit% on the net price" / 100, 1, '='))
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
                    column(SalesInvHeader_BillToName; "Sales Invoice Header"."Bill-to Name" + ' ' + "Sales Invoice Header"."Bill-to Name 2")
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
                    column(SalesInvHeader_SellToName; "Sales Invoice Header"."Sell-to Customer Name" + ' ' + "Sales Invoice Header"."Sell-to Customer Name 2")
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
                        IncludeCaption = true;
                    }
                    column(SalesInvHeader_SellToAddress2; "Sales Invoice Header"."Sell-to Address 2")
                    {
                    }
                    column(SalesInvHeader_ShipToName; "Sales Invoice Header"."Ship-to Name" + ' ' + "Sales Invoice Header"."Ship-to Name 2")
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
                    column(SalesInvHeader_Country; ShipToCountry.Name)
                    {
                    }
                    column(SalesInvHeader_ShipToPostCode; "Sales Invoice Header"."Ship-to Post Code")
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
                    column(TotalInvDis; TotalInvDis)
                    {
                    }
                    column(TotalAmountLCY; TotalAmountLCY)
                    {
                    }
                    column(SubTotalCharges; SubTotalCharges)
                    {
                    }

                    //BC Upgrade MISHRS14 >>
                    // HEI.11
                    column(CustAtt_TaxNo1; CustomerAttributes."Tax Number 1")
                    {
                    }
                    // Also changed variable name reference initially "VAT Registration No." was marked with - CustAtt_TaxNo1 but in NAV Its marked with - CustAtt_TaxNo2
                    column(CustAtt_TaxNo2; Customer."VAT Registration No.")
                    {
                    }
                    // BC Upgrade MISHRS14 <<

                    // column(CustAtt_TaxNo2;Customer."Tax Registration No.") // BC Upgrade SHUKLP03 << Bloecked because of DIT field. 
                    // {
                    // }
                    // column(CustAtt_TaxNo2; '') // BC Upgrade SHUKLP03 << Removed expression. 
                    // {
                    // }
                    column(CustAtt_TaxNo3; CustomerAttributes."Article d'imposition")
                    {
                    }
                    column(ShipmentNo; PostedShip."No.")
                    {
                    }
                    column(InCoTerms; "Sales Invoice Header"."InCo Terms FND")
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
                    column(TotalDiscounts; TotalDiscounts)
                    {
                    }
                    column(AIRSISalesTax; AIRSISalesTax)
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER(Item | Resource | "Fixed Asset" | "G/L Account"));
                        column(SalesLine; "Sales Invoice Line"."Line No.")
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
                        column(SalesPrice; ROUND("Sales Invoice Line"."Unit Price", 1, '='))
                        {
                        }
                        column(SalesPriceExclVAT; ROUND("Sales Invoice Line"."Unit Price" / (1 + ("Sales Invoice Line"."VAT %" / 100)), 1, '='))
                        {
                        }
                        column(SalesVATPer; "Sales Invoice Line"."VAT %")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesAmount; "Sales Invoice Line".Amount)
                        {
                        }
                        column(TotalQuantity; TotalQty)
                        {
                        }
                        column(SalesDiscount; -ItemDiscount + TotalInvDis)
                        {
                        }
                        column(LineAmount_TempOrderTaxCharge; TempOrderTaxCharge."Line Amount")
                        {
                        }
                        column(LineAmount_TempOrderDiscountCharge; TempOrderDiscountCharge."Line Amount")
                        {
                        }
                        column(LineAmount_TempOrderDepositCharge; TempOrderDepositCharge."Line Amount")
                        {
                        }
                        column(PrintUnderLineCharge; PrintUnderLineCharge)
                        {
                        }
                        column(PrintOrderDiscounts; PrintOrderDiscounts)
                        {
                        }
                        column(PrintOrderDeposits; PrintOrderDeposits)
                        {
                        }
                        dataitem(UnderLineCharges; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
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
                                    TempUnderChargeLine.FINDFIRST
                                else
                                    TempUnderChargeLine.NEXT;
                            end;

                            trigger OnPostDataItem();
                            begin
                                TempUnderChargeLine.RESET;
                                TempUnderChargeLine.DELETEALL;
                            end;

                            trigger OnPreDataItem();
                            begin
                                TempUnderChargeLine.RESET;
                                TempUnderChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                SETRANGE(Number, 1, TempUnderChargeLine.COUNT);
                            end;
                        }
                        dataitem(OrderTaxCharges; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(No_TempOrderTaxCharge; TempOrderTaxCharge."No.")
                            {
                            }
                            column(Description_TempOrderTaxCharge; TempOrderTaxCharge.Description)
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then
                                    TempOrderTaxCharge.FINDFIRST
                                else
                                    TempOrderTaxCharge.NEXT;
                            end;

                            trigger OnPostDataItem();
                            begin
                                TempOrderTaxCharge.DELETEALL;
                            end;

                            trigger OnPreDataItem();
                            begin
                                TempOrderTaxCharge.RESET;
                                SETRANGE(Number, 1, TempOrderTaxCharge.COUNT);
                            end;
                        }
                        dataitem(OrderDiscountCharges; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(No_TempOrderDiscountCharge; TempOrderDiscountCharge."No.")
                            {
                            }
                            column(Description_TempOrderDiscountCharge; TempOrderDiscountCharge.Description)
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then
                                    TempOrderDiscountCharge.FINDFIRST
                                else
                                    TempOrderDiscountCharge.NEXT;
                            end;

                            trigger OnPostDataItem();
                            begin
                                TempOrderDiscountCharge.DELETEALL;
                            end;

                            trigger OnPreDataItem();
                            begin
                                TempOrderDiscountCharge.RESET;
                                SETRANGE(Number, 1, TempOrderDiscountCharge.COUNT);
                            end;
                        }
                        dataitem(OrderDepositCharges; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(No_TempOrderDepositCharge; TempOrderDepositCharge."No.")
                            {
                            }
                            column(Description_TempOrderDepositCharge; TempOrderDepositCharge.Description)
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then
                                    TempOrderDepositCharge.FINDFIRST
                                else
                                    TempOrderDepositCharge.NEXT;
                            end;

                            trigger OnPostDataItem();
                            begin
                                TempOrderDepositCharge.DELETEALL;
                            end;

                            trigger OnPreDataItem();
                            begin
                                TempOrderDepositCharge.RESET;
                                SETRANGE(Number, 1, TempOrderDepositCharge.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            OrderChargeLine: Record "Sales Invoice Line";
                            SalesChargeLine: Record "Sales Invoice Line";
                        begin
                            if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then begin
                                //TotalGrossWeight += "Sales Invoice Line".Weight;  // BC Upgrade SHUKLP03 << Blocked because of DIT field Weight.
                                TotalNetWeight += "Sales Invoice Line"."Net Weight";
                            end;

                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;
                            ItemDiscount := 0;

                            TotalInvDis += "Sales Invoice Line"."Line Discount Amount";

                            if ItemsInvoice then begin
                                //Discounts under item line
                                // CLEAR(PrintUnderLineCharge);
                                // BC Upgrade SHUKLP03 >> Blocked because of DIT field "Show Item charge on Invoice".
                                // SalesChargeLine.RESET;
                                // SalesChargeLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                // SalesChargeLine.SETRANGE(Type, "Sales Invoice Line".Type::"Charge (Item)");
                                // //SalesChargeLine.SETRANGE("Item Charge Type", "Sales Invoice Line"."Item Charge Type"::Discount); // BC Upgrade SHUKLP03 << Blocked because of DIT field "Item Charge Type".
                                // //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line"); HEI.06
                                // SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                // if SalesChargeLine.FINDSET then begin
                                //     //HEI.06>>
                                //     ItemChargeRec.GET(SalesChargeLine."No.");
                                //     if ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Under item line" then
                                //         repeat
                                //             /*IF NOT PrintUnderLineCharge THEN
                                //               PrintUnderLineCharge := TRUE;

                                //             TempUnderChargeLine.INIT;
                                //             TempUnderChargeLine := SalesChargeLine;
                                //             TempUnderChargeLine.INSERT;*/
                                //             ItemDiscount += SalesChargeLine."Line Amount";

                                //             SalesChargeLine.CALCSUMS("Line Amount");
                                //             SubTotalCharges += SalesChargeLine."Line Amount";
                                //             TotalSubTotal += SalesChargeLine."Line Amount";
                                //         until (SalesChargeLine.NEXT = 0)
                                // end;
                                // BC Upgrade SHUKLP03 << Blocked because of DIT field "Show Item charge on Invoice".

                                //Tax under item line
                                //HEI.07>>
                                CLEAR(PrintUnderLineCharge);
                                //HEI.07<<

                                // BC Upgrade SHUKLP03 >> Blocked because of DIT field "Item Charge Type" and "Show Item charge on Invoice".
                                // SalesChargeLine.RESET;
                                // SalesChargeLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                // SalesChargeLine.SETRANGE(Type, "Sales Invoice Line".Type::"Charge (Item)");
                                // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Invoice Line"."Item Charge Type"::Tax);
                                // //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line"); HEI.06
                                // SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                // if SalesChargeLine.FINDSET then begin
                                //     //HEI.06>>
                                //     ItemChargeRec.GET(SalesChargeLine."No.");
                                //     if ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Under item line" then
                                //         //HEI.06<<
                                //         repeat
                                //             if (SalesChargeLine."Line Amount" <> 0) then begin
                                //                 if not PrintUnderLineCharge then
                                //                     PrintUnderLineCharge := true;
                                //                 TempUnderChargeLine.INIT;
                                //                 TempUnderChargeLine := SalesChargeLine;
                                //                 TempUnderChargeLine.INSERT;
                                //             end;
                                //             //HEI.07>>
                                //             SubTotalCharges += SalesChargeLine."Line Amount";
                                //             TotalSubTotal += SalesChargeLine."Line Amount";
                                //         //HEI.07<<
                                //         until (SalesChargeLine.NEXT = 0);
                                //     //HEI.07>>
                                //     //SalesChargeLine.CALCSUMS("Line Amount");
                                //     //SubTotalCharges += SalesChargeLine."Line Amount";
                                //     //TotalSubTotal += SalesChargeLine."Line Amount";
                                //     //HEI.07<<
                                // end;
                                // BC Upgrade SHUKLP03 << Blocked because of DIT field "Item Charge Type" and "Show Item charge on Invoice".

                                //Deposit under item line
                                CLEAR(PrintUnderLineCharge);
                                SalesChargeLine.RESET;
                                SalesChargeLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Invoice Line".Type::"Charge (Item)");
                                //SalesChargeLine.SETRANGE("Item Charge Type", "Sales Invoice Line"."Item Charge Type"::Deposit); // BC Upgrade SHUKLP03 << Blocked because of DIT field "Item Charge Type".
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                if SalesChargeLine.FINDSET then begin
                                    //HEI.06>>
                                    ItemChargeRec.GET(SalesChargeLine."No.");
                                    //IF ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Under item line" THEN
                                    repeat
                                        if not PrintUnderLineCharge then
                                            PrintUnderLineCharge := true;
                                        TempUnderChargeLine.INIT;
                                        TempUnderChargeLine := SalesChargeLine;
                                        TempUnderChargeLine.INSERT;

                                        SalesChargeLine.CALCSUMS("Line Amount");
                                        //SubTotalCharges += SalesChargeLine."Line Amount";
                                        TotalSubTotal += SalesChargeLine."Line Amount";
                                    until (SalesChargeLine.NEXT = 0)
                                end;
                            end;

                        end;
                    }
                    dataitem(SplitVatAmt; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(TEMPAccSchedKPIBuffer_VatPercent; FORMAT(TEMPAccSchedKPIBuffer."No."))
                        {
                        }
                        column(TEMPAccSchedKPIBuffer_VatAmount; ROUND(TEMPAccSchedKPIBuffer."Net Change Budget", 1, '='))
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not TEMPAccSchedKPIBuffer.FIND('-') then
                                    CurrReport.BREAK;
                            end else
                                if TEMPAccSchedKPIBuffer.NEXT = 0 then
                                    CurrReport.BREAK;
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

                        if not ExportInvoice then
                            DocumentTitleText := STRSUBSTNO(Text52006, CopyText)
                        else
                            DocumentTitleText := STRSUBSTNO(Text52008, CopyText);
                        SalesInvLineAmt.RESET;
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        // >>HEI.08
                        //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset");
                        SalesInvLineAmt.SETFILTER(Type, '%1|%2|%3|%4', SalesInvLineAmt.Type::Item, SalesInvLineAmt.Type::Resource, SalesInvLineAmt.Type::"Fixed Asset", SalesInvLineAmt.Type::"G/L Account");
                        // <<HEI.08
                        if SalesInvLineAmt.FINDSET then
                            repeat
                                InvLineTotal += SalesInvLineAmt."Line Amount";
                            until SalesInvLineAmt.NEXT = 0;

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;

                        // BC Upgrade SHUKLP03 >> Blocked because of DIT field "Item Charge Type".
                        // SalesInvLine.RESET;
                        // SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        // SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        // if SalesInvLine.FINDSET then
                        //     repeat
                        //         case SalesInvLine."Item Charge Type" of
                        //             SalesInvLine."Item Charge Type"::Tax:
                        //                 begin
                        //                     //HEI.07>>
                        //                     ItemChargeRec.GET(SalesInvLine."No.");
                        //                     if ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Under item line" then
                        //                         //HEI.07<<
                        //                         TotalFooterAmount[1] += SalesInvLine."Line Amount";
                        //                     //TotalFooterAmountText[1]:= 'Excise Duties';
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::Deposit:
                        //                 begin
                        //                     TotalFooterAmount[2] += SalesInvLine."Line Amount";
                        //                     //TotalFooterAmountText[2]:= 'Deposit Amount';
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::"Shipping Cost":
                        //                 begin
                        //                     TotalFooterAmount[3] += SalesInvLine."Line Amount";
                        //                     TotalFooterAmountText[3] := 'Shipping Amount:';
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::Discount:
                        //                 begin
                        //                     /* //HEI.05>>
                        //                     IF SalesInvLine."No." = 'S_MARKUP' THEN BEGIN
                        //                      TotalFooterAmount[5] += SalesInvLine."Line Amount";
                        //                      TotalFooterAmountText[5]:= 'Markup Charges:';

                        //                      //TotalFooterAmount[3] += SalesInvLine."Line Amount";
                        //                      //TotalFooterAmountText[3]:= 'All Discounts';
                        //                     END;
                        //                     //HEI.03>>
                        //                     IF SalesInvLine."No." = 'A1.PPR' THEN BEGIN
                        //                      TotalFooterAmount[7] += SalesInvLine."Line Amount";
                        //                      TotalFooterAmountText[7]:= 'Base Margin PPR:';
                        //                     END;
                        //                     //HEI.03<<
                        //                     IF SalesInvLine."No." = 'S_SHIP' THEN BEGIN
                        //                      TotalFooterAmount[6] += SalesInvLine."Line Amount";
                        //                      //TotalFooterAmountText[6]:= 'Shipping Charges';
                        //                      {IF TotalFooterAmountText[3] = 'All Discounts' THEN
                        //                        TotalFooterAmountText[3]:= 'All Discounts'
                        //                      ELSE
                        //                        TotalFooterAmountText[3]:= 'Shipping Charges';}

                        //                     END;
                        //                     */ //HEI.05<<
                        //                 end;
                        //         end;
                        //     until SalesInvLine.NEXT = 0;
                        // BC Upgrade SHUKLP03 << Blocked because of DIT field "Item Charge Type".

                        /*
                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        //ShipAmount := ROUND(TotalFooterAmount[3],1,'=');
                        ShippingChargesAmount := TotalFooterAmount[6];
                        MarkupChargesAmount:= TotalFooterAmount[5];
                        */

                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        //ShipAmount := ROUND(TotalFooterAmount[3],1,'=');
                        ShippingChargesAmount := TotalFooterAmount[6];
                        MarkupChargesAmount := TotalFooterAmount[5];
                        BaseMarginAmt := TotalFooterAmount[7];//HEI.03

                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        if SalesInvLine.FINDSET then
                            repeat
                                TotalFooterAmount[4] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[4] := 'Line Discount Amount:';
                            until SalesInvLine.NEXT = 0;
                        //LineDisAmount := TotalFooterAmount[4];
                        LineDisAmount := TotalFooterAmount[4];

                        //AmttoPaid := InvLineTotal+VatAmt+TotalFooterAmount[1]+VatAmt+TotalFooterAmount[3]-VatAmt+TotalFooterAmount[4];
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
            var
                SalesInvLine2: Record "Sales Invoice Line";
                SalesInvLine3: Record "Sales Invoice Line";
                OrderChargeLine: Record "Sales Invoice Line";
                SalesReceivablesSetupL: Record "Sales & Receivables Setup";
                AccountGroupL: Record "Account Group FND";
                //DrinkTaxGroupL: Record "Drink Tax Group"; // BC Upgrade SHUKLP03 << Blocked DIT record.
                AIRSIChargeLineL: Record "Sales Invoice Line";
                ItemChargeL: Record "Item Charge";
            begin

                // >>HEI.09
                /*
                IF LangCode <> '' THEN
                  CurrReport.LANGUAGE := Language.GetLanguageID(LangCode)
                ELSE
                  CurrReport.LANGUAGE := Language.GetLanguageID("Sales Invoice Header"."Language Code");
                */
                // <<HEI.09

                if "Sales Invoice Header"."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" then
                    ExportInvoice := true
                else
                    ExportInvoice := false;

                TotalGrossWeight := 0;
                TotalNetWeight := 0;

                TEMPAccSchedKPIBuffer.DELETEALL;
                if Country.GET(CompanyInfo."Country/Region Code") then
                    CompanyInfoContryName := Country.Name;

                //-----Item Invoice
                SalesInvLine2.RESET;
                SalesInvLine2.SETRANGE("Document No.", "No.");
                SalesInvLine2.SETRANGE(Type, SalesInvLine2.Type::Item);
                if not SalesInvLine2.ISEMPTY then ItemsInvoice := true;


                if SalesPerson.GET("Sales Invoice Header"."Salesperson Code") then;

                if ShipmentMethod.GET("Sales Invoice Header"."Shipment Method Code") then
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Invoice Header"."Language Code");

                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Invoice Header"."Language Code");

                PaymentMethod.RESET;
                if PaymentMethod.GET("Payment Method Code") then;

                if "Currency Code" = '' then begin
                    //GLSetup.TESTFIELD("LCY Code");
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

                /*VATEntry.RESET;
                VATEntry.SETRANGE(Type,VATEntry.Type::Sale);
                VATEntry.SETRANGE("Document Type",VATEntry."Document Type"::Invoice);
                VATEntry.SETRANGE("Document No.","Sales Invoice Header"."No.");
                IF VATEntry.FINDSET THEN REPEAT
                  //VatAmt += ABS(VATEntry.Amount);
                  VatAmt += VATEntry.Amount;
                UNTIL VATEntry.NEXT=0;
                VATAmount := ABS(VatAmt);*/

                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.FINDFIRST then
                    VATPer := SalesInvLine."VAT %";

                if "Sales Invoice Header"."Prices Including VAT" = true then
                    PriceIncVAT := 'Yes'
                else
                    PriceIncVAT := 'No';

                "Sales Invoice Header".CALCFIELDS("Amount Including VAT", Amount);
                VatAmt += "Sales Invoice Header"."Amount Including VAT" - "Sales Invoice Header".Amount;
                VATAmount := ABS(VatAmt);

                VatAmt := 0;
                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.FINDSET then
                    repeat
                        //VatAmt += (SalesInvLine."VAT Base Amount"* SalesInvLine."VAT %")/100;
                        //VATAmount := ABS(VatAmt);

                        //split VAT
                        if TEMPAccSchedKPIBuffer.GET(SalesInvLine."VAT %") then begin
                            //TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %")/100;
                            TEMPAccSchedKPIBuffer."Net Change Budget" += SalesInvLine."Amount Including VAT" - SalesInvLine.Amount;
                            TEMPAccSchedKPIBuffer.MODIFY;
                        end else begin
                            TEMPAccSchedKPIBuffer.INIT;
                            TEMPAccSchedKPIBuffer."No." := SalesInvLine."VAT %";
                            //TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount"* SalesInvLine."VAT %")/100;
                            TEMPAccSchedKPIBuffer."Net Change Budget" += SalesInvLine."Amount Including VAT" - SalesInvLine.Amount;
                            TEMPAccSchedKPIBuffer.INSERT;
                        end;
                    until SalesInvLine.NEXT = 0;

                TEMPAccSchedKPIBuffer.RESET;
                if TEMPAccSchedKPIBuffer.FINDSET then
                    repeat
                        Counter += 1;
                        SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."No.") + '%';
                        SplitVatAmount[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Net Change Budget", 0, '<Sign><Integer Thousand><Decimals,3>');
                    until TEMPAccSchedKPIBuffer.NEXT = 0;

                BillToCustomer.GET("Sales Invoice Header"."Bill-to Customer No.");
                SoldToCustomer.GET("Sales Invoice Header"."Sell-to Customer No.");
                if BillToCountry.GET(BillToCustomer."Country/Region Code") then;
                if SoldToCountry.GET(SoldToCustomer."Country/Region Code") then;
                if ShipToCountry.GET("Sales Invoice Header"."Ship-to Country/Region Code") then;

                if "Sales Invoice Header"."No. Printed" = 0 then
                    OriginalCopy := Text50004
                else
                    OriginalCopy := Text52000;

                "Sales Invoice Header".CALCFIELDS("Amount Including VAT");
                TotalAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(TODAY, "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Amount Including VAT", CurrExchRate.ExchangeRate(TODAY, "Sales Invoice Header"."Currency Code"));

                CLEAR(TotalDeposits);
                CLEAR(TotalDiscounts);
                CLEAR(TotalTaxes);
                //HEI.07>>
                CLEAR(AIRSISalesTax);
                //HEI.07<<
                // BC Upgrade SHUKLP03 >> Blocked because of DIT field "Item Charge Type" and "Show Item charge on Invoice".
                // if ItemsInvoice then begin
                //     //-----Order total /blank Discount Charges
                //     OrderChargeLine.RESET;
                //     OrderChargeLine.SETRANGE("Document No.", "No.");
                //     OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                //     OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Discount);
                //     if OrderChargeLine.FINDSET then begin
                //         ItemChargeRec.GET(OrderChargeLine."No.");
                //         if (ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Order total")
                //            or (ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::" ")
                //         then begin
                //             PrintOrderDiscounts := true;
                //             repeat
                //                 TempOrderDiscountCharge.INIT;
                //                 TempOrderDiscountCharge := OrderChargeLine;
                //                 TempOrderDiscountCharge.INSERT;
                //             until (OrderChargeLine.NEXT = 0);
                //             OrderChargeLine.CALCSUMS("Line Amount");
                //             TotalDiscounts += OrderChargeLine."Line Amount";
                //         end;
                //         //HEI.05>>
                //         if (ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Under item line") or
                //          (ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Include in item price") then begin
                //             OrderChargeLine.CALCSUMS("Line Amount");
                //             TotalDiscounts += OrderChargeLine."Line Amount";
                //         end;
                //         //HEI.05<<
                //     end;
                //     //-----Order total /blank Deposit Charges
                //     OrderChargeLine.RESET;
                //     OrderChargeLine.SETRANGE("Document No.", "No.");
                //     OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                //     OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Deposit);
                //     if OrderChargeLine.FINDSET then begin
                //         ItemChargeRec.GET(OrderChargeLine."No.");
                //         if (ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Order total")
                //            or (ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::" ")
                //         then begin
                //             PrintOrderDeposits := true;
                //             repeat
                //                 TempOrderDepositCharge.INIT;
                //                 TempOrderDepositCharge := OrderChargeLine;
                //                 TempOrderDepositCharge.INSERT;
                //             until (OrderChargeLine.NEXT = 0);
                //             OrderChargeLine.CALCSUMS("Line Amount");
                //             TotalDeposits += OrderChargeLine."Line Amount";  //HEI.05
                //         end;
                //     end;
                //     //-----Order total /blank Tax Charges
                //     OrderChargeLine.RESET;
                //     OrderChargeLine.SETRANGE("Document No.", "No.");
                //     OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                //     OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Tax);
                //     if OrderChargeLine.FINDSET then begin
                //         ItemChargeRec.GET(OrderChargeLine."No.");
                //         if (ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Order total")
                //            or (ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::" ")
                //         then begin
                //             repeat
                //                 if (OrderChargeLine."Line Amount" <> 0) then begin
                //                     PrintOrderTaxes := true;
                //                     TempOrderTaxCharge.INIT;
                //                     TempOrderTaxCharge := OrderChargeLine;
                //                     TempOrderTaxCharge.INSERT;
                //                 end;
                //             until (OrderChargeLine.NEXT = 0);
                //             OrderChargeLine.CALCSUMS("Line Amount");
                //             TotalTaxes += OrderChargeLine."Line Amount";
                //         end;
                //     end;
                //     //HEI.07>>
                //     SalesReceivablesSetupL.GET;
                //     if SalesReceivablesSetupL."Account Group for AIRSI" <> '' then begin
                //         if (SoldToCustomer."No." <> BillToCustomer."No.") and (BillToCustomer."No." = '') then begin
                //             if SoldToCustomer."Account Group" = SalesReceivablesSetupL."Account Group for AIRSI" then begin
                //                 AccountGroupL.GET(SoldToCustomer."Account Group");
                //                 DrinkTaxGroupL.GET(DrinkTaxGroupL."Source Type"::Customer, SoldToCustomer."Customer DTax Group Code");
                //                 if SoldToCustomer."Customer DTax Group Code" = "Customer DTax Group Code" then begin
                //                     AIRSIChargeLineL.SETRANGE("Document No.", "No.");
                //                     AIRSIChargeLineL.SETRANGE(Type, AIRSIChargeLineL.Type::"Charge (Item)");
                //                     AIRSIChargeLineL.SETRANGE("Item Charge Type", AIRSIChargeLineL."Item Charge Type"::Tax);
                //                     if AIRSIChargeLineL.FINDSET then begin
                //                         repeat
                //                             if AIRSIChargeLineL."Line Amount" <> 0 then begin
                //                                 ItemChargeL.GET(AIRSIChargeLineL."No.");
                //                                 AIRSISalesTax += AIRSIChargeLineL."Line Amount";
                //                             end;
                //                         until AIRSIChargeLineL.NEXT = 0;
                //                     end;
                //                 end;
                //             end;
                //         end else begin
                //             if BillToCustomer."Account Group" = SalesReceivablesSetupL."Account Group for AIRSI" then begin
                //                 AccountGroupL.GET(BillToCustomer."Account Group");
                //                 DrinkTaxGroupL.GET(DrinkTaxGroupL."Source Type"::Customer, BillToCustomer."Customer DTax Group Code");
                //                 if BillToCustomer."Customer DTax Group Code" = "Customer DTax Group Code" then begin
                //                     AIRSIChargeLineL.SETRANGE("Document No.", "No.");
                //                     AIRSIChargeLineL.SETRANGE(Type, AIRSIChargeLineL.Type::"Charge (Item)");
                //                     AIRSIChargeLineL.SETRANGE("Item Charge Type", AIRSIChargeLineL."Item Charge Type"::Tax);
                //                     if AIRSIChargeLineL.FINDSET then begin
                //                         repeat
                //                             if AIRSIChargeLineL."Line Amount" <> 0 then begin
                //                                 ItemChargeL.GET(AIRSIChargeLineL."No.");
                //                                 AIRSISalesTax += AIRSIChargeLineL."Line Amount";
                //                             end;
                //                         until AIRSIChargeLineL.NEXT = 0;
                //                     end;
                //                 end;
                //             end;
                //         end;
                //     end;
                //     //HEI.07<<
                // end;
                // BC Upgrade SHUKLP03 << Blocked because of DIT field "Item Charge Type" and "Show Item charge on Invoice".

                //*** find Shipping no
                PostedShip.RESET;
                PostedShip.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
                if PostedShip.FINDFIRST then;

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
                    Caption = 'Sales Order';
                    field("No. of Copies"; NoOfCopies)
                    {
                        ApplicationArea = All;
                    }
                    field(LangCode; LangCode)
                    {
                        Caption = 'Local Language Code';
                        LookupPageID = Languages;
                        TableRelation = Language;
                        ApplicationArea = All;
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
                          FRA = 'Conditions de paiement:')
        label(lblShipMethod; ENU = 'Shipment Method',
                            FRA = 'Condition de Livraison')
        label(lblAmtPaid; ENU = 'Subtotal incl. VAT:',
                         FRA = 'Total TTC Liquide')
        label(lblSalesCondition; ENU = 'The Sale Conditions on the back side',
                                FRA = 'Conditions generales de vento ou envers')
        lblTotalQty = 'Total Quantity'; label(lblSalesPerson; ENU = 'Sales Person ID:',
                                                            FRA = 'Contact commercial:')
        label(lblUOM; ENU = 'Unit',
                     FRA = 'Unité')
        label(lblUnitPrice; ENU = 'Unit Price',
                           FRA = 'Prix unitaire')
        label(lblSaleLAmt; ENU = 'Amount Excl. VAT',
                          FRA = 'Montant HT')
        lblPageNo = 'Page No:'; label(lblOrderNo; ENU = 'SO Order No:',
                                                FRA = 'N° de commande:')
        label(lblInvoiceNo; ENU = 'Invoice No:',
                           FRA = 'N° Facture:')
        label(lblVATAmt; ENU = 'Total VAT (18%):',
                        FRA = 'Total TVA (18%):')
        label(lblPostDate; ENU = 'Invoice Date:',
                          FRA = 'Date de facturation:')
        label(lblDueDate; ENU = 'Due Date:',
                         FRA = 'Date d''écheance:')
        lblPriceIncVAT = 'Price Including VAT'; lblDriver = 'Name and Driver Signature'; lblWarehouse = 'Name and Warehouse Keeper Signature'; lblSecurity = 'Name and Security Visa'; label(lblPrintDate; ENU = 'Print Date:',
                                                                                                                                                                                                      FRA = 'Date d''impression:')
        label(LblBillToAddress; ENU = 'BILL TO:',
                               FRA = 'Client facturé:')
        label(LblCustomerName; ENU = 'Customer Name:',
                              FRA = 'Nom client:')
        label(LblAddress; ENU = 'Address 1:',
                         FRA = 'Addresse 1:')
        label(LblAddress2; ENU = 'Address 2:',
                          FRA = 'Addresse 2:')
        label(LblPostCode; ENU = 'Post Code:',
                          FRA = 'Code postal:')
        label(LblCity; ENU = 'City:',
                      FRA = 'Ville:')
        label(LblCountry; ENU = 'Country:',
                         FRA = 'Pays:')
        LblVatRegistrationNo = 'Vat Registration No:'; LblCompanyTaxId = 'Company Tax ID:'; label(LblSoldToAddress; ENU = 'CUSTOMER:',
                                                                                                                 FRA = 'Client:')
        LblCustomerPoNo = 'Customer PO No:'; label(LblTaxDetails; ENU = 'Tax Summary',
                                                                FRA = 'Taux de Tva')
        label(LblBankInfo; ENU = 'Bank Details:',
                          FRA = 'Coordonnées bancaires pour règlement par virement: ')
        label(LblAccountNo; ENU = 'Account No:',
                           FRA = 'N° Compte:')
        label(LblBankName; ENU = 'Bank:',
                          FRA = 'Banque:')
        LblGiro = 'Giro No.'; LblIban = 'Iban:'; LblSwiftCode = 'Swift Code:'; LblSignature = 'Signature:'; LblVatPercent = 'Vat Percent'; LblVatAmount = 'Vat Amount'; LblIncoTerm = 'InCo Terms:'; label(Lbldisc; ENU = 'Disc.',
                                                                                                                                                                                                            FRA = 'MT Total Remise')
        label(LblShipToAddress; ENU = 'SHIP TO ADDRESS:',
                               FRA = 'Client livré:')
        label(LblCustomerNo; ENU = 'Customer No:',
                            FRA = 'N° Client:')
        label(LblInvoiceCurrency; ENU = 'Invoice Currency:',
                                 FRA = 'Devise de facturation:')
        LblVersion = 'Version:'; label(LblItemNo; ENU = 'Item No.',
                                                FRA = 'Code produit')
        label(LblQty; ENU = 'Qty',
                     FRA = 'Quantité')
        label(LblPayMethod; ENU = 'Payment Method:',
                           FRA = 'Mode de règlement:')
        LblInvoiceCurrLCY = 'Invoice Curr LCY:'; label(LblTotalToBePaid; ENU = 'Total to be paid:',
                                                                       FRA = 'Net a payer:')
        LblDiscTotal = 'Disc Total:'; label(LblDesc; ENU = 'Description',
                                                   FRA = 'Désignation')
        label(LblVATRate; ENU = 'VAT%',
                         FRA = 'TVA%')
        label(LblCompCon; ENU = 'N° de compte contribuable:',
                         FRA = 'N° de compte contribuable:')
        label(LblRCCM; ENU = 'RCCM:',
                      FRA = 'RCCM:')
        label(LblRegImp; ENU = 'Régime d''imposition:',
                        FRA = 'Régime d''imposition:')
        label(LblShipNo; ENU = 'Shipping No.:',
                        FRA = 'N de livraison:')
        GrossWeightLbl = 'Gross Weight:'; NetWeightLbl = 'Net Weight:'; BillOfLadingNoLbl = 'Bill Of Lading No:'; VesselNameLbl = 'Vessel Name:'; ETDLbl = 'ETD:'; ETALbl = 'ETA:'; AirWayBillNoLbl = 'Air Way Bill No:'; CommodityCodeLbl = 'Commodity Code:'; CustomTariffCodeLbl = 'Custom Tariff Code:'; LblTotalAIRSIPercentage = 'Total AIRSI (5%):'; label(LblTaxAIRSI; ENU = 'Tax Summary AIRSI',
                                                                                                                                                                                                                                                                                                                                                                    FRA = 'Taux de AIRSI')
        LblAIRSIPercentage = '5%'; LblTotal = 'Total';
    }

    trigger OnInitReport();
    begin
        GLSetup.GET;
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND");
        PrintOrderDiscounts := false;
        GeneralOpCoSetup.GET;
        if GeneralOpCoSetup."Deposit% on the net price" <> 0 then
            TextDepositPaid := STRSUBSTNO(Text50005, GeneralOpCoSetup."Deposit% on the net price");


        // >>HEI.09
        if LangCode <> '' then
            CurrReport.LANGUAGE := LanguageCU.GetLanguageID(LangCode) // BC Upgrade SHUKLP03 << Replaced with Language codeunit.
        else
            CurrReport.LANGUAGE := LanguageCU.GetLanguageID('FRA');  // BC Upgrade SHUKLP03 << Replaced with Language codeunit.
        // <<HEI.09
    end;

    var
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        VATEntry: Record "VAT Entry";
        //Language: Record Language; // BC Upgrade SHUKLP03 << Deprecated. Replaced with Language codeunit.
        LanguageCU: Codeunit Language; // BC Upgrade SHUKLP03 << 
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
        Text52000: Label 'Copy';
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
        Text52005: TextConst ENU = 'Subtotal %1 Excl. VAT:', FRA = 'Montant HT Liquide:';
        Text52005B: Label 'Subtotal %1 Incl. VAT:';
        Text52006: TextConst ENU = 'Sales Invoice', FRA = 'Facture';
        TaxAmout: Decimal;
        VATAmount: Decimal;
        DepAmount: Decimal;
        ShipAmount: Decimal;
        LineDisAmount: Decimal;
        ShippingChargesAmount: Decimal;
        MarkupChargesAmount: Decimal;
        CustomerAttributes: Record "Customer Attributes FND";
        CustomerAttributestext: Text[1024];
        Text52008: TextConst ENU = 'Export Invoice', FRA = 'Facture Export';
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
        Text50001: Label 'Excise Duties:';
        Text50002: TextConst ENU = 'Deposit Amount:', FRA = 'Montant Consigne:';
        Text50003: Label 'Shipping Charges:';
        Text50004: Label 'Original';
        OriginalCopy: Text;
        TotalAmountLCY: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        TempOrderDiscountCharge: Record "Sales Invoice Line" temporary;
        TempOrderDepositCharge: Record "Sales Invoice Line" temporary;
        TempUnderChargeLine: Record "Sales Invoice Line" temporary;
        TempOrderTaxCharge: Record "Sales Invoice Line" temporary;
        ItemsInvoice: Boolean;
        ItemChargeRec: Record "Item Charge";
        PrintOrderDiscounts: Boolean;
        PrintOrderDeposits: Boolean;
        PrintOrderTaxes: Boolean;
        PrintUnderLineCharge: Boolean;
        TotalDeposits: Decimal;
        TotalTaxes: Decimal;
        SubTotalCharges: Decimal;
        TotalSubTotal: Decimal;
        ShipToCountry: Record "Country/Region";
        ItemDiscount: Decimal;
        PostedShip: Record "Sales Shipment Header";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        Text50005: TextConst ENU = '(%1 % Deposit to be paid)', FRA = '(%1 % Consigne à payer)';
        TextDepositPaid: Text;
        ExportInvoice: Boolean;
        TotalGrossWeight: Decimal;
        TotalNetWeight: Decimal;
        TotalDiscountsUnderLine: Decimal;
        TotalDiscounts: Decimal;
        AIRSISalesTax: Decimal;
        LangCode: Code[10];
}

