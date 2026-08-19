report 53008 "Credit Note STD"
{
    // version HEI.12

    // HEI.01 Report created
    // HEI.03 INC1003205 IBM HORTOC01 04.12.2018 #add new item charge discount
    // HEI.04 HT434 CHG2011093 Defect # 4329 IBM GAVANM01 20.08.2019
    //   # add OpCo footer image
    // HEI.05 CHG2031911 Defect # 4329 IBM GAVANM01 19.09.2019  # add info in footer from Company Info
    // HEI.06 IBM BULIMC01 25.10.2019 # defect 4627 # code added
    //    #new variable created (lineNumberVAT)
    //    # data item TEMPAccSchedKPIBuffer_VatPercent changed
    // HEI.07 CHG2062657 HB1368 IBM GAVANM01 29.04.2020 #Correction to Invoice/Credit Note - Shipping Charge
    //   # code and layout changes
    // HEI.08 INC2918336 IBM NASTAA02 29.06.2020 # Printing multiple invoices
    //   # Implemented SetData, GetData functions on layout for the header text boxes
    // HEI.09 CHG2070324 IBM.GUNERE01 02.07.2020 # modifications on layout, DataSource SalesDiscount1 modified,
    //                                            PageLoop - OnAfterGetRecord, Sales Invoice Line - OnAfterGetRecord funcs.
    //                                            modified.
    // HEI.10 CHG2070787 IBM GAVANM01 02.09.2020 Update all Billing documents in line with Global (for the BAHAMAS)
    //   # Add Standard Text Report functionality for footer texts
    // HEI.11 CHG2073371 HB1589 IBM GAVANM01 28.09.2020  #St Lucia Item charges Shipping Cost not working
    //   # Item charges of type Discount and Transport/Shipping Cost = TRUE should be considered as Shipping Cost
    // HEI.12 INC4019421 - CHG2151382 IBM NASTAA02 18.03.2021 # When printing a sales invoice the "Subtotal Srd Excl.Vat " amount , differs from the "Subtotal incl VAT" amount and the total "To be paid amount"
    //   # Updated Subtotal Excl VAT calculation formula on layout

    // BC Upgrade RAHUL>> 
    // 1. Blocking Drink-IT Field ("Sales Invoice Line".Weight,"Item Charge Type"::Discount,SalesInvoiceLine."Show Item charge on Invoice","Sales Invoice Line"."Free Item").
    // 2. Adding Application Area to the Action on Request Page to Field(No. of Copies).
    // 3. Blocked whole loop as dependency on DIT(Field-"Item Charge Type").
    // 4. Added ApplicationArea = All and UsageCategory = ReportsAndAnalysis properties to report level for BC visibility and searchability
    // 5. Commented out variable declarations for Drink-IT custom tables:(StandardTextReport: Record 2014410)
    // 6. Replaced Language.GetLanguageID with Language Codeunit approach for BC compatibility:
    //     - Added LanguageMgt: Codeunit Language variable
    //     - Added LanguageID: Integer variable
    //     - Changed from: CurrReport.LANGUAGE := Language1.GetLanguageID("Language Code")
    //     - Changed to: LanguageID := LanguageMgt.GetLanguageIdOrDefault("Language Code"); CurrReport.Language := LanguageID
    // 7. Commented out Drink-IT fields "Item Charge Type" and "Show Item charge on Invoice" logic:
    //    - SalesInvLineAmt calculation loop (InvLineTotal calculation)
    //    - SalesInvLine Item Charge Type CASE statement (Tax, Deposit, Shipping Cost, Discount calculations)
    //    - Multiple IF conditions checking Item Charge Type
    // 8. Blocking Code of  (CompanyInfo."Tax Registration No."). 
    // 9. Blocking as Wrong Expression.  DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where(Type = filter(Item | Resource | "Fixed Asset" | "Charge (Item)")); 
    // 10. Old Report ID - 50262
    // BC Upgrade RAHUL<<

    DefaultLayout = RDLC;

    RDLCLayout = '.\src\ReportsLayout\Credit Note STD.rdl';

    Caption = 'Credit Note STD';
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;
    ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL Adding Usagecategory

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = sorting("No.");
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
                    column(SalesHCustNo; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SalesHPostDate; Format("Sales Cr.Memo Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesHDueDate; Format("Sales Cr.Memo Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesHDocDate; Format("Sales Cr.Memo Header"."Document Date", 0, 4))
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
                    column(SellCustomerNo; "Sales Cr.Memo Header"."Sell-to Customer No.")
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
                    column(ItemChargeDisc; ItemChargeDisc)
                    {
                    }
                    column(InvDisAmount; InvDisAmount)
                    {
                    }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(Item | Resource | "Fixed Asset" | "Charge (Item)")); // BC Upgrade Rahul Adding as Wrong Expression was Used('"Charge (Item)"').
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
                        column(SalesQty; "Sales Cr.Memo Line".Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesUOM; "Sales Cr.Memo Line"."Unit of Measure Code")
                        {
                        }
                        column(SalesPrice; Round("Sales Cr.Memo Line"."Unit Price", 0.01, '='))
                        {
                        }
                        column(SalesVATPer; "Sales Cr.Memo Line"."VAT %")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesAmount; "Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Price")
                        {
                        }
                        column(TotalQuantity; TotalQty)
                        {
                        }
                        column(SalesDiscount; "Sales Cr.Memo Line"."Line Discount Amount")
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
                            SalesInvoiceLine: Record "Sales Cr.Memo Line";
                        begin
                            //HEI.07>>
                            DiscIncluded := 0;
                            UnitPrice := "Unit Price";
                            LineAmount := "Line Amount";

                            if Type <> Type::"Charge (Item)" then begin
                                //Include in Item Price
                                SalesInvoiceLine.Reset();
                                SalesInvoiceLine.SetRange("Document No.", "Document No.");
                                SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::"Charge (Item)");
                                SalesInvoiceLine.SetRange("Attached to Line No.", "Line No.");
                                // SalesInvoiceLine.SETRANGE("Item Charge Type", SalesInvoiceLine."Item Charge Type"::Discount); // BC Upgrade RAHUL << - Blocked as dependency on Drink-IT Field
                                // SalesInvoiceLine.SETRANGE("Show Item charge on Invoice", SalesInvoiceLine."Show Item charge on Invoice"::"Include in item price"); // BC Upgrade RAHUL << - Blocked as dependency on Drink-IT Field
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
                                // end else if ("Sales Invoice Line"."Item Charge Type" = "Sales Invoice Line"."Item Charge Type"::Discount) and
                                //   ("Show Item charge on Invoice" = "Show Item charge on Invoice"::"Include in item price") then
                                //         if ItemCh.GET("No.") and not ItemCh."Transport/Shipping Cost" then   //HEI.09
                                //             CurrReport.SKIP;
                                //BC Upgrade RAHUL << Blocking Lope DIT Field
                                //HEI.07<<
                            end;
                            /*//commented by HEI.07 >>
                            IF ("Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::"Charge (Item)")
                              AND ("Sales Cr.Memo Line"."Item Charge Type" <> "Sales Cr.Memo Line"."Item Charge Type"::" ") THEN
                                CurrReport.SKIP
                            ELSE BEGIN
                            *///HEI.07<<
                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;

                            TotalInvDis += Abs("Sales Cr.Memo Line"."Line Discount Amount");
                            //END;  //commented by HEI.07

                            //var_Dis := ABS("Line Discount Amount");
                            var_Dis := "Line Discount Amount"; //HEI.09

                            // if (Type = Type::"Charge (Item)") and ("Item Charge Type" = "Item Charge Type"::Discount) then //BC Upgrade RAHUL << Blocking  DIT Field

                            if ItemCh.Get("No.") and not ItemCh."Transport/Shipping Cost FND" then  //HEI.11
                                                                                                //var_Dis += ABS("Line Amount");
                                var_Dis += "Line Amount"; //HEI.09


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
                        Clear(ItemChargeDisc);  //HEI.07

                        DocumentTitleText := StrSubstNo(Text52006, CopyText);

                        // BC Upgrade RAHUL << - Blocked whole loop as dependency on Drink-IT Field
                        // SalesInvLineAmt.RESET;
                        // SalesInvLineAmt.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        // //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3|%4',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset",SalesInvLineAmt.Type::"G/L Account");  //commented by HEI.11
                        // if SalesInvLineAmt.FINDSET then
                        //     repeat
                        //         if (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") or (SalesInvLineAmt."Item Charge Type" = SalesInvLineAmt."Item Charge Type"::" ") then  //HEI.11
                        //             InvLineTotal += SalesInvLineAmt."Line Amount";
                        //     until SalesInvLineAmt.NEXT = 0;
                        // BC Upgrade RAHUL >> - Blocked whole loop as dependency on Drink-IT Field

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;

                        // BC Upgrade RAHUL >> - Blocked whole for loop  as dependency on DIT
                        // SalesInvLine.RESET;
                        // SalesInvLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        // SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        // if SalesInvLine.FINDSET then
                        //     repeat
                        //         case SalesInvLine."Item Charge Type" of
                        //             SalesInvLine."Item Charge Type"::Tax:
                        //                 TotalFooterAmount[1] += SalesInvLine."Line Amount";
                        //             SalesInvLine."Item Charge Type"::Deposit:
                        //                 TotalFooterAmount[2] += SalesInvLine."Line Amount";
                        //             SalesInvLine."Item Charge Type"::"Shipping Cost":
                        //                 TotalFooterAmount[3] += SalesInvLine."Line Amount";
                        //             SalesInvLine."Item Charge Type"::Discount:
                        //                 //HEI.11>>
                        //                 begin
                        //                     if ItemCh.GET(SalesInvLine."No.") and ItemCh."Transport/Shipping Cost" then
                        //                         TotalFooterAmount[3] += SalesInvLine."Line Amount"
                        //                     else
                        //                         //HEI.11<<
                        //                         if SalesInvLine."Show Item charge on Invoice" <> SalesInvLine."Show Item charge on Invoice"::"Include in item price" then
                        //                             //TotalFooterAmount[4] += ABS(SalesInvLine."Line Amount");
                        //                             TotalFooterAmount[4] += SalesInvLine."Line Amount"; //HEI.09
                        //                 end;  //HEI.11
                        //         end;
                        //     until SalesInvLine.NEXT = 0;
                        // BC Upgrade RAHUL << - Blocked whole loop as dependency on Drink-IT Field

                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        ShipAmount := TotalFooterAmount[3];  //HEI.07

                        SalesInvLine.Reset();
                        SalesInvLine.SetRange("Document No.", "Sales Cr.Memo Header"."No.");
                        //SalesInvLine.SETRANGE(Type,SalesInvLine.Type::"Charge (Item)");  //commented by HEI.07
                        if SalesInvLine.FindSet() then
                            repeat
                                TotalFooterAmount[4] += Abs(SalesInvLine."Inv. Discount Amount");
                                TotalFooterAmountText[4] := SalesInvLine.FieldCaption("Inv. Discount Amount");
                                TotalFooterAmount[5] += SalesInvLine."Line Discount Amount";
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
                    Clear(ItemChargeDisc);  //HEI.07
                end;

                trigger OnPostDataItem();
                begin
                    SalesInvCountPrinted.Run("Sales Cr.Memo Header");
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
                //HEI.10>>
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
                // BC Upgrade RAHUL >> ----Drink-IT Table ("StandardTextReport")
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
                // BC Upgrade RAHUL << ----Drink-IT Table ("StandardTextReport")
                //HEI.10<<

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

                // BC Upgrade RAHUL << - Blocked whole loop as dependency on Drink-IT Field
                // if CompanyInfo."Tax Registration No." <> '' then
                //     CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                // BC Upgrade RAHUL >> - Blocked whole loop as dependency on Drink-IT Field

                //CompanyText += ', ' + ChOfComm;
                if CompanyInfo."Phone No." <> '' then
                    CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                if CompanyInfo."Fax No." <> '' then
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                /*IF CompanyInfo."E-Mail" <> '' THEN
                  CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";*/ //commented by HEI.10
                                                                                  //HEI.05<<

                TEMPAccSchedKPIBuffer.DeleteAll();
                if Country.Get(CompanyInfo."Country/Region Code") then
                    CompanyInfoContryName := Country.Name;

                // CurrReport.Language := Language.GetLanguageID("Language Code"); //BC Upgrade RAHUL GetlanguageId moved from Table to CU.
                CurrReport.Language := LanguageG.GetLanguageId("Language Code"); //BC Upgrade RAHUL GetlanguageId moved from Table to CU.

                if SalesPerson.Get("Sales Cr.Memo Header"."Salesperson Code") then;

                if ShipmentMethod.Get("Sales Cr.Memo Header"."Shipment Method Code") then
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Cr.Memo Header"."Language Code");

                if PaymentTerms.Get("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Cr.Memo Header"."Language Code");

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
                if Customer.Get("Sales Cr.Memo Header"."Bill-to Customer No.") then begin
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
                if CustomerAttributes.Get("Sales Cr.Memo Header"."Bill-to Customer No.") then begin
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
                SalesInvLine.SetRange("Document No.", "Sales Cr.Memo Header"."No.");
                SalesInvLine.SetFilter("VAT %", '<>%1', 0);
                if SalesInvLine.FindFirst() then
                    VATPer := SalesInvLine."VAT %";

                if "Sales Cr.Memo Header"."Prices Including VAT" = true then
                    PriceIncVAT := 'Yes'
                else
                    PriceIncVAT := 'No';

                VatAmt := 0;
                lineNumberVAT := 0;  //HEI.06
                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", "Sales Cr.Memo Header"."No.");
                SalesInvLine.SetFilter("VAT %", '<>%1', 0);
                if SalesInvLine.FindSet() then
                    repeat
                        VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                        VATAmount := Abs(VatAmt);

                        //split VAT
                        //IF TEMPAccSchedKPIBuffer.GET(SalesInvLine."VAT %") THEN BEGIN //commented by HEI.06
                        TEMPAccSchedKPIBuffer.Reset(); //HEI.06
                        TEMPAccSchedKPIBuffer.SetRange("Balance at Date Forecast", SalesInvLine."VAT %"); //HEI.06
                        if TEMPAccSchedKPIBuffer.FindFirst() then begin //HEI.06
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.Modify();

                        end else begin
                            //TEMPAccSchedKPIBuffer."No." := SalesInvLine."VAT %";   //commented by HEI.06
                            //HEI.06>>
                            lineNumberVAT += 1;
                            TEMPAccSchedKPIBuffer.Init();
                            TEMPAccSchedKPIBuffer."No." := lineNumberVAT;
                            TEMPAccSchedKPIBuffer."Balance at Date Forecast" := SalesInvLine."VAT %";
                            //HEI.06<<
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.Insert();
                        end;
                    until SalesInvLine.Next() = 0;

                TEMPAccSchedKPIBuffer.Reset();
                if TEMPAccSchedKPIBuffer.FindSet() then
                    repeat
                        Counter += 1;
                        //SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."No.") + '%'; //commented by HEI.06
                        SplitVatPercent[Counter] := Format(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%'; //HEI.06
                        SplitVatAmount[Counter] := Format(TEMPAccSchedKPIBuffer."Net Change Budget", 0, '<Sign><Integer Thousand><Decimals,3>');
                    until TEMPAccSchedKPIBuffer.Next() = 0;

                BillToCustomer.Get("Sales Cr.Memo Header"."Bill-to Customer No.");
                SoldToCustomer.Get("Sales Cr.Memo Header"."Sell-to Customer No.");
                if BillToCountry.Get(BillToCustomer."Country/Region Code") then;
                if SoldToCountry.Get(SoldToCustomer."Country/Region Code") then;

                if "Sales Cr.Memo Header"."No. Printed" = 0 then
                    OriginalCopy := Text50004
                else
                    OriginalCopy := Text52000;

                "Sales Cr.Memo Header".CalcFields("Amount Including VAT");
                TotalAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(Today, "Sales Cr.Memo Header"."Currency Code", "Sales Cr.Memo Header"."Amount Including VAT", CurrExchRate.ExchangeRate(Today, "Sales Cr.Memo Header"."Currency Code"));

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
            area(Content)
            {
                group("Sales Order")
                {
                    Caption = 'Sales Order';
                    field("No. of Copies"; NoOfCopies)
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
        lblTotalQty = 'Total Quantity'; lblSalesPerson = 'Sales Person ID:'; lblUOM = 'Unit'; lblUnitPrice = 'Unit Price'; lblSaleLAmt = 'Amount Excl. VAT'; lblPageNo = 'Page No:'; lblOrderNo = 'RO Order No:'; lblInvoiceNo = 'Credit Note No:'; lblVATAmt = 'Total VAT:'; lblPostDate = 'Credit memo Date:'; lblDueDate = 'Due Date:'; lblPriceIncVAT = 'Price Including VAT'; lblDriver = 'Name and Driver Signature'; lblWarehouse = 'Name and Warehouse Keeper Signature'; lblSecurity = 'Name and Security Visa'; label(lblPrintDate; ENU = 'Print Date:',
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              FRA = 'Date d''impression')
        LblBillToAddress = 'BILL TO:'; LblCustomerName = 'Customer Name:'; LblAddress = 'Address 1:'; LblAddress2 = 'Address 2:'; LblPostCode = 'Post Code:'; LblCity = 'City:'; LblCountry = 'Country:'; LblVatRegistrationNo = 'Vat Registration No:'; LblCompanyTaxId = 'Company Tax ID:'; LblSoldToAddress = 'CUSTOMER:'; LblCustomerPoNo = 'Customer PO No:'; LblTaxDetails = 'Tax Summary'; LblBankInfo = 'Bank Details:'; LblAccountNo = 'Account No:'; LblBankName = 'Bank:'; LblGiro = 'Giro No.'; LblIban = 'Iban:'; LblSwiftCode = 'Swift Code:'; LblSignature = 'Signature:'; LblVatPercent = 'Vat Percent'; LblVatAmount = 'Vat Amount'; LblIncoTerm = 'InCo Terms:'; Lbldisc = 'Disc.'; LblShipToAddress = 'SHIP TO ADDRESS:'; LblCustomerNo = 'Customer No:'; LblInvoiceCurrency = 'CN. Currency:'; LblVersion = 'Version:'; LblItemNo = 'Item No.'; LblQty = 'Qty'; LblPayMethod = 'Payment Method:'; LblInvoiceCurrLCY = 'Credit No Curr LCY:'; LblTotalToBePaid = 'Total to be paid:'; LblDiscTotal = 'Disc Total:'; CustomerServiceEmailLbl = 'Customer Service E-Mail:';
    }

    trigger OnInitReport();
    begin
        GLSetup.Get();
        SalesSetup.Get();  //HEI.10
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture, "OpCo Footer image FND");   //HEI.04
    end;

    var
        CompanyInfo: Record "Company Information";
        LanguageG: Codeunit Language;//BC UPGRADE RAHUL Adding Codeunit as Function Moved from Record to Codeunit.
        Country: Record "Country/Region";
        VATEntry: Record "VAT Entry";
        // Language: Record Language; //BC UPGRADE RAHUL Blocking Table Variable as Function Moved from Record to Codeunit.
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
        Text52005: Label 'Subtotal %1 Excl. VAT:';
        Text52005B: Label 'Subtotal %1 Incl. VAT:';
        Text52006: Label 'Credit Note';
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
        CompanyText: Text;
        CountryInfo: Record "Country/Region";
        TaxNoID: Label 'Tax Number ID:';
        ChOfComm: Label 'Chamber of commerce:';
        ContactNo: Label 'Contact Number:';
        FaxNo: Label 'Fax Number:';
        EmailComp: Label 'E-mail:';
        lineNumberVAT: Integer;
        ItemChargeDisc: Decimal;
        InvDisAmount: Decimal;
        UnitPrice: Decimal;
        LineAmount: Decimal;
        DiscIncluded: Decimal;
        var_Dis: Decimal;
        // StandardTextReport: Record "Standard Text Report"; // BC Upgrade RAHUL << ----Drink-IT Table ("StandardTextReport")
        TextFooter: array[3] of Text;
        CurrencyCode: Code[10];
        ItemCh: Record "Item Charge";
}

