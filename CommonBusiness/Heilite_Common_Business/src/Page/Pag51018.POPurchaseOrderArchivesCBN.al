page 51018 "PO Purchase Order Archives CBN"
{
    // version NAVW110.0,HEI.06

    // HEI.01 PTPGAP064 IBM HORTOC01 12.07.2017
    //   # New page based on standard page
    // HEI.02 FDD PTPGAP081 IBM POSTOI01 08.05.2018
    //   # New page action :
    //      new group: Document
    //      new actions: Receipts
    // HEI.03 FDD-HB2482 CHG2123206 IBM NANDIS01 03.11.2021 - Improvement of multiple HeiLite reports for StP  Procurement users
    //   # Added "Created By" field in the page
    //   # Added Limit PO in the page
    // HEI.04 CHG2121745 IBM BHATTA09 25.11.2021 - SRM - SC fields to be added in HL
    //   # Added "Shopping card No." field in the page
    //   # Added "Shopping Card Creation Date" in the page
    //   # Added field Amount
    //   # Added field Amount Including VAT
    //   # Added field Total Exluding VAT
    //   # Total VAT
    //   # Total Including VAT
    //   # Added field "Requester ID"
    // HEI.05 CHG2137782 HB2685 IBM MAJUMS03 23.12.2021 # Add Field "PO Reference" in Archives PO
    //   # New Field added - "Your Reference".
    // HEI.06 CHG2188365 HB3301 IBM NANDIS01 08.03.2023 # Limit PO in PO Archive
    //   # Code modified to show the fields values in Page correctly
    // BC Upgrade SHUKLP03 >> Added field "Shopping Card Creation Date" in the interface ext because dependency on PurchaseHeaderArchiveAdditional table.
    Caption = 'PO Purchase Order Archives';
    CardPageID = "Purchase Order Archive";
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Header Archive";
    SourceTableView = where("Document Type" = CONST(Order));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
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
                field("Your Reference"; Rec."Your Reference")
                {
                    ToolTip = 'Specifies the value of the Your Reference field.';
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
                /* //BC Upgrade Manisha Drink it code commented>>

                field("Created By";Rec."Created By")
                {
                }
                */ //BC Upgrade Manisha Drink it code commented<<

                field(LimitPO; LimitPO)
                {
                    Caption = 'Limit PO';
                    ToolTip = 'Specifies the value of the Limit PO field.';
                }
                field("Shopping Card No."; Rec."Shopping Card No. FND")
                {
                    ToolTip = 'Specifies the value of the Shopping Card No. field.';
                }
                // BC Upgrade SHUKLP03 >> Added in the interface ext because dependency on PurchaseHeaderArchiveAdditional table.
                // field("PurchaseHeaderArchiveAdditional.""Shopping Card Creation Date"""; PurchaseHeaderArchiveAdditional."Shopping Card Creation Date")
                // {
                //     Caption = 'Shopping Card Creation Date';
                // }
                // BC Upgrade SHUKLP03 << Added in the interface ext because dependency on PurchaseHeaderArchiveAdditional table.
                field(Amount; Rec.Amount)
                {
                    CaptionML = ENU = 'Total Excl. VAT',
                                FRA = 'Montant';
                    ToolTip = 'Specifies the total amount for the archived purchase document.';
                }
                field("""Amount Including VAT""-Amount"; Rec."Amount Including VAT" - Rec.Amount)
                {
                    Caption = 'Total VAT';
                    ToolTip = 'Specifies the value of the Total VAT field.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    CaptionML = ENU = 'Total Incl. VAT',
                                FRA = 'Montant TTC';
                    ToolTip = 'Specifies the total amount including VAT for the archived purchase document.';
                }
                /* //BC Upgrade Manisha Drink it code commented>>
                field("Requester ID"; Rec."Requester ID")
                {
                }
                */ //BC Upgrade Manisha Drink it code commented<<

            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
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
                    ToolTip = 'Executes the Co&mments action.';
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
                    RunPageView = sorting("Order No.");
                    ToolTip = 'Executes the Receipts action.';
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        //HEI.03>>
        //IF PurchaseHeaderAdditionalArch.GET("Document Type","No.") THEN; //HEI.06
        //HEI.03<<
        //HEI.06>>
        LimitPO := false;
        PurchaseHeaderAdditionalArch.RESET();
        PurchaseHeaderAdditionalArch.SETRANGE("Document Type", Rec."Document Type");
        PurchaseHeaderAdditionalArch.SETRANGE("No.", Rec."No.");
        PurchaseHeaderAdditionalArch.SETRANGE("Limit PO", true);
        if PurchaseHeaderAdditionalArch.FINDFIRST() then
            LimitPO := PurchaseHeaderAdditionalArch."Limit PO";
        //HEI.06<<
    end;

    trigger OnOpenPage();
    begin
        Rec.SetSecurityFilterOnRespCenter();

        //HEI.01>>
        PurchasesPayablesSetup.GET;
        PurchasesPayablesSetup.TESTFIELD("PO Subtype Code FND");
        Rec.FILTERGROUP(2);
        Rec.SETRANGE(Rec."Document Subtype Code FND", PurchasesPayablesSetup."PO Subtype Code FND"); // BC UPGRADE VAMSIU01 - Added >>
        Rec.FILTERGROUP(0);
        //HEI.01<<
    end;

    var
        PurchaseHeaderAdditionalArch: Record "Purchase Header Arch Addit FND";
        PurchaseHeaderArchiveAdditional: Record "Purchase Header Arch Addit FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        LimitPO: Boolean;
}

