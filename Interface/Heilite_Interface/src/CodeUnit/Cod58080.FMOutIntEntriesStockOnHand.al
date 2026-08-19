codeunit 58080 "FM Out Int Entries-StockOnHand"
{
    //BC Upgrade GUNREM01 Old ID-50184
    // HEI.01 CHG2146201/RITM2948474 IBM.AK 24.02.22
    // # Added Function CreateStockOnHandWeek
    // # Move SOH interface from Job Queue 50165 to a new Job Queue CU50220
    // HEI.02 INC4158610 IBM GHOSHS05 28.06.22 - Adding permissions for Interface Setup
    // # Read, Insert, Modify and Delete

    Permissions = TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin
        CreateStockOnHandWeek(gILE, true);
    end;

    var
        gILE: Record "Item Ledger Entry";

    procedure CreateStockOnHandWeek(ILE: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        FMInterfaceManag.CreateStockOnHand(ILE, Scheduled)
    end;
}

