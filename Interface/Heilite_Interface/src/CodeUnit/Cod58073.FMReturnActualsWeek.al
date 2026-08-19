codeunit 58073 "FM - Return Actuals Week"
{
        //BC Upgrade GUNREM01 Old ID-50169
    // version HEI.02

    // HEI.01 CHG2174570 IBM.SCO 06.12.22 S&OP New Interface Demand Planning for Returns
    //   # new report
    // HEI.02 CHG2214545  IBM COSTES04 08.08.2023  Return Interfaces to be renumbered in our license range
    //   # Renumber object from 50221 to 50169


    trigger OnRun();
    begin
        //HEI.01
        CreateReturnActualsWeek;
        CreateReturnActualsWeek3YR;
    end;

    local procedure CreateReturnActualsWeek();
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //HEI.01
        FMInterfaceManag.CreateReturnActualsWeek(ItemLedgerEntry, true);
    end;

    local procedure CreateReturnActualsWeek3YR();
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //HEI.01
        FMInterfaceManag.CreateReturnActualsWeek3YR(ItemLedgerEntry, true);
    end;
}

