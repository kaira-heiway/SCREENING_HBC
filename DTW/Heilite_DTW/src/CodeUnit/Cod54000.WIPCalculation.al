codeunit 54000 "WIP Calculation"
{
    // version HEI.02
    //BC Upgrade Kamnay01 Original(Heilite) CU id 50097
    // ID       Date           DEV        RFC #                  Description
    // -----------------------------------------------------------------------
    // HEI.01  02.04.2020 IBM.Ak CHG2060993
    // # New Codeunit
    // # Logic built previously for capacity is completely removed, new logic is built on o/p-i/p
    // # Changed all the calculations of Functions-material used, Material value, output value used & CalculateValue based on the discussion with Mahir/Imen
    // # Logic added for Include only posted entries boolean
    // # Dimensions for each Production order-->value entries (ILE type-O/P) to flow to General Journal lines
    // HEI.02 CHG2118099 IBM PATHAA02 11.05.22
    //  # Removed second comment from HEI01 Errorcombinations
    //  # Entries with zero amount should be filtered out in the journal lines


    trigger OnRun();
    begin
    end;

    var
        JournalTemplate: Code[20];
        JournalBatch: Code[20];
        LineNos: Integer;
        PostingDate: Date;
        Typo: Option Material,Capacity;
        MaterialPercentages: Decimal;
        CapacityPercentages: Decimal;
        ErrorCombinations: Text;
        DocumentCode: Code[20];
        HEI01: Label '%1  Lines have been added to the Journal.';
        Inserts: Integer;
        FilteronZone: Boolean;
        HEI02: Label '%1 Lines have been added to the journal. Many Production orders could not be processed due to missing information';
        InitalPosting: Boolean;
        //CalendarMgt : Codeunit CalendarManagement;//Bc Upgrade YADAVM09 object not used anywhere in the code
        IncludeEntries: Boolean;
        recgenjnltemplate: Record "Gen. Journal Template";
        recvalueentry: Record "Value Entry";

    local procedure CalculateMaterialValue(ProdOrderCode: Code[20]) MatValue: Decimal;
    var
        BOMVersion: Record "Production BOM Version";
        BOMLines: Record "Production BOM Line";
        ProdOrderComponentLines: Record "Prod. Order Component";
        ProdOrderLine: Record "Prod. Order Line";
    begin
        // find the value based on Components lines
        CLEAR(MatValue);
        if IncludeEntries then
            exit(0);
        ProdOrderLine.SETRANGE(ProdOrderLine.Status, ProdOrderLine.Status::Released);
        ProdOrderLine.SETRANGE("Prod. Order No.", ProdOrderCode);
        if ProdOrderLine.findset() then
            repeat
                ProdOrderComponentLines.SETRANGE(ProdOrderComponentLines.Status, ProdOrderComponentLines.Status::Released);
                ProdOrderComponentLines.SETRANGE("Prod. Order No.", ProdOrderLine."Prod. Order No.");
                ProdOrderComponentLines.SETRANGE(ProdOrderComponentLines."Prod. Order Line No.", ProdOrderLine."Line No.");
                if ProdOrderComponentLines.findset() then
                    repeat
                        MatValue += (ProdOrderComponentLines."Remaining Quantity" * ProdOrderComponentLines."Unit Cost");
                    until ProdOrderComponentLines.NEXT() = 0
            until ProdOrderLine.NEXT() = 0;
        //MESSAGE('%1',MatValue);
        exit(MatValue);
    end;

    local procedure CalculateMaterialUsed(ProdOrderCode: Code[20]) MatUsed: Decimal;
    var
        ValueEntries: Record "Value Entry";
    begin
        CLEAR(MatUsed);
        // Based on Valanue entries we can calculate what is consumed
        //IF NOT IncludeEntries THEN
        //EXIT(0);

        ValueEntries.SETRANGE(ValueEntries."Item Ledger Entry Type", ValueEntries."Item Ledger Entry Type"::Consumption);
        ValueEntries.SETRANGE(ValueEntries."Document No.", ProdOrderCode);
        ValueEntries.SETRANGE(Adjustment, false);
        if ValueEntries.findset() then
            repeat
                MatUsed += (ValueEntries."Cost Amount (Actual)" + ValueEntries."Cost Amount (Expected)") * -1;
            until ValueEntries.NEXT() = 0;
        //MESSAGE('%1',MatUsed);
        exit(MatUsed);
    end;

    local procedure CalculateOutputValue(ProdOrderCode: Code[20]) OutputValue: Decimal;
    var
        ProdOrderLine: Record "Prod. Order Line";
    begin
        // find the o/p value on prod orderlines
        CLEAR(OutputValue);
        if IncludeEntries then
            exit(0);
        ProdOrderLine.SETRANGE(ProdOrderLine.Status, ProdOrderLine.Status::Released);
        ProdOrderLine.SETRANGE("Prod. Order No.", ProdOrderCode);
        if ProdOrderLine.findset() then
            repeat
                OutputValue += (ProdOrderLine."Remaining Quantity" * ProdOrderLine."Unit Cost");
            until ProdOrderLine.NEXT() = 0;
        //  MESSAGE('%1',OutputValue);
        exit(OutputValue);
    end;

    local procedure CalculateOutputUsed(ProdOrderCode: Code[20]) OutputUsed: Decimal;
    var
        ValueEntries: Record "Value Entry";
    begin
        CLEAR(OutputUsed);

        //HEI.01>>
        // Based on Value entries we can calculate what is Output
        //IF NOT IncludeEntries THEN
        //EXIT(0);

        ValueEntries.SETRANGE(ValueEntries."Item Ledger Entry Type", ValueEntries."Item Ledger Entry Type"::Output);
        ValueEntries.SETRANGE(ValueEntries."Document No.", ProdOrderCode);
        ValueEntries.SETRANGE(ValueEntries."Entry Type", ValueEntries."Entry Type"::"Direct Cost");
        ValueEntries.SETRANGE(Adjustment, false);
        if ValueEntries.findset() then
            repeat
                OutputUsed += (ValueEntries."Cost Amount (Actual)" + ValueEntries."Cost Amount (Expected)") * -1;//value is coming in negative;
            until ValueEntries.NEXT() = 0;
        //MESSAGE('%1',OutputUsed);
        exit(OutputUsed);
        //HEI.01<<
    end;

    procedure CalculateValue(): Text[1024];
    var
        ProductionOrders: Record "Production Order";
        MaterialDifference: Decimal;
        OutputDifference: Decimal;
        Items: Record Item;
        CapacityDifference: Decimal;
        GeneralLedgerSetup: Record "General Ledger Setup";
        finalvalue: Decimal;
    begin
        //hei.01>>
        // Loop through the Production orders and calculate the WIP Materials&O/P
        CLEAR(MaterialDifference);
        CLEAR(OutputDifference);
        CLEAR(finalvalue);
        LineNos := GetLineNumber();
        ProductionOrders.SETRANGE(ProductionOrders.Status, ProductionOrders.Status::Released);
        ProductionOrders.SETRANGE("Source Type", ProductionOrders."Source Type"::Item);
        ProductionOrders.SETFILTER(ProductionOrders."Source No.", '<>%1', '');

        if FilteronZone then begin
            GeneralLedgerSetup.GET();
            ProductionOrders.SETFILTER("Zone Code FND", GeneralLedgerSetup."WIP Output Zone Filtering FND");
        end;

        if ProductionOrders.findset() then
            repeat
                Items.GET(ProductionOrders."Source No.");

                MaterialDifference := CalculateMaterialValue(ProductionOrders."No.") + CalculateMaterialUsed(ProductionOrders."No.");
                // MESSAGE('%1',MaterialDifference);
                OutputDifference := CalculateOutputValue(ProductionOrders."No.") - CalculateOutputUsed(ProductionOrders."No.");
                //MESSAGE('%1',OutputDifference);
                finalvalue := (OutputDifference - MaterialDifference) * (GeneralLedgerSetup."WIP Accrual. Cap. Perc. FND" / 100);
                //MESSAGE('%1',finalvalue);
                // MESSAGE('Prod Order No:%1','Matdif:%2','OPdiff:%3','FinalValue-%4',ProductionOrders."No.",MaterialDifference,OutputDifference,finalvalue);
                CreatenewGenJournalLine(finalvalue, Items."Inventory Posting Group", ProductionOrders."No.", ProductionOrders."Location Code");
            until ProductionOrders.NEXT() = 0;

        if STRLEN(ErrorCombinations) > 1024 then
            exit(STRSUBSTNO(HEI02, Inserts))
        else
            exit(STRSUBSTNO(HEI01, Inserts));// HEI.02


        //hei.01<<
    end;

    local procedure CreatenewGenJournalLine(Value: Decimal; InvPostingGroup: Code[10]; PONumber: Code[20]; LocationCode: Code[10]);
    var
        GenJournalLines: Record "Gen. Journal Line";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        Loop: Integer;
    begin
        if Value <> 0 then begin //HEI.02
                                 //HEI.01>>
            if InventoryPostingSetup.GET(LocationCode, InvPostingGroup) then begin
                for Loop := 1 to 2 do begin

                    GenJournalLines."Journal Template Name" := JournalTemplate;
                    GenJournalLines."Journal Batch Name" := JournalBatch;
                    GenJournalLines."Line No." := LineNos;
                    GenJournalLines.VALIDATE("Document No.", DocumentCode);

                    if Loop = 1 then begin
                        GenJournalLines.VALIDATE("Posting Date", PostingDate);
                        GenJournalLines.VALIDATE(Amount, -Value);
                    end else begin
                        GenJournalLines.VALIDATE("Posting Date", CALCDATE('<+CM+1D>', PostingDate));
                        GenJournalLines.VALIDATE(Amount, 0);
                        GenJournalLines.VALIDATE(Amount, Value);
                    end;

                    if recgenjnltemplate.GET(JournalTemplate) then
                        GenJournalLines.VALIDATE("Source Code", recgenjnltemplate."Source Code");

                    GenJournalLines."Account Type" := GenJournalLines."Account Type"::"G/L Account";
                    GenJournalLines.VALIDATE("Account No.", InventoryPostingSetup."Accrual WIP Account FND");
                    GenJournalLines."Bal. Account Type" := GenJournalLines."Bal. Account Type"::"G/L Account";
                    GenJournalLines.VALIDATE("Bal. Account No.", InventoryPostingSetup."Accrual WIP Bal.Account FND");
                    GenJournalLines.VALIDATE(Description, FORMAT(COPYSTR(GenJournalLines.Description, 1, 20)) + ' ' + PONumber);

                    //29.04.21>>
                    recvalueentry.RESET();
                    recvalueentry.SETRANGE("Document No.", PONumber);
                    recvalueentry.SETRANGE("Item Ledger Entry Type", recvalueentry."Item Ledger Entry Type"::Output);
                    if recvalueentry.FINDFIRST() then
                        GenJournalLines.VALIDATE("Dimension Set ID", recvalueentry."Dimension Set ID");
                    //29.04.21<<

                    if GenJournalLines.INSERT() then begin
                        LineNos += 1000;
                        Inserts += 1;
                    end;

                end;
            end else
                ErrorCombinations := ErrorCombinations + PONumber + '|';
            //HEI.01>>

        end;
    end;

    procedure SetParameters(pGenJournalTemplate: Code[20]; pJournalBatch: Code[20]; pPostingdate: Date; pDecMaterialPercentage: Decimal; pDecCapacityPercentage: Decimal; pDocumentCode: Code[20]; pFilterZone: Boolean; InclEntries: Boolean);
    begin

        DocumentCode := pDocumentCode;

        MaterialPercentages := pDecMaterialPercentage;
        CapacityPercentages := pDecCapacityPercentage;

        PostingDate := pPostingdate;
        JournalTemplate := pGenJournalTemplate;
        JournalBatch := pJournalBatch;

        FilteronZone := pFilterZone;

        IncludeEntries := InclEntries;
    end;

    local procedure WCCost(WorkCenter: Code[20]): Decimal;
    var
        WorkCenters: Record "Work Center";
    begin
        if WorkCenters.GET(WorkCenter) then
            exit(WorkCenters."Unit Cost")
        else
            exit(0);
    end;

    local procedure GetOutPutItem(ProdOrderCode: Code[20]): Code[10];
    var
        ProductionOrder: Record "Production Order";
    begin
        ProductionOrder.SETRANGE(ProductionOrder.Status, ProductionOrder.Status::Released);
        ProductionOrder.SETRANGE(ProductionOrder."No.", ProdOrderCode);
        ProductionOrder.FINDLAST();
        exit(ProductionOrder."Source No.");
    end;

    local procedure ShowFinalMessage();
    begin
        if GUIALLOWED then
            MESSAGE(STRSUBSTNO(HEI01, ((LineNos - 1000) / 1000))); //HEI.02
    end;

    local procedure GetLineNumber(): Integer;
    var
        GeneralJournalLine: Record "Gen. Journal Line";
    begin
        // Get line Number
        GeneralJournalLine.SETRANGE(GeneralJournalLine."Journal Template Name", JournalTemplate);
        GeneralJournalLine.SETRANGE(GeneralJournalLine."Journal Batch Name", JournalBatch);
        if GeneralJournalLine.FINDLAST() then
            exit(GeneralJournalLine."Line No." + 1000)
        else
            exit(1000);
    end;

    local procedure WCenternUoM(WC: Code[20]): Code[20];
    var
        WorkCenter: Record "Work Center";
    begin
        if WorkCenter.GET(WC) then
            exit(WorkCenter."Unit of Measure Code")
    end;
}

