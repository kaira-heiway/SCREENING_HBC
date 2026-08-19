report 54020 "Delete Zone warehouse movement"
{
    // version HEI.01

    // HEI.01 IBM PRASAA03 PRB2008225/INC4619592/CHG2200279 11.04.2023 #Issue with zone movements that are stuck in INTR
    //   # New Report created to delete the Zone movement Documents
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Old Report ID - 50307
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
        {
            RequestFilterFields = "No.";
            dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
            {
                DataItemLink = "Activity Type" = FIELD(Type),
                               "No." = FIELD("No.");

                trigger OnAfterGetRecord();
                begin
                    "Warehouse Activity Line".DELETE;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Warehouse Activity Line"."Zone-Transfer FND", TRUE);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                "Warehouse Activity Header".DELETE;
            end;

            trigger OnPostDataItem();
            begin
                MESSAGE('Document No. %1 is deleted.', "Warehouse Activity Header"."No.");
            end;

            trigger OnPreDataItem();
            begin
                //SETRANGE("Warehouse Activity Header".Type,3);
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
        IF "Warehouse Activity Header".GETFILTER("No.") = '' THEN
            ERROR('Please Select Document No.');
    end;
}

