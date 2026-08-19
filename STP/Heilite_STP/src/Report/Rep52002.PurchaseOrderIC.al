report 52002 "Purchase Order IC"
{
    // version HEI.05
    // BC Upgrade Kamnay01 Original(Heilite) Report id 50184

    // HEI.01 FDD-IC-PRODGAP BRD HT417 IBM ISYED01 04/10/2019 # PO IC Layout
    //   # New PO Layout for IC
    // HEI.02 RFC-CHG0268766 IBM ISYED01 03.27.2019
    //   # Print location address based on the shipping tab in the PO instead of from Company Information
    // HEI.03 FDD-PURGAP030 - Send updated PO to supplier with specified  changes_V1.1 , NAIKH01 , 03.28.2019
    //   #Added new code.
    //   # Also added new Column "Comments" in the Reports design and added a new table in report design.
    // 
    // HEI.04 FDD-HB858 - CHG2027215 SHANKJ03 IBM 23.01.2020
    //   # ContactCOntractPerson value changed based on FDD condition
    //   # Removed Delivery Date from layout
    //   # Approved By is made hidden in layout
    //   # Document date is changed to Order Date
    // HEI.05 HB2907 CHG2157356 IBM SHIVAS05 31.08.2022
    //   # Find Contact Person Email form user setup on the basis of Created By user
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea property in Report and Requestpage fields.
    // 2. Add Layout path and change layout extension RDLC to rdl.
    // 3. Remove Drink-IT Fields ("Vendor Tax Registration No.","Print On Purchase Order","Requester ID","Created By","Receipt Status")
    // 4. Change Language to LanguageMgt and record to codeunit.
    // 5. Function BuildInvLineBuffer2 is obsolete in Business central , so we are using BuildInvLineBuffer.
    // 7. Function FindInteractTmplCode is obsolete in Business central , so we are using FindInteractionTemplateCode.and change peremeter 13 to "Purch. Ord."
    // 8. "Item Cross Reference" is absolete, so we are using "Item Refrence" in the Place of  "Item Cross Reference". And and in the place of "Cross-Reference Type" we are using ("Reference Type")
    // 9. Comment dotnet variable (StringHelper) this variable convert bigtext to text so we write the simple code by using textbuilder.
    // 10. Field PurchSetup."Archive Quotes and Orders" is missing replaced with "Archive Orders".
    // BC Upgrade BHARDA11 <<
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Purchase Order IC.rdl';// BC Upgrade BHARDA11 ---Add Path and change extension rdlc to rdl

    CaptionML = ENU = 'Purchase Order',
                ESP = 'Orden de Compra',
                FRA = 'Bon de Commande';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(CCtext; CCtext)
            {
            }
            column(Vendor_Email; VendorEmail)
            {
            }
            column(ItemLbl; ItemCaption)
            {
            }
            column(MaterialLbl; Material)
            {
            }
            column(MaterialDescriptionLbl; MaterialDescription)
            {
            }
            column(ExpectedReceiptDate; ExpectedReceiptDate)
            {
            }
            column(ReportTitleLbl; ReportTitle)
            {
            }
            column(ReprintedLbl; Reprinted)
            {
            }
            column(PageCaptionLbl; PageCaption)
            {
            }
            column(OrderingPartyLbl; OrderingParty)
            {
            }
            column(TaxIdentificationLbl; TaxIdentification)
            {
            }
            column(ContactPersonLbl; ContactPerson)
            {
            }
            column(PhoneLbl; Phone)
            {
            }
            column(VendorLbl; VendorCaption)
            {
            }
            column(TaxIdentificationNumberLbl; TaxIdentificationNumber)
            {
            }
            column(EUVATNumberLbl; EUVATNumber)
            {
            }
            column(YourVendorNoWithUsLbl; YourVendorNoWithUs)
            {
            }
            column(PleaseDeliverGoodsToLbl; PleaseDeliverGoodsTo)
            {
            }
            column(PlantOpeningHrsLbl; PlantOpeningHrs)
            {
            }
            column(PleaseDeliverInvoiceToLbl; PleaseDeliverInvoiceTo)
            {
            }
            column(DeliveryTermsLbl; DeliveryTerms)
            {
            }
            column(DocumentDateLbl; DocumentDate)
            {
            }
            column(DeliveryDateLbl; DeliveryDate)
            {
            }
            column(PaymentTermsLbl; PaymentTermsCaption)
            {
            }
            column(IncotermsLbl; Incoterms)
            {
            }
            column(CurrencyLbl; Currency)
            {
            }
            column(OperationalContractRefLbl; OperationalContractRef)
            {
            }
            column(LegalContractReferenceLbl; LegalContractReference)
            {
            }
            column(ContractContactPersonLbl; ContractContactPerson)
            {
            }
            column(QuantityLbl; QuantityCaption)
            {
            }
            column(UoMLbl; UoM)
            {
            }
            column(NetPriceLbl; NetPrice)
            {
            }
            column(NetValueLbl; NetValue)
            {
            }
            column(PurchaseOrderValueLbl; PurchaseOrderValue)
            {
            }
            column(ApprovedByLbl; ApprovedBy)
            {
            }
            column(CRLbl; CR)
            {
            }
            column(VATLbl; VAT)
            {
            }
            column(LegalTextBoxLbl; LegalTextBox)
            {
            }
            column(PurchaseHeader_DocumentType; "Document Type")
            {
            }
            column(PurchaseHeader_No; "No.")
            {
            }
            column(PurchaseHeader_NoPrinted; "No. Printed")
            {
            }
            column(PurchaseHeader_ContactPersonName; ContactPersonCode)
            {
            }
            column(TotalExclVATText; TotalExclVATText)
            {
            }
            column(TotalInclVATText; TotalInclVATText)
            {
            }
            column(VATPer; VATPer)
            {
            }
            column(VATPeTxt; VATPerText)
            {
            }
            column(VATAmt; VatAmt)
            {
            }
            column(ApprovedUserName; ApprovedUserName)
            {
            }
            column(POHeaderMark; POHeaderMark)
            {
            }
            column(POChanged; POChanged)
            {
            }
            column(ShowAddr; ShowAddr)
            {
            }
            column(ShowAddr2; ShowAddr2)
            {
            }
            column(ShowCityPostCode; ShowCityPostCode)
            {
            }
            column(ShowContact; ShowContact)
            {
            }
            column(ShowCountryRegion; ShowCountryRegion)
            {
            }
            column(ExpRecDtLbl; ExpRecDtLbl)
            {
            }
            column(IncotermsLocLbl; IncotermsLocLbl)
            {
            }
            column(OrderDateLbl; OrderDateLbl)
            {
            }
            column(PurchaseHeader_OrderDate; "Purchase Header"."Order Date")
            {
            }
            column(PurchaseHeader_ContactPersonNameNew; ContactPersonTxt)
            {
            }
            // column(testremark; StringHelper.Copy(FORMAT(POTextNew))) // BC Upgrade BHARDA11 ----Replace StringHelper Dotnet variable  to custom variable POTextString
            column(testremark; POTextString) // BC Upgrade BHARDA11 ----:: Added
            {
            }
            column(PurchaseHeader_ContractcontpersonTxt; ContractcontpersonTxt)
            {
            }
            column(ReasonCodeDescription; ReasonCodeDescription)
            {
            }
            column(ReasonCodeDescriptionLbl; ReasonCodeDescriptionLbl)
            {
            }
            column(HouseNumber_PurchaseHeader; "Purchase Header"."House Number FND")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(PurchaseHeader_PaymentTerms; PaymentTerms.Description)
                    {
                    }
                    column(PurchaseHeader_ContactPersonEmail_Remove; ContactPersonEmail)
                    {
                    }
                    column(PurchaseHeader_ContactPersonEmail; UserSetup1."E-Mail")
                    {
                    }
                    column(Ship2name2; Ship2name2)
                    {
                    }
                    column(Ship2name; Ship2name)
                    {
                    }
                    column(Ship2Addr; Ship2Addr)
                    {
                    }
                    column(Ship2Addr2; Ship2Addr2)
                    {
                    }
                    column(FooterText; FooterText)
                    {
                    }
                    column(FooterText2; FooterText2)
                    {
                    }
                    column(FooterSubText; FooterSubText)
                    {
                    }
                    column(Invoicename; Invoicename)
                    {
                    }
                    column(InvoicedeliveryAdd1; InvoicedeliveryAdd1)
                    {
                    }
                    column(InvoicedeliveryAdd2; InvoicedeliveryAdd2)
                    {
                    }
                    column(CompanyInfo_Addr1; CompanyAddr[1])
                    {
                    }
                    column(Companyinfo_Addr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyInfo_Addr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyInfo_Addr4; CompanyAddr[4])
                    {
                    }
                    column(Companyinfo_Addr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyInfo_Addr6; CompanyAddr[6])
                    {
                    }
                    column(CompanyInfo_ShipToAddr1; ShipToCompanyAddr[1])
                    {
                    }
                    column(CompanyInfo_ShipToAddr2; ShipToCompanyAddr[2])
                    {
                    }
                    column(CompanyInfo_ShipToAddr3; ShipToCompanyAddr[3])
                    {
                    }
                    column(CompanyInfo_ShipToAddr4; ShipToCompanyAddr[4])
                    {
                    }
                    column(CompanyInfo_ShipToAddr5; ShipToCompanyAddr[5])
                    {
                    }
                    column(CompanyInfo_ShipToAddr6; ShipToCompanyAddr[6])
                    {
                    }
                    column(CompanyInfo_ShipToAddr7; ShipToCompanyAddr[7])
                    {
                    }
                    column(CompanyInfo_ShipToAddr8; ShipToCompanyAddr[8])
                    {
                    }
                    column(PorcServiceMgr; PorcServiceMgr)
                    {
                    }
                    column(CompanyInfo_Picture2; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo_Picture1; CompanyInfo1."OpCo Logo FND")
                    {
                    }
                    column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfo_VAT; CompanyInfo."RCCM Legal entity code FND")
                    {
                    }
                    column(CompanyInfo_VAT1; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo_RegistrationNo; CompanyInfo."Registration No.")
                    {
                    }
                    column(Vendor_No; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(Vendor_Addr1; BuyFromAddr[1])
                    {
                    }
                    column(Vendor_Addr2; BuyFromAddr[2])
                    {
                    }
                    column(Vendor_Addr3; BuyFromAddr[3])
                    {
                    }
                    column(Vendor_Addr4; BuyFromAddr[4])
                    {
                    }
                    column(Vendor_Addr5; BuyFromAddr[5])
                    {
                    }
                    column(Vendor_Addr6; BuyFromAddr[6])
                    {
                    }
                    column(Vendor_Addr7; BuyFromAddr[7])
                    {
                    }
                    column(Vendor_Addr8; BuyFromAddr[8])
                    {
                    }
                    // column(Vendor_TaxRegistrationNo; "Purchase Header"."Vendor Tax Registration No.") // BC Upgrade BHARDA11 ----Drink-IT Field("Vendor Tax Registration No.")
                    column(Vendor_TaxRegistrationNo; '') // BC Upgrade BHARDA11 ----Drink-IT Field("Vendor Tax Registration No.")
                    {
                    }
                    column(EUVATNumber; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(Vendor_Contact; Vendor.Contact)
                    {
                    }
                    column(PurchaseHeader_DocumentDate; FORMAT("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    column(PurchaseHeader_ExpectedReceiptDate; "Purchase Header"."Expected Receipt Date")
                    {
                    }
                    column(PurchaseHeader_IncoTerms; "Purchase Header"."Shipment Method Code")
                    {
                    }
                    column(PurchaseHeader_Currency; LCYCode)
                    {
                    }
                    column(PurchaseHeader_OperationalContractNo; "Purchase Header"."SRM Contract No. FND")
                    {
                    }
                    column(PurchaseHeader_OperationalContractRef; "Purchase Header"."SRM Contract Name FND")
                    {
                    }
                    column(PurchaseHeader_ContractContactNo; "Purchase Header"."Pay-to Contact")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(DimText; DimText)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(HdrDimCaption; HdrDimCaptionLbl)
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
                    dataitem(CommentLine; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        column(PurchComment; PurchComment)
                        {
                        }

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
                            // PurchCommentLine.SETRANGE("Print On Purchase Order", true); // BC Upgrade BHARDA11 ----Drink-IT Field("Print On Purchase Order")

                            SETRANGE(Number, 1, PurchCommentLine.COUNT);
                        end;
                    }
                    dataitem(VendorCommentsLine; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        column(VendComment; VendComment)
                        {
                        }

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
                            // VendCommentLine.SETRANGE("Print On Purchase Order", true); // BC Upgrade BHARDA11 ----Drink-IT Field("Print On Purchase Order")

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
                        column(PurchaseLine_No; "Purchase Line"."No.")
                        {
                        }
                        column(PurchaseLine_Description; "Purchase Line".Description)
                        {
                        }
                        column(PurchaseLine_Quantity; "Purchase Line".Quantity)
                        {
                        }
                        column(PurchaseLine_UoM; "Purchase Line"."Unit of Measure Code")
                        {
                        }
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
                        column(PurchaseLine_LineNo; "Purchase Line"."Line No.")
                        {
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Type_PurchLine; FORMAT("Purchase Line".Type, 0, 2))
                        {
                        }
                        column(LineAmt2_PurchLine; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(MachineRefNoCaption; MachineRefNo)
                        {
                        }
                        column(Item_MachineReferenceNo; Item."Machine Reference Number FND")
                        {
                        }
                        column(ExpectedReceiptDate_PurchaseLine; FORMAT("Purchase Line"."Expected Receipt Date", 10, '<Day,2>/<Month,2>/<Year4>'))
                        {
                        }
                        column(LineDiscount_PurchaseLine; "Purchase Line"."Line Discount %")
                        {
                        }
                        column(VatPer_PurchaseLine; "Purchase Line"."VAT %")
                        {
                        }
                        column(POLineStatus; POLineStatus)
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }

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

                            if not ItemCrossRef.GET("Purchase Line"."No.", "Purchase Line"."Variant Code", "Purchase Line"."Unit of Measure Code",
                              // ItemCrossRef."Cross-Reference Type"::Vendor, "Purchase Line"."Buy-from Vendor No.", "Purchase Line"."Vendor Item No.") then // Bc Upgrade BHARDA11 ----"Item Cross Reference" is absolete, so we are using "Item Refrence" in the Place of  "Item Cross Reference" and in the place of "Cross-Reference Type" we are using ("Reference Type")
                              ItemCrossRef."Reference Type"::Vendor, "Purchase Line"."Buy-from Vendor No.", "Purchase Line"."Vendor Item No.") then // Bc Upgrade BHARDA11 ----"Item Cross Reference" is absolete, so we are using "Item Refrence" in the Place of  "Item Cross Reference" and in the place of "Cross-Reference Type" we are using ("Reference Type")
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
                            //>>HEI.03
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
                            //<<HEI.03
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
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem();
                        begin
                            if VATAmount = 0 then
                                CurrReport.BREAK();
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
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
                        column(PayToVendNo_PurchHeader; "Purchase Header"."Pay-to Vendor No.")
                        {
                        }
                        column(VendAddr8; VendAddr[8])
                        {
                        }
                        column(VendAddr7; VendAddr[7])
                        {
                        }
                        column(VendAddr6; VendAddr[6])
                        {
                        }
                        column(VendAddr5; VendAddr[5])
                        {
                        }
                        column(VendAddr4; VendAddr[4])
                        {
                        }
                        column(VendAddr3; VendAddr[3])
                        {
                        }
                        column(VendAddr2; VendAddr[2])
                        {
                        }
                        column(VendAddr1; VendAddr[1])
                        {
                        }
                        column(PaymentDetailsCaption; PaymentDetailsCaptionLbl)
                        {
                        }
                        column(VendNoCaption; VendNoCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem();
                        begin
                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total3; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(SellToCustNo_PurchHeader; "Purchase Header"."Sell-to Customer No.")
                        {
                        }
                        column(SellToCustNo_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

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
                        column(PrepmtInvBufGLAccNo; PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(PrepmtInvBufDesc; PrepmtInvBuf.Description)
                        {
                        }
                        column(TotalInclVATText2; TotalInclVATText)
                        {
                        }
                        column(TotalExclVATText2; TotalExclVATText)
                        {
                        }
                        column(PrepmtInvBufAmt; PrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountText; PrepmtVATAmountLine.VATAmountText())
                        {
                        }
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
                        column(PrepmtInvBuDescCaption; PrepmtInvBuDescCaptionLbl)
                        {
                        }
                        column(PrepmtInvBufGLAccNoCaption; PrepmtInvBufGLAccNoCaptionLbl)
                        {
                        }
                        column(PrepaymentSpecCaption; PrepaymentSpecCaptionLbl)
                        {
                        }
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
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code");
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
                        column(PrepmtVATAmtLineVATId; PrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepymtVATAmtSpecCaption; PrepymtVATAmtSpecCaptionLbl)
                        {
                        }

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
                        column(PurchDocLog_DocNo; TEMPPurchaseDocumentLog."Document No.")
                        {
                        }
                        column(PurchDocLog_LineNo; TEMPPurchaseDocumentLog."Line No.")
                        {
                        }
                        column(PurchDocLog_Comments; TEMPPurchaseDocumentLog.Comment)
                        {
                        }
                        column(PurchDocLog_No; TEMPPurchaseDocumentLog."No.")
                        {
                        }
                        column(PurchDocLog_Desc; TEMPPurchaseDocumentLog.Description)
                        {
                        }
                        column(PurchDocLog_Quantity; TEMPPurchaseDocumentLog.Quantity)
                        {
                        }
                        column(PurchDocLog_UOM; TEMPPurchaseDocumentLog."Unit of Measure")
                        {
                        }
                        column(PurchDocLog_DirectUnitCost; TEMPPurchaseDocumentLog."Direct Unit Cost")
                        {
                        }
                        column(PurchDocLog_LineAmount; TEMPPurchaseDocumentLog."Line Amount")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                TEMPPurchaseDocumentLog.FIND('-')
                            else
                                TEMPPurchaseDocumentLog.NEXT();
                            //HEI.03
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(Number, 1, TEMPPurchaseDocumentLog.COUNT);
                            //>>HEI.03
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
                    // PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf); // BC Upgrade BHARDA11 ----Function BuildInvLineBuffer2 is obsolete in Business central , so we are using BuildInvLineBuffer.
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf); // BC Upgrade BHARDA11 ----Function BuildInvLineBuffer2 is obsolete in Business central , so we are using BuildInvLineBuffer.
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
            begin
                UserSetup.SETRANGE("Procurement Serv Manager FND", true);
                if UserSetup.FINDFIRST() then begin
                    User.RESET();
                    User.SETRANGE("User Name", UserSetup."User ID");
                    if User.FINDFIRST() then begin
                        ContactPersonEmail := User."Contact Email";
                        if User."Full Name" <> '' then
                            PorcServiceMgr := User."Full Name"; // BC Upgrade BHARDA11 -- Add ";" 
                                                                // BC Upgrade BHARDA11 >> ----drink-IT Field("Created By")
                                                                // else
                                                                // PorcServiceMgr := "Created By";
                                                                // BC Upgrade BHARDA11 << ----drink-IT Field("Created By")

                    end;
                end;

                // CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");  // BC Upgrade BHARDA11 ---Change Language to LanguageMgt
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageID("Language Code");   // BC Upgrade BHARDA11 ---Change Language to LanguageMgt

                CompanyInfo.GET();
                //FooterText := CompanyInfo.Name +'-'+CompanyInfo."Post Code" + '-' + CompanyInfo.City + ' Tel : ' + CompanyInfo."Phone No." + ' '+ FooterSubText +' '+ CompanyInfo."Cap. Social" +' FCFA -RCCM : '+CompanyInfo."RCCM Legal entity code"+' ';
                FooterText := CompanyInfo.Name + '-' + CompanyInfo."Post Code" + '-' + CompanyInfo.City + ' Tel : ' + CompanyInfo."Phone No." + ' ';//+ FooterSubText +' '+ CompanyInfo."Cap. Social" +' FCFA -RCCM : '+CompanyInfo."RCCM Legal entity code"+' ';
                                                                                                                                                    //FooterText :=FooterText +' - CC : '+ CompanyInfo."VAT Registration No.";

                FooterText2 := ' ' + CompanyInfo."Cap. Social FND" + ' FCFA -RCCM : ' + CompanyInfo."RCCM Legal entity code FND" + ' ';
                FooterText2 := FooterText2 + ' - CC : ' + CompanyInfo."VAT Registration No.";

                Invoicename := CompanyInfo."Invoice Name FND";
                InvoicedeliveryAdd1 := CompanyInfo."Invoice Address FND";
                InvoicedeliveryAdd2 := CompanyInfo."Invoice Address2 FND";

                Ship2name := "Purchase Header"."Ship-to Name";
                Ship2name2 := "Purchase Header"."Ship-to Name 2";
                Ship2Addr := "Purchase Header"."Ship-to Address";
                Ship2Addr2 := "Purchase Header"."Ship-to Address 2";

                /*Ship2name  := CompanyInfo."Ship-to Name";
                Ship2Addr  := CompanyInfo."Ship-to Address";
                Ship2Addr2 := CompanyInfo."Ship-to Address 2";*/

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
                    //CompanyInfo."Ship-to Address 2",CompanyInfo."Ship-to City",CompanyInfo."Ship-to Post Code",CompanyInfo."Ship-to County",CompanyInfo."Ship-to Country/Region Code");
                    //HEI.06>>
                    FormatAddr.FormatAddr(ShipToCompanyAddr, CompanyInfo.Name, CompanyInfo."Name 2", "Purchase Header"."Ship-to Contact", "Purchase Header"."Ship-to Address",
                      "Purchase Header"."Ship-to Address 2", "Purchase Header"."Ship-to City", "Purchase Header"."Ship-to Post Code", "Purchase Header"."Ship-to County", "Purchase Header"."Ship-to Country/Region Code");
                    //HEI.06<<
                end;
                //<<HEI.01

                //>>HEI.01
                //User.SETRANGE("User Name","Last changed User ID");
                // BC Upgrade BHARDA11 >> --Drink-IT Field("Created By")
                // User.RESET;
                // User.SETRANGE("User Name", "Created By");  //Hei.02
                // if User.FINDFIRST then begin
                //     if User."Full Name" <> '' then
                //         ContactPersonCode := User."Full Name"
                //     else
                //         ContactPersonCode := "Created By";
                // end;
                // BC Upgrade BHARDA11 << --Drink-IT Field("Created By")

                //<<HEI.01 <<Hei.02

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

                if Vendor.GET("Purchase Header"."Buy-from Vendor No.") then
                    VendorEmail := Vendor."E-Mail";

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
                //>> Hei.02
                ApprovalEntry.RESET();
                ApprovalEntry.SETRANGE("Table ID", DATABASE::"Purchase Header");
                ApprovalEntry.SETRANGE("Document Type", "Document Type");
                ApprovalEntry.SETRANGE("Document No.", "No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FINDLAST() then;

                User.RESET();
                User.SETRANGE("User Name", ApprovalEntry."Approver ID");  //Hei.02
                if User.FINDFIRST() then begin
                    if User."Full Name" <> '' then
                        ApprovedUserName := User."Full Name"
                    else
                        ApprovedUserName := ApprovalEntry."Approver ID";
                end;

                //<< HEI.02
                //<<HEI.03
                if "Purchase Header"."Changed FND" then begin
                    PurchaseDocumentLog.RESET();
                    PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                    PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                    PurchaseDocumentLog.SETRANGE(Printed, false);
                    PurchaseDocumentLog.SETRANGE(Comment, 'Line Deleted');
                    if PurchaseDocumentLog.FINDSET() then
                        repeat
                            TEMPPurchaseDocumentLog := PurchaseDocumentLog;
                            TEMPPurchaseDocumentLog.Comment := 'Cancelled';
                            TEMPPurchaseDocumentLog.INSERT();
                        until PurchaseDocumentLog.NEXT() = 0;
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
                //>>HEI.03

                //HEI.04>>
                CLEAR(ContactPersonTxt);
                CLEAR(UsrName);
                CLEAR(ContractcontpersonTxt);
                CLEAR(ContrContPerUsrName);
                CLEAR(PurchaserCode);
                CLEAR(ReasonCodeDescription);

                if PurchaseReasonCode.GET("Purch. Reason Code FND") then
                    ReasonCodeDescription := PurchaseReasonCode.Description;

                // Contact Person
                if "Purchase Header"."Maximo Requisition No. FND" <> '' then
                    UsrName := "Purchase Header"."PQ Approver FND"; // BC Upgrade BHARDA11 --Add ";"
                                                                // BC Upgrade BHARDA11 >> ----Drink-IT Field("Requester ID","Created By")
                                                                // else if "Purchase Header"."Quote No." <> '' then
                                                                //     UsrName := "Purchase Header"."Requester ID"
                                                                // else
                                                                //     UsrName := "Purchase Header"."Created By";
                                                                // BC Upgrade BHARDA11 << ----Drink-IT Field("Requester ID","Created By")

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


                PurchasesPayablesSetup.GET();
                PurchasesPayablesSetup.CALCFIELDS("PO Legal Text FND", "PO Legal Txt International FND");
                if Vendor."Language Code" <> CompanyInfo."Language Code FND" then begin
                    if PurchasesPayablesSetup."PO Legal Txt International FND".HASVALUE then begin
                        PurchasesPayablesSetup."PO Legal Txt International FND".CREATEINSTREAM(MemoReader);
                        POTextNew.READ(MemoReader);
                        // BC Upgrade BHARAD11 >>
                        TextBuilder.Clear();
                        TextBuilder.Append(Format(POTextNew));  // Append complete text
                        POTextString := TextBuilder.ToText();  // Convert to Text variable (Here bigtext convert to text)
                        // BC Upgrade BHARDA11 <<
                    end;
                end else begin
                    if PurchasesPayablesSetup."PO Legal Text FND".HASVALUE then begin
                        PurchasesPayablesSetup."PO Legal Text FND".CREATEINSTREAM(MemoReader);
                        POTextNew.READ(MemoReader);
                        // BC Upgrade BHARAD11 >>
                        TextBuilder.Clear();
                        TextBuilder.Append(Format(POTextNew));  // Append complete text
                        POTextString := TextBuilder.ToText();  // Convert to Text variable (Here bigtext convert to text)
                        // BC Upgrade BHARDA11 <<
                    end;
                end;

                //HEI.04<<
                // if UserSetup1.GET("Purchase Header"."Created By") then;//HEI.05 // BC Upgrade BHARDA11 ----Drink-IT Field("Created By")

            end;

            trigger OnPostDataItem();
            var
                PurchHeader: Record "Purchase Header";
            begin
                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                if Print then begin
                    if TempPrintedPurchHeader.FINDSET() then
                        repeat
                            PurchHeader.GET(TempPrintedPurchHeader."Document Type", TempPrintedPurchHeader."No.");
                        // BC Upgrade BHARDA11 >> ----Drink-IT Field("Receipt Status")
                        // if PurchHeader."Receipt Status" < SetReceiptStatus then begin
                        //     PurchHeader.VALIDATE("Receipt Status", SetReceiptStatus);
                        //     PurchHeader.MODIFY(true);
                        // end;
                        // BC Upgrade BHARDA11 << ----Drink-IT Field("Receipt Status")
                        until TempPrintedPurchHeader.NEXT() = 0;
                end;


                //HEI.10>>
                if "Payment Terms Code" = '' then
                    PaymentTerms.INIT()
                else begin
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;
                //HEI.10<<
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
                        ToolTip = 'Specifies the value of the No. of Copies field.';
                    }
                    field(SetReceiptStatus; SetReceiptStatus)
                    {
                        ApplicationArea = All;
                        Caption = 'Set Receipt Status';
                        OptionCaption = 'Open,Order Printed,Order Sent,Order Confirmed,To Receive,Receipt Completed,Invoice';
                        ToolTip = 'Specifies the value of the Set Receipt Status field.';
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
            // ArchiveDocument := PurchSetup."Archive Quotes and Orders"; // BC Upgrade BHARDA11 ---Missing in table
            ArchiveDocument := PurchSetup."Archive Orders"; // BC Upgrade BHARDA11 ---Replaced with "Archive Orders"
            // LogInteraction := SegManagement.FindInteractTmplCode(13) <> ''; // BC Upgrade BHARDA11 ----Function FindInteractTmplCode is obsolete in Business central , so we are using FindInteractionTemplateCode.and change peremeter 13 to "Purch. Ord."
            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch. Ord.") <> ''; // BC Upgrade BHARDA11 ----Function FindInteractTmplCode is obsolete in Business central , so we are using FindInteractionTemplateCode.and change peremeter 13 to "Purch. Ord."

            LogInteractionEnable := LogInteraction;
            SetReceiptStatus := SetReceiptStatus::"Order Printed";
        end;
    }

    labels
    {
        label(LblCode; ENU = 'Material',
                      ESP = 'Material',
                      FRA = 'Matériel')
        label(LblDescription; ENU = 'Material Description',
                             ESP = 'Descripción del material',
                             FRA = 'Description du matériel')
        label(lblExpectedReceiptDate; ENU = 'Expected Receipt Date',
                                     FRA = 'Date de réception prévue')
        label(LblQty; ENU = 'Quantity',
                     ESP = 'Cantidad',
                     FRA = 'Quantité')
        label(LblUOM; ENU = 'UoM',
                     ESP = 'Unidad de Medición',
                     FRA = 'Unité de mesure')
        label(LblUnitCost; ENU = 'Net Price',
                          ESP = 'Precio Neto',
                          FRA = 'Prix Net')
        LblVATPer = 'Vat %'; lblLineDiscPerc = 'Disc.%'; label(LblAmount; ENU = 'Net Value',
                                                                       FRA = 'Valeur nette')
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        PurchSetup.GET();

        CompanyInfo1.GET();
        CompanyInfo1.CALCFIELDS("OpCo Logo FND");
        CompanyInfo1.CALCFIELDS(Picture);


        UserSetup.SETRANGE("Procurement Serv Manager FND", true);
        if UserSetup.FINDFIRST() then begin
            if UserSetup."Procurement Serv Manager FND" then
                PorcServiceMgr := UserSetup."User ID";
        end;
    end;

    var
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label '" COPY"';
        Text004: Label 'Ordering %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
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
        // Language: Record Language; // BC Upgrade BHARDA11 --- Change Language to LanguageMgt and Record to codeunit
        LanguageMgt: Codeunit Language; // BC Upgrade BHARDA11 --- Change Language to LanguageMgt and Record to codeunit

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
        // ItemCrossRef: Record "Item Cross Reference"; // Bc Upgrade BHARDA11 ----"Item Cross Reference" is absolete, so we are using "Item Refrence" in the Place of  "Item Cross Reference".
        ItemCrossRef: Record "Item Reference"; // Bc Upgrade BHARDA11 ----"Item Cross Reference" is absolete, so we are using "Item Refrence" in the Place of  "Item Cross Reference".

        "HIT8006.71": Integer;
        recLocation: Record Location;
        SetReceiptStatus: Option Open,"Order Printed","Order Sent","Order Confirmed","To Receive","Receipt Completed",Invoice;
        txtLocationFaxNo: Text[30];
        txtLocationEmail: Text[80];
        txtLocationPhoneNo: Text[30];
        Print: Boolean;
        TempPrintedPurchHeader: Record "Purchase Header" temporary;
        Text52003: Label '"VAT %1 "';
        HdrDimCaptionLbl: Label 'Header Dimensions';
        LineDimCaptionLbl: Label 'Line Dimensions';
        PaymentDetailsCaptionLbl: Label 'Payment Details';
        VendNoCaptionLbl: Label 'Vendor No.';
        PrepmtInvBuDescCaptionLbl: Label 'Description';
        PrepmtInvBufGLAccNoCaptionLbl: Label 'G/L Account No.';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        PrepymtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification';
        LCYCode: Code[10];
        ReportTitle: TextConst ENU = 'Purchase Order No.', ESP = 'Orden de Compra No.', FRA = 'Bon de Commande No.';
        Reprinted: TextConst ENU = 'Reprinted', ESP = 'Reimpreso', FRA = 'Réimprimé';
        PageCaption: TextConst ENU = 'Page', ESP = 'Pgina', FRA = 'Page';
        OrderingParty: TextConst ENU = 'ORDERING PARTY:', ESP = 'COMPAÑÍA QUE ORDENA:', FRA = 'DONNEUR D''ORDRE:';
        TaxIdentification: Label 'RCCM :';
        ContactPerson: TextConst ENU = 'Contact person:', ESP = 'Persona de Contact:', FRA = 'Personne à Contact:';
        Phone: TextConst ENU = 'Phone:', ESP = 'Teléfono:', FRA = 'Téléphone:';
        VendorCaption: TextConst ENU = 'VENDOR:', ESP = 'PROVEEDOR:', FRA = 'FOURNISSEUR:';
        TaxIdentificationNumber: TextConst ENU = 'Tax Identification Number:', ESP = 'Número de Identificación de Impuestos:', FRA = 'CC : ';
        EUVATNumber: TextConst ENU = 'VAT Number:', ESP = 'EU VAT Number:', FRA = 'RCCM : ';
        YourVendorNoWithUs: TextConst ENU = 'Your Vendor Number with us:', ESP = 'Su número de proveedor con nosotros:', FRA = 'Numéro fournisseur :';
        PleaseDeliverGoodsTo: TextConst ENU = 'PLEASE DELIVER GOODS TO:', ESP = 'FAVOR ENTREGAR MERCANCÍA A:', FRA = 'VEUILLEZ LIVRER LES MARCHANDISES À:';
        PlantOpeningHrs: TextConst ENU = 'Plant opening hrs:', ESP = 'Horario:', FRA = 'Horaires d''ouverture du site:';
        PleaseDeliverInvoiceTo: TextConst ENU = 'PLEASE DELIVER INVOICE TO:', ESP = 'FAVOR ENTREGAR FACTURA A:', FRA = 'VEUILLEZ TRANSMETTRE LA FACTURE À:';
        DeliveryTerms: TextConst ENU = 'Delivery Terms:', ESP = 'Términos de entrega:', FRA = 'Conditions de Livraison:';
        DocumentDate: TextConst ENU = 'Document Date:', ESP = 'Fecha del documento:', FRA = 'Date du document:';
        DeliveryDate: TextConst ENU = 'Delivery Date:', ESP = 'Fecha de Entrega:', FRA = 'Date de Livraison:';
        PaymentTermsCaption: TextConst ENU = 'Payment Terms:', ESP = 'Términos de Pago:', FRA = 'Conditions de Paiements:';
        Incoterms: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:';
        Currency: TextConst ENU = 'Currency:', ESP = 'Moneda:', FRA = 'Devise:';
        OperationalContractRef: TextConst ENU = 'Operational Contract ref:', ESP = 'Referencia del contrato operacional:', FRA = 'En référence au contrat n:';
        LegalContractReference: TextConst ENU = 'Legal Contract Reference:', ESP = 'Referencia legal del contrato:', FRA = 'En référence au contrat legal:';
        ContractContactPerson: TextConst ENU = 'Contract Contact Person:', ESP = 'Contacto:', FRA = 'Responsable du contrat:';
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
        LegalTextBox: TextConst
           ENU = 'General Instructions: This order is subject to the "Terms and Conditions" assigned to this purchase order and the legal reference of the contract indicated above (if applicable). Please send an order confirmation to the contact person for the purchase order within three working days (from the date of the document). Enter the purchase order number on all relevant documents, including Invoice, Delivery Note, Packing List.In case of payment and / or billing problems, please contact the Helpdesk Finance number on +225 21005400 or by electronic address: CI1.payable@heineken.com Failure to comply with the instructions mentioned above could delay or result in non payment / payment of invoices. VAT, signature and stamp are not required in the purchase order form.',
          FRA = 'Instructions Générales: Cette commande est soumise aux "Conditions générales" affectées à ce bon de commande et à la référence légale du contrat indiquée ci-dessus (le cas échéant). Veuillez envoyer une confirmation de commande à la personne à contacter pour le bon de commande dans les trois jours ouvrables (à compter de la date du document) Indiquez le numéro du bon de commande sur tous les documents pertinents, y compris la Facture, Bon de livraison, Liste de colisage En cas de problèmes de paiement et / ou de facturation, veuillez contacter le numéro du support Finance au  +225 21005400 ou par email :  CI1.payable@heineken.com Le non-respect des instructions mentionnées ci-dessus pourrait retarder ou entraîner le non paiement / règlement des factures. La mention de la TVA . la signature et le cachet ne sont pas requis sur le formulaire de bon de commande.';
        ApprovedBy: TextConst ENU = 'Approved by Procurement Service Manager, ', ESP = 'Aprobado por:', FRA = 'Approuvé par le Responsable Service Achats,';
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
        ContactPersonCode: Text[80];
        ApprovalEntry: Record "Approval Entry";
        ApprovedUserName: Text[80];
        UserSetup: Record "User Setup";
        PorcServiceMgr: Text[50];
        FooterText: Text[500];
        FooterSubText: TextConst ENU = 'with social capital of', FRA = 'avec capital social de ';
        ExpectedReceiptDate: TextConst ENU = 'Expected Delivery Date', FRA = 'Date de livraison prévue';
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
        ContactPersonEmail: Text[250];
        VendorEmail: Text[250];
        CCtext: Label '"CC : "';
        InvoicedeliveryAdd1: Text[250];
        InvoicedeliveryAdd2: Text[250];
        Invoicename: Text[250];
        Ship2name: Text[250];
        Ship2Addr: Text[250];
        Ship2Addr2: Text[250];
        Ship2name2: Text[250];
        FooterText2: Text[250];
        ContactPersonTxt: Text;
        UsrName: Code[50];
        UserRec: Record User;
        ContractcontpersonTxt: Text;
        ContrContPerUsrName: Code[50];
        PurchaserCode: Code[10];
        ApprovalUserRec: Record "User Setup";
        MemoReader: InStream;
        // StringHelper: DotNet "'mscorlib'.System.String"; // BC Upgrade BHARDA11 ----DotNet variables are NOT supported in Business Central Cloud/SaaS environment
        TextBuilder: TextBuilder;  // BC Upgrade BHARDA11 ----For handling large text without truncation
        POTextString: Text;  // BC Upgrade BHARDA11 
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        POTextNew: BigText;
        ExpRecDtLbl: TextConst ENU = 'Expected Receipt Date', FRA = 'Date de livraison prévue';
        IncotermsLocLbl: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:';
        OrderDateLbl: TextConst ENU = 'Order Date:', FRA = 'Date de commande';
        ReasonCodeDescription: Text;
        PurchaseReasonCode: Record "Reason Code_Purchase FND";
        ReasonCodeDescriptionLbl: Label 'Reason Code:';
        UserSetup1: Record "User Setup";

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;
}

