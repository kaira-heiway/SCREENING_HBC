report 51105 "Delete Obsolete LSR TO CBN"
{
    // BC Upgrade MISHRS14 >>
    // Created new report NAV ID- 50607
    // HEI.01 CHG2278207 IBM ADHIKG01 31.01.2025 Deletion of Obsolete Transfer Order from 2019 to 2023.
    // # New Report (50607: Delete Obsolete LSR TO) developed for mass deletion of LSR Transfer Orders.
    // BC Upgrade MISHRS14 <<

    Caption = 'Delete Obsolete LSR TO CBN';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset
    {
        dataitem(TransferHeader; "Transfer Header")
        {
            DataItemTableView = SORTING("No.")
                                WHERE("LSR Order No FND" = FILTER(<> ''));

            trigger OnPreDataItem()
            begin
                Clear(CntTODelete);
                WarehouseSetup.Get();
                if WarehouseSetup."Transfer Order Ship Date FND" = ' ' then
                    CurrReport.Break();

                SetFilter("Posting Date", WarehouseSetup."Transfer Order Ship Date FND");
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(PartialShipReceipt);

                TransferLine.Reset();
                TransferLine.SetCurrentKey("Document No.");
                TransferLine.SetRange("Document No.", TransferHeader."No.");

                if TransferLine.FindSet(false) then
                    repeat
                        if ((TransferLine."Quantity Shipped" > 0) and
                            (TransferLine."Quantity Shipped" < TransferLine.Quantity))
                           or
                           ((TransferLine."Quantity Received" > 0) and
                            (TransferLine."Quantity Received" < TransferLine.Quantity))
                        then
                            PartialShipReceipt := true;
                    until (TransferLine.Next() = 0) or PartialShipReceipt;

                if not PartialShipReceipt then begin
                    CntTODelete += 1;

                    TransferHeader2.Get(TransferHeader."No.");
                    TransferHeader2."LSR Order No FND" := '';

                    if TransferHeader2.Status = TransferHeader2.Status::Released then begin
                        ReleaseTransferDoc.Reopen(TransferHeader2);
                        TransferHeader2.Modify(true);
                    end;

                    WhseShipHeader.Reset();
                    WhseShipHeader.SetCurrentKey("Source Document Type FND", "Source No. FND");
                    WhseShipHeader.SetRange(
                        "Source Document Type FND",
                        WhseShipHeader."Source Document Type FND"::"Outbound Transfer");
                    WhseShipHeader.SetRange("Source No. FND", TransferHeader."No.");

                    if WhseShipHeader.FindSet(false) then
                        repeat
                            if WhseShipHeader.Status = WhseShipHeader.Status::Released then begin
                                ReleaseWhseShptDoc.Reopen(WhseShipHeader);

                                WhseShipHeader1.Get(WhseShipHeader."No.");
                                WhseShipHeader1.Delete(true);
                            end else
                                WhseShipHeader.Delete(true);
                        until WhseShipHeader.Next() = 0;

                    WhseReceiptHeader.Reset();
                    WhseReceiptHeader.SetCurrentKey("Source Document Type FND", "Source No. FND");
                    WhseReceiptHeader.SetRange(
                        "Source Document Type FND",
                        WhseReceiptHeader."Source Document Type FND"::"Inbound Transfer");
                    WhseReceiptHeader.SetRange("Source No. FND", TransferHeader."No.");
                    WhseReceiptHeader.DeleteAll(true);
                    ReservationEntry.Reset();
                    ReservationEntry.SetCurrentKey("Source Type", "Source ID");
                    ReservationEntry.SetRange("Source Type", Database::"Transfer Line");
                    ReservationEntry.SetRange("Source ID", TransferHeader."No.");
                    ReservationEntry.DeleteAll(true);

                    TransferHeader2.Delete(true);
                end;
            end;
        }
    }

    trigger OnPostReport()
    begin
        if GuiAllowed then begin
            if CntTODelete <> 0 then
                Message(Text001, CntTODelete)
            else
                Message(Text002);
        end;
    end;

    var
        WarehouseSetup: Record "Warehouse Setup";
        ReservationEntry: Record "Reservation Entry";
        TransferLine: Record "Transfer Line";
        TransferHeader2: Record "Transfer Header";
        WhseShipHeader: Record "Warehouse Shipment Header";
        WhseShipHeader1: Record "Warehouse Shipment Header";
        WhseReceiptHeader: Record "Warehouse Receipt Header";
        ReleaseTransferDoc: Codeunit "Release Transfer Document";
        ReleaseWhseShptDoc: Codeunit "Whse.-Shipment Release";
        PartialShipReceipt: Boolean;
        CntTODelete: Integer;
        Text001: Label 'Transfer Orders Deleted: %1';
        Text002: Label 'There is no Transfer Order to Delete';
}
