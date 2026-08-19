report 54027 "Combined Pick STD"
{
    // FDD-LB-GAPLOG09_Lebanon_ALmaza_Picking List Layout_V1.2, IBM.NAIKH01  20.08.2018
    //   # Created a new Report, Copy of Report 2035403.
    // 
    // HEI.01 Defect#3611 IBM Isyed01 02.04.2019.
    //   #To remove the shelf no.
    //   #To change the signature warehouse employee for picking to Senior WH Operator for picking.
    //   #To change the signature warehouse responsible for picking to Senior WH responsible for picking.
    // 
    // HEI.02 IBM GAVANM01 03.05.2019
    //  # "Quantity not correct" comment from Guido, document 'Combined Pick 50529_Q_LB_WS00000565_Comments.docx', email from 30.04.2019
    // 
    // HEI.03  IBM GAVANM01
    //  # Lot No
    // 
    // HEI.04 HT474 CHG2011081 IBM GAVANM01 20.08.2019
    // # adjustment of the margins
    // 
    // HEI.05 HT474 CHG2011081 IBM GAVANM01 23.08.2019
    //   # defect# 4385 - issue displaying serial no.
    // HEI.06 INC2482364 IBM NASTAA02 14.11.2019 # Suriname Combined Picking List STD - corrections
    //   # Removed condition set on GroupBy = Order
    //   # Removed extra space on layout causing empty second page printed
    // HEI.07 HT474  IBM GAVANM01 20.11.2019
    //   # solve the error when it is grouped by item and not showing all the sales order
    //   # layout adjustments
    // BC Upgrade BHARDA11 >>
    // 1. OLD Report ID - 50259.
    // 2. Add layout path and change layout extension RDLC to RDL
    // 3.  Removed Drink-IT related fields: 
    /* - "Route"
    - "Barcode Position on Documents"
    - "Shortcut Unit of Measure1 Code"
    - "Shortcut Unit of Measure2 Code"
    - "Shortcut Unit of Measure3 Code"
    - "Truck Code"
    - "Trailer Code"
    - "Driver Code"
    - "Driver 2 Code"
    - "Route Planning No."
    - "GTIN Unit of Measure Code" */
    // 4. Removed Drink-IT related code and customizations.
    // 5. Add ApplicationArea property in Report and requestpage fields.
    // 6. Replace "Archive Quotes and Orders" with "Archive Orders"
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Combined Pick STD.rdl'; // BC Upgrade BHARDA11 ---Add layout path and change layout extension RDLC to RDL

    CaptionML = ENU = 'Combined Pick STD',
                FRA = 'Prélévement groupé STD';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header Page"; "Warehouse Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Shipment Date";// , Route;
            column(Route; "Route 107FDW") // BC Upgrade SHUKLP03 Field(Route)
            {
            }
            column(ShipmentDate; "Shipment Date")
            {
            }
            column(GroupBy; GroupBy)
            {
            }
            dataitem("Sales Line"; "Warehouse Shipment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Sales Header Page";
                DataItemTableView = SORTING("Route 107FDW", "Shipment Date", "No.") WHERE("Qty. to Ship" = FILTER(> 0)); // BC Upgrade SHUKLP03 Field(Route)
                trigger OnAfterGetRecord();
                begin

                    BarcodeValueLeft := '';
                    BarcodeValueRight := '';
                    BarcodeValueCenter := '';
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Barcode Position on Documents",Route)
                    // case CompanyInfo."Barcode Position on Documents" of
                    //     CompanyInfo."Barcode Position on Documents"::"No Barcode":
                    //         ;
                    //     CompanyInfo."Barcode Position on Documents"::Left:
                    //         BarcodeValueLeft := "Route 107FDW" + FORMAT("Shipment Date");
                    //     CompanyInfo."Barcode Position on Documents"::Center:
                    //         BarcodeValueCenter := "Route 107FDW" + FORMAT("Shipment Date");
                    //     CompanyInfo."Barcode Position on Documents"::Right:
                    //         BarcodeValueRight := "Route 107FDW" + FORMAT("Shipment Date");
                    // end;
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields("Barcode Position on Documents",Route)

                    //<<DITW17.00.02 AT 19/12/2013 DIT-770 #235

                    tempWarehouseShipmentLine.SETRANGE("No.", "Sales Line"."No.");
                    if GroupBy = GroupBy::Order then
                        tempWarehouseShipmentLine.SETRANGE("Source No.", "Sales Line"."Source No.");// FCE
                    tempWarehouseShipmentLine.SETRANGE("Item No.", "Sales Line"."Item No.");
                    if not tempWarehouseShipmentLine.FINDFIRST then begin
                        tempWarehouseShipmentLine := "Sales Line";
                        tempWarehouseShipmentLine."Line No." += 10000;
                        tempWarehouseShipmentLine."Qty. to Ship" := "Sales Line"."Qty. to Ship";
                        tempWarehouseShipmentLine.INSERT;
                    end else begin
                        tempWarehouseShipmentLine."Qty. to Ship" += "Sales Line"."Qty. to Ship";
                        tempWarehouseShipmentLine.MODIFY;
                    end;

                    NNCTotalExclVAT := NNCTotalLCY;
                    NNCVATAmt := VATAmount;
                    NNCTotalInclVAT := NNCTotalLCY - NNCVATAmt;

                    NNCPmtDiscOnVAT := -VATDiscountAmount;

                    NNCTotalInclVAT2 := TotalAmountInclVAT;

                    NNCVATAmt2 := VATAmount;
                    NNCTotalExclVAT2 := VATBaseAmount;

                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Shortcut Unit of Measure1 Code", "Shortcut Unit of Measure2 Code", "Shortcut Unit of Measure3 Code")
                    // UOMEquivalent1Caption := STRSUBSTNO(UOMEquivalent1lbl, WhseSetup."Shortcut Unit of Measure1 Code");
                    // UOMEquivalent2Caption := STRSUBSTNO(UOMEquivalent2lbl, WhseSetup."Shortcut Unit of Measure2 Code");
                    // UOMEquivalent3Caption := STRSUBSTNO(UOMEquivalent3lbl, WhseSetup."Shortcut Unit of Measure3 Code");
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields("Shortcut Unit of Measure1 Code", "Shortcut Unit of Measure2 Code", "Shortcut Unit of Measure3 Code")

                    UOMEquivalent1 := 0;
                    UOMEquivalent2 := 0;
                    UOMEquivalent3 := 0;
                    // << DITW18.00.06 MSF 22/06/2015 DIT-770 #587   ShowShortcutUomValue
                    // BC Upgrade BHARAD11 >> ----Drink-IT Code
                    // GroupedSalesLine.ShowShortcutUomValue(UOMEquivalent);
                    // UOMEquivalent1 += UOMEquivalent[1];
                    // UOMEquivalent2 += UOMEquivalent[2];
                    // UOMEquivalent3 += UOMEquivalent[3];
                    // BC Upgrade BHARAD11 << ----Drink-IT Code
                    // >> DITW18.00.06 MSF 22/06/2015 DIT-770 #587

                    //NAIKH01>>
                    TruckCodeSalesHdr := '';
                    Driver2CodeSalesHdr := '';
                    DriverCodeSalesHdr := '';
                    RoutePlanningNo := '';
                    RoutePlanningLocationNo := '';
                    WarehouseEmployee := '';
                    WarehouseResponsible := '';


                    WarehouseShipmentHeader.RESET;
                    WarehouseShipmentHeader.SETRANGE("No.", "Sales Line"."No.");
                    if WarehouseShipmentHeader.FINDFIRST then begin
                        // BC UPgrade SHUKLP03 >> Table and field(RecTruck,"Truck Code","Route Planning No.")
                        if RecTruck.GET(WarehouseShipmentHeader."Vehicle Code 101FDW") then
                            TruckCodeSalesHdr := RecTruck.Description;
                        RoutePlanningNo := WarehouseShipmentHeader."Route Planning No. 107FDW";  // BC Upgrade SHUKLP03 <<
                        // BC UPgrade SHUKLP03 << Table and field(RecTruck,"Truck Code","Route Planning No.")

                        WarehouseShipmentNo := WarehouseShipmentHeader."No.";
                        LocationCodeWhseShpHdr := WarehouseShipmentHeader."Location Code";
                        NoPrintedCountHdr := WarehouseShipmentHeader."No. Printed Combined Pick FND";
                        // BC UPgrade SHUKLP03 >> Drink-IT Table and field(RecDriver1,"Driver Code","Driver 2 Code",RecDriver2)
                        if RecDriver1.GET(WarehouseShipmentHeader."Log Driver 107FDW") then
                            DriverCodeSalesHdr := RecDriver1.Description;

                        if RecDriver2.GET(WarehouseShipmentHeader."Co-Driver 107FDW") then
                            Driver2CodeSalesHdr := RecDriver2.Description;  //RecDriver2.Description;
                        // BC UPgrade SHUKLP03 << Table and field(RecDriver1,"Driver Code","Driver 2 Code",RecDriver2)
                        // BC Upgrade SHUKLP03 >> ----Drink-IT Table(RoutePlanningWorksheet)
                        if RoutePlanningNo <> '' then begin
                            if RoutePlanningWorksheet.GET(RoutePlanningNo) then begin
                                RoutePlanningLocationNo := RoutePlanningWorksheet."Shipping Location";
                                WarehouseEmployee := RoutePlanningWorksheet."Warehouse Employee FND";
                                User.RESET;
                                User.SETRANGE("User Name", WarehouseEmployee);
                                if User.FINDFIRST then begin
                                    if User."Full Name" <> '' then
                                        WarehouseEmployeeName := User."Full Name"
                                    else
                                        WarehouseEmployeeName := WarehouseEmployee;
                                end;

                                WarehouseResponsible := RoutePlanningWorksheet."Warehouse Responsible FND";
                                User.RESET;
                                User.SETRANGE("User Name", WarehouseResponsible);
                                if User.FINDFIRST then begin
                                    if User."Full Name" <> '' then
                                        WarehouseResponsibleName := User."Full Name"
                                    else
                                        WarehouseResponsibleName := WarehouseResponsible;
                                end;
                            end;
                        end;
                        // BC UPgrade SHUKLP03 << ----Drink-IT Table (RoutePlanningWorksheet)


                        if LocationCodeWhseShpHdr <> '' then begin
                            if Location.GET(LocationCodeWhseShpHdr) then begin
                                LocName := Location.Name;
                                LocAddress := Location.Address;
                                LocCity := Location.City;
                            end;
                        end;

                    end;

                    QtyFullPallet := 0;
                    QtyMixedPallet := 0;
                    //IF GroupedSalesLine.Type = GroupedSalesLine.Type::Item THEN BEGIN
                    if Item.GET("Sales Line"."Item No.") then begin
                        // BC Upgrade BHARDA11 >> ----Drink-IT Field("GTIN Unit of Measure Code","GTIN Unit of Measure Code")
                        // if Item."GTIN Unit of Measure Code" <> '' then begin
                        //     if ItemUOM.GET("Sales Line"."Item No.", Item."GTIN Unit of Measure Code") then begin
                        //         if "Sales Line".Quantity <= ItemUOM."Qty. per Unit of Measure" then begin
                        //             QtyFullPallet := 0;
                        //             QtyMixedPallet := "Sales Line".Quantity;
                        //         end else if "Sales Line".Quantity > ItemUOM."Qty. per Unit of Measure" then begin
                        //             QtyFullPallet := ROUND(("Sales Line".Quantity / ItemUOM."Qty. per Unit of Measure"), 1, '<');
                        //             QtyFullPallet := QtyFullPallet * ItemUOM."Qty. per Unit of Measure";
                        //             QtyMixedPallet := "Sales Line".Quantity - QtyFullPallet;
                        //         end;
                        //     end else begin
                        //         QtyFullPallet := 0;
                        //         QtyMixedPallet := "Sales Line".Quantity;
                        //     end;
                        // end else begin
                        //     QtyFullPallet := 0;
                        //     QtyMixedPallet := "Sales Line".Quantity;
                        // end;
                        // BC Upgrade BHARDA11 << ----Drink-IT Field("GTIN Unit of Measure Code","GTIN Unit of Measure Code")
                    end;
                    //END;

                    //NAIKH01
                    SalesQty := SalesQty + "Sales Line"."Qty. to Ship";


                    //Total by UOM>>
                    TempUnitOfMeasure.RESET;
                    if TempUnitOfMeasure.GET("Sales Line"."Unit of Measure Code") then begin
                        TempUnitOfMeasure."Column 1 Amt." += "Sales Line"."Qty. to Ship";
                        TempUnitOfMeasure.MODIFY;
                    end else begin
                        TempUnitOfMeasure.INIT;
                        TempUnitOfMeasure."Currency Code" := "Sales Line"."Unit of Measure Code";
                        TempUnitOfMeasure."Column 1 Amt." := "Sales Line"."Qty. to Ship";
                        TempUnitOfMeasure.INSERT;
                    end;
                    //Total by UOM<<
                end;

                trigger OnPreDataItem();
                begin
                    "Sales Line".SETFILTER("Shipment Date", "Sales Header Page".GETFILTER("Shipment Date"));
                    "Sales Line".SETFILTER("Route 107FDW", "Sales Header Page".GETFILTER("Route 107FDW")); // BC Upgrade SHUKLP03
                    //"Sales Line".SETFILTER("Document No.","Sales Header Page".GETFILTER("No.")); //NAIKH01
                    "Sales Line".SETFILTER("No.", "Sales Header Page".GETFILTER("No.")); //NAIKH01

                    CompanyInfo.GET;

                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");

                    COMPRESSARRAY(ShipToAddr);

                    //ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No."; //NAIKH01
                    for i := 1 to ARRAYLEN(ShipToAddr) do
                        if ShipToAddr[i] <> CustAddr[i] then
                            ShowShippingAddr := true;


                    EmptyDetailsExists := false;

                    SalesOrderLine.RESET;
                    if "Sales Header Page".GETFILTER("No.") <> '' then
                        //  SalesOrderLine.SETRANGE("Document No.","Sales Header Page".GETFILTER("No.")); //NAIKH01
                        SalesOrderLine.SETRANGE("No.", "Sales Header Page".GETFILTER("No.")); //NAIKH01
                    if "Sales Header Page".GETFILTER("Shipment Date") <> '' then
                        SalesOrderLine.SETFILTER("Shipment Date", "Sales Header Page".GETFILTER("Shipment Date"));
                    // BC Upgrade SHUKLP03 >>  Fields(Route)
                    if "Sales Header Page".GETFILTER("Route 107FDW") <> '' then
                        SalesOrderLine.SETFILTER("Route 107FDW", "Sales Header Page".GETFILTER("Route 107FDW"));
                    // BC Upgrade SHUKLP03 <<  Fields(Route)
                    //SalesOrderLine.SETRANGE(Type,SalesOrderLine.Type::"Charge (Item)"); //NAIKH01
                    //SalesOrderLine.SETFILTER("Empty Goods Item No.",'<>%1',''); //NAIKH01
                    //SalesOrderLine.SETRANGE("Item Charge Type",SalesOrderLine."Item Charge Type"::Deposit); //NAIKH01
                    if not SalesOrderLine.ISEMPTY then
                        EmptyDetailsExists := true;


                    //CurrReport.CREATETOTALS("Line Amount","Inv. Discount Amount"); //NAIKH01

                    GroupedSalesLine.DELETEALL;
                    tempWarehouseShipmentLine.DELETEALL;
                end;
            }
            dataitem(GroupedPerItem; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(WhseShipmentLine_BinCode; "Sales Line"."Bin Code")
                {
                    IncludeCaption = true;
                }
                column(LineNo_SalesLine; "Sales Line"."Line No.")
                {
                }
                column(DocType_SalesHeader; TestCode)
                {
                }
                column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
                {
                }
                column(No_SalesHeader; "Sales Line"."No.")
                {
                }
                column(PhoneNoCaption; PhoneNoCaptionLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(VATPercentageCaption; VATPercentageCaptionLbl)
                {
                }
                column(VATBaseCaption; VATBaseCaptionLbl)
                {
                }
                column(VATAmtCaption; VATAmtCaptionLbl)
                {
                }
                column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                {
                }
                column(LineAmtCaption; LineAmtCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(UnitPriceCaption; UnitPriceCaptionLbl)
                {
                }
                column(PaymentTermsCaption; PaymentTermsCaptionLbl)
                {
                }
                column(ShipmentMethodCaption; ShipmentMethodCaptionLbl)
                {
                }
                column(DocumentDateCaption; DocumentDateCaptionLbl)
                {
                }
                column(AllowInvDiscCaption; AllowInvDiscCaptionLbl)
                {
                }
                column(CompanyInfo2Picture; CompanyInfo2.Picture)
                {
                }
                column(CompanyInfo3Picture; CompanyInfo3.Picture)
                {
                }
                column(CompanyInfo1Picture; CompanyInfo1.Picture)
                {
                }
                column(CompanyInfo4Picture; CompanyInfo4.Picture)
                {
                }
                column(OrderConfirmCopyCaption; STRSUBSTNO(Text004, CopyText))
                {
                }
                column(CustAddr1; CustAddr[1])
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(CustAddr2; CustAddr[2])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CustAddr3; CustAddr[3])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CustAddr4; CustAddr[4])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CustAddr5; CustAddr[5])
                {
                }
                column(CompanyInfoPhNo; CompanyInfo."Phone No.")
                {
                }
                column(CustAddr6; CustAddr[6])
                {
                }
                column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                {
                }
                column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                {
                }
                column(CompanyInfoBankName; CompanyInfo."Bank Name")
                {
                }
                column(CompanyInfoHomePage; CompanyInfo."Home Page")
                {
                }
                column(CompanyInfoEmail; CompanyInfo."E-Mail")
                {
                }
                column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                {
                }
                column(BilltoCustNo_SalesHeader; TestCode)
                {
                }
                column(DocDate_SalesHeader; FORMAT("Sales Header"."Shipment Date", 0, 4))
                {
                }
                column(VATNoText; VATNoText)
                {
                }
                column(VATRegNo_SalesHeader; TestCode)
                {
                }
                column(ShptDate_SalesHeader; FORMAT("Sales Header"."Shipment Date", 0, 4))
                {
                }
                column(DateTimeCaption; DateTimeCaptionLbl)
                {
                }
                column(DateTime_Today; FORMAT(CURRENTDATETIME, 0, '<day>-<month>-<year4> <hours24>:<minutes>'))
                {
                }
                column(UserIdPrintedCaption; UserIdPrintedLbl)
                {
                }
                column(UserIdPrintedBy; USERID)
                {
                }
                column(SalesPersonText; SalesPersonText)
                {
                }
                column(SalesPurchPersonName; SalesPurchPerson.Name)
                {
                }
                column(ReferenceText; ReferenceText)
                {
                }
                column(SalesOrderReference_SalesHeader; TestCode)
                {
                }
                column(CustAddr7; CustAddr[7])
                {
                }
                column(CustAddr8; CustAddr[8])
                {
                }
                column(CompanyAddr5; CompanyAddr[5])
                {
                }
                column(CompanyAddr6; CompanyAddr[6])
                {
                }
                column(PricesInclVAT_SalesHeader; TestInt)
                {
                }
                column(PageCaption; STRSUBSTNO(Text005, ''))
                {
                }
                column(OutputNo; OutputNo)
                {
                }
                column(PmntTermsDesc; PaymentTerms.Description)
                {
                }
                column(ShptMethodDesc; ShipmentMethod.Description)
                {
                }
                column(PricesInclVATYesNo_SalesHeader; TestInt)
                {
                }
                column(VATRegNoCaption; VATRegNoCaptionLbl)
                {
                }
                column(GiroNoCaption; GiroNoCaptionLbl)
                {
                }
                column(BankCaption; BankCaptionLbl)
                {
                }
                column(AccountNoCaption; AccountNoCaptionLbl)
                {
                }
                column(OrderNoCaption; OrderNoCaptionLbl)
                {
                }
                column(HomePageCaption; HomePageCaptionLbl)
                {
                }
                column(EmailCaption; EmailCaptionLbl)
                {
                }
                column(BilltoCustNo_SalesHeaderCaption; TestCode)
                {
                }
                column(PricesInclVAT_SalesHeaderCaption; TestInt)
                {
                }
                column(BarcodeValueLeft; BarcodeValueLeft)
                {
                }
                column(BarcodeValueCenter; BarcodeValueCenter)
                {
                }
                column(BarcodeValueRight; BarcodeValueRight)
                {
                }
                column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
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
                column(ShiptoCode; ShiptoCode)
                {
                }
                column(ExtDocNoCaption; ExtDocNoCaptionLbl)
                {
                }
                column(ExtDocNo; "Sales Header"."External Document No.")
                {
                }
                column(SelltoCustNo_SalesHeaderCaption; TestCode)
                {
                }
                column(SelltoCustNo_SalesHeader; TestCode)
                {
                }
                column(SelltoContactPhNoCaption; SelltoContactPhNoCaptionLbl)
                {
                }
                column(SelltoContactPhoneNo; SelltoContactPhoneNo)
                {
                }
                column(ShippingAgentCodeCaption; ShippingAgentCodeCaptionLbl)
                {
                }
                column(ShippingAgentCode; "Sales Header"."Shipping Agent Code")
                {
                }
                column(Driver1Caption; Driver1CaptionLbl)
                {
                }
                column(Driver1; DriverCodeSalesHdr)
                {
                }
                column(Driver2Caption; Driver2CaptionLbl)
                {
                }
                column(Driver2; Driver2CodeSalesHdr)
                {
                }
                column(TrailerCaption; TrailerCaptionLbl)
                {
                    Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035';
                }
                column(Trailer; "Sales Header"."Trailer 107FDW") // BC Upgrade SHUKLP03 <<
                {
                    Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035';
                }
                column(TruckCaption; TruckCaptionLbl)
                {
                }
                column(Truck; TruckCodeSalesHdr)
                {
                }
                column(TruckZoneCaption; TestCode)
                {
                }
                column(TruckZone; TestCode)
                {
                }
                column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                {
                }
                column(CompanyInfoIBAN; CompanyInfo.IBAN)
                {
                }
                column(CompanyInfoSwiftCode; CompanyInfo."SWIFT Code")
                {
                }
                column(CompanyInfoFaxNoCaption; CompanyInfoFaxNoCaptionLbl)
                {
                }
                column(CompanyInfoIBANCaption; CompanyInfoIBANCaptionLbl)
                {
                }
                column(CompanyInfoSwiftCodeCaption; CompanyInfoSwiftCodeCaptionLbl)
                {
                }
                column(EmptyDetailsExists; EmptyDetailsExists)
                {
                }
                column(ArrivalDateTimeCaption; ArrivalDateTimeCaptionLbl)
                {
                }
                column(DepartureDateTimeCaption; DepartureDateTimeCaptionLbl)
                {
                }
                column(BreakStartDateTimeCaption; BreakStartDateTimeCaptionLbl)
                {
                }
                column(BreakEndDateTimeCaption; BreakEndDateTimeCaptionLbl)
                {
                }
                column(DriverNameCaption; DriverNameCaptionLbl)
                {
                }
                column(Driver2NameCaption; DriverName2CaptionLbl)
                {
                }
                column(DriverSignatureCaption; DriverSignatureCaptionLbl)
                {
                }
                column(Driver2SignatureCaption; Driver2SignatureCaptionLbl)
                {
                }
                column(DriverCommentsCaption; DriverCommentsCaptionLbl)
                {
                }
                column(Driver2CommentsCaption; Driver2CommentsCaptionLbl)
                {
                }
                column(CustomerSignatureCaption; CustomerSignatureCaptionLbl)
                {
                }
                column(ShiptoAddrKeyNo; ShiptoAddrKeyNo)
                {
                }
                column(PickingTypeCaption; TestCode)
                {
                }
                column(PickingType; TestCode)
                {
                }
                column(DeliveryTime1Caption; DeliveryTime1CaptionLbl)
                {
                }
                column(DeliveryTime1; DeliveryTime1)
                {
                }
                column(DeliveryTime2Caption; DeliveryTime2CaptionLbl)
                {
                }
                column(DeliveryTime2; DeliveryTime2)
                {
                }
                column(AddressLeft; AddressLeft)
                {
                }
                column(AddressRight; AddressRight)
                {
                }
                column(SalesLineAmt; TestInt)
                {
                    AutoFormatType = 1;
                }
                column(Desc_SalesLine; "Sales Line".Description)
                {
                }
                column(RouteCaption; "Sales Line".FIELDCAPTION("Route 107FDW")) // BC Upgrade SHUKLP03 Field(Route)
                {
                }
                column(ShipmentDateCaption; "Sales Line".FIELDCAPTION("Shipment Date"))
                {
                }
                column(NNCSalesLineLineAmt; NNCSalesLineLineAmt)
                {
                }
                column(NNCSalesLineInvDiscAmt; NNCSalesLineInvDiscAmt)
                {
                }
                column(NNCTotalLCY; NNCTotalLCY)
                {
                }
                column(NNCTotalExclVAT; NNCTotalExclVAT)
                {
                }
                column(NNCVATAmt; NNCVATAmt)
                {
                }
                column(NNCTotalInclVAT; NNCTotalInclVAT)
                {
                }
                column(NNCPmtDiscOnVAT; NNCPmtDiscOnVAT)
                {
                }
                column(NNCTotalInclVAT2; NNCTotalInclVAT2)
                {
                }
                column(NNCVATAmt2; NNCVATAmt2)
                {
                }
                column(NNCTotalExclVAT2; NNCTotalExclVAT2)
                {
                }
                column(VATBaseDisc_SalesHeader; TestInt)
                {
                }
                column(DisplayAssemblyInfo; DisplayAssemblyInformation)
                {
                }
                column(ShowInternalInfo; ShowInternalInfo)
                {
                }
                column(No2_SalesLine; "Sales Line"."Item No.")
                {
                }
                column(Qty_SalesLine; "Sales Line"."Qty. to Ship")
                {
                }
                column(SourceNo_SalesLine; "Sales Line"."Source No.")
                {
                }
                column(QtyFullPallet_Caption; QtyFullPalletLbl)
                {
                }
                column(QtyFullPallet; QtyFullPallet)
                {
                }
                column(QtyMixedPallet_Caption; QtyMixedPalletLbl)
                {
                }
                column(QtyMixedPallet; QtyMixedPallet)
                {
                }
                column(GrossWt; GrossWt)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(NetWt; NetWt)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(NetWt_SalesLine; 0.0)
                {
                }
                column(GrossWt_SalesLine; 0.0)
                {
                }
                column(TotQtyHL_SalesLine; TestInt)
                {
                }
                column(TotalQtyinHL; TotalQtyinHL)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(UOMEquivalent1; UOMEquivalent1)
                {
                }
                column(UOMEquivalent2; UOMEquivalent2)
                {
                }
                column(UOMEquivalent3; UOMEquivalent3)
                {
                }
                column(GrossWtCaption; Text011)
                {
                }
                column(NetWtCaption; Text010)
                {
                }
                column(TotalQtyInHLCaption; TotalQtyInHLCaptionLbl)
                {
                }
                column(UOMEquivalent1Caption; UOMEquivalent1Caption)
                {
                }
                column(UOMEquivalent2Caption; UOMEquivalent2Caption)
                {
                }
                column(UOMEquivalent3Caption; UOMEquivalent3Caption)
                {
                }
                column(UOM_SalesLine; "Sales Line"."Unit of Measure Code")
                {
                }
                column(UnitPrice_SalesLine; TestInt)
                {
                    AutoFormatType = 2;
                    IncludeCaption = false;
                }
                column(LineDisc_SalesLine; TestInt)
                {
                }
                column(LineAmt_SalesLine; TestInt)
                {
                    AutoFormatType = 1;
                }
                column(AllowInvDisc_SalesLine; TestInt)
                {
                }
                column(VATIdentifier_SalesLine; TestCode)
                {
                }
                column(Type_SalesLine; 2)
                {
                }
                column(No_SalesLine; "Sales Line"."No.")
                {
                }
                column(AllowInvDiscountYesNo_SalesLine; TestInt)
                {
                }
                column(AsmInfoExistsForLine; AsmInfoExistsForLine)
                {
                }
                column(SalesLineInvDiscAmt; TestInt)
                {
                    AutoFormatType = 1;
                    IncludeCaption = false;
                }
                column(ShelfNo_SalesLineCaption; "Sales Line".FIELDCAPTION("Shelf No."))
                {
                }
                column(ShelfNo_SalesLine; "Sales Line"."Shelf No.")
                {
                }
                column(TotalText; TotalText)
                {
                }
                column(SalsLinAmtExclLineDiscAmt; TestInt)
                {
                    AutoFormatType = 1;
                }
                column(TotalExclVATText; TotalExclVATText)
                {
                }
                column(VATAmtLineVATAmtText3; VATAmountLine.VATAmountText)
                {
                }
                column(TotalInclVATText; TotalInclVATText)
                {
                }
                column(VATAmount; TestInt)
                {
                    AutoFormatType = 1;
                }
                column(SalesLineAmtExclLineDisc; TestInt)
                {
                    AutoFormatType = 1;
                }
                column(VATDiscountAmount; TestInt)
                {
                    AutoFormatType = 1;
                }
                column(VATBaseAmount; TestInt)
                {
                    AutoFormatType = 1;
                }
                column(TotalAmountInclVAT; TestInt)
                {
                    AutoFormatType = 1;
                }
                column(DiscountPercentCaption; DiscountPercentCaptionLbl)
                {
                }
                column(SubtotalCaption; SubtotalCaptionLbl)
                {
                }
                column(PaymentDiscountVATCaption; PaymentDiscountVATCaptionLbl)
                {
                }
                column(Desc_SalesLineCaption; "Sales Line".FIELDCAPTION(Description))
                {
                }
                column(No2_SalesLineCaption; "Sales Line".FIELDCAPTION("No."))
                {
                }
                column(Qty_SalesLineCaption; QtyCaptionLbl)
                {
                }
                column(UOM_SalesLineCaption; UOMCaptionLbl)
                {
                }
                column(VATIdentifier_SalesLineCaption; TestCode)
                {
                }
                column(LocationCaption; LocationCaptionLbl)
                {
                }
                column(Location_SalesLine; "Sales Line"."Location Code")
                {
                }
                column(VATPer_SalesInvLineCaption; VATPercentageCaptionLbl)
                {
                }
                column(VATPer_SalesInvLine; TestInt)
                {
                }
                column(TotalHLCaption; TotalHLCaptionLbl)
                {
                }
                column(FreeItem; TestCode)
                {
                }
                column(FreeReasonDesc; FreeReasonDesc)
                {
                }
                column(ItemChargeCalcPer; TestCode)
                {
                }
                column(LineQtyinHL; LineQtyinHL)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(Desc2_SalesLine; "Sales Line"."Description 2")
                {
                }
                column(Desc2_SalesLineCaption; "Sales Line".FIELDCAPTION("Description 2"))
                {
                }
                column(TruckZoneFilter; TestCode)
                {
                }
                column(RoutePlanningNoCaption; RoutePlanningNoCaptionLbl)
                {
                }
                column(RoutePlanningNo_WhseShipHdr; RoutePlanningNo)
                {
                }
                column(ShipmentNoCaption; ShipmentNoCaptionLbl)
                {
                }
                column(WarehouseShipmentNo; WarehouseShipmentNo)
                {
                }
                column(LocationCodeCaption; LocationCodeCaptionLbl)
                {
                }
                column(RoutePlanningLocationNo; RoutePlanningLocationNo)
                {
                }
                column(LocName; LocName)
                {
                }
                column(LocAddress; LocAddress)
                {
                }
                column(LocCity; LocCity)
                {
                }
                column(ZoneCaption; ZoneCaptionLbl)
                {
                }
                column(ZoneCode_WhseShipLine; "Sales Line"."Zone Code")
                {
                }
                column(LotSerialInfoCaption; LotSerialInfoCaptionLbl)
                {
                }
                column(LotNoCnt; LotNoCnt)
                {
                }
                column(TrackingText1; TrackingText1)
                {
                }
                column(TrackingText2; TrackingText2)
                {
                }
                column(SortBy; SortBy)
                {
                }
                column(SignatureEmpPickingCaption; SignatureEmpPickingCaptionLbl)
                {
                }
                column(WarehouseEmployee; WarehouseEmployeeName)
                {
                }
                column(SignatureResPickingCaption; SignatureResPickingCaptionLbl)
                {
                }
                column(WarehouseResponsible; WarehouseResponsibleName)
                {
                }
                column(WarehouseemployeeCaption; WarehouseemployeeCaptionLbl)
                {
                }
                column(WarehouserespCaption; WarehouserespCaptionLbl)
                {
                }
                column(NoPrintedCaptionLbl; NoPrintedCaptionLbl)
                {
                }
                column(NoPrintedCountHdr; NoPrintedCountHdr)
                {
                }
                column(SpliteLinePerOrder; SpliteLinePerOrder)
                {
                }
                column(SalesQty; SalesQty)
                {
                }
                column(ShowSO; ShowSO)
                {
                }
                column(ShowTO; ShowTO)
                {
                }
                dataitem(SalesOrderLine_Splite; "Integer")
                {
                    column(SpliteOrder_SourceNo1; tempWarehouseShipmentLine_SourceNo."Source No." + '  ' + SalesHeader1."Ship-to Name")
                    {
                    }
                    column(SpliteOrder_Qty; SpliteOrder_Qty)
                    {
                    }
                    column(SpliteOrder_TrackingText; SpliteSourceOrder_TrackingText)
                    {
                    }
                    column(SpliteOrder_SourceNo; TempReservationEntry."Source ID" + '  ' + SalesHeader1."Ship-to Name")
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        ExpDate := 0D;
                        if Number = 1 then begin
                            if not TempReservationEntry.FIND('-') then
                                CurrReport.BREAK;
                        end else
                            if TempReservationEntry.NEXT = 0 then
                                CurrReport.BREAK;
                        /*
                        SalesHeader1.RESET;
                        SalesHeader1.SETRANGE("Document Type",SalesHeader1."Document Type"::Order);
                        SalesHeader1.SETRANGE("No.",TempReservationEntry."Source ID");
                        IF SalesHeader1.FINDFIRST THEN;
                        */
                        //NaikH01New
                        ItemLedgEntry.RESET;
                        ItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");

                        ItemLedgEntry.SETRANGE("Item No.", TempReservationEntry."Item No.");
                        ItemLedgEntry.SETRANGE(Open, true);
                        ItemLedgEntry.SETRANGE("Variant Code", TempReservationEntry."Variant Code");
                        if TempReservationEntry."Lot No." <> '' then
                            ItemLedgEntry.SETRANGE("Lot No.", TempReservationEntry."Lot No.")
                        else
                            if TempReservationEntry."Serial No." <> '' then
                                ItemLedgEntry.SETRANGE("Serial No.", TempReservationEntry."Serial No.");
                        ItemLedgEntry.SETRANGE(Positive, true);

                        if ItemLedgEntry.FINDFIRST then begin
                            ExpDate := ItemLedgEntry."Expiration Date";

                        end;
                        //>>NaikH01New

                        if Item.GET(TempReservationEntry."Item No.") then begin
                            ItemUOM.SETRANGE("Item No.", Item."No.");
                            //ItemUOM.SETRANGE(Code,Item."Inventory Unit of Measure");
                            ItemUOM.SETRANGE(Code, "Sales Line"."Unit of Measure Code");  //HEI.02
                            if ItemUOM.FINDFIRST then
                                IUOM_Qtyperum := ItemUOM."Qty. per Unit of Measure";
                        end;

                        SpliteSourceOrder_TrackingText := '';
                        ReservationEntry."Lot No." := '';
                        if TempReservationEntry."Lot No." <> '' then
                            SpliteSourceOrder_TrackingText := TempReservationEntry."Lot No." + ' ' + FORMAT(ExpDate)
                        //HEI.05>>
                        else
                            if TempReservationEntry."Serial No." <> '' then
                                SpliteSourceOrder_TrackingText := TempReservationEntry."Serial No." + ' ' + FORMAT(ExpDate);
                        //HEI.05<<
                        if TempReservationEntry."Qty. to Handle (Base)" < 0 then
                            SpliteOrder_Qty := -TempReservationEntry."Qty. to Handle (Base)" / IUOM_Qtyperum;

                        if SpliteOrder_Qty < 0 then
                            SpliteOrder_Qty := -SpliteOrder_Qty;

                    end;

                    trigger OnPostDataItem();
                    begin
                        if SpliteLinePerOrder then
                            TempReservationEntry.DELETEALL;
                    end;

                    trigger OnPreDataItem();
                    begin
                        TempReservationEntry.RESET;
                        SETRANGE(Number, 1, TempReservationEntry.COUNT);
                    end;
                }
                dataitem(TrackingSpecification; "Integer")
                {
                    column(TrackingText; TrackingText)
                    {
                    }
                    column(LotNoQty; LotNoQty)
                    {
                    }
                    column(ExtendedText1; ExtendedText1)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin

                        /*IF Number = 1 THEN BEGIN
                          IF NOT tempWhseItemTrackingLine.FIND('-') THEN
                            CurrReport.BREAK;
                        END ELSE
                          IF tempWhseItemTrackingLine.NEXT = 0 THEN
                            CurrReport.BREAK;
                        
                        
                        //NaikH01New
                        ItemLedgEntry.RESET;
                        ItemLedgEntry.SETCURRENTKEY("Item No.",Open,"Variant Code",Positive,"Lot No.","Serial No.");
                        
                        ItemLedgEntry.SETRANGE("Item No.",tempWhseItemTrackingLine."Item No.");
                        ItemLedgEntry.SETRANGE(Open,TRUE);
                        ItemLedgEntry.SETRANGE("Variant Code",tempWhseItemTrackingLine."Variant Code");
                        IF tempWhseItemTrackingLine."Lot No." <> '' THEN
                          ItemLedgEntry.SETRANGE("Lot No.",tempWhseItemTrackingLine."Lot No.")
                        ELSE
                          IF tempWhseItemTrackingLine."Serial No." <> '' THEN
                            ItemLedgEntry.SETRANGE("Serial No.",tempWhseItemTrackingLine."Serial No.");
                        ItemLedgEntry.SETRANGE(Positive,TRUE);
                        
                        IF ItemLedgEntry.FINDFIRST THEN
                          ExpDate := ItemLedgEntry."Expiration Date";
                        //>>NaikH01New
                        
                        TrackingText :=  GetPostedTrackingText(tempWhseItemTrackingLine) +'  '+FORMAT(ExpDate);
                        
                        IF TrackingText = '' THEN BEGIN
                        
                        END;
                        
                        LotNoQty := tempWhseItemTrackingLine."Quantity (Base)";*/

                        ExpDate := 0D;

                        if Number = 1 then begin
                            if not TempReservationEntry.FIND('-') then
                                CurrReport.BREAK;
                        end else
                            if TempReservationEntry.NEXT = 0 then
                                CurrReport.BREAK;

                        ItemLedgEntry.RESET;
                        ItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");

                        ItemLedgEntry.SETRANGE("Item No.", TempReservationEntry."Item No.");
                        ItemLedgEntry.SETRANGE(Open, true);
                        ItemLedgEntry.SETRANGE("Variant Code", TempReservationEntry."Variant Code");
                        if TempReservationEntry."Lot No." <> '' then
                            ItemLedgEntry.SETRANGE("Lot No.", TempReservationEntry."Lot No.")
                        else
                            if TempReservationEntry."Serial No." <> '' then
                                ItemLedgEntry.SETRANGE("Serial No.", TempReservationEntry."Serial No.");
                        ItemLedgEntry.SETRANGE(Positive, true);

                        if ItemLedgEntry.FINDFIRST then
                            ExpDate := ItemLedgEntry."Expiration Date";

                        TrackingText := '';
                        if TempReservationEntry."Lot No." <> '' then
                            TrackingText := TempReservationEntry."Lot No." + '  ' + FORMAT(ExpDate)
                        //HEI.05>>
                        else
                            if TempReservationEntry."Serial No." <> '' then
                                TrackingText := TempReservationEntry."Serial No." + '  ' + FORMAT(ExpDate);
                        //HEI.05<<
                        if Item.GET(TempReservationEntry."Item No.") then begin
                            ItemUOM.SETRANGE("Item No.", Item."No.");
                            ItemUOM.SETRANGE(Code, "Sales Line"."Unit of Measure Code");  //HEI.02
                            if ItemUOM.FINDFIRST then
                                IUOM_Qtyperum := ItemUOM."Qty. per Unit of Measure";
                        end;

                        if TempReservationEntry."Qty. to Handle (Base)" < 0 then
                            LotNoQty := -TempReservationEntry."Qty. to Handle (Base)" / IUOM_Qtyperum;

                        if LotNoQty < 0 then
                            LotNoQty := -LotNoQty;

                        /*TrackingText1 := '';
                        IF LotNoCnt = 1 THEN BEGIN
                          IF TempReservationEntry."Lot No." <> '' THEN
                            TrackingText1 := TempReservationEntry."Lot No."+'  '+FORMAT(ExpDate);
                        END;*/

                    end;

                    trigger OnPostDataItem();
                    begin
                        TempReservationEntry.DELETEALL;
                    end;

                    trigger OnPreDataItem();
                    begin
                        //SETRANGE(Number,1,tempWhseItemTrackingLine.COUNT);
                        TempReservationEntry.RESET;
                        SETRANGE(Number, 1, TempReservationEntry.COUNT);
                    end;
                }
                dataitem(SO; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(SO_No; tempSO."No.")
                    {
                    }
                    column(SO_ExtDocNo; tempSO."External Document No.")
                    {
                    }
                    column(SO_SelltoCustomerNo; tempSO."Sell-to Customer No.")
                    {
                    }
                    column(SO_SelltoCustomerName; tempSO."Sell-to Customer Name")
                    {
                    }
                    column(SO_ShiptoAddr; tempSO."Ship-to Address")
                    {
                    }
                    // BC Upgrade SHUKLP03 >> ----Drink-IT Fields("Truck Zone")
                    column(SO_TruckZone; VehicalDecs)
                    {
                    }

                    // BC Upgrade SHUKLP03 << ----Drink-IT Fields("Truck Zone")
                    column(SO_DeliverySeq; tempSO."Delivery Sequence 107FDW") //BC Upgrade SHUKLP03 <<
                    {
                    }

                    // BC Upgrade BHARDA11 << ----Drink-IT Fields("Truck Zone","Delivery Sequence")

                    trigger OnAfterGetRecord();
                    begin
                        if Number = 1 then begin
                            if not tempSO.FIND('-') then
                                CurrReport.BREAK;
                        end else
                            if tempSO.NEXT = 0 then
                                CurrReport.BREAK;

                        // BC Upgrade SHUKLP03 >> ----Added code to get VehicalR."Load Zone Code 107FDW"(Vehicle101FDW)
                        IF WarehouseShipmentHeader."Vehicle Code 101FDW" <> '' then
                            IF VehicalR.GET(WarehouseShipmentHeader."Vehicle Code 101FDW") THEN
                                VehicalDecs := VehicalR."Load Zone Code 107FDW";
                        // BC Upgrade SHUKLP03 << ----Added code to get VehicalR."Load Zone Code 107FDW"(Vehicle101FDW)

                    end;

                    trigger OnPostDataItem();
                    begin
                        tempSO.DELETEALL;
                    end;

                    trigger OnPreDataItem();
                    begin
                        tempSO.RESET;
                        SETRANGE(Number, 1, tempSO.COUNT);
                        // BC Upgrade SHUKLP03 >> ----Added code to get VehicalR."Load Zone Code 107FDW"(Vehicle101FDW)
                        IF tempso."Vehicle Code 101FDW" <> '' then
                            IF VehicalR.GET(tempso."Vehicle Code 101FDW") THEN
                                VehicalDecs := VehicalR."Load Zone Code 107FDW";
                        // BC Upgrade SHUKLP03 << ----Added code to get VehicalR."Load Zone Code 107FDW"(Vehicle101FDW)

                    end;
                }
                dataitem("TO"; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(TO_No; tempTO."No.")
                    {
                    }
                    column(TO_ExtDocNo; tempTO."External Document No.")
                    {
                    }
                    column(TO_SelltoCustomerNo; tempTO."Transfer-to Code")
                    {
                    }
                    column(TO_SelltoCustomerName; tempTO."Transfer-to Name")
                    {
                    }
                    column(TO_ShiptoAddr; tempTO."Transfer-to Address")
                    {
                    }
                    // column(TO_DeliverySeq; tempTO."Delivery Sequence 107FDW") // BC Upgrade SHUKLP03 Field("Delivery Sequence")
                    column(TO_DeliverySeq; '')
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if Number = 1 then begin
                            if not tempTO.FIND('-') then
                                CurrReport.BREAK;
                        end else
                            if tempTO.NEXT = 0 then
                                CurrReport.BREAK;
                    end;

                    trigger OnPostDataItem();
                    begin
                        tempTO.DELETEALL;
                    end;

                    trigger OnPreDataItem();
                    begin
                        tempTO.RESET;
                        SETRANGE(Number, 1, tempTO.COUNT);
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
                                CurrReport.BREAK;
                        end else
                            if TempUnitOfMeasure.NEXT = 0 then
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

                trigger OnAfterGetRecord();
                begin
                    tempEntryNo := 1000000;
                    ExpDate := 0D;

                    if Number = 1 then begin
                        if tempWarehouseShipmentLine.FINDFIRST then;
                    end else
                        tempWarehouseShipmentLine.NEXT;

                    "Sales Line" := tempWarehouseShipmentLine;

                    //To Get the Lot No Assigned against the Line Item.  NAIKH01>>
                    SetTempWhseItemTrkgLine(
                           tempWarehouseShipmentLine."No.", DATABASE::"Warehouse Shipment Line",
                           '', 0, tempWarehouseShipmentLine."Item No.", tempWarehouseShipmentLine."Location Code");

                    //LotNoCnt := tempWhseItemTrackingLine.COUNT;

                    //NaikH01New
                    ItemLedgEntry.RESET;
                    ItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");

                    ItemLedgEntry.SETRANGE("Item No.", "Sales Line"."Item No.");
                    ItemLedgEntry.SETRANGE(Open, true);
                    ItemLedgEntry.SETRANGE("Variant Code", "Sales Line"."Variant Code");
                    if tempWhseItemTrackingLine."Lot No." <> '' then
                        ItemLedgEntry.SETRANGE("Lot No.", tempWhseItemTrackingLine."Lot No.")
                    else
                        if tempWhseItemTrackingLine."Serial No." <> '' then
                            ItemLedgEntry.SETRANGE("Serial No.", tempWhseItemTrackingLine."Serial No.");
                    ItemLedgEntry.SETRANGE(Positive, true);

                    if ItemLedgEntry.FINDFIRST then
                        ExpDate := ItemLedgEntry."Expiration Date";
                    //>>NaikH01New

                    /*IF LotNoCnt = 1 THEN BEGIN
                      TrackingText1 := '';
                      IF GetPostedTrackingText(tempWhseItemTrackingLine) <> '' THEN
                         TrackingText1 := GetPostedTrackingText(tempWhseItemTrackingLine) +'  ' + FORMAT(ExpDate);
                    END;*/
                    //<<

                    //To Get the Extended Text Lines for Each Item No. NAIKH01>>
                    ExtendedTextHeader.RESET;
                    ExtendedTextHeader.SETRANGE("No.", tempWarehouseShipmentLine."Item No.");
                    ExtendedTextHeader.SETRANGE("Print on Picklist FND", true);
                    if ExtendedTextHeader.FINDFIRST then begin
                        ExtendedTextLine.RESET;
                        ExtendedTextLine.SETRANGE("No.", ExtendedTextHeader."No.");
                        if ExtendedTextLine.FINDSET then begin
                            repeat
                                TempExtendedTextLine := ExtendedTextLine;
                                //TempExtendedTextLine."Line No." := ExtendedTextLine."Line No.";
                                TempExtendedTextLine.INSERT;
                            until ExtendedTextLine.NEXT = 0;
                        end;
                    end;
                    //>>

                    //Splite Per Order Line
                    WareShipLine.SETRANGE("No.", tempWarehouseShipmentLine."No.");
                    WareShipLine.SETRANGE("Item No.", tempWarehouseShipmentLine."Item No.");
                    if GroupBy = GroupBy::Order then
                        WareShipLine.SETRANGE("Source No.", tempWarehouseShipmentLine."Source No.");
                    if WareShipLine.FINDSET then begin
                        repeat
                            tempWarehouseShipmentLine_SourceNo := WareShipLine;
                            tempWarehouseShipmentLine_SourceNo.INSERT;
                        until WareShipLine.NEXT = 0;
                    end;

                    //$$ Get the lot no infomration from Reservation entry while using FEFO functiality.
                    TrackingText2 := '';
                    WareShipLine.SETRANGE("No.", tempWarehouseShipmentLine."No.");
                    WareShipLine.SETRANGE("Item No.", tempWarehouseShipmentLine."Item No.");
                    if GroupBy = GroupBy::Order then
                        WareShipLine.SETRANGE("Source No.", tempWarehouseShipmentLine."Source No.");
                    if WareShipLine.FINDSET then begin
                        repeat
                            ReservationEntry.SETRANGE("Source ID", WareShipLine."Source No.");
                            ReservationEntry.SETRANGE("Item No.", WareShipLine."Item No.");
                            //IF ReservationEntry.FINDSET THEN BEGIN  //HEI.03
                            //HEI.03>>
                            if not ReservationEntry.FINDSET then begin
                                // BC Upgrade BHARDA11 >> ----Drink-IT Codeunit(QualityManagement)
                                case WareShipLine."Source Type" of
                                    DATABASE::"Sales Line":
                                        begin
                                            // BC Upgrade BHARDA11 >> ----Drink-IT Codeunit(QualityManagement)
                                            // LotNoTemp := QualityManagement.GetWhseLotNo(
                                            //     DATABASE::"Sales Line", WareShipLine."Source Subtype", WareShipLine."Source No.", '', 0, WareShipLine."Source Line No.", WareShipLine."Item No.", WareShipLine.Quantity < 0);
                                            // //HEI.05>>
                                            // if LotNoTemp = '' then begin
                                            //     SerialNoTemp := QualityManagement.GetSerialNo(
                                            //       DATABASE::"Sales Line", WareShipLine."Source Subtype", WareShipLine."Source No.", '', 0, WareShipLine."Source Line No.", WareShipLine."Item No.", EntryType::Sale, WareShipLine.Quantity < 0);
                                            // end;
                                            //HEI.05<<
                                            // BC Upgrade BHARDA11 << ----Drink-IT Codeunit(QualityManagement)
                                        end;
                                    DATABASE::"Transfer Line":
                                        begin
                                            // BC Upgrade BHARDA11 >> ----Drink-IT Codeunit(QualityManagement)
                                            // Direction := Direction::Outbound;
                                            // if TransferLine.GET(WareShipLine."Source No.", WareShipLine."Source Line No.") then begin
                                            //     LotNoTemp := QualityManagement.GetWhseLotNo(DATABASE::"Transfer Line",
                                            //       Direction, WareShipLine."Source No.", '', TransferLine."Derived From Line No.", WareShipLine."Source Line No.", WareShipLine."Item No.", WareShipLine.Quantity < 0);
                                            //     //HEI.05>>
                                            //     if LotNoTemp = '' then begin
                                            //         SerialNoTemp := QualityManagement.GetSerialNo(
                                            //           DATABASE::"Transfer Line", Direction, WareShipLine."Source No.", '', TransferLine."Derived From Line No.", WareShipLine."Source Line No.", WareShipLine."Item No.", EntryType::Transfer, WareShipLine.Quantity < 0);
                                            //     end;
                                            //     //HEI.05<<
                                            // end;
                                            // BC Upgrade BHARDA11 << ----Drink-IT Codeunit(QualityManagement)
                                        end
                                // BC Upgrade BHARDA11 << ----Drink-IT Codeunit(QualityManagement)
                                end;

                                if GroupBy = GroupBy::Order then begin
                                    if LotNoTemp <> '' then
                                        TrackingText2 := LotNoTemp
                                    //HEI.05>>
                                    else if SerialNoTemp <> '' then
                                        TrackingText2 := SerialNoTemp;
                                    //HEI.05<<
                                end else begin
                                    tempEntryNo += 1;
                                    TempReservationEntry."Entry No." := tempEntryNo;
                                    if WareShipLine."Source Type" = DATABASE::"Sales Line" then begin
                                        TempReservationEntry.Positive := false;
                                        TempReservationEntry."Qty. to Handle (Base)" := -WareShipLine."Qty. to Ship (Base)";
                                    end else begin
                                        TempReservationEntry.Positive := true;
                                        TempReservationEntry."Qty. to Handle (Base)" := WareShipLine."Qty. to Ship (Base)";
                                    end;

                                    TempReservationEntry."Lot No." := LotNoTemp;
                                    TempReservationEntry."Serial No." := SerialNoTemp;   //HEI.05
                                    TempReservationEntry."Item No." := WareShipLine."Item No.";
                                    TempReservationEntry."Source ID" := WareShipLine."Source No.";
                                    TempReservationEntry.INSERT;
                                end;
                            end else begin
                                //HEI.03<<
                                //IF (GroupBy = GroupBy::Order) AND (ReservationEntry."Lot No." <> '') THEN BEGIN   //commented by HEI.05
                                if (GroupBy = GroupBy::Order) and ((ReservationEntry."Lot No." <> '') or (ReservationEntry."Serial No." <> '')) then begin    //HEI.05
                                    ExpDate := 0D;
                                    ItemLedgEntry.RESET;
                                    ItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");

                                    ItemLedgEntry.SETRANGE("Item No.", ReservationEntry."Item No.");
                                    ItemLedgEntry.SETRANGE(Open, true);
                                    ItemLedgEntry.SETRANGE("Variant Code", ReservationEntry."Variant Code");
                                    if ReservationEntry."Lot No." <> '' then
                                        ItemLedgEntry.SETRANGE("Lot No.", ReservationEntry."Lot No.")
                                    else
                                        if ReservationEntry."Serial No." <> '' then
                                            ItemLedgEntry.SETRANGE("Serial No.", ReservationEntry."Serial No.");
                                    ItemLedgEntry.SETRANGE(Positive, true);

                                    if ItemLedgEntry.FINDFIRST then
                                        ExpDate := ItemLedgEntry."Expiration Date";

                                    if ReservationEntry."Lot No." <> '' then
                                        TrackingText2 := ReservationEntry."Lot No." + ' ' + FORMAT(ExpDate)
                                    //HEI.05>>
                                    else
                                        if ReservationEntry."Serial No." <> '' then
                                            TrackingText2 := ReservationEntry."Serial No." + ' ' + FORMAT(ExpDate);
                                    //HEI.05<<
                                end;
                                repeat
                                    if (GroupBy = GroupBy::Order) or SpliteLinePerOrder then  //HEI.03
                                        TempReservationEntry.SETRANGE("Source ID", ReservationEntry."Source ID");
                                    TempReservationEntry.SETRANGE("Item No.", ReservationEntry."Item No.");
                                    TempReservationEntry.SETRANGE("Lot No.", ReservationEntry."Lot No.");
                                    TempReservationEntry.SETRANGE("Serial No.", ReservationEntry."Serial No.");  //HEI.05
                                                                                                                 //IF NOT TempReservationEntry.FINDFIRST THEN BEGIN  //HEI.03
                                                                                                                 //HEI.03>>
                                    if TempReservationEntry.FINDFIRST then begin
                                        if (GroupBy = GroupBy::Item) and not SpliteLinePerOrder then begin
                                            TempReservationEntry."Qty. to Handle (Base)" += ReservationEntry."Qty. to Handle (Base)";
                                            TempReservationEntry.MODIFY;
                                        end;
                                        //HEI.03<<
                                    end else begin
                                        TempReservationEntry := ReservationEntry;
                                        TempReservationEntry.INSERT;
                                    end;   //HEI.10

                                    case WareShipLine."Source Document" of
                                        WareShipLine."Source Document"::"Sales Order":
                                            begin
                                                //$$ get the sales order doc informaiton from the source id from reservatoin entry.
                                                SalesHeaderSO.SETRANGE("No.", ReservationEntry."Source ID");
                                                if SalesHeaderSO.FINDSET then begin
                                                    repeat
                                                        tempSO.SETRANGE("No.", SalesHeaderSO."No.");
                                                        if not tempSO.FINDFIRST then begin
                                                            tempSO.INIT;
                                                            tempSO := SalesHeaderSO;
                                                            tempSO.INSERT;
                                                            ShowSO := true;
                                                        end;
                                                    until SalesHeaderSO.NEXT = 0;
                                                end;
                                            end;
                                        WareShipLine."Source Document"::"Outbound Transfer":
                                            begin
                                                TransferHeaderTO.SETRANGE("No.", ReservationEntry."Source ID");
                                                if TransferHeaderTO.FINDSET then begin
                                                    repeat
                                                        tempTO.SETRANGE("No.", TransferHeaderTO."No.");
                                                        if not tempTO.FINDFIRST then begin
                                                            tempTO.INIT;
                                                            tempTO := TransferHeaderTO;
                                                            tempTO.INSERT;
                                                            ShowTO := true;
                                                        end;
                                                    until TransferHeaderTO.NEXT = 0;
                                                end;
                                            end;
                                    end;
                                //END;  //commented by HEI.10
                                until ReservationEntry.NEXT = 0;
                            end;
                        until WareShipLine.NEXT = 0;
                    end;

                    TempReservationEntry.RESET;
                    LotNoCnt := TempReservationEntry.COUNT;

                    TrackingText1 := '';
                    if LotNoCnt = 1 then begin
                        ExpDate := 0D;
                        ItemLedgEntry.RESET;
                        ItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.");

                        ItemLedgEntry.SETRANGE("Item No.", TempReservationEntry."Item No.");
                        ItemLedgEntry.SETRANGE(Open, true);
                        ItemLedgEntry.SETRANGE("Variant Code", TempReservationEntry."Variant Code");
                        if TempReservationEntry."Lot No." <> '' then
                            ItemLedgEntry.SETRANGE("Lot No.", TempReservationEntry."Lot No.")
                        else
                            if TempReservationEntry."Serial No." <> '' then
                                ItemLedgEntry.SETRANGE("Serial No.", TempReservationEntry."Serial No.");
                        ItemLedgEntry.SETRANGE(Positive, true);

                        if ItemLedgEntry.FINDFIRST then
                            ExpDate := ItemLedgEntry."Expiration Date";

                        if TempReservationEntry."Lot No." <> '' then
                            TrackingText1 := TempReservationEntry."Lot No." + '  ' + FORMAT(ExpDate)
                        //HEI.05>>
                        else
                            if TempReservationEntry."Serial No." <> '' then
                                TrackingText1 := TempReservationEntry."Serial No." + '  ' + FORMAT(ExpDate);
                        //HEI.05<<
                    end;

                end;

                trigger OnPreDataItem();
                begin
                    tempWarehouseShipmentLine.RESET;
                    SETRANGE(Number, 1, tempWarehouseShipmentLine.COUNT);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if not CurrReport.PREVIEW then
                    NoPrintedCount("Sales Header Page");
                /*
                SalesHeaderSO.RESET;
                SalesHeaderSO.SETRANGE("Whse. Shipment No. (First)","Sales Header Page"."No.");
                SalesHeaderSO.SETRANGE("Route Planning No.","Sales Header Page"."Route Planning No.");
                IF SalesHeaderSO.FINDSET THEN BEGIN
                  REPEAT
                    tempSO.INIT;
                    tempSO := SalesHeaderSO;
                    tempSO.INSERT;
                    UNTIL SalesHeaderSO.NEXT =0;
                
                END;
                */

            end;

            trigger OnPostDataItem();
            begin
                SalesOrderLine.RESET;
                //SalesOrderLine.SETRANGE("Document Type",SalesOrderLine."Document Type"::Order);  //NAIKH01
                if "Sales Header Page".GETFILTER("No.") <> '' then
                    //  SalesOrderLine.SETRANGE("Document No.","Sales Header Page".GETFILTER("No.")); //NAIKH01
                    SalesOrderLine.SETRANGE("No.", "Sales Header Page".GETFILTER("No.")); //NAIKH01
                if "Sales Header Page".GETFILTER("Shipment Date") <> '' then
                    SalesOrderLine.SETFILTER("Shipment Date", "Sales Header Page".GETFILTER("Shipment Date"));
                // BC Upgrade SHUKLP03 >> Field(Route)
                if "Sales Header Page".GETFILTER("Route 107FDW") <> '' then
                    SalesOrderLine.SETFILTER("Route 107FDW", "Sales Header Page".GETFILTER("Route 107FDW"));
                // BC Upgrade SHUKLP03 << Field(Route)
                //SalesOrderLine.SETRANGE(Type,SalesOrderLine.Type::Item); //NAIKH01
                SalesOrderLine.SETFILTER("Qty. to Ship", '>%1', 0);

                if not SalesOrderLine.FINDSET then
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem();
            begin
                Print := Print or not CurrReport.PREVIEW;
                SortBy := 0;

                if SortingMethod = SortingMethod::Description then
                    SortBy := 1;
                if SortingMethod = SortingMethod::"Item No" then
                    SortBy := 2;

                if SortingMethod = SortingMethod::"Shelf No" then
                    SortBy := 3;
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
                    field(SortingMethod; SortingMethod)
                    {
                        ApplicationArea = All;
                        Caption = 'Sorting Method';
                    }
                    field(GroupByField; GroupBy)
                    {
                        ApplicationArea = All;
                        Caption = 'Group By';

                        trigger OnValidate();
                        begin
                            if GroupBy = GroupBy::Item then
                                SplitEnabled := true
                            else begin
                                SplitEnabled := false;
                                SpliteLinePerOrder := false;
                            end;
                        end;
                    }
                    field(SpliteLinePerOrder; SpliteLinePerOrder)
                    {
                        ApplicationArea = All;
                        Caption = 'Splite Line Per Order';
                        Enabled = SplitEnabled;
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
            // ArchiveDocument := SalesSetup."Archive Quotes and Orders";
            ArchiveDocument := SalesSetup."Archive Orders"; // BC Upgrade BHARDA11 ---- "Archive Quotes and Orders" is obsolete 
            //LogInteraction := SegManagement.FindInteractTmplCode(3) <> ''; //NAIKH01

            LogInteractionEnable := LogInteraction;
            OnlyNewLines := false;
            SetShipmentStatus := SetShipmentStatus::"Picklist Printed";

            "Sales Line".SETFILTER("Shipment Date", "Sales Header Page".GETFILTER("Shipment Date"));
            "Sales Line".SETFILTER("Route 107FDW", "Sales Header Page".GETFILTER("Route 107FDW")); // BC Upgrade SHUKLP03 << Field(Route)
            //"Sales Line".SETFILTER("Document No.","Sales Header Page".GETFILTER("No.")); //NAIKH01
            "Sales Line".SETFILTER("No.", "Sales Header Page".GETFILTER("No.")); //NAIKH01

            if GroupBy = GroupBy::Item then
                SplitEnabled := true
            else begin
                SplitEnabled := false;
                SpliteLinePerOrder := false;
            end;
        end;
    }

    labels
    {
        label(UomLbl; ENU = 'Unit Of Measure',
                     FRA = 'Unité de mesure')
        TotalLbl = 'Total'; label(SalesOrderLbl; ENU = 'Sales Order',
                                               FRA = 'N° Commande Vente')
        NoLbl = 'No.'; label(ExtDocNoLbl; ENU = 'External Document No.',
                                        FRA = 'N° Doc. Externe')
        label(SellCustNoLbl; ENU = 'Sell to Customer No.',
                            FRA = 'N° Client')
        label(SellCustNameLbl; ENU = 'Sell to Customer Name',
                              FRA = 'N° donneur d'' ordre')
        label(ShipAddLbl; ENU = 'Ship to Address',
                         FRA = 'Adresse du destinataire')
        label(TruckZoneLbl; ENU = 'Truck Zone',
                           FRA = 'Zone de camion')
        label(DeliverySeqLbl; ENU = 'Delivery Sequence',
                             FRA = 'Séquence de livraison')
        TotalQtyLbl = 'Total Qty'; label(TransferToCodeLbl; ENU = 'Transfer to Code',
                                                          FRA = 'Code dest. transfert')
        label(TransferToNameLbl; ENU = 'Transfer to Name',
                                FRA = 'Nom dest. transfert')
        label(TransferAdd; ENU = 'Transfer to Address',
                          FRA = 'Adresse dest. transfert')
        label(TransferOrderLbl; ENU = 'Transfer Order',
                               FRA = 'N° Ordre de transfert')
        PickedQTYLbl = 'Picked QTY';
    }

    trigger OnInitReport();
    begin
        GLSetup.GET;
        WhseSetup.GET;
        SalesSetup.GET;
        ShowSO := false;
        ShowTO := false;


        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                end;
        end;

        //<<DITW17.00.02 AT 19/12/2013 DIT-770 #235
        // BC Upgrade SHUKLP03 >> ----
        CompanyInfo.GET;
        AddressLeft := false;
        AddressRight := false;
        case CompanyInfo."Address Position on Docs FND" of
            CompanyInfo."Address Position on Docs FND"::Left:
                AddressLeft := true;
            CompanyInfo."Address Position on Docs FND"::Right:
                AddressRight := true;
        end;
        // BC Upgrade SHUKLP03 << ----
        //<<DITW17.00.02 AT 19/12/2013 DIT-770 #235

        TestCode := 'BlankCode';
        TestInt := 1.99;
    end;

    trigger OnPostReport();
    begin
        if Print then begin
            COMMIT;
            SalesLineUpdate.RESET;
            //SalesLineUpdate.SETRANGE("Document Type",SalesLineUpdate."Document Type"::Order);  //NAIKH01
            if "Sales Header Page".GETFILTER("No.") <> '' then
                //SalesLineUpdate.SETRANGE("Document No.","Sales Header Page".GETFILTER("No.")); //NAIKH01
                SalesLineUpdate.SETRANGE("No.", "Sales Header Page".GETFILTER("No.")); //NAIKH01
            if "Sales Header Page".GETFILTER("Shipment Date") <> '' then
                SalesLineUpdate.SETFILTER("Shipment Date", "Sales Header Page".GETFILTER("Shipment Date"));
            // BC Upgrade SHUKLP03 >> Field(Route)
            if "Sales Header Page".GETFILTER("Route 107FDW") <> '' then
                SalesLineUpdate.SETFILTER("Route 107FDW", "Sales Header Page".GETFILTER("Route 107FDW"));
            // BC Upgrade SHUKLP03 << Field(Route)
            //SalesLineUpdate.SETRANGE(Type,SalesOrderLine.Type::Item);  //NAIKH01
            SalesLineUpdate.SETFILTER("Qty. to Ship", '>%1', 0);
            //SalesLineUpdate.SETFILTER("Picking Type",'%1',SalesLineUpdate."Picking Type"::Combined);   //NAIKH01
        end;
    end;

    trigger OnPreReport();
    begin
        CompanyInfo4.GET;
        CompanyInfo4.CALCFIELDS(Picture);
    end;

    var
        Text000: TextConst ENU = 'Salesperson', FRA = 'Vendeur';
        Text001: TextConst ENU = 'Total %1', FRA = 'Total %1';
        Text002: TextConst ENU = 'Total %1 Incl. VAT', FRA = 'Total %1 TTC';
        Text003: TextConst ENU = 'COPY', FRA = 'COPIE';
        Text004: TextConst ENU = 'COMBINED PICK %1', FRA = 'BON DE PRELEVEMENT %1';
        Text005: TextConst ENU = 'Page %1', FRA = 'Page %1';
        Text006: TextConst ENU = 'Total %1 Excl. VAT', FRA = 'Total %1 HT';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        TempPrepmtDimSetEntry: Record "Dimension Set Entry" temporary;
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        CurrExchRate: Record "Currency Exchange Rate";
        AsmHeader: Record "Assembly Header";
        AsmLine: Record "Assembly Line";
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
        VehicalR: Record Vehicle101FDW; // BC Upgrade SHUKLP03 <<
        VehicalDecs: TEXT[30]; // BC Upgrade SHUKLP03 <<
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
        ArchiveDocumentEnable: Boolean;
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
        InvDiscAmtCaptionLbl: TextConst ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
        VATRegNoCaptionLbl: TextConst ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        GiroNoCaptionLbl: TextConst ENU = 'Giro No.', FRA = 'N° CCP';
        BankCaptionLbl: TextConst ENU = 'Bank', FRA = 'Banque';
        AccountNoCaptionLbl: TextConst ENU = 'Account No.', FRA = 'N° compte';
        ShipmentDateCaptionLbl: TextConst ENU = 'Shipment Date', FRA = 'Date d''expédition';
        DateTimeCaptionLbl: TextConst ENU = 'PickList Printed On', FRA = 'Date de prélèvement imprimé sur';
        UserIdPrintedLbl: TextConst ENU = 'User Id', FRA = 'Id utilisateur';
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
        // FreeReasonCode: Record "Free Reason Code"; // BC Upgrade BHARDA11 ----Drink-IT Table("Free Reason Code")
        FreeReasonDesc: Text[50];
        ItemChargeCalcPer: Text[50];
        GrossWt: Decimal;
        NetWt: Decimal;
        TotalQtyinHL: Decimal;
        CommentLine: Record "Comment Line";
        SalesCommentLine: Record "Sales Comment Line";
        TempCommentLine: Record "Comment Line" temporary;
        CommentLineNo: Integer;
        LineQtyinHL: Decimal;
        Item: Record Item;
        EmptyDetailsExists: Boolean;
        ExtDocNoCaptionLbl: TextConst ENU = 'External Document No.', FRA = 'N° document externe';
        SellToAddrCaptionLbl: TextConst ENU = 'Order Address', FRA = 'Adresse commande';
        UOMCaptionLbl: TextConst ENU = 'UOM', FRA = 'UM';
        TotalHLCaptionLbl: TextConst ENU = 'Total HL', FRA = 'Total HL';
        DepositQtyShippedCaptionLbl: TextConst ENU = 'Qty Shipped', FRA = 'Qté expédié';
        DepositQtyReturnedCaptionLbl: TextConst ENU = 'Qty Returned', FRA = 'Quantité retournée';
        DepositDifferenceCaptionLbl: TextConst ENU = 'Difference', FRA = 'Différence';
        EmptyGoodsDetailsCaptionLbl: TextConst ENU = 'Empty Goods Detail', FRA = 'Détail marchandises vides';
        TotalQtyInHLCaptionLbl: TextConst ENU = 'Quantity HL', FRA = 'Quantité HL';
        CompanyInfoFaxNoCaptionLbl: TextConst ENU = 'Fax', FRA = 'Fax';
        CompanyInfoIBANCaptionLbl: TextConst ENU = 'IBAN', FRA = 'IBAN';
        CompanyInfoSwiftCodeCaptionLbl: TextConst ENU = 'SWIFT Code', FRA = 'Code SWIFT';
        SalesOrderLine: Record "Warehouse Shipment Line";
        TempSalesOrderLine: Record "Warehouse Shipment Line" temporary;
        SelltoContactPhoneNo: Text[30];
        SelltoContactPhNoCaptionLbl: TextConst ENU = 'Sell-to Contact Phone No.', FRA = 'N° téléphone contact donneur d''ordre';
        ShippingAgentCodeCaptionLbl: TextConst ENU = 'Shipping Agent', FRA = 'Transporteur';
        Driver1CaptionLbl: TextConst ENU = 'Driver 1', FRA = 'Chauffeur 1';
        Driver2CaptionLbl: TextConst ENU = 'Driver 2', FRA = 'CHauffeur 2';
        TruckCaptionLbl: TextConst ENU = 'Truck', FRA = 'Camion';
        LocationCaptionLbl: TextConst ENU = 'Location', FRA = 'Magasin';
        ArrivalDateTimeCaptionLbl: TextConst ENU = 'Pick Start Date/Time', FRA = 'Début prélèvement Date / Heure';
        DepartureDateTimeCaptionLbl: TextConst ENU = 'Pick End Date/Time', FRA = 'Fin prélèvement Date / Heure';
        BreakStartDateTimeCaptionLbl: TextConst ENU = 'Truck Load Start Date/Time', FRA = 'Début chargement camion Date / Heure';
        BreakEndDateTimeCaptionLbl: TextConst ENU = 'Truck Load End Date/Time', FRA = 'Fin chargement camion Date / Heure';
        DriverNameCaptionLbl: TextConst ENU = 'Picker Name', FRA = 'Nom du préleveur';
        DriverName2CaptionLbl: TextConst ENU = 'Truck Loader Name', FRA = 'Nom responsable du chargement du camion';
        DriverSignatureCaptionLbl: TextConst ENU = 'Picker Signature', FRA = 'Signature du préleveur';
        Driver2SignatureCaptionLbl: TextConst ENU = 'Truck Loader Signature', FRA = 'Signature responsable signature du camion';
        DriverCommentsCaptionLbl: TextConst ENU = 'Picker Comments', FRA = 'Commentaires préleveur';
        Driver2CommentsCaptionLbl: TextConst ENU = 'Truck Loader Comments', FRA = 'Commentaires agent de chargemement du camion';
        CustomerSignatureCaptionLbl: TextConst ENU = 'Customer signature for goods receipt', FRA = 'Signature du client pour la réception des marchandises';
        DeliveryTime1: Text[100];
        DeliveryTime2: Text[100];
        DeliveryTime1CaptionLbl: TextConst ENU = 'Delivery Time 1 ', FRA = 'Délai de livraison 1 ';
        DeliveryTime2CaptionLbl: TextConst ENU = 'Delivery Time 2', FRA = 'Heure de livraison 2';
        ShiptoAddrKeyNo: Text[100];
        AddressLeft: Boolean;
        AddressRight: Boolean;
        QtyCaptionLbl: TextConst ENU = 'QTY', FRA = 'Qté.';
        Route1: Record Route107FDW; // BC Upgrade SHUKLP03 << replacement of Nav table ("Route")
        QtyFullPallet: Decimal;
        QtyMixedPallet: Decimal;
        QtyFullPalletLbl: TextConst ENU = 'Qty. Full Pallet', FRA = 'Qté palette compléte';
        QtyMixedPalletLbl: TextConst ENU = 'Qty. Mixed Pallet', FRA = 'Qté palette mixte';
        ItemUOM: Record "Item Unit of Measure";
        CounterCheck: Boolean;
        "Sales Header": Record "Warehouse Shipment Header";
        RecDriver1: Record Driver107FDW; // BC Upgrade SHUKLP03 replacement of Nav table ("Whse. Shipping Driver")
        RecDriver2: Record Driver107FDW; // BC Upgrade SHUKLP03 replacement of Nav table ("Whse. Shipping Driver")
        SetShipmentStatus: Option Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;
        OnlyNewLines: Boolean;
        GroupedSalesLine: Record "Warehouse Shipment Line" temporary;
        ShipmentdateFilter: Text[50];
        RouteFilter: Code[20];
        ShipmentDateCheck: Date;
        RouteCheck: Code[20];
        SalesLineUpdate: Record "Warehouse Shipment Line";
        SalesLineCheck: Record "Warehouse Shipment Line";
        SalesHeader: Record "Warehouse Shipment Header";
        // UomQtyCodeMgt: Codeunit "UOM Qty.Code Mgt."; // BC Upgrade BHARDA11 ----Drink-IT Codeunit (UOM Qty.Code Mgt.)
        ShortcutQtyUomValue: array[3] of Decimal;
        UOMEquivalent1: Decimal;
        UOMEquivalent2: Decimal;
        UOMEquivalent3: Decimal;
        WhseSetup: Record "Warehouse Setup";
        UOMEquivalent1Caption: Text[50];
        UOMEquivalent2Caption: Text[50];
        UOMEquivalent3Caption: Text[50];
        UOMEquivalent1lbl: TextConst ENU = 'Quantity (Base) %1', FRA = 'Quantité (Base) %1';
        UOMEquivalent2lbl: TextConst ENU = 'Quantity (Base) %1', FRA = 'Quantité (Base) %1';
        UOMEquivalent3lbl: TextConst ENU = 'Quantity (Base) %1', FRA = 'Quantité (Base) %1';
        TrailerCaptionLbl: TextConst ENU = 'Trailer', FRA = 'Remorque';
        UOMEquivalent: array[3] of Decimal;
        TestInt: Decimal;
        TestCode: Code[20];
        Text010: Label 'Net Weight';
        Text011: Label 'Gross Weight';
        TruckCodeSalesHdr: Code[50];
        Driver2CodeSalesHdr: Code[50];
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        DriverCodeSalesHdr: Code[50];
        RoutePlanningNoCaptionLbl: TextConst ENU = 'Route Planning No.', FRA = 'N° planification d''itinéraire';
        ShipmentNoCaptionLbl: TextConst ENU = 'Shipment No.', FRA = 'N° d''Expédition';
        LocationCodeCaptionLbl: TextConst ENU = 'Location Code', FRA = 'Code du magasin';
        ZoneCaptionLbl: Label 'Zone Code';
        LotSerialInfoCaptionLbl: Label 'Lot/Serial Information';
        RoutePlanningNo: Code[20];
        WarehouseShipmentNo: Code[20];
        RoutePlanningWorksheet: Record RoutePlanningWork107FDW; // BC Upgrade BHARDA11 ----Drink-IT Record(Route Planning Worksheet)
                                                                // RoutePlanningWorksheet1: Record

        RoutePlanningLocationNo: Code[20];
        LocationCodeWhseShpHdr: Code[20];
        Location: Record Location;
        LocName: Text;
        LocAddress: Text;
        LocCity: Text;
        CreatePick: Codeunit "Create Pick";
        tempWhseItemTrackingLine: Record "Whse. Item Tracking Line" temporary;
        tempWhseItemTrackingLine_SpliteSourceOrder: Record "Whse. Item Tracking Line" temporary;
        LotNoCnt: Integer;
        LastWhseItemTrkgLineNo: Integer;
        TrackingText: Text;
        LotNoQty: Decimal;
        SortingMethod: Option Description,"Item No","Shelf No";
        SortBy: Integer;
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        TempExtendedTextLine: Record "Extended Text Line" temporary;
        ExtendedText1: Text;
        WarehouseEmployee: Code[20];
        WarehouseResponsible: Code[20];
        SignatureEmpPickingCaptionLbl: TextConst ENU = 'Signature Warehouse employee', FRA = 'Signature Employé Entrepôt';
        SignatureResPickingCaptionLbl: TextConst ENU = 'Signature Warehouse responsible for picking', FRA = 'Signature responsable Entrepôt';
        WarehouseemployeeCaptionLbl: TextConst ENU = 'Warehouse employee:', FRA = 'Employé d''entrepôt:';
        WarehouserespCaptionLbl: TextConst ENU = 'Warehouse resp.:', FRA = 'Responsable Entrepôt:';
        NoPrintedCaptionLbl: TextConst ENU = 'No. Printed', FRA = 'N° impression';
        NoPrintedCountHdr: Integer;
        tempWarehouseShipmentLine: Record "Warehouse Shipment Line" temporary;
        tempWarehouseShipmentLine_SourceNo: Record "Warehouse Shipment Line" temporary;
        WareShipLine: Record "Warehouse Shipment Line";
        SpliteLinePerOrder: Boolean;
        SalesHeader1: Record "Sales Header";
        SpliteSourceOrder_TrackingText: Text;
        tempWareHsShipLine: Record "Warehouse Shipment Line" temporary;
        SalesQty: Decimal;
        SalesHeaderSO: Record "Sales Header";
        ItemLedgEntry: Record "Item Ledger Entry";
        ExpDate: Date;
        User: Record User;
        WarehouseEmployeeName: Text[80];
        WarehouseResponsibleName: Text[80];
        // QualityManagement: Codeunit "Quality Management"; // BC Upgrade BHARDA11 ----Drink-IT Codeunit (Quality Management)
        LotNo: Code[20];
        TempReservationEntry: Record "Reservation Entry" temporary;
        ReservationEntry: Record "Reservation Entry";
        TrackingTextRE: Text[50];
        LotNoQtyRE: Decimal;
        ExtendedText1RE: Text[50];
        tempordernum: Text;
        SpliteOrder_Qty: Decimal;
        IUOM_Qtyperum: Decimal;
        TempUnitOfMeasure: Record "Aging Band Buffer" temporary;
        CompanyInfo4: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        GroupBy: Option Item,"Order";
        SplitEnabled: Boolean;
        TrackingText2: Text;
        TrackingText1: Text;
        RecTruck: Record Vehicle101FDW; // BC Upgrade SHUKLP03 << Nav table replacement Record(Whse. Shipping Truck)
        tempTO: Record "Transfer Header" temporary;
        tempSO: Record "Sales Header" temporary;
        TransferHeaderTO: Record "Transfer Header";
        ShowTO: Boolean;
        ShowSO: Boolean;
        LotNoTemp: Code[20];
        Direction: Option Outbound,Inbound;
        TransferLine: Record "Transfer Line";
        TempReservationEntry2: Record "Reservation Entry" temporary;
        tempEntryNo: Integer;
        SerialNoTemp: Code[20];
        EntryType: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output,,,,Warehouse,Production;

    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean; DisplayAsmInfo: Boolean);
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        ArchiveDocument := ArchiveDocumentFrom;
        LogInteraction := LogInteractionFrom;
        Print := PrintFrom;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10];
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.GET(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10];
    begin
        exit(PADSTR('', 2, ' '));
    end;

    procedure InsertCommentLine(Comment: Text);
    begin
        TempCommentLine.INIT;
        TempCommentLine."Line No." := CommentLineNo;
        TempCommentLine.Comment := Comment;
        TempCommentLine.INSERT;
        CommentLineNo += 10000;
    end;

    procedure SetTempWhseItemTrkgLine(SourceID: Code[20]; SourceType: Integer; SourceBatchName: Code[10]; SourceProdOrderLine: Integer; ItemNo: Code[20]; LocationCode: Code[10]);
    var
        WhseItemTrackingLine: Record "Whse. Item Tracking Line";
    begin
        tempWhseItemTrackingLine.DELETEALL;
        tempWhseItemTrackingLine.INIT;
        //WhseItemTrkgLineCount := 0; //NAIKH01
        //WhseItemTrkgExists := FALSE;
        WhseItemTrackingLine.RESET;
        WhseItemTrackingLine.SETCURRENTKEY(
          "Source ID", "Source Type", "Source Subtype", "Source Batch Name",
          "Source Prod. Order Line", "Source Ref. No.", "Location Code");
        WhseItemTrackingLine.SETRANGE("Source ID", SourceID);
        WhseItemTrackingLine.SETRANGE("Source Type", SourceType);
        WhseItemTrackingLine.SETRANGE("Source Batch Name", SourceBatchName);
        WhseItemTrackingLine.SETRANGE("Source Prod. Order Line", SourceProdOrderLine);
        //WhseItemTrackingLine.SETRANGE("Source Ref. No.",SourceRefNo);
        WhseItemTrackingLine.SETRANGE("Item No.", ItemNo);
        WhseItemTrackingLine.SETRANGE("Location Code", LocationCode);
        if WhseItemTrackingLine.FIND('-') then
            repeat
                if WhseItemTrackingLine."Quantity (Base)" > 0 then begin
                    tempWhseItemTrackingLine := WhseItemTrackingLine;
                    tempWhseItemTrackingLine."Entry No." := LastWhseItemTrkgLineNo + 1;
                    tempWhseItemTrackingLine.INSERT;
                    LastWhseItemTrkgLineNo := tempWhseItemTrackingLine."Entry No.";
                    //WhseItemTrkgExists := TRUE;
                    //   WhseItemTrkgLineCount += 1;
                end;
            until WhseItemTrackingLine.NEXT = 0;
        /*
        SourceWhseItemTrackingLine.INIT;
        SourceWhseItemTrackingLine."Source Type" := SourceType;
        SourceWhseItemTrackingLine."Source ID" := SourceID;
        SourceWhseItemTrackingLine."Source Batch Name" := SourceBatchName;
        SourceWhseItemTrackingLine."Source Prod. Order Line" := SourceProdOrderLine;
        SourceWhseItemTrackingLine."Source Ref. No." := SourceRefNo;
        
        // <<DITW16.00.00.40 DDR 14/03/2012 DIT-715 #274
        WhseSSCCTrkgExists := FALSE;
        IF SSCCSetup.READPERMISSION THEN BEGIN
          SCCreatePick.SetTempWhseItemTrkgLine(
            SourceID,SourceType,SourceBatchName,SourceProdOrderLine,SourceRefNo,LocationCode);
          WhseSSCCTrkgExists := SCCreatePick.IsWhseItemTrkgExists();
        END;
        // >>DITW16.00.00.40 DDR DIT-715 #274
        */

    end;

    procedure GetPostedTrackingText(var TrackingSpecification: Record "Whse. Item Tracking Line") TrackingText: Text[50];
    var
        Text000: TextConst ENU = 'LN', FRA = 'NL';
        Text001: TextConst ENU = 'SN', FRA = 'NS';
    begin
        TrackingText := '';
        if TrackingSpecification."Lot No." <> '' then
            TrackingText := STRSUBSTNO('%1 %2', Text000, TrackingSpecification."Lot No.");
        if TrackingSpecification."Serial No." <> '' then
            if TrackingSpecification."Lot No." <> '' then
                TrackingText := STRSUBSTNO('%1, %2 %3', TrackingText, Text001, TrackingSpecification."Serial No.")
            else
                TrackingText := STRSUBSTNO('%1 %2', Text001, TrackingSpecification."Serial No.");
    end;

    local procedure NoPrintedCount(WarehouseShipmentHeader1: Record "Warehouse Shipment Header");
    var
        WareHouseShipHdr: Record "Warehouse Shipment Header";
    begin
        WareHouseShipHdr.RESET;
        WareHouseShipHdr.SETRANGE("No.", WarehouseShipmentHeader1."No.");
        if WareHouseShipHdr.FINDFIRST then begin
            WareHouseShipHdr."No. Printed Combined Pick FND" := WarehouseShipmentHeader1."No. Printed Combined Pick FND" + 1;
            WareHouseShipHdr.MODIFY;
            COMMIT;
        end;
    end;

    procedure SetTempWhseItemTrkgLine_SpliteSourceOrder(SourceID: Code[20]; SourceType: Integer; SourceBatchName: Code[10]; SourceProdOrderLine: Integer; SourceRefNo: Integer; LocationCode: Code[10]);
    var
        WhseItemTrackingLine: Record "Whse. Item Tracking Line";
    begin
        tempWhseItemTrackingLine_SpliteSourceOrder.DELETEALL;
        tempWhseItemTrackingLine_SpliteSourceOrder.INIT;
        WhseItemTrackingLine.RESET;
        WhseItemTrackingLine.SETCURRENTKEY(
          "Source ID", "Source Type", "Source Subtype", "Source Batch Name",
          "Source Prod. Order Line", "Source Ref. No.", "Location Code");
        WhseItemTrackingLine.SETRANGE("Source ID", SourceID);
        WhseItemTrackingLine.SETRANGE("Source Type", SourceType);
        WhseItemTrackingLine.SETRANGE("Source Batch Name", SourceBatchName);
        WhseItemTrackingLine.SETRANGE("Source Prod. Order Line", SourceProdOrderLine);
        WhseItemTrackingLine.SETRANGE("Source Ref. No.", SourceRefNo);
        WhseItemTrackingLine.SETRANGE("Location Code", LocationCode);
        if WhseItemTrackingLine.FIND('-') then
            repeat
                if WhseItemTrackingLine."Quantity (Base)" > 0 then begin
                    tempWhseItemTrackingLine_SpliteSourceOrder := WhseItemTrackingLine;
                    tempWhseItemTrackingLine_SpliteSourceOrder."Entry No." := LastWhseItemTrkgLineNo + 1;
                    tempWhseItemTrackingLine_SpliteSourceOrder.INSERT;
                    LastWhseItemTrkgLineNo := tempWhseItemTrackingLine_SpliteSourceOrder."Entry No.";
                end;
            until WhseItemTrackingLine.NEXT = 0;
    end;
}

