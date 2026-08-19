codeunit 58046 "Create Interface Outb. Entries"
{
    // version HEI.01
    // BC Upgrade GUNERE01 - Old ID 50021

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New codeunit for Interface Common Framework
    // HEI.02 HB1986 - CHG2095257 IBM NANDIS01 16.03.2021 - Maximo Unit Cost interface Redesign
    //   # New function created CreateUnitCostRedesigned for Maximo Unit cost interface


    trigger OnRun();
    begin
        CreateSRMEntries;
        CreateMaximoEntries;
    end;

    local procedure CreateSRMEntries();
    var
        SRMInterfaceManagement: Codeunit "SRM Interface Management";
    begin
        SRMInterfaceManagement.CreateAccountAssignment;
        SRMInterfaceManagement.CreateGLAccount;
    end;

    local procedure CreateMaximoEntries();
    var
        MaximoInterfaceManagement: Codeunit "Maximo Interface Management";
    begin
        //HEI.02>>
        //MaximoInterfaceManagement.CreateUnitCost;
        MaximoInterfaceManagement.CreateUnitCostRedesigned;
        //HEI.02<<
    end;
}

