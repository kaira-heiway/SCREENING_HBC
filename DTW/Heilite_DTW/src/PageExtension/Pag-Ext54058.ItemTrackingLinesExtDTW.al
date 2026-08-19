namespace BC_DTWLocal.BC_DTWLocal;

using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Transfer;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Activity;

pageextension 54058 ItemTrackingLinesExt_DTW extends "Item Tracking Lines"
{//BC Upgrade Kamnay01  Created this page extension to add the field & code for "Your Reference" in item tracking lines page. This field is required for FDD-DTW 006
    layout
    {
        addafter(Description)
        {
            field("Your Reference"; Rec."Your Reference FND")
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    ReservEntry: Record "Reservation Entry";
                begin
                    //SaveToReservationEntry(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        ItemJnlLine: Record "Item Journal Line";
        WhseActivityLine: Record "Warehouse Activity Line";
        WhseShipmentLine: Record "Warehouse Shipment Line";
        TransferLine: Record "Transfer Line";
    begin
        if Rec."Source Type" = Database::"Item Journal Line" then begin // BC Upgrade SHUKLP03 <<

            if ItemJnlLine.Get(Rec."Source ID", Rec."Source Batch Name", Rec."Source Ref. No.")
            then begin

                if Rec."Your Reference FND" = '' then
                    Rec."Your Reference FND" := ItemJnlLine."Your Reference FND";
                //BC Upgrade Kamnay01 >> BugFix 
                if Rec."Reference No. FND" = '' then
                    Rec."Reference No. FND" := ItemJnlLine."Order No.";
                //BC Upgrade Kamnay01 >> BugFix 
            end;
        end;  // BC Upgrade SHUKLP03 <<
        //BC Upgrade GUNREM01 >> BugFix 04.06.26

        if Rec."Source Type" = Database::"Item Journal Line" then begin
            if ItemJnlLine.Get(
                Rec."Source ID",
                Rec."Source Batch Name",
                Rec."Source Ref. No.")
            then
                Rec."Bin Code" := ItemJnlLine."Bin Code";
        end;

        if Rec."Source Type" = Database::"Warehouse Activity Line" then begin
            WhseActivityLine.SetRange("Activity Type", Rec."Source Subtype");
            WhseActivityLine.SetRange("No.", Rec."Source ID");
            WhseActivityLine.SetRange("Line No.", Rec."Source Ref. No.");

            if WhseActivityLine.FindFirst() then
                Rec."Bin Code" := WhseActivityLine."Bin Code";
        end;

        if Rec."Source Type" = Database::"Transfer Line" then begin
            if TransferLine.Get(
                Rec."Source ID",
                Rec."Source Ref. No.")
            then begin
                if Rec."Bin Code" = '' then
                    Rec."Bin Code" := TransferLine."Transfer-from Bin Code";
            end;
        end;

        //BC Upgrade GUNREM01 << BugFix 04.06.26

    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ItemJnlLine: Record "Item Journal Line";
    begin
        if Rec."Source Type" = Database::"Item Journal Line" then begin // BC Upgrade SHUKLP03 <<

            if ItemJnlLine.Get(Rec."Source ID", Rec."Source Batch Name", Rec."Source Ref. No.")
            then begin

                if Rec."Your Reference FND" <> '' then begin
                    ItemJnlLine.Validate("Your Reference FND", Rec."Your Reference FND");
                    ItemJnlLine.Modify(true);
                end;
            end;

            exit(true);
        end;  // BC Upgrade SHUKLP03 <<
    END;
}



