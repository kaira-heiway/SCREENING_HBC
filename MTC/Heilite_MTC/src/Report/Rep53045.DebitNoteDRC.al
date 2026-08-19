report 53045 "Debit Note DRC"
{
    // version HEI.01

    // HEI.01 CHG2055075 HT1156 GAVANM01 05.05.2020 - New report created
    // HEI.02 CHG2055075 HT1156 POENAB02 09.07.2020 - Added "OpCo Footer image" in the layout
    // HEI.04 CHG2085435 IBM GAVANM01 25.11.2020 - HT1773 Sales documents layout
    //   # layout changes
    //   # if all item charges of type FPI, Excise Duties, Consumption Tax or Incl. In Transport Cost are marked as Hide Item charge on printout, then
    //     they will be hide in the Totals sections

    // BC Upgrade KUMARR78 >>
    // Report Name  : Debit Note DRC
    // Old Report ID: 50447 (NAV - HEI.01 Version)
    // 1. Added Business Central visibility properties.
    //    Old: ApplicationArea and UsageCategory were not defined in NAV.
    //    New:
    //         - ApplicationArea = All
    //         - UsageCategory = ReportsAndAnalysis
    //    Reason: Mandatory for Business Central SaaS report discoverability and role-based visibility.
    // 2. Replaced deprecated Language table usage with Codeunit.
    //    Old:
    //         - Language: Record Language
    //         - CurrReport.LANGUAGE := Language.GetLanguageID(DocLanguage);
    //    New:
    //         - LanguageG: Codeunit Language
    //         - CurrReport.Language := LanguageG.GetLanguageId(DocLanguage);
    //    Reason: GetLanguageId function moved from Language table to Codeunit in BC.
    // 3. Removed/Blocked DIT-specific variables and fields.
    //    Old:
    //         - DocSubtypeCodeSetup: Record "Document Subtype Code Setup FND";
    //         - CompanyInfo."Tax Registration No." usage in CompanyText
    //         - "Free Item" field on Sales Invoice Line
    //         - "Free Calculation Type"
    //         - "Item Charge Type" dependent DIT logic
    //    New:
    //         - Variables commented/removed
    //         - DIT-dependent logic blocked
    //    Reason: Fields not available in standard BC base application.

    // 4. Modified Charge (Item) skipping logic.
    //    Old:
    //         Condition based on:
    //           Type = Charge (Item)
    //           AND "Item Charge Type" <> blank
    //    New:
    //         If Type = Charge (Item) then
    //             CurrReport.Skip();
    //    Reason: Simplified condition due to removal of custom Item Charge Type logic in BC.
    // 5. Blocked legacy Item Charge detailed calculation block.
    //    Old:
    //         Complex logic calculating:
    //             - Tax
    //             - Deposit
    //             - Shipping
    //             - Discount
    //             - Excise Duties
    //             - FPI
    //             - Consumption Tax
    //         Based on Item Charge Type and DIT fields.
    //    New:
    //         Entire block commented/blocked.
    //         Only standard discount accumulation retained.
    //    Reason: DIT custom fields not available in BC; preventing compilation errors.
    // 6. Request Page BC compliance.
    //     Added:
    //         ApplicationArea = All on:
    //             - "No. of Copies"
    //     Reason: Required for BC UI rendering.
    // 7. Variables Added / Modified for BC Compatibility.
    //     Added:
    //         - LanguageG : Codeunit Language
    //
    //     Removed / Blocked:
    //         - Language : Record Language
    //         - DocSubtypeCodeSetup : Record "Document Subtype Code Setup FND"
    //         - DIT-specific item charge related logic
    //
    //     Modified Usage:
    //         - CurrReport.Language instead of CurrReport.LANGUAGE
    // 8. Blocking DIT Colomn and Passing Blank Value.
    //
    //     -Old CompanyInfo_TAX= CompanyInfo."Tax Registration No.";
    //     -Old FreeItem= "Sales Invoice Line"."Free Item"
    //
    //     -New CompanyInfo_TAX= '';
    //     -New FreeItem='';
    // BC Upgrade KUMARR78 <<

    DefaultLayout = RDLC;
    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding UsageCategory
    RDLCLayout = '.\src\ReportsLayout\Debit Note DRC.rdl';

    CaptionML = ENU = 'Debit Note DRC',
                FRA = 'Note de Débit DRC',
                ENG = 'Debit Note DRC';
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;

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
            column(CompanyInfo_RCCM; CompanyInfo."RCCM Legal entity code FND")
            {
            }
            column(CompanyInfo_VAT; CompanyInfo."VAT Registration No.")
            {
            }
            // column(CompanyInfo_TAX; CompanyInfo."Tax Registration No.")
            // {
            // }//BC Upgrade KUMARR78 DIT Field
            column(CompanyInfo_TAX; '')//BC Upgrade KUMARR78 Passing Blank Value in Expression.
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
            column(TxtRCCM; TxtRCCM)
            {
            }
            column(TxtVAT; TxtVAT)
            {
            }
            column(TxtTAX; TxtTAX)
            {
            }
            column(TxtFiscal; TxtFiscal)
            {
            }
            column(TxtAccountCurrency; TxtAccountCurrency)
            {
            }
            column(TxtAccountHolder; TxtAccountHolder)
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
            column(LCYCode; GLSetup."LCY Code")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(SellToCustAttributesNIF; CustomerAttributes1.NIF)
                    {
                    }
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
                    column(SalesHPostDate; Format("Sales Invoice Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesHDueDate; Format("Sales Invoice Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesHDocDate; Format("Sales Invoice Header"."Document Date", 0, 4))
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
                    column(SubTotal; Round(InvLineTotal, 0.01, '='))
                    {
                    }
                    column(FreeSubTotal; Round(FreeInvLineTotal, 0.01, '='))
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
                    column(ExciseDutiesAmtCaption; TotalFooterAmountText[8])
                    {
                    }
                    column(FPIAmtCaption; TotalFooterAmountText[9])
                    {
                    }
                    column(ConsTaxAmtCaption; TotalFooterAmountText[10])
                    {
                    }
                    column(FPIAmout; FPIAmout)
                    {
                    }
                    column(ExcideDutiesAmount; ExcideDutiesAmount)
                    {
                    }
                    column(ConsTaxAmout; ConsTaxAmout)
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
                    column(CurrencyCode; CurrencyCode)
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
                    column(TotalVATAmnt; TotalVATAmnt)
                    {
                    }
                    column(HideFPI; HideFPI)
                    {
                    }
                    column(HideConsTax; HideConsTax)
                    {
                    }
                    column(HideExciseDuties; HideExciseDuties)
                    {
                    }
                    column(HideTransCost; HideTransCost)
                    {
                    }
                    column(FreeFTPAmount; FreeFTPAmount)
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting("Document No.", "Line No.");
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
                        column(SalesPrice; Round("Sales Invoice Line"."Unit Price", 1, '='))
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
                        // column(FreeItem; "Sales Invoice Line"."Free Item")
                        // {
                        // } //BC Upgrade KUMARR78 DIT Field Removed.

                        column(FreeItem; '')
                        {
                        }
                        //BC Upgrade KUMARR78 Passing Blank Value in Expression.
                        column(LineDiscountAmount; "Sales Invoice Line"."Line Discount Amount")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            //BC UPGRADE KUMARR78>> Blocking for Change Expression
                            // if ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)")
                            //   and ("Sales Invoice Line"."Item Charge Type" <> "Sales Invoice Line"."Item Charge Type"::" ") then
                            //     CurrReport.Skip()
                            //BC UPGRADE KUMARR78<< Blocking To Change Condition
                            if ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)") then //BC UPGRADE KUMARR78<< Adding To Change Condition
                                CurrReport.Skip() //BC UPGRADE KUMARR78<< Adding To Change Condition
                            else begin
                                NUMLines := NUMLines - 1;
                                LinesPrinted := LinesPrinted + 1;

                                TotalInvDis += "Sales Invoice Line"."Line Discount Amount";
                            end;
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
                        //HEI.04<<
                        Clear(FreeInvLineTotal);
                        HideFPI := true;
                        HideConsTax := true;
                        HideExciseDuties := true;
                        HideTransCost := true;
                        FPIExists := false;
                        ConsTaxExists := false;
                        ExciseDutiesExists := false;
                        TransCostExists := false;
                        Clear(FreeFTPAmount);
                        //HEI.04>>

                        DocumentTitleText := StrSubstNo(Text52006, CopyText);

                        // SalesInvLineAmt.Reset();
                        // SalesInvLineAmt.SetRange("Document No.", "Sales Invoice Header"."No.");
                        // SalesInvLineAmt.SetFilter(Type, '<>%1', SalesInvLineAmt.Type::" ");
                        // if SalesInvLineAmt.FindSet() then
                        //     repeat
                        //         if (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") or (SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::" ") then
                        //         //InvLineTotal += SalesInvLineAmt.Amount; //commented by HEI.04
                        //         //HEI.04<<
                        //         begin
                        //             InvLineTotal += SalesInvLineAmt.Amount;
                        //             if SalesInvLineAmt."Free Item" then
                        //                 FreeInvLineTotal += SalesInvLineAmt."Line Discount Amount";
                        //         end
                        //     //HEI.04>>
                        //     until SalesInvLineAmt.Next() = 0;

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;
                        //HEI.03>>
                        TotalFooterAmountText[8] := TxtExciseDuties;
                        TotalFooterAmountText[9] := TxtFPI;
                        TotalFooterAmountText[10] := TxtConsTax;
                        //HEI.03<<

                        //BC UPGRADE KUMARR78 >> Blocking As DIT Field Removed in BC
                        // SalesInvLine.Reset();
                        // SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                        // SalesInvLine.SetRange(Type, SalesInvLine.Type::"Charge (Item)");
                        // if SalesInvLine.FindSet() then
                        //     repeat
                        //         //HEI.04<<
                        //         FreeCharge := false;
                        //         if (SalesInvLine."Free Calculation Type" = SalesInvLine."Free Calculation Type"::"Discount 100%") and SalesInvLine."Free Item" then
                        //             FreeCharge := true;
                        //         //HEI.04>>
                        //         case SalesInvLine."Item Charge Type" of
                        //             SalesInvLine."Item Charge Type"::Tax:
                        //                 begin
                        //                     TotalFooterAmount[1] += SalesInvLine.Amount;
                        //                     //HEI.03>>
                        //                     if ItemChargeRec.Get(SalesInvLine."No.") then begin
                        //                         if ItemChargeRec."Excise Duties" then
                        //                           //TotalFooterAmount[8] += SalesInvLine.Amount;  //commented by HEI.04
                        //                           //HEI.04<<
                        //                           begin
                        //                             ExciseDutiesExists := true;
                        //                             TotalFooterAmount[8] += SalesInvLine.Amount;
                        //                             if FreeCharge and ItemChargeRec."Show free amount on printout" then
                        //                                 TotalFooterAmount[8] += SalesInvLine."Line Discount Amount";
                        //                             if not ItemChargeRec."Hide Item charge on printout" then
                        //                                 HideExciseDuties := false;
                        //                         end;
                        //                         //HEI.04>>
                        //                         if ItemChargeRec.FPI then
                        //                           //TotalFooterAmount[9] += SalesInvLine.Amount; //commented by HEI.04
                        //                           //HEI.04<<
                        //                           begin
                        //                             FPIExists := true;
                        //                             TotalFooterAmount[9] += SalesInvLine.Amount;
                        //                             if FreeCharge and ItemChargeRec."Show free amount on printout" then
                        //                                 TotalFooterAmount[9] += SalesInvLine."Line Discount Amount";
                        //                             if not ItemChargeRec."Hide Item charge on printout" then
                        //                                 HideFPI := false;
                        //                         end;
                        //                         //HEI.04>>
                        //                         if ItemChargeRec."Consumption tax" then
                        //                           //TotalFooterAmount[10] += SalesInvLine.Amount;  //commented by HEI.04
                        //                           //HEI.04<<
                        //                           begin
                        //                             ConsTaxExists := true;
                        //                             TotalFooterAmount[10] += SalesInvLine.Amount;
                        //                             if FreeCharge and ItemChargeRec."Show free amount on printout" then
                        //                                 TotalFooterAmount[10] += SalesInvLine."Line Discount Amount";
                        //                             if not ItemChargeRec."Hide Item charge on printout" then
                        //                                 HideConsTax := false;
                        //                         end;
                        //                         //HEI.04>>
                        //                     end;
                        //                     //HEI.03<<
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::Deposit:
                        //                 begin
                        //                     TotalFooterAmount[2] += SalesInvLine."Line Amount";
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::"Shipping Cost":
                        //                 begin
                        //                     TotalFooterAmount[3] += SalesInvLine.Amount;
                        //                     TotalFooterAmountText[3] := Text52011;
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::Discount:
                        //                 begin
                        //                     if ItemChargeRec.Get(SalesInvLine."No.") then
                        //                         if not ItemChargeRec."Transport/Shipping Cost" then begin
                        //                             TotalFooterAmount[4] += SalesInvLine."Line Amount";
                        //                             TotalInvDis += SalesInvLine."Line Amount";
                        //                         end else begin
                        //                             TotalFooterAmount[6] += SalesInvLine."Line Amount";
                        //                             //HEI.04<<
                        //                             TransCostExists := true;
                        //                             if FreeCharge and ItemChargeRec."Show free amount on printout" then
                        //                                 FreeFTPAmount += SalesInvLine."Line Discount Amount";
                        //                             if not ItemChargeRec."Hide Item charge on printout" then
                        //                                 HideTransCost := false;
                        //                             //HEI.04>>
                        //                         end;
                        //                 end;
                        //         end;
                        //     /*ItemChargeRec.GET(SalesInvLine."No.");
                        //     IF (ItemChargeRec."Item Charge Type" = ItemChargeRec."Item Charge Type"::ShippingCost) THEN
                        //       ShippingChargesAmount += SalesInvLine.Amount ;
                        //     //add to shipping costs to shipping charges subtotal row
                        //     IF SalesInvLine."Show Item charge on Invoice" = SalesInvLine."Show Item charge on Invoice"::"Order total" THEN
                        //      ShippingChargesAmount += TotalFooterAmount[6];*/
                        //     until SalesInvLine.Next() = 0;
                        //BC UPGRADE KUMARR78 << Blocking As DIT Field Removed in BC

                        //HEI.04<<
                        if not FPIExists then begin
                            ItemChargeRec.Reset();
                            ItemChargeRec.SetRange("FPI FND", true);
                            ItemChargeRec.SetRange("Hide Item chrg on printout FND", false);
                            if ItemChargeRec.Count > 0 then
                                HideFPI := false;
                        end;
                        if not ConsTaxExists then begin
                            ItemChargeRec.Reset();
                            ItemChargeRec.SetRange("Consumption tax FND", true);
                            ItemChargeRec.SetRange("Hide Item chrg on printout FND", false);
                            if ItemChargeRec.Count > 0 then
                                HideConsTax := false;
                        end;
                        if not ExciseDutiesExists then begin
                            ItemChargeRec.Reset();
                            ItemChargeRec.SetRange("Excise Duties FND", true);
                            ItemChargeRec.SetRange("Hide Item chrg on printout FND", false);
                            if ItemChargeRec.Count > 0 then
                                HideExciseDuties := false;
                        end;
                        if not TransCostExists then begin
                            ItemChargeRec.Reset();
                            ItemChargeRec.SetRange("Transport/Shipping Cost FND", true);
                            ItemChargeRec.SetRange("Hide Item chrg on printout FND", false);
                            if ItemChargeRec.Count > 0 then
                                HideTransCost := false;
                        end;
                        //HEI.04>>

                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        ShippingChargesAmount := TotalFooterAmount[6];
                        MarkupChargesAmount := TotalFooterAmount[5];
                        BaseMarginAmt := TotalFooterAmount[7];
                        //HEI.03>>
                        ExcideDutiesAmount := TotalFooterAmount[8];
                        FPIAmout := TotalFooterAmount[9];
                        ConsTaxAmout := TotalFooterAmount[10];
                        ShippingChargesAmount := TotalFooterAmount[3] + TotalFooterAmount[6];
                        //HEI.03<<


                        SalesInvLine.Reset();
                        SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SetRange(Type, SalesInvLine.Type::"Charge (Item)");
                        if SalesInvLine.FindSet() then
                            repeat
                                TotalFooterAmount[4] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[4] := Text52010;
                            until SalesInvLine.Next() = 0;

                        LineDisAmount := TotalFooterAmount[4];

                        AmttoPaid := InvLineTotal + VatAmt + TotalFooterAmount[1] + VatAmt + TotalFooterAmount[5] + TotalFooterAmount[6] - VatAmt + TotalFooterAmount[4];
                        InvTotalAmount := AmttoPaid + TotalFooterAmount[2];

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
                    //HEI.04<<
                    Clear(FreeInvLineTotal);
                    HideFPI := true;
                    HideConsTax := true;
                    HideExciseDuties := true;
                    HideTransCost := true;
                    FPIExists := false;
                    ConsTaxExists := false;
                    ExciseDutiesExists := false;
                    TransCostExists := false;
                    Clear(FreeFTPAmount);
                    //HEI.04>>
                end;

                trigger OnPostDataItem();
                begin
                    SalesInvCountPrinted.Run("Sales Invoice Header");
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
                //BC Upgrade KUMARR78 >> DIT Field Block
                // if CompanyInfo."Tax Registration No." <> '' then
                //     CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                //BC Upgrade KUMARR78 << DIT Field Block

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

                // CurrReport.LANGUAGE := Language.GetLanguageID(DocLanguage);// BC Upgrade KUMARR78 Blocking as GetlanguageId moved from Table to CU.
                CurrReport.Language := LanguageG.GetLanguageId(DocLanguage); // BC Upgrade KUMARR78 Adding GetlanguageId moved from Table to CU.


                //footer texts
                //commented by HEI.03>>
                /*
                FooterText := CompanyInfo.Address;
                IF CompanyInfo."Post Code" <> '' THEN
                  FooterText := FooterText + ' - ' + CompanyInfo."Post Code";
                IF CompanyInfo.City <> '' THEN
                  FooterText := FooterText + ' '+ CompanyInfo.City;
                IF CompanyInfo."Phone No." <> '' THEN
                  FooterText := FooterText + ' - Tel: ' + CompanyInfo."Phone No.";
                IF CompanyInfo."Fax No." <> '' THEN
                  FooterText := FooterText + ' - Fax: ' + CompanyInfo."Fax No.";
                FooterText1 := CompanyInfo."Add. Address";
                
                IF CompanyInfo."Add. Post Code" <> '' THEN
                  FooterText1 := FooterText1 + ' - ' + CompanyInfo."Add. Post Code";
                IF CompanyInfo."Add. City" <> '' THEN
                  FooterText1 := FooterText1 + ' '+ CompanyInfo."Add. City";
                IF CompanyInfo."Add. Phone No." <> '' THEN
                  FooterText1 := FooterText1 + ' - Tel: ' + CompanyInfo."Add. Phone No.";
                FooterText2 := FooterSubText + ' ' + CompanyInfo."Home Page";
                IF FooterText = '' THEN BEGIN
                  FooterText := FooterText1;
                  FooterText1 := FooterText2;
                  FooterText2 := '';
                END ELSE BEGIN
                  IF FooterText1 = '' THEN BEGIN
                    FooterText1 := FooterText2;
                    FooterText2  := '';
                  END;
                END;*/
                //commented by HEI.03<<

                //HEI.03>>
                FooterText := CompanyInfo.Name + ' ' + TxtFooter;
                if CompanyInfo."RCCM Legal entity code FND" <> '' then
                    FooterText := FooterText + ', ' + TxtFooter1 + ' ' + CompanyInfo."RCCM Legal entity code FND";
                if CompanyInfo."Cap. Social FND" <> '' then
                    FooterText := FooterText + ', ' + TxtFooter2 + ' ' + CompanyInfo."Cap. Social FND";
                if CompanyInfo."WHT Registration ID FND" <> '' then
                    FooterText := FooterText + ', ' + CompanyInfo."WHT Registration ID FND";
                if CompanyInfo."VAT Registration No." <> '' then
                    FooterText := FooterText + ', ' + TxtFooter3 + ' ' + CompanyInfo."VAT Registration No.";
                if CompanyInfo.Address <> '' then
                    FooterText := FooterText + ', ' + CompanyInfo.Address;
                if CompanyInfo."Address 2" <> '' then
                    FooterText := FooterText + ' ' + CompanyInfo."Address 2";
                if CompanyInfo.City <> '' then
                    FooterText := FooterText + ', ' + CompanyInfo.City;
                //HEI.03<<

                if SalesPerson.Get("Sales Invoice Header"."Salesperson Code") then;

                if ShipmentMethod.Get("Sales Invoice Header"."Shipment Method Code") then
                    ShipmentMethod.TranslateDescription(ShipmentMethod, DocLanguage);

                if PaymentTerms.Get("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, DocLanguage);

                PaymentMethod.Reset();
                if PaymentMethod.Get("Payment Method Code") then;

                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    CurrencyCode := GLSetup."LCY Code";
                    TotalExText := StrSubstNo(Text52001, GLSetup."LCY Code");
                    TotalInText := StrSubstNo(Text52002, GLSetup."LCY Code");
                    SubTotalInText := StrSubstNo(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := StrSubstNo(Text52005, GLSetup."LCY Code");
                end else begin
                    CurrencyCode := "Currency Code";
                    TotalExText := StrSubstNo(Text52001, "Currency Code");
                    TotalInText := StrSubstNo(Text52002, "Currency Code");
                    SubTotalInText := StrSubstNo(Text52005B, "Currency Code");
                    SubTotalExText := StrSubstNo(Text52005, "Currency Code");
                end;


                CustomerNo := '';
                CustomerName := '';
                CustomerAddress := '';
                if Customer.Get("Sales Invoice Header"."Bill-to Customer No.") then begin
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

                Clear(CustomerAttributes1);
                if CustomerAttributes1.Get("Sales Invoice Header"."Sell-to Customer No.") then;

                Clear(CustomerAttributestext);
                if CustomerAttributes.Get("Sales Invoice Header"."Bill-to Customer No.") then begin
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





                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SetFilter("VAT %", '<>%1', 0);
                if SalesInvLine.FindFirst() then
                    VATPer := SalesInvLine."VAT %";

                if "Sales Invoice Header"."Prices Including VAT" = true then
                    PriceIncVAT := 'Yes'
                else
                    PriceIncVAT := 'No';

                VatAmt := 0;
                lineNumberVAT := 0;
                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SetFilter("VAT %", '<>%1', 0);
                if SalesInvLine.FindSet() then
                    repeat
                        VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                        //VATAmount := ABS(VatAmt);
                        VATAmount := VatAmt;

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

                BillToCustomer.Get("Sales Invoice Header"."Bill-to Customer No.");
                SoldToCustomer.Get("Sales Invoice Header"."Sell-to Customer No.");
                if BillToCountry.Get(BillToCustomer."Country/Region Code") then;
                if SoldToCountry.Get(SoldToCustomer."Country/Region Code") then;

                if "Sales Invoice Header"."No. Printed" = 0 then
                    OriginalCopy := Text50004
                else
                    OriginalCopy := Text52000;

                //"Sales Invoice Header".CALCFIELDS("Amount Including VAT");
                "Sales Invoice Header".CalcFields("Amount Including VAT", Amount);  //HEI.04
                TotalAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(Today, "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Amount Including VAT", CurrExchRate.ExchangeRate(Today, "Sales Invoice Header"."Currency Code"));

                TotalVATAmnt := "Sales Invoice Header"."Amount Including VAT" - "Sales Invoice Header".Amount;  //HEI.04

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
                        ApplicationArea = all; // BC Upgrade KUMARR78 Adding ApplicationArea
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
        label(lblOrderNo; ENU = 'RO Order No:',
                         ENG = 'RO Order No:')
        label(lblInvoiceNo; ENU = 'Credit Note No:',
                           ENG = 'Credit Note No:')
        label(lblVATAmt; ENU = 'Total VAT:',
                        ENG = 'Total VAT:')
        label(lblPostDate; ENU = 'Credit memo Date:',
                          ENG = 'Credit memo Date:')
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
        label(LblInvoiceCurrency; ENU = 'CN. Currency:',
                                 ENG = 'CN. Currency:')
        label(LblVersion; ENU = 'Version:',
                         ENG = 'Version:')
        label(LblItemNo; ENU = 'Item No.',
                        ENG = 'Item No.')
        label(LblQty; ENU = 'Qty',
                     ENG = 'Qty')
        label(LblPayMethod; ENU = 'Payment Method:',
                           ENG = 'Payment Method:')
        label(LblInvoiceCurrLCY; ENU = 'Credit No Curr LCY:',
                                ENG = 'Credit No Curr LCY:')
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
        CustomerAttributes1: Record "Customer Attributes FND";
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND"; // BC Upgrade VAMSIU01 >>
        GLSetup: Record "General Ledger Setup";
        ItemChargeRec: Record "Item Charge";
        // Language: Record Language; // BC Upgrade KUMARR78 Blocking As Function moved from Table to Codeunit.
        LanguageG: Codeunit Language;    // BC Upgrade KUMARR78 Adding As Function moved from Table to Codeunit.
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvLineAmt: Record "Sales Invoice Line";
        SalesPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        VATEntry: Record "VAT Entry";
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        ConsTaxExists: Boolean;
        ExciseDutiesExists: Boolean;
        ExportInvoice: Boolean;
        FPIExists: Boolean;
        FreeCharge: Boolean;
        HideConsTax: Boolean;
        HideExciseDuties: Boolean;
        HideFPI: Boolean;
        HideTransCost: Boolean;
        ICInvoice: Boolean;
        TransCostExists: Boolean;
        CurrencyCode: Code[10];
        DocLanguage: Code[10];
        CustomerNo: Code[20];
        AmttoPaid: Decimal;
        BaseMarginAmt: Decimal;
        ConsTaxAmout: Decimal;
        DepAmount: Decimal;
        ExcideDutiesAmount: Decimal;
        FPIAmout: Decimal;
        FreeFTPAmount: Decimal;
        FreeInvLineTotal: Decimal;
        InvLineTotal: Decimal;
        InvTotalAmount: Decimal;
        LineDisAmount: Decimal;
        MarkupChargesAmount: Decimal;
        ShipAmount: Decimal;
        ShippingChargesAmount: Decimal;
        TaxAmout: Decimal;
        TotalAmountLCY: Decimal;
        TotalDepositFooterAmount: array[6] of Decimal;
        TotalFooterAmount: array[10] of Decimal;
        TotalInvDis: Decimal;
        TotalQty: Decimal;
        TotalVATAmnt: Decimal;
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
        TxtFooter3: Label 'I.N.';
        TxtFPI: Label 'FPI:';
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
        TotalFooterAmountText: array[10] of Text[50];
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
        Text50001: TextConst ENU = 'Excise Duties:', FRA = 'Droits d''accises:', ENG = 'Excise Duties:';
        Text50002: TextConst ENU = 'Deposit Amount:', FRA = 'Frais consigne:', ENG = 'Deposit Amount:';
        Text50003: TextConst ENU = 'Shipping Charges:', FRA = 'Frais Transport Produits:', ENG = 'Shipping Charges:';
        Text50004: TextConst ENU = 'Original', FRA = 'Original', ENG = 'Original';
        Text52000: TextConst ENU = 'Copy', FRA = 'Copie', ENG = 'Copy';
        Text52001: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 HT', ENG = 'Total %1 Excl. VAT';
        Text52002: TextConst ENU = 'Total %1 Incl. VAT', FRA = 'Total %1 TTC', ENG = 'Total %1 Incl. VAT';
        Text52003: TextConst ENU = 'VAT @ %1 ', FRA = 'TVA @ %1', ENG = 'VAT @ %1 ';
        Text52004: TextConst ENU = 'Order Confirmation %1', FRA = 'Confirmation de commande %1', ENG = 'Order Confirmation %1';
        Text52004B: TextConst ENU = 'Proforma Invoice %1', FRA = 'Facture Proforma %1', ENG = 'Proforma Invoice %1';
        Text52005: TextConst ENU = 'Subtotal %1 Excl. VAT:', FRA = 'Sous Total %1 Hors Taxe:', ENG = 'Subtotal %1 Excl. VAT:';
        Text52005B: TextConst ENU = 'Subtotal %1 Incl. VAT:', FRA = 'Sous-total %1 TTC:', ENG = 'Subtotal %1 Incl. VAT:';
        Text52006: TextConst ENU = 'Debit Note', FRA = 'Note de Débit', ENG = 'Debit Note';
        Text52007: TextConst ENU = 'Sundry Invoice', FRA = 'Sundry Facture', ENG = 'Sundry Invoice';
        Text52008: TextConst ENU = 'Export Invoice', FRA = 'Facture d''Export', ENG = 'Export Invoice', FRE = 'Facture d''Export';
        Text52010: TextConst ENU = 'Invoice discount amount:', FRA = 'Montant remise facture:', ENG = 'Invoice discount amount:';
        Text52011: TextConst ENU = 'Shippimg Amount:', FRA = 'Montant d''expédition:', ENG = 'Shippimg Amount:';
        TxtAccNo: TextConst ENU = 'Account No.:', FRA = 'N° de compte:', ENG = 'Account No.:';
        TxtAccountCurrency: TextConst ENU = 'Account Currency:', FRA = 'Devise du compte:';
        TxtAccountHolder: TextConst ENU = 'Account Holder:', FRA = 'Account Holder:';
        TxtAddress: TextConst ENU = 'Address:', FRA = 'Addresse:', ENG = 'Address:';
        TxtAddress2: TextConst ENU = 'Address 2:', FRA = 'Addresse 2:', ENG = 'Address 2:';
        TxtAmtPaid: TextConst ENU = 'Subtotal incl. VAT:', FRA = 'Total TTC (toute taxe comprise):', ENG = 'Subtotal incl. VAT:';
        TxtBank: TextConst ENU = 'Bank:', FRA = 'Banque:', ENG = 'Bank:';
        TxtBankDetails: TextConst ENU = 'Bank Details:', FRA = 'Coordonnées bancaires:', ENG = 'Bank Details:';
        TxtBillToAddress: TextConst ENU = 'BILL TO:', FRA = 'ADRESSE DE FACTURATION:', ENG = 'BILL TO:';
        TxtCity: TextConst ENU = 'City:', FRA = 'Ville:', ENG = 'City:';
        TxtCodeSwift: TextConst ENU = 'Swift Code:', FRA = 'Swift code:', ENG = 'Swift Code:';
        TxtCompanyTaxId: TextConst ENU = 'Company Tax ID:', FRA = 'N° Impot:', ENG = 'Company Tax ID:';
        TxtConsTax: TextConst ENU = 'Consumption tax:', FRA = 'Taxe de consommation:';
        TxtCountry: TextConst ENU = 'Country:', FRA = 'Pays:', ENG = 'Country:';
        TxtCustomerName: TextConst ENU = 'Customer Name:', FRA = 'Nom du client:', ENG = 'Customer Name:';
        TxtCustomerNo: TextConst ENU = 'Customer No:', FRA = 'N° du client:', ENG = 'Customer No:';
        TxtCustomerPoNo: TextConst ENU = 'Customer PO No:', FRA = 'Bon de commande client N°:', ENG = 'Customer PO No:';
        TxtCustomTariffCode: TextConst ENU = 'Custom Tariff Code:', FRA = 'Code tarifaire personnalisé:', ENG = 'Custom Tariff Code:';
        TxtDescrip: TextConst ENU = 'Description', FRA = 'Description', ENG = 'Description';
        TxtDisc: TextConst ENU = 'Disc.', FRA = 'Mont. Remise', ENG = 'Disc.';
        TxtDiscTotal: TextConst ENU = 'Discount Total:', FRA = 'Remise Totale:', ENG = 'Discount Total:';
        TxtDueDate: TextConst ENU = 'Due Date:', FRA = 'Date d''échéance:', ENG = 'Due Date:';
        TxtExciseDuties: TextConst ENU = 'Excise duties:', FRA = 'Droits d''accises:';
        TxtFiscal: TextConst ENU = 'N° fiscal de l''entreprise:', FRA = 'N° fiscal de l''entreprise:';
        TxtFooter: TextConst ENU = 'a capital variable', FRA = 'a capital variable', ENG = 'a capital variable';
        TxtFooter1: TextConst ENU = 'RCCM: n°', FRA = 'Registre de Commerce et du Crédit Mobilier (RCCM): n°';
        TxtFooter2: TextConst ENU = 'Capital Social Initial :', FRA = 'Capital Social Initial :';
        TxtIBAN: TextConst ENU = 'IBAN:', ENG = 'IBAN:';
        TxtInCoTerms: TextConst ENU = 'InCo Terms:', FRA = 'Incoterm:', ENG = 'InCo Terms:';
        TxtInvCurr: TextConst ENU = 'Invoice Curr LCY:', FRA = 'Devise de facturation:', ENG = 'Invoice Curr LCY:';
        TxtInvoiceCurrency: TextConst ENU = 'Invoice Currency:', FRA = 'Devise de la facture:', ENG = 'Invoice Currency:';
        TxtInvoiceNo: TextConst ENU = 'Invoice No:', FRA = 'N° De Facture:', ENG = 'Invoice No:';
        TxtItemNo: TextConst ENU = 'Item No.', FRA = 'Article N°', ENG = 'Item No.';
        TxtOrderNo: TextConst ENU = 'SO Order No:', FRA = 'N° commande:', ENG = 'SO Order No:';
        TxtPageNo: TextConst ENU = 'Page No:', FRA = 'Page N°:', ENG = 'Page No:';
        TxtPaymMethod: TextConst ENU = 'Payment Method:', FRA = 'Méthode de paiement:', ENG = 'Payment Method:';
        TxtPaymTerms: TextConst ENU = 'Payment Terms:', FRA = 'Conditions de paiement:', ENG = 'Payment Terms:';
        TxtPayTerms: TextConst ENU = 'Payment Terms:', FRA = 'Conditions Paiement:', ENG = 'Payment Terms:';
        TxtPostCode: TextConst ENU = 'Post Code:', FRA = 'Code postal:', ENG = 'Post Code:';
        TxtPostDate: TextConst ENU = 'Invoice Date:', FRA = 'Date de facturation:', ENG = 'Invoice Date:';
        TxtPrintDate: TextConst ENU = 'Print Date:', FRA = 'Date d''impression:', ENG = 'Print Date:';
        TxtQty: TextConst ENU = 'Qty', FRA = 'Qté', ENG = 'Qty';
        TxtRCCM: TextConst ENU = 'N° RCCM:', FRA = 'N° RCCM:', ENG = 'N° RCCM:';
        TxtSaleLAmt: TextConst ENU = 'Amount Excl. VAT', FRA = 'Montant sans TVA', ENG = 'Amount Excl. VAT';
        TxtSalesCondition: TextConst ENU = 'The Sale Conditions on the back side', FRA = 'Conditions generales de vento ou envers', ENG = 'The Sale Conditions on the back side';
        TxtSalesPerson: TextConst ENU = 'Sales Person ID:', FRA = 'ID du Représentant/Commercial:', ENG = 'Sales Person ID:';
        TxtShipMethod: TextConst ENU = 'Shipment Method', FRA = 'Condition de Livraison', ENG = 'Shipment Method';
        TxtShipToAddress: TextConst ENU = 'SHIP TO ADDRESS:', FRA = 'ADRESSE DE LIVRAISON:', ENG = 'SHIP TO ADDRESS:';
        TxtSoldToAddress: TextConst ENU = 'CUSTOMER:', FRA = 'CLIENT:', ENG = 'CUSTOMER:';
        TxtTAX: TextConst ENU = 'N° Impot:', FRA = 'N° Impot:';
        TxtTaxDetails: TextConst ENU = 'VAT Summary', FRA = 'Résumé TVA', ENG = 'VAT Summary';
        TxtTotalToBePaid: TextConst ENU = 'Total:', FRA = 'Total:', ENG = 'Total:';
        TxtUnitPrice: TextConst ENU = 'Unit Price', FRA = 'Prix Unitaire', ENG = 'Unit Price';
        TxtUOM: TextConst ENU = 'Unit', FRA = 'Unité', ENG = 'Unit';
        TxtVAT: TextConst ENU = 'N° Identifiication National:', FRA = 'N° Identifiication National:';
        TxtVATAmt: TextConst ENU = 'Total VAT:', FRA = 'Montant TVA:', ENG = 'Total VAT:';
        TxtVATPer: TextConst ENU = 'VAT Rate', FRA = 'Taux TVA', ENG = 'VAT Rate';
        TxtVatRegistrationNo: TextConst ENU = 'Vat Registration No:', FRA = 'N° d''identification TVA:', ENG = 'Vat Registration No:';
        TxtVersion: TextConst ENU = 'Version:', FRA = 'Version:', ENG = 'Version:';

    local procedure SetExportICInvoice();
    begin
        ICInvoice := false;
        ExportInvoice := false;

        if Customer.Get("Sales Invoice Header"."Bill-to Customer No.") then
            if Customer."Account Group FND" in ['Y005', 'Y006', 'Y008'] then
                ICInvoice := true;

        if "Sales Invoice Header"."Document Subtype Code FND" in [DocSubtypeCodeSetup."Sundry Sales Order Non Stock", DocSubtypeCodeSetup."Sundry Sales Order Stock"] then //BC UPGRADE VAMSIU01 Added>>
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
    end;
}

