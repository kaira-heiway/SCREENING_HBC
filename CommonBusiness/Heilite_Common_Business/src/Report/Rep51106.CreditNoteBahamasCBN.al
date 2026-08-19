report 51106 "Credit Note Bahamas CBN"
{

    // HEI.01 CHG2329783-HB4456 IBM ADHIKG01 19.12.2025 Invoice Layout Change for Bahamas
    //   # New report created by referring to the report: 50262 - Credit Note STD
    //   # Increased the font size by 2 points in the report layout

    // BC UPGRADE PATES08 >>
    // # Created new Report
    // # Nav ID : 50624
    // BC UPGRADE PATES08 <<

    ApplicationArea = All;
    CaptionML = ENU = 'Credit Note Bahamas';
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;

    RDLCLayout = '.\src\Reportslayout\CreditNoteBahamas.rdl';

    dataset
    {
        dataitem(SalesCrMemoHeader; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            column(SalesHDocNo; "No.") { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(CompanyInfo_Address2; CompanyInfo."Address 2") { }
            column(CompanyInfoContryName; CompanyInfoContryName) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyInfo_BankAccNo; CompanyInfo."Bank Account No.") { }
            column(CompanyInfo_BankName; CompanyInfo."Bank Name") { }
            column(CompanyInfo_Giro; CompanyInfo."Giro No.") { }
            column(CompanyInfo_Iban; CompanyInfo.IBAN) { }
            column(CompanyInfo_swiftCode; CompanyInfo."SWIFT Code") { }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code") { }
            column(CompanyInfo_City; CompanyInfo.City) { }
            column(OriginalCopy; OriginalCopy) { }
            column(CompanyInfo_OpCoFooterImage; CompanyInfo."OpCo Footer image FND") { }
            column(CompanyText; CompanyText) { }
            column(CompanyFooter1; TextFooter[1]) { }
            column(CompanyFooter2; TextFooter[2]) { }
            column(CompanyFooter3; TextFooter[3]) { }
            column(CurrencyCode; CurrencyCode) { }
            column(CustomerServiceEmail; SalesSetup."Customer Service E-Mail FND") { }

            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number=CONST(1));

                    column(CustomerAttributestext;CustomerAttributestext) { }
                    column(OrderConfirmCopyCaption;DocumentTitleText) { }
                    column(SalesHCustNo;SalesCrMemoHeader."Bill-to Customer No.") { IncludeCaption = true; }
                    column(SalesHPostDate;FORMAT(SalesCrMemoHeader."Posting Date",0,'<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDueDate;FORMAT(SalesCrMemoHeader."Due Date",0,'<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDocDate;FORMAT(SalesCrMemoHeader."Document Date",0,4)) { }
                    column(SalesHIncVAT;PriceIncVAT) { }
                    column(SalesHSalesPerName;SalesPerson.Name) { }
                    column(SalesPersonCode;SalesCrMemoHeader."Salesperson Code") { }
                    column(OutputNo;OutputNo) { }
                    column(SalesHOrdNo;SalesCrMemoHeader."Return Order No.") { }
                    column(SalesHExtRefNo;SalesCrMemoHeader."External Document No.") { }
                    column(SalesHVATRegNo;SalesCrMemoHeader."VAT Registration No.") { IncludeCaption = true; }
                    column(PaymentTermDescrip;PaymentTerms.Description) { }
                    column(PaymentMethodDesc;PaymentMethod.Description) { }
                    column(ShipMethodDescrip;ShipmentMethod.Description) { }
                    column(CustName;CustomerName) { }
                    column(CustAddress;CustomerAddress) { }
                    column(SubTotal;ROUND(InvLineTotal,0.01,'=')) { }
                    column(TotalIncText;TotalInText) { }
                    column(SubTotalExcText;SubTotalExText) { }
                    column(TaxAmount;TaxAmout) { }
                    column(TaxAmtCaption;TotalFooterAmountText[1]) { }
                    column(DepositAmount;DepAmount) { }
                    column(DepositAmtCaption;TotalFooterAmountText[2]) { }
                    column(ShippingAmount;ShipAmount) { }
                    column(ShippingAmtCaption;TotalFooterAmountText[3]) { }
                    column(LineDiscountAmt;LineDisAmount) { }
                    column(LineDiscCaption;TotalFooterAmountText[4]) { }
                    column(AmountPaid;AmttoPaid) { }
                    column(InvTotalAmt;InvTotalAmount) { }
                    column(ShippingChargesAmount;ShippingChargesAmount) { }
                    column(ShippingChargeAmtCaption;TotalFooterAmountText[6]) { }
                    column(MarkupChargeAmtCaption;TotalFooterAmountText[5]) { }
                    column(MarkupChargesAmount;MarkupChargesAmount) { }
                    column(BaseMarginAmt;BaseMarginAmt) { }
                    column(BaseMarginAmtCaption;TotalFooterAmountText[7]) { }
                    column(SplitVatPercent1;SplitVatPercent[1]) { }
                    column(SplitVatPercent2;SplitVatPercent[2]) { }
                    column(SplitVatPercent3;SplitVatPercent[3]) { }
                    column(SplitVatAmount1;SplitVatAmount[1]) { }
                    column(SplitVatAmount2;SplitVatAmount[2]) { }
                    column(SplitVatAmount3;SplitVatAmount[3]) { }
                    column(SalesInvHeader_BillToName;SalesCrMemoHeader."Bill-to Name") { }
                    column(SalesInvHeader_BillToPostCode;SalesCrMemoHeader."Bill-to Post Code") { }
                    column(SalesInvHeader_BillToCity;SalesCrMemoHeader."Bill-to City") { }
                    column(BillToVatRegNo;BillToCustomer."VAT Registration No.") { }
                    column(BillToCountryName;BillToCountry.Name) { }
                    column(SalesInvHeader_SellToName;SalesCrMemoHeader."Sell-to Customer Name") { }
                    column(SalesInvHeader_SellToCity;SalesCrMemoHeader."Sell-to City") { }
                    column(SalesInvHeader_SellToPostCode;SalesCrMemoHeader."Sell-to Post Code") { }
                    column(SellToCountryName;SoldToCountry.Name) { }
                    column(SellToVatRegNo;SoldToCustomer."VAT Registration No.") { }
                    column(SalesInvHeader_BillToAddress;SalesCrMemoHeader."Bill-to Address") { }
                    column(SalesInvHeader_BillToAddress2;SalesCrMemoHeader."Bill-to Address 2") { }
                    column(SalesInvHeader_SellToAddress;SalesCrMemoHeader."Sell-to Address") { }
                    column(SalesInvHeader_SellToAddress2;SalesCrMemoHeader."Sell-to Address 2") { }
                    column(SalesInvHeader_ShipToName;SalesCrMemoHeader."Ship-to Name") { }
                    column(SalesInvHeader_Address;SalesCrMemoHeader."Ship-to Address") { }
                    column(SalesInvHeader_Address2;SalesCrMemoHeader."Ship-to Address 2") { }
                    column(SalesInvHeader_City;SalesCrMemoHeader."Ship-to City") { }
                    column(SellCustomerNo;SalesCrMemoHeader."Sell-to Customer No.") { }
                    column(InvalidTxt;InvalidTxt) { }
                    column(TotalInvDis;TotalInvDis) { }
                    column(TotalAmountLCY;TotalAmountLCY) { }
                    column(ItemChargeDisc;ItemChargeDisc) { }
                    column(InvDisAmount;InvDisAmount) { }
                    dataitem(SalesCrMemoLine;"Sales Cr.Memo Line")
                    {
                        DataItemTableView = SORTING("Document No.","Line No.") WHERE(Type=FILTER(Item|Resource|"Fixed Asset"|"Charge (Item)"));
                        DataItemLinkReference = SalesCrMemoHeader;
                        DataItemLink = "Document No."=FIELD("No.");
                        column(SalesLType;SalesCrMemoLine.Type) { }
                        column(SalesItem;SalesCrMemoLine."No.") { IncludeCaption = true; }
                        column(SalesDescrip;SalesCrMemoLine.Description) { IncludeCaption = true; }
                        column(SalesQty;SalesCrMemoLine.Quantity) { IncludeCaption = true; }
                        column(SalesUOM;SalesCrMemoLine."Unit of Measure Code") { }
                        column(SalesPrice;ROUND(SalesCrMemoLine."Unit Price",0.01,'=')) { }
                        column(SalesVATPer;SalesCrMemoLine."VAT %") { IncludeCaption = true; }
                        column(SalesAmount;SalesCrMemoLine.Quantity*SalesCrMemoLine."Unit Price") { }
                        column(TotalQuantity;TotalQty) { }
                        column(SalesDiscount;SalesCrMemoLine."Line Discount Amount") { }
                        column(SalesPrice1;UnitPrice) { }
                        column(SalesAmount1;LineAmount) { }
                        column(DiscIncluded;DiscIncluded) { }
                        column(SalesDiscount1;var_Dis) { }

                        dataitem(SplitVatAmountDataItem;Integer)
                        {
                            column(TEMPAccSchedKPIBuffer_VatPercent;FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast")) { }
                            column(TEMPAccSchedKPIBuffer_VatAmount;TEMPAccSchedKPIBuffer."Net Change Budget") { }

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(Number,1,TEMPAccSchedKPIBuffer.COUNT);
                            end;

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                IF NOT TEMPAccSchedKPIBuffer.FIND('-') THEN
                                    CurrReport.BREAK;
                                END ELSE
                                IF TEMPAccSchedKPIBuffer.NEXT = 0 THEN
                                    CurrReport.BREAK;
                            end;

                        }

                        trigger OnAfterGetRecord()
                        var
                            SalesInvoiceLine : Record "Sales Cr.Memo Line";
                        begin
                            DiscIncluded := 0;
                            UnitPrice := "Unit Price";
                            LineAmount := "Line Amount";

                            IF Type <> Type::"Charge (Item)" THEN BEGIN
                            //Include in Item Price
                            SalesInvoiceLine.RESET;
                            SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                            SalesInvoiceLine.SETRANGE(Type,SalesInvoiceLine.Type::"Charge (Item)");
                            SalesInvoiceLine.SETRANGE("Attached to Line No.","Line No.");

                            // BC Upgrade PATELS08 >> # Blocked the following code as the field "Item Charge Type" is blocked in Table Ext 50198, DIT FIELD
                            // SalesInvoiceLine.SETRANGE("Item Charge Type",SalesInvoiceLine."Item Charge Type"::Discount);
                            // BC Upgrade PATELS08 <<
                            SalesInvoiceLine.SETRANGE("Show Item charge on Inv. FND", SalesInvoiceLine."Show Item charge on Inv. FND"::"Include in item price");
                            IF SalesInvoiceLine.FINDSET(FALSE) THEN
                                REPEAT
                                IF ItemCh.GET(SalesInvoiceLine."No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN BEGIN
                                    LineAmount += SalesInvoiceLine."Line Amount";
                                    DiscIncluded += SalesInvoiceLine."Line Amount";
                                    IF SalesInvoiceLine.Quantity <> 0 THEN
                                    UnitPrice := LineAmount / ABS(Quantity);
                                END
                                UNTIL SalesInvoiceLine.NEXT=0;
                            END;
                            // BC Upgrade PATELS08 >> # Blocked the following code as the fields "Item Charge Type" and "Show Item charge on Invoice" are blocked in Table Ext 50198, DIT FIELD
                            // ELSE IF ("Item Charge Type" = "Item Charge Type"::Discount) AND
                            // ("Show Item charge on Inv. FND" = "Show Item charge on Inv. FND"::"Include in item price") THEN
                            //     IF ItemCh.GET("No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN
                            //     CurrReport.SKIP;
                            // BC Upgrade PATELS08 <<

                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;

                            TotalInvDis += ABS(SalesCrMemoLine."Line Discount Amount");

                            var_Dis := "Line Discount Amount";
                            // BC Upgrade PATELS08 >> # Blocked the following code as the field "Item Charge Type" is blocked in Table Ext 50198, DIT FIELD
                            // IF (Type = Type::"Charge (Item)") AND ("Item Charge Type" = "Item Charge Type"::Discount) THEN
                            // IF ItemCh.GET("No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN
                            //     var_Dis += "Line Amount";
                            // BC Upgrade PATELS08 <<
                        end;

                    }

                    trigger OnAfterGetRecord()
                    begin
                        CLEAR(TotalFooterAmount);
                        CLEAR(TotalFooterAmountText);
                        CLEAR(InvTotalAmount);
                        CLEAR(AmttoPaid);
                        CLEAR(TotalInvDis);
                        CLEAR(ItemChargeDisc);

                        DocumentTitleText := STRSUBSTNO(Text52006,CopyText);

                        SalesInvLineAmt.RESET;
                        SalesInvLineAmt.SETRANGE("Document No.",SalesCrMemoHeader."No.");

                        // BC Upgrade PATELS08 >> # Blocked the following code as the field "Item Charge Type" is blocked in Table Ext 50198, DIT FIELD
                        // IF SalesInvLineAmt.FINDSET(FALSE) THEN REPEAT
                        // IF (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") OR (SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::" ") THEN
                        //     InvLineTotal += SalesInvLineAmt."Line Amount";
                        // UNTIL SalesInvLineAmt.NEXT=0;
                        // BC Upgrade PATELS08 <<

                        TotalFooterAmountText[1]:= Text50001;
                        TotalFooterAmountText[2]:= Text50002;
                        TotalFooterAmountText[6]:= Text50003;

                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document No.",SalesCrMemoHeader."No.");
                        SalesInvLine.SETRANGE(Type,SalesInvLine.Type::"Charge (Item)");
                        IF SalesInvLine.FINDSET(FALSE) THEN REPEAT
                        // BC Upgrade PATELS08 >> # Blocked the following code as the fields "Item Charge Type" and "Show Item charge on Invoice" are blocked in Table Ext 50198, DIT FIELD
                        // CASE SalesInvLine."Item Charge Type" OF
                        //     SalesInvLine."Item Charge Type"::Tax:
                        //     TotalFooterAmount[1] += SalesInvLine."Line Amount";
                        //     SalesInvLine."Item Charge Type FND"::Deposit:
                        //     TotalFooterAmount[2] += SalesInvLine."Line Amount";
                        //     SalesInvLine."Item Charge Type"::"Shipping Cost":
                        //     TotalFooterAmount[3] += SalesInvLine."Line Amount";
                        //     SalesInvLine."Item Charge Type"::Discount:
                        //     BEGIN
                        //         IF ItemCh.GET(SalesInvLine."No.") AND ItemCh."Transport/Shipping Cost FND" THEN
                        //         TotalFooterAmount[3] += SalesInvLine."Line Amount"
                        //         ELSE
                        //         IF SalesInvLine."Show Item charge on Invoice" <> SalesInvLine."Show Item charge on Invoice"::"Include in item price" THEN
                        //             TotalFooterAmount[4] += SalesInvLine."Line Amount";
                        //     END;
                        // END;
                        // BC Upgrade PATELS08 <<
                        UNTIL SalesInvLine.NEXT=0;

                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        ShipAmount := TotalFooterAmount[3];

                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document No.",SalesCrMemoHeader."No.");
                        IF SalesInvLine.FINDSET(FALSE) THEN REPEAT
                        TotalFooterAmount[4] += ABS(SalesInvLine."Inv. Discount Amount");
                        TotalFooterAmountText[4]:= SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                        TotalFooterAmount[5] += SalesInvLine."Line Discount Amount";
                        TotalFooterAmountText[5]:= SalesInvLine.FIELDCAPTION("Line Discount Amount");
                        UNTIL SalesInvLine.NEXT=0;

                        InvDisAmount := TotalFooterAmount[4];
                        LineDisAmount := TotalFooterAmount[5];

                        AmttoPaid := InvLineTotal + VATAmount + TaxAmout + ShipAmount - InvDisAmount - LineDisAmount;
                        InvTotalAmount := AmttoPaid + DepAmount;
                    end;

                


                }
            
                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies);
                    IF NoOfLoops <= 0 THEN
                    NoOfLoops := 1;

                    CopyText := '';
                    SETRANGE(Number,1,NoOfLoops);
                    OutputNo := 0;
                end;

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
                    CLEAR(ItemChargeDisc);
                end;

                trigger OnPostDataItem()
                begin
                    SalesInvCountPrinted.RUN(SalesCrMemoHeader);
                end;


                    

            }

            trigger OnAfterGetRecord()
            var
                CurrReportID : Integer;
                i : Integer;
                ExtendedTextHeader : Record "Extended Text Header";
                ExtendedTextLine : Record "Extended Text Line";
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
                EVALUATE(CurrReportID,COPYSTR(CurrReport.OBJECTID(FALSE),8));
                StandardTextReport.SETRANGE("Report ID", CurrReportID);
                StandardTextReport.SETRANGE("Position Text",StandardTextReport."Position Text"::Footer);
                IF StandardTextReport.FINDSET(FALSE) THEN
                REPEAT
                    i := 1;
                    ExtendedTextHeader.RESET;
                    ExtendedTextHeader.SETRANGE("Table Name",ExtendedTextHeader."Table Name"::"Standard Text");
                    ExtendedTextHeader.SETRANGE("No.",StandardTextReport."Standard Text Code");
                    IF ExtendedTextHeader.FINDSET(FALSE) THEN BEGIN
                    REPEAT
                        ExtendedTextLine.RESET;
                        ExtendedTextLine.SETRANGE("Table Name",ExtendedTextHeader."Table Name");
                        ExtendedTextLine.SETRANGE("No.",ExtendedTextHeader."No.");
                        ExtendedTextLine.SETRANGE("Text No.",ExtendedTextHeader."Text No.");
                        ExtendedTextLine.SETRANGE("Language Code","Language Code");
                        IF ExtendedTextHeader."All Language Codes" THEN
                        ExtendedTextLine.SETRANGE("Language Code",ExtendedTextHeader."Language Code");
                        IF ExtendedTextLine.FINDSET(FALSE) THEN
                        BEGIN
                            REPEAT
                                TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                            UNTIL (ExtendedTextLine.NEXT = 0) OR (i > ARRAYLEN(TextFooter));
                        END;
                        i += 1;
                    UNTIL (ExtendedTextHeader.NEXT = 0);
                    END;
                UNTIL (StandardTextReport.NEXT = 0);

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
                // BC Upgrade PAELS08 >> # Blocked the following code as the field "Tax Registration No." is blocked in Table Ext 50121, DIT FIELD
                // IF CompanyInfo."Tax Registration No." <> '' THEN
                //     CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                // BC Upgrade PAELS08 <<
                IF CompanyInfo."Phone No." <> '' THEN
                    CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                IF CompanyInfo."Fax No." <> '' THEN
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";

                TEMPAccSchedKPIBuffer.DELETEALL;
                IF Country.GET(CompanyInfo."Country/Region Code") THEN
                    CompanyInfoContryName := Country.Name;

                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");

                IF SalesPerson.GET(SalesCrMemoHeader."Salesperson Code") THEN;

                IF ShipmentMethod.GET(SalesCrMemoHeader."Shipment Method Code") THEN
                    ShipmentMethod.TranslateDescription(ShipmentMethod,SalesCrMemoHeader."Language Code");

                IF PaymentTerms.GET("Payment Terms Code") THEN
                    PaymentTerms.TranslateDescription(PaymentTerms,SalesCrMemoHeader."Language Code");

                PaymentMethod.RESET;
                IF PaymentMethod.GET("Payment Method Code") THEN;

                IF "Currency Code" = '' THEN BEGIN
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
                END;


                CustomerNo :='';
                CustomerName := '';
                CustomerAddress := '';
                IF Customer.GET(SalesCrMemoHeader."Bill-to Customer No.") THEN BEGIN;
                    CustomerNo := "Bill-to Customer No.";

                CustomerName := "Bill-to Name";
                CustomerAddress := "Bill-to City"+', '+"Bill-to Address"+', '+"Bill-to Address 2";
                IF ("Bill-to City" <> '') AND ("Bill-to Address" <> '') AND ("Bill-to Address 2" <> '') THEN
                    CustomerAddress := "Bill-to City"+', '+"Bill-to Address"+', '+"Bill-to Address 2";

                IF ("Bill-to City" = '') AND ("Bill-to Address" <> '') AND ("Bill-to Address 2" <> '') THEN
                    CustomerAddress := "Bill-to Address"+', '+"Bill-to Address 2";
                IF ("Bill-to City" <> '') AND ("Bill-to Address" = '') AND ("Bill-to Address 2" <> '') THEN
                    CustomerAddress := "Bill-to City"+', '+"Bill-to Address 2";
                IF ("Bill-to City" <> '') AND ("Bill-to Address" <> '') AND ("Bill-to Address 2" = '') THEN
                    CustomerAddress := "Bill-to City"+', '+"Bill-to Address";

                IF ("Bill-to City" = '') AND ("Bill-to Address" = '') AND ("Bill-to Address 2" <> '') THEN
                    CustomerAddress := "Bill-to Address 2";
                IF ("Bill-to City" <> '') AND ("Bill-to Address" = '') AND ("Bill-to Address 2" = '') THEN
                    CustomerAddress := "Bill-to City";
                IF ("Bill-to City" = '') AND ("Bill-to Address" <> '') AND ("Bill-to Address 2" = '') THEN
                    CustomerAddress := "Bill-to Address";
                END;

                CLEAR(CustomerAttributestext);
                IF CustomerAttributes.GET(SalesCrMemoHeader."Bill-to Customer No.") THEN
                    BEGIN
                    IF CustomerAttributes."Name 3" <>'' THEN
                    CustomerAttributestext += CustomerAttributes."Name 3"+ '<br/>';
                    IF CustomerAttributes."Name 4" <> '' THEN
                    CustomerAttributestext += CustomerAttributes."Name 4"+ '<br/>';
                    IF CustomerAttributes."Street 3" <>'' THEN
                    CustomerAttributestext += CustomerAttributes."Street 3"+ '<br/>';
                    IF CustomerAttributes."Street 4" <>'' THEN
                    CustomerAttributestext += CustomerAttributes."Street 4"+ '<br/>';
                    IF CustomerAttributes."Street 5" <>'' THEN
                    CustomerAttributestext += CustomerAttributes."Street 5"+ '<br/>';
                    IF CustomerAttributes."House No. 1" <>'' THEN
                    CustomerAttributestext += CustomerAttributes."House No. 1"+ '<br/>';
                    IF CustomerAttributes."House Supplement 2" <>'' THEN
                    CustomerAttributestext += CustomerAttributes."House Supplement 2"+ '<br/>';
                    END;

                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Document No.",SalesCrMemoHeader."No.");
                SalesInvLine.SETFILTER("VAT %",'<>%1',0);
                IF SalesInvLine.FINDFIRST THEN
                VATPer := SalesInvLine."VAT %";

                IF SalesCrMemoHeader."Prices Including VAT" = TRUE THEN
                PriceIncVAT := 'Yes'
                ELSE
                PriceIncVAT := 'No';

                VatAmt := 0;
                lineNumberVAT := 0;
                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Document No.",SalesCrMemoHeader."No.");
                SalesInvLine.SETFILTER("VAT %",'<>%1',0);
                IF SalesInvLine.FINDSET(FALSE) THEN
                REPEAT
                    VatAmt += (SalesInvLine."VAT Base Amount"* SalesInvLine."VAT %")/100;
                    VATAmount := ABS(VatAmt);

                    TEMPAccSchedKPIBuffer.RESET;
                    TEMPAccSchedKPIBuffer.SETRANGE("Balance at Date Forecast", SalesInvLine."VAT %");
                    IF TEMPAccSchedKPIBuffer.FINDFIRST THEN BEGIN
                    TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %")/100;
                    TEMPAccSchedKPIBuffer.MODIFY;

                    END ELSE BEGIN
                    lineNumberVAT += 1;
                    TEMPAccSchedKPIBuffer.INIT;
                    TEMPAccSchedKPIBuffer."No." := lineNumberVAT;
                    TEMPAccSchedKPIBuffer."Balance at Date Forecast" := SalesInvLine."VAT %";
                    TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount"* SalesInvLine."VAT %")/100;
                    TEMPAccSchedKPIBuffer.INSERT;
                    END;
                UNTIL SalesInvLine.NEXT = 0;

                TEMPAccSchedKPIBuffer.RESET;
                IF TEMPAccSchedKPIBuffer.FINDSET(FALSE) THEN
                REPEAT
                    Counter +=1;
                    SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%';
                    SplitVatAmount[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Net Change Budget",0,'<Sign><Integer Thousand><Decimals,3>');
                UNTIL TEMPAccSchedKPIBuffer.NEXT = 0;

                BillToCustomer.GET(SalesCrMemoHeader."Bill-to Customer No.");
                SoldToCustomer.GET(SalesCrMemoHeader."Sell-to Customer No.");
                IF BillToCountry.GET(BillToCustomer."Country/Region Code") THEN;
                IF SoldToCountry.GET(SoldToCustomer."Country/Region Code") THEN;

                IF SalesCrMemoHeader."No. Printed" = 0 THEN
                    OriginalCopy := Text50004
                ELSE
                    OriginalCopy := Text52000;

                SalesCrMemoHeader.CALCFIELDS("Amount Including VAT");
                TotalAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(TODAY,SalesCrMemoHeader."Currency Code",SalesCrMemoHeader."Amount Including VAT",CurrExchRate.ExchangeRate(TODAY,SalesCrMemoHeader."Currency Code"));
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
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("No. of Copies"; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        SalesSetup.GET;
    end;
    trigger OnPreReport()
    begin

        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture,"OpCo Footer image FND");
    end;

    

    var
        CompanyInfo : Record "Company Information";
        Country : Record "Country/Region";
        VATEntry : Record "VAT Entry";
        LanguageG : Record "Language";
        GLSetup : Record "General Ledger Setup";
        SalesSetup : Record "Sales & Receivables Setup";
        ShipmentMethod : Record "Shipment Method";
        PaymentTerms : Record "Payment Terms";
        Customer : Record "Customer";
        SalesPerson : Record "Salesperson/Purchaser";
        SalesInvLine : Record "Sales Cr.Memo Line";
        SalesInvLineAmt : Record "Sales Cr.Memo Line";
        TempVATAmountLine : Record "VAT Amount Line" temporary;
        SalesInvCountPrinted : Codeunit "Sales Cr. Memo-Printed";
        NoOfLoops : Integer;
        NoOfCopies : Integer;
        OutputNo : Integer;
        NUMLines : Integer;
        InvLineTotal : Decimal;
        VatAmt : Decimal;
        VATPer : Decimal;
        AmttoPaid : Decimal;
        InvTotalAmount : Decimal;
        ItemCharge : Option  ,Tax,Deposit,Discount,Promotion,,ShippingCost;
        PriceIncVAT : Text[10];
        CopyText : Text[10];
        TotalInText : Text[30];
        TotalExText : Text[30];
        SubTotalInText : Text[30];
        SubTotalExText : Text[30];
        VATPerText : Text[30];
        LinesPrinted : Integer;
        TotalQty : Decimal;
        TotalFooterAmount : array[10] of Decimal;
        TotalFooterAmountText : array[7] of Text[50];
        CustomerNo : Code[20];
        CustomerName : Text[50];
        CustomerAddress : Text[240];
        TotalDepositFooterAmountText : array[6] of Text[50];
        TotalDepositFooterAmount : array[6] of Decimal;
        DisplayTitleHeaderType : Option Confirmation,Proforma;
        DocumentTitleText : Text[30];
        TaxAmout : Decimal;
        VATAmount : Decimal;
        DepAmount : Decimal;
        ShipAmount : Decimal;
        LineDisAmount : Decimal;
        ShippingChargesAmount : Decimal;
        MarkupChargesAmount : Decimal;
        CustomerAttributes : Record "Customer Attributes FND";
        CustomerAttributestext : Text[1024];
        BaseMarginAmt : Decimal;
        TEMPAccSchedKPIBuffer : Record "Acc. Sched. KPI Buffer";
        CompanyInfoContryName : Text;
        SplitVatPercent : array[10] of Text;
        SplitVatAmount : array[10] of Text;
        Counter : Integer;
        BillToCustomer : Record "Customer";
        SoldToCustomer : Record "Customer";
        BillToCountry : Record "Country/Region";
        SoldToCountry : Record "Country/Region";
        PaymentMethod : Record "Payment Method";
        TotalInvDis : Decimal;
        OriginalCopy : Text;
        TotalAmountLCY : Decimal;
        CurrExchRate : Record "Currency Exchange Rate";
        CompanyText : Text;
        CountryInfo : Record "Country/Region";
        lineNumberVAT : Integer;
        ItemChargeDisc : Decimal;
        InvDisAmount : Decimal;
        UnitPrice : Decimal;
        LineAmount : Decimal;
        DiscIncluded : Decimal;
        var_Dis : Decimal;
        StandardTextReport : Record "Standard Text Report FND";
        TextFooter : array[3] of Text;
        CurrencyCode : Code[10];
        ItemCh : Record "Item Charge";
        Text52000 : Label 'Copy';
        Text52001 : Label 'Total %1 Excl. VAT';
        Text52002 : Label 'Total %1 Incl. VAT';
        Text52003 : Label 'VAT @ %1 ';
        Text52004 : Label 'Order Confirmation %1';
        Text52004B : Label 'Proforma Invoice %1';
        Text52005 : Label 'Subtotal %1 Excl. VAT:';
        Text52005B : Label 'Subtotal %1 Incl. VAT:';
        Text52006 : Label 'Credit Note';
        Text52007 : Label 'Sundry Invoice';
        EBMSDCInformationLbl : Label 'SDC Information';
        EBMDateLbl : Label 'Date';
        EBMSDCIDLbl : Label 'SDC ID';
        EBMSDCReceiptNumberLbl : Label 'SDC Receipt Number';
        EBMInvoiceNumberLbl : Label 'Invoice Number';
        EBMInternalDateLbl : Label 'Internal Data';
        EBMReceiptSignatureLbl : Label 'Receipt Signature';
        EBMDateTimeOfPrintingLbl : Label 'Date Time of Printing';
        EBMMRCLbl : Label 'MRC';
        EBMNotReceivedErr : Label 'You cannot print %1 %2 because EBM details are not received.';
        InvalidTxt : Label '**INVALID WITHOUT FISCAL OR REFUND RECEIPT ATTACHED**';
        Text50001 : Label 'Excise Duties:';
        Text50002 : Label 'Deposit Amount:';
        Text50003 : Label 'Shipping Charges:';
        Text50004 : Label 'Original';
        TaxNoID : Label 'Tax Number ID:';
        ChOfComm : Label 'Chamber of commerce:';
        ContactNo : Label 'Contact Number:';
        FaxNo : Label 'Fax Number:';
        EmailComp : Label 'E-mail:';


}
