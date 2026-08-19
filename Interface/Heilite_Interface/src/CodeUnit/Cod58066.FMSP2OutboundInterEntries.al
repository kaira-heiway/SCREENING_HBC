codeunit 58066 "FM SP2 Outbound Interf Entries"
{
    // version FM

    //BC Upgrade GUNREM01 Old ID-50074  
    // HEI.01 S&OP IBM POSTOI01 01.02.2019
    //   # SP Process Order related Schedule Receipts
    //   # SP Stock Transport Order Related Schedule Receipts
    //   # SP Actual Production
    //   # SP Purchasing Master Data
    // HEI.02 CHG2152651(CC) IBM.PATHAA02  29.03.22
    //   # Created new function -CreateStockTOVirtualWH or Rwanda JQ
    // HEI.03 INC4158610 IBM GHOSHS05 28.06.22 - Adding permissions for Interface Setup
    // # Read, Insert, Modify and Delete

    Permissions = TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin

        CreateProcFirmOrders(gProdOrderLine, true); //HEI.01
        CreateStockTransfOrders(gTransfLines, true); //HEI.01
        CreateActualProduction(gProdOrder, true); //HEI.01
        CreatePurchMasterData(gPurchaseHeader, true); //HEI.01
        CreateStockTOVirtualWH(gTransfLines, true); //HEI.02
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

    procedure CreateProcFirmOrders(ProdOrderLine: Record "Prod. Order Line"; Scheduled: Boolean);
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
        FMInterfaceManag.CreateProcFirmPlannedOrders(ProdOrderLine, Scheduled);
        //<<HEI.01
    end;

    procedure CreateStockTransfOrders(StockTransf: Record "Transfer Line"; Scheduled: Boolean);
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
        FMInterfaceManag.CreateStockTranspOrders(StockTransf, Scheduled);
        //<<HEI.01
    end;

    procedure CreateActualProduction(ProdOrder: Record "Production Order"; Scheduled: Boolean);
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
        FMInterfaceManag.CreateActualProduction(ProdOrder, Scheduled);
        //<<HEI.01
    end;

    procedure CreatePurchMasterData(PurchHeader: Record "Purchase Header"; Scheduled: Boolean);
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
        FMInterfaceManag.CreatePurchMasterData(PurchHeader, Scheduled);
        //<<HEI.01
    end;

    procedure CreateStockTOVirtualWH(TransferLine: Record "Transfer Line"; Scheduled: Boolean);
    var
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //HEI.02>>
        FMInterfaceManag.CreateStockTOVirtualLoc(TransferLine, Scheduled);
        //HEI.02<<
    end;
}

