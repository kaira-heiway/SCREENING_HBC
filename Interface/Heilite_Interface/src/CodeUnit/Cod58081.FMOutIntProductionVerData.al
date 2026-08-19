codeunit 58081 "FM Out Int Production Ver Data"
{
    //BC Upgrade GUNREM01 Old ID-50189

    // version FM,HEI.01
    // HEI.01 CHG2195346 PATHAA02 20.04.2023 "S&OP FIT | BOM Interface Amendment"
    // # New CU to be scheduled as JQ to execute and send the O/P file to FM

    Permissions = TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin
        CreateBOMVersionMaster(gProdVersionData, true);
    end;

    var
        gProdVersionData: Record "Production Version Data FND";

    procedure CreateBOMVersionMaster(ProdVerData: Record "Production Version Data FND"; Scheduled: Boolean);
    var
        FMInterfaceManag: Codeunit "FM Interface Management";
        BOMHeader: Record "Production Version Data FND";
    begin

        FMInterfaceManag.CreateBOMVersionMaster(ProdVerData, Scheduled);
    end;
}

