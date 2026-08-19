report 52015 "Update NoOfPrintted MailSent"
{
    // version HEI.01
    // HEI.01 CHG2159052 IBM MAJUMS03 25.05.2022 New temporary process report created
    //   To update No. Printed" = 1 in Purchase Header, "Mail Sent" and "Mail Sent Date Time" in Purchase Header Additional table for a specific record.
    //**********************************//
    //BC UPGRADE ATHUKS01//
    //1.Report is created for update data.
    //The variables Error001, Error002, and Text001 have been renamed to DocumentTypeErr, DocumentNoErr, and ProcessMsg, as a warning indicated that variables should be prefixed with Err or Msg
    //3.Old ReportID 50431.

    Permissions = TableData "Purchase Header" = rmd,
                  TableData "Purchase Header Additional FND" = rmd;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending);
            RequestFilterFields = "Document Type", "No.";

            trigger OnAfterGetRecord();
            begin
                if "Purchase Header"."No. Printed" = 0 then
                    "Purchase Header"."No. Printed" := 1;

                "Purchase Header".MODIFY();

                PurchHdrAdd.RESET();
                if PurchHdrAdd.GET("Purchase Header"."Document Type", "Purchase Header"."No.") then begin
                    if not (PurchHdrAdd."Mail Sent") then
                        PurchHdrAdd."Mail Sent" := true;
                    if PurchHdrAdd."Mail Sent Date Time" = 0DT then
                        PurchHdrAdd."Mail Sent Date Time" := CREATEDATETIME(TODAY, TIME);
                    PurchHdrAdd.MODIFY();
                end;
                //HEI.01<<
            end;

            trigger OnPostDataItem();
            begin
                //HEI.01>>
                MESSAGE(ProcessMsg);
                //HEI.01<<
            end;

            trigger OnPreDataItem();
            begin
                //HEI.01>>
                if "Purchase Header".GETFILTER("Document Type") = '' then
                    ERROR(DocumentTypeErr);
                if "Purchase Header".GETFILTER("No.") = '' then
                    ERROR(DocumentNoErr);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PurchHdrAdd: Record "Purchase Header Additional FND";
        DocumentTypeErr: Label 'Document Type Cannot be blank';
        DocumentNoErr: Label 'No. cannot be blank';
        ProcessMsg: Label 'Process Completed';
}

