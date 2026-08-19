page 52022 "PO/NPO/EXP Purch. CM Archs."
{
    // version NAVW110.0,HEI.02


    // HEI.01 PTPGAP064 IBM HORTOC01 12.07.2017
    //   # New page based on standard page
    // HEI.02 FDD PTPGAP081 IBM POSTOI01 07.05.2018
    //   # add code OnPage
    //   # comment line OnPage
    //   #change name of the page : PO/NPO/EXP Purch. CM Archs.
    // HEI.03 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"

    // BC Upgrade KUMARR78 >>
    //
    // Old Page ID and Name:
    //     50051 "PO/NPO/EXP Purch. CM Archs."
    //
    // 1. Added ApplicationArea property at page level.
    //    Old:
    //         - ApplicationArea property was not defined at page level.
    //    New:
    //         - ApplicationArea = All;
    //
    // 2. Blocked DIT fields from layout.
    //    Old:
    //         - Following fields were present in repeater:
    //               "Document Subtype Code"
    //               "Doc. Amount Incl. VAT"
    //               "Doc. Amount VAT"
    //    New:
    //         - Above fields commented and blocked due to DIT dependency.
    //
    // 3. Blocked DIT dependent filtering logic in OnOpenPage trigger.
    //    Old:
    //         - SETFILTER was applied on "Document Subtype Code" using:
    //               PurchasesPayablesSetup."PO Subtype Code"
    //               PurchasesPayablesSetup."NPO Subtype Code"
    //               PurchasesPayablesSetup."Expense Claim CM Subdoc Type"
    //    New:
    //         - SETFILTER logic commented and blocked due to DIT dependency.
    //
    // 4. Modified layout fields to use Rec explicitly.
    //    Old:
    //         - Fields in repeater were defined without explicit Rec reference.
    //           Example:
    //               field("No."; "No.")
    //    New:
    //         - All layout fields updated to use Rec reference.
    //           Example:
    //               field("No."; Rec."No.")
    //
    // 5. Removed dependency on "Document Subtype Code" in filtering logic.
    //    Old:
    //         - Page filtering was based on custom DIT subtype logic.
    //    New:
    //         - Page now only filters by:
    //               SourceTableView = WHERE("Document Type" = CONST("Credit Memo"));
    // BC Upgrade KUMARR78 <<

    Caption = 'Deleted Purchase Credit Memo Archives';
    CardPageID = "PO/NPO/EXP Purch.CM Arch.";
    Editable = false;
    PageType = List;
    ApplicationArea = all; //BC UPGRADE KUMARR78 Adding ApplicationArea
    SourceTable = "Purchase Header Archive";
    SourceTableView = WHERE("Document Type" = CONST("Credit Memo"));
    UsageCategory = Lists; //BC UPGRADE ATHUKUS01 FDDSTP_008

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
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
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
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
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
                field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
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
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5179;
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0),
                                  "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                                  "Version No." = FIELD("Version No.");
                }
                // BC Upgrade BHARDA11 >> ---30April2026
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
                // BC Upgrade BHARDA11 << ---30April2026
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.SetSecurityFilterOnRespCenter;

        //HEI.01>>
        PurchasesPayablesSetup.GET;
        PurchasesPayablesSetup.TESTFIELD("PO Subtype Code FND");
        Rec.FILTERGROUP(2);
        //HEI.02 comment line SETRANGE("Document Subtype Code",PurchasesPayablesSetup."PO Subtype Code");
        //>>HEI.02
        Rec.SETFILTER("Document Subtype Code FND", '=%1|%2|%3', PurchasesPayablesSetup."PO Subtype Code FND", PurchasesPayablesSetup."NPO Subtype Code FND", PurchasesPayablesSetup."Expense ClaimCMSubdoc Type FND");//BC UPGRADE VAMSIU01 >>
        //<<HEI.02
        Rec.FILTERGROUP(0);
        //HEI.01<<
    end;

    var
        PurchasesPayablesSetup: Record 312;
}

