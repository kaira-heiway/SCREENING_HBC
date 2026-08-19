codeunit 58064 "FM SP11 Outbound Interf Entr"
{
    // version FM

    //BC Upgrade GUNREM01 Old ID-50072
    // HEI.01 S&OP IBM POSTOI01 01.02.2019
    //   # SP Open Sales Orders
    //   # SP Stock on Hand
    //   # SP Component Products Master Data
    //   # SP Finished Products UOMs
    // HEI.02 INC4158610 IBM GHOSHS05 28.06.22 - Adding permissions for Interface Setup
    // # Read, Insert, Modify and Delete

    Permissions = TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin

        CreateSupplyPlanningOpenOrders(gSalesLine, true);  //HEI.01
        CreateStockOnHandWeek(gILE, true); //HEI.01
        CreateMasterDataProdComp(gItem, true); //HEI.01
        CreateMasterDataFinishUOM(gItem, true); //HEI.01
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
        //>>HEI.01
        FMInterfaceManag.CreateSupplyPlanOpenOrders(SalesLine, Scheduled);
        //<<HEI.01
    end;

    local procedure CreateStockOnHandWeek(ILE: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //>>HEI.01
        FMInterfaceManag.CreateStockOnHand(ILE, Scheduled)
        //<<HEI.01
    end;

    procedure CreateMasterDataProdComp(Item: Record Item; Scheduled: Boolean);
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
        FMInterfaceManag.CreateComponentDataProducts(Item, Scheduled);
        //<<HEI.01
    end;

    procedure CreateMasterDataFinishUOM(Item: Record Item; Scheduled: Boolean);
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
        FMInterfaceManag.CreateFinishedUOMProducts(Item, Scheduled);
        //<<HEI.01
    end;
}

