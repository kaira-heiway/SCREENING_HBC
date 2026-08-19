codeunit 54001 "Undo Transfer Shipment Line"
{
    // version HEI.03
    //BC Upgrade Kamnay01 Original(Heilite) CU id 50080
    //   HEI.01 FDD-GAPLOG015 IBM NASTAA02 12.05.2018 # Undo Transfer Shipment
    //   # New codeunit created to undo a Transfer Shipment Line
    //   # Codeunit migrated from HEI2.0
    //   # For Item Journal Line used "Unit of Measure Code" instead of "Unit of Measure"
    // 
    //   HEI.02 INC4606391/CHG2199717 IBM PRASAA03 05.04.2023 LOT N°REQUIERED AT  TO WR LEVEL
    //   # Added DeleteReservationEntries function to delete the reservation entry
    // HEI.03 CHG2260099 COSTES04 26.11.2024 Automatic Archiving of Gate Entry Outbound While Undoing Sales Shipment.
    //   # New field added Gate Entry Archived
    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Fields and related code("Is Item Charge","Item Charge Incl. Price","Item DTax Group Code","Item Charge Type","Item Charge Quantity per","Due Tax","Unit Volume HL","New Unit Volume HL","Duty Suspended","Duty Suspended","Tax Formula","Tariff No.","Tax Item No.",Cubage,Weight,"No. of Packages")
    // 2. Remove Drink-IT Tables in permissions property(2035045,2035047)
    // BC Upgrade BHARDA11 <<

    // BC Upgrade MISHRS14 >>
    // Blocked with statement as its deprected and prefixed variable with- TransferShptLine in Procedure-"Code" due to warning
    // Blocked with statement and prefixed variable with TransferShptLine in Procedure- PostItemJnLine
    // Added -As.Integer due to warning of implicit type conversion in Procedure- PostItemJnLine
    // Blocked with statement and prefixed variable with OldTransferShptLine in Procedure- InsertNewShipmentLine
    // Blocked with statement and prefixed variable with TransferLine in Procedure- UpdateTransferOrderLine
    // Blocked with statement and prefixed variable with ReserveEntry in Procedure- InsertItemTracking
    // BC Upgrade MISHRS14 <<


    Permissions = TableData "Sales Line" = imd,
                  TableData "Sales Shipment Line" = imd,
                  TableData "Item Application Entry" = rmd,
                  TableData "Reservation Worksheet Log" = imd,
                  TableData "Item Entry Relation" = ri,
                  TableData "Whse. Item Entry Relation" = rimd;
    // BC Upgrade BHARDA11 >> ----Drink-IT Table(2035045,2035047)
    // TableData 2035045 = ri, 
    // TableData 2035047 = rimd;
    // BC Upgrade BHARDA11 << ----Drink-IT Table(2035045,2035047)
    TableNo = "Transfer Shipment Line";

    trigger OnRun();
    var
        UpdateItemAnalysisView: Codeunit "Update Item Analysis View";
        Rec2: Record "Transfer Shipment Line";
        Rec3: Record "Transfer Shipment Line";
    begin
        IF NOT HideDialog THEN
            IF NOT CONFIRM(Text000) THEN
                EXIT;
        TransferShptLine.COPY(Rec);

        IF TransferShptLine.FINDSET() THEN BEGIN
            REPEAT
                TransferShptLine.MARK(TRUE);
                IF TransferShptLine.Quantity <= 0 THEN
                    ERROR(Text007);
                IF TransferOrderLine.GET(TransferShptLine."Transfer Order No.", TransferShptLine."Line No.") THEN BEGIN
                    IF TransferOrderLine."Quantity Received" <> 0 THEN
                        ERROR(Text005);
                    IF TransferOrderLine."Quantity Shipped" = 0 THEN
                        ERROR(Text008, TransferShptLine."Line No.");
                END;
            UNTIL TransferShptLine.NEXT() = 0;
            Code();
        END;
    end;

    var
        ItemJnlLine: Record "Item Journal Line";
        TransferShptLine: Record "Transfer Shipment Line";
        LastTransferShptLine: Record "Transfer Shipment Line";
        TransferOrderLine: Record "Transfer Line";
        TempWhseJnlLine: Record "Warehouse Journal Line" temporary;
        InvtSetup: Record "Inventory Setup";
        UndoPostingMgt: Codeunit "Undo Posting Management";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        Text000: TextConst ENU = 'Do you really want to undo the selected Transfer Shipment lines?', FRA = 'Souhaitez-vous vraiment supprimer les lignes expédition sélectionnées ?';
        Text001: TextConst ENU = 'Undo quantity posting...', FRA = 'Annulation de la validation de la quantité...';
        Text002: TextConst ENU = 'There is not enough space to insert correction lines.', FRA = 'Il n''y a pas suffisamment d''espace pour insérer les lignes correction.';
        WhseUndoQty: Codeunit "Whse. Undo Quantity";
        InvtAdjmt: Codeunit "Inventory Adjustment";
        ResJnlPostLine: Codeunit "Res. Jnl.-Post Line";
        WhseJnlRegisterLine: Codeunit "Whse. Jnl.-Register Line";
        HideDialog: Boolean;
        Text003: TextConst ENU = 'Checking lines...', FRA = 'Vérification des lignes...';
        NextLineNo: Integer;
        Text005: TextConst ENU = 'This transfer shipment has already been received. Undo Transfer Shipment can be applied only to posted, but not received transfer shipments.', FRA = 'Cette expédition a déjà été facturée. Vous ne pouvez appliquer l''option Annuler expédition qu''aux expéditions enregistrées mais non facturées.';
        Text006: TextConst ENU = 'Undo Transfer Shipment can be performed only for lines of type Item. Please select a line of the Item type and repeat the procedure.', FRA = 'Vous ne pouvez appliquer l''option Annuler expédition qu''aux lignes de type Article. Sélectionnez une ligne de ce type et répétez la procédure.';
        Text007: Label 'Undo Transfer Shipment can be performed only for lines with a positive quantity. Please select a line with a positive quantity and repeat the procedure.';
        Text008: Label 'Line %1 already has been cancelled';
        Text059: TextConst Comment = '%1 = SalesShipmentLine."Document No.". %2 = SalesShipmentLine.FIELDCAPTION("Line No."). %3 = SalesShipmentLine."Line No.". This is used in a progress window.', ENU = '%1 %2 %3', FRA = '%1 %2 %3';
        SalesSetup: Record "Sales & Receivables Setup";
        TransferShptHeader: Record "Transfer Shipment Header";
        GLSetup: Record "General Ledger Setup";
        SalesSetupRead: Boolean;

    procedure SetHideDialog(NewHideDialog: Boolean);
    begin
        HideDialog := NewHideDialog;
    end;

    local procedure "Code"();
    var
        PostedWhseShptLine: Record "Posted Whse. Shipment Line";
        SalesLine: Record "Sales Line";
        ServItem: Record "Service Item";
        Window: Dialog;
        ItemShptEntryNo: Integer;
        DocLineNo: Integer;
        DeleteServItems: Boolean;
        PostedWhseShptLineFound: Boolean;
        TransferShipmentHeader: Record "Transfer Shipment Header";
        GateEntryHeader: Record "Gate Entry Header FND";
    begin
        // BC Upgrade MISHRS14 >>
        // Blocked with statement as its deprected and prefixed variable with- TransferShptLine
        //WITH TransferShptLine DO BEGIN
        //     CLEAR(ItemJnlPostLine);
        //     TransferShptLine.MARKEDONLY(TRUE);
        //     FIND('-');
        //     REPEAT
        //         PostedWhseShptLineFound :=
        //           WhseUndoQty.FindPostedWhseShptLine(
        //             PostedWhseShptLine,
        //             DATABASE::"Transfer Shipment Line",
        //             "Document No.",
        //             DATABASE::"Transfer Line",
        //             0,
        //             "Transfer Order No.",
        //             "Line No.");

        //WITH TransferShptLine DO BEGIN
        CLEAR(ItemJnlPostLine);
        TransferShptLine.MARKEDONLY(TRUE);
        TransferShptLine.FIND('-');
        REPEAT
            PostedWhseShptLineFound :=
              WhseUndoQty.FindPostedWhseShptLine(
                PostedWhseShptLine,
                DATABASE::"Transfer Shipment Line",
                TransferShptLine."Document No.",
                DATABASE::"Transfer Line",
                0,
                TransferShptLine."Transfer Order No.",
                TransferShptLine."Line No.");

            LastTransferShptLine.SETRANGE("Document No.", TransferShptLine."Document No.");
            IF LastTransferShptLine.FINDLAST() THEN
                DocLineNo := LastTransferShptLine."Line No." + 10000;

            PostItemJnlLine(TransferShptLine, DocLineNo);

            DeleteItemEntryRelation();
            //HEI.02>>
            //To delete the reservation entry causing Issue.
            DeleteReservationEntries();
            //HEI.02<<
            InsertNewShipmentLine(TransferShptLine, DocLineNo);

            IF PostedWhseShptLineFound THEN
                WhseUndoQty.UndoPostedWhseShptLine(PostedWhseShptLine);

            TempWhseJnlLine.SETRANGE("Source Line No.", TransferShptLine."Line No.");
            WhseUndoQty.PostTempWhseJnlLine(TempWhseJnlLine);

            UpdateTransferOrderLine(TransferShptLine);
            IF PostedWhseShptLineFound THEN
                WhseUndoQty.UpdateShptSourceDocLines(PostedWhseShptLine);
        UNTIL TransferShptLine.NEXT() = 0;

        InvtSetup.GET();
        IF InvtSetup."Automatic Cost Adjustment" <>
          InvtSetup."Automatic Cost Adjustment"::Never
        THEN BEGIN
            InvtAdjmt.SetProperties(TRUE, InvtSetup."Automatic Cost Posting");
            InvtAdjmt.SetJobUpdateProperties(TRUE);
            InvtAdjmt.MakeMultiLevelAdjmt();
        END;
        //HEI.03>>
        GetSalesSetup();
        IF SalesSetup."Gate Entry Arch. Required FND" THEN BEGIN
            IF TransferShipmentHeader.GET(TransferShptLine."Document No.") THEN BEGIN
                IF GateEntryHeader.GET(TransferShipmentHeader."From Gate Entry No. FND") THEN BEGIN
                    GateEntryHeader.Blocked := TRUE;
                    GateEntryHeader.MODIFY();

                    TransferShipmentHeader."Gate Entry Archived FND" := TRUE;
                    TransferShipmentHeader.MODIFY();
                END;
            END;
        END;
        //HEI.03<<
        //END;
        // BC Upgrade MISHRS14 <<

    end;

    local procedure PostItemJnlLine(TranferShptLine: Record "Transfer Shipment Line"; DocLineNo: Integer): Integer;
    var
        TransferLine: Record "Transfer Line";
        TransferShptHeader: Record "Transfer Shipment Header";
        TransferShptLine2: Record "Transfer Shipment Line";
        SourceCodeSetup: Record "Source Code Setup";
        TempApplyToEntryList: Record "Item Ledger Entry" temporary;
        ItemLedgEntryShipped: Record "Item Ledger Entry";
        LineSpacing: Integer;
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        ValueEntry: Record "Value Entry";
    begin
        GLSetup.GET();

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with TransferShptLine  
        //WITH TransferShptLine DO BEGIN
        SourceCodeSetup.GET();
        TransferShptHeader.GET(TransferShptLine."Document No.");

        ItemJnlLine.INIT();
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Transfer;
        ItemJnlLine."Order Type" := ItemJnlLine."Order Type"::Transfer;
        ItemJnlLine."Order No." := TransferShptLine."Transfer Order No.";
        ItemJnlLine."Item No." := TransferShptLine."Item No.";
        ItemJnlLine."Posting Date" := TransferShptHeader."Posting Date";
        ItemJnlLine."Document Type" := ItemJnlLine."Document Type"::"Transfer Shipment";
        ItemJnlLine."Document No." := TransferShptLine."Document No.";
        ItemJnlLine."Document Line No." := DocLineNo;
        ItemJnlLine."Gen. Prod. Posting Group" := TransferShptLine."Gen. Prod. Posting Group";
        ItemJnlLine."Source Code" := SourceCodeSetup.Transfer;
        ItemJnlLine."Location Code" := TransferShptHeader."In-Transit Code";
        ItemJnlLine."New Location Code" := TransferShptLine."Transfer-from Code";
        ItemJnlLine."New Bin Code" := TransferShptLine."Transfer-from Bin Code";
        ItemJnlLine."Variant Code" := TransferShptLine."Variant Code";
        TransferLine.GET(TransferShptLine."Transfer Order No.", TransferShptLine."Line No.");
        ItemJnlLine."Document Date" := TransferShptHeader."Transfer Order Date";
        ItemJnlLine."Unit of Measure Code" := TransferShptLine."Unit of Measure Code"; //HEI.01
        ItemJnlLine."Item Charge No." := '';
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Is Item Charge","Item Charge Incl. Price","Item DTax Group Code","Item Charge Type","Item Charge Quantity per","Due Tax","Unit Volume HL","New Unit Volume HL","Duty Suspended","Duty Suspended","Tax Formula","Tariff No.","Tax Item No.")
        // ItemJnlLine."Is Item Charge" := "Is Item Charge";
        // ItemJnlLine."Item Charge Incl. Price" := "ItemCharge Incl. Price";
        // ItemJnlLine."Item DTax Group Code" := "Item DTax Group Code";
        // ItemJnlLine."Item Charge Type" := "Item Charge Type";
        // ItemJnlLine."Item Charge Quantity per" := "Item Charge Quantity per";
        // ItemJnlLine."Due Tax" := "Due Tax";
        // //HEI.01>>
        // //ItemJnlLine."Unit Volume HL" := "Unit Volume HL";
        // ItemJnlLine."Unit Volume HL" := ROUND("Unit Volume HL" / "Qty. per Unit of Measure", GLSetup."Unit-Amount Rounding Precision");
        // ItemJnlLine."New Unit Volume HL" := ItemJnlLine."Unit Volume HL";
        // //HEI.01<<
        // ItemJnlLine."Duty Suspended" := "Duty Suspended";
        // ItemJnlLine."Tax Formula" := "Tax Formula";
        // ItemJnlLine."Tariff No." := "Tariff No.";
        // ItemJnlLine."Tax Item No." := "Tax Item No.";
        // BC Upgrade BHARDA11 << ----Drink-IT Fields("Is Item Charge","Item Charge Incl. Price","Item DTax Group Code","Item Charge Type","Item Charge Quantity per","Due Tax","Unit Volume HL","New Unit Volume HL","Duty Suspended","Duty Suspended","Tax Formula","Tariff No.","Tax Item No.")

        ItemJnlLine."Shortcut Dimension 1 Code" := TransferShptLine."Shortcut Dimension 1 Code";
        ItemJnlLine."New Shortcut Dimension 1 Code" := TransferShptLine."Shortcut Dimension 1 Code";
        ItemJnlLine."Shortcut Dimension 2 Code" := TransferShptLine."Shortcut Dimension 2 Code";
        ItemJnlLine."New Shortcut Dimension 2 Code" := TransferShptLine."Shortcut Dimension 2 Code";
        ItemJnlLine."Dimension Set ID" := TransferShptLine."Dimension Set ID";
        ItemJnlLine."New Dimension Set ID" := TransferShptLine."Dimension Set ID";

        WhseUndoQty.InsertTempWhseJnlLine(ItemJnlLine,
          DATABASE::"Transfer Line",
          0,
          TransferShptHeader."Transfer Order No.",
          TransferShptLine."Line No.",

          // BC Upgrade MISHRS14 >>
          // Added -As.Integer due to warning of implicit type conversion
          TempWhseJnlLine."Reference Document"::"Posted T. Shipment".AsInteger(),
          // BC Upgrade MISHRS14 <<

          TempWhseJnlLine,
          NextLineNo);

        IF GetShptEntry(TransferShptLine, ItemLedgEntryShipped) THEN
            IF ItemLedgEntryShipped.FINDSET() THEN
                REPEAT
                    ItemJnlLine."Lot No." := '';
                    ItemJnlLine."Serial No." := '';
                    ItemJnlLine."New Serial No." := '';
                    ItemJnlLine."New Lot No." := '';
                    ItemJnlLine."Item Shpt. Entry No." := 0;
                    ItemJnlLine.VALIDATE("Quantity (Base)", ItemLedgEntryShipped.Quantity);
                    ItemJnlLine.VALIDATE("Invoiced Qty. (Base)", ItemLedgEntryShipped.Quantity);
                    IF (ItemLedgEntryShipped."Lot No." <> '') OR (ItemLedgEntryShipped."Serial No." <> '') THEN
                        InsertItemTracking(ItemLedgEntryShipped);
                    ItemJnlPostLine.SetPostponeReservationHandling(TRUE);
                    ItemJnlPostLine.RUN(ItemJnlLine);
                UNTIL ItemLedgEntryShipped.NEXT() = 0;
        //END;
        // BC Upgrade MISHRS14 <<

    end;

    local procedure InsertNewShipmentLine(OldTransferShptLine: Record "Transfer Shipment Line"; LineNo: Integer);
    var
        NewTransferShptLine: Record "Transfer Shipment Line";
    begin
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with OldTransferShptLine
        // WITH OldTransferShptLine DO BEGIN
        //     NewTransferShptLine.INIT();
        //     NewTransferShptLine.COPY(OldTransferShptLine);
        //     NewTransferShptLine."Line No." := LineNo;
        //     NewTransferShptLine.Quantity := -Quantity;
        //     NewTransferShptLine."Quantity (Base)" := -"Quantity (Base)";
        //     // BC Upgrade BHARDA11 >> ----Drink-IT Fields(Cubage,Weight,"No. of Packages")
        //     // NewTransferShptLine.Cubage := -Cubage;
        //     // NewTransferShptLine.Weight := -Weight;
        //     // NewTransferShptLine."No. of Packages" := -"No. of Packages";
        //     // BC Upgrade BHARDA11 << ----Drink-IT Fields(Cubage,Weight,"No. of Packages")
        //     NewTransferShptLine."Dimension Set ID" := "Dimension Set ID";
        //     NewTransferShptLine.INSERT();
        // END;

        //WITH OldTransferShptLine DO BEGIN
        NewTransferShptLine.INIT();
        NewTransferShptLine.COPY(OldTransferShptLine);
        NewTransferShptLine."Line No." := LineNo;
        NewTransferShptLine.Quantity := -OldTransferShptLine.Quantity;
        NewTransferShptLine."Quantity (Base)" := -OldTransferShptLine."Quantity (Base)";
        // BC Upgrade BHARDA11 >> ----Drink-IT Fields(Cubage,Weight,"No. of Packages")
        // NewTransferShptLine.Cubage := -Cubage;
        // NewTransferShptLine.Weight := -Weight;
        // NewTransferShptLine."No. of Packages" := -"No. of Packages";
        // BC Upgrade BHARDA11 << ----Drink-IT Fields(Cubage,Weight,"No. of Packages")
        NewTransferShptLine."Dimension Set ID" := OldTransferShptLine."Dimension Set ID";
        NewTransferShptLine.INSERT();
        //END;
        // BC Upgarde MISHRS14 <<

    end;

    local procedure UpdateTransferOrderLine(TransferShptLine: Record "Transfer Shipment Line");
    var
        TransferLine: Record "Transfer Line";
    begin
        TransferLine.GET(TransferShptLine."Transfer Order No.", TransferShptLine."Line No.");

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with TransferLine

        // WITH TransferLine DO BEGIN
        //     "Quantity Shipped" := "Quantity Shipped" - TransferShptLine.Quantity;
        //     "Qty. Shipped (Base)" := "Qty. Shipped (Base)" - TransferShptLine."Quantity (Base)";
        //     "Qty. to Ship" := "Qty. to Ship" + TransferShptLine.Quantity;
        //     "Qty. to Ship (Base)" := "Qty. to Ship (Base)" + TransferShptLine."Quantity (Base)";
        //     "Qty. in Transit" := 0;
        //     "Qty. in Transit (Base)" := 0;
        //     "Outstanding Quantity" := "Outstanding Quantity" + TransferShptLine.Quantity;
        //     "Outstanding Qty. (Base)" := "Outstanding Qty. (Base)" + TransferShptLine."Quantity (Base)";
        //     "Completely Shipped" := FALSE;
        //     MODIFY();
        //     RevertPostedItemTracking(TransferLine);
        // END;

        //WITH TransferLine DO BEGIN
        TransferLine."Quantity Shipped" := TransferLine."Quantity Shipped" - TransferShptLine.Quantity;
        TransferLine."Qty. Shipped (Base)" := TransferLine."Qty. Shipped (Base)" - TransferShptLine."Quantity (Base)";
        TransferLine."Qty. to Ship" := TransferLine."Qty. to Ship" + TransferShptLine.Quantity;
        TransferLine."Qty. to Ship (Base)" := TransferLine."Qty. to Ship (Base)" + TransferShptLine."Quantity (Base)";
        TransferLine."Qty. in Transit" := 0;
        TransferLine."Qty. in Transit (Base)" := 0;
        TransferLine."Outstanding Quantity" := TransferLine."Outstanding Quantity" + TransferShptLine.Quantity;
        TransferLine."Outstanding Qty. (Base)" := TransferLine."Outstanding Qty. (Base)" + TransferShptLine."Quantity (Base)";
        TransferLine."Completely Shipped" := FALSE;
        TransferLine.MODIFY();
        RevertPostedItemTracking(TransferLine);
        //END;
        // BC Upgrade MISHRS14 <<
    end;

    local procedure DeleteItemEntryRelation();
    var
        ItemEntryRelation: Record "Item Entry Relation";
    begin
        ItemEntryRelation.SETRANGE("Source Type", 5745);
        ItemEntryRelation.SETRANGE("Source Subtype", 0);
        ItemEntryRelation.SETRANGE("Source ID", TransferShptLine."Document No.");
        ItemEntryRelation.SETRANGE("Source Ref. No.", TransferShptLine."Line No.");
        IF ItemEntryRelation.FINDFIRST() THEN
            ItemEntryRelation.DELETE();
    end;

    local procedure GetShptEntry(TransferShptLine: Record "Transfer Shipment Line"; var ItemLedgEntry: Record "Item Ledger Entry"): Boolean;
    begin
        ItemLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Document Line No.");
        ItemLedgEntry.SETRANGE("Document Type", ItemLedgEntry."Document Type"::"Transfer Shipment");
        ItemLedgEntry.SETRANGE("Document No.", TransferShptLine."Document No.");
        ItemLedgEntry.SETRANGE("Document Line No.", TransferShptLine."Line No.");
        ItemLedgEntry.SETFILTER(Quantity, '>%1', 0);
        EXIT(ItemLedgEntry.FINDSET())
    end;

    procedure InsertItemTracking(ItemLedgEntry: Record "Item Ledger Entry");
    var
        ReserveEntry: Record "Reservation Entry";
        EntryNo: Integer;
        LotNoInformation: Record "Lot No. Information";
    begin
        IF ReserveEntry.FINDLAST() THEN
            EntryNo := ReserveEntry."Entry No." + 1
        ELSE
            EntryNo := 1;

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with ReserveEntry
        // WITH ReserveEntry DO BEGIN
        //     INIT();
        //     "Entry No." := EntryNo;
        //     Positive := TRUE;
        //     VALIDATE("Item No.", ItemJnlLine."Item No.");
        //     VALIDATE("Location Code", ItemJnlLine."Location Code");
        //     VALIDATE("Quantity (Base)", ItemJnlLine."Quantity (Base)");
        //     "Reservation Status" := "Reservation Status"::Prospect;
        //     VALIDATE("Creation Date", ItemJnlLine."Posting Date");
        //     "Source Type" := 83;
        //     "Source Subtype" := 4;
        //     "Source ID" := ItemJnlLine."Journal Template Name";
        //     "Source Batch Name" := ItemJnlLine."Journal Batch Name";
        //     "Source Ref. No." := ItemJnlLine."Line No.";
        //     "Expected Receipt Date" := ItemJnlLine."Posting Date";
        //     "Expiration Date" := ItemLedgEntry."Expiration Date";
        //     // "Bin Code" := ItemJnlLine."Bin Code"; // BC Upgrade BHARAD11 ----Drink-IT Field("Bin Code")
        //     "Lot No." := ItemLedgEntry."Lot No.";
        //     "Serial No." := ItemLedgEntry."Serial No.";
        //     "New Lot No." := ItemLedgEntry."Lot No.";
        //     "New Serial No." := ItemLedgEntry."Serial No.";
        //     "Item Tracking" := "Item Tracking"::"Lot No.";
        //     INSERT();

        //     IF NOT LotNoInformation.GET(ItemJnlLine."Item No.", ItemJnlLine."Variant Code", ItemJnlLine."Lot No.") THEN BEGIN
        //         LotNoInformation.INIT();
        //         LotNoInformation.VALIDATE("Item No.", "Item No.");
        //         LotNoInformation.VALIDATE("Variant Code", "Variant Code");
        //         LotNoInformation.VALIDATE("Lot No.", ItemJnlLine."Lot No.");
        //         LotNoInformation.Description := Description;
        //         // LotNoInformation."Gyle No." := "Gyle No."; // BC Upgrade BHARAD11 ----Drink-IT Field(LotNoInformation."Gyle No.")
        //         LotNoInformation.INSERT(TRUE);
        //     END;
        // END;


        //WITH ReserveEntry DO BEGIN
        ReserveEntry.INIT();
        ReserveEntry."Entry No." := EntryNo;
        ReserveEntry.Positive := TRUE;
        ReserveEntry.VALIDATE("Item No.", ItemJnlLine."Item No.");
        ReserveEntry.VALIDATE("Location Code", ItemJnlLine."Location Code");
        ReserveEntry.VALIDATE("Quantity (Base)", ItemJnlLine."Quantity (Base)");
        ReserveEntry."Reservation Status" := "Reservation Status"::Prospect;
        ReserveEntry.VALIDATE("Creation Date", ItemJnlLine."Posting Date");
        ReserveEntry."Source Type" := 83;
        ReserveEntry."Source Subtype" := 4;
        ReserveEntry."Source ID" := ItemJnlLine."Journal Template Name";
        ReserveEntry."Source Batch Name" := ItemJnlLine."Journal Batch Name";
        ReserveEntry."Source Ref. No." := ItemJnlLine."Line No.";
        ReserveEntry."Expected Receipt Date" := ItemJnlLine."Posting Date";
        ReserveEntry."Expiration Date" := ItemLedgEntry."Expiration Date";
        // "Bin Code" := ItemJnlLine."Bin Code"; // BC Upgrade BHARAD11 ----Drink-IT Field("Bin Code")
        ReserveEntry."Lot No." := ItemLedgEntry."Lot No.";
        ReserveEntry."Serial No." := ItemLedgEntry."Serial No.";
        ReserveEntry."New Lot No." := ItemLedgEntry."Lot No.";
        ReserveEntry."New Serial No." := ItemLedgEntry."Serial No.";
        ReserveEntry."Item Tracking" := ReserveEntry."Item Tracking"::"Lot No.";
        ReserveEntry.INSERT();

        IF NOT LotNoInformation.GET(ItemJnlLine."Item No.", ItemJnlLine."Variant Code", ItemJnlLine."Lot No.") THEN BEGIN
            LotNoInformation.INIT();
            LotNoInformation.VALIDATE("Item No.", ReserveEntry."Item No.");
            LotNoInformation.VALIDATE("Variant Code", ReserveEntry."Variant Code");
            LotNoInformation.VALIDATE("Lot No.", ItemJnlLine."Lot No.");
            LotNoInformation.Description := ReserveEntry.Description;
            // LotNoInformation."Gyle No." := "Gyle No."; // BC Upgrade BHARAD11 ----Drink-IT Field(LotNoInformation."Gyle No.")
            LotNoInformation.INSERT(TRUE);
        END;
        //END;
        // BC Upgrade MISHRS14 <<
    end;

    procedure RevertPostedItemTracking(TransfLine: Record "Transfer Line");
    var
        ReservEntry: Record "Reservation Entry";
        ReservEntryReceipt: Record "Reservation Entry";
        DerivedFromTransfLine: Record "Transfer Line";
        EntryNo: Integer;
    begin
        IF ReservEntry.FINDLAST() THEN
            EntryNo := ReservEntry."Entry No." + 1
        ELSE
            EntryNo := 1;

        DerivedFromTransfLine.SETRANGE("Document No.", TransfLine."Document No.");
        DerivedFromTransfLine.SETRANGE("Derived From Line No.", TransfLine."Line No.");
        IF DerivedFromTransfLine.FINDFIRST() THEN BEGIN
            ReservEntryReceipt.SETRANGE("Source Type", 5741);
            ReservEntryReceipt.SETRANGE("Source Subtype", 1);
            ReservEntryReceipt.SETRANGE("Source ID", TransfLine."Document No.");
            ReservEntryReceipt.SETRANGE("Source Ref. No.", DerivedFromTransfLine."Line No.");
            IF ReservEntryReceipt.FINDSET() THEN
                REPEAT
                    ReservEntry := ReservEntryReceipt;
                    ReservEntry."Entry No." := EntryNo;
                    ReservEntry."Source Subtype" := 0;
                    ReservEntry."Location Code" := TransfLine."Transfer-from Code";
                    ReservEntry."Quantity (Base)" := -ReservEntry."Quantity (Base)";
                    ReservEntry.Quantity := -ReservEntry.Quantity;
                    ReservEntry."Qty. to Handle (Base)" := -ReservEntry."Qty. to Handle (Base)";
                    ReservEntry."Qty. to Invoice (Base)" := -ReservEntry."Qty. to Invoice (Base)";
                    ReservEntry.Positive := FALSE;
                    ReservEntry."Expected Receipt Date" := 0D;
                    ReservEntry."Created By" := USERID;
                    ReservEntry."Shipment Date" := WORKDATE();
                    ReservEntry."Creation Date" := WORKDATE();
                    ReservEntry."Source Ref. No." := TransfLine."Line No.";
                    ReservEntry."Source Prod. Order Line" := 0;
                    ReservEntry.INSERT();
                UNTIL ReservEntryReceipt.NEXT() = 0;
            ReservEntryReceipt.DELETEALL();
        END;
    end;

    local procedure DeleteReservationEntries();
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        //HEI.02
        ReservationEntry.RESET();
        ReservationEntry.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Prod. Order Line");
        ReservationEntry.SETRANGE("Source Type", 5741);
        ReservationEntry.SETRANGE("Source Subtype", 1);
        ReservationEntry.SETRANGE("Source ID", TransferShptLine."Transfer Order No.");
        ReservationEntry.SETRANGE("Source Prod. Order Line", TransferShptLine."Line No.");
        IF ReservationEntry.FINDSET() THEN
            ReservationEntry.DELETEALL();
    end;

    local procedure GetSalesSetup();
    begin
        //HEI.03>>
        IF NOT SalesSetupRead THEN
            IF SalesSetup.GET() THEN;

        SalesSetupRead := TRUE;
        //HEI.03<<
    end;
}

