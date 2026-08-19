report 52048 "Purchase Order Congo"
{
    // version HEI.01

    // HEI.01 FDD-LB-PURGAP01_Lebanon_Almaza_Purchase order Layout_v0.2,NAIKH01 07/19/18
    //   #created a new report
    // 
    // HEI.02      BULIMC01 IBM 05.06.2019
    //   #new report created for Suriname
    // 
    // HEI.03 IBM BULIMC01 23.09.2019 #new report created for Saint Lucia based on Report 50211
    // HEI.04 IBM PANDES01 28.11.2019 # Layout change in Footer, Legal tax block.
    //    # Done changes in layout 23-01-2020
    // HEI.05  FCE  Added a vendor.get to get the correct legal text
    // HEI.06 Removed Delivery Date from header and added missing code of RFC(CHG0268766).
    // HEI.07 FCE Hide the label in rdlc Plant Opening hours and if County and Country / Regio the same, then keep county blank
    // HEI.08 FDD-HB858 - CHG2027215 SHANKJ03 IBM 23.01.2020
    //   # ContactCOntractPerson value changed based on FDD condition
    //   # Removed Delivery Date from layout
    //   # Incoterm Caption changed to Incoerm Location
    //   # Approved By is made hidden in layout
    //   # Document date is changed to Order Date
    // HEI.09 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //   # New report created from Report 50326
    // *************************************************************************************
    // HEI.10 HT2139 CHG2105037 IBM NANDIS01 30-04-2021 - Brasco Congo: HT2139 - PO Form Layout
    //   # New Report saved as from DRC one for Brasco - so not deleting above documentation
    //   # Defecct #6427 - made some space between header and lines and adjust the layout

    // BC Upgrade KUMARS145 Nav ID report 50495 "Purchase Order Congo"

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Purchase Order Congo.rdl';

    CaptionML = ENU = 'Purchase Order Congo', ESP = 'Orden de Compra', FRA = 'Bon de Commande';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(ReportTitleLbl; ReportTitle) { }
            column(ReprintedLbl; Reprinted) { }
            column(PageCaptionLbl; PageCaption) { }
            column(OrderingPartyLbl; OrderingParty) { }
            column(TaxIdentificationLbl; TaxIdentification) { }
            column(ContactPersonLbl; ContactPerson) { }
            column(PhoneLbl; Phone) { }
            column(VendorLbl; VendorCaption) { }
            column(TaxIdentificationNumberLbl; TaxIdentificationNumber) { }
            column(EUVATNumberLbl; EUVATNumber) { }
            column(YourVendorNoWithUsLbl; YourVendorNoWithUs) { }
            column(PleaseDeliverGoodsToLbl; PleaseDeliverGoodsTo) { }
            column(PlantOpeningHrsLbl; PlantOpeningHrs) { }
            column(PleaseDeliverInvoiceToLbl; PleaseDeliverInvoiceTo) { }
            column(DeliveryTermsLbl; DeliveryTerms) { }
            column(DocumentDateLbl; DocumentDate) { }
            column(DeliveryDateLbl; DeliveryDate) { }
            column(PaymentTermsLbl; PaymentTermsCaption) { }
            column(IncotermsLbl; Incoterms) { }
            column(CurrencyLbl; Currency) { }
            column(OperationalContractRefLbl; OperationalContractRef) { }
            column(LegalContractReferenceLbl; LegalContractReference) { }
            column(ContractContactPersonLbl; ContractContactPerson) { }
            column(ItemLbl; ItemCaption) { }
            column(MaterialLbl; Material) { }
            column(MaterialDescriptionLbl; MaterialDescription) { }
            column(QuantityLbl; QuantityCaption) { }
            column(UoMLbl; UoM) { }
            column(NetPriceLbl; NetPrice) { }
            column(NetValueLbl; NetValue) { }
            column(PurchaseOrderValueLbl; PurchaseOrderValue) { }
            column(ApprovedByLbl; ApprovedBy) { }
            column(CRLbl; CR) { }
            column(VATLbl; VAT) { }
            column(VATIDLbl; VATID) { }
            column(FooterLbl; Footer) { }
            column(LegalText; LegalText) { }
            column(PurchaseHeader_DocumentType; "Document Type") { }
            column(PurchaseHeader_No; "No.") { }
            column(PurchaseHeader_NoPrinted; "No. Printed") { }
            column(PurchaseHeader_ContactPersonName; User."Full Name") { }
            column(PurchaseHeader_ContactPersonEmail; User."Contact Email") { }
            column(TotalExclVATText; TotalExclVATText) { }
            column(TotalInclVATText; TotalInclVATText) { }
            column(VATPer; VATPer) { }
            column(VATPeTxt; VATPerText) { }
            column(CommentsLbl; CommentsLbl) { }
            column(VATAmt; VatAmt) { }
            // BC Upgrade KUMARS145 Dotnet procedure are commented....>>
            // column(testremark; StringHelper.Copy(FORMAT(POText))) { }
            // column(FooterText; StringHelper.Copy(FORMAT(FooterText))) { }
            column(testremark; FORMAT(POText)) { }
            column(FooterText; FORMAT(FooterText)) { }
            // BC Upgrade KUMARS145 Dotnet procedure are commented....<<
            column(ExpRecDtLbl; ExpRecDtLbl) { }
            column(IncotermsLocLbl; IncotermsLocLbl) { }
            column(OrderDateLbl; OrderDateLbl) { }
            column(PurchaseHeader_OrderDate; "Purchase Header"."Order Date") { }
            column(PurchaseHeader_ContactPersonNameNew; ContactPersonTxt) { }
            column(PurchaseHeader_ContractcontpersonTxt; ContractcontpersonTxt) { }
            column(POChanged; POChanged) { }
            column(ShowAddr; ShowAddr) { }
            column(ShowAddr2; ShowAddr2) { }
            column(ShowCityPostCode; ShowCityPostCode) { }
            column(ShowContact; ShowContact) { }
            column(ShowCountryRegion; ShowCountryRegion) { }
            column(ReasonCodeDescription; ReasonCodeDescription) { }
            column(ReasonCodeDescriptionLbl; ReasonCodeDescriptionLbl) { }
            column(ApprovalUserTxt; ApprovalUserTxt) { }
            column(ApprovalDateTxt; ApprovalDateTxt) { }
            column(ApprovalUser; ApprovalUser) { }
            column(ApprovalDate; ApprovalDate) { }
            column(LicenseCode; LicenseCode) { }
            column(LicenseCodeLbl; LicenseCodeLbl) { }
            column(Signature; grec_UserSetup."Electronic Signature FND") { }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyInfo_Addr1; CompanyAddr[1]) { }
                    column(Companyinfo_Addr2; CompanyAddr[2]) { }
                    column(CompanyInfo_Addr3; CompanyAddr[3]) { }
                    column(CompanyInfo_Addr4; CompanyAddr[4]) { }
                    column(Companyinfo_Addr5; CompanyAddr[5]) { }
                    column(CompanyInfo_Addr6; CompanyAddr[6]) { }
                    column(CompanyInfo_ShipToAddr1; ShipToCompanyAddr[1]) { }
                    column(CompanyInfo_ShipToAddr2; ShipToCompanyAddr[2]) { }
                    column(CompanyInfo_ShipToAddr3; ShipToCompanyAddr[3]) { }
                    column(CompanyInfo_ShipToAddr4; ShipToCompanyAddr[4]) { }
                    column(CompanyInfo_ShipToAddr5; ShipToCompanyAddr[5]) { }
                    column(CompanyInfo_ShipToAddr6; ShipToCompanyAddr[6]) { }
                    column(CompanyInfo_ShipToAddr7; ShipToCompanyAddr[7]) { }
                    column(CompanyInfo_ShipToAddr8; ShipToCompanyAddr[8]) { }
                    column(CompanyInfo_Picture; CompanyInfo1.Picture) { }
                    column(CompanyInfo_Signature; CompanyInfo1."Signature Image FND") { }
                    column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.") { }
                    column(CompanyInfo_VAT; CompanyInfo."VAT Registration No.") { }
                    column(CompanyInfo_RegistrationNo; CompanyInfo."Registration No.") { }
                    column(Vendor_No; "Purchase Header"."Buy-from Vendor No.") { }
                    column(Vendor_Addr1; BuyFromAddr[1]) { }
                    column(Vendor_Addr2; BuyFromAddr[2]) { }
                    column(Vendor_Addr3; BuyFromAddr[3]) { }
                    column(Vendor_Addr4; BuyFromAddr[4]) { }
                    column(Vendor_Addr5; BuyFromAddr[5]) { }
                    column(Vendor_Addr6; BuyFromAddr[6]) { }
                    column(Vendor_Addr7; BuyFromAddr[7]) { }
                    column(Vendor_Addr8; BuyFromAddr[8]) { }
                    // BC Upgrade KUMARS145 Drinkit fields replaced ....>>
                    // column(Vendor_TaxRegistrationNo; "Purchase Header"."Vendor Tax Registration No.") { }
                    column(Vendor_TaxRegistrationNo; "Purchase Header"."VAT Registration No.") { }
                    // BC Upgrade KUMARS145 Drinkit fields replaced ....<<
                    column(EUVATNumber; "Purchase Header"."VAT Registration No.") { }
                    column(Vendor_Contact; Vendor.Contact) { }
                    column(Vendor_Email; Vendor."E-Mail") { }
                    column(Vendor_LanguageCode; Vendor."Language Code") { }
                    column(PurchaseHeader_DocumentDate; FORMAT("Purchase Header"."Document Date", 0, 4)) { }
                    column(PurchaseHeader_ExpectedReceiptDate; "Purchase Header"."Expected Receipt Date") { }
                    column(PurchaseHeader_PaymentTerms; PaymentTerms.Description) { }
                    column(PurchaseHeader_IncoTerms; "Purchase Header"."Payment Method Code") { }
                    column(PurchaseHeader_ShipMethodCode; "Purchase Header"."Shipment Method Code") { }
                    column(PurchaseHeader_Currency; LCYCode) { }
                    column(PurchaseHeader_OperationalContractNo; "Purchase Header"."SRM Contract No. FND") { }
                    column(PurchaseHeader_OperationalContractRef; "Purchase Header"."SRM Contract Name FND") { }
                    column(PurchaseHeader_ContractContactNo; "Purchase Header"."Pay-to Contact") { }
                    column(OutputNo; OutputNo) { }
                    column(ShowInternalInfo; ShowInternalInfo) { }
                    column(DimText; DimText) { }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(HdrDimCaption; HdrDimCaptionLbl) { }

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
                                    DimText := STRSUBSTNO('%1, %2 %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.Next() = 0;
                        end;

                        trigger OnPreDataItem();
                        begin
                            if not ShowInternalInfo then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(CommentLine; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        column(PurchComment; PurchComment) { }

                        trigger OnAfterGetRecord();
                        begin
                            //<<HEI.01 NAIKH01
                            if Number = 1 then
                                PurchCommentLine.FINDFIRST()
                            else
                                PurchCommentLine.NEXT();

                            PurchComment := PurchCommentLine.Comment;
                        end;

                        trigger OnPreDataItem();
                        begin
                            PurchCommentLine.RESET();
                            PurchCommentLine.SETRANGE("Document Type", PurchCommentLine."Document Type"::Order);
                            PurchCommentLine.SETRANGE("No.", "Purchase Header"."No.");
                            // PurchCommentLine.SETRANGE("Print On Purchase Order", true); // BC Upgrade KUMARS145 code commented as it uses Drinkit field.

                            SETRANGE(Number, 1, PurchCommentLine.COUNT);
                        end;
                    }
                    dataitem(VendorCommentsLine; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        column(VendComment; VendComment) { }

                        trigger OnAfterGetRecord();
                        begin
                            //<<HEI.01 NAIKH01
                            if Number = 1 then
                                VendCommentLine.FINDFIRST()
                            else
                                VendCommentLine.NEXT();

                            VendComment := VendCommentLine.Comment;
                        end;

                        trigger OnPreDataItem();
                        begin
                            VendCommentLine.RESET();
                            VendCommentLine.SETRANGE("Table Name", VendCommentLine."Table Name"::Vendor);
                            VendCommentLine.SETRANGE("No.", "Purchase Header"."Buy-from Vendor No.");
                            // VendCommentLine.SETRANGE("Print On Purchase Order", true);// BC Upgrade KUMARS145 code commented as it uses Drinkit field.

                            SETRANGE(Number, 1, VendCommentLine.COUNT);
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem();
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(PurchaseLine_No; "Purchase Line"."No.") { }
                        column(PurchaseLine_Description; "Purchase Line".Description) { }
                        column(PurchaseLine_Quantity; "Purchase Line".Quantity) { }
                        column(PurchaseLine_UoM; "Purchase Line"."Unit of Measure Code") { }
                        column(PurchaseLine_DirectUnitCost; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(PurchaseLine_LineAmount; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchaseLine_LineNo; "Purchase Line"."Line No.") { }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Type_PurchLine; FORMAT("Purchase Line".Type, 0, 2)) { }
                        column(LineAmt2_PurchLine; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(MachineRefNoCaption; MachineRefNo) { }
                        column(Item_MachineReferenceNo; Item."Machine Reference Number FND") { }
                        column(ExpectedReceiptDate_PurchaseLine; FORMAT(PurchLine."Expected Receipt Date", 10, '<Day,2>/<Month,2>/<Year4>')) { }
                        column(LineDiscount_PurchaseLine; "Purchase Line"."Line Discount %") { }
                        column(VatPer_PurchaseLine; "Purchase Line"."VAT %") { }
                        column(POLineStatus; POLineStatus) { }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(LineDimCaption; LineDimCaptionLbl) { }

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FINDSET() then
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
                                        DimText := STRSUBSTNO('%1, %2 %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                PurchLine.FIND('-')
                            else
                                PurchLine.NEXT();
                            "Purchase Line" := PurchLine;

                            // BC Upgrade KUMARS145 Changed the old tables field...>>
                            // if not ItemCrossRef.GET("Purchase Line"."No.", "Purchase Line"."Variant Code", "Purchase Line"."Unit of Measure Code", ItemCrossRef."Cross-Reference Type"::Vendor, "Purchase Line"."Buy-from Vendor No.", "Purchase Line"."Vendor Item No.") then
                            if not ItemCrossRef.GET("Purchase Line"."No.", "Purchase Line"."Variant Code", "Purchase Line"."Unit of Measure Code", ItemCrossRef."Reference Type"::Vendor, "Purchase Line"."Buy-from Vendor No.", "Purchase Line"."Vendor Item No.") then
                                // BC Upgrade KUMARS145 Changed the old tables field...<<
                                ItemCrossRef.INIT();

                            if not "Purchase Header"."Prices Including VAT" and
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            then
                                PurchLine."Line Amount" := 0;

                            //IF (PurchLine.Type = PurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                            //"Purchase Line"."No." := '';
                            AllowInvDisctxt := FORMAT("Purchase Line"."Allow Invoice Disc.");
                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line".Amount;

                            //HEI.04>>
                            if "Purchase Line".Type = "Purchase Line".Type::Item then
                                if Item.GET("Purchase Line"."No.") then;
                            //HEI.04<<


                            //HEI.08 >>
                            POLineStatus := '';
                            if "Purchase Header"."Changed FND" then begin
                                PurchaseDocumentLog.RESET();
                                PurchaseDocumentLog.SETRANGE("Document Type", PurchaseDocumentLog."Document Type"::Order);
                                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Line"."Document No.");
                                PurchaseDocumentLog.SETRANGE("Line No.", "Purchase Line"."Line No.");
                                PurchaseDocumentLog.SETRANGE(Printed, false);
                                PurchaseDocumentLog.SETRANGE(Comment, 'New Line Added');
                                if PurchaseDocumentLog.FINDFIRST() then
                                    POLineStatus := 'New';

                                PurchaseDocumentLog.RESET();
                                PurchaseDocumentLog.SETRANGE("Document Type", PurchaseDocumentLog."Document Type"::Order);
                                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Line"."Document No.");
                                PurchaseDocumentLog.SETRANGE("Line No.", "Purchase Line"."Line No.");
                                PurchaseDocumentLog.SETRANGE(Printed, false);
                                PurchaseDocumentLog.SETFILTER(Comment, '<>%1&<>%2', 'New Line Added', 'Line Deleted');
                                if PurchaseDocumentLog.FINDFIRST() then
                                    POLineStatus := 'Changed';
                            end;
                            //HEI.08 <<
                        end;

                        trigger OnPostDataItem();
                        begin
                            PurchLine.DELETEALL();
                        end;

                        trigger OnPreDataItem();
                        begin
                            MoreLines := PurchLine.FIND('+');
                            while MoreLines and (PurchLine.Description = '') and (PurchLine."Description 2" = '') and
                                  (PurchLine."No." = '') and (PurchLine.Quantity = 0) and
                                  (PurchLine.Amount = 0)
                            do
                                MoreLines := PurchLine.NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                            SETRANGE(Number, 1, PurchLine.COUNT);
                            CurrReport.CREATETOTALS(PurchLine."Line Amount", PurchLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier") { }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem();
                        begin
                            if VATAmount = 0 then
                                CurrReport.BREAK();
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount", VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate; VALExchRate) { }
                        column(VALSpecLCYHeader; VALSpecLCYHeader) { }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Purchase Header"."Posting Date", "Purchase Header"."Currency Code",
                                  VATAmountLine."VAT Base", "Purchase Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Purchase Header"."Posting Date", "Purchase Header"."Currency Code",
                                  VATAmountLine."VAT Amount", "Purchase Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem();
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Purchase Header"."Currency Code" = '') or
                               (VATAmountLine.GetTotalVATAmount() = 0)
                            then
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007 + Text008
                            else
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(PayToVendNo_PurchHeader; "Purchase Header"."Pay-to Vendor No.") { }
                        column(VendAddr8; VendAddr[8]) { }
                        column(VendAddr7; VendAddr[7]) { }
                        column(VendAddr6; VendAddr[6]) { }
                        column(VendAddr5; VendAddr[5]) { }
                        column(VendAddr4; VendAddr[4]) { }
                        column(VendAddr3; VendAddr[3]) { }
                        column(VendAddr2; VendAddr[2]) { }
                        column(VendAddr1; VendAddr[1]) { }
                        column(PaymentDetailsCaption; PaymentDetailsCaptionLbl) { }
                        column(VendNoCaption; VendNoCaptionLbl) { }

                        trigger OnPreDataItem();
                        begin
                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total3; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(SellToCustNo_PurchHeader; "Purchase Header"."Sell-to Customer No.") { }
                        column(SellToCustNo_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Sell-to Customer No.")) { }

                        trigger OnPreDataItem();
                        begin
                            if ("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(PrepmtLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufGLAccNo; PrepmtInvBuf."G/L Account No.") { }
                        column(PrepmtInvBufDesc; PrepmtInvBuf.Description) { }
                        column(TotalInclVATText2; TotalInclVATText) { }
                        column(TotalExclVATText2; TotalExclVATText) { }
                        column(PrepmtInvBufAmt; PrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountText; PrepmtVATAmountLine.VATAmountText()) { }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBuDescCaption; PrepmtInvBuDescCaptionLbl) { }
                        column(PrepmtInvBufGLAccNoCaption; PrepmtInvBufGLAccNoCaptionLbl) { }
                        column(PrepaymentSpecCaption; PrepaymentSpecCaptionLbl) { }
                        dataitem(PrepmtDimLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then begin
                                    if not PrepmtDimSetEntry.FINDSET() then
                                        CurrReport.BREAK();
                                end else
                                    if not Continue then
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := STRSUBSTNO('%1 %2', PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code")
                                    else
                                        DimText := STRSUBSTNO('%1, %2 %3', DimText, PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code");
                                    if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until PrepmtDimSetEntry.NEXT() = 0;
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not PrepmtInvBuf.FIND('-') then
                                    CurrReport.BREAK();
                            end else
                                if PrepmtInvBuf.NEXT() = 0 then
                                    CurrReport.BREAK();

                            if ShowInternalInfo then
                                PrepmtDimSetEntry.SETRANGE("Dimension Set ID", PrepmtInvBuf."Dimension Set ID");

                            if "Purchase Header"."Prices Including VAT" then
                                PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            else
                                PrepmtLineAmount := PrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem();
                        begin
                            CurrReport.CREATETOTALS(
                              PrepmtInvBuf.Amount, PrepmtInvBuf."Amount Incl. VAT",
                              PrepmtVATAmountLine."Line Amount", PrepmtVATAmountLine."VAT Base",
                              PrepmtVATAmountLine."VAT Amount",
                              PrepmtLineAmount);
                        end;
                    }
                    dataitem(PrepmtVATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrepmtVATAmtLineVATAmt; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVAT; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmtLineVATId; PrepmtVATAmountLine."VAT Identifier") { }
                        column(PrepymtVATAmtSpecCaption; PrepymtVATAmtSpecCaptionLbl) { }

                        trigger OnAfterGetRecord();
                        begin
                            PrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(Number, 1, PrepmtVATAmountLine.COUNT);
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                var
                    PrepmtPurchLine: Record "Purchase Line" temporary;
                    TempPurchLine: Record "Purchase Line" temporary;
                begin
                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    PurchLine.DELETEALL();
                    VATAmountLine.DELETEALL();
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := VATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT();

                    PrepmtInvBuf.DELETEALL();
                    PurchPostPrepmt.GetPurchLines("Purchase Header", 0, PrepmtPurchLine);
                    if not PrepmtPurchLine.ISEMPTY then begin
                        PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        if not TempPurchLine.ISEMPTY then
                            PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPurchLine, PrePmtVATAmountLineDeduct, 1);
                    end;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    if PrepmtVATAmountLine.FINDSET() then
                        repeat
                            PrePmtVATAmountLineDeduct := PrepmtVATAmountLine;
                            if PrePmtVATAmountLineDeduct.FIND() then begin
                                PrepmtVATAmountLine."VAT Base" := PrepmtVATAmountLine."VAT Base" - PrePmtVATAmountLineDeduct."VAT Base";
                                PrepmtVATAmountLine."VAT Amount" := PrepmtVATAmountLine."VAT Amount" - PrePmtVATAmountLineDeduct."VAT Amount";
                                PrepmtVATAmountLine."Amount Including VAT" := PrepmtVATAmountLine."Amount Including VAT" -
                                  PrePmtVATAmountLineDeduct."Amount Including VAT";
                                PrepmtVATAmountLine."Line Amount" := PrepmtVATAmountLine."Line Amount" - PrePmtVATAmountLineDeduct."Line Amount";
                                PrepmtVATAmountLine."Inv. Disc. Base Amount" := PrepmtVATAmountLine."Inv. Disc. Base Amount" -
                                  PrePmtVATAmountLineDeduct."Inv. Disc. Base Amount";
                                PrepmtVATAmountLine."Invoice Discount Amount" := PrepmtVATAmountLine."Invoice Discount Amount" -
                                  PrePmtVATAmountLineDeduct."Invoice Discount Amount";
                                PrepmtVATAmountLine."Calculated VAT Amount" := PrepmtVATAmountLine."Calculated VAT Amount" -
                                  PrePmtVATAmountLineDeduct."Calculated VAT Amount";
                                PrepmtVATAmountLine.MODIFY();
                            end;
                        until PrepmtVATAmountLine.NEXT() = 0;
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    // BC Upgrade KUMARS145 Changed the redundent Function...>>
                    // PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);
                    // BC Upgrade KUMARS145 Changed the redundent Function...<<

                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount();
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase();
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT();

                    if Number > 1 then
                        CopyText := Text003;
                    CurrReport.PAGENO := 1;
                    OutputNo := OutputNo + 1;

                    TotalSubTotal := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem();
                begin
                    if not CurrReport.PREVIEW then
                        PurchCountPrinted.RUN("Purchase Header");
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord();
            var
                lRecCountry: Record "Country/Region";
            begin
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code"); //HEI.03
                if Vendor.GET("Purchase Header"."Buy-from Vendor No.") then
                    CurrReport.LANGUAGE := GetLanguageID(Vendor."Language Code");
                CompanyInfo.GET();

                if RespCenter.GET("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    //>>HEI.01
                    FormatAddr.RespCenter(ShipToCompanyAddr, RespCenter);
                    //<<HEI.01
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    //>>HEI.01
                    //FormatAddr.FormatAddr(ShipToCompanyAddr,CompanyInfo.Name,CompanyInfo."Name 2",CompanyInfo."Ship-to Contact",CompanyInfo."Ship-to Address",
                    // CompanyInfo."Ship-to Address 2",CompanyInfo."Ship-to City",CompanyInfo."Ship-to Post Code",CompanyInfo."Ship-to County",CompanyInfo."Ship-to Country/Region Code");
                    //HEI.05>>
                    // HEI.07-
                    if lRecCountry.GET("Purchase Header"."Ship-to Country/Region Code") then begin
                        if UPPERCASE("Purchase Header"."Ship-to County") = UPPERCASE(lRecCountry.Name) then
                            "Purchase Header"."Ship-to County" := '';
                    end;
                    // HEI.07 +
                    FormatAddr.FormatAddr(ShipToCompanyAddr, CompanyInfo.Name, CompanyInfo."Name 2", "Purchase Header"."Ship-to Contact", "Purchase Header"."Ship-to Address",
                      "Purchase Header"."Ship-to Address 2", "Purchase Header"."Ship-to City", "Purchase Header"."Ship-to Post Code", "Purchase Header"."Ship-to County", "Purchase Header"."Ship-to Country/Region Code");
                    //HEI.05>>
                end;
                //<<HEI.01

                //>>HEI.01
                // BC Upgrade KUMARS145 Changed the old tables field...>>
                // User.SETRANGE("User Name", "Purchase Header"."Created By");
                User.SETRANGE("User Name", "Purchase Header".SystemCreatedBy);
                // BC Upgrade KUMARS145 Changed the old tables field...<<
                if User.FINDFIRST() then;
                //<<HEI.01
                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if "Purchaser Code" = '' then begin
                    SalesPurchPerson.INIT();
                    PurchaserText := '';
                end else begin
                    SalesPurchPerson.GET("Purchaser Code");
                    PurchaserText := Text000
                end;
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FIELDCAPTION("Your Reference");
                if "VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := FIELDCAPTION("VAT Registration No.");

                PurchaseLine.RESET();
                PurchaseLine.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                PurchaseLine.SETRANGE("Document No.", "Purchase Header"."No.");
                PurchaseLine.SETFILTER("VAT %", '<>%1', 0);
                if PurchaseLine.FINDFIRST() then
                    VATPer := PurchaseLine."VAT %";

                PurchaseLine.RESET();
                PurchaseLine.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                PurchaseLine.SETRANGE("Document No.", "Purchase Header"."No.");
                if PurchaseLine.FINDSET() then begin
                    PurchaseLine.CalcVATAmountLines(0, "Purchase Header", PurchaseLine, TempVATAmountLine1);
                    VatAmt := ROUND(TempVATAmountLine1."VAT Amount", 1, '=');
                end;

                if VATPer <> 0 then
                    VATPerText := STRSUBSTNO(Text52003, VATPer) + '%'
                else
                    VATPerText := 'VAT Amount';

                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                end else begin
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                end;


                /*
                IF Vendor."Language Code" <> 'FRA' THEN
                  LegalText := LegalTextBox1Bralima + LegalTextBox2Bralima + LegalTextBox3Bralima
                ELSE
                  LegalText := LegalTextBox1DUTBralima + LegalTextBox2DUTBralima + LegalTextBox3DUTBralima;
                //SP
                */
                //HEI.03>>
                PurchasesPayablesSetup.GET();
                PurchasesPayablesSetup.CALCFIELDS("PO Legal Text FND", "PO Legal Txt International FND");
                PurchasesPayablesSetup.CALCFIELDS("Footer Text FND", "Footer Text International FND");
                if Vendor."Language Code" <> 'FRA' then begin
                    if PurchasesPayablesSetup."PO Legal Txt International FND".HASVALUE then begin
                        PurchasesPayablesSetup."PO Legal Txt International FND".CREATEINSTREAM(MemoReader);
                        POText.READ(MemoReader);
                    end;
                    if PurchasesPayablesSetup."Footer Text International FND".HASVALUE then begin
                        PurchasesPayablesSetup."Footer Text International FND".CREATEINSTREAM(MemoReader_1);
                        FooterText.READ(MemoReader_1);
                    end;
                end else begin
                    if PurchasesPayablesSetup."PO Legal Text FND".HASVALUE then begin
                        PurchasesPayablesSetup."PO Legal Text FND".CREATEINSTREAM(MemoReader);
                        POText.READ(MemoReader);
                    end;
                    if PurchasesPayablesSetup."Footer Text FND".HASVALUE then begin
                        PurchasesPayablesSetup."Footer Text FND".CREATEINSTREAM(MemoReader_1);
                        FooterText.READ(MemoReader_1);
                    end;
                end; //SP
                //HEI.03<<
                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                if "Buy-from Vendor No." <> "Pay-to Vendor No." then
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
                if "Payment Terms Code" = '' then
                    PaymentTerms.INIT()
                else begin
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;
                if "Prepmt. Payment Terms Code" = '' then
                    PrepmtPaymentTerms.INIT()
                else begin
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                end;
                if "Shipment Method Code" = '' then
                    ShipmentMethod.INIT()
                else begin
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                end;

                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");

                if not CurrReport.PREVIEW then begin
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    if LogInteraction then begin
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    end;
                end;
                PricesInclVATtxt := FORMAT("Prices Including VAT");

                if TransportMethod.GET("Purchase Header"."Transport Method") then;

                //<<DITW18.00.06 BCE 11/08/2015 DIT-770 #1532
                recLocation.RESET();
                if recLocation.GET("Purchase Header"."Location Code") then begin
                    txtLocationPhoneNo := recLocation."Phone No.";
                    txtLocationEmail := recLocation."E-Mail";
                    txtLocationFaxNo := recLocation."Fax No.";
                end;
                //>>DITW18.00.06 BCE DIT-770 #1532

                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                if Print then begin
                    TempPrintedPurchHeader := "Purchase Header";
                    TempPrintedPurchHeader.INSERT();
                end;
                //>> DITW18.00.07 VSC DIT-770 #1970

                //>>HEI.02
                if "Currency Code" = '' then
                    LCYCode := GLSetup."LCY Code"
                else
                    LCYCode := "Currency Code";
                //<<HEI.02
                /*
                //<<NAIKH01
                i:=1;
                PurchCommentLine.RESET;
                PurchCommentLine.SETRANGE("Document Type",PurchCommentLine."Document Type"::Order);
                PurchCommentLine.SETRANGE("No.","Purchase Header"."No.");
                PurchCommentLine.SETRANGE("Print On Purchase Order",TRUE);
                IF PurchCommentLine.FINDSET THEN BEGIN
                  REPEAT
                  n[i] := PurchCommentLine.Comment;
                
                  i:=i+1;
                
                  UNTIL PurchCommentLine.NEXT=0;
                END
                //>> NAIKh01
                */
                //HEI.08>>
                CLEAR(ContactPersonTxt);
                CLEAR(UsrName);
                CLEAR(ContractcontpersonTxt);
                CLEAR(ContrContPerUsrName);
                CLEAR(PurchaserCode);

                // Contact Person
                if "Purchase Header"."Maximo Requisition No. FND" <> '' then
                    UsrName := "Purchase Header"."PQ Approver FND"
                // BC Upgrade KUMARS145 code commented it uses Drinkit Field...>>
                // else if "Purchase Header"."Quote No." <> '' then
                //     UsrName := "Purchase Header"."Requester ID"
                // BC Upgrade KUMARS145 code commented it uses Drinkit Field...<<
                // BC Upgrade KUMARS145 Changed the old code to use base's field...>>
                // else
                //     UsrName := "Purchase Header"."Created By";
                else if UserRec1.GET("Purchase Header".SystemCreatedBy) then
                    UsrName := UserRec1."Full Name";
                // BC Upgrade KUMARS145 Changed the old code to use base's field...<<



                if UsrName <> '' then begin
                    UserRec.RESET();
                    UserRec.SETRANGE("User Name", UsrName);
                    if UserRec.FINDFIRST() then
                        ContactPersonTxt := UserRec."Full Name";
                end;

                //Contract Contact Person
                if "Purchase Header"."Channel FND" = '' then
                    ContrContPerUsrName := ''
                else if ("Purchase Header"."Channel FND" = 'A') or ("Purchase Header"."Channel FND" = 'D') then begin
                    PurchaserCode := "Purchase Header"."Purchaser Code";
                    ApprovalUserRec.RESET();
                    ApprovalUserRec.SETRANGE("Salespers./Purch. Code", PurchaserCode);
                    if ApprovalUserRec.FINDFIRST() then
                        ContrContPerUsrName := ApprovalUserRec."User ID"
                end;

                if ContrContPerUsrName <> '' then begin
                    UserRec.RESET();
                    UserRec.SETRANGE("User Name", ContrContPerUsrName);
                    if UserRec.FINDFIRST() then
                        ContractcontpersonTxt := UserRec."Full Name";
                end;

                ShowAddr := false;
                ShowAddr2 := false;
                ShowCityPostCode := false;
                ShowContact := false;
                ShowCountryRegion := false;

                PurchaseDocumentLog.RESET();
                PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                PurchaseDocumentLog.SETRANGE("Line No.", 0);
                PurchaseDocumentLog.SETRANGE(Printed, false);
                if PurchaseDocumentLog.FINDSET() then
                    repeat
                        case PurchaseDocumentLog."Field No." of
                            15:
                                ShowAddr := true;
                            16:
                                ShowAddr2 := true;
                            17, 91:
                                ShowCityPostCode := true;
                            18:
                                ShowContact := true;
                            93:
                                ShowCountryRegion := true;
                        end
                    until PurchaseDocumentLog.NEXT() = 0;


                PurchaseDocumentLog.RESET();
                PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                PurchaseDocumentLog.SETFILTER("Line No.", '<>%1', 0);
                PurchaseDocumentLog.SETRANGE(Printed, false);
                if PurchaseDocumentLog.FINDFIRST() then
                    POChanged := 1;

                if PurchaseReasonCode.GET("Purch. Reason Code FND") then
                    ReasonCodeDescription := PurchaseReasonCode.Description;
                //HEI.08<<
                //HEI.09 >>
                ApprovalDate := 0D;
                CLEAR(ApprovalUser);
                CLEAR(LicenseCode);

                PurchHdrAddRec.RESET();
                PurchHdrAddRec.SETRANGE("Document Type", "Purchase Header"."Document Type");
                PurchHdrAddRec.SETRANGE("No.", "Purchase Header"."No.");
                if PurchHdrAddRec.FINDFIRST() then
                    LicenseCode := PurchHdrAddRec."License Code";

                ApprovalEntryRec.RESET();
                ApprovalEntryRec.ASCENDING;
                //HEI.10>>
                ApprovalEntryRec.SETRANGE(Status, ApprovalEntryRec.Status::Approved);
                //HEI.10<<
                ApprovalEntryRec.SETRANGE("Document No.", "Purchase Header"."No.");
                if ApprovalEntryRec.FINDLAST() then begin
                    ApprovalUser := ApprovalEntryRec."Approver ID";
                    ApprovalDate := DT2DATE(ApprovalEntryRec."Last Date-Time Modified");
                    //HEI.10>>
                    if grec_UserSetup.GET(ApprovalEntryRec."Approver ID") then
                        grec_UserSetup.CALCFIELDS("Electronic Signature FND");
                    //HEI.10<<
                end;
                //HEI.09 <<

            end;

            trigger OnPostDataItem();
            var
                PurchHeader: Record "Purchase Header";
            begin
                // BC Upgrade KUMARS145 Commented the whole code it was dependent on Drinkit field...>>
                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                // if Print then
                //     if TempPrintedPurchHeader.FINDSET() then
                //         repeat
                //             PurchHeader.GET(TempPrintedPurchHeader."Document Type", TempPrintedPurchHeader."No.");
                //             if PurchHeader."Receipt Status" < SetReceiptStatus then begin
                //                 PurchHeader.VALIDATE("Receipt Status", SetReceiptStatus);
                //                 PurchHeader.MODIFY(true);
                //             end;
                //         until TempPrintedPurchHeader.NEXT() = 0;
                // BC Upgrade KUMARS145 Commented the whole code it was dependent on Drinkit field...>>
            end;

            trigger OnPreDataItem();
            begin
                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                Print := Print or not CurrReport.PREVIEW;
                TempPrintedPurchHeader.RESET();
                TempPrintedPurchHeader.DELETEALL();
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
                    Caption = 'Options';
                    field(NoofCopies; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Copies';
                        ToolTip = 'Enter the number of copies to print. The default value is 0, which means that only one copy will be printed.';
                    }
                    field(SetReceiptStatus; SetReceiptStatus)
                    {
                        ApplicationArea = All;
                        Caption = 'Set Receipt Status';
                        OptionCaption = 'Open,Order Printed,Order Sent,Order Confirmed,To Receive,Receipt Completed,Invoice';
                        ToolTip = 'Select the receipt status to which the purchase order will be updated after printing. This option is only applicable when printing the purchase order. The default value is "Order Printed".';
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
        begin
            // BC Upgrade KUMARS145 modified the old code use the new fields...>>
            // ArchiveDocument := PurchSetup."Archive Quotes and Orders";
            if (PurchSetup."Archive Orders" = true) or (PurchSetup."Archive Quotes" = PurchSetup."Archive Quotes"::Always) then
                ArchiveDocument := true
            else
                ArchiveDocument := false;
            // BC Upgrade KUMARS145 modified the old code use the new fields...<<

            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch. Ord.") <> '';

            LogInteractionEnable := LogInteraction;
            SetReceiptStatus := SetReceiptStatus::"Order Printed";
        end;
    }

    labels
    {
        LblCode = 'Material';
        LblDescription = 'Material Description';
        label(lblExpectedReceiptDate; ENU = 'Expected Receipt Date', FRA = 'Date de réception prévue')
        LblQty = 'Quantity';
        LblUOM = 'UOM';
        LblUnitCost = 'Net Price';
        LblVATPer = 'Vat %';
        lblLineDiscPerc = 'Disc.%';
        LblAmount = 'Net Value';

    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        PurchSetup.GET();

        CompanyInfo1.GET();
        CompanyInfo1.CALCFIELDS(Picture);
        CompanyInfo1.CALCFIELDS("Signature Image FND");
    end;

    var
        UserRec1: Record User;
        Text000: TextConst ENU = 'Purchaser', NLD = 'Aanvrager', NLB = 'Aanvrager';
        Text001: TextConst ENU = 'Total %1', NLD = 'Totaal %1';
        Text002: TextConst ENU = 'Total %1 Incl. VAT', NLD = 'Totaal %1 Incl. omzetbelasting';
        Text003: TextConst ENU = ' COPY', NLD = 'KOPIE';
        Text004: TextConst ENU = 'Ordering %1', NLD = 'Bestelling %1';
        Text005: TextConst ENU = 'Page %1', NLD = 'Pagina%1';
        Text006: TextConst ENU = 'Total %1 Excl. VAT', NLD = 'Totaal %1 excl. omzetbelasting ';
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrePmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        PurchLine: Record "Purchase Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        PrepmtDimSetEntry: Record "Dimension Set Entry";
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        LanguageRec: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        PurchSetup: Record "Purchases & Payables Setup";
        User: Record User;
        PurchCountPrinted: Codeunit "Purch.Header-Printed";
        FormatAddr: Codeunit "Format Address";
        PurchPost: Codeunit "Purch.-Post";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        PurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ShipToCompanyAddr: array[8] of Text[50];
        BuyFromAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text007: TextConst ENU = 'VAT Amount Specification in ', NLD = 'Omzetbelasting bedrag specificatie in';
        Text008: TextConst ENU = 'Local Currency', NLD = 'Lokale munteenheid';
        Text009: TextConst ENU = 'Exchange rate: %1/%2', NLD = 'Wisselkoers: %1/%2';
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        PricesInclVATtxt: Text[30];
        AllowInvDisctxt: Text[30];
        ArchiveDocumentEnable: Boolean;
        LogInteractionEnable: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        CompanyInfo1: Record "Company Information";
        Vendor: Record Vendor;
        TransportMethod: Record "Transport Method";
        // BC Upgrade KUMARS145 Replaced the obsolete record....>>
        // ItemCrossRef: Record "Item Cross Reference";
        ItemCrossRef: Record "Item Reference";
        // BC Upgrade KUMARS145 Replaced the obsolete record....<<
        "HIT8006.71": Integer;
        recLocation: Record Location;
        SetReceiptStatus: Option Open,"Order Printed","Order Sent","Order Confirmed","To Receive","Receipt Completed",Invoice;
        txtLocationFaxNo: Text[30];
        txtLocationEmail: Text[80];
        txtLocationPhoneNo: Text[30];
        Print: Boolean;
        TempPrintedPurchHeader: Record "Purchase Header" temporary;
        Text52003: TextConst ENU = 'VAT %1 ', NLD = 'Omzetbelasting %1';
        HdrDimCaptionLbl: TextConst ENU = 'Header Dimensions', NLD = 'Omzetbelasting %1';
        LineDimCaptionLbl: TextConst ENU = 'Line Dimensions', NLD = 'Regel dimensies';
        PaymentDetailsCaptionLbl: TextConst ENU = 'Payment Details', FRA = 'Lubumbashi', NLD = 'Betalingsvoorwaarden';
        VendNoCaptionLbl: TextConst ENU = 'Vendor No.', NLD = 'Leveranciersnummer';
        PrepmtInvBuDescCaptionLbl: TextConst ENU = 'Description', NLD = 'Omschrijving';
        PrepmtInvBufGLAccNoCaptionLbl: TextConst ENU = 'G/L Account No.', NLD = 'Grootboekrekening no.';
        PrepaymentSpecCaptionLbl: TextConst ENU = 'Prepayment Specification', NLD = 'Vooruitbetaling specificatie';
        PrepymtVATAmtSpecCaptionLbl: TextConst ENU = 'Prepayment VAT Amount Specification', NLD = 'Omzetbelasting  specificatie vooruitbetaling ';
        LCYCode: Code[10];
        ReportTitle: TextConst ENU = 'Purchase Order No.', ESP = 'Orden de Compra No.', FRA = 'Bon de Commande No.', NLD = 'Aankoop order no.';
        Reprinted: TextConst ENU = 'Reprinted', ESP = 'Reimpreso', FRA = 'Rimprim', NLD = 'Herprint';
        PageCaption: TextConst ENU = 'Page', ESP = 'Pgina', FRA = 'Page', NLD = 'Pagina';
        OrderingParty: TextConst ENU = 'ORDERING PARTY:', ESP = 'COMPAÑÍA QUE ORDENA:', FRA = 'DONNEUR D''ORDRE:', NLD = 'AANKOPENDE PARTIJ:', NLB = 'AANKOPENDE PARTIJ:';
        TaxIdentification: TextConst ENU = 'VAT Number:', ESP = 'Número de Identificación de Impuestos:', FRA = 'Numero Identifiant Fiscal:', NLD = 'Belasting identificatie:';
        ContactPerson: TextConst ENU = 'Contact person:', ESP = 'Persona de Contacto:', FRA = 'Personne à contacter:', NLD = 'Contactpersoon:';
        Phone: TextConst ENU = 'Phone:', ESP = 'Teléfono:', FRA = 'Téléphone:', NLD = 'Telefoon:';
        VendorCaption: TextConst ENU = 'VENDOR:', ESP = 'PROVEEDOR:', FRA = 'FOURNISSEUR:', NLD = 'LEVERANCIER:';
        TaxIdentificationNumber: TextConst ENU = 'Tax Identification Number:', ESP = 'Número de Identificación de Impuestos:', FRA = 'RCCM:', NLD = 'Belasting vast nummer:';
        EUVATNumber: TextConst ENU = 'VAT Number:', ESP = 'EU VAT Number:', FRA = 'Numero Identifiant Fiscal:', NLD = 'Omzetbelastingnummer:';
        YourVendorNoWithUs: TextConst ENU = 'Your Vendor Number with us:', ESP = 'Su número de proveedor con nosotros:', FRA = 'Votre numéro de fournisseur avec nous:', NLD = 'Uw leveranciersnummer bij ons:';
        PleaseDeliverGoodsTo: TextConst ENU = 'PLEASE DELIVER GOODS TO:', ESP = 'FAVOR ENTREGAR MERCANCÍA A:', FRA = 'VEUILLEZ LIVRER LES MARCHANDISES À:', NLD = 'A.U.B. GOEDEREN AANLEVEREN TE:';
        PlantOpeningHrs: TextConst ENU = 'Plant opening hrs:', ESP = 'Horario:', FRA = 'Horaires d''ouverture du site:', NLD = 'Openingstijden:';
        PleaseDeliverInvoiceTo: TextConst ENU = 'PLEASE DELIVER INVOICE TO:', ESP = 'FAVOR ENTREGAR FACTURA A:', FRA = 'VEUILLEZ TRANSMETTRE LA FACTURE À:', NLD = 'A.U.B. FACTUUR AANLEVEREN AAN:';
        DeliveryTerms: TextConst ENU = 'Delivery Terms:', ESP = 'Términos de entrega:', FRA = 'Conditions de Livraison:', NLD = 'Leveringsvoorwaarden:';
        DocumentDate: TextConst ENU = 'Document Date:', ESP = 'Fecha del documento:', FRA = 'Date de document:', NLD = 'Document Datum:';
        DeliveryDate: TextConst ENU = 'Delivery Date:', ESP = 'Fecha de Entrega:', FRA = 'Date de Livraison:', NLD = 'Leveringsdatum:';
        PaymentTermsCaption: TextConst ENU = 'Payment Terms:', ESP = 'Términos de Pago:', FRA = 'Conditions de Paiement:', NLD = 'Betalingsvoorwaarden:';
        Incoterms: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:', NLD = 'Incoterm voorwaarden:';
        Currency: TextConst ENU = 'Currency:', ESP = 'Moneda:', FRA = 'Devise:', NLD = 'Munteenheid:';
        OperationalContractRef: TextConst ENU = 'Operational Contract ref:', ESP = 'Referencia del contrato operacional:', FRA = 'Référence du contrat opérationnel:', NLD = 'Operationeel contract ref:';
        LegalContractReference: TextConst ENU = 'Legal Contract Reference:', ESP = 'Referencia legal del contrato:', FRA = 'Référence du contrat legal:', NLD = 'Juridisch contract referentie:';
        ContractContactPerson: TextConst ENU = 'Contract Contact Person:', ESP = 'Contacto:', FRA = 'Personne à contacter:', NLD = 'Contract contactpersoon:';
        ItemCaption: TextConst ENU = 'Item', ESP = 'Artículo', FRA = 'Article', NLD = 'Item';
        Material: TextConst ENU = 'Material', ESP = 'Material', FRA = 'Matériel', NLD = 'Materiaal';
        MaterialDescription: TextConst ENU = 'Material Description', ESP = 'Descripción del material', FRA = 'Description du matériel', NLD = 'Materiaal omschrijving';
        QuantityCaption: TextConst ENU = 'Quantity', ESP = 'Cantidad', FRA = 'Quantité', NLD = 'Hoeveelheid';
        UoM: TextConst ENU = 'UoM', ESP = 'Unidad de Medición', FRA = 'Unité de mesure', NLD = 'Maateenheid';
        NetPrice: TextConst ENU = 'Net Price', ESP = 'Precio Neto', FRA = 'Prix Net', NLD = 'Nettoprijs ';
        NetValue: TextConst ENU = 'Net Value', ESP = 'Valor Neto', FRA = 'Valeur Nette', NLD = 'Netto waarde';
        PurchaseOrderValue: TextConst ENU = 'PURCHASE ORDER VALUE:', ESP = 'VALOR DEL PEDIDO:', FRA = 'VALEUR DE LA COMMANDE: ', NLD = 'AANKOOP ORDER WAARDE:';
        CR: TextConst ENU = 'CR:', ESP = 'CR:', FRA = 'CR:', NLD = 'CR:';
        VAT: TextConst ENU = 'VAT:', ESP = 'VAT:', FRA = 'VAT:', NLD = 'Omzetbelasting:';
        LegalTextBox1Bralima: Label 'Bralima S.A reserves the right to cancel without any prejudice the lines from the purchase order, which will not be delivered following the date of receipt indicated above.Bralima S.A reserves the right to cancel without any prejudice the lines from the purchase order, which will not be delivered following the date of receipt indicated above.';
        LegalTextBox2Bralima: Label 'The invoice to be submitted to Bralima S.A has to include the number of this purchase order and comply with the relevant regulations, otherwise it will be rejected and returned to the supplier.';
        LegalTextBox3Bralima: Label 'Please acknowledge the receipt of this order by sending a confirmation per email.N.B: Payment in Congolese Francs at the intermediate rate (BCDC rate + BCC rate)/2 Please acknowledge the receipt of this order by sending a confirmation per email. N.B: Payment in Congolese Francs at the intermediate rate (BCDC rate + BCC rat';
        ApprovedBy: TextConst ENU = 'Approved by:', ESP = 'Aprobado por:', FRA = 'Approuvé par:';
        Item: Record Item;
        MachineRefNo: TextConst ENU = 'Machine Reference Number', ESP = 'Machine Reference Number', FRA = 'Machine Reference Number';
        PurchCommentLine: Record "Purch. Comment Line";
        PurchComment: Text[250];
        i: Integer;
        PurchaseLine: Record "Purchase Line";
        VATPer: Decimal;
        VATPerText: Text[30];
        TempVATAmountLine1: Record "VAT Amount Line" temporary;
        VatAmt: Decimal;
        VendCommentLine: Record "Comment Line";
        VendComment: Text[250];
        LegalText: Text;
        LegalTextBox1DUTBralima: TextConst ENU = 'La Bralima S.A se réserve le droit d''annuler toutes lignes des commandes qui ne seront pas livrées suivant la date de réception indiquée ci-dessus, sans aucun préjudice.La Bralima S.A se réserve le droit d''annuler toutes lignes des commandes qui ne seront pas livrées suivant la date de réception indiquée ci-dessus, sans aucun préjudice.', NLD = 'Gelieve uw PO Nummer te vermelden op de Leveringsnota en Factuur. ZONDER HET PO NUMMER OP UW FACTUUR WORDT UW FACTUUR NIET IN BEHANDELINGGENOMEN. Als u niet kunt leveren op de aangegeven leverdatum dient u onmiddellijk na ontvangst van deze Purchase Order contact op te nemen met de op dit document vermlede Surinaamse Brouwerij N.V. contactpersoon. De Purchase Order wordt uitgegeven door de Surinaamse Brouwerij N.V..';
        LegalTextBox2DUTBralima: TextConst
           ENU = 'La facture à déposer à la Bralima S.A doit reprendre le numéro du présent bon de commande et être conforme à la reglémentation en la matière, sinon elle sera rejetée et retournée au Fournisseur.',
          NLD = 'De partijen gaan akkoord met de levering en verwerving van degoederen en/of diensten onder de voorwaarden en bepalingen uiteengezet in dit besluit, in deze is de versie van de Algemene Inkoopvoorwaarden Surinaamse Brouwerij N.V. met nummer 15-2965 van kracht op de datum van deze Bestelling en/of enige aanvullende overeenkomstmet de relevante Leverancier voor deze Bestelling. Voor zover er inconsistenties zijn tussen de bepalingen en de voorwaarden van deze overeenkomsten, is de volgorde van voorrang; deze Order, de relevante aanvullende overeenkomst met de Leverancier, dan deAlgemene Inkoopvoorwaarden Surinaamse Brouwerij. De Algemene inkoopvoorwaarden Surinaamse Brouwerij N.V. zijn aan u toegezonden of zijn verkrijgbaar door contact op te nemen met de op dit document vermelde Surinaamse Brouwerij N.V. contactpersoon. Door aanvaarding van deze Order aanvaardt de Leverancier de hierin vermelde';
        LegalTextBox3DUTBralima: TextConst
          ENU = 'Prière d''accuser réception de ce bon de commande par retour mail. N.B : Le paiement en Francs congolais au taux intermédiaire (Taux BCDC + Taux BCC)/2',
          NLD = ' Algemene Voorwaarden, de Algemene Voorwaarden van de Bestellingen indien van toepassing, de algemene voorwaarden van aanvullende overeenkomsten met de Leverancier die relevant zijn voor deze Purchase Order. Aangehecht ontvangt u de goedgekeurde Purchase Order. Graag ontvangen wij binnen 48 uur een orderbevestiging vanu. Belangrijke specifieke informatie: *Facturatie: Gelieve uw facturen te e-mailen naar: invoice.surbrouw@parbobier.com. Voor een vlotte afhandeling van de facturen dienthet Purchase Order nummer vermeld te zijn op de factuur als referentie.';
        Footer: Label '- Brouwerijweg 1 - P.O. Box 1854 - Paramaribo - Suriname';
        VATID: Label 'VAT ID :';
        POText: BigText;
        MemoReader: InStream;
        // BC Upgrade KUMARS145 Dotnet variables are commented....>>
        // StringHelper: DotNet "'mscorlib'.System.String";
        // BC Upgrade KUMARS145 Dotnet variables are commented....<<
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        ContactPersonTxt: Text;
        UsrName: Code[50];
        UserRec: Record User;
        ContractcontpersonTxt: Text;
        ContrContPerUsrName: Code[50];
        PurchaserCode: Code[10];
        ApprovalUserRec: Record "User Setup";
        ExpRecDtLbl: TextConst ENU = 'Expected Receipt Date', FRA = 'Date de réception prévue';
        IncotermsLocLbl: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:';
        OrderDateLbl: TextConst ENU = 'Order Date:', FRA = 'Date de commande:';
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        POChanged: Integer;
        POLineStatus: Text;
        ShowAddr: Boolean;
        ShowAddr2: Boolean;
        ShowCityPostCode: Boolean;
        ShowContact: Boolean;
        ShowCountryRegion: Boolean;
        PurchaseReasonCode: Record "Reason Code_Purchase FND";
        ReasonCodeDescription: Text;
        ReasonCodeDescriptionLbl: Label 'Reason Code:';
        LegalTextBox1BOUKIN: Label 'Bralima S.A reserves the right to cancel without any prejudice the lines from the purchase order, which will not be delivered following the date of receipt indicated above.Bralima S.A reserves the right to cancel without any prejudice the lines from the purchase order, which will not be delivered following the date of receipt indicated above.';
        LegalTextBox2BOUKIN: Label 'The invoice to be submitted to Bralima S.A has to include the number of this purchase order and comply with the relevant regulations, otherwise it will be rejected and returned to the supplier.';
        LegalTextBox3BOUKIN: Label 'Please acknowledge the receipt of this order by sending a confirmation per email. N.B: Payment in Congolese Francs at the intermediate rate (BCDC rate + BCC rate)/2 Please acknowledge the receipt of this order by sending a confirmation per email. N.B: Payment in Congolese Francs at the intermediate rate (BCDC rate + BCC rat';
        ApprovalEntryRec: Record "Approval Entry";
        ApprovalUser: Text;
        ApprovalDate: Date;
        ApprovalUserTxt: TextConst ENU = 'Approved by:', FRA = 'Approuvé par:';
        ApprovalDateTxt: TextConst ENU = 'Date of Approval:', FRA = 'Date d''approbation:';
        LicenseCode: Text;
        PurchHdrAddRec: Record "Purchase Header Additional FND";
        LicenseCodeLbl: TextConst ENU = 'License Code:', FRA = 'Code de licence:';
        FooterBralimaFrench: Label 'BRALIMA S.A depuis 1923, Capital Social : 114.045.980.102 FC KINSHASA - KISANGANI - BUKAVU - LUBUMBASHI Primus - Turbo King - Mutzig - Heineken - Legend - Maltina - Energy Malt - Coca-Cola - Fanta - Sprite - Vital''O - Schweppes - Fayrouz';
        FooterBralimaEnglish: Label 'BRALIMA S.A since 1923, Social Capital : 114.045.980.102 CDF KINSHASA - KISANGANI - BUKAVU - LUBUMBASHI Primus - Turbo King - Mutzig - Heineken - Legend - Maltina - Energy Malt - Coca-Cola - Fanta - Sprite - Vital''O - Schweppes - Fayrouz';
        FooterBokinEnglish: Label 'Boukin Sarl Social Capital : 7.800.309,46 CDF Head office adress: 10651, Serge Moke Street, Ngaliema District';
        FooterBokinFrench: Label 'Boukin Sarl Capital Social : 7.800.309,46 FC Adresse du siège social: Avenue Serge Moke, Commune de Ngaliema';
        FooterText: BigText;
        MemoReader_1: InStream;
        CommentsLbl: TextConst ENU = 'Comments', FRA = 'Commentaires';
        grec_UserSetup: Record "User Setup";

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;

    local procedure GetLanguageID(LanguageCode: Code[10]): Integer
    var
        languageRecLocal: Record Language;
    begin
        if languageRecLocal.Get(LanguageCode) then
            exit(languageRecLocal."Windows Language ID");
        exit(0);
    end;
}

