report 53083 "Sundry Invoice Haiti"
{
    // version HEI.10

    // HEI.01 Report created
    // HEI.03 INC1003205 IBM HORTOC01 04.12.2018 #add new item charge discount
    // HEI.04 HT434 CHG2011093 Defect # 4329 IBM GAVANM01 20.08.2019
    //   # add OpCo footer image
    // HEI.05 CHG2031911 Defect # 4329 IBM GAVANM01 19.09.2019  # add info in footer from Company Info
    // HEI.06 FDD-HT915 IBM NASTAA02 27.09.2019 # OtC Billing – Invoice Layout local requirements for Domestic Invoice/Credit Memo/Sundry, and Export Invoice
    //   # Added 4 new Bank Accounts
    // HEI.07 IBM BULIMC01 25.10.2019 # defect 4627 # code added
    //    #new variable created (lineNumberVAT)
    //    # data item TEMPAccSchedKPIBuffer_VatPercent changed
    // HEI.08 Defect #5161 IBM NASTAA02 05.02.2020 # Fix Sundry Invoice not printing GL Account
    //   # Added filter on "Sales invoice Line" DataItem to show also the G/L Accounts
    //   # Fixed wrong Subtotal
    // HEI.09 HB1368 IBM GAVANM01 29.04.2020 #Correction to Invoice/Credit Note - Shipping Charge
    //   # code and layout changes
    // HEI.10 INC2918336 IBM NASTAA02 29.06.2020 # Printing multiple invoices
    //   # Implemented SetData, GetData functions on layout for the header text boxes
    // HEI.11 CHG2070324 IBM.GUNERE01 02.07.2020 # modifications on layout, DataSource SalesDiscount1 modified,
    //                                            PageLoop - OnAfterGetRecord, Sales Invoice Line - OnAfterGetRecord funcs.
    //                                            modified.
    // HEI.12 CHG2070787 IBM GAVANM01 02.09.2020 Update all Billing documents in line with Global (for the BAHAMAS)
    //   # Add Standard Text Report functionality for footer texts
    // HEI.13 CHG2073371 HB1589 IBM GAVANM01 28.09.2020  #St Lucia Item charges Shipping Cost not working
    //   # Item charges of type Discount and Transport/Shipping Cost = TRUE should be considered as Shipping Cost
    // 
    // *** NEW REPORT *******************************************************************************************************
    // 
    // HEI.14 FDD-HT1401 IBM BULIMC01 01.03.2021 new Report created for Haiti
    //   # Saved as from Report 50278(Sales Sundry Invoice STD) so kept the old documentation as above under starred line, didn't delete
    // HEI.15 HT2194 CHG2107750 IBM GAVANM01 26.05.2021 – Excise Duties Haiti
    //   # code changes
    // HEI.16 INC3617037 IBM BULIMC01 26/07/2021
    //   #Tax Summary should display VAT for deposits in case of free goods
    //   #TotalInvDisc is not showing the correct value

    //Bc Upgrade YADAVM09 Drink it fields and code are blocked.
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Sundry Invoice Haiti.rdl';

    Caption = 'Sales Invoice - Sundry STD';
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;

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
            column(CompanyInfo_Picture; CompanyInfo."OpCo Logo FND")
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
                    column(SalesPrintDate; FORMAT(WORKDATE, 0, '<Day,2>/<Month,2>/<Year4>'))
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
                    column(BillToCredLimit; FORMAT(BillToCustomer."Credit Limit (LCY)"))
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
                    column(SellCustomerNo; "Sales Invoice Header"."Sell-to Customer No.")
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
                    column(SalesInvHeader_OrderDate; FORMAT("Sales Invoice Header"."Order Date", 0, '<Day,2>/<Month,2>/<Year4>'))
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
                    column(InCoTerms; "Sales Invoice Header"."Shipment Method Code")
                    {
                    }
                    column(ItemChargeDisc; ItemChargeDisc)
                    {
                    }
                    column(InvDisAmount; InvDisAmount)
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER(Item | Resource | "Fixed Asset" | '"Charge (Item)"'));
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
                        column(HideExcDutyLine; HideExcDutyLine)
                        {
                        }
                        column(NumberText; NumberText)
                        {
                        }

                        trigger OnAfterGetRecord();
                        var
                            SalesInvoiceLine: Record "Sales Invoice Line";
                        begin
                            //HEI.09>>

                            DiscIncluded := 0;
                            //HEI.14<<
                            //Bc Upgrade YADAVM09 Dependency on Drik it field>>
                            // if "Item Charge Type" = "Item Charge Type"::Discount then
                            //     UnitPrice := -"Unit Price"
                            // else
                            //     //HEI.14>>
                            //     UnitPrice := "Unit Price";
                            //Bc Upgrade YADAVM09 Dependency on Drik it field<<
                            LineAmount := "Line Amount";
                            HideExcDutyLine := false; //HEI.14
                                                      //Bc Upgrade YADAVM09 Dependency on drink it field>>
                                                      // if Type <> Type::"Charge (Item)" then begin
                                                      //     //Include in Item Price
                                                      //     SalesInvoiceLine.RESET;
                                                      //     SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                                                      //     SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
                                                      //     SalesInvoiceLine.SETRANGE("Attached to Line No.", "Line No.");
                                                      //     SalesInvoiceLine.SETRANGE("Item Charge Type", SalesInvoiceLine."Item Charge Type"::Discount);
                                                      //     SalesInvoiceLine.SETRANGE("Show Item charge on Invoice", SalesInvoiceLine."Show Item charge on Invoice"::"Include in item price");
                                                      //     if SalesInvoiceLine.FINDSET then
                                                      //         repeat
                                                      //             if ItemCh.GET(SalesInvoiceLine."No.") and not ItemCh."Transport/Shipping Cost" then begin  //HEI.13
                                                      //                 LineAmount += SalesInvoiceLine."Line Amount";
                                                      //                 //DiscIncluded += ABS(SalesInvoiceLine."Line Amount");
                                                      //                 DiscIncluded += SalesInvoiceLine."Line Amount"; //HEI.11
                                                      //                 if SalesInvoiceLine.Quantity <> 0 then
                                                      //                     UnitPrice := LineAmount / ABS(Quantity);
                                                      //             end //HEI.13
                                                      //         until SalesInvoiceLine.NEXT = 0;
                                                      // end else if ("Item Charge Type" <> "Item Charge Type"::Discount) or
                                                      //   ("Show Item charge on Invoice" = "Show Item charge on Invoice"::"Include in item price") then
                                                      //         if ItemCh.GET("No.") and not ItemCh."Transport/Shipping Cost" then   //HEI.13
                                                      //             CurrReport.SKIP;
                                                      // //HEI.09<<

                            // //HEI.14<<
                            // if ("Item Charge Type" = "Item Charge Type"::Discount) or ("Item Charge Type" = "Item Charge Type"::Tax) then
                            //     //IF (ItemCh.GET("No.")) AND (ItemCh."Hide Item charge on printout") THEN  //commented by HEI.15
                            //     if (ItemCh.GET("No.")) and (ItemCh."Tax Due Posting to G/L") then   //HEI.15
                            //         HideExcDutyLine := true;
                            // //HEI.14
                            //HEI.14
                            //Bc Upgrade YADAVM09 Dependency on drink it field<<


                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;


                            //var_Dis := ABS("Line Discount Amount");
                            //var_Dis := "Line Discount Amount"; //HEI.12 HEI.14
                            var_Dis := "Line Discount %"; //HEI.14
                            //Bc Upgrade YADAVM09 Dependency on drink it field>>
                            // if (Type = Type::"Charge (Item)") and ("Item Charge Type" = "Item Charge Type"::Discount) then
                            //     if ItemCh.GET("No.") and not ItemCh."Transport/Shipping Cost" then  //HEI.13
                            //                                                                         //var_Dis += ABS("Line Amount");
                            //                                                                         //IF NOT ItemCh."Hide Item charge on printout" THEN //HEI.14  //commented by HEI.15
                            //         if not ItemCh."Tax Due Posting to G/L" then //HEI.15
                            //             var_Dis += ABS("Item Charge Value"); //HEI.14

                            //Bc Upgrade YADAVM09 Dependency on drink it field<<

                            //HEI.14<<
                            InitTextVariables;
                            NumberText := GetAmtToText(ROUND(TotalInvDis, 0.01), '');
                            //HEi.14>>
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
                        column(BaseAmount; TEMPAccSchedKPIBuffer."Balance at Date Actual")
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
                        CLEAR(ItemChargeDisc);  //HEI.09

                        DocumentTitleText := STRSUBSTNO(Text52007, CopyText);
                        //Bc Upgrade YADAVM09 Dependency on drink it field>>
                        // SalesInvLineAmt.RESET;
                        // SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        // //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset"); //commented by HEI.13
                        // if SalesInvLineAmt.FINDSET then
                        //     repeat
                        //         if (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") or (SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::" ") then  //HEI.13
                        //             InvLineTotal += SalesInvLineAmt."Line Amount";
                        //     until SalesInvLineAmt.NEXT = 0;
                        //Bc Upgrade YADAVM09 Dependency on drink it field<<

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;
                        //Bc Upgrade YADAVM09 Dependency on drink it field>>
                        // SalesInvLine.RESET;
                        // SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        // SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        // if SalesInvLine.FINDSET then
                        //     repeat
                        //         case SalesInvLine."Item Charge Type" of
                        //             SalesInvLine."Item Charge Type"::Tax:
                        //                 //IF ItemCh.GET(SalesInvLine."No.") AND ItemCh."Hide Item charge on printout" THEN  //HEI.14  //commented by HEI.15
                        //                 if ItemCh.GET(SalesInvLine."No.") and ItemCh."Tax Due Posting to G/L" then //HEI.15
                        //                     TotalFooterAmount[1] += SalesInvLine."Line Amount";
                        //             SalesInvLine."Item Charge Type"::Deposit:
                        //                 TotalFooterAmount[2] += SalesInvLine."Line Amount";
                        //             SalesInvLine."Item Charge Type"::"Shipping Cost":
                        //                 TotalFooterAmount[3] += SalesInvLine."Line Amount";
                        //             SalesInvLine."Item Charge Type"::Discount:
                        //                 //HEI.13>>
                        //                 begin
                        //                     if ItemCh.GET(SalesInvLine."No.") and ItemCh."Transport/Shipping Cost" then
                        //                         TotalFooterAmount[3] += SalesInvLine."Line Amount"
                        //                     else
                        //                         //HEI.13<<
                        //                         //TotalFooterAmount[4] += ABS(SalesInvLine."Line Amount");
                        //                         if SalesInvLine."Show Item charge on Invoice" <> SalesInvLine."Show Item charge on Invoice"::"Include in item price" then
                        //                             if ItemCh.GET(SalesInvLine."No.") then  //HEI.15
                        //                                                                     //IF (ItemCh.GET(SalesInvLine."No.")) AND (ItemCh."Hide Item charge on printout" = FALSE) THEN BEGIN //HEI.16  //commented by HEI.15
                        //                                 if not ItemCh."Tax Due Posting to G/L" then begin //HEI.15
                        //                                     TotalFooterAmount[4] += SalesInvLine."Line Amount"; //HEI.12
                        //                                                                                         //TotalInvDis += SalesInvLine."Line Amount";  //HEI.16 commented
                        //                                     TotalInvDis += ABS(SalesInvLine."Line Amount");  //HEI.16
                        //                                 end
                        //                                 //HEI.16
                        //                                 //IF ItemCh.GET(SalesInvLine."No.") AND ItemCh."Hide Item charge on printout" THEN   //commented by HEI.15
                        //                                 else  //HEI.15
                        //                                     TotalFooterAmount[1] += SalesInvLine."Line Amount";
                        //                     //HEI.14<<
                        //                 end;  //HEI.13
                        //         end;
                        //     until SalesInvLine.NEXT = 0;
                        //Bc Upgrade YADAVM09 Dependency on drink it field<<

                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        ShipAmount := TotalFooterAmount[3];  //HEI.07
                                                             //Bc Upgrade YADAVM09 Dependency on drink it field>>
                                                             //SalesInvLine.RESET;
                                                             //SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                                                             //SalesInvLine.SETRANGE(Type,SalesInvLine.Type::"Charge (Item)");  //commented by HEI.09
                                                             //if SalesInvLine.FINDSET then
                                                             //repeat
                                                             //IF ItemCh.GET(SalesInvLine."No.") AND NOT ItemCh."Hide Item charge on printout" THEN BEGIN //HEI.16  //commented by HEI.15

                        // if ItemCh.GET(SalesInvLine."No.") and not ItemCh."Tax Due Posting to G/L" then begin //HEI.15
                        //     TotalFooterAmount[4] += ABS(SalesInvLine."Inv. Discount Amount");
                        //     TotalFooterAmountText[4] := SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                        //     TotalFooterAmount[5] += ABS(SalesInvLine."Line Discount Amount");
                        //     TotalFooterAmountText[5] := SalesInvLine.FIELDCAPTION("Line Discount Amount");
                        // end else begin
                        //     TotalFooterAmount[4] += ABS(SalesInvLine."Inv. Discount Amount");
                        //     TotalFooterAmount[5] += ABS(SalesInvLine."Line Discount Amount");
                        //     if not SalesInvLine."Free Item" then
                        //         TotalInvDis += ABS(SalesInvLine."Inv. Discount Amount")
                        //     else
                        //         TotalInvDis += ABS(SalesInvLine."Line Discount Amount");
                        // end;

                        //until SalesInvLine.NEXT = 0;
                        //Bc Upgrade YADAVM09 Dependency on drink it field<<

                        InvDisAmount := TotalFooterAmount[4];
                        LineDisAmount := TotalFooterAmount[5];

                        AmttoPaid := InvLineTotal + VATAmount + TaxAmout + ShipAmount - InvDisAmount - LineDisAmount;
                        InvTotalAmount := AmttoPaid + DepAmount;
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
                    CLEAR(ItemChargeDisc);  //HEI.09
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
                LanguageMgt: Codeunit Language;//Bc Upgrade YADAVM09<<
            begin
                //HEI.12>>
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
                //Bc Upgrade YADAVM09 Dependency on drink it field>>
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
                //HEI.12<<
                //Bc Upgrade YADAVM09 Dependency on drink it field<<

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
                        //CompanyText += ', ' + CompanyInfo."Country/Region Code" + ' ' + CountryInfo.Name; //HEI.14
                        CompanyText += ', ' + CountryInfo.Name; //HEI.14
                //HEI.14
                if CompanyInfo."VAT Registration No." <> '' then
                    CompanyText += ', ' + 'VAT No.: ' + CompanyInfo."VAT Registration No.";
                //CompanyText += ', ' + ChOfComm;
                if CompanyInfo."Phone No." <> '' then
                    CompanyText += ', ' + 'Telephone: ' + CompanyInfo."Phone No.";
                if CompanyInfo."E-Mail" <> '' then
                    CompanyText += ', ' + 'E-mail: ' + CompanyInfo."E-Mail";
                //HEI.14<<

                TEMPAccSchedKPIBuffer.DELETEALL;
                if Country.GET(CompanyInfo."Country/Region Code") then
                    CompanyInfoContryName := Country.Name;

                // CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");//Bc Upgrade YADAVM09<<
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageID("Language Code");//Bc Upgrade YADAVM09<<

                if SalesPerson.GET("Sales Invoice Header"."Salesperson Code") then;

                if ShipmentMethod.GET("Sales Invoice Header"."Shipment Method Code") then
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Invoice Header"."Language Code");

                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Invoice Header"."Language Code");

                PaymentMethod.RESET;
                if PaymentMethod.GET("Payment Method Code") then;

                //HEI.14
                /*IF "Currency Code" = '' THEN BEGIN
                  GLSetup.TESTFIELD("LCY Code");
                  TotalExText := STRSUBSTNO(Text52001,GLSetup."LCY Code");
                  TotalInText := STRSUBSTNO(Text52002,GLSetup."LCY Code");
                  SubTotalInText := STRSUBSTNO(Text52005B,GLSetup."LCY Code");
                  SubTotalExText := STRSUBSTNO(Text52005,GLSetup."LCY Code");
                END ELSE BEGIN
                  TotalExText := STRSUBSTNO(Text52001,"Currency Code");
                  TotalInText := STRSUBSTNO(Text52002,"Currency Code");
                  SubTotalInText := STRSUBSTNO(Text52005B,"Currency Code");
                  SubTotalExText := STRSUBSTNO(Text52005,"Currency Code");
                END;  */

                //HEI.14
                TotalExText := Text52001;
                TotalInText := Text52002;
                SubTotalInText := Text52005B;
                SubTotalExText := Text52005;
                //HEI.14


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
                //SalesInvLine.SETFILTER("VAT %",'<>%1',0); //HEI.14
                if SalesInvLine.FINDFIRST then
                    VATPer := SalesInvLine."VAT %";

                if "Sales Invoice Header"."Prices Including VAT" = true then
                    PriceIncVAT := 'Yes'
                else
                    PriceIncVAT := 'No';

                VatAmt := 0;
                lineNumberVAT := 0;  //HEI.07
                                     //Bc Upgrade YADAVM09 Drink it Fields>>
                                     // SalesInvLine.RESET;
                                     // SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                                     // //SalesInvLine.SETFILTER("VAT %",'<>%1',0); HEI.14
                                     // if SalesInvLine.FINDSET then
                                     //     repeat
                                     //         if not SalesInvLine."Free Item" then begin //HEI.14
                                     //             VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                                     //             VATAmount := ABS(VatAmt);
                                     //         end; //HEI.14


                //split VAT
                //IF TEMPAccSchedKPIBuffer.GET(SalesInvLine."VAT %") THEN BEGIN  //commented by HEI.07
                //HEI.07>>
                //TEMPAccSchedKPIBuffer.RESET;
                //TEMPAccSchedKPIBuffer.SETRANGE("Balance at Date Forecast", SalesInvLine."VAT %");
                //if TEMPAccSchedKPIBuffer.FINDFIRST then begin
                //IF NOT SalesInvLine."Free Item" THEN BEGIN //HEI.14 //HEI.16commented
                // if (not SalesInvLine."Free Item") or (SalesInvLine."Item Charge Type" = SalesInvLine."Item Charge Type"::Deposit) then begin //HEI.16 //Bc Upgrade YADAVM09 Drink it Fields>>
                //     TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100; //Bc Upgrade YADAVM09 Drink it Fields>>
                //HEI.14
                //if TEMPAccSchedKPIBuffer."Balance at Date Forecast" <> 0 then
                //  TEMPAccSchedKPIBuffer."Balance at Date Actual" := (100 / TEMPAccSchedKPIBuffer."Balance at Date Forecast") * TEMPAccSchedKPIBuffer."Net Change Budget"
                // else
                //  TEMPAccSchedKPIBuffer."Balance at Date Actual" += SalesInvLine."Line Amount";
                //HEI.14
                //TEMPAccSchedKPIBuffer.MODIFY;
                //end; //HEI.14 //Bc Upgrade YADAVM09 Drink it Fields<<
                //end else begin
                //TEMPAccSchedKPIBuffer."No." := SalesInvLine."VAT %";   //commented by HEI.07
                //HEI.07>>
                // lineNumberVAT += 1;
                // TEMPAccSchedKPIBuffer.INIT;
                // TEMPAccSchedKPIBuffer."No." := lineNumberVAT;
                // TEMPAccSchedKPIBuffer."Balance at Date Forecast" := SalesInvLine."VAT %";
                //IF NOT SalesInvLine."Free Item" THEN BEGIN //HEI.14 //HEI.16commented
                // if (not SalesInvLine."Free Item") or (SalesInvLine."Item Charge Type" = SalesInvLine."Item Charge Type"::Deposit) then begin //HEI.16
                //TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                //HEI.14
                //if TEMPAccSchedKPIBuffer."Balance at Date Forecast" <> 0 then
                //   TEMPAccSchedKPIBuffer."Balance at Date Actual" := (100 / TEMPAccSchedKPIBuffer."Balance at Date Forecast") * TEMPAccSchedKPIBuffer."Net Change Budget"
                //else
                //TEMPAccSchedKPIBuffer."Balance at Date Actual" := SalesInvLine."Line Amount";
                //end;//Bc Upgrade YADAVM09 Drink it fields<<
                //HEI.14
                //TEMPAccSchedKPIBuffer.INSERT;
                //end;
                //until SalesInvLine.NEXT = 0;
                //Bc Upgrade YADAVM09 Dependency on Drink it fields<<

                TEMPAccSchedKPIBuffer.RESET;
                if TEMPAccSchedKPIBuffer.FINDSET then
                    repeat
                        Counter += 1;
                        //SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."No.") + '%'; //commented HEI.07
                        SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%'; //HEI.07
                        SplitVatAmount[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Net Change Budget", 0, '<Sign><Integer Thousand><Decimals,3>');
                    until TEMPAccSchedKPIBuffer.NEXT = 0;

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

                //HEI.14
                CLEAR(BankAccountNo);
                CLEAR(BankName);
                CLEAR(IBAN);
                CLEAR(SWIFTCode);

                if SalesSetup."Bank based on inv currency FND" then begin
                    BankAccount.RESET;
                    BankAccount.SETRANGE("Bank for invoice layout FND", true);
                    BankAccount.SETRANGE("Currency Code", "Currency Code");
                    if not BankAccount.FINDFIRST then begin
                        BankAccount.RESET;
                        BankAccount.SETRANGE("Bank for invoice layout FND", true);
                        BankAccount.SETFILTER("Currency Code", '=%1', '');
                        if BankAccount.FINDFIRST then;
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
                //HEI.14<<

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
                        Caption = 'No. of Copies';//Bc Upgrade YADAVM09<<
                        ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
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
                          FRA = 'Conditions Paiement')
        label(lblShipMethod; ENU = 'Shipment Method',
                            FRA = 'Condition de Livraison')
        label(lblAmtPaid; ENU = 'Subtotal:',
                         FRA = 'Montant A Payer')
        label(lblSalesCondition; ENU = 'The Sale Conditions on the back side',
                                FRA = 'Conditions generales de vento ou envers')
        lblTotalQty = 'Total Quantity'; lblSalesPerson = 'Sales Person ID:'; lblUOM = 'Unit'; lblUnitPrice = 'Unit Price'; lblSaleLAmt = 'Amount Excl. VAT'; lblPageNo = 'Page No:'; lblOrderNo = 'SO Order No:'; lblInvoiceNo = 'Invoice No:'; lblVATAmt = 'Total VAT:'; lblPostDate = 'Invoice Date:'; lblDueDate = 'Due Date:'; lblPriceIncVAT = 'Price Including VAT'; lblDriver = 'Name and Driver Signature'; lblWarehouse = 'Name and Warehouse Keeper Signature'; lblSecurity = 'Name and Security Visa'; label(lblPrintDate; ENU = 'Print Date:',
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      FRA = 'Date d''impression')
        LblBillToAddress = 'BILL TO:'; LblCustomerName = 'Customer Name:'; LblAddress = 'Address 1:'; LblAddress2 = 'Address 2:'; LblPostCode = 'Post Code:'; LblCity = 'City:'; LblCountry = 'Country:'; LblVatRegistrationNo = 'Vat Registration No:'; LblCompanyTaxId = 'Company Tax ID:'; LblSoldToAddress = 'CUSTOMER:'; LblCustomerPoNo = 'Customer PO No:'; LblTaxDetails = 'Tax Summary'; LblBankInfo = 'Bank Details:'; LblAccountNo = 'Account No:'; LblBankName = 'Bank:'; LblGiro = 'Giro No.'; LblIban = 'Iban:'; LblSwiftCode = 'Swift Code:'; LblSignature = 'Signature:'; LblVatPercent = 'Vat Percent'; LblVatAmount = 'Vat Amount'; LblIncoTerm = 'Shipment Method:'; Lbldisc = 'Disc.'; LblShipToAddress = 'Ship to Address:'; LblCustomerNo = 'Customer No:'; LblInvoiceCurrency = 'Invoice Currency:'; LblVersion = 'Version:'; LblItemNo = 'Item No.'; LblQty = 'Qty'; LblPayMethod = 'Payment Method:'; LblInvoiceCurrLCY = 'Invoice Curr LCY:'; LblTotalToBePaid = 'Total to be paid:'; LblDiscTotal = 'Disc Total:'; BankInfo2Lbl = 'Bank Details 2:'; BankInfo3Lbl = 'Bank Details 3:'; BankInfo4Lbl = 'Bank Details 4:'; CustomerServiceEmailLbl = 'Customer Service E-Mail:'; LblTaxAmt = 'Tax Amount'; LblBaseAmt = 'Tax Base'; LblCustCreditLimit = 'Customer Credit Limit:'; LblOrderDate = 'Order Date:'; LblDriverSign = 'Driver Signature:'; LblOpco = 'OpCo Name:'; LblPostCodeCity = 'Post code & City:'; LblVATRate = 'VAT Rate';
    }

    trigger OnInitReport();
    begin
        GLSetup.GET;
        SalesSetup.GET;  //HEI.12
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND");  //HEI.04
        CompanyInfo.CALCFIELDS("OpCo Logo FND", "OpCo Logo FND"); //HEI.14
        GeneralOpCoSetup.GET; //HEI.06
    end;

    var
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        VATEntry: Record "VAT Entry";
        //Language: Record Language;//Bc Upgrade YADAVM09 not required<<
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
        Text52001: Label 'Total Excl. VAT';
        Text52002: Label 'Total Incl. VAT';
        Text52003: TextConst ENU = 'VAT @ ', FRA = 'TVA @ %1';
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
        Text52005: Label 'Subtotal Excl. VAT:';
        Text52005B: Label 'Subtotal Incl. VAT:';
        Text52006: Label 'Sales Invoice';
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
        Text50002: Label 'Deposit Amount:';
        Text50003: Label 'Shipping Charges:';
        Text50004: Label 'Original';
        OriginalCopy: Text;
        TotalAmountLCY: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        CompanyText: Text;
        CountryInfo: Record "Country/Region";
        TaxNoID: Label 'Tax Number ID:';
        ChOfComm: Label 'Chamber of commerce:';
        ContactNo: Label 'Contact Number:';
        FaxNo: Label 'Fax Number:';
        EmailComp: Label 'E-mail:';
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        lineNumberVAT: Integer;
        ItemChargeDisc: Decimal;
        InvDisAmount: Decimal;
        UnitPrice: Decimal;
        LineAmount: Decimal;
        DiscIncluded: Decimal;
        var_Dis: Decimal;
        //StandardTextReport: Record "Standard Text Report";//Bc Upgrade YADAVM09 Drink it object.
        TextFooter: array[3] of Text;
        CurrencyCode: Code[10];
        ItemCh: Record "Item Charge";
        BankAccountNo: Text[30];
        BankName: Text[50];
        IBAN: Code[50];
        SWIFTCode: Code[20];
        TaxFreeAmount: Decimal;
        TotalVATAmount: Decimal;
        HideExcDutyLine: Boolean;
        BankAccount: Record "Bank Account";
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ThousText: array[5] of Text;
        NumberText: Text;
        TotalToBePaid: Decimal;
        AmountInWords: Text;
        WholeInWords: Text;
        DecimalInWords: Text;
        WholePart: Integer;
        DecimalPart: Integer;

    local procedure InitTextVariables();
    begin
        //HEI.14<<
        OnesText[1] := 'One';
        OnesText[2] := 'Two';
        OnesText[3] := 'Three';
        OnesText[4] := 'Four';
        OnesText[5] := 'Five';
        OnesText[6] := 'Six';
        OnesText[7] := 'Seven';
        OnesText[8] := 'Eight';
        OnesText[9] := 'Nine';
        OnesText[10] := 'Ten';
        OnesText[11] := 'Eleven';
        OnesText[12] := 'Twelve';
        OnesText[13] := 'Thirteen';
        OnesText[14] := 'Fourteen';
        OnesText[15] := 'Fifteen';
        OnesText[16] := 'Sixteen';
        OnesText[17] := 'Seventeen';
        OnesText[18] := 'Eighteen';
        OnesText[19] := 'Nineteen';

        TensText[1] := '';
        TensText[2] := 'Twenty';
        TensText[3] := 'Thirty';
        TensText[4] := 'Forty';
        TensText[5] := 'Fifty';
        TensText[6] := 'Sixty';
        TensText[7] := 'Seventy';
        TensText[8] := 'Eighty';
        TensText[9] := 'Ninty';

        ThousText[1] := 'Hundred';
        ThousText[2] := 'Thousand';
        ThousText[3] := 'Million';
        ThousText[4] := 'Billion';
        ThousText[5] := 'Trillion';
        //HEI.14<<
    end;

    local procedure NumberToWords(Number: Decimal; AppendScale: Text): Text;
    var
        NumString: Text;
        Pow: Integer;
        PowStr: Text;
        Log: Integer;
    begin
        //HEI.14<<
        NumString := '';
        if Number < 100 then
            if Number < 20 then begin
                if Number <> 0 then NumString := OnesText[Number];
            end else begin
                NumString := TensText[Number div 10];
                if (Number mod 10) > 0 then
                    NumString := NumString + ' ' + OnesText[Number mod 10];
            end
        else begin
            Pow := 0;
            PowStr := '';
            if Number < 1000 then begin // number is between 100 and 1000
                Pow := 100;
                PowStr := ThousText[1];
            end else begin // find the scale of the number
                Log := ROUND(STRLEN(FORMAT(Number div 1000)) / 3, 1, '>');
                Pow := POWER(1000, Log);
                PowStr := ThousText[Log + 1];
            end;

            NumString := NumberToWords(Number div Pow, PowStr) + ' ' + NumberToWords(Number mod Pow, '');
        end;

        exit(DELCHR(NumString, '<>', ' ') + ' ' + AppendScale);
        //HEI.14<<
    end;

    local procedure GetAmtToText(Number: Decimal; AppendScale: Text): Text;
    begin
        //HEI.14<<
        WholePart := ROUND(ABS(Number), 1, '<');
        DecimalPart := ABS((ABS(Number) - WholePart) * 100);

        WholeInWords := NumberToWords(WholePart, AppendScale);

        if DecimalPart <> 0 then begin
            DecimalInWords := NumberToWords(DecimalPart, '');
            WholeInWords := WholeInWords + '& ' + DecimalInWords + 'cents';
        end;

        exit(WholeInWords);
        //HEI.14>>
    end;
}

