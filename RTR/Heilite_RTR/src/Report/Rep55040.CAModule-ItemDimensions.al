report 55040 "CA Module - Item Dimensions"
{
    // HEI.01 CHG2088211 IBM BULIM01 11/10/2020 #new report created to see the customers with missing mandatory dim for CA Module
    // HEI.02 CHG2090275 IBM BULIM01 05/12/2020 #layout changes - increase paper size


    //BC Upgrade KAPOOV01 >>
    // 1. Add layout path and Change extension RDLC to RDL.
    // 2. Add ApplicationArea and UsageCategory property in Report.
    // 3. Old Report ID- 50469.
    //BC Upgrade KAPOOV01  <<


    DefaultLayout = RDLC;
    //RDLCLayout = './CA Module - Item Dimensions.rdlc'; //BC Upgrade KAPOOV01 Commented
    RDLCLayout = '.\src\ReportsLayout\CA Module - Item Dimensions.rdl'; //BC Upgrade KAPOOV01 Changed  layout path and extension changed from RDLC to RDL.

    Caption = 'CA Module - Missing Item Dimensions';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.", "Item Category Code";
            column(No_Item; Item."No.")
            {
            }
            column(Name_Item; Item.Description)
            {
                IncludeCaption = true;
            }
            column(ItemCategoryCode_Item; Item."Item Category Code")
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
                DefaultDimension.SETRANGE("Table ID", DATABASE::Item);
                DefaultDimension.SETRANGE("No.", "No.");
                DefaultDimension.SETRANGE("Dimension Code", GLSetup."Brand Dimension Code FND");
                if DefaultDimension.FINDFIRST then
                    Dim1 := DefaultDimension."Dimension Value Code";

                DefaultDimension.RESET;
                DefaultDimension.SETRANGE("Table ID", DATABASE::Item);
                DefaultDimension.SETRANGE("No.", "No.");
                DefaultDimension.SETRANGE("Dimension Code", GLSetup."Line ext Dimension Code FND");
                if DefaultDimension.FINDFIRST then
                    Dim2 := DefaultDimension."Dimension Value Code";

                DefaultDimension.RESET;
                DefaultDimension.SETRANGE("Table ID", DATABASE::Item);
                DefaultDimension.SETRANGE("No.", "No.");
                DefaultDimension.SETRANGE("Dimension Code", GLSetup."Primary Pack Type Dim FND");
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
        Dim1Lbl = 'BRAND'; Dim2Lbl = 'LINE_EXT'; DIm3Lbl = 'P_PCK_TYPE'; ItemNoLbl = 'Item No.'; TitleLbl = 'Cost Accounting Module - Items with missing dimensions'; CompanyLbl = 'Company:'; DateLbl = 'Date:';
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

