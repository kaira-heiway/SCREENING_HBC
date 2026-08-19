report 53005 "Order Confirmation STD"
{
    // version HEI.07

    // HEI.01 Report created
    // HEI.03 INC1003205 IBM HORTOC01 04.12.2018 #add new item charge discount
    // HEI.04 IBM BULIMC01 25.10.2019 # defect 4627, code added, new variable created (lineNumberVAT) in Sales Invoice Header - OnAfterGetRecord()
    // HEI.06 CHG2062657 HB1368 IBM GAVANM01 02.06.2020 #Correction to Invoice/Credit Note - Shipping Charge
    //   # code and layout changes
    // HEI.07 INC2918336 IBM NASTAA02 29.06.2020 # Printing multiple invoices
    //   # Implemented SetData, GetData functions on layout for the header text boxes
    // HEI.08 CHG2070187 IBM GAVANM01 14.08.2020 # bug fixes
    //   # layout changes
    // HEI.09 CHG2073371 HB1589 IBM GAVANM01 28.09.2020  #St Lucia Item charges Shipping Cost not working
    //   # Item charges of type Discount and Transport/Shipping Cost = TRUE should be considered as Shipping Cost
    // HEI.10 CHG2144396 IBM GHOSHS05 28.01.2022 Added PrintingTime to show proper time in both Webclient and RTC
    // HEI.11 CHG2326215-CC IBM ADHIKG01 09.10.2025 Job queue failure due to missing INV_LEV dimension
    //   # Added condition to execute the "Sales-Printed" codeunit from the CopyLoop - OnPostDataItem trigger

    // BC Upgrade RAHUL>> 
    // 1. Blocking Drink-IT Field ("Sales Invoice Line".Weight,"Item Charge Type"::Discount,SalesInvoiceLine."Show Item charge on Invoice","Sales Invoice Line"."Free Item").
    // 2. Adding Application Area to the Action on Request Page to Field(No. of Copies,"Print Discounts").
    // 3. Blocked whole loop as dependency on DIT(Field-"Item Charge Type").
    // 4. Commenting As Function Moved from Table to Codeunit. (Language: Record Language).
    // 5. Adding Application Area in the report.
    // 6. Adding UsageCategory in the report.
    // 7. Blocking DIT Colomn (column(SalesHOrdNo; "Sales Invoice Header"."Order No.")
    // 8. Blocking as Wrong Expression.  DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where(Type = filter(Item | Resource | "Fixed Asset" | "Charge (Item)")); 
    // 9. Old Report ID is  50257
    // BC Upgrade RAHUL<<

    // BC PATELP08 >>
    // # Added Tag HEI.11 documentation.
    // # Added condition to execute the "Sales-Printed" codeunit from the CopyLoop - OnPostDataItem trigger as per HEI.11 tag
    // BC PATELP08 <<


    DefaultLayout = RDLC;

    RDLCLayout = '.\src\ReportsLayout\Order Confirmation STD.rdl';

    CaptionML = ENU = 'Order Confirmation STD',
                FRA = 'Confirmation de commande vente';
    PaperSourceDefaultPage = TractorFeed;
    ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL Adding Usagecategory
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "Document Type", "No.";
            column(SalesHDocNo; "Sales Invoice Header"."No.")
            {
            }
            column(PrintingTime; PrintingTime)
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
            column(CompanyInfo_OpCoFooter; CompanyInfo."OpCo Footer image FND")
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
            column(PrintDiscounts; PrintDiscounts)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(TotalInvoice; TotalSalesline."Amount Including VAT")
                    {
                    }
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
                    column(SalesHOrdNo; "Sales Invoice Header"."No.") // BC Upgrade RAHUL Blocking DIT- Field
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
                    column(ShippingChrgAmnt; ShippingChrgAmnt)
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
                    column(CurrencyCode; CurrencyCode)
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
                    dataitem("Sales Invoice Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where(Type = filter(Item | Resource | "Fixed Asset" | "Charge (Item)" | "G/L Account")); // BC Upgrade RAHUL Adding as Wrong Expression was Used.
                        // DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where( = filter('Item' | 'Resource' | '"Fixed Asset"' | '"Charge (Item)"')); // BC Upgrade RAHUL Blocking as Wrong Expression.
                        column(HideDiscount; HideDiscount)
                        {
                        }
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
                        column(SalesPrice1; Round("Sales Invoice Line"."Unit Price", 0.01, '='))
                        {
                        }
                        column(SalesVATPer; "Sales Invoice Line"."VAT %")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesAmount1; "Sales Invoice Line".Amount)
                        {
                        }
                        column(TotalQuantity; TotalQty)
                        {
                        }
                        column(SalesDiscount; ItemDiscount)
                        {
                        }
                        column(SalesDiscount2; "Sales Invoice Line"."Line Amount")
                        {
                        }
                        column(TotalInvDis; TotalInvDis + ItemDiscount)
                        {
                        }
                        column(PrintUnderLineCharge; PrintUnderLineCharge)
                        {
                        }
                        column(TotalDiscount; TotalDiscount)
                        {
                        }
                        column(DiscIncluded; DiscIncluded)
                        {
                        }
                        column(SalesPrice; UnitPrice)
                        {
                        }
                        column(SalesAmount; LineAmount)
                        {
                        }
                        column(SalesDiscount1; (-1) * var_Dis)
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
                            OrderChargeLine: Record "Sales Line";
                            SalesChargeLine: Record "Sales Line";
                            SalesInvoiceLine: Record "Sales Line";
                        begin
                            if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then begin
                                TotalGrossWeight += "Sales Invoice Line"."Gross Weight 1 101FDW"; //BC Upgrade RAHUl Blocking DIT Field
                                TotalNetWeight += "Sales Invoice Line"."Net Weight";
                            end;

                            //HEI.06>>
                            DiscIncluded := 0;
                            UnitPrice := "Unit Price";
                            LineAmount := "Line Amount";

                            if Type <> Type::"Charge (Item)" then begin
                                //Include in Item Price

                                SalesInvoiceLine.Reset();
                                SalesInvoiceLine.SetRange("Document No.", "Document No.");
                                SalesInvoiceLine.SetRange("Document Type", "Document Type");
                                SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::"Charge (Item)");
                                SalesInvoiceLine.SetRange("Attached to Line No.", "Line No.");
                                SalesInvoiceLine.SETRANGE("Attached Line Type 101FDW", SalesInvoiceLine."Attached Line Type 101FDW"::"SPC 105FDW"); // BC Upgrade RAHUL << - Blocked as dependency on Drink-IT Field
                                SalesInvoiceLine.SETRANGE("Show Item charge on Inv. FND", SalesInvoiceLine."Show Item charge on Inv. FND"::"Include in item price"); // BC Upgrade RAHUL << - Blocked as dependency on Drink-IT Field
                                if SalesInvoiceLine.FindSet() then
                                    repeat
                                        if ItemCh.Get(SalesInvoiceLine."No.") and not ItemCh."Transport/Shipping Cost FND" then begin  //HEI.09
                                            LineAmount += SalesInvoiceLine."Line Amount";
                                            //DiscIncluded += ABS(SalesInvoiceLine."Line Amount");   //commented by HEI.08
                                            DiscIncluded += SalesInvoiceLine."Line Amount";   //HEI.08
                                            if SalesInvoiceLine.Quantity <> 0 then
                                                UnitPrice := LineAmount / Abs(Quantity);
                                        end  //HEI.09
                                    until SalesInvoiceLine.Next() = 0;
                                //BC Upgrade RAHUL >> Blocking Lope DIT Field
                            end else if ("Sales Invoice Line"."Attached Line Type 101FDW" = "Sales Invoice Line"."Attached Line Type 101FDW"::"SPC 105FDW") and ("Show Item charge on Inv. FND" = "Show Item charge on Inv. FND"::"Include in item price") then
                                    if ItemCh.GET("No.") and not ItemCh."Transport/Shipping Cost FND" then   //HEI.09
                                        CurrReport.SKIP;
                            //BC Upgrade RAHUL << Blocking Lope DIT Field
                            //HEI.06<<
                            //end;
                            HideDiscount := false;

                            if not PrintDiscounts then
                                if (Type = Type::"Charge (Item)") and ("Attached Line Type 101FDW" = "Attached Line Type 101FDW"::"SPC 105FDW") then //BC Upgrade RAHUL << Blocking  DIT Field
                                    if ItemCh.Get("No.") and not ItemCh."Transport/Shipping Cost FND" then  //HEI.09
                                        HideDiscount := true;

                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;
                            ItemDiscount := 0;
                            itemDeposit := 0;
                            if "Sales Invoice Line"."Line Discount %" <> 100 then //BC Upgrade RAHUL << Blocking DIT Field
                                TotalInvDis := "Sales Invoice Line"."Line Discount Amount"; //BC Upgrade RAHUL << Blocking DIT Field

                            if ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)") and ("Sales Invoice Line"."Attached Line Type 101FDW" = "Sales Invoice Line"."Attached Line Type 101FDW"::"SPC 105FDW") then
                                Var_typechargeItem := true
                            else //BC Upgrade RAHUL << Blocking DIT Field
                                if "Sales Invoice Line".Type <> "Sales Invoice Line".Type::"Charge (Item)" then
                                    Var_typechargeItem := false;

                            //HEI.06>>
                            var_Dis := Abs("Line Discount Amount");
                            if (Type = Type::"Charge (Item)") and ("Attached Line Type 101FDW" = "Attached Line Type 101FDW"::"SPC 105FDW") then //BC Upgrade RAHUL << Blocking DIT Field
                                if ItemCh.Get("No.") and not ItemCh."Transport/Shipping Cost FND" then  //HEI.09
                                    var_Dis += Abs("Line Amount");
                            //HEI.06<<

                            /* //Commented by HEI.06>>
                            IsNotUnderitem := FALSE;
                            SalesChargeLine.RESET;
                            SalesChargeLine.SETRANGE("Document Type","Sales Invoice Line"."Document Type");
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
                            SalesChargeLine.SETRANGE("Document Type","Sales Invoice Line"."Document Type");
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
                            SalesChargeLine.SETRANGE("Document Type","Sales Invoice Line"."Document Type");
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
                            SalesChargeLine.SETRANGE("Document Type","Sales Invoice Line"."Document Type");
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
                            END;
                            */ //Commented by HEI.06<<

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

                        //IF NOT ExportInvoice THEN
                        DocumentTitleText := StrSubstNo(Text52006, CopyText);
                        //ELSE
                        //  DocumentTitleText := STRSUBSTNO(Text52008,CopyText);

                        // BC Upgrade RAHUL << - Blocked whole loop as dependency on Drink-IT Field
                        SalesInvLineAmt.RESET;
                        SalesInvLineAmt.SETRANGE("Document Type", "Sales Invoice Header"."Document Type");
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset"); //commented by HEI.09
                        if SalesInvLineAmt.FINDSET then
                            repeat
                                if (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") or (SalesInvLineAmt."Type" = SalesInvLineAmt.Type::"G/L Account") then  //HEI.09
                                    InvLineTotal += SalesInvLineAmt."Line Amount";
                            until SalesInvLineAmt.NEXT = 0;
                        // BC Upgrade RAHUL >> - Blocked whole loop as dependency on Drink-IT Field

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;

                        // BC Upgrade RAHUL >> - Blocked whole for loop  as dependency on DIT
                        SalesInvLine.RESET;
                        SalesInvLine.SETRANGE("Document Type", "Sales Invoice Header"."Document Type");
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        if SalesInvLine.FINDSET then
                            repeat
                                case SalesInvLine."Attached Line Type 101FDW" of
                                    SalesInvLine."Attached Line Type 101FDW"::"TAX 102FDW":
                                        TotalFooterAmount[1] += SalesInvLine."Line Amount";
                                    SalesInvLine."Attached Line Type 101FDW"::"EGM 104FDW":
                                        TotalFooterAmount[2] += SalesInvLine."Line Amount";
                                    // SalesInvLine."Item Charge Type"::ShippingCost:
                                    // TotalFooterAmount[3] += SalesInvLine."Line Amount";
                                    SalesInvLine."Attached Line Type 101FDW"::"SPC 105FDW":
                                        //HEI.09>>
                                        begin
                                            if ItemCh.GET(SalesInvLine."No.") and ItemCh."Transport/Shipping Cost FND" then
                                                TotalFooterAmount[3] += SalesInvLine."Line Amount"
                                            else
                                                //HEI.09<<
                                                //HEI.06 >>
                                                if SalesInvLine."Show Item charge on Inv. FND" <> SalesInvLine."Show Item charge on Inv. FND"::"Include in item price" then
                                                    //TotalFooterAmount[4] += ABS(SalesInvLine."Line Amount");  //commented by HEI.08
                                                    TotalFooterAmount[4] += SalesInvLine."Line Amount";    //HEI.08
                                                                                                           //HEI.06 <<
                                                                                                           /* //commented by HEI.06 >>
                                                                                                           BEGIN
                                                                                                             CASE SalesInvLine."No." OF
                                                                                                             'S_MARKUP':
                                                                                                               BEGIN
                                                                                                                 TotalFooterAmount[5] += SalesInvLine."Line Amount";
                                                                                                                 TotalFooterAmountText[5]:= 'Markup Charges:';
                                                                                                                 //TotalFooterAmount[3] += SalesInvLine."Line Amount";
                                                                                                                 //TotalFooterAmountText[3]:= 'All Discounts';
                                                                                                               END;
                                                                                                             //HEI.03>>
                                                                                                             'A1.PPR':
                                                                                                               BEGIN
                                                                                                                 TotalFooterAmount[7] += SalesInvLine."Line Amount";
                                                                                                                 TotalFooterAmountText[7]:= 'Base Margin PPR:';
                                                                                                               END;
                                                                                                             //HEI.03<<
                                                                                                             'S_SHIP':
                                                                                                               BEGIN
                                                                                                                 TotalFooterAmount[6] += SalesInvLine."Line Amount";

                                                                                                                 //TotalFooterAmountText[6]:= 'Shipping Charges';
                                                                                                                 {IF TotalFooterAmountText[3] = 'All Discounts' THEN
                                                                                                                   TotalFooterAmountText[3]:= 'All Discounts'
                                                                                                                 ELSE
                                                                                                                   TotalFooterAmountText[3]:= 'Shipping Charges';}
                                                                                                               END;
                                                                                                             //ELSE
                                                                                                               //TotalInvDis += SalesInvLine."Line Amount";
                                                                                                             END;
                                                                                                            END;*/ //commented by HEI.06 <<
                                        end  //HEI.09
                                end;
                            until SalesInvLine.NEXT = 0;
                        // BC Upgrade RAHUL << - Blocked whole loop as dependency on Drink-IT Field

                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        ShipAmount := TotalFooterAmount[3];

                        ShippingChrgAmnt := TotalFooterAmount[6];

                        SalesInvLine.Reset();
                        SalesInvLine.SetRange("Document Type", "Sales Invoice Header"."Document Type");
                        SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                        //SalesInvLine.SETRANGE(Type,SalesInvLine.Type::"Charge (Item)");  //commented by HEI.06
                        if SalesInvLine.FindSet() then
                            repeat
                                TotalFooterAmount[4] += Abs(SalesInvLine."Inv. Discount Amount");
                                TotalFooterAmountText[4] := SalesInvLine.FieldCaption("Inv. Discount Amount");
                                TotalFooterAmount[5] += Abs(SalesInvLine."Line Discount Amount");
                                TotalFooterAmountText[5] := SalesInvLine.FieldCaption("Line Discount Amount");
                            until SalesInvLine.Next() = 0;

                        InvDisAmount := TotalFooterAmount[4];
                        LineDisAmount := TotalFooterAmount[5];

                        //AmttoPaid := InvLineTotal+VatAmt+TotalFooterAmount[1]+VatAmt+TotalFooterAmount[5]+TotalFooterAmount[6]-VatAmt+TotalFooterAmount[4];
                        //InvTotalAmount := AmttoPaid+TotalFooterAmount[2];
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
                var
                    SessionGlobal: Codeunit "Session Globals"; // BC Upgrade PATELP08 - HEI.11
                begin
                    // BC Upgrade PATELP08 >>
                    // HEI.11 >>
                    IF NOT SessionGlobal.GetCalledFromDDE() THEN
                        // HEI.11 <<
                        // BC Upgrade PATELP08 <<
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
            begin
                if "Sales Invoice Header"."Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" then
                    ExportInvoice := true
                else
                    ExportInvoice := false;

                TotalGrossWeight := 0;
                TotalNetWeight := 0;

                TEMPAccSchedKPIBuffer.DeleteAll();
                if Country.Get(CompanyInfo."Country/Region Code") then
                    CompanyInfoContryName := Country.Name;

                // CurrReport.Language := Language.GetLanguageID("Language Code"); //BC Upgrade RAHUL GetlanguageId moved from Table to CU.
                IF "Language Code" <> '' THEN  // SHUKLP03
                    CurrReport.Language := LanguageG.GetLanguageId("Language Code"); //BC Upgrade RAHUL GetlanguageId moved from Table to CU.

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
                    CurrencyCode := GLSetup."LCY Code";   //HEI.08
                end else begin
                    TotalExText := StrSubstNo(Text52001, "Currency Code");
                    TotalInText := StrSubstNo(Text52002, "Currency Code");
                    SubTotalInText := StrSubstNo(Text52005B, "Currency Code");
                    SubTotalExText := StrSubstNo(Text52005, "Currency Code");
                    CurrencyCode := "Currency Code";  //HEI.08
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
                SalesInvLine.SetRange("Document Type", "Sales Invoice Header"."Document Type");
                SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SetFilter("VAT %", '<>%1', 0);
                if SalesInvLine.FindFirst() then
                    VATPer := SalesInvLine."VAT %";

                if "Sales Invoice Header"."Prices Including VAT" = true then
                    PriceIncVAT := 'Yes'
                else
                    PriceIncVAT := 'No';

                VatAmt := 0;
                lineNumberVAT := 0; //HEI.04
                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document Type", "Sales Invoice Header"."Document Type");
                SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SetFilter("VAT %", '<>%1', 0);
                if SalesInvLine.FindSet() then
                    repeat
                        VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                        VATAmount := Abs(VatAmt);

                        //split VAT
                        //IF TEMPAccSchedKPIBuffer.GET(SalesInvLine."VAT %") THEN BEGIN  //commented by HEI.04
                        //HEI.04>>
                        TEMPAccSchedKPIBuffer.Reset();
                        TEMPAccSchedKPIBuffer.SetRange("Balance at Date Forecast", SalesInvLine."VAT %");
                        if TEMPAccSchedKPIBuffer.FindFirst() then begin
                            //HEI.04<<
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.Modify();
                        end else begin
                            //TEMPAccSchedKPIBuffer."No." := SalesInvLine."VAT %";   //commented by HEI.04
                            //HEI.04>>
                            lineNumberVAT += 1;
                            TEMPAccSchedKPIBuffer.Init();
                            TEMPAccSchedKPIBuffer."No." := lineNumberVAT;
                            TEMPAccSchedKPIBuffer."Balance at Date Forecast" := SalesInvLine."VAT %";
                            //HEI.04<<
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.Insert();
                        end;
                    until SalesInvLine.Next() = 0;

                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document Type", "Sales Invoice Header"."Document Type");
                SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                if SalesInvLine.FindFirst() then
                    DocumentTotals.CalculateSalesTotals(TotalSalesline, VATAmount, SalesInvLine);

                TEMPAccSchedKPIBuffer.Reset();
                if TEMPAccSchedKPIBuffer.FindSet() then
                    repeat
                        Counter += 1;
                        //SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."No.") + '%';                      //commented by HEI.04
                        SplitVatPercent[Counter] := Format(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%';  //HEI.04
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

            trigger OnPreDataItem();
            begin
                //HEI.10>>
                PrintingTime := CurrentDateTime;
                //HEI.10<<
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group("Sales Order")
                {
                    Caption = 'Sales Order';
                    field("No. of Copies"; NoOfCopies)
                    {
                        ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea to the Action Button

                    }
                    field("Print Discounts"; PrintDiscounts)
                    {
                        ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea to the Action Button
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
        LblBillToAddress = 'BILL TO:'; LblCustomerName = 'Customer Name:'; LblAddress = 'Address 1:'; LblAddress2 = 'Address 2:'; LblPostCode = 'Post Code:'; LblCity = 'City:'; LblCountry = 'Country:'; LblVatRegistrationNo = 'Vat Registration No:'; LblCompanyTaxId = 'Company Tax ID:'; LblSoldToAddress = 'CUSTOMER:'; LblCustomerPoNo = 'Customer PO No:'; LblTaxDetails = 'Tax Summary'; LblBankInfo = 'Bank Details:'; LblAccountNo = 'Account No:'; LblBankName = 'Bank:'; LblGiro = 'Giro No.'; LblIban = 'Iban:'; LblSwiftCode = 'Swift Code:'; LblSignature = 'Signature:'; LblVatPercent = 'Vat Percent'; LblVatAmount = 'Vat Amount'; LblIncoTerm = 'InCo Terms:'; Lbldisc = 'Disc.'; LblShipToAddress = 'SHIP TO ADDRESS:'; LblCustomerNo = 'Customer No:'; LblInvoiceCurrency = 'Invoice Currency:'; LblVersion = 'Version:'; LblItemNo = 'Item No.'; LblQty = 'Qty'; LblPayMethod = 'Payment Method:'; LblInvoiceCurrLCY = 'Invoice Curr LCY:'; LblTotalToBePaid = 'Total to be paid:'; LblDiscTotal = 'Disc Total:'; GrossWeightLbl = 'Gross Weight:'; NetWeightLbl = 'Net Weight:'; BillOfLadingNoLbl = 'Bill Of Lading No:'; VesselNameLbl = 'Vessel Name:'; ETDLbl = 'ETD:'; ETALbl = 'ETA:'; AirWayBillNoLbl = 'Air Way Bill No:'; CommodityCodeLbl = 'Commodity Code:'; CustomTariffCodeLbl = 'Custom Tariff Code:'; LblBillToCustNo = 'Bill-To Customer No.:';
    }

    trigger OnInitReport();
    begin
        GLSetup.Get();
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture, "OpCo Footer image FND");
        GeneralOpCoSetup.Get();
    end;

    var
        TEMPAccSchedKPIBuffer: Record "Acc. Sched. KPI Buffer";
        VATEntry: Record "Area";
        CompanyInfo: Record "Company Information";
        BillToCountry: Record "Country/Region";
        Country: Record "Country/Region";
        SoldToCountry: Record "Country/Region";
        CurrExchRate: Record "Currency Exchange Rate";
        BillToCustomer: Record Customer;
        Customer: Record Customer;
        SoldToCustomer: Record Customer;
        CustomerAttributes: Record "Customer Attributes FND";
        // Language: Record Language; // BC Upgrade RAHUL Commenting As Function Moved from Table to Codeunit.
        GLSetup: Record "General Ledger Setup";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        ItemCh: Record "Item Charge";
        ItemChargeRec: Record "Item Charge";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesInvLine: Record "Sales Line";
        SalesInvLineAmt: Record "Sales Line";
        TempUnderChargeLine: Record "Sales Line" temporary;
        TotalSalesline: Record "Sales Line";
        SalesPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        DocumentTotals: Codeunit "Document Totals";

        LanguageG: Codeunit Language;//BC UPGRADE RAHUL Adding Codeunit as Function Moved from Record to Codeunit.
        SalesInvCountPrinted: Codeunit "Sales-Printed";
        ExportInvoice: Boolean;
        HideDiscount: Boolean;
        IsDeposit: Boolean;
        IsDiscount: Boolean;
        IsNotUnderitem: Boolean;
        PrintDiscounts: Boolean;
        PrintUnderLineCharge: Boolean;
        Var_typechargeItem: Boolean;
        CurrencyCode: Code[10];
        CustomerNo: Code[20];
        PrintingTime: DateTime;
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
        ShippingChrgAmnt: Decimal;
        SubTotalCharges: Decimal;
        TaxAmout: Decimal;
        TotalAmountLCY: Decimal;
        TotalDepositFooterAmount: array[6] of Decimal;
        TotalDiscount: Decimal;
        TotalFooterAmount: array[8] of Decimal;
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
        InvalidTxt: Label '**INVALID WITHOUT FISCAL OR REFUND RECEIPT ATTACHED**';
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
        Text52006: Label 'Order Confirmation';
        Text52007: Label 'Sundry Invoice';
        Text52008: Label 'Export Invoice';
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
        CustomerAddress: Text[240];
        CustomerAttributestext: Text[1024];
        Text52003: TextConst ENU = 'VAT @ %1 ', FRA = 'TVA @ %1';
}

