report 52010 "Purchase Order BA"
{
    // version HEI.07

    // HEI.01 FDD-BA-PURGAP02 Purchase Order Layout Local Bahamas IBM.NAIKH01 21.06.2018
    //   #Created a new report for Purchase order Copy of Report 50058 Panama
    // 
    // HEI.02 Defect #3025 IBM NAIKH01 28.09.2018 # user informations based on Creator user id
    // 
    // HEI.03 CHG0268766 IBM ISYED01 03.31.2018 #Print delivery address on PO
    //  # added code to get the delivery address from the purchase header
    // 
    // HEI.04 FDD-PURGAP030 - Send updated PO to supplier with specified  changes_V1.1 , NAIKH01 , 03.28.2019
    //   #Added new code.
    //   # Also added new Column "Comments" in the Reports design and added a new table in report design.
    // 
    // HEI.05 FDD-CHG2028965 IBM SURYAS01 31/10/2019
    // #Added New table for vendor Comments in Layout
    // # Added New table for Purchase Comments in layout
    // #Changed delivery date value from Purchase header to Purchase line Expected Receipt date.
    // 
    // HEI.06 FDD-HB858 - CHG2027215 SHANKJ03 IBM 23.01.2020
    //   # ContactCOntractPerson value changed based on FDD condition
    //   # Removed Delivery Date from layout
    //   # Incoterm Caption changed to Incoerm Location
    //   # Approved By is made hidden in layout
    //   # Document date is changed to Order Date
    // HEI.07 HB2907 CHG2157356 IBM SHIVAS05 31.08.2022
    //   # Find Contact Person Email form user setup on the basis of Created By user
    //*****************************************//
    //BC UPGRADE ATHUKS01//
    // 1. Add Layout path and change layout extension RDLC to rdl.
    // 2. Remove Drink-IT Fields ("Print On Purchase Order","Requester ID","Created By","Receipt Status")
    // 3. Change Language to LanguageMgt and record to codeunit.
    // 4. Function BuildInvLineBuffer2 is obsolete in Business central , so we are using BuildInvLineBuffer.
    // 5. Function FindInteractTmplCode is obsolete in Business central , so we are using FindInteractionTemplateCode.and change peremeter 13 to "Purch. Ord."
    // 6. "Item Cross Reference" is absolete, so we are using "Item Refrence" in the Place of  "Item Cross Reference". And and in the place of "Cross-Reference Type" we are using ("Reference Type")
    // 7. Comment dotnet variable (StringHelper) this variable convert bigtext to text so we write the simple code by using Text & Method ReadInstream.
    // 8. Field PurchSetup."Archive Quotes and Orders" is missing replaced with "Archive Orders".
    // 9. The “Vendor Tax Registration No.” column in the report was commented out, and the same column was re-added with a blank expression to avoid report rendering issues and data retrieval errors.  
    // 10. Old Report ID is 50141.
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Purchase Order BA.rdl';

    CaptionML = ENU = 'Purchase Order',
                ESP = 'Orden de Compra',
                FRA = 'Bon de Commande';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
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
            column(PurchaseHeader_ContactPersonName; UserRec."Full Name")
            {
            }
            column(PurchaseHeader_ContactPersonEmail_Remove; UserRec."Contact Email")
            {
            }
            column(PurchaseHeader_ContactPersonEmail; UserSetup."E-Mail")
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
            //BC UPGRADE ATHUKS01 >>Donnetvariable
            // column(testremark; StringHelper.Copy(FORMAT(POTextNew)))
            // {

            // }
            //BC UPGRADE ATHUKS01 << Donnetvariable
            //BC UPGRADE ATHUKS01 >> Added 
            column(testremark; StringHelper)
            {
            }
            //BC UPGRADE ATHUKS01<< Added
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
                    // BC UPGRADE ATHUKS01>>
                    // column(Vendor_TaxRegistrationNo; "Purchase Header"."Vendor Tax Registration No.")
                    // {
                    // }
                    column(Vendor_TaxRegistrationNo; '')
                    {
                    }
                    //  BC UPGRADE ATHUKS01<<
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
                    column(PurchaseHeader_IncoTerms; "Purchase Header"."Shipment Method Code" + ' ' + "Purchase Header"."Shipment Method Location FND")
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
                    column(ExpectedReceiptDate_PurchaseLine; FORMAT(DeliveryDate1, 10, '<Day,2>/<Month,2>/<Year4>'))
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
                            //PurchCommentLine.SETRANGE("Print On Purchase Order", true);BC UPGRADE ATHUKS01 Drink IT 

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
                            //VendCommentLine.SETRANGE("Print On Purchase Order", true);//BC UPGRADE ATHUKS01 Drink IT Field

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
                        column(MachineRefNoCaption; MachinerefNo)
                        {
                        }
                        column(Item_MachineReferenceNo; Item."Machine Reference Number FND")
                        {
                        }
                        column(LineNo; LineNo)
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
                            //BC UPGRADE ATHUKS01 >> BC Removed Item Cross Ref Table  
                            if not ItemCrossRef.GET("Purchase Line"."No.", "Purchase Line"."Variant Code", "Purchase Line"."Unit of Measure Code",
                            ItemCrossRef."Reference Type"::Vendor, "Purchase Line"."Buy-from Vendor No.", "Purchase Line"."Vendor Item No.") then
                                ItemCrossRef.INIT();
                            //BC UPGRADE ATHUKS01 << BC Removed Item Cross Ref Table
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
                                if Item.GET("Purchase Line"."No.") then;
                            //HEI.04<<
                            LineNo := INCSTR(LineNo); //HEI.06

                            //>>HEI.04
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
                            //<<HEI.04
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

                            LineNo := '000'; //HEI.06
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
                               (VATAmountLine.GetTotalVATAmount = 0)
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
                                until PrepmtDimSetEntry.NEXT = 0;
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not PrepmtInvBuf.FIND('-') then
                                    CurrReport.BREAK();
                            end else
                                if PrepmtInvBuf.NEXT = 0 then
                                    CurrReport.BREAK;

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
                            //HEI.04
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(Number, 1, TEMPPurchaseDocumentLog.COUNT);
                            //>>HEI.04
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
                    //PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);//BC UPGRADE ATHUKS01 BuildInvLineBuffer2 Not Exist.
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);//BC UPGRADE ATHUKS01 
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT;

                    if Number > 1 then
                        CopyText := Text003;
                    CurrReport.PAGENO := 1;
                    OutputNo := OutputNo + 1;

                    TotalSubTotal := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem();
                begin
                    if not CurrReport.PREVIEW() then
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
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageID("Language Code");

                //>>HEI.01
                //User.SETRANGE("User Name","Last changed User ID");
                // BC UPGRADE ATHUKS01 >> Drink IT Field
                // User.SETRANGE("User Name", "Created By");//HEI.02
                //if User.FINDSET() then;
                // BC UPGRADE ATHUKS01 << Drink IT Field

                //<<HEI.01

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
                    //HEI.03>>
                    //FormatAddr.FormatAddr(ShipToCompanyAddr,CompanyInfo.Name,CompanyInfo."Name 2",CompanyInfo."Ship-to Contact",CompanyInfo."Ship-to Address",
                    //CompanyInfo."Ship-to Address 2",CompanyInfo."Ship-to City",CompanyInfo."Ship-to Post Code",CompanyInfo."Ship-to County",CompanyInfo."Ship-to Country/Region Code");
                    FormatAddr.FormatAddr(ShipToCompanyAddr, CompanyInfo.Name, CompanyInfo."Name 2", "Purchase Header"."Ship-to Contact", "Purchase Header"."Ship-to Address",
                      "Purchase Header"."Ship-to Address 2", "Purchase Header"."Ship-to City", "Purchase Header"."Ship-to Post Code", "Purchase Header"."Ship-to County", "Purchase Header"."Ship-to Country/Region Code");
                    //HEI.03<<
                end;
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

                if not CurrReport.PREVIEW() then begin
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
                //BC UPGRADE ATHUKS01 >> Drink IT code
                // //<<DITW18.00.06 BCE 11/08/2015 DIT-770 #1532
                // recLocation.RESET();
                // if recLocation.GET("Purchase Header"."Location Code") then begin
                //     txtLocationPhoneNo := recLocation."Phone No.";
                //     txtLocationEmail := recLocation."E-Mail";
                //     txtLocationFaxNo := recLocation."Fax No.";
                // end;
                // //>>DITW18.00.06 BCE DIT-770 #1532

                // //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                // if Print then begin
                //     TempPrintedPurchHeader := "Purchase Header";
                //     TempPrintedPurchHeader.INSERT();
                // end;
                // //>> DITW18.00.07 VSC DIT-770 #1970
                //BC UPGRADE ATHUKS01 << Drink IT code

                //>>HEI.02
                if "Currency Code" = '' then
                    LCYCode := GLSetup."LCY Code"
                else
                    LCYCode := "Currency Code";
                //<<HEI.02
                //<<HEI.04
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
                //>>HEI.04

                DeliveryDate1 := 0D;
                PurchLine1.RESET();
                PurchLine1.SETRANGE("Document No.", "No.");
                PurchLine1.SETRANGE("Document Type", "Document Type");
                if PurchLine1.FINDSET() then
                    DeliveryDate1 := PurchLine1."Expected Receipt Date";



                //HEI.06>>
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
                    UsrName := "Purchase Header"."PQ Approver FND"
                else if "Purchase Header"."Quote No." <> '' then;
                //BC UPGRAD ATHUKS01>> Drink IT Field
                //UsrName := "Purchase Header"."Requester ID" 
                // else
                //UsrName := "Purchase Header"."Created By";
                //BC UPGRAD ATHUKS01<<

                if UsrName <> '' then begin
                    UserRec.RESET();
                    UserRec.SETRANGE("User Name", UsrName);
                    if UserRec.FINDFIRST then
                        ContactPersonTxt := UserRec."Full Name";
                end;

                //Contract Contact Person
                if "Purchase Header"."Channel FND" = '' then
                    ContrContPerUsrName := ''
                else If ("Purchase Header"."Channel FND" = 'A') or ("Purchase Header"."Channel FND" = 'D') then begin
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
                        //POTextNew.READ(MemoReader);BC UPGRADE ATHUKS01
                        ReadInstream(MemoReader);//BC UPGRADE ATHUKS01

                    end;
                end else begin
                    if PurchasesPayablesSetup."PO Legal Text FND".HASVALUE then begin
                        PurchasesPayablesSetup."PO Legal Text FND".CREATEINSTREAM(MemoReader);
                        //POTextNew.READ(MemoReader);BC UPGRADE ATHUKS01
                        ReadInstream(MemoReader);//BC UPGRADE ATHUKS01
                    end;
                end;

                //HEI.06<<
                // if UserSetup.GET("Purchase Header"."Created By") then;//HEI.07//BC UPGRADE ATHUKS01 Drink IT code 
            end;
            //BC UPGRADE ATHUKS01 >> Drink IT code 
            // trigger OnPostDataItem();
            // var
            //     PurchHeader: Record "Purchase Header";
            // begin
            //     //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
            //     if Print then begin
            //         ()
            //         if TempPrintedPurchHeader.FINDSET() then
            //             repeat
            //                 PurchHeader.GET(TempPrintedPurchHeader."Document Type", TempPrintedPurchHeader."No.");
            //                 if PurchHeader."Receipt Status" < SetReceiptStatus then begin
            //                     PurchHeader.VALIDATE("Receipt Status", SetReceiptStatus);
            //                     PurchHeader.MODIFY(true);
            //                 end;
            //             until TempPrintedPurchHeader.NEXT() = 0;
            //     end;
            // end;

            // trigger OnPreDataItem();
            // begin
            //     //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
            //     Print := Print or not CurrReport.PREVIEW;
            //     TempPrintedPurchHeader.RESET();
            //     TempPrintedPurchHeader.DELETEALL();
            // end;
            //BC UPGRADE ATHUKS01 << Drink IT code
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
                        Caption = 'No. of Copies';
                        ApplicationArea = all;
                        ToolTip = 'No. of Copies';
                    }
                    field(SetReceiptStatus; SetReceiptStatus)
                    {
                        Caption = 'Set Receipt Status';
                        ToolTip = 'Set Receipt Status';
                        ApplicationArea = all;
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
        var
        enumvalue : Enum "Interaction Log Entry Document Type"; 
        begin
            //BC UPGRADE ATHUKS01>> Field 37 Not Exist BC    
            //ArchiveDocument := PurchSetup."Archive Quotes and Orders()";
            ArchiveDocument := PurchSetup."Archive Orders";
            //BC UPGRADE ATHUKS01<< Field 37 Not Exist BC

            //BC UPGRADE ATHUKS01 >> ChangeMethodName
            //LogInteraction := SegManagement.FindInteractTmplCode(3) <> '';
            LogInteraction := SegManagement.FindInteractionTemplateCode(enumvalue::"Sales Ord. Cnfrmn.") <> '';
            //BC UPGRADE ATHUKS01<<ChangeMethodName

            LogInteractionEnable := LogInteraction;
            SetReceiptStatus := SetReceiptStatus::"Order Printed";
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        PurchSetup.GET();

        CompanyInfo1.GET();
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
        LanguageR: Record Language;
        LanguageMgt: Codeunit Language;
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
        LegalTextBox: Label 'Purchase Order must be stated on the invoice otherwise the invoice will not be processed and will be returned. Purchase Order must be confirmed via e-mail to cblpurchasing@heineken.com in three working days. Supplier is going to conclude an agreement with Commonwealth Brewery/Burn House Group(CBL) in such a way that Supplier agrees to the General Terms & Conditions of CBL unless Parties or HEINEKEN Global Procurement B.V. have concluded a different agreement';
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
        LineNo: Code[10];
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
        PurchCommentLine: Record "Purch. Comment Line";
        PurchComment: Text[250];
        VendCommentLine: Record "Comment Line";
        VendComment: Text[250];
        ContactPersonTxt: Text;
        UsrName: Code[50];
        UserRec: Record User;
        ContractcontpersonTxt: Text;
        ContrContPerUsrName: Code[50];
        PurchaserCode: Code[10];
        ApprovalUserRec: Record "User Setup";
        MemoReader: InStream;
        //StringHelper: DotNet "'mscorlib'.System.String";//BC UPGRADE ATHUKS01 Cloud not support
        StringHelper: Text;//BC UPGRADE ATHUKS01
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        POTextNew: BigText;
        ExpRecDtLbl: TextConst ENU = 'Expected Delivery Date', ESP = 'Fecha de estimada de entrega', FRA = 'Date de livraison prévue';
        IncotermsLocLbl: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:';
        OrderDateLbl: TextConst ENU = 'Order Date:', ESP = 'Fecha de Orden';
        ReasonCodeDescription: Text;
        PurchaseReasonCode: Record "Reason Code_Purchase FND";
        ReasonCodeDescriptionLbl: Label 'Reason Code:';
        UserSetup: Record "User Setup";

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;

    //BC UPGRADE ATHUKS01>>For Replace of .netVarible
    procedure ReadInstream(Ins: InStream)
    var
        Line: text;
    begin
        Clear(StringHelper);
        while not InS.EOS do begin
            InS.ReadText(Line);
            StringHelper += Line;
        end;
    end;
    //BC UPGRADE ATHUKS01<< For Replace of .netVarible
}

