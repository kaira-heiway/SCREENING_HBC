codeunit 58072 "FM - Return Actuals Month"
{
     //BC Upgrade GUNREM01 Old ID-50168
    // version HEI.02
   
    // HEI.01 CHG2174570 IBM COSTES04 06.12.22 S&OP New Interface Demand Planning for Returns
    //   # new codeunit
    // HEI.02 CHG2214545  IBM COSTES04 08.08.2023  Return Interfaces to be renumbered in our license range
    //   # Renumber object from 50220 to 50168


    trigger OnRun();
    begin
        //HEI.01
        CreateReturnActualsMonth;
        CreateReturnActualsMonth3YR;
    end;

    local procedure CreateReturnActualsMonth();
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //HEI.01
        FMInterfaceManag.CreateReturnActualsMonth(ItemLedgerEntry, true);
    end;

    local procedure CreateReturnActualsMonth3YR();
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //HEI.01
        FMInterfaceManag.CreateReturnActualsMonth3YR(ItemLedgerEntry, true);
    end;
}

