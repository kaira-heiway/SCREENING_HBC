page 52031 "PO/NPO/EXP Purch. Inv. Archs."
{
    // version NAVW110.0,HEI.02

    // HEI.02 FDD PTPGAP081 IBM POSTOI01 07.05.2018
    //   # add code OnPage
    //   # comment line OnPage
    //   #change name of the page : PO/NPO/EXP Purch. Inv. Archs.
    // HEI.03 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    // BC Upgrade BHARDA11 >>
    // 1. old Page ID - 50043.
    // 2. Remove Drink-IT ("Document Subtype Code", "Doc. Amount Incl. VAT", "Doc. Amount VAT"), and related code.
    // 3. Add ApplicationArea property in all fields , page and actions.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Deleted Purchase Invoice Archives';
    CardPageID = "PO/NPO/EXP Purch. Inv. Arch.";
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Header Archive";
    SourceTableView = WHERE("Document Type" = CONST(Invoice));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the version number of the archived document.';
                }
                field("Date Archived"; Rec."Date Archived")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the document was archived.';
                }
                field("Time Archived"; Rec."Time Archived")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies what time the document was archived.';
                }
                field("Archived By"; Rec."Archived By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user ID of the person who archived this document.';
                }
                field("Interaction Exist"; Rec."Interaction Exist")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the archived document is linked to an interaction log entry.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade VAMSIU01 - field added >>
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade VAMSIU01 - field added >>

                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Doc. Amount Incl. VAT", "Doc. Amount VAT")
                // field("Doc. Amount Incl. VAT"; Rec."Doc. Amount Incl. VAT")
                // {
                //     ApplicationArea = All;
                // }
                // field("Doc. Amount VAT"; Rec."Doc. Amount VAT")
                // {
                //     ApplicationArea = All;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Doc. Amount Incl. VAT", "Doc. Amount VAT")
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = true;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies information about sales quotes, purchase quotes, or orders in earlier versions of the document.';
                    Visible = false;
                }
                field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;
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
                // BC Upgrade BHARDA11 >> --30April2026
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
                // BC Upgrade BHARDA11 << --30April2026
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
        Rec.SETFILTER("Document Subtype Code FND", '=%1|%2|%3', PurchasesPayablesSetup."PO Subtype Code FND", PurchasesPayablesSetup."NPO Subtype Code FND", PurchasesPayablesSetup."Expense Claim Subdoc. Type FND"); // BC Upgrade VAMSIU01- added("Document Subtype Code") >>
        //<<HEI.02
        Rec.FILTERGROUP(0);
        //HEI.01<<
    end;

    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
}

