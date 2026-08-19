report 53028 "Export Invoice BA"
{
    // version HEI.03
    // HNK100069 MRA-IBM 18/09/15: Adapting report to Free Goods Sales, amount must show 0 in item line and negative free goods line should not show
    // 
    // HEI.01 FDD-LB-GAPLOG04 IBM NASTAA02 25.07.2018 # Order Confirmation Almaza, Proforma Invoice and Export Invoice
    //   # Merged Report 50005 from HEI2.0 and modified the layout
    // 
    // HEI.02 FDD-BA-LOGGAP04 IBM NASTAA02 24.08.2018 # Export Invoice
    //   # Copied Report 50129 - Export Invoice ALM and created dataset and layout according to Bahamas requirements
    // HEI.03 FDD-BA-LOGGAP03 IBM NASTAA02 23.10.2018 # Sales Invoice and Sales Credit Memo Layout
    //   # Added Reprinted to the layout when the Report is printed to the printer
    //****************************************//
    //BC UPGRADE ATHUKS01//
    //1. HEI.01 No changes
    //2. HEI.02 No changes.
    //3. HEI.03  No changes.
    //4. Commented dirink IT fields & Commented BaseField "Archive Quotes and Orders() is removed &
    //Commented method FindInteractTmplCode changed in Codeunit SegManagement.
    //Used LanguageMgt codeunit  for dispaly report in diff language.
    //5.Old Report ID 50171. 
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Export Invoice BA.rdl';

    Caption = 'Export Invoice BA';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeadingML = ENU = 'Sales Invoice',
                                     FRA = 'commande vente';
            column(SalesHeader_DocumentNo; "No.")
            {
            }
            column(Reprinted; Reprinted)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfo_FaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    //BC UPGRADE ATHUKS01 << Drink IT Field
                    // column(CompanyInfo_TIN; CompanyInfo."Tax Registration No.")
                    // {
                    // }
                    // BC UPGRADE ATHUKS01 >> Drink IT Field
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(SalesHeader_PostingDate; "Sales Invoice Header"."Posting Date")
                    {
                    }
                    column(SalesHeader_BillToCustomerNo; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(SalesHeader_YourReference; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(Paymentterms_Description; PaymentTerms.Description)
                    {
                    }
                    column(SalesHeader_DueDate; "Sales Invoice Header"."Due Date")
                    {
                    }
                    column(ShipmentMethod_Description; ShipmentMethod.Description)
                    {
                    }
                    // BC UPGRADE ATHUKS01  << Drink IT field
                    // column(Customer_TIN; Customer."Tax Registration No.")
                    // {
                    // }
                    // BC UPGRADE ATHUKS01  >> Drink IT field
                    column(Cust_BillToAddr1; CustAddr[1])
                    {
                    }
                    column(Cust_BillToAddr2; CustAddr[2])
                    {
                    }
                    column(Cust_BillToAddr3; CustAddr[3])
                    {
                    }
                    column(Cust_BillToAddr4; CustAddr[4])
                    {
                    }
                    column(Cust_BillToAddr5; CustAddr[5])
                    {
                    }
                    column(Cust_BillToAddr6; CustAddr[6])
                    {
                    }
                    column(Cust_BillToAddr7; CustAddr[7])
                    {
                    }
                    column(Cust_BillToAddr8; CustAddr[8])
                    {
                    }
                    column(VATAmount; VATAmount)
                    {
                    }
                    column(VATBaseAmount; VATBaseAmount)
                    {
                    }
                    column(TotalAmountInclVAT; TotalAmountInclVAT)
                    {
                    }
                    column(TotalDiscounts; TotalDiscounts)
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(SalesLine_LineNo; "Line No.")
                        {
                        }
                        column(SalesLine_No; "No.")
                        {
                        }
                        column(SalesLine_Description; Description)
                        {
                        }
                        column(SalesLine_Qty; Quantity)
                        {
                        }
                        column(SalesLine_UoM; "Unit of Measure Code")
                        {
                        }
                        column(SalesLine_VATIdentifier; "VAT %")
                        {
                        }
                        column(SalesLine_UnitPrice; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(SalesLine_LineAmount; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Type_SalesLine; FORMAT(Type))
                        {
                        }
                        column(SalesLineType; Type)
                        {
                        }
                        column(SalesLineAmt; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(NetWeight; NetWeight)
                        {
                        }
                        column(SalesLineAmtExclLineDisc; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        dataitem(UnderLineCharges; "Integer")
                        {
                            column(No_TempUnderChargeLine; TempUnderChargeLine."No.")
                            {
                                IncludeCaption = true;
                            }
                            column(Description_TempUnderChargeLine; TempUnderChargeLine.Description)
                            {
                                IncludeCaption = true;
                            }
                            column(Quantity_TempUnderChargeLine; TempUnderChargeLine.Quantity)
                            {
                                IncludeCaption = true;
                            }
                            column(UnitPrice_TempUnderChargeLine; TempUnderChargeLine."Unit Price")
                            {
                            }
                            column(LineAmount_TempUnderChargeLine; TempUnderChargeLine."Line Amount")
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                //HEI.01>>
                                if Number = 1 then
                                    TempUnderChargeLine.FINDFIRST()
                                else
                                    TempUnderChargeLine.NEXT();
                                //HEI.01<<
                            end;

                            trigger OnPostDataItem();
                            begin
                                //HEI.01>>
                                TempUnderChargeLine.RESET();
                                TempUnderChargeLine.DELETEALL();
                                //HEI.01<<
                            end;

                            trigger OnPreDataItem();
                            begin
                                //HEI.01>>
                                TempUnderChargeLine.RESET();
                                TempUnderChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                                SETRANGE(Number, 1, TempUnderChargeLine.COUNT);
                                //HEI.01<<
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            InventorySetup: Record "Inventory Setup";
                            //MasterDataProperty: Record "Master Data Property"; //BC UPGRADE ATHUKS01
                            SalesChargeLine: Record "Sales Line";
                        begin
                            //HEI.01>>
                            //Discounts under item line
                            CLEAR(PrintUnderLineCharge);
                            SalesChargeLine.RESET();
                            SalesChargeLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                            SalesChargeLine.SETRANGE(Type, "Sales Invoice Line".Type::"Charge (Item)");
                            //BC UPGRADE ATHUKS01 << Drink IT Field
                            //SalesChargeLine.SETFILTER("Item Charge Type", '%1|%2', "Sales Invoice Line"."Item Charge Type"::Discount, "Sales Invoice Line"."Item Charge Type"::Tax);
                            //SalesChargeLine.SETRANGE("Show Item charge on Invoice", SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                            //BC UPGRADE ATHUKS01 >> Drink IT Field
                            SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Invoice Line"."Line No.");
                            if SalesChargeLine.FINDSET() then
                                repeat
                                    if not PrintUnderLineCharge then
                                        PrintUnderLineCharge := true;
                                    TempUnderChargeLine.INIT();
                                    TempUnderChargeLine := SalesChargeLine;
                                    TempUnderChargeLine.INSERT();
                                until (SalesChargeLine.NEXT() = 0);
                            //HEI.01<<
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine_VATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine_VATPerc; VATAmountLine."VAT %")
                        {
                        }
                        column(VATAmountLine_VATAmount; VATAmountLine."VAT Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATBase; VATAmountLine."VAT Base")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem();
                        begin
                            VATAmountLine.RESET();
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                var
                    PrepmtSalesLine: Record "Sales Line" temporary;
                    SalesPost: Codeunit "Sales-Post";
                    TempSalesLine: Record "Sales Line" temporary;
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    VATAmountLine.DELETEALL();
                    SalesLine.DELETEALL();
                    //HEI.02>>
                    //SalesPost.GetSalesLines("Sales Header",SalesLine,0);
                    //SalesLine.CalcVATAmountLines(0,"Sales Header",SalesLine,VATAmountLine);
                    //SalesLine.UpdateVATOnLines(0,"Sales Header",SalesLine,VATAmountLine);
                    //VATAmount := VATAmountLine.GetTotalVATAmount;

                    VATAmountLine.DELETEALL();
                    SalesInvLine.CalcVATAmountLines("Sales Invoice Header", VATAmountLine);
                    VATAmount += VATAmountLine."VAT Amount";

                    VATBaseAmount := VATAmountLine.GetTotalVATBase();
                    //VATDiscountAmount := VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code","Sales Header"."Prices Including VAT"); HEI.02
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT();
                    TotalDiscounts += SalesLine."Inv. Discount Amount"; //HEI.02

                    if Number > 1 then begin
                        CopyText := Text003;
                        OutputNo += 1;
                    end;
                    CurrReport.PAGENO := 1;
                end;

                trigger OnPostDataItem();
                var
                    SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
                begin
                    if Print then
                        SalesInvCountPrinted.RUN("Sales Invoice Header"); //HEI.02
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
            var
                Customer2: Record Customer;
                Customer3: Record Customer;
                Customer4: Record Customer;
                BankAccount: Record "Bank Account";
                DocumentSendingProfile: Record "Document Sending Profile";
                OrderChargeLine: Record "Sales Line";
                PrintOrderDiscounts: Boolean;
                PrintOrderDeposits: Boolean;
                PrintOrderTaxes: Boolean;
            begin
                Reprinted := "No. Printed" > 0; //HEI.03
                Customer.GET("Bill-to Customer No."); //HEI.02

                FormatAddr.Company(CompanyAddr, CompanyInfo);

                if PaymentTerms.GET("Payment Terms Code") then
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");

                if ShipmentMethod.GET("Shipment Method Code") then
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");

                //HEI.02>>
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                FormatAddr.SalesInvShipTo(CustSellAddr, CustAddr, "Sales Invoice Header");
                //HEI.02<<

                if not CustomerBankAcc.GET("Bill-to Customer No.", BillToCust."Preferred Bank Account Code") then begin
                    CustomerBankAcc.SETRANGE("Customer No.", "Bill-to Customer No.");
                    if not CustomerBankAcc.FINDFIRST() then
                        CustomerBankAcc.INIT();
                end;
            end;

            trigger OnPreDataItem();
            begin
                Print := Print or not CurrReport.PREVIEW;
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
                                FRA = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = ALL;
                        ToolTip = 'No. of Copies';


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
            //ArchiveDocument := SalesSetup."Archive Quotes and Orders()";
            ArchiveDocument := SalesSetup."Archive Orders";
            //BC UPGRADE ATHUKS01<< Field 37 Not Exist BC

            //BC UPGRADE ATHUKS01 >> ChangeMethodName
            //LogInteraction := SegManagement.FindInteractTmplCode(3) <> '';
            LogInteraction := SegManagement.FindInteractionTemplateCode(enumvalue::"Sales Ord. Cnfrmn.") <> '';
            //BC UPGRADE ATHUKS01<<ChangeMethodName
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
        GrossweightLbl = 'Gross Weight Kg'; NetWeightLbl = 'Net Weight Kg'; PackingLbl = 'Packing'; GrandTotLbl = 'Grand Total'; TotAmtLbl = 'Total Amt.'; ExpManSignLbl = 'Export Manager Signature'; CustSignLbl = 'Customer Signature'; OfficialDocsLbl = 'Official Documents'; UOMLbl = 'UOM'; TelLbl = 'TEL:'; FaxLbl = 'FAX:'; TINLbl = 'TIN:'; ReportNameLbl = 'VAT Invoice'; InvoiceToLbl = 'Invoice to:'; InvoiceNoLbl = 'Invoice No.'; InvoiceDateLbl = 'Invoice Date'; CustomerCodeLbl = 'Customer Code'; YourReferenceLbl = 'Your Reference'; PaymentTermLbl = 'Payment Term'; DueDateLbl = 'Due Date'; DeliveryLbl = 'Delivery'; CustomerTINLbl = 'Customer TIN'; ItemLbl = 'Item'; DescriptionLbl = 'Description'; QtyLbl = 'Qty'; UnitLbl = 'Unit'; VATLbl = 'VAT'; UnitPriceLbl = 'Unit Price'; NetAmountLbl = 'Net Amount'; VATSpecificationLbl = 'VAT Specification'; VATRateLbl = 'VAT Rate'; BaseLbl = 'Base'; TotalAmountLbl = 'Total Amount'; SubtotalLbl = 'Subtotal'; TotalToBePaidLbl = 'Total to be paid'; FooterTextLbl = 'ALL CLAIMS OR RETURNED GOODS MUST BE ACCOMPANIED BY THIS INVOICE. AN ORIGINAL RECEIPT MUST BE ISSUED FOR ANY PAYMENT MADE TO A COMPANY REPRESENTATIVE.'; ReprintedLbl = 'Reprinted';
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        SalesSetup.GET();
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture); //HEI.02
    end;

    var
        Text000: TextConst ENU = 'Salesperson', FRA = 'Vendeur';
        Text001: TextConst ENU = 'Total %1', FRA = 'Total %1';
        Text002: TextConst ENU = 'Total %1 Incl. VAT', FRA = 'Total %1 TTC';
        Text003: TextConst ENU = 'COPY', FRA = 'COPIE';
        Text004: TextConst ENU = 'Invoice %1', FRA = 'Facture %1';
        PageCaptionCap: TextConst ENU = 'Page %1 of %2', FRA = 'Page %1 de %2';
        Text006: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 HT';
        StCustTextCodes: Record "Standard Customer Sales Code";
        Item: Record Item;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        CountryRegion: Record "Country/Region";
        VATAmountLine: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        ShipTo: Record "Ship-to Address";
        ExitPoints: Record "Entry/Exit Point";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        LanguageR: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        Comments: Record "Comment Line";
        BillToCust: Record Customer;
        lrecCust: Record Customer;
        lrecshiptoadd: Record "Ship-to Address";
        CustomerBankAcc: Record "Customer Bank Account";
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
        DimMgt: Codeunit DimensionManagement;
        Check: Report Check;
        CustAddr: array[8] of Text[50];
        FinalDestination: Text[50];
        CustSellAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        BeerTariff: Text[80];
        BeveragesTariff: Text[80];
        ProdComment: array[6] of Text[80];
        Cust_footer: array[5] of Text[80];
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
        Text007: TextConst ENU = 'VAT Amount Specification in ', FRA = 'Détail TVA dans ';
        Text008: TextConst ENU = 'Local Currency', FRA = 'Devise société';
        Text009: TextConst ENU = 'Exchange rate: %1/%2', FRA = 'Taux de change : %1/%2';
        VALExchRate: Text[50];
        OutputNo: Integer;
        NNCTotalLCY: Decimal;
        NNCTotalExclVAT: Decimal;
        NNCVATAmt: Decimal;
        NNCTotalInclVAT: Decimal;
        NNCPmtDiscOnVAT: Decimal;
        NNCTotalInclVAT2: Decimal;
        NNCVATAmt2: Decimal;
        NNCTotalExclVAT2: Decimal;
        NNCSalesLineLineAmt: Decimal;
        NNCSalesLineInvDiscAmt: Decimal;
        Print: Boolean;

        ArchiveDocumentEnable: Boolean;

        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        PayToOrderCaptionLbl: Label 'Please Pay to the Order:';
        InvDiscAmtCaptionLbl: TextConst ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        GiroNoCaptionLbl: TextConst ENU = 'Giro No.', FRA = 'N° CCP';
        BankCaptionLbl: TextConst ENU = 'Bank', FRA = 'Banque';
        AccountNoCaptionLbl: TextConst ENU = 'Account No.', FRA = 'N° compte';
        ShipmentDateCaptionLbl: TextConst ENU = 'Shipment Date', FRA = 'Date d''expédition';
        QuoteNoCaptionLbl: TextConst ENU = 'Proforma Invoice No.:', FRA = 'N° commande proforma:';
        HomePageCaptionCap: TextConst ENU = 'Home Page', FRA = 'Page d''accueil';
        EmailCaptionLbl: TextConst ENU = 'E-Mail', FRA = 'E-mail';
        HeaderDimCaptionLbl: TextConst ENU = 'Header Dimensions', FRA = 'Analytique en-tête';
        DiscountPercentCaptionLbl: TextConst ENU = 'Discount %', FRA = '% remise';
        SubtotalCaptionLbl: TextConst ENU = 'Subtotal', FRA = 'Sous-total';
        PaymentDiscountVATCaptionLbl: TextConst ENU = 'Payment Discount on VAT', FRA = 'Escompte sur TVA';
        LineDimCaptionLbl: TextConst ENU = 'Line Dimensions', FRA = 'Analytique ligne';
        InvDiscBaseAmtCaptionLbl: TextConst ENU = 'Invoice Discount Base Amount', FRA = 'Montant base remise facture';
        VATIdentifierCaptionLbl: TextConst ENU = 'VAT Identifier', FRA = 'Identifiant TVA';
        ShiptoAddrCaptionLbl: TextConst ENU = 'Ship-to Address', FRA = 'Adresse destinataire';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        GLAccountNoCaptionLbl: TextConst ENU = 'G/L Account No.', FRA = 'N° compte général';
        PrepaymentSpecCaptionLbl: TextConst ENU = 'Prepayment Specification', FRA = 'Spécification acompte';
        PrepaymentVATAmtSpecCapLbl: TextConst ENU = 'Prepayment VAT Amount Specification', FRA = 'Spécification montant TVA acompte';
        PrepmtPmtTermsDescCaptionLbl: TextConst ENU = 'Prepmt. Payment Terms', FRA = 'Conditions paiement acompte';
        PhoneNoCaptionLbl: TextConst ENU = 'Phone:', FRA = 'N° téléphone';
        FaxNoCaptionLbl: Label 'Fax:';
        AmountCaptionLbl: TextConst ENU = 'Amount', FRA = 'Montant';
        VATPercentageCaptionLbl: TextConst ENU = 'VAT', FRA = '%1% TVA';
        VATBaseCaptionLbl: TextConst ENU = 'VAT Base', FRA = 'Base TVA';
        VATAmtCaptionLbl: TextConst ENU = 'VAT Amount', FRA = 'Montant TVA';
        VATAmtSpecCaptionLbl: TextConst ENU = 'VAT Amount Specification', FRA = 'Détail montant TVA';
        LineAmtCaptionLbl: TextConst ENU = 'Line Amount', FRA = 'Montant ligne';
        TotalCaptionLbl: TextConst ENU = 'Total', FRA = 'Total';
        UnitPriceCaptionLbl: TextConst ENU = 'Unit Price', FRA = 'Prix unitaire';
        PaymentTermsCaptionLbl: TextConst ENU = 'Payment Terms:', FRA = 'Conditions de paiement:';
        ShipmentMethodCaptionLbl: TextConst ENU = 'Terms of Sales:', FRA = 'Conditions de livraison:';
        DocumentDateCaptionLbl: TextConst ENU = 'Date:', FRA = 'Date document:';
        AllowInvDiscCaptionLbl: TextConst ENU = 'Allow Invoice Discount', FRA = 'Autoriser remise facture';
        CustPONoLbl: TextConst ENU = 'Customer PO No.:', FRA = 'Nº commande achat client:';
        ReqDelDateCaptionLbl: TextConst ENU = 'Requested Delivery Date:', FRA = 'Date livraison demandée:';
        CurrencyCaptionLbl: TextConst ENU = 'Currency:', FRA = 'Devise:';
        BillToCustCaptionLbl: TextConst ENU = 'CUSTOMER', FRA = 'CLIENT';
        SellToCustCaptionLbl: TextConst ENU = 'CONSIGNEE', FRA = 'CONSIGNEE';
        ShipToCustCaptionLbl: TextConst ENU = 'NOTIFY', FRA = 'NOTIFY';
        IbanCaptionLbl: TextConst ENU = 'IBAN No.:', FRA = 'Nº IBAN:';
        SwiftCaptionLbl: TextConst ENU = 'SWIFT Code:', FRA = 'Code  SWIFT:';
        PhoneBillTo: Text[30];
        FaxBillTo: Text[30];
        PhoneSellTo: Text[30];
        FaxSellTo: Text[30];
        PhoneShipTo: Text[30];
        FaxShipTo: Text[30];
        NameCaptionLbl: Label 'Name:';
        NoCaptionLbl: Label 'No.:';
        AddressCaptionLbl: Label 'Address:';
        GrossWeight: Decimal;
        NetWeight: Decimal;
        PackingCaptionLbl: Label 'Packing';
        StandardCustText: Text[50];
        Text026: TextConst ENU = 'ZERO', FRA = 'ZERO';
        Text027: TextConst ENU = 'HUNDRED', FRA = 'CENT';
        Text028: TextConst ENU = 'AND', FRA = 'ET';
        Text029: TextConst ENU = '%1 results in a written number that is too long.', FRA = '%1 résultat(s) en toutes lettres trop long(s).';
        Text032: TextConst ENU = 'ONE', FRA = 'UN';
        Text033: TextConst ENU = 'TWO', FRA = 'DEUX';
        Text034: TextConst ENU = 'THREE', FRA = 'TROIS';
        Text035: TextConst ENU = 'FOUR', FRA = 'QUATRE';
        Text036: TextConst ENU = 'FIVE', FRA = 'CINQ';
        Text037: TextConst ENU = 'SIX', FRA = 'SIX';
        Text038: TextConst ENU = 'SEVEN', FRA = 'SEPT';
        Text039: TextConst ENU = 'EIGHT', FRA = 'HUIT';
        Text040: TextConst ENU = 'NINE', FRA = 'NEUF';
        Text041: TextConst ENU = 'TEN', FRA = 'DIX';
        Text042: TextConst ENU = 'ELEVEN', FRA = 'ONZE';
        Text043: TextConst ENU = 'TWELVE', FRA = 'DOUZE';
        Text044: TextConst ENU = 'THIRTEEN', FRA = 'TREIZE';
        Text045: TextConst ENU = 'FOURTEEN', FRA = 'QUATORZE';
        Text046: TextConst ENU = 'FIFTEEN', FRA = 'QUINZE';
        Text047: TextConst ENU = 'SIXTEEN', FRA = 'SEIZE';
        Text048: TextConst ENU = 'SEVENTEEN', FRA = 'DIX-SEPT';
        Text049: TextConst ENU = 'EIGHTEEN', FRA = 'DIX-HUIT';
        Text050: TextConst ENU = 'NINETEEN', FRA = 'DIX-NEUF';
        Text051: TextConst ENU = 'TWENTY', FRA = 'VINGT';
        Text052: TextConst ENU = 'THIRTY', FRA = 'TRENTE';
        Text053: TextConst ENU = 'FORTY', FRA = 'QUARANTE';
        Text054: TextConst ENU = 'FIFTY', FRA = 'CINQUANTE';
        Text055: TextConst ENU = 'SIXTY', FRA = 'SOIXANTE';
        Text056: TextConst ENU = 'SEVENTY', FRA = 'SOIXANTE-DIX';
        Text057: TextConst ENU = 'EIGHTY', FRA = 'QUATRE-VINGT';
        Text058: TextConst ENU = 'NINETY', FRA = 'QUATRE-DIX';
        Text059: TextConst ENU = 'THOUSAND', FRA = 'MILLE';
        Text060: TextConst ENU = 'MILLION', FRA = 'MILLION';
        Text061: TextConst ENU = 'BILLION', FRA = 'MILLIARD';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        Shipmentde: Text[100];
        DescriptionLine: array[2] of Text[85];
        VATPerc: Text[30];
        Vat: Text[20];
        VATPer: Decimal;
        VATNISLabel: Text[20];
        TotalQuantity: Decimal;
        SellToCity: Text[30];
        InvoiceNoLbl: Label 'Invoice No.';
        FinalDestinationLbl: Label 'Final Destination';
        ExtendedTextLine: Record "Extended Text Line";
        ExtendedTextLine2: Record "Extended Text Line";
        ExtendedTextFooterBuffer: Record "Extended Text Line" temporary;
        ExtendedTextHeader: array[8] of Text[300];
        IBANNo: Code[50];
        SwiftNo: Code[20];
        PackingPropertyName: Text[50];
        TempUnderChargeLine: Record "Sales Line" temporary;
        TempOrderTaxCharge: Record "Sales Line" temporary;
        TempOrderDiscountCharge: Record "Sales Line" temporary;
        TempOrderDepositCharge: Record "Sales Line" temporary;
        SubTotal: Decimal;
        TotalSubTotal: Decimal;
        PrintUnderLineCharge: Boolean;
        TotalDiscounts: Decimal;
        TotalDeposits: Decimal;
        TotalTaxes: Decimal;
        TotalNetWeight: Decimal;
        NetAmountLbl: Label 'Net Amount';
        Customer: Record Customer;
        SalesInvLine: Record "Sales Invoice Line";
        Reprinted: Boolean;
}

