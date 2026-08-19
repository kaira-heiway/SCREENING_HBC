report 53040 "Sales Invoice - Export CO"
{
    // version HEI.06

    // HEI.01 Report created
    // HEI.03 INC1003205 IBM HORTOC01 04.12.2018 #add new item charge discount
    // HEI.04 FDD-HT915 IBM NASTAA02 27.09.2019 # OtC Billing – Invoice Layout local requirements for Domestic Invoice/Credit Memo/Sundry, and Export Invoice
    //   # Hided square from Layout
    //   # Added 1 new Bank Account
    // HEI.05 HB1368 IBM GAVANM01 29.04.2020 #Correction to Invoice/Credit Note - Shipping Charge
    //   # code and layout changes
    // HEI.06 INC2918336 IBM NASTAA02 29.06.2020 # Printing multiple invoices
    //   # Implemented SetData, GetData functions on layout for the header text boxes
    // HEI.07 CHG2070324 IBM.GUNERE01 02.07.2020 # modifications on layout, DataSource SalesDiscount1 modified,
    //                                            PageLoop - OnAfterGetRecord, Sales Invoice Line - OnAfterGetRecord funcs.
    //                                            modified.
    // HEI.08 CHG2070787 IBM GAVANM01 02.09.2020 Update all Billing documents in line with Global (for the BAHAMAS)
    //   # Add Standard Text Report functionality for footer texts
    // HEI.09 CHG2073371 HB1589 IBM GAVANM01 28.09.2020  #St Lucia Item charges Shipping Cost not working
    //   # Item charges of type Discount and Transport/Shipping Cost = TRUE should be considered as Shipping Cost
    // -------------------------------------------------------------------------------------------------------------------
    // 
    // HEI.10 CHG2105027 HT1226 IBM GAVANM01 12.05.2021 #Sales Documents Brasco
    //   #new report, copied from ID 50277
    //*********************************************//
    //BC UPGRADE ATHUKS01//
    //1.HEI.05,HEI.08,HEI.09 Commented drink IT code.
    //2.HEI.06,HEI.07 no changes.
    //3.Commented CAD related Code. 
    //4.Change Language to LanguageMgt and record to codeunit for getting Language.
    //5.CurrReport.PAGENO is deprecated and unsupported in modern Business Central (AL language) RDLC ,often returning a constant value of 1 or causing compilation warnings.
    //6.Old Report ID 50514       
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Sales Invoice - Export CO.rdl';

    Caption = 'Sales Invoice - Export CO';
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;
    ApplicationArea = ALL;
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
            column(CompanyText; CompanyText)
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
                    column(InCoTerms; "Sales Invoice Header"."InCo Terms FND")
                    {
                    }
                    column(ItemChargeDisc; ItemChargeDisc)
                    {
                    }
                    column(InvDisAmount; InvDisAmount)
                    {
                    }
                    column(QuantityCrates; QuantityCrates)
                    {
                    }
                    column(ASDIAmount; ASDIAmount)
                    {
                    }
                    column(TSBAmount; TSBAmount)
                    {
                    }
                    column(VATDeposit; VATDeposit)
                    {
                    }
                    column(VATProduct; VATProduct)
                    {
                    }
                    column(TimbreAmount; TimbreAmount)
                    {
                    }
                    column(CADProduit; CADProduit)
                    {
                    }
                    column(CADDeposit; CADDeposit)
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER(Item | Resource | "Fixed Asset" | "Charge (Item)" | "G/L Account"));
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
                        column(SalesPrice; ROUND("Sales Invoice Line"."Unit Price", 0.01, '='))
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
                        column(SalesPrice1; UnitPrice)
                        {
                        }
                        column(SalesAmount1; LineAmount)
                        {
                        }
                        column(DiscIncluded; DiscIncluded)
                        {
                        }
                        column(SalesDiscount1; var_Dis)
                        {
                        }

                        trigger OnAfterGetRecord();
                        var
                            SalesInvoiceLine: Record "Sales Invoice Line";
                        begin
                            //BC UPGRADE ATHUKS01 >>  Drink IT field 
                            //HEI.10<<
                            //if "Item Charge Type" = "Item Charge Type"::Deposit then
                            //     CADDeposit += "CAD Amount"
                            // else
                            //     CADProduit += "CAD Amount";
                            //BC UPGRADE ATHUKS01 <<  Drink IT field 

                            if (Type = Type::Resource) and SalesSetup."Timbre Electronique FND" and ("No." = SalesSetup."Timbre Resource Code FND") then begin
                                TimbreAmount += "Line Amount";
                                CurrReport.SKIP();
                            end;
                            //HEI.10>>

                            //HEI.05>>
                            DiscIncluded := 0;
                            UnitPrice := "Unit Price";
                            LineAmount := "Line Amount";

                            //BC UPGRADE ATHUKS01 >>  Drink IT field 
                            // if Type <> Type::"Charge (Item)" then begin
                            //     //Include in Item Price
                            //     SalesInvoiceLine.RESET();
                            //     SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                            //     SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
                            //     SalesInvoiceLine.SETRANGE("Attached to Line No.", "Line No.");
                            //     //SalesInvoiceLine.SETRANGE("Item Charge Type",SalesInvoiceLine."Item Charge Type"::Discount);
                            //     //SalesInvoiceLine.SETRANGE("Show Item charge on Invoice", SalesInvoiceLine."Show Item charge on Invoice"::"Include in item price");
                            //     if SalesInvoiceLine.FINDSET() then
                            //         repeat
                            //             if ItemCh.GET(SalesInvoiceLine."No.") and not ItemCh."Transport/Shipping Cost" and
                            //               (ItemCh."Show Item charge on Invoice" = ItemCh."Show Item charge on Invoice"::"Include in item price") then begin
                            //                 LineAmount += SalesInvoiceLine."Line Amount";
                            //                 DiscIncluded += SalesInvoiceLine."Line Amount"; //HEI.07
                            //                 if SalesInvoiceLine.Quantity <> 0 then
                            //                     UnitPrice := LineAmount / ABS(Quantity);
                            //             end;   //HEI.09
                            //         until SalesInvoiceLine.NEXT() = 0;
                            //     //HEI.10<<
                            //     /*END ELSE IF ("Item Charge Type" <> "Item Charge Type"::Discount) OR
                            //       ("Show Item charge on Invoice" = "Show Item charge on Invoice"::"Include in item price") THEN
                            //         IF ItemCh.GET("No.") AND NOT ItemCh."Transport/Shipping Cost" THEN   //HEI.09
                            //           CurrReport.SKIP;*/
                            // end else if ItemCh.GET("No.") and not ItemCh."Transport/Shipping Cost" and (ItemCh."Item Charge Type" <> ItemCh."Item Charge Type"::Deposit) and
                            //   (ItemCh."Show Item charge on Invoice" <> ItemCh."Show Item charge on Invoice"::"Under item line") then
                            //         CurrReport.SKIP();
                            //HEI.10>>
                            //HEI.05<<
                            //BC UPGRADE ATHUKS01 <<  Drink IT field 

                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;

                            TotalInvDis += ABS("Sales Invoice Line"."Line Discount Amount");

                            if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then
                                //BC UPGRADE ATHUKS01 >>  Drink IT field 
                                // TotalGrossWeight += "Sales Invoice Line".Weight;
                                //BC UPGRADE ATHUKS01 <<  Drink IT field 
                                TotalNetWeight += "Sales Invoice Line"."Net Weight";


                            var_Dis := "Line Discount Amount"; //HEI.07
                            //BC UPGRADE ATHUKS01 >>  Drink IT field 
                            // if (Type = Type::"Charge (Item)") and ("Item Charge Type" = "Item Charge Type"::Discount) then
                            //     if ItemCh.GET("No.") and not ItemCh."Transport/Shipping Cost" and  //HEI.09
                            //       (ItemCh."Show Item charge on Invoice" = ItemCh."Show Item charge on Invoice"::" ") then
                            //         var_Dis += "Line Amount"; //HEI.07
                            //BC UPGRADE ATHUKS01 <<  Drink IT field 

                        end;
                    }
                    dataitem(SplitVatAmt; "Integer")
                    {
                        column(TEMPAccSchedKPIBuffer_VatPercent; FORMAT(TEMPAccSchedKPIBuffer."No."))
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
                        CLEAR(ItemChargeDisc);  //HEI.05
                        CLEAR(ASDIAmount);
                        CLEAR(TSBAmount);
                        CLEAR(VATDeposit);
                        //HEI.10<<
                        CLEAR(TimbreAmount);
                        CLEAR(CADProduit);
                        CLEAR(CADDeposit);
                        //HEI.10>>

                        DocumentTitleText := STRSUBSTNO(Text52007, CopyText);

                        //BC UPGRADE ATHUKS01 >>  Drink IT field 
                        // SalesInvLineAmt.RESET();
                        // SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset"); //commented by HEI.09
                        // if SalesInvLineAmt.FINDSET() then
                        //     repeat
                        //         if (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") or (SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::" ") then  //HEI.09
                        //             InvLineTotal += SalesInvLineAmt."Line Amount";
                        //     until SalesInvLineAmt.NEXT() = 0;
                        //BC UPGRADE ATHUKS01 <<  Drink IT field 

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;

                        //BC UPGRADE ATHUKS01 >>  Drink IT field 
                        // SalesInvLine.RESET();
                        // SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        // SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        // if SalesInvLine.FINDSET() then
                        //     repeat
                        //         case SalesInvLine."Item Charge Type" of
                        //             SalesInvLine."Item Charge Type"::Tax:
                        //                 if ItemCh.GET(SalesInvLine."No.") then begin
                        //                     if ItemCh."Excise Duties" then
                        //                         TotalFooterAmount[1] += SalesInvLine."Line Amount";
                        //                     if ItemCh.ASDI then
                        //                         ASDIAmount += SalesInvLine."Line Amount";
                        //                     if ItemCh.TSB then
                        //                         TSBAmount += SalesInvLine."Line Amount";
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::Deposit:
                        //                 begin
                        //                     TotalFooterAmount[2] += SalesInvLine."Line Amount";
                        //                     VATDeposit += SalesInvLine."Amount Including VAT" - SalesInvLine.Amount;
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::"Shipping Cost":
                        //                 TotalFooterAmount[3] += SalesInvLine."Line Amount";
                        //             SalesInvLine."Item Charge Type"::Discount:
                        //                 //HEI.09>>
                        //                 begin
                        //                     if ItemCh.GET(SalesInvLine."No.") and ItemCh."Transport/Shipping Cost" then
                        //                         TotalFooterAmount[3] += SalesInvLine."Line Amount"
                        //                     else
                        //                         //HEI.09<<
                        //                         if SalesInvLine."Show Item charge on Invoice" <> SalesInvLine."Show Item charge on Invoice"::"Include in item price" then
                        //                             //TotalFooterAmount[4] += ABS(SalesInvLine."Line Amount");
                        //                             TotalFooterAmount[4] += SalesInvLine."Line Amount"; //HEI.07
                        //                 end;  //HEI.09
                        //         end;
                        //     until SalesInvLine.NEXT = 0;
                        //BC UPGRADE ATHUKS01 <<  Drink IT field 

                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        ShipAmount := TotalFooterAmount[3];  //HEI.05

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        //SalesInvLine.SETRANGE(Type,SalesInvLine.Type::"Charge (Item)");  //commented by HEI.09
                        if SalesInvLine.FINDSET() then
                            repeat
                                TotalFooterAmount[4] += ABS(SalesInvLine."Inv. Discount Amount");
                                TotalFooterAmountText[4] := SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                                TotalFooterAmount[5] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[5] := SalesInvLine.FIELDCAPTION("Line Discount Amount");
                            until SalesInvLine.NEXT() = 0;

                        InvDisAmount := TotalFooterAmount[4];
                        LineDisAmount := TotalFooterAmount[5];

                        AmttoPaid := InvLineTotal + VATAmount + TaxAmout + ShipAmount - InvDisAmount - LineDisAmount;
                        InvTotalAmount := AmttoPaid + DepAmount;

                        //Amount in letters
                        Check.InitTextVariable();
                        Check.FormatNoText(DescriptionLine, "Sales Invoice Header"."Amount Including VAT", CurrencyCode); //HEI.05

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
                    CLEAR(ItemChargeDisc);  //HEI.05
                    CLEAR(ASDIAmount);
                    CLEAR(TSBAmount);
                    CLEAR(VATDeposit);
                    //HEI.10<<
                    CLEAR(TimbreAmount);
                    CLEAR(CADProduit);
                    CLEAR(CADDeposit);
                    //HEI.10>>
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
                //-----Language
                //BC UPGRADE ATHUKS01 >>  Drink IT field 
                // CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");  //HEI.10
                CurrReport.Language := LanguageMgt.GetLanguageId("Language Code");
                //BC UPGRADE ATHUKS01 <<  Drink IT field 
                //HEI.08>>
                //-----Currency
                if "Currency Code" <> '' then
                    CurrencyCode := "Currency Code"
                else
                    CurrencyCode := GLSetup."LCY Code";

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
                //         i := 1;
                //         ExtendedTextHeader.RESET;
                //         ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                //         ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                //         if ExtendedTextHeader.FINDSET then begin
                //             repeat
                //                 ExtendedTextLine.RESET;
                //                 ExtendedTextLine.SETRANGE("Table Name", ExtendedTextHeader."Table Name");
                //                 ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                //                 ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                //                 ExtendedTextLine.SETRANGE("Language Code", "Language Code");
                //                 if ExtendedTextHeader."All Language Codes" then
                //                     ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
                //                 if ExtendedTextLine.FINDSET then begin
                //                     repeat
                //                         TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                //                     until (ExtendedTextLine.NEXT = 0) or (i > ARRAYLEN(TextFooter));
                //                 end;
                //                 i += 1;
                //             until (ExtendedTextHeader.NEXT = 0);
                //         end;
                //     until (StandardTextReport.NEXT = 0);
                //BC UPGRADE ATHUKS01 << Drink IT field 

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
                  CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";*/
                //HEI.08<<

                TotalGrossWeight := 0;
                TotalNetWeight := 0;

                TEMPAccSchedKPIBuffer.DELETEALL();
                if Country.GET(CompanyInfo."Country/Region Code") then
                    CompanyInfoContryName := Country.Name;

                CLEAR(SalesPerson);
                if SalesPerson.GET("Sales Invoice Header"."Salesperson Code") then;

                if ShipmentMethod.GET("Sales Invoice Header"."Shipment Method Code") then
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Invoice Header"."Language Code");

                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Invoice Header"."Language Code");

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
                VATProduct := 0;
                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.FINDSET() then
                    repeat
                        VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                        VATAmount := ABS(VatAmt);
                        if (SalesInvLine.Type <> SalesInvLine.Type::"Charge (Item)") or
                          (ItemCh.GET(SalesInvLine."No.") and ItemCh."Excise Duties FND") then
                            VATProduct += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;

                        //split VAT
                        if TEMPAccSchedKPIBuffer.GET(SalesInvLine."VAT %") then begin
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer."Net Change Actual" += SalesInvLine."VAT Base Amount";
                            TEMPAccSchedKPIBuffer.MODIFY();
                        end else begin
                            TEMPAccSchedKPIBuffer.INIT();
                            TEMPAccSchedKPIBuffer."No." := SalesInvLine."VAT %";
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer."Net Change Actual" += SalesInvLine."VAT Base Amount";
                            TEMPAccSchedKPIBuffer.INSERT();
                        end;
                    until SalesInvLine.NEXT() = 0;

                TEMPAccSchedKPIBuffer.RESET();
                if TEMPAccSchedKPIBuffer.FINDSET() then
                    repeat
                        Counter += 1;
                        SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."No.") + '%';
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

                //HEI.10<<
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
                //HEI.10>>

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
                        Caption = 'No. of Copies';
                        ApplicationArea = all;
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
        LblGiro = 'Giro No.'; LblIban = 'IBAN:'; LblSwiftCode = 'Swift code:'; LblSignature = 'Signature:'; label(LblVatPercent; ENU = 'Vat Percent',
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
        ETDLbl = 'ETD:'; ETALbl = 'ETA:'; AirWayBillNoLbl = 'Air Way Bill No:'; label(CommodityCodeLbl; ENU = 'Commodity Code:',
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
        SalesSetup.GET();  //HEI.08
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        VATEntry: Record "VAT Entry";
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
        TaxAmout: Decimal;
        VATAmount: Decimal;
        DepAmount: Decimal;
        ShipAmount: Decimal;
        LineDisAmount: Decimal;
        ShippingChargesAmount: Decimal;
        MarkupChargesAmount: Decimal;
        CustomerAttributes: Record "Customer Attributes FND";
        CustomerAttributestext: Text[1024];
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
        TotalInvDis: Decimal;
        OriginalCopy: Text;
        TotalAmountLCY: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        Check: Report Check;
        DescriptionLine: array[2] of Text[85];
        TotalGrossWeight: Decimal;
        TotalNetWeight: Decimal;
        ItemChargeDisc: Decimal;
        InvDisAmount: Decimal;
        UnitPrice: Decimal;
        LineAmount: Decimal;
        DiscIncluded: Decimal;
        var_Dis: Decimal;
        //BC UPGRADE ATHUKS01 >>  Drink IT field 
        //StandardTextReport: Record "Standard Text Report";
        //BC UPGRADE ATHUKS01 <<  Drink IT field 
        TextFooter: array[3] of Text;
        CurrencyCode: Code[10];
        CompanyText: Text;
        CountryInfo: Record "Country/Region";
        ItemCh: Record "Item Charge";
        QuantityCrates: Decimal;
        BankAccountNo: Text[30];
        BankName: Text[50];
        IBAN: Code[50];
        SWIFTCode: Code[20];
        ASDIAmount: Decimal;
        TSBAmount: Decimal;
        VATProduct: Decimal;
        VATDeposit: Decimal;
        Text52000: Label 'Copy';
        Text52001: Label 'Total %1 Excl. VAT';
        Text52002: Label 'Total %1 Incl. VAT';
        Text52003: TextConst ENU = 'VAT @ %1 ', FRA = 'TVA @ %1';
        Text52004: Label 'Order Confirmation %1';
        Text52004B: Label 'Proforma Invoice %1';
        Text52005: Label 'Subtotal %1 Excl. VAT:';
        Text52005B: Label 'Subtotal %1 Incl. VAT:';
        Text52006: TextConst ENU = 'Sales Invoice', FRA = 'Facture de Vente';
        Text52007: TextConst ENU = 'Export Invoice', FRA = 'Facture d''Exportation';
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
        InvalidTxt: Label '**INVALID WITHOUT FISCAL OR REFUND RECEIPT ATTACHED**';
        Text50001: TextConst ENU = 'Excise Duties', FRA = 'Droits d''Accises';
        Text50002: Label 'Deposit Amount:';
        Text50003: TextConst ENU = 'Shipping Charges:', FRA = 'Frais de Transport';
        Text50004: Label 'Original';
        TaxNoID: Label 'Tax Number ID:';
        ChOfComm: Label 'Chamber of commerce:';
        ContactNo: Label 'Contact Number:';
        FaxNo: Label 'Fax Number:';
        EmailComp: Label 'E-mail:';
        TimbreAmount: Decimal;
        CADProduit: Decimal;
        CADDeposit: Decimal;
}

