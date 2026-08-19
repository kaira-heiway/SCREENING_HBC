report 51094 "CAL Test Summary CBN"
{
    // version TS,HEI.02

    // HEI.01 RITM2923302 IBM SAXENA03 11/02/2022
    //   # Report is developed to Print CAL Test Details
    // HEI.02 CHG2185291 IBM SAXENA03 15.05.2023
    //   # Added code for Consolidation of Test Script objects

    // BC Upgrade PATELP08 >> 
    // # Replaced Custom object with standard ones from CAL Test Line HNK to CAL Test Line.
    // # Added ApplicationArea property.
    // # Modified RDLCLayout Path. 
    // BC Upgrade PATELP08 <<

    DefaultLayout = RDLC;
    // BC Upgrade KAPOOV01 Modified RDLCLayout Path>>
    //RDLCLayout = './CAL Test Summary.rdlc';
    RDLCLayout = '.\src\ReportsLayout\CAL Test Summary.rdl';
    // BC Upgrade KAPOOV01 Modified RDLCLayout Path<<

    // BC Upgrade PATELP08 >> Added ApplicationArea property.
    ApplicationArea = All;
    // BC Upgrade PATELP08 <<
    dataset
    {
        // BC Upgrade PATELP08 >> Replaced Custom object with standard ones.
        //dataitem("CAL Test Line HNK";"CAL Test Line HNK")
        dataitem("CAL Test Line HNK"; "CAL Test Line")
        // BC Upgrade PATELP08 <<
        {
            DataItemTableView = SORTING("Test Suite", "Line No.") WHERE("Line Type" = FILTER(Function));
            RequestFilterFields = "Document Reference No. FND";
            column(Function_CALTestLineHNK; "CAL Test Line HNK"."Function")
            {
            }
            column(Result_CALTestLineHNK; "CAL Test Line HNK".Result)
            {
            }
            column(Company_Name; Company)
            {
            }
            column(TotalFailure; TotalFailure)
            {
            }
            column(TotalSuccess; TotalSuccess)
            {
            }
            column(TotalSkip; TotalSkip)
            {
            }
            column(DocumentReferenceNo_CALTestLineHNK; "CAL Test Line HNK"."Document Reference No. FND")
            {
            }
            column(TestCodeunit_CALTestLineHNK; "CAL Test Line HNK"."Test Codeunit")
            {
            }

            trigger OnAfterGetRecord();
            begin
                Company := COMPANYNAME;

                if "CAL Test Line HNK"."Line Type" = "CAL Test Line HNK"."Line Type"::"Function" then begin
                    if "CAL Test Line HNK".Result = "CAL Test Line HNK".Result::Success then
                        TotalSuccess := TotalSuccess + 1;
                    if "CAL Test Line HNK".Result = "CAL Test Line HNK".Result::Failure then
                        TotalFailure := TotalFailure + 1;
                    if "CAL Test Line HNK".Result = "CAL Test Line HNK".Result::Skipped then
                        TotalSkip := TotalSkip + 1;

                end;
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
        TotalSuccess := 0;
        TotalFailure := 0;
        TotalSkip := 0;
    end;

    var
        Company: Text;
        TotalSuccess: Integer;
        TotalFailure: Integer;
        TotalSkip: Integer;
}

