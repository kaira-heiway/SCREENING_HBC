report 53096 "Sales invoice Bahamas New"
{
    // HEI.01 CHG2329783-HB4456 IBM ADHIKG01 13.01.2026 Invoice Layout Change for Bahamas
    //   # New report created by referring to the report: 50265 - Sales Invoice STD
    //   # Increased the font size by 2 points in the report layout
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Sales invoice Bahamas Test.rdl';

    Caption = 'Sales Invoice Bahamas New';
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
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

            //BC Upgrade KUMBHS03 >> ---- fields ("Bank Name 2","Bank Account No. 2","IBAN 2","SWIFT Code 2")
            column(CompanyInfo_BankName2; CompanyInfo."Bank Name 2 FND")
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
            //BC Upgrade KUMBHS03 << ---- fields ("Bank Name 2","Bank Account No. 2","IBAN 2","SWIFT Code 2")
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
            column(Show_BankDetails3; (GeneralOpCoSetup."Report Invoice Type 3" = GeneralOpCoSetup."Report Invoice Type 3"::Invoice) AND (GeneralOpCoSetup."Bank Account No. 3" <> ''))
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
            column(Show_BankDetails4; (GeneralOpCoSetup."Report Invoice Type 4" = GeneralOpCoSetup."Report Invoice Type 4"::Invoice) AND (GeneralOpCoSetup."Bank Account No. 4" <> ''))
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
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
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
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.")
                                             WHERE(Type = FILTER(0 | 1 | 2 | 3));
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
                        dataitem(UnderLineCharges; Integer)
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

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    TempUnderChargeLine.FINDFIRST
                                ELSE
                                    TempUnderChargeLine.NEXT;
                            end;

                            trigger OnPostDataItem()
                            begin
                                TempUnderChargeLine.RESET;
                                TempUnderChargeLine.DELETEALL;
                            end;

                            trigger OnPreDataItem()
                            begin
                                TempUnderChargeLine.RESET;
                                TempUnderChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                SETRANGE(Number, 1, TempUnderChargeLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            OrderChargeLine: Record "Sales Invoice Line";
                            SalesChargeLine: Record "Sales Invoice Line";
                            SalesInvoiceLine: Record "Sales Invoice Line";
                        begin
                            IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item THEN BEGIN
                                //TotalGrossWeight += "Sales Invoice Line".Weight; //KUMBHS03 commented DIT field
                                TotalGrossWeight += "Sales Invoice Line"."Gross Weight 1 101FDW"; // BC Upgrade KUMBHS03 ----Drink-IT Field (Weight)
                                TotalNetWeight += "Sales Invoice Line"."Net Weight";
                            END;

                            DiscIncluded := 0;
                            UnitPrice := "Unit Price";
                            LineAmount := "Line Amount";

                            IF Type <> Type::"Charge (Item)" THEN BEGIN
                                //Include in Item Price

                                SalesInvoiceLine.RESET;
                                SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                                SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
                                SalesInvoiceLine.SETRANGE("Attached to Line No.", "Line No.");
                                // BC Upgrade KUMBHS03 >> ----Drink-IT Fields (Item Charge Type, "Show Item charge on Invoice")
                                SalesInvoiceLine.SETRANGE("Attached Line Type 101FDW", SalesInvoiceLine."Attached Line Type 101FDW"::"SPC 105FDW");// BC Upgrade KUMBHS03 << Replacement of "Item Charge Type"
                                SalesInvoiceLine.SETRANGE("Show Item charge on Inv. FND", SalesInvoiceLine."Show Item charge on Inv. FND"::"Include in item price");
                                // BC Upgrade KUMBHS03 << ----Drink-IT Fields (Item Charge Type, "Show Item charge on Invoice")
                                IF SalesInvoiceLine.FINDSET(FALSE) THEN
                                    REPEAT
                                        IF ItemCh.GET(SalesInvoiceLine."No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN BEGIN
                                            LineAmount += SalesInvoiceLine."Line Amount";
                                            DiscIncluded += SalesInvoiceLine."Line Amount";
                                            IF SalesInvoiceLine.Quantity <> 0 THEN
                                                UnitPrice := LineAmount / ABS(Quantity);
                                        END;
                                    UNTIL SalesInvoiceLine.NEXT = 0;
                            END

                            //BC UPgrade KUMBHS03 >>----Drink-IT Fields ("Item Charge Type","Show Item charge on Invoice")
                            else IF ("Sales Invoice Line"."Attached Line Type 101FDW" = "Sales Invoice Line"."Attached Line Type 101FDW"::"SPC 105FDW") AND
                                                          ("Show Item charge on Inv. FND" = "Show Item charge on Inv. FND"::"Include in item price") THEN
                                IF ItemCh.GET("No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN   //HEI.15
                                    CurrReport.SKIP;
                            //BC UPgrade KUMBHS03  << ----Drink-IT Fields ("Item Charge Type","Show Item charge on Invoice")

                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;
                            ItemDiscount := 0;
                            itemDeposit := 0;
                            // IF NOT "Sales Invoice Line"."Free Item" THEN
                            //     TotalInvDis := "Sales Invoice Line"."Line Discount Amount";

                            // BC Upgrade KUMBHS03 >> ----Field ("Free Item")
                            IF "Sales Invoice Line"."Line Discount %" = 100 THEN
                                TotalInvDis := "Sales Invoice Line"."Line Discount Amount";
                            // BC Upgrade KUMBHS03 << ---- Field ("Free Item")

                            //var_Dis := ABS("Line Discount Amount");
                            var_Dis := "Line Discount Amount";
                            IF (Type = Type::"Charge (Item)") AND ("Attached Line Type 101FDW" = "Attached Line Type 101FDW"::"SPC 105FDW") THEN // BC Upgrade KUMBHS03 ---- Field("Item Charge Type")
                                IF ItemCh.GET("No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN
                                    var_Dis += ABS("Line Amount");
                        end;
                    }
                    dataitem(SplitVatAmt; Integer)
                    {
                        column(TEMPAccSchedKPIBuffer_VatPercent; FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast"))
                        {
                        }
                        column(TEMPAccSchedKPIBuffer_VatAmount; TEMPAccSchedKPIBuffer."Net Change Budget")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT TEMPAccSchedKPIBuffer.FIND('-') THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF TEMPAccSchedKPIBuffer.NEXT = 0 THEN
                                    CurrReport.BREAK;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, TEMPAccSchedKPIBuffer.COUNT);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CLEAR(TotalFooterAmount);
                        CLEAR(TotalFooterAmountText);
                        CLEAR(InvTotalAmount);
                        CLEAR(AmttoPaid);
                        CLEAR(TotalInvDis);
                        CLEAR(InvLineTotal);
                        IF NOT ExportInvoice THEN
                            DocumentTitleText := STRSUBSTNO(Text52006, CopyText)
                        ELSE
                            DocumentTitleText := STRSUBSTNO(Text52008, CopyText);

                        SalesInvLineAmt.RESET;
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        IF SalesInvLineAmt.FINDSET(FALSE) THEN
                            REPEAT
                                //IF (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") OR (SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::" ") THEN  //KUMBHS03 commnented option not available
                                IF (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") then // OR (SalesInvLineAmt."Attached Line Type 101FDW" = SalesInvLineAmt."Attached Line Type 101FDW"::" ") THEN  //KUMBHS03 added
                                    InvLineTotal += SalesInvLineAmt."Line Amount";
                            UNTIL SalesInvLineAmt.NEXT = 0;

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;

                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        IF SalesInvLine.FINDSET(FALSE) THEN
                            REPEAT

                                CASE SalesInvLine."Attached Line Type 101FDW" OF
                                    SalesInvLine."Attached Line Type 101FDW"::"TAX 102FDW":
                                        TotalFooterAmount[1] += SalesInvLine."Line Amount";
                                    SalesInvLine."Attached Line Type 101FDW"::"EGM 104FDW":
                                        TotalFooterAmount[2] += SalesInvLine."Line Amount";
                                    //SalesInvLine."Item Charge Type"::"Shipping Cost":  // BC Upgrade KUMBHS03 <<
                                    //  TotalFooterAmount[3] += SalesInvLine."Line Amount"; 
                                    SalesInvLine."Attached Line Type 101FDW"::"SPC 105FDW":
                                        BEGIN
                                            // KUMBHS03 >>
                                            IF ItemCh.GET(SalesInvLine."No.") AND ItemCh."Transport/Shipping Cost FND" THEN
                                                TotalFooterAmount[3] += SalesInvLine."Line Amount"
                                            else

                                                IF SalesInvLine."Show Item charge on Inv. FND" <> SalesInvLine."Show Item charge on Inv. FND"::"Include in item price" THEN
                                                    //TotalFooterAmount[4] += ABS(SalesInvLine."Line Amount");
                                                    TotalFooterAmount[4] += SalesInvLine."Line Amount";
                                            // KUMBHS03 <<
                                        END;
                                END;

                            UNTIL SalesInvLine.NEXT = 0;

                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        ShipAmount := TotalFooterAmount[3];

                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        IF SalesInvLine.FINDSET(FALSE) THEN
                            REPEAT
                                TotalFooterAmount[4] += ABS(SalesInvLine."Inv. Discount Amount");
                                TotalFooterAmountText[4] := SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                                TotalFooterAmount[5] += ABS(SalesInvLine."Line Discount Amount");
                                TotalFooterAmountText[5] := SalesInvLine.FIELDCAPTION("Line Discount Amount");
                            UNTIL SalesInvLine.NEXT = 0;

                        InvDisAmount := TotalFooterAmount[4];
                        LineDisAmount := TotalFooterAmount[5];

                        AmttoPaid := InvLineTotal + VATAmount + TaxAmout + ShipAmount - InvDisAmount - LineDisAmount;
                        InvTotalAmount := AmttoPaid + DepAmount;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN
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

                trigger OnPostDataItem()
                begin
                    SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies);
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;

                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                CurrReportID: Integer;
                i: Integer;
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
            begin
                //-----Currency
                IF "Currency Code" <> '' THEN
                    CurrencyCode := "Currency Code"
                ELSE
                    CurrencyCode := GLSetup."LCY Code";

                //-----Footer Texts
                CLEAR(CurrReportID);
                CLEAR(i);
                CLEAR(TextFooter);
                EVALUATE(CurrReportID, COPYSTR(CurrReport.OBJECTID(FALSE), 8));
                // BC Upgrade KUMBHS03 >> ----Drink-IT Table (StandardTextReport)
                StandardTextReport.SETRANGE("Report ID", CurrReportID);
                StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);
                IF StandardTextReport.FINDSET(FALSE) THEN
                    REPEAT
                        i := 1;
                        ExtendedTextHeader.RESET();
                        ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                        ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                        IF ExtendedTextHeader.FINDSET(FALSE) THEN //BEGIN
                            REPEAT
                                ExtendedTextLine.RESET();
                                ExtendedTextLine.SETRANGE("Table Name", ExtendedTextHeader."Table Name");
                                ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                                ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                                ExtendedTextLine.SETRANGE("Language Code", "Language Code");
                                IF ExtendedTextHeader."All Language Codes" THEN
                                    ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
                                IF ExtendedTextLine.FINDSET(FALSE) THEN //BEGIN
                                    REPEAT
                                        TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                                    UNTIL (ExtendedTextLine.NEXT = 0) OR (i > ARRAYLEN(TextFooter));
                                // END;
                                i += 1;
                            UNTIL (ExtendedTextHeader.NEXT() = 0);
                    //END;
                    UNTIL (StandardTextReport.NEXT() = 0);
                // BC Upgrade KUMBHS03 << ----Drink-IT Table  (StandardTextReport)

                //Company Text
                CLEAR(CompanyText);
                CompanyText := CompanyInfo.Name;
                IF (CompanyInfo.Address <> '') THEN
                    CompanyText += ', ' + CompanyInfo.Address;
                IF (CompanyInfo."Address 2" <> '') THEN
                    CompanyText += ', ' + CompanyInfo."Address 2";
                IF (CompanyInfo."Post Code" <> '') THEN
                    CompanyText += ', ' + CompanyInfo."Post Code";
                IF (CompanyInfo.City <> '') THEN
                    CompanyText += ' ' + CompanyInfo.City;
                IF (CompanyInfo."Country/Region Code" <> '') THEN
                    IF CountryInfo.GET(CompanyInfo."Country/Region Code") THEN
                        CompanyText += ', ' + CompanyInfo."Country/Region Code" + ' ' + CountryInfo.Name;

                // BC Upgrade SHUKLP03 >> ---- Field ("Tax Registration No.")
                IF CUSTOMSDOCManage.get() THEN;
                IF CUSTOMSDOCManage."Tax Registration No." <> '' THEN
                    CompanyText += ', ' + TaxNoID + ' ' + CUSTOMSDOCManage."Tax Registration No.";
                // BC Upgrade SHUKLP03 << ---- Field ("Tax Registration No.")

                IF CompanyInfo."Phone No." <> '' THEN
                    CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                IF CompanyInfo."Fax No." <> '' THEN
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";

                IF "Sales Invoice Header"."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" THEN
                    ExportInvoice := TRUE
                ELSE
                    ExportInvoice := FALSE;

                IF "Sales Invoice Header"."Document Subtype Code FND" IN [DocSubtypeCodeSetup."Sundry Sales Order Non Stock", DocSubtypeCodeSetup."Sundry Sales Order Stock"] THEN
                    ExportInvoice := FALSE;

                TotalGrossWeight := 0;
                TotalNetWeight := 0;

                TEMPAccSchedKPIBuffer.DELETEALL;
                IF Country.GET(CompanyInfo."Country/Region Code") THEN
                    CompanyInfoContryName := Country.Name;

                // BC Upgrade KUMBHS03 >> -- Language table dont have the  GetLanguageID now we use lnguage codeunit to handel this
                // CurrReport.LANGUAGE := Language1.GetLanguageID("Language Code");
                LanguageID := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                CurrReport.Language := LanguageID;
                // BC Upgrade KUMBHS03 <<

                IF SalesPerson.GET("Sales Invoice Header"."Salesperson Code") THEN;

                IF ShipmentMethod.GET("Sales Invoice Header"."Shipment Method Code") THEN
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Invoice Header"."Language Code");

                IF PaymentTerms.GET("Payment Terms Code") THEN
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Invoice Header"."Language Code");

                PaymentMethod.RESET;
                IF PaymentMethod.GET("Payment Method Code") THEN;

                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalExText := STRSUBSTNO(Text52001, GLSetup."LCY Code");
                    TotalInText := STRSUBSTNO(Text52002, GLSetup."LCY Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := STRSUBSTNO(Text52005, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalExText := STRSUBSTNO(Text52001, "Currency Code");
                    TotalInText := STRSUBSTNO(Text52002, "Currency Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, "Currency Code");
                    SubTotalExText := STRSUBSTNO(Text52005, "Currency Code");
                END;


                CustomerNo := '';
                CustomerName := '';
                CustomerAddress := '';
                IF Customer.GET("Sales Invoice Header"."Bill-to Customer No.") THEN BEGIN
                    ;
                    CustomerNo := "Bill-to Customer No.";
                    CustomerName := "Bill-to Name";
                    CustomerAddress := "Bill-to City" + ', ' + "Bill-to Address" + ', ' + "Bill-to Address 2";
                    IF ("Bill-to City" <> '') AND ("Bill-to Address" <> '') AND ("Bill-to Address 2" <> '') THEN
                        CustomerAddress := "Bill-to City" + ', ' + "Bill-to Address" + ', ' + "Bill-to Address 2";

                    IF ("Bill-to City" = '') AND ("Bill-to Address" <> '') AND ("Bill-to Address 2" <> '') THEN
                        CustomerAddress := "Bill-to Address" + ', ' + "Bill-to Address 2";
                    IF ("Bill-to City" <> '') AND ("Bill-to Address" = '') AND ("Bill-to Address 2" <> '') THEN
                        CustomerAddress := "Bill-to City" + ', ' + "Bill-to Address 2";
                    IF ("Bill-to City" <> '') AND ("Bill-to Address" <> '') AND ("Bill-to Address 2" = '') THEN
                        CustomerAddress := "Bill-to City" + ', ' + "Bill-to Address";

                    IF ("Bill-to City" = '') AND ("Bill-to Address" = '') AND ("Bill-to Address 2" <> '') THEN
                        CustomerAddress := "Bill-to Address 2";
                    IF ("Bill-to City" <> '') AND ("Bill-to Address" = '') AND ("Bill-to Address 2" = '') THEN
                        CustomerAddress := "Bill-to City";
                    IF ("Bill-to City" = '') AND ("Bill-to Address" <> '') AND ("Bill-to Address 2" = '') THEN
                        CustomerAddress := "Bill-to Address";
                END;

                CLEAR(CustomerAttributestext);
                IF CustomerAttributes.GET("Sales Invoice Header"."Bill-to Customer No.") THEN BEGIN
                    IF CustomerAttributes."Name 3" <> '' THEN
                        CustomerAttributestext += CustomerAttributes."Name 3" + '<br/>';
                    IF CustomerAttributes."Name 4" <> '' THEN
                        CustomerAttributestext += CustomerAttributes."Name 4" + '<br/>';
                    IF CustomerAttributes."Street 3" <> '' THEN
                        CustomerAttributestext += CustomerAttributes."Street 3" + '<br/>';
                    IF CustomerAttributes."Street 4" <> '' THEN
                        CustomerAttributestext += CustomerAttributes."Street 4" + '<br/>';
                    IF CustomerAttributes."Street 5" <> '' THEN
                        CustomerAttributestext += CustomerAttributes."Street 5" + '<br/>';
                    IF CustomerAttributes."House No. 1" <> '' THEN
                        CustomerAttributestext += CustomerAttributes."House No. 1" + '<br/>';
                    IF CustomerAttributes."House Supplement 2" <> '' THEN
                        CustomerAttributestext += CustomerAttributes."House Supplement 2" + '<br/>';
                END;

                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                IF SalesInvLine.FINDFIRST THEN
                    VATPer := SalesInvLine."VAT %";

                IF "Sales Invoice Header"."Prices Including VAT" = TRUE THEN
                    PriceIncVAT := 'Yes'
                ELSE
                    PriceIncVAT := 'No';

                VatAmt := 0;
                lineNumberVAT := 0;
                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                IF SalesInvLine.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                        VATAmount := ABS(VatAmt);

                        TEMPAccSchedKPIBuffer.RESET;
                        TEMPAccSchedKPIBuffer.SETRANGE("Balance at Date Forecast", SalesInvLine."VAT %");
                        IF TEMPAccSchedKPIBuffer.FINDFIRST THEN BEGIN
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.MODIFY;
                        END ELSE BEGIN
                            lineNumberVAT += 1;
                            TEMPAccSchedKPIBuffer.INIT;
                            TEMPAccSchedKPIBuffer."No." := lineNumberVAT;
                            TEMPAccSchedKPIBuffer."Balance at Date Forecast" := SalesInvLine."VAT %";
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.INSERT;
                        END;
                    UNTIL SalesInvLine.NEXT = 0;

                TEMPAccSchedKPIBuffer.RESET;
                IF TEMPAccSchedKPIBuffer.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        Counter += 1;
                        SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%';
                        SplitVatAmount[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Net Change Budget", 0, '<Sign><Integer Thousand><Decimals,3>');
                    UNTIL TEMPAccSchedKPIBuffer.NEXT = 0;

                BillToCustomer.GET("Sales Invoice Header"."Bill-to Customer No.");
                SoldToCustomer.GET("Sales Invoice Header"."Sell-to Customer No.");
                IF BillToCountry.GET(BillToCustomer."Country/Region Code") THEN;
                IF SoldToCountry.GET(SoldToCustomer."Country/Region Code") THEN;

                IF "Sales Invoice Header"."No. Printed" = 0 THEN
                    OriginalCopy := Text50004
                ELSE
                    OriginalCopy := Text52000;

                "Sales Invoice Header".CALCFIELDS("Amount Including VAT");
                TotalAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(TODAY, "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Amount Including VAT", CurrExchRate.ExchangeRate(TODAY, "Sales Invoice Header"."Currency Code"));
            end;

            trigger OnPostDataItem()
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
                        ApplicationArea = all;
                        Caption = 'No. of Copies';
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
        lblPayTerms = 'Payment Terms:';
        lblShipMethod = 'Shipment Method';
        lblAmtPaid = 'Subtotal incl. VAT:';
        lblSalesCondition = 'The Sale Conditions on the back side';
        lblTotalQty = 'Total Quantity';
        lblSalesPerson = 'Sales Person ID:';
        lblUOM = 'Unit';
        lblUnitPrice = 'Unit Price';
        lblSaleLAmt = 'Amount Excl. VAT';
        lblPageNo = 'Page No:';
        lblOrderNo = 'SO Order No:';
        lblInvoiceNo = 'Invoice No:';
        lblVATAmt = 'Total VAT:';
        lblPostDate = 'Invoice Date:';
        lblDueDate = 'Due Date:';
        lblPriceIncVAT = 'Price Including VAT';
        lblDriver = 'Name and Driver Signature';
        lblWarehouse = 'Name and Warehouse Keeper Signature';
        lblSecurity = 'Name and Security Visa';
        lblPrintDate = 'Print Date:';
        LblBillToAddress = 'BILL TO:';
        LblCustomerName = 'Customer Name:';
        LblAddress = 'Address 1:';
        LblAddress2 = 'Address 2:';
        LblPostCode = 'Post Code:';
        LblCity = 'City:';
        LblCountry = 'Country:';
        LblVatRegistrationNo = 'Vat Registration No:';
        LblCompanyTaxId = 'Company Tax ID:';
        LblSoldToAddress = 'CUSTOMER:';
        LblCustomerPoNo = 'Customer PO No:';
        LblTaxDetails = 'Tax Summary';
        LblBankInfo = 'Bank Details:';
        LblAccountNo = 'Account No:';
        LblBankName = 'Bank:';
        LblGiro = 'Giro No.';
        LblIban = 'Iban:';
        LblSwiftCode = 'Swift Code:';
        LblSignature = 'Signature:';
        LblVatPercent = 'Vat Percent';
        LblVatAmount = 'Vat Amount';
        LblIncoTerm = 'InCo Terms:';
        Lbldisc = 'Disc.';
        LblShipToAddress = 'SHIP TO ADDRESS:';
        LblCustomerNo = 'Customer No:';
        LblInvoiceCurrency = 'Invoice Currency:';
        LblVersion = 'Version:';
        LblItemNo = 'Item No.';
        LblQty = 'Qty';
        LblPayMethod = 'Payment Method:';
        LblInvoiceCurrLCY = 'Invoice Curr LCY:';
        LblTotalToBePaid = 'Total to be paid:';
        LblDiscTotal = 'Disc Total:';
        GrossWeightLbl = 'Gross Weight:';
        NetWeightLbl = 'Net Weight:';
        BillOfLadingNoLbl = 'Bill Of Lading No:';
        VesselNameLbl = 'Vessel Name:';
        ETDLbl = 'ETD:';
        ETALbl = 'ETA:';
        AirWayBillNoLbl = 'Air Way Bill No:';
        CommodityCodeLbl = 'Commodity Code:';
        CustomTariffCodeLbl = 'Custom Tariff Code:';
        BankInfo2Lbl = 'Bank Details 2:';
        BankInfo3Lbl = 'Bank Details 3:';
        BankInfo4Lbl = 'Bank Details 4:';
        CustomerServiceEmailLbl = 'Customer Service E-Mail:';
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        SalesSetup.GET;
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND");
        GeneralOpCoSetup.GET;
        DocSubtypeCodeSetup.GET;
    end;

    var
        var_Dis: Decimal;
        tet: Report "Sales invoice Bahamas";
        te: Report "Standard Sales - Invoice";
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        VATEntry: Record "Area";
        LanguageRec: Record "Language"; //Name changed to LanguageRec from Language
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        Customer: Record "Customer";
        SalesPerson: Record "Salesperson/Purchaser";
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvLineAmt: Record "Sales Invoice Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        CUSTOMSDOCManage: Record CustomsDocMgtSetup113FDW; // BC Upgrade KUMBHS03 <<
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        LanguageMgt: Codeunit Language; // BC Upgrade KUMBHS03 <<
        NoOfLoops: Integer;
        NoOfCopies: Integer;
        OutputNo: Integer;
        NUMLines: Integer;
        Text52000: Label 'Copy';
        Text52001: Label 'Total %1 Excl. VAT';
        Text52002: Label 'Total %1 Incl. VAT';
        Text52003: Label 'VAT @ %1 ';
        InvLineTotal: Decimal;
        VatAmt: Decimal;
        VATPer: Decimal;
        LanguageID: Integer;  // BC Upgrade KUMBHS03 <<
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
        Text52008: Label 'Export Invoice';
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
        BillToCustomer: Record "Customer";
        SoldToCustomer: Record "Customer";
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
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND"; // BC Upgrade KUMBHS03
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
        StandardTextReport: Record "Standard Text Report FND"; //BC Upgrade KUMBHS03
        TextFooter: array[3] of Text;
        CurrencyCode: Code[10];
        ItemCh: Record "Item Charge";
}

