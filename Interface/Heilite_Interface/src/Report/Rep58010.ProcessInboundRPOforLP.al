report 58010 "Process Inbound RPO for LP"
{
    //BC Upgrade GUNREM01 Old ID- 50546
    // version HEI.01

    // HEI.01 CHG2129985 SAHAL01      14.04.2022
    //   # Created New Report: 50546 - Process Inbound RPO for LP
    //   # Added Code to create inbound data

    Caption = 'Process Inbound RPO for LP';
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Interface Entry Header VIP INT"; "Interface Entry Header VIP INT")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Descending) WHERE(Direction = CONST(Inbound), Status = CONST(Pending));
            dataitem("Interface Entry Line VIP INT"; "Interface Entry Line VIP INT")
            {
                DataItemLink = "Header Entry No." = FIELD("Entry No.");
                dataitem("Production Order"; "Production Order")
                {
                    DataItemLink = "No." = FIELD("Item Code");
                    DataItemTableView = WHERE(Status = CONST(Released), "Source Type" = CONST(Item));
                    dataitem("Prod. Order Line"; "Prod. Order Line")
                    {
                        DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("No.");
                        //  DataItemTableView = '';

                        trigger OnAfterGetRecord();
                        var
                            ItemL: Record Item;
                        begin
                            //HEI.01>>
                            TESTFIELD("Item No.", "Production Order"."Source No.");
                            TESTFIELD("Item No.", "Interface Entry Line VIP INT"."No.");
                            TESTFIELD("Remaining Quantity");
                            ItemL.GET("Item No.");
                            CreateAndPostProductionJournal("Prod. Order Line", "Interface Entry Line VIP INT");
                            //HEI.01<<
                        end;
                    }
                }
            }

            trigger OnPreDataItem();
            var
                ProdOrderL: Record "Production Order";
            begin
                //HEI.01>>
                if ProdOrderNo <> '' then begin
                    ProdOrderL.GET(ProdOrderL.Status::Released, ProdOrderNo);
                    SETRANGE("Source No.", ProdOrderNo);
                end else
                    ERROR(Text001, HdrEntryNo, TABLECAPTION);
                if HdrEntryNo <> 0 then
                    SETRANGE("Entry No.", HdrEntryNo)
                else
                    ERROR(Text002, ProdOrderNo, TABLECAPTION);
                SETRANGE("Interface Code", WMSInterfaceSetup."Prod. Order Output Interface");
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

    trigger OnInitReport();
    begin
        //HEI.01>>
        CLEARLASTERROR;
        CLEAR(ProdOrderNo);
        //HEI.01<<
    end;

    trigger OnPreReport();
    begin
        //HEI.01>>
        CompanyInformation.GET;
        if WMSInterfaceSetup.GET then;
        if not WMSInterfaceSetup."WMS Integration" then
            exit;
        if not WMSInterfaceSetup."Activate LogoPak Interface" then
            exit;
        WMSInterfaceSetup.TESTFIELD("Prod. Order Output Interface");
        WMSInterfaceSetup.TESTFIELD("Prod. Order Output Template");
        WMSInterfaceSetup.TESTFIELD("Prod. Order Output Batch");
        InterfaceSetup.GET(WMSInterfaceSetup."Prod. Order Output Interface");
        if not InterfaceSetup.Enabled then
            ERROR(Text000, InterfaceSetup.Code);
        ItemJournalTemplateL.GET(WMSInterfaceSetup."Prod. Order Output Template");
        ItemJournalBatchL.GET(WMSInterfaceSetup."Prod. Order Output Template", WMSInterfaceSetup."Prod. Order Output Batch");
        //HEI.01<<
    end;

    var
        CompanyInformation: Record "Company Information";
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        ItemJournalTemplateL: Record "Item Journal Template";
        ItemJournalBatchL: Record "Item Journal Batch";
        ProdOrderNo: Code[20];
        Text000: Label 'Interface %1 is not enabled.';
        Text001: Label 'Production Order does not exist for this Entry No. %1 in %2.';
        Text002: Label 'Entry No. does not exist for this Production Order %1 in %2.';
        Text003: Label 'EAN %1 is not found for this Item %2 in %3.';
        Text004: Label 'Please select the Bin Code.';
        Text005: Label '"There is nothing to create for Output Entry in Reservation. "';
        Text006: Label '"There is nothing to post for Output Prod. Journal. "';
        HdrEntryNo: Integer;

    procedure GetProdOrder(ProductionOrderNo: Code[20]);
    begin
        //HEI.01>>
        ProdOrderNo := ProductionOrderNo;
        //HEI.01<<
    end;

    procedure GetHeaderEntry(HeaderEntryNo: Integer);
    begin
        //HEI.01>>
        HdrEntryNo := HeaderEntryNo;
        //HEI.01<<
    end;

    procedure CreateAndPostProductionJournal(var ProdOrderLine: Record "Prod. Order Line"; InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT");
    var
        ProdOrderL: Record "Production Order";
        EANCodeL: Code[20];
        //  ItemCrossRefL: Record "Item Cross Reference"; //BC Upgrade GUNREM01
        ItemCrossRefL: Record "Item Reference"; //BC Upgrade GUNREM01

        ItemJnlLineL: Record "Item Journal Line";
        NewLineNoL: Integer;
        OutputJnlExplRouteL: Codeunit "Output Jnl.-Expl. Route";
        LotNoInfoL: Record "Lot No. Information";
    begin
        //HEI.01>>
        ProdOrderL.GET(ProdOrderLine.Status, ProdOrderLine."Prod. Order No.");
        InterfaceEntryLineVIP.TESTFIELD("Quantity (Full/Partial Pallet)");
        InterfaceEntryLineVIP.TESTFIELD(EAN);
        InterfaceEntryLineVIP.TESTFIELD("Batch No. (Lot No.)");
        InterfaceEntryLineVIP.TESTFIELD("Production Date");
        InterfaceEntryLineVIP.TESTFIELD("Best Before Date");
        EANCodeL := DELSTR(InterfaceEntryLineVIP.EAN, 1, 1);
        ItemCrossRefL.SETRANGE("Item No.", ProdOrderLine."Item No.");
        //  ItemCrossRefL.SETRANGE("Cross-Reference No.", EANCodeL);
        ItemCrossRefL.SETRANGE("Reference No.", EANCodeL);//BC Upgrade GUNREM01
        if ItemCrossRefL.ISEMPTY then
            ERROR(Text003, EANCodeL, ProdOrderLine."Item No.", ItemCrossRefL.TABLECAPTION);
        ProdOrderL."Prod. Order Output Interf INT" := WMSInterfaceSetup."Prod. Order Output Interface";
        ProdOrderL."Parked from LogoPak INT" := true;
        ProdOrderL.MODIFY(true);
        COMMIT;

        ItemJnlLineL.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Posting Date",
          "Entry Type", "Order Type", "Order No.", "Order Line No.", "Source Type", "Item No.");
        ItemJnlLineL.SETRANGE("Journal Template Name", WMSInterfaceSetup."Prod. Order Output Template");
        ItemJnlLineL.SETRANGE("Journal Batch Name", WMSInterfaceSetup."Prod. Order Output Batch");
        ItemJnlLineL.SETRANGE("Posting Date", InterfaceEntryLineVIP."Production Date");
        ItemJnlLineL.SETRANGE("Entry Type", ItemJnlLineL."Entry Type"::Output);
        ItemJnlLineL.SETRANGE("Order Type", ItemJnlLineL."Order Type"::Production);
        ItemJnlLineL.SETRANGE("Order No.", ProdOrderLine."Prod. Order No.");
        ItemJnlLineL.SETRANGE("Order Line No.", ProdOrderLine."Line No.");
        ItemJnlLineL.SETRANGE("Source Type", ItemJnlLineL."Source Type"::Item);
        ItemJnlLineL.SETRANGE("Item No.", ProdOrderLine."Item No.");
        if ItemJnlLineL.ISEMPTY then begin
            ItemJnlLineL.RESET;
            ItemJnlLineL.LOCKTABLE;
            ItemJnlLineL.SETRANGE("Journal Template Name", WMSInterfaceSetup."Prod. Order Output Template");
            ItemJnlLineL.SETRANGE("Journal Batch Name", WMSInterfaceSetup."Prod. Order Output Batch");
            if ItemJnlLineL.FINDLAST then
                NewLineNoL := ItemJnlLineL."Line No." + 10000
            else
                NewLineNoL := 10000;
            ItemJnlLineL.INIT;
            ItemJnlLineL."Journal Template Name" := WMSInterfaceSetup."Prod. Order Output Template";
            ItemJnlLineL."Journal Batch Name" := WMSInterfaceSetup."Prod. Order Output Batch";
            ItemJnlLineL."Line No." := NewLineNoL;
            ItemJnlLineL.VALIDATE("Posting Date", InterfaceEntryLineVIP."Production Date");
            ItemJnlLineL.VALIDATE("Entry Type", ItemJnlLineL."Entry Type"::Output);
            ItemJnlLineL.VALIDATE("Order Type", ItemJnlLineL."Order Type"::Production);
            ItemJnlLineL.VALIDATE("Order No.", ProdOrderLine."Prod. Order No.");
            ItemJnlLineL.VALIDATE("Order Line No.", ProdOrderLine."Line No.");
            ItemJnlLineL.VALIDATE("Source Code", ItemJournalTemplateL."Source Code");
            ItemJnlLineL.VALIDATE("Source Type", ItemJnlLineL."Source Type"::Item);
            ItemJnlLineL.VALIDATE("Item No.", ProdOrderLine."Item No.");
            ItemJnlLineL.INSERT;
            OutputJnlExplRouteL.RUN(ItemJnlLineL);
        end;

        ItemJnlLineL.RESET;
        ItemJnlLineL.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Posting Date",
          "Entry Type", "Order Type", "Order No.", "Order Line No.", "Source Type", "Item No.");
        ItemJnlLineL.SETRANGE("Journal Template Name", WMSInterfaceSetup."Prod. Order Output Template");
        ItemJnlLineL.SETRANGE("Journal Batch Name", WMSInterfaceSetup."Prod. Order Output Batch");
        ItemJnlLineL.SETRANGE("Posting Date", InterfaceEntryLineVIP."Production Date");
        ItemJnlLineL.SETRANGE("Entry Type", ItemJnlLineL."Entry Type"::Output);
        ItemJnlLineL.SETRANGE("Order Type", ItemJnlLineL."Order Type"::Production);
        ItemJnlLineL.SETRANGE("Order No.", ProdOrderLine."Prod. Order No.");
        ItemJnlLineL.SETRANGE("Order Line No.", ProdOrderLine."Line No.");
        ItemJnlLineL.SETRANGE("Source Type", ItemJnlLineL."Source Type"::Item);
        ItemJnlLineL.SETRANGE("Item No.", ProdOrderLine."Item No.");
        if ItemJnlLineL.FINDFIRST then begin
            ItemJnlLineL.VALIDATE("Item No.");
            //    ItemJnlLineL.VALIDATE("Cross-Reference No.", EANCodeL);
            ItemCrossRefL.SETRANGE("Reference No.", EANCodeL); //BC Upgrade GUNREM01 replaced with "Cross-Reference No."

            ItemJnlLineL.VALIDATE("Output Quantity", InterfaceEntryLineVIP."Quantity (Full/Partial Pallet)");
            ItemJnlLineL.MODIFY;
            ClearReservationEntriesForPO(ItemJnlLineL, InterfaceEntryLineVIP."Batch No. (Lot No.)");
            CreateReservationEntriesForPO(ItemJnlLineL, InterfaceEntryLineVIP."Batch No. (Lot No.)");
            ItemJnlLineL.VALIDATE("Lot No.", InterfaceEntryLineVIP."Batch No. (Lot No.)");
            //BC Upgrade GUNREM01 -Dependency with DIT >>
            // if LotNoInfoL.GET(ItemJnlLineL."Item No.", ItemJnlLineL."Variant Code", ItemJnlLineL."Lot No.") then begin
            //     if LotNoInfoL."Expiration Date" = 0D then begin
            //         LotNoInfoL.VALIDATE("Expiration Date", InterfaceEntryLineVIP."Best Before Date");
            //         LotNoInfoL.MODIFY;
            //     end;
            //     ItemJnlLineL.VALIDATE("Expiration Date", LotNoInfoL."Expiration Date");
            //     ItemJnlLineL.VALIDATE("Item Expiration Date", LotNoInfoL."Expiration Date");
            // end;
            //BC Upgrade GUNREM01 -Dependency with DIT >>
            ItemJnlLineL.MODIFY(true);
            TrySetApplyToEntries(ItemJnlLineL);
            ItemJnlLineL.PostingItemJnlFromProduction(false);
            CLEAR(ProdOrderL);
            ProdOrderL.GET(ProdOrderLine.Status, ProdOrderLine."Prod. Order No.");
            ProdOrderL."Posted from LogoPak INT" := true;
            ProdOrderL.MODIFY(true);
        end else
            ERROR(Text006);
        //HEI.01<<
    end;

    procedure TrySetApplyToEntries(var ItemJournalLine: Record "Item Journal Line");
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ReservationEntry: Record "Reservation Entry";
    begin
        //HEI.01>>
        if FindReservationsReverseOutput(ReservationEntry, ItemJournalLine) then
            repeat
                if FindILEFromReservation(ItemLedgerEntry, ItemJournalLine, ReservationEntry, ItemJournalLine."Order No.") then begin
                    ReservationEntry.VALIDATE("Appl.-to Item Entry", ItemLedgerEntry."Entry No.");
                    ReservationEntry.MODIFY(true);
                end;
            until ReservationEntry.NEXT = 0;
        //HEI.01<<
    end;

    local procedure FindReservationsReverseOutput(var ReservationEntry: Record "Reservation Entry"; ItemJnlLine: Record "Item Journal Line"): Boolean;
    begin
        //HEI.01>>
        if ItemJnlLine.Quantity >= 0 then
            exit(false);

        ReservationEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
        ReservationEntry.SETRANGE("Source ID", ItemJnlLine."Journal Template Name");
        ReservationEntry.SETRANGE("Source Ref. No.", ItemJnlLine."Line No.");
        ReservationEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservationEntry.SETRANGE("Source Subtype", ItemJnlLine."Entry Type");
        ReservationEntry.SETRANGE("Source Batch Name", ItemJnlLine."Journal Batch Name");
        ReservationEntry.SETFILTER("Serial No.", '<>%1', '');
        ReservationEntry.SETRANGE("Qty. to Handle (Base)", -1);
        ReservationEntry.SETRANGE("Appl.-to Item Entry", 0);
        exit(ReservationEntry.FINDSET(false));
        //HEI.01<<
    end;

    local procedure FindILEFromReservation(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJnlLine: Record "Item Journal Line"; ReservationEntry: Record "Reservation Entry"; ProductionOrderNo: Code[20]): Boolean;
    begin
        //HEI.01>>
        ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Lot No.", "Serial No.", "Document No.");
        ItemLedgerEntry.SETRANGE("Item No.", ItemJnlLine."Item No.");
        ItemLedgerEntry.SETRANGE(Open, true);
        ItemLedgerEntry.SETRANGE("Variant Code", ItemJnlLine."Variant Code");
        ItemLedgerEntry.SETRANGE(Positive, true);
        ItemLedgerEntry.SETRANGE("Location Code", ItemJnlLine."Location Code");
        ItemLedgerEntry.SETRANGE("Lot No.", ReservationEntry."Lot No.");
        ItemLedgerEntry.SETRANGE("Serial No.", ReservationEntry."Serial No.");
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);
        exit(ItemLedgerEntry.FINDSET(false));
        //HEI.01<<
    end;

    procedure ClearReservationEntriesForPO(var ItemJournalLine: Record "Item Journal Line"; var LotNo: Code[20]);
    var
        ReservationEntryL: Record "Reservation Entry";
        ReservEntryNoL: Integer;
        ItemJournalLineL: Record "Item Journal Line";
    begin
        //HEI.01>>
        if ItemJournalLineL.GET(ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name", ItemJournalLine."Line No.") then begin
            // ReservationEntryL.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.",
            //   "Reservation Status", Positive, "Item No.", "Qty. per Unit of Measure", "Location Code", "Zone Code", "Bin Code", "Lot No.", "Item Tracking"); //BC Upgrade GUNREM01 -"Bin code" DIT field
            ReservationEntryL.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.",
            "Reservation Status", Positive, "Item No.", "Qty. per Unit of Measure", "Location Code", "Zone Code FND", "Lot No.", "Item Tracking");  //BC Upgrade GUNREM01 -"Bin code" removed
            ReservationEntryL.SETRANGE("Source Type", DATABASE::"Item Journal Line");
            ReservationEntryL.SETRANGE("Source Subtype", ItemJournalLineL."Entry Type");
            ReservationEntryL.SETRANGE("Source ID", ItemJournalLineL."Journal Template Name");
            ReservationEntryL.SETRANGE("Source Batch Name", ItemJournalLineL."Journal Batch Name");
            ReservationEntryL.SETRANGE("Source Prod. Order Line", 0);
            ReservationEntryL.SETRANGE("Source Ref. No.", ItemJournalLineL."Line No.");
            ReservationEntryL.SETRANGE("Reservation Status", ReservationEntryL."Reservation Status"::Prospect);
            ReservationEntryL.SETRANGE(Positive, false);
            ReservationEntryL.SETRANGE("Item No.", ItemJournalLineL."Item No.");
            ReservationEntryL.SETRANGE("Qty. per Unit of Measure", ItemJournalLineL."Qty. per Unit of Measure");
            ReservationEntryL.SETRANGE("Location Code", ItemJournalLineL."Location Code");
            ReservationEntryL.SETRANGE("Zone Code FND", ItemJournalLineL."Zone Code FND");
            //  ReservationEntryL.SETRANGE("Bin Code", ItemJournalLineL."Bin Code"); //BC Upgrade GUNREM01 -DIT Field
            ReservationEntryL.SETRANGE("Lot No.", LotNo);
            ReservationEntryL.SETRANGE("Item Tracking", ReservationEntryL."Item Tracking"::"Lot No.");
            ReservationEntryL.DELETEALL(true);
        end;
        //HEI.01<<
    end;

    procedure CreateReservationEntriesForPO(var ItemJournalLine: Record "Item Journal Line"; var LotNo: Code[20]);
    var
        CreateReservationEntryL: Record "Reservation Entry";
        ReservEntryNoL: Integer;
        ItemJournalLineL: Record "Item Journal Line";
    begin
        //HEI.01>>
        if ItemJournalLineL.GET(ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name", ItemJournalLine."Line No.") then begin
            CreateReservationEntryL.LOCKTABLE;
            if CreateReservationEntryL.FINDLAST then
                ReservEntryNoL := CreateReservationEntryL."Entry No." + 1
            else
                ReservEntryNoL := 1;
            CreateReservationEntryL.INIT;
            CreateReservationEntryL."Entry No." := ReservEntryNoL;
            CreateReservationEntryL.Positive := false;
            CreateReservationEntryL.VALIDATE("Item No.", ItemJournalLineL."Item No.");
            CreateReservationEntryL.VALIDATE("Location Code", ItemJournalLineL."Location Code");
            CreateReservationEntryL.Description := ItemJournalLineL.Description;
            //  CreateReservationEntryL."Zone Code" := ItemJournalLineL."Zone Code";
            //  CreateReservationEntryL."Bin Code" := ItemJournalLineL."Bin Code"; //BC Upgrade GUNREM01 -DIT Field
            if (ItemJournalLineL."Entry Type" = ItemJournalLineL."Entry Type"::Output) and (ItemJournalLineL."Location Code" <> '') then
                if ItemJournalLineL."Bin Code" = '' then
                    ERROR(Text004);
            CreateReservationEntryL.VALIDATE("Lot No.", LotNo);
            CreateReservationEntryL."Expiration Date" := ItemJournalLineL."Expiration Date";
            CreateReservationEntryL."Qty. per Unit of Measure" := ItemJournalLineL."Qty. per Unit of Measure";
            CreateReservationEntryL.VALIDATE("Quantity (Base)", ItemJournalLineL."Quantity (Base)");
            CreateReservationEntryL."Reservation Status" := CreateReservationEntryL."Reservation Status"::Prospect;
            CreateReservationEntryL."Source Type" := DATABASE::"Item Journal Line";
            CreateReservationEntryL."Source Subtype" := ItemJournalLineL."Entry Type".AsInteger();
            CreateReservationEntryL."Source ID" := ItemJournalLineL."Journal Template Name";
            CreateReservationEntryL."Source Batch Name" := ItemJournalLineL."Journal Batch Name";
            CreateReservationEntryL."Source Prod. Order Line" := 0;
            CreateReservationEntryL."Source Ref. No." := ItemJournalLineL."Line No.";
            CreateReservationEntryL."Item Tracking" := CreateReservationEntryL."Item Tracking"::"Lot No.";
            CreateReservationEntryL."Shipment Date" := ItemJournalLineL."Posting Date";
            CreateReservationEntryL."Created By" := USERID;
            CreateReservationEntryL."Creation Date" := TODAY;
            CreateReservationEntryL.INSERT(true);
        end else
            ERROR(Text005);
        //HEI.01<<
    end;
}

