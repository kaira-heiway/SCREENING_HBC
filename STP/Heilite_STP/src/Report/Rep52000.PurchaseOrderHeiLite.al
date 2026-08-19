report 52000 "Purchase Order HeiLite"
{
    // version HEI.11
    // BC Upgrade Kamnay01 Original(Heilite) Report id 50032
    // HEI.01 FDD-PURGAPINT005 IBM NASTAA02 27.09.2017 # Purchase Order Layout Template Procurement
    //   # New Report created with a standard layout
    // 
    // HEI.02 FDD-PURGAPINT005 Defect #719 IBM NASTAA02 23.10.2017 # Purchase Order Layout Template Procurement
    //   # Currency Code should always be filled-in on the layout
    // 
    // HEI.03 Defect #621 IBM NASTAA02 31.10.2017 # Purchase Order Layout Language selection
    //   # Labels are not showing the correct ML Caption depending on Language Code
    // 
    // HEI.04 Defect #818 IBM NASTAA02 15.11.2017 # Maximo Requision No visible on the Layout
    //   # Added "Machine Reference Number" on the Layout
    // 
    // HEI.05 Defect #852 IBM NASTAA02 15.11.2017 # Purchase order printing form
    //   # Calculated the Total Amount Excl. VAT as the SUM of the Net Value
    // 
    // HEI.06 RFC-CHG0246348 IBM.AB 08.10.2018
    //   # Code added to get Reason Code description
    //   # Reason Code Description added in Layout
    // 
    // HEI.07 RFC-CHG0268766 IBM ISYED01 03.27.2019
    //   # Print location address based on the shipping tab in the PO instead of from Company Information
    // 
    // HEI.08 FDD-PURGAP030 - Send updated PO to supplier with specified  changes_V1.1 , NAIKH01 , 03.28.2019
    //   #Added new code.
    //   # Also added new Column "Comments" in the Reports design and added a new table in report design.
    // 
    // HEI.09 FDD-CHG2028965 IBM SURYAS01 31/10/2019
    // #Added New table for vendor Comments in Layout
    // # Added New table for Purchase Comments in layout
    // #Changed delivery date value from Purchase header to Purchase line Expected Receipt date.
    // 
    // HEI.10 FDD-HB858 - CHG2027215 SHANKJ03 IBM 23.01.2020
    //   # Payment terms code Changed to Payment Terms Description
    //   # ContactCOntractPerson value changed based on FDD condition
    //   # Removed Delivery Date from layout
    //   # Incoterm Caption changed to Incoerm Location
    //   # Incoterm Value changed from Shipment method location to Shipment method Code
    //   # Approved By is made hidden in layout
    //   # Document date is changed to Order Date
    // HEI.11 HB2907 CHG2157356 IBM SHIVAS05 31.08.2022
    //   # Find Contact Person Email form user setup on the basis of Created By user
    // BC Upgrade BHARDA11 >>
    // 1. Add Layout Path and Change extension RDLC to rdl
    // 2. Remove Drink-IT Fields and Related code ("Last changed User ID","Vendor Tax Registration No.","Print On Purchase Order","Purchase Header"."Requester ID","Purchase Header"."Created By","Receipt Status")
    // 3. Change Language To LanguageMgt and Record to codeunit and use function GetLanguageID.
    // 4. Add ApplicationArea Property.
    // 5. Function BuildInvLineBuffer2 is obsolete in Business central , so we are using BuildInvLineBuffer.
    // 6. Function FindInteractTmplCode is obsolete in Business central , so we are using FindInteractionTemplateCode.
    // 7. Comment dotnet variable (StringHelper) this variable convert bigtext to text so we write the simple code by using textbuilder.
    // 8. Field PurchSetup."Archive Quotes and Orders" is missing replaced with "Archive Orders".
    // BC Upgrade BHARDA11 <<
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Purchase Order HeiLite.rdl'; // BC Upgrade BHARDA11 ---Add Path and change extension rdlc to rdl

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
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
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
            // column(PurchaseHeader_ContactPersonName; "Last changed User ID") // BC Upgrade BHARDA11 ----Drink-IT Field("Last changed User ID")
            column(PurchaseHeader_ContactPersonName; '')
            {
            }
            column(PurchaseHeader_ContactPersonEmail_Remove; UserRec."Contact Email")
            {
            }
            column(PurchaseHeader_ContactPersonEmail; UserSetup."E-Mail")
            {
            }
            column(ReasonCodeDescription; ReasonCodeDescription)
            {
            }
            column(ReasonCodeDescriptionLbl; ReasonCodeDescriptionLbl)
            {
            }
            column(PurchHeader_Reason_Code; "Purchase Header"."Reason Code")
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
            column(HouseNumber_PurchaseHeader; "Purchase Header"."House Number FND")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
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
                    // column(Vendor_TaxRegistrationNo; "Purchase Header"."Vendor Tax Registration No.") // BC Upgrade BHARDA11 ----Drink-IT Fields("Vendor Tax Registration No.")
                    column(Vendor_TaxRegistrationNo; '') // BC Upgrade BHARDA11 ----Drink-IT Fields("Vendor Tax Registration No.")
                    {
                    }
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
                    column(PurchaseHeader_PaymentTerms; PayTermsDesc)
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
                    column(ExpectedReceiptDate_PurchaseLine; FORMAT(DeliveryDate1))
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(HdrDimCaption; HdrDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET() THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK();

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL DimSetEntry1.NEXT() = 0;
                        end;

                        trigger OnPreDataItem();
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(CommentLine; Integer)
                    {
                        DataItemLinkReference = "Purchase Header";
                        column(PurchComment; PurchComment)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            //<<HEI.01 NAIKH01
                            IF Number = 1 THEN
                                PurchCommentLine.FINDFIRST()
                            ELSE
                                PurchCommentLine.NEXT();

                            PurchComment := PurchCommentLine.Comment;
                        end;

                        trigger OnPreDataItem();
                        begin
                            PurchCommentLine.RESET();
                            PurchCommentLine.SETRANGE("Document Type", PurchCommentLine."Document Type"::Order);
                            PurchCommentLine.SETRANGE("No.", "Purchase Header"."No.");
                            // PurchCommentLine.SETRANGE("Print On Purchase Order", TRUE); // BC Upgrade BHARDA11 ----Drnk-IT Field("Print On Purchase Order")

                            SETRANGE(Number, 1, PurchCommentLine.COUNT);
                        end;
                    }
                    dataitem(VendorCommentsLine; Integer)
                    {
                        DataItemLinkReference = "Purchase Header";
                        column(VendComment; VendComment)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            //<<HEI.01 NAIKH01
                            IF Number = 1 THEN
                                VendCommentLine.FINDFIRST()
                            ELSE
                                VendCommentLine.NEXT();

                            VendComment := VendCommentLine.Comment;
                        end;

                        trigger OnPreDataItem();
                        begin
                            VendCommentLine.RESET();
                            VendCommentLine.SETRANGE("Table Name", VendCommentLine."Table Name"::Vendor);
                            VendCommentLine.SETRANGE("No.", "Purchase Header"."Buy-from Vendor No.");
                            // VendCommentLine.SETRANGE("Print On Purchase Order", TRUE); // BC Upgrade BHARDA11 ----Drink-IT Field("Print On Purchase Order")

                            SETRANGE(Number, 1, VendCommentLine.COUNT);
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem();
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
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
                        column(POLineStatus; POLineStatus)
                        {
                        }
                        column(PurchaseLine_ExpRecDate; FORMAT("Purchase Line"."Expected Receipt Date", 10, '<Day,2>/<Month,2>/<Year4>'))
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDSET() THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL DimSetEntry2.NEXT() = 0;
                            end;

                            trigger OnPreDataItem();
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK();

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            IF Number = 1 THEN
                                PurchLine.FIND('-')
                            ELSE
                                PurchLine.NEXT();
                            "Purchase Line" := PurchLine;

                            IF NOT ItemCrossRef.GET("Purchase Line"."No.", "Purchase Line"."Variant Code", "Purchase Line"."Unit of Measure Code",
                              // ItemCrossRef."Cross-Reference Type"::Vendor, "Purchase Line"."Buy-from Vendor No.", "Purchase Line"."Vendor Item No.") THEN // BC Upgrade BHARDA11 ---Blocked - Replaced "Cross-Reference Type" with Refrence Type
                              ItemCrossRef."Reference Type"::Vendor, "Purchase Line"."Buy-from Vendor No.", "Purchase Line"."Vendor Item No.") THEN // BC Upgrade BHARDA11 ---Added - Item Cross Reference is Obsolet and we are using Item Refrence table 
                                ItemCrossRef.INIT();

                            IF NOT "Purchase Header"."Prices Including VAT" AND
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                PurchLine."Line Amount" := 0;

                            IF (PurchLine.Type = PurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Purchase Line"."No." := '';
                            AllowInvDisctxt := FORMAT("Purchase Line"."Allow Invoice Disc.");
                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line".Amount;

                            //HEI.04>>
                            IF "Purchase Line".Type = "Purchase Line".Type::Item THEN
                                IF Item.GET("Purchase Line"."No.") THEN;
                            //HEI.04<<

                            //>>HEI.08
                            POLineStatus := '';
                            IF "Purchase Header"."Changed FND" THEN BEGIN
                                PurchaseDocumentLog.RESET();
                                PurchaseDocumentLog.SETRANGE("Document Type", PurchaseDocumentLog."Document Type"::Order);
                                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Line"."Document No.");
                                PurchaseDocumentLog.SETRANGE("Line No.", "Purchase Line"."Line No.");
                                PurchaseDocumentLog.SETRANGE(Printed, FALSE);
                                PurchaseDocumentLog.SETRANGE(Comment, 'New Line Added');
                                IF PurchaseDocumentLog.FINDFIRST() THEN
                                    POLineStatus := 'New';

                                PurchaseDocumentLog.RESET();
                                PurchaseDocumentLog.SETRANGE("Document Type", PurchaseDocumentLog."Document Type"::Order);
                                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Line"."Document No.");
                                PurchaseDocumentLog.SETRANGE("Line No.", "Purchase Line"."Line No.");
                                PurchaseDocumentLog.SETRANGE(Printed, FALSE);
                                PurchaseDocumentLog.SETFILTER(Comment, '<>%1&<>%2', 'New Line Added', 'Line Deleted');
                                IF PurchaseDocumentLog.FINDFIRST() THEN
                                    POLineStatus := 'Changed';
                            END;
                            //<<HEI.08
                        end;

                        trigger OnPostDataItem();
                        begin
                            PurchLine.DELETEALL();
                        end;

                        trigger OnPreDataItem();
                        begin
                            MoreLines := PurchLine.FIND('+');
                            WHILE MoreLines AND (PurchLine.Description = '') AND (PurchLine."Description 2" = '') AND
                                  (PurchLine."No." = '') AND (PurchLine.Quantity = 0) AND
                                  (PurchLine.Amount = 0)
                            DO
                                MoreLines := PurchLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                            SETRANGE(Number, 1, PurchLine.COUNT);
                            CurrReport.CREATETOTALS(PurchLine."Line Amount", PurchLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; Integer)
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
                            IF VATAmount = 0 THEN
                                CurrReport.BREAK();
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
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
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Purchase Header"."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount() = 0)
                            THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
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
                            IF "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total3; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(SellToCustNo_PurchHeader; "Purchase Header"."Sell-to Customer No.")
                        {
                        }
                        column(SellToCustNo_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem();
                        begin
                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(PrepmtLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
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
                        dataitem(PrepmtDimLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));

                            trigger OnAfterGetRecord();
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT PrepmtDimSetEntry.FINDSET() THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 %2', PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL PrepmtDimSetEntry.NEXT() = 0;
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT PrepmtInvBuf.FIND('-') THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF PrepmtInvBuf.NEXT() = 0 THEN
                                    CurrReport.BREAK();

                            IF ShowInternalInfo THEN
                                PrepmtDimSetEntry.SETRANGE("Dimension Set ID", PrepmtInvBuf."Dimension Set ID");

                            IF "Purchase Header"."Prices Including VAT" THEN
                                PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            ELSE
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
                    dataitem(PrepmtVATCounter; Integer)
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
                    dataitem(PurchDocLog; Integer)
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
                            IF Number = 1 THEN
                                TEMPPurchaseDocumentLog.FIND('-')
                            ELSE
                                TEMPPurchaseDocumentLog.NEXT();
                            //HEI.08
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(Number, 1, TEMPPurchaseDocumentLog.COUNT);
                            //>>HEI.08
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
                    IF NOT PrepmtPurchLine.ISEMPTY THEN BEGIN
                        PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        IF NOT TempPurchLine.ISEMPTY THEN
                            PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPurchLine, PrePmtVATAmountLineDeduct, 1);
                    END;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    IF PrepmtVATAmountLine.FINDSET() THEN
                        REPEAT
                            PrePmtVATAmountLineDeduct := PrepmtVATAmountLine;
                            IF PrePmtVATAmountLineDeduct.FIND() THEN BEGIN
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
                            END;
                        UNTIL PrepmtVATAmountLine.NEXT() = 0;
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    // PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf); // BC Upgrade BHARDA11 Function(BuildInvLineBuffer2) removed in BC we are using BuildInvLineBuffer
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf); // BC Upgrade BHARDA11
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount();
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase();
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT();

                    IF Number > 1 THEN
                        CopyText := Text003;
                    CurrReport.PAGENO := 1;
                    OutputNo := OutputNo + 1;

                    TotalSubTotal := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem();
                begin
                    IF NOT CurrReport.PREVIEW THEN
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
                // CurrReport.LANGUAGE := Language.GetLanguageID("Language Code"); // BC Upgrade BHARDA11 Change Language to LanguageMgt
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageID("Language Code"); // BC Upgrade BHARDA11 

                CompanyInfo.GET();

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    //>>HEI.01
                    FormatAddr.RespCenter(ShipToCompanyAddr, RespCenter);
                    //<<HEI.01
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    //>>HEI.01
                    //  FormatAddr.FormatAddr(ShipToCompanyAddr,CompanyInfo.Name,CompanyInfo."Name 2",CompanyInfo."Ship-to Contact",CompanyInfo."Ship-to Address",
                    //    CompanyInfo."Ship-to Address 2",CompanyInfo."Ship-to City",CompanyInfo."Ship-to Post Code",CompanyInfo."Ship-to County",CompanyInfo."Ship-to Country/Region Code");
                    //HEI.07>>
                    FormatAddr.FormatAddr(ShipToCompanyAddr, CompanyInfo.Name, CompanyInfo."Name 2", "Purchase Header"."Ship-to Contact", "Purchase Header"."Ship-to Address",
                      "Purchase Header"."Ship-to Address 2", "Purchase Header"."Ship-to City", "Purchase Header"."Ship-to Post Code", "Purchase Header"."Ship-to County", "Purchase Header"."Ship-to Country/Region Code");
                    //HEI.07>>
                END;
                //<<HEI.01

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF "Purchaser Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT();
                    PurchaserText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Purchaser Code");
                    PurchaserText := Text000
                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                END;

                IF Vendor.GET("Purchase Header"."Buy-from Vendor No.") THEN;

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                IF "Buy-from Vendor No." <> "Pay-to Vendor No." THEN
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;
                IF "Prepmt. Payment Terms Code" = '' THEN
                    PrepmtPaymentTerms.INIT()
                ELSE BEGIN
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                END;

                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    END;
                END;
                PricesInclVATtxt := FORMAT("Prices Including VAT");

                IF TransportMethod.GET("Purchase Header"."Transport Method") THEN;

                //<<DITW18.00.06 BCE 11/08/2015 DIT-770 #1532
                recLocation.RESET();
                IF recLocation.GET("Purchase Header"."Location Code") THEN BEGIN
                    txtLocationPhoneNo := recLocation."Phone No.";
                    txtLocationEmail := recLocation."E-Mail";
                    txtLocationFaxNo := recLocation."Fax No.";
                END;
                //>>DITW18.00.06 BCE DIT-770 #1532

                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                IF Print THEN BEGIN
                    TempPrintedPurchHeader := "Purchase Header";
                    TempPrintedPurchHeader.INSERT();
                END;
                //>> DITW18.00.07 VSC DIT-770 #1970

                //>>HEI.02
                IF "Currency Code" = '' THEN
                    LCYCode := GLSetup."LCY Code"
                ELSE
                    LCYCode := "Currency Code";
                //<<HEI.02

                //>>HEI.06
                IF PurchaseReasonCode.GET("Purch. Reason Code FND") THEN
                    ReasonCodeDescription := PurchaseReasonCode.Description;
                //<<HEI.06


                //<<HEI.08
                IF "Purchase Header"."Changed FND" THEN BEGIN
                    PurchaseDocumentLog.RESET();
                    PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                    PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                    PurchaseDocumentLog.SETRANGE(Printed, FALSE);
                    PurchaseDocumentLog.SETRANGE(Comment, 'Line Deleted');
                    IF PurchaseDocumentLog.FINDSET() THEN
                        REPEAT
                            TEMPPurchaseDocumentLog := PurchaseDocumentLog;
                            TEMPPurchaseDocumentLog.Comment := 'Cancelled';
                            TEMPPurchaseDocumentLog.INSERT();
                        UNTIL PurchaseDocumentLog.NEXT() = 0;
                END;


                POHeaderMark := 0;
                POChanged := 0;

                IF (TEMPPurchaseDocumentLog.COUNT >= 1) THEN
                    POHeaderMark := 1;

                ShowAddr := FALSE;
                ShowAddr2 := FALSE;
                ShowCityPostCode := FALSE;
                ShowContact := FALSE;
                ShowCountryRegion := FALSE;

                PurchaseDocumentLog.RESET();
                PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                PurchaseDocumentLog.SETRANGE("Line No.", 0);
                PurchaseDocumentLog.SETRANGE(Printed, FALSE);
                IF PurchaseDocumentLog.FINDSET() THEN
                    REPEAT
                        CASE PurchaseDocumentLog."Field No." OF
                            15:
                                ShowAddr := TRUE;
                            16:
                                ShowAddr2 := TRUE;
                            17, 91:
                                ShowCityPostCode := TRUE;
                            18:
                                ShowContact := TRUE;
                            93:
                                ShowCountryRegion := TRUE;
                        END
                    UNTIL PurchaseDocumentLog.NEXT() = 0;

                PurchaseDocumentLog.RESET();
                PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                PurchaseDocumentLog.SETFILTER("Line No.", '<>%1', 0);
                PurchaseDocumentLog.SETRANGE(Printed, FALSE);
                IF PurchaseDocumentLog.FINDFIRST() THEN
                    POChanged := 1;
                //>>HEI.08

                DeliveryDate1 := 0D;
                PurchLine1.RESET();
                PurchLine1.SETRANGE("Document No.", "No.");
                PurchLine1.SETRANGE("Document Type", "Document Type");
                IF PurchLine1.FINDSET() THEN BEGIN
                    DeliveryDate1 := PurchLine1."Expected Receipt Date";
                END;
                //HEI.10>>
                CLEAR(PayTermsDesc);
                CLEAR(ContactPersonTxt);
                CLEAR(UsrName);
                CLEAR(ContractcontpersonTxt);
                CLEAR(ContrContPerUsrName);
                CLEAR(PurchaserCode);
                "Purchase Header".CALCFIELDS("House Number FND");
                //Payment terms Description
                PaymentTermsRec.RESET();
                IF PaymentTermsRec.GET("Purchase Header"."Payment Terms Code") THEN
                    PayTermsDesc := PaymentTermsRec.Description;

                // Contact Person
                IF "Purchase Header"."Maximo Requisition No. FND" <> '' THEN
                    UsrName := "Purchase Header"."PQ Approver FND"; // BC Upgrade BHARDA11 ---Add (;)
                                                                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Requester ID","Created By")
                                                                // ELSE IF "Purchase Header"."Quote No." <> '' THEN
                                                                //     UsrName := "Purchase Header"."Requester ID"
                                                                // ELSE
                                                                //     UsrName := "Purchase Header"."Created By";
                                                                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Requester ID","Created By")


                IF UsrName <> '' THEN BEGIN
                    UserRec.RESET();
                    UserRec.SETRANGE("User Name", UsrName);
                    IF UserRec.FINDFIRST() THEN
                        ContactPersonTxt := UserRec."Full Name";
                END;

                //Contract Contact Person
                IF "Purchase Header"."Channel FND" = '' THEN
                    ContrContPerUsrName := ''
                ELSE IF ("Purchase Header"."Channel FND" = 'A') OR ("Purchase Header"."Channel FND" = 'D') THEN BEGIN
                    PurchaserCode := "Purchase Header"."Purchaser Code";
                    ApprovalUserRec.RESET();
                    ApprovalUserRec.SETRANGE("Salespers./Purch. Code", PurchaserCode);
                    IF ApprovalUserRec.FINDFIRST() THEN
                        ContrContPerUsrName := ApprovalUserRec."User ID"
                END;

                IF ContrContPerUsrName <> '' THEN BEGIN
                    UserRec.RESET();
                    UserRec.SETRANGE("User Name", ContrContPerUsrName);
                    IF UserRec.FINDFIRST() THEN
                        ContractcontpersonTxt := UserRec."Full Name";
                END;


                PurchasesPayablesSetup.GET();
                PurchasesPayablesSetup.CALCFIELDS("PO Legal Text FND", "PO Legal Txt International FND");
                IF Vendor."Language Code" <> CompanyInfo."Language Code FND" THEN BEGIN
                    IF PurchasesPayablesSetup."PO Legal Txt International FND".HASVALUE THEN BEGIN
                        PurchasesPayablesSetup."PO Legal Txt International FND".
                        CREATEINSTREAM(MemoReader);
                        POTextNew.READ(MemoReader);
                        // BC Upgrade BHARAD11 >>
                        TextBuilder.Clear();
                        TextBuilder.Append(Format(POTextNew));  // Append complete text
                        POTextString := TextBuilder.ToText();  // Convert to Text variable (Here bigtext convert to text)
                        // BC Upgrade BHARDA11 <<
                    END;
                END ELSE BEGIN
                    IF PurchasesPayablesSetup."PO Legal Text FND".HASVALUE THEN BEGIN
                        PurchasesPayablesSetup."PO Legal Text FND".CREATEINSTREAM(MemoReader);
                        POTextNew.READ(MemoReader);
                        // BC Upgrade BHARAD11 >>
                        TextBuilder.Clear();
                        TextBuilder.Append(Format(POTextNew));  // Append complete text
                        POTextString := TextBuilder.ToText();  // Convert to Text variable (Here bigtext convert to text)
                        // BC Upgrade BHARDA11 <<
                    END;
                END;

                //HEI.10<<
                // IF UserSetup.GET("Purchase Header"."Created By") THEN;//HEI.11  // BC Upgrade BHARDA11 ----Drink-IT Fields("Created By")
            end;

            trigger OnPostDataItem();
            var
                PurchHeader: Record "Purchase Header";
            begin
                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                IF Print THEN BEGIN
                    IF TempPrintedPurchHeader.FINDSET() THEN
                        REPEAT
                            PurchHeader.GET(TempPrintedPurchHeader."Document Type", TempPrintedPurchHeader."No.");
                        // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Receipt Status")
                        // IF PurchHeader."Receipt Status" < SetReceiptStatus THEN BEGIN
                        //     PurchHeader.VALIDATE("Receipt Status", SetReceiptStatus);
                        //     PurchHeader.MODIFY(TRUE);
                        // END;
                        // BC Upgrade BHARDA11 << ----Drink-IT Fields("Receipt Status")
                        UNTIL TempPrintedPurchHeader.NEXT() = 0;
                END;
            end;

            trigger OnPreDataItem();
            begin
                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                Print := Print OR NOT CurrReport.PREVIEW;
                TempPrintedPurchHeader.RESET();
                TempPrintedPurchHeader.DELETEALL();
                //>>HEI.01
                // User.SETRANGE("User Name", "Last changed User ID"); // BC Upgrade BHARDA11 ----Drink-IT Field("Last changed User ID")
                IF User.FINDFIRST() THEN;
                //<<HEI.01

                //>>HEI.06
                //commented by syed ASSERTERROR this OMUser IS not used any where
                // with the below code we will get perminssion issue for user on oppco side..
                /*
                OMUser.SETRANGE(Code,"Last changed User ID");
                IF OMUser.FINDFIRST THEN;
                */
                //<<HEI.06

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
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage();
        begin
            // ArchiveDocument := PurchSetup."Archive Quotes and Orders";// BC Upgrade BHARDA11 ----"Archive Quotes and Orders" is removed and now we have 2 new fields Archive Quotes and Archive Order
            ArchiveDocument := PurchSetup."Archive Orders"; // BC Upgrade BHARDA11 ----Replaced with "Archive Orders".
            // LogInteraction := SegManagement.FindInteractTmplCode(13) <> ''; // BC Upgrade BHARDA11 ---Function FindInteractTmplCode replaced with function FindInteractionTemplateCode
            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch. Ord.") <> ''; // BC Upgrade BHARDA11 ---Function FindInteractTmplCode replaced with function FindInteractionTemplateCode and change peremeter 13 to "Purch. Ord."

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
        // Language: Record Language; // BC Upgrade BHARDA11 -- Change Record to Codeunit
        LanguageMgt: Codeunit Language; // BC Upgrade BHARDA11 -- Change Record to Codeunit
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
        // ItemCrossRef: Record "Item Cross Reference"; // BC Upgrade BHARDA11 ---Item Cross Refrence is removed now we are using  "Item Reference".
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
        LegalTextBox: Label 'Legal Text Box';
        ApprovedBy: TextConst ENU = 'Approved by:', ESP = 'Aprobado por:', FRA = 'Approuvé par:';
        Item: Record Item;
        MachineRefNo: TextConst ENU = 'Machine Reference Number', ESP = 'Machine Reference Number', FRA = 'Numéro de référence de la machine';
        ReasonCodeDescriptionLbl: TextConst ENU = 'Reason Code:', FRA = 'Code de raison';
        ReasonCodeDescription: Text[50];
        ReasonCode: Record "Reason Code";
        PurchaseReasonCode: Record "Reason Code_Purchase FND";
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
        ExpRecDtLbl: TextConst ENU = 'Expected Delivery Date', ESP = 'Fecha de estimada de entrega', FRA = 'Date de livraison prévue';
        IncotermsLocLbl: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:';
        OrderDateLbl: TextConst ENU = 'Order Date:', ESP = 'Fecha de Orden', FRA = 'Date de commande';
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
        // StringHelper: DotNet "'mscorlib'.System.String"; // BC Upgrade BHARDA11 ----DotNet variables are NOT supported in Business Central Cloud/SaaS environment
        TextBuilder: TextBuilder;  // BC Upgrade BHARDA11 ----For handling large text without truncation
        POTextString: Text;  // BC Upgrade BHARDA11 
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        POTextNew: BigText;
        UserSetup: Record "User Setup";

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;
}

