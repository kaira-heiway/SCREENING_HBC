report 53061 "Delivery Note - Shipment STD"
{
    // version HEI.15

    // DITW110.00.11 AKH 02/11/2017 NRQ#43605 New Report
    // 
    // HEI.01 FDD-RW-GAPLOG02 IBM NASTAA02 10.09.2018 # Delivery Note
    //   # Copied Report 50161 - Delivery Note - Shipment Alm and created dataset and layout according to Rwanda requirements
    // HEI.02 DefectID 4284  HT476  CHG2011084 IBM GAVANM01 12.08.2019
    //   # error when NoOfCopies is greater then 0
    // HEI.03 Defect4464 IBM BULIMC01 25/11/2019 #new changes in the header layout
    // HEI.04 CHG2044752 Defect #5073 IBM GAVANM01 24.12.2019 #new changes in the header layout
    // HEI.05 CHG2044752 Defect #5083 IBM GAVANM01 13.01.2020 #Gate Entry No added in the header
    // HEI.06 CHG2024500 Defect #5279 IBM GAVANM01 04.03.2020 code and layout changes
    // HEI.07 CHG2053498 IBM SAMANR01 03.04.2020
    //   # Change the Request Page "save value" property as "False"
    //   # Add Control "Route Planing No." & "Posted Warehouse Shipment No." on request page
    //   # Add code for report run from Route Planning Worksheet.
    // HEI.08 CHG2058892 IBM SAMANR01 15.04.2020
    //   # Add code and design to enhancements the report
    // HEI.09 CHG2063989 IBM GAVANM01 13.05.2020 Increase the length of TrackingText to 103
    // HEI.10 CHG2076916 IBM GAVANM01 24.08.2020 fields not translated from English to French
    //   # translation of some fields and code changes
    // HEI.11 CHG2089867 IBM GAVANM01 03.12.2020 if No Printed > 0 then Copy should be added in front of Delivery Note
    // HEI.12 CHG2105841 IBM GHOSHS05 22.06.2021 RDLC layout changed
    //   # LblMissingBTLMissing (BTL)
    //   # LblBreakageBTLBreakage (BTL)
    //   # LblLoadedEmptiesCustLoaded Empties at Customer
    //   # LblReceivedEmptiesReceived Empties at Warehouse
    //   # LblExpectedEmptiestoReturnExpected Empties to Return
    //   # LblSignatureDeliveryofProductsSignature/stamp: Delivery of Products
    //   # LblSignatureReturnofEmptiesSignature/stamp: Return of Empties these labels were added
    //   # Text028 content changed
    // HEI.13 CHG2124279 IBM GHOSHS05 31.08.2021 Hid the field Quantity Received in RDLC
    // HEI.14 CHG2144396 IBM GHOSHS05 28.01.2022 Added PrintingTime to show proper time in both Webclient and RTC
    // HEI.15 CHG2294105 IBM ADHIKG01 15.04.2025 Addition column in delivery note for missing crate, low fills
    //   # Added new field "Show Additional Column on Delivery Note" in the request page
    //   # Added logic to get the ShowAdditionalColumnDN value from Sales & Receivable Setup
    //   # Added new column "Missing Crate/Low Fills" and the visibility condition in the RDLC layout

    // BC Upgrade KUMARR78 >>
    // Report Name  : Delivery Note - Shipment STD
    // Report ID    : 50268
    //
    // 1. Added Business Central visibility properties.
    //    Old:
    //         - ApplicationArea not mandatory in NAV.
    //         - UsageCategory not defined.
    //    New:
    //         - ApplicationArea = All
    //         - UsageCategory = ReportsAndAnalysis
    //
    // 2. Added ApplicationArea on Request Page fields.
    //    Old:
    //         - Request Page fields without ApplicationArea property.
    //    New:
    //         - ApplicationArea = All added to:
    //              • NoOfCopies
    //              • InclPrices
    //              • InclDeposit
    //              • RoutePlnaningNo
    //              • PostedWareHouseShipmentNo
    //              • ShowAdditionalColumnDN
    //
    // 3. Updated Request Page OnLookup trigger signature.
    //    Old:
    //         trigger OnLookup(Text: Text): Boolean;
    //    New:
    //         trigger OnLookup(var Text: Text): Boolean;
    //    Applied on:
    //         • PostedWareHouseShipmentNo
    //
    // 4. Replaced deprecated and renamed standard references.
    //    Old:
    //         - Record "Item Cross Reference"
    //         - NoSeriesMgt: Codeunit NoSeriesManagement;
    //         - Language: Record Language;
    //         - Field: "Cross-Reference No."
    //    New:
    //         - Record "Item Reference"
    //         - NoSeriesMgt: Codeunit "No. Series";
    //         - RecLanguage: Record Language;
    //         - Field: "Reference No."
    //         - Language variable renamed to avoid BC datatype conflict.
    //
    // 5. Removed Document Tracking Management dependency.
    //    Old:
    //         - DocTrackingManagement.CallPostedItemTracking1(...)
    //         - DocTrackingManagement.GetPostedTrackingText(...)
    //         - TrackingText1 derived using DocTrackingManagement.
    //    New:
    //         - All DocTrackingManagement calls commented.
    //         - LotNoCnt derived from TempTrackingSpecification.Count only.
    //         - TrackingText1 logic blocked to remove Codeunit dependency.
    //
    // 6. Removed deprecated and DIT-specific charge logic.
    //    Old:
    //         - "Item Charge Type" filters and conditions.
    //         - "Show Item charge on Invoice" filters.
    //         - Subtotal/TotalSubTotal using "Line Amount".
    //         - (Amount = 0) condition in Sales Shipment Line loop.
    //    New:
    //         - Only Type::"Charge (Item)" used.
    //         - All DIT-specific filters commented.
    //         - Dependent subtotal/tax/discount logic commented.
    //         - Loop retained without Amount dependency.
    //
    // 7. Removed DIT-specific functional blocks.
    //    Old:
    //         - Empty Goods logic:
    //              • Customer."Empty Returned Items Based On"
    //              • "Item DDeposit Group Code"
    //              • DrinkDepositGroup
    //              • "Deposit Value"
    //              • "Empty Goods Item No."
    //              • Link Sales Document fields
    //         - Loyalty Statement logic:
    //              • Customer."Loyalty Statement On"
    //              • LoyaltyBalanceBuffer / LoyaltyLedgerEntry
    //              • "Net Point Change (Actual)"
    //         - Standard Text Footer (Extended Text usage).
    //    New:
    //         - Entire functional blocks commented.
    //         - Related variables removed.
    //         - Core report structure preserved.
    //
    // 8. Removed DIT-specific header and master data fields.
    //    Old:
    //         - RouteName (Routes.Name)
    //         - TechnicianName (MasterDataProperty.Name)
    //         - Truck Code / Truck Name
    //         - Driver Code / Driver Name
    //         - Bank Name 2 / IBAN 2 / SWIFT Code 2
    //         - CompanyInfo."Tax Registration No."
    //         - PaymentMethod."Cash Payment"
    //         - ShipmentMethod.Pickup
    //         - Delivery Time fields
    //         - "Route Planning No."
    //         - "Exp. Date on Del. Note"
    //         - "Document Subtype Code"
    //         - "Empty Good"
    //         - Free Reason Code
    //    New:
    //         - Columns retained with blank ('') expressions where needed.
    //         - All above references commented or removed.
    //         - ShippingAgent retained as standard BC entity.
    //         - ShowLotSerialInfo handled independently.
    //         - ReportTitle simplified using Text002/Text004.
    //
    // 9. Removed DIT-specific filters and table dependencies.
    //    Old:
    //         - SETRANGE / SETFILTER on "Route Planning No."
    //         - GETFILTER("Route Planning No.")
    //         - CommentLine.SETRANGE("Print on Shipment", true);
    //         - SalesCommentLine.SETRANGE("Print on Shipment", true);
    //         - Whse. Shipping Truck / Driver tables
    //         - Route table
    //         - Sales Deposit Item Charge
    //         - Master Data Property
    //    New:
    //         - All DIT-specific filters commented.
    //         - RoutePlaningControlVisible boolean used for control.
    //         - Only standard filter retained:
    //              • "Posted Warehouse Shipment No."
    //         - Core BC standard tables retained.
    //
    // 10. Maintained RDLC dataset compatibility.
    //     Old:
    //         - Dataset bound directly to removed DIT fields.
    //     New:
    //         - Columns retained with blank ('') expressions where needed.
    //         - Structural dataset hierarchy unchanged.
    //         - Layout compatibility ensured without runtime errors.
    //
    // BC Upgrade KUMARR78 <<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Delivery Note - Shipment STD.rdl';
    ApplicationArea = All; // BC Upgrade BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade BC Upgrade KUMARR78 Adding Usagecategory

    Caption = 'Delivery Note - Shipment STD';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Shipment Header';
            column(No_SalesHeader; "No.")
            {
            }
            column(PrintingTime; PrintingTime)
            {
            }
            column(InclPrices; InclPrices)
            {
            }
            column(InclDeposit; InclDeposit)
            {
            }
            column(ShowAdditionalColumnDN; ShowAdditionalColumnDN)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(ReturnOrderNo; ReturnOrder."No.")
                    {
                    }
                    column(RouteName; Routes.Name)// BC Upgrade SHUKLP03 DIT Colomn Variable Blocked
                    {
                    }
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
                    // column(TechnicianName; MasterDataProperty.Name)//BC Upgrade KUMARR78 DIT Variable Colomn Blocked
                    // {
                    // }


                    column(TechnicianName; '') // BC Upgrade KUMARR78 Passing Blank Value for Expression.
                    {
                    }

                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ReportTitle; ReportTitle)
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
                    column(CompanyInfo__BankName__2; CompanyInfo."Bank Name 2 FND") //BC Upgrade SHUKLP03 DIT Variable Colomn Blocked
                    {
                    }
                    column(CompanyInfo__BankName; CompanyInfo."Bank Name")
                    {
                    }
                    //BC Upgrade SHUKLP03>> 
                    column(CompanyInfo__IBAN__2; CompanyInfo."IBAN 2 FND")
                    {
                    }

                    column(CompanyInfo__SWIFTCode__2; CompanyInfo."SWIFT Code 2 FND")
                    {
                    }
                    //BC Upgrade SHUKLP03<< 
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
                    column(Route_SalesHeader; "Sales Shipment Header"."Route 107FDW") //BC Upgrade SHUKLP03 DIT Colomn Variable Blocked.
                    {
                    }
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
                    //BC Upgrade SHUKLP03>> DIT Colomn Variable Blocked.
                    column(SalesShipmentHeader_TruckCode; "Sales Shipment Header"."Vehicle Code 101FDW")
                    {
                    }
                    column(SalesShipmentHeader_TruckName; WhseShippingTruck.Description)
                    {
                    }
                    //BC Upgrade SHUKLP03<< DIT Colomn Variable Blocked.

                    column(SalesShipmentHeader_GateEntryNo; "Sales Shipment Header"."Gate Entry No. FND")
                    {
                    }
                    //BC Upgrade SHUKLP03>> DIT Colomn Variable Blocked.
                    column(SalesShipmentHeader_DriverCode; "Sales Shipment Header"."Log Driver 107FDW")
                    {
                    }
                    column(Name_Driver; Driver.Description)
                    {
                    }
                    //BC Upgrade SHUKLP03<< DIT Colomn Variable Blocked.

                    column(ShipToCountryName; ShipToCountryName.Name)
                    {
                    }

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
                        DataItemTableView = sorting(Number);
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
                                CurrReport.Skip();

                            VATPerText := StrSubstNo(Text2014416, VATAmountLine."VAT %");
                        end;

                        trigger OnPreDataItem();
                        begin
                            VATAmountLine.Reset();
                            SetRange(Number, 1, VATAmountLine.Count);
                        end;
                    }
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = sorting("Document No.", "Line No.");
                        column(Type_SalesLine; Format(Type, 0, 2))
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
                        column(LineAmount_SalesLine; "Item Charge Base Amount") //BC Upgrade SHUKLP03>> Replaced "Line Amount" with "Item Charge Base Amount" because value is coming same.
                        {
                        }
                        column(FreeItem_SalesLine; "Line Discount %")
                        {
                        }
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
                        // column(LineDiscAmount; "Sales Shipment Line"."Line Discount Amount")//BC Upgrade SHUKLP03  Not required as not added in report layout
                        // {
                        // }
                        column(TotalNetAmount; TotalNetAmount)
                        {
                        }
                        dataitem("Item Ledger Entry"; "Item Ledger Entry")
                        {
                            DataItemLink = "Document No." = field("Document No."), "Document Line No." = field("Line No."), "Item No." = field("No.");
                            DataItemLinkReference = "Sales Shipment Line";
                            DataItemTableView = sorting("Entry No.");
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
                                //HEI.01>>
                                MoreLotSerialLines := false;
                                ItemLedgerEntry.SetRange("Document No.", "Document No.");
                                ItemLedgerEntry.SetRange("Document Line No.", "Document Line No.");
                                ItemLedgerEntry.SetRange("Item No.", "Item No.");
                                ItemLedgerEntry.SetFilter("Entry No.", '<>%1', "Entry No.");
                                MoreLotSerialLines := ItemLedgerEntry.FindFirst();

                                if (MaxStrLen(TrackingText) - StrLen(TrackingText) > 2) then begin  //HEI.09
                                    if "Lot No." <> '' then
                                      //TrackingText := "Lot No." + ' ' + FORMAT("Expiration Date")  //commented by HEI.06
                                      //>>HEI.06
                                      begin
                                        if TrackingText <> '' then
                                            TrackingText += ', ';
                                        //TrackingText += "Lot No." + ' ' + FORMAT("Expiration Date");  //commented by HEI.09
                                        TrackingText += CopyStr("Lot No." + ' ' + Format("Expiration Date"), 1, MaxStrLen(TrackingText) - StrLen(TrackingText));   //HEI.09
                                    end //<<HEI.06
                                    else if "Serial No." <> '' then
                                      //TrackingText := "Serial No." + ' ' + FORMAT("Expiration Date")  //commented by HEI.06
                                      //>>HEI.06
                                      begin
                                        if TrackingText <> '' then
                                            TrackingText += ', ';
                                        //TrackingText += "Serial No." + ' ' + FORMAT("Expiration Date")  //HEI.06   //commented by HEI.09
                                        TrackingText += CopyStr("Serial No." + ' ' + Format("Expiration Date"), 1, MaxStrLen(TrackingText) - StrLen(TrackingText));   //HEI.09
                                    end; //<<HEI.06
                                         //HEI.01<<
                                end; //HEI.09
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            ItemLedgEntry: Record "Item Ledger Entry";
                            // ItemCrossReference: Record "Item Cross Reference"; //BC Upgrade KUMARR78 Table Replaced in BC with "Item Reference" 
                            ItemCrossReference: Record "Item Reference"; //BC Upgrade KUMARR78 Replaced with "Item Cross Reference"
                            ReservEntry: Record "Reservation Entry";
                            OrderChargeLine: Record "Sales Shipment Line";
                            SalesChargeLine: Record "Sales Shipment Line";
                            IsTextToInclude: Boolean;
                        begin
                            if not CashInvoice then begin
                                if not (Type in [Type::" ", Type::Item, Type::"Charge (Item)"]) then
                                    CurrReport.Skip()
                                else if Type = Type::"Charge (Item)" then begin
                                    if not InclDeposit then
                                        CurrReport.Skip()
                                    //BC Upgrade SHUKLP03>> Blocking Condition As DIT Field Removed("Item Charge Type").
                                    else if "Attached Line Type 101FDW" <> "Attached Line Type 101FDW"::"EGM 104FDW" then
                                        CurrReport.SKIP();
                                    //BC Upgrade SHUKLP03<< Blocking Condition As DIT Field Removed("Item Charge Type").
                                end;
                            end else
                                if Type = Type::"Charge (Item)" then begin
                                    if not InclDeposit then
                                        CurrReport.Skip()
                                    //BC Upgrade SHUKLP03>> Blocking Condition As DIT Field Removed("Item Charge Type").
                                    else if "Attached Line Type 101FDW" <> "Attached Line Type 101FDW"::"EGM 104FDW" then
                                        CurrReport.SKIP();
                                    //BC Upgrade SHUKLP03<< Blocking Condition As DIT Field Removed("Item Charge Type").

                                end;

                            //-----Qty in HL
                            Clear(QtyHL);
                            //BC Upgrade SHUKLP03>> Blocking Condition As DIT Field Removed("Unit Volume HL").
                            if (Type = Type::Item) and ("No." <> '') then
                                QtyHL := Quantity * "Volume 1 101FDW";
                            //BC Upgrade SHUKLP03<< Blocking Condition As DIT Field Removed("Unit Volume HL").

                            TotalQty += "Sales Shipment Line".Quantity;
                            TotalQtyHL += QtyHL;
                            TotalNetAmount += "Sales Shipment Line"."Item Charge Base Amount"; //BC Upgrade SHUKLP03>> Replaced LineAmount with Item Charge Base Amount.
                            //-----Cross Reference Info


                            //BC Upgrade SHUKLP03>> Blocking Condition As Field Removed("Cross. Ref. on Del. Note").
                            //  Clear(CrossRefText);
                            if Customer."Cross. Ref. on Del. Note FND" then begin
                                if (Type = Type::Item) and ("No." <> '') then
                                    CrossRefText := GetCrossReferences();
                            end;
                            //BC Upgrade SHUKLP03<< Blocking Condition As Field Removed("Cross. Ref. on Del. Note").

                            //-----Expiration Info
                            Clear(ExpirationDate);
                            //IF Customer."Exp. Date on Del. Note" THEN BEGIN
                            ReservEntry.Reset();
                            ReservEntry.SetCurrentKey("Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
                            ReservEntry.SetRange("Source Type", 111);
                            ReservEntry.SetRange("Source Subtype", 1);
                            ReservEntry.SetRange("Source ID", "Document No.");
                            ReservEntry.SetRange("Source Ref. No.", "Line No.");
                            if ReservEntry.FindFirst() then begin
                                ItemLedgEntry.Reset();
                                ItemLedgEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");
                                ItemLedgEntry.SetRange("Item No.", ReservEntry."Item No.");
                                ItemLedgEntry.SetRange(Open, true);
                                ItemLedgEntry.SetRange("Variant Code", ReservEntry."Variant Code");
                                if ReservEntry."Lot No." <> '' then
                                    ItemLedgEntry.SetRange("Lot No.", ReservEntry."Lot No.")
                                else
                                    if ReservEntry."Serial No." <> '' then
                                        ItemLedgEntry.SetRange("Serial No.", ReservEntry."Serial No.");
                                ItemLedgEntry.SetRange(Positive, true);

                                if ItemLedgEntry.FindLast() then
                                    ExpirationDate := ItemLedgEntry."Expiration Date";
                            end;
                            //END;
                            //-----Free Reason Text

                            //BC Upgrade SHUKLP03>> Blocking Condition As DIT Field Removed("Free Reason Code").
                            CLEAR(FreeReasonText);
                            if "Reason Code 101FDW" <> '' then begin
                                FreeReasonCode.GET("Reason Code 101FDW");
                                FreeReasonText := FreeReasonCode.Description;
                            end;
                            //BC Upgrade SHUKLP03<< Blocking Condition As DIT Field Removed("Free Reason Code").

                            //-----Price Info
                            //BC Upgrade SHUKLP03>> Blocking Condition As DIT Field Removed("Empty Good").
                            Clear(PrintPrice);
                            if CashInvoice then
                                if (Type = Type::Item) and ("No." <> '') then begin
                                    Item.Get("No.");
                                    Item.CALCFIELDS("Is Empty Good 104FDW");
                                    PrintPrice := not (Item."Is Empty Good 104FDW");
                                end;
                            //BC Upgrade SHUKLP03<< Blocking Condition As DIT Field Removed("Empty Good").

                            //-----Subtotal
                            //BC Upgrade SHUKLP03>> 
                            if CashInvoice then
                                if
                                (
                                  (Type = Type::Item) and not (IsEmptyGoodItem())
                                  or (Type in [Type::Resource, Type::"Fixed Asset", Type::"G/L Account"])
                                ) then begin
                                    SubTotal += "Item Charge Base Amount";
                                    TotalSubTotal += "Item Charge Base Amount";
                                end;
                            //BC Upgrade SHUKLP03<< 

                            //Charges included in item price
                            //Tax to Grand Total + Total + Line Amount

                            if CashInvoice then begin

                                //BC Upgrade SHUKLP03>> 
                                SalesChargeLine.RESET();
                                SalesChargeLine.SETRANGE("Document No.", "Sales Shipment Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Shipment Line".Type::"Charge (Item)");
                                SalesChargeLine.SETRANGE("Attached Line Type 101FDW", "Sales Shipment Line"."Attached Line Type 101FDW"::"TAX 102FDW");
                                SalesChargeLine.SETRANGE("Show Item charge on Inv. FND", SalesChargeLine."Show Item charge on Inv. FND"::"Include in item price");
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Shipment Line"."Line No.");
                                if SalesChargeLine.FINDSET() then
                                    repeat
                                        "Sales Shipment Line"."Item Charge Base Amount" += SalesChargeLine."Item Charge Base Amount";
                                        SubTotal += SalesChargeLine."Item Charge Base Amount";
                                        TotalSubTotal += SalesChargeLine."Item Charge Base Amount";
                                    until SalesChargeLine.NEXT() = 0;
                                //BC Upgrade SHUKLP03<< 

                                //Discounts to Grand Total + Total + Line Amount

                                //BC Upgrade SHUKLP03>> 
                                CLEAR(PrintUnderLineCharge);
                                SalesChargeLine.RESET();
                                SalesChargeLine.SETRANGE("Document No.", "Sales Shipment Line"."Document No.");
                                SalesChargeLine.SETRANGE(Type, "Sales Shipment Line".Type::"Charge (Item)");
                                SalesChargeLine.SETRANGE("Attached Line Type 101FDW", "Sales Shipment Line"."Attached Line Type 101FDW"::"SPC 105FDW");
                                SalesChargeLine.SETRANGE("Show Item charge on Inv. FND", SalesChargeLine."Show Item charge on Inv. FND"::"Include in item price");
                                SalesChargeLine.SETRANGE("Attached to Line No.", "Sales Shipment Line"."Line No.");
                                if SalesChargeLine.FINDSET() then
                                    repeat
                                        "Sales Shipment Line"."Item Charge Base Amount" += SalesChargeLine."Item Charge Base Amount";
                                        SubTotal += SalesChargeLine."Item Charge Base Amount";
                                        TotalSubTotal += SalesChargeLine."Item Charge Base Amount";
                                    until SalesChargeLine.NEXT() = 0;
                                //BC Upgrade SHUKLP03<< 

                                //Discounts under item line
                                SalesChargeLine.Reset();
                                SalesChargeLine.SetRange("Document No.", "Sales Shipment Line"."Document No.");
                                SalesChargeLine.SetRange(Type, "Sales Shipment Line".Type::"Charge (Item)");
                                SalesChargeLine.SETRANGE("Attached Line Type 101FDW", "Sales Shipment Line"."Attached Line Type 101FDW"::"SPC 105FDW"); //BC Upgrade SHUKLP03<< Blocking Condition As Field Removed("Item Charge Type").
                                SalesChargeLine.SETRANGE("Show Item charge on Inv. FND", SalesChargeLine."Show Item charge on Inv. FND"::"Under item line"); //BC Upgrade SHUKLP03
                                SalesChargeLine.SetRange("Attached to Line No.", "Sales Shipment Line"."Line No.");
                                if SalesChargeLine.FindSet() then
                                    if not PrintUnderLineCharge then
                                        PrintUnderLineCharge := true;
                                repeat
                                    TempUnderChargeLine.Init();
                                    TempUnderChargeLine := SalesChargeLine;
                                    TempUnderChargeLine.Insert();
                                until (SalesChargeLine.Next() = 0);

                                //BC Upgrade SHUKLP03>> 
                                SalesChargeLine.CALCSUMS("Item Charge Base Amount");
                                SubTotal += SalesChargeLine."Item Charge Base Amount";
                                TotalSubTotal += SalesChargeLine."Item Charge Base Amount";
                                //BC Upgrade SHUKLP03<< 

                                //Tax under item line
                                SalesChargeLine.Reset();
                                SalesChargeLine.SetRange("Document No.", "Sales Shipment Line"."Document No.");
                                SalesChargeLine.SetRange(Type, "Sales Shipment Line".Type::"Charge (Item)");
                                SalesChargeLine.SETRANGE("Attached Line Type 101FDW", "Sales Shipment Line"."Attached Line Type 101FDW"::"TAX 102FDW"); //BC Upgrade SHUKLP03>> Blocking Condition As Field Removed("Item Charge Type")
                                SalesChargeLine.SETRANGE("Show Item charge on Inv. FND", SalesChargeLine."Show Item charge on Inv. FND"::"Under item line"); //BC Upgrade SHUKLP03>> Blocking Condition As Field Removed("Show Item charge on Invoice")
                                SalesChargeLine.SetRange("Attached to Line No.", "Sales Shipment Line"."Line No.");
                                if SalesChargeLine.FindSet() then
                                    repeat
                                        if (SalesChargeLine."Item Charge Base Amount" <> 0) then begin //BC Upgrade SHUKLP03<< 
                                            if not PrintUnderLineCharge then
                                                PrintUnderLineCharge := true;
                                            TempUnderChargeLine.Init();
                                            TempUnderChargeLine := SalesChargeLine;
                                            TempUnderChargeLine.Insert();
                                        end;
                                    until (SalesChargeLine.Next() = 0);

                                //BC Upgrade SHUKLP03>> 
                                SalesChargeLine.CALCSUMS("Item Charge Base Amount");
                                SubTotal += SalesChargeLine."Item Charge Base Amount";
                                TotalSubTotal += SalesChargeLine."Item Charge Base Amount";
                                if ("Sales Shipment Line".Quantity <> 0) then
                                    "Sales Shipment Line"."Unit Price" := "Sales Shipment Line"."Item Charge Base Amount" / "Sales Shipment Line".Quantity;
                                //BC Upgrade SHUKLP03>> 
                            end;

                            //HEI.01>>
                            // ExtendedText
                            if Type = Type::Item then begin
                                TempMarketingText.DeleteAll();
                                ExtendedTextHeader.Reset();

                                ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::Item);
                                ExtendedTextHeader.SetRange("No.", "No.");
                                ExtendedTextHeader.SetRange("Print on Delivery Note FND", true);
                                if ExtendedTextHeader.FindSet() then
                                    repeat
                                        IsTextToInclude := true;
                                        if ExtendedTextHeader."Starting Date" <> 0D then
                                            IsTextToInclude := (ExtendedTextHeader."Starting Date" <= "Posting Date");
                                        if IsTextToInclude and (ExtendedTextHeader."Ending Date" <> 0D) then
                                            IsTextToInclude := (ExtendedTextHeader."Ending Date" >= "Posting Date");
                                        if IsTextToInclude then begin
                                            ExtendedTextLine.Reset();
                                            ExtendedTextLine.SetRange("Table Name", ExtendedTextHeader."Table Name");
                                            ExtendedTextLine.SetRange("No.", ExtendedTextHeader."No.");
                                            ExtendedTextLine.SetRange("Text No.", ExtendedTextHeader."Text No.");
                                            if ExtendedTextLine.FindFirst() then
                                                repeat
                                                    TempMarketingText.Init();
                                                    TempMarketingText := ExtendedTextLine;
                                                    TempMarketingText.Insert();
                                                until (ExtendedTextLine.Next() = 0);
                                        end;
                                    until ExtendedTextHeader.Next() = 0;
                            end;
                            //HEI.01<<
                            Clear(TrackingText1);
                            Clear(TrackingText);  //HEI.06

                            //BC Upgrade KUMARR78>> Blocking As Variable Removed(DocTrackingManagement)
                            // DocTrackingManagement.CallPostedItemTracking1(
                            //   DATABASE::"Sales Shipment Line", 0, "Document No.", '', 0, "Line No.", TempTrackingSpecification);
                            //BC Upgrade KUMARR78<< Blocking As Variable Removed(DocTrackingManagement)

                            LotNoCnt := TempTrackingSpecification.Count;

                            //BC Upgrade KUMARR78>> Blocking As Variable Removed(DocTrackingManagement)
                            // if LotNoCnt = 1 then 
                            //     TrackingText1 := DocTrackingManagement.GetPostedTrackingText(TempTrackingSpecification) + ' ' + FORMAT(TempTrackingSpecification."Expiration Date");
                            //BC Upgrade KUMARR78<< Blocking As Variable Removed(DocTrackingManagement)

                            //Total by UOM>>
                            TempUnitOfMeasure.Reset();
                            if TempUnitOfMeasure.Get("Sales Shipment Line"."Unit of Measure Code") then begin
                                TempUnitOfMeasure."Column 1 Amt." += "Sales Shipment Line".Quantity;
                                TempUnitOfMeasure.Modify();
                            end else begin
                                TempUnitOfMeasure.Init();
                                TempUnitOfMeasure."Currency Code" := "Sales Shipment Line"."Unit of Measure Code";
                                TempUnitOfMeasure."Column 1 Amt." := "Sales Shipment Line".Quantity;
                                TempUnitOfMeasure.Insert();
                            end;
                            //Total by UOM<<
                        end;

                        trigger OnPreDataItem();
                        var
                            ReservEntry: Record "Reservation Entry";
                        begin
                            VATAmountLine.DeleteAll();
                            MoreLines := FindLast();

                            while MoreLines and (Description = '') and ("Description 2" = '') and
                                  ("No." = '') and (Quantity = 0)
                            //BC Upgrade SHUKLP03>> 
                              and
                              ("Item Charge Base Amount" = 0)
                            //BC Upgrade SHUKLP03<< 
                            do
                                MoreLines := Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            SetRange("Line No.", 0, "Line No.");

                            TempEmptyGoodItemLine.Reset();
                            if TempEmptyGoodItemLine.FindLast() then
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
                                if not TempUnitOfMeasure.Find('-') then
                                    CurrReport.Break();
                            end else
                                if TempUnitOfMeasure.Next() = 0 then
                                    CurrReport.Break();
                        end;

                        trigger OnPostDataItem();
                        begin
                            TempUnitOfMeasure.DeleteAll();
                        end;

                        trigger OnPreDataItem();
                        begin
                            TempUnitOfMeasure.Reset();
                            SetRange(Number, 1, TempUnitOfMeasure.Count);
                        end;
                    }
                    dataitem("Empty Return Header"; "Sales Header")
                    {
                        column(SalesEmptyHeader_No; "Empty Return Header"."No.")
                        {
                        }
                        dataitem("Empty Return Line"; "Sales Line")
                        {
                            DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
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
                                EmptyReturnItemCharge.Reset();
                                EmptyReturnItemCharge.SetRange("Document Type", "Document Type"::"Return Order");
                                EmptyReturnItemCharge.SetRange("Document No.", "Empty Return Line"."Document No.");
                                EmptyReturnItemCharge.SetRange("Attached to Line No.", "Empty Return Line"."Line No.");
                                EmptyReturnItemCharge.SetFilter(Type, '%1', EmptyReturnItemCharge.Type::"Charge (Item)");
                                EmptyReturnItemCharge.SETFILTER("Attached Line Type 101FDW", '%1', EmptyReturnItemCharge."Attached Line Type 101FDW"::"SPC 105FDW");  //BC Upgrade SHUKLP03>> Blocking Conditon As Field Removed("Item Charge Type")
                                if EmptyReturnItemCharge.FindSet() then
                                    repeat
                                        EmptyReturnUnitPrice += EmptyReturnItemCharge."Unit Price";
                                    until EmptyReturnItemCharge.Next() = 0;

                                //HEI.08>>
                                LotNo := '';
                                ReservationEntry.Reset();
                                ReservationEntry.SetRange("Source ID", "Empty Return Line"."Document No.");
                                ReservationEntry.SetRange("Source Type", 37);
                                ReservationEntry.SetRange("Source Subtype", ReservationEntry."Source Subtype"::"5");
                                ReservationEntry.SetRange("Item No.", "Empty Return Line"."No.");
                                if ReservationEntry.FindSet() then
                                    repeat
                                        if LotNo = '' then
                                            LotNo := ReservationEntry."Lot No." + ' ' + Format(ReservationEntry."Expiration Date")
                                        else
                                            LotNo := LotNo + ',' + ReservationEntry."Lot No." + ' ' + Format(ReservationEntry."Expiration Date");
                                    until ReservationEntry.Next() = 0;
                                //Total by UOM<<
                                TempUnitOfMeasure_EmptyReturn.Reset();
                                if TempUnitOfMeasure_EmptyReturn.Get("Empty Return Line"."Unit of Measure Code") then begin
                                    TempUnitOfMeasure_EmptyReturn."Column 1 Amt." += "Empty Return Line".Quantity;
                                    TempUnitOfMeasure_EmptyReturn.Modify();
                                end else begin
                                    TempUnitOfMeasure_EmptyReturn.Init();
                                    TempUnitOfMeasure_EmptyReturn."Currency Code" := "Empty Return Line"."Unit of Measure Code";
                                    TempUnitOfMeasure_EmptyReturn."Column 1 Amt." := "Empty Return Line".Quantity;
                                    TempUnitOfMeasure_EmptyReturn.Insert();
                                end;
                                //Total by UOM<<
                                //HEI.08<<
                            end;

                            trigger OnPreDataItem();
                            begin
                                //SETFILTER(Type,'%1|%2',Type::Item,Type::"Charge (Item)");
                                SetFilter(Type, '%1', Type::Item);
                                SetRange("Document Type", "Document Type"::"Return Order");
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
                                //HEI.08>>
                                if Number = 1 then begin
                                    if not TempUnitOfMeasure_EmptyReturn.Find('-') then
                                        CurrReport.Break();
                                end else
                                    if TempUnitOfMeasure_EmptyReturn.Next() = 0 then
                                        CurrReport.Break();
                                //HEI.08<<
                            end;

                            trigger OnPostDataItem();
                            begin
                                //HEI.08>>
                                TempUnitOfMeasure_EmptyReturn.DeleteAll();
                                //HEI.08<<
                            end;

                            trigger OnPreDataItem();
                            begin
                                //HEI.08>>
                                TempUnitOfMeasure_EmptyReturn.Reset();
                                SetRange(Number, 1, TempUnitOfMeasure_EmptyReturn.Count);

                                //HEI.08<<
                            end;
                        }

                        trigger OnPreDataItem();
                        begin
                            //BC Upgrade KUMARR78>> Blocking Conditon As Field Removed("Link Sales Document No.")
                            SETRANGE("No.", "Sales Shipment Header"."Order No.");
                            // SETRANGE("Link Sales Document Type", "Link Sales Document Type"::Order); 
                            //BC Upgrade KUMARR78<< Blocking Conditon As Field Removed("Link Sales Document No.")
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    TempTrackingSpecification.DeleteAll();  //HEI.02

                    if Number > 1 then begin
                        CopyText := Text001;
                        OutputNo += 1;
                    end else
                        CopyText := '';
                    Clear(SubTotal);
                    Clear(TotalSubTotal);
                end;

                trigger OnPostDataItem();
                begin

                    if Print then
                        ShptCountPrinted.Run("Sales Shipment Header");
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
            var
                Customer2: Record Customer;
                StandardTextReport: Record "Standard Text Report FND"; //BC Upgrade SHUKLP03 << Variable Removed in BC
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
                ItemLedgerEntry: Record "Item Ledger Entry";
                SalesShipmentHeader: Record "Sales Shipment Header";
                // LoyaltyLedgerEntry: Record "Loyalty Ledger Entry"; //BC Upgrade KUMARR78 Variable Removed in BC
                OrderChargeLine: Record "Sales Shipment Line";
                SalesDepositLines: Record "Sales Shipment Line";
                ServiceSetup: Record "Service Mgt. Setup";
                ShipmentMethod: Record "Shipment Method";
                // NoSeriesMgt: Codeunit NoSeriesManagement; BC Upgrade KUMARR78 Variable Replaced in BC (NoSeriesManagement)
                NoSeriesMgt: Codeunit "No. Series"; //BC Upgrade KUMARR78 Variable Replaced in BC from (NoSeriesManagement to "No. Series")
                IsTextToInclude: Boolean;
                ModifyHeader: Boolean;
                DepositGroupCode: Code[10];
                // LoyaltyBalanceBuffer: Record "Loyalty Balance Buffer" temporary; //BC Upgrade KUMARR78 Variable Removed in BC
                BeginBalDate: Date;
                BeginningMonth: Date;
                EndBalDate: Date;
                DrinkDepositGroup: Record Code104FDW;//"Drink Deposit Group"; //BC Upgrade KUMARR78 Variable Removed in BC
                StartingShipmentdate: Date;
                CurrReportID: Integer;
                i: Integer;
                j: Integer;
                DeliveryTime1: Text;
                DeliveryTime2: Text;
            begin
                if ShipToCountryName.Get("Sales Shipment Header"."Ship-to Country/Region Code") then;
                Clear(TotalQty);
                Clear(TotalQtyHL);

                //-----Company Info
                CompanyInfo.Get();
                //Picture
                CompanyInfo.CalcFields(Picture, "OpCo Footer image FND");
                //Company Text
                Clear(CompanyText);
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
                    if CountryInfo.Get(CompanyInfo."Country/Region Code") then
                        CompanyText += ', ' + CompanyInfo."Country/Region Code" + ' ' + CountryInfo.Name;
                //BC Upgrade KUMARR78>> DIT Field Removed in BC
                // if CompanyInfo."Tax Registration No." <> '' then
                //     CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                // BC Upgrade SHUKLP03 >> ---- Field ("Tax Registration No.")
                CUSTOMSDOCManage.get();
                IF CUSTOMSDOCManage."Tax Registration No." <> '' THEN
                    CompanyText += ', ' + TaxNoID + ' ' + CUSTOMSDOCManage."Tax Registration No.";
                // BC Upgrade SHUKLP03 << ---- Field ("Tax Registration No.")

                //BC Upgrade KUMARR78<< DIT Field Removed in BC
                CompanyText += ', ' + ChOfComm;
                CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";


                //-----Report Title
                CashInvoice := false;//AS
                Clear(ReportTitle);
                Clear(CashInvoice);
                if ("Payment Method Code" <> '') then begin
                    PaymentMethod.Reset();
                    PaymentMethod.Get("Payment Method Code");
                    if (PaymentMethod."Cashier Order FND") then begin//BC Upgrade KUMARR78>> DIT Field Removed in BC
                        ReportTitle := Text002;
                        CashInvoice := true;
                    end;//BC Upgrade KUMARR78>> DIT Field Removed in BC and Blocking End for Begin.
                end;



                if (ReportTitle = '') then
                    if ("Shipment Method Code" <> '') then begin
                        ShipmentMethod.Reset();
                        ShipmentMethod.Get("Shipment Method Code");
                        //BC Upgrade SHUKLP03>> DIT Field Removed in BC
                        if ShipmentMethod."CM Shipment Type APS" = ShipmentMethod."CM Shipment Type APS"::Pickup then
                            ReportTitle := Text003
                        else
                            //BC Upgrade SHUKLP03<< DIT Field Removed in BC
                            ReportTitle := Text004;
                    end;

                //ReportTitle := Text004; //commented by HEI.11
                //HEI.11<<
                ReportTitle := Text002;
                if "Sales Shipment Header"."No. Printed" > 0 then
                    ReportTitle := Text50002 + ' ' + ReportTitle;
                //HEI.11>>

                //-----Shipment Address
                SalesShipmentHeader.Reset();
                if CashInvoice then begin
                    if ("Bill-to Country/Region Code" = CompanyInfo."Country/Region Code") then begin
                        SalesShipmentHeader.Copy("Sales Shipment Header");
                        SalesShipmentHeader."Bill-to Country/Region Code" := '';
                        FormatAddr.SalesShptBillTo(HeaderAddr, HeaderAddr, SalesShipmentHeader);
                    end else
                        FormatAddr.SalesShptBillTo(HeaderAddr, HeaderAddr, "Sales Shipment Header");
                end else begin
                    if ("Ship-to Country/Region Code" = CompanyInfo."Country/Region Code") then begin
                        SalesShipmentHeader.Copy("Sales Shipment Header");
                        SalesShipmentHeader."Ship-to Country/Region Code" := '';
                        FormatAddr.SalesShptShipTo(HeaderAddr, SalesShipmentHeader);
                    end else
                        FormatAddr.SalesShptShipTo(HeaderAddr, "Sales Shipment Header");
                end;
                //Shipment Text
                Clear(PrintShipmentText);
                if CashInvoice then
                    PrintShipmentText := ("Bill-to Name" <> "Ship-to Name") or
                                         ("Bill-to Name 2" <> "Ship-to Name 2") or
                                         ("Bill-to Address" <> "Ship-to Address") or
                                         ("Bill-to Address 2" <> "Ship-to Address 2") or
                                         ("Bill-to Post Code" <> "Ship-to Post Code") or
                                         ("Bill-to City" <> "Ship-to City");

                //-----Header Tel. & Fax
                Customer.Reset();
                Customer.Get("Sell-to Customer No.");

                //-----Shipment Method Info
                //commented by HEI.10>>
                /*IF "Shipment Method Code" <> '' THEN BEGIN
                  ShipMethod.RESET;
                  IF ShipMethod.GET("Shipment Method Code") THEN;
                END;*/
                //commented by HEI.10<<
                //HEI.10>>


                if ShipMethod.GET("Shipment Method Code") then
                    // ShipMethod.TranslateDescription(ShipMethod, Language.Code); //BC Upgrade KUMARR78>> Blocking variable as Conflict with Standard.(Language)
                    ShipMethod.TranslateDescription(ShipMethod, RecLanguage.Code); //BC Upgrade KUMARR78>> Renaming variable as Conflict with Standard(RecLanguage from Language)


                //HEI.10<<

                //-----Route Info

                //BC Upgrade KUMARR78>> DIT Variable Removed in BC(Route)
                if "Route 107FDW" <> '' then begin
                    Routes.RESET;
                    if Routes.GET("Route 107FDW") then;
                end;
                //BC Upgrade KUMARR78<< DIT Variable Removed in BC(Route)

                //-----Payment Terms Info
                //commented by HEI.10>>
                /*IF "Payment Terms Code" <> '' THEN BEGIN
                  PayTerms.RESET;
                  IF PayTerms.GET("Payment Terms Code") THEN;
                END;*/
                //commented by HEI.10<<
                //HEI.10>>

                if PayTerms.GET("Payment Terms Code") then
                    // PayTerms.TranslateDescription(PayTerms, Language.Code);//BC Upgrade KUMARR78>> Blocking variable as Conflict with Standard.(Language)
                    PayTerms.TranslateDescription(PayTerms, RecLanguage.Code); //BC Upgrade KUMARR78>> Renaming variable as Conflict with Standard(RecLanguage from Language)

                //HEI.10<<

                //-----Driver Info
                //BC Upgrade SHUKLP03>> DIT Variable Removed in BC(Driver)
                if ("Log Driver 107FDW" <> '') then begin
                    Driver.RESET;
                    Driver.GET("Log Driver 107FDW");
                end;
                //BC Upgrade SHUKLP03<<DIT Variable Removed in BC(Driver)

                //-----SalesPerson Info
                if ("Salesperson Code" <> '') then begin
                    SalesPerson.Reset();
                    SalesPerson.Get("Salesperson Code");
                end;


                //-----Shipping Agent Info
                if ("Shipping Agent Code" <> '') then begin
                    ShippingAgent.Reset();
                    ShippingAgent.Get("Shipping Agent Code");
                end;
                // BC Upgrade SHUKLP03 >>
                //-----Retunr order Info
                ReturnOrder.RESET();
                ReturnOrder.SETRANGE("Document Type", ReturnOrder."Document Type"::"Return Order");
                ReturnOrder.SETRANGE("No.", "Sales Shipment Header"."Order No.");
                // ReturnOrder.SETRANGE("Link Sales Document Type", ReturnOrder."Link Sales Document Type"::Order);
                if ReturnOrder.FINDSET() then;
                // BC Upgrade SHUKLP03 << 
                //BC Upgrade KUMARR78>> DIT Field Obsolete in BC("Link Sales Document No.","Delivery Time 1 From",Pickup,"Delivery Time 2 From")

                // //-----Delivery Times
                // CLEAR(TextDeliveryTime);
                // CLEAR(blnDeliveryTime);

                // if "Delivery Time Code 107FDW" <> 000000T then begin
                //     if "Delivery Time 1 To" <> 000000T then
                //         DeliveryTime1 := FORMAT("Delivery Time 1 From", 5) + '-' + FORMAT("Delivery Time 1 To", 5)
                //     else
                //         DeliveryTime1 := FORMAT("Delivery Time 1 From", 5);
                //     if DeliveryTime1 <> '' then
                //         if ShipmentMethod.Pickup then
                //             TextDeliveryTime := Text005 + '  ' + DeliveryTime1
                //         else
                //             TextDeliveryTime := Text006 + '  ' + DeliveryTime1;
                // end;
                // if "Delivery Time 2 From" <> 000000T then begin
                //     if "Delivery Time 2 To" <> 000000T then
                //         DeliveryTime2 := FORMAT("Delivery Time 2 From", 5) + '-' + FORMAT("Delivery Time 2 To", 5)
                //     else
                //         DeliveryTime2 := FORMAT("Delivery Time 2 From", 5);
                //     if DeliveryTime2 <> '' then
                //         TextDeliveryTime := TextDeliveryTime + ' ' + Text007 + ' ' + DeliveryTime2;
                // end;
                //BC Upgrade KUMARR78 >> DIT Field Obsolete in BC("Link Sales Document No.","Delivery Time 1 From",Pickup,"Delivery Time 2 From") 
                // blnDeliveryTime := (TextDeliveryTime <> '') and not (ShipmentMethod.Pickup);//BC Upgrade KUMARR78

                //-----Comment Lines
                TempCommentLine.Reset();
                TempCommentLine.DeleteAll();
                CommentLineNo := 10000;
                //Customer Comments
                CommentLine.Reset();
                CommentLine.SetRange("Table Name", CommentLine."Table Name"::Customer);
                CommentLine.SetRange("No.", "Sell-to Customer No.");
                // CommentLine.SETRANGE("Print on Shipment", true); //BC Upgrade KUMARR78>> DIT Field Removed in BC("Print on Shipment")
                if CommentLine.FindSet() then
                    repeat
                        InsertCommentLine(CommentLine.Comment);
                    until CommentLine.Next() = 0;
                //Sales Comments
                SalesCommentLine.Reset();
                SalesCommentLine.SetRange("Document Type", SalesCommentLine."Document Type"::Shipment);
                SalesCommentLine.SetRange("No.", "No.");
                SalesCommentLine.SETRANGE("Print on Delivery Note FND", true); //BC Upgrade KUMARR78>> DIT Field Removed in BC("Print on Shipment")
                if SalesCommentLine.FindSet() then
                    repeat
                        InsertCommentLine(SalesCommentLine.Comment);
                    until SalesCommentLine.Next() = 0;

                //-----Footer Texts

                //BC Upgrade SHUKLP03>> DIT Field Removed in BC(StandardTextReport)
                CLEAR(CurrReportID);
                CLEAR(i);
                CLEAR(TextFooter);
                EVALUATE(CurrReportID, COPYSTR(CurrReport.OBJECTID(false), 8));
                StandardTextReport.SETRANGE("Report ID", CurrReportID);
                StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);

                if StandardTextReport.FINDSET then
                    repeat
                        i := 1;
                        ExtendedTextHeader.RESET();
                        ExtendedTextHeader.SETRANGE("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                        ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                        if ExtendedTextHeader.FINDSET() then begin
                            repeat
                                ExtendedTextLine.RESET();
                                ExtendedTextLine.SETRANGE("Table Name", ExtendedTextHeader."Table Name");
                                ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                                ExtendedTextLine.SETRANGE("Text No.", ExtendedTextHeader."Text No.");
                                if ExtendedTextLine.FINDSET() then begin
                                    repeat
                                        TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                                    until (ExtendedTextLine.NEXT() = 0) or (i > ARRAYLEN(TextFooter));
                                end;
                                i += 1;
                            until (ExtendedTextHeader.NEXT() = 0);
                        end;
                    until (StandardTextReport.NEXT = 0);
                //BC Upgrade SHUKLP03<< DIT Field Removed in BC(StandardTextReport)
                //-----Empty Goods Block
                // BC Upgrade SHUKLP03>> DIT Field and Variables Removed in BC("Empty Returned Items Based On","Item DDeposit Group Code",DrinkDepositGroup,Amount,"Deposit Value")
                TempEmptyGoodItemLine.RESET();
                TempEmptyGoodItemLine.DELETEALL();
                case Customer."CM Autosuggest Ret. Ent. APS" of
                    Customer."CM Autosuggest Ret. Ent. APS"::Yes:
                        begin
                            SalesDepositLines.SETCURRENTKEY("Document No.");
                            SalesDepositLines.SETRANGE("Document No.", "Sales Shipment Header"."No.");
                            SalesDepositLines.SETRANGE(Type, SalesDepositLines.Type::Item);
                            // SalesDepositLines.SETRANGE("Attached Line Type 101FDW", SalesDepositLines."Attached Line Type 101FDW"::"EGM 104FDW");
                            if SalesDepositLines.FINDSET() then begin
                                repeat
                                    if DrinkDepositGroup.GET(SalesDepositLines."No.") then begin
                                        if DrinkDepositGroup."CM Empty Good Bundle Item APS" <> '' then begin
                                            TempEmptyGoodItemLine.RESET();
                                            TempEmptyGoodItemLine.SETRANGE("No.", DrinkDepositGroup."CM Empty Good Bundle Item APS");
                                            if not TempEmptyGoodItemLine.FINDFIRST() then begin
                                                LineNo += 10000;
                                                TempEmptyGoodItemLine.INIT();
                                                TempEmptyGoodItemLine."No." := DrinkDepositGroup."CM Empty Good Bundle Item APS";
                                                if Item.GET(DrinkDepositGroup."CM Empty Good Bundle Item APS") then
                                                    TempEmptyGoodItemLine.Description := Item.Description;
                                                if SalesDepositLines."Quantity (Base)" > 0 then begin
                                                    TempEmptyGoodItemLine.Quantity := SalesDepositLines."Quantity (Base)";
                                                    // TempEmptyGoodItemLine.Amount := Item."Deposit Value"; // SHUKLP03 << Obsolete
                                                end else begin
                                                    TempEmptyGoodItemLine."Quantity (Base)" := -SalesDepositLines."Quantity (Base)";
                                                    // TempEmptyGoodItemLine.Amount := Item."Deposit Value"; // SHUKLP03 << Obsolete
                                                end;
                                                TempEmptyGoodItemLine."Document No." := "No.";
                                                TempEmptyGoodItemLine."Line No." := LineNo;
                                                TempEmptyGoodItemLine.INSERT();
                                            end else begin
                                                if SalesDepositLines."Quantity (Base)" > 0 then begin
                                                    TempEmptyGoodItemLine.Quantity += SalesDepositLines."Quantity (Base)";
                                                end else begin
                                                    TempEmptyGoodItemLine."Quantity (Base)" += -SalesDepositLines."Quantity (Base)";
                                                end;
                                                TempEmptyGoodItemLine.MODIFY();
                                            end;
                                        end;
                                    end;
                                until (NEXT() = 0);
                            end;
                        end;
                    Customer."CM Autosuggest Ret. Ent. APS"::Default:
                        begin
                            SalesDepositLines.SETCURRENTKEY("Document No.");
                            SalesDepositLines.SETRANGE("Document No.", "Sales Shipment Header"."No.");
                            SalesDepositLines.SETRANGE(Type, SalesDepositLines.Type::Item);
                            SalesDepositLines.SETFILTER("Attached Line Type 101FDW", '<>%1', SalesDepositLines."Attached Line Type 101FDW"::"EGM 104FDW");
                            if SalesDepositLines.FINDSET() then begin
                                repeat
                                    if DrinkDepositGroup.GET(SalesDepositLines."No.") then begin
                                        if DrinkDepositGroup."CM Empty Good Bundle Item APS" <> '' then begin
                                            TempEmptyGoodItemLine.RESET();
                                            TempEmptyGoodItemLine.SETRANGE("No.", DrinkDepositGroup."CM Empty Good Bundle Item APS");
                                            if not TempEmptyGoodItemLine.FINDFIRST() then begin
                                                LineNo += 10000;
                                                TempEmptyGoodItemLine.INIT();
                                                TempEmptyGoodItemLine."No." := DrinkDepositGroup."CM Empty Good Bundle Item APS";
                                                if Item.GET(DrinkDepositGroup."CM Empty Good Bundle Item APS") then
                                                    TempEmptyGoodItemLine.Description := Item.Description;
                                                if SalesDepositLines."Quantity (Base)" > 0 then begin
                                                    TempEmptyGoodItemLine.Quantity := SalesDepositLines."Quantity (Base)";
                                                    // TempEmptyGoodItemLine.Amount := Item."Deposit Value"; // SHUKLP03 << Obsolete
                                                end else begin
                                                    TempEmptyGoodItemLine."Quantity (Base)" := -SalesDepositLines."Quantity (Base)";
                                                    // TempEmptyGoodItemLine.Amount := Item."Deposit Value"; // SHUKLP03 << Obsolete
                                                end;
                                                TempEmptyGoodItemLine."Document No." := "No.";
                                                TempEmptyGoodItemLine."Line No." := LineNo;
                                                TempEmptyGoodItemLine.INSERT();
                                            end else begin
                                                if SalesDepositLines."Quantity (Base)" > 0 then begin
                                                    TempEmptyGoodItemLine.Quantity += SalesDepositLines."Quantity (Base)";
                                                end else begin
                                                    TempEmptyGoodItemLine."Quantity (Base)" += -SalesDepositLines."Quantity (Base)";
                                                end;
                                                TempEmptyGoodItemLine.MODIFY();
                                            end;
                                        end;
                                    end;
                                until (NEXT() = 0);
                            end;
                        end;

                end;

                // BC Upgrade SHUKLP03 >> Obsolete as per aptean.
                //     end;
                // end;
                // Customer."Empty Returned Items Based On"::History:
                //     begin
                //         DrinkDepositGroup.GET(DrinkDepositGroup."Source Type"::Customer, Customer."Customer DDeposit Group Code");
                //         DrinkDepositGroup.TESTFIELD("Empty Good Reference period");
                //         StartingShipmentdate := CALCDATE('-' + FORMAT(DrinkDepositGroup."Empty Good Reference period"), "Shipment Date");
                //         ItemLedgerEntry.SETCURRENTKEY("Source Type", "Source No.", "Item DDeposit Group Code", "Posting Date");
                //         ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
                //         ItemLedgerEntry.SETRANGE("Source No.", "Sales Shipment Header"."Sell-to Customer No.");
                //         ItemLedgerEntry.SETFILTER("Item DDeposit Group Code", '<>%1', '');
                //         ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', StartingShipmentdate, "Sales Shipment Header"."Shipment Date");
                //         if ItemLedgerEntry.FINDSET() then begin
                //             repeat
                //                 ItemLedgerEntry.SETRANGE("Item DDeposit Group Code", ItemLedgerEntry."Item DDeposit Group Code");
                //                 if DrinkDepositGroup.GET(DrinkDepositGroup."Source Type"::Item, ItemLedgerEntry."Item DDeposit Group Code") then begin
                //                     if DrinkDepositGroup."Empty Good Reference Item No." <> '' then begin
                //                         with SalesDepositLines do begin
                //                             SETCURRENTKEY("Document No.", "Item DDeposit Group Code");
                //                             SETRANGE("Document No.", "Sales Shipment Header"."No.");
                //                             SETRANGE(Type, Type::Item);
                //                             SETRANGE("Item DDeposit Group Code", DrinkDepositGroup.Code);
                //                             if FINDSET() then begin
                //                                 repeat
                //                                     TempEmptyGoodItemLine.RESET();
                //                                     TempEmptyGoodItemLine.SETRANGE("No.", DrinkDepositGroup."Empty Good Reference Item No.");
                //                                     if not TempEmptyGoodItemLine.FINDFIRST() then begin
                //                                         LineNo += 10000;
                //                                         TempEmptyGoodItemLine.INIT();
                //                                         TempEmptyGoodItemLine."No." := DrinkDepositGroup."Empty Good Reference Item No.";
                //                                         if Item.GET(DrinkDepositGroup."Empty Good Reference Item No.") then
                //                                             TempEmptyGoodItemLine.Description := Item.Description;
                //                                         if "Quantity (Base)" > 0 then begin
                //                                             TempEmptyGoodItemLine.Quantity := "Quantity (Base)";
                //                                             TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                //                                         end else begin
                //                                             TempEmptyGoodItemLine."Quantity (Base)" := -"Quantity (Base)";
                //                                             TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                //                                         end;
                //                                         TempEmptyGoodItemLine."Document No." := "No.";
                //                                         TempEmptyGoodItemLine."Line No." := LineNo;
                //                                         TempEmptyGoodItemLine.INSERT();
                //                                     end else begin
                //                                         if "Quantity (Base)" > 0 then begin
                //                                             TempEmptyGoodItemLine.Quantity += "Quantity (Base)";
                //                                         end else begin
                //                                             TempEmptyGoodItemLine."Quantity (Base)" += -"Quantity (Base)";
                //                                         end;
                //                                         TempEmptyGoodItemLine.MODIFY();
                //                                     end;
                //                                 until (NEXT() = 0);
                //                             end;
                //                         end;
                //                     end;
                //                 end;
                //                 ItemLedgerEntry.FINDLAST();
                //                 ItemLedgerEntry.SETRANGE("Item DDeposit Group Code");
                //                 ItemLedgerEntry.SETFILTER("Item DDeposit Group Code", '<>%1', '');
                //             until (ItemLedgerEntry.NEXT() = 0);
                //         end;
                //     end;
                // Customer."Empty Returned Items Based On"::"Fixed Block":
                //     begin
                //         DrinkDepositGroup.RESET;
                //         DrinkDepositGroup.SETRANGE("Include In Fixed Block", true);
                //         DrinkDepositGroup.SETFILTER("Empty Good Reference Item No.", '<>%1', '');
                //         if not DrinkDepositGroup.ISEMPTY then begin
                //             DrinkDepositGroup.FINDSET;
                //             repeat
                //                 with SalesDepositLines do begin
                //                     SETCURRENTKEY("Document No.", "Item DDeposit Group Code");
                //                     SETRANGE("Document No.", "Sales Shipment Header"."No.");
                //                     SETRANGE(Type, Type::Item);
                //                     SETRANGE("Item DDeposit Group Code", DrinkDepositGroup.Code);
                //                     if FINDSET() then begin
                //                         repeat
                //                             TempEmptyGoodItemLine.RESET();
                //                             TempEmptyGoodItemLine.SETRANGE("No.", DrinkDepositGroup."Empty Good Reference Item No.");
                //                             if not TempEmptyGoodItemLine.FINDFIRST() then begin
                //                                 LineNo += 10000;
                //                                 TempEmptyGoodItemLine.INIT();
                //                                 TempEmptyGoodItemLine."No." := DrinkDepositGroup."Empty Good Reference Item No.";
                //                                 if Item.GET(DrinkDepositGroup."Empty Good Reference Item No.") then
                //                                     TempEmptyGoodItemLine.Description := Item.Description;
                //                                 if "Quantity (Base)" > 0 then begin
                //                                     TempEmptyGoodItemLine.Quantity := "Quantity (Base)";
                //                                     TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                //                                 end else begin
                //                                     TempEmptyGoodItemLine."Quantity (Base)" := -"Quantity (Base)";
                //                                     TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                //                                 end;
                //                                 TempEmptyGoodItemLine."Document No." := "No.";
                //                                 TempEmptyGoodItemLine."Line No." := LineNo;
                //                                 TempEmptyGoodItemLine.INSERT();
                //                             end else begin
                //                                 if "Quantity (Base)" > 0 then begin
                //                                     TempEmptyGoodItemLine.Quantity += "Quantity (Base)";
                //                                 end else begin
                //                                     TempEmptyGoodItemLine."Quantity (Base)" += -"Quantity (Base)";
                //                                 end;
                //                                 TempEmptyGoodItemLine.MODIFY();
                //                             end;
                //                         until (NEXT() = 0);
                //                     end;
                //                 end;
                //             until (DrinkDepositGroup.NEXT) = 0;
                //         end;
                //     end;
                // Customer."Empty Returned Items Based On"::"Document / Item(charges)":
                //     begin
                //         with SalesDepositLines do begin
                //             SETCURRENTKEY("Document No.", "Item DDeposit Group Code");
                //             SETRANGE("Document No.", "Sales Shipment Header"."No.");
                //             SETFILTER("Empty Goods Item No.", '<>%1', '');
                //             if FINDSET() then begin
                //                 repeat
                //                     SETFILTER("Empty Goods Item No.", "Empty Goods Item No.");
                //                     if FINDSET() then
                //                         repeat
                //                             TempEmptyGoodItemLine.RESET();
                //                             TempEmptyGoodItemLine.SETRANGE("No.", "Empty Goods Item No.");
                //                             if not TempEmptyGoodItemLine.FINDFIRST() then begin
                //                                 LineNo += 10000;
                //                                 TempEmptyGoodItemLine.INIT();
                //                                 TempEmptyGoodItemLine."No." := "Empty Goods Item No.";
                //                                 if Item.GET("Empty Goods Item No.") then
                //                                     TempEmptyGoodItemLine.Description := Item.Description;
                //                                 if "Quantity (Base)" > 0 then begin
                //                                     TempEmptyGoodItemLine.Quantity := "Quantity (Base)";
                //                                     TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                //                                 end else begin
                //                                     TempEmptyGoodItemLine."Quantity (Base)" := -"Quantity (Base)";
                //                                     TempEmptyGoodItemLine.Amount := Item."Deposit Value";
                //                                 end;
                //                                 TempEmptyGoodItemLine."Document No." := "No.";
                //                                 TempEmptyGoodItemLine."Line No." := LineNo;
                //                                 TempEmptyGoodItemLine.INSERT();
                //                             end else begin
                //                                 if "Quantity (Base)" > 0 then begin
                //                                     TempEmptyGoodItemLine.Quantity += "Quantity (Base)";
                //                                 end else begin
                //                                     TempEmptyGoodItemLine."Quantity (Base)" += -"Quantity (Base)";
                //                                 end;
                //                                 TempEmptyGoodItemLine.MODIFY();
                //                             end;
                //                         until (NEXT() = 0);
                //                     if FINDLAST() then;
                //                     SETRANGE("Empty Goods Item No.");
                //                     SETFILTER("Empty Goods Item No.", '<>%1', '');
                //                 until (NEXT() = 0);
                //             end;
                //         end;
                //     end;
                // end;
                // BC Upgrade SHUKLP03 << Obsolete as per aptean.

                //BC Upgrade KUMARR78<< DIT Field and Variables Removed in BC("Empty Returned Items Based On","Item DDeposit Group Code",DrinkDepositGroup,Amount,"Deposit Value","Empty Goods Item No.")
                //-----Currency Code
                if CashInvoice then
                    if ("Currency Code" <> '') then
                        CurrCode := "Currency Code"
                    else begin
                        GLSetup.Get();
                        CurrCode := GLSetup."LCY Code";
                    end;
                //-----Loyalty Statement
                //BC Upgrade KUMARR78>> DIT Field and Variables Removed in BC("Loyalty Statement On",LoyaltyBalanceBuffer,"Net Point Change (Actual)","Date Filter")
                // CLEAR(BeginningBalance);
                // CLEAR(EndBalance);
                // CLEAR(Gains);
                // CLEAR(Sales);
                // CLEAR(PrintLoyaltyStatement);
                // if CashInvoice then
                //     if (Customer."Loyalty Statement On" in [Customer."Loyalty Statement On"::"Delivery Note",
                //                                            Customer."Loyalty Statement On"::"Invoice + Delivery Note"])
                //     then begin
                //         PrintLoyaltyStatement := true;
                //         LoyaltyBalanceBuffer.INIT;
                //         LoyaltyBalanceBuffer.SETFILTER("Source Type Filter", '%1', LoyaltyBalanceBuffer."Source Type Filter"::Customer);
                //         LoyaltyBalanceBuffer.SETFILTER("Source No. Filter", Customer."No.");

                //         BeginBalDate := CALCDATE('<CM-1M>', "Posting Date");
                //         LoyaltyBalanceBuffer.SETFILTER("Date Filter", '..%1', BeginBalDate);
                //         LoyaltyBalanceBuffer.CALCFIELDS("Net Point Change (Actual)");
                //         BeginningBalance := LoyaltyBalanceBuffer."Net Point Change (Actual)";

                //         EndBalDate := CALCDATE('<CM>', "Posting Date");
                //         LoyaltyBalanceBuffer.SETFILTER("Date Filter", '..%1', EndBalDate);
                //         LoyaltyBalanceBuffer.CALCFIELDS("Net Point Change (Actual)");
                //         EndBalance := LoyaltyBalanceBuffer."Net Point Change (Actual)";

                //         BeginningMonth := CALCDATE('<1D>', BeginBalDate);

                //         LoyaltyLedgerEntry.RESET;
                //         LoyaltyLedgerEntry.SETFILTER("Source Type", '%1', LoyaltyLedgerEntry."Source Type"::Customer);
                //         LoyaltyLedgerEntry.SETFILTER("Source No.", Customer."No.");
                //         LoyaltyLedgerEntry.SETFILTER("Posting Date", '%1..%2', BeginningMonth, EndBalDate);
                //         LoyaltyLedgerEntry.SETRANGE("Entry Type", LoyaltyLedgerEntry."Entry Type"::Sale);
                //         LoyaltyLedgerEntry.SETRANGE("Loyalty Type", LoyaltyLedgerEntry."Loyalty Type"::Point);
                //         LoyaltyLedgerEntry.CALCSUMS("Point Amount (Actual)");
                //         Gains := LoyaltyLedgerEntry."Point Amount (Actual)";

                //         LoyaltyLedgerEntry.SETFILTER("Entry Type", '<>%1', LoyaltyLedgerEntry."Entry Type"::Sale);
                //         LoyaltyLedgerEntry.CALCSUMS("Point Amount (Actual)");
                //         Sales := LoyaltyLedgerEntry."Point Amount (Actual)";
                //     end;
                // SalesShptLine.CalcVATAmountLines("Sales Shipment Header", VATAmountLine);
                //BC Upgrade KUMARR78<< DIT Field and Variables Removed in BC("Loyalty Statement On",LoyaltyBalanceBuffer,"Net Point Change (Actual)","Date Filter")
                Clear(TotalDeposits);
                Clear(TotalDiscounts);
                Clear(TotalTaxes);

                //-----Order total /blank Discount Charges
                if CashInvoice then begin
                    OrderChargeLine.Reset();
                    OrderChargeLine.SetRange("Document No.", "No.");
                    OrderChargeLine.SetRange(Type, OrderChargeLine.Type::"Charge (Item)");
                    OrderChargeLine.SETRANGE("Attached Line Type 101FDW", OrderChargeLine."Attached Line Type 101FDW"::"SPC 105FDW");  //BC Upgrade KUMARR78<< DIT Field and Variables Removed in BC("Item Charge Type")
                    OrderChargeLine.SETFILTER("Show Item charge on Inv. FND", '%1|%2', OrderChargeLine."Show Item charge on Inv. FND"::"Order total", OrderChargeLine."Show Item charge on Inv. FND"::" "); //BC Upgrade KUMARR78<< DIT Field and Variables Removed in BC("Show Item charge on Invoice")
                    if OrderChargeLine.FindSet() then begin
                        PrintOrderDiscounts := true;
                        repeat
                            TempOrderDiscountCharge.Init();
                            TempOrderDiscountCharge := OrderChargeLine;
                            TempOrderDiscountCharge.Insert();
                        until (OrderChargeLine.Next() = 0);
                        OrderChargeLine.CALCSUMS("Item Charge Base Amount"); //BC Upgrade SHUKLP03<< 
                        TotalDiscounts += OrderChargeLine."Item Charge Base Amount"; //BC Upgrade SHUKLP03<< 
                    end;
                    //-----Order total /blank Deposit Charges
                    OrderChargeLine.Reset();
                    OrderChargeLine.SetRange("Document No.", "No.");
                    OrderChargeLine.SetRange(Type, OrderChargeLine.Type::"Charge (Item)");
                    OrderChargeLine.SETRANGE("Attached Line Type 101FDW", OrderChargeLine."Attached Line Type 101FDW"::"EGM 104FDW"); //BC Upgrade KUMARR78<< DIT Field and Variables Removed in BC("Item Charge Type")
                    OrderChargeLine.SETFILTER("Show Item charge on Inv. FND", '%1|%2', OrderChargeLine."Show Item charge on Inv. FND"::"Order total", OrderChargeLine."Show Item charge on Inv. FND"::" "); //BC Upgrade KUMARR78<< DIT Field and Variables Removed in BC("Show Item charge on Invoice")
                    if OrderChargeLine.FindSet() then begin
                        PrintOrderDeposits := true;
                        repeat
                            TempOrderDepositCharge.Init();
                            TempOrderDepositCharge := OrderChargeLine;
                            TempOrderDepositCharge.Insert();
                        until (OrderChargeLine.Next() = 0);
                        OrderChargeLine.CALCSUMS("Item Charge Base Amount"); //BC Upgrade SHUKLP03<< 
                        TotalDeposits += OrderChargeLine."Item Charge Base Amount";  //BC Upgrade SHUKLP03<< 
                    end;
                    //-----Order total /blank Tax Charges
                    OrderChargeLine.Reset();
                    OrderChargeLine.SetRange("Document No.", "No.");
                    OrderChargeLine.SetRange(Type, OrderChargeLine.Type::"Charge (Item)");
                    OrderChargeLine.SETRANGE("Attached Line Type 101FDW", OrderChargeLine."Attached Line Type 101FDW"::"TAX 102FDW"); //BC Upgrade KUMARR78<< DIT Field and Variables Removed in BC("Item Charge Type")
                    OrderChargeLine.SETFILTER("Show Item charge on Inv. FND", '%1|%2', OrderChargeLine."Show Item charge on Inv. FND"::"Order total", OrderChargeLine."Show Item charge on Inv. FND"::" "); //BC Upgrade KUMARR78<< DIT Field and Variables Removed in BC("Show Item charge on Invoice")
                    if OrderChargeLine.FindSet() then begin
                        repeat
                            if (OrderChargeLine."Item Charge Base Amount" <> 0) then begin //BC Upgrade SHUKLP03<< 
                                TempOrderTaxCharge.Init();
                                TempOrderTaxCharge := OrderChargeLine;
                                TempOrderTaxCharge.Insert();
                            end;
                        until (OrderChargeLine.Next() = 0);
                        OrderChargeLine.CALCSUMS("Item Charge Base Amount"); //BC Upgrade SHUKLP03<<
                        TotalTaxes += OrderChargeLine."Item Charge Base Amount"; //BC Upgrade SHUKLP03<< 
                    end;
                end;

                //HEI.01>>
                // Tracking Info
                ShowLotSerialInfo := false;
                ShowLotSerialInfo := Customer."Exp. Date on Del. Note FND"; //BC Upgrade KUMARR78<< DIT Field and Variables Removed in BC("Exp. Date on Del. Note")

                if ShowLotSerialInfo then
                    TrackingInfoDescriptionLbl := LotSerialInfoLbl
                else
                    TrackingInfoDescriptionLbl := Text027;

                // CTS Document
                ServiceSetup.Get();
                Customer2.Get("Sell-to Customer No.");
                CTSDocumentSubtype := "Document Subtype Code FND" = ServiceSetup."CTS Document Subtype FND"; //BC Upgrade SHUKLP03 << (Document Subtype Code")
                if CTSDocumentSubtype then
                    ReportTitle := CTSLbl + ' ' + ReportTitle;

                //BC Upgrade KUMARR78>> DIT Field and Variables Removed in BC(MasterDataProperty)
                // MasterDataProperty.SETRANGE("Table ID", 18);
                // MasterDataProperty.SETRANGE(Code, Customer2."No.");
                // MasterDataProperty.SETRANGE("Property Code", ServiceSetup."CTS Technician Property Code");
                // if MasterDataProperty.FINDFIRST then
                //     MasterDataProperty.CALCFIELDS(Name);
                //BC Upgrade KUMARR78<< DIT Field and Variables Removed in BC(MasterDataProperty)

                // Responsibility Center
                if ResponsibilityCenter.FindSet() then begin
                    j := 1;
                    repeat
                        RespCenter_Code[j] := ResponsibilityCenter.Code;
                        RespCenter_PostCode[j] := ResponsibilityCenter."Post Code";
                        RespCenter_PhoneNo[j] := ResponsibilityCenter."Phone No.";
                        RespCenter_FaxNo[j] := ResponsibilityCenter."Fax No.";
                        j += 1;
                    until ResponsibilityCenter.Next() = 0;
                end;
                //HEI.01<<

                if WhseShippingTruck.GET("Sales Shipment Header"."Vehicle Code 101FDW") then; //BC Upgrade KUMARR78<< DIT Field and Variables Removed in BC("Truck Code")

                //HEI.08>>
                PlannedDeliveryDate := 0D;
                SalesShptLine.Reset();
                SalesShptLine.SetRange("Document No.", "No.");
                SalesShptLine.SetFilter("Planned Delivery Date", '<>%1', 0D);
                if SalesShptLine.FindFirst() then
                    PlannedDeliveryDate := SalesShptLine."Planned Delivery Date";
                //HEI.08<<

            end;

            trigger OnPreDataItem();
            begin
                //HEI.14>>
                PrintingTime := CurrentDateTime;
                //HEI.14<<
                Print := Print or not CurrReport.Preview;
                //HEI.07>>
                //BC Upgrade KUMARR78>> DIT Field and Variables Removed in BC("Route Planning No.")
                if RoutePlnaningNo <> '' then
                    SETFILTER("Route Planning No. 107FDW", RoutePlnaningNo);
                //BC Upgrade KUMARR78<< DIT Field and Variables Removed in BC("Route Planning No.")
                if PostedWareHouseShipmentNo <> '' then
                    SetFilter("Posted Whse. Shipment No. FND", PostedWareHouseShipmentNo);
                //HEI.07<<
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea
                    }
                    field(InclPrices; InclPrices)
                    {
                        Caption = 'Incl. Price';
                        ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea
                    }
                    field(InclDeposit; InclDeposit)
                    {
                        Caption = 'Incl. Deposit';
                        ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea
                    }
                    field(RoutePlnaningNo; RoutePlnaningNo)
                    {
                        Caption = 'Route Planing No.';
                        Visible = RoutePlaningControlVisible;
                        ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea
                    }
                    field(PostedWareHouseShipmentNo; PostedWareHouseShipmentNo)
                    {
                        Caption = 'Posted Warehouse Shipment No.';
                        Visible = RoutePlaningControlVisible;
                        ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea

                        trigger OnLookup(var Text: Text): Boolean;
                        begin
                            //HEI.07>>
                            PostedWhseShipmentHeader.Reset();
                            PostedWhseShipmentHeader.SETRANGE("Route Planning No. 107FDW", RoutePlnaningNo);  //BC Upgrade KUMARR78>> DIT Field and Variables Removed in BC("Route Planning No.")
                            if Page.RunModal(0, PostedWhseShipmentHeader) = Action::LookupOK then
                                PostedWareHouseShipmentNo := PostedWhseShipmentHeader."No.";
                            //HEI.07<<
                        end;
                    }
                    field(ShowAdditionalColumnDN; ShowAdditionalColumnDN)
                    {
                        Caption = 'Show Additional Column on Delivery Note';
                        Editable = true;
                        ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            //HEI.07>>
            RoutePlnaningNo := "Sales Shipment Header".GETFILTER("Route Planning No. 107FDW");//BC Upgrade KUMARR78>> DIT Field and Variables Removed in BC("Route Planning No.")
            if RoutePlnaningNo <> '' then
                RoutePlaningControlVisible := true;
            //HEI.07<<
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
        label(LblMissingBTL; ENU = 'Missing (BTL)',
                            FRA = 'Bouteille Manquante')
        label(LblBreakageBTL; ENU = 'Breakage (BTL)',
                             FRA = 'Casse')
        label(LblLoadedEmptiesCust; ENU = 'Loaded Empties at Customer',
                                   FRA = 'Emballages livrés chez Client ou Distributeur')
        label(LblReceivedEmpties; ENU = 'Received Empties at Warehouse',
                                 FRA = 'Emballage Recus au Warehouse')
        label(LblExpectedEmptiestoReturn; ENU = 'Expected Empties to Return',
                                         FRA = 'Emballages Retour Attendus')
        label(LblSignatureDeliveryofProducts; ENU = 'Signature/stamp: Delivery of Products',
                                             FRA = 'Signature / cachet: Livraison des Produits')
        label(LblSignatureReturnofEmpties; ENU = 'Signature/stamp: Return of Empties',
                                          FRA = 'Signature\ cachet pour le Retour de l''emballage')
        MissingCrateLbl = 'Low Fills/Missing Crate';
    }

    trigger OnInitReport();
    begin
        //HEI.07>>
        RoutePlaningControlVisible := false;
        //HEI.07<<

        //HEI.10>>
        //BC Upgrade KUMARR78>> Blocking variable as Conflict with Standard.(Language)
        // Language.SETRANGE("Windows Language ID", CurrReport.LANGUAGE);
        // if Language.FINDFIRST() then;
        //BC Upgrade KUMARR78<< Blocking variable as Conflict with Standard.(Language)
        //BC Upgrade KUMARR78 >> Renaming variable as Conflict with Standard(RecLanguage from Language)
        RecLanguage.SETRANGE("Windows Language ID", CurrReport.LANGUAGE);
        if RecLanguage.FINDFIRST() then;
        //BC Upgrade KUMARR78 << Renaming variable as Conflict with Standard(RecLanguage from Language)

        //HEI.10<<
        //HEI.15>>
        SalesSetup.Get();
        if SalesSetup."Show Add. Column on DN FND" then
            ShowAdditionalColumnDN := SalesSetup."Show Add. Column on DN FND";
        //HEI.15<<
    end;

    var
        TempUnitOfMeasure: Record "Aging Band Buffer" temporary;
        TempUnitOfMeasure_EmptyReturn: Record "Aging Band Buffer";
        CommentLine: Record "Comment Line";
        TempCommentLine: Record "Comment Line" temporary;
        CompanyInfo: Record "Company Information";
        CountryInfo: Record "Country/Region";
        WhseShippingTruck: Record Vehicle101FDW; //BC Upgrade SHUKLP03>> DIT Field and Variables Removed in BC
        ShipToCountryName: Record "Country/Region";
        Customer: Record Customer;
        DocumentSendingProfile: Record "Document Sending Profile";
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextBuffer: Record "Extended Text Line" temporary;
        ExtendedTextLine: Record "Extended Text Line";
        TempMarketingText: Record "Extended Text Line" temporary;
        GLSetup: Record "General Ledger Setup";
        Item: Record Item;
        TempTrackingInfo: Record "Item Ledger Entry" temporary;
        TempTrackingSpecification: Record "Item Ledger Entry" temporary;
        PaymentMethod: Record "Payment Method";
        PayTerms: Record "Payment Terms";
        PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header";
        ReservationEntry: Record "Reservation Entry";
        ResponsibilityCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesCommentLine: Record "Sales Comment Line";
        Routes: Record Route107FDW; //BC Upgrade SHUKLP03>> DIT Field and Variables Removed in BC
        ReturnOrder: Record "Sales Header";
        EmptyReturnItemCharge: Record "Sales Line";
        Driver: Record Driver107FDW; //BC Upgrade SHUKLP03>> DIT Field and Variables Removed in BC
        SalesPerson: Record "Salesperson/Purchaser";
        SalesShptLine: Record "Sales Shipment Line";
        TempEmptyGoodItemLine: Record "Sales Shipment Line" temporary;
        TempOrderDepositCharge: Record "Sales Shipment Line" temporary;
        TempOrderDiscountCharge: Record "Sales Shipment Line" temporary;
        TempOrderTaxCharge: Record "Sales Shipment Line" temporary;
        TempUnderChargeLine: Record "Sales Shipment Line" temporary;
        ShipMethod: Record "Shipment Method";
        ShippingAgent: Record "Shipping Agent";
        VATAmountLine: Record "VAT Amount Line" temporary;
        FormatAddr: Codeunit "Format Address";
        ShptCountPrinted: Codeunit "Sales Shpt.-Printed";
        WarehouseShipmentList: Page "Posted Whse. Shipment List";
        blnDeliveryTime: Boolean;
        CashInvoice: Boolean;
        CTSDocumentSubtype: Boolean;
        InclDeposit: Boolean;
        InclPrices: Boolean;
        MoreLines: Boolean;
        MoreLotSerialLines: Boolean;
        Print: Boolean;
        PrintLoyaltyStatement: Boolean;
        PrintOrderDeposits: Boolean;
        PrintOrderDiscounts: Boolean;
        PrintOrderTaxes: Boolean;
        PrintPrice: Boolean;
        PrintShipmentText: Boolean;
        PrintUnderLineCharge: Boolean;

        RoutePlaningControlVisible: Boolean;
        ShowAdditionalColumnDN: Boolean;
        ShowLotSerialInfo: Boolean;
        CurrCode: Code[10];
        RoutePlnaningNo: Code[30];
        PostedWareHouseShipmentNo: Code[200];
        LotNo: Code[250];
        ActualDeliveryDate: Date;
        ExpirationDate: Date;
        PlannedDeliveryDate: Date;
        PrintingTime: DateTime;
        // SalesDepositItemCharge: Record "Sales Deposit Item Charge"; //BC Upgrade KUMARR78>> DIT Field and Variables Removed in BC
        BeginningBalance: Decimal;
        EmptyReturnUnitPrice: Decimal;
        EndBalance: Decimal;
        Gains: Decimal;
        LineAmount: Decimal;
        LotNoQty: Decimal;
        QtyHL: Decimal;
        Sales: Decimal;
        SubTotal: Decimal;
        TotalDeposits: Decimal;
        TotalDiscounts: Decimal;
        TotalNetAmount: Decimal;
        TotalOrderDiscCharges: Decimal;
        TotalQty: Decimal;
        TotalQtyHL: Decimal;
        TotalSubTotal: Decimal;
        TotalTaxes: Decimal;
        CommentLineNo: Integer;
        LineNo: Integer;
        // DocTrackingManagement: Codeunit "Document Tracking Management"; //BC Upgrade KUMARR78>> DIT Field and Variables Removed in BC
        LotNoCnt: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        ChOfComm: Label 'Chamber of commerce:';
        ContactNo: Label 'Contact Number:';
        // MasterDataProperty: Record "Master Data Property";//BC Upgrade KUMARR78>> DIT Field and Variables Removed in BC
        CTSLbl: Label 'CTS';
        EmailComp: Label 'E-mail:';
        FaxNo: Label 'Fax Number:';
        LotSerialInfoLbl: Label 'Lot/Serial Info';
        MissingCrateLbl: Label 'Low Fills/Missing Crate';
        TaxNoID: Label 'Tax Number ID:';
        Text001: Label 'COPY';
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
        Text015: Label 'Invoice No.';
        Text016: Label 'Shipment Date';
        Text017: Label 'Order No.';
        Text018: Label 'Route';
        Text019: Label 'Driver Code';
        Text020: Label 'Salesperson';
        Text021: Label 'Phone No.';
        Text023: Label '" of "';
        Text026: Label '"Expiration Date: "';
        Text030: Label 'HL';
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
        Text058: Label 'Loyalty Statement';
        Text059: Label 'Balance before';
        Text060: Label 'Increase';
        Text061: Label 'Decrease';
        Text062: Label 'Balance after';
        Text063: Label 'Sales Order No.';
        Text2014416: Label 'VAT %1%';
        CompanyText: Text;
        CrossRefText: Text;
        FreeReasonCode: Record "Reason Code"; //BC Upgrade SHUKLP03>> DIT Field and Variables Removed in BC
        FreeReasonText: Text;
        ReportTitle: Text;
        TextDeliveryTime: Text;
        TextFooter: array[3] of Text;
        VATPerText: Text;
        CUSTOMSDOCManage: Record CustomsDocMgtSetup113FDW; // BC Upgrade SHUKLP03 <<

        CopyText: Text[30];
        PostedDocumentLine: record PostedDocumentLine104FDW;
        TrackingInfoDescriptionLbl: Text[30];
        HeaderAddr: array[8] of Text[50];
        RespCenter_Code: array[20] of Text[50];
        RespCenter_FaxNo: array[20] of Text[50];
        RespCenter_PhoneNo: array[20] of Text[50];
        RespCenter_PostCode: array[20] of Text[50];
        TrackingText: Text[103];
        TrackingText1: Text[250];
        Text002: TextConst ENU = 'Delivery Note', FRA = 'BON DE LIVRAISON';
        Text014: TextConst ENU = 'Shipment No.', FRA = 'N° d''Expédition';
        Text022: TextConst ENU = 'Page', FRA = 'Page';
        Text024: TextConst ENU = 'No.', FRA = 'N°';
        Text025: TextConst ENU = 'Item / Description', FRA = 'Description Article';
        Text027: TextConst ENU = 'Lot/Serial & BBdate', FRA = 'N° Lot/Série et DLUO';
        Text028: TextConst ENU = 'Quantity Shipped', FRA = 'Quantité Expédiée';
        Text029: TextConst ENU = 'UOM', FRA = 'Code unité';
        Text031: TextConst ENU = 'Comment', FRA = 'Commentaires';
        Text032: TextConst ENU = 'Unit Price', FRA = 'Prix unitaire';
        // Language: Record Language; //BC Upgrade KUMARR78 Blocking As Conflict with Standard.(Language to RecLanguage)
        RecLanguage: Record Language; //BC Upgrade KUMARR78 Adding As Conflict with Standard.(RecLanguage from Language)

        Text50001: TextConst ENU = 'Original', FRA = 'Original', ENG = 'Original';
        Text50002: TextConst ENU = 'Copy', FRA = 'Copie', ENG = 'Copy';

    procedure InsertCommentLine(Comment: Text);
    begin
        TempCommentLine.Init();
        TempCommentLine."Line No." := CommentLineNo;
        TempCommentLine.Comment := Comment;
        TempCommentLine.Insert();
        CommentLineNo += 10000;
    end;


    local procedure GetCrossReferences() CrossRef: Text;
    var
        // ItemCrossReference: Record "Item Cross Reference"; //BC UPGRADE KUMARR78 Table Replaced in BC
        ItemCrossReference: Record "Item Reference"; //BC UPGRADE KUMARR78 Table Replaced in BC with "Item Cross Reference"

    begin

        //BC UPGRADE KUMARR78>> Blocking Whole Fnc Based on Replaced the table and Field from "Cross-Reference No." to "Reference No." and Table from ("Item Cross Reference" to "Item Reference")
        // ItemCrossReference.Reset();
        // ItemCrossReference.SetRange("Item No.", "Sales Shipment Line"."No.");
        // ItemCrossReference.SetRange("Reference Type", ItemCrossReference."Reference Type"::"Bar Code");
        // if ItemCrossReference.FindFirst() then
        //     CrossRef := Text008 + ItemCrossReference."Reference No.";

        // ItemCrossReference.Reset();
        // ItemCrossReference.SetRange("Item No.", "Sales Shipment Line"."No.");
        // ItemCrossReference.SetRange("Reference Type", ItemCrossReference."Reference Type"::Customer);
        // ItemCrossReference.SetRange("Reference Type No.", "Sales Shipment Line"."Sell-to Customer No.");
        // if ItemCrossReference.FindFirst() then begin
        //     if (CrossRef = '') then
        //         CrossRef := Text009 + ItemCrossReference."Reference No."
        //     else
        //         CrossRef += ' / ' + Text009 + ItemCrossReference."Reference No.";
        // end;
        //BC UPGRADE KUMARR78<<Blocking the table and Field from "Cross-Reference No." to "Reference No." and Table from ("Item Cross Reference" to "Item Reference")

        //BC UPGRADE KUMARR78>> Changin Whole Fnc Based on Replaced table and Field from "Cross-Reference No." to "Reference No." and Table from ("Item Cross Reference" to "Item Reference")
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
            if (CrossRef = '') then
                CrossRef := Text009 + ItemCrossReference."Reference No."
            else
                CrossRef += ' / ' + Text009 + ItemCrossReference."Reference No.";
        end;
        //BC UPGRADE KUMARR78<<Changin Whole Fnc Based on Replaced table and Field from "Cross-Reference No." to "Reference No." and Table from ("Item Cross Reference" to "Item Reference")

    end;

    local procedure IsEmptyGoodItem(): Boolean;
    begin
        if ("Sales Shipment Line".Type <> "Sales Shipment Line".Type::Item) or (("Sales Shipment Line".Type = "Sales Shipment Line".Type::Item) and ("Sales Shipment Line"."No." = '')) then
            exit;
        Item.GET("Sales Shipment Line"."No.");
        //BC UPGRADE KUMARR78>> DIT Field Removed("Empty Good")
        Item.CALCFIELDS("Is Empty Good 104FDW");
        exit(
          Item."Is Empty Good 104FDW");
        //BC UPGRADE KUMARR78>> DIT Field Removed("Empty Good")
    end;

    procedure SetRoute(pRoutePlaningNo: Code[100]);
    begin
        //HEI.07>>
        RoutePlnaningNo := pRoutePlaningNo;
        RoutePlaningControlVisible := true;
        //HEI.07<<
    end;
}

