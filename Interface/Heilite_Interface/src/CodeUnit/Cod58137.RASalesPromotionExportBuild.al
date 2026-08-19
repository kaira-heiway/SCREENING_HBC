codeunit 58156 "RA Sales Promotion Export Bld"
{
    // HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019 # Object created
    // BC Upgrade SHUKLP03 >>
    //   In NAV, this logic lived inside the page (OnOpenPage + local procedures).
    //   In BC it is moved to this codeunit, run in a background session so
    //   web-service callers are never blocked by the build time.
    //   The procedure names and field assignments below match the NAV page exactly.
    //   Only the minimum BC differences are marked with "BC Upgrade SHUKLP03".
    // BC Upgrade SHUKLP03 <<

    trigger OnRun()
    begin
        BuildExportData();
    end;

    var
        // BC Upgrade SHUKLP03 >> These were page-level vars in NAV.
        //   Moved here because the build now runs in this codeunit, not the page.
        OrtecKStoreInterfaceSetup: Record "Ortec & KStore Interf. Stp INT";
        BillToCustomer: Record Customer;
        ExportRec: Record "RASalesPromotionExport int";
    // BC Upgrade SHUKLP03 <<

    procedure BuildExportData()
    begin
        OrtecKStoreInterfaceSetup.GET();
        OrtecKStoreInterfaceSetup.TESTFIELD("Customer Account Group");

        BillToCustomer.SETFILTER("Account Group FND", OrtecKStoreInterfaceSetup."Customer Account Group");

        ExportRec.Reset();
        ExportRec.DeleteAll(true);

        FillTempBasicPromotionLines();
    end;

    local procedure FillTempBasicPromotionLines()
    var
        SalesPromotionsQuery: Query "Sales Promotions Query";
        // BC Upgrade SHUKLP03 >> Tier accumulator variables — not in NAV.
        LastRuleNo: Integer;
        TierCount: Integer;
        TierMinQty: array[3] of Decimal;
        TierFreeQty: array[3] of Decimal;
        FirstRow: Boolean;
    begin
        LastRuleNo := -1;
        FirstRow := true;

        SalesPromotionsQuery.OPEN;
        WHILE SalesPromotionsQuery.READ DO BEGIN

            IF SalesPromotionsQuery.Rule_No_ <> LastRuleNo THEN BEGIN

                IF NOT FirstRow THEN
                    CASE SalesPromotionsQuery.Sales_Type OF
                        SalesPromotionsQuery.Sales_Type::CustomerGroup:
                            InsertBasicLineCPG(SalesPromotionsQuery, TierMinQty, TierFreeQty, TierCount);
                        SalesPromotionsQuery.Sales_Type::CustomerAll:
                            InsertBasicLineAllCustomers(SalesPromotionsQuery, TierMinQty, TierFreeQty, TierCount);
                        SalesPromotionsQuery.Sales_Type::Customer:
                            InsertBasicLineSingleCust(SalesPromotionsQuery, TierMinQty, TierFreeQty, TierCount);
                    END;

                CLEAR(TierMinQty);
                CLEAR(TierFreeQty);
                TierCount := 0;
                FirstRow := false;
                LastRuleNo := SalesPromotionsQuery.Rule_No_;
            END;

            IF TierCount < 3 THEN BEGIN
                TierCount += 1;
                TierMinQty[TierCount] := SalesPromotionsQuery.Minimum_Quantity;
                TierFreeQty[TierCount] := SalesPromotionsQuery.Free_Quantity;
            END;

        END;

        IF NOT FirstRow THEN
            CASE SalesPromotionsQuery.Sales_Type OF
                SalesPromotionsQuery.Sales_Type::CustomerGroup:
                    InsertBasicLineCPG(SalesPromotionsQuery, TierMinQty, TierFreeQty, TierCount);
                SalesPromotionsQuery.Sales_Type::CustomerAll:
                    InsertBasicLineAllCustomers(SalesPromotionsQuery, TierMinQty, TierFreeQty, TierCount);
                SalesPromotionsQuery.Sales_Type::Customer:
                    InsertBasicLineSingleCust(SalesPromotionsQuery, TierMinQty, TierFreeQty, TierCount);
            END;

        SalesPromotionsQuery.CLOSE;
    end;

    local procedure InsertBasicLineCPG(SalesPromotionsQuery: Query "Sales Promotions Query";
        TierMinQty: array[3] of Decimal;
        TierFreeQty: array[3] of Decimal;
        TierCount: Integer)
    var
        DrinkPromotionRelationQueryCustomer: Query "Drink Promotion Relation Query";
        DrinkPromotionRelationQueryItem: Query "Drink Promotion Relation Query";
        Item: Record Item;
    begin
        CASE SalesPromotionsQuery.Source_Type OF

            SalesPromotionsQuery.Source_Type::ItemGroup:
                BEGIN
                    DrinkPromotionRelationQueryCustomer.SETRANGE(DrinkPromotionRelationQueryCustomer.Code, SalesPromotionsQuery.Sales_Code);
                    DrinkPromotionRelationQueryCustomer.OPEN;
                    WHILE DrinkPromotionRelationQueryCustomer.READ DO BEGIN
                        DrinkPromotionRelationQueryItem.CLOSE;
                        DrinkPromotionRelationQueryItem.SETRANGE(DrinkPromotionRelationQueryItem.Code, SalesPromotionsQuery.Source_No);
                        DrinkPromotionRelationQueryItem.OPEN;
                        WHILE DrinkPromotionRelationQueryItem.READ DO BEGIN
                            BillToCustomer.SETRANGE("Bill-to Customer No.", DrinkPromotionRelationQueryCustomer.Source_No);
                            IF BillToCustomer.FINDSET() THEN
                                REPEAT
                                    InsertLine(
                                        BillToCustomer."No.",
                                        DrinkPromotionRelationQueryItem.Source_No,
                                        SalesPromotionsQuery,
                                        TierMinQty, TierFreeQty, TierCount);
                                UNTIL BillToCustomer.NEXT() = 0;
                        END;
                    END;
                    DrinkPromotionRelationQueryCustomer.CLOSE;
                    DrinkPromotionRelationQueryItem.CLOSE;
                END;

            SalesPromotionsQuery.Source_Type::ItemAll:
                BEGIN
                    DrinkPromotionRelationQueryCustomer.SETRANGE(DrinkPromotionRelationQueryCustomer.Code, SalesPromotionsQuery.Sales_Code);
                    DrinkPromotionRelationQueryCustomer.OPEN;
                    WHILE DrinkPromotionRelationQueryCustomer.READ DO BEGIN
                        BillToCustomer.SETRANGE("Bill-to Customer No.", DrinkPromotionRelationQueryCustomer.Source_No);
                        IF BillToCustomer.FINDSET() THEN
                            REPEAT
                                IF Item.FINDSET() THEN
                                    REPEAT
                                        InsertLine(
                                            BillToCustomer."No.",
                                            Item."No.",
                                            SalesPromotionsQuery,
                                            TierMinQty, TierFreeQty, TierCount);
                                    UNTIL Item.NEXT() = 0;
                            UNTIL BillToCustomer.NEXT() = 0;
                    END;
                    DrinkPromotionRelationQueryCustomer.CLOSE;
                END;

            SalesPromotionsQuery.Source_Type::Item:
                BEGIN
                    DrinkPromotionRelationQueryCustomer.SETRANGE(DrinkPromotionRelationQueryCustomer.Code, SalesPromotionsQuery.Sales_Code);
                    DrinkPromotionRelationQueryCustomer.OPEN;
                    WHILE DrinkPromotionRelationQueryCustomer.READ DO BEGIN
                        BillToCustomer.SETRANGE("Bill-to Customer No.", DrinkPromotionRelationQueryCustomer.Source_No);
                        IF BillToCustomer.FINDSET() THEN
                            REPEAT
                                InsertLine(
                                    BillToCustomer."No.",
                                    SalesPromotionsQuery.Source_No,
                                    SalesPromotionsQuery,
                                    TierMinQty, TierFreeQty, TierCount);
                            UNTIL BillToCustomer.NEXT() = 0;
                    END;
                    DrinkPromotionRelationQueryCustomer.CLOSE;
                END;

        END;
    end;

    local procedure InsertBasicLineAllCustomers(
        SalesPromotionsQuery: Query "Sales Promotions Query";
        TierMinQty: array[3] of Decimal;
        TierFreeQty: array[3] of Decimal;
        TierCount: Integer)
    var
        DrinkPromotionRelationQueryItem: Query "Drink Promotion Relation Query";
        Item: Record Item;
        Customer: Record Customer;
    begin
        CASE SalesPromotionsQuery.Source_Type OF

            SalesPromotionsQuery.Source_Type::ItemGroup:
                BEGIN
                    Customer.RESET();
                    Customer.SETFILTER("Account Group FND", OrtecKStoreInterfaceSetup."Customer Account Group");
                    IF Customer.FINDSET() THEN
                        REPEAT
                            DrinkPromotionRelationQueryItem.CLOSE;
                            DrinkPromotionRelationQueryItem.SETRANGE(DrinkPromotionRelationQueryItem.Code, SalesPromotionsQuery.Source_No);
                            DrinkPromotionRelationQueryItem.OPEN;
                            WHILE DrinkPromotionRelationQueryItem.READ DO BEGIN
                                BillToCustomer.SETRANGE("Bill-to Customer No.", Customer."No.");
                                IF BillToCustomer.FINDSET() THEN
                                    REPEAT
                                        InsertLine(
                                            BillToCustomer."No.",
                                            DrinkPromotionRelationQueryItem.Source_No,
                                            SalesPromotionsQuery,
                                            TierMinQty, TierFreeQty, TierCount);
                                    UNTIL BillToCustomer.NEXT() = 0;
                            END;
                        UNTIL Customer.NEXT() = 0;
                    DrinkPromotionRelationQueryItem.CLOSE;
                END;

            SalesPromotionsQuery.Source_Type::ItemAll:
                BEGIN
                    Customer.RESET();
                    Customer.SETFILTER("Account Group FND", OrtecKStoreInterfaceSetup."Customer Account Group");
                    IF Customer.FINDSET() THEN
                        REPEAT
                            IF Item.FINDSET() THEN
                                REPEAT
                                    BillToCustomer.SETRANGE("Bill-to Customer No.", Customer."No.");
                                    IF BillToCustomer.FINDSET() THEN
                                        REPEAT
                                            InsertLine(
                                                BillToCustomer."No.",
                                                Item."No.",
                                                SalesPromotionsQuery,
                                                TierMinQty, TierFreeQty, TierCount);
                                        UNTIL BillToCustomer.NEXT() = 0;
                                UNTIL Item.NEXT() = 0;
                        UNTIL Customer.NEXT() = 0;
                END;

            SalesPromotionsQuery.Source_Type::Item:
                BEGIN
                    Customer.RESET();
                    Customer.SETFILTER("Account Group FND", OrtecKStoreInterfaceSetup."Customer Account Group");
                    IF Customer.FINDSET() THEN
                        REPEAT
                            BillToCustomer.SETRANGE("Bill-to Customer No.", Customer."No.");
                            IF BillToCustomer.FINDSET() THEN
                                REPEAT
                                    InsertLine(
                                        BillToCustomer."No.",
                                        SalesPromotionsQuery.Source_No,
                                        SalesPromotionsQuery,
                                        TierMinQty, TierFreeQty, TierCount);
                                UNTIL BillToCustomer.NEXT() = 0;
                        UNTIL Customer.NEXT() = 0;
                END;

        END;
    end;

    local procedure InsertBasicLineSingleCust(
        SalesPromotionsQuery: Query "Sales Promotions Query";
        TierMinQty: array[3] of Decimal;
        TierFreeQty: array[3] of Decimal;
        TierCount: Integer)
    var
        DrinkPromotionRelationQueryItem: Query "Drink Promotion Relation Query";
        Item: Record Item;
    begin
        CASE SalesPromotionsQuery.Source_Type OF

            SalesPromotionsQuery.Source_Type::ItemGroup:
                BEGIN
                    DrinkPromotionRelationQueryItem.SETRANGE(DrinkPromotionRelationQueryItem.Code, SalesPromotionsQuery.Source_No);
                    DrinkPromotionRelationQueryItem.SETRANGE(DrinkPromotionRelationQueryItem.Source_Type, DrinkPromotionRelationQueryItem.Source_Type::Item);
                    DrinkPromotionRelationQueryItem.OPEN;
                    WHILE DrinkPromotionRelationQueryItem.READ DO BEGIN
                        BillToCustomer.SETRANGE("Bill-to Customer No.", SalesPromotionsQuery.Sales_Code);
                        IF BillToCustomer.FINDSET() THEN
                            REPEAT
                                InsertLine(
                                    BillToCustomer."No.",
                                    DrinkPromotionRelationQueryItem.Source_No,
                                    SalesPromotionsQuery,
                                    TierMinQty, TierFreeQty, TierCount);
                            UNTIL BillToCustomer.NEXT() = 0;
                    END;
                    DrinkPromotionRelationQueryItem.CLOSE;
                END;

            SalesPromotionsQuery.Source_Type::ItemAll:
                BEGIN
                    IF Item.FINDSET() THEN
                        REPEAT
                            BillToCustomer.SETRANGE("Bill-to Customer No.", SalesPromotionsQuery.Sales_Code);
                            IF BillToCustomer.FINDSET() THEN
                                REPEAT
                                    InsertLine(
                                        BillToCustomer."No.",
                                        Item."No.",
                                        SalesPromotionsQuery,
                                        TierMinQty, TierFreeQty, TierCount);
                                UNTIL BillToCustomer.NEXT() = 0;
                        UNTIL Item.NEXT() = 0;
                END;

            SalesPromotionsQuery.Source_Type::Item:
                BEGIN
                    BillToCustomer.SETRANGE("Bill-to Customer No.", SalesPromotionsQuery.Sales_Code);
                    IF BillToCustomer.FINDSET() THEN
                        REPEAT
                            InsertLine(
                                BillToCustomer."No.",
                                SalesPromotionsQuery.Source_No,
                                SalesPromotionsQuery,
                                TierMinQty, TierFreeQty, TierCount);
                        UNTIL BillToCustomer.NEXT() = 0;
                END;

        END;
    end;

    local procedure InsertLine(
        SourceNo: Code[20];
        ItemNo: Code[20];
        SalesPromotionsQuery: Query "Sales Promotions Query";
        TierMinQty: array[3] of Decimal;
        TierFreeQty: array[3] of Decimal;
        TierCount: Integer)
    begin
        ExportRec.INIT();
        ExportRec."Line No." := 0;
        ExportRec."Source Type" := ExportRec."Source Type"::Customer;
        ExportRec."Source No." := SourceNo;
        ExportRec."Item Type" := ExportRec."Item Type"::Item;
        ExportRec."Item No." := ItemNo;
        ExportRec."Currency Code" := SalesPromotionsQuery.Currency_Code;
        ExportRec."Based Location Code" := SalesPromotionsQuery.Location_Code;
        ExportRec."Based Shipment Method Code" := SalesPromotionsQuery.Shipment_Method_Code;
        ExportRec."Based Item Type" := SalesPromotionsQuery.Calculate_per;
        ExportRec."Free Item No." := SalesPromotionsQuery.No;
        ExportRec."Starting Date" := SalesPromotionsQuery.Starting_Date;
        IF SalesPromotionsQuery.Ending_Date = 0D THEN
            ExportRec."Ending Date" := 20991231D
        ELSE
            ExportRec."Ending Date" := SalesPromotionsQuery.Ending_Date;
        ExportRec."Free Unit of Measure Code" := SalesPromotionsQuery.Unit_of_Measure_Code;
        ExportRec."Rate Value" := SalesPromotionsQuery.Unit_Price;
        ExportRec."Minimum Quantity" := SalesPromotionsQuery.Minimum_Quantity;
        ExportRec."Minimum Amount" := SalesPromotionsQuery.Minimum_Amount;
        ExportRec."Free Quantity" := SalesPromotionsQuery.Free_Quantity;
        ExportRec.Calculation_Type := SalesPromotionsQuery.Calculation_Type;

        IF TierCount >= 1 THEN BEGIN
            ExportRec."Tier Level 1" := TierMinQty[1];
            ExportRec."Tier Level 2" := TierFreeQty[1];
        END;
        IF TierCount >= 3 THEN
            ExportRec."Tier Level 3" := TierMinQty[3];

        ExportRec.INSERT(false);
    end;
}