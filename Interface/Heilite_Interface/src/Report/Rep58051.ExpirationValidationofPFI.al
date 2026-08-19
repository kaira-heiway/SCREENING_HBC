report 58051 "ExpirationValidation of PFI"
{
    // version HEI.01

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 25.06.2021 Ibecor - PO API
    //   # New Report created for Ibecor PFI Interface to check PFI Expiry validity

    // BC Upgrade KAPOOV01 >>
    // 1. Old Report ID- 50526.
    // 2. Add ApplicationArea AND UsageCategory in Report.
    // BC Upgrade KAPOOV01 <<

    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;  // BC Upgrade KAPOOV01 Added
    ApplicationArea = ALL; // BC Upgrade KAPOOV01 Added

    dataset
    {
        dataitem("PFI Header INT"; "PFI Header INT")
        {
            DataItemTableView = SORTING("PFI Document No.") ORDER(Ascending) WHERE("PO Created" = FILTER(false), "PFI Expiration Date" = FILTER(<> ''));

            trigger OnAfterGetRecord();
            begin
                //HEI.01>>
                if ("PFI Header INT"."PFI Expiration Date" <> 0D) then begin
                    if (WORKDATE - "PFI Header INT"."PFI Expiration Date") >= 1 then begin
                        "PFI Header INT"."PFI Status" := "PFI Header INT"."PFI Status"::Expired;
                        "PFI Header INT".MODIFY;
                    end;
                end else
                    CurrReport.SKIP;
                //HEI.01<<
            end;

            trigger OnPostDataItem();
            begin
                //HEI.01>>
                if GUIALLOWED then
                    MESSAGE('process completed');
                //HEI.01<<
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

    trigger OnPreReport();
    begin
        //HEI.01>>
        if GUIALLOWED then
            if not CONFIRM(Text50000, true) then
                exit;
        //HEI.01<<
    end;

    var
        Text50000: Label 'Do you want to run the process to expire the PFIs?';
        store: Integer;
}

