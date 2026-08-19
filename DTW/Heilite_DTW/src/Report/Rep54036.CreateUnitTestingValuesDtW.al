report 54036 "Create Unit Testing Values DtW"
{
    // version TS,HEI.33

    // HEI.01 RITM2817451 IBM BHANDS01 10.01.2022 Automation DtW Test Scripts
    //   # New Report created to automatically configure values in Unit Testing Value Setup
    // HEI.02 RITM2817451 IBM BHANDS01 16.02.2022 Automation DtW Test Scripts
    //   # Added new functions
    // HEI.03 RITM2817451 IBM SURYAS01 28-02-2022
    //    # Added new functions
    // HEI.04 RITM2817451 IBM SAXENA03 28-03-2022
    //   # Added Setparameters function to SET request Page values as TRUE
    //   # Code added to Hide messages.
    //   # Commented the Code of OnINITReport trigger.
    // 
    // HEI.05 RITM2817451 IBM SURYAS02 30-03-2022
    //   # Added Code/Function to create automatically Warehouse Employees and User General Journal for UserID
    // HEI.06 RITM3007822 IBM BHANDS01 23-05-2022
    //   #Added code for TestScript PRD090
    // 
    // HEI.07 RITM3007822 IBM GOKULS01 11-08-2022
    //   #Added code for Datacreation issues fix
    // 
    // HEI.08 RITM3007822 IBM GOKULS01 16-08-2022
    //   #Added code for Datacreation issues fix - Production order lines
    // 
    // HEI.09 RITM3007822 IBM GOKULS01 18-08-2022
    //   #Added code for Datacreation issues fix - Production order lines
    // 
    // HEI.10 RITM3007822 IBM GOKULS01 28-08-2022
    //   #Added code for TestScript PRDE15
    // 
    // HEI.11 RITM3007822 IBM GOKULS01 30-08-2022
    //   #Added code for TestScript PRDE090
    // 
    // HEI.12 RITM3007822 IBM GOKULS01 01-09-2022
    //   #Added code for PRD028 change
    // 
    // HEI.13 RITM3145979 IBM SAXENA03 06.09.2022
    //   # Added TS tag in Version List for Test Script related objects
    // HEI.14 RITM3007822 NORRIQ KOROLA04 06-09-2022
    //   # #Added code for PRDR06 change
    // 
    // HEI.15 RITM3007822 IBM GOKULS01 07-09-2022
    //   # Added code for Empty BOM Line
    // 
    // HEI.16 RITM3007822 IBM GOKULS01 08-09-2022
    //   # Added code for Blocked item
    // 
    // HEI.17 RITM3007822 IBM GOKULS01 21-09-2022
    //   # Added code for BIN not to take intr01
    // 
    // HEI.18 RITM3007822 IBM PRASAA03 20-10-2022
    //   # Added code for Production BOM Available Order
    // 
    // HEI.19 RITM3007822 IBM PRASAA03 31-10-2022
    //   # Added code to filter Items To insert PRD071 Data.
    // 
    // HEI.20 RITM3007822 IBM PRASAA03 04-11-2022
    //   # Added code to filter Finished Production Orders To insert PRD001 Data.
    // 
    // HEI.21 RITM3007822 IBM PRASAA03 28-02-2023
    //   # Added code to update the active BOM Version
    // 
    // HEI.22 RITM3323086  IBM SAXENA03 20-03-2023
    //   # Added code to disable Change Log Setup
    // 
    // HEI.23 RITM3007822 IBM PRASAA03 27-03-2023
    //   # Added code to update the active Routing Version
    // 
    // HEI.24 RITM3007822 IBM PRASAA03 03-04-2023
    //   # Added code to update Batch Production Resource No. in bin.
    // 
    // HEI.25 RITM3007822 IBM PRASAA03 05-04-2023
    //   # Update code to use Yeast Production Order details.
    // 
    // HEI.26 RITM3007822 IBM PRASAA03 24.04.2023 Automation DtW Test Scripts
    //   #Removed below report and added functions and replaced the reports with new functions created.
    //   #Report 50567"UpdateItemInventory DTW 2"with Replaced UpdateItemInvDTW2InitParameters.
    // 
    // HEI.27 RITM3007822 IBM PRASAA03 28-04-2023 Automation DtW Test Scripts
    //   # Update code to use Filtration Capacit details.
    // 
    // HEI.28 CHG2185291 IBM SAXENA03 10.05.2023 # Automation DtW Test Scripts
    //   # Added code for Consolidation of Test Script objects
    // 
    // HEI.29 CHG2185291 IBM PRASAA03 24.05.2023 # Automation DtW Test Scripts
    //   # Added code to assign GD2 Value to avoid stock creation issue.
    // 
    // HEI.30 CHG2207595 IBM PRASAA03 07.06.2023 # Automation DtW Test Scripts
    //   # Added code to Delete EBF dimension setup for GD1 and GD2
    //   # Added code to modify Astro setup to not check Active prod Order.
    // 
    // HEI.31 CHG2208369 IBM PRASAA03 12.06.2023 # Automation DtW Test Scripts
    //   # Issue resolved regaring Dimension(ccc) in Rwanda.
    // 
    // HEI.32 CHG2211315 IBM PRASAA03 04.07.2023 # Automation DtW Test Scripts
    //   # code changed to Global for correcting dimension value.
    // 
    // HEI.33 CHG2212895 IBM PRASAA03 17.07.2023 # Automation DtW Test Scripts
    //   # code Added to get PRD042 Order Test Values

    //BC Upgrade KAPOOV01 >>
    // 1. Commented Table-Astro Interface Setup Related code.
    // 2.Commented code related to-DRINK-IT fields-"Production BOM No.","Production BOM Version Code","Routing Version Code" of Table-"Production Order" Table.
    // 3.Commented procedure CreateQualityUsers() dependent on DRINK-IT Table-"Quality User"
    // 4.Commented code related to-DRINK-IT field-"Prod. Jnl. Flushing (Time)" of Table-"Prod. Jnl. Flushing (Time)" Table.
    // 5.Commented Drink-IT Table-"Quality Setup"
    // 6.Commented code related to-DRINK-IT field-"Bin Code" of Table-"Reservation Entry"
    // 7.Added ApplicationArea Property of Report.
    // 8.Old Report ID-50502.
    //BC Upgrade KAPOOV01 <<

    // BC Upgrade PATELS08 >>
    // # Added UsageCategory property to the report level.
    // # Code Change in procedure CreateWarehouseEmployeesForUser() to remove Zone code from Warehouse Employee GET function as number of fields in primary key is 2.
    // BC Upgrade PATELS08 <<


    ProcessingOnly = true;
    ApplicationArea = All;
    // BC UPGRADE PATELS08 >> # Added UsageCategory property to the report level.
    UsageCategory = Tasks;
    // BC UPGRADE PATELS08 <<

    dataset
    {
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
        //HEI.04>>
        //IF NOT (USERID  IN ['HEIWAY\BHANDS01','HEIWAY\MITTRG01','HEIWAY\SHAUKM01','HEIWAY\PATHAA02','HEIWAY\SURYAS01']) THEN
        //  ERROR('Not authorized to run this report');
        //HEI.04<<
        //HEI.28>>
        UnitTestingValue.SkipTestScriptExecutionPROD();
        //HEI.28<<
    end;

    trigger OnPostReport();
    var
        DeleteUnitTestingValue: Record "Unit Testing Value FND";
    begin
        //HEI.05 >>
        //HEI.31>>
        //Update Dimension Value
        //HEI.32>>
        GeneralLedgerSetup.GET();
        //Update GD1
        DefaultDimension.RESET();
        DefaultDimension.SETRANGE("Table ID", 15);
        DefaultDimension.SETRANGE("Dimension Code", GeneralLedgerSetup."Global Dimension 1 Code");
        DefaultDimension.SETRANGE("Dimension Value Code", '');
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Same Code");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        //Update GD2
        DefaultDimension.RESET();
        DefaultDimension.SETRANGE("Table ID", 15);
        DefaultDimension.SETRANGE("Dimension Code", GeneralLedgerSetup."Global Dimension 2 Code");
        DefaultDimension.SETRANGE("Dimension Value Code", '');
        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Same Code");
        DefaultDimension.MODIFYALL("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
        //HEI.31<<
        //HEI.31<<
        //HEI.22>>

        ChangeLogSetup.RESET();
        if ChangeLogSetup.GET() then begin
            ChangeLogSetup."Change Log Activated" := false;
            ChangeLogSetup.MODIFY(true);
        end;
        //HEI.22<<
        CheckPreRequestSetups();//HEI.07
        //CreateQualityUsers; //BC Upgrade KAPOOV01 Commented procedure CreateQualityUsers() dependent on DRINK-IT Table-"Quality User" 
        CreateWarehouseEmployeesForUser(USERID, '', ''); //To add Warehouse Employees

        //TO add user General for userid Only for General and Item
        //For each Journal Type (0 = General, 1 = Item) and Gen. Journal Type (0 = General, 1 = Sales, 2 = Purchases, 3 = Cash Receipts,
        //4 = Payments, 5 = Assets, 6 = Intercompany, 7 = Jobs , 8 = item) call function CreateUserGeneralJournalForUser
        CreateUserGeneralJournalForUser(USERID, 0, 0);
        CreateUserGeneralJournalForUser(USERID, 1, 8);
        //HEI.05 <<
        CreateItemtemplatebatch();//HEI.07
        //HEI.04>>
        if HideDialogs then
            ConfirmOpen := true
        else
            ConfirmOpen := CONFIRM(ConfirmMsg, true);

        //IF CONFIRM(ConfirmMsg,TRUE) THEN
        if ConfirmOpen then
      //HEI.04<<
      begin
            DeleteUnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4', 'PRD001', 'PRD005', 'PRD011', 'PRD013');
            if DeleteUnitTestingValue.FINDSET() then
                DeleteUnitTestingValue.DELETEALL();

            DeleteUnitTestingValue.RESET();
            DeleteUnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3', 'PRD015', 'PRD019', 'PRD022');
            if DeleteUnitTestingValue.FINDSET() then
                DeleteUnitTestingValue.DELETEALL();

            DeleteUnitTestingValue.RESET();
            DeleteUnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4', 'PRD041', 'PRD042', 'PRD046', 'PRD050');
            if DeleteUnitTestingValue.FINDSET() then
                DeleteUnitTestingValue.DELETEALL();

            DeleteUnitTestingValue.RESET();
            DeleteUnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4|%5|%6|%7',
                                              'PRD027', 'PRD028', 'PRD032', 'PRD034', 'PRD035', 'PRD036', 'PRD037');
            if DeleteUnitTestingValue.FINDSET() then
                DeleteUnitTestingValue.DELETEALL();

            DeleteUnitTestingValue.RESET();
            DeleteUnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4', 'PRD054', 'PRD055', 'PRD059', 'PRD066');
            if DeleteUnitTestingValue.FINDSET() then
                DeleteUnitTestingValue.DELETEALL();

            DeleteUnitTestingValue.RESET();
            DeleteUnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4', 'PRD071', 'PRD075', 'PRD077', 'PRD080');
            if DeleteUnitTestingValue.FINDSET() then
                DeleteUnitTestingValue.DELETEALL();

            //HEI.03<<
            DeleteUnitTestingValue.RESET();
            DeleteUnitTestingValue.SETFILTER("Test Script Code", '%1|%2|%3|%4', 'DTW003', 'PRD085', 'PRD090', 'PRDE15');  //HEI.06 //HEI.10
            DeleteUnitTestingValue.DELETEALL(true);
            //HEI.03>>

            //HEI.14 >>
            DeleteUnitTestingValue.RESET();
            DeleteUnitTestingValue.SETFILTER("Test Script Code", 'PRDR06');
            DeleteUnitTestingValue.DELETEALL(true);
            //HEI.14 <<
        end;
        //HEI.30>>
        GeneralLedgerSetup.GET();
        EbfCombination.RESET();
        EbfCombination.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 1 Code");
        EbfCombination.SETFILTER("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DELETEALL();
        EbfCombination.RESET();
        EbfCombination.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        EbfCombination.SETFILTER("Combination Restriction", '<>%1', EbfCombination."Combination Restriction"::" ");
        EbfCombination.DELETEALL();

        //BC Upgrade KAPOOV01 Commented Table-Astro Interface Setup Related code >>
        // if AstroInterfaceSetup.GET then begin
        //     AstroInterfaceSetup."Activate Prod. Order" := false;
        //     AstroInterfaceSetup.MODIFY;
        // end;
        //BC Upgrade KAPOOV01 Commented Table-Astro Interface Setup Related code <<
        //HEI.30<<
        InsertBrewhouseOp();        // For Brewhouse Operations
        //HEI.03<<
        InsertGoodsIssuetoCostCentre();
        InsertBookingStockforRecoveredBeer();
        //HEI.03>>

        // HEI.02 >>
        if COMPANYNAME <> '10_LUBUMBASHI' then
            InsertYeastPropogation();   // For Yeast Propogation
        if not (COMPANYNAME in ['10_BUKAVU', 'BrewCo', '10_BRASSIVOIRE', '10_HBSC', '10_KINSHASA', '10_Haiti']) then
            InsertFilterCapacity();     // For Filter Capacity
        InsertCellarOp();           // For Cellar Operations
        InsertFilterationMixing();  // For Filteration Mixing
        InsertPackagingOp();        // For Packaging Operations
        // HEI.02 <<

        InsertProductionBOM();  //HEI.06 >>
        InsertRouting();//HEI.10
        PRDR06_ItemReclassJournal_InitData(); //HEI.14

        //HEI.04>>
        if not HideDialogs then
            //HEI.04<<
            MESSAGE(CompletedMsg);
    end;

    var
        FinishedProductionOrder: Record "Production Order";
        ConfirmMsg: Label 'Do you want to delete existing DtW Unit Testing Setup?';
        CompletedMsg: Label 'Unit Test Values Setup Updated for DtW!';
        UnitTestingValWort: Record "Unit Testing Value FND";
        AddBinCode1: Code[20];
        AddItem1: Code[20];
        AddZoneCode1: Code[20];
        HideDialogs: Boolean;
        ConfirmOpen: Boolean;
        ProductionBOMLine: Record "Production BOM Line";
        BOMVErUpdated: Boolean;
        ChangeLogSetup: Record "Change Log Setup";
        SKU: Record "Stockkeeping Unit";
        UnitTestingValue: Record "Unit Testing Value FND";
        DimensionValue: Record "Dimension Value";
        EbfCombination: Record "Ebf Combination FND";
        GeneralLedgerSetup: Record "General Ledger Setup";
        //AstroInterfaceSetup : Record "Astro Interface Setup"; //BC Upgrade KAPOOV01 Commented Table-Astro Interface Setup Related code.
        DefaultDimension: Record "Default Dimension";

    local procedure CreateUnitTestingValues(TestCode: Code[20]; TestDescription: Text[100]; TableID: Integer; ParamValue: Code[20]; var UnitTestingValue: Record "Unit Testing Value FND");
    begin
        UnitTestingValue.INIT();
        UnitTestingValue.VALIDATE("Test Script Code", TestCode);
        UnitTestingValue.VALIDATE("Table ID", TableID);
        UnitTestingValue.VALIDATE("Company Name", COMPANYNAME);
        UnitTestingValue.VALIDATE("Test Script Description", TestDescription);
        UnitTestingValue.VALIDATE(Value, ParamValue);
        UnitTestingValue.INSERT(true);
    end;

    local procedure GetAddItemComponent(var BinCodeAddP: Code[20]) ItemAdd: Code[20];
    var
        Item: Record Item;
        BinContent: Record "Bin Content";
    begin
        Item.RESET();
        Item.SETCURRENTKEY(Inventory);
        Item.SETRANGE("Gen. Prod. Posting Group", 'RAWM');
        Item.SETRANGE("Inventory Posting Group", 'RAWM');
        Item.SETFILTER("Item Tracking Code", '<>%1', '');
        Item.SETFILTER("Global Dimension 2 Code", '<>%1', '');
        Item.SETRANGE(Type, Item.Type::Inventory);
        Item.SETFILTER(Inventory, '>%1', 100);
        Item.SETRANGE(Blocked, false);
        if Item.ISEMPTY then
            Item.SETRANGE("Global Dimension 2 Code");
        if Item.FINDLAST() then
            repeat
                BinContent.RESET();
                BinContent.SETRANGE("Item No.", Item."No.");
                BinContent.SETRANGE("Location Code", FinishedProductionOrder."Location Code");
                BinContent.SETRANGE("Zone Code", AddZoneCode1);
                BinContent.SETFILTER(Quantity, '>%1', 100);
                if BinContent.FINDFIRST() then begin
                    BinCodeAddP := BinContent."Bin Code";
                    exit(BinContent."Item No.");
                end;
            until Item.NEXT(-1) = 0;
    end;

    local procedure CheckItemBinContent(ItemNo: Code[20]; LocationCode: Code[20]; ZoneCode: Code[20]; BinCode: Code[20]);
    var
        BinL: Record Bin;
        BinContentL: Record "Bin Content";
    begin
        BinL.RESET();
        BinL.SETRANGE("Location Code", LocationCode);
        BinL.SETRANGE("Zone Code", ZoneCode);
        if BinCode <> '' then
            BinL.SETFILTER(Code, '<>%1', BinCode);
        if BinL.FINDFIRST() then begin
            AddBinCode1 := BinL.Code;
            BinContentL.RESET();
            BinContentL.SETRANGE("Item No.", ItemNo);
            BinContentL.SETRANGE("Location Code", LocationCode);
            BinContentL.SETRANGE("Zone Code", ZoneCode);
            BinContentL.SETRANGE("Bin Code", BinL.Code);
            BinContentL.SETFILTER(Quantity, '>%1', 100);
            if BinContentL.ISEMPTY then begin
                //HEI.26>>
                /*
                CLEAR(UpdateItemInventoryDTW2);
                UpdateItemInventoryDTW2.InitParameters(ItemNo,LocationCode,ZoneCode,BinL.Code,1000,'TESTDtW001','L0963');
                UpdateItemInventoryDTW2.USEREQUESTPAGE(FALSE);
                UpdateItemInventoryDTW2.RUNMODAL;*/
                UpdateItemInvDTW2InitParameters(ItemNo, LocationCode, ZoneCode, BinL.Code, 1000, 'TESTDtW001', 'L0963');
                //HEI.26<<
            end;
        end;

    end;

    local procedure InsertBrewhouseOp();
    var
        UnitTestingValueL: Record "Unit Testing Value FND";
        RoutingVersion: Record "Routing Version";
        RoutingLine: Record "Routing Line";
        ProductionBOMVersion: Record "Production BOM Version";
        ProductionBOMLine: Record "Production BOM Line";
        ProdOrderLine: Record "Prod. Order Line";
        BinL: Record Bin;
        ProdBOMVersionCode: Code[20];
        j: Integer;
        ItemledgerEntries: Record "Item Ledger Entry";
        OutPutAvailable: Boolean;
    begin
        CLEAR(AddBinCode1);
        CLEAR(AddZoneCode1);
        CLEAR(OutPutAvailable);//HEI.20

        FinishedProductionOrder.RESET();
        FinishedProductionOrder.SETRANGE(Status, FinishedProductionOrder.Status::Finished);
        FinishedProductionOrder.SETFILTER("Description 2", '%1', '@*WORT*');
        if FinishedProductionOrder.FINDLAST() then begin
            //HEI.20>>
            repeat
                if OutPutAvailable then
                    exit;
                ItemledgerEntries.RESET();
                ItemledgerEntries.SETCURRENTKEY("Entry Type", "Document No.");
                ItemledgerEntries.SETRANGE("Entry Type", ItemledgerEntries."Entry Type"::Output);
                ItemledgerEntries.SETRANGE("Document No.", FinishedProductionOrder."No.");
                if ItemledgerEntries.FINDFIRST() then begin
                    OutPutAvailable := true;
                    //HEI.20<<
                    // Location
                    CreateUnitTestingValues('PRD001', 'Create FPPO-Wort', DATABASE::Location, FinishedProductionOrder."Location Code", UnitTestingValueL);

                    // Zone
                    ProdOrderLine.RESET();
                    ProdOrderLine.SETRANGE("Prod. Order No.", FinishedProductionOrder."No.");
                    ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Finished);
                    if ProdOrderLine.FINDFIRST() then begin
                        CreateUnitTestingValues('PRD001', 'Create FPPO-Wort', DATABASE::Zone, ProdOrderLine."Zone Code FND", UnitTestingValueL);
                        UnitTestingValueL.VALIDATE("Value 2", ProdOrderLine."Zone Code FND");
                        UnitTestingValueL.MODIFY();
                        AddZoneCode1 := ProdOrderLine."Zone Code FND";
                        AddBinCode1 := ProdOrderLine."Bin Code";//HEI.07
                    end;

                    // Production BOM Version
                    ProductionBOMVersion.RESET();
                    //ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No."); //Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
                    ProductionBOMVersion.SetRange("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01 

                    ProductionBOMVersion.SETRANGE("Active FND", true);
                    if ProductionBOMVersion.FINDFIRST() then begin
                        CreateUnitTestingValues('PRD013', 'Adjust BoM Wort', DATABASE::"Production BOM Version", ProductionBOMVersion."Version Code", UnitTestingValueL);
                        ProdBOMVersionCode := ProductionBOMVersion."Version Code";
                    end;

                    // Item
                    CreateUnitTestingValues('PRD001', 'Create FPPO-Wort', DATABASE::Item, FinishedProductionOrder."Source No.", UnitTestingValueL);
                    // Deletion of a Component
                    j := 0;
                    ProductionBOMLine.RESET();
                    //ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No.");//Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
                    ProductionBOMLine.SetRange("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
                    ProductionBOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
                    ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
                    ProductionBOMLine.SETFILTER("Quantity per", '<%1', 0);
                    if ProductionBOMLine.ISEMPTY then
                        ProductionBOMLine.SETRANGE("Quantity per");
                    if ProductionBOMLine.FINDFIRST() then
                        repeat
                            j += 1;
                            if j = 2 then
                                UnitTestingValueL.VALIDATE("Value 3", ProductionBOMLine."No.");
                        until (ProductionBOMLine.NEXT() = 0) or (j = 2);

                    // Addition of New Component
                    UnitTestingValueL.VALIDATE("Value 2", GetAddItemComponent(AddBinCode1));
                    if UnitTestingValueL."Value 2" = '' then //HEI.07
                        UnitTestingValueL.VALIDATE("Value 2", GetAddItemComponentInventory(AddBinCode1)); //HEI.07

                    if UnitTestingValueL."Value 2" = UnitTestingValueL."Value 3" then begin
                        //ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No."); //Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
                        ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
                        ProductionBOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
                        ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
                        if ProductionBOMLine.FINDFIRST() then
                            UnitTestingValueL.VALIDATE("Value 3", ProductionBOMLine."No.");
                    end;
                    UnitTestingValueL.MODIFY();

                    // Bin
                    BinL.RESET();
                    BinL.SETRANGE("Location Code", FinishedProductionOrder."Location Code");
                    BinL.SETRANGE("Zone Code", AddZoneCode1);
                    if BinL.FINDFIRST() then
                        CreateUnitTestingValues('PRD001', 'Create FPPO-Wort', DATABASE::Bin, BinL.Code, UnitTestingValueL);
                    UnitTestingValueL.VALIDATE("Value 2", AddBinCode1);
                    UnitTestingValueL.MODIFY();

                    // Addition of other New Component
                    CreateUnitTestingValues('PRD011', 'FPPO Enter consumption Qty-Wort', DATABASE::Item, GetAddItemComponent(AddBinCode1), UnitTestingValueL);
                    CreateUnitTestingValues('PRD011', 'FPPO Enter consumption Qty-Wort', DATABASE::Zone, AddZoneCode1, UnitTestingValueL);
                    CreateUnitTestingValues('PRD011', 'FPPO Enter consumption Qty-Wort', DATABASE::Bin, AddBinCode1, UnitTestingValueL);

                    // Routing Version
                    RoutingVersion.RESET();
                    //RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No.");
                    RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No. 112FDW");//BC Upgrade Kamnay01

                    RoutingVersion.SETRANGE("Active FND", true);
                    if RoutingVersion.FINDFIRST() then begin
                        CreateUnitTestingValues('PRD005', 'FPPO_Adjust Routing_Wort', DATABASE::"Routing Version", RoutingVersion."Version Code", UnitTestingValueL);
                        // Work Center
                        RoutingLine.RESET();
                        RoutingLine.SETRANGE("Routing No.", RoutingVersion."Routing No.");
                        RoutingLine.SETRANGE("Version Code", RoutingVersion."Version Code");
                        RoutingLine.SETRANGE(Type, RoutingLine.Type::"Work Center");
                        if RoutingLine.FINDFIRST() then
                            CreateUnitTestingValues('PRD005', 'FPPO_Adjust Routing_Wort', DATABASE::"Work Center", RoutingLine."Work Center No.", UnitTestingValueL);
                    end;
                end;
            until FinishedProductionOrder.NEXT(-1) = 0 //HEI.20
        end;
    end;

    local procedure InsertYeastPropogation();
    var
        UnitTestingValueL: Record "Unit Testing Value FND";
        RoutingVersion: Record "Routing Version";
        RoutingLine: Record "Routing Line";
        ProductionBOMVersion: Record "Production BOM Version";
        ProductionBOMLine: Record "Production BOM Line";
        ProdOrderLine: Record "Prod. Order Line";
        BinL: Record Bin;
        ProdBOMVersionCode: Code[20];
        j: Integer;
        ItemL: Record Item;
    begin
        CLEAR(AddBinCode1);
        CLEAR(AddZoneCode1);

        FinishedProductionOrder.RESET();
        FinishedProductionOrder.SETRANGE(Status, FinishedProductionOrder.Status::Finished);
        FinishedProductionOrder.SETFILTER("Description 2", '%1', '@*Yeast*');
        if FinishedProductionOrder.FINDLAST() then begin
            // Location
            CreateUnitTestingValues('PRD015', 'Create RPO for Yeast Manually', DATABASE::Location, FinishedProductionOrder."Location Code", UnitTestingValueL);

            // Zone
            ProdOrderLine.RESET();
            ProdOrderLine.SETRANGE("Prod. Order No.", FinishedProductionOrder."No.");
            ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Finished);
            if ProdOrderLine.FINDFIRST() then begin
                CreateUnitTestingValues('PRD015', 'Create RPO for Yeast Manually', DATABASE::Zone, ProdOrderLine."Zone Code FND", UnitTestingValueL);
                UnitTestingValueL.VALIDATE("Value 2", ProdOrderLine."Zone Code FND");
                UnitTestingValueL.MODIFY();
                AddZoneCode1 := ProdOrderLine."Zone Code FND";
            end;

            // Production BOM Version
            ProductionBOMVersion.RESET();
            //ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No."); //Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
            ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01

            ProductionBOMVersion.SETRANGE("Active FND", true);
            if ProductionBOMVersion.FINDFIRST() then begin
                CreateUnitTestingValues('PRD022', 'Adjust BoM Yeast', DATABASE::"Production BOM Version", ProductionBOMVersion."Version Code", UnitTestingValueL);
                ProdBOMVersionCode := ProductionBOMVersion."Version Code";
            end;

            // Item
            CreateUnitTestingValues('PRD015', 'Create RPO for Yeast Manually', DATABASE::Item, FinishedProductionOrder."Source No.", UnitTestingValueL);
            // Deletion of a Component
            j := 0;
            ProductionBOMLine.RESET();
            //ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No.");//Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
            ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
            ProductionBOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
            ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
            ProductionBOMLine.SETFILTER("Quantity per", '<%1', 0);
            if ProductionBOMLine.ISEMPTY then
                ProductionBOMLine.SETRANGE("Quantity per");
            if ProductionBOMLine.FINDFIRST() then
                repeat
                    j += 1;
                    if j = 2 then
                        UnitTestingValueL.VALIDATE("Value 3", ProductionBOMLine."No.");
                until (ProductionBOMLine.NEXT() = 0) or (j = 2);

            // Addition of New Component
            UnitTestingValueL.VALIDATE("Value 2", GetAddItemComponent(AddBinCode1));
            if UnitTestingValueL."Value 2" = '' then begin
                UnitTestingValWort.RESET();
                UnitTestingValWort.SETRANGE("Test Script Code", 'PRD001');
                UnitTestingValWort.SETRANGE("Table ID", DATABASE::Item);
                if UnitTestingValWort.FINDFIRST() then
                    UnitTestingValueL.VALIDATE("Value 2", UnitTestingValWort."Value 2");
                CheckItemBinContent(UnitTestingValWort."Value 2", FinishedProductionOrder."Location Code", AddZoneCode1, '');
            end;
            if UnitTestingValueL."Value 2" = UnitTestingValueL."Value 3" then begin
                //ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No."); //Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
                ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01

                ProductionBOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
                ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
                if ProductionBOMLine.FINDFIRST() then
                    UnitTestingValueL.VALIDATE("Value 3", ProductionBOMLine."No.");
            end;
            UnitTestingValueL.MODIFY();

            // Bin
            BinL.RESET();
            BinL.SETRANGE("Location Code", FinishedProductionOrder."Location Code");
            BinL.SETRANGE("Zone Code", AddZoneCode1);
            if BinL.FINDFIRST() then
                CreateUnitTestingValues('PRD015', 'Create RPO for Yeast Manually', DATABASE::Bin, BinL.Code, UnitTestingValueL);
            UnitTestingValueL.VALIDATE("Value 2", AddBinCode1);
            UnitTestingValueL.MODIFY();

            // Routing Version
            RoutingVersion.RESET();
            RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No. 112FDW");//BC Upgrade Kamnay01
                                                                                                 //   RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No.");
            RoutingVersion.SETRANGE("Active FND", true);
            if RoutingVersion.FINDFIRST() then begin
                CreateUnitTestingValues('PRD019', 'RPO_Adjust Routing_Yeast', DATABASE::"Routing Version", RoutingVersion."Version Code", UnitTestingValueL);
                // Work Center
                RoutingLine.RESET();
                RoutingLine.SETRANGE("Routing No.", RoutingVersion."Routing No.");
                RoutingLine.SETRANGE("Version Code", RoutingVersion."Version Code");
                RoutingLine.SETRANGE(Type, RoutingLine.Type::"Work Center");
                if RoutingLine.FINDFIRST() then
                    CreateUnitTestingValues('PRD019', 'RPO_Adjust Routing_Yeast', DATABASE::"Work Center", RoutingLine."Work Center No.", UnitTestingValueL);
            end;
            //HEI.25>>
            //END;
        end else begin
            FinishedProductionOrder.RESET();
            FinishedProductionOrder.SETRANGE(Status, FinishedProductionOrder.Status::Finished);
            FinishedProductionOrder.SETFILTER(Description, '%1', '@*Yeast*');
            if FinishedProductionOrder.FINDLAST() then begin
                if ItemL.GET(FinishedProductionOrder."Source No.") then
                    if ItemL.Blocked then
                        ItemL.MODIFYALL(Blocked, false);
                // Location
                CreateUnitTestingValues('PRD015', 'Create RPO for Yeast Manually', DATABASE::Location, FinishedProductionOrder."Location Code", UnitTestingValueL);

                // Zone
                ProdOrderLine.RESET();
                ProdOrderLine.SETRANGE("Prod. Order No.", FinishedProductionOrder."No.");
                ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Finished);
                if ProdOrderLine.FINDFIRST() then begin
                    CreateUnitTestingValues('PRD015', 'Create RPO for Yeast Manually', DATABASE::Zone, ProdOrderLine."Zone Code FND", UnitTestingValueL);
                    UnitTestingValueL.VALIDATE("Value 2", ProdOrderLine."Zone Code FND");
                    UnitTestingValueL.MODIFY();
                    AddZoneCode1 := ProdOrderLine."Zone Code FND";
                end;

                // Production BOM Version
                ProductionBOMVersion.RESET();
                //ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No.");//Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
                ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01

                ProductionBOMVersion.SETRANGE("Active FND", true);
                if ProductionBOMVersion.FINDFIRST() then begin
                    CreateUnitTestingValues('PRD022', 'Adjust BoM Yeast', DATABASE::"Production BOM Version", ProductionBOMVersion."Version Code", UnitTestingValueL);
                    ProdBOMVersionCode := ProductionBOMVersion."Version Code";
                end;

                // Item
                CreateUnitTestingValues('PRD015', 'Create RPO for Yeast Manually', DATABASE::Item, FinishedProductionOrder."Source No.", UnitTestingValueL);
                // Deletion of a Component
                j := 0;
                ProductionBOMLine.RESET();
                //ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No."); Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
                ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01

                ProductionBOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
                ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
                ProductionBOMLine.SETFILTER("Quantity per", '<%1', 0);
                if ProductionBOMLine.ISEMPTY then
                    ProductionBOMLine.SETRANGE("Quantity per");
                if ProductionBOMLine.FINDFIRST() then
                    repeat
                        j += 1;
                        if j = 2 then
                            UnitTestingValueL.VALIDATE("Value 3", ProductionBOMLine."No.");
                    until (ProductionBOMLine.NEXT() = 0) or (j = 2);

                // Addition of New Component
                UnitTestingValueL.VALIDATE("Value 2", GetAddItemComponent(AddBinCode1));
                if UnitTestingValueL."Value 2" = '' then begin
                    UnitTestingValWort.RESET();
                    UnitTestingValWort.SETRANGE("Test Script Code", 'PRD001');
                    UnitTestingValWort.SETRANGE("Table ID", DATABASE::Item);
                    if UnitTestingValWort.FINDFIRST() then
                        UnitTestingValueL.VALIDATE("Value 2", UnitTestingValWort."Value 2");
                    CheckItemBinContent(UnitTestingValWort."Value 2", FinishedProductionOrder."Location Code", AddZoneCode1, '');
                end;
                if UnitTestingValueL."Value 2" = UnitTestingValueL."Value 3" then begin
                    //ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No."); //Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
                    ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01

                    ProductionBOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
                    ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
                    if ProductionBOMLine.FINDFIRST() then
                        UnitTestingValueL.VALIDATE("Value 3", ProductionBOMLine."No.");
                end;
                UnitTestingValueL.MODIFY();

                // Bin
                BinL.RESET();
                BinL.SETRANGE("Location Code", FinishedProductionOrder."Location Code");
                BinL.SETRANGE("Zone Code", AddZoneCode1);
                if BinL.FINDFIRST() then
                    CreateUnitTestingValues('PRD015', 'Create RPO for Yeast Manually', DATABASE::Bin, BinL.Code, UnitTestingValueL);
                UnitTestingValueL.VALIDATE("Value 2", AddBinCode1);
                UnitTestingValueL.MODIFY();

                // Routing Version
                RoutingVersion.RESET();
                RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No. 112FDW");//BC Upgrade Kamnay01
                RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No.");
                RoutingVersion.SETRANGE("Active FND", true);
                if RoutingVersion.FINDFIRST() then begin
                    CreateUnitTestingValues('PRD019', 'RPO_Adjust Routing_Yeast', DATABASE::"Routing Version", RoutingVersion."Version Code", UnitTestingValueL);
                    // Work Center
                    RoutingLine.RESET();
                    RoutingLine.SETRANGE("Routing No.", RoutingVersion."Routing No.");
                    RoutingLine.SETRANGE("Version Code", RoutingVersion."Version Code");
                    RoutingLine.SETRANGE(Type, RoutingLine.Type::"Work Center");
                    if RoutingLine.FINDFIRST() then
                        CreateUnitTestingValues('PRD019', 'RPO_Adjust Routing_Yeast', DATABASE::"Work Center", RoutingLine."Work Center No.", UnitTestingValueL);
                end;
            end;
        end;
        //HEI.25<<
    end;

    local procedure InsertFilterCapacity();
    var
        UnitTestingValueL: Record "Unit Testing Value FND";
        RoutingVersion: Record "Routing Version";
        RoutingLine: Record "Routing Line";
        ProductionBOMVersion: Record "Production BOM Version";
        ProductionBOMLine: Record "Production BOM Line";
        ProdOrderLine: Record "Prod. Order Line";
        BinL: Record Bin;
        ProdBOMVersionCode: Code[20];
        j: Integer;
        NoSeries: Record "No. Series";
    begin
        CLEAR(AddBinCode1);
        CLEAR(AddItem1);
        CLEAR(AddZoneCode1);

        FinishedProductionOrder.RESET();
        FinishedProductionOrder.SETRANGE(Status, FinishedProductionOrder.Status::Finished);
        FinishedProductionOrder.SETFILTER("Description 2", '%1', '@*Filtration Capacity*');
        //HEI.33>>
        if not FinishedProductionOrder.FINDLAST() then begin
            FinishedProductionOrder.RESET();
            FinishedProductionOrder.SETRANGE(Status, FinishedProductionOrder.Status::Finished);
            FinishedProductionOrder.SETFILTER(Description, '%1', '@*Filtration Capacity*');
        end;
        //HEI.33<<
        if FinishedProductionOrder.FINDLAST() then begin
            // Location
            CreateUnitTestingValues('PRD042', 'Create RPO for FILTER CAPACITY', DATABASE::Location, FinishedProductionOrder."Location Code", UnitTestingValueL);

            // Zone
            ProdOrderLine.RESET();
            ProdOrderLine.SETRANGE("Prod. Order No.", FinishedProductionOrder."No.");
            ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Finished);
            if ProdOrderLine.FINDFIRST() then begin
                CreateUnitTestingValues('PRD042', 'Create RPO for FILTER CAPACITY', DATABASE::Zone, ProdOrderLine."Zone Code FND", UnitTestingValueL);
                UnitTestingValueL.VALIDATE("Value 2", ProdOrderLine."Zone Code FND");
                UnitTestingValueL.MODIFY();
                AddZoneCode1 := ProdOrderLine."Zone Code FND";
            end;

            // Production BOM Version
            ProductionBOMVersion.RESET();
            //ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No."); //Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
            ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
            ProductionBOMVersion.SETRANGE("Active FND", true);
            if ProductionBOMVersion.FINDFIRST() then begin
                CreateUnitTestingValues('PRD050', 'Adjust BoM FILTER CAPACITY', DATABASE::"Production BOM Version", ProductionBOMVersion."Version Code", UnitTestingValueL);
                ProdBOMVersionCode := ProductionBOMVersion."Version Code";
                //HEI.27>>
                //END;
            end else begin
                //Update the BOM Active Version
                BOMVErUpdated := false;
                if SKU.GET(FinishedProductionOrder."Location Code", FinishedProductionOrder."Source No.", '') then begin
                    ProductionBOMVersion.RESET();
                    ProductionBOMVersion.SETCURRENTKEY("Production BOM No.", Status);
                    ProductionBOMVersion.SETRANGE("Production BOM No.", SKU."Production BOM No.");
                    ProductionBOMVersion.SETRANGE(Status, ProductionBOMVersion.Status::Certified);
                    ProductionBOMVersion.SETRANGE("Active FND", true);
                    if ProductionBOMVersion.FINDFIRST() then
                        repeat
                            if not BOMVErUpdated then begin
                                ProductionBOMLine.RESET();
                                ProductionBOMLine.SETRANGE("Production BOM No.", SKU."Production BOM No.");
                                ProductionBOMLine.SETFILTER("Version Code", '<>%1', '');
                                if ProductionBOMLine.FINDFIRST() then begin
                                    ProductionBOMVersion."Active FND" := true;
                                    ProductionBOMVersion.MODIFY();
                                    CreateUnitTestingValues('PRD050', 'Adjust BoM FILTER CAPACITY', DATABASE::"Production BOM Version", ProductionBOMVersion."Version Code", UnitTestingValueL);
                                    ProdBOMVersionCode := ProductionBOMVersion."Version Code";
                                    BOMVErUpdated := true;
                                end;
                            end;
                        until ProductionBOMVersion.NEXT() = 0;
                end;
            end;
            //HEI.27<<

            // Item
            CreateUnitTestingValues('PRD042', 'Create RPO for FILTER CAPACITY', DATABASE::Item, FinishedProductionOrder."Source No.", UnitTestingValueL);
            // Deletion of a Component
            j := 0;
            ProductionBOMLine.RESET();
            //ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No.");//Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
            ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
            ProductionBOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
            ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
            ProductionBOMLine.SETFILTER("Quantity per", '<%1', 0);
            if ProductionBOMLine.ISEMPTY then
                ProductionBOMLine.SETRANGE("Quantity per");
            if ProductionBOMLine.FINDFIRST() then
                repeat
                    j += 1;
                    if j = 2 then
                        UnitTestingValueL.VALIDATE("Value 3", ProductionBOMLine."No.");
                until (ProductionBOMLine.NEXT() = 0) or (j = 2);

            // Addition of New Component
            UnitTestingValueL.VALIDATE("Value 2", GetAddItemComponent(AddBinCode1));
            if UnitTestingValueL."Value 2" = '' then begin
                UnitTestingValWort.RESET();
                UnitTestingValWort.SETRANGE("Test Script Code", 'PRD001');
                UnitTestingValWort.SETRANGE("Table ID", DATABASE::Item);
                if UnitTestingValWort.FINDFIRST() then
                    UnitTestingValueL.VALIDATE("Value 2", UnitTestingValWort."Value 2");
                CheckItemBinContent(UnitTestingValWort."Value 2", FinishedProductionOrder."Location Code", AddZoneCode1, '');
            end;
            if UnitTestingValueL."Value 2" = UnitTestingValueL."Value 3" then begin
                //ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No.");//Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
                ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
                ProductionBOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
                ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
                if ProductionBOMLine.FINDFIRST() then
                    UnitTestingValueL.VALIDATE("Value 3", ProductionBOMLine."No.");
            end;
            UnitTestingValueL.MODIFY();
            AddItem1 := UnitTestingValueL."Value 2";

            // Addition of other New Component
            CreateUnitTestingValues('PRD046', 'Correct consumption Qty-FILTER CAPACITY', DATABASE::Item, AddItem1, UnitTestingValueL);

            // Bin
            BinL.RESET();
            BinL.SETRANGE("Location Code", FinishedProductionOrder."Location Code");
            BinL.SETRANGE("Zone Code", AddZoneCode1);
            if BinL.FINDFIRST() then
                CreateUnitTestingValues('PRD042', 'Create RPO for FILTER CAPACITY', DATABASE::Bin, BinL.Code, UnitTestingValueL);
            //HEI.07>>
            if BinL."Batch Sequential Number FND" = '' then begin
                NoSeries.RESET();
                NoSeries.SETFILTER(Description, '%1', '@*BIN*');
                if NoSeries.FINDLAST() then
                    BinL."Batch Sequential Number FND" := NoSeries.Code;
                BinL.MODIFY();
            end;
            //HEI.07<<
            UnitTestingValueL.VALIDATE("Value 2", AddBinCode1);
            UnitTestingValueL.MODIFY();

            // Routing Version
            RoutingVersion.RESET();
            //  RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No.");
            RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No. 112FDW");//BC Upgrade Kamnay01
            RoutingVersion.SETRANGE("Active FND", true);
            if RoutingVersion.FINDFIRST() then begin
                CreateUnitTestingValues('PRD041', 'Adjust Routing for FILTER CAPACITY', DATABASE::"Routing Version", RoutingVersion."Version Code", UnitTestingValueL);
                // Work Center
                RoutingLine.RESET();
                RoutingLine.SETRANGE("Routing No.", RoutingVersion."Routing No.");
                RoutingLine.SETRANGE("Version Code", RoutingVersion."Version Code");
                RoutingLine.SETRANGE(Type, RoutingLine.Type::"Work Center");
                if RoutingLine.FINDFIRST() then
                    CreateUnitTestingValues('PRD041', 'Adjust Routing for FILTER CAPACITY', DATABASE::"Work Center", RoutingLine."Work Center No.", UnitTestingValueL);
            end;
        end;
    end;

    local procedure InsertCellarOp();
    var
        UnitTestingValueL: Record "Unit Testing Value FND";
        RoutingVersion: Record "Routing Version";
        RoutingLine: Record "Routing Line";
        ProductionBOMVersion: Record "Production BOM Version";
        ProductionBOMLine: Record "Production BOM Line";
        ProdOrderLine: Record "Prod. Order Line";
        BinL: Record Bin;
        ProdBOMVersionCode: Code[20];
        j: Integer;
        BOMLine: Record "Production BOM Line";
    begin
        CLEAR(AddBinCode1);
        CLEAR(AddItem1);
        CLEAR(AddZoneCode1);

        FinishedProductionOrder.RESET();
        FinishedProductionOrder.SETRANGE(Status, FinishedProductionOrder.Status::Finished);
        FinishedProductionOrder.SETFILTER("Description 2", '%1', '@*Mature Beer*');
        //FinishedProductionOrder.SETFILTER("Production BOM No.", '<>%1', '');//HEI.18//Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
        FinishedProductionOrder.SetFilter("Prod. BOM No. 112FDW", '<>%1', '');//BC Upgrade Kamnay01
        if FinishedProductionOrder.FINDLAST() then begin
            // Location
            CreateUnitTestingValues('PRD028', 'Create RPO for GREEN or MATURE BEER Manually', DATABASE::Location, FinishedProductionOrder."Location Code", UnitTestingValueL);

            // Zone
            ProdOrderLine.RESET();
            ProdOrderLine.SETRANGE("Prod. Order No.", FinishedProductionOrder."No.");
            ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Finished);
            if ProdOrderLine.FINDFIRST() then begin
                CreateUnitTestingValues('PRD028', 'Create RPO for GREEN or MATURE BEER Manually', DATABASE::Zone, ProdOrderLine."Zone Code FND", UnitTestingValueL);
                UnitTestingValueL.VALIDATE("Value 2", ProdOrderLine."Zone Code FND");
                UnitTestingValueL.MODIFY();
                AddZoneCode1 := ProdOrderLine."Zone Code FND";
            end;

            // Production BOM Version
            ProductionBOMVersion.RESET();
            //ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No.");//Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
            ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
            ProductionBOMVersion.SETRANGE("Active FND", true);
            if ProductionBOMVersion.FINDFIRST() then begin
                CreateUnitTestingValues('PRD037', 'Adjust BoM MATURE BEER', DATABASE::"Production BOM Version", ProductionBOMVersion."Version Code", UnitTestingValueL);
                ProdBOMVersionCode := ProductionBOMVersion."Version Code";
            end;

            // Item
            CreateUnitTestingValues('PRD028', 'Create RPO for GREEN or MATURE BEER Manually', DATABASE::Item, FinishedProductionOrder."Source No.", UnitTestingValueL);
            // Deletion of a Component
            //HEI.12 >>
            BOMLine.RESET();
            BOMLine.SetRange("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
            //BOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No.");//Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
            BOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
            BOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
            BOMLine.SETFILTER("Quantity per", '<%1', 0);
            if BOMLine.FINDFIRST() then;
            //HEI.12 <<
            ProductionBOMLine.RESET();
            ProductionBOMLine.SetRange("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
            //ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No.");//Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
            ProductionBOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
            ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
            ProductionBOMLine.SETFILTER("No.", '<>%1', BOMLine."No.");//HEI.12
            ProductionBOMLine.SETFILTER("Quantity per", '>%1', 0);
            if ProductionBOMLine.FINDFIRST() then
                UnitTestingValueL.VALIDATE("Value 3", ProductionBOMLine."No.");

            // Addition of New Component
            UnitTestingValueL.VALIDATE("Value 2", GetAddItemComponent(AddBinCode1));
            if UnitTestingValueL."Value 2" = '' then begin
                UnitTestingValWort.RESET();
                UnitTestingValWort.SETRANGE("Test Script Code", 'PRD001');
                UnitTestingValWort.SETRANGE("Table ID", DATABASE::Item);
                if UnitTestingValWort.FINDFIRST() then
                    UnitTestingValueL.VALIDATE("Value 2", UnitTestingValWort."Value 2");
                CheckItemBinContent(UnitTestingValWort."Value 2", FinishedProductionOrder."Location Code", AddZoneCode1, '');
            end;
            UnitTestingValueL.MODIFY();
            AddItem1 := UnitTestingValueL."Value 2";

            // Bin
            BinL.RESET();
            BinL.SETRANGE("Location Code", FinishedProductionOrder."Location Code");
            BinL.SETRANGE("Zone Code", AddZoneCode1);
            if BinL.FINDFIRST() then
                CreateUnitTestingValues('PRD028', 'Create RPO for GREEN or MATURE BEER Manually', DATABASE::Bin, BinL.Code, UnitTestingValueL);
            UnitTestingValueL.VALIDATE("Value 2", AddBinCode1);
            UnitTestingValueL.MODIFY();

            // Addition of other New Component
            CreateUnitTestingValues('PRD036', 'Correct consumption Qty-MATURE BEER', DATABASE::Item, AddItem1, UnitTestingValueL);

            // Enter Consumption Quantities
            CreateUnitTestingValues('PRD027', 'Enter Consumption Quantities-MATURE BEER', DATABASE::Item, AddItem1, UnitTestingValueL);

            // Enter Negative Consumption Quantities
            ProductionBOMLine.RESET();
            ProductionBOMLine.SetRange("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
            //ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No.");//Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
            ProductionBOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
            ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
            ProductionBOMLine.SETFILTER("Quantity per", '<%1', 0);
            if ProductionBOMLine.FINDFIRST() then
                CreateUnitTestingValues('PRD035', 'Enter Negative Consumption Quantities', DATABASE::Item, ProductionBOMLine."No.", UnitTestingValueL)
            else
                CreateUnitTestingValues('PRD035', 'Enter Negative Consumption Quantities', DATABASE::Item, '', UnitTestingValueL);

            // Resource selection of available tanks
            CreateUnitTestingValues('PRD034', 'Resource selection of available tanks MATURE BEER', DATABASE::Item, AddItem1, UnitTestingValueL);
            CheckItemBinContent(AddItem1, FinishedProductionOrder."Location Code", AddZoneCode1, AddBinCode1);
            CreateUnitTestingValues('PRD034', 'Resource selection of available tanks MATURE BEER', DATABASE::Bin, AddBinCode1, UnitTestingValueL);

            // Routing Version
            RoutingVersion.RESET();
            //  RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No.");
            RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No. 112FDW");//BC Upgrade Kamnay01
            RoutingVersion.SETRANGE("Active FND", true);
            if RoutingVersion.FINDFIRST() then begin
                CreateUnitTestingValues('PRD032', 'Adjust Routing for MATURE BEER', DATABASE::"Routing Version", RoutingVersion."Version Code", UnitTestingValueL);
                // Work Center
                RoutingLine.RESET();
                RoutingLine.SETRANGE("Routing No.", RoutingVersion."Routing No.");
                RoutingLine.SETRANGE("Version Code", RoutingVersion."Version Code");
                RoutingLine.SETRANGE(Type, RoutingLine.Type::"Work Center");
                if RoutingLine.FINDFIRST() then
                    CreateUnitTestingValues('PRD032', 'Adjust Routing for MATURE BEER', DATABASE::"Work Center", RoutingLine."Work Center No.", UnitTestingValueL);
            end;
        end;
    end;

    local procedure InsertFilterationMixing();
    var
        UnitTestingValueL: Record "Unit Testing Value FND";
        RoutingVersion: Record "Routing Version";
        RoutingLine: Record "Routing Line";
        ProductionBOMVersion: Record "Production BOM Version";
        ProductionBOMLine: Record "Production BOM Line";
        ProdOrderLine: Record "Prod. Order Line";
        BinL: Record Bin;
        ProdBOMVersionCode: Code[20];
        j: Integer;
    begin
        CLEAR(AddBinCode1);
        CLEAR(AddItem1);
        CLEAR(AddZoneCode1);

        FinishedProductionOrder.RESET();
        FinishedProductionOrder.SETRANGE(Status, FinishedProductionOrder.Status::Finished);
        FinishedProductionOrder.SETFILTER("Description 2", '%1', '@*BRIGHT BEER*');
        if FinishedProductionOrder.FINDLAST() then begin
            // Location
            CreateUnitTestingValues('PRD055', 'Create RPO for BRIGHT BEER Manually Fil&Mix', DATABASE::Location, FinishedProductionOrder."Location Code", UnitTestingValueL);

            // Zone
            ProdOrderLine.RESET();
            ProdOrderLine.SETRANGE("Prod. Order No.", FinishedProductionOrder."No.");
            ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Finished);
            if ProdOrderLine.FINDFIRST() then begin
                CreateUnitTestingValues('PRD055', 'Create RPO for BRIGHT BEER Manually Fil&Mix', DATABASE::Zone, ProdOrderLine."Zone Code FND", UnitTestingValueL);
                UnitTestingValueL.VALIDATE("Value 2", ProdOrderLine."Zone Code FND");
                UnitTestingValueL.MODIFY();
                AddZoneCode1 := ProdOrderLine."Zone Code FND";
            end;

            // Production BOM Version
            ProductionBOMVersion.RESET();
            ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
            //ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No.");//Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
            ProductionBOMVersion.SETRANGE("Active FND", true);
            if ProductionBOMVersion.FINDFIRST() then begin
                CreateUnitTestingValues('PRD066', 'Adjust BoM BRIGHT BEER', DATABASE::"Production BOM Version", ProductionBOMVersion."Version Code", UnitTestingValueL);
                ProdBOMVersionCode := ProductionBOMVersion."Version Code";
            end;

            // Item
            CreateUnitTestingValues('PRD055', 'Create RPO for BRIGHT BEER Manually Fil&Mix', DATABASE::Item, FinishedProductionOrder."Source No.", UnitTestingValueL);
            // Deletion of a Component
            j := 0;
            ProductionBOMLine.RESET();
            ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
            //ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No.");//
            ProductionBOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
            ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
            ProductionBOMLine.SETFILTER("Quantity per", '<%1', 0);
            if ProductionBOMLine.ISEMPTY then
                ProductionBOMLine.SETRANGE("Quantity per");
            if ProductionBOMLine.FINDFIRST() then
                repeat
                    j += 1;
                    if j = 2 then
                        UnitTestingValueL.VALIDATE("Value 3", ProductionBOMLine."No.");
                until (ProductionBOMLine.NEXT() = 0) or (j = 2);

            // Addition of New Component
            UnitTestingValueL.VALIDATE("Value 2", GetAddItemComponent(AddBinCode1));
            if UnitTestingValueL."Value 2" = '' then begin
                UnitTestingValWort.RESET();
                UnitTestingValWort.SETRANGE("Test Script Code", 'PRD001');
                UnitTestingValWort.SETRANGE("Table ID", DATABASE::Item);
                if UnitTestingValWort.FINDFIRST() then
                    UnitTestingValueL.VALIDATE("Value 2", UnitTestingValWort."Value 2");
                CheckItemBinContent(UnitTestingValWort."Value 2", FinishedProductionOrder."Location Code", AddZoneCode1, '');
            end;
            if UnitTestingValueL."Value 2" = UnitTestingValueL."Value 3" then begin
                ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
                //ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No.");//Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
                ProductionBOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
                ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
                if ProductionBOMLine.FINDFIRST() then
                    UnitTestingValueL.VALIDATE("Value 3", ProductionBOMLine."No.");
            end;
            UnitTestingValueL.MODIFY();
            AddItem1 := UnitTestingValueL."Value 2";

            // Bin
            BinL.RESET();
            BinL.SETRANGE("Location Code", FinishedProductionOrder."Location Code");
            BinL.SETRANGE("Zone Code", AddZoneCode1);
            if BinL.FINDFIRST() then
                CreateUnitTestingValues('PRD055', 'Create RPO for BRIGHT BEER Manually Fil&Mix', DATABASE::Bin, BinL.Code, UnitTestingValueL);
            UnitTestingValueL.VALIDATE("Value 2", AddBinCode1);
            UnitTestingValueL.MODIFY();

            // Resource selection of available tanks
            CreateUnitTestingValues('PRD059', 'Resource selection of available tanks BRIGHT BEER', DATABASE::Item, AddItem1, UnitTestingValueL);
            CheckItemBinContent(AddItem1, FinishedProductionOrder."Location Code", AddZoneCode1, AddBinCode1);
            CreateUnitTestingValues('PRD059', 'Resource selection of available tanks BRIGHT BEER', DATABASE::Bin, AddBinCode1, UnitTestingValueL);

            // Routing Version
            RoutingVersion.RESET();
            //   RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No.");
            RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No. 112FDW");//BC Upgrade Kamnay01

            RoutingVersion.SETRANGE("Active FND", true);
            if RoutingVersion.FINDFIRST() then begin
                CreateUnitTestingValues('PRD054', 'Adjust Routing for BRIGHT BEER', DATABASE::"Routing Version", RoutingVersion."Version Code", UnitTestingValueL);
                // Work Center
                RoutingLine.RESET();
                RoutingLine.SETRANGE("Routing No.", RoutingVersion."Routing No.");
                RoutingLine.SETRANGE("Version Code", RoutingVersion."Version Code");
                RoutingLine.SETRANGE(Type, RoutingLine.Type::"Work Center");
                if RoutingLine.FINDFIRST() then
                    CreateUnitTestingValues('PRD054', 'Adjust Routing for BRIGHT BEER', DATABASE::"Work Center", RoutingLine."Work Center No.", UnitTestingValueL);
            end;
        end;
    end;

    local procedure InsertPackagingOp();
    var
        UnitTestingValueL: Record "Unit Testing Value FND";
        RoutingVersion: Record "Routing Version";
        RoutingLine: Record "Routing Line";
        ProductionBOMVersion: Record "Production BOM Version";
        ProductionBOMLine: Record "Production BOM Line";
        ProdOrderLine: Record "Prod. Order Line";
        Item: Record Item;
        StockkeepingUnit: Record "Stockkeeping Unit";
        BinL: Record Bin;
        ProdBOMVersionCode: Code[20];
        j: Integer;
        DeletedItem: Code[20];
        OrderAvail: Boolean;
    begin
        CLEAR(AddBinCode1);
        CLEAR(AddItem1);
        CLEAR(DeletedItem);
        CLEAR(AddZoneCode1);
        CLEAR(OrderAvail);//HEI.19
        Item.RESET();
        Item.SETCURRENTKEY(Inventory);
        Item.SETRANGE("Batch Number Policy FND", Item."Batch Number Policy FND"::"Finished Product Own Produced");
        Item.SETRANGE("Gen. Prod. Posting Group", 'FGPB');
        Item.SETRANGE("Item Category Code", '01');
        //  Item.SETRANGE("Item Tracking Code", 'LOTALLEXP'); //BC Upgrade Kamnay01 // Need to discussed but changing this for temprory purpose to get the data
        Item.SETRANGE("Item Tracking Code", 'LOTALLEXPV');//BC Upgrade Kamnay01 // Need to discussed but changing this for temprory purpose to get the data 

        Item.SETRANGE("Costing Method", Item."Costing Method"::Standard);
        Item.SETFILTER(Inventory, '>%1', 100);
        Item.SETRANGE(Blocked, false);
        if Item.FINDLAST() then begin
            repeat
                //HEI.19>>
                if OrderAvail then
                    exit;
                //HEI.19  <<
                FinishedProductionOrder.RESET();
                FinishedProductionOrder.SETRANGE(Status, FinishedProductionOrder.Status::Finished);
                 FinishedProductionOrder.SETRANGE("Source No.", Item."No.");
                // //FinishedProductionOrder.SETFILTER("Production BOM No.", '<>%1', '');//HEI.23 //Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
                // //FinishedProductionOrder.SETFILTER("Production BOM Version Code", '<>%1', '');//HEI.23 //Commented code related to-DRINK-IT field-"Production BOM Version Code" of Table-"Production Order" Table.
                // FinishedProductionOrder.SETFILTER("Routing No.", '<>%1', '');//HEI.23
                //FinishedProductionOrder.SETFILTER("Routing Version Code", '<>%1', '');//HEI.23 //Commented code related to-DRINK-IT field-"Routing Version Code" of Table-"Production Order" Table.
                FinishedProductionOrder.SETFILTER("Prod. BOM No. 112FDW", '<>%1', '');//HEI.23 //BC Upgrade Kamnay01
                FinishedProductionOrder.SETFILTER("Prod. BOM Vrsn Code 112FDW", '<>%1', '');//HEI.23//BC Upgrade Kamnay01
                FinishedProductionOrder.SETFILTER("Routing No. 112FDW", '<>%1', '');//HEI.23
                FinishedProductionOrder.SETFILTER("Routing Vrsn Code 112FDW", '<>%1', '');//HEI.23 //BC Upgrade Kamnay01
                if FinishedProductionOrder.FINDLAST() then begin
                    OrderAvail := true;//HEI.19
                                       // Location
                    CreateUnitTestingValues('PRD071', 'Create FPPO for Packaging Ops', DATABASE::Location, FinishedProductionOrder."Location Code", UnitTestingValueL);

                    // Zone
                    ProdOrderLine.RESET();
                    ProdOrderLine.SETRANGE("Prod. Order No.", FinishedProductionOrder."No.");
                    ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Finished);
                    if ProdOrderLine.FINDFIRST() then begin
                        CreateUnitTestingValues('PRD071', 'Create FPPO for Packaging Ops', DATABASE::Zone, ProdOrderLine."Zone Code FND", UnitTestingValueL);
                        UnitTestingValueL.VALIDATE("Value 2", ProdOrderLine."Zone Code FND");
                        UnitTestingValueL.MODIFY();
                        AddZoneCode1 := ProdOrderLine."Zone Code FND";
                    end;

                    // Production BOM Version
                    ProductionBOMVersion.RESET();
                    ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
                    //ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No."); //Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
                    ProductionBOMVersion.SETRANGE("Active FND", true);
                    if ProductionBOMVersion.FINDFIRST() then begin
                        CreateUnitTestingValues('PRD077', 'Adjust BoM Packaging Ops', DATABASE::"Production BOM Version", ProductionBOMVersion."Version Code", UnitTestingValueL);
                        ProdBOMVersionCode := ProductionBOMVersion."Version Code";
                        //HEI.21>>
                    end else begin
                        //Update the BOM Active Version
                        BOMVErUpdated := false;
                        ProductionBOMVersion.RESET();
                        ProductionBOMVersion.SETCURRENTKEY("Production BOM No.", Status);
                        ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
                        //ProductionBOMVersion.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No."); //Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
                        ProductionBOMVersion.SETRANGE(Status, ProductionBOMVersion.Status::Certified);
                        if ProductionBOMVersion.FINDFIRST() then
                            repeat
                                if not BOMVErUpdated then begin
                                    ProductionBOMLine.RESET();
                                    ProductionBOMLine.SETRANGE("Production BOM No.", ProductionBOMVersion."Production BOM No.");
                                    ProductionBOMLine.SETRANGE("Version Code", ProductionBOMVersion."Version Code");
                                    if ProductionBOMLine.FINDFIRST() then begin
                                        ProductionBOMVersion."Active FND" := true;
                                        ProductionBOMVersion.MODIFY();
                                        CreateUnitTestingValues('PRD077', 'Adjust BoM Packaging Ops', DATABASE::"Production BOM Version", ProductionBOMVersion."Version Code", UnitTestingValueL);
                                        ProdBOMVersionCode := ProductionBOMVersion."Version Code";
                                        BOMVErUpdated := true;
                                    end;
                                end;
                            until ProductionBOMVersion.NEXT() = 0;
                    end;
                    //HEI.21<<

                    // Item
                    CreateUnitTestingValues('PRD071', 'Create FPPO for Packaging Ops', DATABASE::Item, FinishedProductionOrder."Source No.", UnitTestingValueL);
                    // Deletion of a Component
                    j := 0;
                    ProductionBOMLine.RESET();
                    ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Prod. BOM No. 112FDW");//BC Upgrade Kamnay01
                    //ProductionBOMLine.SETRANGE("Production BOM No.", FinishedProductionOrder."Production BOM No.");//Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order" Table.
                    ProductionBOMLine.SETRANGE("Version Code", ProdBOMVersionCode);
                    ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
                    ProductionBOMLine.SETFILTER("Quantity per", '<%1', 0);
                    if ProductionBOMLine.FINDFIRST() then
                        UnitTestingValueL.VALIDATE("Value 3", ProductionBOMLine."No.");
                    if UnitTestingValueL."Value 3" = '' then begin
                        ProductionBOMLine.SETRANGE("Quantity per");
                        if ProductionBOMLine.FINDFIRST() then
                            repeat
                                j += 1;
                                if j = 2 then
                                    UnitTestingValueL.VALIDATE("Value 3", ProductionBOMLine."No.");
                            until (ProductionBOMLine.NEXT() = 0) or (j = 2);
                    end;
                    DeletedItem := UnitTestingValueL."Value 3";

                    // Addition of New Component
                    UnitTestingValWort.RESET();
                    UnitTestingValWort.SETRANGE("Test Script Code", 'PRD001');
                    UnitTestingValWort.SETRANGE("Table ID", DATABASE::Item);
                    if UnitTestingValWort.FINDFIRST() then
                        UnitTestingValueL.VALIDATE("Value 2", UnitTestingValWort.Value);
                    CheckItemBinContent(UnitTestingValWort.Value, FinishedProductionOrder."Location Code", AddZoneCode1, '');
                    UnitTestingValueL.MODIFY();
                    AddItem1 := UnitTestingValueL."Value 2";

                    // Bin
                    BinL.RESET();
                    BinL.SETRANGE("Location Code", FinishedProductionOrder."Location Code");
                    BinL.SETRANGE("Zone Code", AddZoneCode1);
                    if BinL.FINDFIRST() then begin //HEI.24
                        CreateUnitTestingValues('PRD071', 'Create FPPO for Packaging Ops', DATABASE::Bin, BinL.Code, UnitTestingValueL);
                        //HEI.24>>
                        if BinL."Batch Production Resource FND" = '' then begin
                            BinL."Batch Production Resource FND" := COPYSTR(BinL.Code, 1, 1);
                            BinL.MODIFY();
                        end;
                    end;
                    //HEI.24<<
                    UnitTestingValueL.VALIDATE("Value 2", AddBinCode1);
                    UnitTestingValueL.MODIFY();

                    // Adjust BOM for Packaging Operations
                    CreateUnitTestingValues('PRD077', 'Adjust BoM Packaging Ops', DATABASE::Location, FinishedProductionOrder."Location Code", UnitTestingValueL);
                    CreateUnitTestingValues('PRD077', 'Adjust BoM Packaging Ops', DATABASE::Item, AddItem1, UnitTestingValueL);
                    UnitTestingValueL.VALIDATE("Value 2", DeletedItem);
                    UnitTestingValueL.VALIDATE("Value 3", DeletedItem);
                    UnitTestingValueL.MODIFY();
                    CreateUnitTestingValues('PRD077', 'Adjust BoM Packaging Ops', DATABASE::Zone, AddZoneCode1, UnitTestingValueL);
                    CheckItemBinContent(AddItem1, FinishedProductionOrder."Location Code", AddZoneCode1, AddBinCode1);
                    CreateUnitTestingValues('PRD077', 'Adjust BoM Packaging Ops', DATABASE::Bin, AddBinCode1, UnitTestingValueL);

                    // Routing Version
                    RoutingVersion.RESET();
                    RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No. 112FDW");//BC Upgrade Kamnay01
                    //   RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No.");
                    RoutingVersion.SETRANGE("Active FND", true);
                    if RoutingVersion.FINDFIRST() then begin
                        CreateUnitTestingValues('PRD075', 'Adjust Routing for Packaging Ops', DATABASE::"Routing Version", RoutingVersion."Version Code", UnitTestingValueL);
                        // Work Center
                        RoutingLine.RESET();
                        RoutingLine.SETRANGE("Routing No.", RoutingVersion."Routing No.");
                        RoutingLine.SETRANGE("Version Code", RoutingVersion."Version Code");
                        RoutingLine.SETRANGE(Type, RoutingLine.Type::"Work Center");
                        if RoutingLine.FINDFIRST() then
                            CreateUnitTestingValues('PRD075', 'Adjust Routing for Packaging Ops', DATABASE::"Work Center", RoutingLine."Work Center No.", UnitTestingValueL);
                        //HEI.23>>
                        //END;
                    end else begin
                        RoutingVersion.RESET();
                        RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No. 112FDW");//BC Upgrade Kamnay01
                        //    RoutingVersion.SETRANGE("Routing No.", FinishedProductionOrder."Routing No.");
                        if RoutingVersion.FINDFIRST() then begin
                            RoutingVersion."Active FND" := true;
                            RoutingVersion.MODIFY();
                            CreateUnitTestingValues('PRD075', 'Adjust Routing for Packaging Ops', DATABASE::"Routing Version", RoutingVersion."Version Code", UnitTestingValueL);
                            // Work Center
                            RoutingLine.RESET();
                            RoutingLine.SETRANGE("Routing No.", RoutingVersion."Routing No.");
                            RoutingLine.SETRANGE("Version Code", RoutingVersion."Version Code");
                            RoutingLine.SETRANGE(Type, RoutingLine.Type::"Work Center");
                            if RoutingLine.FINDFIRST() then
                                CreateUnitTestingValues('PRD075', 'Adjust Routing for Packaging Ops', DATABASE::"Work Center", RoutingLine."Work Center No.", UnitTestingValueL);
                        end;
                    end;
                    //HEI.23<<

                    //  Move FPs to Logistics
                    CreateUnitTestingValues('PRD080', 'Move FPs to Logistics Packaging Ops', DATABASE::Location, FinishedProductionOrder."Location Code", UnitTestingValueL);
                    CreateUnitTestingValues('PRD080', 'Move FPs to Logistics Packaging Ops', DATABASE::Item, FinishedProductionOrder."Source No.", UnitTestingValueL);
                    CreateUnitTestingValues('PRD080', 'Move FPs to Logistics Packaging Ops', DATABASE::Zone, AddZoneCode1, UnitTestingValueL);
                    UnitTestingValueL.VALIDATE("Value 2", 'FPWH01');
                    UnitTestingValueL.MODIFY();
                    CreateUnitTestingValues('PRD080', 'Move FPs to Logistics Packaging Ops', DATABASE::Bin, ProdOrderLine."Bin Code", UnitTestingValueL);
                end;
            until Item.NEXT(-1) = 0 //HEI.19
        end;
    end;

    local procedure InsertGoodsIssuetoCostCentre();
    var
        Item: Record Item;
        UnitTestingValueL: Record "Unit Testing Value FND";
        BinContent: Record "Bin Content";
    begin
        //HEI.03<<
        Item.RESET();
        Item.SETCURRENTKEY(Inventory);
        Item.SETRANGE("Gen. Prod. Posting Group", 'RAWM');
        Item.SETRANGE("Inventory Posting Group", 'RAWM');
        Item.SETFILTER("Item Tracking Code", '<>%1', '');
        Item.SETFILTER("Global Dimension 2 Code", '<>%1', '');
        Item.SETRANGE(Type, Item.Type::Inventory);
        Item.SETFILTER(Inventory, '>%1', 100);
        Item.SETRANGE(Blocked, false);
        if Item.ISEMPTY then
            Item.SETRANGE("Global Dimension 2 Code");
        if Item.FINDLAST() then;

        BinContent.RESET();
        BinContent.SETCURRENTKEY("Quantity Unrestrict (Base) FND");
        BinContent.SETRANGE("Item No.", Item."No.");
        BinContent.SETFILTER("Bin Code", '<>%1', 'INTR01');//HEI.17
        if BinContent.FINDLAST() then;
        CreateUnitTestingValues('DTW003', 'Goods Post to GL', DATABASE::Item, Item."No.", UnitTestingValueL);
        CreateUnitTestingValues('DTW003', 'Goods Post to GL', DATABASE::"Item Journal Template", 'ITEM', UnitTestingValueL);
        CreateUnitTestingValues('DTW003', 'Goods Post to GL', DATABASE::"Item Journal Batch", 'DEFAULT', UnitTestingValueL);
        CreateUnitTestingValues('DTW003', 'Goods Post to GL', DATABASE::Location, BinContent."Location Code", UnitTestingValueL);
        CreateUnitTestingValues('DTW003', 'Goods Post to GL', DATABASE::Zone, BinContent."Zone Code", UnitTestingValueL);
        CreateUnitTestingValues('DTW003', 'Goods Post to GL', DATABASE::Bin, BinContent."Bin Code", UnitTestingValueL);
        CreateUnitTestingValues('DTW003', 'Goods Post to GL', DATABASE::"Dimension Value", Item."Global Dimension 2 Code", UnitTestingValueL);
        //HEI.03>>
    end;

    local procedure InsertBookingStockforRecoveredBeer();
    var
        Item: Record Item;
        UnitTestingValueL: Record "Unit Testing Value FND";
        BinContent: Record "Bin Content";
    begin
        //HEI.03<<
        Item.RESET();
        Item.SETCURRENTKEY(Inventory);
        Item.SETRANGE("Gen. Prod. Posting Group", 'SFGD');
        Item.SETRANGE("Inventory Posting Group", 'SFGD');
        Item.SETFILTER("Item Tracking Code", '<>%1', '');
        Item.SETFILTER("Global Dimension 2 Code", '<>%1', '');
        Item.SETRANGE(Type, Item.Type::Inventory);
        //Item.SETFILTER(Inventory,'>%1',100); HEI.09
        Item.SETFILTER(Inventory, '>%1', 0);//HEI.09
        Item.SETRANGE(Blocked, false);
        Item.SETFILTER("Item Category Code", '=%1', '07');
        Item.SETFILTER("Description 2", '%1', '@*BRIGHT BEER*');
        if Item.ISEMPTY then
            Item.SETRANGE("Global Dimension 2 Code");
        if Item.FINDLAST() then;

        BinContent.RESET();
        BinContent.SETCURRENTKEY("Quantity Unrestrict (Base) FND");
        BinContent.SETRANGE("Item No.", Item."No.");
        if BinContent.FINDLAST() then;
        CreateUnitTestingValues('PRD085', 'Booking Stock for Recovered Beer', DATABASE::Item, Item."No.", UnitTestingValueL);
        CreateUnitTestingValues('PRD085', 'Booking Stock for Recovered Beer', DATABASE::"Item Journal Template", 'ITEM', UnitTestingValueL);
        CreateUnitTestingValues('PRD085', 'Booking Stock for Recovered Beer', DATABASE::"Item Journal Batch", 'DEFAULT', UnitTestingValueL);
        CreateUnitTestingValues('PRD085', 'Booking Stock for Recovered Beer', DATABASE::Location, BinContent."Location Code", UnitTestingValueL);
        CreateUnitTestingValues('PRD085', 'Booking Stock for Recovered Beer', DATABASE::Zone, BinContent."Zone Code", UnitTestingValueL);
        CreateUnitTestingValues('PRD085', 'Booking Stock for Recovered Beer', DATABASE::Bin, BinContent."Bin Code", UnitTestingValueL);

        //HEI.03 >> ------- PRD086 and PRD087 testscripts uses the same data of PRD085
    end;

    procedure SetParameters(pCreateGenJournalUsers: Boolean; pCreateWarehouseEmployees: Boolean; pDeleteExistingValues: Boolean; pHideDialogs: Boolean);
    begin
        //HEI.04>>
        //CreateGenJournalUsers:=pCreateGenJournalUsers;
        //CreateWarehouseEmployees:=pCreateWarehouseEmployees;
        //DeleteExistingValues:=pDeleteExistingValues;
        CurrReport.USEREQUESTPAGE(false);
        HideDialogs := pHideDialogs;
        //HEI.04<<
    end;

    local procedure CreateWarehouseEmployeesForUser(UserName: Code[50]; LocationCode: Code[10]; ZoneCode: Code[10]);
    var
        WarehouseEmployee: Record "Warehouse Employee_DTW FND";
        Location: Record Location;
        Zone: Record Zone;
    begin
        //HEI.05>>
        if UserName = '' then
            exit;

        if (LocationCode = '') and (ZoneCode = '') then begin
            //Mass creation
            if Location.FINDSET() then
                repeat
                    Zone.SETRANGE("Location Code", Location.Code);
                    if Zone.FINDSET() then
                        repeat
                            WarehouseEmployee.RESET();
                            // BC UPGRADE PATELS08 >> # Too many key fields were specified, so "Warehouse Employee" could not be retrieved. The number of fields in the primary key is 2.
                            // if not WarehouseEmployee.GET(UserName, Location.Code, '', Zone.Code) then
                            // if not WarehouseEmployee.GET(UserName, Location.Code) then
                            //     // BC UPGRADE PATELS08 <<
                            //     InsertWarehouseEmployee(UserName, Location.Code, Zone.Code);

                            //BC Upgrade Kamnay01 >>
                            if not WarehouseEmployee.GET(UserName, Location.Code, Zone.Code) then
                                InsertWarehouseEmployee(UserName, Location.Code, Zone.Code);
                        //BC Upgrade Kamnay01 <<
                        until Zone.NEXT() = 0;
                until Location.NEXT() = 0;
        end else
            //Creation for specific Location
            if LocationCode <> '' then begin
                if not Location.GET(LocationCode) then
                    exit;
                //A specific Zone
                if ZoneCode <> '' then begin
                    if not Zone.GET(LocationCode, ZoneCode) then
                        exit;

                    // BC UPGRADE PATELS08 >> # Too many key fields were specified, so "Warehouse Employee" could not be retrieved. The number of fields in the primary key is 2.
                    // if not WarehouseEmployee.GET(UserName, LocationCode, '', ZoneCode) then
                    //   if not WarehouseEmployee.GET(UserName, LocationCode) then
                    // BC UPGRADE PATELS08 <<
                    //BC Upgrade Kamnay01 >>
                    if not WarehouseEmployee.GET(UserName, Location.Code, Zone.Code) then
                        //BC Upgrade Kamnay01 <<
                        InsertWarehouseEmployee(UserName, LocationCode, ZoneCode);
                end else begin
                    //All Zones
                    Zone.SETRANGE("Location Code", LocationCode);
                    if Zone.FINDSET() then
                        repeat
                            WarehouseEmployee.RESET();
                            // BC UPGRADE PATELS08 >> # Too many key fields were specified, so "Warehouse Employee" could not be retrieved. The number of fields in the primary key is 2.
                            // if not WarehouseEmployee.GET(UserName, LocationCode, '', Zone.Code) then
                            //  if not WarehouseEmployee.GET(UserName, LocationCode) then
                            // BC UPGRADE PATELS08 <<
                            //BC Upgrade Kamnay01 >>
                            if not WarehouseEmployee.GET(UserName, Location.Code, Zone.Code) then
                                //BC Upgrade Kamnay01 <<
                                InsertWarehouseEmployee(UserName, LocationCode, Zone.Code);
                        until Zone.NEXT() = 0;
                end;
            end;
        //No creation for other cases
        //HEI.05<<
    end;

    local procedure InsertWarehouseEmployee(UserName: Code[50]; LocationCode: Code[10]; ZoneCode: Code[10]);
    var
        WarehouseEmployee: Record "Warehouse Employee_DTW FND";
    begin
        //HEI.05>>
        WarehouseEmployee.INIT();
        WarehouseEmployee.VALIDATE("User ID", UserName);
        WarehouseEmployee.VALIDATE("Location Code", LocationCode);
        WarehouseEmployee.VALIDATE("Zone Code", ZoneCode);
        WarehouseEmployee.INSERT(true);
        //HEI.05<<
    end;

    local procedure CreateUserGeneralJournalForUser(UserName: Code[50]; JournalType: Option General,Item; GenJournalType: Option General,Sales,Purchases,"Cash Receipts",Payments,Assets,Intercompany,Jobs,item);
    var
        UserGenJournalSetup: Record "User Gen. Journal Setup FND";
        GenJournalTemplate: Record "Gen. Journal Template";
        ItemJournalTemplate: Record "Item Journal Template";
    begin
        //HEI.05>>
        if UserName = '' then
            exit;

        UserGenJournalSetup.RESET();
        GenJournalTemplate.RESET();
        GenJournalTemplate.SETRANGE(Type, GenJournalType);
        if GenJournalTemplate.FINDSET() then
            repeat
                UserGenJournalSetup.SETRANGE("Journal Type", JournalType);
                UserGenJournalSetup.SETRANGE("Gen. Journal Template Name", GenJournalTemplate.Name);
                UserGenJournalSetup.SETRANGE("User ID", UserName);
                if not UserGenJournalSetup.FINDFIRST() then begin
                    UserGenJournalSetup.INIT();
                    UserGenJournalSetup.VALIDATE("Journal Type", JournalType);
                    UserGenJournalSetup.VALIDATE("Gen. Journal Template Name", GenJournalTemplate.Name);
                    UserGenJournalSetup.VALIDATE("User ID", UserName);
                    UserGenJournalSetup.INSERT();
                end;
            until GenJournalTemplate.NEXT() = 0;
        //HEI.05<<
        //HEI.07>>
        if JournalType = JournalType::Item then begin
            UserGenJournalSetup.RESET();
            ItemJournalTemplate.RESET();
            ItemJournalTemplate.SETRANGE(Type, ItemJournalTemplate.Type::Item);
            if ItemJournalTemplate.FINDSET(false) then
                repeat
                    UserGenJournalSetup.SETRANGE("Journal Type", JournalType);
                    UserGenJournalSetup.SETRANGE("Gen. Journal Template Name", ItemJournalTemplate.Name);
                    UserGenJournalSetup.SETRANGE("User ID", UserName);
                    if not UserGenJournalSetup.FINDFIRST() then begin
                        UserGenJournalSetup.INIT();
                        UserGenJournalSetup.VALIDATE("Journal Type", JournalType);
                        UserGenJournalSetup.VALIDATE("Gen. Journal Template Name", ItemJournalTemplate.Name);
                        UserGenJournalSetup.VALIDATE("User ID", UserName);
                        UserGenJournalSetup.INSERT();
                    end;
                until ItemJournalTemplate.NEXT() = 0;
        end;

        //HEI.07<<
    end;
    //BC Upgrade KAPOOV01 Commented procedure CreateQualityUsers() dependent on DRINK-IT Table-"Quality User" >>
    // local procedure CreateQualityUsers();
    // var
    //     QualityUsers: Record "Quality User";
    // begin
    //     //HEI.05>>
    //     QualityUsers.RESET;
    //     QualityUsers.SETRANGE("User ID", USERID);
    //     if not QualityUsers.FINDFIRST then begin
    //         QualityUsers.INIT;
    //         QualityUsers."User ID" := USERID;
    //         QualityUsers."Block Quality Tracked Lots" := true;
    //         QualityUsers."Unblock Quality Tracked Lots" := true;
    //         QualityUsers.INSERT;
    //     end;
    //     //HEI.05<<
    // end;
    //BC Upgrade KAPOOV01 Commented procedure CreateQualityUsers() dependent on DRINK-IT Table-"Quality User" <<

    local procedure InsertProductionBOM();
    var
        ProductionBOMHeader: Record "Production BOM Header";
        UnitTestingValueL: Record "Unit Testing Value FND";
        ItemL: Record Item;
        RoutingLink: Record "Routing Link";
        ItemNo: Code[20];
        DocumentNo: Code[20];
        LastDoc: Code[20];
        DocumentFilter: Text;
        NewDocNo: Text;
        BomLine: Record "Production BOM Line";
    begin
        //HEI.06 >>
        ProductionBOMHeader.RESET();
        ProductionBOMHeader.SETRANGE(Status, ProductionBOMHeader.Status::Certified);
        if ProductionBOMHeader.FINDFIRST() then begin
            CreateUnitTestingValues('PRD090', 'Create a BOM', DATABASE::Item, ProductionBOMHeader."Linked Item No. FND", UnitTestingValueL);
            ItemNo := UnitTestingValueL.Value;
            ItemL.SETFILTER("Item Category Code", '%1', '02');
            ItemL.SETRANGE(Blocked, false);
            if ItemL.FINDFIRST() then begin
                UnitTestingValueL.VALIDATE("Value 2", ItemL."No.");
                ItemL.SETFILTER("No.", '<>%1', UnitTestingValueL."Value 2");
                if ItemL.FINDFIRST() then
                    UnitTestingValueL.VALIDATE("Value 3", ItemL."No.");
                UnitTestingValueL.MODIFY();
            end;
            CreateUnitTestingValues('PRD090', 'Create a BOM', DATABASE::Location, ProductionBOMHeader."Linked SKU FND", UnitTestingValueL);
            CreateUnitTestingValues('PRD090', 'Create a BOM', DATABASE::"Unit of Measure", ProductionBOMHeader."Unit of Measure Code", UnitTestingValueL);

            DocumentNo := DELCHR(ItemNo, '<', '00');
            DocumentFilter := '*' + DocumentNo;
            ProductionBOMHeader.RESET();
            ProductionBOMHeader.SETFILTER("No.", '%1', DocumentFilter);
            if ProductionBOMHeader.FINDLAST() then
                LastDoc := ProductionBOMHeader."No.";

            LastDoc := COPYSTR(LastDoc, 1, 2);
            LastDoc := INCSTR(LastDoc);
            NewDocNo := INSSTR(DocumentNo, LastDoc, 1);

            RoutingLink.RESET();
            RoutingLink.SETRANGE(Code, NewDocNo);
            if RoutingLink.ISEMPTY then begin
                RoutingLink.INIT();
                RoutingLink.VALIDATE(Code, NewDocNo);
                RoutingLink.INSERT();
            end else
                RoutingLink.FINDFIRST();

            CreateUnitTestingValues('PRD090', 'Create a BOM', DATABASE::"Routing Link", RoutingLink.Code, UnitTestingValueL);

        end;
        //HEI.11>>
        ProductionBOMHeader.RESET();
        ProductionBOMHeader.SETCURRENTKEY("No.");
        ProductionBOMHeader.SETRANGE(Status, ProductionBOMHeader.Status::Certified);
        if ProductionBOMHeader.FINDSET(false) then
            repeat
                BomLine.RESET();
                BomLine.SETRANGE("Production BOM No.", ProductionBOMHeader."No.");
                BomLine.SETFILTER("Version Code", '<>%1', '');
                if BomLine.FINDSET() then begin
                    if BomLine.COUNT > 2 then begin
                        CreateUnitTestingValues('PRD090', 'Change of BOM', DATABASE::"Production BOM Header", ProductionBOMHeader."No.", UnitTestingValueL);
                        exit;
                    end;
                end;
            until ProductionBOMHeader.NEXT() = 0;
        //HEI.11<<
        //HEI.06 <<
    end;

    local procedure GetAddItemComponentInventory(var BinCodeAddP: Code[20]) ItemAdd: Code[20];
    var
        Item: Record Item;
        BinContent: Record "Bin Content";
    begin
        //HEI.07>>
        Item.RESET();
        Item.SETCURRENTKEY(Inventory);
        Item.SETRANGE("Gen. Prod. Posting Group", 'RAWM');
        Item.SETRANGE("Inventory Posting Group", 'RAWM');
        Item.SETFILTER("Item Tracking Code", '<>%1', '');
        Item.SETFILTER("Global Dimension 2 Code", '<>%1', '');
        Item.SETRANGE(Type, Item.Type::Inventory);
        Item.SETFILTER(Inventory, '>%1', 100);
        Item.SETRANGE(Blocked, false);
        if Item.ISEMPTY then
            Item.SETRANGE("Global Dimension 2 Code");
        if Item.FINDLAST() then
            repeat
                //HEI.26>>
                /*
                CreateInventory.InitParameters(Item."No.",FinishedProductionOrder."Location Code",AddZoneCode1,AddBinCode1,1000,'DETER','EDO12');
                CreateInventory.USEREQUESTPAGE(FALSE);
                CreateInventory.RUN;
                */
                UpdateItemInvDTW2InitParameters(Item."No.", FinishedProductionOrder."Location Code", AddZoneCode1, AddBinCode1, 1000, 'DETER', 'EDO12');
                //HEI.26<<
                BinContent.RESET();
                BinContent.SETRANGE("Item No.", Item."No.");
                BinContent.SETRANGE("Location Code", FinishedProductionOrder."Location Code");
                BinContent.SETRANGE("Zone Code", AddZoneCode1);
                BinContent.SETFILTER(Quantity, '>%1', 100);
                if BinContent.FINDFIRST() then begin
                    BinCodeAddP := BinContent."Bin Code";
                    exit(BinContent."Item No.");
                end;
            until Item.NEXT(-1) = 0;
        //HEI.07<<

    end;

    local procedure CreateItemtemplatebatch();
    var
        ItemTemplate: Record "Item Journal Template";
        ItemBatch: Record "Item Journal Batch";
    begin
        //HEI.07>>
        ItemTemplate.RESET();
        ItemBatch.RESET();
        ItemTemplate.SETRANGE(Name, 'ITEM');
        if not ItemTemplate.FINDLAST() then begin
            ItemTemplate.INIT();
            ItemTemplate.Name := 'ITEM';
            ItemTemplate."Source Code" := 'ITEMJNL';
            ItemTemplate.INSERT();
        end;
        ItemBatch.SETRANGE("Journal Template Name", ItemTemplate.Name);
        ItemBatch.SETRANGE(Name, 'DEFAULT');
        if not ItemBatch.FINDLAST() then begin
            ItemBatch.INIT();
            ItemBatch."Journal Template Name" := 'ITEM';
            ItemBatch.Name := 'DEFAULT';
            ItemBatch.INSERT();
        end;
        //<<HEI.07
    end;

    local procedure CheckPreRequestSetups();
    var
        MFGSetup: Record "Manufacturing Setup";
        UserSetup: Record "User Setup";
        FinishedProd: Record "Production Order";
        FinishedProdLine: Record "Prod. Order Line";
        ProdBOMComp: Record "Production BOM Line";
        ProdBOMHdr: Record "Production BOM Version";
        ItemRec: Record Item;
    begin
        //HEI.07>>
        UserSetup.RESET();
        if not UserSetup.GET(USERID) then begin
            UserSetup.INIT();
            UserSetup.VALIDATE("User ID", USERID);
            UserSetup.VALIDATE("Consump. Tolerance Warning FND", true);
            UserSetup.INSERT();
        end;
        MFGSetup.GET();
        if MFGSetup."CMG Dimension Code FND" <> 'CMG' then begin
            MFGSetup."CMG Dimension Code FND" := 'CMG';
            MFGSetup.MODIFY();
        end;
        if MFGSetup."CMG Values for Neg Consmp FND" <> 'CMG0083|CMG0418|CMG9999' then begin
            MFGSetup."CMG Values for Neg Consmp FND" := 'CMG0083|CMG0418|CMG9999';
            MFGSetup.MODIFY();
        end;
        //Commented code related to-DRINK-IT field-"Prod. Jnl. Flushing (Time)" of Table-"Prod. Jnl. Flushing (Time)" Table. >>
        // if not MFGSetup."Prod. Jnl. Flushing (Time)" then begin
        //     MFGSetup."Prod. Jnl. Flushing (Time)" := true;
        //     MFGSetup.MODIFY;
        // end;
        //Commented code related to-DRINK-IT field-"Prod. Jnl. Flushing (Time)" of Table-"Prod. Jnl. Flushing (Time)" Table. <<
        //<<HEI.07
        //HEI.08>>
        FinishedProd.RESET();
        FinishedProdLine.RESET();
        FinishedProd.SETRANGE(Status, FinishedProd.Status::Finished);
        FinishedProd.SETFILTER("Description 2", '<>%1', '');
        if FinishedProd.FINDSET(true) then
            repeat
                FinishedProdLine.SETRANGE(Status, FinishedProd.Status);
                FinishedProdLine.SETRANGE("Prod. Order No.", FinishedProd."No.");
                if not FinishedProdLine.FINDSET() then begin
                    FinishedProd."Description 2" := '';
                    FinishedProd.MODIFY();
                end
                //HEI.15>>
                else begin
                    ProdBOMHdr.RESET();
                    //ProdBOMHdr.SETRANGE("Production BOM No.", FinishedProd."Production BOM No."); //Commented code related to-DRINK-IT field-"Production BOM No." of Table-"Production Order".
                    //ProdBOMHdr.SETRANGE("Version Code", FinishedProd."Production BOM Version Code"); //Commented code related to-DRINK-IT field-"Production BOM Version Code" of Table-"Production Order".
                    //ProdBOMHdr.SETRANGE(Status,ProdBOMHdr.Status::Certified); //HEI.16
                    ProdBOMHdr.SetRange("Production BOM No.", FinishedProd."Prod. BOM No. 112FDW");//BC upgrade kamnay01 
                    ProdBOMHdr.SetRange("Version Code", FinishedProd."Prod. BOM Vrsn Code 112FDW");//BC upgrade kamnay01
                    if ProdBOMHdr.FINDFIRST() then
                        if ProdBOMHdr.Status = ProdBOMHdr.Status::Certified then begin //HEI.16
                            ProdBOMComp.RESET();
                            ProdBOMComp.SETRANGE("Production BOM No.", ProdBOMHdr."Production BOM No.");
                            ProdBOMComp.SETRANGE("Version Code", ProdBOMHdr."Version Code");
                            if not ProdBOMComp.FINDSET(false) then begin
                                FinishedProd."Description 2" := '';
                                FinishedProd.MODIFY();
                            end
                            else begin
                                //HEI.16>>
                                repeat
                                    if ItemRec.GET(ProdBOMComp."No.") then
                                        if ItemRec.Blocked then begin
                                            FinishedProd."Description 2" := '';
                                            FinishedProd.MODIFY();
                                        end;
                                until ProdBOMComp.NEXT() = 0;
                                //HEI.16<<
                                if not ProdBOMHdr."Active FND" then begin
                                    FinishedProd."Description 2" := '';
                                    FinishedProd.MODIFY();
                                end;
                            end;
                            //HEI.16>>
                        end
                        else if ProdBOMHdr.Status <> ProdBOMHdr.Status::Certified then begin
                            FinishedProd."Description 2" := '';
                            FinishedProd.MODIFY();
                        end;
                    if ItemRec.GET(FinishedProdLine."Item No.") then
                        if ItemRec.Blocked then begin
                            FinishedProd."Description 2" := '';
                            FinishedProd.MODIFY();
                        end;
                    //HEI.16<<
                end;
            //HEI.15<<
            until FinishedProd.NEXT() = 0;
        //HEI.08<<
    end;

    local procedure InsertRouting();
    var
        RoutingHeader: Record "Routing Header";
        UnitTestingValueL: Record "Unit Testing Value FND";
        ItemL: Record Item;
        RoutingLink: Record "Routing Link";
        ItemNo: Code[20];
        DocumentNo: Code[20];
        LastDoc: Code[20];
        DocumentFilter: Text;
        NewDocNo: Text;
        Worckcenter: Record "Work Center";
    begin
        //HEI.10 >>
        RoutingHeader.RESET();
        RoutingHeader.SETRANGE(Status, RoutingHeader.Status::Certified);
        if RoutingHeader.FINDFIRST() then begin
            CreateUnitTestingValues('PRDE15', 'Create a Routing version', DATABASE::"Routing Header", RoutingHeader."No.", UnitTestingValueL);

            Worckcenter.RESET();
            Worckcenter.SETRANGE(Blocked, false);
            if Worckcenter.FINDFIRST() then
                CreateUnitTestingValues('PRDE15', 'Create a Routing', DATABASE::"Work Center", Worckcenter."No.", UnitTestingValueL);
            ItemNo := RoutingHeader."Linked Item No. FND";
            CreateUnitTestingValues('PRDE15', 'Create a Routing version', DATABASE::Item, RoutingHeader."Linked Item No. FND", UnitTestingValueL);
            CreateUnitTestingValues('PRDE15', 'Create a Routing version', DATABASE::Location, RoutingHeader."Linked SKU FND", UnitTestingValueL);

            DocumentNo := DELCHR(ItemNo, '<', '00');
            DocumentFilter := '*' + DocumentNo;
            RoutingHeader.RESET();
            RoutingHeader.SETFILTER("No.", '%1', DocumentFilter);
            if RoutingHeader.FINDLAST() then
                LastDoc := RoutingHeader."No.";

            LastDoc := COPYSTR(LastDoc, 1, 2);
            LastDoc := INCSTR(LastDoc);
            NewDocNo := INSSTR(DocumentNo, LastDoc, 1);

            RoutingLink.RESET();
            RoutingLink.SETRANGE(Code, NewDocNo);
            if RoutingLink.ISEMPTY then begin
                RoutingLink.INIT();
                RoutingLink.VALIDATE(Code, NewDocNo);
                RoutingLink.INSERT();
            end else
                RoutingLink.FINDFIRST();

            CreateUnitTestingValues('PRDE15', 'Create a Routing', DATABASE::"Routing Link", RoutingLink.Code, UnitTestingValueL);

        end;
        //HEI.10 <<
    end;

    local procedure PRDR06_ItemReclassJournal_InitData();
    var
        UnitTestingValueL: Record "Unit Testing Value FND";
        IJB: Record "Item Journal Batch";
        UserGenJnlSetup: Record "User Gen. Journal Setup FND";
    begin
        //HEI.14 >>
        CreateUnitTestingValues('PRDR06', 'Item Reclassification Journal', DATABASE::Item, '0020001103', UnitTestingValueL);
        UnitTestingValueL."Value 2" := 'QUALITY';
        UnitTestingValueL."Value 3" := 'PRDR06001';
        UnitTestingValueL.MODIFY();

        UserGenJnlSetup.VALIDATE("Journal Type", UserGenJnlSetup."Journal Type"::Item);
        UserGenJnlSetup.VALIDATE("User ID", USERID);
        UserGenJnlSetup.VALIDATE("Gen. Journal Template Name", 'RECLASS');
        if UserGenJnlSetup.INSERT() then;

        IJB."Journal Template Name" := 'RECLASS';
        IJB.Name := UnitTestingValueL."Value 2";
        IJB.Description := UnitTestingValueL."Value 2";
        if IJB.INSERT() then;
        //HEI.14 <<
    end;

    procedure UpdateItemInvDTW2InitParameters(ItemNoP: Code[20]; LocationCodeP: Code[20]; ZoneCodeP: Code[20]; BinCodeP: Code[20]; InputQtyP: Integer; DocumentNoP: Code[20]; LotNoP: Code[10]);
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        RoutingLine: Record "Routing Line";
        WorkCenter: Record "Work Center";
        Bin: Record Bin;
        ProductionBOMLine: Record "Production BOM Line";
        ProductionBOMVersion: Record "Production BOM Version";
        //QualitySetup: Record "Quality Setup"; //BC Upgrade KAPOOV01 Commented Drink-IT Table-"Quality Setup"
        Item: Record Item;
        Location: Record Location;
        Zone: Record Zone;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ItemJournalLine: Record "Item Journal Line";
        TrackingSpecification: Record "Tracking Specification";
        ReservationEntry: Record "Reservation Entry";
        ItemNo: Code[20];
        LocationCode: Code[20];
        ZoneCode: Code[20];
        BinCode: Code[20];
        InputQty: Integer;
        EntryType: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        DocumentNo: Code[20];
        ItemUOM: Code[10];
        LotNo: Code[10];
        LastEntryNo: Integer;
        LastResvEntryNo: Integer;
        VersionCode: Code[20];
        ItemCCC: Record Item;
    begin
        ItemNo := ItemNoP;
        LocationCode := LocationCodeP;
        ZoneCode := ZoneCodeP;
        BinCode := BinCodeP;
        InputQty := InputQtyP;
        DocumentNo := DocumentNoP;
        LotNo := LotNoP;

        EntryType := EntryType::"Positive Adjmt.";

        ItemJournalLine.RESET();
        ItemJournalLine.SETRANGE("Journal Template Name", 'ITEM');
        ItemJournalLine.SETRANGE("Journal Batch Name", 'DEFAULT');
        if ItemJournalLine.FINDSET() then
            ItemJournalLine.DELETEALL();

        Item.GET(ItemNo);
        ItemJournalLine.INIT();
        ItemJournalLine.VALIDATE("Journal Template Name", 'ITEM');
        ItemJournalLine.VALIDATE("Journal Batch Name", 'DEFAULT');
        ItemJournalLine."Line No." := 10000;
        ItemJournalLine.INSERT(true);
        ItemJournalLine.VALIDATE("Posting Date", TODAY);
        ItemJournalLine.VALIDATE("Entry Type", EntryType);
        ItemJournalLine.VALIDATE("Document No.", DocumentNo);
        ItemJournalLine.VALIDATE("Item No.", ItemNo);
        ItemJournalLine.VALIDATE("Location Code", LocationCode);
        ItemJournalLine.VALIDATE("Zone Code FND", ZoneCode);
        ItemJournalLine.VALIDATE("Bin Code", BinCode);
        ItemJournalLine.VALIDATE(Quantity, InputQty);
        if ItemJournalLine."Shortcut Dimension 2 Code" = '' then
            ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", Item."Global Dimension 2 Code");

        if (ItemJournalLine."Shortcut Dimension 2 Code" = '') and (Item."Global Dimension 2 Code" = '') then begin
            ItemCCC.RESET();
            ItemCCC.SETRANGE("Item Category Code", Item."Item Category Code");
            ItemCCC.SETFILTER("Global Dimension 2 Code", '<>%1', '');
            //ItemCCC.SETRANGE("Gen. Prod. Posting Free Group", Item."Gen. Prod. Posting Free Group"); //BC Upgrade KAPOOV01 Commented code related to-DRINK-IT field-"Gen. Prod. Posting Free Group" of Table-Item
            ItemCCC.SETRANGE("Inventory Posting Group", Item."Inventory Posting Group");
            if ItemCCC.FINDFIRST() then
                ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", ItemCCC."Global Dimension 2 Code")
            //HEI.29>>
            else begin
                DimensionValue.RESET();
                DimensionValue.SETRANGE("Global Dimension No.", 2);
                if DimensionValue.FINDFIRST() then
                    ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", DimensionValue.Code);
            end;
            //HEI.29<<
        end;
        ItemJournalLine.MODIFY();

        TrackingSpecification.RESET();
        TrackingSpecification.LOCKTABLE();
        if TrackingSpecification.FINDLAST() then
            LastEntryNo := TrackingSpecification."Entry No.";

        if Item."Item Tracking Code" <> '' then begin
            TrackingSpecification.INIT();
            TrackingSpecification."Entry No." := LastEntryNo + 1;
            TrackingSpecification.INSERT();

            TrackingSpecification."Source ID" := ItemJournalLine."Journal Template Name";
            TrackingSpecification."Source Batch Name" := ItemJournalLine."Journal Batch Name";
            TrackingSpecification."Source Type" := DATABASE::"Item Journal Line";
            TrackingSpecification."Source Subtype" := 2;
            TrackingSpecification.VALIDATE("Item No.", ItemNo);
            TrackingSpecification.VALIDATE("Location Code", LocationCode);
            TrackingSpecification.VALIDATE("Quantity Handled (Base)", 0);
            TrackingSpecification.VALIDATE("Quantity Invoiced (Base)", 0);
            TrackingSpecification.VALIDATE("Lot No.", LotNo);
            TrackingSpecification.VALIDATE("Quantity (Base)", ItemJournalLine."Quantity (Base)");
            TrackingSpecification."Zone Code FND" := ZoneCode;
            TrackingSpecification."Bin Code" := BinCode;
            TrackingSpecification.Description := Item.Description;
            TrackingSpecification."Expiration Date" := CALCDATE('<+12M>', TODAY);
            TrackingSpecification.MODIFY();

            ReservationEntry.RESET();
            ReservationEntry.LOCKTABLE();
            if ReservationEntry.FINDLAST() then
                LastResvEntryNo := ReservationEntry."Entry No.";

            ReservationEntry.INIT();
            ReservationEntry.VALIDATE("Entry No.", LastResvEntryNo + 1);
            ReservationEntry.VALIDATE("Item No.", ItemNo);
            ReservationEntry.INSERT(true);//BC upgrade kamnay01
            ReservationEntry.VALIDATE("Location Code", LocationCode);
            ReservationEntry.VALIDATE("Quantity (Base)", ItemJournalLine."Quantity (Base)");
            ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
            ReservationEntry.VALIDATE("Creation Date", TODAY);
            ReservationEntry.VALIDATE("Created By", USERID);
            ReservationEntry.VALIDATE("Source Type", TrackingSpecification."Source Type");
            ReservationEntry.VALIDATE("Source Subtype", TrackingSpecification."Source Subtype");
            ReservationEntry.VALIDATE("Source ID", TrackingSpecification."Source ID");
            ReservationEntry.VALIDATE("Source Batch Name", TrackingSpecification."Source Batch Name");
            ReservationEntry."Source Ref. No." := 10000;
            ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
            ReservationEntry."Expiration Date" := CALCDATE('<+12M>', TODAY);
            ReservationEntry.VALIDATE("Lot No.", LotNo);
            //ReservationEntry.VALIDATE("Bin Code", BinCode); //BC Upgrade KAPOOV01 Commented code related to-DRINK-IT field-"Bin Code" of Table-"Reservation Entry"
            ReservationEntry.MODIFY();
        end;

        COMMIT();
        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine);


        MESSAGE('Completed');
    end;
}

