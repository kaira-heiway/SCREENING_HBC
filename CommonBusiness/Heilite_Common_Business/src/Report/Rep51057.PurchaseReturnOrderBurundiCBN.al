report 51057 "Purch Return Order Burundi CBN"
{
    // version HEI.04

    // HEI.01 FDD-HT935_Burundi
    //   # New Report created based on the standard layout report ID 50035
    // HEI.02 FDD-HT935_Burundi
    //   #change the additional address details
    // HEI.03 FDD-HT935_Burundi
    //   #add the Plant Opening Hrs value from Company information to the Plant Opening Hrs label (section Deliver Goods)
    // HEI.04 HB2907 CHG2157356 IBM SHIVAS05 31.08.2022
    //   # Find Contact Person Email form user setup on the basis of Created By user.
    //**************************************************************************************
    //BC UPGRADE VAMSIU01 17-05-25
    //GetLanguageID() Procedure Moved from table to codeunit.
    //"Created By" Field is changed to SystemCreatedBy in Latest Versions.
    //Procedure Naming change FindInteractTmplCode() with FindInteractionTemplateCode()
    //Language varaiable is Changed to languages because language is built-in procedure, it might cause runtime issues.


    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Purchase Return Order Burundi.rdl';

    CaptionML = ENU = 'Purchase Return Order Burundi',
                ESP = 'Orden de retorno',
                FRA = 'Commande de retour',
                ENG = 'Purchase Return Order Burundi';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = CONST("Return Order"));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeadingML = ENU = 'Purchase Return Order',
                                     ENG = 'Purchase Return Order';
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
            column(PurchaseHeader_No; "No.")
            {
            }
            column(PurchaseHeader_NoPrinted; "No. Printed")
            {
            }
            column(PurchaseHeader_ContactPersonName; User."Full Name")
            {
            }
            column(PurchaseHeader_ContactPersonEmail_Remove; User."Contact Email")
            {
            }
            column(PurchaseHeader_ContactPersonEmail; UserSetup."E-Mail")
            {
            }
            column(PurchHeader_Reason_Code; "Purchase Header"."Reason Code")
            {
            }
            column(ReasonCodeDescription; ReasonCodeDescription)
            {
            }
            column(ReasonCodeDescriptionLbl; ReasonCodeDescriptionLbl)
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
                    column(CompanyInfo_Addr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyInfo_Addr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyInfo_Addr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyInfo_Addr5; CompanyAddr[5])
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
                    column(CompanyInfo_RegistrationNo; CompanyInfo."Registration No.")
                    {
                    }
                    column(CompanyInfo_VAT; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfo_Email; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo_OpCoLogo; CompanyInfo."OpCo Logo FND")
                    {
                    }
                    column(PurchaseHeader_DocumentDate; FORMAT("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    // column(Vendor_TaxRegistrationNo; "Purchase Header"."Vendor Tax Registration No.")
                    // {
                    // }//BC UPGRADE VAMSIU01 -(f2013726 - DIT)
                    column(EUVATNumber; "Purchase Header"."VAT Registration No.")
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
                    column(Vendor_Contact; Vendor.Contact)
                    {
                    }
                    column(Vendor_Email; Vendor."E-Mail")
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
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1Number; Number)
                        {
                        }
                        column(HdrDimsCaption; HdrDimsCaptionLbl)
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
                        column(TypeInt; TypeInt)
                        {
                        }
                        column(PurchaseLine_No; "Purchase Line"."No.")
                        {
                        }
                        column(PurchaseLine_Description; "Purchase Line".Description)
                        {
                        }
                        column(PurchaseLine_Quantity; "Purchase Line".Quantity)
                        {
                        }
                        column(PurchaseLine_UoM; "Purchase Line"."Unit of Measure")
                        {
                        }
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
                        column(TotalAmount; TotalAmount)
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
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = sorting(Number) where(Number = FILTER(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(DimensionLoop2Number; Number)
                            {
                            }
                            column(LineDimsCaption; LineDimsCaptionLbl)
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

                            if (PurchLine.Type = PurchLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Purchase Line"."No." := '';

                            TypeInt := "Purchase Line".Type;
                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line".Amount;


                            if "Purchase Line".Type = "Purchase Line".Type::Item then
                                if Item.GET("Purchase Line"."No.") then;


                            LineNo := INCSTR(LineNo);
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
                            // CurrReport.CREATETOTALS(PurchLine."Line Amount", PurchLine."Inv. Discount Amount");
                            //BCUPG CREATETOTALS DEPRECATED //PANDEA04
                            LineNo := '000';
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
                            // CurrReport.CREATETOTALS(
                            //   VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                            //   VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                            //BCUPG CREATETOTALS DEPRECATED //PANDEA04
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHdr; VALSpecLCYHeader)
                        {
                        }
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
                        column(VATAmtLineVATIdentifier1; VATAmountLine."VAT Identifier")
                        {
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
                            //  CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);
                            //BCUPG CREATETOTALS DEPRECATED //PANDEA04
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
                        DataItemTableView = sorting(Number) where(Number = CONST(1));

                        trigger OnPreDataItem();
                        begin
                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = CONST(1));
                        column(SelltoCustNo_PurchHdr; "Purchase Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(SelltoCustNo_PurchHdrCaption; "Purchase Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem();
                        begin
                            if ("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
                                CurrReport.BREAK();
                        end;
                    }
                }

                trigger OnAfterGetRecord();
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
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                if "Language Code" = 'FRA' then
                    DocLanguage := 'FRA'
                else
                    DocLanguage := 'ENG';
                //CurrReport.LANGUAGE := Language.GetLanguageID(DocLanguage);//BC UPGRADE VAMSIU01 - Commented Due to GetLanguageID() procedure is moved to Codeunit from Table.
                CurrReport.Language := Languages.GetLanguageId(DocLanguage);//BC UPGRADE VAMSIU01 - Replaced Language record varible with Languages codeunit variable because Language is Predefined Procedure in the Business central so it might effect.                 
                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                //User.SETRANGE("User Name","Created By");//BC UPGRADE VAMSIU01 - Commented, Created By is no longer used in the Business central
                User.SetRange("User Name", SystemCreatedBy);//BC UPGRADE VAMSIU01 - Replaced Created by with System Created By beacuse Created by is no longer available in Buinsess central.
                if User.FINDFIRST() then;
                if Vendor.GET("Buy-from Vendor No.") then;


                if LogInteraction then
                    if not CurrReport.PREVIEW then begin
                        if "Buy-from Contact No." <> '' then
                            SegManagement.LogDocument(
                              22, "No.", 0, 0, DATABASE::Contact, "Buy-from Contact No.", "Purchaser Code", '', "Posting Description", '')
                        else
                            SegManagement.LogDocument(
                              22, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '')
                    end;


                if "Currency Code" = '' then
                    LCYCode := GLSetup."LCY Code"
                else
                    LCYCode := "Currency Code";

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


                if "Payment Terms Code" = '' then
                    PaymentTerms.INIT()
                else begin
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, DocLanguage);
                end;


                if PurchaseReasonCode.GET("Purch. Reason Code FND") then
                    ReasonCodeDescription := PurchaseReasonCode.Description;
                //if UserSetup.GET("Purchase Header"."Created By") then;//HEI.04//BC UPGRADE VAMSIU01 - Commented, Created By is no longer used in the Business central.
                if UserSetup.Get("Purchase Header".SystemCreatedBy) then;//BC UPGRADE VAMSIU01 - Replaced Created by with System Created By beacuse Created by is no longer available in Buinsess central.
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
                    field(NoOfCopies; NoOfCopies)
                    {
                        CaptionML = ENU = 'No. of Copies',
                                    ENG = 'No. of Copies';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the NoOfCopies field.';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        CaptionML = ENU = 'Show Internal Information',
                                    ENG = 'Show Internal Information';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ShowInternalInfo field.';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        CaptionML = ENU = 'Log Interaction',
                                    ENG = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the LogInteraction field.';
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
            //LogInteraction := SegManagement.FindInteractTmplCode(22) <> '';
            LogInteraction := SegManagement.FindInteractionTemplateCode(DocumentType::"Purch. Return Ord. Cnfrmn.") <> '';//BC UPGRADE VAMSIU01 - replaced the Procedure FindInteractTmplCode() with FindInteractionTemplateCode() Naming change by Business Central.
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);
        CompanyInfo.CALCFIELDS("OpCo Logo FND");
    end;

    var
        CompanyInfo: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        Item: Record Item;
        PaymentTerms: Record "Payment Terms";
        PurchLine: Record "Purchase Line" temporary;
        ReasonCode: Record "Reason Code";
        PurchaseReasonCode: Record "Reason Code_Purchase FND";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        User: Record User;
        UserSetup: Record "User Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        Vendor: Record Vendor;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        //Language: Record Language;//BC UPGRADE VAMSIU01 -Commented variable, Language is also used as Default Procedure because it might cause runtime issues.
        Languages: Codeunit Language;//BC UPGRADE VAMSIU01 - Added language Codeunit in replacement to Language record for using GetLangugaeID() Procedure.
        PurchPost: Codeunit "Purch.-Post";
        SegManagement: Codeunit SegManagement;
        Continue: Boolean;
        LogInteraction: Boolean;

        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        DocLanguage: Code[10];
        LCYCode: Code[10];
        LineNo: Code[10];
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalSubTotal: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        TypeInt: Enum "Purchase Line Type";
        CopyText: Text[30];
        PurchaserText: Text[30];
        BuyFromAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ReasonCodeDescription: Text[50];
        ShipToAddr: array[8] of Text[50];
        ShipToCompanyAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        VendAddr: array[8] of Text[50];
        OldDimText: Text[75];
        ReferenceText: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        DimText: Text[120];
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
        EUVATNumber: TextConst ENU = 'EU VAT Number:', ESP = 'EU VAT Number:', FRA = 'EU VAT Number:', ENG = 'EU VAT Number:';
        FooterSubText: TextConst ENU = 'Site Internet:', ENG = 'Site Internet:';
        HdrDimsCaptionLbl: TextConst ENU = 'Header Dimensions', ENG = 'Header Dimensions';
        Incoterms: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:', ENG = 'Incoterms:';
        ItemCaption: TextConst ENU = 'Item', ESP = 'Artículo', FRA = 'Article', ENG = 'Item';
        LegalContractReference: TextConst ENU = 'Legal Contract Reference:', ESP = 'Referencia legal del contrato:', FRA = 'Référence du contrat legal:', ENG = 'Legal Contract Reference:';
        LegalTextBox: TextConst ENU = 'THIS MERCHANDISE WILL BE INSURED BY US OUR FLOTING POLICY No.07-02-250473-0 N .  All foreign remitted payment for professional services must be subject to withholding tax of. 0 According to Article 133 of Panamanian Tax Code.  Commercial invoice must bear the following certification signed by and authorized person in your oganization: ¨Conste bajo la gravedad del juramento, que todos los datos expresados en esta factura son exactos y verdaderos.¨', ENG = 'THIS MERCHANDISE WILL BE INSURED BY US OUR FLOTING POLICY No.07-02-250473-0 N .  All foreign remitted payment for professional services must be subject to withholding tax of. 0 According to Article 133 of Panamanian Tax Code.  Commercial invoice must bear the following certification signed by and authorized person in your oganization: ¨Conste bajo la gravedad del juramento, que todos los datos expresados en esta factura son exactos y verdaderos.¨';
        LegalTextBox1: TextConst ENU = 'This Purchase Order is excluding VAT. Please :', FRA = 'Ce bon de commande est hors TVA. Merci de bien vouloir:', ENG = 'This Purchase Order is excluding VAT. Please :';
        LegalTextBox2: TextConst ENU = '• confirm this Purchase Order(delivery time, quantity, quality) within 48H', FRA = '•       confirmer cette commande (Délai, quantité, qualité) sous 48H. ', ENG = '• confirm this Purchase Order(delivery time, quantity, quality) within 48H';
        LegalTextBox3: TextConst ENU = '• write this Purchase Order Number ', FRA = '•       mentionner le numéro de ce bon de commande  ', ENG = '• write this Purchase Order Number ';
        LegalTextBox4: TextConst ENU = ' on your invoice', FRA = ' sur votre facture.', ENG = ' on your invoice';
        LegalTextBox5: TextConst ENU = 'send your invoice to our accounts payable department per post or email to ', FRA = '•       envoyer votre facture à notre service comptabilité via courrier ou email à ', ENG = 'send your invoice to our accounts payable department per post or email to ';
        LineDimsCaptionLbl: TextConst ENU = 'Line Dimensions', ENG = 'Line Dimensions';
        MachinerefNo: TextConst ENU = 'Machine Reference Number', ESP = 'Machine Reference Number', FRA = 'Machine Reference Number', ENG = 'Machine Reference Number';
        Material: TextConst ENU = 'Material', ESP = 'Material', FRA = 'Matériel', ENG = 'Material';
        MaterialDescription: TextConst ENU = 'Material Description', ESP = 'Descripción del material', FRA = 'Description du matériel', ENG = 'Material Description';
        NetPrice: TextConst ENU = 'Net Price', ESP = 'Precio Neto', FRA = 'Prix Net', ENG = 'Net Price';
        NetValue: TextConst ENU = 'Net Value', ESP = 'Valor Neto', FRA = 'Valeur Nette', ENG = 'Net Value';
        OperationalContractRef: TextConst ENU = 'Operational Contract ref:', ESP = 'Referencia del contrato operacional:', FRA = 'Référence du contrat opérationnel:', ENG = 'Operational Contract ref:';
        OrderingParty: TextConst ENU = 'ORDERING PARTY:', ESP = 'COMPAÑÍA QUE ORDENA:', FRA = 'DONNEUR D''ORDRE:', ENG = 'ORDERING PARTY:';
        PageCaption: TextConst ENU = 'Page', ESP = 'Página', FRA = 'Page', ENG = 'Page';
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
        ReasonCodeDescriptionLbl: TextConst ENU = 'Reason Code:', ENG = 'Reason Code:';
        ReportTitle: TextConst ENU = 'Return Order No.', ESP = 'Pedido de Devolución No.', FRA = 'Commande de Retour No.', ENG = 'Return Order No.';
        Reprinted: TextConst ENU = 'Reprinted', ESP = 'Reimpreso', FRA = 'Réimprimé', ENG = 'Reprinted';
        TaxIdentification: TextConst ENU = 'Tax Identification:', ESP = 'Número de Identificación de Impuestos:', FRA = 'Numero Identifiant Fiscal:', ENG = 'Tax Identification:';
        TaxIdentificationNumber: TextConst ENU = 'Tax Identification Number:', ESP = 'Número de Identificación de Impuestos:', FRA = 'Numero Identifiant Fiscal:', ENG = 'Tax Identification Number:';
        Text004: TextConst Comment = '%1 = Document No.', ENU = 'Return Order %1', ENG = 'Return Order %1';
        Text005: TextConst ENU = 'Page %1', ENG = 'Page %1';
        Text007: TextConst ENU = 'VAT Amount Specification in ', ENG = 'VAT Amount Specification in ';
        Text008: TextConst ENU = 'Local Currency', ENG = 'Local Currency';
        Text009: TextConst ENU = 'Exchange rate: %1/%2', ENG = 'Exchange rate: %1/%2';
        UoM: TextConst ENU = 'UoM', ESP = 'Unidad de Medición', FRA = 'Unité de mesure', ENG = 'UoM';
        VAT: TextConst ENU = 'VAT:', ESP = 'VAT:', FRA = 'VAT:', ENG = 'VAT:';
        VendNoCaptionLbl: TextConst ENU = 'Vendor No.', ENG = 'Vendor No.';
        VendorCaption: TextConst ENU = 'VendOR:', ESP = 'PROVEEDOR:', FRA = 'FOURNISSEUR:', ENG = 'VendOR:';
        YourVendorNoWithUs: TextConst ENU = 'Your Vendor Number with us:', ESP = 'Su número de proveedor con nosotros:', FRA = 'Votre numéro de fournisseur avec nous:', ENG = 'Your Vendor Number with us:';

    local procedure FormatAddressFields(PurchaseHeader: Record "Purchase Header");
    begin

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
}

