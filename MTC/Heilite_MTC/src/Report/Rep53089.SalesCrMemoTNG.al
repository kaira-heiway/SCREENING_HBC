report 53089 "Sales Cr. Memo TNG"
{
    // version HEI.03

    // HEI.01 FDD-AL-OTCGAP01a IBM HORTOC01 29.09.2017
    //   # New report
    // 
    // HEI.02 FDD-KDD0TC005 IBM NASTAA02 9.11.2017 # RPM Billing and Reporting
    //   # New groupping added on "RPM Type"
    // 
    // HEI.03 Bugfixing IBM NASTAA02 20.11.2017 # Local Algeria
    //   # Used fields "Registre de Commerce","Article d'imposition","N.I.S." from Customer Attributes table
    //   # Replaced Responsibility Center Information with Company Information
    //   # Replaced CustAddr with data from Customer
    // BASE_FCE01 - Added Print Language from the start
    // BASE FCE02 - 12.01.2018 Commented the Request page when printing second report

    // BC Upgrade KUMARS145 Nav ID Report 50038 "Sales Cr. Memo TNG"

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Sales Cr. Memo TNG.rdl';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(SalesHDocNo; "Sales Cr.Memo Header"."No.") { }
            column(CustRC; CustomerAttributes."Registre de Commerce") { }
            column(CustTaxItem; CustomerAttributes."Article d'imposition") { }
            column(CustVATNo; Customer."VAT Registration No.") { }
            column(CustNIS; CustomerAttributes."N.I.S.") { }
            column(CurrentTime; TIME) { }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(ReprintedText; ReprintedText) { }
                    column(OrderConfirmCopyCaption; DocumentTitleText) { }
                    column(SalesHCustNo; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SalesHPostDate; FORMAT("Sales Cr.Memo Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDueDate; FORMAT("Sales Cr.Memo Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDocDate; FORMAT("Sales Cr.Memo Header"."Document Date", 0, 4)) { }
                    column(SalesHIncVAT; PriceIncVAT) { }
                    column(SalesHSalesPerName; SalesPerson.Name) { }
                    column(OutputNo; OutputNo) { }
                    column(SalesHOrdNo; "Sales Cr.Memo Header"."Return Order No.") { }
                    column(SalesHReference; "Sales Cr.Memo Header"."Your Reference") { }
                    column(SalesHExtRefNo; "Sales Cr.Memo Header"."External Document No.") { }
                    column(SalesHVATRegNo; "Sales Cr.Memo Header"."VAT Registration No.")
                    {
                        IncludeCaption = true;
                    }
                    column(PaymentTermDescrip; PaymentTerms.Description) { }
                    column(PayMethodDescrip; PaymentMethod.Description) { }
                    column(CompanyInfo_Name; CompanyInfo.Name) { }
                    column(CompanyInfo_Name2; CompanyInfo."Name 2") { }
                    column(CompanyInfo_VATNo; CompanyInfo."VAT Registration No.") { }
                    column(CompanyInfo_Telex; CompanyInfo."Telex Answer Back") { }
                    column(CompanyInfo_Address; CompanyInfo.Address) { }
                    column(CompanyInfo_Address2; CompanyInfo."Address 2") { }
                    column(CompanyInfo_City; CompanyInfo.City) { }
                    column(CompanyInfo_Email; CompanyInfo."E-Mail") { }
                    column(Customer_Name; Customer.Name) { }
                    column(Customer_Name2; Customer."Name 2") { }
                    column(Customer_Address; Customer.Address) { }
                    column(Customer_City; Customer.City) { }
                    column(Customer_Country; Country.Name) { }
                    column(Customer_HouseNo; CustomerAttributes."House No. 1") { }
                    column(TotalSubTotal; TotalSubTotal)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(SubTotal; ROUND(InvLineTotal, 0.01, '=')) { }
                    column(VATAmount; VATAmount) { }
                    column(TotalIncText; TotalInText) { }
                    column(SubTotalExcText; SubTotalExText) { }
                    column(TaxAmount; TaxAmout) { }
                    column(TaxAmtCaption; TotalFooterAmountText[1]) { }
                    column(DepositAmountP; DepAmountP) { }
                    column(DepositAmtCaptionP; TotalFooterAmountText[2]) { }
                    column(DepositAmountN; DepAmountN) { }
                    column(DepositAmtCaptionN; TotalFooterAmountText[3]) { }
                    column(ShippingAmount; ShipAmount) { }
                    column(ShippingAmtCaption; TotalFooterAmountText[4]) { }
                    column(InvDiscountAmt; InvDisAmount) { }
                    column(InvDiscCaption; TotalFooterAmountText[5]) { }
                    column(LineDiscountAmt; LineDisAmount) { }
                    column(LineDiscCaption; TotalFooterAmountText[6]) { }
                    column(AmountPaid; ROUND(AmttoPaid, 0.01, '=')) { }
                    column(InvTotalAmt; ROUND(InvTotalAmount, 0.01, '=')) { }
                    column(AmtLetter; AmountLetter) { }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(PrintPrice; PrintPrice) { }
                        column(PrintUnderLineCharge; PrintUnderLineCharge) { }
                        column(LineAmount_SalesLine; "Line Amount") { }
                        column(UnitPrice_SalesLine; "Unit Price") { }
                        column(Type_SalesLine; FORMAT(Type, 0, 2)) { }
                        column(SalesLType; "Sales Cr.Memo Line".Type) { }
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
                        column(SalesUOM; "Sales Cr.Memo Line"."Unit of Measure Code") { }
                        column(SalesPrice; ROUND("Sales Cr.Memo Line"."Unit Price", 0.01, '=')) { }
                        column(SalesVATPer; "Sales Cr.Memo Line"."VAT %")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesDisAmt; "Sales Cr.Memo Line"."Line Discount Amount") { }
                        column(SalesAmount; ROUND(("Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Price") - "Sales Cr.Memo Line"."Line Discount Amount", 0.01, '=')) { }
                        column(TotalQuantity; TotalQty) { }
                        column(RPMType; RPMType) { }
                        column(RPMTypeNotBlank; RPMType <> '') { }
                        dataitem(BlankLine; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(BlankLine; NUMLines) { }

                            trigger OnPreDataItem();
                            begin
                                SETRANGE(Number, 1, NUMLines)
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            // BC Upgrade KUMARS145 Replaced with new table.....>>
                            // ItemCrossReference : Record "Item Cross Reference";
                            ItemCrossReference: Record "Item Reference";
                            // BC Upgrade KUMARS145 Replaced with new table.....<<
                            ReservEntry: Record "Reservation Entry";
                            ItemLedgEntry: Record "Item Ledger Entry";
                            OrderChargeLine: Record "Sales Cr.Memo Line";
                            SalesChargeLine: Record "Sales Cr.Memo Line";
                        begin
                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;

                            //HEI.02>>
                            if PrintPerRPMType and (Type = Type::Item) and Item.GET("No.") then
                                RPMType := Item."RPM Type FND";
                            //HEI.02>>
                            //<<DITW17.00.02 RPG 07/11/2013 DIT-770 #235
                            // BC Upgrade KUMARS145 code dependent on Drinkit field......>>
                            // FreeReasonDesc := '';
                            // if "Free Item" then
                            //     if FreeReasonCode.GET("Free Reason Code") then
                            //         FreeReasonDesc := FreeReasonCode.Description
                            //     else
                            //         FreeReasonDesc := 'Free';

                            //<<Empty Goods Details
                            // if ("Item Charge Type" = "Item Charge Type"::Deposit) and ("Empty Goods Item No." <> '') then begin
                            //     if Quantity > 0 then
                            //         TotalDeposits += "Line Amount"
                            //     else
                            //         TotalReturnedDeposits += "Line Amount";

                            //     NNC_TotalLineAmount += "Line Amount";
                            // end;
                            //>>Empty Goods Details
                            // BC Upgrade KUMARS145 code dependent on Drinkit field......<<

                            LineQtyinHL := 0;
                            LineTaxAmount := 0;
                            LineDiscAmount := 0;
                            UnitPriceCalculated := 0;
                            if Type = Type::Item then begin

                                // LineQtyinHL := Quantity * "Unit Volume HL"; // BC Upgrade KUMARS145 code dependent on Drinkit field.

                                SalesCrMemoLine.RESET();
                                SalesCrMemoLine.SETRANGE("Document No.", "Document No.");
                                SalesCrMemoLine.SETRANGE(Type, Type::"Charge (Item)");
                                // SalesCrMemoLine.SETRANGE("Item Charge Type", "Item Charge Type"::Tax); // BC Upgrade KUMARS145 code dependent on Drinkit field.
                                // SalesCrMemoLine.SETRANGE("Item Charge Calculate per", "Item Charge Calculate per"::Item); // BC Upgrade KUMARS145 code dependent on Drinkit field.
                                SalesCrMemoLine.SETRANGE("Attached to Line No.", "Line No.");
                                if SalesCrMemoLine.FINDSET() then
                                    repeat
                                        LineTaxAmount += SalesCrMemoLine."Line Amount";
                                    until SalesCrMemoLine.NEXT() = 0;

                                SalesCrMemoLine.RESET();
                                SalesCrMemoLine.SETRANGE("Document No.", "Document No.");
                                SalesCrMemoLine.SETRANGE(Type, Type::"Charge (Item)");
                                // SalesCrMemoLine.SETRANGE("Item Charge Type", "Item Charge Type"::Discount); // BC Upgrade KUMARS145 code dependent on Drinkit field.
                                // SalesCrMemoLine.SETRANGE("Item Charge Calculate per", "Item Charge Calculate per"::Item); // BC Upgrade KUMARS145 code dependent on Drinkit field.
                                SalesCrMemoLine.SETRANGE("Attached to Line No.", "Line No.");
                                if SalesCrMemoLine.FINDSET() then
                                    repeat
                                        LineDiscAmount += SalesCrMemoLine."Line Amount";
                                    until SalesCrMemoLine.NEXT() = 0;

                                "Line Amount" := "Line Amount" + LineTaxAmount + LineDiscAmount;
                                NNC_TotalLineAmount += "Line Amount";
                                TotalLineAmount += "Line Amount";
                                // BC Upgrade KUMARS145 code dependent on Drinkit field.....>>
                                // end else begin
                                //     if ((Type <> Type::" ") and (Type <> Type::Item) and (Type <> Type::"Charge (Item)")) or
                                //       ((Type = Type::"Charge (Item)") and ("Item Charge Calculate per" = "Item Charge Calculate per"::Order))

                                //     then begin
                                //         TotalOtherCharges += "Line Amount";
                                //         NNC_TotalLineAmount += "Line Amount";
                                //     end;
                                // BC Upgrade KUMARS145 code dependent on Drinkit field.....<<
                            end;

                            // BC Upgrade KUMARS145 code dependent on Drinkit field.....>>
                            // if "Unit Volume Sales Price" = "Unit Volume Sales Price"::No then begin
                            //     PriceUOM := "Unit of Measure Code";
                            //     if Quantity <> 0 then
                            //         UnitPriceCalculated := "Line Amount" / Quantity;
                            // end else begin
                            //     PriceUOM := VolumeUOM;
                            //     if ("Quantity (Base)" <> 0) and ("Unit Volume HL" <> 0) then
                            //         UnitPriceCalculated := "Line Amount" / "Quantity (Base)" / "Unit Volume HL";
                            // end;
                            // BC Upgrade KUMARS145 code dependent on Drinkit field.....<<
                            //>>DITW17.00.02 RPG DIT-770 #235

                            //<<DITW17.00.02 RPG 07/11/20 13 DIT-770 #235
                            //NNC_TotalLineAmount += "Line Amount";
                            //>>DITW17.00.02 RPG DIT-770 #235
                            NNC_TotalAmountInclVat += "Amount Including VAT";
                            NNC_TotalInvDiscAmount += "Inv. Discount Amount";
                            NNC_TotalAmount += Amount;

                            SalesShipmentBuffer.DELETEALL();
                            PostedReceiptDate := 0D;
                            if Quantity <> 0 then
                                PostedReceiptDate := FindPostedShipmentDate();

                            //<<DITW17.00.02 RPG 07/11/20 13 DIT-770 #235
                            //IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                            //  "No." := '';
                            //>>DITW17.00.02 RPG DIT-770 #235

                            VATAmountLine.INIT();
                            VATAmountLine."VAT Identifier" := "VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            if "Allow Invoice Disc." then
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine();


                            if (Type = Type::"Charge (Item)") then
                                CurrReport.SKIP();
                            // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.......>>
                            // //-----Qty in HL
                            // CLEAR(QtyHL);
                            // if (Type = Type::Item) and ("No." <> '') then
                            //     QtyHL := Quantity * "Unit Volume HL";
                            // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.......<<

                            // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.......>>
                            // //-----Cross Reference Info
                            // CLEAR(CrossRefText);
                            // if Customer."Cross. Ref. on Del. Note" then begin
                            //     if (Type = Type::Item) and ("No." <> '') then
                            //         CrossRefText := GetCrossReferences();
                            // end;
                            // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.......<<
                            // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.......>>
                            // //-----Expiration Info
                            // CLEAR(ExpirationDate);
                            // if Customer."Exp. Date on Del. Note" then begin
                            //     ReservEntry.RESET();
                            //     ReservEntry.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
                            //     ReservEntry.SETRANGE("Source Type", 113);
                            //     ReservEntry.SETRANGE("Source Subtype", 1);
                            //     ReservEntry.SETRANGE("Source ID", "Document No.");
                            //     ReservEntry.SETRANGE("Source Ref. No.", "Line No.");
                            //     if ReservEntry.FINDFIRST() then begin
                            //         ItemLedgEntry.RESET();
                            //         ItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");
                            //         ItemLedgEntry.SETRANGE("Item No.", ReservEntry."Item No.");
                            //         ItemLedgEntry.SETRANGE(Open, true);
                            //         ItemLedgEntry.SETRANGE("Variant Code", ReservEntry."Variant Code");
                            //         if ReservEntry."Lot No." <> '' then
                            //             ItemLedgEntry.SETRANGE("Lot No.", ReservEntry."Lot No.")
                            //         else
                            //             if ReservEntry."Serial No." <> '' then
                            //                 ItemLedgEntry.SETRANGE("Serial No.", ReservEntry."Serial No.");
                            //         ItemLedgEntry.SETRANGE(Positive, true);

                            //         if ItemLedgEntry.FINDLAST() then
                            //             ExpirationDate := ItemLedgEntry."Expiration Date";
                            //     end;
                            // end;
                            // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.......<<
                            // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.......>>
                            // //-----Free Reason Text
                            // CLEAR(FreeReasonText);
                            // if "Free Reason Code" <> '' then begin
                            //     FreeReasonCode.GET("Free Reason Code");
                            //     FreeReasonText := FreeReasonCode.Description;
                            // end;
                            // //-----Price Info
                            // CLEAR(PrintPrice);
                            // if ItemsInvoice then
                            //     if (Type = Type::Item) and ("No." <> '') then begin
                            //         Item.GET("No.");
                            //         Item.CALCFIELDS("Empty Good");
                            //         PrintPrice := not (Item."Empty Good");
                            //     end;
                            // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.......<<

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
                                SalesChargeLine.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Cr.Memo Line".Type::"Charge (Item)");
                                // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Cr.Memo Line"."Item Charge Type"::Tax); // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                                // SalesChargeLine.SETRANGE("Show Item charge on Invoice", SalesChargeLine."Show Item charge on Invoice"::"Include in item price"); // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Cr.Memo Line"."Line No.");
                                if SalesChargeLine.FINDSET() then
                                    repeat
                                        "Sales Cr.Memo Line"."Line Amount" += SalesChargeLine."Line Amount";
                                        SubTotal += SalesChargeLine."Line Amount";
                                        TotalSubTotal += SalesChargeLine."Line Amount";
                                    until SalesChargeLine.NEXT() = 0;
                                //Discounts to Grand Total + Total + Line Amount
                                SalesChargeLine.RESET();
                                SalesChargeLine.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Cr.Memo Line".Type::"Charge (Item)");
                                // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Cr.Memo Line"."Item Charge Type"::Discount); // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                                // SalesChargeLine.SETRANGE("Show Item charge on Invoice", SalesChargeLine."Show Item charge on Invoice"::"Include in item price");// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Cr.Memo Line"."Line No.");
                                if SalesChargeLine.FINDSET() then
                                    repeat
                                        "Sales Cr.Memo Line"."Line Amount" += SalesChargeLine."Line Amount";
                                        SubTotal += SalesChargeLine."Line Amount";
                                        TotalSubTotal += SalesChargeLine."Line Amount";
                                    until SalesChargeLine.NEXT() = 0;
                                //Discounts under item line
                                CLEAR(PrintUnderLineCharge);
                                SalesChargeLine.RESET();
                                SalesChargeLine.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Cr.Memo Line".Type::"Charge (Item)");
                                // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Cr.Memo Line"."Item Charge Type"::Discount);// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                                // SalesChargeLine.SETRANGE("Show Item charge on Invoice", SalesChargeLine."Show Item charge on Invoice"::"Under item line");// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Cr.Memo Line"."Line No.");
                                if SalesChargeLine.FINDSET() then
                                    if not PrintUnderLineCharge then
                                        PrintUnderLineCharge := true;
                                repeat
                                /* TempUnderChargeLine.INIT();
                                 TempUnderChargeLine := SalesChargeLine;
                                 TempUnderChargeLine.INSERT();*/
                                until (SalesChargeLine.NEXT() = 0);
                                SalesChargeLine.CALCSUMS("Line Amount");
                                SubTotal += SalesChargeLine."Line Amount";
                                TotalSubTotal += SalesChargeLine."Line Amount";
                                //Tax under item line
                                SalesChargeLine.RESET();
                                SalesChargeLine.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Cr.Memo Line".Type::"Charge (Item)");
                                // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Cr.Memo Line"."Item Charge Type"::Tax);// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                                // SalesChargeLine.SETRANGE("Show Item charge on Invoice", SalesChargeLine."Show Item charge on Invoice"::"Under item line");// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Cr.Memo Line"."Line No.");
                                if SalesChargeLine.FINDSET() then
                                    repeat
                                        if (SalesChargeLine."Line Amount" <> 0) then //begin
                                            if not PrintUnderLineCharge then
                                                PrintUnderLineCharge := true;
                                    /* TempUnderChargeLine.INIT();
                                     TempUnderChargeLine := SalesChargeLine;
                                     TempUnderChargeLine.INSERT();*/
                                    // end;
                                    until (SalesChargeLine.NEXT() = 0);
                                SalesChargeLine.CALCSUMS("Line Amount");
                                SubTotal += SalesChargeLine."Line Amount";
                                TotalSubTotal += SalesChargeLine."Line Amount";
                                if ("Sales Cr.Memo Line".Quantity <> 0) then
                                    "Sales Cr.Memo Line"."Unit Price" := "Sales Cr.Memo Line"."Line Amount" / "Sales Cr.Memo Line".Quantity;
                            end;

                        end;

                        trigger OnPreDataItem();
                        begin
                            // SETFILTER("Item Charge Type", '<>%1', "Item Charge Type"::Deposit);// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
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
                            TotalSubTotal := TotalDeposits + TotalDiscounts + TotalTaxes;
                        end;
                    }
                    // BC Upgrade KUMARS145 commneted as Dataitem was dependent on Drinkit Table......>>
                    // dataitem("Delayed Disc. & Promo. Line"; "Delayed Disc. & Promo. Line")
                    // {
                    //     DataItemTableView = SORTING("Sequence No.");
                    //     column(DDPNo; "Delayed Disc. & Promo. Line"."No.") { }
                    //     column(DDPDescrip; "Delayed Disc. & Promo. Line".Description) { }
                    //     column(DDPCreateQty; "Delayed Disc. & Promo. Line"."Created Quantity") { }
                    //     column(DDPUOM; "Delayed Disc. & Promo. Line"."Unit of Measure Code") { }
                    //     column(DDPUnitPrice; "Delayed Disc. & Promo. Line"."Unit Price") { }
                    //     column(DDPLineDis; "Delayed Disc. & Promo. Line"."Line Discount %") { }
                    //     column(DDPVATPer; "Delayed Disc. & Promo. Line"."VAT %") { }
                    //     column(DDPCreatedLineDiscAmt; "Delayed Disc. & Promo. Line"."Created Line Discount Amount") { }
                    //     column(DDPCreateLineAmt; "Delayed Disc. & Promo. Line"."Created Line Amount") { }

                    //     trigger OnPreDataItem();
                    //     begin
                    //         SETRANGE("Last Post. Document Type", "Last Post. Document Type"::"Sales Credit Memo");
                    //         SETRANGE("Last Post. Document No.", "Sales Cr.Memo Header"."No.");
                    //         if ISEMPTY then
                    //             CurrReport.BREAK();
                    //     end;
                    // }
                    // BC Upgrade KUMARS145 commneted as Dataitem was dependent on Drinkit Table......<<
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
                        //>>HEI:INC0259274:1:1 28/07/16 IBM.AV
                        CLEAR(InvLineTotal);                   //Added
                        //<<HEI:INC0259274:1:1 28/07/16 IBM.AV
                        CLEAR(AmountLetter);

                        DocumentTitleText := STRSUBSTNO(DocumentCaption2(), CopyText);

                        SalesInvLineAmt.RESET();
                        SalesInvLineAmt.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        //>>HEI:INC0259274:1:1 28/07/16 IBM.AV
                        //SalesInvLineAmt.SETRANGE(Type,SalesInvLine.Type::"Charge (Item)");
                        SalesInvLineAmt.SETFILTER(Type, '<>%1', SalesInvLine.Type::"Charge (Item)");  // added
                        //<<HEI:INC0259274:1:1 28/07/16 IBM.AV

                        if SalesInvLineAmt.FINDSET() then
                            repeat
                                InvLineTotal += SalesInvLineAmt."Line Amount" + SalesInvLineAmt."Line Discount Amount";
                            until SalesInvLineAmt.NEXT() = 0;
                        // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field......>>
                        // SalesInvLine.RESET();
                        // SalesInvLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        // SalesInvLine.SETRANGE(Type, SalesInvLine.Type::"Charge (Item)");
                        // // SalesInvLine.SETFILTER("Item Charge Type", '<>%1', SalesInvLine."Item Charge Type"::Deposit);// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.

                        // if SalesInvLine.FINDSET() then
                        //     repeat
                        //         case SalesInvLine."Item Charge Type" of
                        //             SalesInvLine."Item Charge Type"::Tax:
                        //                 begin
                        //                     TotalFooterAmount[1] += SalesInvLine."Line Amount";
                        //                     TotalFooterAmountText[1] := Text57002;
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::Deposit:
                        //                 begin
                        //                     if SalesInvLine."Line Amount" > 0 then begin
                        //                         TotalFooterAmount[2] += SalesInvLine."Line Amount";
                        //                         TotalFooterAmountText[2] := Text57004;
                        //                     end else if SalesInvLine."Line Amount" < 0 then begin
                        //                         TotalFooterAmount[3] += SalesInvLine."Line Amount";
                        //                         TotalFooterAmountText[3] := Text57005;
                        //                     end;
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::"Shipping Cost":
                        //                 begin
                        //                     TotalFooterAmount[4] += SalesInvLine."Line Amount";
                        //                     TotalFooterAmountText[4] := Text57006;
                        //                 end;
                        //             SalesInvLine."Item Charge Type"::Discount:
                        //                 begin
                        //                     //>>HEI:INC0259274:1:1 28/07/16 IBM.AV
                        //                     // TotalFooterAmount[5] += SalesInvLine."Line Amount";          // Commented
                        //                     TotalFooterAmount[5] += ABS(SalesInvLine."Line Amount");            // Added ABS
                        //                                                                                         //<<HEI:INC0259274:1:1 28/07/16 IBM.AV
                        //                     TotalFooterAmountText[5] := 'Invoice Discounts';
                        //                 end;
                        //         end;
                        //     until SalesInvLine.NEXT() = 0;
                        // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.....<<
                        TaxAmout := TotalFooterAmount[1];
                        DepAmountP := TotalFooterAmount[2];
                        DepAmountN := TotalFooterAmount[3];
                        ShipAmount := TotalFooterAmount[4];

                        SalesInvLine.RESET();
                        SalesInvLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                        // SalesInvLine.SETFILTER("Item Charge Type", '<>%1', SalesInvLine."Item Charge Type"::Deposit); // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.        

                        if SalesInvLine.FINDSET() then
                            repeat
                                TotalFooterAmount[5] += SalesInvLine."Inv. Discount Amount";
                                TotalFooterAmountText[5] := SalesInvLine.FIELDCAPTION("Inv. Discount Amount");
                                TotalFooterAmount[6] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[6] := SalesInvLine.FIELDCAPTION("Line Discount Amount");
                            until SalesInvLine.NEXT() = 0;

                        InvDisAmount := TotalFooterAmount[5];
                        LineDisAmount := TotalFooterAmount[6];

                        //IF ShowSplittedDeposit THEN
                        AmttoPaid := InvLineTotal + TaxAmout + ShipAmount - ABS(LineDisAmount); //>>HEI:INC0259274:1:1 28/07/16 IBM.AV added ABS to LineDisAmount
                        //ELSE
                        //  AmttoPaid := InvLineTotal+TaxAmout+DepAmountP+ShipAmount-DepAmountN-ABS(LineDisAmount);  //>>HEI:INC0259274:1:1 28/07/16 IBM.AV added ABS to LineDisAmount

                        InvTotalAmount := AmttoPaid + VatAmt - ABS(InvDisAmount);       //>>HEI:INC0259274:1:1 28/07/16 IBM.AV added ABS to LineDisAmount

                        HeinekenGlobal.AmountInLetter(AmountLetter, ROUND(InvTotalAmount, 0.01, '='))
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then //begin
                        CopyText := Text52000;
                    // end;
                    //HEI.01>>
                    if "Sales Cr.Memo Header"."No. Printed" > 0 then
                        ReprintedText := Reprintedlbl;
                    //HEI.01<<
                    CurrReport.PAGENO := 1;
                    OutputNo := OutputNo + 1;
                end;

                trigger OnPostDataItem();
                begin
                    if not CurrReport.PREVIEW then
                        SalesCrMemoCountPrinted.RUN("Sales Cr.Memo Header");
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies);
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;

                    CopyText := '';
                    ReprintedText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord();
            var
                SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                ShipmentMethod: Record "Shipment Method";
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
                DeliveryTime1: Text;
                DeliveryTime2: Text;
                // StandardTextReport: Record "Standard Text Report";
                CurrReportID: Integer;
                i: Integer;
                IsTextToInclude: Boolean;
                ItemLedgerEntry: Record "Item Ledger Entry";
                // BC Upgrade KUMARS145 Replaced with new NoSeriesManagement Codeunit....>>
                // NoSeriesMgt: Codeunit  NoSeriesManagement;
                NoSeriesMgt: Codeunit "No. Series";
                // BC Upgrade KUMARS145 Replaced with new NoSeriesManagement Codeunit....<<
                ModifyHeader: Boolean;
                SalesDepositLines: Record "Sales Cr.Memo Line";
                DepositGroupCode: Code[10];
                // DrinkDepositGroup: Record "Drink Deposit Group";
                OrderChargeLine: Record "Sales Cr.Memo Line";
                EmtpyGoodValueEntryNo: Integer;
                ValueEntry: Record "Value Entry";
                SalesCrMemoLine2: Record "Sales Cr.Memo Line";
                SalesCrMemoLine3: Record "Sales Cr.Memo Line";
                StartingShipmentdate: Date;
                // LoyaltyBalanceBuffer: Record "Loyalty Balance Buffer" temporary; // BC Upgrade KUMARS145 Commented Drinkit Record.
                BeginBalDate: Date;
                EndBalDate: Date;
                BeginningMonth: Date;
            // LoyaltyLedgerEntry: Record "Loyalty Ledger Entry"; // BC Upgrade KUMARS145 Commented Drinkit Record.
            begin
                // BASE_FCE01-+ CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                CurrReport.LANGUAGE := GetLanguageID(PrintLanguage);
                if CustomerAttributes.GET("Sales Cr.Memo Header"."Sell-to Customer No.") then;
                if RespCenter.GET("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else// begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                // end;

                FormatAddr.SalesCrMemoBillTo(CustAddr, "Sales Cr.Memo Header");
                if PaymentMethod.GET("Sales Cr.Memo Header"."Payment Method Code") then;

                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Cr.Memo Header"."Language Code");

                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalExText := STRSUBSTNO(Text52001, GLSetup."LCY Code");
                    TotalInText := STRSUBSTNO(Text52002, GLSetup."LCY Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := STRSUBSTNO(Text52005, GLSetup."LCY Code");
                end else begin
                    TotalExText := STRSUBSTNO(Text52001, "Currency Code");
                    TotalInText := STRSUBSTNO(Text52002, "Currency Code");
                    SubTotalInText := STRSUBSTNO(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := STRSUBSTNO(Text52005, GLSetup."LCY Code");
                end;

                VATEntry.RESET();
                VATEntry.SETRANGE(Type, VATEntry.Type::Sale);
                VATEntry.SETRANGE("Document Type", VATEntry."Document Type"::"Credit Memo");
                VATEntry.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                if VATEntry.FINDSET() then
                    repeat
                        VatAmt += VATEntry.Amount;
                    until VATEntry.NEXT() = 0;
                VATAmount := VatAmt;

                SalesInvLine.RESET();
                SalesInvLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                SalesInvLine.SETFILTER("VAT %", '<>%1', 0);
                if SalesInvLine.FINDFIRST() then
                    VATPer := SalesInvLine."VAT %";

                if Customer.GET("Bill-to Customer No.") then
                    if Country.GET(Customer."Country/Region Code") then; //HEI.03

                //syed23222017>>
                /*
                //-----Company Info
                CompanyInfo.GET();
                //Picture
                CompanyInfo.CALCFIELDS(Picture);
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
                
                //-----Report Title
                ReportTitle := Text002;
                */
                //-----Item Invoice
                SalesCrMemoLine2.RESET();
                SalesCrMemoLine2.SETRANGE("Document No.", "No.");
                SalesCrMemoLine2.SETRANGE(Type, SalesCrMemoLine2.Type::Item);
                if not SalesCrMemoLine2.ISEMPTY then ItemsInvoice := true;

                //-----Shipment Address
                if ("Bill-to Country/Region Code" = CompanyInfo."Country/Region Code") then begin
                    SalesCrMemoHeader.COPY("Sales Cr.Memo Header");
                    SalesCrMemoHeader."Bill-to Country/Region Code" := '';
                    FormatAddr.SalesCrMemoBillTo(HeaderAddr, SalesCrMemoHeader);
                end else
                    FormatAddr.SalesCrMemoBillTo(HeaderAddr, "Sales Cr.Memo Header");
                /*
                //Shipment Text
                CLEAR(PrintShipmentText);
                  PrintShipmentText := ("Bill-to Name" <> "Ship-to Name") OR
                                       ("Bill-to Name 2" <> "Ship-to Name 2") OR
                                       ("Bill-to Address" <> "Ship-to Address") OR
                                       ("Bill-to Address 2" <> "Ship-to Address 2") OR
                                       ("Bill-to Post Code" <> "Ship-to Post Code") OR
                                       ("Bill-to City" <> "Ship-to City");
                
                //-----Header Tel. & Fax
                Customer.RESET();
                Customer.GET("Sell-to Customer No.");
                
                //-----Driver Info
                IF ("Driver Code" <> '') THEN BEGIN
                  Driver.RESET();
                  Driver.GET("Driver Code");
                END;
                
                //-----SalesPerson Info
                IF ("Salesperson Code" <> '') THEN BEGIN
                  SalesPerson.RESET();
                  SalesPerson.GET("Salesperson Code");
                END;
                */
                //-----Comment Lines
                TempCommentLine.RESET();
                TempCommentLine.DELETEALL();
                CommentLineNo := 10000;
                //Customer Comments
                CommentLine.RESET();
                CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Customer);
                CommentLine.SETRANGE("No.", "Sell-to Customer No.");
                // CommentLine.SETRANGE("Print on Invoice", true); // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                if CommentLine.FINDSET() then
                    repeat
                        InsertCommentLine(CommentLine.Comment);
                    until CommentLine.NEXT() = 0;
                //Sales Comments
                SalesCommentLine.RESET();
                SalesCommentLine.SETRANGE("Document Type", SalesCommentLine."Document Type"::"Posted Credit Memo");
                SalesCommentLine.SETRANGE("No.", "No.");
                // SalesCommentLine.SETRANGE("Print on Invoice", true);// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                if SalesCommentLine.FINDSET() then
                    repeat
                        InsertCommentLine(SalesCommentLine.Comment);
                    until SalesCommentLine.NEXT() = 0;

                //-----Marketing Texts
                CLEAR(CurrReportID);
                CLEAR(i);

                CLEAR(DisplayMarketingBlock);
                EVALUATE(CurrReportID, COPYSTR(CurrReport.OBJECTID(false), 8));
                // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field........>>
                // StandardTextReport.RESET();
                // TempMarketingText.DELETEALL();
                // StandardTextReport.SETRANGE("Report ID", CurrReportID);
                // StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Line);
                // if StandardTextReport.FINDFIRST() then begin
                //     ExtendedTextHeader.RESET();
                //     ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                //     ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                //     if ExtendedTextHeader.FINDSET() then
                //         repeat
                //             IsTextToInclude := true;
                //             if (ExtendedTextHeader."Starting Date" <> 0D) then
                //                 IsTextToInclude := (ExtendedTextHeader."Starting Date" <= "Document Date");
                //             if IsTextToInclude and (ExtendedTextHeader."Ending Date" <> 0D) then
                //                 IsTextToInclude := (ExtendedTextHeader."Ending Date" >= "Document Date");
                //             if IsTextToInclude then begin
                //                 ExtendedTextLine.RESET();
                //                 ExtendedTextLine.SETRANGE("Table Name", ExtendedTextHeader."Table Name");
                //                 ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                //                 ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                //                 ExtendedTextLine.SETRANGE("Language Code", "Language Code");
                //                 if ExtendedTextHeader."All Language Codes" then
                //                     ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
                //                 if ExtendedTextLine.FINDFIRST() then begin
                //                     DisplayMarketingBlock := true;
                //                     repeat
                //                         TempMarketingText.INIT();
                //                         TempMarketingText := ExtendedTextLine;
                //                         TempMarketingText.INSERT();
                //                     until (ExtendedTextLine.NEXT() = 0);
                //                 end;
                //             end;
                //         until ExtendedTextHeader.NEXT() = 0;
                // end;
                // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field......<<
                //-----Footer Texts
                CLEAR(CurrReportID);
                CLEAR(i);
                CLEAR(TextFooter);
                EVALUATE(CurrReportID, COPYSTR(CurrReport.OBJECTID(false), 8));
                // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.......>>
                // StandardTextReport.SETRANGE("Report ID", CurrReportID);
                // StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);

                // if StandardTextReport.FINDSET() then
                //     repeat
                //         i := 1;
                //         ExtendedTextHeader.RESET();
                //         ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                //         ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                //         if ExtendedTextHeader.FINDSET() then begin
                //             repeat
                //                 ExtendedTextLine.RESET();
                //                 ExtendedTextLine.SETRANGE("Table Name", ExtendedTextHeader."Table Name");
                //                 ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                //                 ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                //                 ExtendedTextLine.SETRANGE("Language Code", "Language Code");
                //                 if ExtendedTextHeader."All Language Codes" then
                //                     ExtendedTextLine.SETRANGE("Language Code", ExtendedTextHeader."Language Code");
                //                 if ExtendedTextLine.FINDSET() then begin
                //                     repeat
                //                         TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                //                     until (ExtendedTextLine.NEXT() = 0) or (i > ARRAYLEN(TextFooter));
                //                 end;
                //                 i += 1;
                //             until (ExtendedTextHeader.NEXT() = 0);
                //         end;
                //     until (StandardTextReport.NEXT() = 0);
                // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.....<<
                //-----Currency Code
                if ("Currency Code" <> '') then
                    CurrCode := "Currency Code"
                else begin
                    GLSetup.GET();
                    CurrCode := GLSetup."LCY Code";
                end;
                //-------VAT
                VATAmountLine.DELETEALL();
                SalesCrMemoLine.CalcVATAmountLines("Sales Cr.Memo Header", VATAmountLine);
                if ItemsInvoice then begin
                    //-----Empty Goods Block
                    TempEmptyGoodItemLine.RESET();
                    TempEmptyGoodItemLine.DELETEALL();
                    // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.......>>
                    // if (Customer."Empty Goods Statement On" in [Customer."Empty Goods Statement On"::Invoice, Customer."Empty Goods Statement On"::"Invoice + Delivery Note"]) then begin
                    //     PrintEmptyGoodsStatement := true;
                    //     with SalesDepositLines do begin
                    //         SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                    //         SETRANGE(Type, Type::"Charge (Item)");
                    //         SETRANGE("Item Charge Type", "Item Charge Type"::Deposit);
                    //         SETFILTER("Empty Goods Item No.", '<>%1', '');
                    //         if FINDSET() then begin
                    //             repeat
                    //                 TempEmptyGoodItemLine.RESET();
                    //                 TempEmptyGoodItemLine.SETRANGE("No.", "Empty Goods Item No.");
                    //                 if not TempEmptyGoodItemLine.FINDFIRST() then begin
                    //                     LineNo += 10000;
                    //                     TempEmptyGoodItemLine.INIT();
                    //                     TempEmptyGoodItemLine."No." := "Empty Goods Item No.";
                    //                     if Item.GET("Empty Goods Item No.") then
                    //                         TempEmptyGoodItemLine.Description := Item.Description;
                    //                     if "Quantity (Base)" > 0 then begin
                    //                         TempEmptyGoodItemLine.Quantity := "Quantity (Base)";
                    //                         TempEmptyGoodItemLine."Unit Price" := Item."Deposit Value";
                    //                     end else begin
                    //                         TempEmptyGoodItemLine."Quantity (Base)" := -"Quantity (Base)";
                    //                         TempEmptyGoodItemLine."Unit Price" := Item."Deposit Value";
                    //                     end;
                    //                     TempEmptyGoodItemLine."Document No." := "No.";
                    //                     TempEmptyGoodItemLine."Line No." := LineNo;
                    //                     TempEmptyGoodItemLine.INSERT();
                    //                 end else begin
                    //                     if "Quantity (Base)" > 0 then begin
                    //                         TempEmptyGoodItemLine.Quantity += "Quantity (Base)";
                    //                     end else begin
                    //                         TempEmptyGoodItemLine."Quantity (Base)" += -"Quantity (Base)";
                    //                     end;
                    //                     TempEmptyGoodItemLine.MODIFY;
                    //                 end;
                    //             until (NEXT = 0);
                    //         end;
                    //     end;
                    // end;
                    // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field........<<
                    TempEmptyGoodItemLine.RESET();
                    if TempEmptyGoodItemLine.FINDSET() then
                        repeat
                            EmtpyGoodValueEntryNo := 0;
                            ValueEntry.RESET();
                            ValueEntry.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
                            // ValueEntry.SETRANGE("Empty Goods Item No.", "No.");// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                            if ValueEntry.FINDLAST() then
                                EmtpyGoodValueEntryNo := ValueEntry."Entry No.";

                            ValueEntry.RESET();
                            // ValueEntry.SETCURRENTKEY("Source Type", "Item Ledger Entry Source No.", "Empty Goods Item No.");// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                            ValueEntry.SETRANGE("Source Type", ValueEntry."Source Type"::Customer);
                            ValueEntry.SETRANGE("Source No.", "Sales Cr.Memo Header"."Bill-to Customer No.");
                            // ValueEntry.SETRANGE("Empty Goods Item No.", "No.");// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                            ValueEntry.SETFILTER("Entry No.", '..%1', EmtpyGoodValueEntryNo);
                            ValueEntry.CALCSUMS("Valued Quantity");
                            TempEmptyGoodItemLine."Amount Including VAT" := ValueEntry."Valued Quantity";//Balance After
                            TempEmptyGoodItemLine.Amount := TempEmptyGoodItemLine."Amount Including VAT" + (TempEmptyGoodItemLine.Quantity - TempEmptyGoodItemLine."Quantity (Base)");//Balance Before
                            TempEmptyGoodItemLine."Line Amount" := TempEmptyGoodItemLine."Unit Price" * (TempEmptyGoodItemLine.Quantity - TempEmptyGoodItemLine."Quantity (Base)");//Deposit Value
                            TempEmptyGoodItemLine.MODIFY();
                        until TempEmptyGoodItemLine.NEXT() = 0;
                    CLEAR(PrintLoyaltyStatement);
                    TempCustomer.RESET();
                    TempCustomer.DELETEALL();
                    // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field......>>
                    // if (Customer."Loyalty Statement On" in [Customer."Loyalty Statement On"::Invoice, Customer."Loyalty Statement On"::"Invoice + Delivery Note"]) then begin
                    //     PrintLoyaltyStatement := true;
                    //     SalesCrMemoLine3.RESET();
                    //     SalesCrMemoLine3.SETCURRENTKEY("Sell-to Customer No.", Type, "Document No.");
                    //     SalesCrMemoLine3.SETFILTER("Sell-to Customer No.", '<>%1', '');
                    //     SalesCrMemoLine3.SETRANGE("Document No.", "No.");
                    //     if SalesCrMemoLine3.FINDSET() then
                    //         repeat
                    //             SalesCrMemoLine3.SETRANGE("Sell-to Customer No.", SalesCrMemoLine3."Sell-to Customer No.");
                    //             TempCustomer.INIT();
                    //             TempCustomer."No." := SalesCrMemoLine3."Sell-to Customer No.";
                    //             TempCustomer.INSERT();
                    //             SalesCrMemoLine3.FINDLAST();
                    //             SalesCrMemoLine3.SETRANGE("Sell-to Customer No.");
                    //         until (SalesCrMemoLine3.NEXT() = 0);


                    //     //-----Loyalty Statement
                    //     if TempCustomer.FINDSET() then begin
                    //         TempLoyaltyBuffer.RESET();
                    //         TempLoyaltyBuffer.DELETEALL();
                    //         repeat
                    //             PrintLoyaltyStatement := true;
                    //             CLEAR(BeginningBalance);
                    //             CLEAR(EndBalance);
                    //             CLEAR(Gains);
                    //             CLEAR(Sales);
                    //             TempLoyaltyBuffer.INIT();
                    //             TempLoyaltyBuffer."Source No." := TempCustomer."No.";
                    //             LoyaltyBalanceBuffer.INIT();
                    //             LoyaltyBalanceBuffer.SETFILTER("Source Type Filter", '%1', LoyaltyBalanceBuffer."Source Type Filter"::Customer);
                    //             LoyaltyBalanceBuffer.SETFILTER("Source No. Filter", TempCustomer."No.");

                    //             BeginBalDate := CALCDATE('<CM-1M>', "Posting Date");
                    //             LoyaltyBalanceBuffer.SETFILTER("Date Filter", '..%1', BeginBalDate);
                    //             LoyaltyBalanceBuffer.CALCFIELDS("Net Point Change (Actual)");
                    //             BeginningBalance := LoyaltyBalanceBuffer."Net Point Change (Actual)";

                    //             EndBalDate := CALCDATE('<CM>', "Posting Date");
                    //             LoyaltyBalanceBuffer.SETFILTER("Date Filter", '..%1', EndBalDate);
                    //             LoyaltyBalanceBuffer.CALCFIELDS("Net Point Change (Actual)");
                    //             EndBalance := LoyaltyBalanceBuffer."Net Point Change (Actual)";

                    //             BeginningMonth := CALCDATE('<1D>', BeginBalDate);

                    //             LoyaltyLedgerEntry.RESET();
                    //             LoyaltyLedgerEntry.SETFILTER("Source Type", '%1', LoyaltyLedgerEntry."Source Type"::Customer);
                    //             LoyaltyLedgerEntry.SETFILTER("Source No.", TempCustomer."No.");
                    //             LoyaltyLedgerEntry.SETFILTER("Posting Date", '%1..%2', BeginningMonth, EndBalDate);
                    //             LoyaltyLedgerEntry.SETRANGE("Entry Type", LoyaltyLedgerEntry."Entry Type"::Sale);
                    //             LoyaltyLedgerEntry.SETRANGE("Loyalty Type", LoyaltyLedgerEntry."Loyalty Type"::Point);
                    //             LoyaltyLedgerEntry.CALCSUMS("Point Amount (Actual)");
                    //             TempLoyaltyBuffer."Balance (Points)" := LoyaltyLedgerEntry."Point Amount (Actual)";

                    //             LoyaltyLedgerEntry.SETFILTER("Entry Type", '<>%1', LoyaltyLedgerEntry."Entry Type"::Sale);
                    //             LoyaltyLedgerEntry.CALCSUMS("Point Amount (Actual)");
                    //             TempLoyaltyBuffer."Balance (Sales)" := LoyaltyLedgerEntry."Point Amount (Actual)";
                    //             TempLoyaltyBuffer.INSERT();
                    //         until (TempCustomer.NEXT() = 0);
                    //     end;
                    // end;
                    // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field........<<
                    CLEAR(TotalDeposits);
                    CLEAR(TotalDiscounts);
                    CLEAR(TotalTaxes);

                    //-----Order total /blank Discount Charges
                    OrderChargeLine.RESET();
                    OrderChargeLine.SETRANGE("Document No.", "No.");
                    OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                    // OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Discount);// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                    // OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" ");// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                    if OrderChargeLine.FINDSET() then begin
                        PrintOrderDiscounts := true;
                        repeat
                            TempOrderDiscountCharge.INIT();
                            TempOrderDiscountCharge := OrderChargeLine;
                            TempOrderDiscountCharge.INSERT();
                        until (OrderChargeLine.NEXT() = 0);
                        OrderChargeLine.CALCSUMS("Line Amount");
                        TotalDiscounts += OrderChargeLine."Line Amount";
                    end;
                    //-----Order total /blank Deposit Charges
                    OrderChargeLine.RESET();
                    OrderChargeLine.SETRANGE("Document No.", "No.");
                    OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                    // OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Deposit);// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                    // OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" ");// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                    if OrderChargeLine.FINDSET() then begin
                        PrintOrderDeposits := true;
                        repeat
                            TempOrderDepositCharge.INIT();
                            TempOrderDepositCharge := OrderChargeLine;
                            TempOrderDepositCharge.INSERT();
                        until (OrderChargeLine.NEXT() = 0);
                        OrderChargeLine.CALCSUMS("Line Amount");
                        TotalDeposits += OrderChargeLine."Line Amount";
                    end;
                    //-----Order total /blank Tax Charges
                    OrderChargeLine.RESET();
                    OrderChargeLine.SETRANGE("Document No.", "No.");
                    OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                    // OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Tax);// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                    // OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" ");// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
                    if OrderChargeLine.FINDSET() then begin
                        repeat
                            if (OrderChargeLine."Line Amount" <> 0) then begin
                                PrintOrderTaxes := true;
                                TempOrderTaxCharge.INIT();
                                TempOrderTaxCharge := OrderChargeLine;
                                TempOrderTaxCharge.INSERT();
                            end;
                        until (OrderChargeLine.NEXT() = 0);
                        OrderChargeLine.CALCSUMS("Line Amount");
                        TotalTaxes += OrderChargeLine."Line Amount";
                    end;
                end;
                //syed23112017<<

            end;

            trigger OnPostDataItem();
            begin
                NUMLines := 20;
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
                        ApplicationArea = all;
                        Caption = 'No. of Copies';
                    }
                    field(PrintPerRPMType; PrintPerRPMType)
                    {
                        ApplicationArea = all;
                        Caption = 'Print per RPM Type';
                    }
                    field(PrintLanguage; PrintLanguage)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Language';
                        TableRelation = Language;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            RequestPageUsed := true;
        end;
    }

    labels
    {
        label(lblPayTerms; ENU = 'Payment Terms',
                          FRA = 'Conditions Paiement')
        label(lblPayMethod; ENU = 'Payment Method',
                           FRA = 'Mode de réglement')
        label(lblAmtPaid; ENU = 'Total DA Excl. VAT',
                         FRA = 'Total DA HT')
        lblTotalQty = 'Total Quantity';
        label(lblSalesPerson; ENU = 'Sales Person',
                          FRA = 'Vendeur')
        label(lblUOM; ENU = 'Unit',
                     FRA = 'Unité')
        label(lblUnitPrice; ENU = 'Unit Price',
                           FRA = 'Prix Unité')
        label(lblSaleLAmt; ENU = 'Amount',
                          FRA = 'Montant')
        label(lblPageNo; ENU = 'Page No.',
                        FRA = 'Page')
        label(lblInvoiceNo; ENU = 'Credit Memo No.',
                           FRA = 'N° Avoir')
        label(lblVATAmt; ENU = 'VAT Amount',
                        FRA = 'Montant TVA')
        label(lblPostDate; ENU = 'Date',
                          FRA = 'Date')
        label(lblDiscAmt; ENU = 'Disc. Amount',
                         FRA = 'Remise Montant')
        lblPriceIncVAT = 'Price Including VAT';
        label(lblRegNo; ENU = 'RC No. :',
                                                              FRA = 'N° RC :')
        label(lblIfNo; ENU = 'I.F No. :',
                      FRA = 'N° I.F :')
        label(lblArticleNo; ENU = 'Item No. :',
                           FRA = 'N° ART :')
        label(lblPhone; ENU = 'Phone No. :',
                       FRA = 'Téléphone :')
        label(lblFax; ENU = 'Fax No. :',
                     FRA = 'N°  Télécopie :')
        label(lblAmtinWord; ENU = 'Amount in Words :',
                           FRA = 'La présente avoir est arrêtée à la somme de :')
        label(lblNIS; ENU = 'N.I.S.',
                     FRA = 'N.I.S.')
        label(lblOrder; ENU = 'Return Order No.',
                       FRA = 'N° Retour')
        lblTime = 'Time'; RPMTypeLbl = 'RPM Type:'; TotalLbl = 'Total';
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        CompanyInfo.GET();
        SalesSetup.GET();
        // BASE_FCE01-
        PrintLanguage := CompanyInfo."Language Code FND";
        // BASE_FCE02+
    end;

    trigger OnPostReport();
    begin
        SalesCrMemoLine.RESET();
        SalesCrMemoLine.SETRANGE("Document No.", "Sales Cr.Memo Header"."No.");
        // SalesCrMemoLine.SETFILTER("Item Charge Type", '%1', SalesCrMemoLine."Item Charge Type"::Deposit);// BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.
        if SalesCrMemoLine.FINDFIRST() then begin
            ReportEmpties.GetVars("Sales Cr.Memo Header"."No.", NoOfCopies);
            /* FCE02-IF NOT RequestPageUsed THEN
              ReportEmpties.USEREQUESTPAGE(FALSE);

          FCE02+*/
            ReportEmpties.RUNMODAL();
        end;

    end;

    trigger OnPreReport();
    begin
        // BASE_FCE01-
        CurrReport.LANGUAGE := GetLanguageID(PrintLanguage);
        // BASE_FCE01+
    end;

    var
        CompanyInfo: Record "Company Information";
        LanguageRec: Record Language;
        Country: Record "Country/Region";
        VATEntry: Record "VAT Entry";
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        Customer: Record Customer;
        SalesPerson: Record "Salesperson/Purchaser";
        RespCenter: Record "Responsibility Center";
        SalesInvLine: Record "Sales Cr.Memo Line";
        SalesInvLineAmt: Record "Sales Cr.Memo Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        Item: Record Item;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SalesCrMemoCountPrinted: Codeunit "Sales Cr. Memo-Printed";
        HeinekenGlobal: Codeunit "Heineken Global";
        ReportEmpties: Report "Sales Cr. Memo Empties TNG";
        AmountLetter: Text[250];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        NoOfLoops: Integer;
        NoOfCopies: Integer;
        OutputNo: Integer;
        NUMLines: Integer;
        Text52000: TextConst ENU = 'COPY', FRA = 'COPIE';
        Text52001: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 HT';
        Text52002: TextConst ENU = 'Total %1 Incl. VAT', FRA = 'Total %1 TTC';
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
        TotalFooterAmount: array[6] of Decimal;
        TotalFooterAmountText: array[6] of Text[50];
        CustomerNo: Code[20];
        CustomerName: Text[50];
        CustomerAddress: Text[240];
        TotalDepositFooterAmountText: array[6] of Text[50];
        TotalDepositFooterAmount: array[6] of Decimal;
        DisplayTitleHeaderType: Option Confirmation,Proforma;
        DocumentTitleText: Text[30];
        Text52004: Label 'Order Confirmation %1';
        Text52005: TextConst ENU = 'Subtotal %1 Excl. VAT', FRA = 'Sous-Total %1 Excl. TVA';
        Text52005B: TextConst ENU = 'Subtotal %1 Incl. VAT', FRA = 'Sous-Total %1 Incl. TVA';
        Text52006: TextConst ENU = 'CREDIT MEMO', FRA = 'AVOIR';
        TaxAmout: Decimal;
        VATAmount: Decimal;
        Text57000: TextConst ENU = 'CREDIT MEMO %1', FRA = 'AVOIR %1';
        Text57001: TextConst ENU = 'CREDIT MEMO EMPTIES %1', FRA = 'AVOIR EMBALLAGE %1';
        Text57002: TextConst ENU = 'Tax Charges TIC', FRA = 'Frais Taxes TIC';
        Text57003: TextConst ENU = 'Disc. Charges', FRA = 'Frais Remises';
        Text57004: TextConst ENU = 'Desposit Charges (+)', FRA = 'Frais consigne (+)';
        Text57005: TextConst ENU = 'Deposit Charges (-)', FRA = 'Frais Consigne (-)';
        Text57006: TextConst ENU = 'Transport Charges', FRA = 'Montant Transport';
        DepAmountP: Decimal;
        DepAmountN: Decimal;
        ShipAmount: Decimal;
        LineDisAmount: Decimal;
        InvDisAmount: Decimal;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        ShowForcePrintNoDeposit: Boolean;
        SplitNo: Integer;
        RequestPageUsed: Boolean;
        BussinessReg: Text;
        TaxableItem: Code[20];
        NIS: Text;
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        CustomerAttributes: Record "Customer Attributes FND";
        Reprintedlbl: Label 'REPRINTED';
        ReprintedText: Text;
        RPMType: Code[20];
        PrintPerRPMType: Boolean;
        FreeReasonDesc: Text[50];
        // FreeReasonCode: Record "Free Reason Code";// BC Upgrade KUMARS145 commneted as Record was dependent on Drinkit.
        TotalDeposits: Decimal;
        TotalReturnedDeposits: Decimal;
        NNC_TotalLineAmount: Decimal;
        LineQtyinHL: Decimal;
        LineTaxAmount: Decimal;
        LineDiscAmount: Decimal;
        UnitPriceCalculated: Decimal;
        TotalLineAmount: Decimal;
        TotalOtherCharges: Decimal;
        PriceUOM: Code[10];
        VolumeUOM: Code[10];
        InventorySetup: Record "Inventory Setup";
        UnitOfMeasure: Record "Unit of Measure";
        BillToAddr: array[8] of Text[50];
        SellToAddr: array[8] of Text[50];
        Cust: Record Customer;
        ShipmentMethod: Record "Shipment Method";
        NNC_TotalAmountInclVat: Decimal;
        NNC_TotalInvDiscAmount: Decimal;
        NNC_TotalAmount: Decimal;
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        PostedReceiptDate: Date;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        Text011: Label 'Sales - Prepmt. Credit Memo %1';
        Text005: Label 'Sales - Credit Memo %1';
        ShowInternalInfo: Boolean;
        LogInteraction: Boolean;
        TempCommentLine: Record "Comment Line" temporary;
        CommentLineNo: Integer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        ItemsInvoice: Boolean;
        HeaderAddr: array[8] of Text[50];
        TempMarketingText: Record "Extended Text Line" temporary;
        CommentLine: Record "Comment Line";
        SalesCommentLine: Record "Sales Comment Line";
        DisplayMarketingBlock: Boolean;
        PrintUnderLineCharge: Boolean;
        TempUnderChargeLine: Record "Sales Cr.Memo Line" temporary;
        TempOrderTaxCharge: Record "Sales Cr.Memo Line" temporary;
        PrintOrderTaxes: Boolean;
        TotalTaxes: Decimal;
        TextFooter: array[3] of Text;
        CurrCode: Code[10];
        TempEmptyGoodItemLine: Record "Sales Cr.Memo Line" temporary;
        PrintEmptyGoodsStatement: Boolean;
        LineNo: Integer;
        PrintLoyaltyStatement: Boolean;
        TempCustomer: Record Customer temporary;
        // TempLoyaltyBuffer: Record "Loyalty Balance Buffer";// BC Upgrade KUMARS145 commneted as Record was dependent on Drinkit.
        BeginningBalance: Decimal;
        EndBalance: Decimal;
        Gains: Decimal;
        Sales: Decimal;
        TotalDiscounts: Decimal;
        PrintOrderDiscounts: Boolean;
        TempOrderDiscountCharge: Record "Sales Cr.Memo Line" temporary;
        PrintOrderDeposits: Boolean;
        TempOrderDepositCharge: Record "Sales Cr.Memo Line" temporary;
        MoreLines: Boolean;
        TotalSubTotal: Decimal;
        QtyHL: Decimal;
        CrossRefText: Text;
        ExpirationDate: Date;
        Text008: Label '"EAN: "';
        Text009: Label '"Your Reference: "';
        FreeReasonText: Text;
        PrintPrice: Boolean;
        SubTotal: Decimal;
        PrintLanguage: Code[10];

    procedure DocumentCaption2(): Text[250];
    begin
        exit(Text52006);
    end;

    procedure FindPostedShipmentDate(): Date;
    var
        ReturnReceiptHeader: Record "Return Receipt Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        if "Sales Cr.Memo Line"."Return Receipt No." <> '' then
            if ReturnReceiptHeader.GET("Sales Cr.Memo Line"."Return Receipt No.") then
                exit(ReturnReceiptHeader."Posting Date");
        if "Sales Cr.Memo Header"."Return Order No." = '' then
            exit("Sales Cr.Memo Header"."Posting Date");

        case "Sales Cr.Memo Line".Type of
            "Sales Cr.Memo Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Cr.Memo Line");
            "Sales Cr.Memo Line".Type::"G/L Account", "Sales Cr.Memo Line".Type::Resource,
          "Sales Cr.Memo Line".Type::"Charge (Item)", "Sales Cr.Memo Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Cr.Memo Line");
            "Sales Cr.Memo Line".Type::" ":
                exit(0D);
        end;

        SalesShipmentBuffer.RESET();
        SalesShipmentBuffer.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", "Sales Cr.Memo Line"."Line No.");

        if SalesShipmentBuffer.FIND('-') then begin
            SalesShipmentBuffer2 := SalesShipmentBuffer;
            if SalesShipmentBuffer.NEXT() = 0 then begin
                SalesShipmentBuffer.GET(
                  SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.DELETE();
                exit(SalesShipmentBuffer2."Posting Date");
            end;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            if SalesShipmentBuffer.Quantity <> "Sales Cr.Memo Line".Quantity then begin
                SalesShipmentBuffer.DELETEALL();
                exit("Sales Cr.Memo Header"."Posting Date");
            end;
        end else
            exit("Sales Cr.Memo Header"."Posting Date");
    end;

    procedure GenerateBufferFromValueEntry(SalesCrMemoLine2: Record "Sales Cr.Memo Line");
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesCrMemoLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesCrMemoLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Cr.Memo Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        if ValueEntry.FIND('-') then
            repeat
                if ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") then begin
                    if SalesCrMemoLine2."Qty. per Unit of Measure" <> 0 then
                        Quantity := ValueEntry."Invoiced Quantity" / SalesCrMemoLine2."Qty. per Unit of Measure"
                    else
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesCrMemoLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity - ValueEntry."Invoiced Quantity";
                end;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            until (ValueEntry.NEXT() = 0) or (TotalQuantity = 0);
    end;

    procedure GenerateBufferFromShipment(SalesCrMemoLine: Record "Sales Cr.Memo Line");
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
        ReturnReceiptHeader: Record "Return Receipt Header";
        ReturnReceiptLine: Record "Return Receipt Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesCrMemoHeader.SETCURRENTKEY("Return Order No.");
        SalesCrMemoHeader.SETFILTER("No.", '..%1', "Sales Cr.Memo Header"."No.");
        SalesCrMemoHeader.SETRANGE("Return Order No.", "Sales Cr.Memo Header"."Return Order No.");
        if SalesCrMemoHeader.FIND('-') then
            repeat
                SalesCrMemoLine2.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                SalesCrMemoLine2.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
                SalesCrMemoLine2.SETRANGE(Type, SalesCrMemoLine.Type);
                SalesCrMemoLine2.SETRANGE("No.", SalesCrMemoLine."No.");
                SalesCrMemoLine2.SETRANGE("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
                if SalesCrMemoLine2.FIND('-') then
                    repeat
                        TotalQuantity := TotalQuantity + SalesCrMemoLine2.Quantity;
                    until SalesCrMemoLine2.NEXT() = 0;
            until SalesCrMemoHeader.NEXT() = 0;

        ReturnReceiptLine.SETCURRENTKEY("Return Order No.", "Return Order Line No.");
        ReturnReceiptLine.SETRANGE("Return Order No.", "Sales Cr.Memo Header"."Return Order No.");
        ReturnReceiptLine.SETRANGE("Return Order Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SETRANGE(Type, SalesCrMemoLine.Type);
        ReturnReceiptLine.SETRANGE("No.", SalesCrMemoLine."No.");
        ReturnReceiptLine.SETRANGE("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
        ReturnReceiptLine.SETFILTER(Quantity, '<>%1', 0);

        if ReturnReceiptLine.FIND('-') then
            repeat
                if "Sales Cr.Memo Header"."Get Return Receipt Used" then
                    CorrectShipment(ReturnReceiptLine);
                if ABS(ReturnReceiptLine.Quantity) <= ABS(TotalQuantity - SalesCrMemoLine.Quantity) then
                    TotalQuantity := TotalQuantity - ReturnReceiptLine.Quantity
                else begin
                    if ABS(ReturnReceiptLine.Quantity) > ABS(TotalQuantity) then
                        ReturnReceiptLine.Quantity := TotalQuantity;
                    Quantity :=
                      ReturnReceiptLine.Quantity - (TotalQuantity - SalesCrMemoLine.Quantity);

                    SalesCrMemoLine.Quantity := SalesCrMemoLine.Quantity - Quantity;
                    TotalQuantity := TotalQuantity - ReturnReceiptLine.Quantity;

                    if ReturnReceiptHeader.GET(ReturnReceiptLine."Document No.") then
                        AddBufferEntry(
                          SalesCrMemoLine,
                          -Quantity,
                          ReturnReceiptHeader."Posting Date");
                end;
            until (ReturnReceiptLine.NEXT() = 0) or (TotalQuantity = 0);
    end;

    procedure AddBufferEntry(SalesCrMemoLine: Record "Sales Cr.Memo Line"; QtyOnShipment: Decimal; PostingDate: Date);
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        if SalesShipmentBuffer.FIND('-') then begin
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity - QtyOnShipment;
            SalesShipmentBuffer.MODIFY();
            exit;
        end;

        SalesShipmentBuffer.INIT();
        SalesShipmentBuffer."Document No." := SalesCrMemoLine."Document No.";
        SalesShipmentBuffer."Line No." := SalesCrMemoLine."Line No.";
        SalesShipmentBuffer."Entry No." := NextEntryNo;
        SalesShipmentBuffer.Type := SalesCrMemoLine.Type;
        SalesShipmentBuffer."No." := SalesCrMemoLine."No.";
        SalesShipmentBuffer.Quantity := -QtyOnShipment;
        SalesShipmentBuffer."Posting Date" := PostingDate;
        SalesShipmentBuffer.INSERT();
        NextEntryNo := NextEntryNo + 1
    end;

    procedure CorrectShipment(var ReturnReceiptLine: Record "Return Receipt Line");
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        SalesCrMemoLine.SETCURRENTKEY("Return Receipt No.", "Return Receipt Line No.");
        SalesCrMemoLine.SETRANGE("Return Receipt No.", ReturnReceiptLine."Document No.");
        SalesCrMemoLine.SETRANGE("Return Receipt Line No.", ReturnReceiptLine."Line No.");
        if SalesCrMemoLine.FIND('-') then
            repeat
                ReturnReceiptLine.Quantity := ReturnReceiptLine.Quantity - SalesCrMemoLine.Quantity;
            until SalesCrMemoLine.NEXT() = 0;
    end;

    local procedure DocumentCaption(): Text[250];
    begin
        if "Sales Cr.Memo Header"."Prepayment Credit Memo" then
            exit(Text011);
        exit(Text005);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
    end;

    procedure InsertCommentLine(Comment: Text);
    begin
        TempCommentLine.INIT();
        TempCommentLine."Line No." := CommentLineNo;
        TempCommentLine.Comment := Comment;
        TempCommentLine.INSERT();
        CommentLineNo += 10000;
    end;

    local procedure GetCrossReferences() CrossRef: Text;
    var
        // BC Upgrade KUMARS145 Replaced to new Record......>>
        // ItemCrossReference: Record "Item Cross Reference";
        ItemCrossReference: Record "Item Reference";
    // BC Upgrade KUMARS145 Replaced to new Record......<<
    begin
        ItemCrossReference.RESET();
        ItemCrossReference.SETRANGE("Item No.", "Sales Cr.Memo Line"."No.");
        ItemCrossReference.SETRANGE("Reference Type", ItemCrossReference."Reference Type"::"Bar Code");
        if ItemCrossReference.FINDFIRST() then
            CrossRef := Text008 + ItemCrossReference."Reference No.";
        ItemCrossReference.RESET();
        ItemCrossReference.SETRANGE("Item No.", "Sales Cr.Memo Line"."No.");
        ItemCrossReference.SETRANGE("Reference Type", ItemCrossReference."Reference Type"::Customer);
        ItemCrossReference.SETRANGE("Reference Type No.", "Sales Cr.Memo Line"."Sell-to Customer No.");
        if ItemCrossReference.FINDFIRST() then //begin
            if (CrossRef = '') then
                CrossRef := Text009 + ItemCrossReference."Reference No."
            else
                CrossRef += ' / ' + Text009 + ItemCrossReference."Reference No.";
        // end;
    end;

    local procedure IsEmptyGoodItem(): Boolean;
    begin
        if ("Sales Cr.Memo Line".Type <> "Sales Cr.Memo Line".Type::Item) or (("Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::Item) and ("Sales Cr.Memo Line"."No." = '')) then
            exit
        else begin
            // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.....>>
            // Item.GET("Sales Cr.Memo Line"."No.");
            // Item.CALCFIELDS("Empty Good");
            // exit(Item."Empty Good");
            // BC Upgrade KUMARS145 commneted as code was dependent on Drinkit Field.......<<
        end;
    end;

    local procedure GetLanguageID(PrintLanguagePar: Code[10]): Integer
    var
        LanguageRecLocal: Record Language;
    begin
        if LanguageRecLocal.Get(PrintLanguagePar) then
            exit(LanguageRecLocal."Windows Language ID");
        exit(0);
    end;
}

