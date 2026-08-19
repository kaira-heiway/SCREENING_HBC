report 52013 "Unregistered Receipts"
{
    // version HEI.01

    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Report from HEI2.0

    // BC Upgrade KUMARR78>>
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
    //    Old: Report retrieves unregistered Purchase, Transfer, Return, and Warehouse Receipts
    //         using Gate Entry No. blank filters and Location Code validations.
    //    New: Same data items, filters, and business logic retained without modification.
    //
    // 5. Layout and output behavior unchanged.
    //    Old: RDLC layout used for report rendering.
    //    New: Same RDLC layout retained; no changes to layout or dataset structure.
    //
    // 6. Report upgrade reference.
    //    Old Report ID: 50190
    //    New: Report upgraded for Business Central with ApplicationArea and UsageCategory compliance.
    //
    // BC Upgrade KUMARR78<<

    DefaultLayout = RDLC;
    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade KUMARR78 Adding UsageCategory
    RDLCLayout = '.\src\ReportsLayout\Unregistered Receipts.rdl';


    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = sorting("No.") where("Location Code" = filter(<> ''), "Gate Entry No. FND" = filter(''));
            column(ShowDetails; ShowDetails)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(RepDate; Format(Today, 0, 4))
            {
            }
            column(PurchRcptNo; "Purch. Rcpt. Header"."No.")
            {
            }
            column(PurchRcptVendNo; "Purch. Rcpt. Header"."Buy-from Vendor No.")
            {
            }
            column(PurchRcptPostDate; Format("Purch. Rcpt. Header"."Posting Date"))
            {
            }
            column(PurchRcptLocCode; "Purch. Rcpt. Header"."Location Code")
            {
            }
            column(PurchRcptVendName; "Purch. Rcpt. Header"."Buy-from Vendor Name")
            {
            }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") where("Gate Entry No. FND" = filter(''));
                column(PurchRcptLType; "Purch. Rcpt. Line".Type)
                {
                }
                column(PurchRcptLNo; "Purch. Rcpt. Line"."No.")
                {
                }
                column(PurchRcptLDescrip; "Purch. Rcpt. Line".Description)
                {
                }
                column(PurchRcptLUOM; "Purch. Rcpt. Line"."Unit of Measure")
                {
                }
                column(PurchRcptLQty; "Purch. Rcpt. Line".Quantity)
                {
                }
            }
        }
        dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
        {
            DataItemTableView = sorting("No.") where("To Gate Entry No. FND" = filter(''), "From Gate Entry No. FND" = filter(''));
            column(TransRcptNo; "Transfer Receipt Header"."No.")
            {
            }
            column(TransRcptPostDate; Format("Transfer Receipt Header"."Posting Date"))
            {
            }
            column(TransRcptToCode; "Transfer Receipt Header"."Transfer-to Code")
            {
            }
            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") where("From Gate Entry No. FND" = filter(''));
                column(TransRcptLItemNo; "Transfer Receipt Line"."Item No.")
                {
                }
                column(TransRcptLDescrip; "Transfer Receipt Line".Description)
                {
                }
                column(TransRcptLUOM; "Transfer Receipt Line"."Unit of Measure")
                {
                }
                column(TransRcptLQty; "Transfer Receipt Line".Quantity)
                {
                }
            }
        }
        dataitem("Return Receipt Header"; "Return Receipt Header")
        {
            DataItemTableView = sorting("No.") where("Location Code" = filter(<> ''), "Gate Entry No. FND" = filter(''));
            column(RetRcptNo; "Return Receipt Header"."No.")
            {
            }
            column(RetRcptPostDate; Format("Return Receipt Header"."Posting Date"))
            {
            }
            column(RetRcptCustNo; "Return Receipt Header"."Sell-to Customer No.")
            {
            }
            column(RetRcptCustName; "Return Receipt Header"."Sell-to Customer Name")
            {
            }
            column(RetRcptLocCode; "Return Receipt Header"."Location Code")
            {
            }
            dataitem("Return Receipt Line"; "Return Receipt Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") where("Gate Entry No. FND" = filter(''));
                column(RetRcptType; "Return Receipt Line".Type)
                {
                }
                column(RetRcptItemNo; "Return Receipt Line"."No.")
                {
                }
                column(RetRcptDescrip; "Return Receipt Line".Description)
                {
                }
                column(RetRcptUOM; "Return Receipt Line"."Unit of Measure")
                {
                }
                column(RetRcptQty; "Return Receipt Line".Quantity)
                {
                }
            }
        }
        dataitem("Posted Whse. Receipt Header"; "Posted Whse. Receipt Header")
        {
            DataItemTableView = sorting("No.") where("Gate Entry No. FND" = filter(''));
            column(WhseRcptNo; "Posted Whse. Receipt Header"."No.")
            {
            }
            column(WhseRcptPostDate; Format("Posted Whse. Receipt Header"."Posting Date"))
            {
            }
            column(WhseRcptLocCode; "Posted Whse. Receipt Header"."Location Code")
            {
            }
            dataitem("Posted Whse. Receipt Line"; "Posted Whse. Receipt Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("Source Type", "Source Subtype", "Source No.", "Source Line No.") order(ascending);
                column(WhseRcptItemNo; "Posted Whse. Receipt Line"."Item No.")
                {
                }
                column(WhseRcptDescrip; "Posted Whse. Receipt Line".Description)
                {
                }
                column(WhseRcptUOM; "Posted Whse. Receipt Line"."Unit of Measure Code")
                {
                }
                column(WhseRcptQty; "Posted Whse. Receipt Line".Quantity)
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
        lblDocType = 'Document Type'; lblDocNo = 'Document No.'; lblPostDate = 'Posting Date'; lblVendCustNo = 'Vendor/ Customer No.'; lblName = 'Name'; lblLocCode = 'Location Code'; lblType = 'Type'; lblNo = 'No.'; lblDescrip = 'Description'; lblUOM = 'Unit of Measure'; lblQty = 'Quantity'; lblPurchRcpt = 'Purchase Receipt'; lblTransRcpt = 'Transfer Receipt'; lblRetRcpt = 'Return Receipt'; lblWareRcpt = 'Warehouse Receipt'; lblPage = 'Page No.';
    }

    trigger OnPreReport();
    begin
        CompanyInfo.Get();
    end;

    var
        CompanyInfo: Record "Company Information";
        Customer: Record Customer;
        Vendor: Record Vendor;
        ShowDetails: Boolean;
}

