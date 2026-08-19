report 53057 "Sales - Credit Memo MOZ"
{
    // version HEI.06

    // HEI.01 IBM.NAIKH01 16.07.2018 FDD-MZ-LOGGAP001_SalesCreditMemo_Domestic_v0.3commented
    //   # Created a new report copy of the standard report 207.
    //   # Added new text in the Report footer
    //   # Added Field "External Document No." on report
    // 07-09-2018 FCE  changed "Credit Memo" into "Credit Note" in ENU langiage
    // 07-09-2018 FCE  Included the percentage of the VAT identifier instead of the Code
    // 
    // HEI.02 # Bugfixing Mozambique IBM NASTAA02 07.09.2018 # Invoices for Mozambique
    //   # Changed margins, Preview Mode to 'Printlayout'
    //   # Removed Home Page, Bank and Account No. from header
    //   # Added '%' sign to the VAT in the lines
    //   # Removed Ship-to Address block
    //   # Changed places between Totals Including/Excluding VAT
    // 
    // HEI.03 # Bugfixing Mozambique IBM NASTAA02 10.09.2018 # Invoices for Mozambique
    //   # Added Total Deposits
    // 
    // HEI.04 # Bugfixing Mozambique IBM NASTAA02 05.10.2018 # Invoices for Mozambique
    //   # Discount should be printed based on "Show Item Charge on Invoice" field
    //   # For Option ' ' (blank) and 'Order Total' discount will be transformed in Disc Percentage and shown in column Disc %
    //   # For Option 'Under Item Line' Discount will be printed under the Item Line
    //   # For Option 'Include in Item Price' Discount will deducted from the Line Amount and from Unit Price and Disc % column will be empty
    // 
    // HEI.05 # Bugfixing Mozambique IBM NASTAA02 20.11.2018 # Deposits are dubled
    //   # Created temp record to store the Deposit entries
    //   # Created new DataItem for the totals
    //   # Removed grouping on "Line No." from layout
    // 
    // HEI.06 # Bugfixing Mozambique IBM NASTAA02 20.11.2018 # Deposits are dubled
    //   # Sales Credit Memo Lines with the next filters shold not be displayed:
    //     "Type" = Item, "Has Item Charges" = YES, "Unit Price Excl.VAT" = 0 and "Empty Goods" from Item table = YES.
    // 
    // HEI.07 CHG2079696 IBM SAMANR01 09-16-2020
    //   # Add code for fix the report language issue

    // BC Upgrade KUMARR78 >>
    // Report Name  : Sales - Credit Memo MOZ
    // Report ID    : 50150
    //
    // 1. Added Business Central visibility properties.
    //    Old:
    //         - ApplicationArea not mandatory in NAV.
    //         - UsageCategory not defined.
    //    New:
    //         - ApplicationArea = All
    //         - UsageCategory = ReportsAndAnalysis
    //
    // 2. Replaced Language record with Codeunit (GetLanguageId moved in BC).
    //    Old:
    //         Language: Record Language;
    //         CurrReport.Language := Language.GetLanguageID(LangCode);
    //    New:
    //         LanguageG: Codeunit Language;
    //         CurrReport.Language := LanguageG.GetLanguageId(LangCode);
    //         - Function GetLanguageId moved from table to Codeunit in BC.
    //         - Avoids conflict with standard Language datatype.
    //
    // 3. Blocked DIT-specific fields in HEI.06 logic (Empty Goods / Has Item Charge).
    //    Old:
    //         Item2.CALCFIELDS("Empty Good");
    //         CALCFIELDS("Has Item Charge");
    //         ShowItemWithItemCharge := (Type = Type::Item) and
    //                                   ("Unit Price" = 0) and
    //                                   "Has Item Charge" and
    //                                   Item2."Empty Good";
    //    New:
    //         - "Empty Good" and "Has Item Charge" logic commented.
    //         - ShowItemWithItemCharge forced FALSE.
    //         - Line visibility controlled without DIT dependency.
    //
    // 4. Removed DIT "Item Charge Type" logic (Discount / Deposit).
    //    Old:
    //         SETRANGE("Item Charge Type", Discount);
    //         SETRANGE("Item Charge Type", Deposit);
    //         Conditional logic based on "Item Charge Type".
    //    New:
    //         - All "Item Charge Type" filters commented.
    //         - Charge handling based only on:
    //              • Type = "Charge (Item)"
    //              • Document No.
    //              • Attached to Line No.
    //         - No DIT-based classification used.
    //
    // 5. Removed DIT field "Show Item charge on Invoice".
    //    Old:
    //         Conditional checks:
    //              • "Include in item price"
    //              • "Under item line"
    //              • "Order total"
    //    New:
    //         - All related conditions commented.
    //         - Under-line charges printed based on existence of charge lines only.
    //         - Discount visibility simplified (HideDiscount counter retained).
    //
    // 6. Removed DIT Empty Goods reference in Deposit section.
    //    Old:
    //         "Empty Goods Item No."
    //         Item.GET("Empty Goods Item No.")
    //         "Item Charge Type" validation for Deposit
    //    New:
    //         - All Empty Goods references commented.
    //         - Deposit lines collected without DIT field validation.
    //         - EmptyGoodAmount accumulated from Line Amount only.
    //
    // 7. Updated SegManagement function (Field renamed in BC).
    //    Old:
    //         SegManagement.FindInteractTmplCode(6)
    //    New:
    //         SegManagement.FindInteractionTemplateCode(6)
    //         - Updated function name as per BC standard.
    //
    // 8. Ensured BC-compliant ApplicationArea on Request Page field.
    //    Old:
    //         LangCode without ApplicationArea.
    //    New:
    //         ApplicationArea = All added to LangCode field.
    //
    // 9. Preserved RDLC layout compatibility.
    //     Old:
    //         - Layout dependent on discount, deposit and VAT columns.
    //     New:
    //         - Dataset structure unchanged.
    //         - Unsupported DIT fields commented instead of removed.
    //
    // BC Upgrade KUMARR78 <<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Sales - Credit Memo MOZ.rdl';
    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding Usagecategory

    CaptionML = ENU = 'Sales - Credit Memo',
                FRA = 'Ventes : Avoir';
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeadingML = ENU = 'Posted Sales Credit Memo',
                                     FRA = 'Avoir vente enregistré';
            column(HideDiscount; HideDiscount = 0)
            {
            }
            column(No_SalesCrMemoHeader; "No.")
            {
            }
            column(VATAmtLineVATCptn; VATAmtLineVATCptnLbl)
            {
            }
            column(VATAmtLineVATBaseCptn; VATAmtLineVATBaseCptnLbl)
            {
            }
            column(VATAmtLineVATAmtCptn; VATAmtLineVATAmtCptnLbl)
            {
            }
            column(VATAmtLineVATIdentifierCptn; VATAmtLineVATIdentifierCptnLbl)
            {
            }
            column(TotalCptn; TotalCptnLbl)
            {
            }
            column(SalesCrMemoLineDiscCaption; SalesCrMemoLineDiscCaptionLbl)
            {
            }
            column(UnitPriceCptn; UnitPriceCptnLbl)
            {
            }
            column(AmountCptn; AmountCptnLbl)
            {
            }
            column(PostedReceiptDateCptn; PostedReceiptDateCptnLbl)
            {
            }
            column(InvDiscAmt_SalesCrMemoLineCptn; InvDiscAmt_SalesCrMemoLineCptnLbl)
            {
            }
            column(SubtotalCptn; SubtotalCptnLbl)
            {
            }
            column(LineAmtInvDiscAmt_SalesCrMemoLineCptn; LineAmtInvDiscAmt_SalesCrMemoLineCptnLbl)
            {
            }
            column(Desc_SalesCrMemoLineCaption; DescriptionLbl)
            {
            }
            column(No_SalesCrMemoLineCaption; ItemNoLbl)
            {
            }
            column(Qty_SalesCrMemoLineCaption; QuantityLbl)
            {
            }
            column(UOM_SalesCrMemoLineCaption; UoMLbl)
            {
            }
            column(VATIdentif_SalesCrMemoLineCaption; VATAmtLineVATIdentifierCptnLbl)
            {
            }
            column(TotalText; TotalText)
            {
            }
            column(TotalExclVATText; ValorTotalExclIVA)
            {
            }
            column(TotalInclVATText; ValorTotalInclIVA)
            {
            }
            column(VATAmtLineVATAmtTxt; VATAmtLineVATAmtCptnLbl)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(DocCptnCopyTxt; STRSUBSTNO(DocumentCaption(), CopyText))
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostDate_SalesCrMemoHeader; FORMAT("Sales Cr.Memo Header"."Posting Date", 0, 4))
                    {
                    }
                    column(VATNoText; CompanyInfoVATRegNoCptnLbl)
                    {
                    }
                    column(VATRegNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."VAT Registration No.")
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(AppliedToText; AppliedToText)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_SalesCrMemoHeader; "Sales Cr.Memo Header"."Your Reference")
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(DocDt_SalesCrMemoHeader; FORMAT("Sales Cr.Memo Header"."Document Date", 0, 4))
                    {
                    }
                    column(PriceInclVAT_SalesCrMemoHeader; "Sales Cr.Memo Header"."Prices Including VAT")
                    {
                    }
                    column(ReturnOrderNoText; ReturnOrderNoText)
                    {
                    }
                    column(ReturnOrdNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Return Order No.")
                    {
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo; FORMAT("Sales Cr.Memo Header"."Prices Including VAT"))
                    {
                    }
                    column(VATBaseDiscPrc_SalesCrMemoLine; "Sales Cr.Memo Header"."VAT Base Discount %")
                    {
                    }
                    column(CompanyInfoPhoneNoCptn; CompanyInfoPhoneNoCptnLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCptn; CompanyInfoVATRegNoCptnLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCptn; CompanyInfoGiroNoCptnLbl)
                    {
                    }
                    column(CompanyInfoBankNameCptn; CompanyInfoBankNameCptnLbl)
                    {
                    }
                    column(CompanyInfoBankAccNoCptn; CompanyInfoBankAccNoCptnLbl)
                    {
                    }
                    column(No1_SalesCrMemoHeaderCptn; No1_SalesCrMemoHeaderCptnLbl)
                    {
                    }
                    column(SalesCrMemoHeaderPostDtCptn; SalesCrMemoHeaderPostDtCptnLbl)
                    {
                    }
                    column(DocumentDate; DocumentDateLbl)
                    {
                    }
                    column(CompanyInfoHomePageCaption; CompanyInfoHomePageCaptionLbl)
                    {
                    }
                    column(CompanyINfoEmailCaption; CompanyINfoEmailCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeaderCaption; CustomerCodeCaption)
                    {
                    }
                    column(PriceInclVAT_SalesCrMemoHeaderCaption; PricesInclVATLbl)
                    {
                    }
                    column(ExternalDocNoLbl; ExternalDocNoLbl)
                    {
                    }
                    column(External_Doc_No_SalesCrMemoHdr; "Sales Cr.Memo Header"."External Document No.")
                    {
                    }
                    column(Text012; Text012)
                    {
                    }
                    column(FooterText; FooterText)
                    {
                    }
                    column(TotalDepositoCap; TotalDepositoCap)
                    {
                    }
                    column(DiscontoCaption1; DiscontoCaption)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1Num; Number)
                        {
                        }
                        column(HeaderDimCptn; HeaderDimCptnLbl)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FINDSET() then
                                    CurrReport.BREAK();
                            end else
                                if not Continue then
                                    CurrReport.BREAK();

                            CLEAR(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.NEXT() = 0;
                        end;

                        trigger OnPreDataItem();
                        begin
                            if not ShowInternalInfo then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(ShowItemWithItemCharge; HideLine)
                        {
                        }
                        column(LineNo_SalesCrMemoLine; "Line No.")
                        {
                        }
                        column(No_SalesCrMemoLine; "No.")
                        {
                        }
                        column(Desc_SalesCrMemoLine; Description)
                        {
                        }
                        column(Qty_SalesCrMemoLine; Quantity)
                        {
                        }
                        column(UnitPrice_SalesCrMemoLine; UnitPrice)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 2;
                        }
                        column(LineAmount; LineAmount)
                        {
                        }
                        column(LineAmt_SalesCrMemoLine; "Line Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(UOM_SalesCrMemoLine; "Unit of Measure")
                        {
                        }
                        column(Discount; Discount)
                        {
                        }
                        column(TotalDiscountPercentage; TotalDiscountPerc)
                        {
                        }
                        column(Disc_SalesCrMemoLine; "Line Discount %")
                        {
                        }
                        column(VATIdentif_SalesCrMemoLine; "VAT Identifier")
                        {
                        }
                        column(PostedReceiptDate; FORMAT(PostedReceiptDate))
                        {
                        }
                        column(Type_SalesCrMemoLine; FORMAT(Type))
                        {
                        }
                        column(InvDiscAmt_SalesCrMemoLine; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Amt_SalesCrMemoLine; Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(LineAmtInvDiscAmt_SalesCrMemoLine; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATPercentage; "VAT %")
                        {
                        }

                        trigger OnAfterGetRecord();
                        var
                            Item2: Record Item;
                            ItemCharge: Record "Item Charge";
                            ItemCharge2: Record "Item Charge";
                            ItemCharge3: Record "Item Charge";
                            SalesChargeLine: Record "Sales Cr.Memo Line";
                            SalesInvoiceLine: Record "Sales Cr.Memo Line";
                            SalesLineDeposit: Record "Sales Cr.Memo Line";
                            ShowItemWithItemCharge: Boolean;
                        begin
                            //HEI.06>>
                            HideLine := false;
                            ShowItemWithItemCharge := false;
                            if Type = Type::Item then begin
                                Item2.GET("No.");
                                //BC Upgrade KUMARR78>> DIT Field Blocked
                                // Item2.CALCFIELDS("Empty Good");
                                // CALCFIELDS("Has Item Charge");
                                // ShowItemWithItemCharge := (Type = Type::Item) and ("Unit Price" = 0) and "Has Item Charge" and Item2."Empty Good";
                                //BC Upgrade KUMARR78<< DIT Field Blocked(("Empty Good","Has Item Charge")
                                if ShowItemWithItemCharge then
                                    HideLine := true
                                else
                                    HideLine := false;
                            end else if Type = Type::"Charge (Item)" then
                                    HideLine := true
                            else
                                HideLine := false;
                            //HEI.06<<

                            NNC_TotalLineAmount += "Line Amount";
                            NNC_TotalAmountInclVat += "Amount Including VAT";
                            NNC_TotalInvDiscAmount += "Inv. Discount Amount";
                            NNC_TotalAmount += Amount;

                            SalesShipmentBuffer.DELETEALL();
                            PostedReceiptDate := 0D;
                            if Quantity <> 0 then
                                PostedReceiptDate := FindPostedShipmentDate();

                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then
                                "No." := '';

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

                            //HEI.03>>
                            // if (Type = Type::"Charge (Item)") and ("Item Charge Type" = "Item Charge Type"::Deposit) then//BC Upgrade KUMARR78>> DIT Field Blocked
                            TotalDeposit += "Line Amount";
                            //HEI.03<<

                            //HEI.04>>
                            //Discount Calculation
                            Discount := 0;
                            PorcDisc := 0;
                            TotalDiscount := 0;
                            TotalDiscountPerc := 0;
                            LineAmount := "Line Amount";
                            UnitPrice := "Unit Price";
                            //BC Upgrade KUMARR78>> DIT Field Blocked
                            // SalesInvoiceLine.RESET();
                            // SalesInvoiceLine.SETRANGE("Document No.", "Document No.");
                            // SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
                            // SalesInvoiceLine.SETRANGE("Attached to Line No.", "Line No.");
                            // SalesInvoiceLine.SETRANGE("Item Charge Type", SalesInvoiceLine."Item Charge Type"::Discount);
                            // if SalesInvoiceLine.FINDSET() then
                            //     repeat
                            //         ItemCharge2.GET(SalesInvoiceLine."No.");
                            //         if (ItemCharge2."Show Item charge on Invoice" = ItemCharge2."Show Item charge on Invoice"::" ") or
                            //             (ItemCharge2."Show Item charge on Invoice" = ItemCharge2."Show Item charge on Invoice"::"Order total")
                            //         then begin
                            //             TotalDiscount += SalesInvoiceLine."Line Amount";
                            //             LineAmount += -ABS(SalesInvoiceLine."Line Amount");
                            //         end;
                            //         ItemCharge3.GET(SalesInvoiceLine."No.");
                            //         if ItemCharge2."Show Item charge on Invoice" = ItemCharge2."Show Item charge on Invoice"::"Include in item price" then begin
                            //             LineAmount += -ABS(SalesInvoiceLine."Line Amount");
                            //             UnitPrice += -ABS(SalesInvoiceLine."Unit Price");
                            //         end;

                            //         //Discount += SalesInvoiceLine."Line Amount";
                            //         Discount += TotalDiscount;
                            //         DiscountTotal += TotalDiscount; //HEI.05
                            //     until SalesInvoiceLine.NEXT() = 0;
                            //BC Upgrade KUMARR78<< DIT Field Blocked("Item Charge Type","Show Item charge on Invoice")

                            if Discount <> 0 then
                                PorcDisc := ROUND((ABS(Discount) / "Line Amount") * 100, 0.1);

                            if TotalDiscount <> 0 then
                                TotalDiscountPerc := ROUND((ABS(TotalDiscount) / "Line Amount") * 100, 0.1);

                            //Discounts under item line
                            CLEAR(PrintUnderLineCharge);
                            SalesChargeLine.RESET();
                            SalesChargeLine.SETRANGE("Document No.", "Document No.");
                            SalesChargeLine.SETRANGE(Type, Type::"Charge (Item)");
                            // SalesChargeLine.SETRANGE("Item Charge Type", "Item Charge Type"::Discount);//BC Upgrade KUMARR78>> DIT Field Blocked
                            SalesChargeLine.SETRANGE("Attached to Line No.", "Line No.");
                            if SalesChargeLine.FINDSET() then
                                repeat
                                    ItemCharge.GET(SalesChargeLine."No.");
                                    // if ItemCharge."Show Item charge on Invoice" = ItemCharge."Show Item charge on Invoice"::"Under item line" then begin//BC Upgrade KUMARR78>> DIT Field Blocked("Show Item charge on Invoice")
                                    if not PrintUnderLineCharge then
                                        PrintUnderLineCharge := true;
                                    TempUnderChargeLine.INIT();
                                    TempUnderChargeLine := SalesChargeLine;
                                    TempUnderChargeLine.INSERT();

                                    Discount += SalesChargeLine.Amount;
                                    DiscountTotal += SalesChargeLine.Amount; //HEI.05
                                                                             // end;//BC Upgrade KUMARR78>> DIT Field Blocked
                                until SalesChargeLine.NEXT() = 0;
                            //HEI.04<<

                            //HEI.05>>
                            //Deposits
                            SalesLineDeposit.RESET();
                            SalesLineDeposit.SETRANGE("Document No.", "Document No.");
                            SalesLineDeposit.SETRANGE(Type, Type::"Charge (Item)");
                            // SalesLineDeposit.SETRANGE("Item Charge Type", "Item Charge Type"::Deposit);//BC Upgrade KUMARR78>>
                            SalesLineDeposit.SETRANGE("Attached to Line No.", "Line No.");
                            SalesLineDeposit.SETFILTER(Quantity, '<>%1', 0);
                            if SalesLineDeposit.FINDSET() then
                                repeat
                                    DepositSalesLineBuffer.INIT();
                                    DepositSalesLineBuffer := SalesLineDeposit;
                                    DepositSalesLineBuffer.INSERT();

                                until SalesLineDeposit.NEXT() = 0;
                            //HEI.05<<
                        end;

                        trigger OnPreDataItem();
                        begin
                            VATAmountLine.DELETEALL();
                            SalesShipmentBuffer.RESET();
                            SalesShipmentBuffer.DELETEALL();
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                                MoreLines := NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");
                            CurrReport.CREATETOTALS(Amount, "Amount Including VAT", "Inv. Discount Amount");
                        end;
                    }
                    dataitem(UnderLineCharges; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
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
                            //HEI.04>>
                            if Number = 1 then
                                TempUnderChargeLine.FINDFIRST()
                            else
                                TempUnderChargeLine.NEXT();
                            //HEI.04<<
                        end;

                        trigger OnPostDataItem();
                        begin
                            //HEI.04>>
                            TempUnderChargeLine.RESET();
                            TempUnderChargeLine.DELETEALL();
                            //HEI.04<<
                        end;

                        trigger OnPreDataItem();
                        begin
                            //HEI.04>>
                            TempUnderChargeLine.RESET();
                            SETRANGE(Number, 1, TempUnderChargeLine.COUNT);
                            //HEI.04<<
                        end;
                    }
                    dataitem(DepositLines; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(Deposit_No; DepositSalesLineBuffer."No.")
                        {
                        }
                        column(Deposit_Description; DepositSalesLineBuffer.Description)
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
                        column(Quantity_DepositLines; DepositSalesLineBuffer.Quantity)
                        {
                        }
                        column(UnitPrice_DepositLines; DepositSalesLineBuffer."Unit Price")
                        {
                        }
                        column(VAT_DepositLines; DepositSalesLineBuffer."VAT %")
                        {
                        }
                        column(LineAmount_DepositLines; DepositSalesLineBuffer."Line Amount")
                        {
                            AutoFormatType = 1;
                        }
                        dataitem("Sales Shipment Buffer"; "Integer")
                        {
                            DataItemTableView = SORTING(Number);

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then
                                    SalesShipmentBuffer.FIND('-')
                                else
                                    SalesShipmentBuffer.NEXT();
                            end;

                            trigger OnPreDataItem();
                            begin
                                SETRANGE(Number, 1, SalesShipmentBuffer.COUNT);
                            end;
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText_DimensionLoop2; DimText)
                            {
                            }
                            column(LineDimCptn; LineDimCptnLbl)
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FIND('-') then
                                        CurrReport.BREAK();
                                end else
                                    if not Continue then
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until DimSetEntry2.NEXT() = 0;
                            end;

                            trigger OnPreDataItem();
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.BREAK();

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Cr.Memo Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            Item: Record Item;
                            ItemCharge: Record "Item Charge";
                        begin
                            //HEI.05>>
                            if Number = 1 then
                                DepositSalesLineBuffer.FINDFIRST()
                            else
                                DepositSalesLineBuffer.NEXT();

                            ItemCharge.GET(DepositSalesLineBuffer."No.");
                            //BC UPGRADE KUMARR78>> DIT Field Removed
                            // if ("Item Charge Type" <> "Item Charge Type"::Deposit) and
                            //    not (ItemCharge."Show Item charge on Invoice" in [ItemCharge."Show Item charge on Invoice"::" ",
                            //        ItemCharge."Show Item charge on Invoice"::"Order total"])
                            // then
                            //     CurrReport.SKIP();
                            //BC UPGRADE KUMARR78<< DIT Field Removed
                            // EmptyGoodsItemNo := "Empty Goods Item No."; //BC UPGRADE KUMARR78<< DIT Field Removed
                            // if Item.GET("Empty Goods Item No.") then begin //BC UPGRADE KUMARR78<< DIT Field Removed
                            EmptyGoodsItemDescr := Item.Description;
                            EmptyGoodsItemBaseUOM := Item."Base Unit of Measure";
                            // end; //BC UPGRADE KUMARR78<< Closing Loop for Begin
                            EmptyGoodAmount += DepositSalesLineBuffer."Line Amount";
                            //HEI.05<<
                        end;

                        trigger OnPostDataItem();
                        begin
                            //HEI.05>>
                            DepositSalesLineBuffer.RESET();
                            DepositSalesLineBuffer.DELETEALL();
                            //HEI.5<<
                        end;

                        trigger OnPreDataItem();
                        begin
                            //HEI.05>>
                            DepositSalesLineBuffer.RESET();
                            SETRANGE(Number, 1, DepositSalesLineBuffer.COUNT);

                            MoreLines := FIND('+');
                            while MoreLines and (DepositSalesLineBuffer.Description = '') and (DepositSalesLineBuffer."No." = '')
                              and (DepositSalesLineBuffer.Quantity = 0) and (DepositSalesLineBuffer.Amount = 0) do
                                MoreLines := NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            EmptyGoodAmount := 0;
                            EmptyGoodsItemNo := '';
                            EmptyGoodsItemDescr := '';
                            EmptyGoodsItemBaseUOM := '';
                            //HEI.05<<
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvoiceDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtSpecificationCptn; VATAmtSpecificationCptnLbl)
                        {
                        }
                        column(VATAmtLineInvDiscBaseAmtCptn; VATAmtLineInvDiscBaseAmtCptnLbl)
                        {
                        }
                        column(VATAmtLineLineAmtCptn; VATAmtLineLineAmtCptnLbl)
                        {
                        }
                        column(VATAmtLineInvoiceDiscAmtCptn; VATAmtLineInvoiceDiscAmtCptnLbl)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATClauseEntryCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATClauseVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATClauseCode; VATAmountLine."VAT Clause Code")
                        {
                        }
                        column(VATClauseDescription; VATClause.Description)
                        {
                        }
                        column(VATClauseDescription2; VATClause."Description 2")
                        {
                        }
                        column(VATClauseAmount; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATClausesCaption; VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption; VATAmtLineVATIdentifierCptnLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption; VATAmtLineVATAmtCptnLbl)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                            if not VATClause.GET(VATAmountLine."VAT Clause Code") then
                                CurrReport.SKIP();
                            VATClause.TranslateDescription("Sales Cr.Memo Header"."Language Code");
                        end;

                        trigger OnPreDataItem();
                        begin
                            CLEAR(VATClause);
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercent; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATIdentifier_VATCounterLCY; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code",
                                "Sales Cr.Memo Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code",
                                "Sales Cr.Memo Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem();
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Cr.Memo Header"."Currency Code" = '')
                            then
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text008 + Text009
                            else
                                VALSpecLCYHeader := Text008 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Sales Cr.Memo Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text010, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Totals; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(NNCTotalLineAmt; NNC_TotalLineAmount)
                        {
                            AutoFormatType = 1;
                        }
                        column(NNCTotalAmtInclVat; NNC_TotalAmountInclVat)
                        {
                            AutoFormatType = 1;
                        }
                        column(NNCTotalInvDiscAmt_SalesCrMemoLine; NNC_TotalInvDiscAmount)
                        {
                            AutoFormatType = 1;
                        }
                        column(NNCTotalAmt; NNC_TotalAmount)
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalDeposit; TotalDeposit)
                        {
                        }
                        column(DiscountTotal; DiscountTotal)
                        {
                        }
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    CurrReport.PAGENO := 1;
                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    end;

                    NNC_TotalLineAmount := 0;
                    NNC_TotalAmountInclVat := 0;
                    NNC_TotalInvDiscAmount := 0;
                    NNC_TotalAmount := 0;

                    //MOZ
                    if "Sales Cr.Memo Header"."No. Printed" > 1 then
                        FooterText := Text013;
                end;

                trigger OnPostDataItem();
                begin
                    if not CurrReport.PREVIEW then
                        CODEUNIT.RUN(CODEUNIT::"Sales Cr. Memo-Printed", "Sales Cr.Memo Header");
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
                ItemCharge: Record "Item Charge";
                ItemChargeLines: Record "Sales Cr.Memo Line";
                DomesticInv: Boolean;
            begin
                // >>HEI.07
                if LangCode = '' then
                    LangCode := "Sales Cr.Memo Header"."Language Code";
                // <<HEI.07

                //HEI.04>>
                DomesticInv := (("Ship-to Country/Region Code" = CompanyInfo."Country/Region Code")
                               or ("Ship-to Country/Region Code" = 'MZ') or ("Ship-to Country/Region Code" = ''));

                if DomesticInv then
                    // CurrReport.Language := Language.GetLanguageID(LangCode); //BC Upgrade KUMARR78 GetlanguageId moved from Table to CU.
                    CurrReport.Language := LanguageG.GetLanguageId(LangCode) //BC Upgrade KUMARR78 GetlanguageId moved from Table to CU.
                else
                    CurrReport.LANGUAGE := 1033;

                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                //HEI.04<<

                FormatAddressFields("Sales Cr.Memo Header");
                FormatDocumentFields("Sales Cr.Memo Header");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if LogInteraction then
                    if not CurrReport.PREVIEW then
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(
                              6, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        else
                            SegManagement.LogDocument(
                              6, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');

                if PaymentTerms.GET("Payment Terms Code") then; //HEI.02

                //HEI.04>>
                HideDiscount := 0;
                ItemChargeLines.SETRANGE("Document No.", "No.");
                ItemChargeLines.SETRANGE(Type, ItemChargeLines.Type::"Charge (Item)");
                // ItemChargeLines.SETRANGE("Item Charge Type", ItemChargeLines."Item Charge Type"::Discount);//BC UPGRADE KUMARR78
                if ItemChargeLines.FINDSET() then
                    repeat
                        ItemCharge.GET(ItemChargeLines."No.");
                        // if ItemCharge."Show Item charge on Invoice" <> ItemCharge."Show Item charge on Invoice"::"Include in item price" then//BC UPGRADE KUMARR78("Show Item charge on Invoice")
                        HideDiscount += 1;
                    until ItemChargeLines.NEXT() = 0;
                //HEI.04<<
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
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'No. of Copies',
                                    FRA = 'Nombre de copies';
                        ToolTipML = ENU = 'Specifies how many copies of the document to print.',
                                    FRA = 'Indique le nombre de copies du document à imprimer.';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Show Internal Information',
                                    FRA = 'Afficher info. internes';
                        ToolTipML = ENU = 'Specifies if the document shows internal information.',
                                    FRA = 'Indique si le document affiche les informations internes.';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Log Interaction',
                                    FRA = 'Journal interaction';
                        Enabled = LogInteractionEnable;
                        ToolTipML = ENU = 'Specifies that interactions with the contact are logged.',
                                    FRA = 'Spécifie que les interactions avec le contact sont enregistrées.';
                    }
                    field(LangCode; LangCode)
                    {
                        Caption = 'Local Language Code';
                        ApplicationArea = all; //BC UPGRADE KUMARR78 Adding ApplicationArea
                        LookupPageID = Languages;
                        TableRelation = Language;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage();
        var
        enumvalue : Enum "Interaction Log Entry Document Type";
        begin

            //LogInteraction := SegManagement.FindInteractTmplCode(6) <> ''; //BC UPGRADE KUMARR78-Field missing in Table
            LogInteraction := SegManagement.FindInteractionTemplateCode(enumvalue::"Sales Cr. Memo") <> ''; //BC UPGRADE KUMARR78-replaced this field
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
        label(LblExternalDocNo; ENU = 'External Document No.',
                               PTB = 'Número do Documento Externo:',
                               PTG = 'Número do Documento Externo:')
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        CompanyInfo.GET();
        SalesSetup.GET();
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    trigger OnPreReport();
    begin
        if not CurrReport.USEREQUESTPAGE then
            InitLogInteraction();
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        // Language: Record Language; //BC UPGRADE KUMARR78 Blocking Codeunit as Function Moved from Record to Codeunit.
        LanguageG: Codeunit Language;//BC UPGRADE KUMARR78 Adding Codeunit as Function Moved from Record to Codeunit.
        PaymentTerms: Record "Payment Terms";
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        DepositSalesLineBuffer: Record "Sales Cr.Memo Line" temporary;
        TempUnderChargeLine: Record "Sales Cr.Memo Line" temporary;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        VATAmountLine: Record "VAT Amount Line" temporary;
        VATClause: Record "VAT Clause";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        Continue: Boolean;
        HideLine: Boolean;
        LogInteraction: Boolean;

        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        PrintUnderLineCharge: Boolean;
        ShowInternalInfo: Boolean;
        ShowShippingAddr: Boolean;
        EmptyGoodsItemBaseUOM: Code[10];
        LangCode: Code[10];
        EmptyGoodsItemNo: Code[20];
        PostedReceiptDate: Date;
        CalculatedExchRate: Decimal;
        Discount: Decimal;
        DiscountTotal: Decimal;
        EmptyGoodAmount: Decimal;
        LineAmount: Decimal;
        NNC_TotalAmount: Decimal;
        NNC_TotalAmountInclVat: Decimal;
        NNC_TotalInvDiscAmount: Decimal;
        NNC_TotalLineAmount: Decimal;
        PorcDisc: Decimal;
        TotalDeposit: Decimal;
        TotalDiscount: Decimal;
        TotalDiscountPerc: Decimal;
        UnitPrice: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        FirstValueEntryNo: Integer;
        HideDiscount: Integer;
        NextEntryNo: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        Text012: Label '"Processado por computador - Microsoft Navision "';
        AppliedToText: Text;
        EmptyGoodsItemDescr: Text;
        FooterText: Text;
        CopyText: Text[30];
        SalesPersonText: Text[30];
        CompanyAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        CustAddr: array[8] of Text[60];
        ShipToAddr: array[8] of Text[60];
        OldDimText: Text[75];
        ReferenceText: Text[80];
        ReturnOrderNoText: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        DimText: Text[120];
        AmountCptnLbl: TextConst ENU = 'Amount', FRA = 'Montant', PTB = 'Valor Total', PTG = 'Valor Total';
        CompanyInfoBankAccNoCptnLbl: TextConst ENU = 'Account No.', FRA = 'N° compte';
        CompanyInfoBankNameCptnLbl: TextConst ENU = 'Bank', FRA = 'Banque';
        CompanyINfoEmailCaptionLbl: TextConst ENU = 'Email', FRA = 'E-mail';
        CompanyInfoGiroNoCptnLbl: TextConst ENU = 'Giro No.', FRA = 'N° CCP', PTB = 'Giro No.', PTG = 'Giro No.';
        CompanyInfoHomePageCaptionLbl: TextConst ENU = 'Home Page', FRA = 'Page d''accueil';
        CompanyInfoPhoneNoCptnLbl: TextConst ENU = 'Phone No.', FRA = 'N° téléphone', PTB = 'Tel.', PTG = 'Tel.';
        CompanyInfoVATRegNoCptnLbl: TextConst ENU = 'VAT Registration No.:', PTB = 'NUIT:', PTG = 'NUIT:';
        CustomerCodeCaption: TextConst ENU = 'Customer No.:', PTB = 'Codigo do Cliente :', PTG = 'Codigo do Cliente :';
        DescriptionLbl: TextConst ENU = 'Description', FRA = 'Descrição', PTB = 'Descrição', PTG = 'Descrição';
        DiscontoCaption: TextConst ENU = 'Discount', FRA = 'Disconto', PTB = 'Disconto', PTG = 'Disconto';
        DocumentDateLbl: TextConst ENU = 'Document Date', FRA = 'Data do Documento', PTB = 'Data do Documento', PTG = 'Data do Documento';
        ExternalDocNoLbl: TextConst ENU = 'External Document No.', PTB = 'Número do Documento Externo:', PTG = 'Número do Documento Externo:';
        HeaderDimCptnLbl: TextConst ENU = 'Header Dimensions', FRA = 'Analytique en-tête';
        InvDiscAmt_SalesCrMemoLineCptnLbl: TextConst ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
        ItemNoLbl: TextConst ENU = 'Ref.', FRA = 'Ref', PTB = 'Ref', PTG = 'Ref';
        LineAmtInvDiscAmt_SalesCrMemoLineCptnLbl: TextConst ENU = 'Payment Discount on VAT', FRA = 'Escompte sur TVA';
        LineDimCptnLbl: TextConst ENU = 'Line Dimensions', FRA = 'Analytique ligne';
        No1_SalesCrMemoHeaderCptnLbl: TextConst ENU = 'Credit Memo No.', FRA = 'N° avoir', PTB = 'Nota de Credito No.', PTG = 'Nota de Credito No.';
        PageCaptionCap: TextConst ENU = 'Page %1 of %2', FRA = 'Page %1 de %2', PTB = 'Página %1 de %2', PTG = 'Página %1 de %2';
        PostedReceiptDateCptnLbl: TextConst ENU = 'Posted Return Receipt Date', FRA = 'Date réception retour validée';
        PricesInclVATLbl: TextConst ENU = 'Prices Including VAT', PTB = 'Valor Total', PTG = 'Valor Total';
        QuantityLbl: TextConst ENU = 'Qty', FRA = 'Qtd', PTB = 'Qtd', PTG = 'Qtd';
        SalesCrMemoHeaderPostDtCptnLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilisation', PTB = 'Data de Documento', PTG = 'Data de Documento';
        SalesCrMemoLineDiscCaptionLbl: TextConst ENU = 'Disc', FRA = '% Remise', PTB = 'Disc', PTG = 'Disc';
        ShiptoAddressCptnLbl: TextConst ENU = 'Ship-to Address', FRA = 'Adresse destinataire';
        SubtotalCptnLbl: TextConst ENU = 'Subtotal', FRA = 'Sous-total';
        Text003: TextConst ENU = '(Applies to %1 %2)', FRA = '(Doc. lettrage %1 %2)';
        Text005: TextConst ENU = 'Credit Note %1', FRA = 'Ventes : Avoir %1', PTB = 'Nota de Credito %1', PTG = 'Nota de Credito %1';
        Text008: TextConst ENU = 'VAT Amount Specification in ', FRA = 'Détail TVA dans ';
        Text009: TextConst ENU = 'Local Currency', FRA = 'Devise société';
        Text010: TextConst ENU = 'Exchange rate: %1/%2', FRA = 'Taux de change : %1/%2';
        Text011: TextConst ENU = 'Sales - Prepmt. Credit Memo %1', FRA = 'Ventes - Avoir acompte %1';
        Text013: TextConst ENU = 'Reprinted', PTB = 'Copia', PTG = 'Copia';
        TotalCptnLbl: TextConst ENU = 'Total', FRA = 'Total';
        TotalDepositoCap: TextConst ENU = 'Total Deposit', FRA = 'Total Deposito', PTB = 'Total Deposito', PTG = 'Total Deposito';
        UnitPriceCptnLbl: TextConst ENU = 'Unit Price', FRA = 'Preço Unitario', PTB = 'Preço Unitario', PTG = 'Preço Unitario';
        UoMLbl: TextConst ENU = 'UoM', FRA = 'UoM', PTB = 'UN', PTG = 'UN';
        ValorTotalExclIVA: TextConst ENU = 'Total Amount Excl. VAT', FRA = 'Valor Total Excl.IVA', PTB = 'Valor Total Excl.IVA', PTG = 'Valor Total Excl.IVA';
        ValorTotalInclIVA: TextConst ENU = 'Total Amount Incl. VAT', FRA = 'Valor Total Incl.IVA', PTB = 'Valor Total Incl.IVA', PTG = 'Valor Total Incl.IVA';
        VATAmtLineInvDiscBaseAmtCptnLbl: TextConst ENU = 'Invoice Discount Base Amount', FRA = 'Montant base remise facture', PTB = 'Valor Total Excl. Desconto', PTG = 'Valor Total Excl. Desconto';
        VATAmtLineInvoiceDiscAmtCptnLbl: TextConst ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture', PTB = 'Descount', PTG = 'Descount';
        VATAmtLineLineAmtCptnLbl: TextConst ENU = 'Line Amount', FRA = 'Montant ligne', PTB = 'SubTotal', PTG = 'SubTotal';
        VATAmtLineVATAmtCptnLbl: TextConst ENU = 'VAT Amount', FRA = 'Montant TVA', PTB = 'Valor IVA', PTG = 'Valor IVA';
        VATAmtLineVATBaseCptnLbl: TextConst ENU = 'VAT Base', FRA = 'Base TVA', PTB = 'Valor Total Excl. IVA', PTG = 'Valor Total Excl. IVA';
        VATAmtLineVATCptnLbl: TextConst ENU = 'VAT %', FRA = '% TVA', PTB = 'IVA %', PTG = 'IVA %';
        VATAmtLineVATIdentifierCptnLbl: TextConst ENU = 'VAT Identifier', FRA = 'Identifiant TVA', PTB = 'Valor IVA', PTG = 'Valor IVA';
        VATAmtSpecificationCptnLbl: TextConst ENU = 'VAT Amount Specification', FRA = 'Détail montant TVA';
        VATClausesCap: TextConst ENU = 'VAT Clause', FRA = 'Clause TVA';

    procedure InitLogInteraction();
    var
    enumvalue: Enum "Interaction Log Entry Document Type";
    begin
        //LogInteraction := SegManagement.FindInteractTmplCode(6) <> ''; //BC UPGRADE KUMARR78-Field missing in Table
        LogInteraction := SegManagement.FindInteractionTemplateCode(enumvalue::"Sales Cr. Memo") <> ''; //BC UPGRADE KUMARR78-replaced this field
    end;

    local procedure FindPostedShipmentDate(): Date;
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

    local procedure GenerateBufferFromValueEntry(SalesCrMemoLine2: Record "Sales Cr.Memo Line");
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        Quantity: Decimal;
        TotalQuantity: Decimal;
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

    local procedure GenerateBufferFromShipment(SalesCrMemoLine: Record "Sales Cr.Memo Line");
    var
        ReturnReceiptHeader: Record "Return Receipt Header";
        ReturnReceiptLine: Record "Return Receipt Line";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
        Quantity: Decimal;
        TotalQuantity: Decimal;
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

    local procedure CorrectShipment(var ReturnReceiptLine: Record "Return Receipt Line");
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

    local procedure AddBufferEntry(SalesCrMemoLine: Record "Sales Cr.Memo Line"; QtyOnShipment: Decimal; PostingDate: Date);
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

    local procedure FormatAddressFields(var SalesCrMemoHeader: Record "Sales Cr.Memo Header");
    begin
        FormatAddr.GetCompanyAddr(SalesCrMemoHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesCrMemoBillTo(CustAddr, SalesCrMemoHeader);
        ShowShippingAddr := FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, SalesCrMemoHeader);
    end;

    local procedure FormatDocumentFields(SalesCrMemoHeader: Record "Sales Cr.Memo Header");
    begin
        FormatDocument.SetTotalLabels(SalesCrMemoHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalesPurchPerson, SalesCrMemoHeader."Salesperson Code", SalesPersonText);

        ReturnOrderNoText := FormatDocument.SetText(SalesCrMemoHeader."Return Order No." <> '', SalesCrMemoHeader.FIELDCAPTION("Return Order No."));
        ReferenceText := FormatDocument.SetText(SalesCrMemoHeader."Your Reference" <> '', SalesCrMemoHeader.FIELDCAPTION("Your Reference"));
        VATNoText := FormatDocument.SetText(SalesCrMemoHeader."VAT Registration No." <> '', SalesCrMemoHeader.FIELDCAPTION("VAT Registration No."));
        AppliedToText :=
          FormatDocument.SetText(
            SalesCrMemoHeader."Applies-to Doc. No." <> '', FORMAT(STRSUBSTNO(Text003, FORMAT(SalesCrMemoHeader."Applies-to Doc. Type"), SalesCrMemoHeader."Applies-to Doc. No.")));
    end;
}

