report 58029 "FM Customers  Manual"
{
    // version FM

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Old Report ID- 50215.
    //BC Upgrade KAPOOV01  <<


    Caption = 'FuturMaster DP Customers Master Data';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            MaxIteration = 1;
            RequestFilterFields = "No.", Name, "Customer Posting Group";

            trigger OnAfterGetRecord();
            begin
                lCustomer.COPYFILTERS(Customer);
                FMInterfacefManag.CreateMasterDataCustomers(Customer, false);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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
        FMInterfacefManag: Codeunit "FM Interface Management";
        lCustomer: Record Customer;
}

