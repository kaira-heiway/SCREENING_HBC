report 52004 "Posted Purchase Receipt STD"
{
    // version HEI.01

    // DITW110.00.11 AKH 02/11/2017 NRQ#43605 New Report
    // 
    // HEI.01 FDD-RW-GAPLOG02 IBM NASTAA02 10.09.2018 # Delivery Note
    //   # Copied Report 50161 - Delivery Note - Shipment Alm and created dataset and layout according to Rwanda requirements
    // HEI.02 FDD-HT742 IBM BULIMC01 07.08.2019 #new report for Ethiopia created from a copy of 50268 - Delivery Note - Shipment STD report.
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID is 50298.
    // 2. Remove Drink-IT fields and related code("Unit Volume HL", "Line Amount", "Free Item", "Line Discount Amount", "Cash Payment", "Print On Purchase Order", "Link Purch. Document No.", "Link Purch. Document Type", "Truck Code", "Driver Code", "Bank Name 2", "IBAN 2", "Route", "SWIFT Code 2", "Tax Registration No.", "Shipping Agent Service Code", "Document Subtype Code")
    // 3. Remove Drink-IT Tables and related code (Routes (Table), MasterDataProperty (Table 2029625), WhseShippingTruck (Table), Driver (Table 2014063), StandardTextReport (Table 2014410), WhseShippingTruck (Table 2014068), Routes (Table 2014072), Item Cross Reference (obsolete in BC)
    // 4. Add ApplicationArea property in Report and requestpage fields.
    // 5. Add layout path and Change extension RDLC to RDL.
    // 6. Removed Drink-IT Columns from Dataset and from rdl layout.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Posted Purchase Receipt STD.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    Caption = 'Posted Purchase Receipt STD';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purch. Receipt Header';
            column(No_SalesHeader; "No.")
            {
            }
            column(InclPrices; InclPrices)
            {
            }
            column(InclDeposit; InclDeposit)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(ReturnOrderNo; ReturnOrder."No.")
                    {
                    }
                    // BC Upgrade BHARAD11 >> ----Drink-IT Table(Routes) This field has also been removed from the layout.
                    // column(RouteName; Routes.Name)
                    // {
                    // }
                    // BC Upgrade BHARAD11 << ----Drink-IT Table(Routes) This field has also been removed from the layout.

                    column(CopyTextCaption; STRSUBSTNO(Text002, CopyText))
                    {
                    }
                    column(ShipMethod; ShipMethod.Description)
                    {
                    }
                    column(PayTerms; PayTerms.Description)
                    {
                    }
                    column(YourReference; "Purch. Rcpt. Header"."Your Reference")
                    {
                    }
                    column(CTSDocumentSubtype; CTSDocumentSubtype)
                    {
                    }
                    // BC Upgrade BHARAD11 >> ----Drink-IT Table(MasterDataProperty) This field has also been removed from the layout.
                    // column(TechnicianName; MasterDataProperty.Name)
                    // {
                    // }
                    // BC Upgrade BHARAD11 << ----Drink-IT Table(MasterDataProperty) This field has also been removed from the layout.

                    column(Comments; Var_Comments)
                    {
                    }
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
                    // BC Upgrade BHARAD11 >> ----Drink-IT Fields("Bank Name 2","IBAN 2",Route,"SWIFT Code 2","IBAN 2") This field has also been removed from the layout.
                    // column(CompanyInfo__BankName__2; CompanyInfo."Bank Name 2")
                    // {
                    // }
                    // column(CompanyInfo__IBAN__2; CompanyInfo."IBAN 2")
                    // {
                    // }
                    // column(CompanyInfo__SWIFTCode__2; CompanyInfo."SWIFT Code 2")
                    // {
                    // }
                    // column(Route_SalesHeader; "Purch. Rcpt. Header".Route)
                    // {
                    // }
                    // BC Upgrade BHARAD11 << ----Drink-IT Fields("Bank Name 2","IBAN 2",Route,"SWIFT Code 2","IBAN 2") This field has also been removed from the layout.

                    column(CompanyInfo__BankName; CompanyInfo."Bank Name")
                    {
                    }


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
                    column(PhoneNo_Customer; Vendor."Phone No.")
                    {
                    }
                    column(FaxNo_Customer; Vendor."Fax No.")
                    {
                    }
                    column(SellToCust_SalesHeader; "Purch. Rcpt. Header"."Buy-from Vendor No.")
                    {
                    }
                    column(AdressVendor_PurchRcptHeader; "Purch. Rcpt. Header"."Pay-to Address")
                    {
                    }
                    column(ShippingNo_SalesHeader; "Purch. Rcpt. Header"."Order No.")
                    {
                    }
                    column(BillToCust_SalesHeader; "Purch. Rcpt. Header"."Pay-to Vendor No.")
                    {
                    }
                    column(BillToCustName; "Purch. Rcpt. Header"."Pay-to Name")
                    {
                    }

                    column(ShipToName_SalesHeader; "Purch. Rcpt. Header"."Buy-from Vendor Name")
                    {
                    }
                    column(ShipToName2_SalesHeader; "Purch. Rcpt. Header"."Buy-from Vendor Name 2")
                    {
                    }
                    column(ShipmentDate_SalesHeader; "Purch. Rcpt. Header"."Posting Date")
                    {
                    }
                    column(ShipToAddress_SalesHeader; "Purch. Rcpt. Header"."Buy-from Address")
                    {
                    }
                    column(ShipToAddress2_SalesHeader; "Purch. Rcpt. Header"."Buy-from Address 2")
                    {
                    }
                    column(ShipToPostCode_SalesHeader; "Purch. Rcpt. Header"."Pay-to Post Code")
                    {
                    }
                    column(ShipToCity_SalesHeader; "Purch. Rcpt. Header"."Buy-from City")
                    {
                    }
                    column(BuyFromCountry_PuchRcptHeader; "Purch. Rcpt. Header"."Ship-to Country/Region Code")
                    {
                    }
                    column(SalesShipmentHeader_UserID; "Purch. Rcpt. Header"."User ID")
                    {
                    }
                    column(SalesShipmentHeader_DocumentDate; "Purch. Rcpt. Header"."Document Date")
                    {
                    }
                    column(SalesShipmentHeader_LocationCode; "Purch. Rcpt. Header"."Location Code")
                    {
                    }
                    // BC Upgrade BHARDA11 >> --Drink-IT Field("Truck Code") This field has also been removed from the layout.
                    // column(SalesShipmentHeader_TruckCode; "Purch. Rcpt. Header"."Truck Code")
                    // {
                    // }
                    // BC Upgrade BHARDA11 << --Drink-IT Field("Truck Code") This field has also been removed from the layout.

                    column(VendorOrderNo_PurchRcptHeader; "Purch. Rcpt. Header"."Vendor Order No.")
                    {
                    }
                    column(VendorShipmentNo_PurchRcptHeader; "Purch. Rcpt. Header"."Vendor Shipment No.")
                    {
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Table(WhseShippingTruck)  This field has also been removed from the layout.
                    // column(SalesShipmentHeader_TruckName; WhseShippingTruck.Description)
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Table(WhseShippingTruck)  This field has also been removed from the layout.
                    column(SalesShipmentHeader_GateEntryNo; "Purch. Rcpt. Header"."Gate Entry No. FND")
                    {
                    }
                    // BC Upgrade BHARAD11 >> ----Drink-IT Field("Driver Code")  This field has also been removed from the layout.
                    // column(SalesShipmentHeader_DriverCode; "Purch. Rcpt. Header"."Driver Code")
                    // {
                    // }
                    // BC Upgrade BHARAD11 << ----Drink-IT Field("Driver Code")  This field has also been removed from the layout.
                    column(ShipToCountryName; ShipToCountryName.Name)
                    {
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Table(Driver)  This field has also been removed from the layout.
                    // column(Name_Driver; Driver.Description)
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Table(Driver)  This field has also been removed from the layout.
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
                    column(SaleShipmentHeader_OrderNo; "Purch. Rcpt. Header"."Order No.")
                    {
                    }
                    column(Text063; Text063)
                    {
                    }
                    column(SaleShipmentHeader_ShippingAgentCode; ShippingAgent.Name)
                    {
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field("Shipping Agent Service Code")  This field has also been removed from the layout.
                    // column(ShippingAgentService_PurchRcptHead; "Purch. Rcpt. Header"."Shipping Agent Service Code")
                    // {
                    // }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field("Shipping Agent Service Code")  This field has also been removed from the layout.
                    column(SaleShipmentHeader_SalesPerson; SalesPerson.Name)
                    {
                    }
                    column(SaleShipmentHeader_GateEntryNo; "Purch. Rcpt. Header"."Gate Entry No. FND")
                    {
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATPercent_VATAmountLine; VATAmountLine."VAT %")
                        {
                        }
                        column(VATAmount_VATAmountLine; VATAmountLine."VAT Amount")
                        {
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
                            /*VATAmountLine.GetLine(Number);
                            
                            IF VATAmountLine."VAT %" = 0 THEN
                              CurrReport.SKIP; */

                            VATPerText := STRSUBSTNO(Text2014416, VATAmountLine."VAT %");

                        end;

                        trigger OnPreDataItem();
                        begin
                            VATAmountLine.RESET;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                        end;
                    }
                    dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Rcpt. Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Type_SalesLine; FORMAT(Type, 0, 2))
                        {
                        }
                        column(SalesShipmentLine_OrderNo; "Purch. Rcpt. Line"."Order No.")
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
                        column(LineNo_SalesLine; "Purch. Rcpt. Line"."Line No.")
                        {
                        }
                        column(UnitCostLCY_SalesLine; "Purch. Rcpt. Line"."Unit Cost (LCY)")
                        {
                        }
                        column(VATIdentifier_SalesLine; "Purch. Rcpt. Line"."VAT %")
                        {
                        }
                        // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Line Amount")  This field has also been removed from the layout.
                        // column(LineAmount_SalesLine; "Line Amount")
                        // {
                        // }
                        // BC Upgrade BHARDA11 << ----Drink-IT Fields("Line Amount")  This field has also been removed from the layout.

                        column(BinCode_PurchRcptLine; "Purch. Rcpt. Line"."Bin Code")
                        {
                        }
                        column(ZoneCode_PurchRcptLine; PostedWhseReceiptLine."Zone Code")
                        {
                        }
                        // column(TotalDirectCOst_PurchLine; GetTotalingLine(2, FIELDNO("Direct Unit Cost"), TRUE))  // BC Upgrade BHARDA11 >> ----GetTotalingLine Not found in BC. This field has also been removed from the layout.
                        // {
                        // }
                        // BC Upgrade BHARDA11 >> ----Drink-IT Field("Free Item") This field has also been removed from the layout.
                        // column(FreeItem_SalesLine; "Free Item")
                        // {
                        // }
                        // BC Upgrade BHARDA11 << ----Drink-IT Field("Free Item") This field has also been removed from the layout.

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
                        column(TotalDirectCost; TotalDirectCost)
                        {
                        }
                        // BC Upgrade BHARDA11 >> ----Drink-IT Field("Line Discount Amount") This field has also been removed from the layout.
                        // column(LineDiscAmount; "Purch. Rcpt. Line"."Line Discount Amount")
                        // {
                        // }
                        // BC Upgrade BHARDA11 << ----Drink-IT Field("Line Discount Amount") This field has also been removed from the layout.

                        column(TotalNetAmount; TotalNetAmount)
                        {
                        }
                        dataitem(DataItem55133; Integer)
                        {
                            column(Temp_LotNo; TempItemLedgerEntry."Lot No.")
                            {
                            }
                            column(Temp_SerialNo; TempItemLedgerEntry."Serial No.")
                            {
                            }
                            column(Temp_Quantity; TempItemLedgerEntry.Quantity)
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                IF Number = 1 THEN
                                    TempItemLedgerEntry.FIND('-')
                                ELSE
                                    TempItemLedgerEntry.NEXT;
                            end;

                            trigger OnPostDataItem();
                            begin
                                TempItemLedgerEntry.DELETEALL;
                            end;

                            trigger OnPreDataItem();
                            begin
                                SETRANGE(Number, 1, TempItemLedgerEntry.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            IsTextToInclude: Boolean;
                        begin
                            //hei.c>>
                            ItemLedgerEntry.RESET;
                            ItemLedgerEntry.SETRANGE("Document No.", "Document No.");
                            ItemLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                            ItemLedgerEntry.SETRANGE("Item No.", "No.");
                            ItemLedgerEntry.SETRANGE("Location Code", "Purch. Rcpt. Line"."Location Code");
                            IF ItemLedgerEntry.FINDSET THEN
                                REPEAT
                                    TempItemLedgerEntry.INIT;
                                    TempItemLedgerEntry."Entry No." := ItemLedgerEntry."Entry No.";
                                    IF ItemLedgerEntry."Lot No." <> '' THEN
                                        TempItemLedgerEntry."Lot No." := ItemLedgerEntry."Lot No."
                                    ELSE IF ItemLedgerEntry."Serial No." <> '' THEN
                                        TempItemLedgerEntry."Lot No." := ItemLedgerEntry."Serial No.";
                                    TempItemLedgerEntry.Quantity := ItemLedgerEntry.Quantity;
                                    TempItemLedgerEntry.INSERT;
                                UNTIL ItemLedgerEntry.NEXT = 0;

                            PostedWhseReceiptLine.SETRANGE("Posted Source No.", "Document No.");
                            PostedWhseReceiptLine.SETRANGE("Posting Date", "Posting Date");
                            PostedWhseReceiptLine.SETRANGE("Source Line No.", "Line No.");
                            PostedWhseReceiptLine.SETRANGE("Item No.", "No.");
                            IF PostedWhseReceiptLine.FINDFIRST THEN;
                            //hei.c>>


                            /*
                            IF NOT CashInvoice THEN BEGIN
                              IF NOT (Type IN [Type::" ",Type::Item,Type::"Charge (Item)"]) THEN
                                CurrReport.SKIP
                              ELSE IF Type = Type::"Charge (Item)" THEN BEGIN
                                IF NOT InclDeposit THEN
                                  CurrReport.SKIP
                                ELSE IF "Item Charge Type" <> "Item Charge Type"::Deposit THEN
                                  CurrReport.SKIP;
                              END;
                            END ELSE
                              IF Type = Type::"Charge (Item)" THEN BEGIN
                                IF NOT InclDeposit THEN
                                  CurrReport.SKIP
                                ELSE IF "Item Charge Type"<>"Item Charge Type"::Deposit THEN
                                  CurrReport.SKIP;
                              END; */

                            //-----Qty in HL
                            CLEAR(QtyHL);
                            // BC Upgrade BHARDA11 >> ----Drink-IT FIELD("Unit Volume HL")
                            // IF (Type = Type::Item) AND ("No." <> '') THEN
                            //     QtyHL := Quantity * "Unit Volume HL";
                            // BC Upgrade BHARDA11 << ----Drink-IT FIELD("Unit Volume HL")
                            TotalQty += "Purch. Rcpt. Line".Quantity;
                            TotalQtyHL += QtyHL;
                            // TotalNetAmount += "Purch. Rcpt. Line"."Line Amount"; // BC Upgrade BHARDA11  ----Drink-IT Fields("Line Amount")
                            // TotalDirectCost += GetTotalingLine(2, FIELDNO("Purch. Rcpt. Line"."Direct Unit Cost"), TRUE); // BC Upgrade BHARDA11 ----GetTotalingLine is missing.
                            //-----Cross Reference Info
                            CLEAR(CrossRefText);
                            /*IF Vendor."Cross. Ref. on Del. Note" THEN BEGIN
                              IF (Type = Type::Item) AND ("No." <> '') THEN
                                CrossRefText := GetCrossReferences();
                            END;*/
                            //-----Expiration Info
                            CLEAR(ExpirationDate);
                            //IF Vendor."Exp. Date on Del. Note" THEN BEGIN
                            /*  ReservEntry.RESET;
                              ReservEntry.SETCURRENTKEY("Source Type","Source Subtype","Source ID","Source Batch Name","Source Prod. Order Line","Source Ref. No.");
                              ReservEntry.SETRANGE("Source Type",111);
                              ReservEntry.SETRANGE("Source Subtype",1);
                              ReservEntry.SETRANGE("Source ID","Document No.");
                              ReservEntry.SETRANGE("Source Ref. No.","Line No.");
                              IF ReservEntry.FINDFIRST THEN BEGIN
                                ItemLedgEntry.RESET;
                                ItemLedgEntry.SETCURRENTKEY("Item No.",Open,"Variant Code",Positive,"Lot No.","Serial No.");
                                ItemLedgEntry.SETRANGE("Item No.",ReservEntry."Item No.");
                                ItemLedgEntry.SETRANGE(Open,TRUE);
                                ItemLedgEntry.SETRANGE("Variant Code",ReservEntry."Variant Code");
                                IF ReservEntry."Lot No." <> '' THEN
                                  ItemLedgEntry.SETRANGE("Lot No.",ReservEntry."Lot No.")
                                ELSE
                                  IF ReservEntry."Serial No." <> '' THEN
                                    ItemLedgEntry.SETRANGE("Serial No.",ReservEntry."Serial No.");
                                ItemLedgEntry.SETRANGE(Positive,TRUE);
                            
                                IF ItemLedgEntry.FINDLAST THEN
                                  ExpirationDate := ItemLedgEntry."Expiration Date";
                              END; */
                            //END;
                            //-----Free Reason Text
                            CLEAR(FreeReasonText);
                            IF "Purch. Rcpt. Line"."Return Reason Code" <> '' THEN BEGIN
                                ReturnCode.GET(ReturnCode);
                                FreeReasonText := ReturnCode.Description;
                            END;
                            //-----Price Info
                            /*CLEAR(PrintPrice);
                            IF CashInvoice THEN
                              IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
                                Item.GET("No.");
                                Item.CALCFIELDS("Empty Good");
                                PrintPrice := NOT(Item."Empty Good");
                              END; */

                            //-----Subtotal
                            /*IF CashInvoice THEN
                            IF
                            (
                              (Type = Type::Item) AND NOT(IsEmptyGoodItem())
                              OR (Type IN [Type::"Fixed Asset",Type::"G/L Account"])
                            ) THEN BEGIN
                                SubTotal += "Line Amount";
                                TotalSubTotal += "Line Amount";
                              END; */
                            //Charges included in item price
                            //Tax to Grand Total + Total + Line Amount
                            /*IF CashInvoice THEN BEGIN
                              SalesChargeLine.RESET;
                              SalesChargeLine.SETRANGE("Document No.","Purch. Rcpt. Line"."Document No.");
                              SalesChargeLine.SETRANGE(Type,"Purch. Rcpt. Line".Type::"Charge (Item)");
                              SalesChargeLine.SETRANGE("Item Charge Type","Purch. Rcpt. Line"."Item Charge Type"::Tax);
                              //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Include in item price");
                              SalesChargeLine.SETRANGE("Attached to Line No.","Purch. Rcpt. Line"."Line No.");
                              IF SalesChargeLine.FINDSET THEN
                                REPEAT
                                  "Purch. Rcpt. Line"."Line Amount" += SalesChargeLine."Line Amount";
                                  SubTotal += SalesChargeLine."Line Amount";
                                  TotalSubTotal += SalesChargeLine."Line Amount";
                                UNTIL SalesChargeLine.NEXT = 0;
                            //Discounts to Grand Total + Total + Line Amount
                              CLEAR(PrintUnderLineCharge);
                              SalesChargeLine.RESET;
                              SalesChargeLine.SETRANGE("Document No.","Purch. Rcpt. Line"."Document No.");
                              SalesChargeLine.SETRANGE(Type,"Purch. Rcpt. Line".Type::"Charge (Item)");
                              SalesChargeLine.SETRANGE("Item Charge Type","Purch. Rcpt. Line"."Item Charge Type"::Discount);
                              //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Include in item price");
                              SalesChargeLine.SETRANGE("Attached to Line No.","Purch. Rcpt. Line"."Line No.");
                              IF SalesChargeLine.FINDSET THEN
                                REPEAT
                                  "Purch. Rcpt. Line"."Line Amount" += SalesChargeLine."Line Amount";
                                  SubTotal += SalesChargeLine."Line Amount";
                                  TotalSubTotal += SalesChargeLine."Line Amount";
                                UNTIL SalesChargeLine.NEXT = 0;
                            //Discounts under item line
                              SalesChargeLine.RESET;
                              SalesChargeLine.SETRANGE("Document No.","Purch. Rcpt. Line"."Document No.");
                              SalesChargeLine.SETRANGE(Type,"Purch. Rcpt. Line".Type::"Charge (Item)");
                              SalesChargeLine.SETRANGE("Item Charge Type","Purch. Rcpt. Line"."Item Charge Type"::Discount);
                             // SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                              SalesChargeLine.SETRANGE("Attached to Line No.","Purch. Rcpt. Line"."Line No.");
                              IF SalesChargeLine.FINDSET THEN
                                IF NOT PrintUnderLineCharge THEN
                                  PrintUnderLineCharge := TRUE;
                                REPEAT
                                  TempUnderChargeLine.INIT;
                                  TempUnderChargeLine := SalesChargeLine;
                                  TempUnderChargeLine.INSERT;
                                UNTIL (SalesChargeLine.NEXT = 0);
                                SalesChargeLine.CALCSUMS("Line Amount");
                                SubTotal += SalesChargeLine."Line Amount";
                                TotalSubTotal += SalesChargeLine."Line Amount";
                            //Tax under item line
                              SalesChargeLine.RESET;
                              SalesChargeLine.SETRANGE("Document No.","Purch. Rcpt. Line"."Document No.");
                              SalesChargeLine.SETRANGE(Type,"Purch. Rcpt. Line".Type::"Charge (Item)");
                              SalesChargeLine.SETRANGE("Item Charge Type","Purch. Rcpt. Line"."Item Charge Type"::Tax);
                              //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                              SalesChargeLine.SETRANGE("Attached to Line No.","Purch. Rcpt. Line"."Line No.");
                              IF SalesChargeLine.FINDSET THEN
                                REPEAT
                                  IF (SalesChargeLine."Line Amount" <> 0) THEN BEGIN
                                    IF NOT PrintUnderLineCharge THEN
                                      PrintUnderLineCharge := TRUE;
                                    TempUnderChargeLine.INIT;
                                    TempUnderChargeLine := SalesChargeLine;
                                    TempUnderChargeLine.INSERT;
                                  END;
                                UNTIL (SalesChargeLine.NEXT = 0);
                                SalesChargeLine.CALCSUMS("Line Amount");
                                SubTotal += SalesChargeLine."Line Amount";
                                TotalSubTotal += SalesChargeLine."Line Amount";
                            IF ("Purch. Rcpt. Line".Quantity <> 0) THEN
                              "Purch. Rcpt. Line"."Unit Cost" := "Purch. Rcpt. Line"."Line Amount" / "Purch. Rcpt. Line".Quantity;
                            END; */

                            //HEI.01>>
                            // ExtendedText
                            IF Type = Type::Item THEN BEGIN
                                TempMarketingText.DELETEALL;
                                ExtendedTextHeader.RESET;

                                ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::Item);
                                ExtendedTextHeader.SETRANGE("No.", "No.");
                                ExtendedTextHeader.SETRANGE("Print on Delivery Note FND", TRUE);
                                IF ExtendedTextHeader.FINDSET THEN
                                    REPEAT
                                        IsTextToInclude := TRUE;
                                        IF ExtendedTextHeader."Starting Date" <> 0D THEN
                                            IsTextToInclude := (ExtendedTextHeader."Starting Date" <= "Posting Date");
                                        IF IsTextToInclude AND (ExtendedTextHeader."Ending Date" <> 0D) THEN
                                            IsTextToInclude := (ExtendedTextHeader."Ending Date" >= "Posting Date");
                                        IF IsTextToInclude THEN BEGIN
                                            ExtendedTextLine.RESET;
                                            ExtendedTextLine.SETRANGE("Table Name", ExtendedTextHeader."Table Name");
                                            ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                                            ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                                            IF ExtendedTextLine.FINDFIRST THEN
                                                REPEAT
                                                    TempMarketingText.INIT;
                                                    TempMarketingText := ExtendedTextLine;
                                                    TempMarketingText.INSERT;
                                                UNTIL (ExtendedTextLine.NEXT = 0);
                                        END;
                                    UNTIL ExtendedTextHeader.NEXT = 0;
                            END;
                            //HEI.01<<
                            //CLEAR(TrackingText1);
                            ///DocTrackingManagement.CallPostedItemTracking1(
                            // DATABASE::"Purch. Rcpt. Line",0,"Document No.",'',0,"Line No.",TempTrackingSpecification);

                            //LotNoCnt:=TempTrackingSpecification.COUNT;

                            //IF LotNoCnt =1 THEN
                            // TrackingText1 := DocTrackingManagement.GetPostedTrackingText(TempTrackingSpecification)+' '+ FORMAT(TempTrackingSpecification."Expiration Date");

                            //Total by UOM>>
                            TempUnitOfMeasure.RESET;
                            IF TempUnitOfMeasure.GET("Purch. Rcpt. Line"."Unit of Measure Code") THEN BEGIN
                                TempUnitOfMeasure."Column 1 Amt." += "Purch. Rcpt. Line".Quantity;
                                TempUnitOfMeasure.MODIFY;
                            END ELSE BEGIN
                                TempUnitOfMeasure.INIT;
                                TempUnitOfMeasure."Currency Code" := "Purch. Rcpt. Line"."Unit of Measure Code";
                                TempUnitOfMeasure."Column 1 Amt." := "Purch. Rcpt. Line".Quantity;
                                TempUnitOfMeasure.INSERT;
                            END;
                            //Total by UOM<<

                        end;

                        trigger OnPreDataItem();
                        begin
                            /*VATAmountLine.DELETEALL;
                            MoreLines := FINDLAST;
                            
                            WHILE MoreLines AND (Description = '') AND ("Description 2" = '') AND
                                  ("No." = '') AND (Quantity = 0) AND
                                  (Amount = 0)
                            DO
                              MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                              CurrReport.BREAK;
                            SETRANGE("Line No.",0,"Line No.");
                            
                            TempEmptyGoodItemLine.RESET;
                            IF TempEmptyGoodItemLine.FINDLAST THEN
                              LineNo := TempEmptyGoodItemLine."Line No.";
                            TotalSubTotal := TotalDeposits + TotalDiscounts + TotalTaxes; */

                        end;
                    }
                    dataitem(UnitOfMeasuretotal; Integer)
                    {
                        column(TempUnitOfMeasure_UOM; TempUnitOfMeasure."Currency Code")
                        {
                        }
                        column(TempUnitOfMeasure_Quantity; TempUnitOfMeasure."Column 1 Amt.")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT TempUnitOfMeasure.FIND('-') THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF TempUnitOfMeasure.NEXT = 0 THEN
                                    CurrReport.BREAK;
                        end;

                        trigger OnPostDataItem();
                        begin
                            TempUnitOfMeasure.DELETEALL;
                        end;

                        trigger OnPreDataItem();
                        begin
                            TempUnitOfMeasure.RESET;
                            SETRANGE(Number, 1, TempUnitOfMeasure.COUNT);
                        end;
                    }
                    dataitem("Empty Return Header"; "Purchase Header")
                    {
                        column(SalesEmptyHeader_No; "Empty Return Header"."No.")
                        {
                        }
                        dataitem("Empty Return Line"; "Purchase Line")
                        {
                            DataItemLink = "Document No." = FIELD("No."),
                                           "Document Type" = FIELD("Document Type");
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
                        }

                        trigger OnPreDataItem();
                        begin
                            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Link Purch. Document No.","Link Purch. Document Type")
                            // SETRANGE("Link Purch. Document No.", "Purch. Rcpt. Header"."Order No.");
                            // SETRANGE("Link Purch. Document Type", "Link Purch. Document Type"::Order);
                            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Link Purch. Document No.","Link Purch. Document Type")
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin

                    IF Number > 1 THEN BEGIN
                        CopyText := Text001;
                        OutputNo += 1;
                    END ELSE IF "Purch. Rcpt. Header"."No. Printed" > 0 THEN
                            CopyText := Text001
                    ELSE
                        CopyText := '';
                    CurrReport.PAGENO := 1;

                    CLEAR(SubTotal);
                    CLEAR(TotalQty);
                    CLEAR(TotalSubTotal);
                    CLEAR(TotalNetAmount);
                    CLEAR(TotalDirectCost);
                end;

                trigger OnPostDataItem();
                begin

                    IF Print THEN
                        ShptCountPrinted.RUN("Purch. Rcpt. Header");
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
                SalesShipmentHeader: Record "Purch. Rcpt. Header";
                ShipmentMethod: Record "Shipment Method";
                // StandardTextReport: Record 2014410; // BC Upgrade BHARDA11 ----Drink-IT Table(2014410)
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
                ServiceSetup: Record "Service Mgt. Setup";
                Vendor2: Record Vendor;
                j: Integer;
            begin
                IF ShipToCountryName.GET("Purch. Rcpt. Header"."Buy-from Country/Region Code") THEN;
                CLEAR(TotalQty);
                CLEAR(TotalQtyHL);
                CLEAR(TotalNetAmount);
                CLEAR(TotalDirectCost);

                //-----Company Info
                CompanyInfo.GET;
                //Picture
                CompanyInfo.CALCFIELDS(Picture, "OpCo Footer image FND");
                //Company Text
                CLEAR(CompanyText);
                CompanyText := CompanyInfo.Name;
                IF (CompanyInfo.Address <> '') THEN
                    CompanyText += ', ' + CompanyInfo.Address;
                IF (CompanyInfo."Address 2" <> '') THEN
                    CompanyText += ', ' + CompanyInfo."Address 2";
                IF (CompanyInfo."Post Code" <> '') THEN
                    CompanyText += ', ' + CompanyInfo."Post Code";
                IF (CompanyInfo.City <> '') THEN
                    CompanyText += ' ' + CompanyInfo.City;
                IF (CompanyInfo."Country/Region Code" <> '') THEN
                    IF CountryInfo.GET(CompanyInfo."Country/Region Code") THEN
                        CompanyText += ', ' + CompanyInfo."Country/Region Code" + ' ' + CountryInfo.Name;
                // BC Upgrade BHARDA11 >> ----Drink-IT Field("Tax Registration No.")
                // IF CompanyInfo."Tax Registration No." <> '' THEN
                //     CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                // BC Upgrade BHARDA11 << ----Drink-IT Field("Tax Registration No.")

                //CompanyText += ', ' + ChOfComm;
                CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                IF CompanyInfo."Fax No." <> '' THEN
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";


                //-----Report Title
                CashInvoice := FALSE;//AS
                CLEAR(ReportTitle);
                CLEAR(CashInvoice);
                IF ("Payment Method Code" <> '') THEN BEGIN
                    PaymentMethod.RESET;
                    PaymentMethod.GET("Payment Method Code");
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field("Cash Payment")
                    // IF (PaymentMethod."Cash Payment") THEN BEGIN
                    //     ReportTitle := Text002;
                    //     CashInvoice := TRUE;
                    // END;
                    // BC Upgrade BHARDA11 << ----Drink-IT Field("Cash Payment")
                END;

                //Comment line
                // BC Upgrade BHARDA11 >> ----Drink-IT Table(StandardTextReport)
                // StandardTextReport.RESET;
                // StandardTextReport.SETRANGE("Report ID", 50298);
                // StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);
                // IF StandardTextReport.FINDSET THEN BEGIN
                //     ExtendedTextHeader.RESET;
                //     ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                //     ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                //     IF ExtendedTextHeader.FINDSET THEN
                //         REPEAT
                //             Var_Comments := '';
                //             ExtendedTextLine.RESET;
                //             ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                //             ExtendedTextLine.SETRANGE("Table Name", ExtendedTextLine."Table Name"::"Standard Text");
                //             IF ExtendedTextLine.FINDSET THEN
                //                 REPEAT
                //                     Var_Comments += ExtendedTextLine.Text + ' ';
                //                 UNTIL ExtendedTextLine.NEXT = 0;
                //         UNTIL ExtendedTextHeader.NEXT = 0;
                // END;
                // BC Upgrade BHARDA11 << ----Drink-IT Table(StandardTextReport)


                IF (ReportTitle = '') THEN
                    IF ("Shipment Method Code" <> '') THEN BEGIN
                        ShipmentMethod.RESET;
                        ShipmentMethod.GET("Shipment Method Code");
                        // BC Upgrade BHARDA11 >> ----Drink-IT Field(Pickup)
                        // IF ShipmentMethod.Pickup THEN
                        //     ReportTitle := Text003
                        // ELSE
                        //     ReportTitle := Text004;
                        // BC Upgrade BHARDA11 << ----Drink-IT Field(Pickup)
                    END;
                ReportTitle := Text004;
                //-----Shipment Address
                SalesShipmentHeader.RESET;
                IF CashInvoice THEN BEGIN
                    IF ("Buy-from Country/Region Code" = CompanyInfo."Country/Region Code") THEN BEGIN
                        SalesShipmentHeader.COPY("Purch. Rcpt. Header");
                        SalesShipmentHeader."Buy-from Country/Region Code" := '';
                        FormatAddr.PurchRcptPayTo(HeaderAddr, SalesShipmentHeader);
                    END ELSE
                        FormatAddr.PurchRcptPayTo(HeaderAddr, "Purch. Rcpt. Header");
                END ELSE BEGIN
                    IF ("Ship-to Country/Region Code" = CompanyInfo."Country/Region Code") THEN BEGIN
                        SalesShipmentHeader.COPY("Purch. Rcpt. Header");
                        SalesShipmentHeader."Ship-to Country/Region Code" := '';
                        FormatAddr.PurchRcptShipTo(HeaderAddr, SalesShipmentHeader);
                    END ELSE
                        FormatAddr.PurchRcptShipTo(HeaderAddr, "Purch. Rcpt. Header");
                END;
                //Shipment Text
                CLEAR(PrintShipmentText);
                IF CashInvoice THEN
                    PrintShipmentText := ("Pay-to Name" <> "Ship-to Name") OR
                                         ("Pay-to Name 2" <> "Ship-to Name 2") OR
                                         ("Pay-to Address" <> "Ship-to Address") OR
                                         ("Pay-to Address 2" <> "Ship-to Address 2") OR
                                         ("Pay-to Post Code" <> "Ship-to Post Code") OR
                                         ("Pay-to City" <> "Ship-to City");

                //-----Header Tel. & Fax
                Vendor.RESET;
                Vendor.GET("Buy-from Vendor No.");

                //-----Shipment Method Info
                IF "Shipment Method Code" <> '' THEN BEGIN
                    ShipMethod.RESET;
                    IF ShipMethod.GET("Shipment Method Code") THEN;
                END;

                //-----Route Info
                // BC Upgrade BHARAD11 >> ----Drink-IT Table(Route)
                // IF Route <> '' THEN BEGIN
                //     Routes.RESET;
                //     IF Routes.GET(Route) THEN;
                // END;
                // BC Upgrade BHARAD11 << ----Drink-IT Table(Route)

                //-----Payment Terms Info
                IF "Payment Terms Code" <> '' THEN BEGIN
                    PayTerms.RESET;
                    IF PayTerms.GET("Payment Terms Code") THEN;
                END;

                //-----Driver Info
                // BC Upgrade BHARAD11 >> ----Drink-IT Field("Driver Code")
                // IF ("Driver Code" <> '') THEN BEGIN
                //     Driver.RESET;
                //     Driver.GET("Driver Code");
                // END;
                // BC Upgrade BHARAD11 << ----Drink-IT Field("Driver Code")

                //-----SalesPerson Info
                //IF ("Salesperson Code" <> '') THEN BEGIN
                //SalesPerson.RESET;
                // SalesPerson.GET("Salesperson Code");
                //END;

                //-----Shipping Agent Info
                // BC Upgrade BHARAD11 >> ----Drink-IT Field("Shipping Agent Code")
                // IF ("Shipping Agent Code" <> '') THEN BEGIN
                //     ShippingAgent.RESET;
                //     ShippingAgent.GET("Shipping Agent Code");
                // END;
                // BC Upgrade BHARAD11 << ----Drink-IT Field("Shipping Agent Code")

                //-----Retunr order Info
                /*ReturnOrder.RESET;
                ReturnOrder.SETRANGE("Document Type",ReturnOrder."Document Type"::"Return Order");
                ReturnOrder.SETRANGE("Link Sales Document No.","Purch. Rcpt. Header"."Order No.");
                ReturnOrder.SETRANGE("Link Sales Document Type",ReturnOrder."Link Sales Document Type"::Order);
                IF ReturnOrder.FINDSET THEN; */


                //-----Comment Lines
                TempCommentLine.RESET;
                TempCommentLine.DELETEALL;
                //CommentLineNo := 10000;
                //Vendor Comments
                CommentLine.RESET;
                CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Vendor);
                CommentLine.SETRANGE("No.", "Buy-from Vendor No.");
                // CommentLine.SETRANGE("Print On Purchase Order", TRUE); // BC Upgrade BHARAD11 ----Drink-IT Field("Print On Purchase Order")
                IF CommentLine.FINDSET THEN
                    REPEAT
                        InsertCommentLine(CommentLine.Comment);
                    UNTIL CommentLine.NEXT = 0;
                //Sales Comments
                SalesCommentLine.RESET;
                SalesCommentLine.SETRANGE("Document Type", SalesCommentLine."Document Type"::Receipt);
                SalesCommentLine.SETRANGE("No.", "No.");
                // SalesCommentLine.SETRANGE("Print On Purchase Order", TRUE); // BC Upgrade BHARAD11 ----Drink-IT Field("Print On Purchase Order")
                IF SalesCommentLine.FINDSET THEN
                    REPEAT
                        InsertCommentLine(SalesCommentLine.Comment);
                    UNTIL SalesCommentLine.NEXT = 0;

                //-----Footer Texts
                /*CLEAR(CurrReportID);
                CLEAR(i);
                CLEAR(TextFooter);
                EVALUATE(CurrReportID,COPYSTR(CurrReport.OBJECTID(FALSE),8));
                StandardTextReport.SETRANGE("Report ID", CurrReportID);
                StandardTextReport.SETRANGE("Position Text",StandardTextReport."Position Text"::Footer);
                
                IF StandardTextReport.FINDSET THEN
                  REPEAT
                    i := 1;
                    ExtendedTextHeader.RESET;
                    ExtendedTextHeader.SETRANGE("Table Name",ExtendedTextHeader."Table Name"::"Standard Text");
                    ExtendedTextHeader.SETRANGE("No.",StandardTextReport."Standard Text Code");
                    IF ExtendedTextHeader.FINDSET THEN BEGIN
                      REPEAT
                        ExtendedTextLine.RESET;
                        ExtendedTextLine.SETRANGE("Table Name",ExtendedTextHeader."Table Name");
                        ExtendedTextLine.SETRANGE("No.",ExtendedTextHeader."No.");
                        ExtendedTextLine.SETRANGE("Text No.",ExtendedTextHeader."Text No.");
                        IF ExtendedTextLine.FINDSET THEN
                        BEGIN
                          REPEAT
                            TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                          UNTIL (ExtendedTextLine.NEXT = 0) OR (i > ARRAYLEN(TextFooter));
                        END;
                        i += 1;
                      UNTIL (ExtendedTextHeader.NEXT = 0);
                    END;
                  UNTIL (StandardTextReport.NEXT = 0); */

                //-----Empty Goods Block
                /*TempEmptyGoodItemLine.RESET;
                TempEmptyGoodItemLine.DELETEALL;
                  CASE Vendor."Empty Returned Items Based On" OF
                    Vendor."Empty Returned Items Based On"::Document:
                      BEGIN
                        WITH SalesDepositLines DO BEGIN
                          SETCURRENTKEY("Document No.","Item DDeposit Group Code");
                          SETRANGE("Document No.","Purch. Rcpt. Header"."No.");
                          SETRANGE(Type, Type::Item);
                          SETFILTER("Item DDeposit Group Code",'<>%1','');
                          IF FINDSET THEN BEGIN
                            REPEAT
                              IF DrinkDepositGroup.GET(DrinkDepositGroup."Source Type"::Item,"Item DDeposit Group Code") THEN BEGIN
                                IF DrinkDepositGroup."Empty Good Reference Item No." <> '' THEN BEGIN
                                  TempEmptyGoodItemLine.RESET;
                                  TempEmptyGoodItemLine.SETRANGE("No.",DrinkDepositGroup."Empty Good Reference Item No.");
                                  IF NOT TempEmptyGoodItemLine.FINDFIRST THEN BEGIN
                                    LineNo += 10000;
                                    TempEmptyGoodItemLine.INIT;
                                    TempEmptyGoodItemLine."No." := DrinkDepositGroup."Empty Good Reference Item No.";
                                    IF Item.GET(DrinkDepositGroup."Empty Good Reference Item No.") THEN
                                      TempEmptyGoodItemLine.Description:= Item.Description;
                                    IF "Quantity (Base)" > 0 THEN BEGIN
                                      TempEmptyGoodItemLine.Quantity := "Quantity (Base)";
                                      TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                    END ELSE BEGIN
                                      TempEmptyGoodItemLine."Quantity (Base)" := - "Quantity (Base)";
                                      TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                    END;
                                    TempEmptyGoodItemLine."Document No." := "No.";
                                    TempEmptyGoodItemLine."Line No." := LineNo;
                                    TempEmptyGoodItemLine.INSERT;
                                  END ELSE BEGIN
                                    IF "Quantity (Base)" > 0 THEN BEGIN
                                      TempEmptyGoodItemLine.Quantity += "Quantity (Base)";
                                    END ELSE BEGIN
                                      TempEmptyGoodItemLine."Quantity (Base)" += -"Quantity (Base)";
                                    END;
                                    TempEmptyGoodItemLine.MODIFY;
                                  END;
                                END;
                              END;
                            UNTIL (NEXT=0);
                          END;
                        END;
                      END;
                    Vendor."Empty Returned Items Based On"::History:
                      BEGIN
                          DrinkDepositGroup.GET(DrinkDepositGroup."Source Type"::Vendor,Vendor."Vendor DDeposit Group Code");
                          DrinkDepositGroup.TESTFIELD("Empty Good Reference period");
                          StartingShipmentdate :=CALCDATE('-'+FORMAT(DrinkDepositGroup."Empty Good Reference period"),"Shipment Date");
                          ItemLedgerEntry.SETCURRENTKEY("Source Type","Source No.","Item DDeposit Group Code","Posting Date");
                          ItemLedgerEntry.SETRANGE("Source Type",ItemLedgerEntry."Source Type"::Vendor);
                          ItemLedgerEntry.SETRANGE("Source No.","Purch. Rcpt. Header"."Buy-from Vendor No.");
                          ItemLedgerEntry.SETFILTER("Item DDeposit Group Code",'<>%1','');
                            ItemLedgerEntry.SETFILTER("Posting Date",'%1..%2',StartingShipmentdate,"Purch. Rcpt. Header"."Shipment Date");
                          IF ItemLedgerEntry.FINDSET THEN BEGIN
                            REPEAT
                              ItemLedgerEntry.SETRANGE("Item DDeposit Group Code" ,ItemLedgerEntry."Item DDeposit Group Code");
                              IF DrinkDepositGroup.GET(DrinkDepositGroup."Source Type"::Item,ItemLedgerEntry."Item DDeposit Group Code") THEN BEGIN
                                IF DrinkDepositGroup."Empty Good Reference Item No." <> '' THEN BEGIN
                                  WITH SalesDepositLines DO BEGIN
                                    SETCURRENTKEY("Document No.","Item DDeposit Group Code");
                                    SETRANGE("Document No.","Purch. Rcpt. Header"."No.");
                                    SETRANGE(Type, Type::Item);
                                    SETRANGE("Item DDeposit Group Code",DrinkDepositGroup.Code);
                                    IF FINDSET THEN BEGIN
                                      REPEAT
                                        TempEmptyGoodItemLine.RESET;
                                        TempEmptyGoodItemLine.SETRANGE("No.",DrinkDepositGroup."Empty Good Reference Item No.");
                                        IF NOT TempEmptyGoodItemLine.FINDFIRST THEN BEGIN
                                          LineNo += 10000;
                                          TempEmptyGoodItemLine.INIT;
                                          TempEmptyGoodItemLine."No." := DrinkDepositGroup."Empty Good Reference Item No.";
                                          IF Item.GET(DrinkDepositGroup."Empty Good Reference Item No.") THEN
                                            TempEmptyGoodItemLine.Description:= Item.Description;
                                          IF "Quantity (Base)" > 0 THEN BEGIN
                                            TempEmptyGoodItemLine.Quantity := "Quantity (Base)";
                                            TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                          END ELSE BEGIN
                                            TempEmptyGoodItemLine."Quantity (Base)" := - "Quantity (Base)";
                                            TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                          END;
                                          TempEmptyGoodItemLine."Document No." := "No.";
                                          TempEmptyGoodItemLine."Line No." := LineNo;
                                          TempEmptyGoodItemLine.INSERT;
                                        END ELSE BEGIN
                                          IF "Quantity (Base)" > 0 THEN BEGIN
                                            TempEmptyGoodItemLine.Quantity += "Quantity (Base)";
                                          END ELSE BEGIN
                                            TempEmptyGoodItemLine."Quantity (Base)" += -"Quantity (Base)";
                                          END;
                                          TempEmptyGoodItemLine.MODIFY;
                                        END;
                                      UNTIL (NEXT=0);
                                    END;
                                  END;
                                END;
                              END;
                              ItemLedgerEntry.FINDLAST;
                              ItemLedgerEntry.SETRANGE("Item DDeposit Group Code");
                              ItemLedgerEntry.SETFILTER("Item DDeposit Group Code",'<>%1','');
                            UNTIL (ItemLedgerEntry.NEXT = 0);
                          END;
                      END;
                    Vendor."Empty Returned Items Based On"::"Fixed Block":
                      BEGIN
                        DrinkDepositGroup.RESET;
                        DrinkDepositGroup.SETRANGE("Include In Fixed Block",TRUE);
                        DrinkDepositGroup.SETFILTER("Empty Good Reference Item No.",'<>%1','');
                        IF NOT DrinkDepositGroup.ISEMPTY THEN BEGIN
                          DrinkDepositGroup.FINDSET;
                          REPEAT
                            WITH SalesDepositLines DO BEGIN
                              SETCURRENTKEY("Document No.","Item DDeposit Group Code");
                              SETRANGE("Document No.","Purch. Rcpt. Header"."No.");
                              SETRANGE(Type, Type::Item);
                              SETRANGE("Item DDeposit Group Code",DrinkDepositGroup.Code);
                              IF FINDSET THEN BEGIN
                                REPEAT
                                  TempEmptyGoodItemLine.RESET;
                                  TempEmptyGoodItemLine.SETRANGE("No.",DrinkDepositGroup."Empty Good Reference Item No.");
                                  IF NOT TempEmptyGoodItemLine.FINDFIRST THEN BEGIN
                                    LineNo += 10000;
                                    TempEmptyGoodItemLine.INIT;
                                    TempEmptyGoodItemLine."No." := DrinkDepositGroup."Empty Good Reference Item No.";
                                    IF Item.GET(DrinkDepositGroup."Empty Good Reference Item No.") THEN
                                      TempEmptyGoodItemLine.Description:= Item.Description;
                                    IF "Quantity (Base)" > 0 THEN BEGIN
                                      TempEmptyGoodItemLine.Quantity := "Quantity (Base)";
                                      TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                    END ELSE BEGIN
                                      TempEmptyGoodItemLine."Quantity (Base)" := - "Quantity (Base)";
                                      TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                    END;
                                    TempEmptyGoodItemLine."Document No." := "No.";
                                    TempEmptyGoodItemLine."Line No." := LineNo;
                                    TempEmptyGoodItemLine.INSERT;
                                  END ELSE BEGIN
                                    IF "Quantity (Base)" > 0 THEN BEGIN
                                      TempEmptyGoodItemLine.Quantity += "Quantity (Base)";
                                    END ELSE BEGIN
                                      TempEmptyGoodItemLine."Quantity (Base)" += -"Quantity (Base)";
                                    END;
                                    TempEmptyGoodItemLine.MODIFY;
                                  END;
                                UNTIL (NEXT=0);
                              END;
                            END;
                          UNTIL (DrinkDepositGroup.NEXT) = 0;
                        END;
                      END;
                    Vendor."Empty Returned Items Based On"::"Document / Item(charges)":
                      BEGIN
                        WITH SalesDepositLines DO BEGIN
                          SETCURRENTKEY("Document No.","Item DDeposit Group Code");
                          SETRANGE("Document No.","Purch. Rcpt. Header"."No.");
                          SETFILTER("Empty Goods Item No.",'<>%1','');
                          IF FINDSET THEN BEGIN
                            REPEAT
                              SETFILTER("Empty Goods Item No.","Empty Goods Item No.");
                              IF FINDSET THEN
                                REPEAT
                                  TempEmptyGoodItemLine.RESET;
                                  TempEmptyGoodItemLine.SETRANGE("No.","Empty Goods Item No.");
                                  IF NOT TempEmptyGoodItemLine.FINDFIRST THEN BEGIN
                                    LineNo += 10000;
                                    TempEmptyGoodItemLine.INIT;
                                    TempEmptyGoodItemLine."No." := "Empty Goods Item No.";
                                    IF Item.GET("Empty Goods Item No.") THEN
                                      TempEmptyGoodItemLine.Description:= Item.Description;
                                    IF "Quantity (Base)" > 0 THEN BEGIN
                                      TempEmptyGoodItemLine.Quantity := "Quantity (Base)";
                                      TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                    END ELSE BEGIN
                                      TempEmptyGoodItemLine."Quantity (Base)" := - "Quantity (Base)";
                                      TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                                    END;
                                    TempEmptyGoodItemLine."Document No." := "No.";
                                    TempEmptyGoodItemLine."Line No." := LineNo;
                                    TempEmptyGoodItemLine.INSERT;
                                  END ELSE BEGIN
                                    IF "Quantity (Base)" > 0 THEN BEGIN
                                      TempEmptyGoodItemLine.Quantity += "Quantity (Base)";
                                    END ELSE BEGIN
                                      TempEmptyGoodItemLine."Quantity (Base)" += -"Quantity (Base)";
                                    END;
                                    TempEmptyGoodItemLine.MODIFY;
                                END;
                              UNTIL(NEXT=0);
                              IF FINDLAST THEN ;
                              SETRANGE("Empty Goods Item No.");
                              SETFILTER("Empty Goods Item No.",'<>%1','');
                            UNTIL (NEXT=0);
                          END;
                        END;
                      END;
                  END; */

                //-----Currency Code
                IF CashInvoice THEN
                    IF ("Currency Code" <> '') THEN
                        CurrCode := "Currency Code"
                    ELSE BEGIN
                        GLSetup.GET;
                        CurrCode := GLSetup."LCY Code";
                    END;
                //-----Loyalty Statement
                /*CLEAR(BeginningBalance);
                CLEAR(EndBalance);
                CLEAR(Gains);
                CLEAR(Sales);
                CLEAR(PrintLoyaltyStatement);
                IF CashInvoice THEN
                  IF (Vendor."Loyalty Statement On" IN [Vendor."Loyalty Statement On"::"Delivery Note",
                                                         Vendor."Loyalty Statement On"::"Invoice + Delivery Note"])
                  THEN BEGIN
                    PrintLoyaltyStatement := TRUE;
                    LoyaltyBalanceBuffer.INIT;
                    LoyaltyBalanceBuffer.SETFILTER("Source Type Filter", '%1',LoyaltyBalanceBuffer."Source Type Filter"::Vendor);
                    LoyaltyBalanceBuffer.SETFILTER("Source No. Filter", Vendor."No.");
                
                    BeginBalDate := CALCDATE('<CM-1M>',"Posting Date");
                    LoyaltyBalanceBuffer.SETFILTER("Date Filter",'..%1',BeginBalDate);
                    LoyaltyBalanceBuffer.CALCFIELDS("Net Point Change (Actual)");
                    BeginningBalance := LoyaltyBalanceBuffer."Net Point Change (Actual)";
                
                    EndBalDate := CALCDATE('<CM>',"Posting Date");
                    LoyaltyBalanceBuffer.SETFILTER("Date Filter",'..%1',EndBalDate);
                    LoyaltyBalanceBuffer.CALCFIELDS("Net Point Change (Actual)");
                    EndBalance := LoyaltyBalanceBuffer."Net Point Change (Actual)";
                
                    BeginningMonth := CALCDATE('<1D>',BeginBalDate);
                
                    LoyaltyLedgerEntry.RESET;
                    LoyaltyLedgerEntry.SETFILTER("Source Type", '%1',LoyaltyLedgerEntry."Source Type"::Vendor);
                    LoyaltyLedgerEntry.SETFILTER("Source No.", Vendor."No.");
                    LoyaltyLedgerEntry.SETFILTER("Posting Date",'%1..%2',BeginningMonth,EndBalDate);
                    LoyaltyLedgerEntry.SETRANGE("Entry Type",LoyaltyLedgerEntry."Entry Type"::Sale);
                    LoyaltyLedgerEntry.SETRANGE("Loyalty Type",LoyaltyLedgerEntry."Loyalty Type"::Point);
                    LoyaltyLedgerEntry.CALCSUMS("Point Amount (Actual)");
                    Gains := LoyaltyLedgerEntry."Point Amount (Actual)";
                
                    LoyaltyLedgerEntry.SETFILTER("Entry Type",'<>%1',LoyaltyLedgerEntry."Entry Type"::Sale);
                    LoyaltyLedgerEntry.CALCSUMS("Point Amount (Actual)");
                    Sales := LoyaltyLedgerEntry."Point Amount (Actual)";
                  END;
                SalesShptLine.CalcVATAmountLines("Purch. Rcpt. Header",VATAmountLine);
                
                CLEAR(TotalDeposits);
                CLEAR(TotalDiscounts);
                CLEAR(TotalTaxes); */

                //-----Order total /blank Discount Charges
                /*IF CashInvoice THEN BEGIN
                  OrderChargeLine.RESET;
                  OrderChargeLine.SETRANGE("Document No.", "No.");
                  OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                  OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Discount);
                  //OrderChargeLine.SETFILTER("Show Item charge on Invoice",'%1|%2',OrderChargeLine."Show Item charge on Invoice"::"Order total",OrderChargeLine."Show Item charge on Invoice"::" ");
                  IF OrderChargeLine.FINDSET THEN BEGIN
                    PrintOrderDiscounts := TRUE;
                    REPEAT
                      TempOrderDiscountCharge.INIT;
                      TempOrderDiscountCharge := OrderChargeLine;
                      TempOrderDiscountCharge.INSERT;
                    UNTIL (OrderChargeLine.NEXT = 0);
                    OrderChargeLine.CALCSUMS("Line Amount");
                    TotalDiscounts += OrderChargeLine."Line Amount";
                  END;
                //-----Order total /blank Deposit Charges
                  OrderChargeLine.RESET;
                  OrderChargeLine.SETRANGE("Document No.", "No.");
                  OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                  OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Deposit);
                  //OrderChargeLine.SETFILTER("Show Item charge on Invoice",'%1|%2',OrderChargeLine."Show Item charge on Invoice"::"Order total",OrderChargeLine."Show Item charge on Invoice"::" ");
                  IF OrderChargeLine.FINDSET THEN BEGIN
                    PrintOrderDeposits := TRUE;
                    REPEAT
                      TempOrderDepositCharge.INIT;
                      TempOrderDepositCharge := OrderChargeLine;
                      TempOrderDepositCharge.INSERT;
                    UNTIL (OrderChargeLine.NEXT = 0);
                    OrderChargeLine.CALCSUMS("Line Amount");
                    TotalDeposits += OrderChargeLine."Line Amount";
                  END;
                  //-----Order total /blank Tax Charges
                  OrderChargeLine.RESET;
                  OrderChargeLine.SETRANGE("Document No.", "No.");
                  OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                  OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Tax);
                  //OrderChargeLine.SETFILTER("Show Item charge on Invoice",'%1|%2',OrderChargeLine."Show Item charge on Invoice"::"Order total",OrderChargeLine."Show Item charge on Invoice"::" ");
                  IF OrderChargeLine.FINDSET THEN BEGIN
                    REPEAT
                      IF (OrderChargeLine."Line Amount" <> 0) THEN BEGIN
                        PrintOrderTaxes := TRUE;
                        TempOrderTaxCharge.INIT;
                        TempOrderTaxCharge := OrderChargeLine;
                        TempOrderTaxCharge.INSERT;
                      END;
                    UNTIL (OrderChargeLine.NEXT = 0);
                    OrderChargeLine.CALCSUMS("Line Amount");
                    TotalTaxes += OrderChargeLine."Line Amount";
                  END;
                END;
                
                //HEI.01>>
                // Tracking Info
                //ShowLotSerialInfo := FALSE;
                //ShowLotSerialInfo := Vendor."Exp. Date on Del. Note";
                
                IF ShowLotSerialInfo THEN
                  TrackingInfoDescriptionLbl := LotSerialInfoLbl
                ELSE
                  TrackingInfoDescriptionLbl := Text027; */

                // CTS Document
                ServiceSetup.GET;
                Vendor2.GET("Buy-from Vendor No.");
                CTSDocumentSubtype := "Document Subtype Code FND" = ServiceSetup."CTS Document Subtype FND"; // BC Upgrade SHUKLP03("Document Subtype Code")
                IF CTSDocumentSubtype THEN
                    ReportTitle := CTSLbl + ' ' + ReportTitle;
                // BC Upgrade BHARDA11 >> ----Drink-IT Table(MasterDataProperty)
                // MasterDataProperty.SETRANGE("Table ID", 18);
                // MasterDataProperty.SETRANGE(Code, Vendor2."No.");
                // MasterDataProperty.SETRANGE("Property Code", ServiceSetup."CTS Technician Property Code");
                // IF MasterDataProperty.FINDFIRST THEN
                //     MasterDataProperty.CALCFIELDS(Name);
                // BC Upgrade BHARDA11 << ----Drink-IT Table(MasterDataProperty)
                // Responsibility Center
                IF ResponsibilityCenter.FINDSET THEN BEGIN
                    j := 1;
                    REPEAT
                        RespCenter_Code[j] := ResponsibilityCenter.Code;
                        RespCenter_PostCode[j] := ResponsibilityCenter."Post Code";
                        RespCenter_PhoneNo[j] := ResponsibilityCenter."Phone No.";
                        RespCenter_FaxNo[j] := ResponsibilityCenter."Fax No.";
                        j += 1;
                    UNTIL ResponsibilityCenter.NEXT = 0;
                END;
                //HEI.01<<

                // IF WhseShippingTruck.GET("Purch. Rcpt. Header"."Truck Code") THEN; // BC Upgrade BHARAD11 ----Drink-IT Table(WhseShippingTruck)

            end;

            trigger OnPreDataItem();
            begin

                Print := Print OR NOT CurrReport.PREVIEW;
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
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Copies';
                    }
                    field(InclPrices; InclPrices)
                    {
                        ApplicationArea = All;
                        Caption = 'Incl. Price';
                    }
                    field(InclDeposit; InclDeposit)
                    {
                        ApplicationArea = All;
                        Caption = 'Incl. Deposit';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        UserIDLbl = 'User ID'; DateLbl = 'Date'; label(LocationCodeLbl; ENU = 'Location Code',
                                                                     FRA = 'Code du magasin')
        label(TruckCodeLbl; ENU = 'Truck Code & Description',
                           FRA = 'Code et description du camion')
        GateEntryLbl = 'Gate Entry'; label(PrintDate; ENU = 'Print Date',
                                                    FRA = 'Date d''Impression')
        label(SalesOrderNoLbl; ENU = 'Purchase Order No.',
                              FRA = 'N° Commande Vente')
        QuantityReceivedLbl = 'Quantity Received'; NameLbl = 'Name'; Name1Lbl = 'Name'; label(DriverLbl; ENU = 'Driver',
                                                                                                     FRA = 'Signature livreur')
        ApprovedByLbl = 'Approved by:'; label(ReceivedByLbl; ENU = 'Received by:',
                                                           FRA = 'Signature du contrôleur ')
        label(SignatureLbl; ENU = 'Signature',
                           FRA = 'Visa de sécurité ')
        TradeRegisterLbl = 'Trade Register'; VATNoLbl = 'VAT No.'; HeadOfficeLbl = '(Head Office)'; POBoxLbl = 'PO Box'; TelLbl = 'Tel:'; FaxLbl = 'Fax:'; label(DocumentDateLbl; ENU = 'Document Date',
                                                                                                                                                                           FRA = 'Date du Document')
        label(ShipmentDateLbl; ENU = 'Receipt Date',
                              FRA = 'Date d''Expédition')
        label(BillToCustomerLbl; ENU = 'Vendor No.',
                                FRA = 'Facturé au client N°')
        BuyfromVendorNameLbl = 'Vendor Name'; label(ShipToCustomerLbl; ENU = 'Ship to Vendor Name',
                                                                     FRA = 'Livré au client N°')
        label(ShipToAddressLbl; ENU = 'Vendor Address',
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
        label(UnitPriceLbl; ENU = 'Total Direct Unit Cost Excl. VAT',
                           FRA = 'Prix unitaire')
        label(DiscountLbl; ENU = 'Discount',
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
        TotalLbl = 'Total Qty'; label(EmptyLbl; ENU = 'Empties to return',
                                              FRA = 'Consigne or bouteilles  à retourner')
        label(PaymentTermsLbl; ENU = 'Payment Term',
                              FRA = 'Condition Paiement')
        label(ShipMethodLbl; ENU = 'Shipment Method',
                            FRA = 'Condition Livraison')
        YourRefLbl = 'Your Reference'; label(RouteLbl; ENU = 'Route',
                                                     FRA = 'Itinéraire')
        label(ReturnOrderLbl; ENU = 'Sales Return Order',
                             FRA = 'Commande de retour')
        ShippingAgentServiceLbl = 'Shipping Agent Service'; VendorOrderNumberLbl = 'Vendor Order Number'; VendorshipmentNumberLbl = 'Vendor Shipment Number'; BinCodeLbl = 'Bin'; ZoneCodeLbl = 'Zone'; Name2Lbl = 'Name';
    }

    var
        CompanyInfo: Record "Company Information";
        CompanyText: Text;
        OutputNo: Integer;
        TextFooter: array[3] of Text;
        FormatAddr: Codeunit "Format Address";
        Vendor: Record Vendor;
        ReportTitle: Text;
        // Driver: Record 2014063; // BC Upgrade BHARDA11 ----Drink-IT Table(2014063)
        SalesPerson: Record "Salesperson/Purchaser";
        blnDeliveryTime: Boolean;
        TextDeliveryTime: Text;
        CommentLine: Record "Comment Line";
        SalesCommentLine: Record "Purch. Comment Line";
        TempCommentLine: Record "Comment Line" temporary;
        CommentLineNo: Integer;
        TempMarketingText: Record "Extended Text Line" temporary;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShptCountPrinted: Codeunit "Purch.Rcpt.-Printed";
        Print: Boolean;
        QtyHL: Decimal;
        CrossRefText: Text;
        ExpirationDate: Date;
        ReturnCode: Record "Return Reason";
        FreeReasonText: Text;
        Text001: Label 'COPY';
        PaymentMethod: Record "Payment Method";
        PrintShipmentText: Boolean;
        PrintPrice: Boolean;
        TotalOrderDiscCharges: Decimal;
        SubTotal: Decimal;
        CashInvoice: Boolean;
        CurrCode: Code[10];
        GLSetup: Record "General Ledger Setup";
        BeginningBalance: Decimal;
        EndBalance: Decimal;
        Gains: Decimal;
        Sales: Decimal;
        PrintLoyaltyStatement: Boolean;
        TotalSubTotal: Decimal;
        PrintOrderDiscounts: Boolean;
        PrintOrderDeposits: Boolean;
        VATAmountLine: Record "VAT Amount Line" temporary;
        Text2014416: Label 'VAT %1%';
        VATPerText: Text;
        Text002: Label 'Purchase - Receipt %1';
        Text003: Label 'Pickup Note';
        Text004: Label 'Delivery Note';
        Text008: Label '"EAN: "';
        Text009: Label '"Your Reference: "';
        Text010: Label '"Delivery Address: "';
        Text011: Label 'Tel.';
        Text012: Label 'Fax.';
        Text013: Label 'Vendor No.';
        Text014: TextConst ENU = 'Shipment No.', FRA = 'N° d''Expédition';
        Text015: Label 'Invoice No.';
        Text016: Label 'Receipt Date';
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
        Text027: TextConst ENU = 'Lot/Serial No.', FRA = 'Lot/Serial & BB date';
        Text028: TextConst ENU = 'Quantity', FRA = 'Quantité';
        Text029: TextConst ENU = 'UOM', FRA = 'Code unité';
        Text030: Label 'HL';
        Text031: TextConst ENU = 'Comment', FRA = 'Commentaires';
        Text032: TextConst ENU = 'Unit Cost', FRA = 'Prix unitaire';
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
        TotalDiscounts: Decimal;
        TotalDeposits: Decimal;
        Text058: Label 'Loyalty Statement';
        Text059: Label 'Balance before';
        Text060: Label 'Increase';
        Text061: Label 'Decrease';
        Text062: Label 'Balance after';
        PrintUnderLineCharge: Boolean;
        PrintOrderTaxes: Boolean;
        TrackingText1: Text[250];
        ShowLotSerialInfo: Boolean;
        TrackingInfoDescriptionLbl: Text[30];
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        CTSDocumentSubtype: Boolean;
        // MasterDataProperty: Record 2029625; // BC Upgrade BHARDA11 ----Drink-IT Table(2029625)
        CTSLbl: Label 'CTS';
        ResponsibilityCenter: Record "Responsibility Center";
        RespCenter_Code: array[20] of Text[50];
        RespCenter_PostCode: array[20] of Text[50];
        RespCenter_PhoneNo: array[20] of Text[50];
        RespCenter_FaxNo: array[20] of Text[50];
        HeaderAddr: array[8] of Text[60];
        Text063: Label 'Purchase Order No.';
        TotalQty: Decimal;
        TotalQtyHL: Decimal;
        // WhseShippingTruck: Record 2014068; // BC Upgrade BHARDA11 ----Drink-IT Table(2014068)
        ShipToCountryName: Record "Country/Region";
        TotalNetAmount: Decimal;
        ShippingAgent: Record "Shipping Agent";
        InclPrices: Boolean;
        TempUnitOfMeasure: Record "Aging Band Buffer" temporary;
        CountryInfo: Record "Country/Region";
        TaxNoID: Label 'Tax Number ID:';
        ContactNo: Label 'Contact Number:';
        FaxNo: Label 'Fax Number:';
        EmailComp: Label 'E-mail:';
        ShipMethod: Record "Shipment Method";
        PayTerms: Record "Payment Terms";
        // Routes: Record 2014072; // BC Upgrade BHARDA11 ----Drink-IT Table(2014072)
        ReturnOrder: Record "Purchase Header";
        InclDeposit: Boolean;
        EmptyReturnUnitPrice: Decimal;
        TotalDirectCost: Decimal;
        Var_Comments: Text;
        TempItemLedgerEntry: Record "Item Ledger Entry" temporary;
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";

    procedure InsertCommentLine(Comment: Text);
    begin
        TempCommentLine.INIT;
        TempCommentLine."Line No." := CommentLineNo;
        TempCommentLine.Comment := Comment;
        TempCommentLine.INSERT;
        CommentLineNo += 10000;
    end;

    local procedure GetCrossReferences() CrossRef: Text;
    var
    // ItemCrossReference: Record "Item Cross Reference"; // BC Upgrade BHARDA11 ---"Item Cross Reference" is obsolete in BC
    begin
        // BC Upgrade BHARDA11 >> ---"Item Cross Reference" is obsolete in BC
        //     ItemCrossReference.RESET;
        //     ItemCrossReference.SETRANGE("Item No.", "Purch. Rcpt. Line"."No.");
        //     ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::"Bar Code");
        //     IF ItemCrossReference.FINDFIRST THEN
        //         CrossRef := Text008 + ItemCrossReference."Cross-Reference No.";
        //     ItemCrossReference.RESET;
        //     ItemCrossReference.SETRANGE("Item No.", "Purch. Rcpt. Line"."No.");
        //     ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::Vendor);
        //     ItemCrossReference.SETRANGE("Cross-Reference Type No.", "Purch. Rcpt. Line"."Buy-from Vendor No.");
        //     IF ItemCrossReference.FINDFIRST THEN BEGIN
        //         IF (CrossRef = '') THEN
        //             CrossRef := Text009 + ItemCrossReference."Cross-Reference No."
        //         ELSE
        //             CrossRef += ' / ' + Text009 + ItemCrossReference."Cross-Reference No.";
        //     END;
        // BC Upgrade BHARDA11 << ---"Item Cross Reference" is obsolete in BC
    end;


    local procedure IsEmptyGoodItem(): Boolean;
    begin
        /*IF ("Purch. Rcpt. Line".Type <> "Purch. Rcpt. Line".Type::Item) OR (("Purch. Rcpt. Line".Type =  "Purch. Rcpt. Line".Type::Item) AND ("Purch. Rcpt. Line"."No."='')) THEN
          EXIT;
        Item.GET("Purch. Rcpt. Line"."No.");
        Item.CALCFIELDS("Empty Good");
        EXIT(
          Item."Empty Good"); */

    end;
}

