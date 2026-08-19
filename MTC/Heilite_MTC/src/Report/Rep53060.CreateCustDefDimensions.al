report 53060 "Create Cust Def Dimensions"
{
    // version HEI.01

    // HEI.01 Defect #1385 IBM NASTAA02 11.01.2018 # Create Customer Default dimensions for Multiple customers
    //   # New Report created to add Customer Default Dimensions for multiple Customers
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID - 50091.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Create Customer Default Dimensions for Multiple Customers';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            begin
                CopyToDefaultDimensions(Customer."No.");
            end;

            trigger OnPostDataItem();
            begin
                MESSAGE(CustDefaultDimCreatedMsg);
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
        CustDefaultDimCreatedMsg: Label 'Customer Default Dimensions were created.';
}

