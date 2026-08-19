codeunit 58027 "Counterpoint Transactions"
{
    // version HEI.01

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 23.11.2018 # Counterpoint Interface
    //   # New functions created for Counterpoint Interface
    // HEI.02 FDD-BA-SLSGAP01 IBM NASTAA02 02.01.2019 # Counterpoint Interface
    //   # Several fixes
    // HEI.03 CHG2029869 IBM NASTAA02 09.01.2020 # Fix Value Entries CounterPoint Journal
    //   # Updated "Unit Amount" from COGS Item Journal with UnitPrice from Counterpoint
    // HEI.04 CHG2032083 IBM GAVANM01 23.01.2020 # Payment Reconciliation - Counterpoint interface
    //   # new code for recording the Bank Deposit Slip ID in the General Ledger Entries

    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Field and related code ("Def. Gen. Bus. Posting Group")
    // 2. Remove Drink-IT Function(SetHideFEFOMessage,FEFOTracking) and related code.
    // 3. Change Noseriesmanagement to "No. Series"
    // 4. Old Codeunit id is 50068.
    // BC Upgrade BHARDA11 <<

    //BCUP0-92 PATHAA02 09.07.27 Aptean field added in item journal template-"Def. Gen. Bus. Posting Group FND"

    TableNo = "Interface Entry Header INT";

    trigger OnRun();
    begin
        GetGeneralInterfaceSetup;
        GetCounterpointInterfaceSetup;
        SimulationMode := TRUE;

        SimulateSales(Rec);
        SimulatePayments(Rec);
        SimulatePayouts(Rec);

        SimulationMode := FALSE;

        ERROR(SimulateModeErr);
    end;

    var
        SalesNoSeriesMgt: Codeunit "No. Series"; // 396;
        PaymentsNoSeriesMgt: Codeunit "No. Series"; // 396;
        PayoutsNoSeriesMgt: Codeunit "No. Series"; // 396;
        CounterpointInterfaceMgmt: Codeunit "Counterpoint Interface Mgmt."; //50066
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        CounterpointInterfaceSetup: Record "Counterpoint Interf. Stp INT";
        GeneralInterfaceSetupRead: Boolean;
        CounterpointInterfaceSetupRead: Boolean;
        SimulationMode: Boolean;
        ItemDimensionCode: Code[20];
        ItemDimensionValue: Code[20];
        SimulateModeErr: Label 'Simulate Mode';
        NegativeTotalAmtErr: Label 'Total Amount on Ticket No. %1 should be negative. Current value is %2.';
        PaymentMissingErr: Label 'Payment is missing.';
        SalesMissingErr: Label 'Sales is missing.';
        CCCDimensionCode: Code[20];
        CCCDimensionValue: Code[20];

    local procedure SimulateSales(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
    begin
        //Search Sales Interface Entry
        InterfaceEntryHeader2.SETRANGE("Interface Code", CounterpointInterfaceSetup."Sales Interface");
        InterfaceEntryHeader2.SETRANGE("Posting Date", InterfaceEntryHeader."Posting Date");
        InterfaceEntryHeader2.SETRANGE("Location Code", InterfaceEntryHeader."Location Code");
        IF NOT InterfaceEntryHeader2.FINDFIRST THEN
            ERROR(SalesMissingErr)
        ELSE IF NOT InterfaceEntryHeader2."Simulation Done" THEN
            ProcessSales(InterfaceEntryHeader2);
    end;

    local procedure SimulatePayments(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
    begin
        //Search Payments Interface Entry
        InterfaceEntryHeader2.SETRANGE("Interface Code", CounterpointInterfaceSetup."Payments Interface");
        InterfaceEntryHeader2.SETRANGE("Posting Date", InterfaceEntryHeader."Posting Date");
        InterfaceEntryHeader2.SETRANGE("Location Code", InterfaceEntryHeader."Location Code");
        IF NOT InterfaceEntryHeader2.FINDFIRST THEN
            ERROR(PaymentMissingErr)
        ELSE IF NOT InterfaceEntryHeader2."Simulation Done" THEN
            ProcessPayments(InterfaceEntryHeader2);
    end;

    local procedure SimulatePayouts(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
    begin
        //Search Payouts Interface Entry
        InterfaceEntryHeader2.SETRANGE("Interface Code", CounterpointInterfaceSetup."Payouts Interface");
        InterfaceEntryHeader2.SETRANGE("Posting Date", InterfaceEntryHeader."Posting Date");
        InterfaceEntryHeader2.SETRANGE("Location Code", InterfaceEntryHeader."Location Code");
        IF InterfaceEntryHeader2.FINDFIRST THEN
            IF NOT InterfaceEntryHeader2."Simulation Done" THEN
                ProcessPayouts(InterfaceEntryHeader2);
    end;

    procedure ProcessSales(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        DimensionManagement: Codeunit DimensionManagement;
        ItemNoSeriesMgt: Codeunit "No. Series";
        SourceCodeSetup: Record "Source Code Setup";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        GenJournalLine3: Record "Gen. Journal Line";
        GenJournalLine4: Record "Gen. Journal Line";
        GenJournalLine5: Record "Gen. Journal Line";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        ItemJournalLine3: Record "Item Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        ItemJournalBatch: Record "Item Journal Batch";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        ReservationEntry: Record "Reservation Entry";
        DocumentNo: Code[20];
        COGSDocumentNo: Code[20];
        LineNo: Integer;
        DiscountAmount: Decimal;
        GrossAmount: Decimal;
        FreeItemAmount: Decimal;
        TotalAmount: Decimal;
        AccountNo: Code[20];
        ItemJournalTemplate: Record "Item Journal Template";
    begin
        //Sales
        GetGeneralInterfaceSetup;
        SourceCodeSetup.GET;
        GetCounterpointInterfaceSetup;

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN BEGIN
            CLEAR(GenJournalLine);
            CLEAR(ItemJournalLine);
            GenJournalBatch.GET(CounterpointInterfaceSetup."Sales Gen. Journal Template", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
            ItemJournalBatch.GET(CounterpointInterfaceSetup."COGS Item Journal Template", CounterpointInterfaceSetup."COGS Item Journal Batch");
            ItemJournalTemplate.GET(CounterpointInterfaceSetup."COGS Item Journal Template"); //HEI.02
            DocumentNo := SalesNoSeriesMgt.GetNextNo(GenJournalBatch."No. Series", InterfaceEntryLine."Posting Date", FALSE);
            COGSDocumentNo := ItemNoSeriesMgt.GetNextNo(ItemJournalBatch."No. Series", InterfaceEntryLine."Posting Date", FALSE);

            //Delete existing Reservation Entries
            ReservationEntry.RESET;
            ReservationEntry.SETRANGE("Source ID", CounterpointInterfaceSetup."COGS Item Journal Template");
            ReservationEntry.SETRANGE("Source Batch Name", CounterpointInterfaceSetup."COGS Item Journal Batch");
            ReservationEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
            IF ReservationEntry.FINDFIRST THEN
                ReservationEntry.DELETEALL;

            //Delete existing empty lines
            GenJournalLine3.RESET;
            GenJournalLine3.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
            GenJournalLine3.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
            IF GenJournalLine3.FINDFIRST THEN
                GenJournalLine3.DELETEALL;

            REPEAT
                //Sales
                InterfaceEntryLine.CALCFIELDS("HeiLite Item No.");
                InterfaceEntryLine.CALCFIELDS("HeiLite Location Code");
                InterfaceEntryLine.TESTFIELD("Amount Incl. VAT", InterfaceEntryLine."Line Amount" + InterfaceEntryLine."VAT Amount");

                //Check Top-Up Item
                IF CheckTopUpItem(InterfaceEntryLine."No.") THEN BEGIN
                    //Top-Up Account (-)
                    GenJournalLine.INIT;
                    GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                    GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                    GenJournalLine2.RESET;
                    GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                    GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                    IF GenJournalLine2.FINDLAST THEN
                        LineNo := GenJournalLine2."Line No." + 10000
                    ELSE
                        LineNo := 10000;
                    GenJournalLine.VALIDATE("Line No.", LineNo);
                    GenJournalLine.INSERT;

                    GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                    GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                    GenJournalLine.VALIDATE("Document No.", DocumentNo);
                    GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                    GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                    GenJournalLine.VALIDATE("Account No.", CounterpointInterfaceSetup."TopUp Account");
                    GenJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    GenJournalLine.VALIDATE(Amount, -InterfaceEntryLine."Amount Incl. VAT");
                    GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Sales Journal");
                    IF (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" <> 0) THEN
                        GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales VAT Code")
                    ELSE IF (InterfaceEntryLine."Tax Code" = 'ZERO') OR (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" = 0) THEN
                        GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales No VAT Code");
                    GenJournalLine.VALIDATE("Gen. Posting Type", GenJournalLine."Gen. Posting Type"::Sale);

                    //Dimensions
                    CLEAR(TempDimensionSetEntry);
                    DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");

                    //Item Dimensions
                    GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                    IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                    END;

                    //Location Dimensions
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

                    GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                    GenJournalLine.MODIFY;

                    //Accounts Receivables (+)
                    GenJournalLine.INIT;
                    GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                    GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                    GenJournalLine2.RESET;
                    GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                    GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                    IF GenJournalLine2.FINDLAST THEN
                        LineNo := GenJournalLine2."Line No." + 10000
                    ELSE
                        LineNo := 10000;
                    GenJournalLine.VALIDATE("Line No.", LineNo);
                    GenJournalLine.INSERT;

                    GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                    GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                    GenJournalLine.VALIDATE("Document No.", DocumentNo);
                    GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                    GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                    GenJournalLine.VALIDATE("Account No.", GetAccountReceivablesNo(InterfaceEntryLine."Location Code", FALSE));
                    GenJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    GenJournalLine.VALIDATE(Amount, InterfaceEntryLine."Amount Incl. VAT");
                    GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Sales Journal");
                    IF (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" <> 0) THEN
                        GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales VAT Code")
                    ELSE IF (InterfaceEntryLine."Tax Code" = 'ZERO') OR (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" = 0) THEN
                        GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales No VAT Code");
                    GenJournalLine.VALIDATE("Gen. Posting Type", GenJournalLine."Gen. Posting Type"::Sale);

                    //Dimensions
                    CLEAR(TempDimensionSetEntry);
                    DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");

                    //Item Dimensions
                    GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                    IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                    END;

                    //Location Dimensions
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

                    GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                    GenJournalLine.MODIFY;

                    //Top-Up Account (+) % AmountInclVAT
                    GenJournalLine.INIT;
                    GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                    GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                    GenJournalLine2.RESET;
                    GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                    GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                    IF GenJournalLine2.FINDLAST THEN
                        LineNo := GenJournalLine2."Line No." + 10000
                    ELSE
                        LineNo := 10000;
                    GenJournalLine.VALIDATE("Line No.", LineNo);
                    GenJournalLine.INSERT;

                    GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                    GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                    GenJournalLine.VALIDATE("Document No.", DocumentNo);
                    GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                    GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                    GenJournalLine.VALIDATE("Account No.", CounterpointInterfaceSetup."TopUp Account");
                    GenJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    GenJournalLine.VALIDATE(Amount, (CounterpointInterfaceSetup."TopUp Acc. Liability %" / 100) * InterfaceEntryLine."Amount Incl. VAT");
                    GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Sales Journal");
                    IF (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" <> 0) THEN
                        GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales VAT Code")
                    ELSE IF (InterfaceEntryLine."Tax Code" = 'ZERO') OR (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" = 0) THEN
                        GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales No VAT Code");
                    GenJournalLine.VALIDATE("Gen. Posting Type", GenJournalLine."Gen. Posting Type"::Sale);

                    //Dimensions
                    CLEAR(TempDimensionSetEntry);
                    DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");

                    //Item Dimensions
                    GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                    IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                    END;

                    //Location Dimensions
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

                    GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                    GenJournalLine.MODIFY;

                    //Top-Up Accrued Liabilities (-) % AmountInclVAT
                    GenJournalLine.INIT;
                    GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                    GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                    GenJournalLine2.RESET;
                    GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                    GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                    IF GenJournalLine2.FINDLAST THEN
                        LineNo := GenJournalLine2."Line No." + 10000
                    ELSE
                        LineNo := 10000;
                    GenJournalLine.VALIDATE("Line No.", LineNo);
                    GenJournalLine.INSERT;

                    GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                    GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                    GenJournalLine.VALIDATE("Document No.", DocumentNo);
                    GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                    GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                    GenJournalLine.VALIDATE("Account No.", CounterpointInterfaceSetup."TopUp Accrued Liabilities");
                    GenJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    GenJournalLine.VALIDATE(Amount, -(CounterpointInterfaceSetup."TopUp Acc. Liability %" / 100) * InterfaceEntryLine."Amount Incl. VAT");
                    GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Sales Journal");
                    IF (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" <> 0) THEN
                        GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales VAT Code")
                    ELSE IF (InterfaceEntryLine."Tax Code" = 'ZERO') OR (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" = 0) THEN
                        GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales No VAT Code");
                    GenJournalLine.VALIDATE("Gen. Posting Type", GenJournalLine."Gen. Posting Type"::Sale);

                    //Dimensions
                    CLEAR(TempDimensionSetEntry);
                    DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");

                    //Item Dimensions
                    GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                    IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                    END;

                    //Location Dimensions
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

                    GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                    GenJournalLine.MODIFY;

                END ELSE IF CheckExciseTaxItem(InterfaceEntryLine."No.") THEN BEGIN
                    //Sales Excise Account (-)
                    GenJournalLine.INIT;
                    GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                    GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                    GenJournalLine2.RESET;
                    GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                    GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                    IF GenJournalLine2.FINDLAST THEN
                        LineNo := GenJournalLine2."Line No." + 10000
                    ELSE
                        LineNo := 10000;
                    GenJournalLine.VALIDATE("Line No.", LineNo);
                    GenJournalLine.INSERT;

                    GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                    GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                    GenJournalLine.VALIDATE("Document No.", DocumentNo);
                    GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                    GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                    GenJournalLine.VALIDATE("Account No.", CounterpointInterfaceSetup."Sales Excise Tax");
                    GenJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    GenJournalLine.VALIDATE(Amount, -InterfaceEntryLine."Amount Incl. VAT");
                    GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Sales Journal");
                    IF (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" <> 0) THEN
                        GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales VAT Code")
                    ELSE IF (InterfaceEntryLine."Tax Code" = 'ZERO') OR (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" = 0) THEN
                        GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales No VAT Code");
                    GenJournalLine.VALIDATE("Gen. Posting Type", GenJournalLine."Gen. Posting Type"::Sale);

                    //Dimensions
                    CLEAR(TempDimensionSetEntry);
                    DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");

                    //Item Dimensions
                    GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                    IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                    END;

                    //Location Dimensions
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

                    GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                    GenJournalLine.MODIFY;

                    //Accounts Receivables (+)
                    GenJournalLine.INIT;
                    GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                    GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                    GenJournalLine2.RESET;
                    GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                    GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                    IF GenJournalLine2.FINDLAST THEN
                        LineNo := GenJournalLine2."Line No." + 10000
                    ELSE
                        LineNo := 10000;
                    GenJournalLine.VALIDATE("Line No.", LineNo);
                    GenJournalLine.INSERT;

                    GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                    GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                    GenJournalLine.VALIDATE("Document No.", DocumentNo);
                    GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                    GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                    GenJournalLine.VALIDATE("Account No.", GetAccountReceivablesNo(InterfaceEntryLine."Location Code", FALSE));
                    GenJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    GenJournalLine.VALIDATE(Amount, InterfaceEntryLine."Amount Incl. VAT");
                    GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Sales Journal");
                    IF (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" <> 0) THEN
                        GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales VAT Code")
                    ELSE IF (InterfaceEntryLine."Tax Code" = 'ZERO') OR (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" = 0) THEN
                        GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales No VAT Code");
                    GenJournalLine.VALIDATE("Gen. Posting Type", GenJournalLine."Gen. Posting Type"::Sale);

                    //Dimensions
                    CLEAR(TempDimensionSetEntry);
                    DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");

                    //Item Dimensions
                    GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                    IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                    END;

                    //Location Dimensions
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

                    GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                    GenJournalLine.MODIFY;

                END ELSE BEGIN
                    // Gross Sales GL Account (-)
                    GenJournalLine.INIT;
                    GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                    GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                    GenJournalLine2.RESET;
                    GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                    GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                    IF GenJournalLine2.FINDLAST THEN
                        LineNo := GenJournalLine2."Line No." + 10000
                    ELSE
                        LineNo := 10000;
                    GenJournalLine.VALIDATE("Line No.", LineNo);
                    GenJournalLine.INSERT;

                    GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                    GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                    GenJournalLine.VALIDATE("Document No.", DocumentNo);
                    GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                    GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                    //HEI.02>>
                    //GenJournalLine.VALIDATE("Account No.",GetSalesAccountNo(InterfaceEntryLine."HeiLite Item No."));
                    AccountNo := GetSalesAccountNo(InterfaceEntryLine."HeiLite Item No.");
                    GenJournalLine.VALIDATE("Account No.", AccountNo);
                    //HEI.02<<
                    GenJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Sales Journal");
                    IF (InterfaceEntryLine."Line Amount" <> 0) AND (InterfaceEntryLine."Amount Incl. VAT" <> 0) THEN BEGIN
                        IF (InterfaceEntryLine."Discount %" > 0) AND (InterfaceEntryLine."Discount %" < 100) THEN BEGIN
                            //GrossAmount := ROUND(InterfaceEntryLine."Line Amount" / (1-InterfaceEntryLine."Discount %" / 100),0.01);
                            GrossAmount := InterfaceEntryLine."Line Amount" / (1 - InterfaceEntryLine."Discount %" / 100);
                            IF InterfaceEntryLine."VAT Amount" <> 0 THEN BEGIN
                                GenJournalLine.VALIDATE(Amount, -(GrossAmount + GetVATPercentage(CounterpointInterfaceSetup."Sales VAT Code") * GrossAmount)); //discount
                                IF InterfaceEntryLine."Tax Code" = 'VAT' THEN
                                    GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales VAT Code")
                                ELSE IF InterfaceEntryLine."Tax Code" = 'ZERO' THEN
                                    GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales No VAT Code");
                                GenJournalLine.VALIDATE("Gen. Posting Type", GenJournalLine."Gen. Posting Type"::Sale);
                            END ELSE
                                GenJournalLine.VALIDATE(Amount, -GrossAmount);
                        END ELSE BEGIN //no discounts
                            GenJournalLine.VALIDATE(Amount, -InterfaceEntryLine."Amount Incl. VAT");
                            IF (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" <> 0) THEN
                                GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales VAT Code")
                            ELSE IF (InterfaceEntryLine."Tax Code" = 'ZERO') OR (InterfaceEntryLine."Tax Code" = 'VAT') AND (InterfaceEntryLine."VAT Amount" = 0) THEN
                                GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales No VAT Code");
                            GenJournalLine.VALIDATE("Gen. Posting Type", GenJournalLine."Gen. Posting Type"::Sale);
                        END;
                    END ELSE BEGIN //free item
                        GenJournalLine.VALIDATE(Amount, -(InterfaceEntryLine.Quantity * InterfaceEntryLine."Unit Amount"));
                        //GenJournalLine.VALIDATE(Amount,-(InterfaceEntryLine.Quantity * InterfaceEntryLine."Unit Amount" +
                        //GetVATPercentage(CounterpointInterfaceSetup."Sales VAT Code") * InterfaceEntryLine.Quantity * InterfaceEntryLine."Unit Amount"));
                        IF InterfaceEntryLine."Discount %" <> 100 THEN BEGIN
                            IF InterfaceEntryLine."Tax Code" = 'VAT' THEN
                                GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales VAT Code")
                            ELSE IF InterfaceEntryLine."Tax Code" = 'ZERO' THEN
                                GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales No VAT Code");
                            GenJournalLine.VALIDATE("Gen. Posting Type", GenJournalLine."Gen. Posting Type"::Sale);
                        END;

                    END;

                    //Dimensions
                    CLEAR(TempDimensionSetEntry);
                    DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");
                    GetItemDimensions(InterfaceEntryLine."HeiLite Item No.", TempDimensionSetEntry);

                    //Item Dimensions
                    GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                    IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                    END;

                    //Location Dimensions
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

                    GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                    GenJournalLine.MODIFY;

                    // Loyalty
                    // Deferred Revenue Loyalty (-)
                    IF InterfaceEntryLine."Loyalty Amount" <> 0 THEN BEGIN
                        GenJournalLine.INIT;
                        GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                        GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                        GenJournalLine2.RESET;
                        GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                        GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                        IF GenJournalLine2.FINDLAST THEN
                            LineNo := GenJournalLine2."Line No." + 10000
                        ELSE
                            LineNo := 10000;
                        GenJournalLine.VALIDATE("Line No.", LineNo);
                        GenJournalLine.INSERT;

                        GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                        GenJournalLine.VALIDATE("Document No.", DocumentNo);
                        GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                        GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                        GenJournalLine.VALIDATE("Account No.", CounterpointInterfaceSetup."Loyalty Deferred Revenue");
                        GenJournalLine.VALIDATE(Amount, -InterfaceEntryLine."Loyalty Amount");
                        GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Sales Journal");

                        //Dimensions
                        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");
                        GetItemDimensions(InterfaceEntryLine."HeiLite Item No.", TempDimensionSetEntry);

                        //Investment Level Dimension
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := CounterpointInterfaceSetup."Investment Level Dimension";
                        TempDimensionSetEntry."Dimension Value Code" := CounterpointInterfaceSetup."Investment Level Dim Value";
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;

                        //Item Dimensions
                        GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                        IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                            TempDimensionSetEntry.INIT;
                            TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                            TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                            IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                        END;

                        //Location Dimensions
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

                        GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                        GenJournalLine.MODIFY;

                        // Sales Reductions Loyalty (+)
                        GenJournalLine.INIT;
                        GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                        GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                        GenJournalLine2.RESET;
                        GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                        GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                        IF GenJournalLine2.FINDLAST THEN
                            LineNo := GenJournalLine2."Line No." + 10000
                        ELSE
                            LineNo := 10000;
                        GenJournalLine.VALIDATE("Line No.", LineNo);
                        GenJournalLine.INSERT;

                        GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                        GenJournalLine.VALIDATE("Document No.", DocumentNo);
                        GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                        GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                        GenJournalLine.VALIDATE("Account No.", CounterpointInterfaceSetup."Loyalty Sales Reduction TPR");
                        GenJournalLine.VALIDATE(Amount, InterfaceEntryLine."Loyalty Amount");
                        GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Sales Journal");

                        //Dimensions
                        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");
                        GetItemDimensions(InterfaceEntryLine."HeiLite Item No.", TempDimensionSetEntry);

                        //Investment Level Dimension
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := CounterpointInterfaceSetup."Investment Level Dimension";
                        TempDimensionSetEntry."Dimension Value Code" := CounterpointInterfaceSetup."Investment Level Dim Value";
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;

                        //Item Dimensions
                        GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                        IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                            TempDimensionSetEntry.INIT;
                            TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                            TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                            IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                        END;

                        //Location Dimensions
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

                        GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                        GenJournalLine.MODIFY;
                    END;

                    // Account Receivables (+)
                    // Free Item (+)
                    IF InterfaceEntryLine."Discount %" = 100 THEN BEGIN
                        GenJournalLine.INIT;
                        GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                        GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                        GenJournalLine2.RESET;
                        GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                        GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                        IF GenJournalLine2.FINDLAST THEN
                            LineNo := GenJournalLine2."Line No." + 10000
                        ELSE
                            LineNo := 10000;
                        GenJournalLine.VALIDATE("Line No.", LineNo);
                        GenJournalLine.INSERT;

                        GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                        GenJournalLine.VALIDATE("Document No.", DocumentNo);
                        GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                        GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                        GenJournalLine.VALIDATE("Account No.", GetDiscSalesAccountNo(InterfaceEntryLine."HeiLite Item No."));
                        GenJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                        IF (InterfaceEntryLine."Amount Incl. VAT" = 0) AND (InterfaceEntryLine."Tax Code" = 'VAT') THEN
                            FreeItemAmount := InterfaceEntryLine.Quantity * InterfaceEntryLine."Unit Amount"
                        // + GetVATPercentage(CounterpointInterfaceSetup."Sales VAT Code") * InterfaceEntryLine.Quantity * InterfaceEntryLine."Unit Amount"
                        ELSE
                            FreeItemAmount := InterfaceEntryLine."Amount Incl. VAT";
                        GenJournalLine.VALIDATE(Amount, FreeItemAmount);
                        GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Sales Journal");
                        /*IF InterfaceEntryLine."Tax Code" = 'VAT' THEN BEGIN
                          GenJournalLine.VALIDATE("VAT Prod. Posting Group",CounterpointInterfaceSetup."Sales VAT Code");
                          GenJournalLine.VALIDATE("Gen. Posting Type",GenJournalLine."Gen. Posting Type"::Sale);
                        END;*/

                        //Dimensions
                        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");
                        GetItemDimensions(InterfaceEntryLine."HeiLite Item No.", TempDimensionSetEntry);

                        //Investment Level Dimension
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := CounterpointInterfaceSetup."Investment Level Dimension";
                        TempDimensionSetEntry."Dimension Value Code" := CounterpointInterfaceSetup."Investment Level Dim Value";
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;

                        //Item Dimensions
                        GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                        IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                            TempDimensionSetEntry.INIT;
                            TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                            TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                            IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                        END;

                        //Location Dimensions
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

                        GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                        GenJournalLine.MODIFY;

                    END ELSE BEGIN
                        // Discounts (+)
                        GenJournalLine.INIT;
                        GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                        GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                        GenJournalLine2.RESET;
                        GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                        GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                        IF GenJournalLine2.FINDLAST THEN
                            LineNo := GenJournalLine2."Line No." + 10000
                        ELSE
                            LineNo := 10000;
                        GenJournalLine.VALIDATE("Line No.", LineNo);
                        GenJournalLine.INSERT;

                        GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                        GenJournalLine.VALIDATE("Document No.", DocumentNo);
                        GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                        GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                        GenJournalLine.VALIDATE("Account No.", GetAccountReceivablesNo(InterfaceEntryLine."Location Code", FALSE));
                        GenJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                        GenJournalLine.VALIDATE(Amount, InterfaceEntryLine."Amount Incl. VAT");
                        GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Sales Journal");

                        //Dimensions
                        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");
                        GetItemDimensions(InterfaceEntryLine."HeiLite Item No.", TempDimensionSetEntry);

                        //Investment Level Dimension
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := CounterpointInterfaceSetup."Investment Level Dimension";
                        TempDimensionSetEntry."Dimension Value Code" := CounterpointInterfaceSetup."Investment Level Dim Value";
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;

                        //Item Dimensions
                        GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                        IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                            TempDimensionSetEntry.INIT;
                            TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                            TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                            IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                        END;

                        //Location Dimensions
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

                        GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                        GenJournalLine.MODIFY;

                        // Discount GL Account (+)
                        IF (InterfaceEntryLine."Discount %" > 0) AND (InterfaceEntryLine."Discount %" < 100) THEN BEGIN
                            GenJournalLine.INIT;
                            GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                            GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                            GenJournalLine2.RESET;
                            GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                            GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                            IF GenJournalLine2.FINDLAST THEN
                                LineNo := GenJournalLine2."Line No." + 10000
                            ELSE
                                LineNo := 10000;
                            GenJournalLine.VALIDATE("Line No.", LineNo);
                            GenJournalLine.INSERT;

                            GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                            GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Invoice);
                            GenJournalLine.VALIDATE("Document No.", DocumentNo);
                            GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                            GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                            GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                            GenJournalLine.VALIDATE("Account No.", GetDiscSalesAccountNo(InterfaceEntryLine."HeiLite Item No."));
                            GenJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                            GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Sales Journal");
                            //DiscountAmount := ROUND(InterfaceEntryLine."Discount %" / 100 * GrossAmount,0.01);
                            DiscountAmount := InterfaceEntryLine."Discount %" / 100 * GrossAmount;
                            IF InterfaceEntryLine."VAT Amount" <> 0 THEN BEGIN
                                GenJournalLine.VALIDATE(Amount, DiscountAmount + GetVATPercentage(CounterpointInterfaceSetup."Sales VAT Code") * DiscountAmount); //discount
                                                                                                                                                                  //GenJournalLine.VALIDATE(Amount,ROUND((DiscountAmount + GetVATPercentage(CounterpointInterfaceSetup."Sales VAT Code") * DiscountAmount),0.01));
                                IF InterfaceEntryLine."Tax Code" = 'VAT' THEN
                                    GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales VAT Code")
                                ELSE IF InterfaceEntryLine."Tax Code" = 'ZERO' THEN
                                    GenJournalLine.VALIDATE("VAT Prod. Posting Group", CounterpointInterfaceSetup."Sales No VAT Code");
                                GenJournalLine.VALIDATE("Gen. Posting Type", GenJournalLine."Gen. Posting Type"::Sale);
                            END ELSE
                                GenJournalLine.VALIDATE(Amount, DiscountAmount);

                            //Dimensions
                            DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");
                            GetItemDimensions(InterfaceEntryLine."HeiLite Item No.", TempDimensionSetEntry);

                            //Investment Level Dimension
                            TempDimensionSetEntry.INIT;
                            TempDimensionSetEntry."Dimension Code" := CounterpointInterfaceSetup."Investment Level Dimension";
                            TempDimensionSetEntry."Dimension Value Code" := CounterpointInterfaceSetup."Investment Level Dim Value";
                            IF TempDimensionSetEntry.INSERT(TRUE) THEN;

                            //Item Dimensions
                            GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                            IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                                TempDimensionSetEntry.INIT;
                                TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                                TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                                IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                            END;

                            //Location Dimensions
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

                            GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                            GenJournalLine.MODIFY;

                            //HEI.02>>
                            GenJournalLine4.RESET;
                            GenJournalLine4.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                            GenJournalLine4.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                            GenJournalLine4.SETRANGE("Document No.", DocumentNo);
                            IF GenJournalLine4.FINDSET THEN BEGIN
                                REPEAT
                                    TotalAmount += GenJournalLine4.Amount;
                                UNTIL GenJournalLine4.NEXT = 0;

                                GenJournalLine5.RESET;
                                GenJournalLine5.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."Sales Gen. Journal Template");
                                GenJournalLine5.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."Sales Gen. Journal Batch");
                                GenJournalLine5.SETRANGE("Document No.", DocumentNo);
                                GenJournalLine5.SETRANGE("Account No.", AccountNo);
                                IF GenJournalLine5.FINDFIRST AND (TotalAmount <> 0) THEN BEGIN
                                    GenJournalLine5.VALIDATE(Amount, GenJournalLine5.Amount - TotalAmount);
                                    GenJournalLine5.MODIFY;
                                END;
                            END;
                            //HEI.02<<

                        END;
                    END;
                END;

                IF NOT CheckTopUpItem(InterfaceEntryLine."No.") AND NOT CheckExciseTaxItem(InterfaceEntryLine."No.") THEN BEGIN
                    //COGS posting
                    InterfaceEntryLine.CALCFIELDS("HeiLite Item No.");
                    InterfaceEntryLine.CALCFIELDS("HeiLite Location Code");

                    //Delete existing empty lines
                    ItemJournalLine3.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."COGS Item Journal Template");
                    ItemJournalLine3.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."COGS Item Journal Batch");
                    ItemJournalLine3.SETRANGE("Item No.", '');
                    IF ItemJournalLine3.FINDSET THEN
                        REPEAT
                            ItemJournalLine3.DELETE;
                        UNTIL ItemJournalLine3.NEXT = 0;

                    ItemJournalLine.INIT;
                    ItemJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."COGS Item Journal Template");
                    ItemJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."COGS Item Journal Batch");
                    ItemJournalLine2.RESET;
                    ItemJournalLine2.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."COGS Item Journal Template");
                    ItemJournalLine2.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."COGS Item Journal Batch");
                    IF ItemJournalLine2.FINDLAST THEN
                        LineNo := ItemJournalLine2."Line No." + 10000
                    ELSE
                        LineNo := 10000;
                    ItemJournalLine.VALIDATE("Line No.", LineNo);
                    ItemJournalLine.INSERT(TRUE); //HEI.02

                    ItemJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                    ItemJournalLine.VALIDATE("Document No.", COGSDocumentNo);
                    ItemJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                    ItemJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                    ItemJournalLine.VALIDATE("Item No.", InterfaceEntryLine."HeiLite Item No.");
                    ItemJournalLine.VALIDATE("Gen. Bus. Posting Group", ItemJournalTemplate."Def. Gen. Bus. Posting Group FND"); //BCUP0-92 PATHAA02 09.07.27
                    ItemJournalLine.VALIDATE(Description, GetItemNoDescription(InterfaceEntryLine."HeiLite Item No."));
                    ItemJournalLine.VALIDATE("Location Code", InterfaceEntryLine."HeiLite Location Code");
                    ItemJournalLine.VALIDATE("Zone Code FND", CounterpointInterfaceSetup."Zone Code");
                    ItemJournalLine.VALIDATE("Bin Code", CounterpointInterfaceSetup."Bin Code");
                    IF InterfaceEntryLine.Quantity > 0 THEN BEGIN
                        ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
                        ItemJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                        ItemJournalLine.VALIDATE("Unit of Measure Code", CounterpointInterfaceSetup."Item UoM Retail");
                        // BC Upgrade BHARDA11 >> ----Drink-IT Function(SetHideFEFOMessage,FEFOTracking)
                        // ItemJournalLine.SetHideFEFOMessage(TRUE);
                        // ItemJournalLine.FEFOTracking(FALSE);
                        // BC Upgrade BHARDA11 << ----Drink-IT Function(SetHideFEFOMessage,FEFOTracking)
                    END ELSE BEGIN
                        ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                        ItemJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                        ItemJournalLine.VALIDATE("Unit of Measure Code", CounterpointInterfaceSetup."Item UoM Retail");
                        CounterpointInterfaceMgmt.CreateReservationEntry(ItemJournalLine);
                    END;
                    UpdateReservationEntry(ItemJournalLine);

                    ItemJournalLine."Source Code" := SourceCodeSetup."Item Journal";
                    ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Sale;
                    //HEI.03>>
                    IF (InterfaceEntryLine."VAT Amount" <> 0) OR
                       ((InterfaceEntryLine."Discount %" <> 0) AND (InterfaceEntryLine."Discount %" <> 100)) OR
                       (InterfaceEntryLine.Quantity < 0) OR
                       (InterfaceEntryLine."Loyalty Amount" <> 0)
                    THEN
                        ItemJournalLine.VALIDATE("Unit Amount", InterfaceEntryLine."Unit Amount" / (1 - InterfaceEntryLine."Discount %" / 100) / InterfaceEntryLine.Quantity)
                    ELSE
                        ItemJournalLine.VALIDATE("Unit Amount", InterfaceEntryLine."Unit Amount");
                    //HEI.03<<

                    //Dimensions
                    CLEAR(TempDimensionSetEntry);
                    DimensionManagement.GetDimensionSet(TempDimensionSetEntry, ItemJournalLine."Dimension Set ID");
                    GetItemDimensions(InterfaceEntryLine."HeiLite Item No.", TempDimensionSetEntry);

                    //Item Dimensions
                    GetDimensionItemMappingCP(InterfaceEntryLine."HeiLite Item No.");
                    IF (ItemDimensionCode <> '') OR (ItemDimensionValue <> '') THEN BEGIN
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry."Dimension Code" := ItemDimensionCode;
                        TempDimensionSetEntry."Dimension Value Code" := ItemDimensionValue;
                        IF TempDimensionSetEntry.INSERT(TRUE) THEN;
                    END;

                    //Location Dimensions
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

                    CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine);
                END;

                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
            UNTIL InterfaceEntryLine.NEXT = 0;

        END;

        IF SimulationMode THEN BEGIN
            InterfaceEntryHeader."Simulation Done" := TRUE;
            InterfaceEntryHeader.MODIFY;
        END;

    end;

    procedure ProcessPayments(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        DimensionManagement: Codeunit DimensionManagement;
        SourceCodeSetup: Record "Source Code Setup";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        GenJournalLine3: Record "Gen. Journal Line";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        GenJournalBatch: Record "Gen. Journal Batch";
        DocumentNo: Code[20];
        LineNo: Integer;
    begin
        //Payments
        GetGeneralInterfaceSetup;
        SourceCodeSetup.GET;
        GetCounterpointInterfaceSetup;

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN BEGIN
            CLEAR(GenJournalLine);
            GenJournalBatch.GET(CounterpointInterfaceSetup."Payments Gen. Jnl Template", CounterpointInterfaceSetup."Payments Gen. Jnl Batch");
            DocumentNo := PaymentsNoSeriesMgt.GetNextNo(GenJournalBatch."No. Series", InterfaceEntryLine."Posting Date", FALSE);

            //Delete existing empty lines
            GenJournalLine3.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."Payments Gen. Jnl Template");
            GenJournalLine3.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."Payments Gen. Jnl Batch");
            IF GenJournalLine3.FINDFIRST THEN
                GenJournalLine3.DELETEALL;

            REPEAT
                InterfaceEntryLine.CALCFIELDS("HeiLite Item No.");
                InterfaceEntryLine.CALCFIELDS("HeiLite Location Code");

                // Account Receivables - Location (-)
                GenJournalLine.INIT;
                GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Payments Gen. Jnl Template");
                GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Payments Gen. Jnl Batch");
                GenJournalLine2.RESET;
                GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                IF GenJournalLine2.FINDLAST THEN
                    LineNo := GenJournalLine2."Line No." + 10000
                ELSE
                    LineNo := 10000;
                GenJournalLine.VALIDATE("Line No.", LineNo);
                GenJournalLine.INSERT;

                GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
                GenJournalLine.VALIDATE("Document No.", DocumentNo);
                GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                GenJournalLine.VALIDATE("Account No.", GetAccountReceivablesNo(InterfaceEntryLine."Location Code", FALSE));
                GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Payment Journal");
                GenJournalLine.VALIDATE(Amount, -InterfaceEntryLine."Line Amount");
                GenJournalLine.VALIDATE(Comment, InterfaceEntryLine.Reference);  //HEI.04

                //Dimensions
                DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");
                GetDimensionLocationMappingCP(InterfaceEntryLine."HeiLite Location Code");
                TempDimensionSetEntry.INIT;
                TempDimensionSetEntry."Dimension Code" := CCCDimensionCode;
                TempDimensionSetEntry."Dimension Value Code" := CCCDimensionValue;
                IF TempDimensionSetEntry.INSERT(TRUE) THEN;

                GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                GenJournalLine.MODIFY;

                //Payment GL Account - Pay Method (+)
                GenJournalLine.INIT;
                GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Payments Gen. Jnl Template");
                GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Payments Gen. Jnl Batch");
                GenJournalLine2.RESET;
                GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                IF GenJournalLine2.FINDLAST THEN
                    LineNo := GenJournalLine2."Line No." + 10000
                ELSE
                    LineNo := 10000;
                GenJournalLine.VALIDATE("Line No.", LineNo);
                GenJournalLine.INSERT;

                GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
                GenJournalLine.VALIDATE("Document No.", DocumentNo);
                GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                GenJournalLine.VALIDATE("Account No.", GetPaymentGLAccount(InterfaceEntryLine."Payment Terms Code", InterfaceEntryLine."HeiLite Location Code"));
                GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Payment Journal");
                GenJournalLine.VALIDATE(Amount, InterfaceEntryLine."Line Amount");
                GenJournalLine.VALIDATE(Comment, InterfaceEntryLine.Reference);  //HEI.04

                //Dimensions
                DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");
                GetDimensionLocationMappingCP(InterfaceEntryLine."HeiLite Location Code");
                TempDimensionSetEntry.INIT;
                TempDimensionSetEntry."Dimension Code" := CCCDimensionCode;
                TempDimensionSetEntry."Dimension Value Code" := CCCDimensionValue;
                IF TempDimensionSetEntry.INSERT(TRUE) THEN;

                GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                GenJournalLine.MODIFY;
            UNTIL InterfaceEntryLine.NEXT = 0;

            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);

        END;

        IF SimulationMode THEN BEGIN
            InterfaceEntryHeader."Simulation Done" := TRUE;
            InterfaceEntryHeader.MODIFY;
        END;
    end;

    procedure ProcessPayouts(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        DimensionManagement: Codeunit DimensionManagement;
        SourceCodeSetup: Record "Source Code Setup";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLine2: Record "Interface Entry Line INT";
        InterfaceEntryLine3: Record "Interface Entry Line INT";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        GenJournalLine3: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DocumentNo: Code[20];
        TicketNo: Code[20];
        TotalAmount: Decimal;
        LineNo: Integer;
    begin
        //Payouts
        GetGeneralInterfaceSetup;
        SourceCodeSetup.GET;
        GetCounterpointInterfaceSetup;

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN BEGIN
            CLEAR(GenJournalLine);
            GenJournalBatch.GET(CounterpointInterfaceSetup."Payouts Gen. Journal Template", CounterpointInterfaceSetup."Payouts Gen. Journal Batch");
            DocumentNo := PayoutsNoSeriesMgt.GetNextNo(GenJournalBatch."No. Series", InterfaceEntryLine."Posting Date", FALSE);

            //Delete existing empty lines
            GenJournalLine3.SETRANGE("Journal Template Name", CounterpointInterfaceSetup."Payouts Gen. Journal Template");
            GenJournalLine3.SETRANGE("Journal Batch Name", CounterpointInterfaceSetup."Payouts Gen. Journal Batch");
            IF GenJournalLine3.FINDSET THEN
                GenJournalLine3.DELETEALL;

            REPEAT
                /*
                IF TicketNo = InterfaceEntryLine."External Document No." THEN BEGIN
                  InterfaceEntryLine3.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");
                  InterfaceEntryLine3.SETRANGE("Location Code",InterfaceEntryLine."Location Code");
                  InterfaceEntryLine3.SETRANGE("Posting Date",InterfaceEntryLine."Posting Date");
                  InterfaceEntryLine3.SETRANGE("External Document No.",TicketNo);
                  IF InterfaceEntryLine3.FINDLAST THEN
                    InterfaceEntryLine := InterfaceEntryLine3;
                END ELSE BEGIN
                  TotalAmount := 0;
                  InterfaceEntryLine2.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");
                  InterfaceEntryLine2.SETRANGE("Location Code",InterfaceEntryLine."Location Code");
                  InterfaceEntryLine2.SETRANGE("Posting Date",InterfaceEntryLine."Posting Date");
                  InterfaceEntryLine2.SETRANGE("External Document No.",InterfaceEntryLine."External Document No.");
                  IF InterfaceEntryLine2.FINDSET THEN BEGIN
                    TicketNo := InterfaceEntryLine."External Document No.";
                    REPEAT
                      TotalAmount += InterfaceEntryLine2."Line Amount";
                    UNTIL InterfaceEntryLine2.NEXT = 0;
                  END;

                  IF TotalAmount >= 0 THEN
                    ERROR(NegativeTotalAmtErr,InterfaceEntryLine."External Document No.",TotalAmount);
                  */

                InterfaceEntryLine.CALCFIELDS("HeiLite Item No.");
                InterfaceEntryLine.CALCFIELDS("HeiLite Location Code");

                // Bank Account - Location (-)
                GenJournalLine.INIT;
                GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Payouts Gen. Journal Template");
                GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Payouts Gen. Journal Batch");
                GenJournalLine2.RESET;
                GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                IF GenJournalLine2.FINDLAST THEN
                    LineNo := GenJournalLine2."Line No." + 10000
                ELSE
                    LineNo := 10000;
                GenJournalLine.VALIDATE("Line No.", LineNo);
                GenJournalLine.INSERT;

                GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::" ");
                GenJournalLine.VALIDATE("Document No.", DocumentNo);
                GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                GenJournalLine.VALIDATE("Account No.", GetAccountReceivablesNo(InterfaceEntryLine."Location Code", TRUE));
                //GenJournalLine.VALIDATE(Amount,TotalAmount);
                GenJournalLine.VALIDATE(Amount, InterfaceEntryLine."Line Amount");
                GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Payment Journal");

                //Dimensions
                DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");
                GetDimensionLocationMappingCP(InterfaceEntryLine."HeiLite Location Code");
                TempDimensionSetEntry.INIT;
                TempDimensionSetEntry."Dimension Code" := CCCDimensionCode;
                TempDimensionSetEntry."Dimension Value Code" := CCCDimensionValue;
                IF TempDimensionSetEntry.INSERT(TRUE) THEN;

                GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                GenJournalLine.MODIFY;

                //Other Expenses (+)
                GenJournalLine.INIT;
                GenJournalLine.VALIDATE("Journal Template Name", CounterpointInterfaceSetup."Payouts Gen. Journal Template");
                GenJournalLine.VALIDATE("Journal Batch Name", CounterpointInterfaceSetup."Payouts Gen. Journal Batch");
                GenJournalLine2.RESET;
                GenJournalLine2.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                GenJournalLine2.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                IF GenJournalLine2.FINDLAST THEN
                    LineNo := GenJournalLine2."Line No." + 10000
                ELSE
                    LineNo := 10000;
                GenJournalLine.VALIDATE("Line No.", LineNo);
                GenJournalLine.INSERT;

                GenJournalLine.VALIDATE("Interface Code FND", InterfaceEntryHeader."Interface Code");
                GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::" ");
                GenJournalLine.VALIDATE("Document No.", DocumentNo);
                GenJournalLine.VALIDATE("External Document No.", InterfaceEntryLine."External Document No.");
                GenJournalLine.VALIDATE("Posting Date", InterfaceEntryLine."Posting Date");
                GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                GenJournalLine.VALIDATE("Account No.", CounterpointInterfaceSetup."Other Expenses");
                //GenJournalLine.VALIDATE(Amount,-TotalAmount);
                GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Payment Journal");
                GenJournalLine.VALIDATE(Amount, -InterfaceEntryLine."Line Amount");

                //Dimensions
                DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GenJournalLine."Dimension Set ID");
                GetDimensionLocationMappingCP(InterfaceEntryLine."HeiLite Location Code");
                TempDimensionSetEntry.INIT;
                TempDimensionSetEntry."Dimension Code" := CCCDimensionCode;
                TempDimensionSetEntry."Dimension Value Code" := CCCDimensionValue;
                IF TempDimensionSetEntry.INSERT(TRUE) THEN;

                GenJournalLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(TempDimensionSetEntry));
                GenJournalLine.MODIFY;
            //END;
            UNTIL InterfaceEntryLine.NEXT = 0;

            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);

        END;

        IF SimulationMode THEN BEGIN
            InterfaceEntryHeader."Simulation Done" := TRUE;
            InterfaceEntryHeader.MODIFY;
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

    local procedure GetItemDimensions(ItemNo: Code[20]; var TempDimensionSetEntry: Record "Dimension Set Entry" temporary);
    var
        DefaultDimension: Record "Default Dimension";
    begin
        DefaultDimension.SETRANGE("Table ID", DATABASE::Item);
        DefaultDimension.SETRANGE("No.", ItemNo);
        IF DefaultDimension.FINDSET THEN
            REPEAT
                TempDimensionSetEntry.INIT;
                TempDimensionSetEntry."Dimension Code" := DefaultDimension."Dimension Code";
                TempDimensionSetEntry."Dimension Value Code" := DefaultDimension."Dimension Value Code";
                IF TempDimensionSetEntry.INSERT(TRUE) THEN;
            UNTIL DefaultDimension.NEXT = 0;
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

    local procedure GetSalesAccountNo(ItemNo: Code[20]): Code[20];
    var
        ItemMappingCp: Record "Item Mapping CP FND";
    begin
        ItemMappingCp.SETRANGE("Heilite Item ID", ItemNo);
        IF ItemMappingCp.FINDFIRST THEN
            EXIT(ItemMappingCp."Item Sales Account");
    end;

    local procedure GetDiscSalesAccountNo(ItemNo: Code[20]): Code[20];
    var
        ItemMappingCp: Record "Item Mapping CP FND";
    begin
        ItemMappingCp.SETRANGE("Heilite Item ID", ItemNo);
        IF ItemMappingCp.FINDFIRST THEN
            EXIT(ItemMappingCp."Item Sales Discount");
    end;

    local procedure GetAccountReceivablesNo(LocationNo: Code[20]; Payout: Boolean): Code[20];
    var
        LocationMappingCP: Record "Location Mapping CP FND";
    begin
        LocationMappingCP.SETRANGE("CP Store Code", LocationNo);
        IF LocationMappingCP.FINDFIRST THEN
            IF Payout THEN
                EXIT(LocationMappingCP."Payouts Bank Account")
            ELSE
                EXIT(LocationMappingCP."Accounts Receivables");
    end;

    local procedure GetPaymentGLAccount(CPCode: Code[20]; LocationCode: Code[20]): Code[20];
    var
        PaymentMethodMappingCP: Record "Payment Method Mapping CP FND";
    begin
        IF PaymentMethodMappingCP.GET(CPCode, LocationCode) THEN
            EXIT(PaymentMethodMappingCP."Payment GL Account");
    end;

    local procedure GetVATPercentage(VATProdPostingGroup: Code[10]): Decimal;
    var
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        VATPostingSetup.SETRANGE("VAT Prod. Posting Group", VATProdPostingGroup);
        IF VATPostingSetup.FINDFIRST THEN
            EXIT(VATPostingSetup."VAT %" / 100);
    end;

    local procedure CheckTopUpItem(ItemNo: Code[20]): Boolean;
    var
        ItemMappingCP: Record "Item Mapping CP FND";
    begin
        ItemMappingCP.SETRANGE("CP Item ID", ItemNo);
        IF ItemMappingCP.FINDFIRST THEN
            EXIT(ItemMappingCP."Top-Up Item");
    end;

    local procedure CheckExciseTaxItem(ItemNo: Code[20]): Boolean;
    var
        ItemMappingCP: Record "Item Mapping CP FND";
    begin
        ItemMappingCP.SETRANGE("CP Item ID", ItemNo);
        IF ItemMappingCP.FINDFIRST THEN
            EXIT(ItemMappingCP."Excise Tax Item");
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
                ReservationEntry."Source Subtype" := ItemJournalLine."Entry Type"::Sale.AsInteger();
                IF ItemJournalLine.Quantity < 0 THEN BEGIN
                    ReservationEntry."Qty. to Handle (Base)" := -ItemJournalLine.Quantity;
                    ReservationEntry."Qty. to Invoice (Base)" := -ItemJournalLine.Quantity;
                END;
                ReservationEntry.MODIFY;
            UNTIL ReservationEntry.NEXT = 0;
    end;
}

