report 53014 "Proforma Invoice STD"
{
    // version HEI.08

    // HEI.01 Report created
    // HEI.03 INC1003205 IBM HORTOC01 04.12.2018 #add new item charge discount
    // HEI.04 HT434 CHG2011093 Defect # 4329 IBM GAVANM01 20.08.2019
    //   # add OpCo footer image
    // HEI.05 CHG2031911 Defect # 4329 IBM GAVANM01 19.09.2019  # add info in footer from Company Info
    // HEI.06 IBM BULIMC01 25.10.2019 # defect 4627 # code added
    //    #new variable created (lineNumberVAT)
    //    # data item TEMPAccSchedKPIBuffer_VatPercent changed
    // HEI.07 HB1368 IBM GAVANM01 29.04.2020 #Correction to Invoice/Credit Note - Shipping Charge
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

    // BC Upgrade RAHUL>>
    // 1. Added ApplicationArea = All property at report level for BC visibility.
    //    Old: ApplicationArea property not defined at report level.
    //    New: ApplicationArea = All added at report level.
    // 2. Added UsageCategory = ReportsAndAnalysis property at report level for BC search.
    //    Old: UsageCategory not defined.
    //    New: UsageCategory = ReportsAndAnalysis added.
    // 3. Corrected Sales Line DataItemTableView filter expression for Type values.
    //    Old: DataItemTableView used wrong filter expression with quoted values:
    //         where(Type = filter(Item | Resource | "Fixed Asset" | '"Charge (Item)"'));
    //    New: Updated to valid BC expression:
    //         where(Type = filter(Item | Resource | "Fixed Asset" | "Charge (Item)"));
    // 4. Blocked Item Charge related filters and logic due to missing/DIT fields in upgraded BC base.
    //    Old: Code depended on fields like:
    //         - "Item Charge Type"
    //         - "Show Item charge on Invoice"
    //    New: Commented out SETRANGE/conditions and the ELSE branch using these fields to avoid compile/runtime issues.
    // 5. Blocked Item Charge footer breakup calculation due to DIT fields dependency.
    //    Old: Footer amount calculation loop categorized Charge(Item) by "Item Charge Type" (Tax/Deposit/Shipping/Discount).
    //    New: Entire section commented out because "Item Charge Type" and "Show Item charge on Invoice" are not available.
    // 6. Blocked Standard Text Report footer text functionality due to missing object/variable in upgraded BC.
    //    Old: StandardTextReport: Record "Standard Text Report" used with Extended Text Header/Line to build TextFooter[].
    //    New: StandardTextReport variable and related footer population logic commented out.
    // 7. Blocked CompanyInfo."Tax Registration No." in CompanyText due to field incompatibility in upgraded BC.
    //    Old: CompanyText appended CompanyInfo."Tax Registration No.".
    //    New: Logic commented out with BC Upgrade note.
    // 8. Updated report language handling to use Codeunit Language.
    //    Old: CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
    //         Language variable was Record Language.
    //    New: CurrReport.Language := RecLanguage.GetLanguageID("Language Code");
    //         RecLanguage variable declared as Codeunit Language.
    // 9. Added ApplicationArea = All on Request Page field "No. of Copies" for BC compliance.
    //    Old: Request page field missing ApplicationArea.
    //    New: ApplicationArea = All added.
    // 10. Report upgrade reference.
    //     Old Report ID: 50279
    //     New: Upgraded for BC with above compatibility changes.
    // 11. Blocking Colomn As DIT Field("Sales Header"."Order No.");
    // BC Upgrade RAHUL<<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Proforma Invoice STD.rdl';
    ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL Adding Usagecategory
    Caption = 'Proforma Invoice STD';
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
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
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
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
                    column(SalesHOrdNo; "Sales Header"."No.") // BC Upgrade SHUKLP03 
                    {
                    }
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
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        // DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(Item | Resource | "Fixed Asset" | '"Charge (Item)"')); // BC Upgrade RAHUL Blocking as Wrong Expression.
                        DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(Item | Resource | "Fixed Asset" | "Charge (Item)")); // BC Upgrade RAHUL Adding as Wrong Expression was Used.
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
                            UnitPrice := "Unit Price";
                            LineAmount := "Line Amount";

                            if Type <> Type::"Charge (Item)" then begin
                                //Include in Item Price
                                SalesInvoiceLine.RESET();
                                SalesInvoiceLine.SETRANGE("Document Type", "Document Type");
                                SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                                SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
                                SalesInvoiceLine.SETRANGE("Attached to Line No.", "Line No.");
                                SalesInvoiceLine.SETRANGE("Attached Line Type 101FDW", SalesInvoiceLine."Attached Line Type 101FDW"::"SPC 105FDW"); // BC Upgrade SHUKLP03
                                SalesInvoiceLine.SETRANGE("Show Item charge on Inv. FND", SalesInvoiceLine."Show Item charge on Inv. FND"::"Include in item price"); // BC Upgrade SHUKLP03
                                if SalesInvoiceLine.FINDSET() then
                                    repeat
                                        if ItemCh.GET(SalesInvoiceLine."No.") and not ItemCh."Transport/Shipping Cost FND" then begin  //HEI.11
                                            LineAmount += SalesInvoiceLine."Line Amount";
                                            //DiscIncluded += ABS(SalesInvoiceLine."Line Amount");
                                            DiscIncluded += SalesInvoiceLine."Line Amount"; //HEI.09
                                            if SalesInvoiceLine.Quantity <> 0 then
                                                UnitPrice := LineAmount / ABS(Quantity);
                                        end //HEI.11
                                    until SalesInvoiceLine.NEXT() = 0;
                            end
                            // BC Upgrade SHUKLP03 >> 
                            else if ("Attached Line Type 101FDW" = "Attached Line Type 101FDW"::"SPC 105FDW") and
                              ("Show Item charge on Inv. FND" = "Show Item charge on Inv. FND"::"Include in item price") then
                                if ItemCh.GET("No.") and not ItemCh."Transport/Shipping Cost FND" then   //HEI.11
                                    CurrReport.SKIP();
                            // BC Upgrade SHUKLP03 <<                            
                            //HEI.07<<

                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;

                            TotalInvDis += ABS("Sales Line"."Line Discount Amount");

                            //var_Dis := ABS("Line Discount Amount");
                            var_Dis := "Line Discount Amount"; //HEI.09
                                                               // if (Type = Type::"Charge (Item)") and ("Item Charge Type" = "Item Charge Type"::Discount) then // BC Upgrade RAHUL Blocking
                            if ItemCh.GET("No.") and not ItemCh."Transport/Shipping Cost FND" then  //HEI.11
                                                                                                    //var_Dis += ABS("Line Amount");
                                var_Dis += "Line Amount"; //HEI.09
                        end;
                    }
                    dataitem(SplitVatAmt; "Integer")
                    {
                        column(TEMPAccSchedKPIBuffer_VatPercent; FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast"))
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
                        CLEAR(ItemChargeDisc);  //HEI.07

                        DocumentTitleText := STRSUBSTNO(Text52006, CopyText);

                        SalesInvLineAmt.RESET();
                        SalesInvLineAmt.SETRANGE("Document Type", "Sales Header"."Document Type");
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Header"."No.");
                        //SalesInvLineAmt.SETFILTER(Type,'%1|%2|%3|%4',SalesInvLineAmt.Type::Item,SalesInvLineAmt.Type::Resource,SalesInvLineAmt.Type::"Fixed Asset",SalesInvLineAmt.Type::"G/L Account");  //commented by HEI.11
                        if SalesInvLineAmt.FINDSET() then
                            repeat
                                if (SalesInvLineAmt.Type <> SalesInvLineAmt.Type::"Charge (Item)") or (SalesInvLineAmt."Attached to Line No." = 0) then  //HEI.11 // BC Upgrade SHUKLP03 
                                    InvLineTotal += SalesInvLineAmt."Line Amount";
                            until SalesInvLineAmt.NEXT() = 0;

                        TotalFooterAmountText[1] := Text50001;
                        TotalFooterAmountText[2] := Text50002;
                        TotalFooterAmountText[6] := Text50003;

                        // BC Upgrade SHUKLP03 >>
                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document Type", "Sales Header"."Document Type");
                        SalesInvLine.SETRANGE("Document No.", "Sales Header"."No.");
                        SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        if SalesInvLine.FINDSET() then
                            repeat
                                case SalesInvLine."Attached Line Type 101FDW" of
                                    SalesInvLine."Attached Line Type 101FDW"::"TAX 102FDW":
                                        TotalFooterAmount[1] += SalesInvLine."Line Amount";
                                    SalesInvLine."Attached Line Type 101FDW"::"EGM 104FDW":
                                        TotalFooterAmount[2] += SalesInvLine."Line Amount";
                                    // SalesInvLine."Attached Line Type 101FDW"::ShippingCost:
                                    //     TotalFooterAmount[3] += SalesInvLine."Line Amount";
                                    SalesInvLine."Attached Line Type 101FDW"::"SPC 105FDW":
                                        //HEI.11>>
                                        if ItemCh.GET(SalesInvLine."No.") and ItemCh."Transport/Shipping Cost FND" then
                                            TotalFooterAmount[3] += SalesInvLine."Line Amount"
                                        else
                                            //HEI.11<<
                                            if SalesInvLine."Show Item charge on Inv. FND" <> SalesInvLine."Show Item charge on Inv. FND"::"Include in item price" then
                                                //TotalFooterAmount[4] += ABS(SalesInvLine."Line Amount");
                                                TotalFooterAmount[4] += SalesInvLine."Line Amount"; //HEI.09
                                end  //HEI.11
                            until SalesInvLine.NEXT() = 0;
                        // BC Upgrade SHUKLP03 <<

                        TaxAmout := TotalFooterAmount[1];
                        DepAmount := TotalFooterAmount[2];
                        ShipAmount := TotalFooterAmount[3];  //HEI.07

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document Type", "Sales Header"."Document Type");
                        SalesInvLine.SETRANGE("Document No.", "Sales Header"."No.");
                        //SalesInvLine.SETRANGE(Type,SalesInvLine.Type::"Charge (Item)");  //commented by HEI.07
                        if SalesInvLine.FINDSET() then
                            repeat
                                TotalFooterAmount[4] += ABS(SalesInvLine."Inv. Discount Amount");
                                TotalFooterAmountText[4] := SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                                TotalFooterAmount[5] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[5] := SalesInvLine.FIELDCAPTION("Line Discount Amount");
                            until SalesInvLine.NEXT() = 0;

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
                        ELSE
                          Check.FormatNoText(DescriptionLine,ROUND(ROUND(InvLineTotal,1,'=') + VATAmount + TaxAmout + DepAmount + ShipAmount,0.01,'='),"Sales Header"."Currency Code");
                        */ //commented by HEI.07<<

                        Check.FormatNoText(DescriptionLine, "Sales Header"."Amount Including VAT", "Sales Header"."Currency Code"); //HEI.07

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
                    CLEAR(ItemChargeDisc);  //HEI.07
                end;

                trigger OnPostDataItem();
                begin
                    SalesInvCountPrinted.RUN("Sales Header");
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
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
                CurrReportID: Integer;
                i: Integer;
            begin
                //HEI.10>>
                //-----Currency
                if "Currency Code" <> '' then
                    CurrencyCode := "Currency Code"
                else
                    CurrencyCode := GLSetup."LCY Code";

                //-----Footer Texts
                // BC Upgrade SHUKLP03 >>
                CLEAR(CurrReportID);
                CLEAR(i);
                CLEAR(TextFooter);
                EVALUATE(CurrReportID, COPYSTR(CurrReport.OBJECTID(false), 8));
                StandardTextReport.SETRANGE("Report ID", CurrReportID);
                StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);
                if StandardTextReport.FINDSET() then
                    repeat
                        i := 1;
                        ExtendedTextHeader.RESET();
                        ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                        ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                        if ExtendedTextHeader.FINDSET() then
                            repeat
                                ExtendedTextLine.RESET();
                                ExtendedTextLine.SETRANGE("Table Name", ExtendedTextHeader."Table Name");
                                ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                                ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                                ExtendedTextLine.SETRANGE("Language Code", "Language Code");
                                if ExtendedTextHeader."All Language Codes" then
                                    ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
                                if ExtendedTextLine.FINDSET() then
                                    repeat
                                        TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                                    until (ExtendedTextLine.NEXT() = 0) or (i > ARRAYLEN(TextFooter));
                                i += 1;
                            until (ExtendedTextHeader.NEXT() = 0);
                    until (StandardTextReport.NEXT() = 0);
                // BC Upgrade SHUKLP03  <<
                //HEI.10<<

                //HEI.05>>
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
                // BC Upgrade SHUKLP03 >> ---- Field ("Tax Registration No.")
                CUSTOMSDOCManage.get();
                IF CUSTOMSDOCManage."Tax Registration No." <> '' THEN
                    CompanyText += ', ' + TaxNoID + ' ' + CUSTOMSDOCManage."Tax Registration No.";
                // BC Upgrade SHUKLP03 << ---- Field ("Tax Registration No.")

                //CompanyText += ', ' + ChOfComm;
                if CompanyInfo."Phone No." <> '' then
                    CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                if CompanyInfo."Fax No." <> '' then
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                /*IF CompanyInfo."E-Mail" <> '' THEN
                  CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";*/ //commented by HEI.10
                                                                                  //HEI.05<<

                TEMPAccSchedKPIBuffer.DELETEALL();
                if Country.GET(CompanyInfo."Country/Region Code") then
                    CompanyInfoContryName := Country.Name;

                // CurrReport.LANGUAGE := Language.GetLanguageID("Language Code //BC Upgrade RAHUL Blocking as function moved to codeunit.
                CurrReport.Language := RecLanguage.GetLanguageID("Language Code"); //BC Upgrade RAHUL Adding as Fnc moved to codeunit.

                if SalesPerson.GET("Sales Header"."Salesperson Code") then;

                if ShipmentMethod.GET("Sales Header"."Shipment Method Code") then
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Header"."Language Code");

                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Header"."Language Code");

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
                if Customer.GET("Sales Header"."Bill-to Customer No.") then begin
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
                if CustomerAttributes.GET("Sales Header"."Bill-to Customer No.") then begin
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



                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document Type", "Sales Header"."Document Type");
                SalesInvLine.SETRANGE("Document No.", "Sales Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.FINDFIRST() then
                    VATPer := SalesInvLine."VAT %";

                if "Sales Header"."Prices Including VAT" = true then
                    PriceIncVAT := 'Yes'
                else
                    PriceIncVAT := 'No';

                VatAmt := 0;
                lineNumberVAT := 0;  //HEI.06
                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document Type", "Sales Header"."Document Type");
                SalesInvLine.SETRANGE("Document No.", "Sales Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.FINDSET() then
                    repeat
                        VatAmt += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                        VATAmount := ABS(VatAmt);

                        //split VAT
                        //IF TEMPAccSchedKPIBuffer.GET(SalesInvLine."VAT %") THEN BEGIN  //commented by HEI.06
                        //HEI.06>>
                        TEMPAccSchedKPIBuffer.RESET();
                        TEMPAccSchedKPIBuffer.SETRANGE("Balance at Date Forecast", SalesInvLine."VAT %");
                        if TEMPAccSchedKPIBuffer.FINDFIRST() then begin
                            //HEI.06<<
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.MODIFY();
                        end else begin
                            //TEMPAccSchedKPIBuffer."No." := SalesInvLine."VAT %";   //commented by HEI.06
                            //HEI.06>>
                            lineNumberVAT += 1;
                            TEMPAccSchedKPIBuffer.INIT();
                            TEMPAccSchedKPIBuffer."No." := lineNumberVAT;
                            TEMPAccSchedKPIBuffer."Balance at Date Forecast" := SalesInvLine."VAT %";
                            //HEI.06<<
                            TEMPAccSchedKPIBuffer."Net Change Budget" += (SalesInvLine."VAT Base Amount" * SalesInvLine."VAT %") / 100;
                            TEMPAccSchedKPIBuffer.INSERT();
                        end;
                    until SalesInvLine.NEXT() = 0;

                TEMPAccSchedKPIBuffer.RESET();
                if TEMPAccSchedKPIBuffer.FINDSET() then
                    repeat
                        Counter += 1;
                        //SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."No.") + '%'; //commented HEI.06
                        SplitVatPercent[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Balance at Date Forecast") + '%'; //HEI.06
                        SplitVatAmount[Counter] := FORMAT(TEMPAccSchedKPIBuffer."Net Change Budget", 0, '<Sign><Integer Thousand><Decimals,3>');
                    until TEMPAccSchedKPIBuffer.NEXT() = 0;

                BillToCustomer.GET("Sales Header"."Bill-to Customer No.");
                SoldToCustomer.GET("Sales Header"."Sell-to Customer No.");
                if BillToCountry.GET(BillToCustomer."Country/Region Code") then;
                if SoldToCountry.GET(SoldToCustomer."Country/Region Code") then;

                if "Sales Header"."No. Printed" = 0 then
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
                        ApplicationArea = all; //BC Upgrade RAHUL Adding Application Area
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
        // Language: Record Language; //BC Upgrade RAHUL Blocking due to Fnc Moved to codeunit from Table
        RecLanguage: Codeunit Language; //BC Upgrade RAHUL Adding As to Fnc Moved to codeunit from Table
        SalesInvCountPrinted: Codeunit "Sales-Printed";
        CurrencyCode: Code[10];
        CustomerNo: Code[20];
        AmttoPaid: Decimal;
        BaseMarginAmt: Decimal;
        DepAmount: Decimal;
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
        StandardTextReport: Record "Standard Text Report FND";//BC Upgrade SHUKLP03  <<
        CUSTOMSDOCManage: Record CustomsDocMgtSetup113FDW; // BC Upgrade SHUKLP03 <<
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
        TotalDepositFooterAmountText: array[6] of Text[50];
        TotalFooterAmountText: array[7] of Text[50];
        DescriptionLine: array[2] of Text[85];
        CustomerAddress: Text[240];
        CustomerAttributestext: Text[1024];
        Text52003: TextConst ENU = 'VAT @ %1 ', FRA = 'TVA @ %1';
}

