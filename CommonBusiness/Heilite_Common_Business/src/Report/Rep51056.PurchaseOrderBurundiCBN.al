report 51056 "Purchase Order Burundi CBN"
{
    // version HEI.06

    // HEI.01 FDD-HT935_Burundi
    //   #created a new report (used template ID 50152)
    // HEI.02 FDD-HT935_Burundi
    //   #change the additional address details
    // 
    // HEI.03 FDD-HB858 - CHG2027215 SHANKJ03 IBM 23.01.2020
    //   # ContactCOntractPerson value changed based on FDD condition
    //   # Removed Delivery Date from layout
    //   # Incoterm Caption changed to Incoerm Location
    //   # Approved By is made hidden in layout
    //   # Document date is changed to Order Date
    // 
    // HEI.04 FDD-HT935_Burundi
    //   # add Plant Opening Hrs value from Company information in Shipping section added after Plant Opening Hours label
    // HEI.05 FDD- HT1571 CHG2071875 IBM SHANKJ03  13.08.2020
    //   # Added Footer text in Layout
    // HEI.06 HB2907 CHG2157356 IBM SHIVAS05 31.08.2022
    //   # Find Contact Person Email form user setup on the basis of Created By user
    //*******************************************************************************
    //BC UPGRADE PATHAA02-17Dec25
    // Function(BuildInvLineBuffer2) removed in BC, used BuildInvLineBuffer
    //Code conditions related DIT fields are commented but need to uncomment back once Aptean Ext/Code is merged.
    //StringHelper: DotNet "'mscorlib'.System.String"; //BC UPGRADE PATHAA02-dotnet variable not supported 
    //GetLanguageId moved from Language Table to Language CU in BC-code changed.
    //Table-"Item Cross Reference" is not available in BC, it is replaced by Item reference table-->code changed to fit new table
    //"Created By" is changed to SystemCreatedBy.
    //PurchSetup."Archive Quotes and Orders" field is removed in BC, used "Archive Orders" as it is boolean; not used "Archive Quotes" as it is option field.
    //SegManagement.FindInteractTmplCode() in NAV changed to SegManagement.FindInteractionTemplateCode() in BC

    DefaultLayout = RDLC;
    //RDLCLayout = '.\src\Purchase Order Burundi.rdl';//BC UPGRADE PATHAA02 
    RDLCLayout = '.\src\Reportslayout\Purchase Order Burundi.rdl';//BC UPGRADE PATHAA02 

    CaptionML = ENU = 'Purchase Order Burundi',
                ESP = 'Orden de Compra',
                FRA = 'Bon de Commande',
                ENG = 'Purchase Order';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeadingML = ENU = 'Purchase Order',
                                     ENG = 'Purchase Order';
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
            column(ItemLbl; ItemCaption)
            {
            }
            column(MaterialLbl; Material)
            {
            }
            column(MaterialDescriptionLbl; MaterialDescription)
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
            column(LegalTextBoxLbl; LegalTextBox1)
            {
            }
            column(LegalTextBoxLbl2; LegalTextBox2)
            {
            }
            column(LegalTextBoxLbl34; LegalTextBox3 + "No." + LegalTextBox4)
            {
            }
            column(LegalTextBoxLbl5; LegalTextBox5 + CompanyInfo."PO Legal Text Box E-Mail FND")
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
            column(PurchaseHeader_ContactPersonEmail_Remove; UserRec."Contact Email")
            {
            }
            column(PurchaseHeader_ContactPersonEmail; UserSetup."E-Mail")
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
            column(TxtExpectedRcptDate; TxtExpectedRcptDate)
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
            // column(testremark; StringHelper.Copy(FORMAT(POTextNew)))//BC UPGRADE PATHAA02-BC doesn't support dotnet variable 
            // {
            // }
            column(PurchaseHeader_ContractcontpersonTxt; ContractcontpersonTxt)
            {
            }
            column(ReasonCodeDescription; ReasonCodeDescription)
            {
            }
            column(ReasonCodeDescriptionLbl; ReasonCodeDescriptionLbl)
            {
            }
            column(FooterSignText; FooterSignText)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = CONST(1));
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
                    column(CompanyInfo_Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo_OpCoLogo; CompanyInfo1."OpCo Logo FND")
                    {
                    }
                    column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfo_VAT; CompanyInfo."VAT Registration No.")
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
                    // column(Vendor_TaxRegistrationNo;"Purchase Header"."Vendor Tax Registration No.")//BC UPGRADE PATHAA02-DIT(F2013726)
                    // {
                    // }
                    column(EUVATNumber; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(Vendor_Contact; Vendor.Contact)
                    {
                    }
                    column(Vendor_Email; Vendor."E-Mail")
                    {
                    }
                    column(PurchaseHeader_DocumentDate; FORMAT("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    column(PurchaseHeader_ExpectedReceiptDate; "Purchase Header"."Expected Receipt Date")
                    {
                    }
                    column(PurchaseHeader_PaymentTerms; PaymentTerms.Description)
                    {
                    }
                    column(PurchaseHeader_IncoTerms; "Purchase Header"."Shipment Method Code")
                    {
                    }
                    column(PurchaseHeader_IncoTermsNew; "Purchase Header"."Shipment Method Code")
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
                    column(FooterTextLbl; FooterText)
                    {
                    }
                    column(FooterText2Lbl; FooterText2)
                    {
                    }
                    column(FooterText1Lbl; FooterText1)
                    {
                    }
                    column(PlantOpeningHrs; CompanyInfo."Plant Opening Hrs. FND")
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting(Number) where(Number = FILTER(1 ..));
                        column(HdrDimCaption; HdrDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.findset() then
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
                            //PurchCommentLine.SETRANGE("Print On Purchase Order",true);//BC UPGRADE PATHAA02-DIT(F2014415)

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
                            //VendCommentLine.SETRANGE("Print On Purchase Order",true);//BC UPGRADE PATHAA02-DIT-F2014415

                            SETRANGE(Number, 1, VendCommentLine.COUNT);
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem();
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = sorting(Number);
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
                        column(ExpectedReceiptDate_PurchaseLine; FORMAT(PurchLine."Expected Receipt Date", 10, '<Day,2>/<Month,2>/<Year4>'))
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
                            DataItemTableView = sorting(Number) where(Number = FILTER(1 ..));
                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.findset() then
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

                            //BC UPGRADE PATHAA02>>

                            // if not ItemCrossRef.GET("Purchase Line"."No.", "Purchase Line"."Variant Code", "Purchase Line"."Unit of Measure Code",
                            //   ItemCrossRef."Cross-Reference Type"::Vendor, "Purchase Line"."Buy-from Vendor No.", "Purchase Line"."Vendor Item No.") then
                            //     ItemCrossRef.INIT;

                            if not ItemRefG.GET("Purchase Line"."No.", "Purchase Line"."Variant Code", "Purchase Line"."Unit of Measure Code",
                                ItemRefG."Reference Type"::Vendor, "Purchase Line"."Buy-from Vendor No.", "Purchase Line"."Vendor Item No.") then
                                ItemRefG.INIT();

                            //BC UPGRADE PATHAA02<<


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


                            if "Purchase Line".Type = "Purchase Line".Type::Item then
                                if Item.GET("Purchase Line"."No.") then;



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
                            //  CurrReport.CREATETOTALS(PurchLine."Line Amount", PurchLine."Inv. Discount Amount"); //BCUPG CREATETOTALS DEPRECATED //PANDEA04
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);
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
                            //    CurrReport.CREATETOTALS(
                            //    VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                            //    VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");//BCUPG CREATETOTALS DEPRECATED //PANDEA04
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = sorting(Number);
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
                            // CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);//BCUPG CREATETOTALS DEPRECATED //PANDEA04

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
                        DataItemTableView = sorting(Number) where(Number = CONST(1));
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
                        DataItemTableView = sorting(Number) where(Number = CONST(1));
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
                        DataItemTableView = sorting(Number) where(Number = FILTER(1 ..));
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
                            DataItemTableView = sorting(Number) where(Number = FILTER(1 ..));

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then begin
                                    if not PrepmtDimSetEntry.findset() then
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
                            // CurrReport.CREATETOTALS(
                            //   PrepmtInvBuf.Amount, PrepmtInvBuf."Amount Incl. VAT",
                            //   PrepmtVATAmountLine."Line Amount", PrepmtVATAmountLine."VAT Base",
                            //   PrepmtVATAmountLine."VAT Amount",
                            //   PrepmtLineAmount); //BCUPG CREATETOTALS DEPRECATED //PANDEA04
                        end;
                    }
                    dataitem(PrepmtVATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);
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
                        DataItemTableView = sorting(Number);
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
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(Number, 1, TEMPPurchaseDocumentLog.COUNT);
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
                    if PrepmtVATAmountLine.findset() then
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
                    //PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);//BC UPGRADE PATHAA02-Function(BuildInvLineBuffer2) removed in BC
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);//BC UPGRADE PATHAA02
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
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                if "Language Code" = 'FRA' then
                    DocLanguage := 'FRA'
                else
                    DocLanguage := 'ENG';
                // CurrReport.LANGUAGE := Language.GetLanguageID(DocLanguage); //BC UPGRADE PATHAA02
                CurrReport.Language := LanguageG.GetLanguageId(DocLanguage); //BC UPGRADE PATHAA02


                CompanyInfo.GET();

                if RespCenter.GET("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);

                    FormatAddr.RespCenter(ShipToCompanyAddr, RespCenter);

                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);


                    //FormatAddr.FormatAddr(ShipToCompanyAddr,CompanyInfo.Name,CompanyInfo."Name 2",CompanyInfo."Ship-to Contact",CompanyInfo."Ship-to Address",
                    //CompanyInfo."Ship-to Address 2",CompanyInfo."Ship-to City",CompanyInfo."Ship-to Post Code",CompanyInfo."Ship-to County",CompanyInfo."Ship-to Country/Region Code");
                    FormatAddr.FormatAddr(ShipToCompanyAddr, CompanyInfo.Name, CompanyInfo."Name 2", "Purchase Header"."Ship-to Contact", "Purchase Header"."Ship-to Address",
                      "Purchase Header"."Ship-to Address 2", "Purchase Header"."Ship-to City", "Purchase Header"."Ship-to Post Code", "Purchase Header"."Ship-to County", "Purchase Header"."Ship-to Country/Region Code");

                end;

                //HEI.02 FooterText := CompanyInfo.Address + '-' + CompanyInfo."Post Code" +' '+ CompanyInfo.City + '-Tel : ' + CompanyInfo."Phone No." + '-' + ' Fax : ' + CompanyInfo."Fax No.";
                //HEI.02 comment line FooterText1 := CompanyInfo."Address 2" + '-' + CompanyInfo."Post Code" + '-Tel : ' + CompanyInfo."Phone No. 2";
                //HEI.02>>
                //HEI.02 FooterText1 := CompanyInfo."Add. Address" + '-' + CompanyInfo."Add. Post Code" +' '+ CompanyInfo."Add. City" + '-Tel : ' + CompanyInfo."Add. Phone No.";
                //HEI.02<<
                //HEI.02 FooterText2 := FooterSubText + ' ' + CompanyInfo."Home Page";

                //HEI.02>>
                FooterText := CompanyInfo.Address;
                if CompanyInfo."Post Code" <> '' then
                    FooterText := FooterText + ' - ' + CompanyInfo."Post Code";
                if CompanyInfo.City <> '' then
                    FooterText := FooterText + ' ' + CompanyInfo.City;
                if CompanyInfo."Phone No." <> '' then
                    FooterText := FooterText + ' - Tel: ' + CompanyInfo."Phone No.";
                if CompanyInfo."Fax No." <> '' then
                    FooterText := FooterText + ' - Fax: ' + CompanyInfo."Fax No.";

                FooterText1 := CompanyInfo."Add. Address FND";
                if CompanyInfo."Add. Post Code FND" <> '' then
                    FooterText1 := FooterText1 + ' - ' + CompanyInfo."Add. Post Code FND";
                if CompanyInfo."Add. City FND" <> '' then
                    FooterText1 := FooterText1 + ' ' + CompanyInfo."Add. City FND";
                if CompanyInfo."Add. Phone No. FND" <> '' then
                    FooterText1 := FooterText1 + ' - Tel: ' + CompanyInfo."Add. Phone No. FND";

                FooterText2 := FooterSubText + ' ' + CompanyInfo."Home Page";

                if FooterText = '' then begin
                    FooterText := FooterText1;
                    FooterText1 := FooterText2;
                    FooterText2 := '';
                end else begin
                    if FooterText1 = '' then begin
                        FooterText1 := FooterText2;
                        FooterText2 := '';
                    end;
                end;

                //HEI.02<<

                //User.SETRANGE("User Name","Last changed User ID");
                User1.RESET();
                //User1.SETRANGE("User Name", "Created By");//BC UPGRADE PATHAA02
                User1.SetRange("User Name", SystemCreatedBy); //BC UPGRADE PATHAA02

                if User1.FINDFIRST() then begin
                    if User1."Full Name" <> '' then
                        ContactPersonCode := User1."Full Name"
                    else
                        // ContactPersonCode := "Created By"; //BC UPGRADE PATHAA02
                        ContactPersonCode := SystemCreatedBy; //BC UPGRADE PATHAA02

                end;


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
                if PurchaseLine.findset() then begin
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

                if Vendor.GET("Purchase Header"."Buy-from Vendor No.") then;

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                if "Buy-from Vendor No." <> "Pay-to Vendor No." then
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
                if "Payment Terms Code" = '' then
                    PaymentTerms.INIT()
                else begin
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, DocLanguage);
                end;
                if "Prepmt. Payment Terms Code" = '' then
                    PrepmtPaymentTerms.INIT()
                else begin
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, DocLanguage);
                end;
                if "Shipment Method Code" = '' then
                    ShipmentMethod.INIT()
                else begin
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, DocLanguage);
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


                if "Currency Code" = '' then
                    LCYCode := GLSetup."LCY Code"
                else
                    LCYCode := "Currency Code";



                ApprovalEntry.RESET();
                ApprovalEntry.SETRANGE("Table ID", DATABASE::"Purchase Header");
                ApprovalEntry.SETRANGE("Document Type", "Document Type");
                ApprovalEntry.SETRANGE("Document No.", "No.");
                ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FINDLAST() then;

                User.RESET();
                User.SETRANGE("User Name", ApprovalEntry."Approver ID");
                if User.FINDFIRST() then begin
                    if User."Full Name" <> '' then
                        ApprovedUserName := User."Full Name"
                    else
                        ApprovedUserName := ApprovalEntry."Approver ID";
                end;


                if "Purchase Header"."Changed FND" then begin
                    PurchaseDocumentLog.RESET();
                    PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                    PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                    PurchaseDocumentLog.SETRANGE(Printed, false);
                    PurchaseDocumentLog.SETRANGE(Comment, 'Line Deleted');
                    if PurchaseDocumentLog.findset() then
                        repeat
                            TEMPPurchaseDocumentLog := PurchaseDocumentLog;
                            TEMPPurchaseDocumentLog.Comment := 'Cancelled';
                            TEMPPurchaseDocumentLog.INSERT();
                        until PurchaseDocumentLog.NEXT() = 0;
                end;

                POHeaderMark := 0;
                POChanged := 0;

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
                if PurchaseDocumentLog.findset() then
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


                //HEI.03>>
                CLEAR(ContactPersonTxt);
                CLEAR(UsrName);
                CLEAR(ContractcontpersonTxt);
                CLEAR(ContrContPerUsrName);
                CLEAR(PurchaserCode);
                CLEAR(ReasonCodeDescription);

                if PurchaseReasonCode.GET("Purch. Reason Code FND") then
                    ReasonCodeDescription := PurchaseReasonCode.Description;

                "Purchase Header".CALCFIELDS("Purchase Header"."PQ Approver FND");
                // Contact Person
                if "Purchase Header"."Maximo Requisition No. FND" <> '' then
                    UsrName := "Purchase Header"."PQ Approver FND"
                else if "Purchase Header"."Quote No." <> '' then
                    //BC UPGRADE PATHAA02-Code commented for condition error>>
                    /*
                        // UsrName := "Purchase Header"."Requester ID" //BC UPGRADE PATHAA02-DIT(F2014430)
                        else
                        // UsrName := "Purchase Header"."Created By";//BC UPGRADE PATHAA02
                        UsrName := "Purchase Header".SystemCreatedBy; //BC UPGRADE PATHAA02
                       */
                    //BC UPGRADE PATHAA02-Code commented for condition error<<


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
                    end;
                end else begin
                    if PurchasesPayablesSetup."PO Legal Text FND".HASVALUE then begin
                        PurchasesPayablesSetup."PO Legal Text FND".CREATEINSTREAM(MemoReader);
                        POTextNew.READ(MemoReader);
                    end;
                end;

                //HEI.03<<

                // if UserSetup.GET("Purchase Header"."Created By") then;//HEI.06 //BC UPGRADE PATHAA02
                if UserSetup.GET("Purchase Header".SystemCreatedBy) then;//BC UPGRADE PATHAA02
            end;

            trigger OnPostDataItem();
            var
                PurchHeader: Record "Purchase Header";
            begin
                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                if Print then begin
                    if TempPrintedPurchHeader.findset() then
                        repeat
                            PurchHeader.GET(TempPrintedPurchHeader."Document Type", TempPrintedPurchHeader."No.");
                        //BC UPGRADE PATHAA02-DIT(F2014114)-code commented>>
                        /*
                        if PurchHeader."Receipt Status" < SetReceiptStatus then begin
                            PurchHeader.VALIDATE("Receipt Status", SetReceiptStatus);
                            PurchHeader.MODIFY(true);
                        end;
                        */
                        //BC UPGRADE PATHAA02-DIT(F2014114)-code commented<<
                        until TempPrintedPurchHeader.NEXT() = 0;
                end;
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
                    CaptionML = ENU = 'Options',
                                ENG = 'Options';
                    field(NoofCopies; NoOfCopies)
                    {
                        CaptionML = ENU = 'No. of Copies',
                                    ENG = 'No. of Copies';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the NoOfCopies field.';
                    }
                    field(SetReceiptStatus; SetReceiptStatus)
                    {
                        CaptionML = ENU = 'Set Receipt Status',
                                    ENG = 'Set Receipt Status';
                        OptionCaptionML = ENU = 'Open,Order Printed,Order Sent,Order Confirmed,To Receive,Receipt Completed,Invoice',
                                          ENG = 'Open,Order Printed,Order Sent,Order Confirmed,To Receive,Receipt Completed,Invoice';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the SetReceiptStatus field.';
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
        DocumentType: Enum "Interaction Log Entry Document Type";
        begin
            //BC UPGRADE PATHAA02>>
            //ArchiveDocument := PurchSetup."Archive Quotes and Orders";//BC UPGRADE PATHAA02-Field missing in Table
            ArchiveDocument := PurchSetup."Archive Orders"; //BC UPGRADE PATHAA02-replaced this field
            //LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';
            LogInteraction := SegManagement.FindInteractionTemplateCode(DocumentType::"Purch. Ord.") <> '';
            //BC UPGRADE PATHAA02<<

            LogInteractionEnable := LogInteraction;
            SetReceiptStatus := SetReceiptStatus::"Order Printed";
        end;
    }

    labels
    {
        label(LblCode; ENU = 'Material',
                      ENG = 'Material')
        label(LblDescription; ENU = 'Material Description',
                             ENG = 'Material Description')
        label(lblExpectedReceiptDate; ENU = 'Expected Receipt Date',
                                     FRA = 'Date de réception prévue',
                                     ENG = 'Expected Receipt Date')
        label(LblQty; ENU = 'Quantity',
                     ENG = 'Quantity')
        label(LblUOM; ENU = 'UOM',
                     ENG = 'UOM')
        label(LblUnitCost; ENU = 'Net Price',
                          ENG = 'Net Price')
        label(LblVATPer; ENU = 'Vat %',
                        ENG = 'Vat %')
        label(lblLineDiscPerc; ENU = 'Disc.%',
                              ENG = 'Disc.%')
        label(LblAmount; ENU = 'Net Value',
                        ENG = 'Net Value')
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        PurchSetup.GET();

        CompanyInfo1.GET();
        CompanyInfo1.CALCFIELDS(Picture);
        CompanyInfo1.CALCFIELDS("OpCo Logo FND");
    end;

    var
        ApprovalEntry: Record "Approval Entry";
        VendCommentLine: Record "Comment Line";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        PrepmtDimSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        Item: Record Item;
        //ItemCrossRef: Record "Item Cross Reference"; //BC UPGRADE PATHAA02-Item Cross Refernce obsolete in BC
        ItemRefG: Record "Item Reference";//BC UPGRADE PATHAA02
        recLocation: Record Location;
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        PurchCommentLine: Record "Purch. Comment Line";
        PurchaseDocumentLog: Record "Purchase Document Log FND";
        TEMPPurchaseDocumentLog: Record "Purchase Document Log FND" temporary;
        TempPrintedPurchHeader: Record "Purchase Header" temporary;
        PurchaseLine: Record "Purchase Line";
        PurchLine: Record "Purchase Line" temporary;
        //StringHelper: DotNet "'mscorlib'.System.String"; //BC UPGRADE PATHAA02-dotnet variable not supported
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        PurchaseReasonCode: Record "Reason Code_Purchase FND";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        TransportMethod: Record "Transport Method";
        User: Record User;
        User1: Record User;
        UserRec: Record User;
        ApprovalUserRec: Record "User Setup";
        UserSetup: Record "User Setup";
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrePmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        TempVATAmountLine1: Record "VAT Amount Line" temporary;
        VATAmountLine: Record "VAT Amount Line" temporary;
        Vendor: Record Vendor;
        ArchiveManagement: Codeunit ArchiveManagement;
        FormatAddr: Codeunit "Format Address";
        //Language : Record Language; //BC UPGRADE PATHAA02
        LanguageG: Codeunit Language;//BC UPGRADE PATHAA02
        PurchPost: Codeunit "Purch.-Post";
        PurchCountPrinted: Codeunit "Purch.Header-Printed";
        PurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
        SegManagement: Codeunit SegManagement;
        POTextNew: BigText;
        ArchiveDocument: Boolean;

        ArchiveDocumentEnable: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;

        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        Print: Boolean;
        ShowAddr: Boolean;
        ShowAddr2: Boolean;
        ShowCityPostCode: Boolean;
        ShowContact: Boolean;
        ShowCountryRegion: Boolean;
        ShowInternalInfo: Boolean;
        DocLanguage: Code[10];
        LCYCode: Code[10];
        PurchaserCode: Code[10];
        ContrContPerUsrName: Code[50];
        UsrName: Code[50];
        PrepmtLineAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalSubTotal: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VatAmt: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        VATPer: Decimal;
        MemoReader: InStream;
        "HIT8006.71": Integer;
        i: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        POChanged: Integer;
        POHeaderMark: Integer;
        FooterSignText: Label 'This document has been signed electronically, hence no signature is required.';
        ReasonCodeDescriptionLbl: Label 'Reason Code:';
        SetReceiptStatus: Option Open,"Order Printed","Order Sent","Order Confirmed","To Receive","Receipt Completed",Invoice;
        ContactPersonTxt: Text;
        ContractcontpersonTxt: Text;
        POLineStatus: Text;
        POText: Text;
        ReasonCodeDescription: Text;
        AllowInvDisctxt: Text[30];
        CopyText: Text[30];
        PricesInclVATtxt: Text[30];
        PurchaserText: Text[30];
        txtLocationFaxNo: Text[30];
        txtLocationPhoneNo: Text[30];
        VATPerText: Text[30];
        BuyFromAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        ShipToCompanyAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        VendAddr: array[8] of Text[50];
        OldDimText: Text[75];
        ApprovedUserName: Text[80];
        ContactPersonCode: Text[80];
        ReferenceText: Text[80];
        txtLocationEmail: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        DimText: Text[120];
        PurchComment: Text[250];
        VendComment: Text[250];
        FooterText: Text[500];
        FooterText1: Text[500];
        FooterText2: Text[500];
        ApprovedBy: TextConst ENU = 'Approved by:', ESP = 'Aprobado por:', FRA = 'Approuvé par:', ENG = 'Approved by:';
        ContactPerson: TextConst ENU = 'Contact person:', ESP = 'Persona de Contacto:', FRA = 'Personne à contacter:', ENG = 'Contact person:';
        ContractContactPerson: TextConst ENU = 'Contract Contact Person:', ESP = 'Contacto:', FRA = 'Personne à contacter:', ENG = 'Contract Contact Person:';
        CR: TextConst ENU = 'CR:', ESP = 'CR:', FRA = 'CR:', ENG = 'CR:';
        Currency: TextConst ENU = 'Currency:', ESP = 'Moneda:', FRA = 'Devise:', ENG = 'Currency:';
        DeliveryDate: TextConst ENU = 'Delivery Date:', ESP = 'Fecha de Entrega:', FRA = 'Date de Livraison:', ENG = 'Delivery Date:';
        DeliveryTerms: TextConst ENU = 'Delivery Terms:', ESP = 'Términos de entrega:', FRA = 'Conditions de Livraison:', ENG = 'Delivery Terms:';
        DocumentDate: TextConst ENU = 'Document Date:', ESP = 'Fecha del documento:', FRA = 'Date de document:', ENG = 'Document Date:';
        EUVATNumber: TextConst ENU = 'VAT Number:', ESP = 'EU VAT Number:', FRA = 'EU VAT Number:', ENG = 'VAT Number:';
        FooterSubText: TextConst ENU = 'Site Internet:', ENG = 'Site Internet:';
        HdrDimCaptionLbl: TextConst ENU = 'Header Dimensions', ENG = 'Header Dimensions';
        Incoterms: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:', ENG = 'Incoterms:';
        IncotermsLocLbl: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:';
        ItemCaption: TextConst ENU = 'Item', ESP = 'Artículo', FRA = 'Article', ENG = 'Item';
        LegalContractReference: TextConst ENU = 'Legal Contract Reference:', ESP = 'Referencia legal del contrato:', FRA = 'Référence du contrat legal:', ENG = 'Legal Contract Reference:';
        LegalTextBox1: TextConst ENU = 'This Purchase Order is excluding VAT. Please :', FRA = 'Ce bon de commande est hors TVA. Merci de bien vouloir:', ENG = 'This Purchase Order is excluding VAT. Please :';
        LegalTextBox2: TextConst ENU = '• confirm this Purchase Order(delivery time, quantity, quality) within 48H', FRA = '•       confirmer cette commande (Délai, quantité, qualité) sous 48H. ', ENG = '• confirm this Purchase Order(delivery time, quantity, quality) within 48H';
        LegalTextBox3: TextConst ENU = '• write this Purchase Order Number ', FRA = '•       mentionner le numéro de ce bon de commande  ', ENG = '• write this Purchase Order Number ';
        LegalTextBox4: TextConst ENU = ' on your invoice', FRA = ' sur votre facture.', ENG = ' on your invoice';
        LegalTextBox5: TextConst ENU = 'send your invoice to our accounts payable department per post or email to ', FRA = '•       envoyer votre facture à notre service comptabilité via courrier ou email à ', ENG = 'send your invoice to our accounts payable department per post or email to ';
        LineDimCaptionLbl: TextConst ENU = 'Line Dimensions', ENG = 'Line Dimensions';
        MachineRefNo: TextConst ENU = 'Machine Reference Number', ESP = 'Machine Reference Number', FRA = 'Machine Reference Number', ENG = 'Machine Reference Number';
        Material: TextConst ENU = 'Material', ESP = 'Material', FRA = 'Matériel', ENG = 'Material';
        MaterialDescription: TextConst ENU = 'Material Description', ESP = 'Descripción del material', FRA = 'Description du matériel', ENG = 'Material Description';
        NetPrice: TextConst ENU = 'Net Price', ESP = 'Precio Neto', FRA = 'Prix Net', ENG = 'Net Price';
        NetValue: TextConst ENU = 'Net Value', ESP = 'Valor Neto', FRA = 'Valeur Nette', ENG = 'Net Value';
        OperationalContractRef: TextConst ENU = 'Operational Contract ref:', ESP = 'Referencia del contrato operacional:', FRA = 'Référence du contrat opérationnel:', ENG = 'Operational Contract ref:';
        OrderDateLbl: TextConst ENU = 'Order Date:', FRA = 'Date de commande', FRB = 'Date de commande';
        OrderingParty: TextConst ENU = 'ORDERING PARTY:', ESP = 'COMPAÑÍA QUE ORDENA:', FRA = 'DONNEUR D''ORDRE:', ENG = 'ORDERING PARTY:';
        PageCaption: TextConst ENU = 'Page', ESP = 'Pgina', FRA = 'Page', ENG = 'Page';
        PaymentDetailsCaptionLbl: TextConst ENU = 'Payment Details', ENG = 'Payment Details';
        PaymentTermsCaption: TextConst ENU = 'Payment Terms:', ESP = 'Términos de Pago:', FRA = 'Conditions de Paiements:', ENG = 'Payment Terms:';
        Phone: TextConst ENU = 'Phone:', ESP = 'Teléfono:', FRA = 'Téléphone:', ENG = 'Phone:';
        PlantOpeningHrs: TextConst ENU = 'Plant opening hrs:', ESP = 'Horario:', FRA = 'Horaires d''ouverture du site:', ENG = 'Plant opening hrs:';
        PleaseDeliverGoodsTo: TextConst ENU = 'PLEASE DELIVER GOODS TO:', ESP = 'FAVOR ENTREGAR MERCANCÍA A:', FRA = 'VEUILLEZ LIVRER LES MARCHANDISES À:', ENG = 'PLEASE DELIVER GOODS TO:';
        PleaseDeliverInvoiceTo: TextConst ENU = 'PLEASE DELIVER INVOICE TO:', ESP = 'FAVOR ENTREGAR FACTURA A:', FRA = 'VEUILLEZ TRANSMETTRE LA FACTURE À:', ENG = 'PLEASE DELIVER INVOICE TO:';
        PrepaymentSpecCaptionLbl: TextConst ENU = 'Prepayment Specification', ENG = 'Prepayment Specification';
        PrepmtInvBuDescCaptionLbl: TextConst ENU = 'Description', ENG = 'Description';
        PrepmtInvBufGLAccNoCaptionLbl: TextConst ENU = 'G/L Account No.', ENG = 'G/L Account No.';
        PrepymtVATAmtSpecCaptionLbl: TextConst ENU = 'Prepayment VAT Amount Specification', ENG = 'Prepayment VAT Amount Specification';
        PurchaseOrderValue: TextConst ENU = 'PURCHASE ORDER VALUE:', ESP = 'VALOR DEL PEDIDO:', FRA = 'VALEUR DE LA COMMANDE: ', ENG = 'PURCHASE ORDER VALUE:';
        QuantityCaption: TextConst ENU = 'Quantity', ESP = 'Cantidad', FRA = 'Quantité', ENG = 'Quantity';
        ReportTitle: TextConst ENU = 'Purchase Order No.', ESP = 'Orden de Compra No.', FRA = 'Bon de Commande No.', ENG = 'Purchase Order No.';
        Reprinted: TextConst ENU = 'Reprinted', ESP = 'Reimpreso', FRA = 'Réimprimé', ENG = 'Reprinted';
        TaxIdentification: TextConst ENU = 'Tax Identification:', ESP = 'Número de Identificación de Impuestos:', FRA = 'Numero Identifiant Fiscal:', ENG = 'Tax Identification:';
        TaxIdentificationNumber: TextConst ENU = 'Tax Identification Number:', ESP = 'Número de Identificación de Impuestos:', FRA = 'Numero Identifiant Fiscal:', ENG = 'Tax Identification Number:';
        Text000: TextConst ENU = 'Purchaser', ENG = 'Purchaser';
        Text001: TextConst ENU = 'Total %1', ENG = 'Total %1';
        Text002: TextConst ENU = 'Total %1 Incl. VAT', ENG = 'Total %1 Incl. VAT';
        Text003: TextConst ENU = ' COPY', ENG = ' COPY';
        Text004: TextConst ENU = 'Ordering %1', ENG = 'Ordering %1';
        Text005: TextConst ENU = 'Page %1', ENG = 'Page %1';
        Text006: TextConst ENU = 'Total %1 Excl. VAT', ENG = 'Total %1 Excl. VAT';
        Text007: TextConst ENU = 'VAT Amount Specification in ', ENG = 'VAT Amount Specification in ';
        Text008: TextConst ENU = 'Local Currency', ENG = 'Local Currency';
        Text009: TextConst ENU = 'Exchange rate: %1/%2', ENG = 'Exchange rate: %1/%2';
        Text52003: TextConst ENU = 'VAT %1 ', ENG = 'VAT %1 ';
        TxtExpectedRcptDate: TextConst ENU = 'Expected Delivery Date', FRA = 'Date de livraison prévue';
        UoM: TextConst ENU = 'UoM', ESP = 'Unidad de Medición', FRA = 'Unité de mesure', ENG = 'UoM';
        VAT: TextConst ENU = 'VAT:', ESP = 'VAT:', FRA = 'VAT:', ENG = 'VAT:';
        VendNoCaptionLbl: TextConst ENU = 'Vendor No.', ENG = 'Vendor No.';
        VendorCaption: TextConst ENU = 'VendOR:', ESP = 'PROVEEDOR:', FRA = 'FOURNISSEUR:', ENG = 'VendOR:';
        YourVendorNoWithUs: TextConst ENU = 'Your Vendor Number with us:', ESP = 'Su número de proveedor con nosotros:', FRA = 'Votre numéro de fournisseur avec nous:', ENG = 'Your Vendor Number with us:';

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;
}

