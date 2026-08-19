report 53077 "Sales Invoice - Base"
{
    // version HEI.03

    // HEI:INC0259274:1:1 28/07/16 IBM.AV
    //   #Code Corrections to fix issues reported in INC0259274.
    // HEI:CHG0153013:1:1 14/12/16 IBM.AV
    //   #Code correction to include Fixed asset totalling in filter.
    // 
    // HEI:CHG0187935:1:1 24/08/17 IBM.SP
    //    # Code Correction against INC0523786.
    // 
    // HEI.01 FDD-GAPLOG006 IBM ISYED01 29.09.2017 # Algerai Local
    //   # Imported  from HEI2.0 and added Reprint to Fotter
    //   # requested by the business to add zeros to the sales lines with no unit Price as it is a legal requirement here in Algeria
    // 
    // HEI.02 Bugfixing IBM NASTAA02 20.11.2017 # Local Algeria
    //   # Used fields "Registre de Commerce","Article d'imposition","N.I.S." from Customer Attributes table
    //   # Replaced Responsibility Center Information with Company Information
    //   # Replaced CustAddr with data from Customer
    //   # Layout improvements
    // 
    // FCE 01  08.12.2017   Added Print Language from the start
    // FCE02   12.01.2018   Removed the Requestpage when printing the Empties
    // 
    // HEI.03 Bugfixing IBM NASTAA02 21.02.2018 # Local Algeria
    //   # Changed Layout to print the correct Header
    // HEI.04 Bugfixing IBM NASTAA02 23.02.2018 # Local Algeria
    //   # Used "Tax Registration" instead of "N.I.S." for Customer NIS
    //   # Added Company NIS: "Tax Registration" and Company NRC: "Industrtial Classification"
    //   # Adjusted code to print multiple empty invoices
    //   # Initialized VATAmount and TaxAmount

    // BC Upgrade KUMARS145 Nav ID Report 50040 "Sales Invoice - Base"

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Sales Invoice - Base.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(SalesHDocNo; "Sales Invoice Header"."No.") { }
            column(Customer_NRC; CustomerAttributes."Registre de Commerce") { }
            column(Customer_NART; CustomerAttributes."Article d'imposition") { }
            column(Customer_NIF; Customer."VAT Registration No.") { }
            // BC Upgrade KUMARS145 Drinkit field commented......>>
            // column(Customer_NIS; Customer."Tax Registration No.") { }
            column(Customer_NIS; '') { }
            // BC Upgrade KUMARS145 Drinkit field commented......<<
            column(SalesInvoiceHeader_NoPrinted; "No. Printed") { }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(OutputNo; OutputNo) { }
                    column(OrderConfirmCopyCaption; DocumentTitleText) { }
                    column(SalesHCustNo; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SalesHPostDate; Format("Sales Invoice Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDueDate; Format("Sales Invoice Header"."Due Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
                    column(SalesHDocDate; Format("Sales Invoice Header"."Document Date", 0, 4)) { }
                    column(SalesHIncVAT; PriceIncVAT) { }
                    column(SalesHSalesPerName; SalesPerson.Name) { }
                    column(SalesHOrdNo; "Sales Invoice Header"."Order No.") { }
                    column(SalesHReference; "Sales Invoice Header"."Your Reference") { }
                    column(SalesHExtRefNo; "Sales Invoice Header"."External Document No.") { }
                    column(SalesHVATRegNo; "Sales Invoice Header"."VAT Registration No.")
                    {
                        IncludeCaption = true;
                    }
                    column(PaymentTermDescrip; PaymentTerms.Description) { }
                    column(PayMethodDescrip; PaymentMethod.Description) { }
                    column(CompanyInfo_Picture; CompanyInfo.Picture) { }
                    column(CompanyInfo_Name; CompanyInfo.Name) { }
                    column(CompanyInfo_Name2; CompanyInfo."Name 2") { }
                    column(CompanyInfo_NIF; CompanyInfo."VAT Registration No.") { }
                    column(CompanyInfo_NART; CompanyInfo."Telex Answer Back") { }
                    // BC Upgrade KUMARS145 Drinkit field commented......>>
                    // column(CompanyInfo_NIS; CompanyInfo."Tax Registration No.") { }
                    column(CompanyInfo_NIS; '') { }
                    // BC Upgrade KUMARS145 Drinkit field commented......<<
                    column(CompanyInfo_NRC; CompanyInfo."Industrial Classification") { }
                    column(CompanyInfo_Address; CompanyInfo.Address)
                    {
                        IncludeCaption = true;
                    }
                    column(CompanyInfo_Address2; CompanyInfo."Address 2") { }
                    column(CompanyInfo_City; CompanyInfo.City) { }
                    column(CompanyInfo_Email; CompanyInfo."E-Mail") { }
                    column(Customer_Name; Customer.Name) { }
                    column(Customer_Name2; Customer."Name 2") { }
                    column(Customer_Address; Customer.Address) { }
                    column(Customer_City; Customer.City) { }
                    column(Customer_Country; Country.Name) { }
                    column(Customer_HouseNo; CustomerAttributes."House No. 1") { }
                    column(SubTotal; SubTotal)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(SubTotal1; Round(InvLineTotal, 0.01, '=')) { }
                    column(VATAmount; Round(VATAmount, 0.01, '=')) { }
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
                    column(AmountPaid; Round(AmttoPaid, 0.01, '=')) { }
                    column(InvTotalAmt; Round(InvTotalAmount, 0.01, '=')) { }
                    column(AmtLetter; AmountLetter) { }
                    column(Footertext; Footertext) { }
                    column(TotalSubTotal; TotalSubTotal)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(Text068; Text068) { }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(LineNo_SalesLine; "Line No.") { }
                        column(PrintPrice; PrintPrice) { }
                        column(UnitPrice_SalesLine; "Unit Price") { }
                        column(LineAmount_SalesLine; "Line Amount") { }
                        column(SalesLType; "Sales Invoice Line".Type) { }
                        column(Type_SalesLine; Format(Type, 0, 2)) { }
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
                        column(SalesPrice; Round("Sales Invoice Line"."Unit Price", 0.01, '=')) { }
                        column(SalesVATPer; "Sales Invoice Line"."VAT %")
                        {
                            IncludeCaption = true;
                        }
                        column(SalesDisAmt; "Sales Invoice Line"."Line Discount Amount") { }
                        column(SalesAmount; Round(("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price") - "Sales Invoice Line"."Line Discount Amount", 0.01, '=')) { }
                        column(TotalQuantity; TotalQty) { }

                        trigger OnAfterGetRecord();
                        var
                            // BC Upgrade KUMARS145 Depricated table "Item Cross Reference"......>>
                            // ItemCrossReference: Record "Item Cross Reference";
                            ItemCrossReference: Record "Item Reference";
                            // BC Upgrade KUMARS145 Depricated table "Item Cross Reference"......<<
                            ReservEntry: Record "Reservation Entry";
                            ItemLedgEntry: Record "Item Ledger Entry";
                            OrderChargeLine: Record "Sales Invoice Line";
                            SalesChargeLine: Record "Sales Invoice Line";
                        begin
                            NUMLines := NUMLines - 1;
                            LinesPrinted := LinesPrinted + 1;
                            if (Type = Type::"Charge (Item)") then
                                CurrReport.Skip();

                            // BC Upgrade KUMARS145 Drinkit field commeted......>>
                            // //-----Qty in HL
                            // Clear(QtyHL);
                            // if (Type = Type::Item) and ("No." <> '') then
                            //     QtyHL := Quantity * "Unit Volume HL";

                            // //-----Cross Reference Info
                            // Clear(CrossRefText);
                            // if Customer."Cross. Ref. on Del. Note" then begin
                            //     if (Type = Type::Item) and ("No." <> '') then
                            //         CrossRefText := GetCrossReferences();
                            // end;
                            // //-----Expiration Info
                            // Clear(ExpirationDate);
                            // if Customer."Exp. Date on Del. Note" then begin
                            //     ReservEntry.Reset();
                            //     ReservEntry.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
                            //     ReservEntry.SetRange("Source Type", 113);
                            //     ReservEntry.SetRange("Source Subtype", 1);
                            //     ReservEntry.SetRange("Source ID", "Document No.");
                            //     ReservEntry.SetRange("Source Ref. No.", "Line No.");
                            //     if ReservEntry.FINDFIRST then begin
                            //         ItemLedgEntry.Reset();
                            //         ItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");
                            //         ItemLedgEntry.SetRange("Item No.", ReservEntry."Item No.");
                            //         ItemLedgEntry.SetRange(Open, true);
                            //         ItemLedgEntry.SetRange("Variant Code", ReservEntry."Variant Code");
                            //         if ReservEntry."Lot No." <> '' then
                            //             ItemLedgEntry.SetRange("Lot No.", ReservEntry."Lot No.")
                            //         else
                            //             if ReservEntry."Serial No." <> '' then
                            //                 ItemLedgEntry.SetRange("Serial No.", ReservEntry."Serial No.");
                            //         ItemLedgEntry.SetRange(Positive, true);

                            //         if ItemLedgEntry.FINDLAST then
                            //             ExpirationDate := ItemLedgEntry."Expiration Date";
                            //     end;
                            // end;
                            // //-----Free Reason Text
                            // Clear(FreeReasonText);
                            // if "Free Reason Code" <> '' then begin
                            //     FreeReasonCode.Get("Free Reason Code");
                            //     FreeReasonText := FreeReasonCode.Description;
                            // end;
                            // //-----Price Info
                            // Clear(PrintPrice);
                            // if ItemsInvoice then
                            //     if (Type = Type::Item) and ("No." <> '') then begin
                            //         Item.Get("No.");
                            //         Item.CALCFIELDS("Empty Good");
                            //         PrintPrice := not (Item."Empty Good");
                            //     end;
                            // BC Upgrade KUMARS145 Drinkit field commeted......<<

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
                                SalesChargeLine.Reset();
                                SalesChargeLine.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                                SalesChargeLine.SetRange(Type, "Sales Invoice Line".Type::"Charge (Item)");
                                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<
                                // SalesChargeLine.SetRange("Item Charge Type", "Sales Invoice Line"."Item Charge Type"::Tax);
                                // SalesChargeLine.SetRange("Show Item charge on Invoice", SalesChargeLine."Show Item charge on Invoice"::"Include in item price");
                                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<
                                SalesChargeLine.SetRange("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                if SalesChargeLine.FindSet() then
                                    repeat
                                        "Sales Invoice Line"."Line Amount" += SalesChargeLine."Line Amount";
                                        SubTotal += SalesChargeLine."Line Amount";
                                        TotalSubTotal += SalesChargeLine."Line Amount";
                                    until SalesChargeLine.Next() = 0;
                                //Discounts to Grand Total + Total + Line Amount
                                SalesChargeLine.Reset();
                                SalesChargeLine.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                                SalesChargeLine.SetRange(Type, "Sales Invoice Line".Type::"Charge (Item)");
                                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                                // SalesChargeLine.SetRange("Item Charge Type", "Sales Invoice Line"."Item Charge Type"::Discount);
                                // SalesChargeLine.SetRange("Show Item charge on Invoice", SalesChargeLine."Show Item charge on Invoice"::"Include in item price");
                                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<
                                SalesChargeLine.SetRange("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                if SalesChargeLine.FindSet() then
                                    repeat
                                        "Sales Invoice Line"."Line Amount" += SalesChargeLine."Line Amount";
                                        SubTotal += SalesChargeLine."Line Amount";
                                        TotalSubTotal += SalesChargeLine."Line Amount";
                                    until SalesChargeLine.Next() = 0;
                                //Discounts under item line
                                Clear(PrintUnderLineCharge);
                                SalesChargeLine.Reset();
                                SalesChargeLine.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                                SalesChargeLine.SetRange(Type, "Sales Invoice Line".Type::"Charge (Item)");
                                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                                // SalesChargeLine.SetRange("Item Charge Type", "Sales Invoice Line"."Item Charge Type"::Discount);
                                // SalesChargeLine.SetRange("Show Item charge on Invoice", SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<
                                SalesChargeLine.SetRange("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                if SalesChargeLine.FindSet() then
                                    if not PrintUnderLineCharge then
                                        PrintUnderLineCharge := true;
                                repeat
                                /*TempUnderChargeLine.INIT;
                                TempUnderChargeLine := SalesChargeLine;
                                TempUnderChargeLine.INSERT;*/
                                until (SalesChargeLine.Next() = 0);
                                SalesChargeLine.CalcSums("Line Amount");
                                SubTotal += SalesChargeLine."Line Amount";
                                TotalSubTotal += SalesChargeLine."Line Amount";
                                //Tax under item line
                                SalesChargeLine.Reset();
                                SalesChargeLine.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                                SalesChargeLine.SetRange(Type, "Sales Invoice Line".Type::"Charge (Item)");
                                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                                // SalesChargeLine.SetRange("Item Charge Type", "Sales Invoice Line"."Item Charge Type"::Tax);
                                // SalesChargeLine.SetRange("Show Item charge on Invoice", SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<
                                SalesChargeLine.SetRange("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                if SalesChargeLine.FindSet() then
                                    repeat
                                        if (SalesChargeLine."Line Amount" <> 0) then begin
                                            if not PrintUnderLineCharge then
                                                PrintUnderLineCharge := true;
                                            /*TempUnderChargeLine.INIT;
                                            TempUnderChargeLine := SalesChargeLine;
                                            TempUnderChargeLine.INSERT;*/
                                        end;
                                    until (SalesChargeLine.Next() = 0);
                                SalesChargeLine.CalcSums("Line Amount");
                                SubTotal += SalesChargeLine."Line Amount";
                                TotalSubTotal += SalesChargeLine."Line Amount";

                                if ("Sales Invoice Line".Quantity <> 0) then
                                    "Sales Invoice Line"."Unit Price" := "Sales Invoice Line"."Line Amount" / "Sales Invoice Line".Quantity;
                            end;

                        end;

                        trigger OnPreDataItem();
                        begin
                            // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                            // if ShowSplittedDeposit then
                            //     SETFILTER("Item Charge Type", '<>%1', "Item Charge Type"::Deposit);
                            // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<

                            MoreLines := FindLast();

                            while MoreLines and (Description = '') and ("Description 2" = '') and
                                  ("No." = '') and (Quantity = 0) and
                                  (Amount = 0)
                            do
                                MoreLines := Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            SetRange("Line No.", 0, "Line No.");

                            TempEmptyGoodItemLine.Reset();
                            if TempEmptyGoodItemLine.FindLast() then
                                LineNo := TempEmptyGoodItemLine."Line No.";
                            TotalSubTotal := TotalDeposits + TotalDiscounts + TotalTaxes;
                        end;
                    }
                    // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                    // dataitem("Delayed Disc. & Promo. Line"; "Delayed Disc. & Promo. Line")
                    // {
                    //     DataItemTableView = sorting("Sequence No.");
                    //     column(DDPNo; "Delayed Disc. & Promo. Line"."No.") { }
                    //     column(DDPDescrip; "Delayed Disc. & Promo. Line".Description) { }
                    //     column(DDPCreateQty; "Delayed Disc. & Promo. Line"."Created Quantity") { }
                    //     column(DDPUOM; "Delayed Disc. & Promo. Line"."Unit of Measure Code") { }
                    //     column(DDPUnitPrice; "Delayed Disc. & Promo. Line"."Unit Price") { }
                    //     column(DDPLineDis; "Delayed Disc. & Promo. Line"."Line Discount %") { }
                    //     column(DDPVATPer; "Delayed Disc. & Promo. Line"."VAT %") { }
                    //     column(DDPCreatedLineDiscAmt; "Delayed Disc. & Promo. Line"."Created Line Discount Amount") { }
                    //     column(DDPCreateLineAmt; "Delayed Disc. & Promo. Line"."Created Line Amount") { }
                    //     dataitem(BlankLine; "Integer")
                    //     {
                    //         DataItemTableView = sorting(Number);
                    //         column(BlankLine; NUMLines)
                    //         {
                    //         }
                    //         trigger OnPreDataItem();
                    //         begin
                    //             SetRange(Number, 1, NUMLines)
                    //         end;
                    //     }
                    //     trigger OnPreDataItem();
                    //     begin
                    //         SetRange("Last Post. Document Type", "Last Post. Document Type"::"Sales Invoice");
                    //         SetRange("Last Post. Document No.", "Sales Invoice Header"."No.");
                    //         if IsEmpty then
                    //             CurrReport.Break();
                    //     end;
                    // }
                    // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<

                    trigger OnAfterGetRecord();
                    begin
                        Clear(TotalFooterAmount);
                        Clear(TotalFooterAmountText);
                        Clear(InvTotalAmount);
                        Clear(AmttoPaid);
                        Clear(ShipAmount);
                        Clear(DepAmountP);
                        Clear(DepAmountN);
                        Clear(ShipAmount);
                        Clear(InvDisAmount);
                        Clear(LineDisAmount);
                        Clear(InvLineTotal);
                        Clear(AmountLetter);

                        DocumentTitleText := StrSubstNo(DocumentCaption2(), CopyText);

                        SalesInvLineAmt.Reset();
                        SalesInvLineAmt.SetRange("Document No.", "Sales Invoice Header"."No.");
                        //>>HEI:CHG0153013:1:1 14/12/16 IBM.AV
                        //SalesInvLineAmt.SetRange(Type,SalesInvLineAmt.Type::Item); //commented
                        SalesInvLineAmt.SetRange(Type, SalesInvLineAmt.Type::Item, SalesInvLineAmt.Type::"Fixed Asset");   //added
                        //<<HEI:CHG0153013:1:1 14/12/16 IBM.AV
                        if SalesInvLineAmt.FindSet() then
                            repeat
                                InvLineTotal += SalesInvLineAmt."Line Amount" + SalesInvLineAmt."Line Discount Amount";
                            until SalesInvLineAmt.Next() = 0;

                        //<<HEI:CHG0187935:1:1 24/08/17 IBM.SP
                        SalesInvLineAmt.Reset();
                        SalesInvLineAmt.SetRange("Document No.", "Sales Invoice Header"."No.");
                        SalesInvLineAmt.SetRange(Type, SalesInvLineAmt.Type::"G/L Account");   //sP
                        if SalesInvLineAmt.FindSet() then
                            repeat
                                InvLineTotal += SalesInvLineAmt."Line Amount" + SalesInvLineAmt."Line Discount Amount";
                            until SalesInvLineAmt.Next() = 0;

                        //<<HEI:CHG0187935:1:1 24/08/17 IBM.SP

                        // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                        // SalesInvLine.Reset();
                        // SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                        // SalesInvLine.SetRange(Type, SalesInvLine.Type::"Charge (Item)");
                        // if ShowSplittedDeposit then
                        //     SalesInvLine.SetFilter("Item Charge Type", '<>%1', SalesInvLine."Item Charge Type"::Deposit);
                        // TaxAmout := 0; //HEI.04
                        // if SalesInvLine.FindSet() then
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
                        //                     // TotalFooterAmount[5] += SalesInvLine."Line Amount";        // Commented
                        //                     TotalFooterAmount[5] += ABS(SalesInvLine."Line Amount");        // Added
                        //                                                                                     //>>HEI:INC0259274:1:1 28/07/16 IBM.AV
                        //                     TotalFooterAmountText[5] := 'Invoice Discounts';
                        //                 end;
                        //         end;
                        //     until SalesInvLine.NEXT = 0;
                        // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<

                        TaxAmout := TotalFooterAmount[1];
                        DepAmountP := TotalFooterAmount[2];
                        DepAmountN := TotalFooterAmount[3];
                        ShipAmount := TotalFooterAmount[4];

                        SalesInvLine.Reset();
                        SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                        // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                        // if ShowSplittedDeposit then
                        //     SalesInvLine.SETFILTER("Item Charge Type", '<>%1', SalesInvLine."Item Charge Type"::Deposit);
                        // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<

                        if SalesInvLine.FindSet() then
                            repeat
                                TotalFooterAmount[5] += SalesInvLine."Inv. Discount Amount";
                                TotalFooterAmountText[5] := SalesInvLine.FieldCaption("Inv. Discount Amount");
                                TotalFooterAmount[6] += SalesInvLine."Line Discount Amount";
                                TotalFooterAmountText[6] := SalesInvLine.FieldCaption("Line Discount Amount");
                            until SalesInvLine.Next() = 0;

                        InvDisAmount := TotalFooterAmount[5];
                        LineDisAmount := TotalFooterAmount[6];

                        if ShowSplittedDeposit then
                            AmttoPaid := InvLineTotal + TaxAmout + ShipAmount - Abs(LineDisAmount)                           //>>HEI:INC0259274:1:1 28/07/16 IBM.AV Added ABS
                        else
                            AmttoPaid := InvLineTotal + TaxAmout + DepAmountP + ShipAmount - DepAmountN - Abs(LineDisAmount);    //>>HEI:INC0259274:1:1 28/07/16 IBM.AV Added ABS
                        //>>HEI:INC0259274:1:1 28/07/16 IBM.AV
                        //InvTotalAmount := AmttoPaid+VATAmount+InvDisAmount;       // Commented
                        InvTotalAmount := AmttoPaid + VATAmount - Abs(InvDisAmount);        // Added
                        //<<HEI:INC0259274:1:1 28/07/16 IBM.AV

                        //HEI.01>>
                        //MontantToutLettre."Montant en texte1"(AmountLetters,Round(InvTotalAmount,0.01,'=')); //old
                        if lang = 1033 then begin
                            RepCheck.InitTextVariable();
                            if "Sales Invoice Header"."Currency Code" = '' then
                                RepCheck.FormatNoText(AmountLetters, Round(InvTotalAmount, 0.01, '='), '')
                            else
                                RepCheck.FormatNoText(AmountLetters, InvTotalAmount, '');
                            AmountLetter := AmountLetters[1] + AmountLetters[2];
                        end
                        else if lang = 1036 then begin
                            if "Sales Invoice Header"."Currency Code" = '' then
                                MontantToutLettre."Montant en texte1"(AmountLetter, Round(InvTotalAmount, 0.01, '='))
                            else
                                MontantToutLettre."Montant en texte1"(AmountLetter, InvTotalAmount);
                        end;
                        //HEI.01<<
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        CopyText := Text52000;
                        CurrReport.PageNo := 1;
                        OutputNo := OutputNo + 1;

                        //HEI.01>>
                        Footertext := 'REPRINTED'
                        //HEI.01<<
                    end;
                end;

                trigger OnPostDataItem();
                begin
                    //HEI.01>>
                    if not CurrReport.Preview then
                        //HEI.01<<
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


                    //HEI.01>>
                    if "Sales Invoice Header"."No. Printed" > 0 then
                        Footertext := 'REPRINTED';
                    //HEI.01<<
                end;
            }

            trigger OnAfterGetRecord();
            var
                SalesInvoiceHeader: Record "Sales Invoice Header";
                ShipmentMethod: Record "Shipment Method";
                DeliveryTime1: Text;
                DeliveryTime2: Text;
                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                // StandardTextReport: Record "Standard Text Report";
                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
                CurrReportID: Integer;
                i: Integer;
                IsTextToInclude: Boolean;
                ItemLedgerEntry: Record "Item Ledger Entry";
                NoSeriesMgt: Codeunit "No. Series";//NoSeriesManagement;
                ModifyHeader: Boolean;
                SalesDepositLines: Record "Sales Invoice Line";
                DepositGroupCode: Code[10];
                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                // DrinkDepositGroup: Record "Drink Deposit Group";
                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<
                OrderChargeLine: Record "Sales Invoice Line";
                EmtpyGoodValueEntryNo: Integer;
                ValueEntry: Record "Value Entry";
                SalesInvLine2: Record "Sales Invoice Line";
                SalesInvLine3: Record "Sales Invoice Line";
                StartingShipmentdate: Date;
                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                // LoyaltyBalanceBuffer: Record "Loyalty Balance Buffer" temporary;
                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<
                BeginBalDate: Date;
                EndBalDate: Date;
                BeginningMonth: Date;
                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                // LoyaltyLedgerEntry: Record "Loyalty Ledger Entry";
                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<
                SalesInvoiceLine: Record "Sales Invoice Line";
            begin
                if CustomerAttributes.Get("Bill-to Customer No.") then; //HEI.02

                //HEI.01>>
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code"); //old
                // FCE01-
                //lang := Language.GetLanguageID(Format(GLOBALLANGUAGE));
                //CurrReport.LANGUAGE := lang;
                //GLOBALLANGUAGE(lang);
                // FCE01+
                //HEI.01<<
                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                end;

                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");

                if PaymentMethod.Get("Sales Invoice Header"."Payment Method Code") then;

                if PaymentTerms.Get("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Invoice Header"."Language Code");

                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalExText := StrSubstNo(Text52001, GLSetup."LCY Code");
                    TotalInText := StrSubstNo(Text52002, GLSetup."LCY Code");
                    SubTotalInText := StrSubstNo(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := StrSubstNo(Text52005, GLSetup."LCY Code");
                end else begin
                    TotalExText := StrSubstNo(Text52001, "Currency Code");
                    TotalInText := StrSubstNo(Text52002, "Currency Code");
                    SubTotalInText := StrSubstNo(Text52005B, GLSetup."LCY Code");
                    SubTotalExText := StrSubstNo(Text52005, GLSetup."LCY Code");
                end;

                VatAmt := 0; //HEI.04
                VATEntry.Reset();
                VATEntry.SetRange(Type, VATEntry.Type::Sale);
                VATEntry.SetRange("Document Type", VATEntry."Document Type"::Invoice);
                VATEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
                if VATEntry.FindSet() then
                    repeat
                        VatAmt += VATEntry.Amount;
                    until VATEntry.Next() = 0;
                VATAmount := -VatAmt;

                SalesInvLine.Reset();
                SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvLine.SetFilter("VAT %", '<>%1', 0);
                if SalesInvLine.FindFirst() then
                    VATPer := SalesInvLine."VAT %";

                if Customer.Get("Bill-to Customer No.") then
                    if Country.Get(Customer."Country/Region Code") then; //HEI.02

                if ShowSplittedDeposit then begin
                    SalesInvLine.Reset();
                    SalesInvLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                    // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                    // SalesInvLine.SETFILTER("Item Charge Type", '<>%1', SalesInvLine."Item Charge Type"::Deposit);
                    // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                    SalesInvLine.SetFilter(Amount, '<>%1', 0);
                    if not SalesInvLine.FindFirst() then begin
                        ReportEmpties.GetVars("Sales Invoice Header"."No.", NoOfCopies);
                        if not RequestPageUsed then
                            ReportEmpties.UseRequestPage(false);
                        ReportEmpties.RunModal();
                        CurrReport.Quit();
                    end;
                end;


                //-----Company Info
                CompanyInfo.Get();
                //Picture
                CompanyInfo.CalcFields(Picture);
                //Company Text
                /*Clear(CompanyText);
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
                ReportTitle := Text002;*/

                //-----Item Invoice
                SalesInvLine2.Reset();
                SalesInvLine2.SetRange("Document No.", "No.");
                SalesInvLine2.SetRange(Type, SalesInvLine2.Type::Item);
                if not SalesInvLine2.IsEmpty then ItemsInvoice := true;
                /*
                //-----Shipment Address
                IF ("Bill-to Country/Region Code" = CompanyInfo."Country/Region Code") THEN BEGIN
                  SalesInvoiceHeader.COPY("Sales Invoice Header");
                  SalesInvoiceHeader."Bill-to Country/Region Code" := '';
                  FormatAddr.SalesInvBillTo(HeaderAddr,SalesInvoiceHeader);
                END ELSE
                  FormatAddr.SalesInvBillTo(HeaderAddr,"Sales Invoice Header");
                
                //Shipment Text
                Clear(PrintShipmentText);
                  PrintShipmentText := ("Bill-to Name" <> "Ship-to Name") OR
                                       ("Bill-to Name 2" <> "Ship-to Name 2") OR
                                       ("Bill-to Address" <> "Ship-to Address") OR
                                       ("Bill-to Address 2" <> "Ship-to Address 2") OR
                                       ("Bill-to Post Code" <> "Ship-to Post Code") OR
                                       ("Bill-to City" <> "Ship-to City");
                                       */
                //-----Header Tel. & Fax
                Customer.Reset();
                Customer.Get("Sell-to Customer No.");
                /*
                //-----Driver Info
                IF ("Driver Code" <> '') THEN BEGIN
                  Driver.Reset();
                  Driver.Get("Driver Code");
                END;
                
                //-----SalesPerson Info
                IF ("Salesperson Code" <> '') THEN BEGIN
                  SalesPerson.Reset();
                  SalesPerson.Get("Salesperson Code");
                END;
                */
                //-----Comment Lines
                TempCommentLine.Reset();
                TempCommentLine.DeleteAll();
                ;
                CommentLineNo := 10000;
                //Customer Comments
                CommentLine.Reset();
                CommentLine.SetRange("Table Name", CommentLine."Table Name"::Customer);
                CommentLine.SetRange("No.", "Sell-to Customer No.");
                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                // CommentLine.SetRange("Print on Invoice", true);
                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<

                if CommentLine.FindSet() then
                    repeat
                        InsertCommentLine(CommentLine.Comment);
                    until CommentLine.Next() = 0;
                //Sales Comments
                SalesCommentLine.Reset();
                SalesCommentLine.SetRange("Document Type", SalesCommentLine."Document Type"::"Posted Invoice");
                SalesCommentLine.SetRange("No.", "No.");
                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......>>
                // SalesCommentLine.SetRange("Print on Invoice", true);
                // BC Upgrade KUMARS145 dependent on Drinkit field commeted......<<
                if SalesCommentLine.FindSet() then
                    repeat
                        InsertCommentLine(SalesCommentLine.Comment);
                    until SalesCommentLine.Next() = 0;

                //-----Marketing Texts
                Clear(CurrReportID);
                Clear(i);

                Clear(DisplayMarketingBlock);
                Evaluate(CurrReportID, CopyStr(CurrReport.ObjectId(false), 8));
                // BC Upgrade KUMARS145 dependent on Drinkit Table commeted......>>
                // StandardTextReport.Reset();
                // TempMarketingText.DELETEALL;
                // StandardTextReport.SetRange("Report ID", CurrReportID);
                // StandardTextReport.SetRange("Position Text", StandardTextReport."Position Text"::Line);
                // if StandardTextReport.FINDFIRST then begin
                //     ExtendedTextHeader.Reset();
                //     ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                //     ExtendedTextHeader.SetRange("No.", StandardTextReport."Standard Text Code");
                //     if ExtendedTextHeader.FINDSET then
                //         repeat
                //             IsTextToInclude := true;
                //             if (ExtendedTextHeader."Starting Date" <> 0D) then
                //                 IsTextToInclude := (ExtendedTextHeader."Starting Date" <= "Document Date");
                //             if IsTextToInclude and (ExtendedTextHeader."Ending Date" <> 0D) then
                //                 IsTextToInclude := (ExtendedTextHeader."Ending Date" >= "Document Date");
                //             if IsTextToInclude then begin
                //                 ExtendedTextLine.Reset();
                //                 ExtendedTextLine.SetRange("Table Name", ExtendedTextHeader."Table Name");
                //                 ExtendedTextLine.SetRange("No.", ExtendedTextHeader."No.");
                //                 ExtendedTextLine.SetRange("Text No.", ExtendedTextHeader."Text No.");
                //                 ExtendedTextLine.SetRange("Language Code", "Language Code");
                //                 if ExtendedTextHeader."All Language Codes" then
                //                     ExtendedTextLine.SetRange("Language Code", ExtendedTextHeader."Language Code");
                //                 if ExtendedTextLine.FINDFIRST then begin
                //                     DisplayMarketingBlock := true;
                //                     repeat
                //                         TempMarketingText.INIT;
                //                         TempMarketingText := ExtendedTextLine;
                //                         TempMarketingText.INSERT;
                //                     until (ExtendedTextLine.NEXT = 0);
                //                 end;
                //             end;
                //         until ExtendedTextHeader.NEXT = 0;
                // end;
                // BC Upgrade KUMARS145 dependent on Drinkit Table commeted......<<

                //-----Footer Texts
                Clear(CurrReportID);
                Clear(i);
                Clear(TextFooter);
                EVALUATE(CurrReportID, COPYSTR(CurrReport.OBJECTID(false), 8));
                // BC Upgrade KUMARS145 dependent on Drinkit Table commeted......>>
                // StandardTextReport.SetRange("Report ID", CurrReportID);
                // StandardTextReport.SetRange("Position Text", StandardTextReport."Position Text"::Footer);
                // if StandardTextReport.FINDSET then
                //     repeat
                //         i := 1;
                //         ExtendedTextHeader.Reset();
                //         ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                //         ExtendedTextHeader.SetRange("No.", StandardTextReport."Standard Text Code");
                //         if ExtendedTextHeader.FINDSET then begin
                //             repeat
                //                 ExtendedTextLine.Reset();
                //                 ExtendedTextLine.SetRange("Table Name", ExtendedTextHeader."Table Name");
                //                 ExtendedTextLine.SetRange("No.", ExtendedTextHeader."No.");
                //                 ExtendedTextLine.SetRange("Text No.", ExtendedTextHeader."Text No.");
                //                 ExtendedTextLine.SetRange("Language Code", "Language Code");
                //                 if ExtendedTextHeader."All Language Codes" then
                //                     ExtendedTextLine.SetRange("Language Code", ExtendedTextHeader."Language Code");
                //                 if ExtendedTextLine.FINDSET then begin
                //                     repeat
                //                         TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                //                     until (ExtendedTextLine.NEXT = 0) or (i > ARRAYLEN(TextFooter));
                //                 end;
                //                 i += 1;
                //             until (ExtendedTextHeader.NEXT = 0);
                //         end;
                //     until (StandardTextReport.NEXT = 0);
                // BC Upgrade KUMARS145 dependent on Drinkit Table commeted......<<
                //-----Currency Code
                if ("Currency Code" <> '') then
                    CurrCode := "Currency Code"
                else begin
                    GLSetup.Get();
                    CurrCode := GLSetup."LCY Code";
                end;
                //-------VAT
                VATAmountLine.DeleteAll();
                SalesInvLine.CalcVATAmountLines("Sales Invoice Header", VATAmountLine);
                if ItemsInvoice then begin
                    //-----Empty Goods Block
                    TempEmptyGoodItemLine.Reset();
                    TempEmptyGoodItemLine.DeleteAll();
                    // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......>>
                    // if (Customer."Empty Goods Statement On" in [Customer."Empty Goods Statement On"::Invoice, Customer."Empty Goods Statement On"::"Invoice + Delivery Note"]) then begin
                    //     PrintEmptyGoodsStatement := true;
                    //     with SalesDepositLines do begin
                    //         SETRANGE("Document No.", "Sales Invoice Header"."No.");
                    //         SETRANGE(Type, Type::"Charge (Item)");
                    //         SETRANGE("Item Charge Type", "Item Charge Type"::Deposit);
                    //         SETFILTER("Empty Goods Item No.", '<>%1', '');
                    //         if FINDSET then begin
                    //             repeat
                    //                 TempEmptyGoodItemLine.Reset();
                    //                 TempEmptyGoodItemLine.SetRange("No.", "Empty Goods Item No.");
                    //                 if not TempEmptyGoodItemLine.FINDFIRST then begin
                    //                     LineNo += 10000;
                    //                     TempEmptyGoodItemLine.INIT;
                    //                     TempEmptyGoodItemLine."No." := "Empty Goods Item No.";
                    //                     if Item.Get("Empty Goods Item No.") then
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
                    //                     TempEmptyGoodItemLine.INSERT;
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
                    // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......<<
                    TempEmptyGoodItemLine.Reset();
                    if TempEmptyGoodItemLine.FindSet() then
                        repeat
                            EmtpyGoodValueEntryNo := 0;
                            ValueEntry.Reset();
                            ValueEntry.SetRange("Document No.", "Sales Invoice Header"."No.");
                            // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......>>
                            // ValueEntry.SetRange("Empty Goods Item No.", "No.");
                            // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......<<
                            if ValueEntry.FindLast() then
                                EmtpyGoodValueEntryNo := ValueEntry."Entry No.";

                            ValueEntry.Reset();
                            // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......>>
                            // ValueEntry.SETCURRENTKEY("Source Type", "Item Ledger Entry Source No.", "Empty Goods Item No.");
                            // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......<<
                            ValueEntry.SetRange("Source Type", ValueEntry."Source Type"::Customer);
                            ValueEntry.SetRange("Source No.", "Sales Invoice Header"."Bill-to Customer No.");
                            // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......>>
                            // ValueEntry.SetRange("Empty Goods Item No.", "No.");
                            // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......<<
                            ValueEntry.SETFILTER("Entry No.", '..%1', EmtpyGoodValueEntryNo);
                            ValueEntry.CALCSUMS("Valued Quantity");
                            TempEmptyGoodItemLine."Amount Including VAT" := ValueEntry."Valued Quantity";//Bal After
                            TempEmptyGoodItemLine.Amount := TempEmptyGoodItemLine."Amount Including VAT" + (TempEmptyGoodItemLine.Quantity - TempEmptyGoodItemLine."Quantity (Base)");//Bal Before
                            TempEmptyGoodItemLine."Line Amount" := TempEmptyGoodItemLine."Unit Price" * (TempEmptyGoodItemLine.Quantity - TempEmptyGoodItemLine."Quantity (Base)");//Deposit Value
                            TempEmptyGoodItemLine.MODIFY();
                        until TempEmptyGoodItemLine.Next() = 0;
                    Clear(PrintLoyaltyStatement);
                    TempCustomer.Reset();
                    TempCustomer.DeleteAll();
                    // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......>>
                    // if (Customer."Loyalty Statement On" in [Customer."Loyalty Statement On"::Invoice, Customer."Loyalty Statement On"::"Invoice + Delivery Note"]) then begin
                    //     PrintLoyaltyStatement := true;
                    //     SalesInvLine3.Reset();
                    //     SalesInvLine3.SETCURRENTKEY("Sell-to Customer No.", Type, "Document No.");
                    //     SalesInvLine3.SETFILTER("Sell-to Customer No.", '<>%1', '');
                    //     SalesInvLine3.SetRange("Document No.", "No.");
                    //     if SalesInvLine3.FINDSET then begin
                    //         repeat
                    //             SalesInvLine3.SetRange("Sell-to Customer No.", SalesInvLine3."Sell-to Customer No.");
                    //             TempCustomer.INIT;
                    //             TempCustomer."No." := SalesInvLine3."Sell-to Customer No.";
                    //             TempCustomer.INSERT;
                    //             SalesInvLine3.FINDLAST;
                    //             SalesInvLine3.SetRange("Sell-to Customer No.");
                    //         until (SalesInvLine3.NEXT = 0);
                    //     end;

                    //     //-----Loyalty Statement
                    //     if TempCustomer.FINDSET
                    //     then begin
                    //         TempLoyaltyBuffer.Reset();
                    //         TempLoyaltyBuffer.DELETEALL;
                    //         repeat
                    //             PrintLoyaltyStatement := true;
                    //             Clear(BeginningBalance);
                    //             Clear(EndBalance);
                    //             Clear(Gains);
                    //             Clear(Sales);
                    //             TempLoyaltyBuffer.INIT;
                    //             TempLoyaltyBuffer."Source No." := TempCustomer."No.";
                    //             LoyaltyBalanceBuffer.INIT;
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

                    //             LoyaltyLedgerEntry.Reset();
                    //             LoyaltyLedgerEntry.SETFILTER("Source Type", '%1', LoyaltyLedgerEntry."Source Type"::Customer);
                    //             LoyaltyLedgerEntry.SETFILTER("Source No.", TempCustomer."No.");
                    //             LoyaltyLedgerEntry.SETFILTER("Posting Date", '%1..%2', BeginningMonth, EndBalDate);
                    //             LoyaltyLedgerEntry.SetRange("Entry Type", LoyaltyLedgerEntry."Entry Type"::Sale);
                    //             LoyaltyLedgerEntry.SetRange("Loyalty Type", LoyaltyLedgerEntry."Loyalty Type"::Point);
                    //             LoyaltyLedgerEntry.CALCSUMS("Point Amount (Actual)");
                    //             TempLoyaltyBuffer."Balance (Points)" := LoyaltyLedgerEntry."Point Amount (Actual)";

                    //             LoyaltyLedgerEntry.SETFILTER("Entry Type", '<>%1', LoyaltyLedgerEntry."Entry Type"::Sale);
                    //             LoyaltyLedgerEntry.CALCSUMS("Point Amount (Actual)");
                    //             TempLoyaltyBuffer."Balance (Sales)" := LoyaltyLedgerEntry."Point Amount (Actual)";
                    //             TempLoyaltyBuffer.INSERT;
                    //         until (TempCustomer.NEXT = 0);
                    //     end;
                    // end;
                    // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......<<
                    Clear(TotalDeposits);
                    Clear(TotalDiscounts);
                    Clear(TotalTaxes);

                    //-----Order total /blank Discount Charges
                    OrderChargeLine.Reset();
                    OrderChargeLine.SetRange("Document No.", "No.");
                    OrderChargeLine.SetRange(Type, OrderChargeLine.Type::"Charge (Item)");
                    // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......>>
                    // OrderChargeLine.SetRange("Item Charge Type", OrderChargeLine."Item Charge Type"::Discount);
                    // OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" ");
                    // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......<<
                    if OrderChargeLine.FindSet() then begin
                        PrintOrderDiscounts := true;
                        repeat
                            TempOrderDiscountCharge.Init();
                            TempOrderDiscountCharge := OrderChargeLine;
                            TempOrderDiscountCharge.Insert();
                        until (OrderChargeLine.Next() = 0);
                        OrderChargeLine.CALCSUMS("Line Amount");
                        TotalDiscounts += OrderChargeLine."Line Amount";
                    end;
                    //-----Order total /blank Deposit Charges
                    OrderChargeLine.Reset();
                    OrderChargeLine.SetRange("Document No.", "No.");
                    OrderChargeLine.SetRange(Type, OrderChargeLine.Type::"Charge (Item)");
                    // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......>>
                    // OrderChargeLine.SetRange("Item Charge Type", OrderChargeLine."Item Charge Type"::Deposit);
                    // OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" ");
                    // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......<<
                    if OrderChargeLine.FindSet() then begin
                        PrintOrderDeposits := true;
                        repeat
                            TempOrderDepositCharge.Init();
                            TempOrderDepositCharge := OrderChargeLine;
                            TempOrderDepositCharge.Insert();
                        until (OrderChargeLine.Next() = 0);
                        OrderChargeLine.CALCSUMS("Line Amount");
                        TotalDeposits += OrderChargeLine."Line Amount";
                    end;
                    //-----Order total /blank Tax Charges
                    OrderChargeLine.Reset();
                    OrderChargeLine.SetRange("Document No.", "No.");
                    OrderChargeLine.SetRange(Type, OrderChargeLine.Type::"Charge (Item)");
                    // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......>>
                    // OrderChargeLine.SetRange("Item Charge Type", OrderChargeLine."Item Charge Type"::Tax);
                    // OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" ");
                    // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......<<
                    if OrderChargeLine.FindSet() then begin
                        repeat
                            if (OrderChargeLine."Line Amount" <> 0) then begin
                                PrintOrderTaxes := true;
                                TempOrderTaxCharge.Init();
                                TempOrderTaxCharge := OrderChargeLine;
                                TempOrderTaxCharge.Insert();
                            end;
                        until (OrderChargeLine.Next() = 0);
                        OrderChargeLine.CALCSUMS("Line Amount");
                        TotalTaxes += OrderChargeLine."Line Amount";
                    end;
                end;

                if ShowSplittedDeposit then begin
                    // BASE 03-
                    ReportEmpties.SetLanguage("Sales Invoice Header"."Language Code");
                    // BASE03+
                    //HEI.03<<
                    Clear(ReportEmpties);
                    SalesInvoiceLine.Reset();
                    SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                    // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......>>
                    // SalesInvoiceLine.SETFILTER("Item Charge Type", '%1', SalesInvoiceLine."Item Charge Type"::Deposit);
                    // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......<<
                    if SalesInvoiceLine.FindFirst() then begin
                        if NoString = '' then
                            NoString := "Sales Invoice Header"."No."
                        else
                            NoString += '|' + "Sales Invoice Header"."No.";
                    end;
                    //HEI.03>>
                end;

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
                    field(ShowSplittedDeposit; ShowSplittedDeposit)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Split Deposit / Empty Goods',
                                    FRA = 'Eclater Caution / Vidange';
                        ToolTipML = ENU = 'Select this option to print the empty goods invoice separately from the goods invoice. When this option is selected, the empty goods invoice will be printed immediately after the goods invoice.',
                                              FRA = 'Sélectionnez cette option pour imprimer la facture des vidanges séparément de la facture des marchandises. Lorsque cette option est sélectionnée, la facture des vidanges sera imprimée immédiatement après la facture des marchandises.';
                    }
                    field("No. of Copies"; NoOfCopies)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Number of Copies for Empty Goods Invoice',
                                    FRA = 'Nombre de copies pour la facture des vidanges';
                        ToolTipML = ENU = 'Enter the number of copies to be printed for the empty goods invoice. This field is only enabled when there are empty goods lines on the invoice and the Split Deposit / Empty Goods option is selected.',
                                              FRA = 'Entrez le nombre de copies à imprimer pour la facture des vidanges. Ce champ n''est activé que lorsqu''il y a des lignes de vidanges sur la facture et que l''option Eclater Caution / Vidange est sélectionnée.';
                    }
                    field(PrintLanguage; PrintLanguage)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Language';
                        TableRelation = Language;
                        ToolTip = 'Select the language in which the invoice will be printed. The available options are based on the languages that are set up in the system.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            ShowSplittedDeposit := true;
        end;

        trigger OnOpenPage();
        begin
            RequestPageUsed := true;
        end;
    }

    labels
    {
        label(lblPayTerms; ENU = 'Payment Terms', FRA = 'Conditions de réglement')
        label(lblPayMethod; ENU = 'Payment Method', FRA = 'Mode de réglement')
        label(lblAmtPaid; ENU = 'Total DA Excl. VAT', FRA = 'Total DA HT')
        label(lblSalesCondition; ENU = 'The Sale Conditions on the back side', FRA = 'Conditions generales de vento ou envers')
        lblTotalQty = 'Total Quantity';
        label(lblSalesPerson; ENU = 'Sales Person', FRA = 'Vendeur')
        label(lblUOM; ENU = 'Unit', FRA = 'Unité')
        label(lblUnitPrice; ENU = 'Unit Price', FRA = 'Prix Unité')
        label(lblSaleLAmt; ENU = 'Amount', FRA = 'Montant')
        label(lblPageNo; ENU = 'Page No.', FRA = 'Page')
        label(lblInvoiceNo; ENU = 'Invoice No.', FRA = 'N° de facture')
        label(lblVATAmt; ENU = 'VAT Amount', FRA = 'Montant TVA')
        label(lblPostDate; ENU = 'Date', FRA = 'Date')
        label(lblDiscAmt; ENU = 'Disc. Amount', FRA = 'Remise Montant')
        lblPriceIncVAT = 'Price Including VAT';
        label(lblRegNo; ENU = 'RC No. :', FRA = 'N° RC :')
        label(lblIfNo; ENU = 'I.F No. :', FRA = 'N° I.F :')
        label(lblArticleNo; ENU = 'Item No. :', FRA = 'N° ART :')
        label(lblNIS; ENU = 'N.I.S.', FRA = 'N.I.S.')
        label(lblPhone; ENU = 'Phone No. :', FRA = 'Téléphone :')
        label(lblFax; ENU = 'Fax No. :', FRA = 'N°  Télécopie :')
        label(lblAmtinWord; ENU = 'Amount in Words :', FRA = 'La présente facture est arrêtée à la somme de :')
        label(lblOrder; ENU = 'Sales Order No.', FRA = 'N° Commande')
    }

    trigger OnInitReport();
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        CompanyInfo.CALCFIELDS(Picture); //HEI.04
        SalesSetup.Get();
        ShowSplittedDeposit := true;
        // FCE01-
        PrintLanguage := CompanyInfo."Language Code FND";
        // FCE01+
    end;

    trigger OnPostReport();
    begin
        //HEI.04<<
        if NoString <> '' then begin
            SalesInvoiceHeader2.SETFILTER("No.", NoString);
            SalesInvoiceHeader2.FindSet();
            Clear(ReportEmpties);
            ReportEmpties.SETTABLEVIEW(SalesInvoiceHeader2);
            ReportEmpties.RUN();
        end;
        //HEI.04>>
    end;

    trigger OnPreReport();
    begin
        // FCE01-
        // CurrReport.LANGUAGE := LanguageRec.GetLanguageID(PrintLanguage);
        // FCE01+
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
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvLineAmt: Record "Sales Invoice Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        ReportEmpties: Report "Sales Invoice Empties Base";
        Check: Report Check;
        Currency: Record Currency;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        MontantToutLettre: Codeunit "Heicore_Funct CBN";
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
        Text52005B: Label 'Subtotal %1 Incl. VAT';
        Text52006: TextConst ENU = 'INVOICE %1', FRA = 'FACTURE %1';
        TaxAmout: Decimal;
        VATAmount: Decimal;
        DepAmountP: Decimal;
        DepAmountN: Decimal;
        ShipAmount: Decimal;
        LineDisAmount: Decimal;
        Text57000: TextConst ENU = 'INVOICE GOODS %1', FRA = 'FACTURE MARCHANDISES %1';
        Text57001: TextConst ENU = 'INVOICE EMPTIES %1', FRA = 'FACTURE EMBALLAGE %1';
        Text57002: TextConst ENU = 'Tax Charges TIC', FRA = 'Frais Taxes TIC';
        Text57003: TextConst ENU = 'Disc. Charges', FRA = 'Frais Remises';
        Text57004: TextConst ENU = 'Desposit Charges (+)', FRA = 'Frais consigne (+)';
        Text57005: TextConst ENU = 'Deposit Charges (-)', FRA = 'Frais Consigne (-)';
        Text57006: TextConst ENU = 'Transport Charges', FRA = 'Montant Transport';
        InvDisAmount: Decimal;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        ShowSplittedDeposit: Boolean;
        SplitNo: Integer;
        RequestPageUsed: Boolean;
        Footertext: Text;
        RepCheck: Report Check;
        AmountLetters: array[2] of Text[250];
        lang: Integer;
        CustomerAttributes: Record "Customer Attributes FND";
        Text008: Label '"EAN: "';
        Text009: Label '"Your Reference: "';
        TempCommentLine: Record "Comment Line" temporary;
        CommentLineNo: Integer;
        Item: Record Item;
        ItemsInvoice: Boolean;
        TempEmptyGoodItemLine: Record "Sales Invoice Line" temporary;
        PrintEmptyGoodsStatement: Boolean;
        LineNo: Integer;
        PrintLoyaltyStatement: Boolean;
        TempCustomer: Record Customer temporary;
        // BC Upgrade KUMARS145 dependent on Drinkit Table commeted......>>
        // TempLoyaltyBuffer: Record "Loyalty Balance Buffer" temporary;
        // BC Upgrade KUMARS145 dependent on Drinkit Table commeted......<<
        BeginningBalance: Decimal;
        EndBalance: Decimal;
        Gains: Decimal;
        Sales: Decimal;
        LineAmount: Decimal;
        TempOrderDepositCharge: Record "Sales Invoice Line" temporary;
        TotalSubTotal: Decimal;
        PrintOrderDiscounts: Boolean;
        PrintOrderDeposits: Boolean;
        VATAmountLine: Record "VAT Amount Line" temporary;
        PriceUOM: Code[10];
        InventorySetup: Record "Inventory Setup";
        UnitOfMeasure: Record "Unit of Measure";
        TotalDiscounts: Decimal;
        TotalDeposits: Decimal;
        Cust: Record Customer;
        DisplayMarketingBlock: Boolean;
        PrintUnderLineCharge: Boolean;
        TempUnderChargeLine: Record "Sales Invoice Line" temporary;
        TempOrderTaxCharge: Record "Sales Invoice Line" temporary;
        PrintOrderTaxes: Boolean;
        TotalTaxes: Decimal;
        TempOrderDiscountCharge: Record "Sales Invoice Line" temporary;
        TotalOrderDiscCharges: Decimal;
        SubTotal: Decimal;
        PrintPrice: Boolean;
        SalesInvLine2: Record "Sales Invoice Line";
        CommentLine: Record "Comment Line";
        SalesCommentLine: Record "Sales Comment Line";
        TempMarketingText: Record "Extended Text Line" temporary;
        TextFooter: array[3] of Text;
        CurrCode: Code[10];
        QtyHL: Decimal;
        CrossRefText: Text;
        ExpirationDate: Date;
        FreeReasonText: Text;
        // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......>>
        // FreeReasonCode: Record "Free Reason Code";
        // BC Upgrade KUMARS145 dependent on Drinkit Field commeted......<<
        MoreLines: Boolean;
        PrintLanguage: Code[10];
        NoString: Text[1024];
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        Text068: Label 'REPRINTED';

    procedure DocumentCaption2(): Text[250];
    begin
        if ShowSplittedDeposit then
            exit(Text57000)
        else
            exit(Text52006);
    end;

    procedure InsertCommentLine(Comment: Text);
    begin
        TempCommentLine.Init();
        TempCommentLine."Line No." := CommentLineNo;
        TempCommentLine.Comment := Comment;
        TempCommentLine.Insert();
        CommentLineNo += 10000;
    end;

    local procedure GetCrossReferences() CrossRef: Text;
    var
        ItemCrossReference: Record "Item Reference";
    begin
        //BC Upgrade KUMARS145 Changed the feilds from Item Cross Reference to Item Refrence's....>>
        ItemCrossReference.Reset();
        ItemCrossReference.SetRange("Item No.", "Sales Invoice Line"."No.");
        ItemCrossReference.SetRange(ItemCrossReference."Reference Type", ItemCrossReference."Reference Type"::"Bar Code");
        if ItemCrossReference.FindFirst() then
            CrossRef := Text008 + ItemCrossReference."Reference No.";
        ItemCrossReference.Reset();
        ItemCrossReference.SetRange("Item No.", "Sales Invoice Line"."No.");
        ItemCrossReference.SetRange("Reference Type", ItemCrossReference."Reference Type"::Customer);
        ItemCrossReference.SetRange("Reference Type No.", "Sales Invoice Line"."Sell-to Customer No.");
        if ItemCrossReference.FindFirst() then begin
            if (CrossRef = '') then
                CrossRef := Text009 + ItemCrossReference."Reference No."
            else
                CrossRef += ' / ' + Text009 + ItemCrossReference."Reference No.";
        end;
        //BC Upgrade KUMARS145 Changed the feilds from Item Cross Reference to Item Refrence's....<<
    end;

    local procedure IsEmptyGoodItem(): Boolean;
    begin
        if ("Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item) or (("Sales Invoice Line".Type = "Sales Invoice Line".Type::Item) and ("Sales Invoice Line"."No." = '')) then
            exit;
        //BC Upgrade KUMARS145 Depende on Drinkit Fields Commented....>>
        // Item.Get("Sales Invoice Line"."No.");
        // Item.CALCFIELDS("Empty Good");
        // exit(Item."Empty Good");
        //BC Upgrade KUMARS145 Depende on Drinkit Fields Commented....>>
    end;
}

