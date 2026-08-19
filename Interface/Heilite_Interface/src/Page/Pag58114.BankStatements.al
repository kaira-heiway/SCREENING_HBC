page 58114 "Bank Statements"
{
    // version BC

    // HEI.01 CHG2020184 IBM POENAB02 26.06.2019
    //   # New page for Bank Connectivity interface

    //Bc Upgrade YADAVM09 Old Id-50352.

    // BC UPGRADE PATELS08 >>
    // # Table name changed from Imported Bank Statements to Imported Bank Statements FND.
    // BC UPGRADE PATELS08 <<
    Caption = 'Imported Bank Statements';
    CardPageID = "Bank Statement";
    DataCaptionFields = "Bank Account No.";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'Process';
    RefreshOnActivate = true;
    SourceTable = "Imported Bank Statements FND";
    ApplicationArea = ALL;//Bc Upgrade YADVAM09<<

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADVAM09<<
                }
                field("Statement No."; Rec."Statement No.")
                {
                    Caption = 'Serial No.';
                    ApplicationArea = ALL;//Bc Upgrade YADVAM09<<
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = ALL;//Bc Upgrade YADVAM09<<
                }
                field("Bank Acc. Rec. Statement No."; Rec."Bank Acc. Rec. Statement No.")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADVAM09<<
                }
                field("Processing Date"; Rec."Processing Date")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADVAM09<<
                }
                field("Processing Time"; Rec."Processing Time")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADVAM09<<
                }
                field("Processed by User"; Rec."Processed by User")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADVAM09<<
                }
                field("Reprocessed by User"; Rec."Reprocessed by User")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADVAM09<<
                }
                field("File Imported"; Rec."File Imported")
                {
                    Caption = 'Statement No. Imported';
                    ApplicationArea = ALL;//Bc Upgrade YADVAM09<<
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                CaptionML = ENU = '&Invoice',
                            FRA = 'Fa&cture';
                Image = Invoice;
                action(Statistics)
                {
                    CaptionML = ENU = 'Statistics',
                                FRA = 'Statistiques';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortCutKey = 'F7';
                }
            }
        }
    }

    trigger OnOpenPage();
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
    end;

    var
        DummyApplicationAreaSetup: Record "Application Area Setup";
        ReportPrint: Codeunit "Test Report-Print";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenPostedSalesInvQst: TextConst ENU = 'The invoice has been posted and moved to the Posted Sales Invoice list.\\Do you want to open the posted invoice?', FRA = 'La facture a été validée et déplacée dans la liste des factures vente enregistrées.\\Souhaitez-vous ouvrir la facture validée ?';
        CanCancelApprovalForRecord: Boolean;

    procedure ShowPreview();
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
    end;

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
    end;

    local procedure Post(PostingCodeunitID: Integer);
    var
        PreAssignedNo: Code[20];
    begin
    end;

    local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20]);
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
    end;
}

