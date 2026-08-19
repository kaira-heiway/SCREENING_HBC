report 53024 "Documents Incorrect Price"
{
    // version HEI.04

    // HEI.01 FDD OTCGAP046 IBM HORTOC01 21.07.2017
    //   # new report
    // HEI.02 FDD OTCGAP046 IBM POENAB01 04.08.2017
    //   # New adjustments, for changing the layout
    // HEI.03 FDD OTCGAP046 IBM POENAB01 10.08.2017
    //   # Change calculation formula for DocFinalPriceExclVAT_PSI. Created new function - GetDocFinalPrice_PSI2
    // HEI.04 FDD OTCGAP046 IBM POENAB01 11.08.2017
    //   # Change calculation formula for ActiveUnitDisc_PSI. Created new function - GetActiveUnitDisc_PSI2
    // BC Upgrade RAHUL>>
    // 1. Added ApplicationArea = All property at report level for BC visibility.
    //    Old: ApplicationArea property not defined at report level.
    //    New: ApplicationArea = All added at report level.
    // 2. Added UsageCategory = ReportsAndAnalysis property at report level for BC search.
    //    Old: UsageCategory not defined at report level.
    //    New: UsageCategory = ReportsAndAnalysis added at report level.
    // 3. Blocked deprecated Sales Price Calc. Mgt. functions due to removal in BC.
    //    Old:
    //      - ActiveUnitPrice_SO := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindSalesPriceExclCampaign(SalesHeader, "Sales Line"), ...)
    //      - ActiveCampaignUnitPrice_SO := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindCampaignSalesPrice(SalesHeader, "Sales Line"), ...)
    //      - ActiveUnitPrice_PSI := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindSalesPriceExclCampaign(SalesHeader2, SalesLine), ...)
    //      - ActiveCampaignUnitPrice_PSI := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindCampaignSalesPrice(SalesHeader2, SalesLine), ...)
    //      - ActiveUnitPrice_PSS := SalesPriceCalcMgt.FindSalesPriceExclCampaign(SalesHeader3, SalesLine1)
    //      - ActiveCampaignUnitPrice_PSS := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindCampaignSalesPrice(SalesHeader3, SalesLine1), ...)
    //      - ActiveUnitPrice_PSS / ActiveCampaignUnitPrice_PSS for archived order using TempSalesHeader/TempSalesLine
    //    New: All above function calls commented out to avoid compile errors in BC.
    // 4. Updated Request Page OnLookup trigger signature for BC compatibility.
    //    Old: trigger OnLookup(Text: Text): Boolean
    //    New: trigger OnLookup(Var Text: Text): Boolean
    // 5. Replaced deprecated ApplicationManagement codeunit usage for date filter conversion.
    //    Old:
    //      - ApplicationMgt: Codeunit ApplicationManagement
    //      - ApplicationManagement.MakeDateFilter(DateFilterTxt)
    //    New:
    //      - FilterToken: Codeunit "Filter Tokens"
    //      - FilterToken.MakeDateFilter(FilterDate)
    // 6. Blocked legacy DIT field dependency: "Item Charge Type" across multiple procedures and dataitems.
    //    Old: Used Sales Line / Sales Invoice Line "Item Charge Type" to calculate discount values and details lines.
    //    New: All logic blocks commented out with marker:
    //         "BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")"
    // 7. No functional change in custom calculation logic (HEI.03 / HEI.04) except removal of unavailable dependencies.
    //    Old: Custom functions GetDocFinalPrice_PSI2 and GetActiveUnitDisc_PSI2 used for revised formula.
    //    New: Same functions retained and used; report now compiles under BC after replacing/removing unsupported calls.
    // 8. Report upgrade reference.
    //    Old Report ID: 50010
    //    New: Upgraded for BC with ApplicationArea/UsageCategory compliance, OnLookup signature fix,
    //         ApplicationManagement replacement, and removal of deprecated SalesPriceCalcMgt + DIT field references.
    // BC Upgrade RAHUL<<


    DefaultLayout = RDLC;
    ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL Adding Usagecategory

    RDLCLayout = '.\src\ReportsLayout\Documents Incorrect Price.rdl';


    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            column(Name_CampanyInfo; CompanyInformation.Name)
            {
            }
            column(CurrentDateTime; CURRENTDATETIME)
            {
            }
            column(ShowSH; ShowSH)
            {
            }
            column(ShowSIH; ShowSIH)
            {
            }
            column(ShowSSH; ShowSSH)
            {
            }
        }
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = FILTER(Order), Type = FILTER(Item));
                column(DocumentType_SalesLine; "Sales Line"."Document Type")
                {
                }
                column(LineNo_SalesLine; "Sales Line"."Line No.")
                {
                }
                column(PostingDate_SalesHeader; SalesHeader."Posting Date")
                {
                }
                column(DocumentNo_SalesLine; "Sales Line"."Document No.")
                {
                }
                column(No_SalesLine; "Sales Line"."No.")
                {
                }
                column(Description_SalesLine; "Sales Line".Description)
                {
                }
                column(Quantity_SalesLine; "Sales Line".Quantity)
                {
                }
                column(UOM_SalesLine; "Sales Line"."Unit of Measure Code")
                {
                }
                column(DocFinalPriceExclVAT_SO; DocFinalPriceExclVAT_SO)
                {
                }
                column(ActiveUnitPrice_SO; ActiveUnitPrice_SO)
                {
                }
                column(ActiveCampaignUnitPrice_SO; ActiveCampaignUnitPrice_SO)
                {
                }
                column(ActiveUnitDisc_SO; ActiveUnitDisc_SO)
                {
                }
                column(CalculatedUnitPrice_SO; CalculatedUnitPrice_SO)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(DocFinalPriceExclVAT_SO);
                    CLEAR(ActiveCampaignUnitPrice_SO);
                    SalesHeader.GET("Sales Line"."Document Type", "Sales Line"."Document No.");
                    DocFinalPriceExclVAT_SO := GetDocFinalPrice_SO("Sales Line");
                    // ActiveUnitPrice_SO := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindSalesPriceExclCampaign(SalesHeader, "Sales Line"), "Sales Line"."No.", "Sales Line"."Unit of Measure Code"); //BC Upgrade RAHUL Blocking due to Function Removal
                    // ActiveCampaignUnitPrice_SO := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindCampaignSalesPrice(SalesHeader, "Sales Line"), "Sales Line"."No.", "Sales Line"."Unit of Measure Code"); //BC Upgrade RAHUL Blocking due to Function Removal
                    ActiveUnitDisc_SO := GetActiveUnitDisc_SO("Sales Line");

                    if (ActiveCampaignUnitPrice_SO < ActiveUnitPrice_SO) and (ActiveCampaignUnitPrice_SO <> 0) then
                        CalculatedUnitPrice_SO := ActiveCampaignUnitPrice_SO - ActiveUnitDisc_SO
                    else
                        CalculatedUnitPrice_SO := ActiveUnitPrice_SO - ActiveUnitDisc_SO;

                    //IF CalculatedUnitPrice_SO < 0 THEN
                    //  CalculatedUnitPrice_SO := CalculatedUnitPrice_SO * -1;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if (SalesDocumentTypeFilter <> SalesDocumentTypeFilter::All) and (SalesDocumentTypeFilter <> SalesDocumentTypeFilter::Order) then
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem();
            begin
                case SalesTypeFilter of
                    SalesTypeFilter::Campaign:
                        SETRANGE("Campaign No.", SalesCodeFilter);
                    SalesTypeFilter::Customer:
                        SETRANGE("Sell-to Customer No.", SalesCodeFilter);
                    SalesTypeFilter::"Customer Price Group":
                        SETRANGE("Customer Price Group", SalesCodeFilter);
                end;

                if FilterDate <> '' then
                    SETFILTER("Posting Date", FilterDate);
            end;
        }
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER(Item));
                column(PostingDate_SalesInvHeader; SalesInvoiceHeader."Posting Date")
                {
                }
                column(DocumentNo_SalesInvoiceLine; "Sales Invoice Line"."Document No.")
                {
                }
                column(No_SalesInvLine; "Sales Invoice Line"."No.")
                {
                }
                column(Description_SalesInvLine; "Sales Invoice Line".Description)
                {
                }
                column(Quantity_SalesInvLine; "Sales Invoice Line".Quantity)
                {
                }
                column(UOM_SalesInvLine; "Sales Invoice Line"."Unit of Measure Code")
                {
                }
                column(DocFinalPriceExclVAT_PSI; DocFinalPriceExclVAT_PSI)
                {
                }
                column(ActiveUnitPrice_PSI; ActiveUnitPrice_PSI)
                {
                }
                column(ActiveCampaignUnitPrice_PSI; ActiveCampaignUnitPrice_PSI)
                {
                }
                column(ActiveUnitDisc_PSI; ActiveUnitDisc_PSI)
                {
                }
                column(CalculatedUnitPrice_PSI; CalculatedUnitPrice_PSI)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(DocFinalPriceExclVAT_PSI);
                    CLEAR(ActiveUnitPrice_PSI);
                    CLEAR(ActiveCampaignUnitPrice_PSI);
                    CLEAR(ActiveUnitDisc_PSI);
                    CLEAR(CalculatedUnitPrice_PSI);
                    SalesInvoiceHeader.GET("Sales Invoice Line"."Document No.");
                    if SalesShipmentLine.GET("Sales Invoice Line"."Shipment No.", "Sales Invoice Line"."Shipment Line No.") then
                        if SalesLine.GET(SalesLine."Document Type"::Order, SalesShipmentLine."Order No.", SalesShipmentLine."Order Line No.") then begin
                            //<<HEI.03
                            //DocFinalPriceExclVAT_PSI := GetDocFinalPrice_PSI(SalesLine);
                            //>>HEI.03
                            SalesHeader2.GET(SalesHeader2."Document Type"::Order, SalesLine."Document No.");
                            // ActiveUnitPrice_PSI := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindSalesPriceExclCampaign(SalesHeader2, SalesLine), "Sales Invoice Line"."No.", "Sales Invoice Line"."Unit of Measure Code"); //BC Upgrade RAHUL Blocking due to Function Removal
                            // ActiveCampaignUnitPrice_PSI := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindCampaignSalesPrice(SalesHeader2, SalesLine), "Sales Invoice Line"."No.", "Sales Invoice Line"."Unit of Measure Code"); //BC Upgrade RAHUL Blocking due to Function Removal
                            //<<HEI.04
                            //ActiveUnitDisc_PSI := GetActiveUnitDisc_PSI(SalesLine);
                            ActiveUnitDisc_PSI := GetActiveUnitDisc_PSI2("Sales Invoice Line");
                            //>>HEI.04

                            if (ActiveCampaignUnitPrice_PSI < ActiveUnitPrice_PSI) and (ActiveCampaignUnitPrice_PSI <> 0) then
                                CalculatedUnitPrice_PSI := ActiveCampaignUnitPrice_PSI - ActiveUnitDisc_PSI
                            else
                                CalculatedUnitPrice_PSI := ActiveUnitPrice_PSI - ActiveUnitDisc_PSI;
                        end else begin
                            //search into sales order archived
                            SalesHeaderArchive.RESET();
                            SalesHeaderArchive.SETRANGE("No.", SalesShipmentLine."Order No.");
                            SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
                            if SalesHeaderArchive.FINDLAST() then begin
                                InitTempSalesHeader(SalesHeaderArchive."No.", SalesShipmentLine."Line No.", SalesHeaderArchive."Version No.");
                                InitTempSalesLine(SalesHeaderArchive."No.", SalesShipmentLine."Line No.", SalesHeaderArchive."Version No.");
                                //<<HEI.03
                                //DocFinalPriceExclVAT_PSI := GetDocFinalPriceTemp_PSI(SalesHeaderArchive,SalesShipmentLine."Line No.");
                                //>>HEI.03
                                // ActiveUnitPrice_PSI := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindSalesPriceExclCampaign(TempSalesHeader, TempSalesLine), "Sales Invoice Line"."No.", "Sales Invoice Line"."Unit of Measure Code"); //BC Upgrade RAHUL Blocking due to Function Removal
                                // ActiveCampaignUnitPrice_PSI := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindCampaignSalesPrice(TempSalesHeader, TempSalesLine), "Sales Invoice Line"."No.", "Sales Invoice Line"."Unit of Measure Code"); //BC Upgrade RAHUL Blocking due to Function Removal
                                //<<HEI.04
                                //ActiveUnitDisc_PSI := GetActiveUnitDiscTemp_PSI(SalesHeaderArchive,SalesShipmentLine."Line No.");
                                ActiveUnitDisc_PSI := GetActiveUnitDisc_PSI2("Sales Invoice Line");
                                //>>HEI.04

                                if (ActiveCampaignUnitPrice_PSI < ActiveUnitPrice_PSI) and (ActiveCampaignUnitPrice_PSI <> 0) then
                                    CalculatedUnitPrice_PSI := ActiveCampaignUnitPrice_PSI - ActiveUnitDisc_PSI
                                else
                                    CalculatedUnitPrice_PSI := ActiveUnitPrice_PSI - ActiveUnitDisc_PSI;
                            end;
                        end;

                    //<<HEI.03
                    DocFinalPriceExclVAT_PSI := GetDocFinalPrice_PSI2("Sales Invoice Line");
                    //>>HEI.03
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if (SalesDocumentTypeFilter <> SalesDocumentTypeFilter::All) and (SalesDocumentTypeFilter <> SalesDocumentTypeFilter::Invoice) then
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem();
            begin
                case SalesTypeFilter of
                    SalesTypeFilter::Campaign:
                        SETRANGE("Campaign No.", SalesCodeFilter);
                    SalesTypeFilter::Customer:
                        SETRANGE("Sell-to Customer No.", SalesCodeFilter);
                    SalesTypeFilter::"Customer Price Group":
                        SETRANGE("Customer Price Group", SalesCodeFilter);
                end;

                if FilterDate <> '' then
                    SETFILTER("Posting Date", FilterDate);
            end;
        }
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER(Item));
                column(PostingDate_SalesShipmentHeader; SalesShipmentHeader."Posting Date")
                {
                }
                column(DocumentNo_SalesShipmentLine; "Sales Shipment Line"."Document No.")
                {
                }
                column(No_SalesShipmentLine; "Sales Shipment Line"."No.")
                {
                }
                column(Description_SalesShipmentLine; "Sales Shipment Line".Description)
                {
                }
                column(Quantity_SalesShipmentLine; "Sales Shipment Line".Quantity)
                {
                }
                column(UOM_SalesShipmentLine; "Sales Shipment Line"."Unit of Measure Code")
                {
                }
                column(DocFinalPriceExclVAT_PSS; DocFinalPriceExclVAT_PSS)
                {
                }
                column(ActiveUnitPrice_PSS; ActiveUnitPrice_PSS)
                {
                }
                column(ActiveCampaignUnitPrice_PSS; ActiveCampaignUnitPrice_PSS)
                {
                }
                column(ActiveUnitDisc_PSS; ActiveUnitDisc_PSS)
                {
                }
                column(CalculatedUnitPrice_PSS; CalculatedUnitPrice_PSS)
                {
                }

                trigger OnAfterGetRecord();
                begin

                    CLEAR(DocFinalPriceExclVAT_PSS);
                    CLEAR(ActiveUnitPrice_PSS);
                    CLEAR(ActiveCampaignUnitPrice_PSS);
                    CLEAR(ActiveUnitDisc_PSS);
                    CLEAR(CalculatedUnitPrice_PSS);

                    SalesShipmentHeader.GET("Sales Shipment Line"."Document No.");
                    if SalesLine1.GET(SalesLine1."Document Type"::Order, "Order No.", "Order Line No.") then begin
                        DocFinalPriceExclVAT_PSS := GetDocFinalPrice_SO(SalesLine1);
                        SalesHeader3.GET(SalesHeader3."Document Type"::Order, SalesLine1."Document No.");
                        // ActiveUnitPrice_PSS := SalesPriceCalcMgt.FindSalesPriceExclCampaign(SalesHeader3, SalesLine1); //BC Upgrade RAHUL Blocking due to Function Removal

                        // ActiveCampaignUnitPrice_PSS := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindCampaignSalesPrice(SalesHeader3, SalesLine1), "Sales Shipment Line"."No.", "Sales Shipment Line"."Unit of Measure Code"); //BC Upgrade RAHUL Blocking due to Function Removal    ;
                        ActiveUnitDisc_PSS := GetActiveUnitDisc_SO(SalesLine1);

                        if (ActiveCampaignUnitPrice_PSS < ActiveUnitPrice_PSS) and (ActiveCampaignUnitPrice_PSS <> 0) then
                            CalculatedUnitPrice_PSS := ActiveCampaignUnitPrice_PSS - ActiveUnitDisc_PSS
                        else
                            CalculatedUnitPrice_PSS := ActiveUnitPrice_PSS - ActiveUnitDisc_PSS;
                    end else begin
                        //search into sales order archived
                        SalesHeaderArchive.RESET();
                        SalesHeaderArchive.SETRANGE("No.", "Order No.");
                        SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
                        if SalesHeaderArchive.FINDLAST() then begin
                            InitTempSalesHeader(SalesHeaderArchive."No.", "Line No.", SalesHeaderArchive."Version No.");
                            InitTempSalesLine(SalesHeaderArchive."No.", "Line No.", SalesHeaderArchive."Version No.");

                            DocFinalPriceExclVAT_PSS := GetDocFinalPriceTemp_PSI(SalesHeaderArchive, "Line No.");
                            // ActiveUnitPrice_PSS := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindSalesPriceExclCampaign(TempSalesHeader, TempSalesLine), "No.", "Unit of Measure Code"); //BC Upgrade RAHUL Blocking due to Function Removal
                            // ActiveCampaignUnitPrice_PSS := ConvertPriceToLineUOM(SalesPriceCalcMgt.FindCampaignSalesPrice(TempSalesHeader, TempSalesLine), "No.", "Unit of Measure Code"); //BC Upgrade RAHUL Blocking due to Function Removal
                            ActiveUnitDisc_PSS := GetActiveUnitDiscTemp_PSI(SalesHeaderArchive, "Line No.");

                            if (ActiveCampaignUnitPrice_PSS < ActiveUnitPrice_PSS) and (ActiveCampaignUnitPrice_PSS <> 0) then
                                CalculatedUnitPrice_PSS := ActiveCampaignUnitPrice_PSS - ActiveUnitDisc_PSS
                            else
                                CalculatedUnitPrice_PSS := ActiveUnitPrice_PSS - ActiveUnitDisc_PSS;
                        end;
                    end;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if (SalesDocumentTypeFilter <> SalesDocumentTypeFilter::All) and (SalesDocumentTypeFilter <> SalesDocumentTypeFilter::Shipment) then
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem();
            begin
                case SalesTypeFilter of
                    SalesTypeFilter::Campaign:
                        SETRANGE("Campaign No.", SalesCodeFilter);
                    SalesTypeFilter::Customer:
                        SETRANGE("Sell-to Customer No.", SalesCodeFilter);
                    SalesTypeFilter::"Customer Price Group":
                        SETRANGE("Customer Price Group", SalesCodeFilter);
                end;

                if FilterDate <> '' then
                    SETFILTER("Posting Date", FilterDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(SalesTypeFilter; SalesTypeFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Type Filter';
                    OptionCaption = 'Customer,Customer Price Group,All Customers,Campaign,None';
                    ToolTip = 'Specifies a filter for which sales prices to display.';

                    trigger OnValidate();
                    begin
                        //SalesTypeFilterOnAfterValidate;
                    end;
                }
                field(SalesCodeFilterCtrl; SalesCodeFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Code Filter';
                    ToolTip = 'Specifies a filter for which sales prices to display.';

                    trigger OnLookup(Var Text: Text): Boolean; //BC Upgrade RAHUL Adding VAR in Trigger OnLookup
                    var
                        CampaignList: Page "Campaign List";
                        CustList: Page "Customer List";
                        CustPriceGrList: Page "Customer Price Groups";
                    begin
                        if SalesTypeFilter = SalesTypeFilter::"All Customers" then
                            exit;

                        case SalesTypeFilter of
                            SalesTypeFilter::Customer:
                                begin
                                    CustList.LOOKUPMODE := true;
                                    if CustList.RUNMODAL() = ACTION::LookupOK then
                                        Text := CustList.GetSelectionFilter()
                                    else
                                        exit(false);
                                end;
                            SalesTypeFilter::"Customer Price Group":
                                begin
                                    CustPriceGrList.LOOKUPMODE := true;
                                    if CustPriceGrList.RUNMODAL() = ACTION::LookupOK then
                                        Text := CustPriceGrList.GetSelectionFilter()
                                    else
                                        exit(false);
                                end;
                            SalesTypeFilter::Campaign:
                                begin
                                    CampaignList.LOOKUPMODE := true;
                                    if CampaignList.RUNMODAL() = ACTION::LookupOK then
                                        Text := CampaignList.GetSelectionFilter()
                                    else
                                        exit(false);
                                end;
                        end;

                        exit(true);
                    end;
                }
                field(SalesDocumentTypeFilter; SalesDocumentTypeFilter)
                {
                    Caption = 'Sales Document Type Filter';
                    ApplicationArea = all;//BC Upgrade RAHUL Adding Application Area
                }
                field(FilterDate; FilterDate)
                {
                    Caption = 'Filter Date';
                    ApplicationArea = all;//BC Upgrade RAHUL Adding Application Area

                    trigger OnValidate();
                    var
                        // ApplicationMgt: Codeunit ApplicationManagement; //BC Upgrade RAHUL Blocking to Add New Codeunit.
                        FilterToken: Codeunit "Filter Tokens"; //BC Upgrade RAHUL New Variable added to replace Application Management
                    begin
                        //if ApplicationManagement.MakeDateFilter(DateFilterTxt) = 0 then; //BC Upgrade RAHUL function CU changed.
                        FilterToken.MakeDateFilter(FilterDate) //BC Upgrade RAHUL function CU changed Adding.
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        CompanyInformation.GET();
        if (SalesTypeFilter <> SalesTypeFilter::None) and (SalesTypeFilter <> SalesTypeFilter::"All Customers") then
            if SalesCodeFilter = '' then
                ERROR(SalesCodeFilterError);

        //<<HEI.02
        SalesHeaderDisplay.RESET();
        ShowSH := false;
        if (SalesDocumentTypeFilter = SalesDocumentTypeFilter::All) or (SalesDocumentTypeFilter = SalesDocumentTypeFilter::Order) then begin
            case SalesTypeFilter of
                SalesTypeFilter::Campaign:
                    SalesHeaderDisplay.SETRANGE("Campaign No.", SalesCodeFilter);
                SalesTypeFilter::Customer:
                    SalesHeaderDisplay.SETRANGE("Sell-to Customer No.", SalesCodeFilter);
                SalesTypeFilter::"Customer Price Group":
                    SalesHeaderDisplay.SETRANGE("Customer Price Group", SalesCodeFilter);
            end;
            if FilterDate <> '' then
                SalesHeaderDisplay.SETFILTER("Posting Date", FilterDate);
            SalesHeaderDisplay.SETRANGE("Document Type", SalesHeaderDisplay."Document Type"::Order);

            if SalesHeaderDisplay.FINDFIRST() then
                repeat
                    SL.RESET();
                    SL.SETRANGE("Document No.", SalesHeaderDisplay."No.");
                    SL.SETRANGE(Type, SL.Type::Item);
                    if SL.FINDFIRST() then
                        ShowSH := true;
                until SalesHeaderDisplay.NEXT() = 0;
        end;

        SalesInvoiceHeaderDisplay.RESET();
        ShowSIH := false;
        if (SalesDocumentTypeFilter = SalesDocumentTypeFilter::All) or (SalesDocumentTypeFilter = SalesDocumentTypeFilter::Invoice) then begin
            case SalesTypeFilter of
                SalesTypeFilter::Campaign:
                    SalesInvoiceHeaderDisplay.SETRANGE("Campaign No.", SalesCodeFilter);
                SalesTypeFilter::Customer:
                    SalesInvoiceHeaderDisplay.SETRANGE("Sell-to Customer No.", SalesCodeFilter);
                SalesTypeFilter::"Customer Price Group":
                    SalesInvoiceHeaderDisplay.SETRANGE("Customer Price Group", SalesCodeFilter);
            end;
            if FilterDate <> '' then
                SalesInvoiceHeaderDisplay.SETFILTER("Posting Date", FilterDate);

            if SalesInvoiceHeaderDisplay.FINDFIRST() then
                repeat
                    SIL.RESET();
                    SIL.SETRANGE("Document No.", SalesInvoiceHeaderDisplay."No.");
                    SIL.SETRANGE(Type, SL.Type::Item);
                    if SIL.FINDFIRST() then
                        ShowSIH := true;
                until SalesInvoiceHeaderDisplay.NEXT() = 0;
        end;

        SalesShipmentHeaderDisplay.RESET();
        ShowSSH := false;
        if (SalesDocumentTypeFilter = SalesDocumentTypeFilter::All) or (SalesDocumentTypeFilter = SalesDocumentTypeFilter::Shipment) then begin
            case SalesTypeFilter of
                SalesTypeFilter::Campaign:
                    SalesShipmentHeaderDisplay.SETRANGE("Campaign No.", SalesCodeFilter);
                SalesTypeFilter::Customer:
                    SalesShipmentHeaderDisplay.SETRANGE("Sell-to Customer No.", SalesCodeFilter);
                SalesTypeFilter::"Customer Price Group":
                    SalesShipmentHeaderDisplay.SETRANGE("Customer Price Group", SalesCodeFilter);
            end;
            if FilterDate <> '' then
                SalesShipmentHeaderDisplay.SETFILTER("Posting Date", FilterDate);

            if SalesShipmentHeaderDisplay.FINDFIRST() then
                repeat
                    SSL.RESET();
                    SSL.SETRANGE("Document No.", SalesShipmentHeaderDisplay."No.");
                    SSL.SETRANGE(Type, SL.Type::Item);
                    if SSL.FINDFIRST() then
                        ShowSSH := true;
                until SalesShipmentHeaderDisplay.NEXT() = 0;
        end;
        //>>HEI.02
    end;

    var
        CompanyInformation: Record "Company Information";
        SalesHeader: Record "Sales Header";
        SalesHeader2: Record "Sales Header";
        SalesHeader3: Record "Sales Header";
        SalesHeaderDisplay: Record "Sales Header";
        TempSalesHeader: Record "Sales Header" temporary;
        SalesHeaderArchive: Record "Sales Header Archive";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceHeaderDisplay: Record "Sales Invoice Header";
        SIL: Record "Sales Invoice Line";
        SalesLine: Record "Sales Line";
        SalesLine1: Record "Sales Line";
        SL: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentHeaderDisplay: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        SSL: Record "Sales Shipment Line";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        ShowSH: Boolean;
        ShowSIH: Boolean;
        ShowSSH: Boolean;
        ActiveCampaignUnitPrice_PSI: Decimal;
        ActiveCampaignUnitPrice_PSS: Decimal;
        ActiveCampaignUnitPrice_SO: Decimal;
        ActiveUnitDisc_PSI: Decimal;
        ActiveUnitDisc_PSS: Decimal;
        ActiveUnitDisc_SO: Decimal;
        ActiveUnitPrice_PSI: Decimal;
        ActiveUnitPrice_PSS: Decimal;
        ActiveUnitPrice_SO: Decimal;
        CalculatedUnitPrice_PSI: Decimal;
        CalculatedUnitPrice_PSS: Decimal;
        CalculatedUnitPrice_SO: Decimal;
        DocFinalPriceExclVAT_PSI: Decimal;
        DocFinalPriceExclVAT_PSS: Decimal;
        DocFinalPriceExclVAT_SO: Decimal;
        SalesCodeFilterError: Label 'Sales Code Filter must have a value!!';
        SalesDocumentTypeFilter: Option All,"Order",Shipment,Invoice;
        SalesTypeFilter: Option Customer,"Customer Price Group","All Customers",Campaign,"None";
        FilterDate: Text;
        SalesCodeFilter: Text;

    local procedure GetDocFinalPrice_SO(SalesLine2: Record "Sales Line"): Decimal;
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        GlAccDiscAmount: Decimal;
        GlAccDiscPrice: Decimal;
        ItemChargeDiscAmount: Decimal;
        ItemChargeDiscPrice: Decimal;
        LineDiscPrice: Decimal;
        UnitDiscAmountExclVAT: Decimal;
    begin
        GeneralLedgerSetup.GET();
        CLEAR(LineDiscPrice);
        if (SalesLine2."Line Discount Amount" <> 0) and (SalesLine2.Quantity <> 0) then
            LineDiscPrice := ROUND((SalesLine2."Line Discount Amount" / SalesLine2.Quantity), GeneralLedgerSetup."Unit-Amount Rounding Precision", '=');
        CLEAR(ItemChargeDiscPrice);
        CLEAR(ItemChargeDiscAmount);
        CLEAR(GlAccDiscPrice);
        CLEAR(GlAccDiscAmount);
        // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")>>
        // SalesLine.RESET();
        // SalesLine.SETRANGE("Document Type", SalesLine2."Document Type");
        // SalesLine.SETRANGE("Document No.", SalesLine2."Document No.");
        // SalesLine.SETRANGE("Attached to Line No.", SalesLine2."Line No.");
        // if SalesLine.FINDSET() then
        //     repeat
        // if (SalesLine.Type = SalesLine.Type::"Charge (Item)") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
        //     ItemChargeDiscPrice += SalesLine."Unit Price";
        //     ItemChargeDiscAmount += SalesLine."Line Amount" * -1;
        // end;
        // if (SalesLine.Type = SalesLine.Type::"G/L Account") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
        //     GlAccDiscPrice += SalesLine."Unit Price";
        //     GlAccDiscAmount += SalesLine."Line Amount" * -1;
        // end;

        // until SalesLine.NEXT() = 0;
        // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")<<

        UnitDiscAmountExclVAT := SalesLine2."Unit Price" - (LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice);
        exit(UnitDiscAmountExclVAT);
    end;

    local procedure GetActiveUnitDisc_SO(SalesLine2: Record "Sales Line"): Decimal;
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        GlAccDiscAmount: Decimal;
        GlAccDiscPrice: Decimal;
        ItemChargeDiscAmount: Decimal;
        ItemChargeDiscPrice: Decimal;
        LineDiscPrice: Decimal;
        UnitDiscAmountExclVAT: Decimal;
    begin
        GeneralLedgerSetup.GET();
        CLEAR(LineDiscPrice);
        if (SalesLine2."Line Discount Amount" <> 0) and (SalesLine2.Quantity <> 0) then
            LineDiscPrice := ROUND((SalesLine2."Line Discount Amount" / SalesLine2.Quantity), GeneralLedgerSetup."Unit-Amount Rounding Precision", '>');
        CLEAR(ItemChargeDiscPrice);
        CLEAR(ItemChargeDiscAmount);
        CLEAR(GlAccDiscPrice);
        CLEAR(GlAccDiscAmount);
        // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")>>
        // SalesLine.RESET();
        // SalesLine.SETRANGE("Document Type", SalesLine2."Document Type");
        // SalesLine.SETRANGE("Document No.", SalesLine2."Document No.");
        // SalesLine.SETRANGE("Attached to Line No.", SalesLine2."Line No.");
        // if SalesLine.FINDSET() then
        //     repeat
        // if (SalesLine.Type = SalesLine.Type::"Charge (Item)") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
        //     ItemChargeDiscPrice += SalesLine."Unit Price";
        //     ItemChargeDiscAmount += SalesLine."Line Amount" * -1;
        // end;
        // if (SalesLine.Type = SalesLine.Type::"G/L Account") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
        //     GlAccDiscPrice += SalesLine."Unit Price";
        //     GlAccDiscAmount += SalesLine."Line Amount" * -1;
        // end;
        // until SalesLine.NEXT() = 0;
        // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")<<

        UnitDiscAmountExclVAT := ROUND(LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice, GeneralLedgerSetup."Unit-Amount Rounding Precision", '=');
        exit(UnitDiscAmountExclVAT);
    end;

    local procedure GetDocFinalPrice_PSI(SalesLine2: Record "Sales Line"): Decimal;
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        GlAccDiscAmount: Decimal;
        GlAccDiscPrice: Decimal;
        ItemChargeDiscAmount: Decimal;
        ItemChargeDiscPrice: Decimal;
        LineDiscPrice: Decimal;
        UnitDiscAmountExclVAT: Decimal;
    begin
        CLEAR(LineDiscPrice);
        GeneralLedgerSetup.GET();
        if SalesLine2."Line Discount Amount" <> 0 then
            LineDiscPrice := ROUND((SalesLine2."Line Discount Amount" / SalesLine2.Quantity), GeneralLedgerSetup."Unit-Amount Rounding Precision", '=');
        CLEAR(ItemChargeDiscPrice);
        CLEAR(ItemChargeDiscAmount);
        CLEAR(GlAccDiscPrice);
        CLEAR(GlAccDiscAmount);
        // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")>>
        // SalesLine.RESET();
        // SalesLine.SETRANGE("Document Type", SalesLine2."Document Type");
        // SalesLine.SETRANGE("Document No.", SalesLine2."Document No.");
        // SalesLine.SETRANGE("Attached to Line No.", SalesLine2."Line No.");
        // if SalesLine.FINDSET() then
        //     repeat
        // if (SalesLine.Type = SalesLine.Type::"Charge (Item)") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
        //     ItemChargeDiscPrice += SalesLine."Unit Price";
        //     ItemChargeDiscAmount += SalesLine."Line Amount" * -1;
        // end;
        // if (SalesLine.Type = SalesLine.Type::"G/L Account") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
        //     GlAccDiscPrice += SalesLine."Unit Price";
        //     GlAccDiscAmount += SalesLine."Line Amount" * -1;
        // end;
        // until SalesLine.NEXT() = 0;
        // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")<<

        if SalesLine2."Inv. Discount Amount" <> 0 then
            UnitDiscAmountExclVAT := ROUND(SalesLine2."Unit Price" - (LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice + (SalesLine2."Inv. Discount Amount" / SalesLine2.Quantity)), GeneralLedgerSetup."Unit-Amount Rounding Precision", '=')
        else
            UnitDiscAmountExclVAT := ROUND(SalesLine2."Unit Price" - (LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice), GeneralLedgerSetup."Unit-Amount Rounding Precision", '=');
        exit(UnitDiscAmountExclVAT);
    end;

    local procedure GetActiveUnitDisc_PSI(SalesLine2: Record "Sales Line"): Decimal;
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        GlAccDiscAmount: Decimal;
        GlAccDiscPrice: Decimal;
        ItemChargeDiscAmount: Decimal;
        ItemChargeDiscPrice: Decimal;
        LineDiscPrice: Decimal;
        UnitDiscAmountExclVAT: Decimal;
    begin
        GeneralLedgerSetup.GET();
        CLEAR(LineDiscPrice);
        if SalesLine2."Line Discount Amount" <> 0 then
            LineDiscPrice := ROUND((SalesLine2."Line Discount Amount" / SalesLine2.Quantity), GeneralLedgerSetup."Unit-Amount Rounding Precision", '>');
        CLEAR(ItemChargeDiscPrice);
        CLEAR(ItemChargeDiscAmount);
        CLEAR(GlAccDiscPrice);
        CLEAR(GlAccDiscAmount);
        // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")>>
        // SalesLine.RESET();
        // SalesLine.SETRANGE("Document Type", SalesLine2."Document Type");
        // SalesLine.SETRANGE("Document No.", SalesLine2."Document No.");
        // SalesLine.SETRANGE("Attached to Line No.", SalesLine2."Line No.");
        // if SalesLine.FINDSET() then
        //     repeat

        // if (SalesLine.Type = SalesLine.Type::"Charge (Item)") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
        //     ItemChargeDiscPrice += SalesLine."Unit Price";
        //     ItemChargeDiscAmount += SalesLine."Line Amount" * -1;
        // end;
        // if (SalesLine.Type = SalesLine.Type::"G/L Account") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
        //     GlAccDiscPrice += SalesLine."Unit Price";
        //     GlAccDiscAmount += SalesLine."Line Amount" * -1;
        // end;

        // until SalesLine.NEXT() = 0;
        // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")<<
        if SalesLine2."Inv. Discount Amount" <> 0 then
            UnitDiscAmountExclVAT := ROUND(LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice + (SalesLine2."Inv. Discount Amount" / SalesLine2.Quantity), GeneralLedgerSetup."Unit-Amount Rounding Precision", '=')
        else
            UnitDiscAmountExclVAT := ROUND(LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice, GeneralLedgerSetup."Unit-Amount Rounding Precision", '=');
        exit(UnitDiscAmountExclVAT);
    end;

    local procedure ConvertPriceToLineUOM(Price: Decimal; ItemNo: Code[20]; UOM: Code[20]): Decimal;
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
    begin
        GeneralLedgerSetup.GET();
        Item.GET(ItemNo);
        if UOM <> Item."Base Unit of Measure" then begin
            exit(ROUND((Price / ItemUnitofMeasure."Qty. per Unit of Measure"), GeneralLedgerSetup."Unit-Amount Rounding Precision", '='))
        end else begin
            exit(Price)
        end;
    end;

    local procedure InitTempSalesHeader(OrderNo: Code[20]; OrderLineNo: Integer; VersionNo: Integer);
    var
        SalesHeaderArchive2: Record "Sales Header Archive";
    begin
        SalesHeaderArchive2.RESET();
        SalesHeaderArchive2.SETRANGE("Document Type", SalesHeaderArchive2."Document Type"::Order);
        SalesHeaderArchive2.SETRANGE("No.", OrderNo);
        SalesHeaderArchive2.SETRANGE("Version No.", VersionNo);
        if SalesHeaderArchive2.FINDFIRST() then begin
            TempSalesHeader.RESET();
            TempSalesHeader.DELETEALL();
            TempSalesHeader.TRANSFERFIELDS(SalesHeaderArchive2);
            TempSalesHeader.INSERT();
        end;
    end;

    local procedure InitTempSalesLine(OrderNo: Code[20]; OrderLineNo: Integer; VersionNo: Integer);
    var
        SalesLineArchive2: Record "Sales Line Archive";
    begin
        SalesLineArchive2.RESET();
        SalesLineArchive2.SETRANGE(SalesLineArchive2."Document Type", SalesLineArchive2."Document Type"::Order);
        SalesLineArchive2.SETRANGE(SalesLineArchive2."Document No.", OrderNo);
        SalesLineArchive2.SETRANGE(SalesLineArchive2."Version No.", VersionNo);
        SalesLineArchive2.SETRANGE("Line No.", OrderLineNo);
        if SalesLineArchive2.FINDFIRST() then begin
            TempSalesLine.RESET();
            TempSalesLine.DELETEALL();
            TempSalesLine.TRANSFERFIELDS(SalesLineArchive2);
            TempSalesLine.INSERT();
        end;
    end;

    local procedure GetDocFinalPriceTemp_PSI(SalesHeaderArchive2: Record "Sales Header Archive"; LineNo: Integer): Decimal;
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        SalesLineArchive: Record "Sales Line Archive";
        GlAccDiscAmount: Decimal;
        GlAccDiscPrice: Decimal;
        ItemChargeDiscAmount: Decimal;
        ItemChargeDiscPrice: Decimal;
        LineDiscPrice: Decimal;
        UnitDiscAmountExclVAT: Decimal;
    begin
        SalesLineArchive.RESET();
        SalesLineArchive.SETRANGE("Document Type", SalesHeaderArchive2."Document Type");
        SalesLineArchive.SETRANGE("Document No.", SalesHeaderArchive2."No.");
        SalesLineArchive.SETRANGE("Version No.", SalesHeaderArchive2."Version No.");
        SalesLineArchive.SETRANGE("Line No.", LineNo);
        if SalesLineArchive.FINDFIRST() then begin
            CLEAR(LineDiscPrice);
            GeneralLedgerSetup.GET();
            if SalesLineArchive."Line Discount Amount" <> 0 then
                LineDiscPrice := ROUND((SalesLineArchive."Line Discount Amount" / SalesLineArchive.Quantity), GeneralLedgerSetup."Unit-Amount Rounding Precision", '=');

            CLEAR(ItemChargeDiscPrice);
            CLEAR(ItemChargeDiscAmount);
            CLEAR(GlAccDiscPrice);
            CLEAR(GlAccDiscAmount);
            // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")>>
            // SalesLine.RESET();
            // SalesLine.SETRANGE("Document Type", SalesLineArchive."Document Type");
            // SalesLine.SETRANGE("Document No.", SalesLineArchive."Document No.");
            // SalesLine.SETRANGE("Attached to Line No.", SalesLineArchive."Line No.");
            // if SalesLine.FINDSET() then
            //     repeat
            // if (SalesLine.Type = SalesLine.Type::"Charge (Item)") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
            //     ItemChargeDiscPrice += SalesLine."Unit Price";
            //     ItemChargeDiscAmount += SalesLine."Line Amount" * -1;
            // end;
            // if (SalesLine.Type = SalesLine.Type::"G/L Account") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
            //     GlAccDiscPrice += SalesLine."Unit Price";
            //     GlAccDiscAmount += SalesLine."Line Amount" * -1;
            // end;
            // until SalesLine.NEXT() = 0;
            // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")<<
            if SalesLineArchive."Inv. Discount Amount" <> 0 then
                UnitDiscAmountExclVAT := ROUND(SalesLineArchive."Unit Price" - (LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice + (SalesLineArchive."Inv. Discount Amount" / SalesLineArchive.Quantity)), GeneralLedgerSetup."Unit-Amount Rounding Precision", '=')
            else
                UnitDiscAmountExclVAT := ROUND(SalesLineArchive."Unit Price" - (LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice), GeneralLedgerSetup."Unit-Amount Rounding Precision", '=');
            exit(UnitDiscAmountExclVAT);
        end;
    end;

    local procedure GetActiveUnitDiscTemp_PSI(SalesHeaderArchive2: Record "Sales Header Archive"; LineNo: Integer): Decimal;
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        SalesLineArchive: Record "Sales Line Archive";
        GlAccDiscAmount: Decimal;
        GlAccDiscPrice: Decimal;
        ItemChargeDiscAmount: Decimal;
        ItemChargeDiscPrice: Decimal;
        LineDiscPrice: Decimal;
        UnitDiscAmountExclVAT: Decimal;
    begin
        SalesLineArchive.RESET();
        SalesLineArchive.SETRANGE("Document Type", SalesHeaderArchive2."Document Type");
        SalesLineArchive.SETRANGE("Document No.", SalesHeaderArchive2."No.");
        SalesLineArchive.SETRANGE("Version No.", SalesHeaderArchive2."Version No.");
        SalesLineArchive.SETRANGE("Line No.", LineNo);
        if SalesLineArchive.FINDFIRST() then begin
            GeneralLedgerSetup.GET();
            CLEAR(LineDiscPrice);
            if SalesLineArchive."Line Discount Amount" <> 0 then
                LineDiscPrice := ROUND((SalesLineArchive."Line Discount Amount" / SalesLineArchive.Quantity), GeneralLedgerSetup."Unit-Amount Rounding Precision", '>');
            CLEAR(ItemChargeDiscPrice);
            CLEAR(ItemChargeDiscAmount);
            CLEAR(GlAccDiscPrice);
            CLEAR(GlAccDiscAmount);
            // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")>>
            // SalesLine.RESET();
            // SalesLine.SETRANGE("Document Type", SalesLineArchive."Document Type");
            // SalesLine.SETRANGE("Document No.", SalesLineArchive."Document No.");
            // SalesLine.SETRANGE("Attached to Line No.", SalesLineArchive."Line No.");
            // if SalesLine.FINDSET() then
            //     repeat
            // if (SalesLine.Type = SalesLine.Type::"Charge (Item)") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
            //     ItemChargeDiscPrice += SalesLine."Unit Price";
            //     ItemChargeDiscAmount += SalesLine."Line Amount" * -1;
            // end;
            // if (SalesLine.Type = SalesLine.Type::"G/L Account") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
            //     GlAccDiscPrice += SalesLine."Unit Price";
            //     GlAccDiscAmount += SalesLine."Line Amount" * -1;
            // end;

            // until SalesLine.NEXT() = 0;
            // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")<<
            if SalesLineArchive."Inv. Discount Amount" <> 0 then
                UnitDiscAmountExclVAT := ROUND(LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice + (SalesLineArchive."Inv. Discount Amount" / SalesLineArchive.Quantity), GeneralLedgerSetup."Unit-Amount Rounding Precision", '=')
            else
                UnitDiscAmountExclVAT := ROUND(LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice, GeneralLedgerSetup."Unit-Amount Rounding Precision", '=');
            exit(UnitDiscAmountExclVAT);
        end;
    end;

    local procedure GetDocFinalPrice_PSI2(SalesInvoiceLine2: Record "Sales Invoice Line"): Decimal;
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesInvoiceLine3: Record "Sales Invoice Line";
        SalesLine: Record "Sales Line";
        GlAccDiscAmount: Decimal;
        GlAccDiscPrice: Decimal;
        ItemChargeDiscAmount: Decimal;
        ItemChargeDiscPrice: Decimal;
        LineDiscPrice: Decimal;
        UnitDiscAmountExclVAT: Decimal;
    begin
        //<<HEI.03
        GeneralLedgerSetup.GET();

        CLEAR(LineDiscPrice);

        if SalesInvoiceLine2."Line Discount Amount" <> 0 then
            LineDiscPrice := ROUND((SalesInvoiceLine2."Line Discount Amount" / SalesInvoiceLine2.Quantity), GeneralLedgerSetup."Unit-Amount Rounding Precision", '=');

        CLEAR(ItemChargeDiscPrice);
        CLEAR(ItemChargeDiscAmount);
        CLEAR(GlAccDiscPrice);
        CLEAR(GlAccDiscAmount);
        // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")>>
        // SalesInvoiceLine3.RESET();
        // SalesInvoiceLine3.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        // SalesInvoiceLine3.SETRANGE("Attached to Line No.", SalesInvoiceLine2."Line No.");
        // if SalesInvoiceLine3.FINDSET() then
        //     repeat
        // if (SalesInvoiceLine3.Type = SalesInvoiceLine3.Type::"Charge (Item)") and (SalesInvoiceLine3."Item Charge Type" = SalesInvoiceLine3."Item Charge Type"::Discount) then begin
        //     ItemChargeDiscPrice += SalesInvoiceLine3."Unit Price";
        //     ItemChargeDiscAmount += SalesInvoiceLine3."Line Amount" * -1;
        // end;
        // if (SalesInvoiceLine3.Type = SalesInvoiceLine3.Type::"G/L Account") and (SalesInvoiceLine3."Item Charge Type" = SalesInvoiceLine3."Item Charge Type"::Discount) then begin
        //     GlAccDiscPrice += SalesInvoiceLine3."Unit Price";
        //     GlAccDiscAmount += SalesInvoiceLine3."Line Amount" * -1;
        // end;

        // until SalesInvoiceLine3.NEXT() = 0;
        // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")<<
        if SalesInvoiceLine2."Inv. Discount Amount" <> 0 then
            UnitDiscAmountExclVAT := ROUND(SalesInvoiceLine2."Unit Price" - (LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice + (SalesInvoiceLine2."Inv. Discount Amount" / SalesInvoiceLine2.Quantity)), GeneralLedgerSetup."Unit-Amount Rounding Precision", '=')
        else
            UnitDiscAmountExclVAT := ROUND(SalesInvoiceLine2."Unit Price" - (LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice), GeneralLedgerSetup."Unit-Amount Rounding Precision", '=');
        exit(UnitDiscAmountExclVAT);
        //>>HEI.03
    end;

    local procedure GetActiveUnitDisc_PSI2(SalesInvoiceLine2: Record "Sales Invoice Line"): Decimal;
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesInvoiceLine: Record "Sales Invoice Line";
        GlAccDiscAmount: Decimal;
        GlAccDiscPrice: Decimal;
        ItemChargeDiscAmount: Decimal;
        ItemChargeDiscPrice: Decimal;
        LineDiscPrice: Decimal;
        UnitDiscAmountExclVAT: Decimal;
    begin
        //<<HEI.04
        GeneralLedgerSetup.GET();
        CLEAR(LineDiscPrice);
        if SalesInvoiceLine2."Line Discount Amount" <> 0 then
            LineDiscPrice := ROUND((SalesInvoiceLine2."Line Discount Amount" / SalesInvoiceLine2.Quantity), GeneralLedgerSetup."Unit-Amount Rounding Precision", '>');
        CLEAR(ItemChargeDiscPrice);
        CLEAR(ItemChargeDiscAmount);
        CLEAR(GlAccDiscPrice);
        CLEAR(GlAccDiscAmount);
        // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")>>
        // SalesInvoiceLine.RESET();
        // SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        // SalesInvoiceLine.SETRANGE("Attached to Line No.", SalesInvoiceLine2."Line No.");
        // if SalesInvoiceLine.FINDSET() then
        //     repeat
        // if (SalesInvoiceLine.Type = SalesInvoiceLine.Type::"Charge (Item)") and (SalesInvoiceLine."Item Charge Type" = SalesInvoiceLine."Item Charge Type"::Discount) then begin
        //     ItemChargeDiscPrice += SalesInvoiceLine."Unit Price";
        //     ItemChargeDiscAmount += SalesInvoiceLine."Line Amount" * -1;
        // end;
        // if (SalesInvoiceLine.Type = SalesInvoiceLine.Type::"G/L Account") and (SalesInvoiceLine."Item Charge Type" = SalesInvoiceLine."Item Charge Type"::Discount) then begin
        //     GlAccDiscPrice += SalesInvoiceLine."Unit Price";
        //     GlAccDiscAmount += SalesInvoiceLine."Line Amount" * -1;
        // end;

        // until SalesInvoiceLine.NEXT() = 0;
        // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")<<
        if SalesInvoiceLine2."Inv. Discount Amount" <> 0 then
            UnitDiscAmountExclVAT := ROUND(LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice + (SalesInvoiceLine2."Inv. Discount Amount" / SalesInvoiceLine2.Quantity), GeneralLedgerSetup."Unit-Amount Rounding Precision", '=')
        else
            UnitDiscAmountExclVAT := ROUND(LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice, GeneralLedgerSetup."Unit-Amount Rounding Precision", '=');
        exit(UnitDiscAmountExclVAT);
        //>>HEI.04
    end;
}

