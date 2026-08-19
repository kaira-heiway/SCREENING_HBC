report 53016 "Delivery Note TNG"
{
    // version DITW110.00.08,HEI.02

    // DITW17.00.02 RPG 28/11/2013 DIT-770 #235 New Report for Delivery Note from Shipment
    // DITW17.00.02 AT 07/01/2014 DIT-770 #235 Cosmetic Changes & Bug Fix
    // DITW17.10.05 MSF 06/10/2014 DIT-770 #943  Add DataItem  Tracking
    //                                           Modify Layout
    // DITW17.10.05 MSF 08/10/2014 DIT-770 #943 Adjust layout
    // DITW17.10.05 MSF 09/10/2014 DIT-770 #943 Adjust layout
    // DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 "Trailer Code"
    // DITW18.00.06 MSF 08/09/2015 DIT-770 #1533 Print Empty Good depending on Setup in customer Card
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // 
    // HEI.01 FDD-SLSGAP001 IBM NASTAA02 07.09.2017 # MDM Customer Card
    //   # Increased "CustAddr" and "ShipToAddr" global variables length from 50 to 60 characters
    // 
    // FCE01 22.02.2018 - Added fields for Tax purpose . Using Telx Anser like they do now for te NIS value.
    //                  - Introduced an initial Language value taken from the Company Setup.
    //                  - VATText should come from the Shipping Location . We may assume that 1 location is used for the Delivery Note
    // HEI.02 Bugfixing IBM NASTAA02 23.02.2018 # Local Algeria
    //    # Added Company NRC, NIF, NART and NIS
    //    # Added Customer NRC, NIF, NART and NIS
    // 
    // HEI.03 DefectID1370 IBM HORTOC01
    //    # Change customer address format
    // 
    // HEI.04 Bugfixing IBM NASTAA02 14.03.2018 # Bugfixing Algeria
    //   # Used "Home Page" from locations to fill in the Registre of Commerce in the Company info
    //   # Deleted NIF, NIS and NRC from the footer
    // HEI.05 DefectID1370 IBM HORTOC01
    //   #display Invoice no on document
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID - 50065
    // 2. Function FindInteractTmplCode is obsolete in Business central , so we are using FindInteractionTemplateCode.
    // 3. Change Language To LanguageMgt and Record to codeunit and use function GetLanguageID.
    // 4. Add layout path and Change extension RDLC to RDL.
    // 5. Remove Drink-IT Fields in Dataset and layout ("Tax Registration No.",,"Picking Type",Route,"Driver Code","Driver 2 Code")
    // 6. Remove Drink-IT Customization.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Delivery Note TNG.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    Caption = 'Sales - Shipment';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Shipment';
            column(No_SalesShptHeader; "No.")
            {
            }
            column(Norriq_ShowLotSN; ShowLotSN)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(InvoiceNo; InvoiceNo)
                    {
                    }
                    column(ReprintedText; ReprintedText)
                    {
                    }
                    column(CompanyInfoName; CompanyInfo.Name)
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(SalesShptCopyText; STRSUBSTNO(Text002, CopyText))
                    {
                    }
                    column(ShipToAddr1; ShipToAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyInfo.Name)
                    {
                    }
                    column(ShipToAddr2; ShipToAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(ShipToAddr6; ShipToAddr[6])
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVATRegtnNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoVATRegtnNoCaption; CompanyInfo.FIELDCAPTION("VAT Registration No."))
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankNameCaption; CompanyInfo.FIELDCAPTION("Bank Name"))
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(CompanyInfo_NIF; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo_NART; CompanyInfo."Telex Answer Back")
                    {
                    }
                    // BC Upgrade BHARDA11 >> ---Drink-IT Field("Tax Registration No.")
                    // column(CompanyInfo_NIS; CompanyInfo."Tax Registration No.")
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ---Drink-IT Field("Tax Registration No.")

                    column(CompanyInfo_NRC; CompanyNRC)
                    {
                    }
                    column(Customer_NRC; CustomerAttributes."Registre de Commerce")
                    {
                    }
                    column(Customer_NART; CustomerAttributes."Article d'imposition")
                    {
                    }
                    column(Customer_NIF; Customer."VAT Registration No.")
                    {
                    }
                    // BC Upgrade BHARDA11 >> ---Drink-IT Field("Tax Registration No.")
                    // column(Customer_NIS; Customer."Tax Registration No.")
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ---Drink-IT Field("Tax Registration No.")

                    column(SelltoCustNo_SalesShptHeader; "Sales Shipment Header"."Sell-to Customer No.")
                    {
                    }
                    column(DocDate_SalesShptHeader; FORMAT("Sales Shipment Header"."Document Date", 0, 4))
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
                    column(YourRef_SalesShptHeader; "Sales Shipment Header"."Your Reference")
                    {
                    }
                    column(ShipToAddr7; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr8; ShipToAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(ShptDate_SalesShptHeader; FORMAT("Sales Shipment Header"."Shipment Date", 0, 4))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ItemTrackingAppendixCaption; ItemTrackingAppendixCaptionLbl)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption; BankAccNoCaptionLbl)
                    {
                    }
                    column(ShipmentNoCaption; ShipmentNoCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(EmailCaption; EmailCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(SelltoCustNo_SalesShptHeaderCaption; "Sales Shipment Header".FIELDCAPTION("Sell-to Customer No."))
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
                    column(ExtDocNoCaption; ExtDocNoCaptionLbl)
                    {
                    }
                    column(ExtDocNo; "Sales Shipment Header"."External Document No.")
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
                    column(ShippingAgentCode; "Sales Shipment Header"."Shipping Agent Code")
                    {
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field(Route)
                    // column(RouteCaption; "Sales Shipment Header".FIELDCAPTION(Route))
                    // {
                    // }
                    // column(Route; "Sales Shipment Header".Route)
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Field(Route)

                    column(Driver1Caption; Driver1CaptionLbl)
                    {
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field("Driver Code") , Also this field has been removed from the layout
                    // column(Driver1; "Sales Shipment Header"."Driver Code")
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Field("Driver Code") Also this field has been removed from the layout

                    column(Driver2Caption; Driver2CaptionLbl)
                    {
                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field("Driver 2 Code") Also this field has been removed from the layout
                    // column(Driver2; "Sales Shipment Header"."Driver 2 Code")
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Field("Driver 2 Code") Also this field has been removed from the layout

                    column(TruckCaption; TruckCaptionLbl)
                    {

                    }
                    // BC Upgrade BHARDA11 >> ----Drink-IT Customization and fields
                    // column(TrailerCaption; TrailerCaptionLbl)
                    // {
                    //     Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035';
                    // }

                    // column(Trailer; "Sales Shipment Header"."Trailer Code")
                    // {
                    //     Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035';
                    // }
                    // column(Truck; "Sales Shipment Header"."Truck Code")
                    // {
                    // }
                    // column(TruckZoneCaption; "Sales Shipment Header".FIELDCAPTION("Truck Zone"))
                    // {
                    // }
                    // column(TruckZone; "Sales Shipment Header"."Truck Zone")
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Customization and fields
                    column(GrossWt; GrossWt)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(NetWt; NetWt)
                    {
                        DecimalPlaces = 0 : 5;
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
                    column(GrossWtCaption; SalesShptLine.FIELDCAPTION("Gross Weight"))
                    {
                    }
                    column(NetWtCaption; SalesShptLine.FIELDCAPTION("Net Weight"))
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
                    column(ChauffeurleCaption; ChauffeurLeLbl)
                    {
                    }
                    column(VisaClientLeCaption; VisaClientLeLbl)
                    {
                    }
                    column(OrderNo_SalesShptHeader; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(OrderNo_SalesShptHeaderCaption; "Sales Shipment Header".FIELDCAPTION("Order No."))
                    {
                    }
                    column(ShiptoAddrKeyNo; ShiptoAddrKeyNo)
                    {
                    }
                    // BC Upgrade BHARAD11 >> -----Drink-IT Fields("Picking Type")
                    // column(PickingTypeCaption; "Sales Shipment Header".FIELDCAPTION("Picking Type"))
                    // {
                    // }
                    // column(PickingType; "Sales Shipment Header"."Picking Type")
                    // {
                    // }
                    // BC Upgrade BHARAD11 << -----Drink-IT Fields("Picking Type")
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
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field("Tax Registration No.")
                    // column(CompanyTaxNo; CompanyInfo."Tax Registration No.")
                    // {
                    // }
                    // BC Upgrade BHARDA11 << ----Drink-IT Field("Tax Registration No.")
                    column(VatRegNumber; gTxtVATRegistration)
                    {
                    }
                    column(NIS_Value; CompanyInfo."Telex Answer Back")
                    {
                    }
                    column(SalesShipmentHeader_LocationCode; "Sales Shipment Header"."Location Code")
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1; %2 - %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL DimSetEntry1.NEXT = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Description_SalesShptLine; Description)
                        {
                        }
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(ShowCorrectionLines; ShowCorrectionLines)
                        {
                        }
                        column(Type_SalesShptLine; FORMAT(Type, 0, 2))
                        {
                        }
                        column(AsmHeaderExists; AsmHeaderExists)
                        {
                        }
                        column(DocumentNo_SalesShptLine; "Document No.")
                        {
                        }
                        column(LinNo; LinNo)
                        {
                        }
                        column(Qty_SalesShptLine; Quantity)
                        {
                        }
                        column(UOM_SalesShptLine; "Unit of Measure Code")
                        {
                        }
                        column(No_SalesShptLine; "No.")
                        {
                        }
                        column(LineNo_SalesShptLine; "Line No.")
                        {
                        }
                        column(Description_SalesShptLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(Qty_SalesShptLineCaption; QtyCaptionLbl)
                        {
                        }
                        column(UOM_SalesShptLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(No_SalesShptLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(LocationCaption; LocationCaptionLbl)
                        {
                        }
                        column(Location_SalesShptLine; "Location Code")
                        {
                        }
                        column(TotalHLCaption; TotalHLCaptionLbl)
                        {
                        }
                        // BC Upgrade BHARDA11 >> ----Drink-IT Field("Free Item")
                        // column(FreeItem; "Free Item")
                        // {
                        // }
                        // BC Upgrade BHARDA11 << ----Drink-IT Field("Free Item")
                        column(FreeReasonDesc; FreeReasonDesc)
                        {
                        }
                        // BC Upgrade BHARDA11 >> ----Drink-IT Field("Item Charge Calculate per")
                        // column(ItemChargeCalcPer; FORMAT("Item Charge Calculate per", 0, 2))
                        // {
                        // }
                        // BC Upgrade BHARDA11 << ----Drink-IT Field("Item Charge Calculate per")
                        column(LineQtyinHL; LineQtyinHL)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(Desc2_SalesShptLine; "Description 2")
                        {
                        }
                        column(Description2_SalesShptLineCaption; FIELDCAPTION("Description 2"))
                        {
                        }
                        dataitem(Tracking; Integer)
                        {
                            column(Norriq_entryNo; TrackingSpecBuffer."Entry No.")
                            {
                            }
                            column(Norriq_LotNo; TrackingSpecBuffer."Lot No.")
                            {
                            }
                            column(Norriq_SerialNo; TrackingSpecBuffer."Serial No.")
                            {
                            }
                            column(Norriq_SerialNo_Caption; TrackingSpecBuffer.FIELDCAPTION("Serial No."))
                            {
                            }
                            column(Norriq_LotNo_caption; TrackingSpecBuffer.FIELDCAPTION("Lot No."))
                            {
                            }
                            column(Norriq_Qty; TrackingSpecBuffer."Quantity (Base)")
                            {
                            }
                            column(Norriq_Qtybasecaption; TrackingSpecBuffer.FIELDCAPTION("Quantity (Base)"))
                            {
                            }
                            column(Norriq_Source; TrackingSpecBuffer."Source Ref. No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                //<<DITW17.10.05 MSF 09/10/2014 DIT-770 #943
                                IF Number = 1 THEN
                                    TrackingSpecBuffer.FINDFIRST
                                ELSE
                                    TrackingSpecBuffer.NEXT;
                                //>>DITW17.10.05 MSF 09/10/2014 DIT-770 #943
                            end;

                            trigger OnPreDataItem()
                            begin
                                //<DITW17.10.05 MSF 06/10/2014 DIT-770 #943
                                TrackingSpecBuffer.RESET;

                                //<<DITW17.10.05 MSF 09/10/2014 DIT-770 #943
                                TrackingSpecBuffer.SETRANGE("Source Ref. No.", "Sales Shipment Line"."Line No.");
                                IF TrackingSpecBuffer.ISEMPTY THEN
                                    CurrReport.BREAK;
                                SETRANGE(Number, 1, TrackingSpecBuffer.COUNT);
                                //>>DITW17.10.05 MSF 09/10/2014 DIT-770 #94
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin


                            LinNo := "Line No.";
                            IF NOT ShowCorrectionLines AND Correction THEN
                                CurrReport.SKIP;

                            DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");
                            IF DisplayAssemblyInformation THEN
                                AsmHeaderExists := AsmToShipmentExists(PostedAsmHeader);

                            //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                            FreeReasonDesc := '';
                            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Free Item","Free Reason Code","Item Charge Type","Empty Goods Item No.")
                            // IF "Free Item" THEN
                            //     IF FreeReasonCode.GET("Free Reason Code") THEN
                            //         FreeReasonDesc := FreeReasonCode.Description
                            //     ELSE
                            //         FreeReasonDesc := 'Free';
                            // IF ("Item Charge Type" = "Item Charge Type"::Deposit) AND ("Empty Goods Item No." <> '') THEN BEGIN
                            //     //<<MSF

                            //     IF EmptyDetailsExists THEN BEGIN
                            //         //<<Empty Goods Details
                            //         TempSalesShptLine.RESET;
                            //         TempSalesShptLine.SETRANGE("Document No.", "Document No.");
                            //         TempSalesShptLine.SETFILTER("Empty Goods Item No.", '%1', "Empty Goods Item No.");
                            //         TempSalesShptLine.SETRANGE("Item Charge Type", "Item Charge Type");
                            //         IF NOT TempSalesShptLine.FINDSET THEN BEGIN
                            //             TempSalesShptLine.INIT;
                            //             TempSalesShptLine := "Sales Shipment Line";
                            //             TempSalesShptLine.Quantity := 0;  //Qty Shipped
                            //             TempSalesShptLine."Quantity (Base)" := 0;  //Qty Returned
                            //             TempSalesShptLine.Amount := 0;  //Value Shipped
                            //             TempSalesShptLine."Amount Including VAT" := 0;  //Value Returned
                            //             TempSalesShptLine."Line Amount" := 0;  //Deposit
                            //             TempSalesShptLine."Gross Weight" := 0;
                            //             TempSalesShptLine."Net Weight" := 0;
                            //             IF Quantity > 0 THEN BEGIN
                            //                 TempSalesShptLine.Quantity := Quantity;
                            //                 TempSalesShptLine.Amount := "Line Amount";
                            //             END ELSE BEGIN
                            //                 TempSalesShptLine."Quantity (Base)" := -Quantity;
                            //                 TempSalesShptLine."Amount Including VAT" := -"Line Amount";
                            //             END;
                            //             TempSalesShptLine."Line Amount" := "Line Amount";
                            //             IF Item.GET("Sales Shipment Line"."Empty Goods Item No.") THEN
                            //                 TempSalesShptLine.Description := Item.Description;
                            //             TempSalesShptLine.INSERT;
                            //         END ELSE BEGIN
                            //             IF Quantity > 0 THEN BEGIN
                            //                 TempSalesShptLine.Quantity += Quantity;
                            //                 TempSalesShptLine.Amount += "Line Amount";
                            //             END ELSE BEGIN
                            //                 TempSalesShptLine."Quantity (Base)" += -Quantity;
                            //                 TempSalesShptLine."Amount Including VAT" += -"Line Amount";
                            //             END;
                            //             TempSalesShptLine."Line Amount" += "Line Amount";
                            //             TempSalesShptLine.MODIFY;
                            //         END;
                            //     END;
                            // END;
                            // BC Upgrade BHARDA11 << ----Drink-IT Field("Free Item","Free Reason Code","Item Charge Type","Empty Goods Item No.")
                            //>>Empty Goods Details

                            LineQtyinHL := 0;
                            IF Type = Type::Item THEN BEGIN
                                IF Quantity = 0 THEN
                                    CurrReport.SKIP;
                                //IF Item.GET("No.") THEN BEGIN
                                //  Item.CALCFIELDS("As Empty Good");
                                //  IF Item."As Empty Good" THEN
                                //    CurrReport.SKIP;
                                //END;

                                // LineQtyinHL := Quantity * "Unit Volume HL"; // BC Upgrade BHARDA11 ---Drink-IT Field("Unit Volume HL")
                                LineQtyinHL := Quantity;
                            END;
                            //>>DITW17.00.02 RPG DIT-770 #235
                        end;

                        trigger OnPostDataItem()
                        begin
                            // Item Tracking:

                            //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                            //<<Empty Goods Details
                            TempSalesShptLine.RESET;
                            IF TempSalesShptLine.FINDSET THEN
                                REPEAT
                                    TempSalesShptLine."Unit Volume" := TempSalesShptLine.Quantity - TempSalesShptLine."Quantity (Base)";  //Deposit Difference
                                    TempSalesShptLine.MODIFY;
                                UNTIL TempSalesShptLine.NEXT = 0;
                            //>>Empty Goods Details
                            //>>DITW17.00.02 RPG DIT-770 #235
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(Comments; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Comment; TempCommentLine.Comment)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                TempCommentLine.FINDFIRST
                            ELSE
                                TempCommentLine.NEXT;
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempCommentLine.RESET;
                            SETRANGE(Number, 1, TempCommentLine.COUNT);
                        end;
                    }
                    dataitem(EmptyGoodsDetails; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        // BC Upgrade BHARDA11 >> ----Drink-IT Field("Empty Goods Item No.")
                        // column(EmptyGoodsItemNo; TempSalesShptLine."Empty Goods Item No.")
                        // {
                        // }
                        // BC Upgrade BHARDA11 << ----Drink-IT Field("Empty Goods Item No.")
                        column(EmptyGoodsItemDesc; TempSalesShptLine.Description)
                        {
                        }
                        column(DepositQtyShipped; TempSalesShptLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(DepositQtyReturned; TempSalesShptLine."Quantity (Base)")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(DepositDifference; TempSalesShptLine."Unit Volume")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(EmptyGoodsDetailsCaption; EmptyGoodsDetailsCaptionLbl)
                        {
                        }
                        column(DepositQtyShippedCptn; DepositQtyShippedCaptionLbl)
                        {
                        }
                        column(DepositQtyReturnedCptn; DepositQtyReturnedCaptionLbl)
                        {
                        }
                        column(DepositDifferenceCptn; DepositDifferenceCaptionLbl)
                        {
                        }
                        column(EmptyGoodsDescCaption; TempSalesShptLine.FIELDCAPTION(Description))
                        {
                        }
                        column(EmptyGoodsItemNoCaption; TempSalesShptLine.FIELDCAPTION("No."))
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                TempSalesShptLine.FINDFIRST
                            ELSE
                                TempSalesShptLine.NEXT;
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempSalesShptLine.RESET;
                            SETRANGE(Number, 1, TempSalesShptLine.COUNT);
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        // Item Tracking:
                        IF ShowLotSN THEN BEGIN
                            TrackingSpecCount := 0;
                            OldRefNo := 0;
                            ShowGroup := FALSE;
                        END;

                        //HEI.02>>
                        IF Customer.GET("Sales Shipment Header"."Sell-to Customer No.") THEN
                            IF CustomerAttributes.GET(Customer."No.") THEN;
                        //HEI.02<<
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := Text001;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;
                    //HEI.01>>
                    IF "Sales Shipment Header"."No. Printed" > 0 THEN
                        ReprintedText := 'REPRINTED';
                    //HEI.01<<
                    TotalQty := 0;           // Item Tracking

                    //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                    TempSalesShptLine.DELETEALL;
                    //>>DITW17.00.02 RPG DIT-770 #235
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        ShptCountPrinted.RUN("Sales Shipment Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 1 + ABS(NoOfCopies);
                    CopyText := '';
                    ReprintedText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                lRecSalesShipmentLines: Record "Sales Shipment Line";
                lRecLocation: Record Location;
            begin
                // FCD CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                // FCE01- Get the Shipment Location from the Lines - Assume 1 location!!!!
                CLEAR(gTxtVATRegistration);
                lRecSalesShipmentLines.SETRANGE(lRecSalesShipmentLines."Document No.", "Sales Shipment Header"."No.");
                lRecSalesShipmentLines.SETFILTER(lRecSalesShipmentLines."Location Code", '<>%1', '');
                IF lRecSalesShipmentLines.FINDFIRST THEN BEGIN
                    lRecLocation.GET(lRecSalesShipmentLines."Location Code");
                    // gTxtVATRegistration := lRecLocation."VAT Registration No."; // BC Upgrade BHARDA11 ----Drink-IT Field("VAT Registration No.")
                END;
                IF gTxtVATRegistration = '' THEN
                    gTxtVATRegistration := CompanyInfo."VAT Registration No.";

                IF Location.GET("Location Code") THEN; //HEI.04
                /*
                // FCE01+
                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                  FormatAddr.RespCenter(CompanyAddr,RespCenter);
                  CompanyInfo."Phone No." := RespCenter."Phone No.";
                  CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                  FormatAddr.Company(CompanyAddr,CompanyInfo);
                */
                SalesShipmentLine.RESET;
                SalesShipmentLine.SETRANGE("Document No.", "Sales Shipment Header"."No.");
                SalesShipmentLine.SETFILTER("Location Code", '<>%1', '');
                IF SalesShipmentLine.FINDFIRST THEN BEGIN
                    LocationAddr.GET(SalesShipmentLine."Location Code");
                    CompanyNRC := LocationAddr."Home Page";
                    HeinekenGlobal.FormatAddrLocation(CompanyAddr, LocationAddr)//CH
                END ELSE BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    CompanyNRC := CompanyInfo."Home Page";
                END;
                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");
                // BC Upgrade BHARAD11 >> ----Drink-IT Field and Drink-IT Customization("Barcode Position on Documents")
                //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                // BarcodeValueLeft := '';
                // BarcodeValueRight := '';
                // BarcodeValueCenter := '';
                // CASE CompanyInfo."Barcode Position on Documents" OF
                //     CompanyInfo."Barcode Position on Documents"::"No Barcode":
                //         ;
                //     CompanyInfo."Barcode Position on Documents"::Left:
                //         BarcodeValueLeft := "No.";
                //     CompanyInfo."Barcode Position on Documents"::Center:
                //         BarcodeValueCenter := "No.";
                //     CompanyInfo."Barcode Position on Documents"::Right:
                //         BarcodeValueRight := "No.";
                // END;

                //>>DITW17.00.02 RPG DIT-770 #235
                // BC Upgrade BHARAD11 >> ----Drink-IT Field("Barcode Position on Documents")
                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");

                //FormatAddr.SalesShptShipTo(ShipToAddr,"Sales Shipment Header");//HEI.03
                //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                //IF ShipToAddr[8] = '' THEN
                //  ShipToAddr[8] := FIELDCAPTION("Ship-to Address Key No.") + ' ' + "Ship-to Address Key No."
                //ELSE
                //  ShiptoAddrKeyNo := FIELDCAPTION("Ship-to Address Key No.") + ' ' + "Ship-to Address Key No.";
                //COMPRESSARRAY(ShipToAddr);

                //<<DITW17.00.02 AT 07/01/2014 DIT-770 #235
                // ShiptoAddrKeyNo := FIELDCAPTION("Ship-to Address Key No.") + ' ' + "Ship-to Address Key No."; // BC Upgrade BHARAD11 ----Drink-IT Customization
                //>>DITW17.00.02 AT 07/01/2014 DIT-770 #235
                //>>DITW17.00.02 RPG DIT-770 #235

                // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
                //FormatAddr.SalesShptBillTo(CustAddr,ShipToAddr,"Sales Shipment Header");HEI.03
                // >>DITW110.00.08 DDR NRQ#0
                //HEI.03>>
                Customer.GET("Sales Shipment Header"."Sell-to Customer No.");
                HeinekenGlobal.CustomerAddressFormat(Customer, ShipToAddr);
                ShowCustAddr := TRUE;
                //HEI.03<<


                /*
                ShowCustAddr := "Bill-to Customer No." <> "Sell-to Customer No.";
                FOR i := 1 TO ARRAYLEN(CustAddr) DO
                  IF CustAddr[i] <> ShipToAddr[i] THEN
                    ShowCustAddr := TRUE;
                */
                //<<DITW17.00.02 RPG 28/11/2013 DIT-770 #235
                SelltoContactPhoneNo := '';
                IF NOT Contact.GET("Sell-to Contact No.") THEN
                    CLEAR(Contact);
                SelltoContactPhoneNo := Contact."Phone No.";
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields and customization("Shortcut Unit of Measure1 Code","Shortcut Unit of Measure2 Code","Shortcut Unit of Measure3 Code")
                // UOMEquivalent1Caption := STRSUBSTNO(UOMEquivalent1lbl, WhseSetup."Shortcut Unit of Measure1 Code");
                // UOMEquivalent2Caption := STRSUBSTNO(UOMEquivalent2lbl, WhseSetup."Shortcut Unit of Measure2 Code");
                // UOMEquivalent3Caption := STRSUBSTNO(UOMEquivalent3lbl, WhseSetup."Shortcut Unit of Measure3 Code");
                // //<<DITW18.00.06 MSF 08/09/2015 DIT-770 #1533
                // IF NOT SelltoCust.GET("Sell-to Customer No.") THEN
                //     CLEAR(SelltoCust);
                //>>DITW18.00.06 MSF 08/09/2015 DIT-770 #1533
                // BC Upgrade BHARDA11 << ----Drink-IT Fields and customization("Shortcut Unit of Measure1 Code","Shortcut Unit of Measure2 Code","Shortcut Unit of Measure3 Code")

                GrossWt := 0;
                NetWt := 0;
                TotalQtyinHL := 0;
                UOMEquivalent1 := 0;
                UOMEquivalent2 := 0;
                UOMEquivalent3 := 0;
                SalesShptLine.RESET;
                SalesShptLine.SETRANGE("Document No.", "No.");
                SalesShptLine.SETRANGE(Type, SalesShptLine.Type::Item);
                IF SalesShptLine.FINDSET THEN
                    REPEAT
                        IF SalesShptLine.Quantity > 0 THEN BEGIN
                            GrossWt += SalesShptLine."Gross Weight" * SalesShptLine."Quantity (Base)";
                            NetWt += SalesShptLine."Net Weight" * SalesShptLine."Quantity (Base)";
                            //UomQtyCodeMgt.SalesShptLineCalcShortcuts(SalesShptLine,ShortcutQtyUomValue,SalesShptLine.FIELDNO("Quantity (Base)"));
                            // BC Upgrade BHARDA11 >> ----Drink-IT Fields and customization("Shortcut Unit of Measure1 Code","Shortcut Unit of Measure2 Code","Shortcut Unit of Measure3 Code")
                            // IF WhseSetup."Shortcut Unit of Measure1 Code" = SalesShptLine."Unit of Measure Code" THEN
                            //     UOMEquivalent1 += SalesShptLine."Quantity (Base)";
                            // IF WhseSetup."Shortcut Unit of Measure2 Code" = SalesShptLine."Unit of Measure Code" THEN
                            //     UOMEquivalent2 += SalesShptLine."Quantity (Base)";
                            // IF WhseSetup."Shortcut Unit of Measure3 Code" = SalesShptLine."Unit of Measure Code" THEN
                            //     UOMEquivalent3 += SalesShptLine."Quantity (Base)";
                            // BC Upgrade BHARDA11 << ----Drink-IT Fields and customization("Shortcut Unit of Measure1 Code","Shortcut Unit of Measure2 Code","Shortcut Unit of Measure3 Code")

                        END;
                        // TotalQtyinHL += SalesShptLine.Quantity * SalesShptLine."Unit Volume HL"; // BC Upgrade BHARAD11 ----Drink-IT Field("Unit Volume HL")
                        TotalQtyinHL += SalesShptLine.Quantity;
                    UNTIL SalesShptLine.NEXT = 0;

                EmptyDetailsExists := FALSE;
                // BC Upgrade BHARAD11 >> ----Drink-IT Customization
                // //<<DITW18.00.06 MSF 08/09/2015 DIT-770 #1533
                // IF (SelltoCust."Empty Goods Statement On" = SelltoCust."Empty Goods Statement On"::"Delivery Note") OR
                //  (SelltoCust."Empty Goods Statement On" = SelltoCust."Empty Goods Statement On"::"Invoice + Delivery Note") THEN BEGIN
                //     //>>DITW18.00.06 MSF 08/09/2015 DIT-770 #1533
                //     SalesShptLine.RESET;
                //     SalesShptLine.SETRANGE("Document No.", "No.");
                //     SalesShptLine.SETRANGE(Type, SalesShptLine.Type::"Charge (Item)");
                //     SalesShptLine.SETFILTER("Empty Goods Item No.", '<>%1', '');
                //     SalesShptLine.SETRANGE("Item Charge Type", SalesShptLine."Item Charge Type"::Deposit);
                //     IF NOT SalesShptLine.ISEMPTY THEN
                //         EmptyDetailsExists := TRUE;
                //     //<<DITW18.00.06 MSF 08/09/2015 DIT-770 #1533
                // END;
                // //>>DITW18.00.06 MSF 08/09/2015 DIT-770 #1533
                // BC Upgrade BHARAD11 << ----Drink-IT Customization
                TempCommentLine.DELETEALL;
                CommentLineNo := 10000;
                CommentLine.RESET;
                CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Customer);
                CommentLine.SETRANGE("No.", "Sell-to Country/Region Code");
                // CommentLine.SETRANGE("Print on Shipment", TRUE); // BC Upgrade BHARDA11 ----Drink-I Field("Print on Shipment")
                IF CommentLine.FINDSET THEN
                    REPEAT
                        InsertCommentLine(CommentLine.Comment);
                    UNTIL CommentLine.NEXT = 0;

                CommentLine.RESET;
                CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Customer);
                CommentLine.SETRANGE("No.", "Sell-to Customer No.");
                // CommentLine.SETRANGE("Print on Shipment", TRUE); // BC Upgrade BHARDA11 ----Drink-I Field("Print on Shipment")
                IF CommentLine.FINDSET THEN
                    REPEAT
                        InsertCommentLine(CommentLine.Comment);
                    UNTIL CommentLine.NEXT = 0;

                SalesCommentLine.RESET;
                SalesCommentLine.SETRANGE("Document Type", SalesCommentLine."Document Type"::Shipment);
                SalesCommentLine.SETRANGE("No.", "No.");
                // SalesCommentLine.SETRANGE("Print on Shipment", TRUE); // BC Upgrade BHARDA11 ----Drink-I Field("Print on Shipment")
                IF SalesCommentLine.FINDSET THEN
                    REPEAT
                        InsertCommentLine(SalesCommentLine.Comment);
                    UNTIL SalesCommentLine.NEXT = 0;
                // BC Upgrade BHARAD11 >> ----Drink-IT Fields("Delivery Time 1 To","Delivery Time 1 From","Delivery Time 2 To","Delivery Time 2 From")
                // IF "Delivery Time 1 To" <> 0T THEN
                //     DeliveryTime1 := FORMAT("Delivery Time 1 From") + ' to ' + FORMAT("Delivery Time 1 To")
                // ELSE
                //     DeliveryTime1 := FORMAT("Delivery Time 1 From");

                // IF "Delivery Time 2 To" <> 0T THEN
                //     DeliveryTime2 := FORMAT("Delivery Time 2 From") + ' to ' + FORMAT("Delivery Time 2 To")
                // ELSE
                //     DeliveryTime2 := FORMAT("Delivery Time 2 From");
                //>>DITW17.00.02 RPG DIT-770 #235
                // BC Upgrade BHARAD11 << ----Drink-IT Fields("Delivery Time 1 To","Delivery Time 1 From","Delivery Time 2 To","Delivery Time 2 From")

                // BC Upgrade BHARAD11 >> ----Drink-IT Code
                //<<DITW17.10.05 MSF 06/10/2014 DIT-770 #943
                // IF ShowLotSN THEN BEGIN
                //     ItemTrackingMgt.SetRetrieveAsmItemTracking(TRUE);
                //     TrackingSpecCount := ItemTrackingMgt.RetrieveDocumentItemTracking(TrackingSpecBuffer, "Sales Shipment Header"."No.",
                //          DATABASE::"Sales Shipment Header", 0);
                //     ItemTrackingMgt.SetRetrieveAsmItemTracking(FALSE);
                // END;
                //>>DITW17.10.05 MSF 06/10/2014 DIT-770 #943
                // BC Upgrade BHARAD11 << ----Drink-IT Code

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '');

                //HEI.05>>
                SalesShipmentLine.RESET;
                SalesShipmentLine.SETRANGE(Type, SalesShipmentLine.Type::Item);
                SalesShipmentLine.SETRANGE("Document No.", "No.");
                IF SalesShipmentLine.FINDFIRST THEN BEGIN
                    SalesShipmentLine.GetSalesInvLines(TempSalesInvoiceLine);
                    InvoiceNo := TempSalesInvoiceLine."Document No.";
                END;
                //HEI.05<<

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
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field("Show Correction Lines"; ShowCorrectionLines)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Correction Lines';
                    }
                    field(ShowLotSN; ShowLotSN)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Serial/Lot Number Appendix';
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Assembly Components';
                    }
                    field(PrintLanguage; PrintLanguage)
                    {
                        ApplicationArea = All;
                        TableRelation = Language;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
        lblCode = 'Code';
        lblDesignation = 'Description';
        lblQtyCharge = 'Qty';
        lblQteRec = 'Qty';
        lShipmentNo = 'Shipment No.';
        lShipAg = 'Agent maritime (Boat) Or Agent Logistic:';
        lDriver = 'Driver';
        lblTaxReg = 'Tax Registration no.';
        lblRegNo = 'RC No. :';
        lblIfNo = 'I.F No. :';
        lblArticleNo = 'Item No. :';
        lblNis = 'N.I.S.';
        lblLocationCode = 'Location code :';
        lblDateTime = 'Date & Time of Print';
    }

    trigger OnInitReport()
    begin
        CompanyInfo.
        GET;
        SalesSetup.GET;
        WhseSetup.GET;

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
        END;

        //<<DITW17.00.02 RPG 07/11/2013 DIT-770 #235
        CompanyInfo.GET;
        AddressLeft := FALSE;
        AddressRight := FALSE;
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Address Position on Documents")
        // CASE CompanyInfo."Address Position on Documents" OF
        //     CompanyInfo."Address Position on Documents"::Left:
        //         AddressLeft := TRUE;
        //     CompanyInfo."Address Position on Documents"::Right:
        //         AddressRight := TRUE;
        // END;
        // BC Upgrade BHARDA11 << ----Drink-IT Fields("Address Position on Documents")
        //>>DITW17.00.02 RPG DIT-770 #235

        // FCE01-
        PrintLanguage := CompanyInfo."Language Code FND";
        // FCE01+
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;
        AsmHeaderExists := FALSE;

        // FCE01-

        // CurrReport.LANGUAGE := Language.GetLanguageID(PrintLanguage); // BC Upgrade BHARDA11 ::Blocked
        CurrReport.LANGUAGE := LanguageMgt.GetLanguageID(PrintLanguage);

        // FCE01+
    end;

    var
        Text000: Label 'Salesperson';
        Text001: Label 'COPY';
        Text002: Label 'Delivery Note %1';
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        // Language: Record Language; // BC Upgrade BHARDA11 ---Blocked
        TrackingSpecBuffer: Record "Tracking Specification" temporary;
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        ShptCountPrinted: Codeunit "Sales Shpt.-Printed";
        SegManagement: Codeunit SegManagement;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        RespCenter: Record "Responsibility Center";
        ItemTrackingAppendix: Report "Item Tracking Appendix";
        CustAddr: array[8] of Text[60];
        ShipToAddr: array[8] of Text;
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[20];
        ReferenceText: Text[80];
        LanguageMgt: Codeunit Language; // BC Upgrade BHARDA11 
        MoreLines: Boolean;
        NoOfCopies: Integer;
        OutputNo: Integer;
        NoOfLoops: Integer;
        TrackingSpecCount: Integer;
        OldRefNo: Integer;
        OldNo: Code[20];
        CopyText: Text[30];
        ShowCustAddr: Boolean;
        i: Integer;
        FormatAddr: Codeunit "Format Address";
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        ShowCorrectionLines: Boolean;
        ShowLotSN: Boolean;
        ShowTotal: Boolean;
        ShowGroup: Boolean;
        TotalQty: Decimal;

        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmHeaderExists: Boolean;
        LinNo: Integer;
        ItemTrackingAppendixCaptionLbl: Label 'Item Tracking - Appendix';
        PhoneNoCaptionLbl: Label 'Phone No.';
        VATRegNoCaptionLbl: Label 'VAT Reg. No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankNameCaptionLbl: Label 'Bank';
        BankAccNoCaptionLbl: Label 'Account No.';
        ShipmentNoCaptionLbl: Label 'Shipment No.';
        ShipmentDateCaptionLbl: Label 'Shipment Date';
        HomePageCaptionLbl: Label 'Home Page';
        EmailCaptionLbl: Label 'E-Mail';
        DocumentDateCaptionLbl: Label 'Document Date';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        BilltoAddressCaptionLbl: Label 'Bill-to Address';
        QuantityCaptionLbl: Label 'Quantity';
        SerialNoCaptionLbl: Label 'Serial No.';
        LotNoCaptionLbl: Label 'Lot No.';
        DescriptionCaptionLbl: Label 'Description';
        NoCaptionLbl: Label 'No.';
        BarcodeValueLeft: Code[20];
        BarcodeValueRight: Code[20];
        BarcodeValueCenter: Code[20];
        Contact: Record Contact;
        SelltoCust: Record Customer;
        ShiptoAddrCust: Record "Ship-to Address";
        // FreeReasonCode: Record 2013788; // BC Upgrade BHARAD11 ----Drink-IT Table(2013788)
        FreeReasonDesc: Text[50];
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
        SalesShptLine: Record "Sales Shipment Line";
        TempSalesShptLine: Record "Sales Shipment Line" temporary;
        SelltoContactPhoneNo: Text[30];
        ExtDocNoCaptionLbl: Label 'External Document No.';
        SellToAddrCaptionLbl: Label 'Order Address';
        UOMCaptionLbl: Label 'UOM';
        TotalHLCaptionLbl: Label 'Total HL';
        DepositQtyShippedCaptionLbl: Label 'Qty Shipped';
        DepositQtyReturnedCaptionLbl: Label 'Qty Returned';
        DepositDifferenceCaptionLbl: Label 'Difference';
        EmptyGoodsDetailsCaptionLbl: Label 'Empty Goods Detail';
        TotalQtyInHLCaptionLbl: Label 'Quantity HL';
        CompanyInfoFaxNoCaptionLbl: Label 'Fax';
        CompanyInfoIBANCaptionLbl: Label 'IBAN';
        CompanyInfoSwiftCodeCaptionLbl: Label 'SWIFT Code';
        SelltoContactPhNoCaptionLbl: Label 'Sell-to Contact Phone No.';
        ShippingAgentCodeCaptionLbl: Label 'Shipping Agent';
        Driver1CaptionLbl: Label 'Driver 1';
        Driver2CaptionLbl: Label 'Driver 2';
        TruckCaptionLbl: Label 'Truck';
        LocationCaptionLbl: Label 'Location';
        ArrivalDateTimeCaptionLbl: Label 'Arrival Date/Time:';
        DepartureDateTimeCaptionLbl: Label 'Departure Date/Time:';
        BreakStartDateTimeCaptionLbl: Label 'Break Start Date/Time';
        BreakEndDateTimeCaptionLbl: Label 'Break End Date/Time';
        DriverNameCaptionLbl: Label 'Driver Name:';
        DriverName2CaptionLbl: Label 'Driver Name 2';
        DriverSignatureCaptionLbl: Label 'Driver Signature:';
        Driver2SignatureCaptionLbl: Label 'Driver 2 Signature';
        DriverCommentsCaptionLbl: Label 'Commentaires et observations sur la livraison et/ou réception :';
        Driver2CommentsCaptionLbl: Label 'Driver 2 Comments';
        CustomerSignatureCaptionLbl: Label 'Customer signature for goods receipt:';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address';
        DeliveryTime1: Text[100];
        DeliveryTime2: Text[100];
        ShiptoAddrKeyNo: Text[100];
        DeliveryTime1CaptionLbl: Label 'Delivery Time 1';
        DeliveryTime2CaptionLbl: Label 'Delivery Time 2';
        AddressLeft: Boolean;
        AddressRight: Boolean;
        QtyCaptionLbl: Label 'QTY';
        // UomQtyCodeMgt: Codeunit 2014067; // BC Upgrade BHARDA11 ----Drink-IT Codeunit
        ShortcutQtyUomValue: array[3] of Decimal;
        UOMEquivalent1: Decimal;
        UOMEquivalent2: Decimal;
        UOMEquivalent3: Decimal;
        WhseSetup: Record "Warehouse Setup";
        UOMEquivalent1Caption: Text[50];
        UOMEquivalent2Caption: Text[50];
        UOMEquivalent3Caption: Text[50];
        UOMEquivalent1lbl: Label 'Quantity (Base) %1';
        UOMEquivalent2lbl: Label 'Quantity (Base) %1';
        UOMEquivalent3lbl: Label 'Quantity (Base) %1';
        TrailerCaptionLbl: Label 'Trailer';
        ReprintedText: Text;
        PrintLanguage: Code[10];
        ChauffeurLeLbl: Label 'Date et visa chauffeur :';
        VisaClientLeLbl: Label 'Date et Visa client ( Signature et cachet) :';
        gTxtVATRegistration: Text;
        CustomerAttributes: Record "Customer Attributes FND";
        Customer: Record Customer;
        HeinekenGlobal: Codeunit "Heineken Global";
        Location: Record Location;
        TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;
        InvoiceNo: Code[20];
        SalesShipmentLine: Record "Sales Shipment Line";
        LocationAddr: Record Location;
        CompanyNRC: Text;

    procedure InitLogInteraction()
    begin
        // LogInteraction := SegManagement.FindInteractTmplCode(5) <> '';  // BC Upgrade BHARDA11 ----FindInteractTmplCode function is Obsolet, we are using this  FindInteractionTemplateCode
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Shpt. Note") <> ''; // BC Upgrade BHARDA11 ----FindInteractTmplCode function is Obsolet, we are using this  FindInteractionTemplateCode and Change add the value in the place of 5

    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean; NewShowLotSN: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        ShowCorrectionLines := NewShowCorrectionLines;
        ShowLotSN := NewShowLotSN;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        EXIT(PADSTR('', 2, ' '));
    end;

    procedure InsertCommentLine(Comment: Text)
    begin
        TempCommentLine.INIT;
        TempCommentLine."Line No." := CommentLineNo;
        TempCommentLine.Comment := Comment;
        TempCommentLine.INSERT;
        CommentLineNo += 10000;
    end;
}

