report 52040 "Purchase Order TNG"
{
    // version HEI.12

    // HEI.01 FDD-AL-PURGAP01 IBM NASTAA02 28.09.2017 # Purchase Order Layout Local Algeria
    //   # New Report created based on the standard layout
    // 
    // HEI.02 FDD-AL-PURGAP01 Defect #719 IBM NASTAA02 23.10.2017 # Purchase Order Layout Local Algeria
    //   # Currency Code should always be filled-in on the layout
    // 
    // HEI.03 Defect #621 IBM NASTAA02 31.10.2017 # Purchase Order Layout Language selection
    //   # Labels are not showing the correct ML Caption depending on Language Code
    // 
    // HEI.04 Defect #818 IBM NASTAA02 15.11.2017 # Maximo Requision No visible on the Layout
    //   # Added "Machine Reference Number" on the Layout
    // 
    // HEI.05 Defect #852 IBM NASTAA02 15.11.2017 # Purchase order printing form
    //   # Calculated the Total Amount Excl. VAT As the SUM of the Net Value
    // 
    // HEI.06 FDD-PURGAP030 - Send updated PO to supplier with specified  changes_V1.1 , NAIKH01 , 03.28.2019
    //   #Added new code.
    //   # Also added new Column "Comments" in the Reports design and added a new table in report design.
    // 
    // HEI.07 FDD-CHG2028965 IBM SURYAS01 31/10/2019
    // #Added New table for vendor Comments in Layout
    // # Added New table for Purchase Comments in layout
    // #Changed delivery date value from Purchase header to Purchase line Expected Receipt date.
    // 
    // HEI.08 HLP-403 CHG2040516 IBM SAXENS01 16/01/2020
    //   Hide rows in report for removal of VAT from Report
    // 
    // HEI.09 FDD-HB858 - CHG2027215 SHANKJ03 IBM 29.01.2020
    //   # Payment terms code Changed to Payment Terms Description
    //   # ContactCOntractPerson value changed based on FDD condition
    //   # Removed Delivery Date from layout
    //   # Incoterm Caption changed to Incoerm Location
    //   # Incoterm Value changed from Shipment method location to Shipment method Code
    //   # Approved By is made hidden in layout
    //   # Document date is changed to Order Date
    // HEI.10 CHG2162272 - HB3023 SHIVAS05 IBM 28.07.2022
    //   # Using Company info address details in place of Hardcoded address on the layout.
    // HEI.11 HB2907 CHG2157356 IBM SHIVAS05 31.08.2022
    //   # Find Contact Person Email form user setup on the basis of Created By user
    // HEI.12 CHG2298673 SHARMP16 14.05.2025 HB4280 Add a field in the PO print Out -Development finetuning
    //   # Add Vendor Order No. Lbl and Your Reference field in report

    // BC Upgrade KUMARS145 Old ID Report 50042 "Purchase Order TNG"

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Purchase Order TNG.rdl';

    CaptionML = ENU = 'Purchase Order',
                ESP = 'Orden de Compra',
                FRA = 'Bon de Commande';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(HQFixAdd1; HQFixAdd1) { }
            column(HQFixAdd2; HQFixAdd2) { }
            column(HQFixAdd3; HQFixAdd3) { }
            column(HQFixAdd4; HQFixAdd4) { }
            column(LegaltextH1; LegaltextH1) { }
            column(LegaltextH2; LegaltextH2) { }
            column(LegaltextH3; LegaltextH3) { }
            column(LegaltextH4; LegaltextH4) { }
            column(LegalTextBoxLbl; LegalTextBox) { }
            column(VATAmountLbl; VATAmountCaption) { }
            column(TotalAmountInclVATLbl; TotalAmountInclVATCaption) { }
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
            column(POpenhourslbl; POpenhourslbl) { }
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
            column(PurchaseHeader_DocumentType; "Document Type") { }
            column(PurchaseHeader_No; "No.") { }
            column(PurchaseHeader_NoPrinted; "No. Printed") { }
            column(PurchaseHeader_ContactPersonName; User."Full Name") { }
            column(PurchaseHeader_ContactPersonEmail_Remove; UserRec."Contact Email") { }
            column(PurchaseHeader_ContactPersonEmail; UserSetup."E-Mail") { }
            column(PaymentTerm_Description; PaymentTerms.Description) { }
            column(POHeaderMark; POHeaderMark) { }
            column(POChanged; POChanged) { }
            column(ShowAddr; ShowAddr) { }
            column(ShowAddr2; ShowAddr2) { }
            column(ShowCityPostCode; ShowCityPostCode) { }
            column(ShowContact; ShowContact) { }
            column(ShowCountryRegion; ShowCountryRegion) { }
            column(ExpRecDtLbl; ExpRecDtLbl) { }
            column(IncotermsLocLbl; IncotermsLocLbl) { }
            column(OrderDateLbl; OrderDateLbl) { }
            column(PurchaseHeader_OrderDate; "Purchase Header"."Order Date") { }
            column(PurchaseHeader_ContactPersonNameNew; ContactPersonTxt) { }
            // BC Upgrade KUMARS145 DotNet Vatiable commented.....>>
            // column(testremark; StringHelper.Copy(FORMAT(POTextNew))) { }
            column(testremark; FORMAT(POTextNew)) { }
            // BC Upgrade KUMARS145 DotNet Vatiable commented.....>>
            column(PurchaseHeader_ContractcontpersonTxt; ContractcontpersonTxt) { }
            column(ReasonCodeDescription; ReasonCodeDescription) { }
            column(ReasonCodeDescriptionLbl; ReasonCodeDescriptionLbl) { }
            column(HouseNumber_PurchaseHeader; "Purchase Header"."House Number FND") { }
            column(VendorOrderNoLbl; VendorOrderNoLbl) { }
            column(YourReference_PurchaseHeader; "Purchase Header"."Your Reference") { }
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
                    // BC Upgrade KUMARS145 Drinkit field commented....>>
                    // column(Vendor_TaxRegistrationNo; "Purchase Header"."Vendor Tax Registration No."){}
                    column(Vendor_TaxRegistrationNo; '') { }
                    // BC Upgrade KUMARS145 Drinkit field commented....<<
                    column(EUVATNumber; "Purchase Header"."VAT Registration No.") { }
                    column(Vendor_Contact; Vendor.Contact) { }
                    column(Vendor_Email; Vendor."E-Mail") { }
                    column(PurchaseHeader_DocumentDate; FORMAT("Purchase Header"."Document Date", 0, 4)) { }
                    column(PurchaseHeader_ExpectedReceiptDate; "Purchase Header"."Expected Receipt Date") { }
                    column(PurchaseHeader_PaymentTerms; "Purchase Header"."Payment Terms Code") { }
                    column(PurchaseHeader_IncoTerms; "Purchase Header"."Shipment Method Code") { }
                    column(PurchaseHeader_IncoTermsNew; "Purchase Header"."Shipment Method Code") { }
                    column(PurchaseHeader_Currency; LCYCode) { }
                    column(PurchaseHeader_OperationalContractNo; "Purchase Header"."SRM Contract No. FND") { }
                    column(PurchaseHeader_OperationalContractRef; "Purchase Header"."SRM Contract Name FND") { }
                    column(PurchaseHeader_ContractContactNo; "Purchase Header"."Pay-to Contact") { }
                    column(OutputNo; OutputNo) { }
                    column(ShowInternalInfo; ShowInternalInfo) { }
                    column(DimText; DimText) { }
                    column(ExpectedReceiptDate_PurchaseLine; FORMAT(DeliveryDate1, 10, '<Day,2>/<Month,2>/<Year4>')) { }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(HdrDimCaption; HdrDimCaptionLbl) { }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FindSet() then
                                    CurrReport.Break();
                            end else
                                if not Continue then
                                    CurrReport.Break();

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
                                CurrReport.Break();
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
                                PurchCommentLine.FindFirst()
                            else
                                PurchCommentLine.Next();

                            PurchComment := PurchCommentLine.Comment;
                        end;

                        trigger OnPreDataItem();
                        begin
                            PurchCommentLine.Reset();
                            PurchCommentLine.SETRANGE("Document Type", PurchCommentLine."Document Type"::Order);
                            PurchCommentLine.SETRANGE("No.", "Purchase Header"."No.");
                            // BC Upgrade KUMARS145 Drinkit field commented....>>
                            // PurchCommentLine.SETRANGE("Print On Purchase Order", true);
                            // BC Upgrade KUMARS145 Drinkit field commented....<<

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
                                VendCommentLine.FindFirst()
                            else
                                VendCommentLine.Next();

                            VendComment := VendCommentLine.Comment;
                        end;

                        trigger OnPreDataItem();
                        begin
                            VendCommentLine.Reset();
                            VendCommentLine.SETRANGE("Table Name", VendCommentLine."Table Name"::Vendor);
                            VendCommentLine.SETRANGE("No.", "Purchase Header"."Buy-from Vendor No.");
                            // BC Upgrade KUMARS145 Drinkit field commented....>>
                            // VendCommentLine.SETRANGE("Print On Purchase Order", true);
                            // BC Upgrade KUMARS145 Drinkit field commented....<<

                            SETRANGE(Number, 1, VendCommentLine.Count);
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem();
                        begin
                            CurrReport.Break();
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
                        column(VATAmount; VATAmount) { }
                        column(TotalAmountIncludingVAT; TotalAmountInclVAT) { }
                        column(Type_PurchLine; FORMAT("Purchase Line".Type, 0, 2)) { }
                        column(LineAmt2_PurchLine; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(MachineRefNoCaption; MachinerefNo) { }
                        column(Item_MachineReferenceNo; Item."Machine Reference Number FND") { }
                        column(POLineStatus; POLineStatus) { }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(LineDimCaption; LineDimCaptionLbl) { }

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FindSet() then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

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
                                until DimSetEntry2.Next() = 0;
                            end;

                            trigger OnPreDataItem();
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.Break();

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                PurchLine.FIND('-')
                            else
                                PurchLine.Next();
                            "Purchase Line" := PurchLine;

                            if not ItemCrossRef.Get("Purchase Line"."No.", "Purchase Line"."Variant Code", "Purchase Line"."Unit of Measure Code",
                              ItemCrossRef."Reference Type"::Vendor, "Purchase Line"."Buy-from Vendor No.", "Purchase Line"."Vendor Item No.") then
                                ItemCrossRef.Init();

                            if not "Purchase Header"."Prices Including VAT" and
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            then
                                PurchLine."Line Amount" := 0;

                            if (PurchLine.Type = PurchLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Purchase Line"."No." := '';
                            AllowInvDisctxt := FORMAT("Purchase Line"."Allow Invoice Disc.");
                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line".Amount;

                            //HEI.04>>
                            if "Purchase Line".Type = "Purchase Line".Type::Item then
                                if Item.Get("Purchase Line"."No.") then;
                            //HEI.04<<

                            //>>HEI.06
                            POLineStatus := '';
                            if "Purchase Header"."Changed FND" then begin
                                PurchaseDocumentLog.Reset();
                                PurchaseDocumentLog.SETRANGE("Document Type", PurchaseDocumentLog."Document Type"::Order);
                                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Line"."Document No.");
                                PurchaseDocumentLog.SETRANGE("Line No.", "Purchase Line"."Line No.");
                                PurchaseDocumentLog.SETRANGE(Printed, false);
                                PurchaseDocumentLog.SETRANGE(Comment, 'New Line Added');
                                if PurchaseDocumentLog.FindFirst() then
                                    POLineStatus := 'New';

                                PurchaseDocumentLog.Reset();
                                ;
                                PurchaseDocumentLog.SETRANGE("Document Type", PurchaseDocumentLog."Document Type"::Order);
                                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Line"."Document No.");
                                PurchaseDocumentLog.SETRANGE("Line No.", "Purchase Line"."Line No.");
                                PurchaseDocumentLog.SETRANGE(Printed, false);
                                PurchaseDocumentLog.SETFILTER(Comment, '<>%1&<>%2', 'New Line Added', 'Line Deleted');
                                if PurchaseDocumentLog.FindFirst() then
                                    POLineStatus := 'Changed';
                            end;
                            //<<HEI.06
                        end;

                        trigger OnPostDataItem();
                        begin
                            PurchLine.DeleteAll();
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
                                CurrReport.Break();
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
                                CurrReport.Break();
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

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", VATAmountLine."VAT Base", "Purchase Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", VATAmountLine."VAT Amount", "Purchase Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem();
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or ("Purchase Header"."Currency Code" = '') or (VATAmountLine.GetTotalVATAmount() = 0) then
                                CurrReport.Break();

                            SETRANGE(Number, 1, VATAmountLine.Count);
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
                                CurrReport.Break();
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
                                CurrReport.Break();
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
                        column(PrepmtVATAmountText; PrepmtVATAmountLine.VATAmountText) { }
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
                                    if not PrepmtDimSetEntry.FindSet() then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

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
                                until PrepmtDimSetEntry.Next() = 0;
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not PrepmtInvBuf.FIND('-') then
                                    CurrReport.Break();
                            end else
                                if PrepmtInvBuf.Next() = 0 then
                                    CurrReport.Break();

                            if ShowInternalInfo then
                                PrepmtDimSetEntry.SETRANGE("Dimension Set ID", PrepmtInvBuf."Dimension Set ID");

                            if "Purchase Header"."Prices Including VAT" then
                                PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            else
                                PrepmtLineAmount := PrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem();
                        begin
                            CurrReport.CREATETOTALS(PrepmtInvBuf.Amount, PrepmtInvBuf."Amount Incl. VAT", PrepmtVATAmountLine."Line Amount", PrepmtVATAmountLine."VAT Base", PrepmtVATAmountLine."VAT Amount", PrepmtLineAmount);
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
                    dataitem(PurchDocLog; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(PurchDocLog_DocNo; TEMPPurchaseDocumentLog."Document No.") { }
                        column(PurchDocLog_LineNo; TEMPPurchaseDocumentLog."Line No.") { }
                        column(PurchDocLog_Comments; TEMPPurchaseDocumentLog.Comment) { }
                        column(PurchDocLog_No; TEMPPurchaseDocumentLog."No.") { }
                        column(PurchDocLog_Desc; TEMPPurchaseDocumentLog.Description) { }
                        column(PurchDocLog_Quantity; TEMPPurchaseDocumentLog.Quantity) { }
                        column(PurchDocLog_UOM; TEMPPurchaseDocumentLog."Unit of Measure") { }
                        column(PurchDocLog_DirectUnitCost; TEMPPurchaseDocumentLog."Direct Unit Cost") { }
                        column(PurchDocLog_LineAmount; TEMPPurchaseDocumentLog."Line Amount") { }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                TEMPPurchaseDocumentLog.FIND('-')
                            else
                                TEMPPurchaseDocumentLog.Next();
                            //HEI.06
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(Number, 1, TEMPPurchaseDocumentLog.COUNT);
                            //>>HEI.06
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
                    PurchLine.DeleteAll();
                    VATAmountLine.DeleteAll();
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := VATAmountLine.GetTotalVATBase();
                    VATDiscountAmount := VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT();

                    PrepmtInvBuf.DeleteAll();
                    PurchPostPrepmt.GetPurchLines("Purchase Header", 0, PrepmtPurchLine);
                    if not PrepmtPurchLine.IsEmpty then begin
                        PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        if not TempPurchLine.ISEMPTY then
                            PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPurchLine, PrePmtVATAmountLineDeduct, 1);
                    end;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    if PrepmtVATAmountLine.FindSet() then
                        repeat
                            PrePmtVATAmountLineDeduct := PrepmtVATAmountLine;
                            if PrePmtVATAmountLineDeduct.Find() then begin
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
                                PrepmtVATAmountLine.Modify();
                            end;
                        until PrepmtVATAmountLine.Next() = 0;
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    // BC Upgrade KUMARS145 Replaced with new procedure .....>>
                    // PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);
                    // BC Upgrade KUMARS145 Replaced with new procedure .....<<

                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount();
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase();
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT();

                    if Number > 1 then
                        CopyText := Text003;
                    CurrReport.PageNo := 1;
                    OutputNo := OutputNo + 1;

                    TotalSubTotal := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem();
                begin
                    if not CurrReport.Preview then
                        PurchCountPrinted.Run("Purchase Header");
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
                UserRecLocal: Record User;
            begin
                LanguageID := 0;

                LanguageID := GetLanguageID("Language Code");
                if LanguageID <> 0 then
                    CurrReport.LANGUAGE := GetLanguageID("Language Code");

                CompanyInfo.Get();

                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    //>>HEI.01
                    FormatAddr.RespCenter(ShipToCompanyAddr, RespCenter);
                    //<<HEI.01
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    //>>HEI.01
                    FormatAddr.FormatAddr(ShipToCompanyAddr, CompanyInfo.Name, CompanyInfo."Name 2", CompanyInfo."Ship-to Contact", CompanyInfo."Ship-to Address", CompanyInfo."Ship-to Address 2", CompanyInfo."Ship-to City", CompanyInfo."Ship-to Post Code", CompanyInfo."Ship-to County", CompanyInfo."Ship-to Country/Region Code");
                end;
                //<<HEI.01

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if "Purchaser Code" = '' then begin
                    SalesPurchPerson.Init();
                    PurchaserText := '';
                end else begin
                    SalesPurchPerson.Get("Purchaser Code");
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

                if Vendor.Get("Purchase Header"."Buy-from Vendor No.") then;

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                if "Buy-from Vendor No." <> "Pay-to Vendor No." then
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
                if "Payment Terms Code" = '' then
                    PaymentTerms.Init()
                else begin
                    PaymentTerms.Get("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;
                if "Prepmt. Payment Terms Code" = '' then
                    PrepmtPaymentTerms.Init()
                else begin
                    PrepmtPaymentTerms.Get("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                end;
                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init()
                else begin
                    ShipmentMethod.Get("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                end;

                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");

                if not CurrReport.Preview then begin
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    if LogInteraction then begin
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');
                    end;
                end;
                PricesInclVATtxt := FORMAT("Prices Including VAT");

                if TransportMethod.Get("Purchase Header"."Transport Method") then;

                //<<DITW18.00.06 BCE 11/08/2015 DIT-770 #1532
                recLocation.Reset();
                if recLocation.Get("Purchase Header"."Location Code") then begin
                    txtLocationPhoneNo := recLocation."Phone No.";
                    txtLocationEmail := recLocation."E-Mail";
                    txtLocationFaxNo := recLocation."Fax No.";
                end;
                //>>DITW18.00.06 BCE DIT-770 #1532

                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                if Print then begin
                    TempPrintedPurchHeader := "Purchase Header";
                    TempPrintedPurchHeader.Insert();
                end;
                //>> DITW18.00.07 VSC DIT-770 #1970

                //>>HEI.02
                if "Currency Code" = '' then
                    LCYCode := GLSetup."LCY Code"
                else
                    LCYCode := "Currency Code";
                //<<HEI.02
                //<<HEI.06
                if "Purchase Header"."Changed FND" then begin
                    PurchaseDocumentLog.Reset();
                    PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                    PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                    PurchaseDocumentLog.SETRANGE(Printed, false);
                    PurchaseDocumentLog.SETRANGE(Comment, 'Line Deleted');
                    if PurchaseDocumentLog.FindSet() then
                        repeat
                            TEMPPurchaseDocumentLog := PurchaseDocumentLog;
                            TEMPPurchaseDocumentLog.Comment := 'Cancelled';
                            TEMPPurchaseDocumentLog.Insert();
                        until PurchaseDocumentLog.Next() = 0;
                end;

                POHeaderMark := 0;
                POChanged := 0;

                if (TEMPPurchaseDocumentLog.COUNT >= 1) then
                    POHeaderMark := 1;

                ShowAddr := false;
                ShowAddr2 := false;
                ShowCityPostCode := false;
                ShowContact := false;
                ShowCountryRegion := false;

                PurchaseDocumentLog.Reset();
                PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                PurchaseDocumentLog.SETRANGE("Line No.", 0);
                PurchaseDocumentLog.SETRANGE(Printed, false);
                if PurchaseDocumentLog.FindSet() then
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
                    until PurchaseDocumentLog.Next() = 0;

                PurchaseDocumentLog.Reset();
                PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                PurchaseDocumentLog.SETFILTER("Line No.", '<>%1', 0);
                PurchaseDocumentLog.SETRANGE(Printed, false);
                if PurchaseDocumentLog.FindFirst() then
                    POChanged := 1;
                //>>HEI.06


                DeliveryDate1 := 0D;
                PurchLine1.Reset();
                PurchLine1.SETRANGE("Document No.", "No.");
                PurchLine1.SETRANGE("Document Type", "Document Type");
                if PurchLine1.FindSet() then begin
                    DeliveryDate1 := PurchLine1."Expected Receipt Date";
                end;


                //HEI.09>>
                CLEAR(PayTermsDesc);
                CLEAR(ContactPersonTxt);
                CLEAR(UsrName);
                CLEAR(ContractcontpersonTxt);
                CLEAR(ContrContPerUsrName);
                CLEAR(PurchaserCode);

                "Purchase Header".CALCFIELDS("House Number FND");
                //Payment terms Description
                PaymentTermsRec.Reset();
                if PaymentTermsRec.Get("Purchase Header"."Payment Terms Code") then
                    PayTermsDesc := PaymentTermsRec.Description;

                // Contact Person

                PurchasesPayablesSetup.Reset();
                PurchasesPayablesSetup.Get();
                if (PurchasesPayablesSetup."Allow printing C&TP PO FND" = true) and ("Purchase Header"."SRM Order No. FND" <> '') then
                    UsrName := ''
                else begin
                    if "Purchase Header"."Maximo Requisition No. FND" <> '' then
                        UsrName := "Purchase Header"."PQ Approver FND"
                    // BC Upgrade KUMARS145 Drinkit field commented.....>>
                    // else if "Purchase Header"."Quote No." <> '' then
                    //     UsrName := "Purchase Header"."Requester ID"
                    // else
                    //     UsrName := "Purchase Header"."Created By";
                    // // BC Upgrade KUMARS145 Drinkit field commented.....<<
                end;

                if UsrName <> '' then begin
                    UserRec.Reset();
                    UserRec.SETRANGE("User Name", UsrName);
                    if UserRec.FindFirst() then
                        ContactPersonTxt := UserRec."Full Name";
                end;

                //Contract Contact Person
                if "Purchase Header"."Channel FND" = '' then
                    ContrContPerUsrName := ''
                else if ("Purchase Header"."Channel FND" = 'A') or ("Purchase Header"."Channel FND" = 'D') then begin
                    PurchaserCode := "Purchase Header"."Purchaser Code";
                    ApprovalUserRec.Reset();
                    ApprovalUserRec.SETRANGE("Salespers./Purch. Code", PurchaserCode);
                    if ApprovalUserRec.FindSet() then
                        ContrContPerUsrName := ApprovalUserRec."User ID"
                end;

                if ContrContPerUsrName <> '' then begin
                    UserRec.Reset();
                    UserRec.SETRANGE("User Name", ContrContPerUsrName);
                    if UserRec.FindSet() then
                        ContractcontpersonTxt := UserRec."Full Name";
                end;


                PurchasesPayablesSetup.Get();
                PurchasesPayablesSetup.CALCFIELDS("PO Legal Text FND", "PO Legal Txt International FND");
                if Vendor."Language Code" <> CompanyInfo."Language Code FND" then begin
                    if PurchasesPayablesSetup."PO Legal Txt International FND".HasValue then begin
                        PurchasesPayablesSetup."PO Legal Txt International FND".CREATEINSTREAM(MemoReader);
                        POTextNew.READ(MemoReader);
                    end;
                end else begin
                    if PurchasesPayablesSetup."PO Legal Text FND".HASVALUE then begin
                        PurchasesPayablesSetup."PO Legal Text FND".CREATEINSTREAM(MemoReader);
                        POTextNew.READ(MemoReader);
                    end;
                end;


                if PurchaseReasonCode.Get("Purch. Reason Code FND") then
                    ReasonCodeDescription := PurchaseReasonCode.Description;

                //HEI.09<<
                // BC Upgrade KUMARS145 dependent on Drinkit field chnaged to base.....>>
                // if UserSetup.Get("Purchase Header"."Created By") then;//HEI.11
                if UserRecLocal.Get("Purchase Header".SystemCreatedBy) then
                    if UserSetup.Get(UserRecLocal."User Name") then;//HEI.11

                if UserRecLocal.Get("Purchase Header".SystemCreatedBy) then
                    if UserSetup.Get(UserRecLocal."User Name") then;//HEI.11
                // BC Upgrade KUMARS145 dependent on Drinkit field chnaged to base.....<<
            end;

            trigger OnPostDataItem();
            var
                PurchHeader: Record "Purchase Header";
            begin
                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                if Print then begin
                    if TempPrintedPurchHeader.FindSet() then
                        repeat
                            PurchHeader.Get(TempPrintedPurchHeader."Document Type", TempPrintedPurchHeader."No.");
                        // BC Upgrade KUMARS145 Drinkit field commented.....>>
                        // if PurchHeader."Receipt Status" < SetReceiptStatus then begin
                        //     PurchHeader.VALIDATE("Receipt Status", SetReceiptStatus);
                        //     PurchHeader.MODIFY(true);
                        // end;
                        // BC Upgrade KUMARS145 Drinkit field commented.....<<
                        until TempPrintedPurchHeader.Next() = 0;
                end;
            end;

            trigger OnPreDataItem();
            begin
                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                Print := Print or not CurrReport.Preview;
                TempPrintedPurchHeader.Reset();
                TempPrintedPurchHeader.DeleteAll();
                //>>HEI.01
                // BC Upgrade KUMARS145 Drinkit field commented.....>>
                // User.SETRANGE("User Name", "Last changed User ID");
                // if User.FindSet() then;
                // BC Upgrade KUMARS145 Drinkit field commented.....<<
                //<<HEI.01
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
                        ApplicationArea = all;
                        Caption = 'No. of Copies';
                    }
                    field(SetReceiptStatus; SetReceiptStatus)
                    {
                        ApplicationArea = all;
                        Caption = 'Set Receipt Status';
                        OptionCaption = 'Open,Order Printed,Order Sent,Order Confirmed,To Receive,Receipt Completed,Invoice';
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
            // BC Upgrade KUMARS145 old code changed to new .....>>
            // ArchiveDocument := PurchSetup."Archive Quotes and Orders";
            ArchiveDocument := (PurchSetup."Archive Orders") or (PurchSetup."Archive Quotes" = PurchSetup."Archive Quotes"::Always);

            // LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';
            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch. Ord.") <> '';
            // BC Upgrade KUMARS145 old code changed to new.....<<

            LogInteractionEnable := LogInteraction;
            SetReceiptStatus := SetReceiptStatus::"Order Printed";
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        GLSetup.Get();
        PurchSetup.Get();

        CompanyInfo1.Get();
        CompanyInfo1.CALCFIELDS(Picture);
    end;

    var
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label '" COPY"';
        Text004: Label 'Ordering %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        PurchLine1: Record "Purchase Line";
        DeliveryDate1: Date;
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
        Text007: Label '"VAT Amount Specification in "';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
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
        ItemCrossRef: Record "Item Reference";
        "HIT8006.71": Integer;
        recLocation: Record Location;
        SetReceiptStatus: Option Open,"Order Printed","Order Sent","Order Confirmed","To Receive","Receipt Completed",Invoice;
        txtLocationFaxNo: Text[30];
        txtLocationEmail: Text[80];
        txtLocationPhoneNo: Text[30];
        Print: Boolean;
        TempPrintedPurchHeader: Record "Purchase Header" temporary;
        HdrDimCaptionLbl: Label 'Header Dimensions';
        LineDimCaptionLbl: Label 'Line Dimensions';
        PaymentDetailsCaptionLbl: Label 'Payment Details';
        VendNoCaptionLbl: Label 'Vendor No.';
        PrepmtInvBuDescCaptionLbl: Label 'Description';
        PrepmtInvBufGLAccNoCaptionLbl: Label 'G/L Account No.';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        PrepymtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification';
        LCYCode: Code[10];
        LegalTextBox: TextConst
           ENU = 'The payment time countdown starts from the date the invoice was filed.In the absence of a specific agreement with the Tango SARL, the supplier accepts by default the General conditions mentioned on this purchase order. The Tango SARL reserves the right to apply a delay penalty of 0.5% per week of delay in relation to the promised delivery date or the date of completion of the service, this penalty shall not exceed 5% of the total amount of the purchase order. The Tango SARL reserves the right to cancel the order if any of the conditions stipulated in the purchase order are not complied with.',
          FRA = 'Le décompte du délai de paiement commence à partir de la date du dépôt de la facture.En l''absence d''un accord spécifique  conclu avec la Sarl Tango, le fournisseur accepte par défaut les conditions générales mentionnées sur ce bon de commande.La Sarl Tango se réserve le droit d''appliquer une pénalité de retard de 0.5% par semaine de retard par rapport à la date de livraison promise ou la date de la réalisation de la prestation, cette pénalité ne doit pas dépasser 5% du montant total du bon de commande.La Sarl Tango se réserve le droit d''annuler la commande si une des conditions stipulées dans le bon de commande n''est pas respectée.';
        VATAmountCaption: TextConst ENU = 'VAT Amount:', FRA = 'Montant de la TVA:';
        TotalAmountInclVATCaption: TextConst ENU = 'Total Amount including VAT:', FRA = 'Montant Total incluant la TVA:';
        ReportTitle: TextConst ENU = 'Purchase Order No.', ESP = 'Orden de Compra No.', FRA = 'Bon de Commande No.';
        Reprinted: TextConst ENU = 'Reprinted', ESP = 'Reimpreso', FRA = 'Réimprimé';
        PageCaption: TextConst ENU = 'Page', ESP = 'Página', FRA = 'Page';
        OrderingParty: TextConst ENU = 'ORDERING PARTY:', ESP = 'COMPAÑÍA QUE ORDENA:', FRA = 'DONNEUR D''ORDRE:';
        TaxIdentification: TextConst ENU = 'Tax Identification:', ESP = 'Número de Identificación de Impuestos:', FRA = 'Numero Identifiant Fiscal:';
        ContactPerson: TextConst ENU = 'Contact person:', ESP = 'Persona de Contacto:', FRA = 'Personne à contacter:';
        Phone: TextConst ENU = 'Phone:', ESP = 'Teléfono:', FRA = 'Téléphone:';
        VendorCaption: TextConst ENU = 'VENDOR:', ESP = 'PROVEEDOR:', FRA = 'FOURNISSEUR:';
        TaxIdentificationNumber: TextConst ENU = 'Tax Identification Number:', ESP = 'Número de Identificación de Impuestos:', FRA = 'Numero Identifiant Fiscal:';
        EUVATNumber: TextConst ENU = 'EU VAT Number:', ESP = 'EU VAT Number:', FRA = 'EU VAT Number:';
        YourVendorNoWithUs: TextConst ENU = 'Your Vendor Number with us:', ESP = 'Su número de proveedor con nosotros:', FRA = 'Votre numéro de fournisseur avec nous:';
        PleaseDeliverGoodsTo: TextConst ENU = 'PLEASE DELIVER GOODS TO:', ESP = 'FAVOR ENTREGAR MERCANCÍA A:', FRA = 'VEUILLEZ LIVRER LES MARCHANDISES À:';
        PlantOpeningHrs: TextConst ENU = 'Plant opening hrs:', ESP = 'Horario:', FRA = 'Horaires d''ouverture du site:';
        PleaseDeliverInvoiceTo: TextConst ENU = 'PLEASE DELIVER INVOICE TO:', ESP = 'FAVOR ENTREGAR FACTURA A:', FRA = 'VEUILLEZ TRANSMETTRE LA FACTURE À:';
        DeliveryTerms: TextConst ENU = 'Delivery Terms:', ESP = 'Términos de entrega:', FRA = 'Conditions de Livraison:';
        DocumentDate: TextConst ENU = 'Document Date:', ESP = 'Fecha del documento:', FRA = 'Date de document:';
        DeliveryDate: TextConst ENU = 'Delivery Date:', ESP = 'Fecha de Entrega:', FRA = 'Date de Livraison:';
        PaymentTermsCaption: TextConst ENU = 'Payment Terms:', ESP = 'Términos de Pago:', FRA = 'Conditions de Paiements:';
        Incoterms: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:';
        Currency: TextConst ENU = 'Currency:', ESP = 'Moneda:', FRA = 'Devise:';
        OperationalContractRef: TextConst ENU = 'Operational Contract ref:', ESP = 'Referencia del contrato operacional:', FRA = 'Référence du contrat opérationnel:';
        LegalContractReference: TextConst ENU = 'Legal Contract Reference:', ESP = 'Referencia legal del contrato:', FRA = 'Référence du contrat legal:';
        ContractContactPerson: TextConst ENU = 'Contract Contact Person:', ESP = 'Contacto:', FRA = 'Personne à contacter:';
        ItemCaption: TextConst ENU = 'Item', ESP = 'Artículo', FRA = 'Article';
        Material: TextConst ENU = 'Material', ESP = 'Material', FRA = 'Matériel';
        MaterialDescription: TextConst ENU = 'Material Description', ESP = 'Descripción del material', FRA = 'Description du matériel';
        QuantityCaption: TextConst ENU = 'Quantity', ESP = 'Cantidad', FRA = 'Quantité';
        UoM: TextConst ENU = 'UoM', ESP = 'Unidad de Medición', FRA = 'Unité de mesure';
        NetPrice: TextConst ENU = 'Net Price', ESP = 'Precio Neto', FRA = 'Prix Net';
        NetValue: TextConst ENU = 'Net Value', ESP = 'Valor Neto', FRA = 'Valeur Nette';
        PurchaseOrderValue: TextConst ENU = 'PURCHASE ORDER VALUE:', ESP = 'VALOR DEL PEDIDO:', FRA = 'VALEUR DE LA COMMANDE: ';
        CR: TextConst ENU = 'CR:', ESP = 'CR:', FRA = 'CR:';
        VAT: TextConst ENU = 'VAT:', ESP = 'VAT:', FRA = 'VAT:';
        ApprovedBy: TextConst ENU = 'Approved by:', ESP = 'Aprobado por:', FRA = 'Approuvé par:';
        Item: Record Item;
        MachinerefNo: TextConst ENU = 'Machine Reference Number', ESP = 'Machine Reference Number', FRA = 'Machine Reference Number';
        POpenhourslbl: TextConst ENU = '8:30 AM-5:00 PM', FRA = '8H30-17H00';
        HQFixAdd1: Label 'Head Quarter Bab Ezzouar';
        HQFixAdd2: TextConst ENU = 'Floor 6, North East Tower of the shopping centre', FRA = 'Etage 6, Tour Nord Est du Centre Commercial';
        HQFixAdd3: Label '16024 Bab Ezzouar';
        HQFixAdd4: TextConst ENU = 'Algeria', FRA = 'Algérie';
        LegaltextH1: TextConst ENU = 'The supplier must file:', FRA = 'Le fournisseur doit déposer :';
        LegaltextH2: TextConst ENU = 'The original invoice which must refer to the number of the purchase order of the company Tango', FRA = 'La facture originale qui doit obligatoirement faire référence aux numéros du bon de commande de la Sarl Tango.';
        LegaltextH3: TextConst ENU = 'For the goods: The original delivery order with acknowledgement of receipt of the Tango SARL; for service delivery: The original of the service is duly signed and sealed by both parties.', FRA = 'Pour la marchandise : Le bon de livraison original avec accusé de réception de la Sarl Tango ; pour une prestation de service : l''original du service fait dûment signé et cacheté par les deux parties.';
        LegaltextH4: TextConst ENU = 'A copy of the order form or a copy of the order confirmation email if agreed to proceed by electronic order', FRA = 'Une copie du bon de commande ou une copie du mail de confirmation du bon de commande si accord pour procéder par commande électronique.';
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        POLineStatus: Text;
        POChanged: Integer;
        POText: Text;
        TEMPPurchaseDocumentLog: Record "Purchase Document Log FND" temporary;
        POHeaderMark: Integer;
        ShowAddr: Boolean;
        ShowAddr2: Boolean;
        ShowCityPostCode: Boolean;
        ShowContact: Boolean;
        ShowCountryRegion: Boolean;
        VendCommentLine: Record "Comment Line";
        VendComment: Text[250];
        PurchCommentLine: Record "Purch. Comment Line";
        PurchComment: Text[250];
        PaymentTermsRec: Record "Payment Terms";
        PayTermsDesc: Text;
        ContactPersonTxt: Text;
        UsrName: Code[50];
        UserRec: Record User;
        ContractcontpersonTxt: Text;
        ContrContPerUsrName: Code[50];
        PurchaserCode: Code[10];
        ApprovalUserRec: Record "User Setup";
        MemoReader: InStream;
        // BC Upgrade KUMARS145 DotNet Vatiable commented.....>>
        // StringHelper: DotNet "'mscorlib'.System.String";
        // BC Upgrade KUMARS145 DotNet Vatiable commented.....<<
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        POTextNew: BigText;
        ExpRecDtLbl: TextConst ENU = 'Expected Delivery Date', FRA = 'Date de livraison prévue';
        IncotermsLocLbl: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:';
        OrderDateLbl: TextConst ENU = 'Order Date:', FRA = 'Date de commande';
        ReasonCodeDescription: Text;
        PurchaseReasonCode: Record "Reason Code_Purchase FND";
        ReasonCodeDescriptionLbl: Label 'Reason Code:';
        LanguageID: Integer;
        UserSetup: Record "User Setup";
        VendorOrderNoLbl: Label 'Vendor Order No. :';

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;

    local procedure GetLanguageID(LanguageCode: Code[10]): Integer
    var
        LanguageRecLocal: Record Language;
    begin
        if LanguageRecLocal.Get() then
            exit(LanguageRecLocal."Windows Language ID")
        else
            exit(WindowsLanguage);
    end;
}

