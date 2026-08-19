report 53010 "Sales Invoice STD"
{
    // version HEI.17

    // HEI.01 Report created
    // HEI.03 INC1003205 IBM HORTOC01 04.12.2018 #add new item charge discount
    // HEI.04 HT434 CHG2011093 Defect # 4329 IBM GAVANM01 20.08.2019
    //   # add OpCo footer image
    // HEI.05 CHG2031911 Defect # 4329 IBM GAVANM01 19.09.2019  # add info in footer from Company Info
    // HEI.06 IBM SURYAS01  20.09.2019  # Commented code in order to aviod the Overflow error when trying to Preview the report.
    // HEI.07 FDD-HT915 IBM NASTAA02 27.09.2019 # OtC Billing – Invoice Layout local requirements for Domestic Invoice/Credit Memo/Sundry, and Export Invoice
    //   # Added 3 new Bank Accounts
    // HEI.08 IBM BULIMC01 25.10.2019 # defect 4627 # code added
    //    #new variable created (lineNumberVAT)
    //    # data item TEMPAccSchedKPIBuffer_VatPercent changed
    // HEI.09 IBM SURYAS01 9/12/2019 #defect 4448
    //   # Modified the below field values in Report Layout
    //   #"SubTotalExcText","@lblVATAmt","@lblAmtPaid",@LblTotalToBePaid
    // HEI.10 CHG2062657 HB1368 IBM GAVANM01 29.04.2020 #Correction to Invoice/Credit Note - Shipping Charge
    //   # code and layout changes
    // HEI.11 INC2918336 IBM NASTAA02 29.06.2020 # Printing multiple invoices
    //   # Implemented SetData, GetData functions on layout for the header text boxes
    // HEI.12 CHG2070324 IBM.GUNERE01 02.07.2020 # modifications on layout, DataSource SalesDiscount1 modified,
    //                                            PageLoop - OnAfterGetRecord, Sales Invoice Line - OnAfterGetRecord funcs.
    //                                            modified.
    // HEI.13 CHG2072833 IBM.MONTAU01 23.07.2020 #modify data shown in duedate field
    // HEI.14 CHG2070787 IBM GAVANM01 02.09.2020 Update all Billing documents in line with Global (for the BAHAMAS)
    //   # Add Standard Text Report functionality for footer texts
    // HEI.15 CHG2073371 HB1589 IBM GAVANM01 28.09.2020  #St Lucia Item charges Shipping Cost not working
    //   # Item charges of type Discount and Transport/Shipping Cost = TRUE should be considered as Shipping Cost
    // HEI.16 CHG2123621 IBM GHOSHS05  Corrected the subtotal calculation in RDLC Layout
    // HEI.17 INC4019421 - CHG2151382 IBM NASTAA02 18.03.2021 # When printing a sales invoice the "Subtotal Srd Excl.Vat " amount , differs from the "Subtotal incl VAT" amount and the total "To be paid amount"
    //   # Updated Subtotal Excl VAT calculation formula on layout

    // BC Upgrade RAHUL>>
    // 1. Added ApplicationArea = All property at report level for BC visibility.
    //    - Old: ApplicationArea not defined.
    //    - New: ApplicationArea = All;
    //
    // 2. Added UsageCategory = ReportsAndAnalysis property at report level for BC searchability.
    //    - Old: UsageCategory not defined.
    //    - New: UsageCategory = ReportsAndAnalysis;
    //
    // 3. Blocked Bank Details 2 columns due to removed/not available fields in BC/DIT.
    //    - Old: CompanyInfo."Bank Name 2", "Bank Account No. 2", "IBAN 2", "SWIFT Code 2".
    //    - New: Columns commented out (CompanyInfo_BankName2, CompanyInfo_BankAcc2, CompanyInfo_IBAN2, CompanyInfo_Swift2).
    //
    // 4. Updated Language handling because GetLanguageID moved from Table to Codeunit in BC.
    //    - Old: CurrReport.Language := Language.GetLanguageID("Language Code");
    //    - New: CurrReport.Language := RecLanguage.GetLanguageID("Language Code");
    //    - Added: RecLanguage: Codeunit Language;
    //
    // 5. Blocked Gross Weight calculation due to removed field from Sales Invoice Line.
    //    - Old: TotalGrossWeight += "Sales Invoice Line".Weight;
    //    - New: Line commented out; Net Weight still calculated using "Net Weight".
    //
    // 6. Blocked Item Charge Type + Show Item charge on Invoice filtering logic due to missing Drink-IT fields.
    //    - Old: SETRANGE("Item Charge Type"::Discount / Deposit / Tax / Shipping Cost) and "Show Item charge on Invoice" filters.
    //    - New: Logic commented out to avoid compilation issues.
    //
    // 7. Blocked "Free Item" based discount logic due to removed field.
    //    - Old: if not "Sales Invoice Line"."Free Item" then TotalInvDis := "Line Discount Amount";
    //    - New: Code commented out.
    //
    // 8. Blocked TotalFooterAmount calculation based on "Item Charge Type" due to removed fields.
    //    - Old: case SalesInvLine."Item Charge Type" of Tax/Deposit/Shipping Cost/Discount...
    //    - New: Entire block commented out; totals derived using standard fields ("Inv. Discount Amount", "Line Discount Amount").
    //
    // 9. Blocked Standard Text Report footer functionality due to missing Drink-IT table "Standard Text Report".
    //    - Old: StandardTextReport filtered by Report ID and Position Text::Footer to build TextFooter[].
    //    - New: Blocked completely.
    //
    // 10. Blocked Company Tax Registration No. printing due to missing Drink-IT field in Company Information.
    //     - Old: CompanyInfo."Tax Registration No."
    //     - New: Code commented out.
    //
    // 11. Blocked ExportInvoice override logic based on Drink-IT table "Doc Subtype Code Setup FND".
    //     - Old: ExportInvoice forced false for Sundry Sales Order types.
    //     - New: DocSubtypeCodeSetup logic blocked (table not available).
    //
    // 12. Added ApplicationArea on Request Page field for BC UI visibility.
    //     - Old: ApplicationArea missing on "No. of Copies" field.
    //     - New: ApplicationArea = All added.
    //
    // 13. Blocking as Wrong Expression.  DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where(Type = filter(Item | Resource | "Fixed Asset" | "Charge (Item)")); 
    // 14. Old Report ID - 50265
    // BC Upgrade RAHUL<<


    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Sales Invoice STD.rdl';
    ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL Adding Usagecategory

    Caption = 'Sales Invoice STD';
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
            // BC Upgrade RAHUL>>
            // column(CompanyInfo_BankName2; CompanyInfo."Bank Name 2")
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
            // BC Upgrade RAHUL<<
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
                        // DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(Item | Resource | "Fixed Asset" | '"Charge (Item)"')); // BC Upgrade RAHUL Blocking as Wrong Expression.
                        DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(Item | Resource | "Fixed Asset" | "Charge (Item)")); // BC Upgrade RAHUL Adding as Wrong Expression was Used.
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
                                // TotalGrossWeight += "Sales Invoice Line".Weight; // BC Upgrade RAHUL Blocking DIT Field("Sales Invoice Line".Weight)
                                TotalNetWeight += "Sales Invoice Line"."Net Weight";
                            end;

                            DiscIncluded := 0;
                            UnitPrice := "Unit Price";
                            LineAmount := "Line Amount";

                            //HEI.10>>
                            if Type <> Type::"Charge (Item)" then begin
                                //Include in Item Price

                                SalesInvoiceLine.Reset();
                                SalesInvoiceLine.SetRange("Document No.", "Document No.");
                                SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::"Charge (Item)");
                                SalesInvoiceLine.SetRange("Attached to Line No.", "Line No.");
                                // SalesInvoiceLine.SETRANGE("Item Charge Type", SalesInvoiceLine."Item Charge Type"::Discount); // BC Upgrade RAHUL Blocking DIT Field(SalesInvoiceLine."Item Charge Type"::Discount)
                                // SalesInvoiceLine.SETRANGE("Show Item charge on Invoice", SalesInvoiceLine."Show Item charge on Invoice"::"Include in item price");// BC Upgrade RAHUL Blocking DIT Field(SalesInvoiceLine."Show Item charge on Invoice"::"Include in item price")
                                if SalesInvoiceLine.FindSet() then
                                    repeat
                                        if ItemCh.Get(SalesInvoiceLine."No.") and not ItemCh."Transport/Shipping Cost FND" then begin  //HEI.15
                                            LineAmount += SalesInvoiceLine."Line Amount";
                                            //DiscIncluded += ABS(SalesInvoiceLine."Line Amount");
                                            DiscIncluded += SalesInvoiceLine."Line Amount"; //HEI.12
                                                                                            /*IF SalesInvoiceLine.Quantity > 0 THEN
                                                                                              UnitPrice += SalesInvoiceLine."Unit Price"
                                                                                            ELSE
                                                                                              UnitPrice -= SalesInvoiceLine."Unit Price";*/
                                            if SalesInvoiceLine.Quantity <> 0 then
                                                UnitPrice := LineAmount / Abs(Quantity);
                                        end;   //HEI.15
                                    until SalesInvoiceLine.Next() = 0;
                            end;
                            // BC Upgrade RAHUL Blocking Else condtion Due to DIT Field >>
                            // end else if ("Sales Invoice Line"."Item Charge Type" = "Sales Invoice Line"."Item Charge Type"::Discount) and 
                            //   ("Show Item charge on Invoice" = "Show Item charge on Invoice"::"Include in item price") then 
                            //         if ItemCh.Get("No.") and not ItemCh."Transport/Shipping Cost" then   //HEI.15 
                            //             CurrReport.Skip(); 
                            // BC Upgrade RAHUL Blocking Else condtion Due to DIT Field <<

                            //HEI.10<<

                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;
                            ItemDiscount := 0;
                            itemDeposit := 0;
                            // BC Upgrade RAHUL Blocking Due to DIT and Removal of Field >>
                            // if not "Sales Invoice Line"."Free Item" then 
                            //     TotalInvDis := "Sales Invoice Line"."Line Discount Amount"; 
                            // BC Upgrade RAHUL Blocking Due to DIT and Removal of Field <<

                            /*IF ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)") AND ("Sales Invoice Line"."Item Charge Type" = "Sales Invoice Line"."Item Charge Type"::Discount) THEN
                              var_Dis := "Sales Invoice Line"."Line Amount"
                            ELSE
                              var_Dis := 0;*/

                            //var_Dis := ABS("Line Discount Amount");
                            var_Dis := "Line Discount Amount"; //HEI.12
                                                               // if (Type = Type::"Charge (Item)") and ("Item Charge Type" = "Item Charge Type"::Discount) then  // BC Upgrade RAHUL Blocking Due to DIT and Removal of Field >>
                            if ItemCh.Get("No.") and not ItemCh."Transport/Shipping Cost FND" then  //HEI.15
                                                                                                //var_Dis += ABS("Line Amount");
                                var_Dis += Abs("Line Amount"); //HEI.12

                            /* //Commented by HEI.10>>
                            IsNotUnderitem := FALSE;
                            SalesChargeLine.RESET;
                            SalesChargeLine.SETRANGE("Document No.","Sales Invoice Line"."Document No.");
                            SalesChargeLine.SETRANGE(Type,"Sales Invoice Line".Type::"Charge (Item)");
                            SalesChargeLine.SETRANGE("Item Charge Type","Sales Invoice Line"."Item Charge Type"::Discount);
                            SalesChargeLine.SETFILTER("Show Item charge on Invoice",'<>%1',SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                            SalesChargeLine.SETRANGE("Attached to Line No.","Sales Invoice Line"."Line No.");
                            IF SalesChargeLine.FINDSET THEN BEGIN
                              IsNotUnderitem:= TRUE;
                            END;

                            //Discounts under item line
                            CLEAR(PrintUnderLineCharge);
                            SalesChargeLine.RESET;
                            SalesChargeLine.SETRANGE("Document No.","Sales Invoice Line"."Document No.");
                            SalesChargeLine.SETRANGE(Type,"Sales Invoice Line".Type::"Charge (Item)");
                            SalesChargeLine.SETRANGE("Item Charge Type","Sales Invoice Line"."Item Charge Type"::Discount);
                            //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                            SalesChargeLine.SETRANGE("Attached to Line No.","Sales Invoice Line"."Line No.");
                            IF SalesChargeLine.FINDSET THEN BEGIN
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
                            END;

                            //Deposit under item line
                            IsDeposit := FALSE;
                            CLEAR(PrintUnderLineCharge);
                            SalesChargeLine.RESET;
                            SalesChargeLine.SETRANGE("Document No.","Sales Invoice Line"."Document No.");
                            SalesChargeLine.SETRANGE(Type,"Sales Invoice Line".Type::"Charge (Item)");
                            SalesChargeLine.SETRANGE("Item Charge Type","Sales Invoice Line"."Item Charge Type"::Deposit);
                            //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                            SalesChargeLine.SETRANGE("Attached to Line No.","Sales Invoice Line"."Line No.");
                            IF SalesChargeLine.FINDSET THEN BEGIN
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
                            END;

                            //Shipping cost under item line
                            CLEAR(PrintUnderLineCharge);
                            SalesChargeLine.RESET;
                            SalesChargeLine.SETRANGE("Document No.","Sales Invoice Line"."Document No.");
                            SalesChargeLine.SETRANGE(Type,"Sales Invoice Line".Type::"Charge (Item)");
                            //SalesChargeLine.SETRANGE("Item Charge Type","Sales Invoice Line"."Item Charge Type"::Discount);
                            //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line"); HEI.06
                            SalesChargeLine.SETRANGE("Attached to Line No.","Sales Invoice Line"."Line No.");
                            IF SalesChargeLine.FINDSET THEN BEGIN
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
                                END;
                              UNTIL (SalesChargeLine.NEXT = 0)
                            END;*/  //Commented by HEI.10<<

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
                        //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset");  //commented by HEI.15
                        if SalesInvLineAmt.FindSet() then
                            repeat
                                // if (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") or (SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::" ") then  //HEI.15  // BC Upgrade RAHUL Blocking Due to DIT Field(SalesInvLineAmt."Item Charge Type"::" ")
                                InvLineTotal += SalesInvLineAmt."Line Amount";
                            until SalesInvLineAmt.Next() = 0;

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;

                        // BC Upgrade RAHUL Blocking Due to DIT Field >>
                        // SalesInvLine.Reset();
                        // SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                        // SalesInvLine.SetRange(Type, SalesInvLine.Type::"Charge (Item)");
                        // if SalesInvLine.FindSet() then
                        //     repeat
                        //         case SalesInvLine."Item Charge Type" of
                        //             SalesInvLine."Item Charge Type"::Tax:
                        //                 TotalFooterAmount[1] += SalesInvLine."Line Amount";
                        //             SalesInvLine."Item Charge Type"::Deposit:
                        //                 TotalFooterAmount[2] += SalesInvLine."Line Amount";
                        //             SalesInvLine."Item Charge Type"::"Shipping Cost":
                        //                 TotalFooterAmount[3] += SalesInvLine."Line Amount";
                        //             SalesInvLine."Item Charge Type"::Discount:
                        //                 //HEI.15>>
                        //                 begin
                        //                     if ItemCh.Get(SalesInvLine."No.") and ItemCh."Transport/Shipping Cost" then
                        //                         TotalFooterAmount[3] += SalesInvLine."Line Amount"
                        //                     else
                        //                         //HEI.15<<
                        //                         if SalesInvLine."Show Item charge on Invoice" <> SalesInvLine."Show Item charge on Invoice"::"Include in item price" then
                        //                             //TotalFooterAmount[4] += ABS(SalesInvLine."Line Amount");
                        //                             TotalFooterAmount[4] += SalesInvLine."Line Amount"; //HEI.12
                        //                 end;  //HEI.15
                        //         end;
                        //     until SalesInvLine.Next() = 0;
                        // BC Upgrade RAHUL Blocking Due to DIT Field <<

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
                CurrReportID: Integer;
                i: Integer;
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
            begin
                //HEI.14>>
                //-----Currency
                if "Currency Code" <> '' then
                    CurrencyCode := "Currency Code"
                else
                    CurrencyCode := GLSetup."LCY Code";

                //-----Footer Texts
                Clear(CurrReportID);
                Clear(i);
                Clear(TextFooter);
                Evaluate(CurrReportID, CopyStr(CurrReport.ObjectId(false), 8));

                // BC Upgrade RAHUL Blocking Due to DIT Field(StandardTextReport) >>
                // StandardTextReport.SETRANGE("Report ID", CurrReportID);
                // StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);
                // if StandardTextReport.FINDSET then
                //     repeat
                //         i := 1;
                //         ExtendedTextHeader.Reset();
                //         ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                //         ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                //         if ExtendedTextHeader.FindSet() then begin
                //             repeat
                //                 ExtendedTextLine.Reset();
                //                 ExtendedTextLine.SetRange("Table Name", ExtendedTextHeader."Table Name");
                //                 ExtendedTextLine.SetRange("No.", ExtendedTextHeader."No.");
                //                 ExtendedTextLine.SetRange("Text No.", ExtendedTextHeader."Text No.");
                //                 ExtendedTextLine.SetRange("Language Code", "Language Code");
                //                 if ExtendedTextHeader."All Language Codes" then
                //                     ExtendedTextLine.SetRange("Language Code", ExtendedTextHeader."Language Code");
                //                 if ExtendedTextLine.FindSet() then begin
                //                     repeat
                //                         TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                //                     until (ExtendedTextLine.Next() = 0) or (i > ArrayLen(TextFooter));
                //                 end;
                //                 i += 1;
                //             until (ExtendedTextHeader.Next() = 0);
                //         end;
                //     until (StandardTextReport.NEXT = 0);
                // BC Upgrade RAHUL Blocking Due to DIT Field(StandardTextReport) <<

                //HEI.14<<

                //HEI.05>>
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
                // BC Upgrade RAHUL >> ----Drink-IT Field ("Tax Registration No.")
                // if CompanyInfo."Tax Registration No." <> '' then
                //     CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                // BC Upgrade RAHUL << ----Drink-IT Field ("Tax Registration No.")
                //CompanyText += ', ' + ChOfComm;
                if CompanyInfo."Phone No." <> '' then
                    CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                if CompanyInfo."Fax No." <> '' then
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                /*IF CompanyInfo."E-Mail" <> '' THEN
                  CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";*/  //commented by HEI.14
                                                                                   //HEI.05<<

                if "Sales Invoice Header"."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" then
                    ExportInvoice := true
                else
                    ExportInvoice := false;

                // BC Upgrade SHUKLP03 (DocSubtypeCodeSetup) >>
                if "Sales Invoice Header"."Document Subtype Code FND" in [DocSubtypeCodeSetup."Sundry Sales Order Non Stock", DocSubtypeCodeSetup."Sundry Sales Order Stock"] then
                    ExportInvoice := false;
                // BC Upgrade SHUKLP03 (DocSubtypeCodeSetup) <<

                TotalGrossWeight := 0;
                TotalNetWeight := 0;

                TEMPAccSchedKPIBuffer.DeleteAll();
                if Country.Get(CompanyInfo."Country/Region Code") then
                    CompanyInfoContryName := Country.Name;

                // CurrReport.Language := Language.GetLanguageID("Language Code"); // BC Upgrade RAHUL  blocking as Function Moved from Table to Codeunit.
                CurrReport.Language := RecLanguage.GetLanguageID("Language Code"); // BC Upgrade RAHUL Adding as Function Moved from Table to Codeunit.

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
                lineNumberVAT := 0;  //HEI.08
                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SetFilter("VAT %", '<>%1', 0);
                if SalesInvLine.FindSet() then
                    repeat
                        VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                        VATAmount := Abs(VatAmt);

                        //HEI.06<<
                        /*
                        //split VAT
                          IF TEMPAccSchedKPIBuffer.GET(SalesInvLine."VAT %") THEN BEGIN
                          TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %")/100;
                          TEMPAccSchedKPIBuffer.MODIFY;

                        END ELSE BEGIN
                          TEMPAccSchedKPIBuffer.INIT;
                          TEMPAccSchedKPIBuffer."No." := SalesInvLine."VAT %";
                          TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount"* SalesInvLine."VAT %")/100;
                          TEMPAccSchedKPIBuffer.INSERT;
                        END;*/
                        //HEI.06>>

                        //HEI.08>>
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
                //HEI.08<<

                //HEI.06<<
                //HEI.08<< //decommented the code commented by HEI.06
                TEMPAccSchedKPIBuffer.Reset();
                if TEMPAccSchedKPIBuffer.FindSet() then
                    repeat
                        Counter += 1;
                        // SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."No.") + '%'; //commented by HEI.08
                        SplitVatPercent[Counter] := Format(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%'; //HEI.08
                        SplitVatAmount[Counter] := Format(TEMPAccSchedKPIBuffer."Net Change Budget", 0, '<Sign><Integer Thousand><Decimals,3>');
                    until TEMPAccSchedKPIBuffer.Next() = 0;
                //HEI.08>> //decommented the code commented by HEI.06
                //HEI.06>>
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
                        ApplicationArea = all; // BC Upgrade RAHUL Adding Application Area
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
        GLSetup.Get();
        SalesSetup.Get();  //HEI.14
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture, "OpCo Footer image FND");  //HEI.04
        GeneralOpCoSetup.Get();
        DocSubtypeCodeSetup.GET(); // BC Upgrade SHUKLP03
    end;

    var
        var_Dis: Decimal;
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        VATEntry: Record "Area";
        // Language: Record Language; // BC Upgrade RAHUL Blocking Variable as Function Moved to Codeunit
        RecLanguage: Codeunit Language; // BC Upgrade RAHUL Adding Variable as Function Moved to Codeunit from Table
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
        BillToCustomer: Record Customer;
        SoldToCustomer: Record Customer;
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
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND"; // BC Upgrade SHUKLP03
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
        // StandardTextReport: Record "Standard Text Report"; // BC Upgrade RAHUL << ----Drink-IT Table ("StandardTextReport")
        TextFooter: array[3] of Text;
        CurrencyCode: Code[10];
        ItemCh: Record "Item Charge";
}

