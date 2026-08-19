report 51080 "Delete Error Autobill JQ CBN"
{
    // version HEI.02

    // HEI.01 HB2935 CHG2156365 IBM GHOSHS05 13.06.2022 #MTC_FIN_Autobilling Error log Deletion Functionality
    //   # New report created to delete error job queues
    // HEI.02 CHG2255747 IBM BHANDS01 20.06.2024 Autobilling Error log Deletion Functionality
    //   # Validating Delete Trigger by adding TRUE in parameter

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    //BC Upgrade KAPOOV01  <<

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Job Queue Entry"; "Job Queue Entry")
        {
            DataItemTableView = WHERE("Object Type to Run" = FILTER(Codeunit), "Object ID to Run" = FILTER(88), Status = FILTER(Error));

            trigger OnAfterGetRecord();
            begin
                // HEI.01>>
                SalesReceivablesSetup.GET();
                if DT2DATE("Job Queue Entry"."Earliest Start Date/Time") <= CALCDATE(SalesReceivablesSetup."Autobilling JQ Del. Period FND", WORKDATE()) then begin
                    //case 1 Order doesnt exist
                    if not "Job Queue Entry"."JQ Posted FND" then begin
                        if not SalesHeader.GET("Job Queue Entry"."Document Type FND", "Job Queue Entry"."Document No. FND") then
                            "Job Queue Entry".DELETE(true); //HEI.02
                    end else
                        //Case 2 EBM is enabled
                        if not SalesReceivablesSetup."Activate CIS System FND" then
                            "Job Queue Entry".DELETE(true)  //HEI.02
                        else
                            if "Job Queue Entry"."JQ Logistics Mail Sent FND" then
                                "Job Queue Entry".DELETE(true); //HEI.02
                end;
                // HEI.01<<
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
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        test: Text;
        SalesHeader: Record "Sales Header";
}

