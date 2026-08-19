page 52024 "NPO Purch. Cr. Memo Archive"
{
    // version NAVW110.0,DITW110.00.08

    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    // DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.02 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"

    // BC Upgrade KUMARR78 >>
    //
    // Old Page ID and Name:
    //     50054 "NPO Purch. Cr. Memo Archive"
    //
    // 1. Added ApplicationArea property at page level.
    //    Old:
    //         - ApplicationArea property was not defined at page level.
    //    New:
    //         - ApplicationArea = All;
    //
    // 2. Modified layout fields to use Rec explicitly.
    //    Old:
    //         - Fields were defined without explicit Rec reference.
    //           Example:
    //               field("No."; "No.")
    //    New:
    //         - All fields updated to use Rec reference.
    //           Example:
    //               field("No."; Rec."No.")
    //
    // 3. Blocked DIT fields from layout.
    //    Old:
    //         - Following DIT fields were present:
    //               "Creation Date/Time"
    //               "Created By"
    //    New:
    //         - Above fields commented and blocked due to DIT dependency.
    //
    // 4. Renamed conflicting field Area to RArea.
    //    Old:
    //         - field(Area; Rec.Area)
    //    New:
    //         - field(RArea; Rec.Area)
    //         - Caption maintained as 'Area'.
    //         - Renamed due to conflict with standard BC field naming.
    //
    // BC Upgrade KUMARR78 <<

    Caption = 'NPO Purch. Cr. Memo Archive';
    DeleteAllowed = false;
    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
    Editable = false;
    PageType = Document;
    SourceTable = "Purchase Header Archive";
    SourceTableView = WHERE("Document Type" = CONST("Credit Memo"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Order Date"; Rec."Order Date")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }

                //BC UPGRADE KUMARR78 >> Blocking DIT Field
                // field("Creation Date/Time"; Rec."Creation Date/Time")
                // {
                //     Description = 'DITW18.00.07 DIT-770 #1282';
                //     Importance = Additional;
                // }
                // field("Created By"; Rec."Created By")
                // {
                //     Description = 'DITW18.00.07 DIT-770 #1282';
                //     Importance = Additional;
                // }
                //BC UPGRADE KUMARR78 << Blocking DIT Field
                field(Status; Rec.Status)
                {
                }
                field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
                {
                }
            }
            part(PurchLinesArchive; "PO/NPO/EXP PurchCMArch Subform")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                              "Version No." = FIELD("Version No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                }
                field("On Hold"; Rec."On Hold")
                {
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                }
                field("Transport Method"; Rec."Transport Method")
                {
                }
                field("Entry Point"; Rec."Entry Point")
                {
                }
                field(RArea; Rec.Area)//BC UPGRADE KUMARR78 Renameing Area to RArea as per Conflict with Std.
                {
                    Caption = 'Area';
                }
            }
            group(Version)
            {
                Caption = 'Version';
                field("Version No."; Rec."Version No.")
                {
                }
                field("Archived By"; Rec."Archived By")
                {
                }
                field("Date Archived"; Rec."Date Archived")
                {
                }
                field("Time Archived"; Rec."Time Archived")
                {
                }
                field("Interaction Exist"; Rec."Interaction Exist")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ver&sion")
            {
                Caption = 'Ver&sion';
                Image = Versions;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        Rec.ShowDimensions();
                        CurrPage.SAVERECORD();
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Archive Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0),
                                  "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                                  "Version No." = FIELD("Version No.");
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;

                    trigger OnAction();
                    begin
                        DocPrint.PrintPurchHeaderArch(Rec);
                    end;
                }
            }
        }
    }

    var
        DocPrint: Codeunit "Document-Print";
}

