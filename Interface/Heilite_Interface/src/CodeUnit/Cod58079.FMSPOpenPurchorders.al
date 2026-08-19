codeunit 58079 "FM-SPOpenPurchOrders"
{
    //BC Upgrade GUNREM01 Old ID-50177
    // version HEI.02

    // HEI.01 HB2214 - CHG2105422 IBM NANDIS01 10.05.2021 # S&OP Core | Burundi | Open Purchase Order Interfaces
    //   #SP Open Purchase Orders - New codeunit created which will used as a JQ in Burundi opco
    // HEI.02 HB2585 - CHG2138180’áIBM NANDIS01 13.12.2021 # S&OP Core | One Code-Unit for Open Purchase Orders Interface
    //   # Changing the name of this CU from "FM-SPOpenPurchOrders Burundi" to "FM-SPOpenPurchOrders"
    //   # Making single codeunit for Open PO SnOP - Deleting opco specific CUs - 50182, 50183, 50184, 50185, 50186
    // HEI.03 INC4158610 IBM GHOSHS05 28.06.22 - Adding permissions for Interface Setup
    // # Read, Insert, Modify and Delete

    Permissions = TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin
        //HEI.01>>
        CreateSupplyPlanningPurchOpenOrders(gPurchaseLine, true);
        //HEI.01<<
    end;

    var
        gPurchaseLine: Record "Purchase Line";

    procedure CreateSupplyPlanningPurchOpenOrders(PurchaseLine: Record "Purchase Line"; Scheduled: Boolean);
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
        //HEI.01>>
        FMInterfaceManag.CreateSupplyPlanPurchOpenOrders(PurchaseLine, Scheduled);
        //HEI.01<<
    end;
}

