report 53058 "Sales - Shipment MZB"
{
    // version NAVW110.0,HEI.01

    // HEI.01 FDD-SLSGAP001 IBM NASTAA02 07.09.2017 # MDM Customer Card
    //   # Increased "CustAddr" and "ShipToAddr" global variables length from 50 to 60 characters
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Sales - Shipment MZB.rdl';
    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding Usagecategory

    CaptionML = ENU = 'Sales - Shipment',
                FRA = 'Ventes : Expédition';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeadingML = ENU = 'Posted Sales Shipment',
                                     FRA = 'Expédition vente enregistrée';
            column(No_SalesShptHeader; "No.")
            {
            }
            column(PageCaption; PageCaptionCap)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(SalesShptCopyText; CopyText)
                    {
                    }
                    column(SalesShipmentHeaderOrderNo; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(CompanyInfoName; CompanyInfo.Name)
                    {
                    }
                    column(ShipToAddr1; ShipToAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
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
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
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
                    column(ShptDate_SalesShptHeader; FORMAT("Sales Shipment Header"."Shipment Date"))
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
                    column(InvoiceNo; InvoiceNo)
                    {
                    }
                    column(LocationCode; LocationCode)
                    {
                    }
                    column(TotalItemQty; FORMAT(TotalItemQty))
                    {
                    }
                    column(TotalWeight; FORMAT(TotalWeight))
                    {
                    }
                    column(TotalVolume; FORMAT(TotalVolume))
                    {
                    }
                    column(DriverNameLbl; DriverNameLbl)
                    {
                    }
                    column(TruckCodeLbl; TruckCodeLbl)
                    {
                    }
                    column(DriverCodeLbl; DriverCodeLbl)
                    {
                    }
                    column(TruckCodeDescLbl; TruckCodeDescLbl)
                    {
                    }
                    //BC UPGRADE KUMARR78>> DIT Field and Variables Removed
                    // column(WhseShippingDrive_Code; WhseShippingDriver.Code)
                    // {
                    // }
                    // column(WhseShippingDriver_Description; WhseShippingDriver.Description)
                    // {
                    // }
                    // column(WhseShippingTruck_Code; WhseShippingTruck.Code)
                    // {
                    // }
                    // column(WhseShippingTruc_Description; WhseShippingTruck.Description)
                    // {
                    // }
                    //BC UPGRADE KUMARR78<< DIT Field and Variables Removed

                    //BC UPGRADE KUMARR78<< DIT Field and Variables Passing Blank Value in Expression.
                    column(WhseShippingDrive_Code; '')
                    {
                    }
                    column(WhseShippingDriver_Description; '')
                    {
                    }
                    column(WhseShippingTruck_Code; '')
                    {
                    }
                    column(WhseShippingTruc_Description; '')
                    {
                    }
                    //BC UPGRADE KUMARR78<< DIT Field and Variables Passing Blank Value in Expression.
                    column(ShipAgName; ShipAgName)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FINDSET then
                                    CurrReport.BREAK;
                            end else
                                if not Continue then
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := STRSUBSTNO('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1; %2 - %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
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
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER(Item), Quantity = FILTER(<> 0));
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
                        column(UOM_SalesShptLine; "Unit of Measure")
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
                        column(Qty_SalesShptLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesShptLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(No_SalesShptLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FINDSET then
                                        CurrReport.BREAK;
                                end else
                                    if not Continue then
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := STRSUBSTNO('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1; %2 - %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPreDataItem();
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.BREAK;
                            end;
                        }
                        dataitem(DisplayAsmInfo; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(PostedAsmLineItemNo; BlanksForIndent + PostedAsmLine."No.")
                            {
                            }
                            column(PostedAsmLineDescription; BlanksForIndent + PostedAsmLine.Description)
                            {
                            }
                            column(PostedAsmLineQuantity; PostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(PostedAsmLineUOMCode; GetUnitOfMeasureDescr(PostedAsmLine."Unit of Measure Code"))
                            {
                                // DecimalPlaces = 0 : 5;//BC UPGRADE KUMARR78<<Blocking As Expression Refers to Decimal Field Only.
                            }

                            trigger OnAfterGetRecord();
                            var
                                ItemTranslation: Record "Item Translation";
                            begin
                                if Number = 1 then
                                    PostedAsmLine.FINDSET
                                else
                                    PostedAsmLine.NEXT;

                                if ItemTranslation.GET(PostedAsmLine."No.",
                                     PostedAsmLine."Variant Code",
                                     "Sales Shipment Header"."Language Code")
                                then
                                    PostedAsmLine.Description := ItemTranslation.Description;
                            end;

                            trigger OnPreDataItem();
                            begin
                                if not DisplayAssemblyInformation then
                                    CurrReport.BREAK;
                                if not AsmHeaderExists then
                                    CurrReport.BREAK;

                                PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                                SETRANGE(Number, 1, PostedAsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            ItemEntryRelation: Record "Item Entry Relation";
                            ItemLedgEntry: Record "Item Ledger Entry";
                        begin
                            LinNo := "Line No.";
                            if not ShowCorrectionLines and Correction then
                                CurrReport.SKIP;

                            DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");
                            if DisplayAssemblyInformation then
                                AsmHeaderExists := AsmToShipmentExists(PostedAsmHeader);

                            ItemEntryRelation.SETCURRENTKEY("Source ID");
                            ItemEntryRelation.SETRANGE("Source Type", 111);
                            ItemEntryRelation.SETRANGE("Source ID", "Document No.");
                            ItemEntryRelation.SETRANGE("Source Ref. No.", LinNo);
                            if ItemEntryRelation.FINDSET then
                                repeat
                                    ItemLedgEntry.GET(ItemEntryRelation."Item Entry No.");
                                    NextEntryNo += 1;
                                    TrackingSpecBuffer."Entry No." := NextEntryNo;
                                    TrackingSpecBuffer.Description := Description;
                                    TrackingSpecBuffer."Item No." := "No.";
                                    TrackingSpecBuffer."Lot No." := ItemLedgEntry."Lot No.";
                                    if ItemLedgEntry."Qty. per Unit of Measure" <> 0 then
                                        TrackingSpecBuffer."Quantity (Base)" := -ItemLedgEntry.Quantity / ItemLedgEntry."Qty. per Unit of Measure"
                                    else
                                        TrackingSpecBuffer."Quantity (Base)" := -ItemLedgEntry.Quantity;

                                    TrackingSpecBuffer."Bin Code" := ItemLedgEntry."Unit of Measure Code";
                                    TrackingSpecBuffer."Expiration Date" := ItemLedgEntry."Expiration Date";
                                    TrackingSpecBuffer.INSERT
                                until ItemEntryRelation.NEXT = 0
                            else begin
                                NextEntryNo += 1;
                                TrackingSpecBuffer."Entry No." := NextEntryNo;
                                TrackingSpecBuffer.Description := Description;
                                TrackingSpecBuffer."Item No." := "No.";
                                TrackingSpecBuffer."Quantity (Base)" := "Sales Shipment Line".Quantity;
                                TrackingSpecBuffer."Bin Code" := "Sales Shipment Line"."Unit of Measure Code";
                                TrackingSpecBuffer."Expiration Date" := ItemLedgEntry."Expiration Date";
                                TrackingSpecBuffer.INSERT
                            end;
                        end;

                        trigger OnPreDataItem();
                        begin
                            TrackingSpecBuffer.DELETEALL;
                            MoreLines := FIND('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) do
                                MoreLines := NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(BilltoCustNo_SalesShptHeader; "Sales Shipment Header"."Bill-to Customer No.")
                        {
                        }
                        column(CustAddr1; CustAddr[1])
                        {
                        }
                        column(CustAddr2; CustAddr[2])
                        {
                        }
                        column(CustAddr3; CustAddr[3])
                        {
                        }
                        column(CustAddr4; CustAddr[4])
                        {
                        }
                        column(CustAddr5; CustAddr[5])
                        {
                        }
                        column(CustAddr6; CustAddr[6])
                        {
                        }
                        column(CustAddr7; CustAddr[7])
                        {
                        }
                        column(CustAddr8; CustAddr[8])
                        {
                        }
                        column(BilltoAddressCaption; BilltoAddressCaptionLbl)
                        {
                        }
                        column(BilltoCustNo_SalesShptHeaderCaption; "Sales Shipment Header".FIELDCAPTION("Bill-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem();
                        begin
                            if not ShowCustAddr then
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(ItemTrackingLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(TrackingSpecBufferNo; FORMAT(TrackingSpecBuffer."Entry No."))
                        {
                        }
                        column(TrackingSpecBufferItemNo; TrackingSpecBuffer."Item No.")
                        {
                        }
                        column(TrackingSpecBufferDesc; TrackingSpecBuffer.Description)
                        {
                        }
                        column(TrackingSpecBufferLotNo; TrackingSpecBuffer."Lot No.")
                        {
                        }
                        column(TrackingSpecBufferSerNo; TrackingSpecBuffer."Serial No.")
                        {
                        }
                        column(TrackingSpecBufferQty; TrackingSpecBuffer."Quantity (Base)")
                        {
                        }
                        column(TrackingSpecBufferUOM; TrackingSpecBuffer."Bin Code")
                        {
                        }
                        column(TrackingSpecBufferExpirationDate; FORMAT(TrackingSpecBuffer."Expiration Date"))
                        {
                        }
                        column(ShowTotal; ShowTotal)
                        {
                        }
                        column(ShowGroup; ShowGroup)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(SerialNoCaption; SerialNoCaptionLbl)
                        {
                        }
                        column(LotNoCaption; LotNoCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(NoCaption; NoCaptionLbl)
                        {
                        }
                        column(PackIDCaption; PackIDCap)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                TrackingSpecBuffer.FINDSET
                            else
                                TrackingSpecBuffer.NEXT;
                            /*
                            IF NOT ShowCorrectionLines AND TrackingSpecBuffer.Correction THEN
                              CurrReport.SKIP;
                            IF TrackingSpecBuffer.Correction THEN
                              TrackingSpecBuffer."Quantity (Base)" := -TrackingSpecBuffer."Quantity (Base)";
                            
                            ShowTotal := FALSE;
                            IF ItemTrackingAppendix.IsStartNewGroup(TrackingSpecBuffer) THEN
                              ShowTotal := TRUE;
                            
                            ShowGroup := FALSE;
                            IF (TrackingSpecBuffer."Source Ref. No." <> OldRefNo) OR
                               (TrackingSpecBuffer."Item No." <> OldNo)
                            THEN BEGIN
                              OldRefNo := TrackingSpecBuffer."Source Ref. No.";
                              OldNo := TrackingSpecBuffer."Item No.";
                              TotalQty := 0;
                            END ELSE
                              ShowGroup := TRUE;
                              */
                            TotalQty += TrackingSpecBuffer."Quantity (Base)";

                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(Number, 1, TrackingSpecBuffer.COUNT);
                            TrackingSpecBuffer.RESET;
                        end;
                    }

                    trigger OnPreDataItem();
                    begin
                        // Item Tracking:
                        if ShowLotSN then begin
                            TrackingSpecCount := 0;
                            OldRefNo := 0;
                            ShowGroup := false;
                        end;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        CopyText := 'REPRINT';
                        OutputNo += 1;
                    end;
                    CurrReport.PAGENO := 1;
                    TotalQty := 0;           // Item Tracking
                end;

                trigger OnPostDataItem();
                begin
                    if not CurrReport.PREVIEW then
                        CODEUNIT.RUN(CODEUNIT::"Sales Shpt.-Printed", "Sales Shipment Header");
                end;

                trigger OnPreDataItem();
                begin
                    //TrackingSpecBuffer.DELETEALL;
                    NoOfLoops := 1 + ABS(NoOfCopies);
                    CopyText := '';
                    if "Sales Shipment Header"."No. Printed" > 0 then
                        CopyText := 'REPRINT';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord();
            var
                SalesShipmentLineCount: Record "Sales Shipment Line";
                ILE: Record "Item Ledger Entry";
                ValueEntry: Record "Value Entry";
                ShippingAgent: Record "Shipping Agent";
            begin
                // CurrReport.LANGUAGE := Language.GetLanguageID('');//"Language Code"); //BC Upgrade KUMARR78 GetlanguageId moved from Table to CU.
                // CurrReport.Language := LanguageG.GetLanguageId(''); //BC Upgrade KUMARR78 GetlanguageId moved from Table to CU. //Commented for Time Being Until Error Resolve.


                FormatAddressFields("Sales Shipment Header");
                FormatDocumentFields("Sales Shipment Header");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");
                //soicad>>
                ShipAgName := '';
                if ShippingAgent.GET("Sales Shipment Header"."Shipping Agent Code") then
                    ShipAgName := ShippingAgent.Name;
                InvoiceNo := '';
                LocationCode := '';
                TotalItemQty := 0;
                TotalWeight := 0;
                TotalVolume := 0;
                SalesShipmentLineCount.SETRANGE("Document No.", "No.");
                SalesShipmentLineCount.SETRANGE(Type, SalesShipmentLineCount.Type::Item);
                if SalesShipmentLineCount.FINDSET then
                    repeat
                        TotalItemQty += SalesShipmentLineCount.Quantity;
                    // TotalWeight += SalesShipmentLineCount.Weight;//BC Upgrade KUMARR78 DIT Field Removed
                    // TotalVolume += SalesShipmentLineCount.Cubage;//BC Upgrade KUMARR78 DIT Field Removed
                    until SalesShipmentLineCount.NEXT = 0;
                ILE.SETCURRENTKEY("Document No.", "Posting Date");
                ILE.SETRANGE("Document No.", "No.");
                if ILE.FINDSET then
                    repeat
                        LocationCode := ILE."Location Code";
                        ValueEntry.RESET;
                        ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
                        ValueEntry.SETRANGE("Item Ledger Entry No.", ILE."Entry No.");
                        ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Sales Invoice");
                        if ValueEntry.FINDFIRST then
                            InvoiceNo := ValueEntry."Document No.";
                    until ILE.NEXT = 0;

                //soicad<<
                if LogInteraction then
                    if not CurrReport.PREVIEW then
                        SegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '');
                //BC Upgrade KUMARR78>> DIT Field Removed("Driver Code")
                // if "Sales Shipment Header"."Driver Code" <> '' then
                //     WhseShippingDriver.GET("Sales Shipment Header"."Driver Code");

                // if "Sales Shipment Header"."Truck Code" <> '' then
                //     WhseShippingTruck.GET("Sales Shipment Header"."Truck Code");
                //BC Upgrade KUMARR78<< DIT Field Removed("Driver Code")
            end;

            trigger OnPreDataItem();
            begin
                ShowLotSN := true;
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
                        ApplicationArea = all;//BC Upgrade KUMARR78 Adding ApplicationArea
                        CaptionML = ENU = 'No. of Copies',
                                    FRA = 'Nombre de copies';
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
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        CompanyInfo.GET;
        SalesSetup.GET;
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
        CompanyInfo.CALCFIELDS(Picture);
        CompanyInfo1.CALCFIELDS(Picture);
        CompanyInfo2.CALCFIELDS(Picture);
        CompanyInfo3.CALCFIELDS(Picture);
    end;

    trigger OnPreReport();
    begin
        if not CurrReport.USEREQUESTPAGE then
            InitLogInteraction;
        AsmHeaderExists := false;
        ShowLotSN := true;
    end;

    var
        Text002: TextConst Comment = '%1 = Document No.', ENU = 'Sales - Shipment %1', FRA = 'Vente : Expédition %1';
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        // Language: Record Language; //BC UPGRADE KUMARR78 Blocking Codeunit as Function Moved from Record to Codeunit.
        LanguageG: Codeunit Language;//BC UPGRADE KUMARR78 Adding Codeunit as Function Moved from Record to Codeunit.
        TrackingSpecBuffer: Record "Tracking Specification" temporary;
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        RespCenter: Record "Responsibility Center";
        ItemTrackingAppendix: Report "Item Tracking Appendix";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
        CustAddr: array[8] of Text[60];
        ShipToAddr: array[8] of Text[60];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[20];
        ReferenceText: Text[80];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        OutputNo: Integer;
        NoOfLoops: Integer;
        TrackingSpecCount: Integer;
        OldRefNo: Integer;
        OldNo: Code[20];
        CopyText: Text[30];
        ShowCustAddr: Boolean;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        ShowCorrectionLines: Boolean;
        ShowTotal: Boolean;
        ShowGroup: Boolean;
        TotalQty: Decimal;
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmHeaderExists: Boolean;
        LinNo: Integer;
        ItemTrackingAppendixCaptionLbl: TextConst ENU = 'Item Tracking - Appendix', FRA = 'Traçabilité - Annexe';
        PhoneNoCaptionLbl: TextConst ENU = 'Phone No.', FRA = 'N° téléphone';
        VATRegNoCaptionLbl: TextConst ENU = 'VAT Reg. No.', FRA = 'N° de société';
        GiroNoCaptionLbl: TextConst ENU = 'Giro No.', FRA = 'N° CCP';
        BankNameCaptionLbl: TextConst ENU = 'Bank', FRA = 'Banque';
        BankAccNoCaptionLbl: TextConst ENU = 'Account No.', FRA = 'N° compte';
        ShipmentNoCaptionLbl: TextConst ENU = 'Shipment No.', FRA = 'N° expédition';
        ShipmentDateCaptionLbl: TextConst ENU = 'Shipment Date', FRA = 'Date d''expédition';
        HomePageCaptionLbl: TextConst ENU = 'Home Page', FRA = 'Page d''accueil';
        EmailCaptionLbl: TextConst ENU = 'Email', FRA = 'E-mail';
        DocumentDateCaptionLbl: TextConst ENU = 'Document Date', FRA = 'Date document';
        HeaderDimensionsCaptionLbl: TextConst ENU = 'Header Dimensions', FRA = 'Analytique en-tête';
        LineDimensionsCaptionLbl: TextConst ENU = 'Line Dimensions', FRA = 'Analytique ligne';
        BilltoAddressCaptionLbl: TextConst ENU = 'Bill-to Address', FRA = 'Adresse facturation';
        QuantityCaptionLbl: TextConst ENU = 'Qty', FRA = 'Quantité';
        SerialNoCaptionLbl: TextConst ENU = 'Serial No.', FRA = 'N° de série';
        LotNoCaptionLbl: TextConst ENU = 'Lot No.', FRA = 'N° lot';
        DescriptionCaptionLbl: TextConst ENU = 'Article', FRA = 'Description';
        NoCaptionLbl: TextConst ENU = 'No.', FRA = 'N°';
        PageCaptionCap: TextConst ENU = 'Page %1 of %2', FRA = 'Page %1 de %2';
        PackIDCap: Label 'Pack.ID';
        ShowLotSN: Boolean;
        NextEntryNo: Integer;
        TotalItemQty: Decimal;
        TotalWeight: Decimal;
        TotalVolume: Decimal;
        InvoiceNo: Code[20];
        LocationCode: Text;
        TruckCodeLbl: Label 'Truck Code';
        TruckCodeDescLbl: Label 'Truck Name';
        DriverNameLbl: Label 'Driver Name';
        //BC Upgrade KUMARR78>> Blocking DIT Variable
        // WhseShippingDriver: Record "Whse. Shipping Driver";
        // WhseShippingTruck: Record "Whse. Shipping Truck";
        //BC Upgrade KUMARR78<< Blocking DIT Variable
        DriverCodeLbl: Label 'Driver Code';
        ShipAgName: Text;

    procedure InitLogInteraction();
    var
    enumvalue : Enum "Interaction Log Entry Document Type";
    begin
        //LogInteraction := SegManagement.FindInteractTmplCode(5) <> ''; //BC UPGRADE KUMARR78-Field missing in Table
        LogInteraction := SegManagement.FindInteractionTemplateCode(enumvalue::"Sales Shpt. Note") <> ''; //BC UPGRADE KUMARR78-replaced this field
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean; NewShowLotSN: Boolean; DisplayAsmInfo: Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        ShowCorrectionLines := NewShowCorrectionLines;
        ShowLotSN := NewShowLotSN;
        DisplayAssemblyInformation := DisplayAsmInfo;
        ShowLotSN := true;
    end;

    local procedure FormatAddressFields(SalesShipmentHeader: Record "Sales Shipment Header");
    begin
        FormatAddr.GetCompanyAddr(SalesShipmentHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesShptShipTo(ShipToAddr, SalesShipmentHeader);
        ShowCustAddr := FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, SalesShipmentHeader);
    end;

    local procedure FormatDocumentFields(SalesShipmentHeader: Record "Sales Shipment Header");
    begin
        FormatDocument.SetSalesPerson(SalesPurchPerson, SalesShipmentHeader."Salesperson Code", SalesPersonText);
        ReferenceText := FormatDocument.SetText(SalesShipmentHeader."Your Reference" <> '', SalesShipmentHeader.FIELDCAPTION("Your Reference"));
    end;

    local procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10];
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
}

