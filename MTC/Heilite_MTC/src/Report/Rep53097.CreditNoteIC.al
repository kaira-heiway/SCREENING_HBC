report 53097 "Credit Note IC"
{
    // version IBM 1001

    // HEI.01 Report created
    // HEI.03 INC1003205 IBM HORTOC01 04.12.2018 #add new item charge discount
    // HEI.04 CHG2032964 IBM.LS       07.11.2019
    //   # Multiple customization required as per RFC.
    //   # Additional bug fixed in following values calculation;
    //     1) Montant HT Liquide
    //     2) Subtotal incl. VAT
    //     3) Total to be paid
    //   # Adjusted text boxes height to visible the values and texts for avoiding to cut
    //     bottom and top edge in the report layout.
    //   # Increased text box height of "Page No." for avoiding to cut bottom edge in there.
    //   # Root cause identified, and bug fixed to disappear the duplicate Charge (Item) lines.
    //   # Align the codes and rounding precision for following values to populate in this
    //     report as per “Sales Invoice IC” report.
    //     1) Total VAT (18%)
    //     2) Subtotal incl. VAT:
    //     3) Total to be paid
    // HEI.05 CHG2065016 IBM SAMANR01 22.06.2020
    //   # fix the Invoice Layout Error
    //   # Include type filter "G/L Account"
    // HEI.06 CHG2107018 IBM SAMANR01 19.04.2021
    //   # fix the language code issue on auto billing
    // HEI.08 CHG2349259 IBM COSTES04 30.03.2026 MODIFICATION TAX NUMBER & VAT REGISTRATION NUMBER
    //   # Add Vat registration no. and Tax Number 1 to the right place
    //GUPTAK03 BC UPGRADE --old report ID -50290
    //GUPTAK03 BC UPGRADE CHANGES-- commented the code for Attached Line Type=Shipping cost and "Customer Dtax Group Code"  --no longer used
    //GUPTAK03 BC UPGRADE CHANGES-- Item Charge Type replaced with Attached Line Type
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Credit Note IC.rdl';

    CaptionML = ENU = 'Credit Note IC',
                FRA = 'Avoir IC';
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(SalesHDocNo; "Sales Cr.Memo Header"."No.")
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
            column(CompanyInfo_RCCM; CompanyInfo."RCCM Legal entity code FND")//BC UPGRADE GUPTAK03 field change FND
            {
            }
            column(CompanyInfo_HomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfo_CapSocial; CompanyInfo."Cap. Social FND")//BC UPGRADE GUPTAK03 field change FND
            {
            }
            column(CompanyInfo_OpCoFooter; CompanyInfo."OpCo Footer image FND")//BC UPGRADE GUPTAK03 field change FND
            {
            }
            column(OriginalCopy; OriginalCopy)
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
                    column(SalesHCustNo; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SalesHPostDate; FORMAT("Sales Cr.Memo Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesHDueDate; FORMAT("Sales Cr.Memo Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesHDocDate; FORMAT("Sales Cr.Memo Header"."Document Date", 0, 4))
                    {
                    }
                    column(SalesHIncVAT; PriceIncVAT)
                    {
                    }
                    column(SalesHSalesPerName; SalesPerson.Name)
                    {
                    }
                    column(SalesPersonCode; "Sales Cr.Memo Header"."Salesperson Code")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(SalesHOrdNo; "Sales Cr.Memo Header"."Return Order No.")
                    {
                    }
                    column(SalesHReference; "Sales Cr.Memo Header"."Your Reference")
                    {
                    }
                    column(SalesHExtRefNo; "Sales Cr.Memo Header"."External Document No.")
                    {
                    }
                    column(SalesHVATRegNo; "Sales Cr.Memo Header"."VAT Registration No.")
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
                    column(SalesInvHeader_BillToName; "Sales Cr.Memo Header"."Bill-to Name")
                    {
                    }
                    column(SalesInvHeader_BillToPostCode; "Sales Cr.Memo Header"."Bill-to Post Code")
                    {
                    }
                    column(SalesInvHeader_BillToCity; "Sales Cr.Memo Header"."Bill-to City")
                    {
                    }
                    column(BillToVatRegNo; BillToCustomer."VAT Registration No.")
                    {
                    }
                    column(BillToCountryName; BillToCountry.Name)
                    {
                    }
                    column(SalesInvHeader_SellToName; "Sales Cr.Memo Header"."Sell-to Customer Name")
                    {
                    }
                    column(SalesInvHeader_SellToCity; "Sales Cr.Memo Header"."Sell-to City")
                    {
                    }
                    column(SalesInvHeader_SellToPostCode; "Sales Cr.Memo Header"."Sell-to Post Code")
                    {
                    }
                    column(SellToCountryName; SoldToCountry.Name)
                    {
                    }
                    column(SellToVatRegNo; SoldToCustomer."VAT Registration No.")
                    {
                    }
                    column(SalesInvHeader_BillToAddress; "Sales Cr.Memo Header"."Bill-to Address")
                    {
                    }
                    column(SalesInvHeader_BillToAddress2; "Sales Cr.Memo Header"."Bill-to Address 2")
                    {
                    }
                    column(SalesInvHeader_SellToAddress; "Sales Cr.Memo Header"."Sell-to Address")
                    {
                        IncludeCaption = true;
                    }
                    column(SalesInvHeader_SellToAddress2; "Sales Cr.Memo Header"."Sell-to Address 2")
                    {
                    }
                    column(SalesInvHeader_ShipToName; "Sales Cr.Memo Header"."Ship-to Name")
                    {
                    }
                    column(SalesInvHeader_Address; "Sales Cr.Memo Header"."Ship-to Address")
                    {
                    }
                    column(SalesInvHeader_Address2; "Sales Cr.Memo Header"."Ship-to Address 2")
                    {
                    }
                    column(SalesInvHeader_City; "Sales Cr.Memo Header"."Ship-to City")
                    {
                    }
                    column(SalesInvHeader_Country; ShipToCountry.Name)
                    {
                    }
                    column(SalesInvHeader_ShipToPostCode; "Sales Cr.Memo Header"."Ship-to Post Code")
                    {
                    }
                    column(SellCustomerNo; "Sales Cr.Memo Header"."Sell-to Customer No.")
                    {
                    }
                    column(CurrencyCode; "Sales Cr.Memo Header"."Currency Code")
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
                    column(CustAtt_TaxNo1; CustomerAttributes."Tax Number 1")
                    {
                    }
                    column(CustAtt_TaxNo2; Customer."VAT Registration No.")
                    {
                    }
                    column(CustAtt_TaxNo3; CustomerAttributes."Article d'imposition")
                    {
                    }
                    column(ShipmentNo; PostedShip."No.")
                    {
                    }
                    column(AIRSISalesTax; AIRSISalesTax)
                    {
                    }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER(Item | Resource | "Fixed Asset" | "G/L Account"));
                        column(SalesLine; "Sales Cr.Memo Line"."Line No.")
                        {
                        }
                        column(SalesLType; "Sales Cr.Memo Line".Type)
                        {
                        }
                        column(SalesItem; "Sales Cr.Memo Line"."No.")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesDescrip; "Sales Cr.Memo Line".Description)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesQtyvy; "Sales Cr.Memo Line".Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesUOM; "Sales Cr.Memo Line"."Unit of Measure Code")
                        {
                        }
                        column(SalesPrice; ROUND("Sales Cr.Memo Line"."Unit Price", 1, '='))
                        {
                        }
                        column(SalesAmount; "Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Price")
                        {
                        }
                        column(SalesVATPer; "Sales Cr.Memo Line"."VAT %")
                        {
                            IncludeCaption = true;
                        }
                        column(TotalQuantity; TotalQty)
                        {
                        }
                        column(SalesDiscount; -ItemDiscount)
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
                                TempUnderChargeLine.SETRANGE("Attached to Line No.", "Sales Cr.Memo Line"."Line No.");
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
                                    TempOrderTaxCharge.FINDFIRST()
                                else
                                    TempOrderTaxCharge.NEXT();
                            end;

                            trigger OnPostDataItem();
                            begin
                                TempOrderTaxCharge.DELETEALL();
                            end;

                            trigger OnPreDataItem();
                            begin
                                TempOrderTaxCharge.RESET();
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
                                    TempOrderDiscountCharge.FINDFIRST()
                                else
                                    TempOrderDiscountCharge.NEXT();
                            end;

                            trigger OnPostDataItem();
                            begin
                                TempOrderDiscountCharge.DELETEALL();
                            end;

                            trigger OnPreDataItem();
                            begin
                                TempOrderDiscountCharge.RESET();
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
                                    TempOrderDepositCharge.FINDFIRST()
                                else
                                    TempOrderDepositCharge.NEXT();
                            end;

                            trigger OnPostDataItem();
                            begin
                                TempOrderDepositCharge.DELETEALL();
                            end;

                            trigger OnPreDataItem();
                            begin
                                TempOrderDepositCharge.RESET();
                                SETRANGE(Number, 1, TempOrderDepositCharge.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            //OrderChargeLine: Record "Sales Cr.Memo Line";
                            SalesChargeLine: Record "Sales Cr.Memo Line";
                        begin
                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;
                            ItemDiscount := 0;

                            TotalInvDis += "Sales Cr.Memo Line"."Line Discount Amount";

                            if ItemsInvoice then begin
                                //Discounts under item line
                                CLEAR(PrintUnderLineCharge);
                                SalesChargeLine.RESET();
                                SalesChargeLine.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Cr.Memo Line".Type::"Charge (Item)");
                                SalesChargeLine.SetRange("Attached Line Type 101FDW", "Sales Cr.Memo Line"."Attached Line Type 101FDW"::"EGM 104FDW");//BC UPGRADE GUPTAK03 Item Charge Type-Discount
                                                                                                                                                      // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Cr.Memo Line"."Item Charge Type"::Discount);
                                                                                                                                                      //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line"); HEI.06
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Cr.Memo Line"."Line No.");
                                if SalesChargeLine.FINDSET() then begin
                                    //HEI.06>>
                                    ItemChargeRec.GET(SalesChargeLine."No.");
                                    if ItemChargeRec."Show Item charge on Inv. FND" = ItemChargeRec."Show Item charge on Inv. FND"::"Under item line" then //BC UPGRADE GUPTAK03 field change FND
                                        repeat
                                            /*IF NOT PrintUnderLineCharge THEN
                                              PrintUnderLineCharge := TRUE;

                                            TempUnderChargeLine.INIT;
                                            TempUnderChargeLine := SalesChargeLine;
                                            TempUnderChargeLine.INSERT;*/
                                            ItemDiscount += SalesChargeLine."Line Amount";

                                            SalesChargeLine.CALCSUMS("Line Amount");
                                            SubTotalCharges += SalesChargeLine."Line Amount";
                                            TotalSubTotal += SalesChargeLine."Line Amount";
                                        until (SalesChargeLine.NEXT() = 0)
                                end;
                                //Tax under item line
                                //HEI.04>>
                                CLEAR(PrintUnderLineCharge);
                                //HEI.04<<
                                SalesChargeLine.RESET();
                                SalesChargeLine.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Cr.Memo Line".Type::"Charge (Item)");
                                SalesChargeLine.SetRange("Attached Line Type 101FDW", "Sales Cr.Memo Line"."Attached Line Type 101FDW"::"TAX 102FDW");//BC UPGRADE GUPTAK03 Item charge type=tax
                                //SalesChargeLine.SETRANGE("Item Charge Type", "Sales Cr.Memo Line"."Item Charge Type"::Tax);
                                //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line"); HEI.06
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Cr.Memo Line"."Line No.");
                                if SalesChargeLine.FINDSET() then begin
                                    //HEI.06>>
                                    ItemChargeRec.GET(SalesChargeLine."No.");
                                    if ItemChargeRec."Show Item charge on Inv. FND" = ItemChargeRec."Show Item charge on Inv. FND"::"Under item line" then
                                        //HEI.06<<
                                        repeat
                                            if (SalesChargeLine."Line Amount" <> 0) then begin
                                                if not PrintUnderLineCharge then
                                                    PrintUnderLineCharge := true;
                                                TempUnderChargeLine.INIT();
                                                TempUnderChargeLine := SalesChargeLine;
                                                TempUnderChargeLine.INSERT();
                                            end;
                                            //HEI.04>>
                                            SubTotalCharges += SalesChargeLine."Line Amount";
                                            TotalSubTotal += SalesChargeLine."Line Amount";
                                        //HEI.04<<
                                        until (SalesChargeLine.NEXT() = 0);
                                    //HEI.04>>
                                    //SalesChargeLine.CALCSUMS("Line Amount");
                                    //SubTotalCharges += SalesChargeLine."Line Amount";
                                    //TotalSubTotal += SalesChargeLine."Line Amount";
                                    //HEI.04<<
                                end;

                                //Deposit under item line
                                CLEAR(PrintUnderLineCharge);
                                SalesChargeLine.RESET();
                                SalesChargeLine.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Cr.Memo Line".Type::"Charge (Item)");
                                SalesChargeLine.SetRange("Attached Line Type 101FDW", "Sales Cr.Memo Line"."Attached Line Type 101FDW"::"EGM 104FDW");//BC UPGRADE GUPTAK03 Item charge type=deposit
                                //SalesChargeLine.SETRANGE("Item Charge Type", "Sales Cr.Memo Line"."Item Charge Type"::Deposit);
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Cr.Memo Line"."Line No.");
                                if SalesChargeLine.FINDSET() then begin
                                    //HEI.06>>
                                    ItemChargeRec.GET(SalesChargeLine."No.");
                                    //IF ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Under item line" THEN
                                    repeat
                                        if not PrintUnderLineCharge then
                                            PrintUnderLineCharge := true;
                                        TempUnderChargeLine.INIT();
                                        TempUnderChargeLine := SalesChargeLine;
                                        TempUnderChargeLine.INSERT();

                                        SalesChargeLine.CALCSUMS("Line Amount");
                                        //SubTotalCharges += SalesChargeLine."Line Amount";
                                        TotalSubTotal += SalesChargeLine."Line Amount";
                                    until (SalesChargeLine.NEXT() = 0)
                                end;
                            end;

                        end;
                    }
                    dataitem(SplitVatAmt; "Integer")
                    {
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

                        DocumentTitleText := STRSUBSTNO(Text52006, CopyText);
                        //DocumentTitleText := STRSUBSTNO(Text52004B,CopyText);
                        SalesInvLineAmt.RESET();
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        //HEI.04>>
                        //SalesInvLineAmt.SETFILTER(Type,'<>%1',SalesInvLineAmt.Type::" ");
                        // >>HEI.05
                        //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset");
                        SalesInvLineAmt.SETFILTER(Type, '%1|%2|%3|%4', SalesInvLineAmt.Type::Item, SalesInvLineAmt.Type::Resource, SalesInvLineAmt.Type::"Fixed Asset", SalesInvLineAmt.Type::"G/L Account");
                        // <<HEI.05
                        //HEI.04<<
                        if SalesInvLineAmt.FINDSET() then
                            repeat
                                InvLineTotal += SalesInvLineAmt."Line Amount";
                            until SalesInvLineAmt.NEXT() = 0;

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        if SalesInvLine.FINDSET() then
                            repeat
                                //BC UPGRADE GUPTAK03 Item charge type change
                                case SalesInvLine."Attached Line Type 101FDW" of
                                    SalesInvLine."Attached Line Type 101FDW"::"TAX 102FDW":
                                        begin
                                            //HEI.04>>
                                            ItemChargeRec.GET(SalesInvLine."No.");
                                            if ItemChargeRec."Show Item charge on Inv. FND" = ItemChargeRec."Show Item charge on Inv. FND"::"Under item line" then //BC UPGRADE GUPTAK03 field change FND
                                                //HEI.04<<
                                                TotalFooterAmount[1] += SalesInvLine."Line Amount";
                                            //TotalFooterAmountText[1]:= 'Excise Duties';
                                        end;
                                    SalesInvLine."Attached Line Type 101FDW"::"EGM 104FDW":

                                        TotalFooterAmount[2] += SalesInvLine."Line Amount";
                                    //TotalFooterAmountText[2]:= 'Deposit Amount';

                                    //BC UPGRADE GUPTAK03 commented as Attached Line Type=Shipping cost does not exist any more.-->>
                                    // SalesInvLine."Item Charge Type"::"Shipping Cost":
                                    //     begin
                                    //         TotalFooterAmount[3] += SalesInvLine."Line Amount";
                                    //         TotalFooterAmountText[3] := 'Shipping Amount:';
                                    //     end; 
                                    //<<--BC UPGRADE GUPTAK03 commented as Attached Line Type=Shipping cost does not exist any more.

                                    SalesInvLine."Attached Line Type 101FDW"::"SPC 105FDW":
                                        begin
                                            if SalesInvLine."No." = 'S_MARKUP' then begin
                                                TotalFooterAmount[5] += SalesInvLine."Line Amount";
                                                TotalFooterAmountText[5] := 'Markup Charges:';

                                                //TotalFooterAmount[3] += SalesInvLine."Line Amount";
                                                //TotalFooterAmountText[3]:= 'All Discounts';
                                            end;
                                            //HEI.03>>
                                            if SalesInvLine."No." = 'A1.PPR' then begin
                                                TotalFooterAmount[7] += SalesInvLine."Line Amount";
                                                TotalFooterAmountText[7] := 'Base Margin PPR:';
                                            end;
                                            //HEI.03<<
                                            if SalesInvLine."No." = 'S_SHIP' then begin
                                                TotalFooterAmount[6] += SalesInvLine."Line Amount";
                                                //TotalFooterAmountText[6]:= 'Shipping Charges';
                                                /*IF TotalFooterAmountText[3] = 'All Discounts' THEN
                                                  TotalFooterAmountText[3]:= 'All Discounts'
                                                ELSE
                                                  TotalFooterAmountText[3]:= 'Shipping Charges';*/
                                            end;
                                        end;
                                end;
                            until SalesInvLine.NEXT() = 0;
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

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        if SalesInvLine.FINDSET() then
                            repeat
                                TotalFooterAmount[4] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[4] := 'Line Discount Amount:';
                            until SalesInvLine.NEXT() = 0;
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
                    SalesInvCountPrinted.RUN("Sales Cr.Memo Header");
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
                SalesInvLine2: Record "Sales Cr.Memo Line";
                SalesInvLine3: Record "Sales Cr.Memo Line";
                OrderChargeLine: Record "Sales Cr.Memo Line";
                SalesReceivablesSetupL: Record "Sales & Receivables Setup";
                AccountGroupL: Record "Account Group FND";//BC UPGRADE GUPTAK03 record change FND
                                                          // DrinkTaxGroupL: Record "Drink Tax Group";//BC UPGRADE GUPTAK03 commented as unused
                AIRSIChargeLineL: Record "Sales Cr.Memo Line";
                ItemChargeL: Record "Item Charge";
            begin
                TEMPAccSchedKPIBuffer.DELETEALL();
                if Country.GET(CompanyInfo."Country/Region Code") then
                    CompanyInfoContryName := Country.Name;

                //-----Item Invoice
                SalesInvLine2.RESET();
                SalesInvLine2.SETRANGE("Document No.", "No.");
                //HEI.04>>
                //SalesInvLine2.SETRANGE(Type, SalesInvLine2.Type::Item);
                SalesInvLine2.SETRANGE(Type, SalesInvLine2.Type::Item);
                //HEI.04<<
                if not SalesInvLine2.ISEMPTY then ItemsInvoice := true;

                if SalesPerson.GET("Sales Cr.Memo Header"."Salesperson Code") then;

                if ShipmentMethod.GET("Sales Cr.Memo Header"."Shipment Method Code") then
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Cr.Memo Header"."Language Code");

                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Cr.Memo Header"."Language Code");

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
                if Customer.GET("Sales Cr.Memo Header"."Bill-to Customer No.") then begin
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
                if CustomerAttributes.GET("Sales Cr.Memo Header"."Bill-to Customer No.") then begin
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

                /*VATEntry.RESET()
                VATEntry.SETRANGE(Type,VATEntry.Type::Sale);
                VATEntry.SETRANGE("Document Type",VATEntry."Document Type"::Invoice);
                VATEntry.SETRANGE("Document No.","Sales Invoice Header"."No.");
                IF VATEntry.FINDSET THEN REPEAT
                  //VatAmt += ABS(VATEntry.Amount);
                  VatAmt += VATEntry.Amount;
                UNTIL VATEntry.NEXT=0;
                VATAmount := ABS(VatAmt);*/

                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.FINDFIRST() then
                    VATPer := SalesInvLine."VAT %";

                if "Sales Cr.Memo Header"."Prices Including VAT" = true then
                    PriceIncVAT := 'Yes'
                else
                    PriceIncVAT := 'No';

                //HEI.04>>
                CALCFIELDS("Amount Including VAT", Amount);
                VatAmt += "Amount Including VAT" - Amount;
                VATAmount := ABS(VatAmt);
                //HEI.04<<

                VatAmt := 0;
                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.FINDSET() then
                    repeat
                        //HEI.04>>
                        //VatAmt += (SalesInvLine."VAT Base Amount"* SalesInvLine."VAT %")/100;
                        //VATAmount := ABS(VatAmt);
                        //HEI.04<<

                        //split VAT
                        if TEMPAccSchedKPIBuffer.GET(SalesInvLine."VAT %") then begin
                            //HEI.04>>
                            //TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %")/100;
                            TEMPAccSchedKPIBuffer."Net Change Budget" += SalesInvLine."Amount Including VAT" - SalesInvLine.Amount;
                            //HEI.04<<
                            TEMPAccSchedKPIBuffer.MODIFY();
                        end else begin
                            TEMPAccSchedKPIBuffer.INIT();
                            TEMPAccSchedKPIBuffer."No." := SalesInvLine."VAT %";
                            //HEI.04>>
                            //TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount"* SalesInvLine."VAT %")/100;
                            TEMPAccSchedKPIBuffer."Net Change Budget" += SalesInvLine."Amount Including VAT" - SalesInvLine.Amount;
                            //HEI.04<<
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

                BillToCustomer.GET("Sales Cr.Memo Header"."Bill-to Customer No.");
                SoldToCustomer.GET("Sales Cr.Memo Header"."Sell-to Customer No.");
                if BillToCountry.GET(BillToCustomer."Country/Region Code") then;
                if SoldToCountry.GET(SoldToCustomer."Country/Region Code") then;
                if ShipToCountry.GET("Sales Cr.Memo Header"."Ship-to Country/Region Code") then;

                if "Sales Cr.Memo Header"."No. Printed" = 0 then
                    OriginalCopy := Text50004
                else
                    OriginalCopy := Text52000;

                "Sales Cr.Memo Header".CALCFIELDS("Amount Including VAT");
                TotalAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(TODAY, "Sales Cr.Memo Header"."Currency Code", "Sales Cr.Memo Header"."Amount Including VAT", CurrExchRate.ExchangeRate(TODAY, "Sales Cr.Memo Header"."Currency Code"));

                CLEAR(TotalDeposits);
                CLEAR(TotalDiscounts);
                CLEAR(TotalTaxes);
                //HEI.04>>
                CLEAR(AIRSISalesTax);
                //HEI.04<<

                if ItemsInvoice then begin
                    //-----Order total /blank Discount Charges
                    OrderChargeLine.RESET();
                    OrderChargeLine.SETRANGE("Document No.", "No.");
                    OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                    OrderChargeLine.SetRange("Attached Line Type 101FDW", "Sales Cr.Memo Line"."Attached Line Type 101FDW"::"SPC 105FDW");//BC UPGRADE GUPTAK03 Item charge type=discount
                    //OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Discount);
                    if OrderChargeLine.FINDSET() then begin
                        ItemChargeRec.GET(OrderChargeLine."No.");
                        if (ItemChargeRec."Show Item charge on Inv. FND" = ItemChargeRec."Show Item charge on Inv. FND"::"Order total")
                           or (ItemChargeRec."Show Item charge on Inv. FND" = ItemChargeRec."Show Item charge on Inv. FND"::" ")//BC UPGRADE GUPTAK03 Field change FND
                        then begin
                            PrintOrderDiscounts := true;
                            repeat
                                TempOrderDiscountCharge.INIT();
                                TempOrderDiscountCharge := OrderChargeLine;
                                TempOrderDiscountCharge.INSERT();
                            until (OrderChargeLine.NEXT() = 0);
                            OrderChargeLine.CALCSUMS("Line Amount");
                            TotalDiscounts += OrderChargeLine."Line Amount";
                        end;
                    end;
                    //-----Order total /blank Deposit Charges
                    OrderChargeLine.RESET();
                    OrderChargeLine.SETRANGE("Document No.", "No.");
                    OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                    OrderChargeLine.SetRange("Attached Line Type 101FDW", OrderChargeLine."Attached Line Type 101FDW"::"EGM 104FDW");//GUPTAK03
                    //OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Deposit);
                    if OrderChargeLine.FINDSET() then begin
                        ItemChargeRec.GET(OrderChargeLine."No.");
                        if (ItemChargeRec."Show Item charge on Inv. FND" = ItemChargeRec."Show Item charge on Inv. FND"::"Order total")
                           or (ItemChargeRec."Show Item charge on Inv. FND" = ItemChargeRec."Show Item charge on Inv. FND"::" ")
                        then begin
                            PrintOrderDeposits := true;
                            repeat
                                TempOrderDepositCharge.INIT();
                                TempOrderDepositCharge := OrderChargeLine;
                                TempOrderDepositCharge.INSERT();
                            until (OrderChargeLine.NEXT() = 0);
                            OrderChargeLine.CALCSUMS("Line Amount");
                            TotalDeposits += OrderChargeLine."Line Amount";
                        end;
                    end;
                    //-----Order total /blank Tax Charges
                    OrderChargeLine.RESET();
                    OrderChargeLine.SETRANGE("Document No.", "No.");
                    OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                    OrderChargeLine.SetRange("Attached Line Type 101FDW", OrderChargeLine."Attached Line Type 101FDW"::"TAX 102FDW");//BC UPGRADE GUPTAK03
                    //OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Tax);
                    if OrderChargeLine.FINDSET() then begin
                        ItemChargeRec.GET(OrderChargeLine."No.");
                        if (ItemChargeRec."Show Item charge on Inv. FND" = ItemChargeRec."Show Item charge on Inv. FND"::"Order total")
                           or (ItemChargeRec."Show Item charge on Inv. FND" = ItemChargeRec."Show Item charge on Inv. FND"::" ")//BC UPGRADE GUPTAK03
                        then begin
                            repeat
                                if (OrderChargeLine."Line Amount" <> 0) then begin
                                    PrintOrderTaxes := true;
                                    TempOrderTaxCharge.INIT();
                                    TempOrderTaxCharge := OrderChargeLine;
                                    TempOrderTaxCharge.INSERT();
                                end;
                            until (OrderChargeLine.NEXT() = 0);
                            OrderChargeLine.CALCSUMS("Line Amount");
                            TotalTaxes += OrderChargeLine."Line Amount";
                        end;
                    end;
                    //HEI.04>>
                    // SalesReceivablesSetupL.GET();
                    // if SalesReceivablesSetupL."Account Group for AIRSI FND" <> '' then begin //GUPTAK03
                    //     if (SoldToCustomer."No." <> BillToCustomer."No.") and (BillToCustomer."No." = '') then begin
                    //         if SoldToCustomer."Account Group FND" = SalesReceivablesSetupL."Account Group for AIRSI FND" then begin //GUPTAK03
                    //     AccountGroupL.GET(SoldToCustomer."Account Group FND");
                    //DrinkTaxGroupL.GET(DrinkTaxGroupL."Source Type"::Customer, SoldToCustomer."Customer DTax Group Code"); //GUPTAK03 commented as unused
                    // if SoldToCustomer."Customer DTax Group Code" = "Customer DTax Group Code" then begin
                    //     AIRSIChargeLineL.SETRANGE("Document No.", "No.");
                    //     AIRSIChargeLineL.SETRANGE(Type, AIRSIChargeLineL.Type::"Charge (Item)");
                    //     // AIRSIChargeLineL.SETRANGE("Item Charge Type", AIRSIChargeLineL."Item Charge Type"::Tax);
                    //     AIRSIChargeLineL.SetRange("Attached Line Type 101FDW", AIRSIChargeLineL."Attached Line Type 101FDW"::"TAX 102FDW");//GUPTAK03
                    //     if AIRSIChargeLineL.FINDSET then begin
                    //         repeat
                    //             if AIRSIChargeLineL."Line Amount" <> 0 then begin
                    //                 ItemChargeL.GET(AIRSIChargeLineL."No.");
                    //                 AIRSISalesTax += AIRSIChargeLineL."Line Amount";
                    //             end;
                    //         until AIRSIChargeLineL.NEXT() = 0;
                    //     end;
                    //     end;
                    // end;
                    //         end else begin
                    //             if BillToCustomer."Account Group FND" = SalesReceivablesSetupL."Account Group for AIRSI FND" then begin
                    //                 AccountGroupL.GET(BillToCustomer."Account Group FND");
                    // DrinkTaxGroupL.GET(DrinkTaxGroupL."Source Type"::Customer, BillToCustomer."Customer DTax Group Code");//GUPTAK03 commented as unused
                    // if BillToCustomer."Customer DTax Group Code" = "Customer DTax Group Code" then begin
                    //     AIRSIChargeLineL.SETRANGE("Document No.", "No.");
                    //     AIRSIChargeLineL.SETRANGE(Type, AIRSIChargeLineL.Type::"Charge (Item)");
                    //     // AIRSIChargeLineL.SETRANGE("Item Charge Type", AIRSIChargeLineL."Item Charge Type"::Tax);
                    //     AIRSIChargeLineL.SetRange("Attached Line Type 101FDW", AIRSIChargeLineL."Attached Line Type 101FDW"::"TAX 102FDW");//GUPTAK03
                    //     if AIRSIChargeLineL.FINDSET then begin
                    //         repeat
                    //             if AIRSIChargeLineL."Line Amount" <> 0 then begin
                    //                 ItemChargeL.GET(AIRSIChargeLineL."No.");
                    //                 AIRSISalesTax += AIRSIChargeLineL."Line Amount";
                    //             end;
                    //         until AIRSIChargeLineL.NEXT() = 0;
                    //     end;
                    // end;
                    //     end;
                    // end;
                    //     end;
                    //HEI.04<<
                end;

                //*** find Shipping no
                /*PostedShip.RESET()
                PostedShip.SETRANGE("Order No.","Sales Invoice Header"."Order No.");
                IF PostedShip.FINDFIRST() THEN;*/

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
                        ToolTip = 'No. Of Copies';
                        Caption = 'No. Of Copies';
                        ApplicationArea = All;
                    }
                    field(LangCode; LangCode)
                    {
                        Caption = 'Local Language Code';
                        ToolTip = 'Local Language Code';
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
        lblPageNo = 'Page No.:'; label(lblOrderNo; ENU = 'RO Order No.:',
                                                 FRA = 'N° de commande:')
        label(lblInvoiceNo; ENU = 'Credit Note No.:',
                           FRA = 'N° Facture:')
        label(lblVATAmt; ENU = 'Total VAT (18%):',
                        FRA = 'Total TVA (18%):')
        label(lblPostDate; ENU = 'Credit memo Date:',
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
        LblVatRegistrationNo = 'Vat Registration No.:'; LblCompanyTaxId = 'Company Tax ID:'; label(LblSoldToAddress; ENU = 'CUSTOMER:',
                                                                                                                  FRA = 'Client:')
        LblCustomerPoNo = 'Customer PO No.:'; label(LblTaxDetails; ENU = 'Tax Summary',
                                                                 FRA = 'Taux de Tva')
        label(LblBankInfo; ENU = 'Bank Details:',
                          FRA = 'Coordonnées bancaires pour règlement par virement: ')
        LblAccountNo = 'Account No.:'; LblBankName = 'Bank:'; LblGiro = 'Giro No.'; LblIban = 'Iban:'; LblSwiftCode = 'Swift Code:'; LblSignature = 'Signature:'; LblVatPercent = 'Vat Percent'; LblVatAmount = 'Vat Amount'; LblIncoTerm = 'InCo Terms:'; label(Lbldisc; ENU = 'Disc.',
                                                                                                                                                                                                                                                                FRA = 'MT Total Remise')
        label(LblShipToAddress; ENU = 'SHIP TO ADDRESS:',
                               FRA = 'Client livré:')
        label(LblCustomerNo; ENU = 'Customer No.:',
                            FRA = 'N° Client:')
        label(LblInvoiceCurrency; ENU = 'CN. Currency:',
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
        LblTotalAIRSIPercentage = 'Total AIRSI (5%):'; label(LblTaxAIRSI; ENU = 'Tax Summary AIRSI',
                                                                        FRA = 'Taux de AIRSI')
        LblAIRSIPercentage = '5%'; LblTotal = 'Total';
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND");//GUPTAK03
        PrintOrderDiscounts := false;
        // >>HEI.06
        if LangCode <> '' then
            CurrReport.LANGUAGE := RecLanguage.GetLanguageID(LangCode)
        else
            CurrReport.LANGUAGE := RecLanguage.GetLanguageID('FRA');
        // <<HEI.06
    end;

    var
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        VATEntry: Record "VAT Entry";
        RecLanguage: Record Language;//GUPTAK03 global variable name conflict
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        Customer: Record Customer;
        SalesPerson: Record "Salesperson/Purchaser";
        SalesInvLine: Record "Sales Cr.Memo Line";
        SalesInvLineAmt: Record "Sales Cr.Memo Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        SalesInvCountPrinted: Codeunit "Sales Cr. Memo-Printed";
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
        Text52006: TextConst ENU = 'Credit Note', FRA = 'Avoir';
        TaxAmout: Decimal;
        VATAmount: Decimal;
        DepAmount: Decimal;
        ShipAmount: Decimal;
        LineDisAmount: Decimal;
        ShippingChargesAmount: Decimal;
        MarkupChargesAmount: Decimal;
        CustomerAttributes: Record "Customer Attributes FND";//GUPTAK03
        CustomerAttributestext: Text[1024];
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
        TempOrderDiscountCharge: Record "Sales Cr.Memo Line" temporary;
        TempOrderDepositCharge: Record "Sales Cr.Memo Line" temporary;
        TempUnderChargeLine: Record "Sales Cr.Memo Line" temporary;
        TempOrderTaxCharge: Record "Sales Cr.Memo Line" temporary;
        //[InDataSet]
        ItemsInvoice: Boolean;
        ItemChargeRec: Record "Item Charge";
        PrintOrderDiscounts: Boolean;
        PrintOrderDeposits: Boolean;
        PrintOrderTaxes: Boolean;
        PrintUnderLineCharge: Boolean;
        TotalDiscounts: Decimal;
        TotalDeposits: Decimal;
        TotalTaxes: Decimal;
        SubTotalCharges: Decimal;
        TotalSubTotal: Decimal;
        ShipToCountry: Record "Country/Region";
        ItemDiscount: Decimal;
        PostedShip: Record "Sales Shipment Header";
        AIRSISalesTax: Decimal;
        LangCode: Code[10];
}

