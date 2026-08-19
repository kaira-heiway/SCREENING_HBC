report 52031 "Purchase Order Haiti"
{
    // version HEI.05

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
    // *****************************************************************************************************
    // HEI.11 HT1321 - CHG2096767 IBM NANDIS01 13.03.2021 PO Layout Haiti for BASE Heilite Haiti
    //   # New report creatd copied from 50032
    //   # Removed almost all the report header and placed everything in report body.
    //   # complete change in report layout
    // 
    // HEI.12 Defect 6317 - CHG2112474 IBM NANDIS01 31.05.2021  PO in HL to exclude the column Machine Reference Number
    //   # Machine Reference Number from line level removed in design
    // 
    // HEI.13 Defect 6357 - CHG2115758 IBM NANDIS01 24.06.2021 Haiti fix for defect 6357:Column machine reference number to be added
    //   # Machine Reference Number Added
    //*****************************************//
    //BC UPGRADE ATHUKS01//
    //1. Old Report ID is 50474.
    // 2. Add Layout path and change layout extension RDLC to rdl.
    // 3. Remove Drink-IT Fields ("Print On Purchase Order","Requester ID","Created By","Receipt Status")
    // 4. Change Language to LanguageMgt and record to codeunit.
    // 5. Function BuildInvLineBuffer2 is obsolete in Business central , so we are using BuildInvLineBuffer.
    // 6. Function FindInteractTmplCode is obsolete in Business central , so we are using FindInteractionTemplateCode.and change peremeter 13 to "Purch. Ord."
    // 7. "Item Cross Reference" is absolete, so we are using "Item Refrence" in the Place of  "Item Cross Reference". And and in the place of "Cross-Reference Type" we are using ("Reference Type")
    // 8. Comment dotnet variable (StringHelper) this variable convert bigtext to text so we write the simple code by using Text & Method ReadInstream.
    // 9. Field PurchSetup."Archive Quotes and Orders" is missing replaced with "Archive Orders".
    // 10. The “Vendor Tax Registration No.” column in the report was commented out, and the same column was re-added with a blank expression to avoid report rendering issues and data retrieval errors.  

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Purchase Order Haiti.rdl';
    CaptionML = ENU = 'Purchase Order Haiti',
                ESP = 'Orden de Compra',
                FRA = 'Bon de Commande';
    PreviewMode = PrintLayout;
    ApplicationArea = ALL;
    UsageCategory = ReportsAndAnalysis;

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
            //BC UPGRADE ATHUKS01 >>  Drink IT field 
            //column(PurchaseHeader_ContactPersonName;"Last changed User ID")
            //{
            //}
            column(PurchaseHeader_ContactPersonName; '')
            {
            }
            //BC UPGRADE ATHUKS01 <<  Drink IT field 
            column(PurchaseHeader_ContactPersonEmail; UserRec."Contact Email")
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
            //BC UPGRADE ATHUKS01 >>Donnetvariable  
            // column(testremark; StringHelper.Copy(FORMAT(POTextNew)))
            // {
            // }
            column(testremark; StringHelper)
            {
            }
            //BC UPGRADE ATHUKS01 <<Donnetvariable
            column(PurchaseHeader_ContractcontpersonTxt; ContractcontpersonTxt)
            {
            }
            column(HouseNumber_PurchaseHeader; "Purchase Header"."House Number FND")
            {
            }
            column(Txt55000; Txt55000)
            {
            }
            column(Txt55001; Txt55001)
            {
            }
            column(Txt55002; Txt55002)
            {
            }
            column(Txt55003; Txt55003)
            {
            }
            column(Txt55004; Txt55004)
            {
            }
            column(Txt55005; Txt55005)
            {
            }
            column(Txt55006; Txt55006)
            {
            }
            column(Txt55007; Txt55007)
            {
            }
            column(Txt55008; Txt55008)
            {
            }
            column(Txt55009; Txt55009)
            {
            }
            column(Txt55010; Txt55010)
            {
            }
            column(Txt55011; Txt55011)
            {
            }
            column(Txt55012; Txt55012)
            {
            }
            column(Txt55013; Txt55013)
            {
            }
            column(Txt55014; Txt55014)
            {
            }
            column(Txt55015; Txt55015)
            {
            }
            column(Txt55016; Txt55016)
            {
            }
            column(Txt55017; Txt55017)
            {
            }
            column(Txt55018; Txt55018)
            {
            }
            column(Txt55019; Txt55019)
            {
            }
            column(Txt55020; Txt55020)
            {
            }
            column(Txt55021; Txt55021)
            {
            }
            column(Txt55022; Txt55022)
            {
            }
            column(Txt55023; Txt55023)
            {
            }
            column(Txt55024; Txt55024)
            {
            }
            column(Txt55025; Txt55025)
            {
            }
            column(Txt55026; Txt55026)
            {
            }
            column(Txt55027; Txt55027)
            {
            }
            column(Txt55028; Txt55028)
            {
            }
            column(Txt55029; Txt55029)
            {
            }
            column(Txt55030; Txt55030)
            {
            }
            column(Txt55031; Txt55031)
            {
            }
            column(Txt55032; Txt55032)
            {
            }
            column(Txt55033; Txt55033)
            {
            }
            //BC UPGRADE ATHUKS01 >>  Drink IT field 
            column(Txt55034; Txt55034)
            {
            }
            // column(Txt55035; Txt55035)
            // {
            // }
            //BC UPGRADE ATHUKS01 <<  Drink IT field 
            column(Txt55035; '')
            {
            }
            column(Txt55036; Txt55036)
            {
            }
            column(Txt55037; Txt55037)
            {
            }
            column(Txt55038; Txt55038)
            {
            }
            column(Txt55039; Txt55039)
            {
            }
            column(Txt55040; Txt55040)
            {
            }
            column(Txt55041; Txt55041)
            {
            }
            column(Txt55042; Txt55042)
            {
            }
            column(Txt55043; Txt55043)
            {
            }
            column(Txt55044; Txt55044)
            {
            }
            column(Txt55045; Txt55045)
            {
            }
            column(Txt55046; Txt55046)
            {
            }
            column(Txt55047; Txt55047)
            {
            }
            column(Txt55048; Txt55048)
            {
            }
            column(Txt55049; Txt55049)
            {
            }
            column(Txt55050; Txt55050)
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
                    //BC UPGRADE ATHUKS01 >>  Drink IT field 
                    // column(Vendor_TaxRegistrationNo; "Purchase Header"."Vendor Tax Registration No.")
                    // {
                    // }
                    column(Vendor_TaxRegistrationNo; '')
                    {
                    }
                    //BC UPGRADE ATHUKS01 <<  Drink IT field 
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
                            //BC UPGRADE ATHUKS01 >>  Drink IT field 
                            //PurchCommentLine.SETRANGE("Print On Purchase Order", true);
                            //BC UPGRADE ATHUKS01 <<  Drink IT field 

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
                            //BC UPGRADE ATHUKS01 >>  Drink IT field 
                            //VendCommentLine.SETRANGE("Print On Purchase Order", true);
                            //BC UPGRADE ATHUKS01 <<  Drink IT field 

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
                        column(POLineStatus; POLineStatus)
                        {
                        }
                        column(PurchaseLine_ExpRecDate; FORMAT("Purchase Line"."Expected Receipt Date", 10, '<Day,2>/<Month,2>/<Year4>'))
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

                            //BC UPGRADE ATHUKS01 >>  
                            if not ItemCrossRef.GET("Purchase Line"."No.", "Purchase Line"."Variant Code", "Purchase Line"."Unit of Measure Code",
                              ItemCrossRef."Reference Type"::Vendor, "Purchase Line"."Buy-from Vendor No.", "Purchase Line"."Vendor Item No.") then
                                ItemCrossRef.INIT();
                            //BC UPGRADE ATHUKS01 <<  
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

                            //>>HEI.08
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
                            //<<HEI.08
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
                            //CurrReport.CREATETOTALS(PurchLine."Line Amount", PurchLine."Inv. Discount Amount");ReportSUM
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
                            //BC UPGRADE ATHUKS01
                            // CurrReport.CREATETOTALS(
                            //   VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                            //   VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
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

                            // CurrReport.CREATETOTALS(
                            //   PrepmtInvBuf.Amount, PrepmtInvBuf."Amount Incl. VAT",
                            //   PrepmtVATAmountLine."Line Amount", PrepmtVATAmountLine."VAT Base",
                            //   PrepmtVATAmountLine."VAT Amount",
                            //   PrepmtLineAmount);
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
                                TEMPPurchaseDocumentLog.NEXT;
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
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

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
                    //BC UPGRADE ATHUKS01 >>  Drink IT field 
                    //PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);
                    //BC UPGRADE ATHUKS01 <<  Drink IT field 
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount();
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase();
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT();

                    if Number > 1 then
                        CopyText := Text003;
                    // CurrReport.PAGENO := 1; //BC UPGRADE ATHUKS01
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
                CurrReport.LANGUAGE := LanguageR.GetLanguageID("Language Code");

                CompanyInfo.GET;

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
                //BC UPGRADE ATHUKS01>>
                //<<DITW18.00.06 BCE 11/08/2015 DIT-770 #1532
                // recLocation.RESET();
                // if recLocation.GET("Purchase Header"."Location Code") then begin
                //     txtLocationPhoneNo := recLocation."Phone No.";
                //     txtLocationEmail := recLocation."E-Mail";
                //     txtLocationFaxNo := recLocation."Fax No.";
                // end;
                //>>DITW18.00.06 BCE DIT-770 #1532

                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                // if Print then begin
                //     TempPrintedPurchHeader := "Purchase Header";
                //     TempPrintedPurchHeader.INSERT();
                // end;
                //>> DITW18.00.07 VSC DIT-770 #1970
                //BC UPGRADE ATHUKS01<<

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


                //<<HEI.08
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
                    until PurchaseDocumentLog.NEXT = 0;

                PurchaseDocumentLog.RESET();
                PurchaseDocumentLog.SETRANGE("Document Type", "Purchase Header"."Document Type"::Order);
                PurchaseDocumentLog.SETRANGE("Document No.", "Purchase Header"."No.");
                PurchaseDocumentLog.SETFILTER("Line No.", '<>%1', 0);
                PurchaseDocumentLog.SETRANGE(Printed, false);
                if PurchaseDocumentLog.FINDFIRST() then
                    POChanged := 1;
                //>>HEI.08

                DeliveryDate1 := 0D;
                PurchLine1.RESET();
                PurchLine1.SETRANGE("Document No.", "No.");
                PurchLine1.SETRANGE("Document Type", "Document Type");
                if PurchLine1.FINDSET() then
                    DeliveryDate1 := PurchLine1."Expected Receipt Date";

                //HEI.10>>
                CLEAR(PayTermsDesc);
                CLEAR(ContactPersonTxt);
                CLEAR(UsrName);
                CLEAR(ContractcontpersonTxt);
                CLEAR(ContrContPerUsrName);
                CLEAR(PurchaserCode);
                "Purchase Header".CALCFIELDS("House Number FND");
                //Payment terms Description
                PaymentTermsRec.RESET;
                if PaymentTermsRec.GET("Purchase Header"."Payment Terms Code") then
                    PayTermsDesc := PaymentTermsRec.Description;

                // Contact Person
                if "Purchase Header"."Maximo Requisition No. FND" <> '' then
                    UsrName := "Purchase Header"."PQ Approver FND";
                //BC UPGRADE ATHUKS01 >>  Drink IT CODE
                //else if "Purchase Header"."Quote No." <> '' then
                //  UsrName := "Purchase Header"."Requester ID"
                //else
                //  UsrName := "Purchase Header"."Created By";
                //BC UPGRADE ATHUKS01 >>  Drink IT CODE

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
                        //POTextNew.READ(MemoReader);//BC UPGRADE ATHUKS01 
                        ReadInstream(MemoReader);//BC UPGRADE ATHUKS01
                    end;
                end else
                    if PurchasesPayablesSetup."PO Legal Text FND".HASVALUE then begin
                        PurchasesPayablesSetup."PO Legal Text FND".CREATEINSTREAM(MemoReader);
                        //POTextNew.READ(MemoReader);//BC UPGRADE ATHUKS01
                        ReadInstream(MemoReader);//BC UPGRADE ATHUKS01
                    end;


                //HEI.10<<
            end;

            //BC UPGRADE ATHUKS01 >>  Drink IT CODE
            // trigger OnPostDataItem();
            // var
            //     PurchHeader: Record "Purchase Header";
            // begin

            //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
            // if Print then begin
            //     if TempPrintedPurchHeader.FINDSET() then
            //         repeat
            //             PurchHeader.GET(TempPrintedPurchHeader."Document Type", TempPrintedPurchHeader."No.");
            //            
            //             // if PurchHeader."Receipt Status" < SetReceiptStatus then begin
            //             //   PurchHeader.VALIDATE("Receipt Status", SetReceiptStatus);
            //          
            //             PurchHeader.MODIFY(true);

            //         until TempPrintedPurchHeader.NEXT() = 0;
            // END;
            // end;
            //BC UPGRADE ATHUKS01 <<  Drink IT CODE


            trigger OnPreDataItem();
            begin
                //BC UPGRADE ATHUKS01 <<  Drink IT CODE
                //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1970
                // Print := Print or not CurrReport.PREVIEW;
                // TempPrintedPurchHeader.RESET();
                // TempPrintedPurchHeader.DELETEALL();
                //BC UPGRADE ATHUKS01 >>  Drink IT CODE

                //>>HEI.01
                //BC UPGRADE ATHUKS01  << Drink IT CODE
                //User.SETRANGE("User Name", "Last changed User ID");
                User.SetRange("User Name", SystemModifiedBy);
                //BC UPGRADE ATHUKS01  >> Drink IT CODE
                if User.FINDFIRST() then;
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
                        Caption = 'No. of Copies';
                        ToolTip = 'NoofCopies';
                        ApplicationArea = ALL;
                    }
                    field(SetReceiptStatus; SetReceiptStatus)
                    {
                        Caption = 'Set Receipt Status';
                        OptionCaption = 'Open,Order Printed,Order Sent,Order Confirmed,To Receive,Receipt Completed,Invoice';
                        ApplicationArea = ALL;
                        ToolTip = 'SetReceiptStatus';
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

        trigger OnOpenPage()
        var
        enumvalue:Enum "Interaction Log Entry Document Type";
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
        GLSetup.GET;
        PurchSetup.GET;

        CompanyInfo1.GET;
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
        LanguageR: Codeunit Language;
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
        //BC UPGRADE ATHUKS01 >> 
        //ItemCrossRef: Record "Item Cross Reference";
        ItemCrossRef: Record "Item Reference";
        //BC UPGRADE ATHUKS01 >> 
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
        //StringHelper: DotNet "'mscorlib'.System.String"; //BC UPGRADE ATHUKS01
        StringHelper: Text;//BC UPGRADE ATHUKS01
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        POTextNew: BigText;
        Txt55000: TextConst ENU = '1    Introduction', FRH = '1    Introduction';
        Txt55001: TextConst ENU = 'BRANA''s way of working with suppliers help to ensure clear, transparent and smooth Purchase to Pay process , to minimize risks for both parties of doing business with each other.', FRA = 'Les méthodes de travail de BRANA avec les fournisseurs contribuent â garantir un processus d''achat- paiement clair, transparent et fluide, afin de minimiser les risques pour les deux parties de faire des affaires entre elles..';
        Txt55002: TextConst ENU = '2    Negotiations', FRA = '2    Négotiations';
        Txt55003: TextConst ENU = '  .  BRANA procurement Department is the only one department authorised to have commercial negotiations regarding price and payment terms', FRA = '  .  Le service des achats de BRANA est le seul département autorisé à avoir des négociations commerciales concernant le prix et les conditions de paiement.';
        Txt55004: TextConst ENU = '  .  Due to duration of Supplier Selection process please ensure quote validity minimum 4 weeks.', FRA = '  .  En raison de la durée du processus de sélection des fournisseurs, veuillez assurer la validité du devis au moins de 4 semaines.';
        Txt55005: TextConst ENU = '3    Purchase Order (PO)', FRA = '3    Bon de commande (PO)';
        Txt55006: TextConst ENU = '  .  Before delivery of goods / providing service to BRANA please make sure you have received from relevant number of BRANA Procurement Department the purchase order, official document confirming BRANA''s commitment to receive and pay certain goods / services. In opposite case BRANA cannot guarantee your goods or services will be paid.', FRA = '  .  Avant de livrer des biens / de fournir des services à BRANA, veuillez vous assurer que vous avez reçu du membre compétent du service des achats de BRANA le bon de commande, document officiel confirmant l''engagement de BRANA à recevoir et à payer certains biens / services. Dans le cas contraire, BRANA ne peut garantir que vos biens ou services seront payés.';
        Txt55007: TextConst ENU = '4    Shipment', FRA = '4    Expédition';
        Txt55008: TextConst ENU = '  .  As soon as you receive the PO please communicate commited / updated lead time to the generic e-mail address: ', FRA = '  .  Dès que vous recevez le bon de commande, veuillez communiquer le délai de livraison engagé / mis à jour à l''adresse e-mail générique:';
        Txt55009: Label 'brana.custom@heineken.com.';
        Txt55010: TextConst ENU = '  .  As soon as goods are ready for shipment please send the following documents to the generic e-mail address: brana.custom@heineken.com.', FRA = '  .  Dès que les marchandises sont prêtes pour l''expédition, veuillez envoyer les documents suivants à l''adresse e-mail générique: brana.custom@heineken.com.';
        Txt55011: TextConst ENU = '      .  Invoice (HS Code) incl. PO number;', FRA = '      .  Facture (code SH) incl. Numéro de bon de commande;';
        Txt55012: TextConst ENU = '      .  Packing List;', FRA = '      .  Liste de colisa;';
        Txt55013: TextConst ENU = '      .  AWL or BOL;', FRA = '      .  AWL ou BOL;';
        Txt55014: TextConst ENU = '      .  Please check in all documents the name of BRANA: "Brasserie Nationale D''Haiti S.A."', FRA = '      .  Veuillez vérifier dans tous les documents le nom de BRANA: "Brasserie Nationale D''Haiti S.A.".';
        Txt55015: TextConst ENU = '  .  Ship to the following official address unless another one is clearly communicated with the PO.', FRA = '  .  Expédiez à l''adresse officielle suivante, à moins qu''une autre ne soit clairement communiquée au PO.';
        Txt55016: Label '"       BRASSERIE NATIONALE D''HAITI S.A."';
        Txt55017: Label '"       BOULEVARD TOUSSAINT LOUVERTURE"';
        Txt55018: Label '"       ROUTE DE L''AEROPORT "';
        Txt55019: Label '"       PORT AU PRINCE, OUEST HT 6120"';
        Txt55020: Label '"       HAITI"';
        Txt55021: TextConst ENU = '  .  Include delivery note with the PO number in the delivery box.', FRA = '  .  Inclure le bon de livraison avec le numéro de commande dans la boîte de livraison.';
        Txt55022: TextConst ENU = '5    Invoice', FRA = '5    Facture';
        Txt55023: TextConst ENU = '  .  All invoices must refer to PO number', FRA = '  .  Toutes les factures doivent se référer au numéro de bon de commande. ';
        Txt55024: TextConst ENU = '  .  For local transport companies and customs brokers: you must put the PO number of the items that are being picked up / processed.', FRA = '  .  Pour les entreprises de transport locales et les courtiers en douane: vous devez mettre le numéro de commande des articles qui sont receuillis / traités.';
        Txt55025: TextConst ENU = '  .  All invoices have to be in the same currency as related PO.', FRA = '  .  Toutes les factures doivent être dans la même devise que le bon de commande correspondant.';
        Txt55026: TextConst ENU = '  .  All invoices have to have date of invoicewhich will be used to define due date for payment based on contracted payment terms. ', FRA = '  .  Toutes les factures doivent avoir une date de facture qui sera utilisée pour définir la date d''échéance du paiement basé sur les termes de paiements contractés.';
        Txt55027: TextConst ENU = '  .  BRANA has two entry points for all invoices:', FRA = '  .  BRANA dispose de 2 points d''entrée pour toutes les factures:';
        Txt55028: TextConst ENU = '      .  Digital via e-mail to brana.accounting@heineken.com, please expect a reply to proof of reception;', FRA = '      .  Numérique via e-mail à brana.accounting@heineken.com , veuillez vous attendre à une réponse d''accusé de réception;';
        Txt55029: TextConst ENU = '      .  Hard copy of BRANA front desk in port -au-prince please expect to sign and get a proof of reception.', FRA = '      .  Copie physique à la réception de BRANA à Port-au-Prince, veuillez vous attendre à signer et à obtenir une preuve de réception.';
        Txt55030: TextConst ENU = '  .  All invoice have to be sent:', FRA = '  .  Toutes les factures doivent être envoyées:';
        Txt55031: TextConst ENU = '      .  for local suppliers: when goods are delivered on service is rendered;', FRA = '      .  pour les fournisseurs locaux: lorsque les marchandises sont livrées ou le service rendu;';
        Txt55032: TextConst ENU = '      .  for International suppliers: when goods are ready for shipment or service is rendered.', FRA = '      .  pour les fournisseurs internationaux: lorsque les marchandises sont prêtes à être expédiées ou que le service est rendu. ';
        Txt55033: TextConst ENU = '  .  In case you are providing repeatitive services you have to send an invoice once per month at last working day.', FRA = '  .  Si vous fournissez des services répétitifs, vous devez envoyer une facture une fois par mois le dernier jour ouvrable.';
        Txt55034: TextConst ENU = '  .  If the date of invoice reception is differet from the date of invoice on more than 7 days this invoice are not going to be processed and has to be corrected by supplier. You will get relevant message from brana.accounting@heineken.com', FRA = '  .  Si la date de réception de la facture est différente de la date de facturation sur plus de 7 jours, cette facture ne sera pas traitée et devra être corrigée par le fournisseur. Vous recevrez un message pertinent de brana.accounting@heineken.com . ';

        //Txt55035: ;
        Txt55036: TextConst ENU = '  .  In case of partial delivery invoices can only be nade for related quantity delivered.', FRA = '  .  En cas de livraison partielle, les factures ne peuvent être établies que pour la quantité livrée. ';
        Txt55037: TextConst ENU = '  .  In case of prepayment related to onvoices still have to be sent to brana.accounting@heineken.com once the service is rendered / goods are shipped or delivered. ', FRA = '  .  En cas de paiement à l''avance, les factures doivent toujours être envoyées à brana.accounting@heineken.com  une fois le service rendu / les marchandises sont expédiées ou livrées.';
        Txt55038: TextConst ENU = '6    Payment', FRA = '6    Paiement';
        Txt55039: TextConst ENU = '  .  For local suppliers in case of PO in foriegn currency payment will be done in local currency using the BRH sales rate at the day of payment.', FRA = '  .  Pour les fournisseurs locaux en cas de commande en devise étrangère, le paiement sera effectué en devise locale en utilisant le taux de vente BRH au jour du paiement.';
        Txt55040: TextConst ENU = '  .  For International suppliers payment will be done in the currency of the PO.', FRA = '  .  Pour les fournisseurs internationaux, le paiement sera effectué dans la devise du bon de commande.';
        Txt55041: TextConst ENU = '  .  If there are changes of bank account occur in the meamtime supplier has to inform BRANA via Treasury e-mail address brana.accounting@heineken.com and from authorised person only.', FRA = '  .  En cas de changement de compte bancaire dans l''intervalle, le fournisseur doit en informer BRANA via l''adresse e-mail du Trésor brana.treasury@heineken.com  et uniquement auprès de la personne autorisée.';
        Txt55042: TextConst ENU = '  .  BRANA aims to make 100% of payment to suppliers by wire transfers. Cheque payments are strongly not recommended.', FRA = '  .  BRANA vise à effectuer 100% du paiement aux fournisseurs par virement bancaire. Les paiements par chèque sont fortement déconseillés.';
        Txt55043: TextConst ENU = '7    Reconciliation', FRA = '7    Réconcilation';
        Txt55044: TextConst ENU = '  .  All suppliers have to provide to brana.accounting@heineken.com their statement for reconciliation at 1st working day of each month.', FRA = '  .  Tous les fournisseurs doivent fournir à brana.accounting@heineken.com  leur état de compte  le 1er jour ouvrable de chaque mois.';
        Txt55045: TextConst ENU = '8    Returns', FRA = '8    Retours';
        Txt55046: TextConst ENU = '  .  In case of returns with credit memo please provide to brana.accounting@heineken.com following information with / on credit memo:', FRA = '  .  En cas de retours avec note de crédit, veuillez fournir à brana.accounting@heineken.com  les informations suivantes avec / sur la note de crédit:';
        Txt55047: TextConst ENU = '      .  PO number;', FRA = '      .  Numéro de bon de commande;';
        Txt55048: TextConst ENU = '      .  Invoice Reference;', FRA = '      .  Référence de la facture;';
        Txt55049: TextConst ENU = '      .  Purchase Information.', FRA = '      .  Les informations d''achats.';
        Txt55050: TextConst ENU = '  .  In case of returns with cash back please provide to brana.treasury@heineken.com following information with / on credit memo:', FRA = '  .  En cas de retour avec remise en argent, veuillez fournir à brana.treasury@heineken.com  les informations suivantes avec / sur la note de crédit:';

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

