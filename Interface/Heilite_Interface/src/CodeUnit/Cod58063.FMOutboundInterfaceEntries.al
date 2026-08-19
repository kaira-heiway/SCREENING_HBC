codeunit 58063 "FM Outbound Interface Entries"
{
    // version FM
    //BC Upgrade GUNREM01 Old ID-50071
    // HEI.01 S&OP IBM POSTOI01 01.02.2019 DP Products Master Data
    // HEI.02 S&OP IBM POSTOI01 01.02.2019 DP Customers Master Data
    // HEI.03 S&OP IBM POSTOI01 01.02.2019 DP Open Orders
    // HEI.04 S&OP IBM POSTOI01 01.02.2019 DP Sell in Actuals Month
    // HEI.05 S&OP IBM POSTOI01 01.02.2019 DP Sell in Actuals Week
    // HEI.06 S&OP IBM POSTOI01 01.02.2019 DP Sell in Actuals Month 3 Years
    // HEI.07 S&OP IBM POSTOI01 01.02.2019 DP Sell in Actuals Week 3 Years
    // HEI.08 S&OP IBM POSTOI01 01.02.2019 SP Open Orders
    // HEI.09 S&OP IBM POSTOI01 01.02.2019 SP Stock on Hand
    // HEI.10 S&OP IBM POSTOI01 01.02.2019 SP Component Products Master Data
    // HEI.11 S&OP IBM POSTOI01 01.02.2019 SP Finished Products UOMs
    // HEI.12 S&OP IBM POSTOI01 01.02.2019 SP Standard Cost
    // HEI.13 S&OP IBM POSTOI01 01.02.2019 SP Semi Finished Products Master
    // HEI.14 S&OP IBM POSTOI01 01.02.2019 SP Open Purchase Orders
    // HEI.15 S&OP IBM POSTOI01 01.02.2019 SP Process Order related Schedule Receipts
    // HEI.16 S&OP IBM POSTOI01 01.02.2019 SP Stock Transport Order Related Schedule Receipts
    // HEI.17 S&OP IBM POSTOI01 01.02.2019 SP Actual Production
    // HEI.18 S&OP IBM POSTOI01 01.02.2019 SP Purchasing Master Data
    // HEI.19 S&OP IBM POSTOI01 01.02.2019 SP BOM Master
    // HEI.20 S&OP IBM POSTOI01 05.21.2019
    //   # comment SP1 and SP2 interfaces
    // HEI.21 CHG2133239 BHANDS01 11-17-2021
    //   # Modified code on CreateProcFirmOrders() to resolve compilation error
    // HEI.22 INC4158610 IBM GHOSHS05 28.06.22 - Adding permissions for Interface Setup
    // # Read, Insert, Modify and Delete

    Permissions = TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin
        CreateDemandPlanningOpenOrders(gSalesLine, true); //HEI.03
        CreateMasterDataProducts(gItem, true);  //HEI.01
        CreateMasterDataCustomers(gCustomer, true);  //HEI.02
        CreateSellInActualsMonth(gILE, true); //HEI.04
        CreateSellInActualsWeek(gILE, true); //HEI.05
        CreateSellInActualsMonth3YR(gILE, true); //HEI.06
        CreateSellInActualsWeek3YR(gILE, true); //HEI.07

        //HEI.20>>
        /*
        CreateSupplyPlanningOpenOrders(gSalesLine, TRUE);  //HEI.08
        CreateStockOnHandWeek(gILE, TRUE); //HEI.09
        CreateMasterDataProdComp(gItem, TRUE); //HEI.10
        CreateMasterDataFinishUOM(gItem, TRUE); //HEI.11
        CreateStandardCost(gItem, TRUE); //HEI.12
        CreateSemiFinishedProducts(gItem, TRUE); //HEI.13
        CreateSupplyPlanningPurchOpenOrders(gPurchaseLine, TRUE); //HEI.14
        CreateProcFirmOrders(gProdOrder, TRUE); //HEI.15
        CreateStockTransfOrders(gTransfLines, TRUE); //HEI.16
        CreateActualProduction(gProdOrder, TRUE); //HEI.17
        CreatePurchMasterData(gPurchaseHeader, TRUE); //HEI.18
        CreateBOMMaster(gBOMHeader, TRUE) //HEI.19
        */
        //HEI.20<<

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

    procedure CreateDemandPlanningOpenOrders(SalesLine: Record "Sales Line"; Scheduled: Boolean);
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
        //>>HEI.03
        FMInterfaceManag.CreateDemandPlanOpenOrders(SalesLine, Scheduled);
        //<<HEI.03
    end;

    procedure CreateMasterDataProducts(Item: Record Item; Scheduled: Boolean);
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
        FMInterfaceManag.CreateMasterDataProducts(Item, Scheduled);
        //<<HEI.01
    end;

    procedure CreateMasterDataCustomers(Customer: Record Customer; Scheduled: Boolean);
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
        //>>HEI.02
        FMInterfaceManag.CreateMasterDataCustomers(Customer, Scheduled);
        //<<HEI.02
    end;

    local procedure CreateSellInActualsMonth(ILE: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //>>HEI.04
        FMInterfaceManag.CreateSellInActualsMonth(ILE, Scheduled)
        //<<HEI.04
    end;

    local procedure CreateSellInActualsWeek(ILE: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //>>HEI.05
        FMInterfaceManag.CreateSellInActualsWeek(ILE, Scheduled)
        //<<HEI.05
    end;

    local procedure CreateSellInActualsMonth3YR(ILE: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //>>HEI.06
        FMInterfaceManag.CreateSellInActualsMonth3YR(ILE, Scheduled)
        //<<HEI.06
    end;

    local procedure CreateSellInActualsWeek3YR(ILE: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //>>HEI.07
        FMInterfaceManag.CreateSellInActualsWeek3YR(ILE, Scheduled)
        //<<HEI.07
    end;

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
        //>>HEI.08
        FMInterfaceManag.CreateSupplyPlanOpenOrders(SalesLine, Scheduled);
        //<<HEI.08
    end;

    local procedure CreateStockOnHandWeek(ILE: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //>>HEI.09
        FMInterfaceManag.CreateStockOnHand(ILE, Scheduled)
        //<<HEI.09
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
        //>>HEI.10
        FMInterfaceManag.CreateComponentDataProducts(Item, Scheduled);
        //<<HEI.10
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
        //>>HEI.11
        FMInterfaceManag.CreateFinishedUOMProducts(Item, Scheduled);
        //<<HEI.11
    end;

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
        //>>HEI.12
        FMInterfaceManag.CreateStandardCost(Item, Scheduled);
        //<<HEI.12
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
        //>>HEI.13
        FMInterfaceManag.CreateSemiFinished(Item, Scheduled);
        //<<HEI.13
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
        //>>HEI.14
        FMInterfaceManag.CreateSupplyPlanPurchOpenOrders(PurchaseLine, Scheduled);
        //<<HEI.14
    end;

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
        //>>HEI.15
        // HEI.21 >>
        // FMInterfaceManag.CreateProcFirmPlannedOrders(ProdOrder, Scheduled);
        FMInterfaceManag.CreateProcFirmPlannedOrders(ProdOrderLine, Scheduled);
        // HEI.21 <<
        //<<HEI.15
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
        //>>HEI.16
        FMInterfaceManag.CreateStockTranspOrders(StockTransf, Scheduled);
        //<<HEI.16
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
        //>>HEI.17
        FMInterfaceManag.CreateActualProduction(ProdOrder, Scheduled);
        //<<HEI.17
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
        //>>HEI.18
        FMInterfaceManag.CreatePurchMasterData(PurchHeader, Scheduled);
        //<<HEI.18
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
        //>>HEI.19
        FMInterfaceManag.CreateBOMMaster(BOMHeader, Scheduled);
        //<<HEI.19
    end;
}

