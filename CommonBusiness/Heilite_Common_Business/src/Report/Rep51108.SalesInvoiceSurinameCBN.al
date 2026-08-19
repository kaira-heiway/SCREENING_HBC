
report 51108 "Sales Invoice Suriname CBN"
{
    // HEI.01 CHG2293829 IBM ADHIKG01 30.04.2025 Add the telephone number of the customers on the invoices
    //   # New report created by referring to the report: 50265 - Sales Invoice STD
    //   # New column "Phone No." added to the report layout
    
    // BC Upgrade PATELS08 >>
    // # Object Created
    // # Nav ID : 50617
    // BC Upgrade PATELS08 <<

    ApplicationArea = All;
    Caption = 'Sales Invoice Suriname';
    UsageCategory = ReportsAndAnalysis;

    PaperSourceFirstPage = TractorFeed;
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;

    RDLCLayout = '.\src\Reportslayout\SalesInvoiceSuriname.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            DataItemTableView = Sorting("No.");
            column(SalesHDocNo; "No.") { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(CompanyInfo_Address2; CompanyInfo."Address 2") { }
            column(Customer_PhoneNo; Customer."Phone No.") { }
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
            column(DepositOnTheNetPrice; GeneralOpCoSetup."Deposit% on the net price") { }
            column(ExportInvoice; ExportInvoice) { }
            column(CompanyInfo_OpCoFooter; CompanyInfo."OpCo Footer image FND") { }
            column(CompanyText; CompanyText) { }
            column(CompanyInfo_BankName2; CompanyInfo."Bank Name 2 FND") { }
            column(CompanyInfo_BankAcc2; CompanyInfo."Bank Account No. 2 FND") { }
            column(CompanyInfo_IBAN2; CompanyInfo."IBAN 2 FND") { }
            column(CompanyInfo_Swift2; CompanyInfo."SWIFT Code 2 FND") { }
            column(GeneralOpCoSetup_BankName3; GeneralOpCoSetup."Bank Name 3") { }
            column(GeneralOpCoSetup_BankAcc3; GeneralOpCoSetup."Bank Account No. 3") { }
            column(GeneralOpCoSetup_IBAN3; GeneralOpCoSetup."IBAN 3") { }
            column(GeneralOpCoSetup_Swift3; GeneralOpCoSetup."SWIFT Code 3") { }
            column(GeneralOpCoSetup_InvoiceType3; GeneralOpCoSetup."Report Invoice Type 3") { }
            column(Show_BankDetails3;
                (GeneralOpCoSetup."Report Invoice Type 3" =
                GeneralOpCoSetup."Report Invoice Type 3"::Invoice) and
                (GeneralOpCoSetup."Bank Account No. 3" <> '')) { }

            column(GeneralOpCoSetup_BankName4; GeneralOpCoSetup."Bank Name 4") { }

            column(GeneralOpCoSetup_BankAcc4; GeneralOpCoSetup."Bank Account No. 4") { }

            column(GeneralOpCoSetup_IBAN4; GeneralOpCoSetup."IBAN 4") { }

            column(GeneralOpCoSetup_Swift4; GeneralOpCoSetup."SWIFT Code 4") { }

            column(GeneralOpCoSetup_InvoiceType4; GeneralOpCoSetup."Report Invoice Type 4") { }

            column(Show_BankDetails4;
                (GeneralOpCoSetup."Report Invoice Type 4" =
                GeneralOpCoSetup."Report Invoice Type 4"::Invoice) and
                (GeneralOpCoSetup."Bank Account No. 4" <> '')) { }

            column(CompanyFooter1; TextFooter[1]) { }

            column(CompanyFooter2; TextFooter[2]) { }

            column(CompanyFooter3; TextFooter[3]) { }

            column(CurrencyCode; CurrencyCode) { }

            column(CustomerServiceEmail; SalesSetup."Customer Service E-Mail FND") { }

            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = Sorting(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number=CONST(1));
                    column(CustomerAttributestext; CustomerAttributestext) { }
                    column(OrderConfirmCopyCaption; DocumentTitleText) { }
                    column(SalesHCustNo; "Sales Invoice Header"."Bill-to Customer No.") { IncludeCaption = true; }
                    column(SalesHPostDate; Format("Sales Invoice Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDueDate; Format("Sales Invoice Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDocDate; Format("Sales Invoice Header"."Document Date", 0, 4)) { }
                    column(SalesHIncVAT; PriceIncVAT) { }
                    column(SalesHSalesPerName; SalesPerson.Name) { }
                    column(SalesPersonCode; "Sales Invoice Header"."Salesperson Code") { }
                    column(OutputNo; OutputNo) { }
                    column(SalesHOrdNo; "Sales Invoice Header"."Order No.") { }
                    column(SalesHReference; "Sales Invoice Header"."Your Reference") { }
                    column(SalesHExtRefNo; "Sales Invoice Header"."External Document No.") { }
                    column(SalesHVATRegNo; "Sales Invoice Header"."VAT Registration No."){ IncludeCaption = true; }
                    column(PaymentTermDescrip; PaymentTerms.Description) { }
                    column(PaymentMethodDesc; PaymentMethod.Description) { }
                    column(ShipMethodDescrip; ShipmentMethod.Description) { }
                    column(CustName; CustomerName) { }
                    column(CustAddress; CustomerAddress) { }
                    column(SubTotal; Round(InvLineTotal, 0.01, '=')) { }
                    column(VATAmount; VATAmount) { }
                    column(TotalIncText; TotalInText) { }
                    column(SubTotalExcText; SubTotalExText) { }
                    column(TaxAmount; TaxAmout) { }
                    column(TaxAmtCaption; TotalFooterAmountText[1]) { }
                    column(DepositAmount; DepAmount) { }
                    column(DepositAmtCaption; TotalFooterAmountText[2]) { }
                    column(ShippingAmount; ShipAmount) { }
                    column(ShippingAmtCaption; TotalFooterAmountText[3]) { }
                    column(LineDiscountAmt; LineDisAmount) { }
                    column(LineDiscCaption; TotalFooterAmountText[4]) { }
                    column(AmountPaid; AmttoPaid) { }
                    column(InvTotalAmt; InvTotalAmount) { }
                    column(ShippingChargesAmount; ShippingChargesAmount) { }
                    column(ShippingChargeAmtCaption; TotalFooterAmountText[6]) { }
                    column(MarkupChargeAmtCaption; TotalFooterAmountText[5]) { }
                    column(MarkupChargesAmount; MarkupChargesAmount) { }
                    column(BaseMarginAmt; BaseMarginAmt) { }
                    column(BaseMarginAmtCaption; TotalFooterAmountText[7]) { }
                    column(SplitVatPercent1; SplitVatPercent[1]) { }
                    column(SplitVatPercent2; SplitVatPercent[2]) { }
                    column(SplitVatPercent3; SplitVatPercent[3]) { }
                    column(SplitVatAmount1; SplitVatAmount[1]) { }
                    column(SplitVatAmount2; SplitVatAmount[2]) { }
                    column(SplitVatAmount3; SplitVatAmount[3]) { }
                    column(SalesInvHeader_BillToName; "Sales Invoice Header"."Bill-to Name") { }
                    column(SalesInvHeader_BillToPostCode; "Sales Invoice Header"."Bill-to Post Code") { }
                    column(SalesInvHeader_BillToCity; "Sales Invoice Header"."Bill-to City") { }
                    column(BillToVatRegNo; BillToCustomer."VAT Registration No.") { }
                    column(BillToCountryName; BillToCountry.Name) { }
                    column(SalesInvHeader_SellToName; "Sales Invoice Header"."Sell-to Customer Name") { }
                    column(SalesInvHeader_SellToCity; "Sales Invoice Header"."Sell-to City") { }
                    column(SalesInvHeader_SellToPostCode; "Sales Invoice Header"."Sell-to Post Code") { }
                    column(SellToCustomer_PhoneNo; SoldToCustomer."Phone No.") { }
                    column(SellToCountryName; SoldToCountry.Name) { }
                    column(SellToVatRegNo; SoldToCustomer."VAT Registration No.") { }
                    column(SalesInvHeader_BillToAddress; "Sales Invoice Header"."Bill-to Address") { }
                    column(SalesInvHeader_BillToAddress2; "Sales Invoice Header"."Bill-to Address 2") { }
                    column(SalesInvHeader_SellToAddress; "Sales Invoice Header"."Sell-to Address") { }
                    column(SalesInvHeader_SellToAddress2; "Sales Invoice Header"."Sell-to Address 2") { }
                    column(SalesInvHeader_ShipToName; "Sales Invoice Header"."Ship-to Name") { }
                    column(SalesInvHeader_Address; "Sales Invoice Header"."Ship-to Address") { }
                    column(SalesInvHeader_Address2; "Sales Invoice Header"."Ship-to Address 2") { }
                    column(SalesInvHeader_City; "Sales Invoice Header"."Ship-to City") { }
                    column(SellCustomerNo; "Sales Invoice Header"."Sell-to Customer No.") { }
                    column(InvalidTxt; InvalidTxt) { }
                    column(TotalAmountLCY; TotalAmountLCY) { }
                    column(InCoTerms; "Sales Invoice Header"."InCo Terms FND") { }
                    column(SubTotalCharges; SubTotalCharges) { }
                    column(BillOfLadingNo; "Sales Invoice Header"."Bill Of Lading No. FND") { }
                    column(VesselName; "Sales Invoice Header"."Vessel Name FND") { }
                    column(ETD; "Sales Invoice Header"."ETD FND") { }
                    column(ETA; "Sales Invoice Header"."ETA FND") { }
                    column(AirWayBillNo; "Sales Invoice Header"."Air Way Bill No FND" ) { }
                    column(CommodityCode; "Sales Invoice Header"."Commodity Code FND") { }
                    column(CustomTariffCode; "Sales Invoice Header"."Custom Tariff Code FND") { }
                    column(TotalGrossWeight; TotalGrossWeight) { }
                    column(TotalNetWeight; TotalNetWeight) { }
                    column(InvDisAmount; InvDisAmount) { }

                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemTableView = SORTING("Document No.","Line No.") WHERE(Type=FILTER(Item|Resource|"Fixed Asset"|"Charge (Item)"));
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemLink = "Document No."=FIELD("No.");
                        column(type; Var_typechargeItem) { }
                        column(itemDeposit; itemDeposit) { }
                        column(IsDisount; IsDiscount) { }
                        column(SalesLineNo; "Line No.") { }
                        column(IsDeposit; IsDeposit) { }
                        column(IsNotUnderitem; IsNotUnderitem) { }
                        column(SalesLType; Type) { }
                        column(SalesItem; "No.") { IncludeCaption = true; }
                        column(SalesDescrip; Description) { IncludeCaption = true; }
                        column(SalesQty; Quantity) { IncludeCaption = true; }
                        column(SalesUOM; "Unit of Measure Code") { }
                        column(SalesPrice; UnitPrice) { }
                        column(SalesVATPer; "VAT %") { IncludeCaption = true; }
                        column(SalesAmount; LineAmount) { }
                        column(TotalQuantity; TotalQty) { }
                        column(SalesDiscount; ItemDiscount) { }
                        column(SalesDiscount1; var_Dis) { }
                        column(TotalInvDis; TotalInvDis + ItemDiscount) { }
                        column(PrintUnderLineCharge; PrintUnderLineCharge) { }
                        column(DiscIncluded; DiscIncluded) { }

                        dataitem(UnderLineCharges; Integer)
                        {
                            column(No_TempUnderChargeLine; TempUnderChargeLine."No.") { IncludeCaption = true; }
                            column(Description_TempUnderChargeLine; TempUnderChargeLine.Description) { IncludeCaption = true; }
                            column(Quantity_TempUnderChargeLine; TempUnderChargeLine.Quantity) { IncludeCaption = true; }
                            column(UnitPrice_TempUnderChargeLine; TempUnderChargeLine."Unit Price") { }
                            column(VATIdentifier_TempUnderChargeLine; TempUnderChargeLine."VAT Identifier") { }
                            column(LineAmount_TempUnderChargeLine; TempUnderChargeLine."Line Amount") { }

                            trigger OnPreDataItem()
                            begin
                                TempUnderChargeLine.RESET;
                                TempUnderChargeLine.SETRANGE("Attached to Line No.","Sales Invoice Line"."Line No.");
                                SETRANGE(Number,1,TempUnderChargeLine.COUNT);
                            end;

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

                        }


                        trigger OnAfterGetRecord()
                        var
                            OrderChargeLine : Record "Sales Invoice Line";
                            SalesChargeLine : Record "Sales Invoice Line";
                            SalesInvoiceLine : Record "Sales Invoice Line";
                        begin
                            IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item THEN BEGIN
                                // BC UPGRADE PATELS08 >> # "Weight" DIT FIELD
                                // TotalGrossWeight += "Sales Invoice Line".Weight;
                                // BC UPGRADE PATELS08 <<
                                TotalNetWeight += "Sales Invoice Line"."Net Weight";
                            END;
                            DiscIncluded := 0;
                            UnitPrice := "Unit Price";
                            LineAmount := "Line Amount";

                            IF Type <> Type::"Charge (Item)" THEN BEGIN
                            //Include in Item Price

                            SalesInvoiceLine.RESET;
                            SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                            SalesInvoiceLine.SETRANGE(Type,SalesInvoiceLine.Type::"Charge (Item)");
                            SalesInvoiceLine.SETRANGE("Attached to Line No.","Line No.");
                            // BC UPGRADE PATELS08 >> # "Item Charge Type" DIT FIELD
                            // SalesInvoiceLine.SETRANGE("Item Charge Type",SalesInvoiceLine."Item Charge Type"::Discount);
                            // BC UPGRADE PATELS08 <<
                            SalesInvoiceLine.SETRANGE("Show Item charge on Inv. FND", SalesInvoiceLine."Show Item charge on Inv. FND"::"Include in item price");
                            IF SalesInvoiceLine.FINDSET(FALSE) THEN
                                REPEAT
                                IF ItemCh.GET(SalesInvoiceLine."No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN BEGIN
                                    LineAmount += SalesInvoiceLine."Line Amount";
                                    DiscIncluded += SalesInvoiceLine."Line Amount";
                                    IF SalesInvoiceLine.Quantity <> 0 THEN
                                    UnitPrice := LineAmount / ABS(Quantity);
                                END;
                                UNTIL SalesInvoiceLine.NEXT=0;
                            END;
                            // BC UPGRADE PATELS08 >> # "Item Charge Type" DIT FIELD 
                            // ELSE IF ("Sales Invoice Line"."Item Charge Type" = "Sales Invoice Line"."Item Charge Type"::Discount) AND
                            // ("Show Item charge on Inv. FND" = "Show Item charge on Inv. FND"::"Include in item price") THEN
                            //     IF ItemCh.GET("No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN
                            //     CurrReport.SKIP;
                            // BC UPGRADE PATELS08 <<

                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;
                            ItemDiscount := 0;
                            itemDeposit := 0;
                            // BC UPGRADE PATELS08 >> # "Free Item" DIT FIELD
                            // IF NOT "Sales Invoice Line"."Free Item" THEN
                            //     TotalInvDis := "Sales Invoice Line"."Line Discount Amount";
                            // BC UPGRADE PATELS08 <<

                            var_Dis := "Line Discount Amount";
                            // BC UPGRADE PATELS08 >> # "Item Charge Type" DIT FIELD
                            // IF (Type = Type::"Charge (Item)") AND ("Item Charge Type" = "Item Charge Type"::Discount) THEN
                            // IF ItemCh.GET("No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN
                            //     var_Dis += ABS("Line Amount");
                            // BC UPGRADE PATELS08 <<
                        end;
                    }

                    dataitem(SplitVatAmt; Integer)
                    {
                        column(TEMPAccSchedKPIBuffer_VatPercent;
                            Format(TEMPAccSchedKPIBuffer."Balance at Date Forecast")) { }

                        column(TEMPAccSchedKPIBuffer_VatAmount;
                            TEMPAccSchedKPIBuffer."Net Change Budget") { }

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
                    begin
                        CLEAR(TotalFooterAmount);
                        CLEAR(TotalFooterAmountText);
                        CLEAR(InvTotalAmount);
                        CLEAR(AmttoPaid);
                        CLEAR(TotalInvDis);
                        CLEAR(InvLineTotal);
                        IF NOT ExportInvoice THEN
                        DocumentTitleText := STRSUBSTNO(Text52006,CopyText)
                        ELSE
                        DocumentTitleText := STRSUBSTNO(Text52008,CopyText);

                        SalesInvLineAmt.RESET;
                        SalesInvLineAmt.SETRANGE("Document No.","Sales Invoice Header"."No.");
                        IF SalesInvLineAmt.FINDSET(FALSE) THEN REPEAT
                        // BC UPGRADE PATELS08 >> "Item Charge Type" DIT FIELD
                        // IF (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") OR (SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::" ") THEN
                        //     InvLineTotal += SalesInvLineAmt."Line Amount";
                        // BC UPGRADE PATELS08 <<
                        UNTIL SalesInvLineAmt.NEXT=0;

                        TotalFooterAmountText[1]:= Text50001;
                        TotalFooterAmountText[2]:= Text50002;
                        TotalFooterAmountText[6]:= Text50003;

                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document No.","Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type,SalesInvLine.Type::"Charge (Item)");
                        IF SalesInvLine.FINDSET(FALSE) THEN REPEAT
                        // BC UPGRADE PATELS08 >> # "Item Charge Type" DIT FIELD
                        // CASE SalesInvLine."Item Charge Type" OF
                        //     SalesInvLine."Item Charge Type"::Tax:
                        //     TotalFooterAmount[1] += SalesInvLine."Line Amount";
                        //     SalesInvLine."Item Charge Type"::Deposit:
                        //     TotalFooterAmount[2] += SalesInvLine."Line Amount";
                        //     SalesInvLine."Item Charge Type"::"Shipping Cost":
                        //     TotalFooterAmount[3] += SalesInvLine."Line Amount";
                        //     SalesInvLine."Item Charge Type"::Discount:
                        //     BEGIN
                        //         IF ItemCh.GET(SalesInvLine."No.") AND ItemCh."Transport/Shipping Cost FND" THEN
                        //         TotalFooterAmount[3] += SalesInvLine."Line Amount"
                        //         ELSE
                        //         IF SalesInvLine."Show Item charge on Inv. FND" <> SalesInvLine."Show Item charge on Inv. FND"::"Include in item price" THEN
                        //             TotalFooterAmount[4] += SalesInvLine."Line Amount";
                        //     END;
                        // END;
                        // BC UPGRADE PATELS08 <<
                        UNTIL SalesInvLine.NEXT=0;

                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        ShipAmount := TotalFooterAmount[3];

                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document No.","Sales Invoice Header"."No.");
                        IF SalesInvLine.FINDSET(FALSE) THEN
                        REPEAT
                        TotalFooterAmount[4] += ABS(SalesInvLine."Inv. Discount Amount");
                        TotalFooterAmountText[4]:= SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                        TotalFooterAmount[5] += ABS(SalesInvLine."Line Discount Amount");
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
                end;

                trigger OnPostDataItem()
                begin
                    SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;
            }

            trigger OnAfterGetRecord()
            var
                CurrReportID : Integer;
                i : Integer;
                ExtendedTextHeader : Record	"Extended Text Header";
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
                // BC UPGRADE PATELS08 >> # "Tax Registration No." table DIT Table
                // IF CompanyInfo."Tax Registration No." <> '' THEN
                // CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                // BC UPGRADE PATELS08 <<
                IF CompanyInfo."Phone No." <> '' THEN
                CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                IF CompanyInfo."Fax No." <> '' THEN
                CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";

                IF "Sales Invoice Header"."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" THEN
                ExportInvoice := TRUE
                ELSE
                ExportInvoice := FALSE;

                // BC UPGRADE PATELS08 >> # DocSubtypeCodeSetup table DIT Table
                // IF "Sales Invoice Header"."Document Subtype Code FND" IN [DocSubtypeCodeSetup."Sundry Sales Order Non Stock",DocSubtypeCodeSetup."Sundry Sales Order Stock"] THEN
                // ExportInvoice := FALSE;
                // BC UPGRADE PATELS08 <<

                TotalGrossWeight := 0;
                TotalNetWeight := 0;

                TEMPAccSchedKPIBuffer.DELETEALL;
                IF Country.GET(CompanyInfo."Country/Region Code") THEN
                CompanyInfoContryName := Country.Name;

                CurrReport.LANGUAGE := LanguageG.GetLanguageID("Language Code");

                IF SalesPerson.GET("Sales Invoice Header"."Salesperson Code") THEN;

                IF ShipmentMethod.GET("Sales Invoice Header"."Shipment Method Code") THEN
                ShipmentMethod.TranslateDescription(ShipmentMethod,"Sales Invoice Header"."Language Code");

                IF PaymentTerms.GET("Payment Terms Code") THEN
                PaymentTerms.TranslateDescription(PaymentTerms,"Sales Invoice Header"."Language Code");

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
                IF Customer.GET("Sales Invoice Header"."Bill-to Customer No.") THEN BEGIN;
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
                IF CustomerAttributes.GET("Sales Invoice Header"."Bill-to Customer No.") THEN
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
                SalesInvLine.SETRANGE("Document No.","Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %",'<>%1',0);
                IF SalesInvLine.FINDFIRST THEN
                VATPer := SalesInvLine."VAT %";

                IF "Sales Invoice Header"."Prices Including VAT" = TRUE THEN
                PriceIncVAT := 'Yes'
                ELSE
                PriceIncVAT := 'No';

                VatAmt := 0;
                lineNumberVAT := 0;
                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Document No.","Sales Invoice Header"."No.");
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

                BillToCustomer.GET("Sales Invoice Header"."Bill-to Customer No.");
                SoldToCustomer.GET("Sales Invoice Header"."Sell-to Customer No.");
                IF BillToCountry.GET(BillToCustomer."Country/Region Code") THEN;
                IF SoldToCountry.GET(SoldToCustomer."Country/Region Code") THEN;

                IF "Sales Invoice Header"."No. Printed" = 0 THEN
                OriginalCopy := Text50004
                ELSE
                OriginalCopy := Text52000;

                "Sales Invoice Header".CALCFIELDS("Amount Including VAT");
                TotalAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(TODAY,"Sales Invoice Header"."Currency Code","Sales Invoice Header"."Amount Including VAT",CurrExchRate.ExchangeRate(TODAY,"Sales Invoice Header"."Currency Code"));
            end ;   

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
        CompanyInfo.CALCFIELDS(Picture,"OpCo Footer image FND" );
        GeneralOpCoSetup.GET;
        // BC UPGRADE PATELS08 >> # DocSubtypeCodeSetup table DIT Table
        // DocSubtypeCodeSetup.GET;
        // BC UPGRADE PATELS08 <<
    end;

    var
        var_Dis: Decimal;
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        VATEntry: Record "Area";
        LanguageG: Record Language;
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
        ItemCharge: Option  ,Tax,Deposit,Discount,Promotion,,ShippingCost;
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
        // DocSubtypeCodeSetup: Record "Document Subtype Code Setup"; // DIT
        CompanyText: Text;
        CountryInfo: Record "Country/Region";
        lineNumberVAT: Integer;
        InvDisAmount: Decimal;
        UnitPrice: Decimal;
        LineAmount: Decimal;
        DiscIncluded: Decimal;
        StandardTextReport: Record "Standard Text Report FND";
        TextFooter: array[3] of Text;
        CurrencyCode: Code[10];
        ItemCh: Record "Item Charge";	
        Text52000: Label 'Copy';
        Text52001: Label 'Total %1 Excl. VAT';
        Text52002: Label 'Total %1 Incl. VAT';
        Text52003: Label 'VAT @ %1';
        Text52004: Label 'Order Confirmation %1';
        Text52004B: Label 'Proforma Invoice %1';
        Text52005: Label 'Subtotal %1 Excl. VAT:';
        Text52005B: Label 'Subtotal %1 Incl. VAT:';
        Text52006: Label 'Sales Invoice';
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
        InvalidTxt: Label '**INVALID WITHOUT FISCAL OR REFUND RECEIPT ATTACHED**';
        Text50001: Label 'Excise Duties:';
        Text50002: Label 'Deposit Amount:';
        Text50003: Label 'Shipping Charges:';
        Text50004: Label 'Original';
        TaxNoID: Label 'Tax Number ID:';
        ChOfComm: Label 'Chamber of commerce:';
        ContactNo: Label 'Contact Number:';
        FaxNo: Label 'Fax Number:';
        EmailComp: Label 'E-mail:';
}
