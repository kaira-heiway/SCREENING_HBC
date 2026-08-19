report 58022 "FM BOM Version Master Manual"
{
    //BC Upgrade GUNREM01 Old ID-50560
    // version FM

    // HEI.01 CHG2150741 IBM GOKULS01 21/07/2022 # BOM Version interface
    //   # Created Report for runing the Version Interface with Dell boomi

    Caption = '"FuturMaster SP BOM Version Master"';//BC UPGRADE PATHAA02 08.06.26
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis; //BC UPGRADE PATHAA02 08.06.26

    dataset
    {
        dataitem("Production Version Data FND"; "Production Version Data FND")
        {

            trigger OnAfterGetRecord();
            begin
                FMInterfacefManag.CreateBOMVersionMaster("Production Version Data FND", false);
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

