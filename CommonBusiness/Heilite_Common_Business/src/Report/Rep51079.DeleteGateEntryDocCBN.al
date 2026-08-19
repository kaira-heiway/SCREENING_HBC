report 51079 "Delete Gate Entry Doc CBN"
{
    // version HEI.01

    // HEI.01 INC4616710/CHG2200312 IBM.PRASAA03 11.04.2023 Unable to remove these gates that have experienced problems of misuse of the tool by users.
    //   # New report developed to delete the wrongly created gate entries

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    //BC Upgrade KAPOOV01  <<

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Gate Entry Header FND"; "Gate Entry Header FND")
        {
            RequestFilterFields = "Gate Entry Document No.";
            dataitem("Gate Entry Line FND"; "Gate Entry Line FND")
            {
                DataItemLink = "Gate Entry Document No." = FIELD("Gate Entry Document No.");

                trigger OnAfterGetRecord();
                begin
                    "Gate Entry Line FND".DELETE();
                end;
            }

            trigger OnAfterGetRecord();
            begin
                "Gate Entry Header FND".DELETE();
                MESSAGE('Gate Entry No. %1 is deleted', "Gate Entry Header FND"."Gate Entry Document No.");
            end;

            trigger OnPreDataItem();
            begin
                if "Gate Entry Header FND".GETFILTER("Gate Entry Header FND"."Gate Entry Document No.") = '' then
                    ERROR('Please Select Gate entry No.');
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
}

