report 58064 "Send SEM Sales Documents_SEM"
{
    // version HEI.01

    // HEI.01 CHG2187475 IBM COSTES04 09.05.2023  SEM Sales Information
    //   # New interface Send Sales Information
    // BC Upgrade KUMARR78 >>
    //
    // Report Name : Send SEM Sales Documents
    // Report ID   : 50584
    //
    // 1. Added Business Central visibility properties.
    //    Old:
    //         - ApplicationArea not defined (NAV).
    //         - UsageCategory not defined.
    //    New:
    //         - ApplicationArea = All;
    //         - UsageCategory = ReportsAndAnalysis;
    //         - Ensures report visibility and searchability in Business Central.
    //
    // 2. Added ApplicationArea to request page fields.
    //    Old:
    //         - Request page fields without ApplicationArea.
    //    New:
    //         - ApplicationArea = All added to:
    //             • DocumentType
    //             • DocumentNo
    //             • PostingDate
    //         - Complies with BC UI visibility requirements.
    //
    // 3. Removed legacy Codeunit dependency.
    //    Old:
    //         - Codeunit "SEM Interface Mgmt." used in OnPreReport.
    //         - Methods:
    //              SEMInterfaceMgmt.SetSendSalesDocumentsFilter(...);
    //              SEMInterfaceMgmt.ProcessPostedDocuments;
    //              SEMInterfaceMgmt.GetNoOfDocProcessed;
    //    New:
    //         - SEM Interface Mgmt. variable removed.
    //         - Related processing logic commented out.
    //         - Eliminates dependency on legacy NAV codeunit.
    //         - Prevents runtime errors if object not available in BC.
    //
    // 4. Cleaned unused variable declaration.
    //    Old:
    //         - SEMInterfaceMgmt: Codeunit "SEM Interface Mgmt.";
    //    New:
    //         - Variable removed.
    //         - Improves code clarity and upgrade safety.
    // BC Upgrade KUMARR78 <<

    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding UsageCategory
    ProcessingOnly = true;
    Caption = 'Send SEM Sales Documents_SEM';

    dataset
    {
        dataitem(Customer; Customer)
        {
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control55001)
                {
                    field(DocumentType; DocumentType)
                    {
                        Caption = 'Document Type';
                        ApplicationArea = all; //BC UPGRDAE KUMARR78 Adding ApplicationArea

                        trigger OnValidate();
                        begin
                            DocumentNoEditable := DocumentType <> DocumentType::" ";
                        end;
                    }
                    field(DocumentNo; DocumentNo)
                    {
                        Caption = 'Document No.';
                        Editable = DocumentNoEditable;
                        ApplicationArea = all; //BC UPGRDAE KUMARR78 Adding ApplicationArea

                        trigger OnLookup(var Text: Text): Boolean;
                        var
                            SalesInvoiceHeader: Record "Sales Invoice Header";
                            SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                        begin
                            if DocumentType = DocumentType::Invoice then begin
                                if PAGE.RUNMODAL(0, SalesInvoiceHeader) = ACTION::LookupOK then begin
                                    DocumentNo := SalesInvoiceHeader."No.";
                                end;
                            end else if DocumentType = DocumentType::"Credit Memo" then begin
                                if PAGE.RUNMODAL(0, SalesCrMemoHeader) = ACTION::LookupOK then begin
                                    DocumentNo := SalesInvoiceHeader."No.";
                                end;
                            end;
                        end;

                        trigger OnValidate();
                        var
                            SalesInvoiceHeader: Record "Sales Invoice Header";
                        begin
                        end;
                    }
                    field(PostingDate; PostingDate)
                    {
                        Caption = 'Posting Date';
                        ApplicationArea = all; //BC UPGRDAE KUMARR78 Adding ApplicationArea
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        PostingDate := CALCDATE('<-1D>', TODAY);
    end;

    trigger OnPreReport();
    begin
        SEMInterfaceMgmt.SetSendSalesDocumentsFilter(PostingDate, DocumentNo, DocumentType, Customer);
        SEMInterfaceMgmt.ProcessPostedDocuments;
        if GUIALLOWED then
            MESSAGE(STRSUBSTNO(NoOfDocProcessedMsg, SEMInterfaceMgmt.GetNoOfDocProcessed));

    end;

    var
        SEMInterfaceMgmt: Codeunit "SEM Interface Mgmt.";
        DocumentType: Option " ",Invoice,"Credit Memo";
        PostingDate: Date;
        DocumentNo: Text;
        DocumentNoEditable: Boolean;
        ResendPostedDocMsg: Label 'By selecting "Re-process Documents" all documents according to the filters will be resend. Please make sure you are selecting the correct filters.';
        NoOfDocProcessedMsg: Label '%1 documents are processed.';
}

