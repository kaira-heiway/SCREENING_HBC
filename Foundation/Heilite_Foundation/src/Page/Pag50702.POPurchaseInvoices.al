page 50702 "PO Purchase Invoices"
{
    // version HEI.06

    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1191 Added fields "Responsiblity Center","Physical Location Group Code"
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code" (Visible FALSE)
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // 
    // HEI.01 PTPGAP064 IBM HORTOC01 12.07.2017
    //   # New page based on standard page 9308
    // 
    // HEI.02 FDD PTPGAP081 IBM POSTOI01 11.05.2018
    //   # Action "Archive Document" , Properties , Enabled = false
    // HEI.03 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    // HEI.04 CHG2204474 IBM SRIVAS07 19.09.23 - Error message displayed when document date is in the future in all invoice processing pages
    //   # Added code in Post Action.
    // HEI.05 CHG2204474 IBM SRIVAS07 26.09.23 - Error message displayed when document date is in the future in all invoice processing pages
    //   # Added code in Post Action.
    //   # Added code in PostAndPrint Action.
    // HEI.06 CHG2204474 IBM SRIVAS07 16.10.23 - Error message displayed when document date is in the future in all invoice processing pages
    //   # Added code in Post Action.
    //   # Added code in PostAndPrint Action.
    //BC Upgrade SHARMP16 -- Old Id 50038 replace with new Id -52014

    //BC Upgrade PATELP08 >> 
    // # Blocking "InDataSet" as Microsoft removed the need for "InDataSet" because all page variables are automatically available to the dataset.
    //BC Upgrade PATELP08 <<

    Caption = 'PO Purchase Invoices';
    CardPageID = "PO Purchase Invoice";
    DataCaptionFields = "Buy-from Vendor No.";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Invoice,Posting,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = CONST(Invoice));
    ApplicationArea = all;
    UsageCategory = Lists;
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
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the compensation agreement identification number, sometimes referred to as the RMA No. (Returns Materials Authorization).';
                    Visible = false;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.';
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vendor who is sending the invoice.';
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the vendor sending the invoice.';
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a ship-to code if you want a different shipment address from the one that has been automatically entered.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the company at the address to which you want the items to be shipped.';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of a contact person for the address where the items should be shipped.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the dimension value code associated with the purchase header.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the dimension value code associated with the purchase header.';
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                // field("Physical Location Group Code";Rec."Physical Location Group Code")
                // {
                //     Editable = false;
                //     Visible = false;
                // }//Bc Upgrade SHARMP16--DRINK-IT fields
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code of the currency of the amounts on the purchase lines.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date of the vendor''s invoice.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when the invoice is due.';
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                    Visible = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how payment for the purchase document must be submitted.';
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the code that represents the shipment method for this purchase.';
                    Visible = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the datApplicationArea = Basic, Suite;e to have the vendor deliver your order to the ship-to address.';
                    Visible = false;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase orders.';
                    Visible = JobQueueActive;
                }
                //BC Upgrade VAMSIU01 -  field added >>
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                //BC Upgrade VAMSIU01 -  field added <<
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of the amounts in the Amount field on the associated purchase lines.';
                }
                field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            // BC Upgrade BHARDA11 >> --30April2026
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Purchase Header"),
                              "Document Type" = field("Document Type"),
                              "No." = field("No.");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                Visible = false;
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
            }
            // BC Upgrade BHARDA11 << --30April2026
            part(Control1901138007; "Vendor Details FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Basic, Suite;
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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction();
                    begin
                        rec.CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic, Suite;
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        rec.ShowDocDim;
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
                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", rec."Document Type", rec."No.");
                        ApprovalEntries.RUN;
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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                        //HEI.02>>
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(false);
                        //HEI.02<<
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = Basic, Suite;
                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                action("Archive Document")
                {
                    Caption = 'Archi&ve Document';
                    Enabled = false;
                    Image = Archive;
                    ApplicationArea = Basic, Suite;
                    trigger OnAction();
                    begin
                        //HEI.02>>
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(false);
                        //HEI.02<<
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
                    ApplicationArea = Basic, Suite;
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
                    ApplicationArea = Basic, Suite;
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
                action(Post_Custom)
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
                        BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
                        AfterLimit: Label 'Document date should not be more than the Posting date.';
                    begin
                        rec.TESTFIELD("Document Date"); //HEI.06
                                                        //HEI.04>>
                        if CALCDATE('-3M', rec."Posting Date") > rec."Document Date" then
                            //HEI.05>>
                            if not CONFIRM(BeforeLimit, false, rec."Document Date", rec."Posting Date") then
                                exit;
                        //ERROR(BeforeLimit);

                        //IF CALCDATE('3M',"Posting Date") < "Document Date" THEN
                        if rec."Document Date" > rec."Posting Date" then
                            ERROR(AfterLimit);
                        //IF "Posting Date" = "Document Date" THEN
                        //ERROR(EqualDate);
                        //HEI.05<<
                        //HEI.04<<

                        VerifyTotal;
                        Post(CODEUNIT::"Purch.-Post (Yes/No)");
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
                    ApplicationArea = Basic, Suite;
                    trigger OnAction();
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(TestReport)
                {
                    ApplicationArea = Basic, Suite;
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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction();
                    var
                        BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
                        AfterLimit: Label 'Document date should not be more than the Posting date.';
                    begin
                        rec.TESTFIELD("Document Date"); //HEI.06
                        //HEI.05<<
                        if CALCDATE('-3M', rec."Posting Date") > rec."Document Date" then
                            if not CONFIRM(BeforeLimit, false, rec."Document Date", rec."Posting Date") then
                                exit;

                        if rec."Document Date" > rec."Posting Date" then
                            ERROR(AfterLimit);
                        //HEI.05<<
                        VerifyTotal;
                        rec.SendToPosting(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        VerifyTotal;
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = JobQueueActive;

                    trigger OnAction();
                    begin
                        rec.CancelBackgroundPosting;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        rec.SetSecurityFilterOnRespCenter;

        JobQueueActive := PurchasesPayablesSetup.JobQueueActive;

        rec.CopyBuyFromVendorFilter;

        //HEI.01>>
        PurchasesPayablesSetup.GET;
        PurchasesPayablesSetup.TESTFIELD("PO Subtype Code FND");
        rec.FILTERGROUP(2);
        rec.SETRANGE("Document Subtype Code FND", PurchasesPayablesSetup."PO Subtype Code FND");//BC Upgrade VAMSIU01--code Added
        rec.FILTERGROUP(0);
        //HEI.01<<
    end;

    var
        ReportPrint: Codeunit "Test Report-Print";
        //BC Upgrade PATELP08 >> Blocking "InDataSet" as Microsoft removed the need for "InDataSet" because all page variables are automatically available to the dataset.
        //[InDataSet]
        //BC Upgrade PATELP08 <<
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenPostedPurchaseInvQst: Label 'The invoice has been posted and moved to the Posted Purchase Invoice list.\\Do you want to open the posted invoice?';
        CanCancelApprovalForRecord: Boolean;
        TotalsMismatchErr: Label 'The invoice cannot be posted because the total is different from the total on the related incoming document.';
        ArchiveManagement: Codeunit ArchiveManagement;

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(rec.RECORDID);
    end;

    local procedure Post(PostingCodeunitID: Integer);
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    begin
        //if ApplicationAreaSetup.IsFoundationEnabled then
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        rec.SendToPosting(PostingCodeunitID);

        //if ApplicationAreaSetup.IsFoundationEnabled then
        ShowPostedConfirmationMessage;
    end;

    local procedure ShowPostedConfirmationMessage();
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        PurchInvHeader.SETFILTER("Pre-Assigned No.", rec."No.");
        if PurchInvHeader.FINDFIRST then
            if DIALOG.CONFIRM(OpenPostedPurchaseInvQst, false) then
                PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
    end;

    local procedure VerifyTotal();
    begin
        if not rec.IsTotalValid then
            ERROR(TotalsMismatchErr);
    end;
}

