report 55016 "C2S Items UoM Missing Setup"
{
    // HEI.01 CHG2143950 IBM BULIMC01 27/01/2022#new report created to show the missing setup for finished goods and RPM items

    // BC Upgrade POENAB02: Original (HeiLite) report id 50530

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\C2S Items UoM Missing Setup.rdl';

    Caption = 'C2S Items UoM Missing Setup';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.") order(ascending);
            RequestFilterFields = "No.";
            column(No_Item; "No.")
            {
                IncludeCaption = true;
            }
            column(Description_Item; Description)
            {
                IncludeCaption = true;
            }
            column(CategoryCode_Item; "Item Category Code")
            {
                IncludeCaption = true;
            }
            column(BaseUnitofMeasure_Item; "Base Unit of Measure")
            {
                IncludeCaption = true;
            }
            dataitem("Item Unit of Measure"; "Item Unit of Measure")
            {
                DataItemLink = "Item No." = field("No."), Code = field("Base Unit of Measure");
                DataItemTableView = sorting("Item No.", Code) order(ascending);
                column(UnitofWeight_ItemUnitofMeasure; "Unit of Weight FND")
                {
                    IncludeCaption = true;
                }
                column(NetWeight_ItemUnitofMeasure; "Net Weight FND")
                {
                    IncludeCaption = true;
                }
                column(CompanyName; CompanyName)
                {
                }
                column(WhseSetup_Kg; WarehouseSetup."Net Weight UoM (Kg) FND")
                {
                }
                column(WhseSetup_G; WarehouseSetup."Net Weight UoM (G) FND")
                {
                }
            }

            trigger OnAfterGetRecord();
            begin
                if (StrPos(InventorySetup."Finished Goods ItemCatCode FND", "Item Category Code") = 0) and (STRPOS(SalesSetup."RPMRelatedItemCategoryCode FND", "Item Category Code") = 0) then
                    CurrReport.Skip();
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
        DateLbl = 'Date:'; CompanyLbl = 'Company:';
    }

    trigger OnPreReport();
    begin
        InventorySetup.Get();
        SalesSetup.Get();
        WarehouseSetup.Get();
    end;

    var
        InventorySetup: Record "Inventory Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        WarehouseSetup: Record "Warehouse Setup";
}

