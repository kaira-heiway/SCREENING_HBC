report 53029 "Sales Invoice BA"
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
    // HEI.08 Defect #1679 IBM NASTAA02 22.03.2018 # Sales invoice goods print
    //   # Removed Company Name 2 from Layout
    //   # Moved lower the Customer Information
    //   # Moved higher the Customer NIF, NIS, NART, NRC
    // HEI.09 Bugfixing IBM NASTAA02 29.03.2018 # Bugfixing Algeria
    //   # InvDisAmount should be deducted in the Total Amount Excl VAT and not from the Total Amount Incl VAT
    // HEI.10 Defect #1409 IBM NASTAA02 30.03.2018 # Free Beer Invoice Printout
    //   # Added Free Item Value for 100% Discounts
    // HEI.11 FDD-BA-LOGGAP03 IBM NASTAA02 20.08.2018 # Sales Invoice and Sales Credit Memo Layout
    //   # Copied Report 50098 - Sales Invoice Base ALG and created layout according to Bahamas requirements
    // HEI.12 FDD-BA-LOGGAP03 IBM NASTAA02 20.08.2018 # Sales Invoice and Sales Credit Memo Layout
    //   # A Filter needs to be used instead of Field "Shortcut Qty per Unit of Measure 2 Code"
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
    // HEI.16 Bugfixing Bahamas IBM NASTAA02 21.01.2019 # Sales Invoice - Discounts
    //   # Discounts should not be always deducted. Removed 'ABS' from formula
    // HEI.17 Bugfixing Bahamas IBM NASTAA02 31.01.2019 # Sales Invoice - Discounts
    //   # Discounts should not be always deducted from Unit Price and Line Amoun
    // HEI.18 Bugfixing Bahamas IBM NASTAA02 01.04.2019 # Sales Invoice - Layout
    //   # Increased font
    // HEI.19 RFC-CHG2042986 IBM.AB 23.12.2019
    //   # Layout Change for Invoice No in 2nd Page
    //*****************************************************//
    //BC UPGRADE ATHUKS01//
    //1.HEI.06 Commented Drink IT code & Drink IT fields
    //2.HEI.07 Commented Drink IT code & Drink IT fields
    //3.HEI.08,HEI.09,HEI.11 No changes 
    //4.HEI.10 Commented Field Free Item related code.
    //5.HEI.12 Commented WarehouseSetup.Shortcut Unit of Measure realted fields.
    //6.HEI.13 No changes
    //7.HEI.14 Commented WarehouseSetup.Shortcut Unit of Measure realted fields.
    //8.HEI.15 Logic is depend on Drink IT feild hence commented code .
    //9.HEI.16 Logic is depend on Drink IT feild hence commented code. 
    //10.HEI.17 Logic is depend on Drink IT feild hence commented code.
    //11.HEI.18 & HEI.19 Layout changes.
    //12.Old Report ID 50169.
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Sales Invoice BA.rdl';

    Caption = 'Sales Invoice BA';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Invoice Header';

            ;
            column(SalesInvoiceHeader_No; "No.")
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
                    column(SalesInvoiceHeader_PostingDate; FORMAT("Sales Invoice Header"."Posting Date", 0, '<Month,2>/<Day,2>/<Year4>'))
                    {
                    }
                    column(SalesInvoiceHeader_OrderNo; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(SalesInvoiceHeader_OrderDate; FORMAT("Sales Invoice Header"."Order Date", 0, '<Month,2>/<Day,2>/<Year4>'))
                    {
                    }
                    column(SalesInvoiceHeader_SellToCustomerNo; "Sales Invoice Header"."Sell-to Customer No.")
                    {
                    }
                    column(SalesInvoiceHeader_CustomerPO; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(PaymentTerms_Description; PaymentTerms.Description)
                    {
                    }
                    column(SalesInvoiceHeader_DueDate; FORMAT("Sales Invoice Header"."Due Date", 0, '<Month,2>/<Day,2>/<Year4>'))
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
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
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
                            IncludeCaption = true;
                        }
                        column(SalesInvoiceLine_UnitOfMeasure; "Unit of Measure Code")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesInvoiceLine_UnitPrice; UnitPrice2)
                        {
                        }
                        column(SalesInvoiceLine_LineAmount; LineAmount2)
                        {
                        }
                        column(SalesInvoiceLine_ItemPerUnit; "Qty. per Unit of Measure")
                        {
                        }
                        column(SalesInvoiceLine_ItemPackageSize; PackageSize)
                        {
                        }
                        //Drink IT
                        // column(TotalShortcutQtyUomValue1Caption; STRSUBSTNO(TotalUomLbl, WarehouseSetup."Shortcut Unit of Measure1 Code"))
                        // {
                        // }
                        column(TotalShortcutQtyUomValue1Caption; '')
                        {
                        }
                        //Drink IT
                        column(TotalShortcutQtyUomValue1; TotalShortcutQtyUomValue[1])
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        //Drink IT 
                        // column(TotalShortcutQtyUomValue2Caption; STRSUBSTNO(TotalUomLbl, WarehouseSetup."Shortcut Unit of Measure2 Code"))
                        // {
                        // }
                        column(TotalShortcutQtyUomValue2Caption; '')
                        {
                        }
                        //Drink IT 

                        column(TotalShortcutQtyUomValue2; TotalShortcutQtyUomValue[2])
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        //Drink IT
                        // column(TotalShortcutQtyUomValue3Caption; STRSUBSTNO(TotalUomLbl, WarehouseSetup."Shortcut Unit of Measure3 Code"))
                        // {
                        // }
                        column(TotalShortcutQtyUomValue3Caption; '')
                        {
                        }
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
                        column(LineAmount; LineAmount2)
                        {
                        }
                        column(UnitPrice; UnitPrice2)
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
                        //Drink IT
                        // column(ShowItemCharge; "Show Item charge on Invoice")
                        // {
                        // }
                        column(ShowItemCharge; '')
                        {
                        }

                        // column(ItemChargeType; "Item Charge Type")
                        // {
                        // }
                        column(ItemChargeType; '')
                        {
                        }
                        //Drink IT
                        trigger OnAfterGetRecord();
                        var
                            ItemCrossReference: Record "Item Reference";
                            ReservEntry: Record "Reservation Entry";
                            ItemLedgEntry: Record "Item Ledger Entry";
                            OrderChargeLine: Record "Sales Invoice Line";
                            SalesChargeLine: Record "Sales Invoice Line";
                            Item2: Record Item;
                            SalesInvoiceLine2: Record "Sales Invoice Line";
                            ShortcutQtyUomValue: array[4] of Decimal;
                            UnitOfMeasureR: Record "Unit of Measure";
                            ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
                            ItemAttributeValue: Record "Item Attribute Value";
                            ItemChargesInclInPrice: Record "Item Charge";
                            ItemCharge2: Record "Item Charge";
                            ItemCharge3: Record "Item Charge";
                            SalesInvoiceLine: Record "Sales Invoice Line";
                        begin
                            //IF (Type = Type::"Charge (Item)") THEN
                            //CurrReport.SKIP;

                            //BC UPGRADE ATHUKS01>>
                            //HEI.15>>
                            //Show Discount Item Charge
                            // if Type = Type::"Charge (Item)" then begin
                            //     if ("Item Charge Type" = "Item Charge Type"::Discount) and
                            //        (("Show Item charge on Invoice" = "Show Item charge on Invoice"::" ") or
                            //         ("Show Item charge on Invoice" = "Show Item charge on Invoice"::"Order total"))
                            //     then
                            //         ShowDiscount := true;
                            // end;
                            //BC UPGRADE ATHUKS01<< 
                            //Include in Item Price
                            UnitPrice2 := "Unit Price";
                            LineAmount2 := "Line Amount";
                            //BC UPGRADE ATHUKS01>> Drink IT field   
                            // SalesInvoiceLine.RESET();
                            // SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                            // SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
                            // SalesInvoiceLine.SETRANGE("Attached to Line No.", "Line No.");
                            // SalesInvoiceLine.SETRANGE("Item Charge Type", SalesInvoiceLine."Item Charge Type"::Discount);
                            // if SalesInvoiceLine.FINDSET() then
                            //     repeat
                            //         if SalesInvoiceLine."Show Item charge on Invoice" = SalesInvoiceLine."Show Item charge on Invoice"::"Include in item price" then begin
                            //             //HEI.17>>
                            //             LineAmount2 += SalesInvoiceLine."Line Amount";
                            //             if SalesInvoiceLine.Quantity > 0 then
                            //                 UnitPrice2 += SalesInvoiceLine."Unit Price"
                            //             else
                            //                 UnitPrice2 -= SalesInvoiceLine."Unit Price";
                            //             //HEI.07<<
                            //         end;
                            //     until SalesInvoiceLine.NEXT() = 0;
                            //HEI.15<<
                            //BC UPGRADE ATHUKS01<< Drink IT field      
                            //-----Subtotal
                            if
                            (
                             (Type = Type::Item) and not (IsEmptyGoodItem())
                             or (Type in [Type::Resource, Type::"Fixed Asset", Type::"G/L Account"])
                            ) then begin
                                SubTotal += "Line Amount";
                                TotalSubTotal += "Line Amount";
                            end;
                            if ItemsInvoice then begin
                                //Tax to Grand Total + Total + Line Amount
                                SalesChargeLine.RESET();
                                SalesChargeLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Invoice Line".Type::"Charge (Item)");
                                // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Invoice Line"."Item Charge Type"::Tax);
                                //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Include in item price");syed
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                if SalesChargeLine.FINDSET() then
                                    repeat
                                        //"Sales Invoice Line"."Line Amount" += SalesChargeLine."Line Amount";syed
                                        //SubTotal += SalesChargeLine."Line Amount";syed
                                        TotalSubTotal += SalesChargeLine."Line Amount";
                                    until SalesChargeLine.NEXT() = 0;
                                //BC UPGRADE ATHUKS01>> Drink IT field
                                //Discounts to Grand Total + Total + Line Amount
                                //SalesChargeLine.RESET();
                                //SalesChargeLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                //SalesChargeLine.SETRANGE(Type, "Sales Invoice Line".Type::"Charge (Item)");
                                // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Invoice Line"."Item Charge Type"::Discount);
                                //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Include in item price"); //HEI.06
                                //SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                // if SalesChargeLine.FINDSET() then begin
                                //     //HEI.06>>
                                //     ItemCharge.GET(SalesChargeLine."No.");
                                //     if ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::"Include in item price" then
                                //         //HEI.06<<
                                //         repeat
                                //             "Sales Invoice Line"."Line Amount" += SalesChargeLine."Line Amount";
                                //             SubTotal += SalesChargeLine."Line Amount";
                                //             TotalSubTotal += SalesChargeLine."Line Amount";
                                //         until SalesChargeLine.NEXT() = 0;
                                // end; //HEI.06
                                //Discounts under item line
                                //BC UPGRADE ATHUKS01<< Drink IT field    
                                CLEAR(PrintUnderLineCharge);
                                SalesChargeLine.RESET();
                                SalesChargeLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Invoice Line".Type::"Charge (Item)");
                                //SalesChargeLine.SETRANGE("Item Charge Type", "Sales Invoice Line"."Item Charge Type"::Discount);//BC UPGRADE ATHUKS01>> Drink IT field
                                //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line"); HEI.06
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                if SalesChargeLine.FINDSET() then begin
                                    //HEI.06>>
                                    ItemCharge.GET(SalesChargeLine."No.");
                                    //BC UPGRADE ATHUKS01>> Drink IT field
                                    // if ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::"Under item line" then
                                    //     //HEI.06<<
                                    //     if not PrintUnderLineCharge then
                                    //         PrintUnderLineCharge := true;
                                    // repeat
                                    //     TempUnderChargeLine.INIT();
                                    //     TempUnderChargeLine := SalesChargeLine;
                                    //     TempUnderChargeLine.INSERT();
                                    // until (SalesChargeLine.NEXT() = 0);
                                    //BC UPGRADE ATHUKS01<< Drink IT field
                                    SalesChargeLine.CALCSUMS("Line Amount");
                                    SubTotal += SalesChargeLine."Line Amount";
                                    TotalSubTotal += SalesChargeLine."Line Amount";
                                end;
                                //Tax under item line
                                SalesChargeLine.RESET();
                                SalesChargeLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Invoice Line".Type::"Charge (Item)");
                                //SalesChargeLine.SETRANGE("Item Charge Type", "Sales Invoice Line"."Item Charge Type"::Tax);
                                //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line"); HEI.06
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                if SalesChargeLine.FINDSET() then begin
                                    //HEI.06>>
                                    ItemCharge.GET(SalesChargeLine."No.");
                                    // if ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::"Under item line" then
                                    //     //HEI.06<<
                                    //     repeat
                                    //         if (SalesChargeLine."Line Amount" <> 0) then begin
                                    //             if not PrintUnderLineCharge then
                                    //                 PrintUnderLineCharge := true;
                                    //             TempUnderChargeLine.INIT();
                                    //             TempUnderChargeLine := SalesChargeLine;
                                    //             TempUnderChargeLine.INSERT();
                                    //         end;
                                    //     until (SalesChargeLine.NEXT() = 0);
                                    SalesChargeLine.CALCSUMS("Line Amount");
                                    SubTotal += SalesChargeLine."Line Amount";
                                    TotalSubTotal += SalesChargeLine."Line Amount";
                                end; //HEI.06
                                if ("Sales Invoice Line".Quantity <> 0) then
                                    "Sales Invoice Line"."Unit Price" := "Sales Invoice Line"."Line Amount" / "Sales Invoice Line".Quantity;
                            end;

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
                            // PromotionSalesInvoiceLine.SETRANGE("Item Charge Type", PromotionSalesInvoiceLine."Item Charge Type"::Promotion);//BC UPGRADE ATHUKS01 Drink IT Field 
                            //PromotionSalesInvoiceLine.SETRANGE("Item Charge Discount %", 100); //BC UPGRADE ATHUKS01 Drink IT Field 
                            if PromotionSalesInvoiceLine.FINDFIRST() then begin
                                PromotionItemChargeAmt := PromotionSalesInvoiceLine."Line Discount Amount";
                                // PromotionItemChargeValue := PromotionSalesInvoiceLine."Item Charge Value";//BC UPGRADE ATHUKS01 Drink IT Field 
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
                            //DiscountSalesInvoiceLine.SETRANGE("Free Item", true);//BC UPGRADE ATHUKS01 Drink IT Field 
                            DiscountSalesInvoiceLine.SETRANGE("Line Discount %", 100);
                            if DiscountSalesInvoiceLine.FINDFIRST() then begin
                                DiscountItemChargeAmt := DiscountSalesInvoiceLine."Line Discount Amount";
                                //DiscountItemChargeValue := DiscountSalesInvoiceLine."Item Charge Value";//BC UPGRADE ATHUKS01 Drink IT Field 
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

                            SalesInvoiceLine2.SETRANGE("Document No.", "Document No.");
                            SalesInvoiceLine2.SETRANGE("Line No.", "Line No.");
                            SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine2.Type::Item);
                            SalesInvoiceLine2.SETFILTER(Quantity, '>%1', 0);
                            if SalesInvoiceLine2.FINDSET() then
                                repeat
                                    ShowShortcutUomValue(ShortcutQtyUomValue, SalesInvoiceLine2);
                                    TotalShortcutQtyUomValue[1] += ShortcutQtyUomValue[1];
                                    TotalShortcutQtyUomValue[2] += ShortcutQtyUomValue[2];
                                    TotalShortcutQtyUomValue[3] += ShortcutQtyUomValue[3];
                                    TotalShortcutQtyUomValue[4] += ShortcutQtyUomValue[4]; //HEI.14
                                until SalesInvoiceLine2.NEXT() = 0;
                            //HEI.11<<
                        end;

                        trigger OnPreDataItem();
                        begin
                            CLEAR(TotalShortcutQtyUomValue); //HEI.14

                            MoreLines := FINDLAST;

                            while MoreLines and (Description = '') and ("Description 2" = '') and
                                  ("No." = '') and (Quantity = 0) and
                                  (Amount = 0)
                            do
                                MoreLines := NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");

                            TempEmptyGoodItemLine.RESET;
                            if TempEmptyGoodItemLine.FINDLAST then
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
                                TempUnderChargeLine.FINDFIRST
                            else
                                TempUnderChargeLine.NEXT;
                        end;

                        trigger OnPostDataItem();
                        begin
                            TempUnderChargeLine.RESET;
                            TempUnderChargeLine.DELETEALL;
                        end;

                        trigger OnPreDataItem();
                        begin
                            TempUnderChargeLine.RESET;
                            TempUnderChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
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
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
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

                        SalesInvLineAmt.RESET();
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        //>>HEI:CHG0153013:1:1 14/12/16 IBM.AV
                        //SalesInvLineAmt.SETRANGE(Type,SalesInvLineAmt.Type::Item); //commented
                        SalesInvLineAmt.SETRANGE(Type, SalesInvLineAmt.Type::Item, SalesInvLineAmt.Type::"Fixed Asset");   //added
                        //<<HEI:CHG0153013:1:1 14/12/16 IBM.AV
                        if SalesInvLineAmt.FINDSET() then
                            repeat
                                //InvLineTotal += SalesInvLineAmt."Line Amount" + SalesInvLineAmt."Line Discount Amount";
                                InvLineTotal += SalesInvLineAmt."Line Amount";
                            until SalesInvLineAmt.NEXT() = 0;

                        //<<HEI:CHG0187935:1:1 24/08/17 IBM.SP
                        SalesInvLineAmt.RESET();
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLineAmt.SETRANGE(Type, SalesInvLineAmt.Type::"G/L Account");   //sP
                        if SalesInvLineAmt.FINDSET() then
                            repeat
                                //InvLineTotal += SalesInvLineAmt."Line Amount" + SalesInvLineAmt."Line Discount Amount";
                                InvLineTotal += SalesInvLineAmt."Line Amount";
                            until SalesInvLineAmt.NEXT() = 0;

                        //<<HEI:CHG0187935:1:1 24/08/17 IBM.SP


                        //BC UPGRADE ATHUKS01>>  
                        // SalesInvLine.RESET();
                        // SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        // SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");

                        // TaxAmout := 0; //HEI.03
                        // if SalesInvLine.FINDSET() then
                        //     repeat
                        //         case SalesInvLine."Item Charge Type" of
                        //             SalesInvLine."Item Charge Type"::Tax:
                        //                 begin
                        //                     TotalFooterAmount[1] += SalesInvLine."Line Amount";
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::Deposit:
                        //                 begin
                        //                     if SalesInvLine."Line Amount" > 0 then begin
                        //                         TotalFooterAmount[2] += SalesInvLine."Line Amount";
                        //                     end else if SalesInvLine."Line Amount" < 0 then begin
                        //                         TotalFooterAmount[3] += SalesInvLine."Line Amount";
                        //                     end;
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::"Shipping Cost":
                        //                 begin
                        //                     TotalFooterAmount[4] += SalesInvLine."Line Amount";
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::Discount:
                        //                 begin
                        //                     //HEI.16>>
                        //                     //TotalFooterAmount[5] += ABS(SalesInvLine."Line Amount");
                        //                     TotalFooterAmount[5] += SalesInvLine."Line Amount";
                        //                     //HEI.16<<
                        //                     TotalFooterAmountText[5] := 'Invoice Discounts';
                        //                 end;
                        //         end;
                        //     until SalesInvLine.NEXT() = 0;
                        //BC UPGRADE ATHUKS01<<

                        TaxAmout := TotalFooterAmount[1];
                        DepAmountP := TotalFooterAmount[2];
                        DepAmountN := TotalFooterAmount[3];
                        ShipAmount := TotalFooterAmount[4];

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");

                        if SalesInvLine.FINDSET() then
                            repeat
                                TotalFooterAmount[5] += SalesInvLine."Inv. Discount Amount";
                                TotalFooterAmountText[5] := SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                                TotalFooterAmount[6] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[6] := SalesInvLine.FIELDCAPTION("Line Discount Amount");
                            until SalesInvLine.NEXT() = 0;

                        InvDisAmount := TotalFooterAmount[5];
                        LineDisAmount := TotalFooterAmount[6];

                        //HEI.16>>
                        //AmttoPaid := InvLineTotal + TaxAmout + DepAmountP + ShipAmount - DepAmountN -ABS(LineDisAmount) - ABS(InvDisAmount);
                        //HEI.16<<
                        AmttoPaid := InvLineTotal + TaxAmout + DepAmountP + ShipAmount - DepAmountN + InvDisAmount;
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
                begin

                    if Print then
                        SalesInvCountPrinted.RUN("Sales Invoice Header");
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
                SalesInvoiceHeader: Record "Sales Invoice Header";
                ShipmentMethod: Record "Shipment Method";
                DeliveryTime1: Text;
                DeliveryTime2: Text;
                //StandardTextReport: Record "Standard Text Report"; Drink IT
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
                CurrReportID: Integer;
                i: Integer;
                IsTextToInclude: Boolean;
                ItemLedgerEntry: Record "Item Ledger Entry";
                NoSeriesMgt: Codeunit "No. Series";
                ModifyHeader: Boolean;
                SalesDepositLines: Record "Sales Invoice Line";
                DepositGroupCode: Code[10];
                //DrinkDepositGroup: Record "Drink Deposit Group"; Drink IT
                OrderChargeLine: Record "Sales Invoice Line";
                EmtpyGoodValueEntryNo: Integer;
                ValueEntry: Record "Value Entry";
                SalesInvLine2: Record "Sales Invoice Line";
                SalesInvLine3: Record "Sales Invoice Line";
                StartingShipmentdate: Date;
                // LoyaltyBalanceBuffer: Record "Loyalty Balance Buffer" temporary; Drink IT
                BeginBalDate: Date;
                EndBalDate: Date;
                BeginningMonth: Date;
            // LoyaltyLedgerEntry: Record "Loyalty Ledger Entry";Drink IT
            begin
                Reprinted := "No. Printed" > 0; //HEI.13
                CLEAR(ShowDiscount); //HEI.15

                if PaymentMethod.GET("Sales Invoice Header"."Payment Method Code") then;
                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Invoice Header"."Language Code");
                Customer.GET("Sales Invoice Header"."Sell-to Customer No.");
                if "Sales Invoice Header"."Bill-to Customer No." <> '' then
                    Customer.GET("Bill-to Customer No.");

                //-----Company Info
                CompanyInfo.GET();

                //BC UPGRADE ATHUKS01>>
                //HEI.18>>
                // if "Location Code" = 'BS05' then
                //     OurTINNo := CompanyInfo."Tax Warehouse Reference"
                // else
                //     OurTINNo := CompanyInfo."Tax Registration No.";
                //HEI.18<<
                //BC UPGRADE ATHUKS01<<

                //-----Item Invoice
                SalesInvLine2.RESET();
                SalesInvLine2.SETRANGE("Document No.", "No.");
                SalesInvLine2.SETRANGE(Type, SalesInvLine2.Type::Item);
                if not SalesInvLine2.ISEMPTY then ItemsInvoice := true;

                //HEI.11>>
                FormatAddr.SalesInvBillTo(BillToCustomerAddress, "Sales Invoice Header");
                FormatAddr.SalesInvShipTo(ShipToCustomerAddress, BillToCustomerAddress, "Sales Invoice Header");
                //HEI.11

                //-----Currency Code
                if ("Currency Code" <> '') then
                    CurrCode := "Currency Code"
                else begin
                    GLSetup.GET();
                    CurrCode := GLSetup."LCY Code";
                end;

                //-------VAT
                CLEAR(SumTotalVatAmt);
                VATAmountLine.DELETEALL();
                SalesInvLine.CalcVATAmountLines("Sales Invoice Header", VATAmountLine);
                SumTotalVatAmt += VATAmountLine."VAT Amount";

                CLEAR(TotalDeposits);
                CLEAR(TotalDiscounts);
                CLEAR(TotalTaxes);
                //BC UPGRADE ATHUKS01>> Drink IT fields 
                //-----Order total /blank Discount Charges
                // OrderChargeLine.RESET();
                // OrderChargeLine.SETRANGE("Document No.", "No.");
                // OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                // // OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Discount);BC UPGRADE ATHUKS01
                // //OrderChargeLine.SETFILTER("Show Item charge on Invoice",'%1|%2',OrderChargeLine."Show Item charge on Invoice"::"Order total",OrderChargeLine."Show Item charge on Invoice"::" "); HEI.06
                // if OrderChargeLine.FINDSET() then begin
                //     //HEI.06>>
                //     ItemCharge.GET(OrderChargeLine."No.");
                //     if (ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::"Order total")
                //         or (ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::" ")
                //     then begin
                //         //HEI.06<<
                //         PrintOrderDiscounts := true;
                //         repeat
                //             TempOrderDiscountCharge.INIT();
                //             TempOrderDiscountCharge := OrderChargeLine;
                //             TempOrderDiscountCharge.INSERT();
                //         until (OrderChargeLine.NEXT() = 0);
                //         OrderChargeLine.CALCSUMS("Line Amount");
                //         TotalDiscounts += OrderChargeLine."Line Amount";
                //     end; //HEI.06
                // end;

                //-----Order total /blank Deposit Charges

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
                //         until (OrderChargeLine.NEXT = 0);
                //         OrderChargeLine.CALCSUMS("Line Amount");
                //         TotalTaxes += OrderChargeLine."Line Amount";
                //     end; //HEI.06
                // end;
                //BC UPGRADE ATHUKS01<< Drink IT fields 

                VatAmt := 0; //HEI.03
                VATEntry.RESET();
                VATEntry.SETRANGE(Type, VATEntry.Type::Sale);
                VATEntry.SETRANGE("Document Type", VATEntry."Document Type"::Invoice);
                VATEntry.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                if VATEntry.FINDSET() then
                    repeat
                        VatAmt += VATEntry.Amount;
                    until VATEntry.NEXT() = 0;
                VATAmount := -VatAmt;
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
                        Caption = 'No. of Copies';
                        ToolTip = 'No. of Copies';
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
        CompanyInfo.CALCFIELDS(Picture); //HEI.04
        //FCE-
        //CurrReport.LANGUAGE := LanguageR.GetLanguageID(CompanyInfo."Language Code");//BC UPGRADE ATHUKS01
        CurrReport.Language := LanguageMgt.GetLanguageId(CompanyInfo."Language Code FND");
        // FCE+
    end;

    var
        CompanyInfo: Record "Company Information";
        LanguageR: Record Language;
        LanguageMgt: Codeunit Language;
        CompanyText: Text;
        OutputNo: Integer;
        TextFooter: array[3] of Text;
        HeaderAddr: array[8] of Text[50];
        FormatAddr: Codeunit "Format Address";
        Customer: Record Customer;
        ReportTitle: Text;
        //Driver: Record "Whse. Shipping Driver"; Drink IT
        SalesPerson: Record "Salesperson/Purchaser";
        CommentLine: Record "Comment Line";
        SalesCommentLine: Record "Sales Comment Line";
        TempCommentLine: Record "Comment Line" temporary;
        CommentLineNo: Integer;
        TempMarketingText: Record "Extended Text Line" temporary;
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        Print: Boolean;
        QtyHL: Decimal;
        CrossRefText: Text;
        ExpirationDate: Date;
        //FreeReasonCode: Record "Free Reason Code"; Drink IT
        FreeReasonText: Text;
        Item: Record Item;
        TempEmptyGoodItemLine: Record "Sales Invoice Line" temporary;
        LineNo: Integer;
        PaymentMethod: Record "Payment Method";
        PrintShipmentText: Boolean;
        PrintPrice: Boolean;
        TempOrderDiscountCharge: Record "Sales Invoice Line" temporary;
        TotalOrderDiscCharges: Decimal;
        SubTotal: Decimal;
        CurrCode: Code[10];
        GLSetup: Record "General Ledger Setup";
        //SalesDepositItemCharge: Record "Sales Deposit Item Charge";Drink IT
        BeginningBalance: Decimal;
        EndBalance: Decimal;
        Gains: Decimal;
        Sales: Decimal;
        PrintLoyaltyStatement: Boolean;
        TempOrderDepositCharge: Record "Sales Invoice Line" temporary;
        TotalSubTotal: Decimal;
        PrintOrderDiscounts: Boolean;
        PrintOrderDeposits: Boolean;
        VATAmountLine: Record "VAT Amount Line" temporary;
        VATPerText: Text;
        Text015: Label 'Invoice No.';
        SalesInvLine: Record "Sales Invoice Line";
        ItemsInvoice: Boolean;
        PriceUOM: Code[10];
        InventorySetup: Record "Inventory Setup";
        TotalDiscounts: Decimal;
        TotalDeposits: Decimal;
        PrintEmptyGoodsStatement: Boolean;
        TempCustomer: Record Customer temporary;
        //TempLoyaltyBuffer: Record "Loyalty Balance Buffer"; Drink IT
        Cust: Record Customer;
        DisplayMarketingBlock: Boolean;
        PrintUnderLineCharge: Boolean;
        TempUnderChargeLine: Record "Sales Invoice Line" temporary;
        TempOrderTaxCharge: Record "Sales Invoice Line" temporary;
        PrintOrderTaxes: Boolean;
        TotalTaxes: Decimal;
        Footertext: Text;
        PaymentTerms: Record "Payment Terms";
        SumTotalVatAmt: Decimal;
        TotalFooterAmount: array[6] of Decimal;
        TotalFooterAmountText: array[6] of Text[50];
        InvTotalAmount: Decimal;
        AmttoPaid: Decimal;
        ShipAmount: Decimal;
        DepAmountP: Decimal;
        DepAmountN: Decimal;
        LineDisAmount: Decimal;
        InvDisAmount: Decimal;
        InvLineTotal: Decimal;
        VatAmt: Decimal;
        SalesInvLineAmt: Record "Sales Invoice Line";
        TaxAmout: Decimal;
        VATAmount: Decimal;
        VATEntry: Record "VAT Entry";
        NUMLines: Integer;
        LinesPrinted: Integer;
        TempOrderLineAmt: Decimal;
        NoString: Text;
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        Location: Record Location;
        ItemCharge: Record "Item Charge";
        CustAddr: array[4] of Text;
        HeinekenGlobal: Codeunit "Heineken Global";
        PromotionLine: Boolean;
        PromotionSalesInvoiceLine: Record "Sales Invoice Line";
        PromotionItemChargeAmt: Decimal;
        PromotionItemChargeValue: Decimal;
        BankInformationLbl: TextConst ENU = 'Bank Information', FRA = 'Réferences Bancaires';
        PhoneNoLbl: TextConst ENU = 'Phone No.', FRA = 'N° Téléphone';
        DiscountItemChargeAmt: Decimal;
        DiscountItemChargeValue: Decimal;
        DiscountLine: Boolean;
        DiscountSalesInvoiceLine: Record "Sales Invoice Line";
        LineAmount: Decimal;
        UnitPrice: Decimal;
        CompanyAddress: Text;
        CompanyAddress2: Text;
        CompanyCity: Text;
        CompanyPhoneNo: Code[20];
        CompanyEmail: Text;
        CompanyNRC: Text;
        LocationAddr: Record Location;
        ShipToLbl: Label 'Ship to:';
        InvoiceToLbl: Label 'Invoice to:';
        OurTINNoLbl: Label 'Our TIN Number';
        InvoiceDateLbl: Label 'Invoice Date';
        SalesOrderLbl: Label 'Sales Order';
        OrderDateLbl: Label 'Order Date';
        CustomerCodeLbl: Label 'Customer Code';
        CustomerPOLbl: Label 'Customer PO';
        PaymentTermLbl: Label 'Payment Term';
        DueDateLbl: Label 'Due Date';
        CustomerTINLbl: Label 'Customer TIN';
        ItemLbl: Label 'Item';
        DescriptionLbl: Label 'Description';
        QtyLbl: Label 'Qty';
        UnitLbl: Label 'Unit';
        SubtotalPerUnitLbl: Label 'Subtotal per Unit';
        SubtotalLbl: Label 'Subtotal';
        PackageSizeLbl: Label 'Package Size:';
        PerUnitLbl: Label 'Per Unit:';
        TotalIndvUnitsLbl: Label 'Total Indv. Units:';
        TotalCasesLbl: Label 'Total Cases:';
        TotalPalletsLbl: Label 'Total Pallets:';
        PalletsReturnedLbl: Label 'Pallets Returned';
        SpecificationLbl: Label 'Specification';
        VATlbl: Label 'VAT';
        BaseLbl: Label 'Base';
        VATAmountLbl: Label 'VAT Amount';
        TotalAmountLbl: Label 'Total Amount';
        ShipToCustomerAddress: array[8] of Text[60];
        BillToCustomerAddress: array[8] of Text[60];
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        TotalShortcutQtyUomValue: array[4] of Decimal;
        WhseSetupShortcutUomCode: array[3] of Code[10];
        WarehouseSetup: Record "Warehouse Setup";
        TotalUomLbl: TextConst ENU = 'Total %1', FRA = 'Total %1';
        EmailLbl: Label '"Email: "';
        PackageSize: Text[250];
        DocumentTitleTextLbl: Label 'VAT Invoice';
        Reprinted: Boolean;
        TotalBarrelsLbl: Label 'Total Barrels:';
        DiscountItemCharge: Record "Item Charge";
        ShowDiscount: Boolean;
        UnitPrice2: Decimal;
        LineAmount2: Decimal;
        OurTINNo: Code[20];

    local procedure IsEmptyGoodItem(): Boolean;
    begin
        if ("Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item) or (("Sales Invoice Line".Type = "Sales Invoice Line".Type::Item) and ("Sales Invoice Line"."No." = '')) then
            exit;
        Item.GET("Sales Invoice Line"."No.");
        //BC UPGRADE ATHUKS01>> Drink IT Field  
        // Item.CALCFIELDS("Empty Good");
        // exit(
        //   Item."Empty Good");
        //BC UPGRADE ATHUKS01<< Drink IT Field 
    end;

    local procedure ShowShortcutUomValue(var ShortcutQtyUomValue: array[4] of Decimal; SalesInvoiceLine2: Record "Sales Invoice Line");
    var
        SalesInvoiceLine_UoM1: Record "Sales Invoice Line";
        SalesInvoiceLine_UoM2: Record "Sales Invoice Line";
        SalesInvoiceLine_UoM3: Record "Sales Invoice Line";
        SalesInvoiceLine_UoM4: Record "Sales Invoice Line";
    begin
        //HEI.11>>
        CLEAR(ShortcutQtyUomValue);
        WarehouseSetup.GET();

        //HEI.12>>
        SalesInvoiceLine_UoM1.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        SalesInvoiceLine_UoM1.SETRANGE("Line No.", SalesInvoiceLine2."Line No.");
        // SalesInvoiceLine_UoM1.SETRANGE("Unit of Measure Code", WarehouseSetup."Shortcut Unit of Measure1 Code");//BC UPGRADE ATHUKS01
        if SalesInvoiceLine_UoM1.FINDFIRST() then
            ShortcutQtyUomValue[1] := SalesInvoiceLine_UoM1.Quantity;

        SalesInvoiceLine_UoM2.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        SalesInvoiceLine_UoM2.SETRANGE("Line No.", SalesInvoiceLine2."Line No.");
        // SalesInvoiceLine_UoM2.SETFILTER("Unit of Measure Code", WarehouseSetup."Short Unit of Measure2 Filter"); //BC UPGRADE ATHUKS01
        if SalesInvoiceLine_UoM2.FINDFIRST() then
            ShortcutQtyUomValue[2] := SalesInvoiceLine_UoM2.Quantity;

        SalesInvoiceLine_UoM3.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        SalesInvoiceLine_UoM3.SETRANGE("Line No.", SalesInvoiceLine2."Line No.");
        //SalesInvoiceLine_UoM3.SETRANGE("Unit of Measure Code", WarehouseSetup."Shortcut Unit of Measure3 Code");//BC UPGRADE ATHUKS01
        if SalesInvoiceLine_UoM3.FINDFIRST() then
            ShortcutQtyUomValue[3] := SalesInvoiceLine_UoM3.Quantity;
        //HEI.12<<

        //HEI.14>>
        SalesInvoiceLine_UoM4.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        SalesInvoiceLine_UoM4.SETRANGE("Line No.", SalesInvoiceLine2."Line No.");
        //SalesInvoiceLine_UoM4.SETRANGE("Unit of Measure Code", WarehouseSetup."Shortcut Unit of Measure4 Code"); //BC UPGRADE ATHUKS01
        if SalesInvoiceLine_UoM4.FINDFIRST() then
            ShortcutQtyUomValue[4] := SalesInvoiceLine_UoM4.Quantity;
        //HEI.14<<
    end;
}

