codeunit 58071 "FM Out Int Entries-DtW"
{
    //BC Upgrade GUNREM01 Old ID-50165
    // version FM

    // HEI.01 IBM.AK CHG2100087(Standard change) 03-06-21
    // # Burundi Opco, copied calling functions from CU's (50071 to 50074)
    // # As Burundi wants to use only 9 Interfaces out of 19, using a seperate CU
    // # Using the CU's (50071-50074) built for Rwanda is leading to error in Jobqueue (Interface setup doesn't exist, as we have not configured complete interfaces like rwanda in burundi)
    // 
    // HEI.02 IBM.AK 25.10.21
    // # Run DtW Interfaces via CU50165  except Product Master on Monday through JQ for below Opcos.
    // # RITM2813203- Burundi
    // # CHG2119606 - St Lucia
    // # CHG2119604 - Bahamas
    // # CHG2119605 - Panama
    // # CHG2119509 - Haiti
    // 
    // HEI.03 CHG2146201/RITM2948474 IBM.AK 23.02.22
    // # Remove Function CreateStockOnHandWeek and add the same in new CU 50220
    // # Move SOH interface from Job Queue 50165 to a new Job Queue CU50220
    // 
    // HEI.04 CHG2139842 IBM.AK 23.02.22  [New FM Outbound Interface-Stock Transfer Order Virtual Warehouse]
    // # Created new function -CreateStockTOVirtualWH
    // HEI.05 INC4158610 IBM GHOSHS05 28.06.22 - Adding permissions for Interface Setup
    // # Read, Insert, Modify and Delete

    Permissions = TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin

        //CreateStockOnHandWeek(gILE, TRUE); //HEI.03
        CreateMasterDataProdComp(gItem, true);
        CreateMasterDataFinishUOM(gItem, true);

        CreateStandardCost(gItem, true);
        CreateSemiFinishedProducts(gItem, true);

        CreateProcFirmOrders(gProdOrderLine, true);
        CreateStockTransfOrders(gTransfLines, true);
        CreateActualProduction(gProdOrder, true);

        CreateStockTOVirtualWH(gTransfLines, true); //HEI.04
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

    local procedure CreateStockOnHandWeek(ILE: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        FMInterfaceManag: Codeunit "FM Interface Management";
    begin
        //FMInterfaceManag.CreateStockOnHand(ILE, Scheduled) //HEI.03
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
        FMInterfaceManag.CreateComponentDataProducts(Item, Scheduled);
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
        FMInterfaceManag.CreateFinishedUOMProducts(Item, Scheduled);
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
        FMInterfaceManag.CreateStandardCost(Item, Scheduled);
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
        FMInterfaceManag.CreateSemiFinished(Item, Scheduled);
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
        FMInterfaceManag.CreateProcFirmPlannedOrders(ProdOrderLine, Scheduled);
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
        FMInterfaceManag.CreateStockTranspOrders(StockTransf, Scheduled);
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
        FMInterfaceManag.CreateActualProduction(ProdOrder, Scheduled);
    end;

    procedure CreateStockTOVirtualWH(TransferLine: Record "Transfer Line"; Scheduled: Boolean);
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
        FMInterfaceManag.CreateStockTOVirtualLoc(TransferLine, Scheduled);//HEI.04
    end;
}

