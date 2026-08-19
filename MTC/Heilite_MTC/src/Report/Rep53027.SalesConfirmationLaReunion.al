report 53027 "Sales Confirmation La Reunion"
{
    // version HEI.07

    // HEI.01 FDD-HT637 IBM NASTAA02 13.01.2020 # Invoice Cr Memo Proforma Inv LaReunion
    //   # New Report created using Report 50265 - Sales Invoice STD
    // HEI.02 Defect #5257 IBM NASTAA02 28.02.2020 # Print batch of invoices page numbers
    //   # Adjusted Page No on Report layout
    // HEI.03 Defect #5566 IBM NASTAA02  29.06.2020 # Invoice layout
    //   # 'Export Invoice' should not be used
    //   # Enlarged Payment Terms column
    // HEI.04 Defect #5657 IBM NASTAA02 30.07.2020 # Invoice Layout
    //   # Lines with Type = ' ' should not have a border line in between
    //   # Discount = 100 should be shown just when Discount % = 100
    // HEI.05 FDD-HT1633 IBM NASTAA02 20.08.2020 # Invoice Layout 2.0
    //   # Bill-to Customer Address changed:
    //     Customer Name = 'Legal Form' + 'Name' + 'Name 2' + 'Name 3'
    //     Customer Address = 'House No 1'+ 'House No Supplement (2)' + 'Address'
    //     Customer Address 2 = 'Address 2' + 'Street 3' + 'Street 4' + 'Street 5' + 'PO Box'
    //     Customer City = 'Post Code' + 'City' + 'Other City' + (Country/Region Code)
    //   # Sell-to Customer Address changed:
    //     Customer Name = 'Name' + 'Name 2' + 'Name 3'
    //     Customer Address = 'House No 1'+ 'House No Supplement (2)' + 'Address'
    //     Customer Address 2 = 'Address 2' + 'Street 3' + 'Street 4' + 'Street 5' + 'PO Box'
    //     Customer City = 'Post Code' + 'City' + 'Other City' + (Country/Region Code)
    // HEI.06 INC3044046 IBM NASTAA02 04.09.2020 # Invoices not printed correctly as PDF
    //   # Fixed layout. Deleted rectangle from the 'Total' tablix and setup 'KeepTogether' property on the tablix
    // HEI.07 CHG2192206 HB3312 IBM BHANDS01 10.07.2023 # Lareunion-Local billing documents update request
    //   # Added new variable SIREN Client for Bill-to Customer
    //   # Updated the report layout to adjust new changes
    // BC Upgrade BHARDA11 >>
    // 1. Add layout path and Change extension RDLC to RDL. 
    // 2. OLD Report ID- 50302.
    // 3. Remove Drink-IT Fields("Order No.", "Item Charge Type", "Show Item charge on Invoice", "ItemCharge Incl. Price", "Free Item")
    // 4. Comment Drink-IT Tables("Doc Subtype Code Setup FND", "Standard Text Report")
    // 5. Remove Drink-It Related Columns in Dataset and layout.
    // 6. ItemCrossReference is obsolete in BC.So We use "Item Reference".
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Sales Confirmation La Reunion.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.
    Caption = 'Sales Confirmation La Reunion';
    PaperSourceDefaultPage = TractorFeed;
    PaperSourceFirstPage = TractorFeed;
    PaperSourceLastPage = TractorFeed;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(SalesHeader_No; "No.")
            {
            }
            // BC Upgrade BHARAD11 >> --Drink-IT Table(StandardTextReport) . 
            // column(Header_Image; StandardTextReport.Image)
            // {
            // }
            // column(Footer_Image; StandardTextReport2.Image)
            // {
            // }
            column(Header_Image; '') // Because of Drink-IT field. Passed Blanked Here
            {
            }
            column(Footer_Image; '') // Because of Drink-IT field. Passed Blanked Here
            {
            }
            // BC Upgrade BHARAD11 << --Drink-IT Table(StandardTextReport) . 

            column(SellToCustomerText; SellToCustomerText)
            {
            }
            column(BillToCustomerText; BillToCustomerText)
            {
            }
            column(InvoiceNoLbl; InvoiceNoLbl)
            {
            }
            column(ShipmentNo; ShipmentNo)
            {
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Field("Order No.")
            // column(SalesHeader_OrderNo; "Order No.")
            // {
            // }
            column(SalesHeader_OrderNo; '') // Because of Drink-IT field. Passed Blanked Here
            {
            }
            // BC Upgrade BHARDA11 << ----Drink-IT Field("Order No.")
            column(SalesHeader_OrderDate; "Shipment Date")
            {
            }
            column(SalesHeader_ShipmentDate; "Posting Date")
            {
            }
            column(SalesHeader_DueDate; "Due Date")
            {
            }
            column(SalesHeader_SalesRoutes; Customer."Sales Routes FND")
            {
            }
            column(SalesHeader_LocationCode; "Location Code")
            {
            }
            column(SalesHeader_ExternalDocNo; "External Document No.")
            {
            }
            column(SalesHeader_PaymentTermsCode; PaymentTerms.Description)
            {
            }
            column(PaymentMethod_Description; PaymentMethod.Description)
            {
            }
            column(CompanyInfo_IBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanyInfo_SWIFTCode; CompanyInfo."SWIFT Code")
            {
            }
            column(SalesHDocNo; "Sales Header"."No.")
            {
            }
            column(SalesHeader_AmountInclVAT; "Amount Including VAT")
            {
            }
            column(BillToCustSIREN; SIRENClient)
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
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(SalesLine_No_Description; NoDescription)
                        {
                        }
                        column(SalesLine_OctroiGtin; OctroiGtin)
                        {
                        }
                        column(SalesLine_Quantity; Quantity)
                        {
                        }
                        column(SalesLine_TranslatedUoM; TranslatedUoM)
                        {
                        }
                        column(UnitPriceExclVAT; UnitPriceExclVAT)
                        {
                        }
                        column(LineDiscountExclVAT; LineDiscountExclVAT)
                        {
                        }
                        column(DroitDAccise; DroitDAccise)
                        {
                        }
                        column(EcoEmbPUHT; EcoEmbPUHT)
                        {
                        }
                        column(OMExoTVA; OMExoTVA)
                        {
                        }
                        column(MontantNetHT; MontantNetHT)
                        {
                        }
                        column(SalesLine_VATPercent; "VAT %")
                        {
                        }
                        column(ConsignesPU; ConsignesPU)
                        {
                        }
                        column(ConsignesMontant; ConsignesMontant)
                        {
                        }
                        column(SalesLine_LineAmount; "Line Amount")
                        {
                        }
                        column(SalesLine_Type; Type)
                        {
                        }

                        trigger OnAfterGetRecord();
                        var
                            // ItemCrossReference: Record "Item Cross Reference"; // BC Upgrade BHARDA11 ----"Item Cross Reference" is Obsolete in BC
                            ItemCrossReference: Record "Item Reference"; // BC Upgrade BHARDA11 --Use "Item Reference" in the Place of "Item Cross Reference".
                            UnitofMeasureTranslation: Record "Unit of Measure Translation";
                            ChargeInvoiceLine: Record "Sales Line";
                            ChargeInvoiceLine2: Record "Sales Line";
                            ItemChargesPrice: Decimal;
                            ItemChargesAmount: Decimal;
                            DiscountChargesAmount: Decimal;
                            LineDiscount: Decimal;
                            DroitDAcciseTxt: Text;
                            OtherTax: Boolean;
                        begin
                            //HEI.01>>
                            // BC Upgrade BHARAD11 >> --Drink-IT Field("Item Charge Type")
                            // if (("Item Charge Type" = "Item Charge Type"::Deposit) or
                            //    ("Item Charge Type" = "Item Charge Type"::Discount) or
                            //    ("Item Charge Type" = "Item Charge Type"::Tax)) and
                            //    ("Attached to Line No." <> 0)
                            // then
                            //     CurrReport.SKIP;
                            // BC Upgrade BHARAD11 << --Drink-IT Field("Item Charge Type")

                            //No + Description
                            if "No." = '' then
                                NoDescription := Description
                            else
                                NoDescription := "No." + ' |  ' + Description;

                            //Octroi Gtin
                            // BC Upgrade BHARDA11 >> ---- ItemCrossReference is obsolete in BC.So We use "Item Reference" here.
                            OctroiGtin := '';
                            if Type = Type::Item then begin
                                Item.GET("No.");
                                ItemCrossReference.RESET;
                                ItemCrossReference.SETRANGE("Item No.", "No.");
                                ItemCrossReference.SETRANGE("Unit of Measure", "Unit of Measure Code");
                                if ItemCrossReference.FINDFIRST then
                                    // OctroiGtin := ItemCrossReference."Cross-Reference No.";
                                    OctroiGtin := ItemCrossReference."Reference No."; // BC Upgrade BHARDA11 --Use "Refrence No." in the place of "Cross-Reference No.".

                                if OctroiGtin <> '' then
                                    OctroiGtin += ' | ' + Item."Tariff No."
                                else
                                    OctroiGtin := Item."Tariff No.";
                            end;
                            // BC Upgrade BHARDA11 << ---- ItemCrossReference is obsolete in BC So We use "Item Reference" here.

                            //UoM translation - Bill to Customer No.
                            UnitofMeasureTranslation.RESET;
                            TranslatedUoM := '';
                            UnitofMeasureTranslation.SETRANGE("Language Code", Customer."Language Code");
                            UnitofMeasureTranslation.SETRANGE(Code, "Unit of Measure Code");
                            if UnitofMeasureTranslation.FINDFIRST then
                                TranslatedUoM := UnitofMeasureTranslation.Description;

                            //PU HT Hors Droit
                            ChargeInvoiceLine.RESET;
                            ItemChargesPrice := 0;
                            //ItemChargesAmount := 0;

                            if Type = Type::Item then begin
                                ChargeInvoiceLine.SETRANGE("Document No.", "Document No.");
                                ChargeInvoiceLine.SETRANGE(Type, ChargeInvoiceLine.Type::"Charge (Item)");
                                ChargeInvoiceLine.SETRANGE("Attached to Line No.", "Line No.");
                                // ChargeInvoiceLine.SETRANGE("Item Charge Type", ChargeInvoiceLine."Item Charge Type"::Discount); // BC Upgrade BHARAD11 >> --Drink-IT Field("Item Charge Type")
                                //ChargeInvoiceLine.SETRANGE("Show Item charge on Invoice",ChargeInvoiceLine."Show Item charge on Invoice"::"Include in item price");
                                if ChargeInvoiceLine.FINDSET then
                                    repeat
                                        if (STRPOS(LOWERCASE(ChargeInvoiceLine.Description), 'octroi') = 0) or
                                           (STRPOS(LOWERCASE(ChargeInvoiceLine.Description), 'mer') = 0)
                                        then begin
                                            if ChargeInvoiceLine.Quantity < 0 then
                                                ItemChargesPrice += -ChargeInvoiceLine."Unit Price"
                                            else
                                                ItemChargesPrice += ChargeInvoiceLine."Unit Price";

                                            //ItemChargesAmount += ChargeInvoiceLine."Line Amount";
                                        end;
                                    until ChargeInvoiceLine.NEXT = 0;
                            end;

                            UnitPriceExclVAT := ItemChargesPrice + "Unit Price";

                            //Line Discount
                            LineDiscount := 0;
                            DiscountChargesAmount := 0;
                            LineDiscountExclVAT := 0;
                            ItemChargesAmount := 0;
                            ChargeInvoiceLine.RESET;

                            //1
                            if Type = Type::Item then begin
                                ChargeInvoiceLine.SETRANGE("Document No.", "Document No.");
                                ChargeInvoiceLine.SETRANGE(Type, ChargeInvoiceLine.Type::"Charge (Item)");
                                ChargeInvoiceLine.SETRANGE("Attached to Line No.", "Line No.");
                                // ChargeInvoiceLine.SETRANGE("Show Item charge on Invoice", ChargeInvoiceLine."Show Item charge on Invoice"::"Include in item price"); // BC Upgrade BHARAD11 >> --Drink-IT Field("Show Item charge on Invoice")
                                if ChargeInvoiceLine.FINDSET then
                                    repeat
                                        if (STRPOS(LOWERCASE(ChargeInvoiceLine2.Description), 'octroi') = 0) or
                                           (STRPOS(LOWERCASE(ChargeInvoiceLine2.Description), 'mer') = 0)
                                        then
                                            ItemChargesAmount += ChargeInvoiceLine."Line Amount";
                                    until ChargeInvoiceLine.NEXT = 0;
                            end;

                            //2
                            if Type = Type::Item then begin
                                ChargeInvoiceLine2.RESET;
                                ChargeInvoiceLine2.SETRANGE("Document No.", "Document No.");
                                ChargeInvoiceLine2.SETRANGE(Type, ChargeInvoiceLine2.Type::"Charge (Item)");
                                ChargeInvoiceLine2.SETRANGE("Attached to Line No.", "Line No.");
                                // BC Upgrade BHARDA11 >> ----Drnk-IT Fields("Show Item charge on Invoice","Item Charge Type")
                                // ChargeInvoiceLine2.SETFILTER("Show Item charge on Invoice", '<>%1', ChargeInvoiceLine2."Show Item charge on Invoice"::"Include in item price");
                                // ChargeInvoiceLine2.SETRANGE("Item Charge Type", ChargeInvoiceLine2."Item Charge Type"::Discount);
                                // BC Upgrade BHARDA11 << ----Drnk-IT Fields("Show Item charge on Invoice","Item Charge Type")
                                if ChargeInvoiceLine2.FINDSET then
                                    repeat
                                        if (STRPOS(LOWERCASE(ChargeInvoiceLine2.Description), 'octroi') = 0) or
                                           (STRPOS(LOWERCASE(ChargeInvoiceLine2.Description), 'mer') = 0)
                                        then
                                            DiscountChargesAmount += ChargeInvoiceLine2."Line Amount";
                                    until ChargeInvoiceLine2.NEXT = 0;

                                //LineDiscount = ItemChargesAmount + "Sales Invoice Line"."Line Amount";
                                if (DiscountChargesAmount <> 0) and (ItemChargesAmount + "Line Amount" <> 0) then
                                    LineDiscountExclVAT := ABS((DiscountChargesAmount / (ItemChargesAmount + "Line Amount")) * 100);

                                //HEI.04>>
                                //IF "Free Item" THEN
                                // BC Upgrade BHARAD11 >> --Drink-IT Field("Free Item")
                                // if "Free Item" and ("Line Discount %" = 100) then
                                //     //HEI.04<<
                                //     LineDiscountExclVAT := 100;
                                // BC Upgrade BHARAD11 << --Drink-IT Field("Free Item")
                            end;

                            //DA PU HT = Droit d’accise Prix unitaire Hors tax
                            ChargeInvoiceLine2.RESET;
                            DroitDAccise := 0;

                            ChargeInvoiceLine2.SETRANGE("Document No.", "Document No.");
                            ChargeInvoiceLine2.SETRANGE(Type, ChargeInvoiceLine2.Type::"Charge (Item)");
                            ChargeInvoiceLine2.SETRANGE("Attached to Line No.", "Line No.");
                            // BC Upgrade BHARDA11 >> ----Drnk-IT Fields("Show Item charge on Invoice","Item Charge Type")
                            // ChargeInvoiceLine2.SETFILTER("Show Item charge on Invoice", '<>%1', ChargeInvoiceLine2."Show Item charge on Invoice"::"Include in item price");
                            // ChargeInvoiceLine2.SETRANGE("Item Charge Type", ChargeInvoiceLine2."Item Charge Type"::Tax);
                            // BC Upgrade BHARDA11 << ----Drnk-IT Fields("Show Item charge on Invoice","Item Charge Type")
                            if ChargeInvoiceLine2.FINDSET then
                                repeat
                                    if (STRPOS(LOWERCASE(ChargeInvoiceLine2.Description), 'droit') > 0) and
                                       (STRPOS(LOWERCASE(ChargeInvoiceLine2.Description), 'accise') > 0)
                                    then
                                        if (ChargeInvoiceLine2.Quantity <> 0) and (ChargeInvoiceLine2.Amount <> 0) then
                                            DroitDAccise += ChargeInvoiceLine2.Amount / ChargeInvoiceLine2.Quantity;
                                until ChargeInvoiceLine2.NEXT = 0;

                            //Eco_emb PU HT
                            ChargeInvoiceLine2.RESET;
                            EcoEmbPUHT := 0;

                            ChargeInvoiceLine2.SETRANGE("Document No.", "Document No.");
                            ChargeInvoiceLine2.SETRANGE(Type, ChargeInvoiceLine2.Type::"Charge (Item)");
                            ChargeInvoiceLine2.SETRANGE("Attached to Line No.", "Line No.");
                            // BC Upgrade BHARDA11 >> ----Drnk-IT Fields("Show Item charge on Invoice","Item Charge Type")
                            // ChargeInvoiceLine2.SETFILTER("Show Item charge on Invoice", '<>%1', ChargeInvoiceLine2."Show Item charge on Invoice"::"Include in item price");
                            // ChargeInvoiceLine2.SETRANGE("Item Charge Type", ChargeInvoiceLine2."Item Charge Type"::Tax);
                            // BC Upgrade BHARDA11 << ----Drnk-IT Fields("Show Item charge on Invoice","Item Charge Type")
                            if ChargeInvoiceLine2.FINDSET then
                                repeat
                                    if (STRPOS(LOWERCASE(ChargeInvoiceLine2.Description), 'eco') > 0) and
                                       (STRPOS(LOWERCASE(ChargeInvoiceLine2.Description), 'emballage') > 0)
                                    then
                                        if (ChargeInvoiceLine2.Quantity <> 0) and (ChargeInvoiceLine2.Amount <> 0) then
                                            EcoEmbPUHT += ChargeInvoiceLine2.Amount / ChargeInvoiceLine2.Quantity;
                                until ChargeInvoiceLine2.NEXT = 0;

                            //OM (Exo TVA)
                            ChargeInvoiceLine2.RESET;
                            OMExoTVA := 0;

                            ChargeInvoiceLine2.SETRANGE("Document No.", "Document No.");
                            ChargeInvoiceLine2.SETRANGE(Type, ChargeInvoiceLine2.Type::"Charge (Item)");
                            ChargeInvoiceLine2.SETRANGE("Attached to Line No.", "Line No.");
                            // ChargeInvoiceLine2.SETFILTER("Show Item charge on Invoice", '<>%1', ChargeInvoiceLine2."Show Item charge on Invoice"::"Include in item price");  // BC Upgrade BHARDA11 >> ----Drnk-IT Fields("Show Item charge on Invoice")
                            //ChargeInvoiceLine2.SETRANGE("Item Charge Type",ChargeInvoiceLine2."Item Charge Type"::Tax);
                            if ChargeInvoiceLine2.FINDSET then
                                repeat
                                    if (STRPOS(LOWERCASE(ChargeInvoiceLine2.Description), 'octroi') > 0) and
                                       (STRPOS(LOWERCASE(ChargeInvoiceLine2.Description), 'mer') > 0)
                                    then
                                        if (ChargeInvoiceLine2.Quantity <> 0) and (ChargeInvoiceLine2.Amount <> 0) then
                                            OMExoTVA += ChargeInvoiceLine2.Amount / ChargeInvoiceLine2.Quantity;
                                until ChargeInvoiceLine2.NEXT = 0;

                            //Montant Net HT
                            ChargeInvoiceLine2.RESET;
                            MontantNetHT := 0;

                            if Type = Type::Item then begin
                                ChargeInvoiceLine2.SETRANGE("Document No.", "Document No.");
                                ChargeInvoiceLine2.SETRANGE(Type, ChargeInvoiceLine2.Type::"Charge (Item)");
                                ChargeInvoiceLine2.SETRANGE("Attached to Line No.", "Line No.");
                                // ChargeInvoiceLine2.SETFILTER("Item Charge Type", '%1|%2', ChargeInvoiceLine2."Item Charge Type"::Discount, ChargeInvoiceLine2."Item Charge Type"::Tax); // BC Upgrade BHARDA11 >> ----Drnk-IT Fields("Item Charge Type")
                                if ChargeInvoiceLine2.FINDSET then
                                    repeat
                                        MontantNetHT += ChargeInvoiceLine2.Amount;
                                    until ChargeInvoiceLine2.NEXT = 0;
                            end;

                            MontantNetHT += "Line Amount";

                            //Consignes PU
                            ConsignesPU := 0;
                            if Type = Type::Item then begin
                                ChargeInvoiceLine2.RESET;
                                ChargeInvoiceLine2.SETRANGE("Document No.", "Document No.");
                                ChargeInvoiceLine2.SETRANGE(Type, ChargeInvoiceLine2.Type::"Charge (Item)");
                                ChargeInvoiceLine2.SETRANGE("Attached to Line No.", "Line No.");
                                // BC Upgrade BHARDA11 >> ----Drnk-IT Fields("Show Item charge on Invoice","ItemCharge Incl. Price")
                                // ChargeInvoiceLine2.SETRANGE("Item Charge Type", ChargeInvoiceLine2."Item Charge Type"::Deposit);
                                // ChargeInvoiceLine2.SETRANGE("ItemCharge Incl. Price", false);
                                // BC Upgrade BHARDA11 << ----Drnk-IT Fields("Show Item charge on Invoice","ItemCharge Incl. Price")
                                if ChargeInvoiceLine2.FINDSET then
                                    repeat
                                        if (ChargeInvoiceLine2.Quantity <> 0) and (ChargeInvoiceLine2.Amount <> 0) then
                                            ConsignesPU += ChargeInvoiceLine2.Amount / ChargeInvoiceLine2.Quantity;
                                    until ChargeInvoiceLine2.NEXT = 0;
                            end;

                            //Consignes Montant
                            ChargeInvoiceLine2.RESET;
                            ConsignesMontant := 0;
                            ChargeInvoiceLine2.SETRANGE("Document No.", "Document No.");
                            ChargeInvoiceLine2.SETRANGE(Type, ChargeInvoiceLine2.Type::"Charge (Item)");
                            ChargeInvoiceLine2.SETRANGE("Attached to Line No.", "Line No.");
                            // BC Upgrade BHARDA11 >> ----Drnk-IT Fields("Show Item charge on Invoice","Item Charge Type")
                            // ChargeInvoiceLine2.SETFILTER("Show Item charge on Invoice", '<>%1', ChargeInvoiceLine2."Show Item charge on Invoice"::"Include in item price");
                            // ChargeInvoiceLine2.SETRANGE("Item Charge Type", ChargeInvoiceLine2."Item Charge Type"::Deposit);
                            // BC Upgrade BHARDA11 << ----Drnk-IT Fields("Show Item charge on Invoice","Item Charge Type")
                            if ChargeInvoiceLine2.FINDSET then
                                repeat
                                    ConsignesMontant += ChargeInvoiceLine2.Amount;
                                until ChargeInvoiceLine2.NEXT = 0;
                            //HEI.01<<
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine_VATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine_VATPerc; VATAmountLine."VAT %")
                        {
                        }
                        column(VATAmountLine_VATAmount; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATBase; VATAmountLine."VAT Base")
                        {
                        }
                        column(SumTotalVatAmt; SumTotalVatAmt)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            //HEI.01>>
                            VATAmountLine.GetLine(Number);

                            if VATAmountLine."VAT %" = 0 then
                                CurrReport.SKIP;
                            //HEI.01<<
                        end;

                        trigger OnPreDataItem();
                        var
                            SalesInvoiceLine2: Record "Sales Invoice Line";
                        begin
                            //HEI.01>>
                            VATAmountLine.RESET;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            //HEI.01<<
                        end;
                    }
                    dataitem(Totals; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(MontantHT; MontantHT)
                        {
                        }
                        column(TotalTTC; TotalTTC)
                        {
                        }
                        column(Consignes; Consignes)
                        {
                        }

                        trigger OnAfterGetRecord();
                        var
                            SalesLine2: Record "Sales Line";
                        begin
                            //HEI.01>>
                            if Number = 1 then
                                Totals.FINDFIRST
                            else
                                Totals.NEXT;

                            //MontantHT
                            SalesLine2.RESET;
                            MontantHT := 0;
                            SalesLine2.SETRANGE("Document No.", "Sales Header"."No.");
                            // SalesLine2.SETFILTER("Item Charge Type", '<>%1', SalesLine2."Item Charge Type"::Deposit); // BC Upgrade BHARDA11 --Drink-IT Field("Item Charge Type")
                            if SalesLine2.FINDSET then
                                repeat
                                    MontantHT += SalesLine2."Line Amount";
                                until SalesLine2.NEXT = 0;

                            //TotalTTC
                            SalesLine2.RESET;
                            TotalTTC := 0;
                            SalesLine2.SETRANGE("Document No.", "Sales Header"."No.");
                            // SalesLine2.SETFILTER("Item Charge Type", '<>%1', SalesLine2."Item Charge Type"::Deposit);  // BC Upgrade BHARDA11 --Drink-IT Field("Item Charge Type")
                            if SalesLine2.FINDSET then
                                repeat
                                    TotalTTC += SalesLine2."Amount Including VAT";
                                until SalesLine2.NEXT = 0;

                            //Consignes
                            SalesLine2.RESET;
                            Consignes := 0;
                            SalesLine2.SETRANGE("Document No.", "Sales Header"."No.");
                            // SalesLine2.SETRANGE("Item Charge Type", SalesLine2."Item Charge Type"::Deposit);  // BC Upgrade BHARDA11 --Drink-IT Field("Item Charge Type")
                            if SalesLine2.FINDSET then
                                repeat
                                    Consignes += SalesLine2."Line Amount";
                                until SalesLine2.NEXT = 0;
                            //HEI.01<<
                        end;

                        trigger OnPreDataItem();
                        begin
                            //HEI.01>>
                            SETRANGE(Number, 1, Totals.COUNT);
                            //HEI.01<<
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then
                        CopyText := Text52000;
                    CurrReport.PAGENO := 1;
                    OutputNo := OutputNo + 1;
                end;

                trigger OnPostDataItem();
                begin
                    SalesCountPrinted.RUN("Sales Header");
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
                Customer2: Record Customer;
                Customer3: Record Customer;
                SalesLine: Record "Sales Line";
                SalesLine2: Record "Sales Line";
                CustomerAttributes: Record "Customer Attributes FND";
                CustomerAttributes2: Record "Customer Attributes FND";
                LegalForm: Record "Legal Form FND";
                OtherTax: Boolean;
                LegalFormName: Text;
            begin

                DocSubtypeCodeSetup.GET();// BC Upgrade SHUKLP03 >>
                //HEI.03>>
                // IF "Ship-to Country/Region Code" <> CompanyInfo."Country/Region Code" THEN
                //     ExportInvoice := TRUE
                // ELSE
                //     ExportInvoice := FALSE;
                //HEI.03<<
                //BC Upgrade SHUKLP03 >> (DocSubtypeCodeSetup)
                if "Document Subtype Code FND" in [DocSubtypeCodeSetup."Sundry Sales Order Non Stock", DocSubtypeCodeSetup."Sundry Sales Order Stock"] then begin
                    //ExportInvoice := FALSE; //HEI.03

                    //HEI.01>>
                    SundryInvoice := true;
                end;
                //BC Upgrade SHUKLP03 << (DocSubtypeCodeSetup)
                // Invoice No Caption
                InvoiceNoLbl := '';

                //HEI.03>>
                //IF ExportInvoice THEN
                //InvoiceNoLbl := ExportInvoiceNoLbl
                //ELSE
                //HEI.03<<

                if SundryInvoice then
                    InvoiceNoLbl := SundryInvoiceNoLbl
                else
                    InvoiceNoLbl := InvoiceNoLbl2;

                Customer.GET("Sell-to Customer No.");
                CustomerAttributes.GET("Sell-to Customer No.");

                //Sell-to Customer
                SellToCustomerText := SellToCustomerLbl + "Sell-to Customer No.";
                SellToCustomerText += '|' + "Sell-to Customer Name";

                //HEI.05>>
                //IF "Sell-to Customer Name 2" <> '' THEN
                //  SellToCustomerText += '|' + "Sell-to Customer Name 2";
                if Customer."Name 2" <> '' then
                    SellToCustomerText += ' ' + Customer."Name 2";
                if CustomerAttributes."Name 3" <> '' then
                    SellToCustomerText += ' ' + CustomerAttributes."Name 3";

                //IF "Sell-to Address" <> '' THEN
                //  IF (CustomerAttributes."House No. 1" <> '') AND (CustomerAttributes."House No. 1" <> '0') THEN
                //    SellToCustomerText += '|' + CustomerAttributes."House No. 1" + ' ' + "Sell-to Address"
                //  ELSE
                //    SellToCustomerText += '|' + "Sell-to Address";

                if Customer.Address <> '' then
                    if (CustomerAttributes."House No. 1" <> '') and (CustomerAttributes."House No. 1" <> '0') then begin
                        SellToCustomerText += '|' + CustomerAttributes."House No. 1";
                        if (CustomerAttributes."House Supplement 2" <> '') and (CustomerAttributes."House Supplement 2" <> '0') then
                            SellToCustomerText += ' ' + CustomerAttributes."House Supplement 2" + ' ' + Customer.Address
                        else
                            SellToCustomerText += ' ' + Customer.Address;
                    end else begin
                        if (CustomerAttributes."House Supplement 2" <> '') and (CustomerAttributes."House Supplement 2" <> '0') then
                            SellToCustomerText += '|' + CustomerAttributes."House Supplement 2" + ' ' + Customer.Address
                        else
                            SellToCustomerText += '|' + Customer.Address;
                    end;

                //IF "Sell-to Address 2" <> '' THEN BEGIN
                //  SellToCustomerText += '|' + "Sell-to Address 2";
                //  IF (CustomerAttributes."P.O.Box" <> '') AND (CustomerAttributes."P.O.Box" <> '0') THEN
                //    SellToCustomerText += ' ' + 'BP' + ' ' + CustomerAttributes."P.O.Box";
                //END ELSE
                //  IF (CustomerAttributes."P.O.Box" <> '') AND (CustomerAttributes."P.O.Box" <> '0') THEN
                //    SellToCustomerText += '|' + 'BP' + ' ' + CustomerAttributes."P.O.Box";

                if Customer."Address 2" <> '' then begin
                    SellToCustomerText += '|' + Customer."Address 2";
                    if CustomerAttributes."Street 3" <> '' then
                        SellToCustomerText += ' ' + CustomerAttributes."Street 3";
                    if CustomerAttributes."Street 4" <> '' then
                        SellToCustomerText += ' ' + CustomerAttributes."Street 4";
                    if CustomerAttributes."Street 5" <> '' then
                        SellToCustomerText += ' ' + CustomerAttributes."Street 5";
                    if (CustomerAttributes."P.O.Box" <> '') and (CustomerAttributes."P.O.Box" <> '0') then
                        SellToCustomerText += ' ' + 'BP' + ' ' + CustomerAttributes."P.O.Box";
                end else begin
                    if CustomerAttributes."Street 3" <> '' then begin
                        SellToCustomerText += '|' + CustomerAttributes."Street 3";
                        if CustomerAttributes."Street 4" <> '' then
                            SellToCustomerText += ' ' + CustomerAttributes."Street 4";
                        if CustomerAttributes."Street 5" <> '' then
                            SellToCustomerText += ' ' + CustomerAttributes."Street 5";
                        if (CustomerAttributes."P.O.Box" <> '') and (CustomerAttributes."P.O.Box" <> '0') then
                            SellToCustomerText += ' ' + 'BP' + ' ' + CustomerAttributes."P.O.Box";
                    end else begin
                        if CustomerAttributes."Street 4" <> '' then begin
                            SellToCustomerText += '|' + CustomerAttributes."Street 4";
                            if CustomerAttributes."Street 5" <> '' then
                                SellToCustomerText += ' ' + CustomerAttributes."Street 5";
                            if (CustomerAttributes."P.O.Box" <> '') and (CustomerAttributes."P.O.Box" <> '0') then
                                SellToCustomerText += ' ' + 'BP' + ' ' + CustomerAttributes."P.O.Box";
                        end else begin
                            if CustomerAttributes."Street 5" <> '' then begin
                                SellToCustomerText += '|' + CustomerAttributes."Street 5";
                                if (CustomerAttributes."P.O.Box" <> '') and (CustomerAttributes."P.O.Box" <> '0') then
                                    SellToCustomerText += ' ' + 'BP' + ' ' + CustomerAttributes."P.O.Box";
                            end else
                                if (CustomerAttributes."P.O.Box" <> '') and (CustomerAttributes."P.O.Box" <> '0') then
                                    SellToCustomerText += '|' + 'BP' + ' ' + CustomerAttributes."P.O.Box";
                        end;
                    end;
                end;

                //IF "Sell-to Post Code" <> '' THEN
                //  SellToCustomerText += '|' + "Sell-to Post Code";
                //IF "Sell-to City" <> '' THEN
                //  SellToCustomerText += ' ' + "Sell-to City";
                //IF "Sell-to Country/Region Code" <> '' THEN
                //  SellToCustomerText += ' (' + "Sell-to Country/Region Code" + ')';
                //IF ("Sell-to Post Code" <> '') OR ("Sell-to City" <> '') OR ("Sell-to Country/Region Code" <> '') THEN
                //  SellToCustomerText += '|';

                if Customer."Post Code" <> '' then begin
                    SellToCustomerText += '|' + Customer."Post Code";
                    if Customer.City <> '' then
                        SellToCustomerText += ' ' + Customer.City;
                    if CustomerAttributes."Other City" <> '' then
                        SellToCustomerText += ' ' + CustomerAttributes."Other City";
                    if Customer."Country/Region Code" <> '' then
                        SellToCustomerText += ' (' + Customer."Country/Region Code" + ')';
                end else begin
                    if Customer.City <> '' then begin
                        SellToCustomerText += '|' + Customer.City;
                        if CustomerAttributes."Other City" <> '' then
                            SellToCustomerText += ' ' + CustomerAttributes."Other City";
                        if Customer."Country/Region Code" <> '' then
                            SellToCustomerText += ' (' + Customer."Country/Region Code" + ')';
                    end else begin
                        if CustomerAttributes."Other City" <> '' then begin
                            SellToCustomerText += '|' + CustomerAttributes."Other City";
                            if Customer."Country/Region Code" <> '' then
                                SellToCustomerText += ' (' + Customer."Country/Region Code" + ')';
                        end else
                            if Customer."Country/Region Code" <> '' then
                                SellToCustomerText += '|' + ' (' + Customer."Country/Region Code" + ')';
                    end;
                end;

                Customer2.RESET;
                Customer2.GET("Sell-to Customer No.");
                if Customer2."Phone No." <> '' then
                    SellToCustomerText += '|' + PhoneLbl + Customer2."Phone No.";
                if Customer2."VAT Registration No." <> '' then
                    SellToCustomerText += '|' + Customer2."VAT Registration No.";

                //Bill-to Customer
                //Legal Form without 'FR-'
                CustomerAttributes2.GET("Bill-to Customer No.");
                LegalFormName := '';
                if CustomerAttributes2."Legal Form" <> '' then begin
                    LegalForm.GET(CustomerAttributes2."Legal Form");
                    if (STRPOS(UPPERCASE(LegalForm.Name), 'FR-') > 0) then
                        LegalFormName := DELCHR(LegalForm.Name, '<', 'FR-');
                end;

                BillToCustomerText := BillToCustomerLbl + "Bill-to Customer No.";

                //HEI.07>>
                SIRENClient := '';
                if CustomerAttributes2."Tax Number 2" <> '' then
                    SIRENClient := CustomerAttributes2."Tax Number 2";
                //HEI.07<<

                //Bill-to Customer Text
                //HEI.05>>
                Customer3.GET("Bill-to Customer No.");

                if LegalFormName <> '' then
                    //BillToCustomerText := LegalFormName + ' - ' + "Bill-to Name"
                    BillToCustomerText += '|' + LegalFormName + ' - ' + "Bill-to Name"
                else
                    //BillToCustomerText := "Bill-to Name";
                    BillToCustomerText += '|' + "Bill-to Name";

                //IF "Bill-to Name 2" <> '' THEN
                //  BillToCustomerText += '|' + "Bill-to Name 2";

                if Customer3."Name 2" <> '' then
                    BillToCustomerText += ' ' + Customer3."Name 2";
                if CustomerAttributes2."Name 3" <> '' then
                    BillToCustomerText += ' ' + CustomerAttributes2."Name 3";

                //IF "Bill-to Address" <> '' THEN
                //  IF (CustomerAttributes2."House No. 1" <> '') AND (CustomerAttributes2."House No. 1" <> '0') THEN
                //    BillToCustomerText += '|' +  CustomerAttributes2."House No. 1" + ' ' + "Bill-to Address"
                //  ELSE
                //    BillToCustomerText += '|' + "Bill-to Address";

                if Customer3.Address <> '' then
                    if (CustomerAttributes2."House No. 1" <> '') and (CustomerAttributes2."House No. 1" <> '0') then begin
                        BillToCustomerText += '|' + CustomerAttributes2."House No. 1";
                        if (CustomerAttributes2."House Supplement 2" <> '') and (CustomerAttributes2."House Supplement 2" <> '0') then
                            BillToCustomerText += ' ' + CustomerAttributes2."House Supplement 2" + ' ' + Customer3.Address
                        else
                            BillToCustomerText += ' ' + Customer3.Address;
                    end else begin
                        if (CustomerAttributes2."House Supplement 2" <> '') and (CustomerAttributes2."House Supplement 2" <> '0') then
                            BillToCustomerText += '|' + CustomerAttributes2."House Supplement 2" + ' ' + Customer3.Address
                        else
                            BillToCustomerText += '|' + Customer3.Address;
                    end;

                //IF "Bill-to Address 2" <> '' THEN BEGIN
                //  BillToCustomerText += '|' + "Bill-to Address 2";
                //  IF (CustomerAttributes2."P.O.Box" <> '') AND (CustomerAttributes2."P.O.Box" <> '0')  THEN
                //    BillToCustomerText += ' ' + 'BP' + ' ' + CustomerAttributes2."P.O.Box";
                //END ELSE
                //  IF (CustomerAttributes2."P.O.Box" <> '') AND (CustomerAttributes2."P.O.Box" <> '0')  THEN
                //    BillToCustomerText += '|' + 'BP' + ' ' + CustomerAttributes2."P.O.Box";

                if Customer3."Address 2" <> '' then begin
                    BillToCustomerText += '|' + Customer3."Address 2";
                    if CustomerAttributes2."Street 3" <> '' then
                        BillToCustomerText += ' ' + CustomerAttributes2."Street 3";
                    if CustomerAttributes2."Street 4" <> '' then
                        BillToCustomerText += ' ' + CustomerAttributes2."Street 4";
                    if CustomerAttributes2."Street 5" <> '' then
                        BillToCustomerText += ' ' + CustomerAttributes2."Street 5";
                    if (CustomerAttributes2."P.O.Box" <> '') and (CustomerAttributes2."P.O.Box" <> '0') then
                        BillToCustomerText += ' ' + 'BP' + ' ' + CustomerAttributes2."P.O.Box";
                end else begin
                    if CustomerAttributes2."Street 3" <> '' then begin
                        BillToCustomerText += '|' + CustomerAttributes2."Street 3";
                        if CustomerAttributes2."Street 4" <> '' then
                            BillToCustomerText += ' ' + CustomerAttributes2."Street 4";
                        if CustomerAttributes2."Street 5" <> '' then
                            BillToCustomerText += ' ' + CustomerAttributes2."Street 5";
                        if (CustomerAttributes2."P.O.Box" <> '') and (CustomerAttributes2."P.O.Box" <> '0') then
                            BillToCustomerText += ' ' + 'BP' + ' ' + CustomerAttributes2."P.O.Box";
                    end else begin
                        if CustomerAttributes2."Street 4" <> '' then begin
                            BillToCustomerText += '|' + CustomerAttributes2."Street 4";
                            if CustomerAttributes2."Street 5" <> '' then
                                BillToCustomerText += ' ' + CustomerAttributes2."Street 5";
                            if (CustomerAttributes2."P.O.Box" <> '') and (CustomerAttributes2."P.O.Box" <> '0') then
                                BillToCustomerText += ' ' + 'BP' + ' ' + CustomerAttributes2."P.O.Box";
                        end else begin
                            if CustomerAttributes2."Street 5" <> '' then begin
                                BillToCustomerText += '|' + CustomerAttributes2."Street 5";
                                if (CustomerAttributes2."P.O.Box" <> '') and (CustomerAttributes2."P.O.Box" <> '0') then
                                    BillToCustomerText += ' ' + 'BP' + ' ' + CustomerAttributes2."P.O.Box";
                            end else
                                if (CustomerAttributes2."P.O.Box" <> '') and (CustomerAttributes2."P.O.Box" <> '0') then
                                    BillToCustomerText += '|' + 'BP' + ' ' + CustomerAttributes2."P.O.Box";
                        end;
                    end;
                end;

                //IF "Bill-to Post Code" <> '' THEN
                //  BillToCustomerText += '|' + "Bill-to Post Code";
                //IF "Bill-to City" <> '' THEN
                //  BillToCustomerText += ' ' + "Bill-to City";
                //IF "Bill-to Country/Region Code" <> '' THEN
                //  BillToCustomerText += ' (' + "Bill-to Country/Region Code" + ')';

                if Customer3."Post Code" <> '' then begin
                    BillToCustomerText += '|' + Customer3."Post Code";
                    if Customer3.City <> '' then
                        BillToCustomerText += ' ' + Customer3.City;
                    if CustomerAttributes2."Other City" <> '' then
                        BillToCustomerText += ' ' + CustomerAttributes2."Other City";
                    if Customer3."Country/Region Code" <> '' then
                        BillToCustomerText += ' (' + Customer3."Country/Region Code" + ')';
                end else begin
                    if Customer3.City <> '' then begin
                        BillToCustomerText += '|' + Customer3.City;
                        if CustomerAttributes2."Other City" <> '' then
                            BillToCustomerText += ' ' + CustomerAttributes2."Other City";
                        if Customer3."Country/Region Code" <> '' then
                            BillToCustomerText += ' (' + Customer3."Country/Region Code" + ')';
                    end else begin
                        if CustomerAttributes2."Other City" <> '' then begin
                            BillToCustomerText += '|' + CustomerAttributes2."Other City";
                            if Customer3."Country/Region Code" <> '' then
                                BillToCustomerText += ' (' + Customer3."Country/Region Code" + ')';
                        end else
                            if Customer3."Country/Region Code" <> '' then
                                BillToCustomerText += '|' + ' (' + Customer3."Country/Region Code" + ')';
                    end;
                end;
                //HEI.05<<

                //Posted Sales Shipment
                SalesShipmentHeader.RESET;
                ShipmentNo := '';
                SalesShipmentHeader.SETRANGE("Order No.", "No.");
                if SalesShipmentHeader.FINDFIRST then
                    ShipmentNo := SalesShipmentHeader."No."
                else
                    ShipmentNo := '';

                //VAT Counter
                CLEAR(SumTotalVatAmt);
                VATAmountLine.DELETEALL;
                SalesLine.CalcVATAmountLines(0, "Sales Header", SalesLine, VATAmountLine);
                SumTotalVatAmt += VATAmountLine."VAT Amount";

                //Check other Tax charges
                SalesLine2.RESET;
                SalesLine2.SETRANGE("Document Type", "Document Type");
                SalesLine2.SETRANGE("Document No.", "No.");
                SalesLine2.SETRANGE(Type, SalesLine2.Type::"Charge (Item)");
                // SalesLine2.SETRANGE("Item Charge Type", SalesLine2."Item Charge Type"::Tax); // BC Upgrade BHARAD11 --Drink-IT Field("Item Charge Type")
                if SalesLine2.FINDSET then
                    repeat
                        OtherTax := true;
                        if ((STRPOS(LOWERCASE(SalesLine2.Description), 'droit') > 0) and
                           (STRPOS(LOWERCASE(SalesLine2.Description), 'accise') > 0))
                        then
                            OtherTax := false;
                        if ((STRPOS(LOWERCASE(SalesLine2.Description), 'eco') > 0) and
                           (STRPOS(LOWERCASE(SalesLine2.Description), 'emballage') > 0))
                        then
                            OtherTax := false;
                        if ((STRPOS(LOWERCASE(SalesLine2.Description), 'octroi') > 0) and
                           (STRPOS(LOWERCASE(SalesLine2.Description), 'mer') > 0))
                        then
                            OtherTax := false;
                    until (SalesLine2.NEXT = 0) or OtherTax;

                if OtherTax then
                    if not CONFIRM(OtherTaxOnInvoiceConf) then
                        ERROR(OtherTaxOnInvoiceErr);
                //HEI.01<<

                // CurrReport.LANGUAGE := Language.GetLanguageID("Language Code"); // BC Upgrade BHARDA11 ----Change Language to LanguageMgt
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageID("Language Code"); // BC Upgrade BHARDA11 ----Change Language to LanguageMgt


                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");

                PaymentMethod.RESET;
                if PaymentMethod.GET("Payment Method Code") then;
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
        lblPageNo = 'Page'; label(PaymentLbl; ENU = 'Payment :',
                                            FRA = 'Paiement :')
        label(PaymentTextLbl; ENU = 'Bank details for payment by bank transfer: IBAN =',
                             FRA = 'Coordonnées bancaires pour règlement par virement : IBAN =')
        label(PaymentTextLbl2; ENU = ' / SWIFT',
                              FRA = ' / BIC')
        label(ShipmentNoLbl; ENU = 'Shipment No.',
                            FRA = 'N° Bon de livraison')
        label(OrderNoLbl; ENU = 'Order No.',
                         FRA = 'N° de commande Interne')
        label(OrderDateLbl; ENU = 'Shipment Date',
                           FRA = 'Date de Livraison')
        label(ShipmentDateLbl; ENU = 'Posting Date',
                              FRA = 'Date Facture')
        label(DueDateLbl; ENU = 'Due Date',
                         FRA = 'Date d''échéance')
        label(SalesRoutesLbl; ENU = 'Sales Routes',
                             FRA = 'Code commercial')
        label(LocationCodeLbl; ENU = 'Location Code',
                              FRA = 'Code mag')
        label(ExternalDocNoLbl; ENU = 'External Document No.',
                               FRA = 'N° de commande Externe')
        label(ItemDescriptionLbl; ENU = 'Item No. | Description',
                                 FRA = 'Désignation Article  GTIN | Nomenclature douanière ')
        label(QuantityLbl; ENU = 'Qty',
                          FRA = 'Qté')
        label(UoMLbl; ENU = 'Unit of Measure',
                     FRA = 'Unité de Mesure')
        label(UnitPriceLbl; ENU = 'Unit Price Excl. VAT',
                           FRA = 'PU HT hors droit')
        label(LineDiscountLbl; ENU = '% Discount',
                              FRA = '% Remise')
        label(DAPUHTLbl; ENU = 'DA PU HT',
                        FRA = 'DA PU HT')
        label(EcoEmbPuHtLbl; ENU = 'Eco-Emb PU HT',
                            FRA = 'Eco-Emb PU HT')
        label(OMExoTVALbl; ENU = 'OM (Exo TVA)',
                          FRE = 'OM (Exo TVA)')
        label(MontantNetHTLbl; ENU = 'Montant Net HT',
                              FRA = 'Montant Net HT')
        label(CodeTVALbl; ENU = 'Code TVA',
                         FRA = 'Code TVA')
        label(ConsignesPULbl; ENU = 'Consignes PU',
                             FRA = 'Consignes PU')
        label(ConsignesMontantExoTVALbl; ENU = 'Consignes montant (Exo TVA)',
                                        FRA = 'Consignes montant (Exo TVA)')
        label(MontantHTLbl; ENU = 'Montant HT',
                           FRA = 'Montant HT')
        label(TotalTTCLbl; ENU = 'TOTAL TTC',
                          FRA = 'TOTAL TTC')
        label(ConsigneLbl; ENU = 'CONSIGNE',
                          FRA = 'CONSIGNE')
        label(NETaPayerEnEURLbl; ENU = 'NET A PAYER EN EUR',
                                FRA = 'NET A PAYER EN EUR')
        label(VATLbl; ENU = 'VAT',
                     FRA = 'TVA')
        label(SIRENLbl; ENU = 'SIREN Client',
                       FRA = 'SIREN Client')
    }

    trigger OnPreReport();
    begin
        CompanyInfo.GET;

        //HEI.01>>
        //Header Image
        // BC Upgrade BHARDA11 >> ----Drink-IT Table(StandardTextReport,StandardTextReport2)
        // StandardTextReport.RESET;
        // StandardTextReport.SETRANGE("Report ID", 50302);
        // StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Header);
        // if StandardTextReport.FINDFIRST then
        //     StandardTextReport.CALCFIELDS(Image);

        // //Footer Image
        // StandardTextReport2.RESET;
        // StandardTextReport2.SETRANGE("Report ID", 50302);
        // StandardTextReport2.SETRANGE("Position Text", StandardTextReport2."Position Text"::Footer);
        // if StandardTextReport2.FINDFIRST then
        //     StandardTextReport2.CALCFIELDS(Image);
        // BC Upgrade BHARDA11 << ----Drink-IT Table(StandardTextReport,StandardTextReport2)
        //HEI.01<<
    end;

    var
        CompanyInfo: Record "Company Information";
        // Language: Record Language; // BC Upgrade BHARDA11 -- Change Language record to LanguageMgt codeunit
        LanguageMgt: Codeunit Language;

        PaymentTerms: Record "Payment Terms";
        Customer: Record Customer;
        SalesCountPrinted: Codeunit "Sales-Printed";
        NoOfLoops: Integer;
        NoOfCopies: Integer;
        OutputNo: Integer;
        Text52000: Label 'Copy';
        CopyText: Text[10];
        PaymentMethod: Record "Payment Method";
        ExportInvoice: Boolean;
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND"; // BC Upgrade SHUKLP03 <<

        // BC Upgrade BHARAD11 >>--Drink-IT Tables("Standard Text Report")
        // StandardTextReport: Record "Standard Text Report";
        // StandardTextReport2: Record "Standard Text Report";
        // BC Upgrade BHARAD11 <<--Drink-IT Tables("Standard Text Report")

        SellToCustomerText: Text;
        SellToCustomerLbl: TextConst ENU = 'Sell-to Customer: ', FRA = 'Client livré: ';
        BillToCustomerLbl: TextConst ENU = 'Bill-to Customer: ', FRA = 'Client Facturé: ';
        PhoneLbl: TextConst ENU = 'Phone: ', FRA = 'Tél: ';
        BillToCustomerText: Text;
        InvoiceNoLbl: Text;
        SundryInvoice: Boolean;
        InvoiceNoLbl2: TextConst ENU = 'Order Confirmation No.', FRA = 'Confirmation Commande N°';
        ExportInvoiceNoLbl: TextConst ENU = 'Export Invoice No.', FRA = 'Facture export N°';
        SundryInvoiceNoLbl: TextConst ENU = 'Sundry Invoice No.', FRA = 'Facture Divers N°';
        SalesShipmentHeader: Record "Sales Shipment Header";
        ShipmentNo: Code[20];
        Item: Record Item;
        OctroiGtin: Text;
        TranslatedUoM: Text;
        UnitPriceExclVAT: Decimal;
        LineDiscountExclVAT: Decimal;
        DroitDAccise: Decimal;
        MontantNetHT: Decimal;
        ConsignesPU: Decimal;
        ConsignesMontant: Decimal;
        EcoEmbPUHT: Decimal;
        OMExoTVA: Decimal;
        OtherTaxOnInvoiceConf: Label 'Not all Tax Charges on Invoice. Do you want to continue?';
        OtherTaxOnInvoiceErr: Label 'Not all Tax Charges on Invoice.';
        VATAmountLine: Record "VAT Amount Line" temporary;
        SumTotalVatAmt: Decimal;
        MontantHT: Decimal;
        Consignes: Decimal;
        TotalTTC: Decimal;
        NoDescription: Text;
        SIRENClient: Text;
}

