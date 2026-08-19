codeunit 58070 "FM Out Int Entries-Prod Master"
{
    //BC upgrade GUNREM0 Old ID-50163
    // version FM

    // HEI.01 IBM.AK CHG2100087(Standard change) 03-06-21
    // # Burundi Opco, copied calling functions from CU's (50071 to 50074)
    // # As Burundi wants to use only 9 Interfaces out of 19, using a seperate CU
    // # Using the CU's (50071-50074) built for Rwanda is leading to error in Jobqueue (Interface setup doesn't exist, as we have not configured complete interfaces like rwanda in burundi)
    // 
    // HEI.02 IBM.AK 25.10.21
    // # Run CU50163 only as Product Master for all Days through JQ for below Opcos.
    // # RITM2813203- Burundi
    // # CHG2119606 - St Lucia
    // # CHG2119604 - Bahamas
    // # CHG2119605 - Panama
    // # CHG2119509 - Haiti
    // HEI.03 INC4158610 IBM GHOSHS05 28.06.22 - Adding permissions for Interface Setup
    // # Read, Insert, Modify and Delete

    Permissions = TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin
        CreateMasterDataProducts(gItem, true);
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
        FMInterfaceManag.CreateMasterDataProducts(Item, Scheduled);
    end;
}

