report 51074 "WH Zone Movements Recon CBN"
{
    // version HEI.01

    // HEI.01 CHG2069354 IBM.AK 14.10.20
    // # Warehouse Movements reconcilliation report (NEW)

    //FDD-GAP001_DTW # Inventory UOM IBM PATHAA02-07.04.26

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\WH Zone Movements Recon.rdl';

    Caption = 'WH Zone Movements Recon';
    ApplicationArea = All;

    dataset
    {
        dataitem("Warehouse Entry"; "Warehouse Entry")
        {
            DataItemTableView = sorting("Entry No.") ORDER(Ascending) where("Entry Type" = FILTER(Movement), "Source Document" = FILTER(''), "Source No." = FILTER(<> ''));
            RequestFilterFields = "Registering Date", "Location Code", "Item Category Code FND", "Item No.";
            column(LocationFilter; 'Location Code : ' + GETFILTER("Warehouse Entry"."Location Code"))
            {
            }
            column(RegDateFilter; 'Registering Date : ' + GETFILTER("Warehouse Entry"."Registering Date"))
            {
            }
            column(ItemCatFilter; 'Item Cat. Code : ' + GETFILTER("Warehouse Entry"."Item Category Code FND"))
            {
            }
            column(ItemNoFilter; 'Item No. : ' + GETFILTER("Warehouse Entry"."Item No."))
            {
            }
            column(CompanyName; compInfo.Name)
            {
            }
            column(PageNo; CurrReport.PAGENO())
            {
            }
            column(ShipRegDate; ShipRegDate)
            {
            }
            column(ReceiptRegDate; ReceiptRegDate)
            {
            }
            column(ItemNo_WarehouseEntry; "Item No.")
            {
                IncludeCaption = true;
            }
            column(ItemDescription; ItemDescription)
            {
            }
            column(SourceNo_WarehouseEntry; "Warehouse Entry"."Source No.")
            {
            }
            column(LocCode_WarehouseEntry; "Warehouse Entry"."Location Code")
            {
            }
            column(WhseDocNo_WarehouseEntry; "Whse. Document No.")
            {
                IncludeCaption = true;
            }
            column(RegDate_WarehouseEntry; FORMAT("Registering Date"))
            {
            }
            column(ZoneCode_WarehouseEntry; "Zone Code")
            {
                IncludeCaption = true;
            }
            column(BinCode_WarehouseEntry; "Bin Code")
            {
                IncludeCaption = true;
            }
            column(UOMCode_WarehouseEntry; "Unit of Measure Code")
            {
                IncludeCaption = true;
            }
            column(Quantity_WarehouseEntry; Quantity)
            {
                IncludeCaption = true;
            }
            column(LotNo_WarehouseEntry; "Lot No.")
            {
                IncludeCaption = true;
            }
            column(SerialNo_WarehouseEntry; "Serial No.")
            {
                IncludeCaption = true;
            }
            column(UserID_WarehouseEntry; "Warehouse Entry"."User ID")
            {
            }
            column(EntryNo_WarehouseEntry; "Entry No.")
            {
                IncludeCaption = true;
            }
            column(InvUOM; InvUOM)
            {
            }
            column(QtyInvUOM; QtyInvUOM)
            {
            }
            column(LotSerialNo; LotSerialNo)
            {
            }

            trigger OnAfterGetRecord();
            var
                WarehouseEntry1: Record "Warehouse Entry";
                WarehouseEntry2: Record "Warehouse Entry";
            begin

                compInfo.GET();
                ShipRegDate := 0D;
                ReceiptRegDate := 0D;
                CLEAR(QtyInvUOM);
                CLEAR(InvUOM);
                CLEAR(LotSerialNo);


                if Item.GET("Item No.") then begin
                    ItemDescription := Item.Description;
                    InvUOM := Item."Inventory Unit of Measure FND"; // BC Upgrade SHUKLP03 << DrinkIT field is blocked. //PATHAA02-uncommented to flow Inv UOM to report
                    if RecItemUoM.GET("Item No.", InvUOM) then
                        QtyInvUOM := ABS("Warehouse Entry".Quantity / RecItemUoM."Qty. per Unit of Measure");
                end;

                WarehouseEntry1.RESET();
                WarehouseEntry1.SETRANGE(WarehouseEntry1."Entry Type", WarehouseEntry1."Entry Type"::Movement);
                WarehouseEntry1.SETRANGE(WarehouseEntry1."Item No.", "Warehouse Entry"."Item No.");
                WarehouseEntry1.SETRANGE(WarehouseEntry1."Source No.", "Warehouse Entry"."Source No.");
                WarehouseEntry1.SETRANGE(WarehouseEntry1."Whse. Document Type", "Warehouse Entry"."Whse. Document Type"::Shipment);
                if WarehouseEntry1.FINDFIRST() then
                    ShipRegDate := WarehouseEntry1."Registering Date";

                WarehouseEntry2.RESET();
                WarehouseEntry2.SETRANGE(WarehouseEntry2."Entry Type", WarehouseEntry1."Entry Type"::Movement);
                WarehouseEntry2.SETRANGE(WarehouseEntry2."Item No.", "Warehouse Entry"."Item No.");
                WarehouseEntry2.SETRANGE(WarehouseEntry2."Source No.", "Warehouse Entry"."Source No.");
                WarehouseEntry2.SETRANGE(WarehouseEntry2."Whse. Document Type", "Warehouse Entry"."Whse. Document Type"::Receipt);
                if WarehouseEntry2.FINDFIRST() then
                    ReceiptRegDate := WarehouseEntry2."Registering Date";

                if "Warehouse Entry"."Lot No." <> '' then
                    LotSerialNo := "Warehouse Entry"."Lot No."
                else
                    LotSerialNo := "Warehouse Entry"."Serial No.";
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        ReportNameLbl = 'WH Zone Movements Reconciliation';
    }

    var
        compInfo: Record "Company Information";
        Item: Record Item;
        RecItemUoM: Record "Item Unit of Measure";
        redfont: Boolean;
        InvUOM: Code[10];
        LotSerialNo: Code[20];
        ReceiptRegDate: Date;
        ShipRegDate: Date;
        QtyInvUOM: Decimal;
        Text001: Label 'WH Recon';
        WhseRegFilter: Text;
        ItemDescription: Text[50];
        CurrReportPageNoCaptionLbl: TextConst ENU = 'Page', FRA = 'Page';
        ItemDescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Description';
        WarehouseEntryRegisteringDateCaptionLbl: TextConst ENU = 'Registering Date', FRA = 'Date enregistrement';
        WarehouseRegisterNoCaptionLbl: TextConst ENU = 'Register No.', FRA = 'N° hist. transaction';
}

