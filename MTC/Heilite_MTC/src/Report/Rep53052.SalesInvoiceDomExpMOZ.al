report 53052 "Sales Invoice Dom/Exp MOZ"
{
    // version HEI.12

    // HEI.01 IBM.NAIKH01 16.07.2018 FDD-MZ-OTCGAP001_SalesInvoice_Domestic_v0.3
    //   # Created a new report copy of report 54501 - Sales Invoice MOZ (HEI.02)
    //   # Added new text in the Report footer
    //   # Added Field "External Document No." on report
    // 
    // 
    // HEI.02 FDD-MZ-LOGGAP002 IBM IPO, 01.08.2018 add extra requirements for Export Invoice
    //   #new column Currency code in detail lines for export invoices
    //   #new column for currency code in totals section
    //   #special section Reason for Export
    //   #add code to Sales Invoice Header - OnAfterGetRecord()
    //   #new global variables DomesticInv, SalesCommLine, SalesCommText and local variable Cust1
    // 
    // HEI.03 # Bugfixing Mozambique IBM NASTAA02 17.08.2018 # Add Deposit Charges
    //   # Added Deposit Charges to Layout
    //   # Updated Total Amount and Total VAT Amount
    //   # Just Deposit Charges with "Show Item Charge on Invoice" blank (' ') or Order Total will be displayed
    //   # Added ENU Caption to some labels
    // 
    // HEI.04 # Bugfixing Mozambique IBM NASTAA02 06.09.2018 # Invoices for Mozambique
    //   # Label is changed in "Line Amount Excl. / Incl. VAT" depending on "Prices Including VAT" Field
    //   # Totals in footer are calculated depending on "Prices Including VAT" Field
    // 
    // HEI.05 # Bugfixing Mozambique IBM NASTAA02 10.09.2018 # Invoices for Mozambique
    //   # Used "Due Date Calculation" for Payment Terms
    //   # Used SetData / GetData functions for header and footer
    //   # Added Deposit Amount on the subtotals
    // 
    // HEI.06 Defect #2875 IBM NASTAA02 21.09.2018 # Discount not calculated on the et price in SellCo
    //   # Discount should be deducted before calculating the VAT
    // 
    // HEI.07 # Bugfixing Mozambique IBM NASTAA02 28.09.2018 # Invoices for Mozambique
    //   # Discount should be printed based on "Show Item Charge on Invoice" field
    //   # For Option ' ' (blank) and 'Order Total' discount will be transformed in Disc Percentage and shown in column Disc %
    //   # For Option 'Under Item Line' Discount will be printed under the Item Line
    //   # For Option 'Include in Item Price' Discount will deducted from the Line Amount and Disc % column will be empty
    // 
    // HEI.08 # Bugfixing Mozambique IBM NASTAA02 28.09.2018 # Invoices for Mozambique
    //   # Disc Column should be blank for Options 'Include in Item Price' and 'Under Item Line'
    //   # Discount should be deducted from the "Unit Price" for Option 'Include in Item Price'
    // 
    // FCE02 03/10/2018 Made some small changes to the discount calc
    // 
    // HEI.09 CHG2079696 IBM SAMANR01 09-16-2020
    //   # Add code for fix the report language issue
    // HEI.10 HB1963 - CHG2093473 IBM NASTAA02 12.02.2021 # MZ - Missing set up for Sundry InvoiceCredit Note
    //   # Removed filter from layout on Type = Resource
    // HEI.11 HB3924 - CHG2249588 IBM COSTES04 28.05.2024 Mozambique-Sales Invoice Customer address, postal and City correction
    //   # Change customer address from bill-to to sell-to
    // HEI.12 CHG2297751 HB4275 IBM ADHIKG01 07.07.2025 Mozambique The customer invoice details for Sales Code 04 are incorrectly displayed due to a wrong logic
    //   # Modified the logic to include Transportation Charge in Unit Price
    //   # Modified the logic to calculate Total Amount Excl. VAT
    //   # Added thousand separator in the footer section

    // BC Upgrade KUMARR78 >>
    // Report Name  : Sales Invoice Dom/Exp MOZ
    // Report ID    : 50148
    // 1. Added Business Central visibility properties.
    //    Old:
    //         - ApplicationArea not mandatory in NAV.
    //         - UsageCategory not defined.
    //    New:
    //         - ApplicationArea = All
    //         - UsageCategory = ReportsAndAnalysis
    //
    // 2. Replaced Language record usage with Codeunit in BC.
    //    Old:
    //         - Language: Record Language;
    //         - CurrReport.Language := Language.GetLanguageID(LangCode);
    //    New:
    //         - LanguageG: Codeunit Language;
    //         - CurrReport.Language := LanguageG.GetLanguageId(LangCode);
    //
    // 3. Removed deprecated "Item Charge Type" (DIT) logic from report.
    //    Old:
    //         - SETRANGE("Item Charge Type", ...);
    //         - Filters on Discount / Deposit / Tax using "Item Charge Type".
    //         - Layout column based on "Item Charge Type".
    //    New:
    //         - All "Item Charge Type" filters and conditions removed.
    //         - DataItemTableView updated to use only:
    //              • Type = FILTER("Charge (Item)")
    //              • Quantity filters where applicable
    //         - Related business logic adjusted accordingly.
    //
    // 4. Modified SalesInvoiceLine_ItemChargeType column.
    //    Old:
    //         column(SalesInvoiceLine_ItemChargeType; "Item Charge Type")
    //    New:
    //         column(SalesInvoiceLine_ItemChargeType; '')
    //         - Passing blank value as field is removed in BC.
    //
    // 5. Updated SalesInvoiceLinesDeposit DataItem filter.
    //    Old:
    //         WHERE(Type = FILTER('"Charge (Item)"'),
    //               "Item Charge Type" = FILTER(Deposit),
    //               Quantity = FILTER(<> 0))
    //    New:
    //         WHERE(Type = FILTER("Charge (Item)"),
    //               Quantity = FILTER(<> 0))
    //
    // 6. Removed obsolete custom/unsupported tables and variables (DIT).
    //    Old:
    //         - Sales Deposit Item Charge (multiple variables)
    //         - Whse. Shipping Driver
    //         - Whse. Shipping Truck
    //         - Document Tracking Management Codeunit
    //    New:
    //         - All above variables and related logic removed.
    //         - Shipping Agent Code retained from Posted Whse. Shipment Header.
    //
    // 7. Adjusted Discount & Deposit calculation logic due to DIT removal.
    //    Old:
    //         - Discount / Deposit determined using:
    //              • "Item Charge Type"
    //              • "Show Item Charge on Invoice" options
    //    New:
    //         - Logic simplified.
    //         - LineAmount recalculated using:
    //              LineAmount := ABS(UnitPrice * Quantity);
    //         - Transport and charge logic handled via:
    //              SETRANGE(Type, Type::"Charge (Item)")
    //
    // 8. Added ApplicationArea on Request Page field.
    //    Old:
    //         - Field LangCode without ApplicationArea.
    //    New:
    //         - ApplicationArea = All added to:
    //              • LangCode
    //
    // 9. Removed Print on Invoice filter in Sales Comment Line.
    //    Old:
    //         SalesCommLine.SETRANGE("Print on Invoice", true);
    //    New:
    //         - Filter removed.
    //
    // 10. Removed commented legacy NAV logic not supported in BC.
    //     Old:
    //         - Deposit specific logic using removed fields.
    //         - Warehouse driver/truck custom logic.
    //         - Document tracking call:
    //              DocTrackingManagement.CallPostedItemTracking3(...)
    //     New:
    //         - Obsolete logic commented/removed for BC compatibility.
    // BC Upgrade KUMARR78 <<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Sales Invoice DomExp MOZ.rdl';
    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding Usagecategory

    CaptionML = ENU = 'Sales Invoice Prod. Companies',
                FRA = 'Facture vente société production';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeadingML = ENU = 'Posted Sales Invoice',
                                     FRA = 'Facture vente enregistrée';
            column(HideDiscount; HideDiscount = 0)
            {
            }
            column(DomesticInv; DomesticInv)
            {
            }
            column(ProcessedByComputerCaption; ProcessedByComputerLbl)
            {
            }
            column(SignatureCaption2; SignatureLbl)
            {
            }
            column(CustomerSignatureCaption; CustomerSignatureLbl)
            {
            }
            column(LblName1; LblName)
            {
            }
            column(AddressCaption1; AddressCaption)
            {
            }
            column(VATRegistrationNum1; VATRegistrationNum)
            {
            }
            column(EmailCaption1; EmailCaption)
            {
            }
            column(BankCaption1; BankCaption)
            {
            }
            column(BankAccNo1; BankAccNo)
            {
            }
            column(INVOICECaption1; INVOICECaption)
            {
            }
            column(InvoiceNoCaption1; InvoiceNoCaption)
            {
            }
            column(DateCaption1; DateCaption)
            {
            }
            column(LblCurrCode1; LblCurrCode)
            {
            }
            column(LblExternalDocNo1; LblExternalDocNo)
            {
            }
            column(CustomerCodeCaption1; CustomerCodeCaption)
            {
            }
            column(CustomerNameCaption1; CustomerNameCaption)
            {
            }
            column(SalesOrderNoCaption1; SalesOrderNoCaption)
            {
            }
            column(DocumentDateCaption1; DocumentDateCaption)
            {
            }
            column(MatriculaCaption1; MatriculaCaption)
            {
            }
            column(DriverName1; DriverName)
            {
            }
            column("RèglementCaption1"; RèglementCaption)
            {
            }
            column(RefCaption1; RefCaption)
            {
            }
            column(DescriptionCaption1; DescriptionCaption)
            {
            }
            column(QuantityCaption1; QuantityCaption)
            {
            }
            column(UnitPriceCaption1; UnitPriceCaption)
            {
            }
            column(ValorTotalExclIVA1; TotalLineLbl)
            {
            }
            column(ValorTotalExclIVA2; ValorTotalExclIVA)
            {
            }
            column(ValorIVACaption1; ValorIVACaption)
            {
            }
            column(DiscontoCaption1; DiscontoCaption)
            {
            }
            column(ValorTotalPagarCapt1; ValorTotalPagarCapt)
            {
            }
            column(TotalDepositoCap1; TotalDepositoCap)
            {
            }
            column(TotalFaturaCap1; TotalFaturaCap)
            {
            }
            column(TestCaption; TestCaption)
            {
            }
            column(HeaderText; HeaderText)
            {
            }
            column(No_SalesInvHdr; "No.")
            {
            }
            column(CopyText; CopyText)
            {
            }
            column(CurrencyCode_SalesInvoiceHeader; CurrencyText)
            {
            }
            column(SellToName; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(BilltoName; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(SellToAddr; "Sales Invoice Header"."Bill-to Address" + ' ' + "Sales Invoice Header"."Bill-to Post Code" + ' ' + "Sales Invoice Header"."Bill-to City")
            {
            }
            column(RespCenter; "Sales Invoice Header"."Responsibility Center" + '/' + Respcenter."Address 2")
            {
            }
            column(ExternalDocumentNo_SalesInvoiceHeader; "Sales Invoice Header"."External Document No.")
            {
            }
            column(Truck; Truck)
            {
            }
            column(Driver; Driver)
            {
            }
            column(ShipAgentCode; ShipAgentCode)
            {
            }
            column(SelltoCustNo_SalesInvHdr; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(PostingDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Posting Date"))
            {
            }
            column(VATRegNo_SalesInvHdr; "Sales Invoice Header"."VAT Registration No.")
            {
            }
            column(DueDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Due Date"))
            {
            }
            column(SalesPurchPersonName; SalesPurchPerson.Name)
            {
            }
            column(HdrOrderNo_SalesInvHdr; "Sales Invoice Header"."Order No.")
            {
            }
            column(InvoiceNo; FORMAT("Sales Invoice Header"."No."))
            {
            }
            column(DocDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Document Date"))
            {
            }
            column(OutputNo; OutputNo)
            {
            }
            column(PricesInclVATYesNo_SalesInvHdr; FORMAT("Sales Invoice Header"."Prices Including VAT"))
            {
            }
            column(PageCaption; PageCaptionCap)
            {
            }
            column(PaymentMethodAndTermsCode; PaymentTerms."Due Date Calculation")
            {
            }
            column(TotTransportAmt; TotTransportAmt)
            {
            }
            column(StampAmt; StampAmt)
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
            column(CompanyInfo_VatR; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_BankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfo_BankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyInfo_RegNo; CompanyInfo."Registration No.")
            {
            }
            column(CompanyInfo_IBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanyInfo_SwiftCode; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_FaxNo; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Respcenter1; RespcenterVar[1])
            {
            }
            column(Respcenter2; RespcenterVar[2])
            {
            }
            column(Respcenter3; RespcenterVar[3])
            {
            }
            column(Respcenter4; RespcenterVar[4])
            {
            }
            column(Respcenter5; RespcenterVar[5])
            {
            }
            column(NamePhone1; NamePhone[1])
            {
            }
            column(NamePhone2; NamePhone[2])
            {
            }
            column(NamePhone3; NamePhone[3])
            {
            }
            column(NamePhone4; NamePhone[4])
            {
            }
            column(NamePhone5; NamePhone[5])
            {
            }
            column(Phonecentre1; Phonecentre[1])
            {
            }
            column(Phonecentre2; Phonecentre[2])
            {
            }
            column(Phonecentre3; Phonecentre[3])
            {
            }
            column(Phonecentre4; Phonecentre[4])
            {
            }
            column(Phonecentre5; Phonecentre[5])
            {
            }
            column(NameFax1; NameFax[1])
            {
            }
            column(NameFax2; NameFax[2])
            {
            }
            column(NameFax3; NameFax[3])
            {
            }
            column(NameFax4; NameFax[4])
            {
            }
            column(NameFax5; NameFax[5])
            {
            }
            column(Faxcenter1; Faxcenter[1])
            {
            }
            column(Faxcenter2; Faxcenter[2])
            {
            }
            column(Faxcenter3; Faxcenter[3])
            {
            }
            column(Faxcenter4; Faxcenter[4])
            {
            }
            column(Faxcenter5; Faxcenter[5])
            {
            }
            column(UnitPriceDCC; UnitPriceDCC)
            {
            }
            column(ItemChrgDiscDescrTotal; ItemChrgDiscDescrTotal)
            {
            }
            column(Packaging; Packaging)
            {
            }
            column(PackSize; PackSize)
            {
            }
            column(TrackingText_Track; TrackingText)
            {
            }
            column(TrackingQty_Track; TrackingQty)
            {
            }
            column(SalesCommText; SalesCommText)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(TotalLbl; TotalLbl)
                    {
                    }
                    column(DiscountLbl; DiscountLbl)
                    {
                    }
                    column(SubTotFiniGoodsLbl; SubTotFiniGoodsLbl)
                    {
                    }
                    column(SubtotDepLbl; SubtotDepLbl)
                    {
                    }
                    column(DCLbl; DCLbl)
                    {
                    }
                    column(VATGoodsAndDCLbl; VATGoodsAndDCLbl)
                    {
                    }
                    column(TranspVATLbl; TranspVATLbl)
                    {
                    }
                    column(TotAmtLbl; TotAmtLbl)
                    {
                    }
                    column(TotHTLbl; TotHTLbl)
                    {
                    }
                    column(TranspHTLbl; TranspHTLbl)
                    {
                    }
                    column(TotTaxLbl; TotTaxLbl)
                    {
                    }
                    column(StampLbl; StampLbl)
                    {
                    }
                    column(TotGoodsInclVATLbl; TotGoodsInclVATLbl)
                    {
                    }
                    column(DepositLbl; DepositLbl)
                    {
                    }
                    column(NetToPayB4DepLbl; NetToPayB4DepLbl)
                    {
                    }
                    column(DeconsignationLbl; DeconsignationLbl)
                    {
                    }
                    column(NetToPayWithoutDepLbl; NetToPayWithoutDepLbl)
                    {
                    }
                    column(TotalTaxDC; TotalTaxDC)
                    {
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                        AutoFormatType = 1;
                    }
                    column(Footertext; Footertext)
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
                        column(Type; Type)
                        {
                        }
                        column(IsChargeItem; Type = Type::"Charge (Item)")
                        {
                        }
                        // column(SalesInvoiceLine_ItemChargeType; "Item Charge Type")//BC Upgrade KUMARR78 Blocking
                        // {
                        // }
                        column(SalesInvoiceLine_ItemChargeType; '')//BC Upgrade KUMARR78 Adding and Passing Blank Value
                        {
                        }
                        column(PrintUnderLineCharge; PrintUnderLineCharge)
                        {
                        }
                        column(VAT_SalesInvoiceLine; "VAT %")
                        {
                        }
                        column(LineAmount; LineAmount)
                        {
                        }
                        column(LineAmount_SalesInvoiceLine; "Line Amount")
                        {
                        }
                        column(Type_SalesInvoiceLine; Type)
                        {
                        }
                        column(No_SalesInvoiceLine; "No.")
                        {
                        }
                        column(Description_SalesInvoiceLine; Description)
                        {
                        }
                        column(UnitofMeasure_SalesInvoiceLine; "Unit of Measure Code")
                        {
                        }
                        column(UnitsperParcel_SalesInvoiceLine; "Units per Parcel")
                        {
                        }
                        column(Quantity_SalesInvoiceLine; Quantity)
                        {
                        }
                        column(UnitPrice_SalesInvoiceLine; UnitPrice)
                        {
                        }
                        column(Discount; FORMAT(Discount, 0, '<Precision,2:2><Standard Format,2>'))
                        {
                        }
                        column(ItemDepositNo; Item1."No.")
                        {
                        }
                        column(TotalDiscountPercentage; TotalDiscountPerc)
                        {
                        }

                        trigger OnAfterGetRecord();
                        var
                            ItemCharge: Record "Item Charge";
                            ItemCharge2: Record "Item Charge";
                            ItemCharge3: Record "Item Charge";
                            SalesChargeLine: Record "Sales Invoice Line";
                        begin
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
                            VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                            VATAmountLine.InsertLine();

                            //Discount Calculation
                            Discount := 0;
                            PorcDisc := 0;
                            TotalDiscount := 0; //HEI.07
                            TotalDiscountPerc := 0; //HEI.07
                            //LineAmount := "Line Amount"; //HEI.07 //HEI.12
                            UnitPrice := "Unit Price"; //HEI.08

                            //BC Upgrade KUMARR78>> DIT Field Removed
                            // SalesInvoiceLine.RESET;
                            // SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                            // SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
                            // SalesInvoiceLine.SETRANGE("Attached to Line No.", "Line No.");
                            // SalesInvoiceLine.SETRANGE("Item Charge Type", SalesInvoiceLine."Item Charge Type"::Discount);
                            // if SalesInvoiceLine.FINDSET then
                            //     repeat
                            //         //HEI.07>>
                            //         ItemCharge2.GET(SalesInvoiceLine."No.");
                            //         if (ItemCharge2."Show Item charge on Invoice" = ItemCharge2."Show Item charge on Invoice"::" ") or
                            //             (ItemCharge2."Show Item charge on Invoice" = ItemCharge2."Show Item charge on Invoice"::"Order total")
                            //         then begin
                            //             TotalDiscount += SalesInvoiceLine."Line Amount";
                            //             //LineAmount += - ABS(SalesInvoiceLine."Line Amount"); //HEI.08 //HEI.12
                            //         end;

                            //         ItemCharge3.GET(SalesInvoiceLine."No.");
                            //         if ItemCharge2."Show Item charge on Invoice" = ItemCharge2."Show Item charge on Invoice"::"Include in item price" then begin
                            //             //HEI.12>>
                            //             //LineAmount += - ABS(SalesInvoiceLine."Line Amount");
                            //             if SalesInvoiceLine."Opposite Qty. Sign" then
                            //                 UnitPrice += ABS(SalesInvoiceLine."Unit Price")
                            //             else
                            //                 //HEI.12<<
                            //                 UnitPrice += -ABS(SalesInvoiceLine."Unit Price"); //HEI.08
                            //         end;
                            //         //HEI.07<<
                            //         // FCE02-  Discount += SalesInvoiceLine."Line Amount";
                            //         Discount += TotalDiscount; // FCE02+
                            //     until SalesInvoiceLine.NEXT = 0;
                            //BC Upgrade KUMARR78 << DIT Field Removed
                            //New Total Amount Excl. VAT Calculation Logic
                            //HEI.12>>
                            LineAmount := ABS(UnitPrice * "Sales Invoice Line".Quantity);
                            //HEI.12<<

                            if Discount <> 0 then
                                PorcDisc := ROUND((ABS(Discount) / "Line Amount") * 100, 0.1);

                            //HEI.07>>
                            if TotalDiscount <> 0 then
                                TotalDiscountPerc := ROUND((ABS(TotalDiscount) / "Line Amount") * 100, 0.1);
                            //HEI.07<<

                            //HEI.07>>
                            //Discounts under item line
                            CLEAR(PrintUnderLineCharge);
                            SalesChargeLine.RESET();
                            SalesChargeLine.SETRANGE("Document No.", "Document No.");
                            SalesChargeLine.SETRANGE(Type, Type::"Charge (Item)");
                            // SalesChargeLine.SETRANGE("Item Charge Type", "Item Charge Type"::Discount);//BC Upgrade KUMARR78 << DIT Field Removed
                            SalesChargeLine.SETRANGE("Attached to Line No.", "Line No.");
                            if SalesChargeLine.FINDSET() then
                                repeat
                                    ItemCharge.GET(SalesChargeLine."No.");
                                    // if ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::"Under item line" then begin //BC Upgrade KUMARR78 << DIT Field Removed

                                    if not PrintUnderLineCharge then
                                        PrintUnderLineCharge := true;
                                    TempUnderChargeLine.INIT();
                                    TempUnderChargeLine := SalesChargeLine;
                                    TempUnderChargeLine.INSERT();
                                // FCE02-
                                // Not needed in the Total Discount+=SalesChargeLine.Amount;
                                // FCE02+
                                // end;//BC Upgrade KUMARR78 << Closing Loop DIT Field Removed
                                until (SalesChargeLine.NEXT() = 0);
                            //HEI.07<<

                            //<< IKH.IBM 20/10/16
                            EmptyGoodAmount := 0;
                            SalesInvoiceLine1.RESET();
                            SalesInvoiceLine1.SETRANGE("Document No.", "Document No.");
                            SalesInvoiceLine1.SETRANGE(Type, SalesInvoiceLine1.Type::"Charge (Item)");
                            // SalesInvoiceLine1.SETRANGE("Item Charge Type", SalesInvoiceLine1."Item Charge Type"::Deposit);//BC Upgrade KUMARR78 << DIT Field Removed
                            if SalesInvoiceLine1.FINDFIRST() then
                                repeat
                                    EmptyGoodAmount += SalesInvoiceLine1."Line Amount";
                                until SalesInvoiceLine1.NEXT() = 0;
                            //>> IKH.IBM 20/10/1

                            //DETERMINATION DU PRIX DE DROIT DE CONSOMMATION UNITAIRE
                            UnitPriceDCC := 0;
                            // SalesInvoiceLine.SETRANGE("Item Charge Type", "Item Charge Type"::Tax);//BC Upgrade KUMARR78 << DIT Field Removed
                            if SalesInvoiceLine.FINDSET() then begin
                                UnitPriceDCC := SalesInvoiceLine."Unit Price";
                                TotalTaxDC += SalesInvoiceLine."Line Amount";
                                TotalDC += "Line Amount";
                            end;

                            TempTrackingSpecification.RESET();
                            Tmpp := ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Invoice Line", 0, "Sales Invoice Header"."No."
                            , '', 0, "Sales Invoice Line"."Line No.");

                            // DocTrackingManagement.CallPostedItemTracking3(Tmpp, TempTrackingSpecification); //BC UPGRADE KUMARR78 DIT Variable Removed

                            if TempTrackingSpecification.FINDSET() then
                                repeat
                                    TempTrackingSpecification.Quantity := ROUND(TempTrackingSpecification.Quantity / "Qty. per Unit of Measure", 0.00001);
                                    TempTrackingSpecification.MODIFY();
                                until TempTrackingSpecification.NEXT() = 0;

                            DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                            DimSetEntry.SETRANGE("Dimension Code", 'I3 - PACKAGING');
                            if DimSetEntry.FINDFIRST() then
                                Packaging := DimSetEntry."Dimension Value Code";
                            DimSetEntry.SETRANGE("Dimension Code", 'I4 - PACK SIZE');
                            if DimSetEntry.FINDFIRST() then
                                PackSize := DimSetEntry."Dimension Value Code";

                            TotLineAmt += ("Line Amount" + Discount);

                            CLEAR(VATPerc);
                            CLEAR(VATAmount);
                            CLEAR(VATBase);
                            TotalTax := 0;
                            VATAmountLine.SETRANGE("VAT %", 18);
                            if VATAmountLine.FINDSET() then
                                repeat
                                    VATPerc[1] := VATAmountLine."VAT %";
                                    VATAmount[1] += VATAmountLine."VAT Amount";
                                    VATBase[1] += VATAmountLine."VAT Base";
                                    TotalTax += VATAmountLine."VAT Amount";
                                until VATAmountLine.NEXT() = 0;

                            VATAmountLine.SETRANGE("VAT %", 12);
                            if VATAmountLine.FINDSET() then
                                repeat
                                    VATPerc[2] := VATAmountLine."VAT %";
                                    VATAmount[2] += VATAmountLine."VAT Amount";
                                    VATBase[2] += VATAmountLine."VAT Base";
                                    TotalTax += VATAmountLine."VAT Amount";
                                until VATAmountLine.NEXT() = 0;
                            VATAmountLine.RESET();
                            //TotalTax += TotalTaxDC;

                            TotGoodsWithVAT := TotLineAmt + TotalTax + StampAmt + TotTransportAmt;
                            NetTot2Pay := TotLineAmtDeposit + TotGoodsWithVAT;

                            MntLettres := '';
                            MontantEnTexte(MntLettres, TotLineAmt + TotLineAmtDeposit + StampAmt + TotalTax + VATBase[2]);
                            //soica
                            TotalAmt := VATAmountLine.GetTotalVATBase();
                            TotalwithVAT := VATAmountLine.GetTotalAmountInclVAT();
                            TotalVatAmt := VATAmountLine.GetTotalVATAmount();
                        end;

                        trigger OnPreDataItem();
                        begin
                            VATAmountLine.DELETEALL();
                            TotLineAmt := 0;
                            TotalTaxDC := 0;
                            TotalDC := 0;
                            NetTot2Pay := 0;
                            TotLineAmtDeposit := 0;
                            TotGoodsWithVAT := 0;
                            TotalPay := 0;
                            MoreLines := FIND('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                                MoreLines := NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");
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
                        column(UnderChargeLine_VAT; TempUnderChargeLine."VAT %")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            //HEI.07>>
                            if Number = 1 then
                                TempUnderChargeLine.FINDFIRST()
                            else
                                TempUnderChargeLine.NEXT();
                            //HEI.07<<
                        end;

                        trigger OnPostDataItem();
                        begin
                            //HEI.07>>
                            TempUnderChargeLine.RESET();
                            TempUnderChargeLine.DELETEALL();
                            //HEI.07<<
                        end;

                        trigger OnPreDataItem();
                        begin
                            //HEI.07>>
                            TempUnderChargeLine.RESET();
                            SETRANGE(Number, 1, TempUnderChargeLine.COUNT);
                            //HEI.07<<
                        end;
                    }
                    dataitem(SalesInvoiceLinesDeposit; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        // DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending) WHERE(Type = FILTER('"Charge (Item)"'), "Item Charge Type" = FILTER(Deposit), Quantity = FILTER(<> 0));//BC UPGRADE KUMARR78 DIT Field Removed and Changed Expression("Item Charge Type","Charge (Item)")
                        DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending) WHERE(Type = FILTER("Charge (Item)"), Quantity = FILTER(<> 0));//BC UPGRADE KUMARR78 DIT Field Removed and Expression changed for("Item Charge Type","Charge (Item)")

                        column(Deposit_No; "No.")
                        {
                        }
                        column(Deposit_Description; Description)
                        {
                        }
                        column(EmptyGoodsItemNo; EmptyGoodsItemNo)
                        {
                        }
                        column(EmptyGoodsItemDescr; EmptyGoodsItemDescr)
                        {
                        }
                        column(EmptyGoodsItemBaseUOM; EmptyGoodsItemBaseUOM)
                        {
                        }
                        column(Quantity_DepositLines; SalesInvoiceLinesDeposit.Quantity)
                        {
                        }
                        column(UnitPrice_DepositLines; SalesInvoiceLinesDeposit."Unit Price")
                        {
                        }
                        column(VAT_DepositLines; SalesInvoiceLinesDeposit."VAT %")
                        {
                        }
                        column(LineAmount_DepositLines; SalesInvoiceLinesDeposit."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }

                        trigger OnAfterGetRecord();
                        var
                            ItemCharge: Record "Item Charge";
                        begin
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
                            VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                            VATAmountLine.InsertLine();

                            ItemCharge.GET("No."); //HEI.03

                            //BC UPGRADE KUMARR78>> DIT Field Removed
                            // if ("Item Charge Type" <> "Item Charge Type"::Deposit) and
                            //    not (ItemCharge."Show Item charge on Invoice" in [ItemCharge."Show Item charge on Invoice"::" ",
                            //        ItemCharge."Show Item charge on Invoice"::"Order total"]) //HEI.03
                            // then
                            //     CurrReport.SKIP();
                            //BC UPGRADE KUMARR78<< DIT Field Removed

                            // EmptyGoodsItemNo := "Empty Goods Item No."; //BC UPGRADE KUMARR78<< DIT Field Removed
                            // if Item.GET("Empty Goods Item No.") then begin //BC UPGRADE KUMARR78<< DIT Field Removed
                            EmptyGoodsItemDescr := Item.Description;
                            EmptyGoodsItemBaseUOM := Item."Base Unit of Measure";
                            // end; //BC UPGRADE KUMARR78<< Closing Loop for Begin
                            EmptyGoodAmount += SalesInvoiceLinesDeposit."Line Amount";

                            TotalVatAmt := VATAmountLine.GetTotalVATAmount(); //HEI.03
                        end;

                        trigger OnPreDataItem();
                        begin
                            MoreLines := FIND('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                                MoreLines := NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");
                            EmptyGoodAmount := 0;
                            EmptyGoodsItemNo := '';
                            EmptyGoodsItemDescr := '';
                            EmptyGoodsItemBaseUOM := '';
                        end;
                    }
                    dataitem(VAT; "Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(VATPerc1; VATPerc[1])
                        {
                        }
                        column(VATAmount1; VATAmount[1])
                        {
                        }
                        column(VATBase1; VATBase[1])
                        {
                        }
                        column(VATPerc2; VATPerc[2])
                        {
                        }
                        column(VATPerc3; VATPerc[3])
                        {
                        }
                        column(VATAmount2; VATAmount[2])
                        {
                        }
                        column(VATBase2; VATBase[2])
                        {
                        }
                        column(VATAmount3; VATAmount[3])
                        {
                        }
                        column(VATBase3; VATBase[3])
                        {
                        }
                        column(TotalTax; TotalTax)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(MntLettres; MntLettres)
                        {
                        }
                        column(TotLineAmtDeposit; TotLineAmtDeposit)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotLineAmt; TotalPay)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotGoodsWithVAT; TotGoodsWithVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(NetTot2Pay; NetTot2Pay + EmptyGoodAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }

                        trigger OnPreDataItem();
                        begin
                            CLEAR(VATPerc);
                            CLEAR(VATAmount);
                            CLEAR(VATBase);
                            TotalTax := 0;
                            VATAmountLine.SETRANGE("VAT %", 18);
                            if VATAmountLine.FINDSET() then
                                repeat
                                    VATPerc[1] := VATAmountLine."VAT %";
                                    VATAmount[1] += VATAmountLine."VAT Amount";
                                    VATBase[1] += VATAmountLine."VAT Base";
                                    TotalTax += VATAmountLine."VAT Amount";
                                until VATAmountLine.NEXT() = 0;

                            VATAmountLine.SETRANGE("VAT %", 12);
                            if VATAmountLine.FINDSET() then
                                repeat
                                    VATPerc[2] := VATAmountLine."VAT %";
                                    VATAmount[2] += VATAmountLine."VAT Amount";
                                    VATBase[2] += VATAmountLine."VAT Base";
                                    TotalTax += VATAmountLine."VAT Amount";
                                until VATAmountLine.NEXT() = 0;
                            VATAmountLine.RESET();
                            TotalTax += TotalTaxDC;

                            TotGoodsWithVAT := TotLineAmt + TotalTax + StampAmt + TotTransportAmt;
                            TotalPay := TotLineAmt + EmptyGoodAmount;
                            NetTot2Pay := TotLineAmtDeposit + TotGoodsWithVAT;

                            //HEI.04>>
                            if "Sales Invoice Header"."Prices Including VAT" then begin
                                TotalAmtInclVAT := TotalPay;
                                TotalAmtExclVAT := TotalPay - TotalVatAmt;
                            end else begin
                                TotalAmtInclVAT := TotalPay + TotalVatAmt;
                                TotalAmtExclVAT := TotalPay;
                            end;
                            //HEI.04<<

                            MntLettres := '';
                            if CurrReport.LANGUAGE = 1033 then begin
                                RepCheck.InitTextVariable();
                                RepCheck.FormatNoText(AmountLetters, TotLineAmt + TotLineAmtDeposit + StampAmt + TotalTax + VATBase[2] + EmptyGoodAmount, '');
                                MntLettres := AmountLetters[1] + AmountLetters[2];
                            end else
                                MontantEnTexte(MntLettres, TotLineAmt + TotLineAmtDeposit + StampAmt + TotalTax + VATBase[2] + EmptyGoodAmount);
                        end;
                    }
                    dataitem("Integer"; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1));
                        column(TotalAmt; FORMAT(TotalAmt, 0, '<Precision,2:2><Standard Format,2>'))
                        {
                        }
                        column(TotalVatAmt; FORMAT(TotalVatAmt, 0, '<Precision,2:2><Standard Format,2>'))
                        {
                        }
                        column(TotalwithVAT; FORMAT(TotalwithVAT, 0, '<Precision,2:2><Standard Format,2>'))
                        {
                        }
                        column(CompanyInformationBankName; "Company Information"."Bank Name")
                        {
                        }
                        column(CompanyInformationBankAccountNo; "Company Information"."Bank Account No.")
                        {
                        }
                        column(CompanyInformationSWIFTCode; "Company Information"."SWIFT Code")
                        {
                        }
                        column(CompanyInformationIBAN; "Company Information".IBAN)
                        {
                        }
                        column(TotalLineAmount; FORMAT(TotalAmtInclVAT, 0, '<Precision,2:2><Standard Format,2>'))
                        {
                        }
                        column(TotalLineAmountExclVat; FORMAT(TotalAmtExclVAT, 0, '<Precision,2:2><Standard Format,2>'))
                        {
                        }
                        column(EmptyGoodAmount; FORMAT(EmptyGoodAmount, 0, '<Precision,2:2><Standard Format,2>'))
                        {
                        }
                    }
                }

                trigger OnAfterGetRecord();
                begin

                    //<<Below Field Deposit is not available in the resp tabe  NAIKH01
                    /*IF (Number > 1) OR (("Sales Invoice Header"."No. Printed" > 0))
                        AND ((PrintOriginal = FALSE) OR ((PrintOriginal = TRUE) AND (UserSetup."Print Original Report" = FALSE))) THEN BEGIN
                        CopyText := 'DUPLICATA';
                      //OutputNo += 1;
                    END;
                    */
                    /*HEI.02 comment
                    IF Number > 1 THEN BEGIN
                      CopyText := 'DUPLICATA';
                      //OutputNo += 1;
                      Footertext := Text011 // FCE01-+
                    END ELSE BEGIN
                      CopyText := '';
                      */
                    //HEI.01<<
                    //END;

                    //>>HEI.02
                    if (Number > 1) or (("Sales Invoice Header"."No. Printed" > 0)) then
                        Footertext := Text011
                    else
                        Footertext := 'Original';
                    //<<HEI.02


                    CurrReport.PAGENO := 1;

                    TotalSubTotal := 0;
                    TotalInvDiscAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscOnVAT := 0;

                end;

                trigger OnPostDataItem();
                begin
                    if not CurrReport.PREVIEW then
                        SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;

                trigger OnPreDataItem();
                begin
                    //NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);

                    OutputNo := 1;

                    //HEI.01>>
                    /*
                    IF "Sales Invoice Header"."No. Printed" > 0 THEN
                      Footertext := Text011
                    ELSE
                      Footertext := 'Original';  //HEI.02
                    */
                    //HEI.01<<

                end;
            }

            trigger OnAfterGetRecord();
            var
                Cust1: Record Customer;
                ItemCharge: Record "Item Charge";
                ItemChargeLines: Record "Sales Invoice Line";
            begin
                // >>HEI.09
                if LangCode = '' then
                    LangCode := "Sales Invoice Header"."Language Code";
                // <<HEI.09
                //CurrReport.LANGUAGE := Language.GetLanguageID(LangCode);

                if Respcenter.GET("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, Respcenter);
                    CompanyInfo."Phone No." := Respcenter."Phone No.";
                    CompanyInfo."Fax No." := Respcenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                if "Order No." = '' then
                    OrderNoText := ''
                else
                    OrderNoText := FIELDCAPTION("Order No.");
                if "Salesperson Code" = '' then begin
                    SalesPurchPerson.INIT();
                    SalesPersonText := '';
                end else begin
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                end;
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FIELDCAPTION("Your Reference");

                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                    CurrencyText := GLSetup."LCY Code";
                end else begin
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                    CurrencyText := "Currency Code";
                end;
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");


                if not Cust.GET("Bill-to Customer No.") then
                    CLEAR(Cust);

                //>>HEI.02

                //CompanyInfo.GET;
                DomesticInv := (("Ship-to Country/Region Code" = CompanyInfo."Country/Region Code") or ("Ship-to Country/Region Code" = 'MZ') or ("Ship-to Country/Region Code" = ''));

                if DomesticInv then
                    // CurrReport.Language := Language.GetLanguageID(LangCode); //BC Upgrade KUMARR78 GetlanguageId moved from Table to CU.
                    CurrReport.Language := LanguageG.GetLanguageId(LangCode) //BC Upgrade KUMARR78 GetlanguageId moved from Table to CU.

                else
                    CurrReport.LANGUAGE := 1033;

                //<<HEI.02

                //<< Below Field Deposit is not available in the resp tabe  NAIKH01
                /*IF Respcenter.Deposit THEN
                  HeaderText := ConsignationCaptionLbl
                ELSE
                  HeaderText := InvoiceCaptionLbl;*/
                //<<

                Driver := '';
                Truck := '';
                ShipAgentCode := '';
                SalesShipmentHeader.RESET();
                SalesShipmentHeader.SETRANGE("Order No.", "Order No.");
                if SalesShipmentHeader.FINDLAST() then begin
                    PostedWhseShipLine.RESET();
                    PostedWhseShipLine.SETRANGE("Posted Source No.", SalesShipmentHeader."No.");
                    if PostedWhseShipLine.FINDFIRST() then begin
                        PostedWhseShipHeader.RESET();
                        PostedWhseShipHeader.SETRANGE("No.", PostedWhseShipLine."No.");
                        if PostedWhseShipHeader.FINDLAST() then begin
                            //BC UPGRADE KUMARR78>> DIT Field Removed
                            // if WhseShipTruck.GET(PostedWhseShipHeader."Truck Code") then 
                            // Truck := WhseShipTruck.Description;
                            // if WhseShipDriver.GET(PostedWhseShipHeader."Driver Code") then
                            // Driver := WhseShipDriver.Description;
                            //BC UPGRADE KUMARR78 <<DIT Field Removed
                            ShipAgentCode := PostedWhseShipHeader."Shipping Agent Code";
                        end;
                    end;
                end;

                //Transport amount Calculation
                TotTransportAmt := 0;
                SalesInvoiceLine.RESET();
                SalesInvoiceLine.SETRANGE("Document No.", "No.");
                SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
                // SalesInvoiceLine.SETRANGE("Item Charge Type", SalesInvoiceLine."Item Charge Type"::Discount);//BC UPGRADE KUMARR78 DIT Field Removed
                SalesInvoiceLine.SETRANGE("No.", 'TRANSPORT');
                if SalesInvoiceLine.FINDSET() then
                    repeat
                        TotTransportAmt += SalesInvoiceLine."Line Amount";
                    until SalesInvoiceLine.NEXT() = 0;

                StampAmt := 0;
                //<<Below Field Deposit is not available in the resp tabe  NAIKH01
                /*IF "Fiscal Stamp"=TRUE  THEN
                  StampAmt := "Stamp Amount";*/
                //<< IKH.IBM 20/10/16

                //BC UPGRADE KUMARR78>> DIT Field Removed
                // SalesInvoiceLine1.RESET();
                // SalesInvoiceLine1.SETRANGE("Document No.", "No.");
                // SalesInvoiceLine1.SETRANGE(Type, SalesInvoiceLine1.Type::"Charge (Item)");
                // SalesInvoiceLine1.SETRANGE("Item Charge Type", SalesInvoiceLine1."Item Charge Type"::Deposit);
                // if SalesInvoiceLine1.FINDFIRST() then
                //     repeat
                //         if Item1.GET(SalesInvoiceLine1."Empty Goods Item No.") then;
                //     until SalesInvoiceLine1.NEXT() = 0;

                //BC UPGRADE KUMARR78<< DIT Field Removed
                //>> IKH.IBM 20/10/16

                //HEI.02>>
                SalesCommLine.SETRANGE("Document Type", SalesCommLine."Document Type"::"Posted Invoice");
                SalesCommLine.SETRANGE("No.", "Sales Invoice Header"."No.");
                // SalesCommLine.SETRANGE("Print on Invoice", true); //BC UPGRADE KUMARR78 DIT Field Removed
                if SalesCommLine.FINDSET() then begin
                    repeat
                        SalesCommText := SalesCommText + SalesCommLine.Comment
                      until SalesCommLine.NEXT() = 0;
                end;
                SalesCommText := COPYSTR(SalesCommText, 1, 50);
                //HEI.02<<

                //HEI.04>>
                if "Prices Including VAT" then
                    TotalLineLbl := ValorTotalInclIVA
                else
                    TotalLineLbl := ValorTotalExclIVA;

                if PaymentTerms.GET("Sales Invoice Header"."Payment Terms Code") then;
                //HEI.04<<

                //HEI.08>>
                HideDiscount := 0;
                ItemChargeLines.SETRANGE("Document No.", "No.");
                ItemChargeLines.SETRANGE(Type, ItemChargeLines.Type::"Charge (Item)");
                // ItemChargeLines.SETRANGE("Item Charge Type", ItemChargeLines."Item Charge Type"::Discount); //BC UPGRADE KUMARR78 DIT Field Removed
                if ItemChargeLines.FINDSET() then
                    repeat
                        ItemCharge.GET(ItemChargeLines."No.");
                        // if ItemCharge."Show Item charge on Invoice" <> ItemCharge."Show Item charge on Invoice"::"Include in item price" then//BC UPGRADE KUMARR78 DIT Field Removed
                        HideDiscount += 1;
                    until ItemChargeLines.NEXT() = 0;
                //HEI.08<<

            end;

            trigger OnPreDataItem();
            begin
                i := 0;
                if Respcenter.FINDSET() then
                    repeat
                        i += 1;
                        NamePhone[i] := FORMAT('Tel:');
                        NameFax[i] := '- Fax:';
                        RespcenterVar[i] := Respcenter.Code;
                        Phonecentre[i] := Respcenter."Phone No.";
                        Faxcenter[i] := Respcenter."Fax No.";
                        RCAddress2 := Respcenter."Address 2";
                    until Respcenter.NEXT() = 0;

                //BC UPGRADE KUMARR78>> DIT Field Removed
                // CLEAR(SalesDepositItemCharge1);
                // SalesDepositItemCharge1.SETRANGE("Source Type", 0);
                // SalesDepositItemCharge1.SETRANGE("Source No.", '704-002');
                // if SalesDepositItemCharge1.FINDLAST then;
                // CLEAR(SalesDepositItemCharge2);
                // SalesDepositItemCharge2.SETRANGE("Source Type", 0);
                // SalesDepositItemCharge2.SETRANGE("Source No.", '704-003');
                // if SalesDepositItemCharge2.FINDLAST then;
                // CLEAR(SalesDepositItemCharge3);
                // SalesDepositItemCharge3.SETRANGE("Source Type", 0);
                // SalesDepositItemCharge3.SETRANGE("Source No.", '705-001');
                // if SalesDepositItemCharge3.FINDLAST then;
                //BC UPGRADE KUMARR78 <<DIT Field Removed
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(LangCode; LangCode)
                {
                    Caption = 'Local Language Code';
                    ApplicationArea = all; //BC UPGRADE KUMARR78 Adding ApplicationArea
                    LookupPageID = Languages;
                    TableRelation = Language;
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            "Company Information".GET();
            // >>HEI.09
            //LangCode := "Company Information"."Language Code";
            // <<HEI.09
        end;
    }

    labels
    {
        label(SeatCaption; ENU = 'Seat',
                          FRA = 'Siège')
        label(CaptialSocialCaption; ENU = 'Capital Sociall',
                                   FRA = 'Captial Social')
        label(VATRegistrationNum; ENU = 'VAT Registration No.:',
                                 FRA = 'Matricule Fiscale:',
                                 PTB = 'NUIT:',
                                 PTG = 'NUIT:')
        RCCaption = 'Número de Registo Comercial'; label(CodeincustomsCaption; ENU = 'Code in Customs',
                                                                             FRA = 'Code en Douane ')
        label(TeleCaption; ENU = 'Tel.:',
                          FRA = 'Tel.:')
        FaxCaption = '/  Fax:'; label(EmailCaption; ENU = 'Email:',
                                                  PTB = 'Email:',
                                                  PTG = 'Email:')
        label(FactoryCaption; ENU = 'Fßbrica',
                             FRA = 'Usine')
        label(INVOICECaption; ENU = 'INVOICE',
                             FRA = 'FACTURE',
                             PTB = 'FATURA',
                             PTG = 'FATURA')
        label(InvoiceNoCaption; ENU = 'Invoice No.',
                               FRA = 'Numero.',
                               PTB = 'Fatura No.',
                               PTG = 'Fatura No.')
        label(DateCaption; ENU = 'Date',
                          PTB = 'Data',
                          PTG = 'Data')
        label(CustomerCodeCaption; ENU = 'Customer No.:',
                                  FRA = 'Code:',
                                  PTB = 'Codigo do Cliente :',
                                  PTG = 'Codigo do Cliente :')
        label(CustomerNameCaption; ENU = 'Customer Name:',
                                  FRA = 'Nom:',
                                  PTB = 'Nome do Cliente:',
                                  PTG = 'Nome do Cliente:')
        label(AddressCaption; ENU = 'Address:',
                             PTB = 'Enderço:',
                             PTG = 'Enderço:')
        MFCaption = 'NUIT:'; label(DepositCaption; ENU = ' DepÝsito :',
                                                 FRA = 'Dépôt''')
        label(SalesOrderNoCaption; ENU = 'Sales Order No.',
                                  FRA = 'N° BC',
                                  PTB = 'Ordem de Venda',
                                  PTG = 'Ordem de Venda')
        label(DocumentDateCaption; ENU = 'Document Date',
                                  PTB = 'Data do Documento',
                                  PTG = 'Data do Documento')
        label(RegistrationIDCaption; ENU = 'Número de Registo',
                                    FRA = 'Véhicule')
        label(DriverName; ENU = 'Driver Name',
                         FRA = 'Livreur',
                         PTB = 'Nome do Motorista')
        label(ShippingAgentCodeCaption; ENU = 'Shipping Agent Code',
                                       FRA = 'Transporteur')
        label("RèglementCaption"; ENU = 'Payment Method',
                                 PTB = 'Prazo de Pagamento',
                                 PTG = 'Prazo de Pagamento')
        label(PaymentMethodCodeCaption; ENU = 'Payment Method Code',
                                       FRA = 'Règlement''')
        PaymentTermsCodeCaption = 'Payment Terms Code'; label(ProductCaption; ENU = 'Produto',
                                                                            FRA = 'Produit')
        label(QuantityCaption; ENU = 'Qty',
                              FRA = 'Quantité',
                              PTB = 'Qtd',
                              PTG = 'Qtd')
        label(AmountCaption; ENU = 'Valor',
                            FRA = 'Montant')
        label(RefCaption; ENU = 'Crt. No.',
                         PTB = 'Ref',
                         PTG = 'Ref')
        label(DescriptionCaption; ENU = 'Description',
                                 FRA = 'Désignation',
                                 PTB = 'Descrição',
                                 PTG = 'Descrição')
        label(UnitCaption; ENU = 'Unidade/ Cada',
                          FRA = 'Unité')
        label(QEXPCAption; ENU = 'Quantidade Expedida',
                          FRA = 'Q.LIV')
        label(QREMCaption; ENU = 'Quantidade Recebida',
                          FRA = 'Q.REST')
        label(QINVCaption; ENU = 'Quantidade Facturada',
                          FRA = 'Q.FAC')
        label(UPHTCaption; ENU = 'Preço Unitario Líquido de IVA',
                          FRA = 'PU HT')
        label(DiscCaption; ENU = 'Desc % (percentage de desconto)',
                          FRA = '% Rem')
        label(ToTWITHOUTDCVATCaption; ENU = 'Valor Total Líquido de Taxas Aduaneiras e IVA',
                                     FRA = 'ToT Hors DC &TVA')
        label(DCUnitCaption; ENU = 'Taxas Aduaneiras por Unidade',
                            FRA = 'DC/Unité')
        label(VATCaption; ENU = 'IVA',
                         FRA = 'TVA')
        label(NetAmountHTVACAption; ENU = 'Valor Liquido de IVA',
                                   FRA = 'Montant Net.HTVA')
        TotalCaption = 'Total'; label(SubtotalFinishedGoodCaption; ENU = 'Subtotal Finished Good:',
                                                                 FRA = 'Sous-Total Produit Fini::')
        label(SubtotalDepositCaption; ENU = 'Sub Total Depósito',
                                     FRA = 'Sous-Total consignation')
        label(TaxtypeCaption; ENU = 'Tipo de Taxa/ imposto',
                             FRA = 'Type de taxe')
        label(RateCaption; ENU = 'Taxa',
                          FRA = 'Taux')
        label(VATBaseCaption; ENU = 'Base de IVA',
                             FRA = 'Base TVA')
        label(TaxAmountCaption; ENU = 'valor de imposto',
                               FRA = 'Montant Taxe')
        label(DCCaption; ENU = 'DC',
                        FRA = 'Droit Consom HT')
        label(VATgoodDC; ENU = 'VAT good+DC',
                        FRA = 'TVA Produit+DC')
        label(TransportVATCaption; ENU = 'Transport VAT',
                                  FRA = 'TVA Transport')
        label(TotalAmountCaption; ENU = 'Valor Total',
                                 FRA = 'Montant Total')
        TotalHTCaption = 'Valor Total de Transporte Liquido de IVA'; TransportHTCaption = 'Valor Total de Transporte Liquido de IVA'; TotalTaxCaption = 'Total de Imposto'; label(StampCaption; ENU = 'Carimbo/ Selo',
                                                                                                                                                                                            FRA = 'TIMBRE')
        label(FooterCaption; ENU = 'Recebido neste factura o valor de',
                            FRA = 'Arrêtée la présente facture à la somme de : ')
        label(AlltaxCompries; ENU = '(All tax Compries)',
                             FRA = '(Toutes taxes Compries)')
        label(DischargeClientCaption; ENU = 'Discharge Client',
                                     FRA = 'Decharge Client')
        SignatureCaption = 'Assinatura'; label(NetToPayCaption; ENU = 'Valor Líquido a pagar',
                                                              FRA = 'NET à payer')
        label(ToTalAmount; ENU = 'Total Amount',
                          FRA = 'Montant total')
        ProcessedByComp = 'Processado por computador.'; label(LblExternalDocNo; ENU = 'External Document No.',
                                                                              PTB = 'Número do Documento Externo:',
                                                                              PTG = 'Número do Documento Externo:')
        label(LblReasonForExport; ENU = 'Reason for Export',
                                 PTB = 'Razão para Exportar:',
                                 PTG = 'Razão para Exportar:')
        label(LblCurrCode; ENU = 'Currency Code',
                          PTB = 'Moeda',
                          PTG = 'Moeda')
        label(LblName; ENU = 'Name:',
                      PTB = 'Nome:',
                      PTG = 'Nome:')
        label(BankCaption; ENU = 'Bank Name:',
                          PTB = 'Banco:',
                          PTG = 'Banco:')
        label(BankAccNo; ENU = 'Bank Account No.:',
                        PTB = 'Conta-Corrente nr.:',
                        PTG = 'Conta-Corrente nr.:')
        label(MatriculaCaption; ENU = 'Registration No',
                               PTB = 'Matricula',
                               PTG = 'Matricula')
        label(MotorName; ENU = 'Driver Name',
                        PTB = 'Nome do Motorista',
                        PTG = 'Nome do Motorista')
        label(UnitPriceCaption; ENU = 'Unit Price',
                               PTB = 'Preço Unitario',
                               PTG = 'Preço Unitario')
        label(ValorTotalExclIVA; ENU = 'Total Amount Excl. VAT',
                                PTB = 'Valor Total Excl.ICA',
                                PTG = 'Valor Total Excl.ICA')
        label(ValorTotalInclIVA; ENU = 'Total Amount Incl. VAT',
                                PTB = 'Valor Total Incl.ICA',
                                PTG = 'Valor Total Incl.ICA')
        label(ValorIVACaption; ENU = 'VAT Amount',
                              PTB = 'Valor IVA',
                              PTG = 'Valor IVA')
        label(DiscontoCaption; ENU = 'Discount',
                              PTB = 'Disconto',
                              PTG = 'Disconto')
        label(ValorTotalPagarCapt; ENU = 'Total Amount to Pay',
                                  PTB = 'Valor Total a pagar',
                                  PTG = 'Valor Total a pagar')
        label(TotalDepositoCap; ENU = 'Total Deposit',
                               PTB = 'Total Deposito',
                               PTG = 'Total Deposito')
        label(TotalFaturaCap; ENU = 'Total Invoice',
                             PTB = 'Total Fatura',
                             PTG = 'Total Fatura')
        label(Lbltest; ENU = 'english',
                      FRA = 'french')
        TotalDepositsLbl = 'Desposit Charges'; IbanLbl = 'IBAN:'; SwiftCodeLbl = 'Swift Code:';
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        SalesSetup.GET();
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);
    end;

    trigger OnPreReport();
    var
        I: Integer;
    begin
        if not UserSetup.GET(USERID) then
            UserSetup.INIT();
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        "Company Information": Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        DimSetEntry: Record "Dimension Set Entry";
        TempDiscountLines: Record "Finance Charge Terms" temporary;
        GLSetup: Record "General Ledger Setup";
        Item: Record Item;
        Item1: Record Item;
        TempDepositLines: Record Item temporary;
        TempTrackingSpecification: Record "Item Ledger Entry" temporary;
        // Language: Record Language; //BC UPGRADE KUMARR78 Blocking Codeunit as Function Moved from Record to Codeunit.
        LanguageG: Codeunit Language;//BC UPGRADE KUMARR78 Adding Codeunit as Function Moved from Record to Codeunit.

        PaymentTerms: Record "Payment Terms";
        PostedWhseShipHeader: Record "Posted Whse. Shipment Header";
        PostedWhseShipLine: Record "Posted Whse. Shipment Line";
        Respcenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesCommLine: Record "Sales Comment Line";
        //BC UPGRADE KUMARR78>> DIT Variable
        // SalesDepositItemCharge1: Record "Sales Deposit Item Charge";
        // SalesDepositItemCharge2: Record "Sales Deposit Item Charge";
        // SalesDepositItemCharge3: Record "Sales Deposit Item Charge";
        // SalesDepositItemCharge4: Record "Sales Deposit Item Charge";
        // SalesDepositItemCharge5: Record "Sales Deposit Item Charge";
        // SalesDepositItemCharge6: Record "Sales Deposit Item Charge";
        // SalesDepositItemCharge7: Record "Sales Deposit Item Charge";
        // SalesDepositItemCharge8: Record "Sales Deposit Item Charge";
        //BC UPGRADE KUMARR78 <<DIT Variable 
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvoiceLine1: Record "Sales Invoice Line";
        TempUnderChargeLine: Record "Sales Invoice Line" temporary;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        SalesShipmentHeader: Record "Sales Shipment Header";
        UserSetup: Record "User Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        VATClause: Record "VAT Clause";

        //BC UPGRADE KUMARR78 >> DIT Variable Removed
        // WhseShipDriver: Record "Whse. Shipping Driver";
        // WhseShipTruck: Record "Whse. Shipping Truck";
        // DocTrackingManagement: Codeunit "Document Tracking Management";
        //BC UPGRADE KUMARR78 << DIT Variable Removed
        RepCheck: Report Check;
        FormatAddr: Codeunit "Format Address";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        Continue: Boolean;
        DomesticInv: Boolean;
        MoreLines: Boolean;
        PrintOriginal: Boolean;
        PrintUnderLineCharge: Boolean;
        ShowDiscLine: Boolean;
        ShowShippingAddr: Boolean;
        LangCode: Code[10];
        ShipAgentCode: Code[10];
        UOMEmptyGoodsItem: Code[10];
        EmptyGoodsItemNo: Code[20];
        Packaging: Code[20];
        PackSize: Code[20];
        RespcenterVar: array[50] of Code[20];
        PostedShipmentDate: Date;
        "Amount HVAT": Decimal;
        "Amount Transport": Decimal;
        CalculatedExchRate: Decimal;
        Discount: Decimal;
        EmptyGoodAmount: Decimal;
        LineAmount: Decimal;
        NetTot2Pay: Decimal;
        PorcDisc: Decimal;
        StampAmt: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalAmt: Decimal;
        TotalAmtExclVAT: Decimal;
        TotalAmtInclVAT: Decimal;
        TotalDC: Decimal;
        "Total DC1": Decimal;
        TotalDiscount: Decimal;
        TotalDiscountPerc: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPay: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TotalSubTotal: Decimal;
        TotalTax: Decimal;
        "Total tax": Decimal;
        "TOTAL TAX1": Decimal;
        TotalTaxDC: Decimal;
        "Total Tax DC1": Decimal;
        TotalVatAmt: Decimal;
        TotalwithVAT: Decimal;
        TotGoodsWithVAT: Decimal;
        TotLineAmt: Decimal;
        TotLineAmtDeposit: Decimal;
        TotTransportAmt: Decimal;
        TrackingQty: Decimal;
        UnitPrice: Decimal;
        UnitPriceDCC: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: array[3] of Decimal;
        VATBase: array[3] of Decimal;
        VATPerc: array[3] of Decimal;
        decimal: Integer;
        entiere: Integer;
        FirstValueEntryNo: Integer;
        HideDiscount: Integer;
        i: Integer;
        nbre: Integer;
        nbre1: Integer;
        NextEntryNo: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        EmailCaption: Label 'Email:';
        Text011: Label 'Copia';
        EmptyGoodsItemBaseUOM: Text;
        EmptyGoodsItemDescr: Text;
        Footertext: Text;
        chaine1: Text[30];
        CopyText: Text[30];
        HeaderText: Text[30];
        NameFax: array[50] of Text[30];
        NamePhone: array[50] of Text[30];
        SalesPersonText: Text[30];
        "Type tax1": Text[30];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        DescrEmptyGoodsItem: Text[50];
        Driver: Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalLineLbl: Text[50];
        TotalText: Text[50];
        TrackingText: Text[50];
        Truck: Text[50];
        VALExchRate: Text[50];
        Faxcenter: array[50] of Text[60];
        Phonecentre: array[50] of Text[60];
        OldDimText: Text[75];
        AmountLetters: array[2] of Text[80];
        OrderNoText: Text[80];
        ReferenceText: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        DimText: Text[120];
        MntLettres: Text[200];
        cent: Text[250];
        ItemChrgDiscDescrTotal: Text[250];
        mille: Text[250];
        million: Text[250];
        RCAddress2: Text[250];
        Tmpp: Text[250];
        CurrencyText: Text[1000];
        SalesCommText: Text[1000];
        AddressCaption: TextConst ENU = 'Address:', FRA = 'Enderço:', PTB = 'Enderço:', PTG = 'Enderço:';
        AmountCaptionLbl: TextConst ENU = 'Amount', FRA = 'Montant';
        BankAccNo: TextConst ENU = 'Bank Account No.:', PTB = 'Conta-Corrente nr.:', PTG = 'Conta-Corrente nr.:';
        BankCaption: TextConst ENU = 'Bank Name:', PTB = 'Banco:', PTG = 'Banco:';
        CompanyInfoBankAccNoCptnLbl: TextConst ENU = 'Account No.', FRA = 'N° compte';
        CompanyInfoBankNameCptnLbl: TextConst ENU = 'Bank', FRA = 'Banque';
        CompanyInfoGiroNoCaptionLbl: TextConst ENU = 'Giro No.', FRA = 'N° CCP';
        CompanyInfoPhoneNoCaptionLbl: TextConst ENU = 'Phone No.', FRA = 'N° téléphone';
        CompanyInfoVATRegNoCptnLbl: TextConst ENU = 'NUIT', FRA = 'N° de société';
        ConsignationCaptionLbl: TextConst ENU = 'BON DE CONSIGNATION', FRA = 'BON DE CONSIGNATION';
        CustomerCodeCaption: TextConst ENU = 'Customer No.:', PTB = 'Codigo do Cliente :', PTG = 'Codigo do Cliente :';
        CustomerNameCaption: TextConst ENU = 'Customer Name:', PTB = 'Nome do Cliente:', PTG = 'Nome do Cliente:';
        CustomerSignatureLbl: TextConst ENU = 'Customer Signature', FRA = 'Customer Signature', PTB = 'Assinatura Cliente', PTG = 'Assinatura Cliente';
        DateCaption: TextConst ENU = 'Date', PTB = 'Data', PTG = 'Data';
        DCLbl: TextConst ENU = 'DC', FRA = 'Droit Consom HT';
        DeconsignationLbl: TextConst ENU = 'Deconsignation', FRA = 'Deconsignation';
        DepositLbl: TextConst ENU = 'Deposit', FRA = 'CONSIGNATION', PTB = 'Deposito', PTG = 'Deposito';
        DescriptionCaption: TextConst ENU = 'Description', FRA = 'Descrição', PTB = 'Descrição', PTG = 'Descrição';
        DiscontoCaption: TextConst ENU = 'Discount', FRA = 'Disconto', PTB = 'Desconto', PTG = 'Desconto';
        DiscountLbl: TextConst ENU = 'DISCOUNT', FRA = 'REMISE';
        DocumentDateCaption: TextConst ENU = 'Document Date', FRA = 'Data do Documento', PTB = 'Data do Documento', PTG = 'Data do Documento';
        DocumentDateCaptionLbl: TextConst ENU = 'Document Date', FRA = 'Date document';
        DriverName: TextConst ENU = 'Driver Name', FRA = 'Nome do Motorista', PTB = 'Nome do Motorista', PTG = 'Nome do Motorista';
        EMailCaptionLbl: TextConst ENU = 'E-Mail', FRA = 'E-mail';
        HeaderDimCaptionLbl: TextConst ENU = 'Header Dimensions', FRA = 'Analytique en-tête';
        HomePageCaptionCap: TextConst ENU = 'Home Page', FRA = 'Page d''accueil';
        InvDiscBaseAmtCaptionLbl: TextConst ENU = 'Invoice Discount Base Amount', FRA = 'Montant base remise facture';
        InvDiscountAmtCaptionLbl: TextConst ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
        InvNoCaptionLbl: TextConst ENU = 'Invoice No.', FRA = 'N° facture';
        INVOICECaption: TextConst ENU = 'INVOICE', PTB = 'FATURA', PTG = 'FATURA';
        InvoiceCaptionLbl: TextConst ENU = 'INVOICE', FRA = 'FACTURE';
        InvoiceNoCaption: TextConst ENU = 'Invoice No.', PTB = 'Fatura No.', PTG = 'Fatura No.';
        LblCurrCode: TextConst ENU = 'Currency Code', PTB = 'Moeda', PTG = 'Moeda';
        LblExternalDocNo: TextConst ENU = 'External Document No.', PTB = 'Número do Documento Externo:', PTG = 'Número do Documento Externo:';
        LblName: TextConst ENU = 'Name:', FRA = 'Nome:', PTB = 'Nome:', PTG = 'Nome:';
        LineAmtAfterInvDiscCptnLbl: TextConst ENU = 'Payment Discount on VAT', FRA = 'Escompte sur TVA';
        LineAmtCaptionLbl: TextConst ENU = 'Line Amount', FRA = 'Montant ligne';
        LineDimCaptionLbl: TextConst ENU = 'Line Dimensions', FRA = 'Analytique ligne';
        MatriculaCaption: TextConst ENU = 'Registration No.', FRA = 'Matricula', PTB = 'Matricula', PTG = 'Matricula';
        NetToPayB4DepLbl: TextConst ENU = 'Net To Pay Before Deposit', FRA = 'Net à payer avant Déc.';
        NetToPayWithoutDepLbl: TextConst ENU = 'Net to Pay Without Deposit', FRA = 'Net à payer après Déc.';
        PageCaptionCap: TextConst ENU = 'Page %1 of %2', FRA = 'Page %1 de %2';
        PaymentTermsDescCaptionLbl: TextConst ENU = 'Payment Terms', FRA = 'Conditions de paiement';
        PostedShipmentDateCaptionLbl: TextConst ENU = 'Posted Shipment Date', FRA = 'Date expédition validée';
        ProcessedByComputerLbl: TextConst ENU = 'Processed by computer - Microsoft Navision', FRA = 'Processed by computer - Microsoft Navision', PTB = 'Processado por computador – Microsoft Navision', PTG = 'Processado por computador – Microsoft Navision';
        QuantityCaption: TextConst ENU = 'Qty', FRA = 'Qtd', PTB = 'Qtd', PTG = 'Qtd';
        RefCaption: TextConst ENU = 'Ref.', FRA = 'Ref', PTB = 'Ref', PTG = 'Ref';
        "RèglementCaption": TextConst ENU = 'Payment Terms', FRA = 'Prazo de Pagamento', PTB = 'Prazo de Pagamento', PTG = ' Prazo de Pagamento';
        SalesInvDueDateCaptionLbl: TextConst ENU = 'Due Date', FRA = 'Date d''échéance';
        SalesInvLineDiscCaptionLbl: TextConst ENU = 'Discount %', FRA = '% remise';
        SalesInvPostingDateCptnLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilisation';
        SalesOrderNoCaption: TextConst ENU = 'Sales Order No.', FRA = 'Ordem de Venda', PTB = 'Ordem de Venda', PTG = 'Ordem de Venda';
        ShipmentCaptionLbl: TextConst ENU = 'Shipment', FRA = 'Expédition';
        ShiptoAddrCaptionLbl: TextConst ENU = 'Ship-to Address', FRA = 'Adresse destinataire';
        ShptMethodDescCaptionLbl: TextConst ENU = 'Shipment Method', FRA = 'Conditions de livraison';
        SignatureLbl: TextConst ENU = 'Signature', FRA = 'Signature', PTB = 'Assinatura', PTG = 'Assinatura';
        StampLbl: TextConst ENU = 'Stamp', FRA = 'Timbre';
        SubtotalCaptionLbl: TextConst ENU = 'Subtotal', FRA = 'Sous-total';
        SubtotDepLbl: TextConst ENU = 'Subtotal DepÝsito', FRA = 'Sous-Total consignation';
        SubTotFiniGoodsLbl: TextConst ENU = 'Subtotal finished good', FRA = 'Sous-Total Produit Fini';
        TestCaption: TextConst ENU = 'english', FRA = 'french';
        Text000: TextConst ENU = 'Salesperson', FRA = 'Vendeur';
        Text001: TextConst ENU = 'Total %1', FRA = 'Total %1';
        Text002: TextConst ENU = 'Total %1 Incl. VAT', FRA = 'Total %1 TTC';
        Text003: TextConst ENU = 'COPY', FRA = 'COPIE';
        Text004: TextConst ENU = 'Sales - Invoice %1', FRA = 'Ventes : Facture %1';
        Text006: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 HT';
        Text007: TextConst ENU = 'VAT Amount Specification in ', FRA = 'Détail TVA dans ';
        Text008: TextConst ENU = 'Local Currency', FRA = 'Devise société';
        Text009: TextConst ENU = 'Exchange rate: %1/%2', FRA = 'Taux de change : %1/%2';
        Text010: TextConst ENU = 'Sales - Prepayment Invoice %1', FRA = 'Ventes - Facture acompte %1';
        TotalCaptionLbl: TextConst ENU = 'Total', FRA = 'Total';
        TotalDepositoCap: TextConst ENU = 'Total Deposit', FRA = 'Total Deposito', PTB = 'Total de Deposito', PTG = 'Total de Deposito';
        TotalFaturaCap: TextConst ENU = 'Total Invoice', FRA = 'Total Fatura', PTB = 'Total da Factura', PTG = 'Total da Factura';
        TotalLbl: TextConst ENU = 'Total', FRA = 'Total';
        TotAmtLbl: TextConst ENU = 'Total Amount', FRA = 'Montant Total';
        TotGoodsInclVATLbl: TextConst ENU = 'TOTAL GOODS with VAT', FRA = 'TOTAL PROD TTC';
        TotHTLbl: TextConst ENU = 'TOTAL HT', FRA = 'TOTAL HT';
        TotTaxLbl: TextConst ENU = 'TOTAL TAX', FRA = 'TOTAl TAXES';
        TranspHTLbl: TextConst ENU = 'Transport HT', FRA = 'Transport HT';
        TranspVATLbl: TextConst ENU = 'Transport VAT', FRA = 'TVA Transport';
        UnitPriceCaption: TextConst ENU = 'Unit Price', FRA = 'Preço Unitario', PTB = 'Preço Unitario', PTG = 'Preço Unitario';
        UnitPriceCaptionLbl: TextConst ENU = 'Unit Price', FRA = 'Prix unitaire';
        ValorIVACaption: TextConst ENU = 'VAT', FRA = 'Valor IVA', PTB = 'Valor IVA', PTG = 'Valor IVA';
        ValorTotalExclIVA: TextConst ENU = 'Total Amount Excl. VAT', FRA = 'Valor Total Excl.IVA', PTB = 'Valor Total Excl.IVA', PTG = 'Valor Total Excl.IVA';
        ValorTotalInclIVA: TextConst ENU = 'Total Amount Incl. VAT', FRA = 'Valor Total Incl.IVA', PTB = 'Valor Total Incl.IVA', PTG = 'Valor Total Incl.IVA';
        ValorTotalPagarCapt: TextConst ENU = 'Total Amount to Pay', FRA = 'Valor Total a pagar', PTB = 'Valor Total a pagar', PTG = 'Valor Total a pagar';
        VATAmtCaptionLbl: TextConst ENU = 'VAT Amount', FRA = 'Montant TVA';
        VATAmtSpecificationCptnLbl: TextConst ENU = 'VAT Amount Specification', FRA = 'Détail montant TVA';
        VATBaseCaptionLbl: TextConst ENU = 'VAT Base', FRA = 'Base TVA';
        VATClausesCap: TextConst ENU = 'VAT Clause', FRA = 'Clause TVA';
        VATGoodsAndDCLbl: TextConst ENU = 'VAT goods+DC', FRA = 'TVA Produit+DC';
        VATIdentifierCaptionLbl: TextConst ENU = 'VAT Identifier', FRA = 'Identifiant TVA';
        VATPercentageCaptionLbl: TextConst ENU = 'VAT %', FRA = '% TVA';
        VATRegistrationNum: TextConst ENU = 'VAT Registration No.:', PTB = 'NUIT:', PTG = 'NUIT:';

    procedure MontantEnTexte(var strprix: Text[250]; prix: Decimal);
    begin
        entiere := ROUND(prix, 1, '<');
        decimal := ROUND((prix - entiere) * 1000, 1, '<');

        nbre := entiere;
        //Chèque.FormatNumTexte(strprix,nbre);

        million := '';
        mille := '';
        cent := '';

        nbre1 := nbre div 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;

        nbre := nbre mod 1000000;
        nbre1 := nbre div 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre mod 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' dinars';
        if entiere = 1 then
            strprix := strprix + ' dinar';

        cent := '';
        if decimal <> 0 then begin
            Centaine(cent, decimal);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if decimal = 1 then
                strprix := strprix + ' millime'
            else
                strprix := strprix + ' millimes';
        end;

        strprix := UPPERCASE(strprix);
    end;

    procedure Centaine(var chaine: Text[250]; i: Integer);
    var
        k: Integer;
    begin
        k := i div 100;
        chaine := '';
        case k of
            1:
                chaine := 'cent';
            2:
                chaine := 'deux cent';
            3:
                chaine := 'trois cent';
            4:
                chaine := 'quatre cent';
            5:
                chaine := 'cinq cent';
            6:
                chaine := 'six cent';
            7:
                chaine := 'sept cent';
            8:
                chaine := 'huit cent';
            9:
                chaine := 'neuf cent';
        end;
        k := i mod 100;
        Dizaine(chaine, k);
    end;

    procedure Dizaine(var chaine: Text[250]; i: Integer);
    var
        k: Integer;
        l: Integer;
    begin
        if i > 16 then begin
            k := i div 10;
            chaine1 := '';
            case k of
                1:
                    chaine1 := 'dix';
                2:
                    chaine1 := 'vingt';
                3:
                    chaine1 := 'trente';
                4:
                    chaine1 := 'quarante';
                5:
                    chaine1 := 'cinquante';
                6:
                    chaine1 := 'soixante';
                7:
                    chaine1 := 'soixante';
                8:
                    chaine1 := 'quatre vingt';
                9:
                    chaine1 := 'quatre vingt';
            end;
            if ((chaine1 <> '') and (chaine <> '')) then
                chaine1 := ' ' + chaine1;
            chaine := chaine + chaine1;
            l := k;
            if ((k = 7) or (k = 9)) then
                k := (i mod 10) + 10
            else
                k := (i mod 10);
        end
        else
            k := i;

        if ((l <> 8) and (l <> 0) and ((k = 1) or (k = 11))) then
            chaine := chaine + ' et';
        if (((k = 0) or (k > 16)) and ((l = 7) or (l = 9))) then begin
            chaine := chaine + ' dix';
            if k > 16 then
                k := k - 10;
        end;

        Unité(chaine, k);
    end;

    procedure "Unité"(var chaine: Text[250]; i: Integer);
    begin
        chaine1 := '';
        case i of
            1:
                chaine1 := 'un';
            2:
                chaine1 := 'deux';
            3:
                chaine1 := 'trois';
            4:
                chaine1 := 'quatre';
            5:
                chaine1 := 'cinq';
            6:
                chaine1 := 'six';
            7:
                chaine1 := 'sept';
            8:
                chaine1 := 'huit';
            9:
                chaine1 := 'neuf';
            10:
                chaine1 := 'dix';
            11:
                chaine1 := 'onze';
            12:
                chaine1 := 'douze';
            13:
                chaine1 := 'treize';
            14:
                chaine1 := 'quatorze';
            15:
                chaine1 := 'quinze';
            16:
                chaine1 := 'seize';
        end;
        if ((chaine1 <> '') and (chaine <> '')) then
            chaine1 := ' ' + chaine1;
        chaine := chaine + chaine1;
    end;

    procedure MontantEnTexteSansMillimes(var strprix: Text[250]; prix: Decimal);
    begin
        entiere := ROUND(prix, 1, '<');
        decimal := ROUND((prix - entiere) * 1000, 1, '<');

        nbre := entiere;
        //Chèque.FormatNumTexte(strprix,nbre);

        million := '';
        mille := '';
        cent := '';

        nbre1 := nbre div 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;

        nbre := nbre mod 1000000;
        nbre1 := nbre div 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre mod 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' dinars';
        if entiere = 1 then
            strprix := strprix + ' dinar';

        if decimal <> 0 then begin
            if strprix <> '' then
                strprix := strprix + ' ' + FORMAT(decimal)
            else
                strprix := strprix + FORMAT(decimal);
            if decimal = 1 then
                strprix := strprix + ' millime'
            else
                strprix := strprix + ' millimes';
        end;

        strprix := UPPERCASE(strprix);
    end;
}

