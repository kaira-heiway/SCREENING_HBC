codeunit 58088 "FM Out Int Entries-BOM Master"
{
    //BC Upgrade GUNREM01 Old ID-50167
    // version FM

    // HEI.01 CHG2134419 S&OP IBM PATHAA02 07.12.21
    //   # SP BOM Master for Burundi Opcos (Also, Stlucia, Bahamas, Panama, Haiti & Suriname)
    // HEI.02 INC4158610 IBM GHOSHS05 28.06.22 - Adding permissions for Interface Setup
    // # Read, Insert, Modify and Delete

    Permissions = TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin
        CreateBOMMaster(gBOMHeader, true); //HEI.01
    end;

    var
        gBOMHeader: Record "Production BOM Header";
        gProdOrderLine: Record "Prod. Order Line";

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

