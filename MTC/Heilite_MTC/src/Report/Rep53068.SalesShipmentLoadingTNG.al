report 53068 "Sales - Shipment LoadingTNG"
{
    //BC Upgrade GUNREM01 Old ID-50036
    // version NAVW17.10.00.36366

    // # Issue 88 IBM.Chauhb01
    //    Added sales Order Number
    //BC Upgrade GUNREM01
    // # commented DIT Code 
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Sales - Shipment LoadingTNG.rdlc';

    CaptionML = ENU = 'Sales - Shipment',
                FRA = 'Ventes : Expédition';
    ApplicationArea = All;

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
            column(DriverName; DriverName)
            {
            }
            column(TruckPlateNo; TruckPlateNo)
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
                    column(SalesShptCopyText; STRSUBSTNO(Text002, CopyText))
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
                    column(SONumber; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(SOCaption; SONumberCaptionLbl)
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
                                //DecimalPlaces = 0 : 5; //BC Upgrade GUNREM01 -we cant use decimal places property for code data type

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
                        begin
                            LinNo := "Line No.";
                            if not ShowCorrectionLines and Correction then
                                CurrReport.SKIP;

                            DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");
                            if DisplayAssemblyInformation then
                                AsmHeaderExists := AsmToShipmentExists(PostedAsmHeader);
                        end;
                        //BC Upgrade GUNREM01 DIT Code >>
                        // trigger OnPostDataItem();
                        // begin
                        //     // Item Tracking:
                        //     if ShowLotSN then begin
                        //         ItemTrackingMgt.SetRetrieveAsmItemTracking(true);
                        //         TrackingSpecCount := ItemTrackingMgt.RetrieveDocumentItemTracking(TrackingSpecBuffer, "Sales Shipment Header"."No.",
                        //             DATABASE::"Sales Shipment Header", 0);
                        //         ItemTrackingMgt.SetRetrieveAsmItemTracking(false);
                        //     end;
                        // end;
                        //BC Upgrade GUNREM01 DIT Code >>
                        trigger OnPreDataItem();
                        begin
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
                        column(TrackingSpecBufferNo; TrackingSpecBuffer."Item No.")
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
                        dataitem(TotalItemTracking; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                            column(Quantity1; TotalQty)
                            {
                            }
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                TrackingSpecBuffer.FINDSET
                            else
                                TrackingSpecBuffer.NEXT;

                            if not ShowCorrectionLines and TrackingSpecBuffer.Correction then
                                CurrReport.SKIP;
                            if TrackingSpecBuffer.Correction then
                                TrackingSpecBuffer."Quantity (Base)" := -TrackingSpecBuffer."Quantity (Base)";

                            ShowTotal := false;
                            if ItemTrackingAppendix.IsStartNewGroup(TrackingSpecBuffer) then
                                ShowTotal := true;

                            ShowGroup := false;
                            if (TrackingSpecBuffer."Source Ref. No." <> OldRefNo) or
                               (TrackingSpecBuffer."Item No." <> OldNo)
                            then begin
                                OldRefNo := TrackingSpecBuffer."Source Ref. No.";
                                OldNo := TrackingSpecBuffer."Item No.";
                                TotalQty := 0;
                            end else
                                ShowGroup := true;
                            TotalQty += TrackingSpecBuffer."Quantity (Base)";
                        end;

                        trigger OnPreDataItem();
                        begin
                            if TrackingSpecCount = 0 then
                                CurrReport.BREAK;
                            CurrReport.NEWPAGE;
                            SETRANGE(Number, 1, TrackingSpecCount);
                            TrackingSpecBuffer.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                              "Source Prod. Order Line", "Source Ref. No.");
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
                        CopyText := Text001;
                        OutputNo += 1;
                    end;
                    CurrReport.PAGENO := 1;
                    TotalQty := 0;           // Item Tracking
                end;

                trigger OnPostDataItem();
                begin
                    if not CurrReport.PREVIEW then
                        ShptCountPrinted.RUN("Sales Shipment Header");
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := 1 + ABS(NoOfCopies);
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                CurrReport.LANGUAGE := Languageg.GetLanguageID("Language Code");

                if RespCenter.GET("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if "Salesperson Code" = '' then begin
                    SalesPurchPerson.INIT;
                    SalesPersonText := '';
                end else begin
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                end;
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FIELDCAPTION("Your Reference");
                FormatAddr.SalesShptShipTo(ShipToAddr, "Sales Shipment Header");

                FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, "Sales Shipment Header");
                ShowCustAddr := "Bill-to Customer No." <> "Sell-to Customer No.";
                for i := 1 to ARRAYLEN(CustAddr) do
                    if CustAddr[i] <> ShipToAddr[i] then
                        ShowCustAddr := true;

                if LogInteraction then
                    if not CurrReport.PREVIEW then
                        SegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '');

                //HEI.01>>
                // GetDriveTruckDetails("Sales Shipment Header"."Driver Code", "Sales Shipment Header"."Truck Code"); //BC Upgrade GUNREM01 DIT fields
                //HEI.01<<
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
                        CaptionML = ENU = 'No. of Copies',
                                    FRA = 'Nombre de copies';
                        ApplicationArea = All;
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        CaptionML = ENU = 'Show Internal Information',
                                    FRA = 'Afficher info. internes';
                        ApplicationArea = All;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        CaptionML = ENU = 'Log Interaction',
                                    FRA = 'Journal interaction';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;
                    }
                    field("Show Correction Lines"; ShowCorrectionLines)
                    {
                        CaptionML = ENU = 'Show Correction Lines',
                                    FRA = 'Afficher lignes correction';
                        ApplicationArea = All;
                    }
                    field(ShowLotSN; ShowLotSN)
                    {
                        CaptionML = ENU = 'Show Serial/Lot Number Appendix',
                                    FRA = 'Afficher annexe numéro série/lot';
                        ApplicationArea = All;
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
                    {
                        CaptionML = ENU = 'Show Assembly Components',
                                    FRA = 'Afficher composants d''assemblage';
                        ApplicationArea = All;
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
        label(Driverlbl; ENU = 'Driver',
                        FRA = 'Chauffeur')
        label(Truckplatenumberlbl; ENU = 'Truck plate number',
                                  FRA = 'Matricule')
        label(SWHMlbl; ENU = 'Signature of the Warehouse Manager',
                      FRA = 'Signature du Chef de Dpt Logistique')
    }

    trigger OnInitReport();
    begin
        CompanyInfo.GET;
        SalesSetup.GET;

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
    end;

    trigger OnPreReport();
    begin
        if not CurrReport.USEREQUESTPAGE then
            InitLogInteraction;
        AsmHeaderExists := false;
    end;

    var
        Text000: TextConst ENU = 'Salesperson', FRA = 'Vendeur';
        Text001: TextConst ENU = 'COPY', FRA = 'COPIE';
        Text002: TextConst ENU = 'ORDER LOADING %1', FRA = 'ORDE DE CHARGEMENT%1';
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        //Language: Record Language;
        LanguageG: Codeunit Language;
        TrackingSpecBuffer: Record "Tracking Specification" temporary;
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        ShptCountPrinted: Codeunit "Sales Shpt.-Printed";
        SegManagement: Codeunit SegManagement;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        RespCenter: Record "Responsibility Center";
        ItemTrackingAppendix: Report "Item Tracking Appendix";
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
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
        ItemTrackingAppendixCaptionLbl: TextConst ENU = 'Item Tracking - Appendix', FRA = 'Traçabilité - Annexe';
        PhoneNoCaptionLbl: TextConst ENU = 'Phone No.', FRA = 'N° téléphone';
        VATRegNoCaptionLbl: TextConst ENU = 'VAT Reg. No.', FRA = 'N° de société';
        GiroNoCaptionLbl: TextConst ENU = 'Giro No.', FRA = 'N° CCP';
        BankNameCaptionLbl: TextConst ENU = 'Bank', FRA = 'Banque';
        BankAccNoCaptionLbl: TextConst ENU = 'Account No.', FRA = 'N° compte';
        ShipmentNoCaptionLbl: TextConst ENU = 'Shipment No.', FRA = 'N° expédition';
        ShipmentDateCaptionLbl: TextConst ENU = 'Shipment Date', FRA = 'Date d''expédition';
        HomePageCaptionLbl: TextConst ENU = 'Home Page', FRA = 'Page d''accueil';
        EmailCaptionLbl: TextConst ENU = 'E-Mail', FRA = 'E-mail';
        DocumentDateCaptionLbl: TextConst ENU = 'Document Date', FRA = 'Date document';
        HeaderDimensionsCaptionLbl: TextConst ENU = 'Header Dimensions', FRA = 'Analytique en-tête';
        LineDimensionsCaptionLbl: TextConst ENU = 'Line Dimensions', FRA = 'Analytique ligne';
        BilltoAddressCaptionLbl: TextConst ENU = 'Bill-to Address', FRA = 'Adresse facturation';
        QuantityCaptionLbl: TextConst ENU = 'Quantity', FRA = 'Quantité';
        SerialNoCaptionLbl: TextConst ENU = 'Serial No.', FRA = 'N° de série';
        LotNoCaptionLbl: TextConst ENU = 'Lot No.', FRA = 'N° lot';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        NoCaptionLbl: TextConst ENU = 'No.', FRA = 'N°';
        PageCaptionCap: TextConst ENU = 'Page %1 of %2', FRA = 'Page %1 de %2';
        SONumberCaptionLbl: TextConst ENU = 'Sales Order No.', FRA = 'N° Commande Vente';
        DriverName: Text[50];
        TruckPlateNo: Text[20];

    procedure InitLogInteraction();
    var
    enumvalue : Enum "Interaction Log Entry Document Type";
    begin
        // LogInteraction := SegManagement.FindInteractTmplCode(5) <> '';
        LogInteraction := SegManagement.FindInteractionTemplateCode(enumvalue::"Sales Shpt. Note") <> ''; //BC Upgrade GUNREM01 -BC replaced the fucntion name 
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean; NewShowLotSN: Boolean; DisplayAsmInfo: Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        ShowCorrectionLines := NewShowCorrectionLines;
        ShowLotSN := NewShowLotSN;
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
    //BC Upgrade GUNREM01 -DIT Code >>
    // local procedure GetDriveTruckDetails(DriverCode: Code[10]; TruckCode: Code[10]);
    // var
    //     WhseShippingDriver: Record "Whse. Shipping Driver";
    //     WhseShippingTruck: Record "Whse. Shipping Truck";
    // begin
    //     //HEI.01>>
    //     WhseShippingDriver.RESET;
    //     WhseShippingDriver.SETRANGE(Code, DriverCode);
    //     if WhseShippingDriver.FINDFIRST then
    //         DriverName := WhseShippingDriver.Description;

    //     WhseShippingTruck.RESET;
    //     WhseShippingTruck.SETRANGE(Code, TruckCode);
    //     if WhseShippingTruck.FINDFIRST then
    //         TruckPlateNo := WhseShippingTruck."Truck Plate No";
    //     //HEI.01>>
    // end;
    //BC Upgrade GUNREM01 -DIT Code <<
}

