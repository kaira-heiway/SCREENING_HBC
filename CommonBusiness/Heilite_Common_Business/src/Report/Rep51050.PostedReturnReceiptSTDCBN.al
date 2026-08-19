report 51050 "Posted Return Rcpt STD CBN"
{
    // version HEI.04

    // DITW110.00.11 AKH 02/11/2017 NRQ#43605 New Report
    // 
    // HEI.01 FDD-RW-GAPLOG02 IBM NASTAA02 10.09.2018 # Delivery Note
    //   # Copied Report 50161 - Delivery Note - Shipment Alm and created dataset and layout according to Rwanda requirements
    // HEI.02 FDD-HT741 IBM BULIMC01 06.09.2019 #new report for Ethiopia created from a copy of 50298 - Posted Purchase Receipt Eth report.
    // HEI.03 CHG2094757 IBM SAMANR01 20.01.2021
    //   # Add data item "Line No" and add group on layout
    // HEI.04 CHG2213617 IBM COSTES04 24.07.2023 INC4747173 | not able to print sale credit memos for two customers
    //   # Skip data item Empty Return Data item
    //-------------------------------------------------------------------------------------

    //BC Upgrade KAPOOV01 01.02.2025 #Table-"Item Cross Reference" is not available in BC, it is replaced by Item reference table-->code changed to fit new table.
    //BC Upgrade KAPOOV01 01.02.2025 #Updated RDLCLayout Property. 
    //BC Upgrade KAPOOV01 01.02.2025 #Commented DRINK-IT Tables and fields and related code.
    //BC Upgrade KAPOOV01 01.02.2025 #Replaced Codeunit- NoSeriesManagement by "No. Series", CU-NoSeriesManagement is Obsolete in BC.
    //BC Upgrade KAPOOV01 01.02.2025 #Replaced Property -ReqFilterHeading by ReqFilterHeadingML as ReqFilterHeading property is not a valid property in BC.
    //BC Upgrade KAPOOV01 01.02.2025 #Added Property -UsageCategory,ApplicationArea.

    DefaultLayout = RDLC;
    //RDLCLayout = './Posted Return Receipt STD.rdlc'; //BC Upgrade KAPOOV01 Commented
    RDLCLayout = '.\src\ReportsLayout\Posted Return Receipt STD.rdl'; //BC Upgrade KAPOOV01-> Add layout path and change layout extension rdlc to rdl

    Caption = 'Posted Return Receipt STD';
    Permissions = TableData "Return Receipt Header" = rm;
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Return Receipt Header"; "Return Receipt Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            //ReqFilterHeading = 'Return Receipt Header';  //BC Upgrade KAPOOV01 Blocked to resolve compilation errors.
            RequestFilterHeadingML = ENU = 'Return Receipt Header'; //BC Upgrade KAPOOV01 Added.

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
                    //BC Upgrade KAPOOV01 Drink-IT >>
                    column(RouteName; '') //Routes.Name)
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT <<
                    column(CopyTextCaption; STRSUBSTNO(Text002, CopyText))
                    {
                    }
                    column(ShipMethod; ShipMethod.Description)
                    {
                    }
                    column(PayTerms; PayTerms.Description)
                    {
                    }
                    column(YourReference; "Return Receipt Header"."Your Reference")
                    {
                    }
                    column(CTSDocumentSubtype; CTSDocumentSubtype)
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT >>
                    column(TechnicianName; '')//MasterDataProperty.Name)
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT <<
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
                    //BC Upgrade KAPOOV01 Drink-IT >>
                    column(CompanyInfo__BankName__2; '')//CompanyInfo."Bank Name 2")
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT <<
                    column(CompanyInfo__BankName; CompanyInfo."Bank Name")
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT >>
                    column(CompanyInfo__IBAN__2; '')//CompanyInfo."IBAN 2")
                    {
                    }

                    column(CompanyInfo__SWIFTCode__2; '')//CompanyInfo."SWIFT Code 2")
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT <<
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
                    column(SellToCust_SalesHeader; "Return Receipt Header"."Sell-to Customer No.")
                    {
                    }
                    column(AdressVendor_PurchRcptHeader; "Return Receipt Header"."Bill-to Address")
                    {
                    }
                    column(ShippingNo_SalesHeader; "Return Receipt Header"."Return Order No.")
                    {
                    }
                    column(BillToCust_SalesHeader; "Return Receipt Header"."Bill-to Customer No.")
                    {
                    }
                    column(BillToCustName; "Return Receipt Header"."Bill-to Name")
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT >>
                    column(Route_SalesHeader; '')//"Return Receipt Header".Route)
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT <<
                    column(ShipToName_SalesHeader; "Return Receipt Header"."Sell-to Customer Name")
                    {
                    }
                    column(ShipToName2_SalesHeader; "Return Receipt Header"."Sell-to Customer Name 2")
                    {
                    }
                    column(ShipmentDate_SalesHeader; "Return Receipt Header"."Posting Date")
                    {
                    }
                    column(ShipToAddress_SalesHeader; "Return Receipt Header"."Sell-to Address")
                    {
                    }
                    column(ShipToAddress2_SalesHeader; "Return Receipt Header"."Sell-to Address 2")
                    {
                    }
                    column(ShipToPostCode_SalesHeader; "Return Receipt Header"."Bill-to Post Code")
                    {
                    }
                    column(ShipToCity_SalesHeader; "Return Receipt Header"."Sell-to City")
                    {
                    }
                    column(BuyFromCountry_PuchRcptHeader; "Return Receipt Header"."Ship-to Country/Region Code")
                    {
                    }
                    column(SalesShipmentHeader_UserID; "Return Receipt Header"."User ID")
                    {
                    }
                    column(SalesShipmentHeader_DocumentDate; "Return Receipt Header"."Document Date")
                    {
                    }
                    column(SalesShipmentHeader_LocationCode; "Return Receipt Header"."Location Code")
                    {
                    }
                    column(ShippingAgentServiceCode_ShipAgent; "Return Receipt Header"."Ship Agent Service Code FND")
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT >>
                    column(SalesShipmentHeader_TruckCode; '')//"Return Receipt Header"."Truck Code")
                    {
                    }

                    column(SalesShipmentHeader_TruckName; '')// WhseShippingTruck.Description)
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT <<
                    column(SalesShipmentHeader_GateEntryNo; "Return Receipt Header"."Gate Entry No. FND")
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT >>
                    column(SalesShipmentHeader_DriverCode; '')//"Return Receipt Header"."Driver Code")
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT <<
                    column(ShipToCountryName; ShipToCountryName.Name)
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT >>
                    column(Name_Driver; '')//Driver.Description)
                    {
                    }
                    //BC Upgrade KAPOOV01 Drink-IT <<
                    column(Name_SalesPerson; SalesPerson.Name)
                    {
                    }
                    column(PhoneNo_SalesPerson; SalesPerson."Phone No.")
                    {
                    }
                    column(ShippingAGentCode; "Return Receipt Header"."Shipping Agent Code")
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
                    column(SaleShipmentHeader_OrderNo; "Return Receipt Header"."Return Order No.")
                    {
                    }
                    column(Text063; Text063)
                    {
                    }
                    column(SaleShipmentHeader_ShippingAgentCode; ShippingAgent.Name)
                    {
                    }
                    column(SaleShipmentHeader_SalesPerson; SalesPerson.Name)
                    {
                    }
                    column(SaleShipmentHeader_GateEntryNo; "Return Receipt Header"."Gate Entry No. FND")
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
                            VATAmountLine.RESET();
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                        end;
                    }
                    dataitem("Return Receipt Line"; "Return Receipt Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Return Receipt Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Type_SalesLine; FORMAT(Type, 0, 2))
                        {
                        }
                        column(SalesShipmentLine_OrderNo; "Return Receipt Line"."Return Order No.")
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
                        column(LineNo_SalesLine; "Return Receipt Line"."Line No.")
                        {
                        }
                        column(UnitCostLCY_SalesLine; "Return Receipt Line"."Unit Cost (LCY)")
                        {
                        }
                        column(VATIdentifier_SalesLine; "Return Receipt Line"."VAT %")
                        {
                        }
                        //BC Upgrade KAPOOV01 Drink-IT >>
                        column(LineAmount_SalesLine; '')//"Line Amount")
                        {
                        }
                        //BC Upgrade KAPOOV01 Drink-IT <<
                        column(BinCode_PurchRcptLine; "Return Receipt Line"."Bin Code")
                        {
                        }
                        column(ZoneCode_PurchRcptLine; PostedWhseReceiptLine."Zone Code")
                        {
                        }
                        //BC Upgrade KAPOOV01 Drink-IT >>
                        column(FreeItem_SalesLine; '')//"Free Item")
                        {
                        }
                        //BC Upgrade KAPOOV01 Drink-IT <<
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
                        //BC Upgrade KAPOOV01 Drink-IT >>
                        column(LineDiscAmount; '')//"Return Receipt Line"."Line Discount Amount")
                        {
                        }
                        //BC Upgrade KAPOOV01 Drink-IT <<
                        column(TotalNetAmount; TotalNetAmount)
                        {
                        }
                        column(LineNo; "Return Receipt Line"."Line No.")
                        {
                        }
                        dataitem("Integer"; "Integer")
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
                                if Number = 1 then
                                    TempItemLedgerEntry.FIND('-')
                                else
                                    TempItemLedgerEntry.NEXT();
                            end;

                            trigger OnPostDataItem();
                            begin
                                TempItemLedgerEntry.DELETEALL();
                            end;

                            trigger OnPreDataItem();
                            begin
                                SETRANGE(Number, 1, TempItemLedgerEntry.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            //ItemCrossReference: Record "Item Cross Reference";  //BC UPGRADE KAPOOV01-Item Cross Refernce obsolete in BC
                            ItemRefG: Record "Item Reference";//BC UPGRADE KAPOOV01 
                            ReservEntry: Record "Reservation Entry";
                            ItemLedgEntry: Record "Item Ledger Entry";
                            OrderChargeLine: Record "Return Receipt Line";
                            SalesChargeLine: Record "Return Receipt Line";
                            IsTextToInclude: Boolean;
                        begin
                            //hei.c>>
                            ItemLedgerEntry.RESET();
                            ItemLedgerEntry.SETRANGE("Document No.", "Document No.");
                            ItemLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                            ItemLedgerEntry.SETRANGE("Item No.", "No.");
                            ItemLedgerEntry.SETRANGE("Location Code", "Return Receipt Line"."Location Code");
                            if ItemLedgerEntry.FINDSET() then
                                repeat
                                    TempItemLedgerEntry.INIT();
                                    TempItemLedgerEntry."Entry No." := ItemLedgerEntry."Entry No.";
                                    if ItemLedgerEntry."Lot No." <> '' then
                                        TempItemLedgerEntry."Lot No." := ItemLedgerEntry."Lot No."
                                    else if ItemLedgerEntry."Serial No." <> '' then
                                        TempItemLedgerEntry."Lot No." := ItemLedgerEntry."Serial No.";
                                    TempItemLedgerEntry.Quantity := ItemLedgerEntry.Quantity;
                                    TotalQty += ItemLedgerEntry.Quantity;
                                    UoM();
                                    TempItemLedgerEntry.INSERT();
                                until ItemLedgerEntry.NEXT() = 0;

                            PostedWhseReceiptLine.SETRANGE("Posted Source No.", "Document No.");
                            PostedWhseReceiptLine.SETRANGE("Posting Date", "Posting Date");
                            PostedWhseReceiptLine.SETRANGE("Source Line No.", "Line No.");
                            PostedWhseReceiptLine.SETRANGE("Item No.", "No.");
                            if PostedWhseReceiptLine.FINDFIRST() then;
                            //hei.c>>



                            if not CashInvoice then begin
                                if not (Type in [Type::" ", Type::Item, Type::"Charge (Item)"]) then
                                    CurrReport.SKIP()
                                else if Type = Type::"Charge (Item)" then begin
                                    if not InclDeposit then
                                        CurrReport.SKIP()
                                    //BC Upgrade KAPOOV01 Drink-IT >>
                                    // else if "Item Charge Type" <> "Item Charge Type"::Deposit then
                                    //     CurrReport.SKIP;
                                    //BC Upgrade KAPOOV01 Drink-IT <<
                                end;
                            end else
                                if Type = Type::"Charge (Item)" then begin
                                    if not InclDeposit then
                                        CurrReport.SKIP()
                                    //BC Upgrade KAPOOV01 Drink-IT >>
                                    // else if "Item Charge Type" <> "Item Charge Type"::Deposit then
                                    //     CurrReport.SKIP;
                                    //BC Upgrade KAPOOV01 Drink-IT <<
                                end;

                            //-----Qty in HL
                            CLEAR(QtyHL);
                            if (Type = Type::Item) and ("No." <> '') then
                                //QtyHL := Quantity * "Unit Volume HL"; //BC Upgrade KAPOOV01 Drink-IT

                                //TotalQty += "Return Receipt Line".Quantity;
                                TotalQtyHL += QtyHL;
                            //TotalNetAmount += "Return Receipt Line"."Line Amount"; //BC Upgrade KAPOOV01 Drink-IT
                            //TotalDirectCost+= GetTotalingLine(2,FIELDNO("Return Receipt Line"."Direct Unit Cost"),TRUE);
                            //-----Cross Reference Info
                            CLEAR(CrossRefText);
                            /*IF Customer."Cross. Ref. on Del. Note" THEN BEGIN
                              IF (Type = Type::Item) AND ("No." <> '') THEN
                                CrossRefText := GetCrossReferences();
                            END;*/
                            //-----Expiration Info
                            CLEAR(ExpirationDate);
                            //IF Customer."Exp. Date on Del. Note" THEN BEGIN
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
                            if "Return Receipt Line"."Return Reason Code" <> '' then begin
                                ReturnReason.GET("Return Receipt Line"."Return Reason Code");
                                FreeReasonText := ReturnReason.Description;
                            end;
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
                              SalesChargeLine.SETRANGE("Document No.","Return Receipt Line"."Document No.");
                              SalesChargeLine.SETRANGE(Type,"Return Receipt Line".Type::"Charge (Item)");
                              SalesChargeLine.SETRANGE("Item Charge Type","Return Receipt Line"."Item Charge Type"::Tax);
                              //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Include in item price");
                              SalesChargeLine.SETRANGE("Attached to Line No.","Return Receipt Line"."Line No.");
                              IF SalesChargeLine.FINDSET THEN
                                REPEAT
                                  "Return Receipt Line"."Line Amount" += SalesChargeLine."Line Amount";
                                  SubTotal += SalesChargeLine."Line Amount";
                                  TotalSubTotal += SalesChargeLine."Line Amount";
                                UNTIL SalesChargeLine.NEXT = 0;
                            //Discounts to Grand Total + Total + Line Amount
                              CLEAR(PrintUnderLineCharge);
                              SalesChargeLine.RESET;
                              SalesChargeLine.SETRANGE("Document No.","Return Receipt Line"."Document No.");
                              SalesChargeLine.SETRANGE(Type,"Return Receipt Line".Type::"Charge (Item)");
                              SalesChargeLine.SETRANGE("Item Charge Type","Return Receipt Line"."Item Charge Type"::Discount);
                              //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Include in item price");
                              SalesChargeLine.SETRANGE("Attached to Line No.","Return Receipt Line"."Line No.");
                              IF SalesChargeLine.FINDSET THEN
                                REPEAT
                                  "Return Receipt Line"."Line Amount" += SalesChargeLine."Line Amount";
                                  SubTotal += SalesChargeLine."Line Amount";
                                  TotalSubTotal += SalesChargeLine."Line Amount";
                                UNTIL SalesChargeLine.NEXT = 0;
                            //Discounts under item line
                              SalesChargeLine.RESET;
                              SalesChargeLine.SETRANGE("Document No.","Return Receipt Line"."Document No.");
                              SalesChargeLine.SETRANGE(Type,"Return Receipt Line".Type::"Charge (Item)");
                              SalesChargeLine.SETRANGE("Item Charge Type","Return Receipt Line"."Item Charge Type"::Discount);
                             // SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                              SalesChargeLine.SETRANGE("Attached to Line No.","Return Receipt Line"."Line No.");
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
                              SalesChargeLine.SETRANGE("Document No.","Return Receipt Line"."Document No.");
                              SalesChargeLine.SETRANGE(Type,"Return Receipt Line".Type::"Charge (Item)");
                              SalesChargeLine.SETRANGE("Item Charge Type","Return Receipt Line"."Item Charge Type"::Tax);
                              //SalesChargeLine.SETRANGE("Show Item charge on Invoice",SalesChargeLine."Show Item charge on Invoice"::"Under item line");
                              SalesChargeLine.SETRANGE("Attached to Line No.","Return Receipt Line"."Line No.");
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
                            IF ("Return Receipt Line".Quantity <> 0) THEN
                              "Return Receipt Line"."Unit Cost" := "Return Receipt Line"."Line Amount" / "Return Receipt Line".Quantity;
                            END; */

                            //HEI.01>>
                            // ExtendedText
                            if Type = Type::Item then begin
                                TempMarketingText.DELETEALL();
                                ExtendedTextHeader.RESET();

                                ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::Item);
                                ExtendedTextHeader.SETRANGE("No.", "No.");
                                ExtendedTextHeader.SETRANGE("Print on Delivery Note FND", true);
                                if ExtendedTextHeader.FINDSET() then
                                    repeat
                                        IsTextToInclude := true;
                                        if ExtendedTextHeader."Starting Date" <> 0D then
                                            IsTextToInclude := (ExtendedTextHeader."Starting Date" <= "Posting Date");
                                        if IsTextToInclude and (ExtendedTextHeader."Ending Date" <> 0D) then
                                            IsTextToInclude := (ExtendedTextHeader."Ending Date" >= "Posting Date");
                                        if IsTextToInclude then begin
                                            ExtendedTextLine.RESET();
                                            ExtendedTextLine.SETRANGE("Table Name", ExtendedTextHeader."Table Name");
                                            ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                                            ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                                            if ExtendedTextLine.FINDFIRST() then
                                                repeat
                                                    TempMarketingText.INIT();
                                                    TempMarketingText := ExtendedTextLine;
                                                    TempMarketingText.INSERT();
                                                until (ExtendedTextLine.NEXT() = 0);
                                        end;
                                    until ExtendedTextHeader.NEXT() = 0;
                            end;
                            //HEI.01<<
                            //CLEAR(TrackingText1);
                            ///DocTrackingManagement.CallPostedItemTracking1(
                            // DATABASE::"Return Receipt Line",0,"Document No.",'',0,"Line No.",TempTrackingSpecification);

                            //LotNoCnt:=TempTrackingSpecification.COUNT;

                            //IF LotNoCnt =1 THEN
                            // TrackingText1 := DocTrackingManagement.GetPostedTrackingText(TempTrackingSpecification)+' '+ FORMAT(TempTrackingSpecification."Expiration Date"

                        end;

                        trigger OnPreDataItem();
                        var
                            ReservEntry: Record "Reservation Entry";
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
                            //TempUnitOfMeasure.DELETEALL;
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
                        }

                        trigger OnPreDataItem();
                        begin
                            //SETRANGE("Link Purch. Document No.","Return Receipt Header"."Order No.");
                            //SETRANGE("Link Purch. Document Type","Link Purch. Document Type"::Order);
                            CurrReport.BREAK();//HEI.04
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin

                    if Number > 1 then begin
                        CopyText := Text001;
                        OutputNo += 1;
                    end else if "Return Receipt Header"."No. Printed" > 0 then
                            CopyText := Text001
                    else
                        CopyText := '';
                    CurrReport.PAGENO := 1;

                    CLEAR(SubTotal);
                    CLEAR(TotalQty);
                    CLEAR(TotalSubTotal);
                    CLEAR(TotalNetAmount);
                    CLEAR(TotalDirectCost);
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
                ReturnReceiptHeader: Record "Return Receipt Header";
                ShipmentMethod: Record "Shipment Method";
                DeliveryTime1: Text;
                DeliveryTime2: Text;
                //StandardTextReport: Record "Standard Text Report";  //BC Upgrade KAPOOV01 Drink-IT
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
                CurrReportID: Integer;
                i: Integer;
                IsTextToInclude: Boolean;
                ItemLedgerEntry: Record "Item Ledger Entry";
                //NoSeriesMgt: Codeunit NoSeriesManagement;  //BC Upgrade KAPOOV01 - Blocked
                NoSeries: Codeunit "No. Series"; //BC Upgrade KAPOOV01 Added
                ModifyHeader: Boolean;
                SalesDepositLines: Record "Return Receipt Line";
                DepositGroupCode: Code[10];
                //DrinkDepositGroup: Record "Drink Deposit Group"; //BC Upgrade KAPOOV01 Drink-IT
                StartingShipmentdate: Date;
                //LoyaltyBalanceBuffer: Record "Loyalty Balance Buffer" temporary;  //BC Upgrade KAPOOV01 Drink-IT
                BeginBalDate: Date;
                EndBalDate: Date;
                BeginningMonth: Date;
                //LoyaltyLedgerEntry: Record "Loyalty Ledger Entry"; //BC Upgrade KAPOOV01 Drink-IT
                OrderChargeLine: Record "Return Receipt Line";
                ServiceSetup: Record "Service Mgt. Setup";
                Customer2: Record Customer;
                j: Integer;
            begin
                if ShipToCountryName.GET("Return Receipt Header"."Sell-to Country/Region Code") then;
                CLEAR(TotalQty);
                CLEAR(TotalQtyHL);
                CLEAR(TotalNetAmount);
                CLEAR(TotalDirectCost);

                if ShipMethod.GET("Shipment Method Code") then;
                if PayTerms.GET("Payment Terms Code") then;
                //BC Upgrade KAPOOV01 Drink-IT >>
                // if WhseShippingTruck.GET("Return Receipt Header"."Truck Code") then;
                // if Driver.GET("Return Receipt Header"."Driver Code") then;
                // if Routes.GET("Return Receipt Header".Route) then;
                //BC Upgrade KAPOOV01 Drink-IT <<

                //-----Company Info
                CompanyInfo.GET();
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
                //BC Upgrade KAPOOV01 Drink-IT >>
                // if CompanyInfo."Tax Registration No." <> '' then
                //     CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                //BC Upgrade KAPOOV01 Drink-IT <<
                //CompanyText += ', ' + ChOfComm;
                CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                if CompanyInfo."Fax No." <> '' then
                    CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";


                //-----Report Title
                CashInvoice := false;//AS
                CLEAR(ReportTitle);
                CLEAR(CashInvoice);
                if ("Payment Method Code" <> '') then begin
                    PaymentMethod.RESET();
                    PaymentMethod.GET("Payment Method Code");
                    //BC Upgrade KAPOOV01 Drink-IT >>
                    // if (PaymentMethod."Cash Payment") then begin
                    //     ReportTitle := Text002;
                    //     CashInvoice := true;
                    // end;
                    //BC Upgrade KAPOOV01 Drink-IT <<
                end;

                if PaymentMethod.GET("Payment Method Code") then;
                //Comment line
                //BC Upgrade KAPOOV01 Drink-IT Below code block logic dependent on Drink-IT Table "Standard Text Report" >>
                // StandardTextReport.RESET;
                // StandardTextReport.SETRANGE("Report ID", 50299);
                // StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);
                // if StandardTextReport.FINDSET then begin
                //     ExtendedTextHeader.RESET;
                //     ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                //     ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                //     if ExtendedTextHeader.FINDSET then
                //         repeat
                //             Var_Comments := '';
                //             ExtendedTextLine.RESET;
                //             ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                //             ExtendedTextLine.SETRANGE("Table Name", ExtendedTextLine."Table Name"::"Standard Text");
                //             if ExtendedTextLine.FINDSET then
                //                 repeat
                //                     Var_Comments += ExtendedTextLine.Text + ' ';
                //                 until ExtendedTextLine.NEXT = 0;
                //         until ExtendedTextHeader.NEXT = 0;
                // end;
                //BC Upgrade KAPOOV01 Drink-IT Below code block logic dependent on Drink-IT Table "Standard Text Report" <<

                if (ReportTitle = '') then
                    if ("Shipment Method Code" <> '') then begin
                        ShipmentMethod.RESET();
                        ShipmentMethod.GET("Shipment Method Code");
                        //BC Upgrade KAPOOV01 Drink-IT >>
                        // if ShipmentMethod.Pickup then
                        //     ReportTitle := Text003
                        // else
                        //     ReportTitle := Text004;
                        //BC Upgrade KAPOOV01 Drink-IT <<
                    end;
                ReportTitle := Text004;
                //-----Shipment Address
                ReturnReceiptHeader.RESET();
                if CashInvoice then begin
                    if ("Sell-to Country/Region Code" = CompanyInfo."Country/Region Code") then begin
                        ReturnReceiptHeader.COPY("Return Receipt Header");
                        ReturnReceiptHeader."Sell-to Country/Region Code" := '';
                        //   FormatAddr.PurchRcptPayTo(HeaderAddr, ReturnReceiptHeader);
                        //  END ELSE
                        //  FormatAddr.PurchRcptPayTo(HeaderAddr,"Return Receipt Header");
                    end else begin
                        if ("Ship-to Country/Region Code" = CompanyInfo."Country/Region Code") then begin
                            ReturnReceiptHeader.COPY("Return Receipt Header");
                            ReturnReceiptHeader."Ship-to Country/Region Code" := '';
                            // FormatAddr.PurchRcptShipTo(HeaderAddr,ReturnReceiptHeader);
                            // END ELSE
                            // FormatAddr.PurchRcptShipTo(HeaderAddr,"Return Receipt Header");
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
                        Customer.RESET();
                        Customer.GET("Sell-to Customer No.");

                        //-----Shipment Method Info
                        if "Shipment Method Code" <> '' then begin
                            ShipMethod.RESET();
                            if ShipMethod.GET("Shipment Method Code") then;
                        end;

                        //-----Route Info
                        //BC Upgrade KAPOOV01 Drink-IT >>
                        // if Route <> '' then begin
                        //     Routes.RESET;
                        //     if Routes.GET(Route) then;
                        // end;
                        //BC Upgrade KAPOOV01 Drink-IT <<
                        //-----Payment Terms Info

                        if PayTerms.GET("Payment Terms Code") then;

                        //-----Driver Info
                        //IF ("Driver Code" <> '') THEN BEGIN
                        // Driver.RESET;
                        //END;

                        //-----SalesPerson Info
                        if ("Salesperson Code" <> '') then begin
                            SalesPerson.RESET();
                            SalesPerson.GET("Salesperson Code");
                        end;

                        //-----Shipping Agent Info
                        if ("Shipping Agent Code" <> '') then begin
                            ShippingAgent.RESET();
                            ShippingAgent.GET("Shipping Agent Code");
                        end;

                        if ShippingAgent.GET("Shipping Agent Code") then;
                        //-----Retunr order Info
                        /*ReturnOrder.RESET;
                        ReturnOrder.SETRANGE("Document Type",ReturnOrder."Document Type"::"Return Order");
                        ReturnOrder.SETRANGE("Link Sales Document No.","Return Receipt Header"."Order No.");
                        ReturnOrder.SETRANGE("Link Sales Document Type",ReturnOrder."Link Sales Document Type"::Order);
                        IF ReturnOrder.FINDSET THEN; */


                        //-----Comment Lines
                        TempCommentLine.RESET();
                        TempCommentLine.DELETEALL();
                        //CommentLineNo := 10000;
                        //Customer Comments
                        CommentLine.RESET();
                        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Customer);
                        CommentLine.SETRANGE("No.", "Sell-to Customer No.");
                        //CommentLine.SETRANGE("Print On Purchase Order,TRUE);
                        if CommentLine.FINDSET() then
                            repeat
                                InsertCommentLine(CommentLine.Comment);
                            until CommentLine.NEXT() = 0;
                        //Sales Comments
                        SalesCommentLine.RESET();
                        SalesCommentLine.SETRANGE("Document Type", SalesCommentLine."Document Type"::"Posted Return Receipt");
                        SalesCommentLine.SETRANGE("No.", "No.");
                        //SalesCommentLine.SETRANGE(prin ,TRUE);
                        if SalesCommentLine.FINDSET() then
                            repeat
                                InsertCommentLine(SalesCommentLine.Comment);
                            until SalesCommentLine.NEXT() = 0;


                        //-----Currency Code
                        if CashInvoice then
                            if ("Currency Code" <> '') then
                                CurrCode := "Currency Code"
                            else begin
                                GLSetup.GET();
                                CurrCode := GLSetup."LCY Code";
                            end;


                        // CTS Document
                        ServiceSetup.GET();
                        Customer2.GET("Sell-to Customer No.");
                        CTSDocumentSubtype := "Document Subtype Code FND" = ServiceSetup."CTS Document Subtype FND"; //BC Upgrade SHUKLP03
                        if CTSDocumentSubtype then
                            ReportTitle := CTSLbl + ' ' + ReportTitle;
                        //BC Upgrade KAPOOV01 Drink-IT table - Master Data Property used >>
                        // MasterDataProperty.SETRANGE("Table ID", 18);
                        // MasterDataProperty.SETRANGE(Code, Customer2."No.");
                        // MasterDataProperty.SETRANGE("Property Code", ServiceSetup."CTS Technician Property Code");
                        // if MasterDataProperty.FINDFIRST then
                        //     MasterDataProperty.CALCFIELDS(Name);
                        //BC Upgrade KAPOOV01 Drink-IT table - Master Data Property used <<

                        // Responsibility Center
                        if ResponsibilityCenter.FINDSET() then begin
                            j := 1;
                            repeat
                                RespCenter_Code[j] := ResponsibilityCenter.Code;
                                RespCenter_PostCode[j] := ResponsibilityCenter."Post Code";
                                RespCenter_PhoneNo[j] := ResponsibilityCenter."Phone No.";
                                RespCenter_FaxNo[j] := ResponsibilityCenter."Fax No.";
                                j += 1;
                            until ResponsibilityCenter.NEXT() = 0;
                        end;
                        //HEI.01<<
                    end;
                end;

            end;

            trigger OnPostDataItem();
            begin
                if Print then begin
                    "No. Printed" := "No. Printed" + 1;
                    MODIFY();
                    COMMIT();
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
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
                    field(InclPrices; InclPrices)
                    {
                        Caption = 'Incl. Price';
                        ApplicationArea = All;
                    }
                    field(InclDeposit; InclDeposit)
                    {
                        Caption = 'Incl. Deposit';
                        ApplicationArea = All;
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
        label(SalesOrderNoLbl; ENU = 'Return Order No.',
                              FRA = 'N° Commande Vente')
        QuantityReceivedLbl = 'Quantity Received'; NameLbl = 'Name'; Name1Lbl = 'Name'; label(DriverLbl; ENU = 'Driver',
                                                                                                     FRA = 'Signature livreur')
        ApprovedByLbl = 'Approved by:'; label(ReceivedByLbl; ENU = 'Received by:',
                                                           FRA = 'Signature du contrôleur ')
        label(SignatureLbl; ENU = 'Signature',
                           FRA = 'Visa de sécurité ')
        TradeRegisterLbl = 'Trade Register'; VATNoLbl = 'VAT No.'; HeadOfficeLbl = '(Head Office)'; POBoxLbl = 'PO Box'; TelLbl = 'Tel:'; FaxLbl = 'Fax:'; label(DocumentDateLbl; ENU = 'Document Date',
                                                                                                                                                                           FRA = 'Date du Document')
        label(ShipmentDateLbl; ENU = 'Shipment Date',
                              FRA = 'Date d''Expédition')
        label(BillToCustomerLbl; ENU = 'Customer No.',
                                FRA = 'Facturé au client N°')
        BuyfromVendorNameLbl = 'Customer Name'; label(ShipToCustomerLbl; ENU = 'Ship to Customer Name',
                                                                       FRA = 'Livré au client N°')
        label(ShipToAddressLbl; ENU = 'Customer Address',
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
        LocationCodeNameLbl = 'Location Code & Name'; ShipmentNoLbl = 'Return Receipt No.'; label(DriverCodeLbl; ENU = 'Driver Code & Description',
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
        ShippingAgentServiceLbl = 'Shipping Agent Service'; BinCodeLbl = 'Bin'; ZoneCodeLbl = 'Zone'; Name2Lbl = 'Name';
    }

    var
        CompanyInfo: Record "Company Information";
        CompanyText: Text;
        OutputNo: Integer;
        TextFooter: array[3] of Text;
        FormatAddr: Codeunit "Format Address";
        Customer: Record Customer;
        ReportTitle: Text;
        //Driver: Record "Whse. Shipping Driver";  //BC Upgrade KAPOOV01 Drink-IT table
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
        ShptCountPrinted: Codeunit "Purch.Rcpt.-Printed";
        Print: Boolean;
        QtyHL: Decimal;
        CrossRefText: Text;
        ExpirationDate: Date;
        ReturnReason: Record "Return Reason";
        FreeReasonText: Text;
        Item: Record Item;
        TempEmptyGoodItemLine: Record "Return Receipt Line" temporary;
        Text001: Label 'COPY';
        LineNo: Integer;
        PaymentMethod: Record "Payment Method";
        PrintShipmentText: Boolean;
        PrintPrice: Boolean;
        TempOrderDiscountCharge: Record "Return Receipt Line" temporary;
        TotalOrderDiscCharges: Decimal;
        SubTotal: Decimal;
        CashInvoice: Boolean;
        CurrCode: Code[10];
        GLSetup: Record "General Ledger Setup";
        //SalesDepositItemCharge: Record "Sales Deposit Item Charge";  //BC Upgrade KAPOOV01 Drink-IT
        BeginningBalance: Decimal;
        EndBalance: Decimal;
        Gains: Decimal;
        Sales: Decimal;
        PrintLoyaltyStatement: Boolean;
        LineAmount: Decimal;
        TempOrderDepositCharge: Record "Return Receipt Line" temporary;
        TotalSubTotal: Decimal;
        PrintOrderDiscounts: Boolean;
        PrintOrderDeposits: Boolean;
        VATAmountLine: Record "VAT Amount Line" temporary;
        Text2014416: Label 'VAT %1%';
        VATPerText: Text;
        Text002: Label 'Sales - Return Receipt %1';
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
        ReturnRecptLine: Record "Return Receipt Line";
        SalesSetup: Record "Sales & Receivables Setup";
        TotalDiscounts: Decimal;
        TotalDeposits: Decimal;
        Text058: Label 'Loyalty Statement';
        Text059: Label 'Balance before';
        Text060: Label 'Increase';
        Text061: Label 'Decrease';
        Text062: Label 'Balance after';
        PrintUnderLineCharge: Boolean;
        TempUnderChargeLine: Record "Return Receipt Line" temporary;
        TempOrderTaxCharge: Record "Return Receipt Line" temporary;
        PrintOrderTaxes: Boolean;
        TotalTaxes: Decimal;
        TempTrackingInfo: Record "Item Ledger Entry" temporary;
        TrackingText: Text[50];
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
        //MasterDataProperty: Record "Master Data Property";  //BC Upgrade KAPOOV01 Drink-IT
        CTSLbl: Label 'CTS';
        ResponsibilityCenter: Record "Responsibility Center";
        RespCenter_Code: array[20] of Text[50];
        RespCenter_PostCode: array[20] of Text[50];
        RespCenter_PhoneNo: array[20] of Text[50];
        RespCenter_FaxNo: array[20] of Text[50];
        HeaderAddr: array[8] of Text[60];
        Text063: Label 'Sales Order No.';
        TempTrackingSpecification: Record "Item Ledger Entry" temporary;
        //DocTrackingManagement: Codeunit "Document Tracking Management"; //BC Upgrade KAPOOV01 Drink-IT Codeunit
        LotNoCnt: Integer;
        TotalQty: Decimal;
        TotalQtyHL: Decimal;
        //WhseShippingTruck: Record "Whse. Shipping Truck";  //BC Upgrade KAPOOV01 Drink-IT
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
        //Routes: Record Route;  //BC Upgrade KAPOOV01 Drink-IT
        ReturnOrder: Record "Sales Header";
        InclDeposit: Boolean;
        EmptyReturnItemCharge: Record "Sales Line";
        EmptyReturnUnitPrice: Decimal;
        TotalDirectCost: Decimal;
        Var_Comments: Text;
        TempItemLedgerEntry: Record "Item Ledger Entry" temporary;
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";

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
        //ItemCrossReference: Record "Item Cross Reference";  //BC UPGRADE KAPOOV01-Item Cross Refernce obsolete in BC
        ItemRefL: Record "Item Reference";//BC UPGRADE KAPOOV01 
    begin
        //BC Upgrade KAPOOV01 Table-"Item Cross Reference" is not available in BC, it is replaced by Item reference table >>

        // ItemCrossReference.RESET;
        // ItemCrossReference.SETRANGE("Item No.", "Return Receipt Line"."No.");
        // ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::"Bar Code");
        // if ItemCrossReference.FINDFIRST then
        //     CrossRef := Text008 + ItemCrossReference."Cross-Reference No.";
        // ItemCrossReference.RESET;
        // ItemCrossReference.SETRANGE("Item No.", "Return Receipt Line"."No.");
        // ItemCrossReference.SETRANGE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::Customer);
        // ItemCrossReference.SETRANGE("Cross-Reference Type No.", "Return Receipt Line"."Sell-to Customer No.");
        // if ItemCrossReference.FINDFIRST then begin
        //     if (CrossRef = '') then
        //         CrossRef := Text009 + ItemCrossReference."Cross-Reference No."
        //     else
        //         CrossRef += ' / ' + Text009 + ItemCrossReference."Cross-Reference No.";
        // end;

        ItemRefL.RESET();
        ItemRefL.SETRANGE("Item No.", "Return Receipt Line"."No.");
        ItemRefL.SETRANGE("Reference Type", ItemRefL."Reference Type"::"Bar Code");
        if ItemRefL.FINDFIRST() then
            CrossRef := Text008 + ItemRefL."Reference No.";
        ItemRefL.RESET();
        ItemRefL.SETRANGE("Item No.", "Return Receipt Line"."No.");
        ItemRefL.SETRANGE("Reference Type", ItemRefL."Reference Type"::Customer);
        ItemRefL.SETRANGE("Reference Type No.", "Return Receipt Line"."Sell-to Customer No.");
        if ItemRefL.FINDFIRST() then begin
            if (CrossRef = '') then
                CrossRef := Text009 + ItemRefL."Reference No."
            else
                CrossRef += ' / ' + Text009 + ItemRefL."Reference No.";
        end;
        //BC Upgrade KAPOOV01 Table-"Item Cross Reference" is not available in BC, it is replaced by Item reference table <<
    end;

    local procedure IsEmptyGoodItem(): Boolean;
    begin
        /*IF ("Return Receipt Line".Type <> "Return Receipt Line".Type::Item) OR (("Return Receipt Line".Type =  "Return Receipt Line".Type::Item) AND ("Return Receipt Line"."No."='')) THEN
          EXIT;
        Item.GET("Return Receipt Line"."No.");
        Item.CALCFIELDS("Empty Good");
        EXIT(
          Item."Empty Good"); */

    end;

    local procedure UoM();
    begin
        TempUnitOfMeasure.RESET();
        if OutputNo = 1 then
            if TempUnitOfMeasure.GET(ItemLedgerEntry."Unit of Measure Code") then begin
                TempUnitOfMeasure."Column 1 Amt." += ItemLedgerEntry.Quantity;
                TempUnitOfMeasure.MODIFY();
            end else begin
                TempUnitOfMeasure.INIT();
                TempUnitOfMeasure."Currency Code" := ItemLedgerEntry."Unit of Measure Code";
                TempUnitOfMeasure."Column 1 Amt." := ItemLedgerEntry.Quantity;
                TempUnitOfMeasure.INSERT();
            end;
    end;
}

