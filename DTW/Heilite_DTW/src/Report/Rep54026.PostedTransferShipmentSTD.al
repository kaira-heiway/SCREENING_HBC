report 54026 "Posted Transfer Shipment STD"
{
    // version HEI.05

    // DITW110.00.11 AKH 02/11/2017 NRQ#43605 New Report
    // 
    // HEI.01 FDD-RW-GAPLOG02 IBM NASTAA02 10.09.2018 # Delivery Note
    //   # Copied Report 50161 - Delivery Note - Shipment Alm and created dataset and layout according to Rwanda requirements
    // HEI.02 Defect #4487 IBM GAVANM01 18.09.2019 # Posted Transfer Shipment STD
    //   #  Chamber of commerce text in the footer should be removed from Transfer Order Delivery Note
    // HEI.03 CHG2047101 Defect #5098 IBM GAVANM01 16.01.2020 # Posted Transfer Shipment STD
    //   #  some layout changes
    // HEI.04 CHG2084413 IBM GAVANM01 03.11.2020 # only the first lot number is displayed and the other lot numbers are not displayed
    //   # code and layout changes to display all lot numbers
    // HEI.05 CHG2197639 IBM MARTIR52 11.05.2023 # calculate the quantity correctly when there are shipment lines undone
    //   # code added, new local variable for ItemUoML (Item Unit of Measure)

    // BC Upgrade KUMARR78 >>
    // Report Name  : Posted Transfer Shipment STD
    // Report ID    : 50266
    //
    // 1. Added mandatory BC report properties.
    //    Old:
    //         - ApplicationArea not defined.
    //         - UsageCategory not defined.
    //    New:
    //         - ApplicationArea = All
    //         - UsageCategory = ReportsAndAnalysis
    //
    // 2. Blocked Drink-IT Master Data Property usage (Technician Name).
    //    Old:
    //         column(TechnicianName; MasterDataProperty.Name)
    //         - MasterDataProperty: Record "Master Data Property";
    //    New:
    //         column(TechnicianName; '')
    //         - MasterDataProperty variable removed/commented as obsolete in BC.
    //
    // 3. Blocked Drink-IT additional Bank fields from Company Information.
    //    Old:
    //         - CompanyInfo."Bank Name 2"
    //         - CompanyInfo."IBAN 2"
    //         - CompanyInfo."SWIFT Code 2"
    //    New:
    //         - Columns retained but passing blank values ('')
    //         - Underlying fields commented as not available in BC.
    //
    // 4. Blocked Truck & Driver related Drink-IT fields.
    //    Old:
    //         - "Truck Code"
    //         - WhseShippingTruck.Description
    //         - "Driver Code"
    //         - Driver.Description
    //         - Variables: WhseShippingTruck, Driver
    //    New:
    //         - Corresponding columns pass blank values ('').
    //         - Variables commented as obsolete in BC.
    //
    // 5. Replaced obsolete "Item Cross Reference" table.
    //    Old:
    //         ItemCrossReference: Record "Item Cross Reference";
    //    New:
    //         ItemCrossReference: Record "Item Reference";
    //         - Updated for BC table structure (not actively used).
    //
    // 6. Removed Document Tracking Management codeunit logic.
    //    Old:
    //         - DocTrackingManagement.CallPostedItemTracking1(...)
    //         - DocTrackingManagement.GetPostedTrackingText(...)
    //         - Variable: Codeunit "Document Tracking Management"
    //    New:
    //         - All calls commented.
    //         - TrackingText1 logic simplified.
    //         - TempTrackingSpecification used only for count.
    //
    // 7. Replaced NoSeriesManagement with BC standard Codeunit.
    //    Old:
    //         NoSeriesMgt: Codeunit NoSeriesManagement;
    //    New:
    //         NoSeriesMgt: Codeunit "No. Series";
    //         - Updated to BC supported codeunit.
    //
    // 8. Removed Drink Deposit & Item Charge Type logic (DIT customization).
    //    Old:
    //         - "Item Charge Type" filters (Discount / Deposit / Tax).
    //         - "Show Item charge on Invoice" filters.
    //         - SalesDepositItemCharge table usage.
    //    New:
    //         - Only Type::"Charge (Item)" used.
    //         - All DIT-specific filters commented.
    //         - Totals (Discounts/Deposits/Taxes) no longer calculated via DIT fields.
    //
    // 9. Removed Loyalty module customization (DIT).
    //    Old:
    //         - Loyalty Balance Buffer
    //         - Loyalty Ledger Entry
    //         - Loyalty Statement calculation logic
    //    New:
    //         - Entire loyalty block commented as obsolete in BC.
    //         - PrintLoyaltyStatement logic disabled.
    //
    // 10. Removed Standard Text Report footer customization (DIT).
    //     Old:
    //         - StandardTextReport table usage.
    //         - Footer text derived via Extended Text.
    //     New:
    //         - Footer generation logic commented.
    //         - TextFooter array not populated via obsolete logic.
    //
    // 11. Removed CompanyInfo."Tax Registration No." usage (DIT field).
    //     Old:
    //         CompanyInfo."Tax Registration No."
    //     New:
    //         Logic commented as field not available in BC base.
    //
    // 12. Updated Extended Text filtering with explicit dataset reference.
    //     Old:
    //         Compared with Posting Date implicitly.
    //     New:
    //         Explicit reference:
    //             "Transfer Shipment Header"."Posting Date"
    //         Ensures proper BC dataset scoping.
    //
    // 13. Ensured Request Page field compliance.
    //     Old:
    //         NoOfCopies without ApplicationArea.
    //     New:
    //         ApplicationArea = All added to NoOfCopies.
    //
    // 14. Removed obsolete Drink-IT variables.
    //     Variables commented/removed:
    //         - "Drink Deposit Group"
    //         - "Sales Deposit Item Charge"
    //         - "Whse. Shipping Driver"
    //         - "Whse. Shipping Truck"
    //         - "Master Data Property"
    //         - "Standard Text Report"
    //         - "Loyalty Balance Buffer"
    //         - "Loyalty Ledger Entry"
    //         - "Document Tracking Management"
    // BC Upgrade KUMARR78 <<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Posted Transfer Shipment STD.rdl';
    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade KUMARR78 Adding Usagecategory
    Caption = 'Transfer Order Delivery Note STD';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code";
            RequestFilterHeading = 'Transfer Shipment Header';
            column(No_SalesHeader; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(CTSDocumentSubtype; CTSDocumentSubtype)
                    {
                    }
                    // BC Upgrade KUMARR78 >> ----Drink-IT Variable Blocking for Alternative Value
                    // column(TechnicianName; MasterDataProperty.Name) 
                    // {
                    // }
                    // BC Upgrade KUMARR78 << ----Drink-IT Variable Blocking for Alternative Value

                    // BC Upgrade KUMARR78 >> ----Drink-IT fields Passing Blank Values in(MasterDataProperty.Name)
                    column(TechnicianName; '')
                    {
                    }
                    // BC Upgrade KUMARR78 << ----Drink-IT fields Passing Blank Values in(MasterDataProperty.Name)
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
                    // BC Upgrade KUMARR78 >> ----Drink-IT fields ("Bank Name 2","IBAN 2","SWIFT Code 2")
                    // column(CompanyInfo__BankName__2; CompanyInfo."Bank Name 2")
                    // {
                    // }

                    // column(CompanyInfo__IBAN__2; CompanyInfo."IBAN 2")
                    // {
                    // }
                    // column(CompanyInfo__SWIFTCode__2; CompanyInfo."SWIFT Code 2")
                    // {
                    // }
                    // BC Upgrade KUMARR78 << ----Drink-IT fields ("Bank Name 2","IBAN 2","SWIFT Code 2")
                    // BC Upgrade KUMARR78 >> ----Drink-IT fields Passing Blank Values in("Bank Name 2","IBAN 2","SWIFT Code 2")
                    column(CompanyInfo__BankName__2; '')
                    {
                    }

                    column(CompanyInfo__IBAN__2; '')
                    {
                    }
                    column(CompanyInfo__SWIFTCode__2; '')
                    {
                    }
                    // BC Upgrade KUMARR78 << ----Drink-IT fields Passing Blank Values in("Bank Name 2","IBAN 2","SWIFT Code 2")
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
                    column(PhoneNo_Customer; Customer."Phone No.")
                    {
                    }
                    column(FaxNo_Customer; Customer."Fax No.")
                    {
                    }
                    column(SellToCust_SalesHeader; "Transfer Shipment Header"."Transfer-to Code")
                    {
                    }
                    column(BillToCust_SalesHeader; "Transfer Shipment Header"."In-Transit Code")
                    {
                    }
                    column(ShippingNo_SalesHeader; "Transfer Shipment Header"."Transfer Order No.")
                    {
                    }
                    column(ShipmentDate_SalesHeader; "Transfer Shipment Header"."Shipment Date")
                    {
                    }
                    column(ShipToName_SalesHeader; "Transfer Shipment Header"."Transfer-to Name")
                    {
                    }
                    column(ShipToName2_SalesHeader; "Transfer Shipment Header"."Transfer-to Name 2")
                    {
                    }
                    column(ShipToAddress_SalesHeader; "Transfer Shipment Header"."Transfer-to Address")
                    {
                    }
                    column(ShipToAddress2_SalesHeader; "Transfer Shipment Header"."Transfer-to Address 2")
                    {
                    }
                    column(ShipToPostCode_SalesHeader; "Transfer Shipment Header"."Transfer-to Post Code")
                    {
                    }
                    column(ShipToCity_SalesHeader; "Transfer Shipment Header"."Transfer-to City")
                    {
                    }
                    column(SalesShipmentHeader_UserID; "Transfer Shipment Header"."Transfer-to Code")
                    {
                    }
                    column(SalesShipmentHeader_DocumentDate; "Transfer Shipment Header"."Posting Date")
                    {
                    }
                    column(SalesShipmentHeader_LocationCode; "Transfer Shipment Header"."Transfer-from Code")
                    {
                    }
                    // BC Upgrade KUMARR78 >> ----Drink-IT fields("Truck Code",WhseShippingTruck.Description,"Driver Code",Driver.Description)
                    // column(SalesShipmentHeader_TruckCode; "Transfer Shipment Header"."Truck Code")
                    // {
                    // }
                    // column(SalesShipmentHeader_TruckName; WhseShippingTruck.Description) 
                    // {
                    // }
                    // column(SalesShipmentHeader_DriverCode; "Transfer Shipment Header"."Driver Code")
                    // {
                    // }
                    // column(Route_SalesHeader; "Transfer Shipment Header"."Driver Code")
                    // {
                    // }
                    // column(Name_Driver; Driver.Description)
                    // {
                    // }
                    // BC Upgrade KUMARR78 << ----Drink-IT fields("Truck Code",WhseShippingTruck.Description,"Driver Code",Driver.Description)

                    // BC Upgrade KUMARR78 >> ----Drink-IT fields Passing Blank Values("Truck Code",WhseShippingTruck.Description,"Driver Code",Driver.Description)
                    column(SalesShipmentHeader_TruckCode; '')
                    {
                    }
                    column(SalesShipmentHeader_TruckName; '')
                    {
                    }
                    column(SalesShipmentHeader_DriverCode; '')
                    {
                    }
                    column(Route_SalesHeader; '')
                    {
                    }
                    column(Name_Driver; '')
                    {
                    }
                    // BC Upgrade KUMARR78 << ----Drink-IT fields Passing Blank Values in("Truck Code",WhseShippingTruck.Description,"Driver Code",Driver.Description)
                    column(SalesShipmentHeader_GateEntryNo; "Transfer Shipment Header"."From Gate Entry No. FND")
                    {
                    }
                    column(SalesShipmentHeader_ToGateEntryNo; "Transfer Shipment Header"."To Gate Entry No. FND")
                    {
                    }

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
                    column(SaleShipmentHeader_OrderNo; "Transfer Shipment Header"."Transfer Order No.")
                    {
                    }
                    column(Text063; Text063)
                    {
                    }
                    column(SaleShipmentHeader_ExternalDocNo; "Transfer Shipment Header"."External Document No.")
                    {
                    }
                    column(SaleShipmentHeader_ShippingAgentCode; ShippingAgent.Name)
                    {
                    }
                    column(SaleShipmentHeader_SalesPerson; SalesPerson.Name)
                    {
                    }
                    column(SaleShipmentHeader_GateEntryNo; "Transfer Shipment Header"."To Gate Entry No. FND")
                    {
                    }
                    dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Transfer Shipment Header";
                        DataItemTableView = sorting("Document No.", "Line No.");
                        column(SalesShipmentLine_OrderNo; "Transfer Shipment Line"."Transfer Order No.")
                        {
                        }
                        column(No_SalesLine; "Item No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Type_SalesLine; Description)
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
                        column(TotalNetAmount; TotalNetAmount)
                        {
                        }
                        dataitem("Item Ledger Entry"; "Item Ledger Entry")
                        {
                            DataItemLink = "Document No." = field("Document No."), "Document Line No." = field("Line No."), "Item No." = field("Item No.");
                            DataItemLinkReference = "Transfer Shipment Line";
                            DataItemTableView = sorting("Entry No.");
                            column(ILE_LotNo; "Item Ledger Entry"."Lot No.")
                            {
                            }
                            column(ILE_EntryNo; "Item Ledger Entry"."Entry No.")
                            {
                            }
                            column(ILE_ItemNo; "Item Ledger Entry"."Item No.")
                            {
                            }
                            column(ILE_Description; "Item Ledger Entry".Description)
                            {
                            }
                            column(ILE_Quantity; ILE_Quantity)
                            {
                            }
                            column(ILE_UOM; "Item Ledger Entry"."Unit of Measure Code")
                            {
                            }
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
                                ItemUoML: Record "Item Unit of Measure";
                            begin
                                //HEI.04<<
                                Clear(ILE_Quantity);
                                if "Location Code" <> "Transfer Shipment Header"."Transfer-from Code" then
                                    CurrReport.Skip()
                                else begin
                                    //HEI.05
                                    ItemUoML.Reset();
                                    ItemUoML.Get("Item No.", "Unit of Measure Code");
                                    ILE_Quantity := -Quantity / ItemUoML."Qty. per Unit of Measure";
                                    /*  IF "Qty. per Unit of Measure" <> 0 THEN
                                      ILE_Quantity := -Quantity/"Qty. per Unit of Measure"
                                    ELSE
                                      ILE_Quantity := -Quantity;*/ //HEI.05
                                                                   //HEI.04>>
                                                                   //HEI.01>>
                                    MoreLotSerialLines := false;
                                    ItemLedgerEntry.SetRange("Document No.", "Document No.");
                                    ItemLedgerEntry.SetRange("Document Line No.", "Document Line No.");
                                    ItemLedgerEntry.SetRange("Item No.", "Item No.");
                                    ItemLedgerEntry.SetFilter("Entry No.", '<>%1', "Entry No.");
                                    MoreLotSerialLines := ItemLedgerEntry.FindFirst();

                                    Clear(TrackingText);
                                    if "Lot No." <> '' then
                                        TrackingText := "Lot No." + ' ' + Format("Expiration Date")
                                    else if "Serial No." <> '' then
                                        TrackingText := "Serial No." + ' ' + Format("Expiration Date")
                                    //HEI.01<<
                                end

                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            ItemLedgEntry: Record "Item Ledger Entry";
                            // ItemCrossReference: Record "Item Cross Reference"; //BC UPGRADE KUMARR78 >> -Item Cross Refernce obsolete in BC
                            ItemCrossReference: Record "Item Reference"; //BC UPGRADE KUMARR78 >> -Item Cross Refernce Replaced to "Item Reference" But not in Use.

                            ReservEntry: Record "Reservation Entry";
                            OrderChargeLine: Record "Sales Shipment Line";
                            SalesChargeLine: Record "Sales Shipment Line";
                            IsTextToInclude: Boolean;
                        begin
                            /*IF NOT CashInvoice THEN BEGIN
                              IF NOT (Type IN [Type::" ",Type::Item]) THEN
                                CurrReport.SKIP;
                            END ELSE;
                              IF (Type = Type::"Charge (Item)") THEN
                                CurrReport.SKIP;*/

                            //-----Qty in HL
                            Clear(QtyHL);
                            /*IF (Type = Type::Item) AND ("No." <> '') THEN
                              QtyHL := Quantity * "Unit Volume HL";*/

                            TotalQty += "Transfer Shipment Line".Quantity;
                            TotalQtyHL += QtyHL;
                            //TotalNetAmount+= "Sales Shipment Line"."Line Amount";
                            //-----Cross Reference Info
                            Clear(CrossRefText);
                            /*IF Customer."Cross. Ref. on Del. Note" THEN BEGIN
                              IF (Type = Type::Item) AND ("No." <> '') THEN
                                CrossRefText := GetCrossReferences();
                            END;*/
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
                            Clear(FreeReasonText);
                            /*IF "Free Reason Code" <> '' THEN BEGIN
                              FreeReasonCode.GET("Free Reason Code");
                              FreeReasonText := FreeReasonCode.Description;
                            END;*/
                            //-----Price Info
                            Clear(PrintPrice);

                            //HEI.01>>
                            // ExtendedText
                            //IF Type = Type::Item THEN BEGIN
                            TempMarketingText.DeleteAll();
                            ExtendedTextHeader.Reset();

                            ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::Item);
                            ExtendedTextHeader.SetRange("No.", "Item No.");
                            ExtendedTextHeader.SetRange("Print on Delivery Note FND", true);
                            if ExtendedTextHeader.FindSet() then
                                repeat
                                    IsTextToInclude := true;
                                    if ExtendedTextHeader."Starting Date" <> 0D then
                                        IsTextToInclude := (ExtendedTextHeader."Starting Date" <= "Transfer Shipment Header"."Posting Date");//BC UPGRADE KUMARR78 >> -Adding DatasetName with Variable ("Posting Date")
                                    if IsTextToInclude and (ExtendedTextHeader."Ending Date" <> 0D) then
                                        IsTextToInclude := (ExtendedTextHeader."Ending Date" >= "Transfer Shipment Header"."Posting Date");//BC UPGRADE KUMARR78 >> -Adding DatasetName with Variable ("Posting Date")
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
                            //END;
                            //HEI.01<<
                            Clear(TrackingText1);
                            // BC Upgrade KUMARR78 >> Variable Removed from BC. 
                            // DocTrackingManagement.CallPostedItemTracking1(
                            //   Database::"Sales Shipment Line", 0, "Document No.", '', 0, "Line No.", TempTrackingSpecification);
                            // BC Upgrade KUMARR78 << Variable Removed from BC.
                            LotNoCnt := TempTrackingSpecification.Count;

                            // BC Upgrade KUMARR78 >>  Variable Removed from BC. 
                            // if LotNoCnt = 1 then
                            //     TrackingText1 := DocTrackingManagement.GetPostedTrackingText(TempTrackingSpecification) + ' ' + Format(TempTrackingSpecification."Expiration Date");
                            // BC Upgrade KUMARR78 <<  Variable Removed from BC.  
                            //Total by UOM>>
                            TempUnitOfMeasure.Reset();
                            if TempUnitOfMeasure.Get("Transfer Shipment Line"."Unit of Measure Code") then begin
                                TempUnitOfMeasure."Column 1 Amt." += "Transfer Shipment Line".Quantity;
                                TempUnitOfMeasure.Modify();
                            end else begin
                                TempUnitOfMeasure.Init();
                                TempUnitOfMeasure."Currency Code" := "Transfer Shipment Line"."Unit of Measure Code";
                                TempUnitOfMeasure."Column 1 Amt." := "Transfer Shipment Line".Quantity;
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
                                  ("Item No." = '') and (Quantity = 0)
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
                }

                trigger OnAfterGetRecord();
                begin

                    if Number > 1 then begin
                        CopyText := Text001;
                        OutputNo += 1;
                    end else
                        CopyText := '';
                    Clear(SubTotal);
                    Clear(TotalSubTotal);
                    Clear(TotalQty);
                end;

                trigger OnPostDataItem();
                begin

                    /*IF Print THEN
                      ShptCountPrinted.RUN("Transfer Shipment Header");*/

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
                // DrinkDepositGroup: Record "Drink Deposit Group"; //BC UPGRADE KUMARR78 >> -"Drink Deposit Group" DIT Variable obsolete in BC
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
                ItemLedgerEntry: Record "Item Ledger Entry";
                // LoyaltyBalanceBuffer: Record "Loyalty Balance Buffer" temporary; //BC UPGRADE KUMARR78 >> -"Loyalty Balance Buffer" DIT Variable obsolete in BC
                // LoyaltyLedgerEntry: Record "Loyalty Ledger Entry";  //BC UPGRADE KUMARR78 >> -"Loyalty Ledger Entry"  obsolete in BC
                SalesShipmentHeader: Record "Sales Shipment Header";
                OrderChargeLine: Record "Sales Shipment Line";
                SalesDepositLines: Record "Sales Shipment Line";
                ServiceSetup: Record "Service Mgt. Setup";
                ShipmentMethod: Record "Shipment Method";
                // StandardTextReport: Record "Standard Text Report"; //BC UPGRADE KUMARR78 >> -"Standard Text Report"  obsolete in BC
                // NoSeriesMgt: Codeunit NoSeriesManagement; //BC UPGRADE KUMARR78 >> -NoSeriesManagement  obsolete in BC
                NoSeriesMgt: Codeunit "No. Series"; //BC UPGRADE KUMARR78 >> -NoSeriesManagement Replaced with "No. Series" and Not in Used.
                IsTextToInclude: Boolean;
                ModifyHeader: Boolean;
                DepositGroupCode: Code[10];
                BeginBalDate: Date;
                BeginningMonth: Date;
                EndBalDate: Date;
                StartingShipmentdate: Date;
                CurrReportID: Integer;
                i: Integer;
                j: Integer;
                DeliveryTime1: Text;
                DeliveryTime2: Text;
            begin
                if ShipToCountryName.Get("Transfer Shipment Header"."Trsf.-to Country/Region Code") then;
                Clear(TotalQty);
                Clear(TotalQtyHL);
                //-----Company Info
                CompanyInfo.Get();
                //Picture
                CompanyInfo.CalcFields(Picture);
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

                //BC UPGRADE KUMARR78 >> CompanyInfo."Tax Registration No." DIT Field.
                // if CompanyInfo."Tax Registration No." <> '' then
                //     CompanyText += ', ' + TaxNoID + ' ' + CompanyInfo."Tax Registration No.";
                //BC UPGRADE KUMARR78 << CompanyInfo."Tax Registration No." DIT Field.

                //CompanyText += ', ' + ChOfComm; //HEI.02
                CompanyText += ', ' + ContactNo + ' ' + CompanyInfo."Phone No.";
                CompanyText += ', ' + FaxNo + ' ' + CompanyInfo."Fax No.";
                CompanyText += ', ' + EmailComp + ' ' + CompanyInfo."E-Mail";

                //-----Report Title
                /*CashInvoice := FALSE;//AS
                CLEAR(ReportTitle);
                CLEAR(CashInvoice);
                IF ("Payment Method Code" <> '') THEN BEGIN
                  PaymentMethod.RESET;
                  PaymentMethod.GET("Payment Method Code");
                  IF (PaymentMethod."Cash Payment") THEN BEGIN
                    ReportTitle := Text002;
                    CashInvoice := TRUE;
                  END;
                END;*/



                if (ReportTitle = '') then
                    if ("Shipment Method Code" <> '') then begin
                        ShipmentMethod.Reset();
                        ShipmentMethod.Get("Shipment Method Code");
                        // BC Upgrade KUMARR78 >> ----Drink-IT Variable >>
                        // if ShipmentMethod.Pickup then // BC Upgrade 
                        //     ReportTitle := Text003 // BC Upgrade 
                        // else 
                        // BC Upgrade KUMARR78 ----Drink-IT Variable <<
                        ReportTitle := Text004;
                    end;
                ReportTitle := Text004;
                //-----Shipment Address
                /*SalesShipmentHeader.RESET;
                IF CashInvoice THEN BEGIN
                  IF ("Bill-to Country/Region Code" = CompanyInfo."Country/Region Code") THEN BEGIN
                    SalesShipmentHeader.COPY("Sales Shipment Header");
                    SalesShipmentHeader."Bill-to Country/Region Code" := '';
                    FormatAddr.SalesShptBillTo(HeaderAddr,HeaderAddr,SalesShipmentHeader);
                  END ELSE
                    FormatAddr.SalesShptBillTo(HeaderAddr,HeaderAddr,"Sales Shipment Header");
                END ELSE BEGIN
                  IF ("Ship-to Country/Region Code" = CompanyInfo."Country/Region Code") THEN BEGIN
                    SalesShipmentHeader.COPY("Sales Shipment Header");
                    SalesShipmentHeader."Ship-to Country/Region Code" := '';
                    FormatAddr.SalesShptShipTo(HeaderAddr,SalesShipmentHeader);
                  END ELSE
                    FormatAddr.SalesShptShipTo(HeaderAddr,"Sales Shipment Header");
                END;
                //Shipment Text
                CLEAR(PrintShipmentText);
                IF CashInvoice THEN
                  PrintShipmentText := ("Bill-to Name" <> "Ship-to Name") OR
                                       ("Bill-to Name 2" <> "Ship-to Name 2") OR
                                       ("Bill-to Address" <> "Ship-to Address") OR
                                       ("Bill-to Address 2" <> "Ship-to Address 2") OR
                                       ("Bill-to Post Code" <> "Ship-to Post Code") OR
                                       ("Bill-to City" <> "Ship-to City");

                //-----Header Tel. & Fax
                Customer.RESET;
                Customer.GET("Sell-to Customer No.");
                */
                //-----Driver Info

                // BC Upgrade KUMARR78 >> ----Drink-IT Variable
                // if ("Driver Code" <> '') then begin
                //     Driver.RESET; 
                //     Driver.GET("Driver Code"); 
                // end;
                // BC Upgrade KUMARR78 << ----Drink-IT Variable

                //-----SalesPerson Info
                /*IF ("Salesperson Code" <> '') THEN BEGIN
                  SalesPerson.RESET;
                  SalesPerson.GET("Salesperson Code");
                END;*/

                //-----Shipping Agent Info
                if ("Shipping Agent Code" <> '') then begin
                    ShippingAgent.Reset();
                    ShippingAgent.Get("Shipping Agent Code");
                end;

                //-----Delivery Times
                /*CLEAR(TextDeliveryTime);
                CLEAR(blnDeliveryTime);
                IF "Delivery Time 1 From" <> 0T THEN BEGIN
                  IF "Delivery Time 1 To" <> 0T THEN
                    DeliveryTime1 := FORMAT("Delivery Time 1 From",5) + '-' + FORMAT("Delivery Time 1 To",5)
                  ELSE
                    DeliveryTime1 := FORMAT("Delivery Time 1 From",5);
                  IF DeliveryTime1 <> '' THEN
                    IF ShipmentMethod.Pickup THEN
                      TextDeliveryTime := Text005 + '  ' +  DeliveryTime1
                    ELSE
                      TextDeliveryTime := Text006 + '  ' +  DeliveryTime1;
                END;
                IF "Delivery Time 2 From" <> 0T THEN BEGIN
                  IF "Delivery Time 2 To" <> 0T THEN
                    DeliveryTime2 := FORMAT("Delivery Time 2 From",5) + '-' + FORMAT("Delivery Time 2 To",5)
                  ELSE
                    DeliveryTime2 := FORMAT("Delivery Time 2 From",5);
                  IF DeliveryTime2  <> '' THEN
                    TextDeliveryTime := TextDeliveryTime + ' '+ Text007 +' ' + DeliveryTime2;
                END;
                blnDeliveryTime := (TextDeliveryTime <> '') AND NOT(ShipmentMethod.Pickup);
                */
                //-----Comment Lines
                /*TempCommentLine.RESET;
                TempCommentLine.DELETEALL;
                CommentLineNo := 10000;
                //Customer Comments
                CommentLine.RESET;
                CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::Customer);
                CommentLine.SETRANGE("No.","Sell-to Customer No.");
                CommentLine.SETRANGE("Print on Shipment",TRUE);
                IF CommentLine.FINDSET THEN
                  REPEAT
                    InsertCommentLine(CommentLine.Comment);
                  UNTIL CommentLine.NEXT = 0;
                //Sales Comments
                SalesCommentLine.RESET;
                SalesCommentLine.SETRANGE("Document Type",SalesCommentLine."Document Type"::Shipment);
                SalesCommentLine.SETRANGE("No.","No.");
                SalesCommentLine.SETRANGE("Print on Shipment",TRUE);
                IF SalesCommentLine.FINDSET THEN
                  REPEAT
                    InsertCommentLine(SalesCommentLine.Comment);
                  UNTIL SalesCommentLine.NEXT = 0;
                */
                //-----Footer Texts

                // BC Upgrade KUMARR78 >> ----Drink-IT Variable
                // Clear(CurrReportID);
                // Clear(i);
                // Clear(TextFooter);
                // Evaluate(CurrReportID, CopyStr(CurrReport.ObjectId(false), 8));
                // StandardTextReport.SETRANGE("Report ID", CurrReportID);
                // StandardTextReport.SETRANGE("Position Text", StandardTextReport."Position Text"::Footer);

                // if StandardTextReport.FINDSET then
                //     repeat
                //         i := 1;
                //         ExtendedTextHeader.Reset();
                //         ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                //         ExtendedTextHeader.SETRANGE("No.", StandardTextReport."Standard Text Code");
                //         if ExtendedTextHeader.FindSet() then begin
                //             repeat
                //                 ExtendedTextLine.Reset();
                //                 ExtendedTextLine.SetRange("Table Name", ExtendedTextHeader."Table Name");
                //                 ExtendedTextLine.SetRange("No.", ExtendedTextHeader."No.");
                //                 ExtendedTextLine.SetRange("Text No.", ExtendedTextHeader."Text No.");
                //                 if ExtendedTextLine.FindSet() then begin
                //                     repeat
                //                         TextFooter[i] += ' ' + (ExtendedTextLine.Text);
                //                     until (ExtendedTextLine.Next() = 0) or (i > ArrayLen(TextFooter));
                //                 end;
                //                 i += 1;
                //             until (ExtendedTextHeader.Next() = 0);
                //         end;
                //     until (StandardTextReport.NEXT = 0);
                // BC Upgrade KUMARR78 << ----Drink-IT Variable

                //-----Loyalty Statement
                // BC Upgrade KUMARR78 >> ----Drink-IT Variable (Loyalty)
                // Clear(BeginningBalance);
                // Clear(EndBalance);
                // Clear(Gains);
                // Clear(Sales);
                // Clear(PrintLoyaltyStatement);
                // if CashInvoice then
                //     if (Customer."Loyalty Statement On" in [Customer."Loyalty Statement On"::"Delivery Note",
                //                                            Customer."Loyalty Statement On"::"Invoice + Delivery Note"])
                //     then begin
                //         PrintLoyaltyStatement := true;
                //         LoyaltyBalanceBuffer.INIT;
                //         LoyaltyBalanceBuffer.SETFILTER("Source Type Filter", '%1', LoyaltyBalanceBuffer."Source Type Filter"::Customer);
                //         LoyaltyBalanceBuffer.SETFILTER("Source No. Filter", Customer."No.");

                //         BeginBalDate := CalcDate('<CM-1M>', "Posting Date");
                //         LoyaltyBalanceBuffer.SETFILTER("Date Filter", '..%1', BeginBalDate);
                //         LoyaltyBalanceBuffer.CALCFIELDS("Net Point Change (Actual)");
                //         BeginningBalance := LoyaltyBalanceBuffer."Net Point Change (Actual)";

                //         EndBalDate := CalcDate('<CM>', "Posting Date");
                //         LoyaltyBalanceBuffer.SETFILTER("Date Filter", '..%1', EndBalDate);
                //         LoyaltyBalanceBuffer.CALCFIELDS("Net Point Change (Actual)");
                //         EndBalance := LoyaltyBalanceBuffer."Net Point Change (Actual)";

                //         BeginningMonth := CalcDate('<1D>', BeginBalDate);

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
                // BC Upgrade KUMARR78 <<----Drink-IT Variable
                //SalesShptLine.CalcVATAmountLines("Sales Shipment Header",VATAmountLine);

                Clear(TotalDeposits);
                Clear(TotalDiscounts);
                Clear(TotalTaxes);

                //-----Order total /blank Discount Charges
                if CashInvoice then begin
                    OrderChargeLine.Reset();
                    OrderChargeLine.SetRange("Document No.", "No.");
                    OrderChargeLine.SetRange(Type, OrderChargeLine.Type::"Charge (Item)");
                    // OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Discount); // BC Upgrade KUMARR78 >> ----Drink-IT Variable
                    // OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" "); // BC Upgrade KUMARR78 >> ----Drink-IT Variable
                    if OrderChargeLine.FindSet() then begin
                        PrintOrderDiscounts := true;
                        repeat
                            TempOrderDiscountCharge.Init();
                            TempOrderDiscountCharge := OrderChargeLine;
                            TempOrderDiscountCharge.Insert();
                        until (OrderChargeLine.Next() = 0);
                        // OrderChargeLine.CALCSUMS("Line Amount"); // BC Upgrade KUMARR78 >> ----Drink-IT Variable
                        // TotalDiscounts += OrderChargeLine."Line Amount"; // BC Upgrade KUMARR78 >> ----Drink-IT Variable
                    end;
                    //-----Order total /blank Deposit Charges
                    OrderChargeLine.Reset();
                    OrderChargeLine.SetRange("Document No.", "No.");
                    OrderChargeLine.SetRange(Type, OrderChargeLine.Type::"Charge (Item)");
                    // OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Deposit); // BC Upgrade KUMARR78 >> ----Drink-IT Variable
                    // OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" "); // BC Upgrade KUMARR78 >> ----Drink-IT Variable
                    if OrderChargeLine.FindSet() then begin
                        PrintOrderDeposits := true;
                        repeat
                            TempOrderDepositCharge.Init();
                            TempOrderDepositCharge := OrderChargeLine;
                            TempOrderDepositCharge.Insert();
                        until (OrderChargeLine.Next() = 0);
                        // OrderChargeLine.CALCSUMS("Line Amount");
                        // TotalDeposits += OrderChargeLine."Line Amount"; // BC Upgrade KUMARR78 >> ----Drink-IT Variable
                    end;
                    //-----Order total /blank Tax Charges
                    OrderChargeLine.Reset();
                    OrderChargeLine.SetRange("Document No.", "No.");
                    OrderChargeLine.SetRange(Type, OrderChargeLine.Type::"Charge (Item)");
                    // OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Tax); // BC Upgrade KUMARR78 >> ----Drink-IT Variable
                    // OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" "); // BC Upgrade KUMARR78 >> ----Drink-IT Variable
                    if OrderChargeLine.FindSet() then begin
                        repeat

                            //    if (OrderChargeLine."Line Amount" <> 0) then begin // BC Upgrade KUMARR78 >> ----Drink-IT Variable 
                            PrintOrderTaxes := true;
                            TempOrderTaxCharge.Init();
                            TempOrderTaxCharge := OrderChargeLine;
                            TempOrderTaxCharge.Insert();
                        // end// BC Upgrade KUMARR78 >> ----Drink-IT Variable 
                        until (OrderChargeLine.Next() = 0);
                        // OrderChargeLine.CALCSUMS("Line Amount"); // BC Upgrade KUMARR78 >> ----Drink-IT Variable
                        // TotalTaxes += OrderChargeLine."Line Amount"; // BC Upgrade KUMARR78 >> ----Drink-IT Variable
                    end;
                end;

                //HEI.01>>
                // Tracking Info
                ShowLotSerialInfo := false;
                // ShowLotSerialInfo := Customer."Exp. Date on Del. Note";  // BC Upgrade KUMARR78 >> ----Drink-IT Variable

                if ShowLotSerialInfo then
                    TrackingInfoDescriptionLbl := LotSerialInfoLbl
                else
                    TrackingInfoDescriptionLbl := Text027;

                // CTS Document
                /*ServiceSetup.GET;
                Customer2.GET("Sell-to Customer No.");
                CTSDocumentSubtype := "Document Subtype Code" = ServiceSetup."CTS Document Subtype";
                IF CTSDocumentSubtype THEN
                  ReportTitle := CTSLbl + ' ' + ReportTitle;

                MasterDataProperty.SETRANGE("Table ID",18);
                MasterDataProperty.SETRANGE(Code,Customer2."No.");
                MasterDataProperty.SETRANGE("Property Code",ServiceSetup."CTS Technician Property Code");
                IF MasterDataProperty.FINDFIRST THEN
                  MasterDataProperty.CALCFIELDS(Name);
                */
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

                // if WhseShippingTruck.GET("Transfer Shipment Header"."Truck Code") then; // BC Upgrade KUMARR78 >> ----Drink-IT Variable 

            end;

            trigger OnPreDataItem();
            begin

                Print := Print or not CurrReport.Preview;
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
                        Caption = 'No. of Copies';
                        ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea  
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
        UserIDLbl = 'User ID'; DateLbl = 'Date'; label(LocationCodeLbl; ENU = 'Transfer-from Code',
                                                                     FRA = 'Code du magasin')
        label(TruckCodeLbl; ENU = 'Truck Code & Description',
                           FRA = 'Code et description du camion')
        FromGateEntryLbl = 'From Gate Entry No.'; ToGateEntryLbl = 'To Gate Entry No.'; label(PrintDate; ENU = 'Print Date',
                                                                                                      FRA = 'Date d''Impression')
        label(SalesOrderNoLbl; ENU = 'Transfer Order No.',
                              FRA = 'N° Commande Vente')
        QuantityReceivedLbl = 'Quantity Received'; TechnicianNameLbl = 'Technician Name'; label(DriverSignatureLbl; ENU = 'Driver Signature',
                                                                                                                 FRA = 'Signature livreur')
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
        label(ShipToCustomerLbl; ENU = 'Transfer-to Code',
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
        label(ToGateEntryNoLbl; ENU = 'To Gate Entry No.',
                               FRA = 'N° contrôle de porte ')
        label(UomLbl; ENU = 'Unit Of Measure',
                     FRA = 'Code unité ')
        TotalLbl = 'Total Qty'; label(EmptyLbl; ENU = 'Empties to return',
                                              FRA = 'Consigne or bouteilles  à retourner')
        TransferToNameLbl = 'Name'; InTransitCodeLbl = 'In-Transit Code';
    }

    var
        TempUnitOfMeasure: Record "Aging Band Buffer" temporary;
        CommentLine: Record "Comment Line";
        TempCommentLine: Record "Comment Line" temporary;
        CompanyInfo: Record "Company Information";
        CountryInfo: Record "Country/Region";
        ShipToCountryName: Record "Country/Region";
        Customer: Record Customer;
        DocumentSendingProfile: Record "Document Sending Profile";
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextBuffer: Record "Extended Text Line" temporary;
        ExtendedTextLine: Record "Extended Text Line";
        TempMarketingText: Record "Extended Text Line" temporary;
        // FreeReasonCode: Record "Free Reason Code"; // BC Upgrade KUMARR78 >> ----Drink-IT Variable 
        GLSetup: Record "General Ledger Setup";
        Item: Record Item;
        TempTrackingInfo: Record "Item Ledger Entry" temporary;
        TempTrackingSpecification: Record "Item Ledger Entry" temporary;
        // MasterDataProperty: Record "Master Data Property"; // BC Upgrade KUMARR78 >> ----Drink-IT Variable 
        PaymentMethod: Record "Payment Method";
        ResponsibilityCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesCommentLine: Record "Sales Comment Line";
        // SalesDepositItemCharge: Record "Sales Deposit Item Charge"; // BC Upgrade KUMARR78 >> ----Drink-IT Variable 
        SalesPerson: Record "Salesperson/Purchaser";
        SalesShptLine: Record "Sales Shipment Line";
        TempEmptyGoodItemLine: Record "Sales Shipment Line" temporary;
        TempOrderDepositCharge: Record "Sales Shipment Line" temporary;
        TempOrderDiscountCharge: Record "Sales Shipment Line" temporary;
        TempOrderTaxCharge: Record "Sales Shipment Line" temporary;
        TempUnderChargeLine: Record "Sales Shipment Line" temporary;
        ShippingAgent: Record "Shipping Agent";
        VATAmountLine: Record "VAT Amount Line" temporary;
        // Driver: Record "Whse. Shipping Driver"; // BC Upgrade KUMARR78 >> ----Drink-IT Variable
        // WhseShippingTruck: Record "Whse. Shipping Truck"; // BC Upgrade KUMARR78 >> ----Drink-IT Variable
        // DocTrackingManagement: Codeunit "Document Tracking Management"; // BC Upgrade KUMARR78 >> ----Drink-IT Variable
        FormatAddr: Codeunit "Format Address";
        ShptCountPrinted: Codeunit "Sales Shpt.-Printed";
        blnDeliveryTime: Boolean;
        CashInvoice: Boolean;
        CTSDocumentSubtype: Boolean;
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
        ShowLotSerialInfo: Boolean;
        CurrCode: Code[10];
        ExpirationDate: Date;
        BeginningBalance: Decimal;
        EndBalance: Decimal;
        Gains: Decimal;
        ILE_Quantity: Decimal;
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
        LotNoCnt: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        ChOfComm: Label 'Chamber of commerce:';
        ContactNo: Label 'Contact Number:';
        CTSLbl: Label 'CTS';
        EmailComp: Label 'E-mail:';
        FaxNo: Label 'Fax Number:';
        LotSerialInfoLbl: Label 'Lot/Serial Info';
        TaxNoID: Label 'Tax Number ID:';
        Text001: Label 'COPY';
        Text002: Label 'Transfer Order Delivery Note';
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
        FreeReasonText: Text;
        ReportTitle: Text;
        TextDeliveryTime: Text;
        TextFooter: array[3] of Text;
        VATPerText: Text;
        CopyText: Text[30];
        TrackingInfoDescriptionLbl: Text[30];
        HeaderAddr: array[8] of Text[50];
        RespCenter_Code: array[20] of Text[50];
        RespCenter_FaxNo: array[20] of Text[50];
        RespCenter_PhoneNo: array[20] of Text[50];
        RespCenter_PostCode: array[20] of Text[50];
        TrackingText: Text[50];
        TrackingText1: Text[250];
        Text014: TextConst ENU = 'Shipment No.', FRA = 'N° d''Expédition';
        Text022: TextConst ENU = 'Page', FRA = 'Page';
        Text024: TextConst ENU = 'No.', FRA = 'N°';
        Text025: TextConst ENU = 'Item / Description', FRA = 'Description Article';
        Text027: TextConst ENU = 'Lot/Serial & BBdate', FRA = 'Lot/Serial & BB date';
        Text028: TextConst ENU = 'Quantity', FRA = 'Quantité';
        Text029: TextConst ENU = 'UOM', FRA = 'Code unité';
        Text031: TextConst ENU = 'Comment', FRA = 'Commentaires';
        Text032: TextConst ENU = 'Unit Price', FRA = 'Prix unitaire';

    procedure InsertCommentLine(Comment: Text);
    begin
        TempCommentLine.Init();
        TempCommentLine."Line No." := CommentLineNo;
        TempCommentLine.Comment := Comment;
        TempCommentLine.Insert();
        CommentLineNo += 10000;
    end;
}

