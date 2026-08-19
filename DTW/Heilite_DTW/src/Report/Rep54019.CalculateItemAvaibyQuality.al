report 54019 "Calculate Item Avai by Quality"
{
    // version HEI.05

    // HEI.01 IBM.AK CHG2072471 12.04.21
    // # Updating Lot no and ILE
    // # to be scheduled over job queue, splitted email and lot & ILE updating functionality in this report from R50018
    // 
    // HEI.02 IBM SURYAS01 PRB2007020 25.03.2022 # Code Optimization
    // 
    // HEI.03 IBM PRASAA03 INC4411609/CHG2183459 28.11.2022  BugFix to Update Warehouse Entries.
    // # If Quality status is On-Hold on lot no. info, then Blocked Field in Lot information table should be enabled.
    // # if Quality status is On-Hold on Warehouse Entry then Unavailable Stock (Quality) should be false on warehouse entry.
    // 
    // HEI.04 IBM PATHAA02/Mimikos CHG2227355 07.11.2023 "Calculate item Availability by Quality"
    // # Report Redesign for Performance Improvement & Avoid Locking
    // # Data Items Item and Location are removed.
    // # UI process dialog when the report is running from the Client
    // 
    // HEI.05 IBM PATHAA02/Mimikos CHG2227355 09.11.2023 "Calculate item Availability by Quality"
    // # Subtype of Global variable -"DotNetInt" changed from Int32 to Int64
    // BC Upgrade BHARDA11 >>
    // 1. Old Report Id-50095
    // 2. Remove All Dotnet Variables and restructure the dotnet related code .
    // 3. Remove Drink-IT Fields and related code("Expiration Date","Quality Status")
    // 4. Add ApplicationArea ,UsageCategory Property in Report.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Calculate Item Avai by quality';
    Permissions = TableData "Item Ledger Entry" = rm,
                  TableData "Warehouse Entry" = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Lot No. Information"; "Lot No. Information")
        {
            // RequestFilterFields = "Expiration Date"; // BC Upgrade BHARDA11 ----Drink-IT Fields("Expiration Date")
            RequestFilterFields = "Expiration Action Date 06 FDW"; //PATHAA02 GAP014_DTW, IBM GAP DTW 43
            UseTemporary = true;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            /*IF (LocationFilter = '') AND (BinFilter = '') AND (ZoneFilter = '') THEN
              UseAsInTransit := TRUE
            ELSE
              UseAsInTransit := FALSE;
            */

        end;
    }

    labels
    {
        lblQuantity = 'Quantity';
        lblQuantityHL = 'Quantity HL';
        lblExpiryDate = 'Expiry Date';
        lblQuantityBase = 'Quantity (Base)';
        lbItemNoCpt = 'Item Number';
        lbItemDescriptionCpt = 'Description';
        lbLotNoCpt = 'Lot Number';
        lbQualityStatusCpt = 'Quality Status';
        lbCode = 'Code';
        lbZOne = 'Zone Code';
        lbBin = 'Bin Code';
        lbUoM = 'UOM';
        lbLocation = 'Location';
        lblPage = 'Page';
        lbBinBlocked = 'Partially Blocked';
        lblItemCatCode = 'Item Cat. Code';
        lblCMGCode = 'CMG Code';
        lblCMGDesc = 'CMG Description';
        lblExtRelevant = 'Extract Relevant';
        lblExtCont = 'Extra Content [%w/w]';
        lblDateReceipt = 'Date of Receipt/Production';
    }

    trigger OnPostReport()
    begin

        CLEAR(TempSkipLotNoInformation); //HEI.02
    end;

    trigger OnPreReport()
    begin

        InventorySetup.GET;
        CLEAR(ItemCategoryFilter);
        IF InventorySetup."Active Best Before Date FND" THEN BEGIN  //activate expiry notification boolean on page
            IF InventorySetup."Item Category Typology FND" <> '' THEN //<Expiry Notification Item Typology on page
                ItemCategoryFilter := InventorySetup."Item Category Typology FND";
        END;

        //HEI.02<<
        IF InventorySetup."Lots skipped FND" <> '' THEN BEGIN
            LotNoInformation.RESET();
            LotNoInformation.SETFILTER("Lot No.", InventorySetup."Lots skipped FND");
            IF LotNoInformation.FINDSET(FALSE) THEN
                REPEAT
                    TempSkipLotNoInformation.INIT;
                    TempSkipLotNoInformation."Item No." := LotNoInformation."Item No.";
                    TempSkipLotNoInformation."Variant Code" := LotNoInformation."Variant Code";
                    TempSkipLotNoInformation."Lot No." := LotNoInformation."Lot No.";
                    TempSkipLotNoInformation.INSERT(FALSE);
                UNTIL LotNoInformation.NEXT = 0;
        END;
        //HEI.02>>

        //HEI.04 <<
        ProccessLots;
        UpdateEntries();
        CLEARALL();
        //HEI.04 >>
    end;

    var
        InventorySetup: Record "Inventory Setup";
        RemShelfLifeDays: Integer;
        ItemCategoryFilter: Code[250];
        WarehouseEntry: Record "Warehouse Entry";
        LotNoInformation: Record "Lot No. Information";
        TempSkipLotNoInformation: Record "Lot No. Information" temporary;
        ItemLedgerEntry: Record "Item Ledger Entry";
        // BC Upgrade BHARDA11 >> ----Dotnet Variables not supported in BC
        // ListLocation    DotNet System.Collections.Generic.List`1.'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
        // DotNetString    DotNet System.String.'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
        // DotNetStringSeperator   DotNet System.String.'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
        // DotNetLocationFilter    DotNet System.String.'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
        // DotNetInt   DotNet System.Int64.'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
        // DotNetEntryFilter   DotNet System.String.'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
        // ListILE DotNet System.Collections.Generic.List`1.'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
        // ListWHE DotNet System.Collections.Generic.List`1.'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
        // BC Upgrade BHARDA11 << ----Dotnet Variables not supported in BC
        // BC Upgrade BHARDA11 >> -- Replaced DotNet List and String types with native AL List type
        ListLocation: List of [Code[20]];
        ListILE: List of [Integer];
        ListWHE: List of [Integer];
        // BC Upgrade BHARDA11 << -- Replaced DotNet List and String types with native AL List type
        recLocation: Record Location;
        recItemCategoryFilter: Record Item;
        tempInt: Integer;
        recItemLot: Record "Lot No. Information";

        TempUpdateLotNoInformation: Record "Lot No. Information" temporary;

    local procedure ProccessLots()
    var
        ProccessDialog: Dialog;
        ProccessDialogStep: Integer;
        ProccessLot: Boolean;
        TotalLots: Integer;
        BlockLot: Boolean;
        // BC Upgrade BHARDA11 >> -- Added variables for native AL string manipulation
        LocationFilter: Text;
        LocationCode: Code[20];
        // BC Upgrade BHARDA11  << -- Added variables for native AL string manipulation
        inventorySetup: Record "Inventory Setup";
    begin

        //HEI.04<<
        // BC Upgrade BHARDA11 >> -- Removed DotNet List initialization, AL Lists auto-initialize
        // ListILE := ListILE.List;
        // ListWHE := ListWHE.List;
        // BC Upgrade BHARDA11 << -- Removed DotNet List initialization, AL Lists auto-initialize
        TotalLots := 0;


        //Calculate totals
        IF GUIALLOWED THEN BEGIN
            recItemLot.RESET();
            recItemLot.SETAUTOCALCFIELDS();
            recItemLot.COPYFILTERS("Lot No. Information");
            recItemLot.SETFILTER("Lot No.", '<>%1', '');
            // recItemLot.SETFILTER("Expiration Date", '<>%1', 0D); // BC Upgrade BHARDA11 -- Drink-IT Field("Expiration Date")
            recItemLot.SetFilter("Expiration Action Date 06 FDW", '<>%1', 0D); //PATHAA02 GAP014_DTW, IBM GAP DTW 43
            IF recItemLot.FINDSET(FALSE) THEN
                REPEAT
                    IF NOT TempSkipLotNoInformation.GET(recItemLot."Item No.", recItemLot."Variant Code", recItemLot."Lot No.") THEN BEGIN
                        recItemCategoryFilter.RESET();
                        IF (ItemCategoryFilter <> '') THEN BEGIN
                            recItemCategoryFilter.SETFILTER("Item Category Code", ItemCategoryFilter);
                        END;
                        recItemCategoryFilter.SETRANGE("No.", recItemLot."Item No.");

                        IF recItemCategoryFilter.FINDFIRST() THEN BEGIN
                            TotalLots := TotalLots + 1;
                        END;
                    END;
                UNTIL recItemLot.NEXT = 0;

            ProccessDialogStep := 0;
            ProccessDialog.OPEN('Item No:#1 Lot No: #2 Mark for Update ILE :#3 Mark for Update WHE #4 Proccessed Lots #5 Total Lots #6 Mark for Update Lot #7');
            ProccessDialog.UPDATE(6, TotalLots);
        END;
        //Calculate totals

        recItemCategoryFilter.RESET();
        IF (ItemCategoryFilter <> '') THEN BEGIN
            recItemCategoryFilter.SETFILTER("Item Category Code", ItemCategoryFilter);
        END;
        IF recItemCategoryFilter.FINDSET(FALSE) THEN
            REPEAT
                recItemLot.RESET();
                recItemLot.SETAUTOCALCFIELDS();
                recItemLot.COPYFILTERS("Lot No. Information");
                recItemLot.SETFILTER("Lot No.", '<>%1', '');
                // recItemLot.SETFILTER("Expiration Date", '<>%1', 0D); // BC Upgrade BHARDA11 -- Drink-IT Field("Expiration Date")
                recItemLot.SetFilter("Expiration Action Date 06 FDW", '<>%1', 0D); //PATHAA02 GAP014_DTW, IBM GAP DTW 43

                recItemLot.SETRANGE("Item No.", recItemCategoryFilter."No.");
                // BC Upgrade BHARDA11 >> -- Removed DotNet List initialization
                // ListLocation := ListLocation.List;
                // BC Upgrade BHARDA11 << -- Removed DotNet List initialization
                IF recItemLot.FINDSET(FALSE) THEN
                    REPEAT
                        IF GUIALLOWED THEN BEGIN
                            ProccessDialogStep := ProccessDialogStep + 1;
                            ProccessDialog.UPDATE(1, recItemLot."Item No.");
                            ProccessDialog.UPDATE(2, recItemLot."Lot No.");
                            ProccessDialog.UPDATE(3, ListILE.Count);
                            ProccessDialog.UPDATE(4, ListWHE.Count);
                            ProccessDialog.UPDATE(5, ProccessDialogStep);
                            ProccessDialog.UPDATE(7, TempUpdateLotNoInformation.COUNT);
                        END;
                        // ListLocation.Clear();
                        ProccessLot := FALSE;

                        IF NOT TempSkipLotNoInformation.GET(recItemLot."Item No.", recItemLot."Variant Code", recItemLot."Lot No.") THEN BEGIN

                            CLEAR(RemShelfLifeDays);
                            // BC Upgrade BHARDA11 >>-- Drink-IT Field("Expiration Date")
                            //     IF InventorySetup."Active Best Before Date" THEN BEGIN
                            //         IF recItemLot."Expiration Date" <> 0D THEN BEGIN
                            //             RemShelfLifeDays := (recItemLot."Expiration Date" - TODAY);
                            //             recLocation.RESET();
                            //             //recLocation.SETRANGE("Use As In-Transit",FALSE);
                            //             IF recLocation.FINDSET(FALSE, FALSE) THEN
                            //                 REPEAT
                            //                     IF ((RemShelfLifeDays <= recLocation."Warning Threshold Days") AND (recItemLot."Expiration Date" <= TODAY)) THEN BEGIN
                            //                         ListLocation.Add(recLocation.Code);
                            //                         ProccessLot := TRUE;
                            //                     END;
                            //                 UNTIL recLocation.NEXT = 0;
                            //         END;
                            //     END;
                            // BC Upgrade BHARDA11 <<-- Drink-IT Field("Expiration Date")

                            // PATHAA02 09.06.26>> 
                            IF InventorySetup."Active Best Before Date FND" THEN BEGIN
                                IF recItemLot."Expiration Date 06 FDW" <> 0D THEN BEGIN
                                    RemShelfLifeDays := (recItemLot."Expiration Date 06 FDW" - TODAY);
                                    recLocation.RESET();
                                    //recLocation.SETRANGE("Use As In-Transit",FALSE);
                                    IF recLocation.FINDSET() THEN
                                        REPEAT
                                            IF ((RemShelfLifeDays <= recLocation."Warning Threshold Days FND") AND (recItemLot."Expiration Date 06 FDW" <= TODAY)) THEN BEGIN
                                                ListLocation.Add(recLocation.Code);
                                                ProccessLot := TRUE;
                                            END;
                                        UNTIL recLocation.NEXT = 0;
                                END;
                            END;
                            //PATHAA02 09.06.26<< 
                        END;



                        IF (ProccessLot = TRUE) THEN BEGIN
                            // BC Upgrade BHARDA11 >> -- Replaced DotNet string manipulation with AL Text methods
                            // DotNetStringSeperator := ' ';
                            // //StringSeperator:=StringLocation.Join(StringSeperator.ToCharArray,ListLocation.ToArray);
                            // DotNetLocationFilter := '';

                            // FOREACH DotNetString IN ListLocation DO BEGIN
                            //     DotNetLocationFilter := FORMAT(DotNetLocationFilter) + FORMAT(DotNetString) + FORMAT(DotNetStringSeperator);
                            // END;

                            // DotNetLocationFilter := DotNetLocationFilter.Trim();
                            // DotNetLocationFilter := DotNetLocationFilter.Replace(' ', '|');
                            LocationFilter := '';

                            foreach LocationCode in ListLocation do begin
                                if LocationFilter <> '' then
                                    LocationFilter += '|';
                                LocationFilter += LocationCode;
                            end;
                            // BC Upgrade BHARDA11 << -- Replaced DotNet string manipulation with AL Text methods


                            ItemLedgerEntry.RESET;
                            ItemLedgerEntry.SETRANGE("Item No.", recItemLot."Item No.");
                            ItemLedgerEntry.SETRANGE("Variant Code", recItemLot."Variant Code");
                            ItemLedgerEntry.SETRANGE("Lot No.", recItemLot."Lot No.");
                            // BC Upgrade BHARDA11 -- Using LocationFilter variable instead of DotNetLocationFilter
                            ItemLedgerEntry.SETFILTER("Location Code", LocationFilter);
                            ItemLedgerEntry.SETFILTER("Quality Status FND", '<>%1', ItemLedgerEntry."Quality Status FND"::"Quality Hold");
                            IF ItemLedgerEntry.FINDSET(FALSE) THEN
                                REPEAT
                                    ListILE.Add(ItemLedgerEntry."Entry No.");
                                UNTIL ItemLedgerEntry.NEXT = 0;

                            BlockLot := FALSE;
                            inventorySetup.Get();//BC Upgrade PATHAA02 
                            WarehouseEntry.RESET;
                            WarehouseEntry.SETRANGE("Item No.", recItemLot."Item No.");
                            WarehouseEntry.SETRANGE("Lot No.", recItemLot."Lot No.");
                            WarehouseEntry.SETRANGE("Variant Code", recItemLot."Variant Code");
                            // WarehouseEntry.SETFILTER("Location Code", DotNetLocationFilter); // BC Upgrade BHARDA11 -- Using LocationFilter variable instead of DotNetLocationFilter
                            WarehouseEntry.SETFILTER("Location Code", LocationFilter);
                            WarehouseEntry.SETRANGE("Inspection Status FND", inventorySetup."Quality Unrestricted FND"); //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
                            IF WarehouseEntry.FINDSET(FALSE) THEN
                                REPEAT
                                    ListWHE.Add(WarehouseEntry."Entry No.");
                                    BlockLot := TRUE;
                                UNTIL WarehouseEntry.NEXT = 0;
                            // BC Upgrade BHARDA11 >> ----Drink-IT Field("Quality Status")
                            // IF (BlockLot = TRUE) THEN BEGIN
                            //     IF (recItemLot."Quality Status" <> recItemLot."Quality Status"::Quarantine) THEN BEGIN
                            //         TempUpdateLotNoInformation.INIT;
                            //         TempUpdateLotNoInformation."Lot No." := recItemLot."Lot No.";
                            //         TempUpdateLotNoInformation."Item No." := recItemLot."Item No.";
                            //         TempUpdateLotNoInformation."Variant Code" := recItemLot."Variant Code";
                            //         TempUpdateLotNoInformation.INSERT(FALSE);
                            //     END;
                            // END;
                            // BC Upgrade BHARDA11 << ----Drink-IT Field("Quality Status")
                            // PATHAA02 09.06.26>>
                            IF (BlockLot = TRUE) THEN BEGIN
                                IF (recItemLot."Inspection Status Code 07 FDW" <> inventorySetup."Quality On Hold FND") THEN BEGIN
                                    TempUpdateLotNoInformation.INIT;
                                    TempUpdateLotNoInformation."Lot No." := recItemLot."Lot No.";
                                    TempUpdateLotNoInformation."Item No." := recItemLot."Item No.";
                                    TempUpdateLotNoInformation."Variant Code" := recItemLot."Variant Code";
                                    TempUpdateLotNoInformation.INSERT(FALSE);
                                END;
                            END;
                            //PATHAA02 09.06.26<<

                        END;
                    UNTIL recItemLot.NEXT = 0;
            UNTIL recItemCategoryFilter.NEXT = 0;

        IF GUIALLOWED THEN BEGIN
            ProccessDialog.CLOSE;
        END;
        //HEI.04>>
    end;

    local procedure UpdateEntries()
    var
        EntryNo: Integer;
        ILEEntryNo: Integer;
        WHEEntryNo: Integer;
    begin
        //HEI.04<<
        // BC Upgrade BHARDA11 >> -- Replaced DotNet List iteration with AL foreach
        IF (ListILE.Count() > 0) THEN BEGIN
            foreach ILEEntryNo in ListILE do begin
                IF ItemLedgerEntry.GET(ILEEntryNo) THEN BEGIN
                    ItemLedgerEntry."Quality Status FND" := ItemLedgerEntry."Quality Status FND"::"Quality Hold";
                    ItemLedgerEntry.MODIFY(FALSE);
                END;
            end;
        END;
        // BC Upgrade BHARDA11 >> -- DotNet iteration commented out
        // IF (ListILE.Count > 0) THEN BEGIN
        //     FOREACH DotNetInt IN ListILE DO BEGIN
        //         EVALUATE(EntryNo, FORMAT(DotNetInt));
        //         IF ItemLedgerEntry.GET(EntryNo) THEN BEGIN
        //             ItemLedgerEntry."Quality Status" := ItemLedgerEntry."Quality Status"::"Quality Hold";
        //             ItemLedgerEntry.MODIFY(FALSE);
        //         END;
        //     END;
        // END;
        // BC Upgrade BHARDA11 << -- DotNet iteration commented out

        // BC Upgrade BHARDA11 >> -- Replaced DotNet List iteration with AL foreach
        IF (ListWHE.Count() > 0) THEN BEGIN
            foreach WHEEntryNo in ListWHE do begin
                IF WarehouseEntry.GET(WHEEntryNo) THEN BEGIN
                    WarehouseEntry."Inspection Status FND" := InventorySetup."Quality On Hold FND"; //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
                    WarehouseEntry."Unavail. Stock (Quality) FND" := FALSE;
                    WarehouseEntry.MODIFY(FALSE);
                END;
            end;
        END;
        // BC Upgrade BHARDA11  << -- Replaced DotNet List iteration with AL foreach
        // BC Upgrade BHARDA11 >> -- DotNet iteration commented out
        // IF (ListWHE.Count > 0) THEN BEGIN
        //     FOREACH DotNetInt IN ListWHE DO BEGIN
        //         EVALUATE(EntryNo, FORMAT(DotNetInt));
        //         IF WarehouseEntry.GET(EntryNo) THEN BEGIN
        //             WarehouseEntry."Quality Status" := WarehouseEntry."Quality Status"::"Quality Hold";
        //             WarehouseEntry."Unavailable Stock (Quality)" := FALSE;
        //             WarehouseEntry.MODIFY(FALSE);
        //         END;
        //     END;
        // END;
        // BC Upgrade BHARDA11 << -- DotNet iteration commented out

        LotNoInformation.RESET;
        IF TempUpdateLotNoInformation.FINDSET THEN
            REPEAT
                IF LotNoInformation.GET(TempUpdateLotNoInformation."Item No.", TempUpdateLotNoInformation."Variant Code", TempUpdateLotNoInformation."Lot No.") THEN BEGIN
                    // LotNoInformation."Quality Status" := "Lot No. Information"."Quality Status"::Quarantine; // BC Upgrade BHARDA11 ----Drink-IT Fields("Quality Status")
                    LotNoInformation."Inspection Status Code 07 FDW" := InventorySetup."Quality On Hold FND"; //PATHAA02 GAP014_DTW, IBM GAP DTW 43
                    LotNoInformation.Blocked := TRUE;//HEI.03
                    LotNoInformation.MODIFY(FALSE);
                END;
            UNTIL TempUpdateLotNoInformation.NEXT = 0;
        //HEI.04>>
    end;
}

