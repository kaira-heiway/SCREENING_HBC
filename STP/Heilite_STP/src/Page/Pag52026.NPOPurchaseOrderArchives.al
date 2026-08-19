page 52026 "NPO Purchase Order Archives"
{
    // version NAVW110.0,HEI.02

    // HEI.01 PTPGAP064 IBM HORTOC01 12.07.2017
    //   # New page based on standard page
    // HEI.02 FDD PTPGAP081 IBM POSTOI01 08.05.2018
    //   # New page action :
    //      new group: Document
    //      new actions: Receipts
    // HEI.03 CHG2121745 IBM BHATTA09 25.11.2021 - SRM - SC fields to be added in HL
    //   # Added field Amount
    //   # Added field Amount Including VAT
    //   # Added field Requester ID

    // BC Upgrade KUMARR78 >>
    //
    // Old Page ID and Name:
    //     50056 "NPO Purchase Order Archives"
    //
    // 1. Added ApplicationArea property at page level.
    //    Old:
    //         - ApplicationArea property was not defined at page level.
    //    New:
    //         - ApplicationArea = All;
    //
    // 2. Modified layout fields to use Rec explicitly.
    //    Old:
    //         - Fields in repeater were defined without explicit Rec reference.
    //           Example:
    //               field("No."; "No.")
    //    New:
    //         - All layout fields updated to use Rec reference.
    //           Example:
    //               field("No."; Rec."No.")
    //
    // 3. Blocked DIT field from layout.
    //    Old:
    //         - Field present in layout:
    //               "Requester ID"
    //    New:
    //         - Field commented and blocked due to DIT dependency.
    //
    // 4. Blocked DIT dependent validation logic in OnOpenPage trigger.
    //    Old:
    //         - PurchasesPayablesSetup.TESTFIELD("NPO Subtype Code");
    //         - Rec.SETRANGE("Document Subtype Code", PurchasesPayablesSetup."NPO Subtype Code");
    //    New:
    //         - Above DIT dependent lines commented and blocked.
    //
    // 5. Removed dependency on "Document Subtype Code" filtering.
    //    Old:
    //         - Page filtering logic depended on custom subtype setup.
    //    New:
    //         - Page now relies only on:
    //               SourceTableView = WHERE("Document Type" = CONST(Order));
    //
    // BC Upgrade KUMARR78 <<

    Caption = 'NPO Purchase Order Archives';
    CardPageID = "Purchase Order Archive";
    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Header Archive";
    SourceTableView = WHERE("Document Type" = CONST(Order));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                }
                field("Version No."; Rec."Version No.")
                {
                    ToolTip = 'Specifies the version number of the archived document.';
                }
                field("Date Archived"; Rec."Date Archived")
                {
                    ToolTip = 'Specifies the date when the document was archived.';
                }
                field("Time Archived"; Rec."Time Archived")
                {
                    ToolTip = 'Specifies what time the document was archived.';
                }
                field("Archived By"; Rec."Archived By")
                {
                    ToolTip = 'Specifies the user ID of the person who archived this document.';
                }
                field("Interaction Exist"; Rec."Interaction Exist")
                {
                    ToolTip = 'Specifies that the archived document is linked to an interaction log entry.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = true;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                }
                //BC UPGRADE KUMARR78 >> Blocking DIT Field
                // field("Requester ID"; Rec."Requester ID")
                // {
                // }
                //BC UPGRADE KUMARR78 << Blocking DIT Code

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
            }
            group(Documents)
            {
                CaptionML = ENU = 'Documents',
                            FRA = 'Documents';
                Image = Documents;
                action(Receipts)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Receipts',
                                FRA = 'Bons de réception';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.SetSecurityFilterOnRespCenter();

        //HEI.01>>
        PurchasesPayablesSetup.GET();
        // PurchasesPayablesSetup.TESTFIELD("NPO Subtype Code");//BC UPGRADE KUMARR78 >> Blocking DIT Code
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Document Subtype Code FND", PurchasesPayablesSetup."NPO Subtype Code FND");//BC UPGRADE VAMSIU01 >>
        Rec.FILTERGROUP(0);
        //HEI.01<<
    end;

    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
}

