codeunit 58026 "Counterpoint Interface Mgmt."
{
    // version HEI.01

    // HEI.01 BA-SLSGAP01 IBM LAZARE02 15.10.2018 # New codeunit for Counterpoint interface
    // HEI.02 FDD-BA-SLSGAP01 IBM NASTAA02 24.10.2018 # Counterpoint Interface
    //   # New functions created for Counterpoint Interface
    // BC Upgrade BHARDA11 >>
    // 1.Remove Drink-IT Function and related code(SetHideFEFOMessage,FEFOTracking)
    // 2. Remove Drink-IT Field("Bin Code")
    // 3. Change NoSeriesmanagement to "No. Series"
    // 4. Old Codeunit ID is 50066.
    // BC Upgrade BHARDA11 <<

    trigger OnRun();
    begin
    end;

    var
        NoSeriesMgt: Codeunit "No. Series";
        CounterpointTransactions: Codeunit "Counterpoint Transactions";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        GeneralInterfaceSetupRead: Boolean;
        CounterpointInterfaceSetupRead: Boolean;
        ItemDimensionCode: Code[20];
        ItemDimensionValue: Code[20];
        SimulateModeErr: Label 'Simulate Mode';
        TotalQtyWrongErr: Label 'Total Quantity on Transfers should be 0.';
        CCCDimensionCode: Code[20];
        CCCDimensionValue: Code[20];

    procedure ProcessSales(InterfaceEntryHeader: Record "Interface Entry Header INT");
    begin
        //Sales
        GetGeneralInterfaceSetup;
        GetCounterpointInterfaceSetup;

        /*
        IF NOT InterfaceEntryHeader."Simulation Done" THEN BEGIN
          COMMIT;
          IF NOT CounterpointTransactions.RUN(InterfaceEntryHeader) THEN
            IF GETLASTERRORTEXT <> SimulateModeErr THEN
              ERROR(GETLASTERRORTEXT)
            ELSE
              CounterpointTransactions.ProcessSales(InterfaceEntryHeader);
        END;
        */
        CounterpointTransactions.ProcessSales(InterfaceEntryHeader);

    end;

    procedure ProcessPayments(InterfaceEntryHeader: Record "Interface Entry Header INT");
    begin
        //Payments
        GetGeneralInterfaceSetup;
        GetCounterpointInterfaceSetup;

        /*
        IF NOT InterfaceEntryHeader."Simulation Done" THEN BEGIN
          COMMIT;
          IF NOT CounterpointTransactions.RUN(InterfaceEntryHeader) THEN
            IF GETLASTERRORTEXT <> SimulateModeErr THEN
              ERROR(GETLASTERRORTEXT)
            ELSE
              CounterpointTransactions.ProcessPayments(InterfaceEntryHeader);
        END;
        */
        CounterpointTransactions.ProcessPayments(InterfaceEntryHeader);

    end;

    procedure ProcessPayouts(InterfaceEntryHeader: Record "Interface Entry Header INT");
    begin
        //Payouts
        GetGeneralInterfaceSetup;
        GetCounterpointInterfaceSetup;

        /*
        IF NOT InterfaceEntryHeader."Simulation Done" THEN BEGIN
          COMMIT;
          IF NOT CounterpointTransactions.RUN(InterfaceEntryHeader) THEN
            IF GETLASTERRORTEXT <> SimulateModeErr THEN
              ERROR(GETLASTERRORTEXT)
            ELSE
              CounterpointTransactions.ProcessPayouts(InterfaceEntryHeader);
        END;
        */
        CounterpointTransactions.ProcessPayouts(InterfaceEntryHeader);

    end;

    procedure ProcessStockAdjmt(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        DimensionManagement: Codeunit DimensionManagement;
        SourceCodeSetup: Record "Source Code Setup";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLine2: Record "Interface Entry Line INT";
        InterfaceEntryLine3: Record "Interface Entry Line INT";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        ItemJournalLine3: Record "Item Journal Line";
        ItemJournalLine4: Record "Item Journal Line";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        ItemJournalBatch: Record "Item Journal Batch";
        ReservationEntry: Record "Reservation Entry";
        DocumentNo: Code[20];
        LocationCode: Code[20];
        LineNo: Integer;
    begin
        //Stock Adjustments
        GetGeneralInterfaceSetup;
        SourceCodeSetup.GET;
        GetCounterpointInterfaceSetup;

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN BEGIN
            ItemJournalBatch.GET(CounterpointInterfaceSetup."Stock Adjst Item Jnl Template", CounterpointInterfaceSetup."Stock Adjst Item Jnl Batch");
            DocumentNo := NoSeriesMgt.GetNextNo(ItemJournalBatch."No. Series", InterfaceEntryLine."Posting Date", FALSE);

            //Delete existing Reservation Entries
            ReservationEntry.SETRANGE("Source ID", CounterpointInterfaceSetup."Stock Adjst Item Jnl Template");
            ReservationEntry.SETRANGE("Source Batch Name", CounterpointInterfaceSetup."Stock Adjst Item Jnl Batch");
            ReservationEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
            IF ReservationEntry.FINDFIRST THEN
                ReservationEntry.DELETEALL;

            //Delete existing empty lines
            ItemJournalLine3.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."Stock Adjst Item Jnl Template");
            ItemJournalLine3.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."Stock Adjst Item Jnl Batch");
            ItemJournalLine3.SETRANGE("Item No.", '');
            IF ItemJournalLine3.FINDFIRST THEN
                ItemJournalLine3.DELETEALL;

            REPEAT
                CLEAR(ItemJournalLine);
                InterfaceEntryLine.CALCFIELDS("HeiLite Item No.");
                InterfaceEntryLine.CALCFIELDS("HeiLite Location Code");

                ItemJournalLine.INIT;
                ItemJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Stock Adjst Item Jnl Template");
                ItemJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Stock Adjst Item Jnl Batch");
                ItemJournalLine2.RESET;
                ItemJournalLine2.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                ItemJournalLine2.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."Stock Adjst Item Jnl Batch");
                IF ItemJournalLine2.FINDLAST THEN
                    LineNo := ItemJournalLine2."Line No." + 10000
                ELSE
                    LineNo := 10000;
                ItemJournalLine.VALIDATE("Line No.", LineNo);
                ItemJournalLine.INSERT;

                ItemJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                ItemJournalLine.VALIDATE("Document No.", DocumentNo);
                ItemJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                ItemJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                ItemJournalLine.VALIDATE("Item No.", InterfaceEntryLine."HeiLite Item No.");
                ItemJournalLine.VALIDATE(Description, GetItemNoDescription(InterfaceEntryLine."HeiLite Item No."));
                ItemJournalLine.VALIDATE("Location Code", InterfaceEntryLine."HeiLite Location Code");
                ItemJournalLine.VALIDATE("Zone Code FND", CounterpointInterfaceSetup."Zone Code");
                ItemJournalLine.VALIDATE("Bin Code", CounterpointInterfaceSetup."Bin Code");
                IF InterfaceEntryLine.Quantity < 0 THEN BEGIN
                    ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
                    ItemJournalLine.VALIDATE(Quantity, -InterfaceEntryLine.Quantity);
                    ItemJournalLine.VALIDATE("Unit of Measure Code", CounterpointInterfaceSetup."Item UoM Retail");
                    // BC Upgrade BHARDA11 >> ----Drink-IT Function(SetHideFEFOMessage,FEFOTracking)
                    // ItemJournalLine.SetHideFEFOMessage(TRUE);
                    // ItemJournalLine.FEFOTracking(FALSE);
                    // BC Upgrade BHARDA11 << ----Drink-IT Function(SetHideFEFOMessage,FEFOTracking)
                END ELSE BEGIN
                    ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                    ItemJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    ItemJournalLine.VALIDATE("Unit of Measure Code", CounterpointInterfaceSetup."Item UoM Retail");
                    CreateReservationEntry(ItemJournalLine);
                END;

                ItemJournalLine.VALIDATE("Source Code", SourceCodeSetup."Item Journal");

                //Dimensions
                CLEAR(TempDimensionSetEntry);
                DimensionManagement.GetDimensionSet(TempDimensionSetEntry, ItemJournalLine."Dimension Set ID");

                //Dimensions Item
                GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                    TempDimensionSetEntry.INIT;
                    TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                    TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                    IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                END;

                //Dimensions Location
                GetDimensionLocationMappingCP(InterfaceEntryLine."HeiLite Location Code");
                TempDimensionSetEntry.SETRANGE("Dimension Code", CCCDimensionCode);
                IF TempDimensionSetEntry.FINDFIRST AND (TempDimensionSetEntry."Dimension Value Code" <> CCCDimensionValue) THEN
                    TempDimensionSetEntry.DELETE;
                IF (CCCDimensionCode <> '') OR (CCCDimensionValue <> '') THEN BEGIN
                    TempDimensionSetEntry.INIT;
                    TempDimensionSetEntry."Dimension Code" := CCCDimensionCode;
                    TempDimensionSetEntry."Dimension Value Code" := CCCDimensionValue;
                    IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                END;

                ItemJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                ItemJournalLine.MODIFY;

            UNTIL InterfaceEntryLine.NEXT = 0;

            ItemJournalLine4.RESET;
            ItemJournalLine4.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."Stock Adjst Item Jnl Template");
            ItemJournalLine4.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."Stock Adjst Item Jnl Batch");
            ItemJournalLine4.SETFILTER("Line No.", '<>%1', 0);
            IF ItemJournalLine4.FINDFIRST THEN
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine);

        END;
    end;

    procedure ProcessTransferAdjmt(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        DimensionManagement: Codeunit DimensionManagement;
        SourceCodeSetup: Record "Source Code Setup";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLine2: Record "Interface Entry Line INT";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        ItemJournalLine3: Record "Item Journal Line";
        ItemJournalLine4: Record "Item Journal Line";
        Location: Record Location;
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        ItemJournalBatch: Record "Item Journal Batch";
        ReservationEntry: Record "Reservation Entry";
        DocumentNo: Code[20];
        LineNo: Integer;
        TotalQty: Decimal;
    begin
        //Transfer Adjustments
        GetGeneralInterfaceSetup;
        SourceCodeSetup.GET;
        GetCounterpointInterfaceSetup;

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN BEGIN
            CLEAR(ItemJournalLine);
            ItemJournalBatch.GET(CounterpointInterfaceSetup."Stock Transf Item Jnl Template", CounterpointInterfaceSetup."Stock Transf Item Jnl Batch");
            DocumentNo := NoSeriesMgt.GetNextNo(ItemJournalBatch."No. Series", InterfaceEntryLine."Posting Date", FALSE);

            //Delete existing Reservation Entries
            ReservationEntry.SETRANGE("Source ID", CounterpointInterfaceSetup."Stock Transf Item Jnl Template");
            ReservationEntry.SETRANGE("Source Batch Name", CounterpointInterfaceSetup."Stock Transf Item Jnl Batch");
            ReservationEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
            IF ReservationEntry.FINDFIRST THEN
                ReservationEntry.DELETEALL;

            //Delete existing empty lines
            ItemJournalLine3.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."Stock Transf Item Jnl Template");
            ItemJournalLine3.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."Stock Transf Item Jnl Batch");
            IF ItemJournalLine3.FINDFIRST THEN
                ItemJournalLine3.DELETEALL;

            REPEAT
                InterfaceEntryLine.CALCFIELDS("HeiLite Item No.");
                InterfaceEntryLine.CALCFIELDS("HeiLite Location Code");

                //Check Total Quantity to be 0
                /*
                InterfaceEntryLine2.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");
                InterfaceEntryLine2.SETRANGE("No.",InterfaceEntryLine."No.");
                IF InterfaceEntryLine2.FINDSET THEN BEGIN
                  REPEAT
                    TotalQty += InterfaceEntryLine2.Quantity;
                  UNTIL InterfaceEntryLine2.NEXT = 0;
                  IF TotalQty <> 0 THEN
                    ERROR(TotalQtyWrongErr);
                END;
                */

                ItemJournalLine.INIT;
                ItemJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Stock Transf Item Jnl Template");
                ItemJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Stock Transf Item Jnl Batch");
                ItemJournalLine2.RESET;
                ItemJournalLine2.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                ItemJournalLine2.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                IF ItemJournalLine2.FINDLAST THEN
                    LineNo := ItemJournalLine2."Line No." + 10000
                ELSE
                    LineNo := 10000;
                ItemJournalLine.VALIDATE("Line No.", LineNo);
                ItemJournalLine.INSERT;

                ItemJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                ItemJournalLine.VALIDATE("Document No.", DocumentNo);
                ItemJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                ItemJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                ItemJournalLine.VALIDATE("Item No.", InterfaceEntryLine."HeiLite Item No.");
                ItemJournalLine.VALIDATE(Description, GetItemNoDescription(InterfaceEntryLine."HeiLite Item No."));
                ItemJournalLine.VALIDATE("Location Code", InterfaceEntryLine."HeiLite Location Code");
                ItemJournalLine.VALIDATE("Zone Code FND", CounterpointInterfaceSetup."Zone Code");
                Location.GET(InterfaceEntryLine."HeiLite Location Code");
                ItemJournalLine.VALIDATE("Bin Code", CounterpointInterfaceSetup."Bin Code");
                IF InterfaceEntryLine.Quantity < 0 THEN BEGIN
                    ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
                    ItemJournalLine.VALIDATE(Quantity, -InterfaceEntryLine.Quantity);
                    ItemJournalLine.VALIDATE("Unit of Measure Code", CounterpointInterfaceSetup."Item UoM Retail");
                    // BC Upgrade BHARDA11 >> ----Drink-IT Function(SetHideFEFOMessage,FEFOTracking)
                    // ItemJournalLine.SetHideFEFOMessage(TRUE);
                    // ItemJournalLine.FEFOTracking(FALSE);
                    // BC Upgrade BHARDA11 << ----Drink-IT Function(SetHideFEFOMessage,FEFOTracking)
                END ELSE BEGIN
                    ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                    ItemJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    ItemJournalLine.VALIDATE("Unit of Measure Code", CounterpointInterfaceSetup."Item UoM Retail");
                    CreateReservationEntry(ItemJournalLine);
                END;

                ItemJournalLine.VALIDATE("Source Code", SourceCodeSetup."Item Journal");

                //Dimensions
                CLEAR(TempDimensionSetEntry);
                DimensionManagement.GetDimensionSet(TempDimensionSetEntry, ItemJournalLine."Dimension Set ID");

                //Dimensions Item
                GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                    TempDimensionSetEntry.INIT;
                    TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                    TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                    IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                END;

                //Dimensions Location
                GetDimensionLocationMappingCP(InterfaceEntryLine."HeiLite Location Code");
                TempDimensionSetEntry.SETRANGE("Dimension Code", CCCDimensionCode);
                IF TempDimensionSetEntry.FINDFIRST AND (TempDimensionSetEntry."Dimension Value Code" <> CCCDimensionValue) THEN
                    TempDimensionSetEntry.DELETE;
                IF (CCCDimensionCode <> '') OR (CCCDimensionValue <> '') THEN BEGIN
                    TempDimensionSetEntry.INIT;
                    TempDimensionSetEntry."Dimension Code" := CCCDimensionCode;
                    TempDimensionSetEntry."Dimension Value Code" := CCCDimensionValue;
                    IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                END;

                ItemJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                ItemJournalLine.MODIFY;

            UNTIL InterfaceEntryLine.NEXT = 0;

            ItemJournalLine4.RESET;
            ItemJournalLine4.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."Stock Transf Item Jnl Template");
            ItemJournalLine4.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."Stock Transf Item Jnl Batch");
            ItemJournalLine4.SETFILTER("Line No.", '<>%1', 0);
            IF ItemJournalLine4.FINDFIRST THEN
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine);

        END;

    end;

    procedure ProcessReceipts(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        DimensionManagement: Codeunit DimensionManagement;
        SourceCodeSetup: Record "Source Code Setup";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLine2: Record "Interface Entry Line INT";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        ItemJournalLine3: Record "Item Journal Line";
        ItemJournalLine4: Record "Item Journal Line";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        ItemJournalBatch: Record "Item Journal Batch";
        ReservationEntry: Record "Reservation Entry";
        DocumentNo: Code[20];
        LineNo: Integer;
    begin
        //Purchase Receipts
        GetGeneralInterfaceSetup;
        SourceCodeSetup.GET;
        GetCounterpointInterfaceSetup;

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        InterfaceEntryLine.SETFILTER(Quantity, '>%1', 0);
        IF InterfaceEntryLine.FINDSET THEN BEGIN
            CLEAR(ItemJournalLine);
            ItemJournalBatch.GET(CounterpointInterfaceSetup."PO Receipts Item Jnl Template", CounterpointInterfaceSetup."PO Receipts Item Jnl Batch");
            DocumentNo := NoSeriesMgt.GetNextNo(ItemJournalBatch."No. Series", InterfaceEntryLine."Posting Date", FALSE);

            //Delete existing Reservation Entries
            ReservationEntry.SETRANGE("Source ID", CounterpointInterfaceSetup."PO Receipts Item Jnl Template");
            ReservationEntry.SETRANGE("Source Batch Name", CounterpointInterfaceSetup."PO Receipts Item Jnl Batch");
            ReservationEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
            IF ReservationEntry.FINDFIRST THEN
                ReservationEntry.DELETEALL;

            //Delete existing empty lines
            ItemJournalLine3.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."PO Receipts Item Jnl Template");
            ItemJournalLine3.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."PO Receipts Item Jnl Batch");
            IF ItemJournalLine3.FINDFIRST THEN
                ItemJournalLine3.DELETEALL;

            REPEAT
                //Skip Burns House CP's
                InterfaceEntryLine2.RESET;
                InterfaceEntryLine2.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                InterfaceEntryLine2.SETRANGE("Entry No.", InterfaceEntryLine."Entry No.");
                InterfaceEntryLine2.SETFILTER("Buy-from Vendor No.", CounterpointInterfaceSetup."Burns House CP No.");
                IF NOT InterfaceEntryLine2.FINDFIRST THEN BEGIN

                    InterfaceEntryLine.CALCFIELDS("HeiLite Item No.");
                    InterfaceEntryLine.CALCFIELDS("HeiLite Location Code");
                    InterfaceEntryLine.CALCFIELDS("HeiLite Vendor No.");

                    ItemJournalLine.INIT;
                    ItemJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."PO Receipts Item Jnl Template");
                    ItemJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."PO Receipts Item Jnl Batch");
                    ItemJournalLine2.RESET;
                    ItemJournalLine2.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                    ItemJournalLine2.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                    IF ItemJournalLine2.FINDLAST THEN
                        LineNo := ItemJournalLine2."Line No." + 10000
                    ELSE
                        LineNo := 10000;
                    ItemJournalLine.VALIDATE("Line No.", LineNo);
                    ItemJournalLine.INSERT;
                    ItemJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                    ItemJournalLine.VALIDATE("Document No.", DocumentNo);
                    ItemJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                    ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::Purchase);
                    ItemJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                    ItemJournalLine.VALIDATE("Item No.", InterfaceEntryLine."HeiLite Item No.");
                    ItemJournalLine.VALIDATE(Description, GetItemNoDescription(InterfaceEntryLine."HeiLite Item No."));
                    ItemJournalLine.VALIDATE("Source Type", ItemJournalLine."Source Type"::Vendor);
                    ItemJournalLine.VALIDATE("Vendor No. FND", InterfaceEntryLine."HeiLite Vendor No.");
                    ItemJournalLine.VALIDATE("Location Code", InterfaceEntryLine."HeiLite Location Code");
                    ItemJournalLine.VALIDATE("Zone Code FND", CounterpointInterfaceSetup."Zone Code");
                    ItemJournalLine.VALIDATE("Bin Code", CounterpointInterfaceSetup."Bin Code");
                    ItemJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    ItemJournalLine.VALIDATE("Unit of Measure Code", CounterpointInterfaceSetup."Item UoM Retail");
                    CreateReservationEntry(ItemJournalLine);
                    ItemJournalLine.VALIDATE("Unit Amount", InterfaceEntryLine."Unit Amount");

                    ItemJournalLine.VALIDATE("Source Code", SourceCodeSetup."Item Journal");
                    ItemJournalLine.VALIDATE("CP Vendor Invoice No. FND", InterfaceEntryLine.Reference);

                    //Dimensions
                    CLEAR(TempDimensionSetEntry);
                    DimensionManagement.GetDimensionSet(TempDimensionSetEntry, ItemJournalLine."Dimension Set ID");

                    //Dimensions Item
                    GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                    IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                    END;

                    //Dimensions Location
                    GetDimensionLocationMappingCP(InterfaceEntryLine."HeiLite Location Code");
                    TempDimensionSetEntry.SETRANGE("Dimension Code", CCCDimensionCode);
                    IF TempDimensionSetEntry.FINDFIRST AND (TempDimensionSetEntry."Dimension Value Code" <> CCCDimensionValue) THEN
                        TempDimensionSetEntry.DELETE;
                    IF (CCCDimensionCode <> '') OR (CCCDimensionValue <> '') THEN BEGIN
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := CCCDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := CCCDimensionValue;
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                    END;

                    ItemJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                    ItemJournalLine.MODIFY;
                END;

            UNTIL InterfaceEntryLine.NEXT = 0;

            ItemJournalLine4.RESET;
            ItemJournalLine4.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."PO Receipts Item Jnl Template");
            ItemJournalLine4.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."PO Receipts Item Jnl Batch");
            ItemJournalLine4.SETFILTER("Line No.", '<>%1', 0);
            IF ItemJournalLine4.FINDFIRST THEN
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine);

        END;
    end;

    procedure ProcessRTV(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        DimensionManagement: Codeunit DimensionManagement;
        SourceCodeSetup: Record "Source Code Setup";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLine2: Record "Interface Entry Line INT";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        ItemJournalLine3: Record "Item Journal Line";
        ItemJournalLine4: Record "Item Journal Line";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        ItemJournalBatch: Record "Item Journal Batch";
        ReservationEntry: Record "Reservation Entry";
        DocumentNo: Code[20];
        LineNo: Integer;
    begin
        //Return to Vendor
        GetGeneralInterfaceSetup;
        SourceCodeSetup.GET;
        GetCounterpointInterfaceSetup;

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        InterfaceEntryLine.SETFILTER(Quantity, '>%1', 0);
        IF InterfaceEntryLine.FINDSET THEN BEGIN
            CLEAR(ItemJournalLine);
            ItemJournalBatch.GET(CounterpointInterfaceSetup."RTV Item Jnl Template", CounterpointInterfaceSetup."RTV Item Jnl Batch");
            DocumentNo := NoSeriesMgt.GetNextNo(ItemJournalBatch."No. Series", InterfaceEntryLine."Posting Date", FALSE);

            //Delete existing Reservation Entries
            ReservationEntry.SETRANGE("Source ID", CounterpointInterfaceSetup."RTV Item Jnl Template");
            ReservationEntry.SETRANGE("Source Batch Name", CounterpointInterfaceSetup."RTV Item Jnl Batch");
            ReservationEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
            IF ReservationEntry.FINDFIRST THEN
                ReservationEntry.DELETEALL;

            //Delete existing empty lines
            ItemJournalLine3.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."RTV Item Jnl Template");
            ItemJournalLine3.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."RTV Item Jnl Batch");
            IF ItemJournalLine3.FINDFIRST THEN
                ItemJournalLine3.DELETEALL;

            REPEAT
                //Skip Burns House CP's
                InterfaceEntryLine2.RESET;
                InterfaceEntryLine2.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                InterfaceEntryLine2.SETRANGE("Entry No.", InterfaceEntryLine."Entry No.");
                InterfaceEntryLine2.SETFILTER("Buy-from Vendor No.", CounterpointInterfaceSetup."Burns House CP No.");
                IF NOT InterfaceEntryLine2.FINDFIRST THEN BEGIN

                    InterfaceEntryLine.CALCFIELDS("HeiLite Item No.");
                    InterfaceEntryLine.CALCFIELDS("HeiLite Location Code");
                    InterfaceEntryLine.CALCFIELDS("HeiLite Vendor No.");

                    ItemJournalLine.INIT;
                    ItemJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."RTV Item Jnl Template");
                    ItemJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."RTV Item Jnl Batch");
                    ItemJournalLine2.RESET;
                    ItemJournalLine2.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                    ItemJournalLine2.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                    IF ItemJournalLine2.FINDLAST THEN
                        LineNo := ItemJournalLine2."Line No." + 10000
                    ELSE
                        LineNo := 10000;
                    ItemJournalLine.VALIDATE("Line No.", LineNo);
                    ItemJournalLine.INSERT;

                    ItemJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                    ItemJournalLine.VALIDATE("Document No.", DocumentNo);
                    ItemJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                    ItemJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                    ItemJournalLine.VALIDATE("Item No.", InterfaceEntryLine."HeiLite Item No.");
                    ItemJournalLine.VALIDATE(Description, GetItemNoDescription(InterfaceEntryLine."HeiLite Item No."));
                    ItemJournalLine.VALIDATE("Source Type", ItemJournalLine."Source Type"::Vendor);
                    ItemJournalLine.VALIDATE("Vendor No. FND", InterfaceEntryLine."HeiLite Vendor No.");
                    ItemJournalLine.VALIDATE("Location Code", InterfaceEntryLine."HeiLite Location Code");
                    ItemJournalLine.VALIDATE("Zone Code FND", CounterpointInterfaceSetup."Zone Code");
                    ItemJournalLine.VALIDATE("Bin Code", CounterpointInterfaceSetup."Bin Code");

                    ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
                    ItemJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    ItemJournalLine.VALIDATE("Unit of Measure Code", CounterpointInterfaceSetup."Item UoM Retail");
                    // BC Upgrade BHARDA11 >> ----Drink-IT Function(SetHideFEFOMessage,FEFOTracking)
                    // ItemJournalLine.SetHideFEFOMessage(TRUE);
                    // ItemJournalLine.FEFOTracking(FALSE);
                    // BC Upgrade BHARDA11 << ----Drink-IT Function(SetHideFEFOMessage,FEFOTracking)
                    UpdateReservationEntry(ItemJournalLine);
                    ItemJournalLine.VALIDATE("Unit Amount", -InterfaceEntryLine."Unit Amount");
                    ItemJournalLine.VALIDATE("Source Code", SourceCodeSetup."Item Journal");
                    ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Purchase;
                    ItemJournalLine.Quantity := -InterfaceEntryLine.Quantity;
                    ItemJournalLine."Quantity (Base)" := -InterfaceEntryLine.Quantity;
                    ItemJournalLine."Invoiced Qty. (Base)" := -InterfaceEntryLine.Quantity;
                    ItemJournalLine.VALIDATE("Unit Amount", -InterfaceEntryLine."Unit Amount");

                    //Dimensions
                    CLEAR(TempDimensionSetEntry);
                    DimensionManagement.GetDimensionSet(TempDimensionSetEntry, ItemJournalLine."Dimension Set ID");

                    //Dimensions Item
                    GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                    IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                    END;

                    //Dimensions Location
                    GetDimensionLocationMappingCP(InterfaceEntryLine."HeiLite Location Code");
                    TempDimensionSetEntry.SETRANGE("Dimension Code", CCCDimensionCode);
                    IF TempDimensionSetEntry.FINDFIRST AND (TempDimensionSetEntry."Dimension Value Code" <> CCCDimensionValue) THEN
                        TempDimensionSetEntry.DELETE;
                    IF (CCCDimensionCode <> '') OR (CCCDimensionValue <> '') THEN BEGIN
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := CCCDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := CCCDimensionValue;
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                    END;

                    ItemJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                    ItemJournalLine.MODIFY;
                END;
            UNTIL InterfaceEntryLine.NEXT = 0;

            ItemJournalLine4.RESET;
            ItemJournalLine4.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."RTV Item Jnl Template");
            ItemJournalLine4.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."RTV Item Jnl Batch");
            ItemJournalLine4.SETFILTER("Line No.", '<>%1', 0);
            IF ItemJournalLine4.FINDFIRST THEN
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine);
        END;
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        IF NOT GeneralInterfaceSetupRead THEN
            GeneralInterfaceSetup.GET;
        GeneralInterfaceSetupRead := TRUE;
    end;

    local procedure GetCounterpointInterfaceSetup();
    begin
        IF NOT CounterpointInterfaceSetupRead THEN
            CounterpointInterfaceSetup.GET;
        CounterpointInterfaceSetupRead := TRUE;
    end;

    local procedure GetDimensionLocationMappingCP(LocationCode: Code[10]);
    var
        LocationMappingCP: Record "Location Mapping CP FND";
    begin
        CLEAR(CCCDimensionCode);
        CLEAR(CCCDimensionValue);

        LocationMappingCP.SETRANGE("Location Code", LocationCode);
        IF LocationMappingCP.FINDFIRST THEN BEGIN
            CCCDimensionCode := LocationMappingCP."CCC Dimension";
            CCCDimensionValue := LocationMappingCP."CCC Dimension Value";
        END;
    end;

    local procedure GetDimensionItemMappingCP(ItemNo: Code[10]);
    var
        ItemMappingCP: Record "Item Mapping CP FND";
    begin
        CLEAR(ItemDimensionCode);
        CLEAR(ItemDimensionValue);

        ItemMappingCP.SETRANGE("Heilite Item ID", ItemNo);
        IF ItemMappingCP.FINDFIRST THEN BEGIN
            ItemDimensionCode := ItemMappingCP.Dimension;
            ItemDimensionValue := ItemMappingCP."Dimension Value";
        END;
    end;

    local procedure GetItemNoDescription(ItemNo: Code[20]): Text[50];
    var
        ItemMappingCP: Record "Item Mapping CP FND";
    begin
        ItemMappingCP.SETRANGE("Heilite Item ID", ItemNo);
        IF ItemMappingCP.FINDFIRST THEN BEGIN
            ItemMappingCP.CALCFIELDS("Heilite Item Description");
            EXIT(ItemMappingCP."Heilite Item Description");
        END;
    end;

    procedure CreateReservationEntry(ItemJnlLine: Record "Item Journal Line");
    var
        ReservationEntry: Record "Reservation Entry";
        LastEntryNo: Integer;
    begin
        GetGeneralInterfaceSetup;
        GetCounterpointInterfaceSetup;

        IF ReservationEntry.FINDLAST THEN
            LastEntryNo := ReservationEntry."Entry No.";

        ReservationEntry.INIT;
        ReservationEntry."Entry No." := LastEntryNo + 1;
        ReservationEntry.Positive := ItemJnlLine.Quantity > 0;
        ReservationEntry."Source Type" := DATABASE::"Item Journal Line";
        ReservationEntry."Source Subtype" := ItemJnlLine."Entry Type".AsInteger();
        ReservationEntry."Source ID" := ItemJnlLine."Journal Template Name";
        ReservationEntry."Source Batch Name" := ItemJnlLine."Journal Batch Name";
        ReservationEntry."Source Ref. No." := ItemJnlLine."Line No.";
        ReservationEntry."Creation Date" := WORKDATE;
        ReservationEntry."Created By" := USERID;
        ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
        ReservationEntry.VALIDATE("Item No.", ItemJnlLine."Item No.");
        ReservationEntry.VALIDATE("Location Code", ItemJnlLine."Location Code");
        // ReservationEntry.VALIDATE("Bin Code", ItemJnlLine."Bin Code"); // BC Upgrade BHARAD11 ----Drink-IT Field("Bin Code")
        ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
        ReservationEntry.VALIDATE("Lot No.", CounterpointInterfaceSetup."Fixed Lot No.");
        ReservationEntry.VALIDATE(Quantity, ItemJnlLine.Quantity);
        ReservationEntry.VALIDATE("Quantity (Base)", ItemJnlLine."Quantity (Base)");
        ReservationEntry.VALIDATE("Qty. to Handle (Base)", ReservationEntry."Quantity (Base)");
        ReservationEntry.INSERT;
    end;

    local procedure UpdateReservationEntry(var ItemJournalLine: Record "Item Journal Line");
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        ReservationEntry.SETRANGE("Source ID", ItemJournalLine."Journal Template Name");
        ReservationEntry.SETRANGE("Source Ref. No.", ItemJournalLine."Line No.");
        ReservationEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservationEntry.SETRANGE("Source Subtype", ItemJournalLine."Entry Type");
        ReservationEntry.SETRANGE("Source Batch Name", ItemJournalLine."Journal Batch Name");
        ReservationEntry.SETRANGE("Item No.", ItemJournalLine."Item No.");
        ReservationEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
        IF ReservationEntry.FINDSET THEN
            REPEAT
                ReservationEntry."Source Subtype" := ItemJournalLine."Entry Type"::Purchase.AsInteger();
                ReservationEntry.MODIFY;
            UNTIL ReservationEntry.NEXT = 0;
    end;
}

