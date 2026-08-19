report 52027 "Purchase Return Order DRC"
{
    // version HEI.16

    // HEI.01 FDD-PA-PURGAP03 IBM NASTAA02 16.10.2017 # Purchase Order Layout Local Panama
    //   # New Report created based on the standard layout
    // 
    // HEI.02 FDD-PA-PURGAP03 Defect #719 IBM NASTAA02 23.10.2017 # Purchase Return Order Layout Local Panama
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
    // HEI.07 Defect #1783 IBM NASTAA02 29.03.2018 # Purchase Order PA
    //   # Item Column should have the format 00x, enlarged Material column
    // 
    // HEI.08 Defect #1900 IBM NASTAA02 11.04.2018 # Return Order form is not aligned with Purchase Order form
    //   # Moved the GetData function to the visibility of the TextBox because the data was not shown on the layout
    // 
    // HEI.09 Defect #1921 IBM NASTAA02 11.04.2018 # NAV_PO Form_Item_Field "Machine Reference Number"
    //   # Removed "Machine Reference Number" from the Layout
    // 
    // HEI.10 Defect #2006 IBM NASTAA02 19.04.2018 # NAV_PO Layout
    //   # Replaced "Payment Term Code" with "Payment Term Description"
    // 
    // HEI.11 Defect #2006 IBM NASTAA02 03.05.2018 # NAV_PO Layout
    //   # Added "Shipment Method Code" to the Incoterms
    // HEI.12 Defect #2283 IBM HORTOC01 25.06.2018 # user informations based on Creator user id
    // HEI.13 RFC-CHG0246348 IBM.SS 29.01.2019 # made changes for reason code
    // HEI.14 FDD-HT-1108 - CHG2053631 SHANKJ03 IBM 26.02.2020
    //   # Layout changes - Fields added and removed.
    // HEI.15 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //   # New report created
    // HEI.16 HB2907 CHG2157356 IBM SHIVAS05 31.08.2022
    //   # Find Contact Person Email form user setup on the basis of Created By user

    // BC Upgrade KUMARR78 >>
    // Report Name  : Purchase Return Order DRC
    // Old Report ID: 50446 (NAV - HEI.16 Version)
    // 1. Added Business Central visibility properties.
    //    Old: ApplicationArea and UsageCategory were not defined.
    //    New:
    //         - ApplicationArea = All
    //         - UsageCategory = ReportsAndAnalysis
    //    Reason: Mandatory for BC SaaS report visibility and role-based access compliance.
    // 2. Replaced deprecated field "Created By" with SystemCreatedBy.
    //    Old:
    //         - "Purchase Header"."Created By"
    //         - UserSetup.GET("Purchase Header"."Created By")
    //         - User.SETRANGE("User Name", "Created By")
    //    New:
    //         - "Purchase Header".SystemCreatedBy
    //         - UserSetup.GET("Purchase Header".SystemCreatedBy)
    //         - User.SetRange("User Name", SystemCreatedBy)
    //    Reason: Field "Created By" removed in Business Central base application.
    // 3. Replaced Language table function with Codeunit.
    //    Old:
    //         - Language: Record Language
    //         - Language.GetLanguageID("Language Code")
    //    New:
    //         - LanguageG: Codeunit Language
    //         - LanguageG.GetLanguageId("Language Code")
    //    Reason: GetLanguageId moved from Record to Codeunit in BC.
    // 4. Blocked unsupported DotNet usage.
    //    Old:
    //         - StringHelper: DotNet "'mscorlib'.System.String"
    //         - StringHelper.Copy(Format(FooterText))
    //    New:
    //         - DotNet variable removed/commented.
    //    Reason: DotNet not supported in Business Central Cloud (SaaS).
    // 5. Replaced deprecated SegManagement function.
    //    Old:
    //         SegManagement.FindInteractTmplCode(22)
    //    New:
    //         SegManagement.FindInteractionTemplateCode(22)
    //    Reason: Function renamed in BC base application.
    // 6. Removed/Blocked DIT-specific or obsolete fields.
    //    Old (commented/removed):
    //         - "Requester ID"
    //         - "Created By"
    //         - "Vendor Tax Registration No."
    //    New:
    //         - Replaced with supported BC fields (SystemCreatedBy)
    //         - Unsupported fields blocked
    //    Reason: Fields removed or redesigned in BC.
    // 7. Request Page BC compliance updates.
    //    Added:
    //         ApplicationArea = All on fields:
    //             - NoOfCopies
    //             - ShowInternalInfo
    //             - LogInteraction
    //    Reason: Required for BC UI rendering compliance.
    // 8. Currency handling retained (HEI.02 logic).
    //    Old:
    //         Currency Code could be blank.
    //    New:
    //         If blank → defaults to GLSetup."LCY Code".
    //    Note: No BC structural change, logic retained.
    // 10. Variables Added / Modified for BC Compatibility.
    //     Added:
    //         - LanguageG : Codeunit Language
    //     Removed / Commented:
    //         - Language : Record Language
    //         - StringHelper : DotNet
    //     Replaced field usage:
    //         - SystemCreatedBy instead of Created By
    // BC Upgrade KUMARR78 <<

    DefaultLayout = RDLC;
    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade KUMARR78 Adding UsageCategory
    RDLCLayout = '.\src\ReportsLayout\Purchase Return Order DRC.rdl';

    CaptionML = ENU = 'Return Order DRC',
                ESP = 'Orden de retorno',
                FRA = 'Commande de retour';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const("Return Order"));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Return Order';
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
            column(PleaseSendaCreditNoteToLbl; PleaseSendaCreditNoteTo)
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
            //BC Upgrade KUMARR78 >> DIT Field 
            // column(RequesterID_PurchaseHeader; "Purchase Header"."Requester ID")
            // {
            // }
            // column(CreatedBy_PurchaseHeader; "Purchase Header"."Created By")
            // {
            // }
            column(CreatedBy_PurchaseHeader; "Purchase Header".SystemCreatedBy)
            {
            }

            // column(LastchangedUserID_PurchaseHeader; "Purchase Header"."Last changed User ID")
            // {
            // }
            //BC Upgrade KUMARR78 << DIT Field
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
            column(CountyRegionName; CountyRegionRec.Name)
            {
            }
            column(YourReference_PurchaseHeader; "Purchase Header"."Your Reference")
            {
            }
            column(SRMContractName_PurchaseHeader; "Purchase Header"."SRM Contract Name FND")
            {
            }
            column(SRMContractNo_PurchaseHeader; "Purchase Header"."SRM Contract No. FND")
            {
            }
            column(PurchaseOrderNoLbl; PurchaseOrderNo)
            {
            }
            column(ClientLbl; Client)
            {
            }
            column(ToVendorAccountingdepLbl; ToVendorAccountingdepLbl)
            {
            }
            column(ShiptoAddress_PurchaseHeader; ShipToAdd1)
            {
            }
            column(ShiptoAddress2_PurchaseHeader; ShipToAdd2)
            {
            }
            column(ShiptoPostCode_PurchaseHeader; ShipToCity)
            {
            }
            column(ShiptoCity_PurchaseHeader; ShipToPost)
            {
            }
            column(LicenseCode; LicenseCode)
            {
            }
            column(LicenseCodeLbl; LicenseCodeLbl)
            {
            }
            column(LastChangedUsrTxt; LastChangedUsrTxt)
            {
            }
            column(RequesterIDTxt; RequesterIDTxt)
            {
            }
            // column(FooterText; StringHelper.Copy(Format(FooterText)))
            // {
            // }//BC Upgrade KUMARR78 Blocking Dot Net
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(CompanyInfo_Addr1; CompanyInfo.Name)
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
                    column(PurchaseHeader_DocumentDate; Format("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    // column(Vendor_TaxRegistrationNo; "Purchase Header"."Vendor Tax Registration No.")
                    // {
                    // }//BC Upgrade KUMARR78 DIT Field Removed
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
                    column(CompanyInfo_Name; CompanyInfo.Name)
                    {
                    }
                    column(CompanyInfo_PoLegal; CompanyInfo."PO Legal Text Box E-Mail FND")
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
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));
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
                                if not DimSetEntry1.FindSet() then
                                    CurrReport.Break();
                            end else
                                if not Continue then
                                    CurrReport.Break();

                            Clear(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      StrSubstNo(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if StrLen(DimText) > MaxStrLen(OldDimText) then begin
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
                        DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem();
                        begin
                            CurrReport.Break();
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
                            DataItemTableView = sorting(Number) where(Number = filter(1 ..));
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
                                    if not DimSetEntry2.FindSet() then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := StrSubstNo('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          StrSubstNo(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
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

                                DimSetEntry2.SetRange("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                PurchLine.Find('-')
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
                                if Item.Get("Purchase Line"."No.") then;
                            //HEI.05<<

                            LineNo := IncStr(LineNo); //HEI.07
                        end;

                        trigger OnPostDataItem();
                        begin
                            PurchLine.DeleteAll();
                        end;

                        trigger OnPreDataItem();
                        begin
                            MoreLines := PurchLine.Find('+');
                            while MoreLines and (PurchLine.Description = '') and (PurchLine."Description 2" = '') and
                                  (PurchLine."No." = '') and (PurchLine.Quantity = 0) and
                                  (PurchLine.Amount = 0)
                            do
                                MoreLines := PurchLine.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            PurchLine.SetRange("Line No.", 0, PurchLine."Line No.");
                            SetRange(Number, 1, PurchLine.Count);
                            CurrReport.CreateTotals(PurchLine."Line Amount", PurchLine."Inv. Discount Amount");

                            LineNo := '000'; //HEI.07
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
                                CurrReport.Break();
                            SetRange(Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
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

                            VALVATBaseLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Purchase Header"."Posting Date", "Purchase Header"."Currency Code",
                                  VATAmountLine."VAT Base", "Purchase Header"."Currency Factor"));
                            VALVATAmountLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Purchase Header"."Posting Date", "Purchase Header"."Currency Code",
                                  VATAmountLine."VAT Amount", "Purchase Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem();
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Purchase Header"."Currency Code" = '') or
                               (VATAmountLine.GetTotalVATAmount() = 0)
                            then
                                CurrReport.Break();

                            SetRange(Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(VALVATBaseLCY, VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007 + Text008
                            else
                                VALSpecLCYHeader := Text007 + Format(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                            VALExchRate := StrSubstNo(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));

                        trigger OnPreDataItem();
                        begin
                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
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
                        column(SelltoCustNo_PurchHdrCaption; "Purchase Header".FieldCaption("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem();
                        begin
                            if ("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
                                CurrReport.Break();
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    Clear(PurchLine);
                    Clear(PurchPost);
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
                    CurrReport.PageNo := 1;

                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem();
                begin
                    if not CurrReport.Preview then
                        Codeunit.Run(Codeunit::"Purch.Header-Printed", "Purchase Header");
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                // CurrReport.Language := Language.GetLanguageID("Language Code"); //BC Upgrade KUMARR78 GetlanguageId moved from Table to CU.
                CurrReport.Language := LanguageG.GetLanguageId("Language Code"); //BC Upgrade KUMARR78 GetlanguageId moved from Table to CU.


                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");

                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");
                //>>HEI.01
                //User.SETRANGE("User Name","Last changed User ID");//HEI.12

                // User.SETRANGE("User Name", "Created By");//HEI.12//BC Upgrade KUMARR78 Blocking DIT Field
                User.SetRange("User Name", SystemCreatedBy);//HEI.12//BC Upgrade KUMARR78 Replacing DIT Field("Created By")

                if User.FindFirst() then;
                if Vendor.Get("Buy-from Vendor No.") then;
                //<<HEI.01

                if LogInteraction then
                    if not CurrReport.Preview then begin
                        if "Buy-from Contact No." <> '' then
                            SegManagement.LogDocument(
                              22, "No.", 0, 0, Database::Contact, "Buy-from Contact No.", "Purchaser Code", '', "Posting Description", '')
                        else
                            SegManagement.LogDocument(
                              22, "No.", 0, 0, Database::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '')
                    end;

                //>>HEI.02
                if "Currency Code" = '' then
                    LCYCode := GLSetup."LCY Code"
                else
                    LCYCode := "Currency Code";
                //<<HEI.02

                //HEI.10>>
                if "Payment Terms Code" = '' then
                    PaymentTerms.Init()
                else begin
                    PaymentTerms.Get("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;
                //HEI.10<<
                //>>HEI.11
                if PurchaseReasonCode.Get("Purch. Reason Code FND") then
                    ReasonCodeDescription := PurchaseReasonCode.Description;
                //<<HEI.11
                // HEI.14 >>
                Clear(LicenseCode);

                PurchHdrAddRec.Reset();
                PurchHdrAddRec.SetRange("Document Type", "Purchase Header"."Document Type");
                PurchHdrAddRec.SetRange("No.", "Purchase Header"."No.");
                if PurchHdrAddRec.FindFirst() then
                    LicenseCode := PurchHdrAddRec."License Code";

                PurchasesPayablesSetup.Get();
                PurchasesPayablesSetup.CalcFields("PO Legal Text FND", "PO Legal Txt International FND");
                PurchasesPayablesSetup.CalcFields("Footer Text FND", "Footer Text International FND");
                if Vendor."Language Code" <> 'FRA' then begin
                    if PurchasesPayablesSetup."Footer Text International FND".HasValue then begin
                        PurchasesPayablesSetup."Footer Text International FND".CreateInStream(MemoReader_1);
                        FooterText.Read(MemoReader_1);
                    end;
                end else begin
                    if PurchasesPayablesSetup."Footer Text FND".HasValue then begin
                        PurchasesPayablesSetup."Footer Text FND".CreateInStream(MemoReader_1);
                        FooterText.Read(MemoReader_1);
                    end;
                end;

                CountyRegionRec.Reset();
                if CountyRegionRec.Get("Purchase Header"."Ship-to Country/Region Code") then;

                if ("Purchase Header"."Ship-to Address" <> '') and ("Purchase Header"."Ship-to Address 2" <> '') then begin
                    ShipToAdd1 := "Purchase Header"."Ship-to Address";
                    ShipToAdd2 := "Purchase Header"."Ship-to Address 2";
                    ShipToCity := "Purchase Header"."Ship-to City";
                    ShipToPost := "Purchase Header"."Ship-to Post Code";
                end else begin
                    Vendor.Reset();
                    if Vendor.Get("Purchase Header"."Buy-from Vendor No.") then begin
                        ShipToAdd1 := Vendor.Address;
                        ShipToAdd2 := Vendor."Address 2";
                        ShipToCity := Vendor.City;
                        ShipToPost := Vendor."Post Code";
                    end;
                end;

                if CompanyInfo."Registration No." <> '' then
                    CRTxtLbl := 'CR: ' + CompanyInfo."Registration No." + ' ;';

                Clear(LicenseCode);

                PurchHdrAddRec.Reset();
                PurchHdrAddRec.SetRange("Document Type", "Purchase Header"."Document Type");
                PurchHdrAddRec.SetRange("No.", "Purchase Header"."No.");
                if PurchHdrAddRec.FindFirst() then
                    LicenseCode := PurchHdrAddRec."License Code";

                //HEI.14 <<
                // if UserSetup.GET("Purchase Header"."Created By") then;//HEI.16 //BC Upgrade KUMARR78 Blocking Field("Created By")
                if UserSetup.GET("Purchase Header".SystemCreatedBy) then;//HEI.16 //BC Upgrade KUMARR78 Replacing Field("Created By")

            end;

            trigger OnPreDataItem();
            begin
                Clear(CRTxtLbl);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = all;//BC Upgrade KUMARR78 Adding ApplicationArea
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = all;//BC Upgrade KUMARR78 Adding ApplicationArea
                        Caption = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = all;//BC Upgrade KUMARR78 Adding ApplicationArea
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
        var
        enumvalue:Enum "Interaction Log Entry Document Type";
        begin
            //LogInteraction := SegManagement.FindInteractTmplCode(22) <> ''; //BC UPGRADE KUMARR78-Field missing in Table
            LogInteraction := SegManagement.FindInteractionTemplateCode(enumvalue::"Purch. Return Ord. Cnfrmn.") <> ''; //BC UPGRADE KUMARR78-replaced this field
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
        CompanyInfo.CalcFields(Picture);
        //<<HEI.01
    end;

    var
        CompanyInfo: Record "Company Information";
        CountyRegionRec: Record "Country/Region";
        CurrExchRate: Record "Currency Exchange Rate";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        Item: Record Item;
        // Language: Record Language; //BC UPGRADE KUMARR78 Blocking Table Variable as Function Moved from Record to Codeunit.
        LanguageG: Codeunit Language;//BC UPGRADE KUMARR78 Adding Codeunit as Function Moved from Record to Codeunit.

        PaymentTerms: Record "Payment Terms";
        PurchHdrAddRec: Record "Purchase Header Additional FND";
        PurchLine: Record "Purchase Line" temporary;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        ReasonCode: Record "Reason Code";
        ReasonCodeRec: Record "Reason Code";
        PurchaseReasonCode: Record "Reason Code_Purchase FND";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        User: Record User;
        UserSetup: Record "User Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        Vendor: Record Vendor;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        PurchPost: Codeunit "Purch.-Post";
        SegManagement: Codeunit SegManagement;
        FooterText: BigText;
        Continue: Boolean;
        LogInteraction: Boolean;
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
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
        // StringHelper: DotNet "'mscorlib'.System.String"; //BC Upgrade KUMARR78 Blocking Dot Net
        MemoReader_1: InStream;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        TypeInt: Integer;
        Client: Label 'Client';
        HdrDimsCaptionLbl: Label 'Header Dimensions';
        LegalTextBox: Label 'THIS MERCHANDISE WILL BE INSURED BY US OUR FLOTING POLICY No.07-02-250473-0 N .  All foreign remitted payment for professional services must be subject to withholding tax of. 0 According to Article 133 of Panamanian Tax Code.  Commercial invoice must bear the following certification signed by and authorized person in your oganization: ¨Conste bajo la gravedad del juramento, que todos los datos expresados en esta factura son exactos y verdaderos.¨';
        LineDimsCaptionLbl: Label 'Line Dimensions';
        PaymentDetailsCaptionLbl: Label 'Payment Details';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        PrepmtInvBuDescCaptionLbl: Label 'Description';
        PrepmtInvBufGLAccNoCaptionLbl: Label 'G/L Account No.';
        PrepymtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification';
        Text005: Label 'Page %1';
        Text007: Label '"VAT Amount Specification in "';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        VendNoCaptionLbl: Label 'Vendor No.';
        CRTxtLbl: Text;
        LicenseCode: Text;
        ShipToAdd1: Text;
        ShipToAdd2: Text;
        ShipToCity: Text;
        ShipToPost: Text;
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
        ApprovedBy: TextConst ENU = 'Approved by:', ESP = 'Aprobado por:', FRA = 'Approuvé par:';
        ContactPerson: TextConst ENU = 'Contact person:', ESP = 'Persona de Contacto:', FRA = 'Personne à contacter:';
        ContractContactPerson: TextConst ENU = 'Contract Contact Person:', ESP = 'Contacto:', FRA = 'Personne à contacter:';
        CR: TextConst ENU = 'CR:', ESP = 'CR:', FRA = 'CR:';
        Currency: TextConst ENU = 'Currency:', ESP = 'Moneda:', FRA = 'Devise:';
        DeliveryDate: TextConst ENU = 'Delivery Date:', ESP = 'Fecha de Entrega:', FRA = 'Date de Livraison:';
        DeliveryTerms: TextConst ENU = 'Delivery Terms:', ESP = 'Términos de entrega:', FRA = 'Conditions de Livraison:';
        DocumentDate: TextConst ENU = 'Document Date:', ESP = 'Fecha del documento:', FRA = 'Date de document:';
        EUVATNumber: TextConst ENU = 'VAT Number:', ESP = 'EU VAT Number:', FRA = 'Numero TVA:', NLD = 'Omzetbelastingnummer:';
        Incoterms: TextConst ENU = 'Incoterms:', ESP = 'Incoterms:', FRA = 'Incoterms:';
        ItemCaption: TextConst ENU = 'Item', ESP = 'Artículo', FRA = 'Article';
        LastChangedUsrTxt: TextConst ENU = 'Last Changed User ID:', FRA = ' ID utilisateur modifié en dernier:';
        LegalContractReference: TextConst ENU = 'Legal Contract Reference:', ESP = 'Referencia legal del contrato:', FRA = 'Référence du contrat legal:';
        LicenseCodeLbl: TextConst ENU = 'License Code:', FRA = 'Code de licence:';
        MachinerefNo: TextConst ENU = 'Machine Reference Number', ESP = 'Machine Reference Number', FRA = 'Machine Reference Number';
        Material: TextConst ENU = 'Material', ESP = 'Material', FRA = 'Matériel';
        MaterialDescription: TextConst ENU = 'Material Description', ESP = 'Descripción del material', FRA = 'Description du matériel';
        NetPrice: TextConst ENU = 'Net Price', ESP = 'Precio Neto', FRA = 'Prix Net';
        NetValue: TextConst ENU = 'Net Value', ESP = 'Valor Neto', FRA = 'Valeur Nette';
        OperationalContractRef: TextConst ENU = 'Operational Contract ref:', ESP = 'Referencia del contrato operacional:', FRA = 'Référence du contrat opérationnel:';
        OrderingParty: TextConst ENU = 'ORDERING PARTY:', ESP = 'COMPAÑÍA QUE ORDENA:', FRA = 'DONNEUR D''ORDRE:';
        PageCaption: TextConst ENU = 'Page', ESP = 'Página', FRA = 'Page';
        PaymentTermsCaption: TextConst ENU = 'Payment Terms:', ESP = 'Términos de Pago:', FRA = 'Conditions de Paiements:';
        Phone: TextConst ENU = 'Phone:', ESP = 'Teléfono:', FRA = 'Téléphone:';
        PlantOpeningHrs: TextConst ENU = 'Plant opening hrs:', ESP = 'Horario:', FRA = 'Horaires d''ouverture du site:';
        PleaseDeliverGoodsTo: TextConst ENU = 'PLEASE RETURN GOODS TO:', ESP = 'FAVOR ENTREGAR MERCANCÍA A:', FRA = 'VEUILLEZ LIVRER LES MARCHANDISES À:';
        PleaseDeliverInvoiceTo: TextConst ENU = 'PLEASE DELIVER INVOICE TO:', ESP = 'FAVOR ENTREGAR FACTURA A:', FRA = 'VEUILLEZ TRANSMETTRE LA FACTURE À:';
        PleaseSendaCreditNoteTo: TextConst ENU = 'PLEASE SEND A CREDIT NOTE TO:', FRA = 'VEUILLEZ ENVOYER UNE NOTE DE CRÉDIT À:';
        PurchaseOrderNo: TextConst ENU = 'Purchase Order Number:', FRA = 'Numéro de commande';
        PurchaseOrderValue: TextConst ENU = 'PURCHASE ORDER VALUE:', ESP = 'VALOR DEL PEDIDO:', FRA = 'VALEUR DE LA COMMANDE: ';
        QuantityCaption: TextConst ENU = 'Quantity', ESP = 'Cantidad', FRA = 'Quantité';
        ReasonCodeDescriptionLbl: TextConst ENU = 'Reason to Return:', FRA = 'Raison du retour:', FRB = 'Raison du retour:';
        ReportTitle: TextConst ENU = 'Return Order No.', ESP = 'Pedido de Devolución No.', FRA = 'Commande de Retour No.';
        Reprinted: TextConst ENU = 'Reprinted', ESP = 'Reimpreso', FRA = 'Réimprimé';
        RequesterIDTxt: TextConst ENU = 'Requester ID:', FRA = 'ID du demandeur:';
        TaxIdentification: TextConst ENU = 'Tax Identification:', ESP = 'Número de Identificación de Impuestos:', FRA = 'Numero Identifiant Fiscal:';
        TaxIdentificationNumber: TextConst ENU = 'Tax Identification Number:', ESP = 'Número de Identificación de Impuestos:', FRA = 'Numero Identifiant Fiscal:';
        Text004: TextConst Comment = '%1 = Document No.', ENU = 'Return Order %1';
        ToVendorAccountingdepLbl: TextConst ENU = 'To: Vendor Accounting dep.:', FRA = 'À: Comptabilité fournisseur dep.:', FRB = 'À: Comptabilité fournisseur dep.:';
        UoM: TextConst ENU = 'UoM', ESP = 'Unidad de Medición', FRA = 'Unité de mesure';
        VAT: TextConst ENU = 'VAT:', ESP = 'VAT:', FRA = 'VAT:';
        VendorCaption: TextConst ENU = 'VENDOR:', ESP = 'PROVEEDOR:', FRA = 'FOURNISSEUR:';
        YourVendorNoWithUs: TextConst ENU = 'Your Vendor Number with us:', ESP = 'Su número de proveedor con nosotros:', FRA = 'Votre numéro de fournisseur avec nous:';

    local procedure FormatAddressFields(PurchaseHeader: Record "Purchase Header");
    begin
        //>>HEI.01
        //FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center",RespCenter,CompanyInfo,CompanyAddr);
        if RespCenter.Get(PurchaseHeader."Responsibility Center") then begin
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

        ReferenceText := FormatDocument.SetText(PurchaseHeader."Your Reference" <> '', PurchaseHeader.FieldCaption("Your Reference"));
        VATNoText := FormatDocument.SetText(PurchaseHeader."VAT Registration No." <> '', PurchaseHeader.FieldCaption("VAT Registration No."));
    end;
}

