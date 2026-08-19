report 51014 "Load List OrderTNG CBN"
{
    // version DITW110.00.11,HEI.02

    // DITW17.00.02 RPG 28/11/2013 DIT-770 #235 New Report for Delivery Note from Order
    // DITW17.10.03 MSF 31/03/2014 DIT-770 #549  :Upgrade from  be updated from DIT DE 2013 OPP
    // DITW17.10.03 VSC 16/04/2014 DIT-770 #579: Fixes testreport
    // DITW17.10.05 MSF 20/10/2014 DIT-770 #831 Change Id of table 2014577 to  2035391
    // DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 "Trailer Code"
    // DITW18.00.06 MSF 26/06/2015 DIT-770 #1278 in the preview mode it should not set the shipment status
    // DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    // DITW18.00.07 DDR 11/04/2016 DIT-770 #1488 Bugfix to update "shipment status" all printed
    // DITW18.00.07 DDR 29/04/2016 DIT-770 #1488 Review & Various bugfixes
    // DITW18.00.07 VSC 30/05/2016 DIT-770 #1488 Bugfix Change VAR
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 AKH 02/11/2017 NRQ#43605 Added Returned empties blocks based on "Fixed Block" option
    //                                        Added "Delivery Sequence" to the list of Sales Orders and adjusted sorting
    // HEI.01 FDD-SLSGAP001 IBM NASTAA02 07.09.2017 # MDM Customer Card
    //   # Increased "CustAddr" and "ShipToAddr" global variables length from 50 to 60 characters
    // FCE - Changed the Document name to "Orde de Chargement" as text constant
    // 
    // HEI.02 Defect #1369 IBM NASTAA02 12.03.2017 # Load List (Loading Note) Orde de Chargement
    //   # Added new fields in the header, layout improvements

    // BC Upgrade KUMARS145 Nav ID Report 50045 "Load List OrderTNG"

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Load List OrderTNG.rdl';

    CaptionML = ENU = 'Load List Order',
                FRA = 'Charger liste des commandes';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(SalesLineFilter; "Sales Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order));

            trigger OnPreDataItem();
            begin
                //only additional sales line filters
                // not used yet
                //CurrReport.BREAK;
            end;
        }
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            MaxIteration = 1;
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeadingML = ENU = 'Sales Order',
                                     FRA = 'Commande vente';
            column(DocType_SalesHeader; "Document Type") { }
            column(No_SalesHeader; "No.") { }
            column(SalesHeader_SellToCustomerNo; "Sell-to Customer No.") { }
            // BC Upgrade KUMARS145 Field dependent on Drinkit commented.....>>
            // column(Route_SalesHeader; Route) { }
            // column(TotalShortcutQtyUomValue1Caption; STRSUBSTNO(Text001, WarehouseSetup."Shortcut Unit of Measure1 Code")) { }
            // column(TotalShortcutQtyUomValue2Caption; STRSUBSTNO(Text001, WarehouseSetup."Shortcut Unit of Measure2 Code")) { }
            // column(TotalShortcutQtyUomValue3Caption; STRSUBSTNO(Text001, WarehouseSetup."Shortcut Unit of Measure3 Code")) { }
            column(Route_SalesHeader; '') { }
            column(TotalShortcutQtyUomValue1Caption; STRSUBSTNO(Text001)) { }
            column(TotalShortcutQtyUomValue2Caption; STRSUBSTNO(Text001)) { }
            column(TotalShortcutQtyUomValue3Caption; STRSUBSTNO(Text001)) { }
            // BC Upgrade KUMARS145 Field dependent on Drinkit commented.....<<
            column(PhoneNoCaption; PhoneNoCaptionLbl) { }
            column(AmountCaption; AmountCaptionLbl) { }
            column(VATPercentageCaption; VATPercentageCaptionLbl) { }
            column(VATBaseCaption; VATBaseCaptionLbl) { }
            column(VATAmtCaption; VATAmtCaptionLbl) { }
            column(VATAmtSpecCaption; VATAmtSpecCaptionLbl) { }
            column(LineAmtCaption; LineAmtCaptionLbl) { }
            column(TotalCaption; TotalCaptionLbl) { }
            column(UnitPriceCaption; UnitPriceCaptionLbl) { }
            column(PaymentTermsCaption; PaymentTermsCaptionLbl) { }
            column(ShipmentMethodCaption; ShipmentMethodCaptionLbl) { }
            column(DocumentDateCaption; DocumentDateCaptionLbl) { }
            column(AllowInvDiscCaption; AllowInvDiscCaptionLbl) { }
            column(TotalShortcutQtyUomValue1; TotalShortcutQtyUomValue[1])
            {
                DecimalPlaces = 0 : 5;
            }
            column(TotalShortcutQtyUomValue2; TotalShortcutQtyUomValue[2])
            {
                DecimalPlaces = 0 : 5;
            }
            column(TotalShortcutQtyUomValue3; TotalShortcutQtyUomValue[3])
            {
                DecimalPlaces = 0 : 5;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture) { }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture) { }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture) { }
                    column(OrderConfirmCopyCaption; STRSUBSTNO(Text004, CopyText)) { }
                    column(CustAddr1; CustAddr[1]) { }
                    column(CompanyAddr1; CompanyAddr[1]) { }
                    column(CustAddr2; CustAddr[2]) { }
                    column(CompanyAddr2; CompanyAddr[2]) { }
                    column(CustAddr3; CustAddr[3]) { }
                    column(CompanyAddr3; CompanyAddr[3]) { }
                    column(CustAddr4; CustAddr[4]) { }
                    column(CompanyAddr4; CompanyAddr[4]) { }
                    column(CustAddr5; CustAddr[5]) { }
                    column(CompanyInfoPhNo; CompanyInfo."Phone No.")
                    {
                        IncludeCaption = false;
                    }
                    column(CustAddr6; CustAddr[6]) { }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.") { }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.") { }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name") { }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page") { }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail") { }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.") { }
                    column(BilltoCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.") { }
                    column(DocDate_SalesHeader; FORMAT("Sales Header"."Document Date", 0, 4)) { }
                    column(VATNoText; VATNoText) { }
                    column(VATRegNo_SalesHeader; "Sales Header"."VAT Registration No.") { }
                    column(ShptDate_SalesHeader; FORMAT("Sales Header"."Shipment Date", 0, 4)) { }
                    column(SalesPersonText; SalesPersonText) { }
                    column(SalesPurchPersonName; SalesPurchPerson.Name) { }
                    column(ReferenceText; ReferenceText) { }
                    column(SalesOrderReference_SalesHeader; "Sales Header"."Your Reference") { }
                    column(CustAddr7; CustAddr[7]) { }
                    column(CustAddr8; CustAddr[8]) { }
                    column(CompanyAddr5; CompanyAddr[5]) { }
                    column(CompanyAddr6; CompanyAddr[6]) { }
                    column(PricesInclVAT_SalesHeader; "Sales Header"."Prices Including VAT") { }
                    column(PageCaption; STRSUBSTNO(Text005, '')) { }
                    column(OutputNo; OutputNo) { }
                    column(PmntTermsDesc; PaymentTerms.Description) { }
                    column(ShptMethodDesc; ShipmentMethod.Description) { }
                    column(PricesInclVATYesNo_SalesHeader; FORMAT("Sales Header"."Prices Including VAT")) { }
                    column(VATRegNoCaption; VATRegNoCaptionLbl) { }
                    column(GiroNoCaption; GiroNoCaptionLbl) { }
                    column(BankCaption; BankCaptionLbl) { }
                    column(AccountNoCaption; AccountNoCaptionLbl) { }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl) { }
                    column(OrderNoCaption; OrderNoCaptionLbl) { }
                    column(HomePageCaption; HomePageCaptionLbl) { }
                    column(EmailCaption; EmailCaptionLbl) { }
                    column(BilltoCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Bill-to Customer No.")) { }
                    column(PricesInclVAT_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Prices Including VAT")) { }
                    column(BarcodeValueLeft; BarcodeValueLeft) { }
                    column(BarcodeValueCenter; BarcodeValueCenter) { }
                    column(BarcodeValueRight; BarcodeValueRight) { }
                    column(ShiptoAddrCaption; ShiptoAddrCaptionLbl) { }
                    column(ShipToAddr1; ShipToAddr[1]) { }
                    column(ShipToAddr2; ShipToAddr[2]) { }
                    column(ShipToAddr3; ShipToAddr[3]) { }
                    column(ShipToAddr4; ShipToAddr[4]) { }
                    column(ShipToAddr5; ShipToAddr[5]) { }
                    column(ShipToAddr6; ShipToAddr[6]) { }
                    column(ShipToAddr7; ShipToAddr[7]) { }
                    column(ShipToAddr8; ShipToAddr[8]) { }
                    column(ShiptoCode; ShiptoCode) { }
                    column(ExtDocNoCaption; ExtDocNoCaptionLbl) { }
                    column(ExtDocNo; "Sales Header"."External Document No.") { }
                    column(SelltoCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Sell-to Customer No.")) { }
                    column(SelltoCustNo_SalesHeader; "Sales Header"."Sell-to Customer No.") { }
                    column(SelltoContactPhNoCaption; SelltoContactPhNoCaptionLbl) { }
                    column(SelltoContactPhoneNo; SelltoContactPhoneNo) { }
                    column(ShippingAgentCodeCaption; ShippingAgentCodeCaptionLbl) { }
                    column(ShippingAgentCode; "Sales Header"."Shipping Agent Code") { }
                    // BC Upgrade KUMARS145 Field dependent on Drinkit commented.....>>
                    // column(RouteCaption; "Sales Header".FIELDCAPTION(Route)) { }
                    // column(Route; "Sales Header".Route) { }
                    // column(Truck; "Sales Header"."Truck Code") { }
                    // column(Trailer; "Sales Header"."Trailer Code"){Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035';}
                    // column(TruckZoneCaption; "Sales Header".FIELDCAPTION("Truck Zone")) { }
                    // column(TruckZone; "Sales Header"."Truck Zone") { }
                    // column(PickingTypeCaption; "Sales Header".FIELDCAPTION("Picking Type")) { }
                    // column(PickingType; "Sales Header"."Picking Type") { }
                    column(RouteCaption; '') { }
                    column(Route; '') { }
                    column(Truck; '') { }
                    column(Trailer; '') { Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035'; }
                    column(TruckZoneCaption; '') { }
                    column(TruckZone; '') { }
                    column(PickingTypeCaption; '') { }
                    column(PickingType; '') { }
                    // BC Upgrade KUMARS145 Field dependent on Drinkit commented.....<<
                    column(Driver1Caption; Driver1CaptionLbl) { }
                    column(Driver1; DriverName[1]) { }
                    column(Driver2Caption; Driver2CaptionLbl) { }
                    column(Driver2; DriverName[2]) { }
                    column(TruckCaption; TruckCaptionLbl) { }
                    column(TrailerCaption; TrailerCaptionLbl)
                    {
                        Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035';
                    }
                    column(GrossWt; TotalGrossWeight)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(NetWt; TotalNetWeight)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(TotalQtyinHL; TotalQtyinHL)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(GrossWtCaption; SalesLine.FIELDCAPTION("Gross Weight")) { }
                    column(NetWtCaption; SalesLine.FIELDCAPTION("Net Weight")) { }
                    column(TotalQtyInHLCaption; TotalQtyInHLCaptionLbl) { }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.") { }
                    column(CompanyInfoIBAN; CompanyInfo.IBAN) { }
                    column(CompanyInfoSwiftCode; CompanyInfo."SWIFT Code") { }
                    column(CompanyInfoFaxNoCaption; CompanyInfoFaxNoCaptionLbl) { }
                    column(CompanyInfoIBANCaption; CompanyInfoIBANCaptionLbl) { }
                    column(CompanyInfoSwiftCodeCaption; CompanyInfoSwiftCodeCaptionLbl) { }
                    column(SalesOrdersExists; SalesOrdersExists) { }
                    column(ArrivalDateTimeCaption; ArrivalDateTimeCaptionLbl) { }
                    column(DepartureDateTimeCaption; DepartureDateTimeCaptionLbl) { }
                    column(BreakStartDateTimeCaption; BreakStartDateTimeCaptionLbl) { }
                    column(BreakEndDateTimeCaption; BreakEndDateTimeCaptionLbl) { }
                    column(DriverNameCaption; DriverNameCaptionLbl) { }
                    column(Driver2NameCaption; DriverName2CaptionLbl) { }
                    column(DriverSignatureCaption; DriverSignatureCaptionLbl) { }
                    column(Driver2SignatureCaption; Driver2SignatureCaptionLbl) { }
                    column(DriverCommentsCaption; DriverCommentsCaptionLbl) { }
                    column(Driver2CommentsCaption; Driver2CommentsCaptionLbl) { }
                    column(CustomerSignatureCaption; CustomerSignatureCaptionLbl) { }
                    column(ShiptoAddrKeyNo; ShiptoAddrKeyNo) { }
                    column(DeliveryTime1Caption; DeliveryTime1CaptionLbl) { }
                    column(DeliveryTime1; DeliveryTime1) { }
                    column(DeliveryTime2Caption; DeliveryTime2CaptionLbl) { }
                    column(DeliveryTime2; DeliveryTime2) { }
                    column(AddressLeft; AddressLeft) { }
                    column(AddressRight; AddressRight) { }
                    // K=BC Upgrade KUMARS145 Field dependent on Drinkit commented.....>>
                    // column(StartingShipmentDateTimeCaption; RouteRegisterEntry.FIELDCAPTION("Shipment Start Date-Time")) { }
                    // column(StartingShipmentDateTime; RouteRegisterEntry."Shipment Start Date-Time") { }
                    // column(EndingShipmentDateTimeCaption; RouteRegisterEntry.FIELDCAPTION("Shipment End Date-Time")) { }
                    // column(EndingShipmentDateTime; RouteRegisterEntry."Shipment End Date-Time") { }
                    // column(Break1TimeMinCaption; RouteRegisterEntry.FIELDCAPTION("Break 1 Time (Min.)")) { }
                    // column(Break1TimeMin; RouteRegisterEntry."Break 1 Time (Min.)") { }
                    // column(Break2TimeMinCaption; RouteRegisterEntry.FIELDCAPTION("Break 2 Time (Min.)")) { }
                    // column(Break2TimeMin; RouteRegisterEntry."Break 2 Time (Min.)") { }
                    // column(StartingKMCaption; RouteRegisterEntry.FIELDCAPTION("Trip Begin")) { }
                    // column(StartingKM; RouteRegisterEntry."Trip Begin") { }
                    // column(EndingKMCaption; RouteRegisterEntry.FIELDCAPTION("Trip End")) { }
                    // column(EndingKM; RouteRegisterEntry."Trip End") { }
                    column(StartingShipmentDateTimeCaption; '') { }
                    column(StartingShipmentDateTime; '') { }
                    column(EndingShipmentDateTimeCaption; '') { }
                    column(EndingShipmentDateTime; '') { }
                    column(Break1TimeMinCaption; '') { }
                    column(Break1TimeMin; '') { }
                    column(Break2TimeMinCaption; '') { }
                    column(Break2TimeMin; '') { }
                    column(StartingKMCaption; '') { }
                    column(StartingKM; '') { }
                    column(EndingKMCaption; '') { }
                    column(EndingKM; '') { }
                    // K=BC Upgrade KUMARS145 Field dependent on Drinkit commented.....<<
                    column(Text010; Text010) { }
                    column(Text011; Text011) { }
                    column(Text012; Text012) { }
                    column(Text013; Text013) { }
                    column(Text014; Text014) { }
                    column(Text015; Text015) { }
                    column(Text016; Text016) { }
                    column(Text017; Text017) { }
                    column(Text018; Text018) { }
                    column(Text019; Text019) { }
                    column(Text020; Text020) { }
                    column(SalesOrderNoCaption; SalesOrderNoLbl) { }
                    column(CustomerNoCaption; CustomerNoLbl) { }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = SalesLineFilter;
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText) { }
                        column(DimensionLoop1Number; Number) { }
                        column(HeaderDimCaption; HeaderDimCaptionLbl) { }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FIND('-') then
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
                                    DimText := STRSUBSTNO('%1, %2 %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");

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
                                CurrReport.Break();
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLinkReference = SalesLineFilter;
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                        MaxIteration = 0;

                        trigger OnPreDataItem();
                        begin
                            // not used in this reprort
                            CurrReport.Break();
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(SalesLineAmt; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesLine; "Sales Line".Description) { }
                        column(NNCSalesLineLineAmt; NNCSalesLineLineAmt) { }
                        column(NNCSalesLineInvDiscAmt; NNCSalesLineInvDiscAmt) { }
                        column(NNCTotalLCY; NNCTotalLCY) { }
                        column(NNCTotalExclVAT; NNCTotalExclVAT) { }
                        column(NNCVATAmt; NNCVATAmt) { }
                        column(NNCTotalInclVAT; NNCTotalInclVAT) { }
                        column(NNCPmtDiscOnVAT; NNCPmtDiscOnVAT) { }
                        column(NNCTotalInclVAT2; NNCTotalInclVAT2) { }
                        column(NNCVATAmt2; NNCVATAmt2) { }
                        column(NNCTotalExclVAT2; NNCTotalExclVAT2) { }
                        column(VATBaseDisc_SalesHeader; "Sales Header"."VAT Base Discount %") { }
                        column(DisplayAssemblyInfo; DisplayAssemblyInformation) { }
                        column(ShowInternalInfo; ShowInternalInfo) { }
                        column(No2_SalesLine; "Sales Line"."No.") { }
                        column(Qty_SalesLine; "Sales Line"."Quantity (Base)") { }
                        column(UOM_SalesLine; "Sales Line"."Unit of Measure Code") { }
                        column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                            IncludeCaption = false;
                        }
                        column(LineDisc_SalesLine; "Sales Line"."Line Discount %") { }
                        column(LineAmt_SalesLine; "Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_SalesLine; "Sales Line"."Allow Invoice Disc.") { }
                        column(VATIdentifier_SalesLine; "Sales Line"."VAT Identifier") { }
                        column(Type_SalesLine; FORMAT("Sales Line".Type, 0, 2)) { }
                        column(No_SalesLine; "Sales Line"."Line No.") { }
                        column(AllowInvDiscountYesNo_SalesLine; FORMAT("Sales Line"."Allow Invoice Disc.")) { }
                        column(AsmInfoExistsForLine; AsmInfoExistsForLine) { }
                        column(SalesLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                            IncludeCaption = false;
                        }
                        column(TotalText; TotalText) { }
                        column(SalsLinAmtExclLineDiscAmt; SalesLine."Line Amount" - VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText) { }
                        column(VATAmtLineVATAmtText3; VATAmountLine.VATAmountText()) { }
                        column(TotalInclVATText; TotalInclVATText) { }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineAmtExclLineDisc; SalesLine."Line Amount" - VATAmountLine."Invoice Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DiscountPercentCaption; DiscountPercentCaptionLbl) { }
                        column(SubtotalCaption; SubtotalCaptionLbl) { }
                        column(PaymentDiscountVATCaption; PaymentDiscountVATCaptionLbl) { }
                        column(Desc_SalesLineCaption; "Sales Line".FIELDCAPTION(Description)) { }
                        column(No2_SalesLineCaption; "Sales Line".FIELDCAPTION("No.")) { }
                        column(Qty_SalesLineCaption; QtyCaptionLbl) { }
                        column(UOM_SalesLineCaption; UOMCaptionLbl) { }
                        column(VATIdentifier_SalesLineCaption; "Sales Line".FIELDCAPTION("VAT Identifier")) { }
                        column(LocationCaption; LocationCaptionLbl) { }
                        column(Location_SalesLine; "Sales Line"."Location Code") { }
                        column(VATPer_SalesInvLineCaption; VATPercentageCaptionLbl) { }
                        column(VATPer_SalesInvLine; "Sales Line"."VAT %") { }
                        column(TotalHLCaption; TotalHLCaptionLbl) { }
                        // BC Upgrade KUMARS145 Field dependent on Drinkit commented.....>>
                        // column(FreeItem; "Sales Line"."Free Item") { }
                        // column(ItemChargeCalcPer; FORMAT("Sales Line"."Item Charge Calculate per", 0, 2)) { }
                        column(FreeItem; '') { }
                        column(ItemChargeCalcPer; '') { }
                        // BC Upgrade KUMARS145 Field dependent on Drinkit commented.....<<
                        column(FreeReasonDesc; FreeReasonDesc) { }
                        column(LineQtyinHL; LineQtyinHL)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(Desc2_SalesLineCaption; "Sales Line".FIELDCAPTION("Description 2")) { }
                        column(Desc2_SalesLine; "Sales Line"."Description 2") { }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                SalesLine.FindSet()
                            else
                                SalesLine.Next();
                            "Sales Line" := SalesLine;

                            if DisplayAssemblyInformation then
                                AsmInfoExistsForLine := SalesLine.AsmToOrderExists(AsmHeader);

                            if not "Sales Header"."Prices Including VAT" and
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            then
                                SalesLine."Line Amount" := 0;

                            if (SalesLine.Type = SalesLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Sales Line"."No." := '';

                            FreeReasonDesc := '';
                            // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....>>
                            // if SalesLine."Free Item" then
                            //     if FreeReasonCode.GET(SalesLine."Free Reason Code") then
                            //         FreeReasonDesc := FreeReasonCode.Description
                            //     else
                            //         // <<DITW18.00.07 DDR 29/04/2016 DIT-770 #1488
                            //         FreeReasonDesc := FreeCaptionLbl;
                            // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....<<
                            // >>DITW18.00.07 DDR DIT-770 #1488


                            // <<DITW18.00.07 DDR 29/04/2016 DIT-770 #1488
                            // LineQtyinHL := 0;
                            // IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
                            //   LineQtyinHL := SalesLine.Quantity * SalesLine."Unit Volume HL";
                            // END;
                            // sum total quantity in hl
                            // LineQtyinHL := SalesLine."Unit Volume HL"; // BC Upgrade KUMARS145 Field dependent on Drinkit commented.
                            // >>DITW18.00.07 DDR DIT-770 #1488

                            NNCSalesLineLineAmt += SalesLine."Line Amount";

                            NNCSalesLineInvDiscAmt += SalesLine."Inv. Discount Amount";

                            NNCTotalLCY := NNCSalesLineLineAmt - NNCSalesLineInvDiscAmt;

                            NNCTotalExclVAT := NNCTotalLCY;
                            NNCVATAmt := VATAmount;
                            NNCTotalInclVAT := NNCTotalLCY - NNCVATAmt;

                            NNCPmtDiscOnVAT := -VATDiscountAmount;

                            NNCTotalInclVAT2 := TotalAmountInclVAT;

                            NNCVATAmt2 := VATAmount;
                            NNCTotalExclVAT2 := VATBaseAmount;
                        end;

                        trigger OnPostDataItem();
                        begin
                            /// DITW17.00.02 RPG 28/11/2013 DIT-770 #235 - DITW110.00.11 AKH 02/11/2017 NRQ#43605
                            SalesLine.DELETEALL;
                        end;

                        trigger OnPreDataItem();
                        begin
                            SalesLine.RESET;
                            // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....>>
                            // SalesLine.SETCURRENTKEY(Route, "Shipment Date", "No.");
                            SalesLine.SETCURRENTKEY("Shipment Date", "No.");
                            // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....<<
                            SETRANGE(Number, 1, SalesLine.COUNT);
                            //<< DITW110.00.11 AKH 02/11/2017 NRQ#43605
                            TempEmptyGoodItemLine.Reset();
                            if TempEmptyGoodItemLine.FindLast() then
                                LineNo := TempEmptyGoodItemLine."Line No.";
                            //>> DITW110.00.11 AKH NRQ#43605
                        end;
                    }
                    dataitem(Comments; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(Comment; TempCommentLine.Comment) { }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                TempCommentLine.FindFirst()
                            else
                                TempCommentLine.Next();
                        end;

                        trigger OnPreDataItem();
                        begin
                            TempCommentLine.Reset();
                            SETRANGE(Number, 1, TempCommentLine.Count);
                        end;
                    }
                    dataitem(EmptyGoodDetails; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(No_TempEmptyGoodItemLine; TempEmptyGoodItemLine."No.") { }
                        column(Description_TempEmptyGoodItemLine; TempEmptyGoodItemLine.Description) { }

                        trigger OnAfterGetRecord();
                        begin
                            //<< DITW110.00.11 AKH 02/11/2017 NRQ#43605
                            if Number = 1 then
                                TempEmptyGoodItemLine.FindFirst()
                            else
                                TempEmptyGoodItemLine.Next();
                        end;

                        trigger OnPreDataItem();
                        begin
                            //<< DITW110.00.11 AKH 02/11/2017 NRQ#43605
                            TempEmptyGoodItemLine.Reset();
                            SETRANGE(Number, 1, TempEmptyGoodItemLine.Count);
                        end;
                    }
                    dataitem(SalesOrders; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(SalesOrdersCaption; SalesOrdersCaption) { }
                        column(SalesOrdersNoCaption; SalesHeader.FIELDCAPTION("No.")) { }
                        column(SalesOrdersNo; SalesHeader."No.") { }
                        column(SalesOrdersSelltoCustomerNoCaption; SalesHeader.FIELDCAPTION("Sell-to Customer No.")) { }
                        column(SalesOrdersSelltoCustomerNo; SalesHeader."Sell-to Customer No.") { }
                        column(SalesOrdersSelltoCustomerNameCaption; SalesHeader.FIELDCAPTION("Sell-to Customer Name")) { }
                        column(SalesOrdersSelltoCustomerName; SalesHeader."Sell-to Customer Name") { }
                        column(SalesOrdersSelltoCustomerSearchNameCaption; Cust.FIELDCAPTION("Search Name")) { }
                        column(SalesOrdersSelltoCustomerSearchName; Cust."Search Name") { }
                        column(SalesOrdersShiptoAddressCaption; SalesHeader.FIELDCAPTION("Ship-to Address")) { }
                        column(SalesOrdersShiptoAddress; SalesHeader."Ship-to Address") { }
                        column(SalesOrdersShiptoCityCaption; SalesHeader.FIELDCAPTION("Ship-to City")) { }
                        column(SalesOrdersShiptoCity; SalesHeader."Ship-to City") { }
                        // BC Upgrade KUMARS145 Field dependent on Drinkit commented.....>>
                        // column(SalesOrdersShiptoAddressKeyNoCaption; SalesHeader.FIELDCAPTION("Ship-to Address Key No.")) { }
                        // column(SalesOrdersShiptoAddressKeyNo; SalesHeader."Ship-to Address Key No.") { }
                        // column(SalesOrdersPickingTypeCaption; SalesHeader.FIELDCAPTION("Picking Type")) { }
                        // column(SalesOrdersPickingType; SalesHeader."Picking Type") { }
                        // column(SalesOrdersTruckZoneCaption; SalesHeader.FIELDCAPTION("Truck Zone")) { }
                        // column(SalesOrdersTruckZone; SalesHeader."Truck Zone") { }
                        // column(DeliverySequence_SalesHeader; SalesHeader."Delivery Sequence") { }
                        // column(DeliverySequenceCaption_SalesHeader; SalesHeader.FIELDCAPTION("Delivery Sequence")) { }
                        column(SalesOrdersShiptoAddressKeyNoCaption; '') { }
                        column(SalesOrdersShiptoAddressKeyNo; '') { }
                        column(SalesOrdersPickingTypeCaption; '') { }
                        column(SalesOrdersPickingType; '') { }
                        column(SalesOrdersTruckZoneCaption; '') { }
                        column(SalesOrdersTruckZone; '') { }
                        column(DeliverySequence_SalesHeader; '') { }
                        column(DeliverySequenceCaption_SalesHeader; '') { }

                        // BC Upgrade KUMARS145 Field dependent on Drinkit commented.....<<

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                SalesHeader.FindSet()
                            else
                                SalesHeader.Next();

                            /// DITW17.00.02 VSC 16/04/2014 DIT-770 #579 Fixes testreport
                            /// DITW18.00.06 MSF 26/06/2015 DIT-770 #1278 - DITW18.00.07 DDR 11/04/2016 29/04/2016 DIT-770 #1488
                            //IF Print AND (CopyLoop.Number = 1) THEN BEGIN
                            //END;

                            if not Cust.GET(SalesHeader."Sell-to Customer No.") then
                                Cust.Init();
                        end;

                        trigger OnPreDataItem();
                        begin
                            SalesHeader.Reset();
                            SETRANGE(Number, 1, SalesHeader.COUNT);
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                var
                    PrepmtSalesLine: Record "Sales Line" temporary;
                    SalesPost: Codeunit "Sales-Post";
                    TempSalesLine: Record "Sales Line" temporary;
                    TempSalesLineDisc: Record "Sales Line" temporary;
                begin
                    if Number > 1 then begin
                        CopyText := Text003;
                        OutputNo += 1;
                    end;
                    CurrReport.PAGENO := 1;

                    NNCTotalLCY := 0;
                    NNCTotalExclVAT := 0;
                    NNCVATAmt := 0;
                    NNCTotalInclVAT := 0;
                    NNCPmtDiscOnVAT := 0;
                    NNCTotalInclVAT2 := 0;
                    NNCVATAmt2 := 0;
                    NNCTotalExclVAT2 := 0;
                    NNCSalesLineLineAmt := 0;
                    NNCSalesLineInvDiscAmt := 0;
                end;

                trigger OnPostDataItem();
                begin
                    if Print then
                        SalesCountPrinted.RUN("Sales Header");
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
                Print := Print or not CurrReport.PREVIEW;
                SalesOrdersExists := true;
                CompanyInfo.GET();
                CurrReport.LANGUAGE := GetLanguageID("Language Code");

                if RespCenter.GET("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                BarcodeValueLeft := '';
                BarcodeValueRight := '';
                BarcodeValueCenter := '';
                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....>>
                // case CompanyInfo."Barcode Position on Documents" of
                //     CompanyInfo."Barcode Position on Documents"::"No Barcode":
                //         ;
                //     CompanyInfo."Barcode Position on Documents"::Left:
                //         BarcodeValueLeft := "No.";
                //     CompanyInfo."Barcode Position on Documents"::Center:
                //         BarcodeValueCenter := "No.";
                //     CompanyInfo."Barcode Position on Documents"::Right:
                //         BarcodeValueRight := "No.";
                // end;
                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....<<
                //>>DITW17.00.02 RPG DIT-770 #235

                if "Salesperson Code" = '' then begin
                    CLEAR(SalesPurchPerson);
                    SalesPersonText := '';
                end else begin
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
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
                FormatAddr.SalesHeaderBillTo(CustAddr, "Sales Header");

                if "Payment Terms Code" = '' then
                    PaymentTerms.Init()
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

                // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
                // >>DITW110.00.08 DDR NRQ#0
                //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....>>
                // if ShipToAddr[8] = '' then
                //     ShipToAddr[8] := FIELDCAPTION("Ship-to Address Key No.") + ' ' + "Ship-to Address Key No."
                // else
                //     ShiptoAddrKeyNo := FIELDCAPTION("Ship-to Address Key No.") + ' ' + "Ship-to Address Key No.";
                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....<<
                COMPRESSARRAY(ShipToAddr);
                //>>DITW17.00.02 RPG DIT-770 #235

                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                for i := 1 to ARRAYLEN(ShipToAddr) do
                    if ShipToAddr[i] <> CustAddr[i] then
                        ShowShippingAddr := true;

                //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                SelltoContactPhoneNo := '';
                if not Contact.GET("Sell-to Contact No.") then
                    CLEAR(Contact);
                SelltoContactPhoneNo := Contact."Phone No.";

                /// DITW18.00.07 DDR 29/04/2016 DIT-770 #1488
                /// only working when running per sales header (here, 1 sales header as base common data))
                ///GrossWt := 0;
                ///NetWt := 0;
                ///TotalQtyinHL := 0;
                ///SalesOrderLine.RESET;
                ///SalesOrderLine.SETRANGE("Document Type",SalesOrderLine."Document Type"::Order);
                ///SalesOrderLine.SETRANGE("Document No.","No.");
                ///SalesOrderLine.SETRANGE(Type,SalesOrderLine.Type::Item);
                ///IF SalesOrderLine.FINDSET THEN
                ///  REPEAT
                ///    IF SalesOrderLine.Quantity > 0 THEN BEGIN
                ///      //<< DITDE7.00.03 VSC 10/03/2014 DIT-770 : 65 Fixes testreport
                ///      GrossWt += SalesOrderLine."Gross Weight" * SalesOrderLine."Quantity (Base)";
                ///      NetWt += SalesOrderLine."Net Weight" * SalesOrderLine."Quantity (Base)";
                ///      //>> DITDE7.00.03 VSC 10/03/2014 DIT-770
                ///    END;
                ///    TotalQtyinHL += SalesOrderLine.Quantity * SalesOrderLine."Unit Volume HL";
                ///  UNTIL SalesOrderLine.NEXT = 0;

                SalesOrdersExists := false;
                SalesOrderLine.RESET();
                SalesOrderLine.SETRANGE("Document No.", "No.");
                SalesOrderLine.SETRANGE(Type, SalesOrderLine.Type::"Charge (Item)");
                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....>>
                // SalesOrderLine.SETFILTER("Empty Goods Item No.", '<>%1', '');
                // SalesOrderLine.SETRANGE("Item Charge Type", SalesOrderLine."Item Charge Type"::Deposit);
                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....<<
                if not SalesOrderLine.IsEmpty then
                    SalesOrdersExists := true;

                TempCommentLine.DELETEALL();
                CommentLineNo := 10000;
                CommentLine.RESET();
                CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::"Countries/Region");
                CommentLine.SETRANGE("No.", "Sell-to Country/Region Code");
                // CommentLine.SETRANGE("Print on Shipment", true); // BC Upgrade KUMARS145 Code dependent on Drinkit commented.
                if CommentLine.FINDSET() then
                    repeat
                        InsertCommentLine(CommentLine.Comment);
                    until CommentLine.Next() = 0;

                CommentLine.Reset();
                CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Customer);
                CommentLine.SETRANGE("No.", "Sell-to Customer No.");
                // CommentLine.SETRANGE("Print on Shipment", true);// BC Upgrade KUMARS145 Code dependent on Drinkit commented.
                if CommentLine.FindSet() then
                    repeat
                        InsertCommentLine(CommentLine.Comment);
                    until CommentLine.Next() = 0;

                SalesCommentLine.Reset();
                SalesCommentLine.SETRANGE("Document Type", SalesCommentLine."Document Type"::Order);
                SalesCommentLine.SETRANGE("No.", "No.");
                // SalesCommentLine.SETRANGE("Print on Shipment", true);// BC Upgrade KUMARS145 Code dependent on Drinkit commented.
                if SalesCommentLine.FINDSET() then
                    repeat
                        InsertCommentLine(SalesCommentLine.Comment);
                    until SalesCommentLine.Next() = 0;

                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....>>
                // if "Delivery Time 1 To" <> 000000T then
                //     DeliveryTime1 := FORMAT("Delivery Time 1 From") + ' to ' + FORMAT("Delivery Time 1 To")
                // else
                //     DeliveryTime1 := FORMAT("Delivery Time 1 From");

                // if "Delivery Time 2 To" <> 000000T then
                //     DeliveryTime2 := FORMAT("Delivery Time 2 From") + ' to ' + FORMAT("Delivery Time 2 To")
                // else
                //     DeliveryTime2 := FORMAT("Delivery Time 2 From");
                //>>DITW17.00.02 RPG DIT-770 #235

                // //<< Hitxxx.xx VSC 01-01-2013 :Show Driver name.
                // if not WhseShippingDriver.GET("Sales Header"."Driver Code") then
                //     WhseShippingDriver.INIT();
                // DriverName[1] := WhseShippingDriver.Description;

                // if not WhseShippingDriver.GET("Sales Header"."Driver 2 Code") then
                //     WhseShippingDriver.INIT();
                // DriverName[2] := WhseShippingDriver.Description;
                // //>> Hitxxx.xx VSC 01-01-2013

                // // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                // RouteRegisterEntry.RESET();
                // RouteRegisterEntry.SETRANGE("Route Planning No.", "Route Planning No.");
                // RouteRegisterEntry.SETRANGE("Shipment Date", "Shipment Date");
                // /// DITDE7.00.03 VSC 10/03/2014 DIT-770 : 65 Fixes testreport
                // RouteRegisterEntry.SETRANGE("Source No.", '');
                // if not RouteRegisterEntry.FINDFIRST() then
                //     RouteRegisterEntry.INIT();
                // // >>DITW18.00.07 DDR DIT-770 #1488
                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....<<

                if Print then begin
                    if ArchiveDocument then
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    /// DITDE7.00.03 VSC 10/03/2014 DIT-770 : 65 Fixes testreport// moved to other section
                    /// DITW18.00.07 DDR 29/04/2016 DIT-770 #1488

                    if LogInteraction then begin
                        CALCFIELDS("No. of Archived Versions");
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No."
                              , "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        else
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    end;
                end;
                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....>>
                // //<<DITW18.00.06 MSF 14/05/2015 DIT-770 #1035
                // TruckDescription := '';
                // if Truck.GET("Truck Code") then begin
                //     TruckDescription := Truck.Description;
                //     if Truck."Transport Unit Identity" <> '' then
                //         TruckDescription += ' - ' + Truck."Transport Unit Identity";
                // end;
                // TrailerDescription := '';
                // if Truck.GET("Trailer Code") then begin
                //     TrailerDescription := Truck.Description;
                //     if Truck."Transport Unit Identity" <> '' then
                //         TrailerDescription += ' - ' + Truck."Transport Unit Identity";
                // end;
                // //>>DITW18.00.06 MSF 14/05/2015 DIT-770 #1035
                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....<<
            end;

            trigger OnPostDataItem();
            var
                SalesHeader2: Record "Sales Header";
                SalesDepositLines: Record "Sales Line";
            // DrinkDepositGroup: Record "Drink Deposit Group"; // BC Upgrade KUMARS145 Record dependent on Drinkit commented.
            begin
                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....>>
                // // <<DITW18.00.07 DDR 11/04/2016 29/04/2016 DIT-770 #1488
                // if Print then
                //     if SalesHeader.FINDSET() then begin
                //         repeat
                //             //<< DITW18.00.07 VSC 30/05/2016 DIT-770 #1488
                //             SalesHeader2.GET(SalesHeader."Document Type", SalesHeader."No.");
                //             if SalesHeader2."Shipment status" < SetShipmentStatus then begin
                //                 SalesHeader2.VALIDATE("Shipment status", SetShipmentStatus);
                //                 SalesHeader2.MODIFY(true);
                //             end;
                //         //>> DITW18.00.07 VSC DIT-770 #1488
                //         until SalesHeader.NEXT() = 0;
                //     end;
                // // >>DITW18.00.07 DDR DIT-770 #1488
                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....<<
            end;

            trigger OnPreDataItem();
            var
                SalesLine2: Record "Sales Line";
                SalesLine3: Record "Sales Line";
                SalesDepositLines: Record "Sales Line";
            // DrinkDepositGroup: Record "Drink Deposit Group"; // BC Upgrade KUMARS145 Record dependent on Drinkit commented.
            begin
                Print := Print or not CurrReport.PREVIEW;
                AsmInfoExistsForLine := false;
                /// DITW18.00.07 DDR 11/04/2016 29/04/2016 DIT-770 #1488

                // <<DITW18.00.07 DDR 29/04/2016 DIT-770 #1488
                TotalGrossWeight := 0;
                TotalNetWeight := 0;
                TotalQtyinHL := 0;
                NewLineNo := 10000;
                //temporary variables
                SalesHeader.RESET();
                SalesHeader.DELETEALL();
                SalesLine.RESET();
                SalesLine.DELETEALL();
                //
                if FINDSET() then begin
                    repeat
                        SalesLine2.COPY(SalesLineFilter);
                        SalesLine2.SETRANGE("Document Type", "Document Type");
                        SalesLine2.SETRANGE("Document No.", "No.");
                        SalesLine2.SETRANGE(Type, SalesLine2.Type::Item);
                        SalesLine2.SETFILTER(Quantity, '>0');
                        if SalesLine2.FINDSET() then begin
                            repeat
                                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....>>
                                // if Print then begin
                                //     if SalesLine2."Shipment Status" < SetShipmentStatus then
                                //         SalesLine2."Shipment Status" := SetShipmentStatus;
                                //     SalesLine2."Picklist Printed (date/time)" := CREATEDATETIME(TODAY, TIME);
                                //     SalesLine2.MODIFY();
                                // end;
                                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....<<

                                // save all orders to be printed.
                                if (SalesHeader."Document Type" <> SalesLine2."Document Type") or
                                  (SalesHeader."No." <> SalesLine2."Document No.")
                                then begin
                                    SalesHeader := "Sales Header";
                                    SalesHeader.INSERT();
                                    if NewLineNo = 10000 then
                                        SalesHeaderFirst := SalesHeader;
                                end;

                                // total in quantity (base)
                                // SalesLine2.ShowShortcutUomValue(ShortcutQtyUomValue);  // BC Upgrade KUMARS145 Code dependent on Drinkit commented.
                                TotalShortcutQtyUomValue[1] += ShortcutQtyUomValue[1];
                                TotalShortcutQtyUomValue[2] += ShortcutQtyUomValue[2];
                                TotalShortcutQtyUomValue[3] += ShortcutQtyUomValue[3];

                                // save all order lines to be printed.
                                // grouping per
                                SalesLine.SETRANGE(Type, SalesLine2.Type);
                                SalesLine.SETRANGE("No.", SalesLine2."No.");
                                // SalesLine.SETRANGE(Route, SalesLine2.Route); // BC upgrade KUMARS145 Code dependent on Drinkit commented.
                                SalesLine.SETRANGE("Shipment Date", SalesLine2."Shipment Date");
                                //
                                SalesLine2."Gross Weight" := SalesLine2.Quantity * SalesLine2."Gross Weight";
                                SalesLine2."Net Weight" := SalesLine2.Quantity * SalesLine2."Net Weight";
                                // SalesLine2."Unit Volume HL" := SalesLine2.Quantity * SalesLine2."Unit Volume HL"; // BC Upgrade KUMARS145 Field dependent on Drinkit commented.
                                if not SalesLine.FINDFIRST() then begin
                                    SalesLine := SalesLine2;
                                    SalesLine."Document No." := SalesHeaderFirst."No.";
                                    SalesLine."Line No." := NewLineNo;
                                    SalesLine.INSERT();// save all lines under the main salesorder
                                    NewLineNo += 10000;
                                end else begin
                                    SalesLine.Quantity += SalesLine2.Quantity;
                                    SalesLine."Outstanding Quantity" += SalesLine2."Outstanding Quantity";
                                    SalesLine."Quantity (Base)" += SalesLine2."Quantity (Base)";
                                    SalesLine."Outstanding Qty. (Base)" += SalesLine2."Outstanding Qty. (Base)";
                                    SalesLine."Gross Weight" += SalesLine2."Gross Weight";
                                    SalesLine."Net Weight" += SalesLine2."Net Weight";
                                    // SalesLine."Unit Volume HL" += SalesLine2."Unit Volume HL"; // BC Upgrade KUMARS145 Field dependent on Drinkit commented.
                                    SalesLine.MODIFY();
                                end;
                            until SalesLine2.NEXT() = 0;
                        end;
                    until NEXT() = 0;
                end;

                if not SalesHeader.FINDFIRST() then
                    CurrReport.BREAK
                //<< DITW110.00.11 AKH 02/11/2017 NRQ#43605
                else begin
                    TempEmptyGoodItemLine.RESET();
                    TempEmptyGoodItemLine.DELETEALL();
                    repeat
                    // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....>>
                    // DrinkDepositGroup.RESET();
                    // DrinkDepositGroup.SETRANGE("Include In Fixed Block", true);
                    // DrinkDepositGroup.SETFILTER("Empty Good Reference Item No.", '<>%1', '');
                    // if not DrinkDepositGroup.ISEMPTY then begin
                    //     DrinkDepositGroup.FINDSET();
                    //     repeat
                    //         with SalesDepositLines do begin
                    //             SETCURRENTKEY("Document Type", "Document No.", "Item DDeposit Group Code");
                    //             SETRANGE("Document Type", SalesHeader."Document Type");
                    //             SETRANGE("Document No.", SalesHeader."No.");
                    //             SETRANGE(Type, Type::Item);
                    //             SETRANGE("Item DDeposit Group Code", DrinkDepositGroup.Code);
                    //             if FINDSET() then begin
                    //                 repeat
                    //                     TempEmptyGoodItemLine.RESET;
                    //                     TempEmptyGoodItemLine.SETRANGE("No.", DrinkDepositGroup."Empty Good Reference Item No.");
                    //                     if not TempEmptyGoodItemLine.FINDFIRST then begin
                    //                         LineNo += 10000;
                    //                         TempEmptyGoodItemLine.INIT();
                    //                         TempEmptyGoodItemLine."No." := DrinkDepositGroup."Empty Good Reference Item No.";
                    //                         if Item.GET(DrinkDepositGroup."Empty Good Reference Item No.") then
                    //                             TempEmptyGoodItemLine.Description := Item.Description;
                    //                         TempEmptyGoodItemLine."Document Type" := TempEmptyGoodItemLine."Document Type"::Order;
                    //                         TempEmptyGoodItemLine."Document No." := "No.";
                    //                         TempEmptyGoodItemLine."Line No." := LineNo;
                    //                         TempEmptyGoodItemLine.INSERT();
                    //                     end;
                    //                 until (NEXT() = 0);
                    //             end;
                    //         end;
                    //     until (DrinkDepositGroup.NEXT() = 0);
                    // end;
                    // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....<<
                    until (SalesHeader.NEXT() = 0);
                end;
                //>> DITW110.00.11 AKH NRQ#43605

                SalesLine.RESET();
                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....>>
                // SalesLine.CALCSUMS("Gross Weight", "Net Weight", "Unit Volume HL"); 
                SalesLine.CALCSUMS("Gross Weight", "Net Weight");
                // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....<<
                TotalGrossWeight := SalesLine."Gross Weight";
                TotalNetWeight := SalesLine."Net Weight";
                // TotalQtyinHL := SalesLine."Unit Volume HL"; // BC Upgrade KUMARS145 Field dependent on Drinkit commented.

                TotalShortcutQtyUomValue[1] := ROUND(TotalShortcutQtyUomValue[1], 0.00001);
                TotalShortcutQtyUomValue[2] := ROUND(TotalShortcutQtyUomValue[2], 0.00001);
                TotalShortcutQtyUomValue[3] := ROUND(TotalShortcutQtyUomValue[3], 0.00001);
                // >>DITW18.00.07 DDR DIT-770 #1488

                "Sales Header".RESET();
                "Sales Header".SETRANGE("Document Type", SalesHeaderFirst."Document Type");
                "Sales Header".SETRANGE("No.", SalesHeaderFirst."No.");// print only the first salesorder
            end;
        }
    }

    requestpage
    {

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
                        ApplicationArea = All;
                        CaptionML = ENU = 'No. of Copies',
                                    FRA = 'Nombre de copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Show Internal Information',
                                    FRA = 'Afficher info. internes';
                        Visible = false;
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Archive Document',
                                    FRA = 'Archiver document';

                        trigger OnValidate();
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Log Interaction',
                                    FRA = 'Journal interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate();
                        begin
                            if LogInteraction then
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(ShowAssemblyComponents; DisplayAssemblyInformation)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Show Assembly Components',
                                    FRA = 'Afficher composants d''assemblage';
                        Visible = false;
                    }
                    field(SetShipmentStatus; SetShipmentStatus)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Set Shipment Status',
                                    FRA = 'Régler état d''expédtion';
                        OptionCaptionML = ENU = 'Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice',
                                          FRA = 'Ouvert,Prélèvement imprimé,Affecté,Prélevé,Expédié,Retour terminée,Facturée';
                    }
                    field(DisplayCustomerInfo; DisplayCustomerInfo)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Display Customer Information',
                                    FRA = 'Avec Information de Client';
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
            // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....>>
            // ArchiveDocument := SalesSetup."Archive Quotes and Orders";
            // LogInteraction := SegManagement.FindInteractTmplCode(3) <> '';
            // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....<<

            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        WarehouseSetup.GET();
        SalesSetup.GET();
        SetShipmentStatus := SetShipmentStatus::Shipped;

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo3.GET();
                    CompanyInfo3.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.GET();
                    CompanyInfo1.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.GET();
                    CompanyInfo2.CALCFIELDS(Picture);
                end;
        end;

        //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
        CompanyInfo.GET();
        AddressLeft := false;
        AddressRight := false;
        // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....>>
        // case CompanyInfo."Address Position on Documents" of
        //     CompanyInfo."Address Position on Documents"::Left:
        //         AddressLeft := true;
        //     CompanyInfo."Address Position on Documents"::Right:
        //         AddressRight := true;
        // end;
        // BC Upgrade KUMARS145 Code dependent on Drinkit commented.....<<
        //>>DITW17.00.02 RPG DIT-770 #235
    end;

    trigger OnPreReport();
    begin
        // FCE01-
        // BC Upgrade KUMARS145 Replaced deprecated function to a new local one.....>>
        // CurrReport.LANGUAGE := Language.GetLanguageID(CompanyInfo."Language Code");
        CurrReport.LANGUAGE := GetLanguageID(CompanyInfo."Language Code FND");
        // BC Upgrade KUMARS145 Replaced deprecated function to a new local one.....<<
        //FCE01+
    end;

    var
        SalesOrdersCaption: TextConst ENU = 'Sales Orders', FRA = 'Commandes vente';
        Text000: TextConst ENU = 'Salesperson', FRA = 'Vendeur';
        Text001: TextConst ENU = 'Total %1', FRA = 'Total %1';
        Text002: TextConst ENU = 'Total %1 Incl. VAT', FRA = 'Total %1 TTC';
        Text003: TextConst ENU = 'COPY', FRA = 'COPIE';
        Text004: TextConst ENU = 'Load List Order %1', FRA = 'Ordre de Chargement %1';
        Text005: TextConst ENU = 'Page %1', FRA = 'Page %1';
        Text006: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 HT';
        GLSetup: Record "General Ledger Setup";
        WarehouseSetup: Record "Warehouse Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        Cust: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        SalesHeader: Record "Sales Header" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        TempPrepmtDimSetEntry: Record "Dimension Set Entry" temporary;
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        LanguageRec: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        AsmHeader: Record "Assembly Header";
        AsmLine: Record "Assembly Line";
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
        DimMgt: Codeunit DimensionManagement;
        CustAddr: array[8] of Text[60];
        ShipToAddr: array[8] of Text[60];
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
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
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
       //[InDataSet]
        ArchiveDocumentEnable: Boolean;
       // [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
        InvDiscAmtCaptionLbl: TextConst ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
        VATRegNoCaptionLbl: TextConst ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        GiroNoCaptionLbl: TextConst ENU = 'Giro No.', FRA = 'N° CCP';
        BankCaptionLbl: TextConst ENU = 'Bank', FRA = 'Banque';
        AccountNoCaptionLbl: TextConst ENU = 'Account No.', FRA = 'N° compte';
        ShipmentDateCaptionLbl: TextConst ENU = 'Shipment Date', FRA = 'Date d''expédition';
        OrderNoCaptionLbl: TextConst ENU = 'Order No.', FRA = 'N° commande';
        HomePageCaptionLbl: TextConst ENU = 'Home Page', FRA = 'Page d''accueil';
        EmailCaptionLbl: TextConst ENU = 'E-Mail', FRA = 'E-mail';
        HeaderDimCaptionLbl: TextConst ENU = 'Header Dimensions', FRA = 'Analytique en-tête';
        DiscountPercentCaptionLbl: TextConst ENU = 'Discount %', FRA = '% remise';
        SubtotalCaptionLbl: TextConst ENU = 'Subtotal', FRA = 'Sous-total';
        PaymentDiscountVATCaptionLbl: TextConst ENU = 'Payment Discount on VAT', FRA = 'Escompte sur TVA';
        LineDimCaptionLbl: TextConst ENU = 'Line Dimensions', FRA = 'Analytique ligne';
        InvDiscBaseAmtCaptionLbl: TextConst ENU = 'Invoice Discount Base Amount', FRA = 'Remise facture montant de base';
        VATIdentifierCaptionLbl: TextConst ENU = 'VAT Identifier', FRA = 'Identifiant TVA';
        ShiptoAddrCaptionLbl: TextConst ENU = 'Ship-to Address', FRA = 'Adresse destinataire';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        GLAccountNoCaptionLbl: TextConst ENU = 'G/L Account No.', FRA = 'N° compte général';
        PrepaymentSpecCaptionLbl: TextConst ENU = 'Prepayment Specification', FRA = 'Spécification acompte';
        PrepaymentVATAmtSpecCapLbl: TextConst ENU = 'Prepayment VAT Amount Specification', FRA = 'Spécification montant TVA acompte';
        PrepmtPmtTermsDescCaptionLbl: TextConst ENU = 'Prepmt. Payment Terms', FRA = 'Conditions paiement acompte';
        PhoneNoCaptionLbl: TextConst ENU = 'Phone No.', FRA = 'N° téléphone';
        AmountCaptionLbl: TextConst ENU = 'Amount', FRA = 'Montant';
        VATPercentageCaptionLbl: TextConst ENU = 'VAT %', FRA = '% TVA';
        VATBaseCaptionLbl: TextConst ENU = 'VAT Base', FRA = 'Base TVA';
        VATAmtCaptionLbl: TextConst ENU = 'VAT Amount', FRA = 'Montant TVA';
        VATAmtSpecCaptionLbl: TextConst ENU = 'VAT Amount Specification', FRA = 'Détail montant TVA';
        LineAmtCaptionLbl: TextConst ENU = 'Line Amount', FRA = 'Montant ligne';
        TotalCaptionLbl: TextConst ENU = 'Total', FRA = 'Total';
        UnitPriceCaptionLbl: TextConst ENU = 'Unit Price', FRA = 'Prix unitaire';
        PaymentTermsCaptionLbl: TextConst ENU = 'Payment Terms', FRA = 'Conditions de paiement';
        ShipmentMethodCaptionLbl: TextConst ENU = 'Shipment Method', FRA = 'Méthode d''expédition';
        DocumentDateCaptionLbl: TextConst ENU = 'Document Date', FRA = 'Date document';
        AllowInvDiscCaptionLbl: TextConst ENU = 'Allow Invoice Discount', FRA = 'Autoriser remise facture';
        BarcodeValueLeft: Code[20];
        BarcodeValueRight: Code[20];
        BarcodeValueCenter: Code[20];
        Contact: Record Contact;
        SelltoCust: Record Customer;
        ShiptoAddrCust: Record "Ship-to Address";
        ShiptoCode: Code[20];
        // BC Upgrade KUMARS145 Record dependent on Drinkit commented.....>>
        // FreeReasonCode: Record "Free Reason Code";
        // WhseShippingDriver: Record "Whse. Shipping Driver";
        // BC Upgrade KUMARS145 Record dependent on Drinkit commented.....>>
        FreeReasonDesc: Text[50];
        TotalGrossWeight: Decimal;
        TotalNetWeight: Decimal;
        TotalQtyinHL: Decimal;
        CommentLine: Record "Comment Line";
        SalesCommentLine: Record "Sales Comment Line";
        TempCommentLine: Record "Comment Line" temporary;
        CommentLineNo: Integer;
        LineQtyinHL: Decimal;
        Item: Record Item;
        SalesOrdersExists: Boolean;
        ExtDocNoCaptionLbl: TextConst ENU = 'External Document No.', FRA = 'N° document externe';
        SellToAddrCaptionLbl: TextConst ENU = 'Order Address', FRA = 'Adresse commande';
        UOMCaptionLbl: TextConst ENU = 'UOM', FRA = 'UM';
        TotalHLCaptionLbl: TextConst ENU = 'Total HL', FRA = 'Total HL';
        DepositQtyShippedCaptionLbl: TextConst ENU = 'Qty. Shipped', FRA = 'Qté expédié';
        DepositQtyReturnedCaptionLbl: TextConst ENU = 'Qty. Returned', FRA = 'Quantité retournée';
        DepositDifferenceCaptionLbl: TextConst ENU = 'Difference', FRA = 'Différence';
        EmptyGoodsDetailsCaptionLbl: TextConst ENU = 'Empty Goods Detail', FRA = 'Détail marchandises vides';
        TotalQtyInHLCaptionLbl: TextConst ENU = 'Quantity HL', FRA = 'Quantité HL';
        CompanyInfoFaxNoCaptionLbl: TextConst ENU = 'Fax', FRA = 'Fax';
        CompanyInfoIBANCaptionLbl: TextConst ENU = 'IBAN', FRA = 'IBAN';
        CompanyInfoSwiftCodeCaptionLbl: TextConst ENU = 'SWIFT Code', FRA = 'Code SWIFT';
        SalesOrderLine: Record "Sales Line";
        TempSalesOrderLine: Record "Sales Line" temporary;
        SelltoContactPhoneNo: Text[30];
        SelltoContactPhNoCaptionLbl: TextConst ENU = 'Sell-to Contact Phone No.', FRA = 'N° téléphone contact donneur d''ordre';
        ShippingAgentCodeCaptionLbl: TextConst ENU = 'Shipping Agent', FRA = 'Transporteur';
        Driver1CaptionLbl: TextConst ENU = 'Driver 1', FRA = 'Chauffeur 1';
        Driver2CaptionLbl: TextConst ENU = 'Driver 2', FRA = 'Chauffeur 2';
        TruckCaptionLbl: TextConst ENU = 'Truck No.', FRA = 'Matricule camion';
        LocationCaptionLbl: TextConst ENU = 'Location', FRA = 'Magasin';
        ArrivalDateTimeCaptionLbl: TextConst ENU = 'Arrival Date/Time', FRA = 'Arrivée Date-Heure';
        DepartureDateTimeCaptionLbl: TextConst ENU = 'Departure Date/Time', FRA = 'Départ Date / Heure';
        BreakStartDateTimeCaptionLbl: TextConst ENU = 'Break Start Date/Time', FRA = 'Début de la pause  Date / Heure';
        BreakEndDateTimeCaptionLbl: TextConst ENU = 'Break End Date/Time', FRA = 'Fin de la pause Date / Heure';
        DriverNameCaptionLbl: TextConst ENU = 'Driver Name', FRA = 'Nom chauffeur';
        DriverName2CaptionLbl: TextConst ENU = 'Driver Name 2', FRA = 'Nom chauffeur 2';
        DriverSignatureCaptionLbl: TextConst ENU = 'Driver Signature', FRA = 'Signature chauffeur';
        Driver2SignatureCaptionLbl: TextConst ENU = 'Driver 2 Signature', FRA = 'Signature chauffeur 2';
        DriverCommentsCaptionLbl: TextConst ENU = 'Driver Comments', FRA = 'Commentaires chauffeur';
        Driver2CommentsCaptionLbl: TextConst ENU = 'Driver 2 Comments', FRA = 'Commentaires chauffeur 2';
        CustomerSignatureCaptionLbl: TextConst ENU = 'Customer signature for goods receipt', FRA = 'Signature du client pour la réception des marchandises';
        DeliveryTime1: Text[100];
        DeliveryTime2: Text[100];
        DeliveryTime1CaptionLbl: TextConst ENU = 'Delivery Time 1', FRA = 'Délai de livraison 1';
        DeliveryTime2CaptionLbl: TextConst ENU = 'Delivery Time 2', FRA = 'Heure de livraison 2';
        ShiptoAddrKeyNo: Text[100];
        AddressLeft: Boolean;
        AddressRight: Boolean;
        QtyCaptionLbl: TextConst ENU = 'QTY', FRA = 'Qté';
        DriverName: array[2] of Text[50];
        NewLineNo: Integer;
        ShortcutQtyUomValue: array[3] of Decimal;
        TotalShortcutQtyUomValue: array[3] of Decimal;
        SetShipmentStatus: Option Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;
        TrailerCaptionLbl: TextConst ENU = 'Trailer', FRA = 'Remorque';
        TruckDescription: Text[80];
        TrailerDescription: Text[80];
        // BC Upgrade KUMARS145 Drinkit table commented....>>
        // Truck: Record "Whse. Shipping Truck";
        // RouteRegisterEntry: Record "Route Register Entry";
        // BC Upgrade KUMARS145 Drinkit table commented....<<
        FreeCaptionLbl: TextConst ENU = 'Free', FRA = 'Gratuit';
        SalesHeaderFirst: Record "Sales Header";
        TempEmptyGoodItemLine: Record "Sales Line" temporary;
        Text010: Label 'No.';
        Text011: Label 'Empty Good Returns';
        Text012: Label 'Empty Good item';
        Text013: Label 'Shipped quantity';
        Text014: Label 'Returned quantity';
        Text015: Label 'Difference';
        LineNo: Integer;
        Text016: Label 'Item / Description';
        Text017: Label 'Description 2';
        Text018: Label 'Quantity';
        Text019: Label 'HL';
        Text020: Label 'Other Returns';
        DisplayCustomerInfo: Boolean;
        SalesOrderNoLbl: TextConst ENU = 'Sales Order No.', FRA = 'N° Commande Vente';
        CustomerNoLbl: TextConst ENU = 'Customer No.', FRA = 'N° Donneur d''ordre';

    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean; DisplayAsmInfo: Boolean);
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        ArchiveDocument := ArchiveDocumentFrom;
        LogInteraction := LogInteractionFrom;
        Print := PrintFrom;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10];
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.GET(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    local procedure BlanksForIndent(): Text[10];
    begin
        exit(PADSTR('', 2, ' '));
    end;

    local procedure InsertCommentLine(Comment: Text);
    begin
        TempCommentLine.INIT;
        TempCommentLine."Line No." := CommentLineNo;
        TempCommentLine.Comment := Comment;
        TempCommentLine.INSERT;
        CommentLineNo += 10000;
    end;
    // BC Upgrade KUMARS145 Replaced deprecated function to a new local one.....>>
    local procedure GetLanguageID(LanguageCode: Code[10]): Integer
    var
        LanguageRecLocal: Record Language;
    begin
        if LanguageRecLocal.GET(LanguageCode) then
            exit(LanguageRecLocal."Windows Language ID")
        else
            exit(0);
    end;
    // BC Upgrade KUMARS145 Replaced deprecated function to a new local one.....>>
}

