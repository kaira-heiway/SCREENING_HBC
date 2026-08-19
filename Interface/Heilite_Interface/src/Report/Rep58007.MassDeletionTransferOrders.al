report 58007 "Mass Deletion-Transfer Orders"
{
    // version HEI.02

    // HEI.01 CHG2278211 PATHAA02 16.12.2024 Deletion of Obsolete Heilite created Transfer Orders from January 2019 up to December 2023.
    //   # New Report developed for Mass Deletion of Transfer Orders
    // HEI.02 CHG2278211 KAMNAY01 18.12.2024 Deletion of Obsolete Heilite created Transfer Orders from January 2019 up to December 2023.
    //   # Code Added to fix the data related issue

    //Bc Upgrade YADAVM09 Report property Changes.
    //Bc Upgrade YADAVM09 Added in interface extension due to dependency on interface extension field "LSR Order No".
    ProcessingOnly = true;
    ApplicationArea = All;//Bc Upgrade YADAVM09<<
    UsageCategory = ReportsAndAnalysis;//Bc Upgrade YADAVM09<<

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            begin
                //HEI.01>>
                if "Transfer Header"."LSR Order No FND" = '' then begin
                    TODelete := true;
                    //HEI.02>>
                    ShipDelete := true;
                    RecDelete := true;
                    //HEI.02<<
                    Rec_Reservationentry.RESET;
                    Rec_Reservationentry.SETRANGE("Source ID", "Transfer Header"."No.");
                    if Rec_Reservationentry.FINDSET(false) then begin
                        Rec_Reservationentry.CALCSUMS("Quantity (Base)");
                        if Rec_Reservationentry."Quantity (Base)" = 0 then
                            Rec_Reservationentry.DELETEALL(true)
                        else
                            CurrReport.SKIP;
                    end;

                    Rec_Transferline.RESET;
                    Rec_Transferline.SETRANGE("Document No.", "Transfer Header"."No.");
                    if Rec_Transferline.FINDSET(false) then begin
                        repeat
                            if (Rec_Transferline."Qty. Shipped (Base)" <> Rec_Transferline."Qty. Received (Base)") then begin
                                TODelete := false;
                                break;
                            end;
                        until Rec_Transferline.NEXT = 0;
                    end;

                    if TODelete then begin
                        CntTO := CntTO + 1;
                        if GUIALLOWED then begin
                            ProgressWindow.UPDATE(1, "Transfer Header"."No.");
                        end;

                        "Transfer Header".Status := "Transfer Header".Status::Open;
                        "Transfer Header".MODIFY(true);

                        //HEI.02>>
                        Rec_WarehouseShipmentLine.RESET;
                        Rec_WarehouseShipmentLine.SETRANGE("Source No.", "Transfer Header"."No.");
                        if Rec_WarehouseShipmentLine.FINDSET(false) then begin
                            Rec_WarehouseShipmentHeader.RESET;
                            Rec_WarehouseShipmentHeader.SETRANGE("No.", Rec_WarehouseShipmentLine."No.");
                            if Rec_WarehouseShipmentHeader.FINDFIRST then begin
                                Rec_WarehouseShipmentHeader.Status := Rec_WarehouseShipmentHeader.Status::Open;
                                Rec_WarehouseShipmentHeader.MODIFY(true);
                                Rec_WarehouseShipmentHeader.DELETE(true);
                                ShipDelete := false;
                            end;
                        end;
                        //HEI.02<<

                        if ShipDelete = true then begin //HEI.02
                            Rec_WarehouseShipmentHeader.RESET; //HEI.02
                            Rec_WarehouseShipmentHeader.SETRANGE("Source No. FND", "Transfer Header"."No.");
                            if Rec_WarehouseShipmentHeader.FINDFIRST then begin
                                Rec_WarehouseShipmentHeader.Status := Rec_WarehouseShipmentHeader.Status::Open;
                                Rec_WarehouseShipmentHeader.MODIFY(true);
                                Rec_WarehouseShipmentHeader.DELETE(true);
                            end; //HEI.02
                        end;


                        Rec_WarehouseReceiptline.RESET; //HEI.02>>
                        Rec_WarehouseReceiptline.SETRANGE("Source No.", "Transfer Header"."No.");
                        if Rec_WarehouseReceiptline.FINDSET(false) then begin
                            //HEI.02<<
                            CLEAR(Rec_WarehouseReceiptHeader);
                            Rec_WarehouseReceiptHeader.RESET;
                            //HEI.02>>
                            Rec_WarehouseReceiptHeader.SETRANGE("No.", Rec_WarehouseReceiptline."No.");
                            if Rec_WarehouseReceiptHeader.FINDFIRST then begin
                                Rec_WarehouseReceiptHeader.DELETE(true);
                                RecDelete := false;
                            end;
                        end;
                        //HEI.02<<


                        if RecDelete = true then begin //HEI.02
                            Rec_WarehouseReceiptHeader.RESET; //HEI.02
                            Rec_WarehouseReceiptHeader.SETRANGE("Source No. FND", "Transfer Header"."No.");
                            if Rec_WarehouseReceiptHeader.FINDFIRST then
                                Rec_WarehouseReceiptHeader.DELETE(true);
                        end; //HEI.02

                        "Transfer Header".DELETE(true);
                    end;
                end;
                //HEI.01<<
            end;

            trigger OnPreDataItem();
            begin
                //HEI.01>>
                CLEAR(CntTO);
                Rec_Warehousesetup.GET;
                if Rec_Warehousesetup."Transfer Order Ship Date FND" = '' then
                    exit;
                "Transfer Header".SETFILTER("Shipment Date", Rec_Warehousesetup."Transfer Order Ship Date FND");
                "Transfer Header".SETFILTER("Transfer-from Code", '<>%1', Rec_Warehousesetup."Exclude Location Filter FND");//HEI.02
                //HEI.01<<
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        //HEI.01>>

        if GUIALLOWED then
            ProgressWindow.CLOSE;
        MESSAGE('Total Transfer Orders deleted: %1', CntTO);
        CLEARALL;
        //HEI.01<<
    end;

    trigger OnPreReport();
    begin
        //HEI.01>>
        if GUIALLOWED then
            ProgressWindow.OPEN(Text001);
        //HEI.01<<
    end;

    var
        Rec_Warehousesetup: Record "Warehouse Setup";
        Rec_Transferline: Record "Transfer Line";
        Rec_WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        Rec_WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        Rec_Reservationentry: Record "Reservation Entry";
        ProgressWindow: Dialog;
        Text001: Label 'Deleting Transfer Orders ...  #1#######';
        TODelete: Boolean;
        CntTO: Integer;
        Rec_WarehouseShipmentLine: Record "Warehouse Shipment Line";
        Rec_WarehouseReceiptline: Record "Warehouse Receipt Line";
        ShipDelete: Boolean;
        RecDelete: Boolean;
}

