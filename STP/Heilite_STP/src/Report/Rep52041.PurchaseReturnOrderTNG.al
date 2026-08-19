report 52041 "Purchase Return Order TNG"
{
    // version HEI.09

    // HEI.01 FDD-AL-PURGAP01 IBM NASTAA02 28.09.2017 # Purchase Order Layout Local Algeria
    //   # New Report created based on the standard layout
    // 
    // HEI.02 FDD-AL-PURGAP01 Defect #719 IBM NASTAA02 23.10.2017 # Purchase Order Layout Local Algeria
    //   # Currency Code should always be filled-in on the layout
    // 
    // HEI.03 Defect #621 IBM NASTAA02 31.10.2017 # Purchase Order Layout Language selection
    //   # Labels are not showing the correct ML Caption depending on Language Code
    // 
    // HEI.04 Defect #853 IBM NASTAA02 7.11.2017 # Purchase Order Layout Template Procurement
    //   # Changed the Report Title ML captions
    // 
    // HEI.05 Defect #818 IBM NASTAA02 15.11.2017 # Maximo Requision No visible on the Layout
    //   # Added "Machine Reference Number" on the Layout
    // 
    // HEI.06 Defect #852 IBM NASTAA02 15.11.2017 # Purchase order printing form
    //   # Calculated the Total Amount Excl. VAT as the SUM of the Net Value
    // 
    // HEI.07 Defect #1900 IBM NASTAA02 11.04.2018 # Return Order form is not aligned with Purchase Order form
    //   # Moved the GetData function to the visibility of the TextBox because the data was not shown on the layout
    // HEI.08 CHG2162272 - HB3023 SHIVAS05 IBM 28.07.2022
    //   # Using Company info address details in place of Hardcoded address on the layout.
    // HEI.09 HB2907 CHG2157356 IBM SHIVAS05 31.08.2022
    //   # Find Contact Person Email form user setup on the basis of Created By user

    // BC Upgrade KUMARS145 Nav ID Report 50043 "Purchase Return Order TNG"

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Purchase Return Order TNG.rdl';

    CaptionML = ENU = 'Return Order',
                ESP = 'Orden de retorno',
                FRA = 'Commande de retour';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST("Return Order"));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Return Order';
            column(POpenhourslbl; POpenhourslbl) { }
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
            column(PurchaseHeader_No; "No.") { }
            column(PurchaseHeader_NoPrinted; "No. Printed") { }
            column(PurchaseHeader_ContactPersonName; User."Full Name") { }
            column(PurchaseHeader_ContactPersonEmail_Remove; User."Contact Email") { }
            column(PurchaseHeader_ContactPersonEmail; UserSetup."E-Mail") { }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyInfo_Addr1; CompanyAddr[1]) { }
                    column(CompanyInfo_Addr2; CompanyAddr[2]) { }
                    column(CompanyInfo_Addr3; CompanyAddr[3]) { }
                    column(CompanyInfo_Addr4; CompanyAddr[4]) { }
                    column(CompanyInfo_Addr5; CompanyAddr[5]) { }
                    column(CompanyInfo_Addr6; CompanyAddr[6]) { }
                    column(CompanyInfo_ShipToAddr1; ShipToCompanyAddr[1]) { }
                    column(CompanyInfo_ShipToAddr2; ShipToCompanyAddr[2]) { }
                    column(CompanyInfo_ShipToAddr3; ShipToCompanyAddr[3]) { }
                    column(CompanyInfo_ShipToAddr4; ShipToCompanyAddr[4]) { }
                    column(CompanyInfo_ShipToAddr5; ShipToCompanyAddr[5]) { }
                    column(CompanyInfo_ShipToAddr6; ShipToCompanyAddr[6]) { }
                    column(CompanyInfo_RegistrationNo; CompanyInfo."Registration No.") { }
                    column(CompanyInfo_VAT; CompanyInfo."VAT Registration No.") { }
                    column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.") { }
                    column(CompanyInfo_Email; CompanyInfo."E-Mail") { }
                    column(CompanyInfo_Picture; CompanyInfo.Picture) { }
                    column(PurchaseHeader_DocumentDate; FORMAT("Purchase Header"."Document Date", 0, 4)) { }
                    // BC Upgrade KUMARS145 drinkit field Commented .....>>
                    // column(Vendor_TaxRegistrationNo; "Purchase Header"."Vendor Tax Registration No.") { }    
                    column(Vendor_TaxRegistrationNo; '') { }
                    // BC Upgrade KUMARS145 drinkit field Commented .....<<

                    column(EUVATNumber; "Purchase Header"."VAT Registration No.") { }
                    column(Vendor_No; "Purchase Header"."Buy-from Vendor No.") { }
                    column(Vendor_Addr1; BuyFromAddr[1]) { }
                    column(Vendor_Addr2; BuyFromAddr[2]) { }
                    column(Vendor_Addr3; BuyFromAddr[3]) { }
                    column(Vendor_Addr4; BuyFromAddr[4]) { }
                    column(Vendor_Addr5; BuyFromAddr[5]) { }
                    column(Vendor_Addr6; BuyFromAddr[6]) { }
                    column(Vendor_Addr7; BuyFromAddr[7]) { }
                    column(Vendor_Addr8; BuyFromAddr[8]) { }
                    column(Vendor_Contact; Vendor.Contact) { }
                    column(Vendor_Email; Vendor."E-Mail") { }
                    column(PurchaseHeader_ExpectedReceiptDate; "Purchase Header"."Expected Receipt Date") { }
                    column(PurchaseHeader_PaymentTerms; "Purchase Header"."Payment Terms Code") { }
                    column(PurchaseHeader_IncoTerms; "Purchase Header"."Shipment Method Location FND") { }
                    column(PurchaseHeader_Currency; LCYCode) { }
                    column(PurchaseHeader_OperationalContractNo; "Purchase Header"."SRM Contract No. FND") { }
                    column(PurchaseHeader_OperationalContractRef; "Purchase Header"."SRM Contract Name FND") { }
                    column(PurchaseHeader_ContractContactNo; "Purchase Header"."Pay-to Contact") { }
                    column(OutputNo; OutputNo) { }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText) { }
                        column(DimensionLoop1Number; Number) { }
                        column(HdrDimsCaption; HdrDimsCaptionLbl) { }

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
                        column(TypeInt; TypeInt) { }
                        column(PurchaseLine_No; "Purchase Line"."No.") { }
                        column(PurchaseLine_Description; "Purchase Line".Description) { }
                        column(PurchaseLine_Quantity; "Purchase Line".Quantity) { }
                        column(PurchaseLine_UoM; "Purchase Line"."Unit of Measure") { }
                        column(PurchaseLine_DirectUnitCost; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineAmt_PurchLine; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(MachineRefNoCaption; MachinerefNo) { }
                        column(Item_MachineReferenceNo; Item."Machine Reference Number FND") { }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount; VATAmount) { }
                        column(TotalAmountIncludingVAT; TotalAmountInclVAT) { }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText) { }
                            column(DimensionLoop2Number; Number) { }
                            column(LineDimsCaption; LineDimsCaptionLbl) { }

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

                            if (PurchLine.Type = PurchLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Purchase Line"."No." := '';

                            TypeInt := "Purchase Line".Type.AsInteger();
                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line".Amount;

                            //HEI.05>>
                            if "Purchase Line".Type = "Purchase Line".Type::Item then
                                if Item.GET("Purchase Line"."No.") then;
                            //HEI.05<<
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
                                MoreLines := PurchLine.Next(-1) <> 0;
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
                        column(VALSpecLCYHdr; VALSpecLCYHeader) { }
                        column(VALVATAmtLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT1; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier1; VATAmountLine."VAT Identifier") { }

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
                               (VATAmountLine.GetTotalVATAmount = 0)
                            then
                                CurrReport.Break();

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
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        trigger OnPreDataItem();
                        begin
                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(SelltoCustNo_PurchHdr; "Purchase Header"."Sell-to Customer No.") { }
                        column(ShipToAddr1; ShipToAddr[1]) { }
                        column(ShipToAddr2; ShipToAddr[2]) { }
                        column(ShipToAddr3; ShipToAddr[3]) { }
                        column(ShipToAddr4; ShipToAddr[4]) { }
                        column(ShipToAddr5; ShipToAddr[5]) { }
                        column(ShipToAddr6; ShipToAddr[6]) { }
                        column(ShipToAddr7; ShipToAddr[7]) { }
                        column(ShipToAddr8; ShipToAddr[8]) { }
                        column(SelltoCustNo_PurchHdrCaption; "Purchase Header".FIELDCAPTION("Sell-to Customer No.")) { }

                        trigger OnPreDataItem();
                        begin
                            if ("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
                                CurrReport.Break();
                        end;
                    }
                }

                trigger OnAfterGetRecord();
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
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT();

                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    end;
                    CurrReport.PAGENO := 1;

                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem();
                begin
                    if not CurrReport.PREVIEW then
                        CODEUNIT.RUN(CODEUNIT::"Purch.Header-Printed", "Purchase Header");
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
            begin
                CurrReport.LANGUAGE := GetLanguageID("Language Code");

                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if LogInteraction then
                    if not CurrReport.PREVIEW then begin
                        if "Buy-from Contact No." <> '' then
                            SegManagement.LogDocument(22, "No.", 0, 0, DATABASE::Contact, "Buy-from Contact No.", "Purchaser Code", '', "Posting Description", '')
                        else
                            SegManagement.LogDocument(22, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '')
                    end;

                //>>HEI.02
                if "Currency Code" = '' then
                    LCYCode := GLSetup."LCY Code"
                else
                    LCYCode := "Currency Code";
                //<<HEI.02
                // BC Upgrade KUMARS145 drinkit field Commented .....>>
                // if UserSetup.GET("Purchase Header"."Created By") then;//HEI.09
                // BC Upgrade KUMARS145 drinkit field Commented .....>>
            end;

            trigger OnPreDataItem();
            begin
                //>>HEI.01
                // BC Upgrade KUMARS145 drinkit field Commented .....>>
                // User.SETRANGE("User Name", "Last changed User ID");
                // if User.FINDFIRST then;
                // BC Upgrade KUMARS145 drinkit field Commented .....<<
                if Vendor.GET("Buy-from Vendor No.") then;
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
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = all;
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = all;
                        Caption = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = all;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
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
            // LogInteraction := SegManagement.FindInteractTmplCode(22) <> '';
            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch. Return Ord. Cnfrmn.") <> '';
            // BC Upgrade KUMARS145 old code changed to new.....<<
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        //>>HEI.01
        CompanyInfo.CALCFIELDS(Picture);
        //<<HEI.01
    end;

    var
        Text004: TextConst Comment = '%1 = Document No.', ENU = 'Return Order %1';
        Text005: Label 'Page %1';
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PurchLine: Record "Purchase Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        LanguageRec: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        User: Record User;
        Vendor: Record Vendor;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        PurchPost: Codeunit "Purch.-Post";
        SegManagement: Codeunit SegManagement;
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
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text007: Label '"VAT Amount Specification in "';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        OutputNo: Integer;
        TypeInt: Integer;
        LogInteractionEnable: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        HdrDimsCaptionLbl: Label 'Header Dimensions';
        LineDimsCaptionLbl: Label 'Line Dimensions';
        PaymentDetailsCaptionLbl: Label 'Payment Details';
        VendNoCaptionLbl: Label 'Vendor No.';
        PrepmtInvBuDescCaptionLbl: Label 'Description';
        PrepmtInvBufGLAccNoCaptionLbl: Label 'G/L Account No.';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        PrepymtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification';
        LCYCode: Code[10];
        LegalTextBox: TextConst
           ENU = 'The payment time countdown starts from the date the invoice was filed.In the absence of a specific agreement with the Tango SARL, the supplier accepts by default the General conditions mentioned on this purchase order. The Tango SARL reserves the right to apply a delay penalty of 0.5% per week of delay in relation to the promised delivery date or the date of completion of the service, this penalty shall not exceed 5% of the total amount of the purchase order. The Tango SARL reserves the right to cancel the order if any of the conditions stipulated in the purchase order are not complied with.',
          FRA = 'Le décompte du délai de paiement commence à partir de la date du dépôt de la facture.En l''absence d''un accord spécifique  conclu avec la Sarl Tango, le fournisseur accepte par défaut les conditions générales mentionnées sur ce bon de commande. La Sarl Tango se réserve le droit d''appliquer une pénalité de retard de 0.5% par semaine de retard par rapport à la date de livraison promise ou la date de la réalisation de la prestation, cette pénalité ne doit pas dépasser 5% du montant total du bon de commande. La Sarl Tango se réserve le droit d''annuler la commande si une des conditions stipulées dans le bon de commande n''est pas respectée.';
        VATAmountCaption: TextConst ENU = 'VAT Amount:', FRA = 'Montant de la TVA:';
        TotalAmountInclVATCaption: TextConst ENU = 'Total Amount including VAT:', FRA = 'Montant Total incluant la TVA:';
        ReportTitle: TextConst ENU = 'Return Order No.', ESP = 'Pedido de Devolución No.', FRA = 'Commande de Retour No.';
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
        UserSetup: Record "User Setup";

    local procedure FormatAddressFields(PurchaseHeader: Record "Purchase Header");
    begin
        //>>HEI.01
        //FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center",RespCenter,CompanyInfo,CompanyAddr);
        if RespCenter.GET(PurchaseHeader."Responsibility Center") then begin
            FormatAddr.RespCenter(CompanyAddr, RespCenter);
            FormatAddr.RespCenter(ShipToCompanyAddr, RespCenter);
            CompanyInfo."Phone No." := RespCenter."Phone No.";
            CompanyInfo."Fax No." := RespCenter."Fax No.";
        end else begin
            FormatAddr.Company(CompanyAddr, CompanyInfo);
            FormatAddr.FormatAddr(ShipToCompanyAddr, CompanyInfo.Name, CompanyInfo."Name 2", CompanyInfo."Ship-to Contact", CompanyInfo."Ship-to Address",
              CompanyInfo."Ship-to Address 2", CompanyInfo."Ship-to City", CompanyInfo."Ship-to Post Code", CompanyInfo."Ship-to County", CompanyInfo."Ship-to Country/Region Code");
        end;
        //<<HEI.01

        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        if PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No." then
            FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header");
    begin
        FormatDocument.SetTotalLabels(PurchaseHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetPurchaser(SalesPurchPerson, PurchaseHeader."Purchaser Code", PurchaserText);

        ReferenceText := FormatDocument.SetText(PurchaseHeader."Your Reference" <> '', PurchaseHeader.FIELDCAPTION("Your Reference"));
        VATNoText := FormatDocument.SetText(PurchaseHeader."VAT Registration No." <> '', PurchaseHeader.FIELDCAPTION("VAT Registration No."));
    end;

    local procedure GetLanguageID(LanguageCode: Code[10]): Integer
    var
        LanguageRecLocal: Record Language;
    begin
        if LanguageRecLocal.GET(LanguageCode) then
            exit(LanguageRecLocal."Windows Language ID")
        else
            exit(WindowsLanguage)
    end;
}

