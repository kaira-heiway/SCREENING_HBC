report 58018 "FM BOM Master Manual"
{
    // version FM

    // HEI.01 OF_F_CORE Supply Planning 006_ Bill of materials master - V 0.2 FINAL IBM POSTOI01
    //   # create object
    // BC Upgrade BHARAD11 >>
    // 1. Old Report ID - 50242.
    // 2. Add ApplicationArea and UsageCategory Property in Report.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = '"FuturMaster SP BOM Master "';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Production BOM Header"; "Production BOM Header")
        {
            MaxIteration = 1;
            RequestFilterFields = Status, "No.";

            trigger OnAfterGetRecord();
            begin
                lBOMMAster.COPYFILTERS("Production BOM Header");

                FMInterfacefManag.CreateBOMMaster("Production BOM Header", false);
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
        lBOMMAster: Record "Production BOM Header";
}

