report 53088 "Delivery Note - Shipment LR"
{
    // version HEI.01

    // HEI.01 CHG2079354 HB1685 IBM GAVANM01 02.11.2020 # Delivery Note form - localization
    //   # Copied Report 50268 - Delivery Note - Shipment STD and created dataset and layout according to La Reunion requirements
    // 1. Added mandatory BC report properties.
    //         - ApplicationArea not defined.
    //         - UsageCategory = ReportsAndAnalysis
    // all the DIT related columns blocked
    // Setrange functions using DIT related fields blocked
    // SalesShptLine.CalcVATAmountLines("Sales Shipment Header", VATAmountLine); DIT function is blocked
    //BC UPGRADE RD03 Table Replaced in BC with "Item Cross Reference"
    //BC UPGRADE RD03>> Changin Whole Fnc Based on Replaced table and Field from "Cross-Reference No." to "Reference No." and Table from ("Item Cross Reference" to "Item Reference")


    Caption = 'Delivery Note - Shipment La Reunion';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    //EnableExternalAssemblies = true;
    PreviewMode = PrintLayout;
    RDLCLayout = '.\src\ReportsLayout\Delivery Note - Shipment LR.rdl';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            //ReqFilterHeading = 'Sales Shipment Header';
            column(No_SalesHeader; "No.")
            {
            }
            column(InclPrices; InclPrices)
            {
            }
            column(InclDeposit; InclDeposit)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(ReturnOrderNo; ReturnOrder."No.")
                    {
                    }
                    // BC Upgrade RD03 Drinkit Related Commented .......>>
                    //column(RouteName; Routes.Name)
                    column(RouteName; '')
                    {
                    }
                    // BC Upgrade RD03 Drinkit Related Commented .......<<
                    column(ShipMethod; ShipMethod.Description)
                    {
                    }
                    column(PayTerms; PayTerms.Description)
                    {
                    }
                    column(YourReference; "Sales Shipment Header"."Your Reference")
                    {
                    }
                    column(CTSDocumentSubtype; CTSDocumentSubtype)
                    {
                    }
                    // BC Upgrade RD03 Drinkit Related Commented .......>>
                    //column(TechnicianName; MasterDataProperty.Name)
                    column(TechnicianName; '')
                    {
                    }
                    // BC Upgrade RD03 Drinkit Related Commented .......<<
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ReportTitle; Text002)
                    {
                    }
                    column(CompanyText; CompanyText)
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo_OpCoFooter; CompanyInfo."OpCo Footer image FND")
                    {
                    }
                    column(CompanyInfo_Name; CompanyInfo.Name)
                    {
                    }
                    column(CompanyInfo_VATNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo_HomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfo_Email; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfo_City; CompanyInfo.City)
                    {
                    }
                    column(CompanyInfo_PostCode; CompanyInfo."Post Code")
                    {
                    }
                    column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfo_FaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfo_TradeRegister; CompanyInfo."Trade Register FND")
                    {
                    }
                    column(CompanyInfo__IBAN; CompanyInfo.IBAN)
                    {
                    }
                    column(CompanyInfo__SWIFTCode; CompanyInfo."SWIFT Code")
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    // column(CompanyInfo__BankName__2; CompanyInfo."Bank Name 2")
                    column(CompanyInfo__BankName__2; '')
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    column(CompanyInfo__BankName; CompanyInfo."Bank Name")
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    //column(CompanyInfo__IBAN__2; CompanyInfo."IBAN 2")
                    column(CompanyInfo__IBAN__2; '')
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......<<

                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    //column(CompanyInfo__SWIFTCode__2; CompanyInfo."SWIFT Code 2")
                    column(CompanyInfo__SWIFTCode__2; '')
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......<<
                    column(CompanyFooter1; TextFooter[1])
                    {
                    }
                    column(CompanyFooter2; TextFooter[2])
                    {
                    }
                    column(CompanyFooter3; TextFooter[3])
                    {
                    }
                    column(HeaderAddr1; HeaderAddr[1])
                    {
                    }
                    column(HeaderAddr2; HeaderAddr[2])
                    {
                    }
                    column(HeaderAddr3; HeaderAddr[3])
                    {
                    }
                    column(HeaderAddr4; HeaderAddr[4])
                    {
                    }
                    column(HeaderAddr5; HeaderAddr[5])
                    {
                    }
                    column(HeaderAddr6; HeaderAddr[6])
                    {
                    }
                    column(HeaderAddr7; HeaderAddr[7])
                    {
                    }
                    column(HeaderAddr8; HeaderAddr[8])
                    {
                    }
                    column(PhoneNo_Customer; Customer."Phone No.")
                    {
                    }
                    column(FaxNo_Customer; Customer."Fax No.")
                    {
                    }
                    column(SellToCust_SalesHeader; "Sales Shipment Header"."Sell-to Customer No.")
                    {
                    }
                    column(ShippingNo_SalesHeader; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(BillToCust_SalesHeader; "Sales Shipment Header"."Bill-to Customer No.")
                    {
                    }
                    column(BillToCustName; "Sales Shipment Header"."Bill-to Name")
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    // column(Route_SalesHeader; "Sales Shipment Header".Route)
                    column(Route_SalesHeader; '')
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......<<
                    column(ShipmentDate_SalesHeader; "Sales Shipment Header"."Shipment Date")
                    {
                    }
                    column(ShipToName_SalesHeader; "Sales Shipment Header"."Ship-to Name")
                    {
                    }
                    column(ShipToName2_SalesHeader; "Sales Shipment Header"."Ship-to Name 2")
                    {
                    }
                    column(ShipToAddress_SalesHeader; "Sales Shipment Header"."Ship-to Address")
                    {
                    }
                    column(ShipToAddress2_SalesHeader; "Sales Shipment Header"."Ship-to Address 2")
                    {
                    }
                    column(ShipToPostCode_SalesHeader; "Sales Shipment Header"."Ship-to Post Code")
                    {
                    }
                    column(ShipToCity_SalesHeader; "Sales Shipment Header"."Ship-to City")
                    {
                    }
                    column(SalesShipmentHeader_UserID; "Sales Shipment Header"."User ID")
                    {
                    }
                    column(SalesShipmentHeader_DocumentDate; "Sales Shipment Header"."Document Date")
                    {
                    }
                    column(SalesShipmentHeader_LocationCode; "Sales Shipment Header"."Location Code")
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    //column(SalesShipmentHeader_TruckCode;  "Sales Shipment Header"."Truck Code")
                    column(SalesShipmentHeader_TruckCode; '')
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......<<
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    //column(SalesShipmentHeader_TruckName; WhseShippingTruck.Description)
                    column(SalesShipmentHeader_TruckName; '')
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......<<
                    column(SalesShipmentHeader_GateEntryNo; "Sales Shipment Header"."Gate Entry No. FND")
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    //column(SalesShipmentHeader_DriverCode; "Sales Shipment Header"."Driver Code")
                    column(SalesShipmentHeader_DriverCode; '')
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......<<
                    column(ShipToCountryName; ShipToCountryName.Name)
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    //column(Name_Driver; Driver.Description)
                    column(Name_Driver; '')
                    {
                    }
                    // BC Upgrade RD03 Drinkit Field Commented .......<<
                    column(Name_SalesPerson; SalesPerson.Name)
                    {
                    }
                    column(PhoneNo_SalesPerson; SalesPerson."Phone No.")
                    {
                    }
                    column(TextDeliveryTime; TextDeliveryTime)
                    {
                    }
                    column(blnDeliveryTime; blnDeliveryTime)
                    {
                    }
                    column(PrintShipmentText; PrintShipmentText)
                    {
                    }
                    column(TotalOrderDiscCharges; TotalOrderDiscCharges)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(SubTotal; SubTotal)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(CashInvoice; CashInvoice)
                    {
                    }
                    column(CurrCode; CurrCode)
                    {
                    }
                    column(BeginningBalance; BeginningBalance)
                    {
                    }
                    column(EndBalance; EndBalance)
                    {
                    }
                    column(Gains; Gains)
                    {
                    }
                    column(Sales; Sales)
                    {
                    }
                    column(TotalSubTotal; TotalSubTotal)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(Text010; Text010)
                    {
                    }
                    column(Text011; Text011)
                    {
                    }
                    column(Text012; Text012)
                    {
                    }
                    column(Text013; Text013)
                    {
                    }
                    column(Text014; Text014)
                    {
                    }
                    column(Text015; Text015)
                    {
                    }
                    column(Text016; Text016)
                    {
                    }
                    column(Text017; Text017)
                    {
                    }
                    column(Text018; Text018)
                    {
                    }
                    column(Text019; Text019)
                    {
                    }
                    column(Text020; Text020)
                    {
                    }
                    column(Text021; Text021)
                    {
                    }
                    column(Text022; Text022)
                    {
                    }
                    column(Text023; Text023)
                    {
                    }
                    column(PrintOrderDiscounts; PrintOrderDiscounts)
                    {
                    }
                    column(PrintOrderDeposits; PrintOrderDeposits)
                    {
                    }
                    column(Text024; Text024)
                    {
                    }
                    column(Text025; Text025)
                    {
                    }
                    column(Text026; Text026)
                    {
                    }
                    column(Text027; Text027)
                    {
                    }
                    column(Text028; Text028)
                    {
                    }
                    column(Text029; Text029)
                    {
                    }
                    column(Text030; Text030)
                    {
                    }
                    column(Text031; Text031)
                    {
                    }
                    column(Text032; Text032)
                    {
                    }
                    column(Text033; Text033)
                    {
                    }
                    column(Text034; Text034)
                    {
                    }
                    column(Text035; Text035)
                    {
                    }
                    column(Text037; Text037)
                    {
                    }
                    column(Text038; Text038)
                    {
                    }
                    column(Text039; Text039)
                    {
                    }
                    column(Text040; Text040)
                    {
                    }
                    column(Text041; Text041)
                    {
                    }
                    column(Text042; Text042)
                    {
                    }
                    column(Text043; Text043)
                    {
                    }
                    column(Text044; Text044)
                    {
                    }
                    column(Text045; Text045)
                    {
                    }
                    column(Text046; Text046)
                    {
                    }
                    column(Text047; Text047)
                    {
                    }
                    column(Text048; Text048)
                    {
                    }
                    column(Text049; Text049)
                    {
                    }
                    column(Text050; Text050)
                    {
                    }
                    column(Text051; Text051)
                    {
                    }
                    column(Text052; Text052)
                    {
                    }
                    column(Text053; Text053)
                    {
                    }
                    column(Text054; Text054)
                    {
                    }
                    column(Text055; Text055)
                    {
                    }
                    column(Text056; Text056)
                    {
                    }
                    column(Text057; Text057)
                    {
                    }
                    column(Text058; Text058)
                    {
                    }
                    column(Text059; Text059)
                    {
                    }
                    column(Text060; Text060)
                    {
                    }
                    column(Text061; Text061)
                    {
                    }
                    column(Text062; Text062)
                    {
                    }
                    column(TotalDiscounts; TotalDiscounts)
                    {
                    }
                    column(TotalDeposits; TotalDeposits)
                    {
                    }
                    column(PrintLoyaltyStatement; PrintLoyaltyStatement)
                    {
                    }
                    column(PrintOrderTaxes; PrintOrderTaxes)
                    {
                    }
                    column(ShowLotSerialInfo; ShowLotSerialInfo)
                    {
                    }
                    column(TrackingInfoDescriptionLbl; TrackingInfoDescriptionLbl)
                    {
                    }
                    column(ResponsibilityCenter_Code1; RespCenter_Code[1])
                    {
                    }
                    column(ResponsibilityCenter_PostCode1; RespCenter_PostCode[1])
                    {
                    }
                    column(ResponsibilityCenter_PhoneNo1; RespCenter_PhoneNo[1])
                    {
                    }
                    column(ResponsibilityCenter_FaxNo1; RespCenter_FaxNo[1])
                    {
                    }
                    column(ResponsibilityCenter_Code2; RespCenter_Code[2])
                    {
                    }
                    column(ResponsibilityCenter_PostCode2; RespCenter_PostCode[2])
                    {
                    }
                    column(ResponsibilityCenter_PhoneNo2; RespCenter_PhoneNo[2])
                    {
                    }
                    column(ResponsibilityCenter_FaxNo2; RespCenter_FaxNo[2])
                    {
                    }
                    column(ResponsibilityCenter_Code3; RespCenter_Code[3])
                    {
                    }
                    column(ResponsibilityCenter_PostCode3; RespCenter_PostCode[3])
                    {
                    }
                    column(ResponsibilityCenter_PhoneNo3; RespCenter_PhoneNo[3])
                    {
                    }
                    column(ResponsibilityCenter_FaxNo3; RespCenter_FaxNo[3])
                    {
                    }
                    column(ResponsibilityCenter_Code4; RespCenter_Code[4])
                    {
                    }
                    column(ResponsibilityCenter_PostCode4; RespCenter_PostCode[4])
                    {
                    }
                    column(ResponsibilityCenter_PhoneNo4; RespCenter_PhoneNo[4])
                    {
                    }
                    column(ResponsibilityCenter_FaxNo4; RespCenter_FaxNo[4])
                    {
                    }
                    column(ResponsibilityCenter_Code5; RespCenter_Code[5])
                    {
                    }
                    column(ResponsibilityCenter_PostCode5; RespCenter_PostCode[5])
                    {
                    }
                    column(ResponsibilityCenter_PhoneNo5; RespCenter_PhoneNo[5])
                    {
                    }
                    column(ResponsibilityCenter_FaxNo5; RespCenter_FaxNo[5])
                    {
                    }
                    column(SaleShipmentHeader_OrderNo; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(Text063; Text063)
                    {
                    }
                    column(SaleShipmentHeader_ExternalDocNo; "Sales Shipment Header"."External Document No.")
                    {
                    }
                    column(SaleShipmentHeader_ShippingAgentCode; ShippingAgent.Name)
                    {
                    }
                    column(SaleShipmentHeader_SalesPerson; SalesPerson.Name)
                    {
                    }
                    column(SaleShipmentHeader_GateEntryNo; "Sales Shipment Header"."Gate Entry No. FND")
                    {
                    }
                    column(PlannedDeliveryDate; PlannedDeliveryDate)
                    {
                    }
                    column(ActualDeliveryDate; ActualDeliveryDate)
                    {
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATPercent_VATAmountLine; VATAmountLine."VAT %")
                        {
                        }
                        column(VATAmount_VATAmountLine; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Shipment Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATPerText; VATPerText)
                        {
                        }
                        column(VATPercent_VATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);

                            if VATAmountLine."VAT %" = 0 then
                                CurrReport.SKIP();

                            VATPerText := STRSUBSTNO(Text2014416, VATAmountLine."VAT %");
                        end;

                        trigger OnPreDataItem();
                        begin
                            VATAmountLine.RESET();
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                        end;
                    }
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Type_SalesLine; FORMAT(Type, 0, 2))
                        {
                        }
                        column(SalesShipmentLine_OrderNo; "Sales Shipment Line"."Order No.")
                        {
                        }
                        column(No_SalesLine; "No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Description_SalesLine; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(Description2_SalesLine; "Description 2")
                        {
                            IncludeCaption = true;
                        }
                        column(Quantity_SalesLine; Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(UOM_SalesLine; "Unit of Measure Code")
                        {
                            IncludeCaption = true;
                        }
                        column(LineNo_SalesLine; "Line No.")
                        {
                        }
                        column(UnitPrice_SalesLine; "Unit Price")
                        {
                        }
                        column(VATIdentifier_SalesLine; "Sales Shipment Line"."VAT %")
                        {
                        }
                        // BC Upgrade RD03 Drinkit Field Commented .......>>
                        //column(LineAmount_SalesLine; "Line Amount")
                        column(LineAmount_SalesLine; '')
                        {
                        }
                        // BC Upgrade RD03 Drinkit Field Commented .......>>

                        // BC Upgrade RD03 Drinkit Field Commented .......>>
                        //column(FreeItem_SalesLine; "Free Item")
                        column(FreeItem_SalesLine; '')
                        {
                        }
                        // BC Upgrade RD03 Drinkit Field Commented .......<<
                        column(QtyHL; QtyHL)
                        {
                        }
                        column(CrossRefText; CrossRefText)
                        {
                        }
                        column(ExpirationDate; ExpirationDate)
                        {
                        }
                        column(FreeReasonText; FreeReasonText)
                        {
                        }
                        column(PrintPrice; PrintPrice)
                        {
                        }
                        column(PrintUnderLineCharge; PrintUnderLineCharge)
                        {
                        }
                        column(TrackingText1; TrackingText1)
                        {
                        }
                        column(TotalQtyHL; TotalQtyHL)
                        {
                        }
                        column(TotalQty; TotalQty)
                        {
                        }
                        // BC Upgrade RD03 Drinkit Field Commented .......>>
                        //column(LineDiscAmount; "Sales Shipment Line"."Line Discount Amount")
                        column(LineDiscAmount; '')
                        {
                        }
                        // BC Upgrade RD03 Drinkit Field Commented .......<<
                        column(TotalNetAmount; TotalNetAmount)
                        {
                        }
                        column(BarcodeLines; BarcodeLines)
                        {
                        }
                        column(BarcodeNumber; BarcodeNumber)
                        {
                        }
                        dataitem("Item Ledger Entry"; "Item Ledger Entry")
                        {
                            DataItemLink = "Document No." = FIELD("Document No."), "Document Line No." = FIELD("Line No."), "Item No." = FIELD("No.");
                            DataItemLinkReference = "Sales Shipment Line";
                            DataItemTableView = SORTING("Entry No.");
                            column(TrackingText; TrackingText)
                            {
                            }
                            column(LotSerialInformation_Quantity; -Quantity)
                            {
                            }
                            column(LotSerialInformation_MoreLines; MoreLotSerialLines)
                            {
                            }

                            trigger OnAfterGetRecord();
                            var
                                ItemLedgerEntry: Record "Item Ledger Entry";
                            begin
                                MoreLotSerialLines := false;
                                ItemLedgerEntry.SETRANGE("Document No.", "Document No.");
                                ItemLedgerEntry.SETRANGE("Document Line No.", "Document Line No.");
                                ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                                ItemLedgerEntry.SETFILTER("Entry No.", '<>%1', "Entry No.");
                                MoreLotSerialLines := ItemLedgerEntry.FINDFIRST();

                                if (MAXSTRLEN(TrackingText) - STRLEN(TrackingText) > 2) then begin
                                    if "Lot No." <> '' then begin
                                        if TrackingText <> '' then
                                            TrackingText += ',';
                                        TrackingText += COPYSTR("Lot No." + ' ' + FORMAT("Expiration Date"), 1, MAXSTRLEN(TrackingText) - STRLEN(TrackingText));
                                    end else if "Serial No." <> '' then begin
                                        if TrackingText <> '' then
                                            TrackingText += ',';
                                        TrackingText += COPYSTR("Serial No." + ' ' + FORMAT("Expiration Date"), 1, MAXSTRLEN(TrackingText) - STRLEN(TrackingText));
                                    end;
                                end;
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            // BC Upgrade RD03 Drinkit Related Commented .......>>
                            //ItemCrossReference: Record "Item Cross Reference";
                            // BC Upgrade RD03 Drinkit Related Commented .......<<
                            ReservEntry: Record "Reservation Entry";
                            ItemLedgEntry: Record "Item Ledger Entry";
                            OrderChargeLine: Record "Sales Shipment Line";
                            SalesChargeLine: Record "Sales Shipment Line";
                            IsTextToInclude: Boolean;
                        begin
                            if not CashInvoice then begin
                                if not (Type in [Type::" ", Type::Item, Type::"Charge (Item)"]) then
                                    CurrReport.SKIP
                                else if Type = Type::"Charge (Item)" then begin
                                    if not InclDeposit then
                                        CurrReport.SKIP
                                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                                    //else if "Item Charge Type" <> "Item Charge Type"::Deposit then
                                    //  CurrReport.SKIP;
                                    // BC Upgrade RD03 Drinkit Field Commented .......<<
                                end;
                            end else if Type = Type::"Charge (Item)" then begin
                                if not InclDeposit then
                                    CurrReport.SKIP
                                // BC Upgrade RD03 Drinkit Field Commented .......>>
                                //else if "Item Charge Type" <> "Item Charge Type"::Deposit then
                                //  CurrReport.SKIP;
                                // BC Upgrade RD03 Drinkit Field Commented .......<<
                            end;

                            //-----Qty in HL
                            CLEAR(QtyHL);
                            if (Type = Type::Item) and ("No." <> '') then
                                // BC Upgrade RD03 Drinkit Field Commented .......>>
                                // QtyHL := Quantity * "Unit Volume HL";
                            QtyHL := Quantity * 0;
                            // BC Upgrade RD03 Drinkit Field Commented .......<<

                            TotalQty += "Sales Shipment Line".Quantity;
                            TotalQtyHL += QtyHL;
                            // BC Upgrade RD03 Drinkit Field Commented .......<<
                            //TotalNetAmount += "Sales Shipment Line"."Line Amount";
                            TotalNetAmount += 0;
                            // BC Upgrade RD03 Drinkit Field Commented .......<<

                            //-----Cross Reference Info
                            CLEAR(CrossRefText);
                            /*//commented by HEI.01<<
                            IF Customer."Cross. Ref. on Del. Note" THEN BEGIN
                              IF (Type = Type::Item) AND ("No." <> '') THEN
                                CrossRefText := GetCrossReferences();
                            END;
                            *///commented by HEI.01>>
                            //HEI.01<<
                            CLEAR(BarcodeLines);
                            CLEAR(BarcodeNumber);
                            if (Type = Type::Item) and ("No." <> '') then begin
                                BarcodeNumber := GetBarCode();
                                if BarcodeNumber <> '' then
                                    BarcodeLines := HeinekenGlobal.EAN13_10String(BarcodeNumber);
                            end;
                            //HEI.01<<

                            //-----Expiration Info
                            CLEAR(ExpirationDate);

                            ReservEntry.RESET;
                            ReservEntry.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
                            ReservEntry.SETRANGE("Source Type", 111);
                            ReservEntry.SETRANGE("Source Subtype", 1);
                            ReservEntry.SETRANGE("Source ID", "Document No.");
                            ReservEntry.SETRANGE("Source Ref. No.", "Line No.");
                            if ReservEntry.FINDFIRST then begin
                                ItemLedgEntry.RESET;
                                ItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");
                                ItemLedgEntry.SETRANGE("Item No.", ReservEntry."Item No.");
                                ItemLedgEntry.SETRANGE(Open, true);
                                ItemLedgEntry.SETRANGE("Variant Code", ReservEntry."Variant Code");
                                if ReservEntry."Lot No." <> '' then
                                    ItemLedgEntry.SETRANGE("Lot No.", ReservEntry."Lot No.")
                                else
                                    if ReservEntry."Serial No." <> '' then
                                        ItemLedgEntry.SETRANGE("Serial No.", ReservEntry."Serial No.");
                                ItemLedgEntry.SETRANGE(Positive, true);

                                if ItemLedgEntry.FINDLAST then
                                    ExpirationDate := ItemLedgEntry."Expiration Date";
                            end;

                            // BC Upgrade RD03 Drinkit Field Commented .......>>
                            //-----Free Reason Text
                            CLEAR(FreeReasonText);
                            //if "Free Reason Code" <> '' then begin
                            // FreeReasonCode.GET("Free Reason Code");
                            //FreeReasonText := FreeReasonCode.Description;
                            //end;
                            // BC Upgrade RD03 Drinkit Field Commented .......>>

                            //-----Price Info
                            CLEAR(PrintPrice);
                            if CashInvoice then
                                if (Type = Type::Item) and ("No." <> '') then begin
                                    Item.GET("No.");
                                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                                    //Item.CALCFIELDS("Empty Good");
                                    //PrintPrice := not (Item."Empty Good");
                                    // BC Upgrade RD03 Drinkit Field Commented .......<<
                                end;

                            //-----Subtotal
                            if CashInvoice then
                                if
                                (
                                  (Type = Type::Item) and not (IsEmptyGoodItem())
                                  or (Type in [Type::Resource, Type::"Fixed Asset", Type::"G/L Account"])
                                ) then begin
                                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                                    // SubTotal += "Line Amount";
                                    // TotalSubTotal += "Line Amount";
                                    SubTotal += 0;
                                    TotalSubTotal += 0;
                                    // BC Upgrade RD03 Drinkit Field Commented .......<<
                                end;
                            //Charges included in item price
                            //Tax to Grand Total + Total + Line Amount
                            if CashInvoice then begin
                                SalesChargeLine.RESET;
                                SalesChargeLine.SETRANGE("Document No.", "Sales Shipment Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Shipment Line".Type::"Charge (Item)");
                                // BC Upgrade RD03 Drinkit Field Commented .......>>
                                // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Shipment Line"."Item Charge Type"::Tax);
                                // SalesChargeLine.SETRANGE("Show Item charge on Invoice", SalesChargeLine."Show Item charge on Invoice"::"Include in item price");
                                // BC Upgrade RD03 Drinkit Field Commented .......<<
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Shipment Line"."Line No.");
                                if SalesChargeLine.FINDSET then
                                    repeat
                                        // BC Upgrade RD03 Drinkit Field Commented .......>>
                                        //"Sales Shipment Line"."Line Amount" += SalesChargeLine."Line Amount";
                                        //SubTotal += SalesChargeLine."Line Amount";
                                        //TotalSubTotal += SalesChargeLine."Line Amount";

                                        //"Sales Shipment Line"."Line Amount" += SalesChargeLine."Line Amount";
                                        SubTotal += 0;
                                        TotalSubTotal += 0;
                                    // BC Upgrade RD03 Drinkit Field Commented .......<<
                                    until SalesChargeLine.NEXT = 0;
                                //Discounts to Grand Total + Total + Line Amount
                                CLEAR(PrintUnderLineCharge);
                                SalesChargeLine.RESET;
                                SalesChargeLine.SETRANGE("Document No.", "Sales Shipment Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Shipment Line".Type::"Charge (Item)");
                                // BC Upgrade RD03 Drinkit Field Commented .......>>
                                // SalesChargeLine.SETRANGE("Item Charge Type", "Sales Shipment Line"."Item Charge Type"::Tax);
                                // SalesChargeLine.SETRANGE("Show Item charge on Invoice", SalesChargeLine."Show Item charge on Invoice"::"Include in item price");
                                // BC Upgrade RD03 Drinkit Field Commented .......<<
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Shipment Line"."Line No.");
                                if SalesChargeLine.FINDSET then
                                    repeat
                                        // BC Upgrade RD03 Drinkit Field Commented .......>>
                                        //"Sales Shipment Line"."Line Amount" += SalesChargeLine."Line Amount";
                                        //SubTotal += SalesChargeLine."Line Amount";
                                        //TotalSubTotal += SalesChargeLine."Line Amount";

                                        //"Sales Shipment Line"."Line Amount" += SalesChargeLine."Line Amount";
                                        SubTotal += 0;
                                        TotalSubTotal += 0;
                                    // BC Upgrade RD03 Drinkit Field Commented .......<<
                                    until SalesChargeLine.NEXT = 0;
                                //Discounts under item line
                                SalesChargeLine.RESET;
                                SalesChargeLine.SETRANGE("Document No.", "Sales Shipment Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Shipment Line".Type::"Charge (Item)");
                                // BC Upgrade RD03 Drinkit Field Commented .......>>
                                //SalesChargeLine.SETRANGE("Item Charge Type", "Sales Shipment Line"."Item Charge Type"::Discount);
                                //SalesChargeLine.SETRANGE("Show Item charge on Invoice", SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                                // BC Upgrade RD03 Drinkit Field Commented .......<<
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Shipment Line"."Line No.");
                                if SalesChargeLine.FINDSET then
                                    if not PrintUnderLineCharge then
                                        PrintUnderLineCharge := true;
                                repeat
                                    TempUnderChargeLine.INIT;
                                    TempUnderChargeLine := SalesChargeLine;
                                    TempUnderChargeLine.INSERT;
                                until (SalesChargeLine.NEXT = 0);
                                // BC Upgrade RD03 Drinkit Field Commented .......>>
                                //SalesChargeLine.CALCSUMS("Line Amount");
                                //SubTotal += SalesChargeLine."Line Amount";
                                //TotalSubTotal += SalesChargeLine."Line Amount";
                                SubTotal += 0;
                                TotalSubTotal += 0;
                                // BC Upgrade RD03 Drinkit Field Commented .......<<

                                //Tax under item line
                                SalesChargeLine.RESET;
                                SalesChargeLine.SETRANGE("Document No.", "Sales Shipment Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Shipment Line".Type::"Charge (Item)");
                                // BC Upgrade RD03 Drinkit Field Commented .......>>
                                //SalesChargeLine.SETRANGE("Item Charge Type", "Sales Shipment Line"."Item Charge Type"::Discount);
                                //SalesChargeLine.SETRANGE("Show Item charge on Invoice", SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                                // BC Upgrade RD03 Drinkit Field Commented .......<<
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Shipment Line"."Line No.");
                                if SalesChargeLine.FINDSET then
                                    repeat
                                        // BC Upgrade RD03 Drinkit Field Commented .......>>
                                        //if (SalesChargeLine."Line Amount" <> 0) then begin
                                        if not PrintUnderLineCharge then
                                            PrintUnderLineCharge := true;
                                        TempUnderChargeLine.INIT;
                                        TempUnderChargeLine := SalesChargeLine;
                                        TempUnderChargeLine.INSERT;
                                    //end;
                                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                                    until (SalesChargeLine.NEXT = 0);

                                // BC Upgrade RD03 Drinkit Field Commented .......>>
                                //SalesChargeLine.CALCSUMS("Line Amount");
                                //SubTotal += SalesChargeLine."Line Amount";
                                //TotalSubTotal += SalesChargeLine."Line Amount";

                                //SalesChargeLine.CALCSUMS("Line Amount");
                                SubTotal += 0;
                                TotalSubTotal += 0;
                                // BC Upgrade RD03 Drinkit Field Commented .......<<
                                if ("Sales Shipment Line".Quantity <> 0) then
                                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                                    //"Sales Shipment Line"."Unit Price" := "Sales Shipment Line"."Line Amount" / "Sales Shipment Line".Quantity;
                                "Sales Shipment Line"."Unit Price" := 0 / "Sales Shipment Line".Quantity;
                                // BC Upgrade RD03 Drinkit Field Commented .......>>
                            end;

                            // ExtendedText
                            if Type = Type::Item then begin
                                TempMarketingText.DELETEALL;
                                ExtendedTextHeader.RESET;

                                ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::Item);
                                ExtendedTextHeader.SETRANGE("No.", "No.");
                                ExtendedTextHeader.SETRANGE("Print on Delivery Note FND", true);
                                if ExtendedTextHeader.FINDSET then
                                    repeat
                                        IsTextToInclude := true;
                                        if ExtendedTextHeader."Starting Date" <> 0D then
                                            IsTextToInclude := (ExtendedTextHeader."Starting Date" <= "Posting Date");
                                        if IsTextToInclude and (ExtendedTextHeader."Ending Date" <> 0D) then
                                            IsTextToInclude := (ExtendedTextHeader."Ending Date" >= "Posting Date");
                                        if IsTextToInclude then begin
                                            ExtendedTextLine.RESET;
                                            ExtendedTextLine.SETRANGE("Table Name", ExtendedTextHeader."Table Name");
                                            ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                                            ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                                            if ExtendedTextLine.FINDFIRST then
                                                repeat
                                                    TempMarketingText.INIT;
                                                    TempMarketingText := ExtendedTextLine;
                                                    TempMarketingText.INSERT;
                                                until (ExtendedTextLine.NEXT = 0);
                                        end;
                                    until ExtendedTextHeader.NEXT = 0;
                            end;

                            CLEAR(TrackingText1);
                            CLEAR(TrackingText);
                            // BC Upgrade RD03 Drinkit Related Commented .......>>
                            //DocTrackingManagement.CallPostedItemTracking1(DATABASE::"Sales Shipment Line", 0, "Document No.", '', 0, "Line No.", TempTrackingSpecification);
                            // BC Upgrade RD03 Drinkit Related Commented .......<<

                            LotNoCnt := TempTrackingSpecification.COUNT;
                            // BC Upgrade RD03 Drinkit Related Commented .......>>
                            //if LotNoCnt = 1 then
                            //TrackingText1 := DocTrackingManagement.GetPostedTrackingText(TempTrackingSpecification) + ' ' + FORMAT(TempTrackingSpecification."Expiration Date");
                            // BC Upgrade RD03 Drinkit Related Commented .......<<

                            //Total by UOM>>
                            TempUnitOfMeasure.RESET;
                            if TempUnitOfMeasure.GET("Sales Shipment Line"."Unit of Measure Code") then begin
                                TempUnitOfMeasure."Column 1 Amt." += "Sales Shipment Line".Quantity;
                                TempUnitOfMeasure.MODIFY;
                            end else begin
                                TempUnitOfMeasure.INIT;
                                TempUnitOfMeasure."Currency Code" := "Sales Shipment Line"."Unit of Measure Code";
                                TempUnitOfMeasure."Column 1 Amt." := "Sales Shipment Line".Quantity;
                                TempUnitOfMeasure.INSERT;
                            end;
                            //Total by UOM<<

                        end;

                        trigger OnPreDataItem();
                        var
                            ReservEntry: Record "Reservation Entry";
                        begin
                            VATAmountLine.DELETEALL();
                            MoreLines := FINDLAST();

                            while MoreLines and (Description = '') and ("Description 2" = '') and
                                  ("No." = '') and (Quantity = 0) //and (Amount = 0)
                            do
                                MoreLines := NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");

                            TempEmptyGoodItemLine.RESET();
                            if TempEmptyGoodItemLine.FINDLAST() then
                                LineNo := TempEmptyGoodItemLine."Line No.";
                            TotalSubTotal := TotalDeposits + TotalDiscounts + TotalTaxes;
                        end;
                    }
                    dataitem(UnitOfMeasuretotal; "Integer")
                    {
                        column(TempUnitOfMeasure_UOM; TempUnitOfMeasure."Currency Code")
                        {
                        }
                        column(TempUnitOfMeasure_Quantity; TempUnitOfMeasure."Column 1 Amt.")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not TempUnitOfMeasure.FIND('-') then
                                    CurrReport.BREAK();
                            end else
                                if TempUnitOfMeasure.NEXT() = 0 then
                                    CurrReport.BREAK();
                        end;

                        trigger OnPostDataItem();
                        begin
                            TempUnitOfMeasure.DELETEALL();
                        end;

                        trigger OnPreDataItem();
                        begin
                            TempUnitOfMeasure.RESET();
                            SETRANGE(Number, 1, TempUnitOfMeasure.COUNT);
                        end;
                    }
                    dataitem("Empty Return Header"; "Sales Header")
                    {
                        column(SalesEmptyHeader_No; "Empty Return Header"."No.")
                        {
                        }
                        dataitem("Empty Return Line"; "Sales Line")
                        {
                            DataItemLink = "Document No." = FIELD("No."), "Document Type" = FIELD("Document Type");
                            column(SalesEmptyLine_No; "Empty Return Line"."No.")
                            {
                            }
                            column(SalesEmptyLine_Description; "Empty Return Line".Description)
                            {
                            }
                            column(SalesEmptyLine_Quantity; "Empty Return Line".Quantity)
                            {
                            }
                            column(SalesEmptyLine_UnitPrice; EmptyReturnUnitPrice)
                            {
                            }
                            column(SalesEmptyLine_UOM; "Empty Return Line"."Unit of Measure Code")
                            {
                            }
                            column(SalesEmptyLine_LotNo; LotNo)
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                EmptyReturnUnitPrice := 0;
                                EmptyReturnItemCharge.RESET();
                                EmptyReturnItemCharge.SETRANGE("Document Type", "Document Type"::"Return Order");
                                EmptyReturnItemCharge.SETRANGE("Document No.", "Empty Return Line"."Document No.");
                                EmptyReturnItemCharge.SETRANGE("Attached to Line No.", "Empty Return Line"."Line No.");
                                EmptyReturnItemCharge.SETFILTER(Type, '%1', EmptyReturnItemCharge.Type::"Charge (Item)");
                                // BC Upgrade RD03 Drinkit Field Commented .......>>
                                //EmptyReturnItemCharge.SETFILTER("Item Charge Type", '%1', EmptyReturnItemCharge."Item Charge Type"::Deposit);
                                // BC Upgrade RD03 Drinkit Field Commented .......<<
                                if EmptyReturnItemCharge.FINDSET() then
                                    repeat
                                        EmptyReturnUnitPrice += EmptyReturnItemCharge."Unit Price";
                                    until EmptyReturnItemCharge.NEXT() = 0;

                                LotNo := '';
                                ReservationEntry.RESET();
                                ReservationEntry.SETRANGE("Source ID", "Empty Return Line"."Document No.");
                                ReservationEntry.SETRANGE("Source Type", 37);
                                ReservationEntry.SETRANGE("Source Subtype", ReservationEntry."Source Subtype"::"5");
                                ReservationEntry.SETRANGE("Item No.", "Empty Return Line"."No.");
                                if ReservationEntry.FINDSET() then
                                    repeat
                                        if LotNo = '' then
                                            LotNo := ReservationEntry."Lot No." + ' ' + FORMAT(ReservationEntry."Expiration Date")
                                        else
                                            LotNo := LotNo + ',' + ReservationEntry."Lot No." + ' ' + FORMAT(ReservationEntry."Expiration Date");
                                    until ReservationEntry.NEXT() = 0;
                                //Total by UOM<<
                                TempUnitOfMeasure_EmptyReturn.RESET();
                                if TempUnitOfMeasure_EmptyReturn.GET("Empty Return Line"."Unit of Measure Code") then begin
                                    TempUnitOfMeasure_EmptyReturn."Column 1 Amt." += "Empty Return Line".Quantity;
                                    TempUnitOfMeasure_EmptyReturn.MODIFY();
                                end else begin
                                    TempUnitOfMeasure_EmptyReturn.INIT();
                                    TempUnitOfMeasure_EmptyReturn."Currency Code" := "Empty Return Line"."Unit of Measure Code";
                                    TempUnitOfMeasure_EmptyReturn."Column 1 Amt." := "Empty Return Line".Quantity;
                                    TempUnitOfMeasure_EmptyReturn.INSERT();
                                end;
                                //Total by UOM<<
                            end;

                            trigger OnPreDataItem();
                            begin
                                SETFILTER(Type, '%1', Type::Item);
                                SETRANGE("Document Type", "Document Type"::"Return Order");
                            end;
                        }
                        dataitem("Empty Return UOM Total"; "Integer")
                        {
                            column(TempUnitOfMeasure_EmptyReturn_UOM; TempUnitOfMeasure_EmptyReturn."Currency Code")
                            {
                            }
                            column(TempUnitOfMeasure_EmptyReturn_Quantity; TempUnitOfMeasure_EmptyReturn."Column 1 Amt.")
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then begin
                                    if not TempUnitOfMeasure_EmptyReturn.FIND('-') then
                                        CurrReport.BREAK();
                                end else
                                    if TempUnitOfMeasure_EmptyReturn.NEXT() = 0 then
                                        CurrReport.BREAK();
                            end;

                            trigger OnPostDataItem();
                            begin
                                TempUnitOfMeasure_EmptyReturn.DELETEALL();
                            end;

                            trigger OnPreDataItem();
                            begin
                                TempUnitOfMeasure_EmptyReturn.RESET();
                                SETRANGE(Number, 1, TempUnitOfMeasure_EmptyReturn.COUNT);
                            end;
                        }

                        trigger OnPreDataItem();
                        begin
                            // BC Upgrade RD03 Drinkit Field Commented .......>>
                            //SETRANGE("Link Sales Document No.", "Sales Shipment Header"."Order No.");
                            //SETRANGE("Link Sales Document Type", "Link Sales Document Type"::Order);
                            // BC Upgrade RD03 Drinkit Field Commented .......<<
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    TempTrackingSpecification.DELETEALL();

                    if Number > 1 then begin
                        CopyText := Text001;
                        OutputNo += 1;
                    end else
                        CopyText := '';
                    CLEAR(SubTotal);
                    CLEAR(TotalSubTotal);
                end;

                trigger OnPostDataItem();
                begin

                    if Print then
                        ShptCountPrinted.RUN("Sales Shipment Header");
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
                SalesShipmentHeader: Record "Sales Shipment Header";
                ShipmentMethod: Record "Shipment Method";
                DeliveryTime1: Text;
                DeliveryTime2: Text;
                // BC Upgrade RD03 Drinkit Related Commented .......>>
                //StandardTextReport: Record "Standard Text Report";
                // BC Upgrade RD03 Drinkit Related Commented .......<<
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
                CurrReportID: Integer;
                i: Integer;
                IsTextToInclude: Boolean;
                ItemLedgerEntry: Record "Item Ledger Entry";
                //NoSeriesMgt: Codeunit NoSeriesManagement;
                ModifyHeader: Boolean;
                SalesDepositLines: Record "Sales Shipment Line";
                DepositGroupCode: Code[10];
                // BC Upgrade RD03 Drinkit Related Commented .......>>
                //DrinkDepositGroup: Record "Drink Deposit Group";
                // BC Upgrade RD03 Drinkit Related Commented .......<<
                StartingShipmentdate: Date;
                // BC Upgrade RD03 Drinkit Related Commented .......>>
                //LoyaltyBalanceBuffer: Record "Loyalty Balance Buffer" temporary;
                // BC Upgrade RD03 Drinkit Related Commented .......<<
                BeginBalDate: Date;
                EndBalDate: Date;
                BeginningMonth: Date;
                // BC Upgrade RD03 Drinkit Related Commented .......>>
                //LoyaltyLedgerEntry: Record "Loyalty Ledger Entry";
                // BC Upgrade RD03 Drinkit Related Commented .......<<
                OrderChargeLine: Record "Sales Shipment Line";
                ServiceSetup: Record "Service Mgt. Setup";
                Customer2: Record Customer;
                j: Integer;
            begin
                if ShipToCountryName.GET("Sales Shipment Header"."Ship-to Country/Region Code") then;
                CLEAR(TotalQty);
                CLEAR(TotalQtyHL);

                //-----Company Info
                CompanyInfo.GET;
                //Picture
                CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND");
                //Company Text
                CLEAR(CompanyText);
                CompanyText := CompanyInfo.Name;
                if (CompanyInfo.Address <> '') then
                    CompanyText += ', ' + CompanyInfo.Address;
                if (CompanyInfo."Address 2" <> '') then
                    CompanyText += ', ' + CompanyInfo."Address 2";
                if (CompanyInfo."Post Code" <> '') then
                    CompanyText += ', ' + CompanyInfo."Post Code";
                if (CompanyInfo.City <> '') then
                    CompanyText += ' ' + CompanyInfo.City;
                if (CompanyInfo."Country/Region Code" <> '') then
                    if CountryInfo.GET(CompanyInfo."Country/Region Code") then
                        CompanyText += ', ' + CompanyInfo."Country/Region Code" + ' ' + CountryInfo.Name;
                // BC Upgrade RD03 Drinkit Field Commented .......>>
                //if CompanyInfo."Tax Registration No." <> '' then
                //  CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";

                //if CompanyInfo."Tax Registration No." <> '' then
                CompanyText += '';
                // BC Upgrade RD03 Drinkit Field Commented .......>>
                CompanyText += ', ' + ChOfComm;
                CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";

                //-----Report Title
                CashInvoice := false;
                CLEAR(ReportTitle);
                CLEAR(CashInvoice);
                if ("Payment Method Code" <> '') then begin
                    PaymentMethod.RESET;
                    PaymentMethod.GET("Payment Method Code");
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    //if (PaymentMethod."Cash Payment") then begin
                    ReportTitle := Text002;
                    CashInvoice := true;
                    //end;
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                end;

                if (ReportTitle = '') then
                    if ("Shipment Method Code" <> '') then begin
                        ShipmentMethod.RESET;
                        ShipmentMethod.GET("Shipment Method Code");
                        // BC Upgrade RD03 Drinkit Field Commented .......>>
                        //if ShipmentMethod.Pickup then
                        ReportTitle := Text003;
                        //else
                        ReportTitle := Text004;
                        // BC Upgrade RD03 Drinkit Field Commented .......<<
                    end;
                ReportTitle := Text004;
                //-----Shipment Address
                SalesShipmentHeader.RESET;
                if CashInvoice then begin
                    if ("Bill-to Country/Region Code" = CompanyInfo."Country/Region Code") then begin
                        SalesShipmentHeader.COPY("Sales Shipment Header");
                        SalesShipmentHeader."Bill-to Country/Region Code" := '';
                        FormatAddr.SalesShptBillTo(HeaderAddr, HeaderAddr, SalesShipmentHeader);
                    end else
                        FormatAddr.SalesShptBillTo(HeaderAddr, HeaderAddr, "Sales Shipment Header");
                end else begin
                    if ("Ship-to Country/Region Code" = CompanyInfo."Country/Region Code") then begin
                        SalesShipmentHeader.COPY("Sales Shipment Header");
                        SalesShipmentHeader."Ship-to Country/Region Code" := '';
                        FormatAddr.SalesShptShipTo(HeaderAddr, SalesShipmentHeader);
                    end else
                        FormatAddr.SalesShptShipTo(HeaderAddr, "Sales Shipment Header");
                end;
                //Shipment Text
                CLEAR(PrintShipmentText);
                if CashInvoice then
                    PrintShipmentText := ("Bill-to Name" <> "Ship-to Name") or
                                         ("Bill-to Name 2" <> "Ship-to Name 2") or
                                         ("Bill-to Address" <> "Ship-to Address") or
                                         ("Bill-to Address 2" <> "Ship-to Address 2") or
                                         ("Bill-to Post Code" <> "Ship-to Post Code") or
                                         ("Bill-to City" <> "Ship-to City");

                //-----Header Tel. & Fax
                Customer.RESET;
                Customer.GET("Sell-to Customer No.");

                //-----Shipment Method Info
                if ShipMethod.GET("Shipment Method Code") then
                    ShipMethod.TranslateDescription(ShipMethod, SysLanguage.Code);

                // BC Upgrade RD03 Drinkit Field Commented .......>>
                //-----Route Info
                //if Route <> '' then begin
                //  Routes.RESET;
                //if Routes.GET(Route) then;
                //end;
                // BC Upgrade RD03 Drinkit Field Commented .......<<

                //-----Payment Terms Info
                if PayTerms.GET("Payment Terms Code") then
                    PayTerms.TranslateDescription(PayTerms, SysLanguage.Code);

                // BC Upgrade RD03 Drinkit Field Commented .......>>
                //-----Driver Info
                //if ("Driver Code" <> '') then begin
                // Driver.RESET;
                //Driver.GET("Driver Code");
                //end;
                // BC Upgrade RD03 Drinkit Field Commented .......<<

                //-----SalesPerson Info
                if ("Salesperson Code" <> '') then begin
                    SalesPerson.RESET;
                    SalesPerson.GET("Salesperson Code");
                end;

                //-----Shipping Agent Info
                if ("Shipping Agent Code" <> '') then begin
                    ShippingAgent.RESET;
                    ShippingAgent.GET("Shipping Agent Code");
                end;

                //-----Retunr order Info
                ReturnOrder.RESET;
                ReturnOrder.SETRANGE("Document Type", ReturnOrder."Document Type"::"Return Order");
                // BC Upgrade RD03 Drinkit Field Commented .......>>
                //ReturnOrder.SETRANGE("Link Sales Document No.", "Sales Shipment Header"."Order No.");
                //ReturnOrder.SETRANGE("Link Sales Document Type", ReturnOrder."Link Sales Document Type"::Order);
                // BC Upgrade RD03 Drinkit Field Commented .......>>
                if ReturnOrder.FINDSET then;

                //-----Delivery Times
                CLEAR(TextDeliveryTime);
                CLEAR(blnDeliveryTime);
                // BC Upgrade RD03 Drinkit Field Commented .......>>
                /*if "Delivery Time 1 From" <> 000000T then begin
                    if "Delivery Time 1 To" <> 000000T then
                        DeliveryTime1 := FORMAT("Delivery Time 1 From", 5) + '-' + FORMAT("Delivery Time 1 To", 5)
                    else
                        DeliveryTime1 := FORMAT("Delivery Time 1 From", 5);
                    if DeliveryTime1 <> '' then
                        if ShipmentMethod.Pickup then
                            TextDeliveryTime := Text005 + '  ' + DeliveryTime1
                        else
                            TextDeliveryTime := Text006 + '  ' + DeliveryTime1;
                end;
                if "Delivery Time 2 From" <> 000000T then begin
                    if "Delivery Time 2 To" <> 000000T then
                        DeliveryTime2 := FORMAT("Delivery Time 2 From", 5) + '-' + FORMAT("Delivery Time 2 To", 5)
                    else
                        DeliveryTime2 := FORMAT("Delivery Time 2 From", 5);
                    if DeliveryTime2 <> '' then
                        TextDeliveryTime := TextDeliveryTime + ' ' + Text007 + ' ' + DeliveryTime2;
                end;*/
                // BC Upgrade RD03 Drinkit Field Commented .......>>

                // BC Upgrade RD03 Drinkit Field Commented .......>>
                //blnDeliveryTime := (TextDeliveryTime <> '') and not (ShipmentMethod.Pickup);
                blnDeliveryTime := (TextDeliveryTime <> '');
                // BC Upgrade RD03 Drinkit Field Commented .......<<

                //-----Comment Lines
                TempCommentLine.RESET;
                TempCommentLine.DELETEALL;
                CommentLineNo := 10000;
                //Customer Comments
                CommentLine.RESET;
                CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Customer);
                CommentLine.SETRANGE("No.", "Sell-to Customer No.");
                // BC Upgrade RD03 Drinkit Field Commented .......>>
                //CommentLine.SETRANGE("Print on Shipment", true);
                // BC Upgrade RD03 Drinkit Field Commented .......<<
                if CommentLine.FINDSET then
                    repeat
                        InsertCommentLine(CommentLine.Comment);
                    until CommentLine.NEXT = 0;
                //Sales Comments
                SalesCommentLine.RESET;
                SalesCommentLine.SETRANGE("Document Type", SalesCommentLine."Document Type"::Shipment);
                SalesCommentLine.SETRANGE("No.", "No.");
                // BC Upgrade RD03 Drinkit Field Commented .......>>
                //CommentLine.SETRANGE("Print on Shipment", true);
                // BC Upgrade RD03 Drinkit Field Commented .......<<
                if SalesCommentLine.FINDSET then
                    repeat
                        InsertCommentLine(SalesCommentLine.Comment);
                    until SalesCommentLine.NEXT = 0;

                //-----Footer Texts
                CLEAR(CurrReportID);
                CLEAR(i);
                CLEAR(TextFooter);
                EVALUATE(CurrReportID, COPYSTR(CurrReport.OBJECTID(false), 8));
                // BC Upgrade RD03 Drinkit Field Commented .......>>
                /*StandardTextReport.SETRANGE("Report ID", CurrReportID);
                StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);

                if StandardTextReport.FINDSET then
                    repeat
                        i := 1;
                        ExtendedTextHeader.RESET;
                        ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                        ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                        if ExtendedTextHeader.FINDSET then begin
                            repeat
                                ExtendedTextLine.RESET;
                                ExtendedTextLine.SETRANGE("Table Name", ExtendedTextHeader."Table Name");
                                ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                                ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                                if ExtendedTextLine.FINDSET then begin
                                    repeat
                                        TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                                    until (ExtendedTextLine.NEXT = 0) or (i > ARRAYLEN(TextFooter));
                                end;
                                i += 1;
                            until (ExtendedTextHeader.NEXT = 0);
                        end;
                    until (StandardTextReport.NEXT = 0);*/
                // BC Upgrade RD03 Drinkit Field Commented .......<<
                //-----Empty Goods Block
                TempEmptyGoodItemLine.RESET;
                TempEmptyGoodItemLine.DELETEALL;

                // BC Upgrade RD03 NRQ Field Commented .......>>
                /*case Customer."Empty Returned Items Based On" of
                    Customer."Empty Returned Items Based On"::Document:
                        begin
                            with SalesDepositLines do begin
                                SETCURRENTKEY("Document No.", "Item DDeposit Group Code");
                                SETRANGE("Document No.", "Sales Shipment Header"."No.");
                                SETRANGE(Type, Type::Item);
                                SETFILTER("Item DDeposit Group Code", '<>%1', '');
                                if FINDSET then begin
                                    repeat
                                        if DrinkDepositGroup.GET(DrinkDepositGroup."Source Type"::Item, "Item DDeposit Group Code") then begin
                                            if DrinkDepositGroup."Empty Good Reference Item No." <> '' then begin
                                                TempEmptyGoodItemLine.RESET;
                                                TempEmptyGoodItemLine.SETRANGE("No.", DrinkDepositGroup."Empty Good Reference Item No.");
                                                if not TempEmptyGoodItemLine.FINDFIRST then begin
                                                    LineNo += 10000;
                                                    TempEmptyGoodItemLine.INIT;
                                                    TempEmptyGoodItemLine."No." := DrinkDepositGroup."Empty Good Reference Item No.";
                                                    if Item.GET(DrinkDepositGroup."Empty Good Reference Item No.") then
                                                        TempEmptyGoodItemLine.Description := Item.Description;
                                                    if "Quantity (Base)" > 0 then begin
                                                        TempEmptyGoodItemLine.Quantity := "Quantity (Base)";
                                                        TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                                    end else begin
                                                        TempEmptyGoodItemLine."Quantity (Base)" := -"Quantity (Base)";
                                                        TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                                    end;
                                                    TempEmptyGoodItemLine."Document No." := "No.";
                                                    TempEmptyGoodItemLine."Line No." := LineNo;
                                                    TempEmptyGoodItemLine.INSERT;
                                                end else begin
                                                    if "Quantity (Base)" > 0 then begin
                                                        TempEmptyGoodItemLine.Quantity += "Quantity (Base)";
                                                    end else begin
                                                        TempEmptyGoodItemLine."Quantity (Base)" += -"Quantity (Base)";
                                                    end;
                                                    TempEmptyGoodItemLine.MODIFY;
                                                end;
                                            end;
                                        end;
                                    until (NEXT = 0);
                                end;
                            end;
                        end;
                    Customer."Empty Returned Items Based On"::History:
                        begin
                            DrinkDepositGroup.GET(DrinkDepositGroup."Source Type"::Customer, Customer."Customer DDeposit Group Code");
                            DrinkDepositGroup.TESTFIELD("Empty Good Reference period");
                            StartingShipmentdate := CALCDATE('-' + FORMAT(DrinkDepositGroup."Empty Good Reference period"), "Shipment Date");
                            ItemLedgerEntry.SETCURRENTKEY("Source Type", "Source No.", "Item DDeposit Group Code", "Posting Date");
                            ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
                            ItemLedgerEntry.SETRANGE("Source No.", "Sales Shipment Header"."Sell-to Customer No.");
                            ItemLedgerEntry.SETFILTER("Item DDeposit Group Code", '<>%1', '');
                            ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', StartingShipmentdate, "Sales Shipment Header"."Shipment Date");
                            if ItemLedgerEntry.FINDSET then begin
                                repeat
                                    ItemLedgerEntry.SETRANGE("Item DDeposit Group Code", ItemLedgerEntry."Item DDeposit Group Code");
                                    if DrinkDepositGroup.GET(DrinkDepositGroup."Source Type"::Item, ItemLedgerEntry."Item DDeposit Group Code") then begin
                                        if DrinkDepositGroup."Empty Good Reference Item No." <> '' then begin
                                            with SalesDepositLines do begin
                                                SETCURRENTKEY("Document No.", "Item DDeposit Group Code");
                                                SETRANGE("Document No.", "Sales Shipment Header"."No.");
                                                SETRANGE(Type, Type::Item);
                                                SETRANGE("Item DDeposit Group Code", DrinkDepositGroup.Code);
                                                if FINDSET then begin
                                                    repeat
                                                        TempEmptyGoodItemLine.RESET;
                                                        TempEmptyGoodItemLine.SETRANGE("No.", DrinkDepositGroup."Empty Good Reference Item No.");
                                                        if not TempEmptyGoodItemLine.FINDFIRST then begin
                                                            LineNo += 10000;
                                                            TempEmptyGoodItemLine.INIT;
                                                            TempEmptyGoodItemLine."No." := DrinkDepositGroup."Empty Good Reference Item No.";
                                                            if Item.GET(DrinkDepositGroup."Empty Good Reference Item No.") then
                                                                TempEmptyGoodItemLine.Description := Item.Description;
                                                            if "Quantity (Base)" > 0 then begin
                                                                TempEmptyGoodItemLine.Quantity := "Quantity (Base)";
                                                                TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                                            end else begin
                                                                TempEmptyGoodItemLine."Quantity (Base)" := -"Quantity (Base)";
                                                                TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                                            end;
                                                            TempEmptyGoodItemLine."Document No." := "No.";
                                                            TempEmptyGoodItemLine."Line No." := LineNo;
                                                            TempEmptyGoodItemLine.INSERT;
                                                        end else begin
                                                            if "Quantity (Base)" > 0 then begin
                                                                TempEmptyGoodItemLine.Quantity += "Quantity (Base)";
                                                            end else begin
                                                                TempEmptyGoodItemLine."Quantity (Base)" += -"Quantity (Base)";
                                                            end;
                                                            TempEmptyGoodItemLine.MODIFY;
                                                        end;
                                                    until (NEXT = 0);
                                                end;
                                            end;
                                        end;
                                    end;
                                    ItemLedgerEntry.FINDLAST;
                                    ItemLedgerEntry.SETRANGE("Item DDeposit Group Code");
                                    ItemLedgerEntry.SETFILTER("Item DDeposit Group Code", '<>%1', '');
                                until (ItemLedgerEntry.NEXT = 0);
                            end;
                        end;
                    Customer."Empty Returned Items Based On"::"Fixed Block":
                        begin
                            DrinkDepositGroup.RESET;
                            DrinkDepositGroup.SETRANGE("Include In Fixed Block", true);
                            DrinkDepositGroup.SETFILTER("Empty Good Reference Item No.", '<>%1', '');
                            if not DrinkDepositGroup.ISEMPTY then begin
                                DrinkDepositGroup.FINDSET;
                                repeat
                                    with SalesDepositLines do begin
                                        SETCURRENTKEY("Document No.", "Item DDeposit Group Code");
                                        SETRANGE("Document No.", "Sales Shipment Header"."No.");
                                        SETRANGE(Type, Type::Item);
                                        SETRANGE("Item DDeposit Group Code", DrinkDepositGroup.Code);
                                        if FINDSET then begin
                                            repeat
                                                TempEmptyGoodItemLine.RESET;
                                                TempEmptyGoodItemLine.SETRANGE("No.", DrinkDepositGroup."Empty Good Reference Item No.");
                                                if not TempEmptyGoodItemLine.FINDFIRST then begin
                                                    LineNo += 10000;
                                                    TempEmptyGoodItemLine.INIT;
                                                    TempEmptyGoodItemLine."No." := DrinkDepositGroup."Empty Good Reference Item No.";
                                                    if Item.GET(DrinkDepositGroup."Empty Good Reference Item No.") then
                                                        TempEmptyGoodItemLine.Description := Item.Description;
                                                    if "Quantity (Base)" > 0 then begin
                                                        TempEmptyGoodItemLine.Quantity := "Quantity (Base)";
                                                        TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                                    end else begin
                                                        TempEmptyGoodItemLine."Quantity (Base)" := -"Quantity (Base)";
                                                        TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                                    end;
                                                    TempEmptyGoodItemLine."Document No." := "No.";
                                                    TempEmptyGoodItemLine."Line No." := LineNo;
                                                    TempEmptyGoodItemLine.INSERT;
                                                end else begin
                                                    if "Quantity (Base)" > 0 then begin
                                                        TempEmptyGoodItemLine.Quantity += "Quantity (Base)";
                                                    end else begin
                                                        TempEmptyGoodItemLine."Quantity (Base)" += -"Quantity (Base)";
                                                    end;
                                                    TempEmptyGoodItemLine.MODIFY;
                                                end;
                                            until (NEXT = 0);
                                        end;
                                    end;
                                until (DrinkDepositGroup.NEXT) = 0;
                            end;
                        end;
                    Customer."Empty Returned Items Based On"::"Document / Item(charges)":
                        begin
                            with SalesDepositLines do begin
                                SETCURRENTKEY("Document No.", "Item DDeposit Group Code");
                                SETRANGE("Document No.", "Sales Shipment Header"."No.");
                                SETFILTER("Empty Goods Item No.", '<>%1', '');
                                if FINDSET then begin
                                    repeat
                                        SETFILTER("Empty Goods Item No.", "Empty Goods Item No.");
                                        if FINDSET then
                                            repeat
                                                TempEmptyGoodItemLine.RESET;
                                                TempEmptyGoodItemLine.SETRANGE("No.", "Empty Goods Item No.");
                                                if not TempEmptyGoodItemLine.FINDFIRST then begin
                                                    LineNo += 10000;
                                                    TempEmptyGoodItemLine.INIT;
                                                    TempEmptyGoodItemLine."No." := "Empty Goods Item No.";
                                                    if Item.GET("Empty Goods Item No.") then
                                                        TempEmptyGoodItemLine.Description := Item.Description;
                                                    if "Quantity (Base)" > 0 then begin
                                                        TempEmptyGoodItemLine.Quantity := "Quantity (Base)";
                                                        TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                                    end else begin
                                                        TempEmptyGoodItemLine."Quantity (Base)" := -"Quantity (Base)";
                                                        TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                                    end;
                                                    TempEmptyGoodItemLine."Document No." := "No.";
                                                    TempEmptyGoodItemLine."Line No." := LineNo;
                                                    TempEmptyGoodItemLine.INSERT;
                                                end else begin
                                                    if "Quantity (Base)" > 0 then begin
                                                        TempEmptyGoodItemLine.Quantity += "Quantity (Base)";
                                                    end else begin
                                                        TempEmptyGoodItemLine."Quantity (Base)" += -"Quantity (Base)";
                                                    end;
                                                    TempEmptyGoodItemLine.MODIFY;
                                                end;
                                            until (NEXT = 0);
                                        if FINDLAST then;
                                        SETRANGE("Empty Goods Item No.");
                                        SETFILTER("Empty Goods Item No.", '<>%1', '');
                                    until (NEXT = 0);
                                end;
                            end;
                        end;
                end;*/
                // BC Upgrade RD03 Drinkit Field Commented .......<<

                //-----Currency Code
                if CashInvoice then
                    if ("Currency Code" <> '') then
                        CurrCode := "Currency Code"
                    else begin
                        GLSetup.GET;
                        CurrCode := GLSetup."LCY Code";
                    end;
                //-----Loyalty Statement
                CLEAR(BeginningBalance);
                CLEAR(EndBalance);
                CLEAR(Gains);
                CLEAR(Sales);
                CLEAR(PrintLoyaltyStatement);
                // BC Upgrade RD03 Drinkit Related Commented .......>>
                /*if CashInvoice then
                    if (Customer."Loyalty Statement On" in [Customer."Loyalty Statement On"::"Delivery Note",
                                                           Customer."Loyalty Statement On"::"Invoice + Delivery Note"])
                    then begin
                        PrintLoyaltyStatement := true;
                        LoyaltyBalanceBuffer.INIT;
                        LoyaltyBalanceBuffer.SETFILTER("Source Type Filter", '%1', LoyaltyBalanceBuffer."Source Type Filter"::Customer);
                        LoyaltyBalanceBuffer.SETFILTER("Source No. Filter", Customer."No.");

                        BeginBalDate := CALCDATE('<CM-1M>', "Posting Date");
                        LoyaltyBalanceBuffer.SETFILTER("Date Filter", '..%1', BeginBalDate);
                        LoyaltyBalanceBuffer.CALCFIELDS("Net Point Change (Actual)");
                        BeginningBalance := LoyaltyBalanceBuffer."Net Point Change (Actual)";

                        EndBalDate := CALCDATE('<CM>', "Posting Date");
                        LoyaltyBalanceBuffer.SETFILTER("Date Filter", '..%1', EndBalDate);
                        LoyaltyBalanceBuffer.CALCFIELDS("Net Point Change (Actual)");
                        EndBalance := LoyaltyBalanceBuffer."Net Point Change (Actual)";

                        BeginningMonth := CALCDATE('<1D>', BeginBalDate);

                        LoyaltyLedgerEntry.RESET;
                        LoyaltyLedgerEntry.SETFILTER("Source Type", '%1', LoyaltyLedgerEntry."Source Type"::Customer);
                        LoyaltyLedgerEntry.SETFILTER("Source No.", Customer."No.");
                        LoyaltyLedgerEntry.SETFILTER("Posting Date", '%1..%2', BeginningMonth, EndBalDate);
                        LoyaltyLedgerEntry.SETRANGE("Entry Type", LoyaltyLedgerEntry."Entry Type"::Sale);
                        LoyaltyLedgerEntry.SETRANGE("Loyalty Type", LoyaltyLedgerEntry."Loyalty Type"::Point);
                        LoyaltyLedgerEntry.CALCSUMS("Point Amount (Actual)");
                        Gains := LoyaltyLedgerEntry."Point Amount (Actual)";

                        LoyaltyLedgerEntry.SETFILTER("Entry Type", '<>%1', LoyaltyLedgerEntry."Entry Type"::Sale);
                        LoyaltyLedgerEntry.CALCSUMS("Point Amount (Actual)");
                        Sales := LoyaltyLedgerEntry."Point Amount (Actual)";
                    end;
                SalesShptLine.CalcVATAmountLines("Sales Shipment Header", VATAmountLine);*/
                // BC Upgrade RD03 Drinkit Related Commented .......<<

                CLEAR(TotalDeposits);
                CLEAR(TotalDiscounts);
                CLEAR(TotalTaxes);

                //-----Order total /blank Discount Charges
                if CashInvoice then begin
                    OrderChargeLine.RESET;
                    OrderChargeLine.SETRANGE("Document No.", "No.");
                    OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    //OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Discount);
                    //OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" ");
                    // BC Upgrade RD03 Drinkit Field Commented .......<<
                    if OrderChargeLine.FINDSET then begin
                        PrintOrderDiscounts := true;
                        repeat
                            TempOrderDiscountCharge.INIT;
                            TempOrderDiscountCharge := OrderChargeLine;
                            TempOrderDiscountCharge.INSERT;
                        until (OrderChargeLine.NEXT = 0);
                        // BC Upgrade RD03 Drinkit Field Commented .......>>
                        //OrderChargeLine.CALCSUMS("Line Amount");
                        //TotalDiscounts += OrderChargeLine."Line Amount";
                        // BC Upgrade RD03 Drinkit Field Commented .......>>
                    end;
                    //-----Order total /blank Deposit Charges
                    OrderChargeLine.RESET;
                    OrderChargeLine.SETRANGE("Document No.", "No.");
                    OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    //OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Deposit);
                    //OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" ");
                    // BC Upgrade RD03 Drinkit Field Commented .......<<
                    if OrderChargeLine.FINDSET then begin
                        PrintOrderDeposits := true;
                        repeat
                            TempOrderDepositCharge.INIT;
                            TempOrderDepositCharge := OrderChargeLine;
                            TempOrderDepositCharge.INSERT;
                        until (OrderChargeLine.NEXT = 0);
                        // BC Upgrade RD03 Drinkit Field Commented .......>>
                        //OrderChargeLine.CALCSUMS("Line Amount");
                        //TotalDeposits += OrderChargeLine."Line Amount";
                        // BC Upgrade RD03 Drinkit Field Commented .......<<
                    end;
                    //-----Order total /blank Tax Charges
                    OrderChargeLine.RESET;
                    OrderChargeLine.SETRANGE("Document No.", "No.");
                    OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    //OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Tax);
                    //OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" ");
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                    /*if OrderChargeLine.FINDSET then begin
                        repeat
                            if (OrderChargeLine."Line Amount" <> 0) then begin
                                PrintOrderTaxes := true;
                                TempOrderTaxCharge.INIT;
                                TempOrderTaxCharge := OrderChargeLine;
                                TempOrderTaxCharge.INSERT;
                            end;
                        until (OrderChargeLine.NEXT = 0);
                        OrderChargeLine.CALCSUMS("Line Amount");
                        TotalTaxes += OrderChargeLine."Line Amount";
                    end;*/
                    // BC Upgrade RD03 Drinkit Field Commented .......>>
                end;

                // Tracking Info
                ShowLotSerialInfo := false;
                // BC Upgrade RD03 Drinkit Field Commented .......>>
                //ShowLotSerialInfo := Customer."Exp. Date on Del. Note";
                // BC Upgrade RD03 Drinkit Field Commented .......<<

                if ShowLotSerialInfo then
                    TrackingInfoDescriptionLbl := LotSerialInfoLbl
                else
                    TrackingInfoDescriptionLbl := Text027;

                // CTS Document
                ServiceSetup.GET;
                Customer2.GET("Sell-to Customer No.");

                CTSDocumentSubtype := "Document Subtype Code FND" = ServiceSetup."CTS Document Subtype FND";//BC UPGRADE VAMSIU01 added>>

                if CTSDocumentSubtype then
                    ReportTitle := CTSLbl + ' ' + ReportTitle;
                // BC Upgrade RD03 Drinkit Related Commented .......>>
                /*MasterDataProperty.SETRANGE("Table ID", 18);
                MasterDataProperty.SETRANGE(Code, Customer2."No.");
                MasterDataProperty.SETRANGE("Property Code", ServiceSetup."CTS Technician Property Code");
                if MasterDataProperty.FINDFIRST then
                    MasterDataProperty.CALCFIELDS(Name);*/
                // BC Upgrade RD03 Drinkit Related Commented .......<<

                // Responsibility Center
                if ResponsibilityCenter.FINDSET then begin
                    j := 1;
                    repeat
                        RespCenter_Code[j] := ResponsibilityCenter.Code;
                        RespCenter_PostCode[j] := ResponsibilityCenter."Post Code";
                        RespCenter_PhoneNo[j] := ResponsibilityCenter."Phone No.";
                        RespCenter_FaxNo[j] := ResponsibilityCenter."Fax No.";
                        j += 1;
                    until ResponsibilityCenter.NEXT = 0;
                end;
                // BC Upgrade RD03 Drinkit Field Commented .......>>
                //if WhseShippingTruck.GET("Sales Shipment Header"."Truck Code") then;
                // BC Upgrade RD03 Drinkit Field Commented .......<<

                PlannedDeliveryDate := 0D;
                SalesShptLine.RESET;
                SalesShptLine.SETRANGE("Document No.", "No.");
                SalesShptLine.SETFILTER("Planned Delivery Date", '<>%1', 0D);
                if SalesShptLine.FINDFIRST then
                    PlannedDeliveryDate := SalesShptLine."Planned Delivery Date";
            end;

            trigger OnPreDataItem();
            begin

                Print := Print or not CurrReport.PREVIEW;
                // BC Upgrade RD03 Drinkit Field Commented .......>>
                //if RoutePlnaningNo <> '' then
                //SETFILTER("Route Planning No.", RoutePlnaningNo);
                // BC Upgrade RD03 Drinkit Field Commented .......<<
                if PostedWareHouseShipmentNo <> '' then
                    SETFILTER("Posted Whse. Shipment No. FND", PostedWareHouseShipmentNo);
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
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = all;
                    }
                    field(InclPrices; InclPrices)
                    {
                        Caption = 'Incl. Price';
                        ApplicationArea = all;
                    }
                    field(InclDeposit; InclDeposit)
                    {
                        Caption = 'Incl. Deposit';
                        ApplicationArea = all;
                    }
                    field(RoutePlnaningNo; RoutePlnaningNo)
                    {
                        Caption = 'Route Planing No.';
                        ApplicationArea = all;
                        Visible = RoutePlaningControlVisible;
                    }
                    field(PostedWareHouseShipmentNo; PostedWareHouseShipmentNo)
                    {
                        Caption = 'Posted Warehouse Shipment No.';
                        Visible = RoutePlaningControlVisible;
                        ApplicationArea = all;
                        // BC Upgrade RD03 Drinkit Field Commented .......>>
                        /*trigger OnLookup(Text: Text): Boolean;
                        begin
                            //HEI.07>>
                            PostedWhseShipmentHeader.RESET;
                            PostedWhseShipmentHeader.SETRANGE("Route Planning No.", RoutePlnaningNo);
                            if PAGE.RUNMODAL(0, PostedWhseShipmentHeader) = ACTION::LookupOK then
                                PostedWareHouseShipmentNo := PostedWhseShipmentHeader."No.";
                            //HEI.07<<
                        end;*/
                        // BC Upgrade RD03 Drinkit Field Commented .......<<
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            // BC Upgrade RD03 Drinkit Field Commented .......>>
            //HEI.07>>
            //RoutePlnaningNo := "Sales Shipment Header".GETFILTER("Route Planning No.");
            //if RoutePlnaningNo <> '' then
            //RoutePlaningControlVisible := true;
            //HEI.07<<
            // BC Upgrade RD03 Drinkit Field Commented .......>>
        end;
    }

    labels
    {
        UserIDLbl = 'User ID'; DateLbl = 'Date'; label(LocationCodeLbl; ENU = 'Location Code',
                                                                     FRA = 'Code du magasin')
        label(TruckCodeLbl; ENU = 'Truck Code & Description',
                           FRA = 'Code et description du camion')
        GateEntryLbl = 'Gate Entry'; label(PrintDate; ENU = 'Print Date',
                                                    FRA = 'Date d''Impression')
        label(SalesOrderNoLbl; ENU = 'Sales Order No.',
                              FRA = 'N° Commande Vente')
        label(QuantityReceivedLbl; ENU = 'Quantity Received',
                                  FRA = 'Quantité reçue')
        TechnicianNameLbl = 'Technician Name'; label(DriverSignatureLbl; ENU = 'Driver Signature',
                                                                       FRA = 'Signature du chauffeur')
        WarehouseKeeperSignatureLbl = 'Warehouse Keeper Signature'; label(ResponsiblePersonLbl; ENU = 'Responsible Person',
                                                                                              FRA = 'Signature du contrôleur ')
        label(SecurityVisaLbl; ENU = 'Security Visa',
                              FRA = 'Visa de sécurité ')
        TradeRegisterLbl = 'Trade Register'; VATNoLbl = 'VAT No.'; HeadOfficeLbl = '(Head Office)'; POBoxLbl = 'PO Box'; TelLbl = 'Tel:'; FaxLbl = 'Fax:'; label(DocumentDateLbl; ENU = 'Document Date',
                                                                                                                                                                           FRA = 'Date du Document')
        label(ShipmentDateLbl; ENU = 'Shipment Date',
                              FRA = 'Date d''Expédition')
        label(BillToCustomerLbl; ENU = 'Bill to Customer No.',
                                FRA = 'Facturé au client N°')
        label(ShipToCustomerLbl; ENU = 'Ship to Customer No.',
                                FRA = 'Livré au client N°')
        label(ShipToAddressLbl; ENU = 'Ship to address',
                               FRA = 'Destinataire adresse')
        label(AddressLbl; ENU = 'Address',
                         FRA = 'Adresse')
        label(Address2Lbl; ENU = 'Address 2',
                          FRA = 'Adresse 2')
        label(PostCodeLbl; ENU = 'Post Code',
                          FRA = 'Code Postal')
        label(CityLbl; ENU = 'City',
                      FRA = 'Ville')
        label(CountryLbl; ENU = 'Country',
                         FRA = 'Pays')
        label(PhoneLbl; ENU = 'Phone No.',
                       FRA = 'N° de téléphone ')
        LocationCodeNameLbl = 'Location Code & Name'; ShipmentNoLbl = 'Shipment No.'; label(DriverCodeLbl; ENU = 'Driver Code & Description',
                                                                                                        FRA = 'Code et description du chauffeur')
        label(UnitPriceLbl; ENU = 'Unit Price',
                           FRA = 'Prix unitaire')
        label(DiscountLbl; ENU = 'Disc',
                          FRA = 'Remise')
        label(VatRateLbl; ENU = 'Vat Rate',
                         FRA = 'Taux de TVA')
        label(NetAmountLbl; ENU = 'Net Amount',
                           FRA = 'Montant Net')
        label(ExtDocNoLbl; ENU = 'External doc. No.',
                          FRA = 'N° Doc. Externe ')
        label(ShippingAgentLbl; ENU = 'Shipping Agent',
                               FRA = 'Transporteur')
        label(SalesPersonLbl; ENU = 'Sales person',
                             FRA = 'Personnel de vente')
        label(GateEntryNoLbl; ENU = 'Gate control No.',
                             FRA = 'N° contrôle de porte ')
        label(UomLbl; ENU = 'Unit Of Measure',
                     FRA = 'Code unité ')
        label(TotalLbl; ENU = 'Total Qty',
                       FRA = 'Qté Totale')
        label(EmptyLbl; ENU = 'Empties to return',
                       FRA = 'Consigne ou bouteilles à retourner')
        label(PaymentTermsLbl; ENU = 'Payment Term',
                              FRA = 'Condition Paiement')
        label(ShipMethodLbl; ENU = 'Shipment Method',
                            FRA = 'Condition Livraison')
        label(YourRefLbl; ENU = 'Your Reference',
                         FRA = 'Référence')
        label(RouteLbl; ENU = 'Route',
                       FRA = 'Itinéraire')
        label(ReturnOrderLbl; ENU = 'Sales Return Order',
                             FRA = 'Commande de retour')
        label(PlannedDeliveryDateLbl; ENU = 'Planned Delivery Date',
                                     FRA = 'Date livraison prévue')
        label(ActualDeliveryDateLbl; ENU = 'Actual Delivery Date',
                                    FRA = 'Date livraison effective')
        SignaturesLbl = 'Signatures'; label(NameLbl; ENU = 'Name',
                                                   FRA = 'Nom')
        SignatureLbl = 'Signature'; label(WHRepresentativeLbl; ENU = 'Warehouse Representative',
                                                             FRA = 'Responsable Entrepôt')
        label(DriverLbl; ENU = 'Driver',
                        FRA = 'Chauffeur')
        label(GateControlLbl; ENU = 'Gate Control',
                             FRA = 'Poste de Garde')
        label(CustomerLbl; ENU = 'Customer',
                          FRA = 'Client')
    }

    trigger OnInitReport();
    begin
        RoutePlaningControlVisible := false;
        SysLanguage.SETRANGE("Windows Language ID", CurrReport.LANGUAGE);
        if SysLanguage.FINDFIRST then;
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyText: Text;
        OutputNo: Integer;
        TextFooter: array[3] of Text;
        FormatAddr: Codeunit "Format Address";
        Customer: Record Customer;
        ReportTitle: Text;
        // BC Upgrade RD03 Drinkit Related Commented .......>>
        //Driver: Record "Whse. Shipping Driver";
        // BC Upgrade RD03 Drinkit Related Commented .......<<
        SalesPerson: Record "Salesperson/Purchaser";
        blnDeliveryTime: Boolean;
        TextDeliveryTime: Text;
        CommentLine: Record "Comment Line";
        SalesCommentLine: Record "Sales Comment Line";
        TempCommentLine: Record "Comment Line" temporary;
        CommentLineNo: Integer;
        TempMarketingText: Record "Extended Text Line" temporary;
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShptCountPrinted: Codeunit "Sales Shpt.-Printed";
        Print: Boolean;
        QtyHL: Decimal;
        CrossRefText: Text;
        ExpirationDate: Date;
        // BC Upgrade RD03 Drinkit Related Commented .......>>
        //FreeReasonCode: Record "Free Reason Code";
        // BC Upgrade RD03 Drinkit Related Commented .......<<
        FreeReasonText: Text;
        Item: Record Item;
        TempEmptyGoodItemLine: Record "Sales Shipment Line" temporary;
        Text001: Label 'COPY';
        LineNo: Integer;
        PaymentMethod: Record "Payment Method";
        PrintShipmentText: Boolean;
        PrintPrice: Boolean;
        TempOrderDiscountCharge: Record "Sales Shipment Line" temporary;
        TotalOrderDiscCharges: Decimal;
        SubTotal: Decimal;
        CashInvoice: Boolean;
        CurrCode: Code[10];
        GLSetup: Record "General Ledger Setup";
        // BC Upgrade RD03 Drinkit Related Commented .......>>
        //SalesDepositItemCharge: Record "Sales Deposit Item Charge";
        // BC Upgrade RD03 Drinkit Related Commented .......<<
        BeginningBalance: Decimal;
        EndBalance: Decimal;
        Gains: Decimal;
        Sales: Decimal;
        PrintLoyaltyStatement: Boolean;
        LineAmount: Decimal;
        TempOrderDepositCharge: Record "Sales Shipment Line" temporary;
        TotalSubTotal: Decimal;
        PrintOrderDiscounts: Boolean;
        PrintOrderDeposits: Boolean;
        VATAmountLine: Record "VAT Amount Line" temporary;
        Text2014416: Label 'VAT %1%';
        VATPerText: Text;
        Text002: TextConst ENU = 'Delivery Note', FRA = 'BON DE LIVRAISON';
        Text003: Label 'Pickup Note';
        Text004: Label 'Delivery Note';
        Text005: Label 'Pickup';
        Text006: Label 'Delivery';
        Text007: Label 'and';
        Text008: Label '"EAN: "';
        Text009: Label '"Your Reference: "';
        Text010: Label '"Delivery Address: "';
        Text011: Label 'Tel.';
        Text012: Label 'Fax.';
        Text013: Label 'Customer No.';
        Text014: TextConst ENU = 'Shipment No.', FRA = 'N° d''Expédition';
        Text015: Label 'Invoice No.';
        Text016: Label 'Shipment Date';
        Text017: Label 'Order No.';
        Text018: Label 'Route';
        Text019: Label 'Driver Code';
        Text020: Label 'Salesperson';
        Text021: Label 'Phone No.';
        Text022: TextConst ENU = 'Page', FRA = 'Page';
        Text023: Label '" of "';
        Text024: TextConst ENU = 'No.', FRA = 'N°';
        Text025: TextConst ENU = 'Item / Description', FRA = 'Description Article';
        Text026: Label '"Expiration Date: "';
        Text027: TextConst ENU = 'Lot/Serial & BBdate', FRA = 'N° Lot/Série et DLUO';
        Text028: TextConst ENU = 'Quantity', FRA = 'Quantité';
        Text029: TextConst ENU = 'UOM', FRA = 'Code unité';
        Text030: Label 'HL';
        Text031: TextConst ENU = 'Comment', FRA = 'Commentaires';
        Text032: TextConst ENU = 'Unit Price', FRA = 'Prix unitaire';
        Text033: Label 'VAT %';
        Text034: Label 'Amount';
        Text035: Label 'Goods Value';
        Text037: Label 'Order Discount';
        Text038: Label 'Deposit value delivered';
        Text039: Label 'Total';
        Text040: Label 'excl. VAT';
        Text041: Label 'VAT Amount';
        Text042: Label 'Total delivered';
        Text043: Label 'incl. VAT';
        Text044: Label 'Total returned';
        Text045: Label 'VAT Amount in returns';
        Text046: Label 'Total all';
        Text047: Label 'Empty Good Returns';
        Text048: Label 'Empty Good item';
        Text049: Label 'Deposit value';
        Text050: Label 'Shipped quantity';
        Text051: Label 'Returned quantity';
        Text052: Label 'Difference';
        Text053: Label 'Other Returns';
        Text054: Label 'Received and Recognized:';
        Text055: Label 'Cash payment';
        Text056: Label 'Customer''s signature';
        Text057: Label 'Amount received - Driver''s signature';
        SalesShptLine: Record "Sales Shipment Line";
        SalesSetup: Record "Sales & Receivables Setup";
        TotalDiscounts: Decimal;
        TotalDeposits: Decimal;
        Text058: Label 'Loyalty Statement';
        Text059: Label 'Balance before';
        Text060: Label 'Increase';
        Text061: Label 'Decrease';
        Text062: Label 'Balance after';
        PrintUnderLineCharge: Boolean;
        TempUnderChargeLine: Record "Sales Shipment Line" temporary;
        TempOrderTaxCharge: Record "Sales Shipment Line" temporary;
        PrintOrderTaxes: Boolean;
        TotalTaxes: Decimal;
        TempTrackingInfo: Record "Item Ledger Entry" temporary;
        TrackingText: Text[103];
        TrackingText1: Text[250];
        LotNoQty: Decimal;
        MoreLotSerialLines: Boolean;
        ShowLotSerialInfo: Boolean;
        TrackingInfoDescriptionLbl: Text[30];
        LotSerialInfoLbl: Label 'Lot/Serial Info';
        DocumentSendingProfile: Record "Document Sending Profile";
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        ExtendedTextBuffer: Record "Extended Text Line" temporary;
        CTSDocumentSubtype: Boolean;
        // BC Upgrade RD03 Drinkit Related Commented .......>>
        //MasterDataProperty: Record "Master Data Property";
        // BC Upgrade RD03 Drinkit Related Commented .......<<
        CTSLbl: Label 'CTS';
        ResponsibilityCenter: Record "Responsibility Center";
        RespCenter_Code: array[8] of Text[50];
        RespCenter_PostCode: array[8] of Text[50];
        RespCenter_PhoneNo: array[8] of Text[50];
        RespCenter_FaxNo: array[8] of Text[50];
        HeaderAddr: array[8] of Text[50];
        Text063: Label 'Sales Order No.';
        TempTrackingSpecification: Record "Item Ledger Entry" temporary;
        // BC Upgrade RD03 Drinkit Related Commented .......>>
        //DocTrackingManagement: Codeunit "Document Tracking Management";
        // BC Upgrade RD03 Drinkit Related Commented .......<<
        LotNoCnt: Integer;
        TotalQty: Decimal;
        TotalQtyHL: Decimal;
        // BC Upgrade RD03 Drinkit Related Commented .......>>
        //WhseShippingTruck: Record "Whse. Shipping Truck";
        // BC Upgrade RD03 Drinkit Related Commented .......<<
        ShipToCountryName: Record "Country/Region";
        TotalNetAmount: Decimal;
        ShippingAgent: Record "Shipping Agent";
        InclPrices: Boolean;
        TempUnitOfMeasure: Record "Aging Band Buffer" temporary;
        CountryInfo: Record "Country/Region";
        TaxNoID: Label 'Tax Number ID:';
        ChOfComm: Label 'Chamber of commerce:';
        ContactNo: Label 'Contact Number:';
        FaxNo: Label 'Fax Number:';
        EmailComp: Label 'E-mail:';
        ShipMethod: Record "Shipment Method";
        PayTerms: Record "Payment Terms";
        // BC Upgrade RD03 Drinkit Related Commented .......>>
        //Routes: Record Route;
        // BC Upgrade RD03 Drinkit Related Commented .......<<
        ReturnOrder: Record "Sales Header";
        InclDeposit: Boolean;
        EmptyReturnItemCharge: Record "Sales Line";
        EmptyReturnUnitPrice: Decimal;
        RoutePlnaningNo: Code[30];
        PostedWareHouseShipmentNo: Code[200];
        PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header";
        WarehouseShipmentList: Page "Posted Whse. Shipment List";
        RoutePlaningControlVisible: Boolean;
        PlannedDeliveryDate: Date;
        ActualDeliveryDate: Date;
        TempUnitOfMeasure_EmptyReturn: Record "Aging Band Buffer";
        ReservationEntry: Record "Reservation Entry";
        LotNo: Code[250];
        SysLanguage: Record Language;
        BarcodeLines: Text;
        BarcodeNumber: Text;
        HeinekenGlobal: Codeunit "Heineken Global";

    procedure InsertCommentLine(Comment: Text);
    begin
        TempCommentLine.INIT();
        TempCommentLine."Line No." := CommentLineNo;
        TempCommentLine.Comment := Comment;
        TempCommentLine.INSERT();
        CommentLineNo += 10000;
    end;

    local procedure GetCrossReferences() CrossRef: Text;
    var
        ItemCrossReference: Record "Item Reference"; //BC UPGRADE RD03 Table Replaced in BC with "Item Cross Reference"
    begin
        /*ItemCrossReference.RESET();
        ItemCrossReference.SETRANGE("Item No.", "Sales Shipment Line"."No.");
        ItemCrossReference.SETRANGE("Reference Type", ItemCrossReference."Cross-Reference Type"::"Bar Code");
        if ItemCrossReference.FINDFIRST then
            CrossRef := Text008 + ItemCrossReference."Cross-Reference No.";
        ItemCrossReference.RESET;
        ItemCrossReference.SETRANGE("Item No.", "Sales Shipment Line"."No.");
        ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::Customer);
        ItemCrossReference.SETRANGE("Cross-Reference Type No.", "Sales Shipment Line"."Sell-to Customer No.");
        if ItemCrossReference.FINDFIRST then begin
            if (CrossRef = '') then
                CrossRef := Text009 + ItemCrossReference."Cross-Reference No."
            else
                CrossRef += ' / ' + Text009 + ItemCrossReference."Cross-Reference No.";
        end;*/
        //BC UPGRADE RD03>> Changin Whole Fnc Based on Replaced table and Field from "Cross-Reference No." to "Reference No." and Table from ("Item Cross Reference" to "Item Reference")
        ItemCrossReference.Reset();
        ItemCrossReference.SetRange("Item No.", "Sales Shipment Line"."No.");
        ItemCrossReference.SetRange("Reference Type", ItemCrossReference."Reference Type"::"Bar Code");
        if ItemCrossReference.FindFirst() then
            CrossRef := Text008 + ItemCrossReference."Reference No.";

        ItemCrossReference.Reset();
        ItemCrossReference.SetRange("Item No.", "Sales Shipment Line"."No.");
        ItemCrossReference.SetRange("Reference Type", ItemCrossReference."Reference Type"::Customer);
        ItemCrossReference.SetRange("Reference Type No.", "Sales Shipment Line"."Sell-to Customer No.");
        if ItemCrossReference.FindFirst() then begin
            if CrossRef = '' then
                CrossRef := Text009 + ItemCrossReference."Reference No."
            else
                CrossRef += '/' + Text009 + ItemCrossReference."Reference No.";
        end;
    end;

    local procedure IsEmptyGoodItem(): Boolean;
    begin
        if ("Sales Shipment Line".Type <> "Sales Shipment Line".Type::Item) or (("Sales Shipment Line".Type = "Sales Shipment Line".Type::Item) and ("Sales Shipment Line"."No." = '')) then
            exit;
        // BC Upgrade RD03 Drinkit Field Commented .......>>
        //Item.GET("Sales Shipment Line"."No.");
        //Item.CALCFIELDS("Empty Good");
        //exit(Item."Empty Good");
        // BC Upgrade RD03 Drinkit Field Commented .......<<
    end;

    procedure SetRoute(pRoutePlaningNo: Code[100]);
    begin
        RoutePlnaningNo := pRoutePlaningNo;
        RoutePlaningControlVisible := true;
    end;

    local procedure GetBarCode() CrossRef: Text;
    var
        ItemCrossReference: Record "Item Reference"; //BC UPGRADE RD03 Table Replaced in BC with "Item Cross Reference"
    begin
        //HEI.01<<
        ItemCrossReference.RESET();
        ItemCrossReference.SETRANGE("Item No.", "Sales Shipment Line"."No.");
        ItemCrossReference.SETRANGE("Unit of Measure", "Sales Shipment Line"."Unit of Measure Code");
        if ItemCrossReference.FINDFIRST() then
            CrossRef := ItemCrossReference."Reference No."
        //HEI.01>>
    end;
}

