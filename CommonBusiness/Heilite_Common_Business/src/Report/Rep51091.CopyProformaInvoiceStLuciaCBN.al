report 51091 "Copy Proforma Inv StLucia CBN"
{
    // version HEI.01
    // HEI.01 CHG2151289 HB2805 IBM BHANDS01 09.05.2022 # St Lucia Invoice layout adjustment for VAT on Free
    //   # Copy of Report 50279 "Proforma Invoice STD" created for St. Lucia
    //   # Code added to remove VAT % and VAT Amount for Free Items
    // BC Upgrade BHARDA11 >>
    // Migration from NAV 2018 to Business Central 26
    // Changes:
    // 1. Added ApplicationArea = All and UsageCategory = ReportsAndAnalysis
    // 2. Added proper RDLC layout path
    // 3. Replaced Language.GetLanguageID with Language codeunit method
    // 4. Add ApplicationAreal property in Fields (NoOfCopies)
    // 5. Commented out Drink IT custom fields and tables
    // Drink IT Custom Objects Commented:
    // - Sales Line."Order No." (field)
    // - Sales Line."Item Charge Type" (field)
    // - Sales Line."Show Item charge on Inv. FND" (field)
    // - Sales Line."Free Reason Code" (field)
    // - Company Information."Tax Registration No." (field)
    // Language Handling:
    // - Old: CurrReport.LANGUAGE := Language1.GetLanguageID("Language Code");
    // - New: LanguageID := LanguageMgt.GetLanguageIdOrDefault("Language Code");
    //        CurrReport.Language := LanguageID;
    // BC Upgrade BHARDA11 <<
    // BC UPGRADE KUMARR78 >>
    // FDD-MTC-008
    // Report 51091 "Copy Proforma Inv StLucia CBN"
    // Migration Changes from NAV 2018 to Business Central 26
    //
    // Changes Done:
    //
    // 1. Replaced Drink-IT custom field logic "Item Charge Type"
    //    Old Logic:
    //    - SalesInvoiceLine."Item Charge Type"::Discount
    //    New Logic:
    //    - SalesInvoiceLine."Attached Line Type 101FDW"::"SPC 105FDW"
    //
    // 2. Retained and reused field "Show Item charge on Inv. FND"
    //    for Include in item price functionality.
    //
    // 3. Added filtering logic for Item Charges using:
    //    - "Attached Line Type 101FDW"
    //    - "Show Item charge on Inv. FND"
    //
    // 4. Added logic to include Item Charge amount inside Item Price:
    //    - Line Amount updated with attached charge amount
    //    - Unit Price recalculated after Item Charge inclusion
    //
    // 5. Added CurrReport.SKIP logic:
    //    - Prevent duplicate printing of Charge Item lines
    //    - Skip lines when:
    //         Attached Line Type = "SPC 105FDW"
    //         AND Show Item charge on Invoice = "Include in item price"
    //
    // 6. Replaced old subtotal calculation logic:
    //    Old:
    //    - Included all non Charge Item lines
    //    New:
    //    - Excludes:
    //         a. Charge (Item)
    //         b. G/L Account
    //    from InvLineTotal calculation.
    //
    // 7. Added footer calculation handling using
    //    "Attached Line Type 101FDW":
    //
    //    Mapping:
    //    - "TAX 102FDW"  -> Excise Duties
    //    - "EGM 104FDW"  -> Deposit Amount
    //    - "SPC 105FDW"  -> Shipping / Discount Charges
    //
    // 8. Added Shipping Charge handling logic:
    //    - Item Charge identified using:
    //         ItemCh."Transport/Shipping Cost"
    //
    // 9. Added separate Discount calculation logic:
    //    - Discounts added only when:
    //         Show Item charge on Invoice <>
    //         "Include in item price"
    //
    // 10. Replaced deprecated Drink-IT table:
    //     Old:
    //     - Record "2014410"
    //
    //     New:
    //     - Record "Standard Text Report"
    //
    //     Purpose:
    //     - Footer text retrieval
    //     - Standard report text handling
    //
    // 11. Replaced CompanyInfo Tax Registration source:
    //     Old:
    //     - CompanyInfo."Tax Registration No."
    //
    //     New:
    //     - RecCustomerDocuMgtSetup."Tax Registration No."
    //
    //     New Table Used:
    //     - CustomsDocMgtSetup113FDW
    //
    // 12. Replaced deprecated Free Reason Code logic:
    //     Old:
    //     - "Free Reason Code"
    //     - Record "2013788"
    //
    //     New:
    //     - "Reason Code 101FDW"
    //     - Record "Reason Code"
    // New Objects:
    // - "Attached Line Type 101FDW"
    // - "Reason Code 101FDW"
    // - "Standard Text Report"
    // - CustomsDocMgtSetup113FDW
    // BC UPGRADE KUMARR78 <<
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Copy Proforma Invoice StLucia.rdl'; // BC Upgrade BHARDA11 -- Add Path

    Caption = 'Proforma Invoice STD';
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;
    ApplicationArea = All; // BC Upgrade BHARDA11
    UsageCategory = ReportsAndAnalysis; // BC Upgrade BHARDA11

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.")
                                where("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeadingML = ENU = 'Proforma Invoice',
                                     FRA = 'Proforma commande vente';
            column(SalesHDocNo; "Sales Header"."No.")
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
            column(CompanyInfo_OpCoFooterImage; CompanyInfo."OpCo Footer image FND")
            {
            }
            column(CompanyText; CompanyText)
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
                    column(Proforma_InvoiceNo; "Sales Header"."Posting No.")
                    {
                    }
                    column(CustomerAttributestext; CustomerAttributestext)
                    {
                    }
                    column(OrderConfirmCopyCaption; DocumentTitleText)
                    {
                    }
                    column(SalesHCustNo; "Sales Header"."Bill-to Customer No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SalesHPostDate; FORMAT("Sales Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesHDueDate; FORMAT("Sales Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesHDocDate; FORMAT("Sales Header"."Document Date", 0, 4))
                    {
                    }
                    column(SalesHIncVAT; PriceIncVAT)
                    {
                    }
                    column(SalesHSalesPerName; SalesPerson.Name)
                    {
                    }
                    column(SalesPersonCode; "Sales Header"."Salesperson Code")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field "Order No."
                    // column(SalesHOrdNo; "Sales Header"."Order No.")
                    // {
                    // }
                    column(SalesHOrdNo; '')
                    {
                    }
                    // BC Upgrade BHARDA11 <<   ----Drink-IT Field "Order No."

                    column(SalesHReference; "Sales Header"."Your Reference")
                    {
                    }
                    column(SalesHExtRefNo; "Sales Header"."External Document No.")
                    {
                    }
                    column(SalesHVATRegNo; "Sales Header"."VAT Registration No.")
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
                    column(SalesInvHeader_BillToName; "Sales Header"."Bill-to Name")
                    {
                    }
                    column(SalesInvHeader_BillToPostCode; "Sales Header"."Bill-to Post Code")
                    {
                    }
                    column(SalesInvHeader_BillToCity; "Sales Header"."Bill-to City")
                    {
                    }
                    column(BillToVatRegNo; BillToCustomer."VAT Registration No.")
                    {
                    }
                    column(BillToCountryName; BillToCountry.Name)
                    {
                    }
                    column(SalesInvHeader_SellToName; "Sales Header"."Sell-to Customer Name")
                    {
                    }
                    column(SalesInvHeader_SellToCity; "Sales Header"."Sell-to City")
                    {
                    }
                    column(SalesInvHeader_SellToPostCode; "Sales Header"."Sell-to Post Code")
                    {
                    }
                    column(SellToCountryName; SoldToCountry.Name)
                    {
                    }
                    column(SellToVatRegNo; SoldToCustomer."VAT Registration No.")
                    {
                    }
                    column(SalesInvHeader_BillToAddress; "Sales Header"."Bill-to Address")
                    {
                    }
                    column(SalesInvHeader_BillToAddress2; "Sales Header"."Bill-to Address 2")
                    {
                    }
                    column(SalesInvHeader_SellToAddress; "Sales Header"."Sell-to Address")
                    {
                    }
                    column(SalesInvHeader_SellToAddress2; "Sales Header"."Sell-to Address 2")
                    {
                    }
                    column(SalesInvHeader_ShipToName; "Sales Header"."Ship-to Name")
                    {
                    }
                    column(SalesInvHeader_Address; "Sales Header"."Ship-to Address")
                    {
                    }
                    column(SalesInvHeader_Address2; "Sales Header"."Ship-to Address 2")
                    {
                    }
                    column(SalesInvHeader_City; "Sales Header"."Ship-to City")
                    {
                    }
                    column(SellCustomerNo; "Sales Header"."Sell-to Customer No.")
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
                    column(InCoTerms; "Sales Header"."InCo Terms FND")
                    {
                    }
                    column(ItemChargeDisc; ItemChargeDisc)
                    {
                    }
                    column(InvDisAmount; InvDisAmount)
                    {
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.")
                                            where(Type = FILTER(Item | Resource | "Fixed Asset" |
                                            "Charge (Item)" | "G/L Account"));
                        column(SalesLType; "Sales Line".Type)
                        {
                        }
                        column(SalesItem; "Sales Line"."No.")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesDescrip; "Sales Line".Description)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesQty; "Sales Line".Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesUOM; "Sales Line"."Unit of Measure Code")
                        {
                        }
                        column(SalesPrice; ROUND("Sales Line"."Unit Price", 0.01, '='))
                        {
                        }
                        column(SalesVATPer; "Sales Line"."VAT %")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesAmount; "Sales Line".Quantity * "Sales Line"."Unit Price")
                        {
                        }
                        column(TotalQuantity; TotalQty)
                        {
                        }
                        column(SalesDiscount; "Sales Line"."Line Discount Amount")
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

                        trigger OnAfterGetRecord();
                        var
                            SalesInvoiceLine: Record "Sales Line";
                        begin
                            //HEI.07>>
                            DiscIncluded := 0;
                            var_Dis := 0;//BC UPGRDAE KUMARR78 ++
                            UnitPrice := "Unit Price";
                            LineAmount := "Line Amount";

                            IF Type <> Type::"Charge (Item)" THEN BEGIN
                                //Include in Item Price
                                SalesInvoiceLine.RESET();
                                SalesInvoiceLine.SETRANGE("Document Type", "Document Type");
                                SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                                SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
                                SalesInvoiceLine.SETRANGE("Attached to Line No.", "Line No.");
                                // BC Upgrade BHARDA11 >> ----Drink-IT Fields ("Item Charge Type","Show Item charge on Inv. FND")
                                // SalesInvoiceLine.SETRANGE("Item Charge Type", SalesInvoiceLine."Item Charge Type"::Discount);
                                // SalesInvoiceLine.SETRANGE("Show Item charge on Inv. FND", SalesInvoiceLine."Show Item charge on Inv. FND"::"Include in item price");
                                // BC Upgrade BHARDA11 << ----Drink-IT Fields ("Item Charge Type","Show Item charge on Inv. FND")
                                //BC UPGRADE KUMARR78 FDD-MTC-008 >> 
                                SalesInvoiceLine.SETRANGE("Attached Line Type 101FDW", SalesInvoiceLine."Attached Line Type 101FDW"::"SPC 105FDW");
                                SalesInvoiceLine.SETRANGE("Show Item charge on Inv. FND", SalesInvoiceLine."Show Item charge on Inv. FND"::"Include in item price");
                                //BC UPGRADE KUMARR78 FDD-MTC-008 <<
                                IF SalesInvoiceLine.findset() THEN
                                    REPEAT
                                        IF ItemCh.GET(SalesInvoiceLine."No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN BEGIN  //HEI.11
                                            LineAmount += SalesInvoiceLine."Line Amount";
                                            //DiscIncluded += ABS(SalesInvoiceLine."Line Amount");
                                            DiscIncluded += SalesInvoiceLine."Line Amount"; //HEI.09
                                            IF SalesInvoiceLine.Quantity <> 0 THEN
                                                UnitPrice := LineAmount / ABS(Quantity);
                                        end //HEI.11
                                    UNTIL SalesInvoiceLine.NEXT() = 0;
                            end
                            else IF ("Attached Line Type 101FDW" = "Attached Line Type 101FDW"::"SPC 105FDW") AND
                              ("Show Item charge on Inv. FND" = "Show Item charge on Inv. FND"::"Include in item price") THEN
                                IF ItemCh.GET("No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN   //HEI.11
                                    CurrReport.SKIP;

                            //HEI.07<<

                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;

                            TotalInvDis += ABS("Sales Line"."Line Discount Amount");

                            //var_Dis := ABS("Line Discount Amount");
                            var_Dis := "Line Discount Amount"; //HEI.09

                            // IF (Type = Type::"Charge (Item)") AND ("Item Charge Type" = "Item Charge Type"::Discount) THEN // BC Upgrade BHARDA11 ----Drink-It Field ("Item Charge Type")

                            IF (Type = Type::"Charge (Item)") AND ("Attached Line Type 101FDW" = "Attached Line Type 101FDW"::"SPC 105FDW") THEN // BC Upgrade KUMARR78 FDD-MTC-008

                            IF ItemCh.GET("No.") AND NOT ItemCh."Transport/Shipping Cost FND" THEN  //HEI.11
                                                                                                    //var_Dis += ABS("Line Amount");
                                    var_Dis += "Line Amount"; //HEI.09

                            //HEI.01 >>
                            // BC Upgrade BHARDA11 >> ----Drink-IT Field and Table("Free Reason Code",FreeReasonCode)
                            // IF "Sales Line"."Free Reason Code" <> '' THEN BEGIN
                            //     FreeReasonCode.RESET;
                            //     FreeReasonCode.SETRANGE(Code, "Sales Line"."Free Reason Code");
                            //     FreeReasonCode.SETRANGE("Allow VAT Calculation", TRUE);
                            //     IF FreeReasonCode.FINDFIRST THEN
                            //         "Sales Line"."VAT %" := 0;
                            // end;
                            // BC Upgrade BHARDA11 << ----Drink-IT Field and Table("Free Reason Code",FreeReasonCode)

                            // BC UPGRADE KUMARR78 FDD-MTC-008 >> Replacing "Free Reason Code" withh "Reason Code 101FDW"
                            // IF "Sales Line"."Reason Code 101FDW" <> '' THEN BEGIN
                            //     FreeReasonCode.RESET;
                            //     FreeReasonCode.SETRANGE(Code, "Sales Line"."Reason Code 101FDW");
                            // FreeReasonCode.SETRANGE("Allow VAT Calculation", TRUE); //BC UPGRADE KUMARR78 FDD-MTC-008 No field found in Reason Code Table
                            // IF FreeReasonCode.FINDFIRST THEN
                            //     "Sales Line"."VAT %" := 0;
                            // end;
                            //  BC UPGRADE KUMARR78 FDD-MTC-008 << Replacing "Free Reason Code" withh "Reason Code 101FDW"

                            //HEI.01 <<
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
                        CLEAR(ItemChargeDisc);  //HEI.07

                        DocumentTitleText := STRSUBSTNO(Text52006, CopyText);
                        // BC Upgrade BHARDA11 >> ----Drink-IT Fields ("Item Charge Type")
                        // SalesInvLineAmt.RESET;
                        // SalesInvLineAmt.SETRANGE("Document Type", "Sales Header"."Document Type");
                        // SalesInvLineAmt.SETRANGE("Document No.", "Sales Header"."No.");
                        // //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3|%4',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset",SalesInvLineAmt.Type::"G/L Account");  //commented by HEI.11
                        // IF SalesInvLineAmt.findset THEN
                        //     REPEAT
                        //         IF (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") OR (SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::" ") THEN  //HEI.11
                        //             InvLineTotal += SalesInvLineAmt."Line Amount";
                        //     UNTIL SalesInvLineAmt.NEXT = 0;
                        // BC Upgrade BHARDA11 << ----Drink-IT Fields ("Item Charge Type")
                        // BC Upgrade KUMARR78 FDD-MTC-008 >> Adding
                        SalesInvLineAmt.RESET;
                        SalesInvLineAmt.SETRANGE("Document Type", "Sales Header"."Document Type");
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Header"."No.");
                        //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3|%4',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset",SalesInvLineAmt.Type::"G/L Account");  //commented by HEI.11
                        IF SalesInvLineAmt.findset THEN
                            REPEAT
                                IF (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") and (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"G/L Account") THEN  //HEI.11
                                    InvLineTotal += SalesInvLineAmt."Line Amount";
                            UNTIL SalesInvLineAmt.NEXT = 0;
                        // BC Upgrade KUMARR78 FDD-MTC-008 << Adding
                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document Type", "Sales Header"."Document Type");
                        SalesInvLine.SETRANGE("Document No.", "Sales Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"G/L Account");
                        IF SalesInvLine.findset() THEN
                            REPEAT
                                CASE SalesInvLine."Attached Line Type 101FDW" OF
                                    SalesInvLine."Attached Line Type 101FDW"::"TAX 102FDW":
                                        TotalFooterAmount[1] += SalesInvLine."Line Amount";
                                    SalesInvLine."Attached Line Type 101FDW"::"EGM 104FDW":
                                        TotalFooterAmount[2] += SalesInvLine."Line Amount";
                                    //BC UPGRADE KUMARR78 FDD-MTC-008 >>
                                    // SalesInvLine."Attached Line Type 101FDW"::ShippingCost:
                                    //     TotalFooterAmount[3] += SalesInvLine."Line Amount";
                                    //BC UPGRADE KUMARR78 FDD-MTC-008 <<

                                    SalesInvLine."Attached Line Type 101FDW"::"SPC 105FDW":
                                        //HEI.11>>
                                        BEGIN
                                            IF ItemCh.GET(SalesInvLine."No.") AND ItemCh."Transport/Shipping Cost FND" THEN
                                                TotalFooterAmount[3] += SalesInvLine."Line Amount"

                                            else
                                                //HEI.11<<
                                                IF SalesInvLine."Show Item charge on Inv. FND" <> SalesInvLine."Show Item charge on Inv. FND"::"Include in item price" THEN
                                                    //TotalFooterAmount[4] += ABS(SalesInvLine."Line Amount");
                                                    TotalFooterAmount[4] += SalesInvLine."Line Amount"; //HEI.09
                                            //BC UPGRADE KUMARR78 FDD-MTC-008<<
                                        end  //HEI.11
                                end;
                            UNTIL SalesInvLine.NEXT() = 0;

                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        ShipAmount := TotalFooterAmount[3];  //HEI.07

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document Type", "Sales Header"."Document Type");
                        SalesInvLine.SETRANGE("Document No.", "Sales Header"."No.");
                        //SalesInvLine.SETRANGE(Type,SalesInvLine.Type::"Charge (Item)");  //commented by HEI.07
                        IF SalesInvLine.findset() THEN
                            REPEAT
                                TotalFooterAmount[4] += ABS(SalesInvLine."Inv. Discount Amount");
                                TotalFooterAmountText[4] := SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                                TotalFooterAmount[5] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[5] := SalesInvLine.FIELDCAPTION("Line Discount Amount");
                            UNTIL SalesInvLine.NEXT() = 0;

                        InvDisAmount := TotalFooterAmount[4];
                        LineDisAmount := TotalFooterAmount[5];

                        //AmttoPaid := InvLineTotal+VatAmt+TotalFooterAmount[1]+VatAmt+TotalFooterAmount[3]-VatAmt+TotalFooterAmount[4];
                        AmttoPaid := InvLineTotal + VatAmt + TotalFooterAmount[1] + VatAmt + TotalFooterAmount[5] + TotalFooterAmount[6] - VatAmt + TotalFooterAmount[4];
                        InvTotalAmount := AmttoPaid + TotalFooterAmount[2];

                        AmttoPaid := InvLineTotal + VATAmount + TaxAmout + ShipAmount - InvDisAmount - LineDisAmount;
                        InvTotalAmount := AmttoPaid + DepAmount;

                        //Amount in letters
                        /*  //commented by HEI.07>>
                        Check.InitTextVariable;
                        IF "Sales Header"."Prices Including VAT" THEN
                          Check.FormatNoText(DescriptionLine,ROUND(DepAmount + ROUND(InvLineTotal,1,'=') + TaxAmout ,0.01,'='),"Sales Header"."Currency Code")
                        else
                          Check.FormatNoText(DescriptionLine,ROUND(ROUND(InvLineTotal,1,'=') + VATAmount + TaxAmout + DepAmount + ShipAmount,0.01,'='),"Sales Header"."Currency Code");
                        */ //commented by HEI.07<<

                        Check.FormatNoText(DescriptionLine, "Sales Header"."Amount Including VAT", "Sales Header"."Currency Code"); //HEI.07

                        DescriptionLine[1] := COPYSTR(DescriptionLine[1], 6);

                        IF DescriptionLine[2] <> '' THEN
                            DescriptionLine[2] += ' ONLY'
                        else
                            DescriptionLine[1] += ' ONLY';

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
                    CLEAR(ItemChargeDisc);  //HEI.07
                end;

                trigger OnPostDataItem();
                begin
                    SalesInvCountPrinted.RUN("Sales Header");
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
                //HEI.10>>
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
                // BC Upgrade BHARDA11 >> ----Drink-IT Table (StandardTextReport)
                // StandardTextReport.SETRANGE("Report ID", CurrReportID);
                // StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);
                // IF StandardTextReport.findset THEN
                //     REPEAT
                //         i := 1;
                //         ExtendedTextHeader.RESET;
                //         ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                //         ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                //         IF ExtendedTextHeader.findset THEN BEGIN
                //             REPEAT
                //                 ExtendedTextLine.RESET;
                //                 ExtendedTextLine.SETRANGE("Table Name", ExtendedTextHeader."Table Name");
                //                 ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                //                 ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                //                 ExtendedTextLine.SETRANGE("Language Code", "Language Code");
                //                 IF ExtendedTextHeader."All Language Codes" THEN
                //                     ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
                //                 IF ExtendedTextLine.findset THEN BEGIN
                //                     REPEAT
                //                         TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                //                     UNTIL (ExtendedTextLine.NEXT = 0) OR (i > ARRAYLEN(TextFooter));
                //                 end;
                //                 i += 1;
                //             UNTIL (ExtendedTextHeader.NEXT = 0);
                //         end;
                //     UNTIL (StandardTextReport.NEXT = 0);
                // BC Upgrade BHARDA11 << ---- Drink-IT Table (StandardTextReport)
                //HEI.10<<

                //BC UPGRADE KUMARR78 FDD-MTC-008 >> Adding
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
                //BC UPGRADE KUMARR78 FDD-MTC-008 << Adding

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
                // BC Upgrade BHARDA11 >> ----Drink_IT Field ("Tax Registration No.")
                // IF CompanyInfo."Tax Registration No." <> '' THEN
                //     CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                // BC Upgrade BHARDA11 << ----Drink_IT Field ("Tax Registration No.")

                // BC UPGRADE KUMARR78 FDD-MTC-008 >> Adding and Replacing CompanyInfo Table with RecCustomerDocuMgtSetup
                IF RecCustomerDocuMgtSetup."Tax Registration No." <> '' THEN
                    CompanyText += ', ' + TaxNoID + ' ' + RecCustomerDocuMgtSetup."Tax Registration No.";
                // BC UPGRADE KUMARR78 FDD-MTC-008 << Adding and Replacing CompanyInfo Table with RecCustomerDocuMgtSetup

                //CompanyText += ', ' + ChOfComm;
                IF CompanyInfo."Phone No." <> '' THEN
                    CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                IF CompanyInfo."Fax No." <> '' THEN
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                /*IF CompanyInfo."E-Mail" <> '' THEN
                  CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";*/ //commented by HEI.10
                                                                                  //HEI.05<<

                TEMPAccSchedKPIBuffer.DELETEALL();
                IF Country.GET(CompanyInfo."Country/Region Code") THEN
                    CompanyInfoContryName := Country.Name;
                // BC Upgrade BHARDA11 >> -- Language table dont have the  GetLanguageID now we use lnguage codeunit to handel this
                // CurrReport.LANGUAGE := Language1.GetLanguageID("Language Code");
                LanguageID := LanguageMgt.GetLanguageIdOrDefault("Language Code");
                CurrReport.Language := LanguageID;
                // BC Upgrade BHARDA11 <<

                IF SalesPerson.GET("Sales Header"."Salesperson Code") THEN;

                IF ShipmentMethod.GET("Sales Header"."Shipment Method Code") THEN
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Header"."Language Code");

                IF PaymentTerms.GET("Payment Terms Code") THEN
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Header"."Language Code");

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
                IF Customer.GET("Sales Header"."Bill-to Customer No.") THEN BEGIN
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
                IF CustomerAttributes.GET("Sales Header"."Bill-to Customer No.") THEN BEGIN
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
                SalesInvLine.SETRANGE("Document Type", "Sales Header"."Document Type");
                SalesInvLine.SETRANGE("Document No.", "Sales Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                IF SalesInvLine.FINDFIRST() THEN
                    VATPer := SalesInvLine."VAT %";

                IF "Sales Header"."Prices Including VAT" = TRUE THEN
                    PriceIncVAT := 'Yes'
                else
                    PriceIncVAT := 'No';

                VatAmt := 0;
                lineNumberVAT := 0;  //HEI.06
                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document Type", "Sales Header"."Document Type");
                SalesInvLine.SETRANGE("Document No.", "Sales Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                IF SalesInvLine.findset() THEN
                    REPEAT
                        //HEI.01 >>
                        // BC Upgrade BHARDA11 >> ---- Drink-IT Table (FreeReasonCode)
                        // FreeReasonCode.RESET;
                        // FreeReasonCode.SETRANGE(Code, SalesInvLine."Free Reason Code");
                        // FreeReasonCode.SETRANGE("Allow VAT Calculation", TRUE);
                        // IF NOT FreeReasonCode.FINDFIRST THEN 
                        // BC Upgrade BHARDA11 << ---- Drink-IT Table (FreeReasonCode)


                        VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                        VATAmount := ABS(VatAmt);

                        //split VAT
                        //IF TEMPAccSchedKPIBuffer.GET(SalesInvLine."VAT %") THEN BEGIN  //commented by HEI.06
                        //HEI.06>>
                        TEMPAccSchedKPIBuffer.RESET();
                        TEMPAccSchedKPIBuffer.SETRANGE("Balance at Date Forecast", SalesInvLine."VAT %");
                        IF TEMPAccSchedKPIBuffer.FINDFIRST() THEN BEGIN
                            //HEI.06<<
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.MODIFY();
                        end else BEGIN
                            //TEMPAccSchedKPIBuffer."No." := SalesInvLine."VAT %";   //commented by HEI.06
                            //HEI.06>>
                            lineNumberVAT += 1;
                            TEMPAccSchedKPIBuffer.INIT();
                            TEMPAccSchedKPIBuffer."No." := lineNumberVAT;
                            TEMPAccSchedKPIBuffer."Balance at Date Forecast" := SalesInvLine."VAT %";
                            //HEI.06<<
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.INSERT();

                        end;     //HEI.01 >>
                    UNTIL SalesInvLine.NEXT() = 0;

                TEMPAccSchedKPIBuffer.RESET();
                IF TEMPAccSchedKPIBuffer.findset() THEN
                    REPEAT
                        Counter += 1;
                        //SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."No.") + '%'; //commented HEI.06
                        SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%'; //HEI.06
                        SplitVatAmount[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Net Change Budget", 0, '<Sign><Integer Thousand><Decimals,3>');
                    UNTIL TEMPAccSchedKPIBuffer.NEXT() = 0;

                BillToCustomer.GET("Sales Header"."Bill-to Customer No.");
                SoldToCustomer.GET("Sales Header"."Sell-to Customer No.");
                IF BillToCountry.GET(BillToCustomer."Country/Region Code") THEN;
                IF SoldToCountry.GET(SoldToCustomer."Country/Region Code") THEN;

                IF "Sales Header"."No. Printed" = 0 THEN
                    OriginalCopy := Text50004
                else
                    OriginalCopy := Text52000;

                "Sales Header".CALCFIELDS("Amount Including VAT");
                TotalAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(TODAY, "Sales Header"."Currency Code", "Sales Header"."Amount Including VAT", CurrExchRate.ExchangeRate(TODAY, "Sales Header"."Currency Code"));

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
                          FRA = 'Conditions Paiement')
        label(lblShipMethod; ENU = 'Shipment Method',
                            FRA = 'Condition de Livraison')
        label(lblAmtPaid; ENU = 'Subtotal incl. VAT:',
                         FRA = 'Montant A Payer')
        label(lblSalesCondition; ENU = 'The Sale Conditions on the back side',
                                FRA = 'Conditions generales de vento ou envers')
        lblTotalQty = 'Total Quantity'; lblSalesPerson = 'Sales Person ID:'; lblUOM = 'Unit'; lblUnitPrice = 'Unit Price'; lblSaleLAmt = 'Amount Excl. VAT'; lblPageNo = 'Page No:'; lblOrderNo = 'SO Order No:'; lblInvoiceNo = 'Invoice No:'; lblVATAmt = 'Total VAT:'; lblPostDate = 'Invoice Date:'; lblDueDate = 'Due Date:'; lblPriceIncVAT = 'Price Including VAT'; lblDriver = 'Name and Driver Signature'; lblWarehouse = 'Name and Warehouse Keeper Signature'; lblSecurity = 'Name and Security Visa'; label(lblPrintDate; ENU = 'Print Date:',
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      FRA = 'Date d''impression')
        LblBillToAddress = 'BILL TO:'; LblCustomerName = 'Customer Name:'; LblAddress = 'Address 1:'; LblAddress2 = 'Address 2:'; LblPostCode = 'Post Code:'; LblCity = 'City:'; LblCountry = 'Country:'; LblVatRegistrationNo = 'Vat Registration No:'; LblCompanyTaxId = 'Company Tax ID:'; LblSoldToAddress = 'CUSTOMER:'; LblCustomerPoNo = 'Customer PO No:'; LblTaxDetails = 'Tax Summary'; LblBankInfo = 'Bank Details:'; LblAccountNo = 'Account No:'; LblBankName = 'Bank:'; LblGiro = 'Giro No.'; LblIban = 'Iban:'; LblSwiftCode = 'Swift Code:'; LblSignature = 'Signature:'; LblVatPercent = 'Vat Percent'; LblVatAmount = 'Vat Amount'; LblIncoTerm = 'InCo Terms:'; Lbldisc = 'Disc.'; LblShipToAddress = 'SHIP TO ADDRESS:'; LblCustomerNo = 'Customer No:'; LblInvoiceCurrency = 'Invoice Currency:'; LblVersion = 'Version:'; LblItemNo = 'Item No.'; LblQty = 'Qty'; LblPayMethod = 'Payment Method:'; LblInvoiceCurrLCY = 'Invoice Curr LCY:'; LblTotalToBePaid = 'Total to be paid:'; LblDiscTotal = 'Disc Total:'; CustomerServiceEmailLbl = 'Customer Service E-Mail:';
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        SalesSetup.GET();  //HEI.10
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND");  //HEI.04
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
        GLSetup: Record "General Ledger Setup";
        ItemCh: Record "Item Charge";
        Language1: Record Language;
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesInvLine: Record "Sales Line";
        SalesInvLineAmt: Record "Sales Line";
        SalesPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        VATEntry: Record "VAT Entry";
        Check: Report Check;
        LanguageMgt: Codeunit Language; // BC Upgrade BHARDA11
        SalesInvCountPrinted: Codeunit "Sales-Printed";
        CurrencyCode: Code[10];
        CustomerNo: Code[20];
        AmttoPaid: Decimal;
        BaseMarginAmt: Decimal;
        DepAmount: Decimal;
        RecCustomerDocuMgtSetup: Record CustomsDocMgtSetup113FDW; //BC UPGRADE KUMARR78 FDD-MTC-008 ++
        DiscIncluded: Decimal;
        InvDisAmount: Decimal;
        InvLineTotal: Decimal;
        InvTotalAmount: Decimal;
        ItemChargeDisc: Decimal;
        LineAmount: Decimal;
        LineDisAmount: Decimal;
        MarkupChargesAmount: Decimal;
        ShipAmount: Decimal;
        ShippingChargesAmount: Decimal;
        TaxAmout: Decimal;
        TotalAmountLCY: Decimal;
        TotalDepositFooterAmount: array[6] of Decimal;
        TotalFooterAmount: array[7] of Decimal;
        TotalInvDis: Decimal;
        TotalQty: Decimal;
        UnitPrice: Decimal;
        var_Dis: Decimal;
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
        Text52006: Label 'Proforma Invoice';
        Text52007: Label 'Sundry Invoice';
        ItemCharge: Option " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        DisplayTitleHeaderType: Option Confirmation,Proforma;
        CompanyInfoContryName: Text;
        CompanyText: Text;
        OriginalCopy: Text;
        SplitVatAmount: array[10] of Text;
        SplitVatPercent: array[10] of Text;
        // StandardTextReport: Record "2014410"; // BC Upgrade BHARDA11 ---- Drink-IT Table
        StandardTextReport: Record "Standard Text Report FND";//BC UPGRADE KUMARR78 FDD-MTC-008 ++
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
        rr: Report "Customer - Order Detail";
        TotalDepositFooterAmountText: array[6] of Text[50];
        TotalFooterAmountText: array[7] of Text[50];
        DescriptionLine: array[2] of Text[85];
        CustomerAddress: Text[240];
        CustomerAttributestext: Text[1024];
        Text52003: TextConst ENU = 'VAT @ %1 ', FRA = 'TVA @ %1';
        // FreeReasonCode: Record "2013788"; // BC Upgrade BHARDA11 ---- Drink-IT Table
        FreeReasonCode: Record "Reason Code"; // BC UPGRADE KUMARR78 FDD-MTC-008++

}

