report 53062 "Debit Note STD"
{
    // version HEI.11

    // HEI.01 CHG2070787 IBM GAVANM01 02.09.2020 Update all Billing documents in line with Global (for the BAHAMAS)
    //   # Report created as copy of report 50265
    // HEI.02 CHG2073371 HB1589 IBM GAVANM01 28.09.2020  #St Lucia Item charges Shipping Cost not working
    //   # Item charges of type Discount and Transport/Shipping Cost = TRUE should be considered as Shipping Cost

    // BC Upgrade KUMARR78 >>
    // Report Name  : Debit Note STD
    // Report ID    : 50454
    //
    // 1. Ensured Business Central visibility properties.
    //    Old:
    //         - ApplicationArea not mandatory in NAV.
    //         - UsageCategory not defined.
    //    New:
    //         - ApplicationArea = All
    //         - UsageCategory = ReportsAndAnalysis
    //
    // 2. Corrected invalid DataItemTableView filter expression.
    //    Old:
    //         where(Type = filter(Item | Resource | "Fixed Asset" | '"Charge (Item)"'))
    //         - Invalid quoted enum expression caused compilation error in BC.
    //    New:
    //         where(Type = filter(Item | Resource | "Fixed Asset" | "Charge (Item)"))
    //         - Enum values aligned to BC AL syntax.
    //
    // 3. Removed DIT-specific bank fields from Company Information.
    //    Old:
    //         CompanyInfo."Bank Name 2"
    //         CompanyInfo."Bank Account No. 2"
    //         CompanyInfo."IBAN 2"
    //         CompanyInfo."SWIFT Code 2"
    //    New:
    //         - Fields commented.
    //         - Blank dataset columns passed to preserve RDLC layout bindings.
    //         - Prevents dataset breaking while removing unsupported fields.
    //
    // 4. Removed DIT logic: "Item Charge Type" and "Show Item charge on Invoice".
    //    Old:
    //         SETRANGE("Item Charge Type", ...)
    //         Conditional logic based on:
    //              • Discount
    //              • Tax
    //              • Deposit
    //              • Shipping Cost
    //              • Show Item charge on Invoice options
    //    New:
    //         - All DIT field filters commented.
    //         - Charge handling simplified using:
    //              • Type = "Charge (Item)"
    //              • Attached to Line No.
    //              • Item Charge."Transport/Shipping Cost"
    //         - Totals derived without DIT classification dependency.
    //
    // 5. Removed DIT field dependency: "Free Item".
    //    Old:
    //         Conditional discount logic skipped when "Free Item" = TRUE.
    //    New:
    //         - Condition commented.
    //         - Invoice discount handled using standard fields:
    //              • "Line Discount Amount"
    //              • "Inv. Discount Amount"
    //
    // 6. Removed DIT-based footer total calculation logic.
    //    Old:
    //         Case logic based on "Item Charge Type" for:
    //              • Tax
    //              • Deposit
    //              • Shipping Cost
    //              • Discount
    //    New:
    //         - Entire case block commented.
    //         - Footer totals calculated using standard BC fields only.
    //         - Preserved TotalFooterAmount array for RDLC compatibility.
    //
    // 7. Removed DIT StandardTextReport footer logic.
    //    Old:
    //         StandardTextReport record used to dynamically load footer texts.
    //    New:
    //         - Entire logic commented.
    //         - TextFooter array retained.
    //         - Prevents dependency on removed custom table.
    //
    // 8. Removed DIT-specific Document Subtype logic.
    //    Old:
    //         DocSubtypeCodeSetup usage.
    //         Conditional ExportInvoice assignment based on subtype.
    //    New:
    //         - Variable and logic commented.
    //         - ExportInvoice forced FALSE to maintain base functionality.
    //
    // 9. Replaced Language record with Codeunit (BC standard change).
    //    Old:
    //         Language: Record Language;
    //         CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
    //    New:
    //         LanguageG: Codeunit Language;
    //         CurrReport.Language := LanguageG.GetLanguageId("Language Code");
    //         - Function moved from table to Codeunit in BC.
    //         - Prevents datatype conflict.
    //
    // 10. Preserved RDLC layout compatibility.
    //     Old:
    //         Layout dependent on:
    //              • Bank fields
    //              • Charge classifications
    //              • Footer totals
    //     New:
    //         - Dataset structure retained.
    //         - Unsupported DIT fields commented instead of removed.
    //         - Blank columns passed where required.
    //
    // 11. Maintained BC-compliant request page configuration.
    //     Old:
    //         NoOfCopies without ApplicationArea.
    //     New:
    //         ApplicationArea = All added to field.
    // BC Upgrade KUMARR78 <<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Debit Note STD.rdl';
    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding Usagecategory

    Caption = 'Debit Note STD';
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
            //BC Upgrade SHUKLP03>> 
            column(CompanyInfo_BankName2; CompanyInfo."Bank Name 2 FND")
            {
            }
            column(CompanyInfo_BankAcc2; CompanyInfo."Bank Account No. 2 FND")
            {
            }
            column(CompanyInfo_IBAN2; CompanyInfo."IBAN 2 FND")
            {
            }
            column(CompanyInfo_Swift2; CompanyInfo."SWIFT Code 2 FND")
            {
            }
            //BC Upgrade SHUKLP03<< 

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
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
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
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        // DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(Item | Resource | "Fixed Asset" | '"Charge (Item)"'));//BC UPGRADE KUMARR78 Blocking as Wrong Expression.
                        DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(Item | Resource | "Fixed Asset" | "Charge (Item)"));//BC UPGRADE KUMARR78 Adding as Wrong Expression was Used.

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
                                    TempUnderChargeLine.FindFirst()
                                else
                                    TempUnderChargeLine.Next();
                            end;

                            trigger OnPostDataItem();
                            begin
                                TempUnderChargeLine.Reset();
                                TempUnderChargeLine.DeleteAll();
                            end;

                            trigger OnPreDataItem();
                            begin
                                TempUnderChargeLine.Reset();
                                TempUnderChargeLine.SetRange("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                SetRange(Number, 1, TempUnderChargeLine.Count);
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            OrderChargeLine: Record "Sales Invoice Line";
                            SalesChargeLine: Record "Sales Invoice Line";
                            SalesInvoiceLine: Record "Sales Invoice Line";
                        begin
                            if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then begin
                                TotalGrossWeight += "Sales Invoice Line"."Gross Weight";//BC Upgrade SHUKLP03<< 
                                TotalNetWeight += "Sales Invoice Line"."Net Weight";
                            end;

                            DiscIncluded := 0;
                            UnitPrice := "Unit Price";
                            LineAmount := "Line Amount";

                            if Type <> Type::"Charge (Item)" then begin
                                //Include in Item Price

                                SalesInvoiceLine.Reset();
                                SalesInvoiceLine.SetRange("Document No.", "Document No.");
                                SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::"Charge (Item)");
                                SalesInvoiceLine.SetRange("Attached to Line No.", "Line No.");
                                SalesInvoiceLine.SETRANGE("Attached Line Type 101FDW", SalesInvoiceLine."Attached Line Type 101FDW"::"SPC 105FDW"); //BC Upgrade SHUKLP03<< 
                                SalesInvoiceLine.SETRANGE("Show Item charge on Inv. FND", SalesInvoiceLine."Show Item charge on Inv. FND"::"Include in item price"); //BC Upgrade SHUKLP03<< 
                                if SalesInvoiceLine.FindSet() then
                                    repeat
                                        if ItemCh.Get(SalesInvoiceLine."No.") and not ItemCh."Transport/Shipping Cost FND" then begin  //HEI.02
                                            LineAmount += SalesInvoiceLine."Line Amount";
                                            DiscIncluded += SalesInvoiceLine."Line Amount";
                                            if SalesInvoiceLine.Quantity <> 0 then
                                                UnitPrice := LineAmount / Abs(Quantity);
                                        end  //HEI.02
                                    until SalesInvoiceLine.Next() = 0;
                            end
                            //BC Upgrade SHUKLP03>> 
                            else
                                if ("Sales Invoice Line"."Attached Line Type 101FDW" = "Sales Invoice Line"."Attached Line Type 101FDW"::"SPC 105FDW") and
                                 ("Show Item charge on Inv. FND" = "Show Item charge on Inv. FND"::"Include in item price") then
                                    if ItemCh.GET("No.") and not ItemCh."Transport/Shipping Cost FND" then   //HEI.02
                                        CurrReport.SKIP();
                            //BC Upgrade SHUKLP03<< 

                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;
                            ItemDiscount := 0;
                            itemDeposit := 0;
                            //BC Upgrade SHUKLP03>> 
                            if "Sales Invoice Line"."Line Discount %" <> 100 then
                                TotalInvDis := "Sales Invoice Line"."Line Discount Amount";
                            //BC Upgrade SHUKLP03<< 

                            var_Dis := "Line Discount Amount";
                            if (Type = Type::"Charge (Item)") and ("Attached Line Type 101FDW" = "Attached Line Type 101FDW"::"SPC 105FDW") then //BC Upgrade SHUKLP03<< 
                                if ItemCh.Get("No.") and not ItemCh."Transport/Shipping Cost FND" then  //HEI.02
                                    var_Dis += Abs("Line Amount");
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
                        Clear(InvLineTotal);
                        if not ExportInvoice then
                            DocumentTitleText := StrSubstNo(Text52006, CopyText)
                        else
                            DocumentTitleText := StrSubstNo(Text52008, CopyText);

                        SalesInvLineAmt.Reset();
                        SalesInvLineAmt.SetRange("Document No.", "Sales Invoice Header"."No.");
                        //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset");   //commented by HEI.02
                        if SalesInvLineAmt.FindSet() then
                            repeat
                                if (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") or (SalesInvLineAmt."Attached to Line No." = 0) then  //HEI.02//BC Upgrade SHUKLP03 
                                    InvLineTotal += SalesInvLineAmt."Line Amount";
                            until SalesInvLineAmt.Next() = 0;

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;
                        //BC Upgrade SHUKLP03>> 
                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        if SalesInvLine.FINDSET() then
                            repeat
                                case SalesInvLine."Attached Line Type 101FDW" of
                                    SalesInvLine."Attached Line Type 101FDW"::"TAX 102FDW":
                                        TotalFooterAmount[1] += SalesInvLine."Line Amount";
                                    SalesInvLine."Attached Line Type 101FDW"::"EGM 104FDW":
                                        TotalFooterAmount[2] += SalesInvLine."Line Amount";
                                    // SalesInvLine."Item Charge Type"::"Shipping Cost":
                                    //     TotalFooterAmount[3] += SalesInvLine."Line Amount";
                                    SalesInvLine."Attached Line Type 101FDW"::"SPC 105FDW":
                                        //HEI.02>>
                                        if ItemCh.GET(SalesInvLine."No.") and ItemCh."Transport/Shipping Cost FND" then
                                            TotalFooterAmount[3] += SalesInvLine."Line Amount"
                                        else
                                            //HEI.02<<
                                            if SalesInvLine."Show Item charge on Inv. FND" <> SalesInvLine."Show Item charge on Inv. FND"::"Include in item price" then
                                                TotalFooterAmount[4] += SalesInvLine."Line Amount";
                                //HEI.02
                                end;
                            until SalesInvLine.NEXT() = 0;
                        //BC Upgrade SHUKLP03<<
                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        ShipAmount := TotalFooterAmount[3];

                        SalesInvLine.Reset();
                        SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                        if SalesInvLine.FindSet() then
                            repeat
                                TotalFooterAmount[4] += Abs(SalesInvLine."Inv. Discount Amount");
                                TotalFooterAmountText[4] := SalesInvLine.FieldCaption("Inv. Discount Amount");
                                TotalFooterAmount[5] += Abs(SalesInvLine."Line Discount Amount");
                                TotalFooterAmountText[5] := SalesInvLine.FieldCaption("Line Discount Amount");
                            until SalesInvLine.Next() = 0;

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
            var
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
                CurrReportID: Integer;
                i: Integer;
            begin
                //-----Currency
                if "Currency Code" <> '' then
                    CurrencyCode := "Currency Code"
                else
                    CurrencyCode := GLSetup."LCY Code";

                //-----Footer Texts
                //BC Upgrade SHUKLP03>> 
                CLEAR(CurrReportID);
                CLEAR(i);
                CLEAR(TextFooter);
                EVALUATE(CurrReportID, COPYSTR(CurrReport.OBJECTID(false), 8));
                StandardTextReport.SETRANGE("Report ID", CurrReportID);
                StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);
                if StandardTextReport.FINDSET() then
                    repeat
                        i := 1;
                        ExtendedTextHeader.RESET();
                        ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                        ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                        if ExtendedTextHeader.FINDSET() then
                            repeat
                                ExtendedTextLine.RESET();
                                ExtendedTextLine.SETRANGE("Table Name", ExtendedTextHeader."Table Name");
                                ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                                ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                                ExtendedTextLine.SETRANGE("Language Code", "Language Code");
                                if ExtendedTextHeader."All Language Codes" then
                                    ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
                                if ExtendedTextLine.FINDSET() then
                                    repeat
                                        TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                                    until (ExtendedTextLine.NEXT() = 0) or (i > ARRAYLEN(TextFooter));
                                i += 1;
                            until (ExtendedTextHeader.NEXT() = 0);
                    until (StandardTextReport.NEXT() = 0);
                //BC Upgrade SHUKLP03<< 
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
                // BC Upgrade SHUKLP03 >> ---- Field ("Tax Registration No.")
                CUSTOMSDOCManage.get();
                IF CUSTOMSDOCManage."Tax Registration No." <> '' THEN
                    CompanyText += ', ' + TaxNoID + ' ' + CUSTOMSDOCManage."Tax Registration No.";
                // BC Upgrade SHUKLP03 << ---- Field ("Tax Registration No.")
                //CompanyText += ', ' + ChOfComm;
                if CompanyInfo."Phone No." <> '' then
                    CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                if CompanyInfo."Fax No." <> '' then
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                /*IF CompanyInfo."E-Mail" <> '' THEN
                  CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";*/


                /*IF "Sales Invoice Header"."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" THEN
                  ExportInvoice := TRUE
                ELSE*/
                ExportInvoice := false;

                if "Sales Invoice Header"."Document Subtype Code FND" in [DocSubtypeCodeSetup."Sundry Sales Order Non Stock", DocSubtypeCodeSetup."Sundry Sales Order Stock"] then //BC Upgrade VAMSIU01 >>
                    ExportInvoice := false;

                TotalGrossWeight := 0;
                TotalNetWeight := 0;

                TEMPAccSchedKPIBuffer.DeleteAll();
                if Country.Get(CompanyInfo."Country/Region Code") then
                    CompanyInfoContryName := Country.Name;

                // CurrReport.LANGUAGE := Language.GetLanguageID("Language Code"); //BC Upgrade KUMARR78 GetlanguageId moved from Table to CU.
                CurrReport.Language := LanguageG.GetLanguageId("Language Code"); //BC Upgrade KUMARR78 GetlanguageId moved from Table to CU.

                if SalesPerson.Get("Sales Invoice Header"."Salesperson Code") then;

                if ShipmentMethod.Get("Sales Invoice Header"."Shipment Method Code") then
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Invoice Header"."Language Code");

                if PaymentTerms.Get("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Invoice Header"."Language Code");

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
                        VATAmount := Abs(VatAmt);

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
                        SplitVatPercent[Counter] := Format(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%'; //HEI.08
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

                "Sales Invoice Header".CalcFields("Amount Including VAT");
                TotalAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(Today, "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Amount Including VAT", CurrExchRate.ExchangeRate(Today, "Sales Invoice Header"."Currency Code"));

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
            area(Content)
            {
                group("Sales Order")
                {
                    Caption = 'Sales Order';
                    field("No. of Copies"; NoOfCopies)
                    {
                        ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
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
        label(lblAmtPaid; ENU = 'Subtotal incl. VAT:',
                         FRA = 'Montant A Payer')
        label(lblSalesCondition; ENU = 'The Sale Conditions on the back side',
                                FRA = 'Conditions generales de vento ou envers')
        lblTotalQty = 'Total Quantity'; lblSalesPerson = 'Sales Person ID:'; lblUOM = 'Unit'; lblUnitPrice = 'Unit Price'; lblSaleLAmt = 'Amount Excl. VAT'; lblPageNo = 'Page No:'; lblOrderNo = 'SO Order No:'; lblInvoiceNo = 'Debit Note No:'; lblVATAmt = 'Total VAT:'; lblPostDate = 'Debit Note Date:'; lblDueDate = 'Due Date:'; lblPriceIncVAT = 'Price Including VAT'; lblDriver = 'Name and Driver Signature'; lblWarehouse = 'Name and Warehouse Keeper Signature'; lblSecurity = 'Name and Security Visa'; label(lblPrintDate; ENU = 'Print Date:',
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            FRA = 'Date d''impression')
        LblBillToAddress = 'BILL TO:'; LblCustomerName = 'Customer Name:'; LblAddress = 'Address 1:'; LblAddress2 = 'Address 2:'; LblPostCode = 'Post Code:'; LblCity = 'City:'; LblCountry = 'Country:'; LblVatRegistrationNo = 'Vat Registration No:'; LblCompanyTaxId = 'Company Tax ID:'; LblSoldToAddress = 'CUSTOMER:'; LblCustomerPoNo = 'Customer PO No:'; LblTaxDetails = 'Tax Summary'; LblBankInfo = 'Bank Details:'; LblAccountNo = 'Account No:'; LblBankName = 'Bank:'; LblGiro = 'Giro No.'; LblIban = 'Iban:'; LblSwiftCode = 'Swift Code:'; LblSignature = 'Signature:'; LblVatPercent = 'Vat Percent'; LblVatAmount = 'Vat Amount'; LblIncoTerm = 'InCo Terms:'; Lbldisc = 'Disc.'; LblShipToAddress = 'SHIP TO ADDRESS:'; LblCustomerNo = 'Customer No:'; LblInvoiceCurrency = 'Debit Note Currency:'; LblVersion = 'Version:'; LblItemNo = 'Item No.'; LblQty = 'Qty'; LblPayMethod = 'Payment Method:'; LblInvoiceCurrLCY = 'Debit Note Curr LCY:'; LblTotalToBePaid = 'Total to be paid:'; LblDiscTotal = 'Disc Total:'; GrossWeightLbl = 'Gross Weight:'; NetWeightLbl = 'Net Weight:'; BillOfLadingNoLbl = 'Bill Of Lading No:'; VesselNameLbl = 'Vessel Name:'; ETDLbl = 'ETD:'; ETALbl = 'ETA:'; AirWayBillNoLbl = 'Air Way Bill No:'; CommodityCodeLbl = 'Commodity Code:'; CustomTariffCodeLbl = 'Custom Tariff Code:'; BankInfo2Lbl = 'Bank Details 2:'; BankInfo3Lbl = 'Bank Details 3:'; BankInfo4Lbl = 'Bank Details 4:'; CustomerServiceEmailLbl = 'Customer Service E-Mail:';
    }

    trigger OnInitReport();
    begin
        GLSetup.Get();
        SalesSetup.Get();
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture, "OpCo Footer image FND");
        GeneralOpCoSetup.Get();
        DocSubtypeCodeSetup.GET(); // BC Upgrade VAMSIU01 >>
    end;

    var
        TEMPAccSchedKPIBuffer: Record "Acc. Sched. KPI Buffer";
        VATEntry: Record "Area";
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
        ItemCh: Record "Item Charge";
        ItemChargeRec: Record "Item Charge";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvLineAmt: Record "Sales Invoice Line";
        TempUnderChargeLine: Record "Sales Invoice Line" temporary;
        SalesPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        // Language: Record Language; //BC UPGRADE KUMARR78 Blocking Codeunit as Function Moved from Record to Codeunit.
        LanguageG: Codeunit Language;//BC UPGRADE KUMARR78 Adding Codeunit as Function Moved from Record to Codeunit.
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        ExportInvoice: Boolean;
        IsDeposit: Boolean;
        IsDiscount: Boolean;
        IsNotUnderitem: Boolean;
        PrintUnderLineCharge: Boolean;
        Var_typechargeItem: Boolean;
        CurrencyCode: Code[10];
        CustomerNo: Code[20];
        AmttoPaid: Decimal;
        BaseMarginAmt: Decimal;
        DepAmount: Decimal;
        DiscIncluded: Decimal;
        InvDisAmount: Decimal;
        InvLineTotal: Decimal;
        InvTotalAmount: Decimal;
        itemDeposit: Decimal;
        ItemDiscount: Decimal;
        LineAmount: Decimal;
        LineDisAmount: Decimal;
        MarkupChargesAmount: Decimal;
        ShipAmount: Decimal;
        ShippingChargesAmount: Decimal;
        SubTotalCharges: Decimal;
        TaxAmout: Decimal;
        TotalAmountLCY: Decimal;
        TotalDepositFooterAmount: array[6] of Decimal;
        TotalFooterAmount: array[7] of Decimal;
        TotalGrossWeight: Decimal;
        TotalInvDis: Decimal;
        TotalNetWeight: Decimal;
        TotalQty: Decimal;
        UnitPrice: Decimal;
        var_amount: Decimal;
        var_Dis: Decimal;
        var_discount: Decimal;
        var_Quantity: Decimal;
        var_unitprice: Decimal;
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
        ChOfComm: Label 'Chamber of commerce:';
        ContactNo: Label 'Contact Number:';
        EBMDateLbl: Label 'Date';
        EBMDateTimeOfPrintingLbl: Label 'Date Time of Printing';
        EBMInternalDateLbl: Label 'Internal Data';
        EBMInvoiceNumberLbl: Label 'Invoice Number';
        EBMMRCLbl: Label 'MRC';
        EBMNotReceivedErr: Label 'You cannot print %1 %2 because EBM details are not received.';
        EBMReceiptSignatureLbl: Label 'Receipt Signature';
        EBMSDCIDLbl: Label 'SDC ID';
        EBMSDCInformationLbl: Label 'SDC Information';
        EBMSDCReceiptNumberLbl: Label 'SDC Receipt Number';
        EmailComp: Label 'E-mail:';
        FaxNo: Label 'Fax Number:';
        InvalidTxt: Label '**INVALID WITHOUT FISCAL OR REFUND RECEIPT ATTACHED**';
        TaxNoID: Label 'Tax Number ID:';
        Text50001: Label 'Excise Duties:';
        Text50002: Label 'Deposit Amount:';
        Text50003: Label 'Shipping Charges:';
        Text50004: Label 'Original';
        Text52000: Label 'Copy';
        Text52001: Label 'Total %1 Excl. VAT';
        Text52002: Label 'Total %1 Incl. VAT';
        Text52004: Label 'Order Confirmation %1';
        Text52004B: Label 'Proforma Invoice %1';
        Text52005: Label 'Subtotal %1 Excl. VAT:';
        Text52005B: Label 'Subtotal %1 Incl. VAT:';
        Text52006: Label 'Debit Note';
        Text52007: Label 'Sundry Invoice';
        Text52008: Label 'Export Invoice';
        ItemCharge: Option " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        DisplayTitleHeaderType: Option Confirmation,Proforma;
        CompanyInfoContryName: Text;
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";//BC Upgrade VAMSIU01 >>
        CompanyText: Text;
        OriginalCopy: Text;
        SplitVatAmount: array[10] of Text;
        SplitVatPercent: array[10] of Text;
        StandardTextReport: Record "Standard Text Report FND"; //BC Upgrade SHUKLP03
        TextFooter: array[3] of Text;
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
        CustomerAttributestext: Text[1024];
        CUSTOMSDOCManage: Record CustomsDocMgtSetup113FDW; // BC Upgrade SHUKLP03 <<
        Text52003: TextConst ENU = 'VAT @ %1 ', FRA = 'TVA @ %1';
}

