report 53030 "Sales Credit Memo BA"
{
    // version HEI.18

    // DITW110.00.11 AKH 02/11/2017 NRQ#43605 New Report
    // FCE01 Changed the Footer"Reprinted"
    // 
    // HEI.04 Bugfixing IBM NASTAA02 23.02.2018 # Local Algeria
    //   # Used "Tax Registration" instead of "N.I.S." for Customer NIS
    //   # Added Company NIS: "Tax Registration" and Company NRC: "Industrtial Classification"
    // 
    // HEI.05 Defect #1447 IBM NASTAA02 27.02.2018 # Incomplete Sales Invoice Report
    //   # Added LCY Code to the Cap. Social
    //   # Amount in letters should be just in French
    // 
    // HEI.06 Bugfixing IBM NASTAA02 13.03.2018 # Bugfixing Algeria
    //   # Used "Home Page" from locations to fill in the Registre of Commerce in the Company info
    //   # Displayed "Item Charge" based on “Show item charge on invoice” field in Item charge table not from Sales Invoice Line
    // 
    // HEI.07 Bugfixing IBM NASTAA02 15.03.2018 # Bugfixing Algeria
    //   # Replaced sum amounts on the layout
    //   # Added Item Charge Value for 100% Discount Promotions
    //   # Added Phone No and Bank Information for Company
    //   # Moved Amount in Letter lower
    //   # Changed margins
    // 
    // HEI.08 Defect #1679 IBM NASTAA02 22.03.2018 # Sales invoice goods print
    //   # Removed Company Name 2 from Layout
    //   # Moved lower the Customer Information
    //   # Moved higher the Customer NIF, NIS, NART, NRC
    // 
    // HEI.09 Bugfixing IBM NASTAA02 29.03.2018 # Bugfixing Algeria
    //   # InvDisAmount should be deducted in the Total Amount Excl VAT and not from the Total Amount Incl VAT
    // 
    // HEI.10 Defect #1409 IBM NASTAA02 30.03.2018 # Free Beer Invoice Printout
    //   # Added Free Item Value for 100% Discounts
    // 
    // HEI.11 FDD-BA-LOGGAP03 IBM NASTAA02 20.08.2018 # Sales Invoice and Sales Credit Memo Layout
    //   # Copied Report 50169 - Sales Invoice BA and created dataset and layout according to Bahamas requirements
    // HEI.12 FDD-BA-LOGGAP03 IBM NASTAA02 04.10.2018 # Sales Invoice and Sales Credit Memo Layout
    //   # Formated Amount columns to be Number with 2 decimals
    // HEI.13 FDD-BA-LOGGAP03 IBM NASTAA02 23.10.2018 # Sales Invoice and Sales Credit Memo Layout
    //   # Added Reprinted to the layout when the Report is printed to the printer
    // HEI.14 Defect #3416 IBM NASTAA02 02.11.2018 # Sales Inoice Layout - Cosmetic adjjustments
    //   # Increased size of font
    //   # Increased size of 'Reprinted'
    //   # Replaced ',' with '.' for decimals
    //   # Increased the header
    //   # For Packing Information will be used Item Attributes
    //   # New sum added per "Shortcut Unit of Measure4"
    //   # Total Section added to rectangle with 'Keep Together' property
    //   # Moved header information to body, to be printed just on the first page
    // HEI.15 Defect #3642 IBM NASTAA02 20.12.2018 # Sales Invoice - Deposits
    //   # When Show Item Charge on Invoivce = "Include in Item Price" then the Discounts need to be deducted from the Item line (Unit Price and Amount)
    //     and not printed separately
    //   # When Show Item Charge on Invoivce = " " or "Order Total" the Discounts line should not be printed, but a subtotal with total Discount Amount
    //     needs to be displayed
    //   # "Show Item Charge on Invoice" from Sales Invoice Lines should be used
    // HEI.16 Bugfixing Bahamas IBM NASTAA02 21.01.2019 # Sales Cr Memo - Discounts
    //   # Discounts should not be always deducted. Removed 'ABS' from formula
    // HEI.17 Bugfixing Bahamas IBM NASTAA02 31.01.2019 # Sales Cr Memo - Discounts
    //   # Discounts should not be always deducted from Unit Price and Line Amoun
    // HEI.18 Bugfixing Bahamas IBM NASTAA02 01.04.2019 # Sales Invoice - Layout
    //   # Increased font
    // HEI.19 RFC-CHG2042986 IBM.AB 23.12.2019
    //   # Layout Change for 2nd Page onwards
    // HEI.20 RFC-CHG2051637 IBM.SAMANR01 12.03.2020
    //   # VAT base calculaculation include if Item Charge Type = BLANK
    //*****************************************************//
    //BC UPGRADE ATHUKS01//
    //1.HEI.04 No changes.
    //1.HEI.06,HEI.07 Commneted Drink IT code realted field Item Charge Type & condtions On Sales Credit Memo Line dataitem.  
    //2.HEI.08 Layout side no changes and convert from NAV to BC.
    //3.HEI.09 No found.
    //4.HEI.10 Drink IT field is Free Item & dependency filter is commented. 
    //5.HEI.12 Commented WarehouseSetup."Shortcut Unit of Measure3 Code" filter dependecies drink IT field.
    //6.HEI.14 Commented filter dependecy on Drink IT field 
    //7.HEI.15 Commented Drink IT Code dependecies on field Item Charge Type
    //8.HEI.16 Commented Drink IT Code dependencies on field Item Charge Type
    //9.HEI.17 Commented Drink IT code dependencies on field Show Item charge on Invoice 
    //10.HEI.18 Commented Code related to  Tax Warehouse Reference & Tax Registration No..
    //11.HEI.19 Layour side no changes 
    //12.HEI.20 Commneted drink code dependencies on field Item Charge Type
    //13..Change Language To LanguageMgt and Record to codeunit and use function GetLanguageID.
    //14.Old Report ID - 50170.
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Sales Credit Memo BA.rdl';

    Caption = 'Sales Credit Memo BA';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Cr.Memo Header';
            column(SalesCrMemoHeader_No; "No.")
            {
            }
            column(GLSetup_LCYCode; GLSetup."LCY Code")
            {
            }
            column(Reprinted; Reprinted)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(OrderConfirmCopyCaption; DocumentTitleTextLbl)
                    {
                    }
                    column(ShipToCustomerAddress_1; ShipToCustomerAddress[1])
                    {
                    }
                    column(ShipToCustomerAddress_2; ShipToCustomerAddress[2])
                    {
                    }
                    column(ShipToCustomerAddress_3; ShipToCustomerAddress[3])
                    {
                    }
                    column(ShipToCustomerAddress_4; ShipToCustomerAddress[4])
                    {
                    }
                    column(ShipToCustomerAddress_5; ShipToCustomerAddress[5])
                    {
                    }
                    column(ShipToCustomerAddress_6; ShipToCustomerAddress[6])
                    {
                    }
                    column(BillToCustomerAddress_1; BillToCustomerAddress[1])
                    {
                    }
                    column(BillToCustomerAddress_2; BillToCustomerAddress[2])
                    {
                    }
                    column(BillToCustomerAddress_3; BillToCustomerAddress[3])
                    {
                    }
                    column(BillToCustomerAddress_4; BillToCustomerAddress[4])
                    {
                    }
                    column(BillToCustomerAddress_5; BillToCustomerAddress[5])
                    {
                    }
                    column(BillToCustomerAddress_6; BillToCustomerAddress[6])
                    {
                    }
                    column(CompanyInfomation_TIN; OurTINNo)
                    {
                    }
                    column(SalesInvoiceHeader_PostingDate; FORMAT("Sales Cr.Memo Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesInvoiceHeader_OrderNo; "Sales Cr.Memo Header"."Return Order No.")
                    {
                    }
                    column(SalesInvoiceHeader_OrderDate; FORMAT("Sales Cr.Memo Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(SalesInvoiceHeader_SellToCustomerNo; "Sales Cr.Memo Header"."Sell-to Customer No.")
                    {
                    }
                    column(SalesInvoiceHeader_CustomerPO; "Sales Cr.Memo Header"."External Document No.")
                    {
                    }
                    column(PaymentTerms_Description; PaymentTerms.Description)
                    {
                    }
                    column(SalesInvoiceHeader_DueDate; FORMAT("Sales Cr.Memo Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(Customer_TIN; Customer."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo_Email; CompanyInfo."E-Mail")
                    {
                    }
                    column(ShipToCaption; ShipToLbl)
                    {
                    }
                    column(InvoiceToCaption; InvoiceToLbl)
                    {
                    }
                    column(OurTINNoCaption; OurTINNoLbl)
                    {
                    }
                    column(InvoiceDateCaption; InvoiceDateLbl)
                    {
                    }
                    column(SalesOrderCaption; SalesOrderLbl)
                    {
                    }
                    column(OrderDateCaption; OrderDateLbl)
                    {
                    }
                    column(CustomerCodeCaption; CustomerCodeLbl)
                    {
                    }
                    column(CustomerPOCaption; CustomerPOLbl)
                    {
                    }
                    column(PaymentTermCaption; PaymentTermLbl)
                    {
                    }
                    column(DueDateCaption; DueDateLbl)
                    {
                    }
                    column(CustomerTINCaption; CustomerTINLbl)
                    {
                    }
                    column(ItemCaption; ItemLbl)
                    {
                    }
                    column(DescriptionCaption; DescriptionLbl)
                    {
                    }
                    column(QtyCaption; QtyLbl)
                    {
                    }
                    column(UnitCaption; UnitLbl)
                    {
                    }
                    column(SubtotalPerUnitCaption; SubtotalPerUnitLbl)
                    {
                    }
                    column(SubtotalCaption; SubtotalLbl)
                    {
                    }
                    column(PackageSizeCaption; PackageSizeLbl)
                    {
                    }
                    column(PerUnitCaption; PerUnitLbl)
                    {
                    }
                    column(TotalIndvUnitsCaption; TotalIndvUnitsLbl)
                    {
                    }
                    column(TotalCasesCaption; TotalCasesLbl)
                    {
                    }
                    column(TotalPalletsCaption; TotalPalletsLbl)
                    {
                    }
                    column(TotalBarrelsCaption; TotalBarrelsLbl)
                    {
                    }
                    column(PalletsReturnedCaption; PalletsReturnedLbl)
                    {
                    }
                    column(SpecificationCaption; SpecificationLbl)
                    {
                    }
                    column(VATCaption; VATlbl)
                    {
                    }
                    column(BaseCaption; BaseLbl)
                    {
                    }
                    column(VATAmountCaption; VATAmountLbl)
                    {
                    }
                    column(TotalAmountCaption; TotalAmountLbl)
                    {
                    }
                    column(EmailCaption; EmailLbl)
                    {
                    }
                    column(Text015; Text015)
                    {
                    }
                    column(BaseAmount; ROUND(AmttoPaid, 0.01, '='))
                    {
                    }
                    column(TotalAmount; ROUND(InvTotalAmount, 0.01, '='))
                    {
                    }
                    column(VATAmount; ROUND(VATAmount, 0.01, '='))
                    {
                    }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Type_SalesLine; FORMAT(Type, 0, 2))
                        {
                        }
                        column(SalesInvoiceLine_Item; "No.")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesInvoiceLine_Description; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(SalesInvoiceLine_Quantity; Quantity)
                        {
                        }
                        column(SalesInvoiceLine_UnitOfMeasure; "Unit of Measure Code")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesInvoiceLine_UnitPrice; "Unit Price")
                        {
                        }
                        column(SalesInvoiceLine_LineAmount; "Line Amount")
                        {
                        }
                        column(SalesInvoiceLine_ItemPerUnit; "Qty. per Unit of Measure")
                        {
                        }
                        column(SalesInvoiceLine_ItemPackageSize; PackageSize)
                        {
                        }
                        //BC UPGRADE ATHUKS01>> Drink IT Field 
                        // column(TotalShortcutQtyUomValue1Caption; STRSUBSTNO(TotalUomLbl, WarehouseSetup."Shortcut Unit of Measure1 Code"))
                        // {
                        // }
                        //BC UPGRADE ATHUKS01<< Drink IT Field
                        column(TotalShortcutQtyUomValue1; TotalShortcutQtyUomValue[1])
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        //BC UPGRADE ATHUKS01>> Drink IT Field
                        // column(TotalShortcutQtyUomValue2Caption; STRSUBSTNO(TotalUomLbl, WarehouseSetup."Shortcut Unit of Measure2 Code"))
                        // {
                        // }
                        //BC UPGRADE ATHUKS01<< Drink IT Field

                        column(TotalShortcutQtyUomValue2; TotalShortcutQtyUomValue[2])
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        //BC UPGRADE ATHUKS01>> Drink IT Field
                        // column(TotalShortcutQtyUomValue3Caption; STRSUBSTNO(TotalUomLbl, WarehouseSetup."Shortcut Unit of Measure3 Code"))
                        // {
                        // }
                        //BC UPGRADE ATHUKS01 << Drink IT Field
                        column(TotalShortcutQtyUomValue3; TotalShortcutQtyUomValue[3])
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TotalShortcutQtyUomValue4Caption; STRSUBSTNO(TotalUomLbl, WarehouseSetup."Shortcut Unit of Meas4Code FND"))
                        {
                        }
                        column(TotalShortcutQtyUomValue4; TotalShortcutQtyUomValue[4])
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(SalesInvoiceLine_VATSpecification; "VAT %")
                        {
                        }
                        column(SalesInvoiceLine_VATBaseAmount; "VAT Base Amount")
                        {
                        }
                        column(Description2_SalesLine; "Description 2")
                        {
                            IncludeCaption = true;
                        }
                        column(LineNo_SalesLine; "Line No.")
                        {
                        }
                        column(LineAmount2; LineAmount2)
                        {
                        }
                        column(UnitPrice2; UnitPrice2)
                        {
                        }
                        column(PrintPrice; PrintPrice)
                        {
                        }
                        column(PrintUnderLineCharge; PrintUnderLineCharge)
                        {
                        }
                        column(TotalDiscounts; TotalDiscounts)
                        {
                        }
                        //BC UPGRADE ATHUKS01>> Drink IT    
                        // column(ShowItemCharge; "Show Item charge on Invoice")
                        // {
                        //RowVisible
                        //=IIF(((Fields!Type_SalesLine.Value = "2") OR 
                        // ((Fields!ShowItemCharge.Value = "Under item line") AND (Fields!ItemChargeType.Value = "Discount"))) OR (Fields!ItemChargeType.Value <> "Discount"),FALSE,TRUE)
                        // }
                        //RowVisible

                        // column(ItemChargeType; "Item Charge Type")
                        // {
                        // }
                        //BC UPGRADE ATHUKS01<< Drink IT

                        trigger OnAfterGetRecord();
                        var
                            ItemCrossReference: Record "Item Reference";
                            ReservEntry: Record "Reservation Entry";
                            ItemLedgEntry: Record "Item Ledger Entry";
                            OrderChargeLine: Record "Sales Cr.Memo Line";
                            SalesChargeLine: Record "Sales Cr.Memo Line";
                            Item2: Record Item;
                            SalesCrMemoLine2: Record "Sales Cr.Memo Line";
                            ShortcutQtyUomValue: array[4] of Decimal;
                            UnitOfMeasure: Record "Unit of Measure";
                            ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
                            ItemAttributeValue: Record "Item Attribute Value";
                            ItemCharge2: Record "Item Charge";
                            ItemCharge3: Record "Item Charge";
                            SalesCrMemoLine: Record "Sales Cr.Memo Line";
                        begin
                            //IF (Type = Type::"Charge (Item)") THEN
                            //CurrReport.SKIP;

                            //HEI.15>>
                            //Show Discount Item Charge
                            //BC UPGRADE ATHUKS01>> Drink IT Code
                            // if Type = Type::"Charge (Item)" then begin
                            //     if ("Item Charge Type" = "Item Charge Type"::Discount) and
                            //        (("Show Item charge on Invoice" = "Show Item charge on Invoice"::" ") or
                            //         ("Show Item charge on Invoice" = "Show Item charge on Invoice"::"Order total"))
                            //     then
                            //         ShowDiscount := true;
                            // end;
                            //BC UPGRADE ATHUKS01<< Drink IT Code
                            //Include in Item Price
                            UnitPrice2 := "Unit Price";
                            LineAmount2 := "Line Amount";

                            //BC UPGRADE ATHUKS01>> Drink IT code
                            // SalesCrMemoLine.RESET();
                            // SalesCrMemoLine.SETRANGE("Document No.", "Document No.");
                            // SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::"Charge (Item)");
                            // SalesCrMemoLine.SETRANGE("Attached to Line No.", "Line No.");
                            // SalesCrMemoLine.SETRANGE("Item Charge Type", SalesCrMemoLine."Item Charge Type"::Discount);
                            // if SalesCrMemoLine.FINDSET() then
                            //     repeat
                            //         if SalesCrMemoLine."Show Item charge on Invoice" = SalesCrMemoLine."Show Item charge on Invoice"::"Include in item price" then begin
                            //             //HEI.17>>
                            //             LineAmount2 += SalesCrMemoLine."Line Amount";
                            //             if SalesCrMemoLine.Quantity > 0 then
                            //                 UnitPrice2 += SalesCrMemoLine."Unit Price"
                            //             else
                            //                 UnitPrice2 -= SalesCrMemoLine."Unit Price";
                            //             //HEI.07<<
                            //         end;
                            //     until SalesCrMemoLine.NEXT() = 0;
                            //HEI.15<<
                            //BC UPGRADE ATHUKS01<< Drink IT code

                            //-----Subtotal
                            if
                            (
                             (Type = Type::Item) and not (IsEmptyGoodItem())
                             or (Type in [Type::Resource, Type::"Fixed Asset", Type::"G/L Account"])
                            ) then begin
                                SubTotal += "Line Amount";
                                TotalSubTotal += "Line Amount";
                            end;
                            //BC UPGRADE ATHUKS01>> Drink IT Code
                            // if ItemsInvoice then begin

                            // //Tax to Grand Total + Total + Line Amount
                            // SalesChargeLine.RESET();
                            // SalesChargeLine.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                            // SalesChargeLine.SETRANGE(Type, "Sales Cr.Memo Line".Type::"Charge (Item)");
                            // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Cr.Memo Line"."Item Charge Type"::Tax);
                            // //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Include in item price");syed
                            // SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Cr.Memo Line"."Line No.");
                            // if SalesChargeLine.FINDSET() then
                            //     repeat
                            //         //"Sales Invoice Line"."Line Amount" += SalesChargeLine."Line Amount";syed
                            //         //SubTotal += SalesChargeLine."Line Amount";syed
                            //         TotalSubTotal += SalesChargeLine."Line Amount";
                            //     until SalesChargeLine.NEXT() = 0;
                            // //Discounts to Grand Total + Total + Line Amount
                            // SalesChargeLine.RESET();
                            // SalesChargeLine.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                            // SalesChargeLine.SETRANGE(Type, "Sales Cr.Memo Line".Type::"Charge (Item)");
                            // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Cr.Memo Line"."Item Charge Type"::Discount);
                            // //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Include in item price"); //HEI.06
                            // SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Cr.Memo Line"."Line No.");
                            // if SalesChargeLine.FINDSET() then begin
                            //     //HEI.06>>
                            //     ItemCharge.GET(SalesChargeLine."No.");
                            //     if ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::"Include in item price" then
                            //         //HEI.06<<
                            //         repeat
                            //             "Sales Cr.Memo Line"."Line Amount" += SalesChargeLine."Line Amount";
                            //             SubTotal += SalesChargeLine."Line Amount";
                            //             TotalSubTotal += SalesChargeLine."Line Amount";
                            //         until SalesChargeLine.NEXT() = 0;
                            // end; //HEI.06
                            //      //Discounts under item line

                            // CLEAR(PrintUnderLineCharge);
                            // SalesChargeLine.RESET();
                            // SalesChargeLine.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                            // SalesChargeLine.SETRANGE(Type, "Sales Cr.Memo Line".Type::"Charge (Item)");
                            // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Cr.Memo Line"."Item Charge Type"::Discount);
                            // //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line"); HEI.06
                            // SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Cr.Memo Line"."Line No.");
                            // if SalesChargeLine.FINDSET() then begin
                            //     //HEI.06>>
                            //     ItemCharge.GET(SalesChargeLine."No.");
                            //     if ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::"Under item line" then
                            //         //HEI.06<<
                            //         if not PrintUnderLineCharge then
                            //             PrintUnderLineCharge := true;
                            //     repeat
                            //         TempUnderChargeLine.INIT();
                            //         TempUnderChargeLine := SalesChargeLine;
                            //         TempUnderChargeLine.INSERT();
                            //     until (SalesChargeLine.NEXT() = 0);
                            //     SalesChargeLine.CALCSUMS("Line Amount");
                            //     SubTotal += SalesChargeLine."Line Amount";
                            //     TotalSubTotal += SalesChargeLine."Line Amount";
                            // end;
                            //BC UPGRADE ATHUKS01<< Drink IT Code
                            //Tax under item line
                            // SalesChargeLine.RESET();
                            // SalesChargeLine.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                            // SalesChargeLine.SETRANGE(Type, "Sales Cr.Memo Line".Type::"Charge (Item)");
                            // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Cr.Memo Line"."Item Charge Type"::Tax);
                            // //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line"); HEI.06//BC UPGRADE ATHUKS01>>
                            // SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Cr.Memo Line"."Line No.");
                            // if SalesChargeLine.FINDSET() then begin
                            //     //HEI.06>>
                            //     ItemCharge.GET(SalesChargeLine."No.");
                            //     if ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::"Under item line" then
                            //         //HEI.06<<
                            //         repeat
                            //             if (SalesChargeLine."Line Amount" <> 0) then begin
                            //                 if not PrintUnderLineCharge then
                            //                     PrintUnderLineCharge := true;
                            //                 TempUnderChargeLine.INIT();
                            //                 TempUnderChargeLine := SalesChargeLine;
                            //                 TempUnderChargeLine.INSERT();
                            //             end;
                            //         until (SalesChargeLine.NEXT() = 0);
                            //     SalesChargeLine.CALCSUMS("Line Amount");
                            //     SubTotal += SalesChargeLine."Line Amount";
                            //     TotalSubTotal += SalesChargeLine."Line Amount";
                            // end; //HEI.06
                            //   if ("Sales Cr.Memo Line".Quantity <> 0) then
                            //     "Sales Cr.Memo Line"."Unit Price" := "Sales Cr.Memo Line"."Line Amount" / "Sales Cr.Memo Line".Quantity;
                            // end;
                            //BC UPGRADE ATHUKS01><<Drink IT Code  
                            if TempOrderDiscountCharge.FINDSET() then
                                repeat
                                    TempOrderLineAmt += TempOrderDiscountCharge."Line Amount";
                                until TempOrderDiscountCharge.NEXT() = 0;


                            TotalSubTotal += (TempOrderLineAmt);

                            //HEI.07>>
                            LineAmount := 0;
                            UnitPrice := 0;
                            PromotionItemChargeAmt := 0;
                            PromotionItemChargeValue := 0;
                            PromotionLine := false;

                            PromotionSalesInvoiceLine.RESET();
                            PromotionSalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                            PromotionSalesInvoiceLine.SETRANGE("Line No.", "Line No.");
                            //BC UPGRADE ATHUKS01>>
                            // PromotionSalesInvoiceLine.SETRANGE("Item Charge Type", PromotionSalesInvoiceLine."Item Charge Type"::Promotion);
                            // PromotionSalesInvoiceLine.SETRANGE("Item Charge Discount %", 100);
                            //BC UPGRADE ATHUKS01<<
                            if PromotionSalesInvoiceLine.FINDFIRST() then begin
                                PromotionItemChargeAmt := PromotionSalesInvoiceLine."Line Discount Amount";
                                //PromotionItemChargeValue := PromotionSalesInvoiceLine."Item Charge Value";BC UPGRADE ATHUKS01
                                PromotionLine := true;
                            end;
                            //HEI.07<<

                            //HEI.10>>
                            DiscountItemChargeAmt := 0;
                            DiscountItemChargeValue := 0;
                            DiscountLine := false;

                            DiscountSalesInvoiceLine.RESET();
                            DiscountSalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                            DiscountSalesInvoiceLine.SETRANGE("Line No.", "Line No.");
                            // DiscountSalesInvoiceLine.SETRANGE("Free Item", true);BC UPGRADE ATHUKS01
                            DiscountSalesInvoiceLine.SETRANGE("Line Discount %", 100);
                            if DiscountSalesInvoiceLine.FINDFIRST() then begin
                                DiscountItemChargeAmt := DiscountSalesInvoiceLine."Line Discount Amount";
                                // DiscountItemChargeValue := DiscountSalesInvoiceLine."Item Charge Value";BC UPGRADE ATHUKS01
                                DiscountLine := true;
                            end;

                            if PromotionLine then begin
                                LineAmount := PromotionItemChargeAmt;
                                UnitPrice := PromotionItemChargeValue;
                            end else if DiscountLine then begin
                                LineAmount := DiscountItemChargeAmt;
                                UnitPrice := DiscountItemChargeValue;
                            end else begin
                                LineAmount := "Line Amount";
                                UnitPrice := "Unit Price";
                            end;
                            //HEI.10<<

                            //HEI.11>>
                            if Type = Type::Item then begin
                                PackageSize := '';
                                Item2.GET("No.");
                                //HEI.14>>
                                ItemAttributeValueMapping.SETRANGE("Table ID", DATABASE::Item);
                                ItemAttributeValueMapping.SETRANGE("No.", Item2."No.");
                                ItemAttributeValueMapping.SETRANGE("Item Attribute ID", 9);
                                if ItemAttributeValueMapping.FINDFIRST() then
                                    if ItemAttributeValue.GET(9, ItemAttributeValueMapping."Item Attribute Value ID") then
                                        PackageSize := ItemAttributeValue."Description FND";
                                //HEI.14<<
                            end;

                            SalesCrMemoLine2.SETRANGE("Document No.", "Document No.");
                            SalesCrMemoLine2.SETRANGE("Line No.", "Line No.");
                            SalesCrMemoLine2.SETRANGE(Type, SalesCrMemoLine2.Type::Item);
                            SalesCrMemoLine2.SETFILTER(Quantity, '>%1', 0);
                            if SalesCrMemoLine2.FINDSET() then
                                repeat
                                    ShowShortcutUomValue(ShortcutQtyUomValue, SalesCrMemoLine2);
                                    TotalShortcutQtyUomValue[1] += ShortcutQtyUomValue[1];
                                    TotalShortcutQtyUomValue[2] += ShortcutQtyUomValue[2];
                                    TotalShortcutQtyUomValue[3] += ShortcutQtyUomValue[3];
                                    TotalShortcutQtyUomValue[4] += ShortcutQtyUomValue[4]; //HEI.14
                                until SalesCrMemoLine2.NEXT() = 0;
                            //HEI.11<<
                        end;

                        trigger OnPreDataItem();
                        begin
                            CLEAR(TotalShortcutQtyUomValue); //HEI.14

                            MoreLines := FINDLAST();

                            while MoreLines and (Description = '') and ("Description 2" = '') and
                                  ("No." = '') and (Quantity = 0) and
                                  (Amount = 0)
                            do
                                MoreLines := NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");

                            TempEmptyGoodItemLine.RESET();
                            if TempEmptyGoodItemLine.FINDLAST() then
                                LineNo := TempEmptyGoodItemLine."Line No.";
                        end;
                    }
                    dataitem(UnderLineCharges; "Integer")
                    {
                        column(UnderChargeLine_No; TempUnderChargeLine."No.")
                        {
                            IncludeCaption = true;
                        }
                        column(UnderChargeLine_Description; TempUnderChargeLine.Description)
                        {
                            IncludeCaption = true;
                        }
                        column(UnderChargeLine_Qty; TempUnderChargeLine.Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(UnderChargeLine_UoM; TempUnderChargeLine."Unit of Measure")
                        {
                        }
                        column(UnderChargeLine_UnitPrice; TempUnderChargeLine."Unit Price")
                        {
                        }
                        column(UnderChargeLine_LineAmount; TempUnderChargeLine."Line Amount")
                        {
                        }

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
                            TempUnderChargeLine.SETRANGE("Attached to Line No.", "Sales Cr.Memo Line"."Line No.");
                            SETRANGE(Number, 1, TempUnderChargeLine.COUNT);
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine_VATPerc; VATAmountLine."VAT %")
                        {
                        }
                        column(VATAmountLine_VATAmount; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATBase; VATAmountLine."VAT Base")
                        {
                        }
                        column(ShowDiscount; ShowDiscount)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);

                            if VATAmountLine."VAT %" = 0 then
                                CurrReport.SKIP();
                        end;

                        trigger OnPreDataItem();
                        begin
                            VATAmountLine.RESET();
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        CLEAR(TotalFooterAmount);
                        CLEAR(TotalFooterAmountText);
                        CLEAR(InvTotalAmount);
                        CLEAR(AmttoPaid);
                        CLEAR(ShipAmount);
                        CLEAR(DepAmountP);
                        CLEAR(DepAmountN);
                        CLEAR(ShipAmount);
                        CLEAR(InvDisAmount);
                        CLEAR(LineDisAmount);
                        CLEAR(InvLineTotal);

                        SalesCrMemoLineAmt.RESET();
                        SalesCrMemoLineAmt.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        //>>HEI:CHG0153013:1:1 14/12/16 IBM.AV
                        //SalesInvLineAmt.SETRANGE(Type,SalesInvLineAmt.Type::Item); //commented
                        SalesCrMemoLineAmt.SETRANGE(Type, SalesCrMemoLineAmt.Type::Item, SalesCrMemoLineAmt.Type::"Fixed Asset");   //added
                        //<<HEI:CHG0153013:1:1 14/12/16 IBM.AV
                        if SalesCrMemoLineAmt.FINDSET() then
                            repeat
                                //InvLineTotal += SalesCrMemoLineAmt."Line Amount" + SalesCrMemoLineAmt."Line Discount Amount";
                                InvLineTotal += SalesCrMemoLineAmt."Line Amount";
                            until SalesCrMemoLineAmt.NEXT() = 0;

                        //<<HEI:CHG0187935:1:1 24/08/17 IBM.SP
                        SalesCrMemoLineAmt.RESET();
                        SalesCrMemoLineAmt.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        SalesCrMemoLineAmt.SETRANGE(Type, SalesCrMemoLineAmt.Type::"G/L Account");   //sP
                        if SalesCrMemoLineAmt.FINDSET() then
                            repeat
                                //InvLineTotal += SalesCrMemoLineAmt."Line Amount" + SalesCrMemoLineAmt."Line Discount Amount";
                                InvLineTotal += SalesCrMemoLineAmt."Line Amount";
                            until SalesCrMemoLineAmt.NEXT() = 0;
                        //BC UPGRADE ATHUKS01<< Drink IT code
                        //<<HEI:CHG0187935:1:1 24/08/17 IBM.SP
                        // SalesCrMemoLine.RESET();
                        // SalesCrMemoLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        // SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::"Charge (Item)");

                        // TaxAmout := 0; //HEI.03
                        // if SalesCrMemoLine.FINDSET() then
                        //     repeat
                        //         case SalesCrMemoLine."Item Charge Type" of
                        //             SalesCrMemoLine."Item Charge Type"::Tax:
                        //                 begin
                        //                     TotalFooterAmount[1] += SalesCrMemoLine."Line Amount";
                        //                 end;
                        //             SalesCrMemoLine."Item Charge Type"::Deposit:
                        //                 begin
                        //                     if SalesCrMemoLine."Line Amount" > 0 then begin
                        //                         TotalFooterAmount[2] += SalesCrMemoLine."Line Amount";
                        //                     end else if SalesCrMemoLine."Line Amount" < 0 then begin
                        //                         TotalFooterAmount[3] += SalesCrMemoLine."Line Amount";
                        //                     end;
                        //                 end;
                        //             SalesCrMemoLine."Item Charge Type"::"Shipping Cost":
                        //                 begin
                        //                     TotalFooterAmount[4] += SalesCrMemoLine."Line Amount";
                        //                 end;
                        //             SalesCrMemoLine."Item Charge Type"::Discount:
                        //                 begin
                        //                     //HEI.16>>
                        //                     //TotalFooterAmount[5] += ABS(SalesCrMemoLine."Line Amount");        // Added
                        //                     TotalFooterAmount[5] += SalesCrMemoLine."Line Amount";
                        //                     //HEI.16<<
                        //                     TotalFooterAmountText[5] := 'Invoice Discounts';
                        //                 end;
                        //             //HEI.20>>
                        //             SalesCrMemoLine."Item Charge Type"::" ":
                        //                 begin
                        //                     TotalFooterAmount[7] += SalesCrMemoLine."Line Amount";
                        //                 end;
                        //         //HEI.20<<
                        //         end;
                        //     until SalesCrMemoLine.NEXT() = 0;
                        //BC UPGRADE ATHUKS01>> Drink IT code
                        TaxAmout := TotalFooterAmount[1];
                        DepAmountP := TotalFooterAmount[2];
                        DepAmountN := TotalFooterAmount[3];
                        ShipAmount := TotalFooterAmount[4];
                        BlankItemChargeAmt := TotalFooterAmount[7]; //HEI.20>>
                        SalesCrMemoLine.RESET();
                        SalesCrMemoLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");

                        if SalesCrMemoLine.FINDSET() then
                            repeat
                                TotalFooterAmount[5] += SalesCrMemoLine."Inv. Discount Amount";
                                TotalFooterAmountText[5] := SalesCrMemoLine.FIELDCAPTION("Inv. Discount Amount");
                                TotalFooterAmount[6] += SalesCrMemoLine."Line Discount Amount";
                                TotalFooterAmountText[6] := SalesCrMemoLine.FIELDCAPTION("Line Discount Amount");
                            until SalesCrMemoLine.NEXT() = 0;

                        InvDisAmount := TotalFooterAmount[5];
                        LineDisAmount := TotalFooterAmount[6];

                        //HEI.16>>
                        //AmttoPaid := InvLineTotal + TaxAmout + DepAmountP + ShipAmount - DepAmountN -ABS(LineDisAmount) - ABS(InvDisAmount);
                        //HEI.20>>
                        //AmttoPaid := InvLineTotal + TaxAmout + DepAmountP + ShipAmount - DepAmountN + InvDisAmount;
                        AmttoPaid := InvLineTotal + TaxAmout + DepAmountP + ShipAmount - DepAmountN + InvDisAmount + BlankItemChargeAmt;
                        //HEI.20<<
                        //HEI.16<<
                        InvTotalAmount := AmttoPaid + VATAmount;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        OutputNo += 1;
                    end else
                        CopyText := '';
                    CLEAR(SubTotal);
                    CLEAR(TotalSubTotal);
                    //HEI.01>>
                    // FCE01-+Footertext := 'REPRINTED'
                    Footertext := '';
                    //HEI.01<<
                end;

                trigger OnPostDataItem();
                var
                    SalesCrMemoCountPrinted: Codeunit "Sales Cr. Memo-Printed";
                begin

                    if Print then
                        SalesCrMemoCountPrinted.RUN("Sales Cr.Memo Header");
                end;

                trigger OnPreDataItem();
                begin

                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord();
            var
                SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                ShipmentMethod: Record "Shipment Method";
                DeliveryTime1: Text;
                DeliveryTime2: Text;
                //StandardTextReport: Record "Standard Text Report"; BC UPGRADE ATHUKS01 Drink IT
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
                CurrReportID: Integer;
                i: Integer;
                IsTextToInclude: Boolean;
                ItemLedgerEntry: Record "Item Ledger Entry";
                NoSeriesMgt: Codeunit "No. Series";
                ModifyHeader: Boolean;
                SalesDepositLines: Record "Sales Cr.Memo Line";
                DepositGroupCode: Code[10];
                //DrinkDepositGroup: Record "Drink Deposit Group"; BC UPGRADE ATHUKS01 Drink IT
                OrderChargeLine: Record "Sales Cr.Memo Line";
                EmtpyGoodValueEntryNo: Integer;
                ValueEntry: Record "Value Entry";
                SalesCrMemoLine2: Record "Sales Cr.Memo Line";
                SalesCrMemoLine3: Record "Sales Cr.Memo Line";
                StartingShipmentdate: Date;
                //  LoyaltyBalanceBuffer: Record "Loyalty Balance Buffer" temporary;BC UPGRADE ATHUKS01 Drink IT
                BeginBalDate: Date;
                EndBalDate: Date;
                BeginningMonth: Date;
            //LoyaltyLedgerEntry: Record "Loyalty Ledger Entry"; BC UPGRADE ATHUKS01 Drink IT 
            begin
                Reprinted := "No. Printed" > 0; //HEI.13
                CLEAR(ShowDiscount); //HEI.15

                if PaymentMethod.GET("Payment Method Code") then;
                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                Customer.GET("Sell-to Customer No.");
                if "Bill-to Customer No." <> '' then
                    Customer.GET("Bill-to Customer No.");

                //-----Company Info
                CompanyInfo.GET();
                //BC UPGRADE ATHUKS01>> Drink IT code
                //HEI.18>>
                // if "Location Code" = 'BS05' then
                //     OurTINNo := CompanyInfo."Tax Warehouse Reference"
                // else
                //     OurTINNo := CompanyInfo."Tax Registration No.";
                //HEI.18<<
                //BC UPGRADE ATHUKS01<< Drink IT code

                //-----Item Invoice
                SalesCrMemoLine2.RESET();
                SalesCrMemoLine2.SETRANGE("Document No.", "No.");
                SalesCrMemoLine2.SETRANGE(Type, SalesCrMemoLine2.Type::Item);
                if not SalesCrMemoLine2.ISEMPTY then
                    ItemsInvoice := true;

                //HEI.11>>
                FormatAddr.SalesCrMemoBillTo(BillToCustomerAddress, "Sales Cr.Memo Header");
                FormatAddr.SalesCrMemoShipTo(ShipToCustomerAddress, BillToCustomerAddress, "Sales Cr.Memo Header");
                //HEI.11

                //-----Currency Code
                if ("Currency Code" <> '') then
                    CurrCode := "Currency Code"
                else begin
                    GLSetup.GET;
                    CurrCode := GLSetup."LCY Code";
                end;

                //-------VAT
                CLEAR(SumTotalVatAmt);
                VATAmountLine.DELETEALL();
                SalesCrMemoLine.CalcVATAmountLines("Sales Cr.Memo Header", VATAmountLine);
                SumTotalVatAmt += VATAmountLine."VAT Amount";

                CLEAR(TotalDeposits);
                CLEAR(TotalDiscounts);
                CLEAR(TotalTaxes);

                //BC UPGRADE ATHUKS01>> Drink IT code 
                //-----Order total /blank Discount Charges     
                //OrderChargeLine.RESET();
                // OrderChargeLine.SETRANGE("Document No.", "No.");
                //OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                // OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Discount);
                //OrderChargeLine.SETFILTER("Show Item charge on Invoice",'%1|%2',OrderChargeLine."Show Item charge on Invoice"::"Order total",OrderChargeLine."Show Item charge on Invoice"::" "); HEI.06
                // if OrderChargeLine.FINDSET() then begin
                //HEI.06>>
                // ItemCharge.GET(OrderChargeLine."No.");
                // if (ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::"Order total")
                //     or (ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::" ")
                // then begin
                //     //HEI.06<<
                //     PrintOrderDiscounts := true;
                //     repeat
                //         TempOrderDiscountCharge.INIT();
                //         TempOrderDiscountCharge := OrderChargeLine;
                //         TempOrderDiscountCharge.INSERT();
                //     until (OrderChargeLine.NEXT() = 0);
                //     OrderChargeLine.CALCSUMS("Line Amount");
                //     TotalDiscounts += OrderChargeLine."Line Amount";
                // end; //HEI.06
                //end;


                // //-----Order total /blank Deposit Charges
                // OrderChargeLine.RESET();
                // OrderChargeLine.SETRANGE("Document No.", "No.");
                // OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                // OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Deposit);
                // //OrderChargeLine.SETFILTER("Show Item charge on Invoice",'%1|%2',OrderChargeLine."Show Item charge on Invoice"::"Order total",OrderChargeLine."Show Item charge on Invoice"::" "); HEI.06
                // if OrderChargeLine.FINDSET() then begin
                //     //HEI.06>>
                //     ItemCharge.GET(OrderChargeLine."No.");
                //     if (ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::"Order total")
                //         or (ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::" ")
                //     then begin
                //         //HEI.06<<
                //         PrintOrderDeposits := true;
                //         repeat
                //             TempOrderDepositCharge.INIT();
                //             TempOrderDepositCharge := OrderChargeLine;
                //             TempOrderDepositCharge.INSERT();
                //         until (OrderChargeLine.NEXT() = 0);
                //         OrderChargeLine.CALCSUMS("Line Amount");
                //         TotalDeposits += OrderChargeLine."Line Amount";
                //     end; //HEI.06
                // end;

                // //-----Order total /blank Tax Charges
                // OrderChargeLine.RESET();
                // OrderChargeLine.SETRANGE("Document No.", "No.");
                // OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                // OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Tax);
                // //OrderChargeLine.SETFILTER("Show Item charge on Invoice",'%1|%2',OrderChargeLine."Show Item charge on Invoice"::"Order total",OrderChargeLine."Show Item charge on Invoice"::" "); //HEI.06
                // if OrderChargeLine.FINDSET() then begin
                //     //HEI.06>>
                //     ItemCharge.GET(OrderChargeLine."No.");
                //     if (ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::"Order total")
                //         or (ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::" ")
                //     then begin
                //         //HEI.06<<
                //         repeat
                //             if (OrderChargeLine."Line Amount" <> 0) then begin
                //                 PrintOrderTaxes := true;
                //                 TempOrderTaxCharge.INIT();
                //                 TempOrderTaxCharge := OrderChargeLine;
                //                 TempOrderTaxCharge.INSERT();
                //             end;
                //         until (OrderChargeLine.NEXT() = 0);
                //         OrderChargeLine.CALCSUMS("Line Amount");
                //         TotalTaxes += OrderChargeLine."Line Amount";
                //     end; //HEI.06
                // end;
                //BC UPGRADE ATHUKS01>> Drink IT code

                VatAmt := 0; //HEI.03
                VATEntry.RESET();
                VATEntry.SETRANGE(Type, VATEntry.Type::Sale);
                VATEntry.SETRANGE("Document Type", VATEntry."Document Type"::"Credit Memo");
                VATEntry.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                if VATEntry.FINDSET() then
                    repeat
                        VatAmt += VATEntry.Amount;
                    until VATEntry.NEXT() = 0;
                VATAmount := VatAmt;
            end;

            trigger OnPostDataItem();
            begin
                NUMLines := 20;
                LinesPrinted := 0;
            end;

            trigger OnPreDataItem();
            begin
                Print := Print or not CurrReport.PREVIEW;
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
                        ApplicationArea = all;
                        ToolTip = 'No. of Copies';
                        Caption = 'No. of Copies';
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
        label(lblPageNo; ENU = 'Page:',
                        FRA = 'Page')
        label(lblInvoiceNo; ENU = 'Invoice No.',
                           FRA = 'N° de facture')
        ReprintedLbl = 'Reprinted'; DiscountLbl = 'Discount Amount';
    }

    trigger OnInitReport();
    begin
        WarehouseSetup.GET(); //HEI.11
        GLSetup.GET();
    end;

    trigger OnPreReport();
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture); //HEI.04 //FCE-
        // CurrReport.LANGUAGE := LanguageR.GetLanguageID(CompanyInfo."Language Code");//BC UPGRADE ATHUKS01
        CurrReport.Language := LanguageMgt.GetLanguageId(CompanyInfo."Language Code FND");//BC UPGRADE ATHUKS01
        // FCE+
    end;

    var
        CommentLine: Record "Comment Line";
        TempCommentLine: Record "Comment Line" temporary;
        CompanyInfo: Record "Company Information";
        PrintEmptyGoodsStatement: Boolean;
        TempCustomer: Record Customer temporary;
        //TempLoyaltyBuffer: Record "Loyalty Balance Buffer";BC UPGRADE ATHUKS01 Drink IT
        Cust: Record Customer;
        Customer: Record Customer;
        TempMarketingText: Record "Extended Text Line" temporary;
        // FreeReasonCode: Record "Free Reason Code"; BC UPGRADE ATHUKS01 Drink IT
        GLSetup: Record "General Ledger Setup";
        Item: Record Item;
        DiscountItemCharge: Record "Item Charge";
        ItemCharge: Record "Item Charge";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        LanguageR: Record Language;
        LanguageMgt: Codeunit Language;
        Location: Record Location;
        LocationAddr: Record Location;
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        SalesCommentLine: Record "Sales Comment Line";
        SalesCrMemoHeader2: Record "Sales Cr.Memo Header";
        DiscountSalesInvoiceLine: Record "Sales Cr.Memo Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesCrMemoLineAmt: Record "Sales Cr.Memo Line";
        TempEmptyGoodItemLine: Record "Sales Cr.Memo Line" temporary;
        TempOrderDepositCharge: Record "Sales Cr.Memo Line" temporary;
        TempOrderDiscountCharge: Record "Sales Cr.Memo Line" temporary;
        TempOrderTaxCharge: Record "Sales Cr.Memo Line" temporary;
        TempUnderChargeLine: Record "Sales Cr.Memo Line" temporary;
        //SalesDepositItemCharge: Record "Sales Deposit Item Charge";//BC UPGRADE ATHUKS01 Drink IT 
        PromotionSalesInvoiceLine: Record "Sales Invoice Line";
        SalesPerson: Record "Salesperson/Purchaser";
        VATAmountLine: Record "VAT Amount Line" temporary;
        VATEntry: Record "VAT Entry";
        WarehouseSetup: Record "Warehouse Setup";
        //Driver: Record "Whse. Shipping Driver";//BC UPGRADE ATHUKS01 Drink IT 
        TextFooter: array[3] of Text;
        HeaderAddr: array[8] of Text[50];
        FormatAddr: Codeunit "Format Address";
        HeinekenGlobal: Codeunit "Heineken Global";
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        DiscountLine: Boolean;
        DisplayMarketingBlock: Boolean;

        ItemsInvoice: Boolean;
        MoreLines: Boolean;
        Print: Boolean;
        PrintLoyaltyStatement: Boolean;
        PrintOrderDeposits: Boolean;
        PrintOrderDiscounts: Boolean;
        PrintOrderTaxes: Boolean;
        PrintPrice: Boolean;
        PrintShipmentText: Boolean;
        PrintUnderLineCharge: Boolean;
        PromotionLine: Boolean;
        Reprinted: Boolean;
        ShowDiscount: Boolean;
        CurrCode: Code[10];
        WhseSetupShortcutUomCode: array[3] of Code[10];
        CompanyPhoneNo: Code[20];
        OurTINNo: Code[20];
        ExpirationDate: Date;
        AmttoPaid: Decimal;
        BeginningBalance: Decimal;
        BlankItemChargeAmt: Decimal;
        DepAmountN: Decimal;
        DepAmountP: Decimal;
        DiscountItemChargeAmt: Decimal;
        DiscountItemChargeValue: Decimal;
        EndBalance: Decimal;
        Gains: Decimal;
        InvDisAmount: Decimal;
        InvLineTotal: Decimal;
        InvTotalAmount: Decimal;
        LineAmount: Decimal;
        LineAmount2: Decimal;
        LineDisAmount: Decimal;
        PromotionItemChargeAmt: Decimal;
        PromotionItemChargeValue: Decimal;
        QtyHL: Decimal;
        Sales: Decimal;
        ShipAmount: Decimal;
        SubTotal: Decimal;
        SumTotalVatAmt: Decimal;
        TaxAmout: Decimal;
        TempOrderLineAmt: Decimal;
        TotalDeposits: Decimal;
        PriceUOM: Code[10];
        InventorySetup: Record "Inventory Setup";
        TotalDiscounts: Decimal;
        TotalFooterAmount: array[8] of Decimal;
        TotalOrderDiscCharges: Decimal;
        TotalShortcutQtyUomValue: array[4] of Decimal;
        TotalSubTotal: Decimal;
        TotalTaxes: Decimal;
        UnitPrice: Decimal;
        UnitPrice2: Decimal;
        VATAmount: Decimal;
        VatAmt: Decimal;
        CommentLineNo: Integer;
        LineNo: Integer;
        LinesPrinted: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        NUMLines: Integer;
        CompanyText: Text;
        OutputNo: Integer;
        BaseLbl: Label 'Base';
        CustomerCodeLbl: Label 'Customer Code';
        CustomerPOLbl: Label 'Customer PO';
        CustomerTINLbl: Label 'Customer TIN';
        DescriptionLbl: Label 'Description';
        DocumentTitleTextLbl: Label 'VAT Credit Note';
        DueDateLbl: Label 'Due Date';
        EmailLbl: Label '"Email: "';
        InvoiceDateLbl: Label 'Invoice Date';
        InvoiceToLbl: Label 'Invoice to:';
        ItemLbl: Label 'Item';
        OrderDateLbl: Label 'Order Date';
        OurTINNoLbl: Label 'Our TIN Number';
        PackageSizeLbl: Label 'Package Size:';
        PalletsReturnedLbl: Label 'Pallets Returned';
        PaymentTermLbl: Label 'Payment Term';
        PerUnitLbl: Label 'Per Unit:';
        QtyLbl: Label 'Qty';
        SalesOrderLbl: Label 'Sales Order';
        ShipToLbl: Label 'Ship to:';
        SpecificationLbl: Label 'Specification';
        SubtotalLbl: Label 'Subtotal';
        SubtotalPerUnitLbl: Label 'Subtotal per Unit';
        Text015: Label 'Invoice No.';
        TotalAmountLbl: Label 'Total Amount';
        TotalBarrelsLbl: Label 'Total Barrels:';
        TotalCasesLbl: Label 'Total Cases:';
        TotalIndvUnitsLbl: Label 'Total Indv. Units:';
        TotalPalletsLbl: Label 'Total Pallets';
        UnitLbl: Label 'Unit';
        VATAmountLbl: Label 'VAT Amount';
        VATlbl: Label 'VAT';
        CompanyAddress: Text;
        CompanyAddress2: Text;
        CompanyCity: Text;
        CompanyEmail: Text;
        CompanyNRC: Text;
        CrossRefText: Text;
        CustAddr: array[4] of Text;
        Footertext: Text;
        FreeReasonText: Text;
        NoString: Text;
        ReportTitle: Text;
        VATPerText: Text;
        CopyText: Text[30];
        DocumentTitleText: Text[30];
        TotalFooterAmountText: array[6] of Text[50];
        BillToCustomerAddress: array[8] of Text[60];
        ShipToCustomerAddress: array[8] of Text[60];
        PackageSize: Text[250];
        BankInformationLbl: TextConst ENU = 'Bank Information', FRA = 'Réferences Bancaires';
        PhoneNoLbl: TextConst ENU = 'Phone No.', FRA = 'N° Téléphone';
        TotalUomLbl: TextConst ENU = 'Total %1', FRA = 'Total %1';

    local procedure IsEmptyGoodItem(): Boolean;
    begin
        if ("Sales Cr.Memo Line".Type <> "Sales Cr.Memo Line".Type::Item) or
           (("Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::Item) and
           ("Sales Cr.Memo Line"."No." = ''))
        then
            exit;
        //BC UPGRADE ATHUKS01>> 
        // Item.GET("Sales Cr.Memo Line"."No.");
        // Item.CALCFIELDS("Empty Good");
        // exit(Item."Empty Good");
        //BC UPGRADE ATHUKS01<<
    end;

    local procedure ShowShortcutUomValue(var ShortcutQtyUomValue: array[4] of Decimal; SalesCrMemoLine2: Record "Sales Cr.Memo Line");
    var
        SalesCrMemoLine_UoM1: Record "Sales Cr.Memo Line";
        SalesCrMemoLine_UoM2: Record "Sales Cr.Memo Line";
        SalesCrMemoLine_UoM3: Record "Sales Cr.Memo Line";
        SalesCrMemoLine_UoM4: Record "Sales Cr.Memo Line";
    begin
        //HEI.11>>
        CLEAR(ShortcutQtyUomValue);
        WarehouseSetup.GET();

        //HEI.12>>
        SalesCrMemoLine_UoM1.SETRANGE("Document No.", SalesCrMemoLine2."Document No.");
        SalesCrMemoLine_UoM1.SETRANGE("Line No.", SalesCrMemoLine2."Line No.");
        //  SalesCrMemoLine_UoM1.SETRANGE("Unit of Measure Code", WarehouseSetup."Shortcut Unit of Measure1 Code");//BC UPGRADE ATHUKS01 Drink IT Field
        if SalesCrMemoLine_UoM1.FINDFIRST() then
            ShortcutQtyUomValue[1] := SalesCrMemoLine_UoM1.Quantity;

        SalesCrMemoLine_UoM2.SETRANGE("Document No.", SalesCrMemoLine2."Document No.");
        SalesCrMemoLine_UoM2.SETRANGE("Line No.", SalesCrMemoLine2."Line No.");
        SalesCrMemoLine_UoM2.SETFILTER("Unit of Measure Code", WarehouseSetup."Short Unit of Meas2 Filt FND");
        if SalesCrMemoLine_UoM2.FINDFIRST() then
            ShortcutQtyUomValue[2] := SalesCrMemoLine_UoM2.Quantity;

        SalesCrMemoLine_UoM3.SETRANGE("Document No.", SalesCrMemoLine2."Document No.");
        SalesCrMemoLine_UoM3.SETRANGE("Line No.", SalesCrMemoLine2."Line No.");
        //SalesCrMemoLine_UoM3.SETRANGE("Unit of Measure Code", WarehouseSetup."Shortcut Unit of Measure3 Code");//BC UPGRADE ATHUKS01 Drink IT Field
        if SalesCrMemoLine_UoM3.FINDFIRST() then
            ShortcutQtyUomValue[3] := SalesCrMemoLine_UoM3.Quantity;
        //HEI.12<<

        //HEI.14>>
        SalesCrMemoLine_UoM4.SETRANGE("Document No.", SalesCrMemoLine2."Document No.");
        SalesCrMemoLine_UoM4.SETRANGE("Line No.", SalesCrMemoLine2."Line No.");
        SalesCrMemoLine_UoM4.SETRANGE("Unit of Measure Code", WarehouseSetup."Shortcut Unit of Meas4Code FND");
        if SalesCrMemoLine_UoM4.FINDFIRST() then
            ShortcutQtyUomValue[4] := SalesCrMemoLine_UoM4.Quantity;
        //HEI.14<<
    end;
}

