page 53019 "CreditMemo-PriceCorr(Negative)"
{
    // version HEI.01
    //BC UPGRADE SIVA Old Page ID 50139
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1190 Added fields "Responsiblity Center","Physical Location Group Code"
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code" (Visible FALSE)
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // HEI.01 IBM PATHAA02 FDD-OTCGAP051 18.01.18
    // # New list Page created from Standard
    // # Code written on Onopenpage to filter
    //************************************************//
    // BC UPGRADE SIVA 9/01/2026>>
    // SUMMARY OF CHANGES:
    //1.HEI.01 Commented Code related to Drink IT T2014473.
    //2.Drink IT Fields/Code are commented
    //BC UPGRADE SIVA <<
    //************************************************//

    // BC Upgrade SHUKLP03 >> "Document Subtype Code" code added

    Caption = 'CreditMemo-PriceCorr(Negative)';
    CardPageID = "Sales Credit Memo";
    ApplicationArea = All;
    UsageCategory = Lists;
    DataCaptionFields = "Sell-to Customer No.";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Release,Posting,Credit Memo,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = CONST("Credit Memo"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the sales document. The field can be filled automatically or manually and can be set up to be invisible.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the customer who will receive the products and be billed by default. When you fill this field, most of the other fields on the document are filled from the customer card.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the number that the customer uses in their own system to refer to this sales document.';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the person to contact at the customer that the items were sold to.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the customer to whom you will send the sales invoice when this customer is different from the sell-to customer.';
                    Visible = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ToolTip = 'Specifies the customer to whom you will send the sales invoice, when different from the customer that you are selling to.';
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you should contact at the customer who you are sending the invoice to.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
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
                    ToolTip = 'Specifies the name of the contact person at the address that products will be shipped to.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the posting of the sales document will be recorded.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the sales header.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the sales header.';
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the responsibility center that is responsible for the document.';
                    Editable = false;
                    Visible = false;
                }
                //BC UPGRADE SIVA >> Drink IT field 
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                //BC UPGRADE SIVA<< Drink IT field
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTip = 'Specifies the name of the sales person who is assigned to the customer.';
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency of amounts on the sales document.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when you created the sales document.';
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ToolTip = 'Specifies the number of the campaign that the document is linked to.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when the sales invoice must be paid.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies the date you expect to ship items on the sales document.';
                    Visible = false;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the type of posted document that you want the credit memo or invoice to be applied to when you post it.';
                    Visible = false;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of a job queue entry or task that handles the posting of sales orders.';
                    Visible = JobQueueActive;
                }
                //BC UPGRADE SHUKLP03>> Added field
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                //BC UPGRADE SHUKLP03<< Added field
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of amounts in the Line Amount field on the sales order lines. It is used to calculate the invoice discount of the sales order.';
                }
            }
        }
        area(factboxes)
        {
            part(Control1902018507; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
                Visible = false;
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
            group("&Cr. Memo")
            {
                Caption = '&Cr. Memo';
                Image = CreditMemo;
                action(Statistics)
                {
                    ToolTip = 'View statistics for the sales document.';
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortCutKey = 'F7';
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        Rec.CalcInvDiscForHeader();
                        COMMIT();
                        PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec);
                    end;
                }
                action("Co&mments")
                {
                    ToolTip = 'View or add comments to the sales document.';
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ApplicationArea = all;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        //ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");//BC UPGRADE SIVA>>
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", Rec."Document Type", Rec."No."); //BC UPGRADE SIVA<<
                        ApprovalEntries.RUN();
                    end;
                }
            }
        }
        area(processing)
        {
            group(CreditMemo)
            {
                Caption = 'Credit Memo';
                Image = Invoice;
                action(Customer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Enabled = CustomerSelected;
                    Image = Customer;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the customer.';
                }
            }
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    ToolTip = 'Release the sales document so that it can be processed further.';
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    ToolTip = 'Reopen the released sales document so that it can be modified.';
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = "Action";
                action(SendApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';
                    ApplicationArea = Basic, Suite;
                    trigger OnAction();
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction();
                    begin
                        CheckSalesCheckAllLinesHaveQuantityAssigned();
                        PostSubmit(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Preview Posting")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction();
                    var
                        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
                    begin
                        SalesPostYesNo.Preview(Rec);
                    end;
                }
                action(PostAndSend)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Send';
                    Ellipsis = true;
                    Image = PostSendTo;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens where you can confirm or select a sending profile.';

                    trigger OnAction();
                    begin
                        CheckSalesCheckAllLinesHaveQuantityAssigned();
                        Rec.SendToPosting(CODEUNIT::"Sales-Post and Send");
                    end;
                }
                action("Post &Batch")
                {
                    ToolTip = 'Schedule the posting of the document to be processed in the background by the job queue.';
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        CheckSalesCheckAllLinesHaveQuantityAssigned();
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Credit Memos", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Remove From Job Queue")
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
            group(Reports)
            {
                Caption = 'Reports';
                Image = "Report";
                group(SalesReports)
                {
                    Caption = 'Sales Reports';
                    Image = "Report";
                    action("Customer - Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Top 10 List';
                        Image = "Report";
                        RunObject = Report "Customer - Top 10 List";
                        ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action("Customer - Sales List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Sales List';
                        Image = "Report";
                        RunObject = Report "Customer - Sales List";
                        ToolTip = 'View customer sales in a period, for example, to report sales activity to customs and tax authorities.';
                    }
                    action("Sales Statistics")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Statistics';
                        Image = "Report";
                        RunObject = Report "Sales Statistics";
                        ToolTip = 'View the customer''s total cost, sale, and profit over time, for example, to analyze earnings trends. The report shows amounts for original and adjusted cost, sales, profit, invoice discount, payment discount, and profit percentage in three adjustable periods.';
                    }
                }
                group(FinanceReports)
                {
                    Caption = 'Finance Reports';
                    Image = "Report";
                    action("Report Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement';
                        Image = "Report";
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';

                        trigger OnAction();
                        var
                            Customer: Record Customer;
                        begin
                            CODEUNIT.RUN(CODEUNIT::"Customer Layout - Statement", Customer);
                        end;
                    }
                    action("Customer - Balance to Date")
                    {
                        ApplicationArea = all;
                        Caption = 'Customer - Balance to Date';
                        Image = "Report";
                        RunObject = Report "Customer - Balance to Date";
                        ToolTip = 'View, print, or save customers'' balances on a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.';
                    }
                    action("Customer - Trial Balance")
                    {

                        ApplicationArea = Suite;
                        Caption = 'Customer - Trial Balance';
                        Image = "Report";
                        RunObject = Report "Customer - Trial Balance";
                        ToolTip = 'View the beginning and ending balance for customers with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.';
                    }
                    action("Customer - Detail Trial Bal.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Detail Trial Bal.';
                        Image = "Report";
                        RunObject = Report "Customer - Detail Trial Bal.";
                        ToolTip = 'View the balance for customers with balances on a specified date, for example, at the close of an accounting period or for an audit.';
                    }
                    action("Customer - Summary Aging")
                    {
                        ApplicationArea = all;
                        Caption = 'Customer - Summary Aging';
                        Image = "Report";
                        RunObject = Report "Customer - Summary Aging";
                        ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    }
                    action("Customer - Detailed Aging")
                    {
                        ApplicationArea = all;
                        Caption = 'Customer - Detailed Aging';
                        Image = "Report";
                        RunObject = Report "Customer Detailed Aging";
                        ToolTip = 'View, print, or save a detailed list of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    }
                    action("Aged Accounts Receivable")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Receivable';
                        Image = "Report";
                        RunObject = Report "Aged Accounts Receivable";
                        ToolTip = 'View an overview of when customer payments are due or overdue, divided into four periods. You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                    }
                    action("Customer - Payment Receipt")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Payment Receipt';
                        Image = "Report";
                        RunObject = Report "Customer - Payment Receipt";
                        ToolTip = 'View a document showing which customer ledger entries that a payment has been applied to. This report can be used as a payment receipt that you send to the customer.';
                    }
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        SetControlAppearance();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage();
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        Rec.SetSecurityFilterOnRespCenter();
        JobQueueActive := SalesSetup.JobQueueActive();

        Rec.CopySellToCustomerFilter();
        //BC UPGRADE SHUKLP03>> Added Code
        //HEI.01 PATHAA02>>
        if docsubtypecodesetup.GET then begin
            docsubtypecodesetup.TESTFIELD(docsubtypecodesetup."CreditMemo-PriceCorr(Negative)");
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Document Subtype Code FND", docsubtypecodesetup."CreditMemo-PriceCorr(Negative)");
            Rec.FILTERGROUP(0);
        end;
        //PATHAA02<<
        //BC UPGRADE SHUKLP03<< Added Code
    end;

    var
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        ReportPrint: Codeunit "Test Report-Print";
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenPostedSalesCrMemoQst: Label 'The credit memo has been posted and archived.\\Do you want to open the posted credit memo from the Posted Sales Credit Memo list?';
        CanCancelApprovalForRecord: Boolean;
        CustomerSelected: Boolean;
        docsubtypecodesetup: Record "Doc Subtype Code Setup FND"; //BC UPGRADE SHUKLP03

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
        CustomerSelected := Rec."Sell-to Customer No." <> '';
    end;

    local procedure PostSubmit(PostingCodeunitID: Integer);
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        PreAssignedNo: Code[20];
    begin
        //if ApplicationAreaSetup.IsFoundationEnabled then begin//BC UPGRADE SIVA>> Microsoft removed this check in the upgraded version
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
        PreAssignedNo := Rec."No.";
        //end;

        Rec.SendToPosting(PostingCodeunitID);

        if Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" then
            CurrPage.CLOSE()
        else
            // if ApplicationAreaSetup.IsFoundationEnabled then //BC UPGRADE SIVA>> Microsoft removed this check in the upgraded version
                ShowPostedConfirmationMessage(PreAssignedNo);
    end;

    local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20]);
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        SalesCrMemoHeader.SETRANGE("Pre-Assigned No.", PreAssignedNo);
        if SalesCrMemoHeader.FINDFIRST() then
            if DIALOG.CONFIRM(OpenPostedSalesCrMemoQst, false) then
                PAGE.RUN(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader);
    end;

    local procedure CheckSalesCheckAllLinesHaveQuantityAssigned();
    var
        ApplicationAreaSetup: Record "Application Area Setup";
    begin
        //if ApplicationAreaSetup.IsFoundationEnabled then //BC UPGRADE SIVA>> Microsoft removed this check in the upgraded version
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
    end;
}

