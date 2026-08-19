codeunit 58075 "FM BI - DP Sell Actuals Week"
{
    //BC Upgrade GUNREM01 Old ID-50171
    // version FM

    // HEI.01 CHG2102974 IBM GAVANM01 07.05.2021 # Deploy S&OP interfaces to Burundi
    //   #DP Sell in Actuals Week
    //   #DP Sell in Actuals Week 3 Years
    // HEI.02 INC4158610 IBM GHOSHS05 28.06.22 - Adding permissions for Interface Setup
    // # Read, Insert, Modify and Delete

    Permissions = TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin
        //HEI.01<<
        CreateSellInActualsWeek(gILE, true);
        CreateSellInActualsWeek3YR(gILE, true);
        //HEI.01>>
    end;

    var
        gILE: Record "Item Ledger Entry";

    local procedure CreateSellInActualsWeek(ILE: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //>>HEI.01
        FMInterfaceManag.CreateSellInActualsWeek(ILE, Scheduled)
    end;

    local procedure CreateSellInActualsWeek3YR(ILE: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //HEI.01
        FMInterfaceManag.CreateSellInActualsWeek3YR(ILE, Scheduled)
    end;
}

