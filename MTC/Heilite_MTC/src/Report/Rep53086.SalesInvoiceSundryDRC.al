report 53086 "Sales Invoice - Sundry DRC"
{
    // version HEI.01

    // HEI.01 CHG2055075 HT1156 GAVANM01 05.05.2020 - New report created
    // HEI.02 CHG2055075 HT1156 POENAB02 09.07.2020 - Added "OpCo Footer image" in the layout
    // HEI.03 CHG2055075 HT1156 Defect #5681 GAVANM01 30.07.2020 - .....
    // HEI.04 CHG2085619 IBM GAVANM01 03.11.2020 - Defect #6013
    //   # changes in DataItemTable Sales Invoice Line - G/L Account added in Type filter
    // HEI.05 CHG2085435 IBM GAVANM01 25.11.2020 - HT1773 Sales documents layout
    //   # layout changes
    //   # global variables added: BankAccNo, BankName, IBAN, SwiftCode
    //   # code changes to set the above variables
    //   # if all item charges of type FPI, Excise Duties, Consumption Tax or Incl. In Transport Cost are marked as Hide Item charge on printout, then
    //     they will be hide in the Totals sections

    // BC Upgrade KUMARS145 Nav ID Report 50435 "Sales Invoice - Sundry DRC"

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Sales Invoice - Sundry DRC.rdl';
    CaptionML = ENU = 'Sales Invoice - Sundry DRC', FRA = 'Facture divers DRC';
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
            column(SalesHDocNo; "Sales Invoice Header"."No.") { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(CompanyInfo_Address2; CompanyInfo."Address 2") { }
            column(CompanyInfoContryName; CompanyInfoContryName) { }
            column(CompanyInfo_Picture; CompanyInfo."OpCo Logo FND") { }
            column(CompanyInfo_BankAccNo; CompanyInfo."Bank Account No.") { }
            column(CompanyInfo_BankName; CompanyInfo."Bank Name") { }
            column(CompanyInfo_Giro; CompanyInfo."Giro No.") { }
            column(CompanyInfo_Iban; CompanyInfo.IBAN) { }
            column(CompanyInfo_swiftCode; CompanyInfo."SWIFT Code") { }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code") { }
            column(CompanyInfo_City; CompanyInfo.City) { }
            column(CompanyInfo_RCCM; CompanyInfo."RCCM Legal entity code FND") { }
            column(CompanyInfo_VAT; CompanyInfo."VAT Registration No.") { }
            // BC Upgrade KUMARS145 used the Base's Vat Registration No. in place of Tax Registration No. as it is in Drinkit....>>
            // column(CompanyInfo_TAX; CompanyInfo."Tax Registration No."){}
            column(CompanyInfo_TAX; CompanyInfo."VAT Registration No.") { }
            // BC Upgrade KUMARS145 used the Base's Vat Registration No. in place of Tax Registration No. as it is in Drinkit....<<
            column(OriginalCopy; OriginalCopy) { }
            column(DepositOnTheNetPrice; GeneralOpCoSetup."Deposit% on the net price") { }
            column(ExportInvoice; ExportInvoice) { }
            column(CompanyInfo_OpCoFooter; CompanyInfo."OpCo Footer image FND") { }
            column(CompanyText; CompanyText) { }
            // BC Upgrade KUMARS145 Commented Drinkit Fields....>>
            // column(CompanyInfo_BankName2; CompanyInfo."Bank Name 2") { }
            // column(CompanyInfo_BankAcc2; CompanyInfo."Bank Account No. 2") { }
            // column(CompanyInfo_IBAN2; CompanyInfo."IBAN 2") { }
            // column(CompanyInfo_Swift2; CompanyInfo."SWIFT Code 2") { }
            column(CompanyInfo_BankName2; '') { }
            column(CompanyInfo_BankAcc2; '') { }
            column(CompanyInfo_IBAN2; '') { }
            column(CompanyInfo_Swift2; '') { }
            // BC Upgrade KUMARS145 Commented Drinkit Fields....<<
            column(GeneralOpCoSetup_BankName3; GeneralOpCoSetup."Bank Name 3") { }
            column(GeneralOpCoSetup_BankAcc3; GeneralOpCoSetup."Bank Account No. 3") { }
            column(GeneralOpCoSetup_IBAN3; GeneralOpCoSetup."IBAN 3") { }
            column(GeneralOpCoSetup_Swift3; GeneralOpCoSetup."SWIFT Code 3") { }
            column(GeneralOpCoSetup_InvoiceType3; GeneralOpCoSetup."Report Invoice Type 3") { }
            column(Show_BankDetails3; (GeneralOpCoSetup."Report Invoice Type 3" = GeneralOpCoSetup."Report Invoice Type 3"::Invoice) and (GeneralOpCoSetup."Bank Account No. 3" <> '')) { }
            column(GeneralOpCoSetup_BankName4; GeneralOpCoSetup."Bank Name 4") { }
            column(GeneralOpCoSetup_BankAcc4; GeneralOpCoSetup."Bank Account No. 4") { }
            column(GeneralOpCoSetup_IBAN4; GeneralOpCoSetup."IBAN 4") { }
            column(GeneralOpCoSetup_Swift4; GeneralOpCoSetup."SWIFT Code 4") { }
            column(GeneralOpCoSetup_InvoiceType4; GeneralOpCoSetup."Report Invoice Type 4") { }
            column(Show_BankDetails4; (GeneralOpCoSetup."Report Invoice Type 4" = GeneralOpCoSetup."Report Invoice Type 4"::Invoice) and (GeneralOpCoSetup."Bank Account No. 4" <> '')) { }
            column(TxtPayTerms; TxtPayTerms) { }
            column(TxtShipMethod; TxtShipMethod) { }
            column(TxtAmtPaid; TxtAmtPaid) { }
            column(TxtSalesCondition; TxtSalesCondition) { }
            column(TxtSalesPerson; TxtSalesPerson) { }
            column(TxtUOM; TxtUOM) { }
            column(TxtUnitPrice; TxtUnitPrice) { }
            column(TxtSaleLAmt; TxtSaleLAmt) { }
            column(TxtPageNo; TxtPageNo) { }
            column(TxtOrderNo; TxtOrderNo) { }
            column(TxtInvoiceNo; TxtInvoiceNo) { }
            column(TxtPostDate; TxtPostDate) { }
            column(TxtDueDate; TxtDueDate) { }
            column(TxtPrintDate; TxtPrintDate) { }
            column(TxtBillToAddress; TxtBillToAddress) { }
            column(TxtCustomerName; TxtCustomerName) { }
            column(TxtAddress; TxtAddress) { }
            column(TxtAddress2; TxtAddress2) { }
            column(TxtPostCode; TxtPostCode) { }
            column(TxtCity; TxtCity) { }
            column(TxtCountry; TxtCountry) { }
            column(TxtVatRegistrationNo; TxtVatRegistrationNo) { }
            column(TxtCompanyTaxId; TxtCompanyTaxId) { }
            column(TxtSoldToAddress; TxtSoldToAddress) { }
            column(TxtCustomerPoNo; TxtCustomerPoNo) { }
            column(TxtShipToAddress; TxtShipToAddress) { }
            column(TxtCustomerNo; TxtCustomerNo) { }
            column(TxtInvoiceCurrency; TxtInvoiceCurrency) { }
            column(TxtVersion; TxtVersion) { }
            column(TxtItemNo; TxtItemNo) { }
            column(TxtQty; TxtQty) { }
            column(TxtTotalToBePaid; TxtTotalToBePaid) { }
            column(TxtDisc; TxtDisc) { }
            column(TxtVATPer; TxtVATPer) { }
            column(TxtDiscTotal; TxtDiscTotal) { }
            column(TxtVATAmt; TxtVATAmt) { }
            column(TxtDescrip; TxtDescrip) { }
            column(TxtTaxDetails; TxtTaxDetails) { }
            column(TxtBankDetails; TxtBankDetails) { }
            column(TxtAccNo; TxtAccNo) { }
            column(TxtBank; TxtBank) { }
            column(TxtIBAN; TxtIBAN) { }
            column(TxtCodeSwift; TxtCodeSwift) { }
            column(TxtPaymTerms; TxtPaymTerms) { }
            column(TxtInCoTerms; TxtInCoTerms) { }
            column(TxtInvCurr; TxtInvCurr) { }
            column(TxtPaymMethod; TxtPaymMethod) { }
            column(TxtRCCM; TxtRCCM) { }
            column(TxtVAT; TxtVAT) { }
            column(TxtTAX; TxtTAX) { }
            column(TxtFiscal; TxtFiscal) { }
            column(TxtGrossWeight; TxtGrossWeight) { }
            column(TxtNetWeight; TxtNetWeight) { }
            column(TxtBillOfLadingNo; TxtBillOfLadingNo) { }
            column(TxtVesselName; TxtVesselName) { }
            column(TxtETD; TxtETD) { }
            column(TxtETA; TxtETA) { }
            column(TxtAirWayBillNo; TxtAirWayBillNo) { }
            column(TxtCommodityCode; TxtCommodityCode) { }
            column(TxtCustomTariffCode; TxtCustomTariffCode) { }
            column(TxtAccountCurrency; TxtAccountCurrency) { }
            column(TxtAccountHolder; TxtAccountHolder) { }
            column(FooterTextLbl; FooterText) { }
            column(FooterText2Lbl; FooterText2) { }
            column(FooterText1Lbl; FooterText1) { }
            column(LCYCode; GLSetup."LCY Code") { }
            column(BankAccNo; BankAccNo) { }
            column(BankName; BankName) { }
            column(IBAN; IBAN) { }
            column(SwiftCode; SwiftCode) { }
            column(AccountCurrency; AccountCurrency) { }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(SellToCustAttributesNIF; CustomerAttributes1.NIF) { }
                    column(CustomerAttributestext; CustomerAttributestext) { }
                    column(OrderConfirmCopyCaption; DocumentTitleText) { }
                    column(SalesHCustNo; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SalesHPostDate; FORMAT("Sales Invoice Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDueDate; FORMAT("Sales Invoice Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDocDate; FORMAT("Sales Invoice Header"."Document Date", 0, 4)) { }
                    column(SalesHIncVAT; PriceIncVAT) { }
                    column(SalesHSalesPerName; SalesPerson.Name) { }
                    column(SalesPersonCode; "Sales Invoice Header"."Salesperson Code") { }
                    column(OutputNo; OutputNo) { }
                    column(SalesHOrdNo; "Sales Invoice Header"."Order No.") { }
                    column(SalesHReference; "Sales Invoice Header"."Your Reference") { }
                    column(SalesHExtRefNo; "Sales Invoice Header"."External Document No.") { }
                    column(SalesHVATRegNo; "Sales Invoice Header"."VAT Registration No.")
                    {
                        IncludeCaption = true;
                    }
                    column(PaymentTermDescrip; PaymentTerms.Description) { }
                    column(PaymentMethodDesc; PaymentMethod.Description) { }
                    column(ShipMethodDescrip; ShipmentMethod.Description) { }
                    column(CustName; CustomerName) { }
                    column(CustAddress; CustomerAddress) { }
                    column(SubTotal; ROUND(InvLineTotal, 0.01, '=')) { }
                    column(FreeSubTotal; ROUND(FreeInvLineTotal, 0.01, '=')) { }
                    column(VATAmount; VATAmount) { }
                    column(FreeVATAmount; FreeVATAmount) { }
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
                    column(ExciseDutiesAmtCaption; TotalFooterAmountText[8]) { }
                    column(FPIAmtCaption; TotalFooterAmountText[9]) { }
                    column(ConsTaxAmtCaption; TotalFooterAmountText[10]) { }
                    column(FPIAmout; FPIAmout) { }
                    column(ExcideDutiesAmount; ExcideDutiesAmount) { }
                    column(ConsTaxAmout; ConsTaxAmout) { }
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
                    column(CurrencyCode; CurrencyCode) { }
                    column(InvalidTxt; InvalidTxt) { }
                    column(TotalAmountLCY; TotalAmountLCY) { }
                    column(InCoTerms; "Sales Invoice Header"."InCo Terms FND") { }
                    column(SubTotalCharges; SubTotalCharges) { }
                    column(BillOfLadingNo; "Sales Invoice Header"."Bill Of Lading No. FND") { }
                    column(VesselName; "Sales Invoice Header"."Vessel Name FND") { }
                    column(ETD; "Sales Invoice Header"."ETD FND") { }
                    column(ETA; "Sales Invoice Header"."ETA FND") { }
                    column(AirWayBillNo; "Sales Invoice Header"."Air Way Bill No FND") { }
                    column(CommodityCode; "Sales Invoice Header"."Commodity Code FND") { }
                    column(CustomTariffCode; "Sales Invoice Header"."Custom Tariff Code FND") { }
                    column(TotalGrossWeight; TotalGrossWeight) { }
                    column(TotalNetWeight; TotalNetWeight) { }
                    column(SubtotalInclVAT; SubtotalInclVAT) { }
                    column(TotalVATAmnt; TotalVATAmnt) { }
                    column(HideFPI; HideFPI) { }
                    column(HideConsTax; HideConsTax) { }
                    column(HideExciseDuties; HideExciseDuties) { }
                    column(HideTransCost; HideTransCost) { }
                    column(FreeFTPAmount; FreeFTPAmount) { }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER(Item | Resource | "Fixed Asset" | "G/L Account"));
                        column(type; Var_typechargeItem) { }
                        column(itemDeposit; itemDeposit) { }
                        column(IsDisount; IsDiscount) { }
                        column(SalesLineNo; "Sales Invoice Line"."Line No.") { }
                        column(IsDeposit; IsDeposit) { }
                        column(IsNotUnderitem; IsNotUnderitem) { }
                        column(SalesLType; "Sales Invoice Line".Type) { }
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
                        column(SalesUOM; "Sales Invoice Line"."Unit of Measure Code") { }
                        column(SalesPrice; ROUND("Sales Invoice Line"."Unit Price", 1, '=')) { }
                        column(SalesVATPer; "Sales Invoice Line"."VAT %")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesAmount; "Sales Invoice Line".Amount) { }
                        column(TotalQuantity; TotalQty) { }
                        column(SalesDiscount; ItemDiscount) { }
                        column(SalesDiscount1; var_Dis) { }
                        column(TotalInvDis; TotalInvDis + ItemDiscount) { }
                        column(PrintUnderLineCharge; PrintUnderLineCharge) { }
                        // BC Upgrade KUMARS145 Commented Drinkit Fields....>>
                        // column(FreeItem; "Sales Invoice Line"."Free Item") { }
                        column(FreeItem; '') { }
                        // BC Upgrade KUMARS145 Commented Drinkit Fields....<<
                        column(LineDiscountAmount; "Sales Invoice Line"."Line Discount Amount") { }
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
                            column(UnitPrice_TempUnderChargeLine; TempUnderChargeLine."Unit Price") { }
                            column(VATIdentifier_TempUnderChargeLine; TempUnderChargeLine."VAT Identifier") { }
                            column(LineAmount_TempUnderChargeLine; TempUnderChargeLine."Line Amount") { }

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
                                TempUnderChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                SETRANGE(Number, 1, TempUnderChargeLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            OrderChargeLine: Record "Sales Invoice Line";
                            SalesChargeLine: Record "Sales Invoice Line";
                        begin
                            if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then begin
                                // BC Upgrade KUMARS145 Code Commented Drinkit Fields....>>
                                // TotalGrossWeight += "Sales Invoice Line".Weight;
                                // BC Upgrade KUMARS145 Code Commented Drinkit Fields....<<
                                TotalNetWeight += "Sales Invoice Line"."Net Weight";
                            end;

                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;
                            ItemDiscount := 0;
                            itemDeposit := 0;
                            // BC Upgrade KUMARS145 Code Commented Drinkit Fields....>>
                            // if not "Sales Invoice Line"."Free Item" then
                            //     TotalInvDis := "Sales Invoice Line"."Line Discount Amount";
                            TotalInvDis := "Sales Invoice Line"."Line Discount Amount";
                            // BC Upgrade KUMARS145 Code Commented Drinkit Fields....<<

                            // BC Upgrade KUMARS145 Code Commented Drinkit Fields....>>
                            // if ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)") and ("Sales Invoice Line"."Item Charge Type" = "Sales Invoice Line"."Item Charge Type"::Discount) then
                            if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)" then
                                // BC Upgrade KUMARS145 Code Commented Drinkit Fields....<<
                                var_Dis := "Sales Invoice Line"."Line Amount"
                            else
                                var_Dis := 0;

                            IsNotUnderitem := false;
                            /*
                            SalesChargeLine.RESET();
                            SalesChargeLine.SETRANGE("Document No.","Sales Invoice Line"."Document No.");
                            SalesChargeLine.SETRANGE(Type,"Sales Invoice Line".Type::"Charge (Item)");
                            SalesChargeLine.SETRANGE("Item Charge Type","Sales Invoice Line"."Item Charge Type"::Discount);
                            SalesChargeLine.SETFILTER("Show Item charge on Invoice",'<>%1',SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                            SalesChargeLine.SETRANGE("Attached to Line No.","Sales Invoice Line"."Line No.");
                            IF SalesChargeLine.FINDSET() THEN BEGIN
                              IsNotUnderitem:= TRUE;
                            END;
                            */

                            // BC Upgrade KUMARS145 Code Commented Drinkit Fields....>>
                            // if ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)") and
                            //   (("Sales Invoice Line"."Show Item charge on Invoice" = "Sales Invoice Line"."Show Item charge on Invoice"::"Order total")) then begin
                            //     IsNotUnderitem := true;
                            // end;
                            if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)" then
                                IsNotUnderitem := true;
                            // BC Upgrade KUMARS145 Code Commented Drinkit Fields....<<


                            //Discounts under item line
                            CLEAR(PrintUnderLineCharge);
                            SalesChargeLine.RESET();
                            SalesChargeLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                            SalesChargeLine.SETRANGE(Type, "Sales Invoice Line".Type::"Charge (Item)");
                            // BC Upgrade KUMARS145 Code Commented Drinkit Fields....>>
                            // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Invoice Line"."Item Charge Type"::Discount);
                            // BC Upgrade KUMARS145 Code Commented Drinkit Fields....<<
                            SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                            if SalesChargeLine.FINDSET() then
                                repeat
                                    if ItemChargeRec.GET(SalesChargeLine."No.") and not ItemChargeRec."Transport/Shipping Cost FND" then begin
                                        IsDiscount := true;
                                        ItemDiscount += SalesChargeLine."Line Amount";
                                        SalesChargeLine.CALCSUMS("Line Amount");
                                        SubTotalCharges += SalesChargeLine."Line Amount";
                                    end;
                                until (SalesChargeLine.NEXT() = 0);




                            //Deposit under item line
                            IsDeposit := false;
                            CLEAR(PrintUnderLineCharge);
                            SalesChargeLine.RESET();
                            SalesChargeLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                            SalesChargeLine.SETRANGE(Type, "Sales Invoice Line".Type::"Charge (Item)");
                            // BC Upgrade KUMARS145 Code Commented Drinkit Fields....>>
                            // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Invoice Line"."Item Charge Type"::Deposit);
                            // BC Upgrade KUMARS145 Code Commented Drinkit Fields....<<

                            SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                            if SalesChargeLine.FINDSET() then
                                repeat
                                    itemDeposit += SalesChargeLine."Line Amount";
                                    IsDeposit := true;
                                    SalesChargeLine.CALCSUMS("Line Amount");
                                    SubTotalCharges += SalesChargeLine."Line Amount";
                                until (SalesChargeLine.NEXT() = 0);


                            //Shipping cost under item line
                            CLEAR(PrintUnderLineCharge);
                            SalesChargeLine.RESET();
                            SalesChargeLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                            SalesChargeLine.SETRANGE(Type, "Sales Invoice Line".Type::"Charge (Item)");
                            SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                            if SalesChargeLine.FINDSET() then
                                repeat
                                    ItemChargeRec.GET(SalesChargeLine."No.");
                                    // BC Upgrade KUMARS145 Replcaed Drinkit with Base's boolean Fields....>>
                                    // if ItemChargeRec."Item Charge Type" = ItemChargeRec."Item Charge Type":: ShippingCost then begin
                                    if ItemChargeRec."Transport/Shipping Cost FND" then begin
                                        // BC Upgrade KUMARS145 Replcaed Drinkit with Base's boolean Fields....<<
                                        if not PrintUnderLineCharge then
                                            PrintUnderLineCharge := true;

                                        TempUnderChargeLine.INIT();
                                        TempUnderChargeLine := SalesChargeLine;
                                        TempUnderChargeLine.INSERT();

                                        SalesChargeLine.CALCSUMS("Line Amount");
                                        SubTotalCharges += SalesChargeLine."Line Amount";
                                    end;
                                until (SalesChargeLine.NEXT() = 0)


                        end;
                    }
                    dataitem(SplitVatAmt; "Integer")
                    {
                        column(TEMPAccSchedKPIBuffer_VatPercent; FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast")) { }
                        column(TEMPAccSchedKPIBuffer_VatAmount; TEMPAccSchedKPIBuffer."Net Change Budget") { }

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
                        CLEAR(InvLineTotal);
                        CLEAR(TotalDeposits);
                        CLEAR(SubtotalInclVAT);
                        //HEI.05<<
                        CLEAR(FreeInvLineTotal);
                        HideFPI := true;
                        HideConsTax := true;
                        HideExciseDuties := true;
                        HideTransCost := true;
                        FPIExists := false;
                        ConsTaxExists := false;
                        ExciseDutiesExists := false;
                        TransCostExists := false;
                        CLEAR(FreeFTPAmount);
                        //HEI.05>>

                        if not ExportInvoice then
                            DocumentTitleText := STRSUBSTNO(Text52007, CopyText)
                        else
                            DocumentTitleText := STRSUBSTNO(Text52008, CopyText);

                        SalesInvLineAmt.RESET();
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3|%4|%5',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset",SalesInvLineAmt.Type::"Charge (Item)",SalesInvLineAmt.Type::"G/L Account");
                        SalesInvLineAmt.SETFILTER(Type, '<>%1', SalesInvLineAmt.Type::" ");
                        if SalesInvLineAmt.FINDSET() then
                            repeat
                                /*  IF NOT ((SalesInvLineAmt.Type = SalesInvLineAmt.Type::"Charge (Item)") AND (SalesInvLineAmt."Item Charge Type" <> SalesInvLineAmt."Item Charge Type"::Discount)) THEN
                                    IF (SalesInvLineAmt."Item Charge Type" <> SalesInvLineAmt."Item Charge Type"::"Shipping Cost") AND
                                     NOT(((SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::Discount) AND (SalesInvLineAmt."No." = 'S_SHIP') AND
                                     (SalesInvLineAmt."Show Item charge on Invoice" = SalesInvLineAmt."Show Item charge on Invoice"::"Order total"))) THEN*/
                                // BC Upgrade KUMARS145 Code Commented Drinkit Fields....>>
                                // if (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") or (SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::" ") then
                                if SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)" then
                                // BC Upgrade KUMARS145 Code Commented Drinkit Fields....<<
                                //InvLineTotal += SalesInvLineAmt.Amount; //commented by HEI.05
                                //HEI.05<<
                                begin
                                    InvLineTotal += SalesInvLineAmt.Amount;
                                    // BC Upgrade KUMARS145 Code Commented Drinkit Fields....>>
                                    // if SalesInvLineAmt."Free Item" then
                                    FreeInvLineTotal += SalesInvLineAmt."Line Discount Amount";
                                    // BC Upgrade KUMARS145 Code Commented Drinkit Fields....<<
                                end
                            //HEI.05>>
                            until SalesInvLineAmt.NEXT() = 0;

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;
                        //HEI.03>>
                        TotalFooterAmountText[8] := TxtExciseDuties;
                        TotalFooterAmountText[9] := TxtFPI;
                        TotalFooterAmountText[10] := TxtConsTax;
                        //HEI.03<<

                        // BC Upgrade KUMARS145 code commneted for Drinkit field ....>>
                        // SalesInvLine.RESET();
                        // SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        // SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        // if SalesInvLine.FINDSET() then
                        //     repeat
                        //         //HEI.05<<
                        //         FreeCharge := false;
                        // if (SalesInvLine."Free Calculation Type" = SalesInvLine."Free Calculation Type"::"Discount 100%") and SalesInvLine."Free Item" then
                        //     FreeCharge := true;
                        // HEI.05>>
                        // case SalesInvLine.Type::"Item Charge Type" of
                        //     SalesInvLine."Item Charge Type"::Tax:
                        //         begin
                        //             TotalFooterAmount[1] += SalesInvLine.Amount;
                        //             //HEI.03>>
                        //             if ItemChargeRec.GET(SalesInvLine."No.") then begin
                        //                 if ItemChargeRec."Excise Duties" then
                        //                   //TotalFooterAmount[8] += SalesInvLine.Amount;  //commented by HEI.05
                        //                   //HEI.05<<
                        //                   begin
                        //                     ExciseDutiesExists := true;
                        //                     TotalFooterAmount[8] += SalesInvLine.Amount;
                        //                     if FreeCharge and ItemChargeRec."Show free amount on printout" then
                        //                         TotalFooterAmount[8] += SalesInvLine."Line Discount Amount";
                        //                     if not ItemChargeRec."Hide Item charge on printout" then
                        //                         HideExciseDuties := false;
                        //                 end;
                        //                 //HEI.05>>
                        //                 if ItemChargeRec.FPI then
                        //                   //TotalFooterAmount[9] += SalesInvLine.Amount; //commented by HEI.05
                        //                   //HEI.05<<
                        //                   begin
                        //                     FPIExists := true;
                        //                     TotalFooterAmount[9] += SalesInvLine.Amount;
                        //                     if FreeCharge and ItemChargeRec."Show free amount on printout" then
                        //                         TotalFooterAmount[9] += SalesInvLine."Line Discount Amount";
                        //                     if not ItemChargeRec."Hide Item charge on printout" then
                        //                         HideFPI := false;
                        //                 end;
                        //                 //HEI.05>>
                        //                 if ItemChargeRec."Consumption tax" then
                        //                   //TotalFooterAmount[10] += SalesInvLine.Amount;  //commented by HEI.05
                        //                   //HEI.05<<
                        //                   begin
                        //                     ConsTaxExists := true;
                        //                     TotalFooterAmount[10] += SalesInvLine.Amount;
                        //                     if FreeCharge and ItemChargeRec."Show free amount on printout" then
                        //                         TotalFooterAmount[10] += SalesInvLine."Line Discount Amount";
                        //                     if not ItemChargeRec."Hide Item charge on printout" then
                        //                         HideConsTax := false;
                        //                 end;
                        //                 //HEI.05>>
                        //             end;
                        //             //HEI.03<<
                        //         end;
                        //     SalesInvLine."Item Charge Type"::Deposit:
                        //         begin
                        //             TotalFooterAmount[2] += SalesInvLine."Line Amount";

                        //         end;
                        //     SalesInvLine."Item Charge Type"::"Shipping Cost":
                        //         begin
                        //             TotalFooterAmount[3] += SalesInvLine.Amount;
                        //             TotalFooterAmountText[3] := Text52011;
                        //         end;
                        //     SalesInvLine."Item Charge Type"::Discount:
                        //         begin
                        //             if ItemChargeRec.GET(SalesInvLine."No.") then
                        //                 if not ItemChargeRec."Transport/Shipping Cost" then begin
                        //                     TotalFooterAmount[4] += SalesInvLine."Line Amount";
                        //                     TotalInvDis += SalesInvLine."Line Amount";
                        //                 end else begin
                        //                     TotalFooterAmount[6] += SalesInvLine."Line Amount";
                        //                     //HEI.05<<
                        //                     TransCostExists := true;
                        //                     if FreeCharge and ItemChargeRec."Show free amount on printout" then
                        //                         FreeFTPAmount += SalesInvLine."Line Discount Amount";
                        //                     if not ItemChargeRec."Hide Item charge on printout" then
                        //                         HideTransCost := false;
                        //                     //HEI.05>>
                        //                 end;
                        //         end;
                        // end;

                        // /*ItemChargeRec.GET(SalesInvLine."No.");
                        // IF (ItemChargeRec."Item Charge Type" = ItemChargeRec."Item Charge Type"::ShippingCost) THEN
                        //   ShippingChargesAmount += SalesInvLine.Amount ;
                        // //add to shipping costs to shipping charges subtotal row
                        // IF SalesInvLine."Show Item charge on Invoice" = SalesInvLine."Show Item charge on Invoice"::"Order total" THEN
                        //  ShippingChargesAmount += TotalFooterAmount[6];*/

                        // until SalesInvLine.NEXT() = 0;
                        // BC Upgrade KUMARS145 Code Commented Drinkit Fields....<<

                        //HEI.05<<
                        if not FPIExists then begin
                            ItemChargeRec.RESET();
                            ItemChargeRec.SETRANGE("FPI FND", true);
                            ItemChargeRec.SETRANGE("Hide Item chrg on printout FND", false);
                            if ItemChargeRec.COUNT > 0 then
                                HideFPI := false;
                        end;
                        if not ConsTaxExists then begin
                            ItemChargeRec.RESET();
                            ItemChargeRec.SETRANGE("Consumption tax FND", true);
                            ItemChargeRec.SETRANGE("Hide Item chrg on printout FND", false);
                            if ItemChargeRec.COUNT > 0 then 
                                HideConsTax := false;
                        end;
                        if not ExciseDutiesExists then begin
                            ItemChargeRec.RESET();
                            ItemChargeRec.SETRANGE("Excise Duties FND", true);
                            ItemChargeRec.SETRANGE("Hide Item chrg on printout FND", false);
                            if ItemChargeRec.COUNT > 0 then
                                HideExciseDuties := false;
                        end;
                        if not TransCostExists then begin
                            ItemChargeRec.RESET();
                            ItemChargeRec.SETRANGE("Transport/Shipping Cost FND", true);
                            ItemChargeRec.SETRANGE("Hide Item chrg on printout FND", false);
                            if ItemChargeRec.COUNT > 0 then
                                HideTransCost := false;
                        end;
                        //HEI.05>>
                        // BC Upgrade KUMARS145 Code Commented Drinkit Fields....>>
                        // SalesInvLine.RESET();
                        // SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        // SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        // if SalesInvLine.FINDSET() then
                        //     repeat
                        //         if ItemChargeRec.GET(SalesInvLine."No.") and (ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Order total") then
                        //             case SalesInvLine."Item Charge Type" of
                        //                 SalesInvLine."Item Charge Type"::Deposit:
                        //                     TotalDeposits += SalesInvLine."Line Amount";
                        //             end;
                        //     until SalesInvLine.NEXT() = 0;
                        // BC Upgrade KUMARS145 Code Commented Drinkit Fields....<<

                        SubtotalInclVAT := "Sales Invoice Header"."Amount Including VAT" - TotalDeposits;


                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        MarkupChargesAmount := TotalFooterAmount[5];
                        BaseMarginAmt := TotalFooterAmount[7];
                        //HEI.03>>
                        ExcideDutiesAmount := TotalFooterAmount[8];
                        FPIAmout := TotalFooterAmount[9];
                        ConsTaxAmout := TotalFooterAmount[10];
                        ShippingChargesAmount := TotalFooterAmount[3] + TotalFooterAmount[6];
                        //HEI.03<<

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        if SalesInvLine.FINDSET() then
                            repeat
                                TotalFooterAmount[4] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[4] := Text52010;
                            until SalesInvLine.NEXT() = 0;

                        LineDisAmount := TotalFooterAmount[4];

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
                    //HEI.05<<
                    CLEAR(FreeInvLineTotal);
                    HideFPI := true;
                    HideConsTax := true;
                    HideExciseDuties := true;
                    HideTransCost := true;
                    FPIExists := false;
                    ConsTaxExists := false;
                    ExciseDutiesExists := false;
                    TransCostExists := false;
                    CLEAR(FreeFTPAmount);
                    //HEI.05>>
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
                // BC Upgrade KUMARS145 replaced Drinkit field with base's....>>
                // if CompanyInfo."Tax Registration No." <> '' then
                //     CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                if CompanyInfo."Vat Registration No." <> '' then
                    CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Vat Registration No.";
                // BC Upgrade KUMARS145 replaced Drinkit field with base's....<<
                //CompanyText += ', ' + ChOfComm;
                if CompanyInfo."Phone No." <> '' then
                    CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                if CompanyInfo."Fax No." <> '' then
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                if CompanyInfo."E-Mail" <> '' then
                    CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";

                //decide if export invoice/intercompany or not and set de report language
                //SetExportICInvoice;

                //set the invoice language
                if ICInvoice then begin
                    DocLanguage := 'ENG';
                end else begin
                    if ExportInvoice then
                        DocLanguage := 'ENG'
                    else
                        DocLanguage := 'FRA';
                end;

                CurrReport.LANGUAGE := GetLanguageID(DocLanguage);

                //footer texts

                //commented by HEI.03>>
                /*FooterText := CompanyInfo.Address;
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

                TotalGrossWeight := 0;
                TotalNetWeight := 0;

                TEMPAccSchedKPIBuffer.DELETEALL();
                if Country.GET(CompanyInfo."Country/Region Code") then
                    CompanyInfoContryName := Country.Name;

                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");



                if SalesPerson.GET("Sales Invoice Header"."Salesperson Code") then;

                if ShipmentMethod.GET("Sales Invoice Header"."Shipment Method Code") then
                    ShipmentMethod.TranslateDescription(ShipmentMethod, DocLanguage);

                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, DocLanguage);

                PaymentMethod.RESET();
                if PaymentMethod.GET("Payment Method Code") then;

                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    CurrencyCode := GLSetup."LCY Code";
                    TotalExText := STRSUBSTNO(Text52001, GLSetup."LCY Code");
                    TotalInText := STRSUBSTNO(Text52002, GLSetup."LCY Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := STRSUBSTNO(Text52005, GLSetup."LCY Code");
                end else begin
                    CurrencyCode := "Currency Code";
                    TotalExText := STRSUBSTNO(Text52001, "Currency Code");
                    TotalInText := STRSUBSTNO(Text52002, "Currency Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, "Currency Code");
                    SubTotalExText := STRSUBSTNO(Text52005, "Currency Code");
                end;

                //HEI.05<<
                CLEAR(BankAccNo);
                CLEAR(BankName);
                CLEAR(IBAN);
                CLEAR(SwiftCode);
                CLEAR(AccountCurrency);
                case CurrencyCode of
                    CompanyInfo."Currency FND":
                        begin
                            BankAccNo := CompanyInfo."Bank Account No.";
                            BankName := CompanyInfo."Bank Name";
                            IBAN := CompanyInfo.IBAN;
                            SwiftCode := CompanyInfo."SWIFT Code";
                            AccountCurrency := CompanyInfo."Currency FND";
                        end;
                    // BC Upgrade KUMARS145 Code Commented Drinkit Fields....>>
                    // CompanyInfo."Currency 2":
                    //     begin
                    //         BankAccNo := CompanyInfo."Bank Account No. 2";
                    //         BankName := CompanyInfo."Bank Name 2";
                    //         IBAN := CompanyInfo."IBAN 2";
                    //         SwiftCode := CompanyInfo."SWIFT Code 2";
                    //         AccountCurrency := CompanyInfo."Currency 2";
                    //     end;
                    // BC Upgrade KUMARS145 Code Commented Drinkit Fields....<<
                    GeneralOpCoSetup."Currency 3":
                        begin
                            BankAccNo := GeneralOpCoSetup."Bank Account No. 3";
                            BankName := GeneralOpCoSetup."Bank Name 3";
                            IBAN := GeneralOpCoSetup."IBAN 3";
                            SwiftCode := GeneralOpCoSetup."SWIFT Code 3";
                            AccountCurrency := GeneralOpCoSetup."Currency 3";
                        end;
                    else begin
                        BankAccNo := CompanyInfo."Bank Account No.";
                        BankName := CompanyInfo."Bank Name";
                        IBAN := CompanyInfo.IBAN;
                        SwiftCode := CompanyInfo."SWIFT Code";
                        AccountCurrency := CompanyInfo."Currency FND";
                    end;
                end;
                //HEI.05>>

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

                CLEAR(CustomerAttributes1);
                if CustomerAttributes1.GET("Sales Invoice Header"."Sell-to Customer No.") then;

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
                FreeVATAmount := 0;
                FreeVATAmt := 0;
                lineNumberVAT := 0;
                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.FINDSET() then
                    repeat
                        VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                        //VATAmount := ABS(VatAmt);
                        VATAmount := VatAmt;


                        TEMPAccSchedKPIBuffer.RESET();
                        TEMPAccSchedKPIBuffer.SETRANGE("Balance at Date Forecast", SalesInvLine."VAT %");
                        if TEMPAccSchedKPIBuffer.FINDFIRST() then begin
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.MODIFY;
                        end else begin
                            lineNumberVAT += 1;
                            TEMPAccSchedKPIBuffer.INIT();
                            TEMPAccSchedKPIBuffer."No." := lineNumberVAT;
                            TEMPAccSchedKPIBuffer."Balance at Date Forecast" := SalesInvLine."VAT %";
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.INSERT();
                        end;
                    until SalesInvLine.NEXT() = 0;

                SalesInvLine_1.RESET();
                SalesInvLine_1.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine_1.SETFILTER("VAT %", '<>%1', 0);
                // SalesInvLine_1.SETRANGE("Free Item", false); // BC Upgrade KUMARS145 Code Commented Drinkit Field....>>
                if SalesInvLine_1.FINDSET() then begin
                    repeat
                        FreeVATAmt += (SalesInvLine_1."VAT Base Amount" * SalesInvLine_1."VAT %") / 100;
                        FreeVATAmount := ABS(FreeVATAmt);

                    until SalesInvLine_1.NEXT() = 0L
                end;

                TEMPAccSchedKPIBuffer.RESET();
                if TEMPAccSchedKPIBuffer.FINDSET() then
                    repeat
                        Counter += 1;

                        SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%';
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

                //"Sales Invoice Header".CALCFIELDS("Amount Including VAT");
                "Sales Invoice Header".CALCFIELDS("Amount Including VAT", Amount);  //HEI.05
                TotalAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(TODAY, "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Amount Including VAT", CurrExchRate.ExchangeRate(TODAY, "Sales Invoice Header"."Currency Code"));

                TotalVATAmnt := "Sales Invoice Header"."Amount Including VAT" - "Sales Invoice Header".Amount;  //HEI.05

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
                        CaptionML = ENU = 'Number of Copies',
                                    FRA = 'Nombre de copies',
                                    ENG = 'Number of Copies';
                        ToolTipML = ENU = 'Enter the number of copies to print. If you enter a number greater than 1, the report will print that many copies of the invoice.',
                                    FRA = 'Entrez le nombre de copies à imprimer. Si vous entrez un nombre supérieur à 1, le rapport imprimera autant de copies de la facture.',
                                    ENG = 'Enter the number of copies to print. If you enter a number greater than 1, the report will print that many copies of the invoice.';
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
        label(lblPayTerms; ENU = 'Payment Terms:', FRA = 'Conditions Paiement', ENG = 'Payment Terms:')
        label(lblShipMethod; ENU = 'Shipment Method', FRA = 'Condition de Livraison', ENG = 'Shipment Method')
        label(lblAmtPaid; ENU = 'Subtotal incl. VAT:', FRA = 'Montant A Payer', ENG = 'Subtotal incl. VAT:')
        label(lblSalesCondition; ENU = 'The Sale Conditions on the back side', FRA = 'Conditions generales de vento ou envers', ENG = 'The Sale Conditions on the back side')
        label(lblTotalQty; ENU = 'Total Quantity', ENG = 'Total Quantity')
        label(lblSalesPerson; ENU = 'Sales Person ID:', FRA = 'Contact Commercial:', ENG = 'Sales Person ID:')
        label(lblUOM; ENU = 'Unit', FRA = 'Unité', ENG = 'Unit')
        label(lblUnitPrice; ENU = 'Unit Price', FRA = 'Prix unitaire', ENG = 'Unit Price')
        label(lblSaleLAmt; ENU = 'Amount Excl. VAT', FRA = 'Taux TVA', ENG = 'Amount Excl. VAT')
        label(lblPageNo; ENU = 'Page No:', FRA = 'Page No:', ENG = 'Page No:')
        label(lblOrderNo; ENU = 'SO Order No:', FRA = 'No commande:', ENG = 'SO Order No:')
        label(lblInvoiceNo; ENU = 'Invoice No:', FRA = 'No Facture:', ENG = 'Invoice No:')
        label(lblVATAmt; ENU = 'Total VAT:', ENG = 'Total VAT:')
        label(lblPostDate; ENU = 'Invoice Date:', FRA = 'Date Facturation:', ENG = 'Invoice Date:')
        label(lblDueDate; ENU = 'Due Date:', FRA = 'Date échéance:', ENG = 'Due Date:')
        label(lblPriceIncVAT; ENU = 'Price Including VAT', ENG = 'Price Including VAT')
        label(lblDriver; ENU = 'Name and Driver Signature', ENG = 'Name and Driver Signature')
        label(lblWarehouse; ENU = 'Name and Warehouse Keeper Signature', ENG = 'Name and Warehouse Keeper Signature')
        label(lblSecurity; ENU = 'Name and Security Visa', ENG = 'Name and Security Visa')
        label(lblPrintDate; ENU = 'Print Date:', FRA = 'Date d''impression', ENG = 'Print Date:')
        label(LblBillToAddress; ENU = 'BILL TO:', FRA = 'ADRESSE FACTURATION:', ENG = 'BILL TO:')
        label(LblCustomerName; ENU = 'Customer Name:', FRA = 'Nom du client:', ENG = 'Customer Name:')
        label(LblAddress; ENU = 'Address 1:', FRA = 'Addresse 1:', ENG = 'Address 1:')
        label(LblAddress2; ENU = 'Address 2:', FRA = 'Addresse 2:', ENG = 'Address 2:')
        label(LblPostCode; ENU = 'Post Code:', FRA = 'Code postal:', ENG = 'Post Code:')
        label(LblCity; ENU = 'City:', FRA = 'Ville :', ENG = 'City:')
        label(LblCountry; ENU = 'Country:', FRA = 'Pays:', ENG = 'Country:')
        label(LblVatRegistrationNo; ENU = 'Vat Registration No:', FRA = 'Numéro d''identificayion fiscal:', ENG = 'Vat Registration No:')
        label(LblCompanyTaxId; ENU = 'Company Tax ID:', FRA = 'Regime TVA:', ENG = 'Company Tax ID:')
        label(LblSoldToAddress; ENU = 'CUSTOMER:', FRA = 'CLIENT:', ENG = 'CUSTOMER:')
        label(LblCustomerPoNo; ENU = 'Customer PO No:', FRA = 'No BC du client:', ENG = 'Customer PO No:')
        label(LblTaxDetails; ENU = 'Tax Summary', ENG = 'Tax Summary')
        label(LblBankInfo; ENU = 'Bank Details:', ENG = 'Bank Details:')
        label(LblAccountNo; ENU = 'Account No:', ENG = 'Account No:')
        label(LblBankName; ENU = 'Bank:', ENG = 'Bank:')
        label(LblGiro; ENU = 'Giro No.', ENG = 'Giro No.')
        label(LblIban; ENU = 'Iban:', ENG = 'Iban:')
        label(LblSwiftCode; ENU = 'Swift Code:', ENG = 'Swift Code:')
        label(LblSignature; ENU = 'Signature:', ENG = 'Signature:')
        label(LblVatPercent; ENU = 'Vat Percent', ENG = 'Vat Percent')
        label(LblVatAmount; ENU = 'Vat Amount', ENG = 'Vat Amount')
        label(LblIncoTerm; ENU = 'InCo Terms:', ENG = 'InCo Terms:')
        label(Lbldisc; ENU = 'Disc.', ENG = 'Disc.')
        label(LblShipToAddress; ENU = 'SHIP TO ADDRESS:', FRA = 'ADDRESSE LIVRAISON:', ENG = 'SHIP TO ADDRESS:')
        label(LblCustomerNo; ENU = 'Customer No:', FRA = 'No du client:', ENG = 'Customer No:')
        label(LblInvoiceCurrency; ENU = 'Invoice Currency:', FRA = 'Devise facturation:', ENG = 'Invoice Currency:')
        label(LblVersion; ENU = 'Version:', FRA = 'Version:', ENG = 'Version:')
        label(LblItemNo; ENU = 'Item No.', FRA = 'Code article.', ENG = 'Item No.')
        label(LblQty; ENU = 'Qty', FRA = 'Qté', ENG = 'Qty')
        label(LblPayMethod; ENU = 'Payment Method:', ENG = 'Payment Method:')
        label(LblInvoiceCurrLCY; ENU = 'Invoice Curr LCY:', ENG = 'Invoice Curr LCY:')
        label(LblTotalToBePaid; ENU = 'Total to be paid:', FRA = 'Net a payer:', ENG = 'Total to be paid:')
        label(LblDiscTotal; ENU = 'Disc Total:', ENG = 'Disc Total:')
        label(GrossWeightLbl; ENU = 'Gross Weight:', FRA = 'Poids brut:', ENG = 'Gross Weight:')
        label(NetWeightLbl; ENU = 'Net Weight:', FRA = 'Poids net:', ENG = 'Net Weight:')
        label(BillOfLadingNoLbl; ENU = 'Bill Of Lading No:', FRA = 'Connaissement non:', ENG = 'Bill Of Lading No:')
        label(VesselNameLbl; ENU = 'Vessel Name:', FRA = 'Nom du navire:', ENG = 'Vessel Name:')
        label(ETDLbl; ENU = 'ETD:', ENG = 'ETD:')
        label(ETALbl; ENU = 'ETA:', ENG = 'ETA:')
        label(AirWayBillNoLbl; ENU = 'Air Way Bill No:', ENG = 'Air Way Bill No:')
        label(CommodityCodeLbl; ENU = 'Commodity Code:', FRA = 'Code marchandise:', ENG = 'Commodity Code:')
        label(CustomTariffCodeLbl; ENU = 'Custom Tariff Code:', FRA = 'Code tarifaire personnalisé:', ENG = 'Custom Tariff Code:')
        label(BankInfo2Lbl; ENU = 'Bank Details 2:', ENG = 'Bank Details 2:')
        label(BankInfo3Lbl; ENU = 'Bank Details 3:', ENG = 'Bank Details 3:')
        label(BankInfo4Lbl; ENU = 'Bank Details 4:', ENG = 'Bank Details 4:')
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND", "OpCo Logo FND");

        GeneralOpCoSetup.GET();
        DocSubtypeCodeSetup.GET; // BC Upgrade VAMSIU01 >>
    end;

    var
        var_Dis: Decimal;
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        VATEntry: Record "Area";
        LanguageRec: Record Language;
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
        Text52000: TextConst ENU = 'Copy', FRA = 'Copie', ENG = 'Copy';
        Text52001: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 HT', ENG = 'Total %1 Excl. VAT';
        Text52002: TextConst ENU = 'Total %1 Incl. VAT', FRA = 'Total %1 TTC', ENG = 'Total %1 Incl. VAT';
        Text52003: TextConst ENU = 'VAT @ %1 ', FRA = 'TVA @ %1', ENG = 'VAT @ %1 ';
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
        TotalFooterAmount: array[10] of Decimal;
        TotalFooterAmountText: array[10] of Text[50];
        CustomerNo: Code[20];
        CustomerName: Text[50];
        CustomerAddress: Text[240];
        TotalDepositFooterAmountText: array[6] of Text[50];
        TotalDepositFooterAmount: array[6] of Decimal;
        DisplayTitleHeaderType: Option Confirmation,Proforma;
        DocumentTitleText: Text[30];
        Text52004: TextConst ENU = 'Order Confirmation %1', FRA = 'Confirmation de commande %1', ENG = 'Order Confirmation %1';
        Text52004B: TextConst ENU = 'Proforma Invoice %1', FRA = 'Facture Proforma %1', ENG = 'Proforma Invoice %1';
        Text52005: TextConst ENU = 'Subtotal %1 Excl. VAT:', FRA = 'Sous Total %1 Hors Taxe:', ENG = 'Subtotal %1 Excl. VAT:';
        Text52005B: TextConst ENU = 'Subtotal %1 Incl. VAT:', FRA = 'Sous-total %1 TTC:', ENG = 'Subtotal %1 Incl. VAT:';
        Text52006: TextConst ENU = 'Sales Invoice', FRA = 'Facture de vente', ENG = 'Sales Invoice', FRE = 'Facture Vente';
        TaxAmout: Decimal;
        VATAmount: Decimal;
        DepAmount: Decimal;
        ShipAmount: Decimal;
        LineDisAmount: Decimal;
        ShippingChargesAmount: Decimal;
        MarkupChargesAmount: Decimal;
        CustomerAttributes: Record "Customer Attributes FND";
        CustomerAttributestext: Text[1024];
        Text52007: TextConst ENU = 'Sundry Invoice', FRA = 'Facture divers', ENG = 'Sundry Invoice';
        Text52008: TextConst ENU = 'Export Invoice', FRA = 'Facture d''Export', ENG = 'Export Invoice', FRE = 'Facture d''Export';
        EBMSDCInformationLbl: TextConst ENU = 'SDC Information', ENG = 'SDC Information';
        EBMDateLbl: TextConst ENU = 'Date', ENG = 'Date';
        EBMSDCIDLbl: TextConst ENU = 'SDC ID', ENG = 'SDC ID';
        EBMSDCReceiptNumberLbl: TextConst ENU = 'SDC Receipt Number', ENG = 'SDC Receipt Number';
        EBMInvoiceNumberLbl: TextConst ENU = 'Invoice Number', ENG = 'Invoice Number';
        EBMInternalDateLbl: TextConst ENU = 'Internal Data', ENG = 'Internal Data';
        EBMReceiptSignatureLbl: TextConst ENU = 'Receipt Signature', ENG = 'Receipt Signature';
        EBMDateTimeOfPrintingLbl: TextConst ENU = 'Date Time of Printing', ENG = 'Date Time of Printing';
        EBMMRCLbl: TextConst ENU = 'MRC', ENG = 'MRC';
        EBMNotReceivedErr: TextConst ENU = 'You cannot print %1 %2 because EBM details are not received.', ENG = 'You cannot print %1 %2 because EBM details are not received.';
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
        InvalidTxt: TextConst ENU = '**INVALID WITHOUT FISCAL OR REFUND RECEIPT ATTACHED**', ENG = '**INVALID WITHOUT FISCAL OR REFUND RECEIPT ATTACHED**';
        TotalInvDis: Decimal;
        Text50001: TextConst ENU = 'Excise Duties:', FRA = 'Droits d''accises:', ENG = 'Excise Duties:';
        Text50002: TextConst ENU = 'Deposit Amount:', FRA = 'Frais consigne:', ENG = 'Deposit Amount:';
        Text50003: TextConst ENU = 'Shipping Charges:', FRA = 'Frais Transport Produits:', ENG = 'Shipping Charges:';
        Text50004: TextConst ENU = 'Original', FRA = 'Original', ENG = 'Original';
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
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";// BC Upgrade VAMSIU01 >>
        CompanyText: Text;
        TaxNoID: TextConst ENU = 'Tax Number ID:', ENG = 'Tax Number ID:';
        ChOfComm: TextConst ENU = 'Chamber of commerce:', ENG = 'Chamber of commerce:';
        ContactNo: TextConst ENU = 'Contact Number:', ENG = 'Contact Number:';
        FaxNo: TextConst ENU = 'Fax Number:', ENG = 'Fax Number:';
        EmailComp: TextConst ENU = 'E-mail:', ENG = 'E-mail:';
        CountryInfo: Record "Country/Region";
        lineNumberVAT: Integer;
        ICInvoice: Boolean;
        Text52010: TextConst ENU = 'Invoice discount amount:', FRA = 'Montant remise facture:', ENG = 'Invoice discount amount:';
        Text52011: TextConst ENU = 'Shippimg Amount:', FRA = 'Montant d''expédition:', ENG = 'Shippimg Amount:';
        DocLanguage: Code[10];
        TxtPayTerms: TextConst ENU = 'Payment Terms:', FRA = 'Conditions Paiement:', ENG = 'Payment Terms:';
        TxtShipMethod: TextConst ENU = 'Shipment Method', FRA = 'Condition de Livraison', ENG = 'Shipment Method';
        TxtSalesCondition: TextConst ENU = 'The Sale Conditions on the back side', FRA = 'Conditions generales de vento ou envers', ENG = 'The Sale Conditions on the back side';
        TxtSalesPerson: TextConst ENU = 'Sales Person ID:', FRA = 'ID du Représentant/Commercial:', ENG = 'Sales Person ID:';
        TxtUOM: TextConst ENU = 'Unit', FRA = 'Unité', ENG = 'Unit';
        TxtUnitPrice: TextConst ENU = 'Unit Price', FRA = 'Prix Unitaire', ENG = 'Unit Price';
        TxtSaleLAmt: TextConst ENU = 'Amount Excl. VAT', FRA = 'Montant sans TVA', ENG = 'Amount Excl. VAT';
        TxtPageNo: TextConst ENU = 'Page No:', FRA = 'Page N°:', ENG = 'Page No:';
        TxtOrderNo: TextConst ENU = 'SO Order No:', FRA = 'N° commande:', ENG = 'SO Order No:';
        TxtInvoiceNo: TextConst ENU = 'Invoice No:', FRA = 'N° De Facture:', ENG = 'Invoice No:';
        TxtPostDate: TextConst ENU = 'Invoice Date:', FRA = 'Date de facturation:', ENG = 'Invoice Date:';
        TxtDueDate: TextConst ENU = 'Due Date:', FRA = 'Date d''échéance:', ENG = 'Due Date:';
        TxtPrintDate: TextConst ENU = 'Print Date:', FRA = 'Date d''impression:', ENG = 'Print Date:';
        TxtBillToAddress: TextConst ENU = 'BILL TO:', FRA = 'ADRESSE DE FACTURATION:', ENG = 'BILL TO:';
        TxtCustomerName: TextConst ENU = 'Customer Name:', FRA = 'Nom du client:', ENG = 'Customer Name:';
        TxtAddress: TextConst ENU = 'Address:', FRA = 'Addresse:', ENG = 'Address:';
        TxtAddress2: TextConst ENU = 'Address 2:', FRA = 'Addresse 2:', ENG = 'Address 2:';
        TxtPostCode: TextConst ENU = 'Post Code:', FRA = 'Code postal:', ENG = 'Post Code:';
        TxtCity: TextConst ENU = 'City:', FRA = 'Ville:', ENG = 'City:';
        TxtCountry: TextConst ENU = 'Country:', FRA = 'Pays:', ENG = 'Country:';
        TxtVatRegistrationNo: TextConst ENU = 'Vat Registration No:', FRA = 'N° d''identification TVA:', ENG = 'Vat Registration No:';
        TxtCompanyTaxId: TextConst ENU = 'Company Tax ID:', FRA = 'N° Impot:', ENG = 'Company Tax ID:';
        TxtSoldToAddress: TextConst ENU = 'CUSTOMER:', FRA = 'CLIENT:', ENG = 'CUSTOMER:';
        TxtCustomerPoNo: TextConst ENU = 'Customer PO No:', FRA = 'Bon de commande client N°:', ENG = 'Customer PO No:';
        TxtShipToAddress: TextConst ENU = 'SHIP TO ADDRESS:', FRA = 'ADRESSE DE LIVRAISON:', ENG = 'SHIP TO ADDRESS:';
        TxtCustomerNo: TextConst ENU = 'Customer No:', FRA = 'N° du client:', ENG = 'Customer No:';
        TxtInvoiceCurrency: TextConst ENU = 'Invoice Currency:', FRA = 'Devise de la facture:', ENG = 'Invoice Currency:';
        TxtVersion: TextConst ENU = 'Version:', FRA = 'Version:', ENG = 'Version:';
        TxtItemNo: TextConst ENU = 'Item No.', FRA = 'Article N°', ENG = 'Item No.';
        TxtQty: TextConst ENU = 'Qty', FRA = 'Qté', ENG = 'Qty';
        TxtTotalToBePaid: TextConst ENU = 'Total:', FRA = 'Total:', ENG = 'Total:';
        TxtDisc: TextConst ENU = 'Disc.', FRA = 'Mont. Remise', ENG = 'Disc.';
        TxtVATPer: TextConst ENU = 'VAT Rate', FRA = 'Taux TVA', ENG = 'VAT Rate';
        TxtDiscTotal: TextConst ENU = 'Discount Total:', FRA = 'Remise Totale:', ENG = 'Discount Total:';
        TxtDescrip: TextConst ENU = 'Description', FRA = 'Description', ENG = 'Description';
        TxtTaxDetails: TextConst ENU = 'VAT Summary', FRA = 'Résumé TVA', ENG = 'VAT Summary';
        TxtBankDetails: TextConst ENU = 'Bank Details:', FRA = 'Coordonnées bancaires:', ENG = 'Bank Details:';
        TxtAccNo: TextConst ENU = 'Account No.:', FRA = 'N° de compte:', ENG = 'Account No.:';
        TxtBank: TextConst ENU = 'Bank:', FRA = 'Banque:', ENG = 'Bank:';
        TxtIBAN: TextConst ENU = 'IBAN:', ENG = 'IBAN:';
        TxtCodeSwift: TextConst ENU = 'Swift Code:', FRA = 'Swift code:', ENG = 'Swift Code:';
        TxtPaymTerms: TextConst ENU = 'Payment Terms:', FRA = 'Conditions de paiement:', ENG = 'Payment Terms:';
        TxtInCoTerms: TextConst ENU = 'InCo Terms:', FRA = 'Incoterm:', ENG = 'InCo Terms:';
        TxtPaymMethod: TextConst ENU = 'Payment Method:', FRA = 'Méthode de paiement:', ENG = 'Payment Method:';
        TxtInvCurr: TextConst ENU = 'Invoice Curr LCY:', FRA = 'Devise de facturation:', ENG = 'Invoice Curr LCY:';
        FooterText: Text[500];
        FooterText2: Text[500];
        FooterText1: Text[500];
        FooterSubText: TextConst ENU = 'Site Internet:', ENG = 'Site Internet:';
        TxtAmtPaid: TextConst ENU = 'Subtotal incl. VAT:', FRA = 'Total TTC (toute taxe comprise):', ENG = 'Subtotal incl. VAT:';
        TxtVATAmt: TextConst ENU = 'Total VAT:', FRA = 'Montant TVA:', ENG = 'Total VAT:';
        TotalDeposits: Decimal;
        SubtotalInclVAT: Decimal;
        SalesInvLine_1: Record "Sales Invoice Line";
        FreeVATAmount: Decimal;
        FreeVATAmt: Decimal;
        TxtRCCM: TextConst ENU = 'N° RCCM:', FRA = 'N° RCCM:', ENG = 'N° RCCM:';
        TxtVAT: TextConst ENU = 'N° Identifiication National:', FRA = 'N° Identifiication National:';
        TxtTAX: TextConst ENU = 'N° Impot:', FRA = 'N° Impot:';
        TxtFiscal: TextConst ENU = 'N° fiscal de l''entreprise:', FRA = 'N° fiscal de l''entreprise:';
        TxtGrossWeight: TextConst ENU = 'Gross Weight:', FRA = 'Poids brut:', ENG = 'Gross Weight:';
        TxtNetWeight: TextConst ENU = 'Net Weight:', FRA = 'Poids net:', ENG = 'Net Weight:';
        TxtBillOfLadingNo: TextConst ENU = 'Bill Of Lading No:', FRA = 'Connaissement non:', ENG = 'Bill Of Lading No:';
        TxtVesselName: TextConst ENU = 'Vessel Name:', FRA = 'Nom du navire:', ENG = 'Vessel Name:';
        TxtETD: TextConst ENU = 'ETD:', ENG = 'ETD:';
        TxtETA: TextConst ENU = 'ETA:', ENG = 'ETA:';
        TxtAirWayBillNo: TextConst ENU = 'Air Way Bill No:', ENG = 'Air Way Bill No:';
        TxtCommodityCode: TextConst ENU = 'Commodity Code:', FRA = 'Code marchandise:', ENG = 'Commodity Code:';
        TxtCustomTariffCode: TextConst ENU = 'Custom Tariff Code:', FRA = 'Code tarifaire personnalisé:', ENG = 'Custom Tariff Code:';
        TxtFooter: TextConst ENU = 'a capital variable', FRA = 'a capital variable', ENG = 'a capital variable';
        TxtFooter1: TextConst ENU = 'RCCM: n°', FRA = 'Registre de Commerce et du Crédit Mobilier (RCCM): n°';
        TxtFooter2: TextConst ENU = 'Capital Social Initial :', FRA = 'Capital Social Initial :';
        TxtFooter3: Label 'I.N.';
        FPIAmout: Decimal;
        ExcideDutiesAmount: Decimal;
        ConsTaxAmout: Decimal;
        TxtExciseDuties: TextConst ENU = 'Excise duties:', FRA = 'Droits d''accises:';
        TxtConsTax: TextConst ENU = 'Consumption tax:', FRA = 'Taxe de consommation:';
        TxtFPI: Label 'FPI:';
        TxtAccountCurrency: TextConst ENU = 'Account Currency:', FRA = 'Devise du compte:';
        TxtAccountHolder: TextConst ENU = 'Account Holder:', FRA = 'Account Holder:';
        CurrencyCode: Code[10];
        CustomerAttributes1: Record "Customer Attributes FND";
        BankAccNo: Text[30];
        BankName: Text[50];
        IBAN: Code[50];
        SwiftCode: Code[20];
        FreeCharge: Boolean;
        FreeInvLineTotal: Decimal;
        TotalVATAmnt: Decimal;
        HideFPI: Boolean;
        HideConsTax: Boolean;
        HideExciseDuties: Boolean;
        HideTransCost: Boolean;
        FPIExists: Boolean;
        ConsTaxExists: Boolean;
        ExciseDutiesExists: Boolean;
        TransCostExists: Boolean;
        AccountCurrency: Code[10];
        FreeFTPAmount: Decimal;

    local procedure SetExportICInvoice();
    begin
        ICInvoice := false;
        ExportInvoice := false;

        if Customer.GET("Sales Invoice Header"."Bill-to Customer No.") then
            if Customer."Account Group FND" in ['Y005', 'Y006', 'Y008'] then
                ICInvoice := true;

        if "Sales Invoice Header"."Document Subtype Code FND" in [DocSubtypeCodeSetup."Sundry Sales Order Non Stock", DocSubtypeCodeSetup."Sundry Sales Order Stock"] then //BC Upgrade VAMSIU01 >>
            ExportInvoice := false
        else
            if "Sales Invoice Header"."Ship-to Country/Region Code" = '' then
                ExportInvoice := false
            else
                if "Sales Invoice Header"."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" then
                    ExportInvoice := true
                else
                    ExportInvoice := false;
    end;

    local procedure GetLanguageID(DocLanguagecode: Code[10]): Integer
    var
        languageReclocal: Record Language;
    begin
        if languageReclocal.GET(DocLanguagecode) then
            exit(languageReclocal."Windows Language ID");
        exit(0);
    end;
}

