codeunit 58078 "FM BI - SP Open Sales Orders"
{
    //BC Upgrade GUNREM01 Old ID-50176
    // version FM

    // HEI.01 CHG2102974 IBM GAVANM01 07.05.2021 # Deploy S&OP interfaces to Burundi
    //   #SP Open Sales Orders
    // HEI.02 INC4158610 IBM GHOSHS05 28.06.22 - Adding permissions for Interface Setup
    // # Read, Insert, Modify and Delete

    Permissions = TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin
        CreateSupplyPlanningOpenOrders(gSalesLine, true);  //HEI.01
    end;

    var
        gSalesLine: Record "Sales Line";

    procedure CreateSupplyPlanningOpenOrders(SalesLine: Record "Sales Line"; Scheduled: Boolean);
    var
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineIn: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        PurchaseHeader: Record "Purchase Header";
        OutboundInterface: Record "Outbound Interface INT";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemHeader: Record "Purch. Cr. Memo Hdr.";
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //HEI.01
        FMInterfaceManag.CreateSupplyPlanOpenOrders(SalesLine, Scheduled);
    end;
}

