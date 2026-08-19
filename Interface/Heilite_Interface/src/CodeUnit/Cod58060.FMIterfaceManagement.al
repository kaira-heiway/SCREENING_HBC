codeunit 58060 "FM Interface Management"
{
    //BC Upgrade GUNREM01 old ID-50062
    // version FM,HEI.71

    // HEI.01 S&OP IBM LAZARE02 21.09.2018 # New codeunit for FuturMaster management
    // HEI.02 S&OP IBM POSTOI01 14.11.2018 # New codeunit for FuturMaster management
    // HEI.03 S&OP IBM POSTOI01 26.02.2019 # New filter to be applied on Customer Master Data Interface
    // HEI.04 S&OP IBM POSTOI01 08.03.2019
    //   # CreateBOMMaster interface modified
    //   # ValidateItemNo modified
    //   # ValidateComponentNo modified
    // HEI.05 S&OP IBM POSTOI01 09.03.2019
    //   # CreateProcFirmPlannedOrders - Production Firm Planned Schedule receipt interface modified
    // HEI.06 S&OP IBM POSTOI01 18.04.2019
    //   # SetPostingDateFilter function, modify code to solve the last/first day year issue, CreateSellInActualsMonth, CreateSellInActualsWeek (reference date setup)
    //   # delete leading 0 character in CreateSellInActualsWeek
    //   # set the default Reference Date as TODAY if the field is set to empty for CreateSellInActualsMonth and CreateSellInActualsWeek interfaces
    //   # comment old procedures. Will be deleted in the next release
    // HEI.07 FDD-PRDGAP061 - Planning nonBOM items v0.2,  IBM.NAIKH01 - 02.04.2019
    //   # Added code on Function "ProcessPurchaseRequisition"
    // HEI.08 S&OP IBM POSTOI01 06.05.2019
    //   # bug fix on GetItemAttributeValue, CalculateRunTime procedure update to solve the nonjob queue execution
    // HEI.09 S&OP IBM POSTOI01 12.05.2019
    //   # for inbound Production Order interface , all the planned productions should be deleted
    // HEI.10 S&OP IBM POSTOI01 17.05.2019
    //   # ProcessProductionOrders add code to find the Item No even it has no leading zeros
    // HEI.11 S&OP IBM POSTOI01 21.05.2019
    //   # add check on the Location Filter for Standard Cost interface
    // HEI.12 S&OP IBM POSTOI01 06.05.2019
    //   # move filters section
    // HEI.13 S&OP IBM POSTOI01 28.06.2019 Stock On Hand
    //   # calculate Quantity in HL using the Unit Volume HL from Item card
    // HEI.15 S&OP CHG2023181 IBM POSTOI01 17.07.2019
    //   # modify CreateComponentDataProducts and CreateSemiFinished
    // HEI.16 S&OP CHG2023804 IBM POSTOI01 22.07.2019
    //   # modify the GroupTransfLines for CreateStockTransfOrder interface quantity calculations
    // HEI.17 S&OP CHG2023806 IBM POSTOI01 23.07.2019
    //   # modify GroupStockOnHandWeek for CreateStockOnHand interface for calculate the quantities in Base UOm for raw and packiging materials
    // HEI.18 S&OP CHG2023808 IBM POSTOI01 23.07.2019
    //   # modify GroupPurchLine for CreateSupplyOpenPurchOrder for calculate the quantities in base UOM for Pack and Raw materials
    // HEI.21 CHG2042680 IBM TUDOSG01 04.02.2019
    //   # Code added
    // HEI.22 CHG2098891 IBM.LS      19.07.2021
    //   # Added Code
    // HEI.23 INC3623121/CHG2123481 IBM.AK 27.08.21
    //  # FuturMaster DP Products Master Data interface issue- descriptions not being shown
    // HEI.24 CHG2119356 HB2414 IBM GAVANM01 25.08.2021 #Update S&OP Core FuturMaster DP Customer Master interface
    //   # new code in function CreateMasterDataCustomers
    // HEI.25 CHG2119355 HB2415 IBM GAVANM01 25.08.2021 #Update S&OP Core DP Open Orders Interface Logic-Burundi
    //   # new code in function CreateDemandPlanOpenOrders
    // HEI.26 CHG2139842 IBM.AK 04.03.22 [New FM Outbound Interface-Stock Transfer Order Virtual Warehouse]
    // # Created new function - CreateStockTOVirtualLoc
    // # Created new function - GroupTransfLinesVirtualLoc
    // # Created new Function - ConvertQtyToHectLit
    // # Function Modified on old Interface- CreateStockTranspOrders(To Exclude Location from StockVirtual Location Setup and Include from STO Location setup)
    // HEI.27 CHG2147112 HB2791 IBM BHANDS01 04.03.2022 Update in logic for FuturMaster DP Sell In Actuals Week
    //   # Modified the logic in CreateSellInActualsWeek() for picking No. of weeks from Setup instead of hardcoded value
    // HEI.28 CHG2143695 IBM PATHAA02 04.04.22 - S&OP FIT | Bahamas Stock On Hand Interface Performance
    // # Replace the old code of Function-GroupStockOnHandWeek with new code(used Query Objects for performance and dotnet var for string handling)
    // # New Function: ConvertQtyToHL_FM
    // # Commented SLEEP in function ProcessManualOutboundEntries
    // HEI.29 CHG2153383 HB2883 IBM NANDIS01 12.05.2022 - FuturMaster update of Expected Receipt Date
    //   # Calculation will be depending on Expected receipt date in stead of Planned Receipt date - modified function - grouppurchline
    // HEI.30 CHG2155822 HB2886 IBM PATHAA02 05.07.22
    //   # Adding Global ID (Mendix ID-Item No.2) to the Component Product Master Interface/xml(Function:CreateComponentDataProduct).
    //   # Adding Global Description (Mendix ID-Desription 2) to the Component Product Master Interface/xml(Function:CreateComponentDataProduct).
    // HEI.31 CHG2158992 IBM PATHAA02 29.06.22 -FuturMaster SOH Design change
    //   # Design Change as per the new logic in the BRD
    //   # Logic on ILE is removed and built on Warehouse Entries
    // HEI.32 INC4158610 IBM BHANDS01 21.06.22 - Adding permissions for Interface Setup
    //   # Insert Delete
    // HEI.33 CHG2164158 IBM GHOSHS05 29.06.22 - commenting the logic of CalculateRunTime as it wll be handled through job queue
    //   # to avoid permission error
    // HEI.34 CHG2150741 IBM GOKULS01 25/07/2022 # BOM Version interface
    //   # New method created for processing the version bom data pushed with Dell Boomi
    // HEI.35 CHG2150741 IBM GOKULS01 26/07/2022 # BOM Version interface
    //   # New feilds are updated for schema changes
    // HEI.36 CHG2164876 HB2932 NORRIQ KOROLA04 27.07.22  - modified procedure ProcessProductionOrders
    // HEI.37 INC4264701/CHG2170800 IBM PATHAA02 24.08.22
    // # Mapping Mendix ID(Global ID) to External Document No. as Global No. was already part of field Mapping
    // # Global No.(keyofowner) will be mapped back to MATERIALS_2
    // HEI.39 CHG2161264 DEBUSD01 10.11.2022 Shipment KPI Interface
    //   # New function CreateShipmentsKpi
    // HEI.40 CHG2174570 COSTES04 06.12.2022 Interface Demand Planning for Returns
    //   # New functions
    // HEI.42 CHG2179087 COSTES04 13.12.2022 Demand planning Sell in Actuals Month/Week - VAN
    //   # Add return receipt quantity to Sell Act interfaces
    // HEI.43 CHG2161264 DEBUSD01 05.01.2023 Shipment KPI Interface Change
    //   # Remove leading zero in materialcode field (item no.)
    // HEI.45 CHG2161264 DEBUSD01 13.02.2023 Shipment KPI Interface Change
    //   # Fix Change in Document type from STO to ST.
    // HEI.46 CHG2195346 PATHAA02 20.04.2023 "S&OP FIT | BOM Interface Amendment"
    //   # Exclude BOM Components with Item Categories 07 and 08 from the BOM interface file being send to FM
    // HEI.47 CHG2203741 COSTES04 20.06.2023 Open Sales Order Interface for Supply
    //   # Add location code to Sales Order interface
    // HEI.48 CHG2211646 13.07.2023 #BOM Interface
    //   # Consumption Rate calculation new logic on the BOM Interface Output
    // HEI.49 CHG2201050 17.07.2023 Standard cost Interface Chg-ETH
    //  # Code added to change Cost for Ethiopia- Base UoM having PC's to be changed to HL
    // HEI.50 CHG2212642 PATHAA02 17.07.2023 Standard Cost Interface Amendment
    //  # Plant Code addition-Global
    // HEI.51 CHG2213616 COSTES04 24.07.2023 FuturMaster Weekly Alert-differences in monthly volumes.
    //  # Add previous periods in filters
    // HEI.52 CHG2203741 COSTES04 27.07.2023 Open Sales Order Interface for Supply
    //   # Add location code filter to Sales Order interface
    // HEI.53 CHG2207158 PATHAA02 29.08.2023 # Productio Plan Interface enhancement
    //   # Commented the old function-"ProcessProductionOrders"
    //   # Created new Functions "ProcessPlannedProductionOrders" & "Insert Error Log"
    // HEI.54 CHG2214545 COSTES04 05.09.2023 Add return filter fields
    //   # Add correct filter on Return Week filters
    // HEI.57 CHG2207158 PATHAA02 10.10.2023 # Productio Plan Interface enhancement
    //  # Automatic Deletion of Production plan lines before new Insertion & Change of caption for Error Log
    // HEI.58 CHG2207158 PATHAA02 12.10.2023 # Production Plan Interface enhancement
    //  # FAT Fix- Commit after Automatic Deletion of Production plan lines before new Insertion to avoid error
    // HEI.60 CHG2226024 PATHAA02 28.10.23  #Bug Fix-Stock Transport Orders Interface
    //   # New Virtual Location filter to avoid duplicate stock calculation for the data sent from Heilite to FM.
    // HEI.61 CHG2207158 PATHAA02 02.11.2023 # Production Plan Interface enhancement
    //  # Removed unused local variable-'FMPlannedProdOrdProcess' from the Function'InsertErrorLog'
    // HEI.62 CHG2227234 PATHAA02 14.11.2023 # Production BOM Interface Modification
    //  # Semifinished Items with Item Category 07 & 08 needs to be mapped as 'BEER_RESOURCE' on the workcentercode
    // HEI.64 CHG2232149 PATHAA02 18.12.23  #BOM Interface logic to be modified.
    //   # Semifinished components to have workcentercode mapped as BEER_Resource based on production BOM Header
    // HEI.65 CHG2226940 HB3632 IBM SRIVAS07 05.02.2024 # Development- Ice Cube to be removed from Item Category Code 01 (S&OP Fit Project)
    //  # Commented few filter in CreateSupplyPlanPurchOpenOrders()
    // HEI.66 CHG2238798 IBM COSTES04 13.02.2024 FM Interfaces Monthly/Weekly Code Optimization
    //  # Fetch Item Ledger Entry data with a query
    // HEI.67 CHG2226940 HB3632 IBM SRIVAS07 19.02.2024 # Development- Ice Cube to be removed from Item Category Code 01 (S&OP Fit Project)
    //  # Added few filter in CreateSupplyPlanPurchOpenOrders()
    // HEI.68 CHG2249105/INC5147448 IBM COSTES04 24.04.2024 FM Interfaces Monthly/Weekly Code wrong filter used
    //  # Add correct filter
    // HEI.69 CHG2269893/INC5365547 IBM PATHAA02 23.09.2024 S&OP FIT - BOM INTERFACE fix
    //  # Bug Fix-Router Header Code Information to be sent to FM instead of Production Version (Data needed for Production Plan Interface)
    // HEI.38 CHG2156586 HB2661 IBM NANDIS01 01.11.2022 FuturMaster update Open Purchase Orders for La Reunion
    //   # Consider Import POs and then consider Exp Physical Rcpt Date
    // HEI.41 CHG2156586 HB2661 IBM NANDIS01 08.12.2022 FuturMaster update Open Purchase Orders for La Reunion
    //   # Blocked the code against HEI.38
    // HEI.70 CHG2285048 HB4203 IBM PATHAA02 14.02.2025 # Dev-Standard cost FM interface to take the Unit cost value
    //   # Code added on Function-CreateStandardCost to include Unit Cost Value for Imported Goods(FGBX) and Std Cost value for non imported goods
    // HEI.71 CHG2285048 HB4203 IBM PATHAA02 04.07.2025 # Dev-Standard cost FM interface to take the Unit cost value
    //   # Code added on Function-'CreateStandardCost' to include Unit Cost Value from Item incase SKU Unit Cost is zero for Imported Goods(FGBX).


    //BC Upgrade GUNREM01  >>
    //# Commented DIT Fields 
    //# Replaced DotNet Variables and changed the code 
    //BC Upgrade GUNREM01  <<

    //BC Upgrade ATHUKS01  >>
    //1.Replace InventorySetup."Volume Unit of Measure Code" with DIT Field "Unit Volume UOM" from FoundationSetup101FDW table which is part of Aptean extension
    //2.Replce with locPurchLine."Unit Volume HL" to  locPurchLine."Unit Volume"
    //BC Upgrade ATHUKS01  <<
    Permissions = TableData "Data Exch." = rimd,
                  TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin
    end;

    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        FuturMasterInterfaceSetup: Record "FuturMaster Interf. Setup INT";
        GeneralInterfaceSetupRead: Boolean;
        FuturMasterInterfaceSetupRead: Boolean;
        TempSalesActualMth: Record "Ledger Entry Matching Buffer" temporary;
        PeriodType: Option Month,Week;
        Index: Integer;
        Direction: Option Up,Down;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        FuturMasterInterfaceSetup2: Record "FuturMaster Interf Setup_2 INT";
        GeneralInterfaceSetupRead2: Boolean;
        FuturMasterInterfaceSetupRead2: Boolean;
        TempGroupSalesLine: Record "Ledger Entry Matching Buffer" temporary;
        Text001: Label 'Scheduled';
        Text002: Label 'Manual';
        TempGroupPurchLine: Record "Ledger Entry Matching Buffer" temporary;
        TempGroupProdOrder: Record "Ledger Entry Matching Buffer" temporary;
        Item: Record Item;
        TempGroupTransfLines: Record "Ledger Entry Matching Buffer" temporary;
        Text003: Label 'An error occured during the processing. See the Error Interface entries!';
        Text004: Label 'The file was successfully uploaded!';
        Text005: Label 'Log data...';
        HeinekenGlobal: Codeunit "Heineken Global";
        QStockonHandWE: Query "StockonHand WE";
        FuturMasterInterfaceSetup3: Record "FuturMaster Interf. Stp 3 INT";
        FuturMasterInterfaceSetupRead3: Boolean;
        TotalQuantity: Decimal;
        DITFoundationSetup: record FoundationSetup101FDW; //BC UPGRADE PATHAA02

    procedure ProcessProductMasterRequest(InterfaceEntryHeader: Record "Interface Entry Header INT") ReturnValue: Text;
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryComponentOut: Record "Interface Entry Component INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        Item: Record Item;
        ItemCrossRefError: Label 'Item No. %1 has no item cross reference with type bar code!';
        EntryNo: Integer;
    begin
        //>>HEI.01
        //Items NAV -> FuturMaster
        //>>HEI.06 comment old procedure
        /*
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Product Master Req. Interface");
        
        IF NOT InterfaceSetup.Enabled THEN
          EXIT;
        GeneralInterfaceSetup.TESTFIELD("Brand Dim. Code");
        FuturMasterInterfaceSetup.TESTFIELD("Product Master Category Filter");
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup,OutboundInterface);
        
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader,FALSE);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Product Master Resp. Interface";
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(TRUE);
        
        InterfaceEntryLine.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN
          REPEAT
            IF InterfaceEntryLine."No." <> '*' THEN BEGIN
              Item.RESET;
              Item.GET(InterfaceEntryLine."No.");
              Item.TESTFIELD(Blocked,FALSE);
        
              CLEAR(InterfaceEntryLineOut);
              InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
              InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
              InterfaceEntryLineOut."No." := Item."No.";
              InterfaceEntryLineOut."Global No." := Item."No. 2";
              InterfaceEntryLineOut.Description := Item.Description;
              InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
              InterfaceEntryLineOut."Unit of Measure Code" := FuturMasterInterfaceSetup."Product Master Def UOM";
              GetProductMasterValues(InterfaceEntryLineOut);
              InterfaceEntryLineOut.INSERT;
            END ELSE BEGIN
              Item.RESET;
              Item.SETFILTER("Item Category Code",FuturMasterInterfaceSetup."Product Master Category Filter");
              Item.SETRANGE(Blocked,FALSE);
              IF Item.FINDSET THEN
                REPEAT
                  CLEAR(InterfaceEntryLineOut);
                  EntryNo := EntryNo + 1;
                  InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                  InterfaceEntryLineOut."Entry No." := EntryNo;
                  InterfaceEntryLineOut."No." := Item."No.";
                  InterfaceEntryLineOut."Global No." := Item."No. 2";
                  InterfaceEntryLineOut.Description := Item.Description;
                  InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                  InterfaceEntryLineOut."Unit of Measure Code" := FuturMasterInterfaceSetup."Product Master Def UOM";
                  GetProductMasterValues(InterfaceEntryLineOut);
                  InterfaceEntryLineOut.INSERT;
                UNTIL Item.NEXT = 0;
            END;
          UNTIL InterfaceEntryLine.NEXT = 0;
        
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
        
        ReturnValue := FORMAT(InterfaceEntryHeaderOut."Entry No.");
        */
        //<<HEI.06

    end;

    local procedure GetProductMasterValues(InterfaceEntryLineOut: Record "Interface Entry Line INT");
    var
        InterfaceEntryComponentOut: Record "Interface Entry Component INT";
        Item: Record Item;
        ItemCategory: Record "Item Category";
    begin
        //HEI.01
        CLEAR(InterfaceEntryComponentOut);
        InterfaceEntryComponentOut."Header Entry No." := InterfaceEntryLineOut."Header Entry No.";
        InterfaceEntryComponentOut."Line Entry No." := InterfaceEntryLineOut."Entry No.";
        InterfaceEntryComponentOut."Table ID" := DATABASE::Item;
        if Item.GET(InterfaceEntryLineOut."No.") then
            if ItemCategory.GET(Item."Item Category Code") then begin
                InterfaceEntryComponentOut.Code := ItemCategory.TABLENAME;
                InterfaceEntryComponentOut."Value Code" := ItemCategory.Code;
                InterfaceEntryComponentOut.Description := ItemCategory.Description;
            end;
        InterfaceEntryComponentOut.INSERT;


        InterfaceEntryComponentOut.INIT;
        GetItemAttributeValue(DATABASE::Item, InterfaceEntryLineOut."No.", GeneralInterfaceSetup."CMG Attribute ID",
                              InterfaceEntryComponentOut.Code, InterfaceEntryComponentOut."Value Code", InterfaceEntryComponentOut.Description);
        if InterfaceEntryComponentOut.Code <> '' then
            InterfaceEntryComponentOut.INSERT;

        InterfaceEntryComponentOut.INIT;
        GetItemAttributeValue(DATABASE::Item, InterfaceEntryLineOut."No.", GeneralInterfaceSetup."Product Type Attr. ID",
                              InterfaceEntryComponentOut.Code, InterfaceEntryComponentOut."Value Code", InterfaceEntryComponentOut.Description);
        if InterfaceEntryComponentOut.Code <> '' then
            InterfaceEntryComponentOut.INSERT;

        InterfaceEntryComponentOut.INIT;
        GetItemAttributeValue(DATABASE::Item, InterfaceEntryLineOut."No.", GeneralInterfaceSetup."Brand Attribute ID",
                              InterfaceEntryComponentOut.Code, InterfaceEntryComponentOut."Value Code", InterfaceEntryComponentOut.Description);
        if InterfaceEntryComponentOut.Code <> '' then
            InterfaceEntryComponentOut.INSERT;

        InterfaceEntryComponentOut.INIT;
        GetItemAttributeValue(DATABASE::Item, InterfaceEntryLineOut."No.", GeneralInterfaceSetup."Line Extension Attr. ID",
                              InterfaceEntryComponentOut.Code, InterfaceEntryComponentOut."Value Code", InterfaceEntryComponentOut.Description);
        if InterfaceEntryComponentOut.Code <> '' then
            InterfaceEntryComponentOut.INSERT;

        InterfaceEntryComponentOut.INIT;
        GetItemAttributeValue(DATABASE::Item, InterfaceEntryLineOut."No.", GeneralInterfaceSetup."Primary Pack Type Attr. ID",
                              InterfaceEntryComponentOut.Code, InterfaceEntryComponentOut."Value Code", InterfaceEntryComponentOut.Description);
        if InterfaceEntryComponentOut.Code <> '' then
            InterfaceEntryComponentOut.INSERT;

        InterfaceEntryComponentOut.INIT;
        GetItemAttributeValue(DATABASE::Item, InterfaceEntryLineOut."No.", GeneralInterfaceSetup."SPT Outer Layer Attr. ID",
                              InterfaceEntryComponentOut.Code, InterfaceEntryComponentOut."Value Code", InterfaceEntryComponentOut.Description);
        if InterfaceEntryComponentOut.Code <> '' then
            InterfaceEntryComponentOut.INSERT;

        InterfaceEntryComponentOut.INIT;
        GetItemAttributeValue(DATABASE::Item, InterfaceEntryLineOut."No.", GeneralInterfaceSetup."SPT Unit Per Outer Attr. ID",
                              InterfaceEntryComponentOut.Code, InterfaceEntryComponentOut."Value Code", InterfaceEntryComponentOut.Description);
        if InterfaceEntryComponentOut.Code <> '' then
            InterfaceEntryComponentOut.INSERT;

        InterfaceEntryComponentOut.INIT;
        GetItemAttributeValue(DATABASE::Item, InterfaceEntryLineOut."No.", GeneralInterfaceSetup."SPT In Betw. Layer Attr. ID",
                              InterfaceEntryComponentOut.Code, InterfaceEntryComponentOut."Value Code", InterfaceEntryComponentOut.Description);
        if InterfaceEntryComponentOut.Code <> '' then
            InterfaceEntryComponentOut.INSERT;

        InterfaceEntryComponentOut.INIT;
        GetItemAttributeValue(DATABASE::Item, InterfaceEntryLineOut."No.", GeneralInterfaceSetup."SPT Units In Betw. Attr. ID",
                              InterfaceEntryComponentOut.Code, InterfaceEntryComponentOut."Value Code", InterfaceEntryComponentOut.Description);
        if InterfaceEntryComponentOut.Code <> '' then
            InterfaceEntryComponentOut.INSERT;

        InterfaceEntryComponentOut.INIT;
        GetItemAttributeValue(DATABASE::Item, InterfaceEntryLineOut."No.", GeneralInterfaceSetup."Returnable Indicat. Attr. ID",
                              InterfaceEntryComponentOut.Code, InterfaceEntryComponentOut."Value Code", InterfaceEntryComponentOut.Description);
        if InterfaceEntryComponentOut.Code <> '' then
            InterfaceEntryComponentOut.INSERT;

        InterfaceEntryComponentOut.INIT;
        GetItemAttributeValue(DATABASE::Item, InterfaceEntryLineOut."No.", GeneralInterfaceSetup."Primary Pack Size Attr. ID",
                              InterfaceEntryComponentOut.Code, InterfaceEntryComponentOut."Value Code", InterfaceEntryComponentOut.Description);
        if InterfaceEntryComponentOut.Code <> '' then
            InterfaceEntryComponentOut.INSERT;
    end;

    local procedure GetItemAttributeValue(TableID: Integer; No: Code[20]; AttributeID: Integer; var AttributeName: Code[20]; var AttributeValueName: Code[20]; var AttributeValueDescription: Text): Text;
    var
        ItemAttributeValue: Record "Item Attribute Value";
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
    begin
        //HEI.01
        AttributeName := '';
        AttributeValueName := '';
        AttributeValueDescription := '';
        ItemAttributeValueMapping.SETRANGE("Table ID", TableID);
        ItemAttributeValueMapping.SETRANGE("No.", No);
        ItemAttributeValueMapping.SETRANGE("Item Attribute ID", AttributeID);
        if ItemAttributeValueMapping.FINDFIRST then
            if ItemAttributeValue.GET(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID") then begin
                ItemAttributeValue.CALCFIELDS("Attribute Name");
                AttributeName := COPYSTR(ItemAttributeValue."Attribute Name", 1, 20);
                AttributeValueName := COPYSTR(ItemAttributeValue.Value, 1, 20);
                //HEI.08 comment line AttributeValueDescription := ItemAttributeValue.Description;
                //HEI.23>>
                //HEI.08>>
                AttributeValueDescription := COPYSTR(ItemAttributeValue."Description FND", 1, 50);
                //HEI.08<<
                //HEI.23<<
            end;
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        //HEI.01
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.GET;
        GeneralInterfaceSetupRead := true;
    end;

    local procedure GetFuturMasterInterfaceSetup();
    begin
        //HEI.01
        if not FuturMasterInterfaceSetupRead then
            if FuturMasterInterfaceSetup.GET then;
        FuturMasterInterfaceSetupRead := true;
    end;

    local procedure GetFuturMasterInterfaceSetup3();
    begin
        //HEI.42
        if not FuturMasterInterfaceSetupRead3 then
            if FuturMasterInterfaceSetup3.GET then;
        FuturMasterInterfaceSetupRead3 := true;
    end;

    procedure ProcessCustomerMasterRequest(InterfaceEntryHeader: Record "Interface Entry Header INT") ReturnValue: Text;
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryComponentOut: Record "Interface Entry Component INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        Item: Record Item;
        ItemCrossRefError: Label 'Item No. %1 has no item cross reference with type bar code!';
        EntryNo: Integer;
        Customer: Record Customer;
    begin
        //HEI.02
        //Customer NAV -> FuturMaster
        //>>HEI.06 comment old procedure
        /*
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Cust. Master Req. Interface");
        
        IF NOT InterfaceSetup.Enabled THEN
          EXIT;
        GeneralInterfaceSetup.TESTFIELD("Brand Dim. Code");
        FuturMasterInterfaceSetup.TESTFIELD("Cust. Master Acc Group Filter");
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup,OutboundInterface);
        
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader,FALSE);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Cust. Master Resp. Interface";
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(TRUE);
        
        InterfaceEntryLine.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN
          REPEAT
            IF InterfaceEntryLine."No." <> '*' THEN BEGIN
              Customer.RESET;
              Customer.SETCURRENTKEY("Account Group");
              Customer.SETRANGE("No.", InterfaceEntryLine."No.");
              Customer.SETFILTER("Account Group",FuturMasterInterfaceSetup."Cust. Master Acc Group Filter");
              IF Customer.FINDFIRST THEN BEGIN
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                InterfaceEntryLineOut."No." := Customer."No.";
                InterfaceEntryLineOut."E-Mail 2" := COPYSTR(Customer.Name + ' ' + Customer."Name 2",1, 100);
                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryLineOut."Ship-to Address" := Customer.City;
                InterfaceEntryLineOut."Ship-to Name" := Customer.City;
                GetCustomerMasterValues(InterfaceEntryLineOut);
                InterfaceEntryLineOut.INSERT;
              END;
            END ELSE BEGIN
              Customer.RESET;
              Customer.SETCURRENTKEY("Account Group");
              Customer.SETFILTER("Account Group",FuturMasterInterfaceSetup."Cust. Master Acc Group Filter");
              IF Customer.FINDSET THEN
                REPEAT
                  CLEAR(InterfaceEntryLineOut);
                  EntryNo := EntryNo + 1;
                  InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                  InterfaceEntryLineOut."Entry No." := EntryNo;
                  InterfaceEntryLineOut."No." := Customer."No.";
                  InterfaceEntryLineOut."E-Mail 2" := COPYSTR(Customer.Name + ' ' + Customer."Name 2",1, 100);
                  InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                  InterfaceEntryLineOut."Ship-to Address" := Customer.City;
                  InterfaceEntryLineOut."Ship-to Name" := Customer.City;
                  GetCustomerMasterValues(InterfaceEntryLineOut);
                  InterfaceEntryLineOut.INSERT;
                UNTIL Customer.NEXT = 0;
            END;
          UNTIL InterfaceEntryLine.NEXT = 0;
        
        IF EntryNo = 0 THEN BEGIN
          CLEAR(InterfaceEntryLineOut);
          EntryNo := EntryNo + 1;
          InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
          InterfaceEntryLineOut."Entry No." := EntryNo;
          InterfaceEntryLineOut."No." := '';
          InterfaceEntryLineOut."E-Mail 2" := '';
          InterfaceEntryLineOut."Legal Entity" := '';
          InterfaceEntryLineOut."Ship-to Address" := '';
          InterfaceEntryLineOut."Ship-to Name" := '';
          InterfaceEntryLineOut.INSERT;
          END;
        
        
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
        
        ReturnValue := FORMAT(InterfaceEntryHeaderOut."Entry No.");
        HEI.06<<*/

    end;

    local procedure GetCustomerMasterValues(InterfaceEntryLineOut: Record "Interface Entry Line INT");
    var
        InterfaceEntryComponentOut: Record "Interface Entry Component INT";
        Item: Record Item;
        ItemCategory: Record "Item Category";
        CustomerAttributes: Record "Customer Attributes FND";
        BusinessSegment: Record "Business Segment FND";
        CustomerSubType: Record "Customer Sub-Type FND";
        ItemAttribute: Record "Item Attribute";
        CustomerLoc: Record Customer;
        CustomerName: Record Customer;
        CountryReg: Record "Country/Region";
        BusinessSubSegment: Record "Business Org Segment FND";
    begin
        //HEI.02
        //test fields
        GeneralInterfaceSetup.TESTFIELD("Returnable Indicat. Attr. ID");
        GeneralInterfaceSetup.TESTFIELD("Product Type Attr. ID");
        GeneralInterfaceSetup.TESTFIELD("Brand Attribute ID");
        GeneralInterfaceSetup.TESTFIELD("Line Extension Attr. ID");
        GeneralInterfaceSetup.TESTFIELD("Primary Pack Type Attr. ID");
        GeneralInterfaceSetup.TESTFIELD("SPT Outer Layer Attr. ID");
        GeneralInterfaceSetup.TESTFIELD("SPT In Betw. Layer Attr. ID");
        GeneralInterfaceSetup.TESTFIELD("Returnable Indicat. Attr. ID");


        //bus seg code - > Item Category
        CustomerAttributes.RESET;
        CustomerAttributes.SETRANGE("Customer No.", InterfaceEntryLineOut."No.");
        if CustomerAttributes.FINDFIRST then begin
            InterfaceEntryComponentOut.INIT;
            CLEAR(InterfaceEntryComponentOut);
            InterfaceEntryComponentOut."Header Entry No." := InterfaceEntryLineOut."Header Entry No.";
            InterfaceEntryComponentOut."Line Entry No." := InterfaceEntryLineOut."Entry No.";
            InterfaceEntryComponentOut."Table ID" := DATABASE::Item;
            if CustomerLoc.GET(InterfaceEntryLineOut."No.") then
                if CustomerAttributes."Business Segment" <> '' then begin
                    InterfaceEntryComponentOut.Code := ItemCategory.TABLENAME;
                    InterfaceEntryComponentOut."Value Code" := CustomerAttributes."Business Segment";
                    if BusinessSegment.GET(CustomerAttributes."Business Segment") then
                        InterfaceEntryComponentOut.Description := BusinessSegment.Name;
                end;
            InterfaceEntryComponentOut.INSERT;
        end;


        //bus sub seg code -> Product Type
        CustomerAttributes.RESET;
        CustomerAttributes.SETRANGE("Customer No.", InterfaceEntryLineOut."No.");
        if CustomerAttributes.FINDFIRST then begin
            InterfaceEntryComponentOut.INIT;
            CLEAR(InterfaceEntryComponentOut);
            InterfaceEntryComponentOut."Header Entry No." := InterfaceEntryLineOut."Header Entry No.";
            InterfaceEntryComponentOut."Line Entry No." := InterfaceEntryLineOut."Entry No.";
            InterfaceEntryComponentOut."Table ID" := DATABASE::Item;
            if CustomerLoc.GET(InterfaceEntryLineOut."No.") then
                if CustomerAttributes."Business OrganizationalSegment" <> '' then begin
                    if ItemAttribute.GET(GeneralInterfaceSetup."Product Type Attr. ID") then begin
                        InterfaceEntryComponentOut.Code := ItemAttribute.Name;
                        InterfaceEntryComponentOut."Value Code" := CustomerAttributes."Business OrganizationalSegment";
                        if BusinessSubSegment.GET(CustomerAttributes."Business OrganizationalSegment") then
                            InterfaceEntryComponentOut.Description := BusinessSubSegment.Name;
                    end;
                end;
            if InterfaceEntryComponentOut.Code <> '' then
                InterfaceEntryComponentOut.INSERT;

        end;

        //customer channel code - BRAND
        CustomerAttributes.RESET;
        CustomerAttributes.SETRANGE("Customer No.", InterfaceEntryLineOut."No.");
        if CustomerAttributes.FINDFIRST then begin
            InterfaceEntryComponentOut.INIT;
            CLEAR(InterfaceEntryComponentOut);
            InterfaceEntryComponentOut."Header Entry No." := InterfaceEntryLineOut."Header Entry No.";
            InterfaceEntryComponentOut."Line Entry No." := InterfaceEntryLineOut."Entry No.";
            InterfaceEntryComponentOut."Table ID" := DATABASE::Item;
            if CustomerLoc.GET(InterfaceEntryLineOut."No.") then
                if CustomerAttributes."Customer Sub-Type" <> '' then begin
                    if ItemAttribute.GET(GeneralInterfaceSetup."Brand Attribute ID") then begin
                        InterfaceEntryComponentOut.Code := ItemAttribute.Name;
                        InterfaceEntryComponentOut."Value Code" := CustomerAttributes."Customer Sub-Type";
                        if CustomerSubType.GET(CustomerAttributes."Customer Sub-Type") then
                            InterfaceEntryComponentOut.Description := CustomerSubType.Name;
                    end;
                end;
            if InterfaceEntryComponentOut.Code <> '' then
                InterfaceEntryComponentOut.INSERT;

        end;

        //sold to code - Line Extension
        CustomerLoc.RESET;
        CustomerLoc.SETRANGE("No.", InterfaceEntryLineOut."No.");
        if CustomerLoc.FINDFIRST then begin
            InterfaceEntryComponentOut.INIT;
            CLEAR(InterfaceEntryComponentOut);
            InterfaceEntryComponentOut."Header Entry No." := InterfaceEntryLineOut."Header Entry No.";
            InterfaceEntryComponentOut."Line Entry No." := InterfaceEntryLineOut."Entry No.";
            InterfaceEntryComponentOut."Table ID" := DATABASE::Item;
            if CustomerLoc.GET(InterfaceEntryLineOut."No.") then begin
                if ItemAttribute.GET(GeneralInterfaceSetup."Line Extension Attr. ID") then begin
                    InterfaceEntryComponentOut.Code := ItemAttribute.Name;
                    InterfaceEntryComponentOut."Value Code" := DELCHR(CustomerLoc."Bill-to Customer No.", '<', '0');
                    if CustomerName.GET(CustomerLoc."Bill-to Customer No.") then
                        InterfaceEntryComponentOut.Description := CustomerName.Name;
                    if InterfaceEntryComponentOut.Code <> '' then
                        InterfaceEntryComponentOut.INSERT;
                end;
            end;
        end;

        //country/region - Primary Pack Type Attr. ID
        CustomerLoc.RESET;
        CustomerLoc.SETRANGE("No.", InterfaceEntryLineOut."No.");
        if CustomerLoc.FINDFIRST then begin
            InterfaceEntryComponentOut.INIT;
            CLEAR(InterfaceEntryComponentOut);
            InterfaceEntryComponentOut."Header Entry No." := InterfaceEntryLineOut."Header Entry No.";
            InterfaceEntryComponentOut."Line Entry No." := InterfaceEntryLineOut."Entry No.";
            InterfaceEntryComponentOut."Table ID" := DATABASE::Item;
            if ItemAttribute.GET(GeneralInterfaceSetup."Primary Pack Type Attr. ID") then begin
                InterfaceEntryComponentOut.Code := ItemAttribute.Name;
                InterfaceEntryComponentOut."Value Code" := COPYSTR(CustomerLoc."Country/Region Code", 1, 20);
                if CountryReg.GET(CustomerLoc."Country/Region Code") then
                    InterfaceEntryComponentOut.Description := CountryReg.Name;
                if InterfaceEntryComponentOut.Code <> '' then
                    InterfaceEntryComponentOut.INSERT;
            end;
        end;

        //region - "SPT Outer Layer Attr. ID"
        CustomerLoc.RESET;
        CustomerLoc.SETRANGE("No.", InterfaceEntryLineOut."No.");
        if CustomerLoc.FINDFIRST then begin
            InterfaceEntryComponentOut.INIT;
            CLEAR(InterfaceEntryComponentOut);
            InterfaceEntryComponentOut."Header Entry No." := InterfaceEntryLineOut."Header Entry No.";
            InterfaceEntryComponentOut."Line Entry No." := InterfaceEntryLineOut."Entry No.";
            InterfaceEntryComponentOut."Table ID" := DATABASE::Item;
            if ItemAttribute.GET(GeneralInterfaceSetup."SPT Outer Layer Attr. ID") then begin
                InterfaceEntryComponentOut.Code := ItemAttribute.Name;
                InterfaceEntryComponentOut."Value Code" := COPYSTR(CustomerLoc."Country/Region Code", 1, 20);
                if CountryReg.GET(CustomerLoc."Country/Region Code") then
                    InterfaceEntryComponentOut.Description := CountryReg.Name;
                if InterfaceEntryComponentOut.Code <> '' then
                    InterfaceEntryComponentOut.INSERT;
            end;
        end;

        //blocked - "Returnable Indicat. Attr. ID"
        CustomerAttributes.RESET;
        CustomerAttributes.SETRANGE("Customer No.", InterfaceEntryLineOut."No.");
        if CustomerAttributes.FINDFIRST then begin
            //CustomerLoc.RESET;
            //CustomerLoc.SETRANGE("No.", InterfaceEntryLineOut."No.");
            //IF CustomerLoc.FINDFIRST THEN BEGIN
            InterfaceEntryComponentOut.INIT;
            CLEAR(InterfaceEntryComponentOut);
            InterfaceEntryComponentOut."Header Entry No." := InterfaceEntryLineOut."Header Entry No.";
            InterfaceEntryComponentOut."Line Entry No." := InterfaceEntryLineOut."Entry No.";
            InterfaceEntryComponentOut."Table ID" := DATABASE::Item;
            if ItemAttribute.GET(GeneralInterfaceSetup."Returnable Indicat. Attr. ID") then begin
                InterfaceEntryComponentOut.Code := ItemAttribute.Name;
                if CustomerAttributes."Flag for Deletion" then begin
                    InterfaceEntryComponentOut."Value Code" := 'Inactive';
                    InterfaceEntryComponentOut.Description := 'Inactive';
                end else begin
                    InterfaceEntryComponentOut."Value Code" := 'Active';
                    InterfaceEntryComponentOut.Description := 'Active';

                end;
                if InterfaceEntryComponentOut.Code <> '' then
                    InterfaceEntryComponentOut.INSERT;
            end;
        end;
    end;

    procedure ProcessSalesActualMthRequest(InterfaceEntryHeader: Record "Interface Entry Header INT") ReturnValue: Text;
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryComponentOut: Record "Interface Entry Component INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        Item: Record Item;
        ItemCrossRefError: Label 'Item No. %1 has no item cross reference with type bar code!';
        EntryNo: Integer;
        Customer: Record Customer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        YearMonth: Text[6];
    begin
        //HEI.02
        //Sales Actual Month NAV -> FuturMaster
        //>>HEI.06 comment old procedure
        /*
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Sell Act Mth Req. Interface");
        
        IF NOT InterfaceSetup.Enabled THEN
          EXIT;
        
        FuturMasterInterfaceSetup.TESTFIELD("Cust. Master Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH Doc Types Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH Ref Date");
        
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup,OutboundInterface);
        
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader,FALSE);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Sell Act Mth Resp. Interface";
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(TRUE);
        
        InterfaceEntryLine.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN
          REPEAT
            IF InterfaceEntryLine."No." <> '*' THEN BEGIN
              ItemLedgerEntry.RESET;
              ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
              ItemLedgerEntry.SETRANGE("Item No.", InterfaceEntryLine."No.");
              ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
              ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
              IF FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Location Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act MTH Location Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter");
              IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                GroupSalesActualMonth(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust. Master Acc Group Filter", TODAY, 1);
                TempSalesActualMth.RESET;
                IF TempSalesActualMth.FINDSET THEN
                  REPEAT
                    IF TempSalesActualMth."Remaining Amount" <> 0 THEN BEGIN
                      CLEAR(InterfaceEntryLineOut);
                      InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                      EntryNo +=1;
                      InterfaceEntryLineOut."Entry No." := EntryNo;
                      InterfaceEntryLineOut."No." := TempSalesActualMth."Account No.";
                      InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                      InterfaceEntryLineOut."Sell-to Customer No." := TempSalesActualMth."Bal. Account No.";
                      InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                      InterfaceEntryLineOut.Quantity := -TempSalesActualMth."Remaining Amount";
                      InterfaceEntryLineOut.INSERT;
                      END;
                  UNTIL TempSalesActualMth.NEXT = 0;
        
              END;
            END ELSE BEGIN
              ItemLedgerEntry.RESET;
              ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
              ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
              ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
              IF FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Location Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act MTH Location Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter");
              IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                GroupSalesActualMonth(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust. Master Acc Group Filter", TODAY, 1);
                TempSalesActualMth.RESET;
                IF TempSalesActualMth.FINDSET THEN
                  REPEAT
                    IF TempSalesActualMth."Remaining Amount" <> 0 THEN BEGIN
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    EntryNo +=1;
                    InterfaceEntryLineOut."Entry No." := EntryNo;
                    InterfaceEntryLineOut."No." := TempSalesActualMth."Account No.";
                    InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                    InterfaceEntryLineOut."Sell-to Customer No." := TempSalesActualMth."Bal. Account No.";
                    InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                    InterfaceEntryLineOut.Quantity := - TempSalesActualMth."Remaining Amount";
                    InterfaceEntryLineOut.INSERT;
                    END;
                  UNTIL TempSalesActualMth.NEXT = 0;
        
              END;
        
            END;
          UNTIL InterfaceEntryLine.NEXT = 0;
        
        IF EntryNo = 0 THEN BEGIN
          CLEAR(InterfaceEntryLineOut);
          EntryNo := EntryNo + 1;
          InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
          InterfaceEntryLineOut."Entry No." := EntryNo;
          InterfaceEntryLineOut."No." := '';
          InterfaceEntryLineOut."E-Mail 2" := '';
          InterfaceEntryLineOut."Legal Entity" := '';
          InterfaceEntryLineOut."Ship-to Address" := '';
          InterfaceEntryLineOut."Ship-to Name" := '';
          InterfaceEntryLineOut.INSERT;
          END;
        
        
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
        
        ReturnValue := FORMAT(InterfaceEntryHeaderOut."Entry No.");
        HEI.06<<*/

    end;

    local procedure GroupSalesActualMonth(var locILE: Record "Item Ledger Entry"; var locSalesActualMth: Record "Ledger Entry Matching Buffer" temporary; CustMasterAccGroup: Code[20]; RefDate: Date; NoOfPeriod: Integer);
    var
        EntryNo: Integer;
        Customer: Record Customer;
        YearMonth: Text[6];
        Item: Record Item;
        i: Integer;
        FMItemLedgerEntryQuantity: Query "FM Item Ledger Entry Quantity";
    begin
        //HEI.03
        //NoOfPeriods reffers to number of last month (excluding the current month)
        locSalesActualMth.DELETEALL;
        CLEAR(EntryNo);
        //HEI.66>>
        //OLD>>
        /*Customer.SETCURRENTKEY("Account Group");
        Customer.SETFILTER("Account Group", CustMasterAccGroup);
        FOR i := 0 TO NoOfPeriod DO BEGIN
          //current month
          CLEAR(YearMonth);
          YearMonth := SetPostingDateFilter(locILE, PeriodType::Month, i, Direction::Down, RefDate);
        
          IF locILE.FINDSET THEN
            REPEAT
              locSalesActualMth.SETRANGE("Account No.", locILE."Item No.");
              locSalesActualMth.SETRANGE("Bal. Account No.", locILE."Source No.");
              locSalesActualMth.SETRANGE("Document No.", YearMonth);
              IF locSalesActualMth.FINDFIRST THEN BEGIN
        
                {old
                IF Item.GET(locILE."Item No.") THEN
                  locSalesActualMth."Remaining Amount" += locILE.Quantity * Item."Unit Volume HL";
                  }
        
                  IF Item.GET(locILE."Item No.") THEN
                    locSalesActualMth."Remaining Amount" += ConvertQtyToHL(locILE."Item No.", locILE.Quantity, '', locILE."Unit of Measure Code", locILE."Quantity in HL");
        
        
                locSalesActualMth.MODIFY;
              END ELSE BEGIN
                Customer.SETRANGE("No.", locILE."Source No.");
                IF Customer.FINDFIRST THEN BEGIN
                  locSalesActualMth.INIT;
                  EntryNo += 1;
                  locSalesActualMth."Entry No." := EntryNo;
                  locSalesActualMth."Account Type" := locSalesActualMth."Account Type"::Customer;
                  locSalesActualMth."Account No." := locILE."Item No.";
                  locSalesActualMth."Bal. Account No." := locILE."Source No.";
                  {old
                  IF Item.GET(locILE."Item No.") THEN
                    locSalesActualMth."Remaining Amount" := locILE.Quantity * Item."Unit Volume HL";
                  }
        
                  IF Item.GET(locILE."Item No.") THEN
                    locSalesActualMth."Remaining Amount" := ConvertQtyToHL(locILE."Item No.", locILE.Quantity, '', locILE."Unit of Measure Code", locILE."Quantity in HL");
        
                  locSalesActualMth."Document No." := YearMonth;
                  locSalesActualMth.INSERT;
                END;
              END;
            UNTIL locILE.NEXT = 0;
        END;*/
        //OLD<<
        FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Entry_Type, locILE.GETFILTER("Entry Type"));
        FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Source_Type, locILE.GETFILTER("Source Type"));
        FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Document_Type, locILE.GETFILTER("Document Type"));

        //HEI.68>>
        //FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Item_Category_Code,locILE.GETFILTER("Location Code"));
        FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Location_Code, locILE.GETFILTER("Location Code"));
        FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Item_Category_Code, locILE.GETFILTER("Item Category Code"));
        //HEI.68<<
        FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Account_Group, CustMasterAccGroup);
        for i := 0 to NoOfPeriod do begin
            //current month
            CLEAR(YearMonth);
            YearMonth := SetPostingDateFilter(locILE, PeriodType::Month, i, Direction::Down, RefDate);
            FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Posting_Date, locILE.GETFILTER("Posting Date"));
            FMItemLedgerEntryQuantity.OPEN;
            while FMItemLedgerEntryQuantity.READ do begin
                locSalesActualMth.INIT;
                EntryNo += 1;
                locSalesActualMth."Entry No." := EntryNo;
                locSalesActualMth."Account Type" := locSalesActualMth."Account Type"::Customer;
                locSalesActualMth."Account No." := DELCHR(FMItemLedgerEntryQuantity.ItemNo, '<', '0');
                locSalesActualMth."Bal. Account No." := DELCHR(FMItemLedgerEntryQuantity.SourceNo, '<', '0');
                //  locSalesActualMth."Remaining Amount" := FMItemLedgerEntryQuantity.Sum_Quantity_in_HL; //BC Upgrade GUNREM01 -DIT Field
                locSalesActualMth."Remaining Amount" := FMItemLedgerEntryQuantity.Volume_2_101FDW; //BC UPGRADE KUMARR78 FM++
                locSalesActualMth."Document No." := YearMonth;
                locSalesActualMth.INSERT;
            end;
        end;
        if FMItemLedgerEntryQuantity.OPEN then
            FMItemLedgerEntryQuantity.CLOSE;
        //HEI.66<<

    end;

    procedure ProcessSalesActualWeekRequest(InterfaceEntryHeader: Record "Interface Entry Header INT") ReturnValue: Text;
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryComponentOut: Record "Interface Entry Component INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        Item: Record Item;
        ItemCrossRefError: Label 'Item No. %1 has no item cross reference with type bar code!';
        EntryNo: Integer;
        Customer: Record Customer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        YearMonth: Text[6];
    begin
        //HEI.02
        //Sales Actual Week NAV -> FuturMaster
        //>>HEI.06 comment old procedure
        /*
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Sell Act Week Req. Interface");
        
        IF NOT InterfaceSetup.Enabled THEN
          EXIT;
        
        FuturMasterInterfaceSetup.TESTFIELD("Cust. Master Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH Doc Types Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act WK Ref Date");
        
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup,OutboundInterface);
        
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader,FALSE);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Sell Act Week Resp. Interface";
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(TRUE);
        
        InterfaceEntryLine.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN
          REPEAT
            IF InterfaceEntryLine."No." <> '*' THEN BEGIN
              ItemLedgerEntry.RESET;
              ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
              ItemLedgerEntry.SETRANGE("Item No.", InterfaceEntryLine."No.");
              ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
              ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
              IF FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Location Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act MTH Location Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter");
              IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                GroupSalesActualWeek(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust. Master Acc Group Filter", TODAY, 8);
                TempSalesActualMth.RESET;
                IF TempSalesActualMth.FINDSET THEN
                  REPEAT
                    IF TempSalesActualMth."Remaining Amount" <> 0 THEN BEGIN
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    EntryNo += 1;
                    InterfaceEntryLineOut."Entry No." := EntryNo;
                    InterfaceEntryLineOut."No." := TempSalesActualMth."Account No.";
                    InterfaceEntryLineOut."Sell-to Customer No." := TempSalesActualMth."Bal. Account No.";
                    InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                    InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                    InterfaceEntryLineOut.Quantity := -TempSalesActualMth."Remaining Amount";
                    InterfaceEntryLineOut.INSERT;
                    END;
                  UNTIL TempSalesActualMth.NEXT = 0;
        
              END;
            END ELSE BEGIN
              ItemLedgerEntry.RESET;
              ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
              ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
              ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
              IF FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Location Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act MTH Location Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter");
              IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                GroupSalesActualWeek(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust. Master Acc Group Filter", TODAY, 8); //****
                TempSalesActualMth.RESET;
                IF TempSalesActualMth.FINDSET THEN
                  REPEAT
                    IF TempSalesActualMth."Remaining Amount" <> 0 THEN BEGIN
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    EntryNo += 1;
                    InterfaceEntryLineOut."Entry No." := EntryNo;
                    InterfaceEntryLineOut."No." := TempSalesActualMth."Account No.";
                    InterfaceEntryLineOut."Sell-to Customer No." := TempSalesActualMth."Bal. Account No.";
                    InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                    InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                    InterfaceEntryLineOut.Quantity := -TempSalesActualMth."Remaining Amount";
                    InterfaceEntryLineOut.INSERT;
                    END;
                  UNTIL TempSalesActualMth.NEXT = 0;
        
              END;
        
            END;
          UNTIL InterfaceEntryLine.NEXT = 0;
        
        IF EntryNo = 0 THEN BEGIN
          CLEAR(InterfaceEntryLineOut);
          EntryNo := EntryNo + 1;
          InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
          InterfaceEntryLineOut."Entry No." := EntryNo;
          InterfaceEntryLineOut."No." := '';
          InterfaceEntryLineOut."E-Mail 2" := '';
          InterfaceEntryLineOut."Legal Entity" := '';
          InterfaceEntryLineOut."Ship-to Address" := '';
          InterfaceEntryLineOut."Ship-to Name" := '';
          InterfaceEntryLineOut.INSERT;
          END;
        
        
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
        
        ReturnValue := FORMAT(InterfaceEntryHeaderOut."Entry No.");
        HEI.06<<*/

    end;

    local procedure GroupSalesActualWeek(var locILE: Record "Item Ledger Entry"; var locSalesActualMth: Record "Ledger Entry Matching Buffer" temporary; CustMasterAccGroup: Code[20]; RefDate: Date; NoOfPeriods: Integer);
    var
        EntryNo: Integer;
        Customer: Record Customer;
        i: Integer;
        YearWeek: Text[6];
        Item: Record Item;
        FMItemLedgerEntryQuantity: Query "FM Item Ledger Entry Quantity";
    begin
        //HEI.03
        locSalesActualMth.DELETEALL;
        CLEAR(EntryNo);
        //HEI.66>>
        //OLD>
        /*Customer.SETCURRENTKEY("Account Group");
        Customer.SETFILTER("Account Group", CustMasterAccGroup);
        
        //current week
        FOR i := 0 TO NoOfPeriods DO BEGIN
          CLEAR(YearWeek);
        
          YearWeek := SetPostingDateFilter(locILE, PeriodType::Week, i, Direction::Down, RefDate);
          IF locILE.FINDSET THEN
            REPEAT
              locSalesActualMth.SETRANGE("Account No.", locILE."Item No.");
              locSalesActualMth.SETRANGE("Bal. Account No.", locILE."Source No.");
              locSalesActualMth.SETRANGE("Document No.", YearWeek);
              IF locSalesActualMth.FINDFIRST THEN BEGIN
                { old
                IF Item.GET(locILE."Item No.") THEN
                  locSalesActualMth."Remaining Amount" += locILE.Quantity * Item."Unit Volume HL";
                  }
        
                IF Item.GET(locILE."Item No.") THEN
                  locSalesActualMth."Remaining Amount" += ConvertQtyToHL(locILE."Item No.", locILE.Quantity, '', locILE."Unit of Measure Code", locILE."Quantity in HL");
        
        
                locSalesActualMth.MODIFY;
              END ELSE BEGIN
                Customer.SETRANGE("No.", locILE."Source No.");
                IF Customer.FINDFIRST THEN BEGIN
                  locSalesActualMth.INIT;
                  EntryNo += 1;
                  locSalesActualMth."Entry No." := EntryNo;
                  locSalesActualMth."Account Type" := locSalesActualMth."Account Type"::Customer;
                  locSalesActualMth."Account No." := locILE."Item No.";
                  locSalesActualMth."Bal. Account No." := locILE."Source No.";
                  { old
                  IF Item.GET(locILE."Item No.") THEN
                    locSalesActualMth."Remaining Amount" := locILE.Quantity * Item."Unit Volume HL";
                    }
        
                  IF Item.GET(locILE."Item No.") THEN
                    locSalesActualMth."Remaining Amount" := ConvertQtyToHL(locILE."Item No.", locILE.Quantity, '', locILE."Unit of Measure Code", locILE."Quantity in HL");
        
        
        
                  locSalesActualMth."Document No." := YearWeek;
                  locSalesActualMth.INSERT;
        
                END;
              END;
            UNTIL locILE.NEXT = 0;
        
        END;*/
        //OLD<<
        FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Entry_Type, locILE.GETFILTER("Entry Type"));
        FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Source_Type, locILE.GETFILTER("Source Type"));
        FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Document_Type, locILE.GETFILTER("Document Type"));

        //HEI.68>>
        //FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Item_Category_Code,locILE.GETFILTER("Location Code"));
        FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Location_Code, locILE.GETFILTER("Location Code"));
        FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Item_Category_Code, locILE.GETFILTER("Item Category Code"));
        //HEI.68<<
        FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Account_Group, CustMasterAccGroup);
        for i := 0 to NoOfPeriods do begin
            //current month
            CLEAR(YearWeek);
            YearWeek := SetPostingDateFilter(locILE, PeriodType::Week, i, Direction::Down, RefDate);
            FMItemLedgerEntryQuantity.SETFILTER(FMItemLedgerEntryQuantity.Posting_Date, locILE.GETFILTER("Posting Date"));
            FMItemLedgerEntryQuantity.OPEN;
            while FMItemLedgerEntryQuantity.READ do begin
                locSalesActualMth.INIT;
                EntryNo += 1;
                locSalesActualMth."Entry No." := EntryNo;
                locSalesActualMth."Account Type" := locSalesActualMth."Account Type"::Customer;
                locSalesActualMth."Account No." := DELCHR(FMItemLedgerEntryQuantity.ItemNo, '<', '0');
                locSalesActualMth."Bal. Account No." := DELCHR(FMItemLedgerEntryQuantity.SourceNo, '<', '0');
                //  locSalesActualMth."Remaining Amount" := FMItemLedgerEntryQuantity.Sum_Quantity_in_HL; //BC Upgrade GUNREM01 -DIT Field
                locSalesActualMth."Remaining Amount" := FMItemLedgerEntryQuantity.Volume_2_101FDW; //BC UPGRADE KUMARR78 FM++
                locSalesActualMth."Document No." := YearWeek;
                locSalesActualMth.INSERT;
            end;
        end;
        if FMItemLedgerEntryQuantity.OPEN then
            FMItemLedgerEntryQuantity.CLOSE;
        //HEI.66<<

    end;

    local procedure SetPostingDateFilter(var ILE: Record "Item Ledger Entry"; PeriodType: Option Month,Week; Index: Integer; Direction: Option Up,Down; RefDate: Date) DateFilter: Text[6];
    var
        ThisMonthFirst: Date;
        ThisMonthLast: Date;
        PrevMonthFirst: Date;
        PrevMonthLast: Date;
        recDate: Record Date;
        StartDate: Date;
        EndDate: Date;
        FirstCurrDay: Date;
        FirstDay: Date;
        EndDay: Date;
    begin
        //HEI.03
        if (PeriodType = PeriodType::Month) and (Direction = Direction::Down) then begin
            FirstCurrDay := DMY2DATE(1, DATE2DMY(RefDate, 2), DATE2DMY(RefDate, 3));
            FirstDay := CALCDATE('-' + FORMAT(Index) + 'M', FirstCurrDay);
            EndDay := CALCDATE('+1M', FirstDay) - 1;
            ILE.SETRANGE("Posting Date", FirstDay, EndDay);
            exit(FormatDateYYYYMM(FirstDay));

        end;


        if (PeriodType = PeriodType::Week) and (Direction = Direction::Down) then begin
            recDate.RESET;
            recDate.SETRANGE("Period Type", recDate."Period Type"::Week);
            recDate.SETRANGE("Period No.", DATE2DWY(RefDate, 2), DATE2DWY(RefDate, 2));
            //recDate.SETRANGE("Period Start", DMY2DATE(1, 1, DATE2DMY(RefDate, 3)), DMY2DATE(31, 12, DATE2DMY(RefDate, 3)));
            //HEI.06 comment line recDate.SETRANGE("Period End", DMY2DATE(1, 1, DATE2DMY(RefDate, 3)), DMY2DATE(31, 12, DATE2DMY(RefDate, 3)));
            //>>HEI.06
            recDate.SETFILTER(recDate."Period Start", '<=%1', RefDate);
            recDate.SETFILTER(recDate."Period End", '>=%1', RefDate);
            //<<HEI.06
            if recDate.FINDFIRST then begin
                Index := Index * 7;
                StartDate := CALCDATE('-' + FORMAT(Index) + 'D', recDate."Period Start");
                EndDate := CALCDATE('-' + FORMAT(Index) + 'D', recDate."Period End");
                ILE.SETRANGE("Posting Date", StartDate, EndDate);
                exit(FormatDateYYYYWW(StartDate));
            end;
        end;
    end;

    procedure ProcessSalesActualMth3YRRequest(InterfaceEntryHeader: Record "Interface Entry Header INT") ReturnValue: Text;
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryComponentOut: Record "Interface Entry Component INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        Item: Record Item;
        ItemCrossRefError: Label 'Item No. %1 has no item cross reference with type bar code!';
        EntryNo: Integer;
        Customer: Record Customer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        YearMonth: Text[6];
        NoOfPeriod: Integer;
        Calendar: Record Date;
    begin
        //HEI.02
        //Sales Actual Month 3YR NAV -> FuturMaster
        //>>HEI.06 comment old procedure
        /*
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Sell Act Mth 3YR  Req. Interf");
        
        IF NOT InterfaceSetup.Enabled THEN
          EXIT;
        
        FuturMasterInterfaceSetup.TESTFIELD("Cust. Master Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH Doc Types Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Mth 3YR Start Date");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Mth 3YR End  Date");
        
        //calculate number of months.
        Calendar.RESET;
        Calendar.SETRANGE("Period Type",Calendar."Period Type"::Month);
        Calendar.SETRANGE("Period Start",FuturMasterInterfaceSetup."Sell Act Mth 3YR Start Date", FuturMasterInterfaceSetup."Sell Act Mth 3YR End  Date");
        NoOfPeriod :=  Calendar.COUNT;
        
        
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup,OutboundInterface);
        
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader,FALSE);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Sell Act Mth 3YR Resp. Interf";
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(TRUE);
        
        InterfaceEntryLine.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN
          REPEAT
            IF InterfaceEntryLine."No." <> '*' THEN BEGIN
              ItemLedgerEntry.RESET;
              ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
              ItemLedgerEntry.SETRANGE("Item No.", InterfaceEntryLine."No.");
              ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
              ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
              IF FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Location Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act MTH Location Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter");
              IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                GroupSalesActualMonth(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust. Master Acc Group Filter", FuturMasterInterfaceSetup."Sell Act Mth 3YR End  Date", NoOfPeriod-1);
                TempSalesActualMth.RESET;
                IF TempSalesActualMth.FINDSET THEN
                  REPEAT
                    IF TempSalesActualMth."Remaining Amount" <> 0 THEN BEGIN
                      CLEAR(InterfaceEntryLineOut);
                      InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                      EntryNo +=1;
                      InterfaceEntryLineOut."Entry No." := EntryNo;
                      InterfaceEntryLineOut."No." := TempSalesActualMth."Account No.";
                      InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                      InterfaceEntryLineOut."Sell-to Customer No." := TempSalesActualMth."Bal. Account No.";
                      InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                      InterfaceEntryLineOut.Quantity := -TempSalesActualMth."Remaining Amount";
                      InterfaceEntryLineOut.INSERT;
                      END;
                  UNTIL TempSalesActualMth.NEXT = 0;
        
              END;
            END ELSE BEGIN
        
              ItemLedgerEntry.RESET;
              ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
              ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
              ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
              IF FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Location Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act MTH Location Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter");
              IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                GroupSalesActualMonth(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust. Master Acc Group Filter", FuturMasterInterfaceSetup."Sell Act Mth 3YR End  Date", NoOfPeriod-1);
                TempSalesActualMth.RESET;
                IF TempSalesActualMth.FINDSET THEN
                  REPEAT
                    IF TempSalesActualMth."Remaining Amount" <> 0 THEN BEGIN
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    EntryNo +=1;
                    InterfaceEntryLineOut."Entry No." := EntryNo;
                    InterfaceEntryLineOut."No." := TempSalesActualMth."Account No.";
                    InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                    InterfaceEntryLineOut."Sell-to Customer No." := TempSalesActualMth."Bal. Account No.";
                    InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                    InterfaceEntryLineOut.Quantity := - TempSalesActualMth."Remaining Amount";
                    InterfaceEntryLineOut.INSERT;
                    END;
                  UNTIL TempSalesActualMth.NEXT = 0;
        
              END;
        
            END;
          UNTIL InterfaceEntryLine.NEXT = 0;
        
        IF EntryNo = 0 THEN BEGIN
          CLEAR(InterfaceEntryLineOut);
          EntryNo := EntryNo + 1;
          InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
          InterfaceEntryLineOut."Entry No." := EntryNo;
          InterfaceEntryLineOut."No." := '';
          InterfaceEntryLineOut."E-Mail 2" := '';
          InterfaceEntryLineOut."Legal Entity" := '';
          InterfaceEntryLineOut."Ship-to Address" := '';
          InterfaceEntryLineOut."Ship-to Name" := '';
          InterfaceEntryLineOut.INSERT;
          END;
        
        
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
        
        ReturnValue := FORMAT(InterfaceEntryHeaderOut."Entry No.");
        HEI.06<<*/

    end;

    procedure ProcessSalesActualWeek3YRRequest(InterfaceEntryHeader: Record "Interface Entry Header INT") ReturnValue: Text;
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryComponentOut: Record "Interface Entry Component INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        Item: Record Item;
        ItemCrossRefError: Label 'Item No. %1 has no item cross reference with type bar code!';
        EntryNo: Integer;
        Customer: Record Customer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        YearMonth: Text[6];
        Calendar: Record Date;
        NoOfPeriod: Integer;
    begin
        //HEI.02
        //Sales Actual Week 3 YR NAV -> FuturMaster
        //>>HEI.06 comment old procedure
        /*
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Sell Act Week 3YR  Req. Interf");
        
        IF NOT InterfaceSetup.Enabled THEN
          EXIT;
        
        FuturMasterInterfaceSetup.TESTFIELD("Cust. Master Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH Doc Types Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Wk 3YR Start Date");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Wk 3YR End  Date");
        
        //calculate number of weeks
        Calendar.RESET;
        Calendar.SETRANGE("Period Type",Calendar."Period Type"::Week);
        Calendar.SETRANGE("Period Start",FuturMasterInterfaceSetup."Sell Act Wk 3YR Start Date", FuturMasterInterfaceSetup."Sell Act Wk 3YR End  Date");
        NoOfPeriod :=  Calendar.COUNT;
        
        
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup,OutboundInterface);
        
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader,FALSE);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Sell Act Week 3YR Resp. Interf";
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryHeaderOut.INSERT(TRUE);
        
        InterfaceEntryLine.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN
          REPEAT
            IF InterfaceEntryLine."No." <> '*' THEN BEGIN
              ItemLedgerEntry.RESET;
              ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
              ItemLedgerEntry.SETRANGE("Item No.", InterfaceEntryLine."No.");
              ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
              ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
              IF FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Location Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act MTH Location Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter");
              IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                GroupSalesActualWeek(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust. Master Acc Group Filter", FuturMasterInterfaceSetup."Sell Act Wk 3YR End  Date", NoOfPeriod-1);
                TempSalesActualMth.RESET;
                IF TempSalesActualMth.FINDSET THEN
                  REPEAT
                    IF TempSalesActualMth."Remaining Amount" <> 0 THEN BEGIN
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    EntryNo += 1;
                    InterfaceEntryLineOut."Entry No." := EntryNo;
                    InterfaceEntryLineOut."No." := TempSalesActualMth."Account No.";
                    InterfaceEntryLineOut."Sell-to Customer No." := TempSalesActualMth."Bal. Account No.";
                    InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                    InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                    InterfaceEntryLineOut.Quantity := -TempSalesActualMth."Remaining Amount";
                    InterfaceEntryLineOut.INSERT;
                    END;
                  UNTIL TempSalesActualMth.NEXT = 0;
        
              END;
            END ELSE BEGIN
              ItemLedgerEntry.RESET;
              ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
              ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
              ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
              IF FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Location Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act MTH Location Filter");
              IF FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter" <> '' THEN
                ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter");
              IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                GroupSalesActualWeek(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust. Master Acc Group Filter", FuturMasterInterfaceSetup."Sell Act Wk 3YR End  Date", NoOfPeriod-1);
                TempSalesActualMth.RESET;
                IF TempSalesActualMth.FINDSET THEN
                  REPEAT
                    IF TempSalesActualMth."Remaining Amount" <> 0 THEN BEGIN
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    EntryNo += 1;
                    InterfaceEntryLineOut."Entry No." := EntryNo;
                    InterfaceEntryLineOut."No." := TempSalesActualMth."Account No.";
                    InterfaceEntryLineOut."Sell-to Customer No." := TempSalesActualMth."Bal. Account No.";
                    InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                    InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                    InterfaceEntryLineOut.Quantity := -TempSalesActualMth."Remaining Amount";
                    InterfaceEntryLineOut.INSERT;
                    END;
                  UNTIL TempSalesActualMth.NEXT = 0;
        
              END;
        
            END;
          UNTIL InterfaceEntryLine.NEXT = 0;
        
        IF EntryNo = 0 THEN BEGIN
          CLEAR(InterfaceEntryLineOut);
          EntryNo := EntryNo + 1;
          InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
          InterfaceEntryLineOut."Entry No." := EntryNo;
          InterfaceEntryLineOut."No." := '';
          InterfaceEntryLineOut."E-Mail 2" := '';
          InterfaceEntryLineOut."Legal Entity" := '';
          InterfaceEntryLineOut."Ship-to Address" := '';
          InterfaceEntryLineOut."Ship-to Name" := '';
          InterfaceEntryLineOut.INSERT;
          END;
        
        
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
        
        ReturnValue := FORMAT(InterfaceEntryHeaderOut."Entry No.");
        HEI.06<<*/

    end;

    procedure CreateDemandPlanOpenOrders(var SalesLine: Record "Sales Line"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Demand Plann Open Order Interf");
        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;
        //HEI.12>>
        /*
        FuturMasterInterfaceSetup.TESTFIELD("Cust. DOO Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Demand Plann Open Order Interf");
        FuturMasterInterfaceSetup.TESTFIELD("Demand Pl OO Item Categ Filter");
        
        //>>interface filters
        //SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code","Delayed Sequence No.","Shipment Date");
        SalesLine.SETFILTER("Document Type", FuturMasterInterfaceSetup."Demand Pl OO  Doc Types Filter");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        //SalesLine.SETFILTER("Qty. to Ship",'<>0');
        SalesLine.SETFILTER("HL Cubage",'<>0');
        
        Item.RESET;
        Item.SETCURRENTKEY("Item Category Code","Product Group Code");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Demand Pl OO Item Categ Filter");
        
        Customer.RESET;
        Customer.SETCURRENTKEY("Account Group");
        Customer.SETFILTER("Account Group", FuturMasterInterfaceSetup."Cust. DOO Acc Group Filter");
        //<<interface filters
        */
        //HEI.12<<
        /*
        IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*/ //HEI.33>>
                     //HEI.12>>
        FuturMasterInterfaceSetup.TESTFIELD("Cust. DOO Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Demand Plann Open Order Interf");
        FuturMasterInterfaceSetup.TESTFIELD("Demand Pl OO Item Categ Filter");

        //>>interface filters
        //SalesLine.RESET;
        // SalesLine.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Delayed Sequence No.", "Shipment Date"); //BC Upgrade GUNREM01 -dependency with DIT Field
        SalesLine.SETFILTER("Document Type", FuturMasterInterfaceSetup."Demand Pl OO  Doc Types Filter");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        //SalesLine.SETFILTER("Qty. to Ship",'<>0');
        SalesLine.SETFILTER("Volume Out. 107FDW", '<>0'); //BC UPGRADE KUMARR78 25-05-2026
        //  SalesLine.SETFILTER("HL Cubage", '<>0'); //BC Upgrade GUNREM01 -DIT Field
        // SalesLine.SETFILTER("Volume 2 101FDW", '<>0'); //BC UPGRADE KUMARR78 25-05-2026 --


        Item.RESET;
        Item.SETCURRENTKEY("Item Category Code", "Product Group Code FND");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Demand Pl OO Item Categ Filter");

        Customer.RESET;
        Customer.SETCURRENTKEY("Account Group FND");
        Customer.SETFILTER("Account Group FND", FuturMasterInterfaceSetup."Cust. DOO Acc Group Filter");
        //<<interface filters
        //HEI.12<<

        GroupSalesLine(SalesLine, TempGroupSalesLine);  //HEI.25

        //process the orders
        //IF SalesLine.FINDSET THEN BEGIN  //commented by HEI.25
        //HEI.25<<
        TempGroupSalesLine.RESET;
        TempGroupSalesLine.SETCURRENTKEY("Bal. Account No.", "Account No.", "Posting Date");
        if TempGroupSalesLine.FINDSET then begin
            //HEI.25>>

            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Demand Plann Open Order Interf";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;
            InterfaceEntryHeaderOut.INSERT(true);

            /*//commented by HEI.25<<
            REPEAT
              Item.SETRANGE("No.", SalesLine."No.");
              IF Item.FINDFIRST THEN BEGIN
                Customer.SETRANGE("No.", SalesLine."Sell-to Customer No.");
                IF Customer.FINDFIRST THEN BEGIN
                  CLEAR(InterfaceEntryLineOut);
                  InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                  EntryNo += 1;
                  InterfaceEntryLineOut."Entry No." := EntryNo;
                  InterfaceEntryLineOut."No." := SalesLine."No.";
                  InterfaceEntryLineOut."Buy-from Vendor No." := SalesLine."Sell-to Customer No.";
                  InterfaceEntryLineOut."Action Code" := FORMAT(DATE2DMY(SalesLine."Shipment Date", 3));
                  IF DATE2DMY(SalesLine."Shipment Date", 2) < 10 THEN
                    InterfaceEntryLineOut."External Contract No." := '0'+ FORMAT(DATE2DMY(SalesLine."Shipment Date", 2))
                  ELSE
                  InterfaceEntryLineOut."External Contract No." := FORMAT(DATE2DMY(SalesLine."Shipment Date", 2));
                  IF DATE2DMY(SalesLine."Shipment Date", 1) < 10 THEN
                    InterfaceEntryLineOut."External Contract Line No." := '0'+ FORMAT(DATE2DMY(SalesLine."Shipment Date", 1))
                  ELSE
                  InterfaceEntryLineOut."External Contract Line No." := FORMAT(DATE2DMY(SalesLine."Shipment Date", 1));
                  InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                  //InterfaceEntryLineOut.Quantity := SalesLine."HL Cubage";
                  InterfaceEntryLineOut.Quantity := ConvertQtyToHL(SalesLine."No.", SalesLine."Outstanding Quantity", '', SalesLine."Unit of Measure Code", SalesLine."HL Cubage");
                  InterfaceEntryLineOut."No." := DELCHR(SalesLine."No.", '<', '0');
                  InterfaceEntryLineOut."Buy-from Vendor No." := DELCHR(SalesLine."Sell-to Customer No.",'<','0');
        
                  InterfaceEntryLineOut.INSERT;
                END;
              END;
            UNTIL SalesLine.NEXT = 0
            *///commented by HEI.25>>
              //HEI.25<<
            repeat
                Item.SETRANGE("No.", TempGroupSalesLine."Bal. Account No.");
                if Item.FINDFIRST then begin
                    Customer.SETRANGE("No.", TempGroupSalesLine."Account No.");
                    if Customer.FINDFIRST then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        EntryNo += 1;
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut."No." := DELCHR(TempGroupSalesLine."Bal. Account No.", '<', '0');
                        InterfaceEntryLineOut."Buy-from Vendor No." := DELCHR(TempGroupSalesLine."Account No.", '<', '0');
                        InterfaceEntryLineOut."Action Code" := FORMAT(DATE2DMY(TempGroupSalesLine."Posting Date", 3));
                        if DATE2DMY(TempGroupSalesLine."Posting Date", 2) < 10 then
                            InterfaceEntryLineOut."External Contract No." := '0' + FORMAT(DATE2DMY(TempGroupSalesLine."Posting Date", 2))
                        else
                            InterfaceEntryLineOut."External Contract No." := FORMAT(DATE2DMY(TempGroupSalesLine."Posting Date", 2));
                        if DATE2DMY(TempGroupSalesLine."Posting Date", 1) < 10 then
                            InterfaceEntryLineOut."External Contract Line No." := '0' + FORMAT(DATE2DMY(TempGroupSalesLine."Posting Date", 1))
                        else
                            InterfaceEntryLineOut."External Contract Line No." := FORMAT(DATE2DMY(TempGroupSalesLine."Posting Date", 1));
                        InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                        InterfaceEntryLineOut.Quantity := TempGroupSalesLine."Remaining Amount";
                        InterfaceEntryLineOut.INSERT;
                    end;
                end;
            until TempGroupSalesLine.NEXT = 0
            //HEI.25>>
            //

        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Demand Plann Open Order Interf";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;

                InterfaceEntryHeaderOut.INSERT(true);
            end;
            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo += 1;
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."Sell-to Customer No." := '';
            InterfaceEntryLineOut."Action Code" := '';
            InterfaceEntryLineOut."External Contract No." := '';
            InterfaceEntryLineOut."External Contract Line No." := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut.Quantity := 0;
            InterfaceEntryLineOut.INSERT;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END; HEI.33>>

    end;

    local procedure CalculateRunTime(CurrTime: Time; InterfaceSetup: Record "Interface Setup INT"): Boolean;
    var
        TimeToRun: Record "Record Buffer" temporary;
        EntryNo: Integer;
        StartTime: Time;
    begin
        //HEI.03
        StartTime := InterfaceSetup."Starting Time";

        //HEI.08>>
        //time to run passed
        if TODAY > DT2DATE(InterfaceSetup."Last Execution Date/Time") then begin
            if (InterfaceSetup."Starting Time" <= CurrTime) and (InterfaceSetup."Ending Time" <= CurrTime) then begin
                if ((DATE2DWY(TODAY, 1) = 1) and InterfaceSetup."Run on Mondays") or
                  ((DATE2DWY(TODAY, 1) = 2) and InterfaceSetup."Run on Tuesdays") or
                  ((DATE2DWY(TODAY, 1) = 3) and InterfaceSetup."Run on Wednesdays") or
                  ((DATE2DWY(TODAY, 1) = 4) and InterfaceSetup."Run on Thursdays") or
                  ((DATE2DWY(TODAY, 1) = 5) and InterfaceSetup."Run on Fridays") or
                  ((DATE2DWY(TODAY, 1) = 7) and InterfaceSetup."Run on Sundays") or
                  ((DATE2DWY(TODAY, 1) = 6) and InterfaceSetup."Run on Saturdays") then begin
                    InterfaceSetup."Last Execution Date/Time" := CREATEDATETIME(TODAY, CurrTime);
                    InterfaceSetup.MODIFY;
                    exit(true);
                end;
            end;
        end;

        if TODAY = DT2DATE(InterfaceSetup."Last Execution Date/Time") then begin
            if (CurrTime > DT2TIME(InterfaceSetup."Last Execution Date/Time")) and
              (DT2TIME(InterfaceSetup."Last Execution Date/Time") < InterfaceSetup."Starting Time") and
              (DT2TIME(InterfaceSetup."Last Execution Date/Time") < InterfaceSetup."Ending Time") and
              (CurrTime > InterfaceSetup."Ending Time") then begin
                if ((DATE2DWY(TODAY, 1) = 1) and InterfaceSetup."Run on Mondays") or
                  ((DATE2DWY(TODAY, 1) = 2) and InterfaceSetup."Run on Tuesdays") or
                  ((DATE2DWY(TODAY, 1) = 3) and InterfaceSetup."Run on Wednesdays") or
                  ((DATE2DWY(TODAY, 1) = 4) and InterfaceSetup."Run on Thursdays") or
                  ((DATE2DWY(TODAY, 1) = 5) and InterfaceSetup."Run on Fridays") or
                  ((DATE2DWY(TODAY, 1) = 7) and InterfaceSetup."Run on Sundays") or
                  ((DATE2DWY(TODAY, 1) = 6) and InterfaceSetup."Run on Saturdays") then begin
                    InterfaceSetup."Last Execution Date/Time" := CREATEDATETIME(TODAY, CurrTime);
                    InterfaceSetup.MODIFY;
                    exit(true);
                end;
            end;
        end;
        //HEI.08<< improvements

        while (StartTime <= InterfaceSetup."Ending Time") do begin
            //IF ABS(CurrTime - StartTime) < 30000 THEN
            if (FORMAT(CurrTime, 0, '<Hours24><Minutes,2>') = FORMAT(StartTime, 0, '<Hours24><Minutes,2>')) then begin
                if (DATE2DWY(TODAY, 1) = 1) and InterfaceSetup."Run on Mondays" then begin
                    //HEI.08>> improvements
                    InterfaceSetup."Last Execution Date/Time" := CREATEDATETIME(TODAY, CurrTime);
                    InterfaceSetup.MODIFY;
                    //HEI.08<< improvements
                    exit(true);
                end;
                if (DATE2DWY(TODAY, 1) = 2) and InterfaceSetup."Run on Tuesdays" then begin
                    //HEI.08>> improvements
                    InterfaceSetup."Last Execution Date/Time" := CREATEDATETIME(TODAY, CurrTime);
                    InterfaceSetup.MODIFY;
                    //HEI.08<< improvements
                    exit(true);
                end;
                if (DATE2DWY(TODAY, 1) = 3) and InterfaceSetup."Run on Wednesdays" then begin
                    //HEI.08>> improvements
                    InterfaceSetup."Last Execution Date/Time" := CREATEDATETIME(TODAY, CurrTime);
                    InterfaceSetup.MODIFY;
                    //HEI.08<< improvements
                    exit(true);
                end;
                if (DATE2DWY(TODAY, 1) = 4) and InterfaceSetup."Run on Thursdays" then begin
                    //HEI.08>> improvements
                    InterfaceSetup."Last Execution Date/Time" := CREATEDATETIME(TODAY, CurrTime);
                    InterfaceSetup.MODIFY;
                    //HEI.08<< improvements
                    exit(true);
                end;
                if (DATE2DWY(TODAY, 1) = 5) and InterfaceSetup."Run on Fridays" then begin
                    //HEI.08>> improvements
                    InterfaceSetup."Last Execution Date/Time" := CREATEDATETIME(TODAY, CurrTime);
                    InterfaceSetup.MODIFY;
                    //HEI.08<< improvements
                    exit(true);
                end;
                if (DATE2DWY(TODAY, 1) = 6) and InterfaceSetup."Run on Saturdays" then begin
                    InterfaceSetup."Last Execution Date/Time" := CREATEDATETIME(TODAY, CurrTime);
                    InterfaceSetup.MODIFY;
                    //HEI.08<< improvements
                    exit(true);
                end;
                if (DATE2DWY(TODAY, 1) = 7) and InterfaceSetup."Run on Sundays" then begin
                    //HEI.08>> improvements
                    InterfaceSetup."Last Execution Date/Time" := CREATEDATETIME(TODAY, CurrTime);
                    InterfaceSetup.MODIFY;
                    //HEI.08<< improvements
                    exit(true);
                end;
            end;
            StartTime := StartTime + InterfaceSetup."No. of Minutes between Runs" * 60000;
        end;
        exit(false);
    end;

    procedure CreateMasterDataProducts(var Item: Record Item; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Customer: Record Customer;
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Product Master Interface");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        GeneralInterfaceSetup.TESTFIELD("Brand Dim. Code");
        FuturMasterInterfaceSetup.TESTFIELD("Product Master Category Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Product Master Interface");
        FuturMasterInterfaceSetup.TESTFIELD("Product Master Def UOM");
        
        //>>interface filters
        //Item.RESET;
        Item.SETCURRENTKEY("Item Category Code","Product Group Code");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Product Master Category Filter");
        Item.SETRANGE(Blocked,FALSE);
        //<<interface filters
        */
        //HEI.12<<

        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*/ //HEI.33>>
                     //HEI.12>>
        GeneralInterfaceSetup.TESTFIELD("Brand Dim. Code");
        FuturMasterInterfaceSetup.TESTFIELD("Product Master Category Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Product Master Interface");
        FuturMasterInterfaceSetup.TESTFIELD("Product Master Def UOM");

        //>>interface filters
        //Item.RESET;
        Item.SETCURRENTKEY("Item Category Code", "Product Group Code FND");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Product Master Category Filter");
        Item.SETRANGE(Blocked, false);
        //<<interface filters
        //HEI.12<<

        //process the orders
        if Item.FINDSET then begin
            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Product Master Interface";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;
            InterfaceEntryHeaderOut.INSERT(true);

            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                EntryNo += 1;
                InterfaceEntryLineOut."Entry No." := EntryNo;
                InterfaceEntryLineOut."No." := Item."No.";
                InterfaceEntryLineOut."Global No." := Item."No. 2";
                InterfaceEntryLineOut.Description := Item.Description;
                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                //InterfaceEntryLineOut."Unit of Measure Code" := Item."Base Unit of Measure";
                InterfaceEntryLineOut."Unit of Measure Code" := FuturMasterInterfaceSetup."Product Master Def UOM";
                GetProductMasterValues(InterfaceEntryLineOut);
                InterfaceEntryLineOut."No." := DELCHR(Item."No.", '<', '0');
                InterfaceEntryLineOut."Global No." := DELCHR(Item."No. 2", '<', '0');
                InterfaceEntryLineOut.INSERT;
            until Item.NEXT = 0

        end;

        //for empty file
        if EntryNo = 0 then begin

            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Product Master Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo += 1;
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."Global No." := '';
            InterfaceEntryLineOut.Description := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Unit of Measure Code" := '';
            InterfaceEntryLineOut.INSERT;

        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END; HEI.33>>

    end;

    procedure CreateMasterDataCustomers(var Customer: Record Customer; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        CustomerAttrib: Record "Customer Attributes FND";
        ValidCust: Boolean;
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Customer Master Interface");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        GeneralInterfaceSetup.TESTFIELD("Brand Dim. Code");
        FuturMasterInterfaceSetup.TESTFIELD("Cust. Master Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Customer Master Interface");
        
        //>>interface filters
        //Customer.RESET;
        Customer.SETCURRENTKEY("Account Group");
        Customer.SETFILTER("Account Group",FuturMasterInterfaceSetup."Cust. Master Acc Group Filter");
        //<<interface filters
        */
        //HEI.12<<

        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*/ //HEI.33>>
                     //HEI.12>>
        GeneralInterfaceSetup.TESTFIELD("Brand Dim. Code");
        FuturMasterInterfaceSetup.TESTFIELD("Cust. Master Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Customer Master Interface");

        //>>interface filters
        //Customer.RESET;
        Customer.SETCURRENTKEY("Account Group FND");
        Customer.SETFILTER("Account Group FND", FuturMasterInterfaceSetup."Cust. Master Acc Group Filter");
        //HEI.21>>
        if FuturMasterInterfaceSetup."Cust. Contract Type Excl Filte" <> FuturMasterInterfaceSetup."Cust. Contract Type Excl Filte"::"Not applicable" then  //HEI.24
            Customer.SETFILTER("Contract Type FND", '<>%1', FuturMasterInterfaceSetup."Cust. Contract Type Excl Filte");
        //HEI.21<<
        //<<interface filters
        //HEI.12<<
        //process the orders
        if Customer.FINDSET then begin
            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Customer Master Interface";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);

            repeat

                //HEI.03>>
                ValidCust := false;
                if CustomerAttrib.GET(Customer."No.") then begin
                    if (FuturMasterInterfaceSetup."Cust. Master Active Filter" = FuturMasterInterfaceSetup."Cust. Master Active Filter"::Active) and (not CustomerAttrib."Flag for Deletion") then
                        ValidCust := true;
                    if (FuturMasterInterfaceSetup."Cust. Master Active Filter" = FuturMasterInterfaceSetup."Cust. Master Active Filter"::Inactive) and (CustomerAttrib."Flag for Deletion") then
                        ValidCust := true;
                    if (FuturMasterInterfaceSetup."Cust. Master Active Filter" = FuturMasterInterfaceSetup."Cust. Master Active Filter"::" ") then
                        ValidCust := true;
                end else
                    ValidCust := true;

                if ValidCust then begin
                    //HEI.03<<
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    EntryNo += 1;
                    InterfaceEntryLineOut."Entry No." := EntryNo;
                    InterfaceEntryLineOut."No." := Customer."No.";
                    InterfaceEntryLineOut."E-Mail 2" := COPYSTR(Customer.Name + ' ' + Customer."Name 2", 1, 100);
                    InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                    InterfaceEntryLineOut."Ship-to Address" := Customer.City;
                    InterfaceEntryLineOut."Ship-to Name" := Customer.City;
                    GetCustomerMasterValues(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."No." := DELCHR(Customer."No.", '<', '0');
                    InterfaceEntryLineOut.INSERT;
                    //HEI.03>>
                end;
            //HEI.03<<

            until Customer.NEXT = 0
        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Customer Master Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo += 1;
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."E-Mail 2" := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Ship-to Address" := '';
            InterfaceEntryLineOut."Ship-to Name" := '';
            InterfaceEntryLineOut.INSERT;

        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");


        //END; HEI.33>>

    end;

    local procedure ProcessManualOutboundEntries(EntryNo: Integer);
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        InfoDialog: Dialog;
    begin
        //HEI.03
        InterfaceEntryHeader.SETRANGE(Direction, InterfaceEntryHeader.Direction::Outbound);
        InterfaceEntryHeader.SETRANGE(Status, InterfaceEntryHeader.Status::Pending);
        InterfaceEntryHeader.SETRANGE("Entry No.", EntryNo);
        if InterfaceEntryHeader.FINDSET then
            repeat
                InterfaceSetup.GET(InterfaceEntryHeader."Interface Code");
                if InterfaceSetup."Call Type" = InterfaceSetup."Call Type"::Asynchronous then begin
                    InfoDialog.OPEN('#1######');

                    InfoDialog.UPDATE(1, 'Processing data..');
                    CLEARLASTERROR;
                    COMMIT;
                    if CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeader) then begin

                        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                        // MV SLEEP(5000); //HEI.28
                        InfoDialog.UPDATE(1, Text005);
                        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
                        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
                        InfoDialog.CLOSE;
                        MESSAGE(Text004)
                    end else begin
                        InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GETLASTERRORTEXT);
                        InfoDialog.CLOSE;
                        MESSAGE(Text003);
                    end;
                end;
            until InterfaceEntryHeader.NEXT = 0;
    end;

    procedure CreateSellInActualsMonth(var ItemLedgerEntry: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
        IncludeReturnReceipts: Boolean;
        ItemLedgerEntryReturn: Record "Item Ledger Entry";
        TempReturnActualMth: Record "Ledger Entry Matching Buffer" temporary;
        CompanyCode: Code[10];
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        GetFuturMasterInterfaceSetup3;//HEI.42
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Month Interface");
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Sell Act Month Interface");


        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        CompanyCode := GeneralInterfaceSetup."Company Code ID";//HEI.66

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        FuturMasterInterfaceSetup.TESTFIELD("Cust.SellActM Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH Doc Types Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH Item Categ Filter");
        
        //>>HEI.06
        IF FuturMasterInterfaceSetup."Sell Act MTH Ref Date" = 0D THEN
          FuturMasterInterfaceSetup."Sell Act MTH Ref Date" := TODAY;
        //<<HEI.06
        
        IF NOT Scheduled THEN
          FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH Ref Date");
        
        
        //>>interface filters
        //ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        IF FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter" <> '' THEN
          ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter");
        IF FuturMasterInterfaceSetup."Sell Act MTH Location Filter" <> '' THEN
         ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act MTH Location Filter");
        IF FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter" <> '' THEN
         ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter");
        
        //<<interface filters
        */
        //HEI.12<<


        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*///HEI.33>>
                    //HEI.12>>
        FuturMasterInterfaceSetup.TESTFIELD("Cust.SellActM Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH Doc Types Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH Item Categ Filter");

        //>>HEI.06
        if FuturMasterInterfaceSetup."Sell Act MTH Ref Date" = 0D then
            FuturMasterInterfaceSetup."Sell Act MTH Ref Date" := TODAY;
        //<<HEI.06

        if not Scheduled then
            FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH Ref Date");


        //>>interface filters
        //>>HEI.42
        ItemLedgerEntryReturn.COPYFILTERS(ItemLedgerEntry);
        IncludeReturnReceipts := GetSellActMonthReturnReceipts(ItemLedgerEntryReturn, TempReturnActualMth, Scheduled);
        //<<HEI.42
        //ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        if FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act MTH Doc Types Filter");
        if FuturMasterInterfaceSetup."Sell Act MTH Location Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act MTH Location Filter");
        if FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act MTH Item Categ Filter");
        //<<interface filters
        //HEI.12<<

        //process the orders
        if ItemLedgerEntry.FINDFIRST then begin
            if Scheduled then
                GroupSalesActualMonth(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust.SellActM Acc Group Filter", TODAY, 1)
            else
                GroupSalesActualMonth(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust.SellActM Acc Group Filter", FuturMasterInterfaceSetup."Sell Act MTH Ref Date", 1);
            TempSalesActualMth.RESET;
            if TempSalesActualMth.FINDSET then begin


                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Sell Act Month Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                //HEI.66>>
                //InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID" ;
                InterfaceEntryHeaderOut."Company Code ID" := CompanyCode;
                //HEI.66<<
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;

                InterfaceEntryHeaderOut.INSERT(true);

                repeat

                    //Add return receipt quantity
                    AddReturnReceiptQtyOnSellActShipments(TempSalesActualMth, TempReturnActualMth, IncludeReturnReceipts);//HEI.42
                    if TempSalesActualMth."Remaining Amount" <> 0 then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        EntryNo += 1;
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        //HEI.66>>
                        //InterfaceEntryLineOut."No." := DELCHR(TempSalesActualMth."Account No.", '<', '0');
                        //InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                        //InterfaceEntryLineOut."Buy-from Vendor No." := DELCHR(TempSalesActualMth."Bal. Account No.", '<', '0');
                        InterfaceEntryLineOut."No." := TempSalesActualMth."Account No.";
                        InterfaceEntryLineOut."Legal Entity" := CompanyCode;
                        InterfaceEntryLineOut."Buy-from Vendor No." := TempSalesActualMth."Bal. Account No.";
                        //HEI.66<<
                        InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                        InterfaceEntryLineOut.Quantity := -TempSalesActualMth."Remaining Amount";
                        InterfaceEntryLineOut.INSERT;
                    end;
                until TempSalesActualMth.NEXT = 0;
                //Create interface Entry Line for return receipts which don't have a match on shipments
                CreateSellInActIntEntryLineOut(InterfaceEntryHeaderOut, TempReturnActualMth, EntryNo);//>>HEI.42
            end;

        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Sell Act Month Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                //HEI.66>>
                //InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryHeaderOut."Company Code ID" := CompanyCode;
                //HEI.66<<
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;
            //>>HEI.42
            if IncludeReturnReceipts and ReturnReceiptExist(TempReturnActualMth) then
                CreateSellInActIntEntryLineOut(InterfaceEntryHeaderOut, TempReturnActualMth, EntryNo)
            else begin
                //<<HEI.42
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                EntryNo := EntryNo + 1;
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := EntryNo;
                InterfaceEntryLineOut."No." := '';
                InterfaceEntryLineOut."E-Mail 2" := '';
                //HEI.66>>
                //InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryLineOut."Legal Entity" := CompanyCode;
                //HEI.66<<
                InterfaceEntryLineOut."Ship-to Address" := '';
                InterfaceEntryLineOut."Ship-to Name" := '';
                InterfaceEntryLineOut.INSERT;
            end;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END;HEI.33>>

    end;

    procedure CreateSellInActualsWeek(var ItemLedgerEntry: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
        IncludeReturnReceipts: Boolean;
        ItemLedgerEntryReturn: Record "Item Ledger Entry";
        TempReturnActualMth: Record "Ledger Entry Matching Buffer" temporary;
        CompanyCode: Code[10];
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        GetFuturMasterInterfaceSetup3;//HEI.42
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Week Interface");
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Sell Act Week Interface");


        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        CompanyCode := GeneralInterfaceSetup."Company Code ID";//HEI.66
        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        FuturMasterInterfaceSetup.TESTFIELD("Cust.SellActW Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Week Doc Types Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Week Item Cat Filter");
        
        //>>HEI.06
        IF FuturMasterInterfaceSetup."Sell Act WK Ref Date" = 0D THEN
          FuturMasterInterfaceSetup."Sell Act WK Ref Date" := TODAY;
        //<<HEI.06
        
        IF NOT Scheduled THEN
          FuturMasterInterfaceSetup.TESTFIELD("Sell Act WK Ref Date");
        
        
        //>>interface filters
        //ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        IF FuturMasterInterfaceSetup."Sell Act Week Doc Types Filter" <> '' THEN
          ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act Week Doc Types Filter");
        IF FuturMasterInterfaceSetup."Sell Act Week Location Filter" <> '' THEN
         ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act Week Location Filter");
        IF FuturMasterInterfaceSetup."Sell Act Week Item Cat Filter" <> '' THEN
         ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act Week Item Cat Filter");
        
        //<<interface filters
        */
        //HEI.12<<
        /*
        IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*///HEI.33>>
                    //HEI.12>>
        FuturMasterInterfaceSetup.TESTFIELD("Cust.SellActW Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Week Doc Types Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Week Item Cat Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Wk Prev Weeks"); //HEI.27

        //>>HEI.06
        if FuturMasterInterfaceSetup."Sell Act WK Ref Date" = 0D then
            FuturMasterInterfaceSetup."Sell Act WK Ref Date" := TODAY;
        //<<HEI.06

        if not Scheduled then
            FuturMasterInterfaceSetup.TESTFIELD("Sell Act WK Ref Date");

        //>>HEI.42
        ItemLedgerEntryReturn.COPYFILTERS(ItemLedgerEntry);
        IncludeReturnReceipts := GetSellActWeekReturnReceipts(ItemLedgerEntryReturn, TempReturnActualMth, Scheduled);
        //<<HEI.42

        //>>interface filters
        //ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        if FuturMasterInterfaceSetup."Sell Act Week Doc Types Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act Week Doc Types Filter");
        if FuturMasterInterfaceSetup."Sell Act Week Location Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act Week Location Filter");
        if FuturMasterInterfaceSetup."Sell Act Week Item Cat Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act Week Item Cat Filter");

        //<<interface filters
        //HEI.12<<

        //process the orders
        if ItemLedgerEntry.FINDFIRST then begin
            if Scheduled then
                //HEI.27 >>
                //      GroupSalesActualWeek(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust.SellActW Acc Group Filter", TODAY, 8) //****
                GroupSalesActualWeek(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust.SellActW Acc Group Filter", TODAY, FuturMasterInterfaceSetup."Sell Act Wk Prev Weeks")
            //HEI.27 <<
            else
                //HEI.27 >>
                //      GroupSalesActualWeek(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust.SellActW Acc Group Filter", FuturMasterInterfaceSetup."Sell Act WK Ref Date", 8);
                GroupSalesActualWeek(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust.SellActW Acc Group Filter", FuturMasterInterfaceSetup."Sell Act WK Ref Date", FuturMasterInterfaceSetup."Sell Act Wk Prev Weeks");
            //HEI.27 <<

            TempSalesActualMth.RESET;
            if TempSalesActualMth.FINDSET then begin


                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Sell Act Week Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                //HEI.66>>
                //InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryHeaderOut."Company Code ID" := CompanyCode;
                //HEI.66<<

                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;

                InterfaceEntryHeaderOut.INSERT(true);
                repeat
                    //Add return receipt quantity
                    AddReturnReceiptQtyOnSellActShipments(TempSalesActualMth, TempReturnActualMth, IncludeReturnReceipts);//HEI.42
                    if TempSalesActualMth."Remaining Amount" <> 0 then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        EntryNo += 1;
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        //HEI.66>>
                        //InterfaceEntryLineOut."No." := DELCHR(TempSalesActualMth."Account No.", '<', '0');
                        //InterfaceEntryLineOut."Buy-from Vendor No." := DELCHR(TempSalesActualMth."Bal. Account No.", '<', '0');
                        //InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                        InterfaceEntryLineOut."No." := TempSalesActualMth."Account No.";
                        InterfaceEntryLineOut."Buy-from Vendor No." := TempSalesActualMth."Bal. Account No.";
                        InterfaceEntryLineOut."Legal Entity" := CompanyCode;
                        //HEI.66<<
                        InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                        InterfaceEntryLineOut.Quantity := -TempSalesActualMth."Remaining Amount";
                        InterfaceEntryLineOut.INSERT;
                    end;
                until TempSalesActualMth.NEXT = 0;
                //Create interface Entry Line for return receipts which don't have a match on shipments
                CreateSellInActIntEntryLineOut(InterfaceEntryHeaderOut, TempReturnActualMth, EntryNo);//>>HEI.42
            end;
        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Sell Act Week Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                //HEI.66>>
                //InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryHeaderOut."Company Code ID" := CompanyCode;
                //HEI.66<<
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;
            //>>HEI.42
            if IncludeReturnReceipts and ReturnReceiptExist(TempReturnActualMth) then
                CreateSellInActIntEntryLineOut(InterfaceEntryHeaderOut, TempReturnActualMth, EntryNo)
            else begin
                //<<HEI.42
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                EntryNo := EntryNo + 1;
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := EntryNo;
                InterfaceEntryLineOut."No." := '';
                InterfaceEntryLineOut."E-Mail 2" := '';
                //HEI.66>>
                //InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryLineOut."Legal Entity" := CompanyCode;
                //HEI.66<<
                InterfaceEntryLineOut."Ship-to Address" := '';
                InterfaceEntryLineOut."Ship-to Name" := '';
                InterfaceEntryLineOut.INSERT;
            end;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END;HEI.33>>

    end;

    procedure CreateSellInActualsMonth3YR(var ItemLedgerEntry: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
        Calendar: Record Date;
        NoOfPeriod: Integer;
        IncludeReturnReceipts: Boolean;
        ItemLedgerEntryReturn: Record "Item Ledger Entry";
        TempReturnActualMth: Record "Ledger Entry Matching Buffer" temporary;
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        GetFuturMasterInterfaceSetup3;//HEI.42
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Month 3YR Interface");
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Sell Act Month 3YR Interface");


        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;


        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;
        //HEI.12>>
        /*
        FuturMasterInterfaceSetup.TESTFIELD("Cust.SellActM3 Acc Gr Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH3YR Doc Typ Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Mth 3YR Start Date");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Mth 3YR End  Date");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH3YR Item Ca Filter");
        
        
        //calculate number of months.
        Calendar.RESET;
        Calendar.SETRANGE("Period Type",Calendar."Period Type"::Month);
        Calendar.SETRANGE("Period Start",FuturMasterInterfaceSetup."Sell Act Mth 3YR Start Date", FuturMasterInterfaceSetup."Sell Act Mth 3YR End  Date");
        NoOfPeriod :=  Calendar.COUNT;
        
        
        //>>interface filters
        //ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        IF FuturMasterInterfaceSetup."Sell Act MTH3YR Doc Typ Filter" <> '' THEN
          ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act MTH3YR Doc Typ Filter");
        IF FuturMasterInterfaceSetup."Sell Act MTH3YR Loc Filter" <> '' THEN
         ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act MTH3YR Loc Filter");
        IF FuturMasterInterfaceSetup."Sell Act MTH3YR Item Ca Filter" <> '' THEN
         ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act MTH3YR Item Ca Filter");
        
        //<<interface filters
        */
        //HEI.12<<
        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*///HEI.33>>
                    //HEI.12>>

        FuturMasterInterfaceSetup.TESTFIELD("Cust.SellActM3 Acc Gr Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH3YR Doc Typ Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Mth 3YR Start Date");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Mth 3YR End  Date");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act MTH3YR Item Ca Filter");


        //calculate number of months.
        Calendar.RESET;
        Calendar.SETRANGE("Period Type", Calendar."Period Type"::Month);
        Calendar.SETRANGE("Period Start", FuturMasterInterfaceSetup."Sell Act Mth 3YR Start Date", FuturMasterInterfaceSetup."Sell Act Mth 3YR End  Date");
        NoOfPeriod := Calendar.COUNT;
        //>>HEI.42
        ItemLedgerEntryReturn.COPYFILTERS(ItemLedgerEntry);
        IncludeReturnReceipts := GetSellActMonth3YRReturnReceipts(ItemLedgerEntryReturn, TempReturnActualMth, Scheduled);
        //<<HEI.42

        //>>interface filters
        //ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        if FuturMasterInterfaceSetup."Sell Act MTH3YR Doc Typ Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act MTH3YR Doc Typ Filter");
        if FuturMasterInterfaceSetup."Sell Act MTH3YR Loc Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act MTH3YR Loc Filter");
        if FuturMasterInterfaceSetup."Sell Act MTH3YR Item Ca Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act MTH3YR Item Ca Filter");

        //<<interface filters
        //HEI.12<<
        //process the orders
        if ItemLedgerEntry.FINDFIRST then begin
            GroupSalesActualMonth(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust.SellActM3 Acc Gr Filter", FuturMasterInterfaceSetup."Sell Act Mth 3YR End  Date", NoOfPeriod - 1);
            TempSalesActualMth.RESET;
            if TempSalesActualMth.FINDSET then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Sell Act Month 3YR Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;

                InterfaceEntryHeaderOut.INSERT(true);
                repeat
                    //Add return receipt quantity
                    AddReturnReceiptQtyOnSellActShipments(TempSalesActualMth, TempReturnActualMth, IncludeReturnReceipts);//HEI.42
                    if TempSalesActualMth."Remaining Amount" <> 0 then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        EntryNo += 1;
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut."No." := DELCHR(TempSalesActualMth."Account No.", '<', '0');
                        InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                        InterfaceEntryLineOut."Buy-from Vendor No." := DELCHR(TempSalesActualMth."Bal. Account No.", '<', '0');
                        InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                        InterfaceEntryLineOut.Quantity := -TempSalesActualMth."Remaining Amount";
                        InterfaceEntryLineOut.INSERT;
                    end;
                until TempSalesActualMth.NEXT = 0;
                //Create interface Entry Line for return receipts which don't have a match on shipments
                CreateSellInActIntEntryLineOut(InterfaceEntryHeaderOut, TempReturnActualMth, EntryNo);//>>HEI.42
            end;

        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Sell Act Month 3YR Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;
            //>>HEI.42
            if IncludeReturnReceipts and ReturnReceiptExist(TempReturnActualMth) then
                CreateSellInActIntEntryLineOut(InterfaceEntryHeaderOut, TempReturnActualMth, EntryNo)
            else begin
                //<<HEI.42
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                EntryNo := EntryNo + 1;
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := EntryNo;
                InterfaceEntryLineOut."No." := '';
                InterfaceEntryLineOut."E-Mail 2" := '';
                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryLineOut."Ship-to Address" := '';
                InterfaceEntryLineOut."Ship-to Name" := '';
                InterfaceEntryLineOut.INSERT;
            end;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END;HEI.33>>

    end;

    procedure CreateSellInActualsWeek3YR(var ItemLedgerEntry: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
        Calendar: Record Date;
        NoOfPeriod: Integer;
        IncludeReturnReceipts: Boolean;
        ItemLedgerEntryReturn: Record "Item Ledger Entry";
        TempReturnActualMth: Record "Ledger Entry Matching Buffer" temporary;
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        GetFuturMasterInterfaceSetup3;//HEI.42
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Week 3YR Interface");
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Sell Act Week 3YR Interface");


        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;


        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        FuturMasterInterfaceSetup.TESTFIELD("Cust.SellActW3 Acc Gr Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act WK3YR Doc Typ Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Wk 3YR Start Date");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Wk 3YR End  Date");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act WK3YR Item Cat Filter");
        
        //calculate number of weeks
        Calendar.RESET;
        Calendar.SETRANGE("Period Type",Calendar."Period Type"::Week);
        Calendar.SETRANGE("Period Start",FuturMasterInterfaceSetup."Sell Act Wk 3YR Start Date", FuturMasterInterfaceSetup."Sell Act Wk 3YR End  Date");
        NoOfPeriod :=  Calendar.COUNT;
        
        
        //>>interface filters
        //ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        IF FuturMasterInterfaceSetup."Sell Act WK3YR Doc Typ Filter" <> '' THEN
          ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act WK3YR Doc Typ Filter");
        IF FuturMasterInterfaceSetup."Sell Act WK3YR Loc Filter" <> '' THEN
         ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act WK3YR Loc Filter");
        IF FuturMasterInterfaceSetup."Sell Act WK3YR Item Cat Filter" <> '' THEN
         ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act WK3YR Item Cat Filter");
        
        //<<interface filters
        */
        //HEI.12<<

        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*///HEI.33>>
                    //HEI.12>>
        FuturMasterInterfaceSetup.TESTFIELD("Cust.SellActW3 Acc Gr Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act WK3YR Doc Typ Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Wk 3YR Start Date");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act Wk 3YR End  Date");
        FuturMasterInterfaceSetup.TESTFIELD("Sell Act WK3YR Item Cat Filter");

        //calculate number of weeks
        Calendar.RESET;
        Calendar.SETRANGE("Period Type", Calendar."Period Type"::Week);
        Calendar.SETRANGE("Period Start", FuturMasterInterfaceSetup."Sell Act Wk 3YR Start Date", FuturMasterInterfaceSetup."Sell Act Wk 3YR End  Date");
        NoOfPeriod := Calendar.COUNT;

        //>>HEI.42
        ItemLedgerEntryReturn.COPYFILTERS(ItemLedgerEntry);
        IncludeReturnReceipts := GetSellActWeek3YRReturnReceipts(ItemLedgerEntryReturn, TempReturnActualMth, Scheduled);
        //<<HEI.42
        //>>interface filters
        //ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        if FuturMasterInterfaceSetup."Sell Act WK3YR Doc Typ Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup."Sell Act WK3YR Doc Typ Filter");
        if FuturMasterInterfaceSetup."Sell Act WK3YR Loc Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."Sell Act WK3YR Loc Filter");
        if FuturMasterInterfaceSetup."Sell Act WK3YR Item Cat Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Sell Act WK3YR Item Cat Filter");

        //<<interface filters
        //HEI.12<<
        //process the orders
        if ItemLedgerEntry.FINDFIRST then begin
            GroupSalesActualWeek(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup."Cust.SellActW3 Acc Gr Filter", FuturMasterInterfaceSetup."Sell Act Wk 3YR End  Date", NoOfPeriod - 1);


            TempSalesActualMth.RESET;
            if TempSalesActualMth.FINDSET then begin


                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Sell Act Week 3YR Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;

                InterfaceEntryHeaderOut.INSERT(true);
                repeat
                    //Add return receipt quantity
                    AddReturnReceiptQtyOnSellActShipments(TempSalesActualMth, TempReturnActualMth, IncludeReturnReceipts);//HEI.42
                    if TempSalesActualMth."Remaining Amount" <> 0 then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        EntryNo += 1;
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut."No." := DELCHR(TempSalesActualMth."Account No.", '<', '0');
                        InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                        InterfaceEntryLineOut."Buy-from Vendor No." := DELCHR(TempSalesActualMth."Bal. Account No.", '<', '0');
                        InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                        InterfaceEntryLineOut.Quantity := -TempSalesActualMth."Remaining Amount";
                        InterfaceEntryLineOut.INSERT;
                    end;
                until TempSalesActualMth.NEXT = 0;
                //Create interface Entry Line for return receipts which don't have a match on shipments
                CreateSellInActIntEntryLineOut(InterfaceEntryHeaderOut, TempReturnActualMth, EntryNo);//>>HEI.42
            end;

        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Sell Act Week 3YR Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;
            //>>HEI.42
            if IncludeReturnReceipts and ReturnReceiptExist(TempReturnActualMth) then
                CreateSellInActIntEntryLineOut(InterfaceEntryHeaderOut, TempReturnActualMth, EntryNo)
            else begin
                //<<HEI.42
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                EntryNo := EntryNo + 1;
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := EntryNo;
                InterfaceEntryLineOut."No." := '';
                InterfaceEntryLineOut."E-Mail 2" := '';
                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryLineOut."Ship-to Address" := '';
                InterfaceEntryLineOut."Ship-to Name" := '';
                InterfaceEntryLineOut.INSERT;
            end;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END;HEI.33>>

    end;

    procedure CreateSupplyPlanOpenOrders(var SalesLine: Record "Sales Line"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
        Location: Record Location;
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Supply Plann Open Order Interf");
        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        FuturMasterInterfaceSetup.TESTFIELD("Cust.SOO Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Supply Plann Open Order Interf");
        FuturMasterInterfaceSetup.TESTFIELD("Supply Pl OO Item Categ Filter");
        
        //>>interface filters
        //SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code","Delayed Sequence No.","Shipment Date");
        SalesLine.SETFILTER("Document Type", FuturMasterInterfaceSetup."Supply Pl OO  Doc Types Filter");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETFILTER("HL Cubage",'<>0');
        
        Item.RESET;
        Item.SETCURRENTKEY("Item Category Code","Product Group Code");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Supply Pl OO Item Categ Filter");
        
        Customer.RESET;
        Customer.SETCURRENTKEY("Account Group");
        Customer.SETFILTER("Account Group", FuturMasterInterfaceSetup."Cust.SOO Acc Group Filter");
        //<<interface filters
        
        GroupSalesLine(SalesLine, TempGroupSalesLine);
        */
        //HEI.12<<

        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*///HEI.33>>
                    //HEI.12>>
        FuturMasterInterfaceSetup.TESTFIELD("Cust.SOO Acc Group Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Supply Plann Open Order Interf");
        FuturMasterInterfaceSetup.TESTFIELD("Supply Pl OO Item Categ Filter");

        //>>interface filters
        //SalesLine.RESET;
        // SalesLine.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Delayed Sequence No.", "Shipment Date"); //BC Upgrade GUNREM01 -dependency with DIT Field
        SalesLine.SETFILTER("Document Type", FuturMasterInterfaceSetup."Supply Pl OO  Doc Types Filter");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETFILTER("Location Code", '<>%1', '');//HEI.52
        // SalesLine.SETFILTER("HL Cubage", '<>0'); //BC Upgrade GUNREM01 -DIT Field
        // SalesLine.SETFILTER("Volume 2 101FDW", '<>0'); //BC UPGRADE KUMARR78 25-05-2026--
        SalesLine.SETFILTER("Volume Out. 107FDW", '<>0'); //BC UPGRADE KUMARR78 25-05-2026



        Item.RESET;
        Item.SETCURRENTKEY("Item Category Code", "Product Group Code FND");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Supply Pl OO Item Categ Filter");

        Customer.RESET;
        Customer.SETCURRENTKEY("Account Group FND");
        Customer.SETFILTER("Account Group FND", FuturMasterInterfaceSetup."Cust.SOO Acc Group Filter");
        //<<interface filters

        //HEI.47>>
        //GroupSalesLine(SalesLine, TempGroupSalesLine);
        GroupSalesLineOnLocation(SalesLine, TempGroupSalesLine);
        //HEI.47<<
        //HEI.12<<

        //process the orders
        TempGroupSalesLine.RESET;
        TempGroupSalesLine.SETCURRENTKEY("Bal. Account No.", "Account No.", "Posting Date");
        if TempGroupSalesLine.FINDSET then begin


            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Supply Plann Open Order Interf";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);


            repeat
                Item.SETRANGE("No.", TempGroupSalesLine."Bal. Account No.");
                if Item.FINDFIRST then begin
                    //HEI.47>>
                    //Customer.SETRANGE("No.", TempGroupSalesLine."Account No.");
                    //IF Customer.FINDFIRST THEN BEGIN
                    Location.SETRANGE(Code, TempGroupSalesLine."Account No.");
                    if Location.FINDFIRST then begin
                        //HEI.47<<
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        EntryNo += 1;
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut."No." := DELCHR(TempGroupSalesLine."Bal. Account No.", '<', '0');
                        InterfaceEntryLineOut."Buy-from Vendor No." := DELCHR(TempGroupSalesLine."Account No.", '<', '0');
                        InterfaceEntryLineOut."Action Code" := FORMAT(DATE2DMY(TempGroupSalesLine."Posting Date", 3));
                        if DATE2DMY(TempGroupSalesLine."Posting Date", 2) < 10 then
                            InterfaceEntryLineOut."External Contract No." := '0' + FORMAT(DATE2DMY(TempGroupSalesLine."Posting Date", 2))
                        else
                            InterfaceEntryLineOut."External Contract No." := FORMAT(DATE2DMY(TempGroupSalesLine."Posting Date", 2));
                        if DATE2DMY(TempGroupSalesLine."Posting Date", 1) < 10 then
                            InterfaceEntryLineOut."External Contract Line No." := '0' + FORMAT(DATE2DMY(TempGroupSalesLine."Posting Date", 1))
                        else
                            InterfaceEntryLineOut."External Contract Line No." := FORMAT(DATE2DMY(TempGroupSalesLine."Posting Date", 1));
                        InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                        InterfaceEntryLineOut.Quantity := TempGroupSalesLine."Remaining Amount";
                        InterfaceEntryLineOut.INSERT;
                    end;
                end;
            until TempGroupSalesLine.NEXT = 0
            //

        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Supply Plann Open Order Interf";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;
            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo += 1;
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."Sell-to Customer No." := '';
            InterfaceEntryLineOut."Action Code" := '';
            InterfaceEntryLineOut."External Contract No." := '';
            InterfaceEntryLineOut."External Contract Line No." := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut.Quantity := 0;
            InterfaceEntryLineOut.INSERT;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END;HEI.33>>

    end;

    procedure CreateStockOnHand(var ItemLedgerEntry: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        FuturMasterInterfaceSetup.TESTFIELD("Stock on Hand Interface");
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Stock on Hand Interface");


        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;


        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        FuturMasterInterfaceSetup.TESTFIELD("StockOnHand CMG Filter");
        //FuturMasterInterfaceSetup.TESTFIELD("StockOnHand Current Week");
        //FuturMasterInterfaceSetup.TESTFIELD("StockOnHand Location Filter");
        
        //>>interface filters
        //ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
        IF FuturMasterInterfaceSetup."StockOnHand Location Filter" <> '' THEN
         ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."StockOnHand Location Filter");
        
        //<<interface filters
        */
        //HEI.12<<

        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*///HEI.33>>
                    //HEI.12>>
        FuturMasterInterfaceSetup.TESTFIELD("StockOnHand CMG Filter");

        //HEI.31>>
        /*
          //>>interface filters
          ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Source Type","Source No.","Posting Date","Document Type","Document No.","Unit of Measure Code");
          IF FuturMasterInterfaceSetup."StockOnHand Location Filter" <> '' THEN
           ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."StockOnHand Location Filter");
        
          //<<interface filters
          //HEI.12<<
        */
        //HEI.31<<


        //process the orders
        //IF ItemLedgerEntry.FINDFIRST THEN BEGIN //HEI.31
        GroupStockOnHandWeek(ItemLedgerEntry, TempSalesActualMth, '', TODAY, 0); //****
        TempSalesActualMth.RESET;
        if TempSalesActualMth.FINDSET then begin


            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Stock on Hand Interface";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);
            repeat
                if TempSalesActualMth."Remaining Amount" <> 0 then begin
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    EntryNo += 1;
                    InterfaceEntryLineOut."Entry No." := EntryNo;
                    InterfaceEntryLineOut."No." := DELCHR(TempSalesActualMth."Account No.", '<', '0');
                    InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                    InterfaceEntryLineOut."Buy-from Vendor No." := TempSalesActualMth."Bal. Account No.";
                    InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                    InterfaceEntryLineOut.Quantity := TempSalesActualMth."Remaining Amount";
                    InterfaceEntryLineOut."Qty. per Unit of Measure" := TempSalesActualMth."Remaining Amt. Incl. Discount";
                    InterfaceEntryLineOut.INSERT;
                end;
            until TempSalesActualMth.NEXT = 0;
        end;

        //END; //HEI.31

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Stock on Hand Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."E-Mail 2" := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Ship-to Address" := '';
            InterfaceEntryLineOut."Ship-to Name" := '';
            InterfaceEntryLineOut.INSERT;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END;HEI.33>>

    end;

    local procedure GroupStockOnHandWeek(var locILE: Record "Item Ledger Entry"; var locSalesActualMth: Record "Ledger Entry Matching Buffer" temporary; CustMasterAccGroup: Code[20]; RefDate: Date; NoOfPeriods: Integer);
    var
        EntryNo: Integer;
        Customer: Record Customer;
        i: Integer;
        YearWeek: Text[6];
        Item: Record Item;
        locWarehouseEntry: Record "Warehouse Entry";
        ILEDateFilter: Text[30];
        locBin: Record Bin;
        LastDay: Date;
        HLRate: Decimal;
        LocalItem: Record Item;
        //BC Upgrade GUNREM01 >>
        ItemList: List of [Code[20]];
        ItemNo: Code[20];
        ItemFilterString: Text;
        // DotNetItemList: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Collections.Generic.List`1";
        // DotNetString: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
        // DotNetStringFilter: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
        // DotNetElement: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
        //BC Upgrade GUNREM01 <<
        TempSalesActualMthLocal: Record "Ledger Entry Matching Buffer" temporary;
        InventorySetup: Record "Inventory Setup";
        AvailableSOHQty: Decimal;
        BlockedSOHQty: Decimal;
    begin
        //HEI.28>>

        CLEAR(EntryNo);
        HLRate := 1;
        InventorySetup.GET();

        if FuturMasterInterfaceSetup."StockOnHand Current Week" then
            i := 0
        else
            i := 1;

        CLEAR(YearWeek);
        YearWeek := SetPostingDateFilter(locILE, PeriodType::Week, i, Direction::Down, RefDate);
        LastDay := locILE.GETRANGEMAX("Posting Date");
        //BC Upgrade GUNREM01 replaced >>
        //  DotNetItemList := DotNetItemList.List(); 
        if ItemList.Count() > 0 then
            ItemList.RemoveRange(1, ItemList.Count());
        //BC Upgrade GUNREM01 replaced <<
        LocalItem.RESET();
        if LocalItem.FINDSET(false) then
            repeat
                if ValidateItemNo(LocalItem."No.") then begin
                    //BC Upgrade GUNREM01 replaced >>
                    // DotNetItemList.Add(LocalItem."No.");
                    ItemList.Add(LocalItem."No.");
                    //BC Upgrade GUNREM01 replaced <<
                end;
            until LocalItem.NEXT = 0;

        //BC Upgrade GUNREM01 >>
        // foreach DotNetElement in DotNetItemList do begin
        //     DotNetString := FORMAT(DotNetString) + FORMAT(DotNetElement) + '|';
        // end;

        // if (DotNetString.Length > 1) then begin
        //     DotNetString := FORMAT(DotNetString.Remove(DotNetString.Length - 1));
        // end;
        ItemFilterString := '';
        foreach ItemNo in ItemList do
            ItemFilterString += ItemNo + '|';

        if StrLen(ItemFilterString) > 0 then
            ItemFilterString := CopyStr(ItemFilterString, 1, StrLen(ItemFilterString) - 1);
        //BC Upgrade GUNREM01 <<
        //HEI.31>>
        /*
        CLEAR(TempSalesActualMthLocal);
        QStockonHandILE.SETFILTER(QStockonHandILE.PostingDate,'..%1', LastDay);
        IF FuturMasterInterfaceSetup."StockOnHand Location Filter" <> '' THEN
          QStockonHandILE.SETFILTER(QStockonHandILE.LocationCode,FuturMasterInterfaceSetup."StockOnHand Location Filter");
        QStockonHandILE.SETFILTER(QStockonHandILE.Quality_Status,'%1|%2',QStockonHandILE.Quality_Status::Unrestricted,QStockonHandILE.Quality_Status::"Quality Hold");
        QStockonHandILE.OPEN;
          WHILE QStockonHandILE.READ DO BEGIN
              IF DotNetItemList.Contains(QStockonHandILE.Item_No) THEN BEGIN
                TempSalesActualMthLocal.INIT;
                EntryNo += 1;
                TempSalesActualMthLocal."Entry No." := EntryNo;
                TempSalesActualMthLocal."Account No." := QStockonHandILE.Item_No;
                TempSalesActualMthLocal."Bal. Account No." := QStockonHandILE.Location_Code;
                IF QStockonHandILE.Item_Category_Code IN ['02', '03', '04', '05', '09'] THEN //for raw and packeging materials
                  TempSalesActualMthLocal."Remaining Amount" := QStockonHandILE.Sum_Quantity
                ELSE
                  TempSalesActualMthLocal."Remaining Amount" := ConvertQtyToHL_FM(QStockonHandILE.Item_No,QStockonHandILE.Sum_Quantity, '', QStockonHandILE.Base_Unit_of_Measure, 0,InventorySetup);
                TempSalesActualMthLocal."Document No." := YearWeek;
                TempSalesActualMthLocal.INSERT;
            END;
          END;
        QStockonHandILE.CLOSE;
        *///HEI.31<<

        //HEI.31 <<
        CLEAR(TempSalesActualMthLocal);
        CLEAR(locSalesActualMth);
        CLEAR(EntryNo);
        CLEAR(AvailableSOHQty);
        CLEAR(BlockedSOHQty);
        //QStockonHandWE.SETFILTER(QStockonHandWE.Item_No, DotNetString);//Due to limitation of 1024 characters we placed List checking inside the While Loop
        QStockonHandWE.SETFILTER(QStockonHandWE.Registering_Date, '..%1', LastDay);

        if FuturMasterInterfaceSetup."StockOnHand Location Filter" <> '' then
            QStockonHandWE.SETFILTER(QStockonHandWE.Location_Code, FuturMasterInterfaceSetup."StockOnHand Location Filter");

        QStockonHandWE.OPEN;
        while QStockonHandWE.READ do begin
            //BC Upgrade GUNREM01 replaced >>
            //  if DotNetItemList.Contains(QStockonHandWE.Item_No) then begin
            if ItemList.Contains(QStockonHandWE.Item_No) then begin
                //BC Upgrade GUNREM01 replaced <<
                //Step1
                TempSalesActualMthLocal.INIT;
                EntryNo += 1;
                TempSalesActualMthLocal."Entry No." := EntryNo;
                TempSalesActualMthLocal."Account No." := QStockonHandWE.Item_No;
                TempSalesActualMthLocal."Bal. Account No." := QStockonHandWE.Location_Code;
                if QStockonHandWE.Item_Category_Code in ['02', '03', '04', '05', '09'] then //for raw and packging materials
                    TempSalesActualMthLocal."Remaining Amount" := QStockonHandWE.Sum_Qty_Base
                else
                    TempSalesActualMthLocal."Remaining Amount" := ConvertQtyToHL_FM(QStockonHandWE.Item_No, QStockonHandWE.Sum_Qty_Base, '', QStockonHandWE.Base_Unit_of_Measure, 0, InventorySetup);
                TempSalesActualMthLocal."Document No." := YearWeek;
                TempSalesActualMthLocal.INSERT;

                //Step2
                if (QStockonHandWE.Unavailable_Stock_Quality and not QStockonHandWE.Unavailable_Stock_Bin) then begin
                    TempSalesActualMthLocal.INIT;
                    EntryNo += 1;
                    TempSalesActualMthLocal."Entry No." := EntryNo;
                    TempSalesActualMthLocal."Account No." := QStockonHandWE.Item_No;
                    TempSalesActualMthLocal."Bal. Account No." := QStockonHandWE.Location_Code;
                    if QStockonHandWE.Item_Category_Code in ['02', '03', '04', '05', '09'] then //for raw and packging materials
                        TempSalesActualMthLocal."Remaining Amt. Incl. Discount" := QStockonHandWE.Sum_Qty_Base
                    else
                        TempSalesActualMthLocal."Remaining Amt. Incl. Discount" := ConvertQtyToHL_FM(QStockonHandWE.Item_No, QStockonHandWE.Sum_Qty_Base, '', QStockonHandWE.Base_Unit_of_Measure, 0, InventorySetup);
                    TempSalesActualMthLocal."Document No." := YearWeek;
                    TempSalesActualMthLocal.INSERT;
                end;

                //Step3
                if QStockonHandWE.Unavailable_Stock_Bin then begin
                    TempSalesActualMthLocal.INIT;
                    EntryNo += 1;
                    TempSalesActualMthLocal."Entry No." := EntryNo;
                    TempSalesActualMthLocal."Account No." := QStockonHandWE.Item_No;
                    TempSalesActualMthLocal."Bal. Account No." := QStockonHandWE.Location_Code;
                    if QStockonHandWE.Item_Category_Code in ['02', '03', '04', '05', '09'] then //for raw and packging materials
                        TempSalesActualMthLocal."Remaining Amt. Incl. Discount" := QStockonHandWE.Sum_Qty_Base
                    else
                        TempSalesActualMthLocal."Remaining Amt. Incl. Discount" := ConvertQtyToHL_FM(QStockonHandWE.Item_No, QStockonHandWE.Sum_Qty_Base, '', QStockonHandWE.Base_Unit_of_Measure, 0, InventorySetup);
                    TempSalesActualMthLocal."Document No." := YearWeek;
                    TempSalesActualMthLocal.INSERT;
                end;
            end;
        end;
        QStockonHandWE.CLOSE;

        if TempSalesActualMthLocal.FINDSET() then
            repeat
                locSalesActualMth.SETRANGE("Account No.", TempSalesActualMthLocal."Account No.");
                locSalesActualMth.SETRANGE("Bal. Account No.", TempSalesActualMthLocal."Bal. Account No.");
                locSalesActualMth.SETRANGE("Document No.", YearWeek);
                if locSalesActualMth.FINDFIRST then begin
                    /*
                    locSalesActualMth."Remaining Amount"+=TempSalesActualMthLocal."Remaining Amount";
                    locSalesActualMth."Remaining Amt. Incl. Discount"+=TempSalesActualMthLocal."Remaining Amt. Incl. Discount";
                    */
                    AvailableSOHQty += TempSalesActualMthLocal."Remaining Amount";
                    BlockedSOHQty += TempSalesActualMthLocal."Remaining Amt. Incl. Discount";
                    locSalesActualMth."Remaining Amount" := AvailableSOHQty - BlockedSOHQty;//Available SOH = step1-[step2+step3]
                    locSalesActualMth."Remaining Amt. Incl. Discount" := BlockedSOHQty; //Blocked SOH = step2+step3
                    locSalesActualMth.MODIFY();
                end else begin
                    locSalesActualMth.INIT;
                    EntryNo += 1;
                    locSalesActualMth."Entry No." := EntryNo;
                    locSalesActualMth."Account No." := TempSalesActualMthLocal."Account No.";
                    locSalesActualMth."Bal. Account No." := TempSalesActualMthLocal."Bal. Account No.";
                    locSalesActualMth."Document No." := YearWeek;
                    /*
                    locSalesActualMth."Remaining Amount":=TempSalesActualMthLocal."Remaining Amount";
                    locSalesActualMth."Remaining Amt. Incl. Discount":=TempSalesActualMthLocal."Remaining Amt. Incl. Discount";
                    */
                    AvailableSOHQty := TempSalesActualMthLocal."Remaining Amount";
                    BlockedSOHQty := TempSalesActualMthLocal."Remaining Amt. Incl. Discount";
                    locSalesActualMth."Remaining Amount" := AvailableSOHQty - BlockedSOHQty;//Available SOH = step1-[step2+step3]
                    locSalesActualMth."Remaining Amt. Incl. Discount" := BlockedSOHQty; //Blocked SOH = step2+step3
                    locSalesActualMth.INSERT();
                end;
            until TempSalesActualMthLocal.NEXT = 0;
        /*
        //HEI.31>>
        //Sum up the Available Stock -On hand
        IF locSalesActualMth.FINDSET() THEN REPEAT
            locSalesActualMth."Remaining Amount":=locSalesActualMth."Remaining Amount"-locSalesActualMth."Remaining Amt. Incl. Discount";
            locSalesActualMth.MODIFY();
        UNTIL locSalesActualMth.NEXT=0;
        //HEI.31<<
        */
        CLEAR(TempSalesActualMthLocal);
        //BC Upgrade GUNREM01 >>
        // CLEAR(DotNetItemList);
        // CLEAR(DotNetString);
        // CLEAR(DotNetStringFilter);
        // CLEAR(DotNetElement);
        Clear(ItemList);
        Clear(ItemFilterString);
        //BC Upgrade GUNREM01 <<
        CLEAR(QStockonHandWE);
        //HEI.31 <<

        //HEI.28<<

        /*//HEI.03 //commented old code HEI.28>>
        locSalesActualMth.DELETEALL;
        CLEAR(EntryNo);
        HLRate := 1;
        
        IF FuturMasterInterfaceSetup."StockOnHand Current Week" THEN
          i := 0
        ELSE
          i := 1;
        
        //current week
        
        CLEAR(YearWeek);
        YearWeek := SetPostingDateFilter(locILE, PeriodType::Week, i, Direction::Down, RefDate);
        LastDay := locILE.GETRANGEMAX("Posting Date");
        locILE.SETFILTER("Posting Date",'..%1', LastDay);
        
        IF locILE.FINDSET THEN
          REPEAT
            IF ValidateItemNo(locILE."Item No.") THEN BEGIN
            IF (locILE."Quality Status" = locILE."Quality Status"::Unrestricted) OR (locILE."Quality Status" = locILE."Quality Status"::"Quality Hold") THEN BEGIN
              locSalesActualMth.SETRANGE("Account No.", locILE."Item No.");
              locSalesActualMth.SETRANGE("Bal. Account No.", locILE."Location Code");
              locSalesActualMth.SETRANGE("Document No.", YearWeek);
              IF locSalesActualMth.FINDFIRST THEN BEGIN
                //HEI.13 locSalesActualMth."Remaining Amount" += ConvertQtyToHL(locILE."Item No.", locILE.Quantity, '', locILE."Unit of Measure Code", locILE."Quantity in HL");
                //HEI.13>>
        
                Item.GET(locILE."Item No.");
                //HEI.17>>
                IF Item."Item Category Code" IN ['02', '03', '04', '05', '09'] THEN //for raw and packging materials
                  locSalesActualMth."Remaining Amount" += locILE.Quantity
                ELSE //HEI.17<<
                  locSalesActualMth."Remaining Amount" += ConvertQtyToHL(locILE."Item No.", locILE.Quantity, '', Item."Base Unit of Measure", 0);
                //HEI.13<<
                locSalesActualMth.MODIFY;
              END ELSE BEGIN
                locSalesActualMth.INIT;
                EntryNo += 1;
                locSalesActualMth."Entry No." := EntryNo;
                locSalesActualMth."Account No." := locILE."Item No.";
                locSalesActualMth."Bal. Account No." := locILE."Location Code";
                //HEI.13 locSalesActualMth."Remaining Amount" := ConvertQtyToHL(locILE."Item No.", locILE.Quantity, '', locILE."Unit of Measure Code", locILE."Quantity in HL");
                //HEI.13>>
                Item.GET(locILE."Item No.");
                //HEI.17>>
                IF Item."Item Category Code" IN ['02', '03', '04', '05', '09'] THEN //for raw and packeging materials
                  locSalesActualMth."Remaining Amount" := locILE.Quantity
                ELSE  //HEI.17<<
                  locSalesActualMth."Remaining Amount" := ConvertQtyToHL(locILE."Item No.", locILE.Quantity, '', Item."Base Unit of Measure", 0);
                //HEI.13<<
        
                locSalesActualMth."Document No." := YearWeek;
                locSalesActualMth.INSERT;
              END;
              END;
              END;
            UNTIL locILE.NEXT = 0;
        
        
        
        locWarehouseEntry.SETCURRENTKEY("Item No.","Bin Code","Location Code","Variant Code","Registering Date");
        locWarehouseEntry.SETFILTER("Item No.", locILE.GETFILTER("Item No."));
        locWarehouseEntry.SETFILTER("Registering Date", locILE.GETFILTER("Posting Date"));
        IF FuturMasterInterfaceSetup."StockOnHand Location Filter" <> '' THEN
         locWarehouseEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup."StockOnHand Location Filter");
        
        IF locWarehouseEntry.FINDSET THEN
          REPEAT
            IF ValidateItemNo(locWarehouseEntry."Item No.") THEN BEGIN
            //column 4 ptr warehouse entry
            IF locWarehouseEntry."Unavailable Stock (Bin)"  OR locWarehouseEntry."Unavailable Stock (Quality)"  THEN BEGIN
              locSalesActualMth.SETRANGE("Account No.", locWarehouseEntry."Item No.");
              locSalesActualMth.SETRANGE("Bal. Account No.", locWarehouseEntry."Location Code");
              locSalesActualMth.SETRANGE("Document No.", YearWeek);
              IF locSalesActualMth.FINDFIRST THEN BEGIN
                //HEI.17 comment line locSalesActualMth."Remaining Amount" += ConvertQtyToHL(locWarehouseEntry."Item No.", locWarehouseEntry.Quantity, '', locWarehouseEntry."Unit of Measure Code", 0);
                //HEI.17>>
                IF Item.GET(locWarehouseEntry."Item No.") THEN;
                IF Item."Item Category Code" IN ['02', '03', '04', '05', '09'] THEN //for raw and packging materials
                  locSalesActualMth."Remaining Amount" += locWarehouseEntry."Qty. (Base)"
                ELSE
                  locSalesActualMth."Remaining Amount" += ConvertQtyToHL(Item."No.", locWarehouseEntry."Qty. (Base)", '', Item."Base Unit of Measure", 0);
                //HEI.17<<
        
                locSalesActualMth.MODIFY;
              END ELSE BEGIN
                locSalesActualMth.INIT;
                EntryNo += 1;
                locSalesActualMth."Entry No." := EntryNo;
                locSalesActualMth."Account No." := locWarehouseEntry."Item No.";
                locSalesActualMth."Bal. Account No." := locWarehouseEntry."Location Code";
                //HEI.17 comment line locSalesActualMth."Remaining Amount" := ConvertQtyToHL(locWarehouseEntry."Item No.", locWarehouseEntry.Quantity, '', locWarehouseEntry."Unit of Measure Code", 0);
                //HEI.17>>
                IF Item.GET(locWarehouseEntry."Item No.") THEN;
                IF Item."Item Category Code" IN ['02', '03', '04', '05', '09'] THEN //for raw and packging materials
                  locSalesActualMth."Remaining Amount" := locWarehouseEntry."Qty. (Base)"
                ELSE
                  locSalesActualMth."Remaining Amount" := ConvertQtyToHL(Item."No.", locWarehouseEntry."Qty. (Base)", '', Item."Base Unit of Measure", 0);
                //HEI.17<<
                locSalesActualMth."Document No." := YearWeek;
                locSalesActualMth.INSERT;
              END;
            END;
            //column 5
            IF locBin.GET(locWarehouseEntry."Location Code", locWarehouseEntry."Bin Code") THEN BEGIN
              IF (locBin."Block Movement" <> locBin."Block Movement"::" ") OR locBin."Unavailable Stock" THEN BEGIN
                locSalesActualMth.SETRANGE("Account No.", locWarehouseEntry."Item No.");
                locSalesActualMth.SETRANGE("Bal. Account No.", locWarehouseEntry."Location Code");
                locSalesActualMth.SETRANGE("Document No.", YearWeek);
                IF locSalesActualMth.FINDFIRST THEN BEGIN
                //HEI.17 comment line locSalesActualMth."Remaining Amt. Incl. Discount" += ConvertQtyToHL(locWarehouseEntry."Item No.", locWarehouseEntry.Quantity, '', locWarehouseEntry."Unit of Measure Code", 0);
                //HEI.17>>
                IF Item.GET(locWarehouseEntry."Item No.") THEN;
                IF Item."Item Category Code" IN ['02', '03', '04', '05', '09'] THEN //for raw and packging materials
                  locSalesActualMth."Remaining Amt. Incl. Discount" += locWarehouseEntry."Qty. (Base)"
                ELSE
                  locSalesActualMth."Remaining Amt. Incl. Discount" += ConvertQtyToHL(Item."No.", locWarehouseEntry."Qty. (Base)", '', Item."Base Unit of Measure", 0);
                //HEI.17<<
                  locSalesActualMth.MODIFY;
                END ELSE BEGIN
                  locSalesActualMth.INIT;
                  EntryNo += 1;
                  locSalesActualMth."Entry No." := EntryNo;
                  locSalesActualMth."Account No." := locWarehouseEntry."Item No.";
                  locSalesActualMth."Bal. Account No." := locWarehouseEntry."Location Code";
                  //HEI.17 comment line locSalesActualMth."Remaining Amt. Incl. Discount" := ConvertQtyToHL(locWarehouseEntry."Item No.", locWarehouseEntry.Quantity, '', locWarehouseEntry."Unit of Measure Code", 0);
                  //HEI.17>>
                  IF Item.GET(locWarehouseEntry."Item No.") THEN;
                  IF Item."Item Category Code" IN ['02', '03', '04', '05', '09'] THEN //for raw and packging materials
                    locSalesActualMth."Remaining Amt. Incl. Discount" := locWarehouseEntry."Qty. (Base)"
                  ELSE
                    locSalesActualMth."Remaining Amt. Incl. Discount" := ConvertQtyToHL(Item."No.", locWarehouseEntry."Qty. (Base)", '', Item."Base Unit of Measure", 0);
                  //HEI.17<<
        
                  locSalesActualMth."Document No." := YearWeek;
                  locSalesActualMth.INSERT;
                END;
                END;
              END;
              END;
            UNTIL locWarehouseEntry.NEXT = 0;
        *///commented old code HEI.28<<

    end;

    local procedure ValidateItemNo(ItemNo: Code[20]): Boolean;
    var
        locItem: Record Item;
        locItemAttribValueMapp: Record "Item Attribute Value Mapping";
        locItemAttributeValue: Record "Item Attribute Value";
        FirstTest: Boolean;
    begin
        //HEI.03
        locItem.SETRANGE("No.", ItemNo);
        if FuturMasterInterfaceSetup."StockOnHand CMG Filter" <> '' then begin
            locItem.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."StockOnHand CMG Filter");
            if locItem.FINDFIRST then
                exit(true);
        end;

        FirstTest := false;

        if FuturMasterInterfaceSetup."StockOnHand Item Categ Filter1" <> '' then begin
            locItem.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."StockOnHand Item Categ Filter1");
            if locItem.FINDFIRST then begin
                locItemAttribValueMapp.RESET;
                locItemAttribValueMapp.SETRANGE("Table ID", 27);
                locItemAttribValueMapp.SETRANGE("No.", ItemNo);
                locItemAttribValueMapp.SETRANGE("Item Attribute ID", FuturMasterInterfaceSetup."StockOnHand Item Attr Filter1");
                if locItemAttribValueMapp.FINDFIRST then
                    FirstTest := true;
                locItemAttributeValue.RESET;
                //HEI.04 locItemAttributeValue.SETRANGE(ID, FuturMasterInterfaceSetup."StockOnHand Item Attr Filter1");
                //>>HEI.04
                locItemAttributeValue.SETRANGE("Attribute ID", FuturMasterInterfaceSetup."StockOnHand Item Attr Filter1");
                locItemAttributeValue.SETRANGE(ID, locItemAttribValueMapp."Item Attribute Value ID");
                //<<HEI.04
                locItemAttributeValue.SETFILTER(Value, FuturMasterInterfaceSetup."StockOnHand ItemAttrValFilter1");
                if locItemAttributeValue.FINDFIRST and FirstTest then
                    exit(true);
            end;

        end;

        FirstTest := false;

        if FuturMasterInterfaceSetup."StockOnHand Item Categ Filter2" <> '' then begin
            locItem.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."StockOnHand Item Categ Filter2");
            if locItem.FINDFIRST then begin
                locItemAttribValueMapp.RESET;
                locItemAttribValueMapp.SETRANGE("Table ID", 27);
                locItemAttribValueMapp.SETRANGE("No.", ItemNo);
                locItemAttribValueMapp.SETRANGE("Item Attribute ID", FuturMasterInterfaceSetup."StockOnHand Item Attr Filter2");
                if locItemAttribValueMapp.FINDFIRST then
                    FirstTest := true;
                locItemAttributeValue.RESET;
                //HEI.04 locItemAttributeValue.SETRANGE(ID, FuturMasterInterfaceSetup."StockOnHand Item Attr Filter2");
                //>>HEI.04
                locItemAttributeValue.SETRANGE("Attribute ID", FuturMasterInterfaceSetup."StockOnHand Item Attr Filter2");
                locItemAttributeValue.SETRANGE(ID, locItemAttribValueMapp."Item Attribute Value ID");
                //<<HEI.04
                locItemAttributeValue.SETFILTER(Value, FuturMasterInterfaceSetup."StockOnHand ItemAttrValFilter2");
                if locItemAttributeValue.FINDFIRST and FirstTest then
                    exit(true);
            end;
        end;

        if FuturMasterInterfaceSetup."StockOnHand Item Categ Filter3" <> '' then begin
            locItem.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."StockOnHand Item Categ Filter3");
            if locItem.FINDFIRST then begin
                locItemAttribValueMapp.RESET;
                locItemAttribValueMapp.SETRANGE("Table ID", 27);
                locItemAttribValueMapp.SETRANGE("No.", ItemNo);
                locItemAttribValueMapp.SETRANGE("Item Attribute ID", FuturMasterInterfaceSetup."StockOnHand Item Attr Filter3");
                if locItemAttribValueMapp.FINDFIRST then
                    FirstTest := true;
                locItemAttributeValue.RESET;
                //HEI.04 locItemAttributeValue.SETRANGE(ID, FuturMasterInterfaceSetup."StockOnHand Item Attr Filter3");
                //>>HEI.04
                locItemAttributeValue.SETRANGE("Attribute ID", FuturMasterInterfaceSetup."StockOnHand Item Attr Filter3");
                locItemAttributeValue.SETRANGE(ID, locItemAttribValueMapp."Item Attribute Value ID");
                //<<HEI.04
                locItemAttributeValue.SETFILTER(Value, FuturMasterInterfaceSetup."StockOnHand ItemAttrValFilter3");
                if locItemAttributeValue.FINDFIRST and FirstTest then
                    exit(true);
            end;

        end;
        if (FuturMasterInterfaceSetup."StockOnHand CMG Filter" <> '') or (FuturMasterInterfaceSetup."StockOnHand Item Categ Filter1" <> '') or
           (FuturMasterInterfaceSetup."StockOnHand Item Categ Filter2" <> '') or (FuturMasterInterfaceSetup."StockOnHand Item Categ Filter3" <> '') then
            exit(false)
        else
            exit(true);
    end;

    procedure CreateComponentDataProducts(var Item: Record Item; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Customer: Record Customer;
        ItemAttribValueMapping: Record "Item Attribute Value Mapping";
        ItemAttribValue: Record "Item Attribute Value";
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Component Product Interface");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        FuturMasterInterfaceSetup.TESTFIELD("Comp Product Category Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Component Product Interface");
        
        //>>interface filters
        //Item.RESET;
        Item.SETCURRENTKEY("Item Category Code","Product Group Code");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Comp Product Category Filter");
        
        //<<interface filters
        */
        //HEI.12<<

        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*///HEI.33>>
                    //HEI.12>>
        FuturMasterInterfaceSetup.TESTFIELD("Comp Product Category Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Component Product Interface");

        //>>interface filters
        //Item.RESET;
        Item.SETCURRENTKEY("Item Category Code", "Product Group Code FND");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Comp Product Category Filter");
        //>>HEI.15
        Item.SETRANGE(Blocked, false);
        //<<HEI.15

        //<<interface filters
        //HEI.12<<
        //process the orders
        if Item.FINDSET then begin
            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Component Product Interface";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);

            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                EntryNo += 1;
                InterfaceEntryLineOut."Entry No." := EntryNo;
                InterfaceEntryLineOut."No." := Item."No.";
                InterfaceEntryLineOut."Global No." := Item."No. 2";
                InterfaceEntryLineOut.Description := Item.Description;
                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryLineOut."Unit of Measure Code" := Item."Base Unit of Measure";
                InterfaceEntryLineOut."Qty. per Unit of Measure" := 1;
                GetProductMasterValues(InterfaceEntryLineOut);

                InterfaceEntryLineOut."No." := DELCHR(Item."No.", '<', '0');
                //HEI.30>>
                //>>HEI.15
                //HEI.37>>
                InterfaceEntryLineOut."Global No." := 'MATERIALS_2';
                //<<HEI.15
                InterfaceEntryLineOut."External Document No." := DELCHR(Item."No. 2", '<', '0');
                //HEI.37<<
                InterfaceEntryLineOut."Description 2" := Item."Description 2";
                //HEI.30<<
                InterfaceEntryLineOut.INSERT;
            until Item.NEXT = 0

        end;

        //for empty file
        if EntryNo = 0 then begin

            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Component Product Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo += 1;
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."Global No." := '';
            InterfaceEntryLineOut.Description := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Unit of Measure Code" := '';
            InterfaceEntryLineOut.INSERT;

        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END;HEI.33>>

    end;

    procedure CreateFinishedUOMProducts(var Item: Record Item; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Customer: Record Customer;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        UnitOfMeasureManag: Codeunit "Unit of Measure Management";
        DefCoef: Decimal;
        Alt1Coef: Decimal;
        Alt2Coef: Decimal;
        ItemUOM: Record "Item Unit of Measure";
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        InterfaceSetup.GET(FuturMasterInterfaceSetup."Finished Product UOM Interface");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        FuturMasterInterfaceSetup.TESTFIELD("Finish UOM Prod Categ Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Finish UOM Prod Def UOM");
        FuturMasterInterfaceSetup.TESTFIELD("Finish UOM Prod Alt1 UOM");
        FuturMasterInterfaceSetup.TESTFIELD("Finish UOM Prod Alt2 UOM");
        
        FuturMasterInterfaceSetup.TESTFIELD("Finished Product UOM Interface");
        
        //>>interface filters
        //Item.RESET;
        Item.SETCURRENTKEY("Item Category Code","Product Group Code");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Finish UOM Prod Categ Filter");
        
        //<<interface filters
        */
        //HEI.12<<

        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*///HEI.33>>
                    //HEI.12>>

        FuturMasterInterfaceSetup.TESTFIELD("Finish UOM Prod Categ Filter");
        FuturMasterInterfaceSetup.TESTFIELD("Finish UOM Prod Def UOM");
        FuturMasterInterfaceSetup.TESTFIELD("Finish UOM Prod Alt1 UOM");
        FuturMasterInterfaceSetup.TESTFIELD("Finish UOM Prod Alt2 UOM");

        FuturMasterInterfaceSetup.TESTFIELD("Finished Product UOM Interface");

        //>>interface filters
        //Item.RESET;
        Item.SETCURRENTKEY("Item Category Code", "Product Group Code FND");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup."Finish UOM Prod Categ Filter");

        //<<interface filters
        //HEI.12<<

        //process the orders
        if Item.FINDSET then begin
            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Finished Product UOM Interface";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);

            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                EntryNo += 1;
                InterfaceEntryLineOut."Entry No." := EntryNo;
                InterfaceEntryLineOut."No." := Item."No.";
                InterfaceEntryLineOut."Global No." := Item."No. 2";

                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryLineOut."Unit of Measure Code" := FuturMasterInterfaceSetup."Finish UOM Prod Def UOM";
                //DefCoef := UnitOfMeasureManag.GetQtyPerUnitOfMeasure(Item."No.", FuturMasterInterfaceSetup."Finish UOM Prod Def UOM");
                Alt1Coef := 0;
                Alt2Coef := 0;
                //BC upgrade GUNREM01 -DIT field >>
                // if ItemUOM.GET(Item."No.", FuturMasterInterfaceSetup."Finish UOM Prod Alt1 UOM") then
                //     Alt1Coef := Item."Unit Volume HL" * UnitOfMeasureManag.GetQtyPerUnitOfMeasure(Item, FuturMasterInterfaceSetup."Finish UOM Prod Alt1 UOM");
                // if ItemUOM.GET(Item."No.", FuturMasterInterfaceSetup."Finish UOM Prod Alt2 UOM") then
                //     Alt2Coef := Item."Unit Volume HL" * UnitOfMeasureManag.GetQtyPerUnitOfMeasure(Item, FuturMasterInterfaceSetup."Finish UOM Prod Alt2 UOM");
                //BC Uprade GUNREM01 -DIT field <<

                //BC UPGRADE PATHAA02 >>
                if ItemUOM.GET(Item."No.", FuturMasterInterfaceSetup."Finish UOM Prod Alt1 UOM") then
                    Alt1Coef := Item."Unit Volume" * UnitOfMeasureManag.GetQtyPerUnitOfMeasure(Item, FuturMasterInterfaceSetup."Finish UOM Prod Alt1 UOM");
                if ItemUOM.GET(Item."No.", FuturMasterInterfaceSetup."Finish UOM Prod Alt2 UOM") then
                    Alt2Coef := Item."Unit Volume" * UnitOfMeasureManag.GetQtyPerUnitOfMeasure(Item, FuturMasterInterfaceSetup."Finish UOM Prod Alt2 UOM");
                //BC UPGRADE PATHAA02 <<

                InterfaceEntryLineOut."Qty. per Unit of Measure" := Alt1Coef;
                InterfaceEntryLineOut."Unit Amount" := Alt2Coef;
                InterfaceEntryLineOut."Location Code" := FuturMasterInterfaceSetup."Finish UOM Prod Alt1 UOM";
                InterfaceEntryLineOut."Currency Code" := FuturMasterInterfaceSetup."Finish UOM Prod Alt2 UOM";
                GetProductMasterValues(InterfaceEntryLineOut);
                InterfaceEntryLineOut."No." := DELCHR(Item."No.", '<', '0');
                InterfaceEntryLineOut."Global No." := DELCHR(Item."No. 2", '<', '0');
                InterfaceEntryLineOut.INSERT;
            until Item.NEXT = 0

        end;

        //for empty file
        if EntryNo = 0 then begin

            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup."Finished Product UOM Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo += 1;
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."Global No." := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Unit of Measure Code" := '';
            InterfaceEntryLineOut."Qty. per Unit of Measure" := 0;
            InterfaceEntryLineOut."Location Code" := '';
            InterfaceEntryLineOut."Currency Code" := '';
            InterfaceEntryLineOut.INSERT;

        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END;HEI.33>>

    end;

    procedure CreateStandardCost(var Item: Record Item; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Customer: Record Customer;
        SKU: Record "Stockkeeping Unit";
        GeneralLedgerSetup: Record "General Ledger Setup";
        FMInterfacesetup3: Record "FuturMaster Interf. Stp 3 INT";
        ItemUoM: Record "Item Unit of Measure";
        Inventorysetup: Record "Inventory Setup";
        HLQty: Decimal;
        DITFoundationSetup: Record FoundationSetup101FDW; //BC UPGRADE PATHAA02
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        if FMInterfacesetup3.GET then; //HEI.49
        Inventorysetup.GET; //HEI.49
        DITFoundationSetup.GET; //BC UPGRADE PATHAA02
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Standard Cost Interface");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.11>>
        /*
        FuturMasterInterfaceSetup2.TESTFIELD("Std Cost Category Filter");
        IF GeneralLedgerSetup.GET THEN;
        
        //>>interface filters
        //Item.RESET;
        Item.SETCURRENTKEY("Item Category Code","Product Group Code");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."Std Cost Category Filter");
        //<<interface filters
        */
        //HEI.11<<

        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*///HEI.33>>

        //HEI.11>>
        FuturMasterInterfaceSetup2.TESTFIELD("Std Cost Category Filter");
        FuturMasterInterfaceSetup2.TESTFIELD("Std Cost Location Filter");
        if GeneralLedgerSetup.GET then;
        //>>interface filters
        Item.SETCURRENTKEY("Item Category Code", "Product Group Code FND");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."Std Cost Category Filter");
        //<<interface filters
        //HEI.11<<

        //process the orders
        if Item.FINDSET then begin
            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Standard Cost Interface";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);
            repeat
                SKU.RESET;
                SKU.SETRANGE("Item No.", Item."No.");
                SKU.SETFILTER("Location Code", FuturMasterInterfaceSetup2."Std Cost Location Filter");
                //IF SKU.FINDFIRST THEN BEGIN //HEI.50
                if SKU.FINDSET(false) then begin //HEI.50
                    repeat
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        EntryNo += 1;
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut."No." := DELCHR(Item."No.", '<', '0');
                        InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                        InterfaceEntryLineOut."Currency Code" := GeneralLedgerSetup."LCY Code";
                        //InterfaceEntryLineOut."Unit Amount" := SKU."Standard Cost";//HEI.49
                        /* //HEI.49>>
                           IF FMInterfacesetup3."Convert Cost PC to HL" THEN BEGIN
                            IF (Item."Base Unit of Measure" = 'PC') AND (Item."Volume Unit of Measure Code"= Inventorysetup."Volume Unit of Measure Code") THEN BEGIN
                               CLEAR(HLQty);
                               ItemUoM.RESET;
                               ItemUoM.SETRANGE("Item No.",Item."No.");
                               ItemUoM.SETRANGE(Code,Inventorysetup."Volume Unit of Measure Code"); //HL
                               IF ItemUoM.FINDFIRST THEN
                                HLQty := ItemUoM."Qty. per Unit of Measure";
                               InterfaceEntryLineOut."Unit Amount" := SKU."Standard Cost"*HLQty;
                             END ELSE
                              InterfaceEntryLineOut."Unit Amount" := SKU."Standard Cost"; //for non PC
                            END ELSE BEGIN
                             InterfaceEntryLineOut."Unit Amount" := SKU."Standard Cost";
                            END;
                          //HEI.49<<
                        *///HEI.70-old code commented

                        //HEI.70>>
                        if (Item."Inventory Posting Group" = FMInterfacesetup3."Inventory Posting Group") then begin //1. Setup FGBX for All Opcos-Imported Goods-Unit Cost;
                            // if (FMInterfacesetup3."Convert Cost PC to HL") and (Item."Base Unit of Measure" = 'PC') and (Item."Volume Unit of Measure Code" = Inventorysetup."Volume Unit of Measure Code") then begin //for PC
                            if (FMInterfacesetup3."Convert Cost PC to HL") and (Item."Base Unit of Measure" = 'PC') and (DITFoundationSetup."Unit Volume UOM" <> '') then begin //for PC-BC UPGRADE PATHAA02
                                CLEAR(HLQty);
                                ItemUoM.RESET;
                                ItemUoM.SETRANGE("Item No.", Item."No.");
                                //ItemUoM.SETRANGE(Code, Inventorysetup."Volume Unit of Measure Code"); //HL
                                ItemUoM.SETRANGE(Code, DITFoundationSetup."Unit Volume UOM"); //HL //BC UPGRADE PATHAA02
                                if ItemUoM.FINDFIRST then
                                    HLQty := ItemUoM."Qty. per Unit of Measure";
                                //HEI.71>>
                                if SKU."Unit Cost" = 0 then //For PC
                                    InterfaceEntryLineOut."Unit Amount" := Item."Unit Cost" * HLQty
                                else
                                    InterfaceEntryLineOut."Unit Amount" := SKU."Unit Cost" * HLQty;
                            end else begin // for non-PC
                                if SKU."Unit Cost" = 0 then
                                    InterfaceEntryLineOut."Unit Amount" := Item."Unit Cost"
                                else
                                    InterfaceEntryLineOut."Unit Amount" := SKU."Unit Cost";
                            end;
                            /*
                            InterfaceEntryLineOut."Unit Amount" := SKU."Unit Cost"*HLQty;
                            END ELSE
                            InterfaceEntryLineOut."Unit Amount" := SKU."Unit Cost"; //for non PC
                            */
                            //HEI.71<<
                        end else begin //2.non imported Goods-Standard Cost
                            //if (FMInterfacesetup3."Convert Cost PC to HL") and (Item."Base Unit of Measure" = 'PC') and (Item."Volume Unit of Measure Code" = Inventorysetup."Volume Unit of Measure Code") then begin //for PC
                            if (FMInterfacesetup3."Convert Cost PC to HL") and (Item."Base Unit of Measure" = 'PC') and (DITFoundationSetup."Unit Volume UOM" <> '') then begin //for PC -BC UPGRADE PATHAA02
                                CLEAR(HLQty);
                                ItemUoM.RESET;
                                ItemUoM.SETRANGE("Item No.", Item."No.");
                                // ItemUoM.SETRANGE(Code, Inventorysetup."Volume Unit of Measure Code"); //HL
                                ItemUoM.SETRANGE(Code, DITFoundationSetup."Unit Volume UOM"); //HL //BC UPGRADE PATHAA02
                                if ItemUoM.FINDFIRST then
                                    HLQty := ItemUoM."Qty. per Unit of Measure";
                                InterfaceEntryLineOut."Unit Amount" := SKU."Standard Cost" * HLQty;
                            end else
                                InterfaceEntryLineOut."Unit Amount" := SKU."Standard Cost"; //for non PC
                        end;
                        //HEI.70<<

                        InterfaceEntryLineOut."Location Code" := SKU."Location Code";//HEI.50
                        InterfaceEntryLineOut.INSERT;
                    until SKU.NEXT = 0;//HEI.50
                end;
            until Item.NEXT = 0

        end;

        //for empty file
        if EntryNo = 0 then begin

            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Standard Cost Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo += 1;
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Currency Code" := '';
            InterfaceEntryLineOut."Unit Amount" := 0;
            InterfaceEntryLineOut.INSERT;

        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END;HEI.33>>

    end;

    local procedure GetFuturMasterInterfaceSetup2();
    begin
        //HEI.03
        if not FuturMasterInterfaceSetupRead2 then
            if FuturMasterInterfaceSetup2.GET then;
        FuturMasterInterfaceSetupRead2 := true;
    end;

    local procedure GroupSalesLine(var locSalesLine: Record "Sales Line"; var locGroupedSalesLine: Record "Ledger Entry Matching Buffer" temporary);
    var
        EntryNo: Integer;
    begin
        //HEI.03
        locGroupedSalesLine.DELETEALL;

        //locSalesLine.RESET;

        if locSalesLine.FINDSET then
            repeat
                locGroupedSalesLine.RESET;
                locGroupedSalesLine.SETRANGE("Account No.", locSalesLine."Sell-to Customer No.");
                locGroupedSalesLine.SETRANGE("Bal. Account No.", locSalesLine."No.");
                locGroupedSalesLine.SETRANGE("Posting Date", locSalesLine."Shipment Date");
                if locGroupedSalesLine.FINDFIRST then begin
                    //locGroupedSalesLine."Remaining Amount" += ConvertQtyToHL(locSalesLine."No.", locSalesLine.Quantity, '', locSalesLine."Unit of Measure Code", locSalesLine."HL Cubage"); //BC Upgrade GUNREM01 -Dependency with DIT Field

                    // locGroupedSalesLine."Remaining Amount" += ConvertQtyToHL(locSalesLine."No.", locSalesLine.Quantity, '', locSalesLine."Unit of Measure Code", locSalesLine."Volume 2 101FDW"); //BC Upgrade KUMARR78 25-05-2026--
                    locGroupedSalesLine."Remaining Amount" += ConvertQtyToHL(locSalesLine."No.", locSalesLine.Quantity, '', locSalesLine."Unit of Measure Code", locSalesLine."Volume Out. 107FDW"); //BC UPGRADE KUMARR78 25-05-2026

                    //locGroupedSalesLine."Remaining Amount" += locSalesLine."HL Cubage";
                    locGroupedSalesLine.MODIFY;
                end else begin
                    locGroupedSalesLine.INIT;
                    EntryNo += 1;
                    locGroupedSalesLine."Entry No." := EntryNo;
                    locGroupedSalesLine."Account Type" := locGroupedSalesLine."Account Type"::Customer;
                    locGroupedSalesLine."Account No." := locSalesLine."Sell-to Customer No.";
                    locGroupedSalesLine."Bal. Account No." := locSalesLine."No.";
                    //locGroupedSalesLine."Remaining Amount" := ConvertQtyToHL(locSalesLine."No.", locSalesLine.Quantity, '', locSalesLine."Unit of Measure Code", locSalesLine."HL Cubage"); //BC Upgrade GUNREM01 -Dependency with DIT Fiel
                    // locGroupedSalesLine."Remaining Amount" += ConvertQtyToHL(locSalesLine."No.", locSalesLine.Quantity, '', locSalesLine."Unit of Measure Code", locSalesLine."Volume 2 101FDW"); //BC Upgrade KUMARR78 25-05-2026--
                    locGroupedSalesLine."Remaining Amount" += ConvertQtyToHL(locSalesLine."No.", locSalesLine.Quantity, '', locSalesLine."Unit of Measure Code", locSalesLine."Volume Out. 107FDW"); //BC Upgrade KUMARR78 25-05-2026


                    //locGroupedSalesLine."Remaining Amount" := locSalesLine."HL Cubage";
                    locGroupedSalesLine."Posting Date" := locSalesLine."Shipment Date";
                    if locGroupedSalesLine."Remaining Amount" <> 0 then
                        locGroupedSalesLine.INSERT;
                end;


            until locSalesLine.NEXT = 0;
    end;

    local procedure GroupSalesLineOnLocation(var locSalesLine: Record "Sales Line"; var locGroupedSalesLine: Record "Ledger Entry Matching Buffer" temporary);
    var
        EntryNo: Integer;
    begin
        //HEI.47>>
        locGroupedSalesLine.DELETEALL;
        if locSalesLine.FINDSET then
            repeat
                locGroupedSalesLine.RESET;
                locGroupedSalesLine.SETRANGE("Account No.", locSalesLine."Location Code");
                locGroupedSalesLine.SETRANGE("Bal. Account No.", locSalesLine."No.");
                locGroupedSalesLine.SETRANGE("Posting Date", locSalesLine."Shipment Date");
                if locGroupedSalesLine.FINDFIRST then begin
                    //  locGroupedSalesLine."Remaining Amount" += ConvertQtyToHL(locSalesLine."No.", locSalesLine.Quantity, '', locSalesLine."Unit of Measure Code", locSalesLine."HL Cubage"); //BC Upgrade GUNREM01 -Dependency with DIT Fiel
                    // locGroupedSalesLine."Remaining Amount" += ConvertQtyToHL(locSalesLine."No.", locSalesLine.Quantity, '', locSalesLine."Unit of Measure Code", locSalesLine."Volume 2 101FDW"); //BC Upgrade KUMARR78 25-05-2026-- 
                    locGroupedSalesLine."Remaining Amount" += ConvertQtyToHL(locSalesLine."No.", locSalesLine.Quantity, '', locSalesLine."Unit of Measure Code", locSalesLine."Volume Out. 107FDW"); //BC Upgrade KUMARR78 25-05-2026

                    locGroupedSalesLine.MODIFY;
                end else begin
                    locGroupedSalesLine.INIT;
                    EntryNo += 1;
                    locGroupedSalesLine."Entry No." := EntryNo;
                    locGroupedSalesLine."Account Type" := locGroupedSalesLine."Account Type"::Customer;
                    locGroupedSalesLine."Account No." := locSalesLine."Location Code";
                    locGroupedSalesLine."Bal. Account No." := locSalesLine."No.";
                    locGroupedSalesLine."External Document No." := locSalesLine."Sell-to Customer No.";
                    //  locGroupedSalesLine."Remaining Amount" := ConvertQtyToHL(locSalesLine."No.", locSalesLine.Quantity, '', locSalesLine."Unit of Measure Code", locSalesLine."HL Cubage");//BC Upgrade GUNREM01 -Dependency with DIT Fiel
                    // locGroupedSalesLine."Remaining Amount" := ConvertQtyToHL(locSalesLine."No.", locSalesLine.Quantity, '', locSalesLine."Unit of Measure Code", locSalesLine."Volume 2 101FDW");//BC Upgrade KUMARR78 25-05-2026 --
                    locGroupedSalesLine."Remaining Amount" := ConvertQtyToHL(locSalesLine."No.", locSalesLine.Quantity, '', locSalesLine."Unit of Measure Code", locSalesLine."Volume Out. 107FDW");//BC Upgrade KUMARR78 25-05-2026
                    locGroupedSalesLine."Posting Date" := locSalesLine."Shipment Date";
                    if locGroupedSalesLine."Remaining Amount" <> 0 then
                        locGroupedSalesLine.INSERT;
                end;
            until locSalesLine.NEXT = 0;
        //HEI.47<<
    end;

    procedure CreateSemiFinished(var Item: Record Item; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Customer: Record Customer;
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Semi Finished Prod Interface");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;


        //HEI.12>>
        /*
        FuturMasterInterfaceSetup2.TESTFIELD("SemiFinish Category Filter");
        //>>interface filters
        Item.RESET;
        Item.SETCURRENTKEY("Item Category Code","Product Group Code");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."SemiFinish Category Filter");
        IF FuturMasterInterfaceSetup2."SemiFinish Location Filter" <> '' THEN
          Item.SETFILTER("Location Code", FuturMasterInterfaceSetup2."SemiFinish Location Filter");
        //remove the filters for Cross-Plant Material Status and plant-Spe cific Material Status
        //IF FuturMasterInterfaceSetup2."SemiFinishCrossPlMatSt  Filter" THEN
        //  Item.SETRANGE("Cross-Plant Material Status", Item."Cross-Plant Material Status"::Active);
        //IF FuturMasterInterfaceSetup2."SemiFinishPlSpMatStt  Filter" THEN
        //  Item.SETRANGE("Plant-Specific Material Status", Item."Plant-Specific Material Status"::"Local active");
        //<<interface filters
        */
        //HEI.12<<

        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*///HEI.33>>
                    //HEI.12>>
        FuturMasterInterfaceSetup2.TESTFIELD("SemiFinish Category Filter");
        //>>interface filters
        Item.RESET;
        Item.SETCURRENTKEY("Item Category Code", "Product Group Code FND");
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."SemiFinish Category Filter");
        //BC Upgrade GUNREM01 -DIT Field >>
        // if FuturMasterInterfaceSetup2."SemiFinish Location Filter" <> '' then
        //     Item.SETFILTER("Location Code", FuturMasterInterfaceSetup2."SemiFinish Location Filter");
        //BC Upgrade GUNREM01 -DIT Field <<
        //>>HEI.15
        Item.SETRANGE(Blocked, false);
        //<<HEI.15

        //<<interface filters
        //HEI.12<<

        //process the orders
        if Item.FINDSET then begin
            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Semi Finished Prod Interface";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);

            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                EntryNo += 1;
                InterfaceEntryLineOut."Entry No." := EntryNo;
                InterfaceEntryLineOut."No." := Item."No.";
                InterfaceEntryLineOut."Global No." := Item."No. 2";
                InterfaceEntryLineOut.Description := Item.Description;
                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryLineOut."Unit of Measure Code" := FuturMasterInterfaceSetup2."SemiFinish Def UOM";
                GetProductMasterValues(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Ship-to Name" := InterfaceEntryLineOut."SPT Outer Layer Code" + ' ' + InterfaceEntryLineOut."SPT Units per Outer Layer";
                InterfaceEntryLineOut."E-Mail" := InterfaceEntryLineOut."SPT Outer Layer Description" + ' ' + InterfaceEntryLineOut."SPT Units per Outer Layer";
                InterfaceEntryLineOut."Ship-to Address" := InterfaceEntryLineOut."SPT Inner Layer Code" + ' ' + InterfaceEntryLineOut."SPT Units per In Between Layer";
                InterfaceEntryLineOut."E-Mail 2" := InterfaceEntryLineOut."SPT Inner Layer Description" + ' ' + InterfaceEntryLineOut."SPT Units per In Between Layer";
                InterfaceEntryLineOut."No." := DELCHR(Item."No.", '<', '0');
                InterfaceEntryLineOut."Global No." := DELCHR(Item."No. 2", '<', '0');
                InterfaceEntryLineOut.INSERT;
            until Item.NEXT = 0

        end;

        //for empty file
        if EntryNo = 0 then begin

            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Semi Finished Prod Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;

                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo += 1;
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."Global No." := '';
            InterfaceEntryLineOut.Description := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Unit of Measure Code" := '';
            InterfaceEntryLineOut.INSERT;

        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END;HEI.33>>

    end;

    procedure CreateSupplyPlanPurchOpenOrders(var PurchaseLine: Record "Purchase Line"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
        PurchaseHeader: Record "Purchase Header";
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        GetFuturMasterInterfaceSetup3; //HEI.67
        FuturMasterInterfaceSetup.GET; //HEI.63
        FuturMasterInterfaceSetup2.TESTFIELD("Open Purch Orders Interface");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Open Purch Orders Interface");


        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;


        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        FuturMasterInterfaceSetup2.TESTFIELD("OpenPurchOrd Category Filter");
        FuturMasterInterfaceSetup2.TESTFIELD("OpenPurchOrd Doc Types Filter");
        FuturMasterInterfaceSetup2.TESTFIELD("OpenPurchOrd Status Filter");
        
        //>>interface filters
        //filters on Purchase Header
        PurchaseHeader.SETCURRENTKEY("Document Type",Status,"Pay-to Vendor No.");
        //PurchaseHeader.SETFILTER(Status, '=%1|%2', PurchaseHeader.Status::Open, PurchaseHeader.Status::Released);
        PurchaseHeader.SETFILTER(Status, FuturMasterInterfaceSetup2."OpenPurchOrd Status Filter");
        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
        
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETRANGE("Delivery Finalized", FALSE);
        PurchaseLine.SETFILTER("Outstanding Quantity" , '<> 0');
        
        IF FuturMasterInterfaceSetup2."OpenPurchOrd Location Filter" <> '' THEN
          PurchaseLine.SETFILTER("Location Code", FuturMasterInterfaceSetup2."OpenPurchOrd Location Filter");
        
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."OpenPurchOrd Category Filter");
        //<<interface filters
        
        GroupPurchLine(PurchaseLine, PurchaseHeader, TempGroupPurchLine);
        */
        //HEI.12<<
        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*///HEI.33>>
                    //HEI.12>>
        FuturMasterInterfaceSetup2.TESTFIELD("OpenPurchOrd Category Filter");
        FuturMasterInterfaceSetup2.TESTFIELD("OpenPurchOrd Doc Types Filter");
        FuturMasterInterfaceSetup2.TESTFIELD("OpenPurchOrd Status Filter");

        //>>interface filters
        //filters on Purchase Header
        PurchaseHeader.SETCURRENTKEY("Document Type", Status, "Pay-to Vendor No.");
        //PurchaseHeader.SETFILTER(Status, '=%1|%2', PurchaseHeader.Status::Open, PurchaseHeader.Status::Released);
        PurchaseHeader.SETFILTER(Status, FuturMasterInterfaceSetup2."OpenPurchOrd Status Filter");
        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);

        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETRANGE("Delivery Finalized FND", false);
        PurchaseLine.SETFILTER("Outstanding Quantity", '<> 0');

        //HEI.63>>
        //HEI.65>>
        //IF FuturMasterInterfaceSetup."CMG Filter"<> '' THEN
        // PurchaseLine.SETFILTER("CMG Code",FuturMasterInterfaceSetup."CMG Filter");
        //HEI.65<<
        //HEI.63<<
        //HEI.67>>
        if FuturMasterInterfaceSetup3."CMG Filter" <> '' then
            PurchaseLine.SETFILTER("CMG Code FND", FuturMasterInterfaceSetup3."CMG Filter");
        //HEI.67<<
        if FuturMasterInterfaceSetup2."OpenPurchOrd Location Filter" <> '' then
            PurchaseLine.SETFILTER("Location Code", FuturMasterInterfaceSetup2."OpenPurchOrd Location Filter");

        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."OpenPurchOrd Category Filter");
        //<<interface filters

        GroupPurchLine(PurchaseLine, PurchaseHeader, TempGroupPurchLine);
        //HEI.12<<
        //process the orders
        TempGroupPurchLine.RESET;
        TempGroupPurchLine.SETCURRENTKEY("Bal. Account No.", "Account No.", "External Document No.");
        if TempGroupPurchLine.FINDSET then begin

            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Open Purch Orders Interface";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                EntryNo += 1;
                InterfaceEntryLineOut."Entry No." := EntryNo;
                InterfaceEntryLineOut."No." := DELCHR(TempGroupPurchLine."Account No.", '<', '0');
                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryLineOut."Location Code" := TempGroupPurchLine."Bal. Account No.";
                InterfaceEntryLineOut."Action Code" := TempGroupPurchLine."External Document No.";
                InterfaceEntryLineOut.Quantity := TempGroupPurchLine."Remaining Amount";
                InterfaceEntryLineOut.INSERT;

            until TempGroupPurchLine.NEXT = 0;
        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Open Purch Orders Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;

            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Location Code" := '';
            InterfaceEntryLineOut."Action Code" := '';
            InterfaceEntryLineOut.INSERT;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END;HEI.33>>

    end;

    local procedure GroupPurchLine(var locPurchLine: Record "Purchase Line"; var locPurchaseHeader: Record "Purchase Header"; var locGroupedPurchLine: Record "Ledger Entry Matching Buffer" temporary);
    var
        EntryNo: Integer;
        DocumentYearWeek: Text[6];
        Item: Record Item;
    begin
        //HEI.03
        locGroupedPurchLine.DELETEALL;
        EntryNo := 0;
        //HEI.18>>
        Item.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."OpenPurchOrd Category Filter");
        //HEI.18<<

        if locPurchLine.FINDSET then begin
            repeat
                CLEAR(DocumentYearWeek);
                locPurchaseHeader.SETRANGE("No.", locPurchLine."Document No.");
                if locPurchaseHeader.FINDFIRST then begin
                    Item.SETRANGE("No.", locPurchLine."No.");
                    if Item.FINDFIRST then begin
                        //HEI.29>>
                        //IF locPurchLine."Planned Receipt Date" > TODAY - FuturMasterInterfaceSetup2."OpenPurchOrd Age Days Filter" THEN BEGIN
                        //  IF DATE2DWY(locPurchLine."Planned Receipt Date", 2) < 10 THEN
                        //    DocumentYearWeek := FORMAT(DATE2DWY(locPurchLine."Planned Receipt Date", 3)) + '0'+ FORMAT(DATE2DWY(locPurchLine."Planned Receipt Date", 2))
                        //  ELSE
                        //    DocumentYearWeek := FORMAT(DATE2DWY(locPurchLine."Planned Receipt Date", 3)) + FORMAT(DATE2DWY(locPurchLine."Planned Receipt Date", 2));
                        //IF NOT CheckImportPO(locPurchaseHeader) THEN BEGIN  //HEI.38  //HEI.41
                        if locPurchLine."Expected Receipt Date" > TODAY - FuturMasterInterfaceSetup2."OpenPurchOrd Age Days Filter" then begin
                            if DATE2DWY(locPurchLine."Expected Receipt Date", 2) < 10 then
                                DocumentYearWeek := FORMAT(DATE2DWY(locPurchLine."Expected Receipt Date", 3)) + '0' + FORMAT(DATE2DWY(locPurchLine."Expected Receipt Date", 2))
                            else
                                DocumentYearWeek := FORMAT(DATE2DWY(locPurchLine."Expected Receipt Date", 3)) + FORMAT(DATE2DWY(locPurchLine."Expected Receipt Date", 2));
                            //HEI.29<<
                            locGroupedPurchLine.RESET;
                            locGroupedPurchLine.SETRANGE("Account No.", locPurchLine."No.");
                            locGroupedPurchLine.SETRANGE("Bal. Account No.", locPurchLine."Location Code");
                            locGroupedPurchLine.SETRANGE("External Document No.", DocumentYearWeek);
                            if locGroupedPurchLine.FINDFIRST then begin
                                //HEI.18 comment line locGroupedPurchLine."Remaining Amount" += locPurchLine."Outstanding Quantity";
                                //HEI.18>>
                                //BC Upgrade GUNREM01 -Dependency with DIT Field >>//BC UPGRADE ATHUKS01  
                                if Item."Item Category Code" in ['01', '07', '08'] then
                                    locGroupedPurchLine."Remaining Amount" += ConvertQtyToHL(Item."No.", locPurchLine."Outstanding Quantity", '', locPurchLine."Unit of Measure Code", locPurchLine."Outstanding Quantity" * locPurchLine."Unit Volume")
                                else
                                    locGroupedPurchLine."Remaining Amount" += locPurchLine."Outstanding Qty. (Base)";
                                //BC Upgrade GUNREM01 -Dependency with DIT Field << //BC UPGRADE ATHUKS01  
                                //HEI.18<<
                                locGroupedPurchLine.MODIFY;
                            end else begin
                                if locPurchLine."Outstanding Quantity" <> 0 then begin
                                    EntryNo += 1;
                                    locGroupedPurchLine.INIT;
                                    locGroupedPurchLine."Entry No." := EntryNo;
                                    locGroupedPurchLine."Account No." := locPurchLine."No.";
                                    locGroupedPurchLine."Bal. Account No." := locPurchLine."Location Code";
                                    locGroupedPurchLine."External Document No." := DocumentYearWeek;
                                    //HEI.18 comment  locGroupedPurchLine."Remaining Amount" := locPurchLine."Outstanding Quantity";
                                    //HEI.18>>
                                    //BC Upgrade GUNREM01 -Dependency with DIT Field >> //BC UPGRADE ATHUKS01
                                    if Item."Item Category Code" in ['01', '07', '08'] then
                                        locGroupedPurchLine."Remaining Amount" := ConvertQtyToHL(Item."No.", locPurchLine."Outstanding Quantity", '', locPurchLine."Unit of Measure Code", locPurchLine."Outstanding Quantity" * locPurchLine."Unit Volume")
                                    else
                                        locGroupedPurchLine."Remaining Amount" := locPurchLine."Outstanding Qty. (Base)";
                                    //BC Upgrade GUNREM01 -Dependency with DIT Field<< //BC UPGRADE ATHUKS01  
                                    //HEI.18<<

                                    locGroupedPurchLine.INSERT;
                                end;
                            end;
                        end;
                        //HEI.41>>
                        ////HEI.38>>
                        //END ELSE BEGIN
                        //  IF locPurchLine."Exp Physical Del Date(Imp)" > TODAY - FuturMasterInterfaceSetup2."OpenPurchOrd Age Days Filter" THEN BEGIN
                        //    IF DATE2DWY(locPurchLine."Exp Physical Del Date(Imp)", 2) < 10 THEN
                        //      DocumentYearWeek := FORMAT(DATE2DWY(locPurchLine."Exp Physical Del Date(Imp)", 3)) + '0'+ FORMAT(DATE2DWY(locPurchLine."Exp Physical Del Date(Imp)", 2))
                        //    ELSE
                        //      DocumentYearWeek := FORMAT(DATE2DWY(locPurchLine."Exp Physical Del Date(Imp)", 3)) + FORMAT(DATE2DWY(locPurchLine."Exp Physical Del Date(Imp)", 2));
                        //  //HEI.29<<
                        //    locGroupedPurchLine.RESET;
                        //    locGroupedPurchLine.SETRANGE("Account No.", locPurchLine."No.");
                        //    locGroupedPurchLine.SETRANGE("Bal. Account No.", locPurchLine."Location Code");
                        //    locGroupedPurchLine.SETRANGE("External Document No.", DocumentYearWeek);
                        //    IF locGroupedPurchLine.FINDFIRST THEN BEGIN
                        //      //HEI.18 comment line locGroupedPurchLine."Remaining Amount" += locPurchLine."Outstanding Quantity";
                        //      //HEI.18>>
                        //      IF Item."Item Category Code" IN ['01', '07', '08'] THEN
                        //        locGroupedPurchLine."Remaining Amount" += ConvertQtyToHL(Item."No.", locPurchLine."Outstanding Quantity", '', locPurchLine."Unit of Measure Code", locPurchLine."Outstanding Quantity" * locPurchLine."Unit Volume HL")
                        //      ELSE
                        //        locGroupedPurchLine."Remaining Amount" += locPurchLine."Outstanding Qty. (Base)";
                        //      //HEI.18<<
                        //      locGroupedPurchLine.MODIFY;
                        //    END ELSE BEGIN
                        //      IF locPurchLine."Outstanding Quantity" <> 0 THEN BEGIN
                        //        EntryNo += 1;
                        //        locGroupedPurchLine.INIT;
                        //        locGroupedPurchLine."Entry No." := EntryNo;
                        //        locGroupedPurchLine."Account No." := locPurchLine."No.";
                        //        locGroupedPurchLine."Bal. Account No." := locPurchLine."Location Code";
                        //        locGroupedPurchLine."External Document No." := DocumentYearWeek;
                        //        //HEI.18 comment  locGroupedPurchLine."Remaining Amount" := locPurchLine."Outstanding Quantity";
                        //        //HEI.18>>
                        //        IF Item."Item Category Code" IN ['01', '07', '08'] THEN
                        //          locGroupedPurchLine."Remaining Amount" := ConvertQtyToHL(Item."No.", locPurchLine."Outstanding Quantity", '', locPurchLine."Unit of Measure Code", locPurchLine."Outstanding Quantity" * locPurchLine."Unit Volume HL")
                        //        ELSE
                        //          locGroupedPurchLine."Remaining Amount" := locPurchLine."Outstanding Qty. (Base)";
                        //       //HEI.18<<
                        //
                        //        locGroupedPurchLine.INSERT;
                        //      END;
                        //    END;
                        //  END;
                        //END;
                        ////HEI.38<<
                        //HEI.41
                    end;
                end;
            until locPurchLine.NEXT = 0;
        end;
    end;

    procedure CreateProcFirmPlannedOrders(var ProdOrderLine: Record "Prod. Order Line"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        FuturMasterInterfaceSetup2.TESTFIELD("Proc And Firm Pl Orders Interf");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Proc And Firm Pl Orders Interf");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        FuturMasterInterfaceSetup2.TESTFIELD("ProcFirmOrd Status Filter");
        
        {HEI.05>>
        //>>interface filters
        //filters on Production Header
        ProductionOrder.SETFILTER("Zone Code", FuturMasterInterfaceSetup2."ProcFirmOrd Zone Filter");
        ProductionOrder.SETFILTER("Location Code", FuturMasterInterfaceSetup2."ProcFirmOrd Location Filter");
        ProductionOrder.SETFILTER(Status, FuturMasterInterfaceSetup2."ProcFirmOrd Status Filter");
        ProductionOrder.SETRANGE("Source Type", ProductionOrder."Source Type"::Item);
        //<<interface filters
        
        
        GroupProdOrders(ProductionOrder, TempGroupProdOrder);
        HEI.05<<}
        
        //>>HEI.05
        
        //>>interface filters
        //filters on Production Header
        ProdOrderLine.SETFILTER("Zone Code", FuturMasterInterfaceSetup2."ProcFirmOrd Zone Filter");
        ProdOrderLine.SETFILTER("Location Code", FuturMasterInterfaceSetup2."ProcFirmOrd Location Filter");
        ProdOrderLine.SETFILTER(Status, FuturMasterInterfaceSetup2."ProcFirmOrd Status Filter");
        //<<interface filters
        
        GroupProdOrders(ProdOrderLine, TempGroupProdOrder);
        //<<HEI.05
        
        TempGroupProdOrder.RESET;
        TempGroupProdOrder.SETCURRENTKEY("Account No.", "Bal. Account No.", "External Document No.");
        */
        //HEI.12<<
        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*///HEI.33>>
                    //HEI.12>>

        FuturMasterInterfaceSetup2.TESTFIELD("ProcFirmOrd Status Filter");
        //>>HEI.05
        //>>interface filters
        //filters on Production Header
        ProdOrderLine.SETFILTER("Zone Code FND", FuturMasterInterfaceSetup2."ProcFirmOrd Zone Filter");
        ProdOrderLine.SETFILTER("Location Code", FuturMasterInterfaceSetup2."ProcFirmOrd Location Filter");
        ProdOrderLine.SETFILTER(Status, FuturMasterInterfaceSetup2."ProcFirmOrd Status Filter");
        //<<interface filters

        GroupProdOrders(ProdOrderLine, TempGroupProdOrder);
        //<<HEI.05

        TempGroupProdOrder.RESET;
        TempGroupProdOrder.SETCURRENTKEY("Account No.", "Bal. Account No.", "External Document No.");

        //HEI.12<<
        //process the orders
        if TempGroupProdOrder.FINDSET then begin

            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Proc And Firm Pl Orders Interf";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                EntryNo += 1;
                InterfaceEntryLineOut."Entry No." := EntryNo;
                InterfaceEntryLineOut."No." := DELCHR(TempGroupProdOrder."Account No.", '<', '0'); //material code
                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryLineOut."Location Code" := TempGroupProdOrder."Bal. Account No.";  //location code
                InterfaceEntryLineOut."Action Code" := TempGroupProdOrder."External Document No.";   //YYYYWW
                InterfaceEntryLineOut.Quantity := TempGroupProdOrder."Remaining Amount";  //quantity grouped
                InterfaceEntryLineOut.INSERT;
            until TempGroupProdOrder.NEXT = 0;
        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Proc And Firm Pl Orders Interf";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Location Code" := '';
            InterfaceEntryLineOut."Action Code" := '';
            InterfaceEntryLineOut.INSERT;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END;HEI.33>>

    end;

    local procedure GroupProdOrders(var locProdOrderLine: Record "Prod. Order Line"; var locGroupedProdOrder: Record "Ledger Entry Matching Buffer" temporary);
    var
        DocumentWeek: Text[6];
        EntryNo: Integer;
        DocumentQtyHL: Decimal;
        ProductionOrderL: Record "Production Order";
    begin
        //HEI.03
        EntryNo := 0;

        //>>HEI.05
        //change local variable locProdOrder with locProdOrderLine
        if locProdOrderLine.FINDSET then
            repeat
                DocumentQtyHL := 0;
                //HEI.22>>
                ProductionOrderL.RESET;
                ProductionOrderL.SETCURRENTKEY(Status, "No.", Blocked);
                ProductionOrderL.SETRANGE(Status, locProdOrderLine.Status);
                ProductionOrderL.SETRANGE("No.", locProdOrderLine."Prod. Order No.");
                ProductionOrderL.SETRANGE(Blocked, false);
                if ProductionOrderL.FINDFIRST then begin
                    //HEI.22<<
                    //calculate the YYYYWW for the current document
                    if DATE2DWY(locProdOrderLine."Ending Date", 2) < 10 then
                        DocumentWeek := FORMAT(DATE2DWY(locProdOrderLine."Ending Date", 3)) + '0' + FORMAT(DATE2DWY(locProdOrderLine."Ending Date", 2))
                    else
                        DocumentWeek := FORMAT(DATE2DWY(locProdOrderLine."Ending Date", 3)) + FORMAT(DATE2DWY(locProdOrderLine."Ending Date", 2));

                    //released documents and firm planned...calculate quantity in HL
                    DocumentQtyHL := ConvertQtyToHL(locProdOrderLine."Item No.", locProdOrderLine."Remaining Quantity", '', locProdOrderLine."Unit of Measure Code", 0);

                    //group the quantities on Item No/Location code/YYYYWW
                    if DocumentQtyHL <> 0 then begin
                        locGroupedProdOrder.RESET;
                        locGroupedProdOrder.SETRANGE("Account No.", locProdOrderLine."Item No.");
                        locGroupedProdOrder.SETRANGE("Bal. Account No.", locProdOrderLine."Location Code");
                        locGroupedProdOrder.SETRANGE("External Document No.", DocumentWeek);
                        if locGroupedProdOrder.FINDFIRST then begin
                            locGroupedProdOrder."Remaining Amount" += DocumentQtyHL;
                            locGroupedProdOrder.MODIFY;
                        end else begin
                            EntryNo += 1;
                            locGroupedProdOrder.INIT;
                            locGroupedProdOrder."Entry No." := EntryNo;
                            locGroupedProdOrder."Account No." := locProdOrderLine."Item No.";
                            locGroupedProdOrder."Bal. Account No." := locProdOrderLine."Location Code";
                            locGroupedProdOrder."External Document No." := DocumentWeek;
                            locGroupedProdOrder."Remaining Amount" := DocumentQtyHL;
                            locGroupedProdOrder.INSERT;
                        end;
                    end;
                    //HEI.22>>
                end;
            //HEI.22<<
            until locProdOrderLine.NEXT = 0;

        //<<HEI.05

        /*//HEI.05 comment all lines
        IF locProdOrder.FINDSET THEN
          REPEAT
            DocumentQtyHL := 0;
            //calculate the YYYYWW for the current document
            IF DATE2DWY(locProdOrder."Ending Date", 2) < 10 THEN
              DocumentWeek := FORMAT(DATE2DWY(locProdOrder."Ending Date", 3)) + '0'+ FORMAT(DATE2DWY(locProdOrder."Ending Date", 2))
            ELSE
              DocumentWeek := FORMAT(DATE2DWY(locProdOrder."Ending Date", 3)) + FORMAT(DATE2DWY(locProdOrder."Ending Date", 2));
        
            //released documents and firm planned...calculate quantity in HL
        
            locProdOrderLine.RESET;
            locProdOrderLine.SETRANGE(Status, locProdOrder.Status);
            locProdOrderLine.SETRANGE("Prod. Order No.", locProdOrder."No.");
            IF locProdOrderLine.FINDFIRST THEN
              DocumentQtyHL := ConvertQtyToHL(locProdOrder."Source No.", locProdOrderLine."Remaining Quantity", '', locProdOrderLine."Unit of Measure Code", 0);
        {
            IF locProdOrder.Status = locProdOrder.Status::Released THEN BEGIN
              locProdOrderLine.RESET;
              locProdOrderLine.SETRANGE(Status, locProdOrder.Status);
              locProdOrderLine.SETRANGE("Prod. Order No.", locProdOrder."No.");
              IF locProdOrderLine.FINDFIRST THEN
                DocumentQtyHL := ConvertQtyToHL(locProdOrder."Source No.", locProdOrderLine."Remaining Quantity", '', locProdOrderLine."Unit of Measure Code", 0);
            END ELSE BEGIN
              locProdOrderLine.RESET;
              locProdOrderLine.SETRANGE(Status, locProdOrder.Status);
              locProdOrderLine.SETRANGE("Prod. Order No.", locProdOrder."No.");
              DocumentQtyHL := ConvertQtyToHL(locProdOrder."Source No.", locProdOrderLine."Remaining Quantity", '', locProdOrderLine."Unit of Measure Code", 0);
            END;
        }
        
            //group the quantities on Item No/Location code/YYYYWW
            IF DocumentQtyHL <> 0 THEN BEGIN
              locGroupedProdOrder.RESET;
              locGroupedProdOrder.SETRANGE("Account No.", locProdOrder."Source No.");
              locGroupedProdOrder.SETRANGE("Bal. Account No.", locProdOrder."Location Code");
              locGroupedProdOrder.SETRANGE("External Document No.", DocumentWeek);
              IF locGroupedProdOrder.FINDFIRST THEN BEGIN
                locGroupedProdOrder."Remaining Amount" += DocumentQtyHL;
                locGroupedProdOrder.MODIFY;
              END ELSE BEGIN
                EntryNo += 1;
                locGroupedProdOrder.INIT;
                locGroupedProdOrder."Entry No." := EntryNo;
                locGroupedProdOrder."Account No." := locProdOrder."Source No.";
                locGroupedProdOrder."Bal. Account No." := locProdOrder."Location Code";
                locGroupedProdOrder."External Document No." := DocumentWeek;
                locGroupedProdOrder."Remaining Amount" := DocumentQtyHL;
                locGroupedProdOrder.INSERT;
              END;
            END;
          UNTIL locProdOrder.NEXT = 0;
        HEI.05*/

    end;

    procedure CreateStockTranspOrders(var TransferLine: Record "Transfer Line"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        GetFuturMasterInterfaceSetup3;//HEI.60
        FuturMasterInterfaceSetup2.TESTFIELD("Stock Transport Orders Interf");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Stock Transport Orders Interf");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        FuturMasterInterfaceSetup2.TESTFIELD("StockTransOrd Category Filter");
        
        //>>interface filters
        //filters on Transfer Header
        IF FuturMasterInterfaceSetup2."StockTransOrd Location Filter" <> '' THEN
          TransferLine.SETFILTER("Transfer-to Code", FuturMasterInterfaceSetup2."StockTransOrd Location Filter");
        IF FuturMasterInterfaceSetup2."StockTransOrd Category Filter" <> '' THEN
          TransferLine.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."StockTransOrd Category Filter");
        TransferLine.SETRANGE(Status, TransferLine.Status::Released);
        TransferLine.SETRANGE("Item Charge No.", '');
        //<<interface filters
        
        GroupTransfLines(TransferLine, TempGroupTransfLines);
        
        TempGroupTransfLines.RESET;
        TempGroupTransfLines.SETCURRENTKEY("Account No.", "Bal. Account No.", "External Document No.");
        */
        //HEI.12<<

        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*/ //HEI.33
                     //HEI.12>>
        FuturMasterInterfaceSetup2.TESTFIELD("StockTransOrd Category Filter");

        //HEI.26<<
        //>>interface filters
        //filters on Transfer Header
        if FuturMasterInterfaceSetup2."StockTransOrd Location Filter" <> '' then begin
            TransferLine.SETFILTER("Transfer-to Code", FuturMasterInterfaceSetup2."StockTransOrd Location Filter");
            //HEI.60<<
            if FuturMasterInterfaceSetup3."StockTransOrd Virtual Location" <> '' then
                TransferLine.SETFILTER("Transfer-from Code", FuturMasterInterfaceSetup3."StockTransOrd Virtual Location");
            /*
            IF FuturMasterInterfaceSetup2."StockTOVirtual Location Filter" <> '' THEN
            TransferLine.SETFILTER("Transfer-from Code", '<>%1',FuturMasterInterfaceSetup2."StockTOVirtual Location Filter");
            */
            //HEI.60>>
        end;
        //HEI.26>>
        if FuturMasterInterfaceSetup2."StockTransOrd Category Filter" <> '' then
            TransferLine.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."StockTransOrd Category Filter");
        TransferLine.SETRANGE(Status, TransferLine.Status::Released);
        //  TransferLine.SETRANGE("Item Charge No.", ''); //BC Upgrade GUNREM01 -DIT Field
        //<<interface filters

        GroupTransfLines(TransferLine, TempGroupTransfLines);

        TempGroupTransfLines.RESET;
        TempGroupTransfLines.SETCURRENTKEY("Account No.", "Bal. Account No.", "External Document No.");
        //HEI.12<<
        //process the orders
        if TempGroupTransfLines.FINDSET then begin

            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Stock Transport Orders Interf";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                EntryNo += 1;
                InterfaceEntryLineOut."Entry No." := EntryNo;
                InterfaceEntryLineOut."No." := DELCHR(TempGroupTransfLines."Account No.", '<', '0'); //material code
                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryLineOut."Location Code" := TempGroupTransfLines."Bal. Account No.";  //location code
                InterfaceEntryLineOut."Action Code" := TempGroupTransfLines."External Document No.";   //YYYYWW
                InterfaceEntryLineOut.Quantity := TempGroupTransfLines."Remaining Amount";  //quantity grouped
                InterfaceEntryLineOut.INSERT;
            until TempGroupTransfLines.NEXT = 0;
        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Stock Transport Orders Interf";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Location Code" := '';
            InterfaceEntryLineOut."Action Code" := '';
            InterfaceEntryLineOut.INSERT;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END; //HEI.33

    end;

    local procedure GroupTransfLines(var locTransfLines: Record "Transfer Line"; var locGroupedTransfLines: Record "Ledger Entry Matching Buffer" temporary);
    var
        locProdOrderLine: Record "Prod. Order Line";
        DocumentWeek: Text[6];
        EntryNo: Integer;
        DocumentQtyHL: Decimal;
        lItem: Record Item;
    begin
        //HEI.03
        EntryNo := 0;

        if locTransfLines.FINDSET then
            repeat
                //calculate the YYYYWW for the current document
                if DATE2DWY(locTransfLines."Receipt Date", 2) < 10 then
                    DocumentWeek := FORMAT(DATE2DWY(locTransfLines."Receipt Date", 3)) + '0' + FORMAT(DATE2DWY(locTransfLines."Receipt Date", 2))
                else
                    DocumentWeek := FORMAT(DATE2DWY(locTransfLines."Receipt Date", 3)) + FORMAT(DATE2DWY(locTransfLines."Receipt Date", 2));
                /*>>HEI.16 comment the lines
                //calculate quantity in HL on Transfer Lines
                DocumentQtyHL := 0;
                DocumentQtyHL := ConvertQtyToHL(locTransfLines."Item No.", locTransfLines."Outstanding Quantity", '', locTransfLines."Unit of Measure Code", 0);
                <<HEI.16*/


                //>>HEI.16
                if lItem.GET(locTransfLines."Item No.") then;
                if lItem."Item Category Code" in ['01', '07', '08'] then begin
                    //finished and semifinished in HL 01, 07, 08
                    DocumentQtyHL := 0;
                    //  DocumentQtyHL := ConvertQtyToHL(locTransfLines."Item No.", locTransfLines."Qty. in Transit", '', locTransfLines."Unit of Measure Code", locTransfLines."Qty. in Transit" * locTransfLines."Unit Volume HL"); //BC Upgrade GUNREM01 -DIT Field
                    DocumentQtyHL := ConvertQtyToHL(locTransfLines."Item No.", locTransfLines."Qty. in Transit", '', locTransfLines."Unit of Measure Code", locTransfLines."Qty. in Transit" * locTransfLines."Unit Volume"); //BC UPGRADE PATHAA02
                end else begin
                    //other Item Category in Base UOM
                    DocumentQtyHL := 0;
                    DocumentQtyHL := locTransfLines."Qty. in Transit (Base)";
                end;

                //<<HEI.16


                //group the quantities on Item No/Location code/YYYYWW
                if DocumentQtyHL <> 0 then begin
                    locGroupedTransfLines.RESET;
                    locGroupedTransfLines.SETRANGE("Account No.", locTransfLines."Item No.");
                    locGroupedTransfLines.SETRANGE("Bal. Account No.", locTransfLines."Transfer-to Code");
                    locGroupedTransfLines.SETRANGE("External Document No.", DocumentWeek);
                    if locGroupedTransfLines.FINDFIRST then begin
                        locGroupedTransfLines."Remaining Amount" += DocumentQtyHL;
                        locGroupedTransfLines.MODIFY;
                    end else begin
                        EntryNo += 1;
                        locGroupedTransfLines.INIT;
                        locGroupedTransfLines."Entry No." := EntryNo;
                        locGroupedTransfLines."Account No." := locTransfLines."Item No.";
                        locGroupedTransfLines."Bal. Account No." := locTransfLines."Transfer-to Code";
                        locGroupedTransfLines."External Document No." := DocumentWeek;
                        locGroupedTransfLines."Remaining Amount" := DocumentQtyHL;
                        locGroupedTransfLines.INSERT;
                    end;
                end;
            until locTransfLines.NEXT = 0;

    end;

    procedure CreateActualProduction(var ProductionOrder: Record "Production Order"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        FuturMasterInterfaceSetup2.TESTFIELD("Actual Production Interf");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Actual Production Interf");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;


        //HEI.12>>
        /*
        //>>interface filters
        //filters on Production Header
        ProductionOrder.SETFILTER("Zone Code", FuturMasterInterfaceSetup2."ActualProd Zone Filter");
        ProductionOrder.SETFILTER("Location Code", FuturMasterInterfaceSetup2."ActualProd Location Filter");
        ProductionOrder.SETFILTER(Status, FuturMasterInterfaceSetup2."ActualProd Status Filter");
        //<<interface filters
        
        GroupActualProdOrderWeek(ProductionOrder, TempGroupProdOrder, TODAY, 8);
        //GroupActualProdOrderWeek(ProductionOrder, TempGroupProdOrder, 110118D, 8);
        
        
        TempGroupProdOrder.RESET;
        TempGroupProdOrder.SETCURRENTKEY("Account No.", "Bal. Account No.", "External Document No.");
        */
        //HEI.12<<

        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*/ //HEI.33>>
                     //HEI.12>>
                     //>>interface filters
                     //filters on Production Header
        ProductionOrder.SETFILTER("Zone Code FND", FuturMasterInterfaceSetup2."ActualProd Zone Filter");
        ProductionOrder.SETFILTER("Location Code", FuturMasterInterfaceSetup2."ActualProd Location Filter");
        ProductionOrder.SETFILTER(Status, FuturMasterInterfaceSetup2."ActualProd Status Filter");
        //<<interface filters

        GroupActualProdOrderWeek(ProductionOrder, TempGroupProdOrder, TODAY, 8);
        //GroupActualProdOrderWeek(ProductionOrder, TempGroupProdOrder, 110118D, 8);


        TempGroupProdOrder.RESET;
        TempGroupProdOrder.SETCURRENTKEY("Account No.", "Bal. Account No.", "External Document No.");
        //HEI.12<<
        //process the orders
        if TempGroupProdOrder.FINDSET then begin

            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Actual Production Interf";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);
            repeat
                if TempGroupProdOrder."Remaining Amount" <> 0 then begin
                    CLEAR(InterfaceEntryLineOut);
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    EntryNo += 1;
                    InterfaceEntryLineOut."Entry No." := EntryNo;
                    InterfaceEntryLineOut."No." := DELCHR(TempGroupProdOrder."Account No.", '<', '0'); //material code
                    InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                    InterfaceEntryLineOut."Location Code" := TempGroupProdOrder."Bal. Account No.";  //location code
                    InterfaceEntryLineOut."Action Code" := TempGroupProdOrder."Document No.";   //YYYYWW
                    InterfaceEntryLineOut.Quantity := TempGroupProdOrder."Remaining Amount";  //quantity grouped
                    InterfaceEntryLineOut.INSERT;
                end;
            until TempGroupProdOrder.NEXT = 0;
        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Actual Production Interf";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Location Code" := '';
            InterfaceEntryLineOut."Action Code" := '';
            InterfaceEntryLineOut.INSERT;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END; //HEI.33>>

    end;

    local procedure GroupActualProdOrderWeek(var locProdOrder: Record "Production Order"; var locProdOrderWk: Record "Ledger Entry Matching Buffer" temporary; RefDate: Date; NoOfPeriods: Integer);
    var
        EntryNo: Integer;
        i: Integer;
        YearWeek: Text[6];
        Item: Record Item;
        locProdOrderLine: Record "Prod. Order Line";
        locILE: Record "Item Ledger Entry";
    begin
        //HEI.03
        locProdOrderWk.DELETEALL;
        CLEAR(EntryNo);

        //current week
        for i := 0 to NoOfPeriods do begin
            CLEAR(YearWeek);
            YearWeek := SetPostingDateFilter(locILE, PeriodType::Week, i, Direction::Down, RefDate);
            //locProdOrder.SETFILTER("Due Date", locILE.GETFILTER("Posting Date"));

            if locProdOrder.FINDSET then
                repeat
                    locILE.SETRANGE("Order Type", locILE."Order Type"::Production);
                    locILE.SETRANGE("Order No.", locProdOrder."No.");
                    locILE.SETRANGE("Entry Type", locILE."Entry Type"::Output);
                    if locILE.FINDSET then
                        repeat
                            if locILE.Quantity <> 0 then begin
                                locProdOrderWk.SETRANGE("Account No.", locILE."Item No.");
                                locProdOrderWk.SETRANGE("Bal. Account No.", locILE."Location Code");
                                locProdOrderWk.SETRANGE("Document No.", YearWeek);
                                if locProdOrderWk.FINDFIRST then begin
                                    //locProdOrderWk."Remaining Amount" += ConvertQtyToHL(locILE."Item No.", locILE.Quantity, '', locILE."Unit of Measure Code", locILE."Quantity in HL"); //BC Upgrade GUNREM01 -DIT Field
                                    locProdOrderWk."Remaining Amount" += ConvertQtyToHL(locILE."Item No.", locILE.Quantity, '', locILE."Unit of Measure Code", locILE."Unit Volume HL FND"); //BC UPGRADE PATHAA02

                                    locProdOrderWk.MODIFY;
                                end else begin
                                    locProdOrderWk.INIT;
                                    EntryNo += 1;
                                    locProdOrderWk."Entry No." := EntryNo;
                                    locProdOrderWk."Account Type" := locProdOrderWk."Account Type"::Customer;
                                    locProdOrderWk."Account No." := locILE."Item No.";
                                    locProdOrderWk."Bal. Account No." := locILE."Location Code";
                                    //locProdOrderWk."Remaining Amount" += ConvertQtyToHL(locILE."Item No.", locILE.Quantity, '', locILE."Unit of Measure Code", locILE."Quantity in HL"); //BC Upgrade GUNREM01 -DIT Field
                                    locProdOrderWk."Remaining Amount" += ConvertQtyToHL(locILE."Item No.", locILE.Quantity, '', locILE."Unit of Measure Code", locILE."Unit Volume HL FND"); //BC UPGRADE PATHAA02
                                    locProdOrderWk."Document No." := YearWeek;
                                    locProdOrderWk.INSERT;
                                end;
                            end;
                        until locILE.NEXT = 0;
                until locProdOrder.NEXT = 0;
        end;
    end;

    procedure CreatePurchMasterData(var PurchaseHeader: Record "Purchase Header"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
        PurchaseLine: Record "Purchase Line";
        TempInvtBuffer: Record "Inventory Buffer" temporary;
        SKU: Record "Stockkeeping Unit";
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        FuturMasterInterfaceSetup2.TESTFIELD("PurchMasterData Interf");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."PurchMasterData Interf");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        FuturMasterInterfaceSetup2.TESTFIELD("PurchMasterData DocType Filter");
        
        //>>interface filters
        //filters on Purchase Header
        IF FuturMasterInterfaceSetup2."PurchMasterData DocType Filter" <> '' THEN
          PurchaseHeader.SETFILTER("Document Type", FuturMasterInterfaceSetup2."PurchMasterData DocType Filter");
        PurchaseHeader.SETFILTER("SRM Contract Type", FuturMasterInterfaceSetup2.PurchMasterDataContrTypeFilter);
        
        PurchaseHeader.SETFILTER("Valid From", '<=%1', TODAY);
        PurchaseHeader.SETFILTER("Valid To", '>=%1', TODAY);
        //old version PurchaseHeader.SETFILTER("Location Code", FuturMasterInterfaceSetup2."PurchMasterDataLocCode Filter");
        IF FuturMasterInterfaceSetup2."PurchMasterDataPlantSp Fiilter" <> '' THEN
          SKU.SETFILTER("Plant-Specific Material Status", FuturMasterInterfaceSetup2."PurchMasterDataPlantSp Fiilter");
        //<<interface filters
        */
        //HEI.12<<

        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*/ //HEI.33>>
                     //HEI.12>>
        FuturMasterInterfaceSetup2.TESTFIELD("PurchMasterData DocType Filter");

        //>>interface filters
        //filters on Purchase Header
        if FuturMasterInterfaceSetup2."PurchMasterData DocType Filter" <> '' then
            PurchaseHeader.SETFILTER("Document Type", FuturMasterInterfaceSetup2."PurchMasterData DocType Filter");
        PurchaseHeader.SETFILTER("SRM Contract Type FND", FuturMasterInterfaceSetup2.PurchMasterDataContrTypeFilter);

        PurchaseHeader.SETFILTER("Valid From FND", '<=%1', TODAY);
        PurchaseHeader.SETFILTER("Valid To FND", '>=%1', TODAY);
        //old version PurchaseHeader.SETFILTER("Location Code", FuturMasterInterfaceSetup2."PurchMasterDataLocCode Filter");
        if FuturMasterInterfaceSetup2."PurchMasterDataPlantSp Fiilter" <> '' then
            SKU.SETFILTER("Plant Spec.Material Status FND", FuturMasterInterfaceSetup2."PurchMasterDataPlantSp Fiilter");
        //<<interface filters
        //HEI.12<<
        //process the orders
        if PurchaseHeader.FINDSET then begin

            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."PurchMasterData Interf";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);
            repeat
                PurchaseLine.RESET;
                PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                if PurchaseLine.FINDSET then
                    repeat
                        if PurchaseLine.Type = PurchaseLine.Type::Item then begin
                            Item.SETRANGE("No.", PurchaseLine."No.");
                            Item.SETRANGE(Blocked, false);
                            SKU.SETRANGE("Location Code", PurchaseLine."Location Code");
                            SKU.SETRANGE("Item No.", PurchaseLine."No.");
                            SKU.SETRANGE("Variant Code", PurchaseLine."Variant Code");
                            if FuturMasterInterfaceSetup2."PurchMasterDataCrossPlant Filt" <> '' then
                                Item.SETFILTER("Cross-Plant Mtrl. Status FND", FuturMasterInterfaceSetup2."PurchMasterDataCrossPlant Filt");
                            //old version-filter moved to SKU IF FuturMasterInterfaceSetup2."PurchMasterDataPlantSp Fiilter" <> '' THEN
                            //old version-filter moved to SKU Item.SETFILTER("Plant-Specific Material Status", FuturMasterInterfaceSetup2."PurchMasterDataPlantSp Fiilter");
                            if Item.FINDFIRST and SKU.FINDFIRST then begin
                                //use temporary table to prevent duplication of Item No + Location Code combination
                                TempInvtBuffer.RESET;
                                TempInvtBuffer.SETRANGE("Item No.", PurchaseLine."No.");
                                TempInvtBuffer.SETRANGE("Location Code", PurchaseLine."Location Code");
                                if not TempInvtBuffer.FINDFIRST then begin
                                    CLEAR(InterfaceEntryLineOut);
                                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                    EntryNo += 1;
                                    InterfaceEntryLineOut."Entry No." := EntryNo;
                                    InterfaceEntryLineOut."No." := DELCHR(PurchaseLine."No.", '<', '0'); //material code
                                    InterfaceEntryLineOut."Location Code" := PurchaseLine."Location Code";  //location code
                                    InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                                    InterfaceEntryLineOut."Purchasing Organisation" := GeneralInterfaceSetup."Company Code ID"; //Purchasing Organization
                                    InterfaceEntryLineOut."Global No." := GeneralInterfaceSetup."Company Code ID"; //Purchasing Group
                                    InterfaceEntryLineOut.INSERT;
                                    TempInvtBuffer.INIT;
                                    TempInvtBuffer."Item No." := PurchaseLine."No.";
                                    TempInvtBuffer."Location Code" := PurchaseLine."Location Code";
                                    TempInvtBuffer.INSERT;
                                end;
                            end;
                        end;
                    until PurchaseLine.NEXT = 0;
            until PurchaseHeader.NEXT = 0;
        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."PurchMasterData Interf";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Location Code" := '';

            InterfaceEntryLineOut.INSERT;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END; //HEI.33>>

    end;

    local procedure FormatDateYYYYWW(RefDate: Date): Text[6];
    begin
        //HEI.03
        if DATE2DWY(RefDate, 2) < 10 then
            exit(FORMAT(DATE2DWY(RefDate, 3)) + '0' + FORMAT(DATE2DWY(RefDate, 2)))
        else
            exit(FORMAT(DATE2DWY(RefDate, 3)) + FORMAT(DATE2DWY(RefDate, 2)));
    end;

    local procedure FormatDateYYYYMM(RefDate: Date): Text[6];
    begin
        //HEI.03
        if DATE2DMY(RefDate, 2) < 10 then
            exit(FORMAT(DATE2DMY(RefDate, 3)) + '0' + FORMAT(DATE2DMY(RefDate, 2)))
        else
            exit(FORMAT(DATE2DMY(RefDate, 3)) + FORMAT(DATE2DMY(RefDate, 2)));
    end;

    procedure CreateBOMMaster(var BOMHeader: Record "Production BOM Header"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
        BOMLines: Record "Production BOM Line";
        RoutingHeader: Record "Routing Header";
        RoutingLine: Record "Routing Line";
        CurrentKey: Text[100];
        SKU: Record "Stockkeeping Unit";
        ItemUOM: Record "Item Unit of Measure";
        BOMUOM: Decimal;
        HLUOM: Decimal;
        HLRate: Decimal;
        VersionMgt: Codeunit VersionManagement;
        VersionBOMHeader: Record "Production BOM Version";
        RoutingVersHeader: Record "Routing Version";
        ItemBOM: Record Item;
    begin
        //HEI.03
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        FuturMasterInterfaceSetup2.TESTFIELD("BOMMasterData Interf");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."BOMMasterData Interf");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //HEI.12>>
        /*
        FuturMasterInterfaceSetup2.TESTFIELD("BOM CMG Filter");
        
        //>>interface filters
        BOMHeader.SETFILTER("Linked SKU", '<>%1', '');
        IF FuturMasterInterfaceSetup2."BOM Status Flter" <> '' THEN
          BOMHeader.SETFILTER(Status, FuturMasterInterfaceSetup2."BOM Status Flter");
        IF FuturMasterInterfaceSetup2."BOM Vers St Filter" <> '' THEN
          VersionBOMHeader.SETFILTER(Status, FuturMasterInterfaceSetup2."BOM Vers St Filter");
        //HEI.04 comment line VersionBOMHeader.SETRANGE(Active, TRUE);
        //<<interface filters
        */
        //HEI.12<<

        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*/ //HEI.33>>
                     //HEI.12>>
        FuturMasterInterfaceSetup2.TESTFIELD("BOM CMG Filter");

        //>>interface filters
        BOMHeader.SETFILTER("Linked SKU FND", '<>%1', '');
        if FuturMasterInterfaceSetup2."BOM Status Flter" <> '' then
            BOMHeader.SETFILTER(Status, FuturMasterInterfaceSetup2."BOM Status Flter");
        if FuturMasterInterfaceSetup2."BOM Vers St Filter" <> '' then
            VersionBOMHeader.SETFILTER(Status, FuturMasterInterfaceSetup2."BOM Vers St Filter");
        //HEI.04 comment line VersionBOMHeader.SETRANGE(Active, TRUE);
        //<<interface filters

        //HEI.12<<
        //process the orders
        if BOMHeader.FINDSET then begin
            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);
            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."BOMMasterData Interf";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);
            CLEAR(CurrentKey);
            repeat
                //>>HEI.04
                ItemBOM.SETRANGE("Production BOM No.", BOMHeader."No.");
                if ItemBOM.FINDFIRST then begin
                    if ValidateComponentNo(ItemBOM."No.") then begin
                        //<<HEI.04

                        //add also the versions if active and certified
                        //start main BOM
                        /*HEI.04 comment all THEN block
                        BOMLines.RESET;
                        BOMLines.SETRANGE("Production BOM No.", BOMHeader."No.");
                        BOMLines.SETFILTER(Type, '=%1', BOMLines.Type::Item);
                        BOMLines.SETRANGE("Version Code", '');
                        IF BOMLines.FINDSET THEN BEGIN
                          REPEAT
                            IF BOMLines."Routing Link Code" <> '' THEN BEGIN
                              //principal routing version>>
                              IF RoutingHeader.GET(BOMLines."Routing Link Code") THEN BEGIN
                                RoutingLine.RESET;
                                RoutingLine.SETRANGE("Routing No.", RoutingHeader."No.");
                                RoutingLine.SETRANGE("Version Code", '');
                                IF RoutingLine.FINDSET THEN
                                  REPEAT
                                    IF CurrentKey <> BOMLines."No." + RoutingHeader."No." + RoutingLine."Work Center No." THEN BEGIN
                                      CLEAR(InterfaceEntryLineOut);
                                      InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                      EntryNo +=1;
                                      InterfaceEntryLineOut."Entry No." := EntryNo;
                                      //InterfaceEntryLineOut."No." := DELCHR(BOMHeader."No.", '<', '0');
                                      InterfaceEntryLineOut."No." := DELCHR(BOMHeader."Linked Item No.", '<', '0');
                                      InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                                      InterfaceEntryLineOut."Global No." := RoutingLine."Work Center No.";

                                      InterfaceEntryLineOut."Location Code" :=  BOMHeader."Linked SKU";
                                      InterfaceEntryLineOut."Cross Reference No." := DELCHR(BOMLines."No.", '<', '0');
                                      InterfaceEntryLineOut."CMG Code" := BOMLines."Routing Link Code"; // routing code from lines
                                      InterfaceEntryLineOut."Project Code" := BOMHeader."No."; //prod BOM header
                                      InterfaceEntryLineOut."Cost Center Code" := ''; // routing version
                                      InterfaceEntryLineOut."Order No." :=  ''; //version no
                                      //>>calculate the HLRate
                                      HLRate := 1;
                                      ItemUOM.RESET;
                                      ItemUOM.SETRANGE("Item No.", BOMHeader."Linked Item No.");
                                      ItemUOM.SETRANGE(Code, BOMHeader."Unit of Measure Code");
                                      IF ItemUOM.FINDFIRST THEN BEGIN
                                        BOMUOM := ItemUOM."Qty. per Unit of Measure";
                                        ItemUOM.SETRANGE(Code, FuturMasterInterfaceSetup2."BOM Ref UM");
                                         IF ItemUOM.FINDFIRST THEN
                                           IF ItemUOM."Qty. per Unit of Measure" <> 0 THEN
                                             HLRate := BOMUOM / ItemUOM."Qty. per Unit of Measure";
                                      END;
                                      //<<calculate HLRate
                                      InterfaceEntryLineOut."Unit Amount" := BOMLines.Quantity / HLRate;
                                      InterfaceEntryLineOut."Line Amount" := BOMLines."Scrap %";
                                      IF BOMHeader."Creation Date" <> 0D THEN
                                        InterfaceEntryLineOut."Zone Code" := FormatDateYYYYWW(BOMHeader."Creation Date")
                                      ELSE
                                        InterfaceEntryLineOut."Zone Code" := FormatDateYYYYWW(BOMHeader."Last Date Modified");
                                      InterfaceEntryLineOut."New Zone Code" := '';

                                      InterfaceEntryLineOut.INSERT;
                                      CurrentKey := BOMLines."No." + RoutingHeader."No." + RoutingLine."Work Center No."
                                    END;
                                  UNTIL RoutingLine.NEXT = 0;
                                END; //and IF RoutingHeader.GET then begin
                                //principal routing version<<

                                //**** version for routing
                                //other routing version>>
                                RoutingVersHeader.RESET;
                                RoutingVersHeader.SETRANGE("Routing No.", RoutingHeader."No.");
                                RoutingVersHeader.SETRANGE(Status, RoutingVersHeader.Status::Certified);
                                //RoutingVersHeader.SETRANGE(Active, TRUE);
                                IF RoutingVersHeader.FINDSET THEN BEGIN
                                  REPEAT
                                  RoutingLine.RESET;
                                  RoutingLine.SETRANGE("Routing No.", RoutingVersHeader."Routing No.");
                                  RoutingLine.SETRANGE("Version Code", RoutingVersHeader."Version Code");
                                  CurrentKey := '';
                                  IF RoutingLine.FINDSET THEN
                                    REPEAT
                                      IF CurrentKey <> BOMLines."No." + RoutingVersHeader."Routing No." + RoutingLine."Work Center No." THEN BEGIN
                                         CLEAR(InterfaceEntryLineOut);
                                         InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                         EntryNo +=1;
                                         InterfaceEntryLineOut."Entry No." := EntryNo;
                                         //InterfaceEntryLineOut."No." := DELCHR(BOMHeader."No.", '<', '0');
                                         InterfaceEntryLineOut."No." := DELCHR(BOMHeader."Linked Item No.", '<', '0');
                                         InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                                         InterfaceEntryLineOut."Global No." := RoutingLine."Work Center No.";

                                         InterfaceEntryLineOut."Location Code" :=  BOMHeader."Linked SKU";
                                         InterfaceEntryLineOut."Cross Reference No." := DELCHR(BOMLines."No.", '<', '0');
                                         InterfaceEntryLineOut."CMG Code" := RoutingVersHeader."Routing No."; // routing code from lines
                                         InterfaceEntryLineOut."Project Code" := BOMHeader."No."; // prod BOM header
                                         InterfaceEntryLineOut."Cost Center Code" := RoutingVersHeader."Version Code"; // routing version is blank on routing version card
                                         InterfaceEntryLineOut."Order No." := ''; //version no
                                         //>>calculate the HLRate
                                         HLRate := 1;
                                         ItemUOM.RESET;
                                         ItemUOM.SETRANGE("Item No.", BOMHeader."Linked Item No.");
                                         ItemUOM.SETRANGE(Code, BOMHeader."Unit of Measure Code");
                                         IF ItemUOM.FINDFIRST THEN BEGIN
                                           BOMUOM := ItemUOM."Qty. per Unit of Measure";
                                           ItemUOM.SETRANGE(Code, FuturMasterInterfaceSetup2."BOM Ref UM");
                                           IF ItemUOM.FINDFIRST THEN
                                             IF ItemUOM."Qty. per Unit of Measure" <> 0 THEN
                                               HLRate := BOMUOM / ItemUOM."Qty. per Unit of Measure";
                                           END;
                                         //<<calculate HLRate
                                         InterfaceEntryLineOut."Unit Amount" := BOMLines.Quantity / HLRate;
                                         InterfaceEntryLineOut."Line Amount" := BOMLines."Scrap %";
                                         IF BOMHeader."Creation Date" <> 0D THEN
                                          InterfaceEntryLineOut."Zone Code" := FormatDateYYYYWW(BOMHeader."Creation Date")
                                         ELSE
                                           InterfaceEntryLineOut."Zone Code" := FormatDateYYYYWW(BOMHeader."Last Date Modified");
                                         InterfaceEntryLineOut."New Zone Code" := '';
                                         InterfaceEntryLineOut.INSERT;
                                         CurrentKey := BOMLines."No." + RoutingVersHeader."Routing No." + RoutingLine."Work Center No."
                                       END;
                                    UNTIL RoutingLine.NEXT = 0;
                                  UNTIL RoutingVersHeader.NEXT = 0;
                                END; //and IF RoutingHeader.GET then begin
                              //**** version for routing
                              END;
                          UNTIL BOMLines.NEXT = 0;
                        //end the Production BOM Header main version
                        END;
                        HEI.04 <<*/
                        //end main BOM

                        //start version bom
                        //start second BOM

                        VersionBOMHeader.RESET;
                        VersionBOMHeader.SETRANGE("Production BOM No.", BOMHeader."No.");
                        //VersionBOMHeader.SETRANGE(Active, TRUE);
                        VersionBOMHeader.SETRANGE(Status, VersionBOMHeader.Status::Certified);
                        if VersionBOMHeader.FINDSET then begin
                            repeat
                                //******
                                BOMLines.RESET;
                                BOMLines.SETRANGE("Production BOM No.", VersionBOMHeader."Production BOM No.");
                                BOMLines.SETFILTER(Type, '=%1', BOMLines.Type::Item);
                                BOMLines.SETRANGE("Version Code", VersionBOMHeader."Version Code");
                                if BOMLines.FINDSET then begin
                                    repeat
                                        //>>HEI.04
                                        //IF ValidateComponentNo(BOMLines."No.") THEN BEGIN
                                        //<<HEI.04
                                        if BOMLines."Routing Link Code" <> '' then begin
                                            //principal routing version>>
                                            if RoutingHeader.GET(BOMLines."Routing Link Code") then begin
                                                RoutingLine.RESET;
                                                RoutingLine.SETRANGE("Routing No.", RoutingHeader."No.");
                                                RoutingLine.SETRANGE("Version Code", VersionBOMHeader."Version Code");
                                                if RoutingLine.FINDSET then
                                                    repeat
                                                        if CurrentKey <> BOMLines."No." + RoutingHeader."No." + RoutingLine."Work Center No." then begin
                                                            /*HEI.04>>
                                                            CLEAR(InterfaceEntryLineOut);
                                                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                                            EntryNo +=1;
                                                            InterfaceEntryLineOut."Entry No." := EntryNo;
                                                            //InterfaceEntryLineOut."No." := DELCHR(BOMHeader."No.", '<', '0');
                                                            InterfaceEntryLineOut."No." := DELCHR(BOMHeader."Linked Item No.", '<', '0');
                                                            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                                                            InterfaceEntryLineOut."Global No." := RoutingLine."Work Center No.";

                                                            InterfaceEntryLineOut."Location Code" :=  BOMHeader."Linked SKU";
                                                            InterfaceEntryLineOut."Cross Reference No." := DELCHR(BOMLines."No.", '<', '0');;
                                                            InterfaceEntryLineOut."CMG Code" := RoutingHeader."No."; // routing code from lines
                                                            InterfaceEntryLineOut."Project Code" := VersionBOMHeader."Production BOM No."; //prod BOM header
                                                            InterfaceEntryLineOut."Cost Center Code" := ''; // routing version
                                                            InterfaceEntryLineOut."Order No." := VersionBOMHeader."Version Code"; //version no
                                                            //>>calculate the HLRate
                                                            HLRate := 1;
                                                            ItemUOM.RESET;
                                                            ItemUOM.SETRANGE("Item No.", BOMHeader."Linked Item No.");
                                                            ItemUOM.SETRANGE(Code, VersionBOMHeader."Unit of Measure Code");
                                                            IF ItemUOM.FINDFIRST THEN BEGIN
                                                              BOMUOM := ItemUOM."Qty. per Unit of Measure";
                                                              ItemUOM.SETRANGE(Code, FuturMasterInterfaceSetup2."BOM Ref UM");
                                                              IF ItemUOM.FINDFIRST THEN
                                                                IF ItemUOM."Qty. per Unit of Measure" <> 0 THEN
                                                                  HLRate := BOMUOM / ItemUOM."Qty. per Unit of Measure";
                                                              END;
                                                            //<<calculate HLRate
                                                            InterfaceEntryLineOut."Unit Amount" := BOMLines.Quantity / HLRate;
                                                            InterfaceEntryLineOut."Line Amount" := BOMLines."Scrap %";
                                                            InterfaceEntryLineOut."Zone Code" := FormatDateYYYYWW(VersionBOMHeader."Last Date Modified");
                                                            InterfaceEntryLineOut."New Zone Code" := '';

                                                            InterfaceEntryLineOut.INSERT;;
                                                            HEI.04<<*/
                                                            CurrentKey := BOMLines."No." + RoutingHeader."No." + RoutingLine."Work Center No."
                                                        end;
                                                    until RoutingLine.NEXT = 0;
                                            end; //and IF RoutingHeader.GET then begin

                                            //other routing version>>
                                            RoutingVersHeader.SETRANGE("Routing No.", RoutingHeader."No.");
                                            RoutingVersHeader.SETRANGE(Status, RoutingVersHeader.Status::Certified);
                                            //RoutingVersHeader.SETRANGE(Active, TRUE);
                                            if RoutingVersHeader.FINDSET then begin
                                                repeat
                                                    RoutingLine.RESET;
                                                    RoutingLine.SETRANGE("Routing No.", RoutingVersHeader."Routing No.");
                                                    RoutingLine.SETRANGE("Version Code", RoutingVersHeader."Version Code");
                                                    CurrentKey := '';
                                                    if RoutingLine.FINDSET then
                                                        repeat
                                                            if CurrentKey <> BOMLines."No." + RoutingVersHeader."Routing No." + RoutingLine."Work Center No." then begin
                                                                CLEAR(InterfaceEntryLineOut);
                                                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                                                EntryNo += 1;
                                                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                                                //InterfaceEntryLineOut."No." := DELCHR(BOMHeader."No.", '<', '0');
                                                                InterfaceEntryLineOut."No." := DELCHR(BOMHeader."Linked Item No. FND", '<', '0');
                                                                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                                                                InterfaceEntryLineOut."Global No." := RoutingLine."Work Center No.";

                                                                InterfaceEntryLineOut."Location Code" := BOMHeader."Linked SKU FND";
                                                                InterfaceEntryLineOut."Cross Reference No." := DELCHR(BOMLines."No.", '<', '0');
                                                                ;
                                                                InterfaceEntryLineOut."CMG Code" := BOMLines."Routing Link Code"; // routing code from lines
                                                                InterfaceEntryLineOut."Project Code" := VersionBOMHeader."Production BOM No."; // prod BOM header
                                                                InterfaceEntryLineOut."Cost Center Code" := RoutingVersHeader."Version Code"; // routing version is blank on routing version card
                                                                InterfaceEntryLineOut."Order No." := VersionBOMHeader."Version Code"; //version no
                                                                                                                                      //>>calculate the HLRate
                                                                HLRate := 1;
                                                                ItemUOM.RESET;
                                                                ItemUOM.SETRANGE("Item No.", BOMHeader."Linked Item No. FND");
                                                                ItemUOM.SETRANGE(Code, VersionBOMHeader."Unit of Measure Code");
                                                                if ItemUOM.FINDFIRST then begin
                                                                    BOMUOM := ItemUOM."Qty. per Unit of Measure";
                                                                    ItemUOM.SETRANGE(Code, FuturMasterInterfaceSetup2."BOM Ref UM");
                                                                    if ItemUOM.FINDFIRST then
                                                                        if ItemUOM."Qty. per Unit of Measure" <> 0 then
                                                                            HLRate := BOMUOM / ItemUOM."Qty. per Unit of Measure";
                                                                end;
                                                                //<<calculate HLRate
                                                                InterfaceEntryLineOut."Unit Amount" := BOMLines.Quantity / HLRate;
                                                                InterfaceEntryLineOut."Line Amount" := BOMLines."Scrap %";
                                                                InterfaceEntryLineOut."Zone Code" := FormatDateYYYYWW(VersionBOMHeader."Last Date Modified");
                                                                InterfaceEntryLineOut."New Zone Code" := FormatDateYYYYWW(VersionBOMHeader."Last Date Modified");
                                                                InterfaceEntryLineOut.INSERT;
                                                                CurrentKey := BOMLines."No." + RoutingVersHeader."Routing No." + RoutingLine."Work Center No."
                                                            end;
                                                        until RoutingLine.NEXT = 0;
                                                until RoutingVersHeader.NEXT = 0;
                                            end; //and IF RoutingHeader.GET then begin

                                        end;
                                    //>>HEI.04
                                    //END;
                                    //<<HEI.04
                                    until BOMLines.NEXT = 0;
                                end;
                            until VersionBOMHeader.NEXT = 0;

                        end;  //IF VersionBOMHeader
                              //end second BOM
                              //>>HEI.04
                    end;
                end;
            //<<HEI.04
            until BOMHeader.NEXT = 0;
        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."BOMMasterData Interf";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."E-Mail 2" := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Ship-to Address" := '';
            InterfaceEntryLineOut."Ship-to Name" := '';
            InterfaceEntryLineOut.INSERT;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END; //HEI.33>>

    end;

    procedure ProcessPurchaseRequisition(InterfaceEntryHeader: Record "Interface Entry Header INT");
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
        ReqLineDel: Record "Requisition Line";
        ReqLine: Record "Requisition Line";
        ReqLine1: Record "Requisition Line";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        Item: Record Item;
        NewCode: Code[20];
    begin
        //HEI.03
        //Purchase Requisition

        GetGeneralInterfaceSetup;
        SourceCodeSetup.GET;
        GetFuturMasterInterfaceSetup2;

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then begin

            //start delete all lines before insert new purchase requisition lines
            ReqLineDel.SETRANGE("Worksheet Template Name", FuturMasterInterfaceSetup2."PurchOrds WksTempName");
            ReqLineDel.SETRANGE("Journal Batch Name", FuturMasterInterfaceSetup2.PurchOrdsJournBatchName);
            if ReqLineDel.FINDFIRST then
                ReqLineDel.DELETEALL;
            //end delete all lines before insert new purchase requisition lines

            repeat
                ReqLine1.SETRANGE("Worksheet Template Name", FuturMasterInterfaceSetup2."PurchOrds WksTempName");
                ReqLine1.SETRANGE("Journal Batch Name", FuturMasterInterfaceSetup2.PurchOrdsJournBatchName);
                if ReqLine1.FINDLAST then
                    LineNo := ReqLine1."Line No." + 10000
                else
                    LineNo := 10000;

                ReqLine.INIT;
                ReqLine.VALIDATE("Worksheet Template Name", FuturMasterInterfaceSetup2."PurchOrds WksTempName");
                ReqLine.VALIDATE("Journal Batch Name", FuturMasterInterfaceSetup2.PurchOrdsJournBatchName);
                ReqLine.VALIDATE("Line No.", LineNo);
                ReqLine.INSERT;
                ReqLine.VALIDATE(Type, ReqLine.Type::Item);


                //HEI.10 comment line Item.RESET;
                //HEI.10 comment line  Item.SETFILTER("No.", '*1', InterfaceEntryLine."No.");
                //HEI.10 comment line IF Item.FINDFIRST THEN
                //HEI.10 comment line  ReqLine.VALIDATE("No.", Item."No.");

                //HEI.10>>
                Item.RESET;
                if STRLEN(InterfaceEntryLine."No.") <= 19 then
                    NewCode := '*' + InterfaceEntryLine."No."
                else
                    NewCode := InterfaceEntryLine."No.";

                Item.SETFILTER("No.", '%1', NewCode);
                if Item.FINDFIRST then
                    ReqLine.VALIDATE("No.", Item."No.");
                //HEI.10<<

                ReqLine.VALIDATE("Action Message", ReqLine."Action Message"::New);
                ReqLine.VALIDATE("Accept Action Message", true);
                ReqLine.VALIDATE("Replenishment System", ReqLine."Replenishment System"::Purchase);

                ReqLine.VALIDATE("Location Code", InterfaceEntryLine."Location Code");


                ReqLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                ReqLine.VALIDATE("Due Date", InterfaceEntryLine."Posting Date");


                // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix >>
                // ReqLine.VALIDATE("Ending Date", LeadTimeMgt.PlannedEndingDate(ReqLine."No.", ReqLine."Location Code", ReqLine."Variant Code", ReqLine."Due Date", '', ReqLine."Ref. Order Type"));
                ReqLine.VALIDATE("Ending Date", LeadTimeMgt.GetPlannedEndingDate(ReqLine."No.", ReqLine."Location Code", ReqLine."Variant Code", ReqLine."Due Date", '', ReqLine."Ref. Order Type"));
                // BC FR Upgrade KAIRAR01 -Version 28.1.49322.0 Compatibility Fix <<



                ReqLine.MODIFY();
                //>>HEI.07
                HeinekenGlobal.UpdateBlanketOrderInReqWorksheet_Modify(ReqLine);
            //<<HEI.07
            until InterfaceEntryLine.NEXT() = 0;

        end;
    end;

    local procedure ConvertQtyToHL(ItemNo: Code[20]; var Qty: Decimal; DefUoM: Code[10]; TransUoM: Code[10]; QtyInHL: Decimal) HLQty: Decimal;
    var
        UnitOfMeasureManag: Codeunit "Unit of Measure Management";
        Item: Record Item;
        ItemUoM: Record "Item Unit of Measure";
        InventorySetup: Record "Inventory Setup";
        DrinkITFounsetup: Record FoundationSetup101FDW; //Add dependency extension Aptean.
    begin
        //HEI.03
        if QtyInHL <> 0 then
            HLQty := QtyInHL
        else begin
            Item.GET(ItemNo);
            if DefUoM = '' then begin
                InventorySetup.GET;
                // DefUoM := InventorySetup."Volume Unit of Measure Code"; //BC UPGRADE ATHUKS01
                DefUoM := DrinkITFounsetup."Unit Volume UOM"; //BC UPGRADER ATHUKS01
            end;
            //BC Upgrade GUNREM01 -dependency with DIT Field >> 
            if TransUoM <> DefUoM then
                HLQty := Qty * UnitOfMeasureManag.GetQtyPerUnitOfMeasure(Item, TransUoM) * Item."Unit Volume"

            else
                HLQty := Qty;
            //BC Upgrade GUNREM01 -DIT Field
            //BC Upgrade GUNREM01 -dependency with DIT Field <<
        end;

        exit(HLQty);
    end;

    procedure ProcessProductionOrders(InterfaceEntryHeader: Record "Interface Entry Header INT");
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
        ReqLineDel: Record "Requisition Line";
        ReqLine: Record "Requisition Line";
        ReqLine1: Record "Requisition Line";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        Item: Record Item;
        ProductionOrder: Record "Production Order";
        NewCode: Code[20];
    begin
        //HEI.53>>
        /*
        //HEI.03
        //Production Orders
        
        GetGeneralInterfaceSetup;
        SourceCodeSetup.GET;
        GetFuturMasterInterfaceSetup2;
        
        InterfaceEntryLine.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN BEGIN
        
          //start delete all lines before insert new purchase requisition lines
          ReqLineDel.SETRANGE("Worksheet Template Name", FuturMasterInterfaceSetup2."ProdOrds WksTempName");
          ReqLineDel.SETRANGE("Journal Batch Name", FuturMasterInterfaceSetup2.ProdOrdsJournBatchName);
          IF ReqLineDel.FINDFIRST THEN
            ReqLineDel.DELETEALL;
          //end delete all lines before insert new purchase requisition lines
        
          //HEI.09>>
          //start delete all planned production orders
          ProductionOrder.RESET;
          ProductionOrder.SETRANGE(Status, ProductionOrder.Status::Planned);
          IF ProductionOrder.FINDFIRST THEN
            ProductionOrder.DELETEALL;
          //end delete all palnned production orders
          //HEI.09<<
        
        
          REPEAT
            ReqLine1.SETRANGE("Worksheet Template Name", FuturMasterInterfaceSetup2."ProdOrds WksTempName");
            ReqLine1.SETRANGE("Journal Batch Name", FuturMasterInterfaceSetup2.ProdOrdsJournBatchName);
            IF ReqLine1.FINDLAST THEN
              LineNo := ReqLine1."Line No." + 10000
            ELSE
              LineNo := 10000;
        
            ReqLine.INIT;
            ReqLine.VALIDATE("Worksheet Template Name", FuturMasterInterfaceSetup2."ProdOrds WksTempName");
            ReqLine.VALIDATE("Journal Batch Name", FuturMasterInterfaceSetup2.ProdOrdsJournBatchName);
            ReqLine.VALIDATE("Line No.", LineNo);
            ReqLine.INSERT;
            ReqLine.VALIDATE(Type, ReqLine.Type::Item);
        
            //HEI.10>>
            //ReqLine.VALIDATE("No.", InterfaceEntryLine."No.");
        
            Item.RESET;
        
            IF STRLEN(InterfaceEntryLine."No.") <= 19 THEN
              NewCode := '*' + InterfaceEntryLine."No."
            ELSE
              NewCode := InterfaceEntryLine."No.";
            Item.SETFILTER("No.", '%1', NewCode);
            IF Item.FINDFIRST THEN
              ReqLine.VALIDATE("No.", Item."No.");
            //HEI.10<<
        
            ReqLine.VALIDATE("Action Message", ReqLine."Action Message"::New);
            ReqLine.VALIDATE("Accept Action Message", TRUE);
            ReqLine.VALIDATE("Replenishment System", ReqLine."Replenishment System"::"Prod. Order");
            ReqLine.VALIDATE("Location Code", InterfaceEntryLine."Location Code");
            ReqLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
            ReqLine.VALIDATE("Due Date", InterfaceEntryLine."Posting Date");
            //HEI.10 comment line ReqLine.VALIDATE("Starting Time", 0T);
            //HEI.10>>
            ReqLine.VALIDATE("Starting Date-Time", CREATEDATETIME(CALCDATE('<-CW>', TODAY) , 0T)); //monday of the current week
            ReqLine.VALIDATE("Ending Date-Time", CREATEDATETIME(CALCDATE('<+5D>', CALCDATE('<-CW>', TODAY)), 235959T)); //friday of the current week
        
            //HEI.10<<
        
        
            //ReqLine.VALIDATE("Ending Date", LeadTimeMgt.PlannedEndingDate(ReqLine."No.",ReqLine."Location Code",ReqLine."Variant Code",ReqLine."Due Date",'',ReqLine."Ref. Order Type"));
            IF InterfaceEntryLine."Cross Reference No." <> '' THEN
              ReqLine.VALIDATE("Production BOM No.", InterfaceEntryLine."Cross Reference No.");
            IF InterfaceEntryLine."Buy-from Vendor No." <> '' THEN
              ReqLine.VALIDATE("Production BOM Version Code", InterfaceEntryLine."Buy-from Vendor No.");
            IF InterfaceEntryLine."External Document No." <> '' THEN
              ReqLine.VALIDATE("Routing No.", InterfaceEntryLine."External Document No.");
            IF InterfaceEntryLine."Global No." <> '' THEN
              ReqLine.VALIDATE("Routing Version Code", InterfaceEntryLine."Global No.");
            IF InterfaceEntryLine."Unit of Measure Code" <> '' THEN
              ReqLine.VALIDATE("Unit of Measure Code", InterfaceEntryLine."Unit of Measure Code");
        
            ReqLine.MODIFY;
          UNTIL InterfaceEntryLine.NEXT = 0;
        
        END;
        */
        //HEI.53>>

    end;

    local procedure ValidateComponentNo(ItemNo: Code[20]): Boolean;
    var
        locItem: Record Item;
        locItemAttribValueMapp: Record "Item Attribute Value Mapping";
        locItemAttributeValue: Record "Item Attribute Value";
        FirstTest: Boolean;
    begin
        //>>HEI.04
        locItem.SETRANGE("No.", ItemNo);
        if FuturMasterInterfaceSetup2."BOM CMG Filter" <> '' then begin
            locItem.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."BOM CMG Filter");
            if locItem.FINDFIRST then
                exit(true);
        end;

        FirstTest := false;

        if FuturMasterInterfaceSetup2."BOM Item Categ Filter1" <> '' then begin
            locItem.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."BOM Item Categ Filter1");
            if locItem.FINDFIRST then begin
                locItemAttribValueMapp.RESET;
                locItemAttribValueMapp.SETRANGE("Table ID", 27);
                locItemAttribValueMapp.SETRANGE("No.", ItemNo);
                locItemAttribValueMapp.SETRANGE("Item Attribute ID", FuturMasterInterfaceSetup2."BOM Item Attr Filter1");
                if locItemAttribValueMapp.FINDFIRST then
                    FirstTest := true;
                locItemAttributeValue.RESET;
                locItemAttributeValue.SETRANGE("Attribute ID", FuturMasterInterfaceSetup2."BOM Item Attr Filter1");
                locItemAttributeValue.SETRANGE(ID, locItemAttribValueMapp."Item Attribute Value ID");
                locItemAttributeValue.SETFILTER(Value, FuturMasterInterfaceSetup2."BOM ItemAttrValFilter1");
                if locItemAttributeValue.FINDFIRST and FirstTest then
                    exit(true);
            end;

        end;

        FirstTest := false;

        if FuturMasterInterfaceSetup2."BOM Item Categ Filter2" <> '' then begin
            locItem.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."BOM Item Categ Filter2");
            if locItem.FINDFIRST then begin
                locItemAttribValueMapp.RESET;
                locItemAttribValueMapp.SETRANGE("Table ID", 27);
                locItemAttribValueMapp.SETRANGE("No.", ItemNo);
                locItemAttribValueMapp.SETRANGE("Item Attribute ID", FuturMasterInterfaceSetup2."BOM Item Attr Filter2");
                if locItemAttribValueMapp.FINDFIRST then
                    FirstTest := true;
                locItemAttributeValue.RESET;
                locItemAttributeValue.SETRANGE("Attribute ID", FuturMasterInterfaceSetup2."BOM Item Attr Filter2");
                locItemAttributeValue.SETRANGE(ID, locItemAttribValueMapp."Item Attribute Value ID");
                locItemAttributeValue.SETFILTER(Value, FuturMasterInterfaceSetup2."BOM ItemAttrValFilter2");
                if locItemAttributeValue.FINDFIRST and FirstTest then
                    exit(true);
            end;
        end;

        if FuturMasterInterfaceSetup2."BOM Item Categ Filter3" <> '' then begin
            locItem.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."BOM Item Categ Filter3");
            if locItem.FINDFIRST then begin
                locItemAttribValueMapp.RESET;
                locItemAttribValueMapp.SETRANGE("Table ID", 27);
                locItemAttribValueMapp.SETRANGE("No.", ItemNo);
                locItemAttribValueMapp.SETRANGE("Item Attribute ID", FuturMasterInterfaceSetup2."BOM Item Attr Filter3");
                if locItemAttribValueMapp.FINDFIRST then
                    FirstTest := true;
                locItemAttributeValue.RESET;
                locItemAttributeValue.SETRANGE("Attribute ID", FuturMasterInterfaceSetup2."BOM Item Attr Filter3");
                locItemAttributeValue.SETRANGE(ID, locItemAttribValueMapp."Item Attribute Value ID");
                locItemAttributeValue.SETFILTER(Value, FuturMasterInterfaceSetup2."BOM ItemAttrValFilter3");
                if locItemAttributeValue.FINDFIRST and FirstTest then
                    exit(true);
            end;

        end;
        if (FuturMasterInterfaceSetup2."BOM CMG Filter" <> '') or (FuturMasterInterfaceSetup2."BOM Item Categ Filter1" <> '') or
           (FuturMasterInterfaceSetup2."BOM Item Categ Filter2" <> '') or (FuturMasterInterfaceSetup2."BOM Item Categ Filter3" <> '') then
            exit(false)
        else
            exit(true);
        //<<HEI.04
    end;

    local procedure ValidateBOMComponentNo(ItemNo: Code[20]): Boolean;
    var
        LocItem: Record Item;
        FMInterfacesetup3: Record "FuturMaster Interf. Stp 3 INT";
    begin
        //>>HEI.46
        if FMInterfacesetup3.GET then;
        if (FMInterfacesetup3."Exclude BOM Cmp ItemCat Filtr1" <> '') or (FMInterfacesetup3."Exclude BOM Cmp ItemCat Filtr2" <> '') then begin
            if LocItem.GET(ItemNo) then begin
                if (LocItem."Item Category Code" = FMInterfacesetup3."Exclude BOM Cmp ItemCat Filtr1") or (LocItem."Item Category Code" = FMInterfacesetup3."Exclude BOM Cmp ItemCat Filtr2") then
                    exit(false)
                else
                    exit(true);
            end;
        end else
            exit(true);
        //HEI.46<<
    end;

    procedure CreateStockTOVirtualLoc(var TransferLine: Record "Transfer Line"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
    begin
        //HEI.26<<
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        FuturMasterInterfaceSetup2.TESTFIELD("Stock TransOrd Virtual  Interf");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Stock TransOrd Virtual  Interf");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;


        /*IF (NOT CalculateRunTime(TIME, InterfaceSetup)) AND Scheduled THEN
          EXIT
        ELSE BEGIN*/ //HEI.33>>

        FuturMasterInterfaceSetup2.TESTFIELD("StockTOVirtual Category Filter");

        //>>interface filters
        //filters on Transfer Header
        if FuturMasterInterfaceSetup2."StockTOVirtual Location Filter" <> '' then
            TransferLine.SETFILTER("Transfer-from Code", FuturMasterInterfaceSetup2."StockTOVirtual Location Filter");
        if FuturMasterInterfaceSetup2."StockTOVirtual Category Filter" <> '' then
            TransferLine.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."StockTOVirtual Category Filter");
        TransferLine.SETRANGE(Status, TransferLine.Status::Released);
        //  TransferLine.SETRANGE("Item Charge No.", ''); //BC Upgrade GUNREM01 -dependency with DIT field
        //<<interface filters

        GroupTransfLinesVirtualLoc(TransferLine, TempGroupTransfLines);

        TempGroupTransfLines.RESET;
        TempGroupTransfLines.SETCURRENTKEY("Account No.", "Bal. Account No.", "External Document No.");

        //process the orders
        if TempGroupTransfLines.FINDSET then begin

            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Stock TransOrd Virtual  Interf";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                EntryNo += 1;
                InterfaceEntryLineOut."Entry No." := EntryNo;
                InterfaceEntryLineOut."No." := DELCHR(TempGroupTransfLines."Account No.", '<', '0'); //material code
                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryLineOut."Location Code" := TempGroupTransfLines."Bal. Account No.";  //location code
                InterfaceEntryLineOut."Action Code" := TempGroupTransfLines."External Document No.";   //YYYYWW
                InterfaceEntryLineOut.Quantity := TempGroupTransfLines."Remaining Amount";  //quantity grouped
                InterfaceEntryLineOut.INSERT;
            until TempGroupTransfLines.NEXT = 0;
        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Stock TransOrd Virtual  Interf";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Location Code" := '';
            InterfaceEntryLineOut."Action Code" := '';
            InterfaceEntryLineOut.INSERT;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //END; //HEI.33>>
        //HEI.26>>

    end;

    local procedure GroupTransfLinesVirtualLoc(var locTransfLines: Record "Transfer Line"; var locGroupedTransfLines: Record "Ledger Entry Matching Buffer" temporary);
    var
        locProdOrderLine: Record "Prod. Order Line";
        DocumentWeek: Text[6];
        EntryNo: Integer;
        DocumentQtyHL: Decimal;
        lItem: Record Item;
        Qty: Decimal;
    begin
        //HEI.26<<
        EntryNo := 0;

        if locTransfLines.FINDSET then
            repeat
                //calculate the YYYYWW for the current document
                if DATE2DWY(locTransfLines."Receipt Date", 2) < 10 then
                    DocumentWeek := FORMAT(DATE2DWY(locTransfLines."Receipt Date", 3)) + '0' + FORMAT(DATE2DWY(locTransfLines."Receipt Date", 2))
                else
                    DocumentWeek := FORMAT(DATE2DWY(locTransfLines."Receipt Date", 3)) + FORMAT(DATE2DWY(locTransfLines."Receipt Date", 2));

                CLEAR(Qty);
                if lItem.GET(locTransfLines."Item No.") then;
                if lItem."Item Category Code" in ['01', '07', '08'] then begin
                    //finished and semifinished in HL 01, 07, 08
                    DocumentQtyHL := 0;
                    Qty := locTransfLines."Qty. in Transit" + locTransfLines.Quantity - locTransfLines."Quantity Shipped";
                    DocumentQtyHL := ConvertQtyToHectLit(locTransfLines."Item No.", Qty, '', locTransfLines."Unit of Measure Code");
                end else begin
                    //other Item Category in Base UOM
                    DocumentQtyHL := 0;
                    DocumentQtyHL := locTransfLines."Qty. in Transit (Base)" + locTransfLines."Quantity (Base)" - locTransfLines."Qty. Shipped (Base)";
                end;

                //group the quantities on Item No/Location code/YYYYWW
                if DocumentQtyHL <> 0 then begin
                    locGroupedTransfLines.RESET;
                    locGroupedTransfLines.SETRANGE("Account No.", locTransfLines."Item No.");
                    locGroupedTransfLines.SETRANGE("Bal. Account No.", locTransfLines."Transfer-to Code");
                    locGroupedTransfLines.SETRANGE("External Document No.", DocumentWeek);
                    if locGroupedTransfLines.FINDFIRST then begin
                        locGroupedTransfLines."Remaining Amount" += DocumentQtyHL;
                        locGroupedTransfLines.MODIFY;
                    end else begin
                        EntryNo += 1;
                        locGroupedTransfLines.INIT;
                        locGroupedTransfLines."Entry No." := EntryNo;
                        locGroupedTransfLines."Account No." := locTransfLines."Item No.";
                        locGroupedTransfLines."Bal. Account No." := locTransfLines."Transfer-to Code";
                        locGroupedTransfLines."External Document No." := DocumentWeek;
                        locGroupedTransfLines."Remaining Amount" := DocumentQtyHL;
                        locGroupedTransfLines.INSERT;
                    end;
                end;
            until locTransfLines.NEXT = 0;
        //HEI.26>>
    end;

    local procedure ConvertQtyToHectLit(ItemNo: Code[20]; var Qty: Decimal; DefUoM: Code[10]; TransUoM: Code[10]) HLQty: Decimal;
    var
        UnitOfMeasureManag: Codeunit "Unit of Measure Management";
        Item: Record Item;
        ItemUoM: Record "Item Unit of Measure";
        InventorySetup: Record "Inventory Setup";
        DITFoundationSetup: Record FoundationSetup101FDW; //BC UPGRADE PATHAA02
    begin
        //HEI.26<<
        Item.GET(ItemNo);
        if DefUoM = '' then begin
            //InventorySetup.GET;
            DITFoundationSetup.GET; //PATHAA02 
            //  DefUoM := InventorySetup."Volume Unit of Measure Code"; //BC Upgrade GUNREM01 -dependency with DIT Field 
            DefUoM := DITFoundationSetup."Unit Volume UOM"; //BC UPGRADE PATHAA02
        end;
        //BC Upgrade GUNREM01 -dependency with DIT Field >>
        // if TransUoM <> DefUoM then
        //     HLQty := Qty * UnitOfMeasureManag.GetQtyPerUnitOfMeasure(Item, TransUoM) * Item."Unit Volume HL"
        // else
        //     HLQty := Qty;
        // exit(HLQty);
        //BC Upgrade GUNREM01 -dependency with DIT Field <<

        //BC UPGRADE PATHAA02>>
        if TransUoM <> DefUoM then
            HLQty := Qty * UnitOfMeasureManag.GetQtyPerUnitOfMeasure(Item, TransUoM) * Item."Unit Volume"
        else
            HLQty := Qty;
        exit(HLQty);
        //BC UPGRADE PATHAA02<<

        //HEI.26<<
    end;

    local procedure ConvertQtyToHL_FM(ItemNo: Code[20]; Qty: Decimal; DefUoM: Code[10]; TransUoM: Code[10]; QtyInHL: Decimal; var InventorySetup: Record "Inventory Setup") HLQty: Decimal;
    var
        UnitOfMeasureManag: Codeunit "Unit of Measure Management";
        Item: Record Item;
        ItemUoM: Record "Item Unit of Measure";
        DITFoundationSetup: Record FoundationSetup101FDW; //BC UPGRADE PATHAA02
    begin
        //HEI.28>>
        if DefUoM = '' then begin
            //InventorySetup.GET;
            // DefUoM := InventorySetup."Volume Unit of Measure Code"; //BC Upgrade GUNREM01 -dependency with DIT Field 
            DITFoundationSetup.Get; //BC UPGRADE PATHAA02
            DefUoM := DITFoundationSetup."Unit Volume UOM"; //BC UPGRADE PATHAA02
        end;
        if TransUoM <> DefUoM then begin
            Item.GET(ItemNo);
            HLQty := Qty * UnitOfMeasureManag.GetQtyPerUnitOfMeasure(Item, TransUoM) * Item."Unit Volume"; //BC Upgrade KUMARR78 
            //  HLQty := Qty * UnitOfMeasureManag.GetQtyPerUnitOfMeasure(Item, TransUoM) * Item."Unit Volume HL"; //BC Upgrade GUNREM01 -dependency with DIT Field 
        end else begin
            HLQty := Qty;
        end;
        exit(HLQty);
        //HEI.28<<
    end;

    procedure CreateBOMVersionMaster(var BOMHeader: Record "Production Version Data FND"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
        BOMLines: Record "Production BOM Line";
        RoutingHeader: Record "Routing Header";
        RoutingLine: Record "Routing Line";
        CurrentKey: Text[100];
        SKU: Record "Stockkeeping Unit";
        ItemUOM: Record "Item Unit of Measure";
        BOMUOM: Decimal;
        HLUOM: Decimal;
        HLRate: Decimal;
        VersionMgt: Codeunit VersionManagement;
        VersionBOMHeader: Record "Production BOM Version";
        RoutingVersHeader: Record "Routing Version";
        ItemBOM: Record Item;
        SKUItemBOM: Record "Stockkeeping Unit";
        ProdBOMHdr: Record "Production BOM Header";
        BOMHeaderUoM: Code[10];
    begin
        //<<HEI.34
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        GetFuturMasterInterfaceSetup3;   //HEI.46
        //>>HEI.35 Feild changed from BOMMaster to new
        //FuturMasterInterfaceSetup2.TESTFIELD("BOMMasterData Interf");
        //InterfaceSetup.GET(FuturMasterInterfaceSetup2."BOMMasterData Interf");
        FuturMasterInterfaceSetup2.TESTFIELD(FuturMasterInterfaceSetup2."Prod. BOM Version Interface");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Prod. BOM Version Interface");
        //<<HEI.35
        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        //FuturMasterInterfaceSetup2.TESTFIELD("BOM CMG Filter"); HEI.35 commented not required

        if BOMHeader.FINDSET(false) then begin
            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);
            InterfaceEntryHeaderOut.INIT;
            //InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."BOMMasterData Interf";//HEI.35
            InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Prod. BOM Version Interface";//HEI.35
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            if Scheduled then
                InterfaceEntryHeaderOut.Description := Text001
            else
                InterfaceEntryHeaderOut.Description := Text002;

            InterfaceEntryHeaderOut.INSERT(true);
            CLEAR(CurrentKey);
            repeat
                SKUItemBOM.RESET;
                SKUItemBOM.SETRANGE("Production BOM No.", BOMHeader."BOM Header Code");
                SKUItemBOM.SETRANGE("Item No.", BOMHeader."Material Code");
                if SKUItemBOM.FINDFIRST then begin
                    if ValidateComponentNo(SKUItemBOM."Item No.") then begin
                        BOMLines.RESET;
                        BOMLines.SETRANGE("Production BOM No.", BOMHeader."BOM Header Code");
                        BOMLines.SETFILTER(Type, '=%1', BOMLines.Type::Item);
                        BOMLines.SETRANGE("Version Code", BOMHeader."BOM Ver. Hdr. Code");
                        if BOMLines.FINDSET(false) then begin
                            repeat
                                //HEI.46>>
                                if ValidateBOMComponentNo(BOMLines."No.") then begin
                                    //HEI.46<<
                                    RoutingLine.RESET;
                                    RoutingLine.SETRANGE("Routing No.", BOMHeader."Routing Header Code");
                                    RoutingLine.SETRANGE("Version Code", BOMHeader."Routing Ver. hdr. Code");
                                    CurrentKey := '';
                                    if RoutingLine.FINDSET(false) then
                                        repeat
                                            if CurrentKey <> BOMLines."No." + RoutingVersHeader."Routing No." + RoutingLine."Work Center No." then begin
                                                CLEAR(InterfaceEntryLineOut);
                                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                                EntryNo += 1;
                                                //InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."BOMMasterData Interf";//HEI.35
                                                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Prod. BOM Version Interface";//HEI.35
                                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                                InterfaceEntryLineOut."No." := DELCHR(BOMHeader."Material Code", '<', '0');
                                                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";

                                                //InterfaceEntryLineOut."Global No." := RoutingLine."Work Center No.";//HEI.62
                                                /*//HEI.62<<
                                                 IF Item.GET(BOMLines."No.") THEN BEGIN
                                                  IF (Item."Item Category Code" = '07') OR (Item."Item Category Code" ='08') THEN //semifinished to have Beer Resource
                                                   InterfaceEntryLineOut."Global No." := 'BEER_RESOURCE'
                                                  ELSE
                                                   InterfaceEntryLineOut."Global No." := RoutingLine."Work Center No.";
                                                 END;
                                                //HEI.62>>
                                                *///HEI.64
                                                  //HEI.64<<
                                                FuturMasterInterfaceSetup3.GET;
                                                if Item.GET(BOMHeader."Material Code") then begin
                                                    if ((Item."Item Category Code" = '07') or (Item."Item Category Code" = '08')) and (FuturMasterInterfaceSetup3."Semi Finished Goods WorkCenter" <> '') then //semifinished to have Beer Resource
                                                        InterfaceEntryLineOut."Global No." := FuturMasterInterfaceSetup3."Semi Finished Goods WorkCenter"
                                                    else
                                                        InterfaceEntryLineOut."Global No." := RoutingLine."Work Center No.";
                                                end;
                                                //HEI.64>>


                                                //InterfaceEntryLineOut."Location Code" :=  BOMHeader."Material Code"; //HEI.35 commented for changes
                                                InterfaceEntryLineOut."Location Code" := SKUItemBOM."Location Code";//HEI.35
                                                                                                                    //>>HEI.35 New feilds data
                                                InterfaceEntryLineOut.Description := BOMHeader."Routing Header Code" + '_' + BOMHeader."Routing Ver. hdr. Code";
                                                InterfaceEntryLineOut."Description 2" := BOMHeader."BOM Header Code" + '_' + BOMHeader."BOM Ver. Hdr. Code";
                                                //<<HEI.35
                                                InterfaceEntryLineOut."Cross Reference No." := DELCHR(BOMLines."No.", '<', '0');
                                                //InterfaceEntryLineOut."CMG Code" := BOMLines."Routing Link Code"; HEI.35 Changed to new
                                                //InterfaceEntryLineOut."CMG Code" := BOMHeader."Production Version";//HEI.35  //HEI.69
                                                InterfaceEntryLineOut."CMG Code" := BOMHeader."Routing Header Code";//HEI.69

                                                InterfaceEntryLineOut."Project Code" := BOMHeader."BOM Header Code";
                                                InterfaceEntryLineOut."Cost Center Code" := BOMHeader."Routing Ver. hdr. Code";
                                                InterfaceEntryLineOut."Order No." := BOMHeader."BOM Ver. Hdr. Code";

                                                //HEI.48<<
                                                /*HLRate := 1;
                                                ItemUOM.RESET;
                                                ItemUOM.SETRANGE("Item No.", BOMHeader."Material Code");
                                                ItemUOM.SETRANGE(Code, BOMLines."Unit of Measure Code");
                                                IF ItemUOM.FINDFIRST THEN BEGIN
                                                  BOMUOM := ItemUOM."Qty. per Unit of Measure";
                                                  ItemUOM.SETRANGE(Code, FuturMasterInterfaceSetup2."BOM Ref UM");
                                                  IF ItemUOM.FINDFIRST THEN
                                                    IF ItemUOM."Qty. per Unit of Measure" <> 0 THEN
                                                      HLRate := BOMUOM / ItemUOM."Qty. per Unit of Measure";
                                                  END;
                                                InterfaceEntryLineOut."Unit Amount" := BOMLines.Quantity / HLRate;*/
                                                //HEI.48>>

                                                //HEI.48>>
                                                CLEAR(BOMHeaderUoM);
                                                ProdBOMHdr.RESET;
                                                ProdBOMHdr.SETRANGE("No.", BOMHeader."BOM Header Code");
                                                if ProdBOMHdr.FINDFIRST then
                                                    BOMHeaderUoM := ProdBOMHdr."Unit of Measure Code";

                                                ItemUOM.RESET;
                                                ItemUOM.SETRANGE("Item No.", BOMHeader."Material Code");
                                                ItemUOM.SETRANGE(Code, BOMHeaderUoM); //BOM Header UoM
                                                if ItemUOM.FINDFIRST then begin
                                                    BOMUOM := ItemUOM."Qty. per Unit of Measure";
                                                    ItemUOM.SETRANGE(Code, FuturMasterInterfaceSetup2."BOM Ref UM"); //HL
                                                    if ItemUOM.FINDFIRST then
                                                        if BOMUOM <> 0 then
                                                            HLRate := (1 / BOMUOM) * ItemUOM."Qty. per Unit of Measure";
                                                end;
                                                InterfaceEntryLineOut."Unit Amount" := BOMLines."Quantity per" * HLRate;
                                                //HEI.48<<

                                                InterfaceEntryLineOut."Line Amount" := BOMLines."Scrap %";
                                                InterfaceEntryLineOut."Zone Code" := BOMHeader."Start Validity Date";
                                                InterfaceEntryLineOut."New Zone Code" := BOMHeader."End Validity Date";
                                                InterfaceEntryLineOut.INSERT;
                                                CurrentKey := BOMLines."No." + RoutingVersHeader."Routing No." + RoutingLine."Work Center No."
                                            end;
                                        until RoutingLine.NEXT = 0;
                                end; //HEI.46
                            until BOMLines.NEXT = 0;
                        end;
                    end;
                end;
            until BOMHeader.NEXT = 0;
        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                //InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."BOMMasterData Interf";//HEI.35
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Prod. BOM Version Interface";//HEI.35
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."E-Mail 2" := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Ship-to Address" := '';
            InterfaceEntryLineOut."Ship-to Name" := '';
            InterfaceEntryLineOut.INSERT;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
        //>>HEI.34

    end;

    local procedure GetSellActMonthReturnReceipts(var ItemLedgerEntry: Record "Item Ledger Entry"; var TempRetActualMth: Record "Ledger Entry Matching Buffer" temporary; Scheduled: Boolean): Boolean;
    begin
        //HEI.42
        if not FuturMasterInterfaceSetup3."Sell Act M. Incl. Return Rcpt." then
            exit(false);

        FuturMasterInterfaceSetup3.TESTFIELD("Sell Act M. Acc Group Filter 2");
        FuturMasterInterfaceSetup3.TESTFIELD("Sell Act M. Item Cat  Filter 2");

        if FuturMasterInterfaceSetup3."Sell Act M. Reference Date 2" = 0D then
            FuturMasterInterfaceSetup3."Sell Act M. Reference Date 2" := TODAY;

        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        ItemLedgerEntry.SETFILTER("Document Type", '%1', ItemLedgerEntry."Document Type"::"Sales Return Receipt");
        if FuturMasterInterfaceSetup3."Sell Act M. Location Filter 2" <> '' then
            ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup3."Sell Act M. Location Filter 2");
        if FuturMasterInterfaceSetup3."Sell Act M. Item Cat  Filter 2" <> '' then
            ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup3."Sell Act M. Item Cat  Filter 2");

        if ItemLedgerEntry.ISEMPTY then
            exit(false);

        if Scheduled then
            GroupSalesActualMonth(ItemLedgerEntry, TempRetActualMth, FuturMasterInterfaceSetup3."Sell Act M. Acc Group Filter 2", TODAY, 1)
        else
            GroupSalesActualMonth(ItemLedgerEntry, TempRetActualMth, FuturMasterInterfaceSetup3."Sell Act M. Acc Group Filter 2", FuturMasterInterfaceSetup3."Sell Act M. Reference Date 2", 1);
        TempRetActualMth.RESET;
        if not TempRetActualMth.FINDFIRST then
            exit(false);

        exit(true);
        //HEI.41>>
        ////HEI.38>>
        //IF PurchaseHeaderAdditional.GET(PurchaseHdr."Document Type"::Order,PurchaseHdr."No.") THEN BEGIN
        //  IF PurchaseHeaderAdditional."Import Identifier" THEN
        //    EXIT(TRUE)
        //  ELSE
        //    EXIT(FALSE);
        //END ELSE
        //  EXIT(FALSE);
        ////HEI.38<<
        //HEI.41<<
    end;

    local procedure GetSellActWeekReturnReceipts(var ItemLedgerEntry: Record "Item Ledger Entry"; var TempRetActualMth: Record "Ledger Entry Matching Buffer" temporary; Scheduled: Boolean): Boolean;
    begin
        //HEI.42
        if not FuturMasterInterfaceSetup3."Sell Act W. Incl. Return Rcpt." then
            exit(false);

        FuturMasterInterfaceSetup3.TESTFIELD("Sell Act W. Acc Group Filter 2");
        FuturMasterInterfaceSetup3.TESTFIELD("Sell Act W. Item Cat Filter 2");
        FuturMasterInterfaceSetup3.TESTFIELD("Sell Act W. Previous Weeks 2");

        if FuturMasterInterfaceSetup3."Sell Act W. Reference Date 2" = 0D then
            FuturMasterInterfaceSetup3."Sell Act W. Reference Date 2" := TODAY;

        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        ItemLedgerEntry.SETFILTER("Document Type", '%1', ItemLedgerEntry."Document Type"::"Sales Return Receipt");
        if FuturMasterInterfaceSetup3."Sell Act W. Location Filter 2" <> '' then
            ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup3."Sell Act W. Location Filter 2");
        if FuturMasterInterfaceSetup3."Sell Act W. Item Cat Filter 2" <> '' then
            ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup3."Sell Act W. Item Cat Filter 2");

        if ItemLedgerEntry.ISEMPTY then
            exit(false);

        if Scheduled then
            GroupSalesActualWeek(ItemLedgerEntry, TempRetActualMth, FuturMasterInterfaceSetup3."Sell Act W. Acc Group Filter 2", TODAY, FuturMasterInterfaceSetup3."Sell Act W. Previous Weeks 2")//HEI.51
        else
            GroupSalesActualWeek(ItemLedgerEntry, TempRetActualMth, FuturMasterInterfaceSetup3."Sell Act W. Acc Group Filter 2", FuturMasterInterfaceSetup3."Sell Act W. Reference Date 2", FuturMasterInterfaceSetup3."Sell Act W. Previous Weeks 2");
        TempRetActualMth.RESET;
        if not TempRetActualMth.FINDFIRST then
            exit(false);

        exit(true);
    end;

    local procedure GetSellActMonth3YRReturnReceipts(var ItemLedgerEntry: Record "Item Ledger Entry"; var TempRetActualMth: Record "Ledger Entry Matching Buffer" temporary; Scheduled: Boolean): Boolean;
    var
        Calendar: Record Date;
        NoOfPeriod: Integer;
    begin
        //HEI.42
        if not FuturMasterInterfaceSetup3."Sell Act M3YR Incl. Rtrn Rcpt" then
            exit(false);

        FuturMasterInterfaceSetup3.TESTFIELD("Sell Act M3YR Acc Gr Filter 2");
        FuturMasterInterfaceSetup3.TESTFIELD("Sell Act M3YR End Date 2");
        FuturMasterInterfaceSetup3.TESTFIELD("Sell Act M3YR Start Date 2");
        FuturMasterInterfaceSetup3.TESTFIELD("Sell Act M3YR Item Ca Filter 2");

        //calculate number of months.
        Calendar.RESET;
        Calendar.SETRANGE("Period Type", Calendar."Period Type"::Month);
        Calendar.SETRANGE("Period Start", FuturMasterInterfaceSetup3."Sell Act M3YR Start Date 2", FuturMasterInterfaceSetup3."Sell Act M3YR End Date 2");
        NoOfPeriod := Calendar.COUNT;

        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        ItemLedgerEntry.SETFILTER("Document Type", '%1', ItemLedgerEntry."Document Type"::"Sales Return Receipt");
        if FuturMasterInterfaceSetup3."Sell Act M3YR Loc Filter 2" <> '' then
            ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup3."Sell Act M3YR Loc Filter 2");
        if FuturMasterInterfaceSetup3."Sell Act M3YR Item Ca Filter 2" <> '' then
            ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup3."Sell Act M3YR Item Ca Filter 2");

        if ItemLedgerEntry.ISEMPTY then
            exit(false);

        GroupSalesActualMonth(ItemLedgerEntry, TempRetActualMth, FuturMasterInterfaceSetup3."Sell Act M3YR Acc Gr Filter 2", FuturMasterInterfaceSetup3."Sell Act M3YR End Date 2", NoOfPeriod - 1);
        TempRetActualMth.RESET;
        if not TempRetActualMth.FINDFIRST then
            exit(false);

        exit(true);
    end;

    local procedure GetSellActWeek3YRReturnReceipts(var ItemLedgerEntry: Record "Item Ledger Entry"; var TempRetActualMth: Record "Ledger Entry Matching Buffer" temporary; Scheduled: Boolean): Boolean;
    var
        Calendar: Record Date;
        NoOfPeriod: Integer;
    begin
        //HEI.42
        if not FuturMasterInterfaceSetup3."Sell Act W3YR Incl. Rtrn. Rcpt" then
            exit(false);

        FuturMasterInterfaceSetup3.TESTFIELD("Sell Act W3YR Acc Gr Filter 2");
        FuturMasterInterfaceSetup3.TESTFIELD("Sell Act W3YR End Date 2");
        FuturMasterInterfaceSetup3.TESTFIELD("Sell Act W3YR Start Date 2");
        FuturMasterInterfaceSetup3.TESTFIELD("Sell Act W3YR Item Ca Filter 2");

        //calculate number of weeks.
        Calendar.RESET;
        Calendar.SETRANGE("Period Type", Calendar."Period Type"::Week);
        Calendar.SETRANGE("Period Start", FuturMasterInterfaceSetup3."Sell Act W3YR Start Date 2", FuturMasterInterfaceSetup3."Sell Act W3YR End Date 2");
        NoOfPeriod := Calendar.COUNT;

        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        ItemLedgerEntry.SETFILTER("Document Type", '%1', ItemLedgerEntry."Document Type"::"Sales Return Receipt");
        if FuturMasterInterfaceSetup3."Sell Act W3YR Loc Filter 2" <> '' then
            ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup3."Sell Act W3YR Loc Filter 2");
        if FuturMasterInterfaceSetup3."Sell Act W3YR Item Ca Filter 2" <> '' then
            ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup3."Sell Act W3YR Item Ca Filter 2");

        if ItemLedgerEntry.ISEMPTY then
            exit(false);

        GroupSalesActualWeek(ItemLedgerEntry, TempRetActualMth, FuturMasterInterfaceSetup3."Sell Act W3YR Acc Gr Filter 2", FuturMasterInterfaceSetup3."Sell Act W3YR End Date 2", NoOfPeriod - 1);
        TempRetActualMth.RESET;
        if not TempRetActualMth.FINDFIRST then
            exit(false);

        exit(true);
    end;

    local procedure AddReturnReceiptQtyOnSellActShipments(var TempSalesActual: Record "Ledger Entry Matching Buffer" temporary; var TempRetActual: Record "Ledger Entry Matching Buffer" temporary; IncludeReturnReceipt: Boolean);
    begin
        //HEI.42
        if not IncludeReturnReceipt then
            exit;
        TempRetActual.RESET;
        TempRetActual.SETRANGE("Account No.", TempSalesActual."Account No.");
        TempRetActual.SETRANGE("Bal. Account No.", TempSalesActual."Bal. Account No.");
        TempRetActual.SETRANGE("Document No.", TempSalesActual."Document No.");
        if TempRetActual.FINDFIRST then begin
            TempSalesActual."Remaining Amount" := TempSalesActual."Remaining Amount" + TempRetActual."Remaining Amount";
            TempRetActual.DELETE;
        end;
    end;

    local procedure CreateSellInActIntEntryLineOut(var InterfaceEntryHeader: Record "Interface Entry Header INT"; var TempRetActual: Record "Ledger Entry Matching Buffer" temporary; LastEntryNo: Integer);
    var
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        EntryNo: Integer;
    begin
        //HEI.42
        TempRetActual.RESET;
        if not TempRetActual.FINDFIRST then
            exit;
        EntryNo := LastEntryNo;
        repeat
            if TempRetActual."Remaining Amount" <> 0 then begin
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeader."Entry No.";
                EntryNo += 1;
                InterfaceEntryLineOut."Entry No." := EntryNo;
                InterfaceEntryLineOut."No." := DELCHR(TempRetActual."Account No.", '<', '0');
                InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryLineOut."Buy-from Vendor No." := DELCHR(TempRetActual."Bal. Account No.", '<', '0');
                InterfaceEntryLineOut."Action Code" := TempRetActual."Document No.";
                InterfaceEntryLineOut.Quantity := -TempRetActual."Remaining Amount";
                InterfaceEntryLineOut.INSERT;
            end;
        until TempRetActual.NEXT = 0;
    end;

    local procedure ReturnReceiptExist(var TempRetActual: Record "Ledger Entry Matching Buffer" temporary): Boolean;
    begin
        //HEI.42
        TempRetActual.SETFILTER("Remaining Amount", '<>%1', 0);
        if not TempRetActual.FINDFIRST then
            exit(false);
        TempRetActual.RESET;
        exit(true);
    end;

    procedure CreateReturnActualsMonth(var ItemLedgerEntry: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
    begin
        //HEI.40
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        FuturMasterInterfaceSetup2.TESTFIELD("Return Act Month Interface");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Return Act Month Interface");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act Month Acc. Gr. Filter");
        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act Month Doc Type Filter");
        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act Month Item Cat Filter");
        if FuturMasterInterfaceSetup2."Ret. Act Month Reference Date" = 0D then
            FuturMasterInterfaceSetup2."Ret. Act Month Reference Date" := TODAY;

        //>>interface filters
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        if FuturMasterInterfaceSetup2."Ret. Act Month Doc Type Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup2."Ret. Act Month Doc Type Filter");
        if FuturMasterInterfaceSetup2."Ret. Act Month Location Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup2."Ret. Act Month Location Filter");
        if FuturMasterInterfaceSetup2."Ret. Act Month Item Cat Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."Ret. Act Month Item Cat Filter");
        //<<interface filters

        //process the orders
        if ItemLedgerEntry.FINDFIRST then begin
            if Scheduled then
                GroupSalesActualMonth(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup2."Ret. Act Month Acc. Gr. Filter", TODAY, 1)
            else
                GroupSalesActualMonth(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup2."Ret. Act Month Acc. Gr. Filter", FuturMasterInterfaceSetup2."Ret. Act Month Reference Date", 1);
            TempSalesActualMth.RESET;
            if TempSalesActualMth.FINDSET then begin


                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Return Act Month Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;

                InterfaceEntryHeaderOut.INSERT(true);
                repeat
                    if TempSalesActualMth."Remaining Amount" <> 0 then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        EntryNo += 1;
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut."No." := DELCHR(TempSalesActualMth."Account No.", '<', '0');
                        InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                        InterfaceEntryLineOut."Buy-from Vendor No." := DELCHR(TempSalesActualMth."Bal. Account No.", '<', '0');
                        InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                        InterfaceEntryLineOut.Quantity := TempSalesActualMth."Remaining Amount";
                        InterfaceEntryLineOut.INSERT;
                    end;
                until TempSalesActualMth.NEXT = 0;
            end;

        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Return Act Month Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."E-Mail 2" := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Ship-to Address" := '';
            InterfaceEntryLineOut."Ship-to Name" := '';
            InterfaceEntryLineOut.INSERT;
        end;

        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
    end;

    procedure CreateReturnActualsWeek(var ItemLedgerEntry: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
    begin
        //HEI.40
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        FuturMasterInterfaceSetup2.TESTFIELD("Return Act Week Interface");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Return Act Week Interface");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act Week Previous Weeks");

        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act Week Acc. Gr. Filter");
        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act Week Doc Type Filter");
        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act Week Item Cat. Filter");
        if not Scheduled then
            FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act Week Reference Date");

        if FuturMasterInterfaceSetup2."Ret. Act Week Reference Date" = 0D then
            FuturMasterInterfaceSetup2."Ret. Act Week Reference Date" := TODAY;

        //>>interface filters
        //ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        if FuturMasterInterfaceSetup2."Ret. Act Week Doc Type Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup2."Ret. Act Week Doc Type Filter");
        if FuturMasterInterfaceSetup2."Ret. Act Week Location Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup2."Ret. Act Week Location Filter");
        if FuturMasterInterfaceSetup2."Ret. Act Week Item Cat. Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."Ret. Act Week Item Cat. Filter");
        //<<interface filters

        //process the orders
        if ItemLedgerEntry.FINDFIRST then begin

            if Scheduled then
                GroupSalesActualWeek(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup2."Ret. Act Week Acc. Gr. Filter", TODAY, FuturMasterInterfaceSetup2."Ret. Act Week Previous Weeks")
            else
                GroupSalesActualWeek(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup2."Ret. Act Week Acc. Gr. Filter", FuturMasterInterfaceSetup2."Ret. Act Week Reference Date", FuturMasterInterfaceSetup2."Ret. Act Week Previous Weeks");//HEI.54

            TempSalesActualMth.RESET;
            if TempSalesActualMth.FINDSET then begin


                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Return Act Week Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;

                InterfaceEntryHeaderOut.INSERT(true);
                repeat
                    if TempSalesActualMth."Remaining Amount" <> 0 then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        EntryNo += 1;
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut."No." := DELCHR(TempSalesActualMth."Account No.", '<', '0');
                        InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                        InterfaceEntryLineOut."Buy-from Vendor No." := DELCHR(TempSalesActualMth."Bal. Account No.", '<', '0');
                        InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                        InterfaceEntryLineOut.Quantity := TempSalesActualMth."Remaining Amount";
                        InterfaceEntryLineOut.INSERT;
                    end;
                until TempSalesActualMth.NEXT = 0;
            end;
        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Return Act Week Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."E-Mail 2" := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Ship-to Address" := '';
            InterfaceEntryLineOut."Ship-to Name" := '';
            InterfaceEntryLineOut.INSERT;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
    end;

    procedure CreateReturnActualsMonth3YR(var ItemLedgerEntry: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
        Calendar: Record Date;
        NoOfPeriod: Integer;
    begin
        //HEI.40
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        FuturMasterInterfaceSetup2.TESTFIELD("Return Act Month 3YR Interface");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Return Act Month 3YR Interface");


        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act MTH3YR Acc. Gr Filter");
        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act MTH3YR Doc Typ Filter");
        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act MTH3YR End Date");
        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act MTH3YR Start Date");
        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act MTH3YR Item Ca Filter");


        //calculate number of months.
        Calendar.RESET;
        Calendar.SETRANGE("Period Type", Calendar."Period Type"::Month);
        Calendar.SETRANGE("Period Start", FuturMasterInterfaceSetup2."Ret. Act MTH3YR Start Date", FuturMasterInterfaceSetup2."Ret. Act MTH3YR End Date");
        NoOfPeriod := Calendar.COUNT;


        //>>interface filters
        //ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);
        if FuturMasterInterfaceSetup2."Ret. Act MTH3YR Doc Typ Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup2."Ret. Act MTH3YR Doc Typ Filter");
        if FuturMasterInterfaceSetup2."Ret. Act MTH3YR Loc. Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup2."Ret. Act MTH3YR Loc. Filter");
        if FuturMasterInterfaceSetup2."Ret. Act MTH3YR Item Ca Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."Ret. Act MTH3YR Item Ca Filter");
        //<<interface filters

        //process the orders
        if ItemLedgerEntry.FINDFIRST then begin
            GroupSalesActualMonth(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup2."Ret. Act MTH3YR Acc. Gr Filter", FuturMasterInterfaceSetup2."Ret. Act MTH3YR End Date", NoOfPeriod - 1);
            TempSalesActualMth.RESET;
            if TempSalesActualMth.FINDSET then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Return Act Month 3YR Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;

                InterfaceEntryHeaderOut.INSERT(true);
                repeat
                    if TempSalesActualMth."Remaining Amount" <> 0 then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        EntryNo += 1;
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut."No." := DELCHR(TempSalesActualMth."Account No.", '<', '0');
                        InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                        InterfaceEntryLineOut."Buy-from Vendor No." := DELCHR(TempSalesActualMth."Bal. Account No.", '<', '0');
                        InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                        InterfaceEntryLineOut.Quantity := TempSalesActualMth."Remaining Amount";
                        InterfaceEntryLineOut.INSERT;
                    end;
                until TempSalesActualMth.NEXT = 0;
            end;

        end;

        //for empty file
        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Return Act Month 3YR Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."E-Mail 2" := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Ship-to Address" := '';
            InterfaceEntryLineOut."Ship-to Name" := '';
            InterfaceEntryLineOut.INSERT;
        end;
        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
    end;

    procedure CreateReturnActualsWeek3YR(var ItemLedgerEntry: Record "Item Ledger Entry"; Scheduled: Boolean);
    var
        LastEntryNo: Integer;
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        Item: Record Item;
        Customer: Record Customer;
        Calendar: Record Date;
        NoOfPeriod: Integer;
    begin
        //HEI.40
        GetGeneralInterfaceSetup;
        GetFuturMasterInterfaceSetup2;
        FuturMasterInterfaceSetup2.TESTFIELD("Return Act Week 3YR Interface");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Return Act Week 3YR Interface");

        if not InterfaceSetup.Enabled then
            exit;

        if InterfaceSetup."Run Type" <> InterfaceSetup."Run Type"::Manual then
            exit;

        if Scheduled then begin
            InterfaceSetup.TESTFIELD("Starting Time");
            InterfaceSetup.TESTFIELD("Ending Time");
        end;

        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act WK3YR Acc. Gr. Filter");
        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act WK3YR Doc Type Filter");
        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act MTH3YR End Date");
        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act WK3YR Start Date");
        FuturMasterInterfaceSetup2.TESTFIELD("Ret. Act WK3YR Item Cat Filter");

        //calculate number of weeks
        Calendar.RESET;
        Calendar.SETRANGE("Period Type", Calendar."Period Type"::Week);
        Calendar.SETRANGE("Period Start", FuturMasterInterfaceSetup2."Ret. Act WK3YR Start Date", FuturMasterInterfaceSetup2."Ret. Act WK3YR End Date");
        NoOfPeriod := Calendar.COUNT;


        //>>interface filters
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Source Type", "Source No.", "Posting Date", "Document Type", "Document No.", "Unit of Measure Code");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Customer);

        if FuturMasterInterfaceSetup2."Ret. Act WK3YR Doc Type Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Document Type", FuturMasterInterfaceSetup2."Ret. Act WK3YR Doc Type Filter");
        if FuturMasterInterfaceSetup2."Ret. Act WK3YR Location Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Location Code", FuturMasterInterfaceSetup2."Ret. Act WK3YR Location Filter");
        if FuturMasterInterfaceSetup2."Ret. Act WK3YR Item Cat Filter" <> '' then
            ItemLedgerEntry.SETFILTER("Item Category Code", FuturMasterInterfaceSetup2."Ret. Act WK3YR Item Cat Filter");
        //<<interface filters

        //process the orders
        if ItemLedgerEntry.FINDFIRST then begin
            GroupSalesActualWeek(ItemLedgerEntry, TempSalesActualMth, FuturMasterInterfaceSetup2."Ret. Act WK3YR Acc. Gr. Filter", FuturMasterInterfaceSetup2."Ret. Act WK3YR End Date", NoOfPeriod - 1);

            TempSalesActualMth.RESET;
            if TempSalesActualMth.FINDSET then begin


                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Return Act Week 3YR Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;

                InterfaceEntryHeaderOut.INSERT(true);
                repeat
                    if TempSalesActualMth."Remaining Amount" <> 0 then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        EntryNo += 1;
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut."No." := DELCHR(TempSalesActualMth."Account No.", '<', '0');
                        InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                        InterfaceEntryLineOut."Buy-from Vendor No." := DELCHR(TempSalesActualMth."Bal. Account No.", '<', '0');
                        InterfaceEntryLineOut."Action Code" := TempSalesActualMth."Document No.";
                        InterfaceEntryLineOut.Quantity := TempSalesActualMth."Remaining Amount";
                        InterfaceEntryLineOut.INSERT;
                    end;
                until TempSalesActualMth.NEXT = 0;
            end;

        end;

        if EntryNo = 0 then begin
            if InterfaceEntryHeaderOut."Entry No." = 0 then begin
                InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
                CLEAR(InterfaceEntryHeaderOut);

                InterfaceEntryHeaderOut.INIT;
                InterfaceEntryHeaderOut."Interface Code" := FuturMasterInterfaceSetup2."Return Act Week 3YR Interface";
                InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

                InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
                InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                if Scheduled then
                    InterfaceEntryHeaderOut.Description := Text001
                else
                    InterfaceEntryHeaderOut.Description := Text002;
                InterfaceEntryHeaderOut.INSERT(true);
            end;

            CLEAR(InterfaceEntryLineOut);
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            EntryNo := EntryNo + 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut."E-Mail 2" := '';
            InterfaceEntryLineOut."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryLineOut."Ship-to Address" := '';
            InterfaceEntryLineOut."Ship-to Name" := '';
            InterfaceEntryLineOut.INSERT;
        end;

        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeaderOut."Entry No.");
    end;

    procedure CreateShipmentsKpi(var SalesShptLines: Record "Sales Shipment Line"; var TransfShptLines: Record "Transfer Shipment Line"; AsPerDate: Date; Scheduled: Boolean): Boolean;
    var
        FuturMasterInterfaceSetup2: Record "FuturMaster Interf Setup_2 INT";
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        TempInterfaceEntryLine: array[2] of Record "Interface Entry Line INT" temporary;
        DataExchColumnDef: Record "Data Exch. Column Def";
        StartDate: Date;
        EndDate: Date;
        NextHeaderEntryNo: Integer;
        NextLineEntryNo: Integer;
        KeySalesDocType: Code[10];
        KeyTransfDocType: Code[10];
        RecTransShipHeader: Record "Transfer Shipment Header";//BC UPGRADE KUMARR78 FM++

    begin
        //HEI.39>>
        GetGeneralInterfaceSetup;
        FuturMasterInterfaceSetup2.GET;
        FuturMasterInterfaceSetup2.TESTFIELD("Shipment KPI Interface");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Shipment KPI Interface");
        if not InterfaceSetup.Enabled then
            exit(false);
        InterfaceSetup.TESTFIELD(Direction, InterfaceSetup.Direction::Outbound);
        InterfaceSetup.TESTFIELD("Call Type", InterfaceSetup."Call Type"::Asynchronous);
        InterfaceSetup.TESTFIELD("Data Exch. Def Code");
        InterfaceSetup.TESTFIELD("Data Exch. Line Def Code");

        // IF Scheduled THEN BEGIN
        //  InterfaceSetup.TESTFIELD("Starting Time");
        //  InterfaceSetup.TESTFIELD("Ending Time");
        // END;

        KeySalesDocType := 'SO';
        //HEI.45>>
        //KeyTransfDocType := 'STO';
        KeyTransfDocType := 'ST';
        //HEI.45<<

        if AsPerDate = 0D then
            AsPerDate := TODAY;

        FuturMasterInterfaceSetup2.TESTFIELD("Shpt. Prev. Weeks");
        StartDate := CALCDATE(STRSUBSTNO('<-%1W>', FuturMasterInterfaceSetup2."Shpt. Prev. Weeks"), AsPerDate);
        EndDate := AsPerDate;
        SalesShptLines.SETRANGE("Posting Date", StartDate, EndDate);

        FuturMasterInterfaceSetup2.TESTFIELD("ShptTrsf. Prev. Weeks");
        StartDate := CALCDATE(STRSUBSTNO('<-%1W>', FuturMasterInterfaceSetup2."ShptTrsf. Prev. Weeks"), AsPerDate);
        EndDate := AsPerDate;
        // TransfShptLines.SETRANGE("Posting Date", StartDate, EndDate); //BC Upgrade GUNREM01 -DIT field
        if SalesShptLines.ISEMPTY() and TransfShptLines.ISEMPTY() then
            exit(false);

        DataExchColumnDef.SETRANGE("Data Exch. Def Code", InterfaceSetup."Data Exch. Def Code");
        DataExchColumnDef.SETRANGE(Name, 'YearWeek');
        if not DataExchColumnDef.FINDFIRST or (DataExchColumnDef."Data Format" = '') then
            DataExchColumnDef."Data Format" := '<Year4><Week,2>';

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        OutboundInterface.TESTFIELD("HeiLite Business System ID");

        CLEAR(InterfaceEntryHeader);
        NextHeaderEntryNo := 1;
        if InterfaceEntryHeader.FINDLAST then
            NextHeaderEntryNo := InterfaceEntryHeader."Entry No." + 1;
        InterfaceEntryHeader.INIT;
        InterfaceEntryHeader."Entry No." := NextHeaderEntryNo;
        InterfaceEntryHeader."Interface Code" := InterfaceSetup.Code;
        InterfaceEntryHeader.Direction := InterfaceEntryHeader.Direction::Outbound;
        InterfaceEntryHeader."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeader."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeader."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeader."Source System ID" := OutboundInterface."Logical System ID";
        InterfaceEntryHeader."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
        if Scheduled then
            InterfaceEntryHeader.Description := Text001
        else
            InterfaceEntryHeader.Description := Text002;
        InterfaceEntryHeader.INSERT(true);

        SalesShptLines.SETCURRENTKEY("Posting Date", "Document No.", Type, "No.", "Location Code");
        if SalesShptLines.FINDSET() then
            repeat
                SalesShptLines.TESTFIELD(Type, SalesShptLines.Type::Item);
                SalesShptLines.TESTFIELD("No.");
                TempInterfaceEntryLine[1].INIT;
                TempInterfaceEntryLine[1]."Header Entry No." := InterfaceEntryHeader."Entry No.";
                TempInterfaceEntryLine[1]."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                //HEI.43>>
                //TempInterfaceEntryLine[1]."Item No." := SalesShptLines."No.";
                TempInterfaceEntryLine[1]."Item No." := DELCHR(SalesShptLines."No.", '<', '0');
                //HEI.43<<
                TempInterfaceEntryLine[1]."Location Code" := SalesShptLines."Location Code";
                //TempInterfaceEntryLine[1]."Posting Date" := SalesShptLines."Posting Date"; //issue with "data format" in column def.
                TempInterfaceEntryLine[1]."Posting Date Text" := FORMAT(SalesShptLines."Posting Date", 0, DataExchColumnDef."Data Format");
                TempInterfaceEntryLine[1]."Order No." := SalesShptLines."Document No.";
                TempInterfaceEntryLine[1]."Document Type Text" := KeySalesDocType;
                //  TempInterfaceEntryLine[1].Quantity := SalesShptLines.Quantity * SalesShptLines."Unit Volume HL";//BC Upgrade GUNREM01-DIT Field
                TempInterfaceEntryLine[1].Quantity := SalesShptLines.Quantity * SalesShptLines."Volume 2 101FDW";//BC UPGRADE KUMARR78 ++

                TempInterfaceEntryLine[2].SETRANGE("Order No.", TempInterfaceEntryLine[1]."Order No.");
                TempInterfaceEntryLine[2].SETRANGE("Item No.", TempInterfaceEntryLine[1]."Item No.");
                TempInterfaceEntryLine[2].SETRANGE("Location Code", TempInterfaceEntryLine[1]."Location Code");
                TempInterfaceEntryLine[2].SETRANGE("Transfer-to Location Code", '');
                if TempInterfaceEntryLine[2].FINDFIRST then begin
                    TempInterfaceEntryLine[2].Quantity += TempInterfaceEntryLine[1].Quantity;
                    TempInterfaceEntryLine[2].MODIFY;
                end else begin
                    NextLineEntryNo += 1;
                    TempInterfaceEntryLine[2] := TempInterfaceEntryLine[1];
                    TempInterfaceEntryLine[2]."Entry No." := NextLineEntryNo;
                    TempInterfaceEntryLine[2].INSERT;
                end;
            until SalesShptLines.NEXT() = 0;

        //  TransfShptLines.SETCURRENTKEY("Posting Date", "Document No.", "Item No.", "Transfer-from Code", "Transfer-to Code"); //BC Upgrade GUNREM01 -Used DIT field for filter 
        if TransfShptLines.FINDSET() then
            repeat
                //BC UPGRADE KUMARR78 ++
                if RecTransShipHeader.Get(TransfShptLines."Document No.") then
                    if (RecTransShipHeader."Posting Date" >= StartDate) and
                       (RecTransShipHeader."Posting Date" <= EndDate) then begin

                        TransfShptLines.TESTFIELD("Item No.");
                        //  TransfShptLines.TESTFIELD("Item Charge No.", ''); //BC Upgrade GUNREM01-DIT Field
                        TempInterfaceEntryLine[1].INIT;
                        TempInterfaceEntryLine[1]."Header Entry No." := InterfaceEntryHeader."Entry No.";
                        TempInterfaceEntryLine[1]."Legal Entity" := GeneralInterfaceSetup."Company Code ID";
                        //HEI.43>>
                        //TempInterfaceEntryLine[1]."Item No." := TransfShptLines."Item No.";
                        TempInterfaceEntryLine[1]."Item No." := DELCHR(TransfShptLines."Item No.", '<', '0');
                        //HEI.43<<
                        TempInterfaceEntryLine[1]."Location Code" := TransfShptLines."Transfer-from Code";
                        TempInterfaceEntryLine[1]."Transfer-to Location Code" := TransfShptLines."Transfer-to Code";
                        //TempInterfaceEntryLine[1]."Posting Date" := TransfShptLines."Posting Date"; //issue with "data format" in column def.
                        // TempInterfaceEntryLine[1]."Posting Date Text" := FORMAT(TransfShptLines."Posting Date", 0, DataExchColumnDef."Data Format");//BC Upgrade GUNREM01-DIT Field
                        TempInterfaceEntryLine[1]."Posting Date Text" := FORMAT(RecTransShipHeader."Posting Date", 0, DataExchColumnDef."Data Format");//BC UPGRADE KUMARR78 FM++

                        TempInterfaceEntryLine[1]."Order No." := TransfShptLines."Document No.";
                        TempInterfaceEntryLine[1]."Document Type Text" := KeyTransfDocType;
                        //   TempInterfaceEntryLine[1].Quantity := TransfShptLines.Quantity * TransfShptLines."Unit Volume HL";//BC Upgrade GUNREM01-DIT Field
                        TempInterfaceEntryLine[1].Quantity := TransfShptLines.Quantity * TransfShptLines."Volume 2 101FDW";//BC UPGRADE KUMARR78 ++

                        TempInterfaceEntryLine[2].SETRANGE("Order No.", TempInterfaceEntryLine[1]."Order No.");
                        TempInterfaceEntryLine[2].SETRANGE("Item No.", TempInterfaceEntryLine[1]."Item No.");
                        TempInterfaceEntryLine[2].SETRANGE("Location Code", TempInterfaceEntryLine[1]."Location Code");
                        TempInterfaceEntryLine[2].SETRANGE("Transfer-to Location Code", TempInterfaceEntryLine[1]."Transfer-to Location Code");
                        if TempInterfaceEntryLine[2].FINDFIRST then begin
                            TempInterfaceEntryLine[2].Quantity += TempInterfaceEntryLine[1].Quantity;
                            TempInterfaceEntryLine[2].MODIFY;
                        end else begin
                            NextLineEntryNo += 1;
                            TempInterfaceEntryLine[2] := TempInterfaceEntryLine[1];
                            TempInterfaceEntryLine[2]."Entry No." := NextLineEntryNo;
                            TempInterfaceEntryLine[2].INSERT;
                        end;
                    end;//BC UPGRADE KUMARR78 ++
            until TransfShptLines.NEXT() = 0;

        TempInterfaceEntryLine[2].RESET;
        if TempInterfaceEntryLine[2].FINDSET() then
            repeat
                InterfaceEntryLine := TempInterfaceEntryLine[2];
                InterfaceEntryLine.INSERT;
            until TempInterfaceEntryLine[2].NEXT() = 0;

        if not Scheduled then
            ProcessManualOutboundEntries(InterfaceEntryHeader."Entry No.");
    end;

    procedure ProcessPlannedProductionOrders(IntEntryHead: Record "Interface Entry Header INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        FMPlannedProdOrdProcess: Codeunit "FM Planned Prod. Ord Process";
        ErrorLogProdPlanInterface: Record "Err Log Prod. Plan Interf. INT";
        Entryno: Integer;
        ReqLineDel: Record "Requisition Line";
        InterfaceSetup: Record "Interface Setup INT";
        FuturMasterInterfaceSetup2: Record "FuturMaster Interf Setup_2 INT";
    begin
        //HEI.53>>

        FuturMasterInterfaceSetup2.GET;
        FuturMasterInterfaceSetup2.TESTFIELD(FuturMasterInterfaceSetup2."Production Orders Interface");
        InterfaceSetup.GET(FuturMasterInterfaceSetup2."Production Orders Interface");

        if not InterfaceSetup.Enabled then
            exit;

        FuturMasterInterfaceSetup2.TESTFIELD("ProdOrds WksTempName");
        FuturMasterInterfaceSetup2.TESTFIELD(ProdOrdsJournBatchName);

        //HEI.57>>
        //start delete all lines before insert new purchase requisition lines
        ReqLineDel.SETRANGE("Worksheet Template Name", FuturMasterInterfaceSetup2."ProdOrds WksTempName");
        ReqLineDel.SETRANGE("Journal Batch Name", FuturMasterInterfaceSetup2.ProdOrdsJournBatchName);
        if ReqLineDel.FINDFIRST then
            ReqLineDel.DELETEALL;
        COMMIT; //HEI.58
        //end delete all lines before insert new purchase requisition lines
        //HEI.57<<

        ErrorLogProdPlanInterface.RESET;
        if ErrorLogProdPlanInterface.FINDLAST then
            Entryno := ErrorLogProdPlanInterface."Entry No." + 1
        else
            Entryno := 1;

        //To process the correct lines and insert the error log for the Error Lines
        InterfaceEntryLine.RESET;
        InterfaceEntryLine.SETRANGE("Header Entry No.", IntEntryHead."Entry No.");
        if InterfaceEntryLine.FINDSET(false) then
            repeat
                CLEARLASTERROR;
                if FMPlannedProdOrdProcess.RUN(InterfaceEntryLine) then;
                if GETLASTERRORTEXT <> '' then begin
                    InsertErrorLog(Entryno, IntEntryHead."Source No.", GETLASTERRORTEXT, IntEntryHead, InterfaceEntryLine);
                    Entryno += 1;
                end;
                COMMIT;
            until InterfaceEntryLine.NEXT = 0;

        //HEI.53<<
    end;

    local procedure InsertErrorLog(pEntryNo: Integer; pItemNo: Code[20]; pErrorMessage: Text; InterfaceEntryHeader: Record "Interface Entry Header INT"; InterfaceEntryLine: Record "Interface Entry Line INT");
    var
        ErrorLogProdPlanInterface: Record "Err Log Prod. Plan Interf. INT";
        Entryno: Integer;
    begin
        //HEI.53>>
        ErrorLogProdPlanInterface.INIT;
        ErrorLogProdPlanInterface."Entry No." := pEntryNo;
        ErrorLogProdPlanInterface."Interface Code" := InterfaceEntryHeader."Interface Code";
        ErrorLogProdPlanInterface.Direction := ErrorLogProdPlanInterface.Direction::Inbound;
        ErrorLogProdPlanInterface.Date := CURRENTDATETIME;
        ErrorLogProdPlanInterface."Error Message" := COPYSTR(pErrorMessage, 1, 250);
        //HEI.57>>
        ErrorLogProdPlanInterface."Error Source Referrence" := 'Header No.:' + FORMAT(InterfaceEntryHeader."Entry No.") + '; Line No: ' + FORMAT(InterfaceEntryLine."Entry No.") + '; Qty:' + FORMAT(InterfaceEntryLine.Quantity) + '; UoM:' + FORMAT(InterfaceEntryLine."Unit of Measure Code") + '; BOM No :' + FORMAT(InterfaceEntryLine."Cross Reference No.");
        //HEI.57<<
        ErrorLogProdPlanInterface.INSERT;
        //HEI.53<<
    end;

    local procedure CheckImportPO(PurchaseHdr: Record "Purchase Header"): Boolean;
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.38>>
        if PurchaseHeaderAdditional.GET(PurchaseHdr."Document Type"::Order, PurchaseHdr."No.") then begin
            if PurchaseHeaderAdditional."Import Identifier" then
                exit(true)
            else
                exit(false);
        end else
            exit(false);
        //HEI.38<<
    end;
}

