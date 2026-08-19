page 52023 "PO/NPO/EXP Purch.CM Arch."
{
    // version NAVW110.0,DITW110.00.08,HEI.02

    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    // DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD PTPGAP081 IBM POSTOI01 07.05.2018
    //   #change name of the page : PO/NPO/EXP Purch. CM Arch.
    //   # show the following fields , tab General
    //   "Document Subtype Code"
    //     "Doc. Amount Incl. VAT"
    //     "Doc. Amount VAT"
    // 
    // HEI.02 defect #2234 IBM POSTOI01 05.06.2018
    //   # modify Editable property from TRUE to FALSE for field Document Subtype Code
    // BC Upgrade KUMARR78 >>
    //
    // Old Page ID and Name:
    //     50053 "PO/NPO/EXP Purch.CM Arch."
    //
    // 1. Added ApplicationArea property at page level.
    //    Old:
    //         - ApplicationArea property was not defined at page level.
    //    New:
    //         - ApplicationArea = All;
    //
    // 2. Blocked DIT dependent fields from layout (General Group).
    //    Old:
    //         - Fields present in layout:
    //               "Document Subtype Code"
    //               "Doc. Amount Incl. VAT"
    //               "Doc. Amount VAT"
    //    New:
    //         - Above fields commented and blocked due to DIT dependency.
    //
    // 3. Blocked DIT custom audit fields.
    //    Old:
    //         - Fields present in layout:
    //               "Creation Date/Time"
    //               "Created By"
    //    New:
    //         - Above fields commented and blocked as DIT customization not required in BC.
    //
    // 4. Renamed conflicting field reference (Area).
    //    Old:
    //         - field(Area; Rec.Area)
    //    New:
    //         - field(RArea; Rec.Area)
    //         - Caption = 'Area';
    //         - Renamed control to avoid conflict with standard BC identifier.
    //
    // BC Upgrade KUMARR78 <<
    // BC Upgrade - RD03 New Action Added to open the attached attachments

    Caption = 'Deleted Purchase Credit Memo Archive';
    DeleteAllowed = false;
    Editable = false;
    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
    PageType = Document;
    SourceTable = "Purchase Header Archive";
    SourceTableView = where("Document Type" = const("Credit Memo"));

    layout
    {
        area(Content)
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
                // BC UPGRADE VAMSIU01 - field added >>
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                }
                // BC UPGRADE VAMSIU01 - field added >>

                //BC UPGRADE KUMARR78 >> Blocking DIT Field
                // field("Doc. Amount Incl. VAT"; Rec."Doc. Amount Incl. VAT")
                // {
                // }
                // field("Doc. Amount VAT"; Rec."Doc. Amount VAT")
                // {
                // }
                //BC UPGRADE KUMARR78 << Blocking DIT Field
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
            }
            part(PurchLinesArchive; "PO/NPO/EXP PurchCMArch Subform")
            {
                SubPageLink = "Document No." = field("No."),
                              "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                              "Version No." = field("Version No.");
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
        area(FactBoxes)
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
        area(Navigation)
        {
            group("Ver&sion")
            {
                Caption = 'Ver&sion';
                Image = Versions;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = page 26;
                    RunPageLink = "No." = field("Buy-from Vendor No.");
                    ShortcutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    AccessByPermission = tabledata 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortcutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        Rec.ShowDimensions();
                        CurrPage.SaveRecord();
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = page 5179;
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0),
                                  "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                  "Version No." = field("Version No.");
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
                // BC Upgrade - RD03 New Action Added to open the attached attachments
                action(Attachments)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    ToolTip = 'Opens the attachments associated with the document.';
                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
                // BC Upgrade - RD03 New Action Added to open the attached attachments
            }
        }
    }

    var
        DocPrint: Codeunit "Document-Print";
}

