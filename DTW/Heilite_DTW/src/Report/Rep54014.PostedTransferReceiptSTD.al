report 54014 "Posted Transfer Receipt STD"
{
    // version HEI.01

    // DITW110.00.11 AKH 02/11/2017 NRQ#43605 New Report
    // 
    // HEI.01 FDD-RW-GAPLOG02 IBM NASTAA02 10.09.2018 # Delivery Note
    //   # Copied Report 50161 - Delivery Note - Shipment Alm and created dataset and layout according to Rwanda requirements
    // HEI.02 FDD-HT742 IBM BULIMC01 07.08.2019 #new report from Ethiopia created from a copy of 50266 - Posted Transfer Shipment STD report.
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID is 50297.
    // 2. Add ApplicationArea and UsageCategory in Report and requestpage fields.
    // 3. Remove Drink-IT fields and related code("Loyalty Statement On","Item Charge Type","Show Item charge on Invoice","Tax Registration No.",ShipmentMethod.Pickup,"Driver Code","Loyalty Statement On")
    // 4. Remove Drink-IT Records and related code.
    // 5. Add layout path and change layout extension RDLC to RDL.
    // 6. Remove Drink-IT Fields column from dataset and layout.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Posted Transfer Receipt STD.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    Caption = 'Posted Transfer Receipt STD';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code";
            RequestFilterHeading = 'Transfer Receipt Header';
            column(No_SalesHeader; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CTSDocumentSubtype; CTSDocumentSubtype)
                    {
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT table(MasterDataProperty) It has been removed from the layout as well.
                    // column(TechnicianName; MasterDataProperty.Name)
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT table(MasterDataProperty) It has been removed from the layout as well.

                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ReportTitle; STRSUBSTNO(Text002, CopyText))
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
                    // BC Upgrade BHARDA11 >> ---Drink-IT Fields("Bank Name 2","IBAN 2","SWIFT Code 2")It has been removed from the layout as well.
                    // column(CompanyInfo__BankName__2; CompanyInfo."Bank Name 2")
                    // {
                    // }
                    // column(CompanyInfo__IBAN__2; CompanyInfo."IBAN 2")
                    // {
                    // }
                    // column(CompanyInfo__SWIFTCode__2; CompanyInfo."SWIFT Code 2")
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields("Bank Name 2","IBAN 2","SWIFT Code 2") and It has been removed from the layout as well.
                    column(CompanyInfo__BankName; CompanyInfo."Bank Name")
                    {
                    }

                    column(CompanyFooter1; TextFooter[1])
                    {
                    }
                    column(CompanyFooter2; TextFooter[2])
                    {
                    }
                    column(Comments; Var_Comments)
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
                    column(SellToCust_SalesHeader; "Transfer Receipt Header"."Transfer-to Code")
                    {
                    }
                    column(BillToCust_SalesHeader; "Transfer Receipt Header"."In-Transit Code")
                    {
                    }
                    column(ShippingNo_SalesHeader; "Transfer Receipt Header"."Transfer Order No.")
                    {
                    }
                    column(ShipmentDate_SalesHeader; "Transfer Receipt Header"."Shipment Date")
                    {
                    }
                    column(ShipToName_SalesHeader; "Transfer Receipt Header"."Transfer-to Name")
                    {
                    }
                    column(ShipToName2_SalesHeader; "Transfer Receipt Header"."Transfer-to Name 2")
                    {
                    }
                    column(ShipToAddress_SalesHeader; "Transfer Receipt Header"."Transfer-to Address")
                    {
                    }
                    column(ShipToAddress2_SalesHeader; "Transfer Receipt Header"."Transfer-to Address 2")
                    {
                    }
                    column(ShipToPostCode_SalesHeader; "Transfer Receipt Header"."Transfer-to Post Code")
                    {
                    }
                    column(ShipToCity_SalesHeader; "Transfer Receipt Header"."Transfer-to City")
                    {
                    }
                    column(SalesShipmentHeader_UserID; "Transfer Receipt Header"."Transfer-to Code")
                    {
                    }
                    column(SalesShipmentHeader_DocumentDate; "Transfer Receipt Header"."Posting Date")
                    {
                    }
                    column(SalesShipmentHeader_LocationCode; "Transfer Receipt Header"."Transfer-from Code")
                    {
                    }
                    // BC Upgrade BHARDA11 >> ---Drink-IT Fields("Truck Code",WhseShippingTruck.Description,"Driver Code",Route,Driver.Description)It has been removed from the layout as well.
                    // column(SalesShipmentHeader_TruckCode; "Transfer Receipt Header"."Truck Code")
                    // {
                    // }
                    // column(SalesShipmentHeader_TruckName; WhseShippingTruck.Description)
                    // {
                    // }
                    // column(SalesShipmentHeader_DriverCode; "Transfer Receipt Header"."Driver Code")
                    // {
                    // }
                    // column(Route_SalesHeader; "Transfer Receipt Header".Route)
                    // {
                    // }
                    // column(Name_Driver; Driver.Description)
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ---Drink-IT Fields("Truck Code",WhseShippingTruck.Description,"Driver Code",Route,Driver.Description)It has been removed from the layout as well.
                    column(SalesShipmentHeader_GateEntryNo; "Transfer Receipt Header"."From Gate Entry No. FND")
                    {
                    }
                    column(SalesShipmentHeader_ToGateEntryNo; "Transfer Receipt Header"."To Gate Entry No. FND")
                    {
                    }

                    column(ShippingAgentServiceCode_TransReceiptHeader; "Transfer Receipt Header"."Shipping Agent Service Code")
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
                    column(SaleShipmentHeader_OrderNo; "Transfer Receipt Header"."Transfer Order No.")
                    {
                    }
                    column(Text063; Text063)
                    {
                    }
                    column(SaleShipmentHeader_ExternalDocNo; "Transfer Receipt Header"."External Document No.")
                    {
                    }
                    column(SaleShipmentHeader_ShippingAgentCode; ShippingAgent.Name)
                    {
                        IncludeCaption = true;
                    }
                    column(SaleShipmentHeader_SalesPerson; SalesPerson.Name)
                    {
                    }
                    column(SaleShipmentHeader_GateEntryNo; "Transfer Receipt Header"."To Gate Entry No. FND")
                    {
                    }
                    dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Transfer Receipt Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(SalesShipmentLine_OrderNo; "Transfer Receipt Line"."Transfer Order No.")
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
                        dataitem(Temp_ItemLedgerEntry; Integer)
                        {
                            column(LotNo_Temp; TempItemLedgerEntry."Lot No.")
                            {
                            }
                            column(Quantity_Temp; TempItemLedgerEntry.Quantity)
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
                            ReservEntry: Record "Reservation Entry";
                            ItemLedgEntry: Record "Item Ledger Entry";
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
                            CLEAR(QtyHL);
                            /*IF (Type = Type::Item) AND ("No." <> '') THEN
                              QtyHL := Quantity * "Unit Volume HL";*/

                            //TotalNetAmount+= "Sales Shipment Line"."Line Amount";
                            //-----Cross Reference Info
                            CLEAR(CrossRefText);
                            /*IF Customer."Cross. Ref. on Del. Note" THEN BEGIN
                              IF (Type = Type::Item) AND ("No." <> '') THEN
                                CrossRefText := GetCrossReferences();
                            END;*/
                            //-----Expiration Info
                            CLEAR(ExpirationDate);
                            //IF Customer."Exp. Date on Del. Note" THEN BEGIN
                            /* ReservEntry.RESET;
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
                            /*IF "Free Reason Code" <> '' THEN BEGIN
                              FreeReasonCode.GET("Free Reason Code");
                              FreeReasonText := FreeReasonCode.Description;
                            END; */
                            //-----Price Info
                            CLEAR(PrintPrice);

                            //HEI.01>>
                            // ExtendedText
                            //IF Type = Type::Item THEN BEGIN
                            /* TempMarketingText.DELETEALL;
                             ExtendedTextHeader.RESET;

                             ExtendedTextHeader.SETRANGE("Table Name",ExtendedTextHeader."Table Name"::Item);
                             ExtendedTextHeader.SETRANGE("No.","Item No.");
                             ExtendedTextHeader.SETRANGE("Print on Delivery Note",TRUE);
                             IF ExtendedTextHeader.FINDSET THEN
                               REPEAT
                                 IsTextToInclude := TRUE ;
                                 IF ExtendedTextHeader."Starting Date" <> 0D THEN
                                   IsTextToInclude := (ExtendedTextHeader."Starting Date" <= "Posting Date");
                                 IF IsTextToInclude AND (ExtendedTextHeader."Ending Date" <> 0D) THEN
                                  IsTextToInclude := (ExtendedTextHeader."Ending Date" >= "Posting Date");
                                 IF IsTextToInclude THEN BEGIN
                                   ExtendedTextLine.RESET;
                                   ExtendedTextLine.SETRANGE("Table Name",ExtendedTextHeader."Table Name");
                                   ExtendedTextLine.SETRANGE("No.",ExtendedTextHeader."No.");
                                   ExtendedTextLine.SETRANGE("Text No.",ExtendedTextHeader."Text No.");
                                   IF ExtendedTextLine.FINDFIRST THEN
                                     REPEAT
                                       TempMarketingText.INIT;
                                       TempMarketingText := ExtendedTextLine;
                                       TempMarketingText.INSERT;
                                     UNTIL (ExtendedTextLine.NEXT = 0);
                                 END;
                               UNTIL ExtendedTextHeader.NEXT = 0;
                           //END;
                           //HEI.01<<
                           CLEAR(TrackingText1);
                           DocTrackingManagement.CallPostedItemTracking1(
                             DATABASE::"Sales Shipment Line",0,"Document No.",'',0,"Line No.",TempTrackingSpecification);

                           LotNoCnt:=TempTrackingSpecification.COUNT;

                           IF LotNoCnt =1 THEN
                             TrackingText1 := DocTrackingManagement.GetPostedTrackingText(TempTrackingSpecification)+' '+ FORMAT(TempTrackingSpecification."Expiration Date");
                           */
                            //Total by UOM<<

                            ItemLedgerEntry.RESET;
                            ItemLedgerEntry.SETRANGE("Document No.", "Transfer Receipt Line"."Document No.");
                            ItemLedgerEntry.SETRANGE("Document Line No.", "Transfer Receipt Line"."Line No.");
                            ItemLedgerEntry.SETRANGE("Item No.", "Transfer Receipt Line"."Item No.");
                            ItemLedgerEntry.SETRANGE("Location Code", "Transfer Receipt Line"."Transfer-to Code");
                            IF ItemLedgerEntry.FINDSET THEN
                                REPEAT
                                    TempItemLedgerEntry.INIT;
                                    TempItemLedgerEntry."Entry No." := ItemLedgerEntry."Entry No.";
                                    IF ItemLedgerEntry."Lot No." <> '' THEN
                                        TempItemLedgerEntry."Lot No." := ItemLedgerEntry."Lot No."
                                    ELSE IF ItemLedgerEntry."Serial No." <> '' THEN
                                        TempItemLedgerEntry."Lot No." := ItemLedgerEntry."Serial No.";
                                    TempItemLedgerEntry.Quantity := ItemLedgerEntry.Quantity;
                                    TotalQty += TempItemLedgerEntry.Quantity;
                                    UoM;
                                    TempItemLedgerEntry.INSERT;
                                UNTIL ItemLedgerEntry.NEXT = 0;

                            //Total by UOM>>

                        end;

                        trigger OnPostDataItem();
                        begin
                            TempItemLedgerEntry.DELETEALL;
                        end;

                        trigger OnPreDataItem();
                        var
                            ReservEntry: Record "Reservation Entry";
                        begin
                            VATAmountLine.DELETEALL;
                            MoreLines := FINDLAST;

                            WHILE MoreLines AND (Description = '') AND ("Description 2" = '') AND
                                  ("Item No." = '') AND (Quantity = 0)
                            DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");

                            TempEmptyGoodItemLine.RESET;
                            IF TempEmptyGoodItemLine.FINDLAST THEN
                                LineNo := TempEmptyGoodItemLine."Line No.";
                            TotalSubTotal := TotalDeposits + TotalDiscounts + TotalTaxes;
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

                        trigger OnPreDataItem();
                        begin
                            TempUnitOfMeasure.RESET;
                            SETRANGE(Number, 1, TempUnitOfMeasure.COUNT);
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin

                    IF Number > 1 THEN BEGIN
                        CopyText := Text001;
                        OutputNo += 1;
                    END ELSE IF "Transfer Receipt Header"."No. Printed FND" > 0 THEN
                            CopyText := Text001
                    ELSE
                        CopyText := '';
                    CLEAR(SubTotal);
                    CLEAR(TotalSubTotal);
                    CLEAR(TotalQty);
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
                // StandardTextReport: Record 2014410; // BC Upgrade BHARDA11 ----Drink-IT Table(2014410)
                ExtendedTextHeader: Record "Extended Text Header";
                ExtendedTextLine: Record "Extended Text Line";
                CurrReportID: Integer;
                i: Integer;
                IsTextToInclude: Boolean;
                ItemLedgerEntry: Record "Item Ledger Entry";

                ModifyHeader: Boolean;
                SalesDepositLines: Record "Sales Shipment Line";
                DepositGroupCode: Code[10];
                // DrinkDepositGroup: Record 2013612; // BC Upgrade BHARDA11 ----Drink-IT Table(2013612)
                StartingShipmentdate: Date;
                // LoyaltyBalanceBuffer: Record 2014513 temporary; // BC Upgrade BHARDA11 ----Drink-IT Table(2014513)
                BeginBalDate: Date;
                EndBalDate: Date;
                BeginningMonth: Date;
                // LoyaltyLedgerEntry: Record 2014514; // BC Upgrade BHARDA11 ----Drink-IT Table(2014514)
                OrderChargeLine: Record "Sales Shipment Line";
                ServiceSetup: Record "Service Mgt. Setup";
                Customer2: Record Customer;
                j: Integer;
            begin
                IF ShipToCountryName.GET("Transfer Receipt Header"."Trsf.-to Country/Region Code") THEN;
                CLEAR(TotalQty);
                CLEAR(TotalQtyHL);
                //-----Company Info
                CompanyInfo.GET;
                //Picture
                CompanyInfo.CALCFIELDS(Picture);
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

                //Comment line
                // BC Upgrade BHARDA11 >> ----Drink-IT table(StandardTextReport)
                // StandardTextReport.RESET;
                // StandardTextReport.SETRANGE("Report ID", 50297);
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
                // BC Upgrade BHARDA11 << ----Drink-IT table(StandardTextReport)

                IF (ReportTitle = '') THEN
                    IF ("Shipment Method Code" <> '') THEN BEGIN
                        ShipmentMethod.RESET;
                        ShipmentMethod.GET("Shipment Method Code");
                        // BC Upgrade BHARAD11 >> ----Drink-IT Field(ShipmentMethod.Pickup)
                        // IF ShipmentMethod.Pickup THEN
                        //     ReportTitle := Text003
                        // ELSE
                        //     ReportTitle := Text004;
                        // BC Upgrade BHARAD11 << ----Drink-IT Field(ShipmentMethod.Pickup)
                    END;
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
                // BC Upgrade BHARDA11 >> ----Drink-IT Field and Table("Driver Code",Driver)
                // IF ("Driver Code" <> '') THEN BEGIN
                //     Driver.RESET;
                //     Driver.GET("Driver Code");
                // END;
                // BC Upgrade BHARDA11 << ----Drink-IT Field and Table("Driver Code",Driver)


                //-----SalesPerson Info
                /*IF ("Salesperson Code" <> '') THEN BEGIN
                  SalesPerson.RESET;
                  SalesPerson.GET("Salesperson Code");
                END;*/

                //-----Shipping Agent Info
                IF ("Shipping Agent Code" <> '') THEN BEGIN
                    ShippingAgent.RESET;
                    ShippingAgent.GET("Shipping Agent Code");
                END;

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


                //-----Loyalty Statement
                CLEAR(BeginningBalance);
                CLEAR(EndBalance);
                CLEAR(Gains);
                CLEAR(Sales);
                CLEAR(PrintLoyaltyStatement);
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields and Tables("Loyalty Statement On",LoyaltyBalanceBuffer)
                // IF CashInvoice THEN
                //     IF (Customer."Loyalty Statement On" IN [Customer."Loyalty Statement On"::"Delivery Note",
                //                                            Customer."Loyalty Statement On"::"Invoice + Delivery Note"])
                //     THEN BEGIN
                //         PrintLoyaltyStatement := TRUE;
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
                //     END;
                // BC Upgrade BHARDA11 << ----Drink-IT Fields and Tables("Loyalty Statement On",LoyaltyBalanceBuffer)
                //SalesShptLine.CalcVATAmountLines("Sales Shipment Header",VATAmountLine);

                CLEAR(TotalDeposits);
                CLEAR(TotalDiscounts);
                CLEAR(TotalTaxes);

                //-----Order total /blank Discount Charges
                IF CashInvoice THEN BEGIN
                    OrderChargeLine.RESET;
                    OrderChargeLine.SETRANGE("Document No.", "No.");
                    OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Item Charge Type","Show Item charge on Invoice")
                    // OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Discount);
                    // OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" ");
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields("Item Charge Type","Show Item charge on Invoice")
                    IF OrderChargeLine.FINDSET THEN BEGIN
                        PrintOrderDiscounts := TRUE;
                        REPEAT
                            TempOrderDiscountCharge.INIT;
                            TempOrderDiscountCharge := OrderChargeLine;
                            TempOrderDiscountCharge.INSERT;
                        UNTIL (OrderChargeLine.NEXT = 0);
                        // OrderChargeLine.CALCSUMS("Line Amount"); // BC Upgrade BHARDA11 ----Drink-IT Field(,"Line Amount")
                        // TotalDiscounts += OrderChargeLine."Line Amount"; // BC Upgrade BHARDA11 ----Drink-IT Field(,"Line Amount")
                    END;
                    //-----Order total /blank Deposit Charges
                    OrderChargeLine.RESET;
                    OrderChargeLine.SETRANGE("Document No.", "No.");
                    OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                    // BC Upgrade BHARDA11 >>----Drink-IT Field("Item Charge Type","Show Item charge on Invoice")
                    // OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Deposit);
                    // OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" ");
                    // BC Upgrade BHARDA11 <<----Drink-IT Field("Item Charge Type","Show Item charge on Invoice")
                    IF OrderChargeLine.FINDSET THEN BEGIN
                        PrintOrderDeposits := TRUE;
                        REPEAT
                            TempOrderDepositCharge.INIT;
                            TempOrderDepositCharge := OrderChargeLine;
                            TempOrderDepositCharge.INSERT;
                        UNTIL (OrderChargeLine.NEXT = 0);
                        // BC Upgrade BHARDA11 >>----Drink-IT Field("Line Amount")
                        // OrderChargeLine.CALCSUMS("Line Amount"); 
                        // TotalDeposits += OrderChargeLine."Line Amount";
                        // BC Upgrade BHARDA11 <<----Drink-IT Field("Line Amount")
                    END;
                    //-----Order total /blank Tax Charges
                    // BC Upgrade BHARDA11 >>----Drink-IT Field("Item Charge Type","Show Item charge on Invoice","Line Amount")
                    //     OrderChargeLine.RESET;
                    //     OrderChargeLine.SETRANGE("Document No.", "No.");
                    //     OrderChargeLine.SETRANGE(Type, OrderChargeLine.Type::"Charge (Item)");
                    //     OrderChargeLine.SETRANGE("Item Charge Type", OrderChargeLine."Item Charge Type"::Tax);
                    //     OrderChargeLine.SETFILTER("Show Item charge on Invoice", '%1|%2', OrderChargeLine."Show Item charge on Invoice"::"Order total", OrderChargeLine."Show Item charge on Invoice"::" ");
                    //     IF OrderChargeLine.FINDSET THEN BEGIN
                    //         REPEAT
                    //             IF (OrderChargeLine."Line Amount" <> 0) THEN BEGIN
                    //                 PrintOrderTaxes := TRUE;
                    //                 TempOrderTaxCharge.INIT;
                    //                 TempOrderTaxCharge := OrderChargeLine;
                    //                 TempOrderTaxCharge.INSERT;
                    //             END;
                    //         UNTIL (OrderChargeLine.NEXT = 0);
                    //         OrderChargeLine.CALCSUMS("Line Amount");
                    //         TotalTaxes += OrderChargeLine."Line Amount";
                    //     END;
                    // BC Upgrade BHARDA11 >>----Drink-IT Field("Item Charge Type","Show Item charge on Invoice","Line Amount")
                END;


                //HEI.01>>
                // Tracking Info

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

                // IF WhseShippingTruck.GET("Transfer Receipt Header"."Truck Code") THEN; // BC Upgrade BHARDA11 ----Drink-IT Table(WhseShippingTruck)

            end;

            trigger OnPostDataItem();
            begin
                IF Print THEN BEGIN
                    "No. Printed FND" := "No. Printed FND" + 1;
                    MODIFY;
                    COMMIT;
                END;
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
        TradeRegisterLbl = 'Trade Register'; Name1Lbl = 'Name'; label(DriverLbl; ENU = 'Driver',
                                                                              FRA = 'Signature livreur')
        ApprovedByLbl = 'Approved by:'; label(ReceivedByLbl; ENU = 'Received by:',
                                                           FRA = 'Signature du contrôleur ')
        label(SignatureLbl; ENU = 'Signature',
                           FRA = 'Visa de sécurité ')
        VATNoLbl = 'VAT No.'; HeadOfficeLbl = '(Head Office)'; POBoxLbl = 'PO Box'; TelLbl = 'Tel:'; FaxLbl = 'Fax:'; label(DocumentDateLbl; ENU = 'Document Date',
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
        TransferToNameLbl = 'Name'; InTransitCodeLbl = 'In-Transit Code'; ShippingAgnetServiceLbl = 'Shipping Agent Service'; RouteLbl = 'Route';
    }

    var
        CompanyInfo: Record "Company Information";
        CompanyText: Text;
        OutputNo: Integer;
        TextFooter: array[3] of Text;
        FormatAddr: Codeunit "Format Address";
        Customer: Record Customer;
        ReportTitle: Text;
        // Driver: Record 2014063; // BC Upgrade BHARDA11 ----Drink-IT Table(2014063)
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
        Print: Boolean;
        QtyHL: Decimal;
        CrossRefText: Text;
        ExpirationDate: Date;
        // FreeReasonCode: Record 2013788; // BC Upgrade BHARDA11 ----Drink-IT Table(2013788)
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
        // SalesDepositItemCharge: Record 2013610; // BC Upgrade BHARDA11 ----Drink-IT Table(2013610)
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
        Text002: Label 'Transfer Receipt %1';
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
        Text027: TextConst ENU = 'Lot/Serial & BBdate', FRA = 'Lot/Serial & BB date';
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
        // MasterDataProperty: Record 2029625; // BC Upgrade BHARDA11 ----Drink-IT Table(2029625)
        CTSLbl: Label 'CTS';
        ResponsibilityCenter: Record "Responsibility Center";
        RespCenter_Code: array[20] of Text[50];
        RespCenter_PostCode: array[20] of Text[50];
        RespCenter_PhoneNo: array[20] of Text[50];
        RespCenter_FaxNo: array[20] of Text[50];
        HeaderAddr: array[8] of Text[50];
        Text063: Label 'Sales Order No.';
        TempTrackingSpecification: Record "Item Ledger Entry" temporary;
        // DocTrackingManagement: Codeunit 2031202; // BC Upgrade BHARDA11 ----Drink-IT Codeunit(2031202)
        LotNoCnt: Integer;
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
        ChOfComm: Label 'Chamber of commerce:';
        ContactNo: Label 'Contact Number:';
        FaxNo: Label 'Fax Number:';
        EmailComp: Label 'E-mail:';
        Var_Comments: Text;
        ItemLedgerEntry: Record "Item Ledger Entry";
        TempItemLedgerEntry: Record "Item Ledger Entry" temporary;

    procedure InsertCommentLine(Comment: Text);
    begin
        TempCommentLine.INIT;
        TempCommentLine."Line No." := CommentLineNo;
        TempCommentLine.Comment := Comment;
        TempCommentLine.INSERT;
        CommentLineNo += 10000;
    end;

    local procedure UoM();
    begin
        TempUnitOfMeasure.RESET;
        IF OutputNo = 1 THEN
            IF TempUnitOfMeasure.GET(ItemLedgerEntry."Unit of Measure Code") THEN BEGIN
                TempUnitOfMeasure."Column 1 Amt." += ItemLedgerEntry.Quantity;
                TempUnitOfMeasure.MODIFY;
            END ELSE BEGIN
                TempUnitOfMeasure.INIT;
                TempUnitOfMeasure."Currency Code" := ItemLedgerEntry."Unit of Measure Code";
                TempUnitOfMeasure."Column 1 Amt." := ItemLedgerEntry.Quantity;
                TempUnitOfMeasure.INSERT;
            END;
    end;
}

