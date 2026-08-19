report 53032 "Unregistered Shipments"
{
    // version HEI.01

    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Report from HEI2.0

    // BC Upgrade RAHUL>>
    // 1. Added ApplicationArea = All property at report level for Business Central visibility.
    //    Old: ApplicationArea property not defined at report level.
    //    New: ApplicationArea = All added at report level.
    //
    // 2. Added UsageCategory = ReportsAndAnalysis property at report level for Business Central search.
    //    Old: UsageCategory not defined.
    //    New: UsageCategory = ReportsAndAnalysis added at report level.
    //
    // 3. Added ApplicationArea property to request page field for BC compliance.
    //    Old: Request page field "Show Details" did not have ApplicationArea defined.
    //    New: ApplicationArea = All added to "Show Details" field.
    //
    // 4. No functional logic changes performed in report dataset or processing.
    //    Old: Report fetches unregistered Sales, Transfer, Return, and Warehouse Shipments
    //         based on empty Gate Entry No. filters.
    //    New: Same data items, filters, and business logic retained without modification.
    //
    // 5. Layout and output behavior unchanged.
    //    Old: RDLC layout used for report rendering.
    //    New: Same RDLC layout retained; no changes to layout or dataset structure.
    //
    // 6. Report upgrade reference.
    //    Old Report ID: 50191
    //    New: Report upgraded for Business Central with ApplicationArea and UsageCategory compliance.
    //
    // BC Upgrade RAHUL<<

    DefaultLayout = RDLC;
    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade KUMARR78 Adding UsageCategory
    RDLCLayout = '.\src\ReportsLayout\Unregistered Shipments.rdl';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = sorting("No.") where("Gate Entry No. FND" = filter(''), "Location Code" = filter(<> ''));
            column(ShowDetails; ShowDetails)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(RepDate; Format(Today, 0, 4))
            {
            }
            column(SalShipNo; "Sales Shipment Header"."No.")
            {
            }
            column(SalShipPosDate; Format("Sales Shipment Header"."Posting Date"))
            {
            }
            column(SalShipCustNo; "Sales Shipment Header"."Sell-to Customer No.")
            {
            }
            column(SalShipCustName; "Sales Shipment Header"."Sell-to Customer Name")
            {
            }
            column(SalShipLoc; "Sales Shipment Header"."Location Code")
            {
            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(SalShipLType; "Sales Shipment Line".Type)
                {
                }
                column(SalShipLItemNo; "Sales Shipment Line"."No.")
                {
                }
                column(SalShipLDescrip; "Sales Shipment Line".Description)
                {
                }
                column(SalShipLUOM; "Sales Shipment Line"."Unit of Measure")
                {
                }
                column(SalShipLQty; "Sales Shipment Line".Quantity)
                {
                }
            }
        }
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = sorting("No.") where("To Gate Entry No. FND" = filter(''), "From Gate Entry No. FND" = filter(''));
            column(TransShipNo; "Transfer Shipment Header"."No.")
            {
            }
            column(TransShipPosDate; Format("Transfer Shipment Header"."Posting Date"))
            {
            }
            column(TransShipLoc; "Transfer Shipment Header"."Transfer-to Code")
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(TransShipLItemNo; "Transfer Shipment Line"."Item No.")
                {
                }
                column(TransShipLDescrip; "Transfer Shipment Line".Description)
                {
                }
                column(TransShipLUOM; "Transfer Shipment Line"."Unit of Measure")
                {
                }
                column(TransShipLQty; "Transfer Shipment Line".Quantity)
                {
                }
            }
        }
        dataitem("Return Shipment Header"; "Return Shipment Header")
        {
            DataItemTableView = sorting("No.") where("Gate Entry No. FND" = filter(''));
            column(RetShipNo; "Return Shipment Header"."No.")
            {
            }
            column(RetShipPostDate; Format("Return Shipment Header"."Posting Date"))
            {
            }
            column(RetShipVendNo; "Return Shipment Header"."Pay-to Vendor No.")
            {
            }
            column(RetShipVendName; "Return Shipment Header"."Buy-from Vendor Name")
            {
            }
            column(RetShipLoc; "Return Shipment Header"."Location Code")
            {
            }
            dataitem("Return Shipment Line"; "Return Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(RetShipLType; "Return Shipment Line".Type)
                {
                }
                column(RetShipLItemNo; "Return Shipment Line"."No.")
                {
                }
                column(RetShipLDescrip; "Return Shipment Line".Description)
                {
                }
                column(RetShipLUOM; "Return Shipment Line"."Unit of Measure")
                {
                }
                column(RetShipLQty; "Return Shipment Line".Quantity)
                {
                }
            }
        }
        dataitem("Posted Whse. Shipment Header"; "Posted Whse. Shipment Header")
        {
            DataItemTableView = sorting("No.") where("Gate Entry No. FND" = filter(''));
            column(WhsShipNo; "Posted Whse. Shipment Header"."No.")
            {
            }
            column(WhsShipPostDate; Format("Posted Whse. Shipment Header"."Posting Date"))
            {
            }
            column(WhsShipLoc; "Posted Whse. Shipment Header"."Location Code")
            {
            }
            dataitem("Posted Whse. Shipment Line"; "Posted Whse. Shipment Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.", "Line No.");
                column(WhsShipLItemNo; "Posted Whse. Shipment Line"."Item No.")
                {
                }
                column(WhsShipLDescrip; "Posted Whse. Shipment Line".Description)
                {
                }
                column(WhsShipLUOM; "Posted Whse. Shipment Line"."Unit of Measure Code")
                {
                }
                column(WhsShipLQty; "Posted Whse. Shipment Line".Quantity)
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group(Option)
                {
                    field("Show Details"; ShowDetails)
                    {
                        Caption = 'Show Details';
                        ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea to Field
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
        lblDocType = 'Document Type'; lblDocNo = 'Document No.'; lblPostDate = 'Posting Date'; lblVendCustNo = 'Vendor/ Customer No.'; lblName = 'Name'; lblLocCode = 'Location Code'; lblType = 'Type'; lblNo = 'No.'; lblDescrip = 'Description'; lblUOM = 'Unit of Measure'; lblQty = 'Quantity'; lblSalesShip = 'Sales Shipment'; lblTransShip = 'Transfer Shipment'; lblRetShip = 'Return Shipment'; lblWareShip = 'Warehouse Shipment';
    }

    var
        ShowDetails: Boolean;
        Customer: Record Customer;
        Vendor: Record Vendor;
        CompanyInfo: Record "Company Information";
}

