report 51090 "Copy Sales Inv STD StLucia CBN"
{
    // version HEI.01

    // HEI.01 CHG2151289 HB2805 IBM BHANDS01 09.05.2022 # St Lucia Invoice layout adjustment for VAT on Free
    //   # Copy of Report 50265 "Sales Invoice STD" created for St. Lucia
    //   # Code added to remove VAT % and VAT Amount for Free Items
    // BC Upgrade BHARDA11 >>
    // Migration from NAV 2018 to Business Central 26
    // Changes:
    // 1. Added ApplicationArea = All and UsageCategory = ReportsAndAnalysis properties to report level for BC visibility and searchability
    // 2. Commented out Drink-IT custom fields from Company Information table:
    //    - "Bank Name 2", "Bank Account No. 2", "IBAN 2", "SWIFT Code 2" (4 columns)
    //    - Replaced with empty string columns to maintain report layout compatibility
    // 3. Commented out Drink-IT custom fields from Sales Invoice Header table:
    //    - "InCo Terms", "Bill Of Lading No.", "Vessel Name", "ETD", "ETA", "Air Way Bill No", "Commodity Code", "Custom Tariff Code" (8 columns)
    //    - Replaced with empty string columns to maintain report layout compatibility
    // 4. Commented out Drink-IT field "Weight" calculation in Sales Invoice Line trigger
    // 5. Commented out Drink-IT fields "Item Charge Type" and "Show Item charge on Invoice" logic:
    //    - SalesInvLineAmt calculation loop (InvLineTotal calculation)
    //    - SalesInvLine Item Charge Type CASE statement (Tax, Deposit, Shipping Cost, Discount calculations)
    //    - Multiple IF conditions checking Item Charge Type
    // 6. Commented out Drink-IT custom tables:
    //    - StandardTextReport (Table 2014410) - Used for footer text generation
    //    - DocSubtypeCodeSetup (Table 2014473) - Used for document subtype validation
    //    - FreeReasonCode (Table 2013788) - Used for free item VAT calculation
    // 7. Commented out Drink-IT field "Free Item" logic in Sales Invoice Line trigger
    // 8. Commented out Drink-IT field "Free Reason Code" VAT calculation logic (2 instances)
    // 9. Commented out Company Information "Tax Registration No." field in company text generation
    // 10. Replaced Language.GetLanguageID with Language Codeunit approach for BC compatibility:
    //     - Added LanguageMgt: Codeunit Language variable
    //     - Added LanguageID: Integer variable
    //     - Changed from: CurrReport.LANGUAGE := Language1.GetLanguageID("Language Code")
    //     - Changed to: LanguageID := LanguageMgt.GetLanguageIdOrDefault("Language Code"); CurrReport.Language := LanguageID
    // 11. Added ApplicationArea = All to request page field "No. of Copies"
    // 12. Commented out variable declarations for Drink-IT custom tables:
    //     - DocSubtypeCodeSetup: Record 2014473
    //     - StandardTextReport: Record 2014410
    //     - FreeReasonCode: Record 2013788
    // 

    // BC Upgrade SHUKLP03 >> Testscriprt OTC221 => Customise DIT code.

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Copy Sales Invoice STD StLucia.rdl';

    Caption = 'Sales Invoice STD';
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;
    ApplicationArea = All; // BC Upgrade BHARDA11
    UsageCategory = ReportsAndAnalysis; // BC Upgrade BHARDA11

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
            //BC Upgrade SHUKLP03 >> ---- fields ("Bank Name 2","Bank Account No. 2","IBAN 2","SWIFT Code 2")
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
            // BC Upgrade BHARDA11 >> ----Drink-IT fields ("Bank Name 2","Bank Account No. 2","IBAN 2","SWIFT Code 2")

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
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = sorting(Number)
                                        where(Number = CONST(1));
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
                    // Bug ID- BCUPO-193
                    column(FreeDiscTotal; FreeDiscTotal)
                    {
                    }
                    // Bug ID- BCUPO-193
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

                    column(SubTotalCharges; SubTotalCharges)
                    {
                    }
                    column(InCoTerms; "Sales Invoice Header"."InCo Terms FND")
                    {
                    }
                    column(BillOfLadingNo; '')
                    {
                    }
                    column(VesselName; '')
                    {
                    }
                    column(ETD; '')
                    {
                    }
                    column(ETA; '')
                    {
                    }
                    column(AirWayBillNo; '')
                    {
                    }
                    column(CommodityCode; '')
                    {
                    }
                    column(CustomTariffCode; '')
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
                        DataItemTableView = sorting("Document No.", "Line No.")
                                            where(Type = FILTER(Item | Resource | "Fixed Asset" | "Charge (Item)" | "G/L Account"));
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

                            trigger OnAfterGetRecord();
                            begin
                                IF Number = 1 THEN
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
                            SalesInvoiceLine: Record "Sales Invoice Line";
                        begin
                            IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item THEN BEGIN
                                TotalGrossWeight += "Sales Invoice Line"."Gross Weight 1 101FDW"; // BC Upgrade SHUKLP03 ----Drink-IT Field (Weight)
                                TotalNetWeight += "Sales Invoice Line"."Net Weight";
                            end;

                            DiscIncluded := 0;
                            UnitPrice := "Unit Price";
                            LineAmount := "Line Amount";

                            //HEI.10>>
                            IF Type <> Type::"Charge (Item)" THEN BEGIN
                                //Include in Item Price

                                SalesInvoiceLine.RESET();
                                SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                                SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
                                SalesInvoiceLine.SETRANGE("Attached to Line No.", "Line No.");
                                // BC Upgrade BHARDA11 >> ----Drink-IT Fields ("Show Item charge on Invoice")
                                SalesInvoiceLine.SETRANGE("Attached Line Type 101FDW", SalesInvoiceLine."Attached Line Type 101FDW"::"SPC 105FDW");// BC Upgrade SHUKLP03 << Replacement of "Item Charge Type"
                                SalesInvoiceLine.SETRANGE("Show Item charge on Inv. FND", SalesInvoiceLine."Show Item charge on Inv. FND"::"Include in item price");
                                // BC Upgrade BHARDA11 << ----Drink-IT Fields ("Show Item charge on Invoice")
                                IF SalesInvoiceLine.findset() THEN
                                    REPEAT
                                        IF ItemCh.GET(SalesInvoiceLine."No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN BEGIN  //HEI.15
                                            LineAmount += SalesInvoiceLine."Line Amount";
                                            //DiscIncluded += ABS(SalesInvoiceLine."Line Amount");
                                            DiscIncluded += SalesInvoiceLine."Line Amount"; //HEI.12
                                                                                            /*IF SalesInvoiceLine.Quantity > 0 THEN
                                                                                              UnitPrice += SalesInvoiceLine."Unit Price"
                                                                                            else
                                                                                              UnitPrice -= SalesInvoiceLine."Unit Price";*/
                                            IF SalesInvoiceLine.Quantity <> 0 THEN
                                                UnitPrice := LineAmount / ABS(Quantity);
                                        end;   //HEI.15
                                    UNTIL SalesInvoiceLine.NEXT() = 0;
                            end // BC Upgrade SHUKLP03 --- Add (;)
                                // BC Upgrade SHUKLP03 >> ----Drink-IT Fields ("Item Charge Type","Show Item charge on Invoice")

                            else IF ("Sales Invoice Line"."Attached Line Type 101FDW" = "Sales Invoice Line"."Attached Line Type 101FDW"::"SPC 105FDW") AND
                              ("Show Item charge on Inv. FND" = "Show Item charge on Inv. FND"::"Include in item price") THEN
                                IF ItemCh.GET("No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN   //HEI.15
                                    CurrReport.SKIP;
                            // BCUPO-193 >>
                            IF ("Sales Invoice Line"."Attached Line Type 101FDW" = "Sales Invoice Line"."Attached Line Type 101FDW"::"EGM 104FDW") THEN
                                "Sales Invoice Line"."Unit of Measure Code" := '';

                            Var_dis := 0;
                            SIL.Reset();
                            SIL.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                            SIL.SETRANGE(Type, SIL.Type::"Charge (Item)");
                            SIL.SetRange("Attached to Line No.", "Sales Invoice Line"."Line No.");
                            // SIL.SetFilter("Gen. Prod. Posting Group", '%1', 'FREE_VAT');
                            // SIL.SetFilter("VAT Prod. Posting Group", '%1', 'NO_VAT');
                            IF SIL.FINDSET() THEN
                                Repeat
                                    SIL2.Reset();
                                    SIL2.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                                    SIL2.SetRange("Line No.", "Sales Invoice Line"."Line No.");
                                    SIL2.SETRANGE(Type, SIL2.Type::Item);
                                    SIL2.SetRange("Attached to Line No.", 0);
                                    IF SIL2.FINDFIRST() THEN begin
                                        IF ItemCh.GET(SIL."No.") AND Itemch."Hide Item chrg on printout FND" AND (Itemch."Exclude/ Include in Print FND" = Itemch."Exclude/ Include in Print FND"::Free_VAT) AND (SIL."Attached to Line No." = "Sales Invoice Line"."Line No.") THEN // BCUPO-193
                                            "Sales Invoice Line"."VAT %" := 0
                                        else
                                            IF ItemCh.GET(SIL."No.") AND Itemch."Hide Item chrg on printout FND" AND (Itemch."Exclude/ Include in Print FND" = Itemch."Exclude/ Include in Print FND"::Free_DISC) AND (SIL."Attached to Line No." = "Sales Invoice Line"."Line No.") THEN begin // BCUPO-193
                                                var_Dis += ABS(SIL."Line Amount");
                                                LineAmount += SIL."Line Amount";
                                            end;
                                    end;
                                until SIL.NEXT() = 0;
                            // << BCUPO-193
                            // Bug ID- BCUPO-193 >>
                            If ItemCh.GET("No.") AND ItemCh."Hide Item chrg on printout FND" THEN Begin  //HEI.15
                                CurrReport.SKIP;
                            end;
                            // Bug ID- BCUPO-193 <<

                            // BC Upgrade SHUKLP03 << ----Drink-IT Fields ("Item Charge Type","Show Item charge on Invoice")
                            //HEI.10<<

                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;
                            ItemDiscount := 0;
                            itemDeposit := 0;
                            // BC Upgrade SHUKLP03 >> ----Field ("Free Item")
                            IF "Sales Invoice Line"."Line Discount %" = 100 THEN
                                TotalInvDis := "Sales Invoice Line"."Line Discount Amount";
                            // BC Upgrade SHUKLP03 << ---- Field ("Free Item")

                            //HEI.01 >>
                            // BC Upgrade SHUKLP03 >> ----Drink-IT Field("Free Reason Code") and Tables (FreeReasonCode)
                            IF "Sales Invoice Line"."Reason Code 101FDW" <> '' THEN BEGIN
                                FreeReasonCode.RESET;
                                FreeReasonCode.SETRANGE(Code, "Sales Invoice Line"."Reason Code 101FDW");
                                FreeReasonCode.SETRANGE("Allow VAT Calculation FND", TRUE);
                                IF FreeReasonCode.FINDFIRST THEN
                                    "Sales Invoice Line"."VAT %" := 0;
                            end;
                            // BC Upgrade SHUKLP03 << ----Drink-IT Field("Free Reason Code") and Tables (FreeReasonCode)
                            //HEI.01 <<

                            /*IF ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)") AND ("Sales Invoice Line"."Item Charge Type" = "Sales Invoice Line"."Item Charge Type"::Discount) THEN
                              var_Dis := "Sales Invoice Line"."Line Amount"
                            else
                              var_Dis := 0;*/

                            //var_Dis := ABS("Line Discount Amount");
                            // var_Dis := "Line Discount Amount"; //HEI.12   Bug ID- BCUPO-193

                            IF (Type = Type::"Charge (Item)") AND ("Attached Line Type 101FDW" = "Attached Line Type 101FDW"::"SPC 105FDW") THEN // BC Upgrade SHUKLP03 ---- Field("Item Charge Type")
                                IF ItemCh.GET("No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN  //HEI.15
                                                                                                        //var_Dis += ABS("Line Amount");
                                    var_Dis += ABS("Line Amount"); //HEI.12

                            /* //Commented by HEI.10>>
                            IsNotUnderitem := FALSE;
                            SalesChargeLine.RESET;
                            SalesChargeLine.SETRANGE("Document No.","Sales Invoice Line"."Document No.");
                            SalesChargeLine.SETRANGE(Type,"Sales Invoice Line".Type::"Charge (Item)");
                            SalesChargeLine.SETRANGE("Item Charge Type","Sales Invoice Line"."Item Charge Type"::Discount);
                            SalesChargeLine.SETFILTER("Show Item charge on Invoice",'<>%1',SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                            SalesChargeLine.SETRANGE("Attached to Line No.","Sales Invoice Line"."Line No.");
                            IF SalesChargeLine.findset THEN BEGIN
                              IsNotUnderitem:= TRUE;
                            end;

                            //Discounts under item line
                            CLEAR(PrintUnderLineCharge);
                            SalesChargeLine.RESET;
                            SalesChargeLine.SETRANGE("Document No.","Sales Invoice Line"."Document No.");
                            SalesChargeLine.SETRANGE(Type,"Sales Invoice Line".Type::"Charge (Item)");
                            SalesChargeLine.SETRANGE("Item Charge Type","Sales Invoice Line"."Item Charge Type"::Discount);
                            //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                            SalesChargeLine.SETRANGE("Attached to Line No.","Sales Invoice Line"."Line No.");
                            IF SalesChargeLine.findset THEN BEGIN
                              //HEI.06>>
                              //ItemChargeRec.GET(SalesChargeLine."No.");
                              //IF ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Under item line" THEN
                              REPEAT
                                IsDiscount := TRUE;

                                ItemDiscount += SalesChargeLine."Line Amount";
                                SalesChargeLine.CALCSUMS("Line Amount");
                                SubTotalCharges += SalesChargeLine."Line Amount";
                                //TotalSubTotal += SalesChargeLine."Line Amount";
                              UNTIL (SalesChargeLine.NEXT = 0)
                            end;

                            //Deposit under item line
                            IsDeposit := FALSE;
                            CLEAR(PrintUnderLineCharge);
                            SalesChargeLine.RESET;
                            SalesChargeLine.SETRANGE("Document No.","Sales Invoice Line"."Document No.");
                            SalesChargeLine.SETRANGE(Type,"Sales Invoice Line".Type::"Charge (Item)");
                            SalesChargeLine.SETRANGE("Item Charge Type","Sales Invoice Line"."Item Charge Type"::Deposit);
                            //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                            SalesChargeLine.SETRANGE("Attached to Line No.","Sales Invoice Line"."Line No.");
                            IF SalesChargeLine.findset THEN BEGIN
                              //HEI.06>>
                              //ItemChargeRec.GET(SalesChargeLine."No.");
                              //IF ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Under item line" THEN
                              REPEAT

                                itemDeposit += SalesChargeLine."Line Amount";
                                IsDeposit := TRUE;
                                SalesChargeLine.CALCSUMS("Line Amount");
                                SubTotalCharges += SalesChargeLine."Line Amount";
                                //TotalSubTotal += SalesChargeLine."Line Amount";
                              UNTIL (SalesChargeLine.NEXT = 0)
                            end;

                            //Shipping cost under item line
                            CLEAR(PrintUnderLineCharge);
                            SalesChargeLine.RESET;
                            SalesChargeLine.SETRANGE("Document No.","Sales Invoice Line"."Document No.");
                            SalesChargeLine.SETRANGE(Type,"Sales Invoice Line".Type::"Charge (Item)");
                            //SalesChargeLine.SETRANGE("Item Charge Type","Sales Invoice Line"."Item Charge Type"::Discount);
                            //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line"); HEI.06
                            SalesChargeLine.SETRANGE("Attached to Line No.","Sales Invoice Line"."Line No.");
                            IF SalesChargeLine.findset THEN BEGIN
                              //HEI.06>>
                              REPEAT
                                ItemChargeRec.GET(SalesChargeLine."No.");
                              //IF ItemChargeRec."Show Item charge on Invoice" = ItemChargeRec."Show Item charge on Invoice"::"Under item line" THEN
                                IF ItemChargeRec."Item Charge Type" = ItemChargeRec."Item Charge Type"::ShippingCost THEN BEGIN
                                  IF NOT PrintUnderLineCharge THEN
                                    PrintUnderLineCharge := TRUE;

                                  TempUnderChargeLine.INIT;
                                  TempUnderChargeLine := SalesChargeLine;
                                  TempUnderChargeLine.INSERT;

                                  SalesChargeLine.CALCSUMS("Line Amount");
                                  SubTotalCharges += SalesChargeLine."Line Amount";
                                end;
                              UNTIL (SalesChargeLine.NEXT = 0)
                            end;*/  //Commented by HEI.10<<

                        end;
                    }
                    dataitem(SplitVatAmt;
                    Integer)
                    {
                        column(TEMPAccSchedKPIBuffer_VatPercent;
                        FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast"))
                        {
                        }
                        column(TEMPAccSchedKPIBuffer_VatAmount; TEMPAccSchedKPIBuffer."Net Change Budget")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT TEMPAccSchedKPIBuffer.FIND('-') THEN
                                    CurrReport.BREAK();
                            end else
                                IF TEMPAccSchedKPIBuffer.NEXT() = 0 THEN
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
                        Clear(FreeDiscTotal); // Bug ID- BCUPO-193
                        IF NOT ExportInvoice THEN
                            DocumentTitleText := STRSUBSTNO(Text52006, CopyText)
                        else
                            DocumentTitleText := STRSUBSTNO(Text52008, CopyText);
                        // BC Upgrade BHARDA11 >> -- Drink-IT Field (SalesInvLineAmt."Item Charge Type")
                        SalesInvLineAmt.RESET;
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset");  //commented by HEI.15
                        IF SalesInvLineAmt.findset THEN
                            REPEAT
                                IF (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") and (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"G/L Account") THEN  //HEI.15
                                    InvLineTotal += SalesInvLineAmt."Line Amount";

                            UNTIL SalesInvLineAmt.NEXT = 0;
                        // BC Upgrade BHARDA11 << -- Drink-IT Field (SalesInvLineAmt."Item Charge Type")

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;
                        // BC Upgrade SHUKLP03 >> ----Drink-IT Fields ("Item Charge Type","Show Item charge on Invoice")
                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SetFilter(Type, '%1|%2', SalesInvLine.Type::"Charge (Item)", SalesInvLine.Type::"G/L Account");
                        IF SalesInvLine.findset THEN
                            REPEAT
                                CASE SalesInvLine."Attached Line Type 101FDW" OF
                                    SalesInvLine."Attached Line Type 101FDW"::"TAX 102FDW":
                                        TotalFooterAmount[1] += SalesInvLine."Line Amount";
                                    SalesInvLine."Attached Line Type 101FDW"::"EGM 104FDW":
                                        TotalFooterAmount[2] += SalesInvLine."Line Amount";
                                    // SalesInvLine."Item Charge Type"::"Shipping Cost": // BC Upgrade SHUKLP03 <<
                                    //     TotalFooterAmount[3] += SalesInvLine."Line Amount";
                                    SalesInvLine."Attached Line Type 101FDW"::"SPC 105FDW":
                                        //HEI.15>>
                                        BEGIN
                                            // SHUKLP03 >>
                                            IF ItemCh.GET(SalesInvLine."No.") AND ItemCh."Transport/Shipping Cost FND" THEN
                                                TotalFooterAmount[3] += SalesInvLine."Line Amount"
                                            else
                                                //HEI.15<<
                                                IF SalesInvLine."Show Item charge on Inv. FND" <> SalesInvLine."Show Item charge on Inv. FND"::"Include in item price" THEN
                                                    //TotalFooterAmount[4] += ABS(SalesInvLine."Line Amount");
                                                    TotalFooterAmount[4] += SalesInvLine."Line Amount"; //HEI.12
                                                                                                        // SHUKLP03 <<
                                            IF ItemCh.GET(SalesInvLine."No.") AND Itemch."Hide Item chrg on printout FND" AND (Itemch."Exclude/ Include in Print FND" = Itemch."Exclude/ Include in Print FND"::Free_VAT) THEN // BCUPO-193
                                                TotalFooterAmount[4] -= SalesInvLine."Line Amount";  //HEI.15  // BCUPO-193
                                            IF ItemCh.GET(SalesInvLine."No.") AND Itemch."Hide Item chrg on printout FND" AND (Itemch."Exclude/ Include in Print FND" = Itemch."Exclude/ Include in Print FND"::Free_DISC) THEN // BCUPO-193
                                                TotalFooterAmount[6] += abs(SalesInvLine."Line Amount");  //HEI.15  // BCUPO-193

                                        end;  //HEI.15
                                end;
                            UNTIL SalesInvLine.NEXT = 0;
                        //BC Upgrade SHUKLP03 << ----Drink-IT Fields ("Item Charge Type","Show Item charge on Invoice")

                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        ShipAmount := TotalFooterAmount[3];
                        FreeDiscTotal := TotalFooterAmount[6]; // Bug ID- BCUPO-193

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        IF SalesInvLine.findset() THEN
                            REPEAT
                                TotalFooterAmount[4] += ABS(SalesInvLine."Inv. Discount Amount");
                                TotalFooterAmountText[4] := SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                                TotalFooterAmount[5] += ABS(SalesInvLine."Line Discount Amount");
                                TotalFooterAmountText[5] := SalesInvLine.FIELDCAPTION("Line Discount Amount");
                            UNTIL SalesInvLine.NEXT() = 0;

                        InvDisAmount := TotalFooterAmount[4];
                        LineDisAmount := TotalFooterAmount[5];

                        AmttoPaid := InvLineTotal + VATAmount + TaxAmout + ShipAmount - InvDisAmount - LineDisAmount;
                        InvTotalAmount := AmttoPaid + DepAmount;
                    end;
                }

                trigger OnAfterGetRecord();
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
                    clear(FreeDiscTotal); // Bug ID- BCUPO-193
                end;

                trigger OnPostDataItem();
                begin
                    SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies);
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;

                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
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
                //HEI.14>>
                //-----Currency
                IF "Currency Code" <> '' THEN
                    CurrencyCode := "Currency Code"
                else
                    CurrencyCode := GLSetup."LCY Code";

                //-----Footer Texts
                CLEAR(CurrReportID);
                CLEAR(i);
                CLEAR(TextFooter);
                EVALUATE(CurrReportID, COPYSTR(CurrReport.OBJECTID(FALSE), 8));
                // BC Upgrade SHUKLP03 >> ----Drink-IT Table (StandardTextReport)
                StandardTextReport.SETRANGE("Report ID", CurrReportID);
                StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);
                IF StandardTextReport.findset THEN
                    REPEAT
                        i := 1;
                        ExtendedTextHeader.RESET;
                        ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                        ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                        IF ExtendedTextHeader.findset THEN BEGIN
                            REPEAT
                                ExtendedTextLine.RESET;
                                ExtendedTextLine.SETRANGE("Table Name", ExtendedTextHeader."Table Name");
                                ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                                ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                                ExtendedTextLine.SETRANGE("Language Code", "Language Code");
                                IF ExtendedTextHeader."All Language Codes" THEN
                                    ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
                                IF ExtendedTextLine.findset THEN BEGIN
                                    REPEAT
                                        TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                                    UNTIL (ExtendedTextLine.NEXT = 0) OR (i > ARRAYLEN(TextFooter));
                                end;
                                i += 1;
                            UNTIL (ExtendedTextHeader.NEXT = 0);
                        end;
                    UNTIL (StandardTextReport.NEXT = 0);
                // BC Upgrade SHUKLP03 << ----Drink-IT Table  (StandardTextReport)
                //HEI.14<<

                //HEI.05>>
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
                CUSTOMSDOCManage.get();
                IF CUSTOMSDOCManage."Tax Registration No." <> '' THEN
                    CompanyText += ', ' + TaxNoID + ' ' + CUSTOMSDOCManage."Tax Registration No.";
                // BC Upgrade SHUKLP03 << ---- Field ("Tax Registration No.")
                //CompanyText += ', ' + ChOfComm;
                IF CompanyInfo."Phone No." <> '' THEN
                    CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                IF CompanyInfo."Fax No." <> '' THEN
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                /*IF CompanyInfo."E-Mail" <> '' THEN
                  CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";*/  //commented by HEI.14
                                                                                   //HEI.05<<

                IF "Sales Invoice Header"."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" THEN
                    ExportInvoice := TRUE
                else
                    ExportInvoice := FALSE;
                //  BC Upgrade SHUKLP03 >> (DocSubtypeCodeSetup)
                IF "Sales Invoice Header"."Document Subtype Code FND" IN [DocSubtypeCodeSetup."Sundry Sales Order Non Stock", DocSubtypeCodeSetup."Sundry Sales Order Stock"] THEN
                    ExportInvoice := FALSE;
                //  BC Upgrade SHUKLP03 << (DocSubtypeCodeSetup)

                TotalGrossWeight := 0;
                TotalNetWeight := 0;

                TEMPAccSchedKPIBuffer.DELETEALL();
                IF Country.GET(CompanyInfo."Country/Region Code") THEN
                    CompanyInfoContryName := Country.Name;
                // BC Upgrade BHARDA11 >> -- Language table dont have the  GetLanguageID now we use lnguage codeunit to handel this
                // CurrReport.LANGUAGE := Language1.GetLanguageID("Language Code");
                LanguageID := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                CurrReport.Language := LanguageID;
                // BC Upgrade BHARDA11 <<
                IF SalesPerson.GET("Sales Invoice Header"."Salesperson Code") THEN;

                IF ShipmentMethod.GET("Sales Invoice Header"."Shipment Method Code") THEN
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Invoice Header"."Language Code");

                IF PaymentTerms.GET("Payment Terms Code") THEN
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Invoice Header"."Language Code");

                PaymentMethod.RESET();
                IF PaymentMethod.GET("Payment Method Code") THEN;

                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalExText := STRSUBSTNO(Text52001, GLSetup."LCY Code");
                    TotalInText := STRSUBSTNO(Text52002, GLSetup."LCY Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := STRSUBSTNO(Text52005, GLSetup."LCY Code");
                end else BEGIN
                    TotalExText := STRSUBSTNO(Text52001, "Currency Code");
                    TotalInText := STRSUBSTNO(Text52002, "Currency Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, "Currency Code");
                    SubTotalExText := STRSUBSTNO(Text52005, "Currency Code");
                end;


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
                end;

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
                end;

                /*VATEntry.RESET;
                VATEntry.SETRANGE(Type,VATEntry.Type::Sale);
                VATEntry.SETRANGE("Document Type",VATEntry."Document Type"::Invoice);
                VATEntry.SETRANGE("Document No.","Sales Invoice Header"."No.");
                IF VATEntry.findset THEN REPEAT
                  //VatAmt += ABS(VATEntry.Amount);
                  VatAmt += VATEntry.Amount;
                UNTIL VATEntry.NEXT=0;
                VATAmount := ABS(VatAmt);*/



                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                IF SalesInvLine.FINDFIRST() THEN
                    VATPer := SalesInvLine."VAT %";

                IF "Sales Invoice Header"."Prices Including VAT" = TRUE THEN
                    PriceIncVAT := 'Yes'
                else
                    PriceIncVAT := 'No';

                VatAmt := 0;
                lineNumberVAT := 0;  //HEI.08
                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                IF SalesInvLine.findset() THEN
                    REPEAT
                        //HEI.01 >>
                        // BC Upgrade SHUKLP03 >> ---- Drink-IT Table (FreeReasonCode)
                        FreeReasonCode.RESET;
                        FreeReasonCode.SETRANGE(Code, SalesInvLine."Reason Code 101FDW");
                        FreeReasonCode.SETRANGE("Allow VAT Calculation FND", TRUE);
                        IF NOT FreeReasonCode.FINDFIRST THEN
                    // BC Upgrade SHUKLP03 << ---- Drink-IT Table (FreeReasonCode)

                    BEGIN
                            VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            VATAmount := ABS(VatAmt);

                            SIL.RESET();
                            SIL.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                            SIL.SETRANGE(Type, SIL.Type::"Charge (Item)");
                            SIL.SetRange("Attached to Line No.", SalesInvLine."Line No.");
                            SIL.Setfilter("Attached to Line No.", '<>%1', 0);
                            // SIL.SetFilter("Gen. Prod. Posting Group", '%1|%2', 'FREE_VAT', 'FREE_DISC');
                            // SIL.SetFilter("VAT Prod. Posting Group", '%1', 'NO_VAT');
                            IF SIL.FINDSET() THEN
                                Repeat
                                    IF ItemCh.get(SIL."No.") AND ItemCh."Hide Item chrg on printout FND" AND (Itemch."Exclude/ Include in Print FND" = Itemch."Exclude/ Include in Print FND"::Free_VAT) Then
                                        VATAmount += SIL."Line Amount";
                                Until SIL.NEXT() = 0;
                            // BC Upgrade SHUKLP03 << BUG-BCUPO-193- Subtracted the VAT amount for the line with No. = 'FREE_VAT' from the total VAT amount   


                            //HEI.06<<
                            /*
                            //split VAT
                              IF TEMPAccSchedKPIBuffer.GET(SalesInvLine."VAT %") THEN BEGIN
                              TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %")/100;
                              TEMPAccSchedKPIBuffer.MODIFY;

                            end else BEGIN
                              TEMPAccSchedKPIBuffer.INIT;
                              TEMPAccSchedKPIBuffer."No." := SalesInvLine."VAT %";
                              TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount"* SalesInvLine."VAT %")/100;
                              TEMPAccSchedKPIBuffer.INSERT;
                            end;*/
                            //HEI.06>>

                            //HEI.08>>
                            TEMPAccSchedKPIBuffer.RESET();
                            TEMPAccSchedKPIBuffer.SETRANGE("Balance at Date Forecast", SalesInvLine."VAT %");
                            IF TEMPAccSchedKPIBuffer.FINDFIRST() THEN BEGIN
                                TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                                TEMPAccSchedKPIBuffer.MODIFY();
                            end else BEGIN
                                lineNumberVAT += 1;
                                // BC Upgrade SHUKLP03 >> Bug ID- BCUPO-193
                                VATTrue := false;
                                SIL.RESET();
                                SIL.SETRANGE("Document No.", SalesInvLine."Document No.");
                                SIL.SETRANGE(Type, SIL.Type::"Charge (Item)");
                                SIL.SetRange("Attached to Line No.", SalesInvLine."Line No.");
                                SIL.Setfilter("Attached to Line No.", '<>%1', 0);
                                // SIL.SetFilter("No.", '%1', );
                                // SIL.SetFilter("VAT Prod. Posting Group", '%1', 'NO_VAT');
                                IF SIL.FINDSET() THEN
                                    Repeat
                                        IF ItemCh.get(SIL."No.") AND ItemCh."Hide Item chrg on printout FND" AND (ItemCh."Exclude/ Include in Print FND" = ItemCh."Exclude/ Include in Print FND"::Free_VAT) AND (SIL."Attached to Line No." = SalesInvLine."Line No.") THEN Begin
                                            TEMPAccSchedKPIBuffer."Balance at Date Forecast" := 0;
                                            TEMPAccSchedKPIBuffer."Net Change Budget" := 0;
                                            VATTrue := TRUE;
                                            // TEMPAccSchedKPIBuffer.Modify();
                                            // TEMPAccSchedKPIBuffer.Delete();
                                        end;
                                    Until SIL.NEXT() = 0;

                                // ITEMCH.Setrange("No.", SalesInvLine."No.");
                                IF Not VATTrue THEN BEGIN
                                    TEMPAccSchedKPIBuffer.INIT();
                                    TEMPAccSchedKPIBuffer."No." := lineNumberVAT;
                                    TEMPAccSchedKPIBuffer."Balance at Date Forecast" := SalesInvLine."VAT %";
                                    TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                                    TEMPAccSchedKPIBuffer.INSERT();
                                end;
                                // BC Upgrade SHUKLP03 << Bug ID- BCUPO-193
                            end;
                        end;
                    //HEI.01 <<
                    UNTIL SalesInvLine.NEXT() = 0;
                //HEI.08<<

                //HEI.06<<
                //HEI.08<< //decommented the code commented by HEI.06
                TEMPAccSchedKPIBuffer.RESET();
                IF TEMPAccSchedKPIBuffer.findset() THEN
                    REPEAT
                        Counter += 1;
                        // SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."No.") + '%'; //commented by HEI.08
                        SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%'; //HEI.08
                        SplitVatAmount[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Net Change Budget", 0, '<Sign><Integer Thousand><Decimals,3>');
                    UNTIL TEMPAccSchedKPIBuffer.NEXT() = 0;
                //HEI.08>> //decommented the code commented by HEI.06
                //HEI.06>>
                BillToCustomer.GET("Sales Invoice Header"."Bill-to Customer No.");
                SoldToCustomer.GET("Sales Invoice Header"."Sell-to Customer No.");
                IF BillToCountry.GET(BillToCustomer."Country/Region Code") THEN;
                IF SoldToCountry.GET(SoldToCustomer."Country/Region Code") THEN;

                IF "Sales Invoice Header"."No. Printed" = 0 THEN
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
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the NoOfCopies field.';
                        // BC Upgrade BHARDA11                        ToolTip = 'Specifies the value of the NoOfCopies field.';

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
        lblTotalQty = 'Total Quantity'; lblSalesPerson = 'Sales Person ID:'; lblUOM = 'Unit'; lblUnitPrice = 'Unit Price'; lblSaleLAmt = 'Amount Excl. VAT'; lblPageNo = 'Page No:'; lblOrderNo = 'SO Order No:'; lblInvoiceNo = 'Invoice No:'; lblVATAmt = 'Total VAT:'; lblPostDate = 'Invoice Date:'; lblDueDate = 'Due Date:'; lblPriceIncVAT = 'Price Including VAT'; lblDriver = 'Name and Driver Signature'; lblWarehouse = 'Name and Warehouse Keeper Signature'; lblSecurity = 'Name and Security Visa'; label(lblPrintDate; ENU = 'Print Date:',
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      FRA = 'Date d''impression')
        LblBillToAddress = 'BILL TO:'; LblCustomerName = 'Customer Name:'; LblAddress = 'Address 1:'; LblAddress2 = 'Address 2:'; LblPostCode = 'Post Code:'; LblCity = 'City:'; LblCountry = 'Country:'; LblVatRegistrationNo = 'Vat Registration No:'; LblCompanyTaxId = 'Company Tax ID:'; LblSoldToAddress = 'CUSTOMER:'; LblCustomerPoNo = 'Customer PO No:'; LblTaxDetails = 'Tax Summary'; LblBankInfo = 'Bank Details:'; LblAccountNo = 'Account No:'; LblBankName = 'Bank:'; LblGiro = 'Giro No.'; LblIban = 'Iban:'; LblSwiftCode = 'Swift Code:'; LblSignature = 'Signature:'; LblVatPercent = 'Vat Percent'; LblVatAmount = 'Vat Amount'; LblIncoTerm = 'InCo Terms:'; Lbldisc = 'Disc.'; LblShipToAddress = 'SHIP TO ADDRESS:'; LblCustomerNo = 'Customer No:'; LblInvoiceCurrency = 'Invoice Currency:'; LblVersion = 'Version:'; LblItemNo = 'Item No.'; LblQty = 'Qty'; LblPayMethod = 'Payment Method:'; LblInvoiceCurrLCY = 'Invoice Curr LCY:'; LblTotalToBePaid = 'Total to be paid:'; LblDiscTotal = 'Disc Total:'; GrossWeightLbl = 'Gross Weight:'; NetWeightLbl = 'Net Weight:'; BillOfLadingNoLbl = 'Bill Of Lading No:'; VesselNameLbl = 'Vessel Name:'; ETDLbl = 'ETD:'; ETALbl = 'ETA:'; AirWayBillNoLbl = 'Air Way Bill No:'; CommodityCodeLbl = 'Commodity Code:'; CustomTariffCodeLbl = 'Custom Tariff Code:'; BankInfo2Lbl = 'Bank Details 2:'; BankInfo3Lbl = 'Bank Details 3:'; BankInfo4Lbl = 'Bank Details 4:'; CustomerServiceEmailLbl = 'Customer Service E-Mail:';
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        SalesSetup.GET();  //HEI.14
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND");  //HEI.04
        GeneralOpCoSetup.GET();
        DocSubtypeCodeSetup.GET(); // BC Upgrade SHUKLP03 <<
    end;

    var
        TEMPAccSchedKPIBuffer: Record "Acc. Sched. KPI Buffer";
        SIL: Record "Sales Invoice Line";
        FreeDiscTotal: Decimal;
        VATTrue: Boolean;
        SIL2: Record "Sales Invoice Line";
        FreeVAT_Amount: Decimal;
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
        Language1: Record Language;
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvLineAmt: Record "Sales Invoice Line";
        TempUnderChargeLine: Record "Sales Invoice Line" temporary;
        SalesPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        LanguageMgt: Codeunit Language; // BC Upgrade BHARDA11
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
        LanguageID: Integer; // BC Upgrade BHARDA11
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
        Text52006: Label 'Sales Invoice';
        Text52007: Label 'Sundry Invoice';
        Text52008: Label 'Export Invoice';
        ItemCharge: Option " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        DisplayTitleHeaderType: Option Confirmation,Proforma;
        CompanyInfoContryName: Text;
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND"; // BC Upgrade SHUKLP03
        CompanyText: Text;
        OriginalCopy: Text;
        SplitVatAmount: array[10] of Text;
        SplitVatPercent: array[10] of Text;
        StandardTextReport: Record "Standard Text Report FND";  // BC Upgrade SHUKLP03 ----  Table
        TextFooter: array[3] of Text;
        CUSTOMSDOCManage: Record CustomsDocMgtSetup113FDW; // BC Upgrade SHUKLP03 <<
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
        Text52003: TextConst ENU = 'VAT @ %1 ', FRA = 'TVA @ %1';
        FreeReasonCode: Record "Reason Code"; // BC Upgrade SHUKLP03 ---- Drink-IT Table
}

