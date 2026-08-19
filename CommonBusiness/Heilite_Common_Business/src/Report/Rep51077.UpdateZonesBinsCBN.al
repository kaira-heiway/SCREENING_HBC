report 51077 "Update Zones/Bins CBN"
{
    // HEI.01 HT1615 BULIMC01 IBM 18.09.2020 #new report to update the Zone Code from ILE and VE

    Caption = 'Update Zone/Bin in Value Entries and Item Ledger Entries';
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = sorting("Document No.", "Posting Date") ORDER(Ascending);

            trigger OnAfterGetRecord();
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
            begin
                ItemLedgerEntry.RESET();
                if ItemLedgerEntry.GET("Item Ledger Entry No.") then begin
                    "Zone Code FND" := UpdateZoneCode(ItemLedgerEntry."Posting Date", ItemLedgerEntry."Document No.", ItemLedgerEntry."Item No.", ItemLedgerEntry.Quantity);
                    "Bin Code FND" := UpdateBinCode(ItemLedgerEntry."Posting Date", ItemLedgerEntry."Document No.", ItemLedgerEntry."Item No.", ItemLedgerEntry.Quantity);
                end else begin
                    "Zone Code FND" := UpdateZoneCode("Posting Date", "Document No.", "Item No.", "Item Ledger Entry Quantity");
                    "Bin Code FND" := UpdateBinCode("Posting Date", "Document No.", "Item No.", "Item Ledger Entry Quantity");
                end;
                MODIFY();

                Counter += 1;
                if Counter >= NoOfRecProgress
                then begin
                    NoOfProgresed := NoOfProgresed + Counter;
                    DialogWindow.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                    Counter := 0;
                    TimeProgress := TIME;
                end;
            end;

            trigger OnPostDataItem();
            begin
                if UpdatedZone and UpdatedBin then
                    MESSAGE(Text003, "Value Entry".TABLECAPTION)
                else
                    MESSAGE(Text004, "Value Entry".TABLECAPTION);
            end;

            trigger OnPreDataItem();
            begin
                NoOfRecords := COUNT;
                NoOfRecProgress := NoOfRecords div 100;
                Counter := 0;
                NoOfProgresed := 0;
                TimeProgress := TIME;
            end;
        }
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Document No.", "Posting Date") ORDER(Ascending);

            trigger OnAfterGetRecord();
            begin
                "Zone Code FND" := UpdateZoneCode("Posting Date", "Document No.", "Item No.", Quantity);
                //"Bin Code" := UpdateBinCode("Posting Date","Document No.","Item No.",Quantity);  // BC Upgrade kamnay01>> DITW field 
                MODIFY();

                Counter2 += 1;
                if Counter2 >= NoOfRecProgress2
                then begin
                    NoOfProgresed2 := NoOfProgresed2 + Counter2;
                    DialogWindow.UPDATE(2, ROUND(NoOfProgresed2 / NoOfRecords2 * 10000, 1));
                    Counter2 := 0;
                    TimeProgress2 := TIME;
                end;
            end;

            trigger OnPostDataItem();
            begin
                if UpdatedZone and UpdatedBin then
                    MESSAGE(Text003, "Item Ledger Entry".TABLECAPTION)
                else
                    MESSAGE(Text004, "Item Ledger Entry".TABLECAPTION);
            end;

            trigger OnPreDataItem();
            begin
                NoOfRecords2 := COUNT;
                NoOfRecProgress2 := NoOfRecords2 div 100;
                Counter2 := 0;
                NoOfProgresed2 := 0;
                TimeProgress2 := TIME;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        DialogWindow.OPEN(Text001 + Text002);
    end;

    var
        WarehouseEntry: Record "Warehouse Entry";
        UpdatedBin: Boolean;
        UpdatedZone: Boolean;
        DialogWindow: Dialog;
        Counter: Integer;
        Counter2: Integer;
        NoOfProgresed: Integer;
        NoOfProgresed2: Integer;
        NoOfRecords: Integer;
        NoOfRecords2: Integer;
        NoOfRecProgress: Integer;
        NoOfRecProgress2: Integer;
        Text001: Label 'Updating Value Entries...@1@@@@@@@@@@@@\';
        Text002: Label 'Updating Item Ledger Entries...@2@@@@@@@@@@@@\';
        Text003: Label 'Zone/Bin Codes have been successfully updated in %1.';
        Text004: Label 'No Zone/Bin Code updated in %1.';
        TimeProgress: Time;
        TimeProgress2: Time;

    local procedure UpdateZoneCode(PostingDate: Date; DocNo: Code[20]; ItemNo: Code[20]; Qty: Decimal) ZoneCode: Code[20];
    begin
        WarehouseEntry.RESET();
        WarehouseEntry.SETCURRENTKEY("Reference No.", "Registering Date");
        WarehouseEntry.SETRANGE("Reference No.", DocNo);
        WarehouseEntry.SETRANGE("Registering Date", PostingDate);
        WarehouseEntry.SETRANGE("Item No.", ItemNo);
        WarehouseEntry.SETRANGE(Quantity, Qty);
        if WarehouseEntry.FINDFIRST() then begin
            ZoneCode := WarehouseEntry."Zone Code";
            UpdatedZone := true;
            exit(ZoneCode);
        end;
    end;

    local procedure UpdateBinCode(PostingDate: Date; DocNo: Code[20]; ItemNo: Code[20]; Qty: Decimal) BinCode: Code[20];
    begin
        WarehouseEntry.RESET();
        WarehouseEntry.SETCURRENTKEY("Reference No.", "Registering Date");
        WarehouseEntry.SETRANGE("Reference No.", DocNo);
        WarehouseEntry.SETRANGE("Registering Date", PostingDate);
        WarehouseEntry.SETRANGE("Item No.", ItemNo);
        WarehouseEntry.SETRANGE(Quantity, Qty);
        if WarehouseEntry.FINDFIRST() then begin
            BinCode := WarehouseEntry."Bin Code";
            UpdatedBin := true;
            exit(BinCode);
        end;
    end;
}

