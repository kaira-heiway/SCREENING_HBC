report 55039 "CA Module - Cust. Dimensions"
{
    // HEI.01 CHG2088211 IBM BULIM01 11/10/2020 #new report created to see the customers with missing mandatory dim for CA Module
    // HEI.02 CHG2090275 IBM BULIM01 05/12/2020 #layout changes - increase paper size


    //BC Upgrade KAPOOV01 >>
    // 1. Add layout path and Change extension RDLC to RDL.
    // 2. Add ApplicationArea and UsageCategory property in Report.
    // 3. Old Report ID- 50468.
    //BC Upgrade KAPOOV01  <<

    DefaultLayout = RDLC;
    //RDLCLayout = './CA Module - Cust. Dimensions.rdlc'; //BC Upgrade KAPOOV01 Commented
    RDLCLayout = '.\src\ReportsLayout\CA Module - Cust. Dimensions.rdl'; //BC Upgrade KAPOOV01 Changed  layout path and extension changed from RDLC to RDL.

    Caption = 'CA Module - Missing Customer Dimensions';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.";
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
                IncludeCaption = true;
            }
            column(Dim1; Dim1)
            {
            }
            column(Dim2; Dim2)
            {
            }
            column(Dim3; Dim3)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }

            trigger OnAfterGetRecord();
            begin
                Dim1 := '';
                Dim2 := '';
                Dim3 := '';

                DefaultDimension.RESET;
                DefaultDimension.SETRANGE("Table ID", DATABASE::Customer);
                DefaultDimension.SETRANGE("No.", "No.");
                DefaultDimension.SETRANGE("Dimension Code", GLSetup."Business Type Dim Code FND");
                if DefaultDimension.FINDFIRST then
                    Dim1 := DefaultDimension."Dimension Value Code";


                DefaultDimension.RESET;
                DefaultDimension.SETRANGE("Table ID", DATABASE::Customer);
                DefaultDimension.SETRANGE("No.", "No.");
                DefaultDimension.SETRANGE("Dimension Code", 'SERVICE ZONE');
                if DefaultDimension.FINDFIRST then
                    Dim2 := DefaultDimension."Dimension Value Code";

                DefaultDimension.RESET;
                DefaultDimension.SETRANGE("Table ID", DATABASE::Customer);
                DefaultDimension.SETRANGE("No.", "No.");
                DefaultDimension.SETRANGE("Dimension Code", 'CHANNEL');
                if DefaultDimension.FINDFIRST then
                    Dim3 := DefaultDimension."Dimension Value Code";

                if (Dim1 <> '') and (Dim2 <> '') and (Dim3 <> '') then
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem();
            begin
                GLSetup.GET;
                CompanyInfo.GET;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
        Dim1Lbl = 'BUSS_SEG'; Dim2Lbl = 'SERVICE ZONE'; DIm3Lbl = 'CHANNEL'; CustNoLbl = 'Customer No.'; TitleLbl = 'Cost Accounting Module - Customers with missing dimensions'; CompanyLbl = 'Company:'; DateLbl = 'Date:';
    }

    var
        Option: Option Customer,Item;
        DefaultDimension: Record "Default Dimension";
        GLSetup: Record "General Ledger Setup";
        Dim1: Code[20];
        Dim2: Code[20];
        Dim3: Code[20];
        CompanyInfo: Record "Company Information";
}

