report 53035 "IC Stock in Transit"
{
    // version HEI.01

    // HEI.01 FDD-HT657 IBM NASTAA02 27.02.2020 # Ethiopia Intercompany Automation
    //   # New Report created to display data related to IC outstanding Purchase Orders

    // BC Upgrade KUMARR78 >>
    // Report Name  : IC Stock in Transit
    // Old Report ID: 50407 (NAV)
    // 1. Added Business Central visibility properties at report level.
    //    Old: ApplicationArea and UsageCategory were not defined.
    //    New:
    //         - ApplicationArea = All
    //         - UsageCategory = ReportsAndAnalysis
    //    Reason: Required for report discoverability and role-based UI compliance in BC.
    // 2. Modified DataItemTableView due to removed field in Business Central.
    //    Old:
    //         WHERE("Document Type" = FILTER(Order | "Return Order"),
    //               "IC Document" = FILTER(true));
    //    New:
    //         WHERE("Document Type" = FILTER(Order | "Return Order"));
    //    Reason: Field "IC Document" no longer available in BC base application.
    // 3. Blocked dataset columns related to removed/unsupported DIT variables.
    //    Old Columns:
    //         - CompanyInfo."IC Partner Code"
    //         - "IC Document"
    //         - ICLogEntry."Created Document No."
    //    New: Columns removed/commented.
    //    Reason: Related table/field dependencies not available in BC.
    // 4. Blocked IC Log Entry logic as table/field not supported in BC.
    //    Old Logic:
    //         - ICLogEntry record usage
    //         - Filtering by Source Type and Document Type
    //         - Fetching related IC log entries
    //    New: Entire ICLogEntry block commented/removed.
    //    Reason: "IC Log Entry" dependency (DIT variable) not available in BC.
    // 5. Removed ICLogEntry global variable.
    //    Old:
    //         ICLogEntry: Record "IC Log Entry";
    //    New:
    //         Variable commented/removed.
    //    Reason: Table not supported in BC extension context.
    // 6. No functional change to core report logic.
    //    Old:
    //         - Displays IC outstanding Purchase Orders
    //         - Filters Purchase Lines with Outstanding Quantity > 0
    //         - Fetches related Warehouse Receipt Lines
    //         - Applies Vendor IC Partner filtering
    //    New:
    //         Same business logic retained.
    //         Only unsupported fields and tables removed for BC compatibility.
    // BC Upgrade KUMARR78 <<

    DefaultLayout = RDLC;
    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding UsageCategory
    RDLCLayout = '.\src\ReportsLayout\IC Stock in Transit.rdl';

    Caption = 'IC Stock in Transit';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.") order(ascending);
            RequestFilterFields = "IC Partner Code";
            column(Vendor_ICPartenerCode2; "IC Partner Code")
            {
            }
        }
        dataitem("Purchase Header Additional FND"; "Purchase Header Additional FND")
        {
            // DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending) WHERE("Document Type" = FILTER(Order | "Return Order"), "IC Document" = FILTER(true)); //BC Upgrade KUMARR78 Replaced as Field was Missing(IC Document)
            DataItemTableView = sorting("Document Type", "No.") order(ascending) where("Document Type" = filter(Order | "Return Order")); //BC Upgrade KUMARR78 Replacing Previous as Field was Missing(IC Document)
            PrintOnlyIfDetail = true;
            // column(CompanyInfo_ICPartenerCode; CompanyInfo."IC Partner Code")
            // {
            // } //BC Upgrade KUMARR78 Blocking as DIT variable
            column(Vendor_ICPartenerCode; Vendor2."IC Partner Code")
            {
            }
            // column(PurchaseHeaderAdditional_ICDocument; "IC Document")
            // {
            // } //BC Upgrade KUMARR78 Blocking as DIT variable
            column(PurchaseHeaderAdditional_No; "No.")
            {
            }
            // column(ICLogEntry_CreatedDocNo; ICLogEntry."Created Document No.")
            // {
            // } //BC Upgrade KUMARR78 Blocking as DIT variable
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.") order(ascending) where("Outstanding Quantity" = filter(> 0));
                RequestFilterFields = Type, "No.", "Expected Receipt Date";
                column(PurchaseLine_Type; Type)
                {
                }
                column(PurchaseLine_No; "No.")
                {
                }
                column(PurchaseLine_Description; Description)
                {
                }
                column(PurchaseLine_ICPartnerReference; "IC Partner Reference")
                {
                }
                column(PurchaseLine_UoMCode; "Unit of Measure Code")
                {
                }
                column(PurchaseLine_Quantity; Quantity)
                {
                }
                column(PurchaseLine_QuantityReceived; "Quantity Received")
                {
                }
                column(PurchaseLine_ExpectedRcptDate; "Expected Receipt Date")
                {
                }
                column(WarehouseReceiptLine_No; WarehouseReceiptLine."No.")
                {
                }
                column(WarehouseReceiptLine_QtyOutstanding; WarehouseReceiptLine."Qty. Outstanding")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    //HEI.01>>
                    Clear(WarehouseReceiptLine);
                    WarehouseReceiptLine.Reset();
                    WarehouseReceiptLine.SetFilter("Source Document", '%1|%2', WarehouseReceiptLine."Source Document"::"Purchase Order", WarehouseReceiptLine."Source Document"::"Purchase Return Order");
                    WarehouseReceiptLine.SetRange("Source No.", "Document No.");
                    WarehouseReceiptLine.SetRange("Source Line No.", "Line No.");
                    WarehouseReceiptLine.SetRange("Item No.", "No.");
                    if WarehouseReceiptLine.FindFirst() then;
                    //HEI.01<<
                end;
            }

            trigger OnAfterGetRecord();
            var
                PurchaseLine: Record "Purchase Line";
            begin
                //HEI.01>>
                Clear(PurchaseLine);
                PurchaseLine.SetFilter("Document Type", '%1|%2', PurchaseLine."Document Type"::Order, PurchaseLine."Document Type"::"Return Order");
                PurchaseLine.SetRange("Document No.", "No.");
                PurchaseLine.SetFilter("Outstanding Quantity", '>%1', 0);
                if not PurchaseLine.FindFirst() then
                    CurrReport.Skip();

                Clear(PurchaseHeader);
                Clear(Vendor2);
                PurchaseHeader.Get("Document Type", "No.");
                Vendor2.SetRange("No.", PurchaseHeader."Buy-from Vendor No.");
                if Vendor.GetFilter("IC Partner Code") <> '' then
                    Vendor2.SetRange("IC Partner Code", Vendor."IC Partner Code");
                if not Vendor2.FindFirst() then
                    CurrReport.Skip();

                //BC Upgrade KUMARR78 Blocking as DIT variable>>
                // CLEAR(ICLogEntry);
                // ICLogEntry.SETRANGE("Source Type", ICLogEntry."Source Type"::Purchase);
                // ICLogEntry.SETFILTER("Document Type", '%1|%2', ICLogEntry."Document Type"::Order, ICLogEntry."Document Type"::"Return Order");
                // ICLogEntry.SETRANGE("Document No.", PurchaseHeader."No.");
                // if ICLogEntry.FINDFIRST then;
                //HEI.02<<
                //BC Upgrade KUMARR78 Blocking as DIT variable<<
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        ReportTitleLbl = 'IC Stock in Transit'; PageLbl = 'Page'; PurchaseDocLbl = 'Purchase Document'; SalesDocLbl = 'Sales Document'; ItemCodeLbl = 'Item Code'; ItemCrossRefLbl = 'Item Cross Refernce'; DescriptionLbl = 'Description'; UoMLbl = 'UoM'; QuantityLbl = 'Quantity'; QtyReceivedLbl = 'Quantity Received'; QtyInTransitLbl = 'Quantity in Transit'; ICPartnerLbl = 'IC Partner'; ExpectedRcptDateLbl = 'Expected Receipt Date';
    }

    trigger OnPreReport();
    begin
        CompanyInfo.Get(); //HEI.01
    end;

    var
        CompanyInfo: Record "Company Information";
        PurchaseHeader: Record "Purchase Header";
        Vendor2: Record Vendor;
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
    // ICLogEntry: Record "IC Log Entry"; //BC Upgrade KUMARR78 Blocking as DIT variable
}

