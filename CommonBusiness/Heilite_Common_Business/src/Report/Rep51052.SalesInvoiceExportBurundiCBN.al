report 51052 "Sales Inv Export Burundi CBN"
{
    // version HEI.01

    // HEI.01 Report created
    // HEI.02 Defect #5011 IBM POSTOI01 11.12.2019 # Burundi FAT
    //   #TextBox 144 field from layout, change the Text Box Properties-> Number : Decimal places = 0
    // HEI.04 CHG2064677 IBM SHANKJ03 29.05.2020
    //   # Layout Change - Proerties for all amount field changed from 0 decimal Places to 2
    // HEI.05 CHG2069329 IBM SAMANR01 08.07.2020
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
    //********************************************************************************
    //BC UPGRADE PATHAA02- 17Dec25
    //Code conditions related DIT fields are commented but need to uncomment back once Aptean Ext/Code is merged.
    //GetlanguageID Function removed in Table and placed in CU in BC

    DefaultLayout = RDLC;
    //RDLCLayout = '.\src\Sales Invoice - Export Burundi.rdl';//BC UPGRADE PATHAA02
    RDLCLayout = '.\src\Reportslayout\Sales Invoice - Export Burundi.rdl';//BC UPGRADE PATHAA02 
    CaptionML = ENU = 'Sales Invoice - Export Burundi',
                ENG = 'Sales Invoice - Export Burundi';
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

            //BC UPGRADE PATHAA02-DIT>>
            // column(CompanyInfo_BankName2;CompanyInfo."Bank Name 2")//(DIT-F2029610)
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
            //BC UPGRADE PATHAA02-DIT<<
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
                    column(ProductDisAmnt; ProductDisAmnt)
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

                            if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then begin
                                //TotalGrossWeight += "Sales Invoice Line".Weight;//BC UPGRDADE PATHAA02-DIT
                                TotalNetWeight += "Sales Invoice Line"."Net Weight";
                            end;
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
                        SalesInvLineAmt.SETFILTER(Type, '%1|%2|%3', SalesInvLineAmt.Type::Item, SalesInvLineAmt.Type::Resource, SalesInvLineAmt.Type::"Fixed Asset");
                        if SalesInvLineAmt.findset() then
                            repeat
                                //HEI.03 InvLineTotal += SalesInvLineAmt."Line Amount";
                                InvLineTotal += SalesInvLineAmt.Amount; //HEI.03
                            until SalesInvLineAmt.NEXT() = 0;



                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        //BC UPGRADE PATHAA02 DIT "Item Charge Type"-code commented>>
                        // if SalesInvLine.findset then
                        //     repeat
                        //         case SalesInvLine."Item Charge Type" of
                        //             SalesInvLine."Item Charge Type"::Tax:
                        //                 begin
                        //                     TotalFooterAmount[1] += SalesInvLine.Amount; //HEI.03

                        //                 end;
                        //             SalesInvLine."Item Charge Type"::Deposit:
                        //                 begin
                        //                     TotalFooterAmount[2] += SalesInvLine."Line Amount";

                        //                 end;
                        //             SalesInvLine."Item Charge Type"::"Shipping Cost":
                        //                 begin
                        //                     TotalFooterAmount[3] += SalesInvLine.Amount; //HEI.03
                        //                     TotalFooterAmountText[3] := 'Shipping Amount:';
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::Discount:
                        //                 begin
                        //                     TotalInvDis += SalesInvLine."Line Amount";//HEI.04
                        //                                                               /*
                        //                                                               IF SalesInvLine."No." = 'S_MARKUP' THEN BEGIN
                        //                                                                TotalFooterAmount[5] += SalesInvLine.Amount; //HEI.03
                        //                                                                TotalFooterAmountText[5]:= 'Markup Charges:';


                        //                                                               end;

                        //                                                               IF SalesInvLine."No." = 'A1.PPR' THEN BEGIN
                        //                                                                TotalFooterAmount[7] += SalesInvLine.Amount;//HEI.03
                        //                                                                TotalFooterAmountText[7]:= 'Base Margin PPR:';
                        //                                                               end;
                        //                                                               */
                        //                     if SalesInvLine."No." = 'S_SHIP' then
                        //                         TotalFooterAmount[6] += SalesInvLine.Amount //HEI.03
                        //                     else
                        //                         TotalFooterAmount[7] += SalesInvLine.Amount;

                        //                 end;
                        //         end;
                        //     until SalesInvLine.NEXT = 0;
                        //BC UPGRADE PATHAA02-code commented<<

                        ///MESSAGE('%1-Inv',InvLineTotal);
                        TaxAmout := TotalFooterAmount[1];
                        //MESSAGE('%1 - Tax',TaxAmout);
                        DepAmount := TotalFooterAmount[2];
                        //MESSAGE('%1- Dep',DepAmount);

                        ShippingChargesAmount := TotalFooterAmount[6];
                        //MESSAGE('%1- Shiping',ShippingChargesAmount);
                        MarkupChargesAmount := TotalFooterAmount[5];
                        //MESSAGE('%1 - markup',MarkupChargesAmount);
                        BaseMarginAmt := TotalFooterAmount[7];
                        ProductDisAmnt := TotalFooterAmount[8];//HEI.04
                                                               //MESSAGE('%1 - BaseMargin',BaseMarginAmt);
                                                               //MESSAGE('%1 - VATamnt',VATAmount
                                                               //);

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        if SalesInvLine.findset() then
                            repeat
                                TotalFooterAmount[4] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[4] := 'Line Discount Amount:';
                            until SalesInvLine.NEXT() = 0;

                        LineDisAmount := TotalFooterAmount[4];



                        AmttoPaid := InvLineTotal + VatAmt + TotalFooterAmount[1] + VatAmt + TotalFooterAmount[5] + TotalFooterAmount[6] - VatAmt + TotalFooterAmount[4];
                        InvTotalAmount := AmttoPaid + TotalFooterAmount[2];

                        //Amount in letters
                        Check.InitTextVariable();
                        if "Sales Invoice Header"."Prices Including VAT" then begin
                            Check.FormatNoText(DescriptionLine, ROUND(DepAmount + ROUND(InvLineTotal, 1, '=') + TaxAmout + BaseMarginAmt, 0.01, '='), "Sales Invoice Header"."Currency Code");
                        end else
                            Check.FormatNoText(DescriptionLine, ROUND(InvLineTotal + TaxAmout + VATAmount + DepAmount + ShippingChargesAmount + BaseMarginAmt, 0.01, '='), "Sales Invoice Header"."Currency Code");//HEI.04
                                                                                                                                                                                                                   //Check.FormatNoText(DescriptionLine,ROUND(ROUND(InvLineTotal,1,'=') + TaxAmout + VATAmount + DepAmount + ShippingChargesAmount + MarkupChargesAmount + BaseMarginAmt,0.01,'='),"Sales Invoice Header"."Currency Code");//HEI.04
                        DescriptionLine[1] := COPYSTR(DescriptionLine[1], 6);

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
                TotalGrossWeight := 0;
                TotalNetWeight := 0;

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

                //BC UPGRADE PATHAA02>>
                //CurrReport.LANGUAGE := Language.GetLanguageID(DocLanguage); 
                CurrReport.Language := LanguageG.GetLanguageId(DocLanguage); //GetlanguageId moved from Table to CU.
                //BC UPGRADE PATHAA02<<

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
                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.findset() then
                    repeat
                        VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                        VATAmount := ABS(VatAmt);

                        //split VAT
                        if TEMPAccSchedKPIBuffer.GET(SalesInvLine."VAT %") then begin
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.MODIFY();

                        end else begin
                            TEMPAccSchedKPIBuffer.INIT();
                            TEMPAccSchedKPIBuffer."No." := SalesInvLine."VAT %";
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.INSERT();
                        end;
                    until SalesInvLine.NEXT() = 0;

                TEMPAccSchedKPIBuffer.RESET();
                if TEMPAccSchedKPIBuffer.findset() then
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
        label(lblAmtPaid; ENU = 'Total to be paid:',
                         FRA = 'Total à payer:',
                         ENG = 'Total to be paid:')
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
        label(LblInvoiceCurrLCY; ENU = 'Amount in BIF:',
                                FRA = 'Montant en BIF:',
                                ENG = 'Amount in BIF:')
        label(LblTotalToBePaid; ENU = 'Total invoiced:',
                               FRA = 'Total facturé:',
                               ENG = 'Total invoiced:')
        label(LblDiscTotal; ENU = 'Disc Total:',
                           ENG = 'Disc Total:')
        label(GrossWeightLbl; ENU = 'Gross Weight:',
                             ENG = 'Gross Weight:')
        label(NetWeightLbl; ENU = 'Net Weight:',
                           ENG = 'Net Weight:')
        label(BillOfLadingNoLbl; ENU = 'Bill Of Lading No:',
                                ENG = 'Bill Of Lading No:')
        label(VesselNameLbl; ENU = 'Vessel Name:',
                            ENG = 'Vessel Name:')
        label(ETDLbl; ENU = 'ETD:',
                     ENG = 'ETD:')
        label(ETALbl; ENU = 'ETA:',
                     ENG = 'ETA:')
        label(AirWayBillNoLbl; ENU = 'Air Way Bill No:',
                              ENG = 'Air Way Bill No:')
        label(CommodityCodeLbl; ENU = 'Commodity Code:',
                               ENG = 'Commodity Code:')
        label(CustomTariffCodeLbl; ENU = 'Custom Tariff Code:',
                                  ENG = 'Custom Tariff Code:')
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
        DocSubtypeCodeSetup.GET();//BC UPGRADE SHUKLP03
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture, "OpCo Logo FND");
    end;

    var
        TEMPAccSchedKPIBuffer: Record "Acc. Sched. KPI Buffer";
        CompanyInfo: Record "Company Information";
        BillToCountry: Record "Country/Region";
        Country: Record "Country/Region";
        SoldToCountry: Record "Country/Region";
        CurrExchRate: Record "Currency Exchange Rate";
        BillToCustomer: Record Customer;
        Customer: Record Customer;
        SoldToCustomer: Record Customer;
        CustomerAttributes: Record "Customer Attributes FND";
        GLSetup: Record "General Ledger Setup";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvLineAmt: Record "Sales Invoice Line";
        SalesPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        VATEntry: Record "VAT Entry";
        Check: Report Check;
        //Language: Record Language;//BC UPGRADE PATHAA02
        LanguageG: Codeunit Language;//BC UPGRADE PATHAA02
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
        ProductDisAmnt: Decimal;
        ShipAmount: Decimal;
        ShippingChargesAmount: Decimal;
        TaxAmout: Decimal;
        TotalAmountLCY: Decimal;
        TotalDepositFooterAmount: array[6] of Decimal;
        TotalFooterAmount: array[8] of Decimal;
        TotalGrossWeight: Decimal;
        TotalInvDis: Decimal;
        TotalNetWeight: Decimal;
        TotalQty: Decimal;
        VATAmount: Decimal;
        VatAmt: Decimal;
        VATPer: Decimal;
        Counter: Integer;
        LinesPrinted: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        NUMLines: Integer;
        OutputNo: Integer;
        ItemCharge: Option " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        DisplayTitleHeaderType: Option Confirmation,Proforma;
        CompanyInfoContryName: Text;
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
        FooterSubText: TextConst ENU = 'Site Internet:', ENG = 'Site Internet:';
        InvalidTxt: TextConst ENU = '**INVALID WITHOUT FISCAL OR REFUND RECEIPT ATTACHED**', ENG = '**INVALID WITHOUT FISCAL OR REFUND RECEIPT ATTACHED**';
        Text50001: TextConst ENU = 'Other Taxes:', FRA = 'Autres Taxes:', ENG = 'Other Taxes:';
        Text50002: TextConst ENU = 'Deposit Amount:', FRA = 'Montant Consigné:', ENG = 'Deposit Amount:';
        Text50003: TextConst ENU = 'Shipping Charges:', ENG = 'Shipping Charges:';
        Text50004: TextConst ENU = 'Original', ENG = 'Original';
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND"; //BC UPGRADE SHUKLP03
        Text52000: TextConst ENU = 'Copy', FRA = 'Copie', ENG = 'Copy';
        Text52001: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 HT', ENG = 'Total %1 Excl. VAT';
        Text52002: TextConst ENU = 'Total %1 Incl. VAT', FRA = 'Total %1 TTC', ENG = 'Total %1 Incl. VAT';
        Text52003: TextConst ENU = 'VAT @ %1 ', FRA = 'TVA @ %1', ENG = 'VAT @ %1 ';
        Text52004: TextConst ENU = 'Order Confirmation %1', FRA = 'Confirmation de commande %1', ENG = 'Order Confirmation %1';
        Text52004B: TextConst ENU = 'Proforma Invoice %1', FRA = 'Facture Proforma %1', ENG = 'Proforma Invoice %1';
        Text52005: TextConst ENU = 'Subtotal %1 Excl. VAT:', FRA = 'Sous-total %1 HT', ENG = 'Subtotal %1 Excl. VAT:';
        Text52005B: TextConst ENU = 'Subtotal %1 Incl. VAT:', FRA = 'Sous-total %1 TTC:', ENG = 'Subtotal %1 Incl. VAT:';
        Text52006: TextConst ENU = 'Sales Invoice', FRA = 'Facture de Vente', ENG = 'Sales Invoice', FRE = 'Facture de Vente';
        Text52007: TextConst ENU = 'Export Invoice', ENG = 'Export Invoice';

    local procedure SetExportICInvoice();
    begin
        ICInvoice := false;
        ExportInvoice := false;

        if Customer.GET("Sales Invoice Header"."Bill-to Customer No.") then
            if Customer."Account Group FND" in ['Y005', 'Y006', 'Y008'] then
                ICInvoice := true;
        //BC UPGRADE SHUKLP03 >> (Document Subtype COde)
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
        //BC UPGRADE SHUKLP03 << (Document Subtype COde)
    end;
}

