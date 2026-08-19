codeunit 58065 "FM SP12 Outbound Interf Entr"
{
    // version FM

    //BC Upgrade GUNREM01 Old ID-50073
    // HEI.01 S&OP IBM POSTOI01 01.02.2019
    //   # SP Standard Cost
    //   # SP Semi Finished Products Master
    //   # SP Open Purchase orders
    //   # SP BOM Master
    // HEI.02 INC4158610 IBM GHOSHS05 28.06.22 - Adding permissions for Interface Setup
    // # Read, Insert, Modify and Delete

    Permissions = TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin

        CreateStandardCost(gItem, true); //HEI.01
        CreateSemiFinishedProducts(gItem, true); //HEI.01
        CreateSupplyPlanningPurchOpenOrders(gPurchaseLine, true); //HEI.01
        CreateBOMMaster(gBOMHeader, true); //HEI.01
    end;

    var
        gSalesLine: Record "Sales Line";
        gItem: Record Item;
        gCustomer: Record Customer;
        gILE: Record "Item Ledger Entry";
        gPurchaseLine: Record "Purchase Line";
        gProdOrder: Record "Production Order";
        gTransfLines: Record "Transfer Line";
        gPurchaseHeader: Record "Purchase Header";
        gBOMHeader: Record "Production BOM Header";
        gProdOrderLine: Record "Prod. Order Line";

    procedure CreateStandardCost(Item: Record Item; Scheduled: Boolean);
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
        //>>HEI.01
        FMInterfaceManag.CreateStandardCost(Item, Scheduled);
        //<<HEI.01
    end;

    procedure CreateSemiFinishedProducts(Item: Record Item; Scheduled: Boolean);
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
        //>>HEI.01
        FMInterfaceManag.CreateSemiFinished(Item, Scheduled);
        //<<HEI.01
    end;

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
        //>>HEI.01
        FMInterfaceManag.CreateSupplyPlanPurchOpenOrders(PurchaseLine, Scheduled);
        //<<HEI.01
    end;

    procedure CreateBOMMaster(BOMHeader: Record "Production BOM Header"; Scheduled: Boolean);
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
        //>>HEI.01
        FMInterfaceManag.CreateBOMMaster(BOMHeader, Scheduled);
        //<<HEI.01
    end;
}

