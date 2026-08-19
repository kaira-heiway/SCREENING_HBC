report 52043 "Purchase Order LR"
{
    // version HEI.13

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
    // HEI.08 FDD-HT632 BULIMC01 IBM 19.09.2019 #new report created for La Reunion based on report 50032
    // HEI.09  DEFECT 4948 SAXENS01 IBM 18.12.2019
    //   Code modification done on Purchase Header Data Item OnAfterGetRecord
    // HEI.10 HLP-498 CHG2026326 IBM SAXENS01 24.01.2020
    //   code commented and added code for "PO Legal Text Box E-Mail"
    //   changes in section for removing company address and additional changes
    //    removed from propertirs of client :;ESP=COMPAÑÍA QUE ORDENA:;FRA=DONNEUR D'ORDRE:
    // 
    // HEI.11 FDD-HB858 - CHG2027215 SHANKJ03 IBM 23.01.2020
    //   # ContactCOntractPerson value changed based on FDD condition
    //   # Removed Delivery Date from layout
    //   # Incoterm Caption changed to Incoerm Location
    //   # Approved By is made hidden in layout
    //   # Document date is changed to Order Date
    // 
    // HEI.12 HB1738 CHG2082506 IBM NANDIS01 08.10.2020
    //   # PO Layout - La Reunion - Property of field "LineAmt2_PurchLine2" in design made to default from Number format
    //   # Adjust width of field – “Unite de mesure”, “Prix Net” and “Valeur Nette” adjusted.
    // HEI.13 HB2907 CHG2157356 IBM SHIVAS05 31.08.2022
    //   # Find Contact Person Email form user setup on the basis of Created By user
    // HEI.14 CHG2350626 IBM PATELS08 02.06.2026 Delivery Date correction for Purchase Orders
    //   # Added a field "Requested Delivery Date" to the Dataset.
    //   # Replaced "Expected Delivery Date" by "Requested Delivery Date" in Layout.

    // BC Upgrade BHARDA11 >>
    // 1. OLD Report ID - 50325.
    // 2. Add layout path and change layout extension RDLC to rdl.
    // 3. Function FindInteractTmplCode is obsolete in Business central , so we are using FindInteractionTemplateCode.
    // 4. Function BuildInvLineBuffer2 is obsolete in Business central , so we are using BuildInvLineBuffer.
    // BC Upgrade BHARDA11 <<

    // BC UPGRADE PATELS08 >>
    // # HEI.14 Tag Added to Documentation.
    // # Added a new field "Requested Delivery Date" to the dataset.
    // # Replaced the exisiting rdl file with new one which has the "Requested Delivery Date" field in layout and removed the "Expected Receipt Date" field from layout.
    // BC UPGRADE PATELS08 <<

    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\src\Reportslayout\Purchase Order LR.rdl';

    CaptionML = ENU = 'Purchase Order LR',
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
            column(CRLbl; CRTxtLbl)
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
            column(PurchaseHeader_ContactPersonName; ContactPerson1)
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; "Purchase Header"."Expected Receipt Date")
            {
            }

            // BC Upgrade PATELS08 >>
            column(RequestedReceiptDate_PurchaseHeader; "Purchase Header"."Requested Receipt Date")
            {
                Description = 'HEI.14';
            }
            // BC Upgrade PATELS08 <<
            column(ForwardersNameLbl; ForwardersNameLbl)
            {
            }
            column(DeliveryDateLbl1; DeliveryDateLbl)
            {
            }
            column(ForwardingAgentLbl; ForwardingAgentLbl)
            {
            }
            column(AddressLbl; AddressLbl)
            {
            }
            column(TelLbl; TelLbl)
            {
            }
            column(ContactShipAgentLbl; ContactShipAgentLbl)
            {
            }
            column(FaxLbl; FaxLbl)
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
            column(Comments; Var_Comments)
            {
            }
            column(CommentsLine; Var_Comments_Line)
            {
            }
            column(DisplayLbl; DisplayLbl)
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
            column(testremark; FORMAT(POTextNew))
            {
            }
            column(PurchaseHeader_ContractcontpersonTxt; ContractcontpersonTxt)
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
                    column(Email; Email)
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
                    column(Vendor_HouseNo; Vendor."House Number FND")
                    {
                    }
                    // column(Vendor_TaxRegistrationNo; "Purchase Header"."Vendor Tax Registration No.") // BC Upgrade BHARDA11 ----_Drink-IT Field("Vendor Tax Registration No.")
                    column(Vendor_TaxRegistrationNo; '')
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
                    column(PurchaseHeader_DocumentDate; FORMAT("Purchase Header"."Order Date", 0, 4))
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
                    column(PurchaseHeader_IncoTermsLocation; "Purchase Header"."Shipment Method Code")
                    {
                    }
                    column(IncotermsLocationLbl; IncotermsLocationLbl)
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
                    column(ShipAgentName_ShippingAgent; ShippingAgent.Name)
                    {
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields(Address,"Post Code",City,"Phone No.","Fax No.",Contact)
                    // column(ShipAgentAddress_ShippingAgent; ShippingAgent.Address)
                    // {
                    // }
                    // column(ShipAgentPostCode_ShippingAgent; ShippingAgent."Post Code")
                    // {
                    // }
                    // column(ShipAgentCity_ShippingAgent; ShippingAgent.City)
                    // {
                    // }
                    // column(ShipAgentPhoneNo_ShippingAgent; ShippingAgent."Phone No.")
                    // {
                    // }
                    // column(ShipAgentFax_ShippingAgent; ShippingAgent."Fax No.")
                    // {
                    // }
                    // column(ShipAgentContact_ShippingAgent; ShippingAgent.Contact)
                    // {
                    // }
                    column(ShipAgentAddress_ShippingAgent; '')
                    {
                    }
                    column(ShipAgentPostCode_ShippingAgent; '')
                    {
                    }
                    column(ShipAgentCity_ShippingAgent; '')
                    {
                    }
                    column(ShipAgentPhoneNo_ShippingAgent; '')
                    {
                    }
                    column(ShipAgentFax_ShippingAgent; '')
                    {
                    }
                    column(ShipAgentContact_ShippingAgent; '')
                    {
                    }
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields(Address,"Post Code",City,"Phone No.","Fax No.",Contact)

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
                                if not DimSetEntry1.FINDSET then
                                    CurrReport.BREAK;
                            end else
                                if not Continue then
                                    CurrReport.BREAK;

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
                            until DimSetEntry1.NEXT = 0;
                        end;

                        trigger OnPreDataItem();
                        begin
                            if not ShowInternalInfo then
                                CurrReport.BREAK;
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
                            //HEI.08>>
                            if Number = 1 then
                                PurchCommentLine.FINDFIRST
                            else
                                PurchCommentLine.NEXT;

                            PurchComment := PurchCommentLine.Comment;
                            //HEI.08<<
                        end;

                        trigger OnPreDataItem();
                        begin
                            //HEI.08>>
                            PurchCommentLine.RESET;
                            PurchCommentLine.SETRANGE("Document Type", PurchCommentLine."Document Type"::Order);
                            PurchCommentLine.SETRANGE("No.", "Purchase Header"."No.");
                            // PurchCommentLine.SETRANGE("Print On Purchase Order", true); // BC Upgrade BHARDA11 ----Drink-IT Field("Print On Purchase Order")

                            SETRANGE(Number, 1, PurchCommentLine.COUNT);
                            //HEI.08>>
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
                            //HEI.08>>
                            if Number = 1 then
                                VendCommentLine.FINDFIRST
                            else
                                VendCommentLine.NEXT;

                            VendComment := VendCommentLine.Comment;
                            //HEI.08>>
                        end;

                        trigger OnPreDataItem();
                        begin
                            //HEI.08>>
                            VendCommentLine.RESET;
                            VendCommentLine.SETRANGE("Table Name", VendCommentLine."Table Name"::Vendor);
                            VendCommentLine.SETRANGE("No.", "Purchase Header"."Buy-from Vendor No.");
                            // VendCommentLine.SETRANGE("Print On Purchase Order", true); // BC Upgrade BHARDA11 ----Drink-IT Field("Print On Purchase Order")

                            SETRANGE(Number, 1, VendCommentLine.COUNT);
                            //HEI.08>>
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem();
                        begin
                            CurrReport.BREAK;
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
                        column(LineAmt2_PurchLine; ROUND("Purchase Line"."Line Amount", 0.01, '='))
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(MachineRefNoCaption; MachineRefNo)
                        {
                        }
                        column(ExpectedReceiptDateLbl; ExpectedReceiptDateLbl)
                        {
                        }
                        column(ExpectedReceiptDate_PurchLine; FORMAT(PurchLine."Expected Receipt Date", 10, '<Day,2>/<Month,2>/<Year4>'))
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
                                    if not DimSetEntry2.FINDSET then
                                        CurrReport.BREAK;
                                end else
                                    if not Continue then
                                        CurrReport.BREAK;

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
                                until DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPreDataItem();
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                PurchLine.FIND('-')
                            else
                                PurchLine.NEXT;
                            "Purchase Line" := PurchLine;

                            if not ItemCrossRef.GET("Purchase Line"."No.", "Purchase Line"."Variant Code", "Purchase Line"."Unit of Measure Code",
                              // ItemCrossRef."Cross-Reference Type"::Vendor, "Purchase Line"."Buy-from Vendor No.", "Purchase Line"."Vendor Item No.") then // BC Upgrade BHARDA11 ----in the place of "Cross-Reference Type" we are using "Reference Type"
                              ItemCrossRef."Reference Type"::Vendor, "Purchase Line"."Buy-from Vendor No.", "Purchase Line"."Vendor Item No.") then
                                ItemCrossRef.INIT;

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

                            //>>HEI.07
                            POLineStatus := '';
                            if "Purchase Header"."Changed FND" then begin
                                PurchaseDocumentLog.RESET;
                                PurchaseDocumentLog.SETRANGE("Document Type", PurchaseDocumentLog."Document Type"::Order);
                                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Line"."Document No.");
                                PurchaseDocumentLog.SETRANGE("Line No.", "Purchase Line"."Line No.");
                                PurchaseDocumentLog.SETRANGE(Printed, false);
                                PurchaseDocumentLog.SETRANGE(Comment, 'New Line Added');
                                if PurchaseDocumentLog.FINDFIRST then
                                    POLineStatus := 'New';

                                PurchaseDocumentLog.RESET;
                                PurchaseDocumentLog.SETRANGE("Document Type", PurchaseDocumentLog."Document Type"::Order);
                                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Line"."Document No.");
                                PurchaseDocumentLog.SETRANGE("Line No.", "Purchase Line"."Line No.");
                                PurchaseDocumentLog.SETRANGE(Printed, false);
                                PurchaseDocumentLog.SETFILTER(Comment, '<>%1&<>%2', 'New Line Added', 'Line Deleted');
                                if PurchaseDocumentLog.FINDFIRST then
                                    POLineStatus := 'Changed';
                            end;
                            //<<HEI.07
                        end;

                        trigger OnPostDataItem();
                        begin
                            PurchLine.DELETEALL;
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
                                CurrReport.BREAK;
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
                                CurrReport.BREAK;
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
                                CurrReport.BREAK;

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
                                CurrReport.BREAK;
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
                                CurrReport.BREAK;
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
                        column(PrepmtVATAmountText; PrepmtVATAmountLine.VATAmountText)
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
                                    if not PrepmtDimSetEntry.FINDSET then
                                        CurrReport.BREAK;
                                end else
                                    if not Continue then
                                        CurrReport.BREAK;

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
                                    CurrReport.BREAK;
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
                        column(PurchDocLog_No; TEMPPurchaseDocumentLog."Entry No.")
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
                                TEMPPurchaseDocumentLog.NEXT;
                            //HEI.07
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(Number, 1, TEMPPurchaseDocumentLog.COUNT);
                            //>>HEI.07
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
                    PurchLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    PrepmtInvBuf.DELETEALL;
                    PurchPostPrepmt.GetPurchLines("Purchase Header", 0, PrepmtPurchLine);
                    if not PrepmtPurchLine.ISEMPTY then begin
                        PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        if not TempPurchLine.ISEMPTY then
                            PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPurchLine, PrePmtVATAmountLineDeduct, 1);
                    end;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    if PrepmtVATAmountLine.FINDSET then
                        repeat
                            PrePmtVATAmountLineDeduct := PrepmtVATAmountLine;
                            if PrePmtVATAmountLineDeduct.FIND then begin
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
                                PrepmtVATAmountLine.MODIFY;
                            end;
                        until PrepmtVATAmountLine.NEXT = 0;
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    // PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf); // BC Upgrade BHARDA11 Function(BuildInvLineBuffer2) removed in BC we are using BuildInvLineBuffer
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf); // BC Upgrade BHARDA11
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
                    if not CurrReport.PREVIEW then
                        PurchCountPrinted.RUN("Purchase Header");

                    CLEAR(ShippingAgent); //HEI.08
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
                //HEI.08<<
                if Vendor.GET("Purchase Header"."Buy-from Vendor No.") then;
                // CurrReport.LANGUAGE := Language.GetLanguageID(Vendor."Language Code");
                CurrReport.LANGUAGE := LanguageMgt.GetLanguageID(Vendor."Language Code");


                if "Purchase Header"."PQ Approver FND" <> '' then
                    ContactPerson1 := "Purchase Header"."PQ Approver FND";
                // BC Upgrad BHARDA11 >> ----Drink-IT Fields("Requester ID","Created By")
                // else if "Purchase Header"."Requester ID" <> '' then
                //     ContactPerson1 := "Purchase Header"."Requester ID"
                // else
                //     ContactPerson1 := "Purchase Header"."Created By";
                // BC Upgrad BHARDA11 << ----Drink-IT Fields("Requester ID","Created By")

                /*
                IF ("Purchase Header".Channel <> 'A') AND ("Purchase Header".Channel <> 'D') THEN
                  ContactContactNo := ''
                ELSE */

                // if ShippingAgent.GET("Shipping Agent Code") then; // BC Upgrade BHARDA11 ----Drink-IT Field("Shipping Agent Code")
                //HEI.08>>

                CompanyInfo.GET;
                Email := CompanyInfo."PO Legal Text Box E-Mail FND";

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
                    //  FormatAddr.FormatAddr(ShipToCompanyAddr,CompanyInfo.Name,CompanyInfo."Name 2",CompanyInfo."Ship-to Contact",CompanyInfo."Ship-to Address",
                    //    CompanyInfo."Ship-to Address 2",CompanyInfo."Ship-to City",CompanyInfo."Ship-to Post Code",CompanyInfo."Ship-to County",CompanyInfo."Ship-to Country/Region Code");
                    //HEI.07>>
                    FormatAddr.FormatAddr(ShipToCompanyAddr, CompanyInfo.Name, CompanyInfo."Name 2", "Purchase Header"."Ship-to Contact", "Purchase Header"."Ship-to Address",
                      "Purchase Header"."Ship-to Address 2", "Purchase Header"."Ship-to City", "Purchase Header"."Ship-to Post Code", "Purchase Header"."Ship-to County", "Purchase Header"."Ship-to Country/Region Code");
                    //HEI.07>>
                end;
                //<<HEI.01
                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if "Purchaser Code" = '' then begin
                    SalesPurchPerson.INIT;
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
                    PaymentTerms.INIT
                else begin
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;
                if "Prepmt. Payment Terms Code" = '' then
                    PrepmtPaymentTerms.INIT
                else begin
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                end;
                if "Shipment Method Code" = '' then
                    ShipmentMethod.INIT
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
                recLocation.RESET;
                if recLocation.GET("Purchase Header"."Location Code") then begin
                    txtLocationPhoneNo := recLocation."Phone No.";
                    txtLocationEmail := recLocation."E-Mail";
                    txtLocationFaxNo := recLocation."Fax No.";
                end;
                //>>DITW18.00.06 BCE DIT-770 #1532

                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                if Print then begin
                    TempPrintedPurchHeader := "Purchase Header";
                    TempPrintedPurchHeader.INSERT;
                end;
                //>> DITW18.00.07 VSC DIT-770 #1970

                //>>HEI.02
                if "Currency Code" = '' then
                    LCYCode := GLSetup."LCY Code"
                else
                    LCYCode := "Currency Code";
                //<<HEI.02

                //>>HEI.06
                if PurchaseReasonCode.GET("Purch. Reason Code FND") then
                    ReasonCodeDescription := PurchaseReasonCode.Description;
                //<<HEI.06


                //<<HEI.07
                if "Purchase Header"."Changed FND" then begin
                    PurchaseDocumentLog.RESET;
                    PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                    PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                    PurchaseDocumentLog.SETRANGE(Printed, false);
                    PurchaseDocumentLog.SETRANGE(Comment, 'Line Deleted');
                    if PurchaseDocumentLog.FINDSET then
                        repeat
                            TEMPPurchaseDocumentLog := PurchaseDocumentLog;
                            TEMPPurchaseDocumentLog.Comment := 'Cancelled';
                            TEMPPurchaseDocumentLog.INSERT;
                        until PurchaseDocumentLog.NEXT = 0;
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

                PurchaseDocumentLog.RESET;
                PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                PurchaseDocumentLog.SETRANGE("Line No.", 0);
                PurchaseDocumentLog.SETRANGE(Printed, false);
                if PurchaseDocumentLog.FINDSET then
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
                    until PurchaseDocumentLog.NEXT = 0;

                PurchaseDocumentLog.RESET;
                PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                PurchaseDocumentLog.SETFILTER("Line No.", '<>%1', 0);
                PurchaseDocumentLog.SETRANGE(Printed, false);
                if PurchaseDocumentLog.FINDFIRST then
                    POChanged := 1;
                //>>HEI.07
                //HEI.09
                /*
                StandardTextReport.RESET;
                StandardTextReport.SETRANGE("Report ID",50325);
                StandardTextReport.SETRANGE("Position Text",StandardTextReport."Position Text"::Footer);
                IF StandardTextReport.FINDSET THEN BEGIN
                  ExtendedTextHeader.RESET;
                  ExtendedTextHeader.SETRANGE("No.",StandardTextReport."Standard Text Code");
                  ExtendedTextHeader.SETRANGE("Table Name",ExtendedTextHeader."Table Name"::"Standard Text");
                  ExtendedTextHeader.SETRANGE("Language Code","Purchase Header"."Language Code");
                  IF ExtendedTextHeader.FINDSET THEN BEGIN
                  REPEAT
                    Var_Comments := '';
                    //Table Name=FIELD(Table Name),No.=FIELD(No.),Language Code=FIELD(Language Code),Text No.=FIELD(Text No.)
                    ExtendedTextLine.RESET;
                    ExtendedTextLine.SETRANGE("No.",ExtendedTextHeader."No.");
                    ExtendedTextLine.SETRANGE("Table Name",ExtendedTextLine."Table Name"::"Standard Text");
                    ExtendedTextLine.SETRANGE("Language Code","Purchase Header"."Language Code");
                    ExtendedTextLine.SETRANGE("Text No.",ExtendedTextHeader."Text No.");
                    IF ExtendedTextLine.FINDSET THEN REPEAT
                      Var_Comments += ExtendedTextLine.Text+' ';
                    UNTIL ExtendedTextLine.NEXT = 0;
                  UNTIL ExtendedTextHeader.NEXT = 0;
                  END ELSE BEGIN
                    ExtendedTextHeader.RESET;
                    ExtendedTextHeader.SETRANGE("No.",StandardTextReport."Standard Text Code");
                    ExtendedTextHeader.SETRANGE("Table Name",ExtendedTextHeader."Table Name"::"Standard Text");
                    ExtendedTextHeader.SETRANGE("All Language Codes",TRUE);
                    ExtendedTextLine.SETRANGE("Text No.",ExtendedTextHeader."Text No.");
                    IF ExtendedTextHeader.FINDSET THEN BEGIN
                    REPEAT
                      Var_Comments := '';
                
                      ExtendedTextLine.RESET;
                      ExtendedTextLine.SETRANGE("No.",ExtendedTextHeader."No.");
                      ExtendedTextLine.SETRANGE("Table Name",ExtendedTextLine."Table Name"::"Standard Text");
                      ExtendedTextHeader.SETRANGE("All Language Codes",TRUE);
                      IF ExtendedTextLine.FINDSET THEN REPEAT
                        Var_Comments += ExtendedTextLine.Text+' ';
                      UNTIL ExtendedTextLine.NEXT = 0;
                     UNTIL ExtendedTextHeader.NEXT = 0;
                    END
                   ELSE BEGIN
                      ExtendedTextHeader.RESET;
                      ExtendedTextHeader.SETRANGE("No.",StandardTextReport."Standard Text Code");
                      ExtendedTextHeader.SETRANGE("Table Name",ExtendedTextHeader."Table Name"::"Standard Text");
                      IF ExtendedTextHeader.FINDSET THEN BEGIN
                      REPEAT
                        Var_Comments := '';
                        ExtendedTextLine.RESET;
                        ExtendedTextLine.SETRANGE("No.",ExtendedTextHeader."No.");
                        ExtendedTextLine.SETRANGE("Table Name",ExtendedTextLine."Table Name"::"Standard Text");
                        IF ExtendedTextLine.FINDSET THEN REPEAT
                          Var_Comments += ExtendedTextLine.Text+' ';
                        UNTIL ExtendedTextLine.NEXT = 0;
                      UNTIL ExtendedTextHeader.NEXT = 0;
                      END
                    END;
                  END;
                END;
                
                StandardTextReport.RESET;
                StandardTextReport.SETRANGE("Report ID",50325);
                StandardTextReport.SETRANGE("Position Text",StandardTextReport."Position Text"::Line);
                IF StandardTextReport.FINDSET THEN BEGIN
                  ExtendedTextHeader.RESET;
                  ExtendedTextHeader.SETRANGE("No.",StandardTextReport."Standard Text Code");
                  ExtendedTextHeader.SETRANGE("Table Name",ExtendedTextHeader."Table Name"::"Standard Text");
                  ExtendedTextHeader.SETRANGE("Language Code","Purchase Header"."Language Code");
                  ExtendedTextLine.SETRANGE("Text No.",ExtendedTextHeader."Text No.");
                  IF ExtendedTextHeader.FINDFIRST THEN BEGIN
                   REPEAT
                    Var_Comments_Line := '';
                    ExtendedTextLine.RESET;
                    ExtendedTextLine.SETRANGE("No.",ExtendedTextHeader."No.");
                    ExtendedTextLine.SETRANGE("Table Name",ExtendedTextLine."Table Name"::"Standard Text");
                    ExtendedTextLine.SETRANGE("Language Code","Purchase Header"."Language Code");
                    IF ExtendedTextLine.FINDSET THEN REPEAT
                      Var_Comments_Line += ExtendedTextLine.Text+' ';
                    UNTIL ExtendedTextLine.NEXT = 0;
                  UNTIL ExtendedTextHeader.NEXT = 0;
                  END ELSE BEGIN
                  ExtendedTextHeader.RESET;
                  ExtendedTextHeader.SETRANGE("No.",StandardTextReport."Standard Text Code");
                  ExtendedTextHeader.SETRANGE("Table Name",ExtendedTextHeader."Table Name"::"Standard Text");
                  ExtendedTextHeader.SETRANGE("All Language Codes",TRUE);
                  IF ExtendedTextHeader.FINDFIRST THEN BEGIN
                   REPEAT
                    Var_Comments_Line := '';
                    ExtendedTextLine.RESET;
                    ExtendedTextLine.SETRANGE("No.",ExtendedTextHeader."No.");
                    ExtendedTextLine.SETRANGE("Table Name",ExtendedTextLine."Table Name"::"Standard Text");
                    ExtendedTextLine.SETRANGE("Text No.",ExtendedTextHeader."Text No.");
                    ExtendedTextLine.SETRANGE("Language Code",'');
                    IF ExtendedTextLine.FINDSET THEN REPEAT
                      Var_Comments_Line += ExtendedTextLine.Text+' ';
                    UNTIL ExtendedTextLine.NEXT = 0;
                  UNTIL ExtendedTextHeader.NEXT = 0;
                  END ELSE BEGIN
                    ExtendedTextHeader.RESET;
                    ExtendedTextHeader.SETRANGE("No.",StandardTextReport."Standard Text Code");
                    ExtendedTextHeader.SETRANGE("Table Name",ExtendedTextHeader."Table Name"::"Standard Text");
                    IF ExtendedTextHeader.FINDFIRST THEN BEGIN
                     REPEAT
                      Var_Comments_Line := '';
                      ExtendedTextLine.RESET;
                      ExtendedTextLine.SETRANGE("No.",ExtendedTextHeader."No.");
                      ExtendedTextLine.SETRANGE("Table Name",ExtendedTextLine."Table Name"::"Standard Text");
                      IF ExtendedTextLine.FINDSET THEN REPEAT
                        Var_Comments_Line += ExtendedTextLine.Text+' ';
                      UNTIL ExtendedTextLine.NEXT = 0;
                    UNTIL ExtendedTextHeader.NEXT = 0;
                  END;
                  END;
                  END;
                END;
                */
                //HEI.09


                //HEI.11>>
                CLEAR(ContactPersonTxt);
                CLEAR(UsrName);
                CLEAR(ContractcontpersonTxt);
                CLEAR(ContrContPerUsrName);
                CLEAR(PurchaserCode);


                // Contact Person
                if "Purchase Header"."Maximo Requisition No. FND" <> '' then
                    UsrName := "Purchase Header"."PQ Approver FND";
                // BC Upgrad BHARDA11 >> ----Drink-IT Fields("Requester ID","Created By")

                // else if "Purchase Header"."Quote No." <> '' then
                //     UsrName := "Purchase Header"."Requester ID"
                // else
                //     UsrName := "Purchase Header"."Created By";
                // BC Upgrad BHARDA11 << ----Drink-IT Fields("Requester ID","Created By")


                if UsrName <> '' then begin
                    UserRec.RESET;
                    UserRec.SETRANGE("User Name", UsrName);
                    if UserRec.FINDFIRST then
                        ContactPersonTxt := UserRec."Full Name";
                end;

                //Contract Contact Person
                if "Purchase Header"."Channel FND" = '' then
                    ContrContPerUsrName := ''
                else if ("Purchase Header"."Channel FND" = 'A') or ("Purchase Header"."Channel FND" = 'D') then begin
                    PurchaserCode := "Purchase Header"."Purchaser Code";
                    ApprovalUserRec.RESET;
                    ApprovalUserRec.SETRANGE("Salespers./Purch. Code", PurchaserCode);
                    if ApprovalUserRec.FINDFIRST then
                        ContrContPerUsrName := ApprovalUserRec."User ID"
                end;
                if CompanyInfo1."Registration No." <> '' then
                    CRTxtLbl := 'CR: ' + CompanyInfo1."Registration No." + ' ;';

                if ContrContPerUsrName <> '' then begin
                    UserRec.RESET;
                    UserRec.SETRANGE("User Name", ContrContPerUsrName);
                    if UserRec.FINDFIRST then
                        ContractcontpersonTxt := UserRec."Full Name";
                end;


                PurchasesPayablesSetup.GET;
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

                //HEI.11<<
                // if UserSetup.GET("Purchase Header"."Created By") then;//HEI.13 // BC Upgrade BHARDA11 ----Drink-IT Field("Created By")

            end;

            trigger OnPostDataItem();
            var
                PurchHeader: Record "Purchase Header";
            begin
                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // if Print then begin
                //     if TempPrintedPurchHeader.FINDSET then
                //         repeat
                //             PurchHeader.GET(TempPrintedPurchHeader."Document Type", TempPrintedPurchHeader."No.");
                //             if PurchHeader."Receipt Status" < SetReceiptStatus then begin
                //                 PurchHeader.VALIDATE("Receipt Status", SetReceiptStatus);
                //                 PurchHeader.MODIFY(true);
                //             end;
                //         until TempPrintedPurchHeader.NEXT = 0;
                // end;
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
            end;

            trigger OnPreDataItem();
            begin
                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                Print := Print or not CurrReport.PREVIEW;
                TempPrintedPurchHeader.RESET;
                TempPrintedPurchHeader.DELETEALL;
                //>>HEI.01
                // User.SETRANGE("User Name", "Last changed User ID"); // BC Upgrade BHARDA11 ----Drink-IT Field("Last changed User ID")
                if User.FINDFIRST then;
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
                    }
                    field(SetReceiptStatus; SetReceiptStatus)
                    {
                        ApplicationArea = All;
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
            // ArchiveDocument := PurchSetup."Archive Quotes and Orders"; // BC Upgrade BHARAD11 ::Blocked
            ArchiveDocument := PurchSetup."Archive Orders"; // BC Upgrade BHARAD11 ::Added
            // LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';// BC Upgrade BHARDA11 ---Function FindInteractTmplCode replaced with function FindInteractionTemplateCode
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
        GLSetup.GET;
        PurchSetup.GET;

        CompanyInfo1.GET;
        CompanyInfo1.CALCFIELDS(Picture);
        CLEAR(CRTxtLbl);
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
        // Language: Record Language; // BC Upgrade BHARDA11 ::Blocked
        LanguageMgt: Codeunit Language; // BC Upgrade BHARDA11 ::Added

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
        // ItemCrossRef: Record "Item Cross Reference";
        ItemCrossRef: Record "Item Reference"; // BC Upgrade BHARDA11 --"Item Cross Reference" is obsolete so we are using"Item Reference"

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
        OrderingParty: Label 'Client:';
        TaxIdentification: TextConst ENU = 'Tax Identification:', ESP = 'Número de Identificación de Impuestos:', FRA = 'Numero Identifiant Fiscal:';
        ContactPerson: TextConst ENU = 'Contact person:', ESP = 'Persona de Contacto:', FRA = 'Personne à contacter:';
        Phone: TextConst ENU = 'Phone:', ESP = 'Teléfono:', FRA = 'Téléphone:';
        VendorCaption: TextConst ENU = 'Supplier:', ESP = 'PROVEEDOR:', FRA = 'FOURNISSEUR:';
        TaxIdentificationNumber: TextConst ENU = 'Tax Identification Number:', ESP = 'Número de Identificación de Impuestos:', FRA = 'Numero Identifiant Fiscal:';
        EUVATNumber: TextConst ENU = 'EU VAT Number:', ESP = 'EU VAT Number:', FRA = 'EU VAT Number:';
        YourVendorNoWithUs: TextConst ENU = 'Your Vendor Number with us:', ESP = 'Su número de proveedor con nosotros:', FRA = 'Votre numéro de fournisseur avec nous:';
        PleaseDeliverGoodsTo: TextConst ENU = 'PLEASE DELIVER GOODS TO:', ESP = 'FAVOR ENTREGAR MERCANCÍA A:', FRA = 'ADRESSE DE LIVRAISON:';
        PlantOpeningHrs: TextConst ENU = 'Plant opening hrs:', ESP = 'Horario:', FRA = 'Horaires d''ouverture du site:';
        PleaseDeliverInvoiceTo: TextConst ENU = 'PLEASE DELIVER INVOICE TO:', ESP = 'FAVOR ENTREGAR FACTURA A:', FRA = 'MERCI D''ENVOYER LA FACTURE À:';
        DeliveryTerms: TextConst ENU = 'Delivery Terms:', ESP = 'Términos de entrega:', FRA = 'Conditions de Livraison:';
        DocumentDate: TextConst ENU = 'Document Date:', ESP = 'Fecha del documento:', FRA = 'Date de document:';
        DeliveryDate: TextConst ENU = 'Delivery Date:', ESP = 'Fecha de Entrega:', FRA = 'Date de Livraison:';
        PaymentTermsCaption: TextConst ENU = 'Payment Terms:', ESP = 'Términos de Pago:', FRA = 'Conditions de Paiements:';
        Incoterms: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:';
        IncotermsLocationLbl: Label 'Incoterm:';
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
        MachineRefNo: TextConst ENU = 'Machine Reference Number', ESP = 'Machine Reference Number', FRA = 'Machine Reference Number';
        ReasonCodeDescriptionLbl: Label 'Reason Code:';
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
        ForwardersNameLbl: TextConst ENU = 'Forwarder''s name & Delivery address', FRA = 'Nom du transitaire et adresse de livraison';
        DeliveryDateLbl: TextConst ENU = 'Delivery Date:', FRA = 'Date de livraison:';
        ForwardingAgentLbl: TextConst ENU = 'Forwarding Agent:', FRA = 'Transitaire:';
        AddressLbl: TextConst ENU = 'Address:', FRA = 'Adresse:';
        TelLbl: TextConst ENU = 'Tel:', FRA = 'Téléphone:';
        FaxLbl: TextConst ENU = 'Fax:', FRA = 'Fax:';
        ContactShipAgentLbl: TextConst ENU = 'Contact Shipping Agent:', FRA = 'Contact du Transitaire:';
        ShippingAgent: Record "Shipping Agent";
        ExpectedReceiptDateLbl: TextConst ENU = 'Expected Delivery Date', FRA = 'Date de livraison prévue';
        ContactPerson1: Text;
        ContactContactNo: Text;
        PurchCommentLine: Record "Purch. Comment Line";
        PurchComment: Text[250];
        i: Integer;
        VendCommentLine: Record "Comment Line";
        VendComment: Text[250];
        // StandardTextReport: Record "Standard Text Report";
        ExtendedTextHeader: Record "Extended Text Header";
        Var_Comments: Text;
        ExtendedTextLine: Record "Extended Text Line";
        Var_Comments_Line: Text;
        DisplayLbl: TextConst ENU = 'To: Vendor accounting dep.', FRA = 'To: Comptabilité Fournisseurs';
        Email: Text[50];
        ContactPersonTxt: Text;
        UsrName: Code[50];
        UserRec: Record User;
        ContractcontpersonTxt: Text;
        ContrContPerUsrName: Code[50];
        PurchaserCode: Code[10];
        ApprovalUserRec: Record "User Setup";
        MemoReader: InStream;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        POTextNew: BigText;
        ExpRecDtLbl: TextConst ENU = 'Expected Receipt Date', FRA = 'Date de livraison prévue';
        IncotermsLocLbl: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:';
        OrderDateLbl: TextConst ENU = 'Order Date:', FRA = 'Date de commande';
        CRTxtLbl: Text;
        UserSetup: Record "User Setup";

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;
}

