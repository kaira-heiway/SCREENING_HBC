page 51050 "Expense Claims CBN"
{
    // version NAVW110.0.00.15052,DITW110.00.09,HEI.06

    // HEI.01 FDD PTPGAP014 - No POGR lines in NPO invoice , IBM NAIKH01 27-06-2017
    //   # Created  a new page that is the Replica of Page 9308 - "Purchase Invoices" to show the Purchase Invoice with Document SubType 'NPO'

    // HEI.02 FDD PTPGAP014 - No POGR lines in NPO invoice , IBM NAIKH01 14.08.2017
    //   # Changed the SourceTableView of the page Property

    // HEI.03 PTPGAP064 IBM HORTOC01 28.08.2017
    //   # HEI.03 Code blocked on OnOpenPage() trigger because filters are applied on "Document Subtype Code" DrinkIT field.

    // HEI.04 CHG2204474 - IBM SRIVAS07 19.09.23 - Error message displayed when document date is in the future in all invoice processing pages
    //   # Added code in Post Action.
    // HEI.05 CHG2204474 - IBM SRIVAS07 26.09.23 - Error message displayed when document date is in the future in all invoice processing pages
    //   # Added code in Post Action.
    //   # Added code in postAndPrint action.
    // HEI.06 CHG2204474 - IBM SRIVAS07 16.10.23 - Error message displayed when document date is in the future in all invoice processing pages
    //   # Added code in Post Action.
    //   # Added code in postAndPrint action.

    //  IsFoundationArea() condition is not required anymore in business central Saas so blocked that condition.
    // DrinkIT fields "Physical Location Group Code", "Document Subtype Code" are blocked.

    // BC Upgrade SHUKLP03 >> "Document Subtype Code" code added.

    Caption = 'Expense Claims';
    CardPageID = "Expense Claim CBN";
    DataCaptionFields = "Buy-from Vendor No.";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Invoice,Posting,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = CONST(Invoice)); // HEI.02
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the purchase document. The field is only visible if you have not set up a number series for the type of purchase document, or if the Manual Nos. field is selected for the number series.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    TableRelation = Vendor where("Employee FND" = FILTER(true));
                    ToolTip = 'Specifies the number of the vendor that you buy from. When you enter the number, several other fields on the document are filled from the vendor card. You can change the vendor number as long as you have not posted the document.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the order address code linked to the relevant vendor''s order address.';
                    Visible = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the vendor who delivers the items.';
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ToolTip = 'Specifies the compensation agreement identification number, sometimes referred to as the RMA No. (Returns Materials Authorization).';
                    Visible = false;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.';
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies the vendor who is sending the invoice.';
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTip = 'Specifies the name of the vendor sending the invoice.';
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies a ship-to code if you want a different shipment address from the one that has been automatically entered.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the company at the address to which you want the items to be shipped.';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of a contact person for the address where the items should be shipped.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the purchase header.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the purchase header.';
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';
                }
                // BC Upgrade SHUKLP03 << DrinkIT field blocked.
                // field("Physical Location Group Code";Rec."Physical Location Group Code")
                // {
                //     Editable = false;
                //     Visible = false;
                // } // BC Upgrade SHUKLP03 << DrinkIT field blocked.
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the code of the currency of the amounts on the purchase lines.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date of the vendor''s invoice.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies when the invoice is due.';
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                    Visible = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies how payment for the purchase document must be submitted.';
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the code that represents the shipment method for this purchase.';
                    Visible = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the date to have the vendor deliver your order to the ship-to address.';
                    Visible = false;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase orders.';
                    Visible = JobQueueActive;
                }
                // BC Upgrade SHUKLP03 >> Added Document Subtype Code

                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                    Visible = true;
                } // BC Upgrade SHUKLP03 << Added Document Subtype Code

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of the amounts in the Amount field on the associated purchase lines.';
                }
            }
        }
        area(factboxes)
        {
            // part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            // {
            //     ShowFilter = false;
            // }//BC Upgrade SHARMP16
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Purchase Header"),
                              "No." = field("No."),
                              "Document Type" = field("Document Type");
            }//BC Upgrade SHARMP16
            part(Control1901138007; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';

                    trigger OnAction();
                    begin
                        Rec.CalcInvDiscForHeader();
                        COMMIT();
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'Executes the Co&mments action.';
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
                        Rec.ShowDocDim();
                    end;
                }
            }
        }
        area(processing)
        {
            group(Invoice)
            {
                Caption = 'Invoice';
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordfilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN();
                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the vendor on the selected purchase document.';
                }
            }
            group(ActionGroup7)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Executes the Re&lease action.';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ToolTip = 'Executes the Re&open action.';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = "Action";
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction();
                    var
                        AfterLimit: Label 'Document date should not be more than the Posting date.';
                        BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
                    begin
                        Rec.TESTFIELD("Document Date");//HEI.06
                                                       //HEI.04>>
                        if CALCDATE('-3M', Rec."Posting Date") > Rec."Document Date" then
                            //HEI.05>>
                            if not CONFIRM(BeforeLimit, false, Rec."Document Date", Rec."Posting Date") then
                                exit;
                        //ERROR(BeforeLimit);

                        //IF CALCDATE('3M',"Posting Date") < "Document Date" THEN
                        if Rec."Document Date" > Rec."Posting Date" then
                            ERROR(AfterLimit);
                        //IF "Posting Date" = "Document Date" THEN
                        //ERROR(EqualDate);
                        //HEI.05<<
                        //HEI.04<<
                        VerifyTotal();
                        Post1(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction();
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(TestReport)
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction();
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Executes the Post and &Print action.';

                    trigger OnAction();
                    var
                        AfterLimit: Label 'Document date should not be more than the Posting date.';
                        BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
                    begin
                        Rec.TESTFIELD("Document Date"); //HEI.06
                        //HEI.05>>
                        if CALCDATE('-3M', Rec."Posting Date") > Rec."Document Date" then
                            if not CONFIRM(BeforeLimit, false, Rec."Document Date", Rec."Posting Date") then
                                exit;

                        if Rec."Document Date" > Rec."Posting Date" then
                            ERROR(AfterLimit);
                        //HEI.05<<
                        VerifyTotal();
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Post &Batch action.';

                    trigger OnAction();
                    begin
                        VerifyTotal();
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = JobQueueActive;

                    trigger OnAction();
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        SetControlAppearance();
        // CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);//BC Upgrade SHARMP16
    end;

    trigger OnOpenPage();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        Rec.SetSecurityFilterOnRespCenter();

        JobQueueActive := PurchasesPayablesSetup.JobQueueActive();

        Rec.CopyBuyFromVendorFilter();

        // BC Upgrade SHUKLP03 >> Added Document Subtype Code
        //HEI.03>>
        PurchasesPayablesSetup.GET();
        PurchasesPayablesSetup.TESTFIELD("NPO Subtype Code FND");
        PurchasesPayablesSetup.TESTFIELD("NPO Prepayment inv.subtype FND");
        PurchasesPayablesSetup.TESTFIELD("NPO Prepayment req.subtype FND");
        PurchasesPayablesSetup.TESTFIELD("NPOPrepaymentCrdMemosubtyp FND");
        PurchasesPayablesSetup.TESTFIELD("Expense Claim Subdoc. Type FND");
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Document Subtype Code FND", PurchasesPayablesSetup."Expense Claim Subdoc. Type FND");
        Rec.FILTERGROUP(0);
        //HEI.03<<
        // BC Upgrade SHUKLP03 << Added Document Subtype Code
    end;

    var
        ReportPrint: Codeunit "Test Report-Print";
        CanCancelApprovalForRecord: Boolean;

        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenPostedPurchaseInvQst: Label 'The invoice has been posted and moved to the Posted Purchase Invoice list.\\Do you want to open the posted invoice?';
        TotalsMismatchErr: Label 'The invoice cannot be posted because the total is different from the total on the related incoming document.';

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    local procedure Post1(PostingCodeunitID: Integer);
    var
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    begin
        // IF ApplicationAreaSetup.IsFoundationEnabled THEN // BC Upgrade SHUKLP03 << Blocked becaue no need of this condition.
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        ShowPostedConfirmationMessage();
    end;

    local procedure ShowPostedConfirmationMessage();
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        PurchInvHeader.SETFILTER("Pre-Assigned No.", Rec."No.");
        if PurchInvHeader.FINDFIRST() then
            if DIALOG.CONFIRM(OpenPostedPurchaseInvQst, false) then
                PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
    end;

    local procedure VerifyTotal();
    begin
        if not Rec.IsTotalValid() then
            ERROR(TotalsMismatchErr);
    end;
}

